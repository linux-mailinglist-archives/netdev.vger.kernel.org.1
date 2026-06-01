Return-Path: <netdev+bounces-293750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDO8IWB9HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637CB61F633
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C766301602A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA33A48DF;
	Mon,  1 Jun 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="eTH/ew4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637437F01C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317418; cv=none; b=WIyYLsjtlCctvHeuBqKRTYCjCsFpScWq1c6xhPelvKMUJRdeYeUoCqGT62DJIeJXZ74Q6fvI214TLgZ7u/GW6/CC52qGb1kZmoG6eT1ESCbjFkuosnrOEiPC0D1j5uclJExVNOS9+685XRUas0m8POR3VPMfZqthSTHPfsD2SK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317418; c=relaxed/simple;
	bh=RG5mDP4M+0zkiDVyBtxNp2Nc02hvc1pSHJ/MasRzBMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzHoKzGbLAzsml7OifsayLdVtSpylan3tzjObD020xrGwodkEPrZRB+GkYcFgBmul63HQr0Eu2BZfHf9KY0FAAU8qR6ctfFtmICgSiiQnQXE/227T5vvDbIYwD6m4BsOfRxNxJhTmLVkpfAt14PWGSYOu0twNdv1hAG9ohoLUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=eTH/ew4X; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kR+lMVzOxfZfBB0GtzI2JSUQ02eAqwdJHqeWDaTCYY=;
	b=eTH/ew4X5/ScMH5D5VdCeroiRUmlIQNU7/lAnAbGSrYbWDr5AFNBltRbxAMOWH6PjjspMF
	jhGtf44JTvuq8sKApZfAzANeT+TNsjAqKelLvCcyOpgdiSXrpm4Syv7RLQ8oEPRZcX6GMe
	rAPJo7e4ZDUY5VGfPX8ifw67yGLXOV2xgVPvg/opWZ43QDuSpl7DR6vG1gHnH/v/mWH4pV
	TQNGT57ihkgDDUxg9SXoe8iVFs0+R/Lr4hMiiLBPadNmn1w4crP5ZbX8TSFDTxjElCRItL
	t0oCcn5j+KrN58ElOSOZSfVplbeiQ1WEQFqLucICPFunoZXyAVitLmXA1R/K5w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next v2 06/15] batman-adv: extract netdev wifi detection information object
Date: Mon,  1 Jun 2026 14:36:20 +0200
Message-ID: <20260601123629.707089-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293750-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: 637CB61F633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Previously, wifi_flags were stored directly in batadv_hard_iface, which is
created for every network interface on the system (including those never
attached to a mesh interface). This wastes memory and complicates the
long-term goal of lazily allocating batadv_hard_iface only for interfaces
that actually join a mesh.

The problem is that several batman-adv features need wifi detection for
net_devices (and their underlying devices) regardless of whether a
batadv_hard_iface exists for them:

* B.A.T.M.A.N. IV TQ hop penalty calculation
* B.A.T.M.A.N. V ELP probing / throughput estimation
* AP isolation

To decouple wifi detection from batadv_hard_iface lifetime, introduce a
global rhashtable (batadv_wifi_net_devices) mapping net_device pointers to
batadv_wifi_net_device_state objects. Only net_devices that are actually
detected as (indirect) wifi interfaces occupy an entry, keeping the common
(non-wifi) case allocation-free.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c      |   6 +-
 net/batman-adv/hard-interface.c | 191 +++++++++++++++++++++++++++++---
 net/batman-adv/hard-interface.h |  34 +++++-
 net/batman-adv/main.c           |  16 ++-
 net/batman-adv/types.h          |  30 ++++-
 5 files changed, 252 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fdc2abe96d777..e207093de79fe 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -85,6 +85,7 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
+	u32 wifi_flags;
 	u32 throughput;
 	int ret;
 
@@ -106,8 +107,9 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
 	 */
