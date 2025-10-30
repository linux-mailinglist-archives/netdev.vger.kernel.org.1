Return-Path: <netdev+bounces-234266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E450C1E570
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD064E31CB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D243E2C21E8;
	Thu, 30 Oct 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="md4utgx4"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167042D6E55;
	Thu, 30 Oct 2025 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798017; cv=none; b=bRY+s0uFV25gwTEcf6kU1YNXb5fxWs8RO62pzJjkuD3U+r/sbl6DwUNoUDo0fjAoqULimtrUzxdMpVb1D9caMGdjhvsUg443mcDmhClpqzbZngk/NJ+xI5/X0MYQWngpr81H84Y/8WNeYNka1DqO9vVYA4FfHHF6u5t3IjFWbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798017; c=relaxed/simple;
	bh=hV448ChgCdUoMa/v6uhDkZ90o1f6aR5lnXQer4rLYLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDiobD/PrnEdZX28IeyPYX5ca3I+c5Cna3N7l9Hu3gNXX8sIWm6dVFzSo7BiW8k/EH7v+gyF3Lr0VqmMS44J/yGVnnSk/XeihRVI9hcFCu2iIi6/rG+NWHOdqG6d0ZDNCOaYwR3s41mlmoToVw798g6agrBSVJzAcoX9uw91LYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=md4utgx4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1748225DC2;
	Thu, 30 Oct 2025 05:20:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ir6IfV8ydrbA; Thu, 30 Oct 2025 05:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761798013; bh=hV448ChgCdUoMa/v6uhDkZ90o1f6aR5lnXQer4rLYLQ=;
	h=From:To:Cc:Subject:Date;
	b=md4utgx4dAmi5a5n2MiEdaoJbFpZLDRuWVMUdKG4m+jLZasnULlA8sQxQjOZ2NX42
	 IBxl8gwLo+Zm9DohTjppZC4zkk4InqLSL/QrfkmqnltLLtlcxOqC0DW6FDBxN9EAz/
	 sgo1andce6WIA59G8v6lHT3fcTcx9JPdaCTIDPUjYcpPOos3SeWVnxiLQA8u0YIufy
	 9Hfgq0deZv+P+G/wYyJCM8uCDo8Ev4LzMMUTRo9CIZJH43FsPLEjL3k8Dst2nE7XNR
	 TaTCT67l/ijx5uS5sgNc/9rvdVs3wNHFFF6mypt9WmSxCWSXIRyJ6ne5fSc8FnLfLZ
	 eOBSb6ycxbyKA==
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
Subject: [PATCH net-next v2 0/3] Unify platform suspend/resume routines for PCI DWMAC glue
Date: Thu, 30 Oct 2025 04:19:13 +0000
Message-ID: <20251030041916.19905-1-ziyao@disroot.org>
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

Changed from v1
- Separate the new suspend/resume helpers into a new file,
  stmmac_libpci.c, and provide Kconfig symbol for it
- Link to v1: https://lore.kernel.org/netdev/20251028154332.59118-1-ziyao@disroot.org/

Yao Zi (3):
  net: stmmac: Add generic suspend/resume helper for PCI-based
    controllers
  net: stmmac: loongson: Use generic PCI suspend/resume routines
  net: stmmac: pci: Use generic PCI suspend/resume routines

 drivers/net/ethernet/stmicro/stmmac/Kconfig   | 11 +++++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++------------
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++------------
 6 files changed, 78 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

-- 
2.51.2


