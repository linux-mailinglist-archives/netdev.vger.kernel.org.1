Return-Path: <netdev+bounces-108501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC9923FD6
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65361B223D1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB701B5805;
	Tue,  2 Jul 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="OHSlqMtW"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3ABA2D;
	Tue,  2 Jul 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929034; cv=none; b=Dihkhuih33Df8seMIE63wIYGW5H+tlHZaLPwa3vHOJ3S3yP1ugzA3JxEmhmmQJSk31jdaAYS3fM3WqPkUZZkXsaaPi1XmUS0WyKaI0WdwGvpZwn4c+iQB00dMAT0oD2XJmv9S+6vqeBNc/Jx17t2iqZ9fZ6RS1GMIaH19SspN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929034; c=relaxed/simple;
	bh=625v53wes7Bvv0wAtLAXA470pPJVJzm/uHoRyuklkVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhGWqoLWKwLY+96bIVvOuwxE3oLJv4ZyR34qbska/1DsjeMDp2zz9FXWPePP0PvZG8GcspMz9dJyMoWkjWCPkSn6GvufWNrCyAhVHQaA/oU4GBQq+jFNbzTWjg9/irvoA7yVEdl7KeS7yfidczFjQd5aSnq5njBRnf++MkCrIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=OHSlqMtW; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 6F2EB100002;
	Tue,  2 Jul 2024 17:03:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719929012; bh=OIRWtO9tmmvE5rTVXX2zQUO9W6ij8CfZDofL07ySZds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OHSlqMtWM45LdOJGQaQszpLwJYeZ1cn4GGbhfFwpxWjNwj6ymQQxU2qY8KU5lQapM
	 plg4JurwmY4pbT6oLGUjxftqfOiaq71204y0vZ4sXWIH80WqopAkZsVuFBZNQBdM3u
	 ASuApnHOKGLdhzTzH9b+MDVyauCpN787NTFQvu/ukh+82sO3+3eBpwkXJugo8ljKON
	 wYTdhWMB+uqP3z8o5i4m0QekUax3m+6b1gPqOt/z8wl6Xl5Dx20rXtGO7ALoHCGnpE
	 bT2YwZ1FuQN0fcL4qDo5KM0Ow93VEHYjmlY+KzWlz8OcVEStd7QBK88lg5Soknke7s
	 GFO+5WQABIa2w==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 17:02:24 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 17:02:04 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Madalin Bucur
	<madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] fsl/fman: Validate cell-index value obtained from Device Tree
Date: Tue, 2 Jul 2024 17:01:24 +0300
Message-ID: <20240702140124.19096-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702095034.12371-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186281 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/02 10:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/02 07:20:00 #25796017
X-KSMG-AntiVirus-Status: Clean, skipped

Cell-index value is obtained from Device Tree and then used to calculate
the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
In case of broken DT due to any error cell-index can contain any value
and it is possible to go beyond the array boundaries which can lead
at least to memory corruption.
Validate cell-index value obtained from Device Tree.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Move check to mac.c to avoid allmodconfig build errors and reference leaks

 drivers/net/ethernet/freescale/fman/fman.c | 1 -
 drivers/net/ethernet/freescale/fman/fman.h | 3 +++
 drivers/net/ethernet/freescale/fman/mac.c  | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index d96028f01770..fb416d60dcd7 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -24,7 +24,6 @@
 
 /* General defines */
 #define FMAN_LIODN_TBL			64	/* size of LIODN table */
-#define MAX_NUM_OF_MACS			10
 #define FM_NUM_OF_FMAN_CTRL_EVENT_REGS	4
 #define BASE_RX_PORTID			0x08
 #define BASE_TX_PORTID			0x28
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 2ea575a46675..74eb62eba0d7 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -74,6 +74,9 @@
 #define BM_MAX_NUM_OF_POOLS		64 /* Buffers pools */
 #define FMAN_PORT_MAX_EXT_POOLS_NUM	8  /* External BM pools per Rx port */
 
+/* General defines */
+#define MAX_NUM_OF_MACS			10
+
 struct fman; /* FMan data */
 
 /* Enum for defining port types */
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9767586b4eb3..ac9ad5e67b44 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -247,6 +247,10 @@ static int mac_probe(struct platform_device *_of_dev)
 		dev_err(dev, "failed to read cell-index for %pOF\n", mac_node);
 		return -EINVAL;
 	}
+	if (val >= MAX_NUM_OF_MACS) {
+		dev_err(dev, "cell-index value is too big for %pOF\n", mac_node);
+		return -EINVAL;
+	}
 	priv->cell_index = (u8)val;
 
 	/* Get the MAC address */
-- 
2.30.2