-	if (batadv_is_wifi_hardif(hard_iface)) {
-		if (!batadv_is_cfg80211_hardif(hard_iface))
+	wifi_flags = batadv_hardif_get_wifi_flags(hard_iface);
+	if (batadv_is_wifi(wifi_flags)) {
+		if (!batadv_is_cfg80211(wifi_flags))
 			/* unsupported WiFi driver version */
 			goto default_throughput;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4b3804ef70b6f..647fda1898e55 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -26,6 +26,8 @@
 #include <linux/notifier.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
+#include <linux/rhashtable-types.h>
+#include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -43,6 +45,15 @@
 #include "send.h"
 #include "translation-table.h"
 
+static const struct rhashtable_params batadv_wifi_net_devices_params = {
+	.key_len		= sizeof(struct net_device *),
+	.key_offset		= offsetof(struct batadv_wifi_net_device_state, netdev),
+	.head_offset		= offsetof(struct batadv_wifi_net_device_state, l),
+	.automatic_shrinking	= true,
+};
+
+static struct rhashtable batadv_wifi_net_devices;
+
 /**
  * batadv_hardif_release() - release hard interface from lists and queue for
  *  free after rcu grace period
@@ -356,21 +367,28 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 }
 
 /**
- * batadv_is_cfg80211_hardif() - check if the given hardif is a cfg80211 wifi
- *  interface
+ * batadv_hardif_get_wifi_flags() - retrieve wifi flags for hard_iface
  * @hard_iface: the device to check
  *
- * Return: true if the net device is a cfg80211 wireless device, false
- *  otherwise.
+ * Return: batadv_hard_iface_wifi_flags flags of the device
  */
-bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface)
 {
-	u32 allowed_flags = 0;
+	struct batadv_wifi_net_device_state *device_state;
+	u32 wifi_flags = 0;
+
+	if (!hard_iface)
+		return 0;
 
-	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
-	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
+	rcu_read_lock();
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &hard_iface->net_dev,
+					      batadv_wifi_net_devices_params);
+	if (device_state)
+		wifi_flags = READ_ONCE(device_state->wifi_flags);
+	rcu_read_unlock();
 
-	return !!(hard_iface->wifi_flags & allowed_flags);
+	return wifi_flags;
 }
 
 /**
@@ -381,10 +399,9 @@ bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
  */
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
 {
-	if (!hard_iface)
-		return false;
+	u32 wifi_flags = batadv_hardif_get_wifi_flags(hard_iface);
 
-	return hard_iface->wifi_flags != 0;
+	return batadv_is_wifi(wifi_flags);
 }
 
 /**
@@ -890,7 +907,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	kref_init(&hard_iface->refcount);
 
 	hard_iface->num_bcasts = BATADV_NUM_BCASTS_DEFAULT;
-	hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
 	if (batadv_is_wifi_hardif(hard_iface))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
@@ -942,6 +958,131 @@ static int batadv_hard_if_event_meshif(unsigned long event,
 	return NOTIFY_DONE;
 }
 
+/**
+ * batadv_wifi_net_device_insert() - save information about wifi net_device
+ * @net_dev: net_device to add to batadv_wifi_net_devices
+ * @wifi_flags: net_device which generated an event
+ *
+ * Return: 0 on result, negative value on error
+ */
+static int
+batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
+{
+	struct batadv_wifi_net_device_state *device_state;
+	int ret;
+
+	ASSERT_RTNL();
+
+	device_state = kzalloc_obj(*device_state, GFP_ATOMIC);
+	if (!device_state)
+		return -ENOMEM;
+
+	device_state->wifi_flags = wifi_flags;
+	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
+	device_state->netdev = net_dev;
+	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
+
+	ret = rhashtable_insert_fast(&batadv_wifi_net_devices, &device_state->l,
+				     batadv_wifi_net_devices_params);
+	if (ret < 0)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	netdev_put(device_state->netdev, &device_state->dev_tracker);
+	kfree(device_state);
+	return ret;
+}
+
+/**
+ * batadv_wifi_net_device_remove() - remove information about wifi net_device
+ * @device_state: wifi net_device state to remove from batadv_wifi_net_device_state
+ */
+static void
+batadv_wifi_net_device_remove(struct batadv_wifi_net_device_state *device_state)
+{
+	ASSERT_RTNL();
+
+	rhashtable_remove_fast(&batadv_wifi_net_devices, &device_state->l,
+			       batadv_wifi_net_devices_params);
+	netdev_put(device_state->netdev, &device_state->dev_tracker);
+	kfree_rcu(device_state, rcu);
+}
+
+/**
+ * batadv_wifi_net_device_update() - update wifi state of net_device
+ * @net_dev: net_device to update in batadv_wifi_net_devices
+ *
+ * The device will only be stored in batadv_wifi_net_devices when
+ * it could be identified as wifi device. If the net_device is no
+ * longer a wifi device, it is automatically removed from
+ * batadv_wifi_net_devices.
+ */
+static void
+batadv_wifi_net_device_update(struct net_device *net_dev)
+{
+	struct batadv_wifi_net_device_state *device_state;
+	u32 wifi_flags;
+
+	ASSERT_RTNL();
+
+	wifi_flags = batadv_wifi_flags_evaluate(net_dev);
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &net_dev,
+					      batadv_wifi_net_devices_params);
+
+	if (device_state) {
+		if (batadv_is_wifi(wifi_flags))
+			WRITE_ONCE(device_state->wifi_flags, wifi_flags);
+		else
+			batadv_wifi_net_device_remove(device_state);
+	} else if (batadv_is_wifi(wifi_flags)) {
+		batadv_wifi_net_device_insert(net_dev, wifi_flags);
+	}
+}
+
+/**
+ * batadv_wifi_net_device_unregister() - remove wifi state of net_device
+ * @net_dev: net_device to remove from batadv_wifi_net_devices
+ */
+static void
+batadv_wifi_net_device_unregister(struct net_device *net_dev)
+{
+	struct batadv_wifi_net_device_state *device_state;
+
+	ASSERT_RTNL();
+
+	device_state = rhashtable_lookup_fast(&batadv_wifi_net_devices,
+					      &net_dev,
+					      batadv_wifi_net_devices_params);
+	if (!device_state)
+		return;
+
+	batadv_wifi_net_device_remove(device_state);
+}
+
+/**
+ * batadv_wifi_net_device_event() - handle network events for batadv_wifi_net_devices
+ * @event: enum netdev_cmd event to handle
+ * @net_dev: net_device to update in batadv_wifi_net_devices
+ */
+static void batadv_wifi_net_device_event(unsigned long event,
+					 struct net_device *net_dev)
+{
+	switch (event) {
+	case NETDEV_REGISTER:
+	case NETDEV_POST_TYPE_CHANGE:
+	case NETDEV_CHANGEUPPER:
+		batadv_wifi_net_device_update(net_dev);
+		break;
+	case NETDEV_UNREGISTER:
+	case NETDEV_PRE_TYPE_CHANGE:
+		batadv_wifi_net_device_unregister(net_dev);
+		break;
+	}
+}
+
 static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
