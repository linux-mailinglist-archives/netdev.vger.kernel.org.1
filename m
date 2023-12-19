Return-Path: <netdev+bounces-58720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9A817EAB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2284028468C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70E7F;
	Tue, 19 Dec 2023 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PkoBxWhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21452387
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945134; x=1734481134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EQY012uor7Mn7XjgkQb0n1HTepjWQOamYe6ikz+1XKk=;
  b=PkoBxWhei5NBfqpcmwkuESzT+zniQXBJmt5v9xw0z93qppxWKoMGVixI
   KtpkXLWsS8Ux9xUjKdmKe/h9IFG+Wi3NKyljrwOjrakVN7GFXj0xNswtd
   7SGFR/L00xHLOZzfgIe+9Mmrk9V0Lk63b6SK1tjWjQMKpYukq6XScDmQ7
   8=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="260969944"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:18:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 987B640D6E;
	Tue, 19 Dec 2023 00:18:50 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:40663]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id dfaf3608-ac23-4c27-91b5-65864f9e31a1; Tue, 19 Dec 2023 00:18:50 +0000 (UTC)
X-Farcaster-Flow-ID: dfaf3608-ac23-4c27-91b5-65864f9e31a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:18:46 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 00:18:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 00/12] tcp: Refactor bhash2 and remove sk_bind2_node.
Date: Tue, 19 Dec 2023 09:18:21 +0900
Message-ID: <20231219001833.10122-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This series refactors code around bhash2 and remove some bhash2-specific
fields; sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.

  patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
  patch 2 -  4 : optimise bind() conflict tests
  patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
                 remove sk_bind2_node

The patch 8 will trigger a false-positive error by checkpatch.


v2: resend of https://lore.kernel.org/netdev/20231213082029.35149-1-kuniyu@amazon.com/
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


