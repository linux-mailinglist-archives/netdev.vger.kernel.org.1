Return-Path: <netdev+bounces-134220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EE99871D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15E3B22E98
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45FD1C9B88;
	Thu, 10 Oct 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yPuNHOdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D791C6F45
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565616; cv=none; b=Q/ONkHZiFuncu8qpfcj5Vd5Z2kOMnnWiGG4lPrqlOnHR0hA5/xRNv/oHT2XUGl9dk9bYbLnPjUZyjQ96ioN+MSPcV98mtco7vC/j8+TMNDmrEFD9ZjonBPbR4iB7kKD4yzeOpBG2hK2M1t7616AoiuNgfiljtSLIs8r1+K+1hlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565616; c=relaxed/simple;
	bh=OWQkn0MUW/mgdcHTmpEvTmkOW5fS/TnVBNLdryMDris=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSLFvglqskAoVHLeetxEpY2Q+HBumA1G0AgkVsfo+SfeQwIqkAhz+7qGNLJYGxG7z2pWU1yN3ojS5QuPwUtHpMLdBCNVDsPrOLBHF/GYaCwkWyK/O+YaA74gM+inLr5zeT0nxEFfDF+L+VfK5mQqZjE2snhLn6rI/sXlASU4VQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yPuNHOdY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a994cd82a3bso128212666b.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728565613; x=1729170413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNP9tX97GIxJUD92qKeaEfhfcrLGqlHC9vf8Y9pXLU0=;
        b=yPuNHOdYIX2aWsz7c6uReVnPHnBg7BKUIv7hPQEVYE12SeVBDYHE7r5+LMcVZLd4yZ
         hg8P4cHsqnvPTxniQ7igyI5dG7MCM84La01ZzABeuOCuJZBSoz4FNqEwzvobHeWFIcZx
         hQ2UdN6+gIbpCBY/y3OuYYZa5exNcI9wETPVCXJGldk+4CmSWUPKKGOxlIWodB6v+SYZ
         30ojT1x1GLOupNJ28HazczN8WUsaDaFfWeYT/K64AygtNMTKBtS2QagM9yyqulZoQaCa
         q2s7+8WbgyVIv/DRz1bHoGN/IA3dKCVKoMHrL8zQpXp3DNBCndT/fobg7I8/JoE5TXK1
         aMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565613; x=1729170413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNP9tX97GIxJUD92qKeaEfhfcrLGqlHC9vf8Y9pXLU0=;
        b=hmR8NgYMcyNuFC8Jumj4bjXeA3Jh0iXxUEfL7JKvT4JKtpWSJ3qsT/+PW7ewVYq0cY
         PqcFGbWYswfpyDb+/DW6MiO8R7llVleAbtqr9F9K37pA2Bgh9kbM3gi+/ObU6rTgC4HA
         HecfnPnapMZXw2qjEG8ZXX9HhOcPuFvGB8gx40z6C4RSChaFRuexPrIt+WbEiGh14Jw9
         wC+6TZlOWNzxLSnNanhVKxTY6ZToNzM4sWNq7ra8tt2aCzkKJZK2P1ZtUfeEN6bQ1idW
         uVi+D1vv7+toA0su7P2FxAEky6uUjRFGZ6/yWJVwycXOAiuF9OwsOf8QmLsJz9sAe95/
         9Etg==
X-Gm-Message-State: AOJu0YyXumwdg8EILDWEFcy5hSveyK3dYgZZBeeMEhv+CJsZSkvuFRcN
	8R7FbzOEf8kLn/tAvmv97Lk9CylyAXgRWlSBnaYoMQT41kRc2f2HuWdnlRxhfh3cYNXlwTlXfKG
	d1ocv/A==
X-Google-Smtp-Source: AGHT+IHrNRIB7LLSbzQ/YI359f1YBMO/pKtDeHMUZZgknMGEIuyVpTKxPOIM6pX3vjSrC2GkFuPeJA==
X-Received: by 2002:a17:907:e89:b0:a99:3f4e:6de8 with SMTP id a640c23a62f3a-a998d3832e7mr554842566b.64.1728565613197;
        Thu, 10 Oct 2024 06:06:53 -0700 (PDT)
