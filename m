Return-Path: <netdev+bounces-294274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lmGkMkD4HmoEbAAAu9opvQ
	(envelope-from <netdev+bounces-294274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0762FD32
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HxS1zvHY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294274-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ABF03094A2C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2D3EDAA0;
	Tue,  2 Jun 2026 15:27:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FB3EC2E1
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:27:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414073; cv=none; b=MCjcYX1cyAZFaE51cifUVWLAt0ZjCa9OZCIUhjH8Bakm2tJUP+7FARPQ3J+LRfNZ8stUmYKguw2EKTJhZSqG6yVSCwIQnOw56OF3YHUXlQnfRWwxrGYyDvXiiMcOZbd3YM8QWhd5w+fvUrD7F4kAtU3PrCYuimMjvkZgc2PaByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414073; c=relaxed/simple;
	bh=VQs4tW/eoKZMufXnsiNdz7NWZjMOtm+s5VEGSaq5cTA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c114JYtdoiX47XOwyjQcj2cRwJP56XyLBFc3t6gG+uJDWTVFTC79EHwAkLbKLZ3F38kHD3DCuvsvcfEr2NjunCU2Oslts8sSmpb7cDC6aAdmMB1eN7orwfoR4aiB2XL3JnLJMb5vo+8sSFRL5Zn0q+IOuyrtcuQHMaRru9wwIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxS1zvHY; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914b4036b15so2031668285a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780414070; x=1781018870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQxUCH89RzlsEDc8Rb+3neMHowKLV0CCb99fM/rZCck=;
        b=HxS1zvHYeXEkPNH9c218qTa3MqZ8TbstGFP5M903sCy007qlpiVoSZj03pdhKa9FoX
         N87dNU8Plr9QXBZXgkBhoF9qsw4lPYcTMmB95QggMrMO9fTdO+HCIPH5y1NN4mh/3CAB
         1+JFcHIYP4KBq6s6TQcTzgRKdc6VbeiJk7M1cG7hWAUxN3edTap5HNuQQUcT/FfopVST
         dJTicebJliGUXUpxYcqChm10H/KqLnpAZdoHS5UQJH1JnKkhEhdJSS7Fp1163tdaIjmV
         2KjeLEv/WUu9V2yc0tMciHQT2FFjIrx3sSoJ+UgY+R93GDJ0uHqGZqZGJS1PeE6tL1if
         KCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414070; x=1781018870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQxUCH89RzlsEDc8Rb+3neMHowKLV0CCb99fM/rZCck=;
        b=fFhnyvxE37hCpebgfOR8tFTwdRxbBDmL48ZDm42ABZRpw27H9y5sbtddqJGk16MPn1
         ePlem9YV2eQET7wvCp65WkFg0f7TKA0ii9dhNFJDgJRYOl6/q8wRj2ApuI6kYouh6qct
         UU1MfwiyQyWfDxRDzJ8miCdDGnRTa3mTG7VnqO2HaLBdPkInt7OwKJQCT/u6ieafuZD2
         YJ2uJjR1Zjdsj9HRXRev8sVvdwoZNm4sAkXiM9V64kJz4bZXb6JYa3aovArr/M0cu54e
         duGbpCTNcxEsVezkM+qcO1KB7KiDRqOERzbvgtOm7eGit9XgehgDBc8bQdIeKd+cvrLJ
         wQPg==
X-Forwarded-Encrypted: i=1; AFNElJ+Oa/BZ+/kjOP/rHKZcWdRov18B5QUZKfV7F7x/2BKg4BNunbn1AdnrEEie/xRJLSKEFzHmOA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tQjRo+RiCbioZbtqqa9qP1errXKF9i30EZK7adldsDWV9EvJ
	PpzONBAV2mNNrBADRp5kVYrCe5YsjfK7x1e+5ubYaJ0xbSOLFjbqV1UZ3jpQ1PC6AT+exX/6Pwb
	hWfYRoo+gbXj68w==
X-Received: from qkmm1.prod.google.com ([2002:a05:620a:2141:b0:915:80e4:7d4e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2586:b0:915:87a8:3735 with SMTP id af79cd13be357-91587a83982mr132918385a.31.1780414069923;
 Tue, 02 Jun 2026 08:27:49 -0700 (PDT)
Date: Tue,  2 Jun 2026 15:27:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152748.2564393-1-edumazet@google.com>
Subject: [PATCH net-next] bonding: annotate data-races in sysfs and procfs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294274-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,jvosburgh.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63D0762FD32

bonding sysfs and procfs read parameters locklessly,
while drivers/net/bonding/bond_options.c can write over them.

Add missing READ_ONCE()/WRITE_ONCE() annotations.

This came as a prereq to avoid RTNL in bond_fill_info().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/bonding/bond_options.c | 65 ++++++++++----------
 drivers/net/bonding/bond_procfs.c  | 48 ++++++++-------
 drivers/net/bonding/bond_sysfs.c   | 98 +++++++++++++++++-------------
 3 files changed, 117 insertions(+), 94 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 7380cc4ee75a9087dff45486dd199d2be790a036..5095ac3dad2cd924ff548343c7c1afe3e57e3065 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -902,22 +902,22 @@ static int bond_option_mode_set(struct bonding *bond,
 			netdev_dbg(bond->dev, "%s mode is incompatible with arp monitoring, start mii monitoring\n",
 				   newval->string);
 			/* disable arp monitoring */
-			bond->params.arp_interval = 0;
+			WRITE_ONCE(bond->params.arp_interval, 0);
 		}
 
 		if (!bond->params.miimon) {
 			/* set miimon to default value */
-			bond->params.miimon = BOND_DEFAULT_MIIMON;
+			WRITE_ONCE(bond->params.miimon, BOND_DEFAULT_MIIMON);
 			netdev_dbg(bond->dev, "Setting MII monitoring interval to %d\n",
 				   bond->params.miimon);
 		}
 	}
 
 	if (newval->value == BOND_MODE_ALB)
-		bond->params.tlb_dynamic_lb = 1;
+		WRITE_ONCE(bond->params.tlb_dynamic_lb, 1);
 
 	/* don't cache arp_validate between modes */
-	bond->params.arp_validate = BOND_ARP_VALIDATE_NONE;
+	WRITE_ONCE(bond->params.arp_validate, BOND_ARP_VALIDATE_NONE);
 	bond->params.mode = newval->value;
 
 	/* When changing mode, the bond device is down, we may reduce
@@ -1010,7 +1010,7 @@ static int bond_option_miimon_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting MII monitoring interval to %llu\n",
 		   newval->value);
-	bond->params.miimon = newval->value;
+	WRITE_ONCE(bond->params.miimon, newval->value);
 	if (bond->params.updelay)
 		netdev_dbg(bond->dev, "Note: Updating updelay (to %d) since it is a multiple of the miimon value\n",
 			   bond->params.updelay * bond->params.miimon);
@@ -1022,9 +1022,10 @@ static int bond_option_miimon_set(struct bonding *bond,
 			   bond->params.peer_notif_delay * bond->params.miimon);
 	if (newval->value && bond->params.arp_interval) {
 		netdev_dbg(bond->dev, "MII monitoring cannot be used with ARP monitoring - disabling ARP monitoring...\n");
-		bond->params.arp_interval = 0;
+		WRITE_ONCE(bond->params.arp_interval, 0);
 		if (bond->params.arp_validate)
-			bond->params.arp_validate = BOND_ARP_VALIDATE_NONE;
+			WRITE_ONCE(bond->params.arp_validate,
+				   BOND_ARP_VALIDATE_NONE);
 	}
 	if (bond->dev->flags & IFF_UP) {
 		/* If the interface is up, we may need to fire off
@@ -1067,7 +1068,7 @@ static int _bond_option_delay_set(struct bonding *bond,
 			    (value / bond->params.miimon) *
 			    bond->params.miimon);
 	}
-	*target = value / bond->params.miimon;
+	WRITE_ONCE(*target, value / bond->params.miimon);
 	netdev_dbg(bond->dev, "Setting %s to %d\n",
 		   name,
 		   *target * bond->params.miimon);
@@ -1113,11 +1114,11 @@ static int bond_option_arp_interval_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting ARP monitoring interval to %llu\n",
 		   newval->value);
-	bond->params.arp_interval = newval->value;
+	WRITE_ONCE(bond->params.arp_interval, newval->value);
 	if (newval->value) {
 		if (bond->params.miimon) {
 			netdev_dbg(bond->dev, "ARP monitoring cannot be used with MII monitoring. Disabling MII monitoring\n");
-			bond->params.miimon = 0;
+			WRITE_ONCE(bond->params.miimon, 0);
 		}
 		if (!bond->params.arp_targets[0])
 			netdev_dbg(bond->dev, "ARP monitoring has been set up, but no ARP targets have been specified\n");
@@ -1154,7 +1155,7 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
 			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
-		targets[slot] = target;
+		WRITE_ONCE(targets[slot], target);
 	}
 }
 
@@ -1226,8 +1227,8 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 		WRITE_ONCE(targets_rx[i], 0);
 	}
 	for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
-		targets[i] = targets[i+1];
-	targets[i] = 0;
+		WRITE_ONCE(targets[i], targets[i+1]);
+	WRITE_ONCE(targets[i], 0);
 
 	return 0;
 }
@@ -1449,7 +1450,7 @@ static int bond_option_arp_validate_set(struct bonding *bond,
 
 	netdev_dbg(bond->dev, "Setting arp_validate to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.arp_validate = newval->value;
+	WRITE_ONCE(bond->params.arp_validate, newval->value);
 
 	if (changed) {
 		bond_for_each_slave(bond, slave, iter)
@@ -1464,7 +1465,7 @@ static int bond_option_arp_all_targets_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting arp_all_targets to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.arp_all_targets = newval->value;
+	WRITE_ONCE(bond->params.arp_all_targets, newval->value);
 
 	return 0;
 }
@@ -1474,7 +1475,7 @@ static int bond_option_missed_max_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting missed max to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.missed_max = newval->value;
+	WRITE_ONCE(bond->params.missed_max, newval->value);
 
 	return 0;
 }
@@ -1553,7 +1554,7 @@ static int bond_option_primary_reselect_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting primary_reselect to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.primary_reselect = newval->value;
+	WRITE_ONCE(bond->params.primary_reselect, newval->value);
 
 	block_netpoll_tx();
 	bond_select_active_slave(bond);
@@ -1567,7 +1568,7 @@ static int bond_option_fail_over_mac_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting fail_over_mac to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.fail_over_mac = newval->value;
+	WRITE_ONCE(bond->params.fail_over_mac, newval->value);
 
 	return 0;
 }
@@ -1579,7 +1580,7 @@ static int bond_option_xmit_hash_policy_set(struct bonding *bond,
 		return -EOPNOTSUPP;
 	netdev_dbg(bond->dev, "Setting xmit hash policy to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.xmit_policy = newval->value;
+	WRITE_ONCE(bond->params.xmit_policy, newval->value);
 
 	return 0;
 }
@@ -1589,7 +1590,7 @@ static int bond_option_resend_igmp_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting resend_igmp to %llu\n",
 		   newval->value);
-	bond->params.resend_igmp = newval->value;
+	WRITE_ONCE(bond->params.resend_igmp, newval->value);
 
 	return 0;
 }
@@ -1597,7 +1598,7 @@ static int bond_option_resend_igmp_set(struct bonding *bond,
 static int bond_option_num_peer_notif_set(struct bonding *bond,
 				   const struct bond_opt_value *newval)
 {
-	bond->params.num_peer_notif = newval->value;
+	WRITE_ONCE(bond->params.num_peer_notif, newval->value);
 
 	return 0;
 }
@@ -1610,7 +1611,7 @@ static int bond_option_all_slaves_active_set(struct bonding *bond,
 
 	if (newval->value == bond->params.all_slaves_active)
 		return 0;
-	bond->params.all_slaves_active = newval->value;
+	WRITE_ONCE(bond->params.all_slaves_active, newval->value);
 	bond_for_each_slave(bond, slave, iter) {
 		if (!bond_is_active_slave(slave)) {
 			if (newval->value)
@@ -1628,7 +1629,7 @@ static int bond_option_min_links_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting min links value to %llu\n",
 		   newval->value);
-	bond->params.min_links = newval->value;
+	WRITE_ONCE(bond->params.min_links, newval->value);
 	bond_set_carrier(bond);
 
 	return 0;
@@ -1637,7 +1638,7 @@ static int bond_option_min_links_set(struct bonding *bond,
 static int bond_option_lp_interval_set(struct bonding *bond,
 				       const struct bond_opt_value *newval)
 {
-	bond->params.lp_interval = newval->value;
+	WRITE_ONCE(bond->params.lp_interval, newval->value);
 
 	return 0;
 }
@@ -1647,7 +1648,7 @@ static int bond_option_pps_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting packets per slave to %llu\n",
 		   newval->value);
-	bond->params.packets_per_slave = newval->value;
+	WRITE_ONCE(bond->params.packets_per_slave, newval->value);
 	if (newval->value > 0) {
 		bond->params.reciprocal_packets_per_slave =
 			reciprocal_value(newval->value);
@@ -1667,7 +1668,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.lacp_active = newval->value;
+	WRITE_ONCE(bond->params.lacp_active, newval->value);
 	bond_3ad_update_lacp_active(bond);
 
 	return 0;
@@ -1678,7 +1679,7 @@ static int bond_option_lacp_rate_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting LACP rate to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.lacp_fast = newval->value;
+	WRITE_ONCE(bond->params.lacp_fast, newval->value);
 	bond_3ad_update_lacp_rate(bond);
 
 	return 0;
@@ -1689,7 +1690,7 @@ static int bond_option_ad_select_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting ad_select to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.ad_select = newval->value;
+	WRITE_ONCE(bond->params.ad_select, newval->value);
 
 	return 0;
 }
@@ -1808,7 +1809,7 @@ static int bond_option_tlb_dynamic_lb_set(struct bonding *bond,
 {
 	netdev_dbg(bond->dev, "Setting dynamic-lb to %s (%llu)\n",
 		   newval->string, newval->value);
-	bond->params.tlb_dynamic_lb = newval->value;
+	WRITE_ONCE(bond->params.tlb_dynamic_lb, newval->value);
 
 	return 0;
 }
@@ -1819,7 +1820,7 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting ad_actor_sys_prio to %llu\n",
 		   newval->value);
 
-	bond->params.ad_actor_sys_prio = newval->value;
+	WRITE_ONCE(bond->params.ad_actor_sys_prio, newval->value);
 	bond_3ad_update_ad_actor_settings(bond);
 
 	return 0;
@@ -1879,7 +1880,7 @@ static int bond_option_ad_user_port_key_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting ad_user_port_key to %llu\n",
 		   newval->value);
 
-	bond->params.ad_user_port_key = newval->value;
+	WRITE_ONCE(bond->params.ad_user_port_key, newval->value);
 	return 0;
 }
 
@@ -1889,7 +1890,7 @@ static int bond_option_coupled_control_set(struct bonding *bond,
 	netdev_info(bond->dev, "Setting coupled_control to %s (%llu)\n",
 		    newval->string, newval->value);
 
-	bond->params.coupled_control = newval->value;
+	WRITE_ONCE(bond->params.coupled_control, newval->value);
 	return 0;
 }
 
diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 3714aab1a3d9c54cb41de06e074ff483f2ac0b94..ec51e446a17c46d8fa00bc3d2f70425bf20c841c 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -61,27 +61,28 @@ static void bond_info_show_master(struct seq_file *seq)
 	struct bonding *bond = pde_data(file_inode(seq->file));
 	const struct bond_opt_value *optval;
 	struct slave *curr, *primary;
-	int i;
+	int arp_interval, fail_over_mac, miimon, i;
 
 	curr = rcu_dereference(bond->curr_active_slave);
 
 	seq_printf(seq, "Bonding Mode: %s",
 		   bond_mode_name(BOND_MODE(bond)));
 
-	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
-	    bond->params.fail_over_mac) {
+	fail_over_mac = READ_ONCE(bond->params.fail_over_mac);
+	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP && fail_over_mac) {
 		optval = bond_opt_get_val(BOND_OPT_FAIL_OVER_MAC,
-					  bond->params.fail_over_mac);
+					  fail_over_mac);
 		seq_printf(seq, " (fail_over_mac %s)", optval->string);
 	}
 
 	seq_printf(seq, "\n");
 
 	if (bond_mode_uses_xmit_hash(bond)) {
-		optval = bond_opt_get_val(BOND_OPT_XMIT_HASH,
-					  bond->params.xmit_policy);
+		int xmit_policy = READ_ONCE(bond->params.xmit_policy);
+
+		optval = bond_opt_get_val(BOND_OPT_XMIT_HASH, xmit_policy);
 		seq_printf(seq, "Transmit Hash Policy: %s (%d)\n",
-			   optval->string, bond->params.xmit_policy);
+			   optval->string, xmit_policy);
 	}
 
 	if (bond_uses_primary(bond)) {
@@ -90,7 +91,7 @@ static void bond_info_show_master(struct seq_file *seq)
 			   primary ? primary->dev->name : "None");
 		if (primary) {
 			optval = bond_opt_get_val(BOND_OPT_PRIMARY_RESELECT,
-						  bond->params.primary_reselect);
+					READ_ONCE(bond->params.primary_reselect));
 			seq_printf(seq, " (primary_reselect %s)",
 				   optval->string);
 		}
@@ -101,32 +102,36 @@ static void bond_info_show_master(struct seq_file *seq)
 
 	seq_printf(seq, "MII Status: %s\n", netif_carrier_ok(bond->dev) ?
 		   "up" : "down");
-	seq_printf(seq, "MII Polling Interval (ms): %d\n", bond->params.miimon);
+	miimon = READ_ONCE(bond->params.miimon);
+	seq_printf(seq, "MII Polling Interval (ms): %d\n", miimon);
 	seq_printf(seq, "Up Delay (ms): %d\n",
-		   bond->params.updelay * bond->params.miimon);
+		   READ_ONCE(bond->params.updelay) * miimon);
 	seq_printf(seq, "Down Delay (ms): %d\n",
-		   bond->params.downdelay * bond->params.miimon);
+		   READ_ONCE(bond->params.downdelay) * miimon);
 	seq_printf(seq, "Peer Notification Delay (ms): %d\n",
-		   bond->params.peer_notif_delay * bond->params.miimon);
+		   READ_ONCE(bond->params.peer_notif_delay) * miimon);
 
 
 	/* ARP information */
-	if (bond->params.arp_interval > 0) {
+	arp_interval = READ_ONCE(bond->params.arp_interval);
+	if (arp_interval > 0) {
 		int printed = 0;
 
 		seq_printf(seq, "ARP Polling Interval (ms): %d\n",
-				bond->params.arp_interval);
+				arp_interval);
 		seq_printf(seq, "ARP Missed Max: %u\n",
-				bond->params.missed_max);
+				READ_ONCE(bond->params.missed_max));
 
 		seq_printf(seq, "ARP IP target/s (n.n.n.n form):");
 
 		for (i = 0; (i < BOND_MAX_ARP_TARGETS); i++) {
-			if (!bond->params.arp_targets[i])
+			__be32 t = READ_ONCE(bond->params.arp_targets[i]);
+
+			if (!t)
 				break;
 			if (printed)
 				seq_printf(seq, ",");
-			seq_printf(seq, " %pI4", &bond->params.arp_targets[i]);
+			seq_printf(seq, " %pI4", &t);
 			printed = 1;
 		}
 		seq_printf(seq, "\n");
@@ -152,12 +157,13 @@ static void bond_info_show_master(struct seq_file *seq)
 
 		seq_puts(seq, "\n802.3ad info\n");
 		seq_printf(seq, "LACP active: %s\n",
-			   (bond->params.lacp_active) ? "on" : "off");
+			   READ_ONCE(bond->params.lacp_active) ? "on" : "off");
 		seq_printf(seq, "LACP rate: %s\n",
-			   (bond->params.lacp_fast) ? "fast" : "slow");
-		seq_printf(seq, "Min links: %d\n", bond->params.min_links);
+			   READ_ONCE(bond->params.lacp_fast) ? "fast" : "slow");
+		seq_printf(seq, "Min links: %d\n",
+			   READ_ONCE(bond->params.min_links));
 		optval = bond_opt_get_val(BOND_OPT_AD_SELECT,
-					  bond->params.ad_select);
+					  READ_ONCE(bond->params.ad_select));
 		seq_printf(seq, "Aggregator selection policy (ad_select): %s\n",
 			   optval->string);
 		if (capable(CAP_NET_ADMIN)) {
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index eaba44c76a5ec69fb677d1e0698ab515e1fa82b3..3232406cbd247454343064343c004ee3e60fbc76 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -213,10 +213,12 @@ static ssize_t bonding_show_xmit_hash(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int xmit_policy;
 
-	val = bond_opt_get_val(BOND_OPT_XMIT_HASH, bond->params.xmit_policy);
+	xmit_policy = READ_ONCE(bond->params.xmit_policy);
+	val = bond_opt_get_val(BOND_OPT_XMIT_HASH, xmit_policy);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.xmit_policy);
+	return sysfs_emit(buf, "%s %d\n", val->string, xmit_policy);
 }
 static DEVICE_ATTR(xmit_hash_policy, 0644,
 		   bonding_show_xmit_hash, bonding_sysfs_store_option);
