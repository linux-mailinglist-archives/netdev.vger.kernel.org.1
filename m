Return-Path: <netdev+bounces-288834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI//NoiCCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE956551D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A0F3048173
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0D3822AF;
	Mon, 18 May 2026 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="crDhx0iN"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAC381AF0;
	Mon, 18 May 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073421; cv=fail; b=jKf9TgPn4Q7lC1ARR2HD0oB9iFrtTR//x4KOVJQ+ryBiezCJMCMR9zqxBlSUc2z4xpSy4xbQv1tjjRkoHvjvWtHzfgx2ziXhkHpLNVIA6fh75walJkJL35r6D1zd5EJHZca875fc8W0QF/ONHyKQZdDCVm+p3jwUD9MmYnCdC9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073421; c=relaxed/simple;
	bh=Prm3C5ULUW4aMn9gCjMf9I6O53o5jeqsvoiyyHeZOHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZ6+KB0aj0Vdg5pXQAH02mO36iCJDigbJTTtx9DPXoVsJNaG6cg5/G0mitQmvLRdbMq3WEn7tbKfNU+GE/OWth3/CW+DrqMYMzBu6pf+HovgjjXwJCMwoGPm+Itj+d1sGgPP9ockOf8yLOh01cwoZMLLYDFBNJWXzbHamDYx720=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=crDhx0iN; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLGI386HyixblaDD+1aU2MI+xfXma+eePD9nN5/GaSSKNoqaYEqI3ad256L+MBRU9yZ7wbwMd8vXgOjyq5MfD56jfaGyiM94TT2xBlTypRSPfPcp4OTmXz5gEpOOmnLRqD03c185uYVRUCIv42Kq/JMu5gCmVD9jHwo4LF1AHv83xb4PUduqgitm0BiFGgN2go4yfvwl+Kb4pIv0vnUlswObw4eD/hQ6JRbdD8y7GOosKr4yI4yKIXz6ImJ1sazETefxScPwFmPsnjyyg+okk/igC02sdBt0mMiOi8eR9yLul51cgDx85F0D1pz1YsIoUrMEBxHT1jD+YMR21SzkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUyb4lOS0JTC2Ax1ifaTxIfgVtO5tU/lGEcD+ACK4MI=;
 b=bfEH6a9zijD3vF1oZY2nMXc7lyB2xVqArYZJG8wYPQ6B55uro2GDE0aOUvH63huvTDs0FF0f1R0AKlbtsMU1PW5Lde7a4GYFbMzPYZDAp0D6/POdN2rsZQOFuazEzv2V9o3moRifuXPTsOJ7RGNT6PfRm1/dBCorpRqcytG1immIiiE64n+KNFLRXWBMazDvIEEr6bkthlb4BS0F95PdzWeEqC5FWR0Eqt/g6QE6cqsBilx8c6x9/gltEB3HIcRlnMPwJOfDpIayx27lTLzgSZoWA8IQMSqc7+L4RBERd7GZ3hafvC7OSRmjpa0453OFuERh/VUgzYM6mo/6TaQhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUyb4lOS0JTC2Ax1ifaTxIfgVtO5tU/lGEcD+ACK4MI=;
 b=crDhx0iNVlOFGk1jq5xDGsq8eQFrm7/cZMJE3JkxrlQTkhPZpc5JEwi6fFjNgnKx2XqrbuOnWT2GFRXphTgWu+iBCPkT1Or9T0m40c8yTqzXMJf4/2it/CSUU8OAab8mwDnbNB8rE6UayByjZJmMC03mxBY3V+2PQ7VAFFoy7gXGctJAmczr9A9eXT7rVDSQbaX3HHZDNMkGVn2dliwOhiXdIuLLneVuaCFMXlBeNYT0857fJr8+9pBrqD1/6chp6VgClaCrLRVnszHMSOlRb2+pmoRd7NukM8I5jHa7dTJD8wjjZ4MJILmaY7zksfXPkCdzoG9WtG6j4moHJczj+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:29 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:28 +0000
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
Subject: [PATCH v2 net 7/9] net: enetc: fix VF-to-PF message handler unbounded loop DoS
Date: Mon, 18 May 2026 11:05:33 +0800
Message-Id: <20260518030535.1057228-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: a1638024-7ce1-48da-005e-08deb48a090f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	6Kd3bCeHfIFg/Kycy7D3WvP49/llNgACt4SKSnqomjqHc9NfaMyFa91GUo81iWiBT8pSEM0zNV096Oqm4+ZcRF5Cb23gdz6Pr2aAaB1FubfvXeh6DtX59fXuvBHSXo3gytPidN+X8mwF0Dsgjfyt+GnJpPu+TkqHZg7B3T6dglLtjl1bZyofrcXutNQzWE52x6VLFskFVOcBdEMyzf1LIeD0a7kT8nRY2CyionQMtQfO+epoLD0SEt6zqVYZuzFFo5SxuGca2+ELmgqVw+U5q9ZUKM6gmILpWy89eRmHB7lXM7nUKvrEg0Owxb3iSQwV0RLr4MMwLM8YBpl1inbRRk37K8Ol5qd3703AnHG0lI5jb4xAT9r80aNMJtromtzRkRXWLX9cpQSJr593CJVou4lNjAQ//6zR5pXHRPcpiyMDKqPzdfdi85niFUg10oZq6OIBxk+0RceNZS2pUk8uT8Ph+/eem7PT2xVdpJo1TqPa8lTxd2AJhqlr2zSkGdUr90E8MAySdnGzUjizCxGUCOsHYF64bZP6QeR9wT+KPRc4w0ZfbNCmG7kXQlklAb+tKjrJ0yQhVPnC2Krg8SYql28PJ5RDpBD6e/AmNJGsEjWIx24lfa5eru+mRw0H70QqBUIaDFvxDm80jWPZvCCy7i+8TmQa6THs/iK9sgnPs6dNmdKTaKw1a12exK2mp0RbpwAMV0RK/ooeN1IiXipJH5UD/EB7IGCSrvdCL+Mp0LygjHmJzHmf5J/CYisbxCss
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rnguIhxTzziI/bX0FTO74TglHdGsb+Hep4McEHJZsgdAWmE5hlryst6eLtmI?=
 =?us-ascii?Q?iWNn8fpJ3lpeeLyuDuXmhtNrga8Y3QuHwFMn+3Z7nV9gNARXohAdqlJtHGeK?=
 =?us-ascii?Q?ZHTFmlptJ/AiNJ/bBBYh4gwTaA71js9wbkRu/NyYzWzxvVBD5pYx3ZlXB2Jl?=
 =?us-ascii?Q?pIeywtRRB9gkHak9uwhIFzS8pDXAINLX74h9VB6EYjzs9uRvkoTHNEeM/GYU?=
 =?us-ascii?Q?d3IZDfZXJt+CV3Io0aA+EHQg+Lwp6hMQYFZB8gR5Ma7v+0MtW3Jyyvxv6358?=
 =?us-ascii?Q?mlnKNat8/FM84tG3UlxGfGIj3Wd1XqSYXIWxWZtw9RKNpmAw+nr6fbGdCqcY?=
 =?us-ascii?Q?spTrnA8MpJ7PCYCGSx49m/qTtozNSoXrqrlu1POcg3IYyAaK2WLPHqYrS6qM?=
 =?us-ascii?Q?a3gGq283e5mXGNfukqW/WiaKqaqop6YbcqX5eDHZuPKdA4WVO3mzpU0VFpEL?=
 =?us-ascii?Q?A7plu/QhSG/oP7NdC4CAsVGRwdkq6JxJgNQ3+lbj+LPOj3Gm2f/2Wsnh6LaG?=
 =?us-ascii?Q?eWg8VjWG1fb7VxZ7fY5cTP3EfSeCyq+SG7uewVGyb8r8CXXbU92jOuS0SbUO?=
 =?us-ascii?Q?NJuM1zvOoIT+vF5CUfCMDZQK1AKPs2fmzRGruZvBsqRxnh+u66L9xvxwy9+l?=
 =?us-ascii?Q?LnlR0IQke+nAZiWIOgXYhFknJsKWr4W0vs+xflauI5hUdz6aIZgJzad56cPj?=
 =?us-ascii?Q?w5qDU176TAiILz/UVA/Xx3b4/hTebpMgKVZXMEw4GSaTCH/ktYU362uZXhb6?=
 =?us-ascii?Q?kX9skLVShviJecgBvAOfbEDSFMEJw6xL/sIx8gSyN/dy6VK0jfoKFmQMPH26?=
 =?us-ascii?Q?7F+D3ycf9Yi5k46+Qep85n1LxvOcw5he4JwfvjoOMZ2DkpIAKSUF19zaHbq/?=
 =?us-ascii?Q?G78KWchpEk2nGJJw1uLN1HJyMW7VgJHWIxZicL45AMLSSme5LgX7+j1eQQUS?=
 =?us-ascii?Q?Uyi3faJzlNV6ndju2+BvMTCyN9xzyAvnGDqk3QRQrbj1UYDbjzqySl4+JOzT?=
 =?us-ascii?Q?dZ1Fn6/bkfbaiyEQ6mYMCle/+lUnbKjz6TherbW+1+0pvft9W6WM4JM6vS4a?=
 =?us-ascii?Q?/80d7GN7lIVkWnTUc7BdeVutUcK9DyU2W2IWotQREgvqc/Y5oD4q8cbLgpqu?=
 =?us-ascii?Q?YzInzA4VxEA9WShPZQurY8YO8hwuuCQXcjCuMuJ0rTdAnVlhfJud0124PKh6?=
 =?us-ascii?Q?9465GrnO3NJJaAs7o7v23BPNsIl9F7O7qB/mjegTh6LR0UnDrm1mYBiKonML?=
 =?us-ascii?Q?Xgu4tx31OwaSvdSzFHCK4UUNxG3nmQNPyhfsH4i2M4fOt/yIE2vItohyeWCB?=
 =?us-ascii?Q?f3UplNZyEEKlVevtJ7M1uZYK7whM5WQT24SQEyDScyYK375QbpxfCrm7eK6r?=
 =?us-ascii?Q?P1OjIyzKk0Zit0vXP+ozcCo+I5/yhGtGn9HSc1avAZ4SvMS+Hesk8/pY22zm?=
 =?us-ascii?Q?GM4kUdIkoScrmY9/tqsNaic4uRzVGtS4+Qf14ILo870XCm8ydGABHhN+G7r6?=
 =?us-ascii?Q?fSybRRWWfpKMLGJwb5vgdDc0e7bfEwVhChIpY0dLnH+8XXxOCyY6vVzx9K5u?=
 =?us-ascii?Q?heEX+lIsmfz/av7eeJEzKPuQFREtSEEmeOhWxyPKOkrLv6B0sKYsJ77l1zl4?=
 =?us-ascii?Q?9XYkMZG3UnpixyAt2ikaYjdffgJ7bz9MZxFmYIx3j/9ugPKO9Jn5CD+/FshY?=
 =?us-ascii?Q?fzUgY+zSD8Q4taE6D8fGbX0ipmGPIRc5+k9lqBB1R4mCssAd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1638024-7ce1-48da-005e-08deb48a090f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:28.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NXqVEDjPcFXPTzRSdV3UDEPrDKoDBWIsLCj+MqEj9V1bLK4D8nTobTwzB3wCn91LOv0NRcQSxIzOXcMsD1Hdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: 4DAE956551D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288834-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

