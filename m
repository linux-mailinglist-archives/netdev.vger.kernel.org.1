Return-Path: <netdev+bounces-284964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLLTJm94+2lnbgMAu9opvQ
	(envelope-from <netdev+bounces-284964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8444DEC2E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F23E300A3BE
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBF4ADD89;
	Wed,  6 May 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cSHvfrm+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSyfcY2o"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFC41B355
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088034; cv=none; b=MS4v6RuL9/kvnmrN8sp/CPTZ0Y9vnmx/Byh6QMo+1rSozlnteEebwr0fGMbRpLeNgcdl234w3vzGhiOjlXtWKQG6Lp37+LgQJclDoIdaqUYPaBSVzBsRqiz31L/IzaX8NUWmqXIcxvmH82MoiaZvllxMJkh5SNpSwl2mVS47ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088034; c=relaxed/simple;
	bh=xAAgnYgLlSXFxR0cxBA1qh6iw/0Tn3Xeue9/SbE/mwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8zcfk1BHqL9m0Y7xesPg3AVZffTeWOLnO+Z+h+QX9+xPXyo/85OY0CKYL/YRuR6GzGfFHxdSwGB5cG4QTXK0nKlNw9oFvOOZNlYzee9J6+80v3k/h3/jlsgZXIheY42YRpFHKe6To/wRJHs8RhKBcdTehy727ZYfa6e2krki7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cSHvfrm+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSyfcY2o; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EE04EC0128;
	Wed,  6 May 2026 13:20:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 06 May 2026 13:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778088025; x=
	1778174425; bh=qivrMLBxM/dU85KxqKwVVx87J+0cqXSf/AT00ICCzu0=; b=c
	SHvfrm+lgh7CQys39c6YiPiX9dVWo4OryGKDGlRUNm7SnvudrXejg8IjtkUdukrA
	OQFOlHS/O354EFe80X9Z2tT3OJsbvCmIEy8M3PsOr8Fs5T0DzNehu9hNWptKy/jr
	pjbQ0lPJpuwHmKCvFRUdj85JWW4ZdVT/do0oY9bW2s4zptyXbXftaP5pbLFJscmM
	XE/MX+eXs/6FQ7k8HDW9q7quQKuWZKigHJX+atHqa/M3q+byGXawnNUaFtIcvPbL
	sbY4/0vbQZw0TZO9s8PoeB3PSFAnqJqV1/qwF4WmZMgjKShFoeoYFmbzT8pCobMr
	bXzdWVzjRP3eXnX2KFMug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778088025; x=1778174425; bh=qivrMLBxM/dU85KxqKwVVx87J+0cqXSf/AT
	00ICCzu0=; b=BSyfcY2ows4dNBLgGjUfzQsON9KzYB8fz6oA8c+LJIkRfZOzfqC
	YGFh+VxxOCpKC5zNajM3Gi9wukEopP5aEz+HWsvLXJGe+Y5moF7suSi+vkoTqi01
	E+IhtmOMat50m/s6voF9FsDY+ILZD7qBX/qAUwViTPy2lyB6H/uoZoDWckj6O8ah
	6P5jaXmMgijD2UcgEXqSxKiVetHJcjbbU5tFIerY++myE4QieZhWlLl1FDL62obr
	/fnynwOKzrkXEFOijeyoFy3Q2Qfk/HDboocpUX+UBBkH3D4l2L6rdYRTD1XBa+fU
	/iLj74JpltcdE7q8C4oOKklLBufeu6oc6MQ==
X-ME-Sender: <xms:WHj7abA4l27-UCh-w4gGuu9_0_aark0tjw_EFukMZs8TYdULPfQWHg>
    <xme:WHj7aY86Y4dG1MfiXA64rq3TzOZiQlBrFwdxhH0UXMu9Xh0jmHCx8Mocxk7RudMYy
    OeFmJYY2ENYJVK4OZYFalKf1sxIzCf-a66pvYhEUHh2mliryrLNIQlH>
X-ME-Received: <xmr:WHj7aT9xLv4i3WFjEIiHOHVoTilNeb5x0pX2rRHC4kBSTM9jPymOtjO6cu71>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthessh
    gvtghunhgvthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeguvghvvghlsehlihhnuhigqdhiphhsvggtrdhorhhg
X-ME-Proxy: <xmx:WHj7aXdVY-THI37nHOyJBS4KDRoDQw4blCfCGhCqjKu_IyDhlGxcNg>
    <xmx:WHj7aUHJKePNfmsRtwuoIb8PX_-ZelrEIwyq4C2_lsZk56zBUy6_Og>
    <xmx:WHj7adeXGDQljD9EnsSJ79ygO5CzXkQwow2nwf5XOaelWqfHUgVL7Q>
    <xmx:WHj7aWHa6iC4BM-MYEztTuyh3XAY96U5fZVcnfuKhGbmp95nMf4miw>
    <xmx:WXj7aVJldhMULQhRzU9iKTTfdIFsvpoz59oi8YXd9OqY_O_UASKZ_GKe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 13:20:23 -0400 (EDT)
Date: Wed, 6 May 2026 19:20:22 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] xfrm: Use regular error handling instead of
 BUG_ON() in the netlink API.
Message-ID: <aft4VvklN84f0xX8@krikkit>
References: <aftnl6d59WUM_Dfm@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aftnl6d59WUM_Dfm@secunet.com>
X-Rspamd-Queue-Id: 1D8444DEC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]

2026-05-06, 18:08:55 +0200, Steffen Klassert wrote:
> The xfrm netlink API uses BUG_ON() on failures since it exists.
> However all these error are uncritical and can be handled
> with regular error handling. This fixes machine crashes
> in situations where an emergency break is not needed.

Nice clean up!

[...]
> @@ -1794,7 +1797,11 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return -ENOMEM;
>  
>  	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(r_skb);
> +		return err;
> +	}
> +

nit: extra blank line

>  
>  	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
>  }

[...]
> @@ -4151,7 +4170,8 @@ static int xfrm_send_report(struct net *net, u8 proto,
>  		return -ENOMEM;
>  
>  	err = build_report(skb, proto, sel, addr);
> -	BUG_ON(err < 0);
> +	if (err < 0)
> +		return err;

This one is missing the kfree_skb(skb).

>  
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_REPORT);
>  }

-- 
Sabrina

