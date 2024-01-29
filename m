Return-Path: <netdev+bounces-66765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7064840933
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAB81C2273C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297915442F;
	Mon, 29 Jan 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mWbvpQqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A91534E6
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540374; cv=none; b=Q3rUq/au7bTh9ZnKNqTPhOt39avKuYMMMgAPiVaRWSmthAiXKgfJ7zvSI7DzpT+jDyYzog0lZMW8wBK6b9j980PumgR6A+xp800dLj1IFcgIEtdC11Iws90A8j5T9EbXeykIa9gd5kPfW/5NcNYmofNUJsX4FwM6cUdhg0cQ2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540374; c=relaxed/simple;
	bh=w+vtkcaEg4HOJ6EQ6DECN4f/kbuYjM4UKBSJAedeigw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE8+zOqBQJ5JkHL1xgqJTd8oO60o2o2RG9U1ipRxCRXN1q2sBsDNLJHBNopa+SvB4JjeXUntngQQV7Khn9gcRD9aPD/WVy4hTe4eEknXla5p2b7XzQN+OV7+Xwcepj2WrDYWierqPpVUeuc5B/53sMKwqQjiPkC9O0FsLDLgo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mWbvpQqZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso331138866b.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706540370; x=1707145170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mT4POyZmbKK1kuk+bzu1xvYfdLsCluJ/1k8wEuWl7dw=;
        b=mWbvpQqZojj7HK76nUm3l9U+mElQpS8RyGmM+Og48/omqLZXYarme6e069SCz06+qT
         5Q8r4RCDUC3jrXdwzzVojLO7U6xhvT/0OE3yH+BVtTWuGc0Jo3+GpkX6lQ7YsTYz6x/k
         SkBeTSS5TPn5/4H6SnzVUM2O5g2u0jYfVJlJJIhIPnYRj1lb0IlxQz1igQDlwV9quFS/
         /5/fEq2eGP9CuwdwF1gmc8cuNYC+BnOtMPDip7X2zU3/nLBjfFT6N+L4u+4oGk3Ftj4K
         T+sGU6Q8PUCmDzN4AJWtflqxqgYBMOceGz5iXv2F3GnQ3LqbVp2/CPRYQEVeuDAkTu70
         KR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540370; x=1707145170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mT4POyZmbKK1kuk+bzu1xvYfdLsCluJ/1k8wEuWl7dw=;
        b=lmxD9sm280Ma0TQRCQEQsgcWcOURrR2plecnh32uJTz1tVxV43Ob87qOk9pZfyLeJp
         rro4R7p0Dowo++BXJDT8gEfuoa51gA2YNSVZRaoB0Th9HmmKcJfLXaaOigaOMI0nDtZG
         8ZWj1urqqrfQnB7KfATkFfgljLINE6Y8s7RFsDbAGhbijbsxid3PclDOFQUjhBf4FbHM
         NofblSWY/MjIZOVxa40EaJ2DnMSxxKe6r06DUb8ITu7oHl34ef6LbEVhvrpkWlolnb+z
         uakER2VF5DiEqHawFoyZIfmmKh/Hcw6ckMPEhPv3Xmn6zL1+WmGkcUNcn2q/Z42qTUMa
         VeLw==
X-Gm-Message-State: AOJu0Yz0glAD+qH+3yiqfzp43+Pp83bjk4SjcGflG62Ukekzv6GMel00
	lHumRU8LVTfNhAXMH6Al8UaWXIyNtoEQDDAiNEGTgDYHW8478Wr9ROI5qGzzuVSKCkEA4IAA/zn
	xR8DNuA==
X-Google-Smtp-Source: AGHT+IH+udtnqsEzAcr2Z3DrMjegwtLPHteljCAh6cwGi3jLoA1Wef0X++R+xe9KlXRiwsp1cNyTjA==
X-Received: by 2002:a17:906:c343:b0:a31:818e:c98a with SMTP id ci3-20020a170906c34300b00a31818ec98amr5001432ejb.19.1706540370119;
        Mon, 29 Jan 2024 06:59:30 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00a2b1a20e662sm4002299ejc.34.2024.01.29.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:59:29 -0800 (PST)
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
Subject: [patch net-next 3/3] net/mlx5: DPLL, Implement lock status error value
Date: Mon, 29 Jan 2024 15:59:16 +0100
Message-ID: <20240129145916.244193-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129145916.244193-1-jiri@resnulli.us>
References: <20240129145916.244193-1-jiri@resnulli.us>
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


