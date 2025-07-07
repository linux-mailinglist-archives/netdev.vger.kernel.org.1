Return-Path: <netdev+bounces-204548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E057FAFB1DE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D6D1894EB9
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785113D891;
	Mon,  7 Jul 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="H7tCSo09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B927453;
	Mon,  7 Jul 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886031; cv=none; b=mzmEA/hFIa6X9AO5Dj89HMOkZO1VQu5OHMnuCFSif6O9xeFTbX2TSydBtT8Ub+NI9n+B7p5/aN31fgPyK+vLqSRy8+8+PwhzEbksoPvFr/dqhh1RS/fFNqT9yv7pBOmfdcMC/8A+fPC5M7lx7L5fZ3fth+krhkPMOdoFRQAwA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886031; c=relaxed/simple;
	bh=DpwsoiP9xCWvlAw9lKe9byGL9drudqXAld/yaXvXjd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6QXU2SaOrc1VlV0KuQ5SDr6L8stOxalqQ0HKujtGd4vBVLdzvKFsSj//OU3y9hl3W/6Jkj+GBPt+XxZg3ylUcj0qKlwiWM0hvs2d/9N4h5HKBE3etWZEusWZpyZpvn1c2aP6di6UWjKBI+fFWOBeLQmyNr728Tqs2qWJnDHmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=H7tCSo09; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1751885716; x=1752490516; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=L1aE7HR52wb++vRxIo7IM/5JmK/xbvuv0ndHj11l35U=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=H7tCSo09eoDgrMwGwPdrPEqzmbZVSxYu2JPFFpJmqpfkNxQh0gk12hJk79vXvnpMJ4791BKBcL8ucOunrspchPiBbj4a5GnY3498zetjHTxLtrySTDhQ4ahPxiG2G0pgjg1OoK1yVZ86crrC1YaDoDGKlGLFwUkf5tM4VbxfoP8=
Received: from osgiliath.superhosting.cz ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507071255138637;
        Mon, 07 Jul 2025 12:55:13 +0200
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Christian Hopps <chopps@labn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: [PATCH net-next] tcp: account for memory pressure signaled by cgroup
Date: Mon,  7 Jul 2025 12:52:05 +0200
Message-ID: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A006368.686BA7B0.0044,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Currently, we have two memory pressure counters for TCP sockets [1],
which we manipulate only when the memory pressure is signalled through
the proto struct [2].

However, the memory pressure can also be signaled through the cgroup
memory subsystem, which we do not reflect in the netstat counters.

This patch adds a new counter to account for memory pressure signaled by
the memory cgroup.

Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
This patch is a result of our long-standing debug sessions, where it
all started as "networking is slow". TLDR; our cgroup memory controller
was "pressuring" our socket communication (eventhough we had enough
free memory and all configurables were set to unlimited), which resulted
in very slow networking speeds (1.5 Mbps instead of 1 Gbps), and we
needed to use the bpftrace to debug this, but if it were in the netstat
counters, we would notice this much earlier.

 Documentation/networking/net_cachelines/snmp.rst |  1 +
 include/net/tcp.h                                | 14 ++++++++------
 include/uapi/linux/snmp.h                        |  1 +
 net/ipv4/proc.c                                  |  1 +
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index bd44b3eebbef..ed17ff84e39c 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -76,6 +76,7 @@ unsigned_long  LINUX_MIB_TCPABORTONLINGER
 unsigned_long  LINUX_MIB_TCPABORTFAILED
 unsigned_long  LINUX_MIB_TCPMEMORYPRESSURES
 unsigned_long  LINUX_MIB_TCPMEMORYPRESSURESCHRONO
+unsigned_long  LINUX_MIB_TCPCGROUPSOCKETPRESSURE
 unsigned_long  LINUX_MIB_TCPSACKDISCARD
 unsigned_long  LINUX_MIB_TCPDSACKIGNOREDOLD
 unsigned_long  LINUX_MIB_TCPDSACKIGNOREDNOUNDO
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 761c4a0ad386..aae3efe24282 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -267,6 +267,11 @@ extern long sysctl_tcp_mem[3];
 #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
 #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in RACK */
 
+#define TCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.tcp_statistics, field)
+#define __TCP_INC_STATS(net, field)	__SNMP_INC_STATS((net)->mib.tcp_statistics, field)
+#define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
+#define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
+
 extern atomic_long_t tcp_memory_allocated;
 DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 
@@ -277,8 +282,10 @@ extern unsigned long tcp_memory_pressure;
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_under_socket_pressure(sk->sk_memcg)) {
+		TCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPCGROUPSOCKETPRESSURE);
 		return true;
+	}
 
 	return READ_ONCE(tcp_memory_pressure);
 }
@@ -316,11 +323,6 @@ bool tcp_check_oom(const struct sock *sk, int shift);
 
 extern struct proto tcp_prot;
 
-#define TCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.tcp_statistics, field)
-#define __TCP_INC_STATS(net, field)	__SNMP_INC_STATS((net)->mib.tcp_statistics, field)
-#define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
-#define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
-
 void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 1d234d7e1892..9e8d1a5e56a9 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -231,6 +231,7 @@ enum
 	LINUX_MIB_TCPABORTFAILED,		/* TCPAbortFailed */
 	LINUX_MIB_TCPMEMORYPRESSURES,		/* TCPMemoryPressures */
 	LINUX_MIB_TCPMEMORYPRESSURESCHRONO,	/* TCPMemoryPressuresChrono */
+	LINUX_MIB_TCPCGROUPSOCKETPRESSURE,      /* TCPCgroupSocketPressure */
 	LINUX_MIB_TCPSACKDISCARD,		/* TCPSACKDiscard */
 	LINUX_MIB_TCPDSACKIGNOREDOLD,		/* TCPSACKIgnoredOld */
 	LINUX_MIB_TCPDSACKIGNOREDNOUNDO,	/* TCPSACKIgnoredNoUndo */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index ea2f01584379..0bcec9a51fb0 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -235,6 +235,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAbortFailed", LINUX_MIB_TCPABORTFAILED),
 	SNMP_MIB_ITEM("TCPMemoryPressures", LINUX_MIB_TCPMEMORYPRESSURES),
 	SNMP_MIB_ITEM("TCPMemoryPressuresChrono", LINUX_MIB_TCPMEMORYPRESSURESCHRONO),
+	SNMP_MIB_ITEM("TCPCgroupSocketPressure", LINUX_MIB_TCPCGROUPSOCKETPRESSURE),
 	SNMP_MIB_ITEM("TCPSACKDiscard", LINUX_MIB_TCPSACKDISCARD),
 	SNMP_MIB_ITEM("TCPDSACKIgnoredOld", LINUX_MIB_TCPDSACKIGNOREDOLD),
 	SNMP_MIB_ITEM("TCPDSACKIgnoredNoUndo", LINUX_MIB_TCPDSACKIGNOREDNOUNDO),

base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
-- 
2.39.5


