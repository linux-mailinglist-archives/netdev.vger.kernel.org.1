Return-Path: <netdev+bounces-207881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AEB08E3D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1319F162241
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C02E5407;
	Thu, 17 Jul 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nosi03nm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F42BDC35;
	Thu, 17 Jul 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758974; cv=fail; b=Rt4tUqR96D5hRangDLtWZee2VfKyumz1ROTSVm40wBkHSEUJI8JZeZq3eY5H+VWbaytTkXM6q5pLPZDj+Xa6Z0mqrWRVn6qKiizWWQIVDW6iiNBcKMSgqogH9gWkGy6DH3r3HGAuPhjho4yN4rzJi11vaCRElX7fvwvXNqre5hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758974; c=relaxed/simple;
	bh=G0JMYBQCzoE3kX+eGXfCcQxo26pwsZAtdc8q9MZ4Nls=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XDQv3JT+ljIneS0kYcamGkLdtQ0FS67UEDcTf0soNloaKjkSs6nk4W0KFZwEaolCOGNyXnPAKTkrgORxc5O/Z4+wYZDE6tgJ8nDWzzxhlQZZyqB8skMjPifLw4LsCS2jwkmgniKi5cyMH/RgGZ8SKfsgWWQyK8zxDSNEDPZqYys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nosi03nm; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2OuN4Jv9yI2QGoya79FUgeLhtWI3SKZSiD1yxyJj87hSlwjAU5aCjAO70c+mOTQISHFWIPDpChxK9C6iRKzXyWCVt0kddnqhsWMR6Ci4xuKQOUzW1DIAUoJYd/btZG8yJF1gQ8nMUj3k2rVmaZPRK4q1Yz0vRSMndZWPD8rUgIIjHkS2nrCOo7R7Tfi7vP0fYmXUxXH03y3sJQOQ3I0sAFLDL+eERoFqbHxfscVuibmotId42Zu0PvEQ+ytXCDfL5uiArMfMpBji+hjgdCN4XpSNwFPTE4XFR9bjRblbuRNmxUOVbmSKMNyr5OzBPPrbGtpCejcLV0ZPNUdnYSAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UKze2uefzRryQFOvGNWgjLX4U94vjV6Mzh0qYadd8E=;
 b=A8WSvge+Qci5QKJQRFM11/tLZLUi5LQsEhAzuLrwDWHX9ehNz3uMZRRy7MFMnfcZWJRlgZVC631cHMWozTC9/wfK58HOVfTYLZLN4NEpXKGWU+bPHxwmW2dvFM487yPNDESVO8vGkv2sYbVRaAp9YOrWevebz4A2eKyBIJQ8UeWdpRK+pUzlG6Frn9OEhuajCljPJEbhUk6/hRRUzCECq7wX14y/soZF069BRaN2Q6Mp/kRUcM6cbPFZd9BQVmE3bLOKeCzCdc/w+OMwVCv8rRzpr8w9JfjnWBfsbCfCoLIZaBWo/xPphLIKpwJ1X/YZvengpAPEmrKlx9I5EaxfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UKze2uefzRryQFOvGNWgjLX4U94vjV6Mzh0qYadd8E=;
 b=nosi03nmGzywiqBPlIu/zt6k/XWdYeQ8r8bwmEZ4bSkgIkNshfNEVPD701/h+b5joGVBCQpHEgXiIRQf+amHdaRy3qkCfgAijQwSrnMJ07oBFKS5BmJhF+UCLgGnkeT7/VYEFCNBHmdqWPz7y3RLZk9XF0ofLxzbPI4FvX1kC0V017YMDZ0DyXwzUQXPMhtadFyCeXMBE1xu3nYkI17oNR7RnYRFchr64RwjdPxqnizX+5MhZ9btrIBoSkXF8FGpWGusTJDCCyvW/bOQjxihozR7/GnosCLGkMWFynzbCJv5UmFaBf1QkPyDeG2SoPR4hM+Eh/qMSR2+iUCJh9OQWA==
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 13:29:29 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::7d) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 13:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 13:29:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 06:29:09 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 06:29:03 -0700
References: <20250716165750.561175-1-dechen@redhat.com>
 <20250717115606.GA27043@horms.kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: Dennis Chen <dechen@redhat.com>, <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: Re: [PATCH] netdevsim: remove redundant branch
