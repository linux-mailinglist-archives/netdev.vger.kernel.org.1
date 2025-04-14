Return-Path: <netdev+bounces-182496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF97A88DD1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C75188B198
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E01CAA6D;
	Mon, 14 Apr 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3GXTEYj"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51C42AA1
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666235; cv=fail; b=dG9ZJkRoMHtu2cYHw5UBOBmDVT6sFqhHVEeDbBptDV4TeplEJyEYbR6rbuSGxsh3++sAoeRPGc0Zv+ewyWnJdOW+pvPzX/8a5HS/f2CKVkzt4p7QHY+g1Yc+RSasLAD21HOQE/IAyqsUvLBEVmcCwPs1JXAh3pffd3mAxE2y77k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666235; c=relaxed/simple;
	bh=LwPmkarIqCeuJ0u/lSgoqedMR64xagBFGNv35G7siqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjeWXjmEehPCsnW00i2bXd1AUPpptP426mUvPoOSvxJWWwMW0am5+JBJkN9RhdOcRkxzAfRsvLqE4yIp/bAdnhfdbyWXfK12D0MZjC0A6aX2tJ2Ka/rlFFyNxP3vPsr6ge1k/sRHIAXu5wVZEy9gCICUF2SOQJ+Y+MYxCby4/YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3GXTEYj; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhhSvmd7WqDCusyooQZ6w3uesFvzYz6zB+seQ9u1Ht02ivblSQxlsh/kdGvyiIMUEQXt0z0bUhhfm9EaO+71QLrWPLjl5o9YgxGhbNnsZDgwIbO0cGFYztDycgq9aBcRcMMhEi67CZZbDMwCImijDywOQDXXc71B0XqR0ljc0QJKceHdzw1AP1GBkTf0g3oRa91x8/nojSnJ2fm4PZ91TUfpQw2eOt8les9sZKZ7CVMmHgamVgvs7yBxiY3edSjCgpeayDMM2wLC1ZSZixrTdrJFS8BlI8yZHTpFEcRk9Y80kp2Jn9cUSY9dPFvlzx1D+HLlUM2cYioX4L3ZZrQknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXk4yr+bsvlLKcEgegy3pjIFJfKqDJ9YW1caL05I+Y0=;
 b=V3D3zvx66+Ztcy2TU+NYG8piXnhAscz7sws3yAAzS57k55u7QdfkKjaFI9yaVUXPfV7Uc5FJwzUlrRaY4MB60jJSwrnXRpV2Y0BomzY2y295SkWVBXB0SaRbkPOnPE5/TPiF+WrgmbLBHCl4BlEwzcdRu/xFkXf17+UTmY3SDYJUaff/SeqFOH29aa7uOCVJUwWaUDZwabLHYfEjH03r0CCS+j97fNJ4vEvJ+80Hevq5nG2AQbjUiICNOpzCbzWRKW0hpRLTr3Q3WfSmXm9M1JMC2kBlOf/ijNf4BSxPrLG5fHt+LdlKnlVNrG3msILv4AUs1/YfpPIBta/JX/Gmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXk4yr+bsvlLKcEgegy3pjIFJfKqDJ9YW1caL05I+Y0=;
 b=k3GXTEYjRshlgb2HH7WP0zpfWxmbHTSd0wccQ+pJAyL5p1VEhMSC5kRB1/hCK5aIssgE8+aglQfqgCnsZiNBrpsUT2qOgrTg9i+SeXFYTZdahtR5sRm2I5xBqihUEOYOdOgU9iYzEZ/gNA/y4n4qbzhCEjYNtTIQzA9PiAqYOtkHxXvSmvld8fUKLEltLz59ED1Ssnm/f4QBoO/4gM6bpfQNlqwehnBSGX5/s/C3S7PggvlprzBnIRtAw2U6BRzRv2pPv4nVOGgn0T7HjbBeiPxFrSFmBPdI89Q0XR0NIJkCgvf2DS2Brg98+wuJg/6Qq4pRUoqPw7tYvB/ukipJSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:30:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:30:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 5/5] net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails
