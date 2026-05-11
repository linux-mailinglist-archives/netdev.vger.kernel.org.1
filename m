Return-Path: <netdev+bounces-286525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCXAFaWWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:43:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C162F50A41D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B73307B076
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F186F3128A2;
	Mon, 11 May 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gqij/QNO"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8C3BA241;
	Mon, 11 May 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488541; cv=fail; b=VDwzOFYqF4PhWAaEZBU09PYQOOo0FDYylgJZ53g6OSgILQVD2a1z44uVGLRLl/mhi4GoHStOZ1LnDdVvRK2POe3wbaBIMjeYK+OqXogPnz3+mttB2qkwxsUUXsljFn3Zclkrcs6Hc+YBLnS7YKyRsPJyIpbxvRaHfkq1bAgLNHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488541; c=relaxed/simple;
	bh=4N2KyH7ul5KwOj9Zq1fVz6tOIyt511ThHsrBX3yqolg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPDWOB52BcxjzMVy1892aTUts4Vih6vmQsIqjFpVe8uOVa6hjJ9vTNkVtm+rapahXv6pWt/gbd/pTo5uKn6tJh8DFkrdaKAyZPyxtJIx/2bDjuXfnZHFrM25/cNIajbc3FBo5/ERsrzdoV0M7GtgstzsZ54bQTZGzt3jZMrKyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gqij/QNO; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfN5hMn3Y+Y+QsdvXLDwErpgUZJHx8RjFYpShw/Ufhu/bLe8FFUh+KaKVfFY5cjmXcnJD+JFnoxWozU+5/JiVOSSYiQR2Hsplosx+kAcLLgLdqoDHppnBhHxpK/3BbKMonHmUhaihd0H4CSlUt9QnKfpcAEYF7vzMJ7gBOziTQVKX23mOmWxAK7bW13PwzxfNATvzEVgGkw2ObKu3IU7RkyxmypcMCx9I6o/BBBlvC+pws1mxNHcct1F45scQ/D8M5tSAAczi/cOG00nVivxUNRbItz9uekCio/V5aFwrxlW1OrOtYWVb8d5uC8f6BO9Cu4T4i+WFuxKSKjfqguGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoLVECL3rwQPuzL+C+a4C8j7/pncOxOZT8bciDhgx3c=;
 b=UaSsGs9FqpwK9IArjnMiHcnuqjFvr6diwZKv/xqB4c2ijMuxp6gUlAZ7/Id52Xjf1p70uihfu4DuGhwNY3BYqM0Zp8KJEQWN71FGviVLwnHyEkWMZoaftjCNZh9XkM3r8Lsstc/F47dmi2ItMW6haVaHRMCOWxM/gZDFxwIKJ3c8qi9tM6FbKilikQRrsmzetzh83L/AsC9JchSU63fSDhWGQbGUS9XIEROYViK03oeOsS7Ceurjw2zJnbC21d9C9gsTEnIzctYAlrVIzbmFbTSLLgaiV62DLkgzBXNqivr2P0Re1pE5BD9FSLV8TSayut2JNAEIS/wVffKrn3Ikxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoLVECL3rwQPuzL+C+a4C8j7/pncOxOZT8bciDhgx3c=;
 b=gqij/QNOYtsqXKHlIimUG/yuoccR4kR8QqdNLNvdVeZr8ZKlTJR9MU/h6qgDTXPvYm1T2qRarKHv4I5ogWBcQOlfYTtL4mS9BnYFpfb2c/FM4I38o+JP5yrLhJEKekPX6NjKRWoOPdWY+AGlXfGmRhwGFvHgDIOAXuDnZ8vd9fgHmD+wsratR5AeWCKai89sZ84BWr8rA9IVqb011l6z8YYoAOn0G2Skkg5Q5+EBLWKo8XxKwMCBNiNMqrvt6mvnSe5yBXLY6k8vTmNiPXB+m3nTo1f5cvtbtifhpjMFtD4xmPvD4eqODeyzvO6AxVrtqQg2Yfwlm9foQLbh0z278g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:35:19 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:19 +0000
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
Subject: [PATCH net-next 12/15] net: enetc: use MADDR_TYPE for MAC filter array size
Date: Mon, 11 May 2026 16:08:02 +0800
Message-Id: <20260511080805.2052495-13-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|AM9PR04MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a5cefa-76b9-46a7-3f98-08deaf383c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Z9F/NP3Gvqj+nryKrQCsaiyckexIm/C2l8E2aGg7F/+gyQXLjLLt5z9J+0n8nCT3FWvCfTldhs4uf5HjAyjKEWORPFtp+kytK4U2gHyDarGY9yJtH5lngskoV8dqmLHVD28voyqgNSt4hIYs3AD8Qda0LsoGjus/WJHuUgOLcRBUWlMZ9J9x8EBqIrrBcfdc+DRuYW3dTahSpOCmwMzcPtSWnelqUarBOMt2dUQeTQy5+EaWqfZ6a0WzoZfZyXECl6h/kM26Eqx9TqNEWeqolrqxud87AcdsNBgMG9SWlFDKu7UT4PhLN2g7sHDyoeqOm8JhwSMG2325Jw99LGn1XTQUjL4pmoazxgLTy41Ej3oNbh6xRZxQwLajLivZZ4OxOx5JM8ZLZD6CfeqrRcp6COzC/VjRAoOZg9qgBXl0YlXZpAxkqZ7waLACPCCDmRCGTX3Bv/IGdNZ/5LAVYkqEL1o0SPxKZfd81v2YTORHvRtJmwlyPa59D1d+tU4hyNvskemhFfRvMNPqeY0c5vD3zm35rDgP8uElg7ASujAP0+Q9u7O/v8tTcx4tvhlw7xubsolmwIWv+n/QDmigFMWKxNwxW5a4bydne9K0B4UZFMXu9//yLC+keMrPHIVBdmEasO30JO/BGQr8J2E6geBpW03dz48tuzZLpITabeGOCOHGYq55XAcMHHT2bodcAh9dL+scXp5yM/T3Q/N5ozJNth6KqG99jgAxrcz3r3f9RCoxcqPTc8rnUl/qVmGF2CFE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SERXcC3Ixmh90n/QayjTWHrX+yZ6T45yFmThQYZNhdZXvesbmy/aggFzKDm?=
 =?us-ascii?Q?5eReNDMUdgogYzNMmwpUovCfZuFDbX901HGqwU17gsnfD7kRuY3qIWH9v/ZI?=
 =?us-ascii?Q?mdMgPyQYjmaikp8s58vFmtAPk98yirrfbIgz0TNkRvMrLTA/GjjJ+jmc+FU/?=
 =?us-ascii?Q?sj7/7HGWrsWppUGHjFZJSPtlnpen8xFmQM8+MnY0n1iL+y5Nygux6newQY+6?=
 =?us-ascii?Q?p9kqvNNCKGMN2ihAVfo+nHePsKrT+X1QZXxZjnrE5Teyq9wr80g7TVPBWmDe?=
 =?us-ascii?Q?0MIm3smV2boAOHdePg4KTpgtAbhm5l5pTUvwFrpbIuk75IZvZ1F2fRpjnfIG?=
 =?us-ascii?Q?lXflw64lcZxpERCNP8jAm4Y7ax+ch3YsoTOFYu2E6eZuqAewnvrVfwPcz8Tm?=
 =?us-ascii?Q?s6gFkbpTjtDPKPxNaSord3WSES+Jv0jFqskg4iMesA71V/i7Ta3c4PLyax65?=
 =?us-ascii?Q?nxD/d6wxha1KH6ZEZY63FhEFra5bgQio8ib2C7UfzvhNuZldFV1hnhsHxWeW?=
 =?us-ascii?Q?irAx5Cw+R6IHglNrvpKSVs6NlIpECNLfd9IkibusvMy4SZWQDrWw/9s7hKwa?=
 =?us-ascii?Q?rvDqeujG9NZWEQfvrRP/68KqZJUo2npXJJSL4JOl81AMAST8ax6F6uHn60GU?=
 =?us-ascii?Q?jPH5cU5JZ682bNrCH++ZNau2dXmHbSONeDcI9mngyoQQpR9KMFtRsEV7VWy9?=
 =?us-ascii?Q?gYIcXh1D8dJEDKZ9IbnonWyMK+cpaOq+kydeZuwLWapM2FaoOcs2jRsO7OhX?=
 =?us-ascii?Q?z4JpMcaZ1jTxWrOSZ44cpA2orNmBKfoi+4fF2gJ1Z7yxG20iND5KUzT5nRIG?=
 =?us-ascii?Q?uUVsHw4prr3l5BNs2CcRIXMY592Mra0Z/5iCb3pQBjqYXJNHwOYSW3s45Kev?=
 =?us-ascii?Q?sRRNiLPoTlOuSUHiTIq7O0OJG6BS5pCpHzOy+cR59wAqSTvVenJ1tE17N5EF?=
 =?us-ascii?Q?bFZNnU62lEXAsMk4nRCpOolEkO122amFT3k05nCGzK0EXoaUsP/myT9JJ66k?=
 =?us-ascii?Q?MKk1BuGmZffhYT/gQWSqG1zQQu7yrreHlm50FRnKH8UfnZ/l8MCRhcny9/cc?=
 =?us-ascii?Q?herEglibtUjytC3tLYbHg9wLRNWE/A1mVgOIgMfvcw6h0HLgy9Mkyk8C3o65?=
 =?us-ascii?Q?MtbBgXFHOwyjcWrqR9p8LaPyZtIzKw4m/SFRkI2lp0v0J3/SUHRcgZ2CVVL5?=
 =?us-ascii?Q?XFhJUvj8Pm70XavqJhQPw2f9+F6kjRW/2UnNies0I0tQZrdD4woY+NsiAw/D?=
 =?us-ascii?Q?vTdOn2peiwlswZmOJKgAwQIu0clIQ+YqPKqK0d5A5juYjZZxiPCjTiqY34N0?=
 =?us-ascii?Q?SQmsD49ip9NSP8FN68VQeP4D03G3F/pndnyecDvjDWox967c4VEx+1Y/4Lqw?=
 =?us-ascii?Q?9hM4qeGVaOwSaW0NED6SvQd9Kbjsl7J3F2e6qAo2Vp+mcWbRtvqw6OWEOQMq?=
 =?us-ascii?Q?L+JD4xyevQRMZCy91sapAX9/LCOELyIEGHeiHscLzbUu0Fa8V7s065CcsECC?=
 =?us-ascii?Q?E9/DiIolyHn8ItEATEhxyqpJgcNPTUyDuYlEmBEYJywff8R/PvMVJeAHdHdn?=
 =?us-ascii?Q?1ssamWKKMcGR4HwOnBuokZoOEarJ1YiORFIVw7F3KUWhgToWkyaRPgU9uk1M?=
 =?us-ascii?Q?/IWHsiGokBA8Amrexkavy8G0mEGdwuTF+mz2jRXRyn+kIb4y6yeB0WAWK+IG?=
 =?us-ascii?Q?Tqvi7TgbvKQ391ttlM4sku8DSFiCucEdrYETZAbvItOgZujm0mXyET62r/ux?=
 =?us-ascii?Q?iXl+TQTcRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a5cefa-76b9-46a7-3f98-08deaf383c14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:19.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC4zf2LpLhfyGNcqPkB9iiUPVuKniVqoZfGtEO5hrxPTfzP9gLDerUdiGbURlvgfGcIXxoh/YWEG2WNgkiMOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Rspamd-Queue-Id: C162F50A41D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286525-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The mac_filter array in struct enetc_pf is sized as
