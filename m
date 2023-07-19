Return-Path: <netdev+bounces-19164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B4759DF0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E739A1C20756
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B2275CD;
	Wed, 19 Jul 2023 18:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA5275A1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:54:50 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACC171E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689792889; x=1721328889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HphxHhLbP1g/vaPeilVVEQW2DgF2V7kO44YGZerFfHc=;
  b=PSH7nLOMeATNF6DFlOT9s/1Q+qqAM7cMImgvnc6fz+fwsCROTjKevezW
   JyRixkuYagSZi/32Nd0aWKd0RU4ywSq/yW28G+Yt7snG8GNKjFaBENc2F
   AKsfpiSH3zPReh3OxKzzvYoKDYcAYZ0YHBC6HpWYd64MOlojwqQ00MuqZ
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="1143927797"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:54:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 98273A0E65;
	Wed, 19 Jul 2023 18:54:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 18:54:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 18:54:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Breno Leitao" <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Wed, 19 Jul 2023 11:53:22 -0700
Message-ID: <20230719185322.44255-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719185322.44255-1-kuniyu@amazon.com>
References: <20230719185322.44255-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller found a warning in packet_getname() [0], where we try to
copy 16 bytes to sockaddr_ll.sll_addr[8].

Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
by struct in6_addr.

The write seems to overflow, but actually not since we use struct
sockaddr_storage defined in __sys_getsockname().

To avoid the warning, we need to let __fortify_memcpy_chk() know the
actual buffer size.

Another option would be to use strncpy() and limit the copied length
to sizeof(sll_addr), but it will return the partial address and might
break an application that passes sockaddr_storage to getsockname().

[0]:
memcpy: detected field-spanning write (size 16) of single field "sll->sll_addr" at net/packet/af_packet.c:3604 (size 8)
WARNING: CPU: 0 PID: 255 at net/packet/af_packet.c:3604 packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
Modules linked in:
CPU: 0 PID: 255 Comm: syz-executor750 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
lr : packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
sp : ffff800089887bc0
x29: ffff800089887bc0 x28: ffff000010f80f80 x27: 0000000000000003
x26: dfff800000000000 x25: ffff700011310f80 x24: ffff800087d55000
x23: dfff800000000000 x22: ffff800089887c2c x21: 0000000000000010
x20: ffff00000de08310 x19: ffff800089887c20 x18: ffff800086ab1630
x17: 20646c6569662065 x16: 6c676e697320666f x15: 0000000000000001
x14: 1fffe0000d56d7ca x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 3e60944c3da92b00
x8 : 3e60944c3da92b00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000898874f8 x4 : ffff800086ac99e0 x3 : ffff8000803f8808
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 packet_getname+0x25c/0x3a0 net/packet/af_packet.c:3604
 __sys_getsockname+0x168/0x24c net/socket.c:2042
 __do_sys_getsockname net/socket.c:2057 [inline]
 __se_sys_getsockname net/socket.c:2054 [inline]
 __arm64_sys_getsockname+0x7c/0x94 net/socket.c:2054
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/packet/af_packet.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 85ff90a03b0c..5eef94a32a4f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3601,7 +3601,10 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
+
+		/* Let __fortify_memcpy_chk() know the actual buffer size. */
+		memcpy(((struct sockaddr_storage *)sll)->__data +
+		       offsetof(struct sockaddr_ll, sll_addr), dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;
-- 
2.30.2


