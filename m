Return-Path: <netdev+bounces-85102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC389979F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD592846A8
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82121465B5;
	Fri,  5 Apr 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="DCLP9VQI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABB145B2F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305026; cv=fail; b=CNQh8dhoE215Aen67+n37bT4mIhx1V84liBs7hnkxTul2GnNyEIu3CYcIkyC25krEzpaprELnOaC9U9lYIrTk9Qmw4deN8fwdyjEWy3aeFNx00AvG+IEdZqNWSYb83gyk8d66TKVcs3hiAmtL/5QQsSBdA/eagpbDMu/crdTZWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305026; c=relaxed/simple;
	bh=wHR/qVd+ENdSfFMi4yzxWHex73x31JIdaA2BSPTN8AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqnbqnO39AklWJvfdld6aj3fyvw1EDomFrwyuFmuJC7XNXqaL46HCOw7z0AfN3IPQjfxyL4eE535J3FU1ZoshzXPTJsQ2v/wcfLVwtcrPergZbXLH43m/Jwn26WB/R1rQ6HJyjkgDAlhbV3JsPfsIPVD1vDwhTi9o/NsLCoJDxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=DCLP9VQI; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gljKtPgYod3xaGDQdDIUgAUhxZlG+SdvA6Qk5MOzsOZhDD17rQ8byJjrfguo4lmmnpnKeF5f/rUSfMK9jP0IkCwfjoC23PvjQxZ4KoAFuZjBtGx+9fKX2WIdWxcD113NeqV4DMjRNjb0FnxcZJDlv8LnLi8NVQftOTqo+iP8H1JPPb45Ha8lFFl4aEoOIRCLO6xYtrs+mcVww0yp9hVqenn4VfzJwnsRaEsc2jgUjBCDfFxeScLWyRa6Mhutr/2OjoAZ9nfnbl5s4VubBYxfEfV3GAxpC6cOKxrVRVFLMwxfDJe7wUIThf0+LWUh5EDvlVwpEY1VzgKbB4Usl0uQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2kHJyvDGKeWWeHWrgvdmaNDJgQjJmCKYdLwgYvWbcE=;
 b=AFyh9d68w+wC8FI8jlsOSgCSi2CCYFMhDBmBQ+kfEWEFP00iODcVYWVN8P2bNMxOVNLnUE1D9P7gFPCCZI/bwVFGUqcj0FJcR7kVH7HxsPsGFaAOM2HwmbFPFaC/0pppRryAaRql+3leSFQSZuCGjaKA8kdPH6sY7YZKbvrT0WNe3vX2tNxSBYrr00BvPldgvnMeRBwSi4mSSNeC+cqcanxquBg4eGJMZh1h++Ba/1M7YsBarylnC5GH2CzHyBD13D6qNGmHeGPCIxPpOD934Jeq2V7pBWjotZ2AyhADWDk+MWCfDMOmrXgBzAOM/+RPPim62x5la3TPtMmI4wdj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2kHJyvDGKeWWeHWrgvdmaNDJgQjJmCKYdLwgYvWbcE=;
 b=DCLP9VQIfBwEUyozm5oT1GyvBARkbezjErliioMOoXWrmDRnnkzGSRKVsLe2GAXNVxBteu8L1209yHRanqVnoXnO44B2ks47oVlfmFlAIOhxEY+9VPSF8287JCA5kdcLdOe5N4rfCU7tPL6wRSepMtlU4fDS0vBxERTs5VQtbaE=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by SN4PR13MB5678.namprd13.prod.outlook.com (2603:10b6:806:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 08:17:01 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:17:01 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v4 1/4] devlink: add a new info version tag
