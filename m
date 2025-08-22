Return-Path: <netdev+bounces-216126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BDB3229F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD81DAE0BBB
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7152C3257;
	Fri, 22 Aug 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTBtSWFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7512C159F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889703; cv=none; b=N9tQrvdtrZLdjvIuPkF0C5aFgA/eZI9PAsWkOClFORRXsGeoN/67Samjka5D6jbu42OlDccG02CP021dl7PvYQCP2qUWRkCD3RLHo83Gls+2NeHKiBoXo7PYRly6kR+7jCcRsH+MK5bwUx/JkR5VVzA4SWXlyI0VxRGBNLqziXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889703; c=relaxed/simple;
	bh=Id0l3GpntZj4oemg8siKw9vj4vV2F7t83HwLPrfWXIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D4f+U2WYb9p+Y55g0BtqVCr1U5D99ORJbe4Z2XOh2KHO2zR3l7I3SMXTebgmDNttadgoyB9Xw+kqVMnA2sO/lqFJJ1bpjIVqdgT7tZj0NnYPfm8kxsgLZvNYXt0MfDGepM6960BbR/Bwzhkq60zGxXJuSYlS0zibJyN1pyrW59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTBtSWFB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3252a37fda8so726724a91.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889701; x=1756494501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJVxuFfmZz9IaVLzh4cSHGYDhL9aFVzK1W98bFitC+E=;
        b=kTBtSWFB3MtENVl2/nuw3zETmPPINkMFpPMQrqvA6Wib6bwLj2VD0DxExyXfabOz3U
         8aSUnMBU6kKeCJOYHawpZkNzHeXTJjNpYQtcsFIQZrlw/40IInAoJ5AHU0bmHTQoYvXv
         CzElnT0KM7VIsI3LrbueiD457zqKFVgJctse/iXu/7fDPNkgPoSq6Sm+FZdOqyo7nEgv
         54NnocciOdtNeCN2B2fNbCyBDorAEHSb250yKsRsaayghwWmTtSvJq9Q81rLzpqrFnTy
         XFXLraohf3j66reiIp0Zi4ZA3NwXEHKP75qQm4HPX6demifBpdn304QTlepK8I0seKIH
         BccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889701; x=1756494501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJVxuFfmZz9IaVLzh4cSHGYDhL9aFVzK1W98bFitC+E=;
        b=tIioTVNTSTRCqWa00bpQd6/QRqUBnHyfeJJEUZdaCn8sT4oflCG2T5aGzOup98pF3J
         mphNSTavtn/SEdTxgNic256gq+zM0ZQFBKFVCY4ncBFRRs8VIgvJ84w6EMZwPDd0mzPj
         uN5BaY7huBL2wi6TFRu6lMt296SQEGLGH+Fo0sLMUHzVczZgpBbSWskBlNyA/k13EThY
         shaPD1S0a1Ot6QKhvpa0RkcluqfniJLX3gMmRuPuzUjuT7eKo2aaot5Rq/srpWCvK0bj
         5FE7KnLagY+a19/3+RkqbAoXurVEdOpO/6Z5xobSOvfvSf1TqQQ29w/7mERNMNd9AqPu
         VTYA==
X-Forwarded-Encrypted: i=1; AJvYcCVFpeGtEEwueRzw7yclFw4Pvi4k9N+uqR9jqGpm/z0R+l05lnK7yb9RWEdXCb+hFzp2PfhTirE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOwJXBwB4ncYd7UtUatuhbIPvR3CUA+6gsYofiYbeatrPuE+e
	2x6Cb9nwRJjPYd4QnFjBM3eVel6USaCmbg92v+LMfi2PYBBPdX73hCU2Bxdw+ojcpZ+a0zJMbif
	ZzOP4gw==
X-Google-Smtp-Source: AGHT+IEewTM1VuoIvP4MtpXXD6dMl5boIiywjIooc6rqvsv0cTE4dOCHJeX34jed/ZS3IW6e5utc9Gehp5U=
X-Received: from pjbpq15.prod.google.com ([2002:a17:90b:3d8f:b0:321:a6cc:51c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288e:b0:324:dfd8:3426
 with SMTP id 98e67ed59e1d1-32518a8c604mr5765398a91.35.1755889701443; Fri, 22
 Aug 2025 12:08:21 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:06:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/6] tcp: Follow up for DCCP removal.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As I mentioned in [0], TCP still has code for DCCP.

This series cleans up such leftovers.

[0]: https://patch.msgid.link/20250410023921.11307-3-kuniyu@amazon.com


Changes:
  v2:
    * Fix up my email address in patch 1~3
    * Drop patch 2

  v1: https://lore.kernel.org/netdev/20250821061540.2876953-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  tcp: Remove sk_protocol test for tcp_twsk_unique().
  tcp: Remove timewait_sock_ops.twsk_destructor().
  tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
  tcp: Don't pass hashinfo to socket lookup helpers.
  tcp: Don't pass hashinfo to inet_diag helpers.
  tcp: Move TCP-specific diag functions to tcp_diag.c.

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |   9 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   9 +-
 include/linux/inet_diag.h                     |  13 -
 include/net/inet6_hashtables.h                |  18 +-
 include/net/inet_hashtables.h                 |  37 +-
 include/net/timewait_sock.h                   |   7 -
 net/core/filter.c                             |   5 +-
 net/ipv4/esp4.c                               |   4 +-
 net/ipv4/inet_diag.c                          | 479 ------------------
 net/ipv4/inet_hashtables.c                    |  34 +-
 net/ipv4/inet_timewait_sock.c                 |   5 +-
 net/ipv4/netfilter/nf_socket_ipv4.c           |   3 +-
 net/ipv4/netfilter/nf_tproxy_ipv4.c           |   5 +-
 net/ipv4/tcp_diag.c                           | 463 ++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |  17 +-
 net/ipv4/tcp_minisocks.c                      |   1 -
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv6/esp6.c                               |   4 +-
 net/ipv6/inet6_hashtables.c                   |  51 +-
 net/ipv6/netfilter/nf_socket_ipv6.c           |   3 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c           |   5 +-
 net/ipv6/tcp_ipv6.c                           |  15 +-
 net/ipv6/tcpv6_offload.c                      |   3 +-
 23 files changed, 549 insertions(+), 644 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


