Return-Path: <netdev+bounces-292760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGRXFn1rGGrcjggAu9opvQ
	(envelope-from <netdev+bounces-292760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:21:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EE5F4E91
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE10C32E90BA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AE3FD13E;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS6kXqUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C543FCB2B;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984582; cv=none; b=KaTB0pk0N5XmZpg04fp9k2mgxPSlJKUCA1bB8JaP3KlQ/AoCZ3ZWklvcZtiAkqX7Efb1IPwQVPYrPC+frF15eBeKJFe9bPtV1PPhlUxxo6J5AnQr7gzPvtpp5YMIz6xh0MVonEISUZG6YgsCb+H0ZUvdzNg/giESFG+g1ugdBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984582; c=relaxed/simple;
	bh=VdBUolhNyo8yi7fcXoYRSQ+Yv/xh8n4VXOHyJf6wnGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7aFqMEKF93s9eMUFX/8ZVR89Q53cPJ8Vl3vAQvO9tAYHjed9AGbeHGbo3tE9dLe8PfKkQO+rVaAyeR3ifkEbYM4ofmdXcLlBgtlaD4GoUlduUjyb8S3CrUpE1mhCPB2E5bvGmdzqXDa9BWYewr5yNVT8CxVJ77NVMXDron/bBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS6kXqUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E4FCC2BCC4;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779984582;
	bh=VdBUolhNyo8yi7fcXoYRSQ+Yv/xh8n4VXOHyJf6wnGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GS6kXqUWXsaWn9K1neFeiSiRcgOpLdbmo1GpgI4zqG6rLZ/d513W+q6ypDoS5m1GH
	 1jNcX9C9mNpfP9iM61sprUbsAbj5OY0W6jU27q1F68Qe4wqib5KEZrRZMQ+jcQZBm7
	 WrhSdt4dAdo25vkKtPUNa6+DGBPdUsB5cobmCTH8lB0nYtIInFzKaJZcu19cP1qn+2
	 7oDz5XCMOb2ZSHjxwXaxESHNbjGh6UWBCvb+hI4+sGU7OH3cC3VB8s1QmKVq+UEVEm
	 jqCkgbglEFJ0WNzqTjN/vtt3j8LbIs2CoOoRpWNW1FuE5c3b/bQhsqaRoNNQeWAfvf
	 AZhb+mesdz/8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E33CD4F54;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Thu, 28 May 2026 18:09:32 +0200
Subject: [PATCH net-next v4 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-net-next-mv88e6xxx-cbs-v4-1-8bd13b906457@luminex.be>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
In-Reply-To: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779984580; l=11505;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=N73EMbDeMk4TXkTfSVwg8qX1Kj5tDWt/w+RuUrgiY1M=;
 b=uSNDGYA/EuSh3u41NuKHbZu7Huid465w7o3F14xkBASOKNLAnDgE0vAFnaPN45aQLNMLu25LS
 QT9+F/pmjfVD1jeHgJHRoYG+7yiSay+xySJSb8MmzK5g+/tgvDMag9p
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292760-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,luminex.be:replyto,luminex.be:mid,luminex.be:email]
X-Rspamd-Queue-Id: 904EE5F4E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cedric Jehasse <cedric.jehasse@luminex.be>

When transmitting fill in the PRI field in the dsa tag to select the
egress queue is sent to.
From the datasheets i've looked at these switches have 4 or 8 transmit
queues per port.
Note: skbs with skb->fw_offload_fwd_mark set use the DSA_CMD_FORWARD
tag. These are processed as normal ingress frames, meaning the queue
they end up in can still be altered by other switch config. eg. priority
overrides, tcam policies.
This isn't done for vlan tagged frames because this would overwrite the
PCP value in the vlan tag (The PRI field in the dsa
tag is used as the PCP value in the vlan tag).

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 net/dsa/tag_dsa.c                | 11 ++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..ffd4fa41b7c5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3979,6 +3979,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 	chip->ds = ds;
 	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
+	ds->num_tx_queues = chip->info->num_tx_queues;
 
 	/* Since virtual bridges are mapped in the PVT, the number we support
 	 * depends on the physical switch topology. We need to let DSA figure
@@ -5689,6 +5690,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		 */
 		.num_ports = 7,
 		.num_internal_phys = 2,
+		.num_tx_queues = 4,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
 		.max_vid = 4095,
 		.port_base_addr = 0x8,
@@ -5711,6 +5713,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -5733,6 +5736,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 10,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5757,6 +5761,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 11,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -5778,6 +5783,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 11,
 		.num_internal_phys = 8,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5803,6 +5809,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 1024,
 		.num_ports = 3,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5828,6 +5835,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 8,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -5850,6 +5858,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 6,
 		.num_internal_phys = 5,
 		.num_gpio = 11,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5875,6 +5884,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 1024,
 		.num_ports = 6,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5901,6 +5911,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 6,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5926,6 +5937,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5952,6 +5964,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -5977,6 +5990,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6003,6 +6017,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6028,6 +6043,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 10,
 		.num_internal_phys = 0,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
@@ -6051,6 +6067,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6076,6 +6093,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6100,6 +6118,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 16384,
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6125,6 +6144,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6151,6 +6171,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6181,6 +6202,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 2,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6205,6 +6227,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6230,6 +6253,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6254,6 +6278,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6282,6 +6307,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6310,6 +6336,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6337,6 +6364,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_ports = 6,
 		.num_gpio = 11,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6363,6 +6391,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6388,6 +6417,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6414,6 +6444,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6442,6 +6473,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.invalid_port_mask = BIT(1) | BIT(2) | BIT(8),
 		.num_internal_phys = 5,
 		.internal_phys_offset = 3,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6468,6 +6500,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6495,6 +6528,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6521,6 +6555,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.internal_phys_offset = 1,
 		.max_vid = 8191,
 		.max_sid = 63,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index cde71828e9d9..19d8eda19b78 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -136,6 +136,7 @@ struct mv88e6xxx_info {
 	unsigned int num_internal_phys;
 	unsigned int num_gpio;
 	unsigned int num_tcam_entries;
+	unsigned int num_tx_queues;
 	unsigned int max_vid;
 	unsigned int max_sid;
 	unsigned int port_base_addr;
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 2a2c4fb61a65..cc27b2994c6b 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -179,8 +179,17 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 			dsa_header[2] &= ~0x10;
 		}
 	} else {
+		u16 queue = skb_get_queue_mapping(skb) & 0x7;
 		u16 vid;
 
+		/* The PRI field is 3 bits. According to the documentation the
+		 * 2 highest bits specify the egress queue in From_CPU DSA
+		 * tagged frames. On devices with 8 queues it's possible to
+		 * send to the 8 queues, which means the 3 bits are used.
+		 */
+		if (dp->ds->num_tx_queues == 4)
+			queue <<= 1;
+
 		vid = br_dev ? MV88E6XXX_VID_BRIDGED : MV88E6XXX_VID_STANDALONE;
 
 		skb_push(skb, DSA_HLEN + extra);
@@ -191,7 +200,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 
 		dsa_header[0] = (cmd << 6) | tag_dev;
 		dsa_header[1] = tag_port << 3;
-		dsa_header[2] = vid >> 8;
+		dsa_header[2] = (queue << 5) | vid >> 8;
 		dsa_header[3] = vid & 0xff;
 	}
 

-- 
2.43.0



