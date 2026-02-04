Return-Path: <netdev+bounces-256585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBLGGJLegmnfdgMAu9opvQ
	(envelope-from <netdev+bounces-256585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC63E21CF
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04BBA3019D52
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92C35C190;
	Wed,  4 Feb 2026 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfKCOP69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BB350A20
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184312; cv=none; b=aA8+081Q2dY5gJBCLdN5EU7Iah07vkOklrACBN2jAMxGIVm0OtKprqBq4A6IfT/xtXBjDY0dvUJB5KBGW/LufZ+M/0Exm6dISILh3sXgOJ2XcNYjBwRsDftcBDZIavJk/h7dmWy5BM9NrvULuTFUXq+rPzJ09gnzcAXdyHpAM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184312; c=relaxed/simple;
	bh=Gz9dxOEtTB/t72TOkZpUekQ16KUQ6ZK9+WHQjUyvhNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ktVLtzCiVKpCSlWNXY6zwHxslwCxIwO1xDXa3VQdHINJpidNbJ4B451YEfvV+8bV31Ui72Rf1uvgXK4ypAdzaX8MVICW4AXHq8GHSGp6kdbpDCJp2MhVI8jM+ud2KKbDeVv3YvaoFA3UoyHTrFie8XVCb7TN20ZQ5CSSNPumEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfKCOP69; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-502a26ccb20so88506051cf.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770184311; x=1770789111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZknvYAgmnJjAhBFiF7RW0zJwBxnxfXK9Qw+kg2Ccf3E=;
        b=IfKCOP69Cu0oB/3AiMBYPT3rMWsE5uujodOx97A2DZS5zcuJN0Qxp75+KR1ExL/YPF
         /aVkxdGndsYnM48QO3daA1pnmUDkLCGE1keBvuGLkIxt0JrrgcFEwjPCyU0tSgCUh52t
         Oka05VqdRJhhN1+UlXGnCjqxxIuTXVQjTkD7XBGxfQMitz/l7kkP+nbzOL89wUrJwgfV
         YLlzhVihKQKgYcQcYq5reW92DtisSwD4IaIJV7BpmkYLLhiiotqgNnDY8HI/iF0mlvJ8
         pJ+RjC/hIvjU+y8BO4VHXfcMMGOko8GRXJS0+XjO+7O9vh91TD7hAEx7Zr67Mqk8lwdI
         tWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184311; x=1770789111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZknvYAgmnJjAhBFiF7RW0zJwBxnxfXK9Qw+kg2Ccf3E=;
        b=caOtT0NbnLz1arnLNs6MtOakktE1XHlZxFe6wn0d97n1eJrjHS+TXzwqDY4mhbHGEr
         oFUwgLt80G5YS+sNtRUg8nvSMtCnL+4sX99HNHL06CJ5dgUygcQE+4nXishl99YYTtH0
         kSAGGmeMY8KalJGvjMve6/CfJZ2i5oNOlwMeJ2I3H7PJnECV/f/3L/ZecicLSdnNGrcX
         E5cyaUV1/lkGiPd4jpgxAZDSCCBt/enF2iGDp/QWCJiUZ55OOsQYSYdyBdSocHMUD5z4
         FwdnRs/lCSxA8IrESOKNuVzh5L3vFkEHGRYy7Y/YhsPpidizWsA3v3y8Vd/rOaikTui9
         +NJw==
X-Forwarded-Encrypted: i=1; AJvYcCXg0oReNwPw7LMFNkTrU2RVlCQitopglKAtjuLKDmekpeEpQ24FGtNEEQwyZItZfOOjP9z3eUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOc4hw9Rg87HkcF+ypmrs538ne/lbSOTZAl0hIXtZBb1TzHbj
	8nYnnj81Zgrjgi5kARMm/pT2a4w9PGG/RzU3mYzf60tWYtSuAIX1EtUwhQLi8BZnETdRaPEiCu4
	fXlRc5u3H/lrz6Q==
X-Received: from qvblv2.prod.google.com ([2002:a05:6214:5782:b0:888:8810:4181])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5801:0:b0:501:50a6:962d with SMTP id d75a77b69052e-5061c1d84ddmr20922041cf.77.1770184310920;
 Tue, 03 Feb 2026 21:51:50 -0800 (PST)
Date: Wed,  4 Feb 2026 05:51:44 +0000
In-Reply-To: <20260204055147.1682705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260204055147.1682705-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204055147.1682705-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256585-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CC63E21CF
X-Rspamd-Action: no action

Only called once from inet_csk_listen_start(), it can be static.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/request_sock.h      |  2 --
 net/core/request_sock.c         | 24 ------------------------
 net/ipv4/inet_connection_sock.c |  9 +++++++++
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 9b9e04f6bb8931088d9bb2fa7d4420fecf235895..23bb909771fbacbbd31f614b1754f0c24e602645 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -196,8 +196,6 @@ struct request_sock_queue {
 					     */
 };
 
-void reqsk_queue_alloc(struct request_sock_queue *queue);
-
 void reqsk_fastopen_remove(struct sock *sk, struct request_sock *req,
 			   bool reset);
 
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 897a8f01a67b4e09197da2241bc5c33ea3d90c29..31389f875b19b56592e81576b8812359017daac9 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -16,30 +16,6 @@
 
 #include <net/request_sock.h>
 
-/*
- * Maximum number of SYN_RECV sockets in queue per LISTEN socket.
- * One SYN_RECV socket costs about 80bytes on a 32bit machine.
- * It would be better to replace it with a global counter for all sockets
- * but then some measure against one socket starving all other sockets
- * would be needed.
- *
- * The minimum value of it is 128. Experiments with real servers show that
- * it is absolutely not enough even at 100conn/sec. 256 cures most
- * of problems.
- * This value is adjusted to 128 for low memory machines,
- * and it will increase in proportion to the memory of machine.
- * Note : Dont forget somaxconn that may limit backlog too.
- */
-
-void reqsk_queue_alloc(struct request_sock_queue *queue)
-{
-	queue->fastopenq.rskq_rst_head = NULL;
-	queue->fastopenq.rskq_rst_tail = NULL;
-	queue->fastopenq.qlen = 0;
-
-	queue->rskq_accept_head = NULL;
-}
-
 /*
  * This function is called to set a Fast Open socket's "fastopen_rsk" field
  * to NULL when a TFO socket no longer needs to access the request_sock.
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 018e8ffc07176dd4f6ecbaae5697b90b67cb1294..60f2ee039c05f46bdb95f6211a8f9eafbedb9610 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1314,6 +1314,15 @@ static int inet_ulp_can_listen(const struct sock *sk)
 	return 0;
 }
 
+static void reqsk_queue_alloc(struct request_sock_queue *queue)
+{
+	queue->fastopenq.rskq_rst_head = NULL;
+	queue->fastopenq.rskq_rst_tail = NULL;
+	queue->fastopenq.qlen = 0;
+
+	queue->rskq_accept_head = NULL;
+}
+
 int inet_csk_listen_start(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-- 
2.53.0.rc2.204.g2597b5adb4-goog


