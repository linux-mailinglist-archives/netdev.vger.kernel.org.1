Return-Path: <netdev+bounces-143705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025AE9C3BC1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D76282B79
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FA1865E0;
	Mon, 11 Nov 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DieTtq6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE85184542;
	Mon, 11 Nov 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320225; cv=none; b=c3fUT7O/3QEQ3DhMTo8vL/ZJuQXUrTMuoVOj05niLF4DzD+x6BGlgc1Uigqi/6oBRwclUh02igirsmo+lLQivGI0YLu6oK4BTD/+8RJn2hNpPg4lbJOIpLOr7G74YQLSk4P0nLtnk3+r0ZyYms+kH9OsBvp9J6mrx8sPmA+4iwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320225; c=relaxed/simple;
	bh=8KI5MpelEUR6rJ58b7qgoqQQPqOLeke18BjqzFRGeTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bf5W5ABJx0VtnI5PoYL7T1FwRqTjVMq+hQtUJyxZDqE7XFtytJqI8Mc0li9+S+Bqy+LYXqSFrvzsp1xT5DP4AZc1EFeyGPsg3V87b1BMFu4/lIdRe5uKjjvmQsc37cw/ohVPjKcAcQDFPBwErGysxqvs6DiIrswmDaO19zyoY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DieTtq6U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-210e5369b7dso43970895ad.3;
        Mon, 11 Nov 2024 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731320223; x=1731925023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPo8tUO71JtoMqwK9/G90nMBMXd8Aq5obbqVaPTicSI=;
        b=DieTtq6UTq7GjKraUJtxAAEvXKdun5E9fVrgsNaIlhAqbgvXA8y3DtaV8YpFGPpCp2
         37oCRppmjMNze2FpjdaQEqgkkwaIJbYdwQLbfMiUqWUDHubH0oMQekkrUFI/JvHyKaw1
         zWa81Z79Js5NQUDcgCbsaGV8ihf5F9qHONwAAiKmCEUpnD/5Yc6/1rbm9GY++Ea82G8O
         OZOiW8j1xnM0IDU/LqefNLfk2YISfArlLx8I2sLKdvfHQ9bhjo106Hpxs8tFcpmfSIUL
         BAImkmdztrURU12tzMtOGZFA9q/rw6YbhVkLr+Cg1cGQum3n79AHW+o5SUrnFrF/VBdc
         5B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731320223; x=1731925023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPo8tUO71JtoMqwK9/G90nMBMXd8Aq5obbqVaPTicSI=;
        b=TgZsV29UHNm3QRE5a8eBsdJ+s5MP/bdauF3dBKq4yAfXSWSsMoqJZNPHe+3F1H5kQ3
         XFdaoD6d0sW3qZNg4viE3g/XIDo2o8ZhiFLk/Crm8dplpi+YG3gZGzvul0spuMmAHeyc
         nh2NlSIUvXPNPSuAAMPMLoamysDiJsicCKaXm56vJbpcB2t2ttRyM3wd50KcI1/gevyq
         G5IaP0sqiHnCSWB5ldbdhDKrwjFbT0Cu9YNbUs1jlVmqzgQeFV8wWrxD9oMg7UznglAG
         ktxtnrF+Uu9EEpV+VHvm1RDM/NvxQCCBIbFUHJbshyGwhT6v0r/3R20+eDHC731GbXvV
         DmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjeSjB8VTbdn2NZgX5vOJPP3zJ05LnSpLLyvqAaA8C+nNgLO2vpW+7c86STEbnZlK2Lj2/9/9fLIYvnfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0x4OH88i1qy+c3/BvUGmHZpSXc0OV3n6ncmUSi8lmqXXlZr4
	jFDVNV9ijb/z9hsdVytiVBFDXLn70XwnIeEN1dMkh6ZrlUQjQldXqCP4l1Zi1+TL1g==
X-Google-Smtp-Source: AGHT+IHfR8jqJL38mF9wZcWMDLTiDcD+R7mJXHNLt+lxzoKSGNa1BujiTkhJIsBTL3g2vpKXY6VYiQ==
X-Received: by 2002:a17:90b:1c08:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e9b16ea69bmr16862424a91.4.1731320223160;
        Mon, 11 Nov 2024 02:17:03 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b26b9bd8sm6309831a91.5.2024.11.11.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:17:02 -0800 (PST)
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
Subject: [PATCHv4 net 1/2] bonding: add ns target multicast address to slave device
Date: Mon, 11 Nov 2024 10:16:49 +0000
Message-ID: <20241111101650.27685-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241111101650.27685-1-liuhangbin@gmail.com>
References: <20241111101650.27685-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_main.c    | 16 +++++-
 drivers/net/bonding/bond_options.c | 82 +++++++++++++++++++++++++++++-
 include/net/bond_options.h         |  2 +
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1bffd8e9a95..15e0f14d0d49 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1008,6 +1008,8 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 
 		if (bond->dev->flags & IFF_UP)
 			bond_hw_addr_flush(bond->dev, old_active->dev);
