Return-Path: <netdev+bounces-301807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oiIKJD57PGoyoggAu9opvQ
	(envelope-from <netdev+bounces-301807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:50:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B976C208D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="JgBKV9/b";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301807-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301807-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C29C30250A6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6B3655C0;
	Thu, 25 Jun 2026 00:50:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0E363C7C;
	Thu, 25 Jun 2026 00:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348603; cv=none; b=iRAd7UEGp+vXPinx/PJ1Z5T5StoAM3R0bZcuDIhnMl/GseFOV59OZJ3vjyPureKZc6eeAYvW1g+y/2YjPuY+EYW7pUaWOk8MhhVE1TsJMX2Q2x8olVwSsZPW4XgrITN6HkHs1ZNaQtd70OzDqjYeu1sjcf/K0TV/kTHjYjfjvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348603; c=relaxed/simple;
	bh=KjS8bjrLQ47IpSuAbKHQ+le1r6uhzYWGJ8jYhJyDc40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r9QYbvtR8h8E6/kZNylAf+AIMvBkzlWSa5dxndLtsCP6y2TkxDNHSYfqt3uE4P8e8JfX0i5/0Cym/GJs8BlLBmIfrM8SPUXl+GayBuRwRR5ACOwGlKE5JF3esE2MVcing3dvG+oDMj8jEaUpG0M/rUBfsMZ4Wj7fTE3G8GsN6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JgBKV9/b; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z9
	CihbKf0KMh5fxT6qRpFD+f2CqMulU+O29ueGod2rM=; b=JgBKV9/baABLk9fUbk
	gRoiaGvJnRa28BMov1+oQ1bnB2+Rl8YP6WzSNzCi/BQGFUYsg1IvOOfVJORijjzq
	fOlFVksgjz+wz7dFEe66HEnRauZVkqv5J7TVge5/dhrrJhq4STKaIvbBRILdOZv8
	zX1WvUyH0yMBo/d56+fOs32Wg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnvwTjejxqOTmnFA--.59108S2;
	Thu, 25 Jun 2026 08:48:37 +0800 (CST)
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
	stable@kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net v3] fsl/fman: Free init resources on KeyGen failure in fman_init()
Date: Thu, 25 Jun 2026 08:48:34 +0800
Message-Id: <20260625004834.3394389-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnvwTjejxqOTmnFA--.59108S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1rXryxCrWfKF45CrW5Awb_yoW8Gr4rpr
	W3K3y3CrW8Jry3G3ZrXw40yFW8ua1xKrWDWr9Iywnaq34ayr1UtF4xKrW8Wrn2vFWxWF43
	try7Zr1akFn8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR3UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQWB72o8euV9gwAA3Z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:florinel.iordache@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@kernel.org,m:pavan.chebbi@broadcom.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-301807-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,kernel.org,broadcom.com,debian.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5B976C208D

fman_muram_alloc() allocates initialization resources before
initializing the KeyGen block. If keygen_init() fails, the
function returns -EINVAL directly and leaves those resources
allocated. Free the initialization resources before returning
from the KeyGen failure path.

Fixes: 7472f4f281d0 ("fsl/fman: enable FMan Keygen")
Cc: stable@kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
 - Add "net" to patch title. Thanks, Pavan!
Changes in v3:
 - Drop the unrelated enable() cleanup from this fix. Thanks, Breno!
---
 drivers/net/ethernet/freescale/fman/fman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..299bab043175 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1995,8 +1995,10 @@ static int fman_init(struct fman *fman)
 
 	/* Init KeyGen */
 	fman->keygen = keygen_init(fman->kg_regs);
-	if (!fman->keygen)
+	if (!fman->keygen) {
+		free_init_resources(fman);
 		return -EINVAL;
+	}
 
 	err = enable(fman, cfg);
 	if (err != 0)
-- 
2.25.1


