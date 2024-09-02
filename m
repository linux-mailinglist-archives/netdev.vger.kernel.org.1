Return-Path: <netdev+bounces-124096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB4967FA6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9C61C20C93
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5A15575F;
	Mon,  2 Sep 2024 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EWHcWM9A"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07F152E12;
	Mon,  2 Sep 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259715; cv=fail; b=FsC+0BjS0dFljh0EUof7TV5Eo6e6r6YjvodF11AlYs6WmQQdVffcoHZ4IzzxHS9ZA9kLfpNGcrrPMm36VsJGYCLzJpXnvI93hmGCeq3YGUuprbK5iCKP5XDIUwbV4s//XxpNf3i0q2vnOjD4oYpElQRjAC9PlkGrkJrvihdepEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259715; c=relaxed/simple;
	bh=swec3VVnW2MkGw+0EpLE7zqYURw4O8WBQEBoach+Wuc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WvGVgk4SK5muJ94L/O/AEQEz9T5yrO7cWwZEkxaOg6aJ1nDiOlfzcYnph2ToSwuthf9JmQZmvaMtKVrkSNLpwEQGRc7Z4+Pygm285dm+vrBrrf82U6Z2uU7NJo7d6ZYMNaYMd3AL2x57/7/hz8P/h4FozBj+bDzpTSM6keIqnHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EWHcWM9A; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otNEJDk7/cciQUlHmBomM/BYliNZZ2bHnPlCvjevOgu+ozncLRj7CLS95CpMwwM4zC5Hd9PRekS/AyXpt1nmnHGjDnBoi8vibRgTC+Da6/1CIQULyIIJydaDSbu+pZxOyZduvNLZaTX7VUxnhYW1uZkQHnVCnVfD+EQxkrrGppfnDlMHq4773i1G/TX2/lY5VXKtCyn1JrVqxhVCp/75H9MiwtN8Ek3yjMGJN/3TWUI+05GVROq9xnjg/R3+sseB1gGapMqkg0bkdiH59NgziHIJvSA7JBRCyoca8TFri3R8sWpVsJntRBl5v49dcw7iUW4bnMFznXZuHXW1m0A7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JdWw79tkGJbFY8WcpZPZ7Z4lxBbCSOEu/K0yuJdu28=;
 b=QE2xbYNqhDmIlNMuthM+DiJQEA5pOBqNBb5BH7tKaXuRkGK8XXwZn7Q+iobco+OQmgBXvmpnBJJ1lo+6dzxvYXOb/60Y+gV3gJgd+eaG2yGs4uRD4vvrMybj5TJBMcYbh6wnQ36UFvoZX9+HUmBM/VlQJV9w2hiDx5AQaDz09JIjQ4iG+lP5CcuflRX8xC3uunbh7AF9H9jH1XwD2jBh6S9l/L6G7/k8tiBWAUkb+W2fENTsaX2Lh9z34B8Ct4uZBx4yur+dk4tFFKZWtBLzVuKHMu2o0dGdIYNHvz7jl1+j/FMNFciYPWGrb9N7Z3I6200qcHhBowELbdEZBpxN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JdWw79tkGJbFY8WcpZPZ7Z4lxBbCSOEu/K0yuJdu28=;
 b=EWHcWM9AR37IX3nlOqxuzNbv/XGM/42oRLwIxeW/76DyTgjY8T3Vj10bRmQAR7i4HZKJ9uCn8pTWrtOxUYb3eMZ9jP4/wA8avP08hVGeAtZx8tWmK6rNet/3kVdjAIFcXAFBVJMXP7apj7oB50nXgQLimhGXlUspCg5isy+h0V5aQ1iR+Bl3GxBv3ZOXwFIG8wtA5VlNF0r+lBDAYnzf8WIUD4k48ww9vDl9pSCeFaFe8AYKaFdGdI5P6Gn3yTfFtULP+hhFQ4R5B/NIaDkuCY/I8HmgiGQ7jX++QH+jl5yVsYcobHDtys+YgJHbXk9uXpOq4M3YZmsdGAs+D5KmkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:48:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:48:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Date: Mon,  2 Sep 2024 14:33:52 +0800
