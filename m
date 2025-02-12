Return-Path: <netdev+bounces-165513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21238A326B7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4803A7493
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49A20E030;
	Wed, 12 Feb 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlEYsgWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A320E035
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366014; cv=none; b=MYqj3sNuYVKryEKegFKVBMGcnfdkaI3hYdwy41bG0ukDoUA4GC/mo/IftLVBKen++K5oOh+livGqdNbUmmW3a4chYc3FniXuwpwyTCUwBkrKITZpWzQgUgrBQjUCGb0Mk2SXKfdED2BBu9c2xDE9wwitpS+P874iyAmUokSVREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366014; c=relaxed/simple;
	bh=a8xQQLMVqUizZWIjOrZPg/n5JVFZLl4tZE0GZFsGDDM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W4vJkMdRcgjhLpUW3aDX9riYKE+LEgILbpgJ+wQxvu1eocfwaYnCN6Sn+c2GIhiAD59f/a0j3Ie1nkTJgQ3DM8vX2TNqjzY+3a/mE/wr4i2PBMiiDPFaMc/Jf1en3/ehtykVDvOvtx0HVovC8KvliNNH55yqYoB+JaGOqzSe7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlEYsgWu; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c07249127aso99194685a.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366011; x=1739970811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlWAbP6pSx00rFDd35hydgoW/Y9+dXdjwz3WH2vxzbE=;
        b=HlEYsgWuId8Hz8YLnmbNT/g3nplZWimxf/v6GMMd4vnrdCrVaX9y3Vuqy3T/yRd16m
         BSPoQQ6TR4ZW2vI9B0TCJxQrfckz7WdDG1JVtO1DkizVXbsqpPKnUDKjc0o1I6dBxd44
         GYFdkdkCoJ4ESLp1KbT4qoRLzBssvL1z5ZulF5uErdS2uosL4Qetc/WS4KtI4ucW6gjy
         Gw68bocHHmXeMMTaoer6oDlbNO2jBdEagebacWP5M5ivhlcQmy5i2Uyc9r4cvbK5HDEa
         aL7TdbHSbdvkD6ixEr78jzGDQRWaAE4cnvyilrYDsPk+eRRK8jdSIta/ktjD/+pLXz4z
         4/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366011; x=1739970811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlWAbP6pSx00rFDd35hydgoW/Y9+dXdjwz3WH2vxzbE=;
        b=M+VS/Ju4Fm1I4pnWoOSnVYreR4HwWzC1F9aCwWEX8/7rUZbO7AnlR9kvuZYgP80Y3o
         lw+xN9LMUXOPY2zSbcn9QxvRpqzC+CUUhjKV5XiK3EL25PqoFSMsBuwrUCwyb73jS/gk
         a5xcLxWR5Ijb7n9CJfhC8vrma+y4/fYTxL6Z8vpn7x4ZuzMLcjXm1eAQUxKH78F/ht7U
         w1k+hdWWm0s1h2eVP2DaGzMj6wV1tb0Jfpq5AGnaEOierNZ91WvHKS0Tv5/I+rRlxsA3
         gnBiVA4Knd/5r8yDIuFZrYZpFeYti05R7OGP7fo3vR8sM/lB6w9k5HSIEr21rBxAft9E
         v7hw==
X-Gm-Message-State: AOJu0YyN0BnRNs1TZ4ChEsK98s+PmXy4F7ii4ly64u1VBL19yIiLiFfz
	gifVEN76TZoX4WiV5M26RhEAfmZRpqaps+DGJlxTS3R6U+mL5RwL6NjbrMRtCHOfJPaWyAiGueu
	/kfHKGciATQ==
X-Google-Smtp-Source: AGHT+IF2k7Cnl3CgobWt0c8hQ5x+6elO62P3RNHLY0sIA6GWkEInT92OUKIwDPn7W8xYI9UiWyPggZIlqnfEBA==
X-Received: from qkbdx11.prod.google.com ([2002:a05:620a:608b:b0:7c0:6114:1fec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8393:b0:7b6:ea22:3069 with SMTP id af79cd13be357-7c06fc82754mr418923085a.26.1739366011524;
 Wed, 12 Feb 2025 05:13:31 -0800 (PST)
Date: Wed, 12 Feb 2025 13:13:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212131328.1514243-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] inet: better inet_sock_set_state() for passive flows
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Small series to make inet_sock_set_state() more interesting for 
LISTEN -> TCP_SYN_RECV changes : The 4-tuple parts are now correct.

First patch is a cleanup.

Eric Dumazet (2):
  inet: reduce inet_csk_clone_lock() indent level
  inet: consolidate inet_csk_clone_lock()

 net/dccp/ipv4.c                 |  3 --
 net/dccp/ipv6.c                 |  9 ++---
 net/ipv4/inet_connection_sock.c | 66 +++++++++++++++++++++------------
 net/ipv4/tcp_ipv4.c             |  4 --
 net/ipv6/tcp_ipv6.c             |  8 +---
 5 files changed, 48 insertions(+), 42 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


