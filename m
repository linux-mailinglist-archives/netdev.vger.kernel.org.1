Return-Path: <netdev+bounces-263607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFzvNJrTp2nEkAAAu9opvQ
	(envelope-from <netdev+bounces-263607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD1E1FB3B2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76357305CA3C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E465381AF5;
	Wed,  4 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d528Oi+o"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282237FF46
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606334; cv=none; b=ZpEHo0sXyxwL3fpVK1Uc+EDnNOo/GGnFcG6+K6Y9tFhxDmF3jAdRaNxEWouZvM7MusWHPLedKsSa7qoIgCKRNCwbSwY7dZMAKG/jTrwRQNwo25CT9xi96fvOp2qsFsLANkFutYDzAMrvOp5LcyVlcusB+fphNLV7dG1YX1c2gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606334; c=relaxed/simple;
	bh=KvbS4fqeuLB3Xt9vJYeJeK3CkPVEUl3hZINO1cNAVoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIE4GG1pMLOOFaeyOwqHVy6uj2oy523kvkXyYUGOrU1/uCFNiWHkLSGSHrcE9On62xrwDbi3ID69K3FGRSob9KcdiPyQfm0WSDVYDR6g2sz5CklHA+J7AphbxCiz5XWocmN3Rmh3+OG4nBTkjfMchxcV3N0ZSrVsW58zx5H8UQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d528Oi+o; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beX/DihSdzlZL0tDa9069FjqX9WJryfpvUqCEqHPrTc=;
	b=d528Oi+oRw4iNMJOtC1tQzAVg1+WrYyFLg0wp7dp0gpwc87orZljKi9wF828reEmGgCjy9
	4PP4BypmWfGH6AruFo4FUj2wlJ1CYNC39HiNnqIDvD5EhO93IE5MmotJb5LR9bXvgPbJor
	X/dePstwvu6QYlIRYtdhRn04e1AgeA0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 4/7] tcp_bpf: add splice_read support for sockmap
Date: Wed,  4 Mar 2026 14:33:55 +0800
Message-ID: <20260304063643.14581-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4FD1E1FB3B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263607-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,buf.page:url]
X-Rspamd-Action: no action

Implement splice_read for sockmap using an always-copy approach.
Each page from the psock ingress scatterlist is copied to a newly
allocated page before being added to the pipe, avoiding lifetime
and slab-page issues.

Add sk_msg_splice_actor() which allocates a fresh page via
alloc_page(), copies the data with memcpy(), then passes it to
add_to_pipe(). The newly allocated page already has a refcount
of 1, so no additional get_page() is needed. On add_to_pipe()
failure, no explicit cleanup is needed since add_to_pipe()
internally calls pipe_buf_release().

Also fix sk_msg_read_core() to update msg_rx->sg.start when the
actor returns 0 mid-way through processing. The loop processes
msg_rx->sg entries sequentially — if the actor fails (e.g. pipe
full for splice, or user buffer fault for recvmsg), prior entries
may already be consumed with sge->length set to 0. Without
advancing sg.start, subsequent calls would revisit these
zero-length entries and return -EFAULT. This is especially
common with the splice actor since the pipe has a small fixed
capacity (16 slots), but theoretically affects recvmsg as well.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c   | 10 ++++++
 net/ipv4/tcp_bpf.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6a906bfe3aa4..2fcbf8eaf4cf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -445,6 +445,16 @@ int sk_msg_read_core(struct sock *sk, struct sk_psock *psock,
 				copy = actor(actor_arg, page,
 					     sge->offset, copy);
 			if (!copy) {
+				/*
+				 * The loop processes msg_rx->sg entries
+				 * sequentially and prior entries may
+				 * already be consumed. Advance sg.start
+				 * so the next call resumes at the correct
+				 * entry, otherwise it would revisit
+				 * zero-length entries and return -EFAULT.
+				 */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 606c2b079f86..e85a27e32ea7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/util_macros.h>
+#include <linux/splice.h>
 
 #include <net/inet_common.h>
 #include <net/tls.h>
@@ -444,6 +445,85 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	return ret;
 }
 
+struct tcp_bpf_splice_ctx {
+	struct pipe_inode_info *pipe;
+};
+
+static int sk_msg_splice_actor(void *arg, struct page *page,
+			       unsigned int offset, size_t len)
+{
+	struct tcp_bpf_splice_ctx *ctx = arg;
+	struct pipe_buffer buf = {
+		.ops = &nosteal_pipe_buf_ops,
+	};
+	ssize_t ret;
+
+	buf.page = alloc_page(GFP_KERNEL);
+	if (!buf.page)
+		return 0;
+
+	memcpy(page_address(buf.page), page_address(page) + offset, len);
+	buf.offset = 0;
+	buf.len = len;
+
+	/*
+	 * add_to_pipe() calls pipe_buf_release() on failure, which
+	 * handles put_page() via nosteal_pipe_buf_ops, so no explicit
+	 * cleanup is needed here.
+	 */
+	ret = add_to_pipe(ctx->pipe, &buf);
+	if (ret <= 0)
+		return 0;
+	return ret;
+}
+
+static ssize_t tcp_bpf_splice_read(struct socket *sock, loff_t *ppos,
+				   struct pipe_inode_info *pipe, size_t len,
+				   unsigned int flags)
+{
+	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe };
+	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
+	struct sock *sk = sock->sk;
+	struct sk_psock *psock;
+	int ret;
+
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock))
+		return tcp_splice_read(sock, ppos, pipe, len, flags);
+	if (!skb_queue_empty(&sk->sk_receive_queue) &&
+	    sk_psock_queue_empty(psock)) {
+		sk_psock_put(sk, psock);
+		return tcp_splice_read(sock, ppos, pipe, len, flags);
+	}
+
+	ret = __tcp_bpf_recvmsg(sk, psock, sk_msg_splice_actor, &ctx,
+				len, bpf_flags);
+	sk_psock_put(sk, psock);
+	if (!ret)
+		return tcp_splice_read(sock, ppos, pipe, len, flags);
+	return ret;
+}
+
+static ssize_t tcp_bpf_splice_read_parser(struct socket *sock, loff_t *ppos,
+					  struct pipe_inode_info *pipe,
+					  size_t len, unsigned int flags)
+{
+	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe };
+	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
+	struct sock *sk = sock->sk;
+	struct sk_psock *psock;
+	int ret;
+
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock))
+		return tcp_splice_read(sock, ppos, pipe, len, flags);
+
+	ret = __tcp_bpf_recvmsg_parser(sk, psock, sk_msg_splice_actor, &ctx,
+				       len, bpf_flags);
+	sk_psock_put(sk, psock);
+	return ret;
+}
+
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				struct sk_msg *msg, int *copied, int flags)
 {
@@ -671,6 +751,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
+	prot[TCP_BPF_BASE].splice_read		= tcp_bpf_splice_read;
 	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
 	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
 
@@ -679,9 +760,11 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 
 	prot[TCP_BPF_RX]			= prot[TCP_BPF_BASE];
 	prot[TCP_BPF_RX].recvmsg		= tcp_bpf_recvmsg_parser;
+	prot[TCP_BPF_RX].splice_read		= tcp_bpf_splice_read_parser;
 
 	prot[TCP_BPF_TXRX]			= prot[TCP_BPF_TX];
 	prot[TCP_BPF_TXRX].recvmsg		= tcp_bpf_recvmsg_parser;
+	prot[TCP_BPF_TXRX].splice_read		= tcp_bpf_splice_read_parser;
 }
 
 static void tcp_bpf_check_v6_needs_rebuild(struct proto *ops)
-- 
2.43.0


