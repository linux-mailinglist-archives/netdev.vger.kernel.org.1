Return-Path: <netdev+bounces-164341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8CA2D68C
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 15:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC4C3AA336
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887723F292;
	Sat,  8 Feb 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPHMOGvP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0C20328;
	Sat,  8 Feb 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739024128; cv=none; b=DQXAvHOETPwxDU3fEj/z1rLxQopeMmJ7xyw6gdu59SOeZooSO6Xqn1XzmBriZcy/7gP6EtMl8LVEJvUVO5znq8PIUimpwv1DSmKM4zwfda1nfIy00B2h8+dVfAoL1QD4Rx5s9KmF6tuoMRCbM8D6fNpVP9rhEC4YzwA6LZ9wKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739024128; c=relaxed/simple;
	bh=dRS2dFkNO1XmsBKb3lZugJeHViVFC2Ib0rAKifXwTaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRyTeIh8AcydYj9E6JCZSazjGJl22+tKaxV4H1hVUMA16+upaaT0sra/9v2S0pDUdQmdrXT51d/Z+MmgRA4pn4ZOpzOjLEy1kGc9Xh1zQylTMBfIvHQgx1xeEcSaL7613mjc4pNo+lUto8+FjTnsNM5557lJ+ngYMgHjo2UMGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPHMOGvP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dcf0de81ebso5945832a12.1;
        Sat, 08 Feb 2025 06:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739024124; x=1739628924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+iqMrEjo+IVGfKF4iUrFvQs5I5Sd+N+2c3oSnwunnM=;
        b=MPHMOGvPf9Sau5mSCA+QsvLVCY1zIDacpHQ7mrKH8nmBtBSgSi7MFwMp1iL6yLx6pi
         aj9Ay7PQieWBWYvYzduoBQf+RbPAsx5QMjauEkyHr0wUjYoCr6hdvT+JKRE6h0sjaOvi
         nDrEPiwOGi0jmTuPn2d/IOgCs80mvagEE4CuLPx4qIj0eXGdzz4HHdPbLDPMke/mrPkt
         toF+5HIcFPwXpFPkxo1XRs1kZ1MFabYsscwoQ9t3U58MjcLqTkupdBf9heapkyKEniEe
         Nixrd/5hZiquiuXdcEqoJJDpG7yF4AAlRwfaZPb4GF7XRVbJVA21xOzfUpuXFS6zUGKg
         m7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739024124; x=1739628924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+iqMrEjo+IVGfKF4iUrFvQs5I5Sd+N+2c3oSnwunnM=;
        b=euJkNdMVR1inc2ZutRrK7v4anYhACwrH4eg6qDhjT452DR+4H38Y96TyLDYkc9WxBD
         qDikuJgl06JLihR/ra1RYGCXlsoSHc0+/GpT+YJsGzjLSMLzVjQrja4+vfIBA4XUxzpP
         4r4bnX2rMkFhyFGaXXyyE3JuXoQdbW1vleeLL032IpmWbgkmdI6Y1RWtrOwWkbVeq3sO
         jaEnuURnQuygwkh3hVr4rmEEgUq3eX5cF+pJLfAl5Q7qrvphXGb4DSMO2UP6cn6Nn2cR
         +Ry+GK2PiGHULmdzXF+di59hsCgMTMfpW66+rEBucEvU8tDJrPEU2RzbyycUJqeMnGjb
         PT0w==
X-Forwarded-Encrypted: i=1; AJvYcCXket4YHLU8AM3pNNU9VoCfLz7dxOkfhnztH9TsR1wNCTZ0yljTXc/QfLh6hSi3FyqG1HD+tb3c+uquS8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtrvnlLhQ31BXi5+WC0Ykvks068vNX4FxShlP163JCOgteNOl
	ZSHCpDgrJqX4r78YdfD9XP28+FFt/OB/dcbBBUwUFP6vgSN7SI24
X-Gm-Gg: ASbGncuYdyolwr2gT4+cNOhwHFnyfynQiUxFPZjWIF3ezzhVf7aVuWjJ6HJDvrIHFKA
	KjKeFztncbjmvoZ9zdvvzU06KuwAIqqfV6OT/9RXC7Q7HYppwah2xpLJ61Aot9FqYmeEeYxhJ81
	vDniigpfQk+gG6D0LJSjmP6Tq6TDOvP3Ukgoto+BIlFtpEq46ssPowDheO20ugfbR9iQ2+f3YJo
	otpaWrBWyDgO/sii0KvYqKD0yHTajUHtf1FWEJpBJwtCs3L1pjfDBwIrNtCDsUUK+UdKvJvY63f
	qAKmu2JaodMoAR+IaKldrFmInkNTp3Ag/RpcWPzQPLf2iHmWUM6bSy398npQzZ3A69LT7gA2T47
	C5IWcWwLeEzee85tSKmr/1+rJyKfCwQst
