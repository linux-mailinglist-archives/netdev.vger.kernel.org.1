Return-Path: <netdev+bounces-82898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27CC890218
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1F1C2D981
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0571272AC;
	Thu, 28 Mar 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFqzCQQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB4823CB
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636837; cv=none; b=BxP6D8JbRXNNKBdP7FUhtxA5beCtwtMoYsRlLDnRKYsRRLRiwg7sElIb8RDlVamiijvPAEdvggCRtQMCO9Mvqa7Y6g28ng5aWOfWTp11WpU0AprzobRlgkPIFjKKgDVWkmRKyck+SSZFtfss9EmGj2akSxgGLRPl/2dVt4Z9BEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636837; c=relaxed/simple;
	bh=lkPaoKPzxidKcyPh03190AbRKW8zWrlysr29NJHk8qA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N3YbO9a56gdBJwjlqQVkKdujwjxQ2Jx3tOfKvEfhxIl9OrRrZd/IYZXtS5nT1D+fKHVANSq+Q4CimE8MEGhUwjiQO2AFYK4tx+kcXS0nxeW+lgvtHPpttWMDkb2Diznajzork/mY4xcL9vgbqU6JRnYy/jkMjsygcTDOatoK3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFqzCQQS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso1364450276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636834; x=1712241634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzgF+TDCaR0KFcPaP54dKjTrgoQrZQDJnm0Od+se0Vk=;
        b=dFqzCQQSziJzzDs/gx67BTYqx1+v3MVqOKbY7pX7CkiiUvSW50CST+eNdm9bcrnSx3
         pHkHXf9vuvNWoK10CvHaQCl4aWOLXd/3gXGqRSF+L2IeC5STM2uld+nAd1u454LLZvWK
         Ua7s0QJVCQuLUe9YSho/DPGW6s37FwPZM0LjgrO1mi3dtBVBHd4kNK6MgD65B8aukiq4
         kBfOJulSNdOuIdJ1VgsYyjXyJ/qVRUqEcJblLndhM4dcJHs7Y4eFst4NipXHLEVgV4BW
         Xw8W1Zk3lYFyfbeMvzLAHFc6LK1AI30Fy1Jw5XJCnr6lgG4mKDnh14nY6xwRCZHFWhkL
         CsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636834; x=1712241634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzgF+TDCaR0KFcPaP54dKjTrgoQrZQDJnm0Od+se0Vk=;
        b=sy3A93U3lxH2ahlnPp6aNQN98QEHiOQk6t+yIJPNTKMq3QimeR5v2uKbZbg/udwvoR
         4H/rWNCewQLeZOxhhNjgLtkAA/ttl7M0EZ81gSt1MHcBVqg2geXXHUejY16Zg/uhG1aa
         Z0Xs70kQPyb85APoLbfDgX0HuAaCnURpxR9yAOy9HnNc8sd03jLc9TaLA4QnUpefioR8
         zH1Qo0tJpTJnC0DsFNn5y4aK6AD0B53oS+sK5wXlCJeRQcpiu0B7KGdxLERqHPuE8WMw
         QSpLR4thj1+AEE+vCAQVHJhBVNkZbe7Aqh5jy9QESvfGft0LWjnmdiAK7aBGSrUbCnQe
         YlVw==
X-Forwarded-Encrypted: i=1; AJvYcCUx1APujjjhHNDQN18sDWM2PLHpxWhSoRRwtMx1YqNVNIoWvwCZhOoT1KwuUHU/NKdhk6L1sk6dCGXDMOdndnu/wt4YrKOg
X-Gm-Message-State: AOJu0YyWymcbJu0/3wMmUNU7P9WLDcIs1gDs9EJGCLXaPy7XYdzBhzqo
	N3VruhyKx/sEm4EhrTAgVOO9XY/agDoooZlmUQ5b2wD+SZxWeoHIMPz2gz9ivXLnl4rzCtmP/6g
	05pMJleTt9w==
X-Google-Smtp-Source: AGHT+IH4zdUY1XwgNdYfB+sWmIN55MJwAfZlxrWR68TK91mlUVVMpUbEXTDrrpwpyHj8Vf3CZWHP0MW576KdDg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dc6:b768:2994 with SMTP
 id w9-20020a056902100900b00dc6b7682994mr216422ybt.0.1711636834439; Thu, 28
 Mar 2024 07:40:34 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:40:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328144032.1864988-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] udp: small changes on receive path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is based on an observation I made in UDP receive path.

The sock_def_readable() costs are pretty high, especially when
epoll is used to generate EPOLLIN events.

First patch annotates races on sk->sk_rcvbuf reads.

Second patch replaces an atomic_add_return()
 with a less expensive atomic_add()

Third patch avoids calling sock_def_readable() when possible.

Fourth patch adds sk_wake_async_rcu() to get better inlining
and code generation.

Eric Dumazet (4):
  udp: annotate data-race in __udp_enqueue_schedule_skb()
  udp: relax atomic operation on sk->sk_rmem_alloc
  udp: avoid calling sock_def_readable() if possible
  net: add sk_wake_async_rcu() helper

 crypto/af_alg.c      |  4 ++--
 include/net/sock.h   |  6 ++++++
 net/atm/common.c     |  2 +-
 net/core/sock.c      |  8 ++++----
 net/dccp/output.c    |  2 +-
 net/ipv4/udp.c       | 32 ++++++++++++++++++--------------
 net/iucv/af_iucv.c   |  2 +-
 net/rxrpc/af_rxrpc.c |  2 +-
 net/sctp/socket.c    |  2 +-
 net/smc/smc_rx.c     |  4 ++--
 net/unix/af_unix.c   |  2 +-
 11 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