Date: Thu, 17 Jul 2025 15:21:11 +0200
In-Reply-To: <20250717115606.GA27043@horms.kernel.org>
Message-ID: <87qzyfc5f0.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bfb125-14c5-439d-e593-08ddc535f51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lw4iNaa25djRqUZFCoVccajErClveXJrFbxlTb4XmP0msE9EdMvft+fE8H7w?=
 =?us-ascii?Q?0+1wUNS4KECRf6L7wUHohpaaexwhUTcHqjjf82V7GCuV9K01odxuKPJl8RlY?=
 =?us-ascii?Q?jH1m5k8UjQgo0ZpIt4hE0BkTjBIwZZX5qlB953u81mZZWRdEgzvvi+bWTlRR?=
 =?us-ascii?Q?xH22CiCU/zyaxbQQXq6JMmkD8EfOQr1KVtWXmEpzG3BYriBZ60g0HexeO2QZ?=
 =?us-ascii?Q?p7V99LbBJ0VsA68q//FTp2OmZSUj2qqIjD1wNGqiWLp1KzKldUhtHW7U863F?=
 =?us-ascii?Q?dGLvDYTWIo/oxxWifrcVRC4bttd90HLElgUZNU1jjTngVEAtfQjq2P020eFr?=
 =?us-ascii?Q?EJ73Ay4MgwzNT/soVjT25TNj6Mi5TQPMY5NUQ0OEW34wRQthr2/e/utXvf9E?=
 =?us-ascii?Q?5qebDoDUjplxKugto00z5XuI2FJb/fO/kwZSppCarHK4wcknC3v/HCXP9bFX?=
 =?us-ascii?Q?df/lLGDB7wNrF/JpIexyPYAZFkgl9aToOyLaSvav9MdM+2O7A9HsY5uaR2rc?=
 =?us-ascii?Q?XgvqP3xkMGhbY/Al/bUjMesV9IuTYfWG1fLsIqmUhmwLhmmwbY76gJKa3Lh5?=
 =?us-ascii?Q?JatnXb0TFIYUPr0TXQgH4tQaZXwtpd8Ml9q9Rla1I/LXgQBRx+W3lK1LTc0M?=
 =?us-ascii?Q?1dEl8p7SbMK51E3sc5L9V1dyFobT+G1wEY/8kuTck1w9RwZ8ssANc1LAidXC?=
 =?us-ascii?Q?99yLT//rX93fZRsaO9Qrr+QWhOwnJK/RHT3z2wXGoDYnG/AlVtbKkpHFQ6D1?=
 =?us-ascii?Q?7dF/SGCWuqdZuud2JkDPfQoSu7TUPigv0aI7Y4mme81QKcB/Wi1Q8f/DTE5g?=
 =?us-ascii?Q?2LuIukyvztRHHgrq5eiEjXbmSNLPLAqgyAAvqu9hdtsSPnzNxB0U7sedGT4M?=
 =?us-ascii?Q?Q+RzlkPRtf1OF9UGhwGix7UVVCqyuivs2jGkOA6D5OZaKE6Wqw2v5E/BOIZQ?=
 =?us-ascii?Q?lBRSeQAjr8BH5E0xdn0/JtVxwMtJFUgb6VkAgWwRHbixCOypUJ0NkH6BWQlk?=
 =?us-ascii?Q?csEgIA16qRs5kInHqFExk0Osrz+35uiZ3FJA/kGSQf27u5MmAu7c7GiEAHg0?=
 =?us-ascii?Q?6v9tz54B3tKzHc8zEX38qzVpXJnPDhxC7GdtiQR83Wsu1LikmlCwbQgJmMBc?=
 =?us-ascii?Q?odCqSX974zHupeGdaeaCqQKHYQ56T0cVbbT9/IjWHRPsfbwj2k0hu0pKbkgJ?=
 =?us-ascii?Q?lalH/pAPs3MFJCgZT1xoXb9WE+qreuUsF3pJkoVw6WMc8ewWqmzptFBPR7yk?=
 =?us-ascii?Q?AV1pIz3tmr8f4gcUBO/nI7l3XCo0PAgsJdd2VAJc/8XW1mruaSdEdhJwOYyv?=
 =?us-ascii?Q?r0CYUSNKjlqM2sJIMrsI81N+5nsUgDdMQPbAFu75UNaX6BdLxINEqi5VVfZn?=
 =?us-ascii?Q?MFE2kB3RFDzD2YqLnm0w6+YvnTgcEGPcsoDpdCFloT8hsDZGogcg+8eheX2i?=
 =?us-ascii?Q?/yesJaAG6D+lUJPd8gX1RWct6IYmm9GeQP+jh8D3FP2zyPvz4Zm1tuS5zYIT?=
 =?us-ascii?Q?vhMEdf72ae9EG2CfmFVSBqA0IoTWW5v/Asyz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:29:29.1430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bfb125-14c5-439d-e593-08ddc535f51f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


Simon Horman <horms@kernel.org> writes:

> On Wed, Jul 16, 2025 at 12:57:50PM -0400, Dennis Chen wrote:
>> bool notify is referenced nowhere else in the function except to check
>> whether or not to call rtnl_offload_xstats_notify(). Remove it and move
>> the call to the previous branch.
>> 
>> Signed-off-by: Dennis Chen <dechen@redhat.com>
>> ---
>>  drivers/net/netdevsim/hwstats.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> Thanks Dennis,
>
> This looks like a nice clean-up to me.
>
> I guess this is an artefact of the development of this code as this pattern
> has been present since the code was added by Petr Machata (CCed) in
> commit 1a6d7ae7d63c ("netdevsim: Introduce support for L3 offload xstats").
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the CC!

There was some locking / cleanup business originally that necessitated
the variable. That went away during internal review, but this was left
behind. I agree it can be cleaned up.

Reviewed-by: Petr Machata <petrm@nvidia.com>

