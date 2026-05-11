Return-Path: <netdev+bounces-286522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ht4F3uWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7050A3ED
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F243306C474
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6583BED63;
	Mon, 11 May 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EWU+PWaG"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC3BAD82;
	Mon, 11 May 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488533; cv=fail; b=WyPrkHMIRdR3HHSzZ2dmgQLee88Gb/HWrp+LNnTeXY9CnACczrZUVrnKJUEMPBrfqvI4Owza4t9zyBER1zxOVDXhSmhKRFHq5fTRa3jw4+mgWeCldHQ3gGc4/g33amXbNTL2GoClPC9cBoHUu+fyRuVzs9tjmqb6DNmEL+4tONo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488533; c=relaxed/simple;
	bh=r2XCngxy/gskydovF1r5EnWnxtAEvW9FjdrRvih9pbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VHG9kGuXa/AwCeSp6jM+MU9s0pC4rQOewwdhlWcvVUk7BGZ7vlCL17sqYiSCCOxL5taufAzjlR1WBJdrOHvdjNKTmikcWWTTy3/Q55Xkqb9SQ9WwTXlMSiS7evvUXqoqrecgcYV7cNAU+graWeB4TVq3VbtkbD85z6bQMFb7VWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EWU+PWaG; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ6hVYaGjk9XIsNw/XzGl935hOut5ObQ2vhSQInalPFXWOQFsUmFu2BPftvimBZ+21+nqUvw+4hu7cmJu2zvgDUQpsD35k1hAXoLnExdYWvK/I/bQukn53ca+0NqEGIyAS5HnDG5PlDcWASo+bSYeLrFLi6quhWXDHWR8AXB4rK8raU6xHLYZ2o28i/T9cDLfs8AYQuPaZ6Lct1fdNi3O2Xw336rlIpKbACRc5GB2CPDvIh8LiIOrRSkpQ5BpcuOrONh05qfrKMY2rfhNaGNq3jXrWsA9fvDiB9dkygxVeolLzQrt9kLWYSMxCDVqJ0fb5WbYoMYHXyfgdUMPVmrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFW1eeLoahigi1Vav0HJx/Q1eOQ5YCecRl7367IMKRc=;
 b=gRscrHoOz7QyVmPCaNH2IfeUyCQwsn7JNQWgstzm8LQOjGCp9iYB74OkEsrH/+hJ8/fc5vEQlxXKc+2VTZQ5M+ofa6adQJsqkVvsEEs77tQ11ePZjqAWBDHxj0O/R28C+lYEXaFGD/mgXfgv7OGklZTKhLzZKailKli5O1IcQGK4YDo6KmcTR7fWRgsldGXw9P7Mb6dznYah6haPEZMBDJ/9gGum1x9PqidUHU4ILBLyPfwwkw8nUryhV//awBulVoN+NV+c3pJin/sKgcQHoLPh4bnK+VwcpO34A2qMN7MsyUvHmOm56EOG1htJuVTnA58eAZnnJdMg/6o5b9Ehsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFW1eeLoahigi1Vav0HJx/Q1eOQ5YCecRl7367IMKRc=;
 b=EWU+PWaGpaFcqDXwDCHl2gv4U5mcI5ak+7mR4RRvHOnyNT2gcJphAp9eq6KacIRa0++P8HiFaHyUqkJNhW6G7uz0kYsIJfC5CHgy9i67ElXTXB9T/buwECTrRy/H/5kl7nQs/W+2QEoyjwz8+wHE7XMX5AAzbVq2Z0mSE6C7KjtGVqB5BbVKboCI3SXrPQY6fakQdvO78F/rBJkicxy4VUnElV16UJYu21QtNT52755g6cGG4rrl8Jp/NuhcxORsTcVgrZ0MW54O+WemW/889c8+YnKmaftPXDhd+ENiUQ3+XOYsnc4ad2o8OMntCDjNDcjLh4rcMzadmC1fx0lZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:35:02 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/15] net: enetc: convert mailbox messages to new formats
