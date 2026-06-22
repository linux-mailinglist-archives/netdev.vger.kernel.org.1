Return-Path: <netdev+bounces-301061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMJAMeEZOWp6mwcAu9opvQ
	(envelope-from <netdev+bounces-301061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C11DA6AEFE1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:17:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=h4iSzb6E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301061-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301061-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD95F302E30D
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA637A48D;
	Mon, 22 Jun 2026 11:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608028CF6F;
	Mon, 22 Jun 2026 11:17:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127060; cv=none; b=AImK0rwgBhxevo/va63lkgGLJpww2GtHgbwfL1ZypZLsyiIZ5yB4AjsGIOK7kPoH94pdVrWsQ3HFvUXhKTcrXlk534IQItRZtT3ujd54tu7ppUhke4Gpgf4HHMdTomjoB9k353v348rpojG1cLO62yS/Ce7DMfqs9demXtWXORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127060; c=relaxed/simple;
	bh=0JuUvxOK9qSQ8lIrhurl6d7+7wG09ok1+E2/4hVjXcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJJ+M4aFLIoIz9HuhkLI01/yUuBbGCyMmk62qA98S2VrINe2vTAG8/45I28LT2iRsBw8GFeGmmtedpzuUtHnLWTNrhww6OwzwVWfeKlmHKwpWHZNLckqK2+keByPpPKwAgu1qM6Di+ubaiUkSt38bZZwTxuFYCcDIrR90lJhzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h4iSzb6E; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tK
	9MfZvggUrMaoHXSIR9WNzTOOGQS5zd5mZgqd7Ab4Q=; b=h4iSzb6EFevOHSzEYD
	HWN47GC96uPQoLsiKyRmI8TyRSIrlsfp+skAOQxhKnFUMqgF7gGgSjaYhsLdcAxp
	faAIZEnu9R5/ZdenFoR8/BOnNSKpIjkho2eDzepRWQtLEVYcEAH/Uq48OBgRCY3g
	xCILFU1XqZ0n0Jr96Sn35iL3w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3ZWCWGTlqlPdvFA--.18479S2;
	Mon, 22 Jun 2026 19:16:40 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: madalin.bucur@nxp.com,
	sean.anderson@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florinel.iordache@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@kernel.org
Subject: [PATCH] fsl/fman: Free init resources on KeyGen failure in fman_init()
Date: Mon, 22 Jun 2026 19:16:38 +0800
Message-Id: <20260622111638.997251-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3ZWCWGTlqlPdvFA--.18479S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr43Wr4xJF1rXF4DJF1DJrb_yoW8JrW8pr
	WxK3yYkr48trWfGwnrJw40yFyYyw4xtryDWrnrWwsavw1ayr1jqr48GrW8Wr1IqFZ7ZF1Y
	qryUZr4akFn8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hhVw2o5GZgmwAAA3U
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:florinel.iordache@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-301061-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C11DA6AEFE1

fman_muram_alloc() allocates initialization resources before
initializing the KeyGen block. If keygen_init() fails, the
function returns -EINVAL directly and leaves those resources
allocated. Free the initialization resources before returning
from the KeyGen failure path.

While at it, drop the unused error check around enable(), which
always returns 0.

Fixes: 7472f4f281d0 ("fsl/fman: enable FMan Keygen")
Cc: stable@kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..3a2a57207e55 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1995,12 +1995,12 @@ static int fman_init(struct fman *fman)
 
 	/* Init KeyGen */
 	fman->keygen = keygen_init(fman->kg_regs);
-	if (!fman->keygen)
+	if (!fman->keygen) {
+		free_init_resources(fman);
 		return -EINVAL;
+	}
 
-	err = enable(fman, cfg);
-	if (err != 0)
-		return err;
+	enable(fman, cfg);
 
 	enable_time_stamp(fman);
 
-- 
2.25.1


