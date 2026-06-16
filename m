Return-Path: <netdev+bounces-299726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91o4OqfQMGp/XgUAu9opvQ
	(envelope-from <netdev+bounces-299726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:27:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B068BE37
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:27:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=uhKKtW+q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299726-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36F59301EB7B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D66D3CB918;
	Tue, 16 Jun 2026 04:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C03C9893;
	Tue, 16 Jun 2026 04:27:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584023; cv=fail; b=LsuJTeJBxUiPTChgEgQ6Dnx1Hm3UTDuXU4K0msnTp4iWJ7YCzMaF3OBMcIgoqbyyOlx3wdfew8DiY+8fVUUYywDpiNcKqUYM7umHKVIzzC4LHEqTStmfIludiLv2Mxh7UlKNkM9m2IXoyqufzB9VE8SuE2Zr6tIosGC8c5yfqaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584023; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BklNxm1PbLDqyWSFB+zgDbZqeU+7RxRhunC/0Y2bHSMYzMGt4mWTh4UY8FVAjRhM9lnLcqRMoHubjv8yqEt1QHKuRazvb1Z7FuMl03Qzx2cvE4sLFDh5ARSjgVRWmbI9EjbMBTZltyB+Yb6SCwyTHLDx4uJlpZo6cpQStCgW94M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uhKKtW+q; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFz7uJHzIQ22HvSrWhMbiXfujS9mSHFOelXgwseVP9mFOqeGUzOXIKOwf286k3Bjdy1eZ8IUIh3irtFf1DJTQbwe8BnieUWYNPRA/Gi8+nWzYa4xNK3hzrEpHV92akb+W0T6FTZRMwQ6fZjbel4Z6FRWJ/vOhxuG/5IAXsLvulQiapzH/rjdW05X/f0pIerYml8hloWKA4317n7C1Jtpk8xWwUVPJ+OX822qWFg34nZ+ZkRxSm/idIjEvnUVHkUYUDx3saRSeVTzyohjqBZXmaHZXOTmlQxpObNyQJQTrjEV4EhjZ+2cGtgXWZwNFfzgRNyB517N0KyHstuL6Argog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=ScV96P/AaiWKkNfDmopbTcOD6RKLFOZNQW4+Ur1/XXFAuNenkscbuyIgan+NaWSwbYZyxR4gwXCzKOys13jxk0Jy80GbJkUleO8+qjoQ4kJEk3KmB7/bwKZly04eXnAa9RaS3GHnbWr58BGfGVM0FD1Yuceubz+lfaFMpCHgdk19MZq+S3QrRkzKywvkclQ9w2CY+t/VvPsFOFKkDtqK0hTHbherVkdsmE4cJpzv/ZXKnosOTCoznRxeHrQF5WZZbyZHTgmnV9qG46n9rDtx/c4Y+jBHpkNhh65bClueJfvW/XrAHosiSNKMXcnV+AB6VaVwpoZ2q7c+4bNouJu5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=uhKKtW+qZcsxN02a0SYi8B/8pDAZq75W7kN1hxsuQy/uEWYkS9AJhhZdKAkjULa7ILYW8oFFEsLoDnjeiW/uJyKl4s02KNbtPX4HK/4MgCsqYUfA+SNSzYGeUrqdWrTnDahQyvZrn5MHIk/BnPU291u4R/kGRB4YwV3UYo6gLwQlEa+plKIqfiZrlRg71ZyoXmgIrHX4ock7/kO/glHVI6amrd5RoZx444azg2PKteh5+Fg4gaMH78J8zncXHpjRlL3ncJ9LONS3sqWpx+ozYAMxNrhTGTcgY7jggCsfx93YdJWULt8kv5b2vYfkjjYMzndMr9532w/U9I5OmIgAYQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 04:26:58 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 04:26:57 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] net: stmmac: xgmac: fix l4 filter port overwrite on register update
