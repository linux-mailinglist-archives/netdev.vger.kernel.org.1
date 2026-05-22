Return-Path: <netdev+bounces-290712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HhUHCUKEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885C5B02E1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F704305F563
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76C3911CE;
	Fri, 22 May 2026 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quU1R9h8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66B346E7D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435986; cv=none; b=hz1Z6jSXzr6o7SzdW3r/porIzpC+nGmKTXwQaybauNnBXfE+X6WuN6BbuZjBR+9b/jWkdrvoHcPJnE2cXoTQjmsddQ4CRu0z8Jb/w+AyYk1hrOGIbVPbumvbvDM7c5QTElk+Zh0Ts/9HPJJdMsXmk7kLVjbFj/tpgDcd1m+DLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435986; c=relaxed/simple;
	bh=dc3cyu+G96Uz0mDs4rxrvr4WW2uo7W5uvC1JD1XZ3SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlUn/6FeGZnbXnlapDQAVIVCTeXWu0w4UlsPfpoVGVALNl4fFhxkSkcqKycYpAMfHD5j1mDkZLGPCec/s+E9k7bKbqtiE//3fW13vp6fgpb9vfe1jTUGi6xmrD95+FKZRUo8qT51CpwsrzvfZf28C8cZV68F3LCYx2oq3MyEqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quU1R9h8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so70946375ad.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435973; x=1780040773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=quU1R9h8YkiXnbJ5Aov05DDXZ8WitU2kE4VXWfEnYj2mYKwzKLQCJfVAhvyDvi6AST
         FStpBjjQMrWvRy41ZccKcd1YAnivAmrj9IE1wI8az8VXm758gYEHhbfnl389o/cHPTmn
         wahROzd+QwkI1LRmqpCS8hXc3ufWsb9P9Yd2rFTOTddDJ6FwbzJbjUkxJRbyhd6+1Ong
         atutJRL8oSiPwDazqmx8ENhn86sS2ZPsVzRTtFJVJONVHQOrY+rjibCOmZ1Ikd5dr2SC
         /1bdD2FoGBbzFOyqS+16pNSWZVXmEve0I3bgtYDTsFw7AMXFaAUt574+vg7Z/2ErD2pI
         1H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435973; x=1780040773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=j21ohRV3Pk6EMZc92cwIcLc28HAVFo2n3xCPgNasHDmY9T+qSlkOgIUxvIzXdB2k+M
         XnPFLkTqFBrE20WXfT6cq0mdd+AGLpWM5hOHu7rZXMQ97YNillB2Zh0fQFqu5vejQ1Jv
         Tp7n8z0BxAd7USpFFZEjk75bnV36nw9615O6kCdcNiyOcjp31fG880VRG6eF0yBWpYDw
         E9/vsUNEaQOCsLghyq/bMj2hzY+qYBo7ryMRJce/kOivivdDyjC6rwAG1OgEY7PcSWUU
         1fgn7AjWyiBfL17yGXBnR3PeiBbiXsvFl/WkMM7sN9NaAwmenRddP/WkVc0NLTgDVKeD
         jkGw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZD6bjb1/vokt38VAFALB3ZksefonanxMtKNoCALoRsSWnoWHGsAcL70BfQM24jH3B1ySpLno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/igr6XCnfFIjJvcr1UKvyPQ4q2onsCxQ7luAn/R5igNjyYo4f
	bzydJLAHiRVx2CWmyiJte9TIn1gKZPhLGhJNhOEQ2esPvAIzbzZ0uhV8duSkwEo/K8MiFLt3Cqz
	FtSa+aw==
X-Received: from plcd18.prod.google.com ([2002:a17:903:2092:b0:2b9:a1d0:9f13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffce:b0:2bd:d97e:724c
 with SMTP id d9443c01a7336-2beb07498dcmr24548155ad.13.1779435973127; Fri, 22
 May 2026 00:46:13 -0700 (PDT)
Date: Fri, 22 May 2026 07:45:00 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-10-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 09/11] bpf: tcp: Factorise bpf_skops_established().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290712-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.812];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2885C5B02E1
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


