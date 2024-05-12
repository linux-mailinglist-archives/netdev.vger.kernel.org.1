Return-Path: <netdev+bounces-95789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E38C373C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C631F2117B
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946C4595D;
	Sun, 12 May 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DtSVH2pH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2010.outbound.protection.outlook.com [40.92.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3C3E47E;
	Sun, 12 May 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530248; cv=fail; b=dncuEdTmBRM6leUjrfxIzPsRCZaFEiBzVpoAfKfo2PIZUWGkbro2CcdUkPPJ02PS1kqNvG0wQajUhV8qlg8sck9e3jZGAr6Rhuhp8bwqwYDtwgY0sShG3UkFbAZu2LLm/wdEMFI4cNhZaL4VItE1NXU4g0exonTW+8CU+9vvv/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530248; c=relaxed/simple;
	bh=cO0OyZ6+x05/ye7ybpX8g59fsXymBhI9Pxn7rRS1QF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dqSync6PfkVLYILnWQ+FuJdFpzrCMwOCTt3epAXa/e4sNfYj0ND9WNnTOnE1GfnvTWNcsBeo+PztnTOuamu7gdF9k1OhMGMip+zvPnvDfJhy9iubDgrMNvmX17/3AKK1pIphsvoJW4A9m9RYnX8jsLujWKZSlY8cMG8f2duc7ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DtSVH2pH; arc=fail smtp.client-ip=40.92.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuPvDlZYjb+VGyzLmNv8cEsQOIRX3qhc1yyp1sSe61YElsqwiIhFPOkt19QWkQR0V3qp8T7EzEaNijUB8X+Q7tF915/HUcX0nVZsQMu3OO/FfUhcX918vK6kMH9wykstXr7aX7FAc9Z0m7zoSEPFtPVG/4bp/3fO3qO/IMpQrclKbioa4t2R2mOl1XLMMpfABXsiEO3xU/YZV6G3x7qt5FhOCbw1TQTAqU+qhx1JH/Y7DBRUELSj3klVF5eWItu6UlZ0djgoIqXbYTr9TaTBbjgs/dF0hb1tQPo71KacsVdbHBHggm9vj2kRbdjSBLWJ2PZLLFLxvObcPSgNz8DrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4nsGLQ3NqJBCm58S+OTDBjY6/TebElea7qWCeysBJE=;
 b=gKB/aXAme466YR3tk27fQxHm1KgdydaluVOeRo03qP9ijncoAIEwGTDGTakAxLnYiE1FRfRuexdwvQ+0b75eyDj1E/kyfmIWbcPOY7uGvckrjy1WYTMR1jTB5yWXAMy3dMlMYY/os81zcnNAEzG6GO5ZvQld5n4utFBQYJ6SzwCYwt9AueLeoxTNILW3j+iiyWTGx0TJkGy22LBpCwUM4JJ6k7K0P6fcnXFGBtZGAFIjkKlAyPTb7hP01brhmUzf8mCO3m+jZ6vBJEG++h1IKxEmnlV9KdP8ALgcDY7/HOscKTKR2Xnjod7fFEekE9lVeHG5suKeflSTvgq4du/cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4nsGLQ3NqJBCm58S+OTDBjY6/TebElea7qWCeysBJE=;
 b=DtSVH2pHvWvEDJqt4Y77jvtwjtI/eUNoHwvbCtULSp+9x8lBDyhsMSMFEhmtdUGWqEjET4x4B3w1a4pBmCgvXQ4QOz6Z6sIh7Ld1EsSOnTFRfx3rpbr0EbeqthWRP2V6v05yohyTuJdoWw7NVFrErwvgPDq51nciY6J4fcQL7GOLNm31/ii09RDdiz277eOMD5agXNVuiXk8W1YhJcV9rwF5j0fEVicbcU4sMmmzOjY88HeIPFYTC7IefLUdYzwlmNlBNvWW4sxkaTz6LPMDiZCoj0mtHc9OZwGr4rnuwwVtNgaz/iLaeP4nT1b0Lzwb6flb+RTL26s2i+S0Zzg4OQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5913.eurprd02.prod.outlook.com (2603:10a6:10:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 16:10:43 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 16:10:43 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Taras Chornyi <taras.chornyi@plvision.eu>,
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] net: prestera: Add flex arrays to some structs
Date: Sun, 12 May 2024 18:10:27 +0200
Message-ID:
 <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [T1zVrY584MW8/ZGItUdUfhC6yAT54btB]
X-ClientProxiedBy: MA4P292CA0013.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::11) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240512161027.12752-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c97e6b-f8a7-4bb9-9502-08dc729e12e7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	fymZMMKbw23gUFgVwPx1K2I6X8EHvueJO2ISRTy2B6iUdjC200qLPmP/+i3Z4PcpWdE7gDCKsqqeZTmM0IB2Rkou2/JocrPag77pizJNY4QBzvFIm9yEZiYDh+hoBW+h7fdFiRlDnv4ztjHLvUQNg8l8/jAZ5AVw5dbmWYF3rGn60pqfjaOmmIU/T7PZy/oZ0sAvZ5I6qOJ/FR4gNt9M3UgDW4171vueSoSGIbgHLz+PqYec85fpbAZdjhzPbR1n4dOK+g/rlL3EtIQRsNbK6r6CVpsr6qklbf6mSYxHkVnDOL5p+yjYWC7xZNt8HPtbDwOYiZBEIGe9SVa0GVbPehePGiTZq7nXmU4yHSdYlYJz0Te7wf/xw4KXsFTGnu8B1lJ6u93QTRPyYuG3PiOGrnIvF+i2hNrbMsql4z1sJOjjZ7OmSjWYopCfq/71I5C44phytvKZhtkUxNfLabpTEtOxoxm4XUGtQuyLGwKC/F5khwtPSEH2+7g0s9FLyXzooRQ+G7jWfCsNsMNNd+XCCtV40YD5OMjDBDvCqZKxGL05DDvVbfhc0bmfOqCEIgPO6lhCOeGP2ZQIufrd9Gt9zhp0+WKwFDeXpaf7QBrFnQ/mOHr3mZpyEK6Xtpnt33Sk54d6Zzp/ArUzNBSSN6moXPgvACRlNwh7Cyb9PC1GaNSZHlOBdvlr28uSsU1wgb2X0RINSQb7WUKSkSt8krx7wg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VEvQHW0EciULOJGyFBygNoR6jHsG+ZLtw9YVNEKTulXJd3k+MgbjGBWpRedL?=
 =?us-ascii?Q?XGMxG+2rdqruuRv253+mBg38sz7CaBzkHCDlOS9m16b9PZyvmUjrnbCEjTFD?=
 =?us-ascii?Q?VBsBbUE66BV3U1yw/thSpe0nFl72Yk5f4Mw5K9tUavpATamuUty4QJ5ikF7p?=
 =?us-ascii?Q?zQFfHzPGYTzFGJ5d0J0HmQZucnt0y6W3F53wQb9fu6I5+GrMd/n04zpRx3xY?=
 =?us-ascii?Q?1k5qteKTYnBovQAW9zeZFe/0jehra0f/BQG5T3yPj7iC9+XakES4ycyu7/mW?=
 =?us-ascii?Q?npzWCoJ31d4HGgWYRL1Y7eF8IuNJLwJvObIlfiQVxZazJiyM8NmWj8UIUBoS?=
 =?us-ascii?Q?nQD/l/0EaTWJfL/HL3aPfbtkeu92VFiSprtsmJ8zm+erF0vKuhRR+jAB+z5P?=
 =?us-ascii?Q?0HqJfren/vYN5UJ4QTRVYG97y3jr7T3iSlD8GU1HP3o5qJWuw8pMZsTM+yYb?=
 =?us-ascii?Q?IpWGfV0EGRqf6bLqNgGgq8XzGHCVtFaYgqlhQMkWpxTUNhdDeqRNh3HU3/yU?=
 =?us-ascii?Q?+8y8MNbJRMB5FJkeoi8Javb8ivSq3g+eZv+WC3hXbjxBCA1hgUIXKYoM5D4m?=
 =?us-ascii?Q?HuWtuTmSFGz/qua1tEkVA9jM/zPMaVt1zOdq3tN/DFajirddMLgIpqvNzi3W?=
 =?us-ascii?Q?qu9M6BXKI5q1yqR+Xb/AmeNnHUitEmN6OzYX4IeLAD4IUaf05yEH3QQ6XsTS?=
 =?us-ascii?Q?/bYGvprld4bSriGEyNHLr1BHz0KGRXwSW7RhCNOixJRsXaf4cP0BJr1j0E4J?=
 =?us-ascii?Q?CbXFgit/rS3n5s/10dpgsacZ26eyBWBRZOkBmHQ519O35dE4ab2146GJAPgh?=
 =?us-ascii?Q?12vLuPAr4ChywBN8eLftme7ylONi2HPX2pinpIF1evayqjLie638zFMpslcN?=
 =?us-ascii?Q?LAkz3VNsu6Fa+Jz1wcyMgMIwt1jtpaXo0UUCEwWhYBh5wfpRpkqSIVvuWvCM?=
 =?us-ascii?Q?nz70PtrSnJ/Tt/4uer0c5kMu5+2aDkG/g/iwJinaKI28YhnPQ5B4w3g06gOF?=
 =?us-ascii?Q?Rv9J4Gr3msHIbwLtaMA39PSToiGEN3ANYY4AcTTbItr1q6MCHdANIN6a4PBn?=
 =?us-ascii?Q?hcx80XbGHDHYkvaHIj7uDNDEuhQsc2CAnHBnjbBW1djQbkiunCyQ6VaYx3ra?=
 =?us-ascii?Q?9zb6qjj2p0++GKVQptzMMjnP20dQGWqAK63PwsNvgS4ZDLT2h93UJSz4S5eK?=
 =?us-ascii?Q?PQTPNEGBZ1IcIVZdF6iD+T/aKPa6CAQ4iBoOvrl5kVtzVQlQZaZS83lTd+4Q?=
 =?us-ascii?Q?pxkt1/3sQgKGb2QLaa+I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c97e6b-f8a7-4bb9-9502-08dc729e12e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 16:10:42.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5913

