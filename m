Return-Path: <netdev+bounces-136706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1A79A2B40
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244EF28821E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2531E0B64;
	Thu, 17 Oct 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="fOlz/VKw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551761E0DE5;
	Thu, 17 Oct 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186943; cv=fail; b=T5GWVdVx8qH4DNUVZipAmQPJadZh4hGeg8mUq4Kr6wfPR/bYwzYi01/FLKtuAhw/H97ZAo/MwjbTqjEch/dvKOCFrBUVHJre+LOYXMzQhJrfpzr8Mrea/7UksEzzV5wH6aH+PXYp8J1Gfed+wUHx7dPo2/hJiLQSLi5RflvJ3Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186943; c=relaxed/simple;
	bh=oagg/QKxHvgPVqHwmV1uYjqfAE2MWo1gIE8DBlOU7aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMZe3g9ObdGeTl9vN7l+HMdnkRDN/4XtDbcJROy1+Zk3iYScVCFuvXdPk6JYh5lVCOM9wFgHEk1NxxAf2EAfkHHuV8ojHu97n9BAGGNRLjmJKk19flgbyH24opBNokK79uDGWkQviQNO9kERJqlzKJY15kO7Z387ckQwa6oDwyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=fOlz/VKw; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrwjqQjS1HiwcnH5QV+quMK1N+YgvpcsLsUAMxKLisgqwJFedmQQA2L1CNdRFJSAD/YJtjpoblqbHTBs54EpWblCXPubrJJ/GEmHDyy+79gexBbXcpsWCXLjGkjBbZ/k8s+DVG/0Vf9nms/bxrX/YfEfrTpfQPykt3DYYeD7FkKksPXg4mtkFCfE3V1LK0h7vFURs8aqZEsYTby3CePmfhDGnlTkvCdUWYROFlyHXGEV218O4VjcC4CMNZQMC3sgP+2fuPL+yASeH4PDhxi9XdcnHd1+uPhTS61VirBVGMGIf3KObaXKFobkKDix/apsa2ZANOTO+1GtA7833AnD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2XYd+ef4QXPkhNAZAaNzaPV6vCmrjU3M3yiht1TQP4=;
 b=pQyMHn2X+cVH83v+clfwac7tzLX83Kf2kCUSGLbxmWtAEjkto3n/TMITiIb/+ofu9A4m1VJ8JVgkOswlM9/BsUUCq9vkyohwqYr+CulV636hZuTFw8KG3dPceHsyzUde6+brV0qr0D9f6ZHd8oX/TRDM14h+V8jbjQotujwOO9OP7dRRAT2iQoHfrAqpA5sxD4W5Mh7nVAVPewiZb3ZDSb8DfLRNdYaML6YHPZhvkpVcR36kSjpjiizDi/xzjzbuTZEygWhWt5Y6vF89aQhBCSeLxnDBdFrqTLGxdvtmI+08yvx6FzPe/izNvRh6R6GDRfgzmawLFczv07VX5RK6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2XYd+ef4QXPkhNAZAaNzaPV6vCmrjU3M3yiht1TQP4=;
 b=fOlz/VKwe11/FbbL6iSn2P21kSHI7LdgI3Di1ybufPxa7Rps1ff3L3X9VT8Ev7MCKuq4tE1ouWwgH2m1CZy5w3FYAN9pidiS3Xyqut8bO3oDqXAXj+DOUSJE3TwlqJ81nM8gKpw9CbwBGYYb6WxG+dY1ebCg8eCvrNTPzlSOl+SX2QwW9Nqe63GNleKxVcdSZruWjFosHrFanbbgq//Nlxt4Vg7S0xp3dULw53Y/w+Ip6/0wQM2UbXs6AeEvFQiaxkPBfVxG7s+9jW08wtQ7GtFC0fIGIZJsCfxztagnRHR4Q02mJuW0/N2xSz26MxygBm97XShxQ0PMpoHqJQwBUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:01 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:01 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 07/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6_mroute_setsockopt()
