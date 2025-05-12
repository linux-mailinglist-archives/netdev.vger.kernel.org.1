Return-Path: <netdev+bounces-189759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146BEAB3850
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A15189202E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264D293743;
	Mon, 12 May 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7fBWiF0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D32609D2;
	Mon, 12 May 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055888; cv=fail; b=e3REiKROoeeFoLZH5IyMsFU9pUixiL/tJvRmslZk8yMWBlcO2BqTACUqHMGCxBlkfLHRXtme0YoMphdjNa80TjCVm+Ref+hDDrjPk3QVqML8fKYRi8VV4W8K5qL7dO26g3saDPGUGq3ccquaxnEv7q1BLdzmb0ABxVuSv2H0nMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055888; c=relaxed/simple;
	bh=6ddKceqcALtADANdTgXcr0giyuLxIaTHfNefiRPIzUo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SyFT3jZpow9KLqs3bpRDSXfzvY32FWyJFurnZ8v8tAUcNCGpZIJ1q8nxcpTFtYra0GsVi/IihPxr0420laNVMg8iAp8e9KYqLv95Ok3nR27g+cu+PqGMUQpnt9yx1U/QwjjhRhZedbXFjM2ua4xd4YAj0v/XvVxg4oEt0NqljNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7fBWiF0; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvD9NLuBobng1+mE6D45YEvm784meBn9P38zT76XQqNozARSy46h5ICQY+SvtC5KksqVnnDaefG6E9vuPSs0vdYtHUdnENQL1AMZNdSneRxdGVg+P0Rv1Pid/OFynG9XUgN9GtARdNZxy50rhvkbGgQG9GjFHdl/t6Ore8NrK3ApeF2wLW/lhGGWiM6WEIGTrbL0ZJe92TNXTtK7o8pkpa4dqq32QbIkCv7jlEpg9zRkN36q/8wdfnZxvfH9X8k/1GgKeP+TmlfCfd69vGAFPGHt+recVIeMJnR4sMjV2MG1sTWGtMnqRgHyEfut8glYsV+tl4XxmJP84oPq2NKJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdmpLh9tDvI8Vr+JAYH7q4woCyy5u2PNY/n2JW/KaSg=;
 b=m1Mek5qt4Af5pBoy5aQ7dsjZKQTXJLg+RKYjko3N504PH3OJy7GAhz571dnaQjJ89MG/E9mmanCJlZTCLYiYcAflKG/ZXnpZ4VMr/GoSVIg0yZip6EY6zJrQ41bdbgE7KE0hF8t1Y92/LLZ3hAYS0bdqr+5UXCvRYJBBP/fRAgx22YkHTkGEpbxMOYdPHX4VZS1qFqjsjke9A9Zvhlu/nOOyeQcg5iadbT8mUmAzqv+SRnb22LZCOihvCwBfgE2/AthvfmFtsQdxJ7gixbGP3jQ7JgPnmNRCPGlFa3pnvcizQseW1cMwn/sejrZuzHyCMWW+ETMvg4nQJoyUSEbqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdmpLh9tDvI8Vr+JAYH7q4woCyy5u2PNY/n2JW/KaSg=;
 b=C7fBWiF0vZFw5dl0H6/12GAtVBj2scKBHaV4DjqeOCDBzQGCzYjK8kUjHR3oz4gWXg5V/d2DN8PEHi6sMO2i4XTc3zH3T9dCFbWS8W7jPtX35MrRIba8UGRD6LSAdbWdT6zvoyRHNSGAL6Ga+6zREYDbGrtAqGO+kKMrF2A3MsY7gjTUYdsnhfxSIwXyA/sUkPr7cyOD2bPNmLpitNVFvsrMLZSg6pi/CFelMeIsGDA3jZq5YFMCqWut5T/XwbLtLalBoz5zNULjyJ9g+uecOiYPHLebfLCAguhyUfZNQlIJXastTGj8wveYOR9Ah1MlQ1K8q794OFgZdtlTXEDGIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 13:18:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 13:18:03 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] docs: networking: timestamping: improve stacked PHC sentence
