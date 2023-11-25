Return-Path: <netdev+bounces-50992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE27F876E
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6506B21399
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012A642;
	Sat, 25 Nov 2023 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iLlcO9Ro"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651D19A3
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700875019; x=1732411019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RX/n6F/KAUoOV2FRP7i4W/NJ/9A4hYx59HOJgROcRXI=;
  b=iLlcO9RoYuSbuxrR8Bapo8SaTsQpc2HlhmNxMCOOYHBsJhSql0czt2C3
   IkunuSdD8upCL/g6i6ERD2NZmhmcbbyz6KidobB2U1cjt0wm0M7uLzdaO
   KDrOScfFsvYfQBSZ44PLoRl0HiC30c+Tu49okEVH9cmTtoXvF+A92SFoH
   c=;
X-IronPort-AV: E=Sophos;i="6.04,224,1695686400"; 
   d="scan'208";a="364820839"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:16:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id D114F68DBB;
	Sat, 25 Nov 2023 01:16:54 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:40013]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id a93e4d59-d91b-49c1-9a05-9816e3162fae; Sat, 25 Nov 2023 01:16:54 +0000 (UTC)
X-Farcaster-Flow-ID: a93e4d59-d91b-49c1-9a05-9816e3162fae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:16:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sat, 25 Nov 2023 01:16:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
Date: Fri, 24 Nov 2023 17:16:30 -0800
Message-ID: <20231125011638.72056-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
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
  v2:
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


