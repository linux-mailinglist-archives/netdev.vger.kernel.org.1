Return-Path: <netdev+bounces-189979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615AAB4AE9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CA8466885
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F71E51E3;
	Tue, 13 May 2025 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwgPIRHW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12B1B3956;
	Tue, 13 May 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113723; cv=none; b=Akgrnv7rJEzuVETQc3pBNWwKkTpnCpn3bWkbzMM/SVA54CSnkZWCuJP9SwOG6ohzEeSyFJA3pjwvxFsm/jqkC6fMSN5FGFx03yJGA769ZEqllbYKscQd+pDrZVXotrxg7Jxqw3smjiJSHZ4CyywTHokKIR3BWnrcSaS1VOpZW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113723; c=relaxed/simple;
	bh=0EkDH2Lu1hmxjJBI+/nOcLCQ85AI1IE323FloCtl0z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAERk6HykPS9Friu1QV8F0ARW3dv1q2Srjp5xJ/oJB46vrSTonRq3maeKEvx6WRAYTYjcVDAY6itu06YMWcdiy3vNEeVyWaW1mOnV6zhW6CxZEJyUL1B5757Vw5d5Ys4JsuB9EM/gjxx1vUdr/QPnFPGPsDI2dwYZi0onS4BW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwgPIRHW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747113722; x=1778649722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0EkDH2Lu1hmxjJBI+/nOcLCQ85AI1IE323FloCtl0z8=;
  b=gwgPIRHWCFsUgAClnqWyOzf3BJ+2ZLTa9IabYgMMz+ZljtoajZaTbY/Z
   ErC3keVx90kzrT3HgD9ENmnNxr534CGHtAqK6zJOMkgyney+0HNHdXbQ+
   8rwG1dJC0NnyjzPfF9JjeBba4+Zdg4L0ummBmxVvFfu/CG7XCC8CGZaK4
   YM2fxUsfRpiiNQwCCbzIoMDTWKskjxsLnWuUUgKebkB1+Lkh7fIjOnXBd
   6NqQD66hix/WwGRCxHp9oHRqeaYGNJf5JLuffuQsjI00Uiw30BoKYje5s
   cYxQei15H6nzNpGyFBWy7BZ2HFYSUG/zpnV8IFTnfrW8IwlWSXbsdy8MZ
   A==;
X-CSE-ConnectionGUID: 5HL1QRJsSG+EEleohb2aQQ==
X-CSE-MsgGUID: Wc3vqet8T2CKsx++OoIJxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60277352"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="60277352"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:22:01 -0700
X-CSE-ConnectionGUID: 2yRa1fBCTr+KBaBKRRvjHQ==
X-CSE-MsgGUID: jda8xgckSE+g0j+r2743vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138552385"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:21:57 -0700
Date: Tue, 13 May 2025 07:21:25 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix typo for declaration
 MT7988 ESW capability
Message-ID: <aCLW1ZAVQvs8fkUm@mev-dev.igk.intel.com>
References: <b8b37f409d1280fad9c4d32521e6207f63cd3213.1747110258.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b37f409d1280fad9c4d32521e6207f63cd3213.1747110258.git.daniel@makrotopia.org>

On Tue, May 13, 2025 at 05:27:30AM +0100, Daniel Golle wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> Since MTK_ESW_BIT is a bit number rather than a bitmap, it causes
> MTK_HAS_CAPS to produce incorrect results. This leads to the ETH
> driver not declaring MAC capabilities correctly for the MT7988 ESW.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 22a532695fb0..6c92072b4c28 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -4748,7 +4748,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
>  	}
>  
>  	if (mtk_is_netsys_v3_or_greater(mac->hw) &&
> -	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW_BIT) &&
> +	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW) &&
>  	    id == MTK_GMAC1_ID) {
>  		mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
>  						       MAC_SYM_PAUSE |

Looks like other usage of MTK_HAS_CAPS is fine, thanks for fixing.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.49.0

