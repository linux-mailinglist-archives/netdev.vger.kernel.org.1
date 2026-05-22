Return-Path: <netdev+bounces-290743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAv+Lh8iEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC25B132F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 804D13041FC3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DECB3BE643;
	Fri, 22 May 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CxeIXYzk"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30113C8C75;
	Fri, 22 May 2026 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441767; cv=fail; b=t35Luc2OhFE28XP1PY3+iS/XKk/rrQQ/Zb6x9kYwhB1hWH28B1LASb2bhQUaTsRMROA3drcRnOw0R8JPwBPpNdutvKllYHs1DsH4tWXkd9wUwCEmzVRW8McZh9Mjm+oC+dG89sFmG1Yhwj+JW8F0XG1I0nFjAdmEbajlVkqPvGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441767; c=relaxed/simple;
	bh=TczaNhjQEDtF5RWbyLBtBMViADyzYv0LlQ6nJtxXpXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knUXbSLeaUVT8rwWJiaZPDXlKA7592l3gtevyxk7gH3rqLyDE3LguCknjAcoDRfzvr1rF+c+pvxNZeyHSDnMt/jF9xo80TcKGE63EsOZG/Wcaprs2NkGmU69PJVubFjsF5o8W9qmwj5IeMDFVahkzn6dTS2bPyJVB13nb89fMns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CxeIXYzk; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLDFq3TfYJnfDK6Oor/A+Y37cK7fQSU4bbGtNX6IHAJzNlHb4lfaBbZsTP84/ng+al7tAuzSVUBi7mEhfTgV0dhMUqWkbYw2kDuCVBc5AHsdSpQgFn2HxC10yJ6Xh7ZGJuTSgmLAiqLpPR0yvNVU/w+7nC0LAHYIaDOquq2IiefwwhvvMqulv7+nC7T718y/NiW12l0qPaxHx/qDH+qwiKa8b+6QARDogrd+RMVBnFmiUgVR4/EOOrBYkxPkaFuzPs15K+E+OdEwkgrjSW2XWYg9NHic/ZocBinZd49RKFxadMymsUnRz1nxslPSpVdYkibbjQGZsySuFrIaOHB+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdEmCcYFpKqSiMJBZv2+JDQ4MvPuWiZkuA3gazvrtFg=;
 b=EzsrJMxOXcNmZsIRiW7WLDTmYSGZA3ggppXzuZuatxx23NrFwmhp0oTWpfU5b0/zySctn6baUts3rrBi+ZQYQ+SMddoXNC1B5y3GqmTI/utLdt2entUZyPTWnhnoaTQ+a4pD5jT+FobnYzz/QmQ+RbrfDoRCs/1gn8GejlGrOnawDx6YCl+e77rgBupCp3ALDyd79DSvrZBekgO5NQlbVq4fw/QpnNKso4boNsIerjkg65IqyP+XEN35YkZnk1vu2N9sf6CNI5QN6o3lb5Stmn7Mr2QjAtfgFaQ3/YzXWEmOtwcmgm52EzlaUZRWPSF6AFdXOlsn32XzlShUn6rJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdEmCcYFpKqSiMJBZv2+JDQ4MvPuWiZkuA3gazvrtFg=;
 b=CxeIXYzkrEtJUPtvmOKqGFdsUteHOW8bGhdJq6nhrkQknsGnAyY9fH5HjkEcGK4YNAMdKaOOb/HVTxUs+EYuzNZGKiW2oQp9xh7s/B/5cFyyyxEDSad/1QNNPazPhwb0FiM9rGXNghj7CRPAeaOFJJUjNBnrn5B4D3u15wAh0e7g38BZGi9G8CpLf9Riv8Hmiu0ixiuZH+uPmwCEkO5Mz2lqlVO8+pUVtssflr2Ja5oPLQ+3KuPdyXJqYNGQF+5cNSQngjDPqnkokAuvQbm60rGhAIJjrsNRl4VcgffGrSvQBjcr3KDVwFPUK5suS8wpdl0xVkcbeoyClIAV2g4Dfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DUZPR04MB9746.eurprd04.prod.outlook.com (2603:10a6:10:4b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:22:41 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:41 +0000
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
Subject: [PATCH v2 net-next 10/12] net: enetc: add generic helper to initialize SR-IOV resources
Date: Fri, 22 May 2026 17:24:36 +0800
Message-Id: <20260522092438.1264020-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DUZPR04MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cf4aec-d947-4dd3-6865-08deb7e3ac4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|11063799006|38350700014|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xtl2UJvc16K+1BqUkiHW1OQIsGFWISKniDlKH5DjE2w1Zhq1Y91BX1X4ZlIm0oYM8RCgbyZjIN4seZthRIIMMWvbU9Royz3I+/f5S33gUtNpaTpdofZ74Zs9Y5YAOnEOmgfCUFGMNkkzFdsXrFkCbe6K1WFZrVATwmiWeLb3yMDWFoKGnW3zaArUVqHhe0E6wU4Xhav9V29SdpLtbcbTeHMLI/MeX1WNaLDAUXjAFDvye9CWLQbfPxTH7Xl8e2Z+WCveLVVwTap/evCaslAk7e521aldL2OFNPM9lq4haX6m9+TdyyaCHxFTeukI1WTyJ/fqe04ktf/CitRb59WS8g61dknd0L1sOG+FyZ7Tv/DQOsaB1M2y4MfMh18uCkV3CuepcxKTfToSxldcAM1Wxmex1q2wpIi6yIWNB3gOIBDeWuyuVnqOXsbhGUNqD5bALKJRmT1xd+lQanwjA/9ue8IuXrd3PuRdeLnMjgytYf+/JTSslahGYFgdT0zjrP+zLJFPRf5L2M2yrH+Fh/E4ZkvRk69yi5FhyPDufBhi0fj2nyOYmUYwu0J4M6L7iU2BfjlJpfT95x/zfY0pj4qugh2o3p69o2Te3mrlDszjkazWnLwndcM9gOpY5tgynb0wmOVQImHdUThjsKWRJJAc0VtJRws90y869xb3cT2AzLfKPpXaVY4VcJte8QpJ8OMhHyjoce9znVSy/mK5QLBI4YlcLxqEh2UbL8f6b4D3vRsuOVp2Je+7+qqGKn6zAgmy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(11063799006)(38350700014)(6133799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJ2CwD0xCDC1u93C1f/AR+BYwz1eQigWQDBw+MvwotzDdg47U7joHygLVyVK?=
 =?us-ascii?Q?RsvtpGm/OZ1+8q7jCBzm+EVS976xxe8sgvB3NqT0yqImJwKtfyg7npQmNsfI?=
 =?us-ascii?Q?9u33dOKc2+KYflotKwKX3Lfi2siCNHG/oA1Yaz2HoQqjRMHCZyVh67RAgcki?=
 =?us-ascii?Q?Hx5hgqerqch7SeKllEPYRjncvsQGumaGbJhZOxPfOsCBCHP8cwdgPBKBDojO?=
 =?us-ascii?Q?Jw+5qqM04NaykXb8mKpUzgRuqtZK3kGc9S5JHZGSuDfwZbxaVxkQIKQaJoBw?=
 =?us-ascii?Q?LR1l6Cgf7Hg9thLoK+tFHl6nZ0u6F5dcvaoj0fQZzSUdrWrGoIg3HphftYg2?=
 =?us-ascii?Q?nzBbIcb4M+bweqBbTwE5uSdaNHc8qJpy7qoXrXup6BNn0BwQVqkWG+Nz2jhP?=
 =?us-ascii?Q?M3LP4NeqNUYMadXU3dqrII6iOXCWztA+uhajTY4bJ6cmPevMnXCczEpZqKwc?=
 =?us-ascii?Q?/tqMOCMYLeR/zYtZUj6zrlRwaRhcc+zt0wWsYO+a1Sb5r+TKfg8vtj1jTA1S?=
 =?us-ascii?Q?w5d2sbKfu90NSIQNzo+oDkc+uJsHyOO/b7vlqVgo8zKMRcBcp9DkcZTgAzkI?=
 =?us-ascii?Q?vd10MKxoITBYsO6SZQfL1W1YcVPWJsMQIbi6PdM9wZ7+7PduHSgcCghI330Z?=
 =?us-ascii?Q?QWiC41IJQrgXYhrHNeZYfidk6RjD7Cs2aNiquPtysjmpCO3CmZI0/8glr9/O?=
 =?us-ascii?Q?8yzdGlUlPDoyWIrita45gQwBYvpAI3GRdZjEGAHbpdhKIYSgt+w6nFzZSNn3?=
 =?us-ascii?Q?8PuDCTgSd7OaGfdWN/XsOtuwB1NBR2FYrESn3ilSKPu9mF0fQ29cw7pyJ1Fs?=
 =?us-ascii?Q?A7pq4XVyQz3ABaIvg7bcNJ8eLLGfDzoEWraExeUB+w4kvVmZtJ4eRjF7/ySF?=
 =?us-ascii?Q?F/HUHJSwAg1weYu7oIFefRwGmmk5FAJoZgyMylRIGxyqby9KYk6r/3bsxrDm?=
 =?us-ascii?Q?nGricSY2b/GWtORJCe1tURXWYGVkytX5YdYfmVOzb8dEr2Gh3VfayTKPnSaz?=
 =?us-ascii?Q?rCbNTvYahDAeov8WLuGP/1wwAeOFWKZr6SsqrnMDaSThlraN6dn0bc2JsLTa?=
 =?us-ascii?Q?wfrSumMb4fSjJnRHxoNBOU5NUpcLWDiL26MrNF/QcfCoW2bMOzV0N6qVRESz?=
 =?us-ascii?Q?A/SqcersJLuAW3dPECmffBe7wymmqSSjCFWOf8O1s6G3xBJ7hoAzK8qESPSH?=
 =?us-ascii?Q?q/DTGxKD4nzVMeAYSkfXFsPDeirBSdZv0qBHq5NRAB5gqvVwD3HM8sxlQ0jP?=
 =?us-ascii?Q?ufudy7iKrOpfVsJN6k1dhv5H5kenoSG+EQ1vibXkuESlNGLpsz9bXeKVVJ9m?=
 =?us-ascii?Q?Da+YKsASkj5coYVO+y09ruyqyMKBMoETT7n794FpY1zNw4VudwgmzW7XBN3X?=
 =?us-ascii?Q?4q8Er7HA8oTXnkOhx1YmRQjTSD+aD4MNFQV0U/EgE2Gyxi1x+RJfcebdEsQ/?=
 =?us-ascii?Q?4OwnEMM3UyOMIz70Nx6nMLrunpZsZanQ1mxSRkbdV+NVRLY5Nu+zyDUpgUSN?=
 =?us-ascii?Q?+EYLQWGDkj2/5RfgBRrYV19SM7wyK+9eNZMNYuDna+2aEwg7Bvg8kBej2MHE?=
 =?us-ascii?Q?8fElpldU2VsnA9sDiEpXpm5/EO1PZk8tIHTQSmxulsd148BML/A5Xq0IIPp5?=
 =?us-ascii?Q?LFdwuUBN+CR63G++z7AU5RCvnjOS3CiELB456Z03X1EpGCSIPqLFg7k2eL12?=
 =?us-ascii?Q?D/Yjdh0YzoZ+DrEkSbtjJFbb2b+zD87tBpzOuBL+MsuxPK3JTuBj+5frhrBK?=
 =?us-ascii?Q?AyB3f/ZRQA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cf4aec-d947-4dd3-6865-08deb7e3ac4e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:41.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqC1/F21I2p+0/Vyl2jz2K+bzIdU2w7EldSsYpBhqWeAwPD2M9HZUViRVBwdYgzuGNuKesyCqjdkciPBKo3f6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9746
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290743-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: C3AC25B132F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The upcoming ENETC v4 PF driver will support SR-IOV, and its logic for
initializing VF resources is identical to the existing ENETC v1 PF
implementation. To avoid code duplication across PF drivers, factor out
the common SR-IOV initialization logic into the enetc-pf-common driver.

Add enetc_init_sriov_resources() to handle:
- Querying the total number of VFs supported by the device via
  pci_sriov_get_totalvfs()
- Allocating memory for the VF state array (struct enetc_vf_state)

The implementation uses devm_kcalloc() instead of kzalloc() to simplify
memory management. This automatically frees VF state memory when the PF
device is removed, eliminating the need for explicit cleanup in error
and remove paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 20 ++++--------------
 .../freescale/enetc/enetc_pf_common.c         | 21 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 7a5dcbfeb693..2d687bb8c3a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -872,18 +872,9 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf->si = si;
 	pf->ops = &enetc_pf_ops;
 
-	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
-	if (pf->total_vfs) {
-		pf->vf_state = kzalloc_objs(struct enetc_vf_state,
-					    pf->total_vfs);
-		if (!pf->vf_state) {
-			err = -ENOMEM;
-			goto err_alloc_vf_state;
-		}
-
-		for (int i = 0; i < pf->total_vfs; i++)
-			mutex_init(&pf->vf_state[i].lock);
-	}
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		goto err_init_sriov_resources;
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
@@ -961,8 +952,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	free_netdev(ndev);
 err_alloc_netdev:
 err_setup_mac_addresses:
-	kfree(pf->vf_state);
-err_alloc_vf_state:
+err_init_sriov_resources:
 	enetc_psi_destroy(pdev);
 err_psi_create:
 	return err;
@@ -989,8 +979,6 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_si_resources(priv);
 
 	free_netdev(si->ndev);
-	kfree(pf->vf_state);
-
 	enetc_psi_destroy(pdev);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index c30b5f71efd5..c423eed6bc78 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -435,5 +435,26 @@ int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid)
 }
 EXPORT_SYMBOL_GPL(enetc_vlan_rx_del_vid);
 
+int enetc_init_sriov_resources(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+
+	pf->total_vfs = pci_sriov_get_totalvfs(pf->si->pdev);
+	if (!pf->total_vfs)
+		return 0;
+
+	pf->vf_state = devm_kcalloc(dev, pf->total_vfs,
+				    sizeof(struct enetc_vf_state),
+				    GFP_KERNEL);
+	if (!pf->vf_state)
+		return -ENOMEM;
+
+	for (int i = 0; i < pf->total_vfs; i++)
+		mutex_init(&pf->vf_state[i].lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index c9b3512d4e2f..57d2e0ebd2b0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -16,6 +16,7 @@ void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
 void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
+int enetc_init_sriov_resources(struct enetc_pf *pf);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


