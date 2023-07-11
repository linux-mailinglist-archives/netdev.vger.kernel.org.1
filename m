Return-Path: <netdev+bounces-16982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7441B74FBF2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5FF1C20E43
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728F51ED4D;
	Tue, 11 Jul 2023 23:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C21DDE5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:54:30 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567F170F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689119669; x=1720655669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S31tc4n4Ui6HS+LailK8v4AO1tjvB2dHTdcwzIgGBFk=;
  b=fsaCeF2b7BODBn9dkEYnt0kziFvuHCDiVjV0clIAnMGJmsoxSjCMBoH8
   CSwkfkWb2GXz3kL4abrqFs0BugDi6bBGUWWsWBQdMvBLFKaSGUgncdw9M
   R2MIxvdnJPoXLu7AGRJynRyg/X07EqAkndj3I9Bydy4csWnkC1vZ9c2CA
   M=;
X-IronPort-AV: E=Sophos;i="6.01,198,1684800000"; 
   d="scan'208";a="659347303"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:54:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id D1D4C60CBB;
	Tue, 11 Jul 2023 23:54:27 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 23:54:27 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 23:54:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>, Harry Coin
	<hcoin@quietfountain.com>
Subject: [PATCH v1 net] bridge: Return an error when enabling STP in netns.
Date: Tue, 11 Jul 2023 16:54:15 -0700
Message-ID: <20230711235415.92166-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.35]
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When we create an L2 loop on a bridge in netns, we will see packets storm
even if STP is enabled.

  # unshare -n
  # ip link add br0 type bridge
  # ip link add veth0 type veth peer name veth1
  # ip link set veth0 master br0 up
  # ip link set veth1 master br0 up
  # ip link set br0 type bridge stp_state 1
  # ip link set br0 up
  # sleep 30
  # ip -s link show br0
  2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
      link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
      RX: bytes  packets  errors  dropped missed  mcast
      956553768  12861249 0       0       0       12861249  <-. Keep
      TX: bytes  packets  errors  dropped carrier collsns     |  increasing
      1027834    11951    0       0       0       0         <-'   rapidly

This is because llc_rcv() drops all packets in non-root netns and BPDU
is dropped.

Let's show an error when enabling STP in netns.

  # unshare -n
  # ip link add br0 type bridge
  # ip link set br0 type bridge stp_state 1
  Error: bridge: STP can't be enabled in non-root netns.

Note this commit will be reverted later when we namespacify the whole LLC
infra.

Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
Suggested-by: Harry Coin <hcoin@quietfountain.com>
Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/bridge/br_stp_if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 75204d36d7f9..a807996ac56b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net)) {
+		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
+		return -EINVAL;
+	}
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
-- 
2.30.2


