Return-Path: <netdev+bounces-158374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41003A1181A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68961881EB5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8022E415;
	Wed, 15 Jan 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsnNUxWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5822E40A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913219; cv=none; b=l7BN1y+awSbe9dtDQSDJ+prseXfmSenaMQzZBC9by9OcPoBQApChNFR7GiN5QxGiHDofNaJqolHdOHP2QNvV1mgf2T3+bQrFY+cAuTmRV7E3ewz59rEuvD8CssaNtt115HPbhycu5bgLZ8V4bQEOOm9pBA2DSJzHaDGlTBB4lXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913219; c=relaxed/simple;
	bh=y/Qa4jSrQoepeNwZ4Prd7/DoPeFA/ecn7vKCQgm7NcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCPXEd6QcOGaw45DtuB90V2SpgoEoKaH/2Eua7d4WjgMVHULIN94UvlTjpHtQDD2YVWL0lksvlkZxqtGCkMBc4/uEFhFGrKaMG/G6Msxq66HjCQmCfYNWiiioR3PyhaxPgVmO4lP7yyLop2RO1OcKfdF3dvg+Kme3W3DYn6uWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsnNUxWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E516C4CEDF;
	Wed, 15 Jan 2025 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913218;
	bh=y/Qa4jSrQoepeNwZ4Prd7/DoPeFA/ecn7vKCQgm7NcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsnNUxWjRpZGBhaK57SuEhxRNhm63odmiPrKfhcgLZhG9Kvh6Ejwu1lzAJmWBjjD8
	 I4u/u28whWl7vmu+P3nC4F4pQZRGZoc9OlMGx32J+RUD3XmZ+Tu/fYrPRgOf8+1mfd
	 ikrLrofc21PvWuhfGx5+rLrnDaws/GF0Z1KFktl51yTS6CePeK3I+LnKBDFyKEQzE5
	 nH5PV+rHJKb0ZdHNNlTzr36jtDCMxxFFesTwddD+7CMtKb5/lWKRZRNRJHzZqY3Egf
	 JDeg1/trl201KF3EwXikwPx3FsTRReRsX3/1+TbfGU1siw8FH05r3cHsmBdGg7arHV
	 y/ntkTIe3wODw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/11] net: add helpers for lookup and walking netdevs under netdev_lock()
Date: Tue, 14 Jan 2025 19:53:11 -0800
Message-ID: <20250115035319.559603-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers for accessing netdevs under netdev_lock().
There's some careful handling needed to find the device and lock it
safely, without it getting unregistered, and without taking rtnl_lock
(the latter being the whole point of the new locking, after all).

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add missing READ_ONCE() when under RCU
v1: https://lore.kernel.org/20250114035118.110297-3-kuba@kernel.org
---
 net/core/dev.h |  16 +++++++
 net/core/dev.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/net/core/dev.h b/net/core/dev.h
index d8966847794c..25ae732c0775 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -2,6 +2,7 @@
 #ifndef _NET_CORE_DEV_H
 #define _NET_CORE_DEV_H
 
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/rwsem.h>
 #include <linux/netdevice.h>
@@ -23,8 +24,23 @@ struct sd_flow_limit {
 extern int netdev_flow_limit_table_len;
 
 struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
+struct napi_struct *
+netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
+struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
+struct net_device *__netdev_put_lock(struct net_device *dev);
+struct net_device *
+netdev_xa_find_lock(struct net *net, struct net_device *dev,
+		    unsigned long *index);
+
+DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
+
+#define for_each_netdev_lock_scoped(net, var_name, ifindex)		\
+	for (struct net_device *var_name __free(netdev_unlock) = NULL;	\
+	     (var_name = netdev_xa_find_lock(net, var_name, &ifindex)); \
+	     ifindex++)
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
diff --git a/net/core/dev.c b/net/core/dev.c
index 6603c08768f6..c871e2697fb6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -783,6 +783,49 @@ struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id)
 	return napi;
 }
 
+/**
+ *	netdev_napi_by_id_lock() - find a device by NAPI ID and lock it
+ *	@net: the applicable net namespace
+ *	@napi_id: ID of a NAPI of a target device
+ *
+ *	Find a NAPI instance with @napi_id. Lock its device.
+ *	The device must be in %NETREG_REGISTERED state for lookup to succeed.
+ *	netdev_unlock() must be called to release it.
+ *
+ *	Return: pointer to NAPI, its device with lock held, NULL if not found.
+ */
+struct napi_struct *
+netdev_napi_by_id_lock(struct net *net, unsigned int napi_id)
+{
+	struct napi_struct *napi;
+	struct net_device *dev;
+
+	rcu_read_lock();
+	napi = netdev_napi_by_id(net, napi_id);
+	if (!napi || READ_ONCE(napi->dev->reg_state) != NETREG_REGISTERED) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	dev = napi->dev;
+	dev_hold(dev);
+	rcu_read_unlock();
+
+	dev = __netdev_put_lock(dev);
+	if (!dev)
+		return NULL;
+
+	rcu_read_lock();
+	napi = netdev_napi_by_id(net, napi_id);
+	if (napi && napi->dev != dev)
+		napi = NULL;
+	rcu_read_unlock();
+
+	if (!napi)
+		netdev_unlock(dev);
+	return napi;
+}
+
 /**
  *	__dev_get_by_name	- find a device by its name
  *	@net: the applicable net namespace
@@ -971,6 +1014,73 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
 	return napi ? napi->dev : NULL;
 }
 
+/* Release the held reference on the net_device, and if the net_device
+ * is still registered try to lock the instance lock. If device is being
+ * unregistered NULL will be returned (but the reference has been released,
+ * either way!)
+ *
+ * This helper is intended for locking net_device after it has been looked up
+ * using a lockless lookup helper. Lock prevents the instance from going away.
+ */
+struct net_device *__netdev_put_lock(struct net_device *dev)
+{
+	netdev_lock(dev);
+	if (dev->reg_state > NETREG_REGISTERED) {
+		netdev_unlock(dev);
+		dev_put(dev);
+		return NULL;
+	}
+	dev_put(dev);
+	return dev;
+}
+
+/**
+ *	netdev_get_by_index_lock() - find a device by its ifindex
+ *	@net: the applicable net namespace
+ *	@ifindex: index of device
+ *
+ *	Search for an interface by index. If a valid device
+ *	with @ifindex is found it will be returned with netdev->lock held.
+ *	netdev_unlock() must be called to release it.
+ *
+ *	Return: pointer to a device with lock held, NULL if not found.
+ */
+struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
+{
+	struct net_device *dev;
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev)
+		return NULL;
+
+	return __netdev_put_lock(dev);
+}
+
+struct net_device *
+netdev_xa_find_lock(struct net *net, struct net_device *dev,
+		    unsigned long *index)
+{
+	if (dev)
+		netdev_unlock(dev);
+
+	do {
+		rcu_read_lock();
+		dev = xa_find(&net->dev_by_index, index, ULONG_MAX, XA_PRESENT);
+		if (!dev) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		dev_hold(dev);
+		rcu_read_unlock();
+
+		dev = __netdev_put_lock(dev);
+		if (dev)
+			return dev;
+
+		(*index)++;
+	} while (true);
+}
+
 static DEFINE_SEQLOCK(netdev_rename_lock);
 
 void netdev_copy_name(struct net_device *dev, char *name)
-- 
2.48.0


