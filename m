Return-Path: <netdev+bounces-247457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA8CFAEC7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7EB930255B7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11F33A707;
	Tue,  6 Jan 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="piE/fzmP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7442F1FDC
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731466; cv=none; b=V7stBh+e42Shc6uE8ybNUw5xa9UE/M5MUqoT/cpve/nbjyGBTPxU8S8n0bFh1/7pZC3QSDXvQlZ52tJp9PCBj4Z1u/uA4ztLUkvqAefV5rJDd801GJhFEp5YMDX9E1cvelXd9tbmxcl96UKsOv+zhgN6nPGJt0ZGMaoIEo7hHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731466; c=relaxed/simple;
	bh=1sX+qb9Dlur4kiw7CXscA2uQklaWRm7LXuNxxosdHls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ct5Exklf09h7kuhCZaBgLa8BRj7p0qkjp44F+LncxUnHuoTFBRJIiwuJHeGMes2QT03eJSekqJXzFtHWn73a/GSLp7EpBEdvEpmITf6BHRs8kQHXjkN8PIx1Y7E9CnHmxa+zhA2OZ9L/DhoEjnYXgcdc3AjrftPzvAXYQP+zMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=piE/fzmP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jX07xLVIsxMza3KOKrZCFuZjgUNblJhk9Q9rDmR+FhQ=; b=piE/fzmPOizXfmLqVhICBmhMhx
	iQHZyHzddzsU+E8JFpwnL8Vbr5T+mgFqhbDRZ45vTp7NTJKNaZHVo2HzepTU9+hsiMKGXz4E6QII7
	Gguq5vaU3C28UtlPskObROeQH2rqA+dczwThEBGxmq+2oFMVAf2NP+Gcx+MoCbi1WSM6KdAsOvnGe
	Z9ooi2kyZa3BbFXwD1j3BRoXKaUtQNjuc2y7s6PgNfV3fiwFRN9PnRr8ZhKFRm16qviN9tsYUknnu
	vonU0X16Womu5x/4GX+4I34fej624gtErmtouljJBBVec9eDmBJQFGG7P9KzHZmXmaicU6LFz2qQ1
	Oo047Xqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52582)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vdDha-0000000010C-2wW1;
	Tue, 06 Jan 2026 20:30:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vdDhX-000000000jR-2EzS;
	Tue, 06 Jan 2026 20:30:47 +0000
Date: Tue, 6 Jan 2026 20:30:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/9] net: stmmac: cleanups and low priority fixes
Message-ID: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Further cleanups and a few low priority fixes:

- Remove duplicated register definitions from header files
- Fix harmless wrong definition used for PTP message type in
  descriptors
- Fix norm_set_tx_desc_len_on_ring() off-by-one error (and make
  enh_set_tx_desc_len_on_ring() follow a similar pattern.)
  Document the buffer size limits. I believe we never call
  norm_set_tx_desc_len_on_ring() with 2KiB lengths.
- use u32 rather than unsigned int for 32-bit quantities in
  descriptors
- modernise: convert to use FIELD_PREP() rather than separate mask
  and shift definitions.
- Reorganise register and register field definitions: registers
  defined in address offset order followed by their register field
  definitions.
- Remove lots of unused register definitions.

 drivers/net/ethernet/stmicro/stmmac/descs.h        |   7 -
 drivers/net/ethernet/stmicro/stmmac/descs_com.h    |  48 +++---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100.h     |  36 +----
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  70 +--------
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  21 ++-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  16 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |   3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  79 ++--------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  28 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  70 ++++-----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h |   8 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  40 ++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   | 164 +++++++-------------
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    | 172 +++++++++------------
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  40 +----
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  21 +--
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  39 ++---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  75 ++++-----
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  27 ++--
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |  25 ++-
 24 files changed, 346 insertions(+), 662 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

