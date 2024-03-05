Return-Path: <netdev+bounces-77577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9D87238E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21471F25206
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1AB127B7B;
	Tue,  5 Mar 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQeQmH0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D488613F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654658; cv=none; b=N0nSw86+DMNkRuNQpdI4z4uUBAbYm5NLSIYn9T6+iP9VKfVSlpnJkXPYaE0W8ixcQK7sUn9gIZROSxP1ZrBVj/aA89D35htYBZ8WBfkV3ejEj4utQ4ylQjhCsJiR5Sbs5x7YKv2fTVcbFRS6ZfmiuOJBaApf3juEfLd+7GnOhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654658; c=relaxed/simple;
	bh=7s3F8dgniscF9dGQbIa8xS+onV+iLrXjdsNeNHerXec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dgEkYN5nr7By4IcB+b4tXEzXwilVh3Z+S9FeHrwVHqC3Sjc2Sldq78M5UnwSR6Garsv9kickr6nrJ5ZchFdwnjk6aW+bv3Xgw3QZvmMv4zr876zOzxyChrjs8xFgyTIPGmi8fM87dkKBd8cV6WiKSfG3JDHvqA5V/WFvab8N4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQeQmH0i; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so8506033276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654656; x=1710259456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4z2pqoGTXYdssuPQUw6GdQ/fuSeTjlkMKbb/XvUuqA=;
        b=XQeQmH0i9+/aTTNpyC3ZdUg884jRyI970im9ExVnumDgClPSfGaBIxzFNYOlS/aM1M
         WISehXvZ404xoj9ptuVhyBEawVC00GpToirfNc+t9civb5a5q/K6ndgqCYdTp4GxxejY
         g4nbVsvHGqqMdsAyYYkLO6UpaNpD/Z/0QiqjM19FDzPm8aYkGI5LHNEeNslpelMR/u/h
         hSQ0TmEhN5puJUvhnifR/N0wSvsz1eHx98Ew33NirtPoyW3y2A4Km9cqeYZx0Cbx30Ne
         7p+7VjBOgJehyC8jhaQEC/2rTX7dkqC/d6Qshtei0Gc/hsuiTWMmVnz/XCNuZgaCoj0t
         jMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654656; x=1710259456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4z2pqoGTXYdssuPQUw6GdQ/fuSeTjlkMKbb/XvUuqA=;
        b=DcfnstHxNtMiw50eVQjakY7ddacc2cV5r7HxegLDHytLhI7yll2R61N3z5dUJoytIo
         +XcYwxiOKUTmI1lfH5HCxAHH+xvW6Q/WxSj2vIOzrJwvPOO/voge8dlOPBrxGtG1i3zx
         3KnfkEwjZsAw2TXM+22VzdzUjvy9NWTFTM6QHqPiYX8ndkPCKT7f/FOf+KrP1emCJQvS
         RxMwxOXZMOYvPTqu6WpnDZMNI0mjpf4aIEB/84MyXs7+aCIXudJoKYDX+YKl9sFRD+2+
         wLLEn/864j5nX0o3gbE3DEktSqc/irz8Y/3hb36PwwgRJX1alGXALmMuXGvsXfYSSTmU
         TRfA==
X-Gm-Message-State: AOJu0YzpiNfIoCIRobL3y03P3Mn6qoXUxrCzHzd9EB+gNnrhcjiyaQKG
	iVZzggnggUgPKBiUSS7uG4foFeoTIsjFxsEYnXCFWTZHIpd3CPZIeoYm4h5vYvAB3B5iJeT1cE5
	NPiZbyzv6sg==
X-Google-Smtp-Source: AGHT+IHE93SjcrMm/rJwPYCbHgYJj7K39a4mfXgHT9k/zGqmhBOQDgjc5GHtlJJoih/gSNY1R0eeJ5B/9OHSuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr3125308ybt.6.1709654655846; Tue, 05 Mar
 2024 08:04:15 -0800 (PST)
Date: Tue,  5 Mar 2024 16:03:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-1-edumazet@google.com>
Subject: [PATCH net-next 00/18] net: group together hot data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While our recent structure reorganizations were focused
on increasing max throughput, there is still an
area where improvements are much needed.

