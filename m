Return-Path: <netdev+bounces-75014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA76867B94
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED851C288DE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806512BF26;
	Mon, 26 Feb 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KFl9qRHV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5A1D531
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964328; cv=none; b=Wyx2rPDHtK2glPtoeKEnlTgGePWH8adUCXTLyFATr1MaHAyFZGxe7peqGAX2UqTxx/nULOtJ8afGdmUo5hXFKpwsKBdJlMsNZgIJSJlZtO7F4ZPKBA8+71SlcmJ88uA4kyHOCFtqfnk2pGzW4wMktAccp1nhmLy52IpOG1G4Hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964328; c=relaxed/simple;
	bh=cVMFlDAjYYZCeqUm/zd/bIXFG1PV+K8XgMDTxvBmSkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kChbb1mjWqL09Ao9gR+C6SlZkm7oeyGlOhfH55LUiV6lsPHZrpsLlpCKFjTTkPyGt58NzAZVTI+hYaBLXu2NAk75pGh7V5ncJJBQ8xkiXaQHaj65KzrmhWJH4Dp0QnEobn8U4GSzDT7Js7b8HzmUT/ooi203vSirKNuSNjcnF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KFl9qRHV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d204e102a9so38237661fa.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708964324; x=1709569124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m3dAbQlzNxdsg56bBl3njAXDWBnO1w63NnPff7rBsSg=;
        b=KFl9qRHV+OPdLo+GMRJztJ3Anqoc9M2xqoyR+SQcHOz2Vrrgb5ThaNNKL8JkQq4toh
         2jgWddvw1xsOKZ99x3tn5ySjNDkjorhTkpP4oveUdl12QjDMP3I8D2Ce88kIHw6uJuXo
         C675WHqnJXBaqGamYwW4TQ7m+6HI5a/gQo8dA1XD6/k741G8UyuAnB5XTxXAlYuG83El
         e8mXLR5Ya2mJN8HU0tpXEpVTn4Qy5BOaCJsqDTZNiP6ZskPJsm4Gp20e/496ncYUPsB/
         wdEfqaFj3rN+wFbtNwoS718oWi+SKqAuSg8sEWcTz2p38vG/iNWXxUhNoNeeVgCJdXO1
         P7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964324; x=1709569124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3dAbQlzNxdsg56bBl3njAXDWBnO1w63NnPff7rBsSg=;
        b=b9E/hXH4HoqpLURdkzqqyzeZsQS6BI7spe6bZ8DQpjunQQDYK7RLam/6pQQwu99npn
         GWsy6RtXNVo4l6kcxkfeWbHMhw90PDwBrKutJ4UmaTWCoQhDzlpeA2KFxUa+AzSYOioO
         ISG5Tee8t9iflqPx+ldQhOllA0bw/DXlDs0I4lkoBbmIacwdeXJy+K/URsMVbJJMfrIX
         suYqgCTHJslPzSY7j8sqSqAUPIJJcZI6fIecFRHXBlF/ekeGLwycNUiRxmtqkbCavZbU
         56Mpndb+ozeuz56gp2RwHU529OstFcTKCZm5+qzuAW5cqUnPHeNM2asqhSW+fo7EKaNj
         j1xg==
X-Forwarded-Encrypted: i=1; AJvYcCXk0DJapJ6OPPBH7qGkeckvxVnrkNhBv9U2Bl943aa4KpESc65gVkAOdRCn/jSm9S3QCYZ6GXtffFoDJtGKP27LQLrglfHq
X-Gm-Message-State: AOJu0YxrZgRy8TBOW1kW7mNJlCN1vU027MGjDluRX4vrqo/HxeJF+tQU
	rDNA0sFUS05xIxcGJNI/wAJDaWYWEk43svVZ9BH9YPrtrfvwfQZw0W8z5Yz+x3g=
X-Google-Smtp-Source: AGHT+IHRfZtHG8RS4sU8HhFYW1PIUZRKvd5Ksu+E8g90YM7Tl3nDIURZvuhwBkgNYjoEM+EmDAuxxw==
X-Received: by 2002:a2e:a545:0:b0:2d2:846e:aae1 with SMTP id e5-20020a2ea545000000b002d2846eaae1mr3702470ljn.30.1708964323890;
        Mon, 26 Feb 2024 08:18:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b00412a5a24745sm3122022wmq.27.2024.02.26.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:18:43 -0800 (PST)
