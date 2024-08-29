Return-Path: <netdev+bounces-123257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A2964512
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73F928A00F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95351AD3E6;
	Thu, 29 Aug 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="20KMQELy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0369191F8B;
	Thu, 29 Aug 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935171; cv=none; b=kL1O/QfBv6C0hrTTHDcn3OmfupXDKvZLAB+waGC7TY9puPy8abionymjN9v8bTopsDHX1ZvGJtuCNYNj5HZabYWZxjvbS5+p1tu0lqJuSEopRCi2ByiB2t1kjcGVN/Ri0Oifmu/Z7Utp8jkrUQE6gffTwQXuPgPLsLoesRgymgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935171; c=relaxed/simple;
	bh=t45kKgaqNgp+zoCbiE0yFAUGsdMB8opYG+4Ni0FrW20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSeOdF+nFXYOy9pjDsYenI5h4KpMnU30hqb7ytNfOlAa3azGRs1vXYNR8fI4n6sFVKuDahrZlwpc/wLIhti3UnGpbCBzlpBT9pqA+Y0YO2zriI/e865by9C3Cqi/pHwprI+UGYWg77fm0R1l1xaKj2YE6Z/hQGh3rrAfHZjTfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=20KMQELy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+QyTeQW/As9IjRzVOrP1/IZ7Jkku9UOdmdk9zFQWvDM=; b=20KMQELyV/A1PdZDXK1xNzAzDD
	yEKZShA/slL4ITbRl/MDrnlwoljjq5bv44f4wQcfBH67lWv9obxeK0rVT25FuDKpmpCx3AkVT4zEx
	2vzJT+sjP4HMw7ZOKajAJMEajW9AheAL2BzfXrKFZzoMj5Xfdeck5vT6dBHd4FKPkxKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjeQU-00621R-6Z; Thu, 29 Aug 2024 14:38:58 +0200
Date: Thu, 29 Aug 2024 14:38:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, krzk@kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH net-next v2 08/13] net: mdio: mux-mmioreg: Simplified
 with dev_err_probe()
Message-ID: <df7418a8-1626-4207-b23e-7f0dc3d83164@lunn.ch>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-9-ruanjinjie@huawei.com>
 <20240828134814.0000569d@Huawei.com>
 <c696926d-748f-1969-f684-727d495c4a12@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c696926d-748f-1969-f684-727d495c4a12@huawei.com>

> >> +		if ((u32)reg & ~s->mask)
> >> +			return dev_err_probe(&pdev->dev, -ENODEV,
> >> +					     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
> > I'd align these super long ones as. 
> > 			     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
> > It is ugly but then so are > 100 char lines.
> 
> It seems that this kind string > 100 char is fine for patch check script.

Strings like this can ignore the 80 char limit because developers are
going to grep for it when it shows up in their kernel log. If it gets
broken in odd places, grep will not find it.

I would also say the indentation is correct as is, level with &pdev.

	Andrew

