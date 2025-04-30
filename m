Return-Path: <netdev+bounces-187054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD6AA4B92
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF1D4E29BD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7BD25C818;
	Wed, 30 Apr 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIAtxpDp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULrGmAUO"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95A25C705
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017293; cv=none; b=ORrrCP31G0ldFnXFWI0zgXH9suVxQeOdrLJ4maerbwG0Lif7a9sU5niy0YaBnuJIVseNBe0IARk56XfgytWvqXG2B12qU4i3tiZ8CtjrHe8S2Sa7vnXLoxKBcBB/qDmVtan6W0x38NAm+p1JEpOJulZejAcRduWH5fPiVcpYfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017293; c=relaxed/simple;
	bh=I87ZPnyoNaZmlPOTsdMHJ3j1zdCA5kVVNwOkDGhSVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNVejzSakSYdH2nYjGXSiiI+AQjexD/xYJJIZNivaOVn05Q+Lj13TNd5m5I7exXjH21qU3gj9KQnk/8PvRR8637ba8dl0EIVPyWqIpXHNRuWOTT6hL9UbdvPVJdKy4EknoO6zn7s22hNtkM8iCOkhfF4CcFUFP3pP0WLVSB8IVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIAtxpDp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULrGmAUO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4zEXvrwbF60B2X3EX6MpWz0vM+Y5gCeoZzwbVxbnbZU=;
	b=vIAtxpDpRJW9YV7s3+uYzKF0ugsPlKiRT4WOgIXtzQYlxw1yzsG4W1Xz2nT8bwInJYtdGZ
	0WWWHLxbgZ4a6L+7/UrXtj/chzFyEvzA5jv8wXAoxbjV2v5Mkh9qhohYmeZ5LjhIZm0tAn
	p1Ht8cTniZB7F4OwK1KDUhQF0WslBVb+cgHS23ks1q2uTSmtO9tx8Fz3QsvNmFPUMuokxf
	1+DjPFT3hbCg8ipK3ZoZcyh/p57Tx2fNFSIziquuQgSm4Sv3AyehplPI8SnHobIh/kTJ9j
	y9zVgKtl1nlu860RHyxkCLByDZHgXAOTHTbcTk/mDNmkLc6tmIIopQe5HJ97CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4zEXvrwbF60B2X3EX6MpWz0vM+Y5gCeoZzwbVxbnbZU=;
	b=ULrGmAUO4B86rUNvoY63S1VSlie8kBDB+P0hMXQw9icw/7Yr9N1pZ6GsB3YJP0HRcs5hN4
	enfRC1VsFfEosyBQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v3 00/18] net: Cover more per-CPU storage with local nested BH locking.
Date: Wed, 30 Apr 2025 14:47:40 +0200
Message-ID: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I was looking at the build-time defined per-CPU variables in net/ and
added the needed local-BH-locks in order to be able to remove the
current per-CPU lock in local_bh_disable() on PREMPT_RT.

The work is not yet complete, I just wanted to post what I have so far
instead of sitting on it.

v2=E2=80=A6v3: https://lore.kernel.org/all/20250414160754.503321-1-bigeasy@=
linutronix.de
   - openvswitch: Limit the ovs_pcpu_storage::owner assignment (and so
     the whole locking procedure in the recursive case) to PREEMPT_RT.
   - Add acked-by from sched folks for "netfilter: nf_dup{4, 6}: Move
     duplication check to task_struct"

v1=E2=80=A6v2: https://lore.kernel.org/all/20250309144653.825351-1-bigeasy@=
linutronix.de
   - act_mirred: Using proper variable on PREEMPT_RT, noticed by Davide
     Caratti.
   - openvswitch:
     - Renamed the per-CPU variable to ovs_pcpu_storage.
     - Moved some data structures from action.c to datapath.h in order
       to implement the locking within datapath.c.

Sebastian Andrzej Siewior (18):
  net: page_pool: Don't recycle into cache on PREEMPT_RT
  net: dst_cache: Use nested-BH locking for dst_cache::cache
  ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
  ipv6: sr: Use nested-BH locking for hmac_storage
  xdp: Use nested-BH locking for system_page_pool
  netfilter: nf_dup{4, 6}: Move duplication check to task_struct
  netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx
  netfilter: nf_dup_netdev: Move the recursion counter struct
    netdev_xmit
  xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
  openvswitch: Merge three per-CPU structures into one
  openvswitch: Use nested-BH locking for ovs_pcpu_storage
  openvswitch: Move ovs_frag_data_storage into the struct
    ovs_pcpu_storage
  net/sched: act_mirred: Move the recursion counter struct netdev_xmit
  net/sched: Use nested-BH locking for sch_frag_data_storage
  mptcp: Use nested-BH locking for hmac_storage
  rds: Disable only bottom halves in rds_page_remainder_alloc()
  rds: Acquire per-CPU pointer within BH disabled section
  rds: Use nested-BH locking for rds_page_remainder

 include/linux/netdevice.h        |  7 ++-
 include/linux/netdevice_xmit.h   |  6 +++
 include/linux/netfilter.h        | 11 ----
 include/linux/sched.h            |  1 +
 net/core/dev.c                   | 15 ++++--
 net/core/dst_cache.c             | 30 +++++++++--
 net/core/page_pool.c             |  4 ++
 net/core/xdp.c                   | 11 +++-
 net/ipv4/netfilter/ip_tables.c   |  2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c |  6 +--
 net/ipv4/route.c                 |  4 ++
 net/ipv6/netfilter/ip6_tables.c  |  2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c |  6 +--
 net/ipv6/seg6_hmac.c             | 13 ++++-
 net/mptcp/protocol.c             |  4 +-
 net/mptcp/protocol.h             |  9 +++-
 net/netfilter/core.c             |  3 --
 net/netfilter/nf_dup_netdev.c    | 22 ++++++--
 net/netfilter/nft_inner.c        | 18 +++++--
 net/openvswitch/actions.c        | 86 +++++---------------------------
 net/openvswitch/datapath.c       | 33 +++++++++---
 net/openvswitch/datapath.h       | 52 +++++++++++++++++--
 net/rds/page.c                   | 25 ++++++----
 net/sched/act_mirred.c           | 28 +++++++++--
 net/sched/sch_frag.c             | 10 +++-
 net/xfrm/xfrm_nat_keepalive.c    | 30 +++++++----
 26 files changed, 285 insertions(+), 153 deletions(-)

--=20
2.49.0


