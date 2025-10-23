Return-Path: <netdev+bounces-232053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95605C00571
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F643A42C2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1130AAC2;
	Thu, 23 Oct 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VeFnkdn7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E03309F17
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212779; cv=none; b=LBT/KQCBqKIHvO31HtZRKrZSWOSKJlkQYZ4wHI2fXOFriy+bFPw8jFqAiPcGt48B1qECRdmJW+765bTYXB1YnZ89YwkWh9cRiqIEVsPY61uCN+YFl1A0vAsfkEMoBDJ3kRtmshIv6CT9pvBP6GAXoRG8V6ec93TZAFe7ZGv9FEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212779; c=relaxed/simple;
	bh=0YDaywRVR8jcHjPUBmaLin4oA11BcpuEO0/zieDrIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W+wt21iQsWDQ3IFzRxAF59SuABnUNLQAXZzfq+OO9/c23zYV+1FFGWipAomUeUTgsRKqhis7uKcXTQIpodFOLK0n9a/hm15BGcgTzZEEuauC9ue4qTDPbfnKzUp/FYpgYvxDNDwe7jc9qu/SXXYv1J2rm8kb7PqJNzIre2KFKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VeFnkdn7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NgpAa3vCXF8Kyi2ufZqWKX+aesmDKAy5CtUjQRUQIQ0=; b=VeFnkdn79Q2P2HP9G4RpPb58FR
	VKZ98Er/W8oLcJsbPdOrkvVY4udncaY1U7sFVyJu1kffwcnHW56FH9qe9Hma/z2g3/cvmIDuK7e/4
	Jzw/At4CH2AbDMnNoPVzoj9zo8FvOe+gwvJwByXqcSrV80Z0DPe4WapqqHGm+rNLtXjkeoV6FEA/Z
	7XIvysR95b+ZsqxwCldkVlb5dI1Rnr/+geCaJHR5xOJ4EOFQC3X/8XwyN93XRR5jKVUKvKeR3/hfv
	UTlsjF2/n2s3EiHIIPiCC5aKlhSuBvDKcWDltQTbVTWTtXl3MCvLFLw7MbadrXJd3rWvORUKo/vQu
	5fz6MKCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36838)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBrtb-0000000068L-2tsr;
	Thu, 23 Oct 2025 10:46:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBrtZ-000000001aN-2Di5;
	Thu, 23 Oct 2025 10:46:09 +0100
Date: Thu, 23 Oct 2025 10:46:09 +0100
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: pcs support part 2
Message-ID: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
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

This is the next part of stmmac PCS support. Not much here, other than
dealing with what remains of the interrupts, which are the PCS AN
complete and PCS Link interrupts, which are just cleared and update
accounting.

Currently, they are enabled at core init time, but if we have an
implementation that supports multiple PHY interfaces, we want to
enable only the appropriate interrupts.

I also noticed that stmmac_fpe_configure_pmac() also modifies the
interrupt mask during run time. As a pre-requisit, we need a way
to ensure that we don't have different threads modifying the
interrupt settings at the same time. So, the first patch introduces
a new function and a spinlock which must be held when manipulating
the interrupt enable/mask state.

The second patch adds the PCS bits for enabling the PCS AN and PCS
link interrupts when the PCS is in-use.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  5 ++++
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  7 +++---
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   | 26 +++++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  | 27 ++++++++++++++++------
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 16 +++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |  2 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   | 22 +++++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |  4 +++-
 11 files changed, 96 insertions(+), 22 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

