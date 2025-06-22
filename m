Return-Path: <netdev+bounces-200075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09FAE30C3
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADDE1681C6
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682361D63EE;
	Sun, 22 Jun 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqYsQ41I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A07263C;
	Sun, 22 Jun 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750609640; cv=none; b=fKNCnsIEj4iegX3G2D683WZBttao2cIeqwVUoWQEe+rsJB66Av9WNPnp1CMTxQYRcngZBpx4dvQGhZQafbZRaM+390gQ6ihd0/FI53Lxz1tApawAI/x5u1gLVAwT1qF8Ig86i35KY9sAFHfddVJSz9QVlZFoOP4Ni7wBO5luNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750609640; c=relaxed/simple;
	bh=cJSpp4loBWRA+XVexUn88O5z1jukld2Np4QMGXcGWgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT3qC/+npQuUaVt2GzRLw6xOMYax3i/eIhb5wWpFiqJwKKbm++aNU85rUCVz/Gkiq5230o0Ajg3XUmLpMtUbNp4q+cRelpThYvi4hwaA+HTKjnmktspkCjJCuGw6TNCNucQLhhCy1q0tRqKBqo1fj+oIBBujGrg5QUmPgJaWSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqYsQ41I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6D1C4CEE3;
	Sun, 22 Jun 2025 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750609639;
	bh=cJSpp4loBWRA+XVexUn88O5z1jukld2Np4QMGXcGWgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqYsQ41ItgezNhmqiTsdxCtKCuGdLyZin7BS8P43DPGH3/n8aaG/+yv3eizc/IrkD
	 RVYMF4IjNV5Ibk3amqEVJmr3T8Aj78jWlvrPBoQvAnhABbBoc4GopjiXe/uEV0hWZg
	 BmGg9LbER68Me2ff6cLjv4uSU6qxHmed57breoIGAj2zULrAVmApWTosGk12WGsA/9
	 rimVskjNLC/SgvjXe7k7/W8LpvY+mFExXiGYchtUj+FBEeTs5/ZvJkBrMIViFNcQcn
	 ykoYp/q3tiSN2YPGnjrZNeuVj3QEQBTe7CuSJvWKGr8WYTmkyynY22CVyGfbHs9iYe
	 WGqwbiUgEBTMQ==
Date: Sun, 22 Jun 2025 17:27:15 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] myri10ge: avoid uninitialized variable use
Message-ID: <20250622162715.GA297140@horms.kernel.org>
References: <20250621193520.620419-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621193520.620419-1-arnd@kernel.org>

On Sat, Jun 21, 2025 at 09:35:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While compile testing on less common architectures, I noticed that gcc-10 on
> s390 finds a bug that all other configurations seem to miss:
> 
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_set_multicast_list':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:25: error: 'cmd.data0' is used uninitialized in this function [-Werror=uninitialized]
>   391 |  buf->data0 = htonl(data->data0);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:25: error: '*((void *)&cmd+4)' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_allocate_rings':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:13: error: 'cmd.data1' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data1' was declared here
>  1939 |  struct myri10ge_cmd cmd;
>       |                      ^~~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:393:13: error: 'cmd.data2' is used uninitialized in this function [-Werror=uninitialized]
>   393 |  buf->data2 = htonl(data->data2);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data2' was declared here
>  1939 |  struct myri10ge_cmd cmd;
> 
> It would be nice to understand how to make other compilers catch this as
> well, but for the moment I'll just shut up the warning by fixing the
> undefined behavior in this driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: initialize two more instances of these [Simon Horman]

Sorry, but looking at this again I found a few more.

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 4743064bc6d4..feda51e23958 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -2258,6 +2258,8 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
 		    (mgp->sram + cmd.data0);
 	}
 	cmd.data0 = slice;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SMALL_RX_OFFSET,
 				    &cmd, 0);
 	ss->rx_small.lanai = (struct mcp_kreq_ether_recv __iomem *)
@@ -2489,7 +2491,6 @@ static int myri10ge_open(struct net_device *dev)
 static int myri10ge_close(struct net_device *dev)
 {
 	struct myri10ge_priv *mgp = netdev_priv(dev);
-	struct myri10ge_cmd cmd;
 	int status, old_down_cnt;
 	int i;
 
@@ -2508,8 +2509,13 @@ static int myri10ge_close(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 	if (mgp->rebooted == 0) {
+		struct myri10ge_cmd cmd;
+
 		old_down_cnt = mgp->down_cnt;
 		mb();
+	        cmd.data0 = 0;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status =
 		    myri10ge_send_cmd(mgp, MXGEFW_CMD_ETHERNET_DOWN, &cmd, 0);
 		if (status)

Even with this, I'm sure there are cases
where stale values are passed in cases like this.
But that seems out of scope for this patch.

  /* setup cmd.data* */
  myri10ge_send_cmd(...);
  /* Something else */
  myri10ge_send_cmd(..);

