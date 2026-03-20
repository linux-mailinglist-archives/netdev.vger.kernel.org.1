Return-Path: <netdev+bounces-269811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCTlKU/2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE312D692B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1215C300D461
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60835B62A;
	Fri, 20 Mar 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNtryrub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AC35A3AA
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991402; cv=none; b=V+32Z41I2QaJ4alqqzQ7Mzp+dmpdAlgf30mwAveMjGPtROPgKaTyHR+R/aywMhhol7iXVP1GbarPsL1ZnJTaDcFAZGLyztsKzMNZ1sgdEV3qnjeOgjs0aPVNMvDDRKNN4ZUgmdtyjp34pLHjR4ycE7Ay4dHOGt28qAUgtiN/8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991402; c=relaxed/simple;
	bh=Wc4MiRjL/PXuQ03s5/LF0WGC9SyHSIsfCOC+jUHFcp0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gMC9thGAfscEf07Faw+ngxJO9IP2N/7YcRljP9qNXJgDUzda/0YULIBy2PSJjzEAYhLhr/GU0edlZfUJlvo29m0F4rLSyOdgquyRTq6N3Yr1VH/XyaSGX60YC/hgKjzW7HiJ2yrOx+HvOhSpS01XRU9HzokMzeo69IhE/xe+Nf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNtryrub; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a106b687cso1009745b3a.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773991400; x=1774596200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7e7z9BPgOZI2//OlISLrUetsLlsbIgJoQN9d42Pt+vs=;
        b=mNtryrubMpFEU/S06KiLGITbwr/aog78K2ynNLHbbR9o7gZI4fGZ01J6xk9NXY2BMc
         khLmjlSRmuCd/clb6s4CG13WVvOZ+Nvf6J7PC1tg+Y4QMZRYBS5gWQJfDXKA/8LSoquJ
         kPOYd+dxkEvuBHdmdB583VFqQDbErEl6wBn6XDOFDhIRS0ug3u5k0wcwMiKqLHMMOkJA
         6ETjv0wW9dsxlk8qvSCUwMyPVfbhOiz0Mo7A4b+bloyCLYeACgMtzKEsHSwGf1xdt+vx
         2uIsUkjUN7hKSAaNfeBNh1hvn/OMtQIsfZShJBs1AyHCMdc6r4d7vkKd8/N1Wkisdrhv
         AF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991400; x=1774596200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7e7z9BPgOZI2//OlISLrUetsLlsbIgJoQN9d42Pt+vs=;
        b=jrHeVXt160oinD8nUOp7rHOQPnYu8QrPS+o93E4QfruHN6m+8erPa8Zk8VEgOiH+nm
         HrdgiWyTiQnkIcN5cdAMBzxtzg4dsZokxf8cQLpR9QTrLuLbGYhvMDJpGadq7MBl+g9K
         Ih0XygxT13CAlhNw4dACeDfmCuOCq7Mc+XzAPcbaQJ9ZgEQI4ZehWAdACB4SBHuA574w
         5GeOsd31/HxdHRUZCIWtXU5UGrzsthWsBw/ieFYlgY3X+9+30jfci1I9EQXOLXtOGoH2
         IpvyUt6iwE48xoGDxbPhWWJ/li9QsBQBRCUYJGHEDr3yGRYB8tr6qPxnvih1vN9giMwO
         Kzzw==
X-Forwarded-Encrypted: i=1; AJvYcCUxj7IML4Vd3EjBnxFlDwYVEoIv88G3X2SsfKC6Drj3g9Lrthx4ycbzdfy58WPRKkV9Vu6faGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4pc2HGJoyN/tk8RrWRmpveo5B21XF02mtZDQaKwVjwV+eWT+
	1Gjw4reAgUCbmRxlwNI+LFIfecaElmsrPN1LE6Kn+8ZQAYYgr3wU1hUB/r/DreZEiTl9YVPWuOm
	l+jfuGA==
X-Received: from pfbde10.prod.google.com ([2002:a05:6a00:468a:b0:829:a298:e5f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bc7:b0:829:7553:afc5
 with SMTP id d2e1a72fcca58-82a8c23301bmr1448594b3a.4.1773991400196; Fri, 20
 Mar 2026 00:23:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:22:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320072317.2561779-1-kuniyu@google.com>
Subject: [PATCH v6 net 0/3] ipv6: Fix two GC issues with permanent routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269811-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.877];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE312D692B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.

Patch 3 is a selftest for the issue fixed by Patch 2.


Changes:
  v6:
    Patch 2: Call fib6_age_exceptions() under RCU

  v5: https://lore.kernel.org/netdev/20260319041427.1528743-1-kuniyu@google.com/
    Add selftest

  v4: https://lore.kernel.org/netdev/20260311052954.1224278-1-kuniyu@google.com/
    Patch 2: s/,/;/ for fib6_gc_args initialisation

  v3: https://lore.kernel.org/netdev/20260309180804.3471287-1-kuniyu@google.com/
    Patch 2: Use IS_ENABLED()

  v2: https://lore.kernel.org/netdev/20260308032304.1841198-1-kuniyu@google.com/
    Patch 2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)

  v1: https://lore.kernel.org/netdev/20260307024709.718395-1-kuniyu@google.com/


Kuniyuki Iwashima (3):
  ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions
    expire.
  ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
  selftest: net: Add GC test for temporary routes with exceptions.

 include/net/ip6_fib.h                    | 21 +++++++-
 net/ipv6/addrconf.c                      |  4 +-
 net/ipv6/ip6_fib.c                       | 15 +++++-
 net/ipv6/route.c                         |  2 +-
 tools/testing/selftests/net/fib_tests.sh | 61 ++++++++++++++++++++++--
 5 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.53.0.959.g497ff81fa9-goog


