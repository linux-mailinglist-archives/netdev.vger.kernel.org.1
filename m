Return-Path: <netdev+bounces-58993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23521818D22
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477371C2462F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653EA20B14;
	Tue, 19 Dec 2023 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gg3krNLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897320333
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e7c4de7198so8176127b3.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703005219; x=1703610019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePq5tpATvVhwn8Rp+KwzalY0fEMI5TkAUQCID0XO2kI=;
        b=Gg3krNLZYJgGCpSaQwayrK0LNAdB+MzIbaoBbCkmLSHkOmUywpkYGcvnvYqQvB2su6
         cDoEZqMTDniBPPPSJDj9SIQ44y+KBz9/oNDsndfAHVtWA/vJikeRJxC6PC2CZ7lIMZWE
         t7Znqf6TQU+MKYrq/ArsajsCdt8fMuizBIWpO4i7TA2P+fcMTHL/ZTcfmWfFTfAEL1Z/
         EA5UPlYuJJMv5UNK+db6mG0Cqh6cf7J4WM3KsEDYVVS5ecSNMpI+S+frTmCguHmSA+gs
         AYEjugaSphecp/LVc0/4iAazFRlF3NuY4XnpWgi/3jjyodTiuztv7XQBzE9yPQXiRpd5
         OvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005219; x=1703610019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePq5tpATvVhwn8Rp+KwzalY0fEMI5TkAUQCID0XO2kI=;
        b=A6GvoCDIJE7VGnwwgvBtc/LDcMuGafQ5eRoPr4Aq1RZmNIgfaiVLYuRNeGEsSjKht4
         qZt0FP978jZ+FloqeBUWYEEk3sw3haPSzynPqtq49GkE8biFftpzMN2NDOsqvZWMEWj1
         Pe3q4jN8tvIfd18yYaYu7521Dm1ht18yU23OsPU5Fma60wDVpiforYZphXtBYLS9M/AZ
         KixDnZvvX6k9vhY26HMLUce9ae2ybDRafNvGUcUZl5vu8D8PCFMV648FTW+d2GN04RTm
         9YX4JVNAw2LTB7nZDMem7gKpw+SibZktuT/IqrA7F+AkT8dmI8St/17PLJjR0eIF/PYG
         rIRg==
X-Gm-Message-State: AOJu0Ywc7L083yup0HR1qlGySMYWQuzZ7IT6c651mdq9q0cpTLsv6DzQ
	xwfA3/vJMUkO4dZQyMhPdRzvYcN66jO5Lw==
X-Google-Smtp-Source: AGHT+IGRbzUq1DN9ZtFYC57Z7zjstTCSzD1lv15qOkQfWZjan4r+nqrh0bFy1tvQqaezABkiG0uIF/Mki5b26w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4987:0:b0:dbc:c637:e85b with SMTP id
 w129-20020a254987000000b00dbcc637e85bmr182154yba.6.1703005218958; Tue, 19 Dec
 2023 09:00:18 -0800 (PST)
Date: Tue, 19 Dec 2023 17:00:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231219170017.73902-1-edumazet@google.com>
Subject: [PATCH net-next] sctp: fix busy polling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jacob Moroni <jmoroni@google.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Busy polling while holding the socket lock makes litle sense,
because incoming packets wont reach our receive queue.

Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp protocol")
Reported-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe599ae5d1d1cc6fa9557a3a3bc 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
+	if (sk_can_busy_loop(sk) &&
+	    skb_queue_empty_lockless(&sk->sk_receive_queue))
+		sk_busy_loop(sk, flags & MSG_DONTWAIT);
+
 	lock_sock(sk);
 
 	if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
@@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags, int *err)
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			break;
 
-		if (sk_can_busy_loop(sk)) {
-			sk_busy_loop(sk, flags & MSG_DONTWAIT);
-
-			if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
-				continue;
-		}
 
 		/* User doesn't want to wait.  */
 		error = -EAGAIN;
-- 
2.43.0.472.g3155946c3a-goog


