Return-Path: <netdev+bounces-229848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD54BE155B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519EC19C542A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A515D5B6;
	Thu, 16 Oct 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cJETBmPd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A843BB48
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584406; cv=none; b=L6ZwBF/PkstgBZUbI4XHtMr9GKqH50jzTo2lkq5O4Xwn5v4CcrXeNz9LwsMhcYxQUG+PBy/Nqc07g/qSGssg0Sd9W/pRJqDVWRQaEZza2lPT3fpol0ps/U47zdSR/oFSCByB0lKASeHYotspuBHcJxcMmzvT3OPWLUEDoNHVH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584406; c=relaxed/simple;
	bh=ncfgQACZkZbkihJOWFdO9Llggeq1N/xxJCHjKzJEaOc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=lQvWjkgM9xLXcpybNfAd6E9JxpadfWCZndlJpN9SeIb9rEgwOYCRoXSn6FZa0ZtLYxrrYcIHw1drj0qDbyxZouVB3FHVBRLdYIsBDdrppfQ8AVO0lhlS8URfUkkS8PjL7XbeGPN4rUXmS/9HaChWmS/FqGKT6tLtRSCdoEWJ+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cJETBmPd; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760584401; h=Message-ID:Subject:Date:From:To;
	bh=7PAh1QvdjIjMe6LCUSzLDPsLb937RcqR31PsLzCiTcY=;
	b=cJETBmPdwBwcFUCe62d+euipa3S0I1cE5rSIbaJZsSKRB8xs4w3vYxDQMWkNN0blzRPf61+aqopd3pL30Zu7X4bUQZyG4vLqe+LqOWR2r4bR8nOMyf2kqWJNo9sgXhDn5usa/kmXmhlX2LdVEtbM7HOHaPiCrJSL+RSzaOKMiW4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqIanIO_1760584399 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 11:13:19 +0800
Message-ID: <1760584372.6252325-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 5/5] eea: introduce ethtool support
Date: Thu, 16 Oct 2025 11:12:52 +0800
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
References: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
 <20251015071145.63774-6-xuanzhuo@linux.alibaba.com>
 <90bddd14-3902-4c19-a134-3c0ea7a66fec@lunn.ch>
In-Reply-To: <90bddd14-3902-4c19-a134-3c0ea7a66fec@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 15 Oct 2025 21:58:07 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > @@ -111,6 +116,8 @@ struct eea_net_cfg {
> >  	u8 tx_cq_desc_size;
> >
> >  	u32 split_hdr;
> > +
> > +	struct hwtstamp_config ts_cfg;
> >  };
> >
>
> > @@ -391,6 +397,10 @@ static void eea_submit_skb(struct eea_net_rx *rx, struct sk_buff *skb,
> >  	if (rx->pkt.data_valid)
> >  		skb->ip_summed = CHECKSUM_UNNECESSARY;
> >
> > +	if (enet->cfg.ts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
> > +		skb_hwtstamps(skb)->hwtstamp = EEA_DESC_TS(desc) +
> > +			enet->hw_ts_offset;
> > +
>
> These two hunks are nothing to do with ethtool.
>
> Otherwise this code looks O.K. to me.

Will move to other commit.

Thanks


>
> 	Andrew

