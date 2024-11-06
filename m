Return-Path: <netdev+bounces-142222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950119BDE3B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BA3282C04
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 05:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB04191F7F;
	Wed,  6 Nov 2024 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFAzr+0r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E12F50;
	Wed,  6 Nov 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730870097; cv=none; b=UJke75ggIR4+n6P5GHrVDeT/rb39bZqrtEk/24bNQEn7dLnhAwVy4pVUiM57KobXedhXlDRdt6NKHsUhQ6L04QkWK+2K2ApOv3IxT1Aq3clTkQ9uC9j37GSKYFnQFZNQgOz0+Gbh4tUE6oNidA9jxELkWFodxDgt6CbJv9HGPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730870097; c=relaxed/simple;
	bh=y5wUPlVNE213fvh22djEGHhvUb8c856ls6qYyOCSnGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJM/N29pGOu/3F5cSmil82awayRN1sriMdvc23sVZ3ikh3Z9e0w+j+Wy7Tgos+yt8OvHvtFct3gwqd9m/fKa2yOlldrO91jSa85v4yKzPTBDLY5NEkMKpIhB+6LpxAaUhgg7rtIi4wf/EQDRRVf/Wi0AU32I+j8F06ad5qPU5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFAzr+0r; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-210e5369b7dso63183085ad.3;
        Tue, 05 Nov 2024 21:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730870095; x=1731474895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TNIxHPcriV+wLI0nui1n7E5bjTkA+MQ0HbkGtr2T4w=;
        b=PFAzr+0rrHy0Zm913bogcMh7Xn6iInfYG2juVs3ylu8g+sqZdzklEe0dOIVCuLnvKE
         ZjjJDGvK9/dO7GtUxtwUVTJUIV/TqFz6poIMALAGR9bNIT84qWoFJRID71VbgGzdzPQa
         3uutP7q+Gf02rD8hKQGtA+Q3c0cFR3JvCb3b6ZWvcIhLmqKzbT9M1VtenlESdWOy3xmj
         iiZuuvMfmPWB38EehPWJgFrXUaIaqt+dZOxhgsJYJVuwr/bjdow8mCPnxOeYG53qgbgx
         b/ZIardWeTpVQQeA9Ej2i7AtDxS4N0pXkH0S7jHmu47208mltQGS9AVYUBeB6MVSBChB
         H72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730870095; x=1731474895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TNIxHPcriV+wLI0nui1n7E5bjTkA+MQ0HbkGtr2T4w=;
        b=o5t8ChJ5tKVsLcxJS9w9armBABKbI0opMwE34WW7uwNlXwJrd6hsP1okrrLuz8JtNs
         uAxiG+UnfHIL3+NZNzO/y8fEOBEC7FW8q5rIAEvBm8bYjb+Z4qORj7Wsnc6KTQZP9CKB
         piYivQ2NO12Ess+MXJBsPKRpzAP53CzWeJz6tzZAh8X+GVigvjx7P9sgwSUZEF99/x4C
         M400q9pg8lNKYah3sUL9NPB1YRhoKFJJpLF4Znjb9R9F48uBhHYcFUtYsl3FWqTwmj2W
         oThGzZJIwf/GKz/72v4EtZnUT+ekTr7aEvxB0fMI43gIiTqPh5X2WcP1r9Fl+13xNFua
         nLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ev2X3iZa0g0eClx6QLYr11seyydGcfGlHF8j7EMlGkTRQTOHLz201Ri870BCpjm2mksiQThcQXwJ4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PIKh2kyfkpBY5u3zfUgA0DGjj6lxTdDkLohoDvbhsQLiESm6
	NNuxL+A89p9atFhNMXZxbGIn4nY1t6i83fBRcsFtXz307OJKbiFCz4wBd88WzPQ=
X-Google-Smtp-Source: AGHT+IGGZJxYHmpiTkeAm3iHMFWrcWyXSHNJFK8MWWxs4kt6jkP5wu2obC8UNhfPOWFZcqPwKVaqyQ==
X-Received: by 2002:a17:902:e74d:b0:20c:b052:7e14 with SMTP id d9443c01a7336-2111b0067admr249845125ad.50.1730870095176;
        Tue, 05 Nov 2024 21:14:55 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3e4sm87988945ad.3.2024.11.05.21.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 21:14:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/2] bonding: add ns target multicast address to slave device
Date: Wed,  6 Nov 2024 05:14:41 +0000
Message-ID: <20241106051442.75177-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106051442.75177-1-liuhangbin@gmail.com>
References: <20241106051442.75177-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
tried to resolve the issue where backup slaves couldn't be brought up when
receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
worked for drivers that receive all multicast messages, such as the veth
interface.

For standard drivers, the NS multicast message is silently dropped because
the slave device is not a member of the NS target multicast group.

To address this, we need to make the slave device join the NS target
multicast group, ensuring it can receive these IPv6 NS messages to validate
the slave’s status properly.

There are three policies before joining the multicast group:
1. All settings must be under active-backup mode (alb and tlb do not support
   arp_validate), with backup slaves and slaves supporting multicast.