@@ -228,11 +230,12 @@ static ssize_t bonding_show_arp_validate(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int arp_validate;
 
-	val = bond_opt_get_val(BOND_OPT_ARP_VALIDATE,
-			       bond->params.arp_validate);
+	arp_validate = READ_ONCE(bond->params.arp_validate);
+	val = bond_opt_get_val(BOND_OPT_ARP_VALIDATE, arp_validate);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.arp_validate);
+	return sysfs_emit(buf, "%s %d\n", val->string, arp_validate);
 }
 static DEVICE_ATTR(arp_validate, 0644, bonding_show_arp_validate,
 		   bonding_sysfs_store_option);
@@ -244,11 +247,11 @@ static ssize_t bonding_show_arp_all_targets(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int arp_all_targets;
 
-	val = bond_opt_get_val(BOND_OPT_ARP_ALL_TARGETS,
-			       bond->params.arp_all_targets);
-	return sysfs_emit(buf, "%s %d\n",
-		       val->string, bond->params.arp_all_targets);
+	arp_all_targets = READ_ONCE(bond->params.arp_all_targets);
+	val = bond_opt_get_val(BOND_OPT_ARP_ALL_TARGETS, arp_all_targets);
+	return sysfs_emit(buf, "%s %d\n", val->string, arp_all_targets);
 }
 static DEVICE_ATTR(arp_all_targets, 0644,
 		   bonding_show_arp_all_targets, bonding_sysfs_store_option);
