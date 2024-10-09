Return-Path: <netdev+bounces-133663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80699969F0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496731F23148
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EC194C7A;
	Wed,  9 Oct 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O2s0kvrS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBF192D98
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476768; cv=none; b=muGTXCBx/uEsI5yRVnSfyFjTAxm8f1eLHrhdqtcd/jJf6tY6ltWrsmw2n/SUf9ucT1iIvZGhoT0bcrnum5aJDi3epDiOZoFpKBBocitwIc9KMAekp6LIt5c51x3DRuovd0GXl0dQuUoQVrUkkh8YdrqAXjbuqyjK5u9nRvIN+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476768; c=relaxed/simple;
	bh=gRW9ytQ3Uem5cJczYPnbiRSXGAx6bz7kaTDgguMPx3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AImEVrig+JZHtJuXiGgXBis4LQFMTMOwN9wp5v+fNJyu6MGvJBKZFIO9umoXMEudM5urwN6BcfS5OGOuz13WK2f/hAvH6hD5H9mrpmEm/3Rb5uyJltAJVQrGR7UWAVl39Zxyg1VozdIeEnD2SK+5OANmJpO4WZw38Z7w7AOM1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O2s0kvrS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso4397606f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728476765; x=1729081565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA5sIi+msG2AVE+zse4mQ+le8iicYbP1tPPHeiDo9bA=;
        b=O2s0kvrSJz0hMb+Y7vgB697Qc+WBfENfBSruI8b9qTJ0lVI5UAUG2O1P11qUJ1IULL
         FpF/Yv+ZnZ4O8+v2p2IG+09EdRozXPX6MQOoncMPXXtdovI4tscHX85Ph9wXHFX+Mfnb
         hofIfLy2Xw2R/i4BR9GKkpZK4pADJbMn6+wce6ivty1VnWUtwu4eiZZMFdpKiz+GFyuG
         9uO39QOSSUwmY4ti9QWacEXOS3lBHPgwbO1QHDF2Cv/Jl9LnidE6IN7c3XOXcSHifG8j
         UHv6n9U5Aa81OPvIlwvStNBXbP5pk/BHkLjDrIt1FWzTnOdQCWc/CF6EOaxwqqxw7IyW
         xnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476765; x=1729081565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA5sIi+msG2AVE+zse4mQ+le8iicYbP1tPPHeiDo9bA=;
        b=O3W8MS6Dp0hcTuEZsFd/eoOuvOgkHo1JX1+8XtYjz+CiX/3KU9EFD7GVgqZvsioBO5
         sA0M11R2v6eiiwjz6yeVB0uDJ4blpEmtAU2wliUydyxCPqfMdHndhAGSzx8y4JtACRml
         avWy+Yplt2YaBE+C+Hovh7vsZiF4lYbaSYeD3b5udTSH4m+C5cHdXj7ME7R1KAb1FNJv
         ydRr57GhDo+oQUS4y+8YXSBmZ0TtzVGOXaUWyifvxE6vCF77qNDwTMn4vX4uMecYMM1O
         BPt7OrQwaJpOQ52VseJILMEof2tMhze1casLMFs6qTIfaFlGmUnZzuSA+dXNNfbM5Y23
         rFDQ==
X-Gm-Message-State: AOJu0YwCQlBKt/nyTSEzo6tyaFERGESRVoYKU3qwhvaEF9XjjFypNFBG
	Etvq/Q5VvsJ3aABEB7p9K9cl+lJv4/e47DMxC53+rtx76OGagR1f0xf6Rz4GJxeksan+Ogq9z6y
	1DhQ=
X-Google-Smtp-Source: AGHT+IFD4e5IZiJtVQVeMYAae3zR8WMsf+cDvvNl+v+h8jeMXvzjP5xXEOddEQCZyZbdT+6zboBE7g==
X-Received: by 2002:a5d:538d:0:b0:37c:ffdd:6d5b with SMTP id ffacd0b85a97d-37d3a9fc99dmr1493872f8f.28.1728476765401;
        Wed, 09 Oct 2024 05:26:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f79bsm10380148f8f.18.2024.10.09.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:26:04 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] net/mlx5: DPLL, Add clock quality level op implementation
Date: Wed,  9 Oct 2024 14:25:47 +0200
Message-ID: <20241009122547.296829-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009122547.296829-1-jiri@resnulli.us>
References: <20241009122547.296829-1-jiri@resnulli.us>
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
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 904e08de852e..3b901b47903c 100644
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
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_PRC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_A):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_SSU_A;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_B):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_SSU_B;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEC1):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_EEC1;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(PRTC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_PRTC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRTC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_EPRTC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EEEC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_EEEC;
+		return 0;
+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRC):
+		*ql = DPLL_CLOCK_QUALITY_LEVEL_EPRC;
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


