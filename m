Return-Path: <netdev+bounces-67192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFF842485
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0696285F4C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937736BB57;
	Tue, 30 Jan 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e/y5G3LJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07846A35A
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616529; cv=none; b=a4L2k26r/Mc6n8C1FACH7/Bbfk+iepC/5heSqZVQPJH6OOuDzZ5ADGPT1v4NnUwlrMdAhMesnNl2N5H9+0fjGCnvG3Kv+ixSC6Mq7e73wa8vy5l7VO//7MSE+x031vTQqw2YGb92KEKUQoaVXGZuG3W0sPxANGGIu7XgJXkDluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616529; c=relaxed/simple;
	bh=2r7pCTPenAGTrjvdUYL6iIL2tUwKbnq5pdG6LxtCv44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdVOI/urEEPIbmeSdCKMtrUyiI3csf248qDhuRnNRovAuxt2+FN4YFH6syCjAGU1+ojXKvtBLbAV5PskMVFyzxXSNv8ylDEPO7F72O1Fx+e3SbqAcfxuASmR2e3FyZR0HbrMBySYw6ybZ7MPfpvtc0sQnWCY9YKG+F8P5M34evM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e/y5G3LJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51028acdcf0so4746003e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706616526; x=1707221326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwd8ySuX8TV+WUgeRVeK0uQOqvsOqqfR4ZNUswkEQMY=;
        b=e/y5G3LJeouKqqHqKvVil6IjpdjPOHQamLF/nZZIg1bY3lb31HLOPMtmNR6+tSpad2
         9n6Eoac2lzC4DI+v/MBcjPQmMgO6Mdo51N1xAseSDq+a8Na1hXlqR9A7alqpdHG7nnum
         SrkZU6vqspBpriLoKFWz5gHoogDAILLb0zxccaQ6PsUfYgno+bqvcmgeulq47i/af8lH
         hfLgEJn1xkuZOv1yRse/DykIheZ7PskkhNSRAZzmRoQGYMZ9sl3Ppws+4P7cs2lkBrOK
         gfW61TvTsB/vwxNZjhnqImgnFg5RVvk9EhJRfLJQk18HSqMPhk34E0QMwbCacW7CtjP+
         +ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616526; x=1707221326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gwd8ySuX8TV+WUgeRVeK0uQOqvsOqqfR4ZNUswkEQMY=;
        b=TJ4j8+/v+bOWw2wLlgFJXz6IqtRCfzdyeAzV/9u/trpIckIEefp+WXGN7F9klvHzzT
         nAilVDEiZuj7KxEOfBK6MPVS4Y00kCMnj7VI09nP1QylkI0XX3k7naqur8gyDldJdpA6
         sFixEZcLb9Sedb5/l4zTlsEfevXtcWag13Js1KMkixJTj0ahC497UjYl3lM1NXByU687
         RJnczCjzmWPdNBCc28KvGdxXL7LABnEJoSv4OpSFAk5zRH/Wl65jND55h/IQ7stiFkGI
         I5UJhDHpF+NFX15phuvyKxsdy4diMSnh+wLxEcU72lq/rog5Bdg2w4ShnEameCzzoAZj
         5S0w==
X-Gm-Message-State: AOJu0YxLNkbxCAx4pTW9ITNTXkfNWfw1IedAfBZlUm/UD3+3MaTvfhY3
	UYCu0DMZVyPDTmBrEsV+eqdc2So3V9w593OgauL6OyI8X7NJR3gH0bBIRGU2oSTJsw/h9gQL9qV
	X7pU=
X-Google-Smtp-Source: AGHT+IG1sfTjotduHVDTBGDEo0FPpT+pKnhVr0tCsI4LtAotPkZD1QPOLzKyEXLbTfinqg/Y0LC1bQ==
X-Received: by 2002:a05:6512:110c:b0:50f:fe72:2c0d with SMTP id l12-20020a056512110c00b0050ffe722c0dmr6044341lfg.56.1706616525594;
        Tue, 30 Jan 2024 04:08:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW8drNRmUfzIm7k/k6JhVw6t/Gzr4zv6bww/XlF9r/yqBsr5kRFAg11hS7/uAvtr0kfd7e6S1Xvm/kyLTr3yYV797IY91YD9+gZ+0HXVpYt6iL9pc0e8FTdbPIswo8+Xs6EVtx4nwBPKYjxwSaVQns7QSOTxcWSola57elw212iTYAijTwzw/0QveQCyMc5qAwLBepidelOhZ6c70FbMM3/XyvXluPWBV6XaC+ns890QcXAZW9OIaPMVNBlbbdPOoA231wqLyOZoGRJKzuULMLdNr6zE80tQCVtZjHJ/bVaI9N7SFBtuROqEGpq1O9qOdwbdhLenkEUZzAXAj3t28WHFB81t1nx+NXt2RQoMxUhk1CnLgfp45n/Ka/XrQaqPJJ33h+PXPC0CmoOIxc=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040d5ae2906esm16851317wmq.30.2024.01.30.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:08:45 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next v2 3/3] net/mlx5: DPLL, Implement lock status error value