Date: Mon, 11 May 2026 16:07:57 +0800
Message-Id: <20260511080805.2052495-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f2ff18-ba23-40bc-2e29-08deaf383204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|3023799003|56012099003|21046099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+QMTGhz6LXpNSF3rmn007YyQFy5iPRHmlmgQOifLbCElb3x7TRSVP3CRc4/ukBkFjpaTsWZv0FdRCaknkx1Eh+A2ufLl2fyPp0UIoXztMI/2reYhuufY9CqzH2b8AOWr6yPUqD78owRTFXBxodbZ9PooCZKURbrFCHH0vfmnMqwVyv3N5OURQ2okuoweyUnMgy13A6AxSTlwpU85ZVZN1ovbsoAmTPZqtTjq9THZYGqulKptc5Qz3Ou8dsvGK1PToCDikLmNcVUN05p6ITuHskXO2xduj31N5fEqRKL/ZznyftbkLne+aPzpF8YuqtluFarBtBXauJvAoLWMJu+Zulvueyj6M7n6LsZJtaPi8ZrMTX3lAWADthQlZUCEHs6nzocLL3braApo+SY4Ry9RTEDQ0R1zLPaKTTbqhYQP3tL9XFj84mBAkAkOQaJ05FNXM40Wl3wMwPxDt58+0qO1Tg8DPA1Yi3fwQiqT3ohCK8u4VXRMj/tP4J0GnO/OfH0oP7++a8RVSd7mtucow9PR+Z5RYjWzL5P4e5TZKCES82At1sZaO1mo/AxDeB4hvKIdTE1enIVoF6OvYVaOeoZGEj80l05jN79gfoB1VxiC1HSuf1OAfz8+vHfo16/KuhfUPZhiS+JR8yQfxg9bp2eU7ygxcrmToKddag9+vJKuTPGANzY1LPw4DAGcwtpr0KKfyE2RV5+hWwg3mO6f/hvgRmWdbxzVPtdJV1WwPHluTG7BhoAAs25YfsJ45puksrl2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799003)(56012099003)(21046099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9clMqp6YgAUKt7haXR7RoL20FCFQ6LvVrmgy+CpMI7oMC078QqqEJc2vTvt?=
 =?us-ascii?Q?t95BxBJgWGOeucRhjt4L4Qk2Vk+wAnGlK9GCNXMjNky1jHb8vnsIAmBZExUD?=
 =?us-ascii?Q?ug/BCSJz4+ByDDkgZ+yPpHZ6s+/PlRnz1YyU93CSKxXWca6/Tl++VPYHzAiP?=
 =?us-ascii?Q?DZiv4RXgzB5XYbPM6em9I8pUhAXlKrFuo3kKnu17oNkKViLPCcK7L0WkdYk9?=
 =?us-ascii?Q?1Yj2MZYc7n+KhKxyL/ACXAsyjIxGSFw6J2S+STwwpXuWg83893XAdl5yPkZe?=
 =?us-ascii?Q?Q4l9Sejkm+bD0HncNQtWRjUCzsFGc/C3BHQ0JCPTi/JadiFDHFkY94eZ4BaC?=
 =?us-ascii?Q?w/gU88yNJIvWQvYv/egocdfMV854gfWLlbeRXy6M2u9LcLYXaxsB4at/hOKh?=
 =?us-ascii?Q?JnIxF2Jk2Vr4K8Wh3QOaepRmt71uHhqHsu8//B0iGaEVM+wY7lIqxs7Ll8Vd?=
 =?us-ascii?Q?5gWPgN534+73k9AFo2ht6enFLxqcAF9sysn6WFINaswDqn13Mq4VYMUAfZLW?=
 =?us-ascii?Q?GxUe0zCR+pYMM5UgkYVh/Wy8NmXQes0tOa+HDZQ1drVjjBwapSCCQoQdud44?=
 =?us-ascii?Q?9D9ZOL0cFQr7JUM61PVyCgxZQ9ZgXtstckDUxThAEtlAhlMdc5reT95nhk4Y?=
 =?us-ascii?Q?11dK971U4Hk6tnTy13fN9V3inpZdi7ieUa0IOGEPZsasw3gUeH2dCB3BrPAk?=
 =?us-ascii?Q?V50QEt6rs8gg4+BoxY+Y4YeA18AllqZnIVFeeWKi8Jb9B/JQubl3TerA85Pg?=
 =?us-ascii?Q?UgIvMmNpccDH1X08uxyy7FdaiPMhAwjqUL0dgsaXPMp9lMeXDvKWDTo5wSeF?=
 =?us-ascii?Q?cXcGMnWBKYnQWblnF0a3f4hFCWBCM+6z87IprZ8adoVaGVzp8ITbbsSX+IDq?=
 =?us-ascii?Q?Y5n/udmUYYLNs20VWCzME4GMEgTaJcux8muQOIE2rYqdqUfV0MB03CUg7YBM?=
 =?us-ascii?Q?ly0BGho/kee4edEX6/SKLUGin+Q69NIPpVDhXC4z+6b8P4462H+er4p9E2yA?=
 =?us-ascii?Q?0P2Q8ZPIbpIMRKzLPhgX3rcm1vJRYtkAXfLmVGhccWPnZAEWAI6LCF7Rc2SC?=
 =?us-ascii?Q?s3twvVGjSH2xaik/c2TSUPLex7OS/k35HVOgMOOyp0kY/pNE4RnGsw4khbk2?=
 =?us-ascii?Q?2O/h7DR3bFz7Dl77TsiOsvdRC89ZAb+le6ZixGXMI6mHdswUshTON6HjA9/w?=
 =?us-ascii?Q?4ClzV7g8LjhMvxgsQML83x6s+3M3/rVk8Tndn68wRrKmYmaWjdA92tmTtOVP?=
 =?us-ascii?Q?pedKOZ0VY84bBj1JH/urjLM2AItKC6fqFOorbPQ3ArKK7weO4QlWb+i2b2q7?=
 =?us-ascii?Q?E4BSZTs/3luWyqYrwhh5i1VLfnb1Mit5GLaAlOolwkx8s4HC1zh1cl8kW6vZ?=
 =?us-ascii?Q?UresussUjr/n9rqx0c9JJlHwfLJbXBBwR//X+w5ntIpgvRI8aOAaqba0i7Dh?=
 =?us-ascii?Q?jGPYPOkiy7gZ8PuKElTtQKbf+4drvYxHXqpzygWuqBYLML+c7nGseAIaWuHZ?=
 =?us-ascii?Q?39dKBK3kp0gLRsdMlWDIgHNyBwEVJ6WYcAFXHzuts8cd1ehkXU57TvX3XKr4?=
 =?us-ascii?Q?zcuanlITr5MEFPXKoK47PhROZptm33fdb45BrV9zbJpGsyY8pb2H7KoKzX8N?=
 =?us-ascii?Q?0zhVndtAK8MJeUTxTa2yiXcvzJvC0YmPKJc0CYTQ4Snsq9Q8l7B+pNNHb2Dr?=
 =?us-ascii?Q?AVuPlHAg0ty4yml4tpOh/gUDYm0ASflLHgHxdFW0/74Od57iROlqs62GnE/5?=
 =?us-ascii?Q?TmADLjEgRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f2ff18-ba23-40bc-2e29-08deaf383204
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:02.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM8JQ4uGJxAfA8vOM2iHW8heMq2+Ku111OiUR8XExtwgESgX25YZGKpqnCx57bwPxbYAXr5Aimj8sU+6SLTM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: B4D7050A3ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286522-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim,i.mx:url]
X-Rspamd-Action: no action

