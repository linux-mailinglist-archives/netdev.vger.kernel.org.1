Return-Path: <netdev+bounces-196422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C120BAD4BBF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651AF16DAA2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249522ACFA;
	Wed, 11 Jun 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZDndOvjA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0A227E8F
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623462; cv=none; b=GrwHkqj9BCAXSFc8XFAr1bvawGsE7tjB/SQHp0rj2hreV+AhdHr5Byndq9MHuJWpY3HEynmdSfnIPf2Pk4iA2K2DbqxywVmX1NbU15V7dPRobx4K73W3xqzJGqwGVSvBjCgeQtBkvuOUYOYh6ffdiexQJI3ugqREVFWxVusHpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623462; c=relaxed/simple;
	bh=L0QDqvP7LYf3a7HP40O4D/9HzWhTu21fcJ9OM8avD+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyRX9foDlqjqSDBUJKfZQJswCjI0asccyq83yLXV9WOag1A7Qe82nXNwsqZFXvHLSS03g9Z5TqD9P3/zEQ3d5QYp4i0S5pPLY74sFkFkhzvakWFeMbpMKe/x9O/4njPmrGBJUCTcCk0vTCXFgHvh0f04bZFkjedKRGZyEe6VuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZDndOvjA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623458;
	bh=bpplyrufTPAEz0szVkPuhXMUOEK92m/zleybUILmNWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZDndOvjASkQ+AjMok8sgFDtg66weRXbcczWUANRT8a7t6+gFrNr0INdcYBNX2+lV/
	 dgCaRbLOpGzo3BG/WshoHDLc2F/20Kpy2RQfv69+PJFveU6zwrzDo8lRHxg3Ex4ez5
	 3tfJhfesoC63k4Kp+lfLh5jt7D8wNyeiK2BsNbZNrnod23IkYy1X5/Qf2oRgHz8HtO
	 xJABG8oBW+RaslYjy2WAeV81b6cNClSZ89Cj3zAYO9e+yt13zHUxibEwvnGQ1wUW1I
	 qt5PbgnpnSiiG1wADSZw/dCA2XLm/GQArAn1MooOUuAQMKGO7yWUva2RKxxx9jh1Zy
	 OyzJs32T9bnoA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id EC2DF67DDD; Wed, 11 Jun 2025 14:30:58 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Jun 2025 14:30:31 +0800
Subject: [PATCH net-next 04/13] net: mctp: test: Add an addressed device
 constructor
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-dev-forwarding-v1-4-6b69b1feb37f@codeconstruct.com.au>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
In-Reply-To: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Upcoming tests will check semantics of hardware addressing, which
require a dev with ->addr_len != 0. Add a constructor to create a
MCTP interface using a physically-addressed bus type.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/utils.c | 20 ++++++++++++++++++--
 net/mctp/test/utils.h |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 565763eb02114be8fd2a097fe0fe391d8f4bd2ae..26dce14dc7f246f03ff66e5b84274b33c48baf0e 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -26,19 +26,22 @@ static void mctp_test_dev_setup(struct net_device *ndev)
 	ndev->type = ARPHRD_MCTP;
 	ndev->mtu = MCTP_DEV_TEST_MTU;
 	ndev->hard_header_len = 0;
-	ndev->addr_len = 0;
 	ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
 	ndev->flags = IFF_NOARP;
 	ndev->netdev_ops = &mctp_test_netdev_ops;
 	ndev->needs_free_netdev = true;
 }
 
-struct mctp_test_dev *mctp_test_create_dev(void)
+static struct mctp_test_dev *__mctp_test_create_dev(unsigned short lladdr_len,
+						    const unsigned char *lladdr)
 {
 	struct mctp_test_dev *dev;
 	struct net_device *ndev;
 	int rc;
 
+	if (WARN_ON(lladdr_len > MAX_ADDR_LEN))
+		return NULL;
+
 	ndev = alloc_netdev(sizeof(*dev), "mctptest%d", NET_NAME_ENUM,
 			    mctp_test_dev_setup);
 	if (!ndev)
@@ -46,6 +49,8 @@ struct mctp_test_dev *mctp_test_create_dev(void)
 
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
+	ndev->addr_len = lladdr_len;
+	dev_addr_set(ndev, lladdr);
 
 	rc = register_netdev(ndev);
 	if (rc) {
@@ -61,6 +66,17 @@ struct mctp_test_dev *mctp_test_create_dev(void)
 	return dev;
 }
 
+struct mctp_test_dev *mctp_test_create_dev(void)
+{
+	return __mctp_test_create_dev(0, NULL);
+}
+
+struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
+						  const unsigned char *lladdr)
+{
+	return __mctp_test_create_dev(lladdr_len, lladdr);
+}
+
 void mctp_test_destroy_dev(struct mctp_test_dev *dev)
 {
 	mctp_dev_put(dev->mdev);
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index df6aa1c03440922c18eec337b220b8428d1c684e..c702f4a6b5ff9f2de06f6a6bfee0c3653abfdefd 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -3,6 +3,8 @@
 #ifndef __NET_MCTP_TEST_UTILS_H
 #define __NET_MCTP_TEST_UTILS_H
 
+#include <uapi/linux/netdevice.h>
+
 #include <kunit/test.h>
 
 #define MCTP_DEV_TEST_MTU	68
@@ -10,11 +12,16 @@
 struct mctp_test_dev {
 	struct net_device *ndev;
 	struct mctp_dev *mdev;
+
+	unsigned short lladdr_len;
+	unsigned char lladdr[MAX_ADDR_LEN];
 };
 
 struct mctp_test_dev;
 
 struct mctp_test_dev *mctp_test_create_dev(void);
+struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
+						  const unsigned char *lladdr);
 void mctp_test_destroy_dev(struct mctp_test_dev *dev);
 
 #endif /* __NET_MCTP_TEST_UTILS_H */

-- 
2.39.5


