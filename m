Return-Path: <netdev+bounces-95840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3EF8C39F7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 04:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551441C2048F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 02:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCE284FCC;
	Mon, 13 May 2024 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c8+m6JlF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F9200BF;
	Mon, 13 May 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715565780; cv=fail; b=ksrXfDZj1L960aNQQoRJV24ODgyZMz87y7H82vfjQt1LEe8ToT3zV3/pZmv65dhScA5DG7NxTG0/+W0RFGAEzF7pyKqorDIllx0EZRHXMxP0Sei5TCnc2tJ8FaHjMpFtS8KfH3nIcgnZ+jVuxaBcYg4q/peABQJHmyR0ullNjKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715565780; c=relaxed/simple;
	bh=mS8buf+BgiCQZkciPKSJ0NHaDiyM6AZ0laX6A90b1hI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WG4yUpSbT29kd+k3JTk9++TA7yQ9A6C4+HqDAP6UA62UNdlgp4/jC86pcMqgL0/CR5nWxCdhKM9DkTPLRFqh8Z3baBbl6orRpk43TueO1osq1S9/48VI8A4FL/ZJkjO2o5MeVEebYt2Qrr6gHzd1a8MyJyc8bQTd4z3c6fHgeqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c8+m6JlF; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGp2EOQigP1CEfk0iFqr5JpezCMll0fOpVBOwO3UgTj04jmNmAbu/nEDGbpDA9xAeRrcjqdECtCYSu0y40lRoKVyZgkurE3lr/XCflzgvmQLqDQsyvx4eMGdO4HfbADNZ3ar1ZiKF7PPMTBdf4tv14TGPFeH/NC1QKZau50FTqg4leZF23tl6hi1pSna//VhokwuHf7IqFl+lAK7LLQtas2U3FmTlH+Z8BCBTecsdKkG4kGgeEBwStVy2Jz1s0yXxcg9y+H4KHI48ASLeCylTwFgvfSPEmKyB2JxIC5tbd75FRAXt96ko8FKU/pqeudZ6tK+PMiLCkmdm7nVn3LicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg6NgPVIPBGzsKPV2QOevCcaYQsebXVAh7Loga0bQec=;
 b=B1V6wc2jdyI8p6vMLRVXvOO/n4XZ9f0KwZR0wyM+le+ksLhd3f3gvoQ4fund/Xap7tpFS3/2UBbhVNPfCBION5Oybrwnzh44j8oZ6BCWwchtXpk2ss/84tvy0aZoxPw0h0xn0GKOnWKb4lzhRhy+zQrpInYM1Xy4dqY4ByGHwDY05rYW0HVXbuIPguhKk+wSaVmgI0tXuY/ddXoVxryqqI8/QfzM8zC+8PRtFNSJwUuX4nAFX8v0a/sRuWK5ATGaL+zPnqz358I5AsV9AO9mJUV2OdS9PilqtY937XJGQsyNA+5CJWA79paldYu+C0M/fmTiEQ9c08CURqCTpWOAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg6NgPVIPBGzsKPV2QOevCcaYQsebXVAh7Loga0bQec=;
 b=c8+m6JlFIG+q4jKtbfm+tVG/TQ6S5G4Yb0jzC0KRYWco2nVh7FY2xGw+z3TidIByhm/lLH/dWBTZKDV3x92rCZ8cWVXXQaWrQIyoNJ4q+8xhQOxChtL913SS8L/q2iWdQte06grQOU7geUB2Y8EPy7/BNWt0hTBTs6oEBa53Ce8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:02:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:02:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Date: Mon, 13 May 2024 09:51:26 +0800
