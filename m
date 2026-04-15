Return-Path: <netdev+bounces-278770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK3fAMKN32l5VAAAu9opvQ
	(envelope-from <netdev+bounces-278770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F8404AC9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E60D309ECBF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0538A72B;
	Wed, 15 Apr 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ll4+zFs4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6538A29A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258201; cv=none; b=AW6muSdTtVpgORn/EM+oY2v0TwiAEG3LTksJc7NDFkX1M7QBYGSiEj7+R55pLTqSxXjdwgQDRu75rOxLRLUhsX5dgvye68uGM2jfDu91/rDh7KbTKDFR5fELdnEDMbBrGMw/d9Y8BU+IeLeoyGv3qjSyF00oqE2L4Ct3y2I6S64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258201; c=relaxed/simple;
	bh=sbEgJoIQrDI51cDybI635FZDGN+pqj6j2mC77Xzsgeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ju3wLEfHQpRvj8qjprwNUyz5At/vqb0Vuin+nEhaH/WLju9z9fp0GrLK1nRM3zNF1TX0hg9IvC6+g52GqLc+/w63LB6O2Zi6Fo17tlbweJZTUN6EM8dm2VbnNBN4eKIpufjpqnPijmpLncxJYPH0aBUPWSc/dXsaHzBjMf8+DLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ll4+zFs4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A77161A32D9;
	Wed, 15 Apr 2026 13:03:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6501A60420;
	Wed, 15 Apr 2026 13:03:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D242110451AC4;
	Wed, 15 Apr 2026 15:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776258191; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=aPR1TWodNx5RYWHwu3ZdmoXUly8UeFqfQ8nq2inuZX4=;
	b=Ll4+zFs4/AyS2qTq+ibkW4oXZP3ruJH2DAac8VIr8OJ0YsslE1xUWiB1jq+L5ffimKvC3h
	JWnxYCXrzVELJw+fRcU0h0dVJsGA/xsn1YplhQmLV3+wzQhONEOENhOXZsrpgY+TncuSsc
	GAD5Lc3Gdt5qsiieulPs5Ny3l28/CrMU6ZH1pGWCsgrddnW9pPaSh17SQWedyMfCdirC81
	NyCMyxx+NtE0uBqxQfEP+7Y73928DjyXAFIKmr0NWqEmvDL7bml9hrRBu9f7wF925cIu8K
	FplAuTYsUdJb/I6DYSVGtz4HHTfq888TkI3gXTJOU+HLJ0uusDJVFf+3IP280g==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Carlo Szelinsky <github@szelinsky.de>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2] net: pse-pd: fix out-of-bounds bitmap access in pse_isr() on 32-bit
Date: Wed, 15 Apr 2026 15:02:59 +0200
Message-ID: <20260415130300.806152-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278770-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 683F8404AC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In pse_isr(), notifs_mask was declared as a single unsigned long on the
stack (32 bits on 32-bit architectures). For PSE controllers with more
than 32 ports, this causes two problems:

- map_event callbacks could wrote bit positions >= 32 via
  *notifs_mask |= BIT(i), which is undefined behaviour on a 32-bit
  unsigned long and corrupts adjacent stack memory.

- for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) treats
  &notifs_mask as a multi-word bitmap and reads beyond the single
  unsigned long when nr_lines > BITS_PER_LONG.

Fix this by moving notifs_mask out of the stack and into struct pse_irq
as a dynamically allocated bitmap. It is sized with
BITS_TO_LONGS(pcdev->nr_lines) words in devm_pse_irq_helper(), so it
is always wide enough regardless of the host word size.

Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Use devm_bitmap_zalloc() instead of devm_kcalloc().
---
 drivers/net/pse-pd/pse_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f6b94ac7a68a4..87aa4f4e97249 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1170,6 +1170,7 @@ struct pse_irq {
 	struct pse_controller_dev *pcdev;
 	struct pse_irq_desc desc;
 	unsigned long *notifs;
+	unsigned long *notifs_mask;
 };
 
 /**
@@ -1247,7 +1248,6 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
 static irqreturn_t pse_isr(int irq, void *data)
 {
 	struct pse_controller_dev *pcdev;
-	unsigned long notifs_mask = 0;
 	struct pse_irq_desc *desc;
 	struct pse_irq *h = data;
 	int ret, i;
@@ -1257,14 +1257,15 @@ static irqreturn_t pse_isr(int irq, void *data)
 
 	/* Clear notifs mask */
 	memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
+	bitmap_zero(h->notifs_mask, pcdev->nr_lines);
 	mutex_lock(&pcdev->lock);
-	ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
-	if (ret || !notifs_mask) {
+	ret = desc->map_event(irq, pcdev, h->notifs, h->notifs_mask);
+	if (ret || bitmap_empty(h->notifs_mask, pcdev->nr_lines)) {
 		mutex_unlock(&pcdev->lock);
 		return IRQ_NONE;
 	}
 
-	for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) {
+	for_each_set_bit(i, h->notifs_mask, pcdev->nr_lines) {
 		unsigned long notifs, rnotifs;
 		struct pse_ntf ntf = {};
 
@@ -1340,6 +1341,10 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
 	if (!h->notifs)
 		return -ENOMEM;
 
+	h->notifs_mask = devm_bitmap_zalloc(dev, pcdev->nr_lines, GFP_KERNEL);
+	if (!h->notifs_mask)
+		return -ENOMEM;
+
 	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
 					IRQF_ONESHOT | irq_flags,
 					irq_name, h);
-- 
2.43.0


