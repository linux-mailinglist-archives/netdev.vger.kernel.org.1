Return-Path: <netdev+bounces-18659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3597583A9
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86846281229
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301215AC1;
	Tue, 18 Jul 2023 17:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96536156E0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:42:13 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77210FE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689702131; x=1721238131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i0Whe2stjEdfIzzYBBNPtwQZ8Nc6HSSEdkv06ap20qU=;
  b=fYnLs8N+Ds5pecTqhNew5RGSbBjfKxBZ4w7CI+eXezq6fw+YTbZpBfqN
   856LQCAO1FoWyHMPZTzHGgEyGyeosFCZPyIFoWORx8fi4YZu8fsyy6c8j
   UrBRsLWS5sQbDJ349vVwQEszVR8hBhASmIOJYs1IAZ0vav+y4KqoN7nc5
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="345255094"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:42:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-0ec33b60.us-west-2.amazon.com (Postfix) with ESMTPS id 047E5A0AC7;
	Tue, 18 Jul 2023 17:42:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:42:05 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 17:42:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/4] net: Support STP on bridge in non-root netns.
Date: Tue, 18 Jul 2023 10:41:48 -0700
Message-ID: <20230718174152.57408-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.18]
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, STP does not work in non-root netns as llc_rcv() drops
packets from non-root netns.

This series fixes it by making some protocol handlers netns-aware,
which are called from llc_rcv() as follows:

  llc_rcv()
  |
  |- sap->rcv_func : registered by llc_sap_open()
  |
  |  * functions : regsitered by register_8022_client()
  |    -> No in-kernel user call register_8022_client()
  |
  |  * snap_rcv()
  |    |
  |    `- proto->rcvfunc() : registered by register_snap_client()
  |
  |       * aarp_rcv()  : drop packets from non-root netns
  |       * atalk_rcv() : drop packets from non-root netns
  |
  |  * stp_pdu_rcv()
  |    |
  |    `- garp_protos[]->rcv() : registered by stp_proto_register()
  |
  |       * garp_pdu_rcv() : netns-aware
  |       * br_stp_rcv()   : netns-aware
  |
  |- llc_type_handlers[llc_pdu_type(skb) - 1]
  |
  |  * llc_sap_handler()  : NOT netns-aware (Patch 1)
  |  * llc_conn_handler() : NOT netns-aware (Patch 2)
  |
  `- llc_station_handler

     * llc_station_rcv() : netns-aware

Patch 1 & 2 convert not-netns-aware functions and Patch 3 remove the
netns restriction in llc_rcv().

Note this series does not namespacify AF_LLC so that these patches
can be backported to stable without conflicts (at least to 4.14.y).

Another series that adds netns support for AF_LLC will be targeted
to net-next later.


Changes:
  v2:
    * Patch 1     : Update changelog, s/in the following patch/soon/
    * Patch 1 & 2 : Fix kdoc warning of make W=1

  v1: https://lore.kernel.org/netdev/20230715021338.34747-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  llc: Check netns in llc_dgram_match().
  llc: Check netns in llc_estab_match() and llc_listener_match().
  llc: Don't drop packet from non-root netns.
  Revert "bridge: Add extack warning when enabling STP in netns."

 include/net/llc_conn.h |  2 +-
 net/bridge/br_stp_if.c |  3 ---
 net/llc/af_llc.c       |  2 +-
 net/llc/llc_conn.c     | 49 ++++++++++++++++++++++++++----------------
 net/llc/llc_if.c       |  2 +-
 net/llc/llc_input.c    |  3 ---
 net/llc/llc_sap.c      | 18 ++++++++++------
 7 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.30.2


