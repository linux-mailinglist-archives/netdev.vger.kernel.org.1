Return-Path: <netdev+bounces-223646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2AB59D2F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF23C3B7814
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587C279DC8;
	Tue, 16 Sep 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2B93b8LT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B52328586
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038997; cv=none; b=ScoCX+Zi12l6v8AcXKkMb7490BAd3ps9pIWqCAOkHVo+ht0dcED2IARd9qmLjyHx+NJNCXWwF02jrzDTTwwiCUG17YuJ1mGj3XowZqWeNSiD2roVAyrDkQjWm+M4Bn1vAuhtFDvIxJQW36FkhDocgNLy9qQdDa5NLyCZ+hORzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038997; c=relaxed/simple;
	bh=PLTS7YLmNVLAibIPolrVrckW2x/g0La72gXKKChg3ew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oprQ0GDk93r8kJ8JjxGV6wA8zfeAXdoA/TqRGXwDuPs0WQIURY9EgV6TCWYk3S7w4Ftn6+0SkZ5uxYMBje+eeRnSRhEq9DO6DUGUv5BbAzEVNb6z55YyawvHbBf18COH8/azJaTz0KmyeuOjD6VkSHKVgURStW53XkIIiShStiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2B93b8LT; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b5fb1f057fso81761791cf.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758038995; x=1758643795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ev7UlKDng61bYRawaL3+HBlxIteZ27n2CF/AcPtUIOo=;
        b=2B93b8LTKn7nTmq0kv+14Kcbv2rdIR7dmH8eBZyoGrxVT8QIKCJ+dUAqNvWbHL5Vyf
         ybWWYLmiE7JjmREuL64V59Zn4gbnqhMwvbJlsjxAY6JR6WcCV8t5taSpvqwsez/Dj9Yd
         ZhI5c7vFcDKV0l/ZXkehRELFgrtrMDor4G5DHxCycJMPgTgdn+Qy55NS77nuSKHBQxe5
         JcQv6BamjFFIhz+fejZOdElIQ91qZCPVuoJt8Nt3kEM6UGvqzjwIksucGcBjwyXOazLP
         /6kJLIMH4B122K02iIuAuZCPNMhNc+gruiHryFaT0du0o+v8LnGJNHUDEPB73AEEckNs
         Zm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038995; x=1758643795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ev7UlKDng61bYRawaL3+HBlxIteZ27n2CF/AcPtUIOo=;
        b=Yldm2YUN9RTkblyRwcsqFp3oV4230nctBGlL/QLmyyz6KVrY2UNAFHtetaPIahKJCi
         0drAKYgNFO3Pf+YhNcCI7NekSGhRdmApWLMRJPsIZurSEcXfva0jYMhaQ0rGS3BLDrQG
         YSWTahpjbw06cy3PbEl84OC7o30LXRNiKt844ZZX+1kfV0iIM55ya2ozbK6tFFXuHVhf
         LJ+D8k+vumQO4eRYjSUo8MC3VvkfjmFdjJzWbNY0XF0wMTCdPHsB1771apRd2RthMZvW
         ahFA8lh9VPngSc+Bhxus5gdDTToAgaBmqaVL8h9i0OuAwNm93cFqx3WOLrBrTuNE4G/V
         2dUg==
X-Forwarded-Encrypted: i=1; AJvYcCWjbQSBjAA5QBtaAY7cUducOWwqqvwijROhW21CxVWkHqi3zy5QAMmFTfaNRfdK0U7oMsW3Wpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/KsVKlHCkCd/KXh8PkksKY+smEHOOxv9wDGbKQT69wyRVjAp
	Low6rnkUb/2InxNu2kEbBT4ttfFkCiAF/ffaGUXbBmP/4QzNdCotnZenVxRsSyPre6SshAlPSSb
	+pi03ozfRLds5hw==
X-Google-Smtp-Source: AGHT+IFj801zrpGw/QyE9jiL89sU6sBG5G9jud7ln6WDbRXQdRaY2Bc8aownywDMV71WXJhkuvCu6rLo5wDgYQ==
X-Received: from qtbne22.prod.google.com ([2002:a05:622a:8316:b0:4b5:e0ab:fe1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:40cd:b0:4b2:ed82:29d5 with SMTP id d75a77b69052e-4b77d00fd60mr243971601cf.33.1758038995285;
 Tue, 16 Sep 2025 09:09:55 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-1-edumazet@google.com>
Subject: [PATCH net-next 00/10] udp: increase RX performance under stress
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is the result of careful analysis of UDP stack,
to optimize the receive side, especially when under one or several
UDP sockets are receiving a DDOS attack.

I have measured a 47 % increase of throughput when using
IPv6 UDP packets with 120 bytes of payload, under DDOS.

16 cpus are receiving traffic targeting a single socket.

Even after adding NUMA aware drop counters, we were suffering
from false sharing between packet producers and the consumer.

1) First four patches are shrinking struct ipv6_pinfo size
   and reorganize fields to get more efficient TX path.
   They should also benefit TCP, by removing one cache line miss.

2) patches 5 & 6 changes how sk->sk_rmem_alloc is read and updated.
   They reduce reduce spinlock contention on the busylock.

3) Patches 7 & 8 change the ordering of sk_backlog (including
   sk_rmem_alloc) sk_receive_queue and sk_drop_counters for
   better data locality.

4) Patch 9 removes the hashed array of spinlocks in favor of
   a per-udp-socket one.

5) Final patch adopts skb_attempt_defer_free(), after TCP got
   good results with it.


Eric Dumazet (10):
  ipv6: make ipv6_pinfo.saddr_cache a boolean
  ipv6: make ipv6_pinfo.daddr_cache a boolean
  ipv6: np->rxpmtu race annotation
  ipv6: reorganise struct ipv6_pinfo
  udp: refine __udp_enqueue_schedule_skb() test
  udp: update sk_rmem_alloc before busylock acquisition
  net: group sk_backlog and sk_receive_queue
  udp: add udp_drops_inc() helper
  udp: make busylock per socket
  udp: use skb_attempt_defer_free()

 include/linux/ipv6.h             | 37 ++++++++++++-----------
 include/linux/udp.h              |  1 +
 include/net/ip6_route.h          |  8 ++---
 include/net/sock.h               |  4 +--
 include/net/udp.h                |  6 ++++
 net/core/sock.c                  |  1 -
 net/ipv4/udp.c                   | 50 ++++++++++++++------------------
 net/ipv6/af_inet6.c              |  2 +-
 net/ipv6/inet6_connection_sock.c |  2 +-
 net/ipv6/ip6_output.c            |  6 ++--
 net/ipv6/raw.c                   |  2 +-
 net/ipv6/route.c                 |  7 ++---
 net/ipv6/tcp_ipv6.c              |  4 +--
 net/ipv6/udp.c                   |  8 ++---
 14 files changed, 69 insertions(+), 69 deletions(-)

-- 
2.51.0.384.g4c02a37b29-goog


