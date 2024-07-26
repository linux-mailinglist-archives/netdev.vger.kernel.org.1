Return-Path: <netdev+bounces-113273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D493D6D7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF0B28544A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFF17C211;
	Fri, 26 Jul 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdw3+T2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4362E620;
	Fri, 26 Jul 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011099; cv=none; b=emR+usS3p1JQdAi9LUKmT2ac+WnJaglPF7KjmPFzbvSvwM0w/s/AAjBe4MQ1MDQ2s4Em/umyNF8Q44tnc4sEEDq4yc0F08cM1DV9DhPXhycZld4Fm7A8KowUNOZJzGwrU6JXCeu4CvELkvWyvUoDyyuLtqLEmBRHtD6lMmZHJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011099; c=relaxed/simple;
	bh=OU3zH8zGTnF36MuG1IbQgk2o8MlcwV9IWTTXu1R001A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFq2vbuV3hCLKtm6vR8fizLYVB/ifh9zd7QMD2Yd1Rg7Oq585yAUyowl/YF4cw3oMN1jF0n+5No3MTejkcS2xCDAypcMlDIKRpHcooKLv3nSKRV8VPU1FPozk2i0WSi9CoEXMJ/hbVBxRPZvUwr4FXe2MlS4WGI0FZqYsyJD8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdw3+T2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93B1C32782;
	Fri, 26 Jul 2024 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722011098;
	bh=OU3zH8zGTnF36MuG1IbQgk2o8MlcwV9IWTTXu1R001A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rdw3+T2UjcRdbMZxllNXlqWZ3lXjiqqDbGQnE0ph4yaUWFI1Nu2tpfGHwJJMiBLNz
	 K+zFPs7XiXPZe7Wc4Xfk+Mirr/3ebLVvZrCjHVr91fME2WSnN+eRCYsOwUJxSwmgQA
	 2umNoi8/QqZ9PZmz9OG/seG1p+quw2WSXU5pzFKTS8ph9M5kGxMaktHrSaJdk6fGEW
	 lQqbCBcI4sRTYToYYb/irmCafmuXIzUcyAt2uCnsdXVqakKov+/HKZHb2wpvdkUCPe
	 KwHgS8KZmTaplEKB7pH5X79SvA8vZZUJmbgq4DC1rWLV/QN4XjUEhrmBSjoGrb7AM/
	 XRBgouKuek/yw==
Date: Fri, 26 Jul 2024 17:24:51 +0100
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
Message-ID: <20240726162451.GR97837@kernel.org>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>

On Fri, Jul 26, 2024 at 06:08:53PM +0530, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
>   Link to the spec:
>   -----------------
>   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> 
> - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
>   Link to the product:
>   --------------------
>   https://www.microchip.com/en-us/product/lan8650

...

This is not a review of this patchset, but to set expectations:

## Form letter - net-next-closed

(Adapted from text by Jakub)

The merge window for v6.11 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after 15th July.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

