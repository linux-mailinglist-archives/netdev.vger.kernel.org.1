Return-Path: <netdev+bounces-154840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB78A000A3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5507B7A05B1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FD188006;
	Thu,  2 Jan 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHA85LYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994813BC0C
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853340; cv=none; b=AjYv0jm4ZrWPSbb5m90gOHnOOrhwvPpyF8Sk7ToiHZAL9wX8U4+UgO/rolfPvGyhYQJiRuhZlkloVjF3KX3Sz4QGGGJ0+/z7zvsfX9iu4JwHz7aIoF5cDLX0JNWH3dgI8BLvbdyikwfJ/Un4RGnas4dT/DlABw9OhJZRWxIq3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853340; c=relaxed/simple;
	bh=w75hdbc+/WUekb1/7vCfyCzT+ksIKYSLQpffOXQw/UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7levvvVqWBnO8v4FJPl7Wi5aP+rk0VFpUMfR6Gk5044PCv/onOCqG2Ke1jOXaF3wjSu7o6l3h1jMRVKQWKWIlXUKJpXPAeEpDLL46yKC+yHg7N99BVds0yOU2ofVlWDUm4ysriD2vAw/J4Q/f5SkY1NPxptretFKYelQNSLwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHA85LYx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2156e078563so139578815ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 13:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735853338; x=1736458138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7KQ2lF4mh8e9FYxaOXJjEpxzA2lcDF3HqklBOCY024=;
        b=OHA85LYx3jZwpPRTgsCjT1kalGKCbcDGGIw/P0hggvCxFlfukOvIdte/NcGTC02PA2
         rpFK19om3o2w9kfBpcG+uDb0vNp44dqgAwg1znOZ8qvoa+MBTkrZ/enn3oeyM5wFQOX+
         483plVjFmLLHTP3ge/DfmiJ9kXYNahbbXNb+wPqev/rxSy5Vb4CSpKzolBvGT3HPmxdz
         c6v/NhvizibssYgsh0jtlIjS8K3nX/sfjReJ8kosOaJMvqTwBxTtDaLLE6TXr7yDV07m
         gir4XuSYALANM73inQebrmGPdic6ynfkqBGJBppETXhDQG7rCKEYwP4/BvPTYiKVUZ6R
         iUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735853338; x=1736458138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7KQ2lF4mh8e9FYxaOXJjEpxzA2lcDF3HqklBOCY024=;
        b=whEgM9w36ZPtOFkIiZywSdOzipexY48UezCYaUdBznCF1M/+ZEHZdo5nbwAwKcGcCV
         ZLorHF7WUVX4FAFmhQxYkVfgJJKM/qG6g1nJc3rDomNGK3s8EA/aTd1RofMnXp38c8K2
         b4LoRVGlfVfTYq52W1AejySetNsUimcLH1u2hpF4J4xPlk6nsES2mcaC+QFg1h36H159
         PVqJ+VExmdOkYznTI9H0qNQon46dFMN5mq9NaL4zNuzCTzEuectWa1YCYIbl82K7CAPr
         fgP4ixzs0XLXvjvVMGvC98Pvi6lSTdz2VhuVYABKQr8ok+Kr8s5IHvxWJxiGr/in/Jaw
         wlrg==
X-Forwarded-Encrypted: i=1; AJvYcCUjdLt10byz6R3oI9NEVBOqVkgvL/xxb+XaUWBkKBtjB4ODfihyGrxWaIuVZDvgloigBVZaO8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FlH158teEzpzr4JhF5xbr2mO96jKFpGMvZa+LS1N98wwu7zJ
	fDAJl+dg+eEaLu7ZsfRzllx5vsZItRy5bdjqWt5+1hqrrcuWipc=
