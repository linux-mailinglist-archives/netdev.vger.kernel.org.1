Return-Path: <netdev+bounces-190501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D2AB71ED
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F11E3AFD01
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08632797A0;
	Wed, 14 May 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ds/4Hzc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E01F1931
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241562; cv=none; b=dGBQoNp4Lwf5CuAQHJY2cPu6SkqexLTSQMHDUmizbSKiOb7TQpVjz+1YphWbOR4jyPdpobquCndss6u+VgCHvXMKLB8hkXa306Y7JJU2buRonfYaIJoIGoYpT3TMaNQKXbh7zYGbkkl4Bf++ZqzXXdN8qIYDwn2DjkPl+yldxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241562; c=relaxed/simple;
	bh=5nouLCzYUgsjar+wShkk5YB8FY2Cgcp2u3ojgwbzPz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QPWrfpCyKv4i+oCTwBJnqj20MuZeS5RnxCMBt9GnS4ylI0NBYFqJGMZKDzWBl/kvD0PTcjZKX5d4PB6OCsIOsEk1gSTiTE9APetQlTUhzY//dMIKsPzSmcg54jfT/Eodj0at3T+1qCxHWbk5pmaCH/M2FJJaLdk/WDWfCB+Jud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ds/4Hzc/; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241561; x=1778777561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kJWvWAas/G3NnMhnf52T5G2ndMv+4nnZfGlYwwB3udE=;
  b=ds/4Hzc/PgAMsmqm5K6C95ADKvBcATGtYJHWuggx+XlQfa2Bkl7RJhb4
   kDxuoqo1Sh3STHafo05ZHGdWzT3qA7Go9ZW6MqWtTSzHQ/pgwvPg0FJGT
   K7kuQnc0SDV8WYYaVfbusaSEnSGvZnYDEcCwMYFR0Gv9lzBDckwaZ6rFw
   08mzPwVNbodhBoYJ4a74kpi2MKgFcSgGUEtxPgnfCQxPg+/ThRjIJSfk7
   KapW/n2ZVnK8nZFqsZJwj6Dh0kD5qdo5EcOIpz395iXegwIZDPLkg5pQ+
   bWstQTOTVRkCmtdjC7iXKF2FYaEPDg1XDgZJ+B3xzN82gMlicbm1QQI5G
   g==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="200545620"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:52:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:4175]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id ad2fceb1-1c2a-438d-b9f4-2a5cbbb12273; Wed, 14 May 2025 16:52:38 +0000 (UTC)
X-Farcaster-Flow-ID: ad2fceb1-1c2a-438d-b9f4-2a5cbbb12273
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:52:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:52:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Wed, 14 May 2025 09:51:43 -0700
Message-ID: <20250514165226.40410-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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
  v3:
    * Patch 3
      * Remove inline in scm.c
    * Patch 4 & 5 & 8
      * Return -EOPNOTSUPP in getsockopt()
    * Patch 5
      * Add CONFIG_SECURITY_NETWORK check for SO_PASSSEC
    * Patch 6
      * Add kdoc for sk_scm_unused
      * Update sk_scm_XXX under lock_sock() in setsockopt()
    * Patch 7
      * Update changelog (recent change -> aed6ecef55d7)

  v2: https://lore.kernel.org/netdev/20250510015652.9931-1-kuniyu@amazon.com/
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
 include/net/scm.h                             | 121 +----------------
 include/net/sock.h                            |  30 ++++-
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/scm.c                                | 122 ++++++++++++++++++
 net/core/sock.c                               |  63 +++++++--
 net/unix/af_unix.c                            |  96 +++++++-------
 tools/include/uapi/asm-generic/socket.h       |   2 +
 .../selftests/net/af_unix/scm_rights.c        |  84 +++++++++++-
 13 files changed, 352 insertions(+), 191 deletions(-)

-- 
2.49.0


