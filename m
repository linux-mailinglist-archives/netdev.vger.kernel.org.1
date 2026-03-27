Return-Path: <netdev+bounces-272370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEDvAq8CxmnQFAUAu9opvQ
	(envelope-from <netdev+bounces-272370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:08:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2633F07C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7A9230805D5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F8376466;
	Fri, 27 Mar 2026 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv7/SvrA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9735DA41
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584410; cv=none; b=ccg6wJMO8FIQrx5owTbD+grBK5gHlqufV+6vstDpNvRfsYax69wU2wYh0uebuEVa5i34lGS+ZSsDsT6MDV8hE3q4iZ6twDGMzg7cf7Sd1//dpF9/aQDNsZjYoKQ4dey50mkrvPkFu68bmvxxMWZdt/SqHvGt21dZDf2bpq/0llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584410; c=relaxed/simple;
	bh=US4/MfrsKSAjJXeXNAHRy4+g718qYpNaeRE5eERlm4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VQ/Migd70k0V/A+v277kaDb8iia+t4HxyEDW4oLS+p4k2AaoNBXEVG7QMGUhqPnHEgI/KskOTkdET8LIs/RBH5lJZkd88QvphNO+F6DgMaB7imRzxHWTGZGPMGqdwdTcISDc80vbQ8A9SQJmZ0NBEzwld5jlV94bagfkQ+zsvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv7/SvrA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cd827a356aso408197685a.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774584408; x=1775189208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7eeu4T+DZHqsWvLN7gc+G1+OVpenGlpWoQ4IMWWRYk=;
        b=Xv7/SvrA3pNWaxH5+pa+FZSCGrx0O95F45rVFv11D1FTYtBUp3iVAoiAcQuzdT0gIp
         ZbDTZ//bjedMLz1UZJwgoiBL3bQlnptPMtcW90X5KYkCiHZfY9644kEL9TeGnCMRMqzU
         UJIGz805hHcJEEMDvWIoWe5kRxC/UCsUUsY1FfzbRVKBPV0MXO2YO8X1v1QY2blqhcLm
         XlWtpM75aWa1kTIQ1JVjYAEJ/wYQQ5oAiLI5wSPUQHLKC8HncouhZebWqnQyt1pGt/3V
         hoy16omC2NYGi4bTnWQKyFeGQzYMZP1rJMd+89Vomr1S0CJdb2+3VpyUqIxZc64M5tq+
         h2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774584408; x=1775189208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7eeu4T+DZHqsWvLN7gc+G1+OVpenGlpWoQ4IMWWRYk=;
        b=CsnODGxThzFFa9rNV7v+NHP48KwOf0MMkh/+58jY6JJmt3fzt/QnU0fvCpxhD+g37m
         i8U+Q9PhUt6VlD0ebJYOfndzpkmUuoyaQf7n3TtGrSXR0TkWR25BdHv96UOjvCA2+Nkk
         6ystQqXhHdDqPuGr6TFhVsKyMW7xdjL7a2BuYpZJT63D2rpEQphp+iPhCl35QbNV49+s
         sMehkxkr8mROILSgh4sl6dyOEqmuhZRf+TiQCl3XLut9J1M/66cofZSIS3qmMGaFrSaI
         26Yhy3eoF4SZdyQZPd9YkQOwqnJLdXscuu2T+/KbZfX6FHDpBSHM/OrS1PbBDCQq22OF
         oNqg==
X-Forwarded-Encrypted: i=1; AJvYcCWesopc/RCWEN/YqGkoIbUUje198+2irMX/TvflSKf97kdrBtTfj8crWnq0UPbPY+goNNKG46A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2I9fbeV3K38M7ib3815yhcWFJnqr+MnYi+wZxzoa9uEThShf
	MlU+BCnGgZHt2HFiijXQfcHEEyAwhJ+9T3b0bR3yU0Y7m3/Ds2dplusdpQC3ar4rEhvIwBjkPs6
	7QTsBkCWRyPbwxA==
X-Received: from qkbdt8.prod.google.com ([2002:a05:620a:4788:b0:8cd:8fcd:4f82])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4445:b0:8cf:c729:a629 with SMTP id af79cd13be357-8d01c65da9dmr115600785a.20.1774584407740;
 Thu, 26 Mar 2026 21:06:47 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:06:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327040646.3849503-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tcp: use __jhash_final() in inet6_ehashfn()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272370-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ED2633F07C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I misread jhash2() implementation.

Last round should use __jhash_final() instead of __jhash_mix().

Using __jhash_mix() here leaves entropy distributed across a, b, and c,
which might lead to incomplete diffusion of the faddr and fport bits
into the bucket index. Replacing this last __jhash_mix() with
__jhash_final() provides the correct avalanche properties
for the returned value in c.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4 (-4)
Function                                     old     new   delta
inet6_ehashfn                                306     302      -4
Total: Before=25155089, After=25155085, chg -0.00%

Fixes: 854587e69ef3 ("tcp: improve inet6_ehashfn() entropy")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: also update the comment (Jakub)

 net/ipv6/inet6_hashtables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 109fbf620ad7cde54300b937db58ada0d5c80664..b111b51d69fc9b77ac6ea2576c1b553c74bb139d 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -42,7 +42,7 @@ u32 inet6_ehashfn(const struct net *net,
 	 * Hash laddr + faddr + lport/fport + net_hash_mix.
 	 * Notes:
 	 * We combine laddr[0] (high order 32 bits of local address)
-	 * with net_hash_mix() to avoid using __jhash_final(a, b, c).
+	 * with net_hash_mix() to hash a multiple of 3 words.
 	 *
 	 * We do not include JHASH_INITVAL + 36 contribution
 	 * to initial values of a, b, c.
@@ -63,7 +63,7 @@ u32 inet6_ehashfn(const struct net *net,
 	a += (__force u32)faddr->s6_addr32[2];
 	b += (__force u32)faddr->s6_addr32[3];
 	c += (__force u32)fport;
-	__jhash_mix(a, b, c);
+	__jhash_final(a, b, c);
 
 	/* Note: We need to add @lport instead of fully hashing it.
 	 * See commits 9544d60a2605 ("inet: change lport contribution
-- 
2.53.0.1018.g2bb0e51243-goog


