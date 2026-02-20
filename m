Return-Path: <netdev+bounces-259728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJk6MShzmGkoIgMAu9opvQ
	(envelope-from <netdev+bounces-259728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E470E1687EB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D8A63002532
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C728D8FD;
	Fri, 20 Feb 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n24lVe0r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AC287265
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598628; cv=none; b=IetfxyZjMCDJPytOlpAaADBOUFFMfwyp2uKGm8BuEmvDTKH2lgaN+Xpk7a/dXio++fu87Rv2PB4VVZAJYNZTpPtnUsTD+QZN8mBOOl8fx8BAaT5aF9G9QKz35c8BD6KlUpPokOk1YBwLffdg2fp7mJr1zR4VD4FaGpRYxVDhOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598628; c=relaxed/simple;
	bh=ULvn95U9unFLL3+Q3z7LSlQErOusU3wWPUBxFXuLXXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d3Tf5jJqqQVLCZUM5CunQvmw78o/GaQwND00fc8T0PPUia7HZ99EeT0K17eO3JsGDaxr5AxS5o3T0t/Ij5bxA4W4Ot7wd3mkseIOp89RWe4xDvu3eJyTAACfOHbERKeOSQGzYQm1ueo1rfG8N2jEnCAGDWAMN2c0MJKqMDRfP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n24lVe0r; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50333a8184aso107781701cf.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771598626; x=1772203426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkhCr30RMPxtLUFaSm19lOv3JosN3wtSFFc8Hjajxjc=;
        b=n24lVe0rIM4U+qLet4eJOWaCOQWJwiHYVKzgLBxFxVa7Q7dF1y9oCa/v4Z+GFzC18X
         Abc3ejNsVUwu1jQByQp9mish3GMMeQuT7kT4a3X4+PFoBNn6sB2JJy+3JCesgr/yUGvb
         JxKNfnxUpIAQAt1WtOaE0jNe+beCpM3clNMitJJXRmLsKGbDK3peaQOXHNn8uzRH0ce9
         tlGWalmvPpZuWnOCT4qqfr9glIYmue4b2zhTA6+WdxKxtzDLw4cLJuXZJHXrtSoYOXGC
         M91bBetHuhSes4nR4OvykonvflwjeK0ynhm5Yy3xhqyAymi/Xb1XKK9k969HA0Z331Xh
         RgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771598626; x=1772203426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkhCr30RMPxtLUFaSm19lOv3JosN3wtSFFc8Hjajxjc=;
        b=FL1Rx7sytlRupiYFi+uGlsFMZw32MRygORIlOV4mHy7Ml0FMGgbtp/j8v77m66VSb7
         dbm0D1+5NKN5k6Y+Cp+ue2JwaawBOl8q6BHyRtMFWPGyY3RCMoAepELhPDMD1+bMLX2+
         9SCQJFjjumYO2yie0+QWwqUwjIuKcSIaskxTVt4YG32sqm7Nl/Prw4n0SRYoS0tTszDp
         DH+p6wk0i0c6OcyMi91knV+nkHpSnZYlF0V5SwZHPACPPX/bKESUKGoQc3DamqjPuqbm
         yrutHj+Y29hrEVnCwMZ1XT0zMRBUlS3KjXroj5SnuRSVpG5cZjaORYHjWnrmzM4MoSRS
         lQHA==
X-Forwarded-Encrypted: i=1; AJvYcCVVpqemhsPQqMxOEnRTXVdNxhyItUY9DL2CWCypMQgYz8QuUqTZR/UXI3KrVUCru4cLFsqNyNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1Elrmpb0ox0ixWegrAEMvU04qhG/u6d+6n7fj8vV0d9PwuSx
	W6x7vFkUPPpplq/QdzYivbR/ZrZZVPDpyW2IET0YMh+EL5+AXiGmSVz1LHM6JIlZejBDL0gQI0V
	9AMczTguD2n4Whg==
X-Received: from qvco8.prod.google.com ([2002:a05:6214:e48:b0:895:32cb:3ceb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3d2:b0:506:a1a8:c6fb with SMTP id d75a77b69052e-5070bba6b7cmr425041cf.2.1771598625676;
 Fri, 20 Feb 2026 06:43:45 -0800 (PST)
Date: Fri, 20 Feb 2026 14:43:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220144344.2548121-1-edumazet@google.com>
Subject: [PATCH net] net: fix potential out-of-bound access in set_rps_cpu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Krishna Kumar <krikku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259728-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E470E1687EB
X-Rspamd-Action: no action

Blamed commit forgot that set_rps_cpu() was reloading
rxqueue->rps_flow_table.

If this pointer has changed between get_rps_cpu() read it initially,
and the new table size is smaller than @flow_id,
we can access out-of-bound data and either corrupt memory or crash.

Fix this by passing the flow_table pointer from get_rps_cpu()
to set_rps_cpu(), more in line with RCU rules.

Fixes: 48aa30443e52 ("net: Cache hash and flow_id to avoid recalculation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Krishna Kumar <krikku@gmail.com>
---
 net/core/dev.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b9bf685cb74d0e762a2b00e97d9de..7c5e69c771caf7fd590e602384be49019853b490 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4993,13 +4993,11 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
-	    u32 flow_id)
+	    u32 flow_id, struct rps_dev_flow_table *flow_table)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
 #ifdef CONFIG_RFS_ACCEL
-		struct netdev_rx_queue *rxqueue;
-		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
@@ -5014,11 +5012,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (rxq_index == skb_get_rx_queue(skb))
 			goto out;
 
-		rxqueue = dev->_rx + rxq_index;
-		flow_table = rcu_dereference(rxqueue->rps_flow_table);
-		if (!flow_table)
-			goto out;
-
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -5134,7 +5127,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
-					    flow_id);
+					    flow_id, flow_table);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.53.0.345.g96ddfc5eaa-goog


