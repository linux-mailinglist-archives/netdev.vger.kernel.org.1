Return-Path: <netdev+bounces-160813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396CDA1B964
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 16:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3233AC1E0
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977F21C19F;
	Fri, 24 Jan 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4idAGDl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384A156257
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732383; cv=none; b=roh8l6jaGTVPaUBEa2l7DZmihhLWVswnzvEsQTlffVTDF6Oy4tiS0QNF+hdXmcY/sZs0byEMUTD3c+DvrZBlpmzXsdaP8MGgaQKgCJLk755yLg07dgDM7V0IWTIF4pjmANRVMd0UvaVXfNpQTsMRGZar+P+NEMk1yJCPIzq5qOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732383; c=relaxed/simple;
	bh=2E0Odxry3OM829CXCuaWwU3Ugr0gD/fgpjkgJ3Svnc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npvo8K3WZNHl+6/mPI0a3h4noqmTmanCMH1VNAdf94uA19drnxVak5qaby2HgiJsRdLhQVjiEj8ALFO9i2ude0toQ5SlY9PyEd7W+vnBgRfIA6WtOWYa5r3LeeJD9D2Bjfw9o+FrmGtJlbbfkdAWAn++0rLkQCn6+lhVxfeVGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4idAGDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95EAC4CED2;
	Fri, 24 Jan 2025 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737732383;
	bh=2E0Odxry3OM829CXCuaWwU3Ugr0gD/fgpjkgJ3Svnc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4idAGDleMrV41iZ8uKNTDzvrZIOhlcYuiq81pnKn28RxzgJDz8UzX7rIKk6N6zD3
	 /BSX5LmbVk2qCXIk48UF+riujwa24XzZsp0+O686ybJcb60NNEzWWaxsPMLg/KfY99
	 PI/m756FVrOKNNd7AiqmHxkH7NKQnALetFCMfPawPg9fjqLwbxciVGl73w48U7mbfG
	 WAfVqsgRN2VqPegNTN2UdHfFCaKaooFDuTHJtXmcsPRAAayicjZ5l8UpZan0XMwbSm
	 og1u/dNc2FZyUaB5M6HefmemXCHjovrMr6aXTLBiSpFJKlFfJ1o5kcsFf2NEz+CuMP
	 sDc5g07vUB/9w==
Date: Fri, 24 Jan 2025 07:26:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <20250124072621.4ef8c763@kernel.org>
In-Reply-To: <Z5ME2-zHJq6arJC8@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
	<20250116215530.158886-11-saeed@kernel.org>
	<20250116152136.53f16ecb@kernel.org>
	<Z4maY9r3tuHVoqAM@x130>
	<20250116155450.46ba772a@kernel.org>
	<Z5LhKdNMO5CvAvZf@mini-arch>
	<20250123165553.66f9f839@kernel.org>
	<Z5ME2-zHJq6arJC8@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 19:11:23 -0800 Saeed Mahameed wrote:
> On 23 Jan 16:55, Jakub Kicinski wrote:
> >> IIUC, we want queue API to move away from rtnl and use only (new) netdev
> >> lock. Otherwise, removing this dependency in the future might be
> >> complicated.  
> >
> >Correct. We only have one driver now which reportedly works (gve).
> >Let's pull queues under optional netdev_lock protection.
> >Then we can use queue mgmt op support as a carrot for drivers
> >to convert / test the netdev_lock protection... "compliance".
> >
> >I added netdev_lock protection for NAPI before the merge window.
> >Queues are configured in much more ad-hoc fashion, so I think
> >the best way to make queue changes netdev_lock safe would be to
> >wrap all driver ops which are currently under rtnl_lock with
> >netdev_lock.  
> 
> Are you expecting drivers to hold netdev_lock internally? 
> I was thinking something more scalable, queue_mgmt API to take
> netdev_lock,  and any other place in the stack that can access 
> "netdev queue config" e.g ethtool/netlink/netdev_ops should grab 
> netdev_lock as well, this is better for the future when we want to 
> reduce rtnl usage in the stack to protect single netdev ops where
> netdev_lock will be sufficient, otherwise you will have to wait for ALL
> drivers to properly use netdev_lock internally to even start thinking of
> getting rid of rtnl from some parts of the core stack.

Agreed, expecting drivers to get the locking right internally is easier
short term but messy long term. I'm thinking opt-in for drivers to have
netdev_lock taken by the core. Probably around all ops which today hold
rtnl_lock, to keep the expectations simple.

net_shaper and queue_mgmt ops can require that drivers that support
them opt-in and these ops can hold just the netdev_lock, no rtnl_lock.

