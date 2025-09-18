Return-Path: <netdev+bounces-224271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8EB834DF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1971C20567
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1B2EA48F;
	Thu, 18 Sep 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUgXOtOc"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4D2EBB8B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180134; cv=fail; b=cnsiWd7B/n8SY8+hjj5o5+/cvzNjIQTmdPNT8mwxmnjD33GBgT6T3YH4yyBGpapLZ9MJcHbuAbh69OKtsB76yoSKvk26Czy72lzUJrqyFBUvwKrL3LlxO9OWjhiyfwfKv35yWShrgSxQvh1rBPoDC6Qc74z5lHVTFMBxXB5b/vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180134; c=relaxed/simple;
	bh=fPpFXUBsQ2K74noeKITh2Hu+3k1X9HtTj4sFTlUL+dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEONys8a9RwWisEWkmxCTlqHouLa/6lpnrdxtAZg0T9SDXQ0/puTB8a31tyHMBcL/akrYcQZwPiMN+pxLhFif9dVQC/llf+/FpH1UPUxwq8hvLV8eOxInt6ihWJPwEF8E/A8xcbiaKsmXjXxh7gwYnZuBJgcMhXemO5hS8Xt8bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUgXOtOc; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ8xobObFfHcOTx9bNlU4b7gK3t2jCQ5zUbrNnom/0ffk+Yegaq6RUVmEQpQor+MQguV5+VmDIVVEeDsQ/geXbxrSfmet4f2Wm3lLNiSZdjb9Dyypn9xVEc+xUnur5Lr1HA9sJzBQg3kaIyhWAe5N2AOD72Ofeg9eDPYscIYdlNbHEvlVFz7hwBKuGVblD79nHYNpTojwWvvbj054dhr2y/L7euOJ7B5pqyu1be+OdWMzaSyDeaIWu6SkVG8BOYurhLRSgF1yY6O0sS0zYUKNwrFuCmCR9BNWc89eJIaRNyLLc0VWDiVze/REpx8XO7hvdrOcqj+9/UXwwJWrMMUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFU4O8gHWYN8HHVf5dqwc1a5Gu79Qrm2sDz8Lss4Jrc=;
 b=j9+iId54jJYQ+B926bRR7EjSWUYNhazOmmlez8HIE3H4K5d0FlMQCQeaEG3o8oiPgutVpGysR0g8BS8y6uQhWqigaNLCtGT/qcpzNXvBa+RJ+ktiKIAT5mlK1VgSSbBezMHR51Ql7qnP/e4vZgLW/uHCt1oWcyGZbeKLODLyUzzKwPI21qsODYh0cvCAxNLjjeim1Uyak4CE/CjMoAAE6rSm0EasZbMq+Tfs7vXgANgrPiqcq1IQ+PB1w8Y1IyRqg5KsJD16MAD86SYeOXGx7BZ82aKlTgjqHpjbbGbZdCxDRdEWleqgagwam3hBUg/c+ZR97qGFZgPf6qiTmWZ5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFU4O8gHWYN8HHVf5dqwc1a5Gu79Qrm2sDz8Lss4Jrc=;
 b=MUgXOtOct069CdwqaNBmm8Q8Zsyp1ObgHnyX5DWFKbb38M2ZUpT4vsqtJWiytZJ622UBp9FCuFCQIf+y9jSNuIlHM4ZeTfHvNJsj77yjiGVYcdUDkLyNNL9qJpb1l5xwmW0a0RGX/ziApOlUqi++xWIxqwDROLVIs8CojnU5n/vTOIqFesPZFEgwtTi3t9iUGUqbslPz94ujyDGtdSCFivKHLNk3+aXu05/r38Z23D+D59BjknqYHV84PfPCAPpYrV+5nDhDImrgMaPR6hd0jvEpqqkIa7DH1nUKsfsUC4qoEfBsxCv2mAvC9QSs89rfbSnJGlfM70xNCn+YN+BcsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:21:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:21:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
