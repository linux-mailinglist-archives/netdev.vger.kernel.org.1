Return-Path: <netdev+bounces-214703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2528B2AF67
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2173A7328
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712EC320395;
	Mon, 18 Aug 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN3ud8bK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782D79CF;
	Mon, 18 Aug 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538092; cv=none; b=O80JRQoM9lpr49y0X+MZU4GbI/wvriVfIECyENkvLTa2bzf0nCRwHXvE8hmYp+S9lrAyq7rmwbE77WavBVJbCsl33AuqU1/P0dkS8qb0Cm7/MB3CO1G5KBeCcWEBzEOy9O9fGWCXsAZrtBo4L/sAQdAi05t2Hi/OhK3O9Ca0YTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538092; c=relaxed/simple;
	bh=kbs4iXyt9FHLQBgq57xTwRMFpLnJCXnI7eRZP9hyCm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljZl3BOncrQcg56uYFU+9LFNbbVw3ORvvA2Pins0M3vGT7i+8/u6L359j8eDc0ofCD7ZZeGCYjbt8mfV4imzeehtG/zQrrR72g0T5l5YBzBcoqtUwnJ1fUQKE87Pwfx6iajwIwbz549xDu3sBb+Vrh4NeThx6j2datqvuVGA104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN3ud8bK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso5290406b3a.0;
        Mon, 18 Aug 2025 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755538090; x=1756142890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acWiq/Eu4b97jl66iamb5rGB9A+KleSKxHt2g6OTFPc=;
        b=LN3ud8bKcTBtsQaPqotSR2MLEaIaJsdyWCgR00VPCZd9/CR54l6lAuLvl94JuXIzhe
         +LXs9pXhbHNGhJfZpkIRLXLrP8sbn0phnq2psERSaFuRzAxdvXQrBX8oz1SJonD53Ph4
         qrjXNchZrFkdmYJzy2Sv21EYAaQmQFHTAQtL0t4O3XQgSus4WJUqMsU4iJ9rAVVSf41Q
         cJxt1rqqpiz53LYu6L/+K8wXukvf7nCWZ9oH3+czklrYseVvSpzZn6th+EMODT5pzDKX
         L7Shc/m7Ypfn7vbADGwGdlvvGAjA/UpnMsRCGUpG0efRA5p6jDcqgFV5S8tsLfu9CEGi
         vUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538090; x=1756142890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acWiq/Eu4b97jl66iamb5rGB9A+KleSKxHt2g6OTFPc=;
        b=NjgNy4JwQoemnf98NpJ+Uihojcyz3RToCJHrX2hr6vuXvx9QQJlDfAhPqf21BPi1xp
         nVH2NGZxHiXDxlBAzlxTK5cnuprfSJ6egghPQA+iHDKZCBLUQO7MHt91c2N7qVHxIt0d
         jeP4w3TYwXmYrz8n28hGpPCObxlLht7x7/UdQ9zEATZsK78dUi7SR5ycieB1PAp6KVCB
         0Y1+a66ReKKd9yXU9toatzRe4xGre7qMZGInYyvC59iV7wUIUMkvHlT5MG4nVLWRGB21
         U7aHVDjUGlPkTi5czt35N2ckMq9F2qCKVYD5CQDY4bYBPOcLuzcWTKXi192S2C35EQlZ
         8q0w==
X-Forwarded-Encrypted: i=1; AJvYcCV8dB0F6s8bTtLoRk29mbpU42EWdJAOm2lFnECXl+B3pS2LD8VMZWwRX7hgiQRjaHBw3GONLG8OkP6z6EM=@vger.kernel.org, AJvYcCWdHmEq9eS/L/w8jIEeOpVbXeW8JK666heikz8BKzIOtFaSkWI6lixKtKOMAIvZshKCybxyPViC@vger.kernel.org
X-Gm-Message-State: AOJu0YwevLVFqCuJTBXvy19u/P+C6i0fOsnZVAm5zqWI3atazAuU+YP+
	+67Uos37tVPEs4ySlsChLT00WAia1CdKINgdJTxGvat+wnt/vTUioHoD1c97Fw==
