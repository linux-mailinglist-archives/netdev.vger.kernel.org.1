Return-Path: <netdev+bounces-251167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E266D3AF3B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52C3230019F9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C838B99B;
	Mon, 19 Jan 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHiDpr6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8E38BDC7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836928; cv=none; b=P9k0XaVsC8+i6+sjJ1FgkKrkkNUGSjyrL0tyolsz9j+jl0lGKY92I15qwURyHhuAgzKjSz2FBxZ9EXex9FyA+UaVB3M4JEcjHVcI5ClvoZlXv+s0qtMST83+Bhp+BeMwbYw9zRXRn9A/N2vmae/3ePlci1Iri3DKD0S8OJq4lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836928; c=relaxed/simple;
	bh=ANxeWm8qe9YMWOTnYYf0JGWyOXcfAn/iIUIToXjjCS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePMDG7Udc8s8x+8s3pFKzo+LvNz6EJb4xeANnR24gSVLb5g7VruY/0yF5XhI1dGQVpnpgOZnQ1bQFnEplJZOhOzFoq17hEZ7M10lKGzYISLF/ptS3BgfMDjOT5vPClscR7EUkLMQYaGjeGTdAaWSnSHFrjQgSncY/16nqVXZhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHiDpr6F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a102494058so26505295ad.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768836926; x=1769441726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vJ5eVw9QUDTsNOtQAd/rmkbee4hLGoma0JU12f0lc8=;
        b=HHiDpr6FgoXjF2qKLmYD53LN/Sxa9tNPbbTc1nGqX5gGEkUZ+XaN3WxI8w/+bhA2p8
         ncw07DAS+8UYgIdtW2PP/AMP9tLdS+/rxtkrlr3axqWcgkOWuJPP4oPT9X6oOaXtyyAB
         jBpJNzn6TfWHWLwJ1Tf4EpUzEhVV1NOZCTF/LHaNNnzCR7t1qEIItaGhw69Uqvvd113c
         qjEJ5h/SWlQR7pzyxf7f0g5Al1qzyc8mC227ogGMgFDzm8Pjuvvv3Ad6x9NkPwg+gwOE
         +Tvg0lwBgpMx22al6Q5yX3Iazdds4iMGjNvSZELo7pM/oRzgIhCoZqqnrSsJWtdQvImK
         HTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768836926; x=1769441726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJ5eVw9QUDTsNOtQAd/rmkbee4hLGoma0JU12f0lc8=;
        b=H365Ozjds/1ED/2tVIBfdJzlcRqPKV/NlW/aX4Zf/k+Fp1nvNjEK8C6PuTNVsj18BK
         5Dn74e7+7bLOTDJZmUee4wm7Us97tjcChBFPgMo4ESdr+qjhx+vmaS43VduvQNtXIm/a
         3IILRM6vErTOTJiPWsDI3UZIOqORK7NmEn27Im7LujQAh98xpBWsbbQg5IBKyoYL26yU
         r0/3l8SzRMogcX1cheoByWSAO5ak7VUVAsDcJ1kv87C9vXOK8sY+xJEbM2UdZNLjuVvr
         NJ8pXbc0Hp8tp9Q96YB1AyEXgWvcit1y/fCtZjhqSA0GpmjmPZ3lwyFyP8Swfhx+G/9r
         cL4w==
X-Gm-Message-State: AOJu0YzLEP6jyej3vCD18YKd1LyfynxhHzsvF1h66TjnuvYamIKB6T9r
	holK3Cwrz4y5m0IEc85CttFLPV/zYJzwq/7RMhqWYiYu02JnZSJSg020fTQrZw==
X-Gm-Gg: AZuq6aL4mL8shlQKeA2So2ufj/tWPZxLfdF/IZQoB3hnBDCDF3y9JynZXHYKuRKl6B2
	BgM7SuyY+hDA2oXXrDlMUXBrWhvJrXAfpuWGphjz7HDP6YJ8/eW9xVmjTF6+kVwYSM6CtF2prfv
	ewwTznijANfGz+NefiHLVvQ6DHBn1Pbcm4CNaYRsueVV3UWbXOJfRSal/G8Am1Ssr7tqOCxJ3db
	hohM+zvhz5LQHxAzFwZz72Y01supA7dNAGTNxws1FRHCmM5kYqESHlCSbviNMP2DDFBPN8pL/5U
	P11/Weh5bRgJmWetp+8bOYSLZGhLuFHuy1nqQAS/jsfbHVXz4WHz9Fbb73PzfDQsStSrhZHXoqT
	q8/wT1vg4zemORlf9iZBGe7lqTzC2lXnocnaNSNbr8n1nNXjdbY62V5vU9y8xbA+yPSgZaas7s9
	Ma63WWJVvv4PiFm2odIBZjPh4uEeE1xGUy0xM0YSRgkr99wPWMHap2bw==
X-Received: by 2002:a17:902:c408:b0:2a0:9a3b:d2a4 with SMTP id d9443c01a7336-2a700990d72mr136181445ad.10.1768836925823;
        Mon, 19 Jan 2026 07:35:25 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eeefasm97601865ad.43.2026.01.19.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:35:25 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sathya Perla <sathya.perla@avagotech.com>,
	Padmanabh Ratnakar <padmanabh.ratnakar@avagotech.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] be2net: fix data race in be_get_new_eqd
Date: Mon, 19 Jan 2026 23:34:36 +0800
Message-ID: <20260119153440.1440578-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In be_get_new_eqd(), statistics of pkts, protected by u64_stats_sync, are
read and accumulated in ignorance of possible u64_stats_fetch_retry()
events. Before the commit in question, these statistics were retrieved
one by one directly from queues. Fix this by reading them into temporary
variables first.

Fixes: 209477704187 ("be2net: set interrupt moderation for Skyhawk-R using EQ-DB")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 5bb31c8fab39..995c159003d7 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -2141,7 +2141,7 @@ static int be_get_new_eqd(struct be_eq_obj *eqo)
 	struct be_aic_obj *aic;
 	struct be_rx_obj *rxo;
 	struct be_tx_obj *txo;
-	u64 rx_pkts = 0, tx_pkts = 0;
+	u64 rx_pkts = 0, tx_pkts = 0, pkts;
 	ulong now;
 	u32 pps, delta;
 	int i;
@@ -2157,15 +2157,17 @@ static int be_get_new_eqd(struct be_eq_obj *eqo)
 	for_all_rx_queues_on_eq(adapter, eqo, rxo, i) {
 		do {
 			start = u64_stats_fetch_begin(&rxo->stats.sync);
-			rx_pkts += rxo->stats.rx_pkts;
+			pkts = rxo->stats.rx_pkts;
 		} while (u64_stats_fetch_retry(&rxo->stats.sync, start));
+		rx_pkts += pkts;
 	}
 
 	for_all_tx_queues_on_eq(adapter, eqo, txo, i) {
 		do {
 			start = u64_stats_fetch_begin(&txo->stats.sync);
-			tx_pkts += txo->stats.tx_reqs;
+			pkts = txo->stats.tx_reqs;
 		} while (u64_stats_fetch_retry(&txo->stats.sync, start));
+		tx_pkts += pkts;
 	}
 
 	/* Skip, if wrapped around or first calculation */
-- 
2.51.0


