Return-Path: <netdev+bounces-216771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A9B3518D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45263AEAA6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE8215077;
	Tue, 26 Aug 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lsFB/2yS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381961FCE;
	Tue, 26 Aug 2025 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174937; cv=none; b=SUg4TQeb3kQq8rJjdy4x2mY9B6fGy+2gGLWSi1t/bYAZOAouoah4samyQUfjQWHKZRkjQKQCozgbqtbMTsxrSoE/2LIEvPjVaTPD1u8ekNz/4MFfF3wqSJZD73BU3wqw233PqZWeBluD1eDVUVPxN67H2Hber5Nxl8gZAXk0o24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174937; c=relaxed/simple;
	bh=tmT/tLAdcoowbyD+cIQdPgCED88KbN3cZAQcTx5kPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou2dj47YvIcR8l7LXC7FDQNMP7gBqyKOPxmRe3keZCWsdCplFf2itlb7yatrPMNhY0N/3L+DrUV4nW9AEQSnlCTTcm+5c2Rl64ml4njlPOs3wzJBrN31/kmy9u6XDp6orMaDWrUC9qAlTc/5ZavW1htcvTn4Yf8npuItAgIhuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lsFB/2yS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g3/SB8WVXUI9MW5KiqhvBEppVZwamrXCShDQl7NKXqU=; b=lsFB/2ySab8xzmslwml7+LxKRV
	GXfCIehZvf1IHYXp6XeSx6v2zDPbK/um552AljNY2OS07OgrmcHCQqnlDT7XPi4mEpBWTgGUdHDVD
	viorhoS5eYgoszCjltQ+XwCcSfZv0GeL1spHRo+rHx95NXrG247x0KQqyn0y04LyIzaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqjJz-0061ZI-SP; Tue, 26 Aug 2025 04:22:03 +0200
Date: Tue, 26 Aug 2025 04:22:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Frank Li <frank.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Message-ID: <bb07efd0-d429-4fe0-bb55-b50b77e1cf88@lunn.ch>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-9-wei.fang@nxp.com>
 <13c4fe5a-878c-4a08-87df-f5bb96f0b589@lunn.ch>
 <AM9PR04MB85057F4330081C86176805E78839A@AM9PR04MB8505.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB85057F4330081C86176805E78839A@AM9PR04MB8505.eurprd04.prod.outlook.com>

On Tue, Aug 26, 2025 at 01:50:06AM +0000, Wei Fang wrote:
> > On Mon, Aug 25, 2025 at 12:15:25PM +0800, Wei Fang wrote:
> > > The NETC Timer supports to loop back the output pulse signal of Fiper-n
> > > into Trigger-n input, so that we can leverage this feature to validate
> > > some other features without external hardware support.
> > 
> > This seems like it should be a common feature which more PTP clocks
> > will support? Did you search around and see if there are other devices
> > with this?
> 
> Actually, the NETC v4 Timer is the same IP used in the QorIQ platforms,
> but it is a different version, and the ptp_qoriq driver is not compatible
> with NETC v4 Timer, I have stated in the patch ("ptp: netc: add NETC V4
> Timer PTP driver support").

That does not answer my question. Does Marvell have this loopback
concept? Intel? Freescale? Microchip? Is there anything which prevents
other vendors implementing it?

	Andrew


