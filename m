Return-Path: <netdev+bounces-280170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK5nCvuX52mp+AEAu9opvQ
	(envelope-from <netdev+bounces-280170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:30:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CE43CBEC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916EC30B660B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CAD3D6681;
	Tue, 21 Apr 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eat04ABF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A13D9026
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784947; cv=none; b=lVGEAPAk8/xL6WbMqyrTRyliZqRq02StyIv5zr4hE1NOfdXzp9Zz1miTrcyhMRL9F3q8VDKi70igGioW6iDktd7XnURqIqfWPV1lW7PyknN1R/+2U1VSlSJqYoEzf4t/p05+abyuxVx0qJDQccB0tYxS87PrFsJtCI4FassXKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784947; c=relaxed/simple;
	bh=10bVTT8LwhDFPnvBCTR3jKRRmNsviYTHVq+4E0ZWOds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kia4xFCNywtN9RKyzRGS6IYbe+lZmlALkJZ9tozHcwaEMKsVedhTHgtvDO7862p0V9GnFiVs4wFl7WuKzBqFPhhDQhn85QFGlI8DWcpQaje3Ebom9BPqgt/ox4riU5O7w5km31ShU1u5wXo+CIYQioyt3aPHgGPBKFWAjz0k0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eat04ABF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so2269196f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784944; x=1777389744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vej0hMbFq4b4vlO5xettSBT3c1QoZw4sK8xxsnU8g+A=;
        b=Eat04ABFRzpRa+4MSTaAWU3+EaBps2Rhg/A+kw8awNx1T+f1uMqu0T4OtCH5b7fUnM
         QW1Chfyio5lx2nnh0Bz9xGN8S76O4qD/R0XQJ3MVogErEAPCORGGmUQaLXnyQxLaGw2x
         GYuM9tzPQq3DMTzXmtKPx5bKA/cbUabK377Mr2ACd30NeP0UtD/tEe3bkOfPp65OnxBf
         jIQS18SA9uK3zPZTV0okz7Jz4tt4EQtGHcBFFncLKqq2UR7I1n8h8EdsK6ziDFt7bW4+
         4WkfvzFe2kAoPX2DYJnRn1wp60PHhGjLsU1ok+vJmpwXMHbjkt6M7/bency92Rqt20H7
         3SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784944; x=1777389744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vej0hMbFq4b4vlO5xettSBT3c1QoZw4sK8xxsnU8g+A=;
        b=lPknGc6ghvXW7kUycSIXz6GFffkcvuBBXKvFUlrjS1hKfUXzewR9wBnipgCMPnW+c9
         Op8rwVF9W85hma+oA4iR63uVxor/edilN2poJQqta97SlTx7d1lh2DeAf9txKFEmb0fL
         ahzXYluM/Io1nncyB5k2S0SPOdV2Cxj7d3M7v3qIhibQdJOgsWttgBonooWuv5rigIE4
         +rq6Jd6K2GvbbdKKETd4wqXZuNNc2d+lviCP4pTNqRUMABmX4HHUeZr3Lm6ROEu371/J
         Qql/lOmRitACvt2kDYh+eb9ppXF6luNRKwvtmt2mX7nQOKpc9vZ25pU+UrGXojC0zliU
         SavA==
X-Gm-Message-State: AOJu0YwndFKhmUEryC+Zvz/RBdgbWFhRO/KbbrTFnf6IXKUCxLJ8tpq/
	Gd2wSTJbtQYmj3jcGYWs+hERaJZJi2eRNvRoHWy9LvDnseTCoMcRgBNRMErCERVX
X-Gm-Gg: AeBDiesCYeTutjcjtfjJSl288bcyvsknNw3t3jaF4ANar6SJsjp4ayX50gOyBZcibTK
	YZIJ1ePG2TdeS6f3JIJTlKVHZbUu0TltbyQQLEyxqhflh5oJH28Vg58SG6Nh55RGAlNSTw0bfng
	9ixxCxBLkA6pCelJGNSMXeD4zqFA6kCbHc1UwUyTarVIJ90HsuSReTXkhwA02sknQW278/pO7FK
	wAplFQjhlIJmx8fmeLuoialsKRlIuxNW7JAdoCZPuz0pglrX0pJfLxFLzywmqY8R6g4FiqQkHqx
	DX1ERSP36WOQ20jbzpj5I8+ZZQiSqkY1tfuSL4lzgL4URkNaZq9p3l3d6dimgDejgcmMInDEl/D
	5Xi2lc0Mb+6dW88ecmzve8vVJfPJQGuGJG7Vn5sID+dq1ErYbags1xh9omHjUgQy7A7U5fPNldG
	BH1q2KHo0GX/LMyFlCnIdeyw7zTkb56Y+U8xfLojsx5+B3JC1iKhDUPrRaJojI4oICuDn7XGnsn
	qk/L/iJa4CZZ7PZ91Re0w==
X-Received: by 2002:adf:f584:0:b0:43f:e16f:3cc3 with SMTP id ffacd0b85a97d-43fe3dfd5efmr19868551f8f.22.1776784943477;
        Tue, 21 Apr 2026 08:22:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:22 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 1/3] mptcp: propagate RECVERR sockopts to subflows
