Return-Path: <netdev+bounces-217266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CFB381FF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1183609F1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD253019DF;
	Wed, 27 Aug 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nsmxdDov"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012051.outbound.protection.outlook.com [40.107.75.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B743019B8;
	Wed, 27 Aug 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296788; cv=fail; b=nv2V2NdomGmjxUQaR5pASrVuuvDGyg2RyQBUJ6ovlcTxDJzz2jonttnWuPXUT5o1PTCxUnabQE1FjXSHOuQp/teojO/9UtypIBlmAlYS95SzEwyJ3F9USo2/37Hbi32+Rylfa3y3YiSLFNs6Rv8UnpGt0iaSlIhdQi7vhVcIDKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296788; c=relaxed/simple;
	bh=945rr4At/O1aOgQmj4cNM7Kr9dX3/CVujObWAeVBRe0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=esQxi3aST+1JKV9Z96gV9nVbYad5rvCOr4XN1pGqa22qGdX0UjheT57EXiL+VXlFMvDV3/NDUGmpl7GNsrMAa12bzgFbHXVJjDakituioCGUmJDawRyZqElKrmGsOkNfA2OPo7sNha75Pgs49wax1FfFJGtfGdZk4D1Ijsgd8Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nsmxdDov; arc=fail smtp.client-ip=40.107.75.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOhk8e0OGDFMs2nDuBc2Ik2g2/+Loe7EhW9WQzDq3IDs0+Ks5zJVSl3mNPb4bV1KNaAwyZ0C5Z52wZrYQZZEZlgyEkREzyTssuXwZ+NycwOgivuXe5lJDfE6OFBzog7ZglVZJ9h/cGRdJldCSacGrDzfA2xfN8YGK3T8brAOQHWDLJTAXwXBWeIt/tzm2ZuSC4MmNKllOlHswgWib3ygOmKpSzagZW83mmu0GM+JGbMKOBcB6BQFZvketYm34NCZyif+W/PgJ8boWwpfeVPlFMRyNjm8/4SQZpJMOVzWu95Doa2l1rJdJujG60eIB5YXY+bV/i/mcLnsUsbd1V2HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0HnMWicu72rgAYwIUIqI4Yb8tHDeAJLiaSCrbNagMQ=;
 b=lWG3oyf3yEWlXHIh87t4mH92iJOw7hbpQ7fBiqdulq9ZYpl2mgRAb5H/vocwmrH8m3k0fjjKa28pS6UkABmoksg62cfaU63bvhIfkKtjK3OidhPDQk1a0NbEcUCl6NeZzqT7Wl6rF68hQhmw9zuMN7ZC85h2JbkcNkmIxT8gHMN3GLYD1xqlsjkHETzb6MH3kheQn8ddG8ge0ye+daRKRhbh5AZyGbi/y/FtKVwHEHD3J9mVCf+MTuMpHQeLnIOD2e2wYiEkuaLea3SvRbZ29k7dir1wubX8iwX26hThOm0REfWIULTLSymkpK1IqJyV873sdFTMPfMDlMYWxf5lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0HnMWicu72rgAYwIUIqI4Yb8tHDeAJLiaSCrbNagMQ=;
 b=nsmxdDovpuvW+UXJpE2pbw2LCDgLcvZ16KgmnH8evJuqHVILVorpf5zlLy9JHg3l4vzutnrkok39uc0skknAHiE7umP6x5tHJi8DLoaGundu4vXrb0Jk2wyYyVHHL6zAFE5C66qoWkVR0Jf0iZ5wsIOcggQeWeeaKFFWmnBimZsb9iBfzLbRS8soXu9k/TBzzW8i1/5cZSfmLpNcirTMB4OymCkneoPqv73f6iAI0v0t5Si1Q6wx5jTrPwJpJ2agT8/zUqkrnzDSDMxj3rpw95skdhcs4Eq4sSmMWa7sA19t96cg0cO7qFL3P50mrcm2eWQtRz+3Z5ekEiz8yTBTbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB6618.apcprd06.prod.outlook.com (2603:1096:400:462::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 12:13:01 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:13:01 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next] intel: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 20:12:49 +0800
