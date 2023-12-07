Return-Path: <netdev+bounces-54876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF545808B7F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA10C281C98
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D224439A;
	Thu,  7 Dec 2023 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y2MRsN85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3FE9
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 07:12:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso1550908a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701961926; x=1702566726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TebxyIph7wGZWHuH7VrfAQ2ChJ0hnUDe2V/gBfoUOVc=;
        b=y2MRsN85vQ+mRVXFNDvWuA3eFbliUMLfkzmye8GDKFLJPlNTtidq9CjG2rnDH116tB
         CSV3ovbgkcweA90JCRsgd+0J829rkhYfdaqlXl5lat19xgsae4gvq3WfTNWw4q/j8Qlj
         RRiVfUT+pBLoIe2T7nLVwaaggeuofWlTrHlxjP4IUf/WrTXo0kHtIhhKdGNOdfMS8aBp
         9SbZFEZ/PKWETtIicLlZWva/S4IdoWxf+E7jtetdumfHpz3XsexTt68HxXfnupQkTe8p
         V9hio8EUOzr0I9ZKpo0dCSEkfOSQ8sw0x0SNH0ZO0jJSQREJdnPtBGjZB+K57H2ii6Jx
         Fmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961926; x=1702566726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TebxyIph7wGZWHuH7VrfAQ2ChJ0hnUDe2V/gBfoUOVc=;
        b=fXkaV1JEaSV8ChmBR8Jb/6SJhGGMBu5U+/7I6q1hqcAakEnzekQojLGNmIwPHDXRww
         0E/clLx9VdhP8x7vk75omRv9TgjqGE2+paXag2HA5WzR3F9HxfWUmZr8K18FbrGE+ODh
         NhVM9lliHp5fbzvIdJdo7vo5rpgH0PktluCQ2rqLg3nM7epzw0NYfxhQGoA293pRyAY+
         7J2ujb8G8J4/NZJeJxkg6x2UoszEU7DXhOQ76CiZOAU18q4UR9iLWIQwTH1TWn4CXJ51
         awYhQee6WjA6ccXViuAicEpXMmViBJ/Kqha481SqZ6TCFhiFspE5sFagQ1suKjMESkyy
         mf7g==
X-Gm-Message-State: AOJu0YzuxNKmhh5UCyMnDK10z/tU2OxN2Gy62lJvbyQbA/NJvss+9wLH
	PsLKVqmFd3VqxgeCWRetlvqdyMlElC2btDp3QN8=
X-Google-Smtp-Source: AGHT+IGjT4layNfREBmpFDePsSNPbysEojQy5OcCVaL9RIxXw2Gtxg97WhQXFHIF2AkaqjC8ZBnpKg==
X-Received: by 2002:a17:907:369:b0:a1a:582c:3b65 with SMTP id rs9-20020a170907036900b00a1a582c3b65mr1599069ejb.143.1701961926133;
        Thu, 07 Dec 2023 07:12:06 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709060b1500b00a1937153bddsm936420ejg.20.2023.12.07.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:12:05 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	richardcochran@gmail.com,
	jonathan.lemon@gmail.com
Subject: [patch net-next] dpll: remove leftover mode_supported() op and use mode_get() instead
Date: Thu,  7 Dec 2023 16:12:04 +0100
Message-ID: <20231207151204.1007797-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Mode supported is currently reported to the user exactly the same, as
the current mode. That's because mode changing is not implemented.
Remove the leftover mode_supported() op and use mode_get() to fill up
the supported mode exposed to user.

One, if even, mode changing is going to be introduced, this could be
very easily taken back. In the meantime, prevent drivers form
implementing this in wrong way (as for example recent netdevsim
implementation attempt intended to do).

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_netlink.c                   | 16 +++++++-----
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 26 -------------------
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  9 -------
 drivers/ptp/ptp_ocp.c                         |  8 ------
 include/linux/dpll.h                          |  3 ---
 5 files changed, 10 insertions(+), 52 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 442a0ebeb953..e1a4737500f5 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -101,13 +101,17 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
 {
 	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
 	enum dpll_mode mode;
+	int ret;
 
-	if (!ops->mode_supported)
-		return 0;
-	for (mode = DPLL_MODE_MANUAL; mode <= DPLL_MODE_MAX; mode++)
-		if (ops->mode_supported(dpll, dpll_priv(dpll), mode, extack))
-			if (nla_put_u32(msg, DPLL_A_MODE_SUPPORTED, mode))
-				return -EMSGSIZE;
+	/* No mode change is supported now, so the only supported mode is the
+	 * one obtained by mode_get().
+	 */
+
+	ret = ops->mode_get(dpll, dpll_priv(dpll), &mode, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u32(msg, DPLL_A_MODE_SUPPORTED, mode))
+		return -EMSGSIZE;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 86b180cb32a0..b9c5eced6326 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -512,31 +512,6 @@ ice_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 	return 0;
 }
 
