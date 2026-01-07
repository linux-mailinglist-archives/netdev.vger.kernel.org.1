Return-Path: <netdev+bounces-247727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0636CFDC8F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECEB930060DB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A2316196;
	Wed,  7 Jan 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO13gosd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1530AAD7
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790645; cv=none; b=aSbF/khxT2lg/hRJ9BtAHPkK65MUUJNfHNyBOGvzapWjcb1Sbt+CAtTK5T9lqr4D0V8J4O3i3CWxnrvwr9p5dcQkbRg/DSpXGw0qKSEtU8u7zJsymAFnGlBneLaN06GgUBgQcdSMfO8dWlWlKzJvW2RPUWJarKHPqD4SRvNsx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790645; c=relaxed/simple;
	bh=LukkQPBp5SBixBLENpAhljrn+GhlOWzpEr6rtqc7ud0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZVcD3+H5BAAyY9XMxM9LekSpLmlCFu3HrsAcQ/7ms5xzrddoLyU1/EHJ6x18mLxyPL0rve3lQxfQbhUg85MB9pqawTeQdJKtXMMOQKoh29bVjH6kP9hJW2wWwieo5YENG2+EhvnXQYA2+uAMTVnAZKAYT3Ybdst//2ZK98S1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO13gosd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996F5C16AAE;
	Wed,  7 Jan 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767790645;
	bh=LukkQPBp5SBixBLENpAhljrn+GhlOWzpEr6rtqc7ud0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aO13gosdfG+LS618mjdTma5mqiYXjmVzaNcIuLG/cKwDI7YdVXdmUYl5f4NRIKOqJ
	 YoE/loVt/RlEdF4LmE7uDdBbYLY4jKv3Z2vnATLukyUW9H9DbuBvu1xHUvRF32Z3mG
	 M6CAUcuXiyFW/St6mqugQueSQSD+bH+OIoOAgRkMxmWr0HVVyIfPlYiWQKahLfW6/c
	 av996UwXYfbLz1aYb4y0jwAof7F8EpjChht7ea2rfbeFtqnhSbGOcBpmpNYxOE1eGs
	 urCaFAJOtx17DekvuGGwhzptwY1YFMm5POeV4a90wx/6/g7/mY7VFMZBtpPHLmaCBL
	 93sMz+CHh7fSA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 07 Jan 2026 13:57:15 +0100
Subject: [PATCH net-next 2/2] net: dsa: ks8995: Add DSA tagging to KS8995
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-ks8995-dsa-tagging-v1-2-1a92832c1540@kernel.org>
References: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
In-Reply-To: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This makes the KS8995 DSA switch use the special tags to direct
traffic to a specific port and identify traffic coming in on a
specific port.

These tags are not available on the sibling devices KSZ8895
or KSZ8795.

To do this the switch require us to enable "special tags" in a
register, then enable tag insertion on the CPU port, meaning the
CPU port will deliver packets with a special tag indicating which
port the traffic is coming from, and then we need to enable
tag removal on all outgoing (LAN) ports, this means that the
special egress tag is stripped off by the switch before exiting
the PHY-backed ports.

Add a MAINTAINERS entry while we're at it.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS              |  8 +++++
 drivers/net/dsa/Kconfig  |  1 +
 drivers/net/dsa/ks8995.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..310accf05153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16942,6 +16942,14 @@ F:	drivers/bus/mhi/
 F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
 F:	include/linux/mhi.h
 
+MICREL KS8995 DSA SWITCH
+M:	Linus Walleij <linusw@kernel.org>
+S:	Supported
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
+F:	drivers/net/dsa/ks8995.c
+F:	net/dsa/tag_ks8995.c
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 S:	Supported
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 7eb301fd987d..8925308cc7d7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -97,6 +97,7 @@ config NET_DSA_KS8995
 	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
 	depends on SPI
 	select NET_DSA_TAG_NONE
+	select NET_DSA_TAG_KS8995
 	help
 	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
 	  switches, managed over SPI.
diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 77d8b842693c..00c8c7853c61 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -3,7 +3,7 @@
  * SPI driver for Micrel/Kendin KS8995M and KSZ8864RMN ethernet switches
  *
  * Copyright (C) 2008 Gabor Juhos <juhosg at openwrt.org>
- * Copyright (C) 2025 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (C) 2025-2026 Linus Walleij <linusw@kernel.org>
  *
  * This file was based on: drivers/spi/at25.c
  *     Copyright (C) 2006 David Brownell
@@ -338,6 +338,12 @@ static int ks8995_reset(struct ks8995_switch *ks)
 	return ks8995_start(ks);
 }
 
+static bool ks8995_is_ks8995(struct ks8995_switch *ks)
+{
+	return ((ks->chip->family_id == FAMILY_KS8995) &&
+		(ks->chip->chip_id == KS8995_CHIP_ID));
+}
+
 /* ks8995_get_revision - get chip revision
  * @ks: pointer to switch instance
  *
@@ -532,12 +538,89 @@ dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
 					 int port,
 					 enum dsa_tag_protocol mp)
 {
-	/* This switch actually uses the 6 byte KS8995 protocol */
+	struct ks8995_switch *ks = ds->priv;
+
+	if (ks8995_is_ks8995(ks))
+		/* This switch uses the KS8995 protocol */
+		return DSA_TAG_PROTO_KS8995;
+
 	return DSA_TAG_PROTO_NONE;
 }
 
+/* Only the KS8995 supports special (DSA) tagging with special bits
+ * set for the ingress and egress ports. The "special tag" register bit
+ * in the other versions is used for clock edge setting so make sure
+ * to only enable this on the KS8995.
+ */
+static int ks8995_special_tags_setup(struct ks8995_switch *ks)
+{
+	int ret;
+	u8 val;
+	int i;
+
+	ret = ks8995_read_reg(ks, KS8995_REG_GC9, &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_GC9\n");
+		return ret;
+	}
+
+	/* Enable the "special tag" (the DSA port tagging) */
+	val |= KS8995_GC9_SPECIAL;
+
+	ret = ks8995_write_reg(ks, KS8995_REG_GC9, val);
+	if (ret)
+		dev_err(ks->dev, "failed to set KS8995_REG_GC11\n");
+
+	ret = ks8995_read_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC0), &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_PC0 on CPU port\n");
+		return ret;
+	}
+
+	/* Enable tag INSERTION on the CPU port, this will add the special KS8995 DSA tag
+	 * to packets entering from the chip, indicating the source port.
+	 */
+	val &= ~KS8995_PC0_TAG_REM;
+	val |= KS8995_PC0_TAG_INS;
+
+	ret = ks8995_write_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC0), val);
+	if (ret) {
+		dev_err(ks->dev, "failed to write KS8995_REG_PC0 on CPU port\n");
+		return ret;
+	}
+
+	/* Enable tag REMOVAL on all the LAN-facing ports: this will strip the special
+	 * DSA tag that we add during transmission of the egress packets before they exit
+	 * the router chip.
+	 */
+	for (i = 0; i < KS8995_CPU_PORT; i++) {
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC0), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC0 on port %d\n", i);
+			return ret;
+		}
+
+		val |= KS8995_PC0_TAG_REM;
+		val &= ~KS8995_PC0_TAG_INS;
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC0), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC0 on port %d\n", i);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ks8995_setup(struct dsa_switch *ds)
 {
+	struct ks8995_switch *ks = ds->priv;
+
+	if (ks8995_is_ks8995(ks))
+		/* This switch uses the KS8995 protocol */
+		return ks8995_special_tags_setup(ks);
+
 	return 0;
 }
 

-- 
2.52.0


