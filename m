Return-Path: <netdev+bounces-300594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QoOBK2jLNGqyhAYAu9opvQ
	(envelope-from <netdev+bounces-300594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:54:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B666A3DC9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=MBVUw0hf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300594-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4BD33010930
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 04:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE73064AE;
	Fri, 19 Jun 2026 04:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737A1E4AF
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 04:53:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844837; cv=none; b=HTTR5q9pNUTq7l0d1aDOqTBzOOuNldIeUGNm5i/+u+9NfUMGn84Mwi3HmBuwQ2xDjXGmkFpiZnP31yoy5zjKVgb9WjdNrFYLe1NxxRmjpMPbMXgBd99+aaJGOeYXVtNi1g7d16DMC7ouUnTG6dwv3Q9W8B8fQhYlxPvOrZjKXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844837; c=relaxed/simple;
	bh=3jWn4EzQJfKNvhwC5KDObScAku08LMQGxJrNv34+npA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuzRvE81oAgWf+aK34Y8acSwXbg6OR1T8s6FT4Y/lPgNAdv3jul1h3zaAwbWEo/XOWFFmh/atW1glctZC+3p1ULVwjQLUvwJve+ZjsQGG0T0xgH5vegN62FnsPf7pzlRHIC+OSEIgzi1tkiFsKxRMs4N8lLmcbRljneLyeh2nJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MBVUw0hf; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842848fd613so1574432b3a.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781844835; x=1782449635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oidVFwmO55NaYIhOFkhTJdv32VPVhBHkGqTi4TsqfpQ=;
        b=MBVUw0hfdINvn0Y1zfwBrmVL6AJO6jBHqI+/yAymAc+Avvx8kaF7vz+KIVTS9dzA+x
         CJZsG7iaMLKMimOEeLm38ACzjKKyxr9hwqGnjCjJ+3aDkhqulqGGDZbUr8yDnil3mWGv
         /3Ig5Q90NBvoVpGI1qAMA/fh0sMP5nRWYg99KrpaKTgQxx+Sk+CG+qRkxL8MHcy51DpR
         3vYl9YomvSk89jY4M06PwyloMhvYJW5IT0ZwNYFGUUGghp5IGkhjy3VQBe3OH774gOiA
         r1XhPbDYNSHcOqhrBKVh5iGb1TWIetfOutm2XeriBBpHr27UtvWtrBnkpSX7hXaGNRrv
         nFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844835; x=1782449635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oidVFwmO55NaYIhOFkhTJdv32VPVhBHkGqTi4TsqfpQ=;
        b=TP4Oj9bVh9Rc6JZDWHiqpmkLBoY2jShWdGB0vn7Lqx+B9n8mcRBMh/OQcV7iIyZEo4
         /pOA3pdHh8jCc1q2gZ9zKIjmJcVoltK+MxIx/FQAtZEE09Ep7E/NmLmxEnZ35uxA48GX
         ntWfHV3ASYiGi2UWgNSEFG2C8JZtfu0uKx4xgz/RbIrgQ6Zmsn1kTQMX3pHsytCdzyLN
         q9tc51jsfXMuNHL0moAeYyX4CzZfFoECBJQz8M9K05uckgsunoxAORj+WT/QMHSYZWKn
         NTRSPpCh97nERi9MWM5zPiayzKE5C6t0B60mAyZRGbCsfc1uLWIIrLxUMVokZ9iK6Lh3
         ujfg==
X-Forwarded-Encrypted: i=1; AFNElJ/E89OxaEUDAopswuWcsDlFKb1a3eFDLefuu1L+VmEWALZsCCiWDLtp1lTlGDlklJ+J3VwNvVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR9+VYkuUB5h3bJ2ssl/F+iQ1e09+pU5sNdbUrAnR6CbXXAS4
	I+XxZeBKDeBZh/dkLebKQfvHYzla2ad/NKmPSHHiR8lW8Ql7NAh3hNUwK/AiAlXGpw==
X-Gm-Gg: AfdE7cnyLUd2zuQujaUqNJNrpUO2IncVXNIDBN7xmBShdB6w5ZbOF2RGzlbxFTEKwWf
	qdBWhsOl83Hxwso/aHeZlG4UNkCWZFMwYVHujdJQPdvop9BNVRUXvEQI3WmLfGfVCrmzJdpOSgQ
	WUoS/AI6yigb0zt8dP/sb6/gLRoFX5H8PmiZ1ZIoOiyW48mXL4U1Rnl5GgqpykEjSBLplpafpjT
	luCkkYi8vTRl/xySkENI+AfXnqZtQJyZ57GUK9cxR+XZsxw5cd9qxVrKGLvxDYmJoPLLdHjH6Em
	GChMkGtTiv/W4p74KKPCSpeA8+xaw7MTtQGicmDmO8ZjFDsuVfZK5fcwyUAq6wyoqh5Gm9fK7R5
	kOEL+71H7TUq8MtIRy7eh/qAIIV78LDTOn6LmhW57S+0SNY7FlFYRYpcGC/WJwW2tHEluNA==
X-Received: by 2002:a05:6a00:6017:b0:842:6fce:6171 with SMTP id d2e1a72fcca58-8455077c299mr1955991b3a.3.1781844835522;
        Thu, 18 Jun 2026 21:53:55 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84553829252sm928782b3a.48.2026.06.18.21.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:53:54 -0700 (PDT)
From: xmei5@asu.edu
To: dsahern@kernel.org,
	idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
Date: Thu, 18 Jun 2026 21:53:34 -0700
Message-ID: <20260619045334.2427073-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,asu.edu];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:horms@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300594-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38B666A3DC9