Message-Id: <20250827121249.493203-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a29f1b6-c51c-4e2f-5755-08dde5631195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DsSA8yNFVDJFcU3Ywx3K++SId1aAlTWDxKidmGGV0d+SvgCB4jIb1994/Tax?=
 =?us-ascii?Q?K4A634dO0bmi+mU+VH5zFShojR7s0Z7Di6zVddtYiq9Ctz53CqsAiVrLYy2d?=
 =?us-ascii?Q?sRzCQyNg5cPBstfXz6Yi8QhUlmQGv61SZ0y2y8kA+41pdHmdhVQFUzRXHP2f?=
 =?us-ascii?Q?/iShKnSD36/phi9tYspLArKJ0ctipHhWYYH8PJgzqv49JU1nDoQAEeEzPoXW?=
 =?us-ascii?Q?zlzawfSaab06XLazZl/F+TvIdhbfPhRxRWxaum6iuSQhE1nXp79ET7xZ0rPe?=
 =?us-ascii?Q?pY1hTAWUoLWHqBugpol2fCc8XSn4L0f1TLgazWICtcmgA4zWRLpWZMBO9fBM?=
 =?us-ascii?Q?9bb9R/YQmDbsZOLvuRO1YqUyUWocA8W+0wAXZEX3pUMX8p8V5uWau1ITWhD0?=
 =?us-ascii?Q?gbSqh1N8UsfMWvYY4i6qUnR8O86fV8PIRs2V2zdiyH1i7engdSSOJRFDT1em?=
 =?us-ascii?Q?9wd9Zak6SRHhMhzgw5gKhqaNMtIClcTe5VLnGJHjs6GKfVdLvnyfHl/JS62Z?=
 =?us-ascii?Q?iNy2E65dDUh/ZqUS8905tkiqv5mb1Z+KAX9YiclCtYSgKx29uEzJ7xVCCOKd?=
 =?us-ascii?Q?h/lzT1rRgivOOHwTb4fhQq29VdrE6s9Vx+/St3UFo4wa9fCP78vOtdwkphvs?=
 =?us-ascii?Q?eMxoLWmhi3s9qsfWvZweSx6sXKwaIhhYnyvNk9rTsvXOi2dSRAmHgeQNb6RP?=
 =?us-ascii?Q?AHJDRgz0v9/FwcP32p36nH6CN6T0ThBK3cW4jLPotBFs1buctGYsisk41wIS?=
 =?us-ascii?Q?yNtxzYxSOK8z+vu+LTh/mryu7bxl2FKbtQi69jy0SnGatcyyw4kAfhoGl8OJ?=
 =?us-ascii?Q?/Tzj+1JxKyYoT9jm/5vV1cuFTn9NRQm1cHV3EEkfGADtwyZdnJ6JjwNhgdLH?=
 =?us-ascii?Q?lg2m2ySN06fZzcuI8lWzOolKFK50ARSa8+5hM02Y8zxFIzT7L535Lgh54G2y?=
 =?us-ascii?Q?WMt6xU25+T3+URyyrqN1Jy+uU0IQqCkwRUkeVnCOfgOSDLsFleJL2r+J9wqC?=
 =?us-ascii?Q?ki0qcIoSDLeJRGpS12zwWCzeez5+mn37uVi2GddAswi5EZwhgNIsyYcdTsie?=
 =?us-ascii?Q?qnHwn4BsAYDk4htP0IogZlMVz5PcRiJ/e4yXxkjvkO8jIYQuOsmSqqnMtx4k?=
 =?us-ascii?Q?xVsDH7GOEqZrJ7wqU7ruBsu5oZeMwmtqf6Z3Ai++3YjB1MgsPW3gWEwnVNoT?=
 =?us-ascii?Q?CMSRDZafTSx7yWG6OKFO0mlMuUQJov4ku5YwQZ3YykqNGhBAzMCIp+WHsu2b?=
 =?us-ascii?Q?TO/CNUXdz9ogpblaXnXwnjuKM8PYdr9n+ywGhvVpHljU50lNGLOnE8DW4xuK?=
 =?us-ascii?Q?yUxC+/gWkpa88r44hyT4L67z9An927p53cjERKPzq9el1Npxzd7AKPEtmlDy?=
 =?us-ascii?Q?9DQB5BMfA+6yXZrwqOFE6eqRWzNpgPnoK2F6S3J5QhX6tyUSRsUINxptz53L?=
 =?us-ascii?Q?bnW15SmRax3+UOFoywTM8r6mAsIJ3DvL6yvTPxryMiDMQgqjr15XyxFTGgnd?=
 =?us-ascii?Q?lcmlJYG0SmrJw+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFZAczQvVFgOiDqTHEaiFJviU019VsYTBQml9SV8WUDzNkGohK7Semcc6S2s?=
 =?us-ascii?Q?ebEK+DO3ARTtmK3uomZX+wcH5H2+rwxYtFjIzc4cVR47vsNqiQXpUcUqqohd?=
 =?us-ascii?Q?3rx1BZhusDch1cdZaLRvXwFtf9T+MaIsl2BYnnmA+4UkIUyxTONbH4KCf7Zo?=
 =?us-ascii?Q?3pRCeVLjYeE0+iJvpZNYBBHWoUgbW6C+IWUlgv1PGROHTCqR3OkXpzn/dc0X?=
 =?us-ascii?Q?ZvWqa25MRPOLUeY2auFpz8piPDJ3LM7HvVmHMlOzEcXEY40z4FmV6HZphdma?=
 =?us-ascii?Q?BYANJBxfSZ2GPMKRen/fhW1FdcpmoYIyaB46CdwSo3eOp/whbw5k9pCdk0z+?=
 =?us-ascii?Q?0Q/4wjWIycl2LCxoQO3yzsr7sJbR7tHNK1JfckMunDjlgNsy+PebxEwvl0+8?=
 =?us-ascii?Q?+t8G4R1kkTi9xVwmCk8zGIFvnh7mEDLN99Lk2gbelgKGQ4b80uVqQdOp+FMd?=
 =?us-ascii?Q?qCPUPT8LtNQ2f/FHrfJvCud/BGc6B107D0pcXshG9e1LdT7eXbXvDsDalXtz?=
 =?us-ascii?Q?3YeVLIPXIr2zDAkqObrnKJI16ojSg8Dk6m3yQ51XRmrXDQ4LF0XgKva8IJUe?=
 =?us-ascii?Q?wRz/8DDaQ4xIm4Pls0xmE5eFG0OQaaABh7KMMdDbqQRnjGjAlRdX+4uFQkCb?=
 =?us-ascii?Q?iOQCSNCc3SuSmRpOOA9IHp9gxInJ6w8netm4iqrB7pGCNqx/VAZE4a13J2qG?=
 =?us-ascii?Q?siSjuyOGgsriYFkB1bHC6tUuedk5+jMaSQg9rjWFSrHp4Q2ndYvlAVAwBJ2i?=
 =?us-ascii?Q?0MQTzi1RcU0ptjDVw4uDzkEO0ykTRwwDB8cxg1FjsuvybwAM5ULj4yv352Dt?=
 =?us-ascii?Q?4BCJfwtdLj547d7rM+K2BjbNfsgawevblaXA9q6WgEBN+cAPt0qHTme+MHlM?=
 =?us-ascii?Q?m9zuwmydN4LYQpY2zrMmnVu6bHKuD9R4JjAUmnl78Glk9eBMvMnZyNJ16rZK?=
 =?us-ascii?Q?CXaDEU7ZmP3ZTDTA0jO22TB7W4nrQIR+TCTxAZYLMkdW5CbMetNsVwiwLuOD?=
 =?us-ascii?Q?tro52QEjfdfNHCRM4CfR4hwexe3up+vz8wAJyCEfy302PO2iirtLlO9QLOAR?=
 =?us-ascii?Q?Rs7n5VETZL07x9jU2UAWQ5RpZsYAG4NWeKj/BucxIKNTwCyDwrkumukTJGiZ?=
 =?us-ascii?Q?WHP432zItWGsc86fUfqdc9ZFVKNoALv45JfXPuM743y/8moVWikaaXqYWxWM?=
 =?us-ascii?Q?cuqu7kCp7R/MxtjjWUIjjEvycnITfiYQkGtfJkbHRPVWLWihimfpHajBnrOC?=
 =?us-ascii?Q?gg7y/9kqE76eZL32M7xn8aXlt8gbVZCcUc0Eb2WT/ejobzq9oBmefbqBwDuC?=
 =?us-ascii?Q?mLKs7vYyocXueXQWnL/VhkChwzVzjQ0KLNVJV+hlQq9TcpnmHs6dxMtHrf/M?=
 =?us-ascii?Q?2+EP+u6AcmNodnBTFZ87mjqxYlOeUqPuIZdmMHdq1DrBPo1ZYS75xN3kAF5M?=
 =?us-ascii?Q?0NI76y7qAUcizRKbVq0baCiKx9SnUqelCiowO/Iz3wk0mKZMaWSD8Wy0sPDT?=
 =?us-ascii?Q?KFao4dI6DRQlpox4k3ngdpiDSOzNLvDecuaCNKyrnz4GmYuiqKCseTE+x1fJ?=
 =?us-ascii?Q?xm1TwsQuNrYScFkzH64zQPWJXVOW4LQ0Dzy7ILom?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a29f1b6-c51c-4e2f-5755-08dde5631195
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:13:01.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd9lBbrZTnBm5ntJ4FDZbaQkuVADtqiIKmUvcps7z5bqHXNcAPkbKchdN+lvjfJaufEjS5pi8b856/EjFca3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6618

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/intel/igb/e1000_phy.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index cd65008c7ef5..c21cd6311f45 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1652,7 +1652,7 @@ s32 igb_phy_has_link(struct e1000_hw *hw, u32 iterations,
 			udelay(usec_interval);
 	}
 
-	*success = (i < iterations) ? true : false;
+	*success = i < iterations;
 
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 6c4d204aecfa..828884d76f04 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -94,7 +94,7 @@ s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
 			udelay(usec_interval);
 	}
 
-	*success = (i < iterations) ? true : false;
+	*success = i < iterations;
 
 	return ret_val;
 }
-- 
2.34.1


