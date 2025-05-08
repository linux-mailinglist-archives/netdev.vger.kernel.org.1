Return-Path: <netdev+bounces-188979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0395AAFBB5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB99C3BB71F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAE22D9F1;
	Thu,  8 May 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C0WhsSM+"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9522B8A8;
	Thu,  8 May 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711682; cv=fail; b=tVTHVAIugbmwptTUwwkzbQjz80XefpOR5vnSgIPuAoHgfzGMiqQO8l891tb9M45IEM7OLj4I8zwMcs3trDc/RHTLMgoNrN1TC0pfzgFnoqVCjBMgnGibZN3PSRGSE8Mjy/3MyaC05B1zXrsq6fMsMWE1L+sgu9hMvtTsna7It3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711682; c=relaxed/simple;
	bh=NbzeWjqNBJYflW8XrIsRg4b9lqcUgpb17eGybsXzlvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYGLaxvM7ad1Wf13oXJq2cN1SdDSIIirMVggqzm8pGeAKGYre0DtLoGH0zhAdd/qFDP/eFLuglgX/bLztoq1a2URlexg7RYShJn/O150ApBVVJk5MAECQ5qxPVPesKLzAJkbUWrR/YxzKQg2lmdNvN/RWgN1Em/Ud7du8T9/EGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C0WhsSM+; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v94+dWZPgnyYcsZLrUsG3VhWb0olCp48iVGz/KBLc0kfGUPQMpmkgi95Pe7CH18SfxHzYOdB2NtCwHexRxvhRELKokwC5Aa2HC21zvsa/Ft/YXoRjlYVaSx9BRlnQy9rxq+VzTn4Ksn3833vd9XyMBj8LpTFR1jtgQU0UkfInIoo/O3XVhOxU5tvSInNV/w2fwdkC8UxQRLmyiGwWq9aaGtesmk2c/pPIqB2YE/4NkebhJ5ycc3bSAc80I5ariNt4ofgaIvAaojFeGoyQz+QuETTIgEWnvScI+Mba2lAPMU647MCKgvgSfW5sueGUFnjBEg70pEMCNH5Ld2l3IX/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OBp2xZIekt4nCk2zSFRKhTio6khC1DdGJc49J4BYng=;
 b=hKeseFLmLPsVmOgsAV8/IB38+RKKCJa23+ScUG/rCgS1yS53kgRM0ZIR9je0OHELPHvQO/2Qn8NjUlRZq3VjVusP65NMsNwD/fFlfDwVcKfHpv92x/dGjZal5PM2Kzynnaa16MfFkQU7ltKE7kXKN/5YPAFeOI98YzGOWClEHQgdRUtKskUe3114gxOpFNXeDPz9lY8Z7wXdmP/1/UhiZ5/AVKfBHTEszfYn7P9XQdOFNQrp8qd8sZWFzQJkrxUecvd8aCmBQ7a2WKo1OyTbzXaIOTjPN7cQHCLEssob1ZyV6wYY7GkMlutwzJOfPovyPB0J+1Q6p69f+7N8VVjgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OBp2xZIekt4nCk2zSFRKhTio6khC1DdGJc49J4BYng=;
 b=C0WhsSM+x7N7um1DTetP32PLc83K2em9qFP0UZaoXJlsUAFvkudeNfwVrYotkkCA0yeDgkKO+eK0Jum/33PH0pW2wzgvPPGHneM287jbdYJ6REaYQek2gRxhybM5VGblI51BzAAU7/c2rBPj8QvuP2bIWOcxGwjgliZB+bxOUf04TK2fz1ove9YP+jh6DbasuwWgow6syomZ+lonRwM+eDR90Y/uSaJkxbg7I2Xtbw6FbPAOtgH9w/gjQYKJVLPHRZ5WfD6Raaz5cM7/VuBu8MCt9pFGsrbzLvr23Nam1SD31K1nX+KtRZvlKt3iRIvWqNKecuik5dpC+cNYtNxKDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10404.eurprd04.prod.outlook.com (2603:10a6:10:566::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 13:41:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 13:41:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dpaa2-eth: add ndo_hwtstamp_get() implementation
Date: Thu,  8 May 2025 16:41:02 +0300
Message-ID: <20250508134102.1747075-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
References: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac4466b-1456-4d41-4cfd-08dd8e3600fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hc9K+j7eY5lnjCVoZki+LOHFYjQHTG+9bhzHKmdeH1ztSt3u3O8jtGIqbWLu?=
 =?us-ascii?Q?KlWsFoVtANrv87xvJWoqI+HJZOc+bxYlRyybIz/4KRXJQo4uExMHW6ohmAAA?=
 =?us-ascii?Q?oZoZyHSGxZbVRu6wP8YBzi97dMjypzqY7cSvU8+i5RYzopj/AB9Bm+0pk2g7?=
 =?us-ascii?Q?s9lDm3iW+7fEjDtNDCTTQFxv7fAymppCW/+HhQlrb1G0J9yQivl7k7majb6y?=
 =?us-ascii?Q?MyMQVbFIjRhUMU90m85BTcwHs5vUa1gjVr6N9RKInjamU8rUrmx1D45vpZFL?=
 =?us-ascii?Q?KS41qqRulKh+tgr3jdhAtf9m6Iy3k6gTFZI5bICOLZwpoWqSM6rUqumQHRPf?=
 =?us-ascii?Q?GMBYabMvjCPs/6VxF+HSSjXX67CH+Guk32sO+QlTl6zNEQY1zZyrUm/jCuGj?=
 =?us-ascii?Q?DeEtCkLgth5wcA3yH0CORbh6OlhohbEKFRqnq2rbTgZjufsDtPLF8Alg5azq?=
 =?us-ascii?Q?aqBT3o+GZ4WCdf4GtqDmm/Zw9IHGaNecRhi/7BHPrZ0P93NurfJ8KJ1KnlGj?=
 =?us-ascii?Q?eprJeG9CKC+bmw8gAfRtKIjmEMHALw8zbLXEfuSGcJGhBdgv74xUCJ0ACnIW?=
 =?us-ascii?Q?OEizVFSW+hxVE71U/ovFXZ50mKo4aoYw9Hj/83T3vZc4PEsamE0vfbXtcGSJ?=
 =?us-ascii?Q?28XM4QGYwegmoU8GHR0vxxAWWnMBU9osanWPyOllFu4TTDj9NfKSmsYkewcr?=
 =?us-ascii?Q?Dt3pLe5Ti+cx1zmz0YcbjUAjSzUbvdggd7wz50T247VGgjS/9mpN3A/30JIA?=
 =?us-ascii?Q?dMAmiwwDaLKaNivorMLtnmje6XpuHT9tJmFYauPeLpiwu7LvzCSeO1B8Xdm3?=
 =?us-ascii?Q?LzqEfjDpI43Zh4A655rnWUoRUYIW7xt2XJe0kfroxr2U3joljT7slyagKXuN?=
 =?us-ascii?Q?fzzuCSBnyxhkssz6M8a/HKETjV8Tl/hu6TB/deiyr100RUUmLdiGIqNzTRAU?=
 =?us-ascii?Q?kdnqC/CspoCCtw+nCrrrFf/PkNVznj3N16ZWkaQ/qyn+xiRGd44se41WVV+p?=
 =?us-ascii?Q?JPAWR7SHIinU/gjLbg4c1mP89Yyd5ZIoWl8g/lmbGfLaALJEFo2dACXfo+PT?=
 =?us-ascii?Q?FuX8EiO3tRBL6nmLGQxxjTqNOESqTpGR6LVzVniLClKmtyzkr2uTAmdewCmI?=
 =?us-ascii?Q?C+lZRYp9z5jnqgqedJQAQqKkvcJmvIqhp6UZW0VrO3TApvA1nCUT3vF5HFRl?=
 =?us-ascii?Q?aZIoWXirpZg5/z0cGWYkCKy597ow4xB0ifXSh9r/RE2nzKOaFNMSMuGeEoma?=
 =?us-ascii?Q?ix9WJk91gyRpyj6Z/+YnbE62GbeEOrWN9iJnb1HGj3f14xVS+tOq5RvFN3kR?=
 =?us-ascii?Q?GvziLwkXAyHKFlL/UdjpaCl+MiAZ0zEyAceUuY8RfQ0/93EexgAGqKrYz6Fv?=
 =?us-ascii?Q?Kz3Dx5S0CHGG8m01wglAhjTh76Ulk6q+vlhA97voWe5LA/h97wWcHzowLypB?=
 =?us-ascii?Q?PQlVzwaBstvJrJPCpJ+V8Pr+1cD2gKfhj4j0iVEf8aHCAyIKEKL6RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5IlrW0Jlc0NNQnJ8SAVg8wUWK/Dp2qBFMV4J5EswGKzbLyFkYUOCIyXhf2L?=
 =?us-ascii?Q?g/ScpK6KFfyumkORn+q4no6spDEeBaPCMrzv1XHAx+IR+jNRgtWoLp+Gj13U?=
 =?us-ascii?Q?HDpc63wXw4HhQA+0fHMugtyc3pCkgqqNya2WZACg0Vr++Me6wKzviHy12JhO?=
 =?us-ascii?Q?sYqPCXWW07v8lC5z2lkXJ6un0DNb9gp0QRRrxAMgY9XsBagRoAwRJDrAkJeX?=
 =?us-ascii?Q?RJbi6R6yrCuxHNTuF+gqzC2/UlZnnmNTr0Xwv+PSOhrmm+0YwLlDb1vfbDXc?=
 =?us-ascii?Q?dJxXJpYl76/Aa51nnfAplpMoW6NyCTeWFHR6Jr+E55gcxrfmX7RRGkaHGfL2?=
 =?us-ascii?Q?4T1lCswMshl3212XjutUhkjkvcl3HaJMMSeTsXWNcLUMSWJDVh4Wzks9vfZV?=
 =?us-ascii?Q?JGavQIjXDddL33b1tB5HYVKU6RQou8imtKTGxHoxlPhqDLLbMFjOGArL6JVB?=
 =?us-ascii?Q?sPTFpDApyMCe3pptjAb43FJD6NbvqYZy1IFb6B4Q9Ddb1xHDJkQ3FS+9q1te?=
 =?us-ascii?Q?TDz/kUaJjvu5uwkH2UXLIC3gRtqfgwT3mVek3EDuqdA15lXsb7l1iTvjRG72?=
 =?us-ascii?Q?nEYLOQ/558wvFklOHSM4PBI8EimI1kLL11Y4nsuTnMHKE4msm3ZGIJog3z/p?=
 =?us-ascii?Q?DqifWicSh0NSN9yqrA/X7s4xk4bcxOXAeavweu3f+CpTIFZVmpIhacBjKhcv?=
 =?us-ascii?Q?nFUlVf6b61LnpZWtbq7laTH1h5r6h+xnbpCjfT4fjrQe8GfDAr9GGMnq/oiJ?=
 =?us-ascii?Q?agUgfr1nN2YhBVCoXkouaw3xjtlrCHp+YAt3i7rPgygsmZ9V/DQTbhKIp9f2?=
 =?us-ascii?Q?TkZteIhqIE9ypRiptCzX+qQ9yXCQt53kNyVntFigrzc22hf4kcbb86DIV/1b?=
 =?us-ascii?Q?TrTSHvJwh66NOzjz7V0CPZtGg0z8TI9QiReu22EqKdsXjRG/YVC8cbvveg8X?=
 =?us-ascii?Q?u5jVyZiI4MsDif7l+xNK3lcQNiZCHoqkFauiQQ953aJ7zLJEsRWgiIBjNg43?=
 =?us-ascii?Q?/szDR5syOPGLlyv0VvtdJcUIw1T61PeXEg+TDWVerk1sAq17Xkv5K2soRSJU?=
 =?us-ascii?Q?PPZw1cVObguWxhx/SVNDkmv+wHvw17OuPFxOp20+4efwbnpYqL47Wp7ID71E?=
 =?us-ascii?Q?rMz7BOMk/bjGaTtwVRMOho/3zQjGjDeWjSZw5fGVEYHv+fVhBj1WTxLQaW0X?=
 =?us-ascii?Q?koQ+liGauu+63Q8JGUXX8v/NJe61ZbWn0mMG2pLyr+fBesdK5zTEaBDsbSF8?=
 =?us-ascii?Q?kjxKZ5t+rWlo00sYvRd5PYYAFcz/5boaBKsecblr3NRYIh8AeRoq7waM0cPs?=
 =?us-ascii?Q?VwlgbNzNY2mhiVCOmV+iIM6tPRXj13pxnK400o+N6Dza9/9tIcSh0fOWv3F8?=
 =?us-ascii?Q?6eev4mb4OVCSQC69cujDbO3XGnyTyMUGrx+pWg/A19Xsvy2ask1O8jIE1Ipe?=
 =?us-ascii?Q?KBWd/NSgcmeT07QJZNYWm1esaySSE7SQo/Aaf5uT0++v77jPoxKZD8tMaKxd?=
 =?us-ascii?Q?UDSSYodmwNrrkY7R3iVrYkKUOiEzHt/FKs9nVzUICoBPFu50fn67lDCZwXBL?=
 =?us-ascii?Q?JY+hQNu8MrhRykZCrGJG2jT1bjVZZETtAer3XAFPWQpO7azuLTy85YkMjwGs?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac4466b-1456-4d41-4cfd-08dd8e3600fa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:41:15.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjgRtxQ8Wh3miCwDcsSVSS5H2L5fGMCK56Ebw8eJRmNk/fiBe0dNWewECub6ZqXmpQ30sgzac1UX3xNHXv5nPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10404

Allow SIOCGHWTSTAMP to retrieve the current timestamping settings on
DPNIs. This reflects what has been done in dpaa2_eth_hwtstamp_set().

Tested with hwstamp_ctl -i endpmac17. Before the change, it prints
"Device driver does not have support for non-destructive SIOCGHWTSTAMP."
After the change, it retrieves the previously set configuration.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LX2160A
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 13b44fc170dc..2ec2c3dab250 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2618,6 +2618,21 @@ static int dpaa2_eth_hwtstamp_set(struct net_device *dev,
 	return 0;
 }
 
+static int dpaa2_eth_hwtstamp_get(struct net_device *dev,
+				  struct kernel_hwtstamp_config *config)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(dev);
+
+	if (!dpaa2_ptp)
+		return -EINVAL;
+
+	config->tx_type = priv->tx_tstamp_type;
+	config->rx_filter = priv->rx_tstamp ? HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
+
+	return 0;
+}
+
 static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(dev);
@@ -3029,6 +3044,7 @@ static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_setup_tc = dpaa2_eth_setup_tc,
 	.ndo_vlan_rx_add_vid = dpaa2_eth_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = dpaa2_eth_rx_kill_vid,
+	.ndo_hwtstamp_get = dpaa2_eth_hwtstamp_get,
 	.ndo_hwtstamp_set = dpaa2_eth_hwtstamp_set,
 };
 
-- 
2.43.0


