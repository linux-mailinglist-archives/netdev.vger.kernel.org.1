Return-Path: <netdev+bounces-186136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF7A9D47A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E6417BE63
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992D22A7EA;
	Fri, 25 Apr 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpfJevb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546B228CB2
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617706; cv=none; b=TIRDlhsYx4bmaDMxNEHN+Lccneo3XqcHFOpcSF/rq6KwbZQ2Dzn40UkD6hdf8HW1xUzd+kILLaIdlWCEWc4Qo8iiNxg0au9yX5qQa6KZZGifAYTgyusGeFrJZBiOkmoKP0BuW/Z1S7bIZiIm/Ceq2VS53fJHoimc4GikjfQ/q7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617706; c=relaxed/simple;
	bh=PvBZsWOMlzpueV/Ut7P3Qhz+WSSr5v2TXp/xHDniBaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS5SCe+R+3d70DDJin1tEncgBUyPK1moYWTwND7DHFfEyb6xH4arTReKzMjDLslOrlIPHDfQAEhhFxydwBwxtkVNHBhm7A6i7IhDuPGy5r5uLe4UglJ+/dbIk0TeHCbVi8K08JUZnxbHEQ0auY5isBsYeO2xAI/6yGtChn5KOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpfJevb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5921FC4CEE4;
	Fri, 25 Apr 2025 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617706;
	bh=PvBZsWOMlzpueV/Ut7P3Qhz+WSSr5v2TXp/xHDniBaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpfJevb4XCdt5fq54Ut6q9jRGV/JKGRMFgzQHr8Gz9KO3/KAdGZSMxSsyzsu8Pkqn
	 vUY3CagV4KGrQYXw6l3Ai8yxrk5RkPs2Y2+zrrno0P4BG/CLhf3DEI9at9tljI/75e
	 KqOQTG5d8JBBJ6dnNn6x7nrLw5WLCMaNuP9zjRnKyLYLIBoGWRgPFrQK+O8kCalKGw
	 NY7alKCMJEDq6kaDxEkARXYGZwc9xsqjYWppixt757rLrMdE//HpAhFimdCgwc+RED
	 Rs4iK/jfWvxIbLv2nnRQVFCgl8E5joeKgC5+ecFRGoeAJVKceT6e+2XkJuhAQrNZRv
	 qGWXpvmqatcQg==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 08/15] devlink: Implement port params registration
Date: Fri, 25 Apr 2025 14:48:01 -0700
Message-ID: <20250425214808.507732-9-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425214808.507732-1-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
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
 net/devlink/param.c   | 150 ++++++++++++++++++++++++++++++++++--------
 net/devlink/port.c    |   3 +
 3 files changed, 140 insertions(+), 27 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index eed1e4507d17..11f98e3a750b 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -125,6 +125,7 @@ struct devlink_port {
 	struct list_head region_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
+	struct xarray params;
 	unsigned int index;
 	spinlock_t type_lock; /* Protects type and type_eth/ib
 			       * structures consistency.
@@ -1823,6 +1824,19 @@ void devl_params_unregister(struct devlink *devlink,
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
index 66a4121015a2..4656d16cd51a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -627,13 +627,16 @@ static int devlink_param_verify(const struct devlink_param *param)
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
@@ -646,11 +649,13 @@ static int devlink_param_register(struct devlink *devlink,
 
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
@@ -659,30 +664,28 @@ static int devlink_param_register(struct devlink *devlink,
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
@@ -690,10 +693,12 @@ int devl_params_register(struct devlink *devlink,
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
@@ -701,9 +706,28 @@ int devl_params_register(struct devlink *devlink,
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
@@ -719,6 +743,22 @@ int devlink_params_register(struct devlink *devlink,
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
@@ -729,13 +769,8 @@ void devl_params_unregister(struct devlink *devlink,
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
 
@@ -749,6 +784,67 @@ void devlink_params_unregister(struct devlink *devlink,
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
+ *	devl_port_params_unregister - unregister configuration parameters for port
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
2.49.0


