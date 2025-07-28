Return-Path: <netdev+bounces-210620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEDB140E7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3422A166BBE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57643274FD9;
	Mon, 28 Jul 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gCUiNtTu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708F2741C0
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722390; cv=none; b=DJvR6fsPpHTBsyDzcSAQ+cXdHlzx3peLK1nvIG/Vgh048xq+PFLd1E7GgOdUHLSiD1QlLifza+HP85k6v4qC73v/R23tDYTBOm6Bf/DntXfkl4ytclzfdSdxgmUMqfD8vJbyTAep5axDEYCmAdLw6qucIe3safja64FF+0+DHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722390; c=relaxed/simple;
	bh=CDjrIBHmq1rNDB88zEcgSRJkJo/3gO/mUW2UYSeDI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8eKOEdOef6bkY4Ygf0i9avUQQn9CWnYM8U2paacvz0VIrsLuAxUQU1w2dvNvver2EhSx6zYfMc6E8+zIimcFNwpcKKceiEV1nIOKr9mh5vVg/AasF8jzLIWmpn0xi28rqgOSR6eXNYVGTfID1CJzoGSg0TtRT7RzffmWiARVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gCUiNtTu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VkH0crfTUwXB5DNXuH8yBQyTTJsazdYrj1Yis/M7piY=; b=gCUiNtTuGXlowIW+QHz40Nn5zY
	8MC70ZfKb7RuvQOy4n7CyiXiBf0bMnigFPsEFeXdlqbk/R4P8Pa8eY39B6qb2AHumFKx6eJ3ztiT0
	mHNMnOVPzfWfdJejDDW0ecM9TfNgCZ6XnbvdTVzAf96HnO0MxpwA9gRgou5eBcSSbwno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugRIp-0037HF-Mc; Mon, 28 Jul 2025 19:06:19 +0200
Date: Mon, 28 Jul 2025 19:06:19 +0200
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
Subject: Re: [PATCH RFC net-next 3/7] net: stmmac: remove redundant WoL
 option validation
Message-ID: <2f61fc10-fad3-442f-bfb7-5cd13dd6711f@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ2o-006KD9-EB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ2o-006KD9-EB@rmk-PC.armlinux.org.uk>

On Mon, Jul 28, 2025 at 04:45:42PM +0100, Russell King (Oracle) wrote:
> The core ethtool API validates the WoL options passed from userspace
> against the support which the driver reports from its get_wol() method,
> returning EINVAL if an unsupported mode is requested.
> 
> Therefore, there is no need for stmmac to implement its own validation.
> Remove this unnecessary code.
> 
> See ethnl_set_wol() in net/ethtool/wol.c and ethtool_set_wol() in
> net/ethtool/ioctl.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

