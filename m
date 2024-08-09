Return-Path: <netdev+bounces-117077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE094C8EC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B441F25D53
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3618637;
	Fri,  9 Aug 2024 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="ZqoZQ8Al"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021120.outbound.protection.outlook.com [52.101.129.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD828E7;
	Fri,  9 Aug 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723174663; cv=fail; b=Cc9wxfW1VOMM2A5Zks39OlT+iOIwiIctkixlWMyWDcV80A5llf6TALp5TCgHB5i+2IldkeuWtYt2M6j+itCda2mzY005LVDN6JPO1xacNXqIzkfcwgBZ/RcZnjyJNE//+7oB9NBnlTh7IuI7X1ul0RLcUQdag34N10XqcigXPqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723174663; c=relaxed/simple;
	bh=sppr9pJHMqxYnNVNvs9RHOcMgjBrlTAhyw5kAQvoad0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QFhFkJElTfPIcOUpP6Gq+5o/iLiYZ95HfvwPGtST7NQnIeLOoRXbROOC1qIGwGHf8psAYWcqJ1AuhkiaEdobogKRyPiPcJFhImqWMbuyl6xdpU6zK3UDMA6NOBemHhFVrKkcKADOw5oRUc/s+ol9/D6j4spY+7LOhElOBf23oPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=ZqoZQ8Al; arc=fail smtp.client-ip=52.101.129.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkucEHnX0bZhdFZOPeD1u8A6gWwMwEykjVajEFJlFAcnywty0iBeeQih9+Pa3DcP34QoKnWsj925np7A28QrYa301s1PbBFQsVGVuyotWtn3PYdoLoZrNAQoT5NU6hqVF+TK9tVijZLvFsfAw8IDcSc+CQKqlNz1K67QihqTfxcbNzGixJEw4shmaFaba5Wd2MAQNJ7X0k8l8uADHSDAyr1kbz4/td2zcqZllKV91o4M6lH4YWCg0SUxtUIWNG6jp2qc4TFQdMqgGrOM8kcFr//eKw30h5v2NpkerZgzWCEzVltANzgH7ms2IjdXVXYnyCdEGxWnDhjankxeTHjkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lngmblPhrTQBmRX1EAWM39oauwtU6Bt+nD3QvRx9NNU=;
 b=nnTHu6eNfPnpOxqde3IzTM+DTuykCZ6P7QCjghW3rWIDdhHdFf1LDOB64CNeaMtyg4wYlHIGzK9gAwUtylidmsNO2D+vKuatvMLzL9WBAkpDwD9bic866wjRaPXuqO50iYgp59t2d642WGhMKzB2xCRiqjJh4qzZmrIDVdSlmAFYbG/F8G3+X5cB7Ue4iM87db4zY75sXhu5wXNH0xoEeA+2LRJL0PvaELkQSq76Zkum+MSbQkVFZo5aTph9l1gumMSDxekg7jy3GncUKiFJcxmULPH3Bm5osTPytZVCQ+jWQceM1QkMy2pvKGNZBirY7+8zm8Fk/dn18NVZXnmbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lngmblPhrTQBmRX1EAWM39oauwtU6Bt+nD3QvRx9NNU=;
 b=ZqoZQ8Al5f8Vg8w9/XFJaeB1WzYa4d9A9LTqaeMNpjGhGCo7azlsICvgWo1wuG8ei6BC9HDwfYigHvRKum4Tr5FRI9hkbBslzUpsqr/05A6hGT5eCc7xXFlLeH0Q5gPRtimd0bvnXsnMpbe03VlMBmZ/u9SFXEThhw8tGBwlbn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEYPR02MB7275.apcprd02.prod.outlook.com (2603:1096:101:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 03:37:31 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 03:37:30 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v2] net: wwan: t7xx: PCIe reset rescan
Date: Fri,  9 Aug 2024 11:37:01 +0800
Message-Id: <20240809033701.4414-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEYPR02MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afa902c-c3e7-417f-9bdd-08dcb82498a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sesy1399fRHtgNA6FRB0UWQfBkHMcpda+YNA1sk1MVPPHfuXRE62qBcTDSmd?=
 =?us-ascii?Q?PFE6JRREuALqWItzqFXWJqXKFwVYA/FfmJTWzcSf0fZlf2V1bmwhZ8ZCJpCK?=
 =?us-ascii?Q?p3mRuTJwRDdhx23MZODFVx5lExMpzW7X58he0hxYbajPnVbeP7p5H+HzswRt?=
 =?us-ascii?Q?71Dm+Aj2wUTxzyNpknZHJ4lo/bQWA2kOmSPrp2Ktd9ZFL98RzUCIXMeyV1yA?=
 =?us-ascii?Q?J61C4s6Vx5hjCLPoDzKA3+6lRKGjfgWfdNHIhqCFMFxeNDLQjXjQvmvRYy8G?=
 =?us-ascii?Q?41EYD5j7gSpkmh+b5/709gDeJQvCfVp1DqB02/5Ntfd5GHhkrkb/JuY4Nxnx?=
 =?us-ascii?Q?gMa/1w964qQfXtVy6iDl/gz8yCJu3iQI0GJTC0Ph2yMfwEqE2UzjqYy8xmDs?=
 =?us-ascii?Q?eXv8ELDrByB26RCBpKHfVBJlli/lLaJMM3fbdFEmYNLBd1ZAw2Xf+YnHsXvv?=
 =?us-ascii?Q?cAESDatkLaV5eirli2RZ1bAMzGHaFBjMMBvsTqNajg3JHprVTpU4Sl6OZqa2?=
 =?us-ascii?Q?fl9c00jnMuK/oKJUwyU7ompqBLj4DCwU9j2v57nCcnbv+sD57W2PEFXDZQbG?=
 =?us-ascii?Q?/aXsDcUHNyKgcDGiDqcLLClYOrVFRaFpiNHg2oYyRjg69HDK8jwxHclICn5h?=
 =?us-ascii?Q?+H/hqZi+Yer20+jWFwBI5T7pZRgYCTtkCvXtqWxm4GNQcq0f2WL3n9k/jbYQ?=
 =?us-ascii?Q?+U+YaRvodeJ98RSM12U48j/A7Ka3io7O79FNF4utV5ow/xcXazG9j7IMSGix?=
 =?us-ascii?Q?dqZUxjZlfXoFDap/O1YGOQJLGwCIpexTfey2RHw7huAH3+ji4FIzmKuB6qYT?=
 =?us-ascii?Q?gnGZBuuMWF9KrwtlbsIKnUrZ8Wf1OI3GIWNcE8RoHzPxYP61/ZaQHQ3tgmqF?=
 =?us-ascii?Q?3hVb0VQKbNYDPxvrY9qc27cQmQaiq2VX04lQfQl0G25RW1g9i7z3fC430idr?=
 =?us-ascii?Q?Fe7N6HLadhFR4Z8tTiOCAWlEs1yMhtuQMEme5acxeKTcH5EQJQhBOQT8OcqM?=
 =?us-ascii?Q?rCtskLAVDZuFIvCwlvu6a+ovosP7hsz2335Z4osWCs54zMPME5L8drzzfDZD?=
 =?us-ascii?Q?dKvZSUmedPmtAuALksThsnTgXdhYUl9UBfJl7sku0upmkddBM06mc7CGlFWH?=
 =?us-ascii?Q?piZIysgaGikB1AlJ5oTJNMXL+Xr5incnJIPfuNS1B51g3WBVV2dgYdvgNcCG?=
 =?us-ascii?Q?APedk8+Oe6NhcekyUT71rungjI3A03WxepxWF7zPnim45w13yUFK5d32fVdm?=
 =?us-ascii?Q?WEhItB4VWJ8LnWpu1g0IZVe++TPYNT3qbUjuY3n/f4BywJO7IBRWxHvpobAH?=
 =?us-ascii?Q?EKrNa1lc6nVGeD0goALZt46IjEiS5gLhMP0m0UDPy3tOok9o7wlE0VGigJnr?=
 =?us-ascii?Q?KsJFYBnR2fanWHk4lLqaqV4o1b+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or8mbDMnxwWb7gPCFtpwdCkDJfpBCjSM4ofh07xANa6bskg3m5eUllNRwUIa?=
 =?us-ascii?Q?cIN+N6NqSUM0mSoFD6ds973PnTh2crjDD1pfIAegqez3muODuyi0/bjARmtw?=
 =?us-ascii?Q?VZHCUSiqBP8xFZOY0+ofZqbJih5mJG7MM80tlkgKRo7TNXAWy/kc/ztO+V/S?=
 =?us-ascii?Q?k8aLIggCBf02X0imm/em7wkykqRl8sQQ/awSl8kkmjQI5y/+ZQIZQDokFwXU?=
 =?us-ascii?Q?YSfH4iWTz46SEq2Z1Q3RXMovBmniZ289+YNVFjyhOZjYZ2JH8WFe38PM5aZx?=
 =?us-ascii?Q?+p11XAfb7XlxE+W2F4sH19k3+god0znayjbFMfdxeh3peTIdVtWONpLgoERF?=
 =?us-ascii?Q?GTLSdMZK27tBBn/pfwxfagmAEXEr3TbcFlmgAvxr3fXRMzQRZJL2WfACMUbv?=
 =?us-ascii?Q?rdF5GW8OtaTrrpbqfhG/OFU6STz50hG06/NPbPOEkc3tdTciO3kHtpERO1fq?=
 =?us-ascii?Q?OXXVqqNDql1YheCbFSo6kucXcwiJbh9e6/CIjR9hUORlxP6Ng4LCtbhfNl/A?=
 =?us-ascii?Q?lMu5TolIkZNCOWIBH/nFkEAJxYxIPxqRqG78pfay42ODmEtyCv4mE20L2CXs?=
 =?us-ascii?Q?CmMJ00MCPCvS1Qfn2yjk4HqED+oDVRD1vdYAvs0MDlRCppcT7fzoy+b3010J?=
 =?us-ascii?Q?fxUCyOCQwnpl2JNDsBvGd1oPO0OXhc/dKjOA0lJ7aVVfhrtq9fyqlyEo4NDM?=
 =?us-ascii?Q?y0YJq5AX86qFfnNhYXp+g0yofb7NJUKw+/SiMtcUYbgJY/DWh2WTYtjdUTPl?=
 =?us-ascii?Q?z9tfMxnbvUDXwXIQdzIz3wHPDrQe+I9BcJfwB+/tt6V1w/Bhh76DZvtsoh7g?=
 =?us-ascii?Q?X5HgPjXRDE1qlVbHxIGC22YjyCQ4TXlDc4aUfQO/FvMnw00hsWyhFBR2OR3J?=
 =?us-ascii?Q?0l2cHAREVQtY/dcCqKFUXzgQwjTcOtOARSUt2LClNFpAiyAOfFdX33yQh3YH?=
 =?us-ascii?Q?kNknIIvClwxNAPwCD5hjW+kG6EDcirRtko2q7oODje50pDIU8eAG26g4rkdw?=
 =?us-ascii?Q?HORn33W6G8YaMyNVKk3sLQeDyh4fCUnuxDjOEtkVAERZpsHR/iWtTWnZI/S8?=
 =?us-ascii?Q?wbvUbbK9KeaeT+JcMn3TSMnqTiUxPz0F02I5gsb+1HrUhljWMUFYtqne5xhE?=
 =?us-ascii?Q?/nVLhwIY2+vtWqvYGSPjWsNYvibx3juYrfkT/5enhp2JLDdVue4YgXaCQecq?=
 =?us-ascii?Q?VIoFCve3ONSlnnAJg2dGkHH/J0ipd3U7vNzK+UQAkeQbMr7CahRi+iVKWG0m?=
 =?us-ascii?Q?GUJej8G3PxBPoQ7p1d73AjDJxPrYEX5Ba6QZ74mrkHC9HeG50+8JYsIqXBMj?=
 =?us-ascii?Q?U6/WIJARjCBVTsCp0Z8dpL+1YzFTL0RtfLPrAYrM6t+EvlaAC4kJPcCWSkUn?=
 =?us-ascii?Q?g3siodQw6cG17YNIWREBdGaNNkcYvxwxl0Au+0yl7CsJLPOkHO9wm10glV7C?=
 =?us-ascii?Q?TYJxr4de77WYVhPA5Yk+vIIJsVbKSZU+BvULVZcICmW7YaV/sLiozh4eTT2c?=
 =?us-ascii?Q?xbsy7/HgJ8eYTetn2iGLNfgFa2uk40YMYOXc7GJy+5vTXcT30ldQZAffbLJA?=
 =?us-ascii?Q?fZ+7Y20C6CsGJH5JiN+E1Dn1zLar1zlDK/ySUCyz/8IkDexlmdgmeBT1Q8Xh?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afa902c-c3e7-417f-9bdd-08dcb82498a5
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 03:37:30.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4IWsbffhE2hndKW8ZgipcIbX3LNCNa8icETdQT4Fx8ux3AdwgmN+PgtvFkyI0RiupxpgXqM+nj44FpDLxNUB+R7SFwRA09sU9cfQWMrzyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7275

WWAN device is programmed to boot in normal mode or fastboot mode,
when triggering a device reset through ACPI call or fastboot switch
command.Maintain state machine synchronization and reprobe logic
after a device reset.

Suggestion from Bjorn:
Link: https://lore.kernel.org/all/20230127133034.GA1364550@bhelgaas/

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
V2:
 * initialize the variable 'ret' in t7xx_reset_device() function
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 47 ++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_modem_ops.h     |  9 +++-
 drivers/net/wwan/t7xx/t7xx_pci.c           | 53 ++++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_pci.h           |  3 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  1 -
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 34 +++++---------
 7 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 8d864d4ed77f..79f17100f70b 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -53,6 +53,7 @@
 
 #define RGU_RESET_DELAY_MS	10
 #define PORT_RESET_DELAY_MS	2000
+#define FASTBOOT_RESET_DELAY_MS	2000
 #define EX_HS_TIMEOUT_MS	5000
 #define EX_HS_POLL_DELAY_MS	10
 
@@ -167,19 +168,52 @@ static int t7xx_acpi_reset(struct t7xx_pci_dev *t7xx_dev, char *fn_name)
 	}
 
 	kfree(buffer.pointer);
