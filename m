Return-Path: <netdev+bounces-295194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DuGzL11jIWpRFgEAu9opvQ
	(envelope-from <netdev+bounces-295194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858863F7AC
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="K rbg5lS";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="b+/ML15U";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295194-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295194-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 363E3309541A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A683413221;
	Thu,  4 Jun 2026 11:30:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E52410D0E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:29:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572601; cv=none; b=nmwYkbYl8okDoSyqB5xojn+1dEddWMUSBW6Ps+ays4c3ulDcOJB9QxgG5q3fD4IS+ve/WuBIyW/SW1IRc99z3fa5xHgeUZgKqHESvJXVvLJCk2j3XawnVYGYpbMNUb5RuqWdG5PMIqdSzpJgKLrmotK24typEMF2jxcPxHqo4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572601; c=relaxed/simple;
	bh=3xCTVmNnSPEoxdgNSEi0gc70c48T1Abej59kL4hGQjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbXoRR1JE7uG7kXoQljtjMmUXCZFRpedAC3D2zUXNJmVdMGSu/eFyI1/05EG+bM7cEpkCUo1qpWNttp8mfBgLGSrtgZKcE6msBmfRyCVMqgOIlfCtY2RWQ7h42N33L3rvkUTzm1bS6xUsZB65eJx4I0bIy3kzxv+L3USkLBir9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Krbg5lSo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+/ML15U; arc=none smtp.client-ip=202.12.124.144
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 45FCF1D000CD;
	Thu,  4 Jun 2026 07:29:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 07:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780572597; x=
	1780658997; bh=KcU5AcFDvHbHjh9CaIlBg3QtzZmbJNSuOoWxDRq/G5s=; b=K
	rbg5lSoXsgOF3yXTZao/3s3PBhbV+L0lp6OmXu32qDTF5oTiGJku13xS+rT2fVgP
	zzZ+eqI/opCDeQ8LLUQlIaNM6YU/VpzUXpoP/8Vm2HdeL9AxzmcVLSaaXQZnp86p
	u1M1nTdIcGHUqS7g4tYAo9dkac50laWiG4ipJdk9kLXmxNcWbhPbusshfFIN9foT
	RqtlnNJ1O8LN2L1I3KAR6vDqk3OPkFFYPVNmREWH8CuDQ5pEZSCT0RWCGR63JuCe
	yaNhvVZADl2xdP+8IBuoqp/71LoanPBLuDAQK3nITm65NrvmJxZc0P/Utt8EY22e
	4uIjMUPCqX7hMmuRKFtwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780572597; x=1780658997; bh=KcU5AcFDvHbHjh9CaIlBg3QtzZmbJNSuOoW
	xDRq/G5s=; b=b+/ML15U2pF+/7366eeuCY/+JA9mmZ6b/L7NdOsQf5u0UmjbuFe
	dD7kAqeKOSSq5/3NBoUma8ytH1b2cb7MNm9B1k6TTNN60v0xmwClpXi37XxAEoXM
	17EFnG9WYBLzwB7Alvz+KivIG+VRHXzhhqL5BXxZJF4ay1c80Llv926Y/ubNBm/z
	zyHusqGswgGqC9xenM4tOe6bgb3y2nBWRqd7buQEYe13GmUJEfcrA2fOr3HtroEz
	+wlkm7WP3iAGyU5Am6Tizsw3Ua31VCwa8tLKLW+Ow+ZneOgpD2yjWkbtn90Te2LQ
	he4Hvq5avk+fOVjIPhOS0rTW1cVOG6fhFaQ==
X-ME-Sender: <xms:tGEhak2y8wq_dwE3LAHlcQSPqopT1dzSrwIjMe_mAMUz5LTKZ5sm5Q>
    <xme:tGEhal__HNxQBTwGPuw5_nsRGMq_NkGRb_69qDkGb7ERmG7BwbVLQtGmrFL6BPsUE
    OP1eaFUEOzBRJ4o9jPhRfRUbme2LS7UgbTDvp0gfHvHHRzkeqkjUAg>
X-ME-Received: <xmr:tGEhalOobjatfXFSiyKQSgGMA7VE3NSHPERDlhYzi0h5R4_vvp2crpdPc9HiZrsbKWZx0huT8pb1CVcEf5P9EVw>
X-ME-Proxy-Cause: dmFkZTERkj34z0SZNtSVrnLqBdxqZzXt9RjqHqE02rrJUZNIo593dtM6b+EWsKHPqDY4zl
    +D3BSrOgZr6162unoeU5+hDv5JvSs+/0Tg076P7ndcxEELILgv9VsINePTq0iiv/B57sac
    GwHWm0ZxS5y9/8nQtk6x3GBI34XUorzboNJV/8u1mo8GuTf6JZv7yVB3TS7c+clhQxrfDZ
    rKPNxHX9dJ5Z0TbLbPVkBn4bpk69IgxLw+A/Tng0A9HUquYbxaXsz6kjBCNQ8GVbwhFIbL
    3zHI3UOdBFtvxx5Qx38xU/Y4AzlUixWXKzRupRUpFIOf1nXik1RQCKNddcxDkak6yk6OIM
    hihhUZ8u4bemsWTlbTelqu9EVF40JieuW4WM8OKbR5P7VDS3zha/LUfYXxLEltpt6Nn7dt
    zScQcOU8BrLlAETLIhZaQ1RBM/RfbriT/E+nPbTfxWkMs7d8YlnHvrpKRKG6G3hIPk7rj8
    13OhbS1rDRn+FdPtHc7Wbor9cz8LkOtJX1vsL96QULt3wKMPWPnMPOaJb+1uK2PCvLTRag
    THm3SITqzbFcy3y29tab4p2Ro+Bdhcbll9doyQ/4rhJVG6UxYMMO6XogMQwMBZiPHvhVe2
    NhsUrXkQYDwWE7sUkflSHxuqno+nq/7i7EpIgih5wjfcwYfnp5Q0SqoLEZ6Q
X-ME-Proxy: <xmx:tGEhapdnfURPYSF7aeAzh6c-mMbTnzyGJ4RWiSNSBmwI_pmiTxLVeQ>
    <xmx:tGEhakWCwHq-HYdfqpleGkdWl8OGCUXy6fcSjwzR-WrhKU_5ACteEw>
    <xmx:tGEhahjPmSo3EoAwJ1BNex26w4L_aSTO971VlXwsFefY73qR2_GWtA>
    <xmx:tGEhaj8F5mN01CzsYqnjO-LbACpA08FiMl9gv5sFfeKxzYStwNclAQ>
    <xmx:tWEhaiU8JTDx4nZnmThCfGbwAuEr9gjZXLjW9r9HMieiQ8l_n2fuRyVm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 07:29:56 -0400 (EDT)
Date: Thu, 4 Jun 2026 13:29:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [PATCH net v4] xfrm: propagate -EINPROGRESS from
 validate_xmit_xfrm()
Message-ID: <aiFhsnMbps9vz3uD@krikkit>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603064659.3867-1-petr.wozniak@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:pabeni@redhat.com,m:edumazet@google.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295194-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2858863F7AC

2026-06-03, 08:46:59 +0200, Petr Wozniak wrote:
> +/* Returns the skb on success, NULL if dropped, or ERR_PTR(-EINPROGRESS)
> + * if stolen by async xfrm crypto (delivered via xfrm_dev_resume()).
> + */
>  static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
>  {
>  	netdev_features_t features;
> @@ -4078,7 +4081,6 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again)
>  {
>  	struct sk_buff *next, *head = NULL, *tail;
> -

nit: no, that blank line needs to stay

>  	for (; skb != NULL; skb = next) {
>  		next = skb->next;
>  		skb_mark_not_on_list(skb);
> @@ -4087,7 +4089,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
>  		skb->prev = skb;
>  
>  		skb = validate_xmit_skb(skb, dev, again);
> -		if (!skb)
> +		if (IS_ERR_OR_NULL(skb))
>  			continue;
>  
>  		if (!head)

[...]
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 550457e4c..bb0c0fafa 100644
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

Could you please explain why you're ignoring my comment about the
2nd x->type_offload->xmit() call in this function?

Thanks,

-- 
Sabrina

