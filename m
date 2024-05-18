Return-Path: <netdev+bounces-97060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F28C8FFF
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5671F21C25
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34381171B6;
	Sat, 18 May 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kfAbA9P0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B256DF78;
	Sat, 18 May 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021076; cv=fail; b=dSWntf8c/CCpZlGvzZ3HhYDlj6kUUkXmQF8lUZSIL9AURa6f1+QcRIbEiCGjwuxWNYrf48L9TsJzKsOIMn3cWHZzAxodIKpKZbvqIBBztvHIblnn/K57t+CT4+qIotFIo3tTeAC/l7WNxbGiCmQ3MZi13h5tMVJankzfR8CpGRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021076; c=relaxed/simple;
	bh=3xwGQAhbXCFkf16Lz+Dc3j9Jmk0bi1L7YBYfT9VOV+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNLkqW4oPF/MeVeUdj6OjVTpInczErNx4RWJK+zP7h8TxV8EKhrGh32GCbh21z2IOm/gCrWYIgVywK14Tw848u/w054JO/nYEbvS+N+q1GEWOFwd2OlIQDsL9o61123ZMIyH4vXuAXomE9+gPSc5n3iE9t4Zs7KOnZJpXFLoTgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kfAbA9P0; arc=fail smtp.client-ip=40.92.90.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MibeWCed4wkxHJvJKHGY4I3nJj8xaSkW0wcoOdQcpcMFoRHtVGoPyJnjbnqS6EX8Sve1m1tdARsgQ7HyM+GDHpC73Xie0PyU/MsHqxV7L99FTMT/4schx8cBfl+2d7bqT1YC2aV05koaOWSltQlL3XbnYyGCE5lM+yK8Gz6JrAYxMcyU3Ilf6pq0WAYRCaYZ39oe4ow5NedP65sLxYScDytWQUOqMBzF3HRqHKborh6dnzQglFU9uXQCbpYQm8RqYaKji9kIes988DaPEL27vJTvMleM58lphMpypvsIfhrmar3KTEMxkgewFp9rfSH8pLLPo6MxJKm3QDWuuL8iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcAfl55zXsrXnU4v2nvZBkiomyDZmRSXbll/OJENccs=;
 b=kKpKHWn5e/cwW8hbEpOASqzwr6FIzork0kSNiPxreffRCshpJsEZTMdrpxFg342n8I+mcVvUAXk5CD/c3IE/oNDgKoDbz0X6rvF0730QA3jLRu+oUPvbt4j5406EKLHUnzsw+imxA24FalKkJERBWQ0kBQmyJEwvJeCZqMEZ50/7syD0ioCsSqzuqIyZaCe/z9h+fRmCfXS3VdeR+MfaT9OELyNGn3o4imYVZBwuzwFLErzTtKXNNlnMTw5DbF7e1oof/URq+7dq9b2qQ3EBEVLOmvQppe5q4VgJc6HOoqjUwK5oYUt9sz4t0G8FWxZDYqPOlf9mSAz5Y2+ZaDkCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcAfl55zXsrXnU4v2nvZBkiomyDZmRSXbll/OJENccs=;
 b=kfAbA9P0GO1XxqyVjtpvCipkB08ttlISzzVV4ItbzCHqNHkTZOVmbJDtDSUc171ggR1Qxtom7jtQTbMaLiye0meUzhbUgPs9hJbTukOkOYXlzItpwsMwPilHy16RruHVWlNmom42xe+5WTS8ef+Cf2MK1A9NccMTFzbQ43HIHke+8EhJE7oZSEkqDS9uXiN3UDukbKbknQ1UCyxnq9bNesmoEb4vKdIeWnl3aWzhN5YeFD4dOkgQnRPs+rUvZmAhNkfvidDc+tJfhVOM3QDEurPPud/e+mP+YmNs3/iuipUqmep8aikyv9yXVU2osxbkB+ygHX+OjpvVFHm43+ZCDQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB8723.eurprd02.prod.outlook.com (2603:10a6:150:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Sat, 18 May
 2024 08:31:08 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 08:31:08 +0000
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
Subject: [PATCH v2 1/2] Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
Date: Sat, 18 May 2024 10:30:38 +0200
Message-ID:
 <AS8PR02MB723788E9DB59D20465408A0C8BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240518083039.7202-1-erick.archer@outlook.com>
References: <20240518083039.7202-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [w6RjX6grYCE1Xp2QGP5TfHCf/E2U24ak]
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240518083039.7202-2-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9a60ad-312a-40aa-9476-08dc7714dd99
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	reBDTKMAWzcD+eqd8XvyWiyEPy2qDL9kW/jr75QZrE7q6EG4S9K6+cbUMndwYSLDQGOnPc/WMr6XDQJKKbQmZnfaEW/KbfLO6TTf9DpsWenuO0dxamBueDERz4exhSLDu/Iwrthm6w2fRg/iuQ5bGm2IgIeoW+NMcGAVPHjkaJ1rU0I9fePjvz64Yo6qF1T4vsgwF/bTYGUc9uTLnln/kZPKiggQMqjOhTq9gwK667zAXlTdkgHtPgxblj7s3jiHFAbVv4gxQnXlxLyuo0E4YX/7KkQNyN0HllduaNyXscZTxgrj2JafcG1FAZdLnbhaN75LuZBOr666QHHomUJ38lGqdnxR66BzjnkBq3/X6zWlzLuBg54d8SqD7b620RZ2Ca3y9JFb8EAPKFI3SHgCA9960OJOpMbZ6PjubYRgSqt17UuaGSe3nrxZApK+SXTqzXK0ufe3XTQcpFimRUowl/huvPPZKGkYiZ377XbDMHOcz6gyxlZ4xmWjYQMy/3qBfWaVhmHvff3HtbGYGF7n8TZx+powcd6Wnu/NxdT4PyHjrbwap4bhGZVjcn55S6BRjmue/cVU108DKFAiCv0nenIKK2GvsxPBbDpSCkHFlpvsshlPkOzRBOBtNsaH0zhTHFOMJ6PWipMXImV1KtFshhmoerOHe9RONXO9hZ1SBqVOqi3rirkRdMhxjl+cS2Rdb9YklfVDDhcbTyPoNEBTjQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0IDbNgqBvUXtLeBBw1U0xeTTjEFoYcB2/joMBQ00d3TsojJo9gsgMiWPOFBl?=
 =?us-ascii?Q?eNvn9lQPrgW94HedIllot7f+TdR96H+pi/8e3Eo+2FzMgEmmA17sCqKbqatv?=
 =?us-ascii?Q?CniZqMlF6D1bSXySgrmcR9y3nja9GBPI6kgsNwNOdRRO8z+Iss5iIzuOry/a?=
 =?us-ascii?Q?Tr0s+WPx9gWGvkUs20hwuoNbChXjzkv05qxY+gIJA+KhvAU2CscVV92Da+W/?=
 =?us-ascii?Q?OM8RF4OVphlMAR1CKHvNszdokf2+uZV/2fyYl6NYSy5q2b9dstuIxGl6Wojk?=
 =?us-ascii?Q?yUNO/6J8bwIgMQViifB7JmJL/EXgQnS6rIMTFL3I/w6+Dhs7FgTj5DUWsbuE?=
 =?us-ascii?Q?YQ/nZC4Gbn+R4XYLqsTaRU9+cBO/AMuAtWMxrwpRg868AX34mgSuoyjl2zc1?=
 =?us-ascii?Q?nYo1sCDpjpzgf7qYq5xZH/pCI3IluaeQagui4kfhfWYNUCAmG6PUfpTF6SYA?=
 =?us-ascii?Q?yqGxPAfUWj1DZGNMlmxwIJhd9eIUDGzirQfHU0eEm5x/lg8j0hConlJb+NxR?=
 =?us-ascii?Q?FGV9XeMrRBdEev8DG7ZkWSv0M3A8O02BRwK/JjrzlnrjWyb20iBysY1gnK0d?=
 =?us-ascii?Q?/M1Whx5ZxgxLxOXcFtLTo10J3mQk/aydysH7Q+Hq3+JgnzhT6DMLVfSoQ+1U?=
 =?us-ascii?Q?SuVX5SvIlKM6jeCiurJum8hDGjxbvLzmyMaILKFhENHPUVTf/dDl64G+6NNt?=
 =?us-ascii?Q?AMkwCYKjS15dYZEOJlirlY+FKar2mtXeGUHPzlq11f6DqLME/yXPM3LLw2D2?=
 =?us-ascii?Q?K9bGBI6MhUm9/JC+8xzv/R2W4pY4OTfjDz/E+EXE37phJgbWqjvPiIJkxzqa?=
 =?us-ascii?Q?0DQeRyqICXob/nwTkhJEMa8Tfdu59mca0eC/s8iLsUFZvnjuQx901zhbqFGt?=
 =?us-ascii?Q?sR8LhmYFZ5lxPaUyp8wYFZp/bb/H4LGkIlNN8dzvBOBhOADCFhwRE7RnQxRx?=
 =?us-ascii?Q?tLCrItlYLkhK1q+L8boVntXK6R3ca3pxbGpCxq0M7kwiNrFgm0Ik/hiGszlm?=
 =?us-ascii?Q?O8mDj4ah5GVShUVLZ4o3pvlBN5JyQnl302NKrwrXodmF8CwKodtWZnYsOQMS?=
 =?us-ascii?Q?OGIgRKX06tmSU5u5GMJPzKJQ4oCkMC0Xk/ILsJEzV0t1CVQAg6ISOUO2JEKI?=
 =?us-ascii?Q?YhkkzwZWcvc82qihupSoxMBdVBn+6JKmadti3vQVnuGRO9aDcayX1Ymqz+ZB?=
 =?us-ascii?Q?DpEs8DN31eyxqyaN+NOopi1p2PhA1wcQnBFbAAfgiBIC5K/0AMfOhrPjt2FT?=
 =?us-ascii?Q?UrOLsp7Ee186eqM6rD0K?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9a60ad-312a-40aa-9476-08dc7714dd99
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 08:31:08.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8723

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

Also remove the "size" variable as it is no longer needed.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/net/bluetooth/hci_sock.h |  2 +-
 net/bluetooth/hci_core.c         | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

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
index dd3b0f501018..81fe0958056d 100644
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


