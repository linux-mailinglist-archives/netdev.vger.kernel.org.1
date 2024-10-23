Return-Path: <netdev+bounces-138186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C99AC879
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C56282410
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C691AAE00;
	Wed, 23 Oct 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aDzu4rGV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A871AA794
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681492; cv=fail; b=m9zl7O9x0Amt1WXoQ4gz9zSXxxPwYIGsAsF+y9+0Yw2kby+TnpHK/UepPHA9mJ8IxnWuSck/H2dBijwXhEsXL/ObgV+u6JUcXNgGkKP7x3NryIWLNlRemXWSnGS9ejsxsXvif2lJ79Tv02Cf/11AFPkssV4KLrRW+R3zvReJ28Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681492; c=relaxed/simple;
	bh=Nupfzg1xlhTBeYXKEyt5yknZU37YU1Vqg0oSw/hdv1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dSxs6eiHaOwbQaJXoj8dTK25CLeitOs/yV+pLWcpkq/VGPC+nLs19o0AAL2yGq1Ar5nqStoi4kKlVsP6ytDh1YtAGWfjvAcAFR/ez/O5YqwkR0fVDbd2tkKiD5DStTA7lHpjen8Lf4YEjEN5M1knSUbrDNHbOk5dZ6DKxr1L7AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aDzu4rGV; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjbni38PGILM3RT34qy4oO/1k51LYh1bhwPprPjWL2akt4QAaO7kz8TyYnykHKBcArB8KhLUtDRP9ocdoe0tL8pcul5VMPMVICgJwz33QjisG8UOWaBilIx7qp0lro9TeZ3THSvYyLGRPetyMOQ6dd4ycfLoiv4/X4Tshg5IYcaaWPLlf4iTlLBlz9fAZUtNv1lE9QQVd5z15ImmHmAj7G4scohXO1CfRuDTX+wrZ/PbHibhcQACS680v28/0+5sd73aw4dHgKrCQy26V/W9uSApaHU6+LPWtDZvIoy24Ie9KetzyfT6VGuzxd00CtsJQNElGou5cS3Br3BU7XhQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LPst1EGYbswi/Rl3FUdvVAlmyasdW0EPRh6UPHkEhM=;
 b=F7578OnyJT9iv3g5pNHcTW4LX2NxJl+8o6586fr2fysuCLtwuLSRYdChryz047/EVtqn5XUvIJYXXUGe989WgRVzBuCfj56cBqhbq5qsVpkxI7qQL/UvC/XeOs391wrU/6ao9yEDGUBiAyxPNhl4SiUGEqnbe0IS7vIeFNw3674066W6Us6RW4ji/Xx4LdQ/vAdiXfX1gmWf1cLPPuOAPsAJtMixCCkMML5v+xkZDtG19z82uW5Gz4C5oTkNIgJ22Lr1ui1+2//RXIpMrLCjP9SHknwBw5d9sboogXv8nuv5s9oKUr5tw62SU9K6XDNBDaYtHCbqaMTkAhJC7azH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LPst1EGYbswi/Rl3FUdvVAlmyasdW0EPRh6UPHkEhM=;
 b=aDzu4rGVJRKWU7vSTmgcdWUxmf99zpDLdMXX4ZlDI/kXSxrszMCdXtvb1aSD/kieVV7uAipuGP8zN9Ko/GfdeKhSaWBbhRgeVHBXyyM7iQWpNzWJg4zyBsxMJg1k2RZPKvHHU5+AlWVcnObOzYdW76QCT1tjf8ch+K8N1QeiBiuZaU+Ho0aXgl32lSZes9jO5IgLJLlL6qJ6jhpSurPFydapfx45FWpWLBGVTtMi2hKHskAn0ChHaAWOOmRr0bw78Z+R9k3DQBOwA++CIYhDrHOfvXurIw8PrbcNKFhl4TOHXxMhTfWUv/qI4prVMyLxLjEOmCLd7RCufNZzKa01Cg==
Received: from DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) by PR3PR07MB8290.eurprd07.prod.outlook.com
 (2603:10a6:102:17d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 11:04:46 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::6c) by DUZPR01CA0131.outlook.office365.com
 (2603:10a6:10:4bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 11:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 23 Oct 2024 11:04:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49NB4aRM021451;
	Wed, 23 Oct 2024 11:04:36 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
        stephen@networkplumber.org, jhs@mojatatu.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 iproute2-next 0/1] DualPI2 iproute2 patch