Message-Id: <20240513015127.961360-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c219309-f373-49e1-85d6-08dc72f0cdcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xDsz/qAsjKM9P1BapO8hAMkYbK7M3bS+8Sa6tR+PNTj+8Tduk6WLN3d6Pq5i?=
 =?us-ascii?Q?99KRKY6HaT3nqYVsLo0eO/5ZroXUBloUL/SX7K/DN5XwQwI3y3kntoindw5s?=
 =?us-ascii?Q?LORAZABzugJSJWRK2q74fPfbfUN1RY4oU+x7fF17L+N7AyUXVPn65wKZxAt0?=
 =?us-ascii?Q?i6eov6o8QltWmzeG3CWqe3lA2gvHGFXy520FlF0MMlxOuBc8sMf3riVyNCw7?=
 =?us-ascii?Q?Msey3OIuA1tddM+E52HkhPuyEIDHJey8S+xe7pr/u6VRYBWm21APuC5SqnBL?=
 =?us-ascii?Q?6l4AOFyzLx6pJohiWmPoNXeky8jzUyCRHx4rEt3uMVR/KMm9oUrnP1rUjcEh?=
 =?us-ascii?Q?y3Xf1zU8eQHCtg13p274PM0XY127nwMcDdfk5VWxBHcx44T9hcayLw1VYyxg?=
 =?us-ascii?Q?E6DUF3K7r66s2YuOE7bfrGwx007zdiCOVe9x047jcKfQl8UQ80F4ZUNZmXHB?=
 =?us-ascii?Q?/r3R3JHbCC0+TaXEon7JFqJVi8/q56UCoPEK3FgBh2sByNa1E2RmDLz9Zege?=
 =?us-ascii?Q?kJYma6W+C1mLMVTUIY1RDMULHDYEBk/i0uzBV31BpsbuSh1tesTbDOyTgn+5?=
 =?us-ascii?Q?3KGyhH1q+ZwBxt0NQQnpkroqqw8XQDr3StDQkQEe4VIODCM8aJnfVCSEvsst?=
 =?us-ascii?Q?Z1itFjfKWiM//OV+Cx4kO9n7hFv3BUjxuZ9uECpAoh376TQd/G+Ke6AlIjoV?=
 =?us-ascii?Q?5tT7jyRFlIpH0PekOQu7UXpHSPay7bpn94GQgRoASdGB6uCOXB4mENaifSA0?=
 =?us-ascii?Q?+RQaHxs0HDlHNDTqyrMpitpLAy+yrzaFe3Vk2jtSq6a95XmFjex7sWXZ0PMB?=
 =?us-ascii?Q?rBVkMLt8fhNufKbvRV33im6RiKseUWcGVlPAqpBvhdHwFP3YGOhuAhV8j3Nc?=
 =?us-ascii?Q?Wm4p4nQ2SVVbW7gJQfJdKsus0COw5zLlNd6WQYFIOKqxDnlmKzXXNhNeiZAv?=
 =?us-ascii?Q?Gd8qiMvg/sKbiLxg+fg075UDK/EMuLG7dWoXL3EEm6Umc7y9FXqhGbsMqidx?=
 =?us-ascii?Q?mJHZDnE1OvYcoU+1oH2O9F8GzmcA1bG82D5oMqJtw6zWddfNGntMAcO8y8ID?=
 =?us-ascii?Q?qQuMbceWuctb4PxUQHOXhYfyJT/RLurIdt0saI5S4FnBD9RGxjyem4CqEqHY?=
 =?us-ascii?Q?zoBabRbhCjl20wCy8YoCDDHGziKuy/qscK4Gh+c8NBnCUsonHGSewoefCwRb?=
 =?us-ascii?Q?BOSbJzH0oy0qSD/rqYqi3tw5mdy11bPtP4FeogBDPQ8aAhL1AAgUpogy3LLQ?=
 =?us-ascii?Q?L4cFHQj/IbnwPf2aUdN17jx1vmDIBAJuIJypXB8QNQAkktBto3xNy39xgGEj?=
 =?us-ascii?Q?HtM4WGeIO+HCUK3ty2Ck4I8ptPr/TNMOH4y/b5I/3+q1Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z7OXDaBpZURMe472MsXjanxiiGi6FSYfSxAUsswDAw+iD80QwI3Hkmtud9Pj?=
 =?us-ascii?Q?5pAwaZwWe1QRLcT0eUHbF/AJ2omEYGOvNzgGE1FmuMC3wLl39fN93MHjnaS9?=
 =?us-ascii?Q?P7tvET8qgkIL4ZATzZfLQQZto8L+O5HYLzhLoaOdqSkkmAjsPws4z1cK79AU?=
 =?us-ascii?Q?FvQX8BslAHRuN1lbYRwN24XAgh3UaF3HepEMSGSSIuTT9u2SsGOvbl943f6W?=
 =?us-ascii?Q?lUGM2XQWHfosGhbqbKIScJ5qwvCiPuDWTBEqErMAEcHqa/1/SjyOJF0xxwXi?=
 =?us-ascii?Q?8oulkKGme9lVpHWCxEvW83RiGoa+c8j4zWjhwRccivqGqpBGc/ySkfFGcm6b?=
 =?us-ascii?Q?mF/XS2D8/bTm/zCCTdtuFw3CctxB320Syycquig1rygo9nA5HlWB7JCdZaIo?=
 =?us-ascii?Q?zKe8P2EUyzh76g9XGxXGhwlyH7cclWURpyNEfxZHrpblbJQu5acZPqS1Jj/8?=
 =?us-ascii?Q?ps26wM26eg+V9nAhaiCwNsAG4NZw/jj6fwo3CkX8s1wSh5rwjTljfZnIex1V?=
 =?us-ascii?Q?IqpaLlV9gpzkGsJdsgCjtbfn9pRrNkO7nVC6U9ScLM7j0F/xz+r1LpMn7VfJ?=
 =?us-ascii?Q?0rWVVxYn3mD+wwOx+UwxovXc+nMkf+I8+A3KL7NjtswyU5FPsXsu71r9LjWq?=
 =?us-ascii?Q?PjP5eukqKQH50covc6gJkP1TFi1Xde0o6fUmGGt9NxPJUf4ZM+UyxInDJsiL?=
 =?us-ascii?Q?X6jh+Y6e49pfMayFtQzCC5iGNrDJLe4ICVI5wjzjq7cx0PmEMpDPWC2okIu9?=
 =?us-ascii?Q?Eze2vDIq0xJuR/opn3cV+TJTdI+B+cmM3IZEI7IJFebuh/iKGc7SlG3WkhZU?=
 =?us-ascii?Q?gq5JqSPMyYKaPnKu52MX76tqkPqmbk6pNjlBlZ6lLPn+HFnq9/vNWtoqOW4l?=
 =?us-ascii?Q?qsdFTndUGlcgTGqAPOZRdZ0t0kyS7BENIntuxDwBCVB9AsPpiC/3SnJsgSoZ?=
 =?us-ascii?Q?xIoUna0A3HFSOYsklaNNFjcJSciXPQ1EK4aIHBgx5QEYkVEdepfHfAAPNA1c?=
 =?us-ascii?Q?dnVoysfVqveCqs5upnNBkaly4kJ7SDqEJBVHKgYDjS3m12NLVg7jN+JJVln2?=
 =?us-ascii?Q?VbKYTx2bCnZdpHLuxtQiIO2DTuZSF1nZzE7IU9/rNQGyYSGUxkSg8JEkqwxc?=
 =?us-ascii?Q?r9DSMasV+Uq1rzlyFPXdsUQuaC3g+uzVBYl9OJVcmLGjq6/kfBb+YTGK/CQt?=
 =?us-ascii?Q?UbP/9NwVFOnpornjbFnlungDmoaWYVnA319cL0Ksy1IbLK4qgfsEJRwdYlRI?=
 =?us-ascii?Q?TC4RE8jiHnwy2JOvsEUL9M68puK8oeaUOdc1o6DesTjuadEUVQUt+ZPvmmSx?=
 =?us-ascii?Q?gW1/9vWwYkpqoGHb4fkCYXP1m2KWtPEnmfWg97R3k0d4rO6EUIO5L2G3Zned?=
 =?us-ascii?Q?G1XLhY880nVwNpGlOOYT6i+l/CpjnRCRFhmkmtxdbGJhta9+n3N/+RlvOGqs?=
 =?us-ascii?Q?jgJxFPtNMChlBFHvOnXk5Xv6zkKXbOTnZCRPUEE/op615o6EVWsN2jN1UaiL?=
 =?us-ascii?Q?5podLpyEkARKi/yFbylP8sNgT4MRH4DgxeRh7x7GTxg1gqiRLSR+PhtSPIDN?=
 =?us-ascii?Q?1dQlMegCd4DINCYhG9+OArHaG3rzrnzV0vnqzcpm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c219309-f373-49e1-85d6-08dc72f0cdcb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:02:55.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34C+iKhBmeQapjTgg6UfoXfHP8H5T9SsOQALF9ikkzJJnVy87GRsUvnKlYmXmMaXA4FStkrMyaeBgwAIJalnpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400

The assignment of pps_enable is protected by tmreg_lock, but the read
operation of pps_enable is not. So the Coverity tool reports a lock
evasion warning which may cause data race to occur when running in a
multithread environment. Although this issue is almost impossible to
occur, we'd better fix it, at least it seems more logically reasonable,
and it also prevents Coverity from continuing to issue warnings.

Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..8d37274a3fb0 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -104,14 +104,16 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	struct timespec64 ts;
 	u64 ns;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
 	fep->pps_channel = DEFAULT_PPS_CHANNEL;
 	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->pps_enable == enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		return 0;
+	}
+
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
 		 */
-- 
2.34.1


