Return-Path: <netdev+bounces-220417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1EB45F75
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350255823A6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C75313264;
	Fri,  5 Sep 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCCIpNLx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8F271476
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091501; cv=none; b=QEOU9nzlZ9mnom2w3QQS5dU88dmA1ot3V1md6FKTUghUbx2zgkDr0kVvQiFLtv4SYLFXRbNg4nXA1zQAEFhaJ6TT2aJVxlu+dNGtqHcWlFH3QUFXsZ5zB/LS10TUOV4a69QQSUTmzbxWsNvFrT4uF4ukOFCBGTLoRRHbwJxqyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091501; c=relaxed/simple;
	bh=Pmg/ZzMxeDFHMlghASzJvuUmOzwx+OyFcfuYH4kah4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXJqzXiJRa0mvwjHoI+LuoWAxHp+V+3KAKb07fH+j91Sw9u5yaOkT8K/mKBKc9ixBHhaFACtOI6ogf+AGNWV6sRIOGvrwIiZUL1PxRs9++1RK7A2wmWRX84lNukPBino1h/2WKCLnRvBvdwynLb4JRngZinhM4ra+xM7Q8wLVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCCIpNLx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e9d67ca7a23so3307663276.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091498; x=1757696298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lXG5sMQlcBpXmEwT4AjVPtFQPivjpGCnFyRYmFc3ho=;
        b=JCCIpNLxmsBXgg/AYk6vVYgGxeS3mdb4vZ1VrMdhPLL2nNz4YFYUKZxQbuvSo7e6fo
         Q3JmrfCPn8P6guX1ADqPN5SK+zYST984YME4G2uM/Cewd3N0h13OKzT0VRfEMdBFBF1g
         ZYxC7gWChBR+O0Nb7SeJ3a5JjB7i5QJ1on30WHZEPIE7oygfE+XHrnR3URtZiCnjM+KZ
         qhKNnRsATDASUKuRKIjliE+oZD/1whzJJH/X/tqRs2K4XTclZgnh7W1Z59Q/XZKCjYeH
         JmL6FnGFnN5YRvR0jWhuAVcm4PpgUgYhEYVNDr39Uld6H7n9lwNf3ECGIkDqlYUR2VER
         2fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091498; x=1757696298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lXG5sMQlcBpXmEwT4AjVPtFQPivjpGCnFyRYmFc3ho=;
        b=L1wZFgkBKB/wADO0Jo6hXEs1nwJHhFJeB+z11XsIYiTot37J4fYyY0TXzEmz6l+6uA
         nz5B0MEZ8Hx4BKg2PJ+CM8AyMjD9ZinExqlt42IsAnZecK4lkzglGDaNNa3onoT3JQyN
         2ugK4HmEqTwrwMOZ/WXnOmRkcRlIb7/v0OjpKhpGJugzQgWxsdCz5P47wC3lNhsrK8SR
         9kJrwardywVqoCJpaA2mZLa72C8b+bbpsMw5HCT8KVqA3l05Q+L72K35Bmj00eJpztQ4
         7vA2uKtepNWdXj0knODNkcDjKG2NRzSWB8kJMkeQoHtS7cYeR7C0tH3dGeb0EZc8rya3
         rEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zT3HsGiqIgEtqTrmhRZKFysYfA5M3KIrz1hCXccsynmuVjtZhfEVCXlueREWaXc9ev7PEEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJdY52TGPtCzr+xD2LclWSPbWvF9tOR6/8Glze7vJ9myA2GOE
	tIRHIHURo2sb4dy+YuzzrH30eXcl8/B06SPLKEWYoP02i0f+if2IyPliC5m+Yn8V/oDiXwiyDzG
	XGEVbdjjQHytdow==
X-Google-Smtp-Source: AGHT+IHFFfMDl1nKanMVreODCfoMtkRqSNpAka62fnqAvelhzHgUOFQrLpQGyhuMu8VFtyuN8HJLJmkaZnvYNw==
X-Received: from ybhx4.prod.google.com ([2002:a25:a004:0:b0:e93:3801:f5e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1890:b0:e97:644:85a2 with SMTP id 3f1490d57ef6-e98a5845465mr21574838276.35.1757091498525;
 Fri, 05 Sep 2025 09:58:18 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:06 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/9] ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Following patch needs this preliminary change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h | 24 ++++++++++++++++++++++++
 net/ipv6/proc.c  | 43 ++++++++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6dbd2bf8fa9c..a1624e8db1ab 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -338,6 +338,19 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
 	} \
 }
 
