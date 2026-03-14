Return-Path: <netdev+bounces-267857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gByMNunBtWke4wAAu9opvQ
	(envelope-from <netdev+bounces-267857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:15:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4828EC2F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ACFD301FB8D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3A388E6B;
	Sat, 14 Mar 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFW7KEXb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9C387340
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519298; cv=none; b=mzKCO7VAtxLw++s7dZCi6d37oENv6+PCwlty/3uLtGYjBUZWpfJv7jwFRfb5G8HXrqWuDB7Xe1UiTiZdN6mLBJdz+tiXeiq7wvB64SevPbFf9T4IkW2EdlnbmhF9UYZTC7f39VkVRQhcOYCioKTTO3sSSnXdz1m2nI9D3hJHpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519298; c=relaxed/simple;
	bh=dcj1s6Dgcrw3Y7tNOEUlJFcSNNEIPs4iabts40+JwIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htLw03m2OIKjPDTYlAqflLb3lsBdZbKzUr+eCk2cdQxBz80x70d9E1kPlRo0FvkSsoajJS6Qi/Ez5oNpEEMxDUoKQ/v7XlLJpz13WzMaQnMiWersJrypRA7lFDeKWT8UtH5wtYS+Inr54LaIYcHyIKoK73Zf1Kt7ThtlWhZmJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFW7KEXb; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d73dd9cb9bso2249204a34.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519295; x=1774124095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=mFW7KEXbx2xHzOcHzEC4+WerjZYDr6T5uY/8RXTxpLRLV9ogJJQlGWMN7baacQtjD8
         0w6nsnlYIhN/otPV6vVvu3g8yy/JiJI5mnP77ZdS4pQ8DJymo/PXbkmVocG9uNYovlLz
         4/5Ocjf42HImX3dEKcpcff1fprnlrROEXn3BA8jyNwI6LVH6z61MUT2DXpwnDo+NBHsn
         nfF8O5euOI/3LCSqq7X6hHeSQb2r1QurUdXyaxbvzNuljzDXVgWg9qd3mAn9NdJQGQsA
         VlLzjLF2EcJ5MOmMhrQ38lHjicLFQO9IiTLg2g4acWNXyaaQvZoGTL8TdOdq/eArIkf8
         QIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519295; x=1774124095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpvhfo9p2XSrc/tbQHeJ0/cabcWcjahm5y6siccjbzs=;
        b=dYM/a40EM9Yfs4jCQDkiFREYImhtCRKbhsMCFoEdYjt3SBxCr/9KtZqGQpyhgit7Em
         sAjX7zeHx1pkjpnIB0O5xZDAc9j39oFZJ/obOIaDUZ1iihf1n05YGGakdyGGOO9nJgDF
         Ct3J+vYHKDAhgw4PaxeSxZNYWsPiNIn+ymRbk1X3jl8jXNWAhSUNOYMIC0QYX5UU7szj
         7/u5iuZlidKle1L9ePkkCGwFKVG+tFOZvQdAD43fXOibaWgKSiBEptYWfUFlG7JvSL9D
         bOkEkk9ZLXIs+AY1xOCaonfRJMhxEj9QRXUlqbiDcN1mIkE733V1tej4vykeYiANBAJE
         dUiw==
X-Gm-Message-State: AOJu0YzoEacBX0x3pvJsLDT5+2zNdmDWdJ9Zp7BxtTMFDZzM+M84E5V+
	H4X2wfI+BaU8lXd688w+1Dk35nwYzGCwQdjXmwJBjVqoqK8WUhoEVjpF1xj7NCYg
X-Gm-Gg: ATEYQzyU1zjzcNvWiCq3b3cnI56rxgj5KDP7TNH2HLDjSSDZMz+mCL2v0YPhglBmT4p
	g4tDSRQHsLHd6g3WRQvs4pJFCI2GXqp02kgRffQm+y+Npz35Yssu2wYqy5T+9IPU0JJU7bTsBz6
	yV78amkgYQ6eV75UCS4TOlGkz+1xXmc4wlFBkmJLeTD20/57VAwFzDotC8HdxwN+dSvjPwfhRFA
	4TTL+fG+8GWm9U4Rj2wjzOJQQfq+wFNZBbM4wne4PE3WEBtWkcnPDkSPuDpB43IKDa8WERQuCzI
	nAIN1bhG20B8QVGm9HgfUuf0Gr5X+qQv2k+3aMGREHlSnS90o3KP2WTLKeJBPcjk2KoAYHqiGMm
	D1czfEHBtR7oCv1mOZXEGyiUO1PWkVJUQHcv/xDemtHX2EOzA45dxkeeQl6QQXZbaKnsSgXuObu
	FmvoypaoAcWb2jfpzO3pXZzAiYMahhQKBKeWRpUS61aj3oKwUXN52bSv4s11nTHnxfuZg6QW8bI
	N/lip6EycL7IJRyEPjsbq1DbMDQFExeGOAIZVvT
X-Received: by 2002:a05:6870:a796:b0:3e8:8b6f:9d85 with SMTP id 586e51a60fabf-417b937d46cmr4417226fac.29.1773519295129;
        Sat, 14 Mar 2026 13:14:55 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:54 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 09/14] mptcp: refresh TCP receive-window snapshots on subflows
Date: Sat, 14 Mar 2026 14:13:43 -0600
Message-ID: <20260314201348.1786972-10-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267857-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: C0A4828EC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

When MPTCP resynchronizes the per-subflow TCP shadow window from the
mptcp-level receive state, refresh the live rwnd snapshot and the
remembered maximum-window snapshot along with it.

That keeps subflow TCP bookkeeping aligned with the sender-visible
window state tracked in the core TCP patches.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 14 +++++++++-----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..64cd637484a4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1073,9 +1073,12 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 		return;
 
 	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
-	 * resync.
+	 * resync. Keep the TCP shadow window in its advertised u32 domain
+	 * and refresh the advertise-time scaling snapshot while doing so.
 	 */
-	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_set_rcv_wnd(tp, min_t(u64, (u64)tp->rcv_wnd +
+				  (mptcp_rcv_wnd - subflow->rcv_wnd_sent),
+				  U32_MAX));
 	tcp_update_max_rcv_wnd_seq(tp);
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
@@ -1335,12 +1338,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		new_win = min_t(u64, win, U32_MAX);
-		tp->rcv_wnd = new_win;
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
+		new_win = tp->rcv_wnd;
 		tcp_update_max_rcv_wnd_seq(tp);
 
 		/* Make sure we do not exceed the maximum possible
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..4ea95c9c0c7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,11 +408,19 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
 }
 
+/* MPTCP exposes window space from the mptcp-level receive queue, so it tracks
+ * a separate backlog counter from the subflow backlog embedded in struct sock.
+ */
+static inline int mptcp_rwnd_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) -
+	       READ_ONCE(mptcp_sk(sk)->backlog_len) -
+	       tcp_rmem_used(sk);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
-				    sk_rmem_alloc_get(sk));
+	return mptcp_win_from_space(sk, mptcp_rwnd_avail(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.43.0


