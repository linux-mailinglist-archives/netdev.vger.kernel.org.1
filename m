Return-Path: <netdev+bounces-289782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLOOJURYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7D5884D7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 694953043494
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66233F5A3;
	Wed, 20 May 2026 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="APaltmVq"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E207346FD2;
	Wed, 20 May 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259340; cv=fail; b=aNPO5AVN57TF1lqA8SDtLZg+BjZmuVcRBmsHhL/Jg7DbihNuNMEEUs9nJ7lNU9m/Cixa3IvoMIA/GwqymddNutiV363JAeP8q7KNajqRSrSPHaYxI6x6SuajD2LWtPEiRiWkEn82D07ukpho9rjgbCJZqGAyX27B5hgbQwiVUF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259340; c=relaxed/simple;
	bh=rwTEZ7lsBNZOmWrkfw50Im7FlapGGbRUlYlwDq5KGCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYhX+4V1GIqlsG4Fnd2/3eCxCfSOCKqJ40t+KOZBZ2bZUDG4GnnTLbFVMlPcPXarOOuvDCqxR8ofj+Ehdue7UloKPnosh49b96lGIobnYnh01imG19Rfmt3zoMxtJIKQ0edu1qZyaq25h/FLUcuM2xzxJEgNqg47sIwzw0+Czk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=APaltmVq; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg/DBN+CNnMwdXTJkO8c/XOvbdAlX6ozRNFauHI94sJgjIDE28HvGj3uT7EDkgo6kB1oWCjZH/ugAJLpX1LIGMbjwBdwgJvzi8hnBfd8754YoXEhj5SlzTJskqe3FeY1r9kK6ZjmipFbiT6yaAwBCFDergvg5BuWx3Bq/lk7FU4UpUhN1ZR/ZHekI95bvHwPjLyT6+hSj80hqKTqAtqRXpgm5qJ7EbH+jAfo3JyU5ZLY075UFniOWhNGfqlPTI1ltgUXRkgaeTn9U8ya+/2KSsqpOnjViBmY0miAQVD262pBmWfIPhqyzJJcmhyTT38JffC6WfFkT/aNd9/28L97uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkTREyA4r38BrZKCm1xzkLGKKKjwInsg0ikOwlOn3cU=;
 b=fY9XC/Aby20bVbcW2bxYhRDD+bad117PyTeJwTvOY5ZUEYWRHE6lciaKelGFyDocyU48m1Qp4r6+gIYOC4pH9tE1hfzjF8nvlfaYVkki1S3WeRL32RG3GYIgG+Y0dywQVT9sLzS1iNodWWbDuMqzpBsDWyLkx9CzzGd2cEx7W5/tcoFBcadNwAdONQCuN1jXXFp/+yD+nFU42NLrFBjzyusHehs3k3a7MlMUJJNshfvPqILIL/dS3Cb2IW6H1MFY46N5YJj57igCpKfiNuwA8DidIHKLioMbfJ5l2nESpG5HHrcFEglh3lWBVrqheTsrGHNtVS5oESz6S1ryi2Efhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkTREyA4r38BrZKCm1xzkLGKKKjwInsg0ikOwlOn3cU=;
 b=APaltmVqvpARRK8//aIfwZUw1lxtXT0KlUAViL4rXcwqLqjPPAj99o/xhEGC4mLLs8HJR/i+mSJ+OvPqzu+xXIuW88VFcOMvRcOAE9rcf7hkhZ5va6bM7+GjZ/bwXAcbH8sJYjd3YgW3Vs1vodDbcZiV+4JlNMxFEekF2fiXKMbrD4OnYtnBbi7J0MyCtiK0/NoFaYRPbrc2AxdEmw6uWvtMFXB1iZ8qjm1y7tuH/yZfzqj07yAn1R5Zj4ySV681oOwr0RIlGt+zI90tqkuvIRv7IdNOKNNuRhOYFcaGrolImbbpjGzOmDc6AMfcs10Ox7/WL0jtxoOhrutNElLOLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:14 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 4/9] net: enetc: fix TOCTOU race and validate VF MAC address
