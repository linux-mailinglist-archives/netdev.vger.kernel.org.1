Return-Path: <netdev+bounces-193565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F7AC47D0
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251C43A9536
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7B1DB551;
	Tue, 27 May 2025 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHBTFXVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839372AEED
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325108; cv=none; b=aSB61djZ5O3JGSFsT9Q5WAU4RuHeaQ7lso0sfydavSFfZUtS2xu0IOrX/aXhQvKf96/uEqoSbJ2ZT5cX3RsDY8//Zu6+0mQ4arUpg96cuPctmApQCiXl6Aw+mLw7u74o/3zi9jCCFvh8vHkOt5j5ZmLAnLv8gXoty9D1yXi9EXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325108; c=relaxed/simple;
	bh=FRU9W1+DS8rfpo6UNzEN6UMBg1u0Yz12fF9f8ZKM/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VOU1Gl6/3BGRkzwHNWJP4Mjtc8tpRZ/HCLfYtr4/Zbeoc2C9FIcCZfBndG+yjOf4EFdyWYUbbGR6IdK8/Vq3l9auKqaM3X8E+3XxDgZlz43VZTZ29SQSv2qcxE18qYpgGI+hJta5OPmODYRcYS9ZoTU834TOl/CJBLr9L9fMBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHBTFXVq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so447401466b.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325105; x=1748929905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVp2NY7FohPgZU2Typ+0h2uamFavzqINb4M9GCUjHoM=;
        b=bHBTFXVq7lydwB0QzS+hm0UM3cfkRYU8KwUkLGuYw2TcnPaOUTR13DvGMIXmoqNmW0
         HA2S3B579S0TlaPnpVn6T31o4VgrKCs2yJXpOTDGwxNxKNBh5Hffe+Bp5do0pn+GjdgR
         MpY0S9SaXpe5RFJEbnAdlLvQMlEKhCGG4bEzvW+a0/HC0o8ikkSUFjzTH1VKlodI4J1C
         l5Q4C7TJGoPgeNKaJqg3pzlnzd0+cs0RzloH7ZxFCOrwLaQs4p6zoG21ZdvrPMWPYWyE
         xmLtJaE+wHldpnrw3Y5Z2cJpuNTp3EJ3H5Aiz4sZGlXTfu8IaEpkray8s4svhPcYmgfv
         +5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325105; x=1748929905;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVp2NY7FohPgZU2Typ+0h2uamFavzqINb4M9GCUjHoM=;
        b=qrBMB2Mx9Q7AE3TYG8cF2uGKWkgZtT/cxnki8Bn2bjD+3MyazD1WxkvXR7xTCU/hHx
         8hkPqdbk5OVhBnZCM6EAp69298S/QtDfMnHN0RuC2DX8ZHGFZdsGSH2ZSpuN2+A+kvA2
         w7k4NdUMi41fZGsgXpMFftsrTkZyavjPJn+fO0MhTvhATl1csQyfWFbG449nPVE4t+Bx
         KStslidN1f1rMA8RFGzEbHEL1JXPm1ktciq6ba9bVVCo4HSETOmLdWDNHx0/hkqmBbX9
         Wp44XbcvUY4ht7oA9vs7lesQmYukv6TK87Hl1nLALY8lRV/J6C4ieSkVaxRpCVPf1IYc
         loSw==
X-Forwarded-Encrypted: i=1; AJvYcCUKcnSHyV0kpQ3L3i6ihpzo9osyARgquPf8MOtvAi879IFvdoeoHItvhzGMNRyJqb+a/F0+VMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbykuNIq5ve/UVB9rz9SL1RR5a04QmTD2TTaGwL4S0EvGzCm+
	6kJg6CQByVHEfhINYsoBj0OygB+eC9ZmP4L0phS4M+sRXAfW09rPZgnIFj+XhefGsy0=
X-Gm-Gg: ASbGncv+HFs0tfX28JLw9KZ6freLAbtZgEXZ3Nagj3ZFNJE6Nr2q8VKgPgtwnN0dD/u
	ZD+KD7znVBkHCYQn5Zx2yDK73DZ5Oi8M9xx2CQQIH6DmJW005KdUZ6AgagRUeWQOqpQt+y4YarJ
	H9dHNfpwjk90I8WCdxkzfnmwXkGYI91guUUXac/KoNgGfcGmSciUIG541cOistsYBr6sOaRdrcS
	oxQSswxmbg/TdhHKF19Esbz/oEM+tePrdZyKN5JbZtRzYtff96pfsRBpYLcxFJiSEMkNT/HLKTF
	9uMkmsZDyDuPtYFr00YhpnocJs1NsnG4+uNs9rJ5kaqWjSv0k6OozusoAVSwDNHzPMWB3pBAGM8
	=
X-Google-Smtp-Source: AGHT+IHjsxqs/6jcL8C7UZ6kgwo4G0JpqJqenkT3mjexlsQRl4jPPZvuq7A6WGfuQrzvXuOSfE1M6A==
X-Received: by 2002:a17:906:b84c:b0:ad8:883b:f10d with SMTP id a640c23a62f3a-ad8883bf140mr176024766b.34.1748325104785;
        Mon, 26 May 2025 22:51:44 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad8908a54f8sm40467266b.63.2025.05.26.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:51:44 -0700 (PDT)
Date: Tue, 27 May 2025 08:51:38 +0300
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
Subject: [PATCH net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDVS6vGV7N4UnqWS@stanley.mountain>
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
the u32 type if we went above 4GHz.  Use unsigned long type for the
mutliplication to prevent that.

Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..7abd6a7c9ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
-	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 max_val_cycles = freq_khz * 1000UL * MLX4_EN_WRAP_AROUND_SEC;
 	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
-- 
2.47.2


