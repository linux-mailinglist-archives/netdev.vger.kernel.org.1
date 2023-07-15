Return-Path: <netdev+bounces-18045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8143754631
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930721C208D4
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D7A47;
	Sat, 15 Jul 2023 02:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB97EC
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:15:14 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5702D68
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689387314; x=1720923314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5e2fQW3Y9E7fqRLX+xgDDUEUogWV6uhg2kDWvxW0d0=;
  b=PkRABj0MelnA8uYilWb+LlSU3xeOV68KAuN9sZWaA5mTuEosxewVfxZH
   0s6BC3fAWNb/1755dt8y5ObjWCy0C3akaD2s50XT14CafIh9gw5hVkOuH
   Fr/ZigAKzPUCcVgAjK9y73l1dapKwr9dLS8vpkZij24TOCJZGrEMVwdj7
   8=;
X-IronPort-AV: E=Sophos;i="6.01,207,1684800000"; 
   d="scan'208";a="339831226"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 02:15:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id CA21BA9315;
	Sat, 15 Jul 2023 02:15:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:15:05 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 02:15:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	<hcoin@quietfountain.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 3/4] llc: Don't drop packet from non-root netns.
Date: Fri, 14 Jul 2023 19:13:37 -0700
Message-ID: <20230715021338.34747-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230715021338.34747-1-kuniyu@amazon.com>
References: <20230715021338.34747-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now these upper layer protocol handlers can be called from llc_rcv()
as sap->rcv_func(), which is registered by llc_sap_open().

  * function which is passed to register_8022_client()
    -> no in-kernel user calls register_8022_client().

  * snap_rcv()
    `- proto->rcvfunc() : registered by register_snap_client()
       -> aarp_rcv() and atalk_rcv() drop packets from non-root netns

  * stp_pdu_rcv()
    `- garp_protos[]->rcv() : registered by stp_proto_register()
       -> garp_pdu_rcv() and br_stp_rcv() are netns-aware

So, we can safely remove the netns restriction in llc_rcv().

Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/llc/llc_input.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index c309b72a5877..7cac441862e2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -163,9 +163,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
-- 
2.30.2


