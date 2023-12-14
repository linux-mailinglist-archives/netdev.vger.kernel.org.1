Return-Path: <netdev+bounces-57633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901E813AC3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B33C1C20DAB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3F6979C;
	Thu, 14 Dec 2023 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4XfMv6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81A6979E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so8846100276.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702582185; x=1703186985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjHMfEabd+3Xlbiimy+s63yAHcYhAs+GhPJrBDH3K8o=;
        b=u4XfMv6CLPQ1e3SmInLx99++3XdwOJNnqAaJHh+32JAQiuty9dzz5REAQ7yXEPsspS
         s6p6Ae4PqUg8Zhqzch6rOmSxEYCbnc9z9foBnK+kKrkCUmsm7dLlC7lqFilkT1WwKkCx
         +IuLijOwWURah/fNUZsLfWcO0gByIlAL9cTYPTpdZJyjSfTlaPAfX/PUYNjWFTTNJxPd
         DyRK880jxScklS7ZmQbwOModmfK6+CbQGX5z3/nzDYqyjufavEr4Vit7jM33GB86gcKZ
         IwtepwCOWH/nUtK9rHtnzKu/53MrR8T/nirA5YN14a9HrexXlkSm5xNvONzuQVco/Jt0
         A3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582185; x=1703186985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjHMfEabd+3Xlbiimy+s63yAHcYhAs+GhPJrBDH3K8o=;
        b=baiUDcZM6/1lQ0uFlSibfc5JvoBjexqSzirnNRFZRJLyO3mK5w63FxrP+vN4Ds3bok
         85O9XBuzlFBQRMlh0cpR5DCLWG7VVysNLOBFgubTslS+uXinZn3icaLAy7oN/t8k7H51
         0bwSnBolSl7Fokv3wmGCdyAyTxn36pBtIeGEecZbQ2ZEP1LpkEZi9EfupSo7aADthXk/
         qPmg077YpfY3U9G9BS4odAXkAh+xPR3fYJuaKQbPSHKOwbhVxPeFfY1L6CXodqdIeVEd
         cSHas8yG4wTTGcvBLfD4bOFo3BoY/eltHDJxPx72QhpgVcaTY0/lxLgAZaX6RkJs7EhE
         geSw==
X-Gm-Message-State: AOJu0YxjGakWmPY4q1M/t98x2dW8vI29a+zHQzsJoimUsop6Qd30RmWc
	gES7YmkixcERV38VJ0qHcbCFRfrLKvfbpQ==
X-Google-Smtp-Source: AGHT+IEH6RGFY2wIIJvrpObT4+2Jzgo1EerYetJEjiWRDb8XWRQk5warZI49awWStLg25d2Z0AnxeJXhjPSEEA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:52f:b0:db5:48c5:302e with SMTP
 id y15-20020a056902052f00b00db548c5302emr102313ybs.4.1702582184937; Thu, 14
 Dec 2023 11:29:44 -0800 (PST)
Date: Thu, 14 Dec 2023 19:29:39 +0000
In-Reply-To: <20231214192939.1962891-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214192939.1962891-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214192939.1962891-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp/dccp: change source port selection at
 connect() time
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 1580ab63fc9a ("tcp/dccp: better use of ephemeral ports in connect()")
we added an heuristic to select even ports for connect() and odd ports for bind().

This was nice because no applications changes were needed.

But it added more costs when all even ports are in use,
when there are few listeners and many active connections.

Since then, IP_LOCAL_PORT_RANGE has been added to permit an application
to partition ephemeral port range at will.

This patch extends the idea so that if IP_LOCAL_PORT_RANGE is set on
a socket before accept(), port selection no longer favors even ports.

This means that connect() can find a suitable source port faster,
and applications can use a different split between connect() and bind()
users.

This should give more entropy to Toeplitz hash used in RSS: Using even
ports was wasting one bit from the 16bit sport.

A similar change can be done in inet_csk_find_open_port() if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/inet_hashtables.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index a532f749e47781cc951f2003f621cec4387a2384..9ff201bc4e6d2da04735e8c160d446602e0adde1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1012,7 +1012,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	bool tb_created = false;
 	u32 remaining, offset;
 	int ret, i, low, high;
-	int l3mdev;
+	bool local_ports;
+	int step, l3mdev;
 	u32 index;
 
 	if (port) {
@@ -1024,10 +1025,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
-	inet_sk_get_local_port_range(sk, &low, &high);
+	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
+	step = local_ports ? 1 : 2;
+
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
-	if (likely(remaining > 1))
+	if (!local_ports && remaining > 1)
 		remaining &= ~1U;
 
 	get_random_sleepable_once(table_perturb,
@@ -1040,10 +1043,11 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	/* In first pass we try ports of @low parity.
 	 * inet_csk_get_port() does the opposite choice.
 	 */
-	offset &= ~1U;
+	if (!local_ports)
+		offset &= ~1U;
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += 2, port += 2) {
+	for (i = 0; i < remaining; i += step, port += step) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
@@ -1083,10 +1087,11 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		cond_resched();
 	}
 
-	offset++;
-	if ((offset & 1) && remaining > 1)
-		goto other_parity_scan;
-
+	if (!local_ports) {
+		offset++;
+		if ((offset & 1) && remaining > 1)
+			goto other_parity_scan;
+	}
 	return -EADDRNOTAVAIL;
 
 ok:
@@ -1109,8 +1114,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	 * on low contention the randomness is maximal and on high contention
 	 * it may be inexistent.
 	 */
-	i = max_t(int, i, get_random_u32_below(8) * 2);
-	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + 2);
+	i = max_t(int, i, get_random_u32_below(8) * step);
+	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + step);
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
-- 
2.43.0.472.g3155946c3a-goog


