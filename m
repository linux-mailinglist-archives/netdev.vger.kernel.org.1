Return-Path: <netdev+bounces-300302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XP7uEzRZM2qw/gUAu9opvQ
	(envelope-from <netdev+bounces-300302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B9369D237
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 04:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CXlqLg61;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300302-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300302-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6A19304D709
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B731352D;
	Thu, 18 Jun 2026 02:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5E40D56F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 02:34:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750066; cv=none; b=RH9m47TCDWYfdC6haUclSVKG8g4DPmXeu6Z02pOF2FSTdS54z/yNapMzySQ5xP9mcQkJMy2Yt0FtzWOkYF5UBoT6/OtDS2PUrbflknYNKKPk89lGgWAoHQnsjzKrkUZGfAef+vKPJLtVpk0K99NkwVt618unWnDCPWfN3SHmBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750066; c=relaxed/simple;
	bh=fUmEeA7dGAXkLEe9ohOlEVhHOmdriGi59MTCsd/DUY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nem8l8myOrk9yhj58PuyViiuasM6koCMLfK2AVmHktLVGVUYCTuwCyisyom0pcTnQuGi1DeqpbtXoCXW/5VBA8/Sofow/OuTBAMISp3uwsIWhEXdLVsr92KBfJ6eBdgdBQs8UyBeBQnw/Dn+eTemo/crpGxs+vB3Hf7F2gBZ//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXlqLg61; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so195868a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781750064; x=1782354864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFTRihsb4A12HPbEPFddMGd3EZlcBtB3kSw8HdT0K2I=;
        b=CXlqLg61cf4NBk8o06sA4SocWFqV0zohPDrg1bfX5C1CMZ/7O04lbJkvhT6a8tZqer
         n0T2WJG8RqTzcaiwEhvP0iuOjEEhwWCqE1ApXw/NaImOoAqsj+y70D4ebudDWXj5aFtU
         NFvvQW5+ABREpWs9nfQNfkY8UOBRCD2DONhBAFyxUI1zMTuOrzpBcLr6hsZCJM4NT/0x
         bGBt0Uzw0vSzXyqhVksdQzR914BpO/94E09Gjk8mcD7NiALCUyAWyYjkKpIFvSrkWIHT
         LaepyK6WN97k0kmge2w3aWQD6gnpjHw17sCB7OO+oZqbUrmGYfX1DPk40m8MLqkNxAw9
         aqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781750064; x=1782354864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFTRihsb4A12HPbEPFddMGd3EZlcBtB3kSw8HdT0K2I=;
        b=tSiCsvUhBUGvp9mAOH3CNJ6NzMyguCONkg20gJ3hdamj6rRC7j76X+3fR4nPqhT1Q0
         xriCTaMGjIsXTpND4j5C9+RUEiNeEt5EE6ttjmHpWQz+OTFgMvfYjLoWe+GOTdKTIeWj
         oBQ+ur2HE4nwi8hxU3zF7NDD2hHddm491s2ILe1TUUQJfwT7SFz5o5iLWLkIOUzSxbjd
         FO/0SANqQab7Z7/xfR9du/dJJ0frEa2DUI2NvuF+GUjejuZuUGcdwAKLWrsR2wNOuAEQ
         p0MZpPReaszjUGXJYVZ0aAyKYBwG2eHUli3ahyCayfFoVjaDCYZIQApeHX2QIv0x68Eo
         1hPg==
X-Gm-Message-State: AOJu0YxoaKl629Xt8QH6hrsa9/89CVtcWvEFEUDR8Fn0O6D0Ta0zNWk4
	o3avvvUtX1qe81z+z/8MXZG/Cdw328HmKiPFZBFlo43wBkTz+4cfJj/WdtoUsg==
X-Gm-Gg: AfdE7ckcpIc/znItsOsw0wZkZUsT3ZMeXjABY94ZIITFG2GoINeVXCccmbo/vipvnYA
	jX+rBjNVkIsk9pAbpRwgNMCxbxJ3wXxI1PMdFNWUJ/TgOF+C5ar8+Fm9INXwNf5RhYpZDqutmUB
	76t9a+OM4rvkZnL+ovoJhNgTE6zw44mPidGmpuTwePwsJrAVI6waOpPL7BRvGARtFfxWQv/KVPw
	Z5Hk9xl3AA9LI5y4NIvl9EBiSMgSl49NhBbXu07maSsCRWfz43/ay0o42DbH6/1bfGR+FyGxSPJ
	WY9h1YJU7M2CAR4ZRCPuJs0nlkomkpdklX2exKyyLC78mlXsLRYibyR6GCy6WUFJdYTXXvmtvQt
	aaloMfh9hJie4eBrsLMR0VQHryPtUCgEZ2JnWGG0jyk90UZZnhtC/yqWO4KwZWXnKrXHO6uHXiA
	wdztJkvL8QBDM1mbyqobvufEbvc+wmnUNI80nU8u9tQzn6WdzUEc8T3jLcgRxmlT6PURRiqgLUJ
	CAVcnjQkwecQ62kvg5NigcB
X-Received: by 2002:a17:90b:1c10:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-37ce44ed8c4mr1645800a91.5.1781750063795;
        Wed, 17 Jun 2026 19:34:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7305:54ba:2fb4:e198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c930d7f81sm4976010a91.6.2026.06.17.19.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 19:34:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] net: emac: Fix NULL pointer dereference in emac_probe
Date: Wed, 17 Jun 2026 19:34:05 -0700
Message-ID: <20260618023405.415644-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300302-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7B9369D237

Move devm_request_irq() after devm_platform_ioremap_resource() so that
dev->emacp is mapped before the interrupt handler can fire.  An early
interrupt hitting emac_irq() would dereference the NULL dev->emacp and
crash.

Also remove redundant error message. devm_platform_ioremap_resource()
already returns an error message with dev_err_probe().

Fixes: dcc34ef7c834 ("net: ibm: emac: manage emac_irq with devm")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove redundant error message.
 drivers/net/ethernet/ibm/emac/core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 80f0c8985845..62ee1b70c3e7 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3044,6 +3044,12 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;

+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
+		err = PTR_ERR(dev->emacp);
+		goto err_gone;
+	}
+
 	/* Setup error IRQ handler */
 	dev->emac_irq = platform_get_irq(ofdev, 0);
 	if (dev->emac_irq < 0) {
@@ -3061,13 +3067,6 @@ static int emac_probe(struct platform_device *ofdev)

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


