Return-Path: <netdev+bounces-24225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06DE76F5D3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 00:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AE28239B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A62591C;
	Thu,  3 Aug 2023 22:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50311EA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 22:46:11 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D76422B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691102770; x=1722638770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5K3A0JutliMRMFbOlGPqvY7SPdXTSZGXNGDWV341NwM=;
  b=vtdVOzyugzs1mQw7XeX9MPKbTaH8wyPc1fjzatBed9DvAdcoHYtRR0tv
   IA93FWWsc/o3ho7ot21xOJMpgz+PXS9P/rVkNqPerQy8nMmY0JtXkaU4v
   PrQnoau/QPSsRJP/yfW/rcIstr1qgXwMYKZhl8b0Nn3LZ7gVPLQRVp9Am
   c=;
X-IronPort-AV: E=Sophos;i="6.01,253,1684800000"; 
   d="scan'208";a="348487104"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:46:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id 62B6D8A43D;
	Thu,  3 Aug 2023 22:46:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:46:04 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:46:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/2] tcp: Disable header prediction for MD5.
Date: Thu, 3 Aug 2023 15:45:50 -0700
Message-ID: <20230803224552.69398-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.14]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 1st patch disable header prediction for MD5 flow and the 2nd
patch updates the stale comment in tcp_parse_options().


Changes:
  v3:
    * Disable header prediction instead of enabling
    * Add the 2nd patch

  v2: https://lore.kernel.org/netdev/20230803042214.38309-1-kuniyu@amazon.com/
    * Update function graph

  v1: https://lore.kernel.org/all/20230803011658.17086-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  tcp: Disable header prediction for MD5 flow.
  tcp: Update stale comment for MD5 in tcp_parse_options().

 net/ipv4/tcp_input.c     | 5 ++---
 net/ipv4/tcp_minisocks.c | 2 --
 net/ipv4/tcp_output.c    | 5 -----
 3 files changed, 2 insertions(+), 10 deletions(-)

-- 
2.30.2


