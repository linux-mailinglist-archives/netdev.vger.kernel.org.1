Return-Path: <netdev+bounces-105409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B3911016
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BC91C251F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153121CCCCD;
	Thu, 20 Jun 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUyKx6y+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A91CCCB8;
	Thu, 20 Jun 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906308; cv=none; b=fYjixBD1fBMqu5Rj2x71Z0I/tbccGAr4TEZXyYqum8VauIkarrvYHa2zACfx2a22WxGdsrfsrkJHkKd7lX0fNrufRfYvN0bqAtG4sGp4rhJkbu7u8v3RxeKZDFulxTc5daxlSmUx6//QdzKFjYWoTKdCiRJoS1os1fGNboxqClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906308; c=relaxed/simple;
	bh=MMONOtKUaLQgb2KMTa49gZOqkZLyA88DR8AvElxOfHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWd50kujfpVL/UUU4xdnVIVHUlS3ZWFPdKq+G4Ty3nxDjp/02jW7B+GeDGbwLFWH5w0Y8/G2znPv9skWAFNZYhEuXFtOd92WLfz7DX2LtAE+KERG28/yVYctvOOlDjOYm3CYzAbhEhsm3NTp6/hfheAOoavnLkTxAr6UcrJ2PnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUyKx6y+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9e5fb4845so42285ad.0;
        Thu, 20 Jun 2024 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906306; x=1719511106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VirWasie1qW9f1ZDCT7HBbnQgPTV5Nl+uIgo4Ud+Ow=;
        b=MUyKx6y+yg3yfzqY1Vq6O8XXjsXOsgvLbND/QgSzh7xhCYBWAouf8aVDhfwa5Df6ow
         AitCEmkOUGfwfdEZHH8fRDlLoKmp6aGd1XjqzTmQMcQKMMtBffwXl2x98NjEX5eHlUUE
         b87qXUwsvyT+hoE0iFkdDbM3cPQ2bF6o0+CYEdNWtM6QfwZklHDUiD18qoIbO7GxTVKZ
         5nJ0dJO3BGi6x5BAPEcVwQ1HdSR8C9ln6NFCQeUIKdpH0UOqVqVwMXT407ygTfxsQEHY
         0psFBQDVfVCCom6ILSsbJk7HiTozJALltXVQYxV/S7sLrhlJ3WGvT6Sw5XiyNHYvw7gM
         OuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906306; x=1719511106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VirWasie1qW9f1ZDCT7HBbnQgPTV5Nl+uIgo4Ud+Ow=;
        b=G8nkmPovV52rQyuThsIRyAO2P4mY7rrVgvMITZkVyTIfdLGV39P2TZl1rGujm9zkhK
         6UBjgRT52bDUisW2c4GI6o7XF8hMXIrema9I/n48PcqWV3uN6HdaoiV08TGizRTyK2rG
         70ISuOAnEy4ovRxk5ojdy8UEb7bFqutaZ1EMwdXJwQp661g6QzqyhkTp6NFRX18y66Cd
         rfzvI9BCssWSzLd+VjG2DmR/2hP+XpUCzhbxHbMfUwMT8xA/Sg/0GYxVfc9IKvKl4+zz
         Z7FJqSZZqb2vz5zlHBFuOxsYWVbB6tRSp7SwUmAirXlxING8b2HM3FsjHM3wtDHQsaDU
         uUlg==
X-Forwarded-Encrypted: i=1; AJvYcCVoGC+72kDVXKEzwxxgjF4YhoKGzZQvjv4EXIqumcOrAx81tH2p0vh4JL+HrhaXueEp+9e2PnTeUEUlMWVRrT3vgkcRGZML
X-Gm-Message-State: AOJu0Yyud7JL4+KqIksXXm9Q8NV8wNEBA25s7/YOBgDYv2z++9F/3kex
	LHvVBJqNO0hAqhrcR0tnNy5X9VIUDKUyUg6QlBOU7KtYBek2ErpxixfpzqECqHA=
X-Google-Smtp-Source: AGHT+IGsYwTXJlieKXLf9Y84hPa5gN6g1kURBsnd/RiHetV5GGng3zA8q1keb8ZyZsxbKZxqnzjz2A==
X-Received: by 2002:a17:902:d2d1:b0:1f9:a602:5e1f with SMTP id d9443c01a7336-1f9a8d5f164mr93863805ad.19.1718906305998;
        Thu, 20 Jun 2024 10:58:25 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9986d3130sm56082585ad.80.2024.06.20.10.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:25 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 27/40] ethernet: rocker: optimize ofdpa_port_internal_vlan_id_get()
Date: Thu, 20 Jun 2024 10:56:50 -0700
Message-ID: <20240620175703.605111-28-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize ofdpa_port_internal_vlan_id_get() by using find_and_set_bit(),
instead of polling every bit from bitmap in a for-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 826990459fa4..d8fe018001b9 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2014-2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
@@ -2249,14 +2250,11 @@ static __be16 ofdpa_port_internal_vlan_id_get(struct ofdpa_port *ofdpa_port,
 	found = entry;
 	hash_add(ofdpa->internal_vlan_tbl, &found->entry, found->ifindex);
 
-	for (i = 0; i < OFDPA_N_INTERNAL_VLANS; i++) {
-		if (test_and_set_bit(i, ofdpa->internal_vlan_bitmap))
-			continue;
+	i = find_and_set_bit(ofdpa->internal_vlan_bitmap, OFDPA_N_INTERNAL_VLANS);
+	if (i < OFDPA_N_INTERNAL_VLANS)
 		found->vlan_id = htons(OFDPA_INTERNAL_VLAN_ID_BASE + i);
-		goto found;
-	}
-
-	netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
+	else
+		netdev_err(ofdpa_port->dev, "Out of internal VLAN IDs\n");
 
 found:
 	found->ref_count++;
-- 
2.43.0