@@ -260,11 +263,12 @@ static ssize_t bonding_show_fail_over_mac(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int fail_over_mac;
 
-	val = bond_opt_get_val(BOND_OPT_FAIL_OVER_MAC,
-			       bond->params.fail_over_mac);
+	fail_over_mac = READ_ONCE(bond->params.fail_over_mac);
+	val = bond_opt_get_val(BOND_OPT_FAIL_OVER_MAC, fail_over_mac);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.fail_over_mac);
+	return sysfs_emit(buf, "%s %d\n", val->string, fail_over_mac);
 }
 static DEVICE_ATTR(fail_over_mac, 0644,
 		   bonding_show_fail_over_mac, bonding_sysfs_store_option);
@@ -276,7 +280,7 @@ static ssize_t bonding_show_arp_interval(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.arp_interval);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.arp_interval));
 }
 static DEVICE_ATTR(arp_interval, 0644,
 		   bonding_show_arp_interval, bonding_sysfs_store_option);
@@ -290,9 +294,10 @@ static ssize_t bonding_show_arp_targets(struct device *d,
 	int i, res = 0;
 
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-		if (bond->params.arp_targets[i])
-			res += sysfs_emit_at(buf, res, "%pI4 ",
-					     &bond->params.arp_targets[i]);
+		__be32 t = READ_ONCE(bond->params.arp_targets[i]);
+
+		if (t)
+			res += sysfs_emit_at(buf, res, "%pI4 ", &t);
 	}
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
@@ -309,7 +314,7 @@ static ssize_t bonding_show_missed_max(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%u\n", bond->params.missed_max);
+	return sysfs_emit(buf, "%u\n", READ_ONCE(bond->params.missed_max));
 }
 static DEVICE_ATTR(arp_missed_max, 0644,
 		   bonding_show_missed_max, bonding_sysfs_store_option);
