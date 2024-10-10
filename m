Return-Path: <netdev+bounces-134126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F29981BA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8791F25D3C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D06E1A0BDC;
	Thu, 10 Oct 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="EexO/Y78"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173AB66C;
	Thu, 10 Oct 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551485; cv=fail; b=WEeU7TRIlMdEQPSeuDnWcKyxjqng3OWNoJuU/UFewYpLtd4FQvtYLmzvpvtpE5GsGhREiatJKVIVAolDImTpN+fOhXmnA/e0lZzhOEvjJk/d7mi+rYECpmGSDvefAQxzyAS3QrlLP+28sCyNBnPP0HpXlbMEE2eQxA8+/Wq5myk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551485; c=relaxed/simple;
	bh=nWBwAjmtWrHQjezkX8yKHU4qGSx4T2X1YXeCXeBjqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ULHPRaEpleQQt+4imbTXDirGicfTCiEzbfpX6q1klerjOBlFZtZjLDAF8W0ndNvbVl7KsMl0ndcYouM/BGCvzsKGMJJLJlnPUCBMylDyUt0qvBxBSAz2hcsZCO/ZRQDxCv9ZCeOuHXJk/VmxezgEsLeBwJEr4YgPkVuPEGQJURw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=EexO/Y78; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIAhLY5J9ylt99H6RrV0esJ7WGQehdyqLlcS+6O2L9I8yZrWJBQWAWQq9ScjhML5ZxmmLt5ycKrrohD1EGbT04sliwnzWx7F5fyTya0ryfuJILMi23WnfCCuOVW2UJRBHWDrknRZzkQY10NE02l7qYcGmxwtf0OQo1/Er5Y/PCwchK121YnOEkiP7K77HyxJ4Tu5t9V62cdi/nCHxGRx0Td8VaND718+YBwkoN3x0g6m8208QsIojpn3nIo/F6xggzVKkUJVugu4apCik1FlWS913rXVqWPu19TFbLy1zz7JCCy6F7rCsaPEvQjilqe9CP/x23x6EavtUAHWNaH5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL5Ywg/26+01JEogw3M4dGMw5q8T9FaP1kRzVv0U74U=;
 b=KonCt8ZNyWXs8phyVgb61Yjns95B62HHfUnQTO1RBsUK02dMWLYtubtOWjqmAO8/G/u3jA3h/gKg2kIxfEUu2WVvymwK//S80LbT8yeQopWwqYc5uYF6Rjbnrvbs4/jH+hQ+xzs+Efead9Q80TVwm+HI/9IRUhUAnSEkBB4t3/ba8+KBIjTnQUXytFRpcNqjzNcFRxboJx6tTn0OmoCPxwuduKRi/J5y4OmgwnMIACaBMPGJILkHl2baVW26fcFbQODYGdrvuHE5t7HXahUNQ7jX0PBJPQqbF6TqyVgxoPBHnCKClSjOGAw2XI10x87YuDtoJ2D/xWQqOC6b4tPwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL5Ywg/26+01JEogw3M4dGMw5q8T9FaP1kRzVv0U74U=;
 b=EexO/Y784lkjYDQuYHiATi6FHJUBJ7yP5WjaxgqXKhF0xSdvF+iHc8sc0OouqLEc+Kaa4cJtb+bsLRmRH9mU4FZHdvmbyFlRoctSn7319mRvkYserSF72pw2JDTUc7CETkuTvrp5K+0zvalXv7pkMi/4M6E6dDzd570NN53aiB6NwVwwVozzj+s4U1adSNiRx4jqT6lWySueqEH11hC93lN4aAMi5mfACLIV42zU34W2rkNJA/jjjSDPzxToj/yxKmUkVB3IU5p8e6Dc0WhjtkB3CQittTwmKdGXw03odGkI4N2pcmtANNjYV8NfinFRQq89IcaB3aPlEPkYh0mx7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB9768.eurprd07.prod.outlook.com (2603:10a6:10:4c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:11:18 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:11:18 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 1/4] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_vif_seq_start()
