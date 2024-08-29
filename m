Return-Path: <netdev+bounces-123030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E909637E1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB94B20D5E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D7C1BC58;
	Thu, 29 Aug 2024 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWhMNxu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68ED51E;
	Thu, 29 Aug 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895597; cv=none; b=DjgvfznyukHBrhgQ6B9C50uuuKKm2cFvIHReSqxpiUS0onSBuDn2slwDKaJSQCc/bDN1I7rXj1FGwPANPC7tntgz0g5wQpyu2wtRRjFTtONiqmDaBW/9WgjLcfdY/4vih0IPJClxkRVe2/FEenqphUdeahQC2b2LXzwhQ+IXdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895597; c=relaxed/simple;
	bh=oD8FYTacxTxgrBwXJY8nJnNAYK+VNbBcJ/HhblMaqEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR5qWbYWL8R3TJgMgaJxT02EPa4OzVKOtvlef38Qz+NRhqvwtqwmWHoylNyNfpC74JxG/bmGhYe717uPqx4/hFecDAA9y+gInHAnJWeKrlj9M+S9FHMMse8dTKH6eNnWH+xE7wJchacVx0CXDW4m4b2jeK0RCWLi87rVFU1fAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWhMNxu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6029C4CEC0;
	Thu, 29 Aug 2024 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895596;
	bh=oD8FYTacxTxgrBwXJY8nJnNAYK+VNbBcJ/HhblMaqEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWhMNxu+bZHG5Ku18L3oKH+Atv+3cwGm7O51EbT+6QUdIqA6KE8wlkV5q4BQwp8Nl
	 3igpWajbnUu1UAtDiBdc/Uv4MvKj8vBXiVX7DnPu2bIwVUHMpq5MN7SZ/OaSr+Sjgw
	 O7dsKIPeIKxQDY+jFAR2dyD5s5TQ9FjYH/WML53y6zAyAbBufnYalfgbpQ9Ii1430b
	 spOmsA+/aZsOOiF0BjgO3K5rKAQgRAAhLKNVoDkNhJprICmPOUbML0PR6KyiKDyhxR
	 zaCDiqexLFzD/iNnjg/lx6I/1L7BOMvACgMYKbN3gQjwJETAl33E3L1aJW7TzAGNuS
	 PoFo5/JrtT4SQ==
Date: Wed, 28 Aug 2024 18:39:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
Message-ID: <20240828183954.39ea827f@kernel.org>
In-Reply-To: <20240827131455.2919051-6-shaojijie@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 21:14:49 +0800 Jijie Shao wrote:
> +static int hbg_net_open(struct net_device *dev)
> +{
> +	struct hbg_priv *priv = netdev_priv(dev);
> +
> +	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
> +		return 0;
> +
> +	netif_carrier_off(dev);

Why clear the carrier during open? You should probably clear it once on
the probe path and then on stop.

> +	hbg_all_irq_enable(priv, true);
> +	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
> +	netif_start_queue(dev);
> +	hbg_phy_start(priv);
> +
> +	return 0;
> +}

