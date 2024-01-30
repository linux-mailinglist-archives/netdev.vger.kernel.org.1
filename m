Return-Path: <netdev+bounces-67191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4261E842491
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B7FB2F4B2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696B6A32D;
	Tue, 30 Jan 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i0d0jqMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234526A018
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616525; cv=none; b=pdV/tJJBjxuLUeZocyZk/GTFxZaDlpYdXkT0PndEIEmroCC4IGtT+KvZ4PGPURE5o980Bmdyg1A4lhBXCsQT617Cn3tdXMLbtMe0MjIiGXUbvjk3opLQJLSWptEAEBEro2rTmksEWcYIi6kA1i1TeSD2gsS+DbzG8dZ0hJBWQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616525; c=relaxed/simple;
	bh=fS4CJWwyBmbltHls+QhHmewDlYt4g3QeHa1ai74pIlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7+7+tW7M+4gw1p9xWQ3+GQjrFPrQWLSkczIPrB2kgXWzo57T28WhS+CsI2wquDaBzDH7BxydC8QSCRUANVY1XMve7y3NvnmPi+AkSr1PMJd2Npu/0lDR50BY30XE0nbBn3+/h8HpuzML/NZx8jyJ8OqnE7UjkLyltBKQEM+14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i0d0jqMU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51030667cedso4682820e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706616522; x=1707221322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R4lrMjk0YHZK4LHiPYNPIRorykEP/3engsxDnFu06A=;
        b=i0d0jqMUAsDws42Xw4qd/KWlqq4beyweXgjQAwpFWhNgwUhzQLk/uWyeEI3O7yQfNn
         a0spheAy9P1DE/PesrWdnekdfoofB9RU+tRJk4M4iGktP4teGvKtXwwFXHbZVifk6vr0
         eE8ZJO7ki8g69IwYCGCE4aZ2F2y+d0ISpZi1TzdcaqzVTQhl4zo+Q+XmY7kOoCoRrGTj
         FKeVMLy7H82+OhctP1/6yjQTUi3hgz/oF4dQEkvMF56puyrEuzD4tOc+BTA6qygvXSZu
         Y6W50rjHo/wXd+BrGoAaCFBLdQb+bcOjiPGdrjDujQvP+e62mbf35pBRy1OGuU7A/6IN
         lm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616522; x=1707221322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R4lrMjk0YHZK4LHiPYNPIRorykEP/3engsxDnFu06A=;
        b=t7vhd3xScGaYbj88D+qOH3w/afIVdbC8Dr3UKlyqhRuWszquUODebpgOzdScCZ2Wbq
         aUFohvPcB7GanX9hcmQFsX1DdnLcLoBBo0/gNWch9zccxwuL7RIrwDfZqU7YL2WWAwYj
         t9KBokZedNPQKw+/c1YLu/j91pSSdVIIknZhArkNp3yEdK1L67/Kkd5v7ifvcseIG+mi
         D4d/4nky6S2fQmoSpHGJQcOsQKzuhPaoAsmJyvD8rlSQrSv7boHnFkB5lzhl7QqdS8PM
         ihk6F3ghZai7IFHGLkVp2Lfqc8gLLbXy9nhV4484vIDm+TOI2NBEJNJE6cOTbsSEWw0h
         QK4g==
X-Gm-Message-State: AOJu0YznEzK3mcmHD8ATeEYDNQIt1i6dPir+csE2epv0OS/mXgTKmoZk
	+3gA6838g5NUnquWVkfO91Qf9nRBUA7jkoeiJgJAzgfsWLnFSZh1cDqVmEyLFffZR0GiKH8lS56
	DSM8=
X-Google-Smtp-Source: AGHT+IHSg5ZcoIviYwFLhUk+W40+LsC1sVBtZlBQGn0M7oQSVmR3PhdyAFr5nl5UlcdxMEYABLP8CA==
X-Received: by 2002:a05:6512:2209:b0:50e:4098:3798 with SMTP id h9-20020a056512220900b0050e40983798mr6578146lfu.60.1706616522078;
        Tue, 30 Jan 2024 04:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhiJs6c+6h7L+9CyEicNSZupRirwGeMrgJrZrhaSArpPxFlP2yoZ1wKm1fnzkA8xyHXUNjtBVJ4MTCqqbPwzODmU+CAcvn6CqJxLkmArNJGWgeXGjiPEv+cOKXjuNUWEEpoDUKAAnqTXgpoCelbMekTsT/pGkd4AmNZKtIao4TXNi7Br3sOJosni84B9mAhpD93g4EHljjLpqW9ZkKnltjSlhsLfg2wVgF2xy8UfpZuBC9fmWmI/lpLsrp/AHWKQUvpsqrUr/bM/jDzXjxsMoI6REDrEaWSY4Z3S2HsAb6sSUn1GNvAgbmyVbsUaPh/nBL58nlKy27V9BBrzE3jRdV6tdiUxUbTJVEdCnIOaGhZiN4r6aODBjngX5O0/LFxFbcxp5eLceZa9uUclA=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600c450500b0040e9d507424sm12984262wmo.5.2024.01.30.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:08:41 -0800 (PST)
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
Subject: [patch net-next v2 2/3] dpll: extend lock_status_get() op by status error and expose to user
Date: Tue, 30 Jan 2024 13:08:30 +0100
Message-ID: <20240130120831.261085-3-jiri@resnulli.us>
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

Pass additional argunent status_error over lock_status_get()
so drivers can fill it up. In case they do, expose the value over
previously introduced attribute to user. Do it only in case the
current lock_status is either "unlocked" or "holdover".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1->v2:
- fixed warning caused by a missed arg description in comment of
  a static function in ice driver :O
---
 drivers/dpll/dpll_netlink.c                    | 9 ++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c      | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 9 +++++----
 drivers/ptp/ptp_ocp.c                          | 9 +++++----
 include/linux/dpll.h                           | 1 +
 5 files changed, 21 insertions(+), 9 deletions(-)

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
index b9c5eced6326..c0256564e998 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -488,6 +488,7 @@ ice_dpll_hw_input_prio_set(struct ice_pf *pf, struct ice_dpll *dpll,
  * @dpll: registered dpll pointer
  * @dpll_priv: private data pointer passed on dpll registration
  * @status: on success holds dpll's lock status
+ * @status_error: status error value
  * @extack: error reporting
  *
  * Dpll subsystem callback, provides dpll's lock status.
@@ -500,6 +501,7 @@ ice_dpll_hw_input_prio_set(struct ice_pf *pf, struct ice_dpll *dpll,
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


