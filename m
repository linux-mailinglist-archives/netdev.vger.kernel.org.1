Return-Path: <netdev+bounces-188834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2DAAF0A0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734953AAACD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB67263D;
	Thu,  8 May 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fQycSQnE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08118C0E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667841; cv=none; b=jzoB+PXDiqM9ao990R9cA7SIhSOOaT41Fnbb1ZJa/ixIi6/TizVcA3s+pdmyl4eR2AKczpwZf5eCkViU9IDZejb/d7scYIQ18UVLkzDUP/tnvImFZLhhICqJjwT5yd8ByCMf5uQLxL833oqIUxiy/hST+01xg5cLMr0WrWjqCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667841; c=relaxed/simple;
	bh=aL/oWWIXdiiT2r5NMfVRjwRYDm/zHFX5uM4HvgYfclE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMzRMCOdsebOgDLEU6OiYvsMs5w4/SF9XX4C9+Xgin15nquqW1RPt+bqdfz43HxAxgMfjxZqw1s5i3joTDIBBVt0FfcM1rny8jEkuK151nWG3Lb2+xq7b441ki1MtMl4Io+K+sx6weAeX8gP9tWBIjAk3kxWqpLaoHOp5dB/iQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fQycSQnE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667836; x=1778203836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7DZ596On9HbcDEPu9h4oyw6aPYRtzOIJ+cfskr8zDSg=;
  b=fQycSQnEY3xGxDvM4If6Fu397dYrkEdxpJrWHbceY24TCKPeJ3PVapNB
   vAgsAoHzM49kWz52GT0yOXB/1akhbvbRMFdvHHEZ8SmgpIjI6MZgene2i
   OlVWnqCkAK+bNK+LTE2tcrvZ5ZXLRPiR8KgMy/sL3PYX0m/oxNBkgJ0V1
   p0i9BrcZmWn2QshUBSofug65yish15vGNuYj/v0hoLuGAH6V++6wIdWYv
   CcB9hWRNvQxEqakfvh/jqhGX9MSR59xC2ckvKb9XKoH5m5Ze/W/uJrzHZ
   AxJc46IYHc4QFlU6sma17R3D2DvjomDz0toyGVdkrHBDsTGOX4MK6u0KQ
   A==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="194692824"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:30:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:62037]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 964daac6-7f21-4422-907b-f7847ba7f1c1; Thu, 8 May 2025 01:30:34 +0000 (UTC)
X-Farcaster-Flow-ID: 964daac6-7f21-4422-907b-f7847ba7f1c1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:30:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:30:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/7] af_unix: Introduce SO_PASSRIGHTS
Date: Wed, 7 May 2025 18:29:12 -0700
Message-ID: <20250508013021.79654-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As long as recvmsg() or recvmmsg() is used with cmsg, it is not
possible to avoid receiving file descriptors via SCM_RIGHTS.

This series introduces a new socket option, SO_PASSRIGHTS, to allow
disabling SCM_RIGHTS.  The option is enabled by default.

See patch 6 for background/context.

This series is related to [0], but is split into a separate series,
as most of the patches are specific to AF_UNIX.

The v2 of the BPF LSM extension part will be posted later, once
this series is merged into net-next and has landed in bpf-next.

[0]: https://lore.kernel.org/bpf/20250505215802.48449-1-kuniyu@amazon.com/


Kuniyuki Iwashima (7):
  af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
  af_unix: Don't pass struct socket to maybe_add_creds().
  scm: Move scm_recv() from scm.h to scm.c.
  af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to sk->sk_flags.
  af_unix: Inherit sk_flags at connect().
  af_unix: Introduce SO_PASSRIGHTS.
  selftest: af_unix: Test SO_PASSRIGHTS.

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/linux/net.h                           |  15 +--
 include/net/scm.h                             | 121 +----------------
 include/net/sock.h                            |   6 +
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/scm.c                                | 124 ++++++++++++++++++
 net/core/sock.c                               |  25 +++-
 net/unix/af_unix.c                            |  88 ++++++-------
 tools/include/uapi/asm-generic/socket.h       |   2 +
 .../selftests/net/af_unix/scm_rights.c        |  84 +++++++++++-
 13 files changed, 296 insertions(+), 179 deletions(-)

-- 
2.49.0


