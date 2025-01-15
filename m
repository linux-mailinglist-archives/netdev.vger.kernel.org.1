Return-Path: <netdev+bounces-158623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75103A12C07
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04350165466
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB81D8A12;
	Wed, 15 Jan 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MyURzcT0"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020074.outbound.protection.outlook.com [40.93.198.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D21D7994;
	Wed, 15 Jan 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970750; cv=fail; b=SpzN3b+1mfokNgrGj+gx2TMHi4wwSlFnEYN5dQRn5oktVJ4NM1pEH2VgQd8TemjXBivuqrMSpw1GxwFm7KcRJw6+oeqXD5ORalaZ9JHxnpKmNm03NlNzERqFd+1VM0oRqyfCWIpfkEwfsnaXn+sGdl5lW+tixnJIQx9dXXCmNX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970750; c=relaxed/simple;
	bh=batFl3JsfZFHQThQoWEV5t4MQvgUbP2Zd+wpTcWhPds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PpjYjVmbbed+wYmkT23db5AWTM95bcnZQzsxOc8VEP05CDSpWnESG0GRD+v6HXhhaa0o/cOS0yvV4x5oMHsVHSLMYKYwNjdcVRnUczcHu4pf9Oar5mdNtKj8lTr5RLzUzYiStUGpUfpIqtgUysJIWciYLA46GfoZnFzeLZC4k+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MyURzcT0; arc=fail smtp.client-ip=40.93.198.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmVdp/vxNzAUT120wdF+u3gGnMYlD/38qrWCRfoq6/H1ffSQQatjiYOq+GDEmywVLpAmHjRPWwgy7V/p+NW8a2iUkxHAasXtoiWuh8939YpLJtC5QowOoXCZK+M7fp7xN4rC7748JD0ffAAMFPiCQHbYcqv/NFQFTvnBv/PmtOc8ch+hiolD/y7jdwlyAs2a9TqvSntcMIuuDkLOdu69esKPylRZfpRS2Ny1oZ73QCCiA6oGCMLEFO6LhPjMLJJWQTmfkVOVsv55T7BLYw/wMj4EAAvu3Fg5baQNcEgTZeqxEROAfsAk0XGxlo3zqQJgG6LgkuQk0HprRMSqOH9Fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW+OE89QP8rxgVbSH7tHL4cntWo6qaVT9vDx6ji2TPU=;
 b=QMt0B1YLOApHl7ivNco3ywS2cRMTNBD2jMSOmOyGPOR3niCSZfst5VGT/3r4UlRe+ygFT0LekMPXY+okCaVubz5HOraY+ELarmnFSjDhy5fhXPvzOxf2e2sQRpeSXZ2AYmHLxDTCDz8IJrwU0w6gKCuGOKItlaSbd+hXBglv2mAo3wlmn31ubacU08xnwEAgtSmb/plqI8yKCOWHMcEz/M9ctNH/tXa14wdFvM6HfS5wQLEaTTVukLyE/rkYU/e8bEddCdvXxlK5awpu6y8eq+xSoTlCMr2E1NlUA4UhyNI7r2FSdxQ1k8wq4Ph2fTQSd+BlgA2rUl5VqhyvITmcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW+OE89QP8rxgVbSH7tHL4cntWo6qaVT9vDx6ji2TPU=;
 b=MyURzcT0OrzLc0hmq/+qdjEEkWbJdyHB4fBYjhorEpB79Qh4FO4CVJMq9YPGrrMGu7s5YVMsAsogpE1A89dHokdYnnis2uYBriEOexSvOhRFwCvH/Rv0BAFxlV/R4doDPK4kIhr1J1Mwb2XSV99tJcgkyDMYeFT9Q6/9maIqHAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SN4PR01MB7517.prod.exchangelabs.com (2603:10b6:806:204::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 19:52:24 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 19:52:24 +0000
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
Subject: [PATCH v15 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 15 Jan 2025 14:52:17 -0500
Message-ID: <20250115195217.729071-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115195217.729071-1-admiyo@os.amperecomputing.com>
References: <20250115195217.729071-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SN4PR01MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: d597a82b-2e5e-4ff0-9865-08dd359e2173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qGzahp8vrGJucPfjQxxGHx23ux9bdBAyT9USo9hVtZA8bBgMBMiL9oqYR7kv?=
 =?us-ascii?Q?xeADgLdoyFkIUCtjY06JGg2wuz8VCQ2T2rJnQ6+KQcHH0UKsBccWfe9hCoKU?=
 =?us-ascii?Q?MXJ6k9V89ikf2YN+PJLs+j+7OcBHNyqJ74UM9d4he9RGuZhoAH5gX0hxhvgY?=
 =?us-ascii?Q?ifGgqaJPAR6B9xEjDlCmqYcKvAD7v0+oi8lUmBXGxifZZDaODjeclYfkPgTl?=
 =?us-ascii?Q?8rG1gIcqGtSZjCGbZxw6/U5XqFlWHwIh3X9f5gpLvcid7rDSCQwqggKovCMK?=
 =?us-ascii?Q?+982hniQBFBxUFR6Gaw63W25S4YsbmyOjeISraLMpVgGN9OW1dHfyttBzdTG?=
 =?us-ascii?Q?TGRIFgrFo4xR7h3k+lpXgmtEL0ivAqG/PEOFxrESIyVCYnerN6V70WtMBQwQ?=
 =?us-ascii?Q?ajHgDcqPd2PTFRTVSWaQUVZrEjpw5QAqbddkOS89llsPpis9opkTUxiLyMbg?=
 =?us-ascii?Q?fQgHbKaAWipNx/b8HFOcz+/+U98p51I1gGJFXUtG9RS+GbHbwZXKifQAfRJk?=
 =?us-ascii?Q?yXZ782vBeabmT7D08eUvUpdlvYMopjS8zIyoI9bYwcDfngxFdcnGDKGL1Stn?=
 =?us-ascii?Q?NvB6VPNlMSmI9Qrb4fWrq+pRkHBrGwaPaYRoy3/SytHuYBfwxEWa3JmrlqR2?=
 =?us-ascii?Q?5n++EdfX/BhSQIf03+J7c1BJ9GXJHcPUPekZdYx7JFFZII2fUzJAUxsyZPzA?=
 =?us-ascii?Q?VQaYK9ZaJ1VxVSBmBr3KdNmPWufjgMCEaViD3JxIZ9WSdPKdDz7UwA69uJ4T?=
 =?us-ascii?Q?RVOJ+MiDEr8bphFCYC4dJfabJcor9JdAoPguyI4Ms6rJGq2SNBm1TTotvX21?=
 =?us-ascii?Q?Q4S9DhYyrkYcf7ClNJbeAfRfTfgSDwOb5obmLzyl1wW7nOVBVWdkVnsT22g8?=
 =?us-ascii?Q?yL0QQKNTmKcDB5f/Wxjj1jn9zINxlv5k55wtZ9J6KManixmuDiJZnKBqMmII?=
 =?us-ascii?Q?rhEdyGAvS0kev/vJCgAb3O97xaSn+xFzO2M6yivZZ1VysXPgm+NPfLd417zD?=
 =?us-ascii?Q?OD9tuz9UYnMHUdsNedBSjENL15JMZVimeTnx7qPcTr9VnzgdNslKkv8Bdo7w?=
 =?us-ascii?Q?2wZTDt8VJJMN3w1qWgnQQ4iIOCDDpYGNkEfk2ealE1aNlzd+xzooJH6pitQ4?=
 =?us-ascii?Q?yzlWZ6uWnvhgGcQs0kYcofP79aGPqugcxSHiuHIWFgYcosYyLs1Da9AasZ7T?=
 =?us-ascii?Q?bA0LlDwT8QC54WH6VLz0+1hOzSU/fn9qzYThPqyxImbUL1L8C4s/L3J/AxBk?=
 =?us-ascii?Q?2/UPk/z4xmhdm9pTJ6otM7+9C4u8100BUWsLxyi6z9UWJGFZahgZ2HYZKsKw?=
 =?us-ascii?Q?V1J0XOSTHaqEtPVtlcETuXhGudYYWp+w06kL1wboDCX2Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGrK/nV+akbUKwwRZkwF9Ays4vHwtXAmT6io5jPI1dPmILivOxoOc9aUu+Ky?=
 =?us-ascii?Q?NfqLY1vH3GxTUA3JB88LGaR2BQCqPFUIOBF+MvAZTTr67JgE5B2VImgmk0QH?=
 =?us-ascii?Q?yiFqNlotFAATEqbfjwAe8FcamTxMu1X0M1hBrcha2pnDPoV0O/UjbuhmVtJ3?=
 =?us-ascii?Q?YS9pNndywWGUFrB660ev9PHfOiHVGyzfv2WAVq9ld/xG5D3WWw6fCm7qELqP?=
 =?us-ascii?Q?aD/M/18ZmrO8zOWjof2W2V91t9SoIi2ur2ur7WkZjQDlWgvum3x9OmzDUiC0?=
 =?us-ascii?Q?6IofZfrOFlleIHqotDuVB0pADd9dujBpAnFeB/9501pY8GU5rYlX02tvArgD?=
 =?us-ascii?Q?1TfH79LpOHRvdSftNyydZE+Yy+MEMGFvnFztBL16KheMPNh9ECks55YUnhUK?=
 =?us-ascii?Q?HrBhOKqbBSBibtaCK/qlnDMJvgAqeOEygB4kXZRcbk6TZa1fm3pzfeLwquA2?=
 =?us-ascii?Q?GvHyX7ACFbR/hm7FX+EcPY1kIyhhwyGonhii7KMTh+t5C/2kSmT96E+0h17F?=
 =?us-ascii?Q?YHQI4zXUFMWjCuYQmMRRUQqTqxXYsb6y0gjyobqGDkOxOUcVP5KpTEZrcUmq?=
 =?us-ascii?Q?wzMqNE0Ow7zVwHqXGq6zErnT77I8acAnbRG/pgoeyixg4mPa9zithV1R7YET?=
 =?us-ascii?Q?gFsDCPHIb/dsJ1W9LlR6EZPenIt55pOiil2boYwiVGic5NNY6msaRA+5sD/d?=
 =?us-ascii?Q?RVBuh3+WGCAH1gg5IVoazW4AmkjGGjRqHsl9pStegCyXaj5gKHvof/y9E9G5?=
 =?us-ascii?Q?cZuaNWqc10y7gBgFpiqz95t9XpIHhiCFpbYfA9Ud95fk6ZIgHom6UuX1jGYG?=
 =?us-ascii?Q?G3UqkU/LmFvbNJYHaZZ73OX6PckZlL3tiPBY7vT8WzGkr3HYAaED2DweWWg+?=
 =?us-ascii?Q?1BB2v5YmeWMmtvuPAo7plEHPDxZeXycJX1w7npOxenTb+/iOIP5Ar1aoRzNh?=
 =?us-ascii?Q?PXaQfsG1KZjppaYFCrFCeMl1AlEU4QXS5ZEDbhlfTkBE6O/9EWY3yDnSUVI5?=
 =?us-ascii?Q?Z35AckkLv6zNs7ds5NWK7IogpC+2vPut20SaJJfFWfedVjzfIvVvZ7aG9A6C?=
 =?us-ascii?Q?GC6UXMykhO6wz4AgNjvuW6MJnkcZPyGJgGpPSxpX3ARCHhfbrIPEuBu5JCj+?=
 =?us-ascii?Q?PCxdjihcoA4WV77FODzbftJlDF1zMidrACNDFqCcP5ynBFJRDwScN15advIX?=
 =?us-ascii?Q?lzy//Hal0XNXYnRNafUARQtQxlENDfB+r4ySV7igkCJ5g+kedTRe7lAp/0hu?=
 =?us-ascii?Q?wAhsCpnst1dWBT8/NSphk+O3ieyyzsejxu9Sn7DqKYFGeHCBxSL0Q8m4JcI6?=
 =?us-ascii?Q?6Y1nEzNdX4h8ng62pk77bj6BR0gOxEVNeU3Wxzc6nL8k6bs/zobzDlg4Cd+b?=
 =?us-ascii?Q?Ee3VuC2488HI7WRkng31IvYsT25/VhVkaUvbOcxAcRfGhl2dyasGYzY5rgm+?=
 =?us-ascii?Q?cvQCd5Gw8903hdNmMSxUlXYpBFeaGD20YyvF1JeR+TLPHaNDcrpT20T3+kC6?=
 =?us-ascii?Q?s23GXWgKRJO59kJyVgH5GLPs7If4tVeNqEBQTrFmGGx55x+UtwBRxvfUbp/M?=
 =?us-ascii?Q?9YHHAxhzwpxDF7Eqqx+EYlNaXgNNGDiLZip/jbGPIQNqUI+zOrtQRFEys2jg?=
 =?us-ascii?Q?qBBMNtSGd3/+28snG+oTO0VD5Qi1vMH7JJLrXfQcvfxk2Jeh5XTR0QmvK0Wn?=
 =?us-ascii?Q?MKhE4SzxhuG+VGtTl4qyHuta5+8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d597a82b-2e5e-4ff0-9865-08dd359e2173
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:52:23.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbr5e6o1ChZI2uegwqCwUfQ+qzzew0vx9jPZ4Gj92miCjT98sGLBIspmE87LnUvgorLdmI0hsT7K/MM1oQ8zMGd8/WrZCmve+RvqgjD2nnVJeynMFe1pCIJh3eAhCYmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7517

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

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 313 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a05cdb41d70..61bbeadd51f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13787,6 +13787,12 @@ F:	include/net/mctpdevice.h
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
index 000000000000..9b8b1cac3db7
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,313 @@
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
+	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+	if (rc)
+		goto cleanup_netdev;
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


