Return-Path: <netdev+bounces-203938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88F6AF834A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52147A35A1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576529344F;
	Thu,  3 Jul 2025 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="htirf0KN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320022BEC3F
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581416; cv=none; b=tSeesQ2SxOgvhewRdDas2rxiYrMljABAnK9l2GQFa1fZ5j3XJYMrDCTCpmM7/U0y0TfmEOC1TUQptbjbnhksdLpEcM39ZhjHBJCrFXj4nblgSiRF78cEK/J6f0tSvj3ErknjHOoCkVPOHCsp87DenleiATjFs9vSuJWOuKJb8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581416; c=relaxed/simple;
	bh=Lbn8rzjh7RE6O7oYUHPkiHveEVz+1OAXcJd7WAjkpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Hh/Hmr8V/cPDxwjd8MbNnBzix90kbWBUOx6YbR4lXUKcUM9+fWLec4EqC6jre7uOvTmSPasyOWASsNQYhZ7UyxHzD/3zRV/ytf7iyey3eKIOQv9VAsEXqhXk/vvjdcQ8uD9blADvA35gc9gzNR8Py1xB+Je57T/znVbUaVSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=htirf0KN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69CC03F691
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581413;
	bh=d+q77i3nRFEpD8HnFtkd3zMitsksPFCi2UIIvgg4IUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=htirf0KN0MCNmKPE9PPRWYrxYXWUdzA3b1NAnKVuJeWUpnHRajtqnx5MxMGXQQcCN
	 IH6Um7CqU7dyevNw7X304HUN+fDC0GdzQYYcOeYG3aIwrRahc/vY9+WJKvZOFR4vY3
	 t1b1/V6XEpYPl3SCeGLJ/H53YYnCsZAhtFjuMYh6O2FxQ3xtMHP+dvKPXKEX4guXyF
	 hOovgIUiycSG33CIGysMnHNMqWuhZZShHYIajHd0EPfar99GAeruRCectjpZePiPQr
	 T4gtQoMcRcoc9BLCSNHe/kchA7sPj3Ca1XeVVKTNBcYLqmlsf+31I+XalR0ioVUmF2
	 BarI5sliH24CA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-60c440c58ddso299699a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581412; x=1752186212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+q77i3nRFEpD8HnFtkd3zMitsksPFCi2UIIvgg4IUI=;
        b=CKFzzvBQAytXsOrUO8PAonlXqpGdQiIb6bgsmzB2Rkk4Koa7SoSR8Xta+AnGuMROnS
         9PJ7H1myspuhLs2sXyw5QcCIo3F5BRXJM/e9jk9QePSzNHzMxa/LYsKGH0dAw302axnl
         o9t6iL+JbAtoScC+x8zoLAN57xPnelESAi/eQcWURcgiPQFN5ZfV3jwqhoVq4EVPJ/U2
         5IESbj5eoTzVEZVWLquVy9s9ZQf89S/izHdlCRzJ85eECH4sQcEU4pk4dtAEu6I6t/lp
         oLjuzZtYnxFYWZ2AgvrZSxaFHV6RWf6whZHZq3nc5atKqm9xchfeG51jgsGUfwv9Qbot
         zoag==
X-Forwarded-Encrypted: i=1; AJvYcCVF+y2R5hmI35H7/4uHVsMNW2Q9AkadmHJ3PRO8Y8+mDbC5ynagySGW3dvw5qD4RKhMN5Y1MAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MnojfwftbEKBPq0mB4XugkNT0m6Pt6pK+0hwksG15HHWDhZ3
	UC4TnxbkqvQpp58/rztjFV/Aw9X4S3an5s9e4Z/lULsBghEIoPLtmWH9ucGNu7zrJ2JT42AICHn
	3EExDLW4kyCBattbnZ/S4/eC3RX/juw7yd+LNIVYpC3EFi97xjZZ2X1cDyC9VbC+A3YDR35TuVA
	==
