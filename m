Return-Path: <netdev+bounces-65977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82F83CC5A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF77D1F269FE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912B1386B3;
	Thu, 25 Jan 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjVIobPd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968911386B0
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211254; cv=none; b=kaJhhb0WnGacJ3T5nz9PZfCMH44HXHQGUqrFXW1JUqQDsWinojHr1vS5Nyb4q63TlThsGh6bc6Vn5sM9vriNUmE/bqmabqmuUcqRq8gv6YMcHTrQiwgd15zEUwAj5mHyDKHWDlObGXCsFKn2R1Bc7oO99J5hORd5c5Y1oKqw18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211254; c=relaxed/simple;
	bh=euenOEJWbKMReqmGzBSFxRmeY7+pAw/n2DDD6pBCMOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbaJXYULBaKX3D6lYG4mY0q0IDnXqkwcisRltmHPerbWwwM5ec00kfJ1apKG1a3A/jgqnnArvi6UCkbAgc0W/96ozNlbLYmHbGkcitRTXyT/22jwH1XEzSvH7HorW7sTTV6XCD3f7g/RTys6Ctd2oO1G7ZK0aD4t/GpLsHIvKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjVIobPd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so1370a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706211251; x=1706816051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8aKo14reNbBvflPUZQ5aXL5UqBMo2rfTkLL7mrvQHA=;
        b=MjVIobPdwgdRBT64fxSRe/sJ0dK95M5Tw6uFkt+S2bgOhAsx+x3PWWYer0XvxcyR3K
         bKtXWbzTTwcUFhb9GBNtdKZJ/7lJXpiqC5+qQ6klkKXkOdENAqmkU3pRo6bPZRP5axZi
         Yekzy7tFU3lG0M6loSRir2FgOr6IClQpSGd/m/p/gb93wm7JhUFK1mka4UWkVeDXb5ve
         HOOY6T3Op4Izp55MgUNsfxeU79gTJ526yT/Uk6+j6WEr8lTUI2co9jXhu81syMGS4ST5
         vMzLHshzpNegXEvzAPsIRLVcZBBIuFC8pi4ny1XeBCEdJAAZ9+CBd5MADcffABHUlQK9
         adrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211251; x=1706816051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8aKo14reNbBvflPUZQ5aXL5UqBMo2rfTkLL7mrvQHA=;
        b=MdmZiJb0oIY8udJd6DAvBg/2hrLXapmpQhUimUiCeLy1rVtVy23+OAoHTsr6KnI5S0
         VBSgF/tC9foeAvVcIAMZc6fgw845Tmuolc9uLhIMhqmmSgtUt5y8Si7qxch7TeZ1Jsv0
         LoRlz+qn6FfZ6xHS/d35R0Zp5cHMd38FXewx3qI6ejkVZw6XEG89TBzpvan0FpfKyBE0
         KRhEegCN/f2d8LZUp7YEhRmtNXiqys8XcA4Bv+8Aqab/YQY8OQQddUY7jU5NmVaUvC+Z
         gCycj7zq0lwT6w7OhyUVmL3Y+nAfe2TBk73PAUI0MmjGdwgG50YM8d6iusHb/3NrDfUN
         AVYg==
X-Gm-Message-State: AOJu0YwnVF5g7au7kOeQ82GNwJyw5w21V8e8JtNbMeDOu1EDR+AlrbMl
	jdfzuoXF/tj3glzwdPfw4Z1e0sgCbtn7Wzn4W1hxCWkcuhy8UORbp5LfS0lGYkVGC/cb7Hro17d
	869NYHnKnAKArYg17qL0diUYTGlAD7s/Tbhy0
X-Google-Smtp-Source: AGHT+IEpMi+NmSM6UzeX1Az5Tw5KfRkgmi7J8s3iBPlxb9oU3Gl6GyDR56rBqH4qqaqN93W4MCGtA2sQMjjZqtpZWDc=
X-Received: by 2002:a05:6402:b57:b0:55d:2163:7ed1 with SMTP id
 bx23-20020a0564020b5700b0055d21637ed1mr14684edb.1.1706211250620; Thu, 25 Jan
 2024 11:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191840.6740-1-jdamato@fastly.com>
In-Reply-To: <20240125191840.6740-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 20:33:56 +0100
Message-ID: <CANn89i+uXsdSVFiQT9fDfGw+h_5QOcuHwPdWi9J=5U6oLXkQTA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: print error if SO_BUSY_POLL_BUDGET is large
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dhowells@redhat.com, 
	alexander@mihalicyn.com, leitao@debian.org, wuyun.abel@bytedance.com, 
	kuniyu@amazon.com, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:18=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> When drivers call netif_napi_add_weight with a weight that is larger
> than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
> prints an error.
>
> Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
> specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
> error.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  net/core/sock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a..ed243bd0dd77 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int o=
ptname,
>                         return -EPERM;
>                 if (val < 0 || val > U16_MAX)
>                         return -EINVAL;
> +               if (val > NAPI_POLL_WEIGHT)
> +                       pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested =
maximum %u\n", val,
> +                              NAPI_POLL_WEIGHT);
>                 WRITE_ONCE(sk->sk_busy_poll_budget, val);
>                 return 0;

This is code run by privileged (CAP_NET_ADMIN) users,
please do not spam the console with such a message.

My point was : Do not allow an unpriv user to set an arbitrary value.

netif_napi_add_weight() is used from kernel drivers, we network
maintainers usually object
if a driver attempts to use a big value, at code review time.

