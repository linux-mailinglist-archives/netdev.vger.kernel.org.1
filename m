Return-Path: <netdev+bounces-258901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGcgC90qk2kI2AEAu9opvQ
	(envelope-from <netdev+bounces-258901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:34:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1771144B79
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20359307D7E3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C5311946;
	Mon, 16 Feb 2026 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiKcPciN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E03126AD
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252129; cv=none; b=Q4520AXbh5xVd6W22uxlmBArpIa45qIVQlKu+anb7pNfc6bCl89gaLKi6b/JIDr8cnWAEHWUcMEHg0Y7H2lf6LrEeaw3MGnm70C1inoqLHrgqt8eWLeXwpJGiop6gyXonAPgKyderRpxcaFElVAMYwHGRGFDhgT/3eGuRta5VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252129; c=relaxed/simple;
	bh=rlG/DxgPd7q/35swaGrAysZz42sFoj0/zB0U8MxVmes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ile5QJPxs34k7Yq4e9RFjqTbDnEsJMMlKOTAR4ORUULn6GAsELZV5ozAfjXMg/26LvG7b6y/iWsQdMfPlFt+Kfy8CQWAEt69gqxpYKwK8nisVvzRfxwt9ea9fi0ecipwqiJQPvKkl7YpTR2a+gbSmelVgR6PeZIGJukCOjaYWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiKcPciN; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70d16d5a9so1687131485a.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252127; x=1771856927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kqWDz9N4m+djrYEWNHYPUllecsCbjr8+FPEA6ovtuk=;
        b=QiKcPciNce9KWFRwhqb03U+YXmtMfrnCDePuEW+7UrzrnEbW5ZOF5T/rSAZjVS+CCe
         pqt4kDtKx8Jq99zlr6XuxQ4E4Y267dl4i16A6GjNYYQQXTR00xNTmtSjTM9w9aItGlIo
         3bJsVwGXv67t5u/2LgZGLxgOtosxhGVON4kOuu7LwPKVTFJuUJsR78RIVxKGP7S2ieAk
         xSwCiKh6lmGi5iC8516O+iGeTBZCtRQJYw5lRFRmj+5JNuOIIyh1lQHcWMVHhQ7tUrGF
         dQ9dduY6XEofccB2MuPgxM+O3GVVt6wdTL3xZ2oFaUWQyAekdoBa1asq3vlvRWyIAEK4
         ChpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252127; x=1771856927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kqWDz9N4m+djrYEWNHYPUllecsCbjr8+FPEA6ovtuk=;
        b=EJtoXZDb7WRZPAGvYwD713z6BJW7iwKI4GlOzNGJLiT3x2AbtN4KpuQKyPebzGWEHk
         b9DPW1UTBRBHz4hu57G6iQyFabB7QW2um2RfFjDBPJlYnrYn0zi5OAkNwHWX+KJm7d1l
         ZG+VVks9rE8H4GpBle5XgF95sGV4NWJ4b3vPuiWs9nquP99AAvShC0uit/CNBfHNndbb
         FiB4xD/Abk3jhaI33ncVJrv46JASdnfGr3zZtNkAfiIcM0jVC+D0SK89xvPA3nvjWQwD
         rKhsz5tL81fbt+GnFkZII5FUt1w/XkD5NVC1G1yR7aEMll2ifvlA5SYjOS1kOqWZeLqP
         t48Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+Jzipp9qq1vpVxJsPcvK9soeD4T+LJGA+YZQJcBPnQiGOgUUHFiXtgIiJH9jZBCX50zTAniQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0OxXVgD54cwa9PuL4iwBHWdtdiFeCvyi9g9FlsG+k4BaTIOX
	dJTYoBIaEHuBJFgXwjInLaL1tDIwdheQfvDZo3hsJXLAxUzPU9ctZzlZQcMINgS43LJ7VQkW6JF
	JQg3zMYxoHV6Skw==
X-Received: from qkof18.prod.google.com ([2002:a05:620a:4092:b0:8c7:995:507f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:398a:b0:8cb:54d6:7ba with SMTP id af79cd13be357-8cb54d6086emr509005285a.7.1771252126440;
 Mon, 16 Feb 2026 06:28:46 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:32 +0000
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216142832.3834174-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-6-edumazet@google.com>
Subject: [PATCH v2 net 5/5] ipv6: icmp: icmpv6_xrlim_allow() optimization if
 net.ipv6.icmp.ratelimit is zero
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1771144B79
X-Rspamd-Action: no action

If net.ipv6.icmp.ratelimit is zero we do not have to call
inet_getpeer_v6() and inet_peer_xrlim_allow().

Both can be very expensive under DDOS.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: fixed patch title

 net/ipv6/icmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 0f41ca6f3d83e86ce97ce5a30613f58f4dc22dad..813d2e9edb8bed7c1649e279cea9229806af4132 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -220,8 +220,12 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		int tmo = READ_ONCE(net->ipv6.sysctl.icmpv6_time);
 		struct inet_peer *peer;
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
-		res = inet_peer_xrlim_allow(peer, tmo);
+		if (!tmo) {
+			res = true;
+		} else {
+			peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
+			res = inet_peer_xrlim_allow(peer, tmo);
+		}
 	}
 	rcu_read_unlock();
 	if (!res)
-- 
2.53.0.310.g728cabbaf7-goog


