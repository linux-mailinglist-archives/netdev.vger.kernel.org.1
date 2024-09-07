Return-Path: <netdev+bounces-126147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D196FF09
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7AE1F22CD4
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CCE5223;
	Sat,  7 Sep 2024 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLMUfOiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB4DDC5;
	Sat,  7 Sep 2024 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673522; cv=none; b=p6iOtnir8D9i3FGc/ei/QX817DjRNcr4t4Tw/24EeaADz2Brf6Eg9KUem4e4I5OMgGYTTyEXQklAYqRchPfkWIsAhntnRW3DTLUnV91aSiGDic+zkR52CNWbOGrTvDAUUB177vxaRBrguj7mekinph8CQQKNq/84+wt8WjQHpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673522; c=relaxed/simple;
	bh=eivU6XWyLHMdNOrbe+NeFg4RRfc4uS3qZGTA0LUgLcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M00Zr9Jk7ebwIeLcfh7w8zUAIveu598Bt3mTaNTaCCEFvbz3OeJnnnK49Irxqf0Lab1O29wlqdGEIbXc8bFXGw3qXWFYnMA9hGjudHckwEUnDbxxx23hiEHDMpSaoETVntiUT69qs9nkJiP+BNJmrlewF3X68VKpXNK2bLW7Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLMUfOiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC34C4CEC4;
	Sat,  7 Sep 2024 01:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725673521;
	bh=eivU6XWyLHMdNOrbe+NeFg4RRfc4uS3qZGTA0LUgLcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLMUfOiPebwVNtSZFGuU1uSJXqMjt4IZDzx3TbTlfTL7yW+TbipAnQ0lVQAccD9I6
	 CdXhI7Eed4+45LRCaOB9FbTkb8xCOWcb2ucUsDVx+ldTeF9a8U0thoL3kxWwG8NP7C
	 8GuNdXjCE3fME0ie5g3z82gmaIAsISZE2bbNSl5UlsDxRevvEfj2KjXaUcrRYGreVe
	 YJ4rlUS9oYLZkO9VruEkVNP8hP32QgDI5KTQhpz7kFdojk/owEDHts9ym8bH0OEuPa
	 vBj7org0XMnWzQ1fMS+JZzODrE9BHZflmzmqsDV2dFQ/2aW7hKOo/47XG89tt0o9PI
	 FLAPcetWnficw==
Date: Fri, 6 Sep 2024 18:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <zhuyuan@huawei.com>,
 <forest.zhouchang@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
 <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 net-next 01/11] net: hibmcge: Add pci table supported
 in this module
Message-ID: <20240906184520.765db72d@kernel.org>
In-Reply-To: <20240905143120.1583460-2-shaojijie@huawei.com>
References: <20240905143120.1583460-1-shaojijie@huawei.com>
	<20240905143120.1583460-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 22:31:10 +0800 Jijie Shao wrote:
> +	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
> +						      struct pcpu_sw_netstats);
> +	if (!netdev->tstats)
> +		return -ENOMEM;

Please set 

	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;

will allocate and free the stats for you.
This will also let other parts of the stack use the stats
since the type will be known (netdev->tstats is part of 
a union).
-- 
pw-bot: cr

