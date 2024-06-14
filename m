Return-Path: <netdev+bounces-103714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF89590932B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF521C22B2C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39A1A0AE3;
	Fri, 14 Jun 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HeaQ+UeX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE521A01B6
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395663; cv=none; b=mIAFoeeWwpvVzCrfs1n9VIkaC7x112HHrO2q+DHfRhKrzRgWlAANpSVo5zIT76tyHPLPKzRmg3OaC65TgZny4egaTVaMVTV6R/bMH9NQ0gSvxZl6ZPNNPA+nYYWwJORgCucZWLDOKIOajetCVwj3vDNiAVDqxDnfHv2inXgzV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395663; c=relaxed/simple;
	bh=3PUVIDwoGmOr7GvcR+R7jSA8BW9EJocEZjoWwuqIJRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfqj7x5fzOj+1hfkNoNLlRn6YWK8nx2SatliJtvyT7xsQCx4fF0miVGZOiRhhuxIi6/VOwhD06TCuZcRLQPrbBAFToSdKvtK8N//tyBvfnoejTk43RVRxygaqHm2VmKendob0ofEX/UEQe2lCHpOT1XoGOpKQ0mG6lSw//APr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HeaQ+UeX; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395662; x=1749931662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/+0tbHgbs2F5SiKCA/Dkp7375YEX9pnfAypOLwWKlgM=;
  b=HeaQ+UeXMQtGyX1wFcq/mHAZ1+Jl3YjHpMrkyNXuAfnFAzswRHZhDPXz
   dmmKcaqSX8bU9zVrEaD174xVoUIY+kR51RKxmMlORUxkVfHHMaaFcn7jS
   DNX4EQ4M9PW8LDP7Ro983CmToaLhknS1IR2Vtgwk1b30xE7Hh4E8EokGn
   0=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="211895407"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:07:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:33513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.123:2525] with esmtp (Farcaster)
 id a14bf69d-0cb1-427c-9db1-52e739db5f50; Fri, 14 Jun 2024 20:07:38 +0000 (UTC)
X-Farcaster-Flow-ID: a14bf69d-0cb1-427c-9db1-52e739db5f50
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:07:32 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:07:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 00/11] af_unix: Remove spin_lock_nested() and convert to lock_cmp_fn.
Date: Fri, 14 Jun 2024 13:07:04 -0700
Message-ID: <20240614200715.93150-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series removes spin_lock_nested() in AF_UNIX and instead
defines the locking orders as functions tied to each lock by
lockdep_set_lock_cmp_fn().

When the defined function returns a negative value, lockdep
considers it will not cause deadlock.  (See ->cmp_fn() in
check_deadlock() and check_prev_add().)

When we cannot define the total ordering, we return -1 for
the allowed ordering and otherwise 0 as undefined. [0]

[0]: https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo/


Changes:
  v3:
    * Patch 3
      * Cache sk->sk_state
      * s/unix_state_lock()/unix_state_unlock()/
    * Patch 8
      * Add embryo -> listener locking order

  v2: https://lore.kernel.org/netdev/20240611222905.34695-1-kuniyu@amazon.com/
   * Patch 1 & 2
      * Use (((l) > (r)) - ((l) < (r))) for comparison

  v1: https://lore.kernel.org/netdev/20240610223501.73191-1-kuniyu@amazon.com/


Kuniyuki Iwashima (11):
  af_unix: Define locking order for unix_table_double_lock().
  af_unix: Define locking order for U_LOCK_SECOND in
    unix_state_double_lock().
  af_unix: Don't retry after unix_state_lock_nested() in
    unix_stream_connect().
  af_unix: Define locking order for U_LOCK_SECOND in
    unix_stream_connect().
  af_unix: Don't acquire unix_state_lock() for sock_i_ino().
  af_unix: Remove U_LOCK_DIAG.
  af_unix: Remove U_LOCK_GC_LISTENER.
  af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in
    unix_collect_skb().
  af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
  af_unix: Remove put_pid()/put_cred() in copy_peercred().
  af_unix: Don't use spin_lock_nested() in copy_peercred().

 include/net/af_unix.h |  14 -----
 net/unix/af_unix.c    | 139 +++++++++++++++++++++++++++---------------
 net/unix/diag.c       |  47 ++++----------
 net/unix/garbage.c    |   8 +--
 4 files changed, 105 insertions(+), 103 deletions(-)

-- 
2.30.2