On the LS1028A platform, the PF-VF mailbox was only used to update the
VF's MAC address. The original message format is minimal, lacks a clear
structure, and provides no means for the receiver to validate message
integrity, making it difficult to extend for new features.

With the introduction of i.MX ENETC v4, the interaction between PF and
VF has become significantly more complex. Typical deployments now include
scenarios where the PF is controlled by an M core while the VF is driven
by either the Linux kernel or DPDK, or where the PF is controlled by the
Linux kernel while the VF is controlled by DPDK. These heterogeneous
driver combinations require a unified and extensible message format to
ensure compatibility across different operating environments.

This patch introduces a newly defined PF-VF message structure and
converts the existing MAC-update mechanism to use the new format. The
redesigned message layout provides:

  - extensibility to support future PF-VF features on ENETC v4,
  - consistent framing for all message types,
  - improved data integrity checking,
  - a common protocol usable across Linux, M core firmware, and DPDK.

Additional PF-VF message types will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   4 -
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 153 ++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 107 +++++++++---
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  88 +++++++---
 6 files changed, 306 insertions(+), 63 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 117038104b69..0e338b33bc85 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -37,6 +37,7 @@ config FSL_ENETC
 	select PHYLINK
 	select PCS_LYNX
 	select DIMLIB
+	select CRC_ITU_T
 	help
 	  This driver supports NXP ENETC gigabit ethernet controller PCIe
 	  physical function (PF) devices, managing ENETC Ports at a privileged
