Return-Path: <netdev+bounces-277639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEVBBtqk2WnwrggAu9opvQ
	(envelope-from <netdev+bounces-277639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:33:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE623DDE0E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F883057C7A
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011BB274B43;
	Sat, 11 Apr 2026 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPvrQ48E"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0451DFDA1
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871172; cv=none; b=szc7D1n173jaho5o6Vfl2K+GscQumBz5NaJorwsc2XSLQTDjju/hS2kIONRKLrRBxHoTR32epg6Wn+yaNmMg+QkTBTt2kZWTiHxbPJe+69YczNfNd0eAccWz5UcXFXpjQwgJ0vAv2lDKzT1ljYThT8W/jtIegeXgJYhycOqFw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871172; c=relaxed/simple;
	bh=VO6BMkxq96+MVVztCDUAdoUouKK0RTwbTwrWVTmDayQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR4hyuYS+BgWqk6oICV8axSptn6JCQwOPV7BhX5Mk8uA49SkF15BRTCeWc+Tmhc5TSdY2u62otFHaEKgIn4LZSmrUElNuLaaKFs4bk7GkvoBUKkW4UMtoW2/ros6fW7rbpSCdTM26HjzRjtKCTz1iHw8XKEIGT7OfW3w/AaVMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPvrQ48E; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775871169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoJCAFaTxUEnMvDnlo8IAOnt4jK6ofxDJqaroElqR/U=;
	b=sPvrQ48EhC0ZhnKra1/msHQQJN8Wu7PXFcsjVNhruGof3v1V+ShwNzVOvODxToSg8zGQc8
	BEH8rdmGWV3uA0/wlCZMd2YuyWhWdJsToiZlrTEbtB10R53lqkWwtV8IabHGessLuYDvAg
	jNqu+zyBT7rOoNafQBt3YamfD7lI9RY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie statistics in tcp_custom_syncookie
Date: Sat, 11 Apr 2026 09:32:05 +0800
Message-ID: <20260411013211.225834-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-1-jiayuan.chen@linux.dev>
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-277639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: BEE623DDE0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add read_tcpext_snmp() helper to network_helpers which reads a
TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
BPF custom syncookie validation.

The delta is captured between start_server() and accept(), which
covers the full SYN/ACK/cookie-check path for one connection.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index b82f572641b7..3388dd5112b6 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -621,6 +621,28 @@ int get_socket_local_port(int sock_fd)
 	return -1;
 }
 
+int read_tcpext_snmp(const char *name, unsigned long *val)
+{
+	char cmd[128], buf[128];
+	int ret = 0;
+	FILE *f;
+
+	snprintf(cmd, sizeof(cmd),
+		 "nstat -az TcpExt%s | awk '/TcpExt/ {print $2}'", name);
+	f = popen(cmd, "r");
+	if (!f)
+		return -errno;
+
+	if (!fgets(buf, sizeof(buf), f)) {
+		ret = ferror(f) ? -errno : -ENODATA;
+		goto out;
+	}
+	*val = strtoul(buf, NULL, 10);
+out:
+	pclose(f);
+	return ret;
+}
+
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 {
 	struct ifreq ifr = {0};
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 79a010c88e11..c53cd781df6e 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -84,6 +84,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+int read_tcpext_snmp(const char *name, unsigned long *val);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..6adfb4b892f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -91,12 +91,21 @@ static void transfer_message(int sender, int receiver)
 
 static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
 {
+	unsigned long recv_before, recv_after;
+	unsigned long failed_before, failed_after;
 	int server, client, child;
 
 	server = start_server(test_case->family, test_case->type, test_case->addr, 0, 0);
 	if (!ASSERT_NEQ(server, -1, "start_server"))
 		return;
 
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_before),
+		       "read SyncookiesRecv before"))
+		goto close_server;
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_before),
+		       "read SyncookiesFailed before"))
+		goto close_server;
+
 	client = connect_to_fd(server, 0);
 	if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
 		goto close_server;
@@ -105,9 +114,20 @@ static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
 	if (!ASSERT_NEQ(child, -1, "accept"))
 		goto close_client;
 
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_after),
+		       "read SyncookiesRecv after"))
+		goto close_child;
+	if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_after),
+		       "read SyncookiesFailed after"))
+		goto close_child;
+
+	ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
+	ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delta");
+
 	transfer_message(client, child);
 	transfer_message(child, client);
 
+close_child:
 	close(child);
 close_client:
 	close(client);
-- 
2.43.0


