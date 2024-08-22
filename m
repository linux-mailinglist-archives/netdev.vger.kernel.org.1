Return-Path: <netdev+bounces-121109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329695BB7E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9762820C6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371461CCEFE;
	Thu, 22 Aug 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i9kxqbFK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CC1CCEC8;
	Thu, 22 Aug 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343234; cv=none; b=ZhHtXgBAFN1c/GHZ4BTOC/sryK1TyB/4p9tkkPZ8fN4exLh+decpdi2OgnSszAiHXacg1rDNyy7MKbb/PN4IB68b1J8Y5lqVd+nlNIWtAWM4OFlq8Xd6Em5mAIztaGr55+MA9Vnq2+NuvO+vaCMzPT/svzOIlEbVIECCcJ6YrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343234; c=relaxed/simple;
	bh=e1oypbvajF4SpUfew03oYi1l67UaC7jt3mKCV5LBYZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNNa5jPR3YB4HUazjHe4wtAa8ZNdhWKHA2ZCnXcVNnfB9uTzrVhpOVuy5kB80cY2TBshMLxFDWllhZ7C3fuAzjbzFxros2ZI9LIUqA12ri6hm8nrZul9U41L/VIx3QoVdQqgv86iVF2p4txk0nNQMYDBCsceEQIt2CnFGA/0Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i9kxqbFK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tHqmbEg8SYjmlcNGaQCSIvPSOQSjjDliqZxcEwLOK6E=; b=i9kxqbFKZHxd86yjMFoT8YTN7f
	stGIMQCAdFAVxHHvpPru2lpxTbAugncjFbaaNv1FEflwC0pVjbIxlRlKcGy+yvYOlPDM2+/jFCjan
	sHy3QzoUuv1UvRbkYuhrJyRgBxiTeZJpBbdmwUuzawORiJMqXsT68K0G6KSjzi83ZWBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1shARQ-005RxK-Ni; Thu, 22 Aug 2024 18:13:40 +0200
Date: Thu, 22 Aug 2024 18:13:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 08/11] net: hibmcge: Implement some
 ethtool_ops functions
Message-ID: <81c1b3de-fe78-4601-9093-641f4a0cda19@lunn.ch>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
 <20240822093334.1687011-9-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822093334.1687011-9-shaojijie@huawei.com>

On Thu, Aug 22, 2024 at 05:33:31PM +0800, Jijie Shao wrote:
> Implement the .get_drvinfo .get_link .get_link_ksettings to get
> the basic information and working status of the driver.
> Implement the .set_link_ksettings to modify the rate, duplex,
> and auto-negotiation status.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

