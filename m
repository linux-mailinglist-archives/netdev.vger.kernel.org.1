Return-Path: <netdev+bounces-159272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2EFA14F4F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B65E188AF9C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B61FF1C6;
	Fri, 17 Jan 2025 12:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365D1FF1C8
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117592; cv=none; b=MCmXa/CvXW/fKe1VMSEKTRNZntVL+eBoDiCFBSkJnAAqTcsEuF/0nrZgVyy7Hvz4CqaRmvN77FGeCOsGvsOcK3LDQEYLhBHjYWgZB7hCXb0HR+TGmb/hA/zNFNxjWYj943Sm+ARpGcr5oUvfnaFNNXzswexvPIjw3E/yanagY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117592; c=relaxed/simple;
	bh=P8+b/0+b5vPqA4OEh7cwNSCwlV+jHv+R4Zj0RxIsRCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQs8+adE8fttZv7f5Vagt6Tjs4LIjVii8rU1BmfHjKwqG5nIGCom/piNmbkcsTSNe1LJP+9fq7YLoCHAleydwVvgdrio+d0SKrruwz5Qg3njBg/K1ix6fPswrQVAbfy4H1lBC/XN8tSHph9QP3BRXDqgokUyZjtLz/c3IL0IRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5973c90D8A96Dd71A2E03F697.dip0.t-ipconnect.de [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B098CFA367;
	Fri, 17 Jan 2025 13:39:47 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 10/10] batman-adv: netlink: reduce duplicate code by returning interfaces
Date: Fri, 17 Jan 2025 13:39:10 +0100
Message-Id: <20250117123910.219278-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

Reduce duplicate code by using netlink helpers which return the
soft/hard interface directly. Instead of returning an interface index
which we are typically not interested in.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c |  33 ++----
 net/batman-adv/distributed-arp-table.c |  18 +--
 net/batman-adv/gateway_client.c        |  18 +--
 net/batman-adv/multicast.c             |  17 +--
 net/batman-adv/netlink.c               | 146 +++++++++++++++++--------
 net/batman-adv/netlink.h               |   5 +-
 net/batman-adv/originator.c            | 116 +++++++-------------
 net/batman-adv/translation-table.c     |  30 ++---
 8 files changed, 174 insertions(+), 209 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 449faf5a5487..8c814f790d17 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -38,7 +39,6 @@
 #include <net/arp.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -47,7 +47,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "originator.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 static const u8 batadv_announce_mac[4] = {0x43, 0x05, 0x43, 0x05};
@@ -2233,25 +2232,16 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->bla.claim_hash;
@@ -2403,25 +2393,16 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->bla.backbone_hash;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 48b72c2be098..e5a07152d4ec 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -36,7 +37,6 @@
 #include <net/arp.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
@@ -46,7 +46,6 @@
 #include "netlink.h"
 #include "originator.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -937,25 +936,16 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	int portid = NETLINK_CB(cb->skb).portid;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 	hash = bat_priv->dat.hash;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 0ddd8b4b3f4c..f68e34ed1f62 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -31,7 +32,6 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -40,7 +40,6 @@
 #include "netlink.h"
 #include "originator.h"
 #include "routing.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 /* These are the offsets of the "hw type" and "hw address length" in the dhcp
