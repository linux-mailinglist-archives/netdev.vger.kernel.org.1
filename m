Return-Path: <netdev+bounces-143650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63FC9C37AD
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A4D1C21631
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06214B08E;
	Mon, 11 Nov 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pxqv4V/q"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459C145B16;
	Mon, 11 Nov 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731301070; cv=none; b=MITaAj+s6cGM9WOSA1S/LQ1bQQ5kNks0S0wJij7HeZ7+FOb+MHyksZbFWT6CBkatuQwURodGLPEUzTR7601/ry9Qyu+usfqaD6/ykdMvJ258jdMs8F+Ppfwre9vyDN1enR2TLEko4+bxO369tqTapOvBjHVlOS/9oqtd+RW4opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731301070; c=relaxed/simple;
	bh=sfTgdTJh1p7JRgOiYF2XlibB9miS7yTgFim2KFUF8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sb91EtKorZmqFNxTdx7CnUEMrjx/ZXa2DWifHuBCWl/9zN+KqPtxgQXhwBsXeYsRbOe2idjm9AbOAoS3iOyW3KLwezUMzxG/T5+hbbTeIs5nkZX09l1rarJxrtnR1dvJvHHC2SqlYF3JAJ3GHTKuOxI+QQ6VrSraNdFJOQx0o4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pxqv4V/q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SHVIa
	l6tBpBpXY3unYv6Gce9rTF7SHEzPbAB03hJXec=; b=pxqv4V/ql9w3wBNIw0JfB
	FfWDCs/6VtjqHeL0nNgeXSTOAOdabMlQIcOKXefjRnT3wwwU1lU+aiWR8DEIAJXC
	RSyZUf6E1gwS6IFPJbwQ8kS8yDzhHRvp9uTVJWJYfj4JFr63towidZ0Dht9EoWmR
	o2kNqbtk5eI8UvRM8kjPi0=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3uS59jjFnxgklBw--.36494S4;
	Mon, 11 Nov 2024 12:57:02 +0800 (CST)
From: David Wang <00107082@163.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] net/ipv4/proc: Avoid usage for seq_printf() when reading /proc/net/snmp
Date: Mon, 11 Nov 2024 12:56:23 +0800
Message-Id: <20241111045623.10229-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3uS59jjFnxgklBw--.36494S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr13Zr4xtw1UKw18Gr4fAFb_yoWfZr1kpa
	y3A34qgr1xJr1Utrsrta1vg3WrWF93AFy2g3ZrGa10y3W5ZrZ5Can3WrW2qF45GFyvqrW5
	XF4DWFy7G398tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELZ2sUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gWUqmcxiOtsiwAAs7

seq_printf() is costy, when reading /proc/net/snmp, profiling indicates
seq_printf() takes more than 50% samples of snmp_seq_show():
	snmp_seq_show(97.751% 158722/162373)
	    snmp_seq_show_tcp_udp.isra.0(40.017% 63515/158722)
		seq_printf(83.451% 53004/63515)
		seq_write(1.170% 743/63515)
		_find_next_bit(0.727% 462/63515)
		...
	    seq_printf(24.762% 39303/158722)
	    snmp_seq_show_ipstats.isra.0(21.487% 34104/158722)
		seq_printf(85.788% 29257/34104)
		_find_next_bit(0.331% 113/34104)
		seq_write(0.235% 80/34104)
		...
	    icmpmsg_put(7.235% 11483/158722)
		seq_printf(41.714% 4790/11483)
		seq_write(2.630% 302/11483)
		...
Time for a million rounds of stress reading /proc/net/snmp:
	real	0m24.323s
	user	0m0.293s
	sys	0m23.679s
On average, reading /proc/net/snmp takes 0.023ms.
With this patch, extra costs of seq_printf() is avoided, and a million
rounds of reading /proc/net/snmp now takes only ~15.853s:
	real	0m16.386s
	user	0m0.280s
	sys	0m15.853s
On average, one read takes 0.015ms, a ~40% improvement.

