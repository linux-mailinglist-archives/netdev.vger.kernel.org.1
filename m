Return-Path: <netdev+bounces-104681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC090E01E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B428796C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B322185E65;
	Tue, 18 Jun 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3cNtTBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A7185E61
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754189; cv=none; b=FqT8PO6ebOyRbyL6wAFG0OHdDE8oFVtnf0po14zLA8mOZm5PU6rrZCOWehrUAxEmApGrJQgMtRGdXDlB31qzEU+EqUS6caXLfCWp1rMcKqqsBqxbPKGd/8ei+AVssO45Oyr/Jm/P7Dxwt5by3aHTBsc9kIsJnEorGBMnIh15A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754189; c=relaxed/simple;
	bh=ToacKlaqUD6Ce52MXXInyaprZ3JQgxfTCZFwJlnSG+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfauT0R6VW5MdGbCrEaGgY5jc3x8WXrYHVSMAmyRpFMGbtWNjefRZMtc1X2mzrmmygmGPcOjDZfC0rQMTVjrpMuVYLkVtGv8+PLUYVR4K9ZTUfbSbKx7rWoWCWdE8zQr9BW2gdHwEcpCoJSXt1U/g6zN79J97vvuoX5g9o4UuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3cNtTBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0795BC3277B;
	Tue, 18 Jun 2024 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718754189;
	bh=ToacKlaqUD6Ce52MXXInyaprZ3JQgxfTCZFwJlnSG+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3cNtTBEwz3RMF4HJLb+YyhkeL8astxsLQ1qvrTayCQIPAUhTZVEYVNNIq2rIuXnf
	 oc8y44kwyqwdWA6lpHor1lhCWUVf1RuCceqezvsD/sgaEFFByxVYQQy49tboqnsuiC
	 5RHK+2v3+uCKdTvdkK0Ga+thwpVgCM/yy785jleg/I948Oeu/F201Z3seLYh9yLZ1q
	 2GQkF3ZNq/xnkdWYzB69IklvCGRIVyBtHJROxPWo/VdZcFcE9zAIpIEMPH843z95gQ
	 y07Adki0A5jtuo76jFGxGai6Gzyeb/k3rrHjqoo3X/QphLOrU0h5n/9nSSpuJxTDV+
	 VSKvp1qTXwORg==
Date: Tue, 18 Jun 2024 16:43:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.com,
 edumazet@google.com, pabeni@redhat.com, Edward Cree
 <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
 leon@kernel.org, jacob.e.keller@intel.com, andrew@lunn.ch,
 ahmed.zaki@intel.com
Subject: Re: [PATCH v5 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Message-ID: <20240618164307.7138ce89@kernel.org>
In-Reply-To: <070a3de4-d502-45f9-913f-5392e0ebee45@davidwei.uk>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
	<03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
	<070a3de4-d502-45f9-913f-5392e0ebee45@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 16:05:13 -0700 David Wei wrote:
> > @@ -11065,6 +11065,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  	dev->real_num_rx_queues = rxqs;
> >  	if (netif_alloc_rx_queues(dev))
> >  		goto free_all;
> > +	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);  
> 
> Why GFP_KERNEL_ACCOUNT instead of just GFP_KERNEL?

netdevs can be created by a user, think veth getting created in 
a container. So we need to account the allocated memory towards 
the memory limit of the current user.

> > +	if (!dev->ethtool)
> > +		goto free_all;
> >  
> >  	strcpy(dev->name, name);
> >  	dev->name_assign_type = name_assign_type;
> > @@ -11115,6 +11118,7 @@ void free_netdev(struct net_device *dev)
> >  		return;
> >  	}
> >  
> > +	kfree(dev->ethtool);  
> 
> dev->ethtool = NULL?

defensive programming is sometimes permitted by not encouraged :)

