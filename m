Return-Path: <netdev+bounces-288934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HpmEhvQCmru8QQAu9opvQ
	(envelope-from <netdev+bounces-288934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:38:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D176F568FB5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 020AA305668B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6AB3EAC68;
	Mon, 18 May 2026 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaIabLYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CE3E3C6C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092687; cv=none; b=S8M84Q/mrLa46SnfL2+Gy0wFLMFVU9Jy1dC5Ybk/JICAbn+jaPgpUB0SJ7NXrn1RAVWc6gY+wyan8q89qvi6H50r5k86IHY4/6E1k8+w690S2XCUUL9xxLlZV/jOm5ooBsT4ezWeSFs/7yHBSnZQVaev+6zmHI1Gz9TMb9H6hQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092687; c=relaxed/simple;
	bh=YunP5JV5Tn6ACZbMb4h5mvr2CvedpcArCmq2xF3W3go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V37ZdZniDKe+eNLAmEtitv8ezObSdHbhkuwcLY6XlwEOwf7ZIGSPTUXwo235TXk718xhWfohhdjeWYNKmlbvCrwnnbyTZcVZsR+veqlYW8PhXB7wkxNFBYZrgnjVp3iIAC2u6j3ooh8koYZDAWmO5BMgsCYc0nnetJvky0cpCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaIabLYr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36974217d4eso989687a91.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092685; x=1779697485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PIwPLcCeOC0NWb/rVd+8epgttcNSCL32RwHPIPB81w=;
        b=QaIabLYrqZeg6FVkfqG9VSwPTQ86P5dHX2hX1bXgyID7Ss/p2F3syIMv4+BeVtWO2l
         M7Os1YzEDgojVePNvrpQNVs0vD6a/lspebEDNWJBVN0bl32uSrLs5IPnhWmgWowLuOMG
         3AzF/8oKmCtrMpiO4IHnYmvlXE7UPiCq2HKHXuaiNwS6OXLOEuAaGwQ5ZjVoua5lwaJZ
         EuYhnbCjA/NYmO6MsLtSMzyip3x2IQ+b6QUcogb0A1LROnUKDgmwIeu+B5C18FSjSFmI
         7FJI8UShSR74WLPumo0/GN1JMn170RJZBAveYnWJ2nNpQ4YV16WyXs1+tTUXOyJP04LI
         jYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092685; x=1779697485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PIwPLcCeOC0NWb/rVd+8epgttcNSCL32RwHPIPB81w=;
        b=WgEevxksbPIA0rNgAgl3FeT94vT+tFD+vpXg+zeUFu8gIIyNzuGm+xvRvk6dUo9Sj3
         GwbkOgckTallewhIsai+OD8rrhO63+LQ5C4M+vb3pzhDaeJhQ1abO/83uZ97W3ObqwDR
         NeYSraHSfTOpQ3G2oAwEoUADi2rp56xhoHsJi+Rl78IRQRT0jIcZUUeds7m0dHXhrDJ8
         Yvad56o092BP/roICht/aUbOVefu3USJcMTsmxdp30GavuTRx+zvaREvmRb/5LlAjY2W
         mW72TKMBo/e+xODGOpjz1Aqxsjd+VITZ7uBjmCpYSqdWVEgeZ50GJlxRxb0klSgEKFDT
         SrRw==
X-Gm-Message-State: AOJu0YzAaJtWYupEv10txaYKTrhH7WPGu6M8SLOcxjMPMj2LYqA4s7XC
	0r3B73Va7oVQZUU6s7ZLcscryR68QcAAdpRp9RDOMHURL63oKlQXFe6K
X-Gm-Gg: Acq92OHa0ZrNBqsu7oK82ekvk35fpVzJwsMJ1kCImyFOppIFv55i28TAxeWYgJG2HDL
	15KBOHCN7wVdDrcwLyLlRMuGImBbKEBJiMDNiJrhb6IromN4RVl2Yc1uUkk5v6xO6fYhKfVAvKc
	zHHolZcv3znqYsSxr5CNToKdsA71+r5mot3OZJEby2a0XOdo83L5fhHcmpd6f2nzfpZ+ceN5Xzv
	CE1dsCAk5DQYc5ujVaqFSkya5x/E728T1tluQbnZ0eKDibED4Ibfjy/1j7eJqBeSG6EGqWb905P
	X0PFtkkhCNjfbQcc8Y9s9EPt3VhIPSwRuSNapwhQc7uXHvR3TAiLR62UiZf9YqEEVpFDQmmN6bK
	YnY/rEzry1fNbw99+k953LFfRI+93Tw64B6+DVnpe6cWU/xGedocY09WSWuRlq8/RAB5qIjoQjO
	u39oAwzl6ui4TKk0eECdzfzEjs+TpHkxWAGFFc4vApPk/65uk0WyIWcFhb8qUWkzTp0UBBBd34j
	b+WRgrulerGJYuGN6sTEI1bei+7ZSXYvGWNr8+a
X-Received: by 2002:a17:90a:c42:b0:369:7421:6d2b with SMTP id 98e67ed59e1d1-3697421b9e8mr4789963a91.19.1779092684697;
        Mon, 18 May 2026 01:24:44 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 6/6] selftests/bpf: Add RX latency tests for bpf timestamping
