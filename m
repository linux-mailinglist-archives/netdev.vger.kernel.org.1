Return-Path: <netdev+bounces-207079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A9B058AD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CB61A65078
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39742D948B;
	Tue, 15 Jul 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icdHuthx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38F1547C9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578691; cv=none; b=jJGyntv+sJB5PR2Q+U0DRMfxReKmOaOqdgurHfm1qinmix555S0G/sR+8LAdT4UW/sJdO2Rfu3oPcoqjgJANZsx73aRXKQm6GFkz/7h/lEoV0+xyMI8vRWfY/Ksbea1LJIiYTpGUChN7S6AHDQd945x1FzPZAPXh+f5uTeT4t+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578691; c=relaxed/simple;
	bh=Ux3YXJvM0BkCPUlYGmU+bISxPsqnWYG4Y5P9pbw05hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly9O3sQvs1ElbpV5UcGBU3GFOi5u3NuhWIWr9ccDH+mg/D+1lnzja/1vkkeRbOcoqin4HDzBQoGy0hYs61h+mDnuFzHmrHa1JMfXWtsm1RYXPDoEUID3l2r1Pnp5EH3eHRpJK1Hxu2gnPvvarrjstoxtVkTVqnq3we5j4WgZvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icdHuthx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so5097790b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578689; x=1753183489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYbR+cTxICRI4uKo/utgI30oZxXgMmmopVAXBaO5FFA=;
        b=icdHuthxdJ50ZRWuz0OfetgSVxB9RN6VAFCTnZQLSNKQczGOwrDFgIdg422+aFqZrn
         4sX2f+j6trUdepAOD9DYwZCAD2oW2yIHm1O7mrJJ9pf/eyXwseccJ0sU5SuvpNP8WGQY
         6sZb2ZU+oWlyw6aulJumb/PV5/qzw/DnW27Isjd9BAQvDIo27dmxXQB5GiY7DAph9UQK
         k2+MP1+jmRUJydnt/FxXW5rimIBTquvKgth3i39QW3oS8o/79HsM5MDmjnISp5oyAXPW
         ESkoJxzE5YFnkGM/jVNxsj1i93W4f3C/KcXxnqoHAEhLRzEEP4943x46m24PYn6hUju8
         pNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578689; x=1753183489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYbR+cTxICRI4uKo/utgI30oZxXgMmmopVAXBaO5FFA=;
        b=SeikWocKPJVs7zB24FZpvos2tNSNEMM10JYJiCbdZGCW1Cma8ZD/LqbUnrGjYK3YRG
         tkmmvvY31yfJxBfBY9BDMcxL3Yi0wlDk8nve1nwL+D3/59eTtKwN0dj+D0A8IHr/GysS
         CMlGDyU7Om64+xO0QIY70lRP9YRl5AiU1Yezr36I8TavE7GNddM4sZIRTfFvC4GGlUfJ
         VrGGskdW6Lsf76CQRSqKjWqs26K8YhgCJDCWiFZq4iG/jSkAOrkGDh2g6q+AnMJ0EEaN
         /MZ50e+I+TsZFNn5C6x+3/Dzq2yANFJ7zGh9CrZ/WH6K8SGfOoXj1SlzfXqubc/yyxHI
         7glA==
X-Gm-Message-State: AOJu0YzOgSYpv3krf4l4mgaKFaNG4MRSEHIY654PXa2iSPw02FjJWhLl
	wbUeNcRim4QDsXli26Nuj6RkVRoz3dAY1nfnhVKRShi1BeWvAdzfDhHMkeZvoQPP
X-Gm-Gg: ASbGnctfqP3zEIgDkOacNGLXdPRzN+uDcEfpf+piK/3Vz6lmL5u0XrQN1i3r7Ck+xr6
	C0x60CUv2xYFpCwGlwcjYoFIAPQ2YHkgW76Sy2tA8axavISQhrh2gFpi74pFEneIqC3CnLA/14n
	NFazytH+imHMDqM6/PV0XoTFfi8PYPMVqFC1Za4e3N26QHrEm0OFIqW0HbgigL6s6A6dJQy6t+G
	tAdDhBbY7zZb2QYpeYHXhPfenTS2pC9RhHIgl4c74uXioBRxrlJ2xtxCN9Vp94xqYs5trcGgkZl
	mRg4kO2mNrRjwTvvk69GBCaxWFQL7KWaksorEyhKHfezhb6tsHykEZhsNItmtlg1NOSbnrF8G8r
	5DFpMAyBM5aMXvwFZ6TYbwNTyvNqE0k0JPC8=
X-Google-Smtp-Source: AGHT+IE5bNzXpkUjbjH0cuX4WxMjv0/NebzDlqh6q23hJOgLA42iVP+zwnPHnX4KLJpLVsttad5mxA==
X-Received: by 2002:a05:6a21:3995:b0:226:d295:bd6a with SMTP id adf61e73a8af0-2317ad4d434mr33384228637.0.1752578689374;
        Tue, 15 Jul 2025 04:24:49 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3ecd5765bcsm734814a12.54.2025.07.15.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:24:48 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com
Cc: tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com
Subject: [PATCH v2 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Tue, 15 Jul 2025 16:54:31 +0530
Message-ID: <20250715112431.2178100-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715112431.2178100-1-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
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
index d6eece960d0d..09b989aa9ef0 100644
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
2.43.0


