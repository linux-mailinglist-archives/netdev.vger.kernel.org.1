Return-Path: <netdev+bounces-244660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB5CBC349
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 02:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149E230084C7
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675C3126A8;
	Mon, 15 Dec 2025 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cf3ENENk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD720C461;
	Mon, 15 Dec 2025 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765763196; cv=none; b=o5O2yux+0Z0Vfgok6caT3pAnpq3Q+n+W402iVvvL0Ao4kRdpvSlDVRlKpVEzq6TxDEyzHU4XQmR0KMLd3vBva42vW54KZNDOoyXzjwNzHg9wr3/3oSK1rFOqY7TWX6sAIXBRmULfhQ8uCFCrb/YQHolptjCNpjBBRYnQvtZJYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765763196; c=relaxed/simple;
	bh=XRC3yl673LmIMW7GZmh0iB+sUGK/S/yb57gGlGX0EBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpQFstJ0JbARUqoaRH57b5qGN/hOTgAb0V6WtallraGMz1yoGiC8n/qRSLWtwI8zNxEFQB7BtJNguHBQDqoSCbF1G6IybapeomxBfl7nl44240ej9CdySeKxiqIUjWOxfqKXlcIiqUGOUnOqLR5U09Ub45tCzBuqPKL7qYVTTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cf3ENENk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LTBoGWcRgSF0H/r01p4IjSgGUzmL4jidq3/URe7sdCY=; b=Cf3ENENk4so979idjMr+2ewvDF
	YPxpATX3V2kqIuKO0z4SIuH1lfLosvtXq3v+8XBQOs6+dr81YLVg1t5O771bEHSJb4El/01DpIkw2
	X/T+m5dziJTgVLn6P2S1IstcJ48+3xqDiO9y89LLwG9Ss6+ziMOHh96wC7s8N5QpcruU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUxfG-00Gx9d-8r; Mon, 15 Dec 2025 02:46:18 +0100
Date: Mon, 15 Dec 2025 02:46:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 2/4] net: dsa: add tag formats for
 MxL862xx switches
Message-ID: <32d0845c-4d89-4904-986d-b7438104cf5c@lunn.ch>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index f86b30742122f..c897d62326f5b 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -145,6 +145,13 @@ config NET_DSA_TAG_QCA
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  the Qualcomm Atheros QCA8K switches.
>  
> +config NET_DSA_TAG_MXL862
> +	tristate "Tag driver for MxL862xx switches"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte
> +	  tagging protocol.
> +

This file is mostly sorted. So this entry should be between
NET_DSA_TAG_MTK and NET_DSA_TAG_MXL_GSW1XX. It would also be good to
try to make it more uniform with the NET_DSA_TAG_MXL_GSW1XX. Maybe
NET_DSA_TAG_MXL_862xx?

	Andrew