-/**
- * ice_dpll_mode_supported - check if dpll's working mode is supported
- * @dpll: registered dpll pointer
- * @dpll_priv: private data pointer passed on dpll registration
- * @mode: mode to be checked for support
- * @extack: error reporting
- *
- * Dpll subsystem callback. Provides information if working mode is supported
- * by dpll.
- *
- * Return:
- * * true - mode is supported
- * * false - mode is not supported
- */
-static bool ice_dpll_mode_supported(const struct dpll_device *dpll,
-				    void *dpll_priv,
-				    enum dpll_mode mode,
-				    struct netlink_ext_ack *extack)
-{
-	if (mode == DPLL_MODE_AUTOMATIC)
-		return true;
-
-	return false;
-}
-
 /**
  * ice_dpll_mode_get - get dpll's working mode
  * @dpll: registered dpll pointer
@@ -1197,7 +1172,6 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
 
 static const struct dpll_device_ops ice_dpll_ops = {
 	.lock_status_get = ice_dpll_lock_status_get,
-	.mode_supported = ice_dpll_mode_supported,
 	.mode_get = ice_dpll_mode_get,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 2cd81bb32c66..a7ffd61fe248 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -128,18 +128,9 @@ static int mlx5_dpll_device_mode_get(const struct dpll_device *dpll,
 	return 0;
 }
 
-static bool mlx5_dpll_device_mode_supported(const struct dpll_device *dpll,
-					    void *priv,
-					    enum dpll_mode mode,
-					    struct netlink_ext_ack *extack)
-{
-	return mode == DPLL_MODE_MANUAL;
-}
-
 static const struct dpll_device_ops mlx5_dpll_device_ops = {
 	.lock_status_get = mlx5_dpll_device_lock_status_get,
 	.mode_get = mlx5_dpll_device_mode_get,
-	.mode_supported = mlx5_dpll_device_mode_supported,
 };
 
 static int mlx5_dpll_pin_direction_get(const struct dpll_pin *pin,
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4021d3d325f9..b022af3d20fe 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4260,13 +4260,6 @@ static int ptp_ocp_dpll_mode_get(const struct dpll_device *dpll, void *priv,
 	return 0;
 }
 
-static bool ptp_ocp_dpll_mode_supported(const struct dpll_device *dpll,
-					void *priv, const enum dpll_mode mode,
-					struct netlink_ext_ack *extack)
-{
-	return mode == DPLL_MODE_AUTOMATIC;
-}
-
 static int ptp_ocp_dpll_direction_get(const struct dpll_pin *pin,
 				      void *pin_priv,
 				      const struct dpll_device *dpll,
@@ -4350,7 +4343,6 @@ static int ptp_ocp_dpll_frequency_get(const struct dpll_pin *pin,
 static const struct dpll_device_ops dpll_ops = {
 	.lock_status_get = ptp_ocp_dpll_lock_status_get,
 	.mode_get = ptp_ocp_dpll_mode_get,
-	.mode_supported = ptp_ocp_dpll_mode_supported,
 };
 
 static const struct dpll_pin_ops dpll_pins_ops = {
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 578fc5fa3750..b1a5f9ca8ee5 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -17,9 +17,6 @@ struct dpll_pin;
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
 			enum dpll_mode *mode, struct netlink_ext_ack *extack);
-	bool (*mode_supported)(const struct dpll_device *dpll, void *dpll_priv,
-			       const enum dpll_mode mode,
-			       struct netlink_ext_ack *extack);
 	int (*lock_status_get)(const struct dpll_device *dpll, void *dpll_priv,
 			       enum dpll_lock_status *status,
 			       struct netlink_ext_ack *extack);
-- 
2.41.0


