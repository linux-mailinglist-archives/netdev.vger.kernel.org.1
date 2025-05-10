Return-Path: <netdev+bounces-189428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF0AB20E4
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA297B2B72
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7642673B0;
	Sat, 10 May 2025 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MwJ4kPzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A91754B
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842229; cv=none; b=swbUrMa6qV2imGY5P1AdMqWnV6HutOdurIPTHQTh86p2Tg0LhYIdVV6AOLlGPVp1MDQfUOmHuO7GWwTK2VlMxC1urW70nzaJD5RkKkABnUmnrDde8wVTqbBXOYSWtqDw+o0M4WYaSJfDWciJOG48qmTo2iuDz4YXe51W0vs0MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842229; c=relaxed/simple;
	bh=OsZgbx1oWF1HMK3WeaaDafeplVXWcQRdRLuet96Q4YQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Stxbmab5REmdp+LJYTTZHJ1OgumiukkggjshbtxZmg6ZYcUIrA7ySZ0LdmlkvfnwEaeBBWBclsnONEw0wdELrSMh73y30nRa1Vpu4T4Mi6ujyqHWKMCvcBgzVJwTTzK3Uu3kY1K68I5NXZSBpMAca3CQCntt0M8iI7ZircZOiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MwJ4kPzw; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842229; x=1778378229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ppoamjTlJwkoPSdZhTGPYViuc/laK54t8/pyyWmGnBY=;
  b=MwJ4kPzwln7eCtsuCXEBkEBYRhMTmNWZLQlI6MW+5iAMOSPR/u1Isghn
   UFPqwRFq5bVk8UxY3/aKptk27RGwrSYKIQhbRQJvnxobD9qQQH4KxJ03R
   an0It0H24FJtrfi4kZ/b+mBfk/AqiomtzvsorSSvSbBqdPTBXoLOFMxhV
   MCz/Za3atuPEqF3wYAL6R8EXIEp5DpC/Rz6Fq567IXq3luY3Ck/WcOrER
   AKv/HEVibr7wGjY/0bHjctcyrYRKhukevIewzHJ5iHwuFA2iTrnjfCx+n
   qZteACawJfsGsqR1s392WNNTmXwaSKiFsBpUEVYloZWf+8smfnIQCDuaU
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="48521519"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:57:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:44557]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.114:2525] with esmtp (Farcaster)
 id 098e440e-b226-49c6-abe7-f693efded85f; Sat, 10 May 2025 01:57:06 +0000 (UTC)
X-Farcaster-Flow-ID: 098e440e-b226-49c6-abe7-f693efded85f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS
Date: Fri, 9 May 2025 18:56:23 -0700
Message-ID: <20250510015652.9931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As long as recvmsg() or recvmmsg() is used with cmsg, it is not
possible to avoid receiving file descriptors via SCM_RIGHTS.

This series introduces a new socket option, SO_PASSRIGHTS, to allow
disabling SCM_RIGHTS.  The option is enabled by default.

See patch 8 for background/context.

This series is related to [0], but is split into a separate series,
as most of the patches are specific to af_unix.

The v2 of the BPF LSM extension part will be posted later, once
this series is merged into net-next and has landed in bpf-next.

[0]: https://lore.kernel.org/bpf/20250505215802.48449-1-kuniyu@amazon.com/


Changes:
  v2:
    * Added patch 4 & 5 to reuse sk_txrehash for scm_recv() flags

  v1: https://lore.kernel.org/netdev/20250508013021.79654-1-kuniyu@amazon.com/


Kuniyuki Iwashima (9):
  af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
  af_unix: Don't pass struct socket to maybe_add_creds().
  scm: Move scm_recv() from scm.h to scm.c.
  tcp: Restrict SO_TXREHASH to TCP socket.
  net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
  af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
  af_unix: Inherit sk_flags at connect().
  af_unix: Introduce SO_PASSRIGHTS.
  selftest: af_unix: Test SO_PASSRIGHTS.

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/linux/net.h                           |  15 +--
 include/net/scm.h                             | 121 +-----------------
 include/net/sock.h                            |  29 ++++-
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/scm.c                                | 121 ++++++++++++++++++
 net/core/sock.c                               |  52 ++++++--
 net/unix/af_unix.c                            |  96 +++++++-------
 tools/include/uapi/asm-generic/socket.h       |   2 +
 .../selftests/net/af_unix/scm_rights.c        |  84 +++++++++++-
 13 files changed, 343 insertions(+), 187 deletions(-)

-- 
2.49.0


