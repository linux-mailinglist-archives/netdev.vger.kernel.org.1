Return-Path: <netdev+bounces-150818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DC9EBA9E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09B5166490
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E4226875;
	Tue, 10 Dec 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szpDhWI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C008633A;
	Tue, 10 Dec 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861285; cv=none; b=p+cqUNWNydE+wrZN+W7I0YPH+3fArVbYGVwea9z4r8azL2H+XIzD8J7VBfeMaS5JQJ6hT4K3QGRzn7f9SCY2QC52lN+/BMxC8NgbOaWyWbd8kUXY4EywwOle18S83+XTW3GqrNvSDwU/BGims1i1bZz7lCjj8Gbnzp9y/lLVINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861285; c=relaxed/simple;
	bh=QjP0IIasjtVnXM9smYkNwrOQvlReXf+3UjfE/cman1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTAR/koJIYfz/QWuf/8D0Di5K3CIcYV2wgi0h3LBfJhK8KrMCo4axMykIRFw08b4Mxp8qIX/QOWiv7LNdRym/fHoLijCW1Z48foX6TbRyo3VeUSrvLmnUDtLB7wBXl6LrGzX0GuD6vv7RQoZO/pESzWTuwP4cJBJUq/bRHAVoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szpDhWI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB37C4CED6;
	Tue, 10 Dec 2024 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733861284;
	bh=QjP0IIasjtVnXM9smYkNwrOQvlReXf+3UjfE/cman1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szpDhWI9OcT8EyJuU64yF0TWflIZVNKNrw4b4C9zR3GizRitmrpqEImIQ3V/+nVhH
	 YSC89R8OY/F8A+4Me1YKuFwoUqXd59x5gUo6SsP67KtO4itELnMEdo+7Vo8omyGulA
	 Fg/xppxVqf4af72sh94+n2cIw+zlYzQm2M9Voy+OFdAomPsGzuQkZLmu7N8Pkq7EMe
	 4N13boG/L3wlJsAw5ykYx6K+NjJRTz3yXyLY/s0T6srjGNDEsAT1mea+ESZEP/1vpC
	 MH/gkiHvHvtMZkMETMnYHtw1gGlXFzokHOlOZDrRs1Gt8Ir/c4eyI4xkEbpI8hfKi4
	 9sBaL+AAMqeeQ==
Date: Tue, 10 Dec 2024 20:07:59 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	"tom@herbertland.com" <tom@herbertland.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
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
Message-ID: <20241210200759.GD2806@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com>
 <20241206092329.GH2581@kernel.org>
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123030.GM2581@kernel.org>
 <PAXPR04MB85107FD857F1AB33BBE4F70988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Z1W_kSMUp3lsLPr_@shredder>
 <PAXPR04MB85101F4E12086B8E0A471580883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85101F4E12086B8E0A471580883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Tue, Dec 10, 2024 at 07:49:18AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Ido Schimmel <idosch@idosch.org>
