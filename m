Return-Path: <netdev+bounces-306286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qWuRHPm4T2pDnQIAu9opvQ
	(envelope-from <netdev+bounces-306286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:06:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8139732A04
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xdaufiqd;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306286-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306286-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7091B30D082C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665438AC8D;
	Thu,  9 Jul 2026 14:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4D30E84A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608557; cv=none; b=tmVkSgaUPPza+v9xpM6inKe7ZQ8rNpL+/oXHtZ2HoULF2q4BNPyQZcYywH5kHMZ5XsfjThNmZk07x5e42u86AHvSuaFe4QHGDyqlH8yND2E1n/wycMkWJKu9ah4QMzt4TuVHDBUaIOWV5zS7KMxkokSr0ECgV/2kAx0kkjGZ1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608557; c=relaxed/simple;
	bh=9FQXYwGmt4FioywMikvgYSN1ECAwaMBHImy48XF5uQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMEvTgbBWDcgI7tw4WCvEv2+iJg+V3//Geh4hopsDallXfMJv7bR+q0CvppJE2/wBDQwGSd8DV0BVVQTwCNKhjT/AEMaQcdGA9ZyCbexUksfzclZa0Zl8qomnOR+Tg4RnI1Q600P6NeTY1TTjjrGaJAybNSDQAxyJnlbyF7kwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdaufiqd; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so17480075e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608554; x=1784213354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=Xdaufiqd5yO9Noz57mi3Kvigw0YoZQR5VBWRMmNeyhMJjAGRPrifVNGDdi00jcZHs6
         6z6PyYuagDA6a+YudD6UQ4hEVPMwJO1ZSzu8X1Q8y9gesJZhukqZzx6r/ehgKLUclPXK
         68hXeWoGY23AzvPBhw5UNUQPvPyZP6YY2FniHW1x6hYJOh3y61l63K68Vri0XFRWs/yf
         MRZFx2852CNaawoTQbpFOv171MpBYJUPKW9IkiFK3HvCsCx3y1mYOV/YgnoIKeSPUHXf
         fUDnyYAg8FUpZugx5NFrNFP1Mx2WOTgTrvVkDVqa852q38Iva1dlIH2NNPbXiDB1EUf3
         wA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608554; x=1784213354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6GY6GroFbI4q5Pmm52+Yi7RBYaKaWgF3VvzfzdyKcY=;
        b=mtaNJ3EssL8Iqe+XUhn2X7fMz6rU1tyc2XImsUcu4rU3Uu/x4wJjckSBHZ2egYrBFv
         Frpgu4EaB0Sa52gA6musQNtV0Gc/ZkNLAaE0udEImkwZljf6jptoI86yvJD3zNnsEkbY
         7hmMVM3hDDx1UEJZQrlI7I0cxA9iCgi4+ShPfeuqxomL5RQmWN0gXyun1kaevYefA6jU
         /2hAAM2DBZiJUaLpg9Ey/XVE7GBbxQFROmCPAVyhjvwmUoKFDLwPEIsqYLEexguwVwuN
         2Tcl3tEn+NflA4szb+e8nqQ9ygI4OqeSEezqNmJUYj/QgjZvmEZcUmfZxI+J+gegNXdU
         WBKA==
X-Forwarded-Encrypted: i=1; AHgh+RqV05hnDDHXkjpAEYymjsuMDNRFE1kANwxRDDdlT4DOfRefWklEhAH27oRyNXtpfoB4oEcCkHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v//+hqSwACuhMKU6TKspplZoVa6lO0Lx26HC5s0zRPVJGfZN
	UZevEUXLV3Dje/G1StSKc1NeKTkQ+SxhkVVQtuXa36oB78PcHjEGYwo5
X-Gm-Gg: AfdE7ckh+Z3RCtoM6ak1K9nIGWcQz/4LGZyiwn1l0dr5NQ0unNY/aVjs+5h9mF5Tdj4
	wN2WRe+FT9BRROvmRTKLRWZxwp8RHBllDiQKx9jDjGuDxlNzUc8+RtfYRUyBmKqF8gRMkOjbsqD
	oO3XS1hYbMOU1yHgUEDlrsYPD3gUTuXTNCFveKbUuKBEWDchG4Z1UKbdy+mV4zFuNhBzbljWDbl
	t7qFa5SG44GdZs1Zpvhl+K+1c2f2W9N1hjXAvFxfwHZR+THhNThswW/dUEz7uTGOsxZ715A6kEG
	7SNfRqr0+FcDqa794aZWDFNx2Y86dCuwIY8QRpyZaM9CgbPbKiJggMAIbFwJa75BO6o1iFJ1wTs
	MBXDcVF4pJ49IipWBGpAQZZGaTg9CLgML/uWMioic32QF6BHLWfIpkwljOiMHv7B3xL1y9wuZup
	aVr/fGm83rYsVxEY/ghewmL6AEG00oEjUd5PSDmck9oh10NSpp7PMCoBmbEw==
X-Received: by 2002:a05:600c:4e93:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-493e67f7c3emr69539015e9.0.1783608553887;
        Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 2/5] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
Date: Thu,  9 Jul 2026 14:48:57 +0000
Message-Id: <20260709144900.245904-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306286-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,etsalapatis.com:email,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8139732A04