+#else
+	struct device *dev = &t7xx_dev->pdev->dev;
+	int ret;
 
+	ret = pci_reset_function(t7xx_dev->pdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset device, error:%d\n", ret);
+		return ret;
+	}
 #endif
 	return 0;
 }
 
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
+static void t7xx_host_event_notify(struct t7xx_pci_dev *t7xx_dev, unsigned int event_id)
 {
-	return t7xx_acpi_reset(t7xx_dev, "_RST");
+	u32 value;
+
+	value = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 }
 
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
 {
-	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	int ret = 0;
+
+	pci_save_state(t7xx_dev->pdev);
+	t7xx_pci_reprobe_early(t7xx_dev);
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
+
+	if (type == FLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "_RST");
+	} else if (type == PLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	} else if (type == FASTBOOT) {
+		t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+		msleep(FASTBOOT_RESET_DELAY_MS);
+	}
+
+	pci_restore_state(t7xx_dev->pdev);
+	if (ret)
+		return ret;
+
+	return t7xx_pci_reprobe(t7xx_dev, true);
 }
 
 static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
@@ -188,16 +222,15 @@ static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
 
 	val = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 	if (val & MISC_RESET_TYPE_PLDR)
-		t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+		t7xx_reset_device(t7xx_dev, PLDR);
 	else if (val & MISC_RESET_TYPE_FLDR)
