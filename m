Return-Path: <netdev+bounces-243991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FBCACE00
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C1F43009759
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE262F9D85;
	Mon,  8 Dec 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VP+WJCtS"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769831077A
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189805; cv=fail; b=KBfBRemtUEfcOz7A801xNbiw57UqPQ2/uLPvgb/ZQ7XYL/T/1Xm2uIYDGSvJuz492lNojJWuxhTRUFnZBUtE0+QNP04O1+r0QE6zZz5P3ZGwXpRsUthV1Bh+TkCgz3jaY9I28cu7stP2bsuQqysqK4A7j9bT+S55qyaEiW/t5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189805; c=relaxed/simple;
	bh=2l9sKVvjTAKA0VgzmSsIEfsDo5EBrBaZ0BVhEmDQU5A=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=X9EmzhGkPaUAtR8XS+jxccvJOjYJWtlhLXOcjsne636WCD6s6vgqRJqrgrhfvxHfc3bGZIkgq9kGArFNvdbpvD54XU1qMRNkIDNgDj4WvJbdNxJfoUzQV9HQp2o4k6dA8/SLm81VFuBTtzfShNzmGTwfgpt5S5iHSgDc0qNXSSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VP+WJCtS; arc=fail smtp.client-ip=52.101.56.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0/vx2mzzm7UVNi5VSfOheE1/2H9Gimyo1+G53LzfgRr2EP8SXPzbEdwwXVmU6De2+YfO/HYHS/TqHQdNccOczbAII6/MxSJSB0MMAtfGCPfzx1Eiqjmf78O5wAtxWk3Taq0qj9OFVjKZVwJgTvsJqJoA0l7x1rzq2WI+wpck3lK7ipJdz/FHrDHf4dOQJJUrc1A2S1Hyxzg/gbawcHfdOTFcke7IJSl5pk1HoXTERkOQM/zixOarD+ozz0PW2vdHitd9tI5aoKZgdWCIzLhPoxPlfCZJNQCOSp9XVCdU1zqAmyyQzaOBb6yrIPJA/awiZaLmK0GwnLWcvXs2zEr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieVeZWejHUo4i4Hqsjkhd3NGggv1piS0EgFamX2v+po=;
 b=SkQ5Hb34hd8SlObsJ7AZgAEKLkGb51SIQ9i/ziAOJgJN0RzzgAOhtbh9C2QtNAbKGSC0/bzYaGzqWwU4KLPjUbWrkHeSO42s/y3fmlVjPa/L7qSgCmoG3chN7Op/4zeZ7YEGz+CMtRXyiHgNgBS3Qk+oQXcVv94ZnLAxyI8XspfYRrgxtpprlNw0UajWFTkLFhpZRI9JRQCd/4GdK6aQwI1H8dNDisIS9/Nefj+PBwUO6RHn/dfCHM6+cr94WMpYSJB/Ecp29XrbgFLjpHktBFLDG47VL4B1pLQ/2/LNCtYKnRHgsLHh5NLsEeQuPRVaLgiVgJcvqYwfqnX63vdk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieVeZWejHUo4i4Hqsjkhd3NGggv1piS0EgFamX2v+po=;
 b=VP+WJCtSE+Yt8mTcL1siIIZs5JvaqbdG1ygHRR81uFeClt5Jq194AHmg7NLMYbLN+iGnJ8+BbbBqKWbQyZSeBbHrmayj5LOaYOgTTOur93GpvsPJ8kVVBWw2HiMAsB+ESl7w7wjAWlK/yH/WdRZJMUAekVmtbqme1sRvxphrPdhOyxxUaZBw3QLzmShW+G6hf1hew6/8vWKBTf2kiOS9sj7fo2kHw6j+y+ItRWvb3O/doaHoNBzdK5dIFiY2LeRtZd7rzRMKYY44LlJxtEIsrgLfTrRiEmc+DdEy5Z1Y18Kg1ZKAeUVGJXQYJqNX7YVx/XZPOO+yj2DFKd4DzzQReA==
