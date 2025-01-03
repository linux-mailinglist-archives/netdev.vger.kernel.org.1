Return-Path: <netdev+bounces-155103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFDA01052
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 23:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED981620D3
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E871C2DC8;
	Fri,  3 Jan 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0iXk5yj/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F681B3955
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735944331; cv=none; b=Qe4yLiT/v58B/yx9EPBlYN9oAu7rR7EVk0qlGW9i++qp/eUJkCpvCFXjLvs8N6bRBZOt3b8gDGtvdmM62pcaN9MFJF70aUdGER2CsRRS5nmIzn8gslPjXgLr3ICdUl8Dr8ppYSXuoKYuQ5tMcedhouCiYAXAjYO9KItraxSeq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735944331; c=relaxed/simple;
	bh=4Zx7cRkju1Qj2OburovcA27OIFyDm8aP+xix7/RaDuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze4YS6zAFCZxVJ27q5SKZB97TEasztqh6o/4TJU6EWfkbdNgPfg836x8zHXW39ogj9A0JcKAHL7tUAubB0db52XkY4xtXCdMGIuYjR7bLIheaAWpR1d1BhDD6HUEEuNdBfIf4p0wicEPafW9TYOmOBCtB4LavIv5cPVCYlZvVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0iXk5yj/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nC4xRGziK9g9aVt6fSkQ1/i2c6tieWGRAMPkl5BbmQQ=; b=0iXk5yj/N9X5BChmvUoExXBHij
	7nlr0oqp4aoFuCc+m92c6aDBPqBR+DgPwhvjnQ1puqPVQEKkXm4wSVtk1dCvzFbqzruEPpdAq8KWS
	+qjTPN9RIeiX8PG/phNYYSfA2HV+zWM5PiBQR5Z56DNS63bGI5dxUTERm9+Bj48OW+MQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTqPn-001ACo-P8; Fri, 03 Jan 2025 23:45:11 +0100
Date: Fri, 3 Jan 2025 23:45:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/6] net: pcs: xpcs: make xpcs_get_interfaces()
 static
Message-ID: <7da95b85-f16e-4082-ae6b-12da27875750@lunn.ch>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk>
 <E1tTffk-007Roi-JM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tTffk-007Roi-JM@rmk-PC.armlinux.org.uk>

On Fri, Jan 03, 2025 at 11:16:56AM +0000, Russell King (Oracle) wrote:
> xpcs_get_interfaces() should no longer be used outside of the XPCS
> code, so make it static.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

