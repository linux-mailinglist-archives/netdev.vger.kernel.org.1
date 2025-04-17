Return-Path: <netdev+bounces-183594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB6BA91200
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 05:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1D33B8801
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143E1B4223;
	Thu, 17 Apr 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh5SKE0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF4366;
	Thu, 17 Apr 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860365; cv=none; b=jceR3CEnxefXrxV1maxoCNgLUl8JN4DBo12MDBWgjem9H6u+S+yf6C0FKDY584LoOnVIk9aisgU4Ev33Q28ozYZgU4McbiKNJbAV5tkefvSaaNxxF6CFGGH7ZB/Zl4ouqTWcrsIro4DTK8vs1TphdqJtRAUAHwpTJwiAMfsLWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860365; c=relaxed/simple;
	bh=7sVoXT7XKlN8U5vje+Hb02RZjNt/UJds8IKOz4ZJvys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAFuqpFvFrC7xvbAD3dcjLjR7wBozjJyUtk9BVPGEtcBxj/iltnuvU7gAA36Xiz9ns2elaFsmc9CSgqENQp9kmWpnx9zbW6lbUnO7sjX4uBJ2t2O89K4EyRVgBxrcPRyUFZdBQbUCo8EOZDHhMlmucpFcqtga+kTcdlPokBd06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh5SKE0i; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so186933a91.3;
        Wed, 16 Apr 2025 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744860363; x=1745465163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rS65ywkzEPVtHQpoEzb/xOFumWoUK7lTFewz48Ob8M=;
        b=bh5SKE0itvUQR0ltFvdZ/04mxVCE6Ww0C4RmWV9X9ofirqHMVbDGt9YyDOpkEq2o+p
         YZw5unH7E9MOzFopg/PrgooIsvZCTV0FTlPma7sv6MzbVCymYdkxi3iQfc+KMVhkVLOc
         Q2VMWiSdQNQqTTQpFRQseOiptKb/+yLWdROACdcDQW2DSWR8ey2593eDoCjvNNWHjoUZ
         rpenwGCXyCex6KFi0P+Yoqr+1gNcO3Qp35bnZ3CspJa+vWfijpRzmHv2hTB/NYK6zEDc
         A9rQduD3gHjk7NcFwKrWLSTRB7za4D8RIAI3x+Vz9qgFRnp5Nv86nWT+cndDLljbb9wX
         AGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860363; x=1745465163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rS65ywkzEPVtHQpoEzb/xOFumWoUK7lTFewz48Ob8M=;
        b=hpOT7SvF/GWfNpCVGH4rzpYzoYxbl49QULPCTJmxzcTzO5OY9a10ynaEfvBx12OcPL
         20KnhkLxbNWrpRhxI3WlcB8ruYSWSf/PTGvGlEXoK6nGWEaRwSg/b6WtmWg1nHgijrTI
         E/Fw9EDrKregDtItPJdTg+JnY2ZWuyzCP16ELnd09CA7OHA9YdOB1SBKEshY4M1tFiNL
         LbMkAOkRJNUDD9yfqa+GrlZlMEg5Rtdv1cB65kXJ9DHJAeNsRSdJx52LlagTni76OpM5
         0FeQyYlhjYw7hT1h5ZKmOOTj5hzW/u0ZZQ8wgtsAbwUa5y50vwbm5ttXnpkz7JBYA0tm
         f6og==
X-Forwarded-Encrypted: i=1; AJvYcCWbEoVq9YHD58xHnEZZYldcqPSemy48R086+n8tPRtoYcXMLfVTMn9XEGHD/UkQdsaIi/+9HcFV@vger.kernel.org, AJvYcCWc8JkjUOEd76Ir/UjazZ+rNKrRN8FfJE835VQmf80cyU5HqnFzVY4av5mNO2sCCVacLMtMKNTsJQO6K00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1/eXg0T+/AIDQSOGygBm60sMBXdTN+odH/2GW22O8ZTjxoET
	LwME1MFpJG0Ze6SW29UeJeu1b4zz1Ekf+v1C2l7h4sFl2fHHBfL7A8lf3iFjAdo=
X-Gm-Gg: ASbGncvYHMM/Rw+IPKoJFwE1cYjv2rO3NSmC77pZLTi9wTGMDWaDI+fgZ8OA5WvnMQP
	5w5LW1l9dBUMLVwYPbERkehp99LX1wrEbmaRv83v7fkyIzIQsftPi/LLizhYuRXG6y7/tGaYrrN
	ckOzNAGh5a8aQLVMdp1lYbxBhlD43EKWbHY3UpRgPp6iQHX7nO9wFVhxBPEeVU56UWc+i46SwfG
	ZvJrUZ4iJHHl+6qPSp/GQmGJrLKeBVNus9ffW96hyQwmu5Okb86dnXk35Z/U48r0RZNklMr0WI/
	LfArE0zre26lK3BluWH42FC7VrFVO+iUIw==
