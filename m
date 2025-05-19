Return-Path: <netdev+bounces-191644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A8ABC8C5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A737A4DDF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934420F09B;
	Mon, 19 May 2025 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dlXds4fZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC11A3142
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688322; cv=none; b=ZzeASs7KCWewDy5vlTwXtmlNGUZFq4kuKQcmYvRGiPts2RUWQoGPNvspOcZy+uJgH9Y6JzeTcY7AzK2WVsQVk53igMVwA42UePZjIeQ1KNuCnHaDO1kCupMusTAbnAkCXH3H+zzH9s1UiF5Ppvb0OC/E3nB+zpC5iDAa2TTCp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688322; c=relaxed/simple;
	bh=DGVVNLUPiV6sfCkOjR1kFN4cvMpzJzSd2+Cn81PX+DU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UxOGC9ZNQIzSDTbyKBx+XQ2Y7pva2Tvp9/TkgmkdDZ0fuXYrbJPjcyBMwteuirDptvcP3m6Shi3KlqWAqIU+nVLpgoQpsvnj9QtAx88MSODM1y9WAdPAkeV8J1RIA8epItpHhPzZNT6qO1kzc/YsG12162gT8eaGetlggxA6mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dlXds4fZ; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688321; x=1779224321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LX+A+TF2YaUaML0OBh3WkqCAUk5Kf1+3fS2xP+7bdHo=;
  b=dlXds4fZcj1exX2VDLVSKaDOxfHBQzMneXrPNLd3kxNLRbxPXxADFiSL
   fFtluV0DdR+3NlkzKiFg4PE3as+2TU4eNoPXOZrOlFhdvLkMd4sfhrM3e
   yB3pwiRVVKnOSwbvE0YH+Q24lz22SHO7ck/gV6klwPFjfQRePeG4qLI+k
   kJ6QJsFxJi7jLGXqj5kMegTa+y2O5G2Y+dpVkhHO+QfNShQj+kxJ32KWR
   F54Py66h3Dz9G9qytRm0Xc2h+wt5lbZQKCccaiJLAApp+Vy/nMgqjAKKU
   NeVsbBfWyKeNTkIYESv+PxJm60XM8SkyKe9Ra9bz7oVth9fLPfL0QCBeH
   w==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="491753854"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 20:58:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:38469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id 2ecddace-722c-4cd4-9ff7-db78378df367; Mon, 19 May 2025 20:58:37 +0000 (UTC)
X-Farcaster-Flow-ID: 2ecddace-722c-4cd4-9ff7-db78378df367
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 20:58:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 20:58:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Mon, 19 May 2025 13:57:51 -0700
Message-ID: <20250519205820.66184-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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
  v5:
    * Patch 4
      * Fix BPF selftest failure (setget_sockopt.c)

  v4: https://lore.kernel.org/netdev/20250515224946.6931-1-kuniyu@amazon.com/
    * Patch 6
      * Group sk->sk_scm_XXX bits by struct
    * Patch 9
      * Remove errno handling

  v3: https://lore.kernel.org/netdev/20250514165226.40410-1-kuniyu@amazon.com/
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
 include/net/sock.h                            |  32 ++++-
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/scm.c                                | 122 ++++++++++++++++++
 net/core/sock.c                               |  63 +++++++--
 net/unix/af_unix.c                            |  96 +++++++-------
 tools/include/uapi/asm-generic/socket.h       |   2 +
 .../selftests/bpf/progs/setget_sockopt.c      |  11 ++
 .../selftests/net/af_unix/scm_rights.c        |  80 +++++++++++-
 14 files changed, 362 insertions(+), 190 deletions(-)

-- 
2.49.0


