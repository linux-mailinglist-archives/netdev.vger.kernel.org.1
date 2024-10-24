Return-Path: <netdev+bounces-138603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E29AE464
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA02284A61
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23871CFEB5;
	Thu, 24 Oct 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jJlzbckt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E01C9B87;
	Thu, 24 Oct 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771679; cv=none; b=sr4nYYbP/Jta9dh4SHui5bT1SQZy/55QxKLQxh/PhWtOd3sQ0elIALJItiDxGXrE+foK6odxROvWInbOpWkxWFelW0p1cJZWup3d2slsQyWKGxC91Uw2t9jtQc/MqXaQgr021yiR1JnVyakOzsRvpWmpMjOhzkvPdV1c7Z8RsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771679; c=relaxed/simple;
	bh=2liUM+daEVqPWfAhbiF3b+JHcFPZnfcPbTQRyHQw5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWfGQs9Por3lqt5nY0rCsj8COPOl58ycijFFAiii8NwfSVyl+GHK5OYrAXs48By0Z2VHPdBQvfHeyx8qYm0GBgkrIby91xNLmqiaYsjOjSuEghWCpQ/iXrl+y3r/fWvSuOD9w+A8iP3EOnzPJQxlD7NnXyR60SXu03/a/thWmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jJlzbckt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=khAU0tBvQcyaqWQJymbOt4CLU7L03Denc6s7WLTJrmQ=; b=jJ
	lzbcktxQCkWNYX+aXL2KHt2Kcl1u1gyGoVypaL7/wXOWI16FKDYG+0PbRzHQ4ZPdP7EruyoEJHc6O
	jlwfDmQnyZw+/Bedm7IfOvXpYQAHODaSZ0SRi8VsfpIlG7hSS+z0CyXfDBmby2fcbVWNeix3Xk9PC
	7+Hqe0hMhy464c0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3wd1-00B6zz-SB; Thu, 24 Oct 2024 14:07:47 +0200
Date: Thu, 24 Oct 2024 14:07:47 +0200
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
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add unicast frame filter
 supported in this module
Message-ID: <a7f38f53-848f-42c5-ad20-a453474a835a@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-4-shaojijie@huawei.com>
 <d66c277b-ea1c-4c33-ab2e-8bd1a0400543@lunn.ch>
 <c4d40afe-b48a-43da-be88-f7ee38dd720c@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4d40afe-b48a-43da-be88-f7ee38dd720c@huawei.com>

On Thu, Oct 24, 2024 at 11:09:22AM +0800, Jijie Shao wrote:
> 
> on 2024/10/23 22:05, Andrew Lunn wrote:
> > > +static int hbg_add_mac_to_filter(struct hbg_priv *priv, const u8 *addr)
> > > +{
> > > +	u32 index;
> > > +
> > > +	/* already exists */
> > > +	if (!hbg_get_index_from_mac_table(priv, addr, &index))
> > > +		return 0;
> > > +
> > > +	for (index = 0; index < priv->filter.table_max_len; index++)
> > > +		if (is_zero_ether_addr(priv->filter.mac_table[index].addr)) {
> > > +			hbg_set_mac_to_mac_table(priv, index, addr);
> > > +			return 0;
> > > +		}
> > > +
> > > +	if (!priv->filter.table_overflow) {
> > > +		priv->filter.table_overflow = true;
> > > +		hbg_update_promisc_mode(priv->netdev);
> > > +		dev_info(&priv->pdev->dev, "mac table is overflow\n");
> > > +	}
> > > +
> > > +	return -ENOSPC;
> > I _think_ this is wrong. If you run out of hardware resources, you
> > should change the interface to promiscuous mode and let the stack do
> > the filtering. Offloading it to hardware is just an acceleration,
> > nothing more.
> > 
> > 	Andrew
> 
> In hbg_update_promisc_mode():
> priv->filter.enabled = !(priv->filter.table_overflow || (netdev->flags & IFF_PROMISC));
> hbg_hw_set_mac_filter_enable(priv, priv->filter.enabled);
> 
> if table_overflow， and netdev->flags not set IFF_PROMISC，
> the priv->filter.enabled will set to false， Then， The MAC filter will be closed.
> I think it's probably the same thing you said
> 
> In this:
> +	if (!priv->filter.table_overflow) {
> +		priv->filter.table_overflow = true;
> +		hbg_update_promisc_mode(priv->netdev);
> +		dev_info(&priv->pdev->dev, "mac table is overflow\n");
> +	}
> +
> +	return -ENOSPC;
> 
> When the first overflow occurs, a log is printed, the MAC filter will be disabled, and -ENOSPC is returned.
> If continue to add MAC addresses, -ENOSPC is returned only.

This is not obvious from a quick look at the code. Maybe a comment
would be good.

	Andrew

