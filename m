Return-Path: <netdev+bounces-205242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FFAFDDD0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD25645AE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B871F5846;
	Wed,  9 Jul 2025 03:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ0sjNYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D91F5434
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030312; cv=none; b=nVNpsC85NHUdVcGN97xsATeZohauP6b6uJsTqv6Guv2aB9x1ilAPRLBxebWZymR/rbGYKxZdCJKpPrZFHQTYbYE57/G/C2ZFbbp85hkncgZ4H7MslT6FIAsL02DNy8sHSDSypHowcnblytkggX0mBfKUHFKkykielmS2+9GddNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030312; c=relaxed/simple;
	bh=fkda5QCp0O4T3MSpOv4NSyJ/uJH7nOMjC38SZlV0R84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1clIt1t4/GdEYR78FuE8Fsex1CUNIcTROP1142/X2cLAcEYureA7SjhwyTJUCo2x7L5xYx7dnl/b1AnELVjKpQL9b2Lv1a26gdT3iWxWk+TyF5Iyjx/mjzbz3L+vOjsVjZZZNsYKyZNd6YKRcrDtdIm42IQb1pyRJAVAw85IAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ0sjNYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C294C4CEED;
	Wed,  9 Jul 2025 03:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030312;
	bh=fkda5QCp0O4T3MSpOv4NSyJ/uJH7nOMjC38SZlV0R84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQ0sjNYUyhgfyVnTMoBJnXQhvAj0WGPcS06cEzB/OprRz92R3P5AEKLpKw6VkhRVV
	 jCk++G+NV8A1TJLbjuzbBevpzmmPC0Finy+woqFSQ3nkhiVYF1KuFq6sy3m2li2gTH
	 vZiMJ8cqKI6aDS3jPIqrx6J6yrKbXXmGWZ8Srs6lTmGNQXcEnQFjS7EiaN1InpLN3U
	 W8V6rKVazIDbkcfllApdEs/8S27nEoOeYbCHuUd/DsYwvv7G1xNG2ELRBRb10jdBWW
	 o3Av1OcugYMSPT4uZXPU+fbejZiuIfclbcvRjc7tmXVXynBcabOxZdPni5rYjhIHky
	 x2apzI9fc0f4w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V6 06/13] devlink: Implement port params registration
Date: Tue,  8 Jul 2025 20:04:48 -0700
Message-ID: <20250709030456.1290841-7-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709030456.1290841-1-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Port params infrastructure is incomplete and needs a bit of plumbing to
support port params commands from netlink.