@@ -321,7 +326,8 @@ static ssize_t bonding_show_downdelay(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.downdelay * bond->params.miimon);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.downdelay) *
+				       READ_ONCE(bond->params.miimon));
 }
 static DEVICE_ATTR(downdelay, 0644,
 		   bonding_show_downdelay, bonding_sysfs_store_option);
@@ -332,7 +338,8 @@ static ssize_t bonding_show_updelay(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.updelay * bond->params.miimon);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.updelay) *
+				       READ_ONCE(bond->params.miimon));
 
 }
 static DEVICE_ATTR(updelay, 0644,
@@ -345,7 +352,8 @@ static ssize_t bonding_show_peer_notif_delay(struct device *d,
 	struct bonding *bond = to_bond(d);
 
 	return sysfs_emit(buf, "%d\n",
-			  bond->params.peer_notif_delay * bond->params.miimon);
+			  READ_ONCE(bond->params.peer_notif_delay) *
+			  READ_ONCE(bond->params.miimon));
 }
 static DEVICE_ATTR(peer_notif_delay, 0644,
 		   bonding_show_peer_notif_delay, bonding_sysfs_store_option);
@@ -357,10 +365,12 @@ static ssize_t bonding_show_lacp_active(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int lacp_active;
 
-	val = bond_opt_get_val(BOND_OPT_LACP_ACTIVE, bond->params.lacp_active);
+	lacp_active = READ_ONCE(bond->params.lacp_active);
+	val = bond_opt_get_val(BOND_OPT_LACP_ACTIVE, lacp_active);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.lacp_active);
+	return sysfs_emit(buf, "%s %d\n", val->string, lacp_active);
 }
 static DEVICE_ATTR(lacp_active, 0644,
 		   bonding_show_lacp_active, bonding_sysfs_store_option);
