Return-Path: <netdev+bounces-232535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA5C06502
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702EC3BCB16
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C03148BD;
	Fri, 24 Oct 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V8T8aUuf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FF1C701F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310113; cv=none; b=V285VdtupiHZswD3fJgDTAojRp1JUaMN3yUNKhEv41kIoocOFP6nPX7X/peQwQtbOfIjjoXfHh4pEeCyW4lUqSFnVqzH3gVFU6bBg+zR0Gj4ay3T5/gov5kzHssbplQM9uLEnjjKSzW7D4X5YwOISTkHifvC3AVBOm6ZQPfAMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310113; c=relaxed/simple;
	bh=mW4vOOXq04242+InNEPkA3sMa4B1dq/TD+Hsfh9A3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QVUgb5M4OjH2BXcSeSwMW46/7c2Qo0nfOd6LPtE88mTPS1a8aJSwuXTEMMv2vbiyLhFlrq534PSBNJauG7DOGgUc+bE/sh97/158plYkkGTUIucNW6HIFQAGBn06jvwo5jUTBxouV+yJ+QUQGW5ChMIaQm1bUBKGAO7Me44G+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V8T8aUuf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7rI/yMDgYjHcfeP17fsZHgiix20oaj8DY0JDBoecpkw=; b=V8T8aUufyxQXItLMUZSGXT1m7I
	59tlrsFjBVvLywhZh2W4BEZuFSdf7AUGix8wfqtHKiWsd2lRzRT++NCnw6E8ZOjJ488dAG9pyHJjw
	Prmv4QZR/yY+Txzbvf0XU3lhllYsh6bSWL3PeyFKDX75YcTYZKtw/SQ0QeqBzrcoIWGHgDSfkUAoT
	lIAe4NTe2rAU1O1HN/dNcEoEo9OSUqGqYfw7zMlBdlaUZ26N+IEWh/H2T72OorVkKGBaRjidaG7dv
	I9V8UWHYFBKPsY6b0QEaTiuSbNqcMGSWnU/rA1ca21buld+RzMzbXtg3Lhthoug9HdmJefXwV06Si
	v+hayfnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCHDV-000000007ZR-3YUy;
	Fri, 24 Oct 2025 13:48:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCHDT-000000002iT-3FcP;
	Fri, 24 Oct 2025 13:48:23 +0100
Date: Fri, 24 Oct 2025 13:48:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
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

This series cleans up hwif.c:

- move the reading of the version information out of stmmac_hwif_init()
  into its own function, stmmac_get_version(), storing the result in a
  new struct.

- simplify stmmac_get_version().

- read the version register once, passing it to stmmac_get_id() and
  stmmac_get_dev_id().

- move stmmac_get_id() and stmmac_get_dev_id() into
  stmmac_get_version()

- define version register fields and use FIELD_GET() to decode

- start tackling the big loop in stmmac_hwif_init() - provide a
  function, stmmac_hwif_find(), which looks up the hwif entry, thus
  making a much smaller loop, which improves readability of this code.

- change the use of '^' to '!=' when comparing the dev_id, which is
  what is really meant here.

- reorganise the test after calling stmmac_hwif_init() so that we
  handle the error case in the indented code, and the success case
  with no indent, which is the classical arrangement.

---
v2:
- fix "verison" typo, impacting patches 2, 3, and 4.
- added reviewed-by / tested-bys

 drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
 2 files changed, 98 insertions(+), 71 deletions(-)
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

