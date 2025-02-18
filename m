Return-Path: <netdev+bounces-167517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9278A3AA86
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F189167652
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0117A313;
	Tue, 18 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glTvl9Uh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E797286287
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913020; cv=none; b=I1Xhe+Kib+zNmFtJPF5Ex/0RxIE7juCrUJN3nkvEn/XmNa2j4ggCUao8icxNjS9alVVkl5Tom1f0Q4PrQl/9ki78ozoJEBQ/cPkMrOvnGMzGq2cC5SQIOyZ8PyhBF85M+T8Lm4cGDT0uzCMz1OkpzTEwYXqalKsm//5W4CCpyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913020; c=relaxed/simple;
	bh=hZh1bGWrQ5PuEiiHXbejeJ2JPesAaxincVAdKYuCco8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZkf4HvLHBowi9+5bTIsw4NHK6qf9p7TNqGUg6otyDiFrKCpUdudFBFpX6hFA1u4qhc8EH47CRQVYab12HaLgQ+RKs+VqqBWaEQZ0ButqpwN0h0wC9EexGNcfvZC0CqbVdqweHcIMb50tmEjueNYAqfi6ee3N/ZuBG5KaXLeKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glTvl9Uh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220dc3831e3so3539335ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739913016; x=1740517816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kig0TWrMVynCZJet8pJTZdmHlgSieqGFt9s4v4DgEAs=;
        b=glTvl9Uh8PSF0kpk073/x1oE0iVCqLIc/e7e8EXgPR9whg3WI20g7ExLE5pvMSDW4z
         hdPZBzzSB+Cmc9NP7l+YNGR863QJVAGG4OMw6yVx59LiG3rRP6biJtvYOsKoUjEdPfRh
         /rwH/L2lN2amoHQP4VbBZJlRVeCAflLLUyOZkptDvoXUW1wE3vF7zSNtDTHSR21S9k2v
         xaXeEHzAGDGJc5UtCthPotwqb6m3OuUqe/4yXTNMFtWVJKs7jGVv8OmbJ5SEJaFyTyJb
         MKwUGpwIEY/rZ0AYLGZ6WW3N4vKSqZ7ipaFqmzpRmNswUjXlDEotV6Cby16bzJN+gPbs
         QjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913016; x=1740517816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kig0TWrMVynCZJet8pJTZdmHlgSieqGFt9s4v4DgEAs=;
        b=i/7L1Qf2Ai/DFIw+5iTyKAr//pEDuEMbUhDLKu1DMXXUV7boUJhJgc6f2XQotClDsi
         +Dj1qP51YghRfBJuq73yAA2UTZ+1juSw4tKqJqsS9dHI2ZDliZEBxc+zW6COR+6hmYqT
         gE5IysMwEjCGgSuwrn9zGkjpWmiWZrrVxlRa4E/Mr+IioZhO3xUgdn2DCOwG0keELTRX
         5LltvNClcl5r/cZ9xITvFO5qGgprpgFS+fng56PUcdUTU9nHx8XbJT1+5R7v2t6gVO8K
         1ovqBfGtY9VeLUuS2u7MT0dY0W4FDb5RO0NRuwyKQcG6PNV3bqZ6GA7abGrzymEXPOsQ
         l1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8KaiGDowPMTXBtcKbrfYGHp7X7zmSJPJVjBH1yMDwTV+Z0/lEBtWu6eX4LbFUtlzoQJsJP50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNQ25zPICd9N2EnjiVfs0sW5i5ewDiGAsd2nBzuQcIH34oeaE
	wjCrrB1LAGVFydFf4DttrORMaeDCUPt9kBQcyEMcc8wk9GZP0/M=
X-Gm-Gg: ASbGncvND9af75+Ar/8I5oIovR5DNmLS9ruaf3aS0cNuPSCfZyuXxGK7FvMsSdHqJ0+
	3it4OwRq6mpUQfslyP5Djpn+ClLVKJBAkim7YHwy5smBNZMYEmKl0WU/J0wm+lROLUbRGIFD0IH
	bBGim6LGyntQCjqXxu4+X3w6wfzHIPBWQDRuWU689INk/pN95Kl1D0jjW6gWoPhd6/pqIAhJoBN
	W5SqfZiUmo6R/KgdiaW2Rqz8bbudqR6vf0/l7+rlrYxz3HjrjVNmAhm5+OqIEDF4djRt6nsjyIf
	pH6AQiWAE64zAKQ=
X-Google-Smtp-Source: AGHT+IEXHVqm/6yYVnOUGZoDh9+dKLjKnshd19bgf3Ad4BW8niJMOB7qMYr83w6jL08ZuIh+4HWxQg==
X-Received: by 2002:a05:6a00:4fd4:b0:730:949d:2d52 with SMTP id d2e1a72fcca58-7329cd77323mr2087179b3a.3.1739913015700;
        Tue, 18 Feb 2025 13:10:15 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568adasm10934567b3a.52.2025.02.18.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:10:15 -0800 (PST)
Date: Tue, 18 Feb 2025 13:10:14 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	jdamato@fastly.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7T3NqZtfCA5C53W@mini-arch>
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-3-kuba@kernel.org>

On 02/18, Jakub Kicinski wrote:
> We use wait_port_listen() extensively to wait for a process
> we spawned to be ready. Not all processes will open listening
> sockets. Add a method of explicitly waiting for a child to
> be ready. Pass a FD to the spawned process and wait for it
> to write a message to us. FD number is passed via KSFT_READY_FD
> env variable.
> 
> Make use of this method in the queues test to make it less flaky.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/xdp_helper.c        | 22 ++++++-
>  tools/testing/selftests/drivers/net/queues.py | 46 ++++++---------
>  tools/testing/selftests/net/lib/py/utils.py   | 58 +++++++++++++++++--
>  3 files changed, 93 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
> index cf06a88b830b..8f77da4f798f 100644
> --- a/tools/testing/selftests/drivers/net/xdp_helper.c
> +++ b/tools/testing/selftests/drivers/net/xdp_helper.c
> @@ -14,6 +14,25 @@
>  #define UMEM_SZ (1U << 16)
>  #define NUM_DESC (UMEM_SZ / 2048)
>  
> +/* Move this to a common header when reused! */
> +static void ksft_ready(void)
> +{
> +	const char msg[7] = "ready\n";
> +	char *env_str;
> +	int fd;

[..]

> +	env_str = getenv("KSFT_READY_FD");
> +	if (!env_str)
> +		return;
> +
> +	fd = atoi(env_str);
> +	if (!fd)
> +		return;

optional nit: should these fail with error() instead of silent return?
Should guarantee that the caller is doing everything correctly.
(passing wait_init vs waiting for a port)