Date: Thu, 10 Oct 2024 11:07:39 +0200
Message-ID: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: cc464372-9855-49a2-8449-08dce90b8038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQG99HxiMSCTT0JKuM9R6ghW8crUTWL57ug9x3oM3j4jhFJNde1AWZ9w6WTN?=
 =?us-ascii?Q?ytY8fxZpDPPyXeNzuTaP3UWLfjos+6UDOw/aLH7yF+py4OKRelNUvcr7XRDx?=
 =?us-ascii?Q?vOGxPtZFll+UyQdsALVXub3kbqHFqPLCLRgGIOm+Vkfanyji/wd8Kifrub70?=
 =?us-ascii?Q?7Ep5VP9aaIZUmc8vWrCairkLoHVAJzLM2Op8RO00hiBkxpec+r61Ez1ZBuKT?=
 =?us-ascii?Q?vIuNHxNn5nZsmj6svm3ii+JIKE6sixLCt+LDofBMt3hH+bBhFIq4YZKJokt1?=
 =?us-ascii?Q?+6vaUhP/ii1GD0bhMAu1pQkNbB9qExI8yoRbRfXrfUsMhe8wwTytzS9wOpWY?=
 =?us-ascii?Q?NTom+s8wNM4Kl4r1syNoWaJKbMUx5s+Nj6kd8WJmXXOUzqwpx+NSRnTXV20u?=
 =?us-ascii?Q?Bwy7DxCdF2CwE808pMYcRtzk2GY0FSHSpv7anzwEnR7A2QfYdZx3yf1/Bv0K?=
 =?us-ascii?Q?FKZ5GOUCC4jsKKSVtsp7CADMsuyjkOKDaJrC5so9vaPAIBa8Jh9qGExk4LT2?=
 =?us-ascii?Q?R1rpMBMLZRax+yfly46M2kN8uCas6xY0nQb9C1hFENxCX+44hI5jhxoJZYaZ?=
 =?us-ascii?Q?uH8MCqFIT625EsSwQaukqjNR3qKXg5Cso2x32q7ivNI1KfaCBGMkJt5CASyL?=
 =?us-ascii?Q?+QJ7Ro3w2xWTUR25uykeXyHV1aRuMgkNpn4MP5eC8DVSlpOSgv+Z6d4OzCEH?=
 =?us-ascii?Q?5dIYqt0Ex4xonQV6tqnklycLs3kg1ehMSfrQCnWAlMb/oPN1Nex3mMmR7r1h?=
 =?us-ascii?Q?R1XezgXpz/kDTcFArzljrVo3kbjb9XUzHCJReym6lDBVElxfjXXTXu9GFPvV?=
 =?us-ascii?Q?WxOvJzkta/KBmpRRImHDTMhhu/er8Uz4Jz4wykI8c9Sa53vwBicljvYVqq9U?=
 =?us-ascii?Q?5di/pPplgKk4gXDR07EPCQ6vdepSAvzKFrIZWLJn1Kk1hi+xD+sMX8qmul9z?=
 =?us-ascii?Q?7uLz3q6FF29njcemMi9urq+B1BZ+xxej48BQLL2wvYvz9AnsRErIXLBBT3LH?=
 =?us-ascii?Q?23evYFIIpXwCD5dmBm4I6NCLh72uNZzgEB4BLRddJ92pK9wGMoAfXubmgmmn?=
 =?us-ascii?Q?L1UFE4iIfwqRM6dk2Y8k+fbweax1Dtl1BJr2mYYnwWTxbXvpqmk4yRjOmU6j?=
 =?us-ascii?Q?joEA59czKnV4ezcvfs89cC+Jhz5HOxsrh3JD2BcG/akF5fPPdi7JAZtPWd9u?=
 =?us-ascii?Q?L2q7supoQLsIfIiCos3hjVV933kOD0TcvjCvouEUFWQMufUrr8//njf4Ti05?=
 =?us-ascii?Q?nArQMjEH3NtkU3yAvBhB6deehyRkENhc375299xuzmrNkSCVMBGuvhCa7dyL?=
 =?us-ascii?Q?m55EPFhc8PXKKi4WuBtfLifEUSSZgbQKdjbb+kO0ooSp5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKc8/0dCTz/8Da/KEbIJ+XZGR8gj59EVJ9rd8rod9orwDjZTuDAiGgdM3E2i?=
 =?us-ascii?Q?PbxHtmsI6ae6RAGPCRLALpxMPXiem4CvgEPhcDyFcA6XeH57rSEHyDpSKtV9?=
 =?us-ascii?Q?uIEsvgX/IhRSAlilULOhPd01SH5xsjZWfTlKJ+WehQ2whvzisLjonQ3d9h5C?=
 =?us-ascii?Q?lPm770YhLOFyxSmBbJkB8djPchvHnm5GArxnD0yzABs/GexYSe8jaoawpy0z?=
 =?us-ascii?Q?MMir+oayVH2nIn580i90vhd2qxeR5D7EfGVIDFBacUH1yYOQbnb5p5DY9ZlR?=
 =?us-ascii?Q?/UOHPLPgg2awtm9dYLk9mSKqMxh1z3fzQT+Ddp8BrHyFVMpze0QCDNIRmk2X?=
 =?us-ascii?Q?sMTaFShIfKI/fP8MKgByyK7wTVlIyFLehwihJsFiq1sO+AzAMNPv3wV2Rxs4?=
 =?us-ascii?Q?51h5VwOdrf1JIq8pgCQgJIDfu1aDRKR2K7o9NB/XLKud/TLx+2X/jiYwxA1Q?=
 =?us-ascii?Q?CnsCVG5eg4UJdq41WSg9bgi4lJAMKq1ssqacJeAkZwp9NN5ntSD7pKErWcJ/?=
 =?us-ascii?Q?jDhWelMCXM2drF0XLGspZjzKsN0gHbVRaLEs8no5eccMjDRceW0rEQIsrkwh?=
 =?us-ascii?Q?C558CD8wmJgiJuhPnbD/lMT948rhXV5CWlE5bmax21ra/xUXaGdFib1zYoIn?=
 =?us-ascii?Q?PlU7A2/y5SkvKFpN5lcUGvjPtXMfSg1tyj1c+t9SErOwHV+A3c2cFevsycR0?=
 =?us-ascii?Q?M1ibg+qr1POwWsJ9fKvZokCjI8AfTzDHEHcC/pp52etCha/qdB0X/G9Iwq8a?=
 =?us-ascii?Q?IYtZYFUyRBR2Ccfwvd80pfy2WZh4qbWlrm2/s8J5TGLcrzstAWgu6Ej9GEo3?=
 =?us-ascii?Q?iwLjD9VG8HGf9Kx83bVzPVg1IoxcVm45nkD95jIHhVsAoVG1y45tLHFFFi9K?=
 =?us-ascii?Q?W+l9vkByIhEheYWX9121Y9DCSFyK8X94RPrwH6MTwFj3xcyCVSJnghKEr832?=
 =?us-ascii?Q?Ji/m9NJewgbnSzFQo38XxPkqDUsvR4e7YMzhVbz+ATgCnAXakmBygv1bVPcs?=
 =?us-ascii?Q?5MfAJ6Q67Gun+QKQ7aG6/c1wfg7pPTjwYqsrud5eqFZafm1e+nwl+bwAWMV6?=
 =?us-ascii?Q?oDcnCxRhWBzxV7owRJsqD8/lKNqbqtCKAGnfGKmmE+fibt8pVsUG+N79IqPU?=
 =?us-ascii?Q?9Fh3lhATdR/Eqg9Soe6SYnBQ9rxidc7Gv5olunWmWENNohnGvygEVcJsBmd/?=
 =?us-ascii?Q?LtyFDt0WQRO+1VnXFEQQtSqiHUFWiyBKRT+uHv619b5X6Nu4D7XWxMO9GsX9?=
 =?us-ascii?Q?/HYtt2OrHT0yzsFI+ZvuMA9SCkLMJZMQOcG9RDNiuGMhLw0dYjPCQZJx3f37?=
 =?us-ascii?Q?n1yIHZj1udAGUMtGeJaF+vstG/gfAM17iySBPeUxsqKFxmr1e2ryHA2xe/7i?=
 =?us-ascii?Q?gtRYOoX6oO2UNbEqTDV/LsvCSJjsCQlETL7p1q0ZhPw8gsJBc5OPVAwuzkgb?=
 =?us-ascii?Q?YXbsHhdA5JJFRPTWZev3OP6hq/QL48trw/mgypUYJeDj5olgqNKbwVvsnn4x?=
 =?us-ascii?Q?V9CsF8sMkI+3gsT1sYw89jTF6r9e9g6ezIMesMdEsGfth3Z7PRQvSW1NMzpq?=
 =?us-ascii?Q?2eXZUiRak5CDLC08jpnpku0nyAz7dyubsAEp2xztdvlj8GACySvI9E52Zpqo?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc464372-9855-49a2-8449-08dce90b8038
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:11:18.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ljRDu+njxpH4Acl5TQiJgZCEUVemP4bfc0syGDqn9ObNsaYyZw8vh7ebe0beRW96wxjTHVS1+yyfBuvlnqC9fiuaLJ4VQfzgWbE44wYg5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9768

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
v3:
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3..268e77196753 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,13 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
-- 
2.42.0


