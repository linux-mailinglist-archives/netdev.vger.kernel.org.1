Return-Path: <netdev+bounces-271419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG6hC4qHw2lRrQQAu9opvQ
	(envelope-from <netdev+bounces-271419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:58:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853FA3205C8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A60309D6B9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6535F170;
	Wed, 25 Mar 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YsYvaCi/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B136074A;
	Wed, 25 Mar 2026 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421716; cv=fail; b=iJhrHm9Q6l4miVf2ZJqI7+U7a4RrbT/E0m+2+xaBtndEuecRpmwd3yAmaduGNh+JhPRrZJGr+7dJ5Fpzplyi3biQZ8yD7+fHcpQwbM/IW63ls/dJd5Olsdrd/q/v0yKlK7LwIJmfm9ZOp9kdo+iTXmcEissmCzB2/suAMG7OmvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421716; c=relaxed/simple;
	bh=g04+NkbxivEf2q7e4aj3IGGeOAEky23lABB4J9JKczE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmicp52wIBN7Bd0JFiiMnQ2elJ5uPviTEuupyu++OgYmPKfCaesIiNXJBauXfrvob/sMbty0yajITWBfF/SlqEb6XAsThgf5VvZcqpf8i3pVGQ0WnT/4gZB8YDqq/o0dowUYmnQLSJNIK9uEJ2yvIxXNjw6lsysUf9ojJOQ9lZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YsYvaCi/; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm+UQG/saAIKP1RA5HTeTQPySTZvHmT9ckLytB14pNsL4WkyL7V/xM0UKteGIvAk9TM4MR1W0iWnuAeDA1GTkvwuYc1SWTYLyhW1H5sLjO3DCosZ+lT79hUTN2zZzljlitb0ObE50IJgZ4Kau9stYbnIsNfJotcHJi224b9JGaa93dD8TyQUsgVjqJFPaxcc8uWoW+FqrIGla/NlfrbGDgV3CHRE2a0ncGcPf+oeSaj/fUJWtbFDgWRYDehXNMvjawywEW8X2SnF8b099yBC3DzlpEmmrC7yprl3Bgdcr3Bu5lzzEuaf4OiqXxDOKfjg+6RzbEaN0kgUd84bZl5uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IZcXhJjmCO+Khiwh/XkWEWCu4sEJ+lb6/M6IZfW0cI=;
 b=YpFrF21yDS5FejphVZzjBcfBOvHO0LEz88oY72cmz1kNFaOKjE3eYvIJGWoH8YqGyaBTZSuzuaAFOwhVoruWX4p5iWgdwml3p98ql117iwiehzEz/nkCSBjVM2vQQlmSLQ9CmI8WMLiNglmTfOMjL7taWs6F9TT+TR3RupEMPxTvik0uB4yFwb+wUlk30rgzf3xvQY5nlCoEqdqLIwSjHne8jcyIdlejv9vqHcCu4qqkjkEBVDmlrMO+M3/reJG2lBx6yKkC33eW5DkDeOBbrzXKPLX/sEdtV2ci1VhVhm9PceGvHNgOOXa00ro7j4V/542mdYFq/RWWtFGth0vY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IZcXhJjmCO+Khiwh/XkWEWCu4sEJ+lb6/M6IZfW0cI=;
 b=YsYvaCi/9LwQZIhkUuRiUO7Kkgq8RqE1EVB0lwJiRwF+D7RqWiSF7NpsFS4Z/mkuTjZqgql/Ah2GA/EKE5VVyz8ZGiEdLn8CMwE4AMZEtcZ3ogulWDTv++tsWX4Zc0phKG/eA6yssIAELMn82YKfNuidYf1ezP43IEbhsCS4EQV++ZJpbkty4JhjT5kfEdsgK1dtM0KAGHR1y01Bal+tTprH1aePZ9R1WNLfVQRxnD+0InpVTQvXctrgPrcrHdd5vthk/6PvAt0DasbncMPyA2uOYf7fYTclxNGtR0ejNn79xyt0NIy1hK91v8OklKNHLg5hdOSXXwXEECGlUb6+kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:55:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:55:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandru.marginean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net 2/2] net: enetc: do not allow VF to configure the RSS key
