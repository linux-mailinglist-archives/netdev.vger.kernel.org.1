Return-Path: <netdev+bounces-137386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF19A5EAD
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9642834C8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359C1DF99C;
	Mon, 21 Oct 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBlA4LFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A31E1C04;
	Mon, 21 Oct 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499480; cv=none; b=d2a05+ebspnymfcANM4OzhM5G8e21buAqjwAVQf3oDvb/3lxJux2yvZOB8RBYb4xV6wWjAemdyCNHLZ6ciz1NqMK595qZgJf2eOCKF1wdFisaiEj1x1Jh1kDcatP99bU1Xy/KKwizpfhoHej7ucQMZVgFHGZuQMyC9zDTgaBgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499480; c=relaxed/simple;
	bh=MD6Uf54kQklPW5l/RSWbga3pHtBfLo6lZNNoUwS0V+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asSQlyG8xm2WbFNh2ntTk+VIdCjpvaAjnJkCoGStJ+gHf6Ekii4O2rtkOg42M49B5f9LrXaF6UAT1iv2RKOciWOOU02x1x6VGkikXuihfNKTev0pSWW73FLzAyB8O8q85mgmdDJhXfx50ihNhVpV3PbIefxhtQ00CGz0zG/0Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBlA4LFI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2846550b3a.2;
        Mon, 21 Oct 2024 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729499477; x=1730104277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRyh0Vzw6taWDVUX+oDeXTnTCcIR54UGFKGb/Q0q7Hk=;
        b=CBlA4LFI5tG572cYcwGX1pObe6lPaNTwK/LfzedwjZWxJAlVci6Ke+FTwoOtuum87d
         xWapfbJSVaHlNVGuOyl9s0FSslNzrRhJN2EcMvEwzi/Vy1AhMymXzFkpXladQ9qcb5pd
         NFY/wGw6RDEhzSqtjm1VCpEOC1qRHKNIt5QJUipM2goCD22pQ6SYv4EGTMxUiUUiTkN+
         8mrT98ukp/FukE1sv6Wr3fs9j640aF6MNVXzj6+U6VLwmyMt49zHpYCfPyA/b8wdgptZ
         pV3+LlSHKPdoLeuLV+iuDbhUtO78J4bRU93LQvGKM60QwPuUgAdDbpBt9qbIw99U8sFb
         OA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499477; x=1730104277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRyh0Vzw6taWDVUX+oDeXTnTCcIR54UGFKGb/Q0q7Hk=;
        b=reHFgGpShCNPczp9XJGWZhF4b6Qq+uSOLZwOaA5VX8KJyVMmvB43nEQ6XhNNl6Bjdm
         rTNy+0P2X20Y15x3s6tDQWwfvSlrrhn8x8Af5ob3tpruhTzpAJMt76/GUZfMRXjrxKXZ
         6zsknxdpl15HIei3kVOE+SmXxFc3VkzUSazv2Q9W/5/2C6mf6xSG2PXDtT4Iv7ezecSv
         SBtIb74JrfRiQsAeo8Bhsniy41Vj8Kjr9lShlgAPH3t0pI8gy+b6ZDRaQyCLGhvD13rU
         RtxW2q1MMMSIstheXSR2ump26C/J2wTfHLSlek7G5kXGXHDSPu0Tfez3ab8vbXUSckmA
         6HVw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdTFj6RyRi3dRsCzM9q21lIMHFynGJzvRXQ3VbrVw+gy8iy9YnWIJTHWZtRt31h1Tmu0Zv5+GuX1COuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PBygbZMPNwOtjNv0uwmaROKvx6mecI9XIjQ+neY0izj0DGrO
	Mg138ZZEuVCm7Ib06vaBrnSlGGWcdqwaF5ujvk/e7ybScvhrWoruyDWAn6A4KI0=
