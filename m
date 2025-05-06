Return-Path: <netdev+bounces-188259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABAAABD40
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA183B12A0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A13253B5B;
	Tue,  6 May 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="acWBkCD6"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DCF24C079;
	Tue,  6 May 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520040; cv=fail; b=npPnNLqY7wwzChNqIsy/lSHcc7TZjexKXSol/IKO0jCuiliEbV34E15PZ0cmUfnBUUo7oUstk0Leb4rtx2M5b52w2BsgcIW2C+S8G328+KqMgNNQsGSyZzAj1IZqlweyow+C8/TOc2wHMZA1FHnhRYGq54ipv5b+C8MPKnILWp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520040; c=relaxed/simple;
	bh=cECNtA6hwGwVWXT5quofPebdfrzn6xUuUG814uZ651k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdHQrk5fUR85ObVGylI8+T5wlwxEd3eXbtBnHqSWLdpxEls3nZT4KHh9+1XuWdSgwFYtRugMK0z3J3dOIKMjypjn9QM6/RfeaKMIwqHX+pJFwuSBtb7HQNg8UGbUSrAIXxh5Fv/TaqDasloZS+6R1ggO2r+elPLJ+RaDkkoH+sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=acWBkCD6; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMZO13r/W3dulA2+QeEpqIDjHrVcfmm59zSBYXl2MyWMGf/WCOoo9Xu2cZOv54AUzCm03mSgewAOtIoWSDEyXajJe4xJ++F1AvSMOUSTEr3vjZn0ETfJEGgrv4cP9ybJ3p2r2oOy/6yVvl/IPOnbTSIuNmQx2g/KHTW/qGdFq0T9DUxJ3MgscQ1wx433gux2XLiREbwvunMDX1Ijek7dvw4GR1ZgdHlNqdlHrQ6AAKKgIPw1bMaOwBWCW8bviPJi7bAW8dLy2gRF4NfQgMwCdE7Z1L7f2feBfmzi9jZWM2LvLraDvXW2bk73f/E1paPibHYDKHIkdfEWAe48YhACAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jobOmsfHZ0X/C1cZvVyTkRk61N8YrgTyIgNTyQO/MJw=;
 b=YrIWo9kqxAYfu1d6E3ggF4CLK/usyFK3RQhEoFSWOFPptY/zZiYKgRpUvrzXKk065bDR/k2neZk79atw3BLDVVkcG1AI3ZHSSaPgyfOSlp7luCPRn2WJ13RcdSK18IFDbb7UcjIEJW8srAWmqwfcuNaxfpmCjWjondVxEEwoJDCXISy0pjQyEYJ2QdlDqvh0iFl8e1WK5nINDSS9YNhE4eeedvNW3RzmbMiwL+s9zGJH+2q+Dnu952Gune9M/JL2VNMVhaIe0tg0Cnu7hJrvABd1xdrDy73Kc8jlN9Y+4d12nfj00pz7Y5UFugWQFzOipd11OFqDe1MRhfPjlGHtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jobOmsfHZ0X/C1cZvVyTkRk61N8YrgTyIgNTyQO/MJw=;
 b=acWBkCD63O9oTsiFj3Z4W38DSzlX4mTJkwp0M+yLYV4P0uHG6gNsRnF39iXekPgsIJk9EYTtMiu1r2g2JFOpFDEj5rl/i6QXFXzW4mjj029oxq2RexpTVrp9gSPgwho+o4o0HCyJHfSBxT/DHHfeAqSJkNdt4sRfxorFaTp4NmeKHd9oo1gL2zn4VJ7mYZhF/pbZAkm6Fh/9Vr10mD+uHaFkjmVYmkrxqv1BB+iXqpQUPClhBk/2bO1B1n+NvZMRagNDyU1pxToFNbDI321umBxNsqtQj1jSeEDrjud5VMFKM0EE8/DN/Vl8FOvfWRN31CFldNOJhN4uRtP1fVMQCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7744.eurprd04.prod.outlook.com (2603:10a6:102:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:27:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:27:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	timur@kernel.org
Subject: [PATCH v7 net-next 06/14] net: enetc: add set/get_rss_table() hooks to enetc_si_ops
Date: Tue,  6 May 2025 16:07:27 +0800
Message-Id: <20250506080735.3444381-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506080735.3444381-1-wei.fang@nxp.com>
References: <20250506080735.3444381-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f9dd55-929f-42b2-4a36-08dd8c77ce9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5xvJ8gxlJVjbgCqHO4pkkpMRpnY9fIW/aty1+lMha/G92inn1iP7gbWJEfp?=
 =?us-ascii?Q?n7J8QcWj8DSRStRO55RJNVJd/tiWWtUVDBoqhVBjwGKpZbemoTKHzJu3RPUc?=
 =?us-ascii?Q?5sosycWhcKhnopRwHjwreT7Ejc0l4mwQh+P2+KQPwvG7S0TWf++G32pmvG28?=
 =?us-ascii?Q?7e6IC82+ESeoOs3HFJGEyfY7C3qP9idk4t/sLb2VHUqxdVZ30i2HxwHPK6t1?=
 =?us-ascii?Q?PfXvV3QM0yapgCCDbi8rGDSDweLPJlNUhi4Kf4tWezNYt1hRDbKLGBk0gSfd?=
 =?us-ascii?Q?hnz4FZb/FEuSE+DzKLM3WyY3UsAfidSHCY1N9YdocCyeZqhEhuX7zbw8uqBe?=
 =?us-ascii?Q?BEudgWGFs4nw+9dS2k64UY0eAkhjxTKJsv0SOLdKQGNrJrDInGUuMgNGQbc3?=
 =?us-ascii?Q?uu1b/uNwiczFkMPjHo4zfJvfMxES7YCe97jvedT+aZyOfkDZ3NAfNSf7BxrY?=
 =?us-ascii?Q?Mr1eHi4XlXb7A/7H2Kz4rzn7aHvy8qtBXnLeqYSsFL6TOHt1/1OzHv9romkx?=
 =?us-ascii?Q?vX1wjoPvAETHV5lssSSVB/06g9ZGIuyJnptU0GrDCZzknU6qR9I1TWTmLRpL?=
 =?us-ascii?Q?hOP/uEzHeaUiLxhRIF6Yfa1Y8CrWgBVRMzJCWFK/gqqhvDmSfVB1h7w6j/az?=
 =?us-ascii?Q?g6diQYMRl4ngbmcY9TkR2IuuA4lr/lc5apboBfvFnCHYFtZRPoRQIOjuLSP9?=
 =?us-ascii?Q?8sgxhwE2G6yuU0XjIe/SGqpv/Uth5MPRYk+0TScsasfAvtSpipKY51IzYHfA?=
 =?us-ascii?Q?pbHPlZSr/QfG/w1knX66JxbcdLsYcFqk2mx6BZr9+BbXwjIRHyOTo/drtX4l?=
 =?us-ascii?Q?7IBF86+QeKvlpQCJP43CXz/B1xccDJJmY8TlWv1Rpna/IEP3a8pS6WRztPfJ?=
 =?us-ascii?Q?jCnHf7v3AYcJnXP7dyeAH4C+YYS70APIKBbnRgItKYxA2nfQRnmu9CZjsTad?=
 =?us-ascii?Q?pfV8+91YCIdEI+OWqH9YppKCxatoEGZfcQUov9+hH0v0kx8gfvwv7dB4Qx5l?=
 =?us-ascii?Q?9ZsJXP0q5S5mPY7DJAiIUbk91N913rNeDg4PYLB+ludlFNZ3AOlcdHv5a6SP?=
 =?us-ascii?Q?7fPvinuLhCuFpyaYlcc296A6L4XUCt7mniq0a1dLzGHfP6cP5/QiGNqjngNK?=
 =?us-ascii?Q?Ew2Orw7VhAv09gb8WJK5H4xRjrOClHDIpPnaLKZRhpvR0kGVP+CHd2CtoKJN?=
 =?us-ascii?Q?IUL+XxA1vKd731/tccOppz89M1bdaujyhaJ9FZ83MA9FHtNAdsTl6Duob4zz?=
 =?us-ascii?Q?+/wExrlFcTQPRzQIkrkKHrrn2iJ8VNnO0cTYNr49nrPayafd1J6qZsBR3wHE?=
 =?us-ascii?Q?MzxYjjq9JNjTrcUglzWFTSKtwaHUlbOXRhWuxjNNm7Whjb4+NVSEy0Hk8cNe?=
 =?us-ascii?Q?OdUVi00IOLxdZPtvWTFHtbZDjhN2gspjM18ozGniuTSvMIqojTNyGK7/dohV?=
 =?us-ascii?Q?dVyRWXu8HCSp+AQL6IJP/7mhsEOfDBDkDMQAXAbvEtWcXxbyoPH0nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eENoNM+eHq/36SHXjiUsL9e6u1iTXmxoRVlUrfotTTcwLjzQlBk01KAUbREr?=
 =?us-ascii?Q?kjB732KCnS4LkkaauvSk7PR2SAHz3LaLXV6zqNIORsx6pArTHkBSAGviv2RW?=
 =?us-ascii?Q?/tr+RyNR97roqBYVZ4XRMZEytypBmvSOImq5lOA0AtAaa2geyzwHWyOB7jha?=
 =?us-ascii?Q?+7ay9i2Ls7KRXd/md8wlToXC/pdeQJw14H8VNYaQWyoX2ij9CCUov/RvklrE?=
 =?us-ascii?Q?U7Zr1jfpd7K9dQxO30Ajo0OTo4h/2DYYB8xtUXsT4B0Lu1tnr2iwLEM9olja?=
 =?us-ascii?Q?Mp39Mx+b6Tk57JgspOApy8yQhMXqpbn+zQ2fCBFRBQwNlQ0C/c69fVau60vk?=
 =?us-ascii?Q?NhzKPcaSeH2I8RNkf4sPEm5GUUTlBaKTE1lIKD7k2Iuvyx9g8nh2oEEfW3gC?=
 =?us-ascii?Q?d/I1twHb+CDL4tDeg8BoxbviJqoF1ntcXKI0Il0Qalh9fiK8JC6U7NOQJ5/y?=
 =?us-ascii?Q?kEGaoVnBYuDBtFJHdMXbbBwMVnYJsanWl2t6g1khENihx0brF9zRCjEQbwld?=
 =?us-ascii?Q?ZSPiPjriEhqhKe8061QnZpq/niKq56O5il9Orl0og7naiIDS6KMTl8GkMOxE?=
 =?us-ascii?Q?+0zBwSXS7WQfrpMdXUMqbgbZaULem7E1e6ZCBqpASfFM0ebTiuNhkGNWR4iZ?=
 =?us-ascii?Q?RFAxpwFVCuJOyjJUjbdRv03R4qV30nqs4MnMdmskzaJOFhQ84qIGGCsfPbni?=
 =?us-ascii?Q?qoiB7RbSH9RNW5r9QLa3TasFDcwH9EMMrkBvocG+ta+px4jW0aMktnsO1JRm?=
 =?us-ascii?Q?GNKiLnqgEOfIbixqJKJV0RZU7ScmsDfrExJgOhb8KGcZo5izGGIIlB7L2UTM?=
 =?us-ascii?Q?mSfD+3QRACZ0RWTGPKLozGBStbPqoZrywC/5jXWLcMNJtd90qfmiBCtXMG+H?=
 =?us-ascii?Q?GzkM7zLLjfdbHYSGPN2gZRngJ7Kn8kBa4HV7FUYy7QeGO63Hlk3bBIVFkR4b?=
 =?us-ascii?Q?z/taC5N2RVFU63wqsf+Y6mHHQ4bin8jPB4xGcWnaCiRA4qn1C1KsXFW8HYbV?=
 =?us-ascii?Q?unUK5iS7t+d57DWMrpYhL11Ol+liTyqRPT6GgwdD+i1yVpn5SKNitWCxof76?=
 =?us-ascii?Q?Y3x8mkAs0qax88yTidBj8Du9Bte7ed3n23LTKlnP/6KbM+nUDWzICe2rL+no?=
 =?us-ascii?Q?66WF+xbyI7XVS6Wn8P0lDcZzEO8uk7sJCPDuPod2JK5j17FM0g3abpCCbDa/?=
 =?us-ascii?Q?XM4451Jp1n0T4Fg7HvjRTHsKPR/RD6w6FLrsovbbfD082YYpEVxVRIZtFb/D?=
 =?us-ascii?Q?couK+/C3rMNVLiy70dvPcnu4v3dMubbqKEqAPxNhkSwexCuLAHcd+1+0K/jP?=
 =?us-ascii?Q?+IB0OW2Iqmx02YER7Jupy6UcrEA5Wji2wyCfbbwC6nWbT/2tKu2zrqSoNlmf?=
 =?us-ascii?Q?UE7wmblHUBuyQmfN6FonZAny77EAoOqQ7GOJDEUiMDDSy4tfox1Jxui/ori6?=
 =?us-ascii?Q?6ku0+9UahN7YY5Y7jC2FGWLE5xXOjuB8V4LZWhilCszxu/yW/gvQLRwjWobF?=
 =?us-ascii?Q?dZK0aAJzSDaq6XXCkQg9wpNUbulAHY51yYF00iltbwLdPG9fuNGGUE55qvt3?=
 =?us-ascii?Q?xNRxT3VoHX/M8pU4w3sdFWQFQp+Xky0R8hrOAnUy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f9dd55-929f-42b2-4a36-08dd8c77ce9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:27:15.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McT4N6tkmCW5vvtw1GNzWRUkvCvRhA/9wCVLShacPWOUtkiyNy8tQutVAEzqOWuV06d1blc9Djstbb+fXFLfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7744

Since i.MX95 ENETC (v4) uses NTMP 2.0 to manage the RSS table, which is
different from LS1028A ENETC (v1). In order to reuse some functions
related to the RSS table, so add .get_rss_table() and .set_rss_table()
hooks to enetc_si_ops.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c        |  2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++++
 .../net/ethernet/freescale/enetc/enetc_ethtool.c    | 12 ++++++------
 drivers/net/ethernet/freescale/enetc/enetc_pf.c     |  6 ++++++
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  6 ++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5a7af44e4594..494f8f77bf4c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2415,7 +2415,7 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	for (i = 0; i < si->num_rss; i++)
 		rss_table[i] = i % num_groups;
 
-	enetc_set_rss_table(si, rss_table, si->num_rss);
+	si->ops->set_rss_table(si, rss_table, si->num_rss);
 
 	kfree(rss_table);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index b53ecc882a90..786042029b1e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -279,6 +279,19 @@ struct enetc_platform_info {
 	const struct enetc_drvdata *data;
 };
 
+struct enetc_si;
+
+/*
+ * This structure defines the some common hooks for ENETC PSI and VSI.
+ * In addition, since VSI only uses the struct enetc_si as its private
+ * driver data, so this structure also define some hooks specifically
+ * for VSI. For VSI-specific hooks, the format is ‘vf_*()’.
+ */
+struct enetc_si_ops {
+	int (*get_rss_table)(struct enetc_si *si, u32 *table, int count);
+	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
+};
+
 /* PCI IEP device data */
 struct enetc_si {
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index f47c8b6cc511..5c51cf7ea439 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -681,7 +681,8 @@ static int enetc_get_rxfh(struct net_device *ndev,
 			  struct ethtool_rxfh_param *rxfh)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int err = 0, i;
 
 	/* return hash function */
@@ -695,8 +696,7 @@ static int enetc_get_rxfh(struct net_device *ndev,
 
 	/* return RSS table */
 	if (rxfh->indir)
-		err = enetc_get_rss_table(priv->si, rxfh->indir,
-					  priv->si->num_rss);
+		err = si->ops->get_rss_table(si, rxfh->indir, si->num_rss);
 
 	return err;
 }
@@ -715,7 +715,8 @@ static int enetc_set_rxfh(struct net_device *ndev,
 			  struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int err = 0;
 
 	/* set hash key, if PF */
@@ -724,8 +725,7 @@ static int enetc_set_rxfh(struct net_device *ndev,
 
 	/* set RSS table */
 	if (rxfh->indir)
-		err = enetc_set_rss_table(priv->si, rxfh->indir,
-					  priv->si->num_rss);
+		err = si->ops->set_rss_table(si, rxfh->indir, si->num_rss);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index f76403f7aee8..8dabb80ec04c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -905,6 +905,11 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 	return enetc_ierb_register_pf(ierb_pdev, pdev);
 }
 
+static const struct enetc_si_ops enetc_psi_ops = {
+	.get_rss_table = enetc_get_rss_table,
+	.set_rss_table = enetc_set_rss_table,
+};
+
 static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 {
 	struct enetc_si *si;
@@ -924,6 +929,7 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 	}
 
 	si->revision = enetc_get_ip_revision(&si->hw);
+	si->ops = &enetc_psi_ops;
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err(&pdev->dev, "Could not get PF driver data\n");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 3768752b6008..4fafe4e18a37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -162,6 +162,11 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
 
+static const struct enetc_si_ops enetc_vsi_ops = {
+	.get_rss_table = enetc_get_rss_table,
+	.set_rss_table = enetc_set_rss_table,
+};
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -176,6 +181,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	si = pci_get_drvdata(pdev);
 	si->revision = ENETC_REV_1_0;
+	si->ops = &enetc_vsi_ops;
 	err = enetc_get_driver_data(si);
 	if (err) {
 		dev_err_probe(&pdev->dev, err,
-- 
2.34.1


