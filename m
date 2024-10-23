Return-Path: <netdev+bounces-138273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8E9ACBE4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381AF1C20950
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18491B85C0;
	Wed, 23 Oct 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xse6AwjF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBB1B4F04;
	Wed, 23 Oct 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692357; cv=none; b=sLxqvbtdakxuPu8z1Je+/MjeDh+jnAt3CXAFqTo6e8hjgXJqYqSy2JYaDAFtM8yP0X2qhltBJoAyMTEEITPX/joMSFuL3vd8lGmUOZnIshaubTpZbUPRM1F7iNCjSN52KTaDWtUMZUoqa9lT/xu0bjPuB4V233wWU87miwELjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692357; c=relaxed/simple;
	bh=ItwYa/sk7ZTqoVW10hctqguvGcuXioVmHtdqpQD1agU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfJxY0ltkEAdRjfIlAb+1KNuL+J4ZQzreTiYazXPBgA2bpg/zNHKZjINw2mlAmsEkxXVy1AGn86I/qXSG4VHCySUAUNRpa7z1+UBFq00l9mscTTYgiQXtYNZZl7q0n5XD+296DGOPHoIolvzasMCZf5JiAM0HwGSK3lzifJfc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xse6AwjF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=irRFI8LoZ9N01cAYli3PJPEZn/4WwVQJ5SfldnWyeM8=; b=Xse6AwjFo/QQO8k61zlpZMEBMa
	Nh42mcixJjQlsRq2lhREyT+4OLx1qWVvzcpXxreBKnsBf8rfGAVWzdDaMu7RJFSrXw39rvPmIrykf
	WR9+cHf25LLJMtQGonUTPGTccgWzP1r/jms5o/K/02mZhH3teBqlwxfVuy3pGdoKo5Ls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3bzf-00AyLy-J1; Wed, 23 Oct 2024 16:05:47 +0200
Date: Wed, 23 Oct 2024 16:05:47 +0200
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
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
Message-ID: <d66c277b-ea1c-4c33-ab2e-8bd1a0400543@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-4-shaojijie@huawei.com>

> +static int hbg_add_mac_to_filter(struct hbg_priv *priv, const u8 *addr)
> +{
> +	u32 index;
> +
> +	/* already exists */
> +	if (!hbg_get_index_from_mac_table(priv, addr, &index))
> +		return 0;
> +
> +	for (index = 0; index < priv->filter.table_max_len; index++)
> +		if (is_zero_ether_addr(priv->filter.mac_table[index].addr)) {
> +			hbg_set_mac_to_mac_table(priv, index, addr);
> +			return 0;
> +		}
> +
> +	if (!priv->filter.table_overflow) {
> +		priv->filter.table_overflow = true;
> +		hbg_update_promisc_mode(priv->netdev);
> +		dev_info(&priv->pdev->dev, "mac table is overflow\n");
> +	}
> +
> +	return -ENOSPC;

I _think_ this is wrong. If you run out of hardware resources, you
should change the interface to promiscuous mode and let the stack do
the filtering. Offloading it to hardware is just an acceleration,
nothing more.

	Andrew

