Return-Path: <netdev+bounces-170410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B4A489EB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EDD3B7897
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B019DF52;
	Thu, 27 Feb 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="CtE8suJn"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39B2AEE0
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688318; cv=none; b=uFMHOdeJCW9rcLEmbFgacBvme4T9Vy5EXp3j7tiFzotNBzsX2ZRa7K42zcAQINLutqzXVWVLwHbh8rDCfY9JjnaLLZOMQej5/Zuddy5dE/x6NZgF2ZO7LgRkN6wZSViy2Iwt3PyKiwGsNCPT9nUtHXpCGm2avTZtRJ06edCInkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688318; c=relaxed/simple;
	bh=VxARNUgP1YlGVkhMRSdQLQRUmxHNUAAWwoTX7cZtvng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMo/CtvbjefAA4UmH/OIyznwMSpaDj1C/05uXfEyKh8lNCfZ1L2zMJ3087/83iDfj32k6Ny/k+gRUe9tcGVeAY/fZ9Hu5HSikbsDi4Yp2M2/3JCIhugoN4kyJbpR7a5xaGexG6e7WiA+8vgrKVW3Fj/s3AJD9P0ykrEmxlLY024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=CtE8suJn; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j2RTWx/iEDaz/kSGFvPpAU09x18Ez11+jc7uAhpeyXs=; b=CtE8suJndnT7z2HNKn0Z8QRk8F
	SHm05f852Xs2p8mPAiYoEJnlNL5/JgJyZBL7+RP4nF/4kgeq0PtnCSDdM4C9+y/ocCCpavYHrxi/V
	jZbX46Gz58M59L7yobiLCHE0ZwdLiR2niyU35enG6KmNFpQD3KmWFt/Y6dfUK0rlXEa4=;
Received: from 88-117-55-1.adsl.highway.telekom.at ([88.117.55.1] helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkXx-000000000iA-2dEv;
	Thu, 27 Feb 2025 21:31:53 +0100
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
Subject: [PATCH net-next v9 8/8] tsnep: Add loopback selftests
Date: Thu, 27 Feb 2025 21:31:38 +0100
Message-Id: <20250227203138.60420-9-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227203138.60420-1-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
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
 .../net/ethernet/engleder/tsnep_selftests.c   | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_selftests.c b/drivers/net/ethernet/engleder/tsnep_selftests.c
index 8a9145f93147..b1f08f17f55b 100644
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
+	count += net_selftest_set_get_count(NET_SELFTEST_LOOPBACK_SPEED);
+	count += net_selftest_set_get_count(NET_SELFTEST_LOOPBACK_SPEED);
+
+	return count;
 }
 
 void tsnep_ethtool_get_test_strings(u8 *data)
 {
 	memcpy(data, tsnep_test_strings, sizeof(tsnep_test_strings));
+	data += sizeof(tsnep_test_strings);
+
+	net_selftest_set_get_strings(NET_SELFTEST_LOOPBACK_SPEED, 100, &data);
+	net_selftest_set_get_strings(NET_SELFTEST_LOOPBACK_SPEED, 1000, &data);
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
@@ -808,4 +818,12 @@ void tsnep_ethtool_self_test(struct net_device *netdev,
 		eth_test->flags |= ETH_TEST_FL_FAILED;
 		data[TSNEP_TEST_TAPRIO_EXTENSION] = 1;
 	}
+	data += TSNEP_TEST_COUNT;
+
+	net_selftest_set(NET_SELFTEST_LOOPBACK_SPEED, 100, netdev, eth_test,
+			 data);
+	data += net_selftest_set_get_count(NET_SELFTEST_LOOPBACK_SPEED);
+
+	net_selftest_set(NET_SELFTEST_LOOPBACK_SPEED, 1000, netdev, eth_test,
+			 data);
 }
-- 
2.39.5


