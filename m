Return-Path: <netdev+bounces-115617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0009473EC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D8FB20A5B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF018225A2;
	Mon,  5 Aug 2024 03:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8063A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828822; cv=none; b=AOZuMjlWYfIa+7y5pJwX0WJTehftG37iP2VaR/7Daq1ceXey7czGcy6DrVt9WSAcnZ10NtxulpU1kKcpCzO++KPkI4lZxbvvSECHdl3rqstTmSzTt2vGXdx8AOwQmELi1ypp4TNRydliZggiexXI5G4pypceqQqeK0SEAiesFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828822; c=relaxed/simple;
	bh=t243z4R2sv/YjPnZMCM9hNNl5pJCjR7ZIxv9mrhO7Hs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Y0bayEiYIJKfPXA9x7qY2xX42rLI+qHtBil1uv5hWHs0Q+RNerRxq4QzdvMg1AMAadFEv73X7mOhgao2V0EOfhVTPSfD/JX7Qk7UB4RreQHX1TA8Dwaz7ToIG7ONR+0qkh3GEruxAwhEBql+snotH6C3U2W5jUnuZsOhFDnV5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id D2FD97D06C;
	Mon,  5 Aug 2024 03:33:39 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Sun, 04 Aug 2024 22:33:05 -0400
In-reply-to: <Zq__9Z4ckXNdR-Ec@hog>
Message-ID: <m2a5hr7iek.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Sabrina Dubroca <sd@queasysnail.net> writes:

> Please CC the reviewers from previous versions of the patchset. It's
> really hard to keep track of discussions and reposts otherwise.

Wasn't aware of this requirement, will try and add all the reviewers in the future.

> 2024-08-04, 16:33:39 -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add support for tunneling user (inner) packets that are larger than the
>> tunnel's path MTU (outer) using IP-TFS fragmentation.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 407 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 381 insertions(+), 26 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> index 20c19894720e..38735e2d64c3 100644
>> --- a/net/xfrm/xfrm_iptfs.c
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -46,12 +46,23 @@
>>   */
>>  #define IPTFS_DEFAULT_MAX_QUEUE_SIZE	(1024 * 10240)
>>
>> +/* 1) skb->head should be cache aligned.
>> + * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline to
>> + * start -16 from data.
>> + * 3) when resv is for L3+L2 headers IOW skb->data points at the IPTFS payload
>> + * we want data to be cache line aligned so all the pushed headers will be in
>> + * another cacheline.
>> + */
>> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>> +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)
>
> How did you pick those values?

That's what the comment is talking to. When reserving space for L2 headers we pick 64 + 16 (a 2^(<=6) cacheline + 16 bytes so the the cacheline should start -16 from where skb->data will point at. For L3 we reserve double the power of 2 space we reserved for L2 only.

We have to reserve some amount of space for pushed headers, so the above made sense to me for good performance/cache locality.

>> +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 len,
>> +				       bool l3resv)
>> +{
>> +	struct sk_buff *skb;
>> +	u32 resv;
>> +
>> +	if (!l3resv) {
>> +		resv = XFRM_IPTFS_MIN_L2HEADROOM;
>> +	} else {
>> +		resv = skb_headroom(tpl);
>> +		if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
>> +			resv = XFRM_IPTFS_MIN_L3HEADROOM;
>> +	}
>> +
>> +	skb = alloc_skb(len + resv, GFP_ATOMIC);
>> +	if (!skb) {
>> +		XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR);
>
> Hmpf, so we've gone from incrementing the wrong counter to
> incrementing a new counter that doesn't have a precise meaning.

The new "No SKB" counter is supposed to mean "couldn't get an SKB", given plenty of other errors are logged under "OutErr" or "InErr" i'm not sure what level of precision you're looking for here. :)

>> +		return NULL;
>> +	}
>> +
>> +	skb_reserve(skb, resv);
>> +
>> +	/* We do not want any of the tpl->headers copied over, so we do
>> +	 * not use `skb_copy_header()`.
>> +	 */
>
> This is a bit of a bad sign for the implementation. It also worries
> me, as this may not be updated when changes are made to
> __copy_skb_header().
> (c/p'd from v1 review since this was still not answered)

I don't agree that this is a bad design at all, I'm curious what you think a good design to be.

I did specifically state why we are not re-using skb_copy_header(). The functionality is different. We are not trying to make a copy of an skb we are using an skb as a template for new skbs.

>> +/**
>> + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
>> + * @st: source skb_seq_state
>> + * @offset: offset in source
>> + * @to: destination buffer
>> + * @len: number of bytes to copy
>> + *
>> + * Copy @len bytes from @offset bytes into the source @st to the destination
>> + * buffer @to. `offset` should increase (or be unchanged) with each subsequent
>> + * call to this function. If offset needs to decrease from the previous use `st`
>> + * should be reset first.
>> + *
>> + * Return: 0 on success or a negative error code on failure
>> + */
>> +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void *to,
>> +			     int len)
>
> Probably belongs in net/core/skbuff.c, although I'm really not
> convinced copying data around is the right way to implement the type
> of packet splitting IPTFS does (which sounds a bit like a kind of
> GSO). And there are helpers in net/core/skbuff.c (such as
> pskb_carve/pskb_extract) that seem to do similar things to what you
> need here, without as much data copying.

I don't have an issue with moving more general skb functionality into skbuff.c; however, I do not want to gate IP-TFS on this change to the general net infra, it is appropriate for a patchset of it's own.

Re copying: Let's be clear here, we are not always copying data, there are sharing code paths as well; however, there are times when it is the best (and even fastest) way to accomplish things (e.g., b/c the packet is small or the data is arranged in skbs in a way to make sharing ridiculously complex and thus slow).

This is in fact a very elegant and efficient sequential walk solution to a complex problem.

>> +static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data *xtfs,
>> +			   u32 mtu)
>> +{
>> +	struct sk_buff *skb = *skbp;
>> +	int err;
>> +
>> +	/* Classic ESP skips the don't fragment ICMP error if DF is clear on
>> +	 * the inner packet or ignore_df is set. Otherwise it will send an ICMP
>> +	 * or local error if the inner packet won't fit it's MTU.
>> +	 *
>> +	 * With IPTFS we do not care about the inner packet DF bit. If the
>> +	 * tunnel is configured to "don't fragment" we error back if things
>> +	 * don't fit in our max packet size. Otherwise we iptfs-fragment as
>> +	 * normal.
>> +	 */
>> +
>> +	/* The opportunity for HW offload has ended */
>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> +		err = skb_checksum_help(skb);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	/* We've split these up before queuing */
>> +	BUG_ON(skb_is_gso(skb));
>
> As I've said previously, I don't think that's a valid reason to
> crash. BUG_ON should be used very rarely:
>
> https://elixir.bootlin.com/linux/v6.10/source/Documentation/process/coding-style.rst#L1230
>
> Dropping a bogus packet is an easy way to recover from this situation,
> so we should not crash here (and probably in all of IPTFS).

This is basically following a style of coding that aims to simplify overall code by eliminating multiple checks for the same condition over and over in code. It does this by arranging for a single variant at the beginning of an operation and then counting on that from then on in the code. Asserts are the way to document this, if no assert then nothing b/c using a conditional is exactly against the design principle.

An existing example of this in the kernel is `assert_spin_locked()`.

Anyway, I will just remove it if this is going to block adoption of the patch.

Thanks,
Chris.

