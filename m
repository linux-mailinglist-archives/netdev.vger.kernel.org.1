Return-Path: <netdev+bounces-151280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2329EDE09
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F6D1676AA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7013B59B;
	Thu, 12 Dec 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVe4jA88"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797957CBE;
	Thu, 12 Dec 2024 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975682; cv=none; b=ZQ77sVlB5NcjVcAxzgNOoHgSEZm8f2jSWwRZod3ToPIBcthyRmFCyDIIzCCs0fzmDA6O9zpI9mBmWZMDDKKMcDUmOIS/ok12XKksjBAlSy3+TmLA48ovQXXNOdXnrggeod5XGtu+lnxRBrMJtzQxUk+5wgAXl2j4/N+aVN7Sxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975682; c=relaxed/simple;
	bh=TJo/10K8D4UMkp+crhwMMswgVgBjjdYqS0iUXkzYFtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jevmRnRH8F+OrY7xzM2ja/wlN09M/rbk7Dkr5vkxxMCz05DhG4g85lhCQr6RgGz7HD9Lyf1yzgSNZfG570izuBI/p0+T2dxKs4Yv/yI4z3nt53iOptL+SeQvKHQIEMfe6AO2o1CiBzkIgNnrxneN6yJqkFe56cij4M7V9Yx2Pog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVe4jA88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29E5C4CED1;
	Thu, 12 Dec 2024 03:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733975681;
	bh=TJo/10K8D4UMkp+crhwMMswgVgBjjdYqS0iUXkzYFtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JVe4jA88U6k4cWRe8Yds8rFSljhX9QvFL4ygOlA21TzB/IEUDKm00TuBikQdBT5Ev
	 9vdWxgPhBPHO165Cus2xcq+pfyrCtCFzemFe8gpDPfLuhMWJMkXqwi0TqzVUg24u/z
	 UwY8HXztTIthrwexSjar+oUYZwfqWI62/86aepH2b3pAmFaM+XVcwKIPV0Mki445Dj
	 HckYiS477rk8WCKVdCeMSPeW4A+rp9iAsspJbE2iCtWukknR3Jip1igGjpYtIPbF9T
	 XYLnoXRRDJr4N69uoDw6ZqvwchUJ2WkHLs301t3qTv9IQsr+TzE3QmuMUhhprPAQ1b
	 QOvHccfdiUfCg==
Date: Wed, 11 Dec 2024 19:54:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <gregkh@linuxfoundation.org>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
Message-ID: <20241211195440.4b861d51@kernel.org>
In-Reply-To: <20241210134855.2864577-4-shaojijie@huawei.com>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
	<20241210134855.2864577-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 21:48:51 +0800 Jijie Shao wrote:
> +static void hbg_del_mac_from_filter(struct hbg_priv *priv, const u8 *addr)
> +{
> +	u32 index;
> +
> +	/* not exists */
> +	if (hbg_get_index_from_mac_table(priv, addr, &index))
> +		return;
> +
> +	hbg_set_mac_to_mac_table(priv, index, NULL);
> +
> +	if (priv->filter.table_overflow) {

why are you tracking the overflow (see below)

> +		priv->filter.table_overflow = false;
> +		hbg_update_promisc_mode(priv->netdev);
> +		dev_info(&priv->pdev->dev, "mac table is not full\n");
> +	}
> +}
> +
> +static int hbg_uc_sync(struct net_device *netdev, const unsigned char *addr)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	return hbg_add_mac_to_filter(priv, addr);
> +}
> +
> +static int hbg_uc_unsync(struct net_device *netdev, const unsigned char *addr)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +
> +	if (ether_addr_equal(netdev->dev_addr, (u8 *)addr))
> +		return 0;
> +
> +	hbg_del_mac_from_filter(priv, addr);
> +	return 0;
> +}
> +
> +static void hbg_net_set_rx_mode(struct net_device *netdev)
> +{
> +	hbg_update_promisc_mode(netdev);
> +	__dev_uc_sync(netdev, hbg_uc_sync, hbg_uc_unsync);

__dev_uc_sync() will only fail if it failed to add an entry
you can pass the status it returned (cast to bool) to
hbg_update_promisc_mode(), no need to save the "table_overflow" bool

> +}
> +
>  static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
>  {
>  	struct hbg_priv *priv = netdev_priv(netdev);
>  	u8 *mac_addr;
> +	bool is_exists;

just "exists", without the is_

> +	u32 index;

