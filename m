Return-Path: <netdev+bounces-77585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031F872397
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB22285B8E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5E129A89;
	Tue,  5 Mar 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wufV5YEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005D1292FD
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654669; cv=none; b=VojtT9LUX/1DQ3pGrST9ScJaU6+56Bp1j8ZNEkAJz+Ey/bOfMwphFuL11KktL0J43jHAyWtGYaEBnJmiVCN0AP7g2ic00RtXJxh9L1Nj1idZQWNCL0Q7A0MDE+UAXLLflye7K92Ks5vx95daiMZABErVCzRD1F2E6XI1Z/TNnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654669; c=relaxed/simple;
	bh=snMuZN97+kOSp/1k7e6f4mv9qsuzm6DWJUPob6gN3yU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SfBw4XmYVPeCHTjpiTTmQYtEXVc+IaqT37Wj8rvucgY356sKLFBgUNy2pyGDxygMmg1w5gCFlRjHzJMydHCBSKtRM+8I58JON6c2Ly2qQQTuE/Ch8uCOJehJMkuiCM2xKMzbPYnzKVOhPXpQNr6T4rIR5zZ4F10NsGLeWIWstn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wufV5YEC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so8506459276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654667; x=1710259467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFWf2CBTF8+VR6S687evZT9Hnp4r7DP5+F9I/vsP0fY=;
        b=wufV5YECY7pG+kW6TLarBd31bNs9cAPi47+J16v9ffFL0SlQaRjFqUrRsFcLpyflQj
         9sVfaBFpyTt5h09gOGAGglgn2ekH6zD0w9W2dkAs1BIm5dpIoge6l0OACWjht/A8tVYf
         Dy8FdA0WQ87t6FX+cxu9IjpF/3ZfbMDCrSlk6pOwjkvYA2s31TvIe+ZxiJM7ZxU+HW5l
         zcDtRYkz848lQSpDWYzAPApZ9mQ6B5kNe9xMvGk4dPeq7WPHRx7Wk1cnQO6w9tCFqWh/
         krbTV7NmZ8P1wp+hEAcQTQ7B3+AYBTQOyXusbD3kNNDDUboHX7oYwAwCeBnQayQh1o86
         eo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654667; x=1710259467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFWf2CBTF8+VR6S687evZT9Hnp4r7DP5+F9I/vsP0fY=;
        b=pmFRA0SRz5Sru5SeVkO+dbXoEnN+znRio9rhwvwX1SBhyKMTcwymlQvZfB8lkrnvmG
         e6ttZxkFvxYIBEsfcgApS7y6By27V+JPR8iZkXWTjX8ru1FAt+K+IRNMoQA3PXZwHhew
         OaocfmF6z5QwM81A3f1gIjYmP8FSC9roxr2hoyAP7dGJ+k0uLwCQhfpjeYxAVIGHyi51
         Q3Y/2TQBqzstowK/j8C5SLOQj+n93ADp7t9DgCp3kmVuFzu73Vncn/2yALs2n3ZxGXOq
         asxAPnXWy/1+phad0pHAVQ7Eb2Y5fptvEIhNbeDlpo9eOZFG84AA3UXUwTLBAqwYvOdz
         HpfQ==
X-Gm-Message-State: AOJu0Yxslye3iVnDfw3CFRdI6ru+aV4W/TiyOhhYD0+JkHRl0Ma8wHyX
	bu3qEkKfzq6whCy+wTaSdVHV1E/GbZB5KkYOGILnefAJv/GMDCnNPq7wrxo7rkl2t5YFjlPsbad
	2WV5XCQK0sw==
X-Google-Smtp-Source: AGHT+IFR/J4nQPkY/BmaUZQbMg+GvDpovKC3txgtx9O2ofXDBlT0aug27UDE1RoQPsxE9HwEgWaP2bPImT+T5Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:110a:b0:dc7:49a9:6666 with SMTP
 id o10-20020a056902110a00b00dc749a96666mr3121810ybu.3.1709654667534; Tue, 05
 Mar 2024 08:04:27 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:03 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-9-edumazet@google.com>
Subject: [PATCH net-next 08/18] net: move dev_tx_weight to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_tx_weight is used in tx fast path.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h  | 1 -
 include/net/hotdata.h      | 1 +
 net/core/dev.c             | 1 -
 net/core/hotdata.c         | 1 +
 net/core/sysctl_net_core.c | 2 +-
 net/sched/sch_generic.c    | 3 ++-
 6 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 044d6f5b2ace3e2decd4296e01c8d3e200c6c7dc..c2a735edc44be95fbd4bbd1e234d883582bfde10 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4788,7 +4788,6 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 
 extern int		dev_rx_weight;
-extern int		dev_tx_weight;
 
 enum {
 	NESTED_SYNC_IMM_BIT,
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index a4a8df3bc0dea1b4c9589bd70f7ac457ebc5b634..2b0eb6b7f1f2c9b1273b07e06ba0b5c12a2934bf 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -23,6 +23,7 @@ struct net_hotdata {
 	int			netdev_budget_usecs;
 	int			tstamp_prequeue;
 	int			max_backlog;
+	int			dev_tx_weight;
 };
 
 extern struct net_hotdata net_hotdata;
diff --git a/net/core/dev.c b/net/core/dev.c
index 1b112c4db983c2d7cd280bc8c2ebc621ea3c6145..3f8d451f42fb9ba621f1ea19e784c7f0be0bf2d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4409,7 +4409,6 @@ int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
 int dev_rx_weight __read_mostly = 64;
-int dev_tx_weight __read_mostly = 64;
 
 /* Called with irq disabled */
 static inline void ____napi_schedule(struct softnet_data *sd,
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 35ed5a83ecc7ebda513fe4fafc596e053f0252c5..ec8c3b48e8fea57491c5870055cffb44c779db44 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -16,5 +16,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 
 	.tstamp_prequeue = 1,
 	.max_backlog = 1000,
+	.dev_tx_weight = 64,
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8eaeeb289914258f90cf940e906d5c6be0cc0cd6..a30016a8660e09db89b3153e4103c185a800a2ef 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -302,7 +302,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
 		WRITE_ONCE(dev_rx_weight, weight * dev_weight_rx_bias);
-		WRITE_ONCE(dev_tx_weight, weight * dev_weight_tx_bias);
+		WRITE_ONCE(net_hotdata.dev_tx_weight, weight * dev_weight_tx_bias);
 	}
 	mutex_unlock(&dev_weight_mutex);
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 9b3e9262040b6ef6516752c558c8997bf4054123..ff5336493777507242320d7e9214c637663f0734 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -27,6 +27,7 @@
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/dst.h>
+#include <net/hotdata.h>
 #include <trace/events/qdisc.h>
 #include <trace/events/net.h>
 #include <net/xfrm.h>
@@ -409,7 +410,7 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets)
 
 void __qdisc_run(struct Qdisc *q)
 {
-	int quota = READ_ONCE(dev_tx_weight);
+	int quota = READ_ONCE(net_hotdata.dev_tx_weight);
 	int packets;
 
 	while (qdisc_restart(q, &packets)) {
-- 
2.44.0.278.ge034bb2e1d-goog


