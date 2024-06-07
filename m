Return-Path: <netdev+bounces-101934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C24900A2E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA301C20F62
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07211993AE;
	Fri,  7 Jun 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oZohv1mV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2106.outbound.protection.outlook.com [40.92.66.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F943AA1;
	Fri,  7 Jun 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.66.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777177; cv=fail; b=dUhds8kFGftUSudpbGZIeFwiH/nRPVIAjT8gGNa7Z7EtF4pqb5RU1dZaMSpGJ0Kbwjnr7hMF68PoXEEaosvIx7QtDj8XLlr/JJDXnuePniLT8+XVwC5D++f2SC48qy7fRDiLVL/ORC9/BkIIHfU5abTgIEkekoVOj/rbsMOIq2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777177; c=relaxed/simple;
	bh=gGPvrfP2Q94zGjeEmigJOoi7Dm/J7+RsvxADT53SrA4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AH32FGXsLBRP1qo8L7/p7BwpqQ1z3UhfKR78jg4r7UAq7HB6A9XxG0vosF0wBfTBOxkpo3zXR3IpHNxoGLHuOmyxl1fn+ixQ/Lro+2W9zRjb4kW+Pv29e0GbCdfu0X3tAAU++0daCzDf288J4+5Qz/Bpl50FgeD+bO34q36sWRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oZohv1mV; arc=fail smtp.client-ip=40.92.66.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPqa7/9eIcFt2S4djzgLAMFZUSc6UYihEwQdTWvJsqYAY0yyxbTrklPGqCOm9E8iDUbfKaUPkPhd8itRsTbUTwR6UYRunJCOTUZyXJDPrvbuYMh8imnzIc4kKhxJ806xhx+RZImyWdn29LaXYeGijYEmDGhRyJAgUoMtZGe/eXOKGyp40K0scWSH+g/5H/fywSRhBybsSf3HszvntVjKN1Vxkodaqxt7DzM536jD9J7UyG8DnKjFUUHzxepHx27MJQ+JdDFS7XolAYpoNnYQ+1Aj8mbPwKw2aMhT0PhvD+c0ZLgloV9cz7EWGXQTXW7PjcMal41cVBfdGVU4twFQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OphJjwEnj0MJlUYtKz6Stb4+YWYsVDyxrR9KBxN3QGQ=;
 b=ak9TQQRWEVzRLVP+86YS+GzQELHNjWfeY1j4hnYky7qrRLUgMBhFMjNY+QD2iKbtGeRSBJt7GDkIH3hR1SL1CsZXSiG8yhIMIP0yed5mAg/jUTdF0pysoFQyB49FddgM2suX1T5ngn+FcHBddu7X/ljvR8aiEFeuZa1jJi1dSM+DMZafgGJSaurMrpzUJ5azTaTldZgatCRlQPal5g8GHQ1k/pfbzuku1k0vcfOMz2Q3Nyf2BYFLOfh3hTNolY4s1chVnj05v9Ycq/QbwLAUnmOpJXs6ikf6mnzc9nYrzZIhQHmfUGlyJd6kqyDuT7HZhcRo29cOJGgEl5MMwv9SjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OphJjwEnj0MJlUYtKz6Stb4+YWYsVDyxrR9KBxN3QGQ=;
 b=oZohv1mVDQb+j0s4GbdYo8TPWR03SAV3JS4nyYih9o/gSx2WV2r9d4BrWiFX84vXvDC7wZpw17wEzxog7bM6FPl2Z/bJ09rz9OHEhC1rtK4LEvuvdoOTf9JeEYTtVO4u4nX2UvHoB50SuEjv5Y3RbFTDekhkKHg04NvpQDc8HQqfhfAzgq31tnK2E48Tr6Bu9F+WWmtBuh76H3a/+icA1QRpaH9D55nNlwxDZmi+zkjkk/Id+4T0u+WUZJHphBfuqY6IXLndWJiRl0UC6/slOJJMxRswFGqSjVWUNzkpzuI2Goow25nCNV1zYrtVovi/M3cAN9okat5mUsf5n/ABRw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAVPR02MB9522.eurprd02.prod.outlook.com (2603:10a6:102:304::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 7 Jun
 2024 16:19:31 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 16:19:31 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Fri,  7 Jun 2024 18:19:12 +0200
Message-ID:
 <AS8PR02MB7237205E3231CD335CB988648BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QUK5acyw/AHh6uscIa1jzWAIdGupbCKx]
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240607161912.4318-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAVPR02MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f6bce6-0133-4cac-9bc1-08dc870d9c9a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	ESqNIu8Tz52C5p4PwTaCyAIBEQ3gXjtQA9b1XKqzHrcf9aGRVjOnQnqg1pBHMXnA7S1RnRo6jov1lFxhi6S5HNLZK89SaNGUGiuX57GK12BRyYFi6mgfSbG0r7wtMfPkgPxOby3obRnXPAREoodFnjB7+DxkzbGAOewo53S6x7JNZ59BHiY5p7xG8mKTY4Nm/qUYmbYDF6NwulqsOnqyJXcXbkbNynDX0bxSk5grvEGNMeCi6wu/1COlnSwiLvmExKFJN/uYlUdbxqeLRQBVHN9cNGhRjSL7aTN8eP0BmmX7+o8ovCmodEU9f53hwQClpjtoidRVmgDtdVl9q+F8DBS6gmfh9PNoc4ipXqpTYrMYCud2zDZct87SsX5sWq6TreCi3lh/aB1TR/D8zv+T5KtL37OHznc4wMfcKg7mcolBISRrlYM0YHz8+jig0h+Nr+fFUuMMMW5BzPRc+JK1os9mZ9Hm0ur8TbhoaUI9ViiTiqN9bDq46dngdAuucmlI8yAgvQ+lnMOuATzTiLKb6niT7dJ0gUEpW5OqOG9B+eZjEP8RjStPgn/OeuCS9WIg7jPcou2Ex7F1ezTepTFruaW8lmaCIThpejK9j7Nheh9+j0LUOm7wow3A0ABB5s7OPTpYEVbnNCUz/Xy4JWK5NnwIYj8CBuHu5xoGv3i4jqBjCAKWozStYt/ML7LBHJ290h1bsQJWJ5PnCg/Xn12Wdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIH8xXKzKpYBGuW8B1UiBWFeaQqZB4yM9DmIJl1kBOSEGDCjB5QpyDqheCHN?=
 =?us-ascii?Q?oobzOuf7KZYBKcZoYVjPATcV7uFk+eKjmbg+taWeySC4dFDTCenBA8gjt4a9?=
 =?us-ascii?Q?45Jprv4CLx6HMpwk5RlZrANfYW0KOxH/urnFpsxapCOijuBUJ1VpDM1qxRoC?=
 =?us-ascii?Q?7bmW2+UILY87GuRrh3BrUu88/ZPyrmo0JQQkhGhHXddyG9mGN9Fzpdw/cxdL?=
 =?us-ascii?Q?pu7BZVpNEJo1te1Bf6uGwsAge688xD4o6FG8OI2C9KKAxPlBevMGV78HhuRh?=
 =?us-ascii?Q?A1fqRh+nBZiY7C3BvO7YAeD7JGGE0Yxbt9Pcr4+KOGoFcejG05IYGsp7xD8u?=
 =?us-ascii?Q?r9xFbNAoXYKqntPqSQLxr55bs7vjj7vOMw6anfnz7AATbHoyotp/IJliKfq7?=
 =?us-ascii?Q?tB5rXfOpcYesatVzC52DUp9xhuG+8r5koxtQxXFG2icVE6lbqMtRcoTLPwNO?=
 =?us-ascii?Q?XER6JPod2cpagbGJEHz3p2TS1FwsVAQmiQXtyBflLtodOFwONRg6nsmZS6Qe?=
 =?us-ascii?Q?gstjsWQZzGV1Ek8QblV9YJDUpBkPOvlMQA5tY1jGBSA8yi7DLkmuZZBP53lH?=
 =?us-ascii?Q?tLAQgg/UYN44j2HMCxm/yqhDitfX6067WXnm0my2dAwfWX8CTC+xNss7/5Tk?=
 =?us-ascii?Q?DUA42/Hzs7eAY6RPzgf7S7rq+L+MJpnYxgKKDL+cD1ws7yPFqHXSYLqOsiwZ?=
 =?us-ascii?Q?8WJyMZDb+keSDAVZwmSlDgd75N+uGpDDNT7ddsizoWIKLc5HdPT313T/aTcn?=
 =?us-ascii?Q?gbJkbE8IO4tlD7+ejORUTr7Y7YXy9K3RUmkqYAfQ8sKpWGFqCimpGiq4Szga?=
 =?us-ascii?Q?TLGStaP6Gl7MdY9zJDHWZJtnkYd8w3Gx91+5jTgNhMISBsZ79VqqQIYxiS5Q?=
 =?us-ascii?Q?eLsT8sDV38/dUpiz93fG80Ab8Z5QEf3x6XV+rJO1pVo0I6G6ubACu25vWysv?=
 =?us-ascii?Q?exnPwS/Zu391KcDCB48kG+AfxssN0tsnAmTVgbDfgA9q9HCPzaR5XzYXcz2W?=
 =?us-ascii?Q?Tr9rHsg5fSY5gZRQvZDw18c4gY72FWv4RdI6riUVm4cI4dPrDHYln5PN1YSX?=
 =?us-ascii?Q?L3qO9JViKd+ohfjTUDbM8fL498N3fdYwL3NsLqs/3nNR3UtROyx5OaAOmz1+?=
 =?us-ascii?Q?71FZV2hW6gaWWusV3UnDFU76z7g57diQpvS9VhYSxIqspnCgCW6AEDwnot13?=
 =?us-ascii?Q?NheJdXvVBu4YltlEhXyMOlmiG76tAXWNffztb/ZjRdsCEDRCeh1zeefF/4Kq?=
 =?us-ascii?Q?eGsFDBGFrfB3n/gQRbg8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f6bce6-0133-4cac-9bc1-08dc870d9c9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:19:31.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9522

The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
trailing elements. Specifically, it uses an array of structures of type
"batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is specifically __counted_by_be since variable
"num_vlan" is of type __be16.

The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:

-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);

