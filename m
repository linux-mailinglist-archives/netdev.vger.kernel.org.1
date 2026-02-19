Return-Path: <netdev+bounces-259481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJPJNYMdl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:26:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916815F770
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0F53069ACC
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFA33EAF9;
	Thu, 19 Feb 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag9H2Yx+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAD33E368
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511074; cv=none; b=fDD0sWJRaZBQ8u8hAuwiE9dsX6K3lNqpkKoYoPy4N/a3O3/Xla96LVcWzekr2sJO7dsjcGhohl44TQRczsUrXC9d3J92d/MSBVJpPIEpI1rc12nQnAbnMFyNknShVmFh+pAPuehb6rWfXF1U8yLYLJWbquO8Dq8CZn8YafZkGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511074; c=relaxed/simple;
	bh=mFTTChIZMPbImSnGQe9CAyrsfNbtDDi1TMX8en9zWZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYHDmO9/lIhR4zsPdPK4aPep6C8ci7MbGVqI/KH5oV6b/QklFyXCqhL9Jz6J9F7FRHi4Q7l0nPWIGzg3dACYTjtRAERfJrfZ4M6X9GCCYXE28eF1cpYpRxAQ2Bm8TgUTcnj3XhgZFyusp8fy/I8dv31yntICiEa2a2n3ewQ+Xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag9H2Yx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEA4C116D0;
	Thu, 19 Feb 2026 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511073;
	bh=mFTTChIZMPbImSnGQe9CAyrsfNbtDDi1TMX8en9zWZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ag9H2Yx+K1KqomDSlx/D525yT5xzDPuKCrQYysWw4LOGXk94MpECkFG/AqG7Ui97w
	 8PRyAuAq0GxulVLzYAlf2PLKy0TGmNDLE4nj+eaX2jp0ObBEllBLKuwcCrlyG6p4mv
	 PUxvhqNDkF8R4O9sQw4zC2sEJ9NtwM7EpfJ4P0w62/bR4Lcewoa19dXvjyMu6TFbhW
	 NToSdP9e98mPV69ZdSsy9jgWXeUuqylUWpEehHefeGq0dwe9Ogc8VI5xVJMp5dkE9x
	 V6CSa61pG5lTvrFH/S+wnXhDX4iqP/UnW4oESeI2Pom5XFPSnV+HJEhGzW3gW3qVxW
	 oHDqg5Ua/0jyw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 15:24:21 +0100
Subject: [PATCH net v3 5/5] net: dsa: ks8995: Implement port isolation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
In-Reply-To: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259481-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5916815F770
X-Rspamd-Action: no action

It is unsound to not have proper port isolation on a
switch which supports it.

Set each port as isolated by default in the setup callback
and de-isolate and isolate the ports in the bridge join/leave
callbacks.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 1ed81a8f7d21..dbae218fb015 100644
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
+		val |= (BIT(i) | BIT(KS8995_CPU_PORT));
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
 
@@ -466,8 +509,44 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
 				   bool *tx_fwd_offload,
 				   struct netlink_ext_ack *extack)
 {
+	struct ks8995_switch *ks = ds->priv;
+	u8 port_bitmap = 0;
+	int ret;
+	u8 val;
+	int i;
+
+	/* De-isolate this port from any other port on the bridge */
+	port_bitmap |= BIT(port);
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		if (i == port)
+			continue;
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+		port_bitmap |= BIT(i);
+	}
+
+	/* Update all affected ports with the new bitmask */
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+
+		val |= port_bitmap;
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
+			return ret;
+		}
+	}
+
 	/* port_stp_state_set() will be called after to put the port in
-	 * appropriate state so there is no need to do anything.
+	 * appropriate state.
 	 */
 
 	return 0;
@@ -476,8 +555,56 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
 static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
 				     struct dsa_bridge bridge)
 {
+	struct ks8995_switch *ks = ds->priv;
+	u8 port_bitmap = 0;
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
+	val &= ~port_bitmap;
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
2.53.0


