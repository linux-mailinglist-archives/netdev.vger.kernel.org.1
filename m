Return-Path: <netdev+bounces-286520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MENJEVOWAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF750A3DE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91B53061EA1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C633BE154;
	Mon, 11 May 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRpUEhqA"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BB3BAD84;
	Mon, 11 May 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488525; cv=fail; b=umJ/zVm/kDdaP4TL2IFCzp65v61Ny7mymfzowCudH4pfW4W+p8J5rVy63tTG83ieLCg2nhRbGRChYbGZFUn27KicFTue7vF9lS1tHmudJHzDuzfcezlyK0MCVThQfR/6r0eY4nFTT33eKBqZj+AttVaFgRyw3s+TYbMikooU3Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488525; c=relaxed/simple;
	bh=3r0sQPb9zRd0urF8OwsOi8XwmsoBpzP/3fDfRVUf5/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qqq50gikVdyRG/jboA+cMqKG32d/QsCwvgx4bYqvbWbpOlCIYNvrZUR0LZWi3REmZ/ocIhXDA2QEnFJNc1hsby5EQ+8NCxe0K4SV7j+d0P7YDpz9anSk2jbYVKohx08UCTqRi9psVv6lYjpLDPjxqandPbYTUM7k8ekICOfhv3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GRpUEhqA; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSylOwU1BPvyRPck0N5ma/TX1IaKyDRb42Xl6nmkxxGkQyJ+0SaWhQ1C2FbQrebRUfJK7FDmpl7nxtgppV2GZsqzfylmOotMuc1yVEL/YQeATy2F9Eobq9L9bruMKh2ZkqPShkcOnFi0t143DrC4OVuAIWVSyM5DwJzrBLCHw5aygczHQL2y9KKsGxSDafL2DnBiyvH4SDGUWky9vi26kxX4/R/b1xzC3nHUo6A2ZUCiy7vVbW6an9QeRmY/2rOaLsBLGaQQBxcf0UpVrQaY3TZdtmIV+GD4HNoEkYcPfjMHIAwxFH17KzOQX/3MiDQPm8qQUJ+Y3VbkNZu9nVXiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7Iki0SDTlMjDWNYpjMG3i8D+tbJFX/X5xADvC4jBTI=;
 b=j8pA/7Y5PxvHzFvf52uR2cP2o1tv6SCcqLsSzkmKbQh+i0NBEgD0NZ0mCWj7vH6Zll0aa67fwIk4wnCebO9T79AkZiIOyeEV2s+Nk1tcQRY+r4Cst/q8cYXTa7CKmeUP6+iZU5qyFODwnBRn5g4S7FhTWJzdDKTsKHIdvHh8WecsiSNc6/kw2PIuCWkrEogELDrys6887+WI8IayXCVKCz06h9yyaa/FwGxnd68c+O1ddz/RArxp5ON0EndVz7Bv3GLoyyyxKbI1cAn/BkXDpjGiEjQq2F35QnnPQepSusI3YRKmeCGk93ID9T+TwkBZTQW5mPfWKV/GJ8vm6qTiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7Iki0SDTlMjDWNYpjMG3i8D+tbJFX/X5xADvC4jBTI=;
 b=GRpUEhqAn0LZT6QZ8hiB2xLsnod9XvLt1V+3hv+9zEGcnImUrN162JEwyC7R1/XtpeIpOOTSAuFekEhuvEsKgE/39pxf8JJhUtz4o4ChMVzE8vAOS2lRONv0l9SHyNLM+o0GMMANpSa/zFcM+fppPNIykLWGgBPAOdSgYolAu+jObk4klwnSzanvel8yRS8tpx3icpEl8PyDIU8GfjtBLoGt1ChjwODwlKavX+98SRntGsSII8gigNXCjGox3SD5j3kLjdTTFITOtaFrMFVjV5dCCYw+ps4Z+nPL/nJnnaHkumpPqAGNbcDlK0lXrTAGGx8NPBSGCKab78Q6B1Dcnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:52 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/15] net: enetc: relocate SR-IOV configuration helper for common PF support
