Return-Path: <netdev+bounces-267428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C1ONSj9s2mWewAAu9opvQ
	(envelope-from <netdev+bounces-267428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:03:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F1282A52
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0C163012E60
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB934D3B8;
	Fri, 13 Mar 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWzAq3E9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC02DA755
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403430; cv=none; b=dMMsqiRAM2CxZZhs2W3xH0hvrG8gO+80345ldfiJb3XTPnguiUGcaEd7xVZshJ2lIr9AzvnVIENm2mxhv+xdXW3MeHoIs+cyreB61/YiF5KbTOPGqw034XnOQKBFpnztqrlEdAmfk4X4EXvCNkxNjQGMTVwUvFuBV11d07T4UpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403430; c=relaxed/simple;
	bh=8ImYfB2tzqYGjOu1vTOY7m3nyhM1vkSu8wedccPHmC8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hzjqRd2XU+3p6jujeNKL6Wfud2ZLYHMYPWATuKefQO1O0mbPvft5vCnQuM/xsXinc6hR+S3YMDXGb2oCvLnRXW8/zMayI2Q1gUr1cvs4nNUr4DBKIPjVN0XFPRZBm8aDtFYsgnX8nICqIXUdZdnKyv6b/18KH4lUjpk+dWqQghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWzAq3E9; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89a174bd442so62097996d6.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773403428; x=1774008228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D6xnvSgowOgdv9q8gQbo09TVpLkgC6pEH5sJ9cGcOC0=;
        b=MWzAq3E9mUJ3RRohMDFlu3SeaBo9QGxkGL1unefXJY54VmBMP8Ed3AQPYj2S/2cVwX
         8pKWNY30eIr1ic56+2vKJiJxtTmk+RwP9b8mczeft0cbJo00YwdVI28Fhc/OAS/M77HF
         8dSzpXONX1pC34fRqkEzSpeNVhA7YaF+f8cB/F/dGXfF6tY9Y1aj3ySOwg8t230AyYe0
         r+aoqbmcLIeD3TAYB7xD7nq06Xq5jKUchko3+pYzrrgFii21g2Rz4ZpPFqggme0JN1WH
         XHCIs1K5T68ypSREeuhoxBJIJ6ikH1j9L4YWwOE2KqQaVBBJJreisHbFuxZUkTo1Dq94
         vEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773403428; x=1774008228;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6xnvSgowOgdv9q8gQbo09TVpLkgC6pEH5sJ9cGcOC0=;
        b=i6kV4LryKOYxcSRy590QS5ziVvQg1s0mKnmZLUbX8z9M/KbWT2jYbhgzZLTeeTHlmO
         xhyhL8xDftxuCyj2zEN9kEPCrWt+u1pOZBbZ0pxvHaAXTAPX+d0BWpgTQGBXCtB15hvH
         fBksw64Jb7NaZfpSeau2G9lFLa2W3GyJ7iD5VIa4ZTulsZxJrrasjtZ8K1zVLijAyFQE
         +wTwBFWFQFsQpaLQ4zpnBiyVacTK2tNuGWShtDmrrCPoJg761NO/pPw6RtucZvIHNUqQ
         m5Ef06/Po8JLWaothyGNbGSHeb6BKZILdefppQIk4mwXplDhPdLg3FSjQNudoCj/pxXN
         0ByQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4BpJHbe1899LdrDBM1VZ85uSEq6c0Q310B/yVncSUxBZiRNW5U4AnFVfuHcY24xBWBfcuEnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmgYeZhrTlecJbHzMBA+t/b56/MyYE67VCfIRoy/uXhV3EQ0H
	tis5C6rJJotzkxqz+sVKp9wBcxRypAXDhg7iSEt9WwHnI17Yzx8yj3nX93tfM+Q6WMQW3pyzGCx
	W+etUDaoDw64faA==
X-Received: from qvboh2.prod.google.com ([2002:a05:6214:4382:b0:899:f84a:7819])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d66:b0:899:e567:f04d with SMTP id 6a1803df08f44-89a81d3283cmr47236576d6.11.1773403428262;
 Fri, 13 Mar 2026 05:03:48 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:03:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260313120346.3378811-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tcp: improve inet6_ehashfn() entropy
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267428-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D7F1282A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of only using the 32 low order bits of the local address,
use all of them.

Xor net_hash_mix(net) with the 32 high order bits of the local address
so that we can use __jhash_mix() three times.

If we were hashing 4 extra bytes, we would need one __jhash_final()
which is a bit expensive.

Using net_hash_mix() at the beginning allows beter register allocation.

We no longer use a cascade of two jhash and inet6_ehash_secret,
this was dubious/weak.

Add a comment explaining why @lport is not part of the jhash computation.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-24 (-24)
Function                                     old     new   delta
inet6_ehashfn                                330     306     -24
Total: Before=24855958, After=24855934, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: do not include @lport in the jhash computation.
    Add a comment explaining why we need @lport being added.

 net/ipv6/inet6_hashtables.c | 40 ++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 72bc68fef48abc2c423c688b47154256828555e4..109fbf620ad7cde54300b937db58ada0d5c80664 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -35,13 +35,43 @@ u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
 		  const struct in6_addr *faddr, const __be16 fport)
 {
-	u32 lhash, fhash;
+	u32 a, b, c;
+
+	/*
+	 * Please look at jhash() implementation for reference.
+	 * Hash laddr + faddr + lport/fport + net_hash_mix.
+	 * Notes:
+	 * We combine laddr[0] (high order 32 bits of local address)
+	 * with net_hash_mix() to avoid using __jhash_final(a, b, c).
+	 *
+	 * We do not include JHASH_INITVAL + 36 contribution
+	 * to initial values of a, b, c.
+	 */
+
+	a = b = c = tcp_ipv6_hash_secret;
+
+	a += (__force u32)laddr->s6_addr32[0] ^ net_hash_mix(net);
+	b += (__force u32)laddr->s6_addr32[1];
+	c += (__force u32)laddr->s6_addr32[2];
+	__jhash_mix(a, b, c);
 
-	lhash = (__force u32)laddr->s6_addr32[3];
-	fhash = __ipv6_addr_jhash(faddr, tcp_ipv6_hash_secret);
+	a += (__force u32)laddr->s6_addr32[3];
+	b += (__force u32)faddr->s6_addr32[0];
+	c += (__force u32)faddr->s6_addr32[1];
+	__jhash_mix(a, b, c);
 
-	return lport + __inet6_ehashfn(lhash, 0, fhash, fport,
-				       inet6_ehash_secret + net_hash_mix(net));
+	a += (__force u32)faddr->s6_addr32[2];
+	b += (__force u32)faddr->s6_addr32[3];
+	c += (__force u32)fport;
+	__jhash_mix(a, b, c);
+
+	/* Note: We need to add @lport instead of fully hashing it.
+	 * See commits 9544d60a2605 ("inet: change lport contribution
+	 * to inet_ehashfn() and inet6_ehashfn()") and d4438ce68bf1
+	 * ("inet: call inet6_ehashfn() once from inet6_hash_connect()")
+	 * for references.
+	 */
+	return lport + c;
 }
 EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
-- 
2.53.0.880.g73c4285caa-goog


