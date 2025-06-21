Return-Path: <netdev+bounces-200011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFDAE2B8A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C216F51C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF291E2606;
	Sat, 21 Jun 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii0+CgVb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BEB1B808;
	Sat, 21 Jun 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534527; cv=none; b=tIx+mNLzXfpf69nxPBEcgCGx+4kLNH+Z3nGr2NeKSWtzfpHasdLjeoUD+jyuAJ9raHcIXr7Wmd8bykk2Awsr29yi5LZGPCerROH6fY5I+15giAMcV5ZKRZoRO6jbcLusyr8/3YvFetVGmTLngyQkBXXn1hyWSiY8cVyPR4ZDEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534527; c=relaxed/simple;
	bh=iRkCqVQGrH7VlO+9U6q1MVEncu/VK7gTCzhyUJEx2FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gqRzfb6G4FuYeNr5DZE2CBBR285LLAjQtP77l3D0rpr2u/qBjvvzMtt+BKFzml4v4ut9I7U3o3b/P7WMflNlS41J5+I6now/XgNYlIHf965Vz1RnEgZ6uM7AOaIT667jWlE5OxmQXD2fE298aAAhxC4VoFMHeG5Hfgj2DdcNz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii0+CgVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9251C4CEE7;
	Sat, 21 Jun 2025 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750534527;
	bh=iRkCqVQGrH7VlO+9U6q1MVEncu/VK7gTCzhyUJEx2FY=;
	h=From:To:Cc:Subject:Date:From;
	b=Ii0+CgVbPT3fYC1KmGf/kH6CdtpLZJRxYnookgmuYuk3hcVkCOwXfpAkZciFhDzYq
	 f2qBaiedTaUwSog0/EC8sfCZTdhWPK+Ui9/ACDmbnF3QZhNyuOoC2fcxXGMnqXIOEW
	 xOqflyFhuPI3ipUIrzX1D8Xl4MDe5RdIuSDf+hLk/2BOqbvwPfgCwHOAOYZ7f0kSls
	 zlWYEktQaboMk3WV2V4LFZdeXSs+CxcBHbd4cToPJqda2ozJMOh2PS9OtHj839RlTc
	 qQ+mV+efexs9ikpm8NPtLjcAJyOPXDqRU3MGF/HCrYi+bVFAaxamKOUPHv5vRrGK7P
	 FfZ9zEZ2CRRnQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] myri10ge: avoid uninitialized variable use
Date: Sat, 21 Jun 2025 21:35:11 +0200
Message-Id: <20250621193520.620419-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While compile testing on less common architectures, I noticed that gcc-10 on
s390 finds a bug that all other configurations seem to miss:

drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_set_multicast_list':
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:25: error: 'cmd.data0' is used uninitialized in this function [-Werror=uninitialized]
  391 |  buf->data0 = htonl(data->data0);
      |                         ^~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:25: error: '*((void *)&cmd+4)' is used uninitialized in this function [-Werror=uninitialized]
  392 |  buf->data1 = htonl(data->data1);
      |                         ^~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_allocate_rings':
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:13: error: 'cmd.data1' is used uninitialized in this function [-Werror=uninitialized]
  392 |  buf->data1 = htonl(data->data1);
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data1' was declared here
 1939 |  struct myri10ge_cmd cmd;
      |                      ^~~
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:393:13: error: 'cmd.data2' is used uninitialized in this function [-Werror=uninitialized]
  393 |  buf->data2 = htonl(data->data2);
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data2' was declared here
 1939 |  struct myri10ge_cmd cmd;

It would be nice to understand how to make other compilers catch this as
well, but for the moment I'll just shut up the warning by fixing the
undefined behavior in this driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: initialize two more instances of these [Simon Horman]
---
 .../net/ethernet/myricom/myri10ge/myri10ge.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index e611ff7fa3fa..4743064bc6d4 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -688,6 +688,9 @@ static int myri10ge_get_firmware_capabilities(struct myri10ge_priv *mgp)
 
 	/* probe for IPv6 TSO support */
 	mgp->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO;
+	cmd.data0 = 0,
+	cmd.data1 = 0,
+	cmd.data2 = 0,
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_MAX_TSO6_HDR_SIZE,
 				   &cmd, 0);
 	if (status == 0) {
@@ -806,6 +809,7 @@ static int myri10ge_update_mac_address(struct myri10ge_priv *mgp,
 		     | (addr[2] << 8) | addr[3]);
 
 	cmd.data1 = ((addr[4] << 8) | (addr[5]));
+	cmd.data2 = 0;
 
 	status = myri10ge_send_cmd(mgp, MXGEFW_SET_MAC_ADDRESS, &cmd, 0);
 	return status;
@@ -817,6 +821,9 @@ static int myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
 	int status, ctl;
 
 	ctl = pause ? MXGEFW_ENABLE_FLOW_CONTROL : MXGEFW_DISABLE_FLOW_CONTROL;
+	cmd.data0 = 0,
+	cmd.data1 = 0,
+	cmd.data2 = 0,
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, 0);
 
 	if (status) {
@@ -834,6 +841,9 @@ myri10ge_change_promisc(struct myri10ge_priv *mgp, int promisc, int atomic)
 	int status, ctl;
 
 	ctl = promisc ? MXGEFW_ENABLE_PROMISC : MXGEFW_DISABLE_PROMISC;
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, atomic);
 	if (status)
 		netdev_err(mgp->dev, "Failed to set promisc mode\n");
@@ -1946,6 +1956,8 @@ static int myri10ge_allocate_rings(struct myri10ge_slice_state *ss)
 	/* get ring sizes */
 	slice = ss - mgp->ss;
 	cmd.data0 = slice;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_RING_SIZE, &cmd, 0);
 	tx_ring_size = cmd.data0;
 	cmd.data0 = slice;
@@ -2238,6 +2250,8 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
 	status = 0;
 	if (slice == 0 || (mgp->dev->real_num_tx_queues > 1)) {
 		cmd.data0 = slice;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET,
 					   &cmd, 0);
 		ss->tx.lanai = (struct mcp_kreq_ether_send __iomem *)
@@ -2312,6 +2326,7 @@ static int myri10ge_open(struct net_device *dev)
 	if (mgp->num_slices > 1) {
 		cmd.data0 = mgp->num_slices;
 		cmd.data1 = MXGEFW_SLICE_INTR_MODE_ONE_PER_SLICE;
+		cmd.data2 = 0;
 		if (mgp->dev->real_num_tx_queues > 1)
 			cmd.data1 |= MXGEFW_SLICE_ENABLE_MULTIPLE_TX_QUEUES;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_ENABLE_RSS_QUEUES,
@@ -2414,6 +2429,8 @@ static int myri10ge_open(struct net_device *dev)
 
 	/* now give firmware buffers sizes, and MTU */
 	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_SET_MTU, &cmd, 0);
 	cmd.data0 = mgp->small_bytes;
 	status |=
@@ -2956,6 +2973,9 @@ static void myri10ge_set_multicast_list(struct net_device *dev)
 
 	/* Disable multicast filtering */
 
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	err = myri10ge_send_cmd(mgp, MXGEFW_ENABLE_ALLMULTI, &cmd, 1);
 	if (err != 0) {
 		netdev_err(dev, "Failed MXGEFW_ENABLE_ALLMULTI, error status: %d\n",
-- 
2.39.5


