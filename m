Return-Path: <netdev+bounces-173528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A61A5948A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBDF1882318
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150CEEAA;
	Mon, 10 Mar 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="erPLNA9w"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A610FD
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609906; cv=none; b=a0tiLm4EsBA3r8JTtb8t0CFefkijKeGZAi6FVKXv5wORC0AsPQqWXNwezJWdFaTBUKGEsJ0kfZX6njZSx09hllXhvFWZnr8ahI74t6JX/3/gs5XPE+LGeWvEMy5umv+Erm0h2l63E3SBLEmexxHL/qrq/w4ly+umeJL/Tc2s4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609906; c=relaxed/simple;
	bh=nu7drn/TzYUmOYZnQWuYJ4aSRox44FuTBFdmRujhYRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lvOTc3xnH0FKAJOWPQVttYewWDSTwzKkB/g3sLc08tARpXLerwMU6exMyxmvPHnhqBB/A/BMayJqNmOlvJkkoJPHV5OahRttmhNAiaXnyVnR8tkzUN+V9eddmxMAI6gYSGcc1bjZHDzF9kqahP3DgOXMH07t0/7lEer6jLFoXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=erPLNA9w; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=itOKGgzpHi7KgaNmFHmHfax9kY4jmtqWEweC2RyI/Og=; b=erPLNA9wWzqDRpmp0jTUNuVy8R
	jHoaL6nv4fDf/jTi6npkgPDWsRHfZpbV/JUCNy7xFneykv3fIKU8bDnM6pGxIYVpTD2kwzYjJjR4A
	VQa5K0G93KLS31qrG03TYdVqFV4Z9zOt1lLJFKJqL+tRH4VNi2+Z6gXTLa1kynvf9a+XhqlIT7Zo7
	ho1BYiMtFsvOVWshin+zBspSykHdSP/bqqBdQs7wq++fc0MPQNBgQxrnXfsBOF+uLtI3Q86BObTUj
	N/ESrcqixtcf+FSXaP3TKKokW3raS17kxirnnwX423itWxAjrmR4Zv1uI8jmhJ8Z2bFv+frFaKHFq
	angen7XQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1trcIB-0002dh-1b;
	Mon, 10 Mar 2025 12:31:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1trcI8-0002TM-19;
	Mon, 10 Mar 2025 12:31:32 +0000
Date: Mon, 10 Mar 2025 12:31:32 +0000
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
Subject: [PATCH net-next 0/2] net: stmmac: avoid unnecessary work in
 stmmac_release()/stmmac_dvr_remove()
Message-ID: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
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

This small series is a subset of a RFC I sent earlier. These two
patches remove code that is unnecessary and/or wrong in these paths.
Details in each commit.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