X-Google-Smtp-Source: AGHT+IG+yja0MCxe5HR+sdvH5GTRKbHFUQfGxkxwGggkTNxfctjkE+Wvudin9ZKae5yE8asxbONcNw==
X-Received: by 2002:a05:6a20:bb28:b0:1d9:3456:b71e with SMTP id adf61e73a8af0-1d93456ba08mr9808967637.12.1729499476908;
        Mon, 21 Oct 2024 01:31:16 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d73easm2317771b3a.111.2024.10.21.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:31:15 -0700 (PDT)
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
Subject: [PATCH net] bonding: add ns target multicast address to slave device
Date: Mon, 21 Oct 2024 08:30:52 +0000
Message-ID: <20241021083052.2865-1-liuhangbin@gmail.com>
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

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Another way is to set IFF_ALLMULTI flag for slaves. But I think that
would affect too much.
---
 drivers/net/bonding/bond_main.c    | 11 ++++++++
 drivers/net/bonding/bond_options.c | 44 +++++++++++++++++++++++++++++-
 include/net/bond_options.h         |  2 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1bffd8e9a95..04ccbd41fb0c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2350,6 +2350,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	if (bond_mode_can_use_xmit_hash(bond))
 		bond_update_slave_arr(bond, NULL);
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (slave_dev->flags & IFF_MULTICAST)
+		/* set target NS maddrs for new slave */
+		slave_set_ns_maddr(bond, slave_dev, true);
+#endif
 
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
@@ -2503,6 +2508,12 @@ static int __bond_release_one(struct net_device *bond_dev,
 	/* recompute stats just before removing the slave */
 	bond_get_stats(bond->dev, &bond->bond_stats);
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (slave_dev->flags & IFF_MULTICAST)
+		/* clear all target NS maddrs */
+		slave_set_ns_maddr(bond, slave_dev, false);
+#endif
+
 	if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
 			.command = XDP_SETUP_PROG,
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 95d59a18c022..823cb93d2853 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1234,17 +1234,41 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
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
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 					    struct in6_addr *target,
 					    unsigned long last_rx)
 {
+	unsigned char target_maddr[ETH_ALEN], slot_maddr[ETH_ALEN];
 	struct in6_addr *targets = bond->params.ns_targets;
 	struct list_head *iter;
 	struct slave *slave;
 
+	if (!ipv6_addr_any(target))
+		ipv6_addr_to_solicited_mac(target, target_maddr);
 	if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
-		bond_for_each_slave(bond, slave, iter)
+		if (!ipv6_addr_any(&targets[slot]))
+			ipv6_addr_to_solicited_mac(&targets[slot], slot_maddr);
+		bond_for_each_slave(bond, slave, iter) {
 			slave->target_last_arp_rx[slot] = last_rx;
+			/* remove the previous maddr on salve */
+			if (!ipv6_addr_any(&targets[slot]))
+				dev_mc_del(slave->dev, slot_maddr);
+			/* add new maddr on slave if target is set */
+			if (!ipv6_addr_any(target))
+				dev_mc_add(slave->dev, target_maddr);
+		}
 		targets[slot] = *target;
 	}
 }
@@ -1290,6 +1314,24 @@ static int bond_option_ns_ip6_targets_set(struct bonding *bond,
 
 	return 0;
 }
+
+void slave_set_ns_maddr(struct bonding *bond, struct net_device *slave_dev,
+			bool add)
+{
+	struct in6_addr *targets = bond->params.ns_targets;
+	unsigned char slot_maddr[ETH_ALEN];
+	int i;
+
+	for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
+		if (!ipv6_addr_any(&targets[i])) {
+			ipv6_addr_to_solicited_mac(&targets[i], slot_maddr);
+			if (add)
+				dev_mc_add(slave_dev, slot_maddr);
+			else
+				dev_mc_del(slave_dev, slot_maddr);
+		}
+	}
+}
 #else
 static int bond_option_ns_ip6_targets_set(struct bonding *bond,
 					  const struct bond_opt_value *newval)
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 473a0147769e..c6c5c1333f37 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -160,6 +160,8 @@ static inline void __bond_opt_init(struct bond_opt_value *optval,
 void bond_option_arp_ip_targets_clear(struct bonding *bond);
 #if IS_ENABLED(CONFIG_IPV6)
 void bond_option_ns_ip6_targets_clear(struct bonding *bond);
+void slave_set_ns_maddr(struct bonding *bond, struct net_device *slave_dev,
+			bool add);
 #endif
 
 #endif /* _NET_BOND_OPTIONS_H */
-- 
2.46.0


