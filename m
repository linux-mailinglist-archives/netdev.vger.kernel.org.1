Return-Path: <netdev+bounces-304297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wDEaIWz5Rmp0gAsAu9opvQ
	(envelope-from <netdev+bounces-304297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A76FD804
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 01:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="eo8/LSMA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304297-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49EE130430D0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A733BE156;
	Thu,  2 Jul 2026 23:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317D3C819E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 23:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036249; cv=none; b=ArEEfKhgNNZYstXeYO+Ie4Qg7VyTiQ+xuIIzEpkVXRoJwLOId35ln1K3KzvMEh5KEK55oQgZkWA8lxJZ+VlHDTBOr6NDMNW6gpGbMnwNqg2MaanVS+Z04zfbBPjVWk8GT85QG7CkNSx9VWkraL9oq72v7X8bMsLdD6zHZLUlqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036249; c=relaxed/simple;
	bh=qxVC+PhAdInHEFda3IbTj5Vu/foDrosmc8KQKtJ9tv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJa8ezXsyd2vKLW8kXYTx5NdHsefRDMNdsQ4CiyDrj4upb/92HZKuX0Dw4kQlpwcPX+hlCsh3+/tG6wrgZu765XEUhSPsxlCLpNf/AWHIZR/YzfxX+5ZUOhXRbbsUZd2ny5xyh33FWNRSKgQHmkeZUAHsny8YRbDaJaG1QehUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo8/LSMA; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84794e800f4so1341315b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783036248; x=1783641048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fw5m2ZAAuYdtnFzlSxNxzYWs1oA4+6H1+UmVCec80cA=;
        b=eo8/LSMAZfjdCrp4MuKdCRv48LD1DStL31O8/99QOQcZN4pm6CUIceyuVHtU6BZC3z
         wZyfhTBHTE7yoYBfBQJChBXM/X3AQ51snz8tsgzAWEj0tvzPSSCR9/rkut4ng7+y2fkQ
         rjiQxk33aj9LceUIzKYnGVitUW5jSIqoCokcyW6dL5LAHFY/P+Gq/1S7rzwtltgZb52j
         HmmIuZPA4cMstb6AlLs6/MuNqEcxqrzeXWCEpyVxbfK+YBzJdQ/R29RnDn8gh5DWWjZ4
         O/JU33rWIAxnLklbHWuMf4i6L4PIF1lCLREJOqQLQdasFRfy/Mrod78pVQgPhWa8x47O
         s1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036248; x=1783641048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fw5m2ZAAuYdtnFzlSxNxzYWs1oA4+6H1+UmVCec80cA=;
        b=RegatejJfYjgeojAsV0qV7XY9m3TsmLHFo4hGhvEoSTAnQu8vfMzt8iP6dhu5eeBZp
         GmdF4nqLwP/erUd7wXhv8AwPY4/eDrSh/+UMnBFWST+C3ItMBoNkVAj5MDM+7JtG0sd2
         5CH/bCjF8LuxDz5Fn/Tb+4r+x14JAHF8PvYF7XEUG8RjLpyDU2hVBj/Qix4HmfEvfGIj
         U/AqkS/83LkWOwOjurbbsj40by+a/mehs+Wv784cJMIVfxI3lHwlikhTeH7RCbv8+FuW
         Sep7OjKoOeFONe8PE3VYUodSB0TdO2C7UmMYFzM6bgtFQ64Rfnfs9godGZiZxrPios/8
         taFw==
X-Gm-Message-State: AOJu0YyBF6stt7PDh63mKtpJ9DYLgWJPxxd/nPO0F112z/dem7mw8oAN
	JERzxpaI3TLNTQm3u92P9kY67h/LfG+P90K9Rf7+1iB3WcU0YplNV3cDsnSdSQ==
X-Gm-Gg: AfdE7ckR7XKpNWQz1E3eMEJbcldpknLCnWi0+7eyXUCRnFHVWW/c6/WUNZ3D3qiOZ+O
	H0F6umo8JUCVuLtWrdw2QCsUnlgoXpvlOalaeeeSyKbaIbj3ROTUt2Yp3iHj9Q1SDKwblUCyFtZ
	EfaXBdYoOlP1zbntjujr62I0mJ7AivEfsY8YE8tazgEBS4sogW+vf8XMwschQRcZ75ZoUg4V7iC
	pMe5PZAIuS9CCCjUKiwDx+hDR2xxYny54ix+4Xc2ROLqQJ5AttHQVjnxT9JN+cVB+Fot1w8jCQy
	DNoOybMNjKgdFoCBZ+r0l/eRWyFhesPwES9AgcTs8aA2OaCzj42duKrXYvi8frBAlDZkGB9/wmD
	Wj+4cCKRGONCby2+KgzJE4KWVE5i0P5VS378zhcv9wIpmT079xGqjBO14dxje7NqGi3I6LhahYX
	wnEYtNyNNuZz2g09KyB0SYVuZ9D2JUsjzTHWwhyqrozSJwTzBZzmukX9zziKoj70UvL7QwMI2Y/
	cNh75/xTq18RUX1qS3W
X-Received: by 2002:a05:6a00:6c85:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-847c514002cmr7264602b3a.29.1783036247553;
        Thu, 02 Jul 2026 16:50:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94bd7esm1985283b3a.38.2026.07.02.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:50:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
Date: Thu,  2 Jul 2026 16:50:45 -0700
Message-ID: <20260702235045.1326384-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304297-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: EA1A76FD804

devm_request_irq() is a managed resource: the IRQ is not freed until
devres_release_all() runs after the probe function returns.  In the
probe error path, free_netdev(mal->dummy_dev) and dcr_unmap() execute
while the IRQ is still live.  If the shared IRQ fires during cleanup,
the handler accesses unmapped DCR registers (crash) or the already-
freed dummy_dev (use-after-free).

Switch to plain request_irq() with per-IRQ error labels that tear down
only the IRQs that were successfully registered, and add the matching
free_irq() calls in mal_remove().

Fixes: 14f59154ff0b ("net: ibm: emac: mal: use devm for request_irq")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index eab7a487bf08..5c3bf05ca6a5 100644
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
 		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
-			       "MAL TX DE", mal);
+	err = request_irq(mal->txde_irq, hdlr_txde, irqflags,
+			  "MAL TX DE", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
-			       "MAL TX EOB", mal);
+		goto fail_serr_irq;
+	err = request_irq(mal->txeob_irq, mal_txeob, 0,
+			  "MAL TX EOB", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
-			       "MAL RX DE", mal);
+		goto fail_txde_irq;
+	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags,
+			  "MAL RX DE", mal);
 	if (err)
-		goto fail_dummy;
-	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
-			       "MAL RX EOB", mal);
+		goto fail_txeob_irq;
+	err = request_irq(mal->rxeob_irq, mal_rxeob, 0,
+			  "MAL RX EOB", mal);
 	if (err)
-		goto fail_dummy;
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
  fail_dummy:
 	free_netdev(mal->dummy_dev);
  fail_unmap:
@@ -718,6 +726,13 @@ static void mal_remove(struct platform_device *ofdev)
 
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