Date: Thu, 18 Sep 2025 10:21:41 +0300
Message-ID: <20250918072142.894692-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918072142.894692-1-vladimir.oltean@nxp.com>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9903a1a4-d198-4925-c038-08ddf6840e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXTyzJkfU8SQIkuqKj8dNUzCzNOHXQqQgOdwclkEWXjINRjhy2kmx2bcwdLb?=
 =?us-ascii?Q?OwIqOEq0zzMQrFsRFxJ8vLeaGBXg8uC7HIqnaSCQc0EWT8xS9PB64V9LMGty?=
 =?us-ascii?Q?gLmylgro2zqSLHFJ0fRFCQWiAQ0nOBRjvwc+w8+UeCzaPXLPA//qJlwrAR1U?=
 =?us-ascii?Q?Cwk1FPiJvQzO46b1KRnsIFATggxHAk+Dq0Ow4ePFGdzdGBXRMMXjz5M4r/1q?=
 =?us-ascii?Q?8pr5c5+CwBsskIDwm20vIaMudXOMsyVvQ+k22l7Luz6AU7kxSEbBgZsuJhUi?=
 =?us-ascii?Q?HlfwgYiw9jyya2RnUQvE5pLxYTJg9gAi0L4PhXUrlzvu7PVe2/wdYS4viPfF?=
 =?us-ascii?Q?k/FSqvlIaQYP9m8V+doJJlNTnxRgHsQknWiiB3dsumxzCxrh6iuo3wFILwWf?=
 =?us-ascii?Q?TrzqUng/AlGKS4iz1JEN53yXsqsXkzyasBC69hcuSBnlA+7blIWEjNx+PRNQ?=
 =?us-ascii?Q?zKzLAQoMpslHqW2DLEjSiHF5pCsGlQmsQgODV7vyG5joJQ0axKEIg6++gkWM?=
 =?us-ascii?Q?oXF5QU0frF+hy5yE1j8mByDkvc2PX0GyYpr99MdIh8qw01RSpXn3L9Xqnz4b?=
 =?us-ascii?Q?d1zcHXeSbFxClAQ4bL40bzpj+ocYc/PsaWUqFecjLMJFRefvDbD2a0WB51mO?=
 =?us-ascii?Q?tUy+4QGMvpo+SsC5c4F7RX8qdCgC2ZnVzr//dCNyD4OMwHrlzofDMPr2D27w?=
 =?us-ascii?Q?GcE3I5D4yf6104sPwL5dEc3vz4zEr8I06eqFQKbEw2w2aERcPxC9so3QWTuq?=
 =?us-ascii?Q?O8k6iOnebbqIZWcIRg94O2pBVHfjQLDUx6KsNvU2CF1JiBUY3kOE1mrYqpIh?=
 =?us-ascii?Q?w+YnSs7xRnCwKFHoY0cuD7YTPMplXimIqBo6HEhxo0sXyBtTj+AUipXjP4jS?=
 =?us-ascii?Q?k9Dowi/ix+WvsEjYDkheToPfB/7VzsvwTK4e40ZJY1PxUThmqm/dfYNb5Je+?=
 =?us-ascii?Q?kpn0IGaUBsj+MAR9CNRt10RoCFWhwZ2Gq/C3Hq8fnLb4rVRWmAWX53GwdrKJ?=
 =?us-ascii?Q?OxP851MTBV6Cy4scj5+OS8kWltnd3IqS/eT/fmESDGVeFu0NB5YxWXkxoDo3?=
 =?us-ascii?Q?EDGx4ekfboTtrDh9RkHKRMJktZpMoPQJheutx4cDOGIqUeGCbVOWkN4Rc65q?=
 =?us-ascii?Q?AlWvmHEFlcllbPYPKOWFXMDoNhad5TlxNFg3nr4QkTeeSUohL9eENxv9VbLZ?=
 =?us-ascii?Q?v0IxDSK0SRhuZE6zxt4Kro1jcD7kp9cAq7LCC+9hRuwf1Y3Hg8IMeNQumO6t?=
 =?us-ascii?Q?eS0ZofV4BY0JuOnCv6eOkCgA+OK+tyO6WaUkfVRM5kO1oxoIFhiVAaA8X4Zc?=
 =?us-ascii?Q?nWOWK9nLL6xZIJJ/U9ULZ5017PKr1K5kINTK56eSoh33wwLxzHlNGb9OAEfX?=
 =?us-ascii?Q?59y9ujOro4HZD5V0//JmzMYDFhNmpNkHxcBQMIb1JzD1bj9WkW2kRSyWDZCZ?=
 =?us-ascii?Q?stG/NMpDNgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zbsfu2P05zHI1IakvK80EPmfT3DlD7ktw2VwA/HOHJU73TQuLk9YvJ5x4lFS?=
 =?us-ascii?Q?YzGXhxI87BbAUHPLFGTaYnJWlHMV6GY9wlWd0Z8d9Z+Mz61rSjXfMqV3XfaV?=
 =?us-ascii?Q?MHxgj7KECgnXAQihXB+BMS4l8l3U75CJI6EXeaGr1uzp5YXqIae1/oe5Qx5a?=
 =?us-ascii?Q?6dRSNSPFzv9cX7LuPjnmwFRuPhEN03bd74mhR/3lOo2h5PARJ0u387qBCovM?=
 =?us-ascii?Q?7RH3pJG4yAaCLKdgFDW6txP2GZadcbrUttKukMEYcM1pevX/DppuZ3+aP9Gj?=
 =?us-ascii?Q?xbM8NRSEb6NMipEQ5oWKNvI2+uFsTAGVjbLLSHeVboWjhadg59SvSCHcWrmx?=
 =?us-ascii?Q?Iii/cVRlAC3xOJGu67UlooSF04DPElUpVbutqkI0t8E/LbOnrvtvrCNwsOJd?=
 =?us-ascii?Q?5MAOuWJfHex1BMhU9VDYDGmoc+PXOJqono7s3hg2udk7hGYXBEteulcOtTS1?=
 =?us-ascii?Q?BgtKzaaDJoYvuiDrewBSsmCtoVbzYgpUu3JbiNqkYB+/7bYwK2pnGGcakFYY?=
 =?us-ascii?Q?8NNDP9R/SukdO80XWJDv27yEAPO5VCzidkKZGufiLNxs5voHm0NLCabDP7mh?=
 =?us-ascii?Q?Rg67Zj+VCxo9CWzMAx41ZFA4DavjTFJ2dy49j6Sup6dTIfpoTJrzO3Tfdp6i?=
 =?us-ascii?Q?mDuT+e5aPo3GW7CcPHm+2A+e7sbv0hRwV6fCsYV1oflztghvRTgCjoAjPpuR?=
 =?us-ascii?Q?GKh+YcnMlSrrhsAeGoYwdVe/r56CgrLvH8v19JYNgtdhQt5EzMhTXle8YlyB?=
 =?us-ascii?Q?GX+Pbs/E2+g2NoV2CPVKZRDlv0B02JjIeIp64YGIvr1g1eJIqtRZPhjcmCpp?=
 =?us-ascii?Q?SE67ui/XIXv//qU1r+mB/r+x3vBNFDjmqkHom/+CadVJu1Hd4pUgV1ywbtl9?=
 =?us-ascii?Q?zSLT6In05aU35Oua/P0cOAWML/GQAa+eDrYPuWUFk6zmoN97ty/l31uhZ7Ad?=
 =?us-ascii?Q?HVLityklBfaxq6YZ6Dd0jWoq0LFE4+OnXKwYtwe2yV8BpZCE+R6y0TsIwwNO?=
 =?us-ascii?Q?RA60h7e5D1iUHUONOoxOsZJvR+FBNq+xaHLBXfJQFxM7qmDVgdpxZ3QEZ78a?=
 =?us-ascii?Q?EGhjsgyH++KzW+NsQz5xBD6kw5k2OnWexnHGajf1Xp6damMtqwN7YmPw1rvO?=
 =?us-ascii?Q?qPl3u9pw1I69nF0Yadf0kcZTrxNPtFdH0OvPBZy9giLMY3OZecmVolKz+GrU?=
 =?us-ascii?Q?JH59uDIEkZEH0qMzONW8N3OYxJuXshpW2kz4i5RH2DxZxEmpsAwhfHE5taHj?=
 =?us-ascii?Q?vDTrAI0mMNaKS0Z/jBK374F2kpTFD1iuCsNC711/trMF7rXIaTCtxS3dlCeP?=
 =?us-ascii?Q?5ROti+WelUbicJB2TmPWzJdYy1gOqETjaSeDsQ3a7s85f9L48FsXp5A74nCb?=
 =?us-ascii?Q?WjG1d006+oNN34Lpo3vPX+441hLSvTLXakLZ4J3zZN6IYhv1eudsC3KOqYZ7?=
 =?us-ascii?Q?k6d/qLOgbtuaOEPpIwoWzKQ948DeBTaFhi8ygcLEGmWMKZ8mtRxiiIqHyXme?=
 =?us-ascii?Q?1Ok+6Q8x9TPLiAMexXTKj+X9dDz2LirWTRtPct9XbxQgH3E7pxYmQJNXW6Kt?=
 =?us-ascii?Q?oFtRaU7v0/KHJzM8zDmVXOJ1cSQf2TJsLXnL/yUdHd2I/dK3oHzJjbqATN1m?=
 =?us-ascii?Q?d88ib2SayogojAdjvuuEBG4cq2B1+x53arWFj39lekTljiUGQ4tf/WM51aCA?=
 =?us-ascii?Q?f6pH/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9903a1a4-d198-4925-c038-08ddf6840e15
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:21:59.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0TQnMgIA4onwjZvxLF7kgsqyWFmQqS+p1aVEmOWf/fY9osbCWEdp128d4Wq0UirN0yf7ckkgTsWXWJE+SSktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045

