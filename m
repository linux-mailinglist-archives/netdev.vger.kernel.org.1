Return-Path: <netdev+bounces-128407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE336979764
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F6DB2128B
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7701C7B88;
	Sun, 15 Sep 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyzrxGF1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B91C578E;
	Sun, 15 Sep 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412915; cv=none; b=s5l5ZeuwBv5Ss+81cL2k4oB5bqi72sd6eDMngT29o1++Mu8EuLIOqqeXES25xmeZ+uyNT0oW3Lmh6UAfJ2/V253V6QCBrqiHzSAi/uYoZxFNnnNJTcbtPDmU781SGAhnSxSV/m4zKnLkvu+K60fGmc50B/E/fBGEErGpQqAlE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412915; c=relaxed/simple;
	bh=n7Na59v+p8pOInKiHUJBGWxI+ZR57eSSkfICSv4JtyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/xOejf4FF9QmECRPqbRbcpWc+8MqU08GOem8/KTUVuc3laDBjRYZqlMCTYVtHjOVXFcAqfGaQ2O7Y6rkz4neRCSJFvauB6Ji5tkgB4e4sffKBYx+esxY4xoV4l1l/bWHcL7h3AyXr/uX69r9QXXEwPcvK8W26b+bjyk5T0lDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyzrxGF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CECC4CEC6;
	Sun, 15 Sep 2024 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726412915;
	bh=n7Na59v+p8pOInKiHUJBGWxI+ZR57eSSkfICSv4JtyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyzrxGF1tNQPxW4+ykrpd0o8BLbUUdINRbOyz33Oim2Q3ZCLwe4RWK1HSbKjwMI+S
	 2fW85Fq5xCXF+WWkv0lZoocyosTCC+VlXPdxtKcZUnAFlmvRHF8yLZ0zRwxdyh2b0Z
	 MxVnNHUZsaHHNUtkmHr7xwgaGLfy2iA2txJPQbePl+cnP5ZQucxNvgQuBh1yLJ8FtK
	 RK3lejrCbh4oZCw3ALVaNcegwVKnaG+H/c7wRyFl8kq8eudjOloTQaaS7NMBJcfNbM
	 DbQCTEkmhmEz4mqnhN5fIvCwg3at8qJKwlZY1BHvSXYr4kAe1WLr6Yc5DXQ89Byu/0
	 6iQKgJ1kEki9w==
Date: Sun, 15 Sep 2024 17:08:28 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 net-next 06/10] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <20240915170828.60f866f1@kernel.org>
In-Reply-To: <20240912025127.3912972-7-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:23 +0800 Jijie Shao wrote:
> +struct hbg_priv;
> +struct hbg_ring;

these are unnecessary, use as struct member automatically fwd declares

> +struct hbg_buffer {
> +	u32 state;
> +	dma_addr_t state_dma;
> +
> +	struct sk_buff *skb;
> +	dma_addr_t skb_dma;
> +	u32 skb_len;
> +
> +	enum hbg_dir dir;
> +	struct hbg_ring *ring;
> +	struct hbg_priv *priv;
> +};

