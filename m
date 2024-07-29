Return-Path: <netdev+bounces-113576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9372593F1F5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB83B247BA
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704913FD84;
	Mon, 29 Jul 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Mp3vupkC"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA9613F42F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247009; cv=none; b=Ix0IZQBVInLBjdfsJKwjlhSHMV9kDd0xXVOuD/Tz8lZ7CGNtoxF/5cFoNX0PR47csyo1IBM1inbz6BHyg6oxpq7OPyd1AQGQY3BJIbwDHlyGd/76VopjyuO+EhpvEQWH5CLv6Hl9s9AEaRfRsfeZQXRl4pm3roY0uXkC66JqSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247009; c=relaxed/simple;
	bh=cp58baruv6kI99ttqSs0vwhfaJOPdiPkpMzJLLea2Xo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ni3eAyUKFC9CuXxmKxlVnKPEinARVUp1ARTLQyMvSmBSYJTVudyeTNjGI0C0mDRNai2twKLcG4m1HGswCXEe7MZp5opSSdbn3nZxgAVwPP6Uxjm6QPlM4LLMszlLvdqh3qaYwjQmjzaCpqA34J82f+TetMGmSe9eEQPG/zThyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Mp3vupkC; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=XASwgVM5L7mw96K2bE
	ahcEwN/Iy/NxjeOfPHGINvGDA=; b=Mp3vupkC2V/UlLEsBlf1a7iFJxoBIW7n3l
	VKVJBfBcBJZSaGYIQBRTrOfPwydzMmM8+IfoFzgP24WVeoPMFct+qhW/FygK14CW
	r/jBoAs3NTrJfl3IYIBhThIzQorAOIOhcTmSFbablv0yZsDAh0YmkEetmEf7NBtn
	m5AC1LmnM=
Received: from localhost.localdomain (unknown [111.48.58.12])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3XyktZ6dmPojCAw--.39738S2;
	Mon, 29 Jul 2024 17:55:58 +0800 (CST)
From: xiaolinkui@126.com
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
Date: Mon, 29 Jul 2024 17:55:54 +0800
Message-Id: <20240729095554.28296-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3XyktZ6dmPojCAw--.39738S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy5Jr1UJr1UZw4fKF1rJFb_yoWrZrWDpF
	yxKryIyFWDJF4UGFn7Zanrur4Sga18GF17Cw1I9r4Sywsrtry8tF4vkr1a9F17ArZ7tFyI
	gFZrtFy3Aws8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbF4iUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiGBIr1mVLczNcZQAAsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
in connect()") allocates even ports for connect() first while leaving
odd ports for bind() and this works well in busy servers.

But this strategy causes severe performance degradation in busy clients.
when a client has used more than half of the local ports setted in
proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
to a server again, the connect time increases rapidly since it will
traverse all the even ports though they are exhausted.

So this path provides another strategy by introducing a system option:
local_port_allocation. If it is a busy client, users should set it to 1
to use sequential allocation while it should be set to 0 in other
situations. Its default value is 0.

In commit 207184853dbd ("tcp/dccp: change source port selection at
connect() time"), tell users that they can access all odd and even ports
by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
socket application. When even numbered ports are not sufficient, use the
sysctl parameter to achieve the same effect:
	sysctl -w net.ipv4.local_port_allocation=1

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 include/net/tcp.h          |  1 +
 net/ipv4/inet_hashtables.c | 12 ++++++++----
 net/ipv4/sysctl_net_ipv4.c |  8 ++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..99969b8e5183 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -269,6 +269,7 @@ DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 
 extern struct percpu_counter tcp_sockets_allocated;
 extern unsigned long tcp_memory_pressure;
+extern bool sysctl_local_port_allocation;
 
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 48d0d494185b..e572f8b21b95 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1020,11 +1020,15 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
-	step = local_ports ? 1 : 2;
+	/* local_port_allocation 0 means even and odd port allocation strategy
+	 * will be applied, so step is 2; otherwise sequential allocation will
+	 * be used and step is 1. Default value is 0.
+	 */
+	step = sysctl_local_port_allocation ? 1 : 2;
 
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
-	if (!local_ports && remaining > 1)
+	if (!sysctl_local_port_allocation && remaining > 1)
 		remaining &= ~1U;
 
 	get_random_sleepable_once(table_perturb,
@@ -1037,7 +1041,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	/* In first pass we try ports of @low parity.
 	 * inet_csk_get_port() does the opposite choice.
 	 */
-	if (!local_ports)
+	if (!sysctl_local_port_allocation)
 		offset &= ~1U;
 other_parity_scan:
 	port = low + offset;
@@ -1081,7 +1085,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		cond_resched();
 	}
 
-	if (!local_ports) {
+	if (!sysctl_local_port_allocation) {
 		offset++;
 		if ((offset & 1) && remaining > 1)
 			goto other_parity_scan;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 9140d20eb2d4..1f6bf3a73516 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -45,6 +45,7 @@ static unsigned int tcp_child_ehash_entries_max = 16 * 1024 * 1024;
 static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
+bool sysctl_local_port_allocation;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -632,6 +633,13 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
+	{
+		.procname	= "local_port_allocation",
+		.data		= &sysctl_local_port_allocation,
+		.maxlen		= sizeof(sysctl_local_port_allocation),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
 };
 
 static struct ctl_table ipv4_net_table[] = {
-- 
2.17.1


