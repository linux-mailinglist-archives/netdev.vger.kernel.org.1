Return-Path: <netdev+bounces-202025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E365AEC09B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BFF3B5293
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6E52EBBBF;
	Fri, 27 Jun 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxWXYafm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08C2EBDC8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054760; cv=none; b=PO81Rn/4ywe4KxvLn8nUnCHJr8FLyJAdof4LVITwNtddhhXA8dRbtsnerix0W/FTACCno6o10xSseJNLcugVHMl7a4vIBJM5UjdMOtRN/Kr+ASG1EfXj2MlWVwv9Rkwjr2gmVQasusCXRw/4BqKD+gSpzFpyL8wr94chmoU8Org=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054760; c=relaxed/simple;
	bh=KbqouvucJpz7EwLEqXuEVG7KnQlNHLb0kRqfYiF76tw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kAOV6vYTdQIVJGe+pUlIgF1PYtcZoDQRG3WnrhJ+xkqRTuixZ1huqmomKaATQwwmDgakepDpFjSijcHdUc/TSQaDb5Uc+UwJC064842ymoe3mIRrYgXB/0nhpsq1w8YIxtnqcvjtB1ZQNmJPH98PvgR3UlIZdUt228LvlvsKciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxWXYafm; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4e75a8ac11eso56368137.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054758; x=1751659558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZuFKooOn4RLxR4Xu12SBH3wXM32FaQhQhAHZBzkRfxY=;
        b=kxWXYafmcHv259kR4ZoWrBYdh6s5ilJT/Y8LFf4GtHChni8Yaw+4isZf8E9ddvDMh6
         hVfX/cE7WZ9a0I42LiWIyJVelXD6pI2cKpxDzTCgNn6wvAaVQbwsjtRWU8FJYBWqMYu0
         2d/EfCY9Dw5HVRBZgBi38zlbHcYt5ECjuMa/rx/yga2UVMF4Cc1hpAhj5gfJeUzUer0P
         00qlE+LnpjgxISbT0bsxgIMZ/XgAHV5WHGowUmbf17t3Y8GU1bNChgqaKbKVFVR1snb1
         AgysNvrRVAi62+BRjc9F8Rm/cye7iGoGR2o7UGisHbZzbymPTDwXYqtDKw2NjK66G4WS
         tWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054758; x=1751659558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuFKooOn4RLxR4Xu12SBH3wXM32FaQhQhAHZBzkRfxY=;
        b=CEUblkZjfH+UKIN845uPX8XwkTEHFvrBZfScrJE8upZhHHgroV6rD8lg0SqBc1VT3H
         kd9Fgur6P1vOQGr373DRwA4Ud+AhYfctZlx1G/Cop6St0kDFijWRWz8R0SmLT3DbpFyR
         z62o2s0giO55NYdctcND0CRuDxraghrW3LAUQY/QXwgwIcM9ExRxQtJg7WIuQcQGHKqA
         2R24z3ZfpWBiT3eO4XxNHfbQCsxzAFJ7Z6rBvbZwb+9fqd36njSXdqIHnOkvpJ+U/VWo
         rnOEjxHwfI3KDZUkkE+dkr03+sLZA9PqDlKhdH8uJf8QledhuNiul610SJWT/fNfYXVi
         Fb/A==
X-Forwarded-Encrypted: i=1; AJvYcCXVElIOzAnJq/vpbQsUYi4jK16hZDCHUz/yaCtIz19+W+pYJSBCB+ea2AFpshZdZnxlZW56bKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m6RoSFRyx0gFKkd/VQZfVjQZjxYVE/zn0CERM4ci3u7R8hqK
	/5Y0Ch/5olySow6XEkhOhIgs1824Y2xG70twh6EUXcBcnf01S/CUIJRZs4tE99BtTcowRV/9zgw
	TsNwLWkU0hAuV2A==
X-Google-Smtp-Source: AGHT+IHBynHra3s5gI1b5133WUMDO6kQ4s3qU+g5xs/PTdV9gNqe7QuaqzXKJFUIN167wjjcYJ4SA+OGIZ+Jqg==
X-Received: from vsbcr11.prod.google.com ([2002:a05:6102:424b:b0:4ec:b143:86d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:511e:b0:4da:fc9d:f0c with SMTP id ada2fe7eead31-4ee4f7ad5cdmr4365721137.12.1751054757918;
 Fri, 27 Jun 2025 13:05:57 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:05:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200551.348096-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: introduce net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

____cacheline_aligned_in_smp on small fields like
tcp_memory_allocated and udp_memory_allocated is not good enough.

It makes sure to put these fields at the start of a cache line,
but does not prevent the linker from using the cache line for other
fields, with potential performance impact.

nm -v vmlinux|egrep -5 "tcp_memory_allocated|udp_memory_allocated"

...
ffffffff849dd480 B tcp_memory_allocated
ffffffff849dd488 B google_shared_statistics
ffffffff849dd4a0 b tcp_orphan_cache
ffffffff849dd4a4 b tcp_enable_tx_delay.__tcp_tx_delay_enabled
...
ffffffff849dddc0 B udp_memory_allocated
ffffffff849dddc8 B udp_encap_needed_key
ffffffff849dddd8 B udpv6_encap_needed_key
ffffffff849dddf0 b inetsw_lock

One solution is to move these sensitive fields to a structure,
so that the compiler is forced to add empty holes between each member.

nm -v vmlinux|egrep -2 "tcp_memory_allocated|udp_memory_allocated|net_aligned_data"

ffffffff885af970 b mem_id_init
ffffffff885af980 b __key.0
ffffffff885af9c0 B net_aligned_data
ffffffff885afa80 B page_pool_mem_providers
ffffffff885afa90 b __key.2


Eric Dumazet (4):
  net: add struct net_aligned_data
  net: move net_cookie into net_aligned_data
  tcp: move tcp_memory_allocated into net_aligned_data
  udp: move udp_memory_allocated into net_aligned_data

 include/net/aligned_data.h | 21 +++++++++++++++++++++
 include/net/tcp.h          |  1 -
 include/net/udp.h          |  1 -
 net/core/hotdata.c         |  5 +++++
 net/core/net_namespace.c   |  8 ++------
 net/ipv4/tcp.c             |  2 --
 net/ipv4/tcp_ipv4.c        |  3 ++-
 net/ipv4/udp.c             |  4 +---
 net/ipv4/udp_impl.h        |  1 +
 net/ipv4/udplite.c         |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 ++-
 net/ipv6/udp.c             |  2 +-
 net/ipv6/udp_impl.h        |  1 +
 net/ipv6/udplite.c         |  2 +-
 net/mptcp/protocol.c       |  3 ++-
 15 files changed, 40 insertions(+), 19 deletions(-)
 create mode 100644 include/net/aligned_data.h

-- 
2.50.0.727.gbf7dc18ff4-goog


