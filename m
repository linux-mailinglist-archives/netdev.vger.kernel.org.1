Return-Path: <netdev+bounces-252605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKHxB/3bcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:25:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B820D6F969
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 200F43015079
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E4F3816F5;
	Fri, 23 Jan 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FyG/V52J"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2537F737;
	Fri, 23 Jan 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134999; cv=fail; b=r6QPIlas+y3ld5dVAiLtCmk4n8zkEvIw5NiA0vw+/LUjm3tc8OqysvMk8d5YK0/hp1B9iSpKXkg97ijym6wbY1QYJ2tBNdSNXWSEaff9llcb9R32RX9e1L8T7t2bwWfbghiFTkQ03SZ1aDtoin4GvI8jPg/IFJrphtqH+ZA0270=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134999; c=relaxed/simple;
	bh=83F6hpKD5emlga6Emz+3NyhKrKFPOtauPNrkpiQGNSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ye6G1VYCTquGTRE8hCXLs0hrnLpSDfbFOTbS7zyLPyct5YrtrNIcUX7x4c1pmfDro1bhAqsdVqVdq3822uTlV6PJrpX+9JLpRrDgkeDfUPcuxibB1GuO0FJXvBW35uB9QMbCT6xUW0ZgT2TByyNNvgVvgbM32ZpoA6EUqxDqk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FyG/V52J; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyWHWfbKdh2pm9XYSQtI1xNyGUiCjoOPOnYgytJC/B4iwTewVaiqpg6b+/WO2sfiCFI84wSoXP/5lfqu+SLYs/R0urRlUCqNCJ/7b2lXrvQ7MuxhV2ouLxTTVMx3h5496ViVii3DmuK7mkzd+OT+W64HFEKkpqy55DiQJyVbmHdYcTgaOQMacDRw/fBmMf+DdAsfaKTkF2iuOL5olmEHPYDL+8xPBBh4Yr8sag7gAABtc1Ezlp/dnnlRy6B93zs1g2v4TYekYecOxP/mnD8ZMdonue6qNOvEFC8S4wYSpn5mO2TVnf2p6ByGBhWJ9oRPe44ylPToR5nfLJpxRuQOxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwIpD6yQVr1QMgKZfsUUT0iB2WzL9g0OWjJfphdF13Q=;
 b=h94tnLw9tW0tH/K6rydcCFqr6h6u87v6Dd/98u0Ot7yzo61tkNoS9rTEW8cODHgTOdKa4VL7Tdmd3qkfuzU6xvsuNPNlTPLzBB2MCBxkTEiMAYU+Q/5gZpK+70TygiGjxImi3XUema2KijXKtjov8qHYu20tDY48G9cBC9sqB0CLDQwgEPQ/oU0YeWTMjocmehntmTYhdb6j6TmSGJcbiXe+nFQhMqs4hPs4+84zp2lzC7ULpEvY1lFkdudmK0QyYQD33cfEFe5C7kJDXPEh8mHF+95dpRZoOl6Kb9X979U9eiIywqhd36RqMTdVnfg2kl7olpwKbGaEmWLAVxilow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwIpD6yQVr1QMgKZfsUUT0iB2WzL9g0OWjJfphdF13Q=;
 b=FyG/V52JhDRHiHkjnrQgZLksTbxKodNR/7AfoHLNKeeaXQQMSQ/08x1tAcpakQuGAEEjU/Vz+QbVxFsP8cuBHeEuBerxQCzI+nadp2Axdei/Jus+nghB3a+SpUWaZsuLk6MZZR/Ex5qkLrw7JoA+zgrshXSb62Jjq2/PN8M7/ESxjXNOylIqTclyUZKJWHGRKusPW+5YfxOnXzFuBm3BokToeTx/XGnb0fII9R2S8JhQm8PKxIXrv+jIHuDfumEK9/AYobQrVCnJ85ta+Ud8DGYrOkHJL89Ai0tIs49OY9nu9pjqZbNhwMj6qjuxxBGQQ+FApMIx76AVVm8D4GNk1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
