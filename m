Return-Path: <netdev+bounces-49860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B404B7F3B58
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60288282800
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F61842;
	Wed, 22 Nov 2023 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R4v1oUrM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B0DD
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700617017; x=1732153017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sgSsfoUTnDXh0m+JQ/G5AxTPzA3Bfkgih7e7O1EBOno=;
  b=R4v1oUrMswl74uUcCQk/yFznarWZaO7dr4QUYoPvY7Tq1iWxgKPaHHt9
   rwDU0l30XBXS8TmeW7B0SOsqxU5fs1kjMIKYZ5Wo9hqMGEt6UNzChQHy6
   6xRs3MKvkyFH+XfD1Zx+mZ+z52dPG1haoLP4YvbzmZto8S+jUrdPOgRsN
   A=;
X-IronPort-AV: E=Sophos;i="6.04,217,1695686400"; 
   d="scan'208";a="313963833"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:36:50 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 68B3F806FD;
	Wed, 22 Nov 2023 01:36:48 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:5740]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with esmtp (Farcaster)
 id 1c0a34c8-d8c1-4ded-b1d0-eff5452648c6; Wed, 22 Nov 2023 01:36:48 +0000 (UTC)
X-Farcaster-Flow-ID: 1c0a34c8-d8c1-4ded-b1d0-eff5452648c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 01:36:44 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Wed, 22 Nov 2023 01:36:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/4] af_unix: Random improvements for GC.
Date: Tue, 21 Nov 2023 17:36:25 -0800
Message-ID: <20231122013629.28554-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist on a host, each
sendmsg() will be forced to wait for unix_gc() even if a process
is not sending any FD.

This series tries not to impose such a penalty on sane users.


Kuniyuki Iwashima (4):
  af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
  af_unix: Return struct unix_sock from unix_get_socket().
  af_unix: Run GC on only one CPU.
  af_unix: Try to run GC async.

 include/linux/io_uring.h |  4 +-
 include/net/af_unix.h    |  6 +--
 include/net/scm.h        |  1 +
 io_uring/io_uring.c      |  5 ++-
 net/core/scm.c           |  3 ++
 net/unix/af_unix.c       | 10 +++--
 net/unix/garbage.c       | 84 ++++++++++++++++++----------------------
 net/unix/scm.c           | 34 ++++++++--------
 8 files changed, 72 insertions(+), 75 deletions(-)

-- 
2.30.2


