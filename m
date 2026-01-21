Return-Path: <netdev+bounces-251911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGrYIIHncGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:49:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE258BD1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A0199AEFC7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25848B376;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfOipWvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EF48AE19;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005436; cv=none; b=ZgMHCE1WKZ0NnEaMnzF+Ef2uBa1BWGcM0Oj3ZtQYvrf0zxVBqpElpQEVLhGwe1UOWiKgbFmEg5Rn8ktU9nzvK/RqD0W6zYZe8KjQlKVVdAnZ385WwaNZ5p5hDf6reMRMiWa+wzkIuoLn4Z0laKYdjwVGlWKPvD/oyoIGcs9kT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005436; c=relaxed/simple;
	bh=B5sSQisIlXD4nZ3RrXRQtajYlHIWif9ztQX/M/g69EA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PdYnT9uDFeoiZdpvQYGsNqWpUZ1rRGaobI6d/ZkvQep4J1VqZupLYadDmB4QguYug1IL1cBcnmWWaWT5eJn1KTYEbC9GOXC0IBFjRgkbqJO4A1RDTt+lnD348hWHBnzhRZ7P+a0g6j65S0faJ/ab+6pwTldsamWRaGPcBFSjJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfOipWvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C563C4CEF1;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769005436;
	bh=B5sSQisIlXD4nZ3RrXRQtajYlHIWif9ztQX/M/g69EA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SfOipWvpBWOHqHLsX6uq7KtY0lJsMZxhIllpbnfKPdVysw7RQTfXPdiog2POsOlN1
	 oSqGrNTwVLbhPPJDnjizrnXWEkui6KkySd18r64//lyhIT2NUmhGnu3YENRfjpQ79G
	 FDEdMM9PxMkKOxouyQlV9duFjoBjEZpP5gk41qOSXyvuaKyla4sOjPopWO6S33700D
	 5vqKpo3rI9KlaJ92BmNS2R0BqkdSBHdvftNSw/Czk2r5VFFQH+wq/zewhvgXfyZSJF
	 W30H90NtEiKrI46J0EfQBpRR+GSfIUGgMoA9kpor7Xa1JtiBXapeMYRewiVesH3sWz
	 Ci8P3b/Ti5wHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FDC44502;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Subject: [PATCH RFC v2 0/4] Support multi-channel IRQs in stmmac platform
 drivers
Date: Wed, 21 Jan 2026 15:23:34 +0100
Message-Id: <20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbhcGkC/2WNQQ6CMBREr0L+2pK2QrWuTEw8gFtDCJZWfmIpt
 ogY0rvb4NLlm8m8WSBojzrAIVvA6wkDuj4B32Sguqa/a4JtYuCUl4xTSdq3bVRtX48Ra/RPItu
 9EbQQXCkGaTV4bXBejVe4nE9QpbDDMDr/WV8mtlY/ISv+hBMjlGxFKXhzo1qa3dGFkPfzkCtno
 YoxfgGY+nkStQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769005434; l=2399;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=B5sSQisIlXD4nZ3RrXRQtajYlHIWif9ztQX/M/g69EA=;
 b=pgjYDJ88uMv/4DQOQtw/xXYRyF4ixkVKWEeXizqK7gttm+9hvXWp8ZGRCTrjfTcOhFQNNsezZ
 WZerk30IkCjCBuYFC61kg7HBiw2PtFwLmi7+HeTJX+Y0p2kH0fJkaV1
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251911-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:replyto,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: E4EE258BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stmmac core supports two interrupt modes, controlled by the
flag STMMAC_FLAG_MULTI_MSI_EN:

- When the flag is set, the driver uses multi-channel IRQ mode (Multi-IRQ).
- Otherwise, a single IRQ line is requested (aka MAC-IRQ):

static int stmmac_request_irq(struct net_device *dev)
{
        /* Request the IRQ lines */
        if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
                ret = stmmac_request_irq_multi_msi(dev);
        else
                ret = stmmac_request_irq_single(dev);
}

At present, only PCI drivers (Intel and Loongson) make use of the Multi-IRQ
mode. This concept can be extended to DT-based embedded glue drivers
(dwmac-xxx.c).

This series adds support for reading per-channel IRQs from the DT node and
reuses the existing STMMAC_FLAG_MULTI_MSI_EN flag to enable multi-IRQ
operation in platform drivers.

The final decision if Multi-IRQ gets enabled remains on glue driver
to allow implementing any reguirements/limitions the focused platform
needs.

NXP S32G2/S32G3/S32R SoCs integrate the DWMAC IP with multi-channel
interrupt support. The dwmac-s32.c driver change is provided as an example of
enabling multi-IRQ mode for non-PCI drivers.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
Changes in v2:
- Fixed incorrect buffer len for 'rx-queue-%d' property check
- Added backward compatibility to not break old settings
- Fixed DT example in yaml
- Link to v1: https://lore.kernel.org/r/20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com

---
Jan Petrous (OSS) (4):
      net: stmmac: platform: read channels irq
      dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
      arm64: dts: s32: set Ethernet channel irqs
      stmmac: s32: enable support for Multi-IRQ mode

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 42 +++++++++++++++++++---
 arch/arm64/boot/dts/freescale/s32g2.dtsi           | 26 ++++++++++++--
 arch/arm64/boot/dts/freescale/s32g3.dtsi           | 26 ++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    | 13 ++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 38 +++++++++++++++++++-
 5 files changed, 132 insertions(+), 13 deletions(-)
---
base-commit: cb015814f8b6eebcbb8e46e111d108892c5e6821
change-id: 20251209-dwmac_multi_irq-9d8f60462cc1

Best regards,
-- 
Jan Petrous (OSS) <jan.petrous@oss.nxp.com>



