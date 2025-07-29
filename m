Return-Path: <netdev+bounces-210760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20046B14B6A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6788D1AA44C2
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46F2877E7;
	Tue, 29 Jul 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YKOV7A+C"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31102749E0;
	Tue, 29 Jul 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781892; cv=none; b=tO2SQoswHREsdcZQYb72RIpzkbMGgTZRIV11k1dMs7C+vZSCY+24E59AIRi1zl8WKDco9eNoWkpsLcIlFAazCwXeEZ0MIflPWtUysY+f6whre8TS4Ns2tSLCUU8LhQz4R9VgPk1qT58OpqTKVSKFXOC2pSV8ymREzAQTITWIi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781892; c=relaxed/simple;
	bh=idYgMwrXAP8bE9FQUXKFBglumUQ+kyKP5QsLbZJGvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2PKfhvkRqS3qYBHxde09WTkexSzkgPIMYnpdfzQgHheZQ2uYCmqA/foY0ohvT9OKi2KtocUG5OPqYSe/pWkhGL4RVEw8Pjps/84b2+Urh/XGUms17HkVx+vsYJ0gx57lsI7/CAKvWuqbWGaeZFRQjrqT6ns0+Kcs9PBwnlF82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YKOV7A+C; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D4DA620075;
	Tue, 29 Jul 2025 11:38:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPFN6c7Zk2KY; Tue, 29 Jul 2025 11:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753781880; bh=idYgMwrXAP8bE9FQUXKFBglumUQ+kyKP5QsLbZJGvcs=;
	h=From:To:Cc:Subject:Date;
	b=YKOV7A+CQgSsnr3Lkw7fjDaarr85dBIoXgyhmipyOE/N6lHiDjQjiS4lX3Z414s3X
	 0tmUBBgpkNXMkoW2o0i9yiRhdYHcSyriUYlSumAZ033qD8TBQOHl6Mos11XwgTQuGt
	 vuveUfpsoB3GDsNmJ8+kGP9UbupOShyogZWe7ZrzU5Ri3nMtPYHVdCAhJJG8ihSAfr
	 yp+UqBfJOD9iiPvl5Acl1M12hdSWWIxG7KPMtaMn6bcvXMPvCZqvyWMO3K0avwgPWz
	 1ohH0cyoRHhme71uOrhYKoEAWZxbVVLokmW8Icw0fmh2cqbvOUBxmgjTWofAS6LhSy
	 GSW+/24Pyxzmw==
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
Subject: [PATCH net 0/3] Fix broken link with TH1520 GMAC when linkspeed changes
Date: Tue, 29 Jul 2025 09:37:31 +0000
Message-ID: <20250729093734.40132-1-ziyao@disroot.org>
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

Yao Zi (3):
  dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
  net: stmmac: thead: Get and enable APB clock on initialization
  riscv: dts: thead: Add APB clocks for TH1520 GMACs

 .../devicetree/bindings/net/thead,th1520-gmac.yaml     |  8 ++++++--
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 10 ++++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c      |  6 ++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.50.1


