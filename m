Return-Path: <netdev+bounces-199740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A9AE19F4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DABD189F860
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B62836A6;
	Fri, 20 Jun 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxPlwCJP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6A78F4A;
	Fri, 20 Jun 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418798; cv=none; b=MyEqPnV98+epqXa3E9dtCzSym34f0nAxVlDwLYgaDL0vFGQZPijWuMy/piVimyeDqj/Ns+DXwjENubRPj3w3/U6Btkl/cnCInGhiZj57umph08UezZS1Nrv7XTDrSN8w/B8QD4LfkccSQhaWO8nstoApjRMQBE/wrhht6MKKoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418798; c=relaxed/simple;
	bh=iYJH96fpJ5ermvw67vAJtEXO+rloBv7/Iorm8b+Imvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tSgYbXaE2UVhjcvZGJy7CLRXHwg5hSO5cI+kMZO9evI/e4wd34Iiggp2RAlxfsJc9phkQ0HL7Wg8zcycyrsK+Yl2yfFLddP8hD93EWgvKf/Aev2IdSqn89cWnaKxJZhh/kPWgqZJLawuoYpdnCIBwADZJ6zPd2e/B47W6RWKnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxPlwCJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6AFC4CEE3;
	Fri, 20 Jun 2025 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418797;
	bh=iYJH96fpJ5ermvw67vAJtEXO+rloBv7/Iorm8b+Imvk=;
	h=From:To:Cc:Subject:Date:From;
	b=jxPlwCJPPBd+v35RONzc7sxOKTXEXiUkv0/ININzAKMGNXyO8O101aYuewy/xaQ8C
	 58qMf5AVqI7FFXK3T8nnUaI3Q0+GwtWSbbyxQq0hgcwjTfg/kTg3sQBTtT/jQk6/sk
	 rhP4dIKC9uVCZ/XAgnbKsT8lunu8noJujg1m+pRQXrPQhe3mq9qYlZMysKNQjkCKtC
	 czxxSNiTz8tAoSuprY61tDHrV9ZNwsheShSQjUUOqJc15XvW3GH29lrCgoI+LTwrVT
	 D9itVZfzW3oUzYxngRtaxB48wiwdSe8r6Ek31WUCbWhtZEJn5En4YdBcCZ9pCR5/Uv
	 NJLMF9grpjmBg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] myri10ge: avoid uninitialized variable use
Date: Fri, 20 Jun 2025 13:26:28 +0200
Message-Id: <20250620112633.3505634-1-arnd@kernel.org>
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
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index e611ff7fa3fa..f9d6ba381361 100644
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
@@ -834,6 +837,9 @@ myri10ge_change_promisc(struct myri10ge_priv *mgp, int promisc, int atomic)
 	int status, ctl;
 
 	ctl = promisc ? MXGEFW_ENABLE_PROMISC : MXGEFW_DISABLE_PROMISC;
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, atomic);
 	if (status)
 		netdev_err(mgp->dev, "Failed to set promisc mode\n");
@@ -1946,6 +1952,8 @@ static int myri10ge_allocate_rings(struct myri10ge_slice_state *ss)
 	/* get ring sizes */
 	slice = ss - mgp->ss;
 	cmd.data0 = slice;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_RING_SIZE, &cmd, 0);
 	tx_ring_size = cmd.data0;
 	cmd.data0 = slice;
@@ -2238,6 +2246,8 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
 	status = 0;
 	if (slice == 0 || (mgp->dev->real_num_tx_queues > 1)) {
 		cmd.data0 = slice;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET,
 					   &cmd, 0);
 		ss->tx.lanai = (struct mcp_kreq_ether_send __iomem *)
@@ -2312,6 +2322,7 @@ static int myri10ge_open(struct net_device *dev)
 	if (mgp->num_slices > 1) {
 		cmd.data0 = mgp->num_slices;
 		cmd.data1 = MXGEFW_SLICE_INTR_MODE_ONE_PER_SLICE;
+		cmd.data2 = 0;
 		if (mgp->dev->real_num_tx_queues > 1)
 			cmd.data1 |= MXGEFW_SLICE_ENABLE_MULTIPLE_TX_QUEUES;
 		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_ENABLE_RSS_QUEUES,
@@ -2414,6 +2425,8 @@ static int myri10ge_open(struct net_device *dev)
 
 	/* now give firmware buffers sizes, and MTU */
 	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_SET_MTU, &cmd, 0);
 	cmd.data0 = mgp->small_bytes;
 	status |=
@@ -2956,6 +2969,9 @@ static void myri10ge_set_multicast_list(struct net_device *dev)
 
 	/* Disable multicast filtering */
 
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	err = myri10ge_send_cmd(mgp, MXGEFW_ENABLE_ALLMULTI, &cmd, 1);
 	if (err != 0) {
 		netdev_err(dev, "Failed MXGEFW_ENABLE_ALLMULTI, error status: %d\n",
-- 
2.39.5


