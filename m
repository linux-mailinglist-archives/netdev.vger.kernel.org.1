Return-Path: <netdev+bounces-194519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F139DAC9D4E
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070D69E070B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63E1F4E3B;
	Sat, 31 May 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWHCniFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523C1B0F19;
	Sat, 31 May 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748731826; cv=none; b=SRM3FDTlUem1XH7LL59RYu+DQu9ANsA1Qvvc9E40LL7atRXXI0PhMr0lYUcY3ApPGyF9/8n40GyUv6t5Qzn+YI21eaJyH3FCBjK1DDJgEox66Z7cbpsevx1y9wYSjxPYZF3MY+kMBB239wWIDDTcHvBRI8FHGVVbVzHFrU2+q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748731826; c=relaxed/simple;
	bh=zJTjdCr8yR6jka+8Fl6/XXKV/YPVY/4YWXAs4bcR55U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZsGH28vI43Asvkh5ReA8Ao5MRMmKQ98LFU5K9FSBoqXc+gQmEIrJMG1ZCzE7LV1DWSIsTQarErThVQfb3jwVKQpt/WMQkAwaWX6l+HmrvEl2Zu6oL6FIItOEzInT0VvUMlxU6b/G77fza9GNZmElhFk7gGDOTUX435h+uj2dSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWHCniFT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso592237966b.0;
        Sat, 31 May 2025 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748731823; x=1749336623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaer8KAt7DHXZvrLCnz/sCu0lhGcXvLJk84mttxt34U=;
        b=cWHCniFT7s9j3HS/K9h8yL6qi02Y6tCnyZrrVh+oiC4cgCHACrUMQVD9Rs9BwLCylt
         Q9CsqeHzYezP41okDLGA4D3+KBuUgqBG68QrM8G5TYnbe4XH6tOVEBP6/9xPXL6DxWbI
         AYd6EgckRqAcyhvFslt3QWAdv+9ofTkfU+AVE5tiGlpizzZWC9o+CVF7AinWUocwGNCG
         es6u1MPmRcUiy1xf93MFjc0djSvbQY7IP6GgI1A1bIEXaZcdoyXKTC2x/vMj7IoMAe2/
         SC9nBJqI49wJVhfqQKwLB1pAXMGR9dB3eT02Jx2P9Thq7FMokwUq3DmATCASdIRHpunq
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748731823; x=1749336623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaer8KAt7DHXZvrLCnz/sCu0lhGcXvLJk84mttxt34U=;
        b=FLortOG4u5cZg+kWR/+SZZlAtglF1gR7wyJzfSA86MxKeO14zwtLjG4xdy72v8w6cE
         sVi+obAbv79qR29SMGg+S+BqODmM4h3HTR1gJq5TQYbihm9CKvYdHHMpBT6DFmtIzUPW
         EKHxl1fUaxFzQPN0Cqtj8XQtsF8evwOADzk//ZOxgaJ7zdbXnH35bFDddanR2h5Q+bfj
         wj7jgiwwHZUAY7D76Gv4l55AgKdD5z2be9HXa5PimvXfwVGaWmItycNJtkOY+9rFv4nN
         yOPti3RLmjgWXCfuEhWkXlvHhPpUEV3OdaWUPy4zroGDVXn+hjGjqLY3E3IiMSCwL2LX
         4OSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPjyx1ItWDskFTAw0pEATHe9oKoz0VvLlXQWnByl0N6shpDMmMIs1KNY17zm00ZpvOS0nK93ejlhkhQRA=@vger.kernel.org, AJvYcCWkktK89MUWrda8DTKdkvvnIURVF8F8/ODgfDECtXyO5himusRU6VJ9/83IdhpJ9qB0A3WsLNv1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6yNWIRO/vycxgKktRVa3FIK/2V32bM7EkMQvQd7rR2FIDkBz
	1YOQFln+JZ7E968o/n94KkIuSr9CaGns3mETwHwfY/GqMTyFCICU6m8d
X-Gm-Gg: ASbGncv64xC+8/wB2lxqD+URngEsumSLyA5Zzs7Il8KXK8SFdykstMwEGAOuuucD4In
	FYCV0rTHK8XMouPXVxqjPFMNfxqt/oLTi/INiunH/Q+QHca5sy+Pl3UlTscsOluJUQZDJX7bUJD
	swfoPrkvTzVPZspVn78znrTZET3EkTLsbaYGKAm/QAd/bM4TDrShu9sOyY5ZE+PEJdrn5RG4gor
	gAS+WCZ0pXsBpF9a92EDdQkExw38hz4NPASH+riUSk7+U1kMHgJvjMJlDmktL8IDB0wXdaZjaE/
	5bwJ/kkkap4GPBPBFWmjc0lvMv7N56KV/tHZ4uGX+vcV+0jQt5obW/R8s+WDnA==
X-Google-Smtp-Source: AGHT+IHn/Dpdb85Wh1MjKffyrYbxU1fvEdgCvFGBMMM46bHiTje9aueKK1J/KMUEBFaESM5G5KG92g==
X-Received: by 2002:a17:907:9801:b0:ad1:e4e9:6b4f with SMTP id a640c23a62f3a-adb322b2c9cmr765323466b.36.1748731822570;
        Sat, 31 May 2025 15:50:22 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7ff054sm562918666b.14.2025.05.31.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 15:50:22 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v1 1/2] net: bcmgenet: use napi_complete_done return value
Date: Sat, 31 May 2025 23:48:52 +0100
Message-Id: <20250531224853.1339-2-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531224853.1339-1-zakkemble@gmail.com>
References: <20250531224853.1339-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the return value from napi_complete_done(). This allows users to
use the gro_flush_timeout and napi_defer_hard_irqs sysfs attributes for
configuring software interrupt coalescing.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index fa0077bc6..cc9bdd244 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2472,10 +2472,8 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 	work_done = bcmgenet_desc_rx(ring, budget);
 
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
+	if (work_done < budget && napi_complete_done(napi, work_done))
 		bcmgenet_rx_ring_int_enable(ring);
-	}
 
 	if (ring->dim.use_dim) {
 		dim_update_sample(ring->dim.event_ctr, ring->dim.packets,
-- 
2.39.5


