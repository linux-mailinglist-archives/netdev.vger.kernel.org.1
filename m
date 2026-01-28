Return-Path: <netdev+bounces-254154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDIPMwrOeWnfzgEAu9opvQ
	(envelope-from <netdev+bounces-254154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7B9E723
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85069303A6CE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1233ADAA;
	Wed, 28 Jan 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bALrlQbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7933A71A;
	Wed, 28 Jan 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590198; cv=none; b=mZhYSTToRrnpJJyqmq9rvf29f+DU+w9/MB9aXLyVncVhtHjwqq7XnHvxRehR3HlbvJyKsSKn2GnEtZZOb/cSUbSjExhVtezf21Hpt+uDbO6qsK/RRmtkt/oWhRVHyGgBuWwPbjNQYi4lRhcvAdvtR+/AHniZAT8jKTnP7yuDKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590198; c=relaxed/simple;
	bh=n9Iorvk8iVt3UkSxca9W0HXO8bsTIYYN0SFfGhp1PmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqZ7PU4jazeyW8BZ6dfxPT0Sf2sfNMl8u4BrQA+0hA2CLPY04+nVIBDVa2CO6WruWh78ahy3600dFxNPkT2s9btOKGujK9wPtwIMDcmEr1Du+XjWN+1Pg1CqhMzbERMmTDBdZkHRtK1xrd7WkzceaPXjf/0tdJdZl+K1m0pRPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bALrlQbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8AD6C4CEF1;
	Wed, 28 Jan 2026 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769590197;
	bh=n9Iorvk8iVt3UkSxca9W0HXO8bsTIYYN0SFfGhp1PmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bALrlQbEMGkAolqBk9DExUb3FBfk1ov2ZITw/sUoCznI4ThO9/XJ/4NlBm13YPqIY
	 t3ExTvN9Dc32S4zyJaiXumqHht/k6o3GhCQbwRtQX1Mr+8EptUMOWKP5xy7g6YBrBW
	 iI8MoWLUj081fdkXAtB1/Pyi5uxUE1yanzXjDfh5YFA0aul3FR/EA9uW/2Nqg34iAV
	 hhaPBq/mqzpXZojIODSrbySkuJ7rEv6zJ4PdCT4aF0z7kXAZnXpAXCwlw+JDahCbNS
	 f4QuTecSIZO4j+NSAilyrcdK/Njc0dmBBr2pnZm303MloSMJFEfg2Urwhjjmm/VZCm
	 X7st+jKcsX0ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E5D35694;
	Wed, 28 Jan 2026 08:49:57 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 28 Jan 2026 09:49:55 +0100
Subject: [PATCH v4 4/4] stmmac: s32: enable support for Multi-IRQ mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dwmac_multi_irq-v4-4-82fa34fcf2f2@oss.nxp.com>
References: <20260128-dwmac_multi_irq-v4-0-82fa34fcf2f2@oss.nxp.com>
In-Reply-To: <20260128-dwmac_multi_irq-v4-0-82fa34fcf2f2@oss.nxp.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769590195; l=3825;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=F5iLqXdHMZ2qiiJkqKhxBpUsPyBKNhvXgKzEG4aoAks=;
 b=GMmeRxime6Zalz6f8cJNInShlnHl2IGRspApM3aNDxKsncINGGej0ms30rkwEIshXjUDTw4hS
 pLuP9QH+OdyD4LrfdukIsvsC6+xAkZUEhQkih4wlGHMk13XiWnhWw7R
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254154-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4033c000:email,oss.nxp.com:mid,oss.nxp.com:replyto,s32g399aevb3:email,suse.com:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78D7B9E723
X-Rspamd-Action: no action

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

To get enabled Multi-IRQ mode, the driver checks:

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

If those prerequisites are met, the driver switch to Multi-IRQ mode,
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..37a5b7b46973 100644
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
 
@@ -149,6 +149,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->pmt = 1;
 	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+
+	/* Check for multi-IRQ config. Assumption: symetrical rx/tx queues */
+	if (plat->rx_queues_to_use > 1 &&
+	    (res.rx_irq[0] > 0 && res.tx_irq[0] > 0)) {
+		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+		dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
+	} else {
+		dev_info(dev, "MAC IRQ mode selected\n");
+	}
+
 	plat->rx_fifo_size = 20480;
 	plat->tx_fifo_size = 20480;
 

-- 
2.47.0



