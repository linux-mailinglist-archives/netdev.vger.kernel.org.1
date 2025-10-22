Return-Path: <netdev+bounces-231564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5FBFA9BE
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87ACA34598B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAFC2FB62C;
	Wed, 22 Oct 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vkCHCsnZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FA2FB09E;
	Wed, 22 Oct 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118721; cv=none; b=JbyG1RlLvbBiwCCge8DB+yaAmvWk2el+igfIPB7o8vvG5bQYWzqKU2X0ubJPkTs3jyiwwlIyWTL/nu8H+0F2gtFljYlBZYgQP0G7JPidPsa1FA5jbLV5qrNYdmPbY3ZF1Hj3wCx+DLxikDl1D/JR9yF9WsSyVWw0LWnLYRI1OQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118721; c=relaxed/simple;
	bh=fEc/ZWEpPt1tUfU52P+K+EeBWDiHXPIPf98V6FgFyeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tnhZygCjYvleSvYlYvXST1eaLhcEz9KYOq36k+ZbRLh9Waer0XEKG9z56R8xoCWcWHWJZZ+NOdFugTGstV7txYR7UEC+dy5OYb+SdFoH0ZAO42uH6AptHltD2lThRm3eeU5aOoHvZzFLSZLr/gHJFhuj96xxUoRIsH+oTEHg4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vkCHCsnZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 49EADC0B8B7;
	Wed, 22 Oct 2025 07:38:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB4A2606DC;
	Wed, 22 Oct 2025 07:38:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CF2F102F2426;
	Wed, 22 Oct 2025 09:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118713; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Cnq8is3Gecu3RIKhzK0SA/syO2DgLWXh6Z3YQxQFw9I=;
	b=vkCHCsnZsPWgWOAsSXRFZ+6iJL341OQwkiKRLqzhjXaT2D2nVElyNKwPuObmBjs32Ab4VH
	gwUqDzOTxnXVSHOmyed0VYT1l5NptBKIq8iFp1JT02tql//R8VaZ1Fw3agKWUSXRQLQ+ar
	CKup/WOKZa31aHkkveOx57Q8yydSkoOPVk0IcIppQK/tl1Sox9tcirNZN5fC4LnfEv13yI
	y5bPVI2w6zqGTl8Q0Z1ds1eNDsLlevklrUpBaBlbUdcYJs6SEB6Da4raLoA0X4va8IbeWW
	kc+Hx50ydnPiMfNmjZeUF6Dzb4mzOEOEQw8h9hfLF71Va94KuTGnsFaXfTtF/g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 0/5] net: macb: EyeQ5 support
Date: Wed, 22 Oct 2025 09:38:09 +0200
Message-Id: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOGJ+GgC/02NywrDIBBFfyXMulPUIn2s+h8li6iTZqDRViUkB
 P+9Il10eTjcc3dIFJkS3LodIi2cOPgK6tCBnQb/JGRXGZRQWgolcB6sQdroo3EkZYWT5OxZQx2
 8I428ttgDPGX0tGboq5k45RC39rLI5n9B+R9cJAo8GWH0cHVqvOi7CSG/2B9tmKEvpXwBFxpQC
 rAAAAA=
X-Change-ID: 20251020-macb-eyeq5-fe2c0d1edc75
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This series' goal is adding support to the MACB driver for EyeQ5 GEM.
The specifics for this compatible are:

 - HW cannot add dummy bytes at the start of IP packets for alignment
   purposes. The behavior can be detected using DCFG6 so it isn't
   attached to compatible data.

 - The hardware LSO/TSO is known to be buggy: add a compatible
   capability flag to force disable it.

 - At init, we have to wiggle two syscon registers that configure the
   PHY integration.

   In past attempts [0] we did it in macb_config->init() using a syscon
   regmap. That was far from ideal so now a generic PHY driver
   abstracts that away. We reuse the bp->sgmii_phy field used by some
   compatibles.

   We have to add a phy_set_mode() call as the PHY power on sequence
   depends on whether we do RGMII or SGMII.

This V2 sees the generic PHY driver drivers/phy/phy-eyeq5-eth.c move
into its separate series. Here you only get net-next patches.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-15-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Drop non net-next patches.
- Re-run get_maintainers.pl to shorten the To/Cc list.
- Rebase upon latest net-next; no changes. Tested on HW.
- Link to v1: https://lore.kernel.org/r/20251021-macb-eyeq5-v1-0-3b0b5a9d2f85@bootlin.com

Past versions of the MACB EyeQ5 patches:
 - March 2025: [PATCH net-next 00/13] Support the Cadence MACB/GEM
   instances on Mobileye EyeQ5 SoCs
   https://lore.kernel.org/lkml/20250321-macb-v1-0-537b7e37971d@bootlin.com/
 - June 2025: [PATCH net-next v2 00/18] Support the Cadence MACB/GEM
   instances on Mobileye EyeQ5 SoCs
   https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/
 - August 2025: [PATCH net v3 00/16] net: macb: various fixes & cleanup
   https://lore.kernel.org/lkml/20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com/

---
Théo Lebrun (5):
      dt-bindings: net: cdns,macb: add Mobileye EyeQ5 ethernet interface
      net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
      net: macb: add no LSO capability (MACB_CAPS_NO_LSO)
      net: macb: rename bp->sgmii_phy field to bp->phy
      net: macb: Add "mobileye,eyeq5-gem" compatible

 .../devicetree/bindings/net/cdns,macb.yaml         | 10 +++
 drivers/net/ethernet/cadence/macb.h                |  6 +-
 drivers/net/ethernet/cadence/macb_main.c           | 92 +++++++++++++++++-----
 3 files changed, 89 insertions(+), 19 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20251020-macb-eyeq5-fe2c0d1edc75

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