@@ -953,6 +1094,8 @@ static int batadv_hard_if_event(struct notifier_block *this,
 	if (batadv_meshif_is_valid(net_dev))
 		return batadv_hard_if_event_meshif(event, net_dev);
 
+	batadv_wifi_net_device_event(event, net_dev);
+
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	if (!hard_iface && (event == NETDEV_REGISTER ||
 			    event == NETDEV_POST_TYPE_CHANGE))
@@ -996,8 +1139,9 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface == primary_if)
 			batadv_primary_if_update_addr(bat_priv, NULL);
 		break;
+	case NETDEV_REGISTER:
+	case NETDEV_POST_TYPE_CHANGE:
 	case NETDEV_CHANGEUPPER:
-		hard_iface->wifi_flags = batadv_wifi_flags_evaluate(net_dev);
 		if (batadv_is_wifi_hardif(hard_iface))
 			hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 		break;
@@ -1015,3 +1159,22 @@ static int batadv_hard_if_event(struct notifier_block *this,
 struct notifier_block batadv_hard_if_notifier = {
 	.notifier_call = batadv_hard_if_event,
 };
+
+/**
+ * batadv_wifi_net_devices_init() - Initialize wifi devices cache
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int __init batadv_wifi_net_devices_init(void)
+{
+	return rhashtable_init(&batadv_wifi_net_devices,
+			       &batadv_wifi_net_devices_params);
+}
+
+/**
+ * batadv_wifi_net_devices_deinit() - Deinitialize wifi devices cache
+ */
+void batadv_wifi_net_devices_deinit(void)
+{
+	rhashtable_destroy(&batadv_wifi_net_devices);
+}
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9ba8fb2bdceb4..089e65c8a4817 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -10,6 +10,7 @@
 #include "main.h"
 
 #include <linux/compiler.h>
+#include <linux/init.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/rcupdate.h>
@@ -69,7 +70,7 @@ extern struct notifier_block batadv_hard_if_notifier;
 
 struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
 struct net_device *batadv_get_real_netdev(struct net_device *net_device);
-bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
+u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
 batadv_hardif_get_by_netdev(const struct net_device *net_dev);
@@ -81,6 +82,8 @@ void batadv_update_min_mtu(struct net_device *mesh_iface);
 void batadv_hardif_release(struct kref *ref);
 int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 			       u8 *orig_addr, u8 *orig_neigh);
