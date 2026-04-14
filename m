Return-Path: <netdev+bounces-278394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPKtL28e3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:01:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 707863F90E7
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF95A30B3432
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E33D7D8B;
	Tue, 14 Apr 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1PPsEav"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F434EF08
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164262; cv=none; b=LoFUChtNfxHMF9gw7EEUZHikMcTVxj81ZDbAYPfltnSqH1jx9KTEE7nhdQBr2PiTke3qlO6HQ6oIERZyBEnMRKzhufOIzPvCRwe66IqFqmz1Yc73dNOHvORoil3K90245D74v+LgVDpiIU9cHV+52uomdGvd2CrV4oyKCGkklPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164262; c=relaxed/simple;
	bh=qEdUDIS0XszYcYgqCC3NvynmxU3u2A8Nt8G2CMnCDi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUHnOXSxjUh7/KAVpnWv68HS4FpNwHaBZe7PG1z42fzwdSCUggtuDtCiZ/ILR6HSPsO7QzhPF1fQ9UZAcO5gohHbZRgV8mqzJBqG33QLZplbj0Z0EI464JOgAXZATl/Q08OXRgaCD8S2fiEX/06kL/300BNgtyuXvy6+6KzqWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1PPsEav; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776164248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kUMc9JT9mvA6tnmnVu0LMQDF/Ku/DuIn19+C8psUBNo=;
	b=s1PPsEavMdzmSBVV4lPqUiUC+F2v+djU9FJWMzHx5Mh37HDgRuD2lugsJIaYVoNut1wJvh
	EK1gumGOCMTY1fKpwe8jNOEj1Bem7TjXbbQV/oNixK1gMTO1fiClvuRQx5m2GZP4Lf/sR7
	0M1WGUkBrJVPH+okbrZSZXXARJlcO+M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf,tcp: avoid infinite recursion in BPF_SOCK_OPS_HDR_OPT_LEN_CB
Date: Tue, 14 Apr 2026 18:57:00 +0800
Message-ID: <20260414105702.248310-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,std.uestc.edu.cn,hust.edu.cn,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-278394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uestc.edu.cn:email,hust.edu.cn:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 707863F90E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG
to inject custom TCP header options. When the kernel builds a TCP packet,
it calls tcp_established_options() to calculate the header size, which
invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN_CB
callback.

If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callback,
__tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which calls
tcp_current_mss(), which calls tcp_established_options() again,
re-triggering the same BPF callback. This creates an infinite recursion
that exhausts the kernel stack and causes a panic.

BPF_SOCK_OPS_HDR_OPT_LEN_CB
  -> bpf_setsockopt(TCP_NODELAY)
	-> tcp_push_pending_frames()
	  -> tcp_current_mss()
		-> tcp_established_options()
		  -> bpf_skops_hdr_opt_len()
                           /* infinite recursion */
			-> BPF_SOCK_OPS_HDR_OPT_LEN_CB

A similar reentrancy issue exists for TCP congestion control, which is
guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduce
tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback in
bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
bpf_setsockopt(TCP_NODELAY) calls that would trigger
tcp_push_pending_frames() and cause the recursion.

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP header option")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 Documentation/networking/net_cachelines/tcp_sock.rst |  1 +
 include/linux/tcp.h                                  | 11 ++++++++++-
 net/core/filter.c                                    |  4 ++++
 net/ipv4/tcp_minisocks.c                             |  1 +
 net/ipv4/tcp_output.c                                |  3 +++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 563daea10d6c..07d3226d90cc 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -152,6 +152,7 @@ unsigned_int                  keepalive_intvl
 int                           linger2
 u8                            bpf_sock_ops_cb_flags
 u8:1                          bpf_chg_cc_inprogress
+u8:1                          bpf_hdr_opt_len_cb_inprogress
 u16                           timeout_rehash
 u32                           rcv_ooopack
 u32                           rcv_rtt_last_tsecr
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f72eef31fa23..2bfb73cf922e 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -475,12 +475,21 @@ struct tcp_sock {
 	u8	bpf_sock_ops_cb_flags;  /* Control calling BPF programs
 					 * values defined in uapi/linux/tcp.h
 					 */
-	u8	bpf_chg_cc_inprogress:1; /* In the middle of
+	u8	bpf_chg_cc_inprogress:1, /* In the middle of
 					  * bpf_setsockopt(TCP_CONGESTION),
 					  * it is to avoid the bpf_tcp_cc->init()
 					  * to recur itself by calling
 					  * bpf_setsockopt(TCP_CONGESTION, "itself").
 					  */
+		bpf_hdr_opt_len_cb_inprogress:1; /* It is set before invoking the
+						  * callback so that a nested
+						  * bpf_setsockopt(TCP_NODELAY) or
+						  * bpf_setsockopt(TCP_CORK) cannot
+						  * trigger tcp_push_pending_frames(),
+						  * which would call tcp_current_mss()
+						  * -> bpf_skops_hdr_opt_len(), causing
+						  * infinite recursion.
+						  */
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
 #else
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..518699429a7a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5483,6 +5483,10 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	if (sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
+	if ((optname == TCP_NODELAY || optname == TCP_CORK) &&
+	    tcp_sk(sk)->bpf_hdr_opt_len_cb_inprogress)
+		return -EBUSY;
+
 	switch (optname) {
 	case TCP_NODELAY:
 	case TCP_MAXSEG:
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index dafb63b923d0..fb06c464ac16 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -663,6 +663,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
 
 	newtp->bpf_chg_cc_inprogress = 0;
+	newtp->bpf_hdr_opt_len_cb_inprogress = 0;
 	tcp_bpf_clone(sk, newsk);
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118..c9654e690e1a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -475,6 +475,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 				  unsigned int *remaining)
 {
 	struct bpf_sock_ops_kern sock_ops;
+	struct tcp_sock *tp = tcp_sk(sk);
 	int err;
 
 	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
@@ -519,7 +520,9 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, 0);
 
+	tp->bpf_hdr_opt_len_cb_inprogress = 1;
 	err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+	tp->bpf_hdr_opt_len_cb_inprogress = 0;
 
 	if (err || sock_ops.remaining_opt_len == *remaining)
 		return;
-- 
2.43.0


