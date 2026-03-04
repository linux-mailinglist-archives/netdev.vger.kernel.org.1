Return-Path: <netdev+bounces-263763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPuZI5YUqGkonwAAu9opvQ
	(envelope-from <netdev+bounces-263763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E41FED51
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB65305D6DD
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED73ACEE6;
	Wed,  4 Mar 2026 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJP51iPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9E3A875E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622930; cv=none; b=c9VkiJTLzvaAll+fVlkZxOq5op1KxEmUhv6Buuo4qvV1eVFgHUgl5VwVlJORLaO1cwEdAoXfe5OVd9gSWOrUhJEGwaz492XdFWfy3YIqavguErbuslmXxjNq+bc8IAI4RYZfiPR8PxUdO3bG5suZPeiUq2UFBH6VIZRz3n9Dptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622930; c=relaxed/simple;
	bh=Fm9MITMvzrN1bUK+Cme/hMncR+Mx97/eQMgmDiY3OnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnYeLOvsxrWD932BfcKnpCdd8HP+TRNq/jnEjEz/d9e/YqZdawBsQCnO36GpSWFsNV3nIpodtOuo7KzIeQ/FIltsXiq980z1f+oW9ddsPDq1zjFncnzvfNyL6ToiPOFKEGnQaH57UR79EFxP+8sQyvFKj8Y7TNDMLwWLH3CevUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJP51iPG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70ece855e2so2756052a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772622928; x=1773227728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=IJP51iPGjup+j/RGhv+o6t42qfu8tehPxMqi1B2EJ9w65puYXEZ3RozxehdAx61+z8
         EcuMbbIPDgUJIy8ez6gaO3EuSEDA/Sqa+UhNC+DbIh6q0m1Rilj83NYNADMN6z8hI2+1
         r5axXNN3TRtY8hX+uVoF8VJuwNupY9S0v0RdNrvkX7PNBk450TOUhzAUhGcwx22jAaLm
         R2fFGENWHr9B7Bi1Ear2xECBMBp1y1YR0zNjoPr41zJsQ4gP4eCEzOtTaVoZZ7ZwvLro
         fpDklSkafcdmaM3nw6dSkG+BLmYK5cYGYXQRSj4Cm9qx2bKjuPo/Zz4/qWRXBrquZ/NT
         qPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622928; x=1773227728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=NGAvwWV5mPOR1iD2J8I2hn0TsuSDPmk91GhDLQf4n4IuOH4PnQ9WBKOES9UjLj8sE5
         5H0RE3IHRq0UfLw+TOg6OFPZPfWHdIiZPXrJ+UMVgPd2T7egBuk5iHU66ZS9lQxCFCGu
         o4Ons9iiDAEAXVl+Gt1pekPfuJVJC6kMFUamzlBBgyFktwGQfHO+tg/q5+Og0MyFY34j
         d0ToygercJHBjfocqnYnLqvIBMyFNZR/aoZH7ngC8zxyLTS4AO/5qxcp4kb6/Cv3CaZP
         BCzJZ4+PK5yiSBNTs6wXG6mxWdQgolnCGEfjiYNfCABs92Fmv+DcnExaqmnFQiJeZVOY
         cWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQyiNd7NG2SCdV3tREy6zApeSbsmPAq/feZVmEzyH2EL8CWn9Q0cdoy1hf3zJLawLCqeG7uZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytemKfA2HIYYBXUJ9NwUvAwHW6yCNlWeCL/dk706ccAPreClMI
	rSSTnXzIPz90ZAURiVDnjEdaoNpTCxgzeuP3byqAdPEUCZB9VHUvqZd2
X-Gm-Gg: ATEYQzyd34D6oKDZFf1DAWdbJwQfKp+ApRxpU9cS1WmrDJL0vaYROKH+ovckc7Iz8bN
	tgO8rox9A5YFfru/rc/QYuKKxOqa4o6A0NJ2lagd1OjrhSikEWgKBlZIDbxF9GSe9ZTwCw+g/Bf
	gC0QuUEi5qdKPtJehBaiyzjFXRM7lh33wJrrgLFiL7xZooy++RB9ni+vj0G9H47OJjFjfyxNLTl
	VGgLNsOmVOKsuNn3alf/iYGZXisaXM2C2aaKEmvn1iJiTCsOWWv9uBUPJYyrxt4GLajZk8BSCak
	LEBFepPnUxs1R0HBKBhPU/ZAI0ujBzZipg0mUNR2Rw+Hd6SvwFn43ah9gXmrGZ4fhfp6qG3j9Yf
	QmHOkwy8C1dskLBlaXk1PqgVYngsA4+5PdMgkbHEZ9pKhi/Il2389nx3fggo8tVfuYVKgH7ivHo
	Zt4uJ2au6nT/vtchC3EXVBnC5tekAMifXlTpdrq6R4irU9x5lTcj26VKhM3VMR1tJEkq0OR+Sfh
	UUxZoRIswll
X-Received: by 2002:a17:902:ce0a:b0:2ad:b213:feba with SMTP id d9443c01a7336-2ae6adcbc04mr14171985ad.5.1772622928153;
        Wed, 04 Mar 2026 03:15:28 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm127226495ad.44.2026.03.04.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:15:27 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 20:15:17 +0900
Message-Id: <20260304111517.2088694-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 029E41FED51
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
	FREEMAIL_CC(0.00)[google.com,kernel.org,cloudflare.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-263763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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

