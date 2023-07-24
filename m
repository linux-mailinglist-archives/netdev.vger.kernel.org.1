Return-Path: <netdev+bounces-20558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B7760142
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349A61C20C6A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B2111AE;
	Mon, 24 Jul 2023 21:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744B111AB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:35:39 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B331722
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690234539; x=1721770539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcm00Qb6ilM/6iYREXiuLK1FwnXzCW114tQpyf8H1Ck=;
  b=aNK2y5yGeg3ywceWxICYBYeq2Lbozd3BgkfOhYYP/fatSmRMWSd3tBt5
   Y+BhFG9BEf8VvTeKF5KxezATC/MFMvqmmn/n87e3sDv89UJaYdgktpNel
   QGwPDa0esCJLHZNkaf45NHYUfhw2Iagu5eWKNOi3y0zoR9FAwsmDDx9C6
   w=;
X-IronPort-AV: E=Sophos;i="6.01,229,1684800000"; 
   d="scan'208";a="594780792"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:35:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id B166380F6A;
	Mon, 24 Jul 2023 21:35:32 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:35:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:35:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Breno Leitao" <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v3 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Mon, 24 Jul 2023 14:34:25 -0700
Message-ID: <20230724213425.22920-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230724213425.22920-1-kuniyu@amazon.com>
References: <20230724213425.22920-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.36]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller found a warning in packet_getname() [0], where we try to
copy 16 bytes to sockaddr_ll.sll_addr[8].

Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
by struct in6_addr.  Also, Infiniband has 32 bytes as MAX_ADDR_LEN.

The write seems to overflow, but actually not since we use struct
sockaddr_storage defined in __sys_getsockname() and its size is 128
(_K_SS_MAXSIZE) bytes.  Thus, we have sufficient room after sll_addr[]
as __data[].

To avoid the warning, let's add a flex array member union-ed with
sll_addr.

Another option would be to use strncpy() and limit the copied length
to sizeof(sll_addr), but it will return the partial address and break
an application that passes sockaddr_storage to getsockname().

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
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/uapi/linux/if_packet.h | 6 +++++-
 net/packet/af_packet.c         | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 9efc42382fdb..4d0ad22f83b5 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -18,7 +18,11 @@ struct sockaddr_ll {
 	unsigned short	sll_hatype;
 	unsigned char	sll_pkttype;
 	unsigned char	sll_halen;
-	unsigned char	sll_addr[8];
+	union {
+		unsigned char	sll_addr[8];
+		/* Actual length is in sll_halen. */
+		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
+	};
 };
 
 /* Packet types */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 85ff90a03b0c..8e3ddec4c3d5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3601,7 +3601,7 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (dev) {
 		sll->sll_hatype = dev->type;
 		sll->sll_halen = dev->addr_len;
-		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
+		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
 	} else {
 		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
 		sll->sll_halen = 0;
-- 
2.30.2