Date: Wed, 20 May 2026 14:44:16 +0800
Message-Id: <20260520064421.91569-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: cd421856-9945-46ef-7639-08deb63aed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|5023799004|3023799007|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1Gp/5JmzK/tvJ4sjN4CGxKlAWnWri61xFiwO6GEhaSCKWzBszwoTAR7KhKOBgYq37rnVc5NzVslribrps9OMU6oNcVA602VCbUDZH/EVoxYb4h84T5DS2fzrM8VDsGqH5Igh2firyutKfi6ZAMa3z+17Otl/gBleKIT8PqGYiiOIuF2SGK9YFGouMhgNYvkwyvshflQBdXYFKYruX/pGH0gmlJaqD6ovQFuntF5EHm5bq90GfJF+E3XprsZhMqe0a8gAkY4ziMkreaJ9z3hW+8kwo6569rme2Ze6qgJZC1H/YOLp38JsDFuxKg8wd9d88A8q5QSGFXI8XHkXaTqKKU9pAZeK42dia7yVG4TtAhNuxQJGgVBlOv0B/xIQKQ53sAk2CSlWKMou5OqgsCULEjoyJ/RJ6TELLlyG7UwOfe92SfAMSWf51TcGjH3hgnwYt2tefKdpip5FTywxE9q5/YwEKR7uJ66dkD4LqTpT4keL2lUGyt05dU7rciEMKzw/yyxXpMRNc6yOjIEAAJR5BfRPYzcArKCn6C9ZApkf0XjXwiLqnbUa2uTBZ0tdacSj3jbo9VeFOZCebXPheqXmlNJC8AU+gP7kG3JuZ/2faU6Q2eoAPb1IUy8yMybp7Iy9zI2WYJegSdgUMOSp5DQqhQGNyI/mbiRsz03zhvhLEdoaMJns3NdGRXC1pkCYfctB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(5023799004)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GQYy9rEuGZR9rawP8T2tNM4C4Ij4CMWeUfrVQ0NPC9rBJQlOBSECso8ti6i?=
 =?us-ascii?Q?K21jJOb1HU0o6FJSn41d/Dm9z8MW4m07LxOq/HpXNt8BrFEzXwIUeJUqYISe?=
 =?us-ascii?Q?SMOyCNk8v+PRRN7CasphXj03wx/xr81Eao+JL8uXlsiwRUuN10SBac6N60B3?=
 =?us-ascii?Q?Haq3Ws1HHgwE0CbrFD7E5PQP5rIfpNNVd14nXanaVc8ti3Omdn5ttye75Cfg?=
 =?us-ascii?Q?dyFDFQlZ0happSLWttUPrTAdBPGbEHVH4ndd9F82TmJKL2tlYx47YgV28YMS?=
 =?us-ascii?Q?gIhMBoBufdq6Ln4X1hjUq+x7sthSBNogNi2WJxlTG0LujL4XhBvR4puF8xoj?=
 =?us-ascii?Q?3k1NQk5taC7DFtkwAHibYFOszDERyMapNuzZ2kxBtOh1uiq2sRgwVCyTLbRY?=
 =?us-ascii?Q?nN30DRJxoRY2l6J4Xn+dA2QNPvKtOYi4ryFu4oJZDER2W4IT8IpH+EoViNH2?=
 =?us-ascii?Q?QehQ8cRnizDpswtztuV1JF8D5ifr3NobWwLR4GF1oDfaE5PxpDSSdJv7vupQ?=
 =?us-ascii?Q?fJe3gi4TZ9tRWq8QyQhyTtxSgQmZAJDXe5N/4qbVmcUqS494d3taO7kpCza9?=
 =?us-ascii?Q?tQ+7rd6P1xMaAvr67pt1fwTuZNtDdG3pWvP/p6QJmIXOqkAHpzcFSW9J1LOA?=
 =?us-ascii?Q?gf1FYHsRE5Wn+8IFZKjiNJxQHB59E/mBHilscpnXoVgstub1sdknIEGslH7N?=
 =?us-ascii?Q?PgpdwZr3/uzsSO1mTuN8p2Sgh58bZk76ZzQoQ2uRmsBkd9MipLE2QUMt8kQF?=
 =?us-ascii?Q?/4T6R1wMFAPXVR9tLrk4T+cIBeIrESFJkJkfJRFSAa7JI/7ZHFyU1NATDKgK?=
 =?us-ascii?Q?br6ISl4/dgxy7mimsbrRH3GV8RA6wWwYla8mU/T6WAmROkH2MUNGvhkNmsem?=
 =?us-ascii?Q?bIakFUNW9phb5j9heJxzVit7Q+6yvkpiUBRxf/1Zcm/0CX4zDTdSMUbn1Rtj?=
 =?us-ascii?Q?KfyCUUDFarI6Wxe1vkkT4Wo8hW5xcK0PFx9w4CbQnAmMq17+nFzC4+I9Wh18?=
 =?us-ascii?Q?slDYbjn87IOx9OY/FJ/rF6dUz8rIHLdN3cyAw/NruTtIHnKU3JMIE5sKHZM7?=
 =?us-ascii?Q?iDJhEePA4DRwfPxwjGinPcROgyLyYi6qDEWbvLgRvOuZ30cJm+f0shRG/Bbp?=
 =?us-ascii?Q?+YOTiz7C4Cf/9Qmf9/zhcDjec8QxKIwsb92ZZkQGWmM/wFEdgMTujkrtvIhH?=
 =?us-ascii?Q?Qj+F5Lf47nGzqhzKW4xUk2QdYEEZOKD9hvbUf6xQ3hfZAyiOQdwOZCVL2i72?=
 =?us-ascii?Q?ZacX7OFIGUXz52LBDx+Mu9edawcPH0VaGv05XWZOHEtzuzLHZY4dVBVlAVvs?=
 =?us-ascii?Q?ELuWkiSIgjRCUclK4R1w/rgC4sw8OS3IY1cqb1SypxIbLcXYeuPwsj+YlwOw?=
 =?us-ascii?Q?Gbgp3y4G3pBZPMKo7ixR3DRNA/iouFFWT9xQT+ZwdcDKECkygpRdoXD5QPPk?=
 =?us-ascii?Q?iZ/s6syNTW8Np46+qvIiMyF0E6w3+j8Wibm4wD84DBnSZqqrGAjBP6zzczIN?=
 =?us-ascii?Q?8LV8H+yuUF4Xv0fKc9igIfbuGUQ+r8lzXCOoINyOBWAgawxhHpke6t+z/g/y?=
 =?us-ascii?Q?JtJi9+rcBGkgCM2YPQTl/J7qaWhn9ludzqyQyBfGMBqViwEY6OzMWmLlxswy?=
 =?us-ascii?Q?gzWL/lI3C0M6dUkiK+KEIpR5HolFoznpm8pobiXSLGytq8iZ5AFAZFc8Ts2d?=
 =?us-ascii?Q?VhGS9SURga53AUECA1RI9MXaBS8PDJEkEstiDVfjKW0amaoHGutZglMrCu2L?=
 =?us-ascii?Q?lFEEmbEvqA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd421856-9945-46ef-7639-08deb63aed3b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:14.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbsDjdwmhe4gXa3625O5wmB+V0lg4dwIbf31m03H5YHf0ucpeS5GO7JeShOhv8N7ccGAH83sbnVOHfirjcI91A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289782-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: C1E7D5884D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported that the PF driver accepts arbitrary MAC address from
