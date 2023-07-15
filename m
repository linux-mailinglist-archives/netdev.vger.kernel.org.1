Return-Path: <netdev+bounces-18042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA075462E
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350A2282338
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9847EC;
	Sat, 15 Jul 2023 02:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D41A47
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:14:08 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB7C2D68
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689387246; x=1720923246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCMw7yfS2lnMoWWz17Smhqc6pFG/wJ++918l39RF624=;
  b=C9tc9atKaS5zTcYXZbwiVGcSr/M4lTH4VHwYeK5pdCPY4QXP2J6FRclC
   IM1YcvTYatJtFLOA7OL67xUMnKkm6NUjJ6yb+R+URoO9WI9bf1MrVg3xD
   SB4PugqKk/gdWXgb2jyY05VfGk8NsSi8yFDM+67FaM6cYHFv5hpMyNVHy
   E=;
X-IronPort-AV: E=Sophos;i="6.01,207,1684800000"; 
   d="scan'208";a="346923723"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 02:14:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 7D0B146851;
	Sat, 15 Jul 2023 02:14:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:13:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:13:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/4] net: Support STP on bridge in non-root netns.
Date: Fri, 14 Jul 2023 19:13:34 -0700
Message-ID: <20230715021338.34747-1-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
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
can be backported to stable tree (at least to 4.14.y) without conflicts.

Another series that adds netns support for AF_LLC will be targeted
to net-next later.


Kuniyuki Iwashima (4):
  llc: Check netns in llc_dgram_match().
  llc: Check netns in llc_estab_match() and llc_listener_match().
  llc: Don't drop packet from non-root netns.
  Revert "bridge: Add extack warning when enabling STP in netns."

 include/net/llc_conn.h |  2 +-
 net/bridge/br_stp_if.c |  3 ---
 net/llc/af_llc.c       |  2 +-
 net/llc/llc_conn.c     | 47 +++++++++++++++++++++++++-----------------
 net/llc/llc_if.c       |  2 +-
 net/llc/llc_input.c    |  3 ---
 net/llc/llc_sap.c      | 17 ++++++++-------
 7 files changed, 41 insertions(+), 35 deletions(-)

-- 
2.30.2


