Return-Path: <netdev+bounces-267307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI0YIDC6s2lXaQAAu9opvQ
	(envelope-from <netdev+bounces-267307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:18:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FAC27EB66
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 712C430C0349
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CE36BCC8;
	Fri, 13 Mar 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRlC+PmQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E036828A;
	Fri, 13 Mar 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386023; cv=none; b=Wj8dHx64l/9t8S9ZVhgzhZ6ja2kuwAGdk1tpQMATiDm3tNpbHgvJLpjNUP6IUePwmn5ZN2T6m0CObeTcc+YXPjWBw+n/rElzlfm63VNqjC1VfbMR2y5gb786HmLugzwESUw1YOyNJiIhjHWhudseUZWJ+dPTjsSqPEtkzUVm5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386023; c=relaxed/simple;
	bh=irkQSwZ0ZgATCbIp5Z59MJUY/oOrgGe+E+CmoJMzRtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogtQiisjjQG8t8aUMzEiL240XgfF0050u6elDZxQ5UUlEnAv53klUG7vx99KsjHFxZvEEhIl+s+EpgWSVRG9a0rqjSBsXEuc6DcOhZrW5/FPZypGhrNTIO5yrYtf0hgkZfuyv5dT2ZUEXMeNM4WGswwH52xhmVw0mmUjxmEo83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRlC+PmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E069DC2BCAF;
	Fri, 13 Mar 2026 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773386022;
	bh=irkQSwZ0ZgATCbIp5Z59MJUY/oOrgGe+E+CmoJMzRtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VRlC+PmQRD0Fqh8YxhKtXiE90sfe0ukQXCzD8jJTt3/c8X9eQkodiH+ccFHReKaj/
	 +G4B8tAVo7Jo24+8Ks6MD0Aa54TD11swIW/6tH30NW36ql6K8CY7/+Zgkz4x4YUQih
	 xEsQbkP5poQe4qiRqrdfkad0sluFrpK0G0NVlRHV5gabkCnccfkHzpaDrVF0dCDBlh
	 L84nPYvS/W6B/YYeyswYQ4SVq0IOsdgN4N8sScgO1YdABg9K3CT027ZHsn/xLsUojM
	 7NEWqTIcIZBotKpfR2lpxl5NPrbkbipjo4/6L2O3A8wy52YQONbkIcYlgRoCYgHqgx
	 UNoXxqKjgmQpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8969106FD8A;
	Fri, 13 Mar 2026 07:13:42 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Fri, 13 Mar 2026 08:13:35 +0100
Subject: [PATCH net-next v12 4/4] stmmac: s32: enable support for Multi-IRQ
 mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-dwmac_multi_irq-v12-4-b5c9d0aa13d6@oss.nxp.com>
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
In-Reply-To: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773386021; l=4691;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=Rdb+10aBIE2gR8Bncd1438yIs2mBOuENyRGkl1CSN58=;
 b=fB8QPeHuIKTmONfEhXXoeF5KRPH8jL6K8S6vwriB04EmaXI6DaSFv6ZzMZyeJVT3EO9EP1OuA
 E0qHUrIRz8BDcra8KcjoEkNKNEcLSnE9ELDzm5801yS23gfFATzO2SU
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267307-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4033c000:email,nxp.com:email,suse.com:email,oss.nxp.com:replyto,oss.nxp.com:mid,s32g399aevb3:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02FAC27EB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Based on previous changes in platform driver, the vendor
glue driver can enable Multi-IRQ mode, if needed.

To get enabled Multi-IRQ mode for dwmac-s32, the driver checks:

  1) property of 'snps,mtl-xx-config' subnode
     defines 'snps,xx-queues-to-use' bigger then one, ie:

     ethernet@4033c000 {
         compatible = "nxp,s32g2-dwmac";
         ...
         snps,mtl-rx-config = <&mtl_rx_setup>;
         ...

         mtl_rx_setup: rx-queues-config {
             snps,rx-queues-to-use = <2>;
         };

  2) queue based IRQs are set, ie:

     ethernet@4033c000 {
         compatible = "nxp,s32g2-dwmac";
         ...
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
                      /* CHN 0: tx, rx */
                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
                      /* CHN 1: tx, rx */
                      <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "macirq",
                           "tx-queue-0", "rx-queue-0",
                           "tx-queue-1", "rx-queue-1";

If those prerequisites are met, the driver switches to Multi-IRQ mode,
using per-queue IRQs for rx/tx data pathr:

[    1.387045] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQs) selected

Now the driver owns all queues IRQs:

root@s32g399aevb3:~# grep eth /proc/interrupts
 29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
 30:    0    0    0    0    0    0    0    0    GICv3  91 Level   eth0:rx-0
 31:    0    0    0    0    0    0    0    0    GICv3  93 Level   eth0:rx-1
 32:    0    0    0    0    0    0    0    0    GICv3  95 Level   eth0:rx-2
 33:    0    0    0    0    0    0    0    0    GICv3  97 Level   eth0:rx-3
 34:    0    0    0    0    0    0    0    0    GICv3  99 Level   eth0:rx-4
 35:    0    0    0    0    0    0    0    0    GICv3  90 Level   eth0:tx-0
 36:    0    0    0    0    0    0    0    0    GICv3  92 Level   eth0:tx-1
 37:    0    0    0    0    0    0    0    0    GICv3  94 Level   eth0:tx-2
 38:    0    0    0    0    0    0    0    0    GICv3  96 Level   eth0:tx-3
 39:    0    0    0    0    0    0    0    0    GICv3  98 Level   eth0:tx-4

Otherwise, if one of the prerequisite don't met, the driver
continue with MAC IRQ mode:

[    1.387045] s32-dwmac 4033c000.ethernet: MAC IRQ mode selected

And only MAC IRQ will be attached:

root@s32g399aevb3:~# grep eth /proc/interrupts
 29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac

What represents the original MAC IRQ mode and is fully backward
compatible.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 36 ++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 48fceadc55b1..024d8e10e918 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -2,7 +2,7 @@
 /*
  * NXP S32G/R GMAC glue layer
  *
- * Copyright 2019-2024 NXP
+ * Copyright 2019-2026 NXP
  *
  */
 
@@ -110,6 +110,37 @@ static void s32_gmac_exit(struct device *dev, void *priv)
 	clk_disable_unprepare(gmac->rx_clk);
 }
 
+static void s32_gmac_setup_multi_irq(struct device *dev,
+				     struct plat_stmmacenet_data *plat,
+				     struct stmmac_resources *res)
+{
+	int i;
+
+	/* RX IRQs */
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		if (res->rx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing RX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	/* TX IRQs */
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		if (res->tx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing TX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
+	return;
+
+mac_irq_mode:
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(dev, "MAC IRQ mode selected\n");
+}
+
 static int s32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
@@ -165,6 +196,9 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->pmt = true;
 	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+
+	s32_gmac_setup_multi_irq(dev, plat, &res);
+
 	plat->rx_fifo_size = 20480;
 	plat->tx_fifo_size = 20480;
 

-- 
2.47.0