@@ -502,22 +501,13 @@ void batadv_gw_node_free(struct batadv_priv *bat_priv)
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int ret;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 14088c4ff2f6..d95c418484fa 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -12,6 +12,7 @@
 #include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -46,7 +47,6 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -56,7 +56,6 @@
 #include "log.h"
 #include "netlink.h"
 #include "send.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -2104,21 +2103,13 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 				 struct batadv_hard_iface **primary_if)
 {
 	struct batadv_hard_iface *hard_iface = NULL;
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int ret = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 9362cd9d6f3d..eefba5600ded 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -158,8 +158,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
  *
  * Return: interface index, or 0.
  */
-int
-batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
+static int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 {
 	struct nlattr *attr = nlmsg_find_attr(nlh, GENL_HDRLEN, attrtype);
 
@@ -881,14 +880,14 @@ static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_netlink_get_hardif() - Get hardif attributes
+ * batadv_netlink_cmd_get_hardif() - Get hardif attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
  * Return: 0 on success or negative error number in case of failure
  */
-static int batadv_netlink_get_hardif(struct sk_buff *skb,
-				     struct genl_info *info)
+static int batadv_netlink_cmd_get_hardif(struct sk_buff *skb,
+					 struct genl_info *info)
 {
 	struct batadv_hard_iface *hard_iface = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
@@ -964,28 +963,16 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 static int
 batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
-	int ifindex;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
 	int i = 0;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface)
-		return -ENODEV;
-
-	if (!batadv_softif_is_valid(soft_iface)) {
-		dev_put(soft_iface);
-		return -ENODEV;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -1150,23 +1137,17 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_get_softif_from_info() - Retrieve soft interface from genl attributes
+ * batadv_netlink_get_softif_from_ifindex() - Get soft-iface from ifindex
  * @net: the applicable net namespace
- * @info: receiver information
+ * @ifindex: index of the soft interface
  *
  * Return: Pointer to soft interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct net_device *
-batadv_get_softif_from_info(struct net *net, struct genl_info *info)
+batadv_netlink_get_softif_from_ifindex(struct net *net, int ifindex)
 {
 	struct net_device *soft_iface;
-	int ifindex;
-
-	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
-		return ERR_PTR(-EINVAL);
-
-	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
 
 	soft_iface = dev_get_by_index(net, ifindex);
 	if (!soft_iface)
@@ -1184,28 +1165,61 @@ batadv_get_softif_from_info(struct net *net, struct genl_info *info)
 }
 
 /**
- * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
- * @bat_priv: the bat priv with all the soft interface information
+ * batadv_netlink_get_softif_from_info() - Get soft-iface from genl attributes
  * @net: the applicable net namespace
  * @info: receiver information
  *
+ * Return: Pointer to soft interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct net_device *
+batadv_netlink_get_softif_from_info(struct net *net, struct genl_info *info)
+{
+	int ifindex;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+
+	return batadv_netlink_get_softif_from_ifindex(net, ifindex);
+}
+
+/**
+ * batadv_netlink_get_softif() - Retrieve soft interface from netlink callback
+ * @cb: callback structure containing arguments
+ *
+ * Return: Pointer to soft interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb)
+{
+	int ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						 BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return ERR_PTR(-ENONET);
+
+	return batadv_netlink_get_softif_from_ifindex(sock_net(cb->skb->sk),
+						      ifindex);
+}
+
+/**
+ * batadv_netlink_get_hardif_from_ifindex() - Get hard-iface from ifindex
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @ifindex: index of the hard interface
+ *
  * Return: Pointer to hard interface (with increased refcnt) on success, error
  *  pointer on error
  */
 static struct batadv_hard_iface *
-batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
-			    struct genl_info *info)
+batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
+				       struct net *net, int ifindex)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct net_device *hard_dev;
-	unsigned int hardif_index;
-
-	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
-		return ERR_PTR(-EINVAL);
-
-	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
 
-	hard_dev = dev_get_by_index(net, hardif_index);
+	hard_dev = dev_get_by_index(net, ifindex);
 	if (!hard_dev)
 		return ERR_PTR(-ENODEV);
 
@@ -1229,6 +1243,51 @@ batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
 	return ERR_PTR(-EINVAL);
 }
 
+/**
+ * batadv_netlink_get_hardif_from_info() - Get hard-iface from genl attributes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @info: receiver information
+ *
+ * Return: Pointer to hard interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct batadv_hard_iface *
+batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
+				    struct net *net, struct genl_info *info)
+{
+	int ifindex;
+
+	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
+
+	return batadv_netlink_get_hardif_from_ifindex(bat_priv, net, ifindex);
+}
+
+/**
+ * batadv_netlink_get_hardif() - Retrieve hard interface from netlink callback
+ * @bat_priv: the bat priv with all the soft interface information
+ * @cb: callback structure containing arguments
+ *
+ * Return: Pointer to hard interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+struct batadv_hard_iface *
+batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
+			  struct netlink_callback *cb)
+{
+	int ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						 BATADV_ATTR_HARD_IFINDEX);
+	if (!ifindex)
+		return ERR_PTR(-ENONET);
+
+	return batadv_netlink_get_hardif_from_ifindex(bat_priv,
+						      sock_net(cb->skb->sk),
+						      ifindex);
+}
+
 /**
  * batadv_get_vlan_from_info() - Retrieve vlan from genl attributes
  * @bat_priv: the bat priv with all the soft interface information
@@ -1288,7 +1347,7 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 		return -EINVAL;
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
-		soft_iface = batadv_get_softif_from_info(net, info);
+		soft_iface = batadv_netlink_get_softif_from_info(net, info);
 		if (IS_ERR(soft_iface))
 			return PTR_ERR(soft_iface);
 
@@ -1297,7 +1356,8 @@ static int batadv_pre_doit(const struct genl_split_ops *ops,
 	}
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_HARDIF) {
-		hard_iface = batadv_get_hardif_from_info(bat_priv, net, info);
+		hard_iface = batadv_netlink_get_hardif_from_info(bat_priv, net,
+								 info);
 		if (IS_ERR(hard_iface)) {
 			ret = PTR_ERR(hard_iface);
 			goto err_put_softif;
@@ -1390,7 +1450,7 @@ static const struct genl_small_ops batadv_netlink_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		/* can be retrieved by unprivileged users */
 		.dumpit = batadv_netlink_dump_hardif,
-		.doit = batadv_netlink_get_hardif,
+		.doit = batadv_netlink_cmd_get_hardif,
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_HARDIF,
 	},
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 876d2806a67d..2097c2ae98f1 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -15,7 +15,10 @@
 
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-int batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype);
+struct net_device *batadv_netlink_get_softif(struct netlink_callback *cb);
+struct batadv_hard_iface *
+batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
+			  struct netlink_callback *cb);
 
 int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 				  u8 result, u32 test_time, u64 total_bytes,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 8f6dd2c6ee41..bcc2e20e0cd6 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -26,9 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