Received: from PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::23)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:29:58 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::2d) by PH7P220CA0080.outlook.office365.com
 (2603:10b6:510:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 10:29:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 02:29:44 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 02:29:41 -0800
References: <20251203095055.3718f079@kernel.org> <87bjkexhhr.fsf@nvidia.com>
 <20251204104337.7edf0a31@kernel.org> <87345oyizz.fsf@nvidia.com>
 <20251205162610.40143536@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [TEST] vxlan brige test flakiness
Date: Mon, 8 Dec 2025 11:27:19 +0100
In-Reply-To: <20251205162610.40143536@kernel.org>
Message-ID: <87qzt5w9kg.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64e23e-3f25-4837-cdc4-08de3644bc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtGCx6+N40jhuqcQYOYRc7buoZpgVdQ1hEFhC3+2I+/EeNrN3Sh4GYNE/FJO?=
 =?us-ascii?Q?DhdRjqI8gvYKz6mBU55qceWsfEKHnHBFqkRPrpv8O//RRV4XsGLY2WDLusu7?=
 =?us-ascii?Q?poKppjrr0St0puI72c1gEfV4ciLhTgWEUSaQW2K7TiSWKy7A2PMMGtalKMNv?=
 =?us-ascii?Q?knA1ue+sGAAwzP+w6fx6vWcN8gltmwfQtUomWz7FEy/mkCi2MU8cWUT5eesh?=
 =?us-ascii?Q?5HDxOHoIzhervnYtiyAfdQ7OnT1WSLbBhBGUPTwcAxbtqBsMxDXT+9vigkZN?=
 =?us-ascii?Q?HSE61V9LjAuHzDC2e+nKmQw89xFB9IXcd0W9UuVRjzeRQz7gy2UZHJUITYiV?=
 =?us-ascii?Q?NZ5fAq/QZvetmumKu5Oz4Z7wvZa/HE8qhIO9yFj7B+/gzYsTA9r7wj02bmer?=
 =?us-ascii?Q?ZqINPgrFQvgyBf2wv0OYdVtVCzfAdtf1FRHZriALAB+uT7NCzeMNoLepTelz?=
 =?us-ascii?Q?E0HX+m/AYpepd/eCcwebrNP8cQrJPfPalIwG8kUbNb3cVReHs7lo79Z3JTfX?=
 =?us-ascii?Q?AfNqvPIfRXfnUVZ2uB5JE8mMsUV1aHMSQyTEpbA4dx1Rlmd/518lP5NuGKhh?=
 =?us-ascii?Q?cWaY0hWIuZHwWoS50rU/eD4cMMPdYLu1so3Z+R5kUYO5IK6S2fyoPMT8Pn8o?=
 =?us-ascii?Q?zbIx2uuu7buCSFoDKJUDeXhx95SjjzIar7OfOTjLHa2Wkgrb/li9iTb0pU9e?=
 =?us-ascii?Q?fICvh/cX/wyafrxvOE+PgIEY26TRNK9yp5XiDnwhGckU8BrGWiy37zLqTcSn?=
 =?us-ascii?Q?9n3LRHVwv/SFICWyg4Ws9m581hXsvX4ilfLRYJLF8qRKzh2kQHkCg0wSteE0?=
 =?us-ascii?Q?jotWBK5xSTp/CEwCE1Z23GUaoBMo+jss+ja4Y34yudaZ2XrZCyA7KEwgFCvG?=
 =?us-ascii?Q?K9Mil914Gm/jDS0Om461ZiQDEXj35hoKb2I+eO46CW1Ex+OXsijjKnSz52l4?=
 =?us-ascii?Q?2L2YwvLam0pKOkpCL2jtWhEJv3JxMLv9y+iZc+JzaF7W+SFhXX0nqDBNhXe+?=
 =?us-ascii?Q?ZZlZ5b2Mohn+2E0mcb0v3FF1N2oUvgEyHUmTWLSilG2YniCToI1MK20O8dCf?=
 =?us-ascii?Q?IFWGMhqsf0FsZNiNYUOu5Y2eXtbckR3TgNvj1lSrMPVGztpSxfb2JASBpTCY?=
 =?us-ascii?Q?6JDvM+7uzU2rKrCG2EepmsqnF+Z1HfppYK4OonmPv1uZ/+ssx+kphtRoDlZ+?=
 =?us-ascii?Q?VIADjr8dZglk/gJjZ11i5Gm5KASCht3O4u7eW5Io+kelKvX6IEmflD4HDS0b?=
 =?us-ascii?Q?+vmvHicyHnL4ZfmbnUlhhze5qcwRiNarfRgcVH/yXl0oW84pSrK9LUnOhqN9?=
 =?us-ascii?Q?1+oeaO3CoU8Sw8dmejLQDtpicOHfeYkMEONqg/hsEVkucth70CjasEMjZFGE?=
 =?us-ascii?Q?3usIyWKR60P38c4oBQUWp2OS7x9caMgk4Y2GJsuacpyFeRweaOLBxc9N3Zcm?=
 =?us-ascii?Q?N6+e++jxJXVPH6cu5ei0gUSqhNYG8W7V50rGJdXLUNDJcOdcRIvLE5fgmTXh?=
 =?us-ascii?Q?MHYjzfmnNWAz3TUPvvio2PbxVK/scrapdIxYhSEeAJMFsjcH5BqmhAqA9Qqa?=
 =?us-ascii?Q?v/YCsFytEXBWCjSJGIk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:29:57.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64e23e-3f25-4837-cdc4-08de3644bc3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 5 Dec 2025 17:16:56 +0100 Petr Machata wrote:
>> OK, cool.
>> 
>> I think the following patch would fix the issue. But I think it should
>> be thematically split into two parts, the lib.sh fix needs its own
>> explanation. Then there is a third patch to get rid of the
>> now-unnecessary vx_wait() helper.
>> 
>> I think it makes sense to send it all as next material after you open it
>> in January. But if the issue is super annoying, I can send the two-part
>> fix now for net, and the cleanup in January for next.
>> 
>> Let me know what you prefer.
>
> I think both the fix and the cleanup would be acceptable at this stage
> of the merge window. But no strong preference, I queued up the diff you
> shared as a local NIPA patch so we can see how it fares over the
> weekend. And it will get auto-ejected when you post the real thing.

Looks good so far, but not conclusive, there was a similarly long streak
before Dec 3. I'll check again tomorrow. If it's still green, I'll send
all three patches for net.

