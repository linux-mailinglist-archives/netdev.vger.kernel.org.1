Return-Path: <netdev+bounces-216606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E037B34B15
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFA2047C3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFCD28314E;
	Mon, 25 Aug 2025 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYuV0rjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F61487D1
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151250; cv=none; b=E1+EP9gyJmCxH06/Sl1Ks+bN68ozC4Aa6WUMPrss0trE+SVonefd7IFW0WDxpTxyTJt36MKsAUBw9jS2MrUohN6eiTvKRRdowP8Bl83rwZpRDYiyth0sTNlEggQN5u/pU2IPu0bKGIdQTmTlOmuDEe6IxhS9PWHaKRVTpA9/tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151250; c=relaxed/simple;
	bh=0i/SjzsuoVkPH9/VI998eUCeMC1cgrzukT1+ts6VACk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEzb9FFCEENrFHbHd+eAAFJiiuthl5dQ6SlneWTQylMrfnIpdCK1oDzclWQNvT/Ylr4FU/6jwfKpNVhYRjkV6k4flHDCjNeLwyrD7iYEncDax3VOj0fcVzcpy0OnOhU27x88Qwc5+LHlyx8Dcnz4WJg84kAWknzmOeK0hIDkua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYuV0rjX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771e4378263so1141950b3a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756151248; x=1756756048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qu5ZlRvYJEQt95QLYc1fbpIoczcJx5tT1S5MYe2Qbaw=;
        b=SYuV0rjXO4hpuPTLQekOvvkOUHk17bg4xYUzPWil9Tox7yHYGybvriVr8ooqNmFUQq
         Jb7IepYVVhiRpVwozxTpXBDP9YBxShBWUkdZxdeId/Q041WCUHnToezHBuR7eI5kyjt1
         J7powrOofJVbrshEemiWG129SQUfrTO4Qt0ZsQsqfO5xI00VpTSoM7UWM3ARMEkyqZut
         gShPOo+4uuQ36Xtd4s7i14TwrwJACz6G489sE9Z38C3TriHMuG2Gr7eRL6TqN47cC0FA
         lSOrkMZkeslP/YtiSw0NZFU2/QhxhXW55JLAOI+DjTOxjF1nzx9ha7mCqbEtv8+zWcam
         FL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151248; x=1756756048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qu5ZlRvYJEQt95QLYc1fbpIoczcJx5tT1S5MYe2Qbaw=;
        b=PB2cZPy2ZcTYFHiJKTKoTnG1fZSDBF2xyveB79c5CD1i1Zblk/FwxbAsX1Cqvs7y3Y
         hscFsn4NDy+voiSBEU0ohMmkzyT8xoAx488HKsUPq4a/R3gqa9r7//fZY1yFJ/uBb20n
         BZkBtMY25M8RvzCjqvJ16rSuT46ZQaCQ8cSLkBkxDDv4O43RYfwj+fQuLLSJ98JH3R89
         4Mb2HaIz4ksZ67J5DS8OSb468ZHiwLF1QuvGlBQEgLoYJ8jVjS0JIetmR6UuU+YjCIac
         FmiDzEL80M9R+R5TA+ZOliiGGeJgTfuSjq27BwgEiqjBnw8+mGVFZP3fxrDIaZ+ZN1ia
         h32w==
X-Forwarded-Encrypted: i=1; AJvYcCUQGijPGPfiRkxpTxbF+MuPbjjwOBKCOPQbN8KQhwImMsyDpUZDCziKNBPM3K9ASX0GV/c1j8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNy1Lc83AoOb2upKHCllTHt7kfQcGqwpEzvw9DqJUvpDwTviyC
	cRVsQlVvbMju96YcMjg2ZC2EkfHD8rwuJzMy1dRknwZG/06bnMcM4EE=
