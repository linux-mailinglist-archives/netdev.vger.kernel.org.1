Return-Path: <netdev+bounces-68121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33435845E24
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B296F1F27E07
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142715CD45;
	Thu,  1 Feb 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bh4PFEaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8277A1A
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807381; cv=none; b=SMfzx6B+C/jxTYmsH++OZ6MR0q93dWRx8VFWIC5IdoYJVvwGtE5ggNib68uUm1lWoY/7d40tWu7BFuPi3AZzxDUZix2P5FgrcZUGHnjthJaXagjVGa77OXjcFpkoMSDhzyMAYFF9GSHVrRTiagTogYVENjo9adiUmcI1CrcXrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807381; c=relaxed/simple;
	bh=qKdLtmmFqMpMa5/7/R9DT0nEKVut95GnUfuy08qxqr0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nsFVsSxq3wHKpmgiOXgjp1g81sAZH1M+maYdahr0m30GX79NY+CeMp/wIirdysHlAwxNjScZk/hQ1GV2YBywZshvqkpDwr25JbJmyHOoLMghh59g9GcKdwbZtF3ydS6LFCe4Go+wb5HIhQ4iYd9kR6jXbWxgGBLsp7b1MfWqE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bh4PFEaS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so1596365276.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807379; x=1707412179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l/1cmhuzEu7aL3blP7EqH4HPx5HG6bVQdpDkQJabhpc=;
        b=bh4PFEaSh3kNqQCtYJGLR6Mb05yutGcgeT0Amb3ny91f7cRUEl7WaSRGpgheZ1KgI2
         VuVEm6OuxUQdlwnOMkFCc5GPD5k2rwpACnJfxO1W7fRm4TJ+52ILd5Skv6tSqSZmBhDu
         90VI3edn1Erq7end1qwuoyJaASR7zmXS/ZaGywjDHHgBiGT8ByX8AbmlGG9hNlDvfHvq
         3DX/1tpqaINGbRwR0Ff5Df/6jxvUcr+cg9bpGxB/oWJYBRa53F5yTFwhHErUpysKFo2S
         wA4lo5omOmSc6JMLx3lyB70VP2KOxx6D3QFYeWT9khG/8Z/7csq+ji3Ei11V7vZNmoXD
         DieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807379; x=1707412179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/1cmhuzEu7aL3blP7EqH4HPx5HG6bVQdpDkQJabhpc=;
        b=YL1IzVNSLnarsH6BPmBkqmAQBUHnIKFoZTtVneqpP42MMr3fFIZ6IrbJNu6DVgl+2v
         FbxaEOSpFqNo2w0wHhCQI1voZ8TYreAmRrMadGKND6GzK99/ZhC/ZmB87gP/h++7Aqmg
         4kIAzwnvYoBExMdxtPB8mU52WfukT6eVk2evw1CXXe78x8MidS5pnAVsXKfspHAGlhV7
         e9EcBU0qjiELTUHNxcOGOuNv5514wRCCVR+1xLSeOO+BjijA6rlh8De/0EhBKcwjtfEx
         tawg8lN2TZ7TvAM7rQ4A2LSOC1YdGcAbALBm80wcyrwne5biVKxyAMezFPH7UzZ7TJ2B
         Xn/Q==
X-Gm-Message-State: AOJu0YwZGHUOpSUUvMC0RbcYmLvX0F9/kc633nmvQj40tlr9k1W41gSp
	iI8Cv9L6z685JGCcmTGnC/68ZNtg2dUCUq8T3Z4EzwCoFgjHzUtIwNU3n9yvT4QR+weITndO6n3
	wKwJnqNmWTg==
X-Google-Smtp-Source: AGHT+IH7zbSjxtmqzJkBKvF50nl2ap0ZrVp1qPrjZkGH6gD6Z9X4vPMkfOWpH3yTJXMxP2V0uMNjjT6n1niF+g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:228f:b0:dc2:3cf3:5471 with SMTP
 id dn15-20020a056902228f00b00dc23cf35471mr192147ybb.6.1706807378985; Thu, 01
 Feb 2024 09:09:38 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-1-edumazet@google.com>
Subject: [PATCH net-next 00/16] net: more factorization in cleanup_net() paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by recent syzbot reports hinting to RTNL and
workqueue abuses.

rtnl_lock() is unfair to (single threaded) cleanup_net(), because
many threads can cause contention on it.

This series adds a new (struct pernet_operations) method,
so that cleanup_net() can hold RTNL longer once it finally
acquires it.

It also factorizes unregister_netdevice_many(), to further
reduce stalls in cleanup_net().

Eric Dumazet (16):
  net: add exit_batch_rtnl() method
  nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
  net: convert default_device_exit_batch() to exit_batch_rtnl method
  bareudp: use exit_batch_rtnl() method
  bonding: use exit_batch_rtnl() method
  geneve: use exit_batch_rtnl() method
  gtp: use exit_batch_rtnl() method
  ipv4: add __unregister_nexthop_notifier()
  vxlan: use exit_batch_rtnl() method
  ip6_gre: use exit_batch_rtnl() method
  ip6_tunnel: use exit_batch_rtnl() method
  ip6_vti: use exit_batch_rtnl() method
  sit: use exit_batch_rtnl() method
  ip_tunnel: use exit_batch_rtnl() method
  bridge: use exit_batch_rtnl() method
  xfrm: interface: use exit_batch_rtnl() method

 drivers/net/bareudp.c           | 13 ++++-------
 drivers/net/bonding/bond_main.c | 20 ++++++++---------
 drivers/net/geneve.c            | 13 ++++-------
 drivers/net/gtp.c               | 20 ++++++++---------
 drivers/net/vxlan/vxlan_core.c  | 21 ++++++++++--------
 include/net/ip_tunnels.h        |  3 ++-
 include/net/net_namespace.h     |  3 +++
 include/net/nexthop.h           |  1 +
 net/bridge/br.c                 | 15 +++++--------
 net/core/dev.c                  | 13 +++++------
 net/core/net_namespace.c        | 31 ++++++++++++++++++++++++++-
 net/ipv4/ip_gre.c               | 24 +++++++++++++--------
 net/ipv4/ip_tunnel.c            | 10 ++++-----
 net/ipv4/ip_vti.c               |  8 ++++---
 net/ipv4/ipip.c                 |  8 ++++---
 net/ipv4/nexthop.c              | 38 ++++++++++++++++++++++-----------
 net/ipv6/ip6_gre.c              | 12 +++++------
 net/ipv6/ip6_tunnel.c           | 12 +++++------
 net/ipv6/ip6_vti.c              | 12 +++++------
 net/ipv6/sit.c                  | 13 +++++------
 net/xfrm/xfrm_interface_core.c  | 14 ++++++------
 21 files changed, 166 insertions(+), 138 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


