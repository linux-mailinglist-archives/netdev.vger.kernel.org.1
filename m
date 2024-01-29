Return-Path: <netdev+bounces-66764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19019840932
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365061C21DC4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8225D153BC1;
	Mon, 29 Jan 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dX0mu9EZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBC1534FE
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540370; cv=none; b=mHnYrMu5SlsA70bnr1wszODzfheFo6RVpfFbEAyKcgYt79ERcelXX3+zV2UFh0XUspXGkwP0oQTCSgkYJu+Zh6l1sxwRHsFNBAfDU3nIh7nOnj7Nwnzs0pLcdcYMuglvzvFmzIlqh17rI2sZtdvHolx4YQbvqOmpYNwGYq4SDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540370; c=relaxed/simple;
	bh=uv+x1tnt+B2n61YzM57z/U/dWWIxIP1XO9FSSvvKCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdRs7Fd1eq1g3zSa9Q/Pz27cdBOgVvt5GIf8OPRCzxbUrmFFdxJfSs18Ikoh7IoPzX8c5FnXd0zKkW1TYh2hgC6W3wcdTDqq0I1sMYx4kdLPFMGb7DDydhKZ13zoU/58zxAoyUev/nZ5DuyGZbIUcesUAyjB7W9IVIpZtSkTpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dX0mu9EZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so30855541fa.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 06:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706540366; x=1707145166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRVeK3/iLpqWUEjl4hBDQ7S/p9rC6B4dKMLerlPoTrk=;
        b=dX0mu9EZ58RDcrOo+yOy9Yx4Weg3UbUdQCNeyxTTm391eQMZSjXPEyAvSa052+ONEm
         yzpXSSv5hf9UBsPnUK2pIZog9GCxhhzQaGlOhGt0GYWc+1DEqoRvtH36gM4rDtQ1IHCD
         HVx0mW2jTwJApG0+rQR2yI8bMexr5KjHK5lLIbc7Ep7tP/PNbQ4Mq8A9gtWAjUjkJoD4
         q9K026IcoGp0tgXD2dSZq9SBdirRy7cT+ORc9wYG5jwj1PW9HtWsDS1+g3Hy97X4WWun
         ZXV9ScGKBY4JQb6c9R5GFra37QzNLNpaaJLxQMI4Im4pJjGKsISiZ/UaKqh6v+q4RVoM
         wFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540366; x=1707145166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRVeK3/iLpqWUEjl4hBDQ7S/p9rC6B4dKMLerlPoTrk=;
        b=qhVE6Hpmk8CyWtE3u05m1pYaeme4kBaNbbUHLrOlasXhR1S+ZrCIbgiAoaPkOSYAS8
         2gOTxnj4SbT72jAGnjY0OHMLA8UzuRiPRIzDeY5dSGFERCEnVJsayAmWwTxfX4HVZmFA
         SZX2+BBrxJdtZLB1rwMr4rYz5r6Ww4ttRlLkJPnaMWv3ygKO2QsZG+v5GT3JmK1c2jZT
         o+8XJzdhXiXEnbKlvyJc5sTCnVNZElkl2/Oc78XUfW8Q3PpyEElde0LCkRZ0BzOKvdrH
         PYkN43E4Sdgk4QRXcVWY609EiPiwY65vQ/YT3N7n0hPjyAMuMjs7OeoaaveVFAK2B0/U
         VItQ==
X-Gm-Message-State: AOJu0YyVUvqrJI6mOV3EuKdaRMRwTjSFvWoqftonzV5tcitqRJR69kAo
	R4cvDt4VBhHfjj28mCOaK/5QTg++cxnT/WjreRIPmDpCMIEv/OncjYLDO2/zCrA5LhHP24tvTxs
	mB7Ztpg==