+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);

is intended to prevent the compiler from generating an "out-of-bounds"
notification due to the __counted_by attribute. The compiler can do a
pointer calculation using the vlan_data flexible array memory, or in
other words, this may be calculated as an array offset, since it is the
same as:

        &tt_data->vlan_data[num_vlan]

Therefore, we go past the end of the array. In other "multiple trailing
flexible array" situations, this has been solved by addressing from the
base pointer, since the compiler either knows the full allocation size
or it knows nothing about it (this case, since it came from a "void *"
function argument).

The order in which the structure batadv_tvlv_tt_data and the structure
batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
type error.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro and use the "flex_array_size" helper to
clarify some calculations, when possible.

Moreover, the new structure member also allow us to avoid the open-coded
arithmetic on pointers in some situations. Take advantage of this.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v4:
- Add the #include of <linux/stddef.h> for the "__counted_by_be"
  helper (Sven Eckelmann).
- Add the "Reviewed-by:" tag.

Changes in v3:
- Address from the base pointer tt_data to avoid an "out-of-bounds"
  notification (Kees Cook).
- Update the commit message to explain the new change.

Changes in v2:
- Add the #include of <linux/overflow.h> for the "flex_array_size"
  helper (Sven Eckelmann).
- Add the "ntohs" function to the "flex_array_size" helper removed
  by mistake during the conversion (Sven Eckelmann).
