Return-Path: <netdev+bounces-103245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF39074A2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BA41C23ADF
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EE143C7E;
	Thu, 13 Jun 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y0ObKpEv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263014265A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287632; cv=none; b=jWwVNlV+x6LDz26lGcjBJI6gKFWi4npPq1/zV5iIf5yIW9mlyJ68dQJfoee/7/lScDIEjRCW3w+GDgu9JkSaND040SihDbeRKm2d2BbYuBdjxSmibKe4rfHA8lKwDV2x6noW8photpvcpnjLU7fq9Axg1MQaVhkMdSViBNSZWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287632; c=relaxed/simple;
	bh=iZ8m1EfBOd1SnoGwLiPYUfu4Y6EqxSI1bQ18J2uWDsQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igtCXD5+epmYNe5MP//oFummz6HvG1h9Yfd4eldb0HRBvOZ/Can2ILvXCFn9D3wqL1N8tZ1J5sdhbL3rL4IxLZzWHAXYDHi+sFBet+mAROANufplccsLW8U52blSY1PD0LZH2TKvRCCj5MNps2n0LpN1go5tlmI7gpGu9lfFULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y0ObKpEv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718287629; x=1749823629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZ8m1EfBOd1SnoGwLiPYUfu4Y6EqxSI1bQ18J2uWDsQ=;
  b=Y0ObKpEvX8/Xh7GGaGnHORjAP6C1AjP19LMeXzAhkoguDSfuVxD3dk7I
   Lw/5g83HnpAe7cey1Gh908ayIglIPqRtK82MMBj57P7cmOd/fVGeDnR9h
   D4X7M2X3eO1INGeuyrwzKTc2W0BOWkJrMEVGQ5iVbK48sjh7jLRy9kPPx
   Md55Y0FsoNqV/dlA/8Tosbm405FYBeOTTl0rkAu1ykQmbWSDUDmrE315m
   xhYCaI0wJNs8N3gyhFx+1BK7kksqVQnWtgPVgKRgn8HGJfDYJZYe9Cd6L
   p4O/7PG5pTPlUxkaFPaX6QK94y5gIpO8TUB/cXBLzYvo1j1N1IrWVt3Pb
   w==;
X-CSE-ConnectionGUID: jOv7ZpKbTC6+JoTCNFFumg==
X-CSE-MsgGUID: uXhU0UtkQ9Gfkc9kNruTbQ==
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="29854906"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 07:07:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 07:06:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 07:06:55 -0700
Date: Thu, 13 Jun 2024 16:06:54 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] eth: lan966x: don't clear unsupported stats
Message-ID: <20240613140654.me6zzng4v5uerwbr@DEN-DL-M31836.microchip.com>
References: <20240613003222.3327368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240613003222.3327368-1-kuba@kernel.org>

The 06/12/2024 17:32, Jakub Kicinski wrote:
> Commit 12c2d0a5b8e2 ("net: lan966x: add ethtool configuration and statistics")
> added support for various standard stats. We should not clear the stats
> which are not collected by the device. Core code uses a special
> initializer to detect when device does not report given stat.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
> CC: horatiu.vultur@microchip.com
> CC: UNGLinuxDriver@microchip.com
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
> index 06811c60d598..c0fc85ac5db3 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
> @@ -376,7 +376,6 @@ static void lan966x_get_eth_mac_stats(struct net_device *dev,
>                 lan966x->stats[idx + SYS_COUNT_TX_PMAC_BC];
>         mac_stats->SingleCollisionFrames =
>                 lan966x->stats[idx + SYS_COUNT_TX_COL];
> -       mac_stats->MultipleCollisionFrames = 0;
>         mac_stats->FramesReceivedOK =
>                 lan966x->stats[idx + SYS_COUNT_RX_UC] +
>                 lan966x->stats[idx + SYS_COUNT_RX_MC] +
> @@ -384,26 +383,19 @@ static void lan966x_get_eth_mac_stats(struct net_device *dev,
>         mac_stats->FrameCheckSequenceErrors =
>                 lan966x->stats[idx + SYS_COUNT_RX_CRC] +
>                 lan966x->stats[idx + SYS_COUNT_RX_CRC];
> -       mac_stats->AlignmentErrors = 0;
>         mac_stats->OctetsTransmittedOK =
>                 lan966x->stats[idx + SYS_COUNT_TX_OCT] +
>                 lan966x->stats[idx + SYS_COUNT_TX_PMAC_OCT];
>         mac_stats->FramesWithDeferredXmissions =
>                 lan966x->stats[idx + SYS_COUNT_TX_MM_HOLD];
> -       mac_stats->LateCollisions = 0;
> -       mac_stats->FramesAbortedDueToXSColls = 0;
> -       mac_stats->FramesLostDueToIntMACXmitError = 0;
> -       mac_stats->CarrierSenseErrors = 0;
>         mac_stats->OctetsReceivedOK =
>                 lan966x->stats[idx + SYS_COUNT_RX_OCT];
> -       mac_stats->FramesLostDueToIntMACRcvError = 0;
>         mac_stats->MulticastFramesXmittedOK =
>                 lan966x->stats[idx + SYS_COUNT_TX_MC] +
>                 lan966x->stats[idx + SYS_COUNT_TX_PMAC_MC];
>         mac_stats->BroadcastFramesXmittedOK =
>                 lan966x->stats[idx + SYS_COUNT_TX_BC] +
>                 lan966x->stats[idx + SYS_COUNT_TX_PMAC_BC];
> -       mac_stats->FramesWithExcessiveDeferral = 0;
>         mac_stats->MulticastFramesReceivedOK =
>                 lan966x->stats[idx + SYS_COUNT_RX_MC];
>         mac_stats->BroadcastFramesReceivedOK =
> --
> 2.45.2
> 
> 

-- 
/Horatiu

