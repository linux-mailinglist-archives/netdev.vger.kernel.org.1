Return-Path: <netdev+bounces-170961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F1A4ADC1
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F0D3B0BA9
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815B1E766E;
	Sat,  1 Mar 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsGxBWRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6821C3BE9
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860069; cv=none; b=SxvzVGbsdsC8OsJQxe0oS4qSejv+SuSn9FvxEvENtKJ9KpMRy59SyRy4MiTDGuqMacJ3rTBFszdfTJpeOJz8QP2swbmPKf59VrEKfe3JvB4PVGiXdaHI5IOt4A0fo5Stg3e2vtQEtt7THkoj/LFAtNwZjtyRhooEEKFq63g14ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860069; c=relaxed/simple;
	bh=TvY2nUWvxWiCUZ+HqFp/8DINzTFv4g2BLuW2qLcLth4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L9y825MPl463lV0ouu16Rw/iXZEVIiyCtspizouYF7+pe/JPYeDUhf6ONPOOZ4/FxDQE1cYMp8/k9Tt/AlWi3ntcKhatR/tK2Y2+cIn/SS4TSqFF6JjvSFXktx5USdVQrgRp8/WodVe/SFLiDM9Eti2tGz8EY3L+oi+mfh1FZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsGxBWRT; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471fc73b941so95432651cf.1
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740860067; x=1741464867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lB/LArvGHpuZUIYZf5b6fGU7II7mfdDl1/EvjKY8pfY=;
        b=FsGxBWRTkLq+Phdhjmz5stDGX2w6A9rZZHxuYeY3giQh2lv3diGQxOYnqXRqSkPmoE
         V7bu7nxkxf8IOOlgzl84+sydcpChVXsLdGt2Tjs75Zd6/vMwoPNjHjWCZhLOeAg07x7q
         IRz/I8havG6nkN8rYit4yRjwAMP/+dYRE4J0yMC1iHdyrk3Y/PEgDA095PhUkIA+i6HK
         N4wCoPSoFzQmg20w4rzDOY9tCL3VWDIElcLb/tsG7nITahKgCGkUKiGFUNFHfhcjMF9g
         eyajsQwcNdeGWZnSE3Z/tPywddiJ+6gfFHPYLnPonhBi1PpL/Og9W0Bfk1DNXnngReVn
         n01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740860067; x=1741464867;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB/LArvGHpuZUIYZf5b6fGU7II7mfdDl1/EvjKY8pfY=;
        b=wWJG9Vd2GkQDUEpHb6P4wFrrzNxHPQ5t+8gfp7rjYp2kRK63IXATF1O45xsAHF7Tet
         haPneV9kJ17/QRAtT7Cjt9oDDUyJnEXPJiVml2WDMyz2OpooKsh2UiyOgxcVGLNi4kfl
         G2eIp5hcsPmgzLMR5WSKqNeiVBhxCmulQxVrg2m16V3yH84yS5MYopB9PYlfha4WXZx5
         5vK6WBENR0JGtyDTMlX7/GCVVzQDJD7fKKq+J5a9s2tOUelMBFCpyvXYoqBY5cu3r9hD
         XS7lhwOgEJ0pj9I94pmz2wJKve9z6RXgVg4jOyRdjd12EKfqJ6W6x0ex8HfMct9yEAcU
         V3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9KcAmCaIyT9W9G7RZsAsLEMQB89yuy+ph1Z4p/3MeajrQN7mFYwq07oPasvWD+UugeieBOIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQE6Xrh6go1fARbDel6rmqNWeip0ODQo+7s73T0Xw9vXO50SM
	94KrolqRP+dQwjL2m1d6lGnevt5iMC0kiBhoJ7eQz2Xiwwa2jg09AwEKKiUenutZTRJyJark/I1
	wYTyCs7EDeA==
X-Google-Smtp-Source: AGHT+IHmahwmsW0YknXmM3S7MVbZmbBUE80eCM0fGI8Lh+6YP4lr+11lYrhlDqzfYlpCiozhQBna4KBfBvxR4g==
X-Received: from qtbew4.prod.google.com ([2002:a05:622a:5144:b0:472:b5:a08a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:594d:0:b0:472:13f8:a97c with SMTP id d75a77b69052e-474bc047442mr140981661cf.3.1740860066539;
 Sat, 01 Mar 2025 12:14:26 -0800 (PST)
Date: Sat,  1 Mar 2025 20:14:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250301201424.2046477-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/6] tcp: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Minor changes, following recent changes in TCP stack.

v2: typo for SKB_DROP_REASON_TCP_LISTEN_OVERFLOW kdoc (Jakub)

Eric Dumazet (6):
  tcp: add a drop_reason pointer to tcp_check_req()
  tcp: add four drop reasons to tcp_check_req()
  tcp: convert to dev_net_rcu()
  net: gro: convert four dev_net() calls
  tcp: remove READ_ONCE(req->ts_recent)
  tcp: tcp_set_window_clamp() cleanup

 include/net/dropreason-core.h  |  9 +++++++++
 include/net/inet6_hashtables.h |  2 +-
 include/net/inet_hashtables.h  |  2 +-
 include/net/tcp.h              |  2 +-
 net/ipv4/tcp.c                 | 36 +++++++++++++++++-----------------
 net/ipv4/tcp_input.c           |  5 ++---
 net/ipv4/tcp_ipv4.c            | 17 ++++++++--------
 net/ipv4/tcp_metrics.c         |  6 +++---
 net/ipv4/tcp_minisocks.c       | 17 +++++++++++-----
 net/ipv4/tcp_offload.c         |  2 +-
 net/ipv4/tcp_output.c          |  2 +-
 net/ipv4/udp_offload.c         |  2 +-
 net/ipv6/tcp_ipv6.c            | 27 +++++++++++++------------
 net/ipv6/tcpv6_offload.c       |  2 +-
 net/ipv6/udp_offload.c         |  2 +-
 15 files changed, 75 insertions(+), 58 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