-		t7xx_acpi_fldr_func(t7xx_dev);
+		t7xx_reset_device(t7xx_dev, FLDR);
 }
 
 static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
-	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index b39e945a92e0..39ed0000fbba 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -78,14 +78,19 @@ struct t7xx_modem {
 	spinlock_t			exp_lock; /* Protects exception events */
 };
 
+enum reset_type {
+	FLDR,
+	PLDR,
+	FASTBOOT,
+};
+
 void t7xx_md_exception_handshake(struct t7xx_modem *md);
 void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id);
 int t7xx_md_reset(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type);
 int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
 
 #endif	/* __T7XX_MODEM_OPS_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 10a8c1080b10..2398f41046ce 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -67,6 +67,7 @@ static ssize_t t7xx_mode_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
+	enum t7xx_mode mode;
 	struct t7xx_pci_dev *t7xx_dev;
 	struct pci_dev *pdev;
 	int index = 0;
@@ -76,12 +77,22 @@ static ssize_t t7xx_mode_store(struct device *dev,
 	if (!t7xx_dev)
 		return -ENODEV;
 
+	mode = READ_ONCE(t7xx_dev->mode);
+
 	index = sysfs_match_string(t7xx_mode_names, buf);
+	if (index == mode)
+		return -EBUSY;
+
 	if (index == T7XX_FASTBOOT_SWITCHING) {
+		if (mode == T7XX_FASTBOOT_DOWNLOAD)
+			return count;
+
 		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_SWITCHING);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, FASTBOOT);
 	} else if (index == T7XX_RESET) {
-		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
-		t7xx_acpi_pldr_func(t7xx_dev);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, PLDR);
 	}
 
 	return count;
