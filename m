Return-Path: <netdev+bounces-56754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB39810C43
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9328175F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A41D68F;
	Wed, 13 Dec 2023 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vqyYBO2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FA8E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455667; x=1733991667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z+bdvlN5X4PbezfjoUMWJEWoW3rVWUjBwmtiLXMAEf0=;
  b=vqyYBO2FFzVe4opapacKJh7wMprakbutm3L082JDIvJbpd43fLQQR46T
   G6Jyve/9llhCPWRpgG5CKk8DfeNNHJoZLcv9rKjSiaxyv02z4czhDwrSx
   itlLIKH59FttDs4T3pzgL0Qx7PhNzkZXhl26hotw/ZHKe6wt7776i2AVw
   E=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="382594616"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:21:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id C5F4C40D67;
	Wed, 13 Dec 2023 08:20:59 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6877]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id c2f4996c-2a63-40ee-8cfd-8e0c3e815d67; Wed, 13 Dec 2023 08:20:59 +0000 (UTC)
X-Farcaster-Flow-ID: c2f4996c-2a63-40ee-8cfd-8e0c3e815d67
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:20:46 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:20:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/12] tcp: Refactor bhash2 and remove sk_bind2_node.
Date: Wed, 13 Dec 2023 17:20:17 +0900
Message-ID: <20231213082029.35149-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This series refactors code around bhash2 and remove some bhash2-specific
fields; sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.

  patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
  patch 2 -  4 : optimise bind() conflict tests
  patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
                 remove sk_bind2_node

The patch 8 will trigger a false-positive error by checkpatch.

After this series, bhash is a wrapper of bhash2:

  tb
  `-> tb2 -> tb2 -> ...
      `-> sk -> sk -> sk ....


Changes:
  v2:
    * Rebase on latest net-next
    * Patch 11
      * Add change in inet_diag_dump_icsk() for recent bhash dump patch

  v1: https://lore.kernel.org/netdev/20231023190255.39190-1-kuniyu@amazon.com/


Kuniyuki Iwashima (12):
  tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.
  tcp: Rearrange tests in
    inet_bind2_bucket_(addr_match|match_addr_any)().
  tcp: Save v4 address as v4-mapped-v6 in
    inet_bind2_bucket.v6_rcv_saddr.
  tcp: Save address type in inet_bind2_bucket.
  tcp: Rename tb in inet_bind2_bucket_(init|create)().
  tcp: Link bhash2 to bhash.
  tcp: Rearrange tests in inet_csk_bind_conflict().
  tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
  tcp: Check hlist_empty(&tb->bhash2) instead of
    hlist_empty(&tb->owners).
  tcp: Unlink sk from bhash.
  tcp: Link sk and twsk to tb2->owners using skc_bind_node.
  tcp: Remove dead code and fields for bhash2.

 include/net/inet_hashtables.h    | 21 +++----
 include/net/inet_timewait_sock.h |  4 --
 include/net/ipv6.h               |  5 --
 include/net/sock.h               | 14 -----
 net/ipv4/inet_connection_sock.c  | 73 +++++++++++-------------
 net/ipv4/inet_diag.c             |  2 +-
 net/ipv4/inet_hashtables.c       | 98 +++++++++++++++-----------------
 net/ipv4/inet_timewait_sock.c    | 21 +------
 8 files changed, 92 insertions(+), 146 deletions(-)

-- 
2.30.2


