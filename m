Return-Path: <netdev+bounces-232613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CEC073CA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F07E0562A31
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06885333746;
	Fri, 24 Oct 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="SxFIz63W";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="RvYaiQ02"
X-Original-To: netdev@vger.kernel.org
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBA1D61BC;
	Fri, 24 Oct 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322415; cv=none; b=dkFaq9SaFDkHV9WUxmSPad4rwTPNAb/KYClmhPiNHwk11B6mp5+hi3mBjYVIG125eA5W7iFncFui6r6rfeLryRc/3z/1kHO1PgkfmBu9ILGpRiggOjLmrrJjL/iPauDW47LW6g6UFzcgppum2nhWdwe+BAtqPC15Lm30OkiGS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322415; c=relaxed/simple;
	bh=8ERzwQyhedL+q7VdDwzFN6oxf1r6ylHaPJoOZKcRg1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGW+Tv4BOtlCf/QdQa+i+f3+zrXNB1rxylzUyu4Sk59ZkFQqLq+79xwMdZ4SNlBKiXwvmfH8/Q5FjH8Gim/sJwZeGCr8QuuHDkF5RxW7sZ8P2mZaFpmTPBJaEsPAx0J7N/P6MVZf7SMYBeAdDvkxYcq86x7qHJLg/Ax0xDwWfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=SxFIz63W; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=RvYaiQ02; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761322404;
	bh=py74iKW7Qy3dzd3gMjjD4ryhlSUGjzcDQYksVPouOZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=SxFIz63WL+YZ1vZEt1eLjhQVdfjPZsTeulIGCee//IfFU5t/B2HFauBq/o7qaOJG6
	 VUXXWTAjzKfJVn7XKgfMHYUeG7WLm6KmfUVKebaXlnQh+tRBT5WHimSwEiUEMJNmNj
	 iPcYYmfd1IgXxRdnk1Auun7BRuZ+6VOe/4Ie3UpAj1tFhAjemIm9ReW9MNjW3gZJ/D
	 M64utWJohz75yDrkyfIbwhDoK1MOQCPsU9a0pf02hY/ezXX4gKUg78bMiYIS1SqSny
	 Ct9s5hrAT/TtzUW4JFGphtjuaj823wNT8Xc6BkgeN/5JTgf49nGPEhD4npisQP292F
	 o16+Omu1DaJNg==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 4622DE80D50;
	Fri, 24 Oct 2025 19:13:24 +0300 (MSK)
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx12.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id E0F8AE8035C;
	Fri, 24 Oct 2025 19:13:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761322394;
	bh=py74iKW7Qy3dzd3gMjjD4ryhlSUGjzcDQYksVPouOZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RvYaiQ02gSU+w9FVm2RXwF9Ml1EAutGhGXp19MRLKSA5E8LCJ6h1jvrhqzovk63fJ
	 wqfCbyGNb0PhTK8mwz1mOgBlNzZDqG1/18V1RAiK+Z4zdsOzbJmwo7JTWegEzLShii
	 VR47rRnoSUImTdf/4SWk+sA3d8L4nbokIL/nfVpbRSAmRBtZNQhsIy4HHNcG2NiTtN
	 +3hfhs9V8oUQlo0dDThrKRTatu3oS63fNFHk9zEbtlI0wpw5JN7Zzqk2KR1XPtvjjD
	 /22se4DNJT5ESP5i3rARua6Pm9mRhy/tRvPcPQv1orwlWItzU7XC6trozFTMakNDLI
	 nnKlib0/QFczg==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id B0C475A4AE7;
	Fri, 24 Oct 2025 19:13:14 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id D57CD5A4AEC;
	Fri, 24 Oct 2025 19:13:10 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 19:13:10 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Paolo Abeni
	<pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>, Harsh Jain <harsh@chelsio.com>, Atul
 Gupta <atul.gupta@chelsio.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Ganesh Goudar <ganeshgr@chelsio.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v4] net: cxgb4/ch_ipsec: fix potential use-after-free in ch_ipsec_xfrm_add_state() callback
Date: Fri, 24 Oct 2025 19:13:02 +0300
Message-ID: <20251024161304.724436-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/24/2025 16:03:08
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197432 [Oct 24 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;kaspersky.com:5.0.1,7.1.1;lore.kernel.org:7.1.1;zhigulin-p.avp.ru:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/24/2025 16:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/24/2025 3:14:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/24 15:00:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/24 12:21:00 #27794049
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/24 15:50:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

In ch_ipsec_xfrm_add_state() there is not check of try_module_get
return value. It is very unlikely, but try_module_get() could return
false value, which could cause use-after-free error.
Conditions: The module count must be zero, and a module unload in
progress. The thread doing the unload is blocked somewhere.
Another thread makes a callback into the module for some request
that (for instance) would need to create a kernel thread.
It tries to get a reference for the thread.
So try_module_get(THIS_MODULE) is the right call - and will fail here.

This fix adds checking the result of try_module_get call

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6dad4e8ab3ec ("chcr: Add support for Inline IPSec")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
v4: Add module_put() on allocation fail after try_module_get() as 
    Jakub Kicinski <kuba@kernel.org> noticed during review. Thanks!
v3: Move the try_module_get() check above the code that initializes
    the sa_entry struct, as suggested by Paolo Abeni <pabeni@redhat.com>
    during code review.
v2: Remove redundant headers. Provide better description.
v1: https://lore.kernel.org/all/20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com/
 .../ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index ecd9a0bd5e18..49b57bb5fac1 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -290,9 +290,15 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 		return -EINVAL;
 	}

+	if (unlikely(!try_module_get(THIS_MODULE))) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire module reference");
+		return -ENODEV;
+	}
+
 	sa_entry = kzalloc(sizeof(*sa_entry), GFP_KERNEL);
 	if (!sa_entry) {
 		res = -ENOMEM;
+		module_put(THIS_MODULE);
 		goto out;
 	}

@@ -301,7 +307,6 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 		sa_entry->esn = 1;
 	ch_ipsec_setkey(x, sa_entry);
 	x->xso.offload_handle = (unsigned long)sa_entry;
-	try_module_get(THIS_MODULE);
 out:
 	return res;
 }
--
2.43.0



