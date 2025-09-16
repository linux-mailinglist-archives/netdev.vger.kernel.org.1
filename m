Return-Path: <netdev+bounces-223487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98788B5951D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3577E17F8D5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7860B2D640F;
	Tue, 16 Sep 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+HNJ4x+"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DE2D0626
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022017; cv=fail; b=ksHf5lSxi3IfhOVZWSXOlMuTAT5nrDa/loJtmwMGmg0tMhA+OCTE2MDq+g8scHIVMpB/CVEZOmZmkIvb3v9kWgr9P3tqSQl8wwr858BdkHjQNM7s3VudQi+ifnwJt3ip7mTQ36maUSpEpJ1bkV7vFgB40Gb3CUjkvbBksAPm7R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022017; c=relaxed/simple;
	bh=PC6cb7f+tz+jAeFgsYXnpisbFDFWS4C0HiweTeCmmC0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EakzSsaP1ov6vQudLQDJcRUx+mr+ZK6zlxa9Gh0vLMZdnPESZVbQKnwl73hnlbAlA6yT+DEUJOZYBtlTjKKc9r7ijRPaNSPSivuwp3VryDd1CsB0IJJ8oRuChASrNXzMSyCn8t11xy14w8sO5YktA2xgSiEzfr4P4Z55GIkrKfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+HNJ4x+; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjhuqmB4uR4P4lvkfmHYFAxjTGzYTsAablyCC5wFatP8Yod9FidftYBRY+KreIjyntYo/kB596K8wPL/WtmnBMJZp9sNNSjLa9H0R3Gs0+IXDbcC8DIXgC1e3EjPd4b6SH7poPRXSrUIaBNlN2GaFlcU/+ME9bR2kjsspJJBd/1SNgR5RrqiYDjjPva+7Fg1DlnDxPykXS0ReowUjzG7U1UVj2xMKG/f6csv+9IbwnJZfSK7Dw1xRfcxE/fc1x8hK2P/asn2NlIiAIcXQa3VB6HKNVJSpm+9zFg4uBENX0NFytV3J3FeocZkWXIkNhNTzfFm+zYfFZ3Qb4hky99f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l3jEk/JWUQrOenLiScIhN5GCXY3tP5HTZWPcS9ayT4=;
 b=VWqmkVfWTFiJCMzIduv9s0SNOaXxKufgd4F2eDnth5PIlMOX9G0LJfYESRus3f2cAoVIPKZnQa7bJeD7s7wumiP+IZKf4bil1726tLQSohjUcr0TQCvraH9iZ5RCYDaciqtGNnS3mKIc/mhnGqqLYUfUunazd3Mtz5/VIPQHW1PAIhMOtq4CbyrIo/TjrnclBKxxrjPI7jbDha9X4utfD41pqve1hSnd3z8JSTuURTZHnvkWuL7KRS76eJ556Qcx+16jbD5rD1leE5P2uQdB/xVuWioQuhxv+8tu6Le9K5u1C8nvmb3wRs9+SMlJzDd/CXAgDIwIvPb1cCYu/PHrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l3jEk/JWUQrOenLiScIhN5GCXY3tP5HTZWPcS9ayT4=;
 b=B+HNJ4x+PHCTgQNIdw+0vWHG1t2sN4/ne0uf9DrhqgudPdSk6Mr8jxZwYP4C41UlPYr+CLPTSEy6TOQqd0TMZiZZYsvxPyqTPwi2q/plA2Irsvf9yg4qWZJZq9ZQOO3gnGMMtkrr2p4RaO0MyhEYVgUHArBDRGXcxz6lBc4GuJ14SoCGZsgBk2pAfG9t97ZSoA2FhNOV82zJLFw/JFRv+pSMp7P5NqDqbUHOVcBC9QVmHOLF6w3+Ut3GbO7TvQ3Ulgl7CyGO2MfKL8kpUej7dRNUj6PPBUwE8pzNBqp2/5BjOu0KGtVa4kuEf314+aiH/vmbGxHtIafrNr/ySxDW3g==
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:26:51 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d4) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 11:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:26:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:26:32 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:26:27 -0700
References: <8ca075b0d6052511b57b07796a64c5be831b3b53.1757945582.git.petrm@nvidia.com>
 <f41661e4-a7c2-4565-8167-3eb452402133@blackwall.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>
