Return-Path: <netdev+bounces-188970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D788AAFA6A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1607E9E0664
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3F2288F7;
	Thu,  8 May 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XfHlaoht"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D112229B1C;
	Thu,  8 May 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708525; cv=fail; b=P1u92dL4IDMAUPOlURF3JXeFi4IaIpQ2xQJGnYoNzqKu8gZjrTyFbs8jktszTbsBCqFH43ouytgRfkQfl8ScGXpHeE/EhzGhU7YqtJy+AcUyGMnNLw7bvORO0NPPkYQnmdL50fXW4rnDmQoDYtGjlAm+G7uSh/EPi0+DCsaF5C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708525; c=relaxed/simple;
	bh=tQnpKqUOjskxesy3DZML8zZbHsdMjtw+gjjyhUvHHJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEZxoHUHz/KG+NIC8aLGE6zBxxhCPk8qmEnr2L5emwSbJwGgRXpsQHP7IbGRaFjGSMrNt5OkbSqs0MhV6328fYLwcYyxDjwG7iLnpNApjGL1H7g9cOIxl1lKqsM0xDzuvGcxdEK6kFdAFVg/onGdCgy6CEBOXKaUZudGWVwwp7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XfHlaoht; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaiW2vZQCY+o8wta8PVeO45I+lpbhONZ/i873SYxXYNxnbZ3I4US8pnW0T6Z6tVKKV5I6fYPrIq21KOQpjTUx/Wf2ra5cV02RMov7ScsO7XwA+ilUbnF09RTKaUMZuslPwC4jlJFKpyBharNF7aQctUpDPZ0ZNmwcmyKChbF0NA31lRIM5DJ8o96jaQH5QnxD51N76Nt4I8wuowVUyevzsgHunPajLxCMge0wYEL2Ap4Zf2TEKYTWg9iAekSlJNIEoL9K4UUEAjkAgVvwmd72tzi0qB2O7set88sK6NhORBSioc/P8FDDIqZpl9vzAIp08FZ6hfatuOt8DumO6s6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIdiUmwIuK0tZKpBGyoe+3v7DpbKu07CDBIyToo5des=;
 b=La6/sftMu3zH8NgC1pk1++GQlLoqcRDB48a32WqwvMw7W/GC2GVJBMMQxNw5ff0qO7zZYusDbAarNQVacXb+HkZ1R7zMRlrvJhMWWc+I5EcwhbL44NqcuRI+/VEie/aLKKZrMhKR8kgcVkTcfjGFH+JM3HZ8QAb3rwER7xnNqiqDoOZ8TNlRFmOjrL2imkospdwRW48u8LpS2euarzLkOeW/w5YTPLaZTEHPzt+qe6JHTk3HYQn4+KYnpsbC3tQHfYsyhAtTmao3zSSpVTNNd76bz6/4hIihUef1l50sfubH+ya1Ke6H5FL3OcwqfY89pY1bvmrTswBXhvr0AJcLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIdiUmwIuK0tZKpBGyoe+3v7DpbKu07CDBIyToo5des=;
 b=XfHlaohtYU9Ucvsoa1WjrfTf1Sw5/jqdWW1tZEyLejCMXNpteSeUgEEgsk3DZgS2wZSXzt9evhSYe8FkhaQ9NNzhIk2LhiCoV2hcDuKo/R/LkulhVflubwC7P1LoH9UYnl5ZmyUji5aMcnMLXedBk3tA65FescLhnQ8wgoIiGBjaaTv4kIlHwTfCFoqKvIrTp7c3m1BMIPC7Y5D+htIkYT1rw0z6w12T2EMLqFvzarkZZHF8u6SPgPtlRsz+vzIU/vMvRwMNLGV3QFN7CP/LEtRZbm4a3SF2tNehnNoiy3P5aEgpW9QQzXUzpo9L0pZb69G3kXRhlvDYJwm7ylZNlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10398.eurprd04.prod.outlook.com (2603:10a6:102:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 12:48:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:48:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: dpaa_eth: add ndo_hwtstamp_get() implementation
Date: Thu,  8 May 2025 15:47:52 +0300
Message-ID: <20250508124753.1492742-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
References: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6765b868-f8e7-45f7-a168-08dd8e2ea753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VmaHZs9YbIpmXrOH3vgPAqOJN7sLT/VQIOmEyvDnkOOEgCMJnVtJAE/WdrE0?=
 =?us-ascii?Q?E00pFSsV63WQEoN9xVdtKs8zBX1ANKElif3KDcz4A8avQ/ADq9DZ3/+Rk/Al?=
 =?us-ascii?Q?jCh6dLjgwQhbT2txGJuKeuvRSI3Ez/AZS//MAsbCbegBqfwnOAGXEKxyRhMo?=
 =?us-ascii?Q?HWr2SYYfclRYYaIT744GaonGQpwS1gdnEYcIplklAdmBw53Hw0PqgYKkrM0s?=
 =?us-ascii?Q?afEkPoCVmYN0angXwyFG/KhJvknNeZwtiCjsC81lvvc+WYUgvuvl6sAj6skz?=
 =?us-ascii?Q?Vo2yDDiRKmc+FZoHiKBGnahnEZOftMgyl7tGgOusTSBHAX2YEXtlIOkw/VFt?=
 =?us-ascii?Q?QLnY+M4NQk9X9C8jItiNtnpvWs4ecKdPIamJtVKwSi2FQz8Jkh5DmdJ6fDjM?=
 =?us-ascii?Q?3K/iWgpw5Np8dGXyhiAk3HXCUuO7HmWjN5GJaAPd/LSW06CR3ZcPC8LzAEKZ?=
 =?us-ascii?Q?a/M3KTG9DZqbsS0Nhlq3nPAyFYT0sutiK54mUJjy7iDBdmLadK6u4DCxFcwX?=
 =?us-ascii?Q?0s6fNmAC/9hxwMu7lPNr+qNxaexal+AjBg8IpYj/RhUis5IQi4dUyRN/Q9Cf?=
 =?us-ascii?Q?g1LIztqsj3XOBVuVHabT4sJhta58JbOYWZ3P/oQqRX5Sbx31rfUt6xmKOpFS?=
 =?us-ascii?Q?mgHrnUUnSh7aSLPDyy/6ogUUqV6woWDDYpLukksK40RJK43Fz3m8AJnMk0oQ?=
 =?us-ascii?Q?NQxg8k5jRC4ur+b/JgGPmtAYwkjobdi5TkeP2Ci5UcaZjAC/ND4lw7Vw25dp?=
 =?us-ascii?Q?NaLrWWzegBZAk8y7hUWYe1rsWUczEEZvMihXG5KBDIYuqpRrfUAmWJH6cSZX?=
 =?us-ascii?Q?ryJeKFrbEBtbo9Xmhj7iBjkL9p0GUFWUmHbR+l6bZlCvsf/DuWo9io/ERnw1?=
 =?us-ascii?Q?xzcMgZXtA7QGYDQnkzEFU/v3dMcYnAGtEc6FG8eLPy82ju6DfitXXKypQAy/?=
 =?us-ascii?Q?EJSxIu2rQRp+N3S6RLZUXjYugWpzKE6JBDHRo4Tscnn9tBk5kHuujtUYxY6o?=
 =?us-ascii?Q?HPLp/Ds6kc5Wtwgs6r68TkOESSksOAHQI3zrF4lBIQmv5TKETLG4X3phe7O9?=
 =?us-ascii?Q?Zl2TuwEzOst23JpNDyNtXoN3Lp2woRMxoQ7ZfgAjywLwU7AhfCT9tUNs7IHh?=
 =?us-ascii?Q?zi2ngXVkncfFjBhPllI4ndpNfolwDGQmAvKPfehZwAS9MHdhrnj+YQyYF2vs?=
 =?us-ascii?Q?7jVQCT85uVLPMENQmeXxb3vRS/Gt5S8K7GiD9dUAe9fTDoXRFQFZLwY5hd5u?=
 =?us-ascii?Q?e/SyerxVlbcBVTosy7RMlw+ubfSp4/ODiZ/QRV//lrgNJd9wqcCkZSsSOM0e?=
 =?us-ascii?Q?ZDOI25hJmIquZgWuMUr0IWEsba81SYs7pD4xrhFOqfRSVgcDdKSE8tj4UtVY?=
 =?us-ascii?Q?hK4HDAYig2zIBYW7Oh8c4G2O7mR2zLRk/Vjv59fT68WashJrYTTtv8thLOmQ?=
 =?us-ascii?Q?xdbakua5pzolTwPyNbTYD/c+tdkzbBgWHDHowy70D9BhuHaCu9cDLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpTQM5cJorxtXZk8j30dni1LyDSJI9CsGzmOy/GFQhbCw+yZJOAHQQQjxBpz?=
 =?us-ascii?Q?xVeleYxj6adZh0+hR2L76X1oxlIYvkiIJbcDNapn2OZmE05hkN7e5u2Cq/xk?=
 =?us-ascii?Q?kcPfXX99qBEuybTSOV53xRT6bCiAwkVrUuEzn69aFDPE/UiCF9gwZScQhXmc?=
 =?us-ascii?Q?GYmqgbp5IOP8xO/FYkE7CHtAxbSe1n2cokerqWIQ0ko0C9COxLjAR1es7jlL?=
 =?us-ascii?Q?80fM60yceha9NGRoem37Emx2CvQX5okIQLg2xvw9lDq8SYi52pOS7K7s4Ev9?=
 =?us-ascii?Q?DqTW+CsnjXrnim+71Wo5b9joTyNRoNR9wltN78AQ4SwSnd2HPJTVVUQmigOT?=
 =?us-ascii?Q?oQfeGP/N3tBWt+nPGa9IsmA5yPzK5UEOMm0cIG82eQHhnxqm16m2vxgxh/tr?=
 =?us-ascii?Q?gGyDkVQWOnfof4GP3zaTiHQxmHylM3/iTWTiQemfAsNtipvejqUxM85mVdHc?=
 =?us-ascii?Q?OdKLHD9j6KEtQ9bSsOi5gTHnuNMxSPnmDQxLNetI7LURW9fGpEl4xQxW2cgq?=
 =?us-ascii?Q?BCOfyNHWQ9HfWK0O01Qjmtvn8G1N+91leEMK/ZLAhq2pGx92zAVtzKJCLh9E?=
 =?us-ascii?Q?eNZU/vGHnkY6hwBSwSC0bWLxfk0+f5EyDUF9nuh93Znkpxm2hWvYuQov2lxC?=
 =?us-ascii?Q?KOdCnioU9xScFtbgPyTeA5afYRZHJD0Gasqd428Q927ZuRjVBj1+eeSIakhC?=
 =?us-ascii?Q?zgR1/kpyWy2f0/JAVyb5KGsaKdpRXZjg6C5YHYQKl3P+dLtpczAkzxxwfpT9?=
 =?us-ascii?Q?UOHF9n6F/2M3slGRtJ9ppJZBqBJkOAvtAZa2vqmyFwMU+qpiZR+bx8RgC6T7?=
 =?us-ascii?Q?LiIpBHZMJjcqJXuEOPkSNjWPmkpzP54gLkPYnaeod5Mf2a3xT0sjwtFzpS+Z?=
 =?us-ascii?Q?/+Y+f/6tYJmN0h4zgYeCTzwRMTNBE2Av1xS/d8mJTqMGMlyIHxiH/Sc78+y6?=
 =?us-ascii?Q?AD2oIufIIphGvIV4Qp5z9aoFAP68tX2udkyjdBQSOXuhA+OGrKdAYnO3dwm4?=
 =?us-ascii?Q?Z7PlxvQXTi48y9fT/nGMNNBxDChJ4Z/64IAA/HZob6OWb06UmbMv7T2in1n4?=
 =?us-ascii?Q?SEJISAERGlk2qWpFw3RqyBVX3Ssn9NE0ecEMhwdtDrKGgU6XJf0L5VI7bS9h?=
 =?us-ascii?Q?bt+LAckeh4GwzD9Sffmni2kS90DQ+gZtW11nrTb6i9rwrlbHtOKYn1599Py/?=
 =?us-ascii?Q?BRzLn77ri6egkHElztndOABhfaT7CTfe8YWPyc6xPOShIszP/CGo8r91LDVl?=
 =?us-ascii?Q?ms0G0s133CsXfjo55z7OpFbBu3utewmrcvpMYhGRtoP+yR0/oV+RDM8LZlnd?=
 =?us-ascii?Q?m1mFMftiqfqG479FhmLfdFWGUy+24vqcNhO6c1esmga0OrFSE6DxErhdvCPp?=
 =?us-ascii?Q?Ld6th4dEJpHENMOB6mbMEZSKerp6L8bb9t1R4nbCie1zRIsKnyRk2kx94fCi?=
 =?us-ascii?Q?TNEdBQXU7ELfDS1nT4oGxAUc60jFqEelUDK43glz5zyLF7/+t/mBWeXl6+aR?=
 =?us-ascii?Q?CnyQlFm8i/tnDJCyBnjT1f9GjSxlG07qb7oFI3D2hUjnNV7jrOf5qHyyBQBL?=
 =?us-ascii?Q?Cdw0kFeKKxnx8PUwthaS6sQLISb0tawBFBVQLh9xaMT64audWfDvS5Z5NSRB?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6765b868-f8e7-45f7-a168-08dd8e2ea753
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:48:38.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWgCDbw701ThV3eO5w/lY228E5VuMK9kGPxOZ2AGrsHFESEWMt84XORE07A6pPe3dG+eOYy9AbYJn8Y07I3GEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

Allow SIOCGHWTSTAMP to retrieve the current timestamping settings
on DPAA1 interfaces. This reflects what has been done in
dpaa_hwtstamp_set().

Tested with hwstamp_ctl -i fm1-mac9.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index d5458a5fb971..5b8d87a0bf82 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3089,6 +3089,18 @@ static int dpaa_xdp_xmit(struct net_device *net_dev, int n,
 	return nxmit;
 }
 
+static int dpaa_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *config)
+{
+	struct dpaa_priv *priv = netdev_priv(dev);
+
+	config->tx_type = priv->tx_tstamp ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config->rx_filter = priv->rx_tstamp ? HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
+
+	return 0;
+}
+
 static int dpaa_hwtstamp_set(struct net_device *dev,
 			     struct kernel_hwtstamp_config *config,
 			     struct netlink_ext_ack *extack)
@@ -3154,6 +3166,7 @@ static const struct net_device_ops dpaa_ops = {
 	.ndo_change_mtu = dpaa_change_mtu,
 	.ndo_bpf = dpaa_xdp,
 	.ndo_xdp_xmit = dpaa_xdp_xmit,
+	.ndo_hwtstamp_get = dpaa_hwtstamp_get,
 	.ndo_hwtstamp_set = dpaa_hwtstamp_set,
 };
 
-- 
2.43.0


