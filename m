Return-Path: <netdev+bounces-111175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64289302D6
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300CFB23F25
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F38C152;
	Sat, 13 Jul 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bqX3/N98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853094C8E
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831560; cv=none; b=Gwe+/iIhCZPiFHnVlgGLy1W7O7Q4tMXeYDRqFNEWa6pTyDV6gAANQmNTgiS/+waSijg27mqBzEuOW9Ez5lwtAYyO4MjIqM8LMoIiq69ctAXp1AlDxrK9WzSY1N49CUNgCeYgbJ6kZ69sM66BxbMP20FHC85V98uHz6B2g8kLVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831560; c=relaxed/simple;
	bh=fIeC+An8Bolk7ryUxH57g7EED4R3JHcxo9Xw3ewYCag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU6tfjIdbb/kygPCxjVtBzNhj0lNJ9O5ODd8mZnJLSKCASmrySrtF3xwQbu3Qv9D6K79RgwAoc+dG+FCt4CdhSSx+13wmTkPd9NOC6Lc0XVHuS/HbqiQwCJEnfie5pgM7dJgUsXwVfIvy/ArcfmCqIJ2jiuy6u0Z8KMJqPbMn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bqX3/N98; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1703205b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1720831558; x=1721436358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW4zTFHOtzR/wwPx1Zay5ljlIiuZLQskqd4uueA0+2Y=;
        b=bqX3/N98t+U/N9aESe4MeB4CFUyQ49wotzpLFJgKHHZGuRJWJlg+fkJZdJm+q4YAa2
         K2FVaAkxBk6ZfSGIsRdUAMWFydmmuhf3+BgWJqSmBR70LSLPho/4f7kFCRjiJZYKhDRX
         6qWAYgOP7Dm/En6SKS2fQCsgXRZixxtW6teUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720831558; x=1721436358;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW4zTFHOtzR/wwPx1Zay5ljlIiuZLQskqd4uueA0+2Y=;
        b=kDUeUsnSx8PV8iSHHaTs3+sdHc+9G4BTiTrEGrXbNFYoQvku8ALaHcSG3euI60dicq
         ffdAjTRPu/vKRHcpZFdHHRWzGUYqFDrxDE18j4JhMsHV+pEGnG+mGd9pfjzbx6rY/Pso
         5jWNVsHvI3pk8dfGZyg1F0GqArIq5tX1X6SnhMWhnpYyKSJ25l7aAodmF725PewoVjGe
         g6idgorMrUT8L0gbQMLHDf5bhhQzvpCH9u9wFk7FGPJX9faZ4MpE1ARzo5oynnv7JQ42
         lbQULc0wOmtEnYF2qvlyKExwpjpTVZ1O8z1Dw/vDsM6F3hJid3xhkEWHdF/j8kQ5ugcU
         y9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVJu/GdrRpcV8sUnLbPE0MJQEECNd+52cHTXQF0ogTBPj+HoQYIuBcQOjuqNBcXDFjAA8MzT8tbDlz3KPQrYSiJD5iH609f
X-Gm-Message-State: AOJu0Yxwwna4LJwHCQMTy5OMcLpmpK49ipMk8qJoK/h9ozJ69Ooug0XM
	mA7ewF5HG3c+bRU1CgveUZsyFEDWDrkCC4U4HKr2gl/eGqNJe/IYok7hTlC6a0g=
X-Google-Smtp-Source: AGHT+IHoPtn3Alyl3FZi++726JDLvsj5bOjq0G1Q9EoK3jyg4rB7GE4Kv5UyyYhw1tM2Dc6MPFlM8A==
X-Received: by 2002:a62:e915:0:b0:705:cc7d:ab7d with SMTP id d2e1a72fcca58-70b6c884c43mr5316300b3a.5.1720831557735;
        Fri, 12 Jul 2024 17:45:57 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e226sm145706b3a.27.2024.07.12.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:45:57 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:45:54 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kyle Huey <me@kylehuey.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org, acme@kernel.org,
	andrii.nakryiko@gmail.com, elver@google.com, khuey@kylehuey.com,
	mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
	robert@ocallahan.org, yonghong.song@linux.dev,
	mkarsten@uwaterloo.ca, kuba@kernel.org
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
Message-ID: <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kyle Huey <me@kylehuey.com>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, acme@kernel.org, andrii.nakryiko@gmail.com,
	elver@google.com, khuey@kylehuey.com, mingo@kernel.org,
	namhyung@kernel.org, peterz@infradead.org, robert@ocallahan.org,
	yonghong.song@linux.dev, mkarsten@uwaterloo.ca, kuba@kernel.org
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2>
 <ZpGrstyKD-PtWyoP@krava>
 <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
 <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
 <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com>

On Fri, Jul 12, 2024 at 04:30:31PM -0700, Kyle Huey wrote:
> Joe, can you test this?
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f908f077935..f0d7119585dc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9666,6 +9666,8 @@ static inline void
> perf_event_free_bpf_handler(struct perf_event *event)
>   * Generic event overflow handling, sampling.
>   */
> 
> +static bool perf_event_is_tracing(struct perf_event *event);
> +
>  static int __perf_event_overflow(struct perf_event *event,
>                   int throttle, struct perf_sample_data *data,
>                   struct pt_regs *regs)
> @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_event *event,
> 
>      ret = __perf_event_account_interrupt(event, throttle);
> 
> -    if (event->prog && !bpf_overflow_handler(event, data, regs))
> +    if (event->prog &&
> +        !perf_event_is_tracing(event) &&
> +        !bpf_overflow_handler(event, data, regs))
>          return ret;
> 
>      /*
> @@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_event *event)
> 
>  #else
> 
> +static inline bool perf_event_is_tracing(struct perf_event *event)
> +{
> +    return false;
> +}
> +
>  static inline void perf_tp_register(void)
>  {
>  }
>

Thank you!

I've applied the above patch on top of commit 338a93cf4a18 ("net:
mctp-i2c: invalidate flows immediately on TX errors"), which seems
to be latest on net-next/main.

I built and booted that kernel on my mlx5 test machine and re-ran
the same bpftrace invocation:

  bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] = count(); }'

I then scp-ed a 100MiB zero filled file to the target 48 times back
to back (e.g. scp zeroes target:~/ && scp zeroes target:~/ && ... )
and the bpftrace output seems reasonable; there are no negative
numbers and the values output *look* reasonable to me.

The patch seems reasonable, as well, with the major caveat that I've
only hacked on drivers and networking stuff and know absolutely
nothing about bpf internals.

All that said:

Tested-by: Joe Damato <jdamato@fastly.com>

