Return-Path: <netdev+bounces-292544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNHYFfWyF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:13:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FF5EC23D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE711301AF46
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B342305697;
	Thu, 28 May 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIWn/mYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667418C933;
	Thu, 28 May 2026 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937901; cv=none; b=DDMg2ZhCtLjIdOKw/N4HPDcBCn3kL6h5unSEbWZWlZZkrP2FURujAR8DxH91/9vl4qmPBwAmmaPCIxFNbPqCS2yozTKsEXLUl40MpLvHq1pWVf26XzRnYWrrM4yvUivoLFcAivqrjmCr/jdJJtenMhm7cwQpSIe6Hrf8jyGGIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937901; c=relaxed/simple;
	bh=8NVMjdRxZpTyLQxHaCs8pbMS+s5bcuOhtXOHfSz4tcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUP2Zm04s+eopWSFLTfgMIajd+yfF3W+Awuyb6q3wbTrTpz8NPVDPv5HgIfoPP0NqJy8WEpN+2RylnJ7NtcDtV9LQu2UzSWteHEHz1SN1gEswZCfcVRv/CJMQWa1xyvIkn2kuuh/Dpv4NZ4EJYonrWNK9SB1K1UHqUrhGCqyKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIWn/mYD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C4E1F00A3C;
	Thu, 28 May 2026 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937899;
	bh=6+8IEzoRehjjp8IjXCg+Lnt1AIJejqKg0hiZ67zNe3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIWn/mYDkjaJRU7bNOFKOv2WcJ6KtrWz08uijEIWCU/NMaxtn3tSMRmcOmQ18kAlX
	 kj16jDwA9JMfjlulFOCPPytGbM3uzx3sBlRao1z8vQmnUOzSndXpOMHAMdxfT5A+5L
	 0s+5qOt2DztUI0Vu2VV42fpc38Yy32uFnFXJHougFhLaRe673S/83mq+oLt/ryhas3
	 S9aCIvyhU5lg67UPy4fREjn9DI7wYsXP5lVKLZehZMP1XbUzCKFbWBs9tChi5Lx991
	 vzwkdOghWMX1XzhIBrA9iTYmFPvf5tbl5IT7eOWJtnb46Are25ZChchdMZmh+9LOal
	 zEeUkh/1kC75A==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
Date: Thu, 28 May 2026 11:10:36 +0800
Message-ID: <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292544-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kylinos.cn:mid,kylinos.cn:email,purestorage.com:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED6FF5EC23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

An MPTCP-specific version of struct nvmet_tcp_proto is implemented for
accept sockets. It is assigned to queue->proto when the accepted socket
protocol is IPPROTO_MPTCP.

Dedicated MPTCP helpers are introduced for setting accept socket options.
These helpers (no_linger, set_priority, set_tos) set the values on all
existing subflows using mptcp_for_each_subflow(). The values are then
synchronized to other newly created subflows in sync_socket_options().

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 16 ++++++++
 include/net/mptcp.h       | 12 ++++++
 net/mptcp/sockopt.c       | 79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 01c23fb15b79..16f153a9772b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -220,6 +220,9 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
+#endif
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1928,6 +1931,15 @@ static const struct nvmet_tcp_proto nvmet_tcp_proto = {
 	.ops		= &nvmet_tcp_ops,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvmet_tcp_proto nvmet_mptcp_proto = {
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= mptcp_sock_set_tos,
+	.ops		= &nvmet_mptcp_ops,
+};
+#endif
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1947,6 +1959,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->sock = newsock;
 	if (newsock->sk->sk_protocol == IPPROTO_TCP) {
 		queue->proto = &nvmet_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (newsock->sk->sk_protocol == IPPROTO_MPTCP) {
+		queue->proto = &nvmet_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_queue;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index aef2dbeb847b..bf74dedc578d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -233,6 +233,12 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+void mptcp_sock_no_linger(struct sock *sk);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority);
+
+void mptcp_sock_set_tos(struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -319,6 +325,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline void mptcp_sock_no_linger(struct sock *sk) { }
+
+static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
+
+static inline void mptcp_sock_set_tos(struct sock *sk) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..359b1eb2d0a9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1662,3 +1662,82 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
+
+void mptcp_sock_no_linger(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	WRITE_ONCE(sk->sk_lingertime, 0);
+	sock_set_flag(sk, SOCK_LINGER);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			WRITE_ONCE(ssk->sk_lingertime, 0);
+			sock_set_flag(ssk, SOCK_LINGER);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_no_linger);
+
+void mptcp_sock_set_priority(struct sock *sk, u32 priority)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	sock_set_priority(sk, priority);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			sock_set_priority(ssk, priority);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+EXPORT_SYMBOL(mptcp_sock_set_priority);
+
+static void __mptcp_sock_set_tos(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	__ip_sock_set_tos(sk, val);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			__ip_sock_set_tos(ssk, val);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+}
+
+void mptcp_sock_set_tos(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int val = 0;
+
+	lock_sock(sk);
+	if (msk->first)
+		val = inet_sk(msk->first)->rcv_tos;
+	release_sock(sk);
+
+	if (val > 0)
+		__mptcp_sock_set_tos(sk, val);
+}
+EXPORT_SYMBOL(mptcp_sock_set_tos);
-- 
2.53.0


