Return-Path: <netdev+bounces-117030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC5494C68E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43872B21272
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34F15B561;
	Thu,  8 Aug 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yKpx0UmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0115820F;
	Thu,  8 Aug 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154256; cv=none; b=p3DjVe3K3m3oSngdpNJKZ/JfTqwTGtXIDaVLyX9di5M9RoN39L8zcsUmqhe+uE2gJs4UaRoIXyutotMr3OkpK0X8tJYw1nQxXyUu238gaC/P4g1vQ04+mYM4vmHipujQAwZKYI6QHGMbrBMrKxhbjt0zlT6i/AyWq9z2Ejfc2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154256; c=relaxed/simple;
	bh=fTYNQC4CAH7sOYb/bMWwW5CHXUN+mk34w8L/xq/xi2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1fFYEid0Ovc639VLiW2rPUgYs4lzC48lv5DAskBGjlvgSQiGKJsd3v651k+73tNCI8rvM33y6+GeameIXqVhnDB9+Xs1ktZZrOUv45gFY45DGmi3srI52RYDdoocY4mgduWXT+DO6AZ4P0GmgeKhwO9yHrCCIcUCaLm9hQ2oK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yKpx0UmO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E6AAA212EB;
	Thu,  8 Aug 2024 23:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723154244;
	bh=OEsvf7g7/w9CifdM3bR3zFhc4Ws0Z/D5lK7FraIhQzQ=;
	h=Received:From:To:Subject;
	b=yKpx0UmOrL8hPRh8T+o0nK1OvzWcEk3154xj3jXg2xTU2No9zUK1DdfGps75RyKdX
	 OiC1klIIaYWHkNuUvAhXkfiYUa7o9aA3TAmpy9fmH4VAxmfSywCdy4T9CPjbppYBd4
	 8JthzIAH8Gzkw04cSWnKg6JdTHtI5pO88zcKoDT7JabqGz7AdsNLG7skoHK7dbnG2U
	 A9i7kUSVZ1hmi56dDBfauPieTuARPiKYmAaj50VCLBL9/RYDtjJRsffBOXwyC21hO4
	 N3JI/+Rh85GafItqSluoF/8mBUllkXr33cYy7jUye+VyvujfZJuow2qBGyHVh6D00k
	 AqyoiKnvPIDsQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 7A9107F8F1; Thu,  8 Aug 2024 23:57:23 +0200 (CEST)
Date: Thu, 8 Aug 2024 23:57:23 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/4]  net: fec: add PPS channel configuration
Message-ID: <ZrU_QwbcgaUxBg61@gaggiata.pivistrello.it>
References: <20240807144349.297342-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807144349.297342-1-francesco@dolcini.it>

Hello net people,

On Wed, Aug 07, 2024 at 04:43:45PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Make the FEC Ethernet PPS channel configurable from device tree.

I realized that I forgot the `net-next` subject patch prefix on this series,
let me know if I should re-send it with it added, thanks.

Francesco


