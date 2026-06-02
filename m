Return-Path: <netdev+bounces-294106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAVtK1miHmquDAAAu9opvQ
	(envelope-from <netdev+bounces-294106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:28:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EF62B909
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D21FA3003BEF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523363C988D;
	Tue,  2 Jun 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CFuWOYj7"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B87243964
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392530; cv=none; b=esDGMobej6yNp9VVMipt/rAQt98/Prk9CTbXMaivq2jopdIVLvConQu9ndGSF0SKWLqJdmueaC3fs1JgAUF2N3pxR7e1lc3WDVp0/u6qaDatmq4YMlQqBcfhcyiRo6dr176eKQBCilWLdDDY5NOojElkzSKI5n9//Y/X406FGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392530; c=relaxed/simple;
	bh=6hEleVb1Oe+t+M0Hx2yGJjztabDWlGD+LDyquRFvwDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pz8EXYTcsA5tx8MMWtzci1M+LcOPa3+B45vJ8XtG2HNEF7VaGku2Bzqn6aCA99pDevTwLVunl1M1oU1dzMPC5Z70m6pcbEH0y58n3mu5J2TLlsSbRjKU5Z7L/Z9Ysj51k/vnuYDhb9jli4pH6sAyBLYGF93eCZ4jXfJ2b7aNgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CFuWOYj7; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+n
	YtOLGFgegoMdTyedhHhyE/lmxYyMUDcJ/IpYpqvU8=; b=CFuWOYj7AslSUwH5qr
	xRlfiQF39xJ96PoCFDOPKsrVLDeftg2lX7mdKo62gfwgFZK9qkLEaqE78JB/aW6P
	Gpeqk4fRm7eQYD0krcnt7cxsyuh2ki4bkg3ZGiRJ8e95DieqdXw8QRjp2cS09KPT
	t087wWCgQ2teU7OQRZl3vbb5Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBncAAnoh5q1UKGAw--.10S2;
	Tue, 02 Jun 2026 17:28:12 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: kuba@kernel.org,
	sukhdeeps@marvell.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: atlantic: aq_utils_obj_{set|clear} optimizations
Date: Tue,  2 Jun 2026 17:29:49 +0800
Message-Id: <20260602092949.263270-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBncAAnoh5q1UKGAw--.10S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWkGFW3tF45KrykWFy8Krg_yoW8GFyfpa
	18XF98uaykWF1UXayktw4rJ398Ja4IyrWY9rW5Kw15ZrZxKF47G3s5tFWaqr1qyr4rZF17
	AF43AF9IkFsrGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UviiDUUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7wzVI2oeoizVEQAA3r
X-Rspamd-Queue-Id: B17EF62B909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhulei_szu@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Action: no action

From: Lei Zhu <zhulei@kylinos.cn>

Adopting atomic_try_cmpxchg() which is slightly more efficient.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
 drivers/net/ethernet/aquantia/atlantic/aq_utils.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_utils.h b/drivers/net/ethernet/aquantia/atlantic/aq_utils.h
index d3a0b2ec0279..61cd08771385 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_utils.h
@@ -15,20 +15,20 @@ static inline void aq_utils_obj_set(atomic_t *flags, u32 mask)
 {
 	unsigned long flags_old, flags_new;
 
+	flags_old = atomic_read(flags);
 	do {
-		flags_old = atomic_read(flags);
 		flags_new = flags_old | (mask);
-	} while (atomic_cmpxchg(flags, flags_old, flags_new) != flags_old);
+	} while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
 }
 
 static inline void aq_utils_obj_clear(atomic_t *flags, u32 mask)
 {
 	unsigned long flags_old, flags_new;
 
+	flags_old = atomic_read(flags);
 	do {
-		flags_old = atomic_read(flags);
 		flags_new = flags_old & ~(mask);
-	} while (atomic_cmpxchg(flags, flags_old, flags_new) != flags_old);
+	} while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
 }
 
 static inline bool aq_utils_obj_test(atomic_t *flags, u32 mask)
-- 
2.25.1


