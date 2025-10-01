Return-Path: <netdev+bounces-227468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04543BB01DA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65229188E0D3
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0492C0290;
	Wed,  1 Oct 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="idQyanWl"
X-Original-To: netdev@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88D15C158;
	Wed,  1 Oct 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317429; cv=none; b=anIhLDEku3Q30pp5x80/XkG3/+Aag/wegNzGj9l1rczdfD+STvSffW/NhiJGMwRM7btagGNBV67dLFlS339fm6e0z9c2LkWLQJXihpVTpwj7OYK7Ibcba+Pxd6/7dEhY1kjMSEH967ibJ7papXFOA/5LRc+U+hbs1HKqphPPL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317429; c=relaxed/simple;
	bh=niZcM15/aM2MHoBvHoPHQLRuvWK0disCzNRRmfsO2Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUBBeRld8x1F6j10H1sY2mQUGQc88sOrGYECuxhyyvDOIf6ouKpVYeZF7FpxVgpTKLfBCgtoJqxPVtMrmDXsTx0OXBqS1WAUzaWtvSh8eCH9PdDEIXcA5RR/5kJUDsaely3OBH9mhqd9fIdlEMEoCR5VNvFCziy5fWhSonra+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=idQyanWl; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759317425;
	bh=zDsXdTX+O9NGT9chMSJOKcjuCs1HpuSIsAqYU7ZmRWc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=idQyanWl32Fu0h+kd6dqIXG+6U1iE9f4xkV0jHmVOIQc6DVET9dyx7ihZKeDpflEy
	 2Cptu0WOSgzoQWJLQ7pFUgQki0LioIB7hy8hLa7gsWIDhfnxqWwbukFh4UWzRJ5Q4d
	 E2dEPdWqMUOo+NLlrvOAcHJn602SJcDSHOhK5W67L+5P+HgP68Bvh4+qHVEUzXG2lS
	 /PgfZ4PpYaU6+3DZ+m2n4vx2uVWrXTGz5aaTCpJdLbmSZ4P284ULiWRWHzB3hkdzL8
	 n7+qN3M1LR9/iX/iFdmdf9Gu5MJytCOaVVhi03ClkSogzBvjYJ5AdHySLdG0DZ0z2w
	 lh8j3ban4iFxA==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 105C43E1F09;
	Wed,  1 Oct 2025 14:17:05 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 089FB3E2127;
	Wed,  1 Oct 2025 14:17:02 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 1 Oct
 2025 14:17:02 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Ayush Sawal <ayush.sawal@chelsio.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Leon Romanovsky <leon@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, Zhu Yanjun
	<yanjun.zhu@linux.dev>, Harsh Jain <harsh@chelsio.com>, Atul Gupta
	<atul.gupta@chelsio.com>, Herbert Xu <herbert@gondor.apana.org.au>, Ganesh
 Goudar <ganeshgr@chelsio.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] net: fix potential use-after-free in ch_ipsec_xfrm_add_state() callback
Date: Wed, 1 Oct 2025 14:16:43 +0300
Message-ID: <20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/01/2025 11:10:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196735 [Oct 01 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 68 0.3.68
 1da783151ba96b73e1c53137281aec6cc92e0a0f
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:5.0.1,7.1.1;kaspersky.com:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/01/2025 11:11:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/1/2025 10:17:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/01 07:34:00 #27871058
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

In ch_ipsec_xfrm_add_state() there is not check of try_module_get
return value. It is very unlikely, but try_module_get() could return
false value, which could cause use-after-free error.

This fix adds checking the result of try_module_get call

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6dad4e8ab3ec ("chcr: Add support for Inline IPSec")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 .../net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index ecd9a0bd5e18..3a5277630afa 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -35,6 +35,8 @@
  *	Atul Gupta (atul.gupta@chelsio.com)
  */

+#include "asm-generic/errno-base.h"
+#include "linux/compiler.h"
 #define pr_fmt(fmt) "ch_ipsec: " fmt

 #include <linux/kernel.h>
@@ -301,7 +303,8 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 		sa_entry->esn = 1;
 	ch_ipsec_setkey(x, sa_entry);
 	x->xso.offload_handle = (unsigned long)sa_entry;
-	try_module_get(THIS_MODULE);
+	if (unlikely(!try_module_get(THIS_MODULE)))
+		res = -ENODEV;
 out:
 	return res;
 }
--
2.43.0


