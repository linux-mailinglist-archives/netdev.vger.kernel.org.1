Return-Path: <netdev+bounces-95784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15148C36C8
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93947B215EC
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3928DD0;
	Sun, 12 May 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ri0d5ptt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2084.outbound.protection.outlook.com [40.92.89.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28F1CD24;
	Sun, 12 May 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715523448; cv=fail; b=ewzbjfKkP1j7XzKQY0G6Ck21M/FD772oGjJxZlPrOdS0fZSu0C7CQJEpqwVjRqphLq+pchBconZsc4xq14iglrbH/0nrv0WAB6vm8Ijkw1peqwV8Ah695dJRYcR+TT3xZ8zNmMAdBOLUBKTbWiI/5k6nciINrlCwdsjDJwgxEEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715523448; c=relaxed/simple;
	bh=SDxCPuJQxzccP7j7GFZTyvx8Dura8z+EKFcFUzT5Z1M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JYvh0dwhFjKx85nLS8gLW4v9lcOWS0xI5g7SSsoZ0GZDatdjaYQRecN/gVAiGLvkdOqEDo2fPi42HwNm8ZL9eKT8yQpqtMcZWIjAet7+9nBnfKKtk79Bpeo6CexjkOQc/GOuOpZZgrnvwFtGWdoWuXcmbHRYEActqGcTMeqI+gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ri0d5ptt; arc=fail smtp.client-ip=40.92.89.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5fEaTVfB+9jU7njNjL81oTIOzvBpSgNn/pWL9dl7O23kYu551Yh+OUyQNtkwECt0ycN+d9K5UxkcXYJffNE8JVIiFjNAYt7PykQxsmXWhwimJmaThSC5qN/1wQDyhpAKS7EOob8wc6CKKZplzuXleZDgT/NOWhXT0eNSadAAo3vnt8bSt7ZXHiRsraER+eEL464UOoRDJu3pDHRNJvhlCtSQBSO41iv72I7BRaIZP5f8dyIplnGXRHh16ktW7OZo0ylmCrasa1FLYZxbCyf60n7mm4jP0wtmKJIo8f4Y6SqEdDL2h9PilrE7NW06duRRqZ1tO/iLExgKNUeZ4e4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWBouPzF4b80BabH5BqHI05RdlxGbJm9SEATh/MKdos=;
 b=O81rrAmH8szicB0AEvxxnkVHdT89dXhTZJDpj/r50mTy/sVtZ1lrJc4LCinsW8tyhXPSRxk4qnQrpSzjNA4kmMwQLpDdtoCcZsqvptfTKJr6Yn15ije+jgSKzH+U0BBx+cJlykBzg7cMTZNlq0z6i2IkCmbzNQxhpmlUzhNV2XvH5v1zQPxSsrZT2SPWVIGK3y1dJUvK/ZaaaJiWSrhaliKmdviLK2i+x82/25u4lWeycSLOfsO33v2m/QqBiDdjDePEccA8GCEN/50QqZndG3Ffoe7sxwDf5z7MpOmLLOwRMBkbjAhmxf6ylbyFueQp23eAZhNB3MxXd7HXhlymnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWBouPzF4b80BabH5BqHI05RdlxGbJm9SEATh/MKdos=;
 b=ri0d5pttn11MDWG+0vbAJCLbgTr7oPNnXuAKbUOGao+3j+7+6C9bCrIA+ClRYpA7klZbWrXLFiz0dnkHNOY7y7PJPWA4Qp7zxrY/rRHG9Nc6ooyQBN1A3HV8H18gP6fy2NIpdpwx+0en7WpYBMbdxOG/MJAyuzFkPOUKsSEFs23/WpKPJ/mwJrXdlbTdvly//Udw9JvvIf+bMDZ1FWJorD+4dBsPbPPXmtM6agoy58PAh39hGveKHUmYA9vutmc2PIApZr24tQa2s8zDBx1pIbyEjVA6AJRy2VNnCA9y/lzL4fr1AWFYCL0f0i5m5AC9w/PpY8YzaPgvsZLvWiy00Q==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS4PR02MB8599.eurprd02.prod.outlook.com (2603:10a6:20b:58a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:17:23 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:17:23 +0000
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
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
Date: Sun, 12 May 2024 16:17:06 +0200
Message-ID:
 <AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZUg31cExZR6tQc2OF0hnUJ/X/sIQk1jN]
