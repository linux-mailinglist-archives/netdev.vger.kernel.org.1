Return-Path: <netdev+bounces-202808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D2AEF16D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2227016B8B6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFCB26A0DF;
	Tue,  1 Jul 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UwG6RMS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAA51022
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359234; cv=none; b=kDqDz0Hvzqa5vdnIeQ4fSRHCYMhy+xic20K7/xFEQ7Fp5FOJYTldVuYupMzRrVr8E+ZKYtLAQOZ9Gbb+kRx4XLG1Hsic6gIbN1F18ow4EF5fRDbx9ZLu0s8QHDW1pTPwJ8y66H3n2jOu2zANLW4q+2r08OHeSKEacvi7tA6CcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359234; c=relaxed/simple;
	bh=Lbn8rzjh7RE6O7oYUHPkiHveEVz+1OAXcJd7WAjkpP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgU2qzuxGjDwsFspDwap8ldbBK0CqVVZm0yQXXoOEnzKbtfAZT0zbaKg+qiGe8X5ifhcK0Uq9ANnXGiqeEKVI8vJb/TgK5WIr/YLFFzCm6s/2fDrA8jtUKcn5KAXayPxSbaz9Mn4nxDxOG8zKBZC6Faych38/8I1gIpiJQIFB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UwG6RMS/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4ACD23F71D
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359231;
	bh=d+q77i3nRFEpD8HnFtkd3zMitsksPFCi2UIIvgg4IUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=UwG6RMS/6mCIhCLYpHRbaWeRX29NrKteVyW5nrQ7bCPrOy6VviJ/5KJpIPoGByYMu
	 qxF7mmJ5r1GX4zVXd9nxJTaJS0eqFCkVhJezFYR7YfzandOrFyXrlg3Hb6gHctAm6W
	 l/0Et23EnYdYAAf58zPUZ7Nk4NktEMjHxibgSp3NaFe6u3JgpHTBpT2YMeVALML1u5
	 PPQY38FstyS8YSjQGckmUcd9jFW3HRfpN+L3FWMTpwaJ1oqhMpHk/9rLinpqmns4gm
	 BIE0AemaB0bvAj/Sm2iRxf/GOd7mWCOTfxGDZb8ee76io5ZsdwG7ehG08KfR08fquB
	 XobzO2Rni9TmQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0b629918eso284970566b.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359230; x=1751964030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+q77i3nRFEpD8HnFtkd3zMitsksPFCi2UIIvgg4IUI=;
        b=jKoVzWa/1zuwCX/lyqfsltgAMMaO94Ka3sF3u2iyE3MqLoCtbHdfI67TeiDqNwF08R
         plA9yK8agxBNmWyFbxCsDjC6ILDhar+18Ab2DkBNfZmibKrlz1xJ21fMQpk7Kycvtquj
         wFnuAtF/FhLQvw61Qhu61HB7EKMPz26xtqBJ9+lt8rQm0VQrqY43fqGJZiF/7yTVbd/H
         +MoFlj67xkuKIIQP2mLq6nx8Er5WddqClSN9bU62Tr/0sBWcZH3AdHfLtJ1BwN8EIlxI
         oLwYT8TRw7a/U+7vneww+NOuVwzbSgKRtP0H7zjYGhqVLe2eZw3NJe2CaT8U4r0y70VP
         cF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP3Dc6cs3iyUYZgoN136MILu+iXirVQtFS0sbA8deEjjThyboQEW2l9QKHSVkZ3jLUQspscg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgGXLhrBRenzyHC317n71+e8UtZz+9gUyqiHgeXjzWI/6d48+y
	P/3OSx3gkzqXH2uEQS9BqLM1O17QQ5PuRamBetJx1CZ95J258iq+DEiycujarDp2tYeOATSkkTJ
	UyKwjrPzJrR+kImdOo4kIgAXLm4OoRRNgY7tGQreZSEeoI7x1BC3xbYp48wwYCcHNAiw0uBRqRA
	==
X-Gm-Gg: ASbGncso6uSN/Aipfw4qPqcdcbHNHY4wrmAwSeZhWyTnYzA8tf/Ld/PHYIuKk7IFJHi
	B+YCsBT793z69qMT7qK8KE6uq99x1wJa6KcanUkUnAbTYSqAn2mL4qjNWm4E47IgNLxIXvbVqKW
	IKOhdeM5e8k3e32vAoMkzi9KvyJ6tKbEWSpVbYv8S3zFGud7XgJssxm6FsPtzLiz6s1q1PSQ+7K
	4LOvmqlHlSRHxVmwLm2ld0OYhERtGH/cijW8GB036/vGxtjr0wlsKrdF/63Po6zLEEHy9djMelu
	r/Yp8Z6EGPjx1ID7DrnUZ96KoYfQNiyvUwcd6/XlYTP3LujxVA==
X-Received: by 2002:a17:907:97cb:b0:ade:9b52:4da0 with SMTP id a640c23a62f3a-ae3501a1608mr1429782166b.60.1751359229828;
        Tue, 01 Jul 2025 01:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm38a4fIG5d97STV7PS1v47gd+0RVwmdaJeweffwuD+F/nL2Rv8S9KkYbLtZuIL5p9B+XmPg==
X-Received: by 2002:a17:907:97cb:b0:ade:9b52:4da0 with SMTP id a640c23a62f3a-ae3501a1608mr1429778366b.60.1751359229276;
        Tue, 01 Jul 2025 01:40:29 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:40:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/6] af_unix: rework unix_maybe_add_creds() to allow sleep
Date: Tue,  1 Jul 2025 10:39:11 +0200
Message-ID: <20250701083922.97928-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
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


