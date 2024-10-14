Return-Path: <netdev+bounces-135255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA099D31F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393CA1F24B10
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C01CACDE;
	Mon, 14 Oct 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMxSZjx3"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB01CACD9;
	Mon, 14 Oct 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919861; cv=fail; b=thWtCdcbFhw2+kg5s8xUTYDq3Kg161XmllmEA9rz0vMHsDkDcaI7mnQgwZq67d0rL7pV/zLCWiUL7e359qm9H3fRBUnS5rLLPnAk2nEFqQT4PbpMJijLwM7jcsT0q3erimisyFYiHIJUQEZeJqRYH0Vn/T92X0DUoVXQXoX4hYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919861; c=relaxed/simple;
	bh=N1BwFuiUi22iThbOw/A+6HKDKkFP2/4GkqrRP3p2+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PHD4b5qQrU/peRcniq/1eEiNRs14OG34q2X2B0xrdJ+FLAotVlUVMp7RntDwrls09GttdxjZXpH+y1QBdxWk92ErtS10zPxUobFzCEpgl6/hiOnkzw4bUM/zxJ4UXOYfm+N1k84KDaxZUTGXL7bwk9rOjxRuqXNuQvBDG5G0ZxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMxSZjx3; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrCBmBgAid8No3LqVYCSMPJstgC5QjbMGB9Q9ntKT647lbHf1n5+88ChH+BTUNCzJB7iNJ5dku0FZrF8V7WNYRRtkyQZUQJY4YoAKzmyHSFCQnDuZUsmQVFvwqfgqL5XIBd7EYwWxhZxiZgWvnZIL6JWbl2gQGLK+MTdfSDI8go4vEQKEvWa3IBihKjfEE59Tsv9CXVLcdX1HD7DJ1lhD4CLgXKaiweHxIU2rAVo+z0DwJVK4+r129MdWE9ZjHSIOfJN0M/4Vt0qi7VFPY2SQR8ULvpAeGAV1epR1JwQRQ3wS03TY/IG+kvirZOTtTvi8ehH3Nc6rKUfNhbTEoPdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgujZZ8Zuy44lBk6iR8kVqbKcGTH84CMRpXtcZsQkaI=;
 b=XTE9TxBjLA5Ffss0TX/damF8eyPEAEVN5n2ywMc9E04OraDSsE5CBNQL34lRHvqZvt1s64qefXOczJAc+2M9LovECdcdmPv53yAoUceuGI5syD8XHt2Q/O9hKUjv+ytWymjpaLgnlK8lpVn78UqbJxhz9r/rORU1/yp3SlA5HoHxre/5ZnSa3B7VP7b60Ml59CipUq76G5OiJEO8GPc3eVi2vDGr+QYY+9uw2z4jlFfp7mYSMw98lBkd8cC5uLHj09US7PQEUBIgnhSboolOGqR782yqIG7nUDSDUqqB4dOIJpTFdpcFliep9uizoQ+YQhZ//CSXTla4XWGbm1LuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgujZZ8Zuy44lBk6iR8kVqbKcGTH84CMRpXtcZsQkaI=;
 b=SMxSZjx3vNNU+CcsPKYdqtublf41uvHBH0yO8IUi3wIG3vEFZzCX9IA6BEU8LxMfBkS0V2ITMqGOuPIkFJFI6VNQVOBfzwPLJPcvOs+qkNmREQGdjOrAL9kceDNKkUK2WJ2DgH2lIAkx//R4jkq8/FF3JdQt/LaPbJYK5DxWwoCxz8sw2t/Ch73fHhoxb/NwIQCWEshnAynurh6TlTC26UlvAFV6jIrDs1bWwshBDZb3SiR6DrR6aDwU4w+Cy/xA5j/IU5JNvbmoeLQBkp54sCRmZRtZe7MBN4HrrdP1lC0cbVSbYxvj9dXkHgX5zD7L/BllNDNOvw9fWP3mqRPR0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:30:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 15:30:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: dsa: vsc73xx: fix reception from VLAN-unaware bridges
