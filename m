Return-Path: <netdev+bounces-247378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CACF90A5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D935306E58B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1333C188;
	Tue,  6 Jan 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwAubXcr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648FC336ECE
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711999; cv=none; b=J0JNBG0WwbUCKdNYlxmlYSgQWpMNRq8W+gcmHDJFTsUhwrWijqlLM/7+hC6308pmmfI5OvWwx5hRECRmes8oVwQUlz5MzyLp9X37NXdKW45vLgT4zhAcJWMeubIUjUsKBHMat9GRUOeGEKQkfn0DRc9FufsSgwx5CYVeP/7I008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711999; c=relaxed/simple;
	bh=Wlnk/11G9FNLpYzC4qc1aHujvRCSLXLDlxsPxH2TQqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihl/ak3nRdV3+2uky+TZiCmLqd7OBgbAnu94NSirSzareXizSm0YP7A1S3V/471VEHxtJCe73cYxNFAPGsOjObjqRABPAwk9zV5aL7Exu9DpKmf2jpR/LyQeM2EARYR+ncJEkuCkdoL+4b4suweO11XkOFNYynL8NuPFnpMJVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwAubXcr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc0f33998so11299667b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711991; x=1768316791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VesORcM4qYIh/AS4ROzcX+TIK5RLKNWV/oYtlzx/zN4=;
        b=VwAubXcryzDjcLBxvCHp4wdwixZ02kQwl1UgMXibe12ifytkQ3u/4snlbdxIy+buV3
         Xzg8dIPOwGgawmIkvdqeIj7y5IMKyAw/RlimvpBBnc9AQNO2W2k3U7cHD3K3aLJAkFdW
         jDLrDWED+grw+6w98oDpluXtmojz8MnNm3lQTYcnloI/zIWWPvd7PcKCmjMgYJ4AzNLk
         xKu5oJvHQThaJ42OJd+TQeR45GfNiKL5AAJGyeHSxnMcfiiqbheTQrs4EeZ/biyfz8Tk
         V1IFe8l8xOiGiEQ+4E6BrhitvLhUJ1MBkdtATGdQax4Q8svQ4qg5TASQ7HYM677nDBhx
         mMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711991; x=1768316791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VesORcM4qYIh/AS4ROzcX+TIK5RLKNWV/oYtlzx/zN4=;
        b=q80wiZTqi6sgI6rwcFeb+MHNj7dd9mNK4eQdOIXtrxKbKjgrawkmwkhySn8upyzOW0
         GMednNzDKREWMoR7Z/LPPlwBITAxlU3iE1JBlMoHTwUQMBDOBK3zT5IjuKzNpGQZf1Xf
         xO5zr40Cv7gdsxAJkXRTFf3fhYpsW8USynVtWaft6jX5/etpMLRCUDlg4Kp01PcOd7C/
         tVTUSw74RCKDYMdoTLcMVHGQlCHZ4cM90ZNYKqJI6gmFnlGWSldQqXJp4auqKG0G9SMM
         TFxKRELh2sG/KrlE6jN1hgpjmJY1lO+W3/TIMb5vdzWE1o/R5XsdnDIxYxb9JK08o0X4
         TAdw==
X-Gm-Message-State: AOJu0YzWSI+vmCKIOZhezcu+BhD0EXHvDqpTysUnpvWx8NB4PooB3Tq1
	nEW4qxoa4G9tKA53JSJkyYbgLVv0YfUSHDRKVcnGWwIY4MA7uWRzHjwKmH6Mxg==
X-Gm-Gg: AY/fxX59CKALMgkJor3pflVIho7hkypaCT+g3l4WPvogaeEDhegSR8NEa2yoC/Kod4J
	tCEgbDx62brSKpm9J9hWyFuP3riPKngtuN1n9plufMQIrmMnhHpNAxi9nBhtwlcvVgDCfJyMD0k
	+8+vUZy1FQwNk1VesLNB0IbnCQhpEjBt3aQ+bXT0zz3PLP/2L5rbNlkbJPQxmEjI4XNtY9v7HWB
	zgGG5gZsmNmneT2hyFqI6lom3pEsQO5zrlGVlLiWT0Uj5n7hwMKIsGv1FnOfPqbSXXVi+pCJMsB
	h//QVkQ8As6e6YMoI/0IZDV05QMeMg5mProzv9nvT4tEf8qxlKLeQTF7zx2d9j5Wc3x4TzskLwT
	OYBaHI2PzIvIVDDn4Q+DKBw1JVj1qOsfew+WHRjaDUmJ/cluf/Yqsh1IpIJC0sHfEygh6aL59Z8
	YfeSY3rQ+8lY+A5MZr6Nk52YpYHPwoJV5tBc9ULfz0n595KTiRTJ9+iH72c3Kus6jkjSoKVX/3Q
	N+T4hNDkQ==
