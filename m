Return-Path: <netdev+bounces-230567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3ABEB276
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67EB743A65
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D931B83D;
	Fri, 17 Oct 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oYMRBeiC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C43258EE9;
	Fri, 17 Oct 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724469; cv=none; b=F0/cgpnYV0R2aG0McSl5oWn4aVbCe84Wq74qjmCMJvhDlMloEG/4zeFORbg4k4M7gBAa8VlWfKQKmQSb2N5G66m/Aj0l//nGOjkccSTKPXAXBHHRZgtuTagJvGRfm1eUTVWIy+M9Iih2y4O1UN4fweb6O2p7i97VpgdFxR+84mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724469; c=relaxed/simple;
	bh=TrxhJ2s8+lWOXkD73rTDS56t6q8wzrTNtRQwWc/V22k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcHO5q/3u3by7wxygWH4ZJ+Is/bkAxTPBcHM8qHKlxASnsv8bXr1shqb3P0mORL5fGoPasq6vEpRe4lSIGZwyhtphXcJfroSAYRbeBH2P5jEbA2nujloyfZzT+O4wcjZxK6acHZxobwcVJznnVqolVV/uFVV6iKhIVbLWgx67jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oYMRBeiC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AaMtS7GRiEXhjfKkdmzpemms487w0LhH7+eaaphPK60=; b=oY
	MRBeiCDVqUhOErW7W9Bxnv1MQUlzkFdgZ/V8UeGSS/NPpOGEEQxtEByH/LLPgQANLKt1QrW7PXsIk
	sYAA3A23iMUtEp76Inj4SY1N6v36Gb/k0N3AS9R7zR+tN+UnEV4Io7OCvOZCX7SAjODLJr7M0xIx1
	UcVCQS1LmRJEk5I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9orX-00BJY5-8x; Fri, 17 Oct 2025 20:07:35 +0200
Date: Fri, 17 Oct 2025 20:07:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 09/15] net: macb: introduce DMA descriptor
 helpers (is 64bit? is PTP?)
Message-ID: <5b2d2fe4-4f15-449a-a1a5-a90777f8f9bb@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-9-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-9-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:10PM +0200, Théo Lebrun wrote:
> Introduce macb_dma64() and macb_dma_ptp() helper functions.
> Many codepaths are made simpler by dropping conditional compilation.
> 
> This implies two additional changes:
>  - Always compile related structure definitions inside <macb.h>.
>  - MACB_EXT_DESC can be dropped as it is useless now.
> 
> The common case:
> 
> 	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> 		struct macb_dma_desc_64 *desc_64;
> 		if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
> 			desc_64 = macb_64b_desc(bp, desc);
> 			// ...
> 		}
> 	#endif
> 
> Is replaced by:
> 
> 	if (macb_dma64(bp)) {
> 		struct macb_dma_desc_64 *desc_64 = macb_64b_desc(bp, desc);
> 		// ...
> 	}
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

