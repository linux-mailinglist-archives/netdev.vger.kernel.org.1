Return-Path: <netdev+bounces-125685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061896E3D4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D01C1C22CAE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EC1B3F33;
	Thu,  5 Sep 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9HCYa2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB41B151B;
	Thu,  5 Sep 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567321; cv=none; b=gosGJ9utdDCzKV4R866soMGXy9t1DFEdL14CAvKTWYO4z0PeAwnoU6FNnhfb3X4N+2ivLCYkIKa8QOAFhwhPu5+8XJ2srC1WyHM1Ne2s80yUj5wel0BGsbyVLFZSzRNF621OfNlqgv4crSjl3EG4h+PvCMX1wPxDMh7h7LhpoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567321; c=relaxed/simple;
	bh=Xr08sTFDdEUhabLb2fj+916WPoFxDcgNBGRB6aLUYPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao9bJykdxWjk+mdSrJpANH4D7HilrvhwX3A9STalNzyAHqfljCEAwFR4DuEIMKfnj3RUmx1mRATbwZhkAFCyiLB49td8YQ5C5i8YgTly8TF60Ue1BdmMI6H2LbFM9L+Ij+hpShTLSY5DeCmix8SZc1S7sXhwtwLK7sETHxteEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9HCYa2w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2057835395aso12190625ad.3;
        Thu, 05 Sep 2024 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567319; x=1726172119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zerd9BuAuSDmlw4ZkhgvIif9TmKF6cW7mi84Axie7a8=;
        b=l9HCYa2wG5w2if+jIuWzarPrEmk2ta5PWEyUVU/7Azg9IXWuF1oQQNwUB2vi6vocVV
         ZIKLhFrWuOs7xlE3HyhQZXDrM5RVJPFZY8qbuTbTCM4fBl4HxJ5i56Arg5UUxqzNo+zL
         sVPYhwRgAQQcJSziRPcJZ1kASkYSdWnJgygZZPE88GCU5MfvzzAe5746wMomL8W3mTJ2
         sV5oIFscp9q8NtiwUhjuz2zFU/DnccMQMZtvv9DdioLaPm5hcvNGbihv4stnSAttquFJ
         imExnEmbQgVnUJ1+zqU2citZyPW3l3Btm3J+SyfkmtCwi+4sl668uaiyOFBGvhhrZdWK
         u6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567319; x=1726172119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zerd9BuAuSDmlw4ZkhgvIif9TmKF6cW7mi84Axie7a8=;
        b=bB/PbBVWxTz5UCz/F6eJHbdzkBoe89I+wRVuxAhsZ8K9EqCxiJw6zLvGYF9rARpJVT
         eVHaXDnZqYnxO/RLCnIPBsJ6pdHxot9Z7DO+4nmrgwr23ninOYYEjVxyQFXphzPWSR3O
         y5/5eCccRLVsx11VjPaw+mlhhslvWn/zdT7FPc3IPQO1Uv3wDggAKW3QvTJYvJNNPPC1
         amNnSLdrhvcJuR8ni5ZhT3DvpSmdfNxFc79wbiW1nogvoPqok8IzSg04hBWWcNd2inUg
         FkmzlzmnK0JbBSNTviebYnoCTz+Ed723mow/eoDS37mUT/kxOsfi94c+CdincLmp3DXn
         bEtg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xbT09YIoT2rxOB3oSoiIYgoiwIOuZuoKsf4dnPokLEi29MYV8SB6WyQgiTNKklL0fC7TT+r1lbAkzrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05Aiyd8mIgTjXZgKJ780UByPNliDmOHn9k8/OVFRVgVEfBxwT
	imyTAi1CYLgCeYVeYqwA9d3yv3aaA3PayMCbMjlarTDyUZ0dDGcocLruv3cJ
X-Google-Smtp-Source: AGHT+IGz8a98+V4EvjpFibZaIbmyUzCSwDIt+5aHKEvOtCNhqx0yfKZIODYHUPEbh9nWC/mwWUYXAw==
X-Received: by 2002:a17:902:f544:b0:206:b399:2f21 with SMTP id d9443c01a7336-206b3995a0amr72839655ad.43.1725567319603;
        Thu, 05 Sep 2024 13:15:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:19 -0700 (PDT)
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
Subject: [PATCHv3 net-next 7/9] net: ibm: emac: replace of_get_property
Date: Thu,  5 Sep 2024 13:15:04 -0700
Message-ID: <20240905201506.12679-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
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
index cda368701ae4..f4126a1f1fff 100644
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


