Return-Path: <netdev+bounces-130528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21598AB95
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C9B23938
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF919DF8E;
	Mon, 30 Sep 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tevr1aRF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3719DF4A;
	Mon, 30 Sep 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719262; cv=none; b=dhMgn4/esbzQTqcPP/dE60AqfskEnjSWiW3s1v1d8oeDCNQXQLNo7apbzhDopfEPiGYXJwStYsuzYLMX5ZuiQr56U983AEWohtdaDs2s8PA5wpsCEmlUMhQ6IHJg4lbI9/q6o+Sq7R8YyzgETQHCnBb3FyvOBCxnXuOElfTQiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719262; c=relaxed/simple;
	bh=lMQRoVBUULxs9uGBgMvAA2of781zrtmqhPL3IKeHEUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9/+8mZr+TTpXkslmxUO+piX3PCznZkElfYhsAs+nJdMS/ZDDp3yDtb1G2CtAyKAOI7kHZP+/TeYpJXnFNr6bAkUwzxANH2JyWHWI4WqVhr5ytcKEJ0fVoCW6WiCZUmcOi3UvSZtjj8NrEU8OQNmljmDtac29R8bMmyB8DWihN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tevr1aRF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e2855479so3321328b3a.1;
        Mon, 30 Sep 2024 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719260; x=1728324060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31HvVby4GL7nx+VsgXoYs6/cZZem/Qg2v55znIBPyLI=;
        b=Tevr1aRFuMMx8wOwqgF7Pzj+NE8cRu0bNLlv+gIFphA5UR7lkD5sR4AOUdJPfwSHbr
         Kf08VCNWDyevntFDv9DCJC+Z8Y9WIRx6DO5EnfbamV7AGRPOSczBV7bZnkjS8RlrNdSx
         80IiDV3dp65bwzux5N8MOmMJVFyzqhozp/xfBufrkJxcRi02tVOz9JSzU/E3OcogVOEW
         Xap4vkKbETpTogMeK8M3WopaeKis6ODzgyQidweiJ3iL8KgPTIQdzEWPOyjAhiTPF5B1
         kn5j7PFBbOYsmvr7qGJ5nAyzewBm8BkUgiRfqFyye8FLb6PfG7vRWFvqcC5xJW7v62IU
         GZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719260; x=1728324060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31HvVby4GL7nx+VsgXoYs6/cZZem/Qg2v55znIBPyLI=;
        b=uBPg/G1R9FcOurTMF+2PQxxwNqyr0T29K2YAQVonvm4YaRl6If8pw6OcKU0pnpSuFn
         AzQdeHZLC0WemK+SEOf1kjcUn/wWEZwXR8r6xfsxfFjvHr/SmQImYOFdc5QLdZ9u1Z4b
         jCTTKGKa1Whbsu7OH5RtT6Hfjs6V/zD31te1VI7YURbzqMHFXBX4CWqbUzyGMRuNR6mT
         1iAmOICz7bdL19u1jb5Nj+AaJr8InFRVoVt7xVVtoDp/G391DhrkGb6jVrXQrK9fVjgd
         SZ4ZLNjz6OG7RfTU42q9sy9Qop06OCdQUj8E8AkoSeFnTWNA2ey9V4gP1N+t5UAMKOrn
         TwwA==
X-Forwarded-Encrypted: i=1; AJvYcCUbeeQKJY42H3XIdHpoqXkPGsYZnjDaV8Ktxq3lIR57LWymG3+8G7yvOz1yezLzSVK1UwMR4wKeseKyK98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHaYQXLEx/p6V2NvdUAvPnk5Id6txTrFroU1lg20kkeVivdT9
	733bY1br4YvFij2ZVO8z0wL5xgs8kQ332/d6JJOQSFvhwci7iWTVmsCfAijf
X-Google-Smtp-Source: AGHT+IFyAbHicDROoHhdPPlEuXlM7VoMrxpcjKj0ArsgPHbYgHPDfXC9YRfzrwcARSgI5nwu9K3l+A==
X-Received: by 2002:a05:6a00:10c8:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-71b25f74f10mr18620290b3a.14.1727719260278;
        Mon, 30 Sep 2024 11:01:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:59 -0700 (PDT)
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
Subject: [PATCH net-next 13/13] net: ibm: emac: mal: use devm for request_irq
Date: Mon, 30 Sep 2024 11:00:36 -0700
Message-ID: <20240930180036.87598-14-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/mal.c | 47 ++++++++++++-----------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 70019ced47ff..449f0abe6e9e 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -578,15 +578,15 @@ static int mal_probe(struct platform_device *ofdev)
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
 
 	if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||
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


