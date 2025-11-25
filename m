Return-Path: <netdev+bounces-241455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DEC84128
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EA3AD8E7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050C3019CB;
	Tue, 25 Nov 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UiAmNl9N"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8A2FE07B;
	Tue, 25 Nov 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060708; cv=fail; b=m7gwFqDHa7roJoqdNT69mk5pqqQphSK2Sg+t62zyG0uxkBzEIyHeypJDV92st++rtOdkfL/HVrSx27sMIYIqo2GK64rAC9ECfSLbYX28vuUdq5O/sKqteNKogSbrxLDcURCCMhCgKEpmgSiglde3xGKDoi3AkB0KTb7axrF5RgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060708; c=relaxed/simple;
	bh=QQOha/aQTknARcVI+Gvouf3TC+Y6/Fa7tvJTaRugD/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnF2LCer0JhkQ5aF6CduBKiDFB1Raoxq4hpxl6rx5XKGzITwA44IICB+eJGTBwBIZfjgyTcj8pnMKbDUuihi+p9ooNkpUcrnhux8xE4wtBQsPcnbxJt1Us68nPS8eJERSGxeKNuCaNgTkSV+9HtlhLMvEItws4tnWWw9OyWotNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UiAmNl9N; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVT118OhNjpeQq0/hJtH3MLuuGL4AFqFVIwOAvahZ35LjOgBmgCPhsPBRQEk8Rw3eHbjbg71VnEZdjqsNrP3SJqq1je201Io0yseFk3m7PHESV8yMkS+OEZ2U01d5Ps44aVE+p/PHNi9zIZAwlyecJClYj1llqBiOsD3bKAozbE60DZZYoneClT9keyqjq/2LHW2yRE4oSFz6O5/6hyyg6xGxg4Ljy1xAPrwv6Oi+zBabW+AvGqML4e0pr2D5L5TwBMEk4Ct3BAG1T0vcpaD55IkWOUZbd2Kd2WSsZTH4ggSGlbaKEAoXort4qJKuChvptGmqoMeVtPMSoU0pQujxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kO7+N1xJLCXr13CVv/lykZOp+Cq8ucb51KPG4K7CvM=;
 b=qtGRbrhsCxLJr5I0db1XH4VpWeVCD3uacKEkREbuQV5Z/nI1n/eFyxFAKdYQFbJdGx4LOIXW8KxdjrzspwQ+5VhrI76C+BCMfPg3tJuwgt1ZvOyFTHoJtxTs1oGvrETAXrgX06i3zeS4L/lW6Khqwud4BIc5TS6PgRnPJwvn3gSUw5CHCbdY1W0xuLmqYn4tpYjBxtrvU+1a119CbMQTL6hDztZB9wh/BtTp9ar05BYYr+AiHn4XFu7qaTlA+xbl8WJlqGqMnhIx14H30/P86lFEf9AWxAZRtyIlw5WaPgDXkHSfMKR4ggKOHdeCO/HWP8elPbq6acI93QNpy9eTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kO7+N1xJLCXr13CVv/lykZOp+Cq8ucb51KPG4K7CvM=;
 b=UiAmNl9N5WxwkcAAb6CIbd/kfXxDqEzurFv+P89kvhV3vNxSzLrXbrgiF7yn4EFs1B1lfHafEDVDEuePxMYlNRX4WTtxn0wDAvYzL72q6Dhw9wUDCZ8sPNdvR7xBreebuJAnMk8ulF+OcGnkFmq67of1XW8+5Eo093G57VIm6MuD7hFXfEPtrLPhxu/oswASwEhZ6396WwJi/6UCc8ton9HaWc4bVH+ng8oWacR1yqYg7cbwIdBttjnJbwI1d5AxI6ri/87wN86y5ahVva/ktnyTkFGrLKqwgaz6q6TCSw1E0V9csU2dTASbfPw04KLCf3Z6/C7pwugi2DYLzH4wgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:51:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:51:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/4] net: fec: do not register PPS event for PEROUT
