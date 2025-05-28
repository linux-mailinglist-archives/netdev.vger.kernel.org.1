Return-Path: <netdev+bounces-193910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8DCAC63E8
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09F91BC49BB
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C726C3A0;
	Wed, 28 May 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kbk5JKQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC98247297
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419879; cv=none; b=B5xOk5agLtIzW0/tp+PM4JJ0lpi7mjJ+gR8YfCZDTgIqr7d8b6/gfl3f025V4Oe77eP6kU6K8+BxMXNXS4uEWErxngUvffkJWl7L+2XLi8l2NmeEZ/Hk/sLsu5ZcjsalzWKb19zs7U6z8aoB9CVHut4hOuaq9Nx4GyaetYDAqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419879; c=relaxed/simple;
	bh=Mou1ieGyUfMk0Ql4ddZnpgGEyPlSxoqDatPUfQa5VIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c5twvG0LwkkuQFCeKlDPUC0A/FGLENl5Dxi4uTaTRKuVlfoctgcsdqIxlHTvgrvIL6Z/49WxPCMiZScWcbtck0Eld8EnWGeIJw6RvaHl2dz77n3SyvKNn7QdJBv4KM4uhUqbO55/reNMCXyojI4Q52yFoFR5uouWwJWW4XxTwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kbk5JKQJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so37535875e9.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748419874; x=1749024674; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eGBmhHpAoBCXn4dDL8o5LjT2W5woVp7uljWhl0TnKw=;
        b=Kbk5JKQJO6bcJ66sbfD5oJcyrM2Eejliy35OG+5TsyyaDjs1UphVXxvz3EiP24THym
         W8TL8L77U4YHJ2uEjz3x+Btwy/yLy/yJS1kaOqf+jRurQ/gbdnkgCjhiXLx2CbwwrlHF
         i4e+NhVR2c5Wd+mRuO5N8OIC9X6XkYb/X/lx3sKJH5zZa9J/DSQ26ZkFsee+QbtBOg1G
         dIgKxd+ojQZ6gOxEpVtS8F0VPAXFKr0keXb+YXs5rIa0gJOUnsj1lVfjGNbF+d3pTjrO
         7B5BJGNvbYJpEKWDUbZYpc1CbLUw5lLIb6wTFCSapplHE53XBpb+LM6c3JEEEBYnXvSd
         D8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419874; x=1749024674;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eGBmhHpAoBCXn4dDL8o5LjT2W5woVp7uljWhl0TnKw=;
        b=J7m6/71BDrvcUnbUWkT4c0PhJOCP16VIqrqu4Lrabq4eIyehb7PS5r5G9U2vYni1y6
         JEV37IhTpk3h/b6G7H+MqHSxgPI4KSvds2fzn0DK0I0BVoPLcV2ZGc3F7DIW8jYOjsai
         ky2tTmmL48nGJqISgaOapkDaWrgRZqznNwIMdQwd4RZwcVHanj0kQJAHVrBO845s3aQu
         ntG/DWHVgX3MBvsztyc+Uw8Piw60VGQcGW5xluTKgPNFkg2pkHiDItJ1ZSBI5GHHYQC+
         QqN5OH6f2BjnInxQ+Z/7QGjyCtNFvEKsvSV6BNfQlnSDtptjH07K6h34l5Mdglpev378
         /b/A==
X-Forwarded-Encrypted: i=1; AJvYcCVSNVu0n0msS3txJlDBA9W44K9stx5+cWMVvojCs/rCn7wFv5hgZCFQ35jZ8/Ml/G8ku7LeFyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnPQj68lzIxFr8/1fvSXdh6P7LXRxgoBW2aC0xHBzIkV5Kv6w
	T81gwC+hgcq5qgkebZZsQpuHyJ99B2wQLzRgCDMmmtSqIaNPi+m+ZIeiXHJnmcHEZAQ=
X-Gm-Gg: ASbGncsqNvSr6dN96DF+WF/O53KZRCEWAwVrQaE/KhVFqAyp0PZXe0s4Lf5M3XadtEl
	xW2o3miAMwNTX4rTSIeOSbdKmFDgumCM4yjoEodPT+qQHV8yFKmvcarCR0zrO+B1HMEeRCMFPBb
	N2DG0u1pHn4EcBU8tW1LcQXMGo5d8t0EF14tPx7bfLafzqhBszSQSQuiwZh/u0wgmJRoFn9wQQC
	Bez23OrBM06vu2jnDnOkLr4SDJS/i86nK5aRLFrtgHg0nixDCjbBV4lrsxMYpl/3cWZjxLlUoDT
	GwF8bQ/o8eHtxmNwE7HUgzWXeYYOEXJC6WLgkrcJptsjZmQXHvs4U/G4
X-Google-Smtp-Source: AGHT+IGyt9pIlXzNb8QFnz35HETogZyJleM14B194rW68Yuuufz6AtscehzIU6fQJn738bKFOwrivA==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:e8bc:594 with SMTP id ffacd0b85a97d-3a4e8bc0917mr1162825f8f.8.1748419873739;
        Wed, 28 May 2025 01:11:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45006498d2dsm13303805e9.4.2025.05.28.01.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:11:13 -0700 (PDT)
Date: Wed, 28 May 2025 11:11:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eugenia Emantayev <eugenia@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Matan Barak <matanb@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDbFHe19juIJKjsb@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
for high frequency is intended but the "freq_khz * 1000" would overflow
the u32 type if we went above 4GHz.  Use unsigned long long type for the
mutliplication to prevent that.

Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Use ULL instead UL.

 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..d73a2044dc26 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000ULL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
-- 
2.47.2


