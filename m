Return-Path: <netdev+bounces-218877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4465B3EF11
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B602C17A8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99C246BD8;
	Mon,  1 Sep 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZV1W/hj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CB42050;
	Mon,  1 Sep 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756785; cv=none; b=htOVjOgCBTBnV7K3BaEvjG0NMVV3vOocM6fZGvkhUisk9s1f0pVTfDSiJI0Bge1fRyUmoxybEXVJ9x6T2t1tGUE7wKpPXbPzpo+aNWiCNHEQVTKoCd2/Z7FKwz9sN/WG/J/bXVpPuWES7p1nj1vZQRTjrZ8RGZew4uAxJXcHOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756785; c=relaxed/simple;
	bh=LjusulijRkUKJpnr1qs0PqNa82Gar7jRHTtIRVpui3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS+p5CoPV12A0FghDjYx3hSzp9Dz6ppqu8f0eWXufEvM3TWzIpKGQ/MJ/pGhmylSKiodfvpcSRTga755/ranKPkgxQgOelIzk9pYF4S5WTZ75RKY+SbdejugojavGIJFBr6tuTjSiC1/EJAxn4lNCcseFxxw6VMpOot1vk6Zwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZV1W/hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC76C4CEF0;
	Mon,  1 Sep 2025 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756784;
	bh=LjusulijRkUKJpnr1qs0PqNa82Gar7jRHTtIRVpui3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZV1W/hjKysAUCJ9xF1iLD4LvckbMHuSKLPpUBsE54akfb7fRZqBmF3onOwJ39QEQ
	 9TJAIVg5mEqgyx6SS9324wg3LEfhMMq7MY31fJAlpwss+fD1TntbP3vEGkuilIMHUF
	 7ckBnOcOrK08fVDhTeWDstysOToIyOSVbjDJ9kZ38F3jKFC59vrQjl32RmYDLVXu4d
	 MkSfLYOFHyOyL//n/pnXs9vNSwb/FFaXEgV1mfpiUOY0d3TxEREVLK2cge0cN1cKtG
	 1pvvHbKGd5CJ8YDdMYsNIihMLn9fHsU3EJEoSD4D67lgygBEIVDMMVH9czwBaFT0uI
	 gMzTZJNb/kRoA==
Date: Mon, 1 Sep 2025 12:59:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
Message-ID: <20250901125943.243efb74@kernel.org>
In-Reply-To: <20250828100237.4076570-2-konrad.leszczynski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-2-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 12:02:35 +0200 Konrad Leszczynski wrote:
> Fix kernel exception by replacing memcpy with strscpy when used with
> safety feature strings in ethtool logic.
> 
> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571

If you hit this with upstream code please mention which string 
is not padded. If this can't happen with upstream platforms --
there is no upstream bug. BTW ethtool_puts() is a better choice.

> Fixes: 8bf993a5877e8a0a ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 77758a7299b4..0433be4bd0c4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -752,7 +752,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  				if (!stmmac_safety_feat_dump(priv,
>  							&priv->sstats, i,
>  							NULL, &desc)) {
> -					memcpy(p, desc, ETH_GSTRING_LEN);
> +					strscpy(p, desc, ETH_GSTRING_LEN);
>  					p += ETH_GSTRING_LEN;
>  				}

