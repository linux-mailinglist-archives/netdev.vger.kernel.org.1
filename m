Return-Path: <netdev+bounces-207761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C7B08761
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC08A3B5807
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A162266B6F;
	Thu, 17 Jul 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IENvC5ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4F2676D9
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739043; cv=none; b=Jo2G7Wdq0UN9yYJbTLw3KlfcJh/YmIVDA4K6GMwgYLLPxH3EN+ShkJjgOsLAqJRKxxarhioJH2aRkiP/2tSe67MgVpbBTl0kYiEOuZoEsfQFGMlGMPxEKyZyg4PwLuCvBR+iL5bC6xLSpjQVZ2CUZXt9Ev5GyOYEZsZdPrbljzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739043; c=relaxed/simple;
	bh=csMfbmkWdSgZGntau+Xy48RzW6LewRdKgVAxCWpIwos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4MAK2nBAEH5zkswFvgZADOiXpmmEL7l0o3IaWyCj55C61rCgpWyrSh7AKxXyeR0Fz+MNLVp2LKnr1BDF0BJZmqlUEK9QUr/AlQ0pnb7VGmCD3aA0yPnE95d0HDVTyb+tLxCN7C3gfPiMIRdMizZRtniOvo9hwwHZSORCeGdou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IENvC5ci; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so8000845ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739041; x=1753343841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iktgh8dc5R2LW6sIGVH6+fpCg9JRn1K/JgrvyYeS/QM=;
        b=IENvC5ci9fzYNQ+wLgr3lKbF/Sv++y9g3Sz01MP3Tw6uB0rGtaBeydAFSSEXqlPu+H
         OHRhyJc0ex0KnMg/WHbMHUKc6Am/c6SMKVZi6DmwzAZJh575y/yYdkXDjhdjeBNqwtYG
         cq7HBqRfRO8sDIOO27AFQRRnNZUw4vUkD9WzdFe0W2OT7hBeQ4LQj5qVEX2dJf3n1AiT
         mzVQWqSm52Eb6Fnut7LWcn82M/sPSaE4I3WdGad/UnK3bttfO/W2cIjA7autkpxtWc6V
         ZJmizt8SVND1aWxXb+ZCww6rvnf95iZQf/lh4y5UVATWhxHDrM3qG0xS5pPqQfwib4Op
         yYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739041; x=1753343841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iktgh8dc5R2LW6sIGVH6+fpCg9JRn1K/JgrvyYeS/QM=;
        b=JKBlAAf5BaiylaIcZ5sp7cfzIV3AJ1BW45P9xBwQpg+DzLidKARU43eMWm7CkN7lGh
         qc26z+L4Z6glO1CIbDFYv32zl9Dj/bPFntaxcpr14vLsR1EYnQApG3GQIhgaYinzwFhw
         +7WPcYnJD/K3vPOrAbhlsgjDVWteBpLY8L8SYfEYKncfM0vM0TDCFyxgTJbCLOwLmuY0
         vUBEAGOdZ+CydILhHTLjRJ4DqtJkSD2F0cn01Dq5Sgd8KaipRyseUQDsNuVkEoCjgxGa
         6f7w3Co28c4CwVKh/Sp5dyo+U6veYqRpVxC8wiTefhMDLYBVR3z00c//rGR9ZafzAbjg
         QAZw==
X-Gm-Message-State: AOJu0Yw3nQeEC0CU5uOb6AhODChgbw5XSAAffjZryzlRNHV+ZYNUcmGe
	OpTlYfz8nx365klnKKqVFKLHXmic1+J1FH1IYFA3oODPo86C76XCSLGw3GX+tBoV
X-Gm-Gg: ASbGncudCLdXi0mSTS6U8V2jikB87A93QX8Vp0QyBY0WSwGiz6HQLRJIR04MumX8tLF
	dzSh1dt2A7HiIjFYI8ZzDdUzNIjBwYHw0Wm2qNq8uqU7EvmLsrCnw4CjAzzZPJ9Y9eIRAm99igu
	KSJ6EdaC30ogk53bmWa3UPHUksbFsEQwMxI+S2eJ7yfH9gF7TsdpFur0s2HcmzKkbdg2VffzdCK
	nIicVN4GDxO53mc6/yQg4kFm2ICx0AlJTWUmS4jtyJr/ahGgXMRU5DAz6KfKqhV1L4kTviKrwIJ
	igvv/nFEmKYgXif5NlW55V9665u8QsV0zsuxz65NzX8FN0hFIQmHomJhaXxDzajjzMiEbebfz1B
	RIRZDWSp6u5sp5ZaiOc6Nt3RCQXvA9aKkJ0ZbSvtEv9SSxw==
X-Google-Smtp-Source: AGHT+IES8zKcWM2UUY53HQG5Ltlvbnr4s935zOx7q1mKi3/DbMOcnNhxaIjlsji48eLUaZpWbLYxPQ==
X-Received: by 2002:a17:902:f650:b0:234:a139:11f0 with SMTP id d9443c01a7336-23e2566b058mr79354155ad.7.1752739040593;
        Thu, 17 Jul 2025 00:57:20 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e92sm143118425ad.128.2025.07.17.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:57:19 -0700 (PDT)
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
Subject: [PATCH v3 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Thu, 17 Jul 2025 13:26:58 +0530
Message-ID: <20250717075659.2725245-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717075659.2725245-1-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
 <20250717075659.2725245-1-krikku@gmail.com>
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


