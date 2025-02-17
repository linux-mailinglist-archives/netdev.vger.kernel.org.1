Return-Path: <netdev+bounces-166942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D26A37F7E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCCD7A3F69
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77301217711;
	Mon, 17 Feb 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DOf0OuFb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF9217713;
	Mon, 17 Feb 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786893; cv=none; b=WmEDcAubd2b4zy2Uq1tsTcgWydK3h7O5dbj8QX33lq5qGe0Ttk5Y88ne3hVXK3CEUuuwYC9neU3fUcZxut0DRhiPBBGiAkZmzVBTIE86dnB/gyAcwTk0d8hYbiB2DcdruuJiCgRAjUrxeKxWKueo9wcGWUdV7tAlBrFzrlBhmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786893; c=relaxed/simple;
	bh=QJhMMvbsGbb9IG1/WGxalDSRUdxAS06UI2IeVEOIOvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0yj+xCoBBZZke+X8qgfkomPPoJRpgA5RLo5GzYn/yhDzQfroklwKd30O90FeaIhjAlo2alELcKOQ97fiUj47kBzUTXl6WZO3IAlR++kxU38jMM9+G3ZjbawO23PukA9elG6Es3WWGFnSF7/Um4J9NymUrdKtnfmRV0qGQSj3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DOf0OuFb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hw1hJQCbl8Z4ry3SD9KqSPmH+QbC3B7QYj7POJLYcWI=; b=DOf0OuFbIVh5MtbmOHngba6QPq
	5YEy2aTZMacwyGrR4qAwdfFeVd+EUNPBsQNMO3kJybjmunT3URm1zZfqyZcnh951R+YASaSQTA0NZ
	wQAfMwm+mwM+846S4drYIDbXmUqTawnjZ/rtgXW7s1cPIly0BzdvkrU65Tok3bZty2jG9/v8+GGFI
	D5v4ZrbAD7u74k/ieqMdLLo+4umR/oHCwamvY19vm5c9+Q4LIfnFUVtK70bTJstZqg/NqpRjoSXOn
	Xp2sI9NkzMIsbtr/Be7lB4XUXHNeYbGeUaQtYFkXrRHvzcjbGDfDZTfzn4XUnc62ssFFBHB9FWKRO
	0XnCe6CA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41180)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjy2e-00067U-2a;
	Mon, 17 Feb 2025 10:07:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjy2a-00067e-1i;
	Mon, 17 Feb 2025 10:07:52 +0000
Date: Mon, 17 Feb 2025 10:07:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4] net: ethernet: mediatek: add EEE support
Message-ID: <Z7MKeEKOzmA5JEjU@shell.armlinux.org.uk>
References: <20250217094022.1065436-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217094022.1065436-1-dqfext@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 17, 2025 at 05:40:21PM +0800, Qingfang Deng wrote:
> Add EEE support to MediaTek SoC Ethernet. The register fields are
> similar to the ones in MT7531, except that the LPI threshold is in
> milliseconds.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Thanks for reworking this.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

