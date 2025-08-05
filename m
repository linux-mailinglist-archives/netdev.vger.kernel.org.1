Return-Path: <netdev+bounces-211661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378FB1B004
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1167A5014
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772324BCE8;
	Tue,  5 Aug 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0TrqgRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169C24634F;
	Tue,  5 Aug 2025 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381392; cv=none; b=Icuev4Hj/X9H4CI87FfpHE7k3dW6IxMgHuVBJfUos7hgc1uC+Hm0AudvX5tbiXE6LY0jOSm3EHbEBRA9ymgCaDuhWDtt0bUjknYDhVIGdYA1HsDf1MuWskn1xPii+J9sBXf6mVCGmnxwqCeuwSjknuup/qcxEkvUMgAMQ43KVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381392; c=relaxed/simple;
	bh=/Kvd3gq5gSRpjWH8//h/apb5ddtdHtTaHkCnWu/vjR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V28op128yE6v3uD6t0GjG0FvZxB1Qc0FUGV76ZGWV/QIkf7a/9xvSyNmsGTS/gzWw0GnW40qO20aBG1eUdlBVLb5P5fweg76kyuj+xw3UpBbLuayxo727aE2AbR9GqVvI3T7t3jMpPFBApFbnlLnmF8rSSx/sYmLeDJlxnUqZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0TrqgRY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236377f00a1so46381675ad.3;
        Tue, 05 Aug 2025 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754381390; x=1754986190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCRQR1Bvw3FTD/e1aHpu9ygiPOyM7VlONIAkEriFph4=;
        b=e0TrqgRYpRcaibhNczg1C49HD/FlXNdIs37XwkX4CqdEmc8UsUssU3A5ZVFuyuwPGc
         6wVGumPHjlkM8yYhPxw7CfejPBa4HBuRIevC7lS6ppvRTyTXiaKqrrA/fTNx87UbsNMl
         9YrtFH0wXnkFy0pOM+soHvv8RR1s7Lj9mwevenubcAyTSGaaSMaA234rdvyPHOwBmcHi
         oqHGQ+R8C6tN+ZSvzlkemPB1QoqBBKUtmQvMaATvznGdcsPJgoc4lG9koxTh9SAOUrVe
         GbV2DxeT/cl894Q0EJf+jFsQOP27K8aq+kGY2RA7V7fh5+Ii9504KyW/Z00dTP9O2FnV
         4THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754381390; x=1754986190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCRQR1Bvw3FTD/e1aHpu9ygiPOyM7VlONIAkEriFph4=;
        b=YYjd6RnEdoa3+ixRvQXuOgLYuXqLiGnuzBU2bUQB1yZmfxqZQQHIiT6+ii61NI929f
         AeSwV4RsfrrVPXGEaUqIuximhTwNh03yr+E5oaaTUzfzi7EtSZcLhv5nlo/cTlE0ykoZ
         3zcUGmH9CIOe0qgpkVm6rdE7CBo3gTfB/JkBwZM4XAHx4hhthBTgaz7/yzkcjYNK5/XH
         fSa6A/ogRnGLq/lm3DZGkeV1sep5Jv8w1wkJeQKfy8TUsgvBWgzQ5aVp8HmRwTmWKxxm
         dFVgqY4xSyqhPdmv8OwzRxxVUdYnzRj8W+9nNwgotM9nwQAU+l5z5RGm9h7gak0J1BhY
         z7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVCvrbyVuEfzgaPQxByWiK2mjAdhGVYPU8zbWlLPIyb5c/81v71aVuXww1tP/8kwD0gTdMP//1yvJG3jKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrmpZ0rARjTBNrZIZ8CsOIZaUp0LqDzjjPJtoQ/yPJ2iqOgrW
	C71ZCPTEwoStNjaIeXtGZxAfpc0PyQanesuPPv9nSsimEPM6TPrZKDkE/Hnj/uijjrI=
X-Gm-Gg: ASbGnctbnEZlYus1LlRR53pmCcDEPZHlJC9DxZhnohWPsGsijWcSMow0dtJA4TEn7a8
	lKZiKMyTjp/YkfaFmv9y4GNhAM+X54XVZ262ctRW9CBDSP1h6t6sFmwd/2/X8CmEfZbYPk0F9Yq
	001VAYxgA0EYXsl7A9HwRvgFORGnuMLZy4XH69+Q6v1O1Zg6vul0p4yoBkF0qMX7PW+CcjTlt8V
	Ymb3W81jCNKieq9dGkId9m1pjbKK2n1BtjNfBTakxtLHTHRQaXDENCXrCVm2QYlMYurHio3FPJW
	hNsACehJkjqobmjSkzWxK2lsQkn2wuYo3MFDV7M3mNDURW5ovCs4if21A+EqR1JgKr7xQILB42T
	j6+klHkGUq7okcv3GH3K9bC1IBdv4Ahtu6MLK0z/5rhYrGA0=
