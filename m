Return-Path: <netdev+bounces-189163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85CAB0E48
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612CA7B2BD9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F192750EA;
	Fri,  9 May 2025 09:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E12750E3
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781809; cv=none; b=B7pQggB8l8AZfILrO5qgu8f89MAAH/Bd6mh8BnTdc/HW55k2WnuJUgahX2ryqs9ePUKdj1DSpDNZCTWvzgAaq42F3vQVjn31ZWuL7/sIvQxOUUOfO+f0b2EcT19Ce05UxQzkc7QCA93qJqc5TfhxzTOH5M4U1Pt2Ji3vzJ00yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781809; c=relaxed/simple;
	bh=Ac6HBR5LL2UHbahbZCM3G5B7kxdPfCvGRl779v1BaRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZyHNbAkdsyhjZ1o0azwkt4RCCR945QJodiDyNlEfIIZEkvpWlgqaxkue5rsFjrn8jiLT9u0/kFV+9dvCUobh7OUO0SvkKTjghOV8/NsabrXE9as4rvFq0DaHjhMEr1D6lpwQbum4lzby3hBtC8HBp2EULJP4u7RaqMctDoVmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C59736C7d829705D90aB67a755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5A8AAFA132;
	Fri,  9 May 2025 11:02:49 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: fix duplicate MAC address check
Date: Fri,  9 May 2025 11:02:40 +0200
Message-Id: <20250509090240.107796-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509090240.107796-1-sw@simonwunderlich.de>
References: <20250509090240.107796-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Schiffer <mschiffer@universe-factory.net>

batadv_check_known_mac_addr() is both too lenient and too strict:

- It is called from batadv_hardif_add_interface(), which means that it
  checked interfaces that are not used for batman-adv at all. Move it
  to batadv_hardif_enable_interface(). Also, restrict it to hardifs of
  the same mesh interface; different mesh interfaces should not interact
  at all. The batadv_check_known_mac_addr() argument is changed from
  `struct net_device` to `struct batadv_hard_iface` to achieve this.
- The check only cares about hardifs in BATADV_IF_ACTIVE and
  BATADV_IF_TO_BE_ACTIVATED states, but interfaces in BATADV_IF_INACTIVE
  state should be checked as well, or the following steps will not
  result in a warning then they should:

  - Add two interfaces in down state with different MAC addresses to
    a mesh as hardifs
  - Change the MAC addresses so they conflict
  - Set interfaces to up state

  Now there will be two active hardifs with the same MAC address, but no
  warning. Fix by only ignoring hardifs in BATADV_IF_NOT_IN_USE state.

The RCU lock can be dropped, as we're holding RTNL anyways when the
function is called.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..d099434d3dfa 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -506,28 +506,32 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 	return false;
 }
 
-static void batadv_check_known_mac_addr(const struct net_device *net_dev)
+static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
 {
-	const struct batadv_hard_iface *hard_iface;
+	const struct net_device *mesh_iface = hard_iface->mesh_iface;
+	const struct batadv_hard_iface *tmp_hard_iface;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->if_status != BATADV_IF_ACTIVE &&
-		    hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED)
+	if (!mesh_iface)
+		return;
+
+	list_for_each_entry(tmp_hard_iface, &batadv_hardif_list, list) {
+		if (tmp_hard_iface == hard_iface)
+			continue;
+
+		if (tmp_hard_iface->mesh_iface != mesh_iface)
 			continue;
 
-		if (hard_iface->net_dev == net_dev)
+		if (tmp_hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			continue;
 
-		if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
-					net_dev->dev_addr))
+		if (!batadv_compare_eth(tmp_hard_iface->net_dev->dev_addr,
+					hard_iface->net_dev->dev_addr))
 			continue;
 
 		pr_warn("The newly added mac address (%pM) already exists on: %s\n",
-			net_dev->dev_addr, hard_iface->net_dev->name);
+			hard_iface->net_dev->dev_addr, tmp_hard_iface->net_dev->name);
 		pr_warn("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
-	rcu_read_unlock();
 }
 
 /**
@@ -764,6 +768,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			    hard_iface->net_dev->name, hardif_mtu,
 			    required_mtu);
 
+	batadv_check_known_mac_addr(hard_iface);
+
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
 	else
@@ -902,7 +908,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	batadv_v_hardif_init(hard_iface);
 
-	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 	batadv_hardif_generation++;
@@ -989,7 +994,7 @@ static int batadv_hard_if_event(struct notifier_block *this,
 		if (hard_iface->if_status == BATADV_IF_NOT_IN_USE)
 			goto hardif_put;
 
-		batadv_check_known_mac_addr(hard_iface->net_dev);
+		batadv_check_known_mac_addr(hard_iface);
 
 		bat_priv = netdev_priv(hard_iface->mesh_iface);
 		bat_priv->algo_ops->iface.update_mac(hard_iface);
-- 
2.39.5