Date: Mon, 18 May 2026 16:23:44 +0800
Message-Id: <20260518082344.96647-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D176F568FB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The client sends data, and the server reads it via read(), which
triggers tcp_recvmsg() internally. And then the computation is done
in the BPF_SOCK_OPS_TSTAMP_RCV_CB callback. Extend test_tcp() to cover
the new BPF RX timestamping path.

One more crucial thing is to add usleep to allow the delay of workqueue
turning on global time record of each skb in recv path, or else the test
might fail due to no timestamp in the skb.

Verify that SO_TIMESTAMPING RX (software) and BPF RX timestamping can
work simultaneously on the same socket without conflict. When
enable_socket_timestamping is set, enable SOF_TIMESTAMPING_SOFTWARE |
SOF_TIMESTAMPING_RX_SOFTWARE on afd and use recvmsg() to verify the
SCM_TIMESTAMPING cmsg contains a valid software RX timestamp.

This exercises the mixed mode where all 4 timestamping paths (SO TX on
cfd, SO RX on afd, BPF TX on cfd, BPF RX on afd) run together. The
standalone mode (enable_socket_timestamping=false) keeps only BPF TX
and BPF RX active using read().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../bpf/prog_tests/net_timestamping.c         | 69 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 ++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
index dbfd87499b6b..3cc52b670e74 100644
--- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
+++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
@@ -143,11 +143,45 @@ static void test_socket_timestamping(int fd)
 	SK_TS_ACK = 0;
 }
 