X-Gm-Gg: ASbGncuktphNbGZlK9SbNBf4852o1u6yOTIKtkzN1cPH6ze2dXMFGGPGXaVePscgTSV
	oEwCPAgScsYQq8roPHj0OIpVLSS6fEZN772fL/zcPmc4QN9twqcgQzYpQIFiqfguHDfcTXDKt2s
	Bb9lYJEUXye9j0WZK6wLFwjtQU3AX6Mh8kclAHolvbXOfwm/OXmcj9Ne1/+MJln3ub6EI3IWmXg
	yl208LHNwvbM1NBZPCFBSqyG5BqTpycc7c4G7Y1jtf7ebaCFK6H/3KmzWgp+P2UoInzZvJFcO9+
	JAu5qUOH1acxaHJP0pZft62rF2GjV7Hjax6W6rGBTvgSr24sTz6G3nMoEHnC+2EysIkuRga4emp
	tWfwtDTHaE/hYluETXyXaM5DFD/VAxNBpWYkB8dmgD4a8kn/ox9/6mKwUWn1/Qv3ol2m2mVKCcT
	tYzJthQTwgPGLfpjp2b1y429giIsXjprb2583fhkic9pm7faE6kRIWdagzCXLp0WfdQbu9m7WZc
	G0aQyWt7qS6b1A=
X-Google-Smtp-Source: AGHT+IE6CDXN8sydOYMY2M+MmXLHi0MILFQePZ7jCcvmxt71+Zsr1S40nbIm+gRNDG8I/A8n+/psoQ==
X-Received: by 2002:a05:6a20:be23:b0:243:7136:2ffe with SMTP id adf61e73a8af0-243713631acmr5702195637.25.1756151248341;
        Mon, 25 Aug 2025 12:47:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49cb8b4b8csm7292269a12.20.2025.08.25.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:47:28 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:47:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	Joe Damato <joe@dama.to>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 1/2] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <aKy9z1oephUbAr_E@mini-arch>
References: <20250824215418.257588-1-skhawaja@google.com>
 <20250824215418.257588-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250824215418.257588-2-skhawaja@google.com>

On 08/24, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
> 
> - NAPI_STATE_THREADED_BUSY_POLL
>   Threaded busy poll is enabled/running for this napi.
> 
> Following changes are introduced in the napi scheduling and state logic:
> 
> - When threaded busy poll is enabled through sysfs or netlink it also
>   enables NAPI_STATE_THREADED so a kthread is created per napi. It also
>   sets NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that
>   it is going to busy poll the napi.
> 
> - When napi is scheduled with NAPI_STATE_SCHED_THREADED and associated
>   kthread is woken up, the kthread owns the context. If
>   NAPI_STATE_THREADED_BUSY_POLL and NAPI_STATE_SCHED_THREADED both are
>   set then it means that kthread can busy poll.
> 
> - To keep busy polling and to avoid scheduling of the interrupts, the
>   napi_complete_done returns false when both NAPI_STATE_SCHED_THREADED
>   and NAPI_STATE_THREADED_BUSY_POLL flags are set. Also
>   napi_complete_done returns early to avoid the
>   NAPI_STATE_SCHED_THREADED being unset.
> 
> - If at any point NAPI_STATE_THREADED_BUSY_POLL is unset, the
>   napi_complete_done will run and unset the NAPI_STATE_SCHED_THREADED
>   bit also. This will make the associated kthread go to sleep as per
>   existing logic.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> ---
>  Documentation/ABI/testing/sysfs-class-net |  3 +-
>  Documentation/netlink/specs/netdev.yaml   |  5 +-
>  Documentation/networking/napi.rst         | 63 +++++++++++++++++++++-
>  include/linux/netdevice.h                 | 11 +++-
>  include/uapi/linux/netdev.h               |  1 +
>  net/core/dev.c                            | 66 +++++++++++++++++++----
>  net/core/dev.h                            |  3 ++
>  net/core/net-sysfs.c                      |  2 +-
>  net/core/netdev-genl-gen.c                |  2 +-
>  tools/include/uapi/linux/netdev.h         |  1 +
>  10 files changed, 142 insertions(+), 15 deletions(-)
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

I might have asked already but forgot the answer: any reason we keep
extending sysfs? With a proper ynl control over per-queue settings,
why do we want an option to enable busy-polling threaded mode for the
whole device?

