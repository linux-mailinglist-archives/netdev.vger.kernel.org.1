Return-Path: <netdev+bounces-50332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFFD7F5607
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADFAB20B3B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEE15A2;
	Thu, 23 Nov 2023 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WQQA3Rbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0312A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700704088; x=1732240088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2N3hz4WoOT+k/R2WopwaZzFpMTttdSYnDipeZE0M0dQ=;
  b=WQQA3RbeUD7Kao2kDkAAFBydaRw3m/csGVz5Z5f2wbZMYF239jLu9pfn
   48IDsOWV8+hBRTPBfY9QRSXh5Mg8YNZ6eMj+XIwpaMBVW8bBa1rCfIxCQ
   6Zg+9gyaVK4gyZ9aMG2kxyorsabCz185ssGfH+ppIN4seOKJ/yo6w0tJ1
   A=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="372049747"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:48:05 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 5858F8038C;
	Thu, 23 Nov 2023 01:48:03 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:56743]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id b70eab57-50c0-4828-8ff9-1379ac8f75bd; Thu, 23 Nov 2023 01:48:02 +0000 (UTC)
X-Farcaster-Flow-ID: b70eab57-50c0-4828-8ff9-1379ac8f75bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:48:01 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:47:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/4] af_unix: Random improvements for GC.
Date: Wed, 22 Nov 2023 17:47:43 -0800
Message-ID: <20231123014747.66063-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist on a host, each
sendmsg() will be forced to wait for unix_gc() even if a process
is not sending any FD.

This series tries not to impose such a penalty on sane users.


Changes:
  v2:
    Patch 4: Fix build error when CONFIG_UNIX=n (kernel test robot)

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
 net/unix/garbage.c       | 84 ++++++++++++++++++----------------------
 net/unix/scm.c           | 34 ++++++++--------
 8 files changed, 74 insertions(+), 75 deletions(-)

-- 
2.30.2