@@ -70,6 +71,7 @@ config FSL_ENETC_VF
 	select FSL_ENETC_MDIO
 	select PHYLINK
 	select DIMLIB
+	select CRC_ITU_T
 	help
 	  This driver supports NXP ENETC gigabit ethernet controller PCIe
 	  virtual function (VF) devices enabled by the ENETC PF driver.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e691144e8756..b70b625328ea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -16,6 +16,7 @@
 
 #include "enetc_hw.h"
 #include "enetc4_hw.h"
+#include "enetc_mailbox.h"
 
 #define ENETC_MAC_MAXFRM_SIZE	9600
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
@@ -257,12 +258,6 @@ static inline union enetc_rx_bd *enetc_rxbd_ext(union enetc_rx_bd *rxbd)
 	return ++rxbd;
 }
 
-struct enetc_msg_swbd {
-	void *vaddr;
-	dma_addr_t dma;
-	int size;
-};
-
 #define ENETC_REV1	0x1
 #define ENETC_REV4	0x4
 
@@ -490,14 +485,6 @@ struct enetc_ndev_priv {
 	u64 sysclk_freq; /* NETC system clock frequency */
 };
 
-/* Messaging */
-
-/* VF-PF set primary MAC address message format */
-struct enetc_msg_cmd_set_primary_mac {
-	struct enetc_msg_cmd_header header;
-	struct sockaddr mac;
-};
-
 #define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
 
 #define ENETC_CBDR_TIMEOUT	1000 /* usecs */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 56899f2254aa..4e771f852358 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -17,10 +17,6 @@
 #define ENETC_MAC_FILTER_TYPE_ALL	(ENETC_MAC_FILTER_TYPE_UC | \
 					 ENETC_MAC_FILTER_TYPE_MC)
 
