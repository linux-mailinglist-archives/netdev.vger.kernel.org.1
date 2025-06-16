Return-Path: <netdev+bounces-198077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D03ADB2BE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C627F1888892
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07152877FE;
	Mon, 16 Jun 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SmyhHYgF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AE2877CA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082262; cv=none; b=C31L0Ut+ewPqcGXLlJOtU1jA0/CM9f6XY27Ru2dqIZLPLxan2kMLtWSTsnHMXTk/1zOVYMwKobKIGZ79JcygL8kZUs7Vny3iF7OVO2UvgLACi6gybzbqk9sbZTjYfEYzKw1DTqY4jtoTZBc41gIu1YReE+TZSHviSuJBWrSHzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082262; c=relaxed/simple;
	bh=zklSNR6RW3C2ialmSj4IXAHk5KC3jMT6gWg/S8bcsj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIoWEKcomenvyNK93xzz5eMhS7+K1dLHuOv3wZFw3q+7/03Rr0xx46PkDjkt71YM6vbgLZcNbi1U5vP8RbDXWZn5zs5VczFhktBX3/VIKPMvQVqnbMfsBBORCR1+XmBTY0Nj5z+SW/0QohbGK2cgjKR40Pd8SntYHJEz+FryXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SmyhHYgF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pkPX3SdfRcKBJtj9YBuTt4Bunu0ITK5f/bnT+P8APAU=; b=SmyhHYgFjbsyLdEkjvpqxcIaq3
	Bv9GKc8m+pG4+wcZIXD9TADXOEznHTSJuE3WZJYYSwpyJUK7yoMdRJf1NxIKDlWOoRAOC78N6hYpd
	3t/BmdJYqTYERaqG6bqbaORsXB+aQSmMK4BqzpFBUF8NilyI/LKBlpFbS2yY1XBi5raY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRAL5-00G38x-I0; Mon, 16 Jun 2025 15:57:31 +0200
Date: Mon, 16 Jun 2025 15:57:31 +0200
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
Subject: Re: [PATCH net-next 2/3] net: stmmac: rk: use device rather than
 platform device in rk_priv_data
Message-ID: <fa271d3d-60db-42b0-bf41-f1fe75e18b9b@lunn.ch>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
 <E1uR6se-004Ktz-Dx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uR6se-004Ktz-Dx@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 11:15:56AM +0100, Russell King (Oracle) wrote:
> All the code in dwmac-rk uses &bsp_priv->pdev->dev, nothing uses
> bsp_priv->pdev directly. Store the struct device rather than the
> struct platform_device in struct rk_priv_data, and simplifying the
> code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

