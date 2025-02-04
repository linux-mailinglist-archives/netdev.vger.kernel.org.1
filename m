Return-Path: <netdev+bounces-162528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7DA27328
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC481689B2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101262135CA;
	Tue,  4 Feb 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4U6rZSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F0211A22
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675442; cv=none; b=A3gS6JgeFbBku3xdTqtP2NfD+6qj2Kgm/+oZnER7OzdWiaOWQ65ppeXe9GvwaiJxGtphRkguAEUOmQA1CjjbyNvv508j0Xcwc4C5ngAeKl/Lsde4zPOBzBZOG3bFZk8xnUSCSmJS/XQ5L2FWkHe+KjZugDugSa3kKJTWwnzUNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675442; c=relaxed/simple;
	bh=1DtIgp835/d/x79tw1DV9ffz3qwATek/asdyY79KFXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AReOItA6MYmOKXhyEClF01K3cFa77tWAkzinjqAg/h467gMA9d8ng6Y6bP9BgDX0/xJTnzQopR37RpUeoCWb3KjOmg0QfAW9MM0l2p6UWs4FgnNTyZUXeXrnqEq2uxC0ajirNJwGY54kJn0ukXbM/uXNtgjApQyPm99ZJEpjknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4U6rZSU; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e7f0735aso919229485a.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675439; x=1739280239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZTM4dpwN+Z+HZicxHhG3KojtEBxAl3dJmecksrObLM=;
        b=H4U6rZSURj4mGjLjX+yjHLp2PsQfh8VJDq83GBkYBlL9TnwmG1wMksARnCvTWY6wmS
         7a7pF7C6ur3aiEHNahapOsCvKth9dvg0RTNpY2hqMq65PKDVLoSrDXpib6aS+SFkc7Ep
         QuUbtqKI9XSvM9wf/tPxnqld6OMCxq5vfryR5iWHV/63UDZh95GKt1dr22Faw6qDwLvZ
         t/BvrOpyqyZCmbZvXfuWfjhaPd3rG2VO8iFQfHemNWVPLPCdc32vQ3Y/tY+O713Oh5Uz
         DSyn6tZhguPtYBykvdf7c0R2QkZOKwOxIIiNQCwdU1oB0uV1M0dj63oNt4qAKiSPhFF8
         1Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675439; x=1739280239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZTM4dpwN+Z+HZicxHhG3KojtEBxAl3dJmecksrObLM=;
        b=K3H89biJG+3ktDX44UuwdxedhFdV5imPn50151IGUtzHUdIi+tw3r55Wp3gdhz8494
         1kWK7C3EGaTDFerLaX26uggPu9/b0nw7DxauOJipyPdTUFzELBvtcqC2gGH+hbj7Locl
         LchMrdheHl6EBM8nD/8uXYYfYJI0sRmVSN7SyMULBSvHahiAegrL6GpsSHL0CStXOjIU
         bki8gGSZUF3944Z13Y0nAu9DeqOhkx3HP4iCP/0jqYWhqE4ihal/YlpR6Q6M/NZEWOct
         0yMT1Vo2I5HQm4IS6JYEFNnDe5274WqFQiM83ZXCgGy/+EjoZHNHcOnrpGL4vuu4WYnL
         TsOw==
X-Gm-Message-State: AOJu0Yzn53jCLHyqPmq4gl4hyKK7FOmYYo78Q5g4VHuvT2NsHU1rRM35
	8hOVMEuGHhh6G50IxWzHGTn1kt6EHLti+moJPtefYiBqQbn8Rxr5ADUn2Yp3jYApaSK/V2Q58YQ
	JllaWb40lyw==
X-Google-Smtp-Source: AGHT+IEGt1mJC5PMRZGEfeC+8SmDWaaYW8EsN8qAXNCZT7nDeyX4BbINIkCkrBCZpnJgCVyMoQcV/fOcQ+n86Q==
X-Received: from qknqf10.prod.google.com ([2002:a05:620a:660a:b0:7bf:ff6a:3fbd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:284c:b0:7b6:d28b:42b4 with SMTP id af79cd13be357-7bffcce1d50mr3685477085a.19.1738675439260;
 Tue, 04 Feb 2025 05:23:59 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-1-edumazet@google.com>
Subject: [PATCH v3 net 00/16] net: first round to use dev_net_rcu()
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
using dev_net() in rcu_read_lock() sections.

v3: Rework patches 9 and 10 after Jakub feedback.
    Link: https://lore.kernel.org/netdev/20250203153633.46ce0337@kernel.org/
    Added some missing Fixes tags.

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
 net/core/filter.c              | 40 ++++++++++++++++----------------
 net/core/flow_dissector.c      | 21 +++++++++--------
 net/ipv4/devinet.c             |  3 ++-
 net/ipv4/icmp.c                | 31 +++++++++++++------------
 net/ipv4/route.c               | 19 +++++++++++----
 net/ipv4/tcp_ipv4.c            |  8 +++----
 net/ipv4/tcp_metrics.c         |  6 ++---
 net/ipv4/tcp_offload.c         |  2 +-
 net/ipv4/udp.c                 | 19 +++++++--------
 net/ipv4/udp_offload.c         |  2 +-
 net/ipv6/icmp.c                | 42 +++++++++++++++++++---------------
 net/ipv6/ip6_input.c           | 12 +++++-----
 net/ipv6/ip6_output.c          |  4 ++--
 net/ipv6/output_core.c         |  2 +-
 net/ipv6/route.c               |  7 +++++-
 net/ipv6/tcp_ipv6.c            | 10 ++++----
 net/ipv6/tcpv6_offload.c       |  2 +-
 net/ipv6/udp.c                 | 18 +++++++--------
 net/ipv6/udp_offload.c         |  2 +-
 25 files changed, 164 insertions(+), 120 deletions(-)

-- 
2.48.1.362.g079036d154-goog


