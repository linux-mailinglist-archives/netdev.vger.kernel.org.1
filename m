Return-Path: <netdev+bounces-267424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OaOJOr5s2nWeQAAu9opvQ
	(envelope-from <netdev+bounces-267424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24A282791
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A24B0302AF3F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E99363098;
	Fri, 13 Mar 2026 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAgOzC9t"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D638A29A;
	Fri, 13 Mar 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402578; cv=fail; b=JT+g0l8HP0cptTTyPAtCVP9hr84Mx2UO2Ag+KfNRkrsgQtlDGKX4nPYayEo6oNcHcOJHqQ65QX94H/BH0k3ZsKEdGZdcgogpQ/bgNpIcktaTcnqxWwbHvUMBt5gXYCoR7zhyiSHlOCDTxKK+xnuuI0PTsEBosl5GzsqzTb1FWVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402578; c=relaxed/simple;
	bh=iRz/2vpou2aGU1RX4d2uo1y8E8ITbSQ2OnJhy8QQ7pk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kqbAHpwrFQaqCSHbDdJLWrhK18K/CHFcecQ6M9EmjPHGogNX49FJMz4vri/bXPTWFbnPPfQeWjYTC5oXWGECsMx8Gm3zmY0jPTIpPLZA4meVL05AeCIJLkIXfidFyHae4DBj1puR/7S9aibWnJvCFgKw4NmM8HrJR3UZfPnN3EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAgOzC9t; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJDr5//tCFGvBP+RLGoDgXGlZVNu9vQzxSCF8tIuiAQkynRIc2Vs8ZCWF9QoemkXJd432GTPhXvPMTo69SvfhHLhqm0MDnVfJdK0xxNuQy1bJR8H7FCk1zSRazknYae76zQJCSPs+sRmk8G3rqnr8zN/dy/w12WIbImjTa5QO4UvmkIChPjIAK2xCqHtJTHUNK+jf9HN8MdYI/2yNrrSFB5cOlgkF1OmWD1H0ml2iqEIMkATEJTxOF5NNc4iotnV7uhguLGLxUg/O54eBvNYVC+h+gc1B15evpuRAq8coVaRYE70t+brMy0gTe8wFBwAPdFoQ7P3yt0Gv4D9L1UKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbUyBoetiM0+QdgMrQkZX16lG9liPmsIujMpsHy9dhM=;
 b=SErhVTS44epknlfQo4b4qIaSpT7xwSAf3mktgfKEjfwKocGIJNmoX42nQfDXdxIwTYXlhpMp6VIakKA60BygFYX46R4iW4bYcC0TxKKl6M2yMEyyuRBdtCzurchqvnuqyhkQjk9qzuqde4lKOwktU/03+H6miAaC3MMkB2ozUqS7tqkwFLSAvfJBB3OQcy0Ki2OjV7osykdUTOhiBIo8A+39jJLQ2KLaKWMkY9ZQisRrTcO40ou2hU6NHReojfmB/ZrxJNijls5exEQ+BjaDOo7PZ5O24ZwpGGui5bOWf9dkl8l3ke5H9TWQwmX+RIVBud2NHZd2LbexBdDe0ZwYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbUyBoetiM0+QdgMrQkZX16lG9liPmsIujMpsHy9dhM=;
 b=OAgOzC9tqG9qMS1Fb52ooxvaoXkP07HnXwkJRVOs3yvqFQLaYpf3cLmbO2lyiIkIu1YgE06siaWX54snY2XbUHp98n3za9FRJITz0j6cjXhnEFHQ32mYXzBmntOyQ1epT2v2zlerFUkCauVge94sCqMTZWHz/fvGcVwEIqaeCc/gp0rddqyYQ38WjHbaLfAmwpFvMsSHvEmqcigKCwZY76mSjFa1GiUagt1kUbiqY59nEp1K57n+aLG0bu/BxC8YAJbyYpTzuY0+NboTfXcO+aCJpnm2bhS9L+rLNP6N/m49PAQOQKfh5GvbJnTnndJDI2XWSa0lMHzMg/hUWlZN0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6831.eurprd04.prod.outlook.com (2603:10a6:803:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 11:49:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 11:49:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next] net: enetc: remove stray semicolon
Date: Fri, 13 Mar 2026 19:24:54 +0800
Message-Id: <20260313112454.427191-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bb8a1c-b5ff-4791-4039-08de80f694ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vLGHgGEotJLjnk432j8Nm5kjR11Qj8H71xDpr469OreOj6APDvlfzMJsIgP8ZmiZyICk+VXlQQoRWFRpLjX7FdX5FQO0KRmNixYT6MTq6MwbTagFenWHS91nQka9U7uhMs6pzj7TQFfJed9QDOZDoO80EwhOIgrocP7+FzSgM9G+zfiTmPbQ9zPukZXuWwusve6h7berkOzDKyO/2vakVMOeabZuzxlQlddqpO+UCjSIF4MBzjJcKNz2YNlG/c9fnabxbtcr0crgwRWmVGIeAvmkvjPSP0iw3hv06hVlxmEB1dYm4kCBZBqq9ibggOGwgfexDIDSTKVWoyqpNEjn2GHU7Qs6YI8rGXuyn5jedBKm1ftOUZwUyaAtCYfRPVEScz4v+5TRRJUjVNHHzsADA/+W4E63kvWuIHYd2ex1wRD/gD6HnzOwE7cgi6r8a96gZjwW3NhlngNOgvpjhw2h8HJl2VJ4rDibINznR2xXlcYqBNvr73L2yT/aC7Ga5KCRa/U9chzBpW0tqzwANp1aWi4Xz2GycZPBW2rT8KmT4J6uSnPyrD5RsXl+mU/QY0HKwGzPv8WIBb0O91l/9YcydpOYaVHOw4L5YxG2/IkJFPNbLlG15v6bg+NQGnndh43pHsYPtUcfPLxpmVdq9cgqRedJFcEXxMlbkqPTLGg6/n0dFHJ5B+TgNJfiVU6l8BEBtxBFjZm2Vw3/xYL2ckiLdcWp2cLvfqAdwS6le+WqxJ60Ui2q90m8r87V1zgRhg91bIM9qn74px5orOHs5Af4FDfOOG8fEIr+TGN1DZOG4gI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GyS+nuo1jc0MvfHUxeaMSVgfZ4ZjjYyg+yArcRL2j7iMhIrCvzbICV33sXL?=
 =?us-ascii?Q?oAoz41rf8HlL1T34YP/BYDcd8RBzKysFo6clDg5qjXlvEObkDlN59H7zfeDT?=
 =?us-ascii?Q?UTUDx0WmagDimvwRn1A0vIWlJneELfHSqoe719rRSVE8aEnMJHKXottdtpre?=
 =?us-ascii?Q?G2ZgJqhacFzJzk41wp6ry90mGLTbRcjJTTfg9XQPCy8oaLMJBhmHMOctRZ6h?=
 =?us-ascii?Q?uEOzHIH+BG6nQJuRzocuq7cISjJaWiCaSzDAJCSEQE2WXM+6Xh5M8V5lbkLv?=
 =?us-ascii?Q?AvSuMRAtct8cLzZRBDvAWCG0rl/44Jhnd3hHhv4c8ys+7xZqfV75rUDYvUPg?=
 =?us-ascii?Q?mvgS9puC8BKKRTrIK7y0tnBD/QfkjTuX37yjPgGjqxmzPettm1XFlHY7iQIQ?=
 =?us-ascii?Q?yMwUbhpLcPRJSRJk8AAJzj1g8oEErx7lLgfFjyz/lnPp/95zJkrxoGtdW/3j?=
 =?us-ascii?Q?CX/Nk7wkrGUY1taTR3owxjfA8lwSS34qwh3inxUcOqfcBsdIxCNjfPuPiSTr?=
 =?us-ascii?Q?HkP2kioYQ3143t2A5TlLSs9CdMtyUlGEj7YRiBylWUbpgO8bJ65YNUSArqJK?=
 =?us-ascii?Q?YjfeDpUiaqP28QyCvZEaU/Yzoo9bL0TvhvQgFIefDQ6pEU8zibK7htFpS7/D?=
 =?us-ascii?Q?h0qPuP5ZgL0U4y6g+p7JNgIgY8Az6WfE6Nh0CD+vkgisjpIYfxoXusi+c7k3?=
 =?us-ascii?Q?3gwgjQ8YGG2Mp8+6L+abdWccBAh9lo1Nd7y2XgFR9eHGkiEjfEUS/wg4+ICn?=
 =?us-ascii?Q?KuLMZYojcPH6OSQzTAbeOC56vqbEO8KTQFRTJNrXzyqNiHCUmdhZSbOA4Byf?=
 =?us-ascii?Q?dQaBgzYwJZvrsSw+fOfvdKMl2/5KLKklQJVnZHO9079vtUcVQJUOKgz4LmFh?=
 =?us-ascii?Q?zUY3dQFM1PWMX7ohQRmnBVu5rMWoz59N+AsataCEPOlulIBwLpAFwuqymFfA?=
 =?us-ascii?Q?iLcNncDarelVRKLh7AfH0ShhCkGkJiNRc4qXSJUABUU1MnnZoaoLkeffoyhE?=
 =?us-ascii?Q?9Y7dLW1IJ7XDsnjPurWB3CZmx0e/bKV+En0SAWm5iHEHVnwa0OA4C2ko2XqS?=
 =?us-ascii?Q?V4wPTvM8/b6ATY6Hts4E8d2trSAdvG8lIgaJYuGFVkvILGO3ns0KPBxvxoG7?=
 =?us-ascii?Q?NPVKyQ25GMH3qU8bEpvM+q6BjqpMtk9/GJP/QnO0GyNgLPAu9OaEpbD03DKV?=
 =?us-ascii?Q?MXXSBXGDQ+Nci6LuODCt7SliRV5Ywrx82aoEKwyazhm/gOsb+a0e2GXEFjeJ?=
 =?us-ascii?Q?SmoQNDye64riZCh9CiX9LqQfzQWSwfMFDXZ6qgIW10sabgTlI5mtVllSJZWD?=
 =?us-ascii?Q?lhIG0cMc1ikZ0yZBIJTWGbZwDMAACv1Lkr/uKO3FXn62cztFyjC6eq+/19Ab?=
 =?us-ascii?Q?M/bpftJlkR28YUHqTdf5K8DB/LVTsw5EBd+l5N6403n+TTIvW6JchZV/pOGt?=
 =?us-ascii?Q?Fq9qAGGrIexJ/ifZaTOOrOMu80xhTa6JZ5OCRGg8XyD5d5t16TRe45TVrzga?=
 =?us-ascii?Q?z5suyJMOO5zS4F/Zr9J3iKOK6AjFJFYWc/Bm5jlsHRtU/QAMMg2i7fqqIQiX?=
 =?us-ascii?Q?Vc7Ves88OoWzj7+nbuVfeElv6icxbYiFhCZAjht6QD7kiG4JGtv2gz93Ucza?=
 =?us-ascii?Q?sUxYxEIELtiBtIK1TnfgJZeorcek1AhraROzlg86z5FQXbUDVG3HVIJJ4vmC?=
 =?us-ascii?Q?XlryMRPwC4ozit3e7OghOKm8VgG/9SORZiwXVm/gts8lcBEVclOBQ6F2QJ56?=
 =?us-ascii?Q?Tg1kWOlG1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bb8a1c-b5ff-4791-4039-08de80f694ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 11:49:28.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZyVcqGmdtZmDAkJNKR0sdFiVK2cf7H9h7vAKrEsbnCMPl1Nfc9UbTAuWjlRkIWFZxSqtCqwlVauR5Z8DD2Nlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6831
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B24A282791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove stray semicolon from ntmp_table_name().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 0c1d343253bf..703752995e93 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -227,7 +227,7 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	default:
 		return "Unknown Table";
-	};
+	}
 }
 
 static int ntmp_delete_entry_by_id(struct ntmp_user *user, int tbl_id,
-- 
2.34.1


