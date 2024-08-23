Return-Path: <netdev+bounces-121350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE195CD90
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71461C20B12
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B61865EA;
	Fri, 23 Aug 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HvrSDFQ4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7631E4B2
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418990; cv=fail; b=kSiNfQ0lwvSo9pAGDd/b7Qoc6ugasyOTgexhyfWYOupIOtNb0KfIbN3yT4aOirVLWDTWMKHkHIdOK6mZMlIFTWNp5zdfGy0QKOTEix3wgQur1/q/ulvM2fSDxtCNUmAyD5UIt+gO/bW0tyLGTGGtChboWaiiCXC9t+veHFGkyXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418990; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YTAyFUxg29hlhyds5YqXw2Qpa4wBmIvKIdwEYgnIUvIzQqb0n5c1Mym77Dp2fAWIaaX6nGMAhPcM9gJb7gHSsA1/kF3L57FIifbBttR1iKHHEqVDSYvrpJvZcvMqLXxFTrWqmtSohwFSxNXC1NH85gZZ2JS7vDIIqr7B2Zi+M9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HvrSDFQ4; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hop7wqnSHZ4aK6V1gGLw3Q70qKQUiN1aK5hRYlGfemDqFwVFyrjF69AnBykXee0eMpEj/JrEB1is/4X4ri00c5CAFVze4++fmkB78n5SfR2uZM0mBCsegi0uMqaqIWrMRPZkcJALf4t6x77FkSdmGc3JMhZ6VCmo2DaWSpWTAagdfgAlWKaNtcNINR7GkWxrOU16Eum6fTGe34aPSKZ03RZcVGu1sbdQAZB0QKeahxhFMEQyK+wPULS9C9HNqNjYvEEY8KZl8hXcd9Wes4IswvqEgw+3wycm27tsm9XOQkQs8W6S1HdO9XIdt9GYw4vOPlWcPvyr+N3MWZifL8kdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=S3f+LjcTPs+y4QlYpfxrSH3TNA3yYi3DvbT6NHdQ+nR1/jPOK8DoOiPNrDrUuwYfLAZTvvAYQDYUIYlqbgNQysFsxKXo9Qk07IvmMLL/1VMwvWMxFvRCQCDNSKMcbqrpast0DBo7mgILz/dDeEhHLTTMt0LkdIUB+jokpAQthFvDi+b7SBU0nLTVNRpcsXDGsCJzw7yUJbbS9zKglOq6F+8e8994pTAIRrcIQsPnHiIJOcrBcc0HdDGJrET43Akev5kDLsRFyOOFGtZSiC5jRDamkMNkb7nK8eLpkRgZU9ThfJDsjggE0mQ5ucG/rsLhWxLAxVHvKGuqgTW2VdxM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=HvrSDFQ4CsY7JD4c65ID1PwCSP/5d8dxcAjUc3Qi3XH3pVhs/SZ5FTY0HQT90ntJViB8zWLXRWNTY2lik/jmmnW+RcWwS5JJQb3PfGlSB8iiuC8n7PiMv/11BF4Ig239OfBg/oNB/lzcJcz8VtjvmHSulGei6jy3t6MLmkTeEA7vCnblt3E/bp8e8zq5xVZAIhNea2QOwAhYGCB9kwp8g8b5qUo1UOFCeWYKbPRma+qVSCFz8hYDE//X2SSda61boCNoFsLIQcu4AsWt7n5uFK4TewSWEGvTDnlb/zezxHXW0uxIQJ12AFXgfGb7fCRRa/Ht300iKnDjZH/bNs7Kew==
Received: from MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:16:24 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::4b) by MN2PR05CA0059.outlook.office365.com
 (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 13:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:16:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:16:05 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:15:58 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-9-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 08/10] ip6mr: delete redundant judgment statements