Date: Mon, 11 May 2026 16:07:54 +0800
Message-Id: <20260511080805.2052495-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: c676c376-4196-4ca0-9945-08deaf382be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r0y505V91l4xi6cxPJvlUeyKkLGrV6QeXGdubB4PhZbRBY2hSkdx8FcDwSovxnvyju4zaQnb+0qL4TTZqyTXl5TNOA9hHXujUQSsswZLM7zq7z9dPGQPfxND96pJ80Uace7Fc6J1a3UNXq6H4bvX36N0Ogd3+vvuHrOHnn6Ro3+11um7DxdXNRlPByEU/LikYI9zAYfco/QJXZKqk+HF7hUIJk0BSqyRbvrUQn3uYTuyD8LKlghEjtcuU6Ep4c5E1SOK7HyN0vPSk3a1aAAyFVIhHl7i2dRUnAnpw4fTKPoPMyi3oqbEGFqx7u9+YQ5Z3quok5jntCfVFWF2JsrH0sNzBMIXg28muwAEPhFbQvi0x+31cN5FOaX8/dcSnEXDyVDtsyQKYiy55mo93Njjom6c3DJuQgMvdqxb4q876UTN0pHaeuCYjLNQSe87OzyWt/QqbOha7AQ8YLNYQmypJfQV8SyuyGgwapApelPOUxFroJuXDrCAds8D7bkyMunoPac6MnfMSabj7mC08hB9N35nzGXKTuSrrJ25eY0u/w0siNE3505xXJy3TyzdfFHJBit7rhpr3+4J9ilHvN4CdKG1BE6THy/Zw02TsTg9guVM1rJgGr5AOZ0WPcgB9lDmNY87WHxn+edjKM9SkRQSDfFi01/5F2RBBP3INjeoA6g/0kaiGfTopv0ccmGuvJT30WpjbfqAoQPMH+gSWD3IfJt+iNk0jrZd95h9Lkf5DLyjvg412zIdeSbTTZRg+bl4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wI99AfVDhdqdFus95eweztVqk/5e+sV3p/RYgptd4yQ/vT3uVzIDn31mXVdO?=
 =?us-ascii?Q?lyHxIovXb907vvS22RnJ4L+zf6nR4gErWltqxCWegNg0o8OxuIGjfnyaZhEz?=
 =?us-ascii?Q?VxU3KQQ9WQ0ccHpWzAgQxUwM9f6XKccYze8j+iwrqJaf6W8XREq9jFYl6D+U?=
 =?us-ascii?Q?A6bdHqAmhiDGg4xN1D/jbCIfF/Y3jY1RlVIYYQHEzzssW+kGUGDx2c9YGTn1?=
 =?us-ascii?Q?nayNihRaZlNbv/EUtLce8IFFzOcw1BOv97impGxan0Syx6loSxnZa9J2/297?=
 =?us-ascii?Q?DkVqrFTUMAlHnq3lwx0VcjHLKslJQUUgVtAeZIqklKKuEy0OTjkTcjpuF5St?=
 =?us-ascii?Q?cLm+cYwhdYpVQAU3hN6vV5swd0LTtyhoTqN33TOZBgSl10Xf9tqXaYOwHI0d?=
 =?us-ascii?Q?XzIx1ifFsT62hX5po6BhBc/+miZbJdN/jNsEBeR8aixmDhKuGJ0/TtN1+/nX?=
 =?us-ascii?Q?hKrVx0IUQ+FNGuPT9Dl7/Y6L7gC5YnSobUl2/JYb1nXSbmhcCaVr+VaPSa/L?=
 =?us-ascii?Q?LRTCzO2ViR2kSXPxXNfcplT3Lt2XyNka4UpgIRAoG30TpITz1RGdc09FJOoG?=
 =?us-ascii?Q?YEiNRSfqlw3XbDHq10B0bHnPDbNlWfWAraPJFQNDyWwAyE9J4ZBUxj0KObpr?=
 =?us-ascii?Q?vApok9f+8Srzs80pb9xrPaHHK5zX0/t2mAxgI77A41XFpN0geuboEzxDFR+p?=
 =?us-ascii?Q?VOJ8XN0+XTAxprAYO6crAZh7jH4Gj1gkcqGQw9WqgR0lMSCI8PHET/06idgg?=
 =?us-ascii?Q?0tDzXUypG2aYT7iqJ3WMSLt4eWDMdkZQ4qYgZyf+QZY+Q5sCSAehdauAaIz8?=
 =?us-ascii?Q?mk2CTrNTUUmRMVefsWXZSz0rXjqbGB9t8O2LCYHdMUd1QNcnwHVU/Szabhqh?=
 =?us-ascii?Q?+SN+BlnbBHJVWU2el5tVgKbn+Jv7w+RKXvE+EHGA4uEZsmgK4u2jwQXbGd6f?=
 =?us-ascii?Q?+xeZMSxUvZCgeOC0CWpHLIMtDUtj1lVi+nSkVG1XpngVRSAsEW8YFcSItAr7?=
 =?us-ascii?Q?hgzkecooGI3QAIwRrhSvfQdTMj/a8g7O6ZOXcqH7DIFW/mL8ro0/kmYBvBEW?=
 =?us-ascii?Q?mByJsCIyA6faFzWs4+8ret73IAdYlwXoShItPaLX4igNlKJTBnM2MQ0XpRz+?=
 =?us-ascii?Q?boX5pUrLNODTOHGaLVCqn1ySWLQnxZ2lSYUjFRHCsAvUyDZj8/g1u5AwymLy?=
 =?us-ascii?Q?5OG5p66lGAEjPYxoPZIUldXGyyg2eW3htpnEfeYrX+026BNslJy0zIpNvxdy?=
 =?us-ascii?Q?tNAoQ0ZMr75OB2VOo9kCUPLbS/G1ljPBmLooO8r1t29pM5pwF1r56dRp2xuE?=
 =?us-ascii?Q?Xr3fHX3iN4Buh81eF8u7FwsYzRrWPqTYS0VL6sHVouBpNE/NSwTGiunZ6kDE?=
 =?us-ascii?Q?BaOFhX8m6epX5BmJt5lxYvLinozzv8S4C+J3/FvifiR/SVtS8WVZJGYAjNq0?=
 =?us-ascii?Q?Z9CA9zQcBU8mBzrrDbg9OH3y/ORDE5EXZ4h/qOOktcyzOLZbE1AsTEm9oFAH?=
 =?us-ascii?Q?WW+R2qYINS+dsYrhfOf5GI0VldWk8O4Xe3J2+bW/FAz3uAcRVnhaYtv1bh1G?=
 =?us-ascii?Q?byGnB74Pj4kuUMI8bgYjcZ9PueN29JPbBz4q6qp4+9KrmGsE4MgYMVSs1gF3?=
 =?us-ascii?Q?eU3bDkGHWt2BfnyfrjkmO5pCubDB+f8JO++1m2miXSPa5bUd8Lnmba8YVhUj?=
 =?us-ascii?Q?axZ1U8Td0xcKrrUQlptcEjrbSxSUH2vV+GqlvSNV4wPo50vZZIdC2avm11c2?=
 =?us-ascii?Q?HCJ5xYS77w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c676c376-4196-4ca0-9945-08deaf382be8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:52.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qV4kVc0BvdlCd7hR+Qv2OsBc0HKLYEfYjeELVWvE0LexlZRTM554KV7IeLXyV08z0Ywo8otwMo4l9gj59MTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: A1CF750A3DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286520-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Move enetc_sriov_configure() from enetc_pf.c to enetc_msg.c to prepare
