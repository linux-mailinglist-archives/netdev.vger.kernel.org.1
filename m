Return-Path: <netdev+bounces-163998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E79A2C43D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7271116351F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0331F561D;
	Fri,  7 Feb 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CARTwS5V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C041F4169
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936725; cv=none; b=D/usFiQxPw3vJ/ArWduIs60vBFdo9GYT4CzjoI8wuqBysqotL9qx5Ig5gwSRwoEHRorSKj25Vv5SLeCdgKcnCzHLpzrP8Bz2YI/FR+o/1b7ycvMBYduIXuwfrsrRJ5f0cr9QNDgrZjpRs5emQJ1v4PJikM6vU7SzYWEW4MzCfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936725; c=relaxed/simple;
	bh=iYD556BzTX92D82Ts3p96G1Tdy6nn1rNf1kuY9uD/eU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tvLaSadCPTBItfdG5jHEpN9g5JnQcuyHXeWtXgLqbOBhrHwb8KgyTyYwGRPUTgDSAeCRtwdGGwSg8/eqkRlDY/tPgD/rFGKQnT+9BPT2yend8/5X/jxLBVnkhdoProkTeuFd87Jr8DWh7J+YSpZZj7CP43pyOikFPeZyp/kTEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CARTwS5V; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e43ed0ec4aso23729046d6.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936722; x=1739541522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEEmRontdIfw97YkeB8Mp9ZluDJHhqq6+xm6UubYeV8=;
        b=CARTwS5VolT9ndhM646wzwUUly9th00DQOZEF+7cqQWSamn7EK0JiSV+4ler0JyRJM
         q50i0obsZf1pWdjIwQPAAAyGW643+aeOzGH0I+1HLO/V1UXAPV4lOa/BnewyBY0XflQR
         DQcbXi9k9o22suB1kBYO73Ng8YmmzUzWKhEDJ2x0uXUx3No/Eq/MKxYpagTW5z6axsPM
         BhGJclPlDa+nZLimLpVvV/xx2wSbSDzK2tqN7yMvs10Q43iwKEplTAGWIHqD9MUjzR1s
         M2Kbb9Jqc+PU2KA+Y84bhXZk8YSWzGscONE7NbnR1FK8Ano6/UPA64W2slkobCL/C3Xx
         /ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936722; x=1739541522;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEEmRontdIfw97YkeB8Mp9ZluDJHhqq6+xm6UubYeV8=;
        b=HiEQ2gtYHfmw0QQeun7hggTGFYplnnJnA6nXKnjX/qqNUVv58HN810dI/1ZGIESXhp
         1gLpmqOi74AAu/hNV6nY5E5Tqwhkf3oHavmVDJ64UQSzGGvvdgVcT8lJl/7xfZTNPeIX
         sORordpgNidt6tUEFPIa0CaEPeLFfT8ZcPAxCMGjG5fLuuQzce0BZqANwbteDdtmiZpk
         8bl3wRXeM7cWb9y2P/Up6/hEV0H8YUQPH/WlH8p3qSXBcT0wAo2cVhbMhc9CRJzlmXaM
         /CO3y6S327jknEjN/HHqwabe0C4sa0jUcCap4WXonTenifuPGhmx9z7BiZjkZJojrMEi
         yPww==
X-Gm-Message-State: AOJu0YwP/aKBtWHXcmZIaOnUuv5ebbk4pYYC3L1RFZx+coeB+jgOsr9c
	mLbFfJYaKrEuoLDdUVAbNNIJ2icUx5Yqc3kB6OUOUzMhGh6j4MZX2ztSBq7TvKGeIODhkAiBAbe
	vyJliZZVXtw==
X-Google-Smtp-Source: AGHT+IGemjNa/mSNG5LfShT97Itxe/pS97Ir1pS/+ANnSUd8KGA9QBDnfp4BFtLthZ3SPwZhyQdvYdCDhQUDag==
X-Received: from qvbow18.prod.google.com ([2002:a05:6214:3f92:b0:6e2:4dfe:895d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5f48:0:b0:6d8:b81c:ecc1 with SMTP id 6a1803df08f44-6e4459c3e61mr43481976d6.13.1738936722571;
 Fri, 07 Feb 2025 05:58:42 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-1-edumazet@google.com>
Subject: [PATCH net 0/8] net: second round to use dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net(dev) should either be protected by RTNL or RCU.

There is no LOCKDEP support yet for this helper.

Adding it would trigger too many splats.

This second series fixes some of them.

Eric Dumazet (8):
  ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
  ndisc: use RCU protection in ndisc_alloc_skb()
  neighbour: use RCU protection in __neigh_notify()
  arp: use RCU protection in arp_xmit()
  openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
  vrf: use RCU protection in l3mdev_l3_out()
  ndisc: extend RCU protection in ndisc_send_skb()
  ipv6: mcast: extend RCU protection in igmp6_send()

 include/net/l3mdev.h       |  2 ++
 net/core/neighbour.c       |  8 ++++++--
 net/ipv4/arp.c             |  4 +++-
 net/ipv6/mcast.c           | 31 +++++++++++++++----------------
 net/ipv6/ndisc.c           | 24 +++++++++++++-----------
 net/openvswitch/datapath.c | 12 +++++++++---
 6 files changed, 48 insertions(+), 33 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


