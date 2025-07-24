Return-Path: <netdev+bounces-209803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97470B10EEF
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A91AC1133
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE692EA74B;
	Thu, 24 Jul 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EPKtrs6J"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A22EA462;
	Thu, 24 Jul 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371774; cv=fail; b=VpBrbeQ3ClLLIgDaNLJO+NE0vQRqvUAlh6PRvuiPe/8DIyCPBYZoKKTbxkXKy6k7st7i91dlMWe5KalLWU7ZFWx1i4QyuPQE8oXlsOQdzAYUmgVq8GnF+Cjqc3IRnqQ5F7hf2QzdtUH/p9rdfHoHx9oBOUcfFiR3h8IkmbsGt7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371774; c=relaxed/simple;
	bh=nEFm1GyuX7d5ymp9B+9jPyDO3LoDBRA9bhYVuKTnguM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i17IfU2ekFr0iSiyQq3Gops4fpjf6JrJcOqutJaFYyG5Fx1WNdRh7HVDHVRMY9+pAXHkjzVQjee4zOvjavoB+zXZcMXlxt5LDsWvq7DP56JjkhfxTYxmd3+gdSXJinH6G0Aa1NnJ4W5LGRXJy2bn1bm8lrQuyibSiH9xWLK0+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EPKtrs6J; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLzucR0tOxpMY+AT9v+OcsQZlFTDBvbilUeCn7WGKsFlvTwe85jqihuHaxDgglLR5+LnftYQeAmIfxt6ufkU+t/MPrp+mMbgw4/rKoI4nml959fPDpurY+2ynAfpVXh9L8D7MR7K/+lGDzXQj13YbOKU3fS4Zy6pOvzxhXsISEGNBnS0Aat7GsRoBHaBCzHDfuUVRovT9TFo/zuBc0bHKN9Afg54ctnXyOmrdS/UYbvlnl4LLBIrB1eVsQ5mYnm0TLYx29+p4cz8BznxSE0KNfG/lB3JPEKRjS1Waoa9JCroS0fjb43wCXlr1vGgkg6K0RGlr7qU8F0SYfiic/btPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaRsvEHSX2gFxB0Edj2htj9JRGfeUZ7auuG1Yikwa0w=;
 b=f23xn6iWI+6C0fRuy1iil2eysR3vFaEbgwM9q9AUquWHR0VU8tP6j+nqXz2G4p0Urs1FVvJ61eR2NwH9Ji3BXSbLOWXzZUCUW0z6aUCSzq++fpoUK0ky62FYH/l1o7Gp6yERrrt6pu1Pytk5E+SlwyDVBClH+0IqELCoWHbZ9ljsbVIRYODNWI2svZCcs7G8IakkyO8w9AIzkJ/HIendweYmKAQEXGhhlFzLDRuyW4EHcVq7sf9AUyFCMApmI0TnozgcuR6K2gGdfkQvarH0WUWHnVnlZ5/8uNVie9e0t8jCZuJe1+xRc9wlaboPNEQ03aA1U8UmO57d5tdbvWyN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaRsvEHSX2gFxB0Edj2htj9JRGfeUZ7auuG1Yikwa0w=;
 b=EPKtrs6JukCAYe/1nTgTZROMfT2KSVwV+YuSrlUcMtvhz+F2+/1+zhVAz8C/lmQEzqlvKr1sCdA2I8IFod6H6Kp5fRf6JOh/Sw/abiSWKwS71Ax18MT2Jg0uqcJ52gG/3RTq6WKQ6iF0GJEVhDC8+ENXJKSINGLpAPRiHw748mS09YDaXBeyyBGEtRl8RgKv8QkNgP1Whs0Bu5lKPA9t1AxK+UDnhJ674awVTiyiNbEj5THe3mU2gI4NrIO1OsiGFVmdPm+vdv7+IoqeejPSadP/P58UFqLnk37l8YJV4C5VvMPZWepIFkEItdb48EHdvNvAnx/ImU2gTWYRk0wUTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA6PR03MB7735.namprd03.prod.outlook.com (2603:10b6:806:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 15:42:48 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:42:48 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 1/4] dt-bindings: net: altr,socfpga-stmmac: Add compatible string for Agilex5
