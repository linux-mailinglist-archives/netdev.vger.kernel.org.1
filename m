Return-Path: <netdev+bounces-261308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCFLOQgyoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C11A5412
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F9333099C47
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091C377541;
	Thu, 26 Feb 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiR3Z1F0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E2364031
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106208; cv=none; b=eiWnEPOoPDlD3YioxlnFHhyYWr+aQfUA/8zz5FlZwrvzbiw8J4jBufD5MSBUEtUR21/5ijRx1zUi3HJLZOcUMX1fmJk2Q9SS397EHsJ/ZSrX/w6T0PzoWF0XLiwqXAaly1ZQNnx29R4pzY4dxQF0WcL2AZUTuqpisnI7xTiTz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106208; c=relaxed/simple;
	bh=QE7+shqhYrIkkr0DVQn90AztuymZ6yT+ozQWHEu81W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf3zST5PTC5fDs/rumTDcVTBZIcvNxJgsDMXNdsI3U5uyjhV1FPlLWkRBuKtU3C8xATK1bKSySxmHRNBv1Xu9nHsJCEixA4jch9Bnuy5W/G9onNroSxS6xWDTKHIhbngGAEUIMbzNCczC0tyxzztyJ/uUzysnuYFp3IiMPCgumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiR3Z1F0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7d98c1879so4889525ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106206; x=1772711006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8tCHRpr4wzppgYjorSC40fFUhqaMIZWAyWgimJgq3o=;
        b=WiR3Z1F0IV9Y2mvK+eYp/fD73mu9BjjmLY8R039NeQOqwvKuR/5qsenve69DxXMwDw
         cro0QsnhBXcELBM1MAPsehsoP+nWHnDBhvryavmidxy158Rj2/sb5aF2yROXhqSO0ML8
         ih03o1gJK9a1WobvNR8Red3mbLDqE2VT+XtF23exNyzU01VDBCaTJJ7GRaXlpK3mqm5B
         /FDqTnQUofodlCt5v/Qdj8oL+p8krtA3z7+0o7pVkTMBPZhVYaBtF7eEMcH2PwHZe/3/
         DvNmjpleD5XHDjXsqgoAmm7o2EfpItMeWcsO/pIavJT+k/ZOyz0w53s6yIgvVAQPVp+7
         diaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106206; x=1772711006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8tCHRpr4wzppgYjorSC40fFUhqaMIZWAyWgimJgq3o=;
        b=ndaYHyIIGOlgUUS9pihT3rBNwONI2rOjCpg4F9yw65pOTBz2W/aO8wbbft+jpjeQat
         HCx1dIXcZ/rap+3K76knWDXUZjtE/otBh0OdJaq/9ah0UAEclT2RONDJUTxE7xog+XLq
         fxusU+RvCjkfR2n//wQ7QwQja861Mfc5KH9jT+5ibYNrnIArw/oyd/2xIJw7XuB/NPCf
         PqvKHNiXiWqWOboUzfn+gcBXn+V3QYv4YysGkt21umOiclCkDU8rvrUoTgllNqzq8Kog
         9wwBeuK4NWIDFUvMF9IcRoCcbmbqbePaewq4b9mzYeRE2p7LNcfaAdKqguveqNdubBEu
         5brQ==
X-Gm-Message-State: AOJu0YyeuvA24nRHRZotsQdnVHagjRKhQE9eGwwrQorXGw4qIVXw1SgT
	acXsmrW7NcpBOGNbQpgTxoRkYjrogUQ0atUrbUgignJeRbN/oMHLOW2qIH0w85h4By4=
X-Gm-Gg: ATEYQzxF07KHNRM7/vH33BxeoEHSArpjPxFMegaFrueQM3WHcsWLTCWv6agIlE6em0r
	VyrXxoOz+Mg0a354oNVbSVWbagjL5Zpyrv33LbeU6v+P636Pr8+3lKc8ez2quoIyUd6ThEf571f
	kbAUzOd4VHXLiQ6wWT/F6/Zzbhln5pdSuCr37hATfDIfdld0t87HghbNTo6ms+xRwTGk9cVE3cK
	PBwJG/kCNwp9UrGdzQ/BdOPQ1Ym4JkdXbrrbnEcHAG5M8pD/O7KWQV/OrijS4K/0Bn+UPPgkUsT
	WcZssj7cU4h2pc4lrVrk7S7cWoc3O3FXx/KaoLYWcbnpEYJyu+N99bAocvSmf8rbWttjR9liMEe
	47T01bjH21mMpC95zosekHDqDkt994pX95qWmBJJpdJMna3shR/3Z1iggi3Jh5TlGfOcPFwYrgs
	Wgf2gCyEHW/wBDpctEMQDgxG5mEKM=
