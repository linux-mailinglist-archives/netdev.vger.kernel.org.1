Return-Path: <netdev+bounces-292640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IR+J14QGGrmbQgAu9opvQ
	(envelope-from <netdev+bounces-292640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AC5EFF7A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382AD3020127
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FF3AF672;
	Thu, 28 May 2026 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cClfDiQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgkCYUtE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD273ACEF1
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961947; cv=none; b=Tpyx5l2aNgFtUiBGsO1CwcC4fEQbjFxkJxqbUPOHkv5ZO3h3cSOA7EBeagZoSJoRAl9dPBwPfa5qGYyqKU/q4trCayjsqNmXbWJ+gZ5DDNQVyKq4oQogebV4mQfdRuS6NQEZTwuIU8Ou4Dw3n2Rf3ePVKeN/PPS4w/L87vwt9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961947; c=relaxed/simple;
	bh=t9Abx1aEIxca1y5NbIWw5kC8f5rjGFz7efhPs/WLGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdTx8tTJlZfVy1tx/YYXlVSHX09X4+8kBT3wlBSBGFYe9ZIfXZvvoJPqWh58p53k7rzpxV7GBxZNEwtXvz1p181lE9h2XV4bRO5hsp+0PA5qrBA2lj1o2ClZAVYabGKtMUvm6ENksL9QL1PWmGxPlANT91ECyZpJT+SScP77aCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cClfDiQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgkCYUtE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA5531400081;
	Thu, 28 May 2026 05:52:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 05:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779961943; x=
	1780048343; bh=jHc8465sjAQxBfSViM9C5uJwpb1R9TWPIJtOUUEnT8o=; b=c
	ClfDiQBY4fLl8IEFSl4uNtB7836QM7eQpKVCpjLvwDJdDjMB4aC4OqbzxNRyPeUR
	JgzahBPr5LESQgXzVSZdjIis6logGq8LAJn//GZMEXu5Tgap1bjs/vlv7KMB9JZf
	u1pOzi5uXFA6SYPQhHmoN6MgHkdHKIWB4hplVq0MBQAD/D6NYqjpUdD+4rhJ5ypz
	vGTLrPGXr83cSUDT0WvefYuxKxEU5pOhRacgVod7QY4WdNwXLHB4SUhOQwxsH2QB
	zaoXtpy9qg/lPkf/0G07HnfSoDu+/Tyl1kl3llDVf14lkEYi0iOPMbxwy3fGCjEV
	sijG/JOqH9AQsvukJlUVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779961943; x=1780048343; bh=jHc8465sjAQxBfSViM9C5uJwpb1R9TWPIJt
	OUUEnT8o=; b=XgkCYUtEEhTs6+3YIQ7u/OIJy7FzDQ85fZWPweCSmAZro+48MOK
	Hgf1aK2zSOV/cMxKbQ1KjYdlVOAVX5Ff2v/mjXA2euOshzo78rM3UGqjo5mSImi1
	7oEiCK4NN1PL4Gv3M4EL6gEVN8TKWif79jFGKoLrQqsVSaKsIGe7afsYKcfHb30m
	IslIgUkpqDTWIc6tZRDsW+AhGckM65xNGlU7VJzDjuHdsD99Qn/v8Rd6aS0pfP/Q
	2msATcw+BBSfQnmXC9mP059JIFc3eNgUJHOGcaLCt92rHoms/b3jGyrlUhIbiAaG
	zOsnhJpOHptTGiGL8yofz25HwKghHxHSE2g==
X-ME-Sender: <xms:VxAYai3avUOlnO-m5YwVcajWsr1W3Jk8dIjAFKKeqQ9SWPyiYmiOEg>
    <xme:VxAYar85g6x6sVG8otoAEvCM9Z7OguNNJBtXrJQjqkTf_uLq9u56SOE7ypfkBt1zU
    RVv6e8Z5jjHdveVUYihocupExxr1pzmfto6bwhiEb3FvCjBRvSk21I>
X-ME-Received: <xmr:VxAYajPD59qnBPaoTFwL4Cqj2TKODQh8rDVUNtNsmYCqfnVTenCS29ipGhsVk6MokFn0xjx7-BObM2n30w3691I>
X-ME-Proxy-Cause: dmFkZTE1+1imFXUlslsZ5/xnDNIzSZxPI84kqcyMuPt4qpWRgZ4/ei4Kw99u+sz8oRZDPG
    KK01oW3poI37B4y9bsl66GogXma235IIyiW/7k+LmDvqB5oQBlhHMU2uQTMNRZUWCutgSh
    KNRmhI8ieB6BILCfWLOI7aUHibNSxh7zqE6lVlEw8hMwX5soj9C60xfTsDTb4dfZ6Et3KJ
    hULUf6jvfDZtkd2z62qKzaA0UXO4O4GyKWUybpIKbgAc+nMnZ0KN7RguZyp7HGYLU+KMrM
    a7nSs5B0bNWTArD5WnxkHlbtqe6ogedcspb9Q28dWHb5WKubIXxryG4b2SJrTwBItR7CuF
    5ETKC+Zph79BxTmKkys2Q1UiCAuL6TvnBwlC8kNAvWDn14sepWxqxnC/GkghYPFMbrf1Wr
    jtcRkAP00l0vkXnUhLLwJPQlN0fOuVpW9D5EFCekb6y41FCRq5ABYCEp6grBPzHooiD5Zj
    PzbdIqAYGh12Lg+4qGOp3JbFfxGiNN5q1bITl9Knhd3R726jjAJNAA6KG31O6yo2bTb+bF
    1UjAuw0chnxNjqQSGuxUpcSrNgYSPI1x/qhFqVpzLc491+fCEwvC25NJsE8zfXYiFImvAo
    irnMNngXKL9doVqiQpyqufiAvXSykEH7CeQYK8oUHZM2UsN6kE9CxgNjbm8w
X-ME-Proxy: <xmx:VxAYavcYsyAoh5Z6mpGjs1t2DnBwrR3wPmYVPzYClesCCaAFSjpbeQ>
    <xmx:VxAYaiVIeT9e9Y-j7nEOrmj20SriaL0zU8rv87MUEoP-LlXW1l30pQ>
    <xmx:VxAYanhPjZlZFCjyAtpu1Hg1U3qG1zeKITn5CrjMV-KkATQrjYQI1w>
    <xmx:VxAYah_uaf_vM97mOo-Jyf6i18KCXBj8NDihQh1WN8SxAnwp1P9WcQ>
    <xmx:VxAYaoXM1631bShZYS5Jn76ehzuRqpW218_k-f5E9uIzQc_LtRzAuHUX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 05:52:22 -0400 (EDT)
Date: Thu, 28 May 2026 11:52:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net] xfrm: propagate -EINPROGRESS from
 validate_xmit_xfrm()
