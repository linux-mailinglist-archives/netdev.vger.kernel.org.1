Return-Path: <netdev+bounces-75029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CD867C61
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77DC1F26030
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F812C7F8;
	Mon, 26 Feb 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NqBCeABa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55C60DC6
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966022; cv=none; b=Xy/LqFC4hKV45jf/W9iUj+EarIpQJIj8a27uti5BkO4AT0T+av1+1kIiuBevQU3hCmoZWiE+x83QAyDqQ67o4Bwc6l8Zw+YpQ35gt6VJB4hplBC0Sj0lHqX0y3QbSU8HHpOE4a2y2b1r7HcG2RnKsKcG2NfJznT7Uvc9FRvcJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966022; c=relaxed/simple;
	bh=aMTbbaUzKxEM2wfy0oX+MiURE0uRO37Yfa5FEz9dbSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtjuLaMnd4kVj/PuIBztzkzFenW3Z0RS7bDddkNOs85biosjNpodKWbrXuIJI4FASd/0FDNjVgkDnCBcl+QNiXRAAu3oi7QUtIuaQ8MJTWZ6HPYIxduZRj7Jvz8yGaCdcPhJMKLDwDqLlo24Kdjeu9rjTd578zXc5vJdzR6WRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NqBCeABa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33de620be53so157514f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708966018; x=1709570818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpfxxTGl/NjEbPWA0gm6Yhz622RJLUP0+Vy7SrxZH7s=;
        b=NqBCeABaE3K592tcdPpMhOH1tkCxsQbMrYGfx5wJUxofCiUtJT/7V9DViuClbIG40M
         gAm/DgLUxuOH2xjZKwwmsJQ+hAEeVJCebw2hF3wZXN49p7mUNNFvasXCxwWIW+gcXeco
         og+mKbiJsCp94NoOGnBbJGM+9X5UGTteNkZSUu9KpcgNGFRGtxzYnuenw19GaaxW86YV
         tWOmnOpENTLFhv+nN2qBWCOGvJzxEA0BLxQH73m8Rm1TuNZ7+jF6fqS+T0rxNFC2xcgn
         HhfQEaV6hktAaK4T8SaKygsUvbGlJrS1yddWG4fY0EcUCstBqIj3UuJz2JzikJBy2OK7
         wOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966018; x=1709570818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpfxxTGl/NjEbPWA0gm6Yhz622RJLUP0+Vy7SrxZH7s=;
        b=lVNFUdDKfUsiOEHqWgp4peKHC09QlJrJV3675Nzoia+478bZ4v9g2VMHxZCaXZVXid
         2bY5q8j3j5g9xmIAE/qvy1JKYC8JWbg+QpgO/bpTm8MoEc21KDNAvoBFkfJjOlXl4bKd
         370vXwGMCGrtb70XjEwFBmQb4HM6ndpFZZukN/CHLB6+Mb8xVN1IN8G0tBRvYkNEE2jN
         0Fq8MJuM5bvZzMWdR0RqoIMslCwWRttnw3o2lwYOAKTl9XnxNvZsgxNwH05Geki3EOZa
         Chiv7EA/fxlkVoR7uQank3AqsPqowLSsVirG/nNEWHIM/gfRsULW0u3/H9QuQ9IFm1dM
         inKw==
X-Forwarded-Encrypted: i=1; AJvYcCWh9P85k+YU/AnOQ6Enhbsxw38I23MY6s+EULBI80SHlm6aUknJDU7irRjAfw1bwe0AyNmipsKKF+8Em3n4//SSCXK6sAC9
X-Gm-Message-State: AOJu0Yx3EOeGHxvmCKQjTBxozwyO7KLfUyIh4eiQ6mq5XfYdJ6uaKdfQ
	gnyDjliCgaPS+UTpln2aVa7aG6MR+widMwj5iRxL0F+broxVEYW69AzEcUTMEwA=
