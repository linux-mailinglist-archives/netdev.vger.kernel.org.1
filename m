Return-Path: <netdev+bounces-242809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D330C9500E
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078F24E167C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE728643D;
	Sun, 30 Nov 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="izhT6vN8"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC328506B
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508673; cv=fail; b=Pm3wupoiJ92c6ZLFAaW68wloAOw5oLaI3t7V/ji6x9RnC8yJsepUuExL9Dn9DTao7M5VL1aUyUxb70cTAxX9h5/FBPR/SmWn4lLdLKEjiuyhF2NZ6uogmfIvbgjILvv12pRVe+55USKWOzSZCRd17slGdJy+kuKnVs8yCz4CanI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508673; c=relaxed/simple;
	bh=1ItFRJLCJfstVPwYNxEDheSPD3paEc2/Wx7dPlIlJ+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF2sogCW3g7HYyboExy+fYsojDCtdkBTzOpO4AdydE8fx4OLt98k2iS4bOXtHhwHbRpKFEUfWmg+ObACU1Oy5G/N1R8UeSSdCGdeCrV03drjXqOCIqsQvsSWM4HfZLTd2vfDLCZOku1HMu6PjelXq0p41Uj5Lf7RkZecppWnfVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=izhT6vN8; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4xX28HMpT5zG05aiXB7OUTXGHS7GBoqWdjD/VBlIVao870MgpXVnlfLdC0LiWoODXcsJOcBWgPxKprkOXxo7conjw+PYLVeuUUzk9ZRdHUQ329DZmsiPaF8VM/Tk3mNioH753Lx1t/vCxi9jyK+s+KxWxTCnYFAGsqUmJQaje+VYlWVf787vUBY5USQyvcjY3DrqlsFeBCecopZV0HidgYc9s6+cSrLgDZFdYpMvmFokeit3eXjREkJJrn6XQM9t4CKe8Cbyn8+/+WvX3xuqUjts/vVHRxafUNPSp9Ouni+n8JRnfFohRx4WBaosij0QUKbX4ZerX6FNisQPrdO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38s5IkkcOXHO+WVud8GCENyJqZPPoWiM4oyT0Jc9iPU=;
 b=xoZ8znLl3C1GRTbUfob9HpKbEacp/3whn/BEqsZYw7OFi5vt1dPppDzbYKTuRK7M3N9JwcqSCTR4Ha13LLEavuWUQiTJ8z8AANNjwZdse4Le9R2WQIoy740x79BVK1aD3NBBhGdsGvsjBHwreK1JVhmn2ow7W6bh3BYYAdJrXEdmvHSwqZHVEVvipwgdq8a96k1v3asfVdQymLTrU9+XpdPD1hu6I1OJ4IuGKJODZ/ViamRbmKIeYXXzaR4xRe6b2fIvY+Dsh0X9tda0f02JIq/XAs6GBhgbszA5Y2fo7Ds0O5OijdwJHs6viFbG4LjLR9JjSynoOxAkfohxk7yJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38s5IkkcOXHO+WVud8GCENyJqZPPoWiM4oyT0Jc9iPU=;
 b=izhT6vN8CqnQg496TCR354VzouIS0mS90hwvwpx0Y1kHd6hZzpnqwpZi0JOlRiEjE6WI32PJEDzgJeZ8MKDwCQ2zUXpL8Jp+hDOqGUvliovH+myxhGlPsKXAbp6Bo4TpnOV+YzIl9DKeacGaTkajJfL7dcjsF4M0WJ896HCQnf2UBKMVb//8hqbE8bLvLymJ4ekBuMHzLz9o/V4Aw93KA/ek/L7p5NCFSREgTM4UauT2PnDW6K0I0TSRRYH/AqyetlJdl/MAwJdHeMB8dhmrRSjP0CewAwv/xf6SYG76/8+kvF8c7KswKK6DpaRd2nQ1FRXNlKaVbWRLIWC3OTVI8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 14/15] Documentation: net: dsa: mention availability of RedBox
