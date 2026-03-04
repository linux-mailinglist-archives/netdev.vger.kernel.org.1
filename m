Return-Path: <netdev+bounces-263608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOhEBavTp2nEkAAAu9opvQ
	(envelope-from <netdev+bounces-263608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FA1FB3C8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 720C3305A95B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0635381AF5;
	Wed,  4 Mar 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjbhhzTd"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C937F8B2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606358; cv=none; b=r/GAodK9j1Jpldfr+VZNiL9qvEI5E8F4op7ZZ3WBBIePBZc/Aqd1mBQ4GtY/FxcJz+oXfCMgZMvSaH/STsnh5BaahwpmlZhkJ2K/pgBl4HxYXWETFJWvQ6VcM+WgNHDMp0QmTTASxfOLNgma1hjnD4U+TPhJRXwljvwIplYAI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606358; c=relaxed/simple;
	bh=T3LZkyXNgXp7yXEoUgK0q7pKCngpRITB3P7KxJw8R3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns/QgTwfRdbY1udqXBH4UT9iO1kXJWd8zzCwhCFngHPkaL45sgPwScE0vXmuHx6cm7Pbti86A+WYl+jM1T+KPX0yTxeWbiS7F3LBfLuRUhhc9SSy6MLl7N0e8Pnon0jiqqO6I63azcFKMl2Ds/fEuSViFx6kAYDiKa8MXhwPidg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XjbhhzTd; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5duGPLmRq29qJW6Ubc2JTj9Y024B43GziisGHsbdVM=;
	b=XjbhhzTdcorKHPYWcfmiX2oGlCoSL1wUr+CUtd8WlT2R3/xdlrugtM+MNIP1lrNiaqM+m5
	jovxTnqsXHiZG+vYbETJvCkxEJ/3hEVv9aiNy4MsJ/xkQiw13drwVxcf3yTduSIFpQUpkw
	y74jmFQHAPmGee+k8P2fG3WOjoVJC5A=
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
Subject: [PATCH bpf-next v1 5/7] tcp_bpf: optimize splice_read with zero-copy for non-slab pages
Date: Wed,  4 Mar 2026 14:33:56 +0800
Message-ID: <20260304063643.14581-6-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8C5FA1FB3C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,buf.page:url]
X-Rspamd-Action: no action

The previous splice_read implementation copies all data through
intermediate pages (alloc_page + memcpy). This is wasteful for
skb fragment pages which are allocated from the page allocator
and can be safely referenced via get_page().

Optimize by checking PageSlab() to distinguish between linear
skb data (slab-backed) and fragment pages (page allocator-backed):

- For slab pages (skb linear data): copy to a page fragment via
  sk_page_frag, matching what linear_to_page() does in the
  standard TCP splice path (skb_splice_bits). get_page() is
  invalid on slab pages so a copy is unavoidable here.
- For non-slab pages (skb frags): use get_page() directly for
  true zero-copy, same as skb_splice_bits does for fragments.

Both paths use nosteal_pipe_buf_ops. The sk_page_frag approach
is more memory-efficient than alloc_page for small linear copies,
as multiple copies can share a single page fragment.

Benchmark results with rx-verdict-ingress mode (loopback, 8 CPUs):

  splice(2) + always-copy:  ~2770 MB/s (before this patch)
  splice(2) + zero-copy:    ~4270 MB/s (after this patch, +54%)
  read(2):                  ~4292 MB/s (baseline for reference)

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/tcp_bpf.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e85a27e32ea7..13506ba7672f 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -447,6 +447,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 struct tcp_bpf_splice_ctx {
 	struct pipe_inode_info *pipe;
+	struct sock *sk;
 };
 
 static int sk_msg_splice_actor(void *arg, struct page *page,
@@ -458,13 +459,33 @@ static int sk_msg_splice_actor(void *arg, struct page *page,
 	};
 	ssize_t ret;
 
-	buf.page = alloc_page(GFP_KERNEL);
-	if (!buf.page)
-		return 0;
+	if (PageSlab(page)) {
+		/*
+		 * skb linear data is backed by slab memory where
+		 * get_page() is invalid. Copy to a page fragment from
+		 * the socket's page allocator, matching what
+		 * linear_to_page() does in the standard TCP splice
+		 * path (skb_splice_bits).
+		 */
+		struct page_frag *pfrag = sk_page_frag(ctx->sk);
+
+		if (!sk_page_frag_refill(ctx->sk, pfrag))
+			return 0;
 
-	memcpy(page_address(buf.page), page_address(page) + offset, len);
-	buf.offset = 0;
-	buf.len = len;
+		len = min_t(size_t, len, pfrag->size - pfrag->offset);
+		memcpy(page_address(pfrag->page) + pfrag->offset,
+		       page_address(page) + offset, len);
+		buf.page = pfrag->page;
+		buf.offset = pfrag->offset;
+		buf.len = len;
+		pfrag->offset += len;
+	} else {
+		buf.page = page;
+		buf.offset = offset;
+		buf.len = len;
+	}
+
+	get_page(buf.page);
 
 	/*
 	 * add_to_pipe() calls pipe_buf_release() on failure, which
@@ -481,9 +502,9 @@ static ssize_t tcp_bpf_splice_read(struct socket *sock, loff_t *ppos,
 				   struct pipe_inode_info *pipe, size_t len,
 				   unsigned int flags)
 {
-	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe };
-	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
 	struct sock *sk = sock->sk;
+	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe, .sk = sk };
+	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
 	struct sk_psock *psock;
 	int ret;
 
@@ -508,9 +529,9 @@ static ssize_t tcp_bpf_splice_read_parser(struct socket *sock, loff_t *ppos,
 					  struct pipe_inode_info *pipe,
 					  size_t len, unsigned int flags)
 {
-	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe };
-	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
 	struct sock *sk = sock->sk;
+	struct tcp_bpf_splice_ctx ctx = { .pipe = pipe, .sk = sk };
+	int bpf_flags = flags & SPLICE_F_NONBLOCK ? MSG_DONTWAIT : 0;
 	struct sk_psock *psock;
 	int ret;
 
-- 
2.43.0


