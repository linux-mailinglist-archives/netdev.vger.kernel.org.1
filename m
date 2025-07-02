Return-Path: <netdev+bounces-203207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB24AF0BEF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684FB1C03B98
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD1221F37;
	Wed,  2 Jul 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6IbgQEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7922172D
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438911; cv=none; b=Nm27G6DyTgHIqoLkq+KqLT6gWSOv0dNZPvlgrNUzXreGzN5Wefg6UU0mxMJun2SvgnlHTHxYuAXqCcK4sQdZc+AVBW3fZJvO4T1KcpCQX/wWHc/Qmvkgqf23ju617KlFylG/I9r1+lyhTd0XoJ+POOZmPPRFmJc/cXAa5SiTrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438911; c=relaxed/simple;
	bh=xAUCB03d9oKH9opcJKmzkxdRySK+hS4GEeC+vscbQfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fa446WDltUB7voOaCyjJ48f2vt6wFc53VQzXHMf9KThUwkv5mK+m1OYS+y4TzdZb6nWKuzK8htbdheg+zgiIVpVX4D8gUM9X+KDsWuXm9uBbgLLRe8ngM+eQb2XRFiAzTYyCz+TfJMpziWBxG+m20OTsLuVC2E2MzBurRV1VeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6IbgQEF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237311f5a54so36982065ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751438909; x=1752043709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIvH/oKJIX1wzN5a5NFzqMamTbkCQ9jn/ggyU9tvalQ=;
        b=G6IbgQEFJtMYf9W55fZbDwY5lcIbXoINy/QshSbJQIvZV+BTCnI+2vkQ+TqqAJ755H
         qkbCt2swDxNfqZqYnTGnwbfO2Uv1G4itFbs3+qv9i5thjVmXHBKNW/10HvSk1N7lbHMY
         dbB9VNe1TDWo97xpUHNKzVIDlpZo7VlwXJBaMGGSqyNYqzJG0edVFmKIKRftDJHTrAaD
         +/1xM0CmSiGBWxF1WlgO4+e/GilHS+l7uhZWCNs3CoLqtgHh+d4fFxKF1511i1Qgh9If
         T7v6HbB3u/fcLb5xqG5JfJ3jflz4K0ipLd1tRLGqKzvUA79/emFbMUoXnRyjXe9xFwDq
         URcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751438909; x=1752043709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIvH/oKJIX1wzN5a5NFzqMamTbkCQ9jn/ggyU9tvalQ=;
        b=CTcYK+YdJyQ7HqGF10Xyfxj+YxmSHEeAgC68yM1Zp0dbxONVxiVwozQzc1XKgirJsB
         STafIP/IeC5cX7kjc8eRAFF4qMS5eIz0e/fcfHXFcJaDDcaEbN7srgelCXoHhmWQJ2uI
         qJRK8i1WrL+yfNfV36zpeyurStHKeDiT3eM1VN+loPzH3FKBD7ZZZgLKgV1wsxoEXIp/
         a4ktWpWFfXBhFFMCJQ0AEqr2oK33MTdsPuDh5TavcnJEIrUB1plPcQXT86fWRgYoKfWz
         +yYcoH9dGMeI8NwWhLoTGtgfqlw9nWK3N/uxjSWU3TmkvknAsNeot8Ox1e/QrfcMelvk
         NhOA==
X-Gm-Message-State: AOJu0Yyzz5wpgY89irdrIM4873phmuLVwDZsUqe+faHLh+HMdXMGYBle
	2/0asteR1gF+APrS6uRtp9JpdDHsXT2Jj8ZiLKLS0AnTP0rPCHrLXoAq
X-Gm-Gg: ASbGncsxGo9rz9va9aAHCtD6NcoMtXIeRdbO20uwbtKY5jyeOJAjOOLFoFDyikBcEj4
	iwa3lHWmtw9m/x+L/0SQoJsO3jydL90AkmcXPXI2xnV/DNxfD1amU6ckvAKAeK6MG7vrE1km8s6
	9fqvtH2A/g0XsPYYmiOv9Vv5fYD8tpcz+EbcPO+IbyjIf7mzRX7Hol2S/3NeAbCXBGKQRAHr0+N
	UAFTmhSXzqJwep2SV3JqZgj6iSaE80seHaVixbGfx78At6yPpk6bjMkkPK8XC3kIQ7ICK0/CnVz
	RGoiLqxSl59Djun/gQohITrfwLQGOJiXN4bA0CZbbCM8ejVmFPpwGdeVee4Qoww1oHwrDRKq0ZG
	WD2iF67HvQv0MlFq33gSnPcDexEcj2IopAQ==
X-Google-Smtp-Source: AGHT+IHJqBq27SzMpKb3aGQ9/TB+HExKjy4dx3meaYUmgJF4yJMLp77OydxuHVnOzAPtbogerDcCJA==
X-Received: by 2002:a17:902:e5ce:b0:234:c86d:4572 with SMTP id d9443c01a7336-23c6e58ad1dmr24547935ad.30.1751438909099;
        Tue, 01 Jul 2025 23:48:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f4c0sm120416205ad.103.2025.07.01.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:48:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] bnxt_en: eliminate the compile warning in bnxt_request_irq due to CONFIG_RFS_ACCEL
Date: Wed,  2 Jul 2025 14:48:22 +0800
Message-Id: <20250702064822.3443-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

I received a kernel-test-bot report[1] that shows the
[-Wunused-but-set-variable] warning. Since the previous commit I made, as
the 'Fixes' tag shows, gives users an option to turn on and off the
CONFIG_RFS_ACCEL, the issue then can be discovered and reproduced with
GCC specifically.

Like Simon and Jakub suggested, use fewer #ifdefs which leads to fewer
bugs.

[1]
All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_request_irq':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10703:9: warning: variable 'j' set but not used [-Wunused-but-set-variable]
   10703 |  int i, j, rc = 0;
         |         ^

Fixes: 9b6a30febddf ("net: allow rps/rfs related configs to be switched")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506282102.x1tXt0qz-lkp@intel.com/
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20250629003616.23688-1-kerneljasonxing@gmail.com/
1. use a better approach with fewer #ifdefs (Simon, Jakub)
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..f1ff87c18b71 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11538,11 +11538,9 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
+	struct cpu_rmap *rmap = NULL;
 	int i, j, rc = 0;
 	unsigned long flags = 0;
-#ifdef CONFIG_RFS_ACCEL
-	struct cpu_rmap *rmap;
-#endif
 
 	rc = bnxt_setup_int_mode(bp);
 	if (rc) {
@@ -11563,15 +11561,15 @@ static int bnxt_request_irq(struct bnxt *bp)
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-#ifdef CONFIG_RFS_ACCEL
-		if (rmap && bp->bnapi[i]->rx_ring) {
+		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+		    rmap && bp->bnapi[i]->rx_ring) {
 			rc = irq_cpu_rmap_add(rmap, irq->vector);
 			if (rc)
 				netdev_warn(bp->dev, "failed adding irq rmap for ring %d\n",
 					    j);
 			j++;
 		}
-#endif
+
 		rc = request_irq(irq->vector, irq->handler, flags, irq->name,
 				 bp->bnapi[i]);
 		if (rc)
-- 
2.41.3