@@ -446,7 +457,7 @@ static int t7xx_pcie_reinit(struct t7xx_pci_dev *t7xx_dev, bool is_d3)
 
 	if (is_d3) {
 		t7xx_mhccif_init(t7xx_dev);
-		return t7xx_pci_pm_reinit(t7xx_dev);
+		t7xx_pci_pm_reinit(t7xx_dev);
 	}
 
 	return 0;
@@ -481,6 +492,33 @@ static int t7xx_send_fsm_command(struct t7xx_pci_dev *t7xx_dev, u32 event)
 	return ret;
 }
 
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev)
+{
+	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
+	int ret;
+
+	if (mode == T7XX_FASTBOOT_DOWNLOAD)
+		pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+
+	ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot)
+{
+	int ret;
+
+	ret = t7xx_pcie_reinit(t7xx_dev, boot);
+	if (ret)
+		return ret;
+
+	t7xx_clear_rgu_irq(t7xx_dev);
+	return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+}
+
 static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 {
 	struct t7xx_pci_dev *t7xx_dev;
@@ -507,16 +545,11 @@ static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 		if (prev_state == PM_RESUME_REG_STATE_L3 ||
 		    (prev_state == PM_RESUME_REG_STATE_INIT &&
 		     atr_reg_val == ATR_SRC_ADDR_INVALID)) {
-			ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
-			if (ret)
-				return ret;
-
-			ret = t7xx_pcie_reinit(t7xx_dev, true);
+			ret = t7xx_pci_reprobe_early(t7xx_dev);
 			if (ret)
 				return ret;
 
-			t7xx_clear_rgu_irq(t7xx_dev);
-			return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+			return t7xx_pci_reprobe(t7xx_dev, true);
 		}
 
 		if (prev_state == PM_RESUME_REG_STATE_EXP ||
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..cd8ea17c2644 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -133,4 +133,7 @@ int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_en
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot);
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev);
+
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 7d6388bf1d7c..35743e7de0c3 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -553,7 +553,6 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
-	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
index 6a3f36385865..4ed8b4e29bf1 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
@@ -59,6 +59,7 @@ static void t7xx_trace_port_uninit(struct t7xx_port *port)
 
 	relay_close(relaych);
 	debugfs_remove_recursive(debugfs_dir);
