Return-Path: <netdev+bounces-271910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLsgEs7lxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:52:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55047330A8A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5246302F78F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A0350A05;
	Thu, 26 Mar 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7Nueb9l"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8334D4DC;
	Thu, 26 Mar 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511439; cv=fail; b=SEDVJWJ+/5+mn9aJ/KxH00pfsOBsB1X+dINVl5ywALJ7Ljjsrc8SaxM+HtfOs3fp1weX7t1qgvaioZ7k0WCvgDPFee5tIGQBeVQAXITSxaf64ZdPkNFQPSZTo8hylc+/GtJTDXwnoJm89Es+CtmVwSYosrWa5LjPC49JUk18mew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511439; c=relaxed/simple;
	bh=Sk5dA+YJavJsTOF9CdyxOVfzMPmHOnO0sfHpoQDA2l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fec3rbY9xqrSOss1/r9EAgh3YjxjSImEPErJPmCVlRHc54BEhQDn27Wm355yVqs3Neo7Z3KSngY1qUw6/tFgaPu8PhUnnnohbejZ85GSwhyImkdCE0sCPvsvwPuwvpF3FMFZLMM+5Gy8WCFNq4aS5jOzhOUJix0uxhpTI40wH2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7Nueb9l; arc=fail smtp.client-ip=52.101.66.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kszdq41H4+ZtRThBTM2ltZJjUmll+l9e5FDHXpFSJyBS0nEYnmcIvkueIU9GINXQ2miKcWgw8J9/Q+PmPhJr8jTnUP6AI3slJS9gvNr/UCEBdtX7qiIzzfcPHO2BMG6n3nkiRPd80xiDZvVLOSDFaAthMVZEsODO9YxVOY+AXYVxV9sm05l6BXP+ci4++AQ5JfESy8rp6kRNhEPbK+fSK1RRQ2MSM852vBdMsprTiNK+jTjq/DddEhTLCsLuwSLSlXdoroKbJygq3Vtx7jFQhxbYfYT1kkpn5F9uhIO4GC3ZNIEqYck/7jBBveIS8PPpzmrtwPAPz5INN66atqZvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1K6prAxbZ56CdBCZS7hymqqRFcVXPZIeWRYwGwcN78=;
 b=FJ85brpzHhcAWKtO4ENm1u0myeCByHtGhEu6DYHx8WtnMFWHxRqQygDIWoBlPru28281kom8NupO9YS175hcV0l2sEqnB5w4PeGYiIc1q+HGAA2cdRY6qOYXzzNUJx7A0oHytRSIqhPero20lsnCzJJSDHl0v3dKqHNb8PUIIGlDh5qsPt3viCRiAt1oax1bzSeeVHAQjhyzTQEeA/AX3fMJmKVxqeQag4EDgsQWRGQxFb9nN0zhln8xEEmpFJ1y4p4coHEKbbJAyrKUn2fpEWGlQIGTZUp8BGp0gdodIRMJ2EJaEg2UK8RaGCq+1r6EKnwEYw1kiXV3gqo+OO93zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1K6prAxbZ56CdBCZS7hymqqRFcVXPZIeWRYwGwcN78=;
 b=i7Nueb9l2UL0lOIlhmaFwExHuQBeHm17m7aelYFyNwVfyrUXQSzuPLZzydpWtESbgFyMTzEbpE1ARCmriMOXQTD4DSb3BZ/XajLqS/tMgl/W2MtQYuVoeY10Ia7G5Pfqay9re0xReVcauUzV91xgD2gua5PLBiwAkHLeNHo9/AL9gLqSGYUh3v/kiVCQ3NmlyGdk/du0Ybdaf20wNhR3eqbFUpvBySTLYGNQOJSBtvaI1v2M5h8PCvzgJnOfvweU/1l5EviI/YwWFDQRt3eaqXy+rqiws3MuKUfbOM2oGqe3Ew3loi+eBkpXWKplHCvMOkIj6gxV23McXBLzbT+Flg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AMBPR04MB12282.eurprd04.prod.outlook.com (2603:10a6:20b:720::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Thu, 26 Mar
 2026 07:50:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:50:36 +0000
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
Subject: [PATCH v2 net 1/2] net: enetc: check whether the RSS algorithm is Toeplitz
Date: Thu, 26 Mar 2026 15:52:32 +0800
Message-Id: <20260326075233.3628047-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326075233.3628047-1-wei.fang@nxp.com>
References: <20260326075233.3628047-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AMBPR04MB12282:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bb10e3-06f1-425e-9d5e-08de8b0c5d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	76VpDKiUQSR8cZIX/JVqObqPaZT2Pt/87i9HtT5M/rQu2GZ9ChiBwQmA9RAuN/QQ41UHsDT9F6vm5m3nUnEUO5aNf0krafk3wvhs4oUcsNasFgBzo+jMR1C11rhhecMyFJtgyEP70sHc0n+aQBwEBkKKHsahYq6Y2o4YxKzy2b0jhwzdzEUubFGb+1d/tOcwxjYh2WzkV+F5REQ3O9hdcA0yWUBJ0iPEeLAacTXb/jEW+OxIcmHje9fMh+6UkNXTqEPaPGerQO9zDOoeDfRwMWW/8sKzcHSCpbsrdUdf4w3rRceIFe2j4zpKjf+miwVGGQMDMzFyHSANixFzlrSqaRiuc/0xqxExzqWZQpCL/bPG4TzqEvIkO9aP49G5uSJNL1Td+RLyoAcQLzVH5Wk3eEVx33G22hiXQOJZe5pqPnzqaVODVoU7JqCpQ0CgmjmLDwoH0cGemuuPLQnIrDCYav09W+0EpsNBABOeaQyH1P47cuou2yumQAao5Tow5G+FTp7hIm4u1Viy7e7ZnJi8hVMm9RtpM1kLi3WogsThYyJdRwuLw/ejQcJPOY/nMY5yDK8GlPDHiXEKOZrQllNAcU+vQq1ti3Jpv8dQXCP6lFa/bUCG0tRPz16oonVO9267420OOGsyyull2bxSh8fpRjjWHUJN5b6bjHL9C0Iw+hzjBesPO8TCFV5vRcz3tmwBnKIlkLFjp1j1CANZ+jSXpXsUpnEZ4yhtB4sj2BOnP01ki8SjALVv9GYg2szRL/C9qXJ6Zc1KnESMiEcCA20zicRC59sBB4QjxdJPZra/3N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qhBbYhgBEnW6EKBaEsHksKrJ+KnEIjOIbUvYsFZ/NqA5+nPj8SjpQuM8oXS?=
 =?us-ascii?Q?Ow0qgEZBOvQhg6azE/4hZA2DaivK9U3SAhusNwbihyGH4lIltSwLz8L2YTwO?=
 =?us-ascii?Q?UgsOUWqPcDJMYhG/y5Eqjonj9d/owpiRv3GNP9twCEwUhmxDT80O1o1RSMly?=
 =?us-ascii?Q?eKKmtYQG49t2kHpKhswqyNIPBa2zhI+xJW2VfnVWsyJqtiaHW08s1/+PRdrI?=
 =?us-ascii?Q?FaChScrI1+974sLjcVj9dLffbkmsIhJC38qUP1+T+w38QZBHj7uUO7Vkc7RR?=
 =?us-ascii?Q?bTH45nC1aA2JKr+ky2jtQetmyZ/sZrYXsRQ+JVE2DljUNcWC0VZVYXYcopv/?=
 =?us-ascii?Q?GFG1M11FJnBe8chZG610nxcqfGlxkmh31VhhP2DK4NkyC8N+sp+GWpeLDnDi?=
 =?us-ascii?Q?LWX36fNCFebPoeUL/B3GvgRnlIfryfcRbqY9yEgsOztfPHstZph/pCdNpiYN?=
 =?us-ascii?Q?bD8nC3wPLpzg30haXMBqbnNtOMhgPFc+ZRGJkNvHAFsCkuEo4OTbv3ZUJ99k?=
 =?us-ascii?Q?W8myqZSXVLsdnQIP/p3kJT2ttKsNhCwYs5E4HnCDfi8bkrC9jciI/Q36hYFS?=
 =?us-ascii?Q?nmTIVhRxhPj+95xR6cOAix+8hTn/bctoMFzEKfs50INKFi9Lus5ETnEiTtCp?=
 =?us-ascii?Q?kScJ93zQnjqZjkF4RYxEDL9Wnj3KGJRFemxLtsJwAModN0G84RrEto4ze5QM?=
 =?us-ascii?Q?PQaTfODUYRTi7+FO7N9cc5tkaaqADiPT5M2iktjBqypfKirpZyfu3P/Q9JYI?=
 =?us-ascii?Q?k9w8MIGyhp5+69P41V5nyFY8jVZZ+BrtfgFrtwlMsVF0QdApaMwiJlAUEoZc?=
 =?us-ascii?Q?igepXxX8a+g/AY1Vt2QvZJppXfZ5wB6zvO3NvKcCJF4Mp7kHR3fk2vyd/P1F?=
 =?us-ascii?Q?MdXW6cptIG3Q9d0OCn7h2/axGW5PSGs9NE+bar3Q5Q2BOU/1Lug9RMscnTUw?=
 =?us-ascii?Q?LTcXg1QwDX21Yc5yFwlm+NH455sAa3ftbZ8nzhmofdyZ/tcKYZ631dUWVncg?=
 =?us-ascii?Q?LBfuVo17QV2fHiAb9Ipak+MjnPxHDlWi0yjRUFzy0jg1xjhW+drRdpJdW39K?=
 =?us-ascii?Q?3WLI/roNg26OJ1P5ue48MCstKuH93U35W2zSk6I67CDacV2+FHRTTA5e9V/U?=
 =?us-ascii?Q?9jJq1Gs12savcnwcvvDzlQ8fhGbLo18XAYj89/hFtVW5dS9MpWWqRS70xnTy?=
 =?us-ascii?Q?d6F5xHRgKR8X6oMdhGl88Ji6hX/vm9iqigc5fAVuDU3tozH+vxiPRkJqY4NE?=
 =?us-ascii?Q?IULo2wDL+/c7PIuKuhxMvT+SNAR1d7atlCfgpG8u4gZP2xvTl1C1CJMbJDtM?=
 =?us-ascii?Q?j3uIwJmlnbfdeSVKeLg5KZBamXzYcX5Vp0Kk22rT4TiA8R4A915M6KbZtOlI?=
 =?us-ascii?Q?EaXIRDiZxXOGVPxoB1S+I1qzJtQX/xfTNAAUyMI+CqR7UYkfr25aQD/xx5Nl?=
 =?us-ascii?Q?y/H4fUACb7H7APw8qE/bNFPwMKQ7DZLfcfMLgHX1iJCxArTkf0VmS87NwLiy?=
 =?us-ascii?Q?x+VQdzCzEdMPWAdLK7c+LqdwfqPHArRskFgpP9R0UHqS2Gv/EOqMbUWB5x0g?=
 =?us-ascii?Q?4nLoRalGHt2Tj21GyBoR63ihJGx7LxQe+3FoKxm0+OmkbngLeJBEsH8WpGE5?=
 =?us-ascii?Q?AMMnF43bEhJPOtU5RUIHvXjUY3lhl8QnNyVjy+2labarO5siHLCTKsnkanHR?=
 =?us-ascii?Q?N5KU/t5mUkuJpAXkRAq6+i3/ef2H3Ixn/TYwJ4YKySoq1vic9zjtZPO7oBkB?=
 =?us-ascii?Q?2myI0FcogA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb10e3-06f1-425e-9d5e-08de8b0c5d42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:50:36.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NIjANxJknHaRtiFb1QQ6Z61w2i5u5sVsoQgzeeY7cqVDtMC1Jktate8y12PzSPUHCNSIcKWTvLMvx8OXidpbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12282
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271910-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 55047330A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both ENETC v1 and v4 only provide Toeplitz RSS support. This patch adds
a validation check to reject attempts to configure other RSS algorithms,
avoiding misleading configuration options for users.

Fixes: d382563f541b ("enetc: Add RFS and RSS support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2fe140ddebb2..a393647e6062 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -795,6 +795,10 @@ static int enetc_set_rxfh(struct net_device *ndev,
 	struct enetc_si *si = priv->si;
 	int err = 0;
 
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
+
 	/* set hash key, if PF */
 	if (rxfh->key && enetc_si_is_pf(si))
 		enetc_set_rss_key(si, rxfh->key);
-- 
2.34.1


