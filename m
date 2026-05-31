Return-Path: <netdev+bounces-293373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GMHH3ObG2pWEgkAu9opvQ
	(envelope-from <netdev+bounces-293373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 04:22:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C326143B4
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 04:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50F703003D20
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E01B4156;
	Sun, 31 May 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeMo4PFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F15194A6C
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780194159; cv=none; b=KB7DPYXN/Q/WKVTZWWiaJE+QgP+hTCfnD0OhW2HAxL9NJLWLbK5c26nbL7xw9nxXs04Q7zsSi5/4WKqWpP01CPEJvc0ilu82goB2Ky/Nv+S2mzkLthR22HVo3+B4ngMtp81TJ9sV/I9CZmOW6JGJGQ/dipU5aCic+TIWZou1CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780194159; c=relaxed/simple;
	bh=cW27X/qs8nPmYocEmOprbNiNOpAaiqTRwBkoXCq9sg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE7pAHi++HTg3HlQdw002i7zHCcUUJ2KzNRd5nGYOhxID5ZivIINoamrOgw4t7MWje6ntZrHyRL/uikRdgDk8hFXBEyzyPh2z+FreAzCRi/1neI0Y0rxCGXUZsIEjVnafXoWU2dsZB4HAsAN0gic14O3mh9dF1pbBLkPlu1NHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeMo4PFK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so1509650a91.1
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 19:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780194158; x=1780798958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zdMO1aum1o0cEFtC+dVHwvB8dCMTjDC9zp/l6WfwTQ=;
        b=QeMo4PFKR4BC/IiHYR5jAfiZ2p9de4ZKyp5qvdAFyx5VJ0GL5eq3Nodk4QKaNhggoI
         H7gV2v1zDzHdWAwHbma69l+fs2kl6pMkCV3rAq10NzsU1KCkyHN0P11i/S5eoQ8g/Of9
         I9XEVC2r+bTjREoAvr3OGZmTkb2sIIgyixOIBM7v/BVyPgKchFS+mjs+ZWjHFghWByY5
         RveZmI3YSM6ESoN5bziiih6oa/Fp6wWPP+QA6WEqeANh3OTPgYWVHw+1icfu/fpjX3PY
         TLiGcshk5oQBrj6bPXNJURRPPubqUc8OKNziFWoqhHbDo7e4oyznGq/ibhCByTXQOPR5
         hw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780194158; x=1780798958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zdMO1aum1o0cEFtC+dVHwvB8dCMTjDC9zp/l6WfwTQ=;
        b=gb/Vyh2kKBD5y/f576JKaNymjYgSotWg3wD3Ibw5rqgoyVCCtHRay3JR0UcCH4K/02
         TY1fihWSxiXjxpuJMODMaq2wG/gJErWUEcpUoY538NVYNUfGaC7l7+M5HWy7d4rL4/Ss
         gmPs3UR5mz46bvAy5cshvYuS4zJOL0xMDLzaVfNBYhWg2dfmH9ZOTNs6UnP/qgJ7wkxE
         s/aCnB//GVPT109o5r1WhwOPVQDKifvOnweEsz7zXOOgCKpTkmrsmKaKSPbG6SiBzoXc
         OKtb/j84PI6O0k3fuf8onWS/KsxCcuLX1nod5Uloe/v7RAQAqSJi9U9j97wlJM0NwQH0
         961g==
X-Gm-Message-State: AOJu0YyiWZDKzQhehz2L3o4eGqN6Fivlbot94f5o6tSwTglOfL7G0xOE
	SW5uy956R+yFssUohg3BAn0tpoDbSh+7g+sxTz8gZe53Ro4rGP+RgNSo+b2ZhB7b
X-Gm-Gg: Acq92OFzBnpcfq/DDfreEd5WIFMQb/0LwzRmZ0C9J/XLzsqSBODre90pnUDwC7SjjJ+
	b6l+yuSLji0gkFIry93i1Qpgew29FvjupIIRIQa2vEx+U2wdJIBf76GLyQHR2YjCWrHXdZsowXK
	JVbSXrzo0+u2AGv7T2B2cG3uHD0IVMjm10VCyf9hV8ZSAseg1x9U3D/NZrFBqh1Ti4WQh2xVTOc
	QVW4LotTc1W+zSi8b1lRVv2od0H2RDtiki1hU4sqfFqA8L7GGjikeWX+IeAbRsZ81o7OvQn/S02
	9y6jsjyVlk98PZ+Ie0KjeiAFqv8koGVTWoTsVbVfKRzrwoa0JCjjTyIyRDs46hh6tBRhjLEb7JA
	zORjc6PVL8H4SEt/xYTNhzUHzDqYk553njR0FXOhArqut/uqq/29o4IJnEEeLZTyr28DSg2U8x2
	BIOFIFT4sFWg7Q++8ubQi6ERvfwXNkKFsVSoZ4otdqLE+24Hmz3izCuvuicR3rnNVB6Kp//Lnjv
	U6PVNLMynCN9HIpF1M2WYCWvvJAxEoifhYwDPRAPAQOHA==
X-Received: by 2002:a17:903:38c5:b0:2c0:ccdf:5e61 with SMTP id d9443c01a7336-2c0ccdf603emr2689255ad.6.1780194157851;
        Sat, 30 May 2026 19:22:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd7bfsm60576395ad.19.2026.05.30.19.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 19:22:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: Fix NULL pointer dereference in emac_probe
Date: Sat, 30 May 2026 19:22:19 -0700
Message-ID: <20260531022219.607001-1-rosenp@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293373-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 12C326143B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move devm_request_irq() after devm_platform_ioremap_resource() so that
dev->emacp is mapped before the interrupt handler can fire.  An early
interrupt hitting emac_irq() would dereference the NULL dev->emacp and
crash.

Fixes: dcc34ef7c834 ("net: ibm: emac: manage emac_irq with devm")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index b060795dace7..3e8ea0b05619 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3044,6 +3044,13 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;

+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		err = PTR_ERR(dev->emacp);
+		goto err_gone;
+	}
+
 	/* Setup error IRQ handler */
 	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
@@ -3056,13 +3063,6 @@ static int emac_probe(struct platform_device *ofdev)

 	ndev->irq = dev->emac_irq;

-	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
-	if (IS_ERR(dev->emacp)) {
-		dev_err(&ofdev->dev, "can't map device registers");
-		err = PTR_ERR(dev->emacp);
-		goto err_gone;
-	}
-
 	/* Wait for dependent devices */
 	err = emac_wait_deps(dev);
 	if (err)
--
2.54.0


