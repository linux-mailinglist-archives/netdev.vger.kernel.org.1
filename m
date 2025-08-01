Return-Path: <netdev+bounces-211313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF84B17EED
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EB11C25C13
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89313221F06;
	Fri,  1 Aug 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LqSjgKsO"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0449221721;
	Fri,  1 Aug 2025 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039596; cv=none; b=kiXiCYEOIK3mBp+AEdtSEB2dEYJbhuLD1Sm4dIeldRMexm7Z3scgZCjvY7U7wrD+PmZz3tyocbTMDd6VbA2ax3XazC2GYFngkeCWSdrRjRHCv1rkBiPR7mEcZlahV5aTFOcmvJv3vTZx+WVkDLInxt6a8mJC20iaz3EdOlrku6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039596; c=relaxed/simple;
	bh=xPvJxuK/PBmyVvnt/ErP5uEKdZ5kX2qWNjIgNy0PW0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNCRwmzwFZdcmKAfB0bIxn5BufSILT+OiD0mB9yE6vCSlnzilLuXU+xQazTbb1e+DWzCnj8FuiQGrGZds2zno/jIS1FcrQdR+M8hEFjtVacOH9T8SSrFLKFBXeIAFAwNiM2Nit+aKlP4PNYqT6mykLtA3zMOBlMaULdeWAJobHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LqSjgKsO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 864F925DDA;
	Fri,  1 Aug 2025 11:13:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zh-OSYwXA6vo; Fri,  1 Aug 2025 11:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754039584; bh=xPvJxuK/PBmyVvnt/ErP5uEKdZ5kX2qWNjIgNy0PW0E=;
	h=From:To:Cc:Subject:Date;
	b=LqSjgKsOjo4AMSSRXfragXwK70JyXgtsFbKFcJQhbLaKQR993L2JPqYOdNntEEX5G
	 dd5tmYAMtqbzd3H7pfUsuut80Zpq5rh0slJ1xNGd9ikw3hqBNIhac335qog7LI7385
	 KyiNA/0PEN7QJuhHzungsu5HeN+8nqh77nXdV3aBPT4Y4M0mWsZ9G8y1VJ/UViQ2G5
	 PAct65VfEAPQ8eqt4xf9LTfl8dOygzP/Z64hY2NtSs3vjHVCm6TgdCSG8XnZ8U3KTZ
	 ni0gJC6G9jlLSMHdh7LzZIveL7ChzAGu9UDo9TibbFsqpZZnOVksVEDG1oohv8Egzh
	 +EWMYjEL5lCVg==
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
Subject: [PATCH net v2 0/3] Fix broken link with TH1520 GMAC when linkspeed changes
Date: Fri,  1 Aug 2025 09:12:37 +0000
Message-ID: <20250801091240.46114-1-ziyao@disroot.org>
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

Changed from v1
- Make apb clock essential in dt-binding
- Collect review tags
- Link to v1: https://lore.kernel.org/all/20250729093734.40132-1-ziyao@disroot.org/

Yao Zi (3):
  dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
  net: stmmac: thead: Get and enable APB clock on initialization
  riscv: dts: thead: Add APB clocks for TH1520 GMACs

 .../devicetree/bindings/net/thead,th1520-gmac.yaml     |  6 ++++--
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 10 ++++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c      |  6 ++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.50.1


