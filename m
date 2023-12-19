Return-Path: <netdev+bounces-58755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D10817FFC
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 04:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5B285B36
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FC17F7;
	Tue, 19 Dec 2023 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HEJG1ax6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A14409
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702954896; x=1734490896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=14W//wmOfpa9X1272SHPM41oBmIzDtWGq68CY54eORU=;
  b=HEJG1ax6xJFlq2QJSE9WAXw+wlYxcKgXS3Pk2kbOIL4FCAslPGGs9HJj
   BK9HrfgFy/s43kl+8x2DBQe9LGr8qzdiXjLUJ71UuZPMXn1Bjhf+UM8jz
   H7gAoH19UbKc+nLFnGoADJbcWSz4jOcaTDPMZS4318+YpPaSa3qBj8i6B
   M=;
X-IronPort-AV: E=Sophos;i="6.04,287,1695686400"; 
   d="scan'208";a="377262548"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:01:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 58D46A63C0;
	Tue, 19 Dec 2023 03:01:31 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:53851]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id 92eda60e-68d9-42c6-be80-ceacdc595633; Tue, 19 Dec 2023 03:01:30 +0000 (UTC)
X-Farcaster-Flow-ID: 92eda60e-68d9-42c6-be80-ceacdc595633
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 03:01:30 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 03:01:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 0/4] af_unix: Random improvements for GC.
Date: Tue, 19 Dec 2023 12:00:58 +0900
Message-ID: <20231219030102.27509-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist on a host, each
sendmsg() will be forced to wait for unix_gc() even if a process
is not sending any FD.

This series tries not to impose such a penalty on sane users who
do not send AF_UNIX FDs or do not have inflight sockets more than
SCM_MAX_FD * 8.

Cleanup patches for commit 69db702c8387 ("io_uring/af_unix: disable
sending io_uring over sockets") will be posted later as noted in [0].

[0]: https://lore.kernel.org/netdev/c716c88321939156909cfa1bd8b0faaf1c804103.1701868795.git.asml.silence@gmail.com/


Changes:
  v4:
    * Rebase on the latest

  v3: https://lore.kernel.org/netdev/20231218075020.60826-1-kuniyu@amazon.com/
    * Patch 3
      * Reuse gc_in_progress flag.
      * Call flush_work() only when gc is queued or in progress.
    * Patch 4
      * Bump UNIX_INFLIGHT_SANE_USER to (SCM_MAX_FD * 8).

  v2: https://lore.kernel.org/netdev/20231123014747.66063-1-kuniyu@amazon.com/
    * Patch 4
      * Fix build error when CONFIG_UNIX=n

  v1: https://lore.kernel.org/netdev/20231122013629.28554-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
  af_unix: Return struct unix_sock from unix_get_socket().
  af_unix: Run GC on only one CPU.
  af_unix: Try to run GC async.

 include/linux/io_uring.h |  4 +-
 include/net/af_unix.h    |  6 +--
 include/net/scm.h        |  1 +
 io_uring/io_uring.c      |  5 ++-
 net/core/scm.c           |  5 +++
 net/unix/af_unix.c       | 10 +++--
 net/unix/garbage.c       | 83 +++++++++++++++++++++-------------------
 net/unix/scm.c           | 34 ++++++++--------
 8 files changed, 79 insertions(+), 69 deletions(-)

-- 
2.30.2


