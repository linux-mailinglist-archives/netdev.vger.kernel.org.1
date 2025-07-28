Return-Path: <netdev+bounces-210421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F774B13361
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41413AF358
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0660DCF;
	Mon, 28 Jul 2025 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYrN5tyO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33882AE97
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672849; cv=none; b=i8mXShMJTo37L4291RSNsGR0TMaa7k4P7xUVVw6TMrI14hlkigFJJYnen+5uoV1BW6d2fiR2Zn6PU8c+AT23WilWTOLaSBQMuw4oRmtHVrFkneXfMHmrDIbPoC2sCwqjHFw6eNxOyWgphX2k31IqPgEhMX/W6DosLfMJp6UEKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672849; c=relaxed/simple;
	bh=15aThoYhzoxdtKRx9/AWEF8DdcN6+PhQOQX9PsPxfmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPwpa9HiIZQw/0aWlIoJqz1Poog6V21R3xpbOyGBet8nP3gzwuQ9Ga+BNnd8WD0drbnNmZ/i3JKEwVjomV/wWAU0gWF9jbXm/3scSTQDB8+5m9Xf+y+wpaq4//v4dQN2tmeCZVfg8rLXjT2TMdhIaahNasH8KIyZksQVi4SP2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYrN5tyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753672845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR5ChySwuOoNU8WWHST/by+WmVyKoXvqxHdmj8YIWY0=;
	b=eYrN5tyOtebWjgvrQYEac046XET/GEsPNqtZ24c/Mx5GXl4UZwgICfZ5sempZU/3odi8y2
	EGUkhq18pDmNZqvOoZZrTrNcfXPZs1inY+TJBYB5x9TTl7Sb9nOb4jE0cdpFCUzwIHWinI
	XfBBhg0JziBEJrXm32ayMRMvtGW6SY8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-pEkNdEQQNtC-fmcQn26oSQ-1; Sun, 27 Jul 2025 23:20:43 -0400
X-MC-Unique: pEkNdEQQNtC-fmcQn26oSQ-1
X-Mimecast-MFC-AGG-ID: pEkNdEQQNtC-fmcQn26oSQ_1753672843
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31edd69d754so659875a91.1
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 20:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753672842; x=1754277642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR5ChySwuOoNU8WWHST/by+WmVyKoXvqxHdmj8YIWY0=;
        b=iBeOYOIZ7V5m1g5u/7B/TzKRK9pbyQQbIEP6z6mWEGC1ITysTwKFNk0DBzqgsBntbc
         17ooTMXX6QGWGdd80PM3C/MbYZJDU/9WLGOdhowvIRlCRFtovazULDsq6dlJ5u/+4Dj4
         O20SSiD27b97pvUN9MywlztWOS7vgktwkTgMDPQD52mxZiDJaR4art+P1k9SSWTSWP3d
         QAV4wLdAdp8QT13Y4Ur8GVu5p3SO9izy/VUCV3quobtV4tVi1W8rWelsqiSCUVYoaZN1
         5hhJ/2nZ8BJjT2Z5k5ulf6G3r5AHHc4NXZ5Bc2ujTmfTpMnLVntF8v9ObG/iwENbKOxa
         2/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNPx6OFieUzbAxF78yjaSoseubpqv+GUPchPG01MQABwxMCaQhVaiSw5ZdOomPH849FV/9iTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDrnYil97tPHsuMR9glAPBcJd7Y79C0jwTYDcmDTZrtbgaiae
	hUzUJ39hBKA9bn6dA2DgUEsZLphmDStVVPKhFeuBKKU2rrttY51XoXS6Q43vroZV6kdYINhS50V
	e3/osqJP4rOSxHw1INveMcsIy7J8pFEUnquAtfrBqZZu7l8uRko4spSmhSX3QQuYLM2kAsOMula
	G5JF4NkLMJbb6synIfc53JaCMPLG89qTpg
X-Gm-Gg: ASbGncsTfpWEv9uj751YE1e9K+X+vs8gojcqKsYSMU9EGvYjlGodVnpeE7nZVK6iMg1
	gymsGGZgzhR6XslY56ZZC8/Jj/r5WLUrMI3WWWT98qaZUWSTC+IUC7uuP6OFsKUpd6cWUTP6KoF
	LSwEKkGJeefy0fYqrwvpg=
