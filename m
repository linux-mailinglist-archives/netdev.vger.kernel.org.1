Return-Path: <netdev+bounces-213468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757EB252D1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885DB7ACC1C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C62BF00B;
	Wed, 13 Aug 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/8GTka/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BF29B78E;
	Wed, 13 Aug 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108646; cv=fail; b=HFlFHobnX1loPGYz+c3OeGdwvt3TfEjnEw9etuIKOpXiE1u4vTidmWQ619Av46Rut0xox4LBr0HjBVppbvdRQJDoh7vUGlrzlAw1G5xQu4bmqj9ySHxtFhwzvc5xVU53Of/tQc6EYA91vfwuTjNTb8uSPaACrnJVulv3AtiuD28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108646; c=relaxed/simple;
	bh=73tez0/fmurZbg0FcF0aTCKxGC7nd6zmTzINnjJtl64=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tnq2YKIKddyqnFzXJe4EwxRKdDGZUWbYeXiUi2OwO47h9xvoWI5DotAfY2fX4KnSZhhSzbR9mf33j3J6RXYGMnpBRpI5AyxOCCOEKtwKdGYW1teTPJcC+SW9FTERFehIht3aaCJwTKQTTiETpmHOckKkqqz7A4lq2hEIQBlVzAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R/8GTka/; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKX3KzkOL5CeOdKCUKYXHzGx1w+Nciabc9ZIOQGJcIMN84Pcf93Itvu6R6sDDJJvsW+SR243FVe45hHdN/ffsUyIvxHrtAFZ+n2zYoCiArXG9tlrqRcptHJsrXhrwDaSNhjRcpuFT/rk2FSQB5uRaruGnzsN1ipWAUEjARhzuNYy8OSrbw323b4cz8BhOay1464azRMOUlRJSykM8C9zeDXbWC5D3qj9O0ppjK+q9jj02WYbYof0bbyI7sv9W3rxH2ptmFObpPEJT/DxQl3QUIUDcFsUN3Iw3wNuwHuqCQFVAM6LCebpB5bdi3YtzRK5eLhrPUge8xGy4QzhGEHdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t42/M6xaI3hvNxRwTFHPfVaSDinWMj3w3SgWM37vd0E=;
 b=F7JkhGeZkK8hPQkEtM+MmcMrfnx9lal9eYPOsNRmKHG8ytvFCTvpkRjMHNvLryUeL8IHPK5z5ksSSTxnxj1wOvyvSiepKJD6KCKAptuNoIwF+1OeqUDQgmc1LRlowcbtwFoan2HNjWnv8VXKHHSjvBASo8mAT9Qd0HSFmzXiaOwhwdvhFYHR/tEGF0Z9afQIezT8SqilmxzwUHTSru3t2AfxJSAgSnGGQCEaYiMMbIA5lCt9p7UhoQb/1+r8NsMdTvwV5QufUkoskPyPUprLilE+23vJS8XXR4RiyZLxra2jKl6+r/gGLbZdoYTYScMDtJAjNUCNR7UderqnnlQUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t42/M6xaI3hvNxRwTFHPfVaSDinWMj3w3SgWM37vd0E=;
 b=R/8GTka/qnvvl+cjRp7LEbBhmo+udG5VXhbaPGHNiswC1jcPpdIKVW2myEkvQ+xMpn0z3hCYAl8Dm19m0MGGP3+OYoBlkL2rY2nSNwCgq4RvTPddYQXsy4KNJCxQaYmC+5lNPKbReDimc0vlw36Kl7n3Fm+z7GC8DZ77rnGKvZ+eLdjDtZEhTVFPCV/RHXIVDzwRuj6BUJKX1VugOaY6qr/n3GfS9P6St4EXI8rymDX49QIz1trfQlnwlNp9iirvKufKlTXCRO7gjB2temEpu/VnkVJguEcRkNMc2BeBrgqbyRtHkFGIyvAstuRU7PqQPEB1eaA94N3Rn92elu0cVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 18:10:39 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 18:10:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: realtek: remove unnecessary file, dentry, inode declarations
