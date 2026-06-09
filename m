Return-Path: <netdev+bounces-297268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WanuGdFxKGpuEwMAu9opvQ
	(envelope-from <netdev+bounces-297268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:04:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89966402E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:04:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C2SguJlO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4214E303FDC0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461733C18B;
	Tue,  9 Jun 2026 20:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D13101D4
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035227; cv=none; b=Opo3Q1SNAFEM44zhUGvFekJd1L2j8foah63clbgTQPr+Xqikt3vS7wyAry9ZeFNs9XtmpaauW/xPYxYuT+XvQ0WPx1w4feLiuKs9X0JL6ZGZQJGoD336sSfDBgxDViLKZsOi/3Sh87OmlKwT3W6ODc4lyMAuVEonyMwF6kigbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035227; c=relaxed/simple;
	bh=atkVeRtHl29QOTq/5yI22UI56jJr39PHMNYds0ex9c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npbWbCSJQSF/qkx9HAaze5+vdtI8rKp33LBdlKq1sFfi1Wy0mXbt6ljXE5rQaxz1RAj8dXiaSipbzfRWFahz2tB4DrECZkZBfOj7kXItkPIsYFQfYSvHbXNK67sKH10J3qrpWNAttY4K2diA7r4ZSExUpbKHRhbZHQ62qPnmt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2SguJlO; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22d29dabso40219445ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781035226; x=1781640026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix3A9Bkx1Es21VmQaAIlLfNxieuTVS2PctS6G8kffR4=;
        b=C2SguJlOSFlbm05lgCc49wTOFULsmUvhEmmNeCRF4rGF8aayECntBpzEJV0m+2SsZo
         yg/Gny/UHmTNE3s1XYsWgD+mpwoXcEsPrtoYO4lTIXETX6Dm4DPZNq5hrLsyEtfaFuZg
         IZjJNCAM6LqtyxWYMRrTHtmy07cMaUBjigH0d8p3kD0EUPn7xiCVT4CN3NMWu1NlX94o
         +l6G4rBg/NDmg16ff9vdcDUhCOMe1xhaV+P5WcHKrDeCzgqfpA29D+OLzt/mzz71WqMA
         HVU9GyfA42KT8cPOkboZH36J9yfl+oBfUOC1jCYCJqbxvvTIGGMIvTHMQR3Q5sMibP/0
         Xdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035226; x=1781640026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix3A9Bkx1Es21VmQaAIlLfNxieuTVS2PctS6G8kffR4=;
        b=mKx9YfzOnSdY3umz5IplVK0VLqosJg44aBFXwse6jYZDE42rmF563dP2jkFB23EH64
         J9krvEfFjlpyxkpUNmgXfN0KA8kA1Lev5Mrbom/8OiGmFZGyrs93WDJ+gQrNpGKHe+av
         /1+PQUcm2HtmosISY8UKPGaeO+TdEypj0HFKiIIGfd33itO2oaUjA5G+IyJYUwnMAmxj
         5Ejgv63tVT287o/SGz6jktGF6T+pZKn1caaixv7K/vrwY7igv++NXp3yzdddBh3YNFAh
         h3KmMQplMQfBqc/tI0X6AZW3Hcxv78zktqLU3h0uRuqDtlo70hIp2YTQ6yAZMOuQwl2p
         /BSw==
X-Forwarded-Encrypted: i=1; AFNElJ8O8fwyKfqfNed6w5Fd3pjUdyHq8Q905FBgWoCgo2NPLb9B7dksUvZLdXH6tjEjTKW5ybhnjXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDa39eE9arjOLsoXY3domUyAkc02zqyZruFnY1nExZ0EzxdWe
	b8EzWOAa1x0iMkXRBLb5HNZDGuHhLnwFkrPj/nVYrg44bOXVHiifooI2
X-Gm-Gg: Acq92OGg7V6Ows7hEMCJwExRZAkTsGJRFbuyZ/OLWP8K6EgqoWkH3/uG2xT+r//fnkn
	yDaDuwFXzXtjdOIdp8lliNhsQJog0uXExEdIuUQSA9JUo78RQ3TeVIPADJg4s1clXYvrsp3EuLs
	aGu05A1v0acGU4JwGdHuU/nHLrM5w9FtkfI+k6QgQ7ZNro5CBUr3haHc6RGzdlY1tgUynPVkdFB
	hlowpLIsofVxNmGzN5y02x0E6FNlXIgKmMkC3IACTu1CTMGZnmcCDk4iJ/jxll0Adom5yTyaYHl
	ncoVwuawcyUftQCM/laU86Ct5q/eAuF+5JdF3wy2ib3uOEEJ1507uZmqVhzIVmHVOxWR/G8prMY
	joMxrvj6DCiyuJxuJwaDa7EWErAGLKT+GdkAOkAWWEO+u0snkfVS70e4mDSVtLhk4FlbRwLFEBS
	GTFjynab89wrs2RbNXaeDbrb/7yQgSxzAsUg8EttI73vH2NuSWcWOQfA==
X-Received: by 2002:a17:902:e747:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2c2a1bcd562mr54246885ad.12.1781035225586;
        Tue, 09 Jun 2026 13:00:25 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6ce98sm203854515ad.10.2026.06.09.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:00:25 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:00:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 4/4] netdev: don't use dev->flags for IFF_UP
Message-ID: <aihw1/9pkcwuUbIF@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-5-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-297268-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD89966402E

On Tue, Jun 09, 2026 at 12:08:04PM -0700, Jakub Kicinski wrote:
> dev->flags are not technically ops lock protected. The IFF_UP flag
> will not change when dev->lock is held, but other flags may change
> so KCSAN would probably not be impressed. Because of this we added
> a dedicated dev->up which is safe to read under dev->lock.
> 
> qstats want to make sure device is up, use dev->up.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 18046ad0f883..745e2eb6c9af 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -773,7 +773,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
>  	const struct netdev_stat_ops *ops = netdev->stat_ops;
>  	int i, err;
>  
> -	if (!(netdev->flags & IFF_UP))
> +	if (!netdev->up)
>  		return 0;
>  
>  	i = ctx->rxq_idx;
> -- 
> 2.54.0
> 
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