- Add the "__counted_by_be" attribute.

Previous versions:
v3 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com/
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com/
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi,

As it was decided in version 3, I resend this path since -r2 has been
released. I hope that this time the patch can be applied ;)

Regards,
Erick
---
 include/uapi/linux/batadv_packet.h | 29 ++++++++++--------
 net/batman-adv/translation-table.c | 49 ++++++++++++------------------
 2 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..439132a819ea 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -9,6 +9,7 @@
 
 #include <asm/byteorder.h>
 #include <linux/if_ether.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 /**
@@ -592,19 +593,6 @@ struct batadv_tvlv_gateway_data {
 	__be32 bandwidth_up;
 };
 
-/**
- * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
- * @flags: translation table flags (see batadv_tt_data_flags)
- * @ttvn: translation table version number
- * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
- *  one batadv_tvlv_tt_vlan_data object per announced vlan
- */
-struct batadv_tvlv_tt_data {
-	__u8   flags;
-	__u8   ttvn;
-	__be16 num_vlan;
-};
-
 /**
  * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
  *  the tt tvlv container
@@ -618,6 +606,21 @@ struct batadv_tvlv_tt_vlan_data {
 	__u16  reserved;
 };
 
+/**
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
+ * @flags: translation table flags (see batadv_tt_data_flags)
+ * @ttvn: translation table version number
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
+ * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
+ */
+struct batadv_tvlv_tt_data {
+	__u8   flags;
+	__u8   ttvn;
+	__be16 num_vlan;
+	struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
+};
+
 /**
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b21ff3c36b07..b44c382226a1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -28,6 +28,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -815,8 +816,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -835,7 +835,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
@@ -895,8 +895,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		total_entries += vlan_entries;
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -915,7 +914,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -2875,7 +2874,6 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 	int i, size;
@@ -2891,7 +2889,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	size = struct_size(tvlv_tt_data, vlan_data, num_vlan);
 	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
@@ -2903,12 +2901,10 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* send all the CRCs within the request. This is needed by intermediate
 	 * nodes to ensure they have the correct table before replying
 	 */