+int __init batadv_wifi_net_devices_init(void);
+void batadv_wifi_net_devices_deinit(void);
 
 /**
  * batadv_hardif_put() - decrement the hard interface refcounter and possibly
@@ -119,4 +122,33 @@ batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 	return hard_iface;
 }
 
+/**
+ * batadv_is_cfg80211() - check if the given hardif is a cfg80211
+ *  wifi interface
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ *
+ * Return: true if the net device is a cfg80211 wireless device, false
+ *  otherwise.
+ */
+static inline bool batadv_is_cfg80211(u32 wifi_flags)
+{
+	u32 allowed_flags = 0;
+
+	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
+	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
+
+	return !!(wifi_flags & allowed_flags);
+}
+
+/**
+ * batadv_is_wifi() - check if flags belong to wifi interface
+ * @wifi_flags: extracted batadv_hard_iface_wifi_flagss of an net_device
+ *
+ * Return: true if the net device is a 802.11 wireless device, false otherwise.
+ */
+static inline bool batadv_is_wifi(u32 wifi_flags)
+{
+	return wifi_flags != 0;
+}
+
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 82bba34893788..d529014857c90 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -105,8 +105,14 @@ static int __init batadv_init(void)
 	batadv_tp_meter_init();
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
-	if (!batadv_event_workqueue)
+	if (!batadv_event_workqueue) {
+		ret = -ENOMEM;
 		goto err_create_wq;
+	}
+
+	ret = batadv_wifi_net_devices_init();
+	if (ret < 0)
+		goto err_init_wifi;
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 	rtnl_link_register(&batadv_link_ops);
@@ -117,10 +123,15 @@ static int __init batadv_init(void)
 
 	return 0;
 
+err_init_wifi:
+	destroy_workqueue(batadv_event_workqueue);
+	batadv_event_workqueue = NULL;
+	rcu_barrier();
+
 err_create_wq:
 	batadv_tt_cache_destroy();
 
-	return -ENOMEM;
+	return ret;
 }
 
 static void __exit batadv_exit(void)
@@ -134,6 +145,7 @@ static void __exit batadv_exit(void)
 
 	rcu_barrier();
 
+	batadv_wifi_net_devices_deinit();
 	batadv_tt_cache_destroy();
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a01ee46d97f34..16fe843577421 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/rhashtable-types.h>
 #include <linux/sched.h> /* for linux/wait.h */
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
@@ -166,6 +167,29 @@ enum batadv_hard_iface_wifi_flags {
 	BATADV_HARDIF_WIFI_CFG80211_INDIRECT = BIT(3),
 };
 
+/**
+ * struct batadv_wifi_net_device_state - cache of wifi information of net_devices
+ */
+struct batadv_wifi_net_device_state {
+	/** @l: anchor in rhashtable */
+	struct rhash_head l;
+
+	/** @netdev: pointer to the net_device */
+	struct net_device *netdev;
+
+	/** @dev_tracker: device tracker for @netdev */
+	netdevice_tracker dev_tracker;
+
+	/**
+	 * @wifi_flags: flags whether this is (directly or indirectly) a wifi
+	 *  interface
+	 */
+	u32 wifi_flags;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
+	struct rcu_head rcu;
+};
+
 /**
  * struct batadv_hard_iface - network device known to batman-adv
  */
@@ -181,12 +205,6 @@ struct batadv_hard_iface {
 	 */
 	u8 num_bcasts;
 
-	/**
-	 * @wifi_flags: flags whether this is (directly or indirectly) a wifi
-	 *  interface
-	 */
-	u32 wifi_flags;
-
 	/** @net_dev: pointer to the net_device */
 	struct net_device *net_dev;
 
-- 
2.47.3