Date: Fri, 23 Jan 2026 10:21:35 +0800
Message-Id: <20260123022143.4121797-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfabe71-79f1-41de-a2de-08de5a2645ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?htZtdj2aZ87Q8mLXpHaoJWV5TwGRIqqX6o6Rm3VjRFcwFFPNVIdXQxO86SzZ?=
 =?us-ascii?Q?EtVongunJP9yvAGWnN4nljvkQ9aSNACvZs6XkfMArVajSstamKOmJ6X871tu?=
 =?us-ascii?Q?dw8SesqaTJozBTzJmljoSsiGvyIzxtyBBRgwOTRIyShMyH78OuXFiSrZ02iv?=
 =?us-ascii?Q?CqgrbT1tg7OVijL7P1CrVixr3xM+nRLfpIokg99ue6xnw3JCtzkqgEcYpF9m?=
 =?us-ascii?Q?v8fzMg9LvsBgoprph+jR57rK9sotPUGqizC1JvRMSePmefkopY/u80iGI/4d?=
 =?us-ascii?Q?GKUol4KAGCHIMsBUarIigWnl9cdSjQbYHiT19D1zdpfZ97V7kszq+a6KiD6X?=
 =?us-ascii?Q?Hbhvk1SJiaI0qTHvHvqZdoLqSfaoZbmiUvz3oPwoCZogzm08ZK2IFtOktNlB?=
 =?us-ascii?Q?rzIj+MksLjhHaA1yFyKMJh9Zf5PqazSUK5bGoOHq87IJMqTYzbF6MRTgxG/0?=
 =?us-ascii?Q?/lPfNqLrJad0VyC+VbTSpEHHFg631v3e0ywTht1CWC0lgYMGlRQ6F3exikYI?=
 =?us-ascii?Q?5sTp+MQ7XIhRbLB894ZYkeDbk/7zLIpMBFccEEeGvi5MdC44yprDc+LVGVHl?=
 =?us-ascii?Q?/cHUQDpLj8kGFMv2CEZC8p6hP1V54enpHxGLcMzYE/SR83jNHsNKubNMeRGb?=
 =?us-ascii?Q?toMcSmIGfPMCmToD+9UnO0rPDhrNyPvLUK684R9lnBgggmtQXjqdr4lidjet?=
 =?us-ascii?Q?O1mrE5R8hSbFHK2mblOFqaWgCDFpbmw3H764QMVIYV4kR83uFYurZBsEoJ62?=
 =?us-ascii?Q?8aJnXcTIa3UBTexRZ1b84ap2wdbq1CeaBqwZ3UjqkzF2NMuOxqxv0z0D7KgN?=
 =?us-ascii?Q?t/YjJZmVBYuPxqI09hLQHme7NGBQrf1WNMgxzVhn5NkuogHGnokGO2RwOe2F?=
 =?us-ascii?Q?F1zPwniDWA9eSwJBo7tkYxvXLYBd8VXZoAIlkHVBNtiZp9jc43bVHnSozSHY?=
 =?us-ascii?Q?/RjYxgmtEEcD6wMu8U4awbHQM35SQXKlST09+VMC5x23fPhkbwVBUNpQm6Jf?=
 =?us-ascii?Q?e/x+gygjra0fpL/qqMZEZLK8YjZcFmCDaoEzkpWYI69lLTOrJyFNapMKRLBG?=
 =?us-ascii?Q?NOv7PX3kB3lRDX8OHp2eFgTXKicKMOpnrGcwMfaNNlr0CBmDILJFgpHba+aA?=
 =?us-ascii?Q?5suwouT10q0Uh9k0I3gJYpb2DxY3U8/loLpz6YYFozgxvbnyaNi+6gfthMHN?=
 =?us-ascii?Q?pnNVAmmdAWw9dpa6bpKbJr2f/6rWyQJGY6M7VqzinaLJY4272r6diGQN3Vj1?=
 =?us-ascii?Q?IShDGENJ3qx8NhVEcuNqJlpN5cSgpHilVua4ExtRLe/bQM4ypJQLu3FSESkP?=
 =?us-ascii?Q?+obwC0r7MKtqLI5VMi3jfHo+rV7HV0pjuMHO0OojFtXQIc6dZPcQk5e5HceS?=
 =?us-ascii?Q?5Oys1kZzwn8V6O/60xm0H7cwntOAI0uj+I6EgRWlHQbHfdbdaasraWp/xB6O?=
 =?us-ascii?Q?RwF3Oz5NHsmkEpnaZOCPC25dySRd2B1TcbzQISD12P43Oo0Xiqazh83o0ogW?=
 =?us-ascii?Q?njf3xW2T9s2ojB1r1YKrA9xofaxUn0/XzgPGJsGRRO/NJzZ1oG7pwxoCm4IT?=
 =?us-ascii?Q?RVNF7iDQYBeLeU2y4HKOuOmga0bQWRnogHvC7AQSVb30xHhYvb+K+ssuVtN5?=
 =?us-ascii?Q?EGOtFT/Ig8mdVksH+p43R5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k78tLGf4MIjb2NN+QpmKOuKWQQOe5aRFI0lDt4ZVKQKEx46+VWG1rseeDUu6?=
 =?us-ascii?Q?NQy781NFoLLBXRuEmr5jwgldZe/taJBz+ZOJHICNDau1DYFvgwnEBsbcJhcd?=
 =?us-ascii?Q?8CdEdPXJtMMVTpX7uxscfUhQl2KGyhrkm6zsbGQnCNPgRVbkZrUzXo7OFsNN?=
 =?us-ascii?Q?lxhGcGG/8L6dg19YRQ+b0oHe2hebGNQ2fqrhesYVfx+9Ec+nA1cwZd947BoM?=
 =?us-ascii?Q?c6CT1PX7R6moAQ6RBG/iC93eKckuqpL2oqSL+zlon/F7rvUmYaJdIVULysUo?=
 =?us-ascii?Q?5d/DzGEmtwyf7I//sFxB9LsHNSzEEPu/Ns357ED/j6M5kvL4P0zXt+nxO4s8?=
 =?us-ascii?Q?yV71imJkGbF8KZG3UStUG+Ihb8Gna+Yud2l/wsGBZPwbX0THAojlRQ3l7nnZ?=
 =?us-ascii?Q?pTcP6RXWd71nvqGRieTQpWOtSb5MGP0B9ZIpMGKkhx0/Fqn6dRfcdHjuHizg?=
 =?us-ascii?Q?pjsmy3rFAnewfL4uA485O+QrK66TgXWvMT4iCu5NZtGbAodgABNwn+Fnz1w+?=
 =?us-ascii?Q?CF0qKUhb/kSRqeT/ZCsD3NZyqZQHEQm30LMf0/eQ5l7OpSbi9lDpKq4SNTbZ?=
 =?us-ascii?Q?ZcGSVdWwtxJI1um4+sq8LxbqwWGD+/5ZotH5hRmGj+LLoR+opFNDCV6E3Beu?=
 =?us-ascii?Q?IPudH1MmzlOaXyNTCmZGDVZJJChoNS62CCbRbcDB4q4louQhdWjZ+L0NFiYk?=
 =?us-ascii?Q?avHbKvoQgGBIH7++La9+9phQpfimBobC5498ZieOCcwm8Sqk19hUAXq5ts/9?=
 =?us-ascii?Q?1KS05WCOTbKk2w7kdR2R5758G/uQOnnBgogO65e82Iie+32grM27KNCwftPH?=
 =?us-ascii?Q?2dpbIOWA1q1AXH27xn//04N3wjB2Odwv3GDHaNQbH/wH5KiJw3R6ufrgLql7?=
 =?us-ascii?Q?ig0aIqQAemCHr1zOudrKrzjZDdmDOXLe/aDTsvaYD2Pf1LWoJTL+a7NwY2v/?=
 =?us-ascii?Q?K71tpOjRiMu2uV/WgCQaJj74by5wC7TsXqjAQ09zJ4uFcrQyAAiiI4vxbBbH?=
 =?us-ascii?Q?hpP7BYWE0c1QnCT/+Z/iJVjYTZnL2h1WUTt5XyX++KGfv39XjUr8psQyKtas?=
 =?us-ascii?Q?tfnxb4FksKvYpodC/NIu5rciah1A1rQF4lScPHDVYkV3CcUZQhN5yNBPwns3?=
 =?us-ascii?Q?iOWeYwJUaleaAYNujopTdIoEaBoor+BBwGH5enYtjmLQfgw9a5MqU06dt2nB?=
 =?us-ascii?Q?EsJbWcP+nFnz1mT34saz7a7w+Q08voLl6U14xuVONonWTikzA2Gs+o+dBVR0?=
 =?us-ascii?Q?2tidLqSQqFcog/2DMGigcfYKPkggyK8PQxKez/4yD2biyvNp5Me2aWk1wRhD?=
 =?us-ascii?Q?+tSHvOz+PjlRnT2Db1J5c3tgId6xSa9Z5jOmNhnzTM/00zUdzjzhzoFV+mq+?=
 =?us-ascii?Q?OinkHcM9BQqKrOh748Y3MR4N5c/BH0Kdlzlc+/6ePtU1Si6gxjn5Su6UJBeh?=
 =?us-ascii?Q?eRkE4znYvzqvteYRem8Dyq4Gh5ECAijkHhktgIHJKJIXyOLscDC5RbKLj6+8?=
 =?us-ascii?Q?HTMiRZn4C6JXf7Gq9X7Wtl3XnfqE8RhDv3TxObSD5I+9MP8OfkupdijV6qHE?=
 =?us-ascii?Q?H2BBfIbtwfF66qOcJRd24Kts+cwgbLjJh2ju7l2a+5gRXKO0woncdzhA6vF3?=
 =?us-ascii?Q?F3/UBnyudgWFx7YfeEdP76ZBDUMEHbhESGT3JYyWEsdtRwxLJiOLL51+JaP6?=
 =?us-ascii?Q?eG3BXA87INFuuHY3gEYykWBI4mC09ccfXYkZkf2OASpAkycd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfabe71-79f1-41de-a2de-08de5a2645ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:35.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L29L1GY9HdlSYZY7qTRKuu04whuPhRJ+HSwFPEIMo37XOMUVnqI0n33BEMip9VoL8AFaM2hsWU4u1/XcjO7KHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252605-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: B820D6F969
