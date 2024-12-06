Return-Path: <netdev+bounces-149729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0669E6F52
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4D4283AC2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DCD1925AE;
	Fri,  6 Dec 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3o6mit1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883179D2;
	Fri,  6 Dec 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491906; cv=none; b=cXVpHQeDyviIpaQ3L0IMGU66KGFPoXyfDxjjooJwKfa0Cfx0SdnUESCj17iHq2P9ZWBNjsiLxysJjPoqIJ/CRZZIbt+Apmln4E6dfKN3LEE6GpGWKd65CeBKAzm+PRJpMlWCPRDp9J+eEMR1brdvu4meWwymZwbG+JJF0UaiTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491906; c=relaxed/simple;
	bh=lVHr4EPApzBT0shqeiUzPtW7g+/3CUZBqO46WoEfjEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpbzL/JRW7h7yX2ZllRJ25mfydQUiMSDkRVvqDiGPsGVibaU1o0nFZDkJToKHBPC9Rnw6zMJ69ym3Jx87Da8o2o6xXQz4hwJOKBGJmVBwrBS420PwViRAlAzXASPOOaJFL8w6pCwW+NntyVdG7pAWqMdMzN8AE+/YO910O10UOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3o6mit1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AB5C4CED1;
	Fri,  6 Dec 2024 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733491905;
	bh=lVHr4EPApzBT0shqeiUzPtW7g+/3CUZBqO46WoEfjEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3o6mit1UqcwGYmyEIMw7d1pTyDmTOImJPMYQ9Of67e0W5YuQUdFOBp/Ebm2F/jPF
	 HiEx1ptu3P7Jl3QJaCNwzMN4uQxNwyWv8w9jfCUBjqiFqIY0NMOqj4dxLJIh+CBQu8
	 PrfVCavddeVNyzGip/FiyV0fUuYLhQfQOLBpo0BbMRaEtbx5je+F1xFoMnZxzk8aj8
	 t3vBKbIJh0GNaTeADeQKjWtfoR/y6jhnExEsWMCFl0BEoKYmZxiCB/NJfWIAAznSRd
	 MMpS9VzWLLbStb+ouYmjNuFwShOeRnznPRwgmiDN4qPhVJ0TqCpSlJd9pdoQ56jXAZ
	 SA9vuwtjNJiXQ==
Date: Fri, 6 Dec 2024 13:31:41 +0000
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
Subject: Re: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Message-ID: <20241206133141.GR2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-3-wei.fang@nxp.com>
 <20241206093708.GI2581@kernel.org>
 <PAXPR04MB8510D797ABEFA1D6153A3C9A88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241206123219.GN2581@kernel.org>
 <PAXPR04MB851043CBB0B4458BACE0AEBE88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB851043CBB0B4458BACE0AEBE88312@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Dec 06, 2024 at 12:38:49PM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2024年12月6日 20:32
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
> > offload for i.MX95 ENETC
> > 
> > On Fri, Dec 06, 2024 at 10:46:49AM +0000, Wei Fang wrote:
> > > > -----Original Message-----
> > > > From: Simon Horman <horms@kernel.org>
> > > > Sent: 2024年12月6日 17:37
> > > > To: Wei Fang <wei.fang@nxp.com>
> > > > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > > > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > > > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > > > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > imx@lists.linux.dev
> > > > Subject: Re: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx
> > > > checksum offload for i.MX95 ENETC
> > > >
> > > > On Wed, Dec 04, 2024 at 01:29:29PM +0800, Wei Fang wrote:
> > > > > In addition to supporting Rx checksum offload, i.MX95 ENETC also
> > > > > supports Tx checksum offload. The transmit checksum offload is
> > > > > implemented through the Tx BD. To support Tx checksum offload,
> > > > > software needs to fill some auxiliary information in Tx BD, such
> > > > > as IP version, IP header offset and size, whether L4 is UDP or TCP, etc.
> > > > >
> > > > > Same as Rx checksum offload, Tx checksum offload capability isn't
> > > > > defined in register, so tx_csum bit is added to struct
> > > > > enetc_drvdata to indicate whether the device supports Tx checksum
> > offload.
> > > > >
> > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > > >
> > > > ...
> > > >
> > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > > b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > > > index 4b8fd1879005..590b1412fadf 100644
> > > > > --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > > > @@ -558,7 +558,12 @@ union enetc_tx_bd {
> > > > >  		__le16 frm_len;
> > > > >  		union {
> > > > >  			struct {
> > > > > -				u8 reserved[3];
> > > > > +				u8 l3_start:7;
> > > > > +				u8 ipcs:1;
> > > > > +				u8 l3_hdr_size:7;
> > > > > +				u8 l3t:1;
> > > > > +				u8 resv:5;
> > > > > +				u8 l4t:3;
> > > > >  				u8 flags;
> > > > >  			}; /* default layout */
> > > >
> > > > Hi Wei,
> > > >
> > > > Given that little-endian types are used elsewhere in this structure
> > > > I am guessing that the layout above works for little-endian hosts
> > > > but will not work on big-endian hosts.
> > > >
> > > > If so, I would suggest an alternate approach of using a single
> > > > 32-bit word and accessing it using a combination of FIELD_PREP() and
> > > > FIELD_GET() using masks created using GENMASK() and BIT().
> > >
> > > Good suggestion, I will refine it, thanks.
> > 
> > Thanks. I forgot to mention that you will likely also need to add
> > cpu_to_le32 and le32_to_cpu to the mix.
> > 
> 
> I think I will use u8 instead of 32-bit, because I don't want to affect
> the existing 'u8 flag'. And u8 is good enough.

Sure, I agree that looks like it should work.

