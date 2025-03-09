Return-Path: <netdev+bounces-173296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F594A584FF
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23A63AA92B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF711DE89C;
	Sun,  9 Mar 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4SAhaYq8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0YfjHxh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA61E515
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531631; cv=none; b=jQq12gJG4CLFROD3m1nA7Gk+9RuVQl8JoosGgyEMXx0JAFeZ4CEt6QIc2fpV9kdCONPGEnJxozlBqR879qTRa3fQRv56rLqoyd1c5uyYFCHY1qYmqAbWQxxS9AGrGhM2X12iAT6p3A+qcS6f3VBxsQBZBULuTldld/aaWcxMgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531631; c=relaxed/simple;
	bh=EmWsKh0P7DLoIKbXDB2RFmOTDq8O3PgLygT/t06D51c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfeduj4boNvLyLA0MLlMHxCLnG9dNTeqHUzdhJmI5hZHxW5bcwK60diPmVYn9C5qXbQoeqUMdemiCNbewLwRDTP0Yfragrd8Hs6vuOtTHAPtFolkrSstmit0xs8On2MiQXEDel3LPdEibwAsmF2a6hm1RPnnJRyIhr8ZXeiqN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4SAhaYq8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0YfjHxh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n0Rnq+i81ympraP8yaPqdbDb9LcK2XQmwtC4wiTcyDg=;
	b=4SAhaYq8QJw0eQLa8jIdYuPZgVabiRMyVc+j3rPy5DB8o7J51ccUwR/p2H8Gzurh4z0zVX
	vbeSXTiqhq+aYlBc0aTx/0Ah6qy+Gb93NOVoK1DLgL3yBZtL+BdNrrHdrltBb2yBwv47y+
	4I1CWlCaCotqmO58U2UuGuvlTFcQn0EL87d1YxtuASvClm7IyRi+S4X89SfQBvbwwgAt1o
	+zDg3dPxsQ13lw5Ycni6VojTojfzq+aBJCNoPUTIbtyuRePlpgXObSvp9GQJyPmQTBOUzY
	u46vbuGJ8D4k6a9wYoChcMnovQbcx/6qMACY+ojbZYUDlxtGaIId8UeRn5mdjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n0Rnq+i81ympraP8yaPqdbDb9LcK2XQmwtC4wiTcyDg=;
	b=r0YfjHxhIRXg9MPxT8iDxx7JPsRb6GPEcvdmAYNgUSFlwQnd1GgIZcb9E2RdWH1OIDgBng
	9nQt83hoY1DnZiAA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 00/18] net: Cover more per-CPU storage with local nested BH locking.
Date: Sun,  9 Mar 2025 15:46:35 +0100
Message-ID: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was looking at the build-time defined per-CPU variables in net/ and
added the needed local-BH-locks in order to be able to remove the
current per-CPU lock in local_bh_disable() on PREMPT_RT.

The work is not yet complete, I just wanted to post what I have so far
instead of sitting on it.

Sebastian

Sebastian Andrzej Siewior (18):
  net: page_pool: Don't recycle into cache on PREEMPT_RT.
  net: dst_cache: Use nested-BH locking for dst_cache::cache.
  ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT.
  ipv6: sr: Use nested-BH locking for hmac_storage.
  xdp: Use nested-BH locking for system_page_pool.
  netfilter: nf_dup{4, 6}: Move duplication check to task_struct.
  netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx.
  netfilter: nf_dup_netdev: Move the recursion counter struct
    netdev_xmit.
  xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46].
  openvswitch: Merge three per-CPU structures into one.
  openvswitch: Use nested-BH locking for ovs_actions.
  openvswitch: Move ovs_frag_data_storage into the struct ovs_action.
  net/sched: act_mirred: Move the recursion counter struct netdev_xmit.
  net/sched: Use nested-BH locking for sch_frag_data_storage.
  mptcp: Use nested-BH locking for hmac_storage.
  rds: Disable only bottom halves in rds_page_remainder_alloc().
  rds: Acquire per-CPU pointer within BH disabled section.
  rds: Use nested-BH locking for rds_page_remainder.

 include/linux/netdevice.h        |  7 +++-
 include/linux/netdevice_xmit.h   |  6 +++
 include/linux/netfilter.h        | 11 -----
 include/linux/sched.h            |  1 +
 net/core/dev.c                   | 15 ++++---
 net/core/dst_cache.c             | 30 ++++++++++++--
 net/core/page_pool.c             |  4 ++
 net/core/xdp.c                   | 11 ++++-
 net/ipv4/netfilter/ip_tables.c   |  2 +-
 net/ipv4/netfilter/nf_dup_ipv4.c |  6 +--
 net/ipv4/route.c                 |  4 ++
 net/ipv6/netfilter/ip6_tables.c  |  2 +-
 net/ipv6/netfilter/nf_dup_ipv6.c |  6 +--
 net/ipv6/seg6_hmac.c             | 13 +++++-
 net/mptcp/protocol.c             |  4 +-
 net/mptcp/protocol.h             |  9 ++++-
 net/netfilter/core.c             |  3 --
 net/netfilter/nf_dup_netdev.c    | 22 ++++++++--
 net/netfilter/nft_inner.c        | 18 +++++++--
 net/openvswitch/actions.c        | 69 +++++++++++++++-----------------
 net/openvswitch/datapath.c       |  9 +----
 net/openvswitch/datapath.h       |  3 --
 net/rds/page.c                   | 25 +++++++-----
 net/sched/act_mirred.c           | 28 +++++++++++--
 net/sched/sch_frag.c             | 10 ++++-
 net/xfrm/xfrm_nat_keepalive.c    | 30 +++++++++-----
 26 files changed, 231 insertions(+), 117 deletions(-)

--=20
2.47.2