-struct enetc_mac_addr {
-	u8 addr[ETH_ALEN];
-};
-
 static void enetc4_get_port_caps(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
new file mode 100644
index 000000000000..260c7333d93a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ *
+ * The VSI-to-PSI message generic format:
+ *
+ * OFFSET  0                               16              24            31
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x0   |       CRC16 (big-endian)      |    CLASS ID   |     CMD ID    |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x4   |   PROTO VER   |      LEN      |    RESV       | COOKIE|  RESV |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x8   |                              RESV                             |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0xc   |                              RESV                             |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x10  |                                                               |
+ *  0x14  |                                                               |
+ *  0x18  |                          Message Body                         |
+ *  0x1c  |                                                               |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x20  |                                                               |
+ *    ~   |              Extended Message Body: LEN x 32B                 |
+ *  0x3e0 |                                                               |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Field Descriptions:
+ * CRC16 (16-bit): Big endian, CRC16 CCITT-FALSE algorithm, It provides the
+ * equivalent data integrity check functionality as the FCS for standard
+ * Ethernet frames.
+ *
+ * CLASS ID (8-bit) and CMD ID (8-bit): These are 8-bit fields identifying
+ * the command class and the class-specific operations supported. For more
+ * details, please refer to the definitions of the relevant class ID and
+ * cmd ID in this document.
+ *
+ * PROTO VER (8-bit): Supported VSI-PSI command protocol version. Currently
+ * only support version 0. To be incremented for future protocol extensions.
+ *
+ * LEN (8-bit): Extended message body length in increments of 32B. The upper
+ * limit is given by the physical implementation of the NETC VSI-PSI Messaging
+ * mechanism that supports message sizes of up to 1024B (including headers),
+ * that are multiple of 32B.
+ *
+ * COOKIE (4-bit): Optional parameter, which, if not 0, indicates that the
+ * command should be execute asynchronously on PSI side. If COOKIE is not 0
+ * and the command cannot be executed instantly on the PSI side (it would
+ * take longer time to complete), the PSI may enqueue the request in a command
+ * queue of up to 15 entries per VSI and, later after command execution, the
+ * PSI returns the COOKIE to VSI as part of an asynchronous notification
+ * message that indicates the command completion status. If COOKIE is 0 then
+ * the command is considered as blocking, the PSI will wait for the execution
+ * of the command to complete before updating the PSIMSGRR[MC] field with the
+ * corresponding return code.
+ *
+ * The PSI-to-VSI message generic format:
+ *   0               4               8               12          15
+ * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ * |       COOKIE      |   CLASS CODE  |          CLASS ID         |
+ * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ *
+ * The PSI to VSI message format is mapped to the following PSI message
+ * registers/fields, depending on use case:
+ * 1) PSI_RX_control: PSIMSGRR[MC] - for VSI command return code messages
+ * (blocking requests), and
+ * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
+ * (async mode)
+ */
+
+#ifndef __ENETC_MAILBOX_H
+#define __ENETC_MAILBOX_H
+
+#include <linux/crc-itu-t.h>
+
+#define ENETC_CRC_INIT				0xffff
+#define ENETC_MSG_ALIGN				32
+/* s indicates the size of the message */
+#define ENETC_MSG_EXT_BODY_LEN(s)		((s) / ENETC_MSG_ALIGN - 1)
+/* l indicates the extended body len (LEN field) of the message */
+#define ENETC_MSG_SIZE(l)			(((l) + 1) * ENETC_MSG_ALIGN)
+
+enum enetc_msg_class_id {
+	/* Class ID for PSI-to-VSI messages */
+	ENETC_MSG_CLASS_ID_CMD_SUCCESS		= 1,
+	ENETC_MSG_CLASS_ID_PERMISSION_DENY,
+	ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT,
+	ENETC_MSG_CLASS_ID_PSI_BUSY,
+	ENETC_MSG_CLASS_ID_CRC_ERROR,
+	ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT,
+	ENETC_MSG_CLASS_ID_INVALID_MSG_LEN,
+	ENETC_MSG_CLASS_ID_CMD_TIMEOUT,
+	ENETC_MSG_CLASS_ID_CMD_DEFERRED		= 0xf,
+
+	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
+	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+};
+
+enum enetc_msg_mac_filter_cmd_id {
+	ENETC_MSG_SET_PRIMARY_MAC,
+};
+
+/* Class-specific error return codes of MAC filter */
+enum enetc_mac_filter_class_code {
+	ENETC_MF_CLASS_CODE_INVALID_MAC,
+};
+
+struct enetc_msg_swbd {
+	void *vaddr;
+	dma_addr_t dma;
+	int size;
+};
+
+/* The PSI-tO-VSI message format, only a 16-bits code */
+union enetc_pf_msg {
+	struct {
+		u8 cookie:4;
+		u8 class_code:4;
+		u8 class_id;
+	};
+	u16 code;
+};
+
+/* The generic VSI-to-PSI message header */
+struct enetc_msg_header {
+	__be16 crc16;
+	u8 class_id;
+	u8 cmd_id;
+	u8 proto_ver;
+	u8 len;
+	u8 resv0;
+	u8 cookie:4;
+	u8 resv1:4;
+	u8 resv2[8];
+};
+
+struct enetc_mac_addr {
+	u8 addr[ETH_ALEN]; /* Network byte order */
+};
+
+/* Message format of class_id 0x20 for exact MAC filter.
+ * cmd_id 0x0: set primary MAC
+ * cmd_id 0x1: Add entries to MAC address filter table
+ * cmd_id 0x2: Delete entries from MAC address filter table
+ * Note that cmd_id 0x1 and 0x2 are not supported yet.
+ */
+struct enetc_msg_mac_exact_filter {
+	struct enetc_msg_header hdr;
+	u8 mac_cnt; /* No need to set for cmd_id 0 */
+	u8 resv[3];
+	struct enetc_mac_addr mac[];
+};
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index a137fa1e6f20..1384752efa7b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -29,49 +29,104 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 }
 
 /* Messaging */
-static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id)
+static void enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
+					      union enetc_pf_msg *pf_msg)
 {
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
 	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id;
+	struct enetc_msg_mac_exact_filter *msg;
 	char *addr;
 
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
-	cmd_id = cmd->header.id;
-	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
-		return ENETC_MSG_CMD_STATUS_FAIL;
+	msg = (struct enetc_msg_mac_exact_filter *)msg_swbd->vaddr;
+	addr = msg->mac[0].addr;
+	if (!is_valid_ether_addr(addr)) {
+		dev_err(dev, "Invalid MAC address from VSI message\n");
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_MAC_FILTER;
+		pf_msg->class_code = ENETC_MF_CLASS_CODE_INVALID_MAC;
+
+		return;
+	}
 
-	addr = cmd->mac.sa_data;
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
 	else
 		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);
 
