Return-Path: <netdev+bounces-101808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BB900232
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4185B210F2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF9188CC0;
	Fri,  7 Jun 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQSQfIhV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6ED18734E;
	Fri,  7 Jun 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759877; cv=none; b=Z2ke6BkriU3iNFzrdwFpU2W0e/Xhux2yoQbzJERb7npvCVypm1lqxcH22+XS2IlSGsCFvh7UrqPpK5NA2omE4xVPI92XS/OTcUOAFEp6fojML0WW28a3NhesjZwOhETjMtM29qbDbL6fxZaW5MG3oYJTfJLUSARBeOEavsyJ7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759877; c=relaxed/simple;
	bh=Nkzv4hcPPvps22qWpC47FSwYdykZx12iKlrS0Wd94wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdKQXFPeicDJB4d+/47WFVDTa9mCYsv6JXmuu7+kWHJeMy6wHtYEsPpHaeYpZeE3LhAJDwamU1Rq5UpJ0l5zk6NBPYvaEP8mkSZiGl8MJC+NG5UJ5eUCM5z8i4tGTpw7ZEq1Ee3mdXgjwhG60Hy8ukOKExEEYwVNyzEvQCpo5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQSQfIhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD8CC2BBFC;
	Fri,  7 Jun 2024 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759876;
	bh=Nkzv4hcPPvps22qWpC47FSwYdykZx12iKlrS0Wd94wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQSQfIhVy92SkTaaGnvSgGOmaOrGPEO9ebOslY3tPDyGu2jF1GTJI9arb4XK29his
	 0BLTfM2LZthM3JHTsdnQHQt0Z4GQiN7MUermB1jSdlNyTlO1ebFCHNF2nXBVU7sbDs
	 N9dCpUgXtuB9ixdap7wO+KFbjkfX+Fe6eWjl+w1HdJ7rrbqG6mvqzpIHR+sxpLYEBy
	 h7g2mVnP6NnWsT3CayAWQbJNEjj4VeA41bOhubBCrmLD+Op1b9G/fVnN4BqtzwWJmv
	 zYcpo16xMyADhz6EMSN1zwreNy5aX1bROtpuyJXMk6eS6rivF7GgpBMYO/OFEV4fJP
	 Bj9egWQZQQb8g==
Date: Fri, 7 Jun 2024 12:31:11 +0100
From: Simon Horman <horms@kernel.org>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net v2] net: stmmac: dwmac-qcom-ethqos: Configure host
 DMA width
Message-ID: <20240607113111.GA27689@kernel.org>
References: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>

On Wed, Jun 05, 2024 at 11:57:18AM -0700, Sagar Cheluvegowda wrote:
> Commit 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA
> address width") added support in the stmmac driver for platform drivers
> to indicate the host DMA width, but left it up to authors of the
> specific platforms to indicate if their width differed from the addr64
> register read from the MAC itself.
> 
> Qualcomm's EMAC4 integration supports only up to 36 bit width (as
> opposed to the addr64 register indicating 40 bit width). Let's indicate
> that in the platform driver to avoid a scenario where the driver will
> allocate descriptors of size that is supported by the CPU which in our
> case is 36 bit, but as the addr64 register is still capable of 40 bits
> the device will use two descriptors as one address.
> 
> Fixes: 8c4d92e82d50 ("net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms")
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---
> Changes in v2:
> Fix commit message to include a commit body
> Replace the proper fixes tag
> Remove the change-Id
> - Link to v1: https://lore.kernel.org/r/20240529-configure_ethernet_host_dma_width-v1-1-3f2707851adf@quicinc.com

Thanks,

this change looks good to me - the usage of dma_addr_width is in line with
my understanding of how it is intended to be used.

And, AFAICS, the changes in v2 address the review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

...

