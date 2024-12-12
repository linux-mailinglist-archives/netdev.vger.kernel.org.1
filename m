Return-Path: <netdev+bounces-151327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA69EE251
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718A0188706A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E020E6F5;
	Thu, 12 Dec 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEo5Vq8s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705620DD62;
	Thu, 12 Dec 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994716; cv=none; b=h6mt52o1XcjARfwcqycQoLRD2GiXmVpRRonwRGJuascJU0pmnop9124aZic8X4ffFfwfTifJIcGoEAIff5fFCI0obmHRnClGr63qCKuhjUnrHCd8OLTG0SEr2QbM4Sy8SdJOwIhrDhSuhb63VlxhZDJjuGISBbIbOsjtGrfNXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994716; c=relaxed/simple;
	bh=kzBsT3F4zajJH9Dt3PQh+yS4Aot+6eJwHXS8DSaNzEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvBlOE1JkGbsaEQv21ognTi6cA2IGIVfUbJkbi0PgtChHj+Z78K1x4fGUWPtn0r/JWAYO/5V9h3BFpzyLQ2c+4C8tNEh7fZXGPoHPEs1G8SRSRzwQjN2A5SmiF2RxONgvKwCl25cpZpuyRlEkzSTqlrZAXvpZ0yEWGFnK3Dzxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEo5Vq8s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733994715; x=1765530715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzBsT3F4zajJH9Dt3PQh+yS4Aot+6eJwHXS8DSaNzEE=;
  b=cEo5Vq8sylL9lgEURRREfwa7XufcPhQ/iuHF/PvuhqCJNIjp6DBEqWBx
   0TUj1/c7I/sEYkb0OS6z8cL1PiCmlrddmO8SMGXnQA5o8rm76ZZ/N8cbq
   PW2okKTYROU6YADoo4mEfh5rAeSIK7KXVlmehK2PIUy8l98UGEvpnYE5W
   VxcyYTSv/2J/49jvpbplszUiHVeYxHpPUAcxz1GKapYbNUBKOuH8VYqNK
   U35oDtOvvk51j2xehHsdJiOpUa9dOJNL5XVmYuBt2ZDr4Nbz45ewJFvsh
   aQUtkemX0de6NOCQpDr5q2cU1smW4iYR2SfG0EFQxRf7HqiINPpHihyHA
   Q==;
X-CSE-ConnectionGUID: fkedDgpvRlO/JlancfuGaw==
X-CSE-MsgGUID: ht0e2ozUQMKgrKbS7AeaCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="21994116"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="21994116"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:11:54 -0800
X-CSE-ConnectionGUID: uq2AS8WyRZyEF+62XFXmDg==
X-CSE-MsgGUID: tvTJ04EgSRmLHfZCdFa8dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96256863"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:11:51 -0800
Date: Thu, 12 Dec 2024 10:08:49 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: Drop redundant dwxgmac_tc_ops
 variable
Message-ID: <Z1qoITwRF9QLkZq/@mev-dev.igk.intel.com>
References: <20241212033325.282817-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212033325.282817-1-0x1207@gmail.com>

On Thu, Dec 12, 2024 at 11:33:25AM +0800, Furong Xu wrote:
> dwmac510_tc_ops and dwxgmac_tc_ops are completely identical,
> keep dwmac510_tc_ops to provide better backward compatibility.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c      |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/hwif.h      |  1 -
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 11 -----------
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 4bd79de2e222..31bdbab9a46c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -267,7 +267,7 @@ static const struct stmmac_hwif_entry {
>  		.hwtimestamp = &stmmac_ptp,
>  		.ptp = &stmmac_ptp_clock_ops,
>  		.mode = NULL,
> -		.tc = &dwxgmac_tc_ops,
> +		.tc = &dwmac510_tc_ops,
>  		.mmc = &dwxgmac_mmc_ops,
>  		.est = &dwmac510_est_ops,
>  		.setup = dwxgmac2_setup,
> @@ -290,7 +290,7 @@ static const struct stmmac_hwif_entry {
>  		.hwtimestamp = &stmmac_ptp,
>  		.ptp = &stmmac_ptp_clock_ops,
>  		.mode = NULL,
> -		.tc = &dwxgmac_tc_ops,
> +		.tc = &dwmac510_tc_ops,
>  		.mmc = &dwxgmac_mmc_ops,
>  		.est = &dwmac510_est_ops,
>  		.setup = dwxlgmac2_setup,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index e428c82b7d31..2f7295b6c1c5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -685,7 +685,6 @@ extern const struct stmmac_dma_ops dwmac410_dma_ops;
>  extern const struct stmmac_ops dwmac510_ops;
>  extern const struct stmmac_tc_ops dwmac4_tc_ops;
>  extern const struct stmmac_tc_ops dwmac510_tc_ops;
> -extern const struct stmmac_tc_ops dwxgmac_tc_ops;
>  
>  #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
>  #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 6a79e6a111ed..694d6ee14381 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1284,14 +1284,3 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
>  	.query_caps = tc_query_caps,
>  	.setup_mqprio = tc_setup_dwmac510_mqprio,
>  };
> -
> -const struct stmmac_tc_ops dwxgmac_tc_ops = {
> -	.init = tc_init,
> -	.setup_cls_u32 = tc_setup_cls_u32,
> -	.setup_cbs = tc_setup_cbs,
> -	.setup_cls = tc_setup_cls,
> -	.setup_taprio = tc_setup_taprio,
> -	.setup_etf = tc_setup_etf,
> -	.query_caps = tc_query_caps,
> -	.setup_mqprio = tc_setup_dwmac510_mqprio,
> -};

LGTM
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks
> -- 
> 2.34.1

