Return-Path: <netdev+bounces-197029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8616AD7668
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3856188E81C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709829DB77;
	Thu, 12 Jun 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAg/G+SW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68BA29CB58
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742194; cv=none; b=qdu+/1QcwWei9SRpluMFdVlkxKuWAVlJUJ2wKyKBKdSm6O8X7nNVHaQx7898qlMDmPzR/pmUvTDlV5oVZpalJWaez0wn8sCyOEXT1/AV8GYbfUjYnIl0yXY132i6yBQImAxtZPslw3HGUlhtxysU+VcDCRBE0fGcYkC64VvD8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742194; c=relaxed/simple;
	bh=z0ar1hJos7ARhEgbjSSfr1bzntLG3QJmXsE49Omcdw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E8Bm8DeVKNuNwP3l6LfJjuFl7hqDctTEWrWK4nHrRroFht9HZwTMV358qWoriy6rq03k3wyZLStnsnz7+l1N1/ZiY2oUTi1M+foFDUOzz0VmkfdkRunAIFvTxw+OKzlv9ARrn1npFpPqHGnvmJmqeKycG+SsbQb3XcqPIU4FhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAg/G+SW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450d08e662fso1090645e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749742191; x=1750346991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKvQ0kizkJd8CblYTjjvTx/DyqmBuLZOpwvQ/Oh9KYc=;
        b=rAg/G+SW2txg0b7vzr6ipT/igZ8ZIsSUxWPPHeSBCfVOdSeb37vMFzo/tnXAwVYVDG
         AjduHqrBXzcBgJQmivIkFdCh/UVcFd+Hi8xsj3ZPERGr76CSuHGbnxjF/6N0Y7D7JqRM
         p0nSVJvXoGYwosAy4osuKRzZdwWJeoPMmT8SFkPvB5oiQx9xBg8rX4kRm94p0yGeF0vA
         rCyWw+crKm2xq4MwJ9AtwYZ/cG4t9zn2JkCbD7AMtdqFdF+ZFm5l0mVAWt0tN57m+FVf
         yKLkPof3O1Po4Ju08M4Qb4BVX6M67vubZmCeQmGbdDX3isCSsEAgqGNYS6JpbzOJXMlO
         idAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749742191; x=1750346991;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKvQ0kizkJd8CblYTjjvTx/DyqmBuLZOpwvQ/Oh9KYc=;
        b=PlAO2jrM12wgdPj0cct+46mZgHzKEzB0YK+ZJ/P2XU78yUZ7F7EJu5eFCUw6FtbURT
         yGO55FqQ9ZX0IBD6jFetkiGMTeZyalKZI8xZc37BJEPfyw/oHG1wjjyWwApTzKEFw2X4
         /SkoV20T6dxw5vhfg4RH7P4O+kpsv0VrH/Fr+q3XorpjvEAKMq+QTUb9hAVrzQ/RgIcI
         nZBfVX3p+ujIdsrXVJKnXUuuxvj0NoV/LvDLX/APJHV84PJvsgIbNL9Bc9y4jNpL21pU
         OKjap21XV91dAMRgiSotlX6jShJ5chd4LjNsCnOmVF3yQ7Uq8qAT8aHM0i9MqFW5CDif
         p3WA==
X-Forwarded-Encrypted: i=1; AJvYcCXY3wfCQ4did5Luhh5qrq6edCLvjvkhB39wDoB/Q2iLHRUdUFa8ocaWdpY0f1UOaYbVrt5Dy10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1XyNQKZ8SFd0IkBErkJEZ8DF/Sj1qqP7j+O5LpRdSJLwvnsS
	DXb9QH6AAgg1mlPVOnkzEveYbnG3o++HN30TyS9u80p2UNrv9p1wXNU8RVGzcKitqKQ=
X-Gm-Gg: ASbGnctOlC7oC06yKIkFGtkRwlmxP2kW9m8Lyn1Iuw+aEiVv21DznBRhgygjN1S5JUO
	d17ClIWvpWix0gHnFSb3a1hrGjoaP1qEnE+8p6WzmYgmLIHUfmNFanF8YSRa4w54irnkj5Eij9f
	F8Tj32R3XwvjyM1z3hxgPaXnQ1ot3m7KFaA5xhsPjuyuFCYTyyopdtlDivlIW88AZokETCjioHF
	nUEg+5HhR8QPWncbSl6lXyN5WAeOjVS2NNyybRD78VJiiNDnJaCuUDNCLcN2q6flPRwkgGgYV0M
	cJXo98ZoxVW/mY/LwjTWYdAAhNbUkZY3ZWq//0CI3ptWb0pAUYys/zroNqNxwwZJSb3ukaoqjEn
	JuqVugs4=
X-Google-Smtp-Source: AGHT+IHcEf5K0JeoZyRffkMk2oZLKO8IT8ky+qUldOOWFDZEO8dRcFFzDiYHDmEiK60pzDMoVYDLyQ==
X-Received: by 2002:a05:6000:26c1:b0:3a4:f8a9:ba02 with SMTP id ffacd0b85a97d-3a5586b8858mr2648512f8f.1.1749742191063;
        Thu, 12 Jun 2025 08:29:51 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e232e4asm23557265e9.11.2025.06.12.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:29:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com, 
 sunyeal.hong@samsung.com, shin.son@samsung.com, 
 Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com
In-Reply-To: <20250529112640.1646740-1-raghav.s@samsung.com>
References: <CGME20250529111705epcas5p25e80695086d6dc0d37343082b7392be7@epcas5p2.samsung.com>
 <20250529112640.1646740-1-raghav.s@samsung.com>
Subject: Re: [PATCH v3 0/4] Add clock support for CMU_HSI2
Message-Id: <174974218878.126240.878153774506566554.b4-ty@linaro.org>
Date: Thu, 12 Jun 2025 17:29:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 29 May 2025 16:56:36 +0530, Raghav Sharma wrote:
> This series sorts clock yaml and adds clock support for the CMU_HSI2 block.
> 
> Patch[1/4]: dt-bindings: clock: exynosautov920: sort clock definitions
>         - Sorts the compatible strings for clocks
> 
> Patch[2/4]: dt-bindings: clock: exynosautov920: add hsi2 clock definitions
>         - Adds DT binding for CMU_HSI2 and clock definitions
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: clock: exynosautov920: sort clock definitions
      https://git.kernel.org/krzk/linux/c/3d6470990bfc8600609177962a53201cb0640daa
[2/4] dt-bindings: clock: exynosautov920: add hsi2 clock definitions
      https://git.kernel.org/krzk/linux/c/da5cb65d25f747236a003b82525eb6de5d49a2e6
[3/4] clk: samsung: exynosautov920: add block hsi2 clock support
      https://git.kernel.org/krzk/linux/c/2d539f31ab0eb3eb3bd9491b7dcd52dec7967e15
[4/4] arm64: dts: exynosautov920: add CMU_HSI2 clock DT nodes
      https://git.kernel.org/krzk/linux/c/e2016763590f571cdc3912d6a7ec848d2b61e6c2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