-	return ENETC_MSG_CMD_STATUS_OK;
+	pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_SUCCESS;
+}
+
+static bool enetc_msg_check_crc16(void *msg_addr, u32 msg_size)
+{
+	u32 data_size = msg_size - 2;
+	u8 *data_buf = msg_addr + 2;
+	u16 verify_val;
+
+	if (msg_size > ENETC_DEFAULT_MSG_SIZE)
+		return false;
+
+	verify_val = crc_itu_t(ENETC_CRC_INIT, data_buf, data_size);
+	verify_val = crc_itu_t(verify_val, msg_addr, 2);
+	if (verify_val)
+		return false;
+
+	return true;
+}
+
+static void enetc_msg_handle_mac_filter(struct enetc_msg_header *msg_hdr,
+					struct enetc_pf *pf, int vf_id,
+					union enetc_pf_msg *pf_msg)
+{
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_SET_PRIMARY_MAC:
+		enetc_msg_set_vf_primary_mac_addr(pf, vf_id, pf_msg);
+		break;
+	default:
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
+	}
 }
 
-static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
+static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
+				   union enetc_pf_msg *pf_msg)
 {
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
+	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
 	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_msg_cmd_header *cmd_hdr;
-	u16 cmd_type;
+	struct enetc_msg_header *msg_hdr;
+	u32 msg_size;
+
+	msg_hdr = (struct enetc_msg_header *)msg_swbd->vaddr;
+	msg_size = ENETC_MSG_SIZE(msg_hdr->len);
+	if (!enetc_msg_check_crc16(msg_swbd->vaddr, msg_size)) {
+		dev_err(dev, "VSI to PSI Message CRC16 error\n");
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CRC_ERROR;
+
+		return;
+	}
 
-	*status = ENETC_MSG_CMD_STATUS_OK;
-	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
-	cmd_type = cmd_hdr->type;
+	/* Currently, asynchronous actions are not supported */
+	if (msg_hdr->cookie) {
+		dev_err(dev, "Cookie field is not supported yet\n");
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
+
+		return;
+	}
+
+	/* Currently only support protocol version 0 */
+	if (msg_hdr->proto_ver) {
+		dev_err(dev, "Protocol version %u is not supported yet\n",
+			msg_hdr->proto_ver);
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT;
+
+		return;
+	}
 
-	switch (cmd_type) {
-	case ENETC_MSG_CMD_MNG_MAC:
-		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
+	switch (msg_hdr->class_id) {
+	case ENETC_MSG_CLASS_ID_MAC_FILTER:
+		enetc_msg_handle_mac_filter(msg_hdr, pf, vf_id, pf_msg);
 		break;
 	default:
-		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
-			cmd_type);
+		pf_msg->class_id = ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT;
 	}
 }
 
@@ -92,15 +147,15 @@ static void enetc_msg_task(struct work_struct *work)
 		}
 
 		for (i = 0; i < pf->num_vfs; i++) {
+			union enetc_pf_msg pf_msg = {};
 			u32 psimsgrr;
-			u16 msg_code;
 
 			if (!(ENETC_PSIMSGRR_MR(i) & mr_mask))
 				continue;
 
-			enetc_msg_handle_rxmsg(pf, i, &msg_code);
+			enetc_msg_handle_rxmsg(pf, i, &pf_msg);
 
-			psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
+			psimsgrr = ENETC_SIMSGSR_SET_MC(pf_msg.code);
 			psimsgrr |= ENETC_PSIMSGRR_MR(i); /* w1c */
 			enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
 		}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 669eb939e33c..31ca08e679b8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -6,7 +6,29 @@
 
 #define ENETC_DRV_NAME_STR "ENETC VF driver"
 