X-Google-Smtp-Source: AGHT+IGkCqmVxaV9KClfzagoI477dboOskk+p5d7HHaf2mwsqb9lOoONU1inUaEb2pNdT1OB3PTotQ==
X-Received: by 2002:a5d:64e6:0:b0:33d:d8d1:2353 with SMTP id g6-20020a5d64e6000000b0033dd8d12353mr2476873wri.62.1708966017961;
        Mon, 26 Feb 2024 08:46:57 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d538e000000b0033d4deb2356sm8702617wrv.56.2024.02.26.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:46:57 -0800 (PST)
Date: Mon, 26 Feb 2024 17:46:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 02/13] ipv6: annotate data-races around
 cnf.disable_ipv6
Message-ID: <ZdzAfhZgY7MuQBj0@nanopsycho>
References: <20240226155055.1141336-1-edumazet@google.com>
 <20240226155055.1141336-3-edumazet@google.com>
 <Zdy3tnU-QZUda0HI@nanopsycho>
 <CANn89iKM1yJ-uUtZ+uRkVdir8vbck8593RAxZt7fzNvFHU5W_Q@mail.gmail.com>
 <Zdy54LUdeUGH2OuB@nanopsycho>
 <CANn89iLXrjT=JpAJNuvtqTxPC+jKto8+j62KOd5nPk25QqoOAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLXrjT=JpAJNuvtqTxPC+jKto8+j62KOd5nPk25QqoOAg@mail.gmail.com>

Mon, Feb 26, 2024 at 05:24:19PM CET, edumazet@google.com wrote:
>On Mon, Feb 26, 2024 at 5:18 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Feb 26, 2024 at 05:14:36PM CET, edumazet@google.com wrote:
>> >On Mon, Feb 26, 2024 at 5:09 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Mon, Feb 26, 2024 at 04:50:44PM CET, edumazet@google.com wrote:
>> >> >disable_ipv6 is read locklessly, add appropriate READ_ONCE()
>> >> >and WRITE_ONCE() annotations.
>> >> >
>> >> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >> >---
>> >> > net/ipv6/addrconf.c   | 12 ++++++------
>> >> > net/ipv6/ip6_input.c  |  4 ++--
>> >> > net/ipv6/ip6_output.c |  2 +-
>> >> > 3 files changed, 9 insertions(+), 9 deletions(-)
>> >> >
>> >> >diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>> >> >index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2ec223b3331c3598ded6 100644
>> >> >--- a/net/ipv6/addrconf.c
>> >> >+++ b/net/ipv6/addrconf.c
>> >> >@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *w)
>> >> >                       if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
>> >> >                           ipv6_addr_equal(&ifp->addr, &addr)) {
>> >> >                               /* DAD failed for link-local based on MAC */
>> >> >-                              idev->cnf.disable_ipv6 = 1;
>> >> >+                              WRITE_ONCE(idev->cnf.disable_ipv6, 1);
>> >> >
>> >> >                               pr_info("%s: IPv6 being disabled!\n",
>> >> >                                       ifp->idev->dev->name);
>> >> >@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
>> >> >               idev = __in6_dev_get(dev);
>> >> >               if (idev) {
>> >> >                       int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
>> >> >-                      idev->cnf.disable_ipv6 = newf;
>> >> >+
>> >> >+                      WRITE_ONCE(idev->cnf.disable_ipv6, newf);
>> >> >                       if (changed)
>> >> >                               dev_disable_change(idev);
>> >> >               }
>> >> >@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
>> >> >
>> >> > static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
>> >> > {
>> >> >-      struct net *net;
>> >> >+      struct net *net = (struct net *)table->extra2;
>> >>
>> >> How is this related to the rest of the patch and why is it okay to
>> >> access table->extra2 without holding rtnl mutex?
>> >
>> >table->extra2 is immutable, it can be fetched before grabbing RTNL.
>> >Everything that can be done before acquiring RTNL is a win under RTNL pressure.
>> >
>> >I had a followup minor patch, but the patch series was already too big.
>>
>> I see, so this hunk should be part of that patch, not this one, I
>> believe.
>>
>
>If I send a V2, I will add the followup patch instead.
>
>IMO this is a minor point.

Yeah, it is minor.

>
>Thank you.

