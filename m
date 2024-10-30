Return-Path: <netdev+bounces-140549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3A9B6DE8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E54282936
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E221B42F;
	Wed, 30 Oct 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCzsT5cB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C221A6F2;
	Wed, 30 Oct 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320675; cv=none; b=NX3r73j4qolWVj4oIjSPInqhgxitoCz9qHrKNPo33TfkzIHVg6aqQxkA7jX9PbQEHtLlke5BWMjpjFUILZQTzGDEb17aNR5yIhnXmYIM963LlrsC0H2uflD1w3t2/4afM+fg6qiTJFzjn8gOMrF1HwRdOB079XV9gQgnz5VZLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320675; c=relaxed/simple;
	bh=39rMKr6P9uONlLHbEfUR52r0/BVHxtYYU2jmy++PC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr5W++66ezVycV7HBei6y9rK/lfthP+2vi+DS2MF8lw9J50Ah09oCgW/NDag+lbS3Gwt+75p1AFTGqfGd24NCTzZbOmTJLXcUG/VZLg2BciVlXhSzGbvTqdZauTNuElPUSK/u52lShVsOnzoac26dup4yTVrK0EjkTbma4x5bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCzsT5cB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so2894395ad.0;
        Wed, 30 Oct 2024 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320673; x=1730925473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPFQQ5MQ7iFYLKfJ1x4ney8Y6u5IyairNMMG2cxgXZ4=;
        b=DCzsT5cBQr3DcOHrd18DRIsfFUBQ8abM2ajhvbRxP/o9z234zyNR9fo3cby/pR8IfK
         XFYMgtG1lzChjudn87jB1sQi4MRbk8Dqns5D/DCTyqg42OhOSbzua4Axc2bYoAMkeap8
         1W2RLmSV9A8rrwL8eNu2p9APG7PgafIohDZkvQ+6I+3+HZ0o0JWd+Ft4HNJbmdu0nE7B
         Sd1tu5+adxzGiZYGMsJTS0A4JcO2BzQboc1NwcAkpsiZm4IlYkiurXr6QqCslSVlT1ND
         sHo6TmbMBujIR0QucBjY2/0F5mlBYQQX7ILCA0PTgDDSfCxs5h6B/zzg681aGwfleXSY
         QzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320673; x=1730925473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPFQQ5MQ7iFYLKfJ1x4ney8Y6u5IyairNMMG2cxgXZ4=;
        b=hvsSOQQFN0YpjhOSHCai2cN5uSw2orkHOQ8+fzw8N/Xk20De3ixFfnXlpTCBW/+GAJ
         h2QJhJcLISelbpUaKxeCcSeeV80Sh8pPCHweOA59zWoUeKTo+PFaN7p7uouoh+wglJni
         41QGHN3lWG3pi9SlvRg+ukjGq6rhDXXu/N9PUkRL7S8kjX97CAbVInYDE7TXFF4zQtd4
         Nho06QT0lihjWozy1ow9aCUItWcGXXaIFylC7FIAQ1tJg7lBSMKDn5wr12UwYiOLwXPc
         kUqid7aejKkZHkuHN/KdZ553l07Casdp0tFW4MGvMEaqv9THk/hHcedKZf4GGwk2Ykb9
         wV5w==
X-Forwarded-Encrypted: i=1; AJvYcCV1guyZkiFkPRM5m3g0bbTd++BE8eyxiYwvgHCg9mmEY2lUPwF8JITGbIRSlyGcbqkB4MXRSYWGxAmKYi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5WELAYudwT0aKUvYEGulJcCv3wDcibq8RrM1fCaeY4hRZUFv
	uncjIYu6BO6z/b8TxIRizg6LBoZ//wnuu7Erdga26GisBMgj0jFYCU4LUCNv
X-Google-Smtp-Source: AGHT+IFobBB1rfzr/+5jKe4ndgUF5+rHGgIxZ1WnI+e7DYKZ2V1e62pB8MZnyKc6sZ4FgndvJ3yKzA==
X-Received: by 2002:a17:903:32cb:b0:20b:6f02:b4e5 with SMTP id d9443c01a7336-21103aaa7d3mr10575605ad.9.1730320672695;
        Wed, 30 Oct 2024 13:37:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 12/12] net: ibm: emac: mal: move irq maps down
Date: Wed, 30 Oct 2024 13:37:27 -0700
Message-ID: <20241030203727.6039-13-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moves the handling right before they are used and allows merging a
branch.

Also get rid of the error handling as devm_request_irq can handle that.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index db9faac21317..7d70056e9008 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -579,25 +579,6 @@ static int mal_probe(struct platform_device *ofdev)
 #endif
 	}
 
-	mal->txeob_irq = platform_get_irq(ofdev, 0);
-	mal->rxeob_irq = platform_get_irq(ofdev, 1);
-	mal->serr_irq = platform_get_irq(ofdev, 2);
-
-	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
-		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
-	} else {
-		mal->txde_irq = platform_get_irq(ofdev, 3);
-		mal->rxde_irq = platform_get_irq(ofdev, 4);
-	}
-
-	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0 ||
-	    mal->txde_irq < 0 || mal->rxde_irq < 0) {
-		printk(KERN_ERR
-		       "mal%d: failed to map interrupts !\n", index);
-		err = -ENODEV;
-		goto fail_unmap;
-	}
-
 	INIT_LIST_HEAD(&mal->poll_list);
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
@@ -651,10 +632,17 @@ static int mal_probe(struct platform_device *ofdev)
 			     sizeof(struct mal_descriptor) *
 			     mal_rx_bd_offset(mal, i));
 
+	mal->txeob_irq = platform_get_irq(ofdev, 0);
+	mal->rxeob_irq = platform_get_irq(ofdev, 1);
+	mal->serr_irq = platform_get_irq(ofdev, 2);
+
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
+		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
 		irqflags = IRQF_SHARED;
 		hdlr_serr = hdlr_txde = hdlr_rxde = mal_int;
 	} else {
+		mal->txde_irq = platform_get_irq(ofdev, 3);
+		mal->rxde_irq = platform_get_irq(ofdev, 4);
 		irqflags = 0;
 		hdlr_serr = mal_serr;
 		hdlr_txde = mal_txde;
-- 
2.47.0


