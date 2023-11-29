Return-Path: <netdev+bounces-51966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEB7FCCDE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CD3B20D2D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0023D8E;
	Wed, 29 Nov 2023 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FCIv1xHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131261727
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701224984; x=1732760984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WM/qAoG12zRF4TkiOj9UBu0qOzr1phc9qTsQ1hD6ZO8=;
  b=FCIv1xHqEwprwg+8Ci7N3g/VSc4YUtNtvr4JX46SbjK5YoFSyN0AhPYC
   MmKe0L5SfmpXxxrX81TWc85YoJ1Id8rFNERIWJUra3F/CJUbDwhJejJdK
   Bc9MQJMLxI+zCMJITTJyRuU/9jlmJ9+jaihsBhtQMTiLIEmESI+/YbdGB
   0=;
X-IronPort-AV: E=Sophos;i="6.04,234,1695686400"; 
   d="scan'208";a="168901349"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:29:41 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 905C2804AD;
	Wed, 29 Nov 2023 02:29:39 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:31692]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.176:2525] with esmtp (Farcaster)
 id d41be20b-1d23-4249-ab87-e905c44323be; Wed, 29 Nov 2023 02:29:39 +0000 (UTC)
X-Farcaster-Flow-ID: d41be20b-1d23-4249-ab87-e905c44323be
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 29 Nov 2023 02:29:38 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:29:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
Date: Tue, 28 Nov 2023 18:29:16 -0800
Message-ID: <20231129022924.96156-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
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


Changes:
  v3:
    Patch 8: Fix ecn_ok init (Eric Dumazet)

  v2: https://lore.kernel.org/netdev/20231125011638.72056-1-kuniyu@amazon.com/
    Patch 7: Remove duplicated treq->syn_tos init (Simon Horman)

  v1: https://lore.kernel.org/netdev/20231123012521.62841-1-kuniyu@amazon.com/


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
 net/ipv4/syncookies.c            | 215 ++++++++++++++++---------------
 net/ipv4/tcp_ao.c                |  16 ++-
 net/ipv6/syncookies.c            | 108 +++++++---------
 net/netfilter/nf_synproxy_core.c |   4 +-
 8 files changed, 198 insertions(+), 196 deletions(-)

-- 
2.30.2


