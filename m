Return-Path: <netdev+bounces-220419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46DB45F77
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C201CC3671
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF853126CF;
	Fri,  5 Sep 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXBR5lNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A430B52F
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091504; cv=none; b=F1Z9nRWrKk4yFGyKkyZhGSLLPzCsp28Zx69jqmkpemzZhjho3i9j0aA9FqcaAqcmLa6hpK15Dc6sYRKZMs/8rnfvrf/7eivsdba8XlFquV/ZIZL0K6KYtjWPYfb8EAqafmpRLsfy3RIrBbiQfjl1G8vXDCvaEVTYjZZ5cJc4oXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091504; c=relaxed/simple;
	bh=Eqm8tjKtCkO4GgujJMzjK1c/qSpDQrjoKO5y1QG0Pps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3LQPHjfKZobrsfEG2aLZAWT7Si/hhbvZ7H70fxefmPLQENz8is5jDWcQSU+d4o1Nd4k1v6V718+x/f4VYVWJ7ZuCO/iLAtZ+OMEIumtfmD/hn6cQrQ1ubaG+EuD7yRp6HoU8ij8u7u4Uwx2g6xl1tKCdpLhtMDEZ5xH5cG9q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXBR5lNX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8063443ef8cso791169985a.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091501; x=1757696301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTuGzMQ6faMu5M3wZqPEtzvQ2O8Lntc0S55sKXAd6ik=;
        b=aXBR5lNX+lBo7X1ETXiLFWBkIiLRtiBjE3axGHbr2Y3xnvVX9QKm8sG9rhWVuHMOru
         1W8QXJixMfzdttF14EumnwvifpmPARRP85BxxvFZKjI2jxoDaoxtz5QFHbxMM0o4+CCM
         XtxfABEthoLYGNzGBOW01GCpU0SPYzqpiJvfD+o7P/o91H0B+EVwZKulzBJWzaEF+YcS
         kEolhwD7Hnu1wraL8JvZNUOAd0J4eUjeUBWmTTi+4p0ut/8iydzTkIbrFpJ7HRtOMJbB
         hQ+sTEn8glzX5+sYzzIHWuWL30uroR0De7sx1Tk2pihCUHLRxOnfB0kWjglOGDlHEDjm
         qLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091501; x=1757696301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTuGzMQ6faMu5M3wZqPEtzvQ2O8Lntc0S55sKXAd6ik=;
        b=UWCJGOpdbdK9V66WWvz8l3NSNwFfk5A23xY46OvmcuO1q3egfx4C3xYP8rU/Jqcp2e
         oEnIkBIWwxdruOZaqCVpa9O1TbsjXIVBNMZBLJdvRyAqWGESyYZFd/uUf7m5XQqwiEGq
         tIqdW9F4WypBGh4nxKbppScehlhgoHC6uWLIMkGv+gDw0mOf9Kal7Sg4lJQooFtc0t6o
         XiWjjeXoM2RGJKV9LTyOgJEHUHm3nMPZRG98QBa2QOh7i96wdHU/3WAAz8122M1LmTUX
         BdI9Nz5JtVlX4ODYWWQLhmOa9wjYbCoGkIltNVJHpTUJhnlUCkALCc4cKxuDQpkZetQr
         1LYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtbdHcktYBHiSwbVpeW8aPeiq2ASvrh500la7sIdCunloksPYIfXKpLMz9LNAoFtBxlqrbvi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+Lrnv3ygDHcytlBTIss3zF9Sgve+tNui6MhnLKtieoO26daq
	kixhcmEH0bSo/kFtFdLTiYb9vbm8/LB0spsFVkkq0Xxs3tGtt81XJ5KYvV+18w0z+8p1Aeo38lH
	fvn/ukMwS1TQFBQ==
