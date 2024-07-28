Return-Path: <netdev+bounces-113430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E393E3E8
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B59B212AD
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B03AD51;
	Sun, 28 Jul 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpMnS7YG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085B2570;
	Sun, 28 Jul 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722151113; cv=none; b=RtomcmTGXKdGqDLS4zyD8wWjJNhTJeUMh1H1P357wLwJQgowT8yjeXyXxEs9oa60DFpPEqH61ym9szEsiSqSAxDsijvveYpbr/GhI4HF2BWd7+ZDiUuD2Iems7OCo/UZ09dHXtJIrUekTwEG8bSCEvBvin/nXWj/otiMabhUiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722151113; c=relaxed/simple;
	bh=sowjuugZXaxlM/D0SnpRi0wuYt0TKl1lXVH9UI1bHd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2Iv24FGsDjVIhGlqbDEvEVtEin+vjjAsKpRF3cM4aFJSR99wYRt5CiwvC2GJXzr3+jI2h2B9+nsawjH/XL4ST/HEWBSp4Sn75H0kYUo9/KKxGl1+EWy3hmkyBb4sOJTLXXqpXGMoLPfXFK23gfITaJNCehCMo8E0cr3+2DD6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpMnS7YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF6C116B1;
	Sun, 28 Jul 2024 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722151112;
	bh=sowjuugZXaxlM/D0SnpRi0wuYt0TKl1lXVH9UI1bHd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpMnS7YGlAahC1hLNy52G+1r8C5lA3r2WZXSjrY/s4xXVmq3Ly7pRSSF+O/YwyelT
	 a7xQByMbRoAzBeG0ef/mIOdCqzgXo9iRifQaXsylYdhnnDHlrul3geiU35CdyvxgUX
	 FA6FNTBSgOkRfjAICaWfMjQT7GNTwojsaJq+GYPPmgzvybGieiAJzEO4WW6bGIlZVE
	 68RFU2g6uon4+YUgefrsTtXTHBsbOOr03Z2u5RW0JgYsXjKeIQzgNKiefk/NJrtLSR
	 vM1vgrFn699O6b4SraT6lwk/ZZoYDuwHziOrsY2unukCkMUo/SFfz28cu66ymJGYYA
	 YQ9DQXfDjNP8w==
Date: Sun, 28 Jul 2024 08:18:21 +0100
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
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 00/14] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <20240728071821.GC1625564@kernel.org>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
 <20240726162451.GR97837@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726162451.GR97837@kernel.org>

On Fri, Jul 26, 2024 at 05:24:51PM +0100, Simon Horman wrote:
> On Fri, Jul 26, 2024 at 06:08:53PM +0530, Parthiban Veerasooran wrote:
> > This patch series contain the below updates,
> > - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
> >   net/ethernet/oa_tc6.c.
> >   Link to the spec:
> >   -----------------
> >   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> > 
> > - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
> >   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
> >   Link to the product:
> >   --------------------
> >   https://www.microchip.com/en-us/product/lan8650
> 
> ...
> 
> This is not a review of this patchset, but to set expectations:
> 
> ## Form letter - net-next-closed
> 
> (Adapted from text by Jakub)
> 
> The merge window for v6.11 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after 15th July.

Sorry, I'm not sure why I wrote the 15th, I meant the 29th.

> RFC patches sent for review only are welcome at any time.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer
> 