for integrating enetc_msg.c into the enetc-pf-common driver, where it
will be shared between ENETC v1 and v4 PF drivers.

Since enetc_msg_psi_init() and enetc_msg_psi_free() are now only called
from enetc_sriov_configure() within the same file, make them static.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 40 ++++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 40 -------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 10 ++++-
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 81d1b87055a3..6f7927f40bea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -151,7 +151,7 @@ static void enetc_msg_free_mbx(struct enetc_si *si, int idx)
 	enetc_wr(hw, ENETC_PSIVMSGRCVAR1(idx), 0);
 }
 
-int enetc_msg_psi_init(struct enetc_pf *pf)
+static int enetc_msg_psi_init(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
 	int vector, i, err;
@@ -193,7 +193,7 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	return err;
 }
 
-void enetc_msg_psi_free(struct enetc_pf *pf)
+static void enetc_msg_psi_free(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
 	int i;
@@ -209,3 +209,39 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 }
+
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
+
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		enetc_msg_psi_free(pf);
+		pf->num_vfs = 0;
+	} else {
+		pf->num_vfs = num_vfs;
+
+		err = enetc_msg_psi_init(pf);
+		if (err) {
+			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
+			goto err_msg_psi;
+		}
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
+			goto err_en_sriov;
+		}
+	}
+
+	return num_vfs;
+
+err_en_sriov:
+	enetc_msg_psi_free(pf);
+err_msg_psi:
+	pf->num_vfs = 0;
+
+	return err;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 3ebc48c3fdf3..fea5cb6a1662 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -476,46 +476,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
 }
 
-#ifdef CONFIG_PCI_IOV
-static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
-{
-	struct enetc_si *si = pci_get_drvdata(pdev);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	int err;
-
-	if (!num_vfs) {
-		pci_disable_sriov(pdev);
-		enetc_msg_psi_free(pf);
-		pf->num_vfs = 0;
-	} else {
-		pf->num_vfs = num_vfs;
-
-		err = enetc_msg_psi_init(pf);
-		if (err) {
-			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
-			goto err_msg_psi;
-		}
-
-		err = pci_enable_sriov(pdev, num_vfs);
-		if (err) {
-			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
-			goto err_en_sriov;
-		}
-	}
-
-	return num_vfs;
-
-err_en_sriov:
-	enetc_msg_psi_free(pf);
-err_msg_psi:
-	pf->num_vfs = 0;
-
-	return err;
-}
-#else
-#define enetc_sriov_configure(pdev, num_vfs)	(void)0
-#endif
-
 static int enetc_pf_set_features(struct net_device *ndev,
 				 netdev_features_t features)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 84f8b58a18f2..44cfb7bdd7e8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -68,5 +68,11 @@ struct enetc_pf {
 #define phylink_to_enetc_pf(config) \
 	container_of((config), struct enetc_pf, phylink_config)
 
-int enetc_msg_psi_init(struct enetc_pf *pf);
-void enetc_msg_psi_free(struct enetc_pf *pf);
+#if IS_ENABLED(CONFIG_PCI_IOV)
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+#else
+static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	return 0;
+}
+#endif
-- 
2.34.1


