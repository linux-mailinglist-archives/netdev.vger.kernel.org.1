Return-Path: <netdev+bounces-236677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6577C3EE2A
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0AE3B1137
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C4310768;
	Fri,  7 Nov 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvAUggh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28003101A2
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502887; cv=none; b=pKJS8Fb8zw/bcZJbE3y0mhUGpS9gG+QqdnH9e+LvaNeLo22GC2xx4w7npVIHxQL/dtsJzNY5/XAlZER5eh7x0jvOessNADa4BFi9sqRJYroi4BpH3eeWhr3JXj3yXAzcFtvOVUGTTwMLyMvK4YIsVn0IdJYbSiLZrBlTYBRBEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502887; c=relaxed/simple;
	bh=T+fv7B4EGOErJ4vvULFWmw8UusTVspY0S65zOSRYCp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoRMo60UNdeV9XyOdUIwwQE+7v+4YkDePzPkniGBPXkYNzyQVcm/fp534gB2C3m9p7//DRPQXVGECfGHIZJGvSXWajeqHVoWhZCFErch4by8nnEdQph432QVUSX5IqpVdq5xCH7rIT8TBwDAnt5ALBlCfB77i/v08w/o+BpEs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvAUggh/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso182236a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502884; x=1763107684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xZ5yli4HyPeAHciL3B8npkM3Dz4xiXZ5nUJPMyAy7w=;
        b=MvAUggh/j9KbagwjBgk/EWhlAc9pkXVQolxRfhDIb4KSplp2OHsbD8sJwBLi7AfyzX
         D6N1Dl9AG9Y/wHQiJCbO9khKXe6X9cTGDC9UmCDtCxclGCQkdYekgKZGhbFgJbHY8fVw
         85IW4mhTm3kDJVN2AoiALH6BIUm0Ma7Q09IMG/gMJ0xBQXY5yAVGBfUaAYXrpglcR81N
         M5fEKOkGCCIqv2YVSdivla4EOoL3nduNJkvGqP8zbXJ8NUU/z/9JSYdb8lhQXShI24jA
         cyaZrAaUsxK4XbLDWUEbtNB4K14LU2eOa1/9XfSfXEYQML5bodKI8As0otegYcpub80U
         Rg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502884; x=1763107684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xZ5yli4HyPeAHciL3B8npkM3Dz4xiXZ5nUJPMyAy7w=;
        b=A5iALM8bBoe47lbxyu8I7ha9P3EOf1Lr/6WLcKrTx0zBZKmsrLih5nQwYzjZ+ykF0L
         y4Wbhv+3h3Q+FJ0x3DO5qej62oL8/v+ZzR2krFG21/vch99MDGGhnfJkqf5O1oCMZz3C
         hkPlcqhAiu9oq4AtrXNqjeK9QINKaZaYR6JrezTtG6UifrEvu4PGq1SlxADDLu2UMbwp
         6yt97tLWRmVQb+kqYLtu/ZLTgY8UsdPUYP86T44yhljk+pEh3daT3rkI+rHT/FlbiH4a
         5Z7NqjmGbfd/QpES+ifmK2FW6HfbaMFMB3fYxCzgCxjVPO2ZO5qnuxf5+Eh8GGNZ9Aar
         E2Ww==
X-Gm-Message-State: AOJu0YyDPtoSiBl/1D+wi08y9IQpG+eBcu0QThujbjqyJuf9RZyEW4KG
	AQbIc5TIjQZe81NdICJu8fiQwNWI7CbNqHzdVBBWobnUZcKDisJ7/I14
X-Gm-Gg: ASbGncvgXc2G7nGl4Ic92t/LVm8ILmnnvryMq/27qCsffN4KJkAaMjBKsXbIC0Bx6LP
	rLmSDZr2wGdsZSXqMMDhbfsZOdnI1DVXRIYxOzsy98Yz+CVpimfpShK7yxipOL7qxXOAAZtKtqW
	qKQZQYmYoIWS48ReGzGCd+db9H+O3bMFt3m0hr9mkWNOY8fmC9qpiq9Gj7q468MW2IhX7ibzAp/
	tm0RktmfLX/YOiao5a+vFaCtyZc91HtZSx+C4nY4mwQ6znkybHDCa6jmG6Ppgk5kq6SfksH3y/i
	XOoAqbl05EN9ApuBA5tmqVwsekroKLH9EukzYbkC47VzM4h6f+Zy6X+UBu4KWfLYTVCEQ0mv0xW
	rCFrsqOr17MyCkDqFUgicctS3WDfeN6QAIJWJHW6XkpVD/g7dyDTv71TJRap7ENYOFtqMAvISH/
	Ub5OwW0Y/JQGWteK50Os6l8o8d9OYBFc0wN84ct8ADSl0GFBSbRYYa3Jlk
X-Google-Smtp-Source: AGHT+IH9b/MYYIuDyWdT7ZTBQkoaDfwy59F6a7uHK4JT6ZExE1cuece4EF876eM8gMqHiUFkgjKe3Q==
X-Received: by 2002:a17:907:9608:b0:b6d:5718:d43f with SMTP id a640c23a62f3a-b72c0abc187mr227415266b.39.1762502884014;
        Fri, 07 Nov 2025 00:08:04 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf60ef8asm173812266b.30.2025.11.07.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:03 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
Date: Fri,  7 Nov 2025 09:07:45 +0100
Message-ID: <20251107080749.26936-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to more easily support more formats, move accessing
ARL_SRCH_CTL into helper functions to contain the differences.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9eb7ca878e30..b13437ea21a0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2033,18 +2033,37 @@ int b53_fdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_fdb_del);
 
-static int b53_arl_search_wait(struct b53_device *dev)
+static void b53_read_arl_srch_ctl(struct b53_device *dev, u8 *val)
 {
-	unsigned int timeout = 1000;
-	u8 reg, offset;
+	u8 offset;
+
+	if (is5325(dev) || is5365(dev))
+		offset = B53_ARL_SRCH_CTL_25;
+	else
+		offset = B53_ARL_SRCH_CTL;
+
+	b53_read8(dev, B53_ARLIO_PAGE, offset, val);
+}
+
+static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
+{
+	u8 offset;
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
+	b53_write8(dev, B53_ARLIO_PAGE, offset, val);
+}
+
+static int b53_arl_search_wait(struct b53_device *dev)
+{
+	unsigned int timeout = 1000;
+	u8 reg;
+
 	do {
-		b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
+		b53_read_arl_srch_ctl(dev, &reg);
 		if (!(reg & ARL_SRCH_STDN))
 			return -ENOENT;
 
@@ -2099,23 +2118,15 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 	unsigned int count = 0, results_per_hit = 1;
 	struct b53_device *priv = ds->priv;
 	struct b53_arl_entry results[2];
-	u8 offset;
 	int ret;
-	u8 reg;
 
 	if (priv->num_arl_bins > 2)
 		results_per_hit = 2;
 
 	mutex_lock(&priv->arl_mutex);
 
-	if (is5325(priv) || is5365(priv))
-		offset = B53_ARL_SRCH_CTL_25;
-	else
-		offset = B53_ARL_SRCH_CTL;
-
 	/* Start search operation */
-	reg = ARL_SRCH_STDN;
-	b53_write8(priv, B53_ARLIO_PAGE, offset, reg);
+	b53_write_arl_srch_ctl(priv, ARL_SRCH_STDN);
 
 	do {
 		ret = b53_arl_search_wait(priv);
-- 
2.43.0