-	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-		tt_vlan_req->vid = tt_vlan->vid;
-		tt_vlan_req->crc = tt_vlan->crc;
+		tvlv_tt_data->vlan_data[i].vid = tt_vlan->vid;
+		tvlv_tt_data->vlan_data[i].crc = tt_vlan->crc;
 
-		tt_vlan_req++;
 		tt_vlan++;
 	}
 
@@ -2960,7 +2956,6 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool ret = false, full_table;
 	u8 orig_ttvn, req_ttvn;
 	u16 tvlv_len;
@@ -2983,10 +2978,9 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_data->vlan_data,
 					ntohs(tt_data->num_vlan)))
 		goto out;
 
@@ -3329,7 +3323,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
-	u16 change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3342,10 +3335,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&orig_node->tt_lock);
 
-	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
-	change_offset *= ntohs(tt_data->num_vlan);
-	change_offset += sizeof(*tt_data);
-	tvlv_ptr += change_offset;
+	tvlv_ptr += struct_size(tt_data, vlan_data, ntohs(tt_data->num_vlan));
 
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
@@ -3944,10 +3934,10 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags, void *tvlv_value,
 					  u16 tvlv_value_len)
 {
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
+	size_t flex_size;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < flex_size)
 		return;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);
+	tvlv_value_len -= flex_size;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+	batadv_tt_update_orig(bat_priv, orig, tt_data->vlan_data, num_vlan,
+			      tt_change, num_entries, tt_data->ttvn);
 }
 
 /**
@@ -3998,8 +3989,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
-	tt_vlan_len *= ntohs(tt_data->num_vlan);
+	tt_vlan_len = flex_array_size(tt_data, vlan_data,
+				      ntohs(tt_data->num_vlan));
 
 	if (tvlv_value_len < tt_vlan_len)
 		return NET_RX_SUCCESS;
-- 
2.25.1


