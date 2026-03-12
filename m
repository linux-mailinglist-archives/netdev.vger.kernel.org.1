Return-Path: <netdev+bounces-266973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGJNFZqNsmkQNgAAu9opvQ
	(envelope-from <netdev+bounces-266973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFE126FEB6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303D1308B424
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925B3BBA0F;
	Thu, 12 Mar 2026 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQ1mrKFL"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AD3B9DBD;
	Thu, 12 Mar 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309176; cv=fail; b=TKKvQcO/1vgfju1ZGNHkQv+vm8qHa80btbErNJE9/BG1cKVfd/5LNaTREh3MvQLIhJvQsMqUAsujgDnpegQ0HgkqkuubQC9JizYr/4/1H75nok7sfLO02MuHBhKwMT0pisfRYQuUSyrTNZgRHInJdUtM2BfNYfrQAqO5wP9UyAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309176; c=relaxed/simple;
	bh=0/ekdzRzk1T+/HnfbkxTCWRunLsCKyaKvGhCBlCnq1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JU5V0MLXloUqZkwhyCUXtvlsFWBamJvXrt38NDe4XV55GkcHfTD3909ePt0vGHwtwhfOuneHNU6ZSuLoqryfme1ss8gDwLFbdzG71mSpsEQd06S6pCaPdzKHQUH6+a8ZOjGzPdFrEcM6mSzoRaRrY3YyT2O4w+qZFkuYdw4B6S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQ1mrKFL; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/cFs9m5OBl3NsaesmgVqp3RfSpBQw4coQ582iLLWIT6QQgSAwLpiRSqzexI9oVN9y9XFqKVX8n77GcKgTKVnOEfysGu0Ihqku+BptV1Av4mWqnIKKXKgKc6GNmQ7Zfua2Ledf2jPbhFuuUvOIynaa9ZjcVFUIwc4INgafbziqocSn7VRHL4NYtmsMIVdGjqmRjkW8x+VazWkcnxeW/VBGLNZjXIA7g9Q80PquGI0hAnNGRlmdwmStj5PySxIeQhim3j5kMY84+9CYC4TZh+MYh1q3cSe/qNnix5ClRA5Uwu5ewR3YZ0Tl8o1JWwjxUEAexu/ojxSoDP+t06o+5IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhEuOM20/pR0ei9IIlTgglND7MbNzWFbTQu4N38DIgs=;
 b=uHRXMDeF7Gi6uA5EFbtlRL5smZD4JG6TJ2CiNZzUyG/x4z8kLE+MwqfJs+bZMzMyLOnyK4h9PDHdMloS1BVhbrXgCB1gvNn+GYFy+FGXcgYUYZFxoSFti2YyqcHmS/FehOcqcQ0CeOX/dzpw4mkm6zV3vosdGR406lPV+E+SENcEz5rNARC1Kw4EzpsOBvyPwC7zCmVzKixN9SamTGOl19UXj29nIXNfbwJSxjQTzGtihtuPeQRtPBdMZS1F5KonKDA1JLV2ijF9oLSt1ThvdmlhXh5Pc3W2L4NtKN6LwMb2iC/fPBApCu9LVNHifaV8XpZwUTDWfqZYAqarXvbBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhEuOM20/pR0ei9IIlTgglND7MbNzWFbTQu4N38DIgs=;
 b=fQ1mrKFLj1TyYYbm2p1/LHHq5MTVY4sfJYtU7jVIyHmg6VEwULLL9KB/c6MsPApB+zNL78gdmh4OYnCfsetzm8W+GDELWLt6/u52Mc0kE7o9eqZeESqTqShRVLv33Fe2ZVCJdN4bgdWQMMDbRycSGQEX3O1qhhi33K1a7+wmPyzdgQPbwtOXiA4mPgiHdZ9Ga0zDuRyDiGk3WwdrPgBQkAbOidvEYoGzlMqSNv0UoCsOGSJFkZQ4pJfWYQa5AfKMZ33+T6VuIHGbbh4lLT/S8P6iCjPKskeQvQ9dPWnUtoIe+LsFK95Xg0zh2ZBi28C7I/7Q7yEVhs/EK4ui2ZFE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:52:41 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 09:52:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net 2/2] net: enetc: add graceful stop to safely reinitialize the TX Ring