Signed-off-by: David Wang <00107082@163.com>
---
 net/ipv4/proc.c | 116 ++++++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 40053a02bae1..3a4586103b5e 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -315,13 +315,14 @@ static void icmpmsg_put_line(struct seq_file *seq, unsigned long *vals,
 
 	if (count) {
 		seq_puts(seq, "\nIcmpMsg:");
-		for (j = 0; j < count; ++j)
-			seq_printf(seq, " %sType%u",
-				type[j] & 0x100 ? "Out" : "In",
-				type[j] & 0xff);
+		for (j = 0; j < count; ++j) {
+			seq_putc(seq, ' ');
+			seq_puts(seq, type[j] & 0x100 ? "Out" : "In");
+			seq_put_decimal_ull(seq, "Type", type[j] & 0xff);
+		}
 		seq_puts(seq, "\nIcmpMsg:");
 		for (j = 0; j < count; ++j)
-			seq_printf(seq, " %lu", vals[j]);
+			seq_put_decimal_ull(seq, " ", vals[j]);
 	}
 }
 
@@ -358,26 +359,35 @@ static void icmp_put(struct seq_file *seq)
 	atomic_long_t *ptr = net->mib.icmpmsg_statistics->mibs;
 
 	seq_puts(seq, "\nIcmp: InMsgs InErrors InCsumErrors");
-	for (i = 0; icmpmibmap[i].name; i++)
-		seq_printf(seq, " In%s", icmpmibmap[i].name);
+	for (i = 0; icmpmibmap[i].name; i++) {
+		seq_puts(seq, " In");
+		seq_puts(seq, icmpmibmap[i].name);
+	}
 	seq_puts(seq, " OutMsgs OutErrors OutRateLimitGlobal OutRateLimitHost");
+	for (i = 0; icmpmibmap[i].name; i++) {
+		seq_puts(seq, " Out");
+		seq_puts(seq, icmpmibmap[i].name);
+	}
+	seq_puts(seq, "\nIcmp:");
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_INMSGS));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_INERRORS));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_CSUMERRORS));
 	for (i = 0; icmpmibmap[i].name; i++)
-		seq_printf(seq, " Out%s", icmpmibmap[i].name);
-	seq_printf(seq, "\nIcmp: %lu %lu %lu",
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_INMSGS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_INERRORS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_CSUMERRORS));
+		seq_put_decimal_ull(seq, " ", atomic_long_read(ptr + icmpmibmap[i].index));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTMSGS));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITGLOBAL));
+	seq_put_decimal_ull(seq, " ",
+			    snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITHOST));
 	for (i = 0; icmpmibmap[i].name; i++)