enetc_msg_task() processes VF-to-PF mailbox messages using an unbounded
for(;;) loop that repeatedly polls ENETC_PSIMSGRR until no MR bits set.

A malicious guest VM can exploit this by immediately sending a new
message as soon as the PF acknowledges the previous one via a w1c write
to ENETC_PSIMSGRR. Since there is no processing budget or yield point,
a VF can keep the MR bit continuously re-asserted, preventing the loop
from ever terminating and starving other tasks on the PF worker thread.

Fix this by replacing the unbounded loop with a single snapshot read of
ENETC_PSIMSGRR at task entry. The task processes only the VFs whose MR
bits were set at that point, clears the corresponding bits in
ENETC_PSIMSGRR and ENETC_PSIIDR, and re-enables the message interrupt
before returning.

No messages are lost: the message interrupt is disabled before
enetc_msg_task() is scheduled (in enetc_msg_psi_msix()), so new messages
arriving during processing do not generate additional CPU interrupts.
When enetc_msg_task() re-enables the interrupts at exit, the hardware
detects any MR bits that were set during execution and generates a new
interrupt, scheduling another task invocation.

This bounds the work per task invocation to at most num_vfs message
processing iterations, regardless of how aggressively VFs send messages.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 38 +++++++++----------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 662e4fbafb74..39b82faaf041 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -96,6 +96,7 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIER_MR_MASK	GENMASK(2, 1)
 #define ENETC_PSIIDR	0xa08
