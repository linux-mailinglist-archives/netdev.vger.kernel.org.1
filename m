Return-Path: <netdev+bounces-185699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69EA9B69E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801117A126E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEF289369;
	Thu, 24 Apr 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4K1d5z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C921F09B4;
	Thu, 24 Apr 2025 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520198; cv=none; b=rXfQWCs6TJD0KziWAfrg4OTKYXBml7/+tmZexRoqG2rn3yH8PY0ZKO/FAF0W5iyygZCeS1pKu0FIMHjtW/AqyKxy7SxmyOdEJIaFcYxGgpUPOc/13Uk3Z6YMYwhJhbvgjJRvAtq2kGSauSqY+rBw4gDgbcf4GYVj2t84RWN39jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520198; c=relaxed/simple;
	bh=e0MSzpfeZC3u0OgpBJaU+o20GeKZiZpJAI9t5/+pTns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdtYNKGqkM16IMTdPpFurI5OwAEBZubPi5McTuIFz47EGdsxh6aMlVmXBQEsQLGHi5LN4JmAK7Vw3F5Hsf76zi0+jsxYh+zN3JbeDUOpxMcQtcX2wayuvjjbTiC1QNLMLWuoCscsTAy+G0Lq106kKwloqsOtZr9syMpzZqx6HIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4K1d5z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CE9C4CEE3;
	Thu, 24 Apr 2025 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745520196;
	bh=e0MSzpfeZC3u0OgpBJaU+o20GeKZiZpJAI9t5/+pTns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4K1d5z2cVAWYRQuDmGg4VfmJIxPQ1MXczD7on+t4QRic41MaX0ABN0CH+8pHP7zJ
	 u6/dNxHsQiy2MT3hX7M+fni8jNGzFyWsNCU1gd4srDlXdQtxT7LQIhkWFHO6TNvpOl
	 Ajfy0ck5+T/Q+TWz25umNhwixgWG8QjSX4ccVikYXMzjiumeRjnQSXfGkoYu9aQ2DJ
	 b2yPsrUoFgnmFRIeYU21CJlbWC0gyG1Ya4aPoQgCI8ev1nWzKe5OCfIh0Ilv0DEnR4
	 eE49muGXrVDxVaio6NWhxgZ91cC0dqjxvAD83gWnopvHPlnszERNmm0tCFH3ksc/f5
	 2dijTq4Fa2RIQ==
Date: Thu, 24 Apr 2025 19:43:11 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: convert cap_bit
 in mtk_eth_muxc struct to u64
Message-ID: <20250424184311.GM3042781@horms.kernel.org>
References: <ded98b0d716c3203017a7a92151516ec2bf1abee.1745369249.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded98b0d716c3203017a7a92151516ec2bf1abee.1745369249.git.daniel@makrotopia.org>

On Wed, Apr 23, 2025 at 01:48:02AM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> With commit 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in
> mtk_soc_data struct to u64") the capabilities bitfield was converted to
> a 64-bit value, but a cap_bit in struct mtk_eth_muxc which is used to
> store a full bitfield (rather than the bit number, as the name would
> suggest) still holds only a 32-bit value.
> 
> Change the type of cap_bit to u64 in order to avoid truncating the
> bitfield which results in path selection to not work with capabilities
> above the 32-bit limit.
> 
> The values currently stored in the cap_bit field are
> MTK_ETH_MUX_GDM1_TO_GMAC1_ESW:
>  BIT_ULL(18) | BIT_ULL(5)
> 
> MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY:
>  BIT_ULL(19) | BIT_ULL(5) | BIT_ULL(6)
> 
> MTK_ETH_MUX_U3_GMAC2_TO_QPHY:
>  BIT_ULL(20) | BIT_ULL(5) | BIT_ULL(6)
> 
> MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII:
>  BIT_ULL(20) | BIT_ULL(5) | BIT_ULL(7)
> 
> MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII:
>  BIT_ULL(21) | BIT_ULL(5)
> 
> While all those values are currently still within 32-bit boundaries,
> the addition of new capabilities of MT7988 as well as future SoC's
> like MT7987 will exceed them. Also, the use of a 32-bit 'int' type to
> store the result of a BIT_ULL(...) is misleading.
> 
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: don't use Fixes: tag
> v2: improve commit message

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

