Return-Path: <netdev+bounces-111481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154AB931526
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C542E282610
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81918C33F;
	Mon, 15 Jul 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhDKyET8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4018C337
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048159; cv=none; b=fBZDopeBWzabv9RW6ywuEXBe2MDz2D8DcFLYNgY8U5eyihPksFq4mUWLfvsYV+12LxUmgrU0FykxS879i9dhopw2nF6/YwI0GqFoVzhmWqZDWJHqn+/0ZyNEUUVTcrkfAiJ768pmb7AJ2JZIHcNN0RYEf5XtXRD7nzMW96iyKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048159; c=relaxed/simple;
	bh=b4r1NWsOpCdiVwR0hE0foMSC3fRb9CcQDESRhIGNoI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKs6oDEyVmmzINjj2w0xtd41lfYV9kRd9HJ7dkvdm6DBbQ62RPtcTLVmsIB+Ulg7YDjdUyBL+msFhSboLtRbf6QrpT2cGdX0wyzP+vWNp4jPnXDoXAmrbig8+NDZ6w4T3gE60WmAwPNLwJxdpqd9RCpV9hS4alprLvz6yzE0IvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhDKyET8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD783C32782;
	Mon, 15 Jul 2024 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721048159;
	bh=b4r1NWsOpCdiVwR0hE0foMSC3fRb9CcQDESRhIGNoI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhDKyET8+rocu/5LxzhLQrB0GpnVl9oYJ5oMPsXRG4HA91Fs/2GZHGg8nB0tWeBFO
	 r/GZ/Et3yuFEqODj8wu9t+YQxKLT8HMN2bpemcoDEgTcVykA++jMyzbilBK+rZuhgy
	 gqEDSXe6cNcvHM1c+v1vtzlK2MHzRz/Jo9LE9aY+cuT1IIUEUGiqbGH2Aj1WQ3DpNi
	 rtY6OqyEaiSWh1ANVdZwf3RScd5Hwkwy5E4vhKOBJGt0YxREpCquN6EMXOFwULVpQt
	 38QyUdQLpPf1U1hrQNPxWVDxRtfascZoSmfeg9x4QHRU3TFUlsG/W5K/AJah2ZTRzG
	 qW1AZKD15eNrQ==
Date: Mon, 15 Jul 2024 13:55:55 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <20240715125555.GC45692@kernel.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-10-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-10-chopps@chopps.org>

On Sun, Jul 14, 2024 at 04:22:37PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add tunnel packet output functionality. This is code handles
> the ingress to the tunnel.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 535 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 532 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c

...

> +static int iptfs_get_cur_pmtu(struct xfrm_state *x,
> +			      struct xfrm_iptfs_data *xtfs, struct sk_buff *skb)
> +{
> +	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
> +	u32 payload_mtu = xtfs->payload_mtu;
> +	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);

Hi Christian,

Please consider arranging local variable declarations in Networking
code in reverse xmas tree order - longest line to shortest.
I think that in this case that would involve separating the
declaration and assignment of pmtu.

Edward Cree's tool can be helpful here:
https://github.com/ecree-solarflare/xmastree

> +
> +	if (payload_mtu && payload_mtu < pmtu)
> +		pmtu = payload_mtu;
> +
> +	return pmtu;
> +}

...

> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
> + * (i.e., aggregating or fragmenting as appropriate).
> + * This is set in dst->output for an SA.
> + */
> +static int iptfs_output_collect(struct net *net, struct sock *sk,
> +				struct sk_buff *skb)
> +{
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct xfrm_state *x = dst->xfrm;
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct sk_buff *segs, *nskb;
> +	u32 pmtu = 0;
> +	bool ok = true;
> +	bool was_gso;
> +
> +	/* We have hooked into dst_entry->output which means we have skipped the
> +	 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
> +	 * when our timer runs we will end up calling xfrm_output directly on
> +	 * the encapsulated traffic.
> +	 *
> +	 * For both cases this is the NF_INET_POST_ROUTING hook which allows
> +	 * changing the skb->dst entry which then may not be xfrm based anymore
> +	 * in which case a REROUTED flag is set. and dst_output is called.
> +	 *
> +	 * For IPv6 we are also skipping fragmentation handling for local
> +	 * sockets, which may or may not be good depending on our tunnel DF
> +	 * setting. Normally with fragmentation supported we want to skip this
> +	 * fragmentation.
> +	 */
> +
> +	BUG_ON(!xtfs);
> +
> +	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
> +
> +	/* Break apart GSO skbs. If the queue is nearing full then we want the
> +	 * accounting and queuing to be based on the individual packets not on the
> +	 * aggregate GSO buffer.
> +	 */
> +	was_gso = skb_is_gso(skb);
> +	if (!was_gso) {
> +		segs = skb;
> +	} else {
> +		segs = skb_gso_segment(skb, 0);
> +		if (IS_ERR_OR_NULL(segs)) {
> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> +			kfree_skb(skb);
> +			return PTR_ERR(segs);

This will return 0 is skb_gso_segment returns NULL,
which occurs if skb doesn't require segmentation.
Is that intentional?

If so, I wonder if it would be slightly nicer
to use PTR_ERR_OR_ZERO() instead of PTR_ERR().

Flagged by Smatch (suggestion is my own).
 (suggestion is my own)
> +		}
> +		consume_skb(skb);
> +		skb = NULL;
> +	}
> +
> +	/* We can be running on multiple cores and from the network softirq or
> +	 * from user context depending on where the packet is coming from.
> +	 */
> +	spin_lock_bh(&x->lock);
> +
> +	skb_list_walk_safe(segs, skb, nskb)
> +	{
> +		skb_mark_not_on_list(skb);
> +
> +		/* Once we drop due to no queue space we continue to drop the
> +		 * rest of the packets from that GRO.
> +		 */
> +		if (!ok) {
> +nospace:
> +			if (skb->dev)
> +				XFRM_INC_STATS(dev_net(skb->dev),
> +					       LINUX_MIB_XFRMOUTNOQSPACE);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			continue;
> +		}
> +
> +		/* Fragmenting handled in following commits. */
> +		if (iptfs_is_too_big(sk, skb, pmtu)) {
> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
> +			continue;
> +		}
> +
> +		/* Enqueue to send in tunnel */
> +		ok = iptfs_enqueue(xtfs, skb);
> +		if (!ok)
> +			goto nospace;
> +	}
> +
> +	/* Start a delay timer if we don't have one yet */
> +	if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
> +		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
> +			      IPTFS_HRTIMER_MODE);
> +		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
> +	}
> +
> +	spin_unlock_bh(&x->lock);
> +	return 0;
> +}

...

> +static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
> +{
> +	struct sk_buff_head list;
> +	struct xfrm_iptfs_data *xtfs;
> +	struct xfrm_state *x;
> +	time64_t settime;
> +
> +	xtfs = container_of(me, typeof(*xtfs), iptfs_timer);
> +	x = xtfs->x;
> +
> +	/* Process all the queued packets
> +	 *
> +	 * softirq execution order: timer > tasklet > hrtimer
> +	 *
> +	 * Network rx will have run before us giving one last chance to queue
> +	 * ingress packets for us to process and transmit.
> +	 */
> +
> +	spin_lock(&x->lock);
> +	__skb_queue_head_init(&list);
> +	skb_queue_splice_init(&xtfs->queue, &list);
> +	xtfs->queue_size = 0;
> +	settime = xtfs->iptfs_settime;

nit: settime is set but otherwise unused in this function.

     Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.

> +	spin_unlock(&x->lock);
> +
> +	/* After the above unlock, packets can begin queuing again, and the
> +	 * timer can be set again, from another CPU either in softirq or user
> +	 * context (not from this one since we are running at softirq level
> +	 * already).
> +	 */
> +
> +	iptfs_output_queued(x, &list);
> +
> +	return HRTIMER_NORESTART;
> +}

...

> @@ -98,10 +607,23 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>  {
>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
> -	int ret = 0;
> +	int ret;
> +	u64 q;
> +
> +	if (x->dir == XFRM_SA_DIR_OUT) {
> +		q = xtfs->init_delay_ns;
> +		(void)do_div(q, NSECS_IN_USEC);
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
> +		if (ret)
> +			return ret;
> +
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
> +				  xc->max_queue_size);
> +		if (ret)
> +			return ret;
>  
> -	if (x->dir == XFRM_SA_DIR_OUT)
>  		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
> +	}

ret will be used uninitialised here unless the if condition above is true.

Flagged by W=1 x86_64 allmodconfig build with clang-18, and Smatch.

>  
>  	return ret;
>  }
...

