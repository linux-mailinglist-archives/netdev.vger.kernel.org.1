Return-Path: <netdev+bounces-289778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdRAzdZDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EB75885C6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEAFE306A147
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F633F588;
	Wed, 20 May 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S/2VN8ll"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AC3382E1;
	Wed, 20 May 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259323; cv=fail; b=OPS0X+mfDVEpwj9diqv4aFvLutzB2J0R8O3VYI6bLVJLKaVqe/1C6VCcdmPRJb6Bx52Zcj7ztU7FxO1PXu8h0aQX3GzPT+yuC36CHvLqIH3IYZgwKtbSlKl6tP5pl3ASJcG7Ka1vswolHFreXq774F/br/p/AGqgktCkNEzj32g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259323; c=relaxed/simple;
	bh=He1kNZXX0xdzdOCodq5TP/ePNBEAMyvI8vXB9IIInvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjDuzuYBWM/NyAv/WoGa9OvN2znasKUi4K0+E9Dw2qOCCVWtHtcxpPZXY0SmmgKy1HKMoy302ls/kso4t9v4zyf7SIIUdAT2bL5TJUjFaY05mAuNvR2nKCI5Y/SvDkUua6Ge9iwpmX74eiA6aeaHZpKh/BHflvAeJZtaEN7eowI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S/2VN8ll; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilu/jtyz7JVg2ITw2AcF56p8Bcdsmu9s3i5kjXyXYgGBeC6pgOQqq9972/164p6/Tyy6wl80kiXQYxBTPTb5uI0DC9hUX0z/HNRkpvSJNQN2gD0zBmGrK9ELCuiR3SLBXWUA+IVYT5p3U7+x6bOEDj7+5763BwQnS1YduEHu1RQoT6EYOO5Wn0R6E476zlIz0Zj0tZstggvL51gtJL6mavlF56JlmTdnp68rNFHzA+fPrpIWjNSUic4/GbogMDTvVyQRyNun6p4eRTIa/C0djrKTW4A+UqMMoUmwHW0jwt9r/yaGuRck1hZhwt/rwu6JT6PFVgdfvucMc5vGJlFVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVqgsefxxXI540L9+tayJuEVaxuUc4DTS1lwbr9pppg=;
 b=XOm6QeLwstzK2u5cxVneiwxt6h4qCok0Vup2M6KmuCLfQGm1o3TI8VQuMPqh3441/519H7/E/5s+LQhC7iVawJx+Et4HPcxuIT9Cx2iTujL/ngmA8GUMQ06HSd9flA8rQMfHYJVTGGiphDYpp/Upr4ov3qfJ3AGRz71MuVcty8s0TFd25RqYQfi5iNAAknhKQV2CqTaZNrWKJQSpPoL+OGDkPosHDTCGblIFbqdJEOC+Au5Vq6/0M5+paBl4xNCvwLCdFcOawMw2n1J00js+AlaxzBuXiYyasYcc5mueweEr7lczzW5+M2Hfpvip1c7i/76XjamKqX9I3oV58LBJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVqgsefxxXI540L9+tayJuEVaxuUc4DTS1lwbr9pppg=;
 b=S/2VN8llTuMXHP7vxCXiPUEEjaoAa7v4qon+UA1vvUTPa5Xn3rBLQwbhvyVXnzVWtL1PrxWuZ/TmlwFaLjAWnkbGWnsc/q6xanPtSSiWBCBw8R5livodnRSo4xotWx72zxdteGwzXwdu/iQhC8BfvI+0SeJnnbnd/EoKPrsENUR7Wm0JNOb7C2fXAFmf4/JVFmauH8vfJmA/WCzcg2SkYXTgigNz4Kk2MHQJULCqsQjIxGpO/VwyZ/XQq280tSZnAV6AIJljzb3QK231zFQ5h0NkrsTB9s4aWfJWH7u/4TJYEkWR+OEtq+KZgYD3UISDcMAIstozcFm2PPpBorwj7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:41:58 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:41:58 +0000
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
Subject: [PATCH v3 net 1/9] net: enetc: fix incorrect mailbox message status returned to VFs
Date: Wed, 20 May 2026 14:44:13 +0800
Message-Id: <20260520064421.91569-2-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: b21f2718-54b8-405b-7cea-08deb63ae3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|22082099003|56012099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	lU7xmPcFQiTVRU46tFF1GhbvzYF2SuDaYFWRjwv3mvTC/kpAIrWNhonX0/wsUoJOdsoyFUNstCnjqSXfrT/nHLWPhWSeiY3oF7N5Ljr7k/5v/djN/RhZ7Z/2zHC/92DojPjp6NaaKYf2zvJjLo/blCQbP7uzJZ86EbQq3CshjxADPsfTh+cxMwjxrJVoRASNsAQpV/kjrxTKtInuQJq/XChELHwMPFQLZz6OpXV8J27QU/megDAKtqXGdi6dPS3FhjHVAUGnJeAYPr3QyCaWiI9CUvYn61zS6NJLghzl4mtb29lA37sM5yiNVPAWLbPJG4+r/1lluBL5Aclea4kkR2H0poZk3GEoYuLbssMjh5hUotp3l6smWmBFKslEf/KpD61JvyiyhW4jW5zzLiLRDwWOC0+R4f+CjEUvHyqwaF9Q6pujUEL/ene6+q24qc1bUU39rJSSXWxKYCdZdoArdikGWNMWCgGuFunh0fyKzh6Bn3VE+ca74+WlkQmlI2dGWLj4SnQAnsUtzRpooo5BvDr+mWG09D2TODLpi/SX/ZGUJM7FL+LBv/nwhS1z3g2OlAQQJmDZrF4W/iO9/hebAY9H+9uhMbhaWrVm1dHvbQbV7FyDqPmeDJHMUhncbYsrrp/FCULxAmvYjGIcA0qE+B5t6577SiD2z16rrpqrsdRHR3eWB54oSYk3RBXI+XuXzmf/14v2cKXKvOo9e8g6bYkHmWJ8p1dkjs6D1oy7vrp9UkrKJKOcfkAcxOB1S/cP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKtmm667FmO/z531Ji2zs2F/Mv6OIiXLzjhQr78JooLOImt2/iOGzR4DyYGw?=
 =?us-ascii?Q?6KbczybHiFyrIQRj/gf9tDxNuM4RqISzrGEA8IpYypIYPckueeEi3WMFyj4G?=
 =?us-ascii?Q?BnRPqpe4CfzbBQveWdgqKDOwksOeLgMgD2bQ1jkm4vxfh7uNDi1/DhXj3r7X?=
 =?us-ascii?Q?JpEKQu2AWLbyf9VSlDaFwKDh8iz98bX3p+0PN8XZ+Xe/Vlw8NRBSWlfOzgx9?=
 =?us-ascii?Q?8gJRoBDfmqJjHWzXW7IpeRmU8GfYckUxlLaHp9cqB0TVosUnZoLvcpITOjlX?=
 =?us-ascii?Q?rwhtrLrL5RtJVVAjMTU1eQdQtXzVok5M+9HxXk+zXHhsHo2NBvHe2Q99oPSq?=
 =?us-ascii?Q?729NW2aaT/hzKvs7u1boIMJQZ9+4edUdTxSs6GXKFuD8mB+u6vZf+bt/KNOM?=
 =?us-ascii?Q?sbvM0eeG8y4XgaOCTO2Ik2rjky7XHGQyc7QGGyg0ecQL+0XezaSkxgQQ+M3R?=
 =?us-ascii?Q?J0mLrgUAEa1yKWmANd2z5rNY2notUwt4MybztZkG/CRWUcsuvJh0DCrITppD?=
 =?us-ascii?Q?zeSskBzTKBpXOWJkW8UyvP44P4vSO3YcZqOrZLDZh2wkYXTGib68zPel2KuZ?=
 =?us-ascii?Q?vv2T5g4f1uf5EQ1L9yf4LeufZWJmNNnF8+5fYfZtR6VVrQ0GwBJjBFNOCT/t?=
 =?us-ascii?Q?RDZturxUfQa0bvrnQdT6JHPUVZHPc611VFCy6bqasNoYySPcXP6oJC+/timp?=
 =?us-ascii?Q?KmCxGnk6cUMRzfTP6qfR9TvwWIM0H3Aeh0Uhw8pgZ/AgqwEVufvobp8DHUAS?=
 =?us-ascii?Q?oCx9TZzUo/wabbPmSdnLavDuyNJiA9Q6QKto9rT9vh4bG7AsupVoW1Dn8A9w?=
 =?us-ascii?Q?gkJJYJaZCcAwjGsJAgxn4F6lVYTKVt1UOgwBn+RqZuZh+EM5AOcKY+AJ45JX?=
 =?us-ascii?Q?JunwjdQDFcl3bfTgwPaoXjP/M9ODOzcShq/3GJNsAn19AxrXEDUZSMN7Vibd?=
 =?us-ascii?Q?P0gaaHKsku8u9DPhRrq6yVjgRIIDgX9Iku+ynYDqQqR8ED32jQdUohHHhZty?=
 =?us-ascii?Q?nKOCQzHC+3EOBvZRWCg4IqKbox/NRwVumJcwuTk4GsNSBs9nCKjiVRupOvrq?=
 =?us-ascii?Q?n0jzY9Q21PvwsNKZnuHE/Heg1PsjssCtopcrpN1G0R27w1HaCDJ6wgNR4pgJ?=
 =?us-ascii?Q?iR8F8FOF4A1d38XEmPv7ZcP8a88B/iqhgmPMkFBzt9INEBspOCv14Gl75FC8?=
 =?us-ascii?Q?/VEViNoKg5EsxaQCO2a4UcpUMbEiScWYFPDEkDihSV+8slt48YQJ+9nbNW1V?=
 =?us-ascii?Q?MAYxI3JEqkfeRViaWnLphZE3boWCLB5OYqocOBGw3mKlka7JgYCw3MNDXtiW?=
 =?us-ascii?Q?4b+g1S/+TLId9bjBCM3V9niAKVCJklpXCIf40NLE5VUCk38kcqplV0DFvFaO?=
 =?us-ascii?Q?TENDeq5X4FQUQ2va7le4BpNd/mySQBnG1tLgCDIB5YhWK2g6EINW/4U6mEus?=
 =?us-ascii?Q?QAlIAtrFvHnFdHuzHc7EDGWsMgB241/5h6rIYhZ//m3/CWGVpyRFbC+aN+l9?=
 =?us-ascii?Q?9md8aQJoeB6w4AD1sLaiPiue1cVz8Xe/mINvjiS9ggPQQh/8ywx8CkoVUleS?=
 =?us-ascii?Q?ry4h0ExSVIDJiEZBc1z2G8HiNthvKV0mHUxIpgkUIHtk0khyS/N8WCLZb1LA?=
 =?us-ascii?Q?BQ2YNP/TTe3Wrg1AHqRj5LiAU899DiFNCp+WJnk9Sau4B4I8t/XVDnCUit9e?=
 =?us-ascii?Q?AHUdxXNFYbjGrEK6z7qOXqelTO3mHWH9QKHlcJIj0Rfoyg4HdeyStV6vVOSD?=
 =?us-ascii?Q?BPIQhWZJPg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21f2718-54b8-405b-7cea-08deb63ae3f9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:41:58.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67IwOrSf7m6VZobvS4hn0ZzYufxgYrDiIsHBeWuSMxgKpXmxapBQAzJWP15S+k+VwAAThREfbAO/1rYUolBy8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289778-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 82EB75885C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are two cases where VFs receive an incorrect success status from
