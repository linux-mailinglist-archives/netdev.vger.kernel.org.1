Return-Path: <netdev+bounces-270891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKWyIiwvwmk+aAQAu9opvQ
	(envelope-from <netdev+bounces-270891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:29:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC41302F4D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0506C3180641
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06003B0AD1;
	Tue, 24 Mar 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmFcaqA/"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB53B47D0;
	Tue, 24 Mar 2026 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333185; cv=fail; b=pj5m1kAElrUHnVMHZlBRMz2r+CPtRuWG6lg3onGKKt4COCNXCjr38zQP/pSIZACHj0z5/8eo9/PXExyqC+bW0wv8QIe6iKJY5tn9ZAtMCrDIZqYXv8YWl1FeW/qB3SHK+WiKE06KNsiEaO5PpfdSd89ON+o6nCLgz3gMh161f14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333185; c=relaxed/simple;
	bh=oYsYh+MnjxCpNyujS2j4KM6QbEZrJm0jBFlVIruk99A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4kmOlzXbxK7bpxRV4vP1NZiTHBDhlyjwD5Szdyb8P5AglYlQBoNVdtY3El6QYIo+i1tgYUl42mmslEnVUvp7Jg7QgoKzWsyfz2q3KpgcY5hXTm6DOltBHvxeQebO6qdsPYVtQHa30TSF0mCNlCdv+nRWzDdNQsFFL/aORP/dnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmFcaqA/; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STtqX0taD5Ab5XVwnACn/0keVgUOD8zT8xcQ38bN/LZi04UVEXIAG4DqpGfcNozzvv1vWOrCoEWWDX+hctHcMrfByPhOl5JQMgGcg2oyk9kEYjkr9uXG7twJUOaGdjr6uzkHEl0kh6u7U46EIHyfr9Z4zE9FizLRZWtq+dvx7EhItWgddMxjjmSOFKpoNHxYhU4LCChvAkL8lPzXPLwIDO0LU8UMxVMZOp2J67qUzRzhR8UEPm6zvcNFdYCD1RDEGhzKUS5XQnSNffjLD9vl/y91bsbwaO4OmW4SEtD3xud1R1HyZRltdzgKINHOVKPf894AsvIhqEdH8fZmCJeW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSoe7TA4ToFYeGLl9fYAcyXPQEeORSuFw1f60XjJclE=;
 b=ZkiejSIZWU0Hzw4fu+o0ZVRp/YgVWPY13ugTWNiMXwOKEJw479BLzo/G9CExGuxZ8dow0+fR8tm2V9ud3LEPBtn+ZLc//sXzexmJT/UvOtIreDYaBUjkxPpZGv1l9INYsifyg0Z6KZMZZVIOYH6jFhg0+ExVUELRuni8uxj0QQK5YIvotxSr5tF4SOujzF15icxxh1WjiUxPvj0F2jNg68193sfA+H2LYfzE1uWffuL2l0mWi3RV8Vo17oEC073Sn9i9W1+ALaOYCl+sRLDAOuWTSQaKsu179+h6VvIlj4eC/fW/npF+p8q0JNV3UFFEBPyRIq9Oe5UGqXtNy88/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSoe7TA4ToFYeGLl9fYAcyXPQEeORSuFw1f60XjJclE=;
 b=UmFcaqA/daJmgVfQjyyfTz7UcbFoduYal+94EIVJ/pFmi+/cESW/OAohN5caG23hjr6tvwvHZuccuj74e6Hq2zHRA5CeoSk/Z8BhOdmG+cPCi0eG3wKOa/eWsElEIMvtl5jeArowjDzwq9tdMvqGDf0bz3jfryG9ht3FeJoXeHyLp0VyIHt7oHdIH65PG2OadoOhSe4CYgggyNh+MTCG+AHSDKK6QyA6P56YddJYs30jEVWN2YkNwP1Nfl4gCA7K/MKWNd3vBdKeXqxg1VPEouT2Q0uGMBi1d3zHmMW0rJRo7h4HL32IFB/iR9f3tazumOFuxDW994s3Lf4RPHGiPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Tue, 24 Mar
 2026 06:19:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 06:19:37 +0000
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
Subject: [PATCH v5 RESEND net 3/3] net: enetc: do not access non-existent registers on pseudo MAC
Date: Tue, 24 Mar 2026 14:21:21 +0800
Message-Id: <20260324062121.2745033-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324062121.2745033-1-wei.fang@nxp.com>
References: <20260324062121.2745033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c3af0f-e498-4a1a-2279-08de896d52f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rhedYQVAcx5vED8fK6ZzFTdirNynRjRWz2D4r6ahMl1NyNjTKMClbgqU06zNfNWEJwvCTqsSTtJ08fbSPlvRdIE+7DTedFr66hJjAHQzEJUvMdGyBGVk8J1Qhf+dZ+jtQN4J2x5W9LTWPW1Vhq6d/Dbpod7E1JD4oE7/F29+ckQKCg2Ltf0kkJHPJmdE8Hk+C8E5BEyCLdCpsnJmxMiEqGhyBu6bN29R1y6p/iQNTdqCDn+j4COLd2pjsbeVZz9quWe0X28b5MY0/qk1ydESN++ebFx83JsTLqZJQc26cRwdVcRTPE8tk96eyapt3Cou/4+pnG6Co/Elt4d/ntmXzjOFuma01GX2mfYvZlZNTvaX3Qdzh1JlqeTJit9OrlFnEWjitvpRynIrKIvtJlqASTMdzZcHmdn6jMZyyPRY2RtIxGRGmV5ZoKrPAu1kvH1cTSuA7GWKeVrmBI2uZrho8q6wCTfTP9GIDmCmCEY04os0rM4Ik+W4Sfs9baSjMqHJVdjKx0irCY4NZ2Q/cwib50TvquwldBxUG0QsH41MG+KE8/MPZoyZtz3eRIR/Uo7bS2IQfcQ5bBzpPynw1cJmC8J9aOM3mayMzdoVqPSKT7XkuOoydkASXx9ytYtmwDg/LU+8nFlX4I8REaPBkeNi/K46DyVDZCAgw0Wz7VXz4krfhxjIikbq9u2JuzPJXThBkGB34DoPs3BGyFLhpyTa/+JDRYKM9iwUH3VX05Kt+K/YDQNSFFiCcepoPi5298/w1JVzfbfby11ddqJgJYkiAND+GBP6KTCT1m0/2ACTNxAkqPUYxvuYrRUkqMvxTORo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhfG5Qqvoz8yGatY43i7vTosMYHDw92XWXDwsmhBzR4TVcNUsvmN4ojgJ7XX?=
 =?us-ascii?Q?3Q3+kqRj7jrTlzhsxHhrbMtqsOcDZkmHoSygfLovpwvLyT3ay2gCKQURi1Sj?=
 =?us-ascii?Q?pL0ofGqe1BxDR9i+o2/n7aa4EfEnHztPCEXuW+s3IyM4C7AqTqP9BskJUiXt?=
 =?us-ascii?Q?ku2ljsgb70S/yGlT2/qny8f9wiwOeNf9+CFuJYjigvWc0D6t3wfxZwFBkQN8?=
 =?us-ascii?Q?PpU8XuwAXMT+xCsF3Uj6HQ15sQab44MLlNWWH91gEpQCv4WErdCaWXW7uq2J?=
 =?us-ascii?Q?llMAQps/mvTGrN0maTdoAFV1aB/Fn2PdtFuqFCTnW4VbF3MMAad2f6mbMJEt?=
 =?us-ascii?Q?lOBATSPw1t8IS4RPtMnOuWiBbpLVVm+y7j26Zmhbd1nq60ZeK7V/8VzDc+6G?=
 =?us-ascii?Q?muzDBTrUmea4nN5dkGjYzoSo8kknouXONpeftcn+QU/aE/iZ6q3aJJEa1rYD?=
 =?us-ascii?Q?pYqy6lJIcxZHVdsGQ8E3oN0f5egBolb2quq6mX7qc/grzyL0VyObMnvPDuLI?=
 =?us-ascii?Q?LKxMZ3V47Xzolf2zkyjo1BzUych0WpqdY55/R4HhsNnfY9zwE132qaitCvbb?=
 =?us-ascii?Q?Nrl+SJYoP8bY57L3tptcXnC3ORayE9ctPTvXICHHDLFszXNmiek7I96zQnIb?=
 =?us-ascii?Q?kBOzS4wgP9OkTXRzCjSWEmZDGMiRwQaesikzoYuwhABz4Oziii7Ktk2caBmf?=
 =?us-ascii?Q?+d+8TWuXmlOx5ElIdMZukiUfREb8SrQc3kYaebYBU9RX+xAt2vrDtgiy2aEm?=
 =?us-ascii?Q?R81UCMOjTGMlsCFF20f5V0taLD1DB5NUwOTmoeAYZdyAnjRlQ4wz40N6jyoc?=
 =?us-ascii?Q?Vf60pZVTWzc3KaTNyOKiPEoGSqDKvD96baECqEzoUgS3Pm7nQS/H14Kba292?=
 =?us-ascii?Q?ZDfI7ZoXpuTOwmebdt2zmfZbJP3HX3xtMhSqmLWJTwPmjRA7xD6a2zoPxZqx?=
 =?us-ascii?Q?QWASTMIY3uc2duSQbc5skWHDNOFJ7LZvGCn+2QQqdfuDDebaaOCGoVQJn0yy?=
 =?us-ascii?Q?fQPZ+IR31UOvBQTSDMOnyl6jApGqnwwsiRlpRSQd4oMnUg7H1Z6xJpBXxVz6?=
 =?us-ascii?Q?kKeNrGORtlaQOLxff8j9tkJyv2KBRXw/ZLZ6NUcu3pW2nlryYlLhkP2L4h3a?=
 =?us-ascii?Q?EToHDXPQth0E/UjuzGrsQKizNi9VEiCnmSRh5RLYS3pe8qEqWB8ZQhCYzQEp?=
 =?us-ascii?Q?sXwyFdN6OHDe3I0jdoALIa9chwYOkmnREcJ2qgfbpYzyeTvPO/7/QcEKIamZ?=
 =?us-ascii?Q?C+k3qvQ1YKykOFQPUdnjUBzOWbcpsAM3IyuOkW4h/BCvg1RHTcURon1rbXJy?=
 =?us-ascii?Q?2v+Mx5vrKutaGYpbpJtrZ6KUwfkmGZ5s1hoUUWpHJ/K3IsApub0AC+yQZ7gF?=
 =?us-ascii?Q?lQ3LZL6T3U+TPjfBEAsUOcMCZDVtBKs8QxNNTi1fA3zLaoVEUWvckWShXI4q?=
 =?us-ascii?Q?w27Q/hOt0TCn3XgIduKK8D9rxA2jnurnEM+eh9DjYl491u2xZ0lTEm6p2h2I?=
 =?us-ascii?Q?CQeYiij72cQN1LCVGx2mN6ophbv+PIeTbNKww53SJIpcsKYUZuICsKjIkwBO?=
 =?us-ascii?Q?9oMwfviGoJvX4Uw5OfRT1+5ycoeC0CObL5ZtQLACe9z9tjd0Rd5K3ShA852J?=
 =?us-ascii?Q?9EMY8o83qYw/j7O4ge3yTNzPcrGW0f2rk6GjOuMoqHGqDI5UmkQibeVCvazu?=
 =?us-ascii?Q?v5o5jwj70ZyFiir+llEmBycSQGnlFSolqLo1Z6UweqnovImAZ9DpWGycqKGE?=
 =?us-ascii?Q?XTTGXNh3VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c3af0f-e498-4a1a-2279-08de896d52f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:19:37.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c08pbGQ9Gp7L5DDxg9JToGVeLOtAZTLTVwRYUlyGFEENfLTWWJpkxBMskAYZWJepY71m5TFLLLEgZyaqAUH/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960
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
	TAGGED_FROM(0.00)[bounces-270891-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDC41302F4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ENETC4_PM_IEVENT and ENETC4_PM_CMD_CFG registers do not exist on the
ENETC pseudo MAC, so the driver should prevent from accessing them.

Fixes: 5175c1e4adca ("net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Tested-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
Note that the commit 5175c1e4adca ("net: enetc: add basic support for
the ENETC with pseudo MAC for i.MX94") does not have such issue, this
patch depends on the patch 2 in this patch set.
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 53cecbb23a97..56899f2254aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -814,6 +814,9 @@ static void enetc4_mac_tx_graceful_stop(struct enetc_pf *pf)
 	val |= POR_TXDIS;
 	enetc_port_wr(hw, ENETC4_POR, val);
 
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	enetc4_mac_wait_tx_empty(si, 0);
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc4_mac_wait_tx_empty(si, 1);
@@ -856,6 +859,9 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	if (enetc_is_pseudo_mac(si))
+		goto check_rx_busy;
+
 	if (si->hw_features & ENETC_SI_F_QBU) {
 		val = enetc_port_rd(hw, ENETC4_PM_CMD_CFG(1));
 		val &= ~PM_CMD_CFG_RX_EN;
@@ -868,6 +874,7 @@ static void enetc4_mac_rx_graceful_stop(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC4_PM_CMD_CFG(0), val);
 	enetc4_mac_wait_rx_empty(si, 0);
 
+check_rx_busy:
 	if (read_poll_timeout(enetc_port_rd, val,
 			      !(val & PSR_RX_BUSY),
 			      100, 10000, false, hw,
-- 
2.34.1