Message-Id: <20240902063352.400251-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c7fd1d-e03a-4b2a-ac9e-08dccb1b40ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I9tL4McOn5t0Vkufzsx0vzEewO7Z7ViQ1ir8ikMVbyJNesN9UVXpsalig92S?=
 =?us-ascii?Q?f/tuyg2QsweP0Y0zxyH2kSjL6v8uWP+nMtWtG3uPNqxZ2S8LN6muWyk4+k4j?=
 =?us-ascii?Q?PXj0F8sIk2PGbXjqHRJQoXabK+d7BirIVQvOnYCWihPzMerx4g4D006U53Bn?=
 =?us-ascii?Q?A3Z3WY8hxqSThZvTYfgTn/BvqFHX018ti+lCl9rtd8sfhVgotK9Q8kBr09t4?=
 =?us-ascii?Q?cMl4ymq72ukj6jnOHvcaFvlys7YJEgUMtpTWT5Bjlps9MVn1bvycNfeVaiZk?=
 =?us-ascii?Q?UM5Rxn7/Am93pkstt4UnDSrEK6HAGlYb63W77EBtGDjZ+vsWGl9N6ak4G5hJ?=
 =?us-ascii?Q?EYdPOe9c3TwPdj4wIRa5juyDfMwhaNtQxQrb8NnQQzidHGCTLmYkfGVasMak?=
 =?us-ascii?Q?PnqxDUE1WaJ4LC27FkRlQahA63AXWl+rT87vvz9UrdTJ1pU61A6z8pqDSS2F?=
 =?us-ascii?Q?R7Q9Osqu2V/o/Qvn5x9ZdVObFDRBuPJaHlUuiuvl6u657vCSnNivNfhSeim5?=
 =?us-ascii?Q?UQL7slTSIgJb5sUJtiysB9Azfkgcelo6H6YakWIFExJKmnySMuz2MfYjCqpc?=
 =?us-ascii?Q?KSXTOQc6sOxFj6bKNoNChdMxvziFbK6TgBvf5/cvWAgUm+wfgHmTHNRwjHs4?=
 =?us-ascii?Q?EMPqVna9ORXWPgaMM5NCxeCShhCctKg3+OdArBZDJzyiWAiXHzuOSY8V3CeB?=
 =?us-ascii?Q?/iisZCqMz66SC0YWqFULIgeBLys7qnC+fsEdOYgwfEoNdNPRR9fKVnYVNTxA?=
 =?us-ascii?Q?ZF8jCpooc5vR386xQ5eOQnQYqHoHk7K2yGmAXNWjuSLHYgKnUxzGX6hlZyBL?=
 =?us-ascii?Q?cUx+E9XhkIrXyAWT4l5+qr1y2hrQqX8jgpf0S/rr0Z+bP0e1iCCkktdLV7/P?=
 =?us-ascii?Q?xASnaDtKRjFMyva3Umqg0m9ZwxAN1W9X6P/kLoRBdsBRtg/vnt11p9XeKo20?=
 =?us-ascii?Q?uNwhKHBtRSjFTWJCGB2biKXW0pTlavI0tU0SjIzqSB8hIffS52uEJvCN+SW+?=
 =?us-ascii?Q?EgANHL6cOzyFOspl/l4w8YB3aHmHRjxcGc6mpH0oAjiW+PfBACfELPHi4sx0?=
 =?us-ascii?Q?GRSzwUsaAoDhkVpRKs+/E1Pb3zj/IgJSdNVawphHgbqhCrrUWtndxrz1359b?=
 =?us-ascii?Q?KS9GaSRcUJWryJLT3CSoLpFStUSfRY62vmPbVNhtfY5mk8EiMtX3sNvBjn+h?=
 =?us-ascii?Q?SuX8/tjKzls5j2AeVI1PN6u0KQmIXhy3xYsAIZtndQWWEk58iq37+PFwqBtu?=
 =?us-ascii?Q?MgdxG14dBfj5wpydBQabgo5xmT3WmMl6BP6QdU56hrFrWOyRxkjkxppn5yGe?=
 =?us-ascii?Q?lvu2UNErgX5oaAPh5f/HpyOoSaYFYkXs734C0qRvBOvRg5UB9DfszFCamBh5?=
 =?us-ascii?Q?BbJ4TgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0oXz/Ge/EC7BlGGOtKnbd00298hWja0MaYEOSYyTWB7WGx9Fv3rK3GxQtvI+?=
 =?us-ascii?Q?fezJsUahCiSJkT9KyWKUmQrkRgeWzwdvUrc5rtx/adwT4ljbOIXXKlnIeT/m?=
 =?us-ascii?Q?rlAcbexKvD7lkXoiM/AQSwVebJvfSnnlOANqz1qJQg21YApxX5Ff0VlAwkwO?=
 =?us-ascii?Q?18dFPZ9ZYLbp4tj8apvBJioWXa9oRJE3MvSwXnXOA7vM+KkNPqMyzZY+XilH?=
 =?us-ascii?Q?p8lH0Xym0yt98juwaqSj/RQwO49jbhCYBaEJWPF08uX5AbJuudXuJdZLq8wd?=
 =?us-ascii?Q?jW1mqHHykMgdh/NBFUwEz6NFZ0xJl/Q0upxl40JcO5doFjkQO5VPI94/Empc?=
 =?us-ascii?Q?cfy3i+4R9CIzrJrFJqNgQ+19CyotUtILRldLNJBd1jj8+L1Dy3Tpq6ciWBye?=
 =?us-ascii?Q?QMPTjXrQueky9sZUN80XjtKvIr7b+9tJAxFmZ4OD5ScKGFhhN25g3v9irFwi?=
 =?us-ascii?Q?jais9FnY32rBHcqc/pPQbgMFT0yDMqiZZV+Yzw3RSCVztTEJBVNIfzLKnEZa?=
 =?us-ascii?Q?8xWzaOTEpd7UI9GWZ/T++PX+/oZsYNpNkPMWUJG1gmf2UmsnDHGrsVOT+Toh?=
 =?us-ascii?Q?cRRn6gZVBuOk0zljX7X1C+QwOq6QD68goPc28mD5A3F9k/DZGv9gx4ijdglT?=
 =?us-ascii?Q?OnU1MhlhOTvDaVBmZ8hfTSNnKizRbZ20cWvXjn+/qvEau0uk00KinFwv6GIz?=
 =?us-ascii?Q?3s7eJMbYWa5VptKZovtEPORilaQe00iRhwg8xpPWz+gsOd85f9G69YNOWhKh?=
 =?us-ascii?Q?piCrt3HMVbQbNO0hWOtNXwRa2+Bnlj3HyApoPwsd2CEAtkpQyCgAyutQy91O?=
 =?us-ascii?Q?06iDIRrfxknXTqYiV0MJYZt6A7MvVuDRp2Gz+kslQF68vakhX/3pIhND2N19?=
 =?us-ascii?Q?y9kYkwK5KBEA5fJ3ufa8Mlk92aOk67ZXzJwMzirXV5V9hEmUyc7KPqmZgxeJ?=
 =?us-ascii?Q?Mg9dONQRo5eCxLB+lsk0nNwnuOhrd5h/di2dVMDyeNd390QoZV8yUrq4ivKn?=
 =?us-ascii?Q?pNeqc0WexDm7wXmYzoM3ha5YSSZvuTpsRaQM0rVAAYavg/aAkmYWglBx/a6O?=
 =?us-ascii?Q?4ZcXUjnsfzbRujb/NOuFnkw25R/6YB3sb5Q75mZJBAUepxWxTUviri22IeID?=
 =?us-ascii?Q?rePMd6Jvls+TYSkflCmE+ncdnd0O+UFw4WHV0rFT8T2o5iwqtx1blP/NAhOU?=
 =?us-ascii?Q?6L0gB+WM7CPaGA87UoPO5pyZfEMYcxwzlIIKVJlPPaqoO6VUMr2xPYe59w6G?=
 =?us-ascii?Q?PUJmuOnRjqTQfxSewl2g+dSXKa6ZsNjmxCaoPwd4c4YXdVjzUuZdYPDxSkgG?=
 =?us-ascii?Q?TJGD6ydNwgPEr2H+FcdtYM9Mf/aQcUcNwM2ivlsf2Pk5n64gXHns0s6aMwUx?=
 =?us-ascii?Q?DfkdXNZkefd8UJoAPKmz8LiY98utGhefjIdszGu07DJAbvTgf8IHVD/N7KJn?=
 =?us-ascii?Q?i216dG0s273iY3QMnpR4xsw0LFCkQO695j/xCoq0QViudBiRx9at4zOGS65S?=
 =?us-ascii?Q?5NLpbEn5vF2fWxBDrqcC9g8oJG3TSF6QJJTm22MeX3aTyhIlxMLwCtZWe/LL?=
 =?us-ascii?Q?D4wmlUjp2/G78ORYDCEkWXXFQXyUjSFd0n7T7jpO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c7fd1d-e03a-4b2a-ac9e-08dccb1b40ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:48:29.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okHDiKPPGOb0bqdzI7Cx33nz5vnZRD0UySY+GkcMrVu3/Q4eQESyZb92qdcCgveZOBMJeYWMw3/3cDoJPvDqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854

