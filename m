Return-Path: <netdev+bounces-219943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2CCB43D1F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032E37BA82F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948A304BCE;
	Thu,  4 Sep 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhnxMLvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1E303C93
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992364; cv=none; b=R9fcl+o1Rgc0sPoXWgZ0XUft7mUGu7StzXrLRj0yLhRBzQBl/oEfAsKGg8IKxZwHuKKrmjezMJNazYEKSlwKZ6NYqH67yKusoA6P0xv1bLULDWNwLwkBmgGrs6vw7glSoNJjvQ7BiN+61j8J1RC6xZS+HKHwjPlS99bbuFzZY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992364; c=relaxed/simple;
	bh=GZMG/nEEe5LQUKeGQvCOmwi9hyVMn2vGaM/kuik3Ryk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQymnsmy4toZEBGbmuVRKTUHdI04ekIdd7u/Sz+y2xq4GJQtRXQmiIbe2Hob+DnOrRxQb0hY3KLrvZcbFDxtHSa49A3iWZSqEyVC/b0QlpjYAbrrOY05fh5pE98QIf3O+I2MFVj1co7OeRvTt97s/xNkjVMgftQFDsBJHH7g+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhnxMLvo; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b3415ddb6aso37172021cf.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756992361; x=1757597161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ev0TcCL9IHPUsCug1HmKcJpWPjQpEMO4NfpFj3H+Bg=;
        b=mhnxMLvojfqNO0zPEKBXrNeEiQKfsLLw+f5djLod/L4TqGHFdEN5uSreCLbmaqVQy4
         oaUOsn3gvrLhFLZ4Bp0EzgkQ49JKsfC9SX/GrbZedFYeiqYjt9GyodFGpScP1IiMCNK8
         gFxK0jJr66scmhWgj0G+ab2KV1J4j2pIs589M1ypbJUoJ2n0yzvs1E7nrSu2wF5XqGge
         9ky7XJhV7M959fnZVM0oVgr5X1udnaCCZOMdOyZobbDGJLoI3EIeoZwwQC7olNj92ouT
         KePE6xs6dRRe6IUYn51DoFATD60BvUrLlRWob8N5cCtLsGDqnwa3BawbnWtGbS9vMjDk
         4pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992361; x=1757597161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ev0TcCL9IHPUsCug1HmKcJpWPjQpEMO4NfpFj3H+Bg=;
        b=LQlk2KOQEXI/LXsZfw3o2UpxdHfrLrlpTdZKhFQE86jvEuQbXqF7Rs6XQd8hAvFCNT
         xo1nmazuT1fjTh2fTb9TbsAIXeD0ZEsHADzHaKnti5m9wE8+KWiN6NIq9byA/LwMzn/4
         FArBKyYrM0N3KuVAYrgnqhR2z95UJT8mq1dKkiZ59oJunIQrj6zfk6jqvbGz4W1klEVM
         Xxyb8jUYL3T1Ztdr5b/jJCCMij6+D/eFKHHB0IwNvGkKOvFH+r/Qao5DQn6VAODC5U5f
         fEVv3ydfckzufRCXQJpI+6H6n0f+BnwOKx0QyIKjzVEC5SeIriMTQjomUGeAb1Z8TjG4
         b3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTdD5nNrOebwTBOA97rpWRCGiH1DZixZ983eqyTBOSgDNay5sG9R5e/JTOkvAIJRYxmUp9HGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDmme0lw81Fl3YLDpDAGXBrulykHJkfDVj4I4lmqq5kP42PYK
	EARAuO/WSDepElVVirunfflf/FRPXtuVoqsAe31FXy4j2wvN9mrmBSP1UZ/joG+Rf09h2Ukx9VC
	3I6gPLvGFYzeWuA==
X-Google-Smtp-Source: AGHT+IFXtbQxeZSWoqyBmKsQo/UuUPrePQWqDa4FT4FkkgmrdRg1cZp64o8K7d6ivoIGF1X+J65jUZ46D9OcqA==
X-Received: from qtblw11.prod.google.com ([2002:a05:622a:a60b:b0:4ab:b3a4:9650])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:11c1:b0:4b0:62c6:74c3 with SMTP id d75a77b69052e-4b31b98c995mr222215041cf.22.1756992361179;
 Thu, 04 Sep 2025 06:26:01 -0700 (PDT)
Date: Thu,  4 Sep 2025 13:25:52 +0000
In-Reply-To: <20250904132554.2891227-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904132554.2891227-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904132554.2891227-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
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
 include/net/ip.h | 11 +++++++++++
 net/ipv6/proc.c  | 39 ++++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6dbd2bf8fa9c..856e62aae036 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -349,6 +349,17 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
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
index e96f14a36834..6dc06a11e05a 100644
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
@@ -182,27 +178,29 @@ static void snmp6_seq_show_icmpv6msg(struct seq_file *seq, atomic_long_t *smib)
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
@@ -210,7 +208,7 @@ static void snmp6_seq_show_item64(struct seq_file *seq, void __percpu *mib,
 	memset(buff64, 0, sizeof(u64) * SNMP_MIB_MAX);
 
 	snmp_get_cpu_field64_batch(buff64, itemlist, mib, syncpoff);
-	for (i = 0; itemlist[i].name; i++)
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
2.51.0.338.gd7d06c2dae-goog