Date: Mon, 12 May 2025 16:17:51 +0300
Message-ID: <20250512131751.320283-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:803:1::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7e3b36-2eb0-4473-2c77-08dd91576cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8hKz3WTfHBr+fkT5hxiiJaxhW8tPOrYhlbWpQkjpwiaf8akDNfdDv2yROg4?=
 =?us-ascii?Q?5hSjtnBZG65m+309TjIOzVD+2VE94Ool1FdWcVrsGHCRHFj2MHDlucpzSpAb?=
 =?us-ascii?Q?bhP4vMU3j56LB87yDsAYR2k5/M7ImDc92W8PVZ/em2S2sy7vvNmEzDO85vLr?=
 =?us-ascii?Q?5NNw08oeaQaNu9XLrCsyEEjPiQptHW62X8FHpYMPwnekVRNk49j1zT1931Wd?=
 =?us-ascii?Q?UWSDHB4W2j/OXX3GaMx62WUoqm7mYo7pwNmXhpDFsomZJjbT9tvqfwSSY1OZ?=
 =?us-ascii?Q?pqMDyXd3Cd2O2FJAyCx4KAdX3H0idM4rJCuYY0Zds0m4SVkJb8sZ/vjlXwvw?=
 =?us-ascii?Q?KQC9Gfi3IM/6vZ1jTqMDJJ1oaspzjQniR3QAP0LMpceXmr0HTXPISVjADaYv?=
 =?us-ascii?Q?xO+Tfdtf3PNCU0XktkzbKp2Qqq50DMkv7MgDWkh1IwFy584fkQuW+CyZj/yG?=
 =?us-ascii?Q?NIscU+cbqYrHaCBxCeTclaFiKIIP54yXslre7YmCs2sekAro26I05knmNB6W?=
 =?us-ascii?Q?tiLdPduK0iNABjIYIGnGSiUNjDvjZf83C2XmwiJLE/tpzO5X6cIH8wyTSkiF?=
 =?us-ascii?Q?jGVkhjf4R8BNz9Q/djNMl8MXOan0xFbjvr9PhWsdiHbpZLyyzULoZ2470jVv?=
 =?us-ascii?Q?hRMVgNBx5tbF7POFeUUbBev4CE03lRjudVUVpwG4X6ObtoeOwEY0z6D53gPS?=
 =?us-ascii?Q?1PqOBs4ibS7TYZtqiL0KQQy74QW5MRgg6ShmLEgEZQRx7a8RLTSWlDJLwri5?=
 =?us-ascii?Q?PGEIn0k96u73T+34s/HYi2lwZCPeDn1eT4NdA6KNzuk4DCmdnWFEfi2CHCqq?=
 =?us-ascii?Q?la8Y2JEiLiwaxyTU4YfU1o/pNz4O4UKeeNFcodZaXIiQ1WS1pHXyKOAqfFJo?=
 =?us-ascii?Q?3msJ5gBsg0OxCrfFyNUzF3dkxIxrmKGYe9iPRD158aF9MawMC7mfvVqUzH7P?=
 =?us-ascii?Q?eGdZqN18Ydp4tFYmyyNt8n56MSFqgm0opx6JNvnJkUN8HxtZ3ICByvxHqjFY?=
 =?us-ascii?Q?92+ocH8K5a26tqZ+d3oSXq2hpKA3rlGHRRpydOq721FHEuShtuS4lsMudZEk?=
 =?us-ascii?Q?H6PXq0hMGHrKEgtH/BIJ6MhZFpqwWMwPwZ6MxmZrSc1ay08hdRh0+JoyXfEq?=
 =?us-ascii?Q?nRRrHTuh3geL/glJDJkmVMkm6RZlIWno6sw5zuu2WO93pbA/PKPSpKqTaTQW?=
 =?us-ascii?Q?n+o0/f47/giVXHCImOWvd54Iuv4Dj2nnO5jLmnCucRkOi7zmDZwwVfsU1gtI?=
 =?us-ascii?Q?3+2OAbX0B5RrBDvZKhqdjPNpHVbrxdltp3FjilfvSi/crTc5a/htZwBaWmb3?=
 =?us-ascii?Q?hzPZERe1D1jY4eNAeV7Ndm3Cn/qPwX1mvD3PHr5Q7Eb6ahmdHBaoZH2NaDdT?=
 =?us-ascii?Q?AI9Bnw/cWS1kHtiE5aZosWbmKRNmT2BnfOwai7Z6zvzUcxW6E6nnXkeBTd06?=
 =?us-ascii?Q?jHnOGjidkwgXE31NwIhixciLa01z2ofmxbWqZLc01nL7j1rb2SMFjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDFAb5l0KXQ4TiUhql45/skFXVvSLcp5y4OFm3xPhb9n3jCpDh069oY2+nYw?=
 =?us-ascii?Q?xohJwCENAG0Tba3o2a/HWQQpVmeO2PIjiVFxVaJHlYsU/LO23nzskEZeW5x3?=
 =?us-ascii?Q?h0D/ShoElUl09ODMW26ejGmoR7oEZmwToEOUGn5gPr++6PhFz2IwnZ8nPB4g?=
 =?us-ascii?Q?QG5rpu8T87+ddXkYimeNSBiaOCx2cQMnNz7vwMIj/xvksqjkO1aC7bTRkM3I?=
 =?us-ascii?Q?yG1fmZX/kR94Fg3UeyF3mzxLW+3axHQetutFxElovFUoAT7Lyk1bP1cf/TGR?=
 =?us-ascii?Q?Ztxz5Mvx/DMQA5jZn6RFe11mXZFe1muFnRBUNpZz2m8ShyL5iGyxfDpg9nAu?=
 =?us-ascii?Q?pUIdz/HNkdXPZ9lSRXBbR+fZP3zgJ5KX/zbpq5zRfGbmf0tVzQMl3ISbOpFA?=
 =?us-ascii?Q?s5rZwtosegUsHcJGphlBx6Wf2jZ2dHMvvkx4m3nSfT3NulZEWCdXjEeqMh9Y?=
 =?us-ascii?Q?s9G4C1jsrokImg8pzWrYJIVUxZ7VpE50jvj2pACDQ0c5M3uvKHHiu2LAxtU3?=
 =?us-ascii?Q?Ay8J98Ksul9MgaclsJuXWpQMomRRKv+S3EdaAFNFX2CCaO6OxEFpFJv4e6LR?=
 =?us-ascii?Q?ugvWLGb+sS7Q+l1UjtrKsHjtWM1QDwT8cPfHzLT14LFElFmiT/fUU5+cRb3F?=
 =?us-ascii?Q?QTrPnC86oi+G70KD1ei9RlqdgLj0Ijef1fb/XGtsOdmsq58j/JYJV/VtZTmP?=
 =?us-ascii?Q?upJlwatMPknZElbhz/9OEnaDh69XRlVVId1jo9L7eMX1ZkzcVp+W6GgqbNEv?=
 =?us-ascii?Q?5sEzMqeEqrxRKOW6tXy1nzImCQIfgoGuUfy+EmS36zUmaVUdAWlfl48hURRK?=
 =?us-ascii?Q?x7Mhlh+jgx1kXiKm7zzJhywg924fhI1qwMz4qWkEZ4soNvVO9JTF24cxXG8t?=
 =?us-ascii?Q?+F4NI4HchQ8VJlXjdMmI21vjgcFpWprxPhEha/lq1p3Nhyu1ffQ0dF3iGyKJ?=
 =?us-ascii?Q?ww2bR85hqV/ty4Dwi0A0RMDmmJHORr//GV4bgNfpFiRoYKnkKnme66s2Nuuz?=
 =?us-ascii?Q?5+jT3KbARW75fTGrgoNGl2j4db0W0EbVCkBi/v90CVj8P9efsVdJ98+1ioMt?=
 =?us-ascii?Q?2EzFi0k85r3IdOGYj7TTZH0lF0xVk6p8KF537ZCzPT1Q7PGsU2kkURXRNHfA?=
 =?us-ascii?Q?dwHH0Sx4VwpwUq5QPcl1nzxotqT3RCWmhuUnSvSMqaPLXXtT0PlzIJuB0gF6?=
 =?us-ascii?Q?dVDCbMV+nej//KycpZcDzQOUfCh9Xfkc1Hzm/NeFhEFOnxehV7R1kEJCN4fo?=
 =?us-ascii?Q?0VLKHM0rSfUXpX9MX6xNvq38NSkSnn3TtidVXFCvtOVIPYjvxwoujs952614?=
 =?us-ascii?Q?yqmAf5cmufqHJNKVvEzdtyYoviMv4fW8/g6GaEUQuBZGEF3tIhZDfOIWRHCc?=
 =?us-ascii?Q?htc/D/iiO5SVF6pOykjf14dsJf3fL3XcOO+38TPwYijSg3QdmwUrp11tZhmC?=
 =?us-ascii?Q?i9+2u2OFRBZhf/7v2bOpJkwsAyPgTCnft+7hOHKFpMaO5sGBcHQ8zzKt9gsZ?=
 =?us-ascii?Q?Kdn5WXIpEWaFHdKOcHmMOFwinB8RyzhnXtS73bpXznOlZOPkjn0vemqJNfKI?=
 =?us-ascii?Q?NxLWZiwnZiQjcby4gtGVx7dSRx5sYutBXJfGqo1QYSCulWgimKFlyXmjRKN4?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e3b36-2eb0-4473-2c77-08dd91576cb4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 13:18:03.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTDBqXcOayFocnOudCg/xTbEs7NCK1RlDeeSw+egrwbNDjpghCjWnRHpbJIMkp/jc+jr4JB5xHjxxMQlWiVmXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

The first paragraph makes no grammatical sense. I suppose a portion of
the intended sentece is missing: "[The challenge with ] stacked PHCs
(...) is that they uncover bugs".

Rephrase, and at the same time simplify the structure of the sentence a
little bit, it is not easy to follow.

Fixes: 94d9f78f4d64 ("docs: networking: timestamping: add section for stacked PHC devices")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/timestamping.rst | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index b8fef8101176..7aabead90648 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -811,11 +811,9 @@ Documentation/devicetree/bindings/ptp/timestamper.txt for more details.
 3.2.4 Other caveats for MAC drivers
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Stacked PHCs, especially DSA (but not only) - since that doesn't require any
-modification to MAC drivers, so it is more difficult to ensure correctness of
-all possible code paths - is that they uncover bugs which were impossible to
-trigger before the existence of stacked PTP clocks.  One example has to do with
-this line of code, already presented earlier::
+The use of stacked PHCs may uncover MAC driver bugs which were impossible to
+trigger without them. One example has to do with this line of code, already
+presented earlier::
 
       skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-- 
2.43.0


