Return-Path: <netdev+bounces-108510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67AF9240AB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263B71F24C91
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4561BA891;
	Tue,  2 Jul 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0lJZk7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64781BA874;
	Tue,  2 Jul 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930291; cv=none; b=XYvL//LMPPkvG7hKWSKy7/SwnAcFjlxWUYSdPLuaL/U5GZn4SbAxSn7pCWyxM6VKunL3tq7qAIPbEZiJwJsjC79OsRUWed3AL6aiQ0OmDPIdMV3Xx93p/rkaRYV4Tq9ix8j5h99IXjYQvh8QqzPzCdYRyHu/rB2fsQuSlXeclZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930291; c=relaxed/simple;
	bh=pQ0VyLEWPbTzv8ueT/SYA25grM78ReWuMdOeMbNrUDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkVD1i9mKxP6NVfkL4qYfNThTOWihj1qNyHc/Kgli7RZMErXJEfuMqmW+lWWcRFy6f7Bcqa4EIMsfEPasvSXkNTPJRKNk+KYIsDLmQhKpbY2sEMgEZPa3JycJWmzAjkWpHV9rYpK35EWutyThp95ORM0Qyc4EYW2Uqqb4YydeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0lJZk7j; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-42574064b16so26759465e9.2;
        Tue, 02 Jul 2024 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930288; x=1720535088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeeAUA+M1CrSeGLqCio6FXkyYBfV90EEN3G250oeFOA=;
        b=U0lJZk7j838j0RN9wVhvEkgwxIIisef+6GnZvYMxQad3c4rA3CGBavY4V78+SFc8wc
         mXayx2ZTLN+O4Ji2kLGr6tTsDsLM52998xf+1c/xY3mnkji5Wo8EbH38D/jZUjJKstRj
         uK6UeULrboMTahGdVzPxnrEKW9qjEv6d7hEQvS/pjQQnhZfvY9OxfZTcyGR/frwL43DE
         ue44YEJ7/B68cktWkenGK7bcFvFGiVHZzFR8yR7AoxgPbbkUcfHHH8bHTIaqAnoyQ+az
         cziLmLlB73gk1ilOW4qUwNLm/vtug8QD6hvJ9Em0dcEonTfG/1qHwTNEmsu1uEAftP/r
         cqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930288; x=1720535088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeeAUA+M1CrSeGLqCio6FXkyYBfV90EEN3G250oeFOA=;
        b=NITcHt3HIH54ETvg2uEBZTRRr3pwuWEYs1pYUhNbL/wCPZhmzhxsTV4j17NOrcTYH/
         gOeBHJz14+prYIFkNvQhmhnZCxPMhfXDvB3B3zRaNsbrANe2kBEaiDGYvNptPO/+vkeE
         BQ4Kv/i7hcTi8+cGdRYKjDiWvMo29JkRfT7cXbXdszSdScphZroVdWuVlU9GMmEnwqo2
         75L7+QuZ35BIb4KWLH9wsUv/SxEKSvKzOxdhIDzO7Ruu5jdqY3g80H3p9dmwa01GBhT8
         +/cvhMHAKtHeidTHUb+a9RdG5NIp+88rkkNJjz2wNAloPyIvAqU0fp78OIZHErYIXAoe
         +RnA==
X-Forwarded-Encrypted: i=1; AJvYcCVq2E9+3D1cGYuH5VxsnTdInI/YpgiBkUKR0KP91ZaL3TNzl1QH7jCS9Lj0aJgIi8XocUK6i1AdBDHpxuVgxRGOOCuzXBGgzXUIm6KAdJ6yro8pLl0U8YQU9kW0iv2xdZx6gsLu
X-Gm-Message-State: AOJu0YwzekyNjDvdgERkI2lefDR62QUidG5EHNaHe2vGUbU9V1P/Nk7J
	eZeUbZiOv0A1Ovr95bqa0QgY4NiVQH9r/MIP8A+7FnneFN7d8ln4
X-Google-Smtp-Source: AGHT+IFVs8QCxMuEfkGcfHEIMry2KNCFjt+wxd4AxRq+lltb3dEuh8t1F/BUWxxFZ5jbRr9E3aHOiw==
X-Received: by 2002:a05:600c:705:b0:424:a4f1:8c3e with SMTP id 5b1f17b1804b1-4257a074b50mr68377395e9.34.1719930287765;
        Tue, 02 Jul 2024 07:24:47 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256f55c4b5sm186586065e9.43.2024.07.02.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:24:47 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [RESEND PATCH net-next v2 0/4] net: route: improve route hinting
