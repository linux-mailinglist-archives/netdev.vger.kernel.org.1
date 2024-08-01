Return-Path: <netdev+bounces-114761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDDF944027
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776C6B2EE4F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A5313A403;
	Thu,  1 Aug 2024 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3OBgiFW3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8241C62;
	Thu,  1 Aug 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722473494; cv=none; b=JhXTmPVTLKnkBWAq5hKFayzAjvzlN92470L3PAqkhVHJ9jE0GhRJBu8JTDUkDP8X0vGx77Ggykbfv7TTwpkBUPLqsGEQdczK4ySVtNgjwLrHaIlSddHNPRvY0Z3LjuLmoZfdkLZFrKGbJtfup8NFpwyHwPs7+DcD953Xm5ZHP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722473494; c=relaxed/simple;
	bh=Tob5RJ8TVTfLxnflDB3RbJP2xKlu9U4itI/sQ1ANdQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKWeA0hSuKJy4jCDgKwwPOSW5SlTqweLZKdsCFGhL82UGvV63gQEpANa+g+YoeCFr0L4oKSWE6lpMcQ0EVSxCNQXbCbigG4bZc+3JCK7woa1GiZirWBXulsKH76gxC2o3z4Ae18Xa19E+tbapEriKbvrX47TKZMB/UYrAPFxy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3OBgiFW3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RWocHcypdVDpKFFDvUYKJ1X6d7KbrOKhop1PRWCze7k=; b=3OBgiFW3zRYKBVWyDo8Gi0dVUy
	89mApb6Bd7IRlzAK2aliFLblGHdxQZFOFlupzswxZ0AzDKA4a9XwhopemY1tME4H3s9KzzZOOfCdl
	jKVDWKBOpvPBrkjr+xqY+K4FZx29fAqSbhRHGyvzHXtUQlZvfUx4VI/JbTSfqwWTJRlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZK2O-003j1D-7z; Thu, 01 Aug 2024 02:51:24 +0200
Date: Thu, 1 Aug 2024 02:51:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 05/10] net: hibmcge: Implement some .ndo
 functions
Message-ID: <0e497b6f-7ab0-4a43-afc6-c5ad205aa624@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-6-shaojijie@huawei.com>

> +static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
> +{
> +	struct hbg_priv *priv = netdev_priv(dev);
> +	u8 *mac_addr;
> +
> +	mac_addr = ((struct sockaddr *)addr)->sa_data;
> +	if (ether_addr_equal(dev->dev_addr, mac_addr))
> +		return 0;
> +
> +	if (!is_valid_ether_addr(mac_addr))
> +		return -EADDRNOTAVAIL;

How does the core pass you an invalid MAC address?

> +static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct hbg_priv *priv = netdev_priv(dev);
> +	bool is_opened = hbg_nic_is_open(priv);
> +	u32 frame_len;
> +
> +	if (new_mtu == dev->mtu)
> +		return 0;
> +
> +	if (new_mtu < priv->dev_specs.min_mtu || new_mtu > priv->dev_specs.max_mtu)
> +		return -EINVAL;

You just need to set dev->min_mtu and dev->max_mtu, and the core will
do this validation for you.

> +	dev_info(&priv->pdev->dev,
> +		 "change mtu from %u to %u\n", dev->mtu, new_mtu);

dev_dbg() Don't spam the log for normal operations.

	Andrew

