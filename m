Return-Path: <netdev+bounces-212342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B2B1F802
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 04:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6308117BEE3
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 02:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7435947;
	Sun, 10 Aug 2025 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="qaIyKwLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5541367
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791487; cv=none; b=YcquS/73Am7wbXB45euk3OL2A7Huy4o2Zv8gcQiNIU8BNH/+OBI4PNSzkqRVBxfqbQsivyyzmL1AT/TUQoBTP9yVIxorX1nqPV3027HL2FsLELoZXJoKQEkVuULvaR183xNcBgAB/KETwrw6EIk2lusHM1kSirAeS3g0LmeqxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791487; c=relaxed/simple;
	bh=5B9EcPlaYkNFgWW2w0IjOvRGR5xFsqb+684FjwZuIdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5YYNFHNaU8PhiEID0xpW6HlU83KOFc5vhQoruQyOnnQS9qn2pLQKzGDDwCM7AlqCzutXbAt2/Ba9MpewWFKxB01OyFAt6m/hezhYFqSUu84AD4lMs6Rh80EdYTRWMb6Brq3sC4i78+ZtvXzmialYpl51fOaOMdAeX6hQwdTgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=qaIyKwLI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76c3607d960so3556039b3a.1
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791483; x=1755396283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpEDcR/rY+YXUvIHTjoMmFXmGhwOZhEhJLky7Dw6ZkA=;
        b=qaIyKwLIV9p9uK/AqsiUY2LWiLIoFnpGOyUbNIM2mY+5onKztlemdtQfwV/giuu0nk
         GTBFkn2l3j3pp3rzdqEXRplOlYvnwnaN45PuDpVnG8hqDmth9Qd/4b4PTt6q2NscuOzP
         OGNuwaOq1PO6V0P5078ERdHJoTHT+GvDhj5trAEgBv1CVjpWp6az9biNKEiik7SqkCvQ
         5tgaHq58RUv0eOyQtNI9xZQ1zSb33k/4tYpTUsUDie8iwrPPdxrp045MVmcl7sz9OOdx
         pG041gidt7jPmGkby+uUNuH8xnapuhEOyEn3nDMkrsnV+Ye+1dPtMZvA+YGV7h+zatA7
         kW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791483; x=1755396283;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpEDcR/rY+YXUvIHTjoMmFXmGhwOZhEhJLky7Dw6ZkA=;
        b=gHL6x7V0ZDqN6OytM9fHtvvAuxtOzG/x3hfJAdtKADETFzqqjvdYbjSNatXkHVdNEI
         CO52z37GjcHQzVXyr//6Zvpfydm/NrfiSBhPw7X+e1b4IVqLkcvKinEMkQAlHfcyJAf+
         cmnTPNPHBQoeWd7ma1v1L9RxBt0mlpDyybsGFnFuuBsRKNDUKWjbKXfGUokiv9qu8Nf8
         5Nf2dL8STXeD0WImq4XQeD7nFwVumbancsxIpEdoBlScFaE+SpUCTjtsHd0SL2gwyjou
         KnT/U8lQ9lo/yZRlg5XAocoV+Ix8LNyK5bgjvZVEdMZrOOfM5oQ2fD0NLoPMNfpUIP2m
         wDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQme5HJ3H9Z6RynrgQ8oupBhVhBD4TGTqKcB6v7VurNaPptnffSut141LCvFUEucXzTOUoNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsL6PLZJJ6kLw00P9IXwy7HxrQOXEebO/glZs2ZiLEhSAY/Uf
	5LhwK61xhK5DqynXhraODHqCyyO5GA6vH/QLAiblyDXUKdx4z9MWMT88oZQFh5Lb4pI=
X-Gm-Gg: ASbGncutrfdkRBDpt9CCpVvBhPpHk0/lxWFZJKHkkO75KgV8q8Z0zpJXB2Rvy5hTURh
	WCfuXYq40bFtotC/JlnIKizihLPw9WPURdwkglNI2UGPks7gUd8dQxRBcTTFOVkTdlNKlvrx2Dz
	oIBvmDu4pcYoBf2ElY7JhiA3tVtSW73gax4+L/LUQjNmqZq+xVpoBEVScyb9CGIPRevlTe+hq1o
	QxufuSNO+0+najotV0/HoNtmiWyWRB+uJMwJIxUuBxX3qaUldtzi0CBCRZ+IqFkWSzchgQBI2AR
	1mdRto0yzN3TEdEX9SWd3Sdxmwz4kA1eYxwWC0UX8KNGKJg3rAvghV+Q/bPzzisFa1N8eOOdOPs
	67lw7goWGYBVskCus8TVSNQ7X+re0/9UabeaI2XXeNZKBzUGgW1qgItqLBitS2CxzNxwuMuSL
X-Google-Smtp-Source: AGHT+IH9l+G3vC9KcZ3JXNHknQZtzhkwAF36rtgqVKo/+BrNtn3ph8Wz2bBk6bfnDChBVuLFaLwxXQ==
X-Received: by 2002:a05:6a21:6d94:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-240551be2a1mr12886194637.32.1754791483437;
        Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm22372207b3a.20.2025.08.09.19.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:04:40 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: update NAPI threaded config even for
 disabled NAPIs
Message-ID: <aJf-ONUg3AKXjcqV@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-3-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:04PM -0700, Jakub Kicinski wrote:

> We chose not to have an "unset" state for threaded, and not to wipe
> the NAPI config clean when channels are explicitly disabled.

Yea... I wonder if we could change that now or if it's too late? I think this
is the thing you mentioned that I couldn't recall in my response to the cover
letter.

> This means the persistent config structs "exist" even when their NAPIs
> are not instantiated.
> 
> Differently put - the NAPI persistent state lives in the net_device
> (ncfg == struct napi_config):
> 
>     ,--- [napi 0] - [napi 1]
>  [dev]      |          |
>     `--- [ncfg 0] - [ncfg 1]
> 
> so say we a device with 2 queues but only 1 enabled:
> 
>     ,--- [napi 0]
>  [dev]      |
>     `--- [ncfg 0] - [ncfg 1]
> 
> now we set the device to threaded=1:
> 
>     ,---------- [napi 0 (thr:1)]
>  [dev(thr:1)]      |
>     `---------- [ncfg 0 (thr:1)] - [ncfg 1 (thr:?)]
> 
> Since [ncfg 1] was not attached to a NAPI during configuration we
> skipped it. If we create a NAPI for it later it will have the old
> setting (presumably disabled). One could argue if this is right
> or not "in principle", but it's definitely not how things worked
> before per-NAPI config..

Thanks for the detailed commit message. I agree that it should probably work
the same now.

> Fixes: 2677010e7793 ("Add support to set NAPI threaded for individual NAPI")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: add missing kdoc
> ---
>  include/linux/netdevice.h | 5 ++++-
>  net/core/dev.c            | 7 ++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

