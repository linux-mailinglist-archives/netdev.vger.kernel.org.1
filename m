Return-Path: <netdev+bounces-205658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B6AFF874
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 07:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3336A1780B2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C9280317;
	Thu, 10 Jul 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b="dpEcEaSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsZwvZgo"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6027F749
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125386; cv=none; b=e8fT5sPgGHk/EDmyK4tMqSa8lDSztzu5VFW1tUzoOUAaUVzaZuiUxRmAq2aNeShVu6S4K+vTol6fXqyyMN3j+VKCRLxO8neyiaV+uU7LmQaaXY9oXhB/mPNtha3GSJk2+wP2uKaGNEZrSK7pqvLb9bK/aN4FJap3cR6y+X/a/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125386; c=relaxed/simple;
	bh=/QPuXsPagYMGpuO++ga2bvKg6r8N2PD+9bXgY6UAalA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ita/K7n7Qbf4d4JEV61Ct3bCqbw9tYyOAqUp9FjDvbrQCg5U68uOSNZ3HuEwcT8wSaZvNQzXzQr4t8YA7fVHWQxN0/15BU3BjTtXY8ZthanDwlb47istVxDj0YH6A5iTa5znFXCJCNTyE11xeJCCQsh2fBzqIl6Ez+QTyZDeiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au; spf=pass smtp.mailfrom=traverse.com.au; dkim=pass (2048-bit key) header.d=traverse.com.au header.i=@traverse.com.au header.b=dpEcEaSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsZwvZgo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 08B2EEC02C4;
	Thu, 10 Jul 2025 01:29:42 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-01.internal (MEProxy); Thu, 10 Jul 2025 01:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1752125382; x=1752211782; bh=MMdcP6sTGpt1a34kdXef9pIIHzLJ2Phl
	UnquDYalTow=; b=dpEcEaSB+rvHX7NOtf3DLw2cIXI6kRIBtQyH+moUZPxnaPeQ
	jTThoXdLvKtXuWfqrEvreXnfq5QClZVEsgn9Em7OEZsDihS9Ta1LwaxyQzG/b0sd
	fVBiKea1uwLnrrLNDB35P0CSuaWvqDtEpoFWqrnrG4Zb6SOmFVkVCPML/Z21nY97
	7sW61daFgD7B0vf1peVaKmyJ7GNqYC0/qdA9wZRJPzub7E+LURdj/qk9CIFkGpnj
	1Iw+lSM1majH3Z1kndffLbYB3XqvtzjRnpef61BdHj5df13Qhhf228UxvKvaZ/8d
	OCksksHEk/5g/IRQmWSNkftOaq9j77BRM8azUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752125382; x=
	1752211782; bh=MMdcP6sTGpt1a34kdXef9pIIHzLJ2PhlUnquDYalTow=; b=M
	sZwvZgoJZfeeOhzRMYtUCEOT4XIzsCihSkh5oMAcx96sRulMmNmZQHH/qjCdcyFt
	J4voUeqKJ3BozcEvdMA+C9SpKqQa1RoxmaKM5E3U5fP5ZITH4AFYIB0CgjTmVh5h
	yTHB5TmGtaJUmKxTMWbPGaSRwEEwQ5AqAl7qb1kHC5i6r12a1oXSdrGsJxXbqwNn
	WuTdMykOTOIfuQTQSqZvWCFhaK8KSFMGvNOY6pq1JKXBPHamR2Fv2Ca2gkqnKHxa
	sUMed0Tb1Y4K4OmeNepJfRPV/k/9CKXmpW3Q7j54qIEg/tRD4/Ow5x1yahZiQP1D
	jMmggzJ/1zntOQlmKDpiQ==
X-ME-Sender: <xms:xU9vaOhZl45z-rfB9RxF_qp7NXcX1YCEJvpn_83dFwQvi7TbEUJfCA>
    <xme:xU9vaPDTDQty_E-xxXjH9NrUy1ZIarZtAVtYYT4xsWqFGExmKh7nj_7IFcfzMmBst
    lc43IENkO3kmt9sdLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfofgrthhhvgifucfotgeurhhiuggvfdcuoehmrghtthesthhr
    rghvvghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhephfdtueffteevgfeihe
    fhvefffffggeeggeeigeehkeelgfeitedtveehtdevffeknecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghdpthhrrghvvghrshgvrdgtohhmrdgruhdprghrmhhlihhnuhigrdhorh
    hgrdhukhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xU9vaIgexHGtXks1vbezMqLHC3sZR36QBPL49RLnqklMoTcbbG4dfQ>
    <xmx:xU9vaLk9OSd4bAwTtlBPKEBMlZFh0aGYx56i5jNF9k76S0IyAKVeSQ>
    <xmx:xU9vaMqLf07Xa9JMvqZNK7gpl2pAQHyMtXaoDVRnfQfmv2aCcaNdhw>
    <xmx:xU9vaME2X7s1_F1j7DNuJXdtR4Ral7iIBIyZMsU4dqvhCS04_D7nGw>
    <xmx:xk9vaJZHjvk8IRH_1R-WQ_vE3UeOpKkdVSP-ihyOjamn_e1cZI11jFL9>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92C9315C008E; Thu, 10 Jul 2025 01:29:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7d5bb7b82feda5d9
Date: Thu, 10 Jul 2025 15:29:01 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev
Message-Id: <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
In-Reply-To: <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
 <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Russell,

On Wed, Apr 23, 2025, at 7:01 PM, Mathew McBride wrote:
> 
[snip]

Just following up on this issue where directly connected SFP+ modules stopped linking up after the introduction of in-band capabilities.

The diff you provided below[1] resolved the issue. 
Were you planning on submitting it as a patch? If not, I'd be happy to send it in.

Best Regards,
Matt

[1] https://lore.kernel.org/all/aAe94Tkf-IYjswfP@shell.armlinux.org.uk/
> Thanks Russell!
> 
> The diff below does fix the problem, 10G SFP's now link up again.
> 
> I should note that Alex Guzman was the one who originally reported the issue to me, he has also confirmed this diff resolves the issue.
> Link: https://forum.traverse.com.au/t/sfp-ports-stop-working-with-linux-6-14-in-arch-linux/1076/4
> 
> > Please try the diff below:
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 1bdd5d8bb5b0..2147e2d3003a 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -3624,6 +3624,15 @@ static int phylink_sfp_config_optical(struct phylink *pl)
> > phylink_dbg(pl, "optical SFP: chosen %s interface\n",
> >     phy_modes(interface));
> >  
> > + /* GBASE-R interfaces with the exception of KR do not have autoneg at
> > + * the PCS. As the PCS is media facing, disable the Autoneg bit in the
> > + * advertisement.
> > + */
> > + if (interface == PHY_INTERFACE_MODE_5GBASER ||
> > +     interface == PHY_INTERFACE_MODE_10GBASER ||
> > +     interface == PHY_INTERFACE_MODE_25GBASER)
> > + __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
> > +
> > if (!phylink_validate_pcs_inband_autoneg(pl, interface,
> > config.advertising)) {
> > phylink_err(pl, "autoneg setting not compatible with PCS");
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 
> 

