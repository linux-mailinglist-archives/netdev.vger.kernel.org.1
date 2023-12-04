Return-Path: <netdev+bounces-53386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE5802BD0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 08:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D5F1C2095F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E64186C;
	Mon,  4 Dec 2023 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="ckElfA2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E213101
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 22:59:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0a5422c80so5018105ad.3
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 22:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701673198; x=1702277998; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX9PCE/s+L2Z904MfQ2/oVmj1XblZE1t5moWkOvo/oA=;
        b=ckElfA2n1hbSBgJ8YZm/sQPKGFWNjMehrCLfYrwI8F0/jLOy5wGAx2UAPX0UpNJzGI
         ZnhPCrMI811MDjsY3EcnnZp+t2MtrNu4GJPJ1QnyIpGTzKOmZq719Jc9jkiMdj7tbnY1
         EO7SwlF/KQyM9kByMHWFiNjOHzFjleKQmAhuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701673198; x=1702277998;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX9PCE/s+L2Z904MfQ2/oVmj1XblZE1t5moWkOvo/oA=;
        b=Wnr7rcPSQmqN5PZA03Vy+EM8Fm00YFa6GPU/XdGX3xdONo3BahmdTTFcIZbcXvk5u4
         kOjpa0szNQXsva9Jak2YgsKArAoDJ9C7k5aENe318v3fstFyLgJdWA8OyZs2Q9rUuKTz
         7mSusWCQoaA5aD7T9ooG5S2q3nNhzNxVSPonMzGS8dgmuoPfFKi6Y8CnIcDy96TEDhjh
         n679bHxv1ic15ny2Q/VPL9mYy8acMrwSyQl+v7HL1cXKYT0e7v9VuMXxJmHzvYAfjexH
         MQO7ZloViiSiaxFsprRuBujgUKgowlW/ElEAc02yLOq+JP7W91I1leLcwhnIuF7jDpdO
         gjlw==
X-Gm-Message-State: AOJu0Yy558srVX0/RL0hHy4RLOA+Jigxhipj51ihRw+1tQxa4kWMuQ1z
	/5AwHQ/+xnGwM+6gfrTasIpnqw==
X-Google-Smtp-Source: AGHT+IHKvFRck+LSlanaWM0Rs2iIfxcXM0ZbK33202PTVxb3GVaY7xLY5+LMcO5xlYOkeuzuPey5xQ==
X-Received: by 2002:a17:902:6b02:b0:1d0:7181:a90e with SMTP id o2-20020a1709026b0200b001d07181a90emr2798490plk.61.1701673197912;
        Sun, 03 Dec 2023 22:59:57 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001d057080022sm5579701plg.20.2023.12.03.22.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 22:59:57 -0800 (PST)
Date: Sun, 3 Dec 2023 22:59:52 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: courmisch@gmail.com
Cc: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] net: phonet: Fix Use-After-Free in pep_recvmsg
Message-ID: <20231204065952.GA16224@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because pep_recvmsg() fetches the skb from pn->ctrlreq_queue
without holding the lock_sock and then frees it,
a race can occur with pep_ioctl().
A use-after-free for a skb occurs with the following flow.
```
pep_recvmsg() -> skb_dequeue() -> skb_free_datagram()
pep_ioctl() -> skb_peek()
```
Fix this by adjusting the scope of lock_sock in pep_recvmsg().

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/phonet/pep.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index faba31f2eff2..212d8a9ddaee 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -1250,12 +1250,17 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(1 << sk->sk_state & (TCPF_LISTEN | TCPF_CLOSE)))
 		return -ENOTCONN;
 
+	lock_sock(sk);
+
 	if ((flags & MSG_OOB) || sock_flag(sk, SOCK_URGINLINE)) {
 		/* Dequeue and acknowledge control request */
 		struct pep_sock *pn = pep_sk(sk);
 
-		if (flags & MSG_PEEK)
+		if (flags & MSG_PEEK) {
+			release_sock(sk);
 			return -EOPNOTSUPP;
+		}
+
 		skb = skb_dequeue(&pn->ctrlreq_queue);
 		if (skb) {
 			pep_ctrlreq_error(sk, skb, PN_PIPE_NO_ERROR,
@@ -1263,12 +1268,14 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			msg->msg_flags |= MSG_OOB;
 			goto copy;
 		}
-		if (flags & MSG_OOB)
+
+		if (flags & MSG_OOB) {
+			release_sock(sk);
 			return -EINVAL;
+		}
 	}
 
 	skb = skb_recv_datagram(sk, flags, &err);
-	lock_sock(sk);
 	if (skb == NULL) {
 		if (err == -ENOTCONN && sk->sk_state == TCP_CLOSE_WAIT)
 			err = -ECONNRESET;
@@ -1278,7 +1285,7 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	if (sk->sk_state == TCP_ESTABLISHED)
 		pipe_grant_credits(sk, GFP_KERNEL);
-	release_sock(sk);
+
 copy:
 	msg->msg_flags |= MSG_EOR;
 	if (skb->len > len)
@@ -1291,6 +1298,8 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		err = (flags & MSG_TRUNC) ? skb->len : len;
 
 	skb_free_datagram(sk, skb);
+
+	release_sock(sk);
 	return err;
 }
 
-- 
2.25.1