@@ -371,10 +381,12 @@ static ssize_t bonding_show_lacp_rate(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int lacp_fast;
 
-	val = bond_opt_get_val(BOND_OPT_LACP_RATE, bond->params.lacp_fast);
+	lacp_fast = READ_ONCE(bond->params.lacp_fast);
+	val = bond_opt_get_val(BOND_OPT_LACP_RATE, lacp_fast);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.lacp_fast);
+	return sysfs_emit(buf, "%s %d\n", val->string, lacp_fast);
 }
 static DEVICE_ATTR(lacp_rate, 0644,
 		   bonding_show_lacp_rate, bonding_sysfs_store_option);
@@ -385,7 +397,7 @@ static ssize_t bonding_show_min_links(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%u\n", bond->params.min_links);
+	return sysfs_emit(buf, "%u\n", READ_ONCE(bond->params.min_links));
 }
 static DEVICE_ATTR(min_links, 0644,
 		   bonding_show_min_links, bonding_sysfs_store_option);
@@ -396,10 +408,12 @@ static ssize_t bonding_show_ad_select(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int ad_select;
 
-	val = bond_opt_get_val(BOND_OPT_AD_SELECT, bond->params.ad_select);
+	ad_select = READ_ONCE(bond->params.ad_select);
+	val = bond_opt_get_val(BOND_OPT_AD_SELECT, ad_select);
 
-	return sysfs_emit(buf, "%s %d\n", val->string, bond->params.ad_select);
+	return sysfs_emit(buf, "%s %d\n", val->string, ad_select);
 }
 static DEVICE_ATTR(ad_select, 0644,
 		   bonding_show_ad_select, bonding_sysfs_store_option);
