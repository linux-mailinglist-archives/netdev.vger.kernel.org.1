Return-Path: <netdev+bounces-174615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4380A5F8A7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D431666A9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390162686BC;
	Thu, 13 Mar 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYT+mDT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE3268690
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876851; cv=none; b=OHBCfdH2Wve6u/h3AKWyNtreS2mOsLzZXwoiIgb/EwQnwhXYxqf8/5LDsNd0R75/vU3JCcCxNDvWsBIO8fMFHym0/zpm5m4xNmMN6uprE1F8R4lG9FmmIjO0WLFKgSJpu6LAOwkpP7t4AUdSJ1HaRGdp2H3yxR9+Ctz/VgboRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876851; c=relaxed/simple;
	bh=pAoE5946s5Gk2fA2kebJUB9HXCq9xcYQxsMTNtXL9/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECjlUbURZOojOS8QIOLh1+Etg5SGo2nXO/9ZrxwnFiBkXaL4qbNHFe+Q61ZXSwXFHUyxaquJdCaHhyZolVcsvaagrvaNHmRZGIkpDSIUXqSCT+epeeqdZIB/+3c9hHBMx5zJSVyUH/a+q7ModeOlysMKn62AnCk1/Bg/FkUsvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYT+mDT2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff0c9d1761so9647197b3.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741876848; x=1742481648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2Bl2Su+/gwfetUP/jaKlf54gtF49C473VvvFpM5g6I=;
        b=BYT+mDT2kM0vrNE2fkq6+ShFAVwkdJoGdGUgXCBZzhqKvj3E02EDqW6qezZa2uWxzn
         4xO02ckXDWRQWYLtxMbsvhBvycWhphRwu1AxsdNljMpeGyYtcz7viSANGbTG+klVcMk4
         9m/aIhrlzfbALvNMYOw21IcbxlaNTl2NAeRRoZc+bYzMyGENxynCpBw9qoXFjARwE0nd
         6aalNDqqWHLROvuuX5AHKWVWVstUYZSZt5eUJ8R8H+skyqijNPmkklOZTV53y75Takvr
         lh056z9kUQLWD3AHRYIkBbwacLm62F20ZozW62r6P8SzzMZSoGirLkxeM/nELo2MkAiy
         ln3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876848; x=1742481648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2Bl2Su+/gwfetUP/jaKlf54gtF49C473VvvFpM5g6I=;
        b=tl0bLMEuNpZNNweU/THYf/wTMQHIFbUpbqCLBSROZ7A7Fj2Pnufv2CD3lLVrj+0hbB
         DCCzXXvWhbQ5LDLM6Qfh85pknPbMPLAf7gy/iM9R1+BHZxnBD3jPjB8niSJI106oF+Fb
         Gm1EQ7cMZmYsx19x7LZWq1eiQjUgEyyM1glf6eU9NXIFCzFkqWyMpx6wTPTk7JerrNnw
         fSZgQ1A6nYKVNRY/wfKjtlfidOcL70i/cQKnO8WHyjJ7kvjYoove6XCDm3Nfh2Ujfwq3
         vZSzNYrgDWDuu0CQ3KW6+fEY+4LE3zN1Os/tKkGcu8nha1WqC7Ok8wa5L2WkyC7VZsCN
         xDWw==
X-Forwarded-Encrypted: i=1; AJvYcCUEmpcHqmwvgqK7y9Rb1vhm+6kzfffrJGZjhm2UbMHc7Uqo7Nz+njz5sjJwHc5YdI8qnqclhf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeihyWS4NUP1hCqCcwp8H78ixdfJ7n90isHiO0N1wHNdCxR6H
	nnOcFQy+fj++wyoiEJ+DRqIUfpkEmWAgriUnglJhykBV+H9w39jJTAmzQYXP5C+Nc/bi5jEEZ4S
	9PQUKx7sgnLHJpCLsdrRG5PfskmLLAwdl1XyBlC7eJL9Jl4Iy7lE=
X-Gm-Gg: ASbGncuckHAeHv3JG1WOmjXdKtiBqNlsOkXujM4Urmd++unuVbxINrjgBFrcJTVMLsc
	fMfEo500q3rbI0cLGp8oxbExoCHtIfQhlPel1RD/HbtFlwL2l+cWsLpQVQMLDaGnNYSUUeNfYXZ
	XHAh6JbOhxem32p0rtdfz64EYVNIft/TVx2j0iBg==
X-Google-Smtp-Source: AGHT+IHlqbCdi6b5AuWlv4WACVSDWJUjfnZagh7rV54UbyilpuB2Jl+yS7qcFAXsJdEa4V8w8Yh8A2r8jqbwYn6VwMQ=
X-Received: by 2002:a05:6902:2789:b0:e63:3e41:6579 with SMTP id
 3f1490d57ef6-e635c20370dmr33596240276.47.1741876848515; Thu, 13 Mar 2025
 07:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307115722.705311-1-bigeasy@linutronix.de> <20250307115722.705311-2-bigeasy@linutronix.de>
In-Reply-To: <20250307115722.705311-2-bigeasy@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 13 Mar 2025 16:40:12 +0200
X-Gm-Features: AQ5f1JomfK90BpA2TiJM9KAdy8VzKdj-rmW-tkbD-mIZWe61aNgjc9raPakx7eg
Message-ID: <CAC_iWjJYGdZNWhYfLwBiDjo4R+gGcujDKpEbOdgaA0mTa9Vj3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] page_pool: Provide an empty
 page_pool_stats for disabled stats.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian

[...]

> @@ -81,6 +81,12 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  {
>         return data;
>  }
> +
> +static inline bool page_pool_get_stats(const struct page_pool *pool,
> +                                      struct page_pool_stats *stats)
> +{
> +       return false;
> +}

[...]

That looks reasonable. Unfortunately, we have some drivers that don't
check the result of this function, but I guess that is a driver-only
problem...

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

