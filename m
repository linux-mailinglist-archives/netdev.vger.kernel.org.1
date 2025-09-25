Return-Path: <netdev+bounces-226191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8ACB9DBCD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B641B2225F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7FC2E8DE5;
	Thu, 25 Sep 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xiKysYkG"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7F2676DE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783379; cv=none; b=b7YO4KHeT6rsGbM4mfFrqIGs9UJvgHJr93oEPvt9MbHeo8K23+m7j0HfAN0PjSGMYOdXnPV4f4AFjnhrJjxCrkzrEteMQkqC9M8rj8oXJN7VIfFQ0cxTxZp9BhVFs6jKBFWtBDaSNQpuI5dWsq1hmkB1Wsco+qZdI8khCGNB9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783379; c=relaxed/simple;
	bh=U+/ZCHWp5n62zUJkVh2GWyCWLWNte4kdeatyl1hYiuQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=A73mgr79DyYqpapU6SvLAzop02VxEmo9KG/WHBMNpk3cf+KPxV89cYwxx3+mMyLQM6teoL7qob0rY3Y+JsRVhJ5OtLZbbHK7w3601luCOYHX6c4EPQg7u0BXzpYDQlqrQdjMshrp4T6kr0h6wLmNjv9X3HqRqdqdDJNmX63AH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xiKysYkG; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758783368; h=Message-ID:Subject:Date:From:To;
	bh=HwMHqrDTzWXAsTudfeETOLyQXa2iP2EbNwTyicCtxAo=;
	b=xiKysYkGMhPmaWog8jO3sDBRSQoPyrqdCyX09nRlDHcCl/jsWvfOjMDmrSSnyu0n6NwO0rV0kUx6S5VSafRa71Jh2l1uQ6DqOMrENZ+4u5F2hM++ZpyHDpXQKy5zXNVEFyAZVB1RNCbclJxvZEDtX53KsSLD8ONLGv0X55yBeVE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WomiAeB_1758783366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 14:56:06 +0800
Message-ID: <1758783354.8636878-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 25 Sep 2025 14:55:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <8b70630c-163b-474b-8322-d72ea8de8778@lunn.ch>
In-Reply-To: <8b70630c-163b-474b-8322-d72ea8de8778@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 19 Sep 2025 18:35:51 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > +static int eea_set_ringparam(struct net_device *netdev,
> > +			     struct ethtool_ringparam *ring,
> > +			     struct kernel_ethtool_ringparam *kernel_ring,
> > +			     struct netlink_ext_ack *extack)
> > +{
> > +	struct eea_net *enet = netdev_priv(netdev);
> > +	struct eea_net_tmp tmp = {};
> > +	bool need_update = false;
> > +	struct eea_net_cfg *cfg;
> > +	bool sh;
> > +
> > +	enet_mk_tmp_cfg(enet, &tmp);
> > +
> > +	cfg = &tmp.cfg;
> > +
> > +	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> > +		return -EINVAL;
>
> You have extack, so you can give a useful error message, in addition
> to EINVAL. set ringparam has soo many parameters it is hard to user
> space to know which values can be set. So seeing "rx_mini_pending not
> supported" is a big help.
>
> 	Andrew


YES. I see.

Thanks.
>

