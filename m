Return-Path: <netdev+bounces-256485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOX/DE1/gmnAVQMAu9opvQ
	(envelope-from <netdev+bounces-256485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8FCDF896
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CCF0303FDFF
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687B2BD5BD;
	Tue,  3 Feb 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAZyYGbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8458256C8B;
	Tue,  3 Feb 2026 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159916; cv=none; b=V2xYvuo75cDgU6P97mBSKzYRnZMAP/x1qUu7L//EDcY4oTdOUZJaQkRe0I9gBHW5Rdy2ceqiY9iXRQbB9zCwnNaKjUdUCmY2ScQLmLth7v1ifl1NyYJpDYz+bttjDuVmHdqBc26409ITwN9KZJEVEJ0/rb0mfzQz5SnK/lQDNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159916; c=relaxed/simple;
	bh=Qe0cVaQhjq3K4xw19O46QJ6IGjb0IRJc/wHoXaIhLH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gK5tbAqbn0oyab3jA0W8bQG6JN1xm6saCSUsE1WzHVCbnuGR0ANv0T5XmyaYZocuV9nlK4PWTEMUMGvrBU4pOHbiHJ1PyXBihG5bvqVFSnCOve4AwPdzKC8St7MEYRpAnwmyF2LTvzdoTrp/izjDYfn/F5eA2nYGNDtymyuAHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAZyYGbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D3C116D0;
	Tue,  3 Feb 2026 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159915;
	bh=Qe0cVaQhjq3K4xw19O46QJ6IGjb0IRJc/wHoXaIhLH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAZyYGboWUClFBBelrSJxG0YLvZIJyDqLwNZI9thWTfEOTtGULVOWA/uLw/H4ZEvf
	 R+EGLwQ3bdwsoKJP8UlVQRjtimhKyFZJbQBeb3QbqoHRyAGTlI+RriCrc+fjpATrOC
	 b5SGc5IDfDDeXHdrdIPrmetWxX1aclsQjY0Zl4OnE8ca+wAMGf3crHRUJJAqg2sOH9
	 EQgiRbMS081Y6kt9zKypkYmlnFv7UWOssDyR5fOT3cG2mdMAJaNFHlLeuARUU4/Ahk
	 wljATe6DMoqUWwzKamnxsH2+/I+4ZbwaF0KiiONSLPo+4IrDQcDQZdaMQ1yf5WKETj
	 xR9mMbcXBCdlw==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [v3] myri10ge: avoid uninitialized variable use
Date: Wed,  4 Feb 2026 00:04:52 +0100
Message-Id: <20260203230501.832872-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260203230501.832872-1-arnd@kernel.org>
References: <20260203230501.832872-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-256485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC8FCDF896
X-Rspamd-Action: no action

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
v3: add one more missing instance
---
 .../net/ethernet/myricom/myri10ge/myri10ge.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index cea28aa971cc..b699d50e227e 100644
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
@@ -2472,7 +2489,6 @@ static int myri10ge_open(struct net_device *dev)
 static int myri10ge_close(struct net_device *dev)
 {
 	struct myri10ge_priv *mgp = netdev_priv(dev);
-	struct myri10ge_cmd cmd;
 	int status, old_down_cnt;
 	int i;
 
@@ -2491,8 +2507,13 @@ static int myri10ge_close(struct net_device *dev)
 
 	netif_tx_stop_all_queues(dev);
 	if (mgp->rebooted == 0) {
+		struct myri10ge_cmd cmd;
+
 		old_down_cnt = mgp->down_cnt;
 		mb();
+		cmd.data0 = 0;
+		cmd.data1 = 0;
+		cmd.data2 = 0;
 		status =
 		    myri10ge_send_cmd(mgp, MXGEFW_CMD_ETHERNET_DOWN, &cmd, 0);
 		if (status)
@@ -2956,6 +2977,9 @@ static void myri10ge_set_multicast_list(struct net_device *dev)
 
 	/* Disable multicast filtering */
 
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	err = myri10ge_send_cmd(mgp, MXGEFW_ENABLE_ALLMULTI, &cmd, 1);
 	if (err != 0) {
 		netdev_err(dev, "Failed MXGEFW_ENABLE_ALLMULTI, error status: %d\n",
-- 
2.39.5