Date: Fri,  5 Apr 2024 10:15:44 +0200
Message-Id: <20240405081547.20676-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405081547.20676-1-louis.peens@corigine.com>
References: <20240405081547.20676-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|SN4PR13MB5678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VOhGgOZ0I7ZHl7SGP36R1HgvEadpWys1uM1JY4/vOBOuZy96y3SofuAna0I9lwzBLNAo8P6I0OxUHa+Quv7PfCRoDN9Ezis7hQsql7OXCjsZJgcgu1miwTLbTVZI1avODUBhBrO1rpCBQs1CNWX5gqBBd4uPA7k3iE7bJ7uglbcGAOM0KanCvalspHj80x43pspO1vMetjToPIUTvRSzX3f2pRSViRcQRBzED3Ktp+HIhBctwUwO5sRDfnBMe+K6YOK0OHuXfJrecFngeDH+qLmSN+joC+nWzoPaPlPQhxxXpEBFFW0s1xEjnwLmkBsVsq08eldubexGXassC8zFil6QnAhPqDrSliB3ToUYCaok/qxAei6kqE7+RSK/p+aETPHFgL7oclO3D8eQxff8BLsYgd7mF5c3nezipuf+knwyxWxlYyjanY/2WsDviqU2EYYcg+ieLbD5XVtuBZvhTswI82PQUoNUYHU1b0CmaIfDr0hJq1E2H/A9EsQtdjfhqqyaXBqjXAsSs5UUqwxpmm79J32YrivGRqVv2OPcIV+lxnWwohvysPHCMxLdAwToraS6JlGwU97Ojl/ECE3fuRtu4QwUXcjnV8m/6pblXFLxWtK5albIjpCxV/juwZp1zRjEE910lCWvXQQ6SObT2j1WFqrlIiyv8WT8OVRmmqQMMha/15BbFn0rP0RPh2flypRC8GaKseqFt1Sq6dwz+5LrmmMGmEue8PBSWiVZlm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?auARjjQXAt+5o7pN7SfUsDul6IT+ftMTtdypds0JRYXlfPWFJiVXukwxQX4U?=
 =?us-ascii?Q?5pMXFhJUfLlgUHoIV4LCgE49T3i7ecqivdqJeIXLTnk3dmNETWaF5Mb4rCRt?=
 =?us-ascii?Q?79IVOXnSc2vvEQdSm7KHoWbS6iEoGiYvTEsoxaCBWSzhGSzYVpTkkROc7Rzf?=
 =?us-ascii?Q?wIumvqfZi9xwsNteserFaiNoLA2KTwYhMrFINzpK8TtQ8Egl2D9ftsS1H8t7?=
 =?us-ascii?Q?XIg8GP1wi7B5vaxX7F0PWWg1hGQ6b9Amq4XGopVChKD1bMIxFHRaXQybmzJT?=
 =?us-ascii?Q?YRE8LSAcz2/Tya6pFygaQ6Eo8Pl/4URU+xfvhfzyqu9+e9srG6UluZfSshw8?=
 =?us-ascii?Q?vKNbLje+4+e+PfcInEr29utSA/iwC9bqb34liMuLQeN9lWp4RSEUJRvt5xeb?=
 =?us-ascii?Q?0gstvE/jGcjs6ehGGqpiKa8/RPTVTr7UEmsGOoKKIu2ji9PCD61ksknx1Kx6?=
 =?us-ascii?Q?F9RWOdd8RIQIPZ8vccEg/JWg0NOaK1GDbGaxWpl9DjNIR6g3hfUZS2cU99MX?=
 =?us-ascii?Q?SgTgEql+2ALRgt7eVGdLvQIuvBWEN6l8GcxTY/t03fvgHawaCXH6nmcwzJEY?=
 =?us-ascii?Q?oSz8ueGGx0wyUCSh5rgG9C7JSPNafokuTuPNGGRuMoD/1sNkK0XXzippOrNt?=
 =?us-ascii?Q?L2S53DOwt1FQZHCyytC7jAVjM0GLx9HdrM7Ur0r1QDmihRav2P45sTyhGGSF?=
 =?us-ascii?Q?FRUNTfbMG8Bp08XFzawXBZWaQfgZ0XtuqnD34B8wxiUcJ6d2In1JOmFzBoSG?=
 =?us-ascii?Q?q9W31oGk/2pc8qTvUJ+8Ix9re26xIahoG9Tb+3OmZ2zoSWnNrV+THt6mYQEU?=
 =?us-ascii?Q?2vRjyz4I0cGGA/1NfxZfOVGGxUINNoSPrqncKcK+Qd11mY5mGinnLQTMh8B4?=
 =?us-ascii?Q?krzdJCHK/Vlp5elRXJD9gn/GAy09n0H/tqIjx9F0Dz7ueSYt5RJx4d68TGJw?=
 =?us-ascii?Q?7Brqe6B1QbOQhnaqM2e+VY1nk1HP9UhCDWFG3QJqN+KX1FF04t2rB8uadXg2?=
 =?us-ascii?Q?Jr7ZFMxrBiyAGaNLovaIjuqrIV0ib9DDt/bHpQmp3ooM+Wavib/9o6Iyj/He?=
 =?us-ascii?Q?yigTgqjPnzO1wLY8/9zy6zdHtc80uTLRqbkfzdrmq8KWr/75C8DJ85xPe/NP?=
 =?us-ascii?Q?TxA/9PlpcsYtNMkiAlyVM/DUvhYTgt5psapmx16kyySLLZrvSrh30Uk/ZrFa?=
 =?us-ascii?Q?DzX68syhVH3dclmmBAmoKDsbwuJJy/TLC9D8EL0lRvA/PNDswxM9Ig0ff4Td?=
 =?us-ascii?Q?6e6y0FddfK9/LQpKRZuYNnQ+dXhiQZsd3DRvWVpzqqf/DV5pcQmOaMfAUSzx?=
 =?us-ascii?Q?F5mtXllc0lRMuoyphbO6POiJpB656K0hXZTRLD8Wn4oGYwQocO30+G65NFT3?=
 =?us-ascii?Q?z6e4fiWHeC6M4wwyyj6CHgsZNRe3CnFJnB8/eaqbTlKOkpBkDrisI83U0GyV?=
 =?us-ascii?Q?hylfOHZYsaAXI+GY7Y1jLX8dAgeBTc0/6ov/wlSbxZro2/j1iccZMerEKh3g?=
 =?us-ascii?Q?qaodLs4SHmx4lOPEe6xfXVcCu+1nrHHuyuRBgRPOJfjaikMb753dm2mw9WEN?=
 =?us-ascii?Q?cARVodIf8uy+43bBRjZ84eoBl+Rs1Q3xLk1HFdZ5Y047bpbs7840PTtH+3qC?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb23991-adc9-4084-0516-08dc5548c55d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:17:01.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4vFSkXcIz4NFbNNe19g2IhD8+2r7tsDAbtT5ZdLGeDwlkbHRN9J01TQ7ctNC/WLEsY93yo/KwaZUMP8TSqaA3xmfkHz3AsNSAOyZhKn/FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5678

From: Fei Qin <fei.qin@corigine.com>

Add definition and documentation for the new generic
info "board.part_number".

The new one is for part number specific use, and board.id
is modified to match the documentation in devlink-info.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 include/net/devlink.h                             | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 1242b0e6826b..805ee673113b 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -146,6 +146,11 @@ board.manufacture
 
 An identifier of the company or the facility which produced the part.
 
+board.part_number
+-----------------
+
+Part number of the board design.
+
 fw
 --
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..2100e62c2c2d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -599,12 +599,14 @@ enum devlink_param_generic_id {
 	.validate = _validate,						\
 }
 
-/* Part number, identifier of board design */
+/* Identifier of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID	"board.id"
 /* Revision of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_REV	"board.rev"
 /* Maker of the board */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE	"board.manufacture"
+/* Part number of board design */
+#define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER	"board.part_number"
 
 /* Part number, identifier of asic design */
 #define DEVLINK_INFO_VERSION_GENERIC_ASIC_ID	"asic.id"
-- 
2.34.1


