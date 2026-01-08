Return-Path: <netdev+bounces-248203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926ED0590E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3683122E30
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96402D662F;
	Thu,  8 Jan 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cAvWBzS6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1313285072
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893736; cv=none; b=Z0WvOk3nTcD8cSdlCf2SjeQigkc5wwpfEVI9uEAdyYpgM2netBgOBFe2waCy3bvmpMqT5uEZhvPO5hh34O58rgj3FV77zj9X8U3pgIEUwcpQDq295zpSbIQVwtRs6riZyPDbOJcWKkm9bGDPOE7dhmiY6AojjLVnGdi0/pKhUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893736; c=relaxed/simple;
	bh=xFUZEjJp/qd37roajmtmZV8v5oN5ZxuGXL45nWMGAig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FNdOwPXFAwuHOmkdy7eyPOlpQtSHk8uNDTCKuMa8SV48XenJUu7g29H6Mm7ntLpPHpuz2zusDyShqsFiY84SkUHdlWbMtnzvb99H/F0vT+f0tcWrh7/K1S2ypaSjJTYqCvOwZGz//uWAsJYFfkwkmaH2LUWU8I58qUScPOyeilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cAvWBzS6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AA6/cU0EwaGIbDjOwCO+iFT0bluemqog3evu4aTUGBo=; b=cAvWBzS6b/klvy0clIH5f3zzZZ
	cgWkt+jJTjSI4L7wD6TWbwt93K8ppCqM8AVVNFCcj88ezQaZBgiVC8UNlzRT4MjK/wnbSbqQJrO9H
	EfT+cwnNGkUAiZJruDCIZkrMonpXrMwwbxrGF3r4Ry7gPkWcsW9NR832EogdpCb19Lb/90wd3gSmr
	S85ItnIrIU4kTZaJ5/m7Keaut4B8pXvC9J2p/4XiNTo4lgKnjqfclSHy1niyYsyEntfxEXbjOPkCg
	lCGVwpX+VSFVDc0xnm0x5rjK8JGPJ+Vo1LegZ0pRWA/zG62p1zUAQPOl6fRd1KEqCup2EdygyMB7a
	AmjRhUQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53814)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vdtuu-000000002yC-3dwS;
	Thu, 08 Jan 2026 17:35:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vdtuq-000000002WF-2Z4D;
	Thu, 08 Jan 2026 17:35:20 +0000
Date: Thu, 8 Jan 2026 17:35:20 +0000
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
Subject: [PATCH net-next v2 0/9] net: stmmac: cleanups and low priority fixes
Message-ID: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
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

v2:
- Add Maxime Chevallier's reviewed-by
- Improve some commit descriptions
- Fix build errors due to missed dwmac-loongson.c usage of SHIFT
  constants in patch 7.

 drivers/net/ethernet/stmicro/stmmac/descs.h        |   7 -
 drivers/net/ethernet/stmicro/stmmac/descs_com.h    |  48 +++---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   5 +-
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
 25 files changed, 348 insertions(+), 665 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

