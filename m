Return-Path: <netdev+bounces-289046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCjwM6oJC2o0/gQAu9opvQ
	(envelope-from <netdev+bounces-289046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB556CECF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B00B8301C6AB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDF641B35B;
	Mon, 18 May 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrQSrxkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490E40FDBC
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107345; cv=none; b=a5FZYALFmXfxAvfXMjMUPDZpd1NCo70kysa49DY1+jyO/fQVLegEbvDS69L4uJfZdsiDMQ0hC2BRBgOmv9qkSo3E03cQdFdl5kdRG5uO4JgqOJDB3am2fx+CGkyOMZivN58rG0RYILj18FrL8jj4SPzTWvJRQ4Mu44AxoArQ6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107345; c=relaxed/simple;
	bh=1GrCwyW2ffu12CX7pHNi0bxbEKk5h4GQncPUwrZxDpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJyt3prV++a1lQHxKJirRdEVsE1wWuvG9jbKFM2Yy6POEPGX4MHhfJ+vDHa7lTAvirM3EdqT4fYJTrarDA4ipf0feomuaFv/wDYVIWf6ApE0tAaQ+KFem3h023I7Vw/VTrFNCsQjL8/3LSPO6Vke4fsvIDEtX+V/ZPbDSQty4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrQSrxkf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so33371235e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107340; x=1779712140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X4Zfs8WDLTkvA+vva6cJd2ZFvk0kYjxlxoLsHGYvrM=;
        b=lrQSrxkfu23kxKPUweaSrADik1UGlJZkErqQHYg7hPXZCpB9xLxyvlufVX4n8zGrqG
         wjG/Fm+DM/gS0DUgHp3pREVIt8RVK2Ip2XbuyEtTEqyd6dC+OOTJ1Y1s0goHiEIFur+J
         AfLKojO20dJxwRH8x5DjdzSRmPDCJPiZX7lEsiSVRgDmaVcI8IKh+k//wlDuwEa7XXpm
         LVN28/m++/9iA1aZ3IqX6lz4Ac05EaBLifqAieTWUwcxwJkMd2SHz9rrXSQihp7lVI0e
         PENbREy7yOu45niAialAN5TMF5RTaXVsaV752syocQCifUCj/9lIlVCZ7xzvM+waV9ri
         e48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107340; x=1779712140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8X4Zfs8WDLTkvA+vva6cJd2ZFvk0kYjxlxoLsHGYvrM=;
        b=BO61Uc30TehhIWFRf8aION0o+dLPs/0rJuI5cNOzebgVRGxngdT8wXzbrVi6I5Rf7g
         NCUbe6z9vpu7Fj4ntJcOFwLU5fSWNTIRl/Yj+1PbrZBx7IVS8u/8HIww7UjS0I5mBcmJ
         XeHAbCVTVhUjFH9hA3tt8jA2S3HJ3bThVaH9ruEspfsF4vaj9DdEWHYmB6vrCOyKtwND
         F5zYIWQ8rb2xifH7OI+f+ellSDekL5oTC2+8w6zOpeIpXm1uIbx94azWWkkI9PDFb61P
         42VFktUP0YlasCjbKqE99Mw34CePYemx5jPkS3E43Qn1w9SOyhebpOgeeGST5YSivY2t
         DKRg==
X-Forwarded-Encrypted: i=1; AFNElJ9f/lSl3MBOU7BXmdr8NR84Yvml0s6FUHaUDxNh7nsiqsRB9Xn/RZljN8Ui3fPGro9iXiBIhD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFCfliGe4YOJGuKWtd1dtHZhRXkS8ikmNYNXz6YApKp4L+PMs
	LwRacpxXJc/gDU8Au0Iyld0OZySmv22IF47CvZRKP7djd/84GbBjXbvIsuOKKDRN5D8=
X-Gm-Gg: Acq92OERZKT6U6HlrNqGWVaqBiVKqrzTY/FgSe+kUv6F5SrdzlAqc4gru0MNSZ/nPpB
	sc/7kaLj3nTf/z9kqdF0Mhj+XeBgXHRAJo58RHrP+XU0+ZN0AeOJ2ICH0GbzNkoyDni9Us0WE6A
	DEN7QrPT0KH1oYkE3VxCFsDcVcSQTJa1UEKpxmdDqAasOh7RSarKmaLyaKy04emj1djNL8jDn+D
	KS1oW5SULqNAshO7MMlpUcVjK3BbsBRneJK+g+h0Af6Xf6WmzwsQuat1e4zLnGeds0e6vhcBvbg
	M+Vp6TX6lDC1XOqEoncKhj1QgQIZlaBlQaYLqA3CbuosU6vCqWh7yrbFMoMtESrVplPpHA1p1uf
	V/L/LJgdrRHCLDpq3oROnh4XZt69WpWfdAqcBd6c4bkD5jvg1tpyqo6Qu8WfslbyTzKhTBjfdwa
	f19j+zBGZik5Ec/3i40HOMF1QgQW2+UiBX3Iy7eQ==
X-Received: by 2002:a05:600c:c10e:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48fe63265ddmr172830605e9.21.1779107340422;
        Mon, 18 May 2026 05:29:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm104304315e9.0.2026.05.18.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:29:00 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v6 5/6] selftests/bpf: add bpf_icmp_send kfunc IPv6 tests