-#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
 #include "distributed-arp-table.h"
@@ -41,7 +40,6 @@
 #include "netlink.h"
 #include "network-coding.h"
 #include "routing.h"
-#include "soft-interface.h"
 #include "translation-table.h"
 
 /* hash class keys */
@@ -755,64 +753,48 @@ batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
  */
 int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
+	struct batadv_hard_iface *primary_if, *hard_iface;
 	struct net_device *soft_iface;
-	struct net_device *hard_iface = NULL;
-	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 	int ret;
-	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out;
+		goto out_put_soft_iface;
 	}
 
-	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
-						  BATADV_ATTR_HARD_IFINDEX);
-	if (hard_ifindex) {
-		hard_iface = dev_get_by_index(net, hard_ifindex);
-		if (hard_iface)
-			hardif = batadv_hardif_get_by_netdev(hard_iface);
-
-		if (!hardif) {
-			ret = -ENODEV;
-			goto out;
-		}
-
-		if (hardif->soft_iface != soft_iface) {
-			ret = -ENOENT;
-			goto out;
-		}
+	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
+	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
+		ret = PTR_ERR(hard_iface);
+		goto out_put_primary_if;
+	} else if (IS_ERR(hard_iface)) {
+		/* => PTR_ERR(hard_iface) == -ENONET
+		 * => no hard-iface given, ok
+		 */
+		hard_iface = BATADV_IF_DEFAULT;
 	}
 
 	if (!bat_priv->algo_ops->neigh.dump) {
 		ret = -EOPNOTSUPP;
-		goto out;
+		goto out_put_hard_iface;
 	}
 
-	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hardif);
+	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hard_iface);
 
 	ret = msg->len;
 
- out:
-	batadv_hardif_put(hardif);
-	dev_put(hard_iface);
+out_put_hard_iface:
+	batadv_hardif_put(hard_iface);
+out_put_primary_if:
 	batadv_hardif_put(primary_if);
+out_put_soft_iface:
 	dev_put(soft_iface);
 
 	return ret;
@@ -1342,64 +1324,48 @@ static void batadv_purge_orig(struct work_struct *work)
  */
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
+	struct batadv_hard_iface *primary_if, *hard_iface;
 	struct net_device *soft_iface;
-	struct net_device *hard_iface = NULL;
-	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
 	struct batadv_priv *bat_priv;
-	struct batadv_hard_iface *primary_if = NULL;
 	int ret;
-	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
 		ret = -ENOENT;
-		goto out;
+		goto out_put_soft_iface;
 	}
 
-	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
-						  BATADV_ATTR_HARD_IFINDEX);
-	if (hard_ifindex) {
-		hard_iface = dev_get_by_index(net, hard_ifindex);
-		if (hard_iface)
-			hardif = batadv_hardif_get_by_netdev(hard_iface);
-
-		if (!hardif) {
-			ret = -ENODEV;
-			goto out;
-		}
-
-		if (hardif->soft_iface != soft_iface) {
-			ret = -ENOENT;
-			goto out;
-		}
+	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
+	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
+		ret = PTR_ERR(hard_iface);
+		goto out_put_primary_if;
+	} else if (IS_ERR(hard_iface)) {
+		/* => PTR_ERR(hard_iface) == -ENONET
+		 * => no hard-iface given, ok
+		 */
+		hard_iface = BATADV_IF_DEFAULT;
 	}
 
 	if (!bat_priv->algo_ops->orig.dump) {
 		ret = -EOPNOTSUPP;
-		goto out;
+		goto out_put_hard_iface;
 	}
 
-	bat_priv->algo_ops->orig.dump(msg, cb, bat_priv, hardif);
+	bat_priv->algo_ops->orig.dump(msg, cb, bat_priv, hard_iface);
 
 	ret = msg->len;
 
- out:
-	batadv_hardif_put(hardif);
-	dev_put(hard_iface);
+out_put_hard_iface:
+	batadv_hardif_put(hard_iface);
+out_put_primary_if:
 	batadv_hardif_put(primary_if);
+out_put_soft_iface:
 	dev_put(soft_iface);
 
 	return ret;
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 76d5517bb507..2bc3407f38b2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc32c.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
@@ -39,7 +40,6 @@
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -1115,26 +1115,18 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
  */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
 	int ret;
-	int ifindex;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
@@ -1890,28 +1882,20 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
 	struct hlist_head *head;
 	int ret;
-	int ifindex;
 	int bucket = cb->args[0];
 	int idx = cb->args[1];
 	int sub = cb->args[2];
 	int portid = NETLINK_CB(cb->skb).portid;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
-	if (!ifindex)
-		return -EINVAL;
-
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	soft_iface = batadv_netlink_get_softif(cb);
+	if (IS_ERR(soft_iface))
+		return PTR_ERR(soft_iface);
 
 	bat_priv = netdev_priv(soft_iface);
 
-- 
2.39.5


