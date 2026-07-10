Return-Path: <netdev+bounces-306464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7QqXMfyvUGrd3QIAu9opvQ
	(envelope-from <netdev+bounces-306464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D3738949
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:40:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fritz.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306464-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306464-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7355303D708
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022443F077C;
	Fri, 10 Jul 2026 08:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA13D8133;
	Fri, 10 Jul 2026 08:36:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672594; cv=none; b=l7tZzUNpR+QtY9uloOt/d/MrsahK1RqfhX2i9mu4Yqysfs5Im9H4qb4ckQ40ExhlyEhqfzKPHEHzb526OjzjZlGVVAGvsXT7Ecfjv96NDw9nT1/xReQBzfaprfAEu/XtgzSnxC+EgcyGahkWN8SY7Q5/ppCdDEWy3oEOlSsubLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672594; c=relaxed/simple;
	bh=0Pn8NIvp3IVqLfVr34QoHwg8mj3PvvrMfokJLRl1f5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0Mu9EVW88u76HY1CvJL5BslbtkKLWj4J7u+UTPii42Gj3zd4OK99FmVLAl3kK8R8zSndY9Tw/E4tRgGeYM34krklVtsFN4O4YNlJZqaEROgKydHGrVFvmvYPr2Kjt0vTZ7kuZNSJYjcUSlvKQ+VOkMyGfpo4wfQr2IXKMi7Zks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.119
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a50af0e-fbf2-7f0000032729-7f000001b32c-1
	for <multiple-recipients>; Fri, 10 Jul 2026 10:36:30 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 10:36:30 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] macvlan: allow source mode devices along with passthru
Date: Fri, 10 Jul 2026 10:36:03 +0200
Message-ID: <20260710083604.396560-2-t.martitz@fritz.com>
In-Reply-To: <20260710083604.396560-1-t.martitz@fritz.com>
References: <20260710083604.396560-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1783672590-70DA87A1-912A5995/0/0
X-purgate-type: clean
X-purgate-size: 8009
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[fritz.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:t.martitz@fritz.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306464-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fritz.com:from_mime,fritz.com:email,fritz.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F5D3738949

This allows for configurations where there are a few
known senders in the system (e.g. multiple SoCs on the same
board) along with unlimited external senders.

The source mode devices represent the known senders while
all external senders terminate on passthru device.

Although you can still receive packets on the lower device
without the need for the passthru vlan device, there
are use cases where you need additional packet processing
in the pipeline that hooks via rx_handler. With this the
rx_handler can be attached to the passthru device while
macvlan itself remains attached to the lower device.

We use this to use the same physical link for inter-SoC
networking and external networking. Some of our chips
have no other viable link for inter-SoC traffic.

Signed-off-by: Thomas Martitz <t.martitz@fritz.com>
---
 drivers/net/macvlan.c | 105 ++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 34 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9a4bc99dbf53b..a2ac913f91906 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -83,6 +83,11 @@ static inline void macvlan_set_passthru(struct macvlan_port *port)
 	port->flags |= MACVLAN_F_PASSTHRU;
 }
 
+static inline void macvlan_clear_passthru(struct macvlan_port *port)
+{
+	port->flags &= ~MACVLAN_F_PASSTHRU;
+}
+
 static inline bool macvlan_addr_change(const struct macvlan_port *port)
 {
 	return port->flags & MACVLAN_F_ADDRCHANGE;
@@ -637,7 +642,7 @@ static int macvlan_open(struct net_device *dev)
 	struct net_device *lowerdev = vlan->lowerdev;
 	int err;
 
-	if (macvlan_passthru(vlan->port)) {
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
 			err = dev_set_promiscuity(lowerdev, 1);
 			if (err < 0)
@@ -712,7 +717,7 @@ static int macvlan_stop(struct net_device *dev)
 	dev_uc_unsync(lowerdev, dev);
 	dev_mc_unsync(lowerdev, dev);
 
-	if (macvlan_passthru(vlan->port)) {
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
 			dev_set_promiscuity(lowerdev, -1);
 		goto hash_del;
@@ -968,6 +973,21 @@ static int macvlan_init(struct net_device *dev)
 	return 0;
 }
 
+static void macvlan_restore_mac(struct macvlan_port *port)
+{
+	/* If the lower device address has been changed by passthru
+	 * macvlan, put it back.
+	 */
+	if (macvlan_passthru(port) &&
+	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
+		struct sockaddr_storage ss;
+
+		ss.ss_family = port->dev->type;
+		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
+		dev_set_mac_address(port->dev, &ss, NULL);
+	}
+}
+
 static void macvlan_uninit(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
@@ -977,8 +997,18 @@ static void macvlan_uninit(struct net_device *dev)
 
 	macvlan_flush_sources(port, vlan);
 	port->count -= 1;
-	if (!port->count)
-		macvlan_port_destroy(port->dev);
+	if (port->count) {
+		/* In case of remaining source interfaces undo
+		 * passthru-specific properties.
+		 */
+		if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
+			macvlan_restore_mac(port);
+			macvlan_clear_passthru(port);
+		}
+		return;
+	}
+
+	macvlan_port_destroy(port->dev);
 }
 
 static void macvlan_dev_get_stats64(struct net_device *dev,
@@ -1052,7 +1082,7 @@ static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (flags & NLM_F_REPLACE)
@@ -1077,7 +1107,7 @@ static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (is_unicast_ether_addr(addr))
@@ -1308,17 +1338,7 @@ static void macvlan_port_destroy(struct net_device *dev)
 		kfree_skb(skb);
 	}
 
-	/* If the lower device address has been changed by passthru
-	 * macvlan, put it back.
-	 */
-	if (macvlan_passthru(port) &&
-	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
-		struct sockaddr_storage ss;
-
-		ss.ss_family = port->dev->type;
-		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
-		dev_set_mac_address(port->dev, &ss, NULL);
-	}
+	macvlan_restore_mac(port);
 
 	kfree(port);
 }