Date: Wed, 23 Oct 2024 13:04:33 +0200
Message-Id: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|PR3PR07MB8290:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40468390-6be4-43ed-a255-08dcf35280d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uL5Yh2eYH3nRN6xxwog6ct7WdjbqrgFWr2Qvgb+UvQVusOFYysMExGeUKLea?=
 =?us-ascii?Q?ATkcF/JAZ9xAJI/JYWt7ULcxHQCEGb6Ri0L3KkSDYt4hzNfh2WvHPhKFZ8d+?=
 =?us-ascii?Q?o9W9pMXMVx+mgKPMDCwtaxoUkZ6AL9gZYhQSytDpl3YARcyOwUBlkZCUfh4x?=
 =?us-ascii?Q?/Uu9i6crQd8cpy4k4On3S5s+/vqCQTO77jrtThuezzL36oeKPTWZLJDHS72b?=
 =?us-ascii?Q?9DiwrhUBpGswGYTsFeOigGbtgRaW9zS8yetJU8vJrM5dr0VgIL1GFG6BmOiV?=
 =?us-ascii?Q?EXk6LknfdnsVdkUDITTWHNjrfn7e6HgbAJHCLbtHbKMSRZe7XAIe34s1snJr?=
 =?us-ascii?Q?PKXdlwNRRyJRBTobZhASxK9GM5EegUMjRkJ9c/yRf9gRGVVxWyi3SsOjrR9a?=
 =?us-ascii?Q?8Ftb/OmqnUl7R+G+K1OymOl+HupZYCW2Pq84iCSTd/HTH7OzRjY/s0gl+fUb?=
 =?us-ascii?Q?TklCf7yBZPG3Rs++2FirlfRwTGKq4dAS1gTLg6+yg4npC/Iy9n5YiioMfzwV?=
 =?us-ascii?Q?jhT1xard1rf1/xXMa/lSmLKDOyeEAZZS8kumsdR2tk5qAEt1vhlABt5ZmEa5?=
 =?us-ascii?Q?z3X80/SrwKXqyQ9h9Ubywll9kUwkEmqIoRMPHkC5vl9xKYtWJmQnmmpseCxA?=
 =?us-ascii?Q?Ql+YZzJmcpLNti5tLB1NxROoKDUv+WqaEIwAsEtkw5BSczxkeEAwq3AYzVKx?=
 =?us-ascii?Q?lU98WKH/EyVlr2+7GGC+8DPJQtZ+ablNL54sd0KO5oQ5dq7Zb8y+7WDj/Y4+?=
 =?us-ascii?Q?7GnVGFf1E1QXoFJy4UlYa5gp4BOBk47Is8tmlGMD+8xAIX+nnKS43ZuCXbZV?=
 =?us-ascii?Q?GdGBtR8vlobaixbHufnqjw+rNhDuBo5ffXVkFRK3t0KWyrmFE/kZjePtWCWC?=
 =?us-ascii?Q?5S4aUOc5HPqrogw0qWZbi2Ataf28DnMYLf3aM2Z9LE3tYJmBl44C/IPH9NUa?=
 =?us-ascii?Q?H2H7rqpHgeVYzJV20ECkb7hoFvJEuJ1TL/kB/Zcq73iTm8+Gwd1y43nt6V+B?=
 =?us-ascii?Q?TksIqihBDV1/gewTpayERdS5hyDzQSAEqF5yULIzJjvqdFKs/NxvyW6k6ObZ?=
 =?us-ascii?Q?VROr2y+FzIXhDVf7XiZGgLDGwID9a+tnRvzZn2Gu19BosZWfeaLlLGRXAJaE?=
 =?us-ascii?Q?mjvCz/ggScLqwIWtLJaVrg27jS3fL39/JY+4JI0NNwQeZszCkvIiO0Tx1uO0?=
 =?us-ascii?Q?Ebv3l2I+ZB95QVS9BH6TZ6nsurrH3FQgl7fqiMmimuLu9cyi/IyTjcOau1In?=
 =?us-ascii?Q?K2WM8VvBK+NHKBWYaKVugCvK4iFayDcJnfRL9sS1snOqF958JxWLwMuPAWox?=
 =?us-ascii?Q?eNA+vW+TChqe0xTldlIkd0+WBLQTyHWjBBNiWrDkdTyqHIt2rZFbulDeNnEk?=
 =?us-ascii?Q?ZKd6k6LSmF2yrq61uZ9didlqsZjij7vuwBiObt99XceLtI/Wewz/dcIgC3Yb?=
 =?us-ascii?Q?7Yepuah5Edg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 11:04:45.2754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40468390-6be4-43ed-a255-08dcf35280d8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8290

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Specific changes in this version
- Rename get_float in dualpi2 to get_float_min_max in utils.c 
- Move get_float from iplink_can.c in utils.c
- Add print function for JSON of dualpi2

Please find the updated patch for DualPI2 for iproute2
(IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).

--
Chia-Yu

Olga Albisser (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |   9 +-
 include/uapi/linux/pkt_sched.h |  34 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 +++
 man/man8/tc-dualpi2.8          | 237 +++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 473 +++++++++++++++++++++++++++++++++
 8 files changed, 785 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


