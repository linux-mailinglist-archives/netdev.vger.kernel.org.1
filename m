Return-Path: <netdev+bounces-224448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC4B85372
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90CD7C7E6B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8930F944;
	Thu, 18 Sep 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eOc8+LYe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412030F7E4;
	Thu, 18 Sep 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205095; cv=none; b=MK8AmtroeP39WWmcGdY1H2Tlt7PpENWFx51Ve3ATxwApIgfBxsLfZlr8BiZBPEYKAQYeBwHUlW1dHkfksowJZNzodNfvzqbqWt9ZuaDUS3Zt4LKs2OgtY6V4bDJ0bMHkOR7X31fGc+O+2ViNzhJ/FXh6bm9+mJxBlJeJ2Xiy9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205095; c=relaxed/simple;
	bh=26U6CzCELKRAi4X7TIQjNGqBzh5+urYGa3ZBhmDxRzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHu/rQcV8sD2WJ/vrAxnzd5gZztcWbUhZOMBXsIa1ewQXPiNcjJQGb12IdqftAlxGw3l4AM5DSmnG1vdx2SOY5zaeizXBJVa77bBfW/40XFCa7ex9JXXf3i3LDA1aMRGWTYjdzEK3DA7c+GdxcPcjDSbBTebxbOoB6WP9kTAGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eOc8+LYe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iex3K3wmKhamz+vqqFHrkjRQrwHLXzKu/EFAlHaGQ9k=; b=eOc8+LYe25TkopazB3zILcKsJW
	uPQCUan41UW29wctSekpNjGXYZRyh0MdKje3dj/Q9rFqVnE/ePWqDfKmQmOjwPnMoiSQT9ownQ9Vz
	L2r76OKZvqQVY0gcpk+zLncycsny4MO0nC8xo+FhV4FVFsG5ExEtpEbt45pYqq0q6t+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzFSY-008phN-AK; Thu, 18 Sep 2025 16:18:06 +0200
Date: Thu, 18 Sep 2025 16:18:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
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
	David Jander <david@protonic.nl>,
	Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
Message-ID: <0f520191-7d9f-4800-a41e-a623b9335c9d@lunn.ch>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>

>  - Onboard T1 ethernet (10BASE-T1L+PoDL, 100BASE-T1+PoDL, 1000BASE-T1)

Are these PHYs connected to the switch? It just seems odd you have a
switch with only one port connected to the outside world.

	Andrew 

