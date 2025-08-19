Return-Path: <netdev+bounces-214952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B74B2C463
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38D4189465E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BC33EAFA;
	Tue, 19 Aug 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cyy1tzxC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A333EAF3;
	Tue, 19 Aug 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608305; cv=fail; b=BOZidZiayE4jPFVWCx57aRAlOCANcVwj7aD8fQvGOmVvOV6ZU94VZiVMw9pdJ/VMFR20MzOBCv2YEi5RohZVVXTU465VIFAingiTBhozDFIyodZp4tUtrGjRQixMeWTi4OgfdVc2NTjlP2HDH79kGxCVn0VkOdfZRXpE/+V7fFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608305; c=relaxed/simple;
	bh=DjQLMXMLlw+ua7i6m3UWbZG+RB1jkijzf2qusDoAIZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HC4qICGk0zHbrApAO8So8dvpQsqHN8c+Qn/8P/thDm76L4yXtU5Rjae0QsNl/qizmgImdfCQvUSfJeayFcctzyAAlnlxkOXDY6EU32yW4Z4cGMa9ry6GrasrcWEM3CKI3DwQB5da5paqBq1kkS0Py9hNBHN8Pixx3z9PmAUDaso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cyy1tzxC; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBZBMFQhwlIk6ssHNMreqTro69W262+aqGO2hmHYW58dTAB1xV0TwjH57AlRPqNJwJ3vcQ+38tTnOsA1Ru0kRK3QyklrRh+tRcXSKC1+ZjpgYJoudrC3Kb+Vv4J9pux9Qd0kU2A7gYm6CuBs6MhHqESIXNi0o6Y8jLI16obIeNMCg6NQ83wRwk+MW7XW8qotXiR98+QNR8I7IEj1XAaV+43BLNJTQKq0ssAZNuMyqqBtiMo+BARaD7msWtL64sK9SwTd3HeJRUOG3vmmyEtaO5FhAVpiXOHIA4pnfEZ+pLDjIVuLskoOxJLAa/veZ04sAKfpjnmGeHBKujAFdEwtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmhoIgRK4RXSRqHooNh8FsohL0dyrdvSCktbdFxVTNs=;
 b=ILhxqnoUAui5J03IWWEiAGeIzz+84DEaCm9f1zPDiM4kUiWA9H83F9v6FjbUysEIQ/HouJ4jW/eYeoHC6Tvy49n2n8BLBHGrKC8llHvTkqHxA5J+FlZ9MiZKscfuyvXlxf4CE9sunT3qnWXjzpoeir2P1IFDMq809erUnioh8lK+EfwLMrv9YfSiS0p0Dph4n5946tHhPf5n6jxgI9ppzLSJ1FgtvJTJU5w5qAoefKXidsqX42ruvtFqaUb0qKgdwRdWr3krGtyygBcsgLycUmC81EN0rpafc7q9EoH0GncU0OdhWWSUWGjfaumjKvQMoXTCTooPVxmtIjKmRURzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmhoIgRK4RXSRqHooNh8FsohL0dyrdvSCktbdFxVTNs=;
 b=Cyy1tzxCJ6ql7ZjrVddIOF6PQ3bscklXulwQliRRtUunMK34jeFDK5Lx+BC86abEFsfZfL82z3Bzi3l3jpFeqMDv9LQINGfSI6bZCQOsFwdyMTVH625ryw1xFjUBgrNHokyucjg33I68fdD0UCFicChPF1i/Z+TYevZguxOnPRUoI+r95wv8n3v4tKbnNk5NEI1T3Gz+BqifiGjFlTvHUs2TFRe5h8J6dAHXJWwfVBEW+N04KWKEpvBjWbWirTSTMm1sec+3lLw3ELw/9lfjx0r27LEGxawV8N1GuA5CqFZTWp3fAnj7YiWs98xme/ztPMSUJCqTfYZ2uRsW9o7yPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 net-next 02/15] dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