Message-ID: <ahgQVfB5NZSOU4T3@krikkit>
References: <20260528064349.5512-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528064349.5512-1-petr.wozniak@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292640-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 161AC5EFF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-28, 08:43:49 +0200, Petr Wozniak wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index XXXXXXX..XXXXXXX 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3846,7 +3846,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *
>  		skb = validate_xmit_skb(skb, dev, again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb))
>  			continue;
>  
>  		if (!head)
> @@ -4552,8 +4552,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  
>  			skb = validate_xmit_skb(skb, dev, &again);
> -			if (!skb)
> -				goto out;
> +			if (IS_ERR_OR_NULL(skb)) {
> +				if (IS_ERR(skb))
> +					rc = 0;

I'd only reset rc to 0 if the error was -EINPROGRESS. Other errors
(none exist for now, but just to make this code future-proof) should
be counted as errors (maybe setting rc to that error).

And this probably deserves a comment such as "validate_xmit_skb can
return -EINPROGRESS, for example when a packet is stolen by async
crypto in xfrm".

If you resend this patch, please wait the required 24 hours:
https://docs.kernel.org/process/maintainer-netdev.html#tl-dr

> +				goto out;
> +			}
>  
>  			HARD_TX_LOCK(dev, txq, cpu);
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index XXXXXXX..XXXXXXX 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -191,7 +191,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featu
>  		err = x->type_offload->xmit(x, skb, esp_features);
>  		if (err) {
>  			if (err == -EINPROGRESS)
> -				return NULL;
> +				return ERR_PTR(-EINPROGRESS);
>  
>  			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
>  			kfree_skb(skb);

What about the skb_list_walk_safe loop? If ->xmit() returns
-EINPROGRESS for all the skbs in the chain, we'll end up returning
NULL even though all the packets were stolen by the async path.

-- 
Sabrina

