Return-Path: <netdev+bounces-267288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBRnDMV+s2kDXQAAu9opvQ
	(envelope-from <netdev+bounces-267288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F727CF82
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF95A302AC06
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591DC2E62B3;
	Fri, 13 Mar 2026 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi1UIez1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1162F5A29
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371041; cv=none; b=nekwRtafeMtW8qgyMbLk4AV99gUQmPiqyiYrXuk92cdPerJ85GXkCioA95jYYjmIJhOM/p+sIqeFUNrglpfAP1870ZaDnDK4Uu+XrXjTxs/Y31UKiEIo/xeEaweZ64rmn5I8CEcSah3415YR5hw/K8ANdrMojxjs0nQuAh3/0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371041; c=relaxed/simple;
	bh=G4W6YNhY1DK0N/jD/Bs+737si/SON3wre12H8bnq7/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTj1b7b7pgZB6DQHU0kJmffC04TXHq3osNM71mytpBOA8POKTCB7JHwLnN83A441WVO4zo65Pj1/M44iAGqV9bkbcOyAdfs+DnMV0e/Ba9O46xcWOnC/cYusZL4ZaJnERQU20g0nMxpC0SWmQCHV9Hq0PZ63qz+nxEFiUNFYM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi1UIez1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso940345a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371039; x=1773975839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBeXDORWZ/mDBhe03hVB52ezLWB2XO1J0L+2w863tec=;
        b=mi1UIez1OOgw+Am+wYGD8FX1HXjsYFCISq/mPs5FmYgBb5pDDDo5wzBny7MgAnsDu9
         QzFi/fRUFTm9GESi7Pp9JvFeAQTlSA5/wOFh0JorQ918lpy/00JZ3yUltDM3oEDsuRky
         K1E31Gq68sSJAQ2CjL+KAUSPShqkXZprAu/S0FF4+RCMLRNsImRxucGT9R6R6Ws27klI
         brhKvQXleFwQvFvi/RSX7mXgD7bLjLJ/7eYqUc6CC8TbRSXYqLVTyQwTNOqdekAiLxe3
         UPS+R+kXItn4aiJg6o1EQNWjupCxENetMexuDhOXwmY+XfDKXEBY4r4vwUs0dSMI86/Y
         CWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371039; x=1773975839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBeXDORWZ/mDBhe03hVB52ezLWB2XO1J0L+2w863tec=;
        b=Ced1lOuBh0VfFxGf55DtMmCn/hLuAIutVeca+VmDydiKyrRTd2z9me6MNWoxcE9eB4
         Bt4k0AP0hnIT2M2SVw+7ulaD3NYZ/ojf52OWIjlSTezvUByTfGC/LMRXwgq+NbA7Ir7C
         vgwpJNUJtSDlhPmhnfls4ydgPH3RlWqwfB1zyj6EwCNBwUY2Wvn2PTFdP4KYKgtd5sAU
         f1TuMERaUxU3rXjTjVSuQAzbR8QyCZprbQENxVsdRnYSlQ5+iKG3ph2FttZWQNpIC2PL
         tWNDqdmXCXzTUYuGCKin6+kiAhbezTDJybyKM+GxMqiDhzDp/KrkAvsYBzLyzHYbteiQ
         IkjQ==
X-Gm-Message-State: AOJu0YyN5QFuabXn31lZFgjRR+CAyMEk3QzNgdSP2V+6GJ+DiVTmXgV+
	2jraDMIZBCwaEYXxuNk6TOyhlHoLBClNOn8dUKb8Ivgqom8OqI08r+N1
X-Gm-Gg: ATEYQzznqGs5VZfIiJzqLxeFF3WTUrEPY3qgCldHoqK8rf3BYdXRgUbATaKCxMcJp7b
	J3SjDlPb9U1Ju8KLuDr8D2TFZysT44X6BsvjOVrN9KyDEGe4vOlrSDCKxweQb9RuedIir+KKy+P
	jKMgU5aSHpjyCNd552nhsQOEhUb38OkSqCvQgVvw1fJH5X03mhgO9z+7Tdf4ibHwPOJ9tu/Dzc/
	9qI4RgFzS/bYlW7A+v4EpsAeFYh9iY5R39+xVzkzdPHl6SPcc9v+EudMLtcFUDOrijUpWDHvLYJ
	/oBfw1RbES07A0dFtPKpEBZcJ8j39b5+Is7BkA7iffmgtNCYYBihfXY71dnp9eTWFdF2KWJyj/C
	Y7vBuBk29qwXBAqBBUag/854kwISof8qgS4lMIBf8qPvKblVwoLxHtURZLFQb4gVeubG4TTTYFB
	sITSPFqohYHGsO+4mH6cox4m4ByT73iPQUUcpsjVCTpIISh6XI9lWWAgORYKDaWLsWaizvluS7r
	Uqw030FUUKz2aLF7/aYi1dRkhONX7R3IjnIxfuRcKtT7MwNzhv1Vztsah7psvk=
X-Received: by 2002:a17:90b:2783:b0:359:3088:6ab1 with SMTP id 98e67ed59e1d1-35a21e1ca4fmr1607854a91.1.1773371039000;
        Thu, 12 Mar 2026 20:03:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:03:58 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:09 +0800
Subject: [PATCH net-next v2 1/4] net: use ndo_set_features to set offload
 features for bonding/bridge/team
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-1-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
In-Reply-To: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D8F727CF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert bonding, bridge, and team drivers to use ndo_set_features callback
instead of manually calling netdev_compute_master_upper_features() during
port add/remove operations.

This change centralizes the feature computation flow:

Before:
- netdev_master_upper_dev_link()
- netdev_compute_master_upper_features()  <- called manually
  - compute offload features
  - netdev_change_features()
    - __netdev_update_features()
      - update other features

After:
- netdev_master_upper_dev_link()
  - __netdev_upper_dev_link()
    - netdev_change_features()
      - __netdev_update_features()
        - ndo_set_features()
          - netdev_compute_master_upper_features()

This ensures offload features are computed automatically when
upper/lower device links change, removing the need for manual
feature computation calls in the driver code.

The netdev_change_features() call in team_uninit() is also removed
since it calls team_port_del() for each port, which now triggers
feature updates automatically.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 11 ++++++++---
 drivers/net/team/team_core.c    | 12 ++++++++----
 net/bridge/br_device.c          |  7 +++++++
 net/bridge/br_if.c              |  4 ----
 net/core/dev.c                  |  8 ++++++--
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 90b71bd53040..2c84d3ce3b04 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1509,6 +1509,12 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int bond_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 			      unsigned short type, const void *daddr,
 			      const void *saddr, unsigned int len)
