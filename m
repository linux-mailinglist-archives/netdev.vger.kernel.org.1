Return-Path: <netdev+bounces-50411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D997F5B09
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE11FB20C1B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC98208BE;
	Thu, 23 Nov 2023 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="IPQY3vK8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347DDD;
	Thu, 23 Nov 2023 01:25:58 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 528061186113;
	Thu, 23 Nov 2023 12:25:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 528061186113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1700731556; bh=lA6R2xYOxsaucfW0fbUZrtsLYzmnyeXkqpK0MlytNN0=;
	h=From:To:CC:Subject:Date:From;
	b=IPQY3vK8Xk6pKBcUeVa4PEQ45sGWgcixKAqzzCXFHr9EoPIuFjGtZ4N1lAlQegP6u
	 lmL5QlhboKHYEC5+4KBuvsHATBL4awEQSHXCFjtUeyuAkYrHDLNT49f6Nl78UN1dpY
	 wn/eCi0ttJS/lEv/duHH+fkaA70iYADFsGr+u2MI=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 4F455312FFE4;
	Thu, 23 Nov 2023 12:25:55 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Paul Moore <paul@paul-moore.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
Thread-Topic: [PATCH net v2] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Thread-Index: AQHaHe8PzUY9PMUIEUGPey0eifO26Q==
Date: Thu, 23 Nov 2023 09:25:54 +0000
Message-ID: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/11/23 07:58:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/11/23 06:11:00 #22507418
X-KLMS-AntiVirus-Status: Clean, skipped

If IPv6 support is disabled at boot (ipv6.disable=3D1),
the calipso_init() -> netlbl_calipso_ops_register() function isn't called,
and the netlbl_calipso_ops_get() function always returns NULL.
In this case, the netlbl_calipso_add_pass() function allocates memory
for the doi_def variable but doesn't free it with the calipso_doi_free().

BUG: memory leak
unreferenced object 0xffff888011d68180 (size 64):
  comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
  hex dump (first 32 bytes):
    00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_cali=
pso.c:76 [inline]
    [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/netlab=
el_calipso.c:111
    [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/g=
enetlink.c:739
    [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:783 [i=
nline]
    [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:8=
00
    [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink=
.c:2515
    [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
    [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.c:13=
13 [inline]
    [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_netlink=
.c:1339
    [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_netlink=
.c:1934
    [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
    [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
    [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
    [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
    [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
    [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink pro=
tocol.")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
v2:
  - return the error code in netlbl_calipso_add() if the variable calipso_h=
ops is NULL
v1: https://lore.kernel.org/all/20231122135242.2779058-1-Ilia.Gavrilov@info=
tecs.ru/

 net/netlabel/netlabel_calipso.c | 49 +++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calips=
o.c
index f1d5b8465217..a07c2216d28b 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -54,6 +54,28 @@ static const struct nla_policy calipso_genl_policy[NLBL_=
CALIPSO_A_MAX + 1] =3D {
 	[NLBL_CALIPSO_A_MTYPE] =3D { .type =3D NLA_U32 },
 };
=20
+static const struct netlbl_calipso_ops *calipso_ops;
+
+/**
+ * netlbl_calipso_ops_register - Register the CALIPSO operations
+ * @ops: ops to register
+ *
+ * Description:
+ * Register the CALIPSO packet engine operations.
+ *
+ */
+const struct netlbl_calipso_ops *
+netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
+{
+	return xchg(&calipso_ops, ops);
+}
+EXPORT_SYMBOL(netlbl_calipso_ops_register);
+
+static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
+{
+	return READ_ONCE(calipso_ops);
+}
+
 /* NetLabel Command Handlers
  */
 /**
@@ -96,15 +118,18 @@ static int netlbl_calipso_add_pass(struct genl_info *i=
nfo,
  *
  */
 static int netlbl_calipso_add(struct sk_buff *skb, struct genl_info *info)
-
 {
 	int ret_val =3D -EINVAL;
 	struct netlbl_audit audit_info;
+	const struct netlbl_calipso_ops *ops =3D netlbl_calipso_ops_get();
=20
 	if (!info->attrs[NLBL_CALIPSO_A_DOI] ||
 	    !info->attrs[NLBL_CALIPSO_A_MTYPE])
 		return -EINVAL;
=20
+	if (!ops)
+		return -EOPNOTSUPP;
+
 	netlbl_netlink_auditinfo(&audit_info);
 	switch (nla_get_u32(info->attrs[NLBL_CALIPSO_A_MTYPE])) {
 	case CALIPSO_MAP_PASS:
@@ -363,28 +388,6 @@ int __init netlbl_calipso_genl_init(void)
 	return genl_register_family(&netlbl_calipso_gnl_family);
 }
=20
-static const struct netlbl_calipso_ops *calipso_ops;
-
-/**
- * netlbl_calipso_ops_register - Register the CALIPSO operations
- * @ops: ops to register
- *
- * Description:
- * Register the CALIPSO packet engine operations.
- *
- */
-const struct netlbl_calipso_ops *
-netlbl_calipso_ops_register(const struct netlbl_calipso_ops *ops)
-{
-	return xchg(&calipso_ops, ops);
-}
-EXPORT_SYMBOL(netlbl_calipso_ops_register);
-
-static const struct netlbl_calipso_ops *netlbl_calipso_ops_get(void)
-{
-	return READ_ONCE(calipso_ops);
-}
-
 /**
  * calipso_doi_add - Add a new DOI to the CALIPSO protocol engine
  * @doi_def: the DOI structure
--=20
2.39.2

