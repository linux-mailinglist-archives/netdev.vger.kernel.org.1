Return-Path: <netdev+bounces-77999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E1873B79
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361021C2330C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001313BACF;
	Wed,  6 Mar 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhZl1x3t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4813AA5E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740856; cv=none; b=dDPC7+vtoRuE0ftigL1Pg3S1RU1h9pMhWkxx8F2ANd9Tdbz11NdGNMd3RMpU3a4w13BSxw0V6NYtVTmHCzwbzZEnU7S4j5hLOJoRGvfmAzV4vWWsX3Womz8G4nNtHXjhqeGHY5zqoWFeUaQatO6LgCZBkQEwuxRQBG01R0+Pe7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740856; c=relaxed/simple;
	bh=UpOECQ3EsXx1llJf2/AC24w2jXjh4gJW+k6maZ5Axp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvdeFL4DuuAwgBdgTfXerYuvCA/3W+ac3mit4II1O85Z1Tpg3x3liZNq8hCadLILHIPiYlexOnjT8M3gJzSkhteKExcZfEz+m9Puz7DakkfLR7xJEOCLm5bKm6erpwhHBiZdsTwkncBeuplOExsBOtUCRlTOu0ZbsGD7/OHx1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhZl1x3t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso1878317276.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740853; x=1710345653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzq8LB/+DmQPB8YTErAS3EzxbMbhKqJ8XJlWs7RBP3w=;
        b=vhZl1x3t/ISO+qQPm1JrsMaLh+nEzu+pVXm1F9Q8FtHdjwiGS21aVnzlZb7ueWU9pJ
         fjejxMZlQ9wyYkn5dOBtFjPq29C/sacQpaNPbqA7xYHx5pNl3tvX7SN6rpUkinTvqgA8
         PHsjP5S0WtR/d8B+vczWxrp7+9DoF1WopBrfSpMkGsvoae7sTMu/5TTVPI9ocW3lM2Tz
         Rjvbvr1UzCtR0mf7jLAQRfTK98x/0C9BgDJWG1hiKwfGgnYZvwSop23z4sQnXBqcq/5v
         TSu4EZQhFsBxtqyl/SxIZ8RwDBTEMyXTUUVFhYbPna90MzcK8Vaso+752cFAcM47114B
         QdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740853; x=1710345653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzq8LB/+DmQPB8YTErAS3EzxbMbhKqJ8XJlWs7RBP3w=;
        b=qDrZqOzVc6PqvDY29RSZD5lmij5oaBJ8dY0WOub7luWUlTtrAHQ4cb0Ki00LWaYutr
         pu47Qz3DYI0F+OPHXnwggBNTM/tEGCRv4uKGKzeAIuPVHTlcbXnAyZMNu4Zc+XuIyYlp
         XCl2QRFVtobEH38im4CemMscpayTrnmIM7zk4r6b8FoIskPFp1mzpYlFAbFtc+xcMxHf
         ByUWoj+Dda1K679rQcNOdWaPNP0UwEeY8stx+M19I85HjBt4p3f8flhJ95nIK+zS+fC5
         rMd7C2KLUoYMlpljPxZjWLaI2i2TAC8SI2+uxNzvXth/Sgfskr5XDh+u9mNlS991v1yz
         3OvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKP8niJUVmA123l9/gg0xqGJwP5zHExbmG67AtanhEQEuh9cXCiRKkj46gZnE1TXZ2z//HwU1sMa0ExADH+yuAzYRtufQ
X-Gm-Message-State: AOJu0YzvJFPTSdE9qZCtbE/2LjlJtAQiFwI8gG7KWkFNOR+ouDmEm5+N
	QcNzkhDrew7nvgtaTWXxltN/wsTz/u7k8LwabySJKkP4cwLVDCp0BN5l7uuLlt/ECqHnxWbx/KI
	AXMZVVMh2dg==
X-Google-Smtp-Source: AGHT+IGLXIFvoPvNLsXQqZoE+I9VDNHceFpYv8P+8C/18+bmievlR+3wlusQp78rMB6lL+i/XpbTSDsFgLxmMQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:df54:0:b0:dc6:53c3:bcbd with SMTP id
 w81-20020a25df54000000b00dc653c3bcbdmr3793723ybg.7.1709740853720; Wed, 06 Mar
 2024 08:00:53 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:21 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/18] net: move dev_tx_weight to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_tx_weight is used in tx fast path.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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
index d86d02f156fc350d508531d23b4fe06b2a27aca2..ffea9cc263e50e4eb69f4f60e2f10c256d9b633f 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -21,6 +21,7 @@ struct net_hotdata {
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


