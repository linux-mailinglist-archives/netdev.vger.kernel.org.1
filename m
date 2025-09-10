Return-Path: <netdev+bounces-221766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC6B51D33
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CF8A03B1A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A3335BA2;
	Wed, 10 Sep 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2cziucY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D83314BC;
	Wed, 10 Sep 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520638; cv=none; b=gxXi/rIR49fXmlDoKjCK0bh/2dvoxf0l8HVvb2OTjD8iqC5obKKzrzf9hM2JyudQiTffkWd/PdRZh0mle7PsyoNre7Kj5u81YlJe9/3++PXwM9CMp6Rf04Uar5uxYCcou7W7gN8Y0prwNs0z0oMLgTX+g/PQdqzj4X4atxg2Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520638; c=relaxed/simple;
	bh=SuHO9tUa2OF0OUV6fs2hnkWnqH3DjUqS7DcINbUCcT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCd5t17Up1LYfMBrgzKycP2faEGAYMRF/LM2y2SIxHtotMcxbRxjHItYzWG9foWMrjqi4G73S93zk0RIPL1eqfZ+rmOHmJDuVO+j9z5JpQ22iEs97qmN+lgKs76IE2Mjed15qEjrz2QdD2h6gwYP58mS5F8FtJJcz0S/goz1CA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2cziucY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC2C4CEEB;
	Wed, 10 Sep 2025 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757520638;
	bh=SuHO9tUa2OF0OUV6fs2hnkWnqH3DjUqS7DcINbUCcT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2cziucYHfube3BjQlaYNvlVr34dxKCenN+Mpzq8EIm1zENyj+tz56NRqoigXQ8vf
	 /jcV5dJQqrN9XPMKFAw6Spm6hNzrsCjeUxNgWcNrdKJdPsov6kZmK7Yw2Z6ZJS72na
	 ob+ZPfl4hkKMyAuDnzFmNpqPsbuNiGOIGyQFNQT/sBU+Bbw91IWTFYokvmwNYSvUEo
	 M8vfybJy+58nFcqcj64vm3Qm99XgU+y613S2EggvP40NOdDbSeEiOqo8HPLj+Zo63A
	 avP9ruRF4RghKknOMMsbVSL3B/PjwYERYa5AFZxFZxa9P9GrUUDxIuOVrHIYrxHMzp
	 37fwWf+spb/qg==
Date: Wed, 10 Sep 2025 09:10:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <20250910091036.3054eb94@kernel.org>
In-Reply-To: <20250909-gxrings-v1-4-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
	<20250909-gxrings-v1-4-634282f06a54@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 13:24:02 -0700 Breno Leitao wrote:
> +static int get_num_rxrings(struct net_device *dev)

ethtool_get_rx_ring_count()

> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_rxnfc rx_rings;

You need to initialize this..

> +	int ret;
> +
> +	if (ops->get_rx_ring_count)
> +		return ops->get_rx_ring_count(dev);
> +
> +	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
> +	if (ret < 0)
> +		return ret;
-- 
pw-bot: cr

