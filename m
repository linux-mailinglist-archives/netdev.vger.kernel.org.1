Return-Path: <netdev+bounces-184249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E5A93FCC
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAAF3BFB0C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3575253351;
	Fri, 18 Apr 2025 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Uz2oFgIl"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41012505D6;
	Fri, 18 Apr 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014498; cv=fail; b=NLBLG3KRAemkCzwx3PUy1JNGgOJ24um1Gg9trMmOPsn4J+Q+EbZ3pORcrKJqxUg1jCtC2/2uCOEl276bG6OPVUUsXub6ffcuRoumnoj1zAl+FJxH4PSwRR8lPUS4Sm0U3dzJVKZUu/9Me7BXzGq/26yR60Cz8h8B+vkD5ulapBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014498; c=relaxed/simple;
	bh=8oshfYtksT1AeNbTC4nogjoVlkxSankhVp+SsAWh68w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNN1YtzKVDtYowoAno3VuK83wHWk0sHkZOC+hi0TICF8Gw3OL5JvAojTrCy7KmMVxSEr3iDq2jMlanluAw03hiPp8kdVN5l8sGcud3LFGlc/nuBgr0YJ5Rbw30ce3lRClUuj6WhjWrAqkxzgoXd6x5htWqe370SzshS3cbQQMrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Uz2oFgIl; arc=fail smtp.client-ip=40.93.199.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrPeSHY2Lsff2d8fIkC8AlKKIPy4kto8agGF1VzUgihjGq6dRZMRP5dRX7yV7jUAXpnpANvIzoWXYw5UGAGyGNey2bocTrMTP706fmrgMHrwhFiGQIQ0y9M8ZlZd+trJjrsri8ZJ0Z3WdyOjlSJwPmv5zAPyS0ZK+xkupCY/OgTadH0QblKDVSIim5XhmuDoh3U0TymCWbZOyoTd69OTYBQ2MeoZ7QpSWKK87UbP5A26Cu2z31ak/ARGRRCQgN2AvBFiywgycdB0o2e2nfRsQIHeQd/LhEjn+j9lAYtdBeXM11X32tDp6BmmidOJV1FA2JcRFS0/BprTxcShwSAG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk+C4S/ovCs8Hejv9N6+hZnbdpH0NKYDGSbCxeLHilE=;
 b=yA3VTuyvzyDJQvwOKVrugA8GkUeKRAJqGZfK/UdJNR3KsuH7nXHFoLtEm49ckgQLUyUq/tByTEyn3yerN6HJzIZb2r5Rfvv8RvTBvt+m0nbffG7VcU/9c/HbAJOTYsOY59FQpZA8etNIbtQnmqa9tu0m1CzYGqQtEUYH1XhEEshfDsd3zj0lXZAlg7cWPIdxyoRlIQCXJdqioQrpGGZ967ukjE39kT5W4VV6KClpyOquB274eXof+MfH0hky4XWGaB3BhJNBFsOXG+ZNJw1rufyJo5tW6e7KDgaH+jGgSw2pYKMJQtYKSdlIGGSYw4Ugvk/gP+RCG2jRzfcAe4Nw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk+C4S/ovCs8Hejv9N6+hZnbdpH0NKYDGSbCxeLHilE=;
 b=Uz2oFgIlmXJ0cphpB28JpvJydjqUb1zAm1/e4lZKzkBljKDDF0L+RwL1xNVlKl1CLrmEtig6Tma1LB6iud6nhEkoNeR3xAHoS29Mn8BI5OqXWT4ckNr/f0a6rW5QlnEWGvt843gHB6t8V13p3kZH8ivqV3B+Ljxel74BaCYhnl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9277.prod.exchangelabs.com (2603:10b6:8:27d::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 22:14:50 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 22:14:50 +0000
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
Subject: [PATCH net-next v18 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Fri, 18 Apr 2025 18:14:33 -0400
Message-ID: <20250418221438.368203-3-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:806:d2::29) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: ef320e01-684e-499d-3ef2-08dd7ec66fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d3CUMLa/z3tF2Hk7k9itT9SHmyWxZgyrHRhndEQ+MGnrSDU6g77X6VvX/723?=
 =?us-ascii?Q?TYQdkr7ld3Fl4Z9Orty0tqwKUwXd3D8cX15Vj2TGP6ZDb88WUEREeGuTknLa?=
 =?us-ascii?Q?n3uCY64cCIRxbk5r/8IVwj5whOtIeSMfq66bb7Hd1U7NLEVnChMT8nmUeg0o?=
 =?us-ascii?Q?Fz3YXWdkZzobkS/P9Su/j0jrt8cq9mPOLpEFvltsk7orv1ZDpxVCO3TaH80k?=
 =?us-ascii?Q?NFZXoZEBw/S+t742QtU1Zm3wZ7EV6HAONnm4NAUqSqQ0p0fyajASVMyr4Jbo?=
 =?us-ascii?Q?8xLNQKPvGq/ON7YqX3LzDGeek6+8ZgJpfbIKSNDpHE/mqAaKgJoJawPtTR4J?=
 =?us-ascii?Q?wVmbctdcFZoWqgsf10Fr1UWyDFCViwfrzMdWxx3HPR27oTsPfCrYjKjC0u1F?=
 =?us-ascii?Q?vUcMH4MFWFbdji4bYMFLmP7KTrVfV8RArcGtSo8xKUT+hvUBSRokM0wkO7cB?=
 =?us-ascii?Q?SipROuHvAU1c/9dd0lddHY/2m23ovXaRJFtTxMpqmEE85U6kMCS1qd31Jhnq?=
 =?us-ascii?Q?fdLlVgPDGHefVyI25vSKAq3Humbqc7qHYHCgaPfxXKPpsCntvnCn3rOqZBTR?=
 =?us-ascii?Q?X9pkp97Uihfs3PO3KmPtstpGxYNlQ9vmk5fdRXLEAYYf/1NZirMMkh05XXo7?=
 =?us-ascii?Q?He0T18Kk5QJ2msDcC4+F1gbucf5CJD5uxEYTwWwOyZgsT8spSKTK/fxaD3H4?=
 =?us-ascii?Q?RU8XM0COSvPzzbrbl0LQz44XtmN02eeB2G/yjqsfMVrR6Xt1xVf27q7K4JVY?=
 =?us-ascii?Q?pMHiY5R5FvylJTxbRzZFoWQe6Soh7TC/hnU2diuIZaxAx0ylRVLEbQURnVfR?=
 =?us-ascii?Q?qoNqvJT+DxOUGazq6BQPTrjwIv4na6CFtXdjKBLDljnyPc7USUjTeXJGG/YV?=
 =?us-ascii?Q?DYfMD4eQIsF6Gp6JhNAmLfaOCStdgVDFSLThqMrSJnylYTfOF0H7ZPaDTeOI?=
 =?us-ascii?Q?OPqfJAn3959YDg2ZyQIsyTZXtr9qQaOaZlC4GcqUeJ47A0ydhYD8nbybv18R?=
 =?us-ascii?Q?o96+qg1cxNefUebX00eZS5EnLJYSbA2+DObg2dlCubAUDGY+oYTr3jBNgA9z?=
 =?us-ascii?Q?SZRmVxrCc7DsOCDzc0Ao0sX7Xt96dkQVhSjvoFA0GpwdiCLaG1ndtZapYp98?=
 =?us-ascii?Q?CflMSLYnZt3EUKbsIhNG5r7yG7LKnSjG05B9MhMCSqv6Z+HqsDwSGO2aLtAW?=
 =?us-ascii?Q?nU1S/neGCGkolyB41ckorkdkpT4Rbcgka23PiJlzxLJe6T1Ho4M6mZHT61jE?=
 =?us-ascii?Q?w3f/W97b7QnuZ5Ie1xvn2fjJTehnVfPMiob36uyswgEQBtutViTeYJf9vkbA?=
 =?us-ascii?Q?LioORb+35CZEyLTKG8moHG1LuBTXxZ1jYql0YKK8O75iIBJ1/UuD/juGCpr9?=
 =?us-ascii?Q?iuNTiZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2PbbjPmTYakaqjmosFHsHqtI0R0d9vwnHoRheGZeDp6Q6aifXW/4T4Pt7lJ?=
 =?us-ascii?Q?SLaYpI94JXODRy8GYx7zfesjuRUXSitybMob9pseODk9hIxKYITM5GTaKkWF?=
 =?us-ascii?Q?jSgzwgfM1ihA8dieGNlTcj2GmraOS0LAYZhQQx8wjoP6D1XtbXJHyopWkjc9?=
 =?us-ascii?Q?9BmZvCbJVnIN5PSbF7JoThlSAQX2kINDYRNc7zBuwr71UmEPpN5eQ4n/4hJA?=
 =?us-ascii?Q?h0XGEWg5IZZt2Btn7HqmsbqE3TiJZ+XTH0DJ4qniYQjB6ZTltng0JBQcZrBS?=
 =?us-ascii?Q?7lpUNtQXaJLZch0QyCRB0fLci6IJkahQBEoL4hRq3T8BbPAf3Gn8QR2h7i7h?=
 =?us-ascii?Q?rJEWIs7D1y7RjxWESkNJxNX8D+7/muLust6EBR7WHyY/JGyggVcB/hsDkSoF?=
 =?us-ascii?Q?mY4lo7GxO6LodKCZpl4nVbiOEgZ+ma9G/FeL6/IfoekYob3weQWyoVE5Xa3o?=
 =?us-ascii?Q?bxaVg17Dcx0Muq6Fmnz88zo8uCVhqDsafhtM5hm3baEgvAvR7Wv1ztCuLLtR?=
 =?us-ascii?Q?ONl7wKEKYu2zXY0bHoe6JE+wYRBtrVGohdNGCfI+Q9sratMictIS2znUlLwn?=
 =?us-ascii?Q?tLS1aRfvtXv/vf4QgHkZCIG9ZYD+cjQ6yS4geq4018/yhIiPwWymMX7Qq895?=
 =?us-ascii?Q?MgWsOQ5CqUOqPGRg+yvh0vrrsyvIjpwkAE0el8m+rl8bGJI7m9fdcvusqxdB?=
 =?us-ascii?Q?6eRVqTnI4ov3SDs6Y9VXxbqSoPVeLQZVqdWY75ykGK5Zmy7IKeOmD5HaA13n?=
 =?us-ascii?Q?iHxe/emJ6v+jiX0BBCElgMWFRxx2tv14fxWM1iEPyJQHw06TAqy6g0jvhozl?=
 =?us-ascii?Q?SUqoHnlUcyhYrt5a8Pp6NxrdYR6ZkO1M7gVzz2R72eW/QBGNqjwk9j2rgnb9?=
 =?us-ascii?Q?Wkkf0IwZvmQ79gJT72kDhVZepTpHRJgVTj0JfR7XORqajchWKiSyfM3xzUZ9?=
 =?us-ascii?Q?xmw9mgQQC2+tazYSQ42a7MxXvA22VOI5X2o2ZXTQi+4jV20dA8D3S8J0a0pA?=
 =?us-ascii?Q?7elfw73BKaBIELeNgyAwm33eyDlZYAaaV21wcnFsQd+jEf3BqG8uCNYS60Tj?=
 =?us-ascii?Q?vpLwnBKWEPYrTl7zEBHyDfaFyS2axGUN669pT6LMm6LURP0/F2DZ15rGp+y0?=
 =?us-ascii?Q?w4Xhlc+5ydadU7Qjpj5+hHcUahbp8HQo0FRcYFo5wFR5e+xtYvRxo8nqPlRR?=
 =?us-ascii?Q?UBns/RNQ/sSQo/zmb8y7Ed5K9/J92QfHPJcS9Wwe+XidovX8TpvEj4tTeErx?=
 =?us-ascii?Q?5+Fq7aUonkMR0xRqV+KrIhhcFaFss2qW3YYxd6eV6tkx1X5alvgQ3i9WBwIu?=
 =?us-ascii?Q?xe4XioPY9oAfNj4JA3rESqaQ3eilcNFK/zZ4vlq8xM5sNPG0HCHJJe+5Hsn8?=
 =?us-ascii?Q?tOQGYUYAQBg+nljw/3NV6Sn4cE+ZZzx6pnrbQmaW8/i7WRbFFOg0bRq8KXPx?=
 =?us-ascii?Q?wNcfd7IMyXeCrBI1yv7E1xxe4e5jUduXu30HetqtNsTfsJKI1B5L9VcdA6PG?=
 =?us-ascii?Q?N98O/UK8erfsmrujWsvvuz59ByI8Ei0tuLEDT4hWQhpbVI/tTEsBYt0btY+9?=
 =?us-ascii?Q?JwQm7N5Ndg7kbRWELjstKE32+GSkYW97mOqjI2OEb4T3Oomjp7wCrGaaQdiY?=
 =?us-ascii?Q?GU1Rr6rhPksBTrZuvWPSfpMFnGs7/FHiSRqt2tdETtMC/gADaYr0vbQ7RiK/?=
 =?us-ascii?Q?4P+2Rlx9Kfhe3B10TKUtjayU7I0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef320e01-684e-499d-3ef2-08dd7ec66fa5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 22:14:50.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMoWT5cmOQ9ZiXAxYA/TxSOwHCWHTgPgxBwe92Be8rjQDMhbeXpzUy7W4cSCR9zwdbj5cQlQ0/pmzWDb7oMsYejLzT0bBP3FDZD27LvgM212RHfYHUk/77UIF0JV0IDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9277

From: Adam Young <admiyo@os.amperecomputing.com>

Implementation of network driver for
Management Control Transport Protocol(MCTP) over
Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP devices are specified via ACPI by entries
in DSDT/SDST and reference channels specified
in the PCCT.

Communication with other devices use the PCC based
doorbell mechanism.

Acked-by:  Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 312 ++++++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d1086e53a317..16858c43526f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13901,6 +13901,12 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 L:	maple-tree@lists.infradead.org
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
index 000000000000..c3b4d747ab70
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,312 @@
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
+		      sizeof(struct mctp_pcc_hdr));
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
+	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
+	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
+	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
+	       MCTP_SIGNATURE_LENGTH);
+	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
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
+	ret = devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
+	if (ret)
+		return -EINVAL;
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
+	if (rc)
+		goto cleanup_netdev;
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
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