X-Received: by 2002:a17:902:ce84:b0:2ad:ba04:40cd with SMTP id d9443c01a7336-2adba0442abmr77452645ad.22.1772106206343;
        Thu, 26 Feb 2026 03:43:26 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:26 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 2/3] net: use ndo_update_offloads for bonding/bridge/team
Date: Thu, 26 Feb 2026 11:42:07 +0000
Message-ID: <20260226114208.27774-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226114208.27774-1-liuhangbin@gmail.com>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,resnulli.us,blackwall.org,nvidia.com,fomichev.me,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261308-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE4C11A5412
X-Rspamd-Action: no action

Convert bonding, bridge, and team drivers to use the new
ndo_update_offloads callback instead of manually calling
netdev_compute_master_upper_features() during port add/remove operations.

This change centralizes the feature computation flow:

Before:
- netdev_compute_master_upper_features()
  - compute offload features
  - netdev_change_features()
    - __netdev_update_features()
      - update other features

After:
- netdev_master_upper_dev_link()
  - __netdev_upper_dev_link()
    - netdev_change_features()
      - __netdev_update_features()
        - ndo_update_offloads()
          - netdev_compute_master_upper_features()
        - update other features

This ensures offload features are computed automatically when
upper/lower device links change, removing the need for manual
feature computation calls in the driver code.

The netdev_change_features() call in team_uninit() is also removed
since it calls team_port_del() for each port, which now triggers
feature updates automatically.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 10 +++++++---
 drivers/net/team/team_core.c    | 11 +++++++----
 net/bridge/br_device.c          |  6 ++++++
 net/bridge/br_if.c              |  4 ----
 net/core/dev.c                  |  8 ++++++--
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 55a960da42b5..dc524f595e28 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1504,6 +1504,11 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static void bond_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2224,7 +2229,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2479,7 +2483,6 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -3971,7 +3974,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			netdev_compute_master_upper_features(bond->dev, true);
+			netdev_change_features(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -5895,6 +5898,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_add_slave		= bond_enslave,
 	.ndo_del_slave		= bond_release,
 	.ndo_fix_features	= bond_fix_features,
+	.ndo_update_offloads	= bond_update_offloads,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
 	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c08a5c1bd6e4..fa62965b61de 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1249,7 +1249,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	netdev_compute_master_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1333,7 +1332,6 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	netdev_compute_master_upper_features(team->dev, true);
 
 	return 0;
 }
@@ -1641,7 +1639,6 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	netdev_change_features(dev);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1959,6 +1956,11 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	return features;
 }
 
+static void team_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static int team_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	struct team *team = netdev_priv(dev);
@@ -1994,6 +1996,7 @@ static const struct net_device_ops team_netdev_ops = {
 	.ndo_add_slave		= team_add_slave,
 	.ndo_del_slave		= team_del_slave,
 	.ndo_fix_features	= team_fix_features,
+	.ndo_update_offloads	= team_update_offloads,
 	.ndo_change_carrier     = team_change_carrier,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -2931,7 +2934,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			netdev_compute_master_upper_features(port->team->dev, true);
+			netdev_change_features(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..3f2e8f5249fb 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -289,6 +289,11 @@ static netdev_features_t br_fix_features(struct net_device *dev,
 	return br_features_recompute(br, features);
 }
 
+static void br_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, false);
+}
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void br_poll_controller(struct net_device *br_dev)
 {
@@ -456,6 +461,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_add_slave		 = br_add_slave,
 	.ndo_del_slave		 = br_del_slave,
 	.ndo_fix_features        = br_fix_features,
+	.ndo_update_offloads	 = br_update_offloads,
 	.ndo_fdb_add		 = br_fdb_add,
 	.ndo_fdb_del		 = br_fdb_delete,
 	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 4c67a32745f6..7806436340ef 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -680,8 +680,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 
 	br_mtu_auto_adjust(br);
 
-	netdev_compute_master_upper_features(br->dev, false);
-
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
 	return 0;
@@ -734,8 +732,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_compute_master_upper_features(br->dev, false);
-
 	return 0;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index d05837c0713a..7043ee022980 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8893,6 +8893,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
 
+	/* re-compute all features after adding link */
+	netdev_change_features(upper_dev);
+
 	return 0;
 
 rollback:
@@ -8985,6 +8988,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
 	__netdev_update_lower_level(upper_dev, priv);
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
+
+	/* re-compute all features after removing link */
+	netdev_change_features(upper_dev);
 }
 
 /**
@@ -12851,8 +12857,6 @@ void netdev_compute_master_upper_features(struct net_device *dev, bool update_he
 
 	netif_set_tso_max_segs(dev, tso_max_segs);
 	netif_set_tso_max_size(dev, tso_max_size);
-
-	netdev_change_features(dev);
 }
 EXPORT_SYMBOL(netdev_compute_master_upper_features);
 
-- 
2.50.1


