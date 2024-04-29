Return-Path: <netdev+bounces-92199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64F8B5EC1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C7E1F230BA
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610AA84E01;
	Mon, 29 Apr 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peHhpQsh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063A537E4;
	Mon, 29 Apr 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407445; cv=none; b=d11Q8iYkFg6bv4kge4aGyg/s860YOEYWVh4BBANSgCQTvJOZbsyVQOjQXXKCPfhw1AOGoJ5+MrwSn/KmrFOrZkB/wGAApgwNe2Pdf7Ad5SD5QC0WVrNRkC2eLP1gdKLiptkhPAgR5UgzeA7Pj7ES6ghf09FCl3TOyd3b/C4Y5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407445; c=relaxed/simple;
	bh=fFqtnGEXmleunxxwmJFa/gw4J4uUe8QQW7/ym6mqmIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3XRpRQfLU7Yfto9PoFVqYV9w/cP417eNNEAf16WipBwtWZiAcN00dRt1LWA2zi9hllGX07P4XVr8GIRji/y8pBPce3cNY3FAAD8gdGOaUifnBnnOlNnSAc16dsqemapwLEWjwBzV+GTZf6p1X1QbB0fbVAWBwrZ9Fhbfb/Ie3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peHhpQsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70974C113CD;
	Mon, 29 Apr 2024 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407444;
	bh=fFqtnGEXmleunxxwmJFa/gw4J4uUe8QQW7/ym6mqmIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peHhpQshIYMKgCjHb7us2iCLHYuPPTP+iGOlmvtnb3lusViJnx/VJRq4uD4Lij077
	 c6lYjSCxOcPfGeV/1PejGw0XFlUxt05lrQ+yEJizlve6r/8oCe6mb7ZiCMs4BTeIHi
	 k0pSDFQD7uup811s1AheDKpSAF7UC54Q+DqlLNrBuRsIUigjKDD6Nf0ugMNBJB9oIb
	 BXRUsIZXGB+Q8UHy1qPtso0nRBKibYVZZ7C0OFtbvhgBeVZUhRX3dn60mqp453qFsR
	 P3s1SjzMeL+LU0SaqUr8xUzf5buqCfqT2KpOIf1Vkx1lrEdCU2+Qh7rFTY9Ne6X3ae
	 44fgSn3T1V3Ag==
Date: Mon, 29 Apr 2024 17:17:16 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, corbet@lwn.net, linux-doc@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	horatiu.vultur@microchip.com, ruanjinjie@huawei.com,
	steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 01/12] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Message-ID: <20240429161716.GZ516117@kernel.org>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-2-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:37PM +0530, Parthiban Veerasooran wrote:
> The IEEE 802.3cg project defines two 10 Mbit/s PHYs operating over a
> single pair of conductors. The 10BASE-T1L (Clause 146) is a long reach
> PHY supporting full duplex point-to-point operation over 1 km of single
> balanced pair of conductors. The 10BASE-T1S (Clause 147) is a short reach
> PHY supporting full / half duplex point-to-point operation over 15 m of
> single balanced pair of conductors, or half duplex multidrop bus
> operation over 25 m of single balanced pair of conductors.
> 
> Furthermore, the IEEE 802.3cg project defines the new Physical Layer
> Collision Avoidance (PLCA) Reconciliation Sublayer (Clause 148) meant to
> provide improved determinism to the CSMA/CD media access method. PLCA
> works in conjunction with the 10BASE-T1S PHY operating in multidrop mode.
> 
> The aforementioned PHYs are intended to cover the low-speed / low-cost
> applications in industrial and automotive environment. The large number
> of pins (16) required by the MII interface, which is specified by the
> IEEE 802.3 in Clause 22, is one of the major cost factors that need to be
> addressed to fulfil this objective.
> 
> The MAC-PHY solution integrates an IEEE Clause 4 MAC and a 10BASE-T1x PHY
> exposing a low pin count Serial Peripheral Interface (SPI) to the host
> microcontroller. This also enables the addition of Ethernet functionality
> to existing low-end microcontrollers which do not integrate a MAC
> controller.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

Some minor feedback from my side.

> ---
>  Documentation/networking/oa-tc6-framework.rst | 491 ++++++++++++++++++

Please add oa-tc6-framework to 

Flagged by: make SPHINXDIRS="networking" htmldocs

>  MAINTAINERS                                   |   6 +
>  2 files changed, 497 insertions(+)
>  create mode 100644 Documentation/networking/oa-tc6-framework.rst
> 
> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst

...

> +Device drivers API
> +==================
> +
> +The include/linux/oa_tc6.h defines the following functions:
> +
> +.. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi,
> +                                           struct net_device *netdev)

I think that you need to use a '\' to escape newlines
for a for a multi-line c:function.

e.g.
.. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi, \
                                           struct net_device *netdev)

Link: https://www.sphinx-doc.org/en/master/usage/domains/index.html

Flagged by make SPHINXDIRS="networking" htmldocs
when using Sphinx 7.2.6

> +
> +Initialize OA TC6 lib.
> +
> +.. c:function:: void oa_tc6_exit(struct oa_tc6 *tc6)
> +
> +Free allocated OA TC6 lib.
> +
> +.. c:function:: int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address,
> +                                          u32 value)
> +
> +Write a single register in the MAC-PHY.
> +
> +.. c:function:: int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address,
> +                                           u32 value[], u8 length)
> +
> +Writing multiple consecutive registers starting from @address in the MAC-PHY.
> +Maximum of 128 consecutive registers can be written starting at @address.
> +
> +.. c:function:: int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address,
> +                                         u32 *value)
> +
> +Read a single register in the MAC-PHY.
> +
> +.. c:function:: int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address,
> +                                          u32 value[], u8 length)
> +
> +Reading multiple consecutive registers starting from @address in the MAC-PHY.
> +Maximum of 128 consecutive registers can be read starting at @address.
> +
> +.. c:function:: netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6,
> +                                              struct sk_buff *skb);
> +
> +The transmit Ethernet frame in the skb is or going to be transmitted through
> +the MAC-PHY.

...

