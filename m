Return-Path: <netdev+bounces-304679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRs4MdR+SGrRqwAAu9opvQ
	(envelope-from <netdev+bounces-304679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 05:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15259706892
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 05:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g3q2tUFe;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304679-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304679-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B90F6301B934
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 03:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E22472A2;
	Sat,  4 Jul 2026 03:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BF13C918
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 03:32:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783135953; cv=none; b=Qf8WUW5b3CtapPMOBpNPi8IgjcMjglMdxbtUGAtcinfRNGuUAdNGz3l25DYQktGCgh8AngfEdYtXIwty8gJvUFl22xpgs9TjfqvBUy0fdSrjT0aXo00iVAohIod01EtvrCfEZp+TRvTlgm7cmZkemu0xUi6BMWDu6Mw6E5YH7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783135953; c=relaxed/simple;
	bh=QQAbitMkQ0qBRMMilwe/GvLXplVQttu88olFEYFJdqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZqatKdqmfK8kb/r1/Fzg/bOyeJyYvFRMRiO3vgE62asKpxZhgQvs6YYaQKQSFEJSP6QIq/dDCTNVtFZXa/0KEwO0iFpoKGOCCY36nLp7sIrBd/3t2NqgD1nkvZ2hvLaj0rQ6Ob9jV3+zUjXLG8RFgXWj7fqmQ6bYLGi31j8czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3q2tUFe; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso11989955ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783135951; x=1783740751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etYBcZKNvedguZcZzxJlv9Nayc7uz+fWkzLHt0ZOgn4=;
        b=g3q2tUFesZJA76leE/wv6vXOFXbA9urWhEjFBZlwNnZRONbeB/QJLpND3BOvMm2Bzb
         feOuQAF/Ryu5d/aw/Vir3dIRdEvToMctaGiVOMGeugoSwM+qfocQ/LMYDSBp2INP4BQw
         qaRG3s/CzyFuIBZSsB9QhSR9A+PcFAFlzx8bAjSH2bkMY/DWjRCvfW3/5tulb1nEkKFW
         WLxz+pw2s4wZpedVl62XXhDNtQUNR0TD/kwiRl6bQCNb6nQjs52frcK8dxG+6WOdNPm7
         +Hpg2wJLefdlVpJkdYiJc5tNMk1MJZSf8Es1kcBCahD1fuUfmGVMjWO16tH6teiR4T23
         5Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783135951; x=1783740751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etYBcZKNvedguZcZzxJlv9Nayc7uz+fWkzLHt0ZOgn4=;
        b=HRzdmczXzPE/nAV0r99GqAaM+BoV+SqqFcjc6v+9NbalR7+HoW0JcOdaBhSpzAIjNi
         /ZtPWGWfR1VpKLu25lSK9lDASsebsjrxGI7+EtiXfL1YgoNfSMT2IkhVD1zcnSXm7Ewd
         jXZjJVfhrj7J4So1kolNz99gKSZbnHHbJx/HINMH/p817KQml4+KCaF4VgxpxCtaHm22
         C91LxgQN1xIy1FjVVGX8KQiGx1kilDE9k/wIBHSsMLVdAAkVaA/i7cSrnDuhmtAJNcdy
         IUYoBmEkW+QzCwVClYF4HXLy85gwN3wwExaIvO5MasfIIG1Yet/Dy2Z15LQ5eYOVvhTa
         3ygw==
X-Gm-Message-State: AOJu0YzGFfcIDvy513tavyx+XlOsi3L9LBXlO+eRZBFRHUy0cW7mFDld
	jI3I12vzppQGB1+ubTnFyPV5l4jOqMbElTD8K3AjUSghilygf87o2M5EdQ05/Q==
X-Gm-Gg: AfdE7clDtD9LRPEPhgA0HprBY1s4N3A179hlxEC4apUufVBUr8TuEdfLMwo1uf1CnfZ
	5s3bNI+503z45tycDpJCAnXltjyIYBkOEjSRvsVTwY1foowYz1tsvxfcsSFtaH+YP7KsZwM1od0
	l1d0W4/9aKRlNcx532H8vtojg8pJ5aRPBjp5yeqdN+oQcmj6o7PNzbkRQAWyQHIL9TKuNOPETEw
	X2FYFQuam5MaS1CPCYxEn6Z79rnwB4jshZAQpIBsz2uHoOUelLbqXJlIs7aGpZQlCMnUVVUXqon
	lpmxvqCbYn7SzzoLroWkWHFgcUmR6lu/772TkdDo1VxD0b1bgxr56HH2eTYwZWQWmKNC3LMYJZ6
	C6+gldSr53pvLtkC90Ss//CnYouDyn5Fn+B4p1utlsSaBrV3ZGPHRCMsNZ7KvXM1By1ne4oMJeX
	xHBv1Fyzw1n5NQQSaKV9C73HAIo6CfZGQgMxP1g0hisVZrsa/Y6RQ9e8hEbq3nlPtPSegp17RxO
	tiIh4vZtg==
X-Received: by 2002:a17:902:d4c1:b0:2c9:b42e:444e with SMTP id d9443c01a7336-2cbea1a3905mr12865425ad.1.1783135951228;
        Fri, 03 Jul 2026 20:32:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25f7bsm17448625ad.7.2026.07.03.20.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 20:32:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
Date: Fri,  3 Jul 2026 20:32:29 -0700
Message-ID: <20260704033229.2447410-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304679-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15259706892

devm_request_irq() is a managed resource: the IRQ is not freed until
devres_release_all() runs after the probe function returns.  In the
probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
while the IRQ is still live.  If the shared IRQ fires during cleanup,
the handler accesses unmapped DCR registers (crash) or the already-
freed dummy_dev (use-after-free).

Switch to plain request_irq() with per-IRQ error labels that tear down
only the IRQs that were successfully registered, and add the matching
free_irq() calls in mal_remove().

Tested on Cisco Meraki MX60

Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: rebase and add tested comment
 drivers/net/ethernet/ibm/emac/mal.c | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index e88e4a1ddcd4..b42ba53671fd 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -656,26 +656,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = devm_request_irq(&ofdev->dev, mal->serr_irq, hdlr_serr, irqflags,
-			       "MAL SERR", mal);
+	err = request_irq(mal->serr_irq, hdlr_serr, irqflags,
+			  "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
-			       "MAL TX DE", mal);
+	err = request_irq(mal->txde_irq, hdlr_txde, irqflags,
+			  "MAL TX DE", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
-			       "MAL TX EOB", mal);
+		goto fail_serr_irq;
+	err = request_irq(mal->txeob_irq, mal_txeob, 0,
+			  "MAL TX EOB", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
-			       "MAL RX DE", mal);
+		goto fail_txde_irq;
+	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags,
+			  "MAL RX DE", mal);
 	if (err)