X-Google-Smtp-Source: AGHT+IHQBzTh/xWHtASNTofL8FsFtshX2G+B9pY/SDZVKyU+5jk0RvWk9ft9LfPpBvPHcpHzF/eO2w==
X-Received: by 2002:a17:902:d2c7:b0:240:3c64:8626 with SMTP id d9443c01a7336-24246f2cce1mr204550115ad.5.1754381390218;
        Tue, 05 Aug 2025 01:09:50 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899af03sm125632675ad.126.2025.08.05.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:09:49 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCHv2 net] bonding: fix multicast MAC address synchronization
Date: Tue,  5 Aug 2025 08:09:36 +0000
Message-ID: <20250805080936.39830-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a corner case where the NS (Neighbor Solicitation) target is set to
an invalid or unreachable address. In such cases, all the slave links are
marked as down and set to *backup*. This causes the bond to add multicast MAC
addresses to all slaves. The ARP monitor then cycles through each slave to
probe them, temporarily marking as *active*.

Later, if the NS target is changed or cleared during this probe cycle, the
*active* slave will fail to remove its NS multicast address because
bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
This leaves stale multicast MACs on the interface.

To fix this, we move the NS multicast MAC address handling into
bond_set_slave_state(), so every slave state transition consistently
adds/removes NS multicast addresses as needed.

We also ensure this logic is only active when arp_interval is configured,
to prevent misconfiguration or accidental behavior in unsupported modes.

Note: Cleanup in __bond_release_one() is retained to remove addresses
when the slave is unbound from the bond.

Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2:
1) Make sure arp_interval is set befer setting slave mac address.
2) add comment about why we need to set slave->backup between two if blocks
3) update commit description
---
 drivers/net/bonding/bond_main.c    |  9 ---------
 drivers/net/bonding/bond_options.c |  1 +
 include/net/bonding.h              | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..283615d8a3fd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1003,8 +1003,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 
 		if (bond->dev->flags & IFF_UP)
 			bond_hw_addr_flush(bond->dev, old_active->dev);
-
-		bond_slave_ns_maddrs_add(bond, old_active);
 	}
 
 	if (new_active) {
@@ -1021,8 +1019,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
 			dev_mc_sync(new_active->dev, bond->dev);
 			netif_addr_unlock_bh(bond->dev);
 		}
-
-		bond_slave_ns_maddrs_del(bond, new_active);
 	}
 }
 
@@ -2373,11 +2369,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	bond_compute_features(bond);
 	bond_set_carrier(bond);
 
-	/* Needs to be called before bond_select_active_slave(), which will
-	 * remove the maddrs if the slave is selected as active slave.
-	 */
-	bond_slave_ns_maddrs_add(bond, new_slave);
-
 	if (bond_uses_primary(bond)) {
 		block_netpoll_tx();
 		bond_select_active_slave(bond);
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 1d639a3be6ba..f54386982198 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1264,6 +1264,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *slave)
 {
 	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+	       bond->params.arp_interval &&
 	       !bond_is_active_slave(slave) &&
 	       slave->dev->flags & IFF_MULTICAST;
 }
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..951d752a5301 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -388,7 +388,24 @@ static inline void bond_set_slave_state(struct slave *slave,
 	if (slave->backup == slave_state)
 		return;
 
+	/*
+	 * The slave->backup assignment must occur between the two if blocks.
+	 * This is because bond_slave_ns_maddrs_{add,del} only operate on
+	 * backup slaves:
+	 *
+	 * - If the slave is transitioning to active, we must call
+	 *   bond_slave_ns_maddrs_del() *before* updating the backup flag.
+	 * - If transitioning to backup, we must call
+	 *   bond_slave_ns_maddrs_add() *after* setting the flag.
+	 */
+	if (slave_state == BOND_STATE_ACTIVE)
+		bond_slave_ns_maddrs_del(slave->bond, slave);
+
 	slave->backup = slave_state;
+
+	if (slave_state == BOND_STATE_BACKUP)
+		bond_slave_ns_maddrs_add(slave->bond, slave);
+
 	if (notify) {
 		bond_lower_state_changed(slave);
 		bond_queue_slave_event(slave);
-- 
2.46.0


