Return-Path: <netdev+bounces-222231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 866DDB539DA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D2904E25F7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E835FC29;
	Thu, 11 Sep 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi89XWxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F935FC1F;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610156; cv=none; b=Lco34NJiDAR+d2Kt+xe1QoYEcGMb5tcTIoG53JIGekofmaPLtmfEBDICW91zEsPFjqnE8un5zY3D3pcWFUGdE1RAmOloajVUE1thaU707ZOFIInd4GtEL4AzQTS6JQMEOyAJ0BLxUo1MABj7VlsiZ0fhC3rNKE3KmP3KbpgXQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610156; c=relaxed/simple;
	bh=JBn7ZUZptRYyLcBRoRqsiC+/d9QEluLjJ1kKkbg5Xkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmDt/3Ot1hrC8QVbzSPbQdvGVBTDo5ynF0yTshsn/ZMo+AzzAjjH8BgWxtItoWwt5yXoNEOThh38Yrjp98j4NBfIKuWQBwTORebebA9lt2MQs/qRw5QZOqndwKZooUz7kJyFyHJFbspusDWZotEpTVrP51W+5F6voIkZM1WP7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi89XWxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192C2C4CEF0;
	Thu, 11 Sep 2025 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757610155;
	bh=JBn7ZUZptRYyLcBRoRqsiC+/d9QEluLjJ1kKkbg5Xkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qi89XWxjqvg6+HjVdoiSuydT66HAjZJ5X1SQN9WOYi+K+7uC6oFStW34400bxsNuz
	 zLNP6wfv1t5hWeiKdhUqAoTDTbGcqleXwbsOSp3E9Fw+f9D6DYYiKh/Nv13OLUZDrR
	 2ENCN5+XszNptTcczKeGiOns/fPUK2uGxSAjca0fqPd1tx5v55piUPQ03ldgcealf8
	 BTMOEdIn7xKeOhvdXDuu/arCPPnS/Il5NGNTXL6PppGVf380yi0EwZBZj03C79Frcz
	 T8TuxUMGPYdukBr9R4tetGd24Td2vyu1pd8txkPXaJ/nYzLp16JD249mHZONqtHq5K
	 Uqjf0ti36Nm/w==
Date: Thu, 11 Sep 2025 18:02:32 +0100
From: Simon Horman <horms@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Message-ID: <20250911170232.GP30363@horms.kernel.org>
References: <20250910054836.6599-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910054836.6599-2-yyyynoom@gmail.com>

On Wed, Sep 10, 2025 at 02:48:37PM +0900, Yeounsu Moon wrote:
> Track dropped packet statistics when skb allocation fails
> in the receive path.
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
> ---
>  drivers/net/ethernet/dlink/dl2k.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> index 6bbf6e5584e5..47d9eef2e725 100644
> --- a/drivers/net/ethernet/dlink/dl2k.c
> +++ b/drivers/net/ethernet/dlink/dl2k.c
> @@ -1009,6 +1009,7 @@ receive_packet (struct net_device *dev)
>  			skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
>  			if (skb == NULL) {
>  				np->rx_ring[entry].fraginfo = 0;
> +				dev->stats.rx_dropped++;

Although new users of dev->stats are discoraged (see ndetdevice.h).
That is not the case here, as the driver already uses dev-stats.
So I believe this is change is good.

>  				printk (KERN_INFO
>  					"%s: receive_packet: "
>  					"Unable to re-allocate Rx skbuff.#%d\n",

Reviewed-by: Simon Horman <horms@kernel.org>


