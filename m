Return-Path: <netdev+bounces-51048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EF7F8CAF
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2D1C20A56
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54C2C858;
	Sat, 25 Nov 2023 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IcbV9MgE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D0106
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IgEUU3pZaCYeudUP0Sz7vrbKJ6aAjYQiGMJBwYXOTuc=; b=IcbV9MgEd3YfRRs6cjng2B2BEc
	4RmlDZlDTszha1F3jWYisg2lwsnQ83xcwu07dxP68U2yNle30fRuvGPHks7EFIuVR9qZoDyrm0XbH
	/vDlOzP9q0cwLY/7bDnyPUaIwWk4bkH66nORjepCtAbkEyd/KF4xIaf2ec3fIQ3ulMlM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6wII-001CT3-Ce; Sat, 25 Nov 2023 18:18:14 +0100
Date: Sat, 25 Nov 2023 18:18:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 10/10] net: phylink: use the PHY's
 possible_interfaces if populated
Message-ID: <60551ce1-80f5-49e1-9e1d-81c71ab2e11e@lunn.ch>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
 <E1r6VIV-00DDMF-Pi@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r6VIV-00DDMF-Pi@rmk-PC.armlinux.org.uk>

On Fri, Nov 24, 2023 at 12:28:39PM +0000, Russell King (Oracle) wrote:
> Some PHYs such as Aquantia, Broadcom 84881, and Marvell 88X33x0 can
> switch between a set of interface types depending on the negotiated
> media speed, or can use rate adaption for some or all of these
> interface types.
> 
> We currently assume that these are Clause 45 PHYs that are configured
> not to use a specific set of interface modes, which has worked so far,
> but is just a work-around. In this workaround, we validate using all
> interfaces that the MAC supports, which can lead to extra modes being
> advertised that can not be supported.
> 
> To properly address this, switch to using the newly introduced PHY
> possible_interfaces bitmap which indicates which interface modes will
> be used by the PHY as configured. We calculate the union of the PHY's
> possible interfaces and MACs supported interfaces, checking that is
> non-empty. If the PHY is on a SFP, we further reduce the set by those
> which can be used on a SFP module, again checking that is non-empty.
> Finally, we validate the subset of interfaces, taking account of
> whether rate matching will be used for each individual interface mode.
> 
> This becomes independent of whether the PHY is clause 22 or clause 45.
> 
> It is encouraged that all PHYs that switch interface modes or use
> rate matching should populate phydev->possible_interfaces.
> 
> Tested-by: Luo Jie <quic_luoj@quicinc.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

