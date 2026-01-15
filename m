Return-Path: <netdev+bounces-250103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92634D2409A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 139CB301D4B7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1991A352C48;
	Thu, 15 Jan 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBtUkzeF"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631B2E9749
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474828; cv=fail; b=c7bwLmuDeJM2FTSLHvBANi1vqfstgF616ftWOCvMXyeQSpoBgO/d7kEm1QrK+ImRV6dcA3CveCkxe9kiTVyXGOOqWWTKeny8hXWvYSnYt3JEzdQKAH2XTGzrBrzNo7q6mSAlWoabHv7mObkffBi2/lilH8JZsN/Hhcn6gDNvsis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474828; c=relaxed/simple;
	bh=8gNM3D++oVqtafOoT/6u1m+HrwFHq8FcHRE40bvRic4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VJYIeuCHIg9DX4YyfDx8S554WNlGj6sC6HS1Tw1g8US1opA2kB8XI/cWFsLpcJQ5/Wv/vz7P8O5QfIbmtTNH+EnPOVNbO14O2aMLcBNTxL2KefCz8SSCRPMrZssz2CdFw5i3e7BkPBnsriSfYK5DVTA664I/wDYavZc+gjQLyts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBtUkzeF; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnydVEAYMXfehnEk0nsCU5IQ1HNifR8SjPeoy3PyKJ8RHRuN4LeYH1+LmDQc8bakXhCAHHpqB006F4/Tqihij2xnIkq6XDll6cALkla0xhj15FurWisNzWHEdms2LgyQpsZGstbdEshJqMBLocsP3acP1YCS0AdWlHEFP0cUBrYby7uyJkdJsavwbPapZ2hD/lIO1PD5oFNjBP/1MwhRGPxz+CjMfBwJTlqqTpl6zUT2Kt+VZRtiR11gVueaC5VCHyMQU7CerjUPJXKmHlMmfDi8gJBS2pV40kGWhaTWi65ENo+h9uLw7LBR5eXZnPGBz0v970owV8O8nkVJJ8qSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gNM3D++oVqtafOoT/6u1m+HrwFHq8FcHRE40bvRic4=;
 b=nqHTpCD6bdENaRBNBbbYu5b5UnwgBkXFUphJ8/UPw1FVDkZ/DpJEPKSR6CyIZleifM3vrviguPEbiDd/FiQFV8dHBGJuAGYVmHZNDE66S85tuUwMmcCSvwQmmqpyih7JaMlEsi6fKe/lIdercp/Ahhtpx0T1h9sEOTwpyNQClAA5O4nP8vTSnsiQcMlHrL75UMX4xabSwsIJLz0zzs04gLK2QD7NsHpEGfssBNQH8Eu7QBXFsjCI4qi8WsmGRP+FFzlQG83aDlN9wD1qxOUKqZbgqmbSG8h8usJ6iGthNtdBZPetFVqDlklawMl9cSRKxF6NDnsbwGcSmV/KcqWMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gNM3D++oVqtafOoT/6u1m+HrwFHq8FcHRE40bvRic4=;
 b=mBtUkzeFepTngJZCM5bLWgapcbNLzrQ+Fcnl36bXn14tJc7+b8UtzMci3wBQO7an7OahT6ltI6oxmhhFTdBdjdMYUJlG59Lyi3IfcuYmIY/IPCt44oxM3tnHRL7KnN9FkOVOVy4AU6gBI5UW4v4mDZRqY+q8hTafy3rpbCZVdumDlfIRdIH9xuMry8OJWJD5n2BLF0yBXvgFCOYlfqMKkrjCI8rFEYqcWjAZGktLf1Z75Jq3JuShXxh9vjoNxn2KwuZNtCOBjhcV05CnLDZVJYLIYdrWnpfM7S2zy8Ic8FMEd01r3CMC+RnRy8iTjm6IhBNY+47d9m6RpgzW5eWpTg==
