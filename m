Return-Path: <netdev+bounces-146333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA969D2EC6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDDBB22FAE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7981D1757;
	Tue, 19 Nov 2024 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NhQRvIb4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC0148FE8;
	Tue, 19 Nov 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043910; cv=none; b=q+MyS0KjMwKkGzPZInW+TdTgnY5j2G9SUVpBipCXESdOwzwyrT9nCiQi0jf/IBfzT0T+SwThNrYJh775rmTIhEp9pyfWxsHV6HVaY4DLjOAw2Y9Ns+/NWjKmlvP6LQCNl5iQQoTrRNbeQr6o7gR7g2LU+TzxGK5j1Dc9pH5S4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043910; c=relaxed/simple;
	bh=/aAQDcV+gHUicJ5/4qlnBJFCevcrS1qkXI2MYBeCHz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5ViTQ1BHEPCmVEH00ZDWmE80dMo+/CLFLtNK3H8ODfLkfEsOfqTXrIdl7MsXp+0dSWd+842HQJzfGV/ZmoRUp3hpLzif8zxLLcL6O1UeRD/Bj2g5MqrUkFO/oqSYJsR8Z75sowET7bT0PfylYscDxxoPJZ/WD0NOg0aOfBZyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NhQRvIb4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2X4+40w6EI+JnEcsSnqxwoW536xienx35hbqOEEbSFU=; b=NhQRvIb4fNLj4T14/RjuJxrS8k
	LpRulsEWgF3DuGI8R/XphFLccOJK1Rhpde/15j3e1vabb4f3UFcMVJxpxWstW0HaWSGcRQqEE4jn9
	XKGzlquHd6CzJvI9bO2L/hpOTdDj2hj6Mpc4MBxdDg2gHocUKqliC/PlSe8LoteBJTMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDTjc-00Ds82-9R; Tue, 19 Nov 2024 20:18:00 +0100
Date: Tue, 19 Nov 2024 20:18:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parker Newman <parker@finest.io>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
 <f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
 <ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
 <20241115135940.5f898781.parker@finest.io>
 <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
 <20241118084400.35f4697a.parker@finest.io>
 <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
 <20241119131336.371af397.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119131336.371af397.parker@finest.io>

> I think there is some confusion here. I will try to summarize:
> - Ihe iommu is supported by the Tegra SOC.
> - The way the mgbe driver is written the iommu DT property is REQUIRED.

If it is required, please also include a patch to
nvidia,tegra234-mgbe.yaml and make iommus required.

> - "iommus" is a SOC DT property and is defined in tegra234.dtsi.
> - The mgbe device tree nodes in tegra234.dtsi DO have the iommus property.
> - There are no device tree changes required to to make this patch work.
> - This patch works fine with existing device trees.
> 
> I will add the fallback however in case there is changes made to the iommu
> subsystem in the future.

I would suggest you make iommus a required property and run the tests
over the existing .dts files.

I looked at the history of tegra234.dtsi. The ethernet nodes were
added in:

610cdf3186bc604961bf04851e300deefd318038
Author: Thierry Reding <treding@nvidia.com>
Date:   Thu Jul 7 09:48:15 2022 +0200

    arm64: tegra: Add MGBE nodes on Tegra234

and the iommus property is present. So the requires is safe.

Please expand the commit message. It is clear from all the questions
and backwards and forwards, it does not provide enough details.

I just have one open issue. The code has been like this for over 2
years. Why has it only now started crashing?

	Andrew

