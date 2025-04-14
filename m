Return-Path: <netdev+bounces-182389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C7A889D7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE563A62B3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A519E806;
	Mon, 14 Apr 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="snsGLG06"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F843146
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651815; cv=none; b=uKH9smoWQNN7EuWdVV/IhuL9RU42fAWiUEGEQ9HbFvsmm8/CKmEVqnd+IBmDRxU1D4i1hzEGhT08KOJmfsIMRrVRLOlQcMyo1ur8JpXVVblcgsZII35+ijth7EQA/iyQIdDNgg3Dv23B7m651+un9QGHodFabFp/lV4rN1pMPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651815; c=relaxed/simple;
	bh=eEUu3lqkuRr5T70y8W0xWpesK40tu5zbUxHjDoO6TAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWXMzvpkrWcdCxL8cRrtAeghXLyBlZgm5xuO/H9EFOoasAX2AJZaDCAqEIMITIY0s4sF+4HrNyZRmHrBRSrr+whEiFNN53o2GUiyaKagmKtVxMmmWZuwlKm9Ty2v3ip37qlQ8kk4z5iWtQsAYsOguaHrk4u4Si1WhOKa8xQiWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=snsGLG06; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GwXhaxA7ixaqtqzPddoX1oS8D1J/btE2jtBkZI27lYE=; b=snsGLG06OR6QoVP8gONg2dBtEJ
	f86M8hOBLcq4ZGic4n+aQDFW+YLzjtYKznL4c3ZilygILPHMKZ/PM55zsxE0P1rxbk/9eiJOraWIj
	jbZs6BOLx3dPo8VzPN++5e27FkP8Twy+uoODw2THnngk+zwFLsvRQq8VsZuB/+JL863Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4NdC-009EyA-5v; Mon, 14 Apr 2025 19:30:02 +0200
Date: Mon, 14 Apr 2025 19:30:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: ingenic: convert to
 devm_stmmac_pltfr_probe()
Message-ID: <9d7b5f8b-d372-4fcc-90a5-c648db966fde@lunn.ch>
References: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
 <E1u4M5S-000YGJ-9K@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4M5S-000YGJ-9K@rmk-PC.armlinux.org.uk>

On Mon, Apr 14, 2025 at 04:51:06PM +0100, Russell King (Oracle) wrote:
> As Ingenic now uses the stmmac platform PM ops, convert it to use
> devm_stmmac_pltfr_probe() which will call the plat_dat->init() method
> before stmmac_drv_probe() and appropriately cleaning up via the
> ->exit() method, thus simplifying the code. Using the devm_*()
> variant also allows removal of the explicit call to
> stmmac_pltfr_remove().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

