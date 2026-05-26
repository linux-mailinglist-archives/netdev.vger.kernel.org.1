Return-Path: <netdev+bounces-291670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJaQIs6HFWpXWQcAu9opvQ
	(envelope-from <netdev+bounces-291670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A75D5157
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E153053BA8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629413E2AB2;
	Tue, 26 May 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBEitvyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD23E51CA;
	Tue, 26 May 2026 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795681; cv=none; b=spNiE9qkhVIRU4ssYgmo918ANglyaHaBvzDpfiRiJyMx/7RHPbhe6mSz3f6ZKOG/aWHLNAWGOqhf3wUMHIG4+R728QA0zrq/V5OsEfSV2CXO5yS0xmgE1BM/wrmp3J6LSDwjCxEwXhnMuBmrY5vWDGTt1kcYQEqOeb1WvVSS8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795681; c=relaxed/simple;
	bh=0fL3XeGJfaA+AeCFu8+QTGSbbY112A6Q0RRB2BrJ3Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSL05uxIZ33xblc+N0WoglziEcJqIYrsH3fkG+aG0QpopnnkOS45zP0xt4UgEhI9HWeN524WiVlDcROVr4UZ3Ph76MguGxMw4wyzlEgW19LPsz1BnHTvS7TICw2BYkY51KEBd8GCZ6HSzSJN9DvjRQsrHxNmlItnJH4xe0BVwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBEitvyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDDC0C2BCC7;
	Tue, 26 May 2026 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779795679;
	bh=0fL3XeGJfaA+AeCFu8+QTGSbbY112A6Q0RRB2BrJ3Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UBEitvyInK9EfyZdszGSzwEovBGsqnzW4SW1NGng6RQpjQ/X8qGE6yumavbhxQ27x
	 z7QIj30EGb/clMqJClFlGvo5n2FkjvnkcBfwhMAhhuaB8DZkcyNIzphTr0sesAlikM
	 w/aWlURa9Hcb+kILJ4ULgsTIB1TmMn3zLlXuo7tyWu5TOeyRGRWu2yYrJQzM8HwPOE
	 IB596qTCr1NIYuy3LPVt/IBBwT/BN1iRTqg99MekdbIGKxAApgThZVFRbgX1WUgS5V
	 61QaVb2K+MU/0+4FrO4YRH2jeRdchoLssyPya9ph6ajylsRW05kmQbRhT6oPkxsVb8
	 B2iV0/UpiuM8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF4CD5BD0;
	Tue, 26 May 2026 11:41:18 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Tue, 26 May 2026 13:41:14 +0200
Subject: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-net-next-mv88e6xxx-cbs-v2-1-13eb49c29b83@luminex.be>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
In-Reply-To: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779795677; l=10640;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=lMevVxiTSA4b91R+42R/GFqUf5AtPMS5FTRydXgef6g=;
 b=SaYj9sfMhLjVQYwzEFJHrAjsbfFG+e3gwZjTvU6pbDgHUg3frvkOQFx9QkrtdGd7CaiNBqf2H
 6EJrrIX3zkrBuW7mmWT+rTDtKNpUg3ybQiPqHJzheGBJT3AIfI/1jlc
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291670-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be]
X-Rspamd-Queue-Id: CF9A75D5157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cedric Jehasse <cedric.jehasse@luminex.be>

From the datasheets i've looked at these switches have 4 or 8 transmit
queues per port.
There's a PRI field in the dsa tag used to indicate which egress queue
the frame is to be sent to.
This isn't done for vlan tagged frames because this would overwrite the
PCP value in the vlan tag (The PRI field in the dsa
tag is used as the PCP value in the vlan tag).

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 net/dsa/tag_dsa.c                |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..70a6d46066e7 100644
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
@@ -6125,6 +6143,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6151,6 +6170,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6181,6 +6201,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 2,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6205,6 +6226,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6230,6 +6252,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6254,6 +6277,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6282,6 +6306,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6310,6 +6335,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6337,6 +6363,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_ports = 6,
 		.num_gpio = 11,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6363,6 +6390,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6388,6 +6416,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_macs = 8192,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6414,6 +6443,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6442,6 +6472,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.invalid_port_mask = BIT(1) | BIT(2) | BIT(8),
 		.num_internal_phys = 5,
 		.internal_phys_offset = 3,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6468,6 +6499,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6495,6 +6527,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6521,6 +6554,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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
index 2a2c4fb61a65..96c8fbedbd3b 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -179,6 +179,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 			dsa_header[2] &= ~0x10;
 		}
 	} else {
+		u16 queue = skb_get_queue_mapping(skb) & 0x7;
 		u16 vid;
 
 		vid = br_dev ? MV88E6XXX_VID_BRIDGED : MV88E6XXX_VID_STANDALONE;
@@ -191,7 +192,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 
 		dsa_header[0] = (cmd << 6) | tag_dev;
 		dsa_header[1] = tag_port << 3;
-		dsa_header[2] = vid >> 8;
+		dsa_header[2] = (queue << 5) | vid >> 8;
 		dsa_header[3] = vid & 0xff;
 	}
 

-- 
2.43.0



