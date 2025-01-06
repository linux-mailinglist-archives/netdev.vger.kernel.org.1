Return-Path: <netdev+bounces-155537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BBA02E83
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C179E7A182B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D43597B;
	Mon,  6 Jan 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="48N32v4m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E8C8DF
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182944; cv=none; b=IUQg32wqq18McVrE4lkTiDz52Ec6j8TVCsEQqb9tsblOMEIkkxhCgsLlPAavWYSrgdOMGYOW0qiSyoWjTo2gtwJ21Ai2Kl60Desll0xr0VmXo6eoVgy2+T0LlC/T9iWKwtjTDUPSq4IYIVewH5tJa7UZHMYfBxZ+Wr++zro0nJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182944; c=relaxed/simple;
	bh=M5BfNx6cbLsopr/zvmt8vFedE5KeJOVO3ZfYYjqXe9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSMsuDdEtlDOclG254DVz47yYaRgTCXffbzFDWai9tcSHBZMinRbnARe0soeNxyYEXbOinh5Gva4xkhXzZevAxE41X/IkTpP5ovOoW15pkZp1oaiNbMgkA+RoCq2M5Rxu3dyblwTDNp/52mgMJY1lID4a0pLlVMGOeDCUR48oAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=48N32v4m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VS+0b0qDAmY2DVRpWtJdhv1Wj/jUpe1PN7cG2IVVK6s=; b=48N32v4mh61pgqdp728cPK8txe
	rsVkq89Q+XfRbVFnYlfltPXT+2NRuPeZy0GIX3l5I0rLRzM+aAHGmPP1jr8gHI1fTfPbCEuwzAACy
	S73OkkWiOP53ILosOVld/5x3N/GRDdMEhKzVmYmh65eRw/8AfEbG4CZO+MAwIUugONCw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqUT-001wHK-RT; Mon, 06 Jan 2025 18:02:09 +0100
Date: Mon, 6 Jan 2025 18:02:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 09/17] net: stmmac: convert to use
 phy_eee_rx_clock_stop()
Message-ID: <a0fca6b4-9bf8-45dd-9ac5-0cc94cfe2195@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAj-007VXV-Lb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAj-007VXV-Lb@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:29PM +0000, Russell King (Oracle) wrote:
> Convert stmmac to use phy_eee_rx_clock_stop() to set the PHY receive
> clock stop in LPI setting, rather than calling the legacy
> phy_init_eee() function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