Date: Tue, 30 Jan 2024 13:08:31 +0100
Message-ID: <20240130120831.261085-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130120831.261085-1-jiri@resnulli.us>
References: <20240130120831.261085-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Fill-up the lock status error value properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 23 +++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 07f43d5c90c6..4ad3d2d3d4c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -41,6 +41,7 @@ struct mlx5_dpll_synce_status {
 	enum mlx5_msees_oper_status oper_status;
 	bool ho_acq;
 	bool oper_freq_measure;
+	enum mlx5_msees_failure_reason failure_reason;
 	s32 frequency_diff;
 };
 
@@ -60,6 +61,7 @@ mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
 	synce_status->oper_status = MLX5_GET(msees_reg, out, oper_status);
 	synce_status->ho_acq = MLX5_GET(msees_reg, out, ho_acq);
 	synce_status->oper_freq_measure = MLX5_GET(msees_reg, out, oper_freq_measure);
+	synce_status->failure_reason = MLX5_GET(msees_reg, out, failure_reason);
 	synce_status->frequency_diff = MLX5_GET(msees_reg, out, frequency_diff);
 	return 0;
 }
@@ -99,6 +101,26 @@ mlx5_dpll_lock_status_get(struct mlx5_dpll_synce_status *synce_status)
 	}
 }
 
+static enum dpll_lock_status_error
+mlx5_dpll_lock_status_error_get(struct mlx5_dpll_synce_status *synce_status)
+{
+	switch (synce_status->oper_status) {
+	case MLX5_MSEES_OPER_STATUS_FAIL_HOLDOVER:
+		fallthrough;
+	case MLX5_MSEES_OPER_STATUS_FAIL_FREE_RUNNING:
+		switch (synce_status->failure_reason) {
+		case MLX5_MSEES_FAILURE_REASON_PORT_DOWN:
+			return DPLL_LOCK_STATUS_ERROR_MEDIA_DOWN;
+		case MLX5_MSEES_FAILURE_REASON_TOO_HIGH_FREQUENCY_DIFF:
+			return DPLL_LOCK_STATUS_ERROR_FRACTIONAL_FREQUENCY_OFFSET_TOO_HIGH;
+		default:
+			return DPLL_LOCK_STATUS_ERROR_UNDEFINED;
+		}
+	default:
+		return DPLL_LOCK_STATUS_ERROR_NONE;
+	}
+}
+
 static enum dpll_pin_state
 mlx5_dpll_pin_state_get(struct mlx5_dpll_synce_status *synce_status)
 {
@@ -132,6 +154,7 @@ mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll, void *priv,
 	if (err)
 		return err;
 	*status = mlx5_dpll_lock_status_get(&synce_status);
+	*status_error = mlx5_dpll_lock_status_error_get(&synce_status);
 	return 0;
 }
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c726f90ab752..6c44f107b8ba 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12705,6 +12705,14 @@ enum mlx5_msees_oper_status {
 	MLX5_MSEES_OPER_STATUS_FAIL_FREE_RUNNING	= 0x5,
 };
 
+enum mlx5_msees_failure_reason {
+	MLX5_MSEES_FAILURE_REASON_UNDEFINED_ERROR		= 0x0,
+	MLX5_MSEES_FAILURE_REASON_PORT_DOWN			= 0x1,
+	MLX5_MSEES_FAILURE_REASON_TOO_HIGH_FREQUENCY_DIFF	= 0x2,
+	MLX5_MSEES_FAILURE_REASON_NET_SYNCHRONIZER_DEVICE_ERROR	= 0x3,
+	MLX5_MSEES_FAILURE_REASON_LACK_OF_RESOURCES		= 0x4,
+};
+
 struct mlx5_ifc_msees_reg_bits {
 	u8         reserved_at_0[0x8];
 	u8         local_port[0x8];
-- 
2.43.0