X-Gm-Gg: ASbGnct8aVQgL4qDcK30Wns6j4emciqqRJmsNcZzqY2y9zzFXoDblsz5MkYKElgT9dD
	IRrdpRNeSrQWpeMg3agps4Ll/wTiY5nGPpIr4Zf49drMJDIjgS5bI88uczHU24rtqvT6OFlt/R6
	wmWq0xX48FMSTsbxb9JvZ4Yfkxd/xmMj8sQE2/P1knYrrPX6fth1w8LuFVdGRry6wmJPg2aCQAg
	XELI4fw8n4Ee0qglbwIzVnryl+S+OHLTPwrqpLXYMyLZKiWl7rAofexfZVfIhoMAUht0bkt5gbQ
	AWr7otnjegBVomiKC81iYNKjaiTBQd1v3sxhqT7SXM03iGfySQ==
X-Received: by 2002:aa7:d30a:0:b0:5fb:c126:12c9 with SMTP id 4fb4d7f45d1cf-60fd349286emr215851a12.25.1751581412239;
        Thu, 03 Jul 2025 15:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2biFnz5cfZv+nKonKT6km6Pn1oWt1Ka0vI4ItopUUTWrSplmT7pd4QPU+o3096hXMOVXGkw==
X-Received: by 2002:aa7:d30a:0:b0:5fb:c126:12c9 with SMTP id 4fb4d7f45d1cf-60fd349286emr215827a12.25.1751581411805;
        Thu, 03 Jul 2025 15:23:31 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:31 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v3 1/7] af_unix: rework unix_maybe_add_creds() to allow sleep
Date: Fri,  4 Jul 2025 00:23:05 +0200
Message-ID: <20250703222314.309967-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a preparation for the next patches we need to allow sleeping
in unix_maybe_add_creds() and also return err. Currently, we can't do
that as unix_maybe_add_creds() is being called under unix_state_lock().
There is no need for this, really. So let's move call sites of
this helper a bit and do necessary function signature changes.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v2:
	- fixed kdoc for unix_maybe_add_creds() [ thanks to Kuniyuki's review ]
---
 net/unix/af_unix.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 129388c309b0..fba50ceab42b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1955,21 +1955,30 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
-/*
+/**
+ * unix_maybe_add_creds() - Adds current task uid/gid and struct pid to skb if needed.
+ * @skb: skb to attach creds to.
+ * @sk: Sender sock.
+ * @other: Receiver sock.
+ *
  * Some apps rely on write() giving SCM_CREDENTIALS
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
+ *
+ * Return: On success zero, on error a negative error code is returned.
  */
-static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
-				 const struct sock *other)
+static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
+				const struct sock *other)
 {
 	if (UNIXCB(skb).pid)
-		return;
+		return 0;
 
 	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
 		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
+
+	return 0;
 }
 
 static bool unix_skb_scm_eq(struct sk_buff *skb,
@@ -2104,6 +2113,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_sock_put;
 	}
 
+	err = unix_maybe_add_creds(skb, sk, other);
+	if (err)
+		goto out_sock_put;
+
 restart:
 	sk_locked = 0;
 	unix_state_lock(other);
@@ -2212,7 +2225,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
 
-	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
@@ -2256,6 +2268,10 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 	if (err < 0)
 		goto out;
 
+	err = unix_maybe_add_creds(skb, sk, other);
+	if (err)
+		goto out;
+
 	skb_put(skb, 1);
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, 1);
 
@@ -2275,7 +2291,6 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 		goto out_unlock;
 	}
 
-	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
@@ -2369,6 +2384,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		fds_sent = true;
 
+		err = unix_maybe_add_creds(skb, sk, other);
+		if (err)
+			goto out_free;
+
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
@@ -2399,7 +2418,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_free;
 		}
 
-		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
 		unix_state_unlock(other);
-- 
2.43.0


