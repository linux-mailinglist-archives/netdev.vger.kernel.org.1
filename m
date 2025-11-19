Return-Path: <netdev+bounces-239911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED585C6DEF0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30B924E8C88
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D283446CB;
	Wed, 19 Nov 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UlqN0QcH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F9299959
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547070; cv=none; b=thXIsKjb3m3ug4oxoROBWb+dcHqzVaDAuvAMKtAB45Eu0w0cY8hlCcqxymbRCmjfPy2ulHAniOVlO6X6dEH6JqCepn2xGMtFutGjeynOHnCiBnQM2ziDikqUOk9vgIkZ9jQqRjfuPRg7VgWxOWIU3hGQn0qZrdhjCXdJMokrUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547070; c=relaxed/simple;
	bh=qgMs/fu4seuvIEKq1Le2WiYWlVXlQOQ4WImHffOQm/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd/FArmT38VTnPkASziNuCVLyzoZsytOo6bT43aUWTUg9V1suAnOYyJlAf0C54WzA0X99MBpp6qkW5hzZ6cOAOQBOKYiB+5AzRTptWka6XuITV9XQCmRGDtxrd9cGtF3Kae5dnckwjEtFpZYkl25I4/MsFOiLimBIevmxNUJIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UlqN0QcH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D34CtWTDd1vUfTflZaY/LmIETvT4QwvilMK5Cvqwxb8=; b=UlqN0QcHrqqCa0kWZnWMI0c1zg
	vxsuRMadYN1IICVUnzqxK5bT4Bm/DvusdFBCFL09cMszWSzQJm5n8cMPBEi0bw3Pap5wZEEB7PXDf
	ZSorIvKaiR76mgRBW+gr9bokyeYiQ3pe5gu6I8p7jZYzy1wg8nJedcteRrkTR4pB1MJyo4R0k4VOQ
	NwWswRybeiQrOKtzYrE2k6+SEx9oBlJ4eMjZq5cNOfxwoO1vMAiVkxtkeL1YtlCmVzeeNEp8NiBhl
	8edUmFmFjH0gYitWiyhJPOq+tMvdl0+5+cCpQb76qH1l1fuzrNNepmBH+LMFKWYFoSz8px66NTZbG
	ceRnB+oQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50806)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLf9Q-000000004Sv-2lDM;
	Wed, 19 Nov 2025 10:11:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLf9O-000000003Ki-1D9n;
	Wed, 19 Nov 2025 10:10:58 +0000
Date: Wed, 19 Nov 2025 10:10:58 +0000
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
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos-eth: simplify switch() in
 dwc_eth_dwmac_config_dt()
Message-ID: <aR2Xsk_aNar-2YMV@shell.armlinux.org.uk>
References: <E1vLJij-0000000ExKZ-3C9s@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vLJij-0000000ExKZ-3C9s@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 18, 2025 at 11:18:01AM +0000, Russell King (Oracle) wrote:
> Simplify the the switch() statement in dwc_eth_dwmac_config_dt().

I notice that "the the" stammer has appeared in this patch commit
description, which is flagged as a warning in patchwork, so I'll
re-send with that fixed.

As I have a number of other patches that depend on this, all centred
around the axi_blen stuff, I'll send this patch as part of that series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

