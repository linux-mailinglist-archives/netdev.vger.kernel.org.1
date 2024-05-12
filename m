Return-Path: <netdev+bounces-95771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0208C362E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0216728163A
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AD4200C1;
	Sun, 12 May 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mdauEvtd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2065.outbound.protection.outlook.com [40.92.89.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FF14265;
	Sun, 12 May 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715512666; cv=fail; b=L8LZ5RudCA9Ypg//+1x/95BjvX9q8aakx9frSctWT0yFvdQVBP11kmZfT6x/8NKU87ACU4kBjaUI7BTPvP4QiHWSxQE3NkHoKpr3PcSbFczh6/NotEMynITkOPA6Jtm17KXIaZ7Bq6hdqfdEbGVC5hMpMTe40PIfM69MOH3ee50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715512666; c=relaxed/simple;
	bh=Twy+4qL0i4LfjKxgj17PnOo/nbEK16vNz1Fsru+7EFw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tRsZuN0yzYUerv+G5BwZyWbOL7IZQje+D/lRjSi524zanIDRknXfrtP/K36DHa9tqHU6tbF06RjPInFb6SEPx9p5xOJjaWdpfEkDAXRa0guy0cFqiBf/B3m4QkcRgM2zmEsJ9bPe46c6AIbuzK7+Wen6fwn5F9ChM5OstSlY/EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mdauEvtd; arc=fail smtp.client-ip=40.92.89.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIAL/egdSVq8/BVSm7Mm1qu4BHPMHHGZz6Gx/hTUdUOCmon+ppldECdmU8ocQjINnVkVCpRsQe9a0GehSVaT0e1Az0/wJObPys2506SWCfEWN+EanycRyg8YGoah38HBRWLJOYPBR3rsT1YoDpZ+Vzu3O3S65bL+y6QG1mOn0vOVgzikCQtnGTQiQZNrGRraJfp/BEpiuoYpxh35abk95rqbAHdIhHdR5y9L7aG8zHO/Tr4InZVcROxuIp3KBRVmdfY9BeVt5JZqZZUU8oSw49EN0PyWsexC9e3GDJaqSU3XQXZ/5wuindS+Lk9YeKCXvitQsHmsvF6R4tMUr+JjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8vtJ2YZxXrunO7ONFn1rxg0QbT1LwStAoKpgMrB2vo=;
 b=CkdyNyPeSOPoE3KCKRbVr95h4/sn5QUOu2c0RUOy9FgM4Qwuf7y8Zx35di7ktaXuQMgU3XMg0OyDQdeUvSa7O+ngWxnOJvIgZraZDruQoEYtJ73ZeJVbN/vM10FB5V2sf9W2JEsnmRggAQSk65Gdkz/ck/AIZF2rI4PAPpQAzijCFjtrG7fU5CaMUyR2cRCnXuoHHaqV+eH22jtN1X4FozI16oCvuX2FQ6fo7iL6WpZcpXigRlkNmuR0VAb+gQ+sBmSjtWuqz5yfPUjXveAH23oTYI2FPzrwCGLVGbYm7me4O2Keu4vkqcwoB2+VOctAe8Ghu6nShZ/Sx1hq9IZYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8vtJ2YZxXrunO7ONFn1rxg0QbT1LwStAoKpgMrB2vo=;
 b=mdauEvtdWnYkrbgHHB2P8frO3DnBmu8RpTDjw1NTpo8tWOk2RAsbPDwe4o4TAkRtXPDWdp7EqMTYqCdwU7+39Sr93x2C34ZUyE5WrQQoMJ9/9ycg84hDPeHrRe28nzaq2Oq3C+2DlKs96MRdMoRmQPZbg6/h2A6BJ2q8j0/QYd6KCVg5aINANYhTtLiE+M4DZTyg2G1KABFBrneQxFHXiTXnz7g1XAVpJWffmPh8HA8+jSv5EL0dAntCgCnax9Vd8gj4YdMlb4hUECBrzk21gZdUjacJdZz/XN4vqmtBXLXrfe7qV8H24uJ98jdEc1v5WQCYs9KAxfx1xah/blH85Q==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GVXPR02MB10690.eurprd02.prod.outlook.com (2603:10a6:150:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 11:17:41 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 11:17:41 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] tty: rfcomm: prefer struct_size over open coded arithmetic
Date: Sun, 12 May 2024 13:17:24 +0200
Message-ID:
 <AS8PR02MB7237262C62B054FABD7229168BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+No29rggw54oDwiDwNbYhS2boQGTnUq4]
