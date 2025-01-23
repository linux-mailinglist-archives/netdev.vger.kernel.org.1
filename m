Return-Path: <netdev+bounces-160667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA332A1AC15
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E8B3A3E97
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814201C5F3C;
	Thu, 23 Jan 2025 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sxrVu2A3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85661C3F34;
	Thu, 23 Jan 2025 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668958; cv=none; b=PcN0PN4+ByTSPnMTDTlSwcUeoK5mMqFuy5qejpPHGRisC8ca4j54TpQ1Y/ZLGZVayYV0PDHIxXcKv3XyGJUX5IiOS8fBmXCj1nzLucpPHchMHVW4rNJa+adghOEontFhVFh1WWBapYuohzwGT5iE2AZxMNBXoBjNm29ikIWnWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668958; c=relaxed/simple;
	bh=+Wrzir/tqbzObALadgdEnWRB8J1JjN6kJHsVc8Lw1+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l26FOT8SYgRdAl3LeM/HUU1xrieCxCp+npl6iMISkoYbtkjq5f1x++7k2Ai9vxT1ykGojP1ArLj7LlVGsHalvCueVsrbrMsP0778YWguNyEHa9XniqlNRowi0o/ikw8FoJssfeqd0ONxgEl236SBZeDpG9jlwvGuETD1NvltS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sxrVu2A3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4wRX6nt5upARGmRL+6GBeqGf+Xia6h78Ps4/imq7qz8=; b=sxrVu2A3hyTix1INO9hsYSTRlw
	3hsdB0UGVaKHFe93i6+mJgUzYMrDBIOg332lYW/kr30ecXdNoGnmmoX3TNPN5fdI7r0xhC002+N38
	4CJs4giDq2cneX+Hg8Ks49wT14J3KHNDViOGzQgOKhTxJ49wBh3J8gPKDOvEcuQMGMLI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tb546-007Njj-4d; Thu, 23 Jan 2025 22:48:42 +0100
Date: Thu, 23 Jan 2025 22:48:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Brad Griffis <bgriffis@nvidia.com>
Cc: Furong Xu <0x1207@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>

> Just to clarify, the patch that you had us try was not intended as an actual
> fix, correct? It was only for diagnostic purposes, i.e. to see if there is
> some kind of cache coherence issue, which seems to be the case?  So perhaps
> the only fix needed is to add dma-coherent to our device tree?

That sounds quite error prone. How many other DT blobs are missing the
property? If the memory should be coherent, i would expect the driver
to allocate coherent memory. Or the driver needs to handle
non-coherent memory and add the necessary flush/invalidates etc.

	Andrew

