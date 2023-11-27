Return-Path: <netdev+bounces-51212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438287F9A46
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C8F1C204F5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 06:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C4D2E5;
	Mon, 27 Nov 2023 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2j+DNWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E812F
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:54:47 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cbca33ad5dso4114559b3a.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701068087; x=1701672887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4qZmOs2gE4M14udfczic0iE0Bphhysq58amkIjCFQc=;
        b=K2j+DNWPomRbPC3d91ummJX4Lc+VvKDGV6Hl/NnwLDuiK8LVajmxx+Mbw8rde2JC/r
         8lh+l7z4Tq+SV95kvr9NttbLGdcFEh6LPT9b9t9sq8SFFaqMmjwG2KXvTO9XfAGgUO44
         euQFxbUYj5UFapsK4pX95Buj8oJM9lL5SMPTJAgIjQX2Wt2ysluzcZAueB7M7uP8ZXk8
         BlQBfsEgMX3nw0zknGkff0gM6dntbkrGgyz6t6IDzx30fEsr5ngRAmJdMFlN4HYvgZcr
         BN88TzVGtNhizzFj6OAEq2C3ZVF8Hj4zbG8oa0ww3NQYqEfm6pE5D1y8vpAFgXRP41ly
         5C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068087; x=1701672887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4qZmOs2gE4M14udfczic0iE0Bphhysq58amkIjCFQc=;
        b=Nr+N64dhI6a535HE9pzvg6Ojmm/IKlASVZMKi9+86bmfCD9zI8WtR89pVsYPRcfLMk
         PrpP7A54dk3AMVzWUa2f1fg6R0kzm4rTrk+osqDp2xP3C1jB+NzTIFYBFWa+jJMnMCKm
         ddBBmQBRwfHm8yqp/xvvCyDKLhVCCA1E2JGRGtbPGpOMCegl82zx7XKKyK6X/MIhqsFl
         RCMPxMgXmRARKZEpYFwRbSX/mm8JdMc1W9giBEqs3KpT3/XPfgPzhFKN/UFF4xsCf2mk
         9QWbTG74/Qb10sXSigSZkUQpbBfHd4Lodpz4HMvkRiayVRo0z6ooKBOxaHjxWX0oiJ53
         S6Hw==
X-Gm-Message-State: AOJu0YzsyyrpncIJw6sbXLe6I8K3sy5lTwAEoctsmM5Cu87SwhVCY80L
	mMWBYL8I8W53XyaPmLAkVBMNp4CHAd07/A==
X-Google-Smtp-Source: AGHT+IE1QsjfRtI1hWvHOL7jMMXr3z67JhuYAeHqJJKA8t2yiOwcrlW7zq20lyCX86BcpkrR7hKHCsnBVVmUkQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:23d6:b0:6c2:dead:dbe6 with SMTP
 id g22-20020a056a0023d600b006c2deaddbe6mr3900486pfc.0.1701068086714; Sun, 26
 Nov 2023 22:54:46 -0800 (PST)
Date: Mon, 27 Nov 2023 06:54:44 +0000
In-Reply-To: <20231126144300.18a05ea7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231125205724.wkxkpnuknj5bf6c4@google.com>
 <20231126144300.18a05ea7@kernel.org>
Message-ID: <20231127065444.6ysqni5pt5jfnimf@google.com>
Subject: Re: [PATCH net-next v3 00/13] net: page_pool: add netlink-based introspection
From: Shakeel Butt <shakeelb@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com, 
	willemb@google.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Nov 26, 2023 at 02:43:00PM -0800, Jakub Kicinski wrote:
> On Sat, 25 Nov 2023 20:57:24 +0000 Shakeel Butt wrote:
> > > $ ./page-pool
> > >     eth0[2]	page pools: 10 (zombies: 0)
> > > 		refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
> > > 		recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)  
> > 
> > Hi Jakub, I am wondering if you considered to expose these metrics
> > through meminfo/vmstat as well, is that a bad idea or is this/netlink
> > more of a preference?
> 
> If that's net-namespaced we can add the basics there. We'll still need
> the netlink interface, tho, it's currently per-interface and per-queue
> (simplifying a bit). But internally the recycling stats are also
> per-CPU, which could be of interest at some stage.

Not really net-namespaced but rather system level stats in those
interfaces. Anyways if having system level makes sense then these stats
can be added later.

