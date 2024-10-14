Return-Path: <netdev+bounces-135088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E099C2B1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4508B20F2E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD8142E77;
	Mon, 14 Oct 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k5JS3CIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEB14A614
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893509; cv=none; b=NqhTW9VtlH4A3gRUlM2f2o+Vl+sY+LIczML9Tm4GoT1Ar9mwcy8VB/Ko6lgl3N+2YIguRCnU1eJ0spELtH0d9sJE2VI46t8j0veuYge9N6HMuSplL+22/1mYXPI5u7WyvAHJVzNsEh8mv98rOSoySwcQWXdTDomieV/rpOWFKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893509; c=relaxed/simple;
	bh=/l6gxq3iAlBhB5N7mngdojlhFo5InTxsUKmnWZ5ahhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBR9KIU3n8wNpqv2rFif3Iq/MAZDm1dz3k8t+XvNkvlYVgd39cMUt/KHZVzC9j6geDYith20BJj0RBROwoQQiZnArK+s7pAn/+Fvkm4VN49W2Uu1k03BZgN0rQbRcMgqBxJ51jyRpItrQ4MHBdJCwP5orsaOdueeIPgGcVayVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=k5JS3CIK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so2516969f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728893505; x=1729498305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtlk4Cn2nViGcObj6t/uU3qZmJxtGsh2I5zxl1Y6pGc=;
        b=k5JS3CIKqh/zQb00oNgB/6uhTCB6RJfF3CEYPzZLSf8Cnx5qSlBpz5wzLh7EeUTYbV
         +S6OaAwdE24DnmCwk4H0ioYjJRtsAXNKGe21m9tE9pAyU68ml73DKGGKqVJxTIcjeQxK
         7SnToTBl/gJN7+8CwY8OwvDkdk/ztC0lxvHPDHmndrCbrYnFueLNd85Rx6XBcxtZlmWP
         N94iLDorcxbdDJCc4ZkL7/h0xUs8bE+02R2PCvbanyF5Q45kPYCKDftdgOJxtCyjMjr1
         eeXLfbryiXGvP8rAWifOfqHwgYWGUzclyH4v1Bk0sPex3MZw8yzDoV4HwwLAB/zeD2i1
         Cirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893505; x=1729498305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtlk4Cn2nViGcObj6t/uU3qZmJxtGsh2I5zxl1Y6pGc=;
        b=rlSEVrnYSyOtsVA2iWxD7swHuWmBQK23CMjs9d5TyS92R4JZkrlTDdP5FKi7SAmQSJ
         YJqkd1+InZaBIoHg3fVU+fd9JIHHSwz4j0jwyDCwrc7dY7H5FweCdC/B267Dj4SjuE42
         GuqofpmS6kkNo1JDgwwIqAwMHr8uv62ZPNBpg6K4Vat6Sa6AdRXFD8TegtxFlRkVlxzy
         EGH5N8DKy+mnyGLC8skFBp4D7uF0fNIj6EVv8PBlnV1dsKVuhRikbTKILrGgqgn8lSSg
         mzbjamXlcZTcvD9XlU67TsZwS2Bx+HA++0lTI/hNTpMEUe2ZNv+91aSp8WuJ6Cpr8Wx/
         eaJw==
X-Gm-Message-State: AOJu0YwTuaqf77vJQGuOPlVbEBusKa6oloMlTY9whHFmXTaGg2PKe1GU
	IS174xpyaK0Wzh7+AF6nBLk8QBa5HB3oxe0z1PZZ73shRgy83dfRMIV2RVy9C7M70DayB84OJbs
	DQbs=
X-Google-Smtp-Source: AGHT+IFVadDqFn4W2OM3xnBmtL5bTrZwm9FTSWVLunva3iMGbfJ/SWhndJsm8JEw6znwEOz8kVDLvg==
X-Received: by 2002:adf:e54e:0:b0:37d:45f0:b33 with SMTP id ffacd0b85a97d-37d55184ae1mr7072850f8f.9.1728893505301;
        Mon, 14 Oct 2024 01:11:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfb35sm10668400f8f.52.2024.10.14.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:11:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/2] net/mlx5: DPLL, Add clock quality level op implementation
Date: Mon, 14 Oct 2024 10:11:33 +0200
Message-ID: <20241014081133.15366-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014081133.15366-1-jiri@resnulli.us>
References: <20241014081133.15366-1-jiri@resnulli.us>
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
v2->v3:
- changed to fill-up quality level to bitmap
- changed "itu" prefix to "itu-opt1"
v1->v2:
- added "itu" prefix to the enum values
---
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 904e08de852e..31142f6cc372 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -166,9 +166,90 @@ static int mlx5_dpll_device_mode_get(const struct dpll_device *dpll,
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
+					     void *priv, unsigned long *qls,
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
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_A):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_A, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_B):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_B, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEC1):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEC1, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(PRTC):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRTC, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRTC):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRTC, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEEC):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEEC, qls);
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRC):
+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC, qls);
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
2.47.0