A port added to a "single port bridge" operates as standalone, and this
is mutually exclusive to being part of a Linux bridge. In fact,
gswip_port_bridge_join() calls gswip_add_single_port_br() with
add=false, i.e. removes the port from the "single port bridge" to enable
autonomous forwarding.

The blamed commit seems to have incorrectly thought that ds->ops->port_enable()
is called one time per port, during the setup phase of the switch.

However, it is actually called during the ndo_open() implementation of
DSA user ports, which is to say that this sequence of events:

1. ip link set swp0 down
2. ip link add br0 type bridge
3. ip link set swp0 master br0
4. ip link set swp0 up

would cause swp0 to join back the "single port bridge" which step 3 had
just removed it from.

The correct DSA hook for one-time actions per port at switch init time
is ds->ops->port_setup(). This is what seems to match the coder's
intention; also see the comment at the beginning of the file:

 * At the initialization the driver allocates one bridge table entry for
   ~~~~~~~~~~~~~~~~~~~~~
 * each switch port which is used when the port is used without an
 * explicit bridge.

Fixes: 8206e0ce96b3 ("net: dsa: lantiq: Add VLAN unaware bridge offloading")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq_gswip.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..d416c072dd28 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -685,18 +685,27 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
-static int gswip_port_enable(struct dsa_switch *ds, int port,
-			     struct phy_device *phydev)
+static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
 	if (!dsa_is_cpu_port(ds, port)) {
-		u32 mdio_phy = 0;
-
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
+	}
+
+	return 0;
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		u32 mdio_phy = 0;
 
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
@@ -1829,6 +1838,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
 	.port_bridge_join	= gswip_port_bridge_join,
-- 
2.43.0


