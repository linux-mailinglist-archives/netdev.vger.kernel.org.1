Return-Path: <netdev+bounces-296447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8yUgN8aSJmrGYwIAu9opvQ
	(envelope-from <netdev+bounces-296447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:00:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE6654CEF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:00:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="TQA+wL v";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296447-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066F930512AB
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE23B95EB;
	Mon,  8 Jun 2026 09:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F523B7B99;
	Mon,  8 Jun 2026 09:55:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912539; cv=none; b=oMGmg7UfaOT2924hiEtOdb9/8KTr6N6djmF2Sut1Hn1yrurPrSPzTsDp0Y7br/OabYfRDfEVFAz5UIWdvs6uyc+5pPBHsnBk0UrzaaZtNYS/JF/kNx+jgJhzQQRf/6Y5LXK6CS863cp8qhyQN3a8EihdL/aPAoVWYXhdvZTu1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912539; c=relaxed/simple;
	bh=qi0iXmLrGA5MmpVbUabr6e2D/HZTE+tUhQ1O691tJzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UeLQEID1v3oM3F4M8+tUFcO5w8P6ti3juswzLP/vg6c+jujrED8FPAqVdaR2dZvEYsd2506u4sci9M6fmKcssBV+HW5SB40PmZVBcq2ARxSmYBxCrOttISLlbmFENBqBcH2yP6Xjo1LXkbfgxYMMfK/3JouvPsVWmehGL2B9x2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=TQA+wLv4; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-00Br5i-BB; Mon, 08 Jun 2026 11:55:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=W/EkfW3VI0FHPtIAcOhbpaSxsRIFKdVu7Fogbx79KNU=; b=TQA+wL
	v4llDRyccSHJGvJzfsM8g7RzokE3LvnMfxaHvCYS0Qlyo8mLg61GcwjHow9PQJvTqv2f/lTIx6Qli
	pk8ZpOI6B8kvx7LI77cA8Bmduk0odtom6KGCAPw03nUzKZVwhgPBUCIApXne0OH6tfen/fpm5r4Lj
	p2R9wZDNq0PXDco2cmB86K7qPg4gBE1gCUUQYZ7t+f6UNgRCHg6ATp4H2tetjt9WSuDse2Z8BURar
	9NO52fv/UoqBo+vWZB1JrHeudS6ydbyuMa+Jae3gLTWkSEpFyxQpmrOY0wmYyb3joxwlhCRFWuJnu
	tYbuIB8HVKjmcDffMPV+wWcY/05A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhk-0000CW-1f; Mon, 08 Jun 2026 11:55:36 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhi-00Ag6G-Eq;
	Mon, 08 Jun 2026 11:55:34 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool: Use strscpy() to copy ethtool test names
Date: Mon,  8 Jun 2026 10:55:06 +0100
Message-Id: <20260608095523.2606-22-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:michael.chan@broadcom.com,m:pabeni@redhat.com,m:pavan.chebbi@broadcom.com,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,broadcom.com,redhat.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44BE6654CEF

From: David Laight <david.laight.linux@gmail.com>

The length must be specified (it is the size of the array element)
because a pointer to the array element is used to shorten the line lengths.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b14134d62d2..68e320285a08 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5542,18 +5542,19 @@ void bnxt_ethtool_init(struct bnxt *bp)
 		test_info->timeout = HWRM_CMD_TIMEOUT;
 	for (i = 0; i < bp->num_tests; i++) {
 		char *str = test_info->string[i];
+		int sz = sizeof (test_info->string[i]);
 		char *fw_str = resp->test_name[i];
 
 		if (i == BNXT_MACLPBK_TEST_IDX) {
-			strcpy(str, "Mac loopback test (offline)");
+			strscpy(str, "Mac loopback test (offline)", sz);
 		} else if (i == BNXT_PHYLPBK_TEST_IDX) {
-			strcpy(str, "Phy loopback test (offline)");
+			strscpy(str, "Phy loopback test (offline)", sz);
 		} else if (i == BNXT_EXTLPBK_TEST_IDX) {
-			strcpy(str, "Ext loopback test (offline)");
+			strscpy(str, "Ext loopback test (offline)", sz);
 		} else if (i == BNXT_IRQ_TEST_IDX) {
-			strcpy(str, "Interrupt_test (offline)");
+			strscpy(str, "Interrupt_test (offline)", sz);
 		} else {
-			snprintf(str, ETH_GSTRING_LEN, "%s test (%s)",
+			snprintf(str, sz, "%s test (%s)",
 				 fw_str, test_info->offline_mask & (1 << i) ?
 					"offline" : "online");
 		}
-- 
2.39.5


