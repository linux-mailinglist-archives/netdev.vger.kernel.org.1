Return-Path: <netdev+bounces-235105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDCC2C079
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A491883ED2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D52116F4;
	Mon,  3 Nov 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3nlO9/2Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9F1DF24F;
	Mon,  3 Nov 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175791; cv=none; b=lIVGflgBD+0W2TV9gG/MxqmwTdxcizfoVjgIGlP7O2cmbqNChTQ0keZnM+SLJepWcSJjkh8AfTsdT7Cy7Ec8vItnhSPVVZ4cHKq+hBz8k+OoqBr3BKLkB14BjRi0Jtr2Le6H4rRw/yeQ+wVbB3oDKPS0OtHHW29UrjESk/iW5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175791; c=relaxed/simple;
	bh=RS+edTG+MOF/a0RYfyBazFVhDI9bve35ADPbL2FNpp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIKXUJgzM5vHSBCIQWR2nQ87TEvWEqjOb6Kdb5JIGMHF3RVWAS0dJFoZ5l+YFg48aw0g/3LcFXStC/ueM6j8jwAGNSgOvJfj/wn1K5HSmQB/87JbKN1a+79e8+J8UZke+fipeTEz+MCiWhZGJiX7uOl4DVVIZtXfpSQwhW64az4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3nlO9/2Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q54XyotxDzl0Do/tOaZrlIdoln6H4SaGnU+6mMDDVKU=; b=3nlO9/2Z8LUvgu1+VI453njg4R
	krenkInq7j6bIs7MmsoxnEZN6gZt8AVCXr+JYfEhZ7PQHQCQvSCwokHPGZNuaO+bU/ndRM2xr91Rt
	N7+AAciZM8nSSD091W+JJk79YIzhP/a6ZcTqm2MFdmFmdVJlN9g34tSDi50uhjy7cgEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFuPz-00CmX9-SX; Mon, 03 Nov 2025 14:16:19 +0100
Date: Mon, 3 Nov 2025 14:16:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Message-ID: <82a5d4b9-9327-4f0e-86ec-8861e1de57f2@lunn.ch>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
 <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <157cf60d-5fc2-4da0-be71-3c495e018c3d@lunn.ch>
 <PAXPR04MB8510D431ACAF445F8E516A0288C7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510D431ACAF445F8E516A0288C7A@PAXPR04MB8510.eurprd04.prod.outlook.com>

> > So you have up to 32 virtual MDIO busses stacked on top of one
> 
> Theoretically, there are up to 33 virtual MDIO buses, 32 port MDIO +
> 1 'EMDIO function'. The EMDIO function can access all the PHYs on
> the physical MDIO bus.

The EMDIO function sound dangerous. All the locking and PHY drivers
assume they have exclusive access to a devices on the bus. Bad things
will happen if they don't. And given how infrequently MDIO is
typically used, such bugs are going to be hard to find.

You might want to make the 32 port MDIOs and the EMDIO mutually
exclusive, so you can eliminate those potential bugs.

	   Andrew

