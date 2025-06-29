Return-Path: <netdev+bounces-202298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4FAED159
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD53A160A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84371242909;
	Sun, 29 Jun 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="i3abdx+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC029B0
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233506; cv=none; b=keZjIXfMP7TebOfNa4iQR9Vl9n5A5yKBQ6J4s0i2iMHtoeZ16y5eSFqd+hba+QYz1L8OEG/aX4D39wuSMAm/59tJrp0BgJPyRgRn5av9BSAOUHhfkANP+0woa1JyFYCOtXbc16hhXNG4Nf6vS/K1B27T6KsyvgISMo2XrS16qDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233506; c=relaxed/simple;
	bh=EifaHAoAApf7q/Mkx9Mw3DETHvUJ2q8UmDQ+dVcocek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWlclhrrMJm0v66moflzsUgHR9VUyBGzxB1zZTgeIjt3WjgON1WRVwM1MmRP7WJ87ezPtrlqB8GWI5O98I3KWmm3DSPJazI5ZAHqNbAMEdGangnoGI6xLNsbWAU/IYhl9XS4Ql9bEWL6RMZEE0bJXU1hWpQNzJ2Y23bR4vMi4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=i3abdx+p; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1BC053F91C
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233502;
	bh=G60zTzgwmIGQw3RA46ispul5I6p3fmOYvxZfvnCsXEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=i3abdx+pC395RdsIxRGi6wy1GOX1wyFYTjLFMemho0SqpDqI2z6xuvzcVBRfZJzFt
	 Nt5ci8bFQNWnri3QijJpRco7HKzxHRIvnvVlT9CcWhg0ZjJDxjcDr3SYsrsS9s0P1U
	 K+aYaXs3XqZV/4NzdDZQu+RkdxSTGU+sz7voTfHuvjY2lK9wTsrMhQpjP01i5GxvEq
	 AIhkrZJL0Srzsjn5ni/NZp57+Rc9CdJwwm+yjRkyhdDmjiRyq3lLOmD2m0AWUM0r25
	 B/pZYklRqT+xdb7H3OS5BL/Q3mpeEhIi7V0wuYLsMAgV4OT2ABcaJAt1JH3iB5za/e
	 585qzCTnqIoig==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-60c5ed14785so2876373a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233500; x=1751838300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G60zTzgwmIGQw3RA46ispul5I6p3fmOYvxZfvnCsXEE=;
        b=SWCExiklOvcmHDa8H+bg7avIFMbvQIavUEKZzAc4WjC3K0YhtyZWVb/LXuKQJ6kzPL
         q1S+JvXg5CPThQpWDaqgIanpPfcfpG14Rpt3ZFjHbSX0J8EhJr86qLcv8ngYjduMd0L+
         UNBjVwsL6fdeRhglqBipeCvDLbCcHT3IzVhKxq7tm2QFGO5c3Hl/xeNQZqgthtis7d9c
         o7an5nckQwqneVmy6Axkn0+0sOnWoWxVLNbqfbwZRg86Cazb/ljrxxOeZIF0lXhnm/4p
         F0x9J3i4bOW2bIyhaL3yFEhOcEImoZ8VkYk+dfmsINkcixjQuQhsXeAmGgP32Tkh5hd7
         RgIw==
X-Forwarded-Encrypted: i=1; AJvYcCUM5BYkYwPzBquv5DMTy3VUbdF6SdygNDRhM5zbXUptp64chhaEAGUAD5vTa+m2O4p41szt24c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfHmH/lIJAx9vxz+0rL+ON542ExFcuxFjoTzzIkZKjAXq80B3
	mzsFzG/Bfs7dfk9SXFlbzmttjmtjm1X6EnjLc2qBKCmBZwYvl9vcMcTXd3uT45i9URqnKSe6EBT
	ycVZcySARNIUEwzoOBXZXN9QuyHp0hnopVdkscxLAgsd3nthy3474C7VIFukXQi2gKX8CAQzISg
	==
X-Gm-Gg: ASbGncvK9NVHoeAYsyBPk1zEKjzAZ/l3C3PecDuIjZheV1apeg4uYs9q/dRxYReHwys
	7O8WFLp6Sn9+YqLgyV8GUB1WbqtEv+cqah+34dpF9HnpBsHvDjXUHhOadXhMrbzhdcyYTUYTf3B
	f2/ZVh6q3wDX6/qsxT5Ta3Q40NJptys5OxlLq8opF2BWzKQgGQt44Uyielz1/P6HMgkZ6e7GoRZ
	0wltVCvJNWE5+JNAFn7k3NmYQAyXxdpRz3WWxYYKFvotBkqBe7HLV2eKPFJ2tRfRaey3ZZgTM+p
	DzK5k7MUAU1SSx/Lr6c0hdGorcCp4x7IEd/h0++oSrwNaVPpyQ==
X-Received: by 2002:a05:6402:2101:b0:60c:4bc0:453e with SMTP id 4fb4d7f45d1cf-60c88b38471mr8622082a12.2.1751233500224;
        Sun, 29 Jun 2025 14:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2xPyY82dEZPtNOjLLgnJHoQ4Iup9xB3PZexu/WprfMu8neYWm8eCcLIXuCERFbcQhVsIVLg==
X-Received: by 2002:a05:6402:2101:b0:60c:4bc0:453e with SMTP id 4fb4d7f45d1cf-60c88b38471mr8622063a12.2.1751233499849;
        Sun, 29 Jun 2025 14:44:59 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:44:58 -0700 (PDT)
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
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [RESEND PATCH net-next 1/6] af_unix: rework unix_maybe_add_creds() to allow sleep
Date: Sun, 29 Jun 2025 23:44:38 +0200
Message-ID: <20250629214449.14462-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
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
---
 net/unix/af_unix.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 129388c309b0..6072d89ce2e7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1955,21 +1955,26 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
-/*
+/* unix_maybe_add_creds() adds current task uid/gid and struct pid to skb if needed.
+ *
  * Some apps rely on write() giving SCM_CREDENTIALS
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
+ *
+ * Context: May sleep.
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
@@ -2104,6 +2109,10 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_sock_put;
 	}
 
+	err = unix_maybe_add_creds(skb, sk, other);
+	if (err)
+		goto out_sock_put;
+
 restart:
 	sk_locked = 0;
 	unix_state_lock(other);
@@ -2212,7 +2221,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
 
-	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
@@ -2256,6 +2264,10 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 	if (err < 0)
 		goto out;
 
+	err = unix_maybe_add_creds(skb, sk, other);
+	if (err)
+		goto out;
+
 	skb_put(skb, 1);
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, 1);
 
@@ -2275,7 +2287,6 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 		goto out_unlock;
 	}
 
-	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
@@ -2369,6 +2380,10 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		fds_sent = true;
 
+		err = unix_maybe_add_creds(skb, sk, other);
+		if (err)
+			goto out_free;
+
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
@@ -2399,7 +2414,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_free;
 		}
 
-		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
 		unix_state_unlock(other);
-- 
2.43.0


