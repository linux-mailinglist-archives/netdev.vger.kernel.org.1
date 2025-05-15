Return-Path: <netdev+bounces-190867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E675CAB9261
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812715031D6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609D28AB12;
	Thu, 15 May 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FAGif22w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FFC28A1CD
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349403; cv=none; b=rSQw/loDJyDg+8PMN0n6BJUutB+3P8Y/DDUAk8dyD9DcWd2jhOoL9GYTpiBNFHl7wUQYcYfa98m6DA8xLcVnozAOhF++S6o5tk+GCSSPa6iISfU29vNgoaxf2DnYaf2enhdRt2hKUsaXpxIispykXXDopDtlxetMJjmJVupxySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349403; c=relaxed/simple;
	bh=ck7zbgEAS1a+X5Bohs4yHO7e9tAXVHoH7hCd6JeS9Ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sObyegM3pvsLzPJ39NGP4PaAjvGhhOycm5XqtcQcrc1Zx9/GSfqvHKl9lD7LsfOGF2HzlFE2yzjvyddNyh4t5TSdG9LtJmDOzTwQEG5n18Dme+hrzTn/+f4IG76rpCO9/cK31ANlP89zSSnhC2klvtTtIfXBECHmxPnzELIJiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FAGif22w; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747349402; x=1778885402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9zDYJESlAAK7JzSX60kmkF9NAPxSnOZrgMTYL4EPFDI=;
  b=FAGif22wzDE23+UGDfveRkEuheS6s49lXFU14urU6Wntpf0IXkvWN+PZ
   eASO11P7CpOIpgkCkZ6FyZXYZiaKaJN6PFbeOXy33+YRwtf2DEgL3rC1B
   Shc13oZHjtP384WmV0aj2dqS5Q8Sw0QGoYXZmx68tQXe04SL0Ml3ZEQSX
   Y6d7f1OvFMuSbDpRdimhq1W6cnta32Ii0rFsmR6Ctt80X5/NA8CCavrHs
   rXNwMIagXHEC9A9ALFlkPnq0nOOsRuSJ7Qew/ntPAL8ISQq/d01QHVDXp
   34e8f+BWVsVidknKkytyG17v2ycv/LbtTAsfZjDLoBnLai3c1mJppfTBK
   w==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="490492141"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:49:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:2740]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id 5b6786dd-a7fb-43fc-86a4-859c6f09a733; Thu, 15 May 2025 22:49:57 +0000 (UTC)
X-Farcaster-Flow-ID: 5b6786dd-a7fb-43fc-86a4-859c6f09a733
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:49:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:49:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Thu, 15 May 2025 15:49:08 -0700
Message-ID: <20250515224946.6931-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
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
  v4:
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
 .../selftests/net/af_unix/scm_rights.c        |  80 +++++++++++-
 13 files changed, 351 insertions(+), 190 deletions(-)

-- 
2.49.0


