Return-Path: <netdev+bounces-134363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3942D998EBF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82A0B2885C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9201BDA90;
	Thu, 10 Oct 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNNVGcVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73719D8A4
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582506; cv=none; b=FGdrV9jk96gUlCI6BuhicGEUnqKxgQ1TOwXja/7Wgg5r/ULTZbrsx55obYh2IQmHk7wlzlNiJ+PyMeWAarYzMJ78h4cc2/mqSAZ9szaKoX8bF5cqrL3kMMTn/hWixt4s4/rO0o3zyf0quBbAll2gY8tDtPP5OX2/6flyzA/Krbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582506; c=relaxed/simple;
	bh=EW8rjCw/z5f98YSJSWfWxCIbXkq4lwiqQFR/qJ+ctus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYRMm42D8qacxF5xDD1QckJa0TThN2Gs9Gud1VWgl79IU7dJBAgRpGK3yW7xOgbZa4oeceFj/+z9IANibX2j1CjDTFHmn2STTIngs5xJW2CMg8+BvvUVk60wi56PHK9tiix5uAG3OzR6jYQP7V2pN033KMSecBkb3U9uxmRhgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNNVGcVJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso789859276.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582503; x=1729187303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuHZY684PM6JvayTAnAVyb/OrKemqXhLytf5nIKhzFY=;
        b=QNNVGcVJvMBpyjcKo3Hez7KupdX3sz5PLY4lLkk16noecwrhFp5g4bzEweid4Gu3lv
         x/PXbRN9W6vucNd5QUCiYTK1qMSQp4BbbTH9MZu7T3T1Jsy/WkeDvGCrTVL3Xxl1Gt89
         XZLijF07WM6wm5vuoMAHYRLCSC/EdeGaq8957gzpX62bEZWnZUR9FfDkSFv13WwfKCqY
         fhy0O4fHCezG9LhDYyOnabUj7m79aSO+3obMtoGVoYX8wiUmawHdirqEu9r+6VY0MnYi
         0Wnn5bKrQcCKxVdP5mvJPbpEPojhWCMeDp5ecK2X18wEGqWWnNg42JAQAIFHNmOsLKIb
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582503; x=1729187303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuHZY684PM6JvayTAnAVyb/OrKemqXhLytf5nIKhzFY=;
        b=VH8RHGyUhb65VpZNJ76wV9u0/Yz3zUj60hmPOLUEWUO1jt/zQAldWr4NDb1EMg0S3V
         7AcBmlrWbs338+SLFNFrkXkz2EwP0KQwXEwjmCvGnaDPmzFPrqBCaKUVqUZ6DaBCiGip
         eRIB2h7CBhWptcfamajzNzN5abLaudYVV1w1QP/JcdDH4lg1VrsEmkkn4GUFI21NWaPZ
         8UCNdg0AO//JjV7n5NXhhrO5elIEMz/w99WJMIkCzWj5m5+zwS2PuvQOS/fRZye+uexS
         wFtt/TfJrP5lb8ZmJVqw2Fu+GnxwXiC75uo4G6RvIk8OboqlUh0A7TZjaf1ww3mf3Zh0
         aAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNGiriv5AyrVQwiT8tx6a0FrVL2X7SfTf4aRjD9KqxQ54mJildKT7k5RtJrnUVQTXKQe3e99A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9H/R38zn+bP0cPrxWspY7uqxh9e6VrqA/NME7oEsIxCSdjtO
	ppR4bbAc8oGJmt+q3CYNAF4i+t6o2gHXpeYZS/Z1koUp6GK39iUuON6GPXjCzc5zoTGQ24HKODD
	j7GgpFo8HMA==
X-Google-Smtp-Source: AGHT+IFEZ50kjCgKcORP4ujltXM2aiUDBiXap4TybmlJC/M0ATsWiOLSgJ7Zeopjm17NOqUr2SKb6FKBIB9OTg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:9206:0:b0:e29:142:86b6 with SMTP id
 3f1490d57ef6-e29014286f5mr4903276.10.1728582503374; Thu, 10 Oct 2024 10:48:23
 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:14 +0000
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP stack is not attaching skb to TIME_WAIT sockets yet,
but we would like to allow this in the future.

Add sk_listener_or_tw() helper to detect the three states
that FQ needs to take care.

Like NEW_SYN_RECV, TIME_WAIT are not full sockets and
do not contain sk->sk_pacing_status, sk->sk_pacing_rate.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 10 ++++++++++
 net/sched/sch_fq.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b32f1424ecc52e4a299a207c029192475c1b6a65..703ec6aef927337f7ca6798ff3c3970529af53f9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2800,6 +2800,16 @@ static inline bool sk_listener(const struct sock *sk)
 	return (1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
 }
 
+/* This helper checks if a socket is a LISTEN or NEW_SYN_RECV or TIME_WAIT
+ * TCP SYNACK messages can be attached to LISTEN or NEW_SYN_RECV (depending on SYNCOOKIE)
+ * TCP RST and ACK can be attached to TIME_WAIT.
+ */
+static inline bool sk_listener_or_tw(const struct sock *sk)
+{
+	return (1 << READ_ONCE(sk->sk_state)) &
+	       (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT);
+}
+
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index aeabf45c9200c4aea75fb6c63986e37eddfea5f9..a97638bef6da5be8a84cc572bf2372551f4b7f96 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -362,8 +362,9 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 	 * 3) We do not want to rate limit them (eg SYNFLOOD attack),
 	 *    especially if the listener set SO_MAX_PACING_RATE
 	 * 4) We pretend they are orphaned
+	 * TCP can also associate TIME_WAIT sockets with RST or ACK packets.
 	 */
-	if (!sk || sk_listener(sk)) {
+	if (!sk || sk_listener_or_tw(sk)) {
 		unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
 
 		/* By forcing low order bit to 1, we make sure to not
-- 
2.47.0.rc1.288.g06298d1525-goog


