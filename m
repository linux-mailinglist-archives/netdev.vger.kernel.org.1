Return-Path: <netdev+bounces-20556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FA76013D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37F11C208E5
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7A111AB;
	Mon, 24 Jul 2023 21:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750E10978
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:34:49 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52110D8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690234489; x=1721770489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vaRxenrkUPEUABvAFjDdwimN8CPg98ngU5PWFLGC3Wk=;
  b=rTxsUc/tptgafY32Le/3vTYx7kxwmnYSHapToCqnW2BlcVsbuZoc5Ks5
   oxp8H8NMIda40Siul3KgS5mRlaeYz7C20yUMakIC8T/VFrZ8raRtCFAc/
   VMx+dBgtPDz5fnKqQ99+HpSTKYnY5nosGuBrOEfiMOLCtDL4U/CKFoC/i
   8=;
X-IronPort-AV: E=Sophos;i="6.01,228,1684800000"; 
   d="scan'208";a="296967578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:34:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 37C7E60A89;
	Mon, 24 Jul 2023 21:34:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:34:38 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:34:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Breno Leitao" <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net 0/2] net: Fix error/warning by -fstrict-flex-arrays=3.
Date: Mon, 24 Jul 2023 14:34:23 -0700
Message-ID: <20230724213425.22920-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.36]
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started applying
strict rules for standard string functions (strlen(), memcpy(), etc.) if
CONFIG_FORTIFY_SOURCE=y.

This series fixes two false positives caught by syzkaller.


Changes:
  v3:
    * Drop Reviewed-by
    * Patch 1: Use strnlen()
    * Patch 2: Add a new flex array member

  v2: https://lore.kernel.org/netdev/20230720004410.87588-1-kuniyu@amazon.com/
    * Patch 2: Fix offset calc.

  v1: https://lore.kernel.org/netdev/20230719185322.44255-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  af_unix: Fix fortify_panic() in unix_bind_bsd().
  af_packet: Fix warning of fortified memcpy() in packet_getname().

 include/uapi/linux/if_packet.h | 6 +++++-
 net/packet/af_packet.c         | 2 +-
 net/unix/af_unix.c             | 6 ++----
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.30.2