Date: Tue, 21 Apr 2026 16:22:09 +0100
Message-ID: <20260421152216.38127-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280170-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6CE43CBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to
existing and future subflows.

Apply the matching sockopt according to the subflow family so mixed-
family subflows stay aligned with the parent socket configuration,
including disable-time errqueue purge semantics.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
---
 net/mptcp/sockopt.c | 125 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..b2b7ef888dff 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -8,6 +8,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/sock.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
@@ -384,6 +386,70 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static bool mptcp_recverr_enabled(const struct sock *sk, bool rfc4884)
+{
+	bool enabled;
+
+	enabled = rfc4884 ? inet_test_bit(RECVERR_RFC4884, sk) :
+			    inet_test_bit(RECVERR, sk);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		enabled |= rfc4884 ? inet6_test_bit(RECVERR6_RFC4884, sk) :
+				     inet6_test_bit(RECVERR6, sk);
+#endif
+
+	return enabled;
+}
+
+static int mptcp_subflow_set_recverr(struct sock *sk, struct sock *ssk,
+				     bool rfc4884)
+{
+	int level, optname, val;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ssk->sk_family == AF_INET6) {
+		level = SOL_IPV6;
+		optname = rfc4884 ? IPV6_RECVERR_RFC4884 : IPV6_RECVERR;
+	} else
+#endif
+	{
+		level = SOL_IP;
+		optname = rfc4884 ? IP_RECVERR_RFC4884 : IP_RECVERR;
+	}
+
+	val = mptcp_recverr_enabled(sk, rfc4884);
+	return tcp_setsockopt(ssk, level, optname, KERNEL_SOCKPTR(&val),
+			      sizeof(val));
+}
+
+static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool rfc4884 = optname == IPV6_RECVERR_RFC4884;
+
+		ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
+		if (ret)
+			break;
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -426,6 +492,10 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		release_sock(sk);
 		break;
+	case IPV6_RECVERR:
+	case IPV6_RECVERR_RFC4884:
+		ret = mptcp_setsockopt_v6_recverr(msk, optname, optval, optlen);
+		break;
 	}
 
 	return ret;
@@ -760,6 +830,33 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	return 0;
 }
 
+static int mptcp_setsockopt_v4_recverr(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool rfc4884 = optname == IP_RECVERR_RFC4884;
+
+		err = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
+		if (err)
+			break;
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+	}
+	release_sock(sk);
+
+	return err;
+}
+
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -771,6 +868,9 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	case IP_RECVERR:
+	case IP_RECVERR_RFC4884:
+		return mptcp_setsockopt_v4_recverr(msk, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1459,6 +1559,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_LOCAL_PORT_RANGE:
 		return mptcp_put_int_option(msk, optval, optlen,
 				READ_ONCE(inet_sk(sk)->local_port_range));
+	case IP_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR, sk));
+	case IP_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(RECVERR_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1479,6 +1585,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_FREEBIND:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet_test_bit(FREEBIND, sk));
+	case IPV6_RECVERR:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6, sk));
+	case IPV6_RECVERR_RFC4884:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet6_test_bit(RECVERR6_RFC4884, sk));
 	}
 
 	return -EOPNOTSUPP;
@@ -1536,6 +1648,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool recverr, recverr_rfc4884;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1586,6 +1699,18 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+	recverr = mptcp_recverr_enabled(sk, false);
+	recverr_rfc4884 = mptcp_recverr_enabled(sk, true);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (ssk->sk_family == AF_INET6) {
+		inet6_assign_bit(RECVERR6, ssk, recverr);
+		inet6_assign_bit(RECVERR6_RFC4884, ssk, recverr_rfc4884);
+	} else
+#endif
+	{
+		inet_assign_bit(RECVERR, ssk, recverr);
+		inet_assign_bit(RECVERR_RFC4884, ssk, recverr_rfc4884);
+	}
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0


