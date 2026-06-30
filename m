Return-Path: <netdev+bounces-303135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDcBNGGzQ2qyfQoAu9opvQ
	(envelope-from <netdev+bounces-303135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:15:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591A6E4114
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:15:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="TAGk+D/f";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303135-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D3331049E0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2640860D;
	Tue, 30 Jun 2026 11:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068A40757B;
	Tue, 30 Jun 2026 11:56:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820592; cv=fail; b=JsTsi4rnTkTpqrBg6+bPxU2W5yfts2CNUETl4dJId7jXyKOyhYNJukCYLb4Uq7GcmXtYVZ6Nzu0ZR8/7VmHcH4qJ8M6i72TGWP09Rk09/X9tSXrg4uf9ZZHsyXpL1BL2Kq1loGwrOgruSTNWAvHb6EWoHLaYToteTJoiB6TS0zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820592; c=relaxed/simple;
	bh=v9dxslsTPqb3WtvX0rHFQRbfj3DDkbQiXwf6feW8Nbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=esTQTalMZmjjNxUolvZ8g+U46CezXyVIUnxUIogksXAJ3qQlmoWYRxQuKGmiiWzoAUYVi+8v0UJlCPjhF46kPZNFP16xKLztmTVxLrcBnef+mIUSmAfjLuRFE33W08M38y8DdAKYiAVJJAA0BAKgLdsTKIHGYovByzIYwq4o6E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TAGk+D/f; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rklN7kztGFawkgWoy98lpnGtNR51vI3W7CRd5urdGJREWkqW8sFMFnBFH6P5cMrOhbBhCDpOfcAGFKbgW9A9khCGswCb79fHckVgUjihfKRfWbMT7ABlTkVgHdo1ddTF5PuYLinon5cwW4RIRmgfLHNZOUr5G6UfsdcN7LaK647Rvf09jzvzv9lI8XgW8N0tUQ4DZFDf6Z898OA4UlzRCJh+XEQhhKwACSKeZij4xfxH8Tkv2VxTAK3WB7T6NYEdoDNNxPvUwZp+8D7lpkFnxcnjzs7BG+9+4y22rvlh+Yg80j6rwphyzxj9PlpqiHveNSeB8RjWBWaNjx2sTfH5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=yP+oNdpX1DIySSP8ar3VqfBBwVv5XdrSbjPaIBLY3ACr2j9Sn0YhuCHGFMOLaiUwZeSOvABNA8bbv0H16W7hH+ES/WkkIcW3AD+IF9LlqPnQaJvmOMVzrvl/oSO1mkJaLqhD+wgfXVaOG5NbXyRhPhKTcYdbnPF7YHNFuBgUouDzsX95qKECoNMAWOINbWJX0h2bEKqJvmhX4bjjyygyCdolJ5cmIOqMidpegRXFiU9WJYM/6LA10mx+ICNu6mSef4CsnEctvWhEuSBGiedthSVQQFKnMqdAzNBFrHejSaI82Nuwo9cqb+2M16YCjd6PxOAzS7LxWQs/P4xmgSgPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=TAGk+D/f4DT4ilVQgUdZKCKlNHkPyCgcWSh4zsgHk9ExHY+nhLRQwB8AP7ypR7r0ygHS6z2ASKL3eTuqa/KCS7ksMIMShOFOwq/N6Sys9wkhU6CxMG6yNh4xl71+3d2XOM1TzezDcwp2wLD+GkN1rmZolUUsHGAJyctkLTr1L9ajPIuhht4DZosCb0NQ+jMsGRWF5Wg3gvCehCnCcbFnQ6AtEY352vjyrZHDYOFqp7CXQmr62kR0vUQRcU86YQsoApav4yIKYKWBMz1RERebkA1WCjNwOmQ5K1lEaRf3rwE6vmP4tqsX6NGEU3uRGKtx8ClDi4yTqHx1L9YWNy5J8A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB4919.namprd03.prod.outlook.com (2603:10b6:a03:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:56:26 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:56:26 +0000
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
Subject: [PATCH v2 3/3] net: stmmac: reset residual action in L3L4 filters on delete
Date: Tue, 30 Jun 2026 04:56:22 -0700
Message-ID: <20260630115622.9426-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BY5PR03MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0e00b4-f1eb-4436-a35d-08ded69e9d05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Nl5bN09h0QD4lFxTA9Cs/+my1+DANRi+Wg1HpXtKYIWcUs5keG5Mi9lmWBcNVYRZO7uTFDrxpBtw7aQzDkmc9VHLwE/M35aQQVT1YsAMYbNUcgIQelCuczKToSH/bWh2J1ijIt3KhQKDB9ZJZdnyXoJrem4CBBmZSt0q/V22Q0ORq8TpGoO/Bfdc/gc4LDgGLgHb8i3bCjuJBNHIfKNOxALg/4MuTxWYXOkVX6OPUdZHqiMFxRAMmTkTYOJXw++kDITiXUNX6WMpfR4MS/a3/0unvOiD88NE1lZCTc2cyetATFIq3LGfZITIBQGH2hOvBz8tRpGz1xIPOnvp/CJSj9IO9pQBwOZ7Nvw7g/4CnBxUNTeFThanVtks52oH8+CAvvLH/1DH6oPpKpKi0wLFNIxr2ML0vE96lxmQqxwycdEk75IzOxIT+KC08P6MFQWqjs6AI8AWhcHvUT22V2K7ufGKlsMuIlQvS8tIXcCFsBje7l7JJmwva57wiW60DM32X52pGvC/2Flfgm1ISONGpSGjftJ85IBJmyr1nrUCBIBLFuJ3Aq4X82w9IAjRvwwBkxD94bOaRNCdVtATJmuzB5KpJXrZRrZs5V2siB6wPF1XIUOU51wVfM23eEAnv4zuZdvmQUcOW6t3XsWuJ4ZUSpP2QgvJBQMcUXrJ/fYsREI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBUTibrsIYrNLYhsK+NUHKkz/O4VvenJrjo1f/QMOl0mV6BjJ0mUn3cgmTw9?=
 =?us-ascii?Q?qnYohMPSbMaxo7yZLCVmdnLftd9aLNiDZ/WNvQ3iJd8iIL2ISf/00bYKNDff?=
 =?us-ascii?Q?U9Xp5zshmCSRzTauoWWAMzb09Tj210Jqd6SvJjbPwaiYwsOsnYE1LaD8ivAi?=
 =?us-ascii?Q?pm0nMZZZr/ZrqHYwJct6qDh0MuYESoxIBffqmj7WT23ILE3D79PUefCbExxO?=
 =?us-ascii?Q?jKEu6zrWyS1930SUBD75lIbnqdiBY7x/JdqDSBXvsz42hww2ihisYGllDwNV?=
 =?us-ascii?Q?Hbf0jHt4SmXxiPgYltiy3TpTZJQYuifdcpplpY1hM5/r5UKi+gqbmja1mASe?=
 =?us-ascii?Q?pj5wCn0chSzFZhSR5EhmBUiPc0T8of4LvgEq2Cud7QS7pjVr/UVxCSQgboz8?=
 =?us-ascii?Q?8zNgYiI37PND3I4MQr+qJ2fIjKOKAWlIFNBtqhtQ/m1jTst0D23lY2tpxBwc?=
 =?us-ascii?Q?r22QSrunn/I6pzc+fIhYSOHe7FFLjvbDIAdyHKVC6qoXDQ62g3/dpzpAavrB?=
 =?us-ascii?Q?7u1TOvTPhLxgnwDrW5F1SfktuhNYLkOvL4nzkP4fc6rs5L1S74ZdGKgSNOJw?=
 =?us-ascii?Q?DfJ+rgvBDL4hbLq76xKr2ItXgMMcBeLbkYcRHNNOUqF7eI1rj0Pv3xM2V71E?=
 =?us-ascii?Q?sm5Maa1FFna1PG7mNdh/wieL/80zjM3VZPH/bOBL4LGKPjaIbBVHYnTCJsNL?=
 =?us-ascii?Q?ko4ya9M8zHrbrPaXHv7jcGkuiqsu/qhTXEvfJWvky6xmHC+masMGLLeqosAv?=
 =?us-ascii?Q?Hl1i008gKLrjBMADKOP897FCziUpoMzLaLjRszb2MgeIj7QmJKcESNGHRmp7?=
 =?us-ascii?Q?CAIvseWMrlG2pIOb9+5PG0/iWHZ0vgkCjbPtOHtbrS8/SYj3Db7JOUXCO//L?=
 =?us-ascii?Q?MO1hvxkG6uocvCQqRKyjT0enLxf/Ixgl2ojDem6h7+YWv0LUO0703O25m3nP?=
 =?us-ascii?Q?H1CljwrccEFanASnZAxCi4CIm4FLpvMWoYbno/t1j3qFAmFtYoMxcGdWkNXK?=
 =?us-ascii?Q?Pp7pHTvuzbB7csc7F82oYtCmNtp0d5zUijB5eeTOlR2IJNpB3nekUXNasRMQ?=
 =?us-ascii?Q?wWQLSTdieI5ycVeqeMcI3OY8ZaXWwu5sZkNlOudXLp4lQISLe2+dJOcxWYZh?=
 =?us-ascii?Q?J+5B8kdY8bHjkaxQbzhVlDH0j5qANyjSvNXBHoSdS9EQ7E/mAlyfNkkXLuQ1?=
 =?us-ascii?Q?AhepSdhwSov5xaSjpqINQdRdatJbVZRT6rt/wcXcs05U4uTZgerBunzRl5kg?=
 =?us-ascii?Q?agPIavAnX2Lp7nsxQ1YwXQfUyjOG9V9EU8ral+AgfoXlmWJXGsBZaCjcH+1G?=
 =?us-ascii?Q?uKhL52dVvTN8LmlRudEr4xC8TOSUavuuuSFleJtnkZaUTPZw8RqmTczZkI1d?=
 =?us-ascii?Q?qRTTNpws90QMD2bQZKeaicztiocCyLBPgX9F0pfJH8jMmKK6eEEMd+d9hbfg?=
 =?us-ascii?Q?9+p3O5LAXkCysQuCfrNCRhs7rZwaPapa/iftk7On86lEShnkaF6NNcRJcpHs?=
 =?us-ascii?Q?3fEtJ0Iv8WrMnVOoPgykZ89azW7ghvVzC/Uo856A9v3XjDez48v9IwP5c+qJ?=
 =?us-ascii?Q?fsYqvANiZSTuSWLcXO9tQycENZgPkaRaOIoUqCuFoJi0IIZ3qe5bfSrXUd7v?=
 =?us-ascii?Q?/REUHC3wV6h6/0jB8YNu3RvYP8wqNOokUccDznRfGvxVD5CeoPXNz1o/92FN?=
 =?us-ascii?Q?8qGOaYVd5BQOxyNE5xP3E/3BFhcPMWyquOfN3KVrKNbeMaTBKsZ26t1Ndc0b?=
 =?us-ascii?Q?PJj7EY7lMKC9Z7zDKL/fLcwUUC0w6L+5VFMHDsJ6FYxBjX+eagmcLW2PXs9R?=
X-MS-Exchange-AntiSpam-MessageData-1: pMF6TwFKvjqkcw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e00b4-f1eb-4436-a35d-08ded69e9d05
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:56:26.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jrNBFx63vdQXB7qPjH3iqGPYoA1t+v3XA4TP3HfU7hbCDePaILKYGtu5ELH5Iq37v6nNe3d09YA8V/iNwy4BCE2k5kPEzdvUeDYU0ioK3/su8d6wdVTN0ijxe7oVcc3faZypmOs8Q0JpwgGe5Zclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4919
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303135-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4591A6E4114

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When deleting an L3/L4 flower filter entry, the action field is not
reset. If a filter was previously configured with a drop action, that
action may persist and affect subsequent filter configurations
unintentionally.

Clear the action field when the filter entry is deleted.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 869f84756ca5..4f9758eeb86f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -653,6 +653,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
-- 
2.43.7


