Return-Path: <netdev+bounces-129535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFC9845CE
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965E91F21767
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F1A76B0;
	Tue, 24 Sep 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klWgnNfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AD1A76AA
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180214; cv=none; b=ZqHEa2PE6FysU+3vXREUNV5RI4euAOPs/5jKI3vus98HKXOjfTUyki/kj5Yp5IiOHub6um+/F5J9mOu18uoWvqus2RyeCIeG7zvdD87uXufgHEL9CeO+f8J3oP2HBR0f1XHZE7D8A3xCFekHW9l7bgnN4m87YzpJK+l8BHyJWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180214; c=relaxed/simple;
	bh=qnm6Q3Igul4ld8Iy93HUk7wcJFk8TRPnZoXz3tGS/+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EtJeDmnCSflB4BmFwYgE1eyhB7p8VDYc+j8hTlbEkM+xMOMDWkTCmMC+mDjEkOfBFCst55VGMBAU7hFJFH57uu3aN6B8OCnirlNomus56kBzWDNOl5w4h1Nxkhg06EO09dN8r6wSCwxtqDk7AO8f3cH1GJwexmZe+GVcn1nELT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klWgnNfx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae102702so44295775e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727180211; x=1727785011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnm6Q3Igul4ld8Iy93HUk7wcJFk8TRPnZoXz3tGS/+U=;
        b=klWgnNfx6njmu9rOtF3qiO2tW434k9LDJZr6vGdR4xwPXRW+p0+rgLEf9Kt/XTWZlN
         Z+Knpj8aKyGr3vRGkX3S1n/S85XgxxoSAfbhGlx01R0M0rNgvagAT7Yxr4fXvwKZtOlF
         dg7goeGc1uPafF/A8Oq0AN5pSXh/HaoN9AMpPqZIIG45xagGg7zwSmkNJ1zlR2Th8qrp
         AgVqXOrPqhiuaChgWUIIC9aNqmsEelKWn6yMExS7mPGppJ6ibx0ki97NBjqvcK8Dcuzp
         6AcRyT7g7LYvna0n/4tBgfaY57NdQ/U9FtCH+MWBlyE+tySr6LrWpGgYK441v9YMGhmC
         TPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727180211; x=1727785011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnm6Q3Igul4ld8Iy93HUk7wcJFk8TRPnZoXz3tGS/+U=;
        b=lkpacDQhpfmevrFrfXKFeG6idvRWhAQyl+HDSZr8bHLsVc46s1L+gZAQbbQYIJTfcR
         bzvgIZcz7rLQ2feTez9mRVS8Ub3BbNk8YCKDLLHYYutpYF4jT7eSiMbrcK73kiRuU1d/
         ykzIg2/exvMhBrZQp9I7G4CVzB2E2Q0AAvplWqzlmCd177roElJaaDx0Bfsu3M96c0iF
         O01Ilw9JPwn21knn9B6vm1lNMdq0TFaZZgiOr8PxKFOem30HlN3EJ5Px0ILtFZnIAn9F
         SZkF8gVg+aLNskBSMnk1Wg8RThCj6//9g4rH7FdlrbvAg/hAdmwX+W/rY3abnpF/+ofg
         kXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVjxJWwqY5w0KVsFkGumcCUlaT+u4o1X43BCGhuZ6ZNU53Lhr35v5QDD51eOlySBxpzJCRe3QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRBhtA3SMxm5w4BxsKWy43NXOgyJNkfDLpiBoM1ECCZRjdqVj
	bRg8WTbGY7LM68cOvYifj3Wk/H1UrYICm1Mkn1bGA9MbZgdQDOIzEHm8vg==
X-Google-Smtp-Source: AGHT+IFrMBdAMWVRxdMBA/j1OtaJgKe0CldHK6pyomphuLLAnAOLTMe2syYBWJx17DZa7WxgQDVssQ==
X-Received: by 2002:a05:600c:35c8:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42e85fc2e61mr62642915e9.34.1727180210740;
        Tue, 24 Sep 2024 05:16:50 -0700 (PDT)
Received: from [10.0.0.4] ([37.171.120.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9029eed4sm20464485e9.24.2024.09.24.05.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 05:16:50 -0700 (PDT)
Message-ID: <5de4c73d-52e5-4c50-b1a2-faef3c0d01c7@gmail.com>
Date: Tue, 24 Sep 2024 14:16:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: Fix gso_features_check to check for both
 dev->gso_{ipv4_,}max_size
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
References: <20240923212242.15669-1-daniel@iogearbox.net>
 <20240923212242.15669-2-daniel@iogearbox.net>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20240923212242.15669-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/23/24 11:22 PM, Daniel Borkmann wrote:
> Commit 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
> added a dev->gso_max_size test to gso_features_check() in order to fall
> back to GSO when needed.
>
> This was added as it was noticed that some drivers could misbehave if TSO
> packets get too big. However, the check doesn't respect dev->gso_ipv4_max_size
> limit. For instance, a device could be configured with BIG TCP for IPv4,
> but not IPv6.
>
> Therefore, add a netif_get_gso_max_size() equivalent to netif_get_gro_max_size()
> and use the helper to respect both limits before falling back to GSO engine.
>
> Fixes: 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---


Reviewed-by: Eric Dumazet <edumazet@google.com>