This test opens a server and client, enters a new cgroup, attach a
cgroup_skb program on egress and calls the bpf_icmp_send function from
the client egress so that an ICMP unreach control message is sent back
to the client. It then fetches the message from the error queue to
confirm the correct ICMP unreach code has been sent.

Note that, for the client, we have to connect in non-blocking mode to
let the test execute faster. Otherwise, we need to wait for the TCP
three-way handshake to timeout in the kernel before reading the errno.

Also note that we don't set IP_RECVERR on the socket in
connect_to_fd_nonblock since the error will be transferred anyway in our
test because the connection is rejected at the beginning of the TCP
handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err for more details.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 164 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c |  38 ++++
 2 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
new file mode 100644
index 000000000000..b8a98c90053e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/errqueue.h>
+#include <poll.h>
+#include "icmp_send.skel.h"
+
+#define TIMEOUT_MS 1000
+
+#define ICMP_DEST_UNREACH 3
+
+#define ICMP_FRAG_NEEDED 4
+#define NR_ICMP_UNREACH 15
+
+#define KFUNC_RET_UNSET -1
+
+static int connect_to_fd_nonblock(int server_fd)
+{
+	struct sockaddr_storage addr;
+	socklen_t len = sizeof(addr);
+	int fd, err;
+
+	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
+		return -1;
+
+	fd = socket(addr.ss_family, SOCK_STREAM | SOCK_NONBLOCK, 0);
+	if (fd < 0)
+		return -1;
+
+	err = connect(fd, (struct sockaddr *)&addr, len);
+	if (err < 0 && errno != EINPROGRESS) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static void read_icmp_errqueue(int sockfd, int expected_code)
+{
+	struct sock_extended_err *sock_err;
+	char ctrl_buf[512];
+	struct msghdr msg = {
+		.msg_control = ctrl_buf,
+		.msg_controllen = sizeof(ctrl_buf),
+	};
+	struct pollfd pfd = {
+		.fd = sockfd,
+		.events = POLLERR,
+	};
+	struct cmsghdr *cm;
+	ssize_t n;
+
+	if (!ASSERT_GE(poll(&pfd, 1, TIMEOUT_MS), 1, "poll_errqueue"))
+		return;
+
+	n = recvmsg(sockfd, &msg, MSG_ERRQUEUE);
+	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
+		return;
+
+	cm = CMSG_FIRSTHDR(&msg);
+	if (!ASSERT_NEQ(cm, NULL, "cm_firsthdr_null"))
+		return;
+
+	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
+			continue;
+
+		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
+
+		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
+			       "sock_err_origin_icmp"))
+			return;
+		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
+			       "sock_err_type_dest_unreach"))
+			return;
+		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
+		return;
+	}
+
+	ASSERT_FAIL("no IP_RECVERR control message found");
+}
+
+static bool valid_unreach_code(int code)
+{
+	if (code < 0)
+		return false;
+
+	return code <= NR_ICMP_UNREACH && code != ICMP_FRAG_NEEDED;
+}
+
+static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
+{
+	int srv_fd = -1, client_fd = -1;
+	int port;
+
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
+	if (!ASSERT_OK_FD(srv_fd, "start_server"))
+		return;
+
+	port = get_socket_local_port(srv_fd);
+	if (!ASSERT_GE(port, 0, "get_socket_local_port")) {
+		close(srv_fd);
+		return;
+	}
+
+	skel->bss->server_port = ntohs(port);
+	skel->bss->unreach_code = code;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	client_fd = connect_to_fd_nonblock(srv_fd);
+	if (!ASSERT_OK_FD(client_fd, "client_connect_nonblock")) {
+		close(srv_fd);
+		return;
+	}
+
+	if (valid_unreach_code(code))
+		read_icmp_errqueue(client_fd, code);
+
+	close(client_fd);
+	close(srv_fd);
+}
+
+void test_icmp_send_unreach_cgroup(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		goto cleanup;
+
+	skel->links.egress =
+		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
+		goto cleanup;
+
+	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
+		if (code == ICMP_FRAG_NEEDED)
+			continue;
+
+		trigger_prog_read_icmp_errqueue(skel, code);
+		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
+	}
+
+	/* Test invalid codes */
+	trigger_prog_read_icmp_errqueue(skel, -1);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	trigger_prog_read_icmp_errqueue(skel, NR_ICMP_UNREACH + 1);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_FRAG_NEEDED);
+	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
+
+cleanup:
+	icmp_send__destroy(skel);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
new file mode 100644
index 000000000000..6d0be0a9afe1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+/* 127.0.0.1 in host byte order */
+#define SERVER_IP 0x7F000001
+
+#define ICMP_DEST_UNREACH 3
+
+__u16 server_port = 0;
+int unreach_code = 0;
+int kfunc_ret = -1;
+
+SEC("cgroup_skb/egress")
+int egress(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+	struct tcphdr *tcph;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
+	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
+		return SK_PASS;
+
+	tcph = (void *)iph + iph->ihl * 4;
+	if ((void *)(tcph + 1) > data_end ||
+	    tcph->dest != bpf_htons(server_port))
+		return SK_PASS;
+
+	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
+
+	return SK_DROP;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1


