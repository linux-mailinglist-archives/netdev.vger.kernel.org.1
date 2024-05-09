Return-Path: <netdev+bounces-94932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746D8C1076
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B650D283DC2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E91527B1;
	Thu,  9 May 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7NohXp2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE731527A2
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261887; cv=none; b=eApqYl7r8xWwSuE647sLt87vT8/3lYL+sWinOCbLFb60CmZ4JFtSGd16NEBwNf41Q4bgarO6klPxwsfS4MuIAR/T/zG30ENjEjYBKAWqBpmFHUBMJfwWP9vJ/yK5wMYS5FyaN20xbfjaBUAg/2g9gOrYrvaVT1K3L72aBhQuH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261887; c=relaxed/simple;
	bh=X6mJcKbl/jyFKWM4B21MRU7RpG+1kDwlsL6cix9KZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKN928xTRoYY+vYrf9otqYqEUIrbUu8dja1G9O/ITOlrjDFwz5Tdn0pibDgoifQPSE3k9UOSYNkdlgIVy4JinSElvHdZB72Esj07VNAEfWWXatKkMCHhNQddQfZhucFLmqZ7af7kCNZRCryRYsnPUTklWmWUZ0+eV5AY77M/7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7NohXp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D6FC116B1;
	Thu,  9 May 2024 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715261887;
	bh=X6mJcKbl/jyFKWM4B21MRU7RpG+1kDwlsL6cix9KZv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7NohXp2Q/JwG6NlfFYTdxwItu+l/u35Zns69jHGXc/RQ8rIzD1vTKoqsH/KjclKs
	 aRv1FQDizqzLlulnYTUbBUPwSyW0g+w6kGfzvQpFgqdxWSNAIM8+jgH5xPwAoNtn+L
	 pxV6Q3SWX8SADhZ8nuIOWyLHQ2hQbf+6sttvWOeW1A7dDIqAOxGiHrFqM8hwtFr+PW
	 ms4zS9XxbeYvVtmgpaMrBXXM0YzXcafzfwiwqU9Cn502xYsFO9LfdlsQLSIQInmP/G
	 ZGACqz08DmjxDhtb8mjj80gkD9i+zbCP56vqbftcP2YKtNaav4/1puTkQAWBMcEkyJ
	 GBjTBK5U9weMg==
Date: Thu, 9 May 2024 14:38:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 4/4] net: txgbe: fix to control VLAN strip
Message-ID: <20240509133802.GY1736038@kernel.org>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
 <20240429102519.25096-5-jiawenwu@trustnetic.com>
 <20240502092526.GD2821784@kernel.org>
 <00a301daa1be$34d98620$9e8c9260$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a301daa1be$34d98620$9e8c9260$@trustnetic.com>

On Thu, May 09, 2024 at 11:08:46AM +0800, Jiawen Wu wrote:
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > index aefd78455468..ed6a168ff136 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > > @@ -2692,9 +2692,9 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
> > >
> > >  	netdev->features = features;
> > >
> > > -	if (changed &
> > > -	    (NETIF_F_HW_VLAN_CTAG_RX |
> > > -	     NETIF_F_HW_VLAN_STAG_RX))
> > > +	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
> > > +		wx->do_reset(netdev);
> > > +	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
> > >  		wx_set_rx_mode(netdev);
> > >
> > >  	return 0;
> > 
> > Hi Jiawen Wu,
> > 
> > NETIF_F_HW_VLAN_CTAG_RX appears in both the "if" and "if else" condition.
> > Should "if else" be changed to "if" ?
> 
> There are 4 cases where wx_set_rx_mode() is called, CTAG_RX and CTAG_FILTER
> combined with wx_mac_sp and wx_mac_em. But only one special case that
> changing CTAG_RX requires wx_mac_sp device to do reset, and wx_set_rx_mode()
> also will be called during the reset process. So I think "if else" is more appropriate
> here.

Hi Jiawen Wu,

Thanks for your response.

Looking over this again it seems that I misread the code the first time
around. And i think that the current if ... else if ...  construction is
fine. Sorry for the noise.

Reviewed-by: Simon Horman <horms@kernel.org>


