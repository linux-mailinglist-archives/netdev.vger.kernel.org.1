Return-Path: <netdev+bounces-154864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBBA00279
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF0162C06
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1EC2E822;
	Fri,  3 Jan 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVIKwj9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4581E502
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735868642; cv=none; b=TEFWevXyHaZRhijUYYJMo/L9H/VwqbHXZSjxE8nvfGUsS2EnwXEYu7q7jVxe+U02XxG1xxBHS32Ouw//ah08b8St3gFHk0YoXj8xKUzG+krYy1HlgMaKPycxSY6+ONCUUeD0Vz4GS/j/fpNqxdq0J+B0XbIBwN671d6+rTDixaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735868642; c=relaxed/simple;
	bh=D0APo6ioKOnN59w3CrrNK9EQUesESiW1aaVdojusO24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1kSyobuAVh7oS2o8vTK3KuTvo7lEDcTr+fNsIrSd85/NvsIsziu8drnqp7pRbCRRLoydJhgvqrMfiFEdfUaarQYlHn4w+FXX1SmBob/ve0IZ6dKdnlkcEUX+xawSm9PE9SztaF5dE5E/uL5Tiz+dwFOxMy1fYPNSp3+++5TWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVIKwj9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A996DC4CED0;
	Fri,  3 Jan 2025 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735868642;
	bh=D0APo6ioKOnN59w3CrrNK9EQUesESiW1aaVdojusO24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uVIKwj9Km1V4MmCp6EykLTloJp+OL/Eyn4oKRqpjt8aX7jO1TgLqmKKvPZbnOg9XM
	 X0mFmQKaiGd8rak4nThKkMTmmoomezH/WWVo9larykTu1Bjawl9l+exJ82hfVYDdpc
	 IwlnooX7iPioQlQAPmBd2KWK24laYiTn7Kr/Cy5Dq2BSEFPynghc/w7/WBg6VREB78
	 Vg9h5Bjpoz2XPbYhLYlLtOLLPaAnvS8u2W0Qn0CrecerrGc+fHl2exNFXiZitQnZB+
	 dpa/OuDXkxsjkgcn5i394GvfDk/WO2DWp3X+YbmqKWt3KeByt8FS4cpNsVz3gOzU4q
	 pelpDAzXWS7OA==
Date: Thu, 2 Jan 2025 17:44:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Mahesh Bandewar
 <maheshb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net] ipvlan: Fix use-after-free in
 ipvlan_get_iflink().
Message-ID: <20250102174400.085fd8ac@kernel.org>
In-Reply-To: <20250101091008.27533-1-kuniyu@amazon.com>
References: <20250101091008.27533-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jan 2025 18:10:08 +0900 Kuniyuki Iwashima wrote:
> syzbot presented a use-after-free report [0] regarding ipvlan and
> linkwatch.
> 
> ipvlan does not hold a refcnt of the lower device.
> 
> When the linkwatch work is triggered for the ipvlan dev, the lower
> dev might have already been freed.
> 
> Let's hold the lower dev's refcnt in dev->netdev_ops->ndo_init()
> and release it in dev->priv_destructor() as done for vlan and macvlan.

Hmmm, random ndo calls after unregister_netdevice() has returned 
are very error prone, if we can address this in the core - I think
that's better.

Perhaps we could take Eric's commit 750e51603395 ("net: avoid potential
UAF in default_operstate()") even further?

If the device is unregistering we can just assume DOWN. And we can use
RCU protection to make sure the unregistration doesn't race with us?
Just to give the idea (not even compile tested):

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 1b4d39e38084..985273bc7c0d 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -42,14 +42,20 @@ static unsigned int default_operstate(const struct net_device *dev)
 	 * first check whether lower is indeed the source of its down state.
 	 */
 	if (!netif_carrier_ok(dev)) {
-		int iflink = dev_get_iflink(dev);
 		struct net_device *peer;
+		int iflink;
 
 		/* If called from netdev_run_todo()/linkwatch_sync_dev(),
 		 * dev_net(dev) can be already freed, and RTNL is not held.
 		 */
-		if (dev->reg_state == NETREG_UNREGISTERED ||
-		    iflink == dev->ifindex)
+		rcu_read_lock();
+		if (dev->reg_state <= NETREG_REGISTERED)
+			iflink = dev_get_iflink(dev);
+		else
+			iflink = dev->ifindex;
+		rcu_read_unlock();
+
+		if (iflink == dev->ifindex)
 			return IF_OPER_DOWN;
 
 		ASSERT_RTNL();