Date: Mon, 14 Oct 2024 18:30:41 +0300
Message-ID: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0308.eurprd07.prod.outlook.com
 (2603:10a6:800:130::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: c797b693-2ae1-4599-d0ff-08dcec6531a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oqDRn3bdBeY15dOC0r00Z3YWWumPSl0ua7VQpaz0QD8xoHZbca/cG3eoafi9?=
 =?us-ascii?Q?HSFfgE3vK9kA8/ixwZTl+zKDz6MT+dJrQkLJLEdqTnwMXox5/TKXUSlC4D9w?=
 =?us-ascii?Q?0zIdcbjIyBi8qgY4MhiHdB+hbUZ+uZHSnUr0RmaU37Zunq5jYfL0PtxSNJHf?=
 =?us-ascii?Q?A5TqDKQrX8agzDLEGmLDX7WS/aSreQvkMoISJrFqR8JWUiruU1cTSXZGYIzX?=
 =?us-ascii?Q?q4klVIBNzHZLneMpc/Sm5vgOD5kTplwhAmZhosbElmUzWBhNfvi1jm9zt2as?=
 =?us-ascii?Q?M53HJQ21YSCLqDgfS435Uj/zUECLa+4Tb+YOzV+x2pCv3k4yk9tjLW4VrLX1?=
 =?us-ascii?Q?oBd5cLBGKT/o4XbcpwlO/r4y2G0rwg5CH8SiOxPKtLphYrgGYJ7H8BnbM7vc?=
 =?us-ascii?Q?pVAMSaHtYSeKtPx5vHvhVm5HknAnHofNI1o92WqRGwKwJKhnUEheKp74VJP3?=
 =?us-ascii?Q?nP8utUxS4kdh9d112mDjgpNSiNuzsXmxsdewNzo13fQCzS9s3vzgP67/eouI?=
 =?us-ascii?Q?AO4pi9JCVs6H9ajcYgwJESGgRX3WR4lN1d/+9FaQ9LlZrukKhs9Fn1llARrP?=
 =?us-ascii?Q?jDDMaZCe0z2iWnRwqaduyBYeAxdhxQaJ53+YfzaS4Pbv+itl+1gPlzKrT5hq?=
 =?us-ascii?Q?/evQDhi92HByMfz7fpJqUGSDqmgeJjpN16bZzkWR9FBDEh2MNru0ONJEPAyH?=
 =?us-ascii?Q?KOOhyPdHGO9LHQSLsitLI2MDrW9nNwwZm2iUf++FPFpXReA5R/lVfHE7mKgB?=
 =?us-ascii?Q?fuSa9hVKkBH1rPnwhYIsNGmG6xoLuoUvxxmH83wt6DEHJcNQWi+2C1HQIMP0?=
 =?us-ascii?Q?ukhDtd9Qx6N9HY5bUXZCXuy+7YMNzyJWba20J/SN/DgbulFllSoAQn3Ln6yz?=
 =?us-ascii?Q?4FaH1fLvFZjptfGgCMHlJ517cVv+mG5WIfu2sjdVp0vReG/sE7CIh7VkNFqs?=
 =?us-ascii?Q?LZg3a4pm40e6YX8ShXbYlgTPXWBZI8DvbVzTHwKoBdPuaeN2lEo3MA7p/bYl?=
 =?us-ascii?Q?gDhjN1GEIF9z1lNRTXslLmNgBsw5i3mK4lRmfvb9STQZmMbT/sZUWLeraXwx?=
 =?us-ascii?Q?J6eQyZWL8iRHyDvLsvc6Dj03PssxBWOOWeg5dCQuVLu+jINXsGmn3LsmokE2?=
 =?us-ascii?Q?gLlLFOX1iYdrSjPuN9rGn4kQatAlwhm/4D0DV1bTxD3cFgcrCkEJ3WyqGcZC?=
 =?us-ascii?Q?ACJmRxODOHqUBlAlxQxDNxG7lC2oNvruZ8lD/69+8o+H9SSj0Dse38p+TAuq?=
 =?us-ascii?Q?QNWT8R0Bx1sF7G23hK3/CSuWo3MrA8xrZrymGnTvtRWEc6FyxJJviSguz+6s?=
 =?us-ascii?Q?gqKIys2FZ7OR1vIUkA0wv6f3Utbxn1+nSAwSrCeo/XRbcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lj+pOCsie+fkx+eFEiIZJsE2uC2315JG6H2HVuffFNDg4efmmUssjMWrdvFs?=
 =?us-ascii?Q?O87jpQdUOpsX4ReU8+zA1oKPSk8b/zLo/N/TlZz2HBtaWZZn5PE2vs0M7nvZ?=
 =?us-ascii?Q?8zjeLqqKGx4ZvFJfTpeArONxt2THO//lmhIrVWVBQd9Py4kd4H/WROLjHDGt?=
 =?us-ascii?Q?SIN7wo5bdLa4KNAim9dAAfHxuj70tY/sgLWOHUix1n8Vuq5MS00RxNYEC7Y8?=
 =?us-ascii?Q?zMWPBYy1a/N+b0cmXmRB6hwtdMAo0ytggc9KBRWN61AAX94hCusXbyuF/t3F?=
 =?us-ascii?Q?rh5IhnB/qFXvVcYYL6iRaNA6tTnV3XQXy0K1R5JcuXtk0s0CNFP/d68f+T4e?=
 =?us-ascii?Q?y2ktM1O/zkkCyVEGVildUdV5OmAcUwZQ8LQdDheviG9CP96KuAc4lDaIClAE?=
 =?us-ascii?Q?PSu6nPLKm/fYE/XIDLEy4uDzRyY+Nf0+Z74I7cPKyMkyv98dN9p+erVJhtOR?=
 =?us-ascii?Q?61kv6ZxyO83zwia0bRN50oNnjkDcefbvZ0h3AOqHWzuwWfX4W1T6DUjWo1bY?=
 =?us-ascii?Q?3q++27U1Wloycye0etJPdx4GLcSp7QZ4DElT/NQQfGsQ51mC7HXf3Xlf65LR?=
 =?us-ascii?Q?giTAliTJLzP1DNgPmDISIcPsbbxhfhd6mIyx64ifI4wKUZ8QB4PMFqxzcV3y?=
 =?us-ascii?Q?Foejxo8Xp/f5Hf9xghrM5BghZnBJxfb5jJMlnnx8hdBduvpuSpvAT8DZ8tDX?=
 =?us-ascii?Q?QivfiAhvUVGiHqQxWoPJ+/m61I4l0O3vlxknJdHlCk+smokL/Dz1vCaqPqVP?=
 =?us-ascii?Q?O1/5L5of2C5wSoUjvld9VbQYBKsXieLBsPJcSAFDfWQ/oYKZ2YkLgqp2VGX6?=
 =?us-ascii?Q?iScnRfhLxK5YL8URqQ29aYqD1XOiWGYmOTeP7TOu9sdAb9va6GDY5lJtCFYq?=
 =?us-ascii?Q?PpOGN2ER1oUPs6mm43B39aOYZLH1OEEzPIN7KU2brwzZvM4DBLmFarxtTntf?=
 =?us-ascii?Q?wgpclPOPnkySbDOsUZyfKMdTJC8ktQCwLRYY7jTfRtFhMJxL0Cd8oC5zdLvV?=
 =?us-ascii?Q?L6hTE58UMkeXGj1lXyqiuxQ3qRPLgM7UveNHt8mTOB6c33pOrjyWh1MXzFrR?=
 =?us-ascii?Q?Ph2NOxJ4pr51yy+8SXoLMejkGAQB1Sydi2spDNa/6O87gygR3MUeWH2Oi1D3?=
 =?us-ascii?Q?s4LyZaKNdtff/Bihl1/LbyhalbJbiA9I/7oR4YxANzxo0OdOzwzSaQpPsIkm?=
 =?us-ascii?Q?gADeO5CCIb+cossUxCbR6tT0/Hquu0i3ho0xHpq6551KP01Yxh7ZsWXk0eFT?=
 =?us-ascii?Q?ksIVdK4Po9PuXku/lxpkdQKvE0mXYxpy6ivc7Zjhj2FkEYmK+ldLegV7usMi?=
 =?us-ascii?Q?M8N0PyaFs9OAMmdUI5Pj7VMUF9AxF1TdhDYh7ER7kkNKVeEFagauo50W8+nJ?=
 =?us-ascii?Q?Ni4G26PwC8shersNsOzu6v+q3pAgJ7SIFpyxp092bGrc8m+S9i9WlXXP6qtD?=
 =?us-ascii?Q?ZPTmULqQZWxB1Q56w8z1+N5jnTfaPAC4JB/IO2WNssEXnVU7AJvhso8aKyaM?=
 =?us-ascii?Q?hWDvhihSA7Pv/aZqmXgmg+1sY2Yl+/RnxQ6XYHFlA8av7rMSM71mLxFcw1fm?=
 =?us-ascii?Q?yCJaD/139a21oOBNFHyg/XUEOANlBh4OnvnRaOJSPQoQCUbp889r9ir35Zk4?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c797b693-2ae1-4599-d0ff-08dcec6531a1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:30:55.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpF+NJB16eUk8DIWmwbNDKNSZdqJVnzosGVuSZjqiXBa3+d2FcUnCHcsu7IqG9LUTBKkVq3Ej+gIMIwFkujxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

Similar to the situation described for sja1105 in commit 1f9fc48fd302
("net: dsa: sja1105: fix reception from VLAN-unaware bridges"), the
vsc73xx driver uses tag_8021q and doesn't need the ds->untag_bridge_pvid
request. In fact, this option breaks packet reception.

The ds->untag_bridge_pvid option strips VLANs from packets received on
VLAN-unaware bridge ports. But those VLANs should already be stripped
by tag_vsc73xx_8021q.c as part of vsc73xx_rcv() - they are not VLANs in
VLAN-unaware mode, but DSA tags. Thus, dsa_software_vlan_untag() tries
to untag a VLAN that doesn't exist, corrupting the packet.

Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on RX for VLAN-aware bridges")
Tested-by: Pawel Dembicki <paweldembicki@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- retarget to 'net'
- rewrite commit message

Link to v1:
https://lore.kernel.org/netdev/20241008104657.3549151-1-vladimir.oltean@nxp.com/

 drivers/net/dsa/vitesse-vsc73xx-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e4b98fd51643..f18aa321053d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -851,7 +851,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
-	ds->untag_bridge_pvid = true;
 	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 	ds->fdb_isolation = true;
 
-- 
2.43.0