2. We can add or remove multicast groups when arp_validate changes.
3. Other operations, such as enslaving, releasing, or setting NS targets,
   need to be guarded by arp_validate.

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c    | 18 ++++++-
 drivers/net/bonding/bond_options.c | 85 +++++++++++++++++++++++++++++-
 include/net/bond_options.h         |  1 +
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1bffd8e9a95..d7c1016619f9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1008,6 +1008,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 
 		if (bond->dev->flags & IFF_UP)
 			bond_hw_addr_flush(bond->dev, old_active->dev);
+
+		/* add target NS maddrs for backup slave */
+		slave_set_ns_maddrs(bond, old_active, true);
 	}
 
 	if (new_active) {
@@ -1024,6 +1027,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 			dev_mc_sync(new_active->dev, bond->dev);
 			netif_addr_unlock_bh(bond->dev);
 		}
+
+		/* clear target NS maddrs for active slave */
+		slave_set_ns_maddrs(bond, new_active, false);
 	}
 }
 
@@ -2341,6 +2347,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
 
+	/* set target NS maddrs for new slave, need to be called before
+	 * bond_select_active_slave(), which will remove the maddr if
+	 * the slave is selected as active slave
+	 */
+	slave_set_ns_maddrs(bond, new_slave, true);
+
 	if (bond_uses_primary(bond)) {
 		block_netpoll_tx();
 		bond_select_active_slave(bond);
@@ -2350,7 +2362,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	if (bond_mode_can_use_xmit_hash(bond))
 		bond_update_slave_arr(bond, NULL);
 
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2548,6 +2559,11 @@ static int __bond_release_one(struct net_device *bond_dev,
 	if (oldcurrent == slave)
 		bond_change_active_slave(bond, NULL);
 
+	/* clear target NS maddrs, must after bond_change_active_slave()
+	 * as we need to clear the maddrs on backup slave
+	 */
+	slave_set_ns_maddrs(bond, slave, false);
+
 	if (bond_is_lb(bond)) {
 		/* Must be called only after the slave has been
 		 * detached from the list and the curr_active_slave
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 95d59a18c022..60368cef2704 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 
 #include <net/bonding.h>
+#include <net/ndisc.h>
 
 static int bond_option_active_slave_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
@@ -1234,6 +1235,64 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+static bool slave_can_set_ns_maddr(struct bonding *bond, struct slave *slave)
+{
+	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+	       !bond_is_active_slave(slave) &&
+	       slave->dev->flags & IFF_MULTICAST;
+}
+
+static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
+{
+	struct in6_addr *targets = bond->params.ns_targets;
+	char slot_maddr[MAX_ADDR_LEN];
+	int i;
+
+	if (!slave_can_set_ns_maddr(bond, slave))
+		return;
+
+	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
+		if (ipv6_addr_any(&targets[i]))
+			break;
+
+		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
+			if (add)
+				dev_mc_add(slave->dev, slot_maddr);
+			else
+				dev_mc_del(slave->dev, slot_maddr);
+		}
+	}
+}
+
+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
+{
+	if (!bond->params.arp_validate)
+		return;
+
+	_slave_set_ns_maddrs(bond, slave, add);
+}
+
+static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
+			       struct in6_addr *target, struct in6_addr *slot)
+{
+	char target_maddr[MAX_ADDR_LEN], slot_maddr[MAX_ADDR_LEN];
+
+	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
+		return;
+
+	/* remove the previous maddr on salve */
+	if (!ipv6_addr_any(slot) &&
+	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0)) {
+		dev_mc_del(slave->dev, slot_maddr);
+	}
+
+	/* add new maddr on slave if target is set */
+	if (!ipv6_addr_any(target) &&
+	    !ndisc_mc_map(target, target_maddr, slave->dev, 0)) {
+		dev_mc_add(slave->dev, target_maddr);
+	}
+}
+
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 					    struct in6_addr *target,
 					    unsigned long last_rx)
@@ -1243,8 +1302,10 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 	struct slave *slave;
 
 	if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
-		bond_for_each_slave(bond, slave, iter)
+		bond_for_each_slave(bond, slave, iter) {
 			slave->target_last_arp_rx[slot] = last_rx;
+			slave_set_ns_maddr(bond, slave, target, &targets[slot]);
+		}
 		targets[slot] = *target;
 	}
 }
@@ -1296,15 +1357,37 @@ static int bond_option_ns_ip6_targets_set(struct bonding *bond,
 {
 	return -EPERM;
 }
+
+static void _slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
+{
+}
+
+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
+{
+}
 #endif
 
 static int bond_option_arp_validate_set(struct bonding *bond,
 					const struct bond_opt_value *newval)
 {
+	bool changed = (bond->params.arp_validate == 0 && newval->value != 0) ||
+		       (bond->params.arp_validate != 0 && newval->value == 0);
+	struct list_head *iter;
+	struct slave *slave;
+
 	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.arp_validate = newval->value;
 
+	if (changed) {
+		bond_for_each_slave(bond, slave, iter) {
+			if (bond->params.arp_validate)
+				_slave_set_ns_maddrs(bond, slave, true);
+			else
+				_slave_set_ns_maddrs(bond, slave, false);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 473a0147769e..59a91d12cd57 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -161,5 +161,6 @@ void bond_option_arp_ip_targets_clear(struct bonding *bond);
 #if IS_ENABLED(CONFIG_IPV6)
 void bond_option_ns_ip6_targets_clear(struct bonding *bond);
 #endif
+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add);
 
 #endif /* _NET_BOND_OPTIONS_H */
-- 
2.46.0


