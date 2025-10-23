Return-Path: <netdev+bounces-232196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0281C026D4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD221AA080F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD502D29C7;
	Thu, 23 Oct 2025 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EDP40gmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949A2D29D7
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236599; cv=none; b=eLwHRxQe9hgyp27vxNbSevrTBXZkwsXYcnGnOHmhsVSzEkjlXnQVdTxOzizE8LJUAZjV7eg3Qyzj1IUj019nH2mGctedk/TctD3mFlVA8q3+fCw3IpEbF6h7zGQHQ35jb4msLvgYgHbOr5JM6u4Ckqe5eMgrBFRt0PwswJ/JqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236599; c=relaxed/simple;
	bh=boDCr8o4nYpDUsW+QPdNHJ7z4OGjq/xQiMTajz+UlYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B6d2lkX4Pi1Gv5cHjDqKcYZD9/NoUsqy95hYue2JgXY5roeMVIUKJtsD/kOK54o24tUFr16T31XWrSSnVcBC+Yi6xYEQ0f5seGZCUBOcE7Emy+tCcf0AEpPg8NNfKfse979C3CNGdCjS25XEvhwZTa1wTvnjRUdtULFQvhxUJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EDP40gmf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7543A1A1617;
	Thu, 23 Oct 2025 16:23:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F0D2606DE;
	Thu, 23 Oct 2025 16:23:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE826102F2468;
	Thu, 23 Oct 2025 18:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761236592; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4xuFTBVTRmNlPbjj2Bd6ZXhk306KnjA+Do0Ps3aeXSE=;
	b=EDP40gmfd+ogUo3DOysQ3BdsBXkRyutAZS2B1m/eA4iWWXSeSh6WZpybxVpUBzPv7c1eF2
	UYkoKPSuAUIWVhZcuG0Acj8CkWPiyNYcf+ZQH926lDGnAjLyOLKBH4k9LAYjeYiNM/4JKi
	lzUicd8Cu6r+ps4cE6/MsUO4Mikm35px8PAyujNdF+b3XXRscei4XlWp89qtEIgVC0FrqO
	eLEC98NodhZWWyvIT82t+blZ+hZWZevdWY8+lD3cGmF0ceKasYXioBCS2HmwW8yCNhQJxc
	VX4j/OFQTE1e3dSU+3wF0nZ1XoMTSkAKAPfT7LayKxFhZg3NzFTPPT0EO562aQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v3 0/5] net: macb: EyeQ5 support
Date: Thu, 23 Oct 2025 18:22:50 +0200
Message-Id: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFpW+mgC/1WNywrDIBQFfyW4ruVqKkm76n+ULnzcNEKjrYokh
 Px7RbpIlsNh5qwkYrAYya1ZScBso/WuQHtqiB6leyG1pjDhwAUDDnSSWlFc8CvogFyDYWh0J0g
 RPgEHO9fYgzhM1OGcyLMso43Jh6W+ZFb3f5Dtg5lRoK0CJeTV8KEXd+V9elt31n6qocz3Mj/Iv
 MidZheQSoHo2VHetu0HJ/ko0O0AAAA=
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
 Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor.dooley@microchip.com>
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

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-15-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v3:
- Drop Fixes: trailer on [2/5]. We don't fix any platform using the
  driver currently.
- Improve [5/5] commit message; add info about how an unconditional
  phy_set_mode_ext() won't break existing platforms.
- Hardbreak 82 characters line in [2/5]; warning by patchwork.
- Trailers:
  - 1x Acked-by: Conor Dooley on [1/5].
  - 2x Reviewed-by: Andrew Lunn on [1/5] and [4/5].
  - 2x Reviewed-by: Maxime Chevallier on [4/5] and [5/5].
- Link to v2: https://lore.kernel.org/r/20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com

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
 drivers/net/ethernet/cadence/macb_main.c           | 94 +++++++++++++++++-----
 3 files changed, 91 insertions(+), 19 deletions(-)
---
base-commit: 61b7ade9ba8c3b16867e25411b5f7cf1abe35879
change-id: 20251020-macb-eyeq5-fe2c0d1edc75

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


