Return-Path: <netdev+bounces-131062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610398C738
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483861C23F3B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E331D0DCE;
	Tue,  1 Oct 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR+DWywV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6941D0B9B;
	Tue,  1 Oct 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816354; cv=none; b=lnufP8+F68jjrlkNB5IdlZHu1+0nVgDtQNuEunIRwI6nqNdaCpZQCVrigX3JVdM4db9D9wiWQqYFCkF08o6GTlmyhxxFtH6mpXwKWI/asXFDvf7RjVR/isZeRAH5Sjjd6kBMQCyxeonaiYh55G78mn6e9J0gbcGchO8CoMEnMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816354; c=relaxed/simple;
	bh=kIpYMffnv2Jsrflqi0UBGLS1xlxbxCI2z0viDXyO2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnjYsfqEGWC7GtoQ1tyVQ+cWcg1ZdFVoaEYmNTbuBtqpULiCOZVh43n6sQGiPQjvJ+c5hu4hHwE5xVZHzI2WyXKNrtoaLDygW8JQ5CIGbOqp4wtJMuWxYT3+Qbi6uQkNWWimKqvIfBSLBk1fYFHIE7I4oSj7jzcoazdAf9tQBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR+DWywV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71dba8b05cbso1241041b3a.3;
        Tue, 01 Oct 2024 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816352; x=1728421152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgLa4BgBe2CooTJVa2laJtRpnBqwaZiL8qbHDW7oMYA=;
        b=WR+DWywVw07tJUa4AmpHNT+ZDjZ3VmzLMgW8i7qG0mAHpq78tFkXIZVIGQmGy83R8f
         4/ErweOX7NSa8gY7PG3yrrX9JjNn6z3kI1R7qjpSc2b1wTTOyrf0e6i/vRyooUElsaAi
         0Dh8a1JevnzGNKtFGM1SJ2rVQhA0tqVhhTF/nfY5SSiFsObgoA687pVvJWBNqYxIW9aX
         hecVVFekd4sJlFhq6+5V1LYg25tIqSEXAD6gTj+QG8sIZT28OZOFoYp761GeHP0cEgrn
         qvVCSntQc3H8aTlYH1EDQ1A5ciNyxdKomzWoHzOk8koGBnpuhGMwoMtr7r9vXQsVHURP
         DINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816352; x=1728421152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgLa4BgBe2CooTJVa2laJtRpnBqwaZiL8qbHDW7oMYA=;
        b=fSBv01Y/Fw6a6lO1WMgdSTyuvYgDxF0UAQ9zrlBps3kOrB5JyDMiFTJFNdOGFM5PSj
         OKXoo8EctmK4W5E0MFKzI5XQCSRVOx//xp5qa5uG5zDOGsfPDebYESc5oMQ0vFkYT7p8
         xvQFE1IBUCrWaFknXMBXyhbpNLDV4xMAlyQPPtvFBfGuqBfLOhzSix8p4NEj+mG/O5J4
         veXPqgSfp+uNRpVwCaVdMUsPCDZXf9dQgflloPupzZmgiCd4kc7cpA1wZqWNpepUfg7A
         hbDZWWRreZxtuw3wfpAAGI5KSkd+xhAk/08FBVgGolkYFXdXoKVmqN3LnG4Bn+UKFhSz
         M9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWDm4x90BRP3VNMjX6vOMUSzCXvR/fvdFJ6cyHldH5MW3qRTVKI2jW9jBwNKqW9W4/OoxJIqy9Ba7zLQCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPJ917svFXx3RSW4OP1qa6tjm77ArFt05CQClsdNTNJKbKeex
	x36hb87kr2l3hvadEwGUtL+bdw1oJy6GUJoVdE9CTcoGUJEsdjQJo0oFoRsu
X-Google-Smtp-Source: AGHT+IEEpCmC4VF8DcR1Mhn4JEwlfphG24IusTTuqQgC6OU/ggYnxNm1+uQpMVsg/LtCAHxajSowHg==
X-Received: by 2002:a05:6a00:2188:b0:718:d9fb:63e1 with SMTP id d2e1a72fcca58-71dc5c6726dmr1526542b3a.10.1727816352520;
        Tue, 01 Oct 2024 13:59:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:12 -0700 (PDT)
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
Subject: [PATCHv2 net-next 18/18] net: ibm: emac: mal: move dcr map down
Date: Tue,  1 Oct 2024 13:58:44 -0700
Message-ID: <20241001205844.306821-19-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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
index 2434673ed00b..259f38950b6a 100644
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


