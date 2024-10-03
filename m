Return-Path: <netdev+bounces-131456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542B98E85D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06602879DD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AE1494B3;
	Thu,  3 Oct 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcPZUA6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42255146A9F;
	Thu,  3 Oct 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921523; cv=none; b=MU1bAETa93RbW/WaKkSrEryUnFTi6T0vCVt9iH38/Rd288IQeYu0vxNCOUz9fOFI0kzB4jY/z9pSe5ZiHsZPTSWxhMWirvADO6AS7+IH0BeHMQzS4RcWynNKqbl1WgVNGBgiF0v2ioML4GkeApWmCMqbPEdowFCkdDAkHjSxlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921523; c=relaxed/simple;
	bh=xkMQUJ+a/seJ+Y5YjIAKxVPqeaNfl7Neu2vo2r4t7VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ewx0NTmyfzdcmXAbbiZblV10nUeWNtT8n/SiStTklkT2JyjTi45+4fveQpGotVahqQqNaunhsEBbg0tQpCuMzy97rnLmpLk8m3PX6yJCONVuwL0cH2Vg8kDxj83LQds0KpPq/VptaomkLwARW33qkvxxZBEP8TCxyElSDpLDL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcPZUA6g; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d91eef2eso340832b3a.1;
        Wed, 02 Oct 2024 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921522; x=1728526322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KWs0i5ENfOJtknzBiWTETb7i51VBhlSos8aop6cLiw=;
        b=RcPZUA6gUFD+gZDXGZj69L5+olar5xGTHyDoeGNnSQ2fo+R6tGmLyhKDv9mzaDxUJG
         IsxWMBQTCDX6Ng8UBqbWOwwkKPw/fEIOuJ2lvPiIGz/Mt1Z1V6E0/9QHuX/znJGCaLYD
         gjWw1931eCQMB3tvTQWsmq6T5NHdFa0opupkgmz+xnNxFz28s+DlZ8Em+dKDKlQ9o6UM
         1JgLboV2u2GmOwN/OEf65PJFjOMBycIvd9nWX6s7Zl4lEgBZOsOFJMqW7p0hl6EyhTnO
         Ik4iL+iPQW4UD67jXmRsRVUOJEp3zyjmtvoT9C66jMMPyMKdM1DTX4y2sjIqjbNALy+N
         zOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921522; x=1728526322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KWs0i5ENfOJtknzBiWTETb7i51VBhlSos8aop6cLiw=;
        b=GlKgJA04K879cAdKjaMgXlDa39TLMSOrguFMJ3W6wFWWjIyg9Zw59mT/dY6jEKQQJz
         n4KPN1HnFQFg3Uz+b667ArWg1md8jlsor+LYkCKii7EOM/oPxkc2XucXnzNAHR9HzVqH
         70mQ+u1inOzc/66daXib1fCAcqZUPgvXvDT/wWJhnySnLGuB+3MA85pPyVyIICAX+McB
         RHAz6fdLA8F3swpgeTkSP17CA/JgPQUKMFozkdmFivE+1h/bFf/NyDB1oaJScW5tUSbj
         GefxUwOi4BPS3F6eWV5l9JXB7WDTK7ZxbdcDl27j5nVEJorj3y7bGmofJC+hOOJe113r
         ED5g==
X-Forwarded-Encrypted: i=1; AJvYcCXOiIdcP1y3F9cuggzpbs0PrRKExvkg9ag1Gij35xPz13nMRS07dWO00XSn/lJdNAMrqXIn6Lz6khcDnYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUv9RvwuwmulG53lCzEmQClj7NUOgrblqy3K1SUl2W8S08FjG8
	OqF+hhrFxdR6O9F7gtYAMBwqiaJ2tVdmkzk0Woyr3sKZLO3QzZ/ZJdjIqh9N
X-Google-Smtp-Source: AGHT+IHRWlBQbinZxKW2YkqEgAUPGXX4BRTXhu2DQdWTWVAfAe3ITdec7ZyqTN5TGTwdmNR8o0N33g==
X-Received: by 2002:aa7:93bb:0:b0:718:dda3:d7fe with SMTP id d2e1a72fcca58-71dd5b6949emr2149177b3a.12.1727921521608;
        Wed, 02 Oct 2024 19:12:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:12:01 -0700 (PDT)
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
Subject: [PATCH net-next v3 17/17] net: ibm: emac: mal: move dcr map down
Date: Wed,  2 Oct 2024 19:11:35 -0700
Message-ID: <20241003021135.1952928-18-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's actually a bug above where it returns instead of calling goto.
Instead of calling goto, move dcr_map and friends down as they're used
right after the spinlock in mal_reset.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 4f58a38f4b32..e6354843d856 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -553,6 +553,18 @@ static int mal_probe(struct platform_device *ofdev)
 	}
 	mal->num_rx_chans = prop[0];
 
+	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
+#if defined(CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT) && \
+		defined(CONFIG_IBM_EMAC_MAL_COMMON_ERR)
+		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT |
+				MAL_FTR_COMMON_ERR_INT);
+#else
+		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
+				ofdev->dev.of_node);
+		return -ENODEV;
+#endif
+	}
+
 	dcr_base = dcr_resource_start(ofdev->dev.of_node, 0);
 	if (dcr_base == 0) {
 		printk(KERN_ERR
@@ -566,18 +578,6 @@ static int mal_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
-	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
-#if defined(CONFIG_IBM_EMAC_MAL_CLR_ICINTSTAT) && \
-		defined(CONFIG_IBM_EMAC_MAL_COMMON_ERR)
-		mal->features |= (MAL_FTR_CLEAR_ICINTSTAT |
-				MAL_FTR_COMMON_ERR_INT);
-#else
-		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
-				ofdev->dev.of_node);
-		return -ENODEV;
-#endif
-	}
-
 	INIT_LIST_HEAD(&mal->poll_list);
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
-- 
2.46.2


