Return-Path: <netdev+bounces-39200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B597BE4CD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA32281873
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862843716E;
	Mon,  9 Oct 2023 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VTGoiu21"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5083D310
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:32:45 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC491
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696865564; x=1728401564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=72nn6q+l3tV4UBJ/EOk9/rwJ62B6uHAp4+R9t28R6Ac=;
  b=VTGoiu21fi+JDX3t71TAuoc5qaTDlvtOw9lwAg8U7xGJke/MNf27wrCu
   IZchphb5hDkB9gD3wA9yZhGsnAbtU8D2fXfzcVy02oRE3LaF0D30AloI0
   tlrfNTr4Fjc0cH81Zpzttkq/x9IB2/cCj4PQgI0Sf9/nD9RY2pq0U3oeZ
   c=;
X-IronPort-AV: E=Sophos;i="6.03,210,1694736000"; 
   d="scan'208";a="34500522"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:32:36 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id D96B2A3F76;
	Mon,  9 Oct 2023 15:32:33 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 15:32:33 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 15:32:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Kees Cook <keescook@chromium.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Sergei Trofimovich
	<slyich@gmail.com>
Subject: [PATCH v1 net] af_packet: Fix fortified memcpy() without flex array.
Date: Mon, 9 Oct 2023 08:31:52 -0700
Message-ID: <20231009153151.75688-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.12]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
("af_packet: Fix warning of fortified memcpy() in packet_getname().").

It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
union-ed member with sll_addr to work around the fortified memcpy() check.

However, a userspace program uses a struct that has struct sockaddr_ll in
the middle, where a flex array is illegal to exist.

  include/linux/if_packet.h:24:17: error: flexible array member 'sockaddr_ll::<unnamed union>::<unnamed struct>::sll_addr_flex' not at end of 'struct packet_info_t'
     24 |                 __DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
        |                 ^~~~~~~~~~~~~~~~~~~~

To fix the regression, let's go back to the first attempt [1] telling
memcpy() the actual size of the array.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Closes: https://github.com/NixOS/nixpkgs/pull/252587#issuecomment-1741733002 [0]
Link: https://lore.kernel.org/netdev/20230720004410.87588-3-kuniyu@amazon.com/ [1]
Fixes: a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/uapi/linux/if_packet.h | 6 +-----
 net/packet/af_packet.c         | 7 ++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 4d0ad22f83b5..9efc42382fdb 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -18,11 +18,7 @@ struct sockaddr_ll {
 	unsigned short	sll_hatype;
 	unsigned char	sll_pkttype;
 	unsigned char	sll_halen;
-	union {
-		unsigned char	sll_addr[8];
-		/* Actual length is in sll_halen. */
-		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
-	};
+	unsigned char	sll_addr[8];
 };
 
 /* Packet types */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8f97648d652f..a84e00b5904b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3607,7 +3607,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
+
+		/* Let __fortify_memcpy_chk() know the actual buffer size. */
+		memcpy(((struct sockaddr_storage *)sll)->__data +
+		       offsetof(struct sockaddr_ll, sll_addr) -
+		       offsetofend(struct sockaddr_ll, sll_family),
+		       dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;
-- 
2.30.2


