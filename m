Return-Path: <netdev+bounces-236592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1CC3E329
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D2F1885B87
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57D264A90;
	Fri,  7 Nov 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G0gsRTz0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4B257458
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481086; cv=none; b=mo9yArPKJ4k0nI2649OIFohHl1BZb6xGOkvuUXGPtHpd9mkVeGR3KqdVO9FDIPbo68PDAJCw6vlGkYbqfiGGJ/oCM9a3vxsLqmyCkUcLPklUsBWEF05a+KJtmMrFZborjYrXK8brCQ5FF3ZyOj/oo7ul/QuGVjjL01XTpUwMMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481086; c=relaxed/simple;
	bh=k37qfvGsSd7pNSGDv2WJq2C7fO3Rk9Lse6+5okMZ0pQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=o31jSVEp+XcstxJhSft+eIRNVC1TLSu9kFJrku8GyxgMFz0zGyTYv4VDI8jyXyexjYVPhlR+2PQqgF+TVUYRFHyhEIxkTNdsjW6Pk7o9KLPKEbMm1yOTAUhKWX2K9vQUNNn3D79OywR6oOjtIPtCJLh8qtVdjVI6myhcfDhqm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G0gsRTz0; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762481082; h=Message-ID:Subject:Date:From:To;
	bh=DPmx+xiWwmWAuKBt5ZtwPAfsmINGSNrffcKiJoEyX4U=;
	b=G0gsRTz0Z8jY9uYARtzjRZI1opckpIir6wNnorgkehOiKnZzEdo/M2flAUKWvHUUmZtGE4EgUzI90efhsHvv40RvUWRSH1Xgd+p/vgyr3tWmk0KRbaMlYG7xoJVQ/Xu9OLwxnghg3ShIhimB/tvydygYKLB+h119b9uQWvJdK5g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wrr03dQ_1762481080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 10:04:40 +0800
Message-ID: <1762481052.9107397-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 3/5] eea: probe the netdevice and create adminq
Date: Fri, 7 Nov 2025 10:04:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim  Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251105013419.10296-1-xuanzhuo@linux.alibaba.com>
 <20251105013419.10296-4-xuanzhuo@linux.alibaba.com>
 <20251106180111.1a71c2ea@kernel.org>
In-Reply-To: <20251106180111.1a71c2ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 6 Nov 2025 18:01:11 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed,  5 Nov 2025 09:34:17 +0800 Xuan Zhuo wrote:
> > +		if (rep->has_reply) {
> > +			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> > +			dev_warn(dev, "Device replied in host_info config: %s",
>
> nit: missing \n ?
>
> > +				 rep->reply_str);
> > +		}
> > +	}
> > +
> > +	kfree(rep);
> > +err_free_cfg:
> > +	kfree(cfg);
> > +	return rc;
> > +}
>
> > +static int eea_netdev_init_features(struct net_device *netdev,
> > +				    struct eea_net *enet,
> > +				    struct eea_device *edev)
> > +{
> > +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> > +	int err;
> > +	u32 mtu;
> > +
> > +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> > +	if (!cfg)
> > +		return -ENOMEM;
> > +
> > +	err = eea_adminq_query_cfg(enet, cfg);
> > +	if (err)
> > +		return err;
>
> AFAICT this is leaking cfg

cfg is freed by __free(kfree).

>
> > +	mtu = le16_to_cpu(cfg->mtu);
> > +	if (mtu < ETH_MIN_MTU) {
> > +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",
> > +			mtu, ETH_MIN_MTU);
> > +		return -EINVAL;
>
> and here? perhaps cfg is always leaked..
>
> > +void eea_net_remove(struct eea_device *edev)
> > +{
> > +	struct net_device *netdev;
> > +	struct eea_net *enet;
> > +
> > +	enet = edev->enet;
> > +	netdev = enet->netdev;
> > +
> > +	unregister_netdev(netdev);
> > +	netdev_dbg(enet->netdev, "eea removed.\n");
> > +
> > +	eea_device_reset(edev);
> > +
> > +	eea_destroy_adminq(enet);
>
> missing free_netdev(), looks transient but each patch must be correct..


Thanks.

> --
> pw-bot: cr

