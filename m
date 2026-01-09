Return-Path: <netdev+bounces-248544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C499D0B0A2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F9C3001A19
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE027FD44;
	Fri,  9 Jan 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIN0H+i6"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AA14A0BC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973592; cv=fail; b=iHleptXLm3yxTuEzICmiITi506R7Jx/Co5SB9UpN4BTMmnZ1zT6tuxWyv7YgGLQ7uLqa2x+WGw47js8FItDoSml86qAkFrHYvRa6ORZKNfYhGfBTtRxZGj4lY8Z7EwMSEBGNQ8jfIb2lhqK+O/CUHzbZVFl1N3Tc/lYhOKmtjmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973592; c=relaxed/simple;
	bh=hBy1wWKhZya5UaGaBuSG51ICJwuW3K5EfwFTcjv7kFQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K8vp1g0EwITn8z72BmRgjHudMTnoeV+oN4hAlTW3ctKIz0nhV8+79sslmSxKhgz2egJbfg1bVXMM0toDel/BdhpJXQgUkJ/dio+H2IDV2W+nQGIDY5jqmrzjSF0chD+vt2KSAZMen1gv704k7B9JF9/PPiecJ1Q9kG165hmejxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIN0H+i6; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe30Cy9ZMfjAG51tkQOK37V+39Ub6B9+HGCR5dibvdBxoHWiUVbRa87kh5lU5liQ+qpNAr849kjo9uoMPYtS3ERQf8TmLmEA1TOAK9PgimuF82zM/oKWP7iKvBwxceu112DN8QuyZLmaeIj1vzO447xRfR1PzWLxHuf0F990YvxskrjlHyIhqzIFw0Xp4tAUrdX+hHh4JnKc//1oDQaCyMHCo3An91/5RTXDTvdtgreNYv6XrwoU7eh5viqMwAWR1S4y5X0XzrX11ayup3CAd/4G0DeBtqd3We5z0qFlgoq4cMwfDNNgEcKWhke51hU6rNEddSE48FjhxE/i58jQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW5LlOg9Xm+LQ4Bau+hpDYlqYVPAliYbx4zNfFZCAeg=;
 b=Q7o4/Spo2oo51fv/pAnoRJI69eOWui9Y/3zw9tTYejAGhnvqYds7OJ64v5cVO9s6QIY+Oub66yQgopc08VlGwgpF5KQdVtSsYzxxmzae81ZZgq5tMSIOjWTqCCP/u1r6/QmDDXfEFJCItLL2OtubLbID5XavJhdGoDTpeerbhkylSeXSdFVoQ4uVDVmbxwj/z7+Oj3I2K+KIHifEImHeq+sGk71FwdDHNEGvlxZyWOHAFt3K8dDG2WPQtB3RYmpgySfhAgy8X/wwM1IG0zYX8DkvwN2062s4CdUbFoLQdzaQnS54E6uJxon6LX7Ql/e3XFPJDykMbFot+2tSOUYQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=fastly.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW5LlOg9Xm+LQ4Bau+hpDYlqYVPAliYbx4zNfFZCAeg=;
 b=dIN0H+i66v6ltloEZHBzEnuCOBBwKdsB+mu3wUBtdaFxUD0P4+T5W5t3b0hTtIko9bXhMEaeQwe0ghIOVpY+nBdZ5UDrU3ulOfwz1qiHVDnTTy1iM67KlyXg8nZx4JE7BSioZMn2NDqlt0brC+Btk5rbGaBWqwaA4QxCxsS/qmC0u6SiVlTIfZDsUwfjbWRyL1FKvO/S5mSu3ngW8TVZEIaWPkbtDeEAaRuFV/tBx/QaxrkAMDeVHAys2cwrRWi0BBlzoObO0Kz2MvaYsOYTv1hujaBkgTsZ9xmQ3dvYVs0fhm/RO+cRCddJ/RGncl8k4fycaI87aFgNkkUgwWtCBg==
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 15:46:27 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::69) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Fri, 9
 Jan 2026 15:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 15:46:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:46:03 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:45:57 -0800
References: <20260108225257.2684238-1-kuba@kernel.org>
 <20260108225257.2684238-2-kuba@kernel.org> <87fr8f5ggb.fsf@nvidia.com>
 <20260109063938.3445c940@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <leitao@debian.org>,
	<jdamato@fastly.com>
Subject: Re: [PATCH net-next 2/2] selftests: net: py: ensure defer() is only
 used within a test case