Date: Thu, 12 Mar 2026 17:54:15 +0800
Message-Id: <20260312095415.669128-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312095415.669128-1-wei.fang@nxp.com>
References: <20260312095415.669128-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4ecdb2-fbaa-4ad8-e754-08de801d1e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8+q+Qdx1VGydFiR2RQQXSB2k8q7iN4prg6KFzgEan6TdlcTsDAKSHS07lF6Xuwz64RwxSgE6Tpu0yrSX3lGadRQaVreUjHb8K+4vF4X93TX1zAlEOXAhk4wAviHfnZZS7KaJCbKVT1HNPcPuXXVwnalKou1sd8ZGQKsNNhAvPB82uZjuEGsb01Ke3evxvOt5meCbaYTPSGCU4VdYk5Pp60Ba/IyPvFVIOicPw8VDdvYNvPDRujiUsGpRnTOB1nUIIK4HM/OmQQahWDCqQMWi50nspejsX76sKvApQ0OWHzNdF6pWm0dRsD38uyv+7MK0jnJGIrl8gbFenk281p+x9vG7JvOGZZS1FxU5aVZpwQDtZ44tDZMSbEj4kNquURF031BjN8LhGcupbiUrvBqReID8rD5HCQqMISYESVYPcCJrym3+I3+Wv7x57a7teF77VAMzGEruZn4ErE1YhsS89zPz2OXVneYYm6iiG3Y0gERhRqCXcp/VS/TlKmaN3qFgOjJ5fUKXtoSAgeXEBtWwSAqIYSDHLQj2LIhDOK40nrtMaIqR8TKY+Hy9AbZ5YrEv5YrHih/eE3tpPgrj3QbYUK5nqOatEY8OgVNIjGAk2BxENDTv7Fh1NyE0GKcY8HvEh73qbWoBNfKspNg1coZKka1NwVeS7hRSq7Pn0cK0tWAznsNHEqqB0ZO2VW5c3aCX4fP/d+J6YlaZpKolU/irHL8nTO9M58CTethkAdXCjn7cgFyUBl8tu+fXUSc305avWLNqdTIMa6ZHN6m9+DYV5vjEZmc9U5f+efaZiYJV1N4a3UHZR/V7byYXpS2CgzRZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5U3eeXXyWkqOnzpq/8H2RLN++EspkJGqCePHDXOGoKt5LFqVkYTWNW6Eq9J?=
 =?us-ascii?Q?n4KBbxGeaxFv9ZFIct59P4be4Vd/2KAbReboSFHsXtzTjviYLlQou0gFSRHB?=
 =?us-ascii?Q?qwhFEoUk1tupKd3OO9JBV8jLo3AB+cQivYL97DUjvrjn7qLxka2disKunbmD?=
 =?us-ascii?Q?CZl6gWZH5iOewIaWjXWgW39t5nMZOLWtaWEMz+bmdQbrGG68VqK/sMRBIu7Z?=
 =?us-ascii?Q?Pl8IAcDi97w6WkwKIwsqDDHCXtbarziCitCCGGmBQZmdYtug8Do6ZD7cTAUi?=
 =?us-ascii?Q?F7aaaML6ulKq7UUDt0CJW1Go5Ii5KWAorKRPVNAsUNiebXG6KIRcrstmptPv?=
 =?us-ascii?Q?mk+jwdsNhBC1H8Nn1bJ6jaDT2Hwqm/O6ELzIgohS0sRGnNxSyqWu/Mfn4b1h?=
 =?us-ascii?Q?MjJT13UB/9AnMUAgIqBf83arkh/cr1qBKU/TGv4em9Pc1WrfkP1nD4FcdJBu?=
 =?us-ascii?Q?RvVE5o2bBa1x7onC1CdicRiDPkxjPKB2JYDrsuLZuo80Gktf9vkVYj9Bcrv4?=
 =?us-ascii?Q?o7TIKbKI4AYL9qnzxRstxmV5Lk7rnjSFXHVBUTBun07HXnpuEZ8tPj1aC3+L?=
 =?us-ascii?Q?NITQ2HP6U+dAGHEWt2w56JB27PyYZYC/xDQJV9uorcDLrh92rMql2DqupqEh?=
 =?us-ascii?Q?rFAjsuPa8jRO6efyWxvIlQM9iNyu4J7J/cWN7Mr3iQGzYKkf+U/F1vJefPmg?=
 =?us-ascii?Q?K5BvJ9EMUwfhON8XQ9zjwGYRAsWxdcLv+KzUEh/IDbQ+p9e4pt4e9g52asAm?=
 =?us-ascii?Q?pfNDa2tOgpTUSDb9AougS0Z1eojXio3qj1jg856bLPOMP/IjM/F2bQTbV0lc?=
 =?us-ascii?Q?ygt8qFtnvOUqQKmwAtrycwb1Zy/vWd5TT01R7glYyLpAEE3Z7z4/9cuMC8mF?=
 =?us-ascii?Q?WcCAS+XiI0v8xxjlgOu+Kl3T/kymL7U04RSUkZnjqtXWDx1MEneLK77Gk9Ok?=
 =?us-ascii?Q?OXCRniL04Ouy/XhluEPUxjtSaSIwikfUe41XExc0237meMwV6ZjBkwyrIhB6?=
 =?us-ascii?Q?gRM8Jg1/5cxpm2n67ZIbeJFE55bnCBmzSn28vgzlppjokbRvvkbYf6sui4Tu?=
 =?us-ascii?Q?xngyubc+Q7ZOZV8Rb10VLnaL/32rxdqKi5joCVipT5gHogFjCxF1y1S0Z5XI?=
 =?us-ascii?Q?tDPKC5U1avmjyfff8qjT6XE0NhEHS1fs8fSe5N3EbZ4dsccIqi8rW8MY2muV?=
 =?us-ascii?Q?g4MPw3VtxYoN6spVDw+XdYFS0Nxt/NulFzZlS61EprvHShTV18cYrDfbncNr?=
 =?us-ascii?Q?pKoQvWIKerxeMm4LwmD+a+I9WXcQZOVVEqA4pUTXr9L4Q/2hYq3SVuKj1mj9?=
 =?us-ascii?Q?vSBaR2IzPHkBeiFIz6eAtkhx2fBBqaZTWCOAnHgUKRI/ZrWw4UcWillk6nSD?=
 =?us-ascii?Q?FRORtAd1eghISsMRGOzbZbcuZ6TA11N66mt1H2w8fEX7BJVOG+PJ9jQrxA/X?=
 =?us-ascii?Q?0mvJlaUNoAeMy2M8JnANKOLtASM5JlK6+xAMldglbxnA0Rv4R8fPBYIHs54/?=
 =?us-ascii?Q?KFbiENiXZlKWs13zH1uCCx8w6ioQx8aKmBZG5lzACwXR2ubvwdWmIMCYeXO2?=
 =?us-ascii?Q?VF5P7x/uS+q8BN5T81Ay48QSRIfkp+NFU6asJRCYQolL4YvdaJ3oBamD3lca?=
 =?us-ascii?Q?UGmfXidQqnZFElHwnqHB/DBKeWNjbEZxz3Uq00pb2eS4asXY6fRQ0pDz/I+V?=
 =?us-ascii?Q?YWnEfTWW6Yhkdfu79FeqB19LMQU/4UD+DsTyrUVya6kBlcRlvyw/tMVz0c7o?=
 =?us-ascii?Q?w6Quudtkow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ecdb2-fbaa-4ad8-e754-08de801d1e06
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:52:49.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ6an/w87nhKoqhMLexWjZ9Ns8+fL0TRaZN1aXtXRrvxQsHm/Ie+BGT0RYue0nFZ/AWhyE8NkoxfijXNWOrfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014
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
	TAGGED_FROM(0.00)[bounces-266973-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: ABFE126FEB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For ENETC v4, the PIR and CIR will be reset if they are not equal when
reinitializing the TX BD ring. However, resetting the PIR and CIR alone
is insufficient. When a link-down event occurs while the TX BD ring is
transmitting frames, subsequent reinitialization of the TX BD ring may
cause it to malfunction. For example, the below steps can reproduce the
problem.

1. Unplug the cable when the TX BD ring is busy transmitting frames.
2. Disable the network interface (ifconfig eth0 down).
3. Re-enable the network interface (ifconfig eth0 up).
4. Plug in the cable, the TX BD ring may fail to transmit packets.

When the link-down event occurs, enetc4_pl_mac_link_down() only clears
PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It doesn't
set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, reinitializing
the TX BD ring at this point is unsafe. To safely reinitialize the TX BD
ring after a link-down event, we checked with the NETC IP team, a proper
Ethernet MAC graceful stop is necessary. Therefore, add the Ethernet MAC
graceful stop to the link-down event handler enetc4_pl_mac_link_down().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
 2 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 3ed0f7a02767..719c88ceb801 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -134,6 +134,12 @@
 
 /* Port operational register */
 #define ENETC4_POR			0x4100
+#define  POR_TXDIS			BIT(0)
+#define  POR_RXDIS			BIT(1)
+
+/* Port status register */
+#define ENETC4_PSR			0x4104
+#define  PSR_RX_BUSY			BIT(1)
 
 /* Port traffic class a transmit maximum SDU register */
 #define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
@@ -173,6 +179,11 @@
 /* Port internal MDIO base address, use to access PCS */
 #define ENETC4_PM_IMDIO_BASE		0x5030
 
+/* Port MAC 0/1 Interrupt Event Register */
+#define ENETC4_PM_IEVENT(mac)		(0x5040 + (mac) * 0x400)
+#define  PM_IEVENT_TX_EMPTY		BIT(5)
+#define  PM_IEVENT_RX_EMPTY		BIT(6)
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 689b9f13c5eb..53cecbb23a97 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -444,20 +444,11 @@ static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
 	enetc4_pf_reset_tc_msdu(&si->hw);
 }
 