X-Received: by 2002:a17:90b:1a84:b0:31c:3872:9411 with SMTP id 98e67ed59e1d1-31e77a2016bmr16652762a91.33.1753672842473;
        Sun, 27 Jul 2025 20:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAqqwiTKZ1k6xyMPcG42f+LD68olHodIchHgf4d4SWVgRBCB8r8cAX9tUvXUmGrbZcChZVuFveu9GSRCmon1A=
X-Received: by 2002:a17:90b:1a84:b0:31c:3872:9411 with SMTP id
 98e67ed59e1d1-31e77a2016bmr16652739a91.33.1753672841989; Sun, 27 Jul 2025
 20:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726010846.1105875-1-kuba@kernel.org>
In-Reply-To: <20250726010846.1105875-1-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:20:30 +0800
X-Gm-Features: Ac12FXxZ7m7tyk_9wVgK1BrIwcTzksoj1OgtRrSSKsyAiorgpSJrAPrBYchlCP0
Message-ID: <CACGkMEuApQn4PPB+H7du7icS16s2Q0c4ee=Gt2gjxVLai+6Bug@mail.gmail.com>
Subject: Re: [PATCH net v2] netpoll: prevent hanging NAPI when netcons gets enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Zigit Zo <zuozhijie@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	leitao@debian.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 9:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Paolo spotted hangs in NIPA running driver tests against virtio.
> The tests hang in virtnet_close() -> virtnet_napi_tx_disable().
>
> The problem is only reproducible if running multiple of our tests
> in sequence (I used TEST_PROGS=3D"xdp.py ping.py netcons_basic.sh \
> netpoll_basic.py stats.py"). Initial suspicion was that this is
> a simple case of double-disable of NAPI, but instrumenting the
> code reveals:
>
>  Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
>    state: 0x37, disabled: false, owner: 0, listed: false, weight: 64
>
> The NAPI was not in fact disabled, owner is 0 (rather than -1),
> so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
> (!list_empty(&n->poll_list) =3D> false). It seems odd that normal NAPI
> processing would wedge itself like this.
>
> Better suspicion is that netpoll gets enabled while NAPI is polling,
> and also grabs the NAPI instance. This confuses napi_complete_done():
>
>   [netpoll]                                   [normal NAPI]
>                                         napi_poll()
>                                           have =3D netpoll_poll_lock()
>                                             rcu_access_pointer(dev->npinf=
o)
>                                               return NULL # no netpoll
>                                           __napi_poll()
>                                             ->poll(->weight)
>   poll_napi()
>     cmpxchg(->poll_owner, -1, cpu)
>       poll_one_napi()
>         set_bit(NAPI_STATE_NPSVC, ->state)
>                                               napi_complete_done()
>                                                 if (NAPIF_STATE_NPSVC)
>                                                   return false
>                                            # exit without clearing SCHED
>
> This feels very unlikely, but perhaps virtio has some interactions
> with the hypervisor in the NAPI ->poll that makes the race window
> larger?

Somehow, for example KVM can schedule out the vcpu that runs normal
NAPI at this time.

>
> Best I could to to prove the theory was to add and trigger this
> warning in napi_poll (just before netpoll_poll_unlock()):
>
>       WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
>                 napi_is_scheduled(n) && list_empty(&n->poll_list),
>                 "NAPI race with netpoll %px", n);
>
> If this warning hits the next virtio_close() will hang.
>
> This patch survived 30 test iterations without a hang (without it
> the longest clean run was around 10). Credit for triggering this
> goes to Breno's recent netconsole tests.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat=
.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move the sync to netpoll_setup()
> v1: https://lore.kernel.org/20250725024454.690517-1-kuba@kernel.org
>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Zigit Zo <zuozhijie@bytedance.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> CC: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> CC: leitao@debian.org
> CC: sdf@fomichev.me
> ---
>  net/core/netpoll.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index a1da97b5b30b..5f65b62346d4 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -768,6 +768,13 @@ int netpoll_setup(struct netpoll *np)
>         if (err)
>                 goto flush;
>         rtnl_unlock();
> +
> +       /* Make sure all NAPI polls which started before dev->npinfo
> +        * was visible have exited before we start calling NAPI poll.
> +        * NAPI skips locking if dev->npinfo is NULL.
> +        */
> +       synchronize_rcu();
> +
>         return 0;
>
>  flush:
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


