Return-Path: <netdev+bounces-200743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75FAE6B80
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D623A54C5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC630749A;
	Tue, 24 Jun 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjHY57pi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3260307498;
	Tue, 24 Jun 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779493; cv=none; b=H4dIMa/u5P0hs5PGm0zfFsE34L/zNwMfIfqJuF1Sw2PnQ1cciqSBZ+5Vjqst7DAqr1CdhdQSoOTa6jxk8pWcZsHxOCRdBP2aTRxfYqdJo4diAlVTZAIsyEXBYh6leTIAqC0k2AOpieYT+FieNTXtlhQLO8KbtNASaTgqUM/lDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779493; c=relaxed/simple;
	bh=P3VihW+mqIUw6aiAqTAXYvFRKnzLkGHPSBvCKl3jDg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAm7q5ZJCusxLizaq0QACWeA3vnTJOtPSjkCm2KcmyoI14ek2PYTv4w7+kg0LRe8nw2RvTwu7xGzaJvG4EMtXmVBeYC3qyfPkv1ZfpcskS5mgaGA62JanNQGUJAdGIbDjQxtX58pQsSQQieoBiMRr+SCE2Ad8vex0h/L9DrHG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjHY57pi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750779492; x=1782315492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3VihW+mqIUw6aiAqTAXYvFRKnzLkGHPSBvCKl3jDg4=;
  b=AjHY57piFhLkIX0aO70GizRPOzEIznfZJz7HOJQIEnox3JXaiqVoP1Lb
   MLUT3v3UHryeT+jnnnikSKTclXvCsm1Z4zQX1xBzQmZ/vHcy9A+HvVlaP
   Dx93+lRq5Tk1hNZDzSPPsxtxzCICae43JJKQjON0UNHwEAdgiG0Eqhxux
   hT2mp6QjxjsQTxeeC0xnw80+tw8RE0ecrLJpnNKg+vIDQgOgT9xN1m0o2
   6eTWTbKpu63QiJKLXWPI3LwcBzir07h4/8pWGcKm/HLut0vOz9j8LPwtX
   /iBU972XWlmVonK7TW6ZqU6a/I7mvfRD7dYBYlGVD6XuXYf5oauaOw7Gh
   Q==;
X-CSE-ConnectionGUID: XtER0C0tSVSTOFA6cZp+PQ==
X-CSE-MsgGUID: LRiOEMsyTDe4mHJ+V63yeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64381055"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="64381055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 08:38:11 -0700
X-CSE-ConnectionGUID: VCajuleGSgeHEcLaUQTxAQ==
X-CSE-MsgGUID: 7ZNQYlxWSbGgqLkoqZOHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="182836326"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jun 2025 08:38:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id EDA47224; Tue, 24 Jun 2025 18:38:05 +0300 (EEST)
Date: Tue, 24 Jun 2025 18:38:05 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: zhangjianrong <zhangjianrong5@huawei.com>
Cc: michael.jamet@intel.com, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, guhengsheng@hisilicon.com,
	caiyadong@huawei.com, xuetao09@huawei.com, lixinghang1@huawei.com
Subject: Re: [PATCH] net: thunderbolt: Enable e2e flow control in two
 direction
Message-ID: <20250624153805.GC2824380@black.fi.intel.com>
References: <20250624093205.722560-1-zhangjianrong5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624093205.722560-1-zhangjianrong5@huawei.com>

Hi,

Perhaps $subject:

net: thunderbolt: Enable end-to-end flow control also in transmit

or so.

On Tue, Jun 24, 2025 at 05:32:05PM +0800, zhangjianrong wrote:
> According to USB4 specification, if E2E flow control is disabled for
> the Transmit Descriptor Ring, the Host Interface Adapter Layer shall
> not require any credits to be available before transmitting a Tunneled
> Packet from this Transmit Descriptor Ring, so e2e flow control should
> be enabled in two direction.

be enabled in both directions.

> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>

Good finding, though.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/net/thunderbolt/main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 0a53ec293d04..643cf67840b5 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -924,8 +924,12 @@ static int tbnet_open(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
> -				RING_FLAG_FRAME);
> +	flags = RING_FLAG_FRAME;
> +	/* Only enable full E2E if the other end supports it too */
> +	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
> +		flags |= RING_FLAG_E2E;
> +
> +	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
>  	if (!ring) {
>  		netdev_err(dev, "failed to allocate Tx ring\n");
>  		return -ENOMEM;
> @@ -944,11 +948,6 @@ static int tbnet_open(struct net_device *dev)
>  	sof_mask = BIT(TBIP_PDF_FRAME_START);
>  	eof_mask = BIT(TBIP_PDF_FRAME_END);
>  
> -	flags = RING_FLAG_FRAME;
> -	/* Only enable full E2E if the other end supports it too */
> -	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
> -		flags |= RING_FLAG_E2E;
> -
>  	ring = tb_ring_alloc_rx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags,
>  				net->tx_ring.ring->hop, sof_mask,
>  				eof_mask, tbnet_start_poll, net);
> -- 
> 2.34.1