@@ -411,7 +425,7 @@ static ssize_t bonding_show_num_peer_notif(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.num_peer_notif);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.num_peer_notif));
 }
 static DEVICE_ATTR(num_grat_arp, 0644,
 		   bonding_show_num_peer_notif, bonding_sysfs_store_option);
@@ -425,7 +439,7 @@ static ssize_t bonding_show_miimon(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.miimon);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.miimon));
 }
 static DEVICE_ATTR(miimon, 0644,
 		   bonding_show_miimon, bonding_sysfs_store_option);
@@ -455,14 +469,15 @@ static ssize_t bonding_show_primary_reselect(struct device *d,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	struct bonding *bond = to_bond(d);
+	const struct bonding *bond = to_bond(d);
 	const struct bond_opt_value *val;
+	int primary_reselect;
+
+	primary_reselect = READ_ONCE(bond->params.primary_reselect);
 
-	val = bond_opt_get_val(BOND_OPT_PRIMARY_RESELECT,
-			       bond->params.primary_reselect);
+	val = bond_opt_get_val(BOND_OPT_PRIMARY_RESELECT, primary_reselect);
 
-	return sysfs_emit(buf, "%s %d\n",
-			  val->string, bond->params.primary_reselect);
+	return sysfs_emit(buf, "%s %d\n", val->string, primary_reselect);
 }
 static DEVICE_ATTR(primary_reselect, 0644,
 		   bonding_show_primary_reselect, bonding_sysfs_store_option);
