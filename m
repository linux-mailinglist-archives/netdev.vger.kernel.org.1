Return-Path: <netdev+bounces-233051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 147B3C0BAA6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7AE4EDEAB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8882C1586;
	Mon, 27 Oct 2025 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYcQS8KA"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3B2C11FA;
	Mon, 27 Oct 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530862; cv=fail; b=lat6pAQr4fwG9GIk0Pi3XH+0LHkAsI6GcUGHuLwLMYGw9s48iZkctoSH79P2ZGLaWg6HjWXTSYqp+/dSdbZpPSZeA/i3JTtvunTG6P9GyAd2+3oYEtp5JfvwjJ0v0ClAUsjMOMx5QZS0g4r1kzHo0s9SDyQrvfIlUUKd2TO3JkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530862; c=relaxed/simple;
	bh=v+LGqaJDbaE4YQd5j1uIJhfEE4OuedcFLV6thO+nTs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EckVXPePLp6iyHmZNBtQ5HJHH8NkksIm+f9zfzBZ07/pWoidh6PWYxYOewKDmqm6exNQzuT2LnBmmFrCvhz9Yl5d3qdgICMOWhmeCJCGpe19I2ofyxe8XXC3ELefe00leD4NAQFtRXwqrmHYjU9kkLtw3Xt2RhqAkLQ3etZxh4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYcQS8KA; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTVUjJef5H0VxsEsm+KKiFNBTkyaKWoRxI1PuQNyhKAprYNaVP3Moyd3D9m/GL0mR1MADRp8EZgfqCWd2Fztexk9Fmm9NVtIB0VPnfb3TjJDEYzO5NSTw4qof605U+KR9fy1fv0aruahu5qhd2W/RcLI/lnVxxIcd7eotX1VWTBRMEoneCo+R3pIYFFidPbUy2AzioU+kV6vC4OJQ1ZTRfgiksm0dLfYrKz3ncFYskjIwZLuZujet2gq3doavkqOlZCKyETT/BFDybXZ2Zk4vt7z1gG9McasUcoSaljDrPZ7Bi4DvuUm0B7yPCPaa1dVTpx/QMu3pjhkiLkQYuHGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=dG1yOixDVbuVMXzwgMEzyL3pWU2yCW1nw4bW3rhlq2aX72vKnYuQh3Rr7fylIm1+wg263ZqAjFMWpL0FQnxnBPwJHinDbXJryT8HCbTBTP1P3kerUGGqOSrGNi9ZgoSGU0zIkiIunjMtveUNVXneTqpOL5ifah4HPojPNor7on4f9GvSIQ8XxZV8S7gaTN4Rr8hBO3gVqosh5pIE+ZDp3O+/srfgf5yAG4AsXpNYW5GSKXrb4GNhbFCnVoH7xDa8vYe45Cr6SFKk/AUU/rS6AgOCNwIHVv9PmwLOFQNC7lY2zOMZaP/RXPkPvqiVp9kGIDCYJ+brGGykE8gUY62rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=UYcQS8KAeM9Lh7cUVr3fxEJsHRBDwBfYvswv3+YZDnqv6XSI2pJtB4HQy+sgC65okqoNapGlrIgzFR133uv8OKXvtPZ5KVZWARY1vzxMeylnLswaLXmq3wX+zkFsWNu3fK/ssprRxk8yJi2u0XuBiFxrP6RGvF/HiKXjUzzl/VXsCdh8nX3fKcHacGXBQpL0qyUJKbS0Fj6XRSeqUNoZi8Mk+av76aYE9xLngDeVyw9x9z4Mi0safcD6y0EsUohQ+TCyX8mnDdXyPqVLRu0cGIQs4z6+RbXKD62IDgNKWv/AM4IU3zGVfO6GwGKhbJN6gM6+qw8/G6sagOvyr0iyrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 02:07:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 1/6] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
