Return-Path: <netdev+bounces-238819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA2C5FDD3
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44FF4E52AF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC91FBC92;
	Sat, 15 Nov 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6zAruMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8D1F1518
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172587; cv=none; b=Kh4SZndzFUQkZVyCeF7NeAKWg9lG/TruQbpzk47G8RUPG+hf6MhP8sDqJRw3lmraYMLaMQG6ZHdZYgbxL1EdV2GWkutRLgr23EogXq+nak6K9j0RIqeJ0cAnNPIQk8ffEippMRvTMNWKrZ1uKK1VmlQNWdlOOIa/4vmEGtIkdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172587; c=relaxed/simple;
	bh=auFIxer3gAxH82KvXUrNc55KyMyGVaTts6aNClMcGgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P7fn64aftGbBDgPgRA2mKWi9fKYxS2NkSRFNDtUj0oC2nuE2qmVH9/ioz6owxg5pkHc5koGeTz+s28fj2RM7+viL9Ndc7wgGzzxZyuBjx7nq/xkGT8Wc7/5U9NbDfj2O9+agnbZUtFd6PcaMKteDTjd8Cxj/r5sjOCJ6zOc7bC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6zAruMZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343fb64cea6so2269544a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172585; x=1763777385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8KeZJmdwonMnwiJ+W/nlpS56s+HtK9/uBAXL/ig64o=;
        b=b6zAruMZfDLkM8dSRiuE/RW2zSEQac0YEiDhD9ze0eJhTI4dzfhRDUHEW1ILhrjtd2
         0HiyA0BxuM6Vbnq75mAU+DTTrFOCWYvDlPo6N1WfRXYLWsJUsdr6QZGK0ypf5vWofCfp
         3dWCX9Kkz87+BCKol3i95+ilPJhsl/ZqWqXOT83vB9grpbHsVsda6igbjF1moXWosLkK
         P+3z0f0RmDABzCTq2D9McaKIESBCSKP33pSWjON/9B6b2eTJkWIKl+yT347BiS898hcQ
         B4fvqQIJCMExVhoY7VCAPwGmZ/9jtTemXCy6F6k6Z9zS+ePp6xq4fS3/e4AM5bzfHqZr
         QmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172585; x=1763777385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8KeZJmdwonMnwiJ+W/nlpS56s+HtK9/uBAXL/ig64o=;
        b=XyNBHhciKDuayHMIWrdVEmWtj1lCWGURK6YPluf/ktDIPr3zdaIF/vv3YH9Bgqxiqu
         J5KgrOQFUetMKmALRI81GniQ/JGOo8KeCM4zx72d8tPs3r8fIL8jroauTdFWaXMFos77
         BJxiNmTyfLYnpwwx4zGjSssjNOhP2frnhMm7qxIRNUe9dGq1B0aC255IlGFMvgn2plix
         GhUu6MFYn3ukRsefSaQfFVcf31HnjqBCMgjuumaVGV7GilNg6GkwreJvYYmswgKnl86P
         gG10Y+nsYZX8nHwu6wq9Aa3Fv6cEi7Nn49XuAJUsznwkFT2w4xTUcX1u3v/h6rH646XO
         JZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbyzPS/mJOFb+TxEyo39u/S2a7MkgqTnCcNUqdCP01OAKs2AfBXSgzA6HQDk8dkf6drZG8U04=@vger.kernel.org
X-Gm-Message-State: AOJu0YysI2138xdanRRralmbFXAPjiONuwhiSKlQpqjE5Q/w4NGJUEMu
	hOX0wj/iBnhUoSmo1lfQxOG5VZcZnnX/cwgc86IBmsqIXPAIOQxiu5GWBYJ7CCezDDX1PIVk/zw
	gnxOWOw==
X-Google-Smtp-Source: AGHT+IE1oYIn7OpxTahJDbYu+qXvDuXI9M3yt1zDjseZwMKDHTOm/eh8dUgQ1ZkldZlUHdF38QQKrDK8cyI=
X-Received: from pjtp2.prod.google.com ([2002:a17:90a:c002:b0:33b:51fe:1a75])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc6:b0:33f:eca0:47c6
 with SMTP id 98e67ed59e1d1-343fa74991emr5233771a91.30.1763172585315; Fri, 14
 Nov 2025 18:09:45 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:35 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/7] af_unix: Don't call wait_for_unix_gc() on
 every sendmsg().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have been calling wait_for_unix_gc() on every sendmsg() in case
there are too many inflight AF_UNIX sockets.

This is also because the old GC implementation had poor knowledge
of the inflight sockets and had to suspect every sendmsg().

This was improved by commit d9f21b361333 ("af_unix: Try to run GC
async."), but we do not even need to call wait_for_unix_gc() if the
process is not sending AF_UNIX sockets.

The wait_for_unix_gc() call only helps when a malicious process
continues to create cyclic references, and we can detect that
in a better place and slow it down.

Let's move wait_for_unix_gc() to unix_prepare_fpl() that is called
only when AF_UNIX socket fd is passed via SCM_RIGHTS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 4 ----
 net/unix/af_unix.h | 1 -
 net/unix/garbage.c | 9 ++++++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4a80dac56bbd..34952242bd81 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2098,8 +2098,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	wait_for_unix_gc(scm.fp);
-
 	if (msg->msg_flags & MSG_OOB) {
 		err = -EOPNOTSUPP;
 		goto out;
@@ -2393,8 +2391,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	wait_for_unix_gc(scm.fp);
-
 	if (msg->msg_flags & MSG_OOB) {
 		err = -EOPNOTSUPP;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 0fb5b348ad94..2f1bfe3217c1 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -30,7 +30,6 @@ void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_schedule_gc(void);
-void wait_for_unix_gc(struct scm_fp_list *fpl);
 
 /* SOCK_DIAG */
 long unix_inq_len(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 190dea73f0ab..280b9b07b1c0 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -282,6 +282,8 @@ void unix_update_edges(struct unix_sock *receiver)
 	}
 }
 
+static void wait_for_unix_gc(struct scm_fp_list *fpl);
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -303,6 +305,8 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 	if (!fpl->edges)
 		goto err;
 
+	wait_for_unix_gc(fpl);
+
 	return 0;
 
 err:
@@ -628,7 +632,7 @@ void unix_schedule_gc(void)
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
 #define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
 
-void wait_for_unix_gc(struct scm_fp_list *fpl)
+static void wait_for_unix_gc(struct scm_fp_list *fpl)
 {
 	/* If number of inflight sockets is insane,
 	 * force a garbage collect right now.
@@ -642,8 +646,7 @@ void wait_for_unix_gc(struct scm_fp_list *fpl)
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
 	 */
-	if (!fpl || !fpl->count_unix ||
-	    READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+	if (READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
 	if (READ_ONCE(gc_in_progress))
-- 
2.52.0.rc1.455.g30608eb744-goog


