Return-Path: <netdev+bounces-290776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOWQM5M3EGoaVAYAu9opvQ
	(envelope-from <netdev+bounces-290776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793675B2A75
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1640D301C10F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE753D4117;
	Fri, 22 May 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTzmN3Bv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E73D3D0B;
	Fri, 22 May 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447399; cv=none; b=ZwffUqvrBh+/3e5Ivh8S3/rMmupCstIcsoUmImME7G5MVtiL8fwipud2miFVV1G1nCth4U2KHrL1CGh6K10sKFhWfSSHq/lHPgMfGBJOImPEhMLNQ3WJvure8RLRGod6rg2+Dyjwks2K6+5r/rTguDwmONBOJvAcOR6HdbaHgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447399; c=relaxed/simple;
	bh=qvZkhlsuEcZSEcwblgQKPCcuS85u2WzNyPhtl+l61pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3TGnIyz5hofbFoecg+i48vFqtWbojMnYpJlNDBkpXvTjHrfbK6ZC7NalOhv57nzY/Kep2FT2bqbGBKn7y/c2wTWlBuWCE4hhxBVtn0SzDJfvM7W21qmMDOBSzkV+blBDgQxw5sKIj1+4Zb/1hA307bU5+AVr/F80pEDZTCElxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTzmN3Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E42C0C2BCB8;
	Fri, 22 May 2026 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779447399;
	bh=qvZkhlsuEcZSEcwblgQKPCcuS85u2WzNyPhtl+l61pM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eTzmN3BvNAZpQt6KH+mOS+9uSpdKo/MRgdlg8hsRnB9NEf+08TvlfMg0TALMxKl/v
	 9Iujx/QEqWE198amR3dZ0SP/ji/S50HPK/XCsvamHiiEACvZLHZwbCWTX+jbUEfc2t
	 EJliJGnMlL8RoIYHzDLfuXekSjA8Mz2rJYC1zLY7VsDqZEvoqGZ1h8vOM8asE2iBkK
	 Gp4tzNFti2DWTbaM8XLp0V3UDdJnXAp6m8DPel51XNOpDWFdv5AiTv8IfzuTx1QgeX
	 Zw3588dBF22sYjTR8UjGtgnSRqqunRdPmUyBayiSGgq+5OmEwRUNiZ95QgN7bn5c8L
	 J9JJ+b/jd+2Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB76CD5BB0;
	Fri, 22 May 2026 10:56:38 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Fri, 22 May 2026 12:56:22 +0200
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779447397; l=5690;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=weJ0Zyvyvl6ZsDGuiTxfE/omgcZa+1TFkl/4LE6ZKXM=;
 b=hlErBP1KeucV7W1+3Qh82MJaPO2KntUuYh7DGJKqdz6c4hRZoGqLjfR4C0lvOUwvUHv9IGBPE
 KKsvsV/MoH6C8/jOq2UMgbtcvKH+bosc+DMqRrOAH66uvlNDQleArRl
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290776-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,luminex.be:replyto,luminex.be:mid,luminex.be:email]
X-Rspamd-Queue-Id: 793675B2A75
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
 drivers/net/dsa/mv88e6xxx/chip.c | 14 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 net/dsa/tag_dsa.c                |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..277efe24edf4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3979,6 +3979,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 	chip->ds = ds;
 	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
+	ds->num_tx_queues = chip->info->num_tx_queues;
 
 	/* Since virtual bridges are mapped in the PVT, the number we support
 	 * depends on the physical switch topology. We need to let DSA figure
@@ -6051,6 +6052,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6076,6 +6078,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6125,6 +6128,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 8,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6151,6 +6155,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 8,
 		.num_tcam_entries = 256,
 		.internal_phys_offset = 1,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6181,6 +6186,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 2,
 		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6205,6 +6211,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6230,6 +6237,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 64,
 		.num_ports = 7,
 		.num_internal_phys = 5,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.port_base_addr = 0x08,
 		.phy_base_addr = 0x00,
@@ -6282,6 +6290,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6310,6 +6319,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 2,
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6414,6 +6424,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 7,
 		.num_internal_phys = 5,
 		.num_gpio = 15,
+		.num_tx_queues = 4,
 		.max_vid = 4095,
 		.max_sid = 63,
 		.port_base_addr = 0x10,
@@ -6468,6 +6479,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 9,
 		.num_gpio = 16,
 		.num_tcam_entries = 256,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6495,6 +6507,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_ports = 11,	/* 10 + Z80 */
 		.num_internal_phys = 9,
 		.num_gpio = 16,
+		.num_tx_queues = 8,
 		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
@@ -6521,6 +6534,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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