From: Xiang Mei <xmei5@asu.edu>

fib6_nh_mtu_change() re-fetches idev via __in6_dev_get(arg->dev) and
dereferences idev->cnf.mtu6 without a NULL check. addrconf_ifdown()
clears dev->ip6_ptr with RCU_INIT_POINTER() after rt6_disable_ip() has
released tb6_lock, so the RA-driven MTU walk can observe a NULL idev and
oops. The caller rt6_mtu_change_route() guards its own __in6_dev_get(),
but this re-fetch is unguarded; nexthop-backed routes survive
addrconf_ifdown()'s flush, so the walk still reaches it after ip6_ptr is
nulled.

Return 0 when idev is NULL, matching rt6_mtu_change_route() and the
fib6_mtu() fix in commit 5ad509c1fdad ("ipv6: Fix null-ptr-deref in
fib6_mtu().").

  Oops: general protection fault, ... KASAN: null-ptr-deref in range
        [0x00000000000002a8-0x00000000000002af]
  RIP: 0010:fib6_nh_mtu_change+0x203/0x990
   rt6_mtu_change_route+0x141/0x1d0
   __fib6_clean_all+0xd0/0x160
   rt6_mtu_change+0xb4/0x100
   ndisc_router_discovery+0x24b5/0x2cb0
   icmpv6_rcv+0x12e9/0x1710
   ipv6_rcv+0x39b/0x410

Fixes: c0b220cf7d80 ("ipv6: Refactor exception functions")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ipv6/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6361ad2fcf77..a1301334da48 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5055,6 +5055,9 @@ static int fib6_nh_mtu_change(struct fib6_nh *nh, void *_arg)
 		struct inet6_dev *idev = __in6_dev_get(arg->dev);
 		u32 mtu = f6i->fib6_pmtu;
 
+		if (!idev)
+			return 0;
+
 		if (mtu >= arg->mtu ||
 		    (mtu < arg->mtu && mtu == idev->cnf.mtu6))
 			fib6_metric_set(f6i, RTAX_MTU, arg->mtu);
-- 
2.43.0