Date: Mon, 18 May 2026 12:28:41 +0000
Message-Id: <20260518122842.218522-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518122842.218522-1-mahe.tardy@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2AB556CECF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This test extends the existing tests with IPv6 support.

Note that we need to set IPV6_RECVERR on the socket for IPv6 in
connect_to_fd_nonblock otherwise the error will be ignored even if we
are in the middle of the TCP handshake. See in
net/ipv6/datagram.c:ipv6_icmp_error for more details.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 76 +++++++++++++------
 tools/testing/selftests/bpf/progs/icmp_send.c | 48 +++++++++---
 2 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index 4f0aed8152d3..d0ac0502f6df 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -8,15 +8,17 @@
 #define TIMEOUT_MS 1000

 #define ICMP_DEST_UNREACH 3
+#define ICMPV6_DEST_UNREACH 1

 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
+#define ICMPV6_REJECT_ROUTE 6

 static int connect_to_fd_nonblock(int server_fd)
 {
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
-	int fd, err;
+	int fd, err, on = 1;

 	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
 		return -1;
@@ -25,6 +27,12 @@ static int connect_to_fd_nonblock(int server_fd)
 	if (fd < 0)
 		return -1;

+	if (addr.ss_family == AF_INET6 &&
+	    setsockopt(fd, IPPROTO_IPV6, IPV6_RECVERR, &on, sizeof(on)) < 0) {
+		close(fd);
+		return -1;
+	}
+
 	err = connect(fd, (struct sockaddr *)&addr, len);
 	if (err < 0 && errno != EINPROGRESS) {
 		close(fd);
@@ -34,7 +42,7 @@ static int connect_to_fd_nonblock(int server_fd)
 	return fd;
 }

-static void read_icmp_errqueue(int sockfd, int expected_code)
+static void read_icmp_errqueue(int sockfd, int expected_code, int af)
 {
 	ssize_t n;
 	struct sock_extended_err *sock_err;
@@ -44,6 +52,12 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 		.msg_control = ctrl_buf,
 		.msg_controllen = sizeof(ctrl_buf),
 	};
+	int expected_level = (af == AF_INET) ? IPPROTO_IP : IPPROTO_IPV6;
+	int expected_type = (af == AF_INET) ? IP_RECVERR : IPV6_RECVERR;
+	int expected_origin = (af == AF_INET) ? SO_EE_ORIGIN_ICMP :
+						SO_EE_ORIGIN_ICMP6;
+	int expected_ee_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						 ICMPV6_DEST_UNREACH;
 	struct pollfd pfd = {
 		.fd = sockfd,
 		.events = POLLERR,
@@ -61,16 +75,16 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 		return;

 	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
-		if (cm->cmsg_level != IPPROTO_IP ||
-		    cm->cmsg_type != IP_RECVERR)
+		if (cm->cmsg_level != expected_level ||
+		    cm->cmsg_type != expected_type)
 			continue;

 		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);

-		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
-			       "sock_err_origin_icmp"))
+		if (!ASSERT_EQ(sock_err->ee_origin, expected_origin,
+			       "sock_err_origin"))
 			return;
-		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
+		if (!ASSERT_EQ(sock_err->ee_type, expected_ee_type,
 			       "sock_err_type_dest_unreach"))
 			return;
 		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
@@ -81,14 +95,13 @@ static void read_icmp_errqueue(int sockfd, int expected_code)
 }

 static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
