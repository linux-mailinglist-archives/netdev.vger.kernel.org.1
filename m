Return-Path: <netdev+bounces-144938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FD9C8CBC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A51F21D3A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D213E04B;
	Thu, 14 Nov 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="swKFX+8k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA413C8F9;
	Thu, 14 Nov 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594004; cv=none; b=PXgA+l0KvSZtWxB0Q9BJYqvxYgxKIiFS3/LfDtVXr/FLnTbr1o+5Gv+6So/X0kM/AzND9LYfVaLFuNGlASRM8ptRPzsw1fSEmeGhmGsU475ce7ZStYojetog2RF4nTiumLyk4v+TwMUx2nAZ3R3hskdHYNEsEz6Io7re0Z45tOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594004; c=relaxed/simple;
	bh=vccQyOB+xJuk2g1am4l4Ua5xhFBGG/H9+Jm2u5oNkaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjIFxdaO2GbFsod8yLk+e/gPaa2iTvjkPI4f6Bk9RLVWYd/5CTp87riaN2lgI82MPeyRrn/n1yLrAsShTkrlnVeNR2t71uAqGOMrxN+bbduFIY3gcAcQGj0CE8rFCs35OHjGu350ciaDdn2A8dOSGNV6QvfchTiCyju+NABFMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=swKFX+8k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Gd4wGVdlE5PEIYAfxbgfk13v84l2R6kUx9v7exrd90=; b=swKFX+8k/URpFhlJqJYu3eOSyQ
	ui5OVTqE/vqWG/rm3L66F/mdJb7SYQAIFmfUs9rV/vnj8ZnAFw1M6jDXi6N3iX/KmrGrfYS/Zm9eX
	OJ230ap0imbagTUlJFI21o5V0kh9+sj3IGQ/Fzflbagb+76Mx4EceRdrNXTN6H7ye5fk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBahO-00DJ0U-0K; Thu, 14 Nov 2024 15:19:54 +0100
Date: Thu, 14 Nov 2024 15:19:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Clause-45 PHY loopback
 support for LAN887x
Message-ID: <9e9d5d35-b66e-4c0e-ad11-1c927225cc85@lunn.ch>
References: <20241114101951.382996-1-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114101951.382996-1-Tarun.Alle@microchip.com>

On Thu, Nov 14, 2024 at 03:49:51PM +0530, Tarun Alle wrote:
> Adds support for clause-45 PHY loopback for the Microchip LAN887x driver.
> 
> Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

