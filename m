Return-Path: <netdev+bounces-287535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HqXMYlZBGozHQIAu9opvQ
	(envelope-from <netdev+bounces-287535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 732E5531C69
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FD7930AECD7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72FA3EFD0C;
	Wed, 13 May 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fi225jVL"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139013909B8;
	Wed, 13 May 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669833; cv=fail; b=ld6wKy7sOfL4Yt7nOu8Uz79Mx272gjXqsrqwef6P/P86lLS5J2VA90lEn0P5P+qZ5Ib6TTHBb8C0lntQLlJInib2zUJGIi0I3BEPDg1QZPyn6tAxqHejSvYacazcVMnKGDcpgaUlPtxknoNVEPCUl1v97gU4OB+e44/FIFJe2+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669833; c=relaxed/simple;
	bh=iuYNmPQJHoFbrYcWwTpkdxa24OGd9/mj/GLfEXZ9uG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRZSFbEhEICPqiZZw3thlZnVqJOvSNCDA5HLUGes+3N+VVHSaUNE+Ygbr6zqVQQrncNFkt1D0eXdPX/5u1Dd4OG45shsEENuRDfZCX6vXZz2N5I8oANuKMLOJv82gkxXRctxR4R/x0TJsQZ3mqomy1tI+dXvCuH04SLSotvuOrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fi225jVL; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L39lbeRwBNHzSnmclKO7ezPKk5BcT3V7STql02HoqcAhtc1Ekmw58Kyqng34Fk4/HUF7PiCgiZo96dHbQTmAwatW25jXdJvzOvZcCZ6d3pJaptrG7YsRWDLLnsHEiEC2CrUU1pSwlCK4NTDQDlKTsEXZQZzubwwyJUjHbZuoRcSEx9VsGUwcrfhLxuqEDLaoxHOGFx/U9yQy3AHykghZh7Kkeag8qw5XXJCpZdpW89SWyQx/J8AGx24jEOiGRIvatRh4QWVCWZDmpMAf1W5eFNqBYGXC8So0U7uYtkfY++NfQg7RrAMDxI72/dBTqKUUs1xhqLXrI+746oKTNeYl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0cEReYRNklW6WIRESfqdItST0kQQzop6MBBwiPE3U0=;
 b=JlFgrz+PLc+DjAIFcEdmhRfnORJU7ZIVDbQ1fYEGwxsPuFglXzXiGPa5UZuQNYbXzeEDaByRKwOopT4CwqQ4HaYlBtwZW1P5stMXe4wihUmg5MtUpjrtQNU2m1kiag1EgkqHNIZPs+oci3MnMbldYuHy+XHl90fnksbSEAtDWB1l4ZtvHuSpJr3mdf5X+CBGYiyDsWMvnsLxXPOca+MCM+nW+uWyG8z2Oz61YFlkOX0iH4gH7vZIBNAs/Nq60i7O0RF4UDIpef/NDcQFmaptAOPa39+YCQc1fQnjeJf3sZO0p6QBhTnqqMX4HIW0lMjBT3hMRClsUyrs6YscQnSe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0cEReYRNklW6WIRESfqdItST0kQQzop6MBBwiPE3U0=;
 b=Fi225jVLTmYGy+mWhP4AxUsSaWGj8zyaSGJ0KNYl0xxjmIyJqGkhh0ZyZkjQmRhaem5YqlJRL22SyTczOoCqfGp6fkOKVVgiro8Z8OEdCmhJtD6czD2ahFleGauPeQc1rcMtBdHR0rY/TUFrzT+H/yRJHtDT7xiVIkpuTlDKXNlsip3J0ensVRFRfJi1jz/YUWUo1UTA/yqgwcEK8gH9N4kENtbbmBeesy0tS2pqzcsqw6Prnzsxxw6HS5Oz14UZRlv6TFND3MPHTq2E8hCzRQTSuIhLDnc/zNFFNZTH4RvTtzVhOrBe0KiGpfr2kIFQJzdn4JXhxxXXijA1cLZt8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:57:07 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:57:07 +0000
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
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH net 4/6] net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
Date: Wed, 13 May 2026 18:30:19 +0800
Message-Id: <20260513103021.2190593-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad94eeb-6cf8-48dd-5e94-08deb0de5fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YOAPBiUZYi/UkTo5XyP+U52sWhtqxLZIjtYoprzD26ERoAR/8xchUvSvBSpkgJKQ4BuX50XejzqWYJxSf/sQnMie93jKnUTTvKrXVS5MQxSfSiEHVJaHNWXcVp1rFeSt08PsFbfBx7DheaYOrzL7QDUJq1itiCn4rWE5jtsV/axrieO7IgHTe7u3c/WUO2tCVeS/5BI50k4uwp0/kWqsIDODtGQkyb3kjTFPli6hYGee9O6tl8aJQyI5MPdNs1rZWcnIkFdc5R5eo5YXpXe54o33Q2N+ps6JmGVnIGPwbUdTjlEPzFzVqBkoG2udVK6/WTfVtealxRAc2IIagj1dkAcOI8PFg+c+BDCC7aq9EPezj6JmdJy1TAC79PJJ9FNX99Kkmmh4z3SYKJCllpnDwvfew39uR1v6QaDu8WXBLEsv+V0oA+rmickKjPahylgSTjSWiqpmkwyB6TbTLptDX0VASJbOG8S1RtyAZALb1On6mG7rM3/AsowoeWkpJo6+q3JjGjUX2F5XoM/bnJzLCtkIGTctUZmC4OhwtBMVEGsOdDwGMvYWGzIQhWYhnA2zK03V04cAgT1o4SUgNRyKQWhFsi6GzNcuPTmHbeKDtaKGZQOgQF7laJC6MIZLSp7uHikeA7B4xgdLF86gDueHJveF0sJsG9lwgLXdS48xLNHituKNuE8A3bkASg2MZUHoucwgSGWoaz8obZlMwJasSOcHgq8qhswdB/0hov4/00cqljsUo6ngXLs0BzBenbd3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rukMQLjC2B9N3JwKnQmV9ubMDrToL5NdkBi602LkKi4HmETtUb8StmlGcfvj?=
 =?us-ascii?Q?bvXGmo5ajtRB/Okm2oLxsnlWvXwkf0XLsz0/THQTrK11p3yGjpmHWKOe/Jec?=
 =?us-ascii?Q?Rlg2OvJueexpgMOO4CnOMcpmfq8PlRc7f+YOa7je8BtVg14j4qG+BHbngolX?=
 =?us-ascii?Q?Z1LIFpLWu4vnMpMnH4TDLWFkCAh+nwmTs5Rf6QP+PHS4OHJHGVBCr4vXHpmU?=
 =?us-ascii?Q?pwuntMtCJAFFcj7LM+EOAX/yvGEWHbA3oBJFY7+VrYzh/WZrKZpHMhAP/pAG?=
 =?us-ascii?Q?iNjGm3bfYVikucbdUx1KIvrsxMkAZT1iDJ++bBr6XRsn3OarSsTgv+5L2jb9?=
 =?us-ascii?Q?cYlefoM5z9cAclAAPNojpmd1Vgcqe2jC0/Cjf9PCO8l9fuOBIUmzq+ToXTUN?=
 =?us-ascii?Q?uUQM4b25FCqWaMM7ckZKsrEHX+O4VEsblApN9K+CSGRv7Uhd7G4f1fO2+wb2?=
 =?us-ascii?Q?EaD9PRXFVTKrtQsNILrOrCVjUIBr4FFc5KP8m1vYrwwbK1UDM3ikGS54b/R9?=
 =?us-ascii?Q?gXtMg0/vj+arCZZtrM9nVfb2EqjbKTWNIZeJmP/LDuC2Bfk/m7aJ5jzIVOky?=
 =?us-ascii?Q?mpYWljz/zRVG0GPU8KlqLhLg/MdvVmIcC29l3rghM8BPQBRD7E1MN+zSFNdQ?=
 =?us-ascii?Q?mVCvu7PzNh+/zEBQTNANnmt8kTeA7czQe9m7na1n346pSH/P56TDkF/dT5ZK?=
 =?us-ascii?Q?HonzMrAEAGtWurCWl9SUjDLe/Za1shz1uflS//EF4+Vd1Qj5cUhWMVOOcH+1?=
 =?us-ascii?Q?+Tq9RKqnjetjAfY4ldEm2hefo1ZkOMyqy43LFIpfymvZ0N4k2GcpkRjSdS1B?=
 =?us-ascii?Q?ygMb2AKMEsWxd55YZRbeEX9G1uwLhXCRTQFPQw7Rpnaqj2vvOw7hFFlo1/qG?=
 =?us-ascii?Q?GHDKBJ0ZvPLiOHj2+vsIT5vMzThZtU+ti8+cuTVCn2sLCiXQQmrJ4XjxfPoU?=
 =?us-ascii?Q?hCcCBXkMGGJS9+pWfrYyxcIqYge9L9kjQnsO0PAom7IF5tVaeDkIq459zqSI?=
 =?us-ascii?Q?ZNVkpQy9VveodwUfEGObnqAoNLZppaZzVIYrw3nQGnJ91Ld3vBe6XX8yUXGD?=
 =?us-ascii?Q?q2/lCr0qXSgZgkgOPMYUD5Njg2dF5p20RQnV11d7VH10XgArB1YI86XZktVW?=
 =?us-ascii?Q?OUCaqUR8v42Bl2F2au7eMgUcbBYnPynYjGEct2PRq841GsTqdP+Kk6DkmEWz?=
 =?us-ascii?Q?fNXfmQZW9d9MgIfqIeMFhxLqVS/iMpu56WVV7g4+v0izBnO5z87/Qq/S8oZN?=
 =?us-ascii?Q?s0KRN0JFYLdiF2XBbhuJdJVGIh5csHJU1TJKkynrX59MJZUzqd71/jqvx9pv?=
 =?us-ascii?Q?rkxpEe8YWaCZf6DriW7+rZLLqjGM3d6+I8XFVsM8XuiIwhYQo49eWrZvmdX8?=
 =?us-ascii?Q?ofurk4Q9dwV0bQ5RP2lTLIf3OjlmJb5E4oiR5K/lRnVBnjwksFL9lkFlrMFF?=
 =?us-ascii?Q?5iVNmXQ1gyVwnJEAvll+uSzyzXO+LoXlYzL31mr/ttEGLhyKFUD12CObkbrk?=
 =?us-ascii?Q?P2Q6kmDUAe6KKdmuX2kgqI2zhd0XdxuRalzR/FVKGrR3tAW3nQ8ZrDUMY784?=
 =?us-ascii?Q?SAPXC+WI05PwhD1og1Wa1/ZpZh3tNomyU8aa5EMbOzPxvKKsCem5iffw/r0E?=
 =?us-ascii?Q?nnyZ1xrHU8AAYjIMRR0N6hHFRiv/Kt9+G4nwrOnH3DBFr+F+9J67MDy7qnkW?=
 =?us-ascii?Q?jGHGmJhP7HVNKnaa+/cV0xSMlDtS/K94j/J9mBFIQxIe0506VQ260Y2inSJk?=
 =?us-ascii?Q?H25hGwddWg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad94eeb-6cf8-48dd-5e94-08deb0de5fc5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:57:07.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7ZWEsMv7iqBuAa3D+dpxq11U5Whtza9nybWkbY2K/QOxu1HUOZeKHPmcmq6+X0SvySba1tfVqjLl++e9jYGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788
X-Rspamd-Queue-Id: 732E5531C69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287535-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

During SR-IOV teardown, enetc_msg_psi_free() disables the MR interrupt
before pci_disable_sriov() removes the VFs. If a VF sends a mailbox
message during this window, the PF cannot receive it, causing the VF to
timeout waiting for a reply.

Since the timeout occurs during SR-IOV teardown when the VF is about to
be removed anyway, it has no functional impact on operation. However,
more messages will be added in the future, some visible error logs may
confuse users. So fix it by calling pci_disable_sriov() first to remove
all VFs, then safely clean up the mailbox resources. This eliminates the
race window where VFs could send messages to an unresponsive PF.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 6939ab04dcdc..052cab48df51 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -544,9 +544,9 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
-		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-- 
2.34.1


