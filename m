Return-Path: <netdev+bounces-162106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B36A25CD5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4474E188605A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1172AEF1;
	Mon,  3 Feb 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xos+a6nP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857F20469B
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593050; cv=none; b=lzI3CHFVQR/pz0elMrQCnfLdz0xzmPIZQHjgfsbShPhcjidjI9Xi85zFM2nRpmDPps2NaWeox7UrIiw2q3zce+8ws02qhnJNP5St9QF9GA6o6M0brMqJJqj4H3NEASqehLLpHVHFbG0vjbWtlhbivvMKo00ABr1kyYoqfhCieZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593050; c=relaxed/simple;
	bh=U2yJe7SRRwk4nISzmW4DbEXKjeztwraC/V5kPyh6rcE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MLfJAFxo8UzDI43TnCGaqPILSmV2v81P+gORbmZtGFxZuq3nPUu3YKA7MuFmcNYebG7TT5qQjRqYVv9I8mMTfdiDuoYrM2K/XeWTWf2B4m0hA0FuIPqewL/Yi+Sjvhasp4CiCzdHLZZfzIICw9dQ04kAjY3IgBqJ3sEBj5Tqdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xos+a6nP; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6dcd1e4a051so90104406d6.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593048; x=1739197848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Egmtd4QsP8U1AmmPAo76DX2dZhG0Km+dIMYJczrcj8=;
        b=xos+a6nPfxFZsFVt0BA4qsP8JKA4KDwuYG9nLuRZat8ZKg6CrxexShnAW7agISIaGK
         t7Tj8otpZATFmMfc7rCLiSevfqjCgsQoY/yjrH65q1zOBb+Te0gf5QzQ5UlSxUHcVYh1
         6wpy7UJ1baBWLw4GDXZpXZUJ8GCmJrEm+766TrAmGrHCUKMgPAHQCOfvGgYu0lS2MqCJ
         KIkj4zrR1TV4O/0nA0wu585+UMBIF9YTnJ/IHtI32pXP8YPqNPjZ+mxa2/pIth8DxWz2
         z3kO2nOWmDCe3eH96XVHBDk1kNHA3wd90MuUyCCRloansZOOmbB/vv0Dr18idRb1S8kX
         vWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593048; x=1739197848;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Egmtd4QsP8U1AmmPAo76DX2dZhG0Km+dIMYJczrcj8=;
        b=oDNiz1wGJ8PyJ508QUaY4TtxibcC2ANr2Zs1RYiDvDftirfHfQ6+Rk8hkw0n9/in/e
         g97kcj4SRU4uIMknhfB7me0EAQvZjJs1m6e9g0WHlOiC+JE0+C+ohbmrC7WavmfqA9r6
         7+ppCC8Fl6Ow8gWWnw3aRlNrLtYhNQkQjEsmas3nRnM8lPtub1UyZoSfzOszeWh2HHQo
         De1OTJlAFINnTTde2PkNTZH8eO2u+8N1moI8ts8UC6TsixUgTtgsBVFtKD0vEpfCu+xZ
         lnrHbJSt5rzTeY0DkzItvgbKv0i+Y8D5TB+OeNlfdnsgtPX1jjOKzUwGlHbS76ty+PJ7
         TiAQ==
X-Gm-Message-State: AOJu0Yz227MhhV88ie5x4+W8Nm+rXlUpQuGdhaNyVvlaUdfD0Vnaprg3
	TvDlz4pdbnWqnLpMSd9uwTq/0pa0rE3VRFmG/Eh1U5eOsiek2UwpJyOD1vMWm7F11BwKT5IfQJk
	H8bi4vH8cdg==
X-Google-Smtp-Source: AGHT+IHKlZggH1ldo98B07q9lhJIrlWbASoyi2NyPzL+QWgzImBY5N4YiIOBWV2HZ4XE/CqtOqxYE81BGlB6pQ==
X-Received: from qvbor23.prod.google.com ([2002:a05:6214:4697:b0:6d4:36ff:4351])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d09:b0:6d3:7a47:2034 with SMTP id 6a1803df08f44-6e243befcc9mr255287676d6.3.1738593047813;
 Mon, 03 Feb 2025 06:30:47 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-1-edumazet@google.com>
Subject: [PATCH v2 net 00/16] net: first round to use dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net(dev) should either be protected by RTNL or RCU.

There is no LOCKDEP support yet for this helper.

Adding it would trigger too many splats.

Instead, add dev_net_rcu() and start to use it
to either fix bugs or document points that were safely
using dev_net().

v2: Resend (one patch missed v1 train), plus minor fixes.

Eric Dumazet (16):
  net: add dev_net_rcu() helper
  ipv4: add RCU protection to ip4_dst_hoplimit()
  ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
  ipv4: use RCU protection in ipv4_default_advmss()
  ipv4: use RCU protection in rt_is_expired()
  tcp: convert to dev_net_rcu()
  net: gro: convert four dev_net() calls
  udp: convert to dev_net_rcu()
  ipv4: icmp: convert to dev_net_rcu()
  ipv6: icmp: convert to dev_net_rcu()
  ipv6: input: convert to dev_net_rcu()
  ipv6: output: convert to dev_net_rcu()
  ipv6: use RCU protection in ip6_default_advmss()
  net: filter: convert to dev_net_rcu()
  flow_dissector: use rcu protection to fetch dev_net()
  ipv4: use RCU protection in inet_select_addr()

 include/linux/netdevice.h      |  6 +++++
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 include/net/ip.h               | 13 ++++++++---
 include/net/net_namespace.h    |  2 +-
 include/net/route.h            |  9 ++++++--
 net/core/filter.c              | 40 +++++++++++++++++-----------------
 net/core/flow_dissector.c      | 21 +++++++++---------
 net/ipv4/devinet.c             |  3 ++-
 net/ipv4/icmp.c                | 22 +++++++++----------
 net/ipv4/route.c               | 19 ++++++++++++----
 net/ipv4/tcp_ipv4.c            |  8 +++----
 net/ipv4/tcp_metrics.c         |  6 ++---
 net/ipv4/tcp_offload.c         |  2 +-
 net/ipv4/udp.c                 | 19 ++++++++--------
 net/ipv4/udp_offload.c         |  2 +-
 net/ipv6/icmp.c                | 22 +++++++++----------
 net/ipv6/ip6_input.c           | 12 +++++-----
 net/ipv6/ip6_output.c          |  4 ++--
 net/ipv6/output_core.c         |  2 +-
 net/ipv6/route.c               |  7 +++++-
 net/ipv6/tcp_ipv6.c            | 10 ++++-----
 net/ipv6/tcpv6_offload.c       |  2 +-
 net/ipv6/udp.c                 | 18 +++++++--------
 net/ipv6/udp_offload.c         |  2 +-
 25 files changed, 146 insertions(+), 109 deletions(-)

-- 
2.48.1.362.g079036d154-goog


