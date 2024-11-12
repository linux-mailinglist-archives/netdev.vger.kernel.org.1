Return-Path: <netdev+bounces-144014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53C9C5205
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1962876B6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4320DD6A;
	Tue, 12 Nov 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h9Q8ad4k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD420E03A;
	Tue, 12 Nov 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403822; cv=fail; b=E+raTb/B3Pz18aS8Em563rNtOzwHxqiqqrIOL/qvxAoCAcal8w+5H5TINUSzLOO1lDx1SWXEiD9RVNYkon2qas8giUzYr2ekIx4W7ddFBID7YwN8X2FKX2JmS1hJyQNA+UYPGM8xlJbZ+GHA1XdzvN33JTWacnmd+D+SCWoTtuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403822; c=relaxed/simple;
	bh=mvol5FQ6PsflUI7rOK6Lo1qwXGIPb4dDmReqR48zatI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BNkZFo7/RqBA6X3tzktdaUjxDMLad32u+tR4WrN4FdIyQOIpixxxKwlOhQkNxsODAF/4qsbMM30530YPLWDlLVrVdr2ipRHQJhmUIOGwdCG0nUwizNlyKS62jcjVISTczJ8B/UY92XqRx7V3FWx/IOSCDzCKLKYFC4xYGCLDvAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h9Q8ad4k; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h28quEuw7cwwUr9p+NOI4LG72SrUCW0uDwz6qTZgb6vfgkklrX47JU1fxewv6YFwLGdwr9Cn/VwhFAZX9gS8uB8rdPoYhIp8Dp+Dxjeh6FhnBzXa4jRrrYxldiix2eSIdocoBqCmBLk0mLDxL+ixXlFzHYyuuSPbAtEi//Ps25V1N0HnPhiJs/dI4MNBhcjG5v4UXgAhGTl7V4rcAxxKLOZhJ0v3KFl/De8aHvehoUSTrp3DNkNvQkYTeMTSOJLVTgh+WKXl3EXt458yQMcQouI5sJZ+ZgTpJSppSwn1YyZCbWreaTOBUiEc0/Dx1LNIAjn/b73wcUTCeMC1yIH/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqX290zXoPATDd9Ovag8s/mK4oEKmcGvsiiN/7VR3PQ=;
 b=Cvmuz9dVWiUvNDW94DHzJh+T8kaDvujECoKGF74z0vssAayys4b8hcEiub49O7bv5qg+Xfz8MHiiPQ/p61UpQfuvgW5mvJ4s13E6jZErMYoFeYjTieUPAgnzNdgt8na4aDZfUQPQ1QuWJ7MRCj+8Cijf55buEGxyp0EeMdQ8J+QjlzgtDpJp7Y5fSF2IkiOHGiVKizGPW/3lHjDDCHJokpBL0YcUdGHlp/TZ37XKo4KzzjhU0YoxsumBc0rPT5DaOBFOMzjPqUnz95woP+jvYUqii9ewAjn3UJNx9HsmuzDuEYqiPCr+Xei3rGLOzqUnIyQyM3wBj21CULn6axLqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqX290zXoPATDd9Ovag8s/mK4oEKmcGvsiiN/7VR3PQ=;
 b=h9Q8ad4k/cNwmM5/HqsTG/GBpaR7Z5DhYPNETmuwIJKS27m4ZR0r02SoqpwWgyF6z8dyy1G4CKYZIdtR5BFegwLe4jEsz5aBS8X0l7DLVKMfJl8WLtEyhU5tAGYsmIOL8SI5B8FNfRjC+EHgHszBWhF6whyz4JM9A45wrmWLV66hg597mlEN4WFtttOKwUeLdvoY7+ZAR1DfjKAEcBOVv6yTE6jHt7Z7/8DpV4V+/uG9l0HRVp+9EkcjwkGreWl3QZDsbbNqKNUO2VtypD9Jieu2VBseuDY7+jLD3HmxfuImDckXIM29J99siE+cEtYf+zxJ7CjSDV1pbG/tVgsCaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:30:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Tue, 12 Nov 2024 17:14:42 +0800
