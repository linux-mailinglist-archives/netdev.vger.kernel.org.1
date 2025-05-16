Return-Path: <netdev+bounces-190955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13488AB975B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D0FA05165
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B0230BE8;
	Fri, 16 May 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dq76bI5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3039230BD5
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383391; cv=none; b=FI7J6B/wyK4vWL9Q2DqC8KHuTVdL4io0TANG46YgFxKK6k6Vsh4qwVBBPa0RvFSL86Z84LVA2etaxgfQwJMV2QAtRI/7hKmVzWVsdVx5HIEegZElPklGV4dUoGX8NlK2LN04sAblJafJUpTdXyVrGAYvqNwzmtlyO3e4nns6CHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383391; c=relaxed/simple;
	bh=9Om3pCVh4DQs/g5WxN71tZrY8Z5myBckCvfA7xSo7S8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CQXseWKG1peKjgzTgCTmW37Nwfa2X0O/RW5jphbS9bR6FocVUqt1/XICGUPZT+iTJmi/20zYIKXA4tYvjTUqNPAVnQf9II5Ed67bvv16HhnTreVXlJkLO2E2VQNOKw40yfw9/Y3/1SQGVpCY0o5j27r52VaH594he4aHx8xnP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dq76bI5L; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441c0d8eb3bso2671755e9.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747383388; x=1747988188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Tv+bX6ZlmsD2MRpJhDybpIJBQMc8p+o4XGgPlDD6Nw=;
        b=Dq76bI5LfkjFzuOI8RJKVdK5jr1DdiSTsDu5uXepnQ9TLJdRc4Sg9Y9imPxZmrLaga
         z8br3TJXE6PPX3+yc7yJl0zWWmNLo2sQN+HncrTKq8TClrYZrCm1Sgb0QcF++1O8fLBt
         RWhhXtRcfeX/iyoxgJwrZZ5losDUWm6LbACXbT5oRFdYXdkOqxeMobLcVKc0d4sHc237
         Mw3gA5HdXsJ1DHobSho5UDXnjEwnPzGusD7UZXgUqIup6ruJmXMtXhO0pK5mEQyDQpcz
         xf7MsTSW5dGLdrpYQmVOvtU9eXbQC7/Ftxt01PxvBhjAMOQZsfdH1ddIVibqg0tkSTPD
         z6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747383388; x=1747988188;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Tv+bX6ZlmsD2MRpJhDybpIJBQMc8p+o4XGgPlDD6Nw=;
        b=cTTkDY3Z0jz62/de1Q5OpYdtQo/OZAvNIDAfdAu/YPhxohDn9od+bOtg0NX/PqRcgc
         O/g6l17PXZvSSY8ov94yMUjeo5rSBBr3WTaJxN7rQWcghY3dftJRDALUVQtz8Y35QedP
         bGNMottMJco3rUDZAxlNj6IUCqu46Rcyi5aeUrzpAIwOQnr1CscWhkw6BgpaoJsopN9F
         2oul/c/eHVp0GTsHynTBljw1ixrceUigT1BnwCldlicc/Jds8GUJVqMwW1fLOI7I8Io1
         7eU8vWDFt1xi4JYpYkamaCPocCpwUu8YorLYtMd2Z0xsVID+jKi4Kt275Tk1+AtxShic
         kkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXAI1G1jbofwVIy1JGLcpcmDScw5s4K8jk22aNSqNliFcOO/36+2+dQ53IKYa0c/Jqr1fd6aTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbi7/wrAYzIKAeT61Uys0XcxkyItVXd6x/CUn4NUllAWt1NeJ7
	e9MKSNrfg04jQZgAIg7oPxwqoxf7maNbXm7bBbpybZn4H3TqDzi+7zh7VQUGuHhqmVA=
X-Gm-Gg: ASbGnctlbH0MmdWlT6v4el8keOFSGEfSqSioJZVE8p/XEXdUOUzrTlP6SC3hmVvG3QE
	sE1UaHL5QmBz3C1iBCKedKwu76/UEI14NfcgYTD+FyPmMpNhAwnOlDRNXPjvgTEVyEYNAG5M1wK
	dgJXuX3livEKivAb/lVNTUqwTwki+vKWPJ3tkAiWinPps3ADKcclrQHVLeAmrJ8FVhfgnuV23fm
	GZ9HnNHxqH+ZMpd0fZRDqsaNgTWRDCM4vPxCoSQfNQLLaiaawIjNm8TvOkjfBdGrT1h41k2cQTv
	lX/miOTsBYWU+Q/HNOYIluHLU4g2BZYkXQ2AFEOM765PSktM3PpS99itUJ/isoSpraJZVfIDQcF
	dZATN+9PcqgFl0v0ZCA==
X-Google-Smtp-Source: AGHT+IEkIkw5elhOyTB83C87OFiQ0tJrARVHpD24DDqhIh7HG2A3aYWsL0sD6JFgRgRzOP8Mln1ztg==
X-Received: by 2002:a05:600c:46cf:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-442fd6845d2mr8039595e9.8.1747383387870;
        Fri, 16 May 2025 01:16:27 -0700 (PDT)
Received: from [10.61.0.48] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd515130sm23980885e9.18.2025.05.16.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 01:16:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel test robot <lkp@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
Message-Id: <174738338644.6332.8007717408731919554.b4-ty@linaro.org>
Date: Fri, 16 May 2025 10:16:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 15 May 2025 16:05:56 +0200, Krzysztof Kozlowski wrote:
> MMIO mux uses now regmap_init_mmio(), so one way or another
> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
> !REGMAP_MMIO case:
> 
>   ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
> 
> REGMAP_MMIO should be, because it is a non-visible symbol, but this
> causes a circular dependency:
> 
> [...]

Applied, thanks!

[1/1] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
      https://git.kernel.org/krzk/linux/c/39bff565b40d26cc51f6e85b3b224c86a563367e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


