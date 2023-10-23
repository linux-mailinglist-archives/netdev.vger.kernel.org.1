Return-Path: <netdev+bounces-43590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38747D3FC4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF662813B2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090921A00;
	Mon, 23 Oct 2023 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KrTweuma"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED1219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:03:11 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2698
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087791; x=1729623791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=02k0pRN6q2W7tutcY/F1Qk+NYSv971sOpwSaE+4te/M=;
  b=KrTweumaFO3LLQrlGS8Ezd75wl3CGYDyYdg2CTkPpYccTpryWVAjYWoo
   Hbt+xj/SWKP/iGWf/q/zITa4Gal1BNN2ewwXtlU+B084L5uefLV6VLOj2
   otHyZHqKTmI9WiGLY6v3JE+7Pn3IJGyyNtw1IjXqC+HrJE7/WSyExSpj8
   g=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="37884399"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:03:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id 592D8A0FAA;
	Mon, 23 Oct 2023 19:03:08 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:40174]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.43:2525] with esmtp (Farcaster)
 id ca6c91f4-310c-4a2e-b9fd-eeeb19f4d9a6; Mon, 23 Oct 2023 19:03:07 +0000 (UTC)
X-Farcaster-Flow-ID: ca6c91f4-310c-4a2e-b9fd-eeeb19f4d9a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:03:07 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 23 Oct 2023 19:03:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/12] tcp: Refactor bhash2 and remove sk_bind2_node.
Date: Mon, 23 Oct 2023 12:02:43 -0700
Message-ID: <20231023190255.39190-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This series refactors code around bhash2 and remove some bhash2-specific
fields, sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.

  patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
  patch 2 -  4 : optimise bind() conflict tests
  patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
                 remove sk_bind2_node

The patch 8 will trigger a false-positive error by checkpatch.

This series will affect the recent work by Coco Li reorganising major
structs.


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
 net/ipv4/inet_hashtables.c       | 98 +++++++++++++++-----------------
 net/ipv4/inet_timewait_sock.c    | 21 +------
 7 files changed, 91 insertions(+), 145 deletions(-)

-- 
2.30.2


