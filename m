Return-Path: <netdev+bounces-149698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB72A9E6E2A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953A81626C0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA81DDA30;
	Fri,  6 Dec 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx8YRFDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54D189912;
	Fri,  6 Dec 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488236; cv=none; b=avioXFt5oMRcbANbFpITaxthgmgAN7DLL1N+ettRsB/KJAngcow6NHnnWKPI0UVtSaeUkYMF47XBsjVNYf05H0/2xQznWkafsfAzYcVrki9FfKfdqGVcTUFxOFxC8M1ijp4Nqq6B2EenmfTteu3Dr/BqIGXH/fvy1B9XH8GFas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488236; c=relaxed/simple;
	bh=2SybpJ75fYsgju996eI5B6rZW6Vasmh/0y64HEmorP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C53j4S8QKCDETPiT4UKZ5gMvxb2vhCiZBrXO0LymFE18st11wKh6+njHZ4iKPvAlgmR2fmygZB413CZl3+CBO6b7T2ZQhMuie4MuU52qZRYATVre0+t9tXeOADrUeO5WCJIgenm7IdZUw87JVPHJ1X6+/rFFcEzPrSKX9xmYNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx8YRFDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1435C4CED1;
	Fri,  6 Dec 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488235;
	bh=2SybpJ75fYsgju996eI5B6rZW6Vasmh/0y64HEmorP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rx8YRFDenjNPSg5EDwgAon21iwlHBcuwKtlnJR0w4VZ4S/KmX03qrL4hyyaJe9/gC
	 jnfMG1TXWWR8cNILNWX20yTblC3fq+RBykko4SU0x0D09nt4BJVFX8XJ1N7aoiXlmC
	 yU4tAIOsOsjkuSJF4KDOOZuax56pIjkqPAdu4QTRc+Iy47H4oun1djTulTFBAmZW2Q
	 kLLh7ugN+hoqTBCl8R80bZYjU0EvJe0D+v0Hq5+UgkBDRYQlWJdZG45V1ecglxteFd
	 UuV/gbOgllDcis7793OG4Abjc/RRPgKqCF2KFlU0oHl2iuL0iN0gAYbAiWCjWzxyXY
	 idmJvLYqRqLDQ==
Date: Fri, 6 Dec 2024 12:30:30 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Message-ID: <20241206123030.GM2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com>
 <20241206092329.GH2581@kernel.org>
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Dec 06, 2024 at 10:33:15AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2024年12月6日 17:23
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
> > offload for i.MX95 ENETC
> > 
> > On Wed, Dec 04, 2024 at 01:29:28PM +0800, Wei Fang wrote:
> > > ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
> > > 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
> > > this capability is not defined in register, the rx_csum bit is added to
> > > struct enetc_drvdata to indicate whether the device supports Rx checksum
> > > offload.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > > ---
> > > v2: no changes
> > > v3: no changes
> > > v4: no changes
> > > v5: no changes
> > > v6: no changes
> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
> > >  drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
> > >  drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
> > >  .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
> > >  4 files changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > index 35634c516e26..3137b6ee62d3 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > @@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr
> > *rx_ring,
> > >
> > >  	/* TODO: hashing */
> > >  	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
> > > -		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > -
> > > -		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> > > -		skb->ip_summed = CHECKSUM_COMPLETE;
> > > +		if (priv->active_offloads & ENETC_F_RXCSUM &&
> > > +		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK)
> > {
> > > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > +		} else {
> > > +			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > +
> > > +			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> > > +			skb->ip_summed = CHECKSUM_COMPLETE;
> > > +		}
> > >  	}
> > 
> > Hi Wei,
> > 
> > I am wondering about the relationship between the above and
> > hardware support for CHECKSUM_COMPLETE.
> > 
> > Prior to this patch CHECKSUM_COMPLETE was always used, which seems
> > desirable. But with this patch, CHECKSUM_UNNECESSARY is conditionally used.
> > 
> > If those cases don't work with CHECKSUM_COMPLETE then is this a bug-fix?
> > 
> > Or, alternatively, if those cases do work with CHECKSUM_COMPLETE, then
> > I'm unsure why this change is necessary or desirable. It's my understanding
> > that from the Kernel's perspective CHECKSUM_COMPLETE is preferable to
> > CHECKSUM_UNNECESSARY.
> > 
> > ...
> 
> Rx checksum offload is a new feature of ENETC v4. We would like to exploit this
> capability of the hardware to save CPU cycles in calculating and verifying checksum.
> 

Understood, but CHECKSUM_UNNECESSARY is usually the preferred option as it
is more flexible, e.g. allowing low-cost calculation of inner checksums
in the presence of encapsulation.

