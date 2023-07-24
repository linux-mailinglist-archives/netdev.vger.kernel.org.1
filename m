Return-Path: <netdev+bounces-20557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118876013E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BD71C208D9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E335111AB;
	Mon, 24 Jul 2023 21:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1D11C86
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:35:16 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB40D8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690234514; x=1721770514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcvQNZkvfX2vFau8D+np+b9z7pYGBCs+SMJJs1BvtQE=;
  b=aWBft0lls+/8jb504AUuTaMKWqDNkJ+TpEJsjyUdWxDpGEpFVOIe1Fv1
   JsdUjGJ0bddGgpjUZhfsGwnOHUXGkPsuRwS0XCaEeqWhO4vvt1qE+mp1A
   R8NKPAN6Js2TIv/za3Yqc8O2n4BNAzmZDsZOeAPknNAV/0rzupaMye+y/
   I=;
X-IronPort-AV: E=Sophos;i="6.01,228,1684800000"; 
   d="scan'208";a="1144782005"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:35:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id E392240DB7;
	Mon, 24 Jul 2023 21:35:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:35:04 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 21:35:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Breno Leitao" <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v3 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
Date: Mon, 24 Jul 2023 14:34:24 -0700
Message-ID: <20230724213425.22920-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller found a bug in unix_bind_bsd() [0].  We can reproduce it
by bind()ing a socket on a path with length 108.

108 is the size of sun_addr of struct sockaddr_un and is the maximum
valid length for the pathname socket.  When calling bind(), we use
struct sockaddr_storage as the actual buffer size, so terminating
sun_addr[108] with null is legitimate as done in unix_mkname_bsd().

However, strlen(sunaddr) for such a case causes fortify_panic() if
CONFIG_FORTIFY_SOURCE=y.  __fortify_strlen() has no idea about the
actual buffer size and see the string as unterminated.

Let's use strnlen() to allow sun_addr to be unterminated at 107.

[0]:
detected buffer overflow in __fortify_strlen
kernel BUG at lib/string_helpers.c:1031!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 255 Comm: syz-executor296 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #4
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
lr : fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
sp : ffff800089817af0
x29: ffff800089817af0 x28: ffff800089817b40 x27: 1ffff00011302f68
x26: 000000000000006e x25: 0000000000000012 x24: ffff800087e60140
x23: dfff800000000000 x22: ffff800089817c20 x21: ffff800089817c8e
x20: 000000000000006c x19: ffff00000c323900 x18: ffff800086ab1630
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 1ffff00011302eb8 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 64a26b65474d2a00
x8 : 64a26b65474d2a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800089817438 x4 : ffff800086ac99e0 x3 : ffff800080f19e8c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 000000000000002c
Call trace:
 fortify_panic+0x1c/0x20 lib/string_helpers.c:1030
 _Z16__fortify_strlenPKcU25pass_dynamic_object_size1 include/linux/fortify-string.h:217 [inline]
 unix_bind_bsd net/unix/af_unix.c:1212 [inline]
 unix_bind+0xba8/0xc58 net/unix/af_unix.c:1326
 __sys_bind+0x1ac/0x248 net/socket.c:1792
 __do_sys_bind net/socket.c:1803 [inline]
 __se_sys_bind net/socket.c:1801 [inline]
 __arm64_sys_bind+0x7c/0x94 net/socket.c:1801
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x134/0x240 arch/arm64/kernel/syscall.c:139
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:188
 el0_svc+0x2c/0x7c arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: aa0003e1 d0000e80 91030000 97ffc91a (d4210000)

Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 123b35ddfd71..bbacf4c60fe3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1208,10 +1208,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	struct path parent;
 	int err;
 
-	unix_mkname_bsd(sunaddr, addr_len);
-	addr_len = strlen(sunaddr->sun_path) +
-		offsetof(struct sockaddr_un, sun_path) + 1;
-
+	addr_len = strnlen(sunaddr->sun_path, sizeof(sunaddr->sun_path))
+		+ offsetof(struct sockaddr_un, sun_path) + 1;
 	addr = unix_create_addr(sunaddr, addr_len);
 	if (!addr)
 		return -ENOMEM;
-- 
2.30.2


