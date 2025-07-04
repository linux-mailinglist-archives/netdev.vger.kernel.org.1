Return-Path: <netdev+bounces-204228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CCAF9A4B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BB6E32E1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEE1F1501;
	Fri,  4 Jul 2025 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uVP0P6ls"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB531386B4;
	Fri,  4 Jul 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652268; cv=none; b=ET1LnmDQqcIq/fWsHenHEMHIOGhvMkTd3QJMjeAg26X/XFcG91OwWGDpG6kM/JhPC4wAJRBLrHYMt9yncRcWY7U5DDh1qG91wv1kRaorZ0ySCSF4uAOUDQG2RzGj70lswCIYL5Mmyd2o94ecUTV+RUkJphXNMBD3X1r4MUitmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652268; c=relaxed/simple;
	bh=Hbnc+qLr0FRSfK3FgJpdrnEbICvswvH2mJWgkf1Z3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc9KG3qj4WaTpip6TuXll/pLDrs8Ud33yEm403C1gzXK707TOK8s2vC8FKRmcKbt4PRv0SpatWzBD6i/v/y/HtORShYY3J2NDXwnwauu2uK+eak5TrdBJuDNRMlaLbjZcAu7GyAmle+zZXPDQCAvTB88ziiVlKuC8cwdNFe8twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uVP0P6ls; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=whpTm1Bcn8HqWYeBHauMvcgOCQGmAFCeXt6Il9zBGdk=; b=uVP0P6lsIGV1V2OQxS2KF8DJ1+
	QWdj2KDfqkGk1ryQmiH31OS8NPlvrZfVP+QLXyO0hcWPDNSMLZqXfzszpB8VxXW57MlXBLhoAtuHa
	smyS7IiOIE/2H5ZWOdJ2gKQkMHns0fFvZ1mBFsW4GqpxZGF3cPBvLLoD7ulXm1TpUl0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXklH-000HI7-Uy; Fri, 04 Jul 2025 20:03:47 +0200
Date: Fri, 4 Jul 2025 20:03:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <3d0a5666-c57a-4026-b6a1-284821f25943@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703014859.210110-3-dong100@mucse.com>

> +#define M_NET_FEATURE_SG ((u32)(1 << 0))
> +#define M_NET_FEATURE_TX_CHECKSUM ((u32)(1 << 1))
> +#define M_NET_FEATURE_RX_CHECKSUM ((u32)(1 << 2))

Please use the BIT() macro.

> +	u32 feature_flags;
> +	u16 usecstocount;
> +};
> +

> +#define rnpgbe_rd_reg(reg) readl((void *)(reg))
> +#define rnpgbe_wr_reg(reg, val) writel((val), (void *)(reg))

These casts look wrong. You should be getting your basic iomem pointer
from a function which returns an void __iomem* pointer, so the cast
should not be needed.

> -static int rnpgbe_add_adpater(struct pci_dev *pdev)
> +static int rnpgbe_add_adpater(struct pci_dev *pdev,
> +			      const struct rnpgbe_info *ii)
>  {
> +	int err = 0;
>  	struct mucse *mucse = NULL;
>  	struct net_device *netdev;
> +	struct mucse_hw *hw = NULL;
> +	u8 __iomem *hw_addr = NULL;
> +	u32 dma_version = 0;
>  	static int bd_number;
> +	u32 queues = ii->total_queue_pair_cnts;

You need to work on your reverse Christmas tree. Local variables
should be ordered longest to shortest.

       Andrew

