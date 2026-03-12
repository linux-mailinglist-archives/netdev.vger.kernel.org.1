Return-Path: <netdev+bounces-267026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNbxMw2ksmnwOQAAu9opvQ
	(envelope-from <netdev+bounces-267026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C27270F57
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761D5324DC17
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA423BF68F;
	Thu, 12 Mar 2026 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjrnREJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0983BED54
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314701; cv=none; b=Z8i26vNyksNasI/E//DmuRj/7WXmYLuV7uYIGz8D0UoIUP/CN89dxVt/NYFZ8A+lqAKedhluwOXnzFitAS2NRlitGyLK/K2v0Z5eqIRMzhn+b1WolgiZfBZIpY+COfxJiZ6Xc+fO5NaJjBj7vs7Rc1tVIuccInILNs8aRc+2tDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314701; c=relaxed/simple;
	bh=XZ3HU2abgLtxMlcIyycB5AGR0S/kq3CI/nxNfozc40o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=exbXvZ4uvc+rjbwMlPIdlPsTQw2TIWnjJiws8Yijq3vYIVbJe53/w34smQfVYMEafXnISCsnR+fN5i2KZiV1gbrhkEqzE8shPae8DVFVsLXERLTKw0R/NRIUtLddWzghQ6jDGL/hIyODtwBVmXTn4QEDOmmqCydYs03E37E0NQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjrnREJ7; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd77e5e187so479581085a.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773314699; x=1773919499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jD5MuEFel/X/DRavo2Nkc32vDmB8wgk9AmXB2GE2xDA=;
        b=LjrnREJ7hB43iBAdQmzbyvOKdlAVH3d3ATMcZfR7LOakEDYrbAkLIjunJcdGGQbUfe
         avTM/zA3OFCl1mRz4/UNU5WPN/RTAdR8u1E+hiLcZeFRFbVZfkWKx5I/BMeZtLPs9vuQ
         hv0OcDA/u+pbjUc0nfbHE6SKsEKoL0IJ8mOANsCiReso7H1KO6MyIrOVEShqeapWnPid
         UxuJLM67UEIt7Qtrz0R3iLqK/YaxYIlXf0/go3sMwP2hu4lgeRV9TRvpwGcUOy4knWDT
         bi0PvTQ+qhEb14Z/hGuUPujSyXnfn80Y1xjfrnDhxU3H9X5o4o0dhDf/3f2VsREsdILk
         RmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314699; x=1773919499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jD5MuEFel/X/DRavo2Nkc32vDmB8wgk9AmXB2GE2xDA=;
        b=BCQtGG1khvBqCkepgfgYCoNt0TsfSeShkNNNC7uYwuvMELedSLEiDXaDOJHjX7lDM+
         ov7QSaXAtR58tmvAIhSuqxW8CeAOaq7rpZKu+UPlHq9sglqwzyRtqiNGXDq8XSVGppsc
         KRWts1dQojeuWEKuYCC/IP4gMiXVn25sSaEDXxUuqaCccDInYTD/RnP9WVzgifcM/uYU
         meM/fhSDAmjydHLBUOpF73+i7Uasfo/eb1rLjI1gFmzGsHnrwHIQoPBQ1uGEqikLhvvy
         cmFwH7KEkJaSyzlbC1AE2BVCbWRWi78wgnGEoWOf/rLS2y7VP08inwIqUOrp0F6UqWZo
         QUfA==
X-Forwarded-Encrypted: i=1; AJvYcCWYfRqK7Cad0vl9oolvwD8mvwYvcPzUkzAutoRv856DwzLVm36AOAl951ISHNLYtkbMgTNwE2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTkuf/yhpKVIl+XqfmBIR9f4VuoStmdV+E83siYlDfu8BXaJX
	KwhUqbnVNq86EgLjOTiTAbsLuaaLkcGzTqN35UjqE0bL4q9MRuKkr4VYglSBrDMHqooABtWWtud
	H+ZUEuO7wHN/Quw==
X-Received: from qknpc16.prod.google.com ([2002:a05:620a:8410:b0:8cd:7aed:be78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4153:b0:8cd:8884:2509 with SMTP id af79cd13be357-8cda1a5162bmr726476685a.55.1773314698408;
 Thu, 12 Mar 2026 04:24:58 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:24:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260312112457.3606806-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: improve inet6_ehashfn() entropy
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
	TAGGED_FROM(0.00)[bounces-267026-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35C27270F57
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

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-27 (-27)
Function                                     old     new   delta
inet6_ehashfn                                330     303     -27
Total: Before=24855320, After=24855293, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/inet6_hashtables.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 72bc68fef48abc2c423c688b47154256828555e4..bf3c9bbb2107c05f18ca296cfb7a54d2d0ed558a 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -35,13 +35,37 @@ u32 inet6_ehashfn(const struct net *net,
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
+
+	a += (__force u32)laddr->s6_addr32[3];
+	b += (__force u32)faddr->s6_addr32[0];
+	c += (__force u32)faddr->s6_addr32[1];
+	__jhash_mix(a, b, c);
 
-	lhash = (__force u32)laddr->s6_addr32[3];
-	fhash = __ipv6_addr_jhash(faddr, tcp_ipv6_hash_secret);
+	a += (__force u32)faddr->s6_addr32[2];
+	b += (__force u32)faddr->s6_addr32[3];
+	c += ((u32)lport << 16) + (__force u32)fport;
+	__jhash_mix(a, b, c);
 
-	return lport + __inet6_ehashfn(lhash, 0, fhash, fport,
-				       inet6_ehash_secret + net_hash_mix(net));
+	return c;
 }
 EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
-- 
2.53.0.473.g4a7958ca14-goog


