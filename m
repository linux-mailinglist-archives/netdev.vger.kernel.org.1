Return-Path: <netdev+bounces-214398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427CB293F8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368972A43B1
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1F1EEA3C;
	Sun, 17 Aug 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Js/+i2gN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111D1DD9D3
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446674; cv=none; b=M3F+ZKcwlbCE48zmJDTgcm0kUi4e0FHtrJ0E76ze05XXp8CbQ1kn932thkraFMpSc6093CyDGW8xDTvVBSGL31cq8WzrfoCH0BkZ8jEhS4zKI82EclY9g8Ag8Yx3RKjm9DtVG1FUgyvhrTUOzK4Ra6OLeMAeujUYAW+VpwvFhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446674; c=relaxed/simple;
	bh=P5rwfcGSSOv/uKKsAF8TFd6e2O3BXYcrXeQHrS/Jmoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeFLPuQILjibn2fO6HmB20tXH5fHrG2WCRnCkr1q/se/8xhnSwYa9TrTtqLuWrCq4qAykILji0Q5VMef+Dz+uifi3VmQtePB6stSM79f1nbh+ydrJ8+JzcnpnkDJLMW19XKWK6f5mMdkqXmRJJdCW/350ZtxnWlQyUpIqx+24zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Js/+i2gN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pCcg/l2MDgyx42YR9rTaA9Q/wswgRnMWMOcSSkfSRn4=; b=Js/+i2gNu7+OuWsAOyEK76MHHO
	+acVYTB9ee7v42LjoTfgrn+PZf3WWQw3nWkegNNMFrUQuTUlKLsU9LAEdA4LMgwWLLmUlTOLmsDv0
	lFguBOYFUw5w8mXnBJp53xm+O0rOnOsjIH12t/3Wlpl+xLYDi0yFenWZoO3qcxP2AyFo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfrr-004yc7-Ll; Sun, 17 Aug 2025 18:04:23 +0200
Date: Sun, 17 Aug 2025 18:04:23 +0200
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
Subject: Re: [PATCH net-next 6/7] net: stmmac: add helpers to indicate WoL
 enable status
Message-ID: <f5b02f2a-e05e-414d-962d-4f561710271e@lunn.ch>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
 <E1umsfP-008vKp-U1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1umsfP-008vKp-U1@rmk-PC.armlinux.org.uk>

On Fri, Aug 15, 2025 at 12:32:15PM +0100, Russell King (Oracle) wrote:
> Add two helpers to abstract the WoL enable status at the PHY and MAC to
> make the code easier to read.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

