Return-Path: <netdev+bounces-185035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B5A98490
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7F37A976B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3511F2B8E;
	Wed, 23 Apr 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="UbWrAVwp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muouxeg3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528001F4725
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398899; cv=none; b=IpKxTCDxtTeonaGx/qMkl9L5i2RG9FWS6o5s83GQMO12qW04fp4KrGvZDi0MaMMM7w6iuNPF5s0PKpFpAcJ7BFQfBCnfj5f+A/r8glvSKmfErPvlmDIRrm1bUffMsG2TPDYITgcS3NrsIQBns5NgMx4CGUAsh41p4sJMImvVJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398899; c=relaxed/simple;
	bh=BW7t9jNayRBf1ClggMJtd3Fp6+ccv9CeKKDviPbFIvQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G7xywhJ+pFq3GgZGArhTaB0/ivEzTs+Vdnj+1RiRoQENAS1DXhOzDJEzRp6f5RaaRjaNViQoLOE5SATC8+LcNZttJ+AzkDddcGKHylPgwd3qTfVq8XQ4h697pyKM39CVa3sRwsb6rjcQRx3+p7xKCFqii8BWkKLT45heNrMWJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=UbWrAVwp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muouxeg3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AE2625401C2;
	Wed, 23 Apr 2025 05:01:35 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-01.internal (MEProxy); Wed, 23 Apr 2025 05:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745398895; x=1745485295; bh=6rYiYxza8OupvFSqvlyUYjwG0PLM/T6t
	h/eLY3q8+V0=; b=UbWrAVwp6+3tHv4dVYXzafE8OXvFGiofevVO30MPlN+ghajb
	UIMmumAMqG6XYMmkp326WuVsmAQ2v7nu6quxehGti1mpISbfQLxtYbDxe53W8m1Z
	BGWZ1oREOORbbxJ+TA79XiJrtAs3A3M1cjY03MsVOSKUyRoB6nVH6/irduX8JNiK
	P0GN+DGPu4/UAJdH+babo/MUMjSTxMii2y4rrpg+qNYt3SgPK/8Okq+sUEadQw7U
	mBSqf+VwTZUMS8LcDgT38bvC3tndp3LeYUdNpRa3Ax1m9bCnZIp2p+GVJLQ2adkq
	DlfWUdZz8AJJIP60PqqF2GBDFd/lH54/XTGjlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745398895; x=
	1745485295; bh=6rYiYxza8OupvFSqvlyUYjwG0PLM/T6th/eLY3q8+V0=; b=m
	uouxeg3DLwsR4JXP1l4P6eYN49rF84EzyanNxjGBC3vqxNTFdZyajKtFOJrr79rq
	Cl/SaF8H+xCfd3JEIyvmtrHZYcOlDjFFVirjTbJlZIH9OCBSsSLnsOSXze9Sd5TS
	b72F7ttKw1drAeN41SbY9ZkPKQTXYkrRQnamGr4/jZltyOQP/ztsRGVH+2w3Dmcm
	xQgY2suxsvHezVei04wT8ZsOQtxjLSE8b5YsSEsZ5CqcB0rHAcajIyKl72xrEEth
	14q21aIIkJmPo3dtAbhfA/lSo8zt/4JaurfqlcFnUjrn+fRfeYmSVf0uWOvMxvCR
	dgwKfGbFgO6KSuQrUxMWA==
X-ME-Sender: <xms:bqwIaOxf2wpgrNlQnv6Hwo9s0YAHXO_wTj2Z70zFgPKo3YExfKrP2Q>
    <xme:bqwIaKT7GxWxlEnYkESW5y6N3KSBdWFf2epI6FBDW-9oX7DVUmb1Q1YKisfpSzIuK
    AWhWv_diZUYtdTCkgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfofgrthhhvgifucfotgeurhhiuggvfdcuoehmrghtthesthhrrg
    hvvghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnheptdelgfeiudelgeevgedv
    teegvdehtddvheeigeelgeegveetleetheffgfejgfeinecuffhomhgrihhnpehtrhgrvh
    gvrhhsvgdrtghomhdrrghupdgrrhhmlhhinhhugidrohhrghdruhhknecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrh
    hsvgdrtghomhdrrghupdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhkrghllhif
    vghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehiohgrnhgrrdgtihhorhhn
    vghisehngihprdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:bqwIaAXVj0tt7LWwTsWq4a27SWmSbkFfECWyM6GvCqc4rFCLXwy5lg>
    <xmx:bqwIaEidH2FGedOytoSeIiMuwROo8byXZ9Vxwtj8YxRG4PuBjUdNQA>
    <xmx:bqwIaABsaGxInNEqMjJroFK4HQgwO-NOk6WntKmnRbZkBBYztLk9VQ>
    <xmx:bqwIaFKYZApBaz_KYcFncWrNDytwnAFmRUexDH2tE4B0nXgfqHU6tQ>
    <xmx:b6wIaLV-7LNNYaJKvPprmYFG7MqLrOgMg8ng-tEDnDcfHDuCbDb-XhI9>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70ADA78006C; Wed, 23 Apr 2025 05:01:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7d5bb7b82feda5d9
Date: Wed, 23 Apr 2025 19:01:02 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 regressions@lists.linux.dev
Message-Id: <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
In-Reply-To: <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, Apr 23, 2025, at 2:03 AM, Russell King (Oracle) wrote:
> On Fri, Apr 18, 2025 at 01:02:19PM +1000, Mathew McBride wrote:
> > #regzbot introduced: 6561f0e547be221f411fda5eddfcc5bd8bb058a5
> > 
> > Hi Russell,
> > 
> > On Thu, Dec 5, 2024, at 8:42 PM, Russell King (Oracle) wrote:
> > > Report the PCS in-band capabilities to phylink for the Lynx PCS.
> > > 
> > 
> > The implementation of in-band capabilities has broken SFP+ (10GBase-R) mode on my LS1088 board.
> > The other ports in the system (QSGMII) work fine.
> 
> Thanks for the report.

Thanks Russell!

The diff below does fix the problem, 10G SFP's now link up again.

I should note that Alex Guzman was the one who originally reported the issue to me, he has also confirmed this diff resolves the issue.
Link: https://forum.traverse.com.au/t/sfp-ports-stop-working-with-linux-6-14-in-arch-linux/1076/4

> Please try the diff below:
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 1bdd5d8bb5b0..2147e2d3003a 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3624,6 +3624,15 @@ static int phylink_sfp_config_optical(struct phylink *pl)
> phylink_dbg(pl, "optical SFP: chosen %s interface\n",
>     phy_modes(interface));
>  
> + /* GBASE-R interfaces with the exception of KR do not have autoneg at
> + * the PCS. As the PCS is media facing, disable the Autoneg bit in the
> + * advertisement.
> + */
> + if (interface == PHY_INTERFACE_MODE_5GBASER ||
> +     interface == PHY_INTERFACE_MODE_10GBASER ||
> +     interface == PHY_INTERFACE_MODE_25GBASER)
> + __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
> +
> if (!phylink_validate_pcs_inband_autoneg(pl, interface,
> config.advertising)) {
> phylink_err(pl, "autoneg setting not compatible with PCS");
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

