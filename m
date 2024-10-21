Return-Path: <netdev+bounces-137660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D09A9325
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6641C22229
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21691FEFD6;
	Mon, 21 Oct 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tTZ1dmaa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7F1CA84
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548973; cv=fail; b=ly90HksPBd/hWtGdv34QDI/EbACJMbiGmtg4OTTyGb48hKGEQ+VpDNOQ2kYCDMnFSiCusHpIhm5YtMvkBcxg0Gvv7fdlvsaD3nTIHE4OPtwYZnNWJe7rmYyehOol6Hl7FOo9OXwJp8EaX0akZiATW/cHNWSlnM8ehCad7WEaH/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548973; c=relaxed/simple;
	bh=bqQPkol7NszG/tLLgfGFVM7sldTA8qePUaIqOwredps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gO9ys+u4rDJXpbI+6dUlZqhnMl9w30l9nfhfoenbUnZT0D8Fpr2X30jrkg2bEVkOd4Oc89XBqOy9FAc1/gLqd8SOkU5+LyF9vBJE1YZEW6TyP3Vlo8nUpZCQifRd077MxJukVGej0g4xh/ZY/H/7MeA/qnnl6G1WWvxDzoFPlvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tTZ1dmaa; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxUZzb7k7VwMDlK+yzU1eeSFGqXCtF+Dmk25ZJFcyDrOTBUmG18m29qrFuNKu0GiWjzc2ya3Muu6d91sIxwgATqjZnbBe8nVWVHkNHyhK4Xb4FJ8xmGjeCkzs26FXyLvfkmLQeYyfzuAH0D3ZsCyjYPyBGVwkyJseEDXan3bKr2mUZmiutzgqilkS7AdzfhYPtxnqDzh+0QIugSipoAdRU2VsbzSHgE1ZYt9ks7FPaC/tBAklJkvws9cNCpFIgOnFMl4eHO+GWWEkYdTwFzcwfWK73KBZv2masqMd+7yWkVVKNKWq5X6MbIPk6ANjNnmVFNgkPKEkAIeoZQlksspYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbVP+eHM7FntawUJp3mazx5tCRYama43WY9xXDeV9ZM=;
 b=OCNUzlE6xDzlUFRySe9da3a8HmaNF7sbfSW9PQJtMQoekqr97oeFovN95M0r3RirTgkUJroV1tgAsPqnAelEQl9HIip36JyT++t4zb2M5NiQBZqgPoJV8vCpwEvA2Fq0/MYyVIwKdGUnuYpwfBJ0BvQAuH05CBZP02im6uTQgVLmV9gvZ+La0S6vCbTCrsh1xIDB3Tij3nWTqiewriExAb2i8jRgLrTDaArQPIZmhabchkO5op4lKJoM//QOFUf6Uq3Hhrr9PjMB5cWTs5SIz20yfxF7QLcRn9+C/ZQCnd9pH9KuOuRSgL94Uf0BH/fYN8Qgpah+tABvuY8c/oQN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbVP+eHM7FntawUJp3mazx5tCRYama43WY9xXDeV9ZM=;
 b=tTZ1dmaaDNeDBn40fD5SWY51vjIWlHwAibWt9vmM/fPGhxBHwd999GcmE1p6r+Sroa+F0gW7D2BKgFtA0Nzaa3dRFBk2yp9tIUgwFhHvOfqTfL3+ntoNgDljfEql50hCUuh8B0tiO6Zhkoc6knRRFMiwfWUKQKuqtWBhHXdKRJqvYJuupMBz8892x/JOmTiD0YWvezn1zLwXYmPtf9vPIoTdWiXNZzIvImk00sipQmE6ojVQmbnXYxWfbXwOMURTwmUKz7WWbtSWbvRnALe8tOwJJPYI2DFe+t0sl5z6hd/tTwrBYfOD1CGQJFILCqsBYZ2znRQTzUP4PGyUHY686w==
Received: from DB9PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:10:1da::26)
 by AS8PR07MB8135.eurprd07.prod.outlook.com (2603:10a6:20b:372::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 22:16:08 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::3) by DB9PR05CA0021.outlook.office365.com
 (2603:10a6:10:1da::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 22:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 22:16:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49LMG2xF027767;
	Mon, 21 Oct 2024 22:16:02 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
        stephen@networkplumber.org, jhs@mojatatu.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH iproute2-next 0/1] DualPI2 iprtoue2 patch 
