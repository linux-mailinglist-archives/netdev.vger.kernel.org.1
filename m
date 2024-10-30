Return-Path: <netdev+bounces-140287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062D9B5D6B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE311C20CCF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066551DFE16;
	Wed, 30 Oct 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bArtue9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40F1E0DD6
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275933; cv=none; b=m0D6RW76sF1qVv3jKADk64AF2MZXVnw+msiXA4bHJfdUJlefNhiZdWVnvxQcKxhIItiDaD5mbSrsqUnL+OV7K+vXdabNDkR9HAgL2Kak8E2X0A/W1oPalisqJljkJcwv3vpiIxdlsqTB5/sFKPXft2MnpQZaR5lOXp7YiCgZj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275933; c=relaxed/simple;
	bh=Cbszx9KO8ha9vFeT5cnVcidPTMVwQi9KD3CTiihJ3sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnvycw/AB78vpMkJs6DJuK7QpIRD12oiT/ST8DfZur9HSGTmeXMAgz96geV/7NMxsfsLstnM9P2yqPgiBieFPNAIyzwAOzrpbrIGYSkGb0oyAKxKvFqdCddm7yQe3jtbbYKjPxmuSaQz3Y/bJtjQhEBy2kRp4daenE41s4tDR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bArtue9n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431481433bdso60825125e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730275930; x=1730880730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+gqwKCE3IiO/c9WgVIha5lPT6Lm81W2JJXzloOrm/0=;
        b=bArtue9nKmeCPoTLB6g7cQot3wfmifPdn4tPoHanz90MLQ4wcpUG7Xbbo6zim1fj4s
         bL7y0KvV5xxuJwO3Ymu1Cdy/41mZWBjjzjQv27VOeqpEHvChLKk7cWAonj7ixqQ1yp73
         1TA/kJWJbmMRpLczZJwWpY4GXJ1m95jQpBSwtLp+B+0nwgbsJ/5+2O8tLvo03fqVxRsO
         2/MwLQSATQRuIMgSbo4MgEWepAwExgWr9CNw8qF66pTzdTlk3bVtaPzaLyRp6cH5YULh
         j1VWLq4dNTO3YwQfXiPaEwGaGV5c+zfUsZqZd3F+T+YVsAmR1w9idjC5NJUKfTJFD/EG
         k95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275930; x=1730880730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+gqwKCE3IiO/c9WgVIha5lPT6Lm81W2JJXzloOrm/0=;
        b=r1/7ILZCyVJWBhoHMpZq8TR3KNl6fKVkl13xGMeKV8efE44yUqth5s8gg+Gfiyg1hV
         /vY4IU3cRyn2pPsavPy/ck7DzAcLvqotEvkHg+q+V9BOXild3V8s24C2tinbKir2gQD/
         dB3YUOhFDYBv8NV+d5xaMU36Y8SQ0S3KSoidFvx+sGhNPLbkcpY4xrjFKIWDqRjUGrD8
         95v6vpqYWeOilaq8cDAgC3vcEn6WXABRQTQw7IQ/0THBFMFUAsHczX8KrnGCHvpWGH+B
         kByAtpVXFJ9S5Xjim6kfZ/6G6i1iNvzRF3i/qC/DWsNb7pTrPlHkyu0O/6gEbNYNEtJ8
         T3GA==
X-Gm-Message-State: AOJu0YyYTOFdmo7tFUGdhanyCm+YBx84xVrOMvT/tr08N+Hw9TQii8zo
	TzZ21ajF7+gn0/3HUVLsdZ/zvC/lzfWtlJ965BpkPzmwWIGKmZuop07W0hnWAKpWEYizhNDWUVn
	pjHo=
X-Google-Smtp-Source: AGHT+IHanPVo+KF5AWksdAFY/Rurm9SaveewE2DqZ79ArAL1p0QYoNQhgLASP8h9frxuWpo55P9Evg==
X-Received: by 2002:a05:600c:1e8f:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-4319ad0dc41mr130547075e9.22.1730275929915;
        Wed, 30 Oct 2024 01:12:09 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947a9fsm13515125e9.22.2024.10.30.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:12:09 -0700 (PDT)
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
	tariqt@nvidia.com,
	maciejm@nvidia.com
Subject: [PATCH net-next v4 2/2] net/mlx5: DPLL, Add clock quality level op implementation
Date: Wed, 30 Oct 2024 09:11:57 +0100
Message-ID: <20241030081157.966604-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030081157.966604-1-jiri@resnulli.us>
References: <20241030081157.966604-1-jiri@resnulli.us>
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

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
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