In many cases, a cpu handles one packet at a time,
instead of a nice batch.

Hardware interrupt.
 -> Software interrupt.
   -> Network/Protocol stacks.

If the cpu was idle or busy in other layers,
it has to pull many cache lines.

This series adds a new net_hotdata structure, where
some critical (and read-mostly) data used in
rx and tx path is packed in a small number of cache lines.

Synthetic benchmarks will not see much difference,
but latency of single packet should improve.

net_hodata current size on 64bit is 416 bytes,
but might grow in the future.

Also move RPS definitions to a new include file.

Eric Dumazet (18):
  net: introduce struct net_hotdata
  net: move netdev_budget and netdev_budget to net_hotdata
  net: move netdev_tstamp_prequeue into net_hotdata
  net: move ptype_all into net_hotdata
  net: move netdev_max_backlog to net_hotdata
  net: move ip_packet_offload and ipv6_packet_offload to net_hotdata
  net: move tcpv4_offload and tcpv6_offload to net_hotdata
  net: move dev_tx_weight to net_hotdata
  net: move dev_rx_weight to net_hotdata
  net: move skbuff_cache(s) to net_hotdata
  udp: move udpv4_offload and udpv6_offload to net_hotdata
  ipv6: move tcpv6_protocol and udpv6_protocol to net_hotdata
  inet: move tcp_protocol and udp_protocol to net_hotdata
  inet: move inet_ehash_secret and udp_ehash_secret into net_hotdata
  ipv6: move inet6_ehash_secret and udp6_ehash_secret into net_hotdata
  ipv6: move tcp_ipv6_hash_secret and udp_ipv6_hash_secret to
    net_hotdata
  net: introduce include/net/rps.h
  net: move rps_sock_flow_table to net_hotdata

 drivers/net/ethernet/intel/ice/ice_arfs.c     |   1 +
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c |   1 +
 drivers/net/ethernet/sfc/rx_common.c          |   1 +
 drivers/net/ethernet/sfc/siena/rx_common.c    |   1 +
 drivers/net/tun.c                             |   1 +
 include/linux/netdevice.h                     |  88 ------------
 include/linux/skbuff.h                        |   1 -
 include/net/gro.h                             |   5 +-
 include/net/hotdata.h                         |  52 ++++++++
 include/net/protocol.h                        |   3 +
 include/net/rps.h                             | 125 ++++++++++++++++++
 include/net/sock.h                            |  35 -----
 kernel/bpf/cpumap.c                           |   4 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/Makefile                             |   1 +
 net/core/dev.c                                |  58 +++-----
 net/core/dev.h                                |   3 -
 net/core/gro.c                                |  15 +--
 net/core/gro_cells.c                          |   3 +-
 net/core/gso.c                                |   4 +-
 net/core/hotdata.c                            |  22 +++
 net/core/net-procfs.c                         |   7 +-
 net/core/net-sysfs.c                          |   1 +
 net/core/skbuff.c                             |  44 +++---
 net/core/sysctl_net_core.c                    |  25 ++--
 net/core/xdp.c                                |   5 +-
 net/ipv4/af_inet.c                            |  49 +++----
 net/ipv4/inet_hashtables.c                    |   3 +-
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_offload.c                        |  17 ++-
 net/ipv4/udp.c                                |   2 -
 net/ipv4/udp_offload.c                        |  17 ++-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/inet6_hashtables.c                   |   8 +-
 net/ipv6/ip6_offload.c                        |  18 +--
 net/ipv6/tcp_ipv6.c                           |  17 +--
 net/ipv6/tcpv6_offload.c                      |  16 +--
 net/ipv6/udp.c                                |  19 ++-
 net/ipv6/udp_offload.c                        |  21 ++-
 net/sched/sch_generic.c                       |   3 +-
 net/sctp/socket.c                             |   1 +
 net/xfrm/espintcp.c                           |   4 +-
 net/xfrm/xfrm_input.c                         |   3 +-
 44 files changed, 391 insertions(+), 320 deletions(-)
 create mode 100644 include/net/hotdata.h
 create mode 100644 include/net/rps.h
 create mode 100644 net/core/hotdata.c

-- 
2.44.0.278.ge034bb2e1d-goog


