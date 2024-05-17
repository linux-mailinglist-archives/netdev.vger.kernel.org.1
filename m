Return-Path: <netdev+bounces-96821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6C8C7F57
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E596F1F229F1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 00:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822938F;
	Fri, 17 May 2024 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdB5zHT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D798F40
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907284; cv=none; b=Ih1s74z80Wtwl7PUDowVQMNtnvuwqGQBzEYYJqfQJBfQGiHdkHAy51MqBQsHzkPcYkLJKWOz2iM4iK8UWT42xVgJ+yvYucJpLpu9Ert5vHsYEoS3gC8HvPHMVskxQVdzQQQh31/orCUEfsUzWyMU/tEySFyi1mgUGTiGO6BBtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907284; c=relaxed/simple;
	bh=FtYIVThiVc5kbXnFXbYwegoShTqdkJ9z2ffacyMPDHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V++71BZTvyA9P0qkIUvQLT7B9FpXLbnp6FeTQLaJSY2CCzmL/zULLZp2mwU4EQCHUv3fab+aHrhSOty6uBoh+/IQlr39wisIf/XwtVJTy//EnD2R3xQ7Cht5JXjBPDwjIVCtwuOtGlolXSQGl1gr8a8dyG5M1tShbVKbGED9Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdB5zHT3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed904c2280so702625ad.2
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715907282; x=1716512082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSqMKNX5OHYStDn4wL1WzMGVJvFLse/6VPSdUAmxlTk=;
        b=TdB5zHT3iszh8Aq5k1JA0AcXqHnitXQQIHPbQjubTx95uoRFY/0d3so12hd6dCOgf5
         OZAtSsseYoks6uV/Cp/wl0VYrTvzoe7DEIZunsCEmni4RteRZQuLozcuPZL1drALEAGh
         WaPdRpJA0gYgsHwQI9ZWVX6VeWC3JdodZ+gmq14yxTHbKCr7YOE3RfJgK00Zj7Xh6RLG
         0Fh/qVfwDIZ1+bMyMN/eu3Q7eHFQHq3hxE/uftCAxi8LD4UeW4tgkkjW/1HVZiMr1PGg
         +MbCjN+HziWzWrf07uDIedZOTxPozdKWyPBdqF3tNnFyWPVCr0/hiymSwm6T1/kba3zH
         O+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715907282; x=1716512082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSqMKNX5OHYStDn4wL1WzMGVJvFLse/6VPSdUAmxlTk=;
        b=RbF86kUnmQnSBk+blpQbqS6pyVPEjryr4lx2eY54OZudUK+8fZlCmsWoSiG0bMJZtg
         VeqHu5EjjSJx/QHLpfHn/nYCRfBGoOlWB93FJmol+ogjFoPLggR6DmXx77Biwkt/Mn17
         IrYfewxR7Or7UL3zOTHffJsCKCHFUjIr9eMw7A26TK0carmMeRGaG1PuJL7gyE5tNuug
         Y1XJIGkn8njTzsRB9D+G+y7F5MLCVZs1crMbJhPjuYSbomtdoskNKULYT5MWc7tJjTIN
         +sVqbmAQ9mY8dFgDRNtqDR/XoRQuKj5TLAg69RlgECK8n9nFJuj1mPcVzTK+qynIgxVh
         RzZw==
X-Gm-Message-State: AOJu0YzSLCPfoBvS3+p0Oars+lNeZT47paJ3PvBpw64uEHKzlz5hh/ap
	CC053TBaZPaFtiuMBjsKfviCE6H7inaCuE2lIZgZ1WYsWXOrk3NaGkfeBzPse++niQ==
X-Google-Smtp-Source: AGHT+IHLGSJnmZQP9MOY0ONyr/wClYuON8e7/zwbTBuJ7JB4Qr69GGzKDynxCsoZA1O3bu6sVu97wQ==
X-Received: by 2002:a17:903:2444:b0:1e4:55d8:dfae with SMTP id d9443c01a7336-1ef43c0cec0mr252498505ad.4.1715907282327;
        Thu, 16 May 2024 17:54:42 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134ce8sm145528245ad.243.2024.05.16.17.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 17:54:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net] ipv6: sr: fix memleak in seg6_hmac_init_algo
Date: Fri, 17 May 2024 08:54:35 +0800
Message-ID: <20240517005435.2600277-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

seg6_hmac_init_algo returns without cleaning up the previous allocations
if one fails, so it's going to leak all that memory and the crypto tfms.

Update seg6_hmac_exit to only free the memory when allocated, so we can
reuse the code directly.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Closes: https://lore.kernel.org/netdev/Zj3bh-gE7eT6V6aH@hog/
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/seg6_hmac.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 861e0366f549..bbf5b84a70fc 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -356,6 +356,7 @@ static int seg6_hmac_init_algo(void)
 	struct crypto_shash *tfm;
 	struct shash_desc *shash;
 	int i, alg_count, cpu;
+	int ret = -ENOMEM;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 
@@ -366,12 +367,14 @@ static int seg6_hmac_init_algo(void)
 		algo = &hmac_algos[i];
 		algo->tfms = alloc_percpu(struct crypto_shash *);
 		if (!algo->tfms)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			tfm = crypto_alloc_shash(algo->name, 0, 0);
-			if (IS_ERR(tfm))
-				return PTR_ERR(tfm);
+			if (IS_ERR(tfm)) {
+				ret = PTR_ERR(tfm);
+				goto error_out;
+			}
 			p_tfm = per_cpu_ptr(algo->tfms, cpu);
 			*p_tfm = tfm;
 		}
@@ -383,18 +386,22 @@ static int seg6_hmac_init_algo(void)
 
 		algo->shashs = alloc_percpu(struct shash_desc *);
 		if (!algo->shashs)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			shash = kzalloc_node(shsize, GFP_KERNEL,
 					     cpu_to_node(cpu));
 			if (!shash)
-				return -ENOMEM;
+				goto error_out;
 			*per_cpu_ptr(algo->shashs, cpu) = shash;
 		}
 	}
 
 	return 0;
+
+error_out:
+	seg6_hmac_exit();
+	return ret;
 }
 
 int __init seg6_hmac_init(void)
@@ -412,22 +419,29 @@ int __net_init seg6_hmac_net_init(struct net *net)
 void seg6_hmac_exit(void)
 {
 	struct seg6_hmac_algo *algo = NULL;
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
 	int i, alg_count, cpu;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
 		algo = &hmac_algos[i];
-		for_each_possible_cpu(cpu) {
-			struct crypto_shash *tfm;
-			struct shash_desc *shash;
 
-			shash = *per_cpu_ptr(algo->shashs, cpu);
-			kfree(shash);
-			tfm = *per_cpu_ptr(algo->tfms, cpu);
-			crypto_free_shash(tfm);
+		if (algo->shashs) {
+			for_each_possible_cpu(cpu) {
+				shash = *per_cpu_ptr(algo->shashs, cpu);
+				kfree(shash);
+			}
+			free_percpu(algo->shashs);
+		}
+
+		if (algo->tfms) {
+			for_each_possible_cpu(cpu) {
+				tfm = *per_cpu_ptr(algo->tfms, cpu);
+				crypto_free_shash(tfm);
+			}
+			free_percpu(algo->tfms);
 		}
-		free_percpu(algo->tfms);
-		free_percpu(algo->shashs);
 	}
 }
 EXPORT_SYMBOL(seg6_hmac_exit);
-- 
2.43.0


