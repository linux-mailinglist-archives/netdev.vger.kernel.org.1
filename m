Return-Path: <netdev+bounces-196113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1630AD38D3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080AB172E15
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1A29CB5B;
	Tue, 10 Jun 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0t4YqEXI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F929DB61;
	Tue, 10 Jun 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561183; cv=none; b=LsTxBq+6gAY+ECFnN/t69CWsuuociy9zNcQeWwR2+fzLf4ZzLF7XEelV2jqXzUbWn/oL4PJXMVd+OhgkLfotf4yXMc7eRWIv8GqEs3KGT4RZSGBnRRL73U/fUqf4LouRQsJRAwuKSiOwCPdom+Y9FUkh1TQ985OZMoq8BtVSdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561183; c=relaxed/simple;
	bh=DIddHnvEu+r4cX3U54N0dikQhHdYKSD9e1hqvrNphFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2cvAxOueC6agUREYm8BFnGUtjqQD1sSZ9imD07eUx5dVa2107+1J4kjzJNuvmrv4zCIVeNeMMGmZChwc4WBqt6W4OPcuMG2UNra543mizJ2qnVVkkzUdXJF0d3a4yTvXaYKJiMZmBthFVkzCtU7+mxaS4hJJB57tD+w28kdWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0t4YqEXI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z+69PO38Dug2JMh9w+wNLBY3VxYo6x8UuFy4TPZFXqk=; b=0t4YqEXISPThoEuoOcYST5i/lL
	ICGY/z17C0xp3zHOy57IIwS9vjdq7FXX4o3ExbMMYYDMpxe7k8Cj5kxxQkLn7Af61hZVwwp7h6kiL
	+drP5DXxJWoSYwGjhacy8u3NNEd43VB8T/Yh2Xlow2FnAeo/zAMB9bdVdvrbyJMfTXGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOymc-00FGwx-9R; Tue, 10 Jun 2025 15:12:54 +0200
Date: Tue, 10 Jun 2025 15:12:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: micrel: add MDI/MDI-X control
 support for KSZ9477 switch-integrated PHYs
Message-ID: <df3f4f74-50cc-42b2-8b41-913d4bcd211c@lunn.ch>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
 <20250610091354.4060454-2-o.rempel@pengutronix.de>
 <6597c2fd-077a-4eac-945f-97b43c130418@lunn.ch>
 <aEgpE7dZNT_GqhSV@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEgpE7dZNT_GqhSV@pengutronix.de>

On Tue, Jun 10, 2025 at 02:46:11PM +0200, Oleksij Rempel wrote:
> On Tue, Jun 10, 2025 at 02:31:45PM +0200, Andrew Lunn wrote:
> > On Tue, Jun 10, 2025 at 11:13:52AM +0200, Oleksij Rempel wrote:
> > > Add MDI/MDI-X configuration support for PHYs integrated in the KSZ9477
> > > family of Ethernet switches.
> > > 
> > > All MDI/MDI-X configuration modes are supported:
> > >   - Automatic MDI/MDI-X (ETH_TP_MDI_AUTO)
> > >   - Forced MDI (ETH_TP_MDI)
> > >   - Forced MDI-X (ETH_TP_MDI_X)
> > > 
> > > However, when operating in automatic mode, the PHY does not expose the
> > > resolved crossover status (i.e., whether MDI or MDI-X is active).
> > > Therefore, in auto mode, the driver reports ETH_TP_MDI_INVALID as
> > > the current status.
> > 
> > I assume you also considered returning ETH_TP_MDI_AUTO? What makes
> > INVALID better than AUTO?
> 
> The phydev->mdix_ctrl returns configuration state, which cant be set to
> ETH_TP_MDI_AUTO.
> The phydev->mdix should return actual crossover state, which is
> ETH_TP_MDI or ETH_TP_MDI_X. Setting it to ETH_TP_MDI_AUTO, would not
> provide any usable information.

[Goes and looks at the code]

#define ETH_TP_MDI_INVALID	0x00 /* status: unknown; control: unsupported */
#define ETH_TP_MDI		0x01 /* status: MDI;     control: force MDI */
#define ETH_TP_MDI_X		0x02 /* status: MDI-X;   control: force MDI-X */
#define ETH_TP_MDI_AUTO		0x03 /*                  control: auto-select */

So _AUTO is not listed as being valid as a status. And _INVALID has
the comment unkown. So:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


