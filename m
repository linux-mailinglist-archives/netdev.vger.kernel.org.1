Return-Path: <netdev+bounces-149700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CB9E6E33
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245CF2810C7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B026E20124E;
	Fri,  6 Dec 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPR3kDjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2E200135;
	Fri,  6 Dec 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488344; cv=none; b=MSbFAQwFuvwgDm56SM/vRcSWUWyKFq36nMSVVNHzJDaV1IBzce1ixMKkimngzIRa58FT2ElFqom5a3SnfMUNK17yGcb/IVaRAsFmVS48nFYNq1BfltF3b0e5DjJbZV7hfc7X+VxYiILvfvVJ4JGEMfthj8sodfKw2P2ekwGJAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488344; c=relaxed/simple;
	bh=w/ls8XXs5aUyevc75S13Ak3D8BY0kudJCVt5TOtgEQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcFqSwgm9nZuhekuh4U0KLvAUfkyvPQl6/HqtW0fmtPA79jq3XSn5VqcPdzsCOcWqN+8+0SRaHIzyWmR7RYkQwUDw5r5YQ2wJwglHabYtUiWxfGPRoCOdDSX48pjSA7v05x2VFEY0dStBLG5OqDYpcTkyvLe5olGux95t8hUkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPR3kDjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E3EC4CED1;
	Fri,  6 Dec 2024 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488344;
	bh=w/ls8XXs5aUyevc75S13Ak3D8BY0kudJCVt5TOtgEQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPR3kDjQz0Sb6HZVaCIGX8RIv6cIFwyCtU+CqXdLr0vHVbeOa+Up2HBiKBlzJzn1H
	 AQ7GqKPTAYSQjtkb8G9udoz7OsYSc0lRZl4da7b41QvDepcbU9tQWM8K/L5CbPi9e+
	 3LZQQt6Kf2yBZ+tcEOVX6TP7BCw3YVgNzj21FH/d636HTKkImyctF3uFjisdYzAFcx
	 AuaH/BfMibdJltJcgVlBbwem3DMjgyFCxgd7cBbf2w/0B76IxYxM7gS+HlH81f/1KU
	 okFSnxuxwnTdf7e3s6YtltHck/TvZhNp1G6QJzCVvoxNsJXJbWuUBSsxHh+YfIP/6D
	 YBPpXt2KaAP5g==
Date: Fri, 6 Dec 2024 12:32:19 +0000
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
Message-ID: <20241206123219.GN2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-3-wei.fang@nxp.com>
 <20241206093708.GI2581@kernel.org>
 <PAXPR04MB8510D797ABEFA1D6153A3C9A88312@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510D797ABEFA1D6153A3C9A88312@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Dec 06, 2024 at 10:46:49AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2024年12月6日 17:37
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; imx@lists.linux.dev
> > Subject: Re: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
> > offload for i.MX95 ENETC
> > 
> > On Wed, Dec 04, 2024 at 01:29:29PM +0800, Wei Fang wrote:
> > > In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> > > Tx checksum offload. The transmit checksum offload is implemented through
> > > the Tx BD. To support Tx checksum offload, software needs to fill some
> > > auxiliary information in Tx BD, such as IP version, IP header offset and
> > > size, whether L4 is UDP or TCP, etc.
> > >
> > > Same as Rx checksum offload, Tx checksum offload capability isn't defined
> > > in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> > > whether the device supports Tx checksum offload.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > index 4b8fd1879005..590b1412fadf 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > > @@ -558,7 +558,12 @@ union enetc_tx_bd {
> > >  		__le16 frm_len;
> > >  		union {
> > >  			struct {
> > > -				u8 reserved[3];
> > > +				u8 l3_start:7;
> > > +				u8 ipcs:1;
> > > +				u8 l3_hdr_size:7;
> > > +				u8 l3t:1;
> > > +				u8 resv:5;
> > > +				u8 l4t:3;
> > >  				u8 flags;
> > >  			}; /* default layout */
> > 
> > Hi Wei,
> > 
> > Given that little-endian types are used elsewhere in this structure
> > I am guessing that the layout above works for little-endian hosts
> > but will not work on big-endian hosts.
> > 
> > If so, I would suggest an alternate approach of using a single 32-bit
> > word and accessing it using a combination of FIELD_PREP() and FIELD_GET()
> > using masks created using GENMASK() and BIT().
> 
> Good suggestion, I will refine it, thanks.

Thanks. I forgot to mention that you will likely also need to add
cpu_to_le32 and le32_to_cpu to the mix.

> > Or, less desirably IMHO, by providing an alternate layout for
> > the embedded struct for big endian systems.
> > 
> > ...
> 

