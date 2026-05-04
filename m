Return-Path: <netdev+bounces-283992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iu/VLcbj+Gkt2wIAu9opvQ
	(envelope-from <netdev+bounces-283992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:21:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D94C261C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99325301B90D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59D3DE44E;
	Mon,  4 May 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9fb6NQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775848460
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918913; cv=none; b=M/CCxcDEzNS7QyG+2zx++sVRSMAiKAzxPOeNxmhecMytLPTpH3jZEYqmFZN6oaEgyMkQCmknIyjk3pxXEk5QEgrgRdG8XO0PIusG7i6R6uoZ1/F0SPtESAzKnQeyzpqtujruFfbYFe+A/0/KZ3fKXOw9uZWrhcAmwvsSDmQfgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918913; c=relaxed/simple;
	bh=2Ln7NuP17fN3KbpwPkE7OMG3ShNAswMdr+VATds+Wx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ectg2ZtP0rR3NgTf+4f9Jz7Xi7pkQVlSQA/AVBdrVkqsmPUkUFlCxM+QNPaACY4qkMoOtL3Hx2GBlARaqiz90lHQgwCyFjO+6tPiFMSKIABkoVk7mNMP5OQFD45L8xMP+yWzvOrBoUPGHpu+Bma2tEWpug4wdKsHq1iCddBQoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9fb6NQJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so46829145e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777918911; x=1778523711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul7mBG5W2QxscDjew0PAO8dOqwPhU4Mbu6L94MsasSA=;
        b=A9fb6NQJxWTgqgqscOzS8obpi1ZWYhXTqPsM8V2sEGb/WKQ/PZuEMYL6Z8Mcx/Icga
         ozayG9386Bc/A9MwnW9IIJeV9NM7mb5Yv4kXSIc2/zyeBHU9PGlq0LaGWuye36+U/KfO
         i5E5VyqFDxDF4cCTxqQOsKez//u6JLriBQVcn2UUhjRJu0L92J4ZJ10xOVZ5X4I9tpM9
         1v4LaKW5mDAsRZnbkQSPluiB+JGb2uNPg3AHbzaywfAZAukE+0MJoSEj5ZYLaljc3IYX
         3cDJdyPgbb2aGm+Py5ZrHNqyDT2F1Qle3Ab+55uvorx+zmdrvXnOCXTQD3+fI3yhmmOC
         R5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777918911; x=1778523711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul7mBG5W2QxscDjew0PAO8dOqwPhU4Mbu6L94MsasSA=;
        b=LBtnn4vRczE9MIbySZ8yBLTltp4aURAiZTLXE1cFx/R0MABgdVe+kvB13XWdBiX55c
         VAiom3eO8LZBPF6nldIGTZqKDZxMKxMSAtKq4jTGU/8K2uE4XERU5sJO5Hw3ODJbEFNK
         oPEtkYCRVgV8gkgVTNyC1b9J2mrBB64tYYBcY1VqLKECGYnt8HCrNGCVNQ1qbhCTTd0I
         1KxGSpUN05pFP24Kod99mL1yIdmXwwaVvNCJDred7HBA5yyMD825iP6fDPP7U8Fb0qOm
         LWR3afv7J5kKKp7z61hfkKF7bDqlV9oYSYyNJC3z9zwop2sEbBMHp18Q1huF30UnUttS
         812g==
X-Forwarded-Encrypted: i=1; AFNElJ9y8vuiE29Up3XknLiPLzsDg2J+szm6qg9x9n4ku2CHWqSe7lSzc2b5Y+VvxH3oMcmPwdMEt74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5ELZIUGzn8dOMpy8G56yNZmE2Ec8EOT18mwq3h7JIFAMhZVl
	2aismTdVN7JjTBRbWW7CHP7c+M01EY+7bp+r2G7Lrn5AfBP3UinmpUCZ
X-Gm-Gg: AeBDiesTrQXfLJy8+chFmQqU5gA24qFAYAHwSSCHmC8fQ9ovsdfST8PwfGZcLXJRJui
	sZ+nqNPR8je+9pEPDgo7FnLx2NmM4R+qFqRKB2iv1bganx5vhegpz1ejlPJyGmvk51DQ1yrabhZ
	98zmkC4qMDS1QYtTdrCtsYFA9iphOUVxruVdOFBafixYa9EnTNJF2ibPyI8ikKR5fbqELTjL7rq
	9o+1y4rBOVQU3vBTigOCnvqt9GhUncB4b9bviZBKjXh77o3x6Q7/06ffFMq/1FI01KTjZOcEWIm
	wqc0loj8QH+BbQzfRn3ivwm1TdYNUkVlv1FkugdQOaH1sZz4RPhxNOdue1329n9FGPZppk68ncy
	/w6ci+5XEcWiAw8qxSoW11BG0Vb/v10gcjSTsFwJCtWf4v6GxCPMyUr/ftPtHM2B7iFTVr7C7xp
	ex+Mq6Pa0FAXJn1SjWBeGYIaiTsc6jo+zFfs3Xme0p4j6BC+gwZrc7lbCx
X-Received: by 2002:a05:600c:8b17:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48d1426cdecmr9856175e9.14.1777918910697;
        Mon, 04 May 2026 11:21:50 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.251.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm412192115e9.11.2026.05.04.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:21:49 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	John Fraker <jfraker@google.com>,
	Matt Olson <maolson@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] gve: Use generic power management
Date: Mon,  4 May 2026 18:21:32 +0000
Message-ID: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 234D94C261C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283992-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vaibhavgupta40@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]

Switch to the generic power management and remove the usage of legacy
(pci_driver) hooks.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..b7bac6bf89e2 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2967,9 +2967,9 @@ static void gve_shutdown(struct pci_dev *pdev)
 	rtnl_unlock();
 }
 
-#ifdef CONFIG_PM
-static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
+static int gve_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
@@ -2990,8 +2990,9 @@ static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gve_resume(struct pci_dev *pdev)
+static int gve_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
 	int err;
@@ -3004,7 +3005,8 @@ static int gve_resume(struct pci_dev *pdev)
 	rtnl_unlock();
 	return err;
 }
-#endif /* CONFIG_PM */
+
+static DEFINE_SIMPLE_DEV_PM_OPS(gve_pm_ops, gve_suspend, gve_resume);
 
 static const struct pci_device_id gve_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_GOOGLE, PCI_DEV_ID_GVNIC) },
@@ -3017,10 +3019,7 @@ static struct pci_driver gve_driver = {
 	.probe		= gve_probe,
 	.remove		= gve_remove,
 	.shutdown	= gve_shutdown,
-#ifdef CONFIG_PM
-	.suspend        = gve_suspend,
-	.resume         = gve_resume,
-#endif
+	.driver.pm	= &gve_pm_ops,
 };
 
 module_pci_driver(gve_driver);
-- 
2.53.0