X-Gm-Gg: ASbGnctQmpOeEdJl9v8p9a2bUVl29u55dbBaps/s0m/xdaWCP0q4aOzxwTuzwnDSNKd
	5w05Qb/rXMtJdT9mCiJhidPdOzQ1JvMkQaVKv46cE3t2mkp8cvrzhZOYDQvZG3Fyu4oc0nmYKoH
	JMZixyVpss//oBI0SvflK4LU5zDBeEYlsm+52bgEhXPVm+R9DLZrB8bVD9cEyBFocgHrvI3XSGd
	WOqMdw1wkuAkOAg7irmr9Pcbso/LEy45jtvNeEKTMUbi9i1+UOPaWEi
X-Google-Smtp-Source: AGHT+IEJWnu3J3r3XuDAsYpYeLQW2VbVIV6NXzwtuqDGlHovgIVl7Y8UQNKyS79ZSq5Hqxz18aeiMg==
X-Received: by 2002:a17:902:db0f:b0:215:9379:4650 with SMTP id d9443c01a7336-219e6f10958mr741353395ad.42.1735853338238;
        Thu, 02 Jan 2025 13:28:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02509sm233943155ad.253.2025.01.02.13.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 13:28:57 -0800 (PST)
Date: Thu, 2 Jan 2025 13:28:57 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <Z3cFGZ2vuzkO0EcJ@mini-arch>
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102191227.2084046-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102191227.2084046-4-skhawaja@google.com>

On 01/02, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
> 
> - STATE_THREADED_BUSY_POLL
>   Threaded busy poll is enabled/running for this napi.
> 
> Following changes are introduced in the napi scheduling and state logic:
> 
> - When threaded busy poll is enabled through sysfs it also enables
>   NAPI_STATE_THREADED so a kthread is created per napi. It also sets
>   NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
>   supposed to busy poll for each napi.
> 
> - When napi is scheduled with STATE_SCHED_THREADED and associated
>   kthread is woken up, the kthread owns the context. If
>   NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
>   then it means that we can busy poll.
> 
> - To keep busy polling and to avoid scheduling of the interrupts, the
>   napi_complete_done returns false when both SCHED_THREADED and
>   THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
>   early to avoid the STATE_SCHED_THREADED being unset.
> 
> - If at any point STATE_THREADED_BUSY_POLL is unset, the
>   napi_complete_done will run and unset the SCHED_THREADED bit also.
>   This will make the associated kthread go to sleep as per existing
>   logic.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net     |  3 +-
>  Documentation/netlink/specs/netdev.yaml       |  5 +-
>  .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
>  include/linux/netdevice.h                     | 24 +++++--
>  net/core/dev.c                                | 72 ++++++++++++++++---
>  net/core/net-sysfs.c                          |  2 +-
>  net/core/netdev-genl-gen.c                    |  2 +-
>  7 files changed, 89 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
> index ebf21beba846..15d7d36a8294 100644
> --- a/Documentation/ABI/testing/sysfs-class-net
> +++ b/Documentation/ABI/testing/sysfs-class-net
> @@ -343,7 +343,7 @@ Date:		Jan 2021
>  KernelVersion:	5.12
>  Contact:	netdev@vger.kernel.org
>  Description:
> -		Boolean value to control the threaded mode per device. User could
> +		Integer value to control the threaded mode per device. User could
>  		set this value to enable/disable threaded mode for all napi
>  		belonging to this device, without the need to do device up/down.
>  
> @@ -351,4 +351,5 @@ Description:
>  		== ==================================
>  		0  threaded mode disabled for this dev
>  		1  threaded mode enabled for this dev
> +		2  threaded mode enabled, and busy polling enabled.
>  		== ==================================
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index aac343af7246..9c905243a1cc 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -272,10 +272,11 @@ attribute-sets:
>          name: threaded
>          doc: Whether the napi is configured to operate in threaded polling
>               mode. If this is set to `1` then the NAPI context operates
> -             in threaded polling mode.
> +             in threaded polling mode. If this is set to `2` then the NAPI
> +             kthread also does busypolling.
>          type: u32
>          checks:
> -          max: 1
> +          max: 2
>    -

I'd vote for a separate threaded-busy-poll parameter (and separate doc)
instead of overloading 'threaded' bool. But if you prefer to
have a single argument, let's at least change it to enum with proper
values for busy and non-busy modes instead of magic numbers?

