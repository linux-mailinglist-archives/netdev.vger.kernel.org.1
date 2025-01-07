Return-Path: <netdev+bounces-156018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E27A04AB9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9202166BAC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BF18C01E;
	Tue,  7 Jan 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLbOQDGD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822928F6B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280710; cv=none; b=tHqjo1a5G/iphGFTWtcRctFP2FlaB3JXrfl6l0vZoCxDHQH7nJw5VaAmltPDZE7M0vSRLY2aJ/WpivuQ9EK6MzzPf0eSRyTKc9bBHxVG9DroQxlNTZ2fEI4aeqyHXy9K50kifXCew4YZ2mYmtZ2/2kG1px0YEeVD7w/acgeqJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280710; c=relaxed/simple;
	bh=YWHcM3Rk9LFzh86a/ibeKGPjZ7FEJwlz8wutbdGN4LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE4heIMgZ99D/Iumf8CiAgfqwZjW3AhwsHxI0BQKyxITmGS6Knp6kw4zk0TNl226viQ2YELu+74W/MGlV6HTcDctvBuMcHFXFGDw9v2Q+hxS5WdDim+tKYou9noDusNVpaQHkPLkOeSRhqe560BmUh2Ex6R4TYO2mbd+eQH0T18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLbOQDGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9698C4CED6;
	Tue,  7 Jan 2025 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736280710;
	bh=YWHcM3Rk9LFzh86a/ibeKGPjZ7FEJwlz8wutbdGN4LQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLbOQDGDt94ivvsKYq6IIMAbdAePsU6PhdsN7q+gLkr4z5ksoFWwDrsmwIFR9/ble
	 tNlb3KBR3FnBOZvrSYlfkWJS4IjuslhpEePbctxfvTl5GLYcsvUFnEwgxRU3BHmwsG
	 GsAbcwXkifQakostI+ry6RXJXMT3ni07RQxo4UCQFinQ+ZlW22gTKwcU3eQt+ZOOoU
	 N8ZeUIR3ctactpuD1WbqVdsWG3xt/d7c+p2joPF9z5qujcVJMQhotcaEfDvsvdwFMm
	 5WaR/FnC3J//RCdgnNycdfsmeSNwyyU3WugkohvYeWC/6bW7teF/P5rtWvyHwvLXg3
	 HrOgmjUKivBLg==
Date: Tue, 7 Jan 2025 12:11:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/4] net: reduce RTNL pressure in
 unregister_netdevice()
Message-ID: <20250107121148.7054518d@kernel.org>
In-Reply-To: <20250107173838.1130187-1-edumazet@google.com>
References: <20250107173838.1130187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 17:38:34 +0000 Eric Dumazet wrote:
> One major source of RTNL contention resides in unregister_netdevice()
> 
> Due to RCU protection of various network structures, and
> unregister_netdevice() being a synchronous function,
> it is calling potentially slow functions while holding RTNL.
> 
> I think we can release RTNL in two points, so that three
> slow functions are called while RTNL can be used
> by other threads.

I think we'll need:

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..cdfa22453a55 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1311,6 +1311,7 @@ int devlink_port_netdevice_event(struct notifier_block *nb,
 		__devlink_port_type_set(devlink_port, devlink_port->type,
 					netdev);
 		break;
+	case NETDEV_UNREGISTERING:
 	case NETDEV_UNREGISTER:
 		if (devlink_net(devlink) != dev_net(netdev))
 			return NOTIFY_OK;


There is no other way to speed things up? Use RT prio for the work?
Maybe WRITE_ONCE() a special handler into backlog.poll, and schedule it?

I'm not gonna stand in your way but in general re-taking caller locks
in a callee is a bit ugly :(

