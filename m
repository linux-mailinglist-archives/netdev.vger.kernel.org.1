Return-Path: <netdev+bounces-290033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qONsG0f7DWrO5AUAu9opvQ
	(envelope-from <netdev+bounces-290033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40955595D3F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F6CB30F40E4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23633D75C7;
	Wed, 20 May 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="g+cEPuc5"
X-Original-To: netdev@vger.kernel.org
Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141E3E832A;
	Wed, 20 May 2026 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300118; cv=none; b=i3u/2TSscBr5EUN/kLmEDCAI2IBm35uraxAt5eYkplo3BhGfN63g3zGzNSSzNST4vakYr5hLqELDjuMCamKe+RumhEFgXyHOgQJxY5deDwZaxv28lCGO1cefXtYQ4qv5NfOI421YpxN7Zjtl0a8livnY9rTpp69QQFZ3lUAZhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300118; c=relaxed/simple;
	bh=YBNCoG2jLUjM4gI3YmiFrwZgnVARktZfsQJ6Af8Z1Dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MAsMER73go+bTnMRzSGeYHljEAlM2Pu6lymV7nIk4PVhD5SPCRgOkGiJ7lxfflGvxU0w0pJSI6ugg49ASr1dwUzSuxHIXM36h5ng1d1DPWhKxbiS5vC5ULLr4rOwNfYpkL3IpG1z0znEjtmXA1KAYgnZdtsc4NSNn+88ucXKRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=g+cEPuc5; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=YBNCoG2jLUjM
	4gI3YmiFrwZgnVARktZfsQJ6Af8Z1Dc=; h=date:subject:to:from;
	d=al2klimov.de; b=g+cEPuc5oWcNG3PmiT9C72lxLwT0NWYwYIAhvNno/yMGVkkn55QR
	Ar2YTcs7SxFsAlOJh0xuYEE4lfjS+PfSMxrFV45QiG6CXfrb0tWd+ZFFHSVnXrnlKD81f2
	ykMa+d7RMEJgOJypsgxA6jHuVfV0r7joRJN0HVOeR5OwspeK6/C0DDF4lJGseVD5wtJ/Mi
	5cvcfG3RDePwIkO+Gw0PbQu3iLxpnim23d9lwbZloNBR47Q3do/scUF8J0ZNhAaKBN1WqP
	Kl7RWv7f0p+0INNWDUY+pa2El5c4G8pVZ9B39FkuqMv7S4GyyfEPN9WuucHf2Ef0Gnq1Fc
	d56qlrnucA==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 317324e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 May 2026 18:01:55 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Tobias Regnery <tobias.regnery@gmail.com>,
	netdev@vger.kernel.org (open list:ATLX ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: alx: fix possible buffer overflow
Date: Wed, 20 May 2026 20:01:35 +0200
Message-ID: <20260520180140.538826-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[al2klimov.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[al2klimov.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,al2klimov.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290033-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grandmaster@al2klimov.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[al2klimov.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[al2klimov.de:email,al2klimov.de:mid,al2klimov.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40955595D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In alx_request_msix(), use snprintf(DST, sizeof(DST), ...)
and not sprintf(DST, ...) to never write more than sizeof(DST) bytes.

Fixes: e0eac2546090 ("alx: prepare interrupt functions for multiple queues")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/net/ethernet/atheros/alx/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index ab262e66f986..d2697d9eacfa 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -865,16 +865,17 @@ static int alx_request_msix(struct alx_priv *alx)
 		vector++;
 
 		if (np->txq && np->rxq)
-			sprintf(np->irq_lbl, "%s-TxRx-%u", netdev->name,
-				np->txq->queue_idx);
+			snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-TxRx-%u",
+				 netdev->name, np->txq->queue_idx);
 		else if (np->txq)
-			sprintf(np->irq_lbl, "%s-tx-%u", netdev->name,
-				np->txq->queue_idx);
+			snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-tx-%u",
+				 netdev->name, np->txq->queue_idx);
 		else if (np->rxq)
-			sprintf(np->irq_lbl, "%s-rx-%u", netdev->name,
-				np->rxq->queue_idx);
+			snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-rx-%u",
+				 netdev->name, np->rxq->queue_idx);
 		else
-			sprintf(np->irq_lbl, "%s-unused", netdev->name);
+			snprintf(np->irq_lbl, sizeof(np->irq_lbl), "%s-unused",
+				 netdev->name);
 
 		np->vec_idx = vector;
 		err = request_irq(pci_irq_vector(alx->hw.pdev, vector),
-- 
2.54.0


