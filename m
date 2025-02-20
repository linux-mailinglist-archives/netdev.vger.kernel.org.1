Return-Path: <netdev+bounces-168249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EBFA3E407
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFAF189ABDD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8415215067;
	Thu, 20 Feb 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JmL/azu7"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023090.outbound.protection.outlook.com [40.107.201.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D929215053;
	Thu, 20 Feb 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076466; cv=fail; b=HZ6Vy7ob5eUoAwYHUE5DN5XzyXlfu1xD6ED0q7npBBDQkgCgsDrkSKOBVciI2I54ucNO86pGo93k4z1Ik5RHj2EREQ5AR0tQFScHE24Za+TZGVBbOCCQ3xIF50bYC2BfNOoiyugx/W+zGaR2UPSPS7SNl6+xW8jh3OmcCr77QR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076466; c=relaxed/simple;
	bh=8oshfYtksT1AeNbTC4nogjoVlkxSankhVp+SsAWh68w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TghEo6lacyOWpVOm5NbfbxW6DmhmkN4rKJcaD7JieieTGxPB3zCniXcPNmbiiT/2DRruRLiMmkWvDW99oR6GuotOmbS3flT56bgtC5OBbdFxGUsokqhJO0swX7EXsfChwVLjoFYb8czvI7PZQ2TovPqOkc58OqJkLF/UWrN+51Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JmL/azu7; arc=fail smtp.client-ip=40.107.201.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck64eqD28jDaOYkHUmzs2SY+ht20awgdsNDQbGtVmNNyJ+YTu6XrdQ/Sr+/2619OA+CLIhdxhBlDA/z91l5oqNjpmuHrkeEhineOv47wsBJUTFnWYuJQfjnJ5KyG7Lv9U+GFXsmDRS6hXXKJl1BESdlOapTNXo/USgB4OpmY++0JLAIKniDkyhNnquCJ5VhjaS4YQXM4QJfkl7WKI0VQfCEb4/DZ52E/SwfQmujQMp9l+VbAAuqa4sJv1Sp1OVHiwvClEYkLD4AelGoeb1nsDeYjxZaiUscnmblAHPDPzRhZqIZwgTqpTTNi+7sn4lK6LQTw7he8+WJ5lzwoC6V/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk+C4S/ovCs8Hejv9N6+hZnbdpH0NKYDGSbCxeLHilE=;
 b=i2iaL1RtGDSa2DQelyRe/Qxo20gCGT/AaH3jnjr/1OKZ7/zA/jfm88PIofF571tV8ob53W4TRj4n94cymd/HFCo1gzNfBIhKps2732IQNrzBjtU16rD2HfY9L4CNA7Ikb9QTfgOfOeQ3XmAGNdpv3Uc05RkJ6N8TJ3K8peBVEKzQH9LYdR7jauTPvL/YYDgNZPAHoTYsG5itooeN6rCWoEZT6uEwL9Rtr22QQyjxYZQpTHh3ioqCXvFLOeKI5vPurK/tFhIXwJHuYL9CjZt/53DZewYFjVbwF+YD4rWjDndMrNvyQ+pKRwXaILZeb0JqrzY8CJlYv/BBpdvA/TkppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk+C4S/ovCs8Hejv9N6+hZnbdpH0NKYDGSbCxeLHilE=;
 b=JmL/azu7tmgSZ6pCRVgJkIth/lbfpIphDj8xmpRyaEqKIXxHr8hCCL1Zld9d40vgEtXKf/zD0VWPP8C8Jn20VxvrV4w3z9MkFVtY1MdS3KUVQhDzwshx2DI5SU/8NgxcTM0E/VIqJ9joNwwmF33R6nXNuSwzOifbjMXty4+c+F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CYYPR01MB8385.prod.exchangelabs.com (2603:10b6:930:bc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Thu, 20 Feb 2025 18:34:19 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 18:34:18 +0000
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
Date: Thu, 20 Feb 2025 13:34:10 -0500
Message-ID: <20250220183411.269407-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220183411.269407-1-admiyo@os.amperecomputing.com>
References: <20250220183411.269407-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CYYPR01MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5860a7a5-29ad-46ee-2c77-08dd51dd2faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7416014|52116014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jMSn0a9OWWbnXEK6wzo4BE8BIKqDlCeJp6fiTEkpVQLaaax+VVYEsFT+2pY?=
 =?us-ascii?Q?/gor25Zz83EeffxcIiCUMZH3F63z91OTIwXFfag8kwCp+Zb8o/sCFXc2Ewtu?=
 =?us-ascii?Q?UYW1KKXoac/Rq4pBGTchw/yPOf7lDfZ9YAFj9wuJLgxbDSDqbqF31s7E9sex?=
 =?us-ascii?Q?cyIXxqWAJXWL79wWiOdDExV+7o19viEBLphZwf8mH2Cuh84AoJ4/bWyz6/LJ?=
 =?us-ascii?Q?SxUIbcZqfgli8/flmZuMvRTo8dsOqKVS1lUIKZ43QI9F3KKN31mHjRP15E2g?=
 =?us-ascii?Q?xxT4xsee1y8oK2PhyS0lZXpfjy8ctxuOOctjTzlVWa4TZIV4jputUive2rlE?=
 =?us-ascii?Q?zqDoJvuxPYpvAy0bcYlRlaNM4zYiAYbbGi6+k43aIDmICKdSw20SGMoQcKFo?=
 =?us-ascii?Q?gjUUPVD591sX66aH2FxPKzOSENhWoaFN8iWFNAMXH8GzB3Wv0CvOewk8Nhzi?=
 =?us-ascii?Q?+4RgVbycyoKvSomeKr2G4xDVgKvv/OSbdBOPT9ZB38Xkps6yrdpl83mtoyuf?=
 =?us-ascii?Q?VAvRHZXcIFzA7qvJyhdB7SvZ6porQd3jKUZ8GjJsHQhwwdLfGl0jIs6gfo4r?=
 =?us-ascii?Q?wp0RF82T8fD5Mnlt0ds4x6T3yv0IBhId/WBimL2cKuoNo4uyXUbs1rCWYI7E?=
 =?us-ascii?Q?2cSqL1udw/rRkRLsLPdUZrQG6qBHBadVfERo3101vkIUN0xfQ6ybnmtd+ZzM?=
 =?us-ascii?Q?IMY61M0do1yISQaDheHxUk85l4l5g9nmdg+IReSq9nsTKbzLfxm9r0NClmw7?=
 =?us-ascii?Q?d0C0+ffyqqc1/g8W4Yv5udlbrQNqhmpa+X94uNS5zpeQIflQvjzWXIBVgcBd?=
 =?us-ascii?Q?fkosGYYGWscKwLD2PHgnepYda2OiDt7jfm476VClu9aKuU+oiMO/t0T8pztE?=
 =?us-ascii?Q?tPW903glCCE6NAJYt2wmsiBvWZlHbNSPzbbhTo3lsZHUNFWGreWeTt0aOMM/?=
 =?us-ascii?Q?2STUv3CchMuQzp+oM9ScXDQXG9DSerILqHZ0CmDy8t0x48HJtHPNgRL1QQlr?=
 =?us-ascii?Q?b1zkD4QaGcGwPtbQYx695T1MjkEzF80zqd4vElfoXXvuJd4kcAroa35w90QA?=
 =?us-ascii?Q?7lDnZCL5/hFNUcbysjiGO2yOSjA0G2vEQM1hwMC5vWR9DVgY/lmm6BQ4QF+O?=
 =?us-ascii?Q?fmdwhd2dzx5gVJRXfJm80KBrPpIB6PAmWhkUf67KjovHLnPfRs2Po0e2zWD6?=
 =?us-ascii?Q?NBKL/jYRUQcIMIh36g9iUs3D7I75z3Mc2xz8Ieu9a+CPX9h7RIC7YJuMRJGr?=
 =?us-ascii?Q?L7YpHAXy/yapyM5e4+/6quQc4e84XZFL5PUwFDicnGMy4qCesPGdYJGLqzSd?=
 =?us-ascii?Q?Jk2s2pa27fF+Gb451DC0aEsYjvlZuEZ8BI3+1s5jFWMUhdv6+knc/RnZBSen?=
 =?us-ascii?Q?UJTXxRcu56D4LOdUft8cTq2IZ9NK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014)(52116014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vNB5Kjohk37p+yIqER483sPJay/vQvq9bydC9CISVQ6PWo+zWQtyOmwF9XVX?=
 =?us-ascii?Q?1F+r+nyeOuUHOGPi9WWqtsE/JkZVZd+OZkzsAcFDpTTYWBRH6VvkccJ+2Z6C?=
 =?us-ascii?Q?iD3n22kVEbU3IfJJcyEOEjBl6FM50PeLvk/9vPLX8lKLw/OXOfCMPcdZRtg1?=
 =?us-ascii?Q?3OYhPSZ455zzrP4k9LP6+4zqOVKIkPWTPpcHdIbrQpiWpfbWMr4OU35uccCk?=
 =?us-ascii?Q?acd3evYnlSRwxwLDk7xHPey7R2vjh7WCMjQTHuimAbz9dAoUVojBoY/bPEKi?=
 =?us-ascii?Q?dFTIp3VTk2CExTIusrxeDpW2bt9L8T6j41CF+XBzscyVPfM3cvh9pCSqC9t+?=
 =?us-ascii?Q?3oYPX/jrjNdHKZBq98tvODvkqdSUF33JwubS/+zu+OFs6TccPNRmBX5sk32U?=
 =?us-ascii?Q?0FGHLS31wD3gpm9GbdH9mPAw53fsaF4uFn57fUAiwBkWojpnPDNz1BvaseCC?=
 =?us-ascii?Q?h7WsKv2KKnngPdJ/z+WBDUnyWrF0aWlm8mPCVkUnpAyeOkS33AKBc9ZDphB5?=
 =?us-ascii?Q?F4rfM9gdLr/RpezA8BcM3OFVhlxurgi1MiffDCe2w2R/d3kbYDhSXIL76og+?=
 =?us-ascii?Q?eYjrnMSZnmFeDTsHGjjr+0xJv97Lm4SQHaTh7MOzPU90N3Usv52C2FycBYxP?=
 =?us-ascii?Q?335DXWI52p9pM+qkHjKcWCLeWCvQh/YGV5IXeQQI/YunXHebPjGim8inI6Mg?=
 =?us-ascii?Q?b6gZWEXGDiO/S9rGrY/zsdSoBykBfCeJHv8+6i9WnhGxYgdEfUWsvfGkzy0K?=
 =?us-ascii?Q?QXSCb+u4YgVwzc5TTjv4P/mVsk6TpnLL2mco0SWCU80e2G0rAN6REj4S5A/8?=
 =?us-ascii?Q?2HntFt3jHG2efw6JlBKMzZ0wtO1bNq1kQVpgOw12p2SEePSL9HkDkaVuzxBx?=
 =?us-ascii?Q?tJX18L6m9+8OYshBlbf6E27KM3vlchF6PE8gnS2kWlseiL3VjGdOmdAfB/8j?=
 =?us-ascii?Q?oiTBRuat2TTq9Zoq4fJ3JsoYN/6VkvpIouNuiYPOVEI8butYm5wjb4CQ5s/8?=
 =?us-ascii?Q?2Y0DDTxOqcmJW1V8OLPVmRP+8t022wmerY9eho56R6ggn6zsU11W3HIpH555?=
 =?us-ascii?Q?Vep6dXp8NQoAMJIuESawzeSzHzStS/KwPx0mF+H2QRwAaoeV5VupJv1+3nxc?=
 =?us-ascii?Q?qm/aMPUyj5O1niN5Ea4QHlJJ+KOJnZ6DS99jkHRvdnbSvV86fMCOEkiSfuwB?=
 =?us-ascii?Q?aC3GftKsXqA261zvLHe3FMPp3rWx39aCMXSwf9BWQn0idj4K2DkLJfmKmRGQ?=
 =?us-ascii?Q?VFcg6HqeYD3P3NfIgWGyGXZD25TZMMm6PuG1A5IBJItlXVBb1/gZSj3uLj3p?=
 =?us-ascii?Q?KDgWdYaFjHpsJ05VQZijm6DfG+0kmde5TDbM/YN1V00UDopC1kjokmyNadb+?=
 =?us-ascii?Q?GsZBAfXFA0vq25mf/HyXV/m+0q327sbTDPs77oQCrwwMRQUqZBxNjsJaYaEE?=
 =?us-ascii?Q?KpSjDT0j/TTyvRhUgK8YI0BA/JxRxZeYe4KK3nbejLf1EEWHrnkbCHvWuSB8?=
 =?us-ascii?Q?cYdiq0DVFVDLMJNmayS9diQzuSJ0uN7t5ho4uun7LQpMFtZ8tUz1/Cdodtot?=
 =?us-ascii?Q?HNRvKgS/qhGGOnNzjcJ244grxTxLcIgJwjGoT70QiiX34/XmZYWBPTaq0ZTq?=
 =?us-ascii?Q?H7agTHvX6j5SjFkS4+JLN3RR17OEikEAL4l1CXf7sz+e5ORaZSZ16qpffig4?=
 =?us-ascii?Q?Zp810AaGgbMcrfpH9iIcD6Zlyv0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5860a7a5-29ad-46ee-2c77-08dd51dd2faa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:34:18.6849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8a8GbBeRHJxK+Z90e2WNujAoOrUq1pzSxMEFI4kbx+HSlY/wSjn7WqPsTK2NOvUWikWl/vZkEGPipgZpdnX+3d0n8c3/6+/wOQoW1ON3R1vAOBNkiUXlGkx5pPOwp7W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8385

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


