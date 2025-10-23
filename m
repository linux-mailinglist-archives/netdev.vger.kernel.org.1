Return-Path: <netdev+bounces-232131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC103C01A00
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7835670E5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAE315D57;
	Thu, 23 Oct 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMoxSCz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69475314B6B
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227719; cv=none; b=bVwrJtrT6c01l9Bi6rJEcEgmZussLu8sajBbv+fx8PPQOb3Ewepj8kBIXu1xbSNvnnS7RLHVTBhx5LC20ICbs0qDT+qpRibHP2xr28Xk2pWpejZG+5EX3dcCA0SCNHqIphRoIbhqmk7wrkTFiCcJ8o37nWQJTcFKVS2s/koKduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227719; c=relaxed/simple;
	bh=8+PYyTyomYrzalK2WJlYKw9EVkV1usHo2Fw16pjCGe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBWRfdmZJrwdK/rV7tx7HwEg6WVZMFgEP7M9xkYUSzXpz6dCRKYu+NykUIPH7IGJR5NGVAgzVSmAzBBfarihCca91Q0jJHgcWnDx+S+DI6xnyfgq7KMLF5k/vwBOEcq11CH2x+xZVbch1lzUGysNvkcilrPLN/u4xYb0eI4wKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMoxSCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE80C4CEE7;
	Thu, 23 Oct 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227719;
	bh=8+PYyTyomYrzalK2WJlYKw9EVkV1usHo2Fw16pjCGe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AqMoxSCza+A0XfaH7kMBvzjNAui1E8PIJYitbbFjCCnu4M4cnCUASAbUPVjW2T2+/
	 gUOqjoGZUaJk5YOKwkE8QTvnFY3zXLO+X1kUM3gIxLBXFdTKxscg/A6ZurqohNy3hp
	 +goY+m4yYc0yucjbASj0tCTytz3IvPp73sOparzjGjo+1bLzPwrQu3/BYC16NltsQs
	 Tvvhun6wjfArkw7wsbMuEk0Kytrmeqw39+l2EzMrTHkknbXwiDK27GUdEl0nqQewz3
	 VAxGVx/RbtGWBU26imuqbEVM8ZkznBgkiSyos7Xy0PKv4eu6ijWaz5O94VfkUT79ZK
	 As8Cu+fmXExWA==
Date: Thu, 23 Oct 2025 06:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Dr. David
 Alan Gilbert" <linux@treblig.org>, Dong Chenchen
 <dongchenchen2@huawei.com>, Oscar Maes <oscmaes92@gmail.com>
Subject: Re: [PATCH net] net: vlan: sync VLAN features with lower device
Message-ID: <20251023065517.2d3dfca0@kernel.org>
In-Reply-To: <38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>
References: <20251021095658.86478-1-liuhangbin@gmail.com>
	<38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 15:39:07 +0200 Paolo Abeni wrote:
> > @@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
> >  	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
> >  	grp->nr_vlan_devs++;
> >  
> > +	netdev_change_features(dev);  
> 
> Is this just for NETIF_F_LRO? it feels a bit overkill for single flag.
> Also, why netdev_change_features() (vs netdev_update_features())?

Another thought -- isn't this a problem for more uppers?
Isn't this what all callers of netdev_upper_dev_link() effectively
need, and therefore perhaps we should stick it somewhere in the core
(netdev_upper_dev_link() itself or when device is registered) ?

