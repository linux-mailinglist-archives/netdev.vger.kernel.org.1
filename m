Return-Path: <netdev+bounces-124704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18C96A7AB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239331F25297
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9841D58AF;
	Tue,  3 Sep 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSUprc+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B31D5880;
	Tue,  3 Sep 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392606; cv=none; b=mac9V8AV5QuzRBupR3JtaYGPRhH+hfWq8kamHG7qShBgF+met4dUp3MTQmFaXoMqoMHsSMV4IccUbrneeed18zAG2IV3exLgJ/MSUkTMmTjiXu3/k3KFTN/oKE8Ac2YAnN8CDwKTPvR/85Em79AIXG08bwGOjcfwtjLlegssrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392606; c=relaxed/simple;
	bh=Vqa1JcGHbelpuSMZGTBLTJROHgdmvgVL9Omtrlf1C+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvTzk09zjexBnc1GoaKZa8L8fAUoguDwsxLgtCuie9i3WpY8enmxH9lCxP/toHP4/h4niM+7hRjI5F1Oxyq5MJjbwOqSN+h3v/lEt7CaEhNHXIJ31pI39OA+GXWn+GPMhiw7dwTjRvJS5p2feH5E7ZtlsMpXrWxvV5SXYNwaSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSUprc+2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201d5af11a4so50055155ad.3;
        Tue, 03 Sep 2024 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392604; x=1725997404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYleQ4wVeI+UIqewsN+uSfMEW3OIt7z6W9ffXRdutuU=;
        b=SSUprc+2eqC+UQVX1nH9WZQU51Ia1y/fhtx9cObiFLNbHRBWQRID6UOSNr9JZFuh2c
         Qpsl7/Jafd645e27ZBs0C/HS5D/+1+X4VUMkB+q8ZEMMHCoKU5Nb3q9PRxxHIg2HP4Qm
         G8PLlv6BCJGg6Pr62VMip1ru0RQJ4A+/MwZ1+eFedvRC4th/zCTsuhCat7aPsVU9+9KC
         iEbgu7RU0K8sT5Ghqzd4xFZQHwbMhEM+71jqI07n33hBFho1jQSkv7kVPWR7a6b41mTe
         eJ83b8wi96YLIRj4coM9J/i5lgpAJeYOh5W8bgLE24Q5szF2DSSKJZQFOX4pnvMemZYR
         30jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392604; x=1725997404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYleQ4wVeI+UIqewsN+uSfMEW3OIt7z6W9ffXRdutuU=;
        b=MQESOM/MXlwUjFX+gwNNJ79o+SYy9QiViHkr9V1Dg1H64abmq9mhLmY61DvHHhKGLx
         G/aEWq2IBqMQmwVHvaKJnWCvLMeVR/Slw8eGGcnsvVqIgTDbeBl3anwBxGyfJdfeUC+H
         f8tKgD1UtilK9CegkngA6j48bUwJKWQcwOCy7ful5eLlBzXod3oWMQ4Gkr6iZC5fYa7F
         x/GHozxzGR7VKRx/UhRm5vJ80HylpMajqo6BdExYJmgRhvE12btCDSD0m3uJD8CL5WOV
         t/y7UAMcFL8HnO7+l5f996D8bfjIUswFexWZG0hQFw+0RP6QCxdq4hubhk6Q1oHDjnwR
         Ub+w==
X-Forwarded-Encrypted: i=1; AJvYcCXduUcIpWT7LbSGNUL6CQhU9zXdZM2+xGQgT6uGqKnlA/Kba8mIrWSVwIkUmda2t1a80XHAY6TmTzNL83Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaF54+tstdlwINYHXM9nkHRy4CWCEEdCHobyPa6UlMKorAIthJ
	tRRDgylhkhrMwmrOcwbeOapb02HfltEhj9gWtAjA93CQjF1io7eXdTJ4oXgY
X-Google-Smtp-Source: AGHT+IH+W0wOtdVGBMNlUR3NzzhtwJUzozrCwqT9ynym+LQcxWrCbyQHclCypj1i9QH6KAiVFknEEg==
X-Received: by 2002:a17:903:32cb:b0:205:88ca:9e24 with SMTP id d9443c01a7336-20588caa05cmr86225555ad.19.1725392604206;
        Tue, 03 Sep 2024 12:43:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 7/8] net: ibm: emac: replace of_get_property
Date: Tue,  3 Sep 2024 12:42:43 -0700
Message-ID: <20240903194312.12718-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32 can be used.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 121db9611cd9..6db76eeb4d9b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2444,15 +2444,14 @@ static int emac_wait_deps(struct emac_instance *dev)
 static int emac_read_uint_prop(struct device_node *np, const char *name,
 			       u32 *val, int fatal)
 {
-	int len;
-	const u32 *prop = of_get_property(np, name, &len);
-	if (prop == NULL || len < sizeof(u32)) {
+	int err;
+
+	err = of_property_read_u32(np, name, val);
+	if (err) {
 		if (fatal)
-			printk(KERN_ERR "%pOF: missing %s property\n",
-			       np, name);
-		return -ENODEV;
+			pr_err("%pOF: missing %s property", np, name);
+		return err;
 	}
-	*val = *prop;
 	return 0;
 }
 
@@ -3298,16 +3297,15 @@ static void __init emac_make_bootlist(void)
 
 	/* Collect EMACs */
 	while((np = of_find_all_nodes(np)) != NULL) {
-		const u32 *idx;
+		u32 idx;
 
 		if (of_match_node(emac_match, np) == NULL)
 			continue;
 		if (of_property_read_bool(np, "unused"))
 			continue;
-		idx = of_get_property(np, "cell-index", NULL);
-		if (idx == NULL)
+		if (of_property_read_u32(np, "cell-index", &idx))
 			continue;
-		cell_indices[i] = *idx;
+		cell_indices[i] = idx;
 		emac_boot_list[i++] = of_node_get(np);
 		if (i >= EMAC_BOOT_LIST_SIZE) {
 			of_node_put(np);
-- 
2.46.0