Date: Wed, 13 Aug 2025 21:10:23 +0300
Message-ID: <20250813181023.808528-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0151.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: dd057537-1c7f-4808-cc6d-08ddda94b57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|52116014|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgjEy0+5x08UCytAwEDuAxaDFR8pXmmMtcsKGi/XYXw4hnvEoVH/2zhDoYMl?=
 =?us-ascii?Q?hN41GpzMKYmA442WlziNLykGi7lf/q+z0fuIflgssCVKaTQEERLORLL9Erng?=
 =?us-ascii?Q?XoR86TvOmgxeTGWPBdVffbG7VF2tytwE59tQ6ZA94PPz5nhe01eL2wyWD2KT?=
 =?us-ascii?Q?Ozoy+XDf7uSbD/JHnDC5SR10iJtP6eBMf4XTrhlVs+Nspe0aSjT4QxD5ulPZ?=
 =?us-ascii?Q?IIkSz0dp9zayJjJzjBqil44vLqTKo3IP2xUAjmHq/IpCKtuyqHS0uoy4/Zm2?=
 =?us-ascii?Q?r7dDf15FhDF/NCNtjiQ+UlAwubdBZ8fNjlKGHfQvhu5XP+RWN612r9PwGGED?=
 =?us-ascii?Q?E90LcBZgvyMSlEPvBPPlUQSBenCW2kb4isGnqr5limFUCnnblROs16iEFVq/?=
 =?us-ascii?Q?zQ902/hDsHm4sGNFzlg2shivJ14CTHOcHpg2s84R9nFyTeHt/k8DylFDg7mW?=
 =?us-ascii?Q?Udj/8P93phzN2YmnfHzaYiLY3prDxaAi/WZFODaAszrZvtCyqhyNpN7tdKH8?=
 =?us-ascii?Q?mauXm0UNjTTwRNXW5vDQsPwyjt96QOCHT7PKkipNLW/Fv3Q7YpQruekFdxsH?=
 =?us-ascii?Q?KOslrdx5R42s8ZoXRxP/WAqhz6xz1JWDuztR8CZ+/QcAOup2jXEwbqZD0qWB?=
 =?us-ascii?Q?WsJGYeZMYDhAwuuq/nfuCJfYHuzC82d1VY0iywVWvI9VTcCdxGQTem1lcJW2?=
 =?us-ascii?Q?VZKpoGRkecLdelhu8yR3+gm91mJRkaSd1Mj+ys9tmJBk9IVG4vNSHnlGEhSr?=
 =?us-ascii?Q?A2fqJWq4mxJMoiiclP7hA0GcHFTN6Mxo26PFKJXfsmAJvRP/GCw+wb38f4QH?=
 =?us-ascii?Q?QqsEx7UZdsnoe0FsS5g2idCXlwEeCRE2/Zs7a+JBTPJNKCb07W6VtwPOvLE/?=
 =?us-ascii?Q?mGx9KP887DSCSM81G3zdxESn50+tqmXaR2K3skZGulGFzN8m539hnxmwWxJ8?=
 =?us-ascii?Q?x6hguoM9OQJNXrrV1XeR932ZDmcW0nCPPy8WFBwYqo7VeWpSPV4qzTqWNiRD?=
 =?us-ascii?Q?0gM8alt64LcJneWtSqHhVEcw6ovoP2We4JNX4gbKTSEy8CoMVeZZz0ZJ9jRz?=
 =?us-ascii?Q?t23ZrPMqU2iWRT2ewE/fnIrDVn8TxOQwFU+PXwcxOmLm6sXCrKysSdav492x?=
 =?us-ascii?Q?u7U1BrCC+Q2sBBw29qvHD6OV0G+/dIqRPT5G0XRjMvKTxMBIwMA0Of3zBt0r?=
 =?us-ascii?Q?7hwL3RCff+7QA+Tw9IxNXzcF4XoY8Z5tKQ3h3RML5ZIkoyomG/wDKtINCtof?=
 =?us-ascii?Q?tTbkSxNt4dyS85M5zmsXNCeG6T3F2RwSFE75pjw8GdIRbx2B0IQp/PBw49Fc?=
 =?us-ascii?Q?CZ2VcXSRbh01fPVhlOeA/HX8HffOls/FYZaDfXZXjjwPAfZqyoU71EV8f0pd?=
 =?us-ascii?Q?EIvQ5FrlQcvqonWMp9+OuCg0pXOL6SYcW26s/TgVPziu+nw1QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(52116014)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+PJO1/tJZvXU2pcP35Lnbk6qaQbAeeisw7dAqyr7ydBhe3yDrg5e3q6YUIb?=
 =?us-ascii?Q?yO58kho1l91dNmsssnVpUe7JOffXJj3zITF7EbDXVTk3Cg5dzxEk32g3caJZ?=
 =?us-ascii?Q?bCmKIQILNCFLe8G3GIJfsVsXy8Jdbmq32bgdp2l9Ou+gmgL0+rlSR8He5lu2?=
 =?us-ascii?Q?ZpOfWsjgyMxyoyiSYZD2YFTJEcIxGETxr38knjKyZ2k/V5uwN1faBNNj2OK9?=
 =?us-ascii?Q?vxU2mqS3N02hC6oVJBZjXhCS3Fgbb2T/nVwHgLpSvN84QIW7lSX4dqjtFG2H?=
 =?us-ascii?Q?a+Z49ZSTiHlVmcLNRJOt9bGEA4zOLTuzh626rh2Doohvj/B9SGKPClwqiTKo?=
 =?us-ascii?Q?r9Vy36KuD9ApO66bZIxhJgyMohDLT/qZ5u9NfngbqBsQ/pzw5ZHX5jNrj1oU?=
 =?us-ascii?Q?L3wEftkSpY8vH7qpnwP6qpmaTBL9mr/fWt4da4sG/Gb0DZ18mIx7Yc8yeDQY?=
 =?us-ascii?Q?UnJbyeWYjSP7Rp8MGPSAcJsdqiGps1iQiI8tsH0FW06O/xnfc6lAKZ5lWXAG?=
 =?us-ascii?Q?+kCs7WfWZ7GdR8ecK7EZAZK0nxrDoaAhcZ6I/2CzkOP/Tu8khKrxX0XMLweo?=
 =?us-ascii?Q?OU9JchvZF/BWLxUfTJAm9T4Wn+oMum5kM6sQIrE6FInatv33IdSz7HqIdQ+A?=
 =?us-ascii?Q?WDULEXQ2uvdze2mvaw07SGu+og6v1NxFdwJ1Er9crVrw8EscOuwT7BETk3qR?=
 =?us-ascii?Q?eQ0MDnrxUcZMfao2WuNdgkM+Nd4u1QEmEHuxaPXSpKFCARs+lKnT4KOVgcNS?=
 =?us-ascii?Q?/ddLFh6Jo/s22qlhhNLdAvcZj9CTD7c2pSwNXabt/iXxp5KKHVU0YpE8hzWg?=
 =?us-ascii?Q?yj3Usn9pCkAVwpivuLhU95CJK+tjdNxTUUj/gRmWnMTr4KQQcXoAsTUxeQIt?=
 =?us-ascii?Q?EoJ95z9l4HlE/47PxnXYqzsDWba6JKjCotGNA7sCCeCndKu01o5i4xwJiRfB?=
 =?us-ascii?Q?laHAA1kz8xtdUszobfv1S35j0vgjdgi/bXd1AoMeAu8KBiz0/L5a20GwCUrw?=
 =?us-ascii?Q?J7nyO89nuETXmcCrlG7f7VBa73d5nAfRehFQVTykfXlOz3Boys5BaREmQwVH?=
 =?us-ascii?Q?TH86nrrwGiSpSCjRIg81ya/DphQqwFKUYXjY+YPIfd2fq8aoPHr9h0I8QxQP?=
 =?us-ascii?Q?Ap6xOtVX48kcrFHzZkxw8Pbb94w25na4qHh1Uk18/6ltIl7IObyGSlTfXQok?=
 =?us-ascii?Q?6vg/rfVTI4p8K820JjLDn+EydY486rUazaqavUs/p8MbD2tuTbtNcXW/To8F?=
 =?us-ascii?Q?SKH25trbAFdesBdfNZNgg20QtI6ipHVHNCuNwRs9cVo0S4gW1D7y7VNP2/3g?=
 =?us-ascii?Q?aJL1sohEnZDHHv2VMh7+tJdHpTWylPmrlpFLBIKfAGbCu8eQpiSf3lh/v2wi?=
 =?us-ascii?Q?wKQthAemNUml8lDfatrFqnkzo1Au3MmN7YH1MbVzyiC1bXh2q9TqbAXjQV7R?=
 =?us-ascii?Q?XRB7tay7+3ghpeYobfxKybN4fbzXeMiPTHGNFPtiTndJ51xT1JlrCeqf8s8Z?=
 =?us-ascii?Q?oAbubpbeo7YT3DLJpMp9GOHRPQkZ3SUMKkLF9Gb07qwndJR01z27JaxL/8Ev?=
 =?us-ascii?Q?vHwoz4jbOSRd4Sujp+JrqIvLvgh8F4nbMuHNoNRTNX2N8WYUGBvo4maQm4ME?=
 =?us-ascii?Q?TbohS+Emx8v5DFwdrmW+nc3nNLfR9OQpT0RmJhK9RwYhNVPLpoxZ460BVx2b?=
 =?us-ascii?Q?cHXreQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd057537-1c7f-4808-cc6d-08ddda94b57e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:10:39.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/CdjkuokKeFT7Gn/uAJUWvrLbJJns8IqDD4sYoDR/GFQh9u6ixhNx3CQMYf7J78o8NT9GreCFu0BgV4h9H7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918

These are present since commit d8652956cf37 ("net: dsa: realtek-smi: Add
Realtek SMI driver") and never needed. Apparently the driver was not
cleaned up sufficiently for submission.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/realtek/realtek.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 7f652b245b2e..580a7c55d1e8 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -19,9 +19,6 @@
 
 struct phylink_mac_ops;
 struct realtek_ops;
-struct dentry;
-struct inode;
-struct file;
 
 struct rtl8366_mib_counter {
 	unsigned int	base;
-- 
2.43.0