the PF mailbox message handler, misleading them into believing their
requests have been fulfilled:

In enetc_msg_handle_rxmsg(), *status is pre-initialized to
ENETC_MSG_CMD_STATUS_OK. When an unsupported command type is received,
the default case only logs an error without updating *status, so it
remains as ENETC_MSG_CMD_STATUS_OK.

In enetc_msg_pf_set_vf_primary_mac_addr(), when the PF has already
assigned a MAC address for the VF (ENETC_VF_FLAG_PF_SET_MAC is set),
the function rejects the request but returns ENETC_MSG_CMD_STATUS_OK
instead of ENETC_MSG_CMD_STATUS_FAIL.

Therefore, correct the status value for the two cases mentioned above.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a12fd54a475f..27d4bb65e017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -493,11 +493,13 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 
 	addr = cmd->mac.sa_data;
-	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC)
+	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
-	else
-		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
+	enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
 
 	return ENETC_MSG_CMD_STATUS_OK;
 }
@@ -509,7 +511,6 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 	struct enetc_msg_cmd_header *cmd_hdr;
 	u16 cmd_type;
 
-	*status = ENETC_MSG_CMD_STATUS_OK;
 	cmd_hdr = (struct enetc_msg_cmd_header *)msg->vaddr;
 	cmd_type = cmd_hdr->type;
 
@@ -518,6 +519,7 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id);
 		break;
 	default:
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
 		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
 			cmd_type);
 	}
-- 
2.34.1