Date: Mon, 26 Feb 2024 17:18:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 02/13] ipv6: annotate data-races around
 cnf.disable_ipv6
Message-ID: <Zdy54LUdeUGH2OuB@nanopsycho>
References: <20240226155055.1141336-1-edumazet@google.com>
 <20240226155055.1141336-3-edumazet@google.com>
 <Zdy3tnU-QZUda0HI@nanopsycho>
 <CANn89iKM1yJ-uUtZ+uRkVdir8vbck8593RAxZt7fzNvFHU5W_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKM1yJ-uUtZ+uRkVdir8vbck8593RAxZt7fzNvFHU5W_Q@mail.gmail.com>

Mon, Feb 26, 2024 at 05:14:36PM CET, edumazet@google.com wrote:
>On Mon, Feb 26, 2024 at 5:09 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Feb 26, 2024 at 04:50:44PM CET, edumazet@google.com wrote:
>> >disable_ipv6 is read locklessly, add appropriate READ_ONCE()
>> >and WRITE_ONCE() annotations.
>> >
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >---
>> > net/ipv6/addrconf.c   | 12 ++++++------
>> > net/ipv6/ip6_input.c  |  4 ++--
>> > net/ipv6/ip6_output.c |  2 +-
>> > 3 files changed, 9 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> >index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2ec223b3331c3598ded6 100644
>> >--- a/net/ipv6/addrconf.c
>> >+++ b/net/ipv6/addrconf.c
>> >@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *w)
>> >                       if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
>> >                           ipv6_addr_equal(&ifp->addr, &addr)) {
>> >                               /* DAD failed for link-local based on MAC */
>> >-                              idev->cnf.disable_ipv6 = 1;
>> >+                              WRITE_ONCE(idev->cnf.disable_ipv6, 1);
>> >
>> >                               pr_info("%s: IPv6 being disabled!\n",
>> >                                       ifp->idev->dev->name);
>> >@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
>> >               idev = __in6_dev_get(dev);
>> >               if (idev) {
>> >                       int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
>> >-                      idev->cnf.disable_ipv6 = newf;
>> >+
>> >+                      WRITE_ONCE(idev->cnf.disable_ipv6, newf);
>> >                       if (changed)
>> >                               dev_disable_change(idev);
>> >               }
>> >@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
>> >
>> > static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
>> > {
>> >-      struct net *net;
>> >+      struct net *net = (struct net *)table->extra2;
>>
>> How is this related to the rest of the patch and why is it okay to
>> access table->extra2 without holding rtnl mutex?
>
>table->extra2 is immutable, it can be fetched before grabbing RTNL.
>Everything that can be done before acquiring RTNL is a win under RTNL pressure.
>
>I had a followup minor patch, but the patch series was already too big.

I see, so this hunk should be part of that patch, not this one, I
believe.


>
>We do not need to grab rtnl when changing net->ipv6.devconf_dflt->disable_ipv6
>
>diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>index 08b4728733e3ed16d139d2bd4b50328552b3c27f..befe2709acdffdce8c6a3304df8dec598246a682
>100644
>--- a/net/ipv6/addrconf.c
>+++ b/net/ipv6/addrconf.c
>@@ -6398,17 +6398,16 @@ static int addrconf_disable_ipv6(struct
>ctl_table *table, int *p, int newf)
>        struct net *net = (struct net *)table->extra2;
>        int old;
>
>+       if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
>+               WRITE_ONCE(*p, newf);
>+               return 0;
>+       }
>        if (!rtnl_trylock())
>                return restart_syscall();
>
>        old = *p;
>        WRITE_ONCE(*p, newf);
>
>-       if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
>-               rtnl_unlock();
>-               return 0;
>-       }
>-
>        if (p == &net->ipv6.devconf_all->disable_ipv6) {
>                WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
>                addrconf_disable_change(net, newf);

