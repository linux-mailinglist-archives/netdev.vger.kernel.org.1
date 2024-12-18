Return-Path: <netdev+bounces-152860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6EF9F606F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EF4169FE0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409119340E;
	Wed, 18 Dec 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vG6toXNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73174158538
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511632; cv=none; b=oebnq/BOeg3A83UV3ROeuwwFAFYSjDda20Dxl0cbMe1Z9g2smPd7mR5ZP4x9Y+OyVKm0twHwEmQXvZsymIqMMhyGH5Q43REM8TuNTwM6yrfswTOlOBNiNIZvpjx0MiXrD1UMZ6ztKd4X4W7N8FaVeSuf2FlV+Z3L8Y4JYv6x/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511632; c=relaxed/simple;
	bh=8ksdT+6JL4PRc0qsABLDiek46kwkWeHRDJMKst7/7Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef0r4Sgrjhj1p9wmYTRl/N9X8cq6K1HYQGmb/uEaa9UFYZ4nfJToSqw5dKezfSTDJ4GTqN/R2Drqdxsh9bwZKihYyuepgd6RESFTY1ca9p3+pawXtq6ieKo5F9/w55R82MsGDMbTJu20JXu5wheZZkSrTnuarinM646uWMnZw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vG6toXNA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1071618766b.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734511629; x=1735116429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awYOd7nW/uYhwdpcUlzdmbuNuKZNGqm7WQIOfBNb0bA=;
        b=vG6toXNAbzkPVUWo4eA6ePsuQfiooKA4xI6NLQhLnU2pXSnbKcNtdzObsFTiiIlUdC
         h4RgZXJslytRAZpQDjhEmGLzG8Fac/EmdG2bi0nEFx1Ucp/Ni3wS/wxH168Lq7v709jW
         xBpeDK+0+CpviD8muER3LceEasTOF2YlQL85qtBmbkXDbr33+0lSOKyeR9GYo3+jBPg2
         anE5WTL1PvFykwlVHU/wAQ0kYQFErLpXueEcYCRFv1qKvE94W16MPM0JG7ez8r9CHxQu
         QZKSh19MbIl+hxfPr/LzgwuJO1P/S61g5+zZRh1C6jDsPRdiJit12dXXIiZ09TEE6VTA
         gKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511629; x=1735116429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awYOd7nW/uYhwdpcUlzdmbuNuKZNGqm7WQIOfBNb0bA=;
        b=mEO/QO1HxLTI7IG60Y2CRuEfbgAgoPFU0OoTV8pnb4NSIxCxjLLXMfTz9wtRfXhbGQ
         u+WWrlc9iVWcgK6UP91EgjKnNLizs4Ig4uENf+1BEQu/VBgYp64LW/MlvO4woolz0ZxO
         Li+RkLgEUCvPVPDHbhENL18m001Ja514FUnzgKFmqgWcvaQUViMPE5b9iwKp6yepvfx9
         YefIoNIKFxvpI9KBNhz90lBsngDonGTqtjo+HxKlq3BCFV334UB4spd6TRzYORLuI9A6
         izdQAOfRpuW1g5CCKVRPnuaXfjHJj8Cft4w1rtyb67mWWf3AWPq4cwbb9PY5HTHIqlba
         5I2A==
X-Forwarded-Encrypted: i=1; AJvYcCVNQrdQ28sYxGMLEBtttTDYAR7EIG5jQ3qYCkbhJSbQQFqiSP65lcJ+Ypmmz0Hj29aacGL8ldA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWz+81YMbbjjrX2lZKfOKkzWP5e9HBLHsaOdOErIikJ4hdTzR
	tgkWRWIE+HMmRetvV5zgDBka/z5dZ4V21yMYX1m1rr0Hv/P7qX7yEXqX9+ZowTMMXjLAwbF0Tjd
	G
X-Gm-Gg: ASbGnctKZNZBDBIKhc69SoaZEBXZxmyje39WqFBwqKVTyK8tmlkHPytdJvrHm5i2N3Z
	ZxeatCo+jo50rcfyQNNJS3GwvwtLo8bZYEO5Zgc37GC+G3tT8rErt06wVb4b4+3VWkKdqG349lL
	fRof83y26yBy5VErLzrQkhOhP1SFPhMefw5kJF8E8tb+o4m9saM4N4MCHT+Xllld6jsvwaCElZZ
	Z45x3gXiBfcoxRWlKsKgZWosyNM/Up63RWEEvXBxtN5fRR4LRJgz+3QpMFphA==
X-Google-Smtp-Source: AGHT+IEesJsYCdC9UFEGhaTqrMICLwfcC5MMBolyO6FsF0TYPthXIP+FiSV87sC5+qBm6pQjIp3hHw==
X-Received: by 2002:a17:907:da8:b0:aa6:7b34:c1a8 with SMTP id a640c23a62f3a-aabf497399dmr163808766b.55.1734511628681;
        Wed, 18 Dec 2024 00:47:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9600df0csm538175266b.24.2024.12.18.00.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:47:08 -0800 (PST)
Date: Wed, 18 Dec 2024 11:47:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	krzk@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: stmmac: remove the unnecessary argument of
 stmmac_remove_config_dt()
Message-ID: <8dcb6337-87d9-454d-8f71-295d69c5c785@stanley.mountain>
References: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241218032230.117453-3-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218032230.117453-3-joe@pf.is.s.u-tokyo.ac.jp>

On Wed, Dec 18, 2024 at 12:22:30PM +0900, Joe Hattori wrote:
>  static void devm_stmmac_remove_config_dt(void *data)
>  {
> -	struct plat_stmmacenet_data *plat = data;
> -
> -	/* Platform data argument is unused */
> -	stmmac_remove_config_dt(NULL, plat);
> +	stmmac_remove_config_dt(data);

Instead of doing this, move the code from stmmac_remove_config_dt()
to here and delete the stmmac_remove_config_dt() function.  Delete
the comments that mention stmmac_remove_config_dt().

- * Description: Devres variant of stmmac_probe_config_dt(). Does not require
- * the user to call stmmac_remove_config_dt() at driver detach.

This comment no longer makes sense.

regards,
dan carpenter


