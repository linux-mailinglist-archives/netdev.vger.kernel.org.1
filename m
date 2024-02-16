Return-Path: <netdev+bounces-72296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AF85778C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AF0B227D0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAA1C69F;
	Fri, 16 Feb 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Jmnj0TFv"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E011C6A0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071583; cv=none; b=QSyk//7yWot1bLwZyL/1EiVxwiuPrnUQin8RGrIGq7Wez+I/v339U8PjH8il09R58EBaXtd3r+o9udDzPsIsWXsFxoYthV03z5xDW8ZbQWO7Hi2znFc7LfptDPRNSM+4e1h0IFgtBs4p6vptJua5y8QoMDvQjFGUeLTJsT+XJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071583; c=relaxed/simple;
	bh=BiR82YM45dzwMMggH9ZW7nSph/p6iK+CZYyBCI23Yeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1jydDPsbXrmev8mp+X+PXOAXE23l9vzPAUKONrdj3QT4CzPpF6cz9nfNfkqw8Zev6wXPgmMOnkQWjnCS4o91C0uJDnjw0yT5e43+Tc7I3KTcKSTwfC0twbd+zbl+wNTPjXDkWwzLT+oDpILmbRe60MyqpOat51QiWUeQ6DTfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Jmnj0TFv; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 3EE54203C3; Fri, 16 Feb 2024 16:19:33 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071573;
	bh=Vo4RoKIbWLrO3lPpfIPk9QaysJLNHEwzWH6rlNJ12vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jmnj0TFvKIrcHOk1Q9+TyJk+q1laahqV9YV+22rxVQFACOFUPG/aSf4k9ruZ8CTGV
	 N9FcqcvqqECFHvxBGtWvFGqd6iA6f+xHq2aEpQu2zTL39vo0AzQmZk8n3DyAD0QZUP
	 aeFGGX2QT9yCYqfpXm31U9LuzUtXb/C6D46RF1LvRgFGnl0K0L0GUFBm4owl68Gz+Q
	 /zmMC9E/MmN9XlAZzrYMn+d66XZ5SXoLJKYmLFlIGOVXe49A+HV22AQ/1DC95DOCU8
	 r43fzfAwO4wENCLdRkVi1vZARWHY6GfRJbKc02JbY9qIDKkfoIFs54BRjzg06v7Pt8
	 8J6pD5yi0TMww==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 04/11] net: mctp: tests: create test skbs with the correct net and device
Date: Fri, 16 Feb 2024 16:19:14 +0800
Message-Id: <c263636d197ddb98acff500f0f8d659eee069bd4.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our test skb creation functions, we're not setting up the net and
device data. This doesn't matter at the moment, but we will want to add
support for distinct net IDs in future.

Set the ->net identifier on the test MCTP device, and ensure that test
skbs are set up with the correct device-related data on creation. Create
a helper for setting skb->dev and mctp_skb_cb->net.

We have a few cases where we're calling __mctp_cb() to initialise the cb
(which we need for the above) separately, so integrate this into the skb
creation helpers.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 23 +++++++++++++++--------
 net/mctp/test/utils.c      |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 92ea4158f7fc..714e5ae47629 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -79,6 +79,16 @@ static void mctp_test_route_destroy(struct kunit *test,
 	kfree_rcu(&rt->rt, rcu);
 }
 
+static void mctp_test_skb_set_dev(struct sk_buff *skb,
+				  struct mctp_test_dev *dev)
+{
+	struct mctp_skb_cb *cb;
+
+	cb = mctp_cb(skb);
+	cb->net = READ_ONCE(dev->mdev->net);
+	skb->dev = dev->ndev;
+}
+
 static struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,
 					    unsigned int data_len)
 {
@@ -91,6 +101,7 @@ static struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,
 	if (!skb)
 		return NULL;
 
+	__mctp_cb(skb);
 	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
 
 	buf = skb_put(skb, data_len);
@@ -111,6 +122,7 @@ static struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
 	if (!skb)
 		return NULL;
 
+	__mctp_cb(skb);
 	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
 	memcpy(skb_put(skb, data_len), data, data_len);
 
@@ -249,8 +261,6 @@ static void mctp_test_rx_input(struct kunit *test)
 	skb = mctp_test_create_skb(&params->hdr, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
-	__mctp_cb(skb);
-
 	mctp_pkttype_receive(skb, dev->ndev, &mctp_packet_type, NULL);
 
 	KUNIT_EXPECT_EQ(test, !!rt->pkts.qlen, params->input);
@@ -344,8 +354,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 	skb = mctp_test_create_skb_data(&params->hdr, &params->type);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
-	skb->dev = dev->ndev;
-	__mctp_cb(skb);
+	mctp_test_skb_set_dev(skb, dev);
 
 	rc = mctp_route_input(&rt->rt, skb);
 
@@ -417,8 +426,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 		skb = mctp_test_create_skb_data(&params->hdrs[i], &c);
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
-		skb->dev = dev->ndev;
-		__mctp_cb(skb);
+		mctp_test_skb_set_dev(skb, dev);
 
 		rc = mctp_route_input(&rt->rt, skb);
 	}
@@ -576,8 +584,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	skb = mctp_test_create_skb_data(&params->hdr, &c);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
-	skb->dev = dev->ndev;
-	__mctp_cb(skb);
+	mctp_test_skb_set_dev(skb, dev);
 
 	rc = mctp_route_input(&rt->rt, skb);
 
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index e03ba66bbe18..565763eb0211 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -4,6 +4,7 @@
 #include <linux/mctp.h>
 #include <linux/if_arp.h>
 
+#include <net/mctp.h>
 #include <net/mctpdevice.h>
 #include <net/pkt_sched.h>
 
@@ -54,6 +55,7 @@ struct mctp_test_dev *mctp_test_create_dev(void)
 
 	rcu_read_lock();
 	dev->mdev = __mctp_dev_get(ndev);
+	dev->mdev->net = mctp_default_net(dev_net(ndev));
 	rcu_read_unlock();
 
 	return dev;
-- 
2.39.2