Received: from BN1PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:e0::19)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 11:00:22 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::a9) by BN1PR10CA0014.outlook.office365.com
 (2603:10b6:408:e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 11:00:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 03:00:06 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 03:00:00 -0800
References: <cover.1768410519.git.pabeni@redhat.com>
 <551e2839d870351c34f656530bfd5865b9b131bc.1768410519.git.pabeni@redhat.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Simon
 Horman" <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, <sdf@fomichev.me>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <idosch@nvidia.com>
Subject: Re: [PATCH v3 net-next 10/10] selftests: net: tests for add double
 tunneling GRO/GSO
Date: Thu, 15 Jan 2026 11:13:30 +0100
In-Reply-To: <551e2839d870351c34f656530bfd5865b9b131bc.1768410519.git.pabeni@redhat.com>
Message-ID: <871pjr6t08.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: eba40d8f-6867-495e-0b16-08de542547cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03yY9kmo0GiJhlgp+U/cvKTg/97IE7HgASfcSR5ZjK21sRDBUfnJSbH+ODfF?=
 =?us-ascii?Q?jFqFYvrVnKSvp4G1gfajnjv9tQQa0Gl+oO+lsg8fth7ZOIBwZUs4VQb03hNw?=
 =?us-ascii?Q?zFrE2ZHqeQynCm+GkHfK3teg01U3jYmDYLry2NchfkgVGE/Xxb/eq94Z3C3x?=
 =?us-ascii?Q?nzjV08l8KGe/vBFg2kWf/VU0ByaXPQbYDq80/SUx/4DUArhlL70gsS5/L2+m?=
 =?us-ascii?Q?S89eIa9laH0N+fD4gpXu+ee4wEiyLspya8UmC30eetZPTlSVNQzLjtwCXoEk?=
 =?us-ascii?Q?r2bZPeGisU6t/WyslKthLtXOuuOfN2KWeouVOUHdFH8sTKlJTIjS2jbvey5O?=
 =?us-ascii?Q?Xz3klTJpHg6xQ+Ff38fIvb0lxh9fhCBBPrz/7K54YyDVOoee91mMuMKaSJAZ?=
 =?us-ascii?Q?s+a1Zo7M2a0Yb8bj38rGjVKex0tAOU6Jv/Wg8+BMVGThShiEF94wqBs9jTgm?=
 =?us-ascii?Q?4o6y7SVAoov4iR9D+swDizDT1tMKvVM5HHk5xoKHVSGLg0MxYe6DBYEhRled?=
 =?us-ascii?Q?DOyRrcQwy9eRR1aFMkHgHH4E5cnZACFgrdg0zVyAo5EAQUBHE7ZiYxS+wI9X?=
 =?us-ascii?Q?jOm0y9YMSrmm9lpgKGuEmfrdzLA13P4EU1SxT0k+ndmzUaNkR4PlaEVgdSPM?=
 =?us-ascii?Q?DsRrIfS/+HZ6qeULjoyXvH5S+V7HQg7nHYnTUnZzAZVDdDecokZryHheH923?=
 =?us-ascii?Q?QNatZhUnlCEEyQEXdwEzRobdA9SMicDy0EUyN0nZIwSnjf8dxEkpW1w3Dnyr?=
 =?us-ascii?Q?u1rX31Tszo5giqRkPLXJe/SE+OmTFliKVfd+bCK6SNwu9imlNnJTxtuCBPGy?=
 =?us-ascii?Q?NX8PR6m2oC0og9eRBPRReNm0ScG4q3xzDJYM66dOUEGFl2zi71QirMoFOOxr?=
 =?us-ascii?Q?leEGa4X1ae+IwSQ7tr7uCawYfYyOpHg8LWP+yzoEUuaNnnWb5iY7clSL5b9i?=
 =?us-ascii?Q?O2nsXm4OFECatOoiE7URtFtgAT37z67v9rCDaLblq5KmupboFmoILC4JPCIG?=
 =?us-ascii?Q?l9KPDRujcJVJ7EunIHhoB+p4zNdCVrrkOl7l19ik2vJ5AeL9MCqZp7LB9sk/?=
 =?us-ascii?Q?2DQvzGjZU+s45d/JO15SQLSLy0poiklvrlIm6zcNMoT7gotdN1+FF38GOOLX?=
 =?us-ascii?Q?f2EiSjLor0AD0weGKNBP4ftTPmVmeNocROlWBtu+sQvbO35Ut8FJrHBTU9FJ?=
 =?us-ascii?Q?1CjNrJg8LxiOu8HIN88mr2JJR6AuZE+clQ4/Qy+dliuh02cfG/ChuYgjkgxI?=
 =?us-ascii?Q?nr5elyjJjT/82R06KQxdEjwjdKJ7BYdEZKzvFtF00suXcPq7+19t53SxX1yN?=
 =?us-ascii?Q?t5jIBY+F6Z3/uRC4Hv3M7eJ4hZ/wib+d8mpYuARW+5pd/XcxXrAJNgPEC7/V?=
 =?us-ascii?Q?BEidkZdpQY9ZBiBy98ewmhaxEGeQuyw+bvW1x/oN3XAQXzlL99PDBN5zvfaV?=
 =?us-ascii?Q?XqYKf9U4JHwxOV4k1pZqsLa/QAeBI/4mO4JvCyuIDZ/MQcDKzECL3dAgxmm4?=
 =?us-ascii?Q?qsEiHTohk3Z5/X6EfZK1YXFv00r/3cb9EbrW32PPXElCoT7gJGr6CphPMYqU?=
 =?us-ascii?Q?W1CPqh2XAivcSPA/zKDRKrNGL5tZAQFsKXkizOz8lcUfWiXWCTQdVCpmTQsb?=
 =?us-ascii?Q?wU491IR2mXWXs6JqajpQfTU7+39mhgUZf0bLGtDOoMJbJoR7vR66HyTuHmDf?=
 =?us-ascii?Q?N8G7ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:00:22.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba40d8f-6867-495e-0b16-08de542547cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093


Paolo Abeni <pabeni@redhat.com> writes:

> Create a simple, netns-based topology with double, nested UDP tunnels and
> perform TSO transfers on top.
>
> Explicitly enable GSO and/or GRO and check the skb layout consistency with
> different configuration allowing (or not) GSO frames to be delivered on
> the other end.
>
> The trickest part is account in a robust way the aggregated/unaggregated
> packets with double encapsulation: use a classic bpf filter for it.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks OK overall, just:

> diff --git a/tools/testing/selftests/net/double_udp_encap.sh b/tools/testing/selftests/net/double_udp_encap.sh
> new file mode 100755
> index 000000000000..055f65b4d18d
> --- /dev/null
> +++ b/tools/testing/selftests/net/double_udp_encap.sh

> +# tcp retransmisions will break the accounting
> +[ "$KSFT_MACHINE_SLOW" = yes ] && FAIL_TO_XFAIL=yes

You should just be able to call `xfail_on_slow' without an argument to
apply the setting globally.

Selftests shouldn't have to touch FAIL_TO_XFAIL directly.