> > Sent: 2024年12月8日 23:47
> > To: Wei Fang <wei.fang@nxp.com>; tom@herbertland.com
> > Cc: Simon Horman <horms@kernel.org>; Claudiu Manoil
> > <claudiu.manoil@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>; Clark
> > Wang <xiaoning.wang@nxp.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Frank Li <frank.li@nxp.com>; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
> > offload for i.MX95 ENETC
> > 
> > On Fri, Dec 06, 2024 at 12:45:02PM +0000, Wei Fang wrote:
> > > > -----Original Message-----
> > > > From: Simon Horman <horms@kernel.org>
> > > > Sent: 2024年12月6日 20:31
> > > > To: Wei Fang <wei.fang@nxp.com>
> > > > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > > > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > > > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > > > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > > > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
> > > > offload for i.MX95 ENETC
> > > >
> > > > On Fri, Dec 06, 2024 at 10:33:15AM +0000, Wei Fang wrote:
> > > > > > -----Original Message-----
> > > > > > From: Simon Horman <horms@kernel.org>
> > > > > > Sent: 2024年12月6日 17:23
> > > > > > To: Wei Fang <wei.fang@nxp.com>
> > > > > > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > > > > > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > > > > > andrew+netdev@lunn.ch; davem@davemloft.net;
> > edumazet@google.com;
> > > > > > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > > > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > imx@lists.linux.dev
> > > > > > Subject: Re: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx
> > checksum
> > > > > > offload for i.MX95 ENETC
> > > > > >
> > > > > > On Wed, Dec 04, 2024 at 01:29:28PM +0800, Wei Fang wrote:
> > > > > > > ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the
> > bit
> > > > > > > 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
> > > > > > > this capability is not defined in register, the rx_csum bit is added to
> > > > > > > struct enetc_drvdata to indicate whether the device supports Rx
> > > > checksum
> > > > > > > offload.
> > > > > > >
> > > > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > > > > > > ---
> > > > > > > v2: no changes
> > > > > > > v3: no changes
> > > > > > > v4: no changes
> > > > > > > v5: no changes
> > > > > > > v6: no changes
> > > > > > > ---
> > > > > > >  drivers/net/ethernet/freescale/enetc/enetc.c       | 14
> > > > ++++++++++----
> > > > > > >  drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
> > > > > > >  drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
> > > > > > >  .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
> > > > > > >  4 files changed, 17 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > > > index 35634c516e26..3137b6ee62d3 100644
> > > > > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > > > > > @@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct
> > > > enetc_bdr
> > > > > > *rx_ring,
> > > > > > >
> > > > > > >  	/* TODO: hashing */
> > > > > > >  	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
> > > > > > > -		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > > > > > -
> > > > > > > -		skb->csum = csum_unfold((__force
> > > > __sum16)~htons(inet_csum));
> > > > > > > -		skb->ip_summed = CHECKSUM_COMPLETE;
> > > > > > > +		if (priv->active_offloads & ENETC_F_RXCSUM &&
> > > > > > > +		    le16_to_cpu(rxbd->r.flags) &
> > > > ENETC_RXBD_FLAG_L4_CSUM_OK)
> > > > > > {
> > > > > > > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > > > > > +		} else {
> > > > > > > +			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> > > > > > > +
> > > > > > > +			skb->csum = csum_unfold((__force
> > > > __sum16)~htons(inet_csum));
> > > > > > > +			skb->ip_summed = CHECKSUM_COMPLETE;
> > > > > > > +		}
> > > > > > >  	}
> > > > > >
> > > > > > Hi Wei,
> > > > > >
> > > > > > I am wondering about the relationship between the above and
> > > > > > hardware support for CHECKSUM_COMPLETE.
> > > > > >
> > > > > > Prior to this patch CHECKSUM_COMPLETE was always used, which seems
> > > > > > desirable. But with this patch, CHECKSUM_UNNECESSARY is conditionally
> > > > used.
> > > > > >
> > > > > > If those cases don't work with CHECKSUM_COMPLETE then is this a
> > > > bug-fix?
> > > > > >
> > > > > > Or, alternatively, if those cases do work with CHECKSUM_COMPLETE,
> > then
> > > > > > I'm unsure why this change is necessary or desirable. It's my
> > understanding
> > > > > > that from the Kernel's perspective CHECKSUM_COMPLETE is preferable
> > to
> > > > > > CHECKSUM_UNNECESSARY.
> > > > > >
> > > > > > ...
> > > > >
> > > > > Rx checksum offload is a new feature of ENETC v4. We would like to exploit
> > > > this
> > > > > capability of the hardware to save CPU cycles in calculating and verifying
> > > > checksum.
> > > > >
> > > >
> > > > Understood, but CHECKSUM_UNNECESSARY is usually the preferred option
> > as
> > > > it
> > > > is more flexible, e.g. allowing low-cost calculation of inner checksums
> > > > in the presence of encapsulation.
> > >
> > > I think you mean 'CHECKSUM_COMPLETE' is the preferred option. But there is
> > no
> > > strong reason against using CHECKSUM_UNNECESSARY. So I hope to keep this
> > patch.
> > 
> > I was also under the impression that CHECKSUM_COMPLETE is more desirable
> > than CHECKSUM_UNNECESSARY. Maybe Tom can help.
> 
> From the kernel doc [1] it should be necessary to use CHECKSUM_COMPLETE in
> enetc driver, because ENETCv4 only supports UDP/TCP checksum offload. So I will
> drop this patch from the patch set. thanks.

Thanks.

> 
> [1] https://docs.kernel.org/networking/skbuff.html#:~:text=Even%20if%20device%20supports%20only%20some%20protocols%2C%20but%20is%20able%20to%20produce%20skb%2D%3Ecsum%2C%20it%20MUST%20use%20CHECKSUM_COMPLETE%2C%20not%20CHECKSUM_UNNECESSARY.