-/* Messaging */
+/* Note: This function should be called after filling the message body,
+ * because the CRC16 needs to be calculated after all the data has been
+ * filled.
+ */
+static void enetc_msg_fill_common_hdr(struct enetc_msg_swbd *msg_swbd,
+				      u8 class_id, u8 cmd_id, u8 proto_ver,
+				      u8 cookie)
+{
+	struct enetc_msg_header *hdr = msg_swbd->vaddr;
+	u8 *data_buf = ((u8 *)msg_swbd->vaddr) + 2; /* skip crc16 field */
+	u32 data_size = msg_swbd->size - 2;
+	u16 crc16;
+
+	hdr->class_id = class_id;
+	hdr->cmd_id = cmd_id;
+	hdr->len = ENETC_MSG_EXT_BODY_LEN(msg_swbd->size);
+	hdr->proto_ver = proto_ver;
+	hdr->cookie = cookie;
+
+	crc16 = crc_itu_t(ENETC_CRC_INIT, data_buf, data_size);
+	hdr->crc16 = htons(crc16);
+}
+
 static void enetc_msg_vsi_write_msg(struct enetc_hw *hw,
 				    struct enetc_msg_swbd *msg)
 {
@@ -28,6 +50,7 @@ static void enetc_msg_dma_free(struct device *dev, struct enetc_msg_swbd *msg)
 static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
 	struct device *dev = &si->pdev->dev;
+	union enetc_pf_msg pf_msg;
 	u32 vsimsgsr;
 	int err;
 
@@ -59,36 +82,63 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 
 	/* check for message delivery error */
 	if (vsimsgsr & ENETC_VSIMSGSR_MS) {
-		dev_err(dev, "VSI command execute error: %d\n",
-			ENETC_SIMSGSR_GET_MC(vsimsgsr));
+		dev_err(dev, "Transfer error when copying the data\n");
 		return -EIO;
 	}
 
-	return 0;
+	pf_msg.code = ENETC_SIMSGSR_GET_MC(vsimsgsr);
+	/* Check the user-defined completion status. */
+	if (pf_msg.class_id != ENETC_MSG_CLASS_ID_CMD_SUCCESS) {
+		switch (pf_msg.class_id) {
+		case ENETC_MSG_CLASS_ID_PERMISSION_DENY:
+			return -EACCES;
+		case ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT:
+		case ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT:
+			err = -EOPNOTSUPP;
+			break;
+		case ENETC_MSG_CLASS_ID_PSI_BUSY:
+			err = -EBUSY;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
+			err = -ETIME;
+			break;
+		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
+		case ENETC_MSG_CLASS_ID_MAC_FILTER:
+			err = -EINVAL;
+			break;
+		default:
+			err = -EIO;
+		}
+	}
+
+	if (err)
+		dev_err(dev, "Return error code from PSI: 0x%04x\n",
+			pf_msg.code);
+
+	return err;
 }
 
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
-	struct enetc_msg_cmd_set_primary_mac *cmd;
-	struct enetc_msg_swbd msg;
-
-	msg.size = ALIGN(sizeof(struct enetc_msg_cmd_set_primary_mac), 64);
-	msg.vaddr = dma_alloc_coherent(priv->dev, msg.size, &msg.dma,
-				       GFP_KERNEL);
-	if (!msg.vaddr) {
-		dev_err(priv->dev, "Failed to alloc Tx msg (size: %d)\n",
-			msg.size);
+	struct enetc_msg_mac_exact_filter *msg;
+	struct enetc_msg_swbd msg_swbd;
+	u32 msg_size;
+
+	msg_size = struct_size(msg, mac, 1);
+	msg_swbd.size = ALIGN(msg_size, ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
 		return -ENOMEM;
-	}
 
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg.vaddr;
-	cmd->header.type = ENETC_MSG_CMD_MNG_MAC;
-	cmd->header.id = ENETC_MSG_CMD_MNG_ADD;
-	memcpy(&cmd->mac, saddr, sizeof(struct sockaddr));
+	msg = (struct enetc_msg_mac_exact_filter *)msg_swbd.vaddr;
+	memcpy(&msg->mac[0].addr, saddr->sa_data, ETH_ALEN);
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_PRIMARY_MAC, 0, 0);
 
 	/* send the command and wait */
-	return enetc_msg_vsi_send(priv->si, &msg);
+	return enetc_msg_vsi_send(priv->si, &msg_swbd);
 }
 
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
-- 
2.34.1


