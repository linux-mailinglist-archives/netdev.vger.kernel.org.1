Return-Path: <netdev+bounces-244647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA54CBC0F3
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B0A300D414
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270D315D50;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIYVbP79"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44F19A2A3;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765750553; cv=none; b=U8cUvhMwHtTT3SNduqqqt+a9bQousAvzD/mkoYQRI6XoDTk5MfiQtZOBib9udnEUSoZo59tiyy18oW1oaGYqQcwW9J9z+5skg4vZZpTLAZlEn6rWdl4ikZDy03ZBFLFT9cvaTk+ywUgxD+e4UOKrd++vXcfzk5YITTupV2tZ1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765750553; c=relaxed/simple;
	bh=eoWq0R056rv6qFunXhkW+ex9LyETDs54864ThvZUEN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mUiWKSKAB2BWysmZyfEVi9MSmu8orDyp8b3WZVBbCP2fVHVcLR8W+YMeQX5KZiSLnoIuZzepak+qlyrYJ1aEpkXHwAcorrOhsMrr6724eP4ibfpGM3Qy5Ek4khBmFjvcUlHKSkyJlo+3iIBZ0u2RLrGEoYyjugDMXg1Za6ceIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIYVbP79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9315C4CEF1;
	Sun, 14 Dec 2025 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765750553;
	bh=eoWq0R056rv6qFunXhkW+ex9LyETDs54864ThvZUEN0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sIYVbP79jyu36bP2/ttcG9+TnIZASIbsMOfDQlGt67dlHV5o3hlT6W4jlWsk2iGWS
	 /90+fX6H6VbzZOvk+vvCLijEwlCkQ2leZan8z9L6MizQ3HNSR13QmN8FdAwtaDhwrW
	 AoKjELjgs9maUHNjiJ+PM1yamiYUrkxITT4ig2wgxYDbn0CaTW5lb7RPgSyczSACif
	 bZ+gwMwKgYAX3S08OEvIMDtiC385cpJkO76aQ4Hb158rQHM/3ja022s/Z7RCvYleuZ
	 Ty5MSoqaBfhOqDRznL/5rIXZCaLMnjRa8s7iIsvykLso8PsEoW64bfqUQ05AoE8D6V
	 nmYV1PtNApxAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A8D5B16E;
	Sun, 14 Dec 2025 22:15:52 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Subject: [PATCH RFC 0/4] Support multi-channel IRQs in stmmac platform
 drivers
Date: Sun, 14 Dec 2025 23:15:36 +0100
Message-Id: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAg3P2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNL3ZTy3MTk+NzSnJLM+MyiQl3LFIs0MwMTM6PkZEMloK6CotS0zAq
 widFKQW7OSrG1tQC+VpqgZgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765750551; l=4064;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=eoWq0R056rv6qFunXhkW+ex9LyETDs54864ThvZUEN0=;
 b=2gQIU5wXxSZN34/wa2M1NFfbZH0jsb3PuTqiNgL/E7P0BbaWTcjdieFbbA7UU7kR4LeCpMq6i
 XH6Jmr1v0jWAEEMu9tEhHckAVlKp6UMi8B3z0/Ksqx3lOIILWxGtVh4
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

The stmmac core supports two interrupt modes, controlled by the
flag STMMAC_FLAG_MULTI_MSI_EN.
- When the flag is set, the driver uses multi-channel IRQ mode (multi-IRQ).
- Otherwise, a single IRQ line is requested:

static int stmmac_request_irq(struct net_device *dev)
{
        /* Request the IRQ lines */
        if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
                ret = stmmac_request_irq_multi_msi(dev);
        else
                ret = stmmac_request_irq_single(dev);
}

At present, only PCI drivers (Intel and Loongson) make use of the multi-IRQ
mode. This concept can be extended to DT-based embedded glue drivers
(dwmac-xxx.c).

This series adds support for reading per-channel IRQs from the DT node and
reuses the existing STMMAC_FLAG_MULTI_MSI_EN flag to enable multi-IRQ
operation in platform drivers.

NXP S32G2/S32G3/S32R SoCs integrate the DWMAC IP with multi-channel
interrupt support. The dwmac-s32.c driver change is provided as an example of
enabling multi-IRQ mode for non-PCI drivers.

An open question remains: should platform drivers support both single-IRQ
and multi-IRQ modes, or should multi-IRQ be required with the DT node
specifying all channel interrupts? The current RFC implementation follows
the latter approach — dwmac-s32 requires IRQs to be defined for all
channels.

So, when the glue driver has set the flag, but the corresponding DT node
has not expanded 'interrupts' property accordingly, the driver init
fails with the following error:

[4.925420] s32-dwmac 4033c000.ethernet eth0: stmmac_request_irq_multi_msi: alloc rx-0  MSI -6 (error: -22)

When correctly set, the assigned IRQs can be visible
in /proc/interrupts:

root@s32g399aevb3:~# grep eth /proc/interrupts
 29:          0          0          0          0          0          0          0          0    GICv3  89 Level     eth0:mac
 30:          0          0          0          0          0          0          0          0    GICv3  91 Level     eth0:rx-0
 31:          0          0          0          0          0          0          0          0    GICv3  93 Level     eth0:rx-1
 32:          0          0          0          0          0          0          0          0    GICv3  95 Level     eth0:rx-2
 33:          0          0          0          0          0          0          0          0    GICv3  97 Level     eth0:rx-3
 34:          0          0          0          0          0          0          0          0    GICv3  99 Level     eth0:rx-4
 35:          0          0          0          0          0          0          0          0    GICv3  90 Level     eth0:tx-0
 36:          0          0          0          0          0          0          0          0    GICv3  92 Level     eth0:tx-1
 37:          0          0          0          0          0          0          0          0    GICv3  94 Level     eth0:tx-2
 38:          0          0          0          0          0          0          0          0    GICv3  96 Level     eth0:tx-3
 39:          0          0          0          0          0          0          0          0    GICv3  98 Level     eth0:tx-4

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
Jan Petrous (OSS) (4):
      net: stmmac: platform: read channels irq
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      arm64: dts: s32: set Ethernet channel irqs
      stmmac: s32: enable multi irqs mode

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 40 +++++++++++++++++++---
 arch/arm64/boot/dts/freescale/s32g2.dtsi           | 24 +++++++++++--
 arch/arm64/boot/dts/freescale/s32g3.dtsi           | 24 +++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 38 +++++++++++++++++++-
 5 files changed, 119 insertions(+), 10 deletions(-)
---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251209-dwmac_multi_irq-9d8f60462cc1

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



