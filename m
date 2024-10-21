Return-Path: <netdev+bounces-137426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B49A62D2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16EA282260
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B341E6DC0;
	Mon, 21 Oct 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RuCp/aVa"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80AE1E47C9
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506401; cv=none; b=XNKxuI350fr2/Facnop/Aj1Qty2lyRPY/XMt8J7Fb+iQBZIF40UQv6maA513zt4ex0h0ez6bVD1V7sM79swTLzoUiScyqHfmztIDg8CkAJn9KPuOGJ+G6cUn7ZrR/sLdFkWHn+5PuZYE8eJIlmg65nR0g26B03c/kAnEs11cfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506401; c=relaxed/simple;
	bh=E7VKrqv0adoPjG9DIf0lsHdFk0cfFJ+l4WaW1k/o1YY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekIOHtYmXXDzndYit8oaGyhBGvIA6wCdcD9/N/Gg4X3LhCXw/u1nYnE4ZfbYi8y34YkspNZYucZC3gue1ZtPXbhANFpropkOYLoLZHe1LuWprtAIjEfpxIDdpM3twxoE+YYz/iICODoEPRTa5rB6tsammXuGffZquFi2qfBdSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RuCp/aVa; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 94350205CD;
	Mon, 21 Oct 2024 12:26:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIhp2a-hy_6k; Mon, 21 Oct 2024 12:26:35 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C354D20758;
	Mon, 21 Oct 2024 12:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C354D20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729506395;
	bh=vgi1+KRBbHkeCoQHa3jb7Qa/cewHJFr9xoAsQOd+VC0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RuCp/aVacoWNgV72a6EV5H29V1ifBjGDevvtnbt+bwq7X+l4iqdeFgM2KAsbQ++4S
	 Fi6LeoJuLMqsvmiwl/UtR3mydkSdytPACw1QwW3IQmGx4MEqjXxGi0I5EkquNDTIoG
	 dzOkjm1ZV5FMjTPUQvRWHEyEa9s8u2aMWiB5yEbuxk/I+7A3432AbWjdpEMp34j5Nu
	 xeM55ZABS8YX/WX6gEwSaV00VFT/hHNiCNWCnSY05w2nyVA2KWneM2BzwXKodPXwBA
	 d61Dkf2SFoGFDy1QLFovDEKV9hrPO5aVfcSeas8zSy6Vj55HNcEdOF2SQ75L/dZeNm
	 gqznjwV2WZGrw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 12:26:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 12:26:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B512331819D0; Mon, 21 Oct 2024 12:26:34 +0200 (CEST)
Date: Mon, 21 Oct 2024 12:26:34 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 12/16] xfrm: iptfs: handle received
 fragmented inner packets
