Return-Path: <netdev+bounces-50319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793677F55D6
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771E0B20CEF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556515A2;
	Thu, 23 Nov 2023 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cNvTVpYG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6292
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700702736; x=1732238736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dfMcvxuVCVdCau3+eoEshY5KxyD34il+jgzMON32OFQ=;
  b=cNvTVpYGhe1Nw32L80qIjDaETsnDh9lfciq7IOw/dyuJiGiINx8bFlqn
   eaeMIXZ8ng6nYhtm9S0GucaIXrAFcFHg+0SfwmDE6UHUd3nYfx3r9U5i1
   VoZ2h1+Nlw7Ip3KO6ycEXqArN6gri/Y0EhzF03MJ0iG5NVhfxEKLU2Ckw
   0=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="617735990"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:25:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 7627F807E6;
	Thu, 23 Nov 2023 01:25:34 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:46272]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 032cc0d4-1195-452d-bea7-1d4f2b565aa7; Thu, 23 Nov 2023 01:25:33 +0000 (UTC)
X-Farcaster-Flow-ID: 032cc0d4-1195-452d-bea7-1d4f2b565aa7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:25:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:25:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
Date: Wed, 22 Nov 2023 17:25:13 -0800
Message-ID: <20231123012521.62841-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This is a preparation series for upcoming arbitrary SYN Cookie
support with BPF. [0]

There are slight differences between cookie_v[46]_check().  Such a
discrepancy caused an issue in the past, and BPF SYN Cookie support
will add more churn.

The primary purpose of this series is to clean up and refactor
cookie_v[46]_check() to minimise such discrepancies and make the
BPF series easier to review.

[0]: https://lore.kernel.org/netdev/20231121184245.69569-1-kuniyu@amazon.com/


Kuniyuki Iwashima (8):
  tcp: Clean up reverse xmas tree in cookie_v[46]_check().
  tcp: Cache sock_net(sk) in cookie_v[46]_check().
  tcp: Clean up goto labels in cookie_v[46]_check().
  tcp: Don't pass cookie to __cookie_v[46]_check().
  tcp: Don't initialise tp->tsoffset in tcp_get_cookie_sock().
  tcp: Move TCP-AO bits from cookie_v[46]_check() to tcp_ao_syncookie().
  tcp: Factorise cookie-independent fields initialisation in
    cookie_v[46]_check().
  tcp: Factorise cookie-dependent fields initialisation in
    cookie_v[46]_check()

 include/linux/netfilter_ipv6.h   |   8 +-
 include/net/tcp.h                |  22 ++--
 include/net/tcp_ao.h             |   6 +-
 net/core/filter.c                |  15 +--
 net/ipv4/syncookies.c            | 216 ++++++++++++++++---------------
 net/ipv4/tcp_ao.c                |  16 ++-
 net/ipv6/syncookies.c            | 108 +++++++---------
 net/netfilter/nf_synproxy_core.c |   4 +-
 8 files changed, 199 insertions(+), 196 deletions(-)

-- 
2.30.2