from VF mailbox messages without proper validation, creating a security
vulnerability [1].

In enetc_msg_pf_set_vf_primary_mac_addr(), the MAC address is extracted
directly from the message buffer (cmd->mac.sa_data) and programmed into
hardware via pf->ops->set_si_primary_mac() without any validity checks.
A malicious VF can configure a multicast, broadcast, or all-zero MAC
address. Therefore, a validation to check the MAC address provided by VF
is required.

However, simply checking the MAC address is not enough, because it also
has the potential TOCTOU race [2]: The code reads the MAC address from
the DMA buffer to validate it via is_valid_ether_addr(), if validation
passes, reads the same DMA buffer a second time when calling
enetc_pf_set_primary_mac_addr() to program the hardware. A malicious VF
can exploit this window by overwriting the MAC address in the DMA buffer
between the validation check and the hardware programming, bypassing the
validation entirely.

Therefore, allocate a local buffer in enetc_msg_handle_rxmsg() and copy
the message content from the DMA buffer via memcpy() before processing.
This ensures the PF operates on a stable snapshot that the VF cannot
modify.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Link: https://sashiko.dev/#/patchset/20260513103021.2190593-1-wei.fang%40nxp.com #2
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index dea3a92c4722..09c642040892 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -478,21 +478,24 @@ static void enetc_configure_port(struct enetc_pf *pf)
 
 /* Messaging */
 static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id)
+						int vf_id, void *msg)
 {
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct enetc_msg_cmd_set_primary_mac *cmd = msg;
 	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id;
+	u16 cmd_id = cmd->header.id;
 	char *addr;
 
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
-	cmd_id = cmd->header.id;
 	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
 		return ENETC_MSG_CMD_STATUS_FAIL;
 
 	addr = cmd->mac.sa_data;
+	if (!is_valid_ether_addr(addr)) {
+		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
+				    vf_id);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
@@ -507,17 +510,33 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 {
-	struct enetc_msg_swbd *msg = &pf->rxmsg[vf_id];
+	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
 	struct device *dev = &pf->si->pdev->dev;
 	struct enetc_msg_cmd_header *cmd_hdr;
 	u16 cmd_type;
+	u8 *msg;
 
-	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
+	msg = kzalloc_objs(*msg, msg_swbd->size);
+	if (!msg) {
+		dev_err_ratelimited(dev,
+				    "Failed to allocate message buffer\n");
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
+		return;
+	}
+
+	/* Currently, only ENETC_MSG_CMD_MNG_MAC command is supported, so
+	 * only sizeof(struct enetc_msg_cmd_set_primary_mac) bytes need to
+	 * be copied. This data already includes the cmd_type field, so it
+	 * can correctly return an error code.
+	 */
+	memcpy(msg, msg_swbd->vaddr,
+	       sizeof(struct enetc_msg_cmd_set_primary_mac));
+	cmd_hdr = (struct enetc_msg_cmd_header *)msg;
 	cmd_type = cmd_hdr->type;
 
 	switch (cmd_type) {
 	case ENETC_MSG_CMD_MNG_MAC:
-		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
+		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id, msg);
 		break;
 	default:
 		*status = ENETC_MSG_CMD_STATUS_FAIL;
@@ -525,6 +544,8 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 				    "command not supported (cmd_type: 0x%x)\n",
 				    cmd_type);
 	}
+
+	kfree(msg);
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.34.1


