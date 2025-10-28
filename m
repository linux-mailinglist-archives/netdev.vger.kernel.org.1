Return-Path: <netdev+bounces-233567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC242C1598B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A2C1C224AE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49D33DEE6;
	Tue, 28 Oct 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aHV+A+wZ"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47420255248;
	Tue, 28 Oct 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666257; cv=none; b=C8gA0ccLAALkC1aZ8R4QxafcBaWLcitLeS484+zSw1re7D22FVzOql/BGHc7CwJwBaJLIlLkPueQ2us43vBw12bXk6WzEDxJVRvDYm6PiCGMtfU/mwX2D0uU8nvyhYVGEMXF9F+mW9mJJULc4CeVM8T5DBJ9Z/X04s2quobm6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666257; c=relaxed/simple;
	bh=h1EqEdosEVXM/Wjqw2eF9qs7x/LxS9suQpaADDGEg+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKD0scKmDeJkjwVMLHW4HJUhSDiGbwv5nZHlmEWbWyryEPHwdVTRI+w/b64fUfn9hXrsT5M/emmQkFZTRid26uILF2sk0kY4YRGzPZAkoOyUcvjE7HiubF1vMke+XAGtsq7Oediby0G7Nf/dOiU3mQF/HS3efitBzv4L4VoEJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aHV+A+wZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AECB025DC2;
	Tue, 28 Oct 2025 16:44:13 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vuips1VY5t7x; Tue, 28 Oct 2025 16:44:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761666253; bh=h1EqEdosEVXM/Wjqw2eF9qs7x/LxS9suQpaADDGEg+0=;
	h=From:To:Cc:Subject:Date;
	b=aHV+A+wZStl2JgKEq/qb9gBM1K7pFXlAIec+39LRSF4S+D6UJEVHY32XZUKsYyMnS
	 V42sXB+z5AliANOVj+A+9HWbMSYwaUvgg8hsBd+bFah+AtyB8+kowIxWQvceDhytSn
	 B+Qz7UlaHmeGmdryqeiHLnOMK3jIYTLU90M9tXzwzhvnCA/iZLiszK7d83jHDOgZER
	 dxFjgfUY+f1b9/OUfw0aPdF7iuPDnBG0BbU1Lkd0KZLmFccxshjZvB+Bet+xugd730
	 TgtUW1xD8eG0Atm8hjrCwvnsGDbgr6dSLCZ4QGM25zeNR8rBf2oFA4Wk8d1PJOoBiR
	 rSUQFrhBCcDrw==
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
Subject: [PATCH net-next 0/3] Unify platform suspend/resume routines for PCI DWMAC glue
Date: Tue, 28 Oct 2025 15:43:29 +0000
Message-ID: <20251028154332.59118-1-ziyao@disroot.org>
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

This series introduces a pair of helpers,
stmmac_pci_plat_{suspend,resume}, and replaces the driver-specific
implementation with the helpers to reduce code duplication. The helper
will also work for the Motorcomm DWMAC glue driver which I'm working on.

The glue driver for Intel controllers isn't covered by the series, since
its suspend routine doesn't call pci_disable_device() and thus is a
little different from the new generic helpers.

I only have Loongson hardware on hand, thus the series is only tested on
Loongson 3A5000 machine. I could confirm the controller works after
resume, and WoL works as expected. This shouldn't break stmmac_pci.c,
either, since the new helpers have the exactly same code as the old
driver-specific suspend/resume hooks.

Yao Zi (3):
  net: stmmac: Add generic suspend/resume helper for PCI-based
    controllers
  net: stmmac: loongson: Use generic PCI suspend/resume routines
  net: stmmac: pci: Use generic PCI suspend/resume routines

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 35 +-----------------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 35 +-----------------
 4 files changed, 43 insertions(+), 66 deletions(-)

-- 
2.50.1