Date: Thu, 17 Oct 2024 19:37:49 +0200
Message-ID: <20241017174109.85717-8-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b78e508-c36c-4788-42d7-08dceed2f735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1+lTCVvyHZK0ugfchn6UWlWllz0cDTK74Rr7Gsjv0PkdXyccUR0z9snmwtA?=
 =?us-ascii?Q?xM+WARMColTa4Ot/ktG3G8p/WCGop9YAl6haqce29aBnbETJIn3c5AMzBvyn?=
 =?us-ascii?Q?2CDITNWXPi5gmfGJte/1iIob1PIoid+bHCGUrnGKBp+9OBDq2CY7804zjGW4?=
 =?us-ascii?Q?fYoe0QUi+UAq8tjurkosMoabmxEfK/ZZPJWFxjRwdV0GcszGbK7Eo5eGS4HD?=
 =?us-ascii?Q?4lIFRdINsUmNKF6c4tpnB/5doO0KQ7mRf6OJsl/iVBGxnZ1IMS4nqFlHrHDo?=
 =?us-ascii?Q?PZfTvgSdO4A4HrN2cNQ6f/c/fPv2gqpvyFgnMiUv53fKctC8Zs0flkVJt+bb?=
 =?us-ascii?Q?g/QV/otjEhbIj0JWe5urqubO19wZfeOclO8wqjJnmNsGgHe0a8htC14PTXZj?=
 =?us-ascii?Q?BKFOXdZmU5xb1mYf5e6ncYxIuToRCZpu1OZ6h+3G8zjq6QyV0lIrPa5PBRFp?=
 =?us-ascii?Q?znBWg/QVkhurUU218SLVifdnJSlivRPoBxaFaJ1YakA5KAdCRJ02tHX5a65M?=
 =?us-ascii?Q?SIFpcXLoHfPsizsPtiT6nFXW+YWlqw3fI+vWpJhh/yn0V/mI4t3WLqsP5PSu?=
 =?us-ascii?Q?AuRZKKS62HROmZuvIgLX8TR4OzSloq7tdpNiB85VGrJiBdmJ8bdSUitXhtnU?=
 =?us-ascii?Q?ywK5l6UU1Dbt9hhLZOTjzAdw6R/CM+6i72TPBlicZeDOGtp/8i7nn0/goaz4?=
 =?us-ascii?Q?3hDy8SPdJPFmgq1s/TeiRT8dTcINzE77diCw1WGsvIe4jJEVzQ7NsUAh+j2b?=
 =?us-ascii?Q?m3bEtIPFZX/7tBPCcrgdOWtXHMLQgDWOBYU3aJwelXwvEpx5MEduPxpfsZK3?=
 =?us-ascii?Q?TpOart/gO0gBuUyJ7IWCNR2yYT5J7SDG7bNuuzTJdEky0zfFypo9LRgBCI+A?=
 =?us-ascii?Q?UrpTvVq3Ww5ljofAx1jemf2X5kW0H90O8cgIedeCUMHuwJSYKB7NBwzQcUCA?=
 =?us-ascii?Q?RcLoozoA/5EIisiUTBMesdjQkHSC12XZzrBZ9qzsE+9jJ3SM5CkmN/qZW/u6?=
 =?us-ascii?Q?5hghfp6LyaN0E1HsFCY9Rqk8zWEZK740W74V1pbJg5txF1YlrOTQNvKxPzzE?=
 =?us-ascii?Q?GwgA0m8wCzdoEpMBVPrwerOcjlr0DqnEsz2JZc70hxwoz0/mb6XzB4xoNmTn?=
 =?us-ascii?Q?k3+EB5f2W0Yp25V92hcV3vQWzwqsMz6V0IRhEcLCZUDf5WS/vkQRw9WqYWp/?=
 =?us-ascii?Q?H9rUBMrgwVAS2Q/oBLpQESxwApIuY44FeKvWLClaxhF3RfUTPa++3FZtApgX?=
 =?us-ascii?Q?fB+B7+f1JlXVxwSmDWhF+ZU2gUFCWKaWArzEH8arnhn8ppS+Z2yIONeP//l+?=
 =?us-ascii?Q?ZkiprwMSfB5lEDakz4eKtrnDAIRCq85FoEzGZRwX0utk2685R2jdiXLecc+3?=
 =?us-ascii?Q?U1tJIWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tS/ZARH1LtQ8WwVnnuy9yJfEUtfrxaFKy5KJxhcN2tRhGv+bCBvYqanoT4ju?=
 =?us-ascii?Q?3Y7rt7vtb2QW5mIY2aJ9L0iPj3nTsQ6St3K0NxmpkSjs2m3tHlGHf4aPEF28?=
 =?us-ascii?Q?hmZbo4PqVpz+U3i/y3bScrZ65JZOYMbH4u8q/niXLqpjtTEyF4N30mgxHhl9?=
 =?us-ascii?Q?1yO7sAMWWM3nRmiTg4sLpY1fwM271EGLYGXcmzwixIrqiaAEar7MrV06LUOy?=
 =?us-ascii?Q?YhstMpUkb1vW8b5Wz58G9b/LH8pR42wawXzl2bGJindjVU6j2jvNEfY2mYkb?=
 =?us-ascii?Q?igK43Pc4Jd9/Mup1Fi+nXnjnaekiGizZakrNYp6IqEg1faOvQE3sZvkZ7g0j?=
 =?us-ascii?Q?C9Zzpf4fJLtoRZRgvR/CgNEVgXQmfzYugOALqI4YyexdAuDdziy6Nfa0vKnu?=
 =?us-ascii?Q?eG9Vz82hP4gEwhbBukVP12eL439oNRwsOMThUN+Rme+aQek2evk32HRLlLsJ?=
 =?us-ascii?Q?hzGLHMCQRGJ+jUNRASl+Kdun5YsQsARgx/0GYyLPggwCq15aVlpWEXuP3mPq?=
 =?us-ascii?Q?bmL+ptb322/QMfZVTJhZpTPgI5exVar6i5ACIItGeMe64YgqOUJPXIFNUGk6?=
 =?us-ascii?Q?Piv1G3+fdNcL+X4GJ3fwLvjOmV5uGXiPT1NE/RtrZEHWX5SRYCAFz5XCp8Ja?=
 =?us-ascii?Q?qn90uiERYGKdfeistLN31fa94YHxj8slEBTPx2m9gTPLGE2Cmt4hfbMqjp2n?=
 =?us-ascii?Q?tTpY7EIJkFPCy3mRUJZVYGS4j+zFgl2BC4ykDlOw0eC63uwqoaoXCv2BetZv?=
 =?us-ascii?Q?p4woMJQ9nEufe2gYIzHe7bFEYuPSrL9u/bV1Des8MtbJaph0xFNzhGDb0U2p?=
 =?us-ascii?Q?Yx0P00UxCpDXWCO0pO/e/PiHp6KO0R5HbpZbE/KO0ER94YPQ0ZpVMA8d+2xm?=
 =?us-ascii?Q?HhzZrHlwIGAwqkm7UWPOZVPJciRwT7fvF7gTzM6pHKqawVNaRSzo+9EVXauz?=
 =?us-ascii?Q?eE2UjhZ9+MHILkwV5l0H6GGyjL/gcQc0XNLhmSpQLeiK9f2zC3V5jC69+nCn?=
 =?us-ascii?Q?iEBfL/WypmUQWJkpwaEoT35/GDr41EcO8lGcKML9uxGEXZYf+qzN2T4Mjlyg?=
 =?us-ascii?Q?lHP3AcxODp3r3LlwskpnX0hWvdot5pKmM8YstwwHeRUUx5KLl2H4QhhcNH9/?=
 =?us-ascii?Q?ryVzxdcg9zHB30Tfd9PEU2K8iX/ZAGGbe+FdKWdW8WNiRFiMaeV60xahZQew?=
 =?us-ascii?Q?1FhhU9g6LAsI8dGvoLBhJD3MOh1pmPelWoKsIyA0L5sxUPI6tdPFQeOjVF1+?=
 =?us-ascii?Q?p+9sscD4wikqEtgk1/cg0LpxP3hKQtfVwNSNFIdWt3C1Jg9POp/A682Bt2Ow?=
 =?us-ascii?Q?2hSOJyMZ1Ew8BqgVgl3wIIMAGzSCWKeKFg1p/pKY/mdl6m9aTVuNHUvqBR6c?=
 =?us-ascii?Q?Jdydqa9yPpzC9j3DBenNpaeimRbwtFijpeT2AGwk64gQ0TUEjSk8M/l52E5p?=
 =?us-ascii?Q?+bK3P5HzoJhGdK5P/VfS441V7JMBjLj60ha6yKapPMloFRgF4h/dLcBQ43Da?=
 =?us-ascii?Q?VIC0Y0qELbtltSkXXmQbgPohAvrhzZwtwBMPmtuLOfW75gVzyYq8BS3FsKTD?=
 =?us-ascii?Q?nE2Mqa1LRi9mNcP46zMs+pPHdqZbU0jAJM/0seLQtKbjaeOtzwC5FrVXsjO9?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b78e508-c36c-4788-42d7-08dceed2f735
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:43.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y73rTUYzb7mln5O4ZfC54Xkt6PZ+vfUfXlyAtNlqa3/tyuS5pzNJA/21y9cuZJ/qI4+MeAyFwwbb7LapRSVl1W/JWbDgrTp2xor9xYOzfzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 165 +++++++++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 70 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 90d0f09cdd4e..4726b9e156c7 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1667,7 +1667,7 @@ EXPORT_SYMBOL(mroute6_is_socket);
 int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			  unsigned int optlen)
 {
-	int ret, parent = 0;
+	int ret, flags, v, parent = 0;
 	struct mif6ctl vif;
 	struct mf6cctl mfc;
 	mifi_t mifi;
@@ -1678,48 +1678,103 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
+	switch (optname) {
+	case MRT6_ADD_MIF:
+		if (optlen < sizeof(vif))
+			return -EINVAL;
+		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
+			return -EFAULT;
+		break;
+
+	case MRT6_DEL_MIF:
+		if (optlen < sizeof(mifi_t))
+			return -EINVAL;
+		if (copy_from_sockptr(&mifi, optval, sizeof(mifi_t)))
+			return -EFAULT;
+		break;
+
+	case MRT6_ADD_MFC:
+	case MRT6_DEL_MFC:
+	case MRT6_ADD_MFC_PROXY:
+	case MRT6_DEL_MFC_PROXY:
+		if (optlen < sizeof(mfc))
+			return -EINVAL;
+		if (copy_from_sockptr(&mfc, optval, sizeof(mfc)))
+			return -EFAULT;
+		break;
+
+	case MRT6_FLUSH:
+		if (optlen != sizeof(flags))
+			return -EINVAL;
+		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
+			return -EFAULT;
+		break;
+
+	case MRT6_ASSERT:
+#ifdef CONFIG_IPV6_PIMSM_V2
+	case MRT6_PIM:
+#endif
+#ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
+	case MRT6_TABLE:
+#endif
+		if (optlen != sizeof(v))
+			return -EINVAL;
+		if (copy_from_sockptr(&v, optval, sizeof(v)))
+			return -EFAULT;
+		break;
+	/*
+	 *	Spurious command, or MRT6_VERSION which you cannot
+	 *	set.
+	 */
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	if (optname != MRT6_INIT) {
 		if (sk != rcu_access_pointer(mrt->mroute_sk) &&
-		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
-			return -EACCES;
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+			ret = -EACCES;
+			goto out;
+		}
 	}
 
 	switch (optname) {
 	case MRT6_INIT:
-		if (optlen < sizeof(int))
-			return -EINVAL;
+		if (optlen < sizeof(int)) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		return ip6mr_sk_init(mrt, sk);
+		ret = ip6mr_sk_init(mrt, sk);
+		goto out;
 
 	case MRT6_DONE:
-		return ip6mr_sk_done(sk);
+		ret = ip6mr_sk_done(sk);
+		goto out;
 
 	case MRT6_ADD_MIF:
-		if (optlen < sizeof(vif))
-			return -EINVAL;
-		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
-			return -EFAULT;
-		if (vif.mif6c_mifi >= MAXMIFS)
-			return -ENFILE;
+		if (vif.mif6c_mifi >= MAXMIFS) {
+			ret = -ENFILE;
+			goto out;
+		}
 		rtnl_lock();
 		ret = mif6_add(net, mrt, &vif,
 			       sk == rtnl_dereference(mrt->mroute_sk));
 		rtnl_unlock();
-		return ret;
+		goto out;
 
 	case MRT6_DEL_MIF:
-		if (optlen < sizeof(mifi_t))
-			return -EINVAL;
-		if (copy_from_sockptr(&mifi, optval, sizeof(mifi_t)))
-			return -EFAULT;
 		rtnl_lock();
 		ret = mif6_delete(mrt, mifi, 0, NULL);
 		rtnl_unlock();
-		return ret;
+		goto out;
 
 	/*
 	 *	Manipulate the forwarding caches. These live
@@ -1731,10 +1786,6 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		fallthrough;
 	case MRT6_ADD_MFC_PROXY:
 	case MRT6_DEL_MFC_PROXY:
-		if (optlen < sizeof(mfc))
-			return -EINVAL;
-		if (copy_from_sockptr(&mfc, optval, sizeof(mfc)))
-			return -EFAULT;
 		if (parent == 0)
 			parent = mfc.mf6cc_parent;
 		rtnl_lock();
@@ -1746,47 +1797,27 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 					    rtnl_dereference(mrt->mroute_sk),
 					    parent);
 		rtnl_unlock();
-		return ret;
+		goto out;
 
 	case MRT6_FLUSH:
-	{
-		int flags;
-
-		if (optlen != sizeof(flags))
-			return -EINVAL;
-		if (copy_from_sockptr(&flags, optval, sizeof(flags)))
-			return -EFAULT;
 		rtnl_lock();
 		mroute_clean_tables(mrt, flags);
 		rtnl_unlock();
-		return 0;
-	}
+		ret = 0;
+		goto out;
 
 	/*
 	 *	Control PIM assert (to activate pim will activate assert)
 	 */
 	case MRT6_ASSERT:
-	{
-		int v;
-
-		if (optlen != sizeof(v))
-			return -EINVAL;
-		if (copy_from_sockptr(&v, optval, sizeof(v)))
-			return -EFAULT;
 		mrt->mroute_do_assert = v;
-		return 0;
-	}
+		ret = 0;
+		goto out;
 
 #ifdef CONFIG_IPV6_PIMSM_V2
 	case MRT6_PIM:
 	{
 		bool do_wrmifwhole;
-		int v;
-
-		if (optlen != sizeof(v))
-			return -EINVAL;
-		if (copy_from_sockptr(&v, optval, sizeof(v)))
-			return -EFAULT;
 
 		do_wrmifwhole = (v == MRT6MSG_WRMIFWHOLE);
 		v = !!v;
@@ -1798,24 +1829,21 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			mrt->mroute_do_wrvifwhole = do_wrmifwhole;
 		}
 		rtnl_unlock();
-		return ret;
+		goto out;
 	}
 
 #endif
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 	case MRT6_TABLE:
-	{
-		u32 v;
-
-		if (optlen != sizeof(u32))
-			return -EINVAL;
-		if (copy_from_sockptr(&v, optval, sizeof(v)))
-			return -EFAULT;
 		/* "pim6reg%u" should not exceed 16 bytes (IFNAMSIZ) */
-		if (v != RT_TABLE_DEFAULT && v >= 100000000)
-			return -EINVAL;
-		if (sk == rcu_access_pointer(mrt->mroute_sk))
-			return -EBUSY;
+		if (v != RT_TABLE_DEFAULT && v >= 100000000) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (sk == rcu_access_pointer(mrt->mroute_sk)) {
+			ret = -EBUSY;
+			goto out;
+		}
 
 		rtnl_lock();
 		ret = 0;
@@ -1825,16 +1853,13 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		else
 			raw6_sk(sk)->ip6mr_table = v;
 		rtnl_unlock();
-		return ret;
-	}
+		goto out;
 #endif
-	/*
-	 *	Spurious command, or MRT6_VERSION which you cannot
-	 *	set.
-	 */
-	default:
-		return -ENOPROTOOPT;
 	}
+
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
-- 
2.42.0


