Return-Path: <netdev+bounces-184796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B5A9735C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D13AB616
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9529617D;
	Tue, 22 Apr 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVGR+ToU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84D13C3F6;
	Tue, 22 Apr 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341743; cv=none; b=JjU7y19Y/7IYNJLm0MhZl8wws/E8PcEf94mtg2Gm4jWjMoXDmssiScp+HKBjmQd984MJUgTOkI0BbRW5OKNs1+AlENVCCZ6DqjIMcfRiCLYQAQ13X5mLedWtgHnjFgGI1pHWPhnihaqwhJecjvwf6ujD/y0IjcoUM36yYUakqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341743; c=relaxed/simple;
	bh=cfux6OpSEf4zIM34Xufn2UQbviRHWmsNHDSxigTjgfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKVCvy8DI5X1njR2iPYZwwtGwVx7ivZKRZpoK7uVguIqH0a12ijsqlDfP3dq1B1jGUpCpKZBWxul4JrFue0cXBXCOCBrz5WP6m2/6J1gU8z9Erv9VI7ZP7BC6+fPfd7IJhXq9vz3cqIKcTRxWTmdzD4/5fiGM4vz8gqH698mox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVGR+ToU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF8C4CEE9;
	Tue, 22 Apr 2025 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745341743;
	bh=cfux6OpSEf4zIM34Xufn2UQbviRHWmsNHDSxigTjgfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVGR+ToUEbLnB+Rua6EgtpsO3NkyuLn+KBKN8XJ9qpc9dxCRC7IwgCup001kf/Cmj
	 wGX4AP1ayXq7enDHtfQ99453NJbjrW0egSCxfojqMoAXHgsjrbHjNSo9hLuHjz/c/2
	 QOHb2IaZIs4SNebhYLjOexxFuqJrL1J9b5qWbbr6mgJ/bI0cH7P6VtpulaU+EVBDVW
	 KOQHmfVBDcMhFhEfnd+YBooUDlrO189B8dsB+OJBzco7lNodlMT1koh4Bl1lt3LZ1H
	 7dHgwaKUzim0ey6xP/DGFlZ2MhkG6v7yriZEHrpfHsLp+mRWMXRtV4LiNckFKOC6Xp
	 iFymvNOcuvJUA==
Date: Tue, 22 Apr 2025 18:08:58 +0100
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
Message-ID: <20250422170858.GL2843373@horms.kernel.org>
References: <d6d3f9421baa85cdb7ff56cd06a9fc97ba0a77f9.1744907886.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d3f9421baa85cdb7ff56cd06a9fc97ba0a77f9.1744907886.git.daniel@makrotopia.org>

On Thu, Apr 17, 2025 at 05:42:16PM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> The capabilities bitfield was converted to a 64-bit value, but a cap_bit
> in struct mtk_eth_muxc which is used to store a full bitfield (rather
> than the bit number, as the name would suggest) still holds only a
> 32-bit value.
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
> Fixes: 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64")

As this is not a fix and not for net it should not have a Fixes tag.

If you wish to reference the commit you can do so using:

commit ("net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to
u64")

E.g.:

Introduced in commit ("net: ethernet: mtk_eth_soc: convert caps in
mtk_soc_data struct to u64").

Note this should be line wrapped. And should be in the "body" of the commit
message. That is, if it comes at the end of the commit message then there
should be at least one blank line between it and the Signed-off-by and
other tags

> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: improve commit message, target net-next instead of net tree