X-Google-Smtp-Source: AGHT+IGAPg8YR5odC5J7num/W2k21qmHdtRj/ssaOtbsGIAfgwQVFfKU55O7ciz7iIN10EDoMHRQkw==
X-Received: by 2002:a05:690c:3602:b0:788:e1b:5ee6 with SMTP id 00721157ae682-790a8b7a313mr60498667b3.70.1767711991309;
        Tue, 06 Jan 2026 07:06:31 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm8142177b3.41.2026.01.06.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:06:30 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	axboe@kernel.dk,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: do not write to msg_get_inq in callee
Date: Tue,  6 Jan 2026 10:05:46 -0500
Message-ID: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

NULL pointer dereference fix.

msg_get_inq is an input field from caller to callee. Don't set it in
the callee, as the caller may not clear it on struct reuse.

This is a kernel-internal variant of msghdr only, and the only user
does reinitialize the field. So this is not critical for that reason.
But it is more robust to avoid the write, and slightly simpler code.
And it fixes a bug, see below.

Callers set msg_get_inq to request the input queue length to be
returned in msg_inq. This is equivalent to but independent from the
SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
To reduce branching in the hot path the second also sets the msg_inq.
That is WAI.

This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
SO_INQ unless explicitly asked for"), which fixed the inverse.

Also avoid NULL pointer dereference in unix_stream_read_generic if
state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
implement splice for stream af_unix sockets").

Also collapse two branches using a bitwise or.

Cc: stable@vger.kernel.org
Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicitly asked for")
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Jens, I dropped your Reviewed-by because of the commit message updates.
But code is unchanged.

changes nn v1 -> net v1
  - add Fixes tag and explain reason
  - redirect to net
  - s/caller/callee in subject line

nn v1: https://lore.kernel.org/netdev/20260105163338.3461512-1-willemdebruijn.kernel@gmail.com/
---
 net/ipv4/tcp.c     | 8 +++-----
 net/unix/af_unix.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f035440c475a..d5319ebe2452 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2652,10 +2652,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	if (sk->sk_state == TCP_LISTEN)
 		goto out;
 
-	if (tp->recvmsg_inq) {
+	if (tp->recvmsg_inq)
 		*cmsg_flags = TCP_CMSG_INQ;
-		msg->msg_get_inq = 1;
-	}
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	/* Urgent data needs to be handled specially. */
@@ -2929,10 +2927,10 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	ret = tcp_recvmsg_locked(sk, msg, len, flags, &tss, &cmsg_flags);
 	release_sock(sk);
 
-	if ((cmsg_flags || msg->msg_get_inq) && ret >= 0) {
+	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
 		if (cmsg_flags & TCP_CMSG_TS)
 			tcp_recv_timestamp(msg, sk, &tss);
-		if (msg->msg_get_inq) {
+		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
 			msg->msg_inq = tcp_inq_hint(sk);
 			if (cmsg_flags & TCP_CMSG_INQ)
 				put_cmsg(msg, SOL_TCP, TCP_CM_INQ,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a7ca74653d94..d0511225799b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2904,7 +2904,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
-	bool do_cmsg;
 	int err = 0;
 	long timeo;
 	int target;
@@ -2930,9 +2929,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	u = unix_sk(sk);
 
-	do_cmsg = READ_ONCE(u->recvmsg_inq);
-	if (do_cmsg)
-		msg->msg_get_inq = 1;
 redo:
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
@@ -3090,9 +3086,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (msg) {
+		bool do_cmsg = READ_ONCE(u->recvmsg_inq);
+
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (msg->msg_get_inq && (copied ?: err) >= 0) {
+		if ((do_cmsg | msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
 			if (do_cmsg)
 				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-- 
2.52.0.351.gbe84eed79e-goog


