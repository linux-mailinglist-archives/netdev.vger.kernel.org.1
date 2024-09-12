Return-Path: <netdev+bounces-127645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6824975F2E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC8928566D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB5156972;
	Thu, 12 Sep 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jddS98DK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A015381F;
	Thu, 12 Sep 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109355; cv=none; b=poWOycfOa8h91ogaOGX9wz8o6Ntov0zYD8wBm56wuM9KX7Ih1pzcyLXbaYaHV1IW9BYIkTZlMkuSRGYo2Xc4eYEKuPq60/PDQRbwslIJ17ZLjYateEWuY26AkeiulAjvn07O6XoVEcnSV0yUJPTr6XQ/IWIV19WV4nhtZCVXOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109355; c=relaxed/simple;
	bh=cQL5yPbQcYe6yme7gcbKAIFuXBiN8YmNK8P5nr9cbPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2mPaPEJLuiG0h1sCUqtRC4pVyN0cIpYubz86F6HCtm1B+T02eEKjQmEHALotOBkLDTIZIY3170XbcRBz2YjrsQDME8devgH7BHkLniFv2kp6V4WqUQlHy9BfumWKi4dW6bgiurLVLAroWDkSxG4HtmGZMFqL4rdoXALeqW/9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jddS98DK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso319779a91.3;
        Wed, 11 Sep 2024 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109354; x=1726714154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdM6LajGMTp7t7LfZYUjKJErX6CVQyZIDaz77Lj5L1w=;
        b=jddS98DK0Pyobm+uMkoe2lQhe5sAwisRDa2DhmhBy9sUzcQwq4F4wHwQllnD2rs2V1
         OBVAg4Uob5yvcX22Z4bGEIKdi2HofFu5t4r+sZFQC8d0PbvN/ir6R0LqJxFsxezxhAS5
         Z1qZM2BZcLGGeGC2SwUORjvq208Jh7s3JNXLfOZnzisKjsD6q475LnlFTxqpfhQ2Nv9d
         2H5ojR8dV8xACZTGFMVobshEV28ighCD1FaUE0tmh1D6D37/Of5cRZuk9S0eFSkVHmI8
         RLnfBJyF6pe/gAq+8Q0Zkla100ovT4Y0hA6LuqhJ/gmju7StBCvMma+Tcykp/qpRDbxI
         ErHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109354; x=1726714154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdM6LajGMTp7t7LfZYUjKJErX6CVQyZIDaz77Lj5L1w=;
        b=j+tkB5qb9g/aP+ZKpJvSxgIkFIeNFkvpCkwjtWw3LRvzxSpgLLEr5T/9oV9OH3fNgA
         AePQz4VMenJc2m5+dwE4J4NzPiOxG7xscnuOxwVqFUZWA8fexNUplP03a1KmYkZ+uUNX
         UDDq/gudwQYL3ok1dpNN/C80qjHSWTXGZCxj83LCWIFKr515H0CJ99meVUm5VqlF7SAf
         KyjYQSz2CWLyEStB94ElSVtOZfq2HEC/m4XW1eDZiv3XAElrC6oIB4LFyUazWmeeUEoa
         X+HLRG0HZVOab8JQc6EzgoRTD1jsmjz++a2fvwRJTikpMiqV91ErN0NZ29olCCobP9Hc
         iHFg==
X-Forwarded-Encrypted: i=1; AJvYcCUh6qHz8qEy16DRg2R4da+RpRW4mkGu+DRNz5297vqnbxRm77zeBw1dY7arGMBRzpkwHiohagr+3l3tXmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUB7DeC4/8iw4M/YlrFlCKT655yGztNi0eG6s5SYMjHiRcDQhp
	M5rF3oaDdMxftY6ZKGRzk9P3IjYdeI1JA69waoY66A/Zy0VhOSQJGIqI/qk+
X-Google-Smtp-Source: AGHT+IHFoUgida2Frn96ClWM1JjgBIz73y8GF76HHUxNIvJ/VpSIEvpi/zTbF8meQnsOXf1MEF0O2w==
X-Received: by 2002:a17:90b:5252:b0:2cf:2bf6:b030 with SMTP id 98e67ed59e1d1-2dba007f3cbmr1605938a91.33.1726109353588;
        Wed, 11 Sep 2024 19:49:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:13 -0700 (PDT)
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
Subject: [PATCHv5 net-next 5/9] net: ibm: emac: use devm for register_netdev
Date: Wed, 11 Sep 2024 19:48:59 -0700
Message-ID: <20240912024903.6201-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleans it up automatically. No need to handle manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 9596eca20317..65e78f9a5038 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3182,7 +3182,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	netif_carrier_off(ndev);
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(&ofdev->dev, ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3248,8 +3248,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	DBG(dev, "remove" NL);
 
-	unregister_netdev(dev->ndev);
-
 	cancel_work_sync(&dev->reset_work);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
-- 
2.46.0


