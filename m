Return-Path: <netdev+bounces-110695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A692DC5B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C4B25AEA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762014D2B1;
	Wed, 10 Jul 2024 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XKD0ji9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917B143732
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652937; cv=none; b=iVaHPvBx6l3IXMgzc6dK9CEqX8JpqKBmY/vQzRC4jmn655MiOEcZc8Hb9znF+u51O96TVv7HHTO6t+xSF5OjTD04K1GQuXj0MQyBFmOxeUfgKNaR+43KhYbZYT4BaS9Xp4ZAUumcMRt1SM/APD4mdrnQgV7HozOetfckG94tImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652937; c=relaxed/simple;
	bh=wwHwsoCzTsglQ+b6bxuXxs8fA64M/vk9hY6q/LKLBys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ktt0ikRy32mlR6usA/zzstW2Yp5b/xob4wE3HDf3GckXg8fu2EE8wHnAc9WhnhwiImwYfYrX4LeZZBQaviifu1eT6qQBj0+1kNfDcprG+8OfxthlJ3ow/hmFMPI1w77PAAPaT49M0bmKE/lMII1SWEyMNVli4E4O3apy7ULQkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XKD0ji9T; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so214254b3a.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720652934; x=1721257734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqJS7VrqZOjg+4uCH/J/AhoWd6gznwt4tFXOXS0Dgao=;
        b=XKD0ji9TV7vQHSPh8rcvTVudCzxre6r4IegDLUTfkU82cspBjFY4w7oYqgWHdlW1pY
         RZPvqJjVc6BAkuKOz+k4oUHbRasIKdJQkHnTjHodYPn+IWYpzL8rlSEYz/UVWJfZef8I
         CI3ewpenVt3BQFazplv0hgJoVpi5zkGQ4tv+S7vW/s+6aHdJOVIN1uVq5TaB8zI+A02Q
         6gOOP+mC1/+NDMmpkyTCN53mUuDeipyRgbIGa+TZwfYr5qyEuZEPF6t1sV9/CSKAkulK
         eWB8ciCNp5bOqQdjr767/66TaT5JqCx2P+XF45/CvlLO/JgPcSdTsWlDgWpR8h1tcQR9
         N2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652934; x=1721257734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqJS7VrqZOjg+4uCH/J/AhoWd6gznwt4tFXOXS0Dgao=;
        b=KvqzAyo7TkhRd38F4w4PeZL97M4HiaHhkdm+OtxZ/dWW89p6jNlW4uqxcIQvyhS8eH
         5DF87Wl6Ys5vubBoJ25uJ052o5fjwFGJjGWlwnEE2MYuq0UVTy2JDa29YUtW9Qc0MO8X
         IUBd67JIavo2oQUCbN1qmIOLOXLwvj6Wag8P/Di6OyWNG9Zsnvz+yFsm4m0wdHFUr0jW
         eUEcHbwnQP37BEeNvOikFELLDkIFUZOKgZxQs8pbyIKo6E5RjJhdnMq0fwDcyPLrGTx7
         4Lk0paVTO/PaMsKci5KbmgmxGBBsVfqKxFtcNy5yUtsSXwtqaE/xM6qr/s1otCgqszRM
         /HKA==
X-Gm-Message-State: AOJu0YxWY2Pr2cWBiYCxdgoemE5LACMwesFXt4SVMzUG0mOlECC4xpO1
	U+7+Qo0GK6cMC7+EMw4eyJ5LR2p95ohu12o5EDgIX3uxRciXxx7148sjjRjvlPYjoBw2Nd6Oh2T
	W
X-Google-Smtp-Source: AGHT+IEzEAXadz1EhFaR6DD837GGGk6cSQZQAJ+0byJxPiIIFU1ujKJqA2zCcC+3se68vXphDVtO0A==
X-Received: by 2002:aa7:88c5:0:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-70b5de18d73mr1279571b3a.8.1720652934414;
        Wed, 10 Jul 2024 16:08:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0996sm4346874b3a.60.2024.07.10.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:08:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:08:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] q_tbf: Fix potential static-overflow in tbf_print_opt
Message-ID: <20240710160852.2e8e0177@hermes.local>
In-Reply-To: <20240707175538.1245-1-maks.mishinFZ@gmail.com>
References: <20240707175538.1245-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jul 2024 20:55:38 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> An element of array '&b1[0]' of size 64, declared at q_tbf.c:257,
> is accessed by an index with values in [0, 74] at q_tbf.c:279,
> which may lead to a buffer overflow.
> 
> Details: Format string: '%s/%u'. Size of buffer parameter is 63;
> Specifier '%u': min value '-2147483647' requires 10 character(s),
> max value '2147483647' requires 10 character(s), so the buffer needs
> enough space to receive 10 character(s).
> Size of the string except for specifiers is 1; Total maximum size is 74.
> 
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tc/q_tbf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tc/q_tbf.c b/tc/q_tbf.c
> index 9356dfd2..b9f4191c 100644
> --- a/tc/q_tbf.c
> +++ b/tc/q_tbf.c
> @@ -254,7 +254,7 @@ static int tbf_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *op
>  	double latency, lat2;
>  	__u64 rate64 = 0, prate64 = 0;
>  
> -	SPRINT_BUF(b1);
> +	char b1[74];

Looks correct, but wonder about other alternatives here.
  * printing buffer and cell log as combined value was a mistake.
    ideally, json should be one value per key, not something like "10K/4"
  * not sure how sprint_size() could ever get large enough with any realistic input.
    that makes this a theoretical problem.
  * the use of sprintf() in q_tbf.c is leftover historical bad C practice. Should be using snprintf always.
  * do not like introducing magic constant 74 here, why not just 2*SPRINT_BSIZE (ie 128)


