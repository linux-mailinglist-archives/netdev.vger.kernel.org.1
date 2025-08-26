Return-Path: <netdev+bounces-216760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41390B35109
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C05918955B7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FD1DD9AC;
	Tue, 26 Aug 2025 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1DyysYwx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E01C84D0;
	Tue, 26 Aug 2025 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172190; cv=none; b=rJ6RuGsXseC/Lg8UxW8kBq3BI3MPHfN+70ZOlkbsriL+3F0+CeMoyWlcYVD1wTlpvOBURoe36pTfALExzvbY2KrQG+c5zpNEJWBAp4PnMePRL9evA8IizdNSJMj3G7TrJ6ITSA9Mbp1WM7I+MfGLxomBA7C9o3Op9oSYqho6eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172190; c=relaxed/simple;
	bh=gUXvPxrNKSXaMSyGV0y4SSA01uJp0o88ba6YqqvouFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiUjf7HRQq5j+S8fUsM+hq3ZaQSvh7r703DdNNTstD2rRRAHz/C2mJlk3OXzGj0tPeLm3f/tCZ3L8kCnEmBwX9HcqGy8fNtRxP25YkyBkciKKp9tG4xVnUSYxYIjLxlJP4gw3mWCQoxw1muuZ/b99sX/X7lCabldbwgrj3ckEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1DyysYwx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hl9O6wsWtW0Fx/jv9bnoxKhDVg4C1Yd7b6RVijVPgRY=; b=1DyysYwxkK9hvOD7vv4AF76aCf
	IRSyA8tZ/efbMrCP9ZDHC5xwj2kmFbJ9zX2JAeu8xKZBDhFTqNBYo79rcwjPu6GgXjo/iSvOo7Avw
	5inzuHVdXmOtqfQauHWKvjx3eEpkasb+TdmiABZbo6hWdvRJFrA9mguSIvyVuIynfSas=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqibY-0061Ka-RA; Tue, 26 Aug 2025 03:36:08 +0200
Date: Tue, 26 Aug 2025 03:36:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next 1/6] MAINTAINERS: lantiq_gswip: broaden file
 pattern
Message-ID: <54c76590-f137-4980-9846-932a47606932@lunn.ch>
References: <cover.1756163848.git.daniel@makrotopia.org>
 <8c42d29b711287d7aa54be93809fd8cea69b7c06.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c42d29b711287d7aa54be93809fd8cea69b7c06.1756163848.git.daniel@makrotopia.org>

On Tue, Aug 26, 2025 at 01:12:08AM +0100, Daniel Golle wrote:
> Match all drivers/net/dsa/lantiq_gswip* instead of only lantiq_gswip.c.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bce96dd254b8..aae3a261d7f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13801,7 +13801,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> -F:	drivers/net/dsa/lantiq_gswip.c
> +F:	drivers/net/dsa/lantiq_gswip*
>  F:	drivers/net/dsa/lantiq_pce.h

I know there is another firmware blob coming soon. Does it make sense
to use just drivers/net/dsa/lantiq*

Or maybe even move the code into a subdirectory?

	Andrew