+
+		bond_slave_ns_maddrs_add(bond, old_active);
 	}
 
 	if (new_active) {
@@ -1024,6 +1026,8 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 			dev_mc_sync(new_active->dev, bond->dev);
 			netif_addr_unlock_bh(bond->dev);
 		}
+
+		bond_slave_ns_maddrs_del(bond, new_active);
 	}
 }
 
@@ -2341,6 +2345,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
 
+	/* Needs to be called before bond_select_active_slave(), which will
+	 * remove the maddrs if the slave is selected as active slave.
+	 */
+	bond_slave_ns_maddrs_add(bond, new_slave);
+
 	if (bond_uses_primary(bond)) {
 		block_netpoll_tx();
 		bond_select_active_slave(bond);
@@ -2350,7 +2359,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	if (bond_mode_can_use_xmit_hash(bond))
 		bond_update_slave_arr(bond, NULL);
 
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2548,6 +2556,12 @@ static int __bond_release_one(struct net_device *bond_dev,
 	if (oldcurrent == slave)
 		bond_change_active_slave(bond, NULL);
 
+	/* Must be called after bond_change_active_slave () as the slave
+	 * might change from an active slave to a backup slave. Then it is
+	 * necessary to clear the maddrs on the backup slave.
+	 */
+	bond_slave_ns_maddrs_del(bond, slave);
+
 	if (bond_is_lb(bond)) {
 		/* Must be called only after the slave has been
 		 * detached from the list and the curr_active_slave
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 95d59a18c022..327b6ecdc77e 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 
 #include <net/bonding.h>
+#include <net/ndisc.h>
 
 static int bond_option_active_slave_set(struct bonding *bond,
 					const struct bond_opt_value *newval);
@@ -1234,6 +1235,68 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *slave)
+{
+	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+	       !bond_is_active_slave(slave) &&
+	       slave->dev->flags & IFF_MULTICAST;
+}
+
+static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
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
+void bond_slave_ns_maddrs_add(struct bonding *bond, struct slave *slave)
+{
+	if (!bond->params.arp_validate)
+		return;
+	slave_set_ns_maddrs(bond, slave, true);
+}
+
+void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave)
+{
+	if (!bond->params.arp_validate)
+		return;
+	slave_set_ns_maddrs(bond, slave, false);
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
+	/* remove the previous maddr from slave */
+	if (!ipv6_addr_any(slot) &&
+	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0))
+		dev_mc_del(slave->dev, slot_maddr);
+
+	/* add new maddr on slave if target is set */
+	if (!ipv6_addr_any(target) &&
+	    !ndisc_mc_map(target, target_maddr, slave->dev, 0))
+		dev_mc_add(slave->dev, target_maddr);
+}
+
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 					    struct in6_addr *target,
 					    unsigned long last_rx)
@@ -1243,8 +1306,10 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
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
@@ -1296,15 +1361,30 @@ static int bond_option_ns_ip6_targets_set(struct bonding *bond,
 {
 	return -EPERM;
 }
+
+static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add) {}
+
+void bond_slave_ns_maddrs_add(struct bonding *bond, struct slave *slave) {}
+
+void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave) {}
 #endif
 
 static int bond_option_arp_validate_set(struct bonding *bond,
 					const struct bond_opt_value *newval)
 {
+	bool changed = !!bond->params.arp_validate != !!newval->value;
+	struct list_head *iter;
+	struct slave *slave;
+
 	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.arp_validate = newval->value;
 
+	if (changed) {
+		bond_for_each_slave(bond, slave, iter)
+			slave_set_ns_maddrs(bond, slave, !!bond->params.arp_validate);
+	}
+
 	return 0;
 }
 
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 473a0147769e..18687ccf0638 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -161,5 +161,7 @@ void bond_option_arp_ip_targets_clear(struct bonding *bond);
 #if IS_ENABLED(CONFIG_IPV6)
 void bond_option_ns_ip6_targets_clear(struct bonding *bond);
 #endif
+void bond_slave_ns_maddrs_add(struct bonding *bond, struct slave *slave);
+void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave);
 
 #endif /* _NET_BOND_OPTIONS_H */
-- 
2.46.0


