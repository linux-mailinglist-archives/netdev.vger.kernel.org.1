Return-Path: <netdev+bounces-298984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YNOdGdOELWqQhAQAu9opvQ
	(envelope-from <netdev+bounces-298984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5667F10C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wB6dZb11;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298984-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E2A3022685
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE2E1624C0;
	Sat, 13 Jun 2026 16:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395A30D41F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367928; cv=none; b=qcZauOO5JS43lN0Duk5/sNyuZn9hUEmsowWs3HLuyaFMjihgF84nLgR42rDPGiji1TqT2iiRIvpPCxh5bwsR7dqFtyIoHS/Y2uoJVTAYgIoTIVi05wZO5WzmGeWDA4h8Alm/xzP00Ul15Fa0W0oJD4NHIWsD753VCqLD9WV2Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367928; c=relaxed/simple;
	bh=Tgz5fbE2F6BnrKPj3NravBmADjbAGqgeaiswNj+n42M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs9+3o6MW3UwF5ix3vK+ykt85bqgPTP63kutb7iQSizxGDcffMQjFf7H6NVigaDc81xKEuApM6cIQ5fKDA06/wFL/00kojEsWdKVCBE30NL9KzFV3OlW/QQzBbMd9LAGxtKKEE6hywoMCihssskHNGOBkLj0LtD8FrYh0a5NrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wB6dZb11; arc=none smtp.client-ip=91.218.175.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781367924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEq9q/jnE/hhTQbdBCDPVl5f7XKJflv20xFeGiECkR8=;
	b=wB6dZb11onUfE5CbpWiuuTENg6gLRBjGR9qbtHQnN9+ooSJWpO6sETM7nzLgMTKdc/GO8L
	MeVZNzfyjm6oZLJpN4KvYTFiM0lDYNo+WKYssAPgKZytPo/kbs4NePf8JueA7ObEsnZk1Y
	95gvVjyOEhLk093WNd1ndDfG7pFFhLQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper
Date: Sun, 14 Jun 2026 00:24:43 +0800
Message-ID: <20260613162443.60515-3-leon.hwang@linux.dev>
In-Reply-To: <20260613162443.60515-1-leon.hwang@linux.dev>
References: <20260613162443.60515-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:leon.hwang@linux.dev,m:ihor.solodrai@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-patches-bot@fb.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A5667F10C

Verify the fix by:

1. Attach cgroup sockops prog.
2. Build a tcp connection using ipv4 addr in ipv6 socket.
3. Verify the return value of bpf_setsockopt() helper.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/setget_sockopt.c | 78 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 23 ++++++
 2 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 77fe1bfb7504..4e91d9b615ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -199,6 +199,83 @@ static void test_nonstandard_opt(int family)
 	bpf_link__destroy(getsockopt_link);
 }
 
+static int connect_to_v4mapped_v6_fd(int server_fd)
+{
+	struct sockaddr_storage addr;
+	struct sockaddr_in *addr4 = (void *)&addr;
+	socklen_t addrlen = sizeof(addr);
+	struct sockaddr_in6 addr6 = {};
+	int fd = -1, v6only = 0, err;
+
+	err = getsockname(server_fd, (struct sockaddr *)&addr, &addrlen);
+	if (!ASSERT_OK(err, "getsockname"))
+		return -1;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		return -1;
+
+	err = settimeo(fd, 0);
+	if (!ASSERT_OK(err, "settimeo"))
+		goto err_out;
+
+	err = setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only, sizeof(v6only));
+	if (!ASSERT_OK(err, "clear_v6only"))
+		goto err_out;
+
+	addr6.sin6_family = AF_INET6;
+	addr6.sin6_port = addr4->sin_port;
+	addr6.sin6_addr.s6_addr[10] = 0xff;
+	addr6.sin6_addr.s6_addr[11] = 0xff;
+	memcpy(&addr6.sin6_addr.s6_addr[12], &addr4->sin_addr, sizeof(addr4->sin_addr));
+
+	err = connect(fd, (struct sockaddr *)&addr6, sizeof(addr6));
+	if (!ASSERT_OK(err, "connect"))
+		goto err_out;
+
+	return fd;
+
+err_out:
+	close(fd);
+	return -1;
+}
+
+static void test_v4mapped_v6_ip_tos(void)
+{
+	struct setget_sockopt__bss *bss = skel->bss;
+	int sfd = -1, fd = -1, got = 0, exp = 0x1c;
+	socklen_t optlen;
+
+	memset(bss, 0, sizeof(*bss));
+	bss->v4mapped_v6_ip_tos_enable = 1;
+	bss->v4mapped_v6_ip_tos_ret = -1;
+	bss->v4mapped_v6_ip_tos_val = exp;
+
+	sfd = start_server(AF_INET, SOCK_STREAM, addr4_str, 0, 0);
+	if (!ASSERT_GE(sfd, 0, "start_server"))
+		goto err_out;
+
+	fd = connect_to_v4mapped_v6_fd(sfd);
+	if (!ASSERT_GE(fd, 0, "connect_to_v4mapped_v6_fd"))
+		goto err_out;
+
+	ASSERT_GT(bss->v4mapped_v6_ip_tos_cnt, 0, "v4mapped_v6_ip_tos_cnt");
+	ASSERT_EQ(bss->v4mapped_v6_ip_tos_ret, 0, "v4mapped_v6_ip_tos_ret");
+
+	optlen = sizeof(got);
+	if (!ASSERT_OK(getsockopt(fd, SOL_IP, IP_TOS, &got, &optlen), "getsockopt_ip_tos"))
+		goto err_out;
+
+	ASSERT_EQ(got, exp, "ip_tos");
+
+err_out:
+	bss->v4mapped_v6_ip_tos_enable = 0;
+	if (fd >= 0)
+		close(fd);
+	if (sfd >= 0)
+		close(sfd);
+}
+
 void test_setget_sockopt(void)
 {
 	cg_fd = test__join_cgroup(CG_NAME);
@@ -238,6 +315,7 @@ void test_setget_sockopt(void)
 	test_ktls(AF_INET);
 	test_nonstandard_opt(AF_INET);
 	test_nonstandard_opt(AF_INET6);
+	test_v4mapped_v6_ip_tos();
 
 done:
 	setget_sockopt__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index d330b1511979..636a7cd8e2fa 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -387,6 +387,24 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	return 1;
 }
 
+int v4mapped_v6_ip_tos_enable;
+int v4mapped_v6_ip_tos_ret;
+int v4mapped_v6_ip_tos_cnt;
+int v4mapped_v6_ip_tos_val;
+
+static void test_v4mapped_v6_ip_tos(struct bpf_sock_ops *skops)
+{
+	int tos = v4mapped_v6_ip_tos_val;
+
+	if (!v4mapped_v6_ip_tos_enable || skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return;
+	if (skops->family != AF_INET6)
+		return;
+
+	v4mapped_v6_ip_tos_cnt++;
+	v4mapped_v6_ip_tos_ret = bpf_setsockopt(skops, IPPROTO_IP, IP_TOS, &tos, sizeof(tos));
+}
+
 SEC("sockops")
 int skops_sockopt(struct bpf_sock_ops *skops)
 {
@@ -401,6 +419,11 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 	if (!sk)
 		return 1;
 
+	if (v4mapped_v6_ip_tos_enable) {
+		test_v4mapped_v6_ip_tos(skops);
+		return 1;
+	}
+
 	switch (skops->op) {
 	case BPF_SOCK_OPS_TCP_LISTEN_CB:
 		nr_listen += !(bpf_test_sockopt(skops, sk) ||
-- 
2.54.0