+static bool recv_verify_rx_timestamp(int fd, char *buf, int len)
+{
+	struct scm_timestamping *tss = NULL;
+	char ctrl[1024];
+	struct msghdr msg = {};
+	struct iovec iov;
+	struct cmsghdr *cm;
+	int ret;
+
+	iov.iov_base = buf;
+	iov.iov_len = len;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = ctrl;
+	msg.msg_controllen = sizeof(ctrl);
+
+	ret = recvmsg(fd, &msg, 0);
+	if (!ASSERT_EQ(ret, len, "recvmsg from client"))
+		return false;
+
+	for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cm);
+			break;
+		}
+	}
+
+	ASSERT_TRUE(tss != NULL, "SCM_TIMESTAMPING cmsg present");
+	ASSERT_TRUE(tss && (tss->ts[0].tv_sec || tss->ts[0].tv_nsec),
+		    "rx sw timestamp non-zero");
+	return true;
+}
+
 static void test_tcp(int family, bool enable_socket_timestamping)
 {
 	struct net_timestamping__bss *bss;
 	char buf[cfg_payload_len];
-	int sfd = -1, cfd = -1;
+	int sfd = -1, cfd = -1, afd = -1;
 	unsigned int sock_opt;
 	struct netns_obj *ns;
 	int cg_fd;
@@ -187,7 +221,27 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
 		goto out;
 
+	afd = accept(sfd, NULL, NULL);
+	if (!ASSERT_OK_FD(afd, "accept"))
+		goto out;
+
+	/* net_enable_timestamp() defers the static key update via
+	 * schedule_work() when CONFIG_JUMP_LABEL is set. Give the
+	 * workqueue a chance to run so that netstamp_needed_key is
+	 * active and skb->tstamp gets populated in the receive path.
+	 */
+	usleep(10000);
+
 	if (enable_socket_timestamping) {
+		unsigned int rx_opt;
+
+		rx_opt = SOF_TIMESTAMPING_SOFTWARE |
+			 SOF_TIMESTAMPING_RX_SOFTWARE;
+		ret = setsockopt(afd, SOL_SOCKET, SO_TIMESTAMPING,
+				 (char *)&rx_opt, sizeof(rx_opt));
+		if (!ASSERT_OK(ret, "setsockopt SO_TIMESTAMPING RX on afd"))
+			goto out;
+
 		sock_opt = SOF_TIMESTAMPING_SOFTWARE |
 			   SOF_TIMESTAMPING_OPT_ID |
 			   SOF_TIMESTAMPING_TX_SCHED |
@@ -207,6 +261,15 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	if (!ASSERT_EQ(ret, sizeof(buf), "send to server"))
 		goto out;
 
+	if (enable_socket_timestamping) {
+		if (!recv_verify_rx_timestamp(afd, buf, sizeof(buf)))
+			goto out;
+	} else {
+		ret = read(afd, buf, sizeof(buf));
+		if (!ASSERT_EQ(ret, sizeof(buf), "recv from client"))
+			goto out;
+	}
+
 	if (enable_socket_timestamping)
 		test_socket_timestamping(cfd);
 
@@ -215,8 +278,12 @@ static void test_tcp(int family, bool enable_socket_timestamping)
 	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
 	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
 	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
+	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
+	ASSERT_GE(bss->nr_rcv, 1, "nr_rcv");
 
 out:
+	if (afd >= 0)
+		close(afd);
 	if (sfd >= 0)
 		close(sfd);
 	if (cfd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/net_timestamping.c b/tools/testing/selftests/bpf/progs/net_timestamping.c
index b4c2f0f2be11..4bbff09db55c 100644
--- a/tools/testing/selftests/bpf/progs/net_timestamping.c
+++ b/tools/testing/selftests/bpf/progs/net_timestamping.c
@@ -6,6 +6,8 @@
 #include "bpf_kfuncs.h"
 #include <errno.h>
 
+extern u64 bpf_ktime_get_real_ns(void) __ksym;
+
 __u32 monitored_pid = 0;
 
 int nr_active;
@@ -14,6 +16,7 @@ int nr_passive;
 int nr_sched;
 int nr_txsw;
 int nr_ack;
+int nr_rcv;
 
 struct sk_stg {
 	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
@@ -65,6 +68,22 @@ static int bpf_test_sockopt(void *ctx, const struct sock *sk, int expected)
 	return 0;
 }
 
+static int bpf_test_rx_sockopt(void *ctx, const struct sock *sk, int expected)
+{
+	int tmp, new = SK_BPF_CB_RX_TIMESTAMPING;
+	int opt = SK_BPF_CB_FLAGS;
+	int level = SOL_SOCKET;
+
+	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)) != expected)
+		return 1;
+
+	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) != expected ||
+	    (!expected && tmp != new))
+		return 1;
+
+	return 0;
+}
+
 static bool bpf_test_access_sockopt(void *ctx, const struct sock *sk)
 {
 	if (bpf_test_sockopt(ctx, sk, -EOPNOTSUPP))
@@ -224,6 +243,9 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		nr_active += !bpf_test_sockopt(skops, sk, 0);
 		break;
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		nr_passive += !bpf_test_rx_sockopt(skops, sk, 0);
+		break;
 	case BPF_SOCK_OPS_TSTAMP_SENDMSG_CB:
 		if (bpf_test_delay(skops, sk))
 			nr_snd += 1;
@@ -240,6 +262,19 @@ int skops_sockopt(struct bpf_sock_ops *skops)
 		if (bpf_test_delay(skops, sk))
 			nr_ack += 1;
 		break;
+	case BPF_SOCK_OPS_TSTAMP_RCV_CB: {
+		u64 sw_tstamp, now, delay;
+
+		sw_tstamp = (u64)skops->args[0] | ((u64)skops->args[1] << 32);
+		if (!sw_tstamp)
+			break;
+
+		now = bpf_ktime_get_real_ns();
+		delay = now - sw_tstamp;
+		if (delay < delay_tolerance_nsec)
+			nr_rcv += 1;
+		break;
+	}
 	}
 
 	return 1;
-- 
2.43.7


