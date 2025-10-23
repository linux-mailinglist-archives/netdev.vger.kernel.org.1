Return-Path: <netdev+bounces-232078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03737C00A58
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3B33359D16
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C630C344;
	Thu, 23 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jxOik2Id"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167A3043CF;
	Thu, 23 Oct 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217955; cv=none; b=EMsYilVpGV4wctT2pGgnqgcjRl23+4sgOszGkwb3xLgOjVIIlGQ68MZB5QkcqJ2UDA3IscfvFdRK90lVgRU/y4kKJ9iZJrp3hVFgL5O7vsX5QoK101SquXdVl3gG4c3LQteBjNMDpqpCtqvk7vzUFbhKq2xwbaKb6SyWWUSDp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217955; c=relaxed/simple;
	bh=3hMBp/p5x9ot2ZSFNPVVvO9OLUVbZmrsFWygF2FKnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTgV0IzDyQVcneVBRvCaXYBtVe5fbJtOEwmiS2Fc4RcLUN7bQ3T+tfDNX69+F7rtIr48fmh+r2oP4TKXTLutKs25of33Ge6mD8GaWm8q+4undbjnieixKcoDc1Y3c+OzvGXnD+XPmEkXfFVnEfIjKxxw5r0P3kFYCeJepyJMsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jxOik2Id; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=QzLW9awd3vNvuf8W7Wp9CCWT/0H8mh0rC8ZP1OwiNJU=; b=jxOik2Iddy1l8boel5Qj+SovlW
	6L6KHxuhcFY2dxzF7oicpue7dI65N9ujwppKiB3/W0f3xtbBqIBF0PeBWNMYzhUUPNgjoKznsV2Dt
	0evKfS5WcJ0LCf03+3teWCAwRsE35awUPn1mZu2ZpmyX3WM6iTce+PmAuiEWtj0Sr7PXjS/8djHqW
	ZLq6LrMZlxHsYWLkVFPT8viBpmojhaQ7OLf9d8WmxsSpIozsEA6A2DW5zrUhIguxi9FWUR6F/3mg0
	QPu4gfq1My/HFAmssnRBaG5e0I3+tJAfzGJoExZTw8D981mchzsU6UWkppPGf4qMLYPHWaVCgMVrb
	yi68s4+g==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEt-0002w5-NZ; Thu, 23 Oct 2025 13:12:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se
Subject: [PATCH v2 0/5] DWMAC support for Rockchip RK3506
Date: Thu, 23 Oct 2025 13:12:07 +0200
Message-ID: <20251023111213.298860-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cleanups to the DT binding for Rockchip variants of the dwmac
and adding the RK3506 support on top.

As well as the driver-glue needed for setting up the correct RMII
speed seitings.

changes in v2:
- add Conor's Acks to dt-bindings
- add Andrew's Reviews to first 3 patches
  I didn't add the driver Review, as I did address Jonas' comments
- adapt to Jonas' comments in the driver
- add a patch for a MAINTAINERS entry (Jakub)


David Wu (1):
  ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support

Heiko Stuebner (4):
  dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
  dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
  dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506
  MAINTAINERS: add dwmac-rk glue driver to the main Rockchip entry

 .../bindings/net/rockchip-dwmac.yaml          |  3 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |  6 +-
 MAINTAINERS                                   |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 64 +++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.47.2