-static void enetc4_enable_trx(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-
-	/* Enable port transmit/receive */
-	enetc_port_wr(hw, ENETC4_POR, 0);
-}
-
 static void enetc4_configure_port(struct enetc_pf *pf)
 {
 	enetc4_configure_port_si(pf);
 	enetc4_set_trx_frame_size(pf);
 	enetc_set_default_rss_key(pf);
-	enetc4_enable_trx(pf);
 }
 
 static int enetc4_init_ntmp_user(struct enetc_si *si)
@@ -801,15 +792,105 @@ static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_paus
 	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
 }
 
-static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_TX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d TX is not empty\n", mac);
+}
+
+static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+
+	enetc4_mac_wait_tx_empty(si, 0);
+	if (si->hw_features & ENETC_SI_F_QBU)
+		enetc4_mac_wait_tx_empty(si, 1);
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_mac_tx_enable(struct enetc_pf *pf)
 {
+	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	u32 val;
 
 	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
-	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+	val |= PM_CMD_CFG_TX_EN;
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_TXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_wait_rx_empty(struct enetc_si *si, int mac)
+{
+	u32 val;
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      val & PM_IEVENT_RX_EMPTY,
+			      100, 10000, false, &si->hw,
+			      ENETC4_PM_IEVENT(mac)))
+		dev_warn(&si->pdev->dev,
+			 "MAC %d RX is not empty\n", mac);
+}
+
+static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	if (si->hw_features & ENETC_SI_F_QBU) {
+		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
+		val &= ~PM_CMD_CFG_RX_EN;
+		enetc_port_wr(hw, ENETC4_PM_CMD_CFG(1), val);
+		enetc4_mac_wait_rx_empty(si, 1);
+	}
+
+	val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(0));
+	val &= ~PM_CMD_CFG_RX_EN;
+	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
+	enetc4_mac_wait_rx_empty(si, 0);
+
+	if (read_poll_timeout(enetc_port_rd, val,
+			      !(val & PSR_RX_BUSY),
+			      100, 10000, false, hw,
+			      ENETC4_PSR))
+		dev_warn(&si->pdev->dev, "Port RX busy\n");
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val |= POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
+}
+
+static void enetc4_mac_rx_enable(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_POR);
+	val &= ~POR_RXDIS;
+	enetc_port_wr(hw, ENETC4_POR, val);
 
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val |= PM_CMD_CFG_RX_EN;
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
@@ -853,7 +934,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
-	enetc4_enable_mac(pf, true);
+	enetc4_mac_tx_enable(pf);
+	enetc4_mac_rx_enable(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -862,7 +944,8 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
-	enetc4_enable_mac(pf, false);
+	enetc4_mac_rx_graceful_stop(pf);
+	enetc4_mac_tx_graceful_stop(pf);
 }
 
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
-- 
2.34.1


