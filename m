Return-Path: <netdev+bounces-94672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85F8C028D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD861C2121B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD710953;
	Wed,  8 May 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WZKtBqyP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FB652;
	Wed,  8 May 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187894; cv=none; b=FG83e/GSnfJja0+pQyXsrUszjwa5JgMp7bkiQ7LPHZ/VLm06Jrs9/cQRfrB7LS5CViUav2KFT0nb/hyIcnp7vIgZ8tomrMAqR87UZPLoqvF63HEIDcXMydoM7CLvZXUxXm5yHB5tWsKGdjj4QIn9ym4gstj5vubjd1WQusxlh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187894; c=relaxed/simple;
	bh=D7E7QeI+gp0ya2d3meWYIiSnBaeMnXJODx+/8sDrago=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeFhxQgJ8ixYqbp4y1foalJmU1Hmj1fxFKEb2CDl1+D9cHNjFiodO2YBiuLBf9qVFZ0tvbkaPpR3LKH0ZAE54fa0RSWdqS1EBR2foIxvK0yqaCUV0KiqutCF52IiRqIce5SAP9Tj90a/mfANrth+K/wagwroo24Ghh8iqobM5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WZKtBqyP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5KTtRIHrwO6zZcqjjoJy7Z2JtnTKoYC+UnI35VpkFyk=; b=WZKtBqyPC1fQ2SapGaZKLVZ10q
	Ivm2zSjyjRZCrrc4TbmokWe9WgSR80tPiiVjVSX3jBotWPP989QGawQX6B+hrqawRjjGDQjVaRyei
	r+8pA9Jw/XawKKe28j2j8Fkym9xK8ZkSytljvMB5Gzv9AXRy0BgI8EEBwGlC6Q2gsP3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4kia-00EyUG-0u; Wed, 08 May 2024 19:04:36 +0200
Date: Wed, 8 May 2024 19:04:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>

> Yes. I tried this test. It works as expected.

>    Each LAN8651 received approximately 3Mbps with lot of "Receive buffer 
> overflow error". I think it is expected as the single SPI master has to 
> serve both LAN8651 at the same time and both LAN8651 will be receiving 
> 10Mbps on each.

Thanks for testing this.

This also shows the "Receive buffer overflow error" needs to go away.
Either we don't care at all, and should not enable the interrupt, or
we do care and should increment a counter.

	Andrew