Date: Wed, 25 Mar 2026 14:56:47 +0800
Message-Id: <20260325065647.2882997-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325065647.2882997-1-wei.fang@nxp.com>
References: <20260325065647.2882997-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d654346-196a-4ac9-87eb-08de8a3b720e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	YoKt6bEw4g7GHvQ8QBCEzfTuBVXrGpQVdHR/SgoF3P0Rt7pGmIjqs4wrtmlajwkrwTanCiz7WYccc7xaKTlfluGK/VW/Spfcl1ipQOrMl7bsFqplCvm5EVZOlZIWrTG0FIGUPAzb0zyzQLXUFIY9IDbyUL9ko06/pVOvHLJCl0OEsjh6SAq4pkp8shxzTrEyp80JWUm4us9/ixlmBlOn9W96n/GxA9CR6FO3YEByeFEcoEJN++Ye4jM8MHfirv6NYHBvKGRYzXPhiMr1QlF30f42XAdr/RLPSrt/SMq6iAokOkO9WG6dgnhH3KcP2bS8Xw+uOgBlfo17lPQouislkREqU4DrbmVGqJzHoCywjglajdJstlWJ+gPP/16IZOAUErBZFv4gNRwdpKH7SfRyzmOpX/t5m0kGVI/I8NZ0lSbSVWMkjeDM/Xv5W1km/bDWji/o/MYKUuW4shM2OMyHiKHLMMpUAT3XSbLXBAY2P6aN2u6JrNIIeLAZV1u61msug+ZJ3ViPgiUcQCtqbcqfTsVloanw8YRmAvL2DhtgZf8rYdYEAnOub1UWK5IwLzvaKWl+T3Apam/rPdmTaYds8ik0rRbaYN22/l5GqSCOYPT4BudE5vQdy2n7yxH1dMzh7Yq8nK8E0ZaEGHmJY6Tc9xuuLEYXA4AYOzjiWt62MMja+Ru2yseIgtZ9ZpP8PvikT5HaQ8kSqwIMaWL3Opn9XAvsYMPf2osc+FFcmRSvdBQNS6MclQrtCJ/oCysRoDn47K/4UdoIL0wxXwiRgiKnxhDe4c6MppeIqXD+MbKCCh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngahG63veiYpf0ALXwy6H2GkFDxX5rYluAzv7pvITeOoz3QZ2NHJ9BHgciRn?=
 =?us-ascii?Q?oX3H57WYoXWx7DTtPm+y5MOtHsUSPzbCBDWkFSVnAG31qzoS+3O1FRV4Qwf3?=
 =?us-ascii?Q?rYr+lSyvWDtLPmAYB1RTDGAe1/edOlm/Pbc0j+mnFB4dG8/AW1hZdyHBxdFY?=
 =?us-ascii?Q?q9PAh2PFzqPpWND1UAFKCeMetcpzIxfYulFAIuvJzm1hiHp8vw1WaWZ6iS7p?=
 =?us-ascii?Q?6K3bgzvBSAnaJUaVmEeLH3+dSHOSPTJIsgM7A0ep01Wgexk6rLSHD2hG17xG?=
 =?us-ascii?Q?XsPNigqXy8vaSZO1wxdxifa7nR2z7VipmNr2fUuE6oJAcGUaTIEu8/Xm7L9C?=
 =?us-ascii?Q?2ELTByrzHJEkbnUWJ4dkEApYmhZw1A2i+wByGMEka4dIkjj/YDslHIniT1VB?=
 =?us-ascii?Q?265yR0y/tbJBE3TIUv4fNjBpka6YFv06eXigf9dsXIFA5TUQyJ4LwOdeSJ2n?=
 =?us-ascii?Q?4pitHPjI24XItgJiXvqWZE0HQix3KdsGxmDfYz2Au71kHVhOpWjWHG2nQVZU?=
 =?us-ascii?Q?bXU4wLiwJuL9KCLBted0QdiKJrt3cpTMYoGeZrIwxuIXHKVSvT3DMZ9CkAKt?=
 =?us-ascii?Q?nY85xdPELPNX51rVa682TJuYxXzqRo4iy2qf+o0XlwoqDzClHH/rilwJ63As?=
 =?us-ascii?Q?jU8MAbnMKeYKLCJRz1WeAXXDDfr0eLRSbwPcJrzuzLrzoyhdecdCdZ/+6NS2?=
 =?us-ascii?Q?RAlLalV/y0n/0GAvA9PMv7eFMTb6WTG9oGKO7r3qg920HLWIOk7HOd8H15/l?=
 =?us-ascii?Q?8b7GTwmZ2/SUv8Qd47htqzL2CMkSmlCYTjk9ulfJ54DHIxJBOsHbVuNPcM3u?=
 =?us-ascii?Q?6zo/SBu3z31QZGca2zaQaTbB54gtvVfdt9RvNqXK6uYWA8CGO5E24rUOsXH4?=
 =?us-ascii?Q?fVbG9W4Z//YdTg6VM3iy+5QkzePFVPf50KqgNcHdz1r76t36mXI8XQMC2C8b?=
 =?us-ascii?Q?E3i6aotiAs0RIcNd2WkMdtwuwpH35bf77GbeSW7+xbW+QMej7F8wyxVeMS29?=
 =?us-ascii?Q?rC1Wmbk2bJRRBj9E6ADUoo/29E09u+hxHgtqwx0HKte606PlhpHIUUZr9E7N?=
 =?us-ascii?Q?+YDuFxgrysAcnffxeCSb+nT+23RaEP1wSocogm4fCud2EvgobNQG8ww1hgDU?=
 =?us-ascii?Q?tvYAASygl7xlMf+OdId4Ghf5rsSE9WhRPkKR9hY/kq+gvXiWZ9uOKQYzS3nN?=
 =?us-ascii?Q?Ng9/hBsMdBjcP2UXAVUB6ulv+euKhCmDrN2311+5D5vepfvY/E4AvjOT6mqH?=
 =?us-ascii?Q?we6djQiqSyNK00y/IMRsTJWJiecGYIaUOXoc6YlM8MHkfc19yj+wRo7++j7C?=
 =?us-ascii?Q?k34UShOIrRDh24u0pO+kxZdq4uFJukaBt3G6tmhUpFuRFCHBKRs1qUBqNinA?=
 =?us-ascii?Q?RAzBiQkqKUdJrxCt7yc3jxN6oiu0YbfY1HYuCfTqIubc0dZACrVK/lKRkaZE?=
 =?us-ascii?Q?szQpPGnfwFXCGQyX7fr+kraObwcXgzNXv7W6DGYG0AmPzY4aL+LKpes084NP?=
 =?us-ascii?Q?mhgO0xFbqAQqIwY/euSuNYr+ED82epuG5WSI4PotsqwiTH9GbAxqzE89AhEt?=
 =?us-ascii?Q?mb6YkE3ar1mdS5xOnhTSjxdVGvFT23gYUYCINHFZzJCFd6wB2Miqo4epFUvP?=
 =?us-ascii?Q?shG2J4SvMNHNlAdGvfeV/MiwQjw5Ew4/QggHWssEUokAlakrrqy0fyDVfegU?=
 =?us-ascii?Q?2l2NWhLcw2H2OYe9S7K8kzV1Niie0/9Mtja2Ug0kkAd4yRmuxkPfYjAAmOwk?=
 =?us-ascii?Q?fFVhRng0WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d654346-196a-4ac9-87eb-08de8a3b720e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:55:05.5432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfHbNIm4Zs9rSO+9uULngWyhQCdWvpKAqXMpWynaoRli0zdb3jcO2pRcyD0/BQg5Y+rDrUqdkYFrRN0StFAhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271419-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 853FA3205C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VFs do not have privilege to configure the RSS key because the registers
are owned by the PF. Currently, if a VF attempts to onfigure the RSS key,
enetc_set_rxfh() simply skips the configuration and does not generate a
warning, which may mislead users into thinking the feature is supported.
To improve this situation, add a check to reject RSS key configuration
on VFs.

Fixes: d382563f541b ("enetc: Add RFS and RSS support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index a393647e6062..7c17acaf7a38 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -800,8 +800,12 @@ static int enetc_set_rxfh(struct net_device *ndev,
 		return -EOPNOTSUPP;
 
 	/* set hash key, if PF */
-	if (rxfh->key && enetc_si_is_pf(si))
+	if (rxfh->key) {
+		if (!enetc_si_is_pf(si))
+			return -EOPNOTSUPP;
+
 		enetc_set_rss_key(si, rxfh->key);
+	}
 
 	/* set RSS table */
 	if (rxfh->indir)
-- 
2.34.1