Date: Mon, 15 Jun 2026 21:26:53 -0700
Message-ID: <20260616042655.7782-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: ea18f175-9631-4fb2-543e-08decb5f8073
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|55112099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5riCYaNFeDyI3lv8LAwAPbwriQ0sA4lfLcYu+3pccoCdug4/4RkeROTyii474Bf7FWWSh0vGnOb31JDKn+SM2CJVHxNHVGmKxkkpQ4E67gGOFFsxTkXLU7AWstVFv8pOZt/XSLYneiBWcaC2oolCIbv7MF+cKdTSz1Wi3UAIAXAN155b/dhjbYLPwqb5Y3T8a4szSfp8/2/boN/oBDDNm8T5j5rX/XflFcKSKoguc6QpHkda7VicT7NqbEg4RXtG2DDKgi9C3Jw1IXXiLJ7EyD4WUlJM/HD7A2Ie4V342NdUAOTje0yH6xWSQcNWraDbxOOIXgFTMHQNTfnWzD71VY82Y3oanCur4RRlxGvwloJGMTx/d2UXuJZpoFcqmviJglslZNiLhAzsH23o8MtUl1Yz9xf/ynvZ/Rrm0b8P5ZIHa6jRbM9zGYM2rzdv9O1cYHj+8j/un4IScD6/B7i8FMrbyf+o/f2nlFIkO/TkKdS+stJ5mqTX9CyZY1lxcyaaZs45rc5YMR0s7g57gdn0oCbJb8bLsLUH0Av8PoGTB/OKfKTc1ZtXZNmDbGthn0/XO/Y3OMCBrGn6v0bmuj6tgb4Jku1SaY/TMk2HesxVEs+RfFVrxeHHeQiNzwyDZcKec1ro7TPF2FIG6psacBrbeJo3BT2qgUD0s98jFgrfcwLAobD2Cq1S+dxlch2uSsK6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbWsYJrkQrUNHYU/UGTqM/hBH5wnCxuvUjnkLSrTJvC+kreICyp+8WuAXuri?=
 =?us-ascii?Q?hEzL8Ql0ux1QqydKvDtTWm2y5jAjqGHvbWYjufuiv0om1EE6nNH7T3cySx4v?=
 =?us-ascii?Q?v1jDhJ1gdLsIR0Y032ZTlz2OUexWO+nMddYo1bbuC2PGBRKftbH1mTV1sbZ4?=
 =?us-ascii?Q?+u0OumTcDI8MX+e+W5MCZB+9lHaP6PNo7H2+jikK5+iNhpwbTpewGwLcaNKi?=
 =?us-ascii?Q?N4Gw2Eex7MFW5zHKvTThVcJrpio9/129J4kMCSb2mQDHpFVy+SCxXksia+C0?=
 =?us-ascii?Q?Qx5QTpISl20Pir7zdN+hmHi3I7etzNZe844mJ44p7ikEZuPLRpCDBITtZGst?=
 =?us-ascii?Q?b7FQEWk4dvl3KJmRIKz5gI7JjiQLJseu7QT3DuzhPGmWFqh3jicf6N/s+wnr?=
 =?us-ascii?Q?VqEdh/zzlGTRE9WFEv1ViVTK5VJ/UwHQct10pbT7UZhYIkp3ibPhFdc6YVri?=
 =?us-ascii?Q?ugZvPlzNRO2MkrsClumOwraQ9WN6d4TEiF6090bmW6ERHuwMh0+6tCQC1vAu?=
 =?us-ascii?Q?jNh8i2DfaYLHTdpQikB/Z1e+TrEZ8l88RbFMJabV+WLi6qWiw4uQa8sAg4Ls?=
 =?us-ascii?Q?Lx5gAeqpIH0zbtnKsjLeOrRhlFggcJ+TTwqeQBKfZ9JWBjRHwFsvgf/cxZto?=
 =?us-ascii?Q?lNLd6pf+5U6NlD1te8rcTwolTb38mCdXVBfc9MjXeeoLFAQE1neP+xke+ma5?=
 =?us-ascii?Q?UCqbCOoGdVvHlorXNF6G/iu3O31ZD9zwSCfLdca+Oc8giCvffzoIhS3RGQBj?=
 =?us-ascii?Q?Jf1RaGh+ZUPMy6z2TP8fPd+zghAazd67lBAHgoLBrIjeELNqObh1YFt1A89R?=
 =?us-ascii?Q?QTQploj33Bkf9j6eVsfTqGs8h0YSngrfmaVbcgGCbffeDTTFaBWwtLMnub/X?=
 =?us-ascii?Q?z1fnhSYXpv4Ieth9O5dNx4K7130nPUWZJAzEdR22hgbN8fiTXP7EVyMTDHMS?=
 =?us-ascii?Q?Ea5abxZ5xnf0eoIyouAYMm9Hoxs2zCHC3IrQCOxzKiIBQ4G6z5p9VOncT19v?=
 =?us-ascii?Q?Uz3i1PJAvgoF8AAEqWiFunOrWuL6GGdVBmWN3iJUIhDKlWoW3p5tpC/Zq67/?=
 =?us-ascii?Q?nvO740qq4mAfmg3rOFlTn5Kj3xwYwTbrLcpOAxWXpE0P6bbJgSXYK7e1ldd8?=
 =?us-ascii?Q?k4eNYeTG69+Oh/gNmEw94Lp2Ct2DZNUbBbcX1K4htVTjgkXmI+LPVGcQgK5h?=
 =?us-ascii?Q?6Z9LbiR8XC6aWykmUVnUdj2EV8Bl2feeCCHJFHeLiFWfgEQ+AqLhEXwC7jEs?=
 =?us-ascii?Q?CJnMQpZgQztoJ+sxVcNzaU/ELleuYs++ubq1L28Vz8ZzTAYgSf9jilDLlMnQ?=
 =?us-ascii?Q?v0fceK77hTBzOp/86+FO/el8W/8Bm3IKrho7v2+tNyBoKg/6EC5fVPKYAYUw?=
 =?us-ascii?Q?+GAOYXI6nPu6dzwZ8cMP7+pCJSHsrK2Dk2KMvRrhdbnOT7A09Qp3RS/QBb7L?=
 =?us-ascii?Q?ck7+IvyCbYjjc6g4flFrPXJPQkdPJ6iafS3vLeK1b4WDoIB7YAqBemJtK9Z9?=
 =?us-ascii?Q?p5nsVPVvZamp5Z586RhrvycHedcxHsGYNja1NK7fkoBh8hovPJSIl7D9d/uB?=
 =?us-ascii?Q?nKHt7nOQChAWYjj4/nGKQZ9mcg7M1HrSe/5jA/vkfQjRSHeD2ZBF92cJi4ts?=
 =?us-ascii?Q?3GVzU1ehENS2QqyiEj65ax4HM+gGfRfOsFvjvbyumsJ2xjCfRHe1i7j9gMMY?=
 =?us-ascii?Q?2c5TUifz9z0A7zlrCgLSBzOTrm7c9SEsyxXF/dis124grdNI+1UiP5vb5T+9?=
 =?us-ascii?Q?K+ICYYPOg0XX3ufiLlD4NJZ0/Rmg+Nh3Ank+w7AV8kiv0OeYNVjnRQQNdOUY?=