Message-Id: <20241112091447.1850899-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b00c68-ae1e-4e08-36f2-08dd02fc9ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VIh0a/oqCqHsBsc6GqmUlvmFDYBkcdmHDwnqHaUrFEe3uB4s8UYLyqADcGsJ?=
 =?us-ascii?Q?TXO5vNYZB1j2DGfkSUmPw+gbHY+Louy1tzWmYxvPhAG9+WafTX1eDtrBK9Uc?=
 =?us-ascii?Q?vIrB7+jdOjJN3KQoJTwVeHeHqUtPO8m4OlHu+xSYURATmOlZAenRNJYdOKWe?=
 =?us-ascii?Q?yJ4majFZBOn3AvdHWlt8rGdkErlj5U82zt7AdM3Xd5+2S67YaeF8hrwAvPpq?=
 =?us-ascii?Q?JG8hbsss9q+JiYqbYMC90SxUqyXv029a3hcWjbxINOzW/P9A71buyA9Ou9MH?=
 =?us-ascii?Q?KYiLi3yolvDxEg+6MDP+2Kj83Si2YgxNjevCF9yHBU514sw6wAL2IFLItSjx?=
 =?us-ascii?Q?W/BFILf0iVA3rzQX99l0rdxpUBKeSrFS199lHasXsuJ7wyb530HkGSMmGl2O?=
 =?us-ascii?Q?WOtZUyx+cDUoQ3HKkSXforBNi87upa9enMG0gnkiZzhHol+UyGn+bV8/5zk6?=
 =?us-ascii?Q?GrBI6P2HfHGuvOwlOv/0M62a7fh8f2+0F6D9N7eeX3mCYD1eNbKBKFVKUcNb?=
 =?us-ascii?Q?KGMI+L9mDTkeA+mtLVHFoafYqw9kxvXMNsIwYn3Bz8FfjKlR+QWdf2VWRYhT?=
 =?us-ascii?Q?/HOiWzxwssLGTwfzN/RJ7y1b+FyH8kNZ34CB2/m8AuZcANT3AOEVFJw57YOE?=
 =?us-ascii?Q?pLntxtlKFjCNaJTH67WhjEaIqgkY769OwhhiXQgZswpSxldvpFfMCN6Atp1+?=
 =?us-ascii?Q?KtqZrlQLbJImfY361TLzQfR7vac5F70N0yQ99xtoK0k9kbjWAF9JNh/mMmBB?=
 =?us-ascii?Q?6htgo1NyYynHxRJDOf1mgyOU97MuSjy7iWvfNTw1vxHjZacUPYXYItL+5Tl4?=
 =?us-ascii?Q?p+vdt0yKtyxsdP6vPsRTeVlJ7ODz2iGRd73yKJhdjbZ9X48iGTXEOicoUeY3?=
 =?us-ascii?Q?rgekzYcRqedTaW4vcV+1mZbF0hGnpR+3WpWR5Gn5XaFEf6I9KIymPojvyqOy?=
 =?us-ascii?Q?dCvuLUXigSyWgLTLo7Zdrw273WfY2IKhRFyeT1K2pU89VZkM2aIW8I2KNulH?=
 =?us-ascii?Q?Ht27UsCPLEkPCnKyGWBe67r0HCUYO4P8485i8nFvLWnidhWCRvMmPWv0ApAG?=
 =?us-ascii?Q?RWLAUea0itp7CbovUkLzgX/SkJypn6eJGhdZ57nOZxu1JQVONGQwOkoRWIHn?=
 =?us-ascii?Q?RHvHyd/K9G+aDJkFVD8IUx3OObK6hba0+GkTl3g++ipm4SD09nZUCADbYQs2?=
 =?us-ascii?Q?/q3B0j9v/JZy32YwF8dod7ff/qYejNbO028Wu4/IQq81C9ef7x+s+KL1K19a?=
 =?us-ascii?Q?FFK4EfwQf6Lvum9cnCp6S4jgHez7tSa2QxdR/7u8YtdcFIr2A6NeuQKovtT5?=
 =?us-ascii?Q?qwycUIkutjX1RkP0+LikcDmO4ropLzMOoZ9HwUEGNLb8Yz2CpgGL5UBf0+uz?=
 =?us-ascii?Q?xB/+ndc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWKFbaSohUOVJoaoLI5BRlVhDtZ7glXLTI10tASqP9DRxmuZlERvx4XCkue4?=
 =?us-ascii?Q?lZt5jjQSApyIAxu0qZTJ/vVnSemLMt+5Pi26MLan20EE/bs60Bgu5JAmrhx0?=
 =?us-ascii?Q?fLmJW5+4En00dI0r8KJDoyTlWdx6aUY3bLZHK8+To9vEVGSSeRd6gtHBLnn5?=
 =?us-ascii?Q?Fob5oY/jTaT2eB4Lhy9npa1ITHONwscaC+9LVoCkWQt5qEWmdlmHp62TzoQa?=
 =?us-ascii?Q?/gIXlFBW1QSKEY00pjig7tFHBhzRedbV7MCwAI6/DGhW45azM4bOibpoijHo?=
 =?us-ascii?Q?hfuKCRgf54q2P+H48W3sqadsaaem2P6Nrsmjzs9F1oNBq/cATgcMtxrVmcsn?=
 =?us-ascii?Q?+nPndWmgHtFQrUC6O9HkH6RvjeW/o9gb5YvLCqpoUZQKRh8FuheQFOygfZ4M?=
 =?us-ascii?Q?05JOwBJsC5c9ohOKLa0csPkM0+R/RkDmgDQgfcdYcOyuZ777sR0RbjP82L7h?=
 =?us-ascii?Q?YNXKIlaB/VqGBSXpD2QOn+FfpyQIRDpaBOS+I2fA38G4C2AtJfnbuYFkEsaT?=
 =?us-ascii?Q?wf/S3eZe/hQLxpZc6UR/flSi0eZ6QA5Lnb9PQUAbdkt01qWTRHlptTD1TMpT?=
 =?us-ascii?Q?Jq5JuYWUvsJo3oi5wg8xKGr12QL2CiIt0q3/t/y1e+GcBmQhK22zO7UDnLOE?=
 =?us-ascii?Q?0PeeHM44m0fWRMR3t/u4bJfib6h3yQfICcEZQWGDCcp0hsDYh3eFz0DF2bGs?=
 =?us-ascii?Q?gVaJN0AGD42MnVUBmOF5QlZInbOoAbP1BmZoFB/hE6lujkiFsRfC2ArUDdzT?=
 =?us-ascii?Q?wZww5ddVrnU3dwPFszeHS4fvQG/JbEIcNlslMs+MMN5n33G2NRfLhSo5lZ79?=
 =?us-ascii?Q?ikhNOUc70+wfJr5aeRmnaqwt3ppgxoId/IQb2cqwXY1Dm0+YQRJoAI/l1A7e?=
 =?us-ascii?Q?c2SZxbqEmMwZueds91o1ov1ktvVlJoshhEQeeV7/xlxUoSzxgbfjBsnPveqd?=
 =?us-ascii?Q?YMcKKGZr7ULWcfgPwSJzHwomXIiDDhBRFGMiYOszv7pyqZ9nTBEnw8mUhFTM?=
 =?us-ascii?Q?Oj7BxZ5qVY4qMGIPJuc+VawCZYKsOdHjlgCphT2jskELCyKuWYPgK/eUq0Iu?=
 =?us-ascii?Q?CYAa4iSjRz7Kq1l9HmhYre0nEljQFld81fUl20VVODQUVLH69JhuECmGzTsn?=
 =?us-ascii?Q?BGx8Q06R5540QVqY5nGW7+RcCLYJio2yw0xbf2SuPXfpYxON8cDJKTahbAjO?=
 =?us-ascii?Q?c9EB2QgLy4Faxbx8Sj3ajtuWLM/xZcyXuDPq+4CjyHmk6ts7ly0Gp66j4+EW?=
 =?us-ascii?Q?BEjDJCeXJihcm1RWD0kTwd9lp1RCEvndNC0C6RBU4ttLzZwTY2xjDBWvDcSY?=
 =?us-ascii?Q?y3kp9Z3ktgDqHHZGz8eSf8KQeDx0LLSbKhg2ZGY0IHtzL7mupIJAjBf10LI7?=
 =?us-ascii?Q?c4f3lwbaNvW4HId2fTcwb9a5iMd3EJOL4WfdK8yxNc0aDjaYdx2crqA0wqhP?=
 =?us-ascii?Q?cpnj9kb1Eh8Q7mms0Wu+KJuMXXBtaGqjzelQzRrGAUIJkXZhLnG7hKYuumAp?=
 =?us-ascii?Q?azfPTIRKCZwSRZjQZkvfxmiXH1WVV6kbXjGo/z8X/Be3vDOvPk6vnHjPL7+9?=
 =?us-ascii?Q?33+O7hYYTQQ9c82Ln5sZLPwdFtObo3rCtZd5pBtP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b00c68-ae1e-4e08-36f2-08dd02fc9ddc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:16.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqiebOG6x10uO7cVktP6mPU7XtRr6I9moLWn0y25RbuFtyOnY5+nke+H16Z1rxxTqlXV/muzlA+M1gHpKNnApw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 344 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 418 insertions(+), 34 deletions(-)

-- 
2.34.1


