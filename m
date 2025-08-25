Return-Path: <netdev+bounces-216357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70EBB3346E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57653175E25
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37208236457;
	Mon, 25 Aug 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+WGLRPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA0221578
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091430; cv=none; b=up2tpfqU61FvZJ4XQtdsyv135kXcWgBRtzzf/Xeu8FKAKPWx70THCpntd0zxS8Y9TxEY4Ybj/7YxZHzE7Qe1up1dq38FcvoD0azaLBRL517w79/CWy3elUwaW5XxF6QcjI59675SZsH4jNrOH1puRxocnwu7DE/pXdv6rVlzPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091430; c=relaxed/simple;
	bh=yhfq7c/CLcV3FjMG4nf+AMvpkI7m4oGXGxyh6E7ZAnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCo1BnH9+Du8m9IVRzcUeZ4P5jC6aG0WoL5jLYeaLpj6wCRbuTBnoPpLG0AtN4whpn/WUa7+w7unyE2TeBXdj6ESe1iqyHq504w2n1EnFtPZyauOwvaIOXfPpOLgDcmGAWN8dPBGhQ6hdeuyyboS8+H5xqXD2L/LdLzROB/Zr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+WGLRPC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77053017462so691647b3a.1
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756091427; x=1756696227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC4nURQFHR+JLoxdstOfmvqV/X531RHBr0s+7owjXUg=;
        b=P+WGLRPChDfa8VuW/OngC9KiRgrh8Ij9Rx3kwqopdPiqvvljN+xe4XCgiy0tf+oHSq
         zHkUbSwocwSCKbdzyEjv5HUQdYFeCzIxgZ/A+4oMqJc4VTUaO2yMYOB6t6iHvBrePEbP
         S9UplndZDrh/BlAf2hTn7g6+jVLlNiM8lOyp69x+NEv3rZnFhqNcu31zMdhTLKk44mkX
         lVNEjBhf7JpLbSyWRqmtjwb4/6FwjOoGImmqCiSaCeOHqlTa8F2pK7aeV1ydg3dkAFYd
         bDBsS+UHOXOcBAryOhMPpqocOQsdyRSwrybaBBKwBDy+1K+R5AiICmSrv1876QSd0F4s
         8i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091427; x=1756696227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC4nURQFHR+JLoxdstOfmvqV/X531RHBr0s+7owjXUg=;
        b=abgZDuV20aPri2l2BNk8s2khU6qP88r8pNR4JXMFNiq/F6Rf3l6INuein/yGe8JOTo
         MjyDI0nRi3AM4ZZ0KP2R0ex0Kpyf6QuT6S0ljPf1G+MdjOPCf0/GHp0B0SZHdPFZiW7w
         LDI/lC3MqAb0vGrO3fcZVsbXpjVdYxy+K+11vxqa4fcJiWP97iEei9SQ56kwFOgJ/Afu
         /9a958CUpHLIF4vO0pS53ZxJfAdPsqkr7U8txzFpxnUgwOY+Ap/MFjcufjJ8ElqCx2SA
         8c5hdHzaFsQh0rp8PBB9hEAFxrcCfryl9kfhbZgvwQvVjNEKkjgzTuJ9hY4AuEYyQvV9
         2Rmw==
X-Gm-Message-State: AOJu0YxiKpT9M8nqJcxodB0yEJ37thhOdAXlIBaTM1NsJ6OTLS7j/6IT
	lNhGepSDQSR26RXYC2GzNYAsfclXRXTC4CtEi0vApp07wplK2lHVPjr1HzIS8s4j
X-Gm-Gg: ASbGncthCKmejxgohdE2k99Ihu39sOTqNF/tONhiqMeiqzmqH9a5+faCGHW1uEnk8oG
	QzZmuyt5w9k9yZoqMOAKd9B87KJcw587uWQK5l6s8M4rPSSXdGqpcZlylQVcYWdcJFRYFT+5C8E
	jCdzZbFcbFQfHWTLc7tBZgOVms5ZRRnpX+iO+D9RBlO4VH2ftmBmNfjzgXKAohuYWvzjJapkfRZ
	dlB3TiCaxOZxY6FQc/1jwdN7LAP5J2U6c47MhqpBrIUfPFWBHdNjQJlrQE8k7RFjyCeNoGKYbH9
	qeomojxcXHgYe/NN8ymJbqEjXltkXqWLF8FPSX9JyqVOA8xA+MkFhJXRmeuCxb6Oi/UZfMXkEEP
	EUIUSIaxQKFEBkB9hStpfveDymzNe9IxFchsnxtOcoA==
X-Google-Smtp-Source: AGHT+IFiXgB4p6bxyueFLtfJDbX84Pn1qA9OQ8oS+iYS9OMdPBHu5m+1vU6ZkxcsvUXmlbf/7TIFsw==
X-Received: by 2002:a05:6a20:9191:b0:233:b2f8:70c with SMTP id adf61e73a8af0-24340c48838mr15655587637.19.1756091427286;
        Sun, 24 Aug 2025 20:10:27 -0700 (PDT)
Received: from krishna-laptop.localdomain ([2401:4900:62f4:d6c0:d353:4049:5750:d5ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ebabeeffsm29162b3a.30.2025.08.24.20.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:10:26 -0700 (PDT)
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
Subject: [RESEND PATCH v7 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Mon, 25 Aug 2025 08:40:05 +0530
Message-ID: <20250825031005.3674864-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825031005.3674864-1-krikku@gmail.com>
References: <20250825031005.3674864-1-krikku@gmail.com>
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