-		goto fail2;
-	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
-			       "MAL RX EOB", mal);
+		goto fail_txeob_irq;
+	err = request_irq(mal->rxeob_irq, mal_rxeob, 0,
+			  "MAL RX EOB", mal);
 	if (err)
-		goto fail2;
+		goto fail_rxde_irq;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -694,6 +694,14 @@ static int mal_probe(struct platform_device *ofdev)
 
 	return 0;
 
+ fail_rxde_irq:
+	free_irq(mal->rxde_irq, mal);
+ fail_txeob_irq:
+	free_irq(mal->txeob_irq, mal);
+ fail_txde_irq:
+	free_irq(mal->txde_irq, mal);
+ fail_serr_irq:
+	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_dummy:
@@ -720,6 +728,13 @@ static void mal_remove(struct platform_device *ofdev)
 
 	mal_reset(mal);
 
+	/* Free IRQs before freeing resources they access */
+	free_irq(mal->serr_irq, mal);
+	free_irq(mal->txde_irq, mal);
+	free_irq(mal->txeob_irq, mal);
+	free_irq(mal->rxde_irq, mal);
+	free_irq(mal->rxeob_irq, mal);
+
 	free_netdev(mal->dummy_dev);
 
 	dcr_unmap(mal->dcr_host, 0x100);
-- 
2.55.0


