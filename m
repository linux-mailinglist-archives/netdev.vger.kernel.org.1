Return-Path: <netdev+bounces-293784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OLlL9mUHWrOcQkAu9opvQ
	(envelope-from <netdev+bounces-293784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D0620B33
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A360302DE1A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795363AE1B1;
	Mon,  1 Jun 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="FO2ZVpsG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/6Lj473"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4837CD48
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322902; cv=none; b=PRukM/g3cjS/jycRvAfi6Zm7eABqO2qKKnc6uI/ekOFp02scOeETTWqu5y8wOVjsVN2YB5v55sQJR/OPRYkjyn/pt30GbNHHTPyTfv81LkQPLZ7lVRFTf/7Cg83d5rthacV+Yp327M92200rSCVwiJ7A27V4dbXanYVrYZzGG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322902; c=relaxed/simple;
	bh=nL8DZCombjhPliRsheRgFy6iQn4eApXFO6BcytBBlcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yalh0J/E9F41RQODmvCpT/setaarqwnQyr3t+EM4TM4av2xz6B8pFD95ZT6ZG8ZZak3DRVRjrOfltgVfY5ATVV3f02gebLfNrnSdL1xpuFEWiTGr1fsH6EkSFZlm4e/gS2sfW+9f23LqKXirUQ23m6NLtvVZHERGSkFsJPMsOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=FO2ZVpsG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/6Lj473; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 79DA8EC00C4;
	Mon,  1 Jun 2026 10:08:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780322898; x=
	1780409298; bh=UxVpBV78FyUduhPpqlpu94XSUNLZLVVUE4ub/DoSkvc=; b=F
	O2ZVpsGhVBPCiLXX4R9snsKtsxCvfvK1rXU0CI9ZzUQY6KCPxfSAxq2Lg0N0j+bj
	x8Vt6Yg0nVJQhwKAEraLIpFQSOlGKjte/+Fa23zt80kNLiqYHxf2m8ugqm0GxiQq
	LQHMrz7Cbe14SE/jWBb2G8YgaYBqRZgyVxy7JyHvwHphJnAImtrGsH3GMutk1Kd7
	FMpy/Yjz+VKBH1rr9qEaX37pLe+gh0xO6qza41tAA+3c0BhZ68rlQyRG88RLRz4R
	QKcoL060aR0ftiUerlqN+9STeEYq+0c0ZJ1apTyg7H6RTTZVvRcaaRtJg2r9I+Yt
	3Lxd2VqBkAcXRcgrbjAqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780322898; x=1780409298; bh=UxVpBV78FyUduhPpqlpu94XSUNLZLVVUE4u
	b/DoSkvc=; b=c/6Lj473rI52i+latOYcH6qINqjB/LUvS0xbg/TSjjdVemzbcNi
	R+5WHIgHOmWm8YvhX5gFGOjvgcKiuDKHd9Eke8VIOo7sVE/xCxIsJIroYf/WuWGl
	f7n061p5+WaM+bFH9imXK/lXSi4F8Q8Iq3kqwxRGDwdhuvwMpzT5xK0z7GooBv7J
	oLVZ9x8dzmWJmLLAoK+WJPJqGNyZ/Vr2ngh99s2TlagvMMQnUg9iie7iodxr+sIU
	3C0tDZFZA4vdjUMz+SIUe+qEj8C60xSRoJ6LzRP5m1V79x6NP3WYJvULOkgpYFbY
	yDtZrFkBWRbtOc68vElAlKvqQFMZxQu2FeQ==
X-ME-Sender: <xms:UZIdak-y587jnKe6VraoKHdtsY_BxXcFvx55Oc-IHFFXAdgJ2_eUsg>
    <xme:UZIdajnM2kDDla_egc8BtAq03sjIs95yj919vyfcfZvZzsHdXYcJXArQ8bSMe5gnW
    8rkAcWajDtIHkIUDDuLVluJXhmoKP_y2D3n2E7ksWAQ_WPOzxjG0Q>
X-ME-Received: <xmr:UZIdaiW9QobRdsfxEGnbDlQv43iAiWpRu3SVMR7paUskiXsT5_inw-Cmq8jaCuhJFxWfaZhgmABCoORTvHkH4Yo>
X-ME-Proxy-Cause: dmFkZTEfQR4Vl6mNpFQ5K/t8d4VjlatqF4f/7pDjuAm21VjzLnKw9qTv3DSskSuVuo756y
    jFpICW9ULybtLFGjn4Y56uEvY4jfd3ipHl3IZ+vKmyE8Y79Mv1TLSCV0kTNDlRJ+FBab28
    i7Uo23byHA6sf1RAA8vocqa8FiAH03uWxGH3rPucgrQKOlsGIBdwXXyBKL9pani0+ZGiOc
    NsSEYejvpMsfym9R4/5uiVuTmE4SMmSsijIMgP5OmUo+9QkgMmTvfuyG+FFDdfy4O3gODQ
    5IPtJQBbktjJ6fwsTh6CMIsPlinh4nIpwks8TUFWexPfofUP3ZOgZpy09I4Vml9UsxGnr0
    j14OdFc16Byfv7MqtI1kdh952JHRGfk6r88xrSQwVPFj0F4Zi5Kxq8rFUfWqmYoSQv4nxF
    KP0f1+asAYJUuSpSU+o6bapVMy5E8ic1DCVholcC2OR2+Lo1VWqNTu9/+ykaKzWOfoQ+rh
    3pEFpiiEsUAINxW33k2/2AKPCMOYd3O/XM1ects/2bWWckEDfi2ZS5ssGBkewvFhyYdDKg
    khhcpImR+d6LQuQ3p14rO5MOkV73X94Ro5nfohnGiOs3DvZQ+XxWtGo5tgsgMUj+KHMEVG
    qOHZiJH+YxsUk7JxtLpqgklGDtDVGMDhxug4e/Cedw6LJjOVnbu0YKcmWNBA
X-ME-Proxy: <xmx:UZIdagHxFhp6Qf6WkoWoVBxnGeWOeW_kZyoIe8b1goCA5wz3ddXsjw>
    <xmx:UZIdamdATfitpaaawMABbJrs2pVIbCjmtSNnoErG37Ix7tqX85eWYA>
    <xmx:UZIdapJPsdU3Z3uKpgG-KIfYMXzRG_edGNlofMmdvvkbWJ5Dci6b5g>
    <xmx:UZIdajFVzZYEM0iakKY982ueQYIhj5VybcoDHIMdS-029Dh-lktpCw>
    <xmx:UpIdap-LgwMPBxdWhR4G63Nph__uLTSVIIITPsXTer49MwQksFSFUBGK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:08:17 -0400 (EDT)
Date: Mon, 1 Jun 2026 16:08:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net v2] xfrm: propagate -EINPROGRESS from
 validate_xmit_xfrm()
