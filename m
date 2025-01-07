Return-Path: <netdev+bounces-155717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAB2A03791
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F09163872
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF21A840A;
	Tue,  7 Jan 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlG1v0NM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A283195FEF
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229706; cv=none; b=MI9RaQPG0vTvTec5vVN+J0XDR96mqup85vFEaCRa1lXkBIGcyDAq6862Tot7G7YKhe5JV7lB1hXVyFe7e7Q5Y4TvVEgn3+6C+vPRkPE0s1pGqObMNtZuz3gpUXjWhTHyvZp6WgC2edoGP+vTFSeX5hcBPcYzJA4lr+1oZRkRkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229706; c=relaxed/simple;
	bh=VnwibYjT8jBw8IwFP6CfgTnL083IcGiCaYr09GVI1nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiXPWIQHOtxDarVB9l2VYviEtjl/AyBkZ+29rvOPRG24hYIGTqKJ0LRQHLbYon2r7yzbZeyud5x8fQhM/g58VMubKqJGWTNjKgu819aX07gQLWOxAH01FMoR87zr1+NxqJFRnudNgdG99Uent8b9cQ/h+3jjw5ZKRZBmHPzQaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlG1v0NM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736229703; x=1767765703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VnwibYjT8jBw8IwFP6CfgTnL083IcGiCaYr09GVI1nE=;
  b=TlG1v0NMrgox2zPvKlCEe9WYNx0+2F9Jv157SyttgifDr+yRl82V2DQW
   aZt+3WbcudewqCfNqNQXsRGidUhkfATv6Jl9u7kcxvAEsvfAKLPZ01Mh3
   jzsKQddm68PFA6StAo0pXfsMnA+XeXSA42vrzb81GgHJgBoNJhO9290VS
   469taWYyan007KZTzsUOPaE+GGwywWZLXmxSdDnX8ZNYgW8LIoENzTVdL
   tXEmMty5RxuPPS+yEVnxLei6toy/ADebdx2knNXpwPm80ZPQ6Mg0OfBsE
   HDARdkL2DKcaxZ9GDbpnfcl2Au2F4VWbdPqiuEGzM8d3UK4owqk09Dlrv
   g==;
X-CSE-ConnectionGUID: F/MMRhKSTaSD7MzhXNRNiA==
X-CSE-MsgGUID: zp3RRGPnSu21pRPxvlB3IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="47812720"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="47812720"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 22:01:41 -0800
X-CSE-ConnectionGUID: QcEoKJL3QtSsIlWnqxL5mw==
X-CSE-MsgGUID: hWsoUdjLTd6OO9u/yaTVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="103163445"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 22:01:39 -0800
Date: Tue, 7 Jan 2025 06:58:22 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 2/2] enic: Obtain the Link speed only after the
 link comes up
Message-ID: <Z3zCfiwPl2Xu/Zvi@mev-dev.igk.intel.com>
References: <20250107025135.15167-1-johndale@cisco.com>
 <20250107025135.15167-3-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107025135.15167-3-johndale@cisco.com>

On Mon, Jan 06, 2025 at 06:51:35PM -0800, John Daley wrote:
> The link speed is obtained in the RX adaptive coalescing function. It
> was being called at probe time when the link may not be up. Change the
> call to run after the Link comes up.
> 
> The impact of not getting the correct link speed was that the low end of
> the adaptive interrupt range was always being set to 0 which could have
> caused a slight increase in the number of RX interrupts.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 957efe73e41a..49f6cab01ed5 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
>  static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
>  	{0,  0}, /* 0  - 4  Gbps */
>  	{0,  3}, /* 4  - 10 Gbps */
> -	{3,  6}, /* 10 - 40 Gbps */
> +	{3,  6}, /* 10+ Gbps */

Is this on purpose? You didn't mention anything about speed range in
commit message. Just wondering, patch looks fine, thanks.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  };
>  
>  static void enic_init_affinity_hint(struct enic *enic)
> @@ -466,6 +466,7 @@ static void enic_link_check(struct enic *enic)
>  	if (link_status && !carrier_ok) {
>  		netdev_info(enic->netdev, "Link UP\n");
>  		netif_carrier_on(enic->netdev);
> +		enic_set_rx_coal_setting(enic);
>  	} else if (!link_status && carrier_ok) {
>  		netdev_info(enic->netdev, "Link DOWN\n");
>  		netif_carrier_off(enic->netdev);
> @@ -3063,7 +3064,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
>  
>  	enic_rfs_flw_tbl_init(enic);
> -	enic_set_rx_coal_setting(enic);
>  	INIT_WORK(&enic->reset, enic_reset);
>  	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
>  	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
> -- 
> 2.35.2

