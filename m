Return-Path: <netdev+bounces-208084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCFB09ACB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 06:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083197B81FC
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F671DE4FF;
	Fri, 18 Jul 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKzfAYEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD51DE4E1
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814700; cv=none; b=SbR5Gt03CZLXu6u8bySlwLjjUxHuNaqO+y448YXiOHsNBaNlRMHHlfNc68H+NnbgXAMlmywdFGhaiACscQv2JNb2MtMmPJQSJqaMHtL4qU+Vew8+DCcdaBy26xH2e2up+O/pc8q3Ssqz3yrOiYnMCul1txCSOhLVJNRV8Kui+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814700; c=relaxed/simple;
	bh=csMfbmkWdSgZGntau+Xy48RzW6LewRdKgVAxCWpIwos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBWn0z+AWEArzGSOFVJyAfXoi4a6ir6jY8gFudspTlzVGcX0FMQpAinH7xtcpDL3eyOAdUaBksdBChG7rpV4qEArNTlHIXby1UulQXylI932ku0H05F9LRtOcO3YUDaBb8A/wYNmkEXNFxnR75y0gitOLNH9glUhTrz7X3geqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKzfAYEy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso894090a12.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814698; x=1753419498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iktgh8dc5R2LW6sIGVH6+fpCg9JRn1K/JgrvyYeS/QM=;
        b=RKzfAYEyMcjWju3m2QfxaOiY5KXC1kZ16GnuOc/vIzlZ7rrRURn9BVF29nYCKiTXi4
         oNjUiFLZud5JS8lgmb/qC/qE2Q2ljOevzJs/ZbiktkU+7J/21T7T7P0fWDblMJbX2fat
         JLESunIht+KGEelRoOlRN3YyUb2S/PZtimMI+/mOstQxuACem1cdGqDKS095XhM69dPN
         y0FnLiYVUHwysP7kmOKrXL2RRBHo+Ut2qdxstILQFfGPZef6E8au3/XShtu2Btc9qYjn
         0ShAal7X8PmCSLb3E3JcpHK2+K77J8WgP/JCQGzdy0f/XEcRESHFZHR8A4hfLmq/eLR9
         4TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814698; x=1753419498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iktgh8dc5R2LW6sIGVH6+fpCg9JRn1K/JgrvyYeS/QM=;
        b=DIaNOIDJp9e7Tp5yo6Vv1f9kVo3JCxUD9O9je9lkTqI5lInV4oLu3GWJX3OWYS1ccY
         sUzc4lOcb2bIXeXY/lxVg9u0rGW3OflFtAUs9V3v9rHqoVmRb6Jbwi3HW5LA2RZOGmLI
         6VHzcj0/c3mfoCQ2yAhVZVLfVTJiCRusqoV1BSUCcAZJ+C1prhrZgTImrmN2qF2ILvBe
         Ckfylt5PbbigyvzNUA00Jdb0vfv21dDn54oK3TFaO0nuk8gRMiUhO9QyCfCKUV8jCCYw
         3ZehRVAZRYuq9uA5rLvsekUJSjQhmtm521atmIPOLv+cuGjNh3+opkuRsQpVzKD1Y/5m
         r5+Q==
X-Gm-Message-State: AOJu0YzZB0OGwBOeyHu++VR90htqJnDsrb9QVlqIDAPlHWw4KB1uEfxO
	QFu+8xmmsc3R7BJ0rLrVXnc20O8NofrnSL0QNI2kXSstAkEPs956VVY1sVij68mH
X-Gm-Gg: ASbGncvoei3z7vlaJcyLUfKJgjcecWklFtPc3qSZF6qe5HZrD9JI2d39gAly8VfnaOh
	r6OHf6g2nyOEFSpL+J1JZmCZcmgipbKoQMMncNsI97fC2rJE2GPoCACV9b2WhPxqI5JsVrd+Qg6
	kk4G/h7B6/QKMo2ZjJVt/k6zFlizmiB3rk57vfXL5bWdbAUN4btB5e7gR+f2cBT4yHYuVk3oSew
	dkLaP4ecjruHT6nM16nqvnSA/QSasXXJ5TD1+BJSBmQqtA/dfkUTF+St/eLqdVbbYamanz5NlJf
	FGVBm41N3mrFdrC6ahhFAPt9A2sifJQcbuTwC+6mwnaBZjCBFlh/4w3RyIuT6RJ545KFLhgAykw
	c4jg/WyXZmoD/wMfjpBYL/ftZk55kzIa/k4Y=
X-Google-Smtp-Source: AGHT+IE7ChEMcxNvVyNqUCKOWH3EB3ITNe+neP9dp1eIFalAVdV0GsvXbTpRTuEcz80HxEg/H5TgbQ==
X-Received: by 2002:a05:6300:6d0b:b0:238:cded:d32d with SMTP id adf61e73a8af0-238cdedd407mr8670708637.23.1752814697697;
        Thu, 17 Jul 2025 21:58:17 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff62789sm374991a12.44.2025.07.17.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:58:17 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v4 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Fri, 18 Jul 2025 10:27:58 +0530
Message-ID: <20250718045758.4022899-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718045758.4022899-1-krikku@gmail.com>
References: <20250718045758.4022899-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_rps_cpu() can cache flow_id and hash as both are required by
set_rps_cpu() instead of recalculating them twice.

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 net/core/dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 614fa64de84e..db4b52079392 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4863,7 +4863,8 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
+	    u32 flow_id)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -4874,8 +4875,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
-		u32 flow_id;
-		u32 hash;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4891,9 +4890,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
-		hash = skb_get_hash(skb);
-		flow_id = rfs_slot(hash, flow_table);
-
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -4967,6 +4963,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
+	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -5013,7 +5010,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, flow_table);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5032,7 +5030,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
+					    flow_id);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.43.0