X-Google-Smtp-Source: AGHT+IGsZ/9dx9FYI+oQpVx4JOXVwQvAUJum7qEbDxrnqhP+VM/BcuksSHWZ2fx9T8apy7IXXeZFvw==
X-Received: by 2002:a2e:7407:0:b0:2cd:cd45:5cc0 with SMTP id p7-20020a2e7407000000b002cdcd455cc0mr3726003ljc.9.1706540366798;
        Mon, 29 Jan 2024 06:59:26 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ds8-20020a0564021cc800b0055c9280dc51sm3832713edb.14.2024.01.29.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:59:26 -0800 (PST)
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
Subject: [patch net-next 2/3] dpll: extend lock_status_get() op by status error and expose to user
Date: Mon, 29 Jan 2024 15:59:15 +0100
Message-ID: <20240129145916.244193-3-jiri@resnulli.us>
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

Pass additional argunent status_error over lock_status_get()
so drivers can fill it up. In case they do, expose the value over
previously introduced attribute to user. Do it only in case the
current lock_status is either "unlocked" or "holdover".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_netlink.c                    | 9 ++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c      | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 9 +++++----
 drivers/ptp/ptp_ocp.c                          | 9 +++++----
 include/linux/dpll.h                           | 1 +
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 314bb3775465..cf3313517ae1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -121,14 +121,21 @@ dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
 			 struct netlink_ext_ack *extack)
 {
 	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_lock_status_error status_error = 0;
 	enum dpll_lock_status status;
 	int ret;
 
-	ret = ops->lock_status_get(dpll, dpll_priv(dpll), &status, extack);
+	ret = ops->lock_status_get(dpll, dpll_priv(dpll), &status,
+				   &status_error, extack);
 	if (ret)
 		return ret;
 	if (nla_put_u32(msg, DPLL_A_LOCK_STATUS, status))
 		return -EMSGSIZE;
+	if (status_error &&
+	    (status == DPLL_LOCK_STATUS_UNLOCKED ||
+	     status == DPLL_LOCK_STATUS_HOLDOVER) &&
+	    nla_put_u32(msg, DPLL_A_LOCK_STATUS_ERROR, status_error))
+		return -EMSGSIZE;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index b9c5eced6326..04cafa896e9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -500,6 +500,7 @@ ice_dpll_hw_input_prio_set(struct ice_pf *pf, struct ice_dpll *dpll,
 static int
 ice_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 			 enum dpll_lock_status *status,
+			 enum dpll_lock_status_error *status_error,
 			 struct netlink_ext_ack *extack)
 {
 	struct ice_dpll *d = dpll_priv;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 18fed2b34fb1..07f43d5c90c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -118,10 +118,11 @@ mlx5_dpll_pin_ffo_get(struct mlx5_dpll_synce_status *synce_status,
 	return 0;
 }
 
-static int mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll,
-					    void *priv,
-					    enum dpll_lock_status *status,
-					    struct netlink_ext_ack *extack)
+static int
+mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll, void *priv,
+				 enum dpll_lock_status *status,
+				 enum dpll_lock_status_error *status_error,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_dpll_synce_status synce_status;
 	struct mlx5_dpll *mdpll = priv;
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 5f858e426bbd..9507681e0d12 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4209,10 +4209,11 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	device_unregister(&bp->dev);
 }
 
-static int ptp_ocp_dpll_lock_status_get(const struct dpll_device *dpll,
-					void *priv,
-					enum dpll_lock_status *status,
-					struct netlink_ext_ack *extack)
+static int
+ptp_ocp_dpll_lock_status_get(const struct dpll_device *dpll, void *priv,
+			     enum dpll_lock_status *status,
+			     enum dpll_lock_status_error *status_error,
+			     struct netlink_ext_ack *extack)
 {
 	struct ptp_ocp *bp = priv;
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 9cf896ea1d41..9cb02ad73d51 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -19,6 +19,7 @@ struct dpll_device_ops {
 			enum dpll_mode *mode, struct netlink_ext_ack *extack);
 	int (*lock_status_get)(const struct dpll_device *dpll, void *dpll_priv,
 			       enum dpll_lock_status *status,
+			       enum dpll_lock_status_error *status_error,
 			       struct netlink_ext_ack *extack);
 	int (*temp_get)(const struct dpll_device *dpll, void *dpll_priv,
 			s32 *temp, struct netlink_ext_ack *extack);
-- 
2.43.0