ENETC_MAX_NUM_MAC_FLT, defined as (ENETC_MAX_NUM_VFS + 1) * MADDR_TYPE.
This resulted in an array of 6 elements (for 2 VFs), but only the first
2 entries are actually used.

The PF driver maintains MAC filters for unicast (UC) and multicast (MC)
addresses, indexed by the enum enetc_mac_addr_type (UC=0, MC=1). The
code only iterates over MADDR_TYPE (2) entries and directly accesses
mac_filter[UC] and mac_filter[MC]. The extra space allocated for
(ENETC_MAX_NUM_VFS * MADDR_TYPE) entries is never used because VF MAC
filtering is not implemented yet.

Remove the ENETC_MAX_NUM_MAC_FLT macro and size the array as
MADDR_TYPE, reducing the allocation from 6 to 2 entries. This saves 48
bytes per PF and better reflects the actual usage.

This change has no functional impact. Future VF MAC filtering support
will move mac_filter into struct enetc_si, allowing each SI (PF or VF)
to maintain its own independent filter table.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 731d56bad5fc..9fcf1c58d59b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -5,8 +5,6 @@
 #include <linux/phylink.h>
 
 #define ENETC_PF_NUM_RINGS	8
-#define ENETC_MAX_NUM_MAC_FLT	((ENETC_MAX_NUM_VFS + 1) * MADDR_TYPE)
-
 #define ENETC_VLAN_HT_SIZE	64
 
 enum enetc_vf_flags {
@@ -42,7 +40,7 @@ struct enetc_pf {
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
 
-	struct enetc_mac_filter mac_filter[ENETC_MAX_NUM_MAC_FLT];
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 
 	struct enetc_msg_swbd rxmsg[ENETC_MAX_NUM_VFS];
 	struct work_struct msg_task;
-- 
2.34.1