Date: Mon, 27 Oct 2025 09:44:58 +0800
Message-Id: <20251027014503.176237-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d436be-98a7-4225-b037-08de14fd9964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|19092799006|7416014|376014|366016|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l3RTlOOdh68OLQix/Vu1fE7+IGt0vyzESH2gqlMty86rts72Y6Xqpu250JFe?=
 =?us-ascii?Q?oQ6Jy2TYY3RrB4lzGlMI0fSSfIl9GvtpImCKpAMimQya8FTEKPC8PPwwNV1R?=
 =?us-ascii?Q?tZCn+2l0oAxJmLoQJ/cC+8q49zlycDljauFaELPpubpPJmHirdJ1qP3Dqys5?=
 =?us-ascii?Q?V5sKB2Q26ZspxUiZbjJsNJFhAmpXWgFW+aLwV5YatHUJ1y8SXMNk25u67q5j?=
 =?us-ascii?Q?c0zzfzBx749HD7OtYTd/y62aRyt7JSen7N9JaQVY8G8QolF48R9NZ1JEzsCy?=
 =?us-ascii?Q?6hw2jjjViMRK4YXQ9sipzPTuXf6wGkFJrJgKPvlCaiMQ9zTQS8cc7+lSS6RL?=
 =?us-ascii?Q?qeYxZ7VPxZTtGj6BLxzGG6RGJzt25FBtuv4g4+zuKAqjLkOwp1fIU4Fo5jS9?=
 =?us-ascii?Q?X/sn+3JM4umBoBz5sfmdsfGUcZISpco8+wT9MCF6uOqIskuMMab49eJuuxoj?=
 =?us-ascii?Q?nhB6qicH4gkADkiPS03P7klYXEld0xBHCzleSiLlcy7rJrMeCSAdTceE1SbM?=
 =?us-ascii?Q?RqNpqiaOOwUCh5L2WCVISMPJ9phN3Sfft4uxupNOHoCxlxERzc/+Eh8yd8OG?=
 =?us-ascii?Q?zUEExB1ZvvY1fu5rXB0ow5wT6d0HaOzfaJCWd1nRGAO73lZKedO585QTvjMU?=
 =?us-ascii?Q?0F8LoDbpL+kFjIuWbSjAvKU4Ri+5ursWAR4FW3H0nNkh7sFMKTwiut+ToJyZ?=
 =?us-ascii?Q?39/oRAFF3wvXMXhX9iIN1kv3Z4dFeiG0el0yiSUm/VHLrMNXnljpFsJ7IGTQ?=
 =?us-ascii?Q?X+Kn8tROT6NAnedSYbSIfmxGwwW1MEXbYZbcpmVrT24olYvokbbRIBmbFguB?=
 =?us-ascii?Q?FmPAxBnRnrBEwFVngPAwpNiVI50eJ1YgxnGlF7JFuZ/Q18hHeb/CY0hU0tOp?=
 =?us-ascii?Q?Ggiv7+Z83O+LXaLusuHTxubr8Qb8YFwunhy2Olca34/g30/YqP+qUfJvFBqZ?=
 =?us-ascii?Q?I6NLT3Dj71Bn3iZHc5dws2jtBCRv6nOwnF59zYwjrmpAcCAhvxTMK/m5zDGW?=
 =?us-ascii?Q?ABlT83bO29jhS3Mmz/T8jTr2rn+0S/YdocQqQEf5V476dbtoAiFHKGh8zms1?=
 =?us-ascii?Q?BS5M+Q0eo638XOXIj+Ys5f5r7potRQBU7CSES20K892t19KT49A8zG+k6X0l?=
 =?us-ascii?Q?xeUBKE9h//Xp9jRUgsSwDJ3NWnmXRIg7kR49emMcwNg9pnMOiU27Jt53ka6C?=
 =?us-ascii?Q?Fv0zY2UAlxxQW7McUqqYyLPmJrxP36YI8y3NuaRvzqXlqLtsIufb3cVgQ6C1?=
 =?us-ascii?Q?75LDUQeSlB2Ex0Nng9PoUS2VSv0SgWKUzc1Ch+6WQxMCHLqR6//r/Do/PrsS?=
 =?us-ascii?Q?AvdfDLVfpYkFI5XxZkixNyKI4aXG7PjVNAly2qlfk7bj/4tEW7CsegTnpvrI?=
 =?us-ascii?Q?UQ4xVpPAdjRzIJ0h1rY9VO2HqMS4XGK1KoAQhtiuzZDOwEFXLJvflDchB00o?=
 =?us-ascii?Q?kcX5VXZcUEJkKfcytSteKwtnWHGMX/niReS6255urwXwABtZ5Qd7xIDlvfnp?=
 =?us-ascii?Q?+VYb5aFRObPVyBQ/V3prgvX8RvzlUtfIJUBrSLj78VbUbtJ7NC+LCNE6lw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(19092799006)(7416014)(376014)(366016)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1ytj36rNp0dFGlMcikM399oOQzFzUkrQlWwJY21qQQGpWcsQ2VQybZw96oZ?=
 =?us-ascii?Q?KYw+4Spa2X1Uvl6ecQfUceMCeqcH9R4dy4CfnoIAjbA6VMw8y9p6c/X7v+fj?=
 =?us-ascii?Q?pM7O6/Iksy8QC6ZPdXZhdR0TUAPS4CcyunRCf4iz3jaDfXCSrOlbh/CmiF6c?=
 =?us-ascii?Q?bFjzdWiY3JVyttkttbKZlvOpySBpfelB1VzPbYUmPFH83LVr+FO1DgWLvOeI?=
 =?us-ascii?Q?5lLaXppmriCKCkT/7Qu9xBblzPzAVv1J5LNyt66/B4eo8Yj9NEE7AoNnjKJv?=
 =?us-ascii?Q?5LOo9MEOf5YiKlXWDAAqU2WvpKoouPwW7v5gUgd3IUa9MMUcVi+h5rAh0XqO?=
 =?us-ascii?Q?H7orO3QsHaKPy1XN2c7CwQuXOLRoeqfDoGGvG0kykiRkIef6T5aUihsJl9+B?=
 =?us-ascii?Q?XfO2bDws/iYUvdm/y1bfIQgNlbgRXZhk4C0MLB6PH+Amp8HcGWZhYD9G5lZU?=
 =?us-ascii?Q?yY1WgCtJKMm/zfWywO5YIP8DnglAoGRNp0lLbUB41xVnyvNMEBfV36C1DyJ3?=
 =?us-ascii?Q?n+YSqxd9FmAFdk38EN403oCv56B+k0dWZ0QicGfHWgUYffV+lJeGJqYO2t0E?=
 =?us-ascii?Q?TkYz/Z2Rilcm+LUTJTZLCoa+IbZjsBtQ6nUp9wii0tQ+nrSPSCC38q70i8go?=
 =?us-ascii?Q?XsfhsGjhYYSotDcMd9klc1YV4W1YtVwglplBVWTgfHcxnKwr7zXYrCuznCmB?=
 =?us-ascii?Q?EploJHGKwZJXy+8BWw81+EFVwDIhVfipwyNt8Vq2mQwMg77fz9p+yvag/Olx?=
 =?us-ascii?Q?C/tQ7POz+ZnVLDCkOLZ4CmMmUL1ssWaxPZJxt32OpDJEf9QffojIfJy7oy2r?=
 =?us-ascii?Q?HBUPCrBoGVqrpBP00UV7keXk/xqdKcy/O/TUmOZjaeA6aNbb9PS2Py14WijG?=
 =?us-ascii?Q?6Xp52aVi9hRAc+FZumi0Z1NJblL6p19lQDq2H5V6M3VUt+p34Rr5iN0b9DSX?=
 =?us-ascii?Q?2/zBvGI0TTh4DlzCL+95Sm6OfsO08pDtr8KUr693W5rW7UKuptgN+2ubmmd6?=
 =?us-ascii?Q?9u8kDfs8ssKKjkOWSzVNWY2QDeM0eT80AQQbMV2wnwNIUUek3jcEHPxCoJaF?=
 =?us-ascii?Q?Frg8+arnIM5Ptk6xVRnuBgKy7wl2WtOiNuYWERhsYubH5ykkiGCzSinZXpCw?=
 =?us-ascii?Q?vuXSHh8c4xTW0gQZE3zvbbvRo9IQW5Z5aIoXkJcgMTPFRzSh8UUOIlqEGzeY?=
 =?us-ascii?Q?Y/AhPlPA1C/gAx0ewmXZD6taxlIEYwrIPoOfbtAdHvdqLvRVXY4FIrVsfijO?=
 =?us-ascii?Q?PaDuRH3gtm1mC0piirakjcHtpVIIkX23rTe2XRGW1ZPTp7ZRhK+jV9bWrsz6?=
 =?us-ascii?Q?bUNWBK09O7wWHpcobp9ixf4d2qg7ibiiGDB3fse/wjoSg+Ujv0YE1Y4XDhMt?=
 =?us-ascii?Q?RQZvLRI4XriudbJ+KoRTy21JBUFXlLS4SmfW9+9Mw21TEmS55rsl6elXz20u?=
 =?us-ascii?Q?PMZ88tE/1vOfH+wqkJn2dnvuAQWurZRAPql0VF2BWTKxigpm4dv2Y0GRxkU/?=
 =?us-ascii?Q?Qit/7IWdky+KcXuFd1/zYzOV6PRrrh30gI/R/17thIthsFqvAQG4EAmZF1D0?=
 =?us-ascii?Q?W1lYpKZzeTAP8EYLZPQPQuZ5PPBLyQJsQj1jsBJi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d436be-98a7-4225-b037-08de14fd9964
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:36.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMW4R1/CUn0vAXWZLFQJQbwIzYjKxkDVpvEP0+mAWSqwMKF+/H3WGxVVTGw5A0Q7YNnLNG3POOTsc2Cp4v9cPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417

Add the compatible string "nxp,imx94-netc-blk-ctrl" for i.MX94 platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
index 97389fd5dbbf..deea4fd73d76 100644
--- a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -21,6 +21,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - nxp,imx94-netc-blk-ctrl
       - nxp,imx95-netc-blk-ctrl
 
   reg:
-- 
2.34.1