Date: Tue, 22 Oct 2024 00:15:58 +0200
Message-Id: <20241021221559.60411-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|AS8PR07MB8135:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04172be2-be07-4275-b811-08dcf21df56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?925NmGYmxZxkFDPvDmPlEh12VvnUh6PplP53C1rTvz1DofEe+j77W+9vng+9?=
 =?us-ascii?Q?Bq6Th702dtcx1/9q+z1KwdNDJsUw/5s8oTtBPphmvvCsH9vo8vhg4vHNRSCQ?=
 =?us-ascii?Q?2GkRRyz/WMn5k/lxkcPviydQjc79smAFa2FA8bCB8zkZo9mQFQHigt3jDwXZ?=
 =?us-ascii?Q?v4wuDY/MM3VtHyrhs/uuc4Be9ORKSIkJUMnG+sYtDcsXQteYQtW8jzGH79Qz?=
 =?us-ascii?Q?O4w/0+SQInV8SaL2uPukVIrTNCI1Ax5l0Pd8RhkdagN9yqJOEmw+ztDjqC9c?=
 =?us-ascii?Q?ugERIECsTY/oShOD5DIZzFJ4whm7hdllOaF5aXuGnHIvpaDi7MxXH1t7QVqR?=
 =?us-ascii?Q?cB1nItKW+gqoPy1uM0R8RCDNKcX0MCuwgQRNv5iFRLdKG+IU9Q08rUiDrF4o?=
 =?us-ascii?Q?RrZ2zTuorAT+ozTqOvjJET/XMQgMnsnxNMOOyEARNV0/wGSRiw1vXRLrsRAf?=
 =?us-ascii?Q?mBPrbzRr50DjHjUGxgotwETR7T2Gjrocg1Lpwx95mbwfCvFAbnlR9kuQIdrl?=
 =?us-ascii?Q?ziu8GvrObrosFMap2muGofgKChGQ20EC8Rt+Qp+W6g9oWR3HozY6QDs7eKKM?=
 =?us-ascii?Q?en0f6Zi65pfkY+DJydH5VzaEFP7mDwbDz3iAOwl4J3RkUmGRQcA7CuJknfEk?=
 =?us-ascii?Q?eIv+4z5TW7/iY5dFcWP0JSPAWWiKpqJTbFSfzUEQSrbzBcM9vyB/1pf9j1Il?=
 =?us-ascii?Q?z1WU/o+c8l9u/JbxILvD1iTxNSMoaanT3YjuVcNP49BQnRIaSXdrbG9E2n9X?=
 =?us-ascii?Q?tEyex3wk6/3BsjL6pCIsfmZABalDXwRefrMEaSAYv/XFC0+PZvph1zatw/QK?=
 =?us-ascii?Q?SIhbQFBKGvZVavwwQnQbdOeeK8p2iLVk2IVwrHaSLBpBchx8LafteDwVuRzY?=
 =?us-ascii?Q?MKNScrTDqMpxCj5DTaW4KYXrL6kJxqn9tyyA0JR8oCqX+Ycu4JfVzbw/1JSW?=
 =?us-ascii?Q?lres4kL6I0Fwmv05Nl18j3ciEv3QSbXa3F5xjWz/55yaKaHPC0GeOxHaXDi6?=
 =?us-ascii?Q?0QYsv4tyUjMHwAtGt/w9IuEaFENb2CdgZeyQJ5d+eDU95Xkv5/MkdSfC4EAU?=
 =?us-ascii?Q?7+aX0uaO7eq7WD58ndGFPHhBAv8L0WWvjye/clKuYAJe0PR5HZx/w8wBkqFY?=
 =?us-ascii?Q?Q5dlMN/OspQEy+NYMOfUS4zEAF+H4Yel9yHwgcgkbRPHADPQxSgGtA3R/4ew?=
 =?us-ascii?Q?oSWazylTxbnd4W7aCN4V9LXVNqRMMa4zeXeyviBdCSr1qUx+Oh/dtkHjTNU7?=
 =?us-ascii?Q?DOL9I+VUOYWAuFbzlPMXTr2SoCyrTi4NZO3S0M+XCYFhHSSZpIw+gvgbvRgJ?=
 =?us-ascii?Q?EVyf5m4UbpWOBquDg7TMfkolKD1eOZthXHtcuj1TJ+5dl+koCKsC0v6Szd2G?=
 =?us-ascii?Q?CQD8qXrMnHYZ+5952egeUqMRsDvNYqQ5EcgNM4jxUx7cu0uIUxae1yf/BC9Z?=
 =?us-ascii?Q?WI4RxqWzb58=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 22:16:06.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04172be2-be07-4275-b811-08dcf21df56c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8135

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the updated patch for DualPI2 for iproute2
(IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).

--
Chia-Yu

Olga Albisser (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |   9 +-
 include/uapi/linux/pkt_sched.h |  34 +++
 man/man8/tc-dualpi2.8          | 237 +++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 470 +++++++++++++++++++++++++++++++++
 5 files changed, 750 insertions(+), 1 deletion(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


