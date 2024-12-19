Return-Path: <netdev+bounces-153160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436D9F71A3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46109168FAD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274EB41C72;
	Thu, 19 Dec 2024 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HekLFyLp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFD35960;
	Thu, 19 Dec 2024 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571159; cv=none; b=W17bx+vmb0N9BlU3X1d/hJvj0CmJsdljoT6cXqnRRmTnLH+PtZYTy0eOxoBHfW25BRydhiMZW7yyrFB20y114vwKVMJBFlE1Wc5VFkwrX63Lzuud+enJTZJe8qKIiffVxGyQymkZRZ1OxLZF+MO9hOyVqsH/O2giKpaClxTWp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571159; c=relaxed/simple;
	bh=WgKrOQgc5+ve3ZEs3d+wbWdTrA44m5zY+NgdD/BDjKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwwxH6yzeSzu2iixbIYGZsuElfx03GzHvYUrxyynj1fskqlVyce2miJJI1DxP3fUD/V/1M2XBTZHXjH+ByUNnj3cmHjSYFyKcV9Xq0ZANLtU4R1yLUW0Z3R4KxcEIpUXncNk5hc9yNYA9ZuHMAwzYczGdfNPFgQ2KnqM3yYIFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HekLFyLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301B1C4CECD;
	Thu, 19 Dec 2024 01:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734571157;
	bh=WgKrOQgc5+ve3ZEs3d+wbWdTrA44m5zY+NgdD/BDjKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HekLFyLp4SrCKPmY5L8j2MeK+4ZuTsqK6fI8koG/ZKdSytND9ZyY44zwKlTOLUFWo
	 UR0tJV37jgCFCdRoA5r+tAdWmEzAfJa8frBLSMr8iRuthRU67Cp9lutbr+/2b0YCqr
	 LjI+e1eoMk323iyi5s4hy1ngIIaAaVFgpSFEnZc2Umml2fkLcaG+McO/xZUoodBFUl
	 6fXxv2+YxOXMFoZcBbOS8lPV14Vic/iGrYptQ1Bn4iudzfK7UuTt7a+JZFoOwtAwT+
	 H8mHUs8F3/JMIeSe73Y6Q2XuNZgZHQA2sSpK4ypoN0WyT3cw7FPG8SBYFRN1JKyJAT
	 W9Zxccha2uS1A==
Date: Wed, 18 Dec 2024 17:19:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of
 DMA descriptor allocations
Message-ID: <20241218171916.24a7e24f@kernel.org>
In-Reply-To: <20241213030006.337695-1-0x1207@gmail.com>
References: <20241213030006.337695-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 11:00:06 +0800 Furong Xu wrote:
> -		if (priv->dma_cap.addr64 <= 32)
> -			desc->des0 = cpu_to_le32(curr_addr);
> -		else
> -			stmmac_set_desc_addr(priv, desc, curr_addr);
> -
> +		stmmac_set_desc_addr(priv, desc, curr_addr);

I can't figure out if this is correct or not in a reasonable amount of
time. dwmac4 and dwxgmac2 looks pretty obviously okay. But there are
also ndesc and enh, which don't seem to map to platform in an obvious
way to an outside reviewer.

Please provide more context/guidance in the commit message, otherwise
this looks like a high risk refactoring for a driver this poorly
designed.
-- 
pw-bot: cr

