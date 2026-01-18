Return-Path: <netdev+bounces-250927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91435D39A44
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17DA300B2B2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B12FDC37;
	Sun, 18 Jan 2026 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZlFwKif"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15E23B63C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774072; cv=none; b=P15R5mHuLkmkLqcqoMyNWrkMV3Ctj31cLgNcPYPHN7K6gYnwk4nedy4o0RUTgclfijdvywk+zeUtPF0bnFwyPBFMiD35vNFLP0TUq6B/kEROIuQcDgI6QYKHMiOdNZ8yG33r0mENXciHV+2u76O0K2yAWbBXZ5QgDYcAWHSCZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774072; c=relaxed/simple;
	bh=T2bIJrl4QEakLSCAoGrmwGZ0UqAzT0qPqc/M2lrVugw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiGYmavwVcb2uNgjfOmX47gayj7ULlliKyU0e7+xiiLNTj5DyVnGZ4J5Lacm3lUc1g0t5vTE/BhxGorfK0IuVKCycbx9Lf+Q3Gn2ITPe37oRRz3bp+f1trL2+GVTjqzjGQDDBLqrwD/itTY7MGKx82M9KDTFKmly9VEacXB+Y6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZlFwKif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02580C19424;
	Sun, 18 Jan 2026 22:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774071;
	bh=T2bIJrl4QEakLSCAoGrmwGZ0UqAzT0qPqc/M2lrVugw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OZlFwKifzRheM9HdT0jx26McV83RO0lc/bxS9vjILZQtsyyCgP8sODjgjRw0Hd6Dg
	 En9TOJFTn1NeFGcvCdUL4rm2x71T6vYxerVpVG8qjIjo4VNWkGv/VnWgWFPTPZ3Txs
	 MSi7qNlWFtmGAuChS0h1PNAfo4TWe4V0TAshgZa/Sgwejt97fzGM9/VijzQveavhjl
	 TMFY1s/79O/fD4t7w0jZ9E+DL2Sb3m54D3aOhIxq/8QZKvNh3Q+3AriI+0locTPY4Q
	 h+50EB1WEjoit+lMF+mioIiqtwc52JqJLYHLsr0qA4ozI6l2Q1a2aYIDkdvv+ggjdT
	 OAfpmFqqF95kg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 18 Jan 2026 23:07:34 +0100
Subject: [PATCH net-next 4/4] net: dsa: ks8995: Implement port isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-ks8995-fixups-v1-4-10a493f0339d@kernel.org>
References: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
In-Reply-To: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

It is unsound to not have proper port isolation on a
switch which supports it.

Set each port as isolated by default in the setup callback
and de-isolate and isolate the ports in the bridge join/leave
callbacks.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 060bc8303a14..ad985f0d0dba 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -80,6 +80,11 @@
 #define KS8995_PC0_TAG_REM	BIT(1)	/* Enable tag removal on port */
 #define KS8995_PC0_PRIO_EN	BIT(0)	/* Enable priority handling */
 
+#define KS8995_PC1_SNIFF_PORT	BIT(7)	/* This port is a sniffer port */
+#define KS8995_PC1_RCV_SNIFF	BIT(6)	/* Packets received goes to sniffer port(s) */
+#define KS8995_PC1_XMIT_SNIFF	BIT(5)	/* Packets transmitted goes to sniffer port(s) */
+#define KS8995_PC1_PORT_VLAN	GENMASK(4, 0)	/* Port isolation mask */
+
 #define KS8995_PC2_TXEN		BIT(2)	/* Enable TX on port */
 #define KS8995_PC2_RXEN		BIT(1)	/* Enable RX on port */
 #define KS8995_PC2_LEARN_DIS	BIT(0)	/* Disable learning on port */
@@ -441,6 +446,44 @@ dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
 
 static int ks8995_setup(struct dsa_switch *ds)
 {
+	struct ks8995_switch *ks = ds->priv;
+	int ret;
+	u8 val;
+	int i;
+
+	/* Isolate all user ports so they can only send packets to itself and the CPU port */
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+
+		val &= ~KS8995_PC1_PORT_VLAN;
+		val |= BIT(i) | BIT(KS8995_CPU_PORT);
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+	}
+
+	/* The CPU port should be able to talk to all ports */
+	ret = ks8995_read_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on CPU port\n");
+		return ret;
+	}
+
+	val |= KS8995_PC1_PORT_VLAN;
+
+	ret = ks8995_write_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), val);
+	if (ret) {
+		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on CPU port\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -466,8 +509,56 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
 				   bool *tx_fwd_offload,
 				   struct netlink_ext_ack *extack)
 {
+	struct ks8995_switch *ks = ds->priv;
+	unsigned int port_bitmap = 0;
+	int ret;
+	u8 val;
+	int i;
+
+	/* De-isolate this port from any other port on the bridge */
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		/* Current port handled last */
+		if (i == port)
+			continue;
+		/* Not on this bridge */
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+
+		val |= BIT(port);
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+
+		/* Accumulate this port for access by current */
+		port_bitmap |= BIT(i);
+	}
+
+	/* Let current port access all other ports on the bridge */
+	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", port);
+		return ret;
+	}
+
+	val |= BIT(port_bitmap);
+
+	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), val);
+	if (ret) {
+		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", port);
+		return ret;
+	}
+
 	/* port_stp_state_set() will be called after to put the port in
-	 * appropriate state so there is no need to do anything.
+	 * appropriate state.
 	 */
 
 	return 0;
@@ -476,8 +567,56 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
 static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
 				     struct dsa_bridge bridge)
 {
+	struct ks8995_switch *ks = ds->priv;
+	unsigned int port_bitmap = 0;
+	int ret;
+	u8 val;
+	int i;
+
+	/* Isolate this port from any other port on the bridge */
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		/* Current port handled last */
+		if (i == port)
+			continue;
+		/* Not on this bridge */
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
+			return;
+		}
+
+		val &= ~BIT(port);
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
+			return;
+		}
+
+		/* Accumulate this port for access by current */
+		port_bitmap |= BIT(i);
+	}
+
+	/* Isolate this port from all other ports formerly on the bridge */
+	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", port);
+		return;
+	}
+
+	val &= ~BIT(port_bitmap);
+
+	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), val);
+	if (ret) {
+		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", port);
+		return;
+	}
+
 	/* port_stp_state_set() will be called after to put the port in
-	 * forwarding state so there is no need to do anything.
+	 * forwarding state.
 	 */
 }
 

-- 
2.52.0