X-ClientProxiedBy: MA2P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::15) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240512111724.5660-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GVXPR02MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e7f092-dbf6-4107-6eeb-08dc72752341
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	0zuDgyWjKt8f63JVqPGb+wwvHL9dMuf53GBWzIdoYpKnJ4gC4p5wxE9q7FdmqGo1aa9JhHjM0JAOBOvHknwVdBv36dzLmMQM5/yAIH/eSsm3TehAZfJVDAs3u6epp6T5hvhRj3bmwCkOYXqFnyK8C5I/GzzIX+YXrIvNwVuQKLCSofuEQQWC/bcqWjx1qcw5ABpKh5FqmQJdu3iiRlGpbT7Y+rUwDzXuyUkxkbYSwQZvVE7Wk09F1Ij+b4D3lDOCWtXO3rRBjwz6RdyWJYg1xpiiTjDRrJyaUZIOs00+Emxy57dSSBZWtPu7vMwFLrlX2YHMzWZOOPP1Yv6O1Iz27A79Cf6h0kNoIw1TfuzL0JKnO5A2GO66Ea302w1yGapAIZuOoNsX9gbCSg5RzEl/YVUUXsjmzWXtMB9ZwAPPKqTn/bDORsCUExwXvHzsYYrPqJi3oSml+WuLIRQqGgZ2cqjMyrp50ty9uUKWsABnTWFoU1/UdXnbLaPHzDkmYG0LgfxIJtIDPOioIEte4puJlRjKfmh9W6mDgzCoLxt+uFaaoLLq+xhFLMhfKM3hyYxfap5PYdB4+kEAEjFi1ON/x3xg7bUMw5zMDiVV656K49GV33vAYN0hEYlnYHDolZaMo0XsfbOX/OYHgQHY+2pzPXoawgMNXwvSt3hdCN4Yc+z78azOHOZAM8H9YnvwqCneRKiejwB8hBhWkUwH7t9zAw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXH39S/gWMh1ErEmQM/HmkXIHcjIF1VEMJ4KZYl6y1upxXt12K7RQvV1Jt3a?=
 =?us-ascii?Q?8YrX6m1+ww6nH3LyOP+DB2MOKfu0Ay2VeEsY9QkkPxgiD+vsEVJRpkx7TJkV?=
 =?us-ascii?Q?3Sk6PASO0MKcAE0uxg1TG19Mzb5p2GqbAAkhN0L8HGwxcAB6XBlW8sHH8l9b?=
 =?us-ascii?Q?xk5vUWVcBgnrbr0ukvov/Rvmr3Lf/qNrGOdQUzjeLAwkxthsAyhv7BjaD/HC?=
 =?us-ascii?Q?UI7Eu5NoFSxg3887hFOXzI57EJWnhYEnA9TSv0UivrhajHKNaIxGFMUMBlpa?=
 =?us-ascii?Q?e3HQ1ILIUHeL9Ysodo4SiFMcL/rEfwAAdtQB8KTLVgkw4xmltT9jvJot/esH?=
 =?us-ascii?Q?Ji4RRNKdqtJJ/NdFaTb0eWQFLl27r4t66d4wmDlSv9un0BvsHPTZTGJUzPXG?=
 =?us-ascii?Q?e9aOxsOYcvyOXSQJLtEd6TFoQZg1JcxclCPuXS8d9c0k7+RT3oVf9eDtB6G1?=
 =?us-ascii?Q?o/D4vjs3lD01IKPv0yPjBQ5rHK5/kB+6fdcvmDVwiL1T1AnHH1v6bfLPbpo9?=
 =?us-ascii?Q?yyLyfdgbleGuXVGZ9/3YviD/2SAiEAUpHuOCJ1/3uNVUwwyeBeWzVizkXZi8?=
 =?us-ascii?Q?dTCGgm2bajpggK5I0v2DXZu1UY19DIGf2atdPdZO4qGjqBi6Z8fGL8ijdSl5?=
 =?us-ascii?Q?8N8RxWfqf8Fj1b0zQ1FKUMOr3+a0aWoGBlXwVD+PxCbh2jNmjSY7KpUyL45w?=
 =?us-ascii?Q?47aYfYDAicJajU3susbS5/Pv4UeVPoH0uzdsDKtaIXTBq1GI1J+Mb8sx3+LJ?=
 =?us-ascii?Q?RjsypqTH0z8c8AFAKmn164DVK9P/YqIp7ESOQwIM/ds0eV9B2dHenQATWY7B?=
 =?us-ascii?Q?byXLV2dgHMj6hDZ0/2bwM4Vf15cQu2zrnFakipBekCQGJOYV1sOUev1sAqV8?=
 =?us-ascii?Q?c7xk581bV4mgDxp2ya49LuGWLCvCtf5gQ6//0PG4HWcU4vciSRv7h1wkfJf4?=
 =?us-ascii?Q?h+K5LPfu3MX0U/tTYSMj5UlGM9uEqn8G+ptOgn+S+UbRWMQcUdwQYKN73Wp/?=
 =?us-ascii?Q?RopL1bEAhe01y09SIAgR2Bxuinf5/QyPtaIGB9zARQFZ6oK1tE97690I2Gyf?=
 =?us-ascii?Q?JUlyApKmujQMunNMJAbDZ9fDtUB/2qny7cCpxswHiAidk11IKyLQwsRz58PI?=
 =?us-ascii?Q?nPQAkmJmpEm2u0q1EEKWjKNpBDMFIR+exoeplVC3DYU2K3mMWXOLupjaOJat?=
 =?us-ascii?Q?t9tyAoWdRYQLcQonF7Zie6Wo8G+SZOc7GH3fogjiUMysk4SsWMPNSlq46h3y?=
 =?us-ascii?Q?FASBtBSX93Ckz4QS7r0r?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e7f092-dbf6-4107-6eeb-08dc72752341
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 11:17:41.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10690

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct rfcomm_dev_list_req" and
this structure ends in a flexible array:

struct rfcomm_dev_list_req {
	[...]
	struct   rfcomm_dev_info dev_info[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() and copy_to_user() functions.

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

In this case, it is important to note that the logic needs a little
refactoring to ensure that the "dev_num" member is initialized before
the first access to the flex array. Specifically, add the assignment
before the list_for_each_entry() loop.

Also remove the "size" variable as it is no longer needed and refactor
the list_for_each_entry() loop to use di[n] instead of (di + n).

This way, the code is more readable, idiomatic and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the __counted_by() attribute (Kees Cook).
- Refactor the list_for_each_entry() loop to use di[n] instead of
  (di + n) (Kees Cook).

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723725E0069F7AE8F64E876E8B142@AS8PR02MB7237.eurprd02.prod.outlook.com/
---
 include/net/bluetooth/rfcomm.h |  2 +-
 net/bluetooth/rfcomm/tty.c     | 23 ++++++++++-------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 99d26879b02a..c05882476900 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -355,7 +355,7 @@ struct rfcomm_dev_info {
 
 struct rfcomm_dev_list_req {
 	u16      dev_num;
-	struct   rfcomm_dev_info dev_info[];
+	struct   rfcomm_dev_info dev_info[] __counted_by(dev_num);
 };
 
 int  rfcomm_dev_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 69c75c041fe1..af80d599c337 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -504,7 +504,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	struct rfcomm_dev *dev;
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
-	int n = 0, size, err;
+	int n = 0, err;
 	u16 dev_num;
 
 	BT_DBG("");
@@ -515,12 +515,11 @@ static int rfcomm_get_dev_list(void __user *arg)
 	if (!dev_num || dev_num > (PAGE_SIZE * 4) / sizeof(*di))
 		return -EINVAL;
 
-	size = sizeof(*dl) + dev_num * sizeof(*di);
-
-	dl = kzalloc(size, GFP_KERNEL);
+	dl = kzalloc(struct_size(dl, dev_info, dev_num), GFP_KERNEL);
 	if (!dl)
 		return -ENOMEM;
 
+	dl->dev_num = dev_num;
 	di = dl->dev_info;
 
 	mutex_lock(&rfcomm_dev_lock);
@@ -528,12 +527,12 @@ static int rfcomm_get_dev_list(void __user *arg)
 	list_for_each_entry(dev, &rfcomm_dev_list, list) {
 		if (!tty_port_get(&dev->port))
 			continue;
-		(di + n)->id      = dev->id;
-		(di + n)->flags   = dev->flags;
-		(di + n)->state   = dev->dlc->state;
-		(di + n)->channel = dev->channel;
-		bacpy(&(di + n)->src, &dev->src);
-		bacpy(&(di + n)->dst, &dev->dst);
+		di[n].id      = dev->id;
+		di[n].flags   = dev->flags;
+		di[n].state   = dev->dlc->state;
+		di[n].channel = dev->channel;
+		bacpy(&di[n].src, &dev->src);
+		bacpy(&di[n].dst, &dev->dst);
 		tty_port_put(&dev->port);
 		if (++n >= dev_num)
 			break;
@@ -542,9 +541,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 	mutex_unlock(&rfcomm_dev_lock);
 
 	dl->dev_num = n;
-	size = sizeof(*dl) + n * sizeof(*di);
-
-	err = copy_to_user(arg, dl, size);
+	err = copy_to_user(arg, dl, struct_size(dl, dev_info, n));
 	kfree(dl);
 
 	return err ? -EFAULT : 0;
-- 
2.25.1