@@ -655,7 +670,7 @@ static ssize_t bonding_show_slaves_active(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.all_slaves_active);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.all_slaves_active));
 }
 static DEVICE_ATTR(all_slaves_active, 0644,
 		   bonding_show_slaves_active, bonding_sysfs_store_option);
@@ -667,7 +682,7 @@ static ssize_t bonding_show_resend_igmp(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.resend_igmp);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.resend_igmp));
 }
 static DEVICE_ATTR(resend_igmp, 0644,
 		   bonding_show_resend_igmp, bonding_sysfs_store_option);
@@ -679,7 +694,7 @@ static ssize_t bonding_show_lp_interval(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.lp_interval);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.lp_interval));
 }
 static DEVICE_ATTR(lp_interval, 0644,
 		   bonding_show_lp_interval, bonding_sysfs_store_option);
@@ -690,7 +705,7 @@ static ssize_t bonding_show_tlb_dynamic_lb(struct device *d,
 {
 	struct bonding *bond = to_bond(d);
 
-	return sysfs_emit(buf, "%d\n", bond->params.tlb_dynamic_lb);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(bond->params.tlb_dynamic_lb));
 }
 static DEVICE_ATTR(tlb_dynamic_lb, 0644,
 		   bonding_show_tlb_dynamic_lb, bonding_sysfs_store_option);
