Return-Path: <netdev+bounces-138276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E949ACC0B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9ADB2101A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3A1AD9F9;
	Wed, 23 Oct 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PSwANbvV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A5DDAB;
	Wed, 23 Oct 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692966; cv=none; b=Mrzi8zDjEOaorYol3ObjIPTrFz2jah730Cfid8ELYbnhvZPBVqcfkS4VUBGyQFj9hRQwkKvyFtIgILagzADGwLNdS12xANbqJZe0NS1znRdfkldD+WEyMtbnnLHd8m2cmL4K/mK26hwELsL+cHs5Fn0LADdggu+Q+fxV8M9xpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692966; c=relaxed/simple;
	bh=Gu2iN8gdFasYrnvcRt7YhP1qX4e9n5iQRV8z31HhiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZfIKy97E8t+ieT5QerU78HPrJo2uhEcvVqcDQNXT9L9QxyAY6EKlSA+W6zOqBfqI+e9Zw3mnUf9+X0dfEOO7noN7/A253+9Ve0W97+dPQhG+Bao/R8Co5ASwtQpCtp7ayqciIOqUeEEVKShluHGCp+Ona2olDe4ezJ+yZvme78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PSwANbvV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=77p4+RdoNTXvi8evqnZRuTEwaSSlwz6pYfTAGdLu6jM=; b=PSwANbvV5dmlNtnxVfInoDutHp
	dNcnr/T++ZW/GXMDFmwfeetNa+gjBzl94j/WQoN+uLxcHyB/qDKFbkEzvy5utTkpfdfFbU/2CA+lH
	l+yu8JY4KN1j2UIzO68hbtqPVRs99yl8O7pB6WVPiPsu5FRZpFBuUANT707ct3MhLFws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3c9U-00AyPH-76; Wed, 23 Oct 2024 16:15:56 +0200
Date: Wed, 23 Oct 2024 16:15:56 +0200
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
Subject: Re: [PATCH net-next 5/7] net: hibmcge: Add pauseparam supported in
 this module
Message-ID: <ea2caab1-1bf9-47b3-96a8-6c1c92fbc83b@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-6-shaojijie@huawei.com>

> +static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
> +				      struct ethtool_pauseparam *param)
> +{
> +	struct hbg_priv *priv = netdev_priv(net_dev);
> +
> +	if (param->autoneg) {
> +		netdev_err(net_dev, "autoneg unsupported\n");
> +		return -EOPNOTSUPP;
> +	}

Not being able to do it is not an error, so there is no need for the
netdev_err().


    Andrew

---
pw-bot: cr

