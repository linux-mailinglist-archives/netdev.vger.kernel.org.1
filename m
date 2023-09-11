Return-Path: <netdev+bounces-32907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E579AADA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B101D1C20A04
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90B154AE;
	Mon, 11 Sep 2023 18:37:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B6AD23
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:37:27 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2DA1AB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694457446; x=1725993446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u72EqY14UiepYwo7iLfPI83WRNIuD9tKRcPajzZe1sY=;
  b=psnAPkL2f7srqKBPHVcIlOuzXL719SXbY2QDKcqwLrKGebfjnLEhNdxw
   DdumpVzshjAfFDIdQxWlZ+BmNqibARjJ5vFVAa3SNZy6OCoZ/0Z2+gNCj
   pfArC0YPLBMabsTXoqBFqpbARMReoEqamE7InJZCHBo45+KI0Oy7/jQIj
   k=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="1153589798"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:37:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 71901806DC;
	Mon, 11 Sep 2023 18:37:13 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 18:37:12 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Mon, 11 Sep 2023 18:37:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/6] tcp: Fix bind() regression for v4-mapped-v6 address
Date: Mon, 11 Sep 2023 11:36:54 -0700
Message-ID: <20230911183700.60878-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since bhash2 was introduced, bind() is broken in two cases related
to v4-mapped-v6 address.

This series fixes the regression and adds test to cover the cases.


Changes:
  v2:
    * Added patch 1 to factorise duplicated comparison (Eric Dumazet)

  v1: https://lore.kernel.org/netdev/20230911165106.39384-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  tcp: Factorise sk_family-independent comparison in
    inet_bind2_bucket_match(_addr_any).
  tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
  tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
  selftest: tcp: Fix address length in bind_wildcard.c.
  selftest: tcp: Move expected_errno into each test case in
    bind_wildcard.c.
  selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.

 include/net/ipv6.h                          |  5 ++
 net/ipv4/inet_hashtables.c                  | 36 ++++++-----
 tools/testing/selftests/net/bind_wildcard.c | 68 +++++++++++++++++----
 3 files changed, 82 insertions(+), 27 deletions(-)

-- 
2.30.2


