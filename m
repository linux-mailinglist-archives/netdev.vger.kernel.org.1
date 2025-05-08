Return-Path: <netdev+bounces-189068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10870AB03AE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8152E523032
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23E28A1C9;
	Thu,  8 May 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c6f5DHH8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E541F582E;
	Thu,  8 May 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732574; cv=none; b=IBzD8tASO/7OrOpTgI4eHrBAB1KSbo5DaMS0gybEjaWO9eHHKZBWqok6Rg66kCW8UvEJpI7vXaR8Fxq5w7xH2Atkz/qa84QVAP1jcDAM/4BEhvik08M4cqwxGFzzsfhNJO3GyBmglNUF8ktbNmD3pUExh4HnvXvaOEk8iWTqA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732574; c=relaxed/simple;
	bh=SOJVmZEKF/QQVwiJVSIf+MtKdpcNcAsDNOcuN2oJAeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3PswJDQTgG5zslD3yI9eMfqU+wya6k4pIz0i/wVL9seCMwko5/d7nKf48oCGikOTyToKY11DN3mJfPBRiw9TJI3BWWBGHMWZXJbun1sjGl8ZxfdW585VotAdaVMU9vInOxwwO5FbTVxPqcs+OSP/04sIebGGS2c7FdEiakUMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c6f5DHH8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KHy6po0W22Ev89YgCTuH6Hdrukk2aXIoiByyKLP1F5M=; b=c6f5DHH8/O6FDm0HbZFhP2Snmj
	oUAbv4iiYMtKYhLjzEP5ZthhwhHSe3/24FgU+JHvxKVPbh53i87Mg4ENJFZ2yjVtGWNEsBzoXxX/d
	jbwXW19/C6jA5wanltVBcy1aKUBWqXJi/c6UsJ82TIYHqUXOntfp+fOQNbBJS6yXonXI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uD6vj-00C2Vw-DW; Thu, 08 May 2025 21:29:15 +0200
Date: Thu, 8 May 2025 21:29:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Message-ID: <8ab5354a-bb19-4679-a364-be68baa7e911@lunn.ch>
References: <3c34a2f1-d163-4854-9146-4a9440671177@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c34a2f1-d163-4854-9146-4a9440671177@gmail.com>

On Wed, May 07, 2025 at 09:08:36PM +0200, Heiner Kallweit wrote:
> MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
> select MDIO_DEVRES. So we can remove this symbol. mdio_devres
> is quite small, therefore make it part of phylib instead of a
> separate module.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