+#define ENETC_PSIIDR_MR(n)	BIT((n) + 1) /* n = VSI index */
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
 #define ENETC_SIMSIVR	0xa30
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index b4d7457097e6..39f057fe85c7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -32,32 +32,32 @@ static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
 	struct enetc_hw *hw = &pf->si->hw;
-	unsigned long mr_mask;
+	u32 mr_status;
 	int i;
 
-	for (;;) {
-		mr_mask = enetc_rd(hw, ENETC_PSIMSGRR) & ENETC_PSIMSGRR_MR_MASK;
-		if (!mr_mask) {
-			/* re-arm MR interrupts, w1c the IDR reg */
-			enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIIER_MR_MASK);
-			enetc_msg_enable_mr_int(hw);
-			return;
-		}
+	mr_status = enetc_rd(hw, ENETC_PSIMSGRR) & ENETC_PSIMSGRR_MR_MASK;
+	if (!mr_status)
+		goto out;
 
-		for (i = 0; i < pf->num_vfs; i++) {
-			u32 psimsgrr;
-			u16 msg_code;
+	for (i = 0; i < pf->num_vfs; i++) {
+		u32 psimsgrr;
+		u16 msg_code;
+
+		if (!(ENETC_PSIMSGRR_MR(i) & mr_status))
+			continue;
 
-			if (!(ENETC_PSIMSGRR_MR(i) & mr_mask))
-				continue;
+		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-			enetc_msg_handle_rxmsg(pf, i, &msg_code);
+		/* w1c to clear the corresponding VF MR bit */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIIDR_MR(i));
 
-			psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-			psimsgrr |= ENETC_PSIMSGRR_MR(i); /* w1c */
-			enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
-		}
+		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
+		psimsgrr |= ENETC_PSIMSGRR_MR(i); /* w1c */
+		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
 	}
+
+out:
+	enetc_msg_enable_mr_int(hw);
 }
 
 /* Init */
-- 
2.34.1


