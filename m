Return-Path: <netdev+bounces-224796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A517B8A96B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29231C27B60
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AB23815B;
	Fri, 19 Sep 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lli64WPh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D23A927
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299768; cv=none; b=gUrQPRPzf6DAryhsI0kHSsvIz2C0rn7d9xKSc6Ob1S9xRnZF/VwuEMGX1lgOBo+/wWbvOlR/0PQqOLIP5XH/Ovn4cPC3UwSR6fHpW6ZnYdtniVqyiULOW6vqljb6a5JM7fPdz1IfUPpqXeJrrIJQsIKFMTV7/GcbNVfYoqBMcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299768; c=relaxed/simple;
	bh=tRINUuCfJAKmqw5fJkEDdjQfXhGq3k79lU34CHAJBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew0PdYsOhoUf/i4Yhgku97/l177+iaTHYLlpqzgxbv/EzOz+PONU3w+GW1pD4b7WocLt2AjpW5xzuCXYGQuScPuGccRkNHrkAHyOaOqCw/iAbTNR86/0fLWjFQbs+7RJk/TY1RRKK2M+g1A8xSl0aMydXzG2s3loNQABWHiRSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lli64WPh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=13eTelw6DqsVLFa301440JLqBVu/S5TLFdr4a4WGS0Y=; b=Lli64WPhN3bkK0cuNljrGkgYXr
	qAEV17JASuRX39ylV6aSoaSWDMaSZ8LLQFbLKFcPSMqEC8OefsqNg17qqbnq/ce4biLzPhvu4SoVw
	5v+4YQ1/m0FTeutzoDWm479rAeD4obmdGhZAMJXMxg3GhsGUt73mikWiMGyDzt3lJhz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uze5P-008xQN-Jc; Fri, 19 Sep 2025 18:35:51 +0200
Date: Fri, 19 Sep 2025 18:35:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <8b70630c-163b-474b-8322-d72ea8de8778@lunn.ch>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>

> +static int eea_set_ringparam(struct net_device *netdev,
> +			     struct ethtool_ringparam *ring,
> +			     struct kernel_ethtool_ringparam *kernel_ring,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_tmp tmp = {};
> +	bool need_update = false;
> +	struct eea_net_cfg *cfg;
> +	bool sh;
> +
> +	enet_mk_tmp_cfg(enet, &tmp);
> +
> +	cfg = &tmp.cfg;
> +
> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> +		return -EINVAL;

You have extack, so you can give a useful error message, in addition
to EINVAL. set ringparam has soo many parameters it is hard to user
space to know which values can be set. So seeing "rx_mini_pending not
supported" is a big help.

	Andrew