X-Google-Smtp-Source: AGHT+IHRlg6a5WHt94wQjV8YuRdQ/K6mGEvKQnnyq4TjuTRN2piQcoQkGA0KObUeZNfpEsvXdV7ggA==
X-Received: by 2002:a05:6402:4588:b0:5dc:cc90:a384 with SMTP id 4fb4d7f45d1cf-5de450a9cadmr7346610a12.22.1739024124086;
        Sat, 08 Feb 2025 06:15:24 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f9a6sm4530201a12.55.2025.02.08.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 06:15:23 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [RFC PATCH v1 net-next] net: mlxsw_sp: Use switchdev_handle_port_obj_add_foreign() for vxlan
Date: Sat,  8 Feb 2025 15:15:18 +0100
Message-ID: <20250208141518.191782-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending as RFC as I do not own this hardware. This code is not tested.

Vladimir found this part of the spectrum switchdev, while looking at
another issue here:

https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/

As vxlan seems a foreign port, wouldn't it be better to use
switchdev_handle_port_obj_add_foreign() ?

Note that port_obj_info->handled = true is set in
__switchdev_handle_port_obj_add() and can be removed.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +
 .../mellanox/mlxsw/spectrum_switchdev.c       | 92 ++++++++++---------
 3 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index d714311fd884..f03b489f7b99 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4002,6 +4002,12 @@ bool mlxsw_sp_port_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &mlxsw_sp_port_netdev_ops;
 }
 
+bool mlxsw_sp_foreign_dev_check(const struct net_device *dev,
+				const struct net_device *foreign_dev)
+{
+	return netif_is_vxlan(foreign_dev);
+}
+
 static int mlxsw_sp_lower_dev_walk(struct net_device *lower_dev,
 				   struct netdev_nested_priv *priv)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index b10f80fc651b..4264468c5a6f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -709,6 +709,8 @@ int mlxsw_sp_flow_counter_alloc(struct mlxsw_sp *mlxsw_sp,
 void mlxsw_sp_flow_counter_free(struct mlxsw_sp *mlxsw_sp,
 				unsigned int counter_index);
 bool mlxsw_sp_port_dev_check(const struct net_device *dev);
+bool mlxsw_sp_foreign_dev_check(const struct net_device *dev,
+				const struct net_device *foreign_dev);
 struct mlxsw_sp *mlxsw_sp_lower_get(struct net_device *dev);
 struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find(struct net_device *dev);
 struct mlxsw_sp_port *mlxsw_sp_port_dev_lower_find_rcu(struct net_device *dev);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6397ff0dc951..0ab80cb22bc4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2252,6 +2252,14 @@ mlxsw_sp_port_mrouter_update_mdb(struct mlxsw_sp_port *mlxsw_sp_port,
 	}
 }
 
+static int
+mlxsw_sp_switchdev_handle_vxlan_obj_add(struct net_device *vxlan_dev,
+					const struct switchdev_obj *obj,
+					struct netlink_ext_ack *extack);
+static void
+mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
+					const struct switchdev_obj *obj);
+
 static int mlxsw_sp_port_obj_add(struct net_device *dev, const void *ctx,
 				 const struct switchdev_obj *obj,
 				 struct netlink_ext_ack *extack)
