Return-Path: <netdev+bounces-19298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6975A38C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8ED281BC5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7F64C;
	Thu, 20 Jul 2023 00:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40173621
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:45:17 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41912100
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689813917; x=1721349917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilr1spx6x8Sja/x4OJeBwc7Btf7Qagl8uMdd/OqmKW8=;
  b=q8CfgbvMfJEi28dHZ2bDEyFxyGTzex916pod5jEkeCBFbgCkTcyL4apb
   EeFd66sFBBPUZRLqktxaYu3oNTYHorMSVZiE9vPk2t7i0wZh45i+r8gdZ
   FAkQuMN9siyXrTGiXaXNRCe3tj9IyYcysBKlzq/oFmFdHkk4wF1qUw9Ax
   I=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="593943980"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:45:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id E79AE8059C;
	Thu, 20 Jul 2023 00:45:11 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:45:11 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 00:45:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Breno Leitao" <leitao@debian.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v2 net 1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
Date: Wed, 19 Jul 2023 17:44:09 -0700
Message-ID: <20230720004410.87588-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230720004410.87588-1-kuniyu@amazon.com>
References: <20230720004410.87588-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.39]
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller found a bug in unix_bind_bsd() [0].  We can reproduce it
by bind()ing a socket on a path with length 108.

108 is the size of sun_addr of struct sockaddr_un and is the maximum
valid length for the pathname socket.  When calling bind(), we use
struct sockaddr_storage as the actual buffer size, so terminating
sun_addr[108] with null is legitimate.

However, strlen(sunaddr) for such a case causes fortify_panic() if
CONFIG_FORTIFY_SOURCE=y.  __fortify_strlen() has no idea about the
actual buffer size and takes 108 as overflow, although 108 still
fits in struct sockaddr_storage.

Let's make __fortify_strlen() recognise the actual buffer size.

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
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/unix/af_unix.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 123b35ddfd71..e1b1819b96d1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -302,6 +302,18 @@ static void unix_mkname_bsd(struct sockaddr_un *sunaddr, int addr_len)
 	((char *)sunaddr)[addr_len] = 0;
 }
 
+static int unix_strlen_bsd(struct sockaddr_un *sunaddr)
+{
+	/* Don't pass sunaddr->sun_path to strlen().  Otherwise, the
+	 * max valid length UNIX_PATH_MAX (108) will cause panic if
+	 * CONFIG_FORTIFY_SOURCE=y.  Let __fortify_strlen() know that
+	 * the actual buffer is struct sockaddr_storage and that 108
+	 * is within __data[].  See also: unix_mkname_bsd().
+	 */
+	return strlen(((struct sockaddr_storage *)sunaddr)->__data) +
+		offsetof(struct sockaddr_un, sun_path) + 1;
+}
+
 static void __unix_remove_socket(struct sock *sk)
 {
 	sk_del_node_init(sk);
@@ -1209,9 +1221,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	int err;
 
 	unix_mkname_bsd(sunaddr, addr_len);
-	addr_len = strlen(sunaddr->sun_path) +
-		offsetof(struct sockaddr_un, sun_path) + 1;
-
+	addr_len = unix_strlen_bsd(sunaddr);
 	addr = unix_create_addr(sunaddr, addr_len);
 	if (!addr)
 		return -ENOMEM;
-- 
2.30.2


