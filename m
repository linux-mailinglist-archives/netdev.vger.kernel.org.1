Return-Path: <netdev+bounces-72873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AE85A047
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290981C212B7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA725601;
	Mon, 19 Feb 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N5BbRcA+"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063028DAB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336438; cv=none; b=K7wU1FcxZD7r7N+HBTIAsG4IU6ovj3BaEhHhwWE0j/qOX2SGyefPZMbrtI3KQbP7b/m0u8Yp49yyc2geYOHpnGvESIRSmiihn872pJe3BjQT36x9apP0uxtjUT8Ov0FAQ77YFKkaD/CoHoz/A58A25xoZmM04XT6x72rcnfLC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336438; c=relaxed/simple;
	bh=BiR82YM45dzwMMggH9ZW7nSph/p6iK+CZYyBCI23Yeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2UHYnWj7MzSywp9p2U/8UfJIrQGcndWJyn7IAFkEWDOZLivOdOl95vAYuqNgWicKITXN3Awc81RHnJ0aOMAJBzaWBkQKGsZtj53VpYzF2DmdjcGJhxVAPEvDKn3qgHCnCd/3E/cxIKXXkD9UJZ3v0+Nlpum/8BfD4460TMGFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N5BbRcA+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id D76DF20487; Mon, 19 Feb 2024 17:53:54 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336434;
	bh=Vo4RoKIbWLrO3lPpfIPk9QaysJLNHEwzWH6rlNJ12vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5BbRcA+fLsGjA/3nLAZ91zmj3d7eEHy2DwV04eltwxQApEj7VGQBpcOZv1IM6zyK
	 4OxF9Ca6bCS5CRmad+3QuoUtdHObSyW7MANff2nC0cNnSedmOIaeXl5D9JkNHkeS3V
	 UJXYPTX/D6pX6EIZiSXLrJzwys3Y8n6InHjQdUHiNjSoqMLFkp4lpbN36qIFnoMrGC
	 iba7Re0ZeaTZuIATCAkMylJylzXfYQKFQtZ8PHPq33UcN+TZvHq/QiH9l2kIRBxQTm
	 fLxgkg50uXS/80AxiMgaB/u4vL96N84pDjlIk2/nDAPJ1yzed8Ub8oVgR5wcxoqume
	 7ObHs9DNIjtCQ==
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
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 04/11] net: mctp: tests: create test skbs with the correct net and device
Date: Mon, 19 Feb 2024 17:51:49 +0800
Message-Id: <c263636d197ddb98acff500f0f8d659eee069bd4.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
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


