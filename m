Return-Path: <netdev+bounces-266516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJOIAuEisWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:08:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F3F25E9A3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC86232C8340
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF553BD63B;
	Wed, 11 Mar 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4OdtH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5273BC676
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215803; cv=none; b=HrUH+Eti9QcsZiFwhlzVrlHxb8IGNWYOr4+W0EGKrP+iGbV/C/5hP0qcdEaod6rh2aD0tkzLchpBDfafBt8zpgXoIskxBWIVN72PWyh8OF3DYdr4xMwE81p4KzUHyLZj4xpfWha4VTvM0nyVjlWW1/xTHO782A/ZSQUnFkv4bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215803; c=relaxed/simple;
	bh=9YrqMac2RvVbcQMvhIkvAs6CdxSyWCSfXy/rvRlKfmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+MWM4Ln1rWq89dSnMrqbyLVDGowXM+0Gwf6XjdNEQAy2XriKC7moqFLcUz7o4JYJmvcZd0flq9HsWW/DT+wl33HQg1n91d2+gbTsK9p69SSQ6nD1i0eZyMk1HYMgfjygYqpW+6S0mVYTpQE2MzVTcRLZ4OyttWfU6RHPQYlKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf4OdtH7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-409de4132b5so5818904fac.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215797; x=1773820597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=bf4OdtH7dYvZH0Pm5BCE0v6Kyxgrqcm9ifR02nbDzdUgjo4ncoo7rOA6dUpoXbNOjl
         Cf18YTTMviUOYlpP6pO4GkC9utn3BDvSRM18341vKYC+if5y93YQ89ulI/GZlVhEIB6I
         3RamUOhKpNPdZSdRSvU2vlG8WmcwO1I7w5cF6qDNtfbNMdWux7C4uOrzuWX9CE0Ms6oz
         EsIgclWrrW399y8mn/r12uYJRC4B+2LkZRW3YmZs+B6OvsmEDFFOHblSC1kG0ETkG/AU
         BzCvlhugDNX1fI/4IROI5CgS3sv3hosqE80Lk9ZkPMPB/Uo1ROn16Qfz4CiMFrDCA2k+
         BAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215797; x=1773820597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=a8R8wXsiDy8nRH6PB6V3rl728kN+09dcpgc9vAg6yhunewoZQxMhvYoILvwS1msKYu
         oaMULTIgcVqGQ/rhpbhYp9ZmnW+hBkUXQKdji7pGtnhSTFaWpwc8jgcljWsagWRel89T
         B5FxYQ6N+xXmZ4ykanBQVidoj45cCuloocsD0rIMErUZpzKGs/Tyo5YEQeneI9s7CF7A
         Ao3glkY9eUT1yue+gx5mvTkxmDCr+E2voEWikddQcfLF6OiKRAdy3PX1yreEaObGBCBS
         X90Ce9os+mxDJb/0kxq5RFHYcpZxZt8bHfq6Ewuaf8k4Oi380kFiXm42YpZI5nR13Uu6
         uQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSf2lbzZfmUPnD9NcL3ci5ytzC+Cb2T/1pvd5x/YJwC9i1vzrvTs+l5UNjZIIX/uwtJfXa/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/8Elr81NaYbaljmWwYzzSm/XOpiDPyFu3d8M+DraLA3LUAP6
	S62IcCNgnyJYJxKuxE/d4Gw0CFi7JZyrqvX2Dlq3P4A+MnaShyhibccXFKERDGHu
X-Gm-Gg: ATEYQzwmeK7aUPqyD8jn938oS1gEF+I52YTU2tv6hqnosT+/kXu/WlPO2IH/sJPHKFh
	BM5UnMYjTywl5hHFBM0PlnI7PnXCdxRdhqusDlbIhus0mTntfpgwFhkeXPcdd+gboZRQnnqhV52
	P61xG6CIV2W650ksX/6EWx2q6iUj5cNEuYVAVxWcXEXeTYgIwmgQBKRCSQU0PFvL7UV1owaPN1L
	KefwLYEaZyzrk+UynPD4dQhziMqckid3N982BfWcRQZajU54RkFTuZKqg1zrox/KQj3/Yp8c2fY
	9E1BrQZ1YvCyolqxiHzGOtypV20rjF1IRV8bJOHlrMguBdRWKIkJAR2lgjNw4l3miasyXQ9Xueh
	pSpa8c6wD3HxXH7OlWDlsUpdrFqTXHxpMWH1OoEflAk5juooBOcl4w+oqiAXJIIEIRTxK4MV/SU
	67Zz8HQBt6F45rM6L1BOFnzO5s0hBV4LGkJZT8oXd94iWX9UrKeh7c10loAKLkvwGtyFOg8y278
	nBiXCyoV45rI9vgQOXDMRaWGUeuyo06mwMMDqSbO1yicUXJ
X-Received: by 2002:a05:6870:2e04:b0:409:7cfc:7392 with SMTP id 586e51a60fabf-4177c96b888mr1211062fac.42.1773215796875;
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 5/7] mptcp: refresh tcp rcv_wnd snapshot when syncing receive windows
Date: Wed, 11 Mar 2026 01:55:58 -0600
Message-Id: <20260311075600.948413-6-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6F3F25E9A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266516-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

MPTCP rewrites the TCP shadow receive window on subflows when shared
receive-window state changes.

Once tp->rcv_wnd carries paired snapshot semantics, those subflow shadow
updates have to refresh the snapshot too. Convert the MPTCP window-sync
write sites to use the helper and keep the aggregate receive-space
arithmetic using the explicit rwnd-availability helper.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 12 ++++++++----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 43df4293f58b..6e6aa084cbfa 100644
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
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
@@ -1334,11 +1337,12 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
 		new_win = tp->rcv_wnd;
 
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
2.34.1