Introduce port params registration API, very similar to current devlink
params API, add the params xarray to devlink_port structure and
decouple devlink params registration routines from the devlink
structure.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h |  14 ++++
 net/devlink/param.c   | 151 ++++++++++++++++++++++++++++++++++--------
 net/devlink/port.c    |   3 +
 3 files changed, 141 insertions(+), 27 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 32508b4d5df3..ffb47f62d575 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -127,6 +127,7 @@ struct devlink_port {
 	struct list_head region_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
+	struct xarray params;
 	unsigned int index;
 	spinlock_t type_lock; /* Protects type and type_eth/ib
 			       * structures consistency.
@@ -1835,6 +1836,19 @@ void devl_params_unregister(struct devlink *devlink,
 void devlink_params_unregister(struct devlink *devlink,
 			       const struct devlink_param *params,
 			       size_t params_count);
+int devl_port_params_register(struct devlink_port *devlink_port,
+			      const struct devlink_param *params,
+			      size_t params_count);
+int devlink_port_params_register(struct devlink_port *devlink_port,
+				 const struct devlink_param *params,
+				 size_t params_count);
+void devl_port_params_unregister(struct devlink_port *devlink_port,
+				 const struct devlink_param *params,
+				 size_t params_count);
+void devlink_port_params_unregister(struct devlink_port *devlink_port,
+				    const struct devlink_param *params,
+				    size_t params_count);
+
 int devl_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 				    union devlink_param_value *val);
 void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
diff --git a/net/devlink/param.c b/net/devlink/param.c
index fcb59763530a..3103091c2da7 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -590,13 +590,16 @@ static int devlink_param_verify(const struct devlink_param *param)
 }
 
 static int devlink_param_register(struct devlink *devlink,
+				  struct devlink_port *devlink_port,
+				  struct xarray *params_arr,
 				  const struct devlink_param *param)
 {
 	struct devlink_param_item *param_item;
+	enum devlink_command cmd;
 	int err;
 
 	WARN_ON(devlink_param_verify(param));
-	WARN_ON(devlink_param_find_by_name(&devlink->params, param->name));
+	WARN_ON(devlink_param_find_by_name(params_arr, param->name));
 
 	if (param->supported_cmodes == BIT(DEVLINK_PARAM_CMODE_DRIVERINIT))
 		WARN_ON(param->get || param->set);
@@ -609,11 +612,13 @@ static int devlink_param_register(struct devlink *devlink,
 
 	param_item->param = param;
 
-	err = xa_insert(&devlink->params, param->id, param_item, GFP_KERNEL);
+	err = xa_insert(params_arr, param->id, param_item, GFP_KERNEL);
 	if (err)
 		goto err_xa_insert;
 
-	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_NEW);
+	cmd = devlink_port ? DEVLINK_CMD_PORT_PARAM_NEW : DEVLINK_CMD_PARAM_NEW;
+	devlink_param_notify(devlink, devlink_port, param_item, cmd);
+
 	return 0;
 
 err_xa_insert:
@@ -622,30 +627,28 @@ static int devlink_param_register(struct devlink *devlink,
 }
 
 static void devlink_param_unregister(struct devlink *devlink,
+				     struct devlink_port *devlink_port,
+				     struct xarray *params_arr,
 				     const struct devlink_param *param)
 {
 	struct devlink_param_item *param_item;
+	enum devlink_command cmd;
 
-	param_item = devlink_param_find_by_id(&devlink->params, param->id);
+	param_item = devlink_param_find_by_id(params_arr, param->id);
 	if (WARN_ON(!param_item))
 		return;
-	devlink_param_notify(devlink, NULL, param_item, DEVLINK_CMD_PARAM_DEL);
-	xa_erase(&devlink->params, param->id);
+
+	cmd = devlink_port ? DEVLINK_CMD_PORT_PARAM_DEL : DEVLINK_CMD_PARAM_DEL;
+	devlink_param_notify(devlink, devlink_port, param_item, cmd);
+	xa_erase(params_arr, param->id);
 	kfree(param_item);
 }
 
-/**
- *	devl_params_register - register configuration parameters
- *
- *	@devlink: devlink
- *	@params: configuration parameters array
- *	@params_count: number of parameters provided
- *
- *	Register the configuration parameters supported by the driver.
- */
-int devl_params_register(struct devlink *devlink,
-			 const struct devlink_param *params,
-			 size_t params_count)
+static int __devlink_params_register(struct devlink *devlink,
+				     struct devlink_port *devlink_port,
+				     struct xarray *params_arr,
+				     const struct devlink_param *params,
+				     size_t params_count)
 {
 	const struct devlink_param *param = params;
 	int i, err;
@@ -653,10 +656,12 @@ int devl_params_register(struct devlink *devlink,
 	lockdep_assert_held(&devlink->lock);
 
 	for (i = 0; i < params_count; i++, param++) {
-		err = devlink_param_register(devlink, param);
+		err = devlink_param_register(devlink, devlink_port, params_arr,
+					     param);
 		if (err)
 			goto rollback;
 	}
+
 	return 0;
 
 rollback:
@@ -664,9 +669,28 @@ int devl_params_register(struct devlink *devlink,
 		return err;
 
 	for (param--; i > 0; i--, param--)
-		devlink_param_unregister(devlink, param);
+		devlink_param_unregister(devlink, devlink_port, params_arr,
+					 param);
+
 	return err;
 }
+
+/**
+ *	devl_params_register - register configuration parameters
+ *
+ *	@devlink: devlink
+ *	@params: configuration parameters array
+ *	@params_count: number of parameters provided
+ *
+ *	Register the configuration parameters supported by the driver.
+ */
+int devl_params_register(struct devlink *devlink,
+			 const struct devlink_param *params,
+			 size_t params_count)
+{
+	return __devlink_params_register(devlink, NULL, &devlink->params,
+					 params, params_count);
+}
 EXPORT_SYMBOL_GPL(devl_params_register);
 
 int devlink_params_register(struct devlink *devlink,
@@ -682,6 +706,22 @@ int devlink_params_register(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devlink_params_register);
 
+static void __devlink_params_unregister(struct devlink *devlink,
+					struct devlink_port *devlink_port,
+					struct xarray *params_arr,
+					const struct devlink_param *params,
+					size_t params_count)
+{
+	const struct devlink_param *param = params;
+	int i;
+
+	lockdep_assert_held(&devlink->lock);
+
+	for (i = 0; i < params_count; i++, param++)
+		devlink_param_unregister(devlink, devlink_port, params_arr,
+					 param);
+}
+
 /**
  *	devl_params_unregister - unregister configuration parameters
  *	@devlink: devlink
@@ -692,13 +732,8 @@ void devl_params_unregister(struct devlink *devlink,
 			    const struct devlink_param *params,
 			    size_t params_count)
 {
-	const struct devlink_param *param = params;
-	int i;
-
-	lockdep_assert_held(&devlink->lock);
-
-	for (i = 0; i < params_count; i++, param++)
-		devlink_param_unregister(devlink, param);
+	__devlink_params_unregister(devlink, NULL, &devlink->params,
+				    params, params_count);
 }
 EXPORT_SYMBOL_GPL(devl_params_unregister);
 
@@ -712,6 +747,68 @@ void devlink_params_unregister(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devlink_params_unregister);
 
+/**
+ *	devl_port_params_register - register configuration parameters for port
+ *
+ *	@devlink_port: devlink port
+ *	@params: configuration parameters array
+ *	@params_count: number of parameters provided
+ *
+ *	Register the configuration parameters supported by the driver for the
+ *	specific port.
+ */
+int devl_port_params_register(struct devlink_port *devlink_port,
+			      const struct devlink_param *params,
+			      size_t params_count)
+{
+	return __devlink_params_register(devlink_port->devlink,
+					 devlink_port,
+					 &devlink_port->params,
+					 params, params_count);
+}
+EXPORT_SYMBOL_GPL(devl_port_params_register);
+
+/**
+ *	devl_port_params_unregister - unregister configuration parameters for
+ *				      devlink port
+ *
+ *	@devlink_port: devlink port
+ *	@params: configuration parameters to unregister
+ *	@params_count: number of parameters provided
+ */
+void devl_port_params_unregister(struct devlink_port *devlink_port,
+				 const struct devlink_param *params,
+				 size_t params_count)
+{
+	__devlink_params_unregister(devlink_port->devlink, devlink_port,
+				    &devlink_port->params,
+				    params, params_count);
+}
+EXPORT_SYMBOL_GPL(devl_port_params_unregister);
+
+int devlink_port_params_register(struct devlink_port *devlink_port,
+				 const struct devlink_param *params,
+				 size_t params_count)
+{
+	int err;
+
+	devl_lock(devlink_port->devlink);
+	err = devl_port_params_register(devlink_port, params, params_count);
+	devl_unlock(devlink_port->devlink);
+	return err;
+}
+EXPORT_SYMBOL_GPL(devlink_port_params_register);
+
+void devlink_port_params_unregister(struct devlink_port *devlink_port,
+				    const struct devlink_param *params,
+				    size_t params_count)
+{
+	devl_lock(devlink_port->devlink);
+	devl_port_params_unregister(devlink_port, params, params_count);
+	devl_unlock(devlink_port->devlink);
+}
+EXPORT_SYMBOL_GPL(devlink_port_params_unregister);
+
 /**
  *	devl_param_driverinit_value_get - get configuration parameter
  *					  value for driver initializing
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..39bba3f7a1f9 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1075,6 +1075,8 @@ int devl_port_register_with_ops(struct devlink *devlink,
 	devlink_port->registered = true;
 	devlink_port->index = port_index;
 	devlink_port->ops = ops ? ops : &devlink_port_dummy_ops;
+	xa_init_flags(&devlink_port->params, XA_FLAGS_ALLOC);
+
 	spin_lock_init(&devlink_port->type_lock);
 	INIT_LIST_HEAD(&devlink_port->reporter_list);
 	err = xa_insert(&devlink->ports, port_index, devlink_port, GFP_KERNEL);
@@ -1134,6 +1136,7 @@ void devl_port_unregister(struct devlink_port *devlink_port)
 	devlink_port_type_warn_cancel(devlink_port);
 	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
 	xa_erase(&devlink_port->devlink->ports, devlink_port->index);
+	xa_destroy(&devlink_port->params);
 	WARN_ON(!list_empty(&devlink_port->reporter_list));
 	devlink_port->registered = false;
 }
-- 
2.50.0