Date: Tue, 19 Aug 2025 20:36:07 +0800
Message-Id: <20250819123620.916637-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bfd719-94db-49a5-25fc-08dddf2012e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3C6O2QflnVL4ojibZTcYNOtQx39AdhAgmC5ANGP1SVTkaPP5dKDHaLWEUfd?=
 =?us-ascii?Q?cY2z4z69EbomidfizKByCqd1kAhEVhjHDsd3O/IfGhl7QV6VWI+ams4ZpDYt?=
 =?us-ascii?Q?Lkk4z7AbFrk1Ulvu9tJ8IiRZkM0hMHim+HzbqRbHrQ4Qsgft6MeHsiQ4Immm?=
 =?us-ascii?Q?kC5ewukhbJczgN/iS2MLVjXc8mViaADx1yVtw1fxwvnoME6WhUr212liPllR?=
 =?us-ascii?Q?DmSIugBL7JLIClbl18TOXENSFa3SItxFiXCDX99ivrkHZ1TAUV51NgudHwl/?=
 =?us-ascii?Q?+oJxpnt4v1fDANKtYGBrTXZslGcrsRvYCREOeLrLcfoD02f8k31YOETwrX+T?=
 =?us-ascii?Q?0k3EKu7nJH4P1y4e3VFul1GnDQNdB3qPM+q5xbS3PA5SWzlI6WwgtAo9e3Ck?=
 =?us-ascii?Q?C0GfbC0wgyTRHmjNvW9xPbe/eSzTXiv9tewoXmTt0PyqlOevNpbp7ArtkCF0?=
 =?us-ascii?Q?vU0LR4AbStdwVktzlx3TVE604aRkjTmFIMnlNxFsEDc70s2H7PZsJCw3JBjg?=
 =?us-ascii?Q?/l9c9Ez95ZVwVqS+Z1rYL0ywawoX2pQYsDvn0hTdi5k+QSp6YJW9NkQAQQld?=
 =?us-ascii?Q?6MEg01K0IdI/d2ICIvlW1mGIkH0x1JByr17dzcZtA2lQ26ePdFqUKNolTYxy?=
 =?us-ascii?Q?fsyWwaWaPDg9dRHNs11AYqtk7NKLvjGbSPxWUw1sBLqfMhArfnKrdLXeVbzi?=
 =?us-ascii?Q?W8QqVU5rFzKudVnneZ8xHbx6ZLzywghPJBziy/sLNQMRAdD2pPM19xc63Y1E?=
 =?us-ascii?Q?BIEDVNZL6/ztCRMCNwUm5Er9w3fMxUOkwiLdsSCZLMnQhc8VtQZchwUjP2qB?=
 =?us-ascii?Q?QLV0fw8qHqR3QW52LG+Ph4VEdmnEekei8mJRfp37NldsOfBJMHh4tO/C2MHr?=
 =?us-ascii?Q?dS8SN4/Z2Gi24ATIuwpSL0NqBi5vwaJ0YqNE8aaK3RMJ7Z8bJDVbw5otSa4I?=
 =?us-ascii?Q?4r5cXXSfvXCet14nj7GDuUwiVLfhKIb6srI5cmazUYw14j6Bl/iseeTCw2it?=
 =?us-ascii?Q?2ciFajUFe4svrMQmaxkIeMpkWHV2/v5/r3BtINa42vSqLnULRTa2u2eg3mXF?=
 =?us-ascii?Q?oduqtt+aLPexQslFPPxMJI0oZDzTNUpPESr77kbZf32CrjY/RDr0fvDylhbl?=
 =?us-ascii?Q?YA4yd8ZCaH36rUvdESMTKKqCqznz9fWV34+m5bJwSr5WuWfu3BgfWK0a1uCL?=
 =?us-ascii?Q?qkJ7VQyb6wPd9ePmBrrZcIu7FRgRNi1RwImZ0eTGNz2yRzhvHARFQGZlj0RP?=
 =?us-ascii?Q?0lToHHgfMyvD1VIZqH45nxdvl8teN+yZzaQnXev8R5mIWP8SaAUhzHdwBZyf?=
 =?us-ascii?Q?35T2W+NnP8Ndr7y9ynkXBPpg7B9196LybjLfZNHGwhZZ4bVYcTDGyLip6zNH?=
 =?us-ascii?Q?Z6xxYAtMkCqFGaCig6HIP+Io25u81AfyR3mBuMS1Nd7rOpjjtnzYSfdk89ZN?=
 =?us-ascii?Q?2Pvdr7hoEqh8sKivTf8L+OlvVKqYNhcX84f5DT2qqz2BTWWgcNPksR95Ceoc?=
 =?us-ascii?Q?ilLSOS0nI5MHtIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebGeGvZ9oegwZ22ML1D/yuwJVF/+0tsiq4TDittO51iIH7wPCh3Zj60st4KF?=
 =?us-ascii?Q?Gz/rcQzM6WXP/73pFbwS7RfLGnblrdgKJT3tbHg39+R5wTqam3YZPtazXJEE?=
 =?us-ascii?Q?+OIwbq7xP0VzerbbtqekH3MA7mromvXoauO2ySv7nKsbBnY6M+gX5t2xOTuu?=
 =?us-ascii?Q?Rkxr7KRp52ylTuJhy3rohNOhiA/fCL3sfEkDn2kzSZyoF2/sjYjV2t53UX3q?=
 =?us-ascii?Q?DluXkgyYI///lSmGbTmrFMHh3DVcBjR6m0SWTJ50AnB2E4fd/rbYBPJkddSj?=
 =?us-ascii?Q?HYMa7cUlP5pikQNx7lR1dycMgTG9tsefroctmgwXcw/4bClg8N1wMGfuCJ7F?=
 =?us-ascii?Q?rwto4rx25OKK+8EoUL795M1xh5A/TDqMzIDZ4LTilSwq5vkozlvVkTy/5E7d?=
 =?us-ascii?Q?jKMfLHusweQDzUM6n2GTdHKnzN98AIaPTbG+XwcBEZxPlPzRzec6Vrbt3CZY?=
 =?us-ascii?Q?bWtyZPRHrcUVTz+VS4v1etBit3VBcakOSnApElvIf7NaX35O6BeTjAG9XUZJ?=
 =?us-ascii?Q?AMv0tlJcJjtFlYZGIax3OwxNh31tfXN5owxWjSqYcFkF7OS4taxWSAnP5Mlp?=
 =?us-ascii?Q?gyXly/eChFT/ZWDZIMnfFtsvfFNNMuTIqNDluh7xy75n4AaLXv3JYmB0r6M2?=
 =?us-ascii?Q?foFBjWg3bW70gNh1WN8VBSj4gK4tPMt55KPY6QjkHfM6uGCNZL0DNxTD8m2O?=
 =?us-ascii?Q?k72wG8XKgJVabpd0UqQ0afh+UkjPTuFw93Qm3MgOk5pxS/T67n6omrbQJrpY?=
 =?us-ascii?Q?hddiFk2un3RD7gTUcrmcpbMcEugodaPYNCKLJ1CJdYhXRBUUEBXpdUxWdD5e?=
 =?us-ascii?Q?nlWDEAHlRymt1ePKZkXC1EYTVVIavyYA/XrS1PEBhzMa1wmtS5VnEQ2pxh9M?=
 =?us-ascii?Q?PBxjuNYHwJr7MAPi/1yPTwpMu2W/pZGPSPdHhd5y1M9UvNzjgO3jqg9pMBEM?=
 =?us-ascii?Q?xHUYReNMQ1CeC7/j5zNHVp8bWkpnBJKzyrFoGTQH1mNXqvXlGNCwgHw7QGvj?=
 =?us-ascii?Q?juPi/yfIrc5g4t2KHKAwsVTMKc1S98HRVZu2n23Expz1x4MRAup2t885EXQI?=
 =?us-ascii?Q?HXlqkq6/QCYy+OyVhyGC6hjaV32EgF+bENzPEOgMTDqEVxFCE+VWR8NsSoM3?=
 =?us-ascii?Q?pLoV/Qz7Xg0S/6riWddaCndodSvUtOR+InG8S01Ld9GQHr2az5s9nIreAYDC?=
 =?us-ascii?Q?hemD/mIpb6KOenaEY9Q05so0FeWUJRC87fiZw0UPkAohGHQDJ+St6Zlja/xv?=
 =?us-ascii?Q?efDdoyAoXwzsEKbzCja1KrRObuSH0A1eCbHNa+DdF2X9H34YiN/sbSV9HMEs?=
 =?us-ascii?Q?4anqkfXfu5bHdc67E0lGhr1scl5RdO7/e6D2YsglRr7eIZuAZ++8sTmVsxXO?=
 =?us-ascii?Q?1/9ty9CzZvyURZ/EsaPnjWp3Y9VSJTkBtx6oygkbyn5Ck8qS5Q4TeHWq/Usz?=
 =?us-ascii?Q?r5NEBVoh+RYp9BFMcCFy2fHHmNtqBMyCggGwlV09GC/QU3JqMk6wFpMdxgJd?=
 =?us-ascii?Q?p2OR1aIjbzY6cA5FGTtl08lEB7h+fmLh1x75SU6nISrKzoJ+k+ZxpX6JizH6?=
 =?us-ascii?Q?LoCfu4fr65GsY2X/RFEYEr10MoGDc45qhmfaHiZX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bfd719-94db-49a5-25fc-08dddf2012e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:21.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oryof65q+k9SMdu0vYgdnzGQtYznZVsWZkTaSdNnyj+PdkS12nYyEq4OGny+CMzYycrJojADTD65m3oBeX8Z2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

