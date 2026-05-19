Return-Path: <netdev+bounces-289414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJPGL75JDGrjdQUAu9opvQ
	(envelope-from <netdev+bounces-289414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:30:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8657DA25
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1BAC3032E6F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4D4A2E16;
	Tue, 19 May 2026 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ADI5ucoG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330B492532
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189758; cv=none; b=NN4avXlxjwIMI+BomVM02SwZGbk1SVVu3FMdaITgykj9YVJR00O4k6VJ2GO/TVPXDDdBZ3xVJEsP6A3XsacTkyoQmOCtIlD/4qOyDRQtGD/vEnumee8XJPuSbF1VVfZlOvAOCs9Xf+u5M+tskaSLrNd7BIPRZLk9Reqy3Cw06pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189758; c=relaxed/simple;
	bh=JiliqwmeTv5ZXyMxVrtt16k5uLTWWHQegfkwLE0N5jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmbpaeOAZwGxovcnxFKyTKoT2G+fv5eJA86qt3ICkQQjnRC9eq/5/7/mIswwOH8ZPpXaW0pp95MM/KiQWR4cRji4JZYZCMbQPmElx/P+/tpw6O8Izqbsy36FaK1m4B60U5r7/wxvwzKu1L0aFHEDixsXhGuMG8cQR8DZTdEaWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ADI5ucoG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so693655166b.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779189755; x=1779794555; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1U4HETeGQHn+t9ZlydfwnmW4BLrbZCxQ7ZyTEEws6I=;
        b=ADI5ucoGYM30zTcqLgzSLlIRJ/TG9ZF2k0I3fltRtn3Lh32L3EJ6eh+nOmjYzkcEPX
         3HufeRHJmJGuZjNBg20b6m2JBRjfs07o8a5Bk7gLgJd9Wkgo/igesWj2J/lL4DmWu1Xo
         D6QBBQr7ItBJR3MpaiibvBgxcml12KtzaXjxkyYZWs4V8z+VYxpj0VjOGdQ6QCPuUAOj
         k6dcy9rPXcsbUatfzWCJcsJTfiqhbexeyiE4tryrC6H8t6DF3EhKpbEU9UsyMMBtYS3g
         lGCt9jOYO5NaI2vGcqCZiKnaUEmRUvwFNBB22DvMzq4W/0tri/XrdSQgGklytnuNGdIi
         uu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779189755; x=1779794555;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1U4HETeGQHn+t9ZlydfwnmW4BLrbZCxQ7ZyTEEws6I=;
        b=lr+py5f6E3sr0jtpb1Bnni2CIgT+io0PdjWL8N+AYRPE7hXBe9Vx4yMdSzcRWkCvWX
         +KRkVXxWwW+9UyN2e6K7kDAdg6VdnKxKy9pWaLX8cQELQjTDN5OwIK3K5Zca8+YNbZNR
         j1Pr8Y6ryGkVDLdzDZCvNU7tXn6/2nKPYtsxzSVWBXf3j6k8LHiarXhmP2CfoOhlpYQq
         +wUiy2COb2nHM6kBy0xPfr+D1UmULLTLb+gXDvdm8eCT/KgE8HNWayIrhOgkkZHiGmh6
         hz2lNoWdR3BbrAHmBjuXEvTb/oxcs29a956xryc+97hsiOVxe81WCwlJkDtwTMMlUj3e
         YZLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/H6xYEu8hs13bLn15c1CpwjRtihVgbhix1GI7cY2w02MPIkxUNXDgpJ9PNCJ74uupoFKlVVDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4hvhbZe4UYOSu16Ump2QZ8LdiwGiO0dyFOIo12z0hipxdf2L
	fv1WhtyV7jjHNoMzbB51HLh2UUt8lNOQk+4jFP6OyuWG0G6tNHYL3XvWEusF/rvBZis=
X-Gm-Gg: Acq92OFIujiF3naZ5GIzXHJb67dYWq7v6ceKMXjeN2G1k2BVAaCotZ2edQS3aIJorwk
	QkxKf2P5FXGIvgFkHlJGxKYPk64lmC9QHHy8VJj8l4SkKQ7eijMPyxAgKg47ALsnH7lgYLBZPI+
	ozoJe+49L6/Sdk8zuy/O8RIVWklEbFvNJ2KEA8MUOV0BsTCo6VwrKatwyUaLp4NO3GEy7kXYb1d
	5rSd53uc9Bw/7hFGBUs1I/S4I5wrPvMNq6AKQY2/6ojUcmTg7L4RlKE1mQIA6c58aKFPBpVzzJr
	KIym9X5SihdjaB0KU/0Ujw5fUdOdnvZm8UuYqmBgR8XiLxOoBNZ88V9Sog/67fVC4B5E94igMOS
	aFEIYa38t716uJ1+xeO8vKRFo2lq/+Dvd7cV+PkbdqoIG3OsL7UfPnVXmGrvh2dN7cwSHxN30gX
	rElxKhoCaO2W0p6MxtatwXVRVpqA==
X-Received: by 2002:a17:907:c986:b0:b9d:e301:20db with SMTP id a640c23a62f3a-bd517906719mr867512166b.25.1779189755116;
        Tue, 19 May 2026 04:22:35 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ed37ecsm693190766b.63.2026.05.19.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:22:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Qingfang Deng <qingfang.deng@linux.dev>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
In-Reply-To: <20260519095557.3749407-1-yzjaurora@gmail.com> (Zijing Yin's
	message of "Tue, 19 May 2026 02:55:55 -0700")
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
Date: Tue, 19 May 2026 13:22:33 +0200
Message-ID: <878q9fod8m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289414-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,pastebin.com:url,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 69A8657DA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 02:55 AM -07, Zijing Yin wrote:
> netif_rx_mode_run() fires netdev_WARN() when netif_addr_lists_snapshot()
> returns non-zero. The only path to a non-zero return is -ENOMEM from
> __hw_addr_create() failing its kmalloc(GFP_ATOMIC) -- syzkaller hits it
> via failslab, and it can also be reached under real memory pressure.
>
> This is the only allocator-failure site in this file that WARNs.
> __hw_addr_create() itself, and every other caller of it in this file
> (__hw_addr_add_ex(), dev_uc_add_excl(), dev_uc_add(), dev_mc_add(), ...)
> just propagate the -ENOMEM silently. GFP_ATOMIC is a may-fail allocator;
> callers are required to handle NULL, so a returned -ENOMEM here is an
> expected runtime condition, not an invariant violation.
>
> The miss is self-healing: any subsequent change to dev->uc / dev->mc
> (every dev_{uc,mc}_{add,del}, IFF_PROMISC flip, etc.) calls
> __dev_set_rx_mode() -> netif_rx_mode_queue(), which re-queues the device
> and retries the sync. The only cost of a failed attempt is one stale
> rx-mode window until the next update; nothing in the kernel relies on
> this attempt succeeding.
>
> Demote to net_err_ratelimited() so the condition stays observable in
> dmesg without tripping panic_on_warn.
>
> Reproducer (syzkaller .prog format with setup notes): 
> https://pastebin.com/t7AQKx9v
>
> Fixes: 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work")
> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
> ---
>  net/core/dev_addr_lists.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index d73fcb0c6..c6fdcac74 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -1275,7 +1275,8 @@ static void netif_rx_mode_run(struct net_device *dev)
>  		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
>  						&uc_ref, &mc_ref);
>  		if (err) {
> -			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
> +			net_err_ratelimited("%s: failed to sync uc/mc addresses\n",
> +					    netdev_name(dev));
>  			netif_addr_unlock_bh(dev);
>  			return;
>  		}

1) I'd go with net_warn_ratelimited() instead. The promoted message
level in syslog might cause operational pain, and as you say the
condition is self-healing. Seems unwarranted.

2) Since it has a Fixes tag, should probably be sumitted for 'net' tree.

3) Was this reported by syzbot? If so, there should also be Reported-by
and Closes tags.

