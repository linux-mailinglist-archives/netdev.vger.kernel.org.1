Return-Path: <netdev+bounces-230564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB633BEB249
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956157433BA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E7305E20;
	Fri, 17 Oct 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t5nD1e1d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5329B77E;
	Fri, 17 Oct 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724198; cv=none; b=VqQT+47Ul5ECSsWIRiKxbQST0FEljXGcLhqneVsa2UEOD7mOkX5uqa68P45SyLs2Y6h01jijZrWdMjTLJQFcxmYBXjbt950/V3CRvMErHamQbSuu/RuQ0HgxqxXcqK9IBjmzRSe0tfBvV5BpMOv6/yds+QiZ5hwh9sK7dRdkUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724198; c=relaxed/simple;
	bh=Qk0LBZOt8pQIuFxbzo90xAzKgi55jXIwz51NTp5jWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVV5i/Y0l+/Bpc+mqr+j1vtm/RgEBxLKOrveQn/nj0iC5E2PdAmvv7wFLrx3d9SeyvcUUpKEVnGbH+G2m6RdJgjNogSwdEb+7e4r+kPYzDT1Mdy6Pd/Yul5xx+LKE4CYElAQYGSRWdnC7EvCD6qK0cqWJBWXAvmd0IGifDGoAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t5nD1e1d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6vqYBVQLbTmlLBtdpiLTED/ZIuLahPgg/JXTEnb6jBo=; b=t5
	nD1e1dGRr+/iOI+Of2lmtenph14Kp4Jp6sg8eFxKTshWRmfg/uVtoTy+UnpgbmgC1bQXjPFg7BSoU
	oxb+wv3aFU6kB4JsdgyZYWBKKbamMqPb1yZ7gyGCTJycfcmX+pGX6b0mo+Z5d/AZLqact3k/SDHy9
	IKMUW+fPFZp45/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9onD-00BJVf-LX; Fri, 17 Oct 2025 20:03:07 +0200
Date: Fri, 17 Oct 2025 20:03:07 +0200
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
Subject: Re: [PATCH net-next 08/15] net: macb: move bp->hw_dma_cap flags to
 bp->caps
Message-ID: <2409b245-bc66-48fc-9206-a071fe3466ab@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-8-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-8-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:09PM +0200, Théo Lebrun wrote:
> Drop bp->hw_dma_cap field and put its two flags into bp->caps.
> 
> On my specific config (eyeq5_defconfig), bloat-o-meter indicates:
>  - macb_main.o: Before=56251, After=56359, chg +0.19%
>  - macb_ptp.o:  Before= 3976, After= 3952, chg -0.60%
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

