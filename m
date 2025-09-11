Return-Path: <netdev+bounces-222162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF5B53548
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF6484017
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69433CE9E;
	Thu, 11 Sep 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ug/U8ts+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96A33A02E
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600889; cv=none; b=f/IaKOd2Q+FSfohGEoo4enO+JAxofF8yNgLm5LGkd5iKC3WyRwuUaGVbrT/jqcCtd4vfakwoeVuDmRUycgIhpHBdjuG5Ihw2jABT+gekEiTuRcbrYavxPfjunbd1A05JuCBz+BN3z1hmtvbsfu73NGRKtTbLNrsTX/6V4eb6Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600889; c=relaxed/simple;
	bh=L8Rv5I9MOtjbqMRwzNPRXdtlZUlDe9OzcwdxyOghTrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I56WZve4VANlbh+OirKx/7G1g1ZKKh/Wji3u7ttWUx/Km+scKfHDcG7kASpUE7/DT5xlQ+Mu+3XDDKIqHUw9LoiSGkj3lW+EY9uhjU09BKFvX80QdjfBuJOovLpVbo7fu3iv7k1INJ8GB5il1Pw1kAf1SBhtKEpRyAWBrbfEoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ug/U8ts+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nRjM2G6ArmE3OzWIa1LqTN8oIhsvSyu0npA7UOn04Qs=; b=ug/U8ts+cKrcqPIqLwFZTzaCBC
	9vg9JUSNtnq5EzR5n/bjAzYibej9nRxBd/rylIbeXRsdsCDhH4iL5TCT8jtCFzA6I4rCfZiOehMCq
	PrirYmZ5xvNzsQzXy84ofOtUywPvcll1ipJ7Z/xZdEc9prOrTGvnSgc6AEPajdyFkueg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwiHC-0085kS-Ag; Thu, 11 Sep 2025 16:27:54 +0200
Date: Thu, 11 Sep 2025 16:27:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
	darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ena: fix duplicate Autoneg setting in
 get_link_ksettings
Message-ID: <6500d036-f6ef-47df-9158-529b2f376fae@lunn.ch>
References: <20250911113727.3857978-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911113727.3857978-1-alok.a.tiwari@oracle.com>

On Thu, Sep 11, 2025 at 04:37:20AM -0700, Alok Tiwari wrote:
> The ENA ethtool implementation mistakenly sets the Autoneg link mode
> twice in the 'supported' mask, leaving the 'advertising mask unset.

These are not masks. They are bitfields.

> Fix this by setting Autoneg in 'advertising' instead of duplicating
> it in 'supported'.
> 
> Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index a81d3a7a3bb9..a6ef12c157ca 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -471,7 +471,7 @@ static int ena_get_link_ksettings(struct net_device *netdev,
>  		ethtool_link_ksettings_add_link_mode(link_ksettings,
>  						     supported, Autoneg);
>  		ethtool_link_ksettings_add_link_mode(link_ksettings,
> -						     supported, Autoneg);
> +						     advertising, Autoneg);

While i agree the current code looks wrong, i'm not convinced your
change is correct.

What does ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK mean?

That the firmware support autoneg? If so, setting the bit in supported
makes sense. But does it mean it is actually enabled? If its not
enabled, you should not set it in advertising.

However, if we assume the firmware always supports autoneg, but
ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK indicates it is enabled,
supported should always have the bit set, and advertising should be
set based on this flag.

	Andrew