Message-ID: <ah2STzEhNYfCc-Wm@krikkit>
References: <20260530061619.2239-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530061619.2239-1-petr.wozniak@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-293784-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E4D0620B33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-30, 08:16:19 +0200, Petr Wozniak wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 804e8ad25..618e6299f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4079,6 +4079,7 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
>  {
>  	struct sk_buff *next, *head = NULL, *tail;
> +	bool stolen = false;
>  
>  	for (; skb != NULL; skb = next) {
>  		next = skb->next;
> @@ -4088,8 +4089,11 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
>  		skb->prev = skb;
>  
>  		skb = validate_xmit_skb(skb, dev, again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb)) {
> +			if (IS_ERR(skb))
> +				stolen = true;
>  			continue;
> +		}
>  
>  		if (!head)
>  			head = skb;
> @@ -4100,6 +4104,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
>  		 */
>  		tail = skb->prev;
>  	}
> +	if (!head && stolen)
> +		return ERR_PTR(-EINPROGRESS);

Why? You said previously that this path isn't affected (sure, since
validate_xmit_skb_list ignores intermediate returns).

Also, sashiko complains that if you're going to do this, the callers
should be updated to handle EINPROGRESS. And from my side, if you want
to keep this "bool stolen" handling here, stolen should only be true
only for EINPROGRESS, not all errors that validate_xmit_skb could
return.

>  	return head;
>  }
>  EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
> @@ -4859,8 +4865,13 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  			goto recursion_alert;
>  
>  		skb = validate_xmit_skb(skb, dev, &again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb)) {
> +			/* -EINPROGRESS: packet stolen by async xfrm crypto,
> +			 * delivered via xfrm_dev_resume(). */
> +			if (PTR_ERR(skb) == -EINPROGRESS)
> +				rc = NET_XMIT_SUCCESS;
>  			goto out;
> +		}
>  
>  		HARD_TX_LOCK(dev, txq, cpu);
>  
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 5454be0b2..7702cca2b 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -182,7 +182,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
>  		err = x->type_offload->xmit(x, skb, esp_features);
>  		if (err) {
>  			if (err == -EINPROGRESS)
> -				return NULL;
> +				return ERR_PTR(-EINPROGRESS);
>  
>  			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
>  			kfree_skb(skb);

c/p'ing my comment from v1 since you didn't address it (either with a
change or a reply to explain why it's not a valid concern):

What about the skb_list_walk_safe loop? If ->xmit() returns
-EINPROGRESS for all the skbs in the chain, we'll end up returning
NULL even though all the packets were stolen by the async path.

-- 
Sabrina

