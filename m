Return-Path: <netdev+bounces-260744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p/3NNHBtnmkcVQQAu9opvQ
	(envelope-from <netdev+bounces-260744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:33:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B206191333
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80513010175
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB61E5B63;
	Wed, 25 Feb 2026 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJfzk7D/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77AC11CBA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990340; cv=none; b=MvIKiRMeI4y2NbMP04xmFYLAavcs00H/IL1Q1VAxSv59ix16QsiNe9AnzhCvK6uu964D+ps2flkBxf7sbxBN2MNoBNRAQW8grLQ8TayNb2otwBJKwmgExi6ymtRsTZT2ZofPI2WH3Y+s1gpc596c/8c1poVIoJ55k3bkDl9dG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990340; c=relaxed/simple;
	bh=JeWWhjlGQSAE8+JVghoKUWiFAPmhlTzy71NR5YC4I2k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=feAccz6a+7A95ESCkxult9y857EEalYSEayK0SyHtRHqlJ9yTeHY5s3kW1G/zhqzYqeP+U+2qcFShNWiSqToUXESxV/JDRrDn9YrnxgvEIhl77nOrE/kyIbteEPgq4QkvzzrrBRtTZYWfM5Z+U42L3yhuCFCPlazeQBDHfL2ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJfzk7D/; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb4817f3c8so4646180885a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771990339; x=1772595139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PBH2ht8SvVICfDQUa0pPrXGp/+5LQJ28p1mb+pPA6q8=;
        b=JJfzk7D/Z68TaRWgJxUTFrZ71CCwU/fkr01kzCj4Z9vqOkadODRADxALIaUKAKCGBi
         WzgwcvAjcoJDsjlkQ1YCCw7TcWdzyhBscjVT0w4/NGGomPXxkWxMjNjCgOsgfGVA6m2l
         wiI+bzxaS1kTTC+0mowMHELx4acx4wCY4oob+tYyRmTNoQ/+fnM6DaZeLg38nMY6O+lo
         7ZMU69rc1ZDijX2Gawcfa93edmw/Rd6nU8wU41e/LvzE/K8ejODZJ8V+HhZmYwclTaab
         9dXLZ4iBcWrQ3CFVl5t+F0AoGMSQg6aNZ9NDBmRMtHFiFKfH0HNS3LjqYG/Y9IqRMHQV
         yYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990339; x=1772595139;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBH2ht8SvVICfDQUa0pPrXGp/+5LQJ28p1mb+pPA6q8=;
        b=gKvLj1GqkIpCB9/5I+PRmzJsBto+Ve7kNvAl12rYljFQY4ASjkSfq4OshLOIEeKJdz
         KfrfK6IhfG3gYv43rSKGsBl3vfUPOMfneG6JzPpwn+EzOTupPMY2+D1b43ouXeVf4CWB
         xpTnuAYLytDZ/kr1Btpbs6nKQ6W4p7WxCaxZlCFXz6//UQBk7nHejgEEJYqDwGnoh8Hj
         VfWpKbArf382wR/yytjHbaaQ1McQ0hMwCxxAoNfBGUs1v2Mko9qr0qTzYLTvb1AMBfpp
         h8WO31+Z/sI5pzY5EjSCIsQZeuhIPXfpvPDl4YUi0aK1LGT1+V7d+JwkJT4XXHy9Ykgs
         +6BA==
X-Forwarded-Encrypted: i=1; AJvYcCVHnYrCodQUt656b5TaNhXsNvVsT54Zk0ZGJTEPwYAhPtI7uBLuvMsqhcyrxkMYojoPuC3FfCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZL4wkguqPDHtTTbdN4aOYwxf5WdsovXIK8X+OERVse8aXdIs1
	s6Xt1MPMuAAJ0eKD0HeUyd6Qg1hgElpJ01AHEV3ed0SjE2qA6qkQ7xBGzh24cGzUC3mYrjbHh0E
	tEIMtBWHQxl6tfA==
X-Received: from qknwm15.prod.google.com ([2002:a05:620a:580f:b0:8c5:2ecb:a10a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a85:b0:8c6:a5bb:f464 with SMTP id af79cd13be357-8cb8ca80011mr1772979885a.66.1771990338561;
 Tue, 24 Feb 2026 19:32:18 -0800 (PST)
Date: Wed, 25 Feb 2026 03:32:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225033216.601205-1-edumazet@google.com>
Subject: [PATCH net-next] net: use cmpxchg() in lock_sock_nested()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260744-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B206191333
X-Rspamd-Action: no action

Add a fast path in lock_sock_nested(), to avoid acquiring
the socket spinlock only to set @owned to one:

        spin_lock_bh(&sk->sk_lock.slock);
        if (unlikely(sock_owned_by_user_nocheck(sk)))
                __lock_sock(sk);
        sk->sk_lock.owned = 1;
        spin_unlock_bh(&sk->sk_lock.slock);

On x86_64 compiler generates something quite efficient:

ffffffff81e96100 <lock_sock_nested>:
ffffffff81e96100:       f3 0f 1e fa             endbr64
ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
ffffffff81e9610e:       31 c0                   xor    %eax,%eax
ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148(%rdi)
ffffffff81e96117:       00 00
ffffffff81e96119:       48 85 c0                test   %rax,%rax
ffffffff81e9611c:       74 33                   je     ffffffff81e96151 <lock_sock_nested+0x51>
...// slow path
ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d2570 <__pi___x86_return_thunk>

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h |  9 +++++++--
 net/core/sock.c    | 10 ++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 55b61e4b0d8318887d527e919fc1103d78ac6d14..84c21fb38a28406e387dc33e0fb5decd18893950 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -81,8 +81,13 @@
  * mini-semaphore synchronizes multiple users amongst themselves.
  */
 typedef struct {
-	spinlock_t		slock;
-	int			owned;
+	union {
+		struct slock_owned {
+			int		owned;
+			spinlock_t	slock;
+		};
+		long	combined;
+	};
 	wait_queue_head_t	wq;
 	/*
 	 * We express the mutex-alike socket_lock semantics
diff --git a/net/core/sock.c b/net/core/sock.c
index cfb2a6209946089669882cdbd5d1b36c53838989..2a03d1432111f2dcea9d700f80efb7b0bb4a47d8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3780,6 +3780,16 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
 
 	might_sleep();
+#ifdef CONFIG_64BIT
+	if (sizeof(struct slock_owned) == sizeof(long)) {
+		socket_lock_t tmp;
+
+		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
+		tmp.owned = 1;
+		if (likely(!cmpxchg(&sk->sk_lock.combined, 0, tmp.combined)))
+			return;
+	}
+#endif
 	spin_lock_bh(&sk->sk_lock.slock);
 	if (unlikely(sock_owned_by_user_nocheck(sk)))
 		__lock_sock(sk);
-- 
2.53.0.414.gf7e9f6c205-goog


