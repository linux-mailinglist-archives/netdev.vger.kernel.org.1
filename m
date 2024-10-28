Return-Path: <netdev+bounces-139443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A9F9B286B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17F81F21731
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66118FDB9;
	Mon, 28 Oct 2024 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="P7fbbknc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80F18E05A;
	Mon, 28 Oct 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099377; cv=none; b=eY3DSanorE6f//ohCFDOjXIWmjb3+D8IMrgr81XF8LRrKL/OqmB0rVfmuqnNk0Oi1NTfHaM3HUoAa0nFkwVK7CqSvXxzCN4zAMKy1E/QA06gUSkbyhjLDu+BpxUkbeaOP4Vs71M6HMFszFPqm4kj1F8WfLW10n8lzSGs24Q3OTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099377; c=relaxed/simple;
	bh=VWC1nHpOnQMfHS2IajS5B1U2ElXAuNB+4YFi0LN9JSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwbvr8qL/KoHSzlFJce4NwwCvzSf7KdlpewItAeH8HCioSB/gro5JvSqMEopLBVoPUsKmLjoJ0672wogBZ+4KWh7PG+LDqLu1eGEVkBKNB0gqxITMx425Ma2UEBaGv5JmqagaZzfoHXQeYYQhZ+EJ8nzDff8ODwo9DiAkBbG/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=P7fbbknc; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 1DE7D100003;
	Mon, 28 Oct 2024 10:00:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1730098810; bh=RN2mSQ9y2BkKPqjSxY5ISepC6Gm0Q+p6EoQS4iqNWM0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=P7fbbknceZNWh/5zRJW8GY5t4hhL3fpEPt7AMK7crnGQwEf++n1J+eRvsbIh6JMcp
	 Wd2P0fD6B3oW5y6m+5DnmOsqZbSmd0dQAVKiCwsJUL/VL29IsFBhLbbfigdtAgo3x1
	 1Z0rV98sA5qQAyBDfgFfAAUSWhhbYSNLKo4On3+TDW1jQHYFupoIESE2pntln7DdB6
	 aLxN6+gZMln0Uf03LnLzjk6NWKUeGtGSfXcgengB1ADzPIXKDZic3iZf6Arb+BRBbB
	 vhdM68F3Z5LY77dEz2ZwsXHt7bjP8Zfzj3mhruRCS43NAdQZGrVtpsOVZzXYPYkAwg
	 G+Bjjwz7O9b3Q==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon, 28 Oct 2024 09:59:01 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 09:58:41 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Madalin Bucur
	<madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v4] fsl/fman: Validate cell-index value obtained from Device Tree
Date: Mon, 28 Oct 2024 09:58:24 +0300
Message-ID: <20241028065824.15452-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 188748 [Oct 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/28 05:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/28 06:18:00 #26808967
X-KSMG-AntiVirus-Status: Clean, skipped

Cell-index value is obtained from Device Tree and then used to calculate
the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
In case of broken DT due to any error cell-index can contain any value
and it is possible to go beyond the array boundaries which can lead
at least to memory corruption.

Validate cell-index value obtained from Device Tree.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v4:
  - Update patch after refcount leaks fix
    (https://lore.kernel.org/all/20241015060122.25709-1-amishin@t-argos.ru/)
	as suggested by Jakub
	(https://lore.kernel.org/all/20240904072307.1b17227c@kernel.org/)
v3: https://lore.kernel.org/all/20240904060920.9645-1-amishin@t-argos.ru/
  - Add Reviewed-by: Sean Anderson <sean.anderson@seco.com>
    (https://lore.kernel.org/all/e0b8c69a-3cc0-4034-b3f7-d8bdcc480c4d@seco.com/)
v2: https://lore.kernel.org/all/20240702140124.19096-1-amishin@t-argos.ru/
  - Move check to mac.c to avoid allmodconfig build errors and reference leaks
v1: https://lore.kernel.org/all/20240702095034.12371-1-amishin@t-argos.ru/

 drivers/net/ethernet/freescale/fman/fman.c | 1 -
 drivers/net/ethernet/freescale/fman/fman.h | 3 +++
 drivers/net/ethernet/freescale/fman/mac.c  | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index 11da139082e1..1916a2ac48b9 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -259,6 +259,11 @@ static int mac_probe(struct platform_device *_of_dev)
 		err = -EINVAL;
 		goto _return_dev_put;
 	}
+	if (val >= MAX_NUM_OF_MACS) {
+		dev_err(dev, "cell-index value is too big for %pOF\n", mac_node);
+		err = -EINVAL;
+		goto _return_dev_put;
+	}
 	priv->cell_index = (u8)val;
 
 	/* Get the MAC address */
-- 
2.30.2


