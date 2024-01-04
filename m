Return-Path: <netdev+bounces-61534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4A824334
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877F61C23FBC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39808224F9;
	Thu,  4 Jan 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jdMcgn8Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A8224DD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV8KwNB+FVQN1G4UnwDlDYxZc8MlhWfEjY//7o5w/5aqI41Yaiur+BHf16rZjH05OEh40jpKi8HQgLB706lwDtEtFiYrRwGYMceee/sX5avL4vCOXvr48EZCMVimH+brrVJ8kWtWmcBuOdS+UnDF9omtifQgBp3zAXss4EpiGizAw/nwBUrg4p2WYxTKzEus8TExsoFIqSvs2l7TEIwYfabgJ/ZiK9A7IkblJ4kOQ6kmfQU03fu8XiEP3NDkILgh/+AlZa8ctHPLDB9gDIdg1O1a+712ZNqu5aBPzoX7Pmeqvarkddf4jQB9/tIQR+hopcbmHqsNpWtL66Me35/Nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd5dCSsY2lxoWH8zAZsSKuKMTTUgYCtJh0AAJS7CHzA=;
 b=OYKfg+3L7Afhih4yJASlTAJFi2/D7bYqLErPrK7NN0dEIxEUpruB+VA+Yt9CtpR5uF+Ua3DJ8ILn3P2rJy+aPqSBmArTP6PdIjQ8eKHc1zjwymKLqeELfFKS56oPGif/efZjubBgwbGduuQDY7G01YjP8XRSSUmk9kupUqdDZbOc4ygPcnkKsn3Z8kmSenZrAp3AyhpPlJXIs5NjxAJQEnaWtEhbhimJ9cdMlkrt1x8cZcMYv9Te0lskpIX5nHhu62E1wrkm1nQGtDbOn82tsFjRl3UVSbod4aPRw0UyQK6wj8cah9ybopWRuzNu0INBSukBprEMADBW+vFq/KcPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd5dCSsY2lxoWH8zAZsSKuKMTTUgYCtJh0AAJS7CHzA=;
 b=jdMcgn8QV9XdZpE64i1t3QnjKN9gnWKbUsKPwktsbAV9JLr+UcPhiwJ5a7F6ZT8aOFsq4SyhSp1dTXGUajkXyA7JZYhwyIYBqTaAHCViiHmE9a3zVCXG5rzGPi2iYf/UlI8srSWqDp3Dpa/V6RX5awBo5o8MwYGonx3XU0RoVT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:16 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH net-next 03/10] net: dsa: lantiq_gswip: ignore MDIO buses disabled in OF