Date: Tue, 15 Apr 2025 00:30:20 +0300
Message-ID: <20250414213020.2959021-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
References: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7f28b0-87e6-45c7-63e6-08dd7b9b9546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R8cKev8xr95ZIVC6YvWEcMXn01MzBXyFEmrzb1HkszsK56rC/WorEdnPuxe+?=
 =?us-ascii?Q?aa0LaHFI49XCvYo6ZZ678LOkn5equrx+LmkcVkWDPD0yZkS4nWJGkogWkjMr?=
 =?us-ascii?Q?uM/ZdnKdxgWFI4izCwbjpx+YWcwcoNg1hDU7u+h5u/+eRnUNTsGW2Js3zOs7?=
 =?us-ascii?Q?4IQBxa/S73zlIH2H4YcaWsbZoNfKF0zY1MtpwOWV3EIsu8QQb+FyTqRDj4m6?=
 =?us-ascii?Q?cdZnT+r+nISAN/qRBEaEEBjEdGAa6k+uaSRs53kuTSQ45HcoJxj4LrmXxaKy?=
 =?us-ascii?Q?YVmVIj5W5CcmmqgZcDQ9AVn3xObQjPaF7D4mmm06KLXgP/8VmQAUmNHlJuwK?=
 =?us-ascii?Q?vXcth26KEjM/QhIHsyMxZQAk3qsQomOWY6TSf+G45UmXJD3Eykqxg55LIoTH?=
 =?us-ascii?Q?+9ZiXlHaYkKiYdM7mU0GeiBVwuZKsJN3qlCTFKWPNzJ/o/EoRtwLkNGl8+bu?=
 =?us-ascii?Q?mj4W1cLH/Pl2lGzClsn2e6CsXxHzdbOdNu67jHaeBjxQLczW3t3jhAe6cuvD?=
 =?us-ascii?Q?ZHQdsm+GXXfyEZj69qyOFVusAN+10AjZbQQnfwq7AHFe6WRSVB74d6KyoMXp?=
 =?us-ascii?Q?lVBIR9NIcKaQvd781PN6bFEYMlZsN8vHrf1FQYwFj04VFGwKv2djK0fEEdv2?=
 =?us-ascii?Q?4EzmAVhdKwhajpH//50QYP56yDPLKy4wb0MDRGb0xZRq4yU12pon49SOjGr1?=
 =?us-ascii?Q?6Cheu0MfjqnJ7YKLNrH7Vps4ct7chwkJfedxLyMC9vFzB7XZ76RTz/Kl6qc1?=
 =?us-ascii?Q?wBHH+iaIL+oSRLZg/iaKYgwwgxbOIQZPbBAed88hHC0z6P4Ttu3+UW5oOAPb?=
 =?us-ascii?Q?VPAceoooNhkIu+lMicyRN5MTzrXOvqDf/aotI4ggzKGJxDsgaZsQ6SXz6s/E?=
 =?us-ascii?Q?Nc0S7l/DultSLb1CvnuP+vdk4DZ7CiWJzgLqdYqy3VvA08gMTuFFv6mH2GVu?=
 =?us-ascii?Q?c6BGBuXqj/x9RkOfaIO7vTVppNBTd6VSoQBPtbXbv+mOUoZgxLgxRECFaAsw?=
 =?us-ascii?Q?W+SwAe9bhDXXshr25PfYuILwNspi9EKZ5TWO0JFOgrRuI/ZXKuaBr9X1pLwd?=
 =?us-ascii?Q?FP+DyNX0DvcH0c5FlSewakqxstPErc5+ES9f+60FuVQK7v8yZdpQa2M2Tcy8?=
 =?us-ascii?Q?sy/yjnMKz0/D48qr+dSlqqovFnBdWrS9/j6s+X3hxd/0Plh7jlGL9GfhnWJu?=
 =?us-ascii?Q?FTL5Eu1TeMzEHfgYwqBcp24TeeYbpHEDsRV+pbsjkm95z7Syp/sMpV1g2xcC?=
 =?us-ascii?Q?0W/JYOaZQjHVTOtxHVb8HoC2xoIpU/rtAOIYd6sOHgKHW4xp8Lmp/7AhpXzQ?=
 =?us-ascii?Q?8SZgVrrOXfhnauMGpwU5LOqWAm4hj2bJmCRIfwCaJAZ0rRoU4wDGC2I8Z0Dn?=
 =?us-ascii?Q?5usB59RXqS00NZJ6fjN2xPV+8MB+w15NEXO2KxCZwTEpfxgf4xAn2AwDCJRA?=
 =?us-ascii?Q?g38VFQXYFA3a+Xj4pFSP0PVpHJSYTc4DiSKrbAXbZwcMqVePKnXsNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlaKGfND5+gmn79gvfDCDTllbF15QJ3llQBEBKcIaE40Q1Ga/ChT59z32BT/?=
 =?us-ascii?Q?xrh5qHzYLPAbjmJqRGasYfwc9oKjs2kt/+joDn8p1rh1FO/yswfbAnfCKpVK?=
 =?us-ascii?Q?I0AwSXhbnnMM2gybisio7kCoiYhLvus25Mz+hICm+fC3mlkccdwpiPQpLTBl?=
 =?us-ascii?Q?AaTqgDGsXuddqKLL2xFYGNFF3Y41mgx/V1I+ZoaXEq5iVCc87WmnyoQmkPqu?=
 =?us-ascii?Q?jPBeJ04ctswYlR8s3OzMYALhfeR+C2ob4Gy2jcptR/tGThfQJfR460x3ZlMC?=
 =?us-ascii?Q?QCnfYzne8QVmnuB066Y5KrIIY4V0DnmHjKIJ88M5u7wcepGIsYdLpu7sG/V+?=
 =?us-ascii?Q?0p1HNBg9wAKRtal85VMR1se64TN+cQlYfqdbqIYoSjWSssDiey9q4EMbyf+O?=
 =?us-ascii?Q?R6+lR/WEcK8FdbHsj6nP2Y19EFuV0thLKB0Mx1BCUUd5d/92ZnVkmPlg/RSA?=
 =?us-ascii?Q?CTmcH4HZF6T/MznsnpcEEzijnmWn0mH50e3V4+W6QpX4AmhwsNPs1j59wkga?=
 =?us-ascii?Q?KirmEPQVIf1GEaYwLnaRgszp+0V2OFrgiL4kK2Hak7hvEdenoTeF06FpYbHv?=
 =?us-ascii?Q?0aYscOLLsh78/M+e0eEmw3dtXvzvh8r5Peodfa9NEjh0uTIEBz66rEbAqsZ4?=
 =?us-ascii?Q?kHD7B8DOGaafIqZCSlbXkGy09Jh4/bNPe6W+6GUxd0ZoChr1djGA8n7S7m0n?=
 =?us-ascii?Q?nEft5aoU1YHoT2ck/ANJx0doNPoZsTOWTp2aJ2tiJbK5/8HbJfKchEMPUrUu?=
 =?us-ascii?Q?m4dj4DSggkzyx7arZW1YK96s7fJrDU/GwtfeUTsuXn9TJcX5h35SLrSwQA2x?=
 =?us-ascii?Q?69saqSXm6Aj1da7+y3VXcXgOCLNY94KQ6MI7exFKbJis3wyl9kd2HLGRk9A7?=
 =?us-ascii?Q?Bu/4wiDD0rHRE4dqC7FMQGncRyvTKgQyIh3qBsnJtvjKg9DJvRtAWpvw2a+E?=
 =?us-ascii?Q?EoYtzJJKNNuIe5s3NEIFYGioyyW3T3/2CDG+dsuIZRgmlDxQEmbvPz0zRS3X?=
 =?us-ascii?Q?Wts8iJkowp6u6JD7TVG+//eb0lE+rJwkbbkUE8mh8HYFcThj5bcpNVoUf0pi?=
 =?us-ascii?Q?txIdp1btQD+cVfd8WqBLBxFGrC87GDxsDDZPP1g12XJK1mLdpSLVRYKJy9Ar?=
 =?us-ascii?Q?O7KMeri+mTxoUQdYIU7ZU1ZyFS49mCkT+FmdCu9Is1/M1UYjNlLjppoQIizj?=
 =?us-ascii?Q?8LoXgaA726ahB4LKE2rI6KhzAZzAub0dXnZ6IA92uhgNaz9w5aofZVUEZoTS?=
 =?us-ascii?Q?wzFscQsC1sKAfKIDQFJEvI2DTAKxp/3AGHYltzNq+2rMKq1ZHRRD/m7YQ0XH?=
 =?us-ascii?Q?GTP6QDvfPiAbfXFK7dsMOiMrmw7U15qsNJX5y8Nl+zDaQP3FDduO5HRK1Lwl?=
 =?us-ascii?Q?OaZZr4N4w8adS9gcpfflDhBqGU4lhtsgS+ekiv/duuVogsVx2HtmTf2WNoH+?=
 =?us-ascii?Q?kqBk3Y+CzVpiu3+XFOR0ZeWoukoMJNxaT4NIHvyPaTsLsT+HJ5Uy57JwPvU6?=
 =?us-ascii?Q?yWTFgncmkFJz5gtr2RjnV8UBjJ8iORH3xisM38ZnlBy+B1ZSzN0YGeneu/3G?=
 =?us-ascii?Q?SHN4bV39R4SCAJjbqSbHnXiq2zvMKNubSXyXjhJY6JNmuyDewlAaIJnIhbiZ?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7f28b0-87e6-45c7-63e6-08dd7b9b9546
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:30:31.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pctQFOmtjBm75g07ejaOakpDWw48ofvFbTUBr51bno0fiZgaTB2zdWkXFNxMueIHUaYr9wvrlqFrSQJarmujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

This is very similar to the problem and solution from commit
232deb3f9567 ("net: dsa: avoid refcount warnings when
->port_{fdb,mdb}_del returns error"), except for the
dsa_port_do_tag_8021q_vlan_del() operation.

Fixes: c64b9c05045a ("net: dsa: tag_8021q: add proper cross-chip notifier support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 3ee53e28ec2e..53e03fd8071b 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -197,7 +197,7 @@ static int dsa_port_do_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid)
 
 	err = ds->ops->tag_8021q_vlan_del(ds, port, vid);
 	if (err) {
-		refcount_inc(&v->refcount);
+		refcount_set(&v->refcount, 1);
 		return err;
 	}
 
-- 
2.43.0


