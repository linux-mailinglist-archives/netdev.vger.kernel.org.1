Return-Path: <netdev+bounces-132171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED59909F8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A1E1F247E7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAC1CACF1;
	Fri,  4 Oct 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="10BfuADd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27411C831A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061648; cv=none; b=gnkLKf/bvKZF29IVzDd5f/sQMbZpO7rt8wdyUNowKlAcwfkayuO3SPICmVFhoRJtHuLwqUadKYos7JXpm/9JkjmGlngj7mdOqOus0jy8vbQs4+ymNENKy9T7liTwYaLEnNjTiyhZCxSFJBRDTPVZALyl1J49JNLxwKG3E+JK/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061648; c=relaxed/simple;
	bh=otmozzONu41sGvqzklOoi8vd3iy6hvVCXx0QRD/oCbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6lyNK13rmuiCgtzfZRC4S+d+7Hz3A75Uk0qFlM3+mLy1YgbPAOumfCARBjshJjKPt3QlQ7CVCR7o9jXdixqj98rsaczKc8GZllIvp4wyX/ohhYo6wXSGfXPT0sqALOGBEsvymHc2ah6/LJbdZ4YNlQvUWMzzU3dWK9e08rfCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=10BfuADd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eUrKQlJ9GoNgsouFhKisvL8cCNUjhZWHkUqj1luPv0k=; b=10BfuADdrTE40KbDRPsbAYzSOP
	PMZKWKf/RlunKhpplrrK4F7nCnK+wGCFV9rf/WL3AOA3bOseBmAvikuCX4N14wKV3Mh/gHWiHs3+7
	aXlvycwEU4b3yAQ+hvxEI10lAMRmVSg9G93bnDb7UpswOUJMnK9d0XNw95+gA2FH19VyOnqbcM+BL
	zGY6M1XBKOccsqFqfhryncFnBNo7hk7olRv/XoGIgcRzjWIe743f+cYq+VuDs7aRHIQrhK6nk2D+g
	CADbICk/HrNFBE90qvzoz6AI7UtjmKhAJs6mOYTxD1jde0oK6FN9i8geeqD4n/cmhbAImyILHWS7+
	Zht+57SA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33080)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swlll-0002Kb-2O;
	Fri, 04 Oct 2024 18:07:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swllg-0001KS-0J;
	Fri, 04 Oct 2024 18:07:04 +0100
Date: Fri, 4 Oct 2024 18:07:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <ZwAgtwKKD8rsBL-_@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
 <20241004111940.xbtssgeggp5mcprl@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004111940.xbtssgeggp5mcprl@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 02:19:40PM +0300, Vladimir Oltean wrote:
> On Fri, Oct 04, 2024 at 11:19:57AM +0100, Russell King (Oracle) wrote:
> >  drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-
> 
> I want to test this on the SJA1110, but every XPCS cleanup series day is
> a new unpacking day. I have to take the board out of a box and make sure
> it still works. It might take a while.

Sorry about that - if netdev didn't have the "15 patches max" then I
would've posted it as one series which would've saved you the
additional work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