Date: Tue, 25 Nov 2025 16:52:10 +0800
Message-Id: <20251125085210.1094306-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125085210.1094306-1-wei.fang@nxp.com>
References: <20251125085210.1094306-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fe0183-8308-441e-5954-08de2bffdb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeuwJaKWDzWrwE8soT8zXVq+iYcxWTBwenzd4GzBnpM30MVVqrmbodXkVc1H?=
 =?us-ascii?Q?wpZR321qMGkecouZaMZbpFTyLOlkdDy2TmWBIWBHYzciOdMkOZrRRjk7RE63?=
 =?us-ascii?Q?Y/cWcNw5KzXdHKuDxnBfosy0cfyMKLB3eg+isUvfQdi6Ttbhk1oW/j4JuBUf?=
 =?us-ascii?Q?X5tZxJIjqCdlDqqmKjaYVUPlooOejLHriIlIjUJS/uNV8ObbnM9oLa2a2lf8?=
 =?us-ascii?Q?vWjfIkvdMSPOxKuIrq+a2uCtLG9r+e1GFQKwkUCrcVIJPtnDBdWfUEUqTiwQ?=
 =?us-ascii?Q?btrukBw7IP3vKYY2CQ5wHvGec94iC+QPKMCmFNR9M1qVHymWoBhiYCe2whZU?=
 =?us-ascii?Q?2UIql74vaKg9ITDYhXDSaMMgW0JkQQFPmVLST5qCK88l+twsUqj0Kgh/rsa5?=
 =?us-ascii?Q?KRt/TZ1fj4MCYt8cmcRQpvJptPQhHEwHbVq2mPEaOi14UTdaA3EJlg2Cjg/m?=
 =?us-ascii?Q?WmI2wT3tZnABszolAhnuBygoyo/sRoQKxHGYQfmoarGUZ8BczEZkNqu+2aoQ?=
 =?us-ascii?Q?4CZEWUZaD/XU2e4C0j784l6xkKBHy6/ehVvQ6Vxc1YAi3+vT8VyHxoMAEHfn?=
 =?us-ascii?Q?YD6OEjYaDMXJcYCfT60VPuTv13GsI8iZ45K1eIpBVDzHP4dWQvcVcKXmg6FB?=
 =?us-ascii?Q?aVI6AIAuEbmcpugVaFUlB5EpGQPUD6Tfz/kEz3BV33+nCJAH44kzQiCMn/Qy?=
 =?us-ascii?Q?OX78otV0Sh1Pey7X4WiyVOHdfc/KCV0FEdaru6az4u7p5bvtLLKfApg80bFg?=
 =?us-ascii?Q?dYW49jLj0NBxVqxFfU70YMwdHYAdsWPEEPAN6r2n63UbZ2P2kgUc2gVsjZcl?=
 =?us-ascii?Q?ZILclgNa0Br8LvcYnlO3LQ0DGfuj6kzG0KCIAH6BzAWZCxsYiFdWBRImTkGb?=
 =?us-ascii?Q?f6qObsnHa+r/JABpBQKuddgsVq8IVckuZCEykRCEJJqCKA9D0jurReBhSm9t?=
 =?us-ascii?Q?oiz7p708G3lsJYPNIsRpix8XuTPAcg3YUdBUVJED9u2eIQ9dEJNJAg5e9D+z?=
 =?us-ascii?Q?OwRf9Go3ewGSc53eNDt8ReKaqeUGA+ynybOxApXHdYu1Ne1LT3ZJK50S8mUy?=
 =?us-ascii?Q?xcfRUX++2OOgakM1ClXzYRFPhP8T6mt53MOTt4lYHqZ1IsQMB818S6APAvlA?=
 =?us-ascii?Q?XZxfQW4IQIqRt2nkur39gcxAgY2d4Ce0CiamFlWbuHGLsYV3ETqQqsa9qShZ?=
 =?us-ascii?Q?XSs/s5fU85F8tibQF3pyPzfUyvp6F0fc8doOvzi7n0fmlXx2TVjN0w4DcmJC?=
 =?us-ascii?Q?s4ryZ16BnGVI+K8E/o8HZXW/efiZZJjuhCMbTt17yp6MIbTlxPL7GSw0i9Rg?=
 =?us-ascii?Q?I/h+e/2j6+D3yKll4SMzXS+15qBVVJdsVtShwTRNTpJq0VRKruEmwvyXTokk?=
 =?us-ascii?Q?RSwnDvl8IXw4gEpUslJBECGlmW77EC9v0bZJve8tihMPwv8U8cmGntbNEEZo?=
 =?us-ascii?Q?AWCxcgCzcNdVM/rTefca6nh4B7FXRvikyjUVwzjKIP4FgrqhBMXuUxbEn+WQ?=
 =?us-ascii?Q?u05KRslG0ThdHGXZyxqJp0TEh0rwTCnhBm8T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTUuZsViONpig5ERZjG52kpwQgVUNQfbK/Pp+dadvQYtyC/GZh42Jo2oQJ1y?=
 =?us-ascii?Q?8r2EKRwAK7hMpmpPHPSdrmhz9Aue11Xz+fPdIe3rfAaTlgeyQg6cU1iVBqTd?=
 =?us-ascii?Q?IEyGA/6tyCXy5DaCug0tMxjEHgzgZn2w5rCaDF192rG1paJs4ZKYfbZtKnk7?=
 =?us-ascii?Q?PyUmp6GzAPpjXyjJI1bAWJ6Fw6YBKdww/p2Rrb1FIPjMvi+Jn/VRSkwdkRHI?=
 =?us-ascii?Q?6wAAyslCGofBlo7iB5ZEEc7Qu+XnULUn+eLrE367lmsoz9qHW/vXfs5Az5vv?=
 =?us-ascii?Q?suhT1r2qD6+k8NfjzTMKLEJun6IIdFK/MsHDENtHhdEjtmGx0mr7y8ImODb1?=
 =?us-ascii?Q?fb4qhIRIyqTiB6GtZvpeDcjCd9Y5AILU3eSVzDqgtOp32hqWGDyte17NTy3h?=
 =?us-ascii?Q?wQ1uctzQHKoG4+IYzD8aaI4zDGX3nBE+kfjfDWwM58UQW6jA0x0OpBQtheGT?=
 =?us-ascii?Q?oJ42r+QcmLwGPxomR+blk9Fq4s1gKsYtdEmOKG+5JVF3TaHfoE4Olu//1aEd?=
 =?us-ascii?Q?5vUx/bQyPosqWZo26MUgNSyYdUNnjEZZAJcZOiX5B1ETQ3WwG7RD2eE5Gkb4?=
 =?us-ascii?Q?gglhg7BMo4Nq43bE1ePBNzQuFNd05CMUWH3ZrbjoyYI8OCuwEdaOktYSNrFn?=
 =?us-ascii?Q?SHvR/iRsnxfiZOMeeZ5TzZNjMgmg/RQD4A8v/eq22gr38EdN/YRzhLyeQpbg?=
 =?us-ascii?Q?SIDBWMojy7c0+2LnJLVXHjV3riYxZAHvPqZ2Pf6qpFWIUutzvupuUb7PX+dl?=
 =?us-ascii?Q?BRwbncgmgfOjwcfKyK1F+IU5TWsgfqSpj2ni+FVfp2f2PF7nr36G9lZfz3IS?=
 =?us-ascii?Q?Fh5r6NK8H4gf2fvQkXuXPMdB1lXxl027XgWFRvNL9eitlyYLQ/g432ikv6rU?=
 =?us-ascii?Q?86iRCBdCs8J6Zd+5fSEUOxOEQAlIX8Khn7O5YvnGd92LGZkIWzdKHq403hwX?=
 =?us-ascii?Q?h+Mcg5XUPn/TZQzWUDB4ju9joijq5m1So2heFP28dtLoDFtETrl3ZmsF9jxv?=
 =?us-ascii?Q?ptE3rmP+JjBnIBobdkeN5IrSs9NeUiQvFORNyCNDyIjiZ1OBrn3yvdXrh5e9?=
 =?us-ascii?Q?99YtFyWIQOw/46/r5sMiduoJsuiS1Es7xjKIfFlkPG1YPWyDM71QVdKHLLHe?=
 =?us-ascii?Q?r8W0YAk/PHQhy8tVX5n4WmjaEG7sqwBSwl3X16i6/YdnRZQMgfwcDtKPOkPj?=
 =?us-ascii?Q?s54+bDbJpJZOdwr4DZnE6HHuz1d+W4Ls8ESWFcJKVwBQPMRfZ+MHUupnWCRE?=
 =?us-ascii?Q?UzLF8P8jtJHi6qw8r+6JinzZpwNde35PVnl5iy7aOzW69SBtylG6BYBEQV8k?=
 =?us-ascii?Q?/IW2Fz7VJNuLiQEOcm73azt4/EjqPABcFqn/EI8wjbETDyNQ4Y6OjGavhUxg?=
 =?us-ascii?Q?CffAK08l8ZhGZVGIXdHm/BOdusp1IfvngsehMcEG7tmKSPgkulPWyHbz2uVG?=
 =?us-ascii?Q?aQHZcYWeLWohPbO/uC3EAqLDBmbflJVbSLk+/Y05IKsU+kXr0763nJKpdSJs?=
 =?us-ascii?Q?eowV36baAnhT0yyj50uUFwf3qpcyyOscS+FRo+hiZSi3pFtcjp9Qtx4gahfA?=
 =?us-ascii?Q?C2RdvnsAEykPNDYMsCSb336Iax4WQyzMT2VQv4ki?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fe0183-8308-441e-5954-08de2bffdb5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:51:43.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKRF3dzyIdkh6WYCPugJiFIDgTxE/IEdaLZXbz9DbjfHhihbUcJJe3uBcEzVrP21KVdOWc/GMag9Ju+4DOyJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

There are currently two situations that can trigger the PTP interrupt,
one is the PPS event, the other is the PEROUT event. However, the irq
handler fec_pps_interrupt() does not check the irq event type and
directly registers a PPS event into the system, but the event may be
a PEROUT event. This is incorrect because PEROUT is an output signal,
while PPS is the input of the kernel PPS system. Therefore, add a check
for the event type, if pps_enable is true, it means that the current
event is a PPS event, and then the PPS event is registered.

Fixes: 350749b909bf ("net: fec: Add support for periodic output signal of PPS")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index ed5d59abeb53..4b7bad9a485d 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -718,8 +718,11 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
 		fep->next_counter = (fep->next_counter + fep->reload_period) &
 				fep->cc.mask;
 
-		event.type = PTP_CLOCK_PPS;
-		ptp_clock_event(fep->ptp_clock, &event);
+		if (fep->pps_enable) {
+			event.type = PTP_CLOCK_PPS;
+			ptp_clock_event(fep->ptp_clock, &event);
+		}
+
 		return IRQ_HANDLED;
 	}
 
-- 
2.34.1