Date: Tue,  2 Jul 2024 16:24:02 +0200
Message-Id: <20240702142406.465415-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
sub-system. The hinting optimization improves performance by reusing
previously found dsts instead of looking them up for each skb.

This patch series introduces a generalized version of the hinting mechanism that
can "remember" a larger number of dsts. This reduces the number of dst
lookups for frequently encountered daddrs.

Before diving into the code and the benchmarking results, it's important
to address the deletion of the old route cache [2] and why
this solution is different. The original cache was complicated,
vulnerable to DOS attacks and had unstable performance.

The new input dst_cache is much simpler thanks to its lazy approach,
improving performance without the overhead of the removed cache
implementation. Instead of using timers and GC, the deletion of invalid
entries is performed lazily during their lookups.
The dsts are stored in a simple, lightweight, static hash table. This
keeps the lookup times fast yet stable, preventing DOS upon cache misses.
The new input dst_cache implementation is built over the existing
dst_cache code which supplies a fast lockless percpu behavior.

The measurement setup is comprised of 2 machines with mlx5 100Gbit NIC.
I sent small UDP packets with 5000 daddrs (10x of cache size) from one
machine to the other while also varying the saddr and the tos. I set
an iptables rule to drop the packets after routing. the receiving
machine's CPU (i9) was saturated. 

Thanks a lot to David Ahern for all the help and guidance!

I measured the rx PPS using ifpps and the per-queue PPS using ethtool -S.
These are the results:

Total PPS:
mainline              patched                   delta
  Kpps                  Kpps                      %
  6903                  8105                    17.41

Per-Queue PPS:
Queue          mainline         patched
  0             345775          411780
  1             345252          414387
  2             347724          407501
  3             346232          413456
  4             347271          412088
  5             346808          400910
  6             346243          406699
  7             346484          409104
  8             342731          404612
  9             344068          407558
  10            345832          409558
  11            346296          409935
  12            346900          399084
  13            345980          404513
  14            347244          405136
  15            346801          408752
  16            345984          410865
  17            346632          405752
  18            346064          407539
  19            344861          408364
 total          6921182         8157593

I also verified that the number of packets caught by the iptables rule
matches the measured PPS.

TCP throughput was not affected by the patch, below is iperf3 output:
       mainline                                     patched 
15.4 GBytes 13.2 Gbits/sec                  15.5 GBytes 13.2 Gbits/sec

[1] https://lore.kernel.org/netdev/cover.1574252982.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/20120720.142502.1144557295933737451.davem@davemloft.net/

v1->v2:
- fix bitwise cast warning
- improved measurements setup

v1:
- fix typo while allocating per-cpu cache
- while using dst from the dst_cache set IPSKB_DOREDIRECT correctly
- always compile dst_cache

RFC-v2:
- remove unnecessary macro
- move inline to .h file

RFC-v1: https://lore.kernel.org/netdev/d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com/
RFC-v2: https://lore.kernel.org/netdev/3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com/

Leone Fernando (4):
  net: route: expire rt if the dst it holds is expired
  net: dst_cache: add input_dst_cache API
  net: route: always compile dst_cache
  net: route: replace route hints with input_dst_cache

 drivers/net/Kconfig        |   1 -
 include/net/dst_cache.h    |  68 +++++++++++++++++++
 include/net/dst_metadata.h |   2 -
 include/net/ip_tunnels.h   |   2 -
 include/net/route.h        |   6 +-
 net/Kconfig                |   4 --
 net/core/Makefile          |   3 +-
 net/core/dst.c             |   4 --
 net/core/dst_cache.c       | 132 +++++++++++++++++++++++++++++++++++++
 net/ipv4/Kconfig           |   1 -
 net/ipv4/ip_input.c        |  58 ++++++++--------
 net/ipv4/ip_tunnel_core.c  |   4 --
 net/ipv4/route.c           |  75 +++++++++++++++------
 net/ipv4/udp_tunnel_core.c |   4 --
 net/ipv6/Kconfig           |   4 --
 net/ipv6/ip6_udp_tunnel.c  |   4 --
 net/netfilter/nft_tunnel.c |   2 -
 net/openvswitch/Kconfig    |   1 -
 net/sched/act_tunnel_key.c |   2 -
 19 files changed, 291 insertions(+), 86 deletions(-)

-- 
2.34.1


