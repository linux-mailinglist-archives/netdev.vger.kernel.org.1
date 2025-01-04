Return-Path: <netdev+bounces-155117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB69A01226
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 04:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4881641AA
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213D1474D3;
	Sat,  4 Jan 2025 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="F8yru7BF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2099.outbound.protection.outlook.com [40.107.237.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863686252;
	Sat,  4 Jan 2025 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735962892; cv=fail; b=IoI0vyLsVtSjQ6i1WYDCvQiDpBkI+d0DhfwF/RZa2XCTjo7THI2zM7x0RErAQcnp9y/K/AYK+VIU/osZW0cJXphHNyJ4vv0Hnan04tQpupP2t56g7JX6VHpNnwxFeXczabO+ebKpn/pWhG8XRDLU3aQFLTSJ15xxRBp7h2XHYwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735962892; c=relaxed/simple;
	bh=bYWwSwVCyVr4xhXEb4VuTN9V0H86VS1DEbpUb63b5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ijouk4KrX0ab7Ga7suJVXH60IJy+/R5LvGbM0BiyqfOuU75IqaiO9oBjRGWmyOvs37YNLN2udVZEbmy1iSmvg38xl9nv6y8Kf07rh/cJjGnnaXSzAiicGxa03x6bOXUcu+i1a/77f3BN1Ij5sRwzM+k77UQywBqb9udqgm2UXVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=F8yru7BF; arc=fail smtp.client-ip=40.107.237.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUQU7vzrGIJ9RGKPyJmQwgc+pI+MFesLUBmuTuwTd3216jm5QQ96LFO3Rb5FwsWXAmkD8BFGd3VDN5aHeb71tLrO+JPDojvOGjm7DnmeYB9OPqe9dQ2/oPDFfE+PDw/Wff6qMXoAksz0MvFItNkn21bob8b2SI68FA4I0gQWvHotCyaUStfXYdugYCbMsUF3oanL6NYCYNxFb5otadsXbwj1d6Ki1HubGNzdkZgRJWGhBQ0qPu/g+qLbpWO0XG7kc0uY1Wsvy9vbmkyXBVI/3sjiwZL3VBu4jb6rIVyOyYpWlw0C2tVBj57kJ1Op1fKwefMGWGaMJ/zKg7QyhMICUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ong3syvmC54qm887GjwTxX2r45D0SsJT3xlRDu0BVqc=;
 b=UEHCQZgUxUJ5bivMXYXXIPvWhVrd3KMN/olAg+S8GTPkZZSjJpSvQb2QoSX+2oJKfPw0NdQyNPQJJJ3T6LaCOiAyjKFCInyA6GgOFUDOJjpYKdvT/RMkPVmbBpCTvh7v1RPkpdKNHo6LRUbdbKNITb0KbBCkaDBl7z1+RsqLXCX+cZzp6u78oEdSG9krh8KBepj0YHezKb2g9yt1zTOTc6M0/xAoSFiTY6aIf3avSJhxGOyt+9uPdH5fN9/9/MZ5ek5OWwGs+TXAKMMMRQd+tZTHZ6HAShlnIV225p3pWIRyEFMYRFp+JQA9JNBZhgFfT6j/cGw7/ezL4IvKbCcBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ong3syvmC54qm887GjwTxX2r45D0SsJT3xlRDu0BVqc=;
 b=F8yru7BFutPSyHhvObWfZKyHbzy/WeanVHH8Jly3bpaKuFOo/DqbGDum2BCAVTmDR8soPiLC3V04QTUrY7thFy3gHwCiswY0EhPcp/N+XWoxFmuuXZngySmldX9SkuMB8FnxVBEIpIwphfdWQlTR8XjWZI1Alo4Oonivz6s4AkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH0PR01MB6891.prod.exchangelabs.com (2603:10b6:610:104::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Sat, 4 Jan 2025 03:54:43 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8314.001; Sat, 4 Jan 2025
 03:54:43 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v11 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Fri,  3 Jan 2025 22:54:29 -0500
Message-ID: <20250104035430.625147-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
References: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH0PR01MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd33cab-c68d-49bc-5d93-08dd2c7385e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eRJzBuB6sF8Fv9U6m4qwmaCj3Ql4slw8YPiDNdB20XXEzY6c3YqLvXyDpJiS?=
 =?us-ascii?Q?WUoKU1RJisupUmR0UgzNYi7hRPv0/EOm3p2ah7lhrS4bIDZBotNFoVX8uyyT?=
 =?us-ascii?Q?pMfd/D6cimuop3FJChcpXOZO6XAnJedEnPbPmcT92RkjZ1iM8q2+I3GYZHFl?=
 =?us-ascii?Q?TJg3jJZCkx25eKPTAU4YJSZKCo2eBFZwtpAgwce7QcO2SGi92WptE0hGGsCb?=
 =?us-ascii?Q?91HGxNLXjOJUHhu0Mnc0fx9vsvxkB3/UNRqRJNuIi2p9hujZJUgEiEqDweH+?=
 =?us-ascii?Q?v/l4ckUuFgC2KLsARMSW7LEhZaK9bneon6ckfj7HfbzU9/Wn1QZXValLgqbN?=
 =?us-ascii?Q?zudlRPHDaT3ImGqCbt/TvE8mQax2BmQtMPYwx8XFUsrbywadXsZjuoG+5TIN?=
 =?us-ascii?Q?Zg7hDnG0235BHUW5dAuZDsbmT0y63hT2z/V5/cz8QMyojDapb8dsbdrm5Ojt?=
 =?us-ascii?Q?zw1G7wtm84FpIGp+l+pGhg/wM4+GcI3kwHNkFIGxvcTUZwt3YW72pOz49eqR?=
 =?us-ascii?Q?LBdrHak94LV4zTgGGKvQZjcpDNpguOxsEdB71Ir/EfqZOCe6vTNlu9Y8YFHn?=
 =?us-ascii?Q?UWA/iMd0UkBP9d5pk7qLQABmDua77zVhiWGondEXAlaifvOZy12SKRY6mrlN?=
 =?us-ascii?Q?LSS2dlZ/FVlPFc8m0JrPf3tEX0etxh4QpbHFIsY2eei4iLIxmwcqlMqHci+e?=
 =?us-ascii?Q?7lyGZHGKB5RETlzLG14kxTaEbRpi6GX+5M1Px3PfWv+oRTMXDPp4OIqb+0PV?=
 =?us-ascii?Q?JUTQTxVEjyRSEEFe+PNOgurbg7qcEVakE08UKCFXVna7gmD9+gVCiVbuQh4O?=
 =?us-ascii?Q?NIQYiT1ys7a6O9cljF4xJSb2PA/d5OGXLy0ZscGM52uX15Ce82Gh/MXYAPsU?=
 =?us-ascii?Q?XPyRs6EplLetO7sxO6qr0MKM9ItQtoIyNSH+cg2t51iBe0WD/pIL96DL8gHi?=
 =?us-ascii?Q?2khC5mdBkMMZlDbUlt047s4p4I6/hO4IP7nzkUFh5YvYZrdmYzc5hFwMl4C2?=
 =?us-ascii?Q?q5j49s/6EbrjUkBO/mhoagHEulQa3ok4rUMhkpFu3G1xJLmHMUXtxJG0EQUp?=
 =?us-ascii?Q?U8XqxrnGxEineqTTmb7AGLt8yoAhgojrgOMSnpA2h3qWBDM0svotumuzUatx?=
 =?us-ascii?Q?qvd0TO2XqygBj4HuZm4gdMoAxWevMrEQUEHDImnzFtIdlFULuH1I3NaE2nRH?=
 =?us-ascii?Q?suJU+Y6LEN0WLkswv03AflXJH9YHCxOmMeTApqz+jrew504W4O3jPxg7EUnW?=
 =?us-ascii?Q?ywocw6NQ3hs+nuy4PvZYh0CGl2yqgCv+3eHe/O+Fbzo2hjthrhDmuyQPye/B?=
 =?us-ascii?Q?g/u4DGEILOHWmLttwc1t+eczXeOakWMMFk6Eaqpwhs6ljp+ZVF1/9FZuZ5oQ?=
 =?us-ascii?Q?7gKMDUFpo1HfUlFZBXsv7EuwpI3m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LSAJfrnI1SlnM0oX+MFHBhN7J7SBtEySk++g7ev/UwRWozADb/lGRxf8tnSF?=
 =?us-ascii?Q?Dgwxfkcgm+fdPsTqB6Avt12Ryt8pyI8UxzVuvCxY+68UL3XQdnQnNtU92we2?=
 =?us-ascii?Q?erPYCYIwnwrjFcXbMEfFeoiItoUZ92XUk8LGe6cRSvF55J3YGABZ7fJ1+Y2j?=
 =?us-ascii?Q?pmxEIC+B+qZx7YlYUz5jFE26yF09qWDaDymS0ieozne0OAe4DpqlgVu9YtxQ?=
 =?us-ascii?Q?/qgGFEVi+/j/yCLF9JbFbsUcECoG5wLIBiIwJAwwHrNa+pAn/FoNm4njbYVL?=
 =?us-ascii?Q?Vdwy4XViX3qzDBTG0APp8mFCv8MEka2ZOJa3FSHL6sLCDi5rHkenlfJi1JUV?=
 =?us-ascii?Q?FxjdR4cHmEAmkVgpAsTH+HIuBJ6ncVBj6A9+1qNjg0zeSI7ZojSMxP/K4XLr?=
 =?us-ascii?Q?fXIX6pl0BUzGXGTXuh5Tge0O32BP802z03+hsmpDIDuuOe450XKgGyL5VUOL?=
 =?us-ascii?Q?Vyzli19yBmc+5cAcq0HzuwCvzXcXNtwMzn5ZBXP+or++OwMhYBvN1mCxaps2?=
 =?us-ascii?Q?fvNUNVMZaxFg9OBt5+X/6EqfBJLNsP/dgp7e75FWsOWxzoni9Jqi4vr13G8B?=
 =?us-ascii?Q?I9t1/BzJLW04JmcnGEMRJsJfwnlfmCfbb04srtNPAQVVaLfawmXtB9HZIWoJ?=
 =?us-ascii?Q?whDbgUiybhstxE6qSmYdH6SXrZvq65bk/kRXY2DyIIRrr47ur7Cu1ApRHtmk?=
 =?us-ascii?Q?UpwZxoJ+vCipK9NrX++OuPWDks2nLins3mxPRnocK3adz7axHoOOuqiNnp4O?=
 =?us-ascii?Q?TOXLXS434xloajX9s82VJdCmGGLR0EfiVP1Sp14z6117E8AZXpGb3kHpn8/y?=
 =?us-ascii?Q?eiDaK943qoevPU5UNOylSy/hVc+WDfK+Izbe1JuXIQ4ak9XWzVcGPHct1U3/?=
 =?us-ascii?Q?8ll2XAev1PpPNCzax8ujTQ1fpwBt6F/IX0MGpbcdpZzJtplNH/HkVhHthE+U?=
 =?us-ascii?Q?LT9WDKydR7Pt+N2tiqJjsVbH3a2SgcuiPmd3CVL4kWGrPfIvwfEUUYLH7l7l?=
 =?us-ascii?Q?6scWRT1UFsuoBKn10l1CQXM4udgbnEmuCZifgv9sPDrWeN4X7rY4HYZ6Aeci?=
 =?us-ascii?Q?ehlGhqaRFUZqupSa5u5nswZ596ppmn7PTstI+qUOVtAbe2+/icoynRxhXtwZ?=
 =?us-ascii?Q?6JeLQ+oIat7C7DJ+d9ofDv9t/tP3xAGeVLuFWnhUlrdjN14HXKtJPiygYsfl?=
 =?us-ascii?Q?xJNthv15TnOg26LbazZEeU4QU3FrfZD5KHHVmL6T1VVGTANlP0+hznCZgrVe?=
 =?us-ascii?Q?l96Jiu4vnRU80yNZXaVOj9DERTyRsLkpXQucPVjuzh67r8bHHlIfbLpSQDzN?=
 =?us-ascii?Q?olFQQWfoZGVYWDMKColYhWbo2d1e/EW/zdkx+OJFs4vV1rIRzWCKoYDMR2ZD?=
 =?us-ascii?Q?oiR66HgRixiHvS2VTxyS5Nc42tgyXZbJViDOKTHODtooUqIIpHwl68jc4zFV?=
 =?us-ascii?Q?MrsBKHH324ehi5eqbd5GomHlKwwS9ArEI/LLJwJvkxHi18okAGvPXHCXTRQc?=
 =?us-ascii?Q?TCA4CLaJ+/vZYS4pnXAbwO9nbDWtG3z5/3WTbUfkrTYACQLIMOhcqhD8WPRz?=
 =?us-ascii?Q?A7N5MHIjTcsUiLuibbBOeddTYZCr3deMC3z1xl3aWQyXFIEiFCfv2E6MKRsN?=
 =?us-ascii?Q?tW27DTZ3NZYmlg52d7IJuBCdmLNOWYoLulQQHRF7rj6bgaWBQFXOX2K0VmxX?=
 =?us-ascii?Q?m53O5u5ioAFTCTLj/KLGiru+AHE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd33cab-c68d-49bc-5d93-08dd2c7385e0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:54:43.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mov23hx9PdvNcgBcoGsHcy1pZfiX0zzJWprnwHDJlKr8mnYF3CWkWVhmyF9NEu6Bkn0sZ8PF2eSKIgPCZwg0lSKkHwYXUxoEX6FCapMcTeYECH7MF8BRZsvhCMn+Wiok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6891

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP devices are specified by entries in DSDT/SDST and
reference channels specified in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39f..073eb2a21841 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DST/SDST that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54a..492a9e47638f 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..4cd66c0ded85
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024, Ampere Computing LLC
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <acpi/pcc.h>
+
+#define MCTP_PAYLOAD_LENGTH     256
+#define MCTP_CMD_LENGTH         4
+#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_MAGIC               0x50434300
+#define PCC_HEADER_FLAG_REQ_INT 0x1
+#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	char mctp_signature[MCTP_SIGNATURE_LENGTH];
+};
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	/* spinlock to serialize access to PCC outbox buffer and registers
+	 * Note that what PCC calls registers are memory locations, not CPU
+	 * Registers.  They include the fields used to synchronize access
+	 * between the OS and remote endpoints.
+	 *
+	 * Only the Outbox needs a spinlock, to prevent multiple
+	 * sent packets triggering multiple attempts to over write
+	 * the outbox.  The Inbox buffer is controlled by the remote
+	 * service and a spinlock would have no effect.
+	 */
+	spinlock_t lock;
+	struct mctp_dev mdev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_hdr mctp_pcc_hdr;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	void *skb_buf;
+	u32 data_len;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
+	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
+		      sizeof(struct mctp_pcc_hdr));
+	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
+	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
+		return;
+	}
+	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_buf = skb_put(skb, data_len);
+	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
+
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr  *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+
+	dev_dstats_tx_add(ndev, len);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
+	buffer = mpnd->outbox.chan->shmem;
+	mctp_pcc_header->signature = PCC_MAGIC | mpnd->outbox.index;
+	mctp_pcc_header->flags = PCC_HEADER_FLAGS;
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	memcpy_toio(buffer, skb->data, skb->len);
+	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
+						    NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static const struct mctp_netdev_ops mctp_netdev_ops = {
+	NULL
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = 0;
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	switch (ares->type) {
+	case PCC_DWORD_TYPE:
+		break;
+	default:
+		return AE_OK;
+	}
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static void mctp_cleanup_channel(void *data)
+{
+	struct pcc_mbox_chan *chan = data;
+
+	pcc_mbox_free_channel(chan);
+}
+
+static int mctp_pcc_initialize_mailbox(struct device *dev,
+				       struct mctp_pcc_mailbox *box, u32 index)
+{
+	int ret;
+
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	ret = pcc_mbox_ioremap(box->chan->mchan);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0, 0, 0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	int mctp_pcc_mtu;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	//inbox initialization
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto cleanup_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	//outbox initialization
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto cleanup_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+	mctp_pcc_ndev->mdev.dev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	/* There is no clean way to pass the MTU to the callback function
+	 * used for registration, so set the values ahead of time.
+	 */
+	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
+		sizeof(struct mctp_pcc_hdr);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	/* ndev needs to be freed before the iomemory (mapped above) gets
+	 * unmapped,  devm resources get freed in reverse to the order they
+	 * are added.
+	 */
+	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
+	return rc;
+cleanup_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001"},
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