Date: Fri, 9 Jan 2026 16:43:16 +0100
In-Reply-To: <20260109063938.3445c940@kernel.org>
Message-ID: <87344e6b7z.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 15897bb8-9fbd-4e2e-81ad-08de4f964016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mm5LW3tRM/RA3HomNVnXBymyOBIZFhG8KQn6MvNzVhcuJ/YekhmKIT0at/91?=
 =?us-ascii?Q?cjmOBHDDB98dEGCVBUKOPXeevrdvHp/BU/NLWR0q7qFBcL29qBG2Q6mn/8WR?=
 =?us-ascii?Q?UqFI6amCjJBg7R0Z3b5FzpN5UXYKlS0BnFgdR6+Z2prpURq1sldH3XkBLoxj?=
 =?us-ascii?Q?sAPm/4bRN06yO3jedVdL0/2DV45y7sQiun+VXuSNri1hHJ75sNkIMgLnodQl?=
 =?us-ascii?Q?Zj1mcMpXnZJvup33znx1Dg6ztGyvSSsLpoxZU1AoW9xY74Xn8N66LQ6BKD+i?=
 =?us-ascii?Q?fYLPtZkf2SxSBlmL907f1xo6iNkc0i+xc3Zd4hnNuhGoMiL5+8GI6Rt9xWd4?=
 =?us-ascii?Q?FzWIizh2gWPIojJdym9vltW3yUMQ+40c99A3bkyO9Cl+sH9c7Bnz8eSrRHHl?=
 =?us-ascii?Q?MudnD0EwiKlBbsD7cmEF3UDeZaePexgrhM99Fq1GDn7KXkXvtfEnv/sHc5kV?=
 =?us-ascii?Q?5Zi8w71bz5kMUg3Ii6I78BVCtH8+4zZ2AK/YpHvW8MWM3hvSXh3HS3C9eeK/?=
 =?us-ascii?Q?rNDCBdRpFT080xBKVV8GM3POpjxxO7d3rZ0kBiKzQXQeKLaEQVyMrjB0Pn1K?=
 =?us-ascii?Q?1VTeerpYFy8zyQeOpcHNM8i8UfUecuyHx3SI5f5novcNUTTGmHPNQOujcwAZ?=
 =?us-ascii?Q?2qnJr8tpXKNANtHEVFzZozORh9+AJSulgiOkVoOw2WyV4ah7ZN0F2l5T4pk9?=
 =?us-ascii?Q?eG+j6aZnvPzLiwMRTYNxGtJHZStpLrsvKYY/OeSXhMfnVCnRJfm5II4R1LgK?=
 =?us-ascii?Q?TDl9tLs60g35InQ+zGsvEOLTZGyEkVDMSjFAvUVReylXjNvTcF0ZGVOntpxF?=
 =?us-ascii?Q?CpEos1823ic+zyzGbjDz6GTfPoaK7rBcSg0TsGNs4D/XFtymG7ImVIeYsALG?=
 =?us-ascii?Q?RtNRbRks7iyBgUmaREPBoyeO7sodA8IV0+VwLXmqgTwo21zRTlYc34cWBcZB?=
 =?us-ascii?Q?X1iZDKHafAQTktFFqg4x3h9AL7KiUUnmIUJAWq/9wx+RI2TU3ndTyUMWakgB?=
 =?us-ascii?Q?H6guW8Grry4Uk2tojgFsGMosQO0ALUTQ//iVd54TRmgXB5NNpWsn6bEew4yT?=
 =?us-ascii?Q?zFHUi0k1ZhamfICUjWu3AeYvnHJVCZjO7mI7sbBMEWd4hLWICvIUeFCWZX0a?=
 =?us-ascii?Q?fIrL7udw5Qr6SrHeNjKaYV6YdaFnr0PxZ46WQaD/ujgvSksUSJmYqVu3sr2/?=
 =?us-ascii?Q?TKehG6ohjBsaJ+49Riw9etItU/sHraph7QvjVXBpvof8kr8d27yB9xbeZZQt?=
 =?us-ascii?Q?mgBf3ZOHfOf/rXeiVs+xblN2rMRaSzU6Itg5rheSFFAWOwpF7e/DMtOd+H+0?=
 =?us-ascii?Q?ldbgYF7ioH81veu5yr+3lbz9deeslRzCCm1aLMNJvFWn14tRD/vUGWFPTt6G?=
 =?us-ascii?Q?zxSOi7EcmeAT72+B39IcYcORG10pC2HCtUNKwbj2iBGg+8bMUXz9KG1rJWVF?=
 =?us-ascii?Q?aKnYTaQrT9duk7IOxt+bKltcGu+5W6J+W0kvDYUIOj9+vx8LbjYYcHahggbF?=
 =?us-ascii?Q?A3/9o9aMbw20/b+MI/lE1zrhT6YATevUQZ9KcNyIQ2OUIPUhoCuAsJziTMCe?=
 =?us-ascii?Q?stRtdUv9J80zq16TX+c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:46:27.0616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15897bb8-9fbd-4e2e-81ad-08de4f964016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 9 Jan 2026 09:23:54 +0100 Petr Machata wrote:
>> > I wasted a couple of hours recently after accidentally adding
>> > a defer() from within a function which itself was called as
>> > part of defer(). This leads to an infinite loop of defer().
>> > Make sure this cannot happen and raise a helpful exception.
>> >
>> > I understand that the pair of _ksft_defer_arm() calls may
>> > not be the most Pythonic way to implement this, but it's
>> > easy enough to understand.
>> >
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
>> 
>> I think we achieve the same without the extra globals though? Just drain
>> the queue and walk through a copy of it?
>> 
>>     defer_queue = utils.GLOBAL_DEFER_QUEUE
>>     utils.GLOBAL_DEFER_QUEUE = []
>>     for i, entry in enumerate(defer_queue):
>>         ...
>>     if utils.GLOBAL_DEFER_QUEUE:
>>         warning / exception
>
> That's what I had initially (IIUC), I was assigning None to the queue,
> and then [] only while inside a test case. It gets slightly hairy
> because either we need to pass in the queue into the flush function;
> or we have to restore the queue if something raises and exception during
> flush (in which case ksft_run() prints a warning and calls
> ksft_flush_defer() one more time).

Hmm, yeah, the exception robustness will complicate it. OK, let's have
it your way then :)

Reviewed-by: Petr Machata <petrm@nvidia.com>