+#define snmp_get_cpu_field64_batch_cnt(buff64, stats_list, cnt,	\
+				       mib_statistic, offset)	\
+{ \
+	int i, c; \
+	for_each_possible_cpu(c) { \
+		for (i = 0; i < cnt; i++) \
+			buff64[i] += snmp_get_cpu_field64( \
+					mib_statistic, \
+					c, stats_list[i].entry, \
+					offset); \
+	} \
+}
+
 #define snmp_get_cpu_field_batch(buff, stats_list, mib_statistic) \
 { \
 	int i, c; \
@@ -349,6 +362,17 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
 	} \
 }
 
+#define snmp_get_cpu_field_batch_cnt(buff, stats_list, cnt, mib_statistic) \
+{ \
+	int i, c; \
+	for_each_possible_cpu(c) { \
+		for (i = 0; i < cnt; i++) \
+			buff[i] += snmp_get_cpu_field( \
+						mib_statistic, \
+						c, stats_list[i].entry); \
+	} \
+}
+
 static inline void inet_get_local_port_range(const struct net *net, int *low, int *high)
 {
 	u32 range = READ_ONCE(net->ipv4.ip_local_ports.range);
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index e96f14a36834..92ed04729c2f 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -85,7 +85,6 @@ static const struct snmp_mib snmp6_ipstats_list[] = {
 	SNMP_MIB_ITEM("Ip6InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("Ip6InCEPkts", IPSTATS_MIB_CEPKTS),
 	SNMP_MIB_ITEM("Ip6OutTransmits", IPSTATS_MIB_OUTPKTS),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct snmp_mib snmp6_icmp6_list[] = {
@@ -96,7 +95,6 @@ static const struct snmp_mib snmp6_icmp6_list[] = {
 	SNMP_MIB_ITEM("Icmp6OutErrors", ICMP6_MIB_OUTERRORS),
 	SNMP_MIB_ITEM("Icmp6InCsumErrors", ICMP6_MIB_CSUMERRORS),
 	SNMP_MIB_ITEM("Icmp6OutRateLimitHost", ICMP6_MIB_RATELIMITHOST),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct snmp_mib snmp6_udp6_list[] = {
@@ -109,7 +107,6 @@ static const struct snmp_mib snmp6_udp6_list[] = {
 	SNMP_MIB_ITEM("Udp6InCsumErrors", UDP_MIB_CSUMERRORS),
 	SNMP_MIB_ITEM("Udp6IgnoredMulti", UDP_MIB_IGNOREDMULTI),
 	SNMP_MIB_ITEM("Udp6MemErrors", UDP_MIB_MEMERRORS),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct snmp_mib snmp6_udplite6_list[] = {
@@ -121,7 +118,6 @@ static const struct snmp_mib snmp6_udplite6_list[] = {
 	SNMP_MIB_ITEM("UdpLite6SndbufErrors", UDP_MIB_SNDBUFERRORS),
 	SNMP_MIB_ITEM("UdpLite6InCsumErrors", UDP_MIB_CSUMERRORS),
 	SNMP_MIB_ITEM("UdpLite6MemErrors", UDP_MIB_MEMERRORS),
-	SNMP_MIB_SENTINEL
 };
 
 static void snmp6_seq_show_icmpv6msg(struct seq_file *seq, atomic_long_t *smib)
@@ -182,35 +178,37 @@ static void snmp6_seq_show_icmpv6msg(struct seq_file *seq, atomic_long_t *smib)
  */
 static void snmp6_seq_show_item(struct seq_file *seq, void __percpu *pcpumib,
 				atomic_long_t *smib,
-				const struct snmp_mib *itemlist)
+				const struct snmp_mib *itemlist,
+				int cnt)
 {
 	unsigned long buff[SNMP_MIB_MAX];
 	int i;
 
 	if (pcpumib) {
-		memset(buff, 0, sizeof(unsigned long) * SNMP_MIB_MAX);
+		memset(buff, 0, sizeof(unsigned long) * cnt);
 
-		snmp_get_cpu_field_batch(buff, itemlist, pcpumib);
-		for (i = 0; itemlist[i].name; i++)
+		snmp_get_cpu_field_batch_cnt(buff, itemlist, cnt, pcpumib);
+		for (i = 0; i < cnt; i++)
 			seq_printf(seq, "%-32s\t%lu\n",
 				   itemlist[i].name, buff[i]);
 	} else {
-		for (i = 0; itemlist[i].name; i++)
+		for (i = 0; i < cnt; i++)
 			seq_printf(seq, "%-32s\t%lu\n", itemlist[i].name,
 				   atomic_long_read(smib + itemlist[i].entry));
 	}
 }
 
 static void snmp6_seq_show_item64(struct seq_file *seq, void __percpu *mib,
-				  const struct snmp_mib *itemlist, size_t syncpoff)
+				  const struct snmp_mib *itemlist,
+				  int cnt, size_t syncpoff)
 {
 	u64 buff64[SNMP_MIB_MAX];
 	int i;
 
-	memset(buff64, 0, sizeof(u64) * SNMP_MIB_MAX);
+	memset(buff64, 0, sizeof(u64) * cnt);
 
-	snmp_get_cpu_field64_batch(buff64, itemlist, mib, syncpoff);
-	for (i = 0; itemlist[i].name; i++)
+	snmp_get_cpu_field64_batch_cnt(buff64, itemlist, cnt, mib, syncpoff);
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, "%-32s\t%llu\n", itemlist[i].name, buff64[i]);
 }
 
@@ -219,14 +217,19 @@ static int snmp6_seq_show(struct seq_file *seq, void *v)
 	struct net *net = (struct net *)seq->private;
 
 	snmp6_seq_show_item64(seq, net->mib.ipv6_statistics,
-			    snmp6_ipstats_list, offsetof(struct ipstats_mib, syncp));
+			      snmp6_ipstats_list,
+			      ARRAY_SIZE(snmp6_ipstats_list),
+			      offsetof(struct ipstats_mib, syncp));
 	snmp6_seq_show_item(seq, net->mib.icmpv6_statistics,
-			    NULL, snmp6_icmp6_list);
+			    NULL, snmp6_icmp6_list,
+			    ARRAY_SIZE(snmp6_icmp6_list));
 	snmp6_seq_show_icmpv6msg(seq, net->mib.icmpv6msg_statistics->mibs);
 	snmp6_seq_show_item(seq, net->mib.udp_stats_in6,
-			    NULL, snmp6_udp6_list);
+			    NULL, snmp6_udp6_list,
+			    ARRAY_SIZE(snmp6_udp6_list));
 	snmp6_seq_show_item(seq, net->mib.udplite_stats_in6,
-			    NULL, snmp6_udplite6_list);
+			    NULL, snmp6_udplite6_list,
+			    ARRAY_SIZE(snmp6_udplite6_list));
 	return 0;
 }
 
@@ -236,9 +239,11 @@ static int snmp6_dev_seq_show(struct seq_file *seq, void *v)
 
 	seq_printf(seq, "%-32s\t%u\n", "ifIndex", idev->dev->ifindex);
 	snmp6_seq_show_item64(seq, idev->stats.ipv6,
-			    snmp6_ipstats_list, offsetof(struct ipstats_mib, syncp));
+			      snmp6_ipstats_list,
+			      ARRAY_SIZE(snmp6_ipstats_list),
+			      offsetof(struct ipstats_mib, syncp));
 	snmp6_seq_show_item(seq, NULL, idev->stats.icmpv6dev->mibs,
-			    snmp6_icmp6_list);
+			    snmp6_icmp6_list, ARRAY_SIZE(snmp6_icmp6_list));
 	snmp6_seq_show_icmpv6msg(seq, idev->stats.icmpv6msgdev->mibs);
 	return 0;
 }
-- 
2.51.0.355.g5224444f11-goog


