Return-Path: <netdev+bounces-228698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB16BD2688
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47FB4F0096
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6E2F8BF5;
	Mon, 13 Oct 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="UC0Pss1o"
X-Original-To: netdev@vger.kernel.org
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5D1946AA;
	Mon, 13 Oct 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349502; cv=none; b=IYJ0jxsd/9mmi034h4PrDErWaDgSAbqxfzSGlaf8U8jOJhbk6xahl73QsUodGM258Pof4AquvKoyd5V4NkZXzPcLIzwelHx1fZ3wo7NgOfzsD3c/E8DaVOrK0631et4oNXPDRLY44Sfxutj+exb9sj7eW3Tj4geQp25kvQoaIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349502; c=relaxed/simple;
	bh=4X5mXs/MVhTxkA6z8UTMPefgBsp+QyTrtiNs+qT/IEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M+6407MnavoVTkegamnoh5pSaHIxddvaRXX82ustaFbXnEN7o7tnaxKZwZv2bsUGsXNdli4ELQXS0W3UgaNCwpziqRUXdNXxaJ67H35zPijcQWoTGvnsBvpFmgVWoCPFhDJPvVQSHcZ40QapNebhB+HZfuUQQHJYSNEaUz72g8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=UC0Pss1o; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1760349492;
	bh=/nGgE73c7kKM2M4s3vTGnNGSNQsMklwH02IcUOgrV2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UC0Pss1oG/LHZa7F16nmuCqYkGE2Qu0E466f0RZfrIwBLMI7B4mxa6L3kA8OffsWU
	 efyI77A/vUffNFhWsoWRVc/X5YzM8w/2RyOXzuItcKnEXRGZT/DrPNXMy5XYDo1RNx
	 VQ6UVdK3AR6B/wtfHALQgguZYo/C5vxNtT92w+lf1Mqsirlw19Ffk6V/6D55BPUb1h
	 Rn7X1l9mX3q+KPGtQO1uit59bF6SinxIxZYgQFz/ycLKFLuvjD4WtPpPra/w28J0/x
	 m9jSHtQ9r0Ka1OZ1HA3FLEq5PPPFn9tCH282zQ8eLqxbAqeFyR6teHDxY+Rxh8TllC
	 yyMttgbkiYZcw==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 894835A17B9;
	Mon, 13 Oct 2025 12:58:12 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 5D1795A16CF;
	Mon, 13 Oct 2025 12:58:10 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 12:58:09 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Zhu Yanjun
	<yanjun.zhu@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>, Harsh Jain <harsh@chelsio.com>, Atul
 Gupta <atul.gupta@chelsio.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Ganesh Goudar <ganeshgr@chelsio.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net v3] net: cxgb4/ch_ipsec: fix potential use-after-free in ch_ipsec_xfrm_add_state() callback
Date: Mon, 13 Oct 2025 12:58:08 +0300
Message-ID: <20251013095809.2414748-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/13/2025 09:40:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197021 [Oct 13 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 71 0.3.71
 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: lore.kernel.org:7.1.1;kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;zhigulin-p.avp.ru:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/13/2025 09:46:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/13/2025 8:20:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/13 09:46:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/13 05:48:00 #27908488
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/13 09:46:00
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
v3: Move the try_module_get() check above the code that initializes
    the sa_entry struct, as suggested by Paolo Abeni <pabeni@redhat.com>
    during code review.
v2: Remove redundant headers. Provide better description.
v1: https://lore.kernel.org/all/20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com/
 .../ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index ecd9a0bd5e18..0eff5abe0ca5 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -290,6 +290,11 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
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
@@ -301,7 +306,6 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
 		sa_entry->esn = 1;
 	ch_ipsec_setkey(x, sa_entry);
 	x->xso.offload_handle = (unsigned long)sa_entry;
-	try_module_get(THIS_MODULE);
 out:
 	return res;
 }
--
2.43.0


