Return-Path: <netdev+bounces-210780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A20B14C6A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E4718A2AED
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6F28A70A;
	Tue, 29 Jul 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgbiy9DK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A528A708
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785692; cv=none; b=nUH13d3w5R083+Ge3yVuzCnZNcPCVNZCqq1EFV39UWi56+OcixibrpWnKA5SL9pN2vJx4Qg4xsRKbYcmYaUVnP2pRJdnx/cnCG6e5MZFYKBwWlE3qDkQ2bKLhxqOwcfNaRDCW8VFm0mKmWoHmwDjmVML0gGtOJQo8Sw1pHTGGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785692; c=relaxed/simple;
	bh=yhfq7c/CLcV3FjMG4nf+AMvpkI7m4oGXGxyh6E7ZAnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQw/eV0at7oIdWz4wE2NxbLkDU4sNoveRyDUC3c5f37O9EMO7DPTeqOX4LujlMcaSmQcqJfCMU7CFnz8ou9Z9Sm6N0uHUFf6OSQikefd/rf38EVnTtudtqMNFBx3ht2C5tbf6YdbeI3soQwSbH0FLPlRNcv1X+s9ZYd3LRGD1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgbiy9DK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fc5aedaf0so22403835ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753785689; x=1754390489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC4nURQFHR+JLoxdstOfmvqV/X531RHBr0s+7owjXUg=;
        b=Lgbiy9DKZFVH1edWmfeBBy3sZqusK5j1iF7NL0RMlZGry3154hZSUmrQ13EZrTBCcP
         RRTwfyK9NdBw8smw6MLVBsrAvbkAzDoPSuT0IAoW8OQQjhk1ZzTWcr8f0aWHUy3U/E5M
         r4eBb3bFqg/x2jOSdLmQJfufzK3+WqgIPo15curr7MJupm8uOn/sOUta1sZzpkVMEZMq
         VoenMkxAFyQNT35YNpKnj5ai3pG6oJs/d7jJG8zSFGlOW3CH/UwiW0ak9j3hQBvJ1dIX
         0FmDEmZ/7urRt3rNcV14qhIKdrpUZkehDKzXSLsdDvuHb8THD3Za1Xl2vuDriPVwsJjG
         EHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785689; x=1754390489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC4nURQFHR+JLoxdstOfmvqV/X531RHBr0s+7owjXUg=;
        b=DaqiRRlXuinRwlugDI3ccHQopwFBDJVE8igxLDtYscoaLj76PO/xbsmlTRCi/m/szs
         Lt7VQ0gT3BG+E7kzV/Yfmty6fgIVBVWfM6Tk+MjvRTR+hXto92YFEuuIsNBR91GP8ppF
         I1AAGUIJsVKKjWaSxq/11Dx8xzMVY9JjTaJ8hArxodHsSkQ1A4QiufNuyWTaUdQjTvya
         WiAFdexm4X9AbFzg1oG6wtZgBr08WhlEfI4P5ZMMlfRyQXYgGICnoyDcC/XporjQZdMA
         wnywwgJYTDQt1PLHFxqCnt/uKFIHa3VdOPnYkOb3Q6iMYxilMgonwO7Fia8EOq4xhn7n
         WZXw==
X-Gm-Message-State: AOJu0YzyHMBnHx6GtgaNwDDF+tKfS1mS2bPpEiwLw+G0JcpNid1z+wJF
	AJodMEWmrYoMRysOyo4qMZ1mrMrCLwSbcVpnNWr35kGb2MWXDydwZp384T0VA9vj
X-Gm-Gg: ASbGncv34Ndnxt9aDjZJy6BSkXa4DICTuE1RehDSAF+5+0NRJ+2NUE+GaCxPQd9vtpB
	WXcaOFws3sHMvfzg8vzTcui9jsnt9bCQCvZlNiyvf6plytPs0oBbFxi/ilLU/TwxihjZEGSZUsk
	qf7CnDrWepSYw1EwDE4Q3V27to3u0Og+mPE1aaxXxmeo9a/oJOGww7RpE5s7bhWwc9KiKPA+Drg
	yVN/BO+hdDsfNHnaCoEzkqdpvd2U9Yu2hfMNBNrCHpoqRDD6mayEamMwN7d1kfGR5CAO8zJGstC
	mxUrWButquPbYeOG6/mLu67tVY68lLsjYovX0A7zLnZjbt+f+XqnvEGseuQkcxPb24UMqaA8XaG
	gSk+wZ1wTmHKTXDE4jLZkQfPlY/5aoVvbSctlQidIQ4Pinj8=
X-Google-Smtp-Source: AGHT+IHQTHYTRVmQaCAtsageUvTFSyHWVSbfpit6UgkOY4zsMlVm9iykkMGovTWxi+mRUt1wvtH2zw==
X-Received: by 2002:a17:903:41d1:b0:240:2145:e51d with SMTP id d9443c01a7336-2402145e8c6mr118526285ad.31.1753785689457;
        Tue, 29 Jul 2025 03:41:29 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c9922d1sm36557855ad.13.2025.07.29.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:41:28 -0700 (PDT)
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
Subject: [PATCH v7 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Tue, 29 Jul 2025 16:11:09 +0530
Message-ID: <20250729104109.1687418-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729104109.1687418-1-krikku@gmail.com>
References: <20250729104109.1687418-1-krikku@gmail.com>
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
index 656eceb18e67..5083f97801d4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4869,7 +4869,8 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
+	    u32 flow_id)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -4880,8 +4881,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
-		u32 flow_id;
-		u32 hash;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4897,9 +4896,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
-		hash = skb_get_hash(skb);
-		flow_id = rfs_slot(hash, flow_table);
-
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -4947,6 +4943,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
+	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -4993,7 +4990,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, flow_table);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5012,7 +5010,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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


