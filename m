Return-Path: <netdev+bounces-155880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE02BA042D8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E6D161180
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E31F1913;
	Tue,  7 Jan 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCc0pZLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273511F1311
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260868; cv=none; b=oEx0/B2UCur7d4ssEDycIEqSLXW3aanwtPwulsEbmlgUeUaryQR9rgUi+9fvDMfAwR8zIkUEprTVkmDrDlN+nskqGzoBkAeGXKjjcrY/Z3BPRPk8Dg/utcB2/jwsM+r6R6DLUvOWVkU0dhpgHFu15JovFP21VkqVKmal8JiQ8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260868; c=relaxed/simple;
	bh=Fm54NFKxpCer1yj0tlCPm8daKKZ3zQKs8KdgFK7i0r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhCx7TmiV8Ql0kemgpUBOT8qkRrbNTge35EAnyCLi8Lucwr0ntFkESo6VmzII3snj0RXEt9MYhaUvw0ocllYUhywCmA5JPPG8sOyQIvEWp/d71/8q29841Vqbw0vCp078sQbaCbasta6w2toDKlu+UhbgA6KTTOtq7zy3GqmFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCc0pZLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08487C4CED6;
	Tue,  7 Jan 2025 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736260867;
	bh=Fm54NFKxpCer1yj0tlCPm8daKKZ3zQKs8KdgFK7i0r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCc0pZLn5PRwtj2bDqvy9l0P08SW3iNYULWsw9OD4KMgEwI7FImqoRhAsK61anQtY
	 bsnW1U7j/UYZQr6m5feLqcycuFT+1lO28KfR5d7ABZ58afQbFF3fzxnSNcsjW9uY62
	 C2LgXTKRRObyPWgald3Ce2Mu6IRDZK9vqX/WNUg8WU8sK7XYFwAtyXpk/pkkO/N42M
	 uEK1SIeDIsKrJgyxpcV8D//caXY2pz1bCc7pJgjxI7Rsopo55xMME/Gn6/lnef2uIO
	 Mx6+t3jO6PrQ6AH/AtWgu2bZbVp7lpFb6vbJzEsC6rWTRlhTkvSqp/0I6/+ir1MouF
	 m2H2PsWVOXVEw==
Date: Tue, 7 Jan 2025 14:41:03 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/17] net: stmmac: use correct type for
 tx_lpi_timer
Message-ID: <20250107144103.GB5872@kernel.org>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
 <20250107112851.GE33144@kernel.org>
 <Z30WmPpMp_BRgrOI@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30WmPpMp_BRgrOI@shell.armlinux.org.uk>

On Tue, Jan 07, 2025 at 11:57:12AM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 07, 2025 at 11:28:51AM +0000, Simon Horman wrote:
> > On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> > > The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> > > Use u32 to store this internally within stmmac rather than "int"
> > > which could misinterpret large values.
> > > 
> > > Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> > > should be unsigned to avoid a negative number being interpreted as a
> > > very large positive number.
> > > 
> > > Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> > > rather than int, which is derived from tx_lpi_timer, even though
> > > masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> > > value argument type for writel().
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index 9a9169ca7cd2..b0ef439b715b 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -111,8 +111,8 @@ static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
> > >  				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
> > >  
> > >  #define STMMAC_DEFAULT_LPI_TIMER	1000
> > > -static int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > > -module_param(eee_timer, int, 0644);
> > > +static unsigned int eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > > +module_param(eee_timer, uint, 0644);
> > >  MODULE_PARM_DESC(eee_timer, "LPI tx expiration time in msec");
> > >  #define STMMAC_LPI_T(x) (jiffies + usecs_to_jiffies(x))
> > >  
> > 
> > Hi Russell,
> > 
> > now that eee_timer is unsigned the following check in stmmac_verify_args()
> > can never be true. I guess it should be removed.
> > 
> >         if (eee_timer < 0)
> >                 eee_timer = STMMAC_DEFAULT_LPI_TIMER;
> > 
> 
> Thanks for finding that. The parameter description doesn't seem to
> detail whether this is intentional behaviour or not, or whether it is
> "because someone used int and we shouldn't have negative values here".
> 
> I can't see why someone would pass a negative number for eee_timer
> given that it already defaults to STMMAC_DEFAULT_LPI_TIMER.
> 
> So, I'm tempted to remove this.

I'm not sure either. It did cross my mind that the check could be changed,
to disallow illegal values (if the range of legal values is not all
possible unsigned integer values). But it was just an idea without any
inspection of the code or thought about it's practicality. And my first
instinct was the same as yours: remove the check.

