Return-Path: <netdev+bounces-302639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ER6AD5xQmpx7QkAu9opvQ
	(envelope-from <netdev+bounces-302639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:21:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B36DB19D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=npc-ksb.ru (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302639-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4584630A7E6D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1F405844;
	Mon, 29 Jun 2026 13:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517D3FD946;
	Mon, 29 Jun 2026 13:08:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738540; cv=none; b=gNdpFzTsrkjckvyo2ZUqc8lrpmfh4Q3F1p6XANgNox9p9AlsaGYtnGzAxyhEK+7Cfo8K3Pbz50eBk7LYzPWzDsQ/SD0lI8uKlFQsz47zmsK+YEpdElxl60B5wP7/kHa0wsuxWoBfiJS8rDuES1us5T7LiGb9hxu0zsS04aq/csA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738540; c=relaxed/simple;
	bh=7zxT35iZfYUloVfdIN1A2Tchq2YZbtpf3iKeNzj5wWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZDfj1QlbwW1qJt9TJ+Ke274N/5U1NBBAfVXpHf3bI18pNPTdei0YvrXNFdEveqvTP3TKUiCaODFrh850sw1V+g22a+lo3mOxaceeD1HIgDGH44opOUFpSKwdoWF/6L7f0S/iPWI71XHv65NS2VLNa1994EpXkWNeENuyN3BXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru; spf=pass smtp.mailfrom=npc-ksb.ru; arc=none smtp.client-ip=5.167.76.63
Received: from ksb-289.ksb.ksb-soft.ru (unknown [10.38.22.14])
	by mail.ksb-soft.ru (Postfix) with ESMTPA id 4gpmnP35PQz4LJWR;
	Mon, 29 Jun 2026 16:08:57 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Gleb Markov <markov.gi@npc-ksb.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	lvc-project@linuxtesting.org
Subject: [PATCH net] cxgb4: Fix decode strings dump for T6 adapters
Date: Mon, 29 Jun 2026 16:08:54 +0300
Message-ID: <20260629130856.1168-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427, bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[npc-ksb.ru : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302639-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bharat@chelsio.com,m:markov.gi@npc-ksb.ru,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,npc-ksb.ru:email,npc-ksb.ru:mid,npc-ksb.ru:from_mime,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 796B36DB19D

From: Gleb Markov <markov.gi@npc-ksb.ru>

Depending on the value of chip_version, the correct decode set is selected.
However, the subsequent matching with the t4 encoding type in the if-else
block results in a reassignment, which leads to the loss of support for
t6_decode as well as reinitializing of values t4_decode and t5_decode.

The component history shows that the if-else block previously used for
this purpose, as well as the execution order, was not affected by the
change.
Furthermore, it is suggested by the execution order that the scenario with
overwriting and loss of support will be implemented.

Delete the if-else block.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6df397539cb0 ("cxgb4: Update correct encoding of SGE Ingress DMA States for T6 adapter")
Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 8d719f82854a..f3e8153a7a0b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -6735,14 +6735,6 @@ void t4_sge_decode_idma_state(struct adapter *adapter, int state)
 		return;
 	}
 
-	if (is_t4(adapter->params.chip)) {
-		sge_idma_decode = (const char **)t4_decode;
-		sge_idma_decode_nstates = ARRAY_SIZE(t4_decode);
-	} else {
-		sge_idma_decode = (const char **)t5_decode;
-		sge_idma_decode_nstates = ARRAY_SIZE(t5_decode);
-	}
-
 	if (state < sge_idma_decode_nstates)
 		CH_WARN(adapter, "idma state %s\n", sge_idma_decode[state]);
 	else
-- 
2.43.0


