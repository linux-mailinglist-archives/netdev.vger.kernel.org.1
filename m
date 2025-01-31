Return-Path: <netdev+bounces-161791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B105A241A2
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CFF188A849
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72B1EC00C;
	Fri, 31 Jan 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA+1emBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4F38DF9
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343619; cv=none; b=gLo8SZaWtdVXbwwvPgVmleAAh4Vh4e5aUmQ0OR/uWIj5pldNc2fsBuTcBACFkxLwLEucRGV4ByftERveWDxxKc6A99WKsi/QF2XvjQzhiZM40gd4DHMMhCmvPyRAAoJZr4e5bSf2KV6zBoNEmyegQSJkNwVQa0f2Pzxydi5iQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343619; c=relaxed/simple;
	bh=X0dGUNwoYEJvq97Uq0IH+DgBY3Zx/xbPMSCOT0TYIlI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I3aD7j49fnZkyXYlr6oMrCiB/FZKsz56uFiRgXE718ChCUojPbYejGUH4TksPBZAF9w252dXs53OAIKIaK4xd+Gryf8NtO/OGzJn3zMj98SX4CxJOax36LzoSF4yz5M6Mea9EvaV/xEKBhOb3Nr9/cgt8lZZ36gxApga12H1XF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA+1emBX; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e7f07332so383646385a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343616; x=1738948416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJrcjbGyIXZvSKLdt1hOUGQq59vSaOv0HDNOZZSylyA=;
        b=XA+1emBX0oSnBfc2SawuhdTlGiRMWy4NNYRZkuS8IeMeuz5mZ84l5k5id6hcGhYsSk
         it7GHDHSwdhuImB+b5ErntXB85anzvjpN1jPNUi8nIq5yvVhLX15YN+UowFq1EzdiDGT
         7m/6FVn3lk9zBoNStFKwHOvvN/6aeROuhcuWS5La67Rfb/3m0RcpUXBWc8K8etpvAy71
         BgVRXIvZAoceglOvOkpnSAl9WFShd7bPLiDcRARqWYbD+ec4MSd3FBWCqXaVEOiagFEV
         woiCpzRQfffoxHrJcMKOa4wCnjuL52U/wjf476Acpc/RT4nOIFQ6+qOUhgFGIYW0feop
         Il2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343616; x=1738948416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJrcjbGyIXZvSKLdt1hOUGQq59vSaOv0HDNOZZSylyA=;
        b=vvolk5R+3FeffaIBWZrrS6GsDlwD8q1IX1N/H18zWoDB0VzEVjfoQG9q5rLf9ZOjrt
         7ugaVlJ2X2XEr4od8pH4WWK5AOJ5p/0hIrAnv+lUum0O4tmPhubAKaS4h/X7JCHQyQ9g
         a9LdoTICs6Kr39Zf5ugLVMYUMjJeyP5lJcSGi+AKJp6/qK0+Btire2hgKOoodi551Snz
         cmM3MJDSe7tExuJtYi8uV3kNW24mGAoPIGX67w7qXH+1cm6X24LiYv3OvI6qI/LRY1RZ
         YcOjq69aObSFJ9oR5OdrklxEaTCMpRlwWeqg7lkRMeWwqOC2xSjFbN2jFhPGPDzaIGiO
         SaJA==
X-Gm-Message-State: AOJu0YxXwqEtXdQ+d7joK4p+pIk56KTo5r/8fp4MJbqOM7hhWl0fggCo
	3DmXrgNK5Oiemsi7F6ltvhYtvO1j03t59OrN4LUHS2qdZP8WZcOUAxVb0gAJJ97lRfW6FiTkWCS
	dAQASKulcTw==
X-Google-Smtp-Source: AGHT+IFvVcKzfn8QAr49BRV+muvFBrht6ttTLymbH2tWtIhdeNjDpn8Oeqr38h4BmBcgbJyn4FcRMCZf2gU62Q==
X-Received: from qkbdz28.prod.google.com ([2002:a05:620a:2b9c:b0:7b6:f191:b68b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4101:b0:7b6:eed4:695c with SMTP id af79cd13be357-7bffcd43d99mr1943443885a.32.1738343616281;
 Fri, 31 Jan 2025 09:13:36 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-1-edumazet@google.com>
Subject: [PATCH net 00/16] net: first round to use dev_net_rcu()
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


