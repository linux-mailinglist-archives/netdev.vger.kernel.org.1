Return-Path: <netdev+bounces-241201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD8BC817B4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4461E3465F4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15277314B78;
	Mon, 24 Nov 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aSoAQ13T"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02D314A97;
	Mon, 24 Nov 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000293; cv=none; b=FxU/IbO2AwHc/OoX7GXNrWKglRuxwWQkTuAqiIJ9EEeq24cytjOhQ2ZJow0CER60UVN9z5Y4fVJfh3SVwWTYejnXs2tdxIToup/sbvVd+zAsV8dncNYTeAj5IwXUB1h2CMPRthAMIBiw+dQaMjzmgLxdhMBWyQK8L+6mHryxGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000293; c=relaxed/simple;
	bh=HYHm0pewJmm2CgAXTGPrpKYki/YRlZM6tufmDtbvECw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSEk18dsTH4nLuUfJGxUzxicpCVEBRXmC+irTEov8hOTSYNHa1IEJ6lzw6y4GMxKEECMawFnMc3bLIVN9msAgG4lL4PKlR1mYXt7MXBcZ7jN8g1uMpdcTnIDg4AJlc0naGYvFPZMsxMFitzg6JXD0VLr7swyRbrRXhtu2V/G8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aSoAQ13T; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2899F25D8B;
	Mon, 24 Nov 2025 17:04:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktKX2exUFH_q; Mon, 24 Nov 2025 17:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764000280; bh=HYHm0pewJmm2CgAXTGPrpKYki/YRlZM6tufmDtbvECw=;
	h=From:To:Cc:Subject:Date;
	b=aSoAQ13T+k40ZmCQmIhkNnqOMu5dFgHxSaRDMc5pm+nLoMmM0GF3OO/MyMAJt5evj
	 vjrrn6vjgP/OWCd7AvMBhFaD0YPbNvEni8EAdyFiEpcqjv2Mg0ohbvt7eLjTv3hMPs
	 S/piRsJFsmisUUb4ykr+5PnH87ykRCWg0hPpR5Oq0lvu/y4MTHrmfHmCd7EiJn5KEH
	 6pnfH5BzcOwDKW+WhAqWD2aUJNSIp/m8Ir3z9Tr6IHlAOqs4TYa3jbhW5rhTNL9WwF
	 yWHpg6SnhYy53bRx1ehyb8Z9nIlaDGrejbwOj5haYIEuocoIAcwMNW8QnrPU3BlNQz
	 3jMJVJd4J5FRA==
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
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH net-next v5 0/3] Unify platform suspend/resume routines for PCI DWMAC glue
Date: Mon, 24 Nov 2025 16:04:14 +0000
Message-ID: <20251124160417.51514-1-ziyao@disroot.org>
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

Changed from v4
- Hide STMMAC_LIBPCI. drop default y and dependency to PCI
- Select STMMAC_LIBPCI instead of depending on it in glue symbols
- Bring "depends on PCI" back to glue symbols, reverting part of change
  in v4
- Link to v4: https://lore.kernel.org/netdev/20251111100727.15560-2-ziyao@disroot.org/

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

 drivers/net/ethernet/stmicro/stmmac/Kconfig   | 11 ++++-
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++------------
 .../ethernet/stmicro/stmmac/stmmac_libpci.c   | 48 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_libpci.h   | 12 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 36 ++------------
 6 files changed, 76 insertions(+), 68 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_libpci.h

-- 
2.51.2


