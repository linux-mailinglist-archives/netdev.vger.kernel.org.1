Return-Path: <netdev+bounces-106307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128B915BB9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF03B21BBD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42217BA3;
	Tue, 25 Jun 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mS2oTrxn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DA1CA87
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279425; cv=none; b=aGe7Pif0VeJLFReV0+Pc6rIuBsc9EkQjFhACjv/tCuy49SirE6gyQH8S1SWB1uN1uPHVAxV3e3B9GUv+bZQfxQSfrSbEgY58h1DOW8kVok3kp2d3WI5EPT/HlVkaDavLYujhDb5FXNWmzmT7vPCFPpbNduTy59G5eCf1PJ8DqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279425; c=relaxed/simple;
	bh=e4f/fXFATlO2nUE7ha+QIQ83p9B+cL0KJrmbyBbSIY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYlxjvDBpI/m/p17v9xPHSVCRLeHduFfc8vsOPSsMdxts0AJrHiDZ1H2JVpV0AJ3ZeR9l0gUo9GtSWwtEsKxmB7KGmh/mcNiZg6WY+E8oWFsb+QhJNOqCuSblrqsX8Zxv3zh1jL/om4suTrk83YqCCwq4Qyx2hoSDwwZhJxSyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mS2oTrxn; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279424; x=1750815424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AmU8e5pxfEGBJgfyCf0K+Rhg34HYOOyMWMwPG+BrCMs=;
  b=mS2oTrxnXKtIJYuNJ/YW8y7f4Ioz+iOZ6GHARLpB3Sjk76SEeJULGSiM
   zn/raENsebQrS5AMvpcpRM0PeGiNQX8lJ4xXmqOX5HszGtOauZ05Jy6Ry
   mrMDO85JPraGb8ZJFRCmM2ZZmm+Yph+bjOt8w/tRJdZn1x81lIAEXTJK+
   k=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="7152138"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:37:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:23917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.204:2525] with esmtp (Farcaster)
 id 164f397c-32c7-49a7-ad59-c21211d0e84e; Tue, 25 Jun 2024 01:37:00 +0000 (UTC)
X-Farcaster-Flow-ID: 164f397c-32c7-49a7-ad59-c21211d0e84e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:37:00 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:36:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 00/11] af_unix: Fix bunch of MSG_OOB bugs and add new tests.
Date: Mon, 24 Jun 2024 18:36:34 -0700
Message-ID: <20240625013645.45034-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series rewrites the selftest for AF_UNIX MSG_OOB and fixes
bunch of bugs that AF_UNIX behaves differently compared to TCP.

Note that the test discovered few more bugs in TCP side, which
will be fixed in another series.


Kuniyuki Iwashima (11):
  selftest: af_unix: Remove test_unix_oob.c.
  selftest: af_unix: Add msg_oob.c.
  af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
  af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the
    head.
  selftest: af_unix: Add non-TCP-compliant test cases in msg_oob.c.
  af_unix: Don't stop recv() at consumed ex-OOB skb.
  selftest: af_unix: Add SO_OOBINLINE test cases in msg_oob.c
  selftest: af_unix: Check SIGURG after every send() in msg_oob.c
  selftest: af_unix: Check EPOLLPRI after every send()/recv() in
    msg_oob.c
  af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the
    head.
  selftest: af_unix: Check SIOCATMARK after every send()/recv() in
    msg_oob.c.

 net/unix/af_unix.c                            |  37 +-
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 tools/testing/selftests/net/af_unix/msg_oob.c | 734 ++++++++++++++++++
 .../selftests/net/af_unix/test_unix_oob.c     | 436 -----------
 5 files changed, 766 insertions(+), 444 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/msg_oob.c
 delete mode 100644 tools/testing/selftests/net/af_unix/test_unix_oob.c

-- 
2.30.2


