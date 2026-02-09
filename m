Return-Path: <netdev+bounces-257920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJxeFbKsiWndAgUAu9opvQ
	(envelope-from <netdev+bounces-257920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2310DB22
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6B13009B27
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12787346A19;
	Mon,  9 Feb 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WE3lZqjX"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145A258CDF;
	Mon,  9 Feb 2026 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630288; cv=fail; b=gmIBzK0N7V+E/hfpkZHruQ/+4A6tbIwsPh2ev9opqxxjKhUQPnXLr+x/No7S4ZHMS18DDtsoHGWmyd4a6a0jequs33w70o1JKnuDjUatDrkLoSX+mdU8N6QrTt0WErB1qbsmebhDbB9XLgJSVQBrr2MKKIXsKFXarOh+q0QBfGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630288; c=relaxed/simple;
	bh=/tMzyQuQOr8VVtqtNBtzUQtV9dUk8BTKTRfMRWGKOdA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J0cNDvR9a4Ptx1gQ9GQKVbByduZmZDUqyRhMlaiYKb4VGeeUwl9RB175jbZDI04GTbubfNDI5kNlUv60OpWf9ZBFiskEROdmU39HJjzEOcQIJGZ47oJagiGOzekn5D/gq0F3peFIaS+Yh4MeF3zjzxRN74IsAduZjzq8hTjnuW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WE3lZqjX; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEZoh3bKPq7G/cQdiFr6n0zglXUVMmiiVQmp0KvfwxAAdVM9al4IYaSFvnl5Bh3KEyvhHpYqVa0L1dYt5mL67udllaQ3WW1upUoKrCw60FJpjLcexiLIvtsB6Wc+Sqt1UGXcEK8r9GfgGVtKXAI4L6isvFPwxKIB6SVMPnfKH5+JeyWJaLquut5MUoXoAz1o/cTzyL/E2ya847AnGulY7aGrAoGayFtL/5XcprqutY4wjutboQXo9AmRNUBHUxxxt7VIiiFSKGj02m7/NevOCbxcPUv57Gx8rr4oN2AsvsatLq8FSweLzlWetbpIO2v8LQxpF8XHawrNpdGCrAi1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve6C1nPGK3oEJq+q5YaB/+Bt+jkHgR81zWSrpbFPMio=;
 b=iuPljIrcVCAs5lAt1bgsYZRs57D2/6c+hBxdLqZbLP00NTJDdxCELEti9Tx+Zspn8c1Df1PNh3VqK01sZvBxlvCfTlQ4uilk5v5HMekkDMdjEe/lu0aIR89r4H+JMRyoWsowh2VOeiuBa/Hv9s8D0BeaHXe8QLAA00mSP8PX7TE272MMtnEwWoROlKKofEltB0sqyuAty5AO1kH2eFeNw3CtuxRWHIzxNmA0ZU1P61PD8vsNeoXsW0uDvVlpzmeSU13oih9jPn7umhW4UbVwZpwGUjlvL5ufUWefPaGmNjyNPCCOMp36DgFaJfDht2ZuAIIh1tRtecEeJBAwkHjpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve6C1nPGK3oEJq+q5YaB/+Bt+jkHgR81zWSrpbFPMio=;
 b=WE3lZqjXLOmrrwN0kTBGEY8ymN0p0DL1tAhp1HdPKsi0IEu06rLnGbd4UXrzXvgStcC9caXHa1UcI0tuR/ZoO9seRcfiGjbpcH+BwTprCPZ1X2YiC2ean2l8zos7xBv8Czv+EYFB3Fy7nzIiXThxdugZ5XhBIHlK/wGyVEaK9M/eNEH9yuqxYViCOPqeVVUfpBO+yhpH6vOcI2lJq388/vboiRkbbGrnxAETsXEZLJeugBix8/8gRwLPdTaO05UvfYpNCZIOp8JH0qYyYmWrB+iUg475GkDjBS3xGGfHyWwFufhXWRO57zGEfItJPBcdCkuSuzYLExAA0hfSwfJsGg==
Received: from BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49) by
 DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Mon, 9 Feb 2026 09:44:40 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::da) by BYAPR01CA0072.outlook.office365.com
 (2603:10b6:a03:94::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 09:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 09:44:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:44:21 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:44:15 -0800
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<donald.hunter@gmail.com>, <michael.chan@broadcom.com>,
	<pavan.chebbi@broadcom.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] tools: ynltool: add qstats analysis for
 HW-GRO efficiency / savings
