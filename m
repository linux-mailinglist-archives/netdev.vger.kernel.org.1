Return-Path: <netdev+bounces-290703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAdPKc8JEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:46:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46A5B0270
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22808302FE92
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89938E13F;
	Fri, 22 May 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNKmH2JO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D439061D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435969; cv=none; b=KRK8TfoquORq2ekQu1V56ghivTZZfLppb3isblDqAz807EO9WfTUSMPr7vcPveBE6RGMgTSDPF2/fATzOIRx4xzMFjBlJA3poD2ZeWc71tBXNRkwjHbvVpRbK3198EKDGgdm/p+gQwntjk9YoKIjxQ4S32e9ZJERfQ5I+eV2TuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435969; c=relaxed/simple;
	bh=wpfP9iaC4NcOUpR4U8log0eGACMjzwD9P5ShdZk1/Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmFQy9IW3Fuq5UnfQVJO5efwBKti6N2xZpVzUPv0nGebAh0LoCrB/vlofHUaA4JXd/ilnZ0Hbg3YjO3EJEabzeixVMh5vNDoXGp9zl0xwq39PK5xw+m+bTeCZV+u353mhtjCNfUGPW72Siw27STH6or4+B3rvPVzhYP5iRY1V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNKmH2JO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso4056054a12.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435967; x=1780040767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=NNKmH2JOIYls7L2yMK16B+qiMBQ6oqhS3HaT7EYPDCsXvbBsW/fzAwdSCB0y32H5YN
         pG7XEehJJLxQpck/W6kow2TOxfp3SUK7J73yuhwgSP17gHyo9WgeKnRaPNLv5swp9PNR
         JpsdcKdXX0wbzTwepGcX8mrfozCr/5VlgTAhLWO8j40/Y0hoyRsr7Tj0UxHsArgHqcXF
         nyY8FEnj2wKs8J+72XcKvDYkDOK0+XvUwuBW/ZGuHplEsrOXwiojt7MDXmN7DDJMNBCh
         ETxPMu8Jm/ebRKOOzV1HMavKKoGpgeqJkhLE1Zp4GtywbuRsZoq9jErWYYXwBvlaNw04
         uyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435967; x=1780040767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=f60sjvG2JCL3qOBTN8QwLRdSeH7hivCPGobTjDbvzyYanH+HoMVC3WuQuxTztNmUfv
         ze+TEQXwBSZrHC8iz1L3p77YM3ufZ51Xp3K4mLeKb9Bl0wYbM1heUdNN2PCE83WL/acL
         VCW8wdO/VQvNjezndNW+txD9APR6VMIdOvgJkK0l2WvBqcpR0Le5DtvYtHAf7Dq6P0Oy
         l85bscw7uQZFPxKW/KUJJkRuojlHnE7ZgR7LvcAh9nYuZag5oE6JVKNIrTU4KCbnLX++
         PusW0IrGWiwQaWnQVAiDJvV8Ncpiz3hfQ958joZz84ojaU+wupgZHRAUZwH97gWISqSp
         v6Aw==
X-Forwarded-Encrypted: i=1; AFNElJ+2nVMl+e0qclnilbm5Lq1ab9ZmpONnMIyjhcoHDfkgy/zSiTmHsQCp3gpmDxpBECrETtqI4Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLobkxUUCesOwhbl4sHak9hJMC+PmcwwSxMmWKSTxUaXT2V9Y7
	ckpt8MZ0YuSC75Gr9lmSbZU+UvevHekwruLfAqcwpbsIZ63xNA916EzA3/vDGti1dau51EdJmy+
	+16LFbQ==
X-Received: from pfbgu11.prod.google.com ([2002:a05:6a00:4e4b:b0:83a:58c1:f5e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3923:b0:82f:4a4d:3793
 with SMTP id d2e1a72fcca58-8415f407030mr2837303b3a.28.1779435966826; Fri, 22
 May 2026 00:46:06 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:53 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290703-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.857];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5D46A5B0270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will introduce a new type of opt-in hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVQ_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
(e.g., a full RPC frame) is available in the receive queue.

Note that is_locked_tcp_sock_ops() is left unchanged not to enable
bpf_setsockopt() unnecessarily, but bpf_sock_ops_cb_flags_set() is
supported at BPF_SOCK_OPS_RCVQ_CB to disable by itself.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: s/BPF_SOCK_OPS_RCVLOWAT_CB/BPF_SOCK_OPS_RCVQ_CB/g
---
 include/uapi/linux/bpf.h       | 18 +++++++++++++++++-
 net/core/filter.c              |  3 ++-
 tools/include/uapi/linux/bpf.h | 18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..31130e1b63ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..4a50fe2cd863 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!is_locked_tcp_sock_ops(bpf_sock))
+	if (!is_locked_tcp_sock_ops(bpf_sock) &&
+	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
 		return -EOPNOTSUPP;
 
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 37142e6d911a..3b8f392d8c69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.54.0.746.g67dd491aae-goog


