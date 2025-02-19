Return-Path: <netdev+bounces-167848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1103A3C902
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F2E177DCB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E4722B8D5;
	Wed, 19 Feb 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="P3MOh51t"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278422AE68
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994154; cv=none; b=fipqRx8vZKTc6z/uHo99pdjk6maLiGe2i1GJpVpi7BgF4WOeo6wfcwbDxMiVtc6kTn8Gnfi3Rzs/4gqmaA7wDBmadjherXqTcAtSLBjpUiavMyIJiFIXkqSqtbX6XeJHfvFEumimwh3p9wyJiaQgRZI3ZFCiQtGhyFdiaCa2tqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994154; c=relaxed/simple;
	bh=HXBLJtaIaOudcomRCIGwhxYjIl3TJo2FXN1fAgjAjv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blHqDyQJpKmpXWEFocbVoEKpSzf1Rz5WU6uUjrW2v/RWutF/Y0yxTUHbUdUGEIQAd4G9ok3EPCh5KiNp0AO5Jm9gb6LtoKdZMVCtFs60qhB13QzuqpA3of1e7G5HQeTMmERHGasaJP+7r6dg1muT8z1cEpYnvXmZNipaSRGdQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=P3MOh51t; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ytnMsgyp8cUwtU3iNP5WDJh5DFPeXAXSbRtN6uiSNiw=; b=P3MOh51tDxysa4NdUS/DaoRNxE
	LjoCRTkJNiXAgduROtSPoywoU7VOxwrBSUoUn0rpCLM1a6042MFbDZrj6QEh/9iMmxtnRTisi18Rz
	9KPPzEfNix6Kc3CyR60rSsx3ja+eC8N8rhYJoUc/LPQAtWzA3HJeoXM7omdmsas0Cges=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tkpxk-000000003mi-3sS8;
	Wed, 19 Feb 2025 20:42:29 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v7 8/8] tsnep: Add loopback selftests
Date: Wed, 19 Feb 2025 20:42:13 +0100
Message-Id: <20250219194213.10448-9-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219194213.10448-1-gerhard@engleder-embedded.com>
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Add selftest sets with 100 Mbps and 1000 Mbps fixed speed to ethtool
selftests.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 .../net/ethernet/engleder/tsnep_selftests.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_selftests.c b/drivers/net/ethernet/engleder/tsnep_selftests.c
index 8a9145f93147..3f56cd871c00 100644
--- a/drivers/net/ethernet/engleder/tsnep_selftests.c
+++ b/drivers/net/ethernet/engleder/tsnep_selftests.c
@@ -4,6 +4,7 @@
 #include "tsnep.h"
 
 #include <net/pkt_sched.h>
+#include <net/selftests.h>
 
 enum tsnep_test {
 	TSNEP_TEST_ENABLE = 0,
@@ -756,27 +757,36 @@ static bool tsnep_test_taprio_extension(struct tsnep_adapter *adapter)
 
 int tsnep_ethtool_get_test_count(void)
 {
-	return TSNEP_TEST_COUNT;
+	int count = TSNEP_TEST_COUNT;
+
+	count += net_selftest_set_get_count(NET_TEST_LOOPBACK_100);
+	count += net_selftest_set_get_count(NET_TEST_LOOPBACK_1000);
+
+	return count;
 }
 
 void tsnep_ethtool_get_test_strings(u8 *data)
 {
 	memcpy(data, tsnep_test_strings, sizeof(tsnep_test_strings));
+	data += sizeof(tsnep_test_strings);
+
+	net_selftest_set_get_strings(NET_TEST_LOOPBACK_100, &data);
+	net_selftest_set_get_strings(NET_TEST_LOOPBACK_1000, &data);
 }
 
 void tsnep_ethtool_self_test(struct net_device *netdev,
 			     struct ethtool_test *eth_test, u64 *data)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
+	int count = tsnep_ethtool_get_test_count();
+	int i;
 
-	eth_test->len = TSNEP_TEST_COUNT;
+	eth_test->len = count;
 
 	if (eth_test->flags != ETH_TEST_FL_OFFLINE) {
 		/* no tests are done online */
-		data[TSNEP_TEST_ENABLE] = 0;
-		data[TSNEP_TEST_TAPRIO] = 0;
-		data[TSNEP_TEST_TAPRIO_CHANGE] = 0;
-		data[TSNEP_TEST_TAPRIO_EXTENSION] = 0;
+		for (i = 0; i < count; i++)
+			data[i] = 0;
 
 		return;
 	}
@@ -808,4 +818,10 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 		eth_test->flags |= ETH_TEST_FL_FAILED;
 		data[TSNEP_TEST_TAPRIO_EXTENSION] = 1;
 	}
+
+	data += TSNEP_TEST_COUNT;
+	net_selftest_set(NET_TEST_LOOPBACK_100, netdev, eth_test, data);
+
+	data += net_selftest_set_get_count(NET_TEST_LOOPBACK_100);
+	net_selftest_set(NET_TEST_LOOPBACK_1000, netdev, eth_test, data);
 }
-- 
2.39.5