X-Google-Smtp-Source: AGHT+IFtqI1CqKTIM/jrxhhrxuf2p0UJnIOVE7kPwhyJihgi9eBplT3DrZhT1S5OKibUWcgk+wlFn38zyqNfBg==
X-Received: from qkntz10.prod.google.com ([2002:a05:620a:690a:b0:7e8:8f3a:4779])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:171f:b0:812:2554:6b3a with SMTP id af79cd13be357-8122563b962mr230146285a.44.1757091501224;
 Fri, 05 Sep 2025 09:58:21 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:08 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/9] ipv4: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/proc.c | 65 +++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 65b0d0ab0084..974afc4ecbe2 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -95,7 +95,6 @@ static const struct snmp_mib snmp4_ipstats_list[] = {
 	SNMP_MIB_ITEM("FragFails", IPSTATS_MIB_FRAGFAILS),
 	SNMP_MIB_ITEM("FragCreates", IPSTATS_MIB_FRAGCREATES),
 	SNMP_MIB_ITEM("OutTransmits", IPSTATS_MIB_OUTPKTS),
-	SNMP_MIB_SENTINEL
 };
 
 /* Following items are displayed in /proc/net/netstat */
@@ -119,7 +118,6 @@ static const struct snmp_mib snmp4_ipextstats_list[] = {
 	SNMP_MIB_ITEM("InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("InCEPkts", IPSTATS_MIB_CEPKTS),
 	SNMP_MIB_ITEM("ReasmOverlaps", IPSTATS_MIB_REASM_OVERLAPS),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct {
@@ -157,7 +155,6 @@ static const struct snmp_mib snmp4_tcp_list[] = {
 	SNMP_MIB_ITEM("InErrs", TCP_MIB_INERRS),
 	SNMP_MIB_ITEM("OutRsts", TCP_MIB_OUTRSTS),
 	SNMP_MIB_ITEM("InCsumErrors", TCP_MIB_CSUMERRORS),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct snmp_mib snmp4_udp_list[] = {
@@ -170,7 +167,6 @@ static const struct snmp_mib snmp4_udp_list[] = {
 	SNMP_MIB_ITEM("InCsumErrors", UDP_MIB_CSUMERRORS),
 	SNMP_MIB_ITEM("IgnoredMulti", UDP_MIB_IGNOREDMULTI),
 	SNMP_MIB_ITEM("MemErrors", UDP_MIB_MEMERRORS),
-	SNMP_MIB_SENTINEL
 };
 
 static const struct snmp_mib snmp4_net_list[] = {
@@ -309,7 +305,6 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
 	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
-	SNMP_MIB_SENTINEL
 };
 
 static void icmpmsg_put_line(struct seq_file *seq, unsigned long *vals,
@@ -389,14 +384,15 @@ static void icmp_put(struct seq_file *seq)
  */
 static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 {
+	const int cnt = ARRAY_SIZE(snmp4_ipstats_list);
+	u64 buff64[ARRAY_SIZE(snmp4_ipstats_list)];
 	struct net *net = seq->private;
-	u64 buff64[IPSTATS_MIB_MAX];
 	int i;
 
-	memset(buff64, 0, IPSTATS_MIB_MAX * sizeof(u64));
+	memset(buff64, 0, sizeof(buff64));
 
 	seq_puts(seq, "Ip: Forwarding DefaultTTL");
-	for (i = 0; snmp4_ipstats_list[i].name; i++)
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, " %s", snmp4_ipstats_list[i].name);
 
 	seq_printf(seq, "\nIp: %d %d",
@@ -404,10 +400,10 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 		   READ_ONCE(net->ipv4.sysctl_ip_default_ttl));
 
 	BUILD_BUG_ON(offsetof(struct ipstats_mib, mibs) != 0);
-	snmp_get_cpu_field64_batch(buff64, snmp4_ipstats_list,
-				   net->mib.ip_statistics,
-				   offsetof(struct ipstats_mib, syncp));
-	for (i = 0; snmp4_ipstats_list[i].name; i++)
+	snmp_get_cpu_field64_batch_cnt(buff64, snmp4_ipstats_list, cnt,
+				       net->mib.ip_statistics,
+				       offsetof(struct ipstats_mib, syncp));
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, " %llu", buff64[i]);
 
 	return 0;
@@ -415,20 +411,23 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 
 static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 {
+	const int udp_cnt = ARRAY_SIZE(snmp4_udp_list);
+	const int tcp_cnt = ARRAY_SIZE(snmp4_tcp_list);
 	unsigned long buff[TCPUDP_MIB_MAX];
 	struct net *net = seq->private;
 	int i;
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, tcp_cnt * sizeof(unsigned long));
 
 	seq_puts(seq, "\nTcp:");
-	for (i = 0; snmp4_tcp_list[i].name; i++)
+	for (i = 0; i < tcp_cnt; i++)
 		seq_printf(seq, " %s", snmp4_tcp_list[i].name);
 
 	seq_puts(seq, "\nTcp:");
-	snmp_get_cpu_field_batch(buff, snmp4_tcp_list,
-				 net->mib.tcp_statistics);
-	for (i = 0; snmp4_tcp_list[i].name; i++) {
+	snmp_get_cpu_field_batch_cnt(buff, snmp4_tcp_list,
+				     tcp_cnt,
+				     net->mib.tcp_statistics);
+	for (i = 0; i < tcp_cnt; i++) {
 		/* MaxConn field is signed, RFC 2012 */
 		if (snmp4_tcp_list[i].entry == TCP_MIB_MAXCONN)
 			seq_printf(seq, " %ld", buff[i]);
@@ -436,27 +435,29 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 			seq_printf(seq, " %lu", buff[i]);
 	}
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, udp_cnt * sizeof(unsigned long));
 
-	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
-				 net->mib.udp_statistics);
+	snmp_get_cpu_field_batch_cnt(buff, snmp4_udp_list,
+				     udp_cnt,
+				     net->mib.udp_statistics);
 	seq_puts(seq, "\nUdp:");
-	for (i = 0; snmp4_udp_list[i].name; i++)
+	for (i = 0; i < udp_cnt; i++)
 		seq_printf(seq, " %s", snmp4_udp_list[i].name);
 	seq_puts(seq, "\nUdp:");
-	for (i = 0; snmp4_udp_list[i].name; i++)
+	for (i = 0; i < udp_cnt; i++)
 		seq_printf(seq, " %lu", buff[i]);
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, udp_cnt * sizeof(unsigned long));
 
 	/* the UDP and UDP-Lite MIBs are the same */
 	seq_puts(seq, "\nUdpLite:");
-	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
-				 net->mib.udplite_statistics);
-	for (i = 0; snmp4_udp_list[i].name; i++)
+	snmp_get_cpu_field_batch_cnt(buff, snmp4_udp_list,
+				     udp_cnt,
+				     net->mib.udplite_statistics);
+	for (i = 0; i < udp_cnt; i++)
 		seq_printf(seq, " %s", snmp4_udp_list[i].name);
 	seq_puts(seq, "\nUdpLite:");
-	for (i = 0; snmp4_udp_list[i].name; i++)
+	for (i = 0; i < udp_cnt; i++)
 		seq_printf(seq, " %lu", buff[i]);
 
 	seq_putc(seq, '\n');
@@ -480,8 +481,8 @@ static int snmp_seq_show(struct seq_file *seq, void *v)
  */
 static int netstat_seq_show(struct seq_file *seq, void *v)
 {
-	const int ip_cnt = ARRAY_SIZE(snmp4_ipextstats_list) - 1;
-	const int tcp_cnt = ARRAY_SIZE(snmp4_net_list) - 1;
+	const int ip_cnt = ARRAY_SIZE(snmp4_ipextstats_list);
+	const int tcp_cnt = ARRAY_SIZE(snmp4_net_list);
 	struct net *net = seq->private;
 	unsigned long *buff;
 	int i;
@@ -494,8 +495,8 @@ static int netstat_seq_show(struct seq_file *seq, void *v)
 	buff = kzalloc(max(tcp_cnt * sizeof(long), ip_cnt * sizeof(u64)),
 		       GFP_KERNEL);
 	if (buff) {
-		snmp_get_cpu_field_batch(buff, snmp4_net_list,
-					 net->mib.net_statistics);
+		snmp_get_cpu_field_batch_cnt(buff, snmp4_net_list, tcp_cnt,
+					     net->mib.net_statistics);
 		for (i = 0; i < tcp_cnt; i++)
 			seq_printf(seq, " %lu", buff[i]);
 	} else {
@@ -513,7 +514,7 @@ static int netstat_seq_show(struct seq_file *seq, void *v)
 		u64 *buff64 = (u64 *)buff;
 
 		memset(buff64, 0, ip_cnt * sizeof(u64));
-		snmp_get_cpu_field64_batch(buff64, snmp4_ipextstats_list,
+		snmp_get_cpu_field64_batch_cnt(buff64, snmp4_ipextstats_list, ip_cnt,
 					   net->mib.ip_statistics,
 					   offsetof(struct ipstats_mib, syncp));
 		for (i = 0; i < ip_cnt; i++)
-- 
2.51.0.355.g5224444f11-goog


