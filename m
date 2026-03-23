Return-Path: <netdev+bounces-270334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKO1JuKUwGmxIwQAu9opvQ
	(envelope-from <netdev+bounces-270334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:18:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0D2EB662
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B57D30028C9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208117C203;
	Mon, 23 Mar 2026 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8YA7PEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D661EFFA1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228700; cv=none; b=dNkVywtoZYfYwn/DrrodcgyQMWXuSiH0HypcP55RUbG+el7PJhwFZ9M00+GgANoAYOsbmjS7LXRGKCUojamEgCg4+VBQS68061wuhNSy9IID7mWKAaJ1dZLlzbGdiYWkaXnblJH1Kc45ty91Z34QF2jhvc1jLMWhH1uTIdRHGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228700; c=relaxed/simple;
	bh=YeZ8V6UkzHcniCt+npJv0xMO+On3fTtnYCQvUrXMX5Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ol8uhltaNunU4qOvZqdgzRgUFcuht+HXwbWdjwoVqI/hSTvc9SooI9dPv1YgrYf+SOPocsXr/aRAeV//PbQ8FAcofboDi8MdUI0JRy1ubxzbxSff4q1IKtFZ5T5noz0CJXDAaRoM40T0fU1gYT4yaYoW+lQVb1VFyOw0Z6Crths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8YA7PEh; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cfc1aced6fso350254285a.3
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774228698; x=1774833498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5xiHYENMCb0ZbJlSS5WSHJ9TfPuivE8E3mb14jdw7o=;
        b=d8YA7PEhguYi1jKHISa+UyQTuxXCPoZ9YU7Kphhk9QfF1mjtH7UuiMZMbbofl17kw8
         AS8TEqHCKM6CiIGsyeb2WLwi7PNniPlhwI0UIJhRwrF0u34r1mFFh9ExIGQjDSksBfx6
         gCeFoN1kC1p8Ikqhwa9gdnVTC08uPgPIqm2IIlYhLhIwZPPMDko6VfYzD+/sd5Eljcfc
         DzP2CsJHTfvo0Zxg+ZBvLJUJAYWc6BpEA/yuvA+EU80py4uNe6hlv9T00qP5QPJU4SEw
         OI+5YnRtBOSZKY3dH0I8DfIWxCP42Jipso1Wn5y5JsVl3gHRlLDgExsJGxuPvqsFAs8j
         2Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228698; x=1774833498;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5xiHYENMCb0ZbJlSS5WSHJ9TfPuivE8E3mb14jdw7o=;
        b=c+x2jktT/UnOmmN+fMWmNAZrk70EjZ3L6MtDK9g23HAKUXWuzc/3rZ004sx+mz8H4P
         lV5buqkfnUSSDNSi78F0wx4WFtE2zP5A+rqTXjHufCoya26h68Lr1RYop5Gad/Ll37ag
         nmXr9IoRo6RiAihu2TPaNgExGChEnYuf7N4JUUewOsdh46PauBpBSWWU2cSIa7HNYTQ2
         8Oz+28WJMyGkf5/m6q4myu5b2x9gsWgcW18aRzbK0u3PiL8tCv4RCJY0cUJORZ6hCFUC
         cbbxq0eiSVhXIwnqaPLJ7u8nzWz7E9iAlY3kw0uYFcn3HeJiyEhD1zpYHEnGSC7/ihvD
         TTKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgCTeqJM34vHkXJ/Mo5tJv2DwCEs0qqKyKbl8jcpMiTr0b9ukMXSvyiPpFOumyU3uM4aotnJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3W1zz2hdhoclR2IB4SfwiWUl2iTmN4cQmqIzQuC/4+jXkydDM
	dG/dLchLxobA7o4CXheKo00EZzQ2/i5Ph/aLASynWdUB82UXKopssuy34qnNAe2huDwM1bgC4ao
	8h56J6swDV20P0g==
X-Received: from qkip11.prod.google.com ([2002:a05:620a:22eb:b0:8b2:fb0e:83aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2905:b0:8cd:8fc7:831f with SMTP id af79cd13be357-8cfc7f7debfmr1531205685a.56.1774228698283;
 Sun, 22 Mar 2026 18:18:18 -0700 (PDT)
Date: Mon, 23 Mar 2026 01:18:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323011816.3737155-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: use __jhash_final() in inet6_ehashfn()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92F0D2EB662
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
---
 net/ipv6/inet6_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 109fbf620ad7cde54300b937db58ada0d5c80664..0a781cba4085f2f74b01518cbdb33889900d99ec 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -63,7 +63,7 @@ u32 inet6_ehashfn(const struct net *net,
 	a += (__force u32)faddr->s6_addr32[2];
 	b += (__force u32)faddr->s6_addr32[3];
 	c += (__force u32)fport;
-	__jhash_mix(a, b, c);
+	__jhash_final(a, b, c);
 
 	/* Note: We need to add @lport instead of fully hashing it.
 	 * See commits 9544d60a2605 ("inet: change lport contribution
-- 
2.53.0.959.g497ff81fa9-goog


