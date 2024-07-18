Return-Path: <netdev+bounces-112004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8C9347BC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200A3B20F6C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D53FB87;
	Thu, 18 Jul 2024 05:55:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F523C6A6
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282156; cv=none; b=h196ZF3j+STQoKE59vedyV0NlN7cJvbHHhx+CssyUwuojbyZnhF+IdMZhDaLBllm75mklVnH/UIHnUhpCoufmEmur+QWF+w5KParVEV8g+e11E9228AB2PZxS8WJ7Aq7rlpaqOxNfm2oBnWtULFO1162oe8F3voiy3eAwPBgJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282156; c=relaxed/simple;
	bh=6BC+H2z4JAuwK2cY7mRTCWlx88Ffab3npa+HwFfk9yc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ue0Lc+F+NmeaYGT4dT/alolG/fNOtrihfv2qpeadbb2gDWdtyc5eQDhQ2+BFP/HzFhS9WtjdoXHBmH5JYy1jbHeFCj3JVbcR2M1uO0NUBhVfaNWUz5lob8cxLha9fG5WCkPFJGb06N8nSLZQfOke8kwXdPUSLEVWWfwEumKDeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0F7157D06B;
	Thu, 18 Jul 2024 05:55:47 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-10-chopps@chopps.org>
 <20240715125555.GC45692@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user
 packet (tunnel ingress) handling
Date: Wed, 17 Jul 2024 22:35:40 -0700
In-reply-to: <20240715125555.GC45692@kernel.org>
Message-ID: <m2cynbdz19.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman via Devel <devel@linux-ipsec.org> writes:

> On Sun, Jul 14, 2024 at 04:22:37PM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add tunnel packet output functionality. This is code handles
>> the ingress to the tunnel.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 535 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 532 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>
> ...
>
>> +static int iptfs_get_cur_pmtu(struct xfrm_state *x,
>> +			      struct xfrm_iptfs_data *xtfs, struct sk_buff *skb)
>> +{
>> +	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
>> +	u32 payload_mtu = xtfs->payload_mtu;
>> +	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
>
> Hi Christian,
>
> Please consider arranging local variable declarations in Networking
> code in reverse xmas tree order - longest line to shortest.
> I think that in this case that would involve separating the
> declaration and assignment of pmtu.
>
> Edward Cree's tool can be helpful here:
> https://github.com/ecree-solarflare/xmastree

This does not appear to be a style that is required by the net/xfrm code. I verified this by running the above tool on the other files in net/xfrm/*.c. In this case I'd prefer to not increase the number of lines in the function in order to satisfy the optional style guideline.

>> +
>> +	if (payload_mtu && payload_mtu < pmtu)
>> +		pmtu = payload_mtu;
>> +
>> +	return pmtu;
>> +}
>
> ...
>
>> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
>> + * (i.e., aggregating or fragmenting as appropriate).
>> + * This is set in dst->output for an SA.
>> + */
>> +static int iptfs_output_collect(struct net *net, struct sock *sk,
>> +				struct sk_buff *skb)
>> +{
>> +	struct dst_entry *dst = skb_dst(skb);
>> +	struct xfrm_state *x = dst->xfrm;
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct sk_buff *segs, *nskb;
>> +	u32 pmtu = 0;
>> +	bool ok = true;
>> +	bool was_gso;
>> +
>> +	/* We have hooked into dst_entry->output which means we have skipped the
>> +	 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
>> +	 * when our timer runs we will end up calling xfrm_output directly on
>> +	 * the encapsulated traffic.
>> +	 *
>> +	 * For both cases this is the NF_INET_POST_ROUTING hook which allows
>> +	 * changing the skb->dst entry which then may not be xfrm based anymore
>> +	 * in which case a REROUTED flag is set. and dst_output is called.
>> +	 *
>> +	 * For IPv6 we are also skipping fragmentation handling for local
>> +	 * sockets, which may or may not be good depending on our tunnel DF
>> +	 * setting. Normally with fragmentation supported we want to skip this
>> +	 * fragmentation.
>> +	 */
>> +
>> +	BUG_ON(!xtfs);
>> +
>> +	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
>> +
>> +	/* Break apart GSO skbs. If the queue is nearing full then we want the
>> +	 * accounting and queuing to be based on the individual packets not on the
>> +	 * aggregate GSO buffer.
>> +	 */
>> +	was_gso = skb_is_gso(skb);
>> +	if (!was_gso) {
>> +		segs = skb;
>> +	} else {
>> +		segs = skb_gso_segment(skb, 0);
>> +		if (IS_ERR_OR_NULL(segs)) {
>> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
>> +			kfree_skb(skb);
>> +			return PTR_ERR(segs);
>
> This will return 0 is skb_gso_segment returns NULL,
> which occurs if skb doesn't require segmentation.
> Is that intentional?
>
> If so, I wonder if it would be slightly nicer
> to use PTR_ERR_OR_ZERO() instead of PTR_ERR().
>
> Flagged by Smatch (suggestion is my own).
>  (suggestion is my own)

Thanks! Actually in the case of NULL I've changed the code to return -EINVAL as xfrm_output_gso() does.

>> +		}
>> +		consume_skb(skb);
>> +		skb = NULL;
>> +	}
>> +
>> +	/* We can be running on multiple cores and from the network softirq or
>> +	 * from user context depending on where the packet is coming from.
>> +	 */
>> +	spin_lock_bh(&x->lock);
>> +
>> +	skb_list_walk_safe(segs, skb, nskb)
>> +	{
>> +		skb_mark_not_on_list(skb);
>> +
>> +		/* Once we drop due to no queue space we continue to drop the
>> +		 * rest of the packets from that GRO.
>> +		 */
>> +		if (!ok) {
>> +nospace:
>> +			if (skb->dev)
>> +				XFRM_INC_STATS(dev_net(skb->dev),
>> +					       LINUX_MIB_XFRMOUTNOQSPACE);
>> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
>> +			continue;
>> +		}
>> +
>> +		/* Fragmenting handled in following commits. */
>> +		if (iptfs_is_too_big(sk, skb, pmtu)) {
>> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
>> +			continue;
>> +		}
>> +
>> +		/* Enqueue to send in tunnel */
>> +		ok = iptfs_enqueue(xtfs, skb);
>> +		if (!ok)
>> +			goto nospace;
>> +	}
>> +
>> +	/* Start a delay timer if we don't have one yet */
>> +	if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
>> +		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
>> +			      IPTFS_HRTIMER_MODE);
>> +		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
>> +	}
>> +
>> +	spin_unlock_bh(&x->lock);
>> +	return 0;
>> +}
>
> ...
>
>> +static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
>> +{
>> +	struct sk_buff_head list;
>> +	struct xfrm_iptfs_data *xtfs;
>> +	struct xfrm_state *x;
>> +	time64_t settime;
>> +
>> +	xtfs = container_of(me, typeof(*xtfs), iptfs_timer);
>> +	x = xtfs->x;
>> +
>> +	/* Process all the queued packets
>> +	 *
>> +	 * softirq execution order: timer > tasklet > hrtimer
>> +	 *
>> +	 * Network rx will have run before us giving one last chance to queue
>> +	 * ingress packets for us to process and transmit.
>> +	 */
>> +
>> +	spin_lock(&x->lock);
>> +	__skb_queue_head_init(&list);
>> +	skb_queue_splice_init(&xtfs->queue, &list);
>> +	xtfs->queue_size = 0;
>> +	settime = xtfs->iptfs_settime;
>
> nit: settime is set but otherwise unused in this function.
>
>      Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.
>

Hmm, this value is in fact used inside a trace point function call in this function.

>> +	spin_unlock(&x->lock);
>> +
>> +	/* After the above unlock, packets can begin queuing again, and the
>> +	 * timer can be set again, from another CPU either in softirq or user
>> +	 * context (not from this one since we are running at softirq level
>> +	 * already).
>> +	 */
>> +
>> +	iptfs_output_queued(x, &list);
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>
> ...
>
>> @@ -98,10 +607,23 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>>  {
>>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>> -	int ret = 0;
>> +	int ret;
>> +	u64 q;
>> +
>> +	if (x->dir == XFRM_SA_DIR_OUT) {
>> +		q = xtfs->init_delay_ns;
>> +		(void)do_div(q, NSECS_IN_USEC);
>> +		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
>> +				  xc->max_queue_size);
>> +		if (ret)
>> +			return ret;
>>
>> -	if (x->dir == XFRM_SA_DIR_OUT)
>>  		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>> +	}
>
> ret will be used uninitialised here unless the if condition above is true.
>
> Flagged by W=1 x86_64 allmodconfig build with clang-18, and Smatch.

Sigh, this is an artifact of splitting up the new file into multiple functionality commits. The final resulting code does not leave the value uninitialized. In any case I will fix it in this middle commit too.

Thanks!
Chris.

>
>>
>>  	return ret;
>>  }
> ...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaYrmISHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAls2MP/ii8QGkfwoQPy3lRSG6+ENt4rDsVrU0U
4bU8f4rlOlAXYC3HqPJHH4DrRrzjslzWDfqsFqsdtelGEl1rsS43D2QqfPAmrV7X
8jB9cFdwH+UpW+7eWE0e4GUx5yNCz2islpd/5ZrpuKRvQTCPXUnB0xWdnnNYcaVi
aawf3FEiFVeHFI29Q5JHe4f1/lNy2bWwACb8U4rVqUf22RjZ71NQsECyohN2ujdU
18HkFC0NhkTLiDYUIMmpKHcoyZWVfCzWAfjWLtOmJYXye/xVmqn3mEzSyzpXx7Us
uQYfRU4n+XVFRX593xFitvckYJde8/IF88kQe8UJZQ1bNEh0zkjORms5R3gzg38E
1UD9UVPLjxKRHwZdH5WLTAreRiRbyoO9NZ226TAfP/DVS7takX2j1DVhUOPIL1ZG
bXbr2P2/HgNTyon91kAUW39p6j7YpG4ynzP249L1HjlLv5tQhxJ9Hxv4YxdPPMFw
OjzNDo04PGuOi6oy2eOPeevW+RN/ZqRW9iykvwgpKtged/WT2c774dbSNznoxdOW
iCNIzYve+Ky1QFQ4ifSDnPK8qXEERkzJzoAQ3Q5vB2YjpgJmFp7dUTIHUZbhUhjg
d4QFp2WD+Ob5syIizpji+rKdW/9qKBXr9B5INXuQbsGTVVLTPLK6/80EdGgjlE7v
QNDSOH3TVxst
=E895
-----END PGP SIGNATURE-----
--=-=-=--

