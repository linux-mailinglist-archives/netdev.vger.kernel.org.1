Return-Path: <netdev+bounces-184054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEB6A92FE0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C515464145
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF782673BD;
	Fri, 18 Apr 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiG/ielD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55C21930B
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942782; cv=none; b=eqbWJjNKxzc//8y844aPeRapHb8u7yn56KADcx5ChwzPj1HAZ8pADqO5JtBBrPV26f83il7B5utgUIILxZp+VpLhNWuLnL6lV5tqQ7TYikEvoaq6BZ+9HpTuchv4vjKpfZzfAH8wthh8oErsfm9o44wiwcAlcaiX1g4IhcrpuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942782; c=relaxed/simple;
	bh=txDyh8MtPv1ophJMkXAfogbeTcEPpSTYlg9rHAD/CI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVTXC094C7VLVU53bNy8WmvqG191q9VP35P+8Jqnyqh+X54c4+rrq2IzCA0NaqZ6pZBjnxRY7IkIWfS51LS/GVM1gVQl7S17ooZFQhQLoQHM/uYssvCB8ejoBgR//iw8/QAs43p3iHvSFXp1JOzPopeU948Zv0qRRD043tl1Vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiG/ielD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6984C4CEE4;
	Fri, 18 Apr 2025 02:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942781;
	bh=txDyh8MtPv1ophJMkXAfogbeTcEPpSTYlg9rHAD/CI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SiG/ielD4htcULb70ZZn0RCFBNzzZw1dpKxpzh6TeOY2puPNlQ1k/i9l0dmk6qMdE
	 7TnuMWwkzMV9EhYJWbry0T/qW5YJn2FwKka2c8FAMJYlzgiQ+l7QYFpmxqJzpKvRC7
	 v0flMuQmGZYZP3pwmmABchO7HD9HjkQRtC/MqM8Dw5jd8M/c3TKdW6arQZ/d1kIYmg
	 TJNxZTB+zs9oGTK3NynxuGFCAJ4HoE1IU76U0BvabceDKfX5TtqdhMOvWqruebXhuv
	 WEy9BpODfKS2nJFx65RAdIvHIXUnwGUkUqc+qepfp3j6YVrY1ufuRX8zugnH9Wn0+t
	 Qxs7teDhjHXKQ==
Date: Thu, 17 Apr 2025 19:19:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <dlemoal@kernel.org>, <jdamato@fastly.com>,
 <saikrishnag@marvell.com>, <vadim.fedorenko@linux.dev>,
 <przemyslaw.kitszel@intel.com>, <ecree.xilinx@gmail.com>,
 <rmk+kernel@armlinux.org.uk>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 1/2] net: txgbe: Support to set UDP tunnel
 port
Message-ID: <20250417191939.1c4c2dde@kernel.org>
In-Reply-To: <01fb01dbb003$5b920bd0$12b62370$@trustnetic.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>
	<20250417080328.426554-2-jiawenwu@trustnetic.com>
	<20250417165736.15d212ec@kernel.org>
	<01fb01dbb003$5b920bd0$12b62370$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 09:44:00 +0800 Jiawen Wu wrote:
> On Fri, Apr 18, 2025 7:58 AM, Jakub Kicinski wrote:
> > On Thu, 17 Apr 2025 16:03:27 +0800 Jiawen Wu wrote:  
> > > @@ -392,6 +393,8 @@ static int txgbe_open(struct net_device *netdev)  
> >                                  ^^^^^^^^^^  
> > >
> > >  	txgbe_up_complete(wx);
> > >
> > > +	udp_tunnel_nic_reset_ntf(netdev);  
> >         ^^^^^^^^^^^^^^^^^^^^^^^^  
> > >  	return 0;  
> >   
> > > +	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,  
> > 
> > Documentation says:
> > 
> >         /* Device only supports offloads when it's open, all ports
> >          * will be removed before close and re-added after open.
> >          */
> >         UDP_TUNNEL_NIC_INFO_OPEN_ONLY   = BIT(1),
> > 
> > Are you sure you have to explicitly reset?  
> 
> Yes. Stop device will reset hardware, which reset UDP port to the default value.
> So it has to re-configure the ports.

My point is that this is basically what the
UDP_TUNNEL_NIC_INFO_OPEN_ONLY flag already assumes.
There should be no need to reset if you already told the core 
with the flag that the device forgets everything when closed.

Could you retest without the reset_ntf ?

