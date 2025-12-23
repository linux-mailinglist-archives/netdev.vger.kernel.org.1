Return-Path: <netdev+bounces-245890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0556CDA240
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1DF301B2E2
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19834DB4D;
	Tue, 23 Dec 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="VRK0U6hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail74.out.titan.email (mail74.out.titan.email [3.216.99.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4634DB48
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511631; cv=none; b=Xp09Hv51CNeBlk1/OTXDr+7UA9v5hMh92KeFDx8T+/lMq8A5paA+FTMvMxFcQWFEpMhiii7H0rcfpzFKuRCqezRUHo0YLSVVVza3G730Pz8EM6yQbnCWAKMuhnB4sbBFf1SpPpSpyJihK2dIr2Ggr3ptm/9CCrRiIN/nHPJgwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511631; c=relaxed/simple;
	bh=xjm7EuZUyAPqwTngzV/ux1OUHOg23co3qmXDoLIrBTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfWi14iPnClOP4KjqqoBAGzMNjRAAIU5PHmBG2c+J6ojCCioEG5ntjkdgl3gd5UtpymBqj70TC31WcHVrAcrMYgoKdoJH2QhWxp5ZXVVTtHzsm3BWPXz97jv7vC4VNtBzxB9bplNnN+pMzLfq5vb/nvKgRm/RtPSM1fRuQrInGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=VRK0U6hN; arc=none smtp.client-ip=3.216.99.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dbMjL1XqMz2xC7;
	Tue, 23 Dec 2025 17:40:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=uf76l8zJvuG4vvM9+mMQnvTcSJw69Y2+zoVdn3mljzI=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=from:to:subject:in-reply-to:date:cc:message-id:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1766511622; v=1;
	b=VRK0U6hN/IMzkjprynxNZT7h1zihxKzpssn8B13XZ0Rh8I7NQBs4AdIxfs4yxxpjLdl98Oso
	x9+9d1C9sIGtyjti1zEdgKppGeHB7ax4J5JY+fBAzzPKK8ky8uT98DwncFkxd3w5rRhCnBnEU0o
	b1zdd0b/yrYbvjTpPE9lJLBE=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dbMjC4gyyz2xH9;
	Tue, 23 Dec 2025 17:40:15 +0000 (UTC)
Date: Tue, 23 Dec 2025 17:40:10 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [RFC PATCH net-next v4 1/3] net: phy: motorcomm: Support YT8531S
 PHY in YT6801 Ethernet controller
Message-ID: <aUrT-qZTPd5H8L1G@pie>
References: <20251216180331.61586-1-me@ziyao.cc>
 <20251216180331.61586-2-me@ziyao.cc>
 <5365dc9f-310a-4532-9987-ae0e1849f46b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5365dc9f-310a-4532-9987-ae0e1849f46b@lunn.ch>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766511622055939926.27573.5277451296718629596@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=694ad406
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=NfpvoiIcAAAA:8 a=fr2vSiNBX_bauJSxUDwA:9 a=CjuIK1q_8ugA:10
	a=HwjPHhrhEcEjrsLHunKI:22 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Sun, Dec 21, 2025 at 09:29:01PM +0100, Andrew Lunn wrote:
> On Tue, Dec 16, 2025 at 06:03:29PM +0000, Yao Zi wrote:
> > YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> > by a previous series[1] and reading PHY ID. Add support for
> > PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
> > reuse the PHY code for its internal PHY.
> > 
> > Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
> > Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
> > Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> >  drivers/net/phy/motorcomm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> > index 89b5b19a9bd2..b751fbc6711a 100644
> > --- a/drivers/net/phy/motorcomm.c
> > +++ b/drivers/net/phy/motorcomm.c
> > @@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
> >  		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
> >  		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
> >  		break;
> > +	case PHY_INTERFACE_MODE_GMII:
> > +		if (phydev->drv->phy_id != PHY_ID_YT8531S)
> > +			return -EOPNOTSUPP;
> > +		break;
> 
> You have a break here. So the write to RGMII delay register will be
> performed, even thought this is an GMII PHY. Does the register exists?

With testing it seems the register simply makes no effect on the YT8531S
PHY integrated in YT6801.

> Would it be better to just return 0;

However, returning early here could avoid possible confusion. Will
change it in v5.

>       Andrew

Regards,
Yao Zi