As Rob pointed in another mail thread [1], the binding of tja11xx PHY
is completely broken, the schema cannot catch the error in the DTS. A
compatiable string must be needed if we want to add a custom propety.
So extract known PHY IDs from the tja11xx PHY drivers and convert them
into supported compatible string list to fix the broken binding issue.

[1]: https://lore.kernel.org/netdev/31058f49-bac5-49a9-a422-c43b121bf049@kernel.org/T/

Fixes: 52b2fe4535ad ("dt-bindings: net: tja11xx: add nxp,refclk_in property")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 50 +++++++++++++------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index 85bfa45f5122..c2a1835863e1 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -14,8 +14,41 @@ maintainers:
 description:
   Bindings for NXP TJA11xx automotive PHYs
 
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id0180.dc40
+      - ethernet-phy-id0180.dd00
+      - ethernet-phy-id0180.dc80
+      - ethernet-phy-id001b.b010
+      - ethernet-phy-id001b.b031
+
 allOf:
   - $ref: ethernet-phy.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id0180.dc40
+              - ethernet-phy-id0180.dd00
+    then:
+      properties:
+        nxp,rmii-refclk-in:
+          type: boolean
+          description: |
+            The REF_CLK is provided for both transmitted and received data
+            in RMII mode. This clock signal is provided by the PHY and is
+            typically derived from an external 25MHz crystal. Alternatively,
+            a 50MHz clock signal generated by an external oscillator can be
+            connected to pin REF_CLK. A third option is to connect a 25MHz
+            clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
+            as input or output according to the actual circuit connection.
+            If present, indicates that the REF_CLK will be configured as
+            interface reference clock input when RMII mode enabled.
+            If not present, the REF_CLK will be configured as interface
+            reference clock output when RMII mode enabled.
+            Only supported on TJA1100 and TJA1101.
 
 patternProperties:
   "^ethernet-phy@[0-9a-f]+$":
@@ -32,22 +65,6 @@ patternProperties:
         description:
           The ID number for the child PHY. Should be +1 of parent PHY.
 
-      nxp,rmii-refclk-in:
-        type: boolean
-        description: |
-          The REF_CLK is provided for both transmitted and received data
-          in RMII mode. This clock signal is provided by the PHY and is
-          typically derived from an external 25MHz crystal. Alternatively,
-          a 50MHz clock signal generated by an external oscillator can be
-          connected to pin REF_CLK. A third option is to connect a 25MHz
-          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
-          as input or output according to the actual circuit connection.
-          If present, indicates that the REF_CLK will be configured as
-          interface reference clock input when RMII mode enabled.
-          If not present, the REF_CLK will be configured as interface
-          reference clock output when RMII mode enabled.
-          Only supported on TJA1100 and TJA1101.
-
     required:
       - reg
 
@@ -60,6 +77,7 @@ examples:
         #size-cells = <0>;
 
         tja1101_phy0: ethernet-phy@4 {
+            compatible = "ethernet-phy-id0180.dc40";
             reg = <0x4>;
             nxp,rmii-refclk-in;
         };
-- 
2.34.1