For some Ethernet controllers, the PTP timer function is not integrated.
Instead, the PTP timer is a separate device and provides PTP Hardware
Clock (PHC) to the Ethernet controller to use, such as NXP FMan MAC,
ENETC, etc. Therefore, a property is needed to indicate this hardware
relationship between the Ethernet controller and the PTP timer.

Since this use case is also very common, it is better to add a generic
property to ethernet-controller.yaml. According to the existing binding
docs, there are two good candidates, one is the "ptp-timer" defined in
fsl,fman-dtsec.yaml, and the other is the "ptimer-handle" defined in
fsl,fman.yaml. From the perspective of the name, the former is more
straightforward, so move the "ptp-timer" from fsl,fman-dtsec.yaml to
ethernet-controller.yaml.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3 changes:
New patch, add a generic property instead of adding a property to
fsl,enetc.yaml
v4 changes:
1. Change the title
2. Remove "ptp-timer" from fsl,fman-dtsec.yaml
---
 .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
 Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml    | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 66b1cfbbfe22..2c924d296a8f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -108,6 +108,11 @@ properties:
     $ref: "#/properties/phy-handle"
     deprecated: true
 
+  ptp-timer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specifies a reference to a node representing an IEEE 1588 PTP device.
+
   rx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index 60aaf30d68ed..ef1e30a48c91 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -81,10 +81,6 @@ properties:
       An array of two references: the first is the FMan RX port and the second
       is the TX port used by this MAC.
 
-  ptp-timer:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: A reference to the IEEE1588 timer
-
   phys:
     description: A reference to the SerDes lane(s)
     maxItems: 1
-- 
2.34.1


