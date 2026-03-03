Return-Path: <netdev+bounces-263110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH+DHa6ypmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:06:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E363F1EC587
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB7CA30747B9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B3739023E;
	Tue,  3 Mar 2026 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp3LHtWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AA390227
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532290; cv=none; b=tpxf2xr681YnYiw3m7luln1eMHk4hTaZNOvQGeKCIhlc1aRHaiUbvi8kApDUpksKHtgLgLH2nel8NSlwjGiISalLuRYyfqv+LlL8OYTszBlM8OjEohzvh7CPgNeeHJ1SBS2CfHOFndQrlI8yn/nEhK91yiDXFPKKl8YKE0WChDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532290; c=relaxed/simple;
	bh=j8x8rSyHICY5qcHKtJbgh2Wkn2gcq92t1omfvouCwNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T18QIh3kX4C1Plqzmvgu8Rkhin6MquU+ha+VmsL83a6I9lrCsE8Wrze2lUVGau0aKFC471zIQ/ZIIAffk8kYMdqR1Ja8/g1qoknVJhXznLnZ+nQeBrFH5NjcZLAbRRRtAUy/H8aRSV3KZnTddYaKPLJRmc64MLnrV/iydIEv2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp3LHtWE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9516a653so22862825ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772532287; x=1773137087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfAHCrUtdxDkRhQeZ2MUII7KbpuuMok/pw78xOx4c/E=;
        b=Zp3LHtWEy5JRZlPE3D/tWYPg0dJztNAv2cZuWiNM+sC5ZXdDR3thyjofDAwC8uogeH
         ltlzDBS9Rk9XX2gxJqbUlciYSjDfYsZpfyvIvX3jyQEQszcV6t6vQldfaJi9a04mRGpQ
         g+IqbZtoedBfHGsj6CXHuEphXP0qEQENY8FDQOKIUr6NPbTqi9SlT2utpV9kdFpiIXH7
         Serl/WejCaRVQECECjn1fqAwXV/OWqc93B3j4tNpeMH6qbJx3FIz3Ek1nmuGtaj1hwyX
         2/rKfUqntNQdNHYplhxzLoNQ2H4JrAGMcLjFolrawycNCy58IFT242BZU0VJLRZG5pZO
         NOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532287; x=1773137087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfAHCrUtdxDkRhQeZ2MUII7KbpuuMok/pw78xOx4c/E=;
        b=VEFnPthZBzFK3lfU/shSXXMaGPOO6k7kJtZNqqrP/A83TuhtDEAsuvgnJx3k8JFbVB
         ZjJuqQiVBBO5VZCPxQQkqxXl11da7x5mU535OGqlF+flUlyRB8fPpt9jQ9kltPCpe2fl
         7s9cRto5fGAX9iMms5PXQioud8ZXAdmqWavPKkRQAbAEbCFqzd/WZDUrxDNeT64Sl0Wa
         QLB/YcmnUbLvfrpJnTUmbZpJxY3JmJBrMTFAWYVHPu9a6rI8ZQR1bF28kjbhW7kgSX45
         eC8jnD0RskEdnI9HRgxy7ZKZhMhXokNvtJh1S0ntb8JtJ3wleCBCl12roxZSkE/9GSW6
         aNZg==
X-Forwarded-Encrypted: i=1; AJvYcCX0WVQE4mFDd9JKcyZunQpoZ6q9zBXoUcuXKTfWBAIclFqp7Ill67kiqj0gtQBorFpcz/t4VJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXi8n6r6Tqr8TmGRVfZ6ux2Z0Y4o2V+6MJxWY0WxnVE18xcQ0
	MnxP5ckxGgpwb/XY7/FWGHWc3N2FDW6H/eq98WS5ba8W6EvAWduG6oed
X-Gm-Gg: ATEYQzwMQkQu9yMG+JAYFn+49hA1Es9fMlitOY5+RhaiZDVA3yf6pyubXqchKwIh8Mb
	wgSZ0EoWaTisSOXBMPahRcU667CE95dCNt3cCXqogoVwnWHiYwyHwOzs8V9OgRNAnncPkV8JE7q
	ZR9csx2nHD+WawsPZFn2EepUR3XSxyCeWLPs8JCKMAK7GEBg7BDeqDNtR1IBB6t5m84/9TM6O2d
	dnk2HEo+w0QGtY3bTp20uFTAhPsiY3A07UMMSD/ZiIXr3iQVQE0fA2UBuVFgPUeI6QngVsENFx/
	9LapMQq3i0CubfCH/NiE54a8/889fcs2yLK9c+UnCbnZZeeVmKyRBEkfojzzFt8PtDwGadVs56B
	pabnIWL8kynzFQsust5lb5Hj5SeGqr2WDRpYiHb0d4Gkt74+pwfvPS7T3VwKsmnsljJgqqrelRq
	pvMJzN1zxXViRjACFg43/94Rpuagk/4DFzWpCsvbGcOwehN/6YSF1k8m0pmCQ7aff5eE9ycQvrJ
	nAXyTFKIdAx
X-Received: by 2002:a17:902:c951:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2ae2e3e3e93mr154800025ad.5.1772532287501;
        Tue, 03 Mar 2026 02:04:47 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b5813sm166283095ad.63.2026.03.03.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:04:47 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Tue,  3 Mar 2026 19:04:39 +0900
Message-Id: <20260303100439.3172296-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E363F1EC587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use struct_group() to group the three fields in tcp_out_options that are
read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
(mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
with a targeted memset of only that group.

struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
CONFIG_MPTCP=y (typical distro config). Every remaining field is either
assigned before first use by tcp_established_options()/tcp_syn_options(),
or gated behind its OPTION_* flag in tcp_options_write(). This memset
runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
bytes to 4 bytes reduces per-packet overhead on the hot path.

Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):

  Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
  After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)

Also add opts->options = 0 at the top of tcp_syn_options(), which
already used |= without a prior clear. tcp_established_options() already
clears opts->options at its top.

Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d..63ee037f46e50 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *options)
 }
 
 struct tcp_out_options {
+	/* Following group is cleared in __tcp_transmit_skb() */
+	struct_group(cleared,
+		u16 mss;		/* 0 to disable */
+		u8 bpf_opt_len;		/* length of BPF hdr option */
+		u8 num_sack_blocks;	/* number of SACK blocks to include */
+	);
+
+	/* Caution: following fields are not cleared in __tcp_transmit_skb() */
 	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
 	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
 	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
 	u8 hash_size;		/* bytes in hash_location */
-	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
@@ -965,6 +970,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
 	bool timestamps;
 
+	opts->options = 0;
+
 	/* Better than switch (key.type) as it has static branches */
 	if (tcp_key_is_md5(key)) {
 		timestamps = false;
@@ -1549,7 +1556,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts, 0, sizeof(opts));
+	memset(&opts.cleared, 0, sizeof(opts.cleared));
 
 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {

base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
-- 
2.34.1