X-Rspamd-Action: no action

Remove fec_enet_xdp_get_tx_queue() from fec_enet_xdp_tx_xmit() and add
the tx_qid parameter to it. Then, calculate the TX queue ID for XDP_TX
frames in fec_enet_rx_queue_xdp(). This way, the TX queue ID only needs
to be calculated once for XDP_TX frames during each NAPI polling. And
since the number of RX queues and TX queues in FEC is generally equal,
the RX queue ID can be directly used as the TX queue ID. In exceptional
cases, fec_enet_xdp_get_tx_queue() is used to calculate the TX queue ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 86447a7cb963..b60c736da027 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -79,7 +79,7 @@ static void set_multicast_list(struct net_device *ndev);
 static void fec_enet_itr_coal_set(struct net_device *ndev);
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len);
+				u32 dma_sync_len, int queue);
 
 #define DRIVER_NAME	"fec"
 
@@ -1889,6 +1889,15 @@ static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
 	page_pool_put_page(rxq->page_pool, page, sync, true);
 }
 
+static int
+fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
+{
+	if (unlikely(index < 0))
+		return 0;
+
+	return (index % fep->num_tx_queues);
+}
+
 static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				 int budget, struct bpf_prog *prog)
 {
@@ -1902,6 +1911,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	struct sk_buff *skb;
 	u16 status, pkt_len;
 	struct xdp_buff xdp;
+	int tx_qid = queue;
 	struct page *page;
 	u32 xdp_res = 0;
 	dma_addr_t dma;
@@ -1916,6 +1926,9 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	flush_cache_all();
 #endif
 
+	if (unlikely(tx_qid >= fep->num_tx_queues))
+		tx_qid = fec_enet_xdp_get_tx_queue(fep, cpu);
+
 	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
@@ -1988,7 +2001,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 			break;
 		case XDP_TX:
 			rxq->stats[RX_XDP_TX]++;
-			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync, tx_qid);
 			if (unlikely(err)) {
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
@@ -3938,15 +3951,6 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
-static int
-fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
-{
-	if (unlikely(index < 0))
-		return 0;
-
-	return (index % fep->num_tx_queues);
-}
-
 static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 				   struct fec_enet_priv_tx_q *txq,
 				   void *frame, u32 dma_sync_len,
@@ -4040,15 +4044,11 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 				int cpu, struct xdp_buff *xdp,
-				u32 dma_sync_len)
+				u32 dma_sync_len, int queue)
 {
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int queue, ret;
-
-	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
-	txq = fep->tx_queue[queue];
-	nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	int ret;
 
 	__netif_tx_lock(nq, cpu);
 
-- 
2.34.1


