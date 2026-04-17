Return-Path: <netdev+bounces-279217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zjJOAteg4Wm2vwAAu9opvQ
	(envelope-from <netdev+bounces-279217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224041660D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13436303DF4E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8121F09A5;
	Fri, 17 Apr 2026 02:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B12E1F0E;
	Fri, 17 Apr 2026 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393945; cv=fail; b=mosrzSINLG5FOKcE5+CCmqDb+b3DOQ1XTrrBdx74wYRqQfBXvTys7HLc3EYeoIPltRU2dd+AI0dduexNy8VylLrw+cbtMmOi2v1CyC7koAPHzDroPp8Liu7qzknJj+qnZX36JfB1/6VIOCfuquxYFOdrah+6weKcJdA6d+57mak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393945; c=relaxed/simple;
	bh=NyjLV19G4YQvvOPwV3x8TmP5XaI+Lw7S8lHprIgKxvU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F9vdK8KMitsVr1fHeQAL9Dn7+VxSUDkbnl/gWhPdaTRAiFR/O7QixbUGO56aifcBkA0MGX9vJln/53w6TnnaqynSuR/R/qb3mLuobiir2T4825quPUWZFlgWjt3GhouRcFZOtPReCvZWhuWCGKxLSrHFQxply2dPJmXlTd82Mq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5of0svGxnkX9xQ2qq5HLRBnr3RFHk2T1uCeML39uqSs0lMy6bHMdC/dHpLtXaru4IoZc5Hn8fOPslsBmVLBZ4MNq5+mlQc8gpnNjl/uAJvF92yIQV2L2zY2A3Z8LrX5jMtPYRMpTYZOZ7uNBKjkhmIaKwSK3froZVRQke/lTI5Laj6hqYvic5QnoguuTUDjTsTaGuTH4JSIucISJzZ1Bhv6EUbm5VWxefLscXPFE+JYknwBooWP/sJ3F6y283Z5B71To2bFsKRMGSMMF/UI0V0V920y1U67ac7ldIpvZ8TN+Jcui1SudXE/uZHu7eIsQuzwGafeYXWJpZPluubSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBS+dVk8fjPlFaPGiBV3bi2ohi1pudGFfBYThY4spvA=;
 b=ez1xc6W8EYDtK4XpQEijfbsrelAD+uheLDq3zq3fkUsbfu40VH5ahPD05Z7D+H3wcejK56h//hcR3lBvMAyhDw77Pxt5e58Zkeu+vpgV1drqadLCSHX+MzWoKUQs1WvPxvPVYFa98cFTftnf85v6m5lzlpFgthw8Rvw7cAuuO4FY/sLtArNrCn80UHXzcnPTBkxDAAiEE6xOtZsdJ9caoSlwQ6WYBdzc/qvTQBrMnkWh1E+oycd96JUuwt3kAq3HjWUiDNmsGiyvKjIyR/FzpvL6C6YSZkxZnYFznVKSksIvmz4v5hfgsKrP+7Iin9gu5Y/7lI94K9ktl5EsAb/SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 02:45:32 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Fri, 17 Apr 2026 02:45:31 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v2 0/5] Add StarFive JHB100 soc SGMII GMAC support
Date: Fri, 17 Apr 2026 10:45:18 +0800
Message-Id: <20260417024523.107786-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::20) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0517:EE_
X-MS-Office365-Filtering-Correlation-Id: 081fd850-ce8b-4d7a-d2f1-08de9c2b647e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	GyvhqVQxVUpxbqiEmEk+qKfQEbHgHfwP6kPhTlJPMD/O+jnya17a9htcEUGI8MtWXYdxXf5ERZZqxWUv24OZu5w48W6BaXFbRK19aDsrAQi3BfKA/rKCxKh4PMAP0LbQQ4dig1CjWucJW7t9ek/1k1kF/zvCc8dwp7RfaSlhsBFZHoEsTcII/O0SSuOXiGU3yAmGmYV6UAuxNpzDu8rsiLXuXTl7avjr0s3y49B28FkRrHUhAvnveTUErFtEHiJmp/vnsTpnk6r2FVh7O8c6NrWkIlViuDYxpfiq6k0cY5aC52WN7nEPFxNoXZFQDeSdsL+mTdn8hc9crZtq3pwnakN4xN2K4xc4AKkiA36gpDVkDtaVqUwwzW2z+A3gqmpgkpaTUcLItKQ/dkwQIQLq6v4/fgi8QcocEGfOtifpxgfkWSozswvtrC7ra6oL3/Z67ORbWCo3hVGHlnJxVHE+ME8gWvV4WSyuMA5k7EuwTJ8z88tCtcipMrOiT/t4qXDnaOkAjgF3xh5g4TjiOzoTOHbhR7ZHfM4FEm4FH+Q79o35rpL+EelnI0V/9wOh6Ay9eNUu07zbw41I9t7+ntWUtNe7Fx01Ol4OJbXil8RV8WU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F63uixmKcd4K+QLiNWLdhhxy8OMo/ZTl2NJjg44OxrLX+Ek7hUHVnSvuBS3P?=
 =?us-ascii?Q?LIJW9rVAFCtWF0muBD7ipk0EbiNCd14DFX6SHocyyYoEODpUdUFlNq0ivjc5?=
 =?us-ascii?Q?7Xg2H0gm71zHkExIF1ouojYVHVHMNID/shUWswZPvE9RsdV7OR5raOtslwmU?=
 =?us-ascii?Q?TYdMYsMVUdEA5V3ueSb/2UBn0SxvHhDZeU0H9MEkrsgi9z8lWatD6iag57GN?=
 =?us-ascii?Q?aIOiV9imlG07TvcvAbzBmZ1atJbyawfD/oJFghbKyrsuedLio9PSsqhdYbs1?=
 =?us-ascii?Q?wBBXcKQr+EROGIZ2MWrsrw8/pjoWewiaq8k6vc6LYwzzGXbZoj0pVLE10nqc?=
 =?us-ascii?Q?sKokS3tQL9m3dwroEPXwMQ8t7dFzSv0i/NUEVtM1hevmuI6FdNBCUJA0E7FZ?=
 =?us-ascii?Q?Spb0XFJfAOoEOs9vcYwsRSh/Zqd5QCnibRlJglKfaPZZ1QMlwXU3bUq1mqsP?=
 =?us-ascii?Q?YdPjtyQqe3cc0X71iCK6fsNcRYXHuCsyRiBxOWpQcqhbbLZwu0tXvpBXADOb?=
 =?us-ascii?Q?DoObOe6VJlhlvyPktDvJ7BxygCp53YprRyC/ei6XHdoCypfl63IuA9LoOE/f?=
 =?us-ascii?Q?XMO75bsOt4rryEKeafcq5ideryWhn3SVXqTtlHrXjno9ZEDD1m7P+sPSjfy8?=
 =?us-ascii?Q?KUhi3I0j+LU7+7KsD1BCxZuQBFhc+bYvDVQe7O+dX8pPLZjX+VPewvOEy87g?=
 =?us-ascii?Q?BFKgn/yfFQ17NDQMPvgTVHd7/Hgrt+CgyUpQhqZPJBTH/5BPe5K2qRvCI6h4?=
 =?us-ascii?Q?DvJph14fQyLxBo+IGnetbXd2ME+6xwBF6g1K4nhkvpwlzzUae4RM3WkqGqiT?=
 =?us-ascii?Q?nOouDA06vVw0+lpyf/OHRBsAxzqo8Sbv/JtQ1eudGx/CDg40PD8T2uisNBf9?=
 =?us-ascii?Q?nSrx7Jb29ieZ3Hcd3+mgDt5oclQxWMHKQG46eLSQXzebM553V3rcRZeK+6UW?=
 =?us-ascii?Q?98Tskr62yc7a7IdOQVvqonnyfj67nIRA5GzcX4m24KPJmHZtNriAXp8xRhei?=
 =?us-ascii?Q?LvltjsBQ46ZoVjbkGsfa+8m7LeFwlDvr7Nufc//RDT4m/7eDvxOkKev8tw5y?=
 =?us-ascii?Q?7KwIIC+7kwQTVW5oLQbiJwwFxumIY9qJtTj9ih3MQFyr1V62sxP/US3UzUwb?=
 =?us-ascii?Q?qN4Lk2uOGrChyEBa7j1tZgKVWPImUlpIHwxplOCYO7hYqmhBZf4gMgnuBHmI?=
 =?us-ascii?Q?VJ3vwRwKG0fWvPkBBxoSJ2V4tTOz5z8V7FnoRoHs3tiFbntcu09q4TKcY3mD?=
 =?us-ascii?Q?2wwrY18kv+/Pb1NgUWFo/Dr7E+fvIOcSUjZKzv3pCW12yRH2UdSBRRlDlfxy?=
 =?us-ascii?Q?FeEEYOx5YIjIcy/3pKAuM40pmBmTSNSZpvGQH6ZDuZEr93D4VI/ifGhpWS92?=
 =?us-ascii?Q?7vrcJnr4bumixWvaqQzIKyGL407SlN8G1MntCC6R7Y13q2DsVzVE2+CzNb/c?=
 =?us-ascii?Q?sEIi6LrHKpoKqt6iO91GL/8dsJnLMWfJuHGbGFFBepLOzI5h+Dfe59uKcAvw?=
 =?us-ascii?Q?CHRaATKLc/R3msRUqknKbzmA5c2ZSyrVLkBZJH3M4DFBDtlsns4gQB40Z6Uq?=
 =?us-ascii?Q?OH/OHD/J8FixokA0ppuG9K0bBSv9BMqU5eYAWjIlbpmDH9aNS+3YITLLIitm?=
 =?us-ascii?Q?qtUySYU2Qfum9a8UuvTxzRwPkzxdI3iMn05a5NR2ELgi0O15wpAtSjxHj3l6?=
 =?us-ascii?Q?2Kprk0z5LjcuWFTGNbmFhp9QHuLj4Uf4B0M9C60INfxPPEQtunc1gPbqDF5h?=
 =?us-ascii?Q?refai86e9k8wzDmOXe6SrbSmjTWM+iM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081fd850-ce8b-4d7a-d2f1-08de9c2b647e
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:45:31.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3W+9+Ouo1VfDgL7HrESAEUHODl11xJXdIG6DMMHw1ryg6QD+gUEaHziUZKvUv/ktSCY8FK831vAjcoBeHPc7203lLSvRlV7uukgOqm/2Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.355];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:mid]
X-Rspamd-Queue-Id: 8224041660D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.467700-1-changhuang.liang@starfivetech.com/

JHB100 GMAC still using designware GMAC core like JH7100 and JH7110,
and contains 2 SGMII interfaces, 1 RGMII/RMII interface, 1 RMII
interface. In JH7100/JH7110 dwmac-starfive.c have supported RGMII/RMII
interface. So require to add SGMII support to dwmac-starfive.c for JHB100.

SGMII serdes PHY has been intergrated in JHB100 and do not have driver
setting.

In JHB100 EVB board, SGMII connect with motorcomm YT8531s external PHY
and support RJ45 ethernet port.

The patch base in 7.0-rc5

changes
v2:
1. patch1 Add the remove reason
2. patch2 rename rx clock to sgmii_rx
3. patch4 confirm sgmii rx clock exist, or will probe error
   sgmii will not call starfive_dwmac_set_mode() 

Minda Chen (5):
  dt-bindings: net: starfive,jh7110-dwmac: Remove JH8100
  dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 support
  dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 sgmii rx clk
  net: stmmac: starfive: Add JHB100 SGMII interface
  net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag

 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 89 +++++++++++++------
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 56 +++++++++---
 3 files changed, 106 insertions(+), 40 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.17.1


