Return-Path: <netdev+bounces-163086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01BA29540
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE2167B9D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13218FDDA;
	Wed,  5 Feb 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSIng8z3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DC186E26
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770684; cv=none; b=ub5MTq5eGTOu5hXO4wR1JsC7C2fePhPFj66Yw4Efl1vNgHBVufwoNAUeHmol0Wqweg+3UyRAu3zdSJaerDNyN2+WIlcdmXHBksKe8WahoNdpuOyCDEQgqfqLykf+jt3QRfkvYsClVr5q5b1N9cSr327ySqCrYz4lqPdhFjNRpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770684; c=relaxed/simple;
	bh=ncQa1vpjOCYb2+gQ2Myk5x3QBjx+OrwxwQx1bcoH0g4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R4jn0fP3Dwq7Tj2VVXP52alcyrvFCEP/5/qwu3fvNZOgLYuFuonlA/Ri64y7Sfpm0UULCJ/3gmCB10ZAqmG6KoygWdjk7oP7mvqkOchIKNpm3o1s2hkZD3k2L/x0gilY5I5WwNou54Y0BxvWd+LEhSkqT5utMc+oUgUbk4ILQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSIng8z3; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e42d5ff298so16763396d6.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770681; x=1739375481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xR2ZV193StI40Y2pzGK5rMpwmNqvpyqRerG0vIYFos=;
        b=bSIng8z3etX/0bpfUfDkM273OI4L9EaswbE0o8RL3KtUyL7DTPRyss+5LC0s7WVrnP
         rdYlHMg+2iWIqBV4gZ6XjEW4sKPRMbuG1GG/NM7p/pt4ieUf4whfR6WfHrmSZ1p6djq2
         jhGv/HsEf5HTTBG6+WnF8+i2bHPunUrovFmy7Wc4Ybhie80c7Rcl3qsdoTntLjE4QyGS
         mtwnB45ocLv8+mggZzOwhRCKQ6iQH6s5JKjh2AQMbhVwTsiy8/YTphzLf5kNFF5Ldymq
         U7fyXPBEQGEnvZiaR3oJIzWCqOBdlGy19d7sq81Gl/kXTdOmCpT/M4x81n3plezeGo6M
         nH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770681; x=1739375481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xR2ZV193StI40Y2pzGK5rMpwmNqvpyqRerG0vIYFos=;
        b=obpFbew2wX6rcrNt7dMJ5OWNLVKE2+7uZ2YgLgWlTi1DivMeNNXbXEoiEa/QXzXRsJ
         SHfKg4pEXERXCrrSONk1fggSG9st1U61l147yjosWpeJmdFEb9bCp63i56X/VRR7o5Jz
         VjTQW6C0aPyxhz6vBSnPUnaWMpfC9YuNlTIrMKcMc867k8XOggx5VZlU3iI1af0lvK0f
         BjVzCPw3orBAKYtXazD/7uXZRRXo2Q/VV3F1Ph5Dpl6BdcIGGxNjiIpNjitwZDidclcP
         2mYTPe2UNKkCYCbw57TLYhyGPo3Np3dBSVx3QfMRZDQvTFK9MioXbXKpdYMhvfsOFbhr
         GNcg==
X-Gm-Message-State: AOJu0YzYmSTwC65dMCc5P01a3Q76KIgVhXTuu/+4Lv743m9bh6BOFng8
	fhceuRDapPCsV7ByPpmLwRCdrHRtUkdIL5wQ2BCJkNk8SmUi7C9xYDi3cF9iHPl9FdxYF371yW/
	WAr7GBnHhXQ==
X-Google-Smtp-Source: AGHT+IHwOvbMwUsRRmt6x56NyP7qXv9pqWOMXzFm1VHd+/T/spqd1K+g7tPC4lbj7i5ryIALhzFQ5MkFFNRV0w==
X-Received: from qvblv5.prod.google.com ([2002:a05:6214:5785:b0:6e2:58ca:a8a5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:53c8:b0:6d8:8f14:2f5f with SMTP id 6a1803df08f44-6e42fc0229cmr53853566d6.23.1738770681498;
 Wed, 05 Feb 2025 07:51:21 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-1-edumazet@google.com>
Subject: [PATCH v4 net 00/12] net: first round to use dev_net_rcu()
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

Instead, add dev_net_rcu() for rcu_read_lock() contexts
and start to use it to fix bugs and clearly document the
safety requirements.

v4: Shrink the series to limit number of potential iterations.
    Fix ip6_input() in a separate patch.
    Link: https://lore.kernel.org/netdev/CANn89i+AozhFhZNK0Y4e_EqXV1=yKjGuvf43Wa6JJKWMOixWQQ@mail.gmail.com/

v3: Rework patches 9 and 10 after Jakub feedback.
    Link: https://lore.kernel.org/netdev/20250203153633.46ce0337@kernel.org/
    Added some missing Fixes tags.

v2: Resend (one patch missed v1 train), plus minor fixes.

Eric Dumazet (12):
  net: add dev_net_rcu() helper
  ipv4: add RCU protection to ip4_dst_hoplimit()
  ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
  ipv4: use RCU protection in ipv4_default_advmss()
  ipv4: use RCU protection in rt_is_expired()
  ipv4: use RCU protection in inet_select_addr()
  ipv4: use RCU protection in __ip_rt_update_pmtu()
  ipv4: icmp: convert to dev_net_rcu()
  flow_dissector: use RCU protection to fetch dev_net()
  ipv6: use RCU protection in ip6_default_advmss()
  ipv6: icmp: convert to dev_net_rcu()
  ipv6: Use RCU in ip6_input()

 include/linux/netdevice.h   |  6 ++++++
 include/net/ip.h            | 13 +++++++++---
 include/net/net_namespace.h |  2 +-
 include/net/route.h         |  9 ++++++--
 net/core/flow_dissector.c   | 21 ++++++++++---------
 net/ipv4/devinet.c          |  3 ++-
 net/ipv4/icmp.c             | 31 ++++++++++++++-------------
 net/ipv4/route.c            | 30 ++++++++++++++++++--------
 net/ipv6/icmp.c             | 42 ++++++++++++++++++++-----------------
 net/ipv6/ip6_input.c        | 14 ++++++++-----
 net/ipv6/route.c            |  7 ++++++-
 11 files changed, 113 insertions(+), 65 deletions(-)

-- 
2.48.1.362.g079036d154-goog


