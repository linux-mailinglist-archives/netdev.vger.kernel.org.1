Return-Path: <netdev+bounces-212141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E4B1E5CE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BC17A7078
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DCC26FA6A;
	Fri,  8 Aug 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lQkxiJ7G"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B333234964;
	Fri,  8 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646261; cv=none; b=ha4WcImKcN5J79/JlP4sVobk5c5p4n2iU0GyISQQDbgIQKGiMfBILOb+yh9+wuweBWljBfjvOn/qJU652txoc+SWtukEp9sWvDkzDwHWdLoGW4XHZsfLAvV8zUjpvtAHMN3TjoIQQrRGCwKBWhqQNrPZO5rqjk6MqS3pT735GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646261; c=relaxed/simple;
	bh=6F4MMCjDeOJQTOBiI/kQboYeE8sVAqRfvejXM0WLAGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8IjaOpjd4pPDhuh0DpPe3gdENFkkd60UE3dAgV9s7xmE01zF9c2WuayqXjuZ0NpFLu9r9dOK+18off28sI9rT3rrjA4X2NmyJComCs0BkKrMxp/0xoqrHUF2DHoVlLUoXA27tYiM5IDn+xuXdtAn+voFBH3eENE6FMl2zKfzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lQkxiJ7G; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DCCE225B19;
	Fri,  8 Aug 2025 11:44:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-OBsePsy6H5; Fri,  8 Aug 2025 11:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754646253; bh=6F4MMCjDeOJQTOBiI/kQboYeE8sVAqRfvejXM0WLAGY=;
	h=From:To:Cc:Subject:Date;
	b=lQkxiJ7GL8amk1iNsM0f1VFSXFUbtqeVC9w+I4T/U8Z+AFfrKQQje2rzWNzNiYEah
	 nxgYnsfL6EiaBivK4JdDs0FiOeboMG2FDp6t86MwxqsovXsJje+BJuMKUugHhvLBfl
	 0d41UVPpYU5Cgk5+P7H/0DYtCwUYXwUvhvg4WycX1uCqWT5SR9mYv5uhA/uDM6J05Q
	 vkcMbk/7CxLjkn1A/GE71bEunM9BGStgv70g6R+Slb6uEVuTZDUe5WFQTdfg22YnBk
	 Oj4YEgEAZ+0tbkLaChdnB8q8IvAPHei2yHp3glhPAS91hBxC3VLTZwl1OOUSrqjOpn
	 tRyYcegkOWIbw==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net v3 0/3] Fix broken link with TH1520 GMAC when linkspeed changes
Date: Fri,  8 Aug 2025 09:36:53 +0000
Message-ID: <20250808093655.48074-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's noted that on TH1520 SoC, the GMAC's link becomes broken after
the link speed is changed (for example, running ethtool -s eth0 speed
100 on the peer when negotiated to 1Gbps), but the GMAC could function
normally if the speed is brought back to the initial.

Just like many other SoCs utilizing STMMAC IP, we need to adjust the TX
clock supplying TH1520's GMAC through some SoC-specific glue registers
when linkspeed changes. But it's found that after the full kernel
startup, reading from them results in garbage and writing to them makes
no effect, which is the cause of broken link.

Further testing shows perisys-apb4-hclk must be ungated for normal
access to Th1520 GMAC APB glue registers, which is neither described in
dt-binding nor acquired by the driver.

This series expands the dt-binding of TH1520's GMAC to allow an extra
"APB glue registers interface clock", instructs the driver to acquire
and enable the clock, and finally supplies CLK_PERISYS_APB4_HCLK for
TH1520's GMACs in SoC devicetree.

Changed from v2
- dt-binding: Drop the Tested-by tag
- driver
  - Improve the commit message to mention the dt-compatibility problem
  - Add a comment about the dt-compatibility problem
  - Emit a warning when failed to get APB clock
  - Stop using the optional clock-getting API since it doesn't help much
    when we need to handle the missing case.
- Collect review tags
- Link to v2: https://lore.kernel.org/netdev/20250801091240.46114-1-ziyao@disroot.org/

Changed from v1
- Make apb clock essential in dt-binding
- Collect review tags
- Link to v1: https://lore.kernel.org/all/20250729093734.40132-1-ziyao@disroot.org/

Yao Zi (3):
  dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
  net: stmmac: thead: Get and enable APB clock on initialization
  riscv: dts: thead: Add APB clocks for TH1520 GMACs

 .../devicetree/bindings/net/thead,th1520-gmac.yaml |  6 ++++--
 arch/riscv/boot/dts/thead/th1520.dtsi              | 10 ++++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.50.1


