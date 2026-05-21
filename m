Return-Path: <netdev+bounces-290474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGJNEDQXD2oDFgYAu9opvQ
	(envelope-from <netdev+bounces-290474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2225A74D5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB67531FC162
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65B3E92A5;
	Thu, 21 May 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr7fPMui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278C2E1EE0
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371636; cv=none; b=Spzwj0e98pPJ2rCPTPU3gL96XVSXiE7cGVxbBM7xjUhqjWfxsWDcFSLaXBnwitfDIw5PXSv7LomOCJL3TD/QqWPuRLsKoF7XOPAN0Pcfb0iRHIIGyAJl2onSI84gJIlwtKmMxfTYkfNTxwnlpsqoh+cYLYvuA/9H3AbpM+jiY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371636; c=relaxed/simple;
	bh=4bFsDAM12mrZKSw4R78Ox7JfFMnkz8xQoZAOT6nLvY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cpt+fJV/ipgzojKXjpMmnkKx+Ck9k9mkIW65Yv8iL8B8g8/xFS9wldBxYxmaH2NEupwbWPDPttt+SPF7ykc+cpx7TsHGo6V9j2YJ2n0ipMjFitZOXhhKsSC7jAe3YIH/fK3MpLdHeSe+fyhI/suDJF4Lmfc9E51GF1JNTXAjZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr7fPMui; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9ea536877so37624385ad.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371634; x=1779976434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk22UbcVBp7SP3bZskwyIN7wzI3P1oiov9XU2EHkG+k=;
        b=Sr7fPMui6mDuQ9xTCToHl0N9L9VeGd+oraTmVm0+AISY9hix7q8MVLngEtpvFUiZEK
         wZjS3a+kG2oN4opwAEzmwUkDOMw+mVGtfZ1lh0MSUNw4lNpPJfobVax8T2ZL+45MbhrI
         CkXRSrJ8Kzzl0SxMni3T6XFnuhxh+QPlgo/2vNWhcUrRAOOi1sn2sngNyNyFFNVWxUTN
         tZ1NyvQn/GHtjTJQzSNJ5FevHCLwP2YuvjEET+7K4CxLfQGUVp2R8qM9rbVlmy+qzMZR
         ISuPzT/iJu8yBE5dS37ZRo/Pc2sH4FtfTzJ0Ih9dZhicPNHW08f7cjA2YgBuDO4LoYGi
         QJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371634; x=1779976434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xk22UbcVBp7SP3bZskwyIN7wzI3P1oiov9XU2EHkG+k=;
        b=jigbN3gdw8N26GxO85yJHK7GHI7iKETLgS6/nIn/NzHCQAzsNlHsIrssYJ6LuuYbel
         qkf+GB565QcYBvOsVWgxdrn9vUMNCoh4QP+AXCSOexdPponRgk7DwSU/JxuqK28wqQ89
         b7chPB6gZORm2ByMsD0VliB8aqDafApIFWdK4WU7yYoQRZ/MI8tLi001twzd/0NuBnVI
         vJ6GogEPHqVSyzaE6rEnyzTnoXgly45sprvEmE1RVtxWqr70DJsT4wLcZgf7s1lGToxl
         C7uIE4bG/7Sv7BsfKSXFufSg2Tz4OlodIKD3KXQ789TURZj2Snv0UXE+NnOAhnNxPxfZ
         W2qw==
X-Gm-Message-State: AOJu0Yzf0QMNgYPIgzHJs3zMmmqhDH13IHCiHc2FTg5gGJzCLmMUZj6a
	PRgBae/zzSvfE+K7MxHF3f7+vVZe4VbVUF1jhPvM4R7K+dVivZeGgfcF
X-Gm-Gg: Acq92OFP4aWp/3H1en8q0JyWJm4e9Z6T7MH8wqDSFNkK4+veCl6AyeJfGxj8i8NtRF9
	cQy+PcY36wyVX70VDukZhg82RfT/3QesmVF6n8FlBTo3oYTQWDh+OeLi1FGNnbrfQIW41rP/TJO
	vICQVC1T0pramf5yAQuds39v+KudydndX7qpz/NjYDUwDHoIfv4JTpgAZXW1KoijdFRtGfVO5Vv
	EFeltcCOhURLSXJLP57aS2MPG0hp6QrXXEh1Bwokqqss/STQSvIk+evJ2OJpXBETaCEKKWLY5jL
	rfj8OvHLg5NAM4sdpMfitwGyw3MqEyNb+CV0+XCmkLFyl+lZJSWs7A/gHhPbO2lYcUsljzh8jK6
	qjnhQb+Qr6knMZa0RKmqrxbHVSGfwgv8/o4NW2DqWK3qCJA8+HJq+osx/EhBruNxZsusd2YgKBb
	aCUGOOH+hO1+brO2iQL09HFIXM3RBZzBMf77ewtnlqi9QC61aHPOSypO3GOVR7YMu94x8rQfpZi
	H5jucNiiOo8n83ue4Bk+nw+TeBSREs=
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr28559035ad.20.1779371633985;
        Thu, 21 May 2026 06:53:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/6] selftests/bpf: Add RX latency tests for bpf timestamping
Date: Thu, 21 May 2026 21:52:44 +0800
Message-Id: <20260521135244.40869-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290474-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 9A2225A74D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
index dbfd87499b6b..e3fe850e4cc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
+++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
@@ -143,11 +143,47 @@ static void test_socket_timestamping(int fd)
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
+	if (!ASSERT_TRUE(tss != NULL, "SCM_TIMESTAMPING cmsg present") ||
+	    !ASSERT_TRUE(tss->ts[0].tv_sec || tss->ts[0].tv_nsec, "rx sw
+			 timestamp non-zero"))
+		return false;
+
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
@@ -187,7 +223,27 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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
@@ -207,6 +263,15 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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
 
@@ -215,8 +280,12 @@ static void test_tcp(int family, bool enable_socket_timestamping)
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