Date: Thu, 24 Jul 2025 08:40:48 -0700
Message-ID: <20250724154052.205706-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724154052.205706-1-matthew.gerlach@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA6PR03MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa0d7ad-64e7-401f-ea2a-08ddcac8bda8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pRhz7TKTt/YNeiiFlcUUj9DG0148GwXV+7OZRWnPwqyYR0NRL1hnhvVidTSu?=
 =?us-ascii?Q?2sQXPJnI21/oNaa5upQg927qRTcw6/CPN8cBqoKkfvB2gDhqRkNGE96Vmdg9?=
 =?us-ascii?Q?Y7DXlxDvwUclmoxksaVkePtw7Ne47ojcgEytNHrWlm0wBvrDsDNdcanxNAdv?=
 =?us-ascii?Q?Lzz9e0iKN9CoV6lolbGeHGOsxkMKzrKgw8DDqq4xhLyK8CMkENTm3ewVChis?=
 =?us-ascii?Q?O/PGMYA9K4a6h2/FK/ReQ69jH8idq7y2LprbjNZsnZkAn5ckVPF7VIFRBi+D?=
 =?us-ascii?Q?y8nL6zbx9wmBrh7KKlcRLjQsOge8EbXeYENUR1uIO7zvto3Wz1vjVgpEnFJS?=
 =?us-ascii?Q?939obO9JCw85TFRrX6htDrx7m0Y151mtIagkpTAUTqwi740OaQuPgUCqktH9?=
 =?us-ascii?Q?+xtqH9RAQupUSpa4byQEmpDJzIDAMaC5oOg5Hz1WLx6Ok0xu2K1smvCVgAku?=
 =?us-ascii?Q?uDSydCb8ZP6XxA0SPAHDaTmkvNSkbmRQBx1G83xVd9QIaRq5gITPz3CDkG85?=
 =?us-ascii?Q?zKyoaFvOoewPWxndOI8yjt0QGti25kbxhdtJJaby5wOLxB8460JeYdbog/m2?=
 =?us-ascii?Q?2lrxvmJEDGXqeIulsqjTLIMQKz8DfkfNjEQMgO9ILwNGXSGJAqUykF7/A1bf?=
 =?us-ascii?Q?vdShQpG1D7g8fO38mjqLyjtU5xQuCddnyr65lStzPvfF51liBMgyAJR/Ik38?=
 =?us-ascii?Q?2/taQ226M6fQnpMcIVvIeG5t5EultNGKniSoHwNwMV4OubgBogNBH2WFMVHw?=
 =?us-ascii?Q?oehsUJxoUgfthXyH2c7IVO/QkQQPJhEUyYnUd+2IItncS1mdadYdWmurdSZu?=
 =?us-ascii?Q?INamLPqzAotzraC0drpnJnikBLiWHejAK7gzA2RBXFFVxadc1G53pkOk6mhb?=
 =?us-ascii?Q?RocIXxl2XAi9QujOTVUblyZuQ8YjxHM+eyA7oc25sg0WW+VxLcmdVZqbD4I7?=
 =?us-ascii?Q?BK4l6gx15kLsl0EPEbMqaX8VEWMlcJ1Dah/eXoRMfz3dh1sGOHmpQmHj+fvw?=
 =?us-ascii?Q?o4YBwrbvIB79/FNwZuiIsx5TcG2vIeiRyfPu8103YdWJ5pzuU6XNRNg1war+?=
 =?us-ascii?Q?CsHvYvoEhPKf5EipjSGktUw9pCDLPGudcYBjvMJjwsfZNS6yQKtTZvzlikE4?=
 =?us-ascii?Q?ggFUrRJHVZLB8GJ11xX2jUXiS9bXmlUr67wk+krz2QPo/YW1HWGYOiw2zGsE?=
 =?us-ascii?Q?9FawB+9GPgxWPunX7hoq83WANyDo7ZiwhXVGjQTpru+8Rf9HYEyjXy7fyXwB?=
 =?us-ascii?Q?ge/SU3OxOtcCqPKk/gVEs+NXTnhL3Zt/0Y9TXGAzqF8fASLxGrTLBm3ybNyJ?=
 =?us-ascii?Q?Y5tRkPWqwILb5ERddmlqTNNxJO65qCtJHCft98e9bwWBXlgTOWi8mkTzB/S8?=
 =?us-ascii?Q?+ve2ie4Q6DcRKQVUPaO42zScfj8CkPqNW3rNPyn5Gl5lJJGyniqgtdnr0TfT?=
 =?us-ascii?Q?Ad1NC5n0S7/+x5VvKNlXAl+FxlAnSieUUpQd+hr2HD2d2Q4eid9j4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOHHVOcarF6NC9VbwLsstHacsThWuLxXqYff4TxfynmqQ25LkWgLjC36UnDU?=
 =?us-ascii?Q?GfxykpXDvvfdFQNPvgUutqORl0Xsb4dqqkcmlqDcPgtH8vGObt1xcyB9e8rE?=
 =?us-ascii?Q?elMqidN3Wl4Z0JNV0lf5eDg4Ek+QsgUypdyvFdBHzJCesXcBs+w0cR7jCnhc?=
 =?us-ascii?Q?DrJhcu07719t0eHIrIxzLRnh6+qosqbB5rVOslyHXrk1nsPj+WIEAHvc952u?=
 =?us-ascii?Q?9SQwNG2m4ggfLBP85tSucjeW6m3A0dw5ZRsCF+Yn68R/ImrxvAWvIjTSo0vt?=
 =?us-ascii?Q?Fn2qNDhnrOvD28J7Cz7vZAd40jdZRUOVCh6wMZXl/Gkk9/uHF1JMhQ6yP/BV?=
 =?us-ascii?Q?6xZCkCyi0g7to2xS1OQO1QWIllKwOses+xtpVTBzQLt9OL2u+6/3ADjLo5Eq?=
 =?us-ascii?Q?IKrZCKugF+stil+9jEYnur++fNPvTsm8B8RbqzD1NGTpB+5mdqZFq1Nr/SVg?=
 =?us-ascii?Q?jzHNVjybRLIg8MmnO45u9nhVmjRmQkppL4DPguI7Bnh1lNL/2mimVvwhZJVR?=
 =?us-ascii?Q?hAA3QevgI8jLKUQ9VWIVQpUykSE437A1KSwGinK48mau7H3GlV6fFPVJM21v?=
 =?us-ascii?Q?KkeWEq187JYMXVXwwhWqGF3Q1rlRULHtzhNXrynCnTYWvZcyXe0dHrRVdeLI?=
 =?us-ascii?Q?l7sWmFScyTYF+wlLIOJg8Q4aUK1EnTiqUMLHhQ7ZnonIy4BsWvGy+2G1gzrv?=
 =?us-ascii?Q?LtJ8AS4wKdkkGjMO9yUA2V+xCI6eS1V2MSl+aL3Z3mm/yELDehpvcuye7Vwp?=
 =?us-ascii?Q?zbLnVwTvYevlUsbf/4DPyc+g9daZkJx/smuIbuxnMtzZWgnFtd46/Sq1RNkC?=
 =?us-ascii?Q?/FjHE2uW7WCTxcgIwQgcVH3dJMn9SgVolJ9SdbMNnzB88eSCt8wmgpYKFFx7?=
 =?us-ascii?Q?+apkcXfzgwLiAnXEUBktvQoXQNkJU5EowQEJUAetG3Hp27s3TMBmC6MsJEg5?=
 =?us-ascii?Q?BrlS4wYNsn9kEatpfjoyXgxAgLHvwY9FaUxG0cWP1M5wRF1ue948ze3K1VFU?=
 =?us-ascii?Q?lDMWF0juKwgCU7WxkJnTB9xTqBby5Fhfhc1TwslNd0lAzDAGi6Dl32m5pXLl?=
 =?us-ascii?Q?qufug6zpdWJbc6NOfCnRLtyBjk7H+sP6x5eDq6/fedzGDfTbhs/+IyuqiWdd?=
 =?us-ascii?Q?NamOD/BN+1cAc7AoXY+py504mTvFSlN2QI9QDLRQEFr061btVu28/aPw7CCX?=
 =?us-ascii?Q?pJ2AEkVOTSYnVzezVaSeBxFu7i96pr88wdZjVT4qrZlUnSPqagAsNoqt4vOZ?=
 =?us-ascii?Q?3H36GTHHY9uui+Y0+qfIOc4NXNKZFRfV4n9GGVwke273Lgoihy13jcNLLFtZ?=
 =?us-ascii?Q?V/kFzKKZ3RBomqRsqqbfNQ3Yj9ohCFuEWeXK+GQAmfgT5tvAGdfFYLibC/9Z?=
 =?us-ascii?Q?gpYldXBIimhtxxFwZxjvEi7B9IhDeKqhN6TMA1y6E1k6qV/6avpB86Mhzydb?=
 =?us-ascii?Q?YpxFdt7vk4M1bYQNy2E9/bsYD+ZIhJxWzIlknmCDkdQogy59rnOSlMvcS9os?=
 =?us-ascii?Q?wP1+d0w5RlM4O6FMLR2rC9Si865gOsjkXxxrc1xa5gT0RW2vyASpxFzxThsk?=
 =?us-ascii?Q?m19X/XqeRflnF4bGQonUCWVfOhCIYsOTDaC5dm9gU8s4cVnJz8NmC0Io6XF1?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0d7ad-64e7-401f-ea2a-08ddcac8bda8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:42:48.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FQjovAIqa+zCkgKDLUlXUZb5gn1WWBb4dlHYxauRQ6AxCrKArICCsvOEP5Ye3x3Yqcujd0Jk/1mh5HdjN+z8hm98eripY8NIT+AZ15Fo0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7735

Add compatible string for the Altera Agilex5 variant of the Synopsys DWC
XGMAC IP version 2.10.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - Remove generic compatible string for Agilex5.
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index ec34daff2aa0..3a22d35db778 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -11,8 +11,8 @@ maintainers:
 
 description:
   This binding describes the Altera SOCFPGA SoC implementation of the
-  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
-  of chips.
+  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
+  families of chips.
   # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
   # does not validate against net/snps,dwmac.yaml.
 
@@ -23,6 +23,7 @@ select:
         enum:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
+          - altr,socfpga-stmmac-agilex5
 
   required:
     - compatible
@@ -42,6 +43,9 @@ properties:
           - const: altr,socfpga-stmmac-a10-s10
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-agilex5
+          - const: snps,dwxgmac-2.10
 
   clocks:
     minItems: 1
-- 
2.35.3


