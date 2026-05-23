Return-Path: <netdev+bounces-291066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLaBOLBlEWr7lQYAu9opvQ
	(envelope-from <netdev+bounces-291066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C53E65BDE00
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95F553013B86
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370AF34E777;
	Sat, 23 May 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGMSU+++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1435E94E
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525021; cv=none; b=SNmnJ1votj3zGnpnp2KTls4nNWTx97DVK8mihrf7FyAPtUanL6jKs+7c7E9Dl1OTl3L5LJ6oD1N/+gO6emdHKbBFbVz2zmyhMmT82naoYHWvqWGW269GIXM+4e+mUDotiiWCfC0oM0kYtE4HqT5KYM/on6AOY0dLc1UnCl6f5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525021; c=relaxed/simple;
	bh=dc3cyu+G96Uz0mDs4rxrvr4WW2uo7W5uvC1JD1XZ3SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2jVzPll8ObPRiIhPr3HCP+MwUGZzpIfGUj0P1+tHPz8nMDDHF9tumgXjMoOI07Iuzm8D7bsgj53HiT/iAcdeWXJI9O0YiohF8TTQPEEkDdGGKxT4oVqNT79A4uKeTNFv+0W0+aYulkPEQZoqjLsNspbEY1sk7iWAHeM/RXS6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGMSU+++; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso12306364b3a.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525012; x=1780129812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=JGMSU+++G9d538s0e/IdGl1foYSqEJ4RwIVFrQXUeP4HivwYdYlp8kq7vlifm6K/eQ
         hAiWJp7aUYJj/Tlf/DL4i8o9jX/TS3nsllUVeOe/oYdOacxIfvr88E0RRV4+vj47Pza+
         sLS0lqzxBvwd1urXvHBB6QUYNyHms+65rowpfd4JI689HNZeuIQPu+tSfmHTSQ5iUW0T
         LId2XmDq/VkJ2/inj/JfF6s6bTsA+iGttyL6z+uL7CjApLsafV8sLqFPLLecWnn45Qai
         MJVZbkjNUCC6GmVO9Gou3xjrS6SKSprinM/sQGzGxas04pNzs4c+PkkxRrMc3Js0LWPc
         zS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525012; x=1780129812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=nXUjHmwEyeiQN+BwKEhYTkygnRICMOguLL24lYDwUaaUW1e9TwgECCFdlJ9p1Y+xaA
         +wDrSyHlcHQZpsdi3D8vVjQ0HABfg3yaAfThyVjVq9U55gMeJba74slmVeRwhFtZZiGY
         x1pzKDdzcmwDqb9gMv1q8C078hT+8Xx2Q70qdZyWgJ5/rnrLJHiukv7/K7v+xw6l9XK4
         oP6NVlAJphavyQf5rVv2njUZwd82mbPBWUv8b/tp5eeeBoqjP8Q8Lf7Dkwl+RFwdp9TR
         DlJot3QQJhExueCRXIalqglk2MNB+82eG/bjNdTfGOAzZGnloj1Pn5qfBUp2x4kei4+u
         nLJA==
X-Forwarded-Encrypted: i=1; AFNElJ+Tu6P2M9T3doB0x7kUyao7ERLWGZr8k3ztGYjOZgNmhgZTmEO3jfPXSI2vYhvaWXvxJEPMgnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWdvLXiajHT+rPTTzkxwig9TKIUcyUvk5zPaC6NBZ/lMgRlJi
	THRDqG+KHsuGKul/aeTVf4gI7oeVTj8+oVUhoDHDjSaYpTgr5OWiB9g3uTuhiFxvN1WBNfn1Qvv
	79tRkQA==
X-Received: from pful9.prod.google.com ([2002:a05:6a00:1409:b0:82f:b53f:40d7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1789:b0:81f:5037:a317
 with SMTP id d2e1a72fcca58-8415f15a6a3mr6389881b3a.11.1779525011515; Sat, 23
 May 2026 01:30:11 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:38 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-10-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 09/11] bpf: tcp: Factorise bpf_skops_established().
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291066-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.817];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C53E65BDE00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will call BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB.

It requires a similar setup to bpf_skops_established(), and the
only difference is the skb data length.

Let's factor out the common logic into bpf_skops_common_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..c4ba4f1e9d9e 100644
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
2.54.0.746.g67dd491aae-goog


