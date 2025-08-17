Return-Path: <netdev+bounces-214387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4960B293BB
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CF206C3B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2FC1DFD96;
	Sun, 17 Aug 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VAZe1EbT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7454764;
	Sun, 17 Aug 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443257; cv=none; b=E5xsvGSI74UEcuaCr/nT2NoLOqRfhkIEooShBBpppQrpriPB0wgO41HmG4fMB4lsER9xeASmgtJ2dp+/1zsJpgUxli96Ai+3Cfn+jQQnCVE0FEMy8wrVqL2sySkRJK+nZ4ykurtbbzvOSVtAxqdqfVKP3eZcIu012DzmAd7hD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443257; c=relaxed/simple;
	bh=/RqkqFhDrq26l8hA4tfNGpYfvEi+DPbtJXFlgVFW9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mek3A/vnRimgOG3p8kw6z/ROuprs2tqpNxjpdKh2cT1VJWUUff8ZYIj1Y+PMv/9sYnb6TIdyGreeuyPAjn1zu6aMc7eNZL0+NWkZnC1oEBdxdY/DPdjtWCHoOhak8/qawz0l0TYP1oeCQztVG6uC2jRCNOcdssnBLl9u2NxKvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VAZe1EbT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K0OiBdNurffqoHgxQZm3OzPzwdNzdsApmPRVXRmmFDc=; b=VAZe1EbT+E5EccPhfUmhaPfDrO
	dHl9jUi8DyivfenNU5/avHaCdEqCTrSwD/2LsogvoBB1Kv48G9pkPrMa/qHvohouqFycyieYQBVir
	NsG9G6nldvQpTM1d0jB/+MU8I5UaaV4b5/o6yJJRO52hhbT1DGnOhUBt6ZzXmEaMlBYs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uneyb-004yH7-TC; Sun, 17 Aug 2025 17:07:17 +0200
Date: Sun, 17 Aug 2025 17:07:17 +0200
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
Subject: Re: [PATCH RFC net-next 03/23] net: dsa: lantiq_gswip: prepare for
 more CPU port options
Message-ID: <6420c9a1-45b9-41b3-bfcd-f86d8bb80734@lunn.ch>
References: <aKDhQSBX4Pl6n14b@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhQSBX4Pl6n14b@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:51:29PM +0100, Daniel Golle wrote:
> The MaxLinear GSW1xx series of switches support using either the
> (R)(G)MII interface on port 5 or the SGMII interface on port 4 to be
> used as CPU port. Prepare for supporting them by defining a mask of
> allowed CPU ports instead of a single port.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

