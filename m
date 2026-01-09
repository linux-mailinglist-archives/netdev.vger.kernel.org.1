Return-Path: <netdev+bounces-248420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EECD085F5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6681E300A86B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BC33554B;
	Fri,  9 Jan 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1zTS6r2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A13296BCB;
	Fri,  9 Jan 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952686; cv=none; b=P6Fq/TWa84/q+T8/O9rOApY+9rfkxYeqN0ySjk1lfyoEUM/Qln10cLiIR9toBJbt4zvHhA56kMeuyYj6X+5pjQQVVVwTdyiG2q92u2Vm7oEzyBbzmm6pQDRzG8ixMH4/vuCwLFL16jpy0zbYfxe7/z35iPxaGR8F35WJJjbNFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952686; c=relaxed/simple;
	bh=AYkp6bsgzCEdxBv7Tjl5nsBSLP1aoFKshtzd33sSLOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnyN5TLOFIbswRsLr+p+K8iiu1qv0deDO2G3VGBvAy0kW4d4mX3Ayfb5e66QYpt0HL3VJPJudFDCW2BP49+laGVdeh8U70GZQyMIGahS868YUZMfmuZwwXsRb0rvf2wtMjOo6UtdblbQgZ2O6tZwGcvpxvkAn0t6O3BEyZKhLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1zTS6r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33B2C4CEF1;
	Fri,  9 Jan 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767952686;
	bh=AYkp6bsgzCEdxBv7Tjl5nsBSLP1aoFKshtzd33sSLOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1zTS6r2lwnpCdemdIHFTpC/Kz1++IL2BF/9fB36hBsbh4ckD87S5zT7EUswtdale
	 9n8Ksztd1JNTtwbRtfJJH2t0XUH0SWL6PxuWFpJJt4OU3dTn5eWpdMl6QPS6+HzNlM
	 gfCIR6n/zxt96M+APu6ZUOxmpW42gS6dozivTbFf2u3h1ltdJGVjpiNCmfJrIYSLF4
	 b6dbvpLq2qN4mw7LDTJcrNtgwFjCrpuhjFFYurQM5+f3R/GF6nxiG2xuLc04Lm6Tdy
	 KMdOTGnZrA07J0XuzywgLBXj9L7naoRHeTW0ODO9CSpMpGCLxae/9tKQHZtsI7KxnP
	 XeUxN2p1JzpIw==
Date: Fri, 9 Jan 2026 09:58:01 +0000
From: Lee Jones <lee@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260109095801.GD1118061@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
 <987743fa-5673-4067-9a53-f5155b8d9ad8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <987743fa-5673-4067-9a53-f5155b8d9ad8@lunn.ch>

On Wed, 17 Dec 2025, Andrew Lunn wrote:

> > > Name         Description                                         Start      End
> > > SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
> > > 100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
> > > SGMII1       SGMII Port 1                                        0x705000   0x705ffc
> > > SGMII2       SGMII Port 2                                        0x706000   0x706ffc
> > > SGMII3       SGMII Port 3                                        0x707000   0x707ffc
> > > SGMII4       SGMII Port 4                                        0x708000   0x708ffc
> > > 100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc
> > 
> > All in drivers/net.
> 
> I've not been following this conversation too much, but i would like
> to point out that what you find in drivers/net is not a uniform set of
> drivers, but a collection of different driver types.
> 
> SWITCH might belong on drivers/net/dsa
> 100BASE-T1 might belong on drivers/net/mdio
> SGMIIX might belong in drivers/net/pcs
> 100BASE-TX might belong in drivers/net/mdio
> 
> I also expect those T1 and TX PHYs have drivers in drivers/net/phy,
> but they are not memory mapped, so not on your list.
> 
> Each driver can probe independently, registering with different parts
> of the net core. And then the switch driver will link all the parts
> together using phandles.
> 
> Saying that all the sub drivers are in drivers/net seems an odd
> argument it is not an MFD.

Okay, I'm convinced.  Thanks for the additional context.

-- 
Lee Jones [李琼斯]

