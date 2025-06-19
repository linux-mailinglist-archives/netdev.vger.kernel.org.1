Return-Path: <netdev+bounces-199368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C8ADFF55
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52EB17C9EC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157625F7AC;
	Thu, 19 Jun 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FvuWYQ1j"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6125E815
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320074; cv=none; b=rlVxwv1rlH2snx82AD8X9GLcYquzktC2tIUFVqIWsOg/aF1b5hZ9l1s2SALpHOTw0ypPZ24KNbILIh9PEp0lX9agBXHNl705+Y0UvdomMikblL5qkM+HST66OTMXhb1EFtS6enhys9+aGYUv4/NYzw42V25Lu+4mLBTH0RAwP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320074; c=relaxed/simple;
	bh=/T8dRKxqCyOJRox78UgDkHKwz3XgkkuozzPMMep5h3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1T62y+VsG2Jlrj2biZsz0kYmffvjCIwlsILQYdhH3wXx5yyhTq+GFxdFymaZeXmsd/EAt8tjx8EeJ9D5YbvggMeajgEBk08UzOV9+ckJwCkzUl8Y4ttb/G6XrHuICrdyLy02jvkqIUo6EQMM52uNCcdH8GtpHCslUa1g3TdzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FvuWYQ1j; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320062;
	bh=slLKkXJZ0IROdMTAwrNvRFaAOgB+k94hUEomh6b+6pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FvuWYQ1jOGf8V15C2F/XQrPXfJVG/Wx1jHqEWKvgV+8MvWjtE5+dtNNpNlzxYU/Nc
	 8Hyh3ZiTCsqRPUulRkEisz0Y70uM2S57Pj97l6CECAYZZkwic8UkGDclgd6WzFDlBW
	 W3a/ySKNMKZdOZo7s4HyNX5BinfG3LmBHCq/hcahWS8xarlsQ6zRf3lCcT7O5OyE+X
	 uEOP5HZ8TJDdB5iIdrkxRw22OGhA1HZ187DaCywDf2q5KLZXCAsbvKHnyzCdPoddju
	 7HeNO8Di57PrLYjhby9WI1Ya65iiX0G1AAvf5DTFFwV2+41EQrqoq03ePmgK/gnWlr
	 XPs481wZ/1McQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B075B68EC6; Thu, 19 Jun 2025 16:01:02 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:43 +0800
Subject: [PATCH net-next v2 08/13] net: mctp: test: Add initial socket
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-8-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Recent changes have modified the extaddr path a little, so add a couple
of kunit tests to af-mctp.c. These check that we're correctly passing
lladdr data between sendmsg/recvmsg and the routing layer.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c          |   5 ++
 net/mctp/test/sock-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 42d80a9f21d6a054375156e3de21be72a187c6fc..23158f6d2d6e63a8a51adfde52a62d374bc23545 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -17,6 +17,8 @@
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 
+#include <kunit/static_stub.h>
+
 #include <uapi/linux/if_arp.h>
 
 #include <net/mctp.h>
@@ -1006,6 +1008,9 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	int rc;
 	u8 tag;
 
+	KUNIT_STATIC_STUB_REDIRECT(mctp_local_output, sk, dst, skb, daddr,
+				   req_tag);
+
 	rc = -ENODEV;
 
 	spin_lock_irqsave(&dst->dev->addrs_lock, flags);
diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
index abaad82b4e256bead6c0a6ab0698bfa4f75f8473..5501f7794a8f96f1dcf26e93542bec04ddcfc769 100644
--- a/net/mctp/test/sock-test.c
+++ b/net/mctp/test/sock-test.c
@@ -1,10 +1,223 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 
+#include <linux/socket.h>
+#include <linux/spinlock.h>
+
 #include "utils.h"
 
