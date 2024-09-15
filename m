Return-Path: <netdev+bounces-128409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01397976A
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074CA1F213E9
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05E1C8FA8;
	Sun, 15 Sep 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0GCNU8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E181C3F14;
	Sun, 15 Sep 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413258; cv=none; b=Cjgs4dR1HLX0Z+cUh4t55qqZG5EEgs0o8oeGXX+gFDqATDu+5q2GGHQu8OOiaJlTMWVHkUoFs1u3YsMukL4tYYCVWtdoNcoXQ3iwv73UK+7VwwEgmLRKC68gK+fYJCsrfqnb3wAcKmQ6eoG8BnBEWq9SiHSFr9lrfq3BpWpD2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413258; c=relaxed/simple;
	bh=7H1Xca8D+hkNFzDab9q2m2rHYAo2OvW/IjvDV+FDevY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2WWvECqAU3K8jrSXzed8FTyDciaoUqlRu1g70vBj9pGCPup+pqZGh+UBrxSPf3ytgDxc0ywouiIq5UV92Qa8RI6Y/XNBk30d9DjCU52AEhOgb4QlIZqk0iXATUrqop7MqBOB1YjdS9CHTcleB+VQCR3weNaivMYG+K++XpS/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0GCNU8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BBDC4CEC3;
	Sun, 15 Sep 2024 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726413258;
	bh=7H1Xca8D+hkNFzDab9q2m2rHYAo2OvW/IjvDV+FDevY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0GCNU8+ZlF3mOCzqJd7HWNilZxWNIQWEqD1+PG/ievHassnryUEszg4hIR1UnzmL
	 u66y2GBe4qL6KaVV4FucYw5GL/UB96V9sxxoqgbVxXsMdS1RYfcKaR9vSB5NhI2KsE
	 GTy5S6QdYNQPdgVSyEVI4VD1djJvkSCa2nz2Ju24CrUNhOdav4ol3zCWsc2BJer/T1
	 HWWkRZZ0EaFsRIihDd+RdzwTu2zkWd6A3btrB+gXIkDsnTPFMKK7v3YqRoBuLV2Ljt
	 IiwNpJuW5Lzr1hFxPqJEb5H9ZrmRzAIBKu8++YDSgPg9x+sj0ju4OM1M81fJjj8i0F
	 Rxuz8K9a9MxQA==
Date: Sun, 15 Sep 2024 17:14:10 +0200
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
Subject: Re: [PATCH V10 net-next 05/10] net: hibmcge: Implement some .ndo
 functions
Message-ID: <20240915171410.2c4dc951@kernel.org>
In-Reply-To: <20240912025127.3912972-6-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:22 +0800 Jijie Shao wrote:
> +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	bool is_running = netif_running(netdev);
> +
> +	if (is_running)
> +		hbg_net_stop(netdev);
> +
> +	hbg_change_mtu(priv, new_mtu);
> +	WRITE_ONCE(netdev->mtu, new_mtu);
> +
> +	dev_dbg(&priv->pdev->dev,
> +		"change mtu from %u to %u\n", netdev->mtu, new_mtu);
> +	if (is_running)
> +		hbg_net_open(netdev);

What if open() fails? You either have to pre-allocate the new resources
or find a way of resetting without reallocating memory. Or return -EBUSY
if interface is running