@@ -700,7 +715,7 @@ static ssize_t bonding_show_packets_per_slave(struct device *d,
 					      char *buf)
 {
 	struct bonding *bond = to_bond(d);
-	unsigned int packets_per_slave = bond->params.packets_per_slave;
+	unsigned int packets_per_slave = READ_ONCE(bond->params.packets_per_slave);
 
 	return sysfs_emit(buf, "%u\n", packets_per_slave);
 }
@@ -714,7 +729,7 @@ static ssize_t bonding_show_ad_actor_sys_prio(struct device *d,
 	struct bonding *bond = to_bond(d);
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD && capable(CAP_NET_ADMIN))
-		return sysfs_emit(buf, "%hu\n", bond->params.ad_actor_sys_prio);
+		return sysfs_emit(buf, "%hu\n", READ_ONCE(bond->params.ad_actor_sys_prio));
 
 	return 0;
 }
@@ -743,7 +758,8 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
 	struct bonding *bond = to_bond(d);
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD && capable(CAP_NET_ADMIN))
-		return sysfs_emit(buf, "%hu\n", bond->params.ad_user_port_key);
+		return sysfs_emit(buf, "%hu\n",
+				  READ_ONCE(bond->params.ad_user_port_key));
 
 	return 0;
 }
-- 
2.54.0.929.g9b7fa37559-goog