-					    int code)
+					    int code, int af, const char *ip)
 {
 	int srv_fd = -1, client_fd = -1;
 	struct sockaddr_in addr;
 	socklen_t len = sizeof(addr);

-	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
-			      TIMEOUT_MS);
+	srv_fd = start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		return;

@@ -97,6 +110,8 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
 		return;
 	}
 	skel->bss->server_port = ntohs(addr.sin_port);
+	skel->bss->unreach_type = (af == AF_INET) ? ICMP_DEST_UNREACH :
+						    ICMPV6_DEST_UNREACH;
 	skel->bss->unreach_code = code;

 	client_fd = connect_to_fd_nonblock(srv_fd);
@@ -106,13 +121,33 @@ static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
 	}

 	/* Skip reading ICMP error queue if code is invalid */
-	if (code >= 0 && code <= NR_ICMP_UNREACH)
-		read_icmp_errqueue(client_fd, code);
+	if (code >= 0 && ((af == AF_INET && code <= NR_ICMP_UNREACH) ||
+			   (af == AF_INET6 && code <= ICMPV6_REJECT_ROUTE)))
+		read_icmp_errqueue(client_fd, code, af);

 	close(client_fd);
 	close(srv_fd);
 }

+static void run_icmp_test(struct icmp_send *skel, int af,
+			  const char *ip, int max_code)
+{
+	for (int code = 0; code <= max_code; code++) {
+		/* The TCP stack reacts differently when asking for
+		 * fragmentation, let's ignore it for now.
+		 */
+		if (af == AF_INET && code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code, af, ip);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test an invalid code */
+	trigger_prog_read_icmp_errqueue(skel, -1, af, ip);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+}
+
 void test_icmp_send_unreach(void)
 {
 	struct icmp_send *skel;
@@ -131,20 +166,11 @@ void test_icmp_send_unreach(void)
 	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
 		goto cleanup;

-	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
-		/* The TCP stack reacts differently when asking for
-		 * fragmentation, let's ignore it for now.
-		 */
-		if (code == ICMP_FRAG_NEEDED)
-			continue;
-
-		trigger_prog_read_icmp_errqueue(skel, code);
-		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
-	}
+	if (test__start_subtest("ipv4"))
+		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);

-	/* Test an invalid code */
-	trigger_prog_read_icmp_errqueue(skel, -1);
-	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+	if (test__start_subtest("ipv6"))
+		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

 cleanup:
 	icmp_send__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6d0be0a9afe1..6e1ba539eeb0 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -5,10 +5,11 @@

 /* 127.0.0.1 in host byte order */
 #define SERVER_IP 0x7F000001
-
-#define ICMP_DEST_UNREACH 3
+/* ::1 in host byte order (last 32-bit word) */
+#define SERVER_IP6_LO 0x00000001

 __u16 server_port = 0;
+int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

@@ -18,19 +19,48 @@ int egress(struct __sk_buff *skb)
 	void *data = (void *)(long)skb->data;
 	void *data_end = (void *)(long)skb->data_end;
 	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
 	struct tcphdr *tcph;
+	__u8 version;

-	iph = data;
-	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
-	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
+	if (data + 1 > data_end)
 		return SK_PASS;

-	tcph = (void *)iph + iph->ihl * 4;
-	if ((void *)(tcph + 1) > data_end ||
-	    tcph->dest != bpf_htons(server_port))
+	version = (*((__u8 *)data)) >> 4;
+
+	if (version == 4) {
+		iph = data;
+		if ((void *)(iph + 1) > data_end ||
+		    iph->protocol != IPPROTO_TCP ||
+		    iph->daddr != bpf_htonl(SERVER_IP))
+			return SK_PASS;
+
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+
+	} else if (version == 6) {
+		ip6h = data;
+		if ((void *)(ip6h + 1) > data_end ||
+		    ip6h->nexthdr != IPPROTO_TCP)
+			return SK_PASS;
+
+		if (ip6h->daddr.in6_u.u6_addr32[0] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[1] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[2] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[3] != bpf_htonl(SERVER_IP6_LO))
+			return SK_PASS;
+
+		tcph = (void *)(ip6h + 1);
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+	} else {
 		return SK_PASS;
+	}

-	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
+	kfunc_ret = bpf_icmp_send(skb, unreach_type, unreach_code);

 	return SK_DROP;
 }
--
2.34.1


