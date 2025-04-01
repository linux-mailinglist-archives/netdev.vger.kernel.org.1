Return-Path: <netdev+bounces-178588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50DA77B1A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC316C1A0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717202036FE;
	Tue,  1 Apr 2025 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw6SEcvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E51EBA14;
	Tue,  1 Apr 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511008; cv=none; b=dUDhRKqlGiuZi6pXToNe2VGX5wlNVRlJnfrX1dUIc98LIsXt2WxKK2Z4eAWHqHVun7bZUoKPj8/BYkkAs+bthq1H7nhgCWLvOtV3vDpJeSwO4Pf4rez6Nvg/ueOKiepRVvSyiiYmnBCmxY9s8A8UDti4Xx2E9d2OtYJgRYDQUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511008; c=relaxed/simple;
	bh=SMxVGS/Buv4fRdofBLBNHAFpGHxFUKN37Cye8ij6Jnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ri+vEomjsSisB8idnAjD4kr0v+rh3UTUdqe1EzCoGT5VfTSyyn8fy9QCiIS7m68M2GwCyOp9YAvehfO7fNEdTIivnfSYNfz9nWiPFa3fSPRLPYuYwtJqtyZB9P5+trlJSnU+hDhocb6zUm+qhJXqkOUOZmvGnpmpe8syoFdfN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw6SEcvZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227aaa82fafso104573815ad.2;
        Tue, 01 Apr 2025 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743511006; x=1744115806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kOWsBcQybX4AdwxCjxqVL+WbP73O/Z+BulTPIY+zAE=;
        b=Xw6SEcvZUZtMY4WKi1n+uIxRC7BhJje6tmXBOczzTAB0GokAVrEPadjP8+j7JcCH/P
         fh/FZr2d7XApaEgue6RnqYik6wDj0ggVsq1TDk71FtmGh/0K2INqBgs2fbnOk9D1hrZm
         Ha7OzvxpC6NTFuwnNJRSUSyDGrF/WqRKMPNYxusoHCtds2nDoTMJ8X8gDq09hHf7j6m8
         kwI/pDqlsGXNZjBF/42Jrj/2fJ2s1vY2TarjOFZYL7yECZXVxZm9QJnrvDQg184APaX3
         3x8SmarjnzUK+eWP+ixszeTzXVWDjcmt/w9HGPrrowd3Xj/BYVVr0RkPl60tqNuzmaD2
         623Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743511006; x=1744115806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kOWsBcQybX4AdwxCjxqVL+WbP73O/Z+BulTPIY+zAE=;
        b=kyk5e1JFLJyfbcdi1RIW3k8zV9vJV1vDAuL3jBxf9Bqdcay/NHphkT42tjLQ2gdAcQ
         XigIXseWChAIflZgKQJsaPESPh1BG3q1IEl6igS56sspJyHuS2nVaR1jH66wvTqxjxMz
         46vIFZvTxR6W5nI7Wu1kbsHwqkeMgshB4vOpJrKBSoBcNmiUB7ObjwBTFYAXewOg7KKB
         HK8PsT2jHHpUV4qvbHgt97Qkum6E7GEZEFoMSH9OoN91CKFenibhdhue9LxL/HGxDk3T
         /Vx52pMIzgVj+bGq8Lks2dLOqM1aNql1fdS7uGEMzKM5RBrhpA4yDogGhXkvvIpa/wWI
         myHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2R/caAgjtVNv4WPw6/HaiSrfVUXYFiUKXPDyfSxXx22XouZztwTz0DKvhzGpbD5Gmgqyl4/FiGTfxEBc=@vger.kernel.org, AJvYcCVFoWwBiv2VlN7b9S+d1L11EHzdcQohHN4MsCaNjC+GaX65rl/KZNOhrdBevvCuCqNcls/GZidkzmtN@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmx7bHaIbMTOvUDQf7t4h+FTzdzwvpaiU21+RxcQ8m1PRf2yr
	H+XRK0iuuICx95ucq1xrcH//u08WZcSQQdGOfz863FSgya6gm6SC
X-Gm-Gg: ASbGnctWd9YHQ45TAnXUhDCbBgYcJdaQIz2KVS+siEMhBKzvEvOjAEJgWoLe5T1Zamk
	Man42v3WYHe3DOVkPZH9/+eax66v2VB0cteVZ+axSs1Ia4bJf6qiwvJTKsv5OYYoflXRA24Ks0q
	TFSDsHzpzL6KKl9xQPAkthXlvcVQ3fy0tlQbl4L0CrRC2+sqhYe//pzjuhLajysD1C/yu5vxg59
	By8+q5KTwyqRb7O7EQEa62CFikmzFYGXkiMtaRcTfytG+ZrJdwRNFYrJ2QRuEhJRm/CIF+YytBK
	Osip5WDZy+XPxHLZTLetCryaNpjDfWfx53I/T6EcYQPKOTlkjI0aXdtiwCcL80PWVj7ZeExGOB+
	1saY=
X-Google-Smtp-Source: AGHT+IGQHPJ1r32yqZ9I9wKeIBrXrtyGaI0sDXqxyakU0oi8eKsOICRD+72kOB+Mw2dnXiElAgQiMQ==
X-Received: by 2002:a17:90b:5686:b0:2fe:a742:51b0 with SMTP id 98e67ed59e1d1-3053216e481mr17772883a91.31.1743511006184;
        Tue, 01 Apr 2025 05:36:46 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e1139fasm12699199a91.25.2025.04.01.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:36:45 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ying Lu <luying1@xiaomi.com>
Subject: [PATCH v2 1/1] usbnet:fix NPE during rx_complete
Date: Tue,  1 Apr 2025 20:36:32 +0800
Message-ID: <0ed61e6aaa99a692a09f074c9f0057e47a2d22ec.1743510609.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743510609.git.luying1@xiaomi.com>
References: <cover.1743510609.git.luying1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

Missing usbnet_going_away Check in Critical Path.
The usb_submit_urb function lacks a usbnet_going_away
validation, whereas __usbnet_queue_skb includes this check.

This inconsistency creates a race condition where:
A URB request may succeed, but the corresponding SKB data
fails to be queued.

Subsequent processes:
(e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer
dereference (Kernel Panic).

Signed-off-by: Ying Lu <luying1@xiaomi.com>
---
 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..5161bb5d824b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -519,7 +519,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 	    netif_device_present (dev->net) &&
 	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
 	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
-	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags)) {
+	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
+	    !usbnet_going_away(dev)) {
 		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
 		case -EPIPE:
 			usbnet_defer_kevent (dev, EVENT_RX_HALT);
@@ -540,8 +541,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			if (!usbnet_going_away(dev))
-				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
-- 
2.49.0


