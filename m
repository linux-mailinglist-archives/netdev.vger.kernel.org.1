Return-Path: <netdev+bounces-153918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2D9FA104
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C96166B40
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456F41F4726;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Ogu5ij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128825949C
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=AmqgcedrDpxUfgujX21P0eCbNw3fPjkpOyLcILdx/eGakf8SVUczfBbmxkzWY1xsAHgUM2HU8UqzhwxcvdQFbvoTrwTrnKPzcs1c26A5FoXzlmwJfQt0V4+0GMy9/VNvm9UTv3J2zxE4Nac5/M05KDnHDZCCHubHJi/cjnXkV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=WNV7VzPZ8IYtkgzuWUpSuVQulrCqx6cTlAD0PaHvaVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TA/sR8hLmu0ujOhCVWXz6vWexliD+Ke/PpMUX7lSADfgOQzD21vS72NNWf473xTl/BZS2JG7my4C0+vMWpdShexb1LmddsuunNn7cGLLocotnC3bVJPomEi9L7m3ihrQbr7cUhKvXOhxonICcXwLk17C15OK47CKa4N3PkQwd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Ogu5ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88827C4CECE;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792252;
	bh=WNV7VzPZ8IYtkgzuWUpSuVQulrCqx6cTlAD0PaHvaVQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q2Ogu5ijAx0Kf84EWH3p/5G2dTYVo9mPzUVTl9V8mONVDb/MwubkDCqCjP9HxAAvw
	 0gUbZciG2FyFNbJru4yPhUA8Lm9llFvZrohnvEnk1ZSXAlLFVCFGLGdUAPCbbEv8aG
	 M6bY8uo1CxQ/us4FZ48YeJn0bT+gmYs11HG8xmzuVfduakrKT7yXZJWZ8ZpztvniVh
	 DfTVDGMaTavWldjnGSp00p1PwT4d+u5xX/f/2iM1waY5TSoxNfzsxl+HoPUN/KBm3k
	 H8aUTprdKVm+O+FRa3Y6U463pRGJMkkjpVinhT057Htf7xoxLj4m7PXCeHSU21M+CK
	 9ktpFC21itaog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71952E77184;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Subject: [PATCH net-next v4 0/7] net: tn40xx: add support for AQR105 based
 cards
Date: Sat, 21 Dec 2024 15:43:35 +0100
Message-Id: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfUZmcC/02NwQ6DIBAFf8XsudsAKrU99T8aD4iLchAbIITG+
 O9F00OPLy8zs0EgbynAo9rAU7LBrq6M5lKBnpWbCO1YNggmGi64xOjuLWeYaoVCG827dpQdM1C
 Atydj8yl7gaOIjnKEvjyDCoSDV07Ph2xR1h3AbENc/eeMp/rEfp3bfyfVyLAZWzLSyE4Se05Lv
 pYA9Pu+fwEkONhuwwAAAA==
X-Change-ID: 20241216-tn9510-v3a-2cfc185d680f
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=3890;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=WNV7VzPZ8IYtkgzuWUpSuVQulrCqx6cTlAD0PaHvaVQ=;
 b=YqIIdHSNqjf1BaCxIeg6aMOn04ua42yFiNZ6h/tGBE2EB5OWgDdDqnSy/lhqqUn4neWWq+yT5
 CYfgxbBevOsCzu2JAvtJJoh9Gug0xvDA4r5L2+HeJRoMQ6Mklf4GOzG
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
which combine a TN4010 MAC with an Aquantia AQR105.
It is an update of the patch series "net: tn40xx: add support for AQR105
based cards", addressing review comments and generally cleaning up the series.

The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).

Changes v1 -> v2:
- simplify the check for a firmware-name in a swnode in the aquantia PHY driver
(comment from Andrew Lunn)
- changed the software node definition to an mdio node with phy child nodes, to
be more in line with a typical device tree definition (also comment from
Andrew Lunn)
This also solves the problem with several TN4010-based cards that FUJITA
Tomonori reported
- clarified the cleanup calls, now calling fwnode_handle_put instead of
software_node_unregister (comment by FUJITA Tomonori)
- updated the function mdiobus_scan to support swnodes (following hint of
Andrew Lunn)
- remove the small patch to avoid failing after aqr_wait_reset_complete, now
that a proper patch by Vladimir Oltean is available
- replace setting of bit 3 in TN40_REG_MDIO_CMD_STAT by calling of
tn40_mdio_set_speed (suggestion by FUJITA Tomonori)
- cleaning up the distributed calls to set the MDIO speed in the tn40xx driver
- define supported PCI-IDs including subvendor IDs to prevent loading on
unsupported card
- Link to v1: https://lore.kernel.org/netdev/trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc2-1726082106356@3c-app-gmx-bs04/

Changes v2 -> v3:
- aquantia_firmware: remove call to of_property_read_string. It should be
  called from the more generic function device_property_read_string
- add more AQR105-specific function, to support proper advertising and auto-
  negotiation
- re-organize the patches about the mdio speed and TN40_REG_MDIO_CMD_STAT,
  skipping the 1MHz intermediate speed step
- re-organized the sequence of the patches:
    1. changes to the general support functions (net/phy/mdio_bus.c)
    2. changes to the aquantia PHY driver
    3. changes to the tn40xx MAC driver, required to support the TN9510 cards
- Link to v2: https://lore.kernel.org/netdev/trinity-602c050f-bc76-4557-9824-252b0de48659-1726429697171@3c-app-gmx-bap07/

---
Changes in v4:
- use separate aqr105 specific functions instead of adding aqr105 functionality
  in common functions, with need of "chip generation" parameter
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- make generation and cleanup of swnodes more symmetric
  (suggested by Andrew Lunn <andrew@lunn.ch>)
- add MDIO/PHY software nodes only for devices that have an aqr105 PHY
  (suggested by FUJITA Tomonori <fujita.tomonori@gmail.com>)
- Link to v3: https://lore.kernel.org/r/20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net

---
Hans-Frieder Vogt (7):
      net: phy: Add swnode support to mdiobus_scan
      net: phy: aquantia: add probe function to aqr105 for firmware loading
      net: phy: aquantia: search for firmware-name in fwnode
      net: phy: aquantia: add essential functions to aqr105 driver
      net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus
      net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
      net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards

 drivers/net/ethernet/tehuti/tn40.c           |   9 +-
 drivers/net/ethernet/tehuti/tn40.h           |  31 ++++
 drivers/net/ethernet/tehuti/tn40_mdio.c      |  80 ++++++++-
 drivers/net/phy/aquantia/aquantia_firmware.c |   7 +-
 drivers/net/phy/aquantia/aquantia_main.c     | 243 ++++++++++++++++++++++++++-
 drivers/net/phy/mdio_bus.c                   |  14 ++
 6 files changed, 375 insertions(+), 9 deletions(-)
---
base-commit: 860dbab69ad8d07a91117ed9c9eb5fb64adf7e0e
change-id: 20241216-tn9510-v3a-2cfc185d680f

Best regards,
-- 
Hans-Frieder Vogt <hfdevel@gmx.net>