@@ -1506,15 +1526,6 @@ int macvlan_common_newlink(struct net_device *dev,
 	}
 	port = macvlan_port_get_rtnl(lowerdev);
 
-	/* Only 1 macvlan device can be created in passthru mode */
-	if (macvlan_passthru(port)) {
-		/* The macvlan port must be not created this time,
-		 * still goto destroy_macvlan_port for readability.
-		 */
-		err = -EINVAL;
-		goto destroy_macvlan_port;
-	}
-
 	vlan->lowerdev = lowerdev;
 	vlan->dev      = dev;
 	vlan->port     = port;
@@ -1527,10 +1538,30 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_FLAGS])
 		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
 
+	/* Only 1 macvlan device can be created in passthru mode. There may be
+	 * additional source mode devices but nothing else at the moment.
+	 *
+	 * First check if adding a source mode device to an existing passthru vlan.
+	 */
+	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
+		/* The macvlan port must be not created this time,
+		 * still goto destroy_macvlan_port for readability.
+		 */
+		err = -EINVAL;
+		goto destroy_macvlan_port;
+	}
+
+	/* Now check if adding a passthru device to an existing set of source mode
+	 * devices.
+	 */
 	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
-		if (port->count) {
-			err = -EINVAL;
-			goto destroy_macvlan_port;
+		struct macvlan_dev *p;
+
+		list_for_each_entry(p, &port->vlans, list) {
+			if (p->mode != MACVLAN_MODE_SOURCE) {
+				err = -EINVAL;
+				goto destroy_macvlan_port;
+			}
 		}
 		macvlan_set_passthru(port);
 		eth_hw_addr_inherit(dev, lowerdev);
@@ -1564,7 +1595,11 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (err)
 		goto unregister_netdev;
 
-	list_add_tail_rcu(&vlan->list, &port->vlans);
+	/* macvlan_handle_frame expects the (one and only) passthru device first. */
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU)
+		list_add_rcu(&vlan->list, &port->vlans);
+	else
+		list_add_tail_rcu(&vlan->list, &port->vlans);
 	update_port_bc_queue_len(vlan->port);
 	netif_stacked_transfer_operstate(lowerdev, dev);
 	linkwatch_fire_event(dev);
@@ -1627,9 +1662,11 @@ static int macvlan_changelink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_MODE]) {
 		set_mode = true;
 		mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
-		/* Passthrough mode can't be set or cleared dynamically */
-		if ((mode == MACVLAN_MODE_PASSTHRU) !=
-		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
+		/* Passthrough mode can't be set or cleared dynamically,
+		 * regardless of existing source interfaces. Furthermore, source
+		 * interfaces can't switch modes within a passhtrough port.
+		 */
+		if (macvlan_passthru(vlan->port) && mode != vlan->mode)
 			return -EINVAL;
 		if (vlan->mode == MACVLAN_MODE_SOURCE &&
 		    vlan->mode != mode)
@@ -1639,7 +1676,7 @@ static int macvlan_changelink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_FLAGS]) {
 		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
 		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
-		if (macvlan_passthru(vlan->port) && promisc) {
+		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
 			int err;
 
 			if (flags & MACVLAN_FLAG_NOPROMISC)
-- 
2.54.0


