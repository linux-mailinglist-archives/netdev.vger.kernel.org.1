Return-Path: <netdev+bounces-138602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3F9AE45E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E4E284AA6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2E1D1739;
	Thu, 24 Oct 2024 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3Px2/XXH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109C1C9B87;
	Thu, 24 Oct 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771533; cv=none; b=CM5svXgozRc7Zo0lchqxPfG15iKqVeJY6/UX3HgqzXTqwaw68m7JiWYo6gR91srkjeZGYwoO1CedCdV34R7xpqcBjW7GvZMwDTvg+V8SEAmvh8tXu7+Bzf5+JQmTnA94Zk2F8n0oQh79C8l0WfL9GFfFxv85nE1Lpsp5KZEBj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771533; c=relaxed/simple;
	bh=9SVCJQ83upO2goGKzzQ9J9+IbXeXTAAfxRt9cyiwzeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9GS5dCbL4xqMJFMGYPvOVfdzqDE03waW7Nl0dLTVT74jMTQT+GMlUXwzzBUU0jD4Unf7CWFGkguM0Hf/HjYcKEPtDwGPs7eu4P4YTZi6tQ/JPpNZGoCKUZKi2KoAg224RrmeooiQZawQKci0ElZ386hJZqZgfpKwAdNeJKu610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3Px2/XXH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IwIVZ8p2qGF8PkbBgA2FJd1tQpdeorZ0NIrV7KiBMvc=; b=3Px2/XXHi0kzVGoMhuNdfWBX2+
	O+mg7FvozBVmjDGPbCapft6ezR97pSUoyRfh7i0c7qDd00cbcwMCsEY8uEYAGhKrbj0ntJYIh4GTV
	UyTPBjturIe1ssLv13f++8Wn2MSNH+ydz3Hq/jrlMRkckKQncVpELVPsAZf3fzGt0V8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3waf-00B6xH-Ia; Thu, 24 Oct 2024 14:05:21 +0200
Date: Thu, 24 Oct 2024 14:05:21 +0200
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
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this
 module
Message-ID: <6103ee00-175d-4a35-9081-2c500ad3c123@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-3-shaojijie@huawei.com>
 <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
 <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>

> > > +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
> > Is this interesting? Are you clocking it greater than 2.5MHz?
> 
> MDIO controller supports 1MHz, 2.5MHz, 12.5MHz, and 25MHz
> Of course, we chose and tested 2.5M in actual work, but this can be modified.

How? What API are you using it allow it to be modified? Why cannot you
get the value using the same API?

> We requested three interrupts: "tx", "rx", "err"
> The err interrupt is a summary interrupt. We distinguish different errors
> based on the status register and mask.
> 
> With "cat /proc/interrupts | grep hibmcge",
> we can't distinguish the detailed cause of the error,
> so we added this file to debugfs.
> 
> the following effects are achieved:
> [root@localhost sjj]# cat /sys/kernel/debug/hibmcge/0000\:83\:00.1/irq_info
> RX                  : is enabled: true, print: false, count: 2
> TX                  : is enabled: true, print: false, count: 0
> MAC_MII_FIFO_ERR    : is enabled: false, print: true, count: 0
> MAC_PCS_RX_FIFO_ERR : is enabled: false, print: true, count: 0
> MAC_PCS_TX_FIFO_ERR : is enabled: false, print: true, count: 0
> MAC_APP_RX_FIFO_ERR : is enabled: false, print: true, count: 0
> MAC_APP_TX_FIFO_ERR : is enabled: false, print: true, count: 0
> SRAM_PARITY_ERR     : is enabled: true, print: true, count: 0
> TX_AHB_ERR          : is enabled: true, print: true, count: 0
> RX_BUF_AVL          : is enabled: true, print: false, count: 0
> REL_BUF_ERR         : is enabled: true, print: true, count: 0
> TXCFG_AVL           : is enabled: true, print: false, count: 0
> TX_DROP             : is enabled: true, print: false, count: 0
> RX_DROP             : is enabled: true, print: false, count: 0
> RX_AHB_ERR          : is enabled: true, print: true, count: 0
> MAC_FIFO_ERR        : is enabled: true, print: false, count: 0
> RBREQ_ERR           : is enabled: true, print: false, count: 0
> WE_ERR              : is enabled: true, print: false, count: 0
> 
> 
> The irq framework of hibmcge driver also includes tx/rx interrupts.
> Therefore, these interrupts are not distinguished separately in debugfs.

Please make this a patch of its own, and include this in the commit
message.

Ideally you need to show there is no standard API for what you want to
put into debugfs, because if there is a standard API, you don't need
debugfs...

> 
> > 
> > > +static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
> > > +{
> > > +	struct net_device *netdev = dev_get_drvdata(s->private);
> > > +	struct hbg_priv *priv = netdev_priv(netdev);
> > > +
> > > +	seq_printf(s, "event handling state: %s\n",
> > > +		   hbg_get_bool_str(test_bit(HBG_NIC_STATE_EVENT_HANDLING,
> > > +					     &priv->state)));
> > > +
> > > +	seq_printf(s, "tx timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
> > Don't you have this via ethtool -S ?
> 
> Although tx_timeout_cnt is a statistical item, it is not displayed in the ethtool -S.

Why?

	Andrew