Subject: Re: [PATCH iproute2-next] ip: iplink_bridge: Support fdb_local_vlan_0
Date: Tue, 16 Sep 2025 13:14:46 +0200
In-Reply-To: <f41661e4-a7c2-4565-8167-3eb452402133@blackwall.org>
Message-ID: <87ms6uprku.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3db30f-8c35-4fc1-c67f-08ddf513ee80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAc86H6y6umr2l4jr+pnk18pGylcUW88KNa/pzN+WOAvWLiDS3coW5EXsWO4?=
 =?us-ascii?Q?xpSjJYTUy6EtB3gk55Hf1FFh75i9TJB54zngzCE4exc1J3YDInak5PMNBT1p?=
 =?us-ascii?Q?/OlHP0wN+v12Hjk3wBmjaC/Qx1GbwiCMBEGUGW4cofCqo2V0B6cYK4AIZHuN?=
 =?us-ascii?Q?vVCyDiY88cdnY2PddvLuWArN1z6Ed1+rI7WCegXOUb8NLgyCwVkw742ymA0/?=
 =?us-ascii?Q?W/tIk2a3v5lPgiNWcQkMn0MAn23JPrn86RtTUvVCJAR9WPSAFEiaHmzzMLkY?=
 =?us-ascii?Q?W9wSMfEE/Zi4zI73Jk45Wt5n2ozysADQ0i60hLGxD50kUIhc6J3aDODWzRg6?=
 =?us-ascii?Q?gaLv/DCWHhQOo8jtqj6uACbNJ0PFHg3X+SPXCaALdKSLIfCB/Cfa7pB/BBd9?=
 =?us-ascii?Q?E6q0mFrpQ71wXKGAD+Tgo0CoQrBEsaspp4GtrxzGppL6IdssrQFQS4kn2TM5?=
 =?us-ascii?Q?f/V4NNnbFylqxlU0/tUHZ9kS2tNtglW1OgCT9ME48ii/gtxPIBHQBRyHTf4x?=
 =?us-ascii?Q?++6jjDXGzQPl0XUxpipjinkNGQZ38lfcmfj89cR1jKzNH5cW9NBXCWUIAQdl?=
 =?us-ascii?Q?nmjK66j+1p/lGMJtCPbRhUQfR6FJluml15jLyK4rMs+SEGj3eegdRSpfZLMj?=
 =?us-ascii?Q?V5zw4S6X1IMovOGNChoB9t6vW0RO/LEURLGbLXSiPchPFDhdAaHmRrPOOk1d?=
 =?us-ascii?Q?hLcEaEfd2o3KyfR6dd5J9JB6mqIIMCMzaH3ODIqt8pW3OxFYx13U0Vp1Hsbs?=
 =?us-ascii?Q?zCJARipjMwj4TBxX5zxTcCsX2hkJDQi5P4HCAQC37gPFgCRry/xrDGyCJcgu?=
 =?us-ascii?Q?NTNl0+ER4HuBghbsEyzTfSPb4dcdxoj91je3nfbUNSxKXgk7MiCFDor0//IH?=
 =?us-ascii?Q?bPoaOpGu8plFSy7cqDU3hpeQDpg0C18au+mnWsXVJQVZbVjBRl2fPCHrv40H?=
 =?us-ascii?Q?muslT5xwFFa0II7IFS1YGYXvpL2jqYJ9aidvO763XoVZML4XiGTPFdxgGWoL?=
 =?us-ascii?Q?knh0s1GGNpwi2/68fNPqrkfJzxuJ0Ptk1g2tweXhopkvqpt+M8RbRxfwYb56?=
 =?us-ascii?Q?+ee+DJD9h/Hl7OixtcW3NNCagp8eV86So7uAb/drR3J3jU/HMJhvlXdTmVv7?=
 =?us-ascii?Q?LSzkkMgLBdT21lxFb28CffRinsOyc4zO9xRuHMPbd887SXZqQryUBBU8ceoX?=
 =?us-ascii?Q?X7UNClsOwlhWBYJLIazsOwYLOHYZhGBgKRoS+/mY29zExrdqHzQeknIDdH7H?=
 =?us-ascii?Q?PSkrfueeBqvxO3XlFbntMisfq6DbqVKs5CwSfenLBxI5MLNchLEj8lskkIxe?=
 =?us-ascii?Q?cWq6UcfGiYtZyXuiFt9wgy/uMUxbNauI+bCRhtn7HV73BqAQUcXaYR5bFoc/?=
 =?us-ascii?Q?nms+rUcEICBYEDBDNqnq4bydDlq+GZaRGhoAgXdan3B4UOAhTtliM3vTN+/r?=
 =?us-ascii?Q?uwDqOxlv62Ja6dj4Tedf59wTILLDeMGJ1wu2mDfuAg3F6s0yMvCZQ5J4dgdm?=
 =?us-ascii?Q?356DVWzpaNiBU0NXpLl2L2nOEmClOcZ/Uti9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:26:50.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3db30f-8c35-4fc1-c67f-08ddf513ee80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 9/15/25 17:21, Petr Machata wrote:
>> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>> ---
>
> Please CC me as well on bridge patches.

Sorry. I need to get into habit of running get_maintainer on the
iproute2 patches as well.

>> @@ -637,6 +650,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>   		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
>>   		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>>   		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
>> +		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
>>   		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
>>   		struct br_boolopt_multi *bm;
>
> nit: the block vars seem arranged in reverse xmas tree, could you please keep it?

OK

>>   @@ -661,6 +675,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr
>> *tb[])
>>   				   "mdb_offload_fail_notification",
>>   				   "mdb_offload_fail_notification %u ",
>>   				   !!(bm->optval & mofn_bit));
>> +		if (bm->optval & fdb_vlan_0_bit)
>> +			print_uint(PRINT_ANY,
>> +				   "fdb_local_vlan_0",
>> +				   "fdb_local_vlan_0 %u ",
>> +				   !!(bm->optval & fdb_vlan_0_bit));
>>   	}
>>     	if (tb[IFLA_BR_MCAST_ROUTER])
>> diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
>> index e3297c57..8bc11257 100644
>> --- a/man/man8/ip-link.8.in
>> +++ b/man/man8/ip-link.8.in
>> @@ -1725,6 +1725,8 @@ the following additional arguments are supported:
>>   ] [
>>   .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
>>   ] [
>> +.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
>> +] [
>>   .BI fdb_max_learned " FDB_MAX_LEARNED "
>>   ] [
>>   .BI vlan_filtering " VLAN_FILTERING "
>> @@ -1852,6 +1854,18 @@ or off
>>   When disabled, the bridge will not learn from link-local frames (default:
>>   enabled).
>>   +.BI fdb_local_vlan_0 " FDB_LOCAL_VLAN_0 "
>> +When disabled, local FDB entries (i.e. those for member port addresses and
>> +address of the bridge itself) are kept at VLAN 0 as well as any member VLANs.
>> +When the option is enabled, they are only kept at VLAN 0.
>> +
>> +When this option is enabled, when making a forwarding decision, the bridge looks
>> +at VLAN 0 for a matching entry that is permanent, but not added by user. However
>> +in all other ways the entry only exists on VLAN 0. This affects dumping, where
>> +the entries are not shown on non-0 VLANs, and FDB get and flush do not find the
>> +entry on non-0 VLANs. When the entry is deleted, it affects forwarding on all
>> +VLANs.
>> +
>
> Please add what is the default.

OK

