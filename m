Return-Path: <netdev+bounces-257794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDvfNELJh2mqdAQAu9opvQ
	(envelope-from <netdev+bounces-257794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:22:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCE107668
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3913013A93
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685BF3009E4;
	Sat,  7 Feb 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcElKBo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359301A9FA7
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770506560; cv=none; b=sTQvtbLKWXEouQuhwAmYM5DDGGepTMt9KPKO06JTmOZ1lCTRHCLjV1DOqNkMbQrMsnhspHAuFf0k25ZrpVA/9k7HfDD5LWr8G33Awd7WlC9w5iJN597cTYKUvUqTU7yV2oVryGbozxWxUR2I/bSFzdGffqffsO8HzlB5rozTMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770506560; c=relaxed/simple;
	bh=f3qPgky3Pw0rYjSITIQHTMTnZETYSuAhTnwJJxBOpYU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jugqNrSRlrgsC5Rh+01G2/kfcnV8JuG/xfg+x7++XjbZsX+Qc+WOI3Zx8o4QKt0CKF4s8VYetUV+rLSlyIyZrnUgfmsUKwdVTCoDkudjDp38TYROIHlPBclhsio9Mkkje3uvQPYcr8nwfzpSYrb13Fz1QrQeoMHQu4/oJDuZemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcElKBo0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a863be8508so22603545ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770506559; x=1771111359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U19uQlZiKIH7AXzq4LYM6LlqVqJMr7uhu5rg6VG3uvw=;
        b=zcElKBo0lniBdJyRJjl36JQn4czO9HV79oS8msUtrYpuzNLuh75QN1ycrVuhzwtX6c
         UJfy8j6EkgkrAVFI1PuLgLC6DA3Gb6yvqhMRobzmcnHZH/ZL4yX07PLJhMTEB8ukI3/0
         ZCrM4CbKxxXDyoTzR2mYC2ZhG0pXVYQYfdgPoZE4yDfVQcDJhPwvEN85JWGjq3Oblpux
         VlA4ZhZ07HFUmDH3BLtE72V2vu2elsXfo8jDxopopuGKG8MEDWvHmoNYbTHijRuOX1j8
         yTsCuHppkngNPb6mY+MfpF/7Ri3p6o8F31nl7sJm/G7tHBxti8vGSXSXzudF9s05I2E3
         T20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770506559; x=1771111359;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U19uQlZiKIH7AXzq4LYM6LlqVqJMr7uhu5rg6VG3uvw=;
        b=LmEu0QOg3wXuB51VeIB5JgqCoV197yNvS43U5hGMRKwDb7jFDZYhQLyUvKvw2uNuQj
         BTPFEDV0LD7H4yRl/L55PZEGANl3Txu4HpW3zs/Dc1l3oLt9NOOPF3h3Rmkq8mDVODgf
         KgxtLJGYkS7RQ1sNtElvbRLDHWxBmdLSdmS2ivqWt2Wca9WFSYFkfqSPgpQevBo6Zipa
         UTn08rDyGpi5RVOqVmiLk9TCZhDLslc5fCsg9TyzEySwChQwlOkIP6i71UBw68QMq0FI
         yPs7No16e4ns9WGWHi/5oO4OTy4f691f1lAZ8qyl0sA/6oEMeHo9rG1zmB7l0u+XaU6U
         lU0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQGt/gtATLQDGI23CRXXkvK5QfQit3oRsbEimeBgO/a9+UolezoiP0tC6J7bZV18iE3DEblhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pPieTlN9SZEFOhzSwSRefjiYXgEqaHolrQlaGMLRLc/UorG2
	gZ4vCQlQd+dhZPFBzRaswY4LkdPSdEuStjdMAf8fDtbDdjptDO3rXdycfU1jJkjTcZNzvYvDT3I
	SyDNMrw==
X-Received: from plbcp15.prod.google.com ([2002:a17:902:e78f:b0:2a9:5683:db05])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88a:b0:2a9:5b48:2b57
 with SMTP id d9443c01a7336-2a95b483459mr48976645ad.45.1770506559555; Sat, 07
 Feb 2026 15:22:39 -0800 (PST)
Date: Sat,  7 Feb 2026 23:22:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207232236.2557549-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Fix memleak of newsk in unix_stream_connect().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257794-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CCCE107668
X-Rspamd-Action: no action

When prepare_peercred() fails in unix_stream_connect(),
unix_release_sock() is not called for newsk, and the memory
is leaked.

Let's move prepare_peercred() before unix_create1().

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d0511225799b..f6d56e70c7a2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1650,10 +1650,9 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 
 	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
-	/* First of all allocate resources.
-	 * If we will make it after state is locked,
-	 * we will have to recheck all again in any case.
-	 */
+	err = prepare_peercred(&peercred);
+	if (err)
+		goto out;
 
 	/* create new sock for complete connection */
 	newsk = unix_create1(net, NULL, 0, sock->type);
@@ -1662,10 +1661,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 		goto out;
 	}
 
-	err = prepare_peercred(&peercred);
-	if (err)
-		goto out;
-
 	/* Allocate skb for sending to listening sock */
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
 	if (!skb) {
-- 
2.53.0.rc2.204.g2597b5adb4-goog