+static const u8 dev_default_lladdr[] = { 0x01, 0x02 };
+
+/* helper for simple sock setup: single device, with dev_default_lladdr as its
+ * hardware address, assigned with a local EID 8, and a route to EID 9
+ */
+static void __mctp_sock_test_init(struct kunit *test,
+				  struct mctp_test_dev **devp,
+				  struct mctp_test_route **rtp,
+				  struct socket **sockp)
+{
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock;
+	unsigned long flags;
+	u8 *addrs;
+	int rc;
+
+	dev = mctp_test_create_dev_lladdr(sizeof(dev_default_lladdr),
+					  dev_default_lladdr);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	addrs = kmalloc(1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, addrs);
+	addrs[0] = 8;
+
+	spin_lock_irqsave(&dev->mdev->addrs_lock, flags);
+	dev->mdev->num_addrs = 1;
+	swap(addrs, dev->mdev->addrs);
+	spin_unlock_irqrestore(&dev->mdev->addrs_lock, flags);
+
+	kfree(addrs);
+
+	rt = mctp_test_create_route(dev_net(dev->ndev), dev->mdev, 9, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
+
+	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	*devp = dev;
+	*rtp = rt;
+	*sockp = sock;
+}
+
+static void __mctp_sock_test_fini(struct kunit *test,
+				  struct mctp_test_dev *dev,
+				  struct mctp_test_route *rt,
+				  struct socket *sock)
+{
+	sock_release(sock);
+	mctp_test_route_destroy(test, rt);
+	mctp_test_destroy_dev(dev);
+}
+
+struct mctp_test_sock_local_output_config {
+	struct mctp_test_dev *dev;
+	size_t halen;
+	u8 haddr[MAX_ADDR_LEN];
+	bool invoked;
+	int rc;
+};
+
+static int mctp_test_sock_local_output(struct sock *sk,
+				       struct mctp_dst *dst,
+				       struct sk_buff *skb,
+				       mctp_eid_t daddr, u8 req_tag)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct mctp_test_sock_local_output_config *cfg = test->priv;
+
+	KUNIT_EXPECT_PTR_EQ(test, dst->dev, cfg->dev->mdev);
+	KUNIT_EXPECT_EQ(test, dst->halen, cfg->halen);
+	KUNIT_EXPECT_MEMEQ(test, dst->haddr, cfg->haddr, dst->halen);
+
+	cfg->invoked = true;
+
+	kfree_skb(skb);
+
+	return cfg->rc;
+}
+
+static void mctp_test_sock_sendmsg_extaddr(struct kunit *test)
+{
+	struct sockaddr_mctp_ext addr = {
+		.smctp_base = {
+			.smctp_family = AF_MCTP,
+			.smctp_tag = MCTP_TAG_OWNER,
+			.smctp_network = MCTP_NET_ANY,
+		},
+	};
+	struct mctp_test_sock_local_output_config cfg = { 0 };
+	u8 haddr[] = { 0xaa, 0x01 };
+	u8 buf[4] = { 0, 1, 2, 3 };
+	struct mctp_test_route *rt;
+	struct msghdr msg = { 0 };
+	struct mctp_test_dev *dev;
+	struct mctp_sock *msk;
+	struct socket *sock;
+	ssize_t send_len;
+	struct kvec vec = {
+		.iov_base = buf,
+		.iov_len = sizeof(buf),
+	};
+
+	__mctp_sock_test_init(test, &dev, &rt, &sock);
+
+	/* Expect to see the dst configured up with the addressing data we
+	 * provide in the struct sockaddr_mctp_ext
+	 */
+	cfg.dev = dev;
+	cfg.halen = sizeof(haddr);
+	memcpy(cfg.haddr, haddr, sizeof(haddr));
+
+	test->priv = &cfg;
+
+	kunit_activate_static_stub(test, mctp_local_output,
+				   mctp_test_sock_local_output);
+
+	/* enable and configure direct addressing */
+	msk = container_of(sock->sk, struct mctp_sock, sk);
+	msk->addr_ext = true;
+
+	addr.smctp_ifindex = dev->ndev->ifindex;
+	addr.smctp_halen = sizeof(haddr);
+	memcpy(addr.smctp_haddr, haddr, sizeof(haddr));
+
+	msg.msg_name = &addr;
+	msg.msg_namelen = sizeof(addr);
+
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &vec, 1, sizeof(buf));
+	send_len = mctp_sendmsg(sock, &msg, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, send_len, sizeof(buf));
+	KUNIT_EXPECT_TRUE(test, cfg.invoked);
+
+	__mctp_sock_test_fini(test, dev, rt, sock);
+}
+
+static void mctp_test_sock_recvmsg_extaddr(struct kunit *test)
+{
+	struct sockaddr_mctp_ext recv_addr = { 0 };
+	u8 rcv_buf[1], rcv_data[] = { 0, 1 };
+	u8 haddr[] = { 0xaa, 0x02 };
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct mctp_skb_cb *cb;
+	struct mctp_sock *msk;
+	struct sk_buff *skb;
+	struct mctp_hdr hdr;
+	struct socket *sock;
+	struct msghdr msg;
+	ssize_t recv_len;
+	int rc;
+	struct kvec vec = {
+		.iov_base = rcv_buf,
+		.iov_len = sizeof(rcv_buf),
+	};
+
+	__mctp_sock_test_init(test, &dev, &rt, &sock);
+
+	/* enable extended addressing on recv */
+	msk = container_of(sock->sk, struct mctp_sock, sk);
+	msk->addr_ext = true;
+
+	/* base incoming header, using a nul-EID dest */
+	hdr.ver = 1;
+	hdr.dest = 0;
+	hdr.src = 9;
+	hdr.flags_seq_tag = MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM |
+			    MCTP_HDR_FLAG_TO;
+
+	skb = mctp_test_create_skb_data(&hdr, &rcv_data);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+
+	mctp_test_skb_set_dev(skb, dev);
+
+	/* set incoming extended address data */
+	cb = mctp_cb(skb);
+	cb->halen = sizeof(haddr);
+	cb->ifindex = dev->ndev->ifindex;
+	memcpy(cb->haddr, haddr, sizeof(haddr));
+
+	/* Deliver to socket. The route input path pulls the network header,
+	 * leaving skb data at type byte onwards. recvmsg will consume the
+	 * type for addr.smctp_type
+	 */
+	skb_pull(skb, sizeof(hdr));
+	rc = sock_queue_rcv_skb(sock->sk, skb);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	msg.msg_name = &recv_addr;
+	msg.msg_namelen = sizeof(recv_addr);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, sizeof(rcv_buf));
+
+	recv_len = mctp_recvmsg(sock, &msg, sizeof(rcv_buf),
+				MSG_DONTWAIT | MSG_TRUNC);
+
+	KUNIT_EXPECT_EQ(test, recv_len, sizeof(rcv_buf));
+
+	/* expect our extended address to be populated from hdr and cb */
+	KUNIT_EXPECT_EQ(test, msg.msg_namelen, sizeof(recv_addr));
+	KUNIT_EXPECT_EQ(test, recv_addr.smctp_base.smctp_family, AF_MCTP);
+	KUNIT_EXPECT_EQ(test, recv_addr.smctp_ifindex, dev->ndev->ifindex);
+	KUNIT_EXPECT_EQ(test, recv_addr.smctp_halen, sizeof(haddr));
+	KUNIT_EXPECT_MEMEQ(test, recv_addr.smctp_haddr, haddr, sizeof(haddr));
+
+	__mctp_sock_test_fini(test, dev, rt, sock);
+}
+
 static struct kunit_case mctp_test_cases[] = {
+	KUNIT_CASE(mctp_test_sock_sendmsg_extaddr),
+	KUNIT_CASE(mctp_test_sock_recvmsg_extaddr),
 	{}
 };
 

-- 
2.39.5


