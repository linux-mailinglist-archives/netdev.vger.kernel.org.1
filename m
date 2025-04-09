Return-Path: <netdev+bounces-180688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0FA821E5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602911BA06C3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404F25D551;
	Wed,  9 Apr 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="i1jrz/RO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2525484C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193999; cv=none; b=DULhWurDVHaubDJlE+9MMU2WS06C8eCqeWlHq0rgVusgYXlMAmvz8DhCL39zQoVKu5oQxe2pt1QVnHlhxTCeihmzgE3ODsb85G22zI/OjTq94ctNPfgLn0heDsQ66ULq21122On+ZR6yT5vXeUBcl4tMxOXt3cMY/qstbpUosq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193999; c=relaxed/simple;
	bh=p7pacLd3PulMfGfRttBZoQwZ69k59P6QPwfZRrSE3vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6IuKEejuUJYFSt4OtlX5vdn6WAfHCrjcHhZqNZRdj2LqEAB1Qra//xz6PAJbVnnquI52ZoGmp6FIzvCmFlg6aqL+PNWbJArO60dmu2tFpkW8wzse9oVQQcjJML6s5v4Fp6xRRn3G/UV9/auvmJZ8yk9yYauSLzzRSnSKBcQZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=i1jrz/RO; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4ZXf871294z9trN;
	Wed,  9 Apr 2025 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1744193991; bh=p7pacLd3PulMfGfRttBZoQwZ69k59P6QPwfZRrSE3vo=;
	h=From:To:Cc:Subject:Date:From;
	b=i1jrz/ROI7dvqU0oYMl+4r1Ub7TTTHDFzbZF0385LVb/uTahSey+zle5YJWB80ziR
	 5mwd+u6Ivea6yYgxgfEcr3Z/U6n/K9x98RuadiakzM01LKzz7zEArVqXEGlFZYr3k+
	 IjRfd9zroJ0VpzjLXt0uMpy3LTP/UJH90K29ZULo=
X-Riseup-User-ID: 9FCD14B935416C469B0D91EA530B3291EF2FF94C9C91F186644DB1D323BE2772
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZXf8465YfzFtY8;
	Wed,  9 Apr 2025 10:19:48 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	pabeni@redhat.com,
	shannon.nelson@amd.com,
	horms@kernel.org,
	lukma@denx.de,
	kuba@kernel.org,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP
Date: Wed,  9 Apr 2025 12:19:11 +0200
Message-ID: <20250409101911.3120-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to work properly PRP requires slave1 and slave2 to share the
same MAC address. To ease the configuration process on userspace tools,
sync the slave2 MAC address with slave1. In addition, when deleting the
port from the list, restore the original MAC address.

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
v3: restore the original MAC address on slave removal.
---
 net/hsr/hsr_device.c | 5 +++++
 net/hsr/hsr_main.c   | 9 +++++++++
 net/hsr/hsr_main.h   | 1 +
 net/hsr/hsr_slave.c  | 2 ++
 4 files changed, 17 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 439cfb7ad5d1..e8922e8d9398 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res)
 		goto err_unregister;
 
+	if (protocol_version == PRP_V1) {
+		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
+		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
+	}
+
 	if (interlink) {
 		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
 		if (res)
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index d7ae32473c41..192893c3f2ec 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			eth_hw_addr_set(master->dev, dev->dev_addr);
 			call_netdevice_notifiers(NETDEV_CHANGEADDR,
 						 master->dev);
+
+			if (hsr->prot_version == PRP_V1) {
+				port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
+				if (port) {
+					eth_hw_addr_set(port->dev, dev->dev_addr);
+					call_netdevice_notifiers(NETDEV_CHANGEADDR,
+								 port->dev);
+				}
+			}
 		}
 
 		/* Make sure we recognize frames from ourselves in hsr_rcv() */
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 1bc47b17a296..135ec5fce019 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -155,6 +155,7 @@ struct hsr_port {
 	struct hsr_priv		*hsr;
 	enum hsr_port_type	type;
 	struct rcu_head		rcu;
+	unsigned char		original_macaddress[ETH_ALEN];
 };
 
 struct hsr_frame_info;
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 2a802a5de2ac..b87b6a6fe070 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	port->hsr = hsr;
 	port->dev = dev;
 	port->type = type;
+	ether_addr_copy(port->original_macaddress, dev->dev_addr);
 
 	if (type != HSR_PT_MASTER) {
 		res = hsr_portdev_setup(hsr, dev, port, extack);
@@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
 		if (!port->hsr->fwd_offloaded)
 			dev_set_promiscuity(port->dev, -1);
 		netdev_upper_dev_unlink(port->dev, master->dev);
+		eth_hw_addr_set(port->dev, port->original_macaddress);
 	}
 
 	kfree_rcu(port, rcu);
-- 
2.49.0