X-MS-Exchange-AntiSpam-MessageData-1: cVqQLYlbm9+Yiw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea18f175-9631-4fb2-543e-08decb5f8073
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 04:26:57.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtsEqPvKwu3Sexa3p7Ezduhy4QX5B2WSihgDGbfsHI3txbPXqdkAZAt2zbnLQSkKuO1IKwpX1fDwrL7jh2V/w66zTu7cS9B0Ypx4TOv6427N+yeiYDHsRcFjvYnQBadvl9TXvT83N8lkBi6iPymdrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E3B068BE37

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The XGMAC_L4_ADDR register holds both source and destination port
match values. The current implementation overwrites the entire register
when configuring either port, so setting one silently erases the other.

Fix this by reading the register first, then masking and updating only
the relevant field before writing back.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..52054f31376d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1370,36 +1370,40 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 		value &= ~XGMAC_L4PEN0;
 	}
 
-	value &= ~(XGMAC_L4SPM0 | XGMAC_L4SPIM0);
-	value &= ~(XGMAC_L4DPM0 | XGMAC_L4DPIM0);
 	if (sa) {
 		value |= XGMAC_L4SPM0;
 		if (inv)
 			value |= XGMAC_L4SPIM0;
+		else
+			value &= ~XGMAC_L4SPIM0;
 	} else {
 		value |= XGMAC_L4DPM0;
 		if (inv)
 			value |= XGMAC_L4DPIM0;
+		else
+			value &= ~XGMAC_L4DPIM0;
 	}
 
 	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, value);
 	if (ret)
 		return ret;
 
-	if (sa) {
-		value = FIELD_PREP(XGMAC_L4SP0, match);
+	ret = dwxgmac2_filter_read(hw, filter_no, XGMAC_L4_ADDR, &value);
+	if (ret)
+		return ret;
 
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+	if (sa) {
+		value &= ~XGMAC_L4SP0;
+		value |= FIELD_PREP(XGMAC_L4SP0, match);
 	} else {
-		value = FIELD_PREP(XGMAC_L4DP0, match);
-
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+		value &= ~XGMAC_L4DP0;
+		value |= FIELD_PREP(XGMAC_L4DP0, match);
 	}
 
+	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
+	if (ret)
+		return ret;
+
 	if (!en)
 		return dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, 0);
 
-- 
2.43.7


