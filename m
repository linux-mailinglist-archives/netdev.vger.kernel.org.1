Return-Path: <netdev+bounces-32872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9F79AA55
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6CB2811B0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771CAD2E;
	Mon, 11 Sep 2023 16:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9198F4A
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:51:25 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF077EB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694451086; x=1725987086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2aDSyiTKFdvbMWvr53F8uz13ixFKRPUMyCnsNPJlUrk=;
  b=veLsRvg2fp9ahTu1VJ6jA4jwFyHbU+H3j4IIeuLLLV+X4FnWtlYWuJYM
   WujOcPPINYixrm7faIjFdNvc8KwmVwHCRDQGX3A9U5qbgMllwr6zoWErU
   Zrxq199/G9uhvch0sF3YddvTKGNh4gisJQvVB3uxfQccbPDp01wU7WMlO
   E=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="603852977"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 16:51:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 484968072B;
	Mon, 11 Sep 2023 16:51:21 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:51:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 11 Sep 2023 16:51:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/5] tcp: Fix bind() regression for v4-mapped-v6 address
Date: Mon, 11 Sep 2023 09:51:01 -0700
Message-ID: <20230911165106.39384-1-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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


Kuniyuki Iwashima (5):
  tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
  tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
  selftest: tcp: Fix address length in bind_wildcard.c.
  selftest: tcp: Move expected_errno into each test case in
    bind_wildcard.c.
  selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.

 include/net/ipv6.h                          |  5 ++
 net/ipv4/inet_hashtables.c                  | 12 +++-
 tools/testing/selftests/net/bind_wildcard.c | 68 +++++++++++++++++----
 3 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.30.2


