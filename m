Return-Path: <netdev+bounces-170268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40CA48068
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B431894990
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797913D51E;
	Thu, 27 Feb 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WXF1QCxe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61029CE8
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664828; cv=none; b=XIlSmTgzsxMSYaP15KhND5AUdzV7LFJRsk4PIx/D24MK37Z0i2C3qdZmBd6UQAp44shSuCgK0i155Td96beL/FByUZaxt2xYnyXjMWuJhATJVNnihSJeBRnUgkphAlBDP3soEM+OI6VvUrfPqQ+QlTYpvw6qgD6Ho7uxj8eprmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664828; c=relaxed/simple;
	bh=BKe3+KjegUpgcHnKIb2rwZAkKMDdPAVgn8sLdRIFtW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSPul1dacNNNr27b/O6cOuk6tAmBkC2NDamUIgMjEIgiMM1jqtCN30flhYIqchAbWabtyIrIZJ9OeDuxYW08g5hCJOZefMPZ5eKNH6H+C+Fv8xdr+sW8gOKq6cSW7avW4gzwJeCuXRTDdwdaNJVTOa+OVPk5tsob1w+wzH/lwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WXF1QCxe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tLzhqeeg9n3pIyjjUQhSuLkLk1yrOReLDokLtVJVqZo=; b=WXF1QCxeZJVQulvZ8x3fC4stUb
	HTmS3C1w6lsU8B0dVcn1tmIjNTixidb8ix/Ho2rwVTn8rV0YI9yCEXVb8AdmD5/GjePz2MNp1ssf5
	JpcnKGzTRPBfOqgM4W3BkJEFSWzuOZRtwqe/1SfBiDQGLFStG5tFzPnSFmUiOH5uSlGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneQv-000btb-QW; Thu, 27 Feb 2025 15:00:13 +0100
Date: Thu, 27 Feb 2025 15:00:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 05/11] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <5378b276-90f7-40bf-ad31-646505907ab9@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0a-0052sq-59@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna0a-0052sq-59@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:16:44AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

