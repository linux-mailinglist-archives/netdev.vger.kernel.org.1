Return-Path: <netdev+bounces-132456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF4991C1C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FB01C21303
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED44317BB26;
	Sun,  6 Oct 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN1JrioP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FF17B400;
	Sun,  6 Oct 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181744; cv=none; b=dS+8em442JkbGOcUjBloLwWOCNVerGWH8F6tKPdK3AqNzQSfvkvIEdxVltXC3sNI94QAy9nBu3qk03A9EoBmEEmVY690CNcHpzHkqeK3jLT3tOd9XgM3RO34RAmPGNRuyoJHyJ5h6A3asy7fqeEzE/A8FHjbjngX1iXefLQMLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181744; c=relaxed/simple;
	bh=tPMaKKCrP3tEFhfNaUWKZ/JHAt5j/C2Ms8f8SpstWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foV9g1vOovyb2bBUpFX2iIEusYbaWWqDs6TnWf0U9CVktWK0guenFH3wx0bP4j5EgXTaXBmB81yWiIhauJaJlga0wIqwsL14fWEQgod6WXhnYZLTD9sj7sUlMFM+cTvg8QPPHO16AmTnNbdny2BpwizO0Taq7v4hT0yrs9616ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN1JrioP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso258706b3a.1;
        Sat, 05 Oct 2024 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181742; x=1728786542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=kN1JrioPgajEn6xS1KHQ9zM+XR6JKfmt8aABw0uuETjKYUeI5xb47GFV7HDBc+2Mn4
         z/ZEOrIGFbgf1E81G1emZeqtpQliX0BIqzYGwiBWBXEIN/G7k11aQIiNykmLjT/Uwdo3
         v7ET3Bx429jdQvSZsZKKOYKmiy0N9scOUluXrBEpFrR5eITBvci/6Mx8a/wfBdxUAgy/
         dqLkP8ef9Bft3FE7p++jZ2DtR/iocwBzE7ytnE9inPN+MerIS+QcBSJYZyT6djaD9axN
         LiwhejrWjpl0REN3nuf1tIrl53NZN6Ir3ydW5KLHTfuVllLoKaDhvsebRJxodZBSJY7B
         S2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181742; x=1728786542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=XoandSTubV9/5Zbk+bqemu1S+SLPaKnWypfYZG9AjfDMai9NVsHS1weTlhASpDGEdY
         eC6xGv0ZguWNVVuqmQ94DcZBaoea/ZM1kNrkjmRdVT6bpUGQ1xoSBTRLc+yioSiimvwf
         lNhzQ2yCljkE7oaUyYyikdOJO9baRYPPzfvVTOs11AaqzNCnA/6njo5bm5nSuu3lz4jj
         Ov66LyJgLAI/TLUskxg+X33GegLocD4+ach5M2B1OiPRLaNcIEjguRlrZ0KnAcGTAXyT
         rLuIYZBhAlgZeydOQt8p0+HfYc903yjMQDrzlnwkrj/MQXP6ZoLG3DCaGcXKDfkwAwlr
         VVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1le9u/EAELiGtXeUttMV40XrUCTb+mvFhowMe7nj0NLg/EenQWfPa6xD1N3R0RAr5g4vpUOqhEpXrfQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8f5Glt9UgIJb0j2DibYBh7fEU3auyDBsZ26195vZeHnAWl8jJ
	zq2Uw3I1NCX6HyMF4CI2at2XTXs6fi/cQ6U2BJEmhQcDpjJf3ITTeOHSQg==
X-Google-Smtp-Source: AGHT+IHhcBDPHI6ZJiG4LrmxLbAs88LeuLCqJItCY+6yYrX51yIrGagTM9+9KDleQrCLiK9RVoC8XA==
X-Received: by 2002:a05:6a00:914d:b0:71d:f2e1:f02b with SMTP id d2e1a72fcca58-71df2e1f068mr5495391b3a.2.1728181742525;
        Sat, 05 Oct 2024 19:29:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:29:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 11/14] net: ibm: emac: mal: use devm for request_irq
Date: Sat,  5 Oct 2024 19:28:41 -0700
Message-ID: <20241006022844.1041039-12-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids manual frees. Also replaced irq_of_parse_and_map with
platform_get_irq since it's simpler and does the same thing.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 51 ++++++++++++-----------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 70019ced47ff..b07b2e0ce478 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -578,19 +578,19 @@ static int mal_probe(struct platform_device *ofdev)
 #endif
 	}
 
-	mal->txeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	mal->rxeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 1);
-	mal->serr_irq = irq_of_parse_and_map(ofdev->dev.of_node, 2);
+	mal->txeob_irq = platform_get_irq(ofdev, 0);
+	mal->rxeob_irq = platform_get_irq(ofdev, 1);
+	mal->serr_irq = platform_get_irq(ofdev, 2);
 
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
 		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
 	} else {
-		mal->txde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 3);
-		mal->rxde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 4);
+		mal->txde_irq = platform_get_irq(ofdev, 3);
+		mal->rxde_irq = platform_get_irq(ofdev, 4);
 	}
 
-	if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||
-	    !mal->txde_irq  || !mal->rxde_irq) {
+	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0 ||
+	    mal->txde_irq < 0 || mal->rxde_irq < 0) {
 		printk(KERN_ERR
 		       "mal%d: failed to map interrupts !\n", index);
 		err = -ENODEV;
@@ -660,21 +660,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = request_irq(mal->serr_irq, hdlr_serr, irqflags, "MAL SERR", mal);
+	err = devm_request_irq(&ofdev->dev, mal->serr_irq, hdlr_serr, irqflags,
+			       "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = request_irq(mal->txde_irq, hdlr_txde, irqflags, "MAL TX DE", mal);
+	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
+			       "MAL TX DE", mal);
 	if (err)
-		goto fail3;
-	err = request_irq(mal->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
+			       "MAL TX EOB", mal);
 	if (err)
-		goto fail4;
-	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags, "MAL RX DE", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
+			       "MAL RX DE", mal);
 	if (err)
-		goto fail5;
-	err = request_irq(mal->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
+			       "MAL RX EOB", mal);
 	if (err)
-		goto fail6;
+		goto fail2;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -693,14 +698,6 @@ static int mal_probe(struct platform_device *ofdev)
 
 	return 0;
 
- fail6:
-	free_irq(mal->rxde_irq, mal);
- fail5:
-	free_irq(mal->txeob_irq, mal);
- fail4:
-	free_irq(mal->txde_irq, mal);
- fail3:
-	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_dummy:
@@ -725,12 +722,6 @@ static void mal_remove(struct platform_device *ofdev)
 		       "mal%d: commac list is not empty on remove!\n",
 		       mal->index);
 
-	free_irq(mal->serr_irq, mal);
-	free_irq(mal->txde_irq, mal);
-	free_irq(mal->txeob_irq, mal);
-	free_irq(mal->rxde_irq, mal);
-	free_irq(mal->rxeob_irq, mal);
-
 	mal_reset(mal);
 
 	free_netdev(mal->dummy_dev);
-- 
2.46.2


