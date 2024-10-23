Return-Path: <netdev+bounces-138280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4039ACC1E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF531F22E7F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E501BD017;
	Wed, 23 Oct 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c9Gp2nyx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661051A76AC;
	Wed, 23 Oct 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693167; cv=none; b=uIIUKJqaJPOptgA1nsNNfXH3Na0Ve1fSbvinlynx3aUKJ0UmnbGJGCLYCZZn/a4R7mZcIgGYR7U8GoXxLhqYrTZ8A1+1najuVPuLylszUh82gJz8ctLnb7rG7bdLbCVdWABeYuIw9ugFLZpL0pXrhGJSDh4UyEWg4MOOyjHn77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693167; c=relaxed/simple;
	bh=FoHxH+9wsfGKFGD0k6kjbUJBPw85bHnZowT36nmDODs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRGqkonCrUQXwN5VZ93XiV+gRwnKLZe05EpuxrajYmhSkEcJFJPdIPK6IlS9A9gGelzy9w/AR3+x3rAxCU9g48MHibBBrgPCZM+023Mw3SgDED8F9fK4XbmjNoiDHfu4YLcfi5ipptjxJKcYWaKhD3fUjRTkoqvNtWd9KNhVFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c9Gp2nyx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IwqvHuF1Zy2iPtyM1A1kEGzLN9h3efIwk8pyQq8z64s=; b=c9Gp2nyxrDaOrnIuxb/874no1C
	R2K5+vo/eeM5KMtNcxndGqB+lgK/OUacWE8ZenJljwmZ411n0qwBWIgSg7U2nDndbLFVZMymWDHwp
	LTZJG8v51kmKFDkMoO3RVVoGlrA9O2BwoRdK7S79drYrOJiOxfX0Q6MV/7Euurk85ZvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3cCk-00AyRj-VI; Wed, 23 Oct 2024 16:19:18 +0200
Date: Wed, 23 Oct 2024 16:19:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: hibmcge: Add nway_reset supported in
 this module
Message-ID: <b4a1a293-f35b-4338-bd7c-9f1e550854b2@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-7-shaojijie@huawei.com>

On Wed, Oct 23, 2024 at 09:42:12PM +0800, Jijie Shao wrote:
> Add nway_reset supported in this module
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
> index 1e93d1dcf7a0..2fef3d161c21 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
> @@ -367,6 +367,7 @@ static const struct ethtool_ops hbg_ethtool_ops = {
>  	.get_link		= ethtool_op_get_link,
>  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
>  	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
> +	.nway_reset		= phy_ethtool_nway_reset,
>  	.get_sset_count		= hbg_ethtool_get_sset_count,
>  	.get_strings		= hbg_ethtool_get_strings,
>  	.get_ethtool_stats	= hbg_ethtool_get_stats,

It is odd that you have phy_ethtool_get_link_ksettings etc, so have
phylib integration, yet don't support pause autoneg?

	Andrew

