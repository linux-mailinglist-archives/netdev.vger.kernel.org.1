Return-Path: <netdev+bounces-149560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37559E6397
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986C8162744
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF661A269;
	Fri,  6 Dec 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVCnGO87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454310957;
	Fri,  6 Dec 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449809; cv=none; b=cDAGKxy/NJTvOb3ltWxNS4fx68Zz9ufm2ByfEhv0y9XYqyNYHDlOaeBeMd66y6t7Wi80u8LnQL+AQFpDtY1n6XuoLqDjRZ8Yh/21KGR6QzEMoKQH55X/gWrUcJ82ZTBUuyb+/Hob2mhvTgQTfTLq1ugeMNBdwFoM0KiIcKiYf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449809; c=relaxed/simple;
	bh=bW65i811fDrjHfY/VxLUbPF+5BLD0cbq8jfzdEKjG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9KjrQRipxfgnXpGq11zXrFDE4LWCtdgmQOE34N8SzNFEYNxE+z/pyYN0RLE0TouxB+LGiIQ+jNihTQr+voZGiyeAuxF8dnLHAJDuVQbt5SgOoj601sUs+0bKH693aJTShEk3GVyMk1N+A6m0+U34m2x6nVr//78UZV3EC/ahYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVCnGO87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99DC4CED1;
	Fri,  6 Dec 2024 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733449808;
	bh=bW65i811fDrjHfY/VxLUbPF+5BLD0cbq8jfzdEKjG/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVCnGO874yBcBhXsba/iFWje7H0YxtyTVTO04Ogb11ZABhYXRhXWbMHl++OnBpNfC
	 S+H75kBS+miuNu/GUv2cJ5lhyjkxt9I8kO1e6x7pYxKWWz7A0yVGHYnGd7PSDXUcYB
	 zt/2zY+UR4wZXYaCup/MW1agfNpjA0+osNnFJ5qPq+bT7NEt/iFG5bsT+aVI9gsSeT
	 PhPUQh8o3aX9mQe9cBF6TvD5Zl61qpgwzKYa9bt9F+bjxbvkPMpsNG/pP0HIof0B1M
	 6/+A8f/EC4fSozZzYN/pK4BmJh8ew+mAye9h62q6no+zVdMEEkhnUGOnz90WdqX8wn
	 NyyYxVOQOzqaw==
Date: Thu, 5 Dec 2024 17:50:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V4 RESEND net-next 1/7] net: hibmcge: Add debugfs
 supported in this module
Message-ID: <20241205175006.318f17d9@kernel.org>
In-Reply-To: <20241203150131.3139399-2-shaojijie@huawei.com>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
	<20241203150131.3139399-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 23:01:25 +0800 Jijie Shao wrote:
> +static void hbg_debugfs_uninit(void *data)
> +{
> +	debugfs_remove_recursive((struct dentry *)data);
> +}
> +
> +void hbg_debugfs_init(struct hbg_priv *priv)
> +{
> +	const char *name = pci_name(priv->pdev);
> +	struct device *dev = &priv->pdev->dev;
> +	struct dentry *root;
> +	u32 i;
> +
> +	root = debugfs_create_dir(name, hbg_dbgfs_root);
> +
> +	for (i = 0; i < ARRAY_SIZE(hbg_dbg_infos); i++)
> +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
> +					    root, hbg_dbg_infos[i].read);
> +
> +	/* Ignore the failure because debugfs is not a key feature. */
> +	devm_add_action_or_reset(dev, hbg_debugfs_uninit, root);

There is nothing specific to this driver in the devm action,
also no need to create all files as devm if you remove recursive..

Hi Greg, are you okay with adding debugfs_create_devm_dir() ?