+	port->log.relaych = NULL;
 }
 
 static int t7xx_trace_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 9889ca4621cf..3931c7a13f5a 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -213,16 +213,6 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
-static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
-{
-	u32 value;
-
-	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-	value &= ~HOST_EVENT_MASK;
-	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
-	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-}
-
 static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
 {
 	struct t7xx_modem *md = ctl->md;
@@ -264,8 +254,14 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
+	enum t7xx_mode mode;
+
 	ctl->curr_state = FSM_STATE_STOPPED;
 
+	mode = READ_ONCE(ctl->md->t7xx_dev->mode);
+	if (mode == T7XX_FASTBOOT_DOWNLOAD || mode == T7XX_FASTBOOT_DUMP)
+		return 0;
+
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_STOPPED);
 	return t7xx_md_reset(ctl->md->t7xx_dev);
 }
@@ -284,8 +280,6 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 {
 	struct cldma_ctrl *md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
 	struct t7xx_pci_dev *t7xx_dev = ctl->md->t7xx_dev;
-	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
-	int err;
 
 	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
@@ -296,21 +290,10 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING)
-		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
-
 	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
 	/* Wait for the DRM disable to take effect */
 	msleep(FSM_DRM_DISABLE_DELAY_MS);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	} else {
-		err = t7xx_acpi_fldr_func(t7xx_dev);
-		if (err)
-			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	}
-
 	fsm_finish_command(ctl, cmd, fsm_stopped_handler(ctl));
 }
 
@@ -414,7 +397,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 
 		case T7XX_DEV_STAGE_LK:
 			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 			t7xx_lk_stage_event_handling(ctl, status);
+
 			break;
 
 		case T7XX_DEV_STAGE_LINUX:
@@ -436,6 +421,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 	}
 
 finish_command:
+	if (ret)
+		t7xx_mode_update(md->t7xx_dev, T7XX_UNKNOWN);
+
 	fsm_finish_command(ctl, cmd, ret);
 }
 
-- 
2.34.1