Date: Sun, 30 Nov 2025 15:16:56 +0200
Message-Id: <20251130131657.65080-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: d098a7e1-9b6e-4ddb-1740-08de3012d691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cv9os6rCuIQFKq6k1P6cUMSSKpDNuwKIxQzVhuLBtfwx3oAKUQakrspOpSL+?=
 =?us-ascii?Q?gOr/BC/5pKdqqYwP6iURF7yBA9WjCFgPXOD8cz26VrycqHHRFSuxITfYzgu5?=
 =?us-ascii?Q?1UsBWPDpQJrZMhEO2w4Klg9ABt9KzteCLwpkylfatZRJyUX4o7+8TGfldRQS?=
 =?us-ascii?Q?+ehO7MnSnzzbh6gsZLou4yU+/CYgBlzFjDenc8EutecXLR5v2HviP+FjrLMi?=
 =?us-ascii?Q?y/vjebRZkPxKCKSbutt0EaVJFXdZO2ZrE1UYLewgSszwyaNaBbIyTd7eg9KZ?=
 =?us-ascii?Q?FwShoGY/g8Quo9BQdQrZ3a26SYWoZosYEwl2S6gmuZnkl4vYFcaCHsgxpRPc?=
 =?us-ascii?Q?EYmCrDFgX5Lzpi96zK70nvEs+Z890z1NZmjUPVgbeENB4O0jQBe9OwIVwUo+?=
 =?us-ascii?Q?DBgqwUyZXnwfihc/baxk6b9HQZPB2tLNFhsXLO70vogb32nKOnhjAxB6uHzI?=
 =?us-ascii?Q?+mbTiRKFaSou0Tv/hPErkTpjywZf4aMl+YyntsrEkqbixiKTRrg+/F5x/bs9?=
 =?us-ascii?Q?TUMGQeuv+dA/DWisS3qyDLDW5fzwTQgjBK29LM2T68aJur58fcnKpwzWDH2M?=
 =?us-ascii?Q?ilkMoomZGaP2cFwL10v9uHul3vU4LWD174C9FcZiAyXMDKZsYNp2wZXKoI8Z?=
 =?us-ascii?Q?TDXacLEqm0i4c8807li0iZpLAVoUbMeJ0Cjt7IkseIfpgLX7+jeYD+lFiH4Q?=
 =?us-ascii?Q?c5hBMQDx+/cl/k4qkJoS4z48J8SbGDs1ytEQcQeSkVAXXTV0uqxZmaXF7WFI?=
 =?us-ascii?Q?ZZdo+isvDbXNLB9EWsIcuGDQd8ucvVrPhfSidBOkYSEnoy0m46X0c0AU6/RW?=
 =?us-ascii?Q?Z4DNKfeQF9b7SwmMPnoGsWRKb6fGdhBTGY4PQtuHC+KTa/whz40PRHEWHc2I?=
 =?us-ascii?Q?Sk4UtKk9/hJEqF45XHAyHbtdOxJQ97Mcs8ofOGb4aM4AjE0cCCsPpZE5vdN6?=
 =?us-ascii?Q?aPH044H0r4o3DGwtVLSwvJ0UGVNzAcDL5KJ0+HbnuS31e8spXShtsfPzyn64?=
 =?us-ascii?Q?Efg+2AGuEx4LKhD7+IRsUaj+PfiZkmjwheqoyfIOhLMOnwQEa4hhqw/bPEbn?=
 =?us-ascii?Q?LiGsK75t3P2XeWWDjFxfbVJIJNVy8B1edQEk/iIXMgIJ4riFFw2Mug9j3Otc?=
 =?us-ascii?Q?RCpajF4DShQhcT+lY+3d7plE+AJWHk8hHEg8fm9eF3XokkvuzJmmN2lWvw3T?=
 =?us-ascii?Q?S3bFET/k932IeTYJmmKjq5ysEXNg3hZcJQI8zIdzl5yFE/H/50iKusrWj3Yd?=
 =?us-ascii?Q?mAP1NMA3+Euq8qNFnvHOZODeV7xRRByZt0pf/W77trljfzmIcrmZmM0C70Tk?=
 =?us-ascii?Q?4BOcrHBMY0Z348lngoHQD1WIiNUJIfbtZUFL92Y4NdEdXWHKptIrwinbY+CN?=
 =?us-ascii?Q?qg6AcgJ97riJIg1w03P8epGhvQCCNrobY8AJ9+BjvBDW6yX2jVyFjw54A5Bm?=
 =?us-ascii?Q?Dhyc3fvUnp/lSK02tYqrurbuypRUnbGuaEz4nXsR6RHsV9fyKoeyQPTXMXat?=
 =?us-ascii?Q?lX8ob6H6Kzm60NWrRPlFpe0pQmrr7wVi6Gv7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N77RUPU8hUc4/NBhWubBQeNy3xkYb8Gg1DdEStMqatpH1n1pexvjMFTooj5V?=
 =?us-ascii?Q?44dvmI7PgnfcLNvKcJ4lmePpK4Y/Em4rVfYk1ht0Ybop7tCh8XbkAtjfASTR?=
 =?us-ascii?Q?RCyA5rY3wWxo3buZAtt1aPXZebYukuN9UmI9q5tUCS1vHvUIe1OL71hc/jQx?=
 =?us-ascii?Q?HCUFmWHTuCBbR+zaeggnsji942iOBVAiJI1KkOShqYOl31WkaQqWQQbzZ7KS?=
 =?us-ascii?Q?pDZUze4oo88VUqruzivH3uSUk/EbsJptOL9uti4aKAydrnrHWZUnQZHVLSDg?=
 =?us-ascii?Q?5wgbwfBBthO73bH6uaPf0bgd9jijhvmWHhQ0gfeGU6rSP/grOqwMe58eBdaU?=
 =?us-ascii?Q?s8S5yef4N5zNDCGfNwD8am2u5UnI/klSLaxglwqmgSKQstbMBRFhA3IJOG59?=
 =?us-ascii?Q?kF1fZ+VL+uCZnCD9KTXuC3Y/O4ePIJCno1LYzOgU01dyl0Dqs0FD90Hsjpw6?=
 =?us-ascii?Q?1hnGV162xaTCS1tt5k+UXHApultj4tjafjgYeWd4efdT1Cw5/ejY3yu4xMPi?=
 =?us-ascii?Q?R9nCPnJVkLNC0qlnMTXda0yt7XzbB72kQ6rLUdCxriqECDuBy8o37XXLXmc5?=
 =?us-ascii?Q?NntvkE0TuQPzxYWmi1E+pnHtAoAozQg7BtV/F31gYTGrAf7JkmTNh6gYwEaO?=
 =?us-ascii?Q?nq260QUAFAX4qS24aYazRTIWaJSn67ia7zTeoP5SGtZWuUXEHgfdpvsGQ/Pe?=
 =?us-ascii?Q?csKelIiK1Sg5ZZvWQwFnQuL+bmNLFnurvcYmT3FhG2Vx/5YCJXE0CNHZ3gSg?=
 =?us-ascii?Q?LaGf+Z7FRRUcsvndNvnYWi7HBQgezos6icb+3IIKJ53b4DWvRjjDANVQ28EA?=
 =?us-ascii?Q?icZjLw1f7vV6p7k/nfiUT7cef9JkANTOzqufjy4Zf0R3qaCbbwYmBKmxIY6s?=
 =?us-ascii?Q?Pu/6d72jd7dIaDhCvRbwgvRWWRw+Bj1guahSdTxkRH7LSdBlRY+KVrmR79th?=
 =?us-ascii?Q?l70s0ZJy3JJ+d9i/OGyGGY7i+14L/x+dIE8oa7B/ktd/p9ZCNZrL5uFd+ojn?=
 =?us-ascii?Q?JP7AtorNqgubmtHT+hXlkujn4VhyXB3Zl+zxjf//naN29B5n+4cn3fjNlU3T?=
 =?us-ascii?Q?BboHprSl/qdClfirqq38gpINFahSpSW3tdEJg6CVUQGQ4tvW4LPalTbY47pG?=
 =?us-ascii?Q?UcKVIKQq3zLgXB5hgRIt1WBnule6416vh1MQeDIczcx5+T+fg+sy0BdJ3PeT?=
 =?us-ascii?Q?hHoD4u0A8sD6kFs4YHojG3MWk6SvoTQOpKDpVKTArJUMkByLoXBg/zJDh3d7?=
 =?us-ascii?Q?vvJCMKvSK1XuQA22LMA/yixreMO+sG1DM5xCwmkZ8f2zU8D8NWSfBBb0ye2O?=
 =?us-ascii?Q?JHFa+4/ZtnO4S2YQTnbK8nHEeYHZUe8JQPg+1kYP4/d3V8Mz9/GtA/UatU/W?=
 =?us-ascii?Q?DECpfiIYogr3+vjQIxjsEwyvRa/5XbHc477lrTjcoEb2mgqZXVtPtqTDS5vG?=
 =?us-ascii?Q?Zo75AJhI2nNADSlcoblKZh+VHnAddAAH4Zkkp8mCLUj/wmiOuFb01+mF64yg?=
 =?us-ascii?Q?w9P/1YpY2DS/87W0TqgDpc21fEogRVxnwU3dV+3uPrswoaSVMyWQyBmK0AZR?=
 =?us-ascii?Q?Dz1LolvrA2eka8L/WeDqhlQDH4IlH3bu+eZDZ1cYW44VIlSqfyM/uyzN6MXM?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d098a7e1-9b6e-4ddb-1740-08de3012d691
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:40.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpkXjc6jmPQJquFLJwLJhIxSTsHsQnyKo12n0/ULYb6gs1Dhx4Ue12vvc10vjqmab5hN1TIxs6Ht9LqUeKeqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

Since commit 5055cccfc2d1 ("net: hsr: Provide RedBox support
(HSR-SAN)"), RedBox is available (including for offload in DSA).

Update the DSA documentation that states it isn't.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 7b2e69cd7ef0..89dc15bcf271 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -1104,12 +1104,11 @@ health of the network and for discovery of other nodes.
 In Linux, both HSR and PRP are implemented in the hsr driver, which
 instantiates a virtual, stackable network interface with two member ports.
 The driver only implements the basic roles of DANH (Doubly Attached Node
-implementing HSR) and DANP (Doubly Attached Node implementing PRP); the roles
-of RedBox and QuadBox are not implemented (therefore, bridging a hsr network
-interface with a physical switch port does not produce the expected result).
+implementing HSR), DANP (Doubly Attached Node implementing PRP) and RedBox
+(allows non-HSR devices to connect to the ring via Interlink ports).
 
-A driver which is able of offloading certain functions of a DANP or DANH should
-declare the corresponding netdev features as indicated by the documentation at
+A driver which is able of offloading certain functions of should declare the
+corresponding netdev features as indicated by the documentation at
 ``Documentation/networking/netdev-features.rst``. Additionally, the following
 methods must be implemented:
 
-- 
2.34.1