X-Google-Smtp-Source: AGHT+IGblRydXyNhcA3GeQ8a1oibWNPa3oj7Gy5lonhqrT2rZXBiN/eFky9E8IOo3IujZT1TbDmIlg==
X-Received: by 2002:a17:90b:520f:b0:2f4:49d8:e6f6 with SMTP id 98e67ed59e1d1-30863d201b9mr5461741a91.3.1744860363149;
        Wed, 16 Apr 2025 20:26:03 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6d58sm2485169a91.8.2025.04.16.20.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:26:02 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Nathan Sullivan <nathan.sullivan@ni.com>,
	Josh Cartwright <josh.cartwright@ni.com>,
	Zach Brown <zach.brown@ni.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chuanhong Guo <gch981213@gmail.com>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>,
	Hao Guan <hao.guan@siflower.com.cn>
Subject: [PATCH net] net: phy: leds: fix memory leak
Date: Thu, 17 Apr 2025 11:25:56 +0800
Message-ID: <20250417032557.2929427-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

A network restart test on a router led to an out-of-memory condition,
which was traced to a memory leak in the PHY LED trigger code.

The root cause is misuse of the devm API. The registration function
(phy_led_triggers_register) is called from phy_attach_direct, not
phy_probe, and the unregister function (phy_led_triggers_unregister)
is called from phy_detach, not phy_remove. This means the register and
unregister functions can be called multiple times for the same PHY
device, but devm-allocated memory is not freed until the driver is
unbound.

This also prevents kmemleak from detecting the leak, as the devm API
internally stores the allocated pointer.

Fix this by replacing devm_kzalloc/devm_kcalloc with standard
kzalloc/kcalloc, and add the corresponding kfree calls in the unregister
path.

Fixes: 3928ee6485a3 ("net: phy: leds: Add support for "link" trigger")
Fixes: 2e0bc452f472 ("net: phy: leds: add support for led triggers on phy link state change")
Signed-off-by: Hao Guan <hao.guan@siflower.com.cn>
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 drivers/net/phy/phy_led_triggers.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index bd3c9554f6ac..60893691d4c3 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -93,9 +93,8 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (!phy->phy_num_led_triggers)
 		return 0;
 
-	phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
-					     sizeof(*phy->led_link_trigger),
-					     GFP_KERNEL);
+	phy->led_link_trigger = kzalloc(sizeof(*phy->led_link_trigger),
+					GFP_KERNEL);
 	if (!phy->led_link_trigger) {
 		err = -ENOMEM;
 		goto out_clear;
@@ -105,10 +104,9 @@ int phy_led_triggers_register(struct phy_device *phy)
 	if (err)
 		goto out_free_link;
 
-	phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
-					    phy->phy_num_led_triggers,
-					    sizeof(struct phy_led_trigger),
-					    GFP_KERNEL);
+	phy->phy_led_triggers = kcalloc(phy->phy_num_led_triggers,
+					sizeof(struct phy_led_trigger),
+					GFP_KERNEL);
 	if (!phy->phy_led_triggers) {
 		err = -ENOMEM;
 		goto out_unreg_link;
@@ -129,11 +127,11 @@ int phy_led_triggers_register(struct phy_device *phy)
 out_unreg:
 	while (i--)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
-	devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
+	kfree(phy->phy_led_triggers);
 out_unreg_link:
 	phy_led_trigger_unregister(phy->led_link_trigger);
 out_free_link:
-	devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
+	kfree(phy->led_link_trigger);
 	phy->led_link_trigger = NULL;
 out_clear:
 	phy->phy_num_led_triggers = 0;
@@ -147,8 +145,13 @@ void phy_led_triggers_unregister(struct phy_device *phy)
 
 	for (i = 0; i < phy->phy_num_led_triggers; i++)
 		phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
+	kfree(phy->phy_led_triggers);
+	phy->phy_led_triggers = NULL;
 
-	if (phy->led_link_trigger)
+	if (phy->led_link_trigger) {
 		phy_led_trigger_unregister(phy->led_link_trigger);
+		kfree(phy->led_link_trigger);
+		phy->led_link_trigger = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(phy_led_triggers_unregister);
-- 
2.43.0


