Return-Path: <netdev+bounces-186882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F4CAA3B78
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377D21B65DD0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB72750F1;
	Tue, 29 Apr 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ujd42siZ"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020098.outbound.protection.outlook.com [52.101.193.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56D2749E4;
	Tue, 29 Apr 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965693; cv=fail; b=Ym6Y2FRkzdPrxpvSllj4Vb3BsSbXzavdYmdr9kBHmS2k9br53PQZGtOdOcKeATf8F5B5mG4firCUipgfNt4GG/4HCK5e7uc09L1Q9zCtawVyVaE9ChYsk4fQ8RQ8RYARs+ebntLxv81W/aoRpd2SR4SuQ9Ii/Zvx/aSyV+Q4X38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965693; c=relaxed/simple;
	bh=0H4Q6kT9EeySX+G1/1ECvKRN3tbAs3qqNLUFemCunlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNmNhVQ/iep+f4rv4pB374fFmXy+iHguJXdSweV79uAjd2RZa93RMAMy1Xw151myzYCEBtzBCgNLVnbWlwY7BFiCpc1BcPMxNLPwMJWWsBNh9j0h/6NkJ+arsR3jTiA81AnMilGtCzKq0DNtZ0w9CLqNdkorX9Cj7qssYwj8axc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ujd42siZ; arc=fail smtp.client-ip=52.101.193.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dltHU+heT/8eZeGK9j8QcML9QPpdtwMEjNgfk+f8+ZJxLlTXjCxbfGhCpu3MBYkxBLZNABe4/caDq7vnaJZm+oqE4fS91OYKtc6VYSeqBzxVvn02QwKYNa/roYwGvwL5c2SGW7kHBUZXMxOcX11KQzXrf9XFLrGmkcIiLCdzrj+wjLIXh9kokZXHE1ElR2NSI6b+H4omufq7G0eFWRIC09J+CBQfcyOBTfizl5zStUUHelKO0uPTSQUPoRRT/SiLC/vFZ2V9i+by62Rl0BZ8r7E5oUrkuuittnTu3nPGO36GVT4qchYlwIA4yFYF+cnHbWt0hv1xcoY5kfubNTHAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKHZ7IkpHOBmvPBOHCNIA80aacn02iv898am7NgVnFM=;
 b=hggSwrO6GGp3ZegiFTUchtbMH9K/2FbeTXhvKtlEOlZC1mEooaPWCDCRe7ytLrgMRiJDHT6g1uWmr6VYv8k5o3K4YupDOrfFPBFduQ/3BQcXM7odAUmznCUD+M4UK7VKyGlMM1J3x9Sz5yuMCJegukgl4AKwfg62ZOn3eDObfSUMVbI+nYhZduAZdWW36v+Mkh840u82pmHBATEYEeBKotuCSqeUMBViu8Aag9nzj6SQzq9qYszICPCRSV1utQEwrx1hfT6tHXRa3B6boKbBlIlAvFAPDQz8vda3BXtjEnL8E0n5xYetdGEAACKI9MRSyQ56cfudpFVtotcYArd5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKHZ7IkpHOBmvPBOHCNIA80aacn02iv898am7NgVnFM=;
 b=Ujd42siZF8CTe8jIcHeDvc0pfLgW5+FfJI6EO9Qt9MqTok9/DLUpfwjRUfbYsaKwWEwtw+t8EMB7chlqSIBzPbNStkb9FwdPTo+xo7j3u6H27X40+1dwDeEnhuyB1Ja7eOlLtnQNZzBDmjRJdTjPCmn6eznpslD2Zjbl9r/xaSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA3PR01MB8016.prod.exchangelabs.com (2603:10b6:806:318::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Tue, 29 Apr 2025 22:28:09 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 22:28:09 +0000
From: admiyo@os.amperecomputing.com
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH net-next v21 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 29 Apr 2025 18:27:58 -0400
Message-ID: <20250429222759.138627-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429222759.138627-1-admiyo@os.amperecomputing.com>
References: <20250429222759.138627-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA3PR01MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afdfb81-b7f3-4c24-8a7e-08dd876d1ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFumm4a8FmtYS6JtLgqkmeZLIdkd8CpaacAiioGN8MHTDO8Vj+1p/oeJJReJ?=
 =?us-ascii?Q?1z8Cjn1HeXOEFNzbupj4gC5AY/cPyyXTdL+BNvOG9+7SsMubw6y9wRbI8wjC?=
 =?us-ascii?Q?xTnHWU5dqEJQv9fa7dVoKNIHx9MvSkoNjigx8OGjeVV6dxJg0eK6srzbieWs?=
 =?us-ascii?Q?p9QsA9vH6o3dnd465TAJAksCqM0B68rXlX1pcQ2m+iwfBv33KC3JEbOuWt6R?=
 =?us-ascii?Q?wbiDYTmmjCUv+p2GCaV3aJner/RxwdlwScH2JdWoElBnWNpswomeNdEFSsZM?=
 =?us-ascii?Q?sSf7YT+EBHyrZGFIWmQNZuiBwP5EXM7lZ/NTiKjD6Jxc2CcSf9GoDFwGrxRQ?=
 =?us-ascii?Q?Yusa0qZnXy4W7CmxsKTwNaJORGp9jUH0tceu5+KA6MYu2mG+6j4mgVUfoPf7?=
 =?us-ascii?Q?faqOc9jOtzxH6wWWT2hztOMQ1z/ftcsxZYw6RBJhe+j4IeOZhBUBuxxWpBlT?=
 =?us-ascii?Q?l979kIlFapUySNkM2XymoWXB7JMvpnzg2MfAcOYBomKEvCt3bn97hZyg4Xgg?=
 =?us-ascii?Q?9rhLvMEoHXHK+Y5nmMOToenQ8NFZGuj4GrehpFyQJHF59cNvFY+W1WRUip31?=
 =?us-ascii?Q?Wppy2uHzFdwx5t4ImNanVuIyFlIKLwSZUnVB1JS8B+/hvt9J15dsSLBsojV+?=
 =?us-ascii?Q?eennEmkmwD2nWymov5ML/x5FFrPl/J6CHyjROlDeODWEYgi1D5fT5UgOA6Ko?=
 =?us-ascii?Q?TMC1qSIzd4085plvWbZpdgrjLMx/J2rkDZLFrPB68Agn38ciHTzY60ADBJPB?=
 =?us-ascii?Q?EqaVqt/2NTVlHz0LUP5jOgEgaye0THyMU9krthg4PnTSluY/ad+0iW8/P/L1?=
 =?us-ascii?Q?JZt+Z+EWJr703dzSuMegytIsT3Wb49baXv1zcgSeuUat9/L8x3ZuSWeblm+2?=
 =?us-ascii?Q?HSafWT/1VEwAzwIj97uIA73IxNg4/8bZriEUdH0ArPSuFvts9Yt+BhWUMoZ0?=
 =?us-ascii?Q?fut1HG4w21wS3Zif4nbdXRrrX+YkloiwfbLPjUhbRrcJpdoJjH0iEQRZxX+y?=
 =?us-ascii?Q?Dh7PMl7tAQv0lnfMnRYlQbZMrtwWrFETRYXMov1QgYJkDYuEZqlzlAJUDig5?=
 =?us-ascii?Q?+dbnDVFpolNcf+9S4qS7+d6ckk05baKLp0OOHGh+KF6W+cfG45z3vtR9/ElU?=
 =?us-ascii?Q?9C94it/WH4tlGM8yc5km0YR1F2hhes/r8lfWw/jBdFZm0/nPkkZj2YsOYjbc?=
 =?us-ascii?Q?5O4ReLja5EkCqxDdq79OjG4AsOWEFz1VQx6N0GMwWmVug0YRcfKoEKBDiETB?=
 =?us-ascii?Q?JNVVvb8suwAlVVcf9vxdzx+WGoIggGiAgnvOxRM7AK+lfDODIpW4r6MrPLKh?=
 =?us-ascii?Q?qIhJEgJcp+kHiuEBmOaq+rdwiKGbLNDbJxxmdDT12Luh8kEnC9hVj5ICeuup?=
 =?us-ascii?Q?lM8fuhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YuyImXXS51fa9xD8jj1xsjFusy5M52Xcv5GsZZqFBUTOK4DOgyKv77BngLjK?=
 =?us-ascii?Q?1Xv7mlQ/KeP/F8z3MxDIa28eq+fz2p5v+HokvSDtWBUGY08zqDAKtrf2P7DJ?=
 =?us-ascii?Q?52EpVwrV3WlDo8jH0r4Q/Zxi6FeDQLzD8WAKV3cwJJ+x/+1BWibt0mmy/rl0?=
 =?us-ascii?Q?UUAh2r45BiuDOW3eKtKhQEzonAyHfckH5Ea28hZ5oOV/EcKvd1UwPbI7ILXj?=
 =?us-ascii?Q?KNQXaTfgcSu+xgHWwYQhf/q4PapRG2WzJMgBBMAO6WDvEvBHxZe69mMk76bv?=
 =?us-ascii?Q?xeXPiXDpRCAOtk8yPVA7xs0lnWnXi7+ayLD3VmXgzblghd1l+KQedV0HTqBD?=
 =?us-ascii?Q?CWEtFbiHAv+KGDZOoz7FDsQ6mEzYL7p7kwePBUXJEiw9YuIZvWbUI1gAWdnk?=
 =?us-ascii?Q?Sw8Ae8IzUvBNDXikDKByT3TnRec+2I8mC4JzsbrzOpTGtS5PhqWmQlT74aZj?=
 =?us-ascii?Q?RI5NcQVCnevbbiJ/fmMSTMJn/sA9JDAeLn4BPGO6HlMCkTZCxW58a34+jJbE?=
 =?us-ascii?Q?SCFFZXQa+VanYAkuLpqoewxHIS/xUB14g1/RtazuWQuKTnY3Iy11vvY8oSVw?=
 =?us-ascii?Q?cFVJ6cDVScQxNjd8Ryhm+2a31m9y2WVgjje5SCauHXcOlgJyELRjS+pKwC4V?=
 =?us-ascii?Q?y+krir5MyZHsHIYCOZWo0Qfsd73scQ0dd9FBp5RgJsIQcvWN8ORc3FLCbi6i?=
 =?us-ascii?Q?8o00/c8l6PcpqZ0oMoxMb6SzeZhByiX3oRIxisziR/R/Lp/ciFKhhY44NjuI?=
 =?us-ascii?Q?wQeVTHIkRHHhWjnDDb2X2XYoz7wV8BEx8SnMHUECIGBUH5CStfesq1biFpNY?=
 =?us-ascii?Q?7+C90gwNe8SttSy72MeCDDhp6dCZveO5VcqjC2JR1PslHWSZBd4qwlBiuf8x?=
 =?us-ascii?Q?3TXpaT5dMeKMFX+UbutzTy8zvhIRse+gV2lpWnavqQTwzEgNdDI6TOLWwswn?=
 =?us-ascii?Q?xDbpqoPpEbBIJ7BneOffF/E+6qxHN/BjcR57AtNvSt0ovB0vbRIIcewiVdZm?=
 =?us-ascii?Q?w6VGiC8jxPA/yFJrcQ5w0XGqmeW41uAkjOMm04oJWM/oij67uyH6qqth/tNt?=
 =?us-ascii?Q?7jmpgD7Oa7wA9ZdmAIaVWRmuTisZ9zXTTWB3tfqIgUhDy7tCj2hHtLXuVs4u?=
 =?us-ascii?Q?lXcAc1XTOLanibAszZwYUKxKItXjk0siru3Ao5JWAwFIku79ZOFEkBNKitWu?=
 =?us-ascii?Q?uzLg83kDxx8KaLhpsZLj+4FcosBenEdeRuwYAgpyv69Dfsbi+GpcAz8wJiZd?=
 =?us-ascii?Q?IW0ZkCVRtrAbJ1cjqEWLU6y6ioOBYa75FZUI9ygQ9AGmzo1kmlsXHNkdSOCD?=
 =?us-ascii?Q?/Xckjf/xI56dtcQga6urjFZRi/IIPm7bNysDZy/eIDYDUNx/kVh8kuQffD6i?=
 =?us-ascii?Q?tCi/bmkYSNoydSMfdc/7/CzxUHxMtPsBv3AngoT5uAAeW9G9aoqn0YKi9Fpc?=
 =?us-ascii?Q?1vVR31+kTAysRa/A0Jt8w6pp7sM9fLrxYbeRbBUcbVtyf3yHukWxJQt+oB8B?=
 =?us-ascii?Q?hj8sJ5CBCxD+5zMZNxs7BbR2O9df5mnXXSA913s/4rp276Tcne+TQnejKnCR?=
 =?us-ascii?Q?3387F7vWxlpYLSOKjekQWuYiER3VzvQ2q1AZ6yGPzU4p+93yEBF6TpePReqB?=
 =?us-ascii?Q?/StI4z/rd1EJfiNm+leMwnGUczKG4+gdNmaSN6fZzd4uISScXJ9/A6XOt7fm?=
 =?us-ascii?Q?vFt7cFLu7BoUviXddS04LpH7NEc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afdfb81-b7f3-4c24-8a7e-08dd876d1ee3
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 22:28:09.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sELIuLppklnqcpQR25EskYDb/cwudmjc/0IflRN0faiw1tg/KxBIH95MqPttIBoX5+ZmDMf7CthXpk5W2p4BYbYvTcuasW/HJy2RZ6LZdsJgMQ1d2gzK0LJeIgc+Pld0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8016

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.  Messages are sent on a type 3 and
received on a type 4 channel.  Communication with
other devices use the PCC based doorbell mechanism;
a shared memory segment with a corresponding
interrupt and a memory register used to trigger
remote interrupts.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 305 ++++++++++++++++++++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a7545b5abef9..7a3096a025ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14207,6 +14207,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..f69d0237f058 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
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
index c36006849a1e..2276f148df7c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..aa5c5701d581
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,305 @@
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
+#define MCTP_PCC_VERSION        0x1 /* DSP0292 a single version: 1 */
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_HEADER_LENGTH      12
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_hdr {
+	__le32 signature;
+	__le32 flags;
+	__le32 length;
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
+		      sizeof(mctp_pcc_hdr));
+	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
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
+	skb_pull(skb, sizeof(mctp_pcc_hdr));
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	struct mctp_pcc_hdr *mctp_pcc_header;
+	void __iomem *buffer;
+	unsigned long flags;
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*mctp_pcc_header));
+	if (rc)
+		goto err_drop;
+
+	mctp_pcc_header = skb_push(skb, sizeof(mctp_pcc_header));
+	mctp_pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	spin_lock_irqsave(&mpnd->lock, flags);
+	buffer = mpnd->outbox.chan->shmem;
+	memcpy_toio(buffer, skb->data, skb->len);
+	rc = mpnd->outbox.chan->mchan->mbox->ops->send_data
+		(mpnd->outbox.chan->mchan, NULL);
+	spin_unlock_irqrestore(&mpnd->lock, flags);
+	if ACPI_FAILURE(rc)
+		goto err_drop;
+	dev_dstats_tx_add(ndev, len);
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+err_drop:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
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
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
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
+	box->index = index;
+	box->chan = pcc_mbox_request_channel(&box->client, index);
+	box->client.dev = dev;
+	if (IS_ERR(box->chan))
+		return PTR_ERR(box->chan);
+	return devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
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
+	/* inbox initialization */
+	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	spin_lock_init(&mctp_pcc_ndev->lock);
+
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
+					 context.inbox_index);
+	if (rc)
+		goto free_netdev;
+	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
+
+	/* outbox initialization */
+	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
+					 context.outbox_index);
+	if (rc)
+		goto free_netdev;
+
+	mctp_pcc_ndev->acpi_device = acpi_dev;
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
+	if (rc)
+		goto free_netdev;
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
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


