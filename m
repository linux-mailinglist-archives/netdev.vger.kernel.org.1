Return-Path: <netdev+bounces-215493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B8B2EE00
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0151C3BEB24
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2054764;
	Thu, 21 Aug 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNd7c0gy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBE35971
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756960; cv=none; b=MJ2AT8SGDSrE6Sly50S+uwnEpjXfkm32ZCbc5yVhTlhyzyHxk9QGwsjIKgdFxH594n/q5U6r/LVZE3lKZFX8BDA6wBf682Ft+kbUxxThVTR8QYeZbdptUB14BDoFzpbN1tQ42VrL5HmkaafvrBLbem2Wj7iD8CHCi0ntKrNSPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756960; c=relaxed/simple;
	bh=advS7tFPj+KSAi51td9+tVuCge1RSTi75os3B77Y6yE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=msaMMuLDBCJG6MDqVrCU0Eqg6LHzvQLU91Rvwwc0norCJ4Dcq1Rr7Ucle45axJcA7itFEyFvv8o3MTUPmtNu2moIcTdHeI3oGkdAvMqtFLFEpGX8rZWyijxwMBdM677rFjwSsoqwuG5S7EnzRvWIbfdR67KnNJxkR6xnN2mz7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNd7c0gy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso1751194b3a.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756959; x=1756361759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7UGCWhHd8YN0Zoigl9+6ZYmmGsiN5D2hfa+nEsPL3F0=;
        b=aNd7c0gyih7sF57MukZbj431eQvlnMzohfOSXLqmY59QgHIEBNwmBF25v8rocVwTz5
         QQ7HliUS/Wbr5wpmhgU5F0noZYqbQQirUyuco7hN/O/Jz1W7swqmBuBmld3i9CFxWGb8
         Pglo5yO+hG4p30Ad2wO6qMQAuN72klmoju7OqZZAsuPHIq3oS313deBskx/1Y9w7PUvs
         WC+IB/HsMnphpt3kYQ/W8Ae0gdOTLbHiWp/U1qvLumRHahHSGhjYqPztiQn+YpUebRJh
         Uoa+5BtKJa1o+dQdR0RriN9dcPef6x4pmHfWd1gBKhNfUjQG1vaG1lFmCPylwqgSucj6
         1c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756959; x=1756361759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UGCWhHd8YN0Zoigl9+6ZYmmGsiN5D2hfa+nEsPL3F0=;
        b=Ki6HNyo41mjLOJQ13yfMDm4aAt5Yrj3ECtdUjxGuJKq5HYRhLPh+lh2SEK4a+yLn/O
         SWS5KdbW0/s1Dch5cMmu+jyVEo1audBHJ+u+laF+M5kBXXg0ugCmM/yXESTbY2s035bt
         ENzbx5dyR3mvN3reXfun8PVh84mT4IRyQq9T+KnhZzlXGwVga7Dj6gxfOXeR0fi79cP0
         stT6BPlxREnrdFcqCn4pNQcE3sPNrRqATw/HUwJqRFflem/cPDZCGuDd5lESkleOD2cP
         ZPmbopeuvKt7U0kBaIln0sF3bDKheQFEBgg4f8pvVE06dldHXfBqF0blzgshAGzW9g1I
         AvHg==
X-Forwarded-Encrypted: i=1; AJvYcCXR9fc1SdTH+dgyvUrYWWiQTXoI+8lawcyR13ycTzMXKsX09DNX1QTs0zfANzYx61MIQmHaS74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzEYxVp5M+EVhHXzDLG2KPN3PVp1QKYP80X5jogMR3xQpJ1Ie
	fnT176sHNJwQojXOZVHf7j57WO+6TekA2fZaIXKMeS7Aj78zgJFR05omcLoSEnYlHWwepOMK9mC
	eBr9Pzg==
X-Google-Smtp-Source: AGHT+IGtKcHlPTV6dzqEKqfmgG+bmmt4y66ZZv/89+Lm8IFS3ykgTUNPjt87icc9HAs7h6om7Yw0joSDW5Y=
X-Received: from pjbsn7.prod.google.com ([2002:a17:90b:2e87:b0:312:dbc:f731])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5483:b0:243:15b9:765f
 with SMTP id adf61e73a8af0-24330b6a45emr1745203637.57.1755756958760; Wed, 20
 Aug 2025 23:15:58 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/7] tcp: Follow up for DCCP removal.
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


Kuniyuki Iwashima (7):
  tcp: Remove sk_protocol test for tcp_twsk_unique().
  tcp: Save __module_get() for TIME_WAIT sockets.
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
 include/net/inet_timewait_sock.h              |   1 -
 include/net/timewait_sock.h                   |   7 -
 net/core/filter.c                             |   5 +-
 net/ipv4/esp4.c                               |   4 +-
 net/ipv4/inet_diag.c                          | 479 ------------------
 net/ipv4/inet_hashtables.c                    |  34 +-
 net/ipv4/inet_timewait_sock.c                 |  11 +-
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
 24 files changed, 549 insertions(+), 651 deletions(-)

-- 
2.51.0.rc1.193.gad69d77794-goog


