Return-Path: <netdev+bounces-138217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C69ACA0E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C511F2204D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6A1A76CC;
	Wed, 23 Oct 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDF7Eh0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0C155C87;
	Wed, 23 Oct 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686749; cv=none; b=Zii4/e9KyvMWgzTolrjFxq2mES8VemHUh1SvUxZPVq7Hrojg1zwoCOQrnypf7eWNeuHYx5njFu1trG1mvh8hoVSaB9fYHthUFQtVMdkUi1t8FmgDbagKe24KYyHF+3H6BztYm43nhMGhOnOvmYLUW8ZpuHRqdchu7L0sKDOvWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686749; c=relaxed/simple;
	bh=0u61zPI6kPaYE6d7SUDMcg9KEvVtVS3BiNpZ5FQc7io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GSirOC0YTYP1+xpvCN7iRatF4rIwzwTAwT00HubPI2A0DAT1swOSplsTpsNHN19Jw2XjItKkJP0Sp+OTHYm5DUa0CrNqMRdw9HAdRUV/5g/r8J7eloBwMvZD7eDOD9Dk5aZ+9kHtzjQFj8VPChXD3o699GTM6KVR1x+CHqArw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDF7Eh0B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c693b68f5so72352635ad.1;
        Wed, 23 Oct 2024 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729686747; x=1730291547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyPlzhyIGQ6drEk3t/yWEdQeT6zpBSBiNYimm8vS+lA=;
        b=kDF7Eh0BeOT2XTpgkTx/qmYbAj82DCIe28S1+4AQWIBKdFw2dO6fREegxnsL2cbI8J
         NIBmOd7qKmGG3oOgNm/y0Jf7IqBuEvYNyDx6af+jxDCBEtA4Z8sEsMY5LxijC0cvt4X7
         HCZ4KwNyzk7lrX7wJaJrd2ut0ikCJhVtpAqNpx7KgWFo73bRMqoEXyhI16eoQGLimcos
         ZSnd1L1TPH2fyR8wp3ZXnsitXSDYdviB2gPLxulzpXIWCwmty5WfUxFxk8Y2rAmR98mu
         vsPv5PTLiPmW7t4JGjEWoeiKC1qqlgk9V8FSSxpIDrfxN6MiIXV6/DhIvaDAbjqyPbwj
         oGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686747; x=1730291547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyPlzhyIGQ6drEk3t/yWEdQeT6zpBSBiNYimm8vS+lA=;
        b=Xj1aYL5AUAECQiopGgIcU12s40TJCEQH1SdAu/G3dSdKuRhn0lw2/c9KDvdGT0t80e
         vqIEGJMC5hYQGbsnunrSHXRBdeUW51ODcUuaac8nyEdAH5s2HRYngbEske9XFd2ctkYF
         CYX0fp8Ytj9gMO9Yi3cEVf2FY8JxyPq6qCxpqW2rEYIcY+7oCv4CORuPMjTJB9Q8A/Eo
         xtDIo95WKUK7H8SmCO6Lu3dpk9UHsbzGkNhYXPtIy/vjUCZMbEkVtaAs6wpX1bmIECiI
         5ogr613i840otrkGuSYWtKQJFQVfWU151trz2SKdKP3ftzeV8BwXmzHZuGknPyfVVVL+
         zjIg==
X-Forwarded-Encrypted: i=1; AJvYcCU60O8QCWAgJ9wtYRuL0FI5Plg1z8UhXfcXpKSbLv1zQ7VmOJhzIPH5iijTeLeAiuRWpyYRs+NIOu4MkQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kMikM2aZ+xrNjvHNZr6dyAoRyp0qIwAhZ8QUAISTVms3xH+e
	+KKiJ2Ib53xf9n6haAZVSZQfaOz9/p7O3BkniA2kFyffZ0YEhsksKRSJ9V0iJiY=
X-Google-Smtp-Source: AGHT+IHhGyFnOA0JEuXypLbyS99ekRbpTMXNBF40qoDwdwUJeNtU9rp5IbYcGbvg0Rinr4nuUaNeuA==
X-Received: by 2002:a05:6a20:cfa5:b0:1d9:22c1:1231 with SMTP id adf61e73a8af0-1d978b3ddc5mr2474719637.29.1729686746583;
        Wed, 23 Oct 2024 05:32:26 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7462sm6256722b3a.109.2024.10.23.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:32:25 -0700 (PDT)
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
Subject: [PATCHv2 net] bonding: add ns target multicast address to slave device
Date: Wed, 23 Oct 2024 12:32:15 +0000
Message-ID: <20241023123215.5875-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
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
v2: only add/del mcast group on backup slaves when arp_validate is set (Jay Vosburgh)
    arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab mode.
---
 drivers/net/bonding/bond_main.c    | 18 +++++-
 drivers/net/bonding/bond_options.c | 95 +++++++++++++++++++++++++++++-
 include/net/bond_options.h         |  1 +
 3 files changed, 112 insertions(+), 2 deletions(-)

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
index 95d59a18c022..2554ba70f092 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1234,6 +1234,75 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+/* convert IPv6 address to link-local solicited-node multicast mac address */
+static void ipv6_addr_to_solicited_mac(const struct in6_addr *addr,
+				       unsigned char mac[ETH_ALEN])
+{
+	mac[0] = 0x33;
+	mac[1] = 0x33;
+	mac[2] = 0xFF;
+	mac[3] = addr->s6_addr[13];
+	mac[4] = addr->s6_addr[14];
+	mac[5] = addr->s6_addr[15];
+}
+
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
+	unsigned char slot_maddr[ETH_ALEN];
+	int i;
+
+	if (!slave_can_set_ns_maddr(bond, slave))
+		return;
+
+	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
+		if (ipv6_addr_any(&targets[i]))
+			break;
+
+		ipv6_addr_to_solicited_mac(&targets[i], slot_maddr);
+		if (add)
+			dev_mc_add(slave->dev, slot_maddr);
+		else
+			dev_mc_del(slave->dev, slot_maddr);
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
+	unsigned char target_maddr[ETH_ALEN], slot_maddr[ETH_ALEN];
+
+	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
+		return;
+
+	/* remove the previous maddr on salve */
+	if (!ipv6_addr_any(slot)) {
+		ipv6_addr_to_solicited_mac(slot, slot_maddr);
+		dev_mc_del(slave->dev, slot_maddr);
+	}
+
+	/* add new maddr on slave if target is set */
+	if (!ipv6_addr_any(target)) {
+		ipv6_addr_to_solicited_mac(target, target_maddr);
+		dev_mc_add(slave->dev, target_maddr);
+	}
+}
+
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 					    struct in6_addr *target,
 					    unsigned long last_rx)
@@ -1243,8 +1312,10 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
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
@@ -1296,15 +1367,37 @@ static int bond_option_ns_ip6_targets_set(struct bonding *bond,
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