@@ -2273,7 +2279,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2528,7 +2533,6 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4026,7 +4030,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			netdev_compute_master_upper_features(bond->dev, true);
+			netdev_change_features(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -5953,6 +5957,7 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_add_slave		= bond_enslave,
 	.ndo_del_slave		= bond_release,
 	.ndo_fix_features	= bond_fix_features,
+	.ndo_set_features	= bond_set_features,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_xmit_slave	= bond_xmit_get_slave,
 	.ndo_sk_get_lower_dev	= bond_sk_get_lower_dev,
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b7282f5c9632..4906ea3717b1 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1247,7 +1247,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	netdev_compute_master_upper_features(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1337,7 +1336,6 @@ static int team_port_del(struct team *team, struct net_device *port_dev, bool un
 	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	netdev_compute_master_upper_features(team->dev, true);
 
 	return 0;
 }
@@ -1645,7 +1643,6 @@ static void team_uninit(struct net_device *dev)
 	team_mcast_rejoin_fini(team);
 	team_notify_peers_fini(team);
 	team_queue_override_fini(team);
-	netdev_change_features(dev);
 }
 
 static void team_destructor(struct net_device *dev)
@@ -1972,6 +1969,12 @@ static netdev_features_t team_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int team_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static int team_change_carrier(struct net_device *dev, bool new_carrier)
 {
 	struct team *team = netdev_priv(dev);
@@ -2007,6 +2010,7 @@ static const struct net_device_ops team_netdev_ops = {
 	.ndo_add_slave		= team_add_slave,
 	.ndo_del_slave		= team_del_slave,
 	.ndo_fix_features	= team_fix_features,
+	.ndo_set_features	= team_set_features,
 	.ndo_change_carrier     = team_change_carrier,
 	.ndo_features_check	= passthru_features_check,
 };
@@ -2944,7 +2948,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			netdev_compute_master_upper_features(port->team->dev, true);
+			netdev_change_features(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd35..f82082050e36 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -289,6 +289,12 @@ static netdev_features_t br_fix_features(struct net_device *dev,
 	return br_features_recompute(br, features);
 }
 
+static int br_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, false);
+	return 0;
+}
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void br_poll_controller(struct net_device *br_dev)
 {
@@ -456,6 +462,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_add_slave		 = br_add_slave,
 	.ndo_del_slave		 = br_del_slave,
 	.ndo_fix_features        = br_fix_features,
+	.ndo_set_features        = br_set_features,
 	.ndo_fdb_add		 = br_fdb_add,
 	.ndo_fdb_del		 = br_fdb_delete,
 	.ndo_fdb_del_bulk	 = br_fdb_delete_bulk,
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d39571e13744..030248bc94c5 100644
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
index f48dc299e4b2..16b3fc620807 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8920,6 +8920,9 @@ static int __netdev_upper_dev_link(struct net_device *dev,
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
 
+	/* re-compute all features after adding link */
+	netdev_change_features(upper_dev);
+
 	return 0;
 
 rollback:
@@ -9012,6 +9015,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
 	__netdev_update_lower_level(upper_dev, priv);
 	__netdev_walk_all_upper_dev(upper_dev, __netdev_update_lower_level,
 				    priv);
+
+	/* re-compute all features after removing link */
+	netdev_change_features(upper_dev);
 }
 
 /**
@@ -12874,8 +12880,6 @@ void netdev_compute_master_upper_features(struct net_device *dev, bool update_he
 
 	netif_set_tso_max_segs(dev, tso_max_segs);
 	netif_set_tso_max_size(dev, tso_max_size);
-
-	netdev_change_features(dev);
 }
 EXPORT_SYMBOL(netdev_compute_master_upper_features);
 

-- 
Git-155)


