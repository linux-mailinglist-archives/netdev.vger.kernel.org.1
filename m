Return-Path: <netdev+bounces-189689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17577AB3391
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC84189B480
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9D266B7F;
	Mon, 12 May 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S/Y+iDG/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6x6vUzdN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AB25DD17
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042065; cv=none; b=I/bYNSATsl+oTZlY7odBMwYJd/ZbEv2ZnUfaq0+qdFXXnYujKBLHeitNAHXXiWrazKvGuwCbaL26cS6h97ThgUUe2aKemFf4ZQMZ33ogyazhtie3m6NtHCLLdANXVsh/JrunLPv39QK4GkjSTgCIuBmsMFz0QWSrpLl/CN5Pl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042065; c=relaxed/simple;
	bh=0+Ksli5EQaWGaOkAnBgor72S4sJr/MfaOZ+uBIe4pOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vl8zs637VA39c0j20nuj3r3BIzsWEdSYpeWAuaBW6ep9qL2swh+tpi8P5ziV1Ad7mC0t2NSRBteoLLBa5gNNzYKAQpXA8HyHjdcWZKa3zyrddvuOH4oiL1gCEuy9fsKOkmlGIpYtNn7Pfszn/qhEERWewg4Od3BLsP6Uq5f6/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/Y+iDG/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6x6vUzdN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9bvJbz4rA6x9F64n3GMRGwdtwxVa5d/y5IWIS2DHrw=;
	b=S/Y+iDG/LYNj34ExQpKU67C6mCkJ94TjR0SiAC3nHy1+++8QLZn5Zu2pcvdpoEd2RWVH9l
	bIhr1lC2v0cMoBuznAJ82YRlUi7gt3cCe2plMkOQpsX7H3ePD8RtLGnvQT3nsNXAKvgftT
	kiEEHzWyA32QDW/CCSFKzpUSG+Z4aoFygZRoNNKZRo2R9j6LERCFkIoCyOd4nH5YWdT9Qc
	T8d/3O9Pnkh7DKYAhJhqbDC47bzr6ckkizsYrRO0LE9ry9BPZoOyb6q34pD4W4aP68oFEE
	947BEqJzPQyXDcC4JL7gPFOP5ft2cDUtXkLrL20S/uH7hterGGMM4IN05H/uJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x9bvJbz4rA6x9F64n3GMRGwdtwxVa5d/y5IWIS2DHrw=;
	b=6x6vUzdNuT0ervVv7xaCWt9o0LXfzQoPT8gAlnzyPHRPOrofDG/n7uOCV442If0gyMsvro
	E2diASTBHDLXXxAQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v4 00/15] net: Cover more per-CPU storage with local nested BH locking
Date: Mon, 12 May 2025 11:27:21 +0200
Message-ID: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I was looking at the build-time defined per-CPU variables in net/ and
added the needed local-BH-locks in order to be able to remove the
current per-CPU lock in local_bh_disable() on PREMPT_RT.

The work is not yet complete, I just wanted to post what I have so far
instead of sitting on it.

v3=E2=80=A6v4: https://lore.kernel.org/all/20250430124758.1159480-1-bigeasy=
@linutronix.de/
   - xdp: Extend locked section and create a single unlock/ exit path in
     xdp_copy_frags_from_zc(). Toke asked for this.
   - Dropped the netfilter patches.
   - Fixed up a typo in the openswitch comment.

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


Sebastian Andrzej Siewior (15):
  net: page_pool: Don't recycle into cache on PREEMPT_RT
  net: dst_cache: Use nested-BH locking for dst_cache::cache
  ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
  ipv6: sr: Use nested-BH locking for hmac_storage
  xdp: Use nested-BH locking for system_page_pool
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

 include/linux/netdevice.h      |  7 ++-
 include/linux/netdevice_xmit.h |  3 ++
 net/core/dev.c                 | 15 ++++--
 net/core/dst_cache.c           | 30 ++++++++++--
 net/core/page_pool.c           |  4 ++
 net/core/xdp.c                 | 15 ++++--
 net/ipv4/route.c               |  4 ++
 net/ipv6/seg6_hmac.c           | 13 ++++-
 net/mptcp/protocol.c           |  4 +-
 net/mptcp/protocol.h           |  9 +++-
 net/openvswitch/actions.c      | 86 +++++-----------------------------
 net/openvswitch/datapath.c     | 33 +++++++++----
 net/openvswitch/datapath.h     | 52 ++++++++++++++++++--
 net/rds/page.c                 | 25 +++++-----
 net/sched/act_mirred.c         | 28 +++++++++--
 net/sched/sch_frag.c           | 10 +++-
 net/xfrm/xfrm_nat_keepalive.c  | 30 ++++++++----
 17 files changed, 241 insertions(+), 127 deletions(-)

--=20
2.49.0

