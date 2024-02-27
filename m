Return-Path: <netdev+bounces-75379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BDD869A7D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78C81C2309A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7514534F;
	Tue, 27 Feb 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LLGYtntJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359631DFF5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048175; cv=none; b=Yfwjj+yH4QdvjdQiAtmyHNQLv0UGEboQgq0ZdVpTq9bbZJkTdsr6TPALzvFCNcZxPR+c1OCLcjCEF9wqvfoNaN22v6Du0E+uA1M0IYYeOcehqjcQJRANXOg7eA+CNTTwFLm9LiHlPQV8huRFRY70TyUg1tAMGB7rWh3ZiliERs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048175; c=relaxed/simple;
	bh=MTXVSoXCe3+NiM6pFapT2t15samHUEPGBgyp7Bps65I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1ApQikhNvFJujSXR2EURAWKaTP3jLBJ3x5ThLAfj0GVtua24NthVItchTxpwQbJytC0jJt2Em8X2IRKrHoSz1tZnzBjVf6kYLheWpYQS+BSwUNmDl2PyH6ONh7Hjq5ro1JTfGnGXXfi9pqXB2FF8lIa9uHae6WycOMPNGVW5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LLGYtntJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a4848f0dso16269715e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709048171; x=1709652971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ3MAbvmJmzaq8Lwhna7tgCbWBoA4wKd3GYIZXywM8Q=;
        b=LLGYtntJZJNni+NaIl7aCEyEQaL5PRpsNO6AZsu7zBNLW3kJeRe0oBWzgrZSpdZGG4
         sM48safeKzxBm+BK4B3vNfM8x7h5LdSCdOBfrPMy0q0/4MxF8yboa1Ruz7TWIR8zMf2P
         raJ5uFkEDjU+phHVr+pY3Z8HJ1x6NHsZwg0505T85ZT4e+t5LpWQw2qfecdfi643J+nz
         MoaPz0QDFZdDNH+VsjThAPej5rbaVrDEGDosentFibG7fhjTCUGqmySVZgPMiotm4B59
         Ld34zSHc9QMS+3dlDq76lhbJsozoboEwzA5zdE0Xg0quPf557LhQ772QcHGfimmkPpy7
         DDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048171; x=1709652971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ3MAbvmJmzaq8Lwhna7tgCbWBoA4wKd3GYIZXywM8Q=;
        b=LzaRRYPUNYdUFSEDGmMEPPivZxPpV3s435j9w4coqc7LQrlPjKLq1CkFy2zm/LeAqv
         c9rEQ4CIaIA1nZ+0NzdCbm8vKv+yx6OH2wUHyTSxnnPVe4rNg4FuG2FggAsPHZPf3maV
         Kv5v0iupvkx3zTyPik45T2gUvIQH4iMplmseQKOvf1jaeaIV4glwzaCaNf4iwOy5lHW3
         icG0mB2yD5LcQhUau7WRb5STXCjiE+I44zu9OlNi67sBiuc00GYqwxA5QsucOQ81QOUA
         BJ9gdcg3CoxAkoewE6CSZE9S2VdvbNC+5GoiZx2Gj1D0onPbQyi7TcyawyrmEFWUbxbM
         eM8w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6LuDYlqunoy1wziw+MfRqp5ziZZhOqcD+BzD1b1Wa91Fjhh1JybX1Q/QJEq7OH3nNrUbJdud+szddaehD8JYej5SHo7l
X-Gm-Message-State: AOJu0YyNiKxinISpg6ouojBtDioOzi/1JWS7g6m2Rhp9ossHXWeR5HHo
	pAgKTriqdD3TDuS441/97Y5LrLrnLED15v7F/5JMJ/TrRDI7xnDz9FrgbBaznik=
X-Google-Smtp-Source: AGHT+IHCmRXTEATu3W2ZdTUl6L02Xzo83GSXeI+XpfMPo1e0OIhynh3xqHDOw6BXMrLwFgu7v+nO/A==
X-Received: by 2002:a05:600c:a002:b0:412:a498:ad36 with SMTP id jg2-20020a05600ca00200b00412a498ad36mr4920595wmb.20.1709048171366;
        Tue, 27 Feb 2024 07:36:11 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b004122b7a680dsm11760534wmo.21.2024.02.27.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:36:10 -0800 (PST)
Date: Tue, 27 Feb 2024 16:36:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 00/15] ipv6: lockless accesses to devconf
Message-ID: <Zd4BaDVZltdcpr1S@nanopsycho>
References: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>

Tue, Feb 27, 2024 at 04:01:45PM CET, edumazet@google.com wrote:
>- First patch puts in a cacheline_group the fields used in fast paths.
>
>- Annotate all data races around idev->cnf fields.
>
>- Last patch in this series removes RTNL use for RTM_GETNETCONF dumps.
>
>v2: addressed Jiri Pirko feedback
> - Added "ipv6: addrconf_disable_ipv6() optimizations"
>   and "ipv6: addrconf_disable_policy() optimization"
>
>Eric Dumazet (15):
>  ipv6: add ipv6_devconf_read_txrx cacheline_group
>  ipv6: annotate data-races around cnf.disable_ipv6
>  ipv6: addrconf_disable_ipv6() optimizations
>  ipv6: annotate data-races around cnf.mtu6
>  ipv6: annotate data-races around cnf.hop_limit
>  ipv6: annotate data-races around cnf.forwarding
>  ipv6: annotate data-races in ndisc_router_discovery()
>  ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
>  ipv6: annotate data-races in rt6_probe()
>  ipv6: annotate data-races around devconf->proxy_ndp
>  ipv6: annotate data-races around devconf->disable_policy
>  ipv6: addrconf_disable_policy() optimization
>  ipv6/addrconf: annotate data-races around devconf fields (I)
>  ipv6/addrconf: annotate data-races around devconf fields (II)
>  ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

>
> .../ethernet/netronome/nfp/flower/action.c    |   2 +-
> drivers/net/usb/cdc_mbim.c                    |   2 +-
> include/linux/ipv6.h                          |  13 +-
> include/net/addrconf.h                        |   2 +-
> include/net/ip6_route.h                       |   2 +-
> include/net/ipv6.h                            |   8 +-
> net/core/filter.c                             |   2 +-
> net/ipv6/addrconf.c                           | 283 +++++++++---------
> net/ipv6/exthdrs.c                            |  16 +-
> net/ipv6/ioam6.c                              |   8 +-
> net/ipv6/ip6_input.c                          |   6 +-
> net/ipv6/ip6_output.c                         |  10 +-
> net/ipv6/ipv6_sockglue.c                      |   2 +-
> net/ipv6/mcast.c                              |  14 +-
> net/ipv6/ndisc.c                              |  69 +++--
> net/ipv6/netfilter/nf_reject_ipv6.c           |   4 +-
> net/ipv6/output_core.c                        |   4 +-
> net/ipv6/route.c                              |  20 +-
> net/ipv6/seg6_hmac.c                          |   8 +-
> net/netfilter/nf_synproxy_core.c              |   2 +-
> 20 files changed, 246 insertions(+), 231 deletions(-)
>
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