Date: Mon, 9 Feb 2026 10:43:33 +0100
In-Reply-To: <20260207003509.3927744-4-kuba@kernel.org>
Message-ID: <87o6lyz1xx.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d4d4d9-e388-46b0-a14c-08de67bfd8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7bnLfA6jUX3ai+GWKlGxpGDk2fowXpoDwGGCVsLocSpoqAnzM0nZlvPtSZx?=
 =?us-ascii?Q?631PCGBLOvpLIklqAtTNUFOUw2jUnifXZ7tSysKHNKRvtUq12wg82OWxlaGI?=
 =?us-ascii?Q?RalF6GF84QBHRgT537j/wyLg6UlHNeAwcitJWUKgUgOhdnb6UliupjR2X04J?=
 =?us-ascii?Q?LyfXdkWiOdm2JeaHzz42lHUMxhromVTBi1oDPdViGDAHTfXZTYJSWqDLdnHC?=
 =?us-ascii?Q?SOzNwTfEOlP9D4bPiGyeArY/ku9xi42sQ/ZfmbRAuk1GlEI4eMzGTdDx7aQE?=
 =?us-ascii?Q?GtyKowGaQh3TGSHHJLFeuIUkJttlkBDsF/kYiECGJEbH8OlaKkwMZc4BaTpm?=
 =?us-ascii?Q?vRLK9hIgSWzldDIxi4KbqoLDZp8qswV/skDe8DGMTrnX0l4oO4cKzYiNTslk?=
 =?us-ascii?Q?eCpDYozgEn6dqnq2obsvu7usk9NioTHDHGQTnxJIzTj+dFuL0zi2WavS2GZe?=
 =?us-ascii?Q?taEQ0Pkm5sSxwp9LAHNc0v8P+r3v5EVPf/oJfPIRF53b7PEK6UGPI54PO24N?=
 =?us-ascii?Q?yEU/DHMOPrV4jtD7ZFAvC/ijI5k+mMxJK8Ef79jUv4LTcM8wwk1b5+9DCI97?=
 =?us-ascii?Q?HUPBRGaTJdHyhoHF36PYoD+BnaKWouI6bwxyZrZTH624rqzUVrsVO0yvBCya?=
 =?us-ascii?Q?8sMiVCEevcsZOifbh/ghkJf8DOwDDXZiJNRQclss1Fg5Y2xBc5xyXIyka6x+?=
 =?us-ascii?Q?D8V4e+fMCZ5b8wMKJx72et8oO5eJSr4R4UFeyztowNWWSBxQLeB4/7MvIYVp?=
 =?us-ascii?Q?KjWUJSiYq6eohswE1HA1hXybM1Zbg88+6v8cubjv3o8FZz73MGfX/gA7+0vM?=
 =?us-ascii?Q?zrX5rDyrRA6GzRFODu8S4mRdEgUHWFRYRKThjepJI9J+QsmN/b4YeKTKP+lP?=
 =?us-ascii?Q?tih4ESCvBg1LoWDt/jCH3Jfx4LMFYf0eoErTvYRIqYi1EIj79RukQePK6QlT?=
 =?us-ascii?Q?EZfvcU6qKacw3Ir9TMcnpnxHJar1YkdC0F7u4UD4A8amxa6nOhZWo2x5QziC?=
 =?us-ascii?Q?9z8R71NsvgBRbvGDVQbJaBFDz3H48e6YvHGF51R/HzpPRObKae0YtcAZ/+BJ?=
 =?us-ascii?Q?DY5ZDzyK5mW1AvXciBc7e0KiZnOgF1p6oF+OdDMb6FVAILBlX1eul4zmO9yO?=
 =?us-ascii?Q?wvjZC61xgffms4qRFsSmo8BgiHzSncGRrvJDGdqLxrXFFe9p01V2iO1CpQwz?=
 =?us-ascii?Q?qo5mN0bYykFij30DUBa50P55hVC+VXKUsnY5BI/pq/HpKRlz5pvxvvsU59Eu?=
 =?us-ascii?Q?ktBAWxnHERHC5lSyhjwSvg4VPRj9ImG7brgoSgtq8loBXUDrnuoIxTGRXhTy?=
 =?us-ascii?Q?HX/9CgodcWsrFzd5ceqmDBsSY5SpvLt7wjJnl6TOh8T797n5f3NeeEz3m4F2?=
 =?us-ascii?Q?Fm/Z4gXTPomxI3NNGF5hqJozhng8kAZez08HSUK1B+N0MnZ/p8H2KNMXbeuO?=
 =?us-ascii?Q?+QEpRLiJmWUNTb/tc8VDSMNYoMGkwO9WAJKhMrzxYe90Bmsm+On4tyS2GZF/?=
 =?us-ascii?Q?PEgURgGbFlYD6iI1PyVLI247t5dBYsyRp60mRO7nrMw/oVIzzaHnoZ/CBWuf?=
 =?us-ascii?Q?MbP1Uig1m8gXsvqYTvGnuwdieymx8aNzVifhwx3r+d4t6oXVYY3ps242L9zq?=
 =?us-ascii?Q?h0gXry3mIfBA3VsvzQdYekh4BIh0s9auWv6lsFS8hmbIZ9HXV9pL3yCMfDLD?=
 =?us-ascii?Q?v9+rFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f3MxfO3wpblQWefPER/4i+AUxI5uu8ByOrnTmJyBHbGyqMbCb4lWUnl4KP/cMXwndIgLkcs02/+mOe6rtG6nOOTGztOp786lA4oiOLINzS1tdgaxiDjy9iVN2BH0YXw6yQ6vk2jBSAYFC8yp/eZpFeTV9ZxyqFYptZabkUecIzm49SMcv9BjZOlbMU6Pe6dW73OxVgSomnD3vhPtvgdMifyzS8a+iDV9AdxGZDeP1PBy1gfU8lmBffj05nYAXhCP15VilaGMtwD47nrpRtYG7TxDSUJ2s88uzGlw0woXbZHmAsbNbzHjj8gyZX4/xcyNrX6vypJE+1cJaNd8fOpUTtERXQxp/CngHaeUT0mupRkugJCEB1YP3wijnFXAk2g2jqFc6IVS0MxUF1mnY3mTe7MIZkpK6TsYZ3hjGm32BaVYYFH2DN2eopaGjm6JZWbL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 09:44:40.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d4d4d9-e388-46b0-a14c-08de67bfd8bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257920-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F2E2310DB22
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> Extend ynltool to compute HW GRO savings metric - how many
> packets has HW GRO been able to save the kernel from seeing.
>
> Note that this definition does not actually take into account
> whether the segments were or weren't eligible for HW GRO.
> If a machine is receiving all-UDP traffic - new metric will show
> HW-GRO savings of 0%. Conversely since the super-packet still
> counts as a received packet, savings of 100% is not achievable.
> Perfect HW-GRO on a machine with 4k MTU and 64kB super-frames
> would show ~93.75% savings. With 1.5k MTU we may see up to
> ~97.8% savings (if my math is right).
>
> Example after 10 sec of iperf on a freshly booted machine
> with 1.5k MTU:
>
>   $ ynltool qstats show
>   eth0     rx-packets:  40681280               rx-bytes:   61575208437
>         rx-alloc-fail:         0      rx-hw-gro-packets:       1225133
>                                  rx-hw-gro-wire-packets:      40656633
>   $ ynltool qstats hw-gro
>   eth0: 96.9% savings
>
> None of the NICs I have access to can report "missed" HW-GRO
> opportunities so computing a true "effectiveness" metric
> is not possible. One could also argue that effectiveness metric
> is inferior in environments where we control both senders and
> receivers, the savings metrics will capture both regressions
> in receiver's HW GRO effectiveness but also regressions in senders
> sending smaller TSO trains. And we care about both. The main
> downside is that it's hard to tell at a glance how well the NIC
> is doing because the savings will be dependent on traffic patterns.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