Date: Thu,  4 Jan 2024 16:00:30 +0200
Message-Id: <20240104140037.374166-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104140037.374166-1-vladimir.oltean@nxp.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c85fd4-4eb5-4100-afd8-08dc0d2d9dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DXqDpVL83mZ+BKbNvjDhDVUdY4IQom/LM7Mhaz59hmNT4Bx1+7UbuStbDwV/dQv31tnxFcgxhUInQ3GZQW8qNpV16KmXQuMp0+Zt20WBxO2P24qhCojE112D96HCLQlC66Th49A2kK2fOybnQr6hJ6L+m1O/aUb6hudZIiv68wRhd+W2xIQLJew8bm9LFcjxAAzzevM26dKZoGbSn7tVLArmTlRf1e/kXtMDdWLUN8mo5z4C0He4EBQrwHvTLcVGExXUu1MOoxySdyarxJIvmwpIMxVnL48x1Ap+9FiJHZkKjKwhxap0myxRsghsDMCZWCtyn7k9wLFbZizhtS/Mgf10OId41kaQ1JC/l+DEii/5aPpQw/pAX/qKrO/o7fAIVAM2BlymVsoTXKFE0fmyuHsBhxnpHzOnCnrPdh78MrDVbi4O2+OzcLWUYJurkpVSLoT/we3BvcwdlxUwrvreIrxP/UIaquvic3HbnDFYZj2+FJX/2y/Jqe7BlV4jgQdHPKcfx4dxGdZP3plC1mZAu/1G34t9T5YCQO1MaS/mGV0qByOYDZzD47fyBVP6DrULDOW6sxMNE9jKYkUMvup+LJ0YZ4BWsQf4l+vB64DthOHsIbTYHGReKB88S18AD2yz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WnlFjnexvcGsDgoWc74EO1+OKqZn1ztmoLsgv3EbygpvW8jj6m3H3j93A1vA?=
 =?us-ascii?Q?sK15tszsQzfIJHyzybjuwbfI1nfcGQkF5HXJ942F4EeGR5JaA8Z0UfT4Y4eJ?=
 =?us-ascii?Q?9gk6Xsd0NuXUCRrpG+noqrcW2inNfaKT5Ys7j+Qz/s8dd+QvlvBKg5zywLVi?=
 =?us-ascii?Q?seZ2XFELYgERn7X9dr0xt5LIp6Ck3nskkC8oA+5OH5cxXQ/tdVu6wG/m5fOL?=
 =?us-ascii?Q?X5TV1FutUWNZ2DBZgqs1OD7aWs+ftQUwqU4EqWux92bvcHRvkMgCw6VglkRA?=
 =?us-ascii?Q?ceTOm9BhV0lZCCCP49EBGOVkaj1tPIHk7H/FGl9LNzBB1MIK4dr5HUYxkS5k?=
 =?us-ascii?Q?82QFAFZLgt/xaXeT2C7i5UfcxVXV3pjzaal/DkgT9EnoKsSN9XJNyPJllfgw?=
 =?us-ascii?Q?WCBOtDiTt2vgsHqFovvKjgeJq2ZG4RMXQ3fRU8c0sjdhTZJv9rWQQLmRPmXw?=
 =?us-ascii?Q?Pd6cdb/InQ7ycFp4Som1oHxvoOagO1vy76F2F8uMX9fqxCPMqSc8QkXgUrB7?=
 =?us-ascii?Q?XEU4AyJOIOxQrJBzdKbXGacuirB+7dexJAmSxmdS0EOY9s/EW1EvX0FGzsV7?=
 =?us-ascii?Q?9Gazc4EiOMtpkYsIDxkVHlGSZDT8YINaKhx+ArovvCnoFrhVtAE5rWH3K+3H?=
 =?us-ascii?Q?Z9PM4m3YSOS9RY6Fco8srin23YUbosH3jUdlheP6q6FTrBHkjX14xJCq14CK?=
 =?us-ascii?Q?L0jtJ3RQblFqxch/d2w4Fs4St7TpC0akjAftO+z9jYOTU979vb1rQnOkk0oZ?=
 =?us-ascii?Q?9kRxio6dQZX6fLPw/InyebBH8Pd4urQIu1n7vqN9VWNlW7lwME9nz/n+QIbL?=
 =?us-ascii?Q?zQ0Mq5IJcNHlSKtTlHAXi8k7UzeNmAQJ/Icvm9f3YjMqBjsVrkyLSijQEMNW?=
 =?us-ascii?Q?3vPEEcNHz6pqGBkSfa/4K09fTLbsoiMXwx50iDdCzvyaK80bohMus/T5dOH5?=
 =?us-ascii?Q?B5bjBVBc9ZKd9yk78XYnLgrxIE6Vr9w/uPOw5kOIZOU0VxfcS6DWit87cSmA?=
 =?us-ascii?Q?oSBrE3bPXfF+T0k3eqzxfLowUlNBGoB4jJ7CXZCdw/knOGgswwIOpORBYfaM?=
 =?us-ascii?Q?+w9a/oW2UNL2K7l9TqucQtwrV4okiVcU4lEtsUstiWC8ROccDtlAx506weX8?=
 =?us-ascii?Q?5yPY+6kEC6hG1drXqTJWhx+lwubVrnZlU+HkpIbkT3dHPLQhKsHtTyy3Qk0Y?=
 =?us-ascii?Q?BH0o4RsLHmlyb77vnRvbimSapwnLk4xGRXP7Kx3e7b01OiEcxWWUI0prNobK?=
 =?us-ascii?Q?+7HYCv6v7Dk+ey8b61v6V11FdaOWNSzmg3GcWL4Jl+ZRBsd8gHT7WGlRh9Vz?=
 =?us-ascii?Q?5y9HdlYMH9KRU39blmOfE9V5KUzS7tKfFcLyugNG0my+8NnH481x3t4Or23t?=
 =?us-ascii?Q?mS1V7VEa11R3qt+xWndMNPgcw32d+8qDyxsOHEiPHcUSJQ9m6t1e4TOLz2R3?=
 =?us-ascii?Q?in4H90WyN7Z3lcWw+pUHAn5/qhH5KzDVzlAjab/oYBJ/gk5KI+Wx9tltvWg7?=
 =?us-ascii?Q?cGE+Y+SSKQZUUza87/hrAnnzB41dmyD7BLcgVPqekdimWbY2I2xxHmntbuFs?=
 =?us-ascii?Q?F2YxdXKpct/eDZrHP0GIoVqwtWwLYZBbfUVHiaYxWf6kKwSDFe5C3lZrwOO4?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c85fd4-4eb5-4100-afd8-08dc0d2d9dee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:15.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOkHVZ1YhE9/aJLMtDXznhsTdNBdW4+4iRPzesNrh8v656Tj88Q/dlT2TUAROQAyiuelrBlkAY6m1pLB4n2YMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

If the "lantiq,xrx200-mdio" child has status = "disabled", the MDIO bus
creation should be avoided. Use of_device_is_available() to check for
that, and take advantage of 2 facts:

- of_device_is_available(NULL) returns false
- of_node_put(NULL) is a no-op

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq_gswip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index a514e6c78c38..de48b194048f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -510,11 +510,11 @@ static int gswip_mdio(struct gswip_priv *priv)
 	struct device_node *mdio_np, *switch_np = priv->dev->of_node;
 	struct device *dev = priv->dev;
 	struct mii_bus *bus;
-	int err;
+	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
-	if (!mdio_np)
-		return 0;
+	if (!of_device_is_available(mdio_np))
+		goto out_put_node;
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus) {
-- 
2.34.1


