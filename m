Return-Path: <netdev+bounces-254897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICfdOka0e2neHwIAu9opvQ
	(envelope-from <netdev+bounces-254897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:25:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51794B3F21
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89053060BDA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8210314D1F;
	Thu, 29 Jan 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyCDgmFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8F32471A;
	Thu, 29 Jan 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714642; cv=none; b=bJvNc2/2IupGH2yNI+wDmWgIsZa4pxjr57/bD+dz9dJgzye+B6nBdxBJN2lSMTGzMdIKubnYFBKphRxTfMwuEp50yvIWab8Q3rwaAY0iXw1g8sLC/6+F++YLuqKd/lksm+i5aFyzoeEHxpHm9CVj4xcZYV0x3RuCuSK7bvrJ3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714642; c=relaxed/simple;
	bh=5pXsZ1+bdcl0+5ekJkKvICgBbW8Fn1J1qfigEm+sIpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtISvvJaQGUS3176ahixpcXJDKwgPmZWIZ2ztyEQlso1WmlM4hzfQCxoe5BwuIKYB5r2PtTanLnqNYLcyKEM8cjKbtmUVvmgnh+NmB81he3sm5bfUN9nxn/aX/FxDbx+tQN+kjdR83C1V6CWmDOr5XE4/DOqGFPZSRUIPk8pJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyCDgmFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B91C2BC86;
	Thu, 29 Jan 2026 19:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769714640;
	bh=5pXsZ1+bdcl0+5ekJkKvICgBbW8Fn1J1qfigEm+sIpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eyCDgmFskEs8TLZcnVdkB0SWuu7iFTRnF/KeXF6dfEdicQAFGOQEHFsWKNELAEuEJ
	 yT0rft9c92//i7t/yOugLElCbTxu2bbBQjKUg1M3FWZ2vcgAVMb8LvGEOeMXk4Srxb
	 9DvCyc+EW/Aw2LjmhATVdxZIidz588P6HP7DK7gHlwNxDbyumduEs0RCG5auGgVP78
	 MthL3fJagCwHZZkyXmi6LX+lZPBIE+izrGyMV2EIEuO2nnud6leAvy4Rgv0Ljd8bvN
	 7CsiDokfZ+8of8vYDrI131Ff9BW92MqFrKWrToN9r1GydK8dwfgEL/yTz5pqfAF5RW
	 uPgUfUp2Or3PQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Jan 2026 20:23:36 +0100
Subject: [PATCH net-next 3/6] tcp: export tcp_splice_state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-net-next-mptcp-splice-v1-3-994cac40daa0@kernel.org>
References: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
In-Reply-To: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=E5O3UWqgt4CvgYo2yhYrE/jWhi6yLAzzOug/sQ4PZ3w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKrNx9iUA1kNpL1O7B6J6e65fNpXUYqncsNJzivNHy7p
 LdJM+96RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZwIZwcQrAREQcGP6HFr7e/uW+dpfB3wop
 b2+b1PlLvs4/NmvLt5T2J3PuTv7qxPA/bsWbSa0z1Yy+3bp1lY370peNE5wWLZGtSeZfJpSgu/I
 XIwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51794B3F21
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

Export struct tcp_splice_state and tcp_splice_data_recv() in net/tcp.h
so that they can be used by MPTCP in the next patch.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h | 11 +++++++++++
 net/ipv4/tcp.c    | 13 ++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f1cf9e6730c8..cecec1a92d5e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -347,6 +347,15 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
+/*
+ * TCP splice context
+ */
+struct tcp_splice_state {
+	struct pipe_inode_info *pipe;
+	size_t len;
+	unsigned int flags;
+};
+
 void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
@@ -378,6 +387,8 @@ void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
 void tcp_twsk_purge(struct list_head *net_exit_list);
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e4009158b908..6e94c5859f4b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -318,15 +318,6 @@ EXPORT_SYMBOL(tcp_have_smc);
 struct percpu_counter tcp_sockets_allocated ____cacheline_aligned_in_smp;
 EXPORT_IPV6_MOD(tcp_sockets_allocated);
 
-/*
- * TCP splice context
- */
-struct tcp_splice_state {
-	struct pipe_inode_info *pipe;
-	size_t len;
-	unsigned int flags;
-};
-
 /*
  * Pressure flag: try to collapse.
  * Technical note: it is used by multiple contexts non atomically.
@@ -791,8 +782,8 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 	__tcp_push_pending_frames(sk, mss_now, nonagle);
 }
 
-static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
-				unsigned int offset, size_t len)
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len)
 {
 	struct tcp_splice_state *tss = rd_desc->arg.data;
 	int ret;

-- 
2.51.0


