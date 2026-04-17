Return-Path: <netdev+bounces-279416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHHdFaOX4mlS7wAAu9opvQ
	(envelope-from <netdev+bounces-279416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:27:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7A41E7D1
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C813055E9F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38D3033E3;
	Fri, 17 Apr 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4DERvOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216E2FF17A
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457542; cv=none; b=PYuH6X1SK7S06pWVq7PWUQV0xE9e6zUqyMwfC7qQRHGUcl4E9K7VveLD8jBftfXucryoqy4JR8LbJKwkdfP6196d/LWg3ONNdqe2WDgBq5pfV9tO3d5UDQESMSW5o1WCHg5WGA8z1qqVPubSDtydgvIH17pAq+HKdy9xxISw/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457542; c=relaxed/simple;
	bh=aj1AWvC8XbRVZ84THDbjAbLYwcPNCY8pg/zxBAkidcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6WdZMjwuxxunTAKwkFwe/zq94v7UPO1ld8PbK3RAAS0oEwVkgC5w48s5TRzkDOeJYqAvzAg+2/yzMk36IO9GLjIJF4uGfgok7OyuX92Q/5N+gcfIUgXwq3N9SGu8qC/HNicUrcBKQ7m43zz+CJTbIXgdaXLdTOBM+RYGtQpdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4DERvOx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7645adbdso646893f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776457539; x=1777062339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdlRI90tG77ZcO4PzgXRbhAv78/rObSf67pj3SzFeiA=;
        b=n4DERvOxFodb2N/tkbprUyJKRKZld+2UklsHd6jQTHAoNxNTe2YkQsmiHDX8+2JTQ3
         5aFU8nYgcEpAdRw1JMxaIrOfHXOaUVwPLTudmZ+Gc+dlxxsO+s0EzUr6WUkTkQmPoObl
         67zgSDveTxlNrfYPaiuXdGk7ytGDS/mwoGgqmCdfBXpItFoOhnrffudG1ieGMosAD7e9
         gTUwEltAIn97GFLqlPqihMhhq3+okKTZ452Kecv+9X/cTpQEpn+Gz7pom5oyovH7kjB9
         56JhC2cVciEfUvqfsO2/3QqFCo+VbISLFIkNHBo6NdFKRGfn8OohcBLZUr+f3KrP5ybB
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776457539; x=1777062339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdlRI90tG77ZcO4PzgXRbhAv78/rObSf67pj3SzFeiA=;
        b=s9F5vb4p8GcGIm6RPBiXi5NXi3zC2tOrj+3scAgKs19pH8WgCjmJjT4BfXdoNfZZMS
         Eced45RTW3Mv1oliZhLA6Crr/HN51NnowJ3v0HoyK34BQ4UEHdH3NeqE0lpLa0jTiY4O
         J+Pcwka0zXHV/DTsnhAmlv17IXV+KlaST4j4D0uuxWh7UM9IAbybqvg+Cr37Aengq6/D
         veNPm69EzaasOaUgJTSZucB3BMGdG1nqYvytzj9+36gnIfUkpAmVVxll5mviTDJRIP1K
         WEnF7KWAwCsPavEWYxzFVqquqzfGpH+EYTENIVLJCVoNyxZ8fcfcjOuEQUvbKCN5oUnE
         vDAg==
X-Gm-Message-State: AOJu0Yz3ez3SvBWmD3I3fMnzahDaN8NPst2Mx9YdmKGS75OgGHMzjO8x
	0Gu/x5RnycCFtetCFr2QQ4iGj+vWuNnXBbrpjumzq80c3j9rZefbuhvu/6YulIQgB74=
X-Gm-Gg: AeBDietElm7qUJQ3SU1pS9EP809X/PktW5v3raeW/aeAz40OkDdqTajPFqQEMbDttMS
	cKo9McA5d95XfgbZJt622JVMO0UueCP1P4VKLUcJ1puXoK0ge4kRKdWJTOLKpmCvepH2zYlSZcz
	l4/SH9sYDAoIIuBQUFHdkK616/Zc+ltGUUTJ34cpK1C9nXQ/3Q+6G87hbLSQQZsgA7A2DHTDmyv
	kV12RYaYOg1EBZFS7HZrDzwwrdQrP9CGBrZWtLDOLWilBbLDYGb6YG9hjTVqVlj2RNLAwd3VJJD
	gVV0gQgRwYEa3j6rj55KoPQmlKUizaHWKwLm59nGjsb7OOeFdChLm2MZT9bFbyKxaFvyeXifalK
	0cHomUxjgKHQRVqpGLXkLLyG4EzSWi/hXSTWyxxeLSClJo6xrdXoxtcqWhsurzIRbGtKO2h0xwQ
	h/JaybXgV4CWOJeGGLJcgogb3BgW7A9qxFUTzs
X-Received: by 2002:a05:6000:2383:b0:439:a95b:3c43 with SMTP id ffacd0b85a97d-43fe3dc0e4fmr6610154f8f.21.1776457538949;
        Fri, 17 Apr 2026 13:25:38 -0700 (PDT)
Received: from i3.local ([2a02:3035:bed:c6a6:3d8a:5cd4:13d1:48e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm7455830f8f.30.2026.04.17.13.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:25:38 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	ncardwell@google.com
Cc: kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH] tcp: fix orphan count order in __tcp_close()
Date: Fri, 17 Apr 2026 22:25:18 +0200
Message-ID: <20260417202518.1354891-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-279416-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rubenkelevra@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3C7A41E7D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__tcp_close() calls sock_orphan(sk) first and drains the backlog with
__release_sock(sk), which might call tcp_done() which decrements the
tcp_orphan_count. After which we will increment tcp_orphan_count again.

Since tcp_orphan_count is an unsigned int, we underflow to uint_max if we
started with a 0 - at least on all current supported platforms.

I could not locate a direct user of this value, and in
tcp_orphan_count_sum() this underflow is contained by adding the unsigned
int value into a signed int sum, causing it to behave like -1 on current
supported platforms and then get clamped by max(n, 0) to 0.

The impact therefore is currently limited to e.g. tcp_too_many_orphans()
checking an artificially low value, if the cached sum is refreshed within
this timeframe.

This fix mirrors the previous fix I found while investigating: commit
75c2d9077c63 ("[TCP]: Fix sock_orphan dead lock")

Later commit eb4dea585304 ("net: Fix percpu counters deadlock") moved the
increment down for old percpu_counter reasons. commit 19757cebf0c5 ("tcp:
switch orphan_count to bare per-cpu counters") changed orphan accounting to
plain per-cpu counters, so that old reason no longer applies the same way
now.

Fixes: 19757cebf0c5 ("tcp: switch orphan_count to bare per-cpu counters")
Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 net/ipv4/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2014a6408e93..1a91cb31b02f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3234,11 +3234,10 @@ void __tcp_close(struct sock *sk, long timeout)
 
 	local_bh_disable();
 	bh_lock_sock(sk);
+	tcp_orphan_count_inc();
 	/* remove backlog if any, without releasing ownership. */
 	__release_sock(sk);
 
-	tcp_orphan_count_inc();
-
 	/* Have we already been destroyed by a softirq or backlog? */
 	if (state != TCP_CLOSE && sk->sk_state == TCP_CLOSE)
 		goto out;
-- 
2.53.0