@@ -2262,16 +2270,20 @@ static int mlxsw_sp_port_obj_add(struct net_device *dev, const void *ctx,
 
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
-
-		err = mlxsw_sp_port_vlans_add(mlxsw_sp_port, vlan, extack);
-
-		/* The event is emitted before the changes are actually
-		 * applied to the bridge. Therefore schedule the respin
-		 * call for later, so that the respin logic sees the
-		 * updated bridge state.
-		 */
-		mlxsw_sp_span_respin(mlxsw_sp_port->mlxsw_sp);
+		if (netif_is_vxlan(dev)) {
+			err = mlxsw_sp_switchdev_handle_vxlan_obj_add(dev, obj, extack);
+		} else {
+			vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+
+			err = mlxsw_sp_port_vlans_add(mlxsw_sp_port, vlan, extack);
+
+			/* The event is emitted before the changes are actually
+			 * applied to the bridge. Therefore schedule the respin
+			 * call for later, so that the respin logic sees the
+			 * updated bridge state.
+			 */
+			mlxsw_sp_span_respin(mlxsw_sp_port->mlxsw_sp);
+		}
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		err = mlxsw_sp_port_mdb_add(mlxsw_sp_port,
@@ -2401,8 +2413,12 @@ static int mlxsw_sp_port_obj_del(struct net_device *dev, const void *ctx,
 
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		err = mlxsw_sp_port_vlans_del(mlxsw_sp_port,
-					      SWITCHDEV_OBJ_PORT_VLAN(obj));
+		if (netif_is_vxlan(dev)) {
+			mlxsw_sp_switchdev_handle_vxlan_obj_del(dev, obj);
+		} else {
+			err = mlxsw_sp_port_vlans_del(mlxsw_sp_port,
+						      SWITCHDEV_OBJ_PORT_VLAN(obj));
+		}
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		err = mlxsw_sp_port_mdb_del(mlxsw_sp_port,
@@ -3931,19 +3947,17 @@ mlxsw_sp_switchdev_vxlan_vlan_del(struct mlxsw_sp *mlxsw_sp,
 
 static int
 mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device *vxlan_dev,
-				   struct switchdev_notifier_port_obj_info *
-				   port_obj_info)
+				   const struct switchdev_obj *obj,
+				   struct netlink_ext_ack *extack)
 {
 	struct switchdev_obj_port_vlan *vlan =
-		SWITCHDEV_OBJ_PORT_VLAN(port_obj_info->obj);
+		SWITCHDEV_OBJ_PORT_VLAN(obj);
 	bool flag_untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool flag_pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	struct mlxsw_sp_bridge_device *bridge_device;
-	struct netlink_ext_ack *extack;
 	struct mlxsw_sp *mlxsw_sp;
 	struct net_device *br_dev;
 
-	extack = switchdev_notifier_info_to_extack(&port_obj_info->info);
 	br_dev = netdev_master_upper_dev_get(vxlan_dev);
 	if (!br_dev)
 		return 0;
@@ -3952,8 +3966,6 @@ mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device *vxlan_dev,
 	if (!mlxsw_sp)
 		return 0;
 
-	port_obj_info->handled = true;
-
 	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
 	if (!bridge_device)
 		return -EINVAL;
@@ -3969,11 +3981,10 @@ mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device *vxlan_dev,
 
 static void
 mlxsw_sp_switchdev_vxlan_vlans_del(struct net_device *vxlan_dev,
-				   struct switchdev_notifier_port_obj_info *
-				   port_obj_info)
+				   const struct switchdev_obj *obj)
 {
 	struct switchdev_obj_port_vlan *vlan =
-		SWITCHDEV_OBJ_PORT_VLAN(port_obj_info->obj);
+		SWITCHDEV_OBJ_PORT_VLAN(obj);
 	struct mlxsw_sp_bridge_device *bridge_device;
 	struct mlxsw_sp *mlxsw_sp;
 	struct net_device *br_dev;
@@ -3986,8 +3997,6 @@ mlxsw_sp_switchdev_vxlan_vlans_del(struct net_device *vxlan_dev,
 	if (!mlxsw_sp)
 		return;
 
-	port_obj_info->handled = true;
-
 	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
 	if (!bridge_device)
 		return;
@@ -4001,15 +4010,15 @@ mlxsw_sp_switchdev_vxlan_vlans_del(struct net_device *vxlan_dev,
 
 static int
 mlxsw_sp_switchdev_handle_vxlan_obj_add(struct net_device *vxlan_dev,
-					struct switchdev_notifier_port_obj_info *
-					port_obj_info)
+					const struct switchdev_obj *obj,
+					struct netlink_ext_ack *extack)
 {
 	int err = 0;
 
-	switch (port_obj_info->obj->id) {
+	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		err = mlxsw_sp_switchdev_vxlan_vlans_add(vxlan_dev,
-							 port_obj_info);
+							 obj, extack);
 		break;
 	default:
 		break;
@@ -4020,12 +4029,11 @@ mlxsw_sp_switchdev_handle_vxlan_obj_add(struct net_device *vxlan_dev,
 
 static void
 mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net_device *vxlan_dev,
-					struct switchdev_notifier_port_obj_info *
-					port_obj_info)
+					const struct switchdev_obj *obj)
 {
-	switch (port_obj_info->obj->id) {
+	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		mlxsw_sp_switchdev_vxlan_vlans_del(vxlan_dev, port_obj_info);
+		mlxsw_sp_switchdev_vxlan_vlans_del(vxlan_dev, obj);
 		break;
 	default:
 		break;
@@ -4040,20 +4048,16 @@ static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unused,
 
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
-		if (netif_is_vxlan(dev))
-			err = mlxsw_sp_switchdev_handle_vxlan_obj_add(dev, ptr);
-		else
-			err = switchdev_handle_port_obj_add(dev, ptr,
-							mlxsw_sp_port_dev_check,
-							mlxsw_sp_port_obj_add);
+		err = switchdev_handle_port_obj_add_foreign(dev, ptr,
+							    mlxsw_sp_port_dev_check,
+							    mlxsw_sp_foreign_dev_check,
+							    mlxsw_sp_port_obj_add);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
-		if (netif_is_vxlan(dev))
-			mlxsw_sp_switchdev_handle_vxlan_obj_del(dev, ptr);
-		else
-			err = switchdev_handle_port_obj_del(dev, ptr,
-							mlxsw_sp_port_dev_check,
-							mlxsw_sp_port_obj_del);
+		err = switchdev_handle_port_obj_del_foreign(dev, ptr,
+							    mlxsw_sp_port_dev_check,
+							    mlxsw_sp_foreign_dev_check,
+							    mlxsw_sp_port_obj_del);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
 		err = switchdev_handle_port_attr_set(dev, ptr,
-- 
2.47.1


