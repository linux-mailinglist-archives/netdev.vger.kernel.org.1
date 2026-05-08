Return-Path: <netdev+bounces-285691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAdSE4CS/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34DB4F3145
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F8F2304509A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666037E303;
	Fri,  8 May 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCZz6xp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984333F589
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225662; cv=none; b=XvLbbdlIcD3N0Uuza5Ua4fN8xOePyV24G7++o9DFgfV2hjaDSrFHv+n54tEV//iAVNSNCF0Y6GO4PzEzyu+Gmxzpm+LKM61BNkv2fdI0Qk0hwgfRpa+AHc0/MkwR7LLkVPsiACds223pyPuN/xZ0zU4oa2ih1LbWdrctK0K/Jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225662; c=relaxed/simple;
	bh=tqQ2jM2Q1BOqOxu106kkyWAq+V16GOqtJbI3zSEMUxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7jQz0cv26Bcf1gF/KmdiWN2Cte3mFC84oATC8f9wiJOmo5Q5XizcFduTe2Skd9loPPQvNiQmFxiWsQjWtMrH6x0eXkiOvrjc305u+HdO7DX9VBZ+vRcJ6hZisAQnzH99imOzrtLg3fFk585hxQW2cRqC6Lxac48Y7Fok8rn6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCZz6xp0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso906231a12.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225660; x=1778830460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cT+UqQxZ+SAP7wyj/Ie43+g5JFp+Cz/745zVAjBum4o=;
        b=hCZz6xp0cJDm+4dRl8t9eIUZSyV9RbqdmHZbJT5U8frC6b0lsYZtLWGzH2nSulkDc6
         QtDqb4FyXVv4qcVcEeFQjlpL306X5ss5gpncgfP9m/DNYfwgTAluAO5oRxqzN5YJGmZw
         G4Oi/uPaEuN+atQU8eh7LzJ3QTc2BU9zo2AZJx6S002xMPnFkNj7QzDyPTCPRYNC39Wf
         rElfBc2kIDj1iB9lin9tf/cVm12C6QZ+Nfnk/Nf+RcC2zLtal39+vhv4BpmQNcVw4kV0
         EsKqxa82VVHo9N2aTrlfvTKTzPfx6EOkPEKXCL31yCkxMQesl+JYduLCPt1HzxGvMSlW
         V1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225660; x=1778830460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT+UqQxZ+SAP7wyj/Ie43+g5JFp+Cz/745zVAjBum4o=;
        b=MOmNTQfzEYBgMUInQXMuSYU6Hh1oN7NhG5onHKaDUuw5QQfN5zdgRKagza3dAUkQGk
         I0WJii+y3S5GTsJ2QK60hprW1Gq1EebN2a6ce36R4HqaLmt5RrbD1jLRMERtYde9G+GS
         X0Nx2jor+1/kgMyl8RxDi1ojj5TD/Kbix2V8xRISzS+KjFjXmn0YPIKVhu/0OmQRtrf3
         7PQteCUuB0GusEzYH0enI16/Q0hmkmEj7K3uPqLhyTLnrxXE5Dq1NfntGGuWJLH0kGUc
         BzQ69rzsye2lhMjyChqoK0siMhl4aIJEBHTH/5KalQERy9Sgt0BZrRAIO4JOyUmPuqIb
         aNLA==
X-Forwarded-Encrypted: i=1; AFNElJ8PeVgUUqEXWiRIw2HOPDdYwZ1Zl0qrWcf/IcLns8h9Km/QWWyzj0dZ6+TxcdNrBJ4dfk5iSVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJ3rHjO+9YTbah/qBJCDUDEA/S+ucsDfLPu2uo4x7K6a/UE7p
	Gd2HO1J1805+uF7jv9rVUP5OW1uTNjnhESa6u+YTVsfWRRCm7Vbdmmq1f7ct3zJujgXJKhdVQKS
	bsHH4Tg==
X-Received: from pgbgj3.prod.google.com ([2002:a05:6a02:4943:b0:c79:65ab:b3b4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2588:b0:3a2:dc51:44e
 with SMTP id adf61e73a8af0-3aa5a4ba895mr12027517637.22.1778225659928; Fri, 08
 May 2026 00:34:19 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:27 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-7-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 6/8] bpf: tcp: Factorise bpf_skops_established().
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
X-Rspamd-Queue-Id: B34DB4F3145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285691-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

We will call BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB.

It requires a similar setup to bpf_skops_established(), and the
only difference is the skb data length.

Let's factor out the common logic into bpf_skops_common_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 021f745747c5..7e26503fd96d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -179,8 +179,9 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 
-static void bpf_skops_established(struct sock *sk, int bpf_op,
-				  struct sk_buff *skb)
+static void bpf_skops_common_locked(struct sock *sk, int bpf_op,
+				    struct sk_buff *skb,
+				    unsigned int end_offset)
 {
 	struct bpf_sock_ops_kern sock_ops;
 
@@ -191,12 +192,18 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	sock_ops.is_fullsock = 1;
 	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
-	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
-		bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+		bpf_skops_init_skb(&sock_ops, skb, end_offset);
 
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
+
+static void bpf_skops_established(struct sock *sk, int bpf_op,
+				  struct sk_buff *skb)
+{
+	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
+	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
-- 
2.54.0.563.g4f69b47b94-goog


