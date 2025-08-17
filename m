Return-Path: <netdev+bounces-214394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17070B293E8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3034E32ED
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9062EACED;
	Sun, 17 Aug 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JSfGOoSR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6E2E5D30;
	Sun, 17 Aug 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755445427; cv=none; b=g74vThKJZCNnGvbSI39lL8WL7NjzISsefIgSsql8qDeiEcPWgNqVzzP57YBJnkiz1xymb26yuCatU1oJiC/1Z4MxDxJoN3vukad79I3CyA8DlOwOWNFLIjw9u4CZSXHXZsogBsyOzn/vKAuajuYadE8NsT3EVTuNM9Vj9hbTydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755445427; c=relaxed/simple;
	bh=8Nm+4/xDYbPwKXJ+Q/BkwH554auvDIwd36Ys38lMFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW0+bQM/5eBuNBFaFdxk1/R32LJKu725Srp2kjWkMIA9fRrTO+ReT/YD0FZcKmDlF+lnCEeady0dt/zqvKYJiRZQsoL+N5Yu3cI2ckQDh1Fpd4H4pg2l1uIsPNMfr7LkwS9ITOrxtZsIFxl47fTeRrZw/KD0+fG3M1Og3HSJzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JSfGOoSR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xiYU6zDnLSC5t35wkz5NmkHEQkEt2jtczkb6tSK1COo=; b=JSfGOoSRcSoG8r1NKyPCGBZ8j1
	WwrHCGh+xWo6bhO0u60E1dwi5pQvKt3mMyrDmrAzY9ArsiIlEBb3M1z06Yog8XPKlDuy+7Mdt83SN
	OIgSDXGDJM2vSwX6Cgjq2FG1SVWbLreEWQEc9PzyfBhzuQa6T0qGHg4nJuATlRTv7jE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfXb-004yT8-D7; Sun, 17 Aug 2025 17:43:27 +0200
Date: Sun, 17 Aug 2025 17:43:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 00/23] net: dsa: lantiq_gswip: Add support
 for MaxLinear GSW1xx switch family
Message-ID: <af253f4d-b63c-4a05-bd87-f5bd47f3f8e2@lunn.ch>
References: <aKDhFCNwjDDwRKsI@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhFCNwjDDwRKsI@pidgin.makrotopia.org>

> This is submitted as RFC to gather feedback on the approach, particularly
> regarding the prefered order of things, ie. should I first introduce all
> features (some are already supported on GRX3xx), then split into MDIO and
> common parts, then add new hardware like I did now, or rather first split
> into MDIO and common parts, then add new hardware support and then new
> features would follow (maybe even in follow series)?

I think the first 8 patches can be merged as a series. You can see
these are preparation for new features, but don't actually add any new
features, so make a reasonable set. 23 patches is too many for one
set.

I have not looked at the remaining patches.

	Andrew