X-Gm-Gg: ASbGncuJN4WerFd1CwrEuPixg5+dEc4CPtDZR6ocALE5YQBqakFVPonxUg2UahFHsei
	H96IJwjgDI2vcaBWxdafy9hGqqHN+y5hGv3q27qVSQebRDbxieU1Omz0RIUvrH/y9Q2cC5W7uf4
	mWxDyexeR/mbLbhgsulgLeGFN1jUX48QGuS2jnVe1CtdvPLU5sxVwWFI0Okeqw7Hrss+3/R67qZ
	6MFr17mU67MT6KDW9spy+FqemC8uumEL9tvBIra0yX9Xlmhh2UnVtU7cj0YRr3Pt3xEP1nIArRm
	k4bFyTdXD5e+v5lj7hM6Y65diSStTVXTlXLKFccgNd5ZrJ1TmGt8LvpENaLzJTORySc3uq9bfTc
	LY9LdFHqg/+XwuALbW25ThQ==
X-Google-Smtp-Source: AGHT+IFmRSySa45xD9fCEzcHsqRlZjFBWp1yVfJrKh54MmrWxQXTyfMCfcK8RaNkWNIs2+SqbAlNzg==
X-Received: by 2002:a17:902:d482:b0:242:c66f:9f80 with SMTP id d9443c01a7336-2446da0196cmr177872225ad.53.1755538089876;
        Mon, 18 Aug 2025 10:28:09 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54e2a3sm85679165ad.125.2025.08.18.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:28:09 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] net: openvswitch: Use for_each_cpu() where appropriate
Date: Mon, 18 Aug 2025 13:28:05 -0400
Message-ID: <20250818172806.189325-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

Due to legacy reasons, openswitch code opencodes for_each_cpu() to make
sure that CPU0 is always considered.

Since commit c4b2bf6b4a35 ("openvswitch: Optimize operations for OvS
flow_stats."), the corresponding  flow->cpu_used_mask is initialized
such that CPU0 is explicitly set.

So, switch the code to using plain for_each_cpu().

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 net/openvswitch/flow.c       | 12 ++++--------
 net/openvswitch/flow_table.c |  7 +++----
 2 files changed, 7 insertions(+), 12 deletions(-)

v1: https://lore.kernel.org/all/20250814195838.388693-1-yury.norov@gmail.com/
v2:
 - always include CPU0 (Ilya);

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index b80bd3a90773..66366982f604 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -129,15 +129,13 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 			struct ovs_flow_stats *ovs_stats,
 			unsigned long *used, __be16 *tcp_flags)
 {
-	int cpu;
+	unsigned int cpu;
 
 	*used = 0;
 	*tcp_flags = 0;
 	memset(ovs_stats, 0, sizeof(*ovs_stats));
 
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+	for_each_cpu(cpu, flow->cpu_used_mask) {
 		struct sw_flow_stats *stats = rcu_dereference_ovsl(flow->stats[cpu]);
 
 		if (stats) {
@@ -158,11 +156,9 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 /* Called with ovs_mutex. */
 void ovs_flow_stats_clear(struct sw_flow *flow)
 {
-	int cpu;
+	unsigned int cpu;
 
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+	for_each_cpu(cpu, flow->cpu_used_mask) {
 		struct sw_flow_stats *stats = ovsl_dereference(flow->stats[cpu]);
 
 		if (stats) {
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index d108ae0bd0ee..ffc72a741a50 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -107,16 +107,15 @@ int ovs_flow_tbl_count(const struct flow_table *table)
 
 static void flow_free(struct sw_flow *flow)
 {
-	int cpu;
+	unsigned int cpu;
 
 	if (ovs_identifier_is_key(&flow->id))
 		kfree(flow->id.unmasked_key);
 	if (flow->sf_acts)
 		ovs_nla_free_flow_actions((struct sw_flow_actions __force *)
 					  flow->sf_acts);
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+
+	for_each_cpu(cpu, flow->cpu_used_mask) {
 		if (flow->stats[cpu])
 			kmem_cache_free(flow_stats_cache,
 					(struct sw_flow_stats __force *)flow->stats[cpu]);
-- 
2.43.0