The "struct prestera_msg_vtcam_rule_add_req" uses a dynamically sized
set of trailing elements. Specifically, it uses an array of structures
of type "prestera_msg_acl_action actions_msg".

The "struct prestera_msg_flood_domain_ports_set_req" also uses a
dynamically sized set of trailing elements. Specifically, it uses an
array of structures of type "prestera_msg_acl_action actions_msg".

So, use the preferred way in the kernel declaring flexible arrays [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is specifically __counted_by_le since the
counters are of type __le32.

The logic does not need to change since the counters for the flexible
arrays are asigned before any access to the arrays.

The order in which the structure prestera_msg_vtcam_rule_add_req and the
structure prestera_msg_flood_domain_ports_set_req are defined must be
changed to avoid incomplete type errors.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro.

Moreover, the new structure members also allow us to avoid the open-
coded arithmetic on pointers. So, take advantage of this refactoring
accordingly.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 .../ethernet/marvell/prestera/prestera_hw.c   | 83 +++++++++----------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
index fc6f7d2746e8..197198ba61b1 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
@@ -419,15 +419,6 @@ struct prestera_msg_vtcam_destroy_req {
 	__le32 vtcam_id;
 };
 
-struct prestera_msg_vtcam_rule_add_req {
-	struct prestera_msg_cmd cmd;
-	__le32 key[__PRESTERA_ACL_RULE_MATCH_TYPE_MAX];
-	__le32 keymask[__PRESTERA_ACL_RULE_MATCH_TYPE_MAX];
-	__le32 vtcam_id;
-	__le32 prio;
-	__le32 n_act;
-};
-
 struct prestera_msg_vtcam_rule_del_req {
 	struct prestera_msg_cmd cmd;
 	__le32 vtcam_id;
@@ -471,6 +462,16 @@ struct prestera_msg_acl_action {
 	};
 };
 
+struct prestera_msg_vtcam_rule_add_req {
+	struct prestera_msg_cmd cmd;
+	__le32 key[__PRESTERA_ACL_RULE_MATCH_TYPE_MAX];
+	__le32 keymask[__PRESTERA_ACL_RULE_MATCH_TYPE_MAX];
+	__le32 vtcam_id;
+	__le32 prio;
+	__le32 n_act;
+	struct prestera_msg_acl_action actions_msg[] __counted_by_le(n_act);
+};
+
 struct prestera_msg_counter_req {
 	struct prestera_msg_cmd cmd;
 	__le32 client;
@@ -702,12 +703,6 @@ struct prestera_msg_flood_domain_destroy_req {
 	__le32 flood_domain_idx;
 };
 
-struct prestera_msg_flood_domain_ports_set_req {
-	struct prestera_msg_cmd cmd;
-	__le32 flood_domain_idx;
-	__le32 ports_num;
-};
-
 struct prestera_msg_flood_domain_ports_reset_req {
 	struct prestera_msg_cmd cmd;
 	__le32 flood_domain_idx;
@@ -725,6 +720,13 @@ struct prestera_msg_flood_domain_port {
 	__le16 port_type;
 };
 
+struct prestera_msg_flood_domain_ports_set_req {
+	struct prestera_msg_cmd cmd;
+	__le32 flood_domain_idx;
+	__le32 ports_num;
+	struct prestera_msg_flood_domain_port ports[] __counted_by_le(ports_num);
+};
+
 struct prestera_msg_mdb_create_req {
 	struct prestera_msg_cmd cmd;
 	__le32 flood_domain_idx;
@@ -1371,23 +1373,18 @@ int prestera_hw_vtcam_rule_add(struct prestera_switch *sw,
 			       struct prestera_acl_hw_action_info *act,
 			       u8 n_act, u32 *rule_id)
 {
-	struct prestera_msg_acl_action *actions_msg;
 	struct prestera_msg_vtcam_rule_add_req *req;
 	struct prestera_msg_vtcam_resp resp;
-	void *buff;
-	u32 size;
+	size_t size;
 	int err;
 	u8 i;
 
-	size = sizeof(*req) + sizeof(*actions_msg) * n_act;
-
-	buff = kzalloc(size, GFP_KERNEL);
-	if (!buff)
+	size = struct_size(req, actions_msg, n_act);
+	req = kzalloc(size, GFP_KERNEL);
+	if (!req)
 		return -ENOMEM;
 
-	req = buff;
 	req->n_act = __cpu_to_le32(n_act);
-	actions_msg = buff + sizeof(*req);
 
 	/* put acl matches into the message */
 	memcpy(req->key, key, sizeof(req->key));
@@ -1395,7 +1392,7 @@ int prestera_hw_vtcam_rule_add(struct prestera_switch *sw,
 
 	/* put acl actions into the message */
 	for (i = 0; i < n_act; i++) {
-		err = prestera_acl_rule_add_put_action(&actions_msg[i],
+		err = prestera_acl_rule_add_put_action(&req->actions_msg[i],
 						       &act[i]);
 		if (err)
 			goto free_buff;
@@ -1411,7 +1408,7 @@ int prestera_hw_vtcam_rule_add(struct prestera_switch *sw,
 
 	*rule_id = __le32_to_cpu(resp.rule_id);
 free_buff:
-	kfree(buff);
+	kfree(req);
 	return err;
 }
 
@@ -2461,14 +2458,13 @@ int prestera_hw_flood_domain_ports_set(struct prestera_flood_domain *domain)
 {
 	struct prestera_flood_domain_port *flood_domain_port;
 	struct prestera_msg_flood_domain_ports_set_req *req;
-	struct prestera_msg_flood_domain_port *ports;
 	struct prestera_switch *sw = domain->sw;
 	struct prestera_port *port;
 	u32 ports_num = 0;
-	int buf_size;
-	void *buff;
+	size_t buf_size;
 	u16 lag_id;
 	int err;
+	int i = 0;
 
 	list_for_each_entry(flood_domain_port, &domain->flood_domain_port_list,
 			    flood_domain_port_node)
@@ -2477,15 +2473,11 @@ int prestera_hw_flood_domain_ports_set(struct prestera_flood_domain *domain)
 	if (!ports_num)
 		return -EINVAL;
 
-	buf_size = sizeof(*req) + sizeof(*ports) * ports_num;
-
-	buff = kmalloc(buf_size, GFP_KERNEL);
-	if (!buff)
+	buf_size = struct_size(req, ports, ports_num);
+	req = kmalloc(buf_size, GFP_KERNEL);
+	if (!req)
 		return -ENOMEM;
 
-	req = buff;
-	ports = buff + sizeof(*req);
-
 	req->flood_domain_idx = __cpu_to_le32(domain->idx);
 	req->ports_num = __cpu_to_le32(ports_num);
 
@@ -2494,31 +2486,30 @@ int prestera_hw_flood_domain_ports_set(struct prestera_flood_domain *domain)
 		if (netif_is_lag_master(flood_domain_port->dev)) {
 			if (prestera_lag_id(sw, flood_domain_port->dev,
 					    &lag_id)) {
-				kfree(buff);
+				kfree(req);
 				return -EINVAL;
 			}
 
-			ports->port_type =
+			req->ports[i].port_type =
 				__cpu_to_le16(PRESTERA_HW_FLOOD_DOMAIN_PORT_TYPE_LAG);
-			ports->lag_id = __cpu_to_le16(lag_id);
+			req->ports[i].lag_id = __cpu_to_le16(lag_id);
 		} else {
 			port = prestera_port_dev_lower_find(flood_domain_port->dev);
 
-			ports->port_type =
+			req->ports[i].port_type =
 				__cpu_to_le16(PRESTERA_HW_FDB_ENTRY_TYPE_REG_PORT);
-			ports->dev_num = __cpu_to_le32(port->dev_id);
-			ports->port_num = __cpu_to_le32(port->hw_id);
+			req->ports[i].dev_num = __cpu_to_le32(port->dev_id);
+			req->ports[i].port_num = __cpu_to_le32(port->hw_id);
 		}
 
-		ports->vid = __cpu_to_le16(flood_domain_port->vid);
-
-		ports++;
+		req->ports[i].vid = __cpu_to_le16(flood_domain_port->vid);
+		i++;
 	}
 
 	err = prestera_cmd(sw, PRESTERA_CMD_TYPE_FLOOD_DOMAIN_PORTS_SET,
 			   &req->cmd, buf_size);
 
-	kfree(buff);
+	kfree(req);
 
 	return err;
 }
-- 
2.25.1


