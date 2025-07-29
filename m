Return-Path: <netdev+bounces-210843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67152B1511C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFEF17F1CA
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B371E835D;
	Tue, 29 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dw7oxMUb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8231D5154
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805876; cv=none; b=RfagDIZ+Nc2/yyEOA8LGnE10vh5ORfOw1Z/eYAv56HQfwOLsJrT0XJBU4BeNJVkb7YNP0GjQAi9RVBzKnr+NCWlgYJdvka7I5APvCav1UmpPucjVn07dE+w2HTtzeYpX5lJEENZ1RUQkUcDVEVqpa92CeYIwuhI2NYeq669cZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805876; c=relaxed/simple;
	bh=suXxZPilRlmQ0/nb7hEfLfu4Aamc/datWovD0S2Ixl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+uKVCFZ3edtomXzhl0SO4Z6zsdt0nZkOXBwzQxB0TAi+mtmXFlkddLAZFVgGZa7Edckt0OBi7rIsRZSq9JWK7+C/I6GrPmGcO5y2fAJLcBfAz9N4i16Vd3H8hnlXZ26+BXJZInLaaNRaUQoaxCLGvHB5uXTLmPL52OJS8vBvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dw7oxMUb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qgrdYlAwq9qL1RZu7ItpFhufs6pqCuDanSXXOYAYdSo=; b=dw7oxMUbZlO9lcPni/j7pzg5wC
	wUni7kuJEwYeZOUEFeelyVOtzIW3E48cry+bMdNaORw9Od4vnqcKE35HIzabjX32yG3Vwp/NiAxHq
	47m8JjINfqu7Z4uFPllQ/IlvdEeg3NHzEJOWcAkP9fde4IUIQaD+uRFYC+hTInYpJEjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugn1F-003D8K-SQ; Tue, 29 Jul 2025 18:17:37 +0200
Date: Tue, 29 Jul 2025 18:17:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>

On Tue, Jul 29, 2025 at 05:01:06PM +0100, Vadim Fedorenko wrote:
> On 29/07/2025 14:48, Andrew Lunn wrote:
> > > +        name: fec-hist-bin-low
> > > +        type: s32
> > 
> > Signed 32 bit
> > 
> > > +struct ethtool_fec_hist_range {
> > > +	s16 low;
> > 
> > Signed 16 bit.
> > 
> > > +		if (nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
> > > +				ranges[i].low) ||
> > 
> > Unsigned 32 bit.
> > 
> > Could we have some consistency with the types.
> 
> Yeah, it looks a bit messy. AFAIK, any type of integer less than 32 bits
> will be extended to 32 bits anyway,

sign extended, not just extended. That makes things more fun.

> so I believe it's ok to keep smaller
> memory footprint

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c
 .../ethernet/fungible/funeth/funeth_ethtool.c
 .../ethernet/hisilicon/hns3/hns3_ethtool.c   
 drivers/net/ethernet/intel/ice/ice_ethtool.c 
 .../marvell/octeontx2/nic/otx2_ethtool.c     
 .../ethernet/mellanox/mlx5/core/en_ethtool.c 
 drivers/net/ethernet/sfc/ethtool.c           
 drivers/net/ethernet/sfc/siena/ethtool.c

These are all huge drivers, with extensive memory footprint.  How many
bins are we talking about? 5? One per PCS? I suspect the size
difference it deep in the noise.

> for the histogram definition in the driver but still use
> s32 as netlink attr type. I'll change the code to use nla_put_s32()
> to keep sign info.

So bins can have negative low/high values?

	Andrew

