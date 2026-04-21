Return-Path: <netdev+bounces-280181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHadOgWf52ml+QEAu9opvQ
	(envelope-from <netdev+bounces-280181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:00:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1854643D0E4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B49EE30095F9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17873630AE;
	Tue, 21 Apr 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXwGyR4q"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F036215B
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787173; cv=none; b=j17UfH0UmykWsuIjKtWVZzif0Dl0e6wdR+PMtP/pyeyw+PV7mY3sJGKXbTkxF1hGoBxz2SlQc5uCva73NNSU1zdvpM7Huy6RKtx+FSc3oJWZ9o4WsbR1KG0cOqfhTsxCbv3CItAcpTwAL5cOTWqN5quDCSHAj6DGHZ47UYauWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787173; c=relaxed/simple;
	bh=3hSh3lFXbFSbrMW9IaKB5o2WHPIwz1DAomU7Hz2Ubwg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDreCSCV24PaKc6L7ohIWOMjfW2iQCo4tJ9Ivfu4PiFWCzRdnnH0qgiuzSse+fpGBQZR+iy4gCo49Q5AfMlM0ZJTxbqOhzgb8N2j+VEcUNsazePNQrwK+s4X88757rXSDi/xlXdyvlY2un5RtxpiKXMnddm4XTJMJT2PL1Xu0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXwGyR4q; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3E/jslnq568lIXr1RHFQ4heGbZ1dbw/jYSVYgE8kqw=;
	b=dXwGyR4qw6xlhwShrrRLocyNpS3JKKBB748aO0Yr7w9EnBzbixYMt/k1rY0jugp101Pdj5
	9ho34v23h0q8OjNq6WAC9nTZvuqC7gpi6+z03cdA/64eKRpqgRJmTMLRP1tI+hx4n99NtC
	mOf/VxUV/l4iqMEXfHeTn7iiq0l7eGs=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/4] bpf: Reject TCP_NODELAY in bpf-tcp-cc
Date: Tue, 21 Apr 2026 23:58:02 +0800
Message-ID: <20260421155804.135786-3-kafai.wan@linux.dev>
In-Reply-To: <20260421155804.135786-1-kafai.wan@linux.dev>
References: <20260421155804.135786-1-kafai.wan@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280181-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[27];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1854643D0E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A BPF TCP congestion control program can call bpf_setsockopt() from
its callbacks. In current kernels, if it calls
bpf_setsockopt(TCP_NODELAY) from cwnd_event_tx_start(), the call can
re-enter the TCP transmit path before the outer tcp_transmit_skb()
has completed and advanced the send head.

This can re-trigger CA_EVENT_TX_START and lead to unbounded recursion:

  tcp_transmit_skb()
    -> tcp_event_data_sent()
      -> tcp_ca_event(sk, CA_EVENT_TX_START)
        -> cwnd_event_tx_start()
          -> bpf_setsockopt(TCP_NODELAY)
            -> tcp_push_pending_frames()
              -> tcp_write_xmit()
                -> tcp_transmit_skb()

This leads to unbounded recursion and can overflow the kernel stack.

Reject TCP_NODELAY with -EOPNOTSUPP for bpf-tcp-cc by introducing
a dedicated setsockopt proto for BPF_PROG_TYPE_STRUCT_OPS TCP
congestion control programs.

Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 include/linux/bpf.h   |  1 +
 net/core/filter.c     | 24 ++++++++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..cf75da8a12bd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3725,6 +3725,7 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
+extern const struct bpf_func_proto bpf_sk_setsockopt_nodelay_proto;
 extern const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
diff --git a/net/core/filter.c b/net/core/filter.c
index 96849f4c1fbc..1140f4b55ab5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5688,6 +5688,30 @@ const struct bpf_func_proto bpf_sk_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sk_setsockopt_nodelay, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	/*
+	 * TCP_NODELAY triggers tcp_push_pending_frames() and re-enters
+	 * CA_EVENT_TX_START in bpf_tcp_cc, reject it in all bpf_tcp_cc.
+	 */
+	if (level == SOL_TCP && optname == TCP_NODELAY)
+		return -EOPNOTSUPP;
+
+	return _bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+const struct bpf_func_proto bpf_sk_setsockopt_nodelay_proto = {
+	.func		= bpf_sk_setsockopt_nodelay,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_unlocked_sk_setsockopt, struct sock *, sk, int, level,
 	   int, optname, char *, optval, int, optlen)
 {
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 008edc7f6688..791e15063237 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -168,7 +168,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 		 */
 		if (prog_ops_moff(prog) !=
 		    offsetof(struct tcp_congestion_ops, release))
-			return &bpf_sk_setsockopt_proto;
+			return &bpf_sk_setsockopt_nodelay_proto;
 		return NULL;
 	case BPF_FUNC_getsockopt:
 		/* Since get/setsockopt is usually expected to
-- 
2.43.0