Date: Fri, 23 Aug 2024 15:15:34 +0200
In-Reply-To: <20240822043252.3488749-9-lizetao1@huawei.com>
Message-ID: <87bk1jjs6s.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f35799a-3d72-4f26-20d4-08dcc375c9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jDH5glE3LQRDR5ja+kdt3cuYmHZyQs0yYnODzDio/G3VepyvfeQHeG280yvC?=
 =?us-ascii?Q?z3zbK/sNYeu7q7GaAPmPXmQJAJdGUCt5hakuaPQF0e2eaKAzLQgS29sI8ddS?=
 =?us-ascii?Q?aFKv3OomNGrpgClb43nF89x9KZdXlDTupo1hxDfPuiLGAWuVmxRCt8wDrCTy?=
 =?us-ascii?Q?87+DkqT0Pmk48WIOuvyuedEQ8G2FLM+q8FSM2ClitkjDCxslDRZs6nk5l+8K?=
 =?us-ascii?Q?EWYm7SXwMVX/YN3yEtoZmjhIpG1RLmtxpJhzPYSo39udDhtizl3RbecQtnnJ?=
 =?us-ascii?Q?OAmIVYwNvi2RpCGwr8sKed50rLmaHN6p051iT0023/P1F4KZ5ojj1R9QIBy7?=
 =?us-ascii?Q?rwQDavU2YM4x9XvB3PthoAo6gDwSSepdTpZs2ykR1gz6STgz5XWYl75fI48M?=
 =?us-ascii?Q?OjAOmRzdvHHJkzGvWVFWgdyw9S8L29i2TgfVZRalLpG/sY7YCNp5lbntpTDJ?=
 =?us-ascii?Q?qoBjMx4UIy3Xbir1ad638o7tEFM4std4p33IL4hwk5VTiQfBDw3RmHE+/1Ea?=
 =?us-ascii?Q?AGS4t3OnH7cJJCIwQynfLayu44yU9qcp05Yc9mMMnXHW2OcHQT+dg15Fn5pa?=
 =?us-ascii?Q?qKbPm2OH849HVxZ6XtBOkYBbEzjed5UQM5/8zDJ21nz93HMH7GxHOod7onZn?=
 =?us-ascii?Q?Vd/bkcnchepE7bZpJmx0hqZTZOIEU8SHb6+uzgmP+/UP7NgOSP59anuarPl8?=
 =?us-ascii?Q?KGKYXu7CJQ0RPLLNrlOo09XvWjmEu47VU/EJIbLRvAlgc6W//mp8XwwaSDeq?=
 =?us-ascii?Q?MRvINb3PKjRKLdIoXRBUB6RgoLL28Fo1om2uyymqDu4RgaWSYMifQFFr9r4y?=
 =?us-ascii?Q?ICXZnCRUg/sLG+mEj2yFmr4dSQlr/k8f3LqUupkLOaRIvwKV7Y5d4mVYEvNL?=
 =?us-ascii?Q?whDm4SMRPTBmUvmJOCq3XaxfnfsK8F9crDTPUnRMbcp4RnzdVZ+25MlZByNO?=
 =?us-ascii?Q?Nic8BgglvgwI7Z/ptzKmcGkRWng4f7/Q7K77xzh1LePfLRWUNd9JlPVEdAJn?=
 =?us-ascii?Q?jUZs9R/8i4Aq5UUz/fTVyV6Ary2llYkrFWZG/S/w7vjI7Bq7bTitwD/3SkCQ?=
 =?us-ascii?Q?n3NGz2g7SGNIBtaMuKpUYOdncU2pmZuZhoPEr/cNfdVd8mjWZwz+Wzng77FF?=
 =?us-ascii?Q?mAOY6ps6mcuJ3hO6Oc2Cz/R/EEltnkkDJxjrliSbP0bSsi2AAE6HQcbUTuJC?=
 =?us-ascii?Q?RDebD+9ZoIunrqjehvYu3EqA00JWOJI7fcFBxj59lXJoSCE+ZvBXveUkuY53?=
 =?us-ascii?Q?cojfYq4DGIJuv+vJkTCV3OnBDPIWND2WFcKnTMiHJiwJhQw3E8SdK65zKic5?=
 =?us-ascii?Q?Y4NoePMuTfmlHqguuZ5VCnPWSQajnHGPf/Qn27YxagkDfu1kgbYJw18dyCwN?=
 =?us-ascii?Q?UYafDTL+i1ZghUXROep3prRrJjAjA1TAqRXfAz9hOS94yPj5q4OVrEFxNeH5?=
 =?us-ascii?Q?Q7SLNRV2c14j6avnL8oNdNJY3nawkWvL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:16:24.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f35799a-3d72-4f26-20d4-08dcc375c9f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