Received: from localhost ([37.48.49.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9371533c4sm745604a12.54.2024.10.10.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:06:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Subject: [PATCH net-next v2 2/2] net/mlx5: DPLL, Add clock quality level op implementation
Date: Thu, 10 Oct 2024 15:06:46 +0200
Message-ID: <20241010130646.399365-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241010130646.399365-1-jiri@resnulli.us>
References: <20241010130646.399365-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Use MSECQ register to query clock quality from firmware. Implement the
dpll op and fill-up the quality level value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added "itu" prefix to the enum values
---
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 904e08de852e..ccb7477d77b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -166,9 +166,91 @@ static int mlx5_dpll_device_mode_get(const struct dpll_device *dpll,
 	return 0;
 }
 
+enum {
+	MLX5_DPLL_SSM_CODE_PRC = 0b0010,
+	MLX5_DPLL_SSM_CODE_SSU_A = 0b0100,
+	MLX5_DPLL_SSM_CODE_SSU_B = 0b1000,
+	MLX5_DPLL_SSM_CODE_EEC1 = 0b1011,
+	MLX5_DPLL_SSM_CODE_PRTC = 0b0010,
+	MLX5_DPLL_SSM_CODE_EPRTC = 0b0010,
+	MLX5_DPLL_SSM_CODE_EEEC = 0b1011,
+	MLX5_DPLL_SSM_CODE_EPRC = 0b0010,
+};
+
+enum {
+	MLX5_DPLL_ENHANCED_SSM_CODE_PRC = 0xff,
+	MLX5_DPLL_ENHANCED_SSM_CODE_SSU_A = 0xff,
+	MLX5_DPLL_ENHANCED_SSM_CODE_SSU_B = 0xff,
+	MLX5_DPLL_ENHANCED_SSM_CODE_EEC1 = 0xff,
+	MLX5_DPLL_ENHANCED_SSM_CODE_PRTC = 0x20,
+	MLX5_DPLL_ENHANCED_SSM_CODE_EPRTC = 0x21,
+	MLX5_DPLL_ENHANCED_SSM_CODE_EEEC = 0x22,
+	MLX5_DPLL_ENHANCED_SSM_CODE_EPRC = 0x23,
+};
+
+#define __MLX5_DPLL_SSM_COMBINED_CODE(ssm_code, enhanced_ssm_code)		\
+	((ssm_code) | ((enhanced_ssm_code) << 8))
+
+#define MLX5_DPLL_SSM_COMBINED_CODE(type)					\
+	__MLX5_DPLL_SSM_COMBINED_CODE(MLX5_DPLL_SSM_CODE_##type,		\
+				      MLX5_DPLL_ENHANCED_SSM_CODE_##type)
+
+static int mlx5_dpll_clock_quality_level_get(const struct dpll_device *dpll,
+					     void *priv,
+					     enum dpll_clock_quality_level *ql,
+					     struct netlink_ext_ack *extack)
+{
+	u8 network_option, ssm_code, enhanced_ssm_code;
+	u32 out[MLX5_ST_SZ_DW(msecq_reg)] = {};
+	u32 in[MLX5_ST_SZ_DW(msecq_reg)] = {};
+	struct mlx5_dpll *mdpll = priv;
+	int err;
+
+	err = mlx5_core_access_reg(mdpll->mdev, in, sizeof(in),
+				   out, sizeof(out), MLX5_REG_MSECQ, 0, 0);
+	if (err)
+		return err;
+	network_option = MLX5_GET(msecq_reg, out, network_option);
+	if (network_option != 1)
+		goto errout;
+	ssm_code = MLX5_GET(msecq_reg, out, local_ssm_code);
+	enhanced_ssm_code = MLX5_GET(msecq_reg, out, local_enhanced_ssm_code);
+
+	switch (__MLX5_DPLL_SSM_COMBINED_CODE(ssm_code, enhanced_ssm_code)) {
+	case MLX5_DPLL_SSM_COMBINED_CODE(PRC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_PRC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_A):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_SSU_A;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_B):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_SSU_B;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEC1):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_EEC1;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(PRTC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_PRTC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRTC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_EPRTC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEEC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_EEEC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_ITU_EPRC;
+		return 0;
+	}
+errout:
+	NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from firmware\n");
+	return -EINVAL;
+}
+
 static const struct dpll_device_ops mlx5_dpll_device_ops = {
 	.lock_status_get = mlx5_dpll_device_lock_status_get,
 	.mode_get = mlx5_dpll_device_mode_get,
+	.clock_quality_level_get = mlx5_dpll_clock_quality_level_get,
 };
 
 static int mlx5_dpll_pin_direction_get(const struct dpll_pin *pin,
-- 
2.46.1


