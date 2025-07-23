Return-Path: <netdev+bounces-209213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DEB0EA77
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E777580244
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2C26B770;
	Wed, 23 Jul 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAMJ6xjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DD25CC63
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251387; cv=none; b=FHcARfZte+RaKwzxoHStemQDhYjXmL8ToQmU2qOIc0YWmoPVgPGrT0eAq1Ft1FUGsKEuRro61qvLeIH03lNRDKY6YIGB2yD87VIJRhDabCyed18Xyez7+Wq6wX5jVEa5/Ds1EsSHH79I0kfki29j04ZpLViaw2f19T3IBrW4zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251387; c=relaxed/simple;
	bh=ys8iFXHoSHoZPYsluj1o28+fqMoRyPka+IIKeiWibTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSL+FOXlCLbpYIyrkQyQedy3XiH1ymxecStdYEH01z1N5v3IFX0p5AAOBo9XSXUgKCqRJBLiSE9tAN9BiWRtoLeF7d/uVy5M2CkC69azVk0RLe/v7hFIxddaIS6mNTEjiwNXQSbNSaMFInnobU1RKoCRxbFeLFx56Uobvska+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAMJ6xjE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ea292956so57833695ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753251385; x=1753856185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6IxTA6cX8YawblCwfHsELttSamLmiOM++958DmIdP8=;
        b=EAMJ6xjEvPCJQfGI0HECKgimljbdN7ioVDUvOU9QkAQdzJCNf6cyNzWjtyIPgjFcMX
         VVWHY7pNySsLkH49TYwLxgfOJvG1s8skFYKS8Pu3DDcxtG/fvyqrZ8kPU1t+Lb9vuyix
         5XE1Ttsu3Suhe48OIskwWkFmKuq5Qw9WUaHZyfyEgGBLmWTsHWhOOvqCShN38GiSfU8o
         QX17bjeOoXwF9BtIkydtL2OdePi4MXYEnItd213q6LvmQHNGYLXXB3oCa7BF80iTWldd
         HZ4XhcppqQm1mrjNboxSnUgJavepnt3zurvq8EamedJ+3lIqgZz54LFpy4vCHdNztvEP
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753251385; x=1753856185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6IxTA6cX8YawblCwfHsELttSamLmiOM++958DmIdP8=;
        b=pKJSeYp4t8rnKDzwU89ZKUM4AxnI9l8FKv0KNDhy4sOBlOiDoi/V7vkRoLLNzcuQiX
         rgelTHAPLvXRoApbzaf2D/emqdor+j96iTn0rPiBeAK2v6EuWycC4Q2QUrILPJf8fFJ3
         B9dorUvFlLsCTkoVXfNiaaBVlhBbSN/NnITghSibIZjwll8XftC/C01D9wXWSyzD5y33
         3c891+GHe4kZhyWVQw91C6+73JF2IGHM/9wqwKJNWYY6hDHE9Mep3TA+2LkR3w1B+tUi
         LCBiaCaDGE2PuoLbCNOIQR6ysnvX3aiDF+xTp4gQNsYIjon05NQNRNYMVmFFbDx6X23Z
         p32A==
X-Gm-Message-State: AOJu0YySH5IfmOqF1aLownKRam0667ft3ik8QwMysLr26JywKuJRNHcm
	8HyLbDfsRvrycYCrfy0zs3QDn+JQ8tAqjJ/jgTEurU3PW8X5JuZg1aIl98PLfL+u
X-Gm-Gg: ASbGncu3tSOcH5NGtnS/0K1dUpOiA1OuRpL8AWFPIOQPdWX1BK46cxC5wR7CZeKPx5l
	+X8Y9AxUs5NI/d1qeyu3T2g0euFYfy3OEdDH/nIXXhjGCyhSGL1Cktxr21MVKXHgpgNSn8zhs3l
	pBxvTyjw2H4wLl9PiwWnj18uBerwnlknSchc+3tZiKzFWO9g9IEHFsYIpFeBRfC9w/JfuoVtUyR
	agf71NKlkzV9WarayBoHQzghRaXTed7s/iy7JzETFf8HZ2F7JqQBR5lL+tjQ5YPiInsd0p7aYvN
	wu+KLOY9sSs79arc/2Ontk1UB4MHzmoDtcKTyIKLFZz6yGvre4N+hpLnIBoylQ+OTYlZbjJev2m
	URY7ME8Ca2UyZ790hq1DyyXmZeNnKCXYXc18=
X-Google-Smtp-Source: AGHT+IGMMhKJZCPdOBCnqwesLICSOBoryRlpsWZ3qL8HGJDKNjhBQgvvF283IwX3BzxL4cq50dZrNw==
X-Received: by 2002:a17:903:178b:b0:23e:317a:abc6 with SMTP id d9443c01a7336-23f981e5a3fmr26093985ad.47.1753251384729;
        Tue, 22 Jul 2025 23:16:24 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.252.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51b9329csm798044a91.32.2025.07.22.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:16:24 -0700 (PDT)
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
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v6 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Wed, 23 Jul 2025 11:46:04 +0530
Message-ID: <20250723061604.526972-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723061604.526972-1-krikku@gmail.com>
References: <20250723061604.526972-1-krikku@gmail.com>
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
index 979dcdfdee1f..2c3981b823c7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4861,7 +4861,8 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
+	    u32 flow_id)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -4872,8 +4873,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
-		u32 flow_id;
-		u32 hash;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4889,9 +4888,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
-		hash = skb_get_hash(skb);
-		flow_id = rfs_slot(hash, flow_table);
-
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -4965,6 +4961,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
+	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -5011,7 +5008,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, flow_table);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5030,7 +5028,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
+					    flow_id);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.39.5


