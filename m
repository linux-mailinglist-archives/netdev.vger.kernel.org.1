Return-Path: <netdev+bounces-108390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D5C923ABB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B181C21F0B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B9156C6B;
	Tue,  2 Jul 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="hNZOWcX3"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2C15748F;
	Tue,  2 Jul 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913970; cv=none; b=EMoNblCn7Kc9ke06ixeuz/wGbVGwqjgyuTnKRRasz7b5/2B4vjJLiFpYkQoy+uOj4TphqzUjJmptvSP+B2K7mUcdL5C0hV79tqDtkZVZZMp5W+NISrmDpTr/EEwYcHKr5BPbwN17W8n9AgJGovx4xOlHKBkPYe98h0Alw4DIkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913970; c=relaxed/simple;
	bh=bxm7EwGm4U7hZabbWvg8Mgu7xEnH4BGn9uR6qJR2Fg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLoqY1r6+nnneXDubJGH2n7kKmfhMfTKgQaRe5Je6BBPcMexr2QhrVymd9e9vdCA5TOEJL156RTkcQ5wz4CTTANSkm7UiuPAUUjMhQO3H4UQygGIU7im95prs/31SY0i6yQil3Jzk/rq6fpDqrZvUh3t2Tg5w16pKxCvpdh4KoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=hNZOWcX3; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 09A0D100003;
	Tue,  2 Jul 2024 12:52:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719913947; bh=zivgzMCNQd/zVFarZ2SxkTXpeBtz2aMNAkA+qBWI4m0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hNZOWcX33q8Ds50Sv4Rn4agriI1Y+ZFoAsZUtRteaZR6fJp3lhlUpfh8wsYfxg9Ri
	 uIXfHeIYr1UCoIBx6eT6ovY776IX55o7tHC6MkrYyX4xNIbhEGuc2O3Tlr6HthmJ53
	 OpTuu5AL2/mPG/J7V5l+4RjrH00aGLuEbfrNs0N5GuIRG9X7tfpG9e1ZO1sHLJo28N
	 aVVJ9Kw17ZiMi47pxbH/EoNC0mFxrHdO8/BRuZFOinpBVsYUXDGls8YdJEZavkhFaI
	 6J3G+wjajosJt61AIY5hDxxzMpnxDkPTJmeTI7lB2aWeVpJWNE5zfsdA+To2AYB2Vt
	 r9fpmhHh4angg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 12:51:20 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 12:50:56 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Madalin Bucur
	<madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] fsl/fman: Validate cell-index value obtained from Device Tree
Date: Tue, 2 Jul 2024 12:50:34 +0300
Message-ID: <20240702095034.12371-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 186273 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/02 08:55:00
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
 drivers/net/ethernet/freescale/fman/fman.c | 7 +++++++
 drivers/net/ethernet/freescale/fman/fman.h | 2 ++
 drivers/net/ethernet/freescale/fman/mac.c  | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index d96028f01770..6929bca3f768 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2933,3 +2933,10 @@ module_exit(fman_unload);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Freescale DPAA Frame Manager driver");
+
+int check_mac_id(u32 mac_id)
+{
+	if (mac_id >= MAX_NUM_OF_MACS)
+		return -EINVAL;
+	return 0;
+}
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 2ea575a46675..3cedde4851e1 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -372,6 +372,8 @@ u16 fman_get_max_frm(void);
 
 int fman_get_rx_extra_headroom(void);
 
+int check_mac_id(u32 mac_id);
+
 #ifdef CONFIG_DPAA_ERRATUM_A050385
 bool fman_has_errata_a050385(void);
 #endif
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9767586b4eb3..7a67b4c887e2 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -247,6 +247,11 @@ static int mac_probe(struct platform_device *_of_dev)
 		dev_err(dev, "failed to read cell-index for %pOF\n", mac_node);
 		return -EINVAL;
 	}
+	err = check_mac_id(val);
+	if (err) {
+		dev_err(dev, "cell-index value is out of range for %pOF\n", mac_node);
+		return err;
+	}
 	priv->cell_index = (u8)val;
 
 	/* Get the MAC address */
-- 
2.30.2


