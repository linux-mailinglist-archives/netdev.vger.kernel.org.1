Return-Path: <netdev+bounces-124822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93D96B138
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4481C20F86
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD2137776;
	Wed,  4 Sep 2024 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="U67pEJQN"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694812C522;
	Wed,  4 Sep 2024 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430301; cv=none; b=NiVvlzS4uwMWuoRuA2vQN0v7eVku/J00ya6ak2e7ixhZ/FxrTvljG0cGvciHBQMvJOAoHAsnNWlTT1j6QU6yCOto9XkdS48YIeaBXrbhGnZdLgVzNTf9k0/3heyqb419a6oWXDb8NY1mYpA1vx47tuDdCXfSk7ESre3VAwHV+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430301; c=relaxed/simple;
	bh=BVk75/I/bV+9ETgvytWFVFN4T4zzvPL3GWZtJtnYk5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2uA7omPm2B5qrqnhc2I58bb2U8I7scJWL6LfXRNaCV5f3F32/JkoLyYBDBSotMXqtH/+qNJfkXGJMGoJAh5RDIe0za9dJ1bAVq94r4eJTjeG91sOO7sSwizV18u2yy9rVziTc/B6bY9U0MT49f/DCuFxuVvESzJDQiBP1ldmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=U67pEJQN; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id CBF8F100002;
	Wed,  4 Sep 2024 09:11:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1725430270; bh=FBERuqxsp0arGHoZa1OelsEJhh/5TEmMpEu1RfzOCCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=U67pEJQNqyt0l7qEW0QzrDOqaP4lw7EeaLW2pXSBk7v4peAlLoSI8OB6tlwMv595c
	 2srqvWZdJ1MxROVAIIsJG7MeXxcTSeZ82yuitKppp3Q5Gv2D8xlMMUQGUreEanTvjy
	 ZaO4zIJQxjLMbM3FweRO1iSXx90DHWxrCn4WHa32TfJbGHvtoCwznMyIESKUxyJX6s
	 PYVY8IHaIbD8Eg5pVEKI42qnnAPOCS1P9PKwN4x+v4Q09Di82kxbMgniAvNnC41rGc
	 cn2BC0/uwOL0ZN4/c1UY2FugNXSTcUTYSlm6FuFx4GGOIEklv+Tkg6Xuqip8QgfNoV
	 osH6jmVJ9WwMg==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  4 Sep 2024 09:10:04 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 09:09:44 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Madalin Bucur
	<madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v3] fsl/fman: Validate cell-index value obtained from Device Tree
Date: Wed, 4 Sep 2024 09:09:20 +0300
Message-ID: <20240904060920.9645-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187517 [Sep 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;lore.kernel.org:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/03 23:54:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/04 01:19:00 #26517203
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
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
---
v3:
  - Add Reviewed-by: Sean Anderson <sean.anderson@seco.com>
    (https://lore.kernel.org/all/e0b8c69a-3cc0-4034-b3f7-d8bdcc480c4d@seco.com/)
v2: https://lore.kernel.org/all/20240702140124.19096-1-amishin@t-argos.ru/
  - Move check to mac.c to avoid allmodconfig build errors and reference leaks
v1: https://lore.kernel.org/all/20240702095034.12371-1-amishin@t-argos.ru/

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


