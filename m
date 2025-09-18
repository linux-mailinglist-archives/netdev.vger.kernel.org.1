Return-Path: <netdev+bounces-224487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35AB8570A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E400160684
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E8286427;
	Thu, 18 Sep 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Mg6dsQR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51522A1D5;
	Thu, 18 Sep 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207906; cv=none; b=uo1Dk9SrixpRmgm1l7O8m65zFADPEWcAiAHVQtRE7YAgQ3j9dQEfTqDqWTcDyG8P2fRO0UoATAKa0gVaS8QHPnbPn6PtMju1KOAoLDHQEV+yLtnID9TZfexP9vXUb6W5g+h+5+U1400d1K1LEixGRnCATNsUy7PYVDXhYkj1ns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207906; c=relaxed/simple;
	bh=dEh6BfjHPJCDZQNyVxEP0Gyi/kZdfBsir4jzEInAR9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7W9upFSL9elNV7YK3ixFL1niHRd3TpVyhO2AdxFxlPb5lppWlo21HV36FnZc22xluBsLAl0eTrIdl6xbws3wYSsvC66IeIYnX78OSZGO9ONpIBy7mc1DjS0QRgerBhyDgg4+u0LolKJln2uXm2vCF6KD8ppv+7/tYkRtesGngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Mg6dsQR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gT7EyJhqaGT1c/vVbat3yyZR0Yh/jcDyJmsQcPvAhhs=; b=2Mg6dsQRTBgEVP1SD38awP1HMR
	VvKK0efTP0JUtG5xvhbIVACkueM+2moVFWtAlmpRQfbaX166ZQBeUMz63JIUb4QIolAa6aTlcBmdP
	E50ZUVM0uxw1NFBK57Eg0qCdzKXOiyM4dwi4vS3tzX+voRwq5MUK3j+7fA8h8V9Vy8QA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzGBr-008q5n-Ct; Thu, 18 Sep 2025 17:04:55 +0200
Date: Thu, 18 Sep 2025 17:04:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Jander <david@protonic.nl>
Cc: Jonas Rebmann <jre@pengutronix.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
Message-ID: <7f1d9289-4102-4db9-a2bb-ff270e8871b7@lunn.ch>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
 <af554442-aeec-40d2-a35a-c7ee5bfcb99a@lunn.ch>
 <20250918165156.10e55b85@erd003.prtnl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918165156.10e55b85@erd003.prtnl>

> Yes, unfortunately the SJA1105Q does not support PAUSE frames, and the i.MX8MP
> FEC isn't able to sustain 1000Mbps (only about 400ish) due to insufficient
> internal bus bandwidth. It will generate PAUSE frames, but the SJA1105Q
> ignores these, leading to packet loss, which is obviously worse than
> restricting this link to 100Mbps. Ironically both chips are from the same
> manufacturer, yet are incompatible in this regard.

Thanks for the explanation. Maybe add a comment that the bandwidth is
limited due to the lack of flow control resulting in packet loss in
the FEC.

Anything which looks odd deserves a comment, otherwise somebody will
question it....

	Andrew

