Return-Path: <netdev+bounces-237539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792EC4CE83
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EB918829EE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC9320CB8;
	Tue, 11 Nov 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Z0/yYO81"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0A3074AA;
	Tue, 11 Nov 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855783; cv=none; b=l80a8/Y4pN1KCHSw7EI4PfxSyvw0U9cyFx5XenzZVTrR8aXxVIq4J9UF9qI6T05bFWYmuruOiQjc4jAKIckXuf1LrBRxznA4Ur2ihJxjctckTch/Yq00voPPPKb+5zDHdDa30OkF1F5oUZZe0jnmQ5/rRSuvzyiZWnXXf2+1RdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855783; c=relaxed/simple;
	bh=x9Skz4QboTPRNwi8Kr6vybv0DsEwdKJC0C+uVQ+zAgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meyW0gn4ki52h5Uq8UWPmy0cNJeGKYkIHJA7OFuF7+x3d4k6/6KTVtLGNDZGk/zxlSJqJX3MDC5Q2GJjFn68OOeH95GMFGfl4kF9Ed1dJmEF22JzGo/a3q8QmQ7l6ciesZO2gao61cOrXNFlUgfKghP2fQNoaq6lyk/se5bkBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Z0/yYO81; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9147220945;
	Tue, 11 Nov 2025 11:09:32 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYskvV9Tp9jo; Tue, 11 Nov 2025 11:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762855771; bh=x9Skz4QboTPRNwi8Kr6vybv0DsEwdKJC0C+uVQ+zAgo=;
	h=From:To:Cc:Subject:Date;
	b=Z0/yYO81gPH91mCxLEOFgHyaLLJfKb3rKRmvgpMT/cgsZF2AdTJ4mCAu2SYQCZ2l8
	 XGxJ7nzMezjoz671GZdkELdKEvkwUGsAISWI5NcDmhVyYRarzZ45YUNTRhH9qqxY8F
	 mloHWoQWw6U5J/pNP40GJAVIQPzuk0tB2zJgFsFc+2Vzd2j8obk2Bnaa9rSPy9LmjV
	 sPpCohlev+z06yX9HhTAAVViA481tY5CTyA/jrm8cVfJoZBQXnhe6vwfHhjB1JDwUI
	 zrc29hDbgdL3q0ja5av/yHO5DO4taSL8V+HbtCM9RZEJUcAxM425Q6/gxMZju7KyXn
	 qyrmJYp4BKMhA==
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
Subject: [PATCH net-next v4 0/3] Unify platform suspend/resume routines for PCI DWMAC glue
Date: Tue, 11 Nov 2025 10:07:25 +0000
Message-ID: <20251111100727.15560-2-ziyao@disroot.org>
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

Changed from v3
- Drop (now) redundant Kconfig depends for DWMAC_LOONGSON and STMMAC_PCI
- Collect review tags
- Link to v3: https://lore.kernel.org/netdev/20251104151647.3125-1-ziyao@disroot.org/

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

 drivers/net/ethernet/stmicro/stmmac/Kconfig   | 16 ++++++-
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++------------
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++------------
 6 files changed, 81 insertions(+), 68 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

-- 
2.51.2


