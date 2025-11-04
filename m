Return-Path: <netdev+bounces-235521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD7C31D54
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF4844E2AD9
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DAA24A069;
	Tue,  4 Nov 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UmYUdIxw"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CF215F42;
	Tue,  4 Nov 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269842; cv=none; b=KmLP72WGULJ3G0SYe0BnXzkJc/dpfAHWqbTiY326LcImgRWcWLLWNwKbIluD55aB9ksWPagPtDkobMcdueL73Tg6imBQjcjoCG7dPnjE/dzPrST9Vbv1CkcPr+akdsUlMO+Bjh5X+OIEnPhDiW09bLu2yqbpFG3iHFXm75gujI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269842; c=relaxed/simple;
	bh=i6yZQgYEzBAnE5YGZ2Am83L5vFKe8Mk/y5uubB3v5Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TC87gsIYV1uQHXQiLDJPegRKSiBMy/VeyDdDj4CmLaPGJ7EyBbtikjBb/fYwHrR7Kls43LuUreay+VvzytDE4Kbd2t+aqP8zv+zZrwwcvSvfA0WFynHPUvO88+tMomB8KeQ4pOrXRj8wLilpztHH58MFCt96752nmyxFS9CjDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UmYUdIxw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2A2C620D7F;
	Tue,  4 Nov 2025 16:17:11 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSM0mJ7iStq5; Tue,  4 Nov 2025 16:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762269430; bh=i6yZQgYEzBAnE5YGZ2Am83L5vFKe8Mk/y5uubB3v5Wg=;
	h=From:To:Cc:Subject:Date;
	b=UmYUdIxwnXcnCaZzz8fVpf7F2c+siUXRErNT7d2Mknf8wE++4qtHCZ4yEUd6KqFul
	 LKA6MC9mM9FWRLGvMP5rqI9BGQWlhNEMMnvxwlF04U0cOk4qxQlEBbs8Io+aemf7Y/
	 u+GLxvFBj+tvOW2GOjWSFKtBKb5BglKUkL9Q9GyhgmCl8ATeVH60D0PNvl3o0B1eNU
	 5mLy25M7/dTaJU+Me+tAeYCShvDm6JUbIbo0paH7zdXdt4/CJnD5JNbmeM+JfFo3ga
	 CwkNkmdQfQDDCokuFujEeOMmBXOj8+8BH69b+yDOO0nujdPcmn25R4QJnAZkyy/fnj
	 xlQB00cRY/rUg==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] Unify platform suspend/resume routines for PCI DWMAC glue
Date: Tue,  4 Nov 2025 15:16:44 +0000
Message-ID: <20251104151647.3125-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently three PCI-based DWMAC glue drivers in tree,
stmmac_pci.c, dwmac-intel.c, and dwmac-loongson.c. Both stmmac_pci.c and
dwmac-intel.c implements the same and duplicated platform suspend/resume
routines.

This series introduces a new PCI helper library, stmmac_libpci.c,
providing a pair of helpers, stmmac_pci_plat_{suspend,resume}, and
replaces the driver-specific implementation with the helpers to reduce
code duplication. The helper will also simplify the Motorcomm DWMAC glue
driver which I'm working on.

The glue driver for Intel controllers isn't covered by the series, since
its suspend routine doesn't call pci_disable_device() and thus is a
little different from the new generic helpers.

I only have Loongson hardware on hand, thus the series is only tested on
Loongson 3A5000 machine. I could confirm the controller works after
resume, and WoL works as expected. This shouldn't break stmmac_pci.c,
either, since the new helpers have the exactly same code as the old
driver-specific suspend/resume hooks.

Changed from v2
- Drop unnecessary "depends on STMMAC_ETH" from STMMAC_LIBPCI
- Enclose DWMAC_LOONGSON and STMMAC_PCI within "if STMMAC_LIBPCI",
  instead of depends on the option.
- Link to v2: https://lore.kernel.org/netdev/20251030041916.19905-1-ziyao@disroot.org/

Changed from v1
- Separate the new suspend/resume helpers into a new file,
  stmmac_libpci.c, and provide Kconfig symbol for it
- Link to v1: https://lore.kernel.org/netdev/20251028154332.59118-1-ziyao@disroot.org/

Yao Zi (3):
  net: stmmac: Add generic suspend/resume helper for PCI-based
    controllers
  net: stmmac: loongson: Use generic PCI suspend/resume routines
  net: stmmac: pci: Use generic PCI suspend/resume routines

 drivers/net/ethernet/stmicro/stmmac/Kconfig   | 13 +++++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++------------
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++------------
 6 files changed, 80 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

-- 
2.51.2


