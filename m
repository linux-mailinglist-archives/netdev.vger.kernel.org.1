Return-Path: <netdev+bounces-214393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A532BB293E5
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B71E7B249F
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17822A4E1;
	Sun, 17 Aug 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MXMb2L+1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E231E1A05;
	Sun, 17 Aug 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444994; cv=none; b=Xtt2xg1Hov+HjJXb0sh/HCIQg3A8K7diXfKTBtdWWIkOx5y6vIQRIRx1GWE1b2+BeLHHLsX7XVt1Tl9Gvc133NCAIWZBVyv/YrO5BYNXlvGsez6++q8apulFlG/1UPm6GZMUNtVeuP1j5A8z5AB9mCoJRp+dymuscqV2A5SoMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444994; c=relaxed/simple;
	bh=EJFLB8vlxaD2J0q/5EuxQV/CklJYT944X91IRyIAV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlY8rkMCROkbt+jxtaWTpQU9CeS9eWVDfOldnKZcQSk+Mr4r+dCBr5deTlmLsB56lCMhG+w+9eBoRcpPzpv56crC6y3lPSscv6Hc0tFJxhDSz45UGVlgvSm6zZf4GQMdl5kAwP6pX/Y6uHk+9OBnwluWfzDSZIRgFIrz07B2rfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MXMb2L+1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a3dU9bOsBGQWEGsligX1eCujGn6cFI0IDVQajv49Yzg=; b=MXMb2L+1jOEzEvTBuomQ1QVrKk
	1ncJsTUL0HJ7f7BhG7rT9ESGdBicu7Ydeyp6BVYwFd497HQkrvT5EXM7Eumty8kTvImWm6pMJ4b8Z
	F4ue5yk4DBAax2J7JT5Cp+RE6FgzTD3fxl48EPKUrt9uLRAjXEZnvWMaKDefQU1Fw6t0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfQb-004yQP-Qg; Sun, 17 Aug 2025 17:36:13 +0200
Date: Sun, 17 Aug 2025 17:36:13 +0200
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
Subject: Re: [PATCH RFC net-next 09/23] net: dsa: lantiq_gswip: add support
 for SWAPI version 2.3
Message-ID: <712e82b5-62fc-423a-a356-8cc74fc22e3d@lunn.ch>
References: <aKDhigwyg2v5mtIG@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhigwyg2v5mtIG@pidgin.makrotopia.org>

On Sat, Aug 16, 2025 at 08:52:42PM +0100, Daniel Golle wrote:
> Add definition for switch API version 2.3 and a macro to make comparing
> the version more conveniant.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq_gswip.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
> index 433b65b047dd..fd0c01edb914 100644
> --- a/drivers/net/dsa/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq_gswip.h
> @@ -7,6 +7,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/swab.h>
>  #include <net/dsa.h>
>  
>  /* GSWIP MDIO Registers */
> @@ -93,6 +94,8 @@
>  #define   GSWIP_VERSION_2_1		0x021
>  #define   GSWIP_VERSION_2_2		0x122
>  #define   GSWIP_VERSION_2_2_ETC		0x022
> +#define   GSWIP_VERSION_2_3		0x023
> +#define GSWIP_VERSION_GE(priv, ver)	(swab16(priv->version) >= swab16(ver))

Don't this depend on the endiannes of the CPU?

It seems like it would be better to make your new version member cpu
endian, and when writing to it, do le16_to_cpu().

Also, if i remember correctly, you made version a u32. Should it
really be a u16?

	Andrew