-		seq_printf(seq, " %lu",
-			   atomic_long_read(ptr + icmpmibmap[i].index));
-	seq_printf(seq, " %lu %lu %lu %lu",
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTMSGS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITGLOBAL),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITHOST));
-	for (i = 0; icmpmibmap[i].name; i++)
-		seq_printf(seq, " %lu",
-			   atomic_long_read(ptr + (icmpmibmap[i].index | 0x100)));
+		seq_put_decimal_ull(seq, " ",
+				    atomic_long_read(ptr + (icmpmibmap[i].index | 0x100)));
 }
 
 /*
@@ -392,8 +402,10 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 	memset(buff64, 0, IPSTATS_MIB_MAX * sizeof(u64));
 
 	seq_puts(seq, "Ip: Forwarding DefaultTTL");
-	for (i = 0; snmp4_ipstats_list[i].name; i++)
-		seq_printf(seq, " %s", snmp4_ipstats_list[i].name);
+	for (i = 0; snmp4_ipstats_list[i].name; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_ipstats_list[i].name);
+	}
 
 	seq_printf(seq, "\nIp: %d %d",
 		   IPV4_DEVCONF_ALL_RO(net, FORWARDING) ? 1 : 2,
@@ -404,7 +416,7 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 				   net->mib.ip_statistics,
 				   offsetof(struct ipstats_mib, syncp));
 	for (i = 0; snmp4_ipstats_list[i].name; i++)
-		seq_printf(seq, " %llu", buff64[i]);
+		seq_put_decimal_ull(seq, " ", buff64[i]);
 
 	return 0;
 }
@@ -418,8 +430,10 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
 
 	seq_puts(seq, "\nTcp:");
-	for (i = 0; snmp4_tcp_list[i].name; i++)
-		seq_printf(seq, " %s", snmp4_tcp_list[i].name);
+	for (i = 0; snmp4_tcp_list[i].name; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_tcp_list[i].name);
+	}
 
 	seq_puts(seq, "\nTcp:");
 	snmp_get_cpu_field_batch(buff, snmp4_tcp_list,
@@ -429,7 +443,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 		if (snmp4_tcp_list[i].entry == TCP_MIB_MAXCONN)
 			seq_printf(seq, " %ld", buff[i]);
 		else
-			seq_printf(seq, " %lu", buff[i]);
+			seq_put_decimal_ull(seq, " ", buff[i]);
 	}
 
 	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
@@ -437,11 +451,13 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
 				 net->mib.udp_statistics);
 	seq_puts(seq, "\nUdp:");
-	for (i = 0; snmp4_udp_list[i].name; i++)
-		seq_printf(seq, " %s", snmp4_udp_list[i].name);
+	for (i = 0; snmp4_udp_list[i].name; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_udp_list[i].name);
+	}
 	seq_puts(seq, "\nUdp:");
 	for (i = 0; snmp4_udp_list[i].name; i++)
-		seq_printf(seq, " %lu", buff[i]);
+		seq_put_decimal_ull(seq, " ", buff[i]);
 
 	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
 
@@ -449,11 +465,13 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nUdpLite:");
 	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
 				 net->mib.udplite_statistics);
-	for (i = 0; snmp4_udp_list[i].name; i++)
-		seq_printf(seq, " %s", snmp4_udp_list[i].name);
+	for (i = 0; snmp4_udp_list[i].name; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_udp_list[i].name);
+	}
 	seq_puts(seq, "\nUdpLite:");
 	for (i = 0; snmp4_udp_list[i].name; i++)
-		seq_printf(seq, " %lu", buff[i]);
+		seq_put_decimal_ull(seq, " ", buff[i]);
 
 	seq_putc(seq, '\n');
 	return 0;
@@ -483,8 +501,10 @@ static int netstat_seq_show(struct seq_file *seq, void *v)
 	int i;
 
 	seq_puts(seq, "TcpExt:");
-	for (i = 0; i < tcp_cnt; i++)
-		seq_printf(seq, " %s", snmp4_net_list[i].name);
+	for (i = 0; i < tcp_cnt; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_net_list[i].name);
+	}
 
 	seq_puts(seq, "\nTcpExt:");
 	buff = kzalloc(max(tcp_cnt * sizeof(long), ip_cnt * sizeof(u64)),
@@ -493,16 +513,18 @@ static int netstat_seq_show(struct seq_file *seq, void *v)
 		snmp_get_cpu_field_batch(buff, snmp4_net_list,
 					 net->mib.net_statistics);
 		for (i = 0; i < tcp_cnt; i++)
-			seq_printf(seq, " %lu", buff[i]);
+			seq_put_decimal_ull(seq, " ", buff[i]);
 	} else {
 		for (i = 0; i < tcp_cnt; i++)
-			seq_printf(seq, " %lu",
-				   snmp_fold_field(net->mib.net_statistics,
-						   snmp4_net_list[i].entry));
+			seq_put_decimal_ull(seq, " ",
+					    snmp_fold_field(net->mib.net_statistics,
+							    snmp4_net_list[i].entry));
 	}
 	seq_puts(seq, "\nIpExt:");
-	for (i = 0; i < ip_cnt; i++)
-		seq_printf(seq, " %s", snmp4_ipextstats_list[i].name);
+	for (i = 0; i < ip_cnt; i++) {
+		seq_putc(seq, ' ');
+		seq_puts(seq, snmp4_ipextstats_list[i].name);
+	}
 
 	seq_puts(seq, "\nIpExt:");
 	if (buff) {
@@ -513,13 +535,13 @@ static int netstat_seq_show(struct seq_file *seq, void *v)
 					   net->mib.ip_statistics,
 					   offsetof(struct ipstats_mib, syncp));
 		for (i = 0; i < ip_cnt; i++)
-			seq_printf(seq, " %llu", buff64[i]);
+			seq_put_decimal_ull(seq, " ", buff64[i]);
 	} else {
 		for (i = 0; i < ip_cnt; i++)
-			seq_printf(seq, " %llu",
-				   snmp_fold_field64(net->mib.ip_statistics,
-						     snmp4_ipextstats_list[i].entry,
-						     offsetof(struct ipstats_mib, syncp)));
+			seq_put_decimal_ull(seq, " ",
+					    snmp_fold_field64(net->mib.ip_statistics,
+							      snmp4_ipextstats_list[i].entry,
+							      offsetof(struct ipstats_mib, syncp)));
 	}
 	kfree(buff);
 	seq_putc(seq, '\n');
-- 
2.39.2