X-ClientProxiedBy: MA2P292CA0006.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::7)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240512141706.6280-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS4PR02MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4dc55f-1fcd-4cbc-02f2-08dc728e3dbf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	BTZrkYT1OZkUW06Vd+hj0UW8mywzh+A1RcNelQlp2wkVnHkNQZZq5G8cgboxiwM7V8a+NpaTruTYsGhpVB1S11amWOl/XCFShF//Ug/mUHRqmYvSxzUT0iT9+/PmHiir7Twm89F4qu+CNGwfsUip5vorzT0ZFqoWVpAvKGHHundPqnxmKmtW/Y5+/eN/Ft5LGsOh2Dk6SmrJRxF5E9dtHQP/TSKTSorsfbHHasq1vHKyP7PNADzNBY6Lhp5dk3IaTwzRoVm6S9J+wePtoNAzIaUmou+jm8wBG1rBVZs8/iNcnXYrBW4j7g/VlZg+m4CzojHZ1gKATcsMMfEuD6jMIsHzzW7rWN/qPXAXZCz36fK7kpF3ed2r28k8objGJNjwY6p5HLzrUIKgRGySeZFWwk0LCKINA2sVSsbo1tuBREUyx5Er8FF2LCTKyI4TBn4IIVsgLjq+1vs6R8zmwHXbxROrvb3kD4naP9zLi2rRYWwhj4Ftwp4hxTm9oYLQXXFGM47Xi2pRYFJkG34CmdSW7dWQxVdwmUATOpNhBdlxkstNtuEM1yY5yqsqFcMpM3nd7lXVJx1EzoXepYktSivwl2hVD+LjMxfUpsZKrb0SSv4q0b8B0FfRIrAnk9UkXkkJAD0W2oi7tarlUV2IhfBdNSh73vYdN7PQSq2Hveu7dKlsIghfFumHYIm9wd3xiqYp6N0e9MS9YxBJHpGsfrZIhg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suOZYN5I6JW2Q2xl6hl5JgOlrABrdjIrjruA9IFJHnogcytQiV9gPWVhMkbR?=
 =?us-ascii?Q?tAN7zG8fGsevoXLytC2OmIg86ltNJj52tKCG6tOTVAGJGql+ijHjeMb1S/Xa?=
 =?us-ascii?Q?0APbHiZ7dom8UftNMEWXAD7KPpyVNpe22vM2DaJ+SiLpzshx1E44/jSNdzzF?=
 =?us-ascii?Q?MegcCzdfL5D902UI5xUW7az0qLXymPMo/NKwOP0OREkjssUSKriSbNjvWibV?=
 =?us-ascii?Q?+IWzCLuR9o521xkMNYeahTF4dwoHKRj35CV9N2t6epaFcgYUqValnRchC3tD?=
 =?us-ascii?Q?6Yptfvup1J5x01AYfGLBlET48zpbgSy3uiFOPZty+hjSMUgQYWJKjzkFmpC8?=
 =?us-ascii?Q?NLlBcJLMygN/ncMzfPP2skgEwQUmF0X9R9msW5YG+rga1mqBEL5/qj9LwEhH?=
 =?us-ascii?Q?KmFq7Ce/eICGOkyF9U9Cv8bCABueaahdC/zZA7NSpIPL49Hj4waFz48qOQeV?=
 =?us-ascii?Q?YRHHvzCdgPYOA1E9qsJ9R28WuWDz9kQO/0aRg1hvEvhpxsgw0sdHRNYzMbAf?=
 =?us-ascii?Q?r7B8olqa/j021TludxeRCDLeAX+PjexDXCAawWHUuApPPOfvd+vckq0jJ0JK?=
 =?us-ascii?Q?XjZWKNVM2/UeZy8Vs1PirXkwthHdOEB9SY2KbVQzXLe8DWtOUCJtZQcGnt92?=
 =?us-ascii?Q?1y4PTgvqsPdxE9/91s8nhIdBKMajcvQyxwewETcokKJKaHBW504Opa77r6WX?=
 =?us-ascii?Q?F6XenwW2pOSY5erko4ClU73b5o4w6+5M6rFlyZxb9DfYjm56rkoLE60CmfEA?=
 =?us-ascii?Q?+bFKAdIIL2DbKs0t7vldf2kub0P49kp30My924mIxGBW32HpDxRrAi7aejhx?=
 =?us-ascii?Q?/phM/psITLTDGd82U9rHPvcer1wosEqN3dHk99l0ixLQgQPYGviL9BdXnj9Q?=
 =?us-ascii?Q?nqcELWZVH3QEF3ypBvRQpdC+RRhn3ZlK2jcPtqBnt8a67OzLRmYkthhEh9V9?=
 =?us-ascii?Q?Y+ALVJEVlc1tnc7pbtChxatHaaTjmbLhX90ZI6UfW0jXxUa21f3ivxBwKWgt?=
 =?us-ascii?Q?Hhf/VCcDzlXEpu5rNAornuHEczfx6Z2BGqwP6eH7DBMB809To4+CakIqkTdr?=
 =?us-ascii?Q?h8DfusI4ldn2amlBvB9I4e+WHshLZbvr/6mLbjBhjb9J/Yxay0/JVwu2CKCg?=
 =?us-ascii?Q?uD4NZBqxTBCVOZeaOmqxUVaFrg+GO6VSQUeeCk/ldOgfpIItL4xBZQSNs8gk?=
 =?us-ascii?Q?TKE7QpNlekfk8A6qNOBv/sRF88ZyERGTcsBY+Gv/sGyWDzZSGXhVCHWyKyru?=
 =?us-ascii?Q?1F2b3VjToLF72MsC4Uhm?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4dc55f-1fcd-4cbc-02f2-08dc728e3dbf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:17:22.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8599

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "dl" variable is a pointer to "struct hci_dev_list_req" and this
structure ends in a flexible array:

struct hci_dev_list_req {
	[...]
	struct hci_dev_req dev_req[];	/* hci_dev_req structures */
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
the list_for_each_entry() loop to use dr[n] instead of (dr + n).

This way, the code is more readable, idiomatic and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/net/bluetooth/hci_sock.h |  2 +-
 net/bluetooth/hci_core.c         | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 9949870f7d78..13e8cd4414a1 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -144,7 +144,7 @@ struct hci_dev_req {
 
 struct hci_dev_list_req {
 	__u16  dev_num;
-	struct hci_dev_req dev_req[];	/* hci_dev_req structures */
+	struct hci_dev_req dev_req[] __counted_by(dev_num);
 };
 
 struct hci_conn_list_req {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index adfd53a9fcd4..cae8a67bcd62 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -837,7 +837,7 @@ int hci_get_dev_list(void __user *arg)
 	struct hci_dev *hdev;
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
-	int n = 0, size, err;
+	int n = 0, err;
 	__u16 dev_num;
 
 	if (get_user(dev_num, (__u16 __user *) arg))
@@ -846,12 +846,11 @@ int hci_get_dev_list(void __user *arg)
 	if (!dev_num || dev_num > (PAGE_SIZE * 2) / sizeof(*dr))
 		return -EINVAL;
 
-	size = sizeof(*dl) + dev_num * sizeof(*dr);
-
-	dl = kzalloc(size, GFP_KERNEL);
+	dl = kzalloc(struct_size(dl, dev_req, dev_num), GFP_KERNEL);
 	if (!dl)
 		return -ENOMEM;
 
+	dl->dev_num = dev_num;
 	dr = dl->dev_req;
 
 	read_lock(&hci_dev_list_lock);
@@ -865,8 +864,8 @@ int hci_get_dev_list(void __user *arg)
 		if (hci_dev_test_flag(hdev, HCI_AUTO_OFF))
 			flags &= ~BIT(HCI_UP);
 
-		(dr + n)->dev_id  = hdev->id;
-		(dr + n)->dev_opt = flags;
+		dr[n].dev_id  = hdev->id;
+		dr[n].dev_opt = flags;
 
 		if (++n >= dev_num)
 			break;
@@ -874,9 +873,7 @@ int hci_get_dev_list(void __user *arg)
 	read_unlock(&hci_dev_list_lock);
 
 	dl->dev_num = n;
-	size = sizeof(*dl) + n * sizeof(*dr);
-
-	err = copy_to_user(arg, dl, size);
+	err = copy_to_user(arg, dl, struct_size(dl, dev_req, n));
 	kfree(dl);
 
 	return err ? -EFAULT : 0;
-- 
2.25.1