Message-ID: <ZxYsWnWKPYyaoX79@gauss3.secunet.de>
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-13-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007135928.1218955-13-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 09:59:24AM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> +
> +/**
> + * __iptfs_iphlen() - return the v4/v6 header length using packet data.
> + * @data: pointer at octet with version nibble
> + *
> + * The version data is expected to be valid (i.e., either 4 or 6).
> + *
> + * Return: the IP header size based on the IP version.
> + */
> +static u32 __iptfs_iphlen(u8 *data)
> +{
> +	struct iphdr *iph = (struct iphdr *)data;
> +
> +	if (iph->version == 0x4)
> +		return sizeof(*iph);
> +	WARN_ON_ONCE(iph->version != 0x6);
> +	return sizeof(struct ipv6hdr);

Better to return an error if this is not IPv6

> +}
> +
> +/**
> + * __iptfs_iplen() - return the v4/v6 length using packet data.
> + * @data: pointer to ip (v4/v6) packet header
> + *
> + * Grab the IPv4 or IPv6 length value in the start of the inner packet header
> + * pointed to by `data`. Assumes data len is enough for the length field only.
> + *
> + * The version data is expected to be valid (i.e., either 4 or 6).
> + *
> + * Return: the length value.
> + */
> +static u32 __iptfs_iplen(u8 *data)
> +{
> +	struct iphdr *iph = (struct iphdr *)data;
> +
> +	if (iph->version == 0x4)
> +		return ntohs(iph->tot_len);
> +	WARN_ON_ONCE(iph->version != 0x6);
> +	return ntohs(((struct ipv6hdr *)iph)->payload_len) +
> +	       sizeof(struct ipv6hdr);

Same here.

> +
> +		/* We have enough data to get the ip length value now,
> +		 * allocate an in progress skb
> +		 */
> +		ipremain = __iptfs_iplen(xtfs->ra_runt);
> +		if (ipremain < sizeof(xtfs->ra_runt)) {
> +			/* length has to be at least runtsize large */
> +			XFRM_INC_STATS(xs_net(xtfs->x),
> +				       LINUX_MIB_XFRMINIPTFSERROR);
> +			goto abandon;
> +		}
> +
> +		/* For the runt case we don't attempt sharing currently. NOTE:
> +		 * Currently, this IPTFS implementation will not create runts.
> +		 */
> +
> +		newskb = iptfs_alloc_skb(skb, ipremain, false);

As mentioned above, __iptfs_iplen needs error handling. Otherwise
you might alocate a random amount of data here.

> +		if (!newskb) {
> +			XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINERROR);
> +			goto abandon;
> +		}
> +		xtfs->ra_newskb = newskb;
> +
> +		/* Copy the runt data into the buffer, but leave data
> +		 * pointers the same as normal non-runt case. The extra `rrem`
> +		 * recopied bytes are basically cacheline free. Allows using
> +		 * same logic below to complete.
> +		 */
> +		memcpy(skb_put(newskb, runtlen), xtfs->ra_runt,
> +		       sizeof(xtfs->ra_runt));
> +	}
> +
> +	/* Continue reassembling the packet */
> +	ipremain = __iptfs_iplen(newskb->data);
> +	iphlen = __iptfs_iphlen(newskb->data);
> +
> +	/* Sanity check, we created the newskb knowing the IP length so the IP
> +	 * length can't now be shorter.
> +	 */
> +	WARN_ON_ONCE(newskb->len > ipremain);
> +
> +	ipremain -= newskb->len;
> +	if (blkoff < ipremain) {
> +		/* Corrupt data, we don't have enough to complete the packet */
> +		XFRM_INC_STATS(xs_net(xtfs->x), LINUX_MIB_XFRMINIPTFSERROR);
> +		goto abandon;
> +	}
> +
> +	/* We want the IP header in linear space */
> +	if (newskb->len < iphlen) {
> +		iphremain = iphlen - newskb->len;
> +		if (blkoff < iphremain) {
> +			XFRM_INC_STATS(xs_net(xtfs->x),
> +				       LINUX_MIB_XFRMINIPTFSERROR);
> +			goto abandon;
> +		}
> +		fraglen = min(blkoff, remaining);
> +		copylen = min(fraglen, iphremain);
> +		WARN_ON_ONCE(skb_tailroom(newskb) < copylen);

This is also something that needs error handling. This WARN_ON_ONCE
does not make much sense, as the next line will crash the machine
anyway if this condition is true.

This is also a general thing, there are a lot of WARN_ON_ONCE
and you just continue after the warning. Whenever such a warn
condition can happen, it needs audit why it can happen. Usually
it can be either fixed or catched with an error. Warnings
should be used very rarely.

In this case you can either make sure to allocate the correct amount
of data or extend the tailroom with pskb_expand_head().

No need to crash the machine here :)

Please audit your WARN_ON_ONCE calls, I guess most are either not
needed or the condition can be handled otherwise somehow.

> +		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
> +				      copylen)) {
> +			XFRM_INC_STATS(xs_net(xtfs->x),
> +				       LINUX_MIB_XFRMINBUFFERERROR);
> +			goto abandon;
> +		}

> @@ -1286,7 +1729,11 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>  	int ret = 0;
>  	u64 q;
>  
> -	if (x->dir == XFRM_SA_DIR_OUT) {
> +	if (x->dir == XFRM_SA_DIR_IN) {
> +		q = xtfs->drop_time_ns;
> +		(void)do_div(q, NSECS_IN_USEC);

This cast is not needed.


