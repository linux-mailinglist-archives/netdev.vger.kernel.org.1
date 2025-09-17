Return-Path: <netdev+bounces-224012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E31B7EB87
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7681C520F40
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7132BC0A;
	Wed, 17 Sep 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJnsYk9d"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA618FDBD
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113539; cv=fail; b=uJp5wE3E40Qyf8WOPVBpMNMAvoZd1NUWc0MEBRal9jzt6SoPUID9UMJNAqL4rEoplqoUcWiHg1zH6We5P0froA2v9cVTxBkJsnUpc+6z1Pemrx9f+22wtnt6WsnVP5OyWslCi4w+wBmSrIBkfALT/3ep7UsQW1zQ1XN04I8obOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113539; c=relaxed/simple;
	bh=HXZVQ1NBENrUaX8xEEppFNqyAEvgSwKc1QUWCD1q22M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ogW4j318gu8rPeyMuMOMqLIuX6+Ht4GLaFTgzx3bW2MFyqna/4ybANDnji/tYvHKhiaPc3BsymZ4fNuaD8db0fnD9T9Qxot7E4xGTW+clygFqGlAUpOwaG1G5VzC4X5CrZgzshh/qc8Eet8oTMHiYJwt9wE3yBppYoYn9ooR62w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJnsYk9d; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGyKAXRunMGksQQ7ILV9z5Ygm1u7mRoyadZl78M9RT4r0YW2lgCVzR7+nKDXBV+37rqnYDumk0I8MFUcYC9GAh6QcYpInFIO43zTc08j3cdbwIwWN8EN3pJRXKAm98yvF2sI0EGDbehAH+f+57l2rDLRqXmzSIPucCdnEAwF/qKLb3ET3qSboHl6hhWcnAPP4TYH0MeALJbHRAH6Qbto7QXm2sWHVCvoYlcR8OLB8zPgpU9y/NMwbS5af9HUtGD2pLQYIKXKpZ7yKxgwxvirUFNntlQe/FR0otNS07aJGB+V/jF+KYfnJrUDIhGNp9pN6RiIa+EU5H8vbHL3aqLQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvh/mxhj2GUAEnN1icwmSsQzATIAySNU3NTpO8OakrY=;
 b=tex8Vl4wNuwF+ntQDhISrwY5sFaKolEbzXCaenrL6N4r3JAhGh6CTf8LbNP8+lr6YOanVekprr8nD1XHnWvAIIAcUNjgLQimvUIqjVXW73yh/fAUfbqLjHHv+HiJhLUx0iJmAfX+sym4Rlfss94DbuVl4Ok/ZShO5z11SVclBQGwggaFHyliUOyGqFHIOmVP/O9wE3ozjMrvWinc+i+qzi8XmLsLpGq+ZpRc30TNahj2hV0BwsOsuYILThMy3I1BrFzeXo8VvGjXfj3bY/sUEenvpFQvzCNTFV04fYprsyGdI/tSY+z1pxMCyfOKGuYjrMXcXR+qnXQnJOIM2w6z4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvh/mxhj2GUAEnN1icwmSsQzATIAySNU3NTpO8OakrY=;
 b=DJnsYk9dMoG1ftyTIZpgNMDF+7UgGqYnVhQn7UCTUcbYEj23ZdLcOwHWk8qRUErsvgkpXQz+HGXenN2e21L0SGNPs66GRERUratcE90ijmOnWGy8wXv5FteM18zkpdpeQF25rYC9LO9vIlM+NYGxwmRUeNDrN2+NKv9RlxszzRwmbkwHuC3BW4Lkm1m+BiUlISuHzP3jDbxgY9IsnJHKv6FRRjAA2zOySCpI7r6rj3art0Hu+YiJznHaPIr4ZW4qiy2OTB8j+5kPxNoAGJmf4XIelfm3Ryov87lLFS+MU+i+LD8G7ptcj0/+uEEXXORxhW8cRiDWOiPb6AkEK0TCbw==
Received: from BL1PR13CA0093.namprd13.prod.outlook.com (2603:10b6:208:2b9::8)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 12:52:13 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::f0) by BL1PR13CA0093.outlook.office365.com
 (2603:10b6:208:2b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 12:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 12:52:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 05:51:58 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 05:51:54 -0700
References: <9d887044246a656e15d05df716cde77e9d9ba64a.1758038828.git.petrm@nvidia.com>
 <aMqi98APC2YXu5xn@shredder>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>, Andy Roulin
	<aroulin@nvidia.com>
Subject: Re: [PATCH iproute2-next v2] ip: iplink_bridge: Support
 fdb_local_vlan_0
Date: Wed, 17 Sep 2025 14:50:43 +0200
In-Reply-To: <aMqi98APC2YXu5xn@shredder>
Message-ID: <87bjn9s0nr.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: d3009e80-e892-41ed-a230-08ddf5e905dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rqmk8za+IjcScajKomiT5GtJIzJRvgq/7ZMSCT58Dg4FOzm0ox9rm7U/3G7+?=
 =?us-ascii?Q?vwtwykJcvXytZi9sZ36e1dild4YjREL+us0uDVurI7ry1vSxrVM7pYFT/HbP?=
 =?us-ascii?Q?nsxmAkMqM2RX1ZqH5QF+A6a4PtphpOaid5Qh8F7ruHTqbwa/cy+j4+vRtqp/?=
 =?us-ascii?Q?ZEBHCNoNvkhWbNnFH8qJugJlTWK7hUF1pM1L2DoEwGKJdUyF/DoEykOjfVNB?=
 =?us-ascii?Q?caf3Phy255xfjj/9Dz1lf90Y+fK4orAMyKgMvs0tyZDjbrD+AGslH94jBrty?=
 =?us-ascii?Q?ctOJ0y0Lpe/Q8HUW1E7fM0ltCHYjmI0ImRT6AFHL4zINtTb/C5gNVaJe3lje?=
 =?us-ascii?Q?4LwsD2rFMh0RMHXamDzFjBqpcbWEG9D++1CuJXr3Adh4sXe79suB21pSOcTY?=
 =?us-ascii?Q?n7bKytVnP46/mHqN8/HB2UrmYmXKVUG2G2YCGNIXev72zcHYuxot8Cuecuiy?=
 =?us-ascii?Q?ykVMsGNzO193H5ZlMFC+JHw29UE0vvpRZQjNFL9KW/t9CIonIl15zO+tBGCZ?=
 =?us-ascii?Q?GA9FbOBEk50jcWbWcgi7tlKqBpQ4tKwljwOENpuE+3Ov1dXQYFTUW4oZTmqn?=
 =?us-ascii?Q?dwRvsR6qMjLglsJJe4OMz7GokYS6IpI55yk5bmlqA2w3EAt2USE91mSeaMND?=
 =?us-ascii?Q?CS8UBUIaZUCKM54VYdv+WciQSIsXuC4u4DRG9hvftpWdRySxQf+kjMUeC3sZ?=
 =?us-ascii?Q?KqCB6nZMTXFCLBjHw/FqRa2CZ14sLGRRZGV/E+YS96XS8bca3fEvNOlTaiQO?=
 =?us-ascii?Q?LSvODJOQZDLT7kyDmRq+lHfSjL1wKRnEK7HmJQkjBqhhEQiyVyHw2LsX7R81?=
 =?us-ascii?Q?RhTn8tQAxvnMyqcz/VlbgzXqw8kEgeViFLLey69zk/S+xjXnxt89Fxsr1BD7?=
 =?us-ascii?Q?e4UbVuRwhtQmvpFhy1id0fdVovSezGDI79l4kWWVnF40GRuCiYmogFp3tBqo?=
 =?us-ascii?Q?J3T1iEkzTdKzLQpe8dM2MdwhitpdPdj7Fgap3QFZwi1liNbC5LjBFAM2NhQu?=
 =?us-ascii?Q?DMm1akCP81/OManyz/27l1V8QE4e0dLAL8DLdcCd97SPhUp53aKdV9Ztc2cN?=
 =?us-ascii?Q?KFncB6XRAIFE7pDN5AzTSu9LnNLPxAbr+8pKAoDwKeRN/QFdX3DlXop25quA?=
 =?us-ascii?Q?6ECPWVHlSbP+/I8+H9cN68Wfmww2RBGnzfn0axxQoBQgE+Q77N9XvFYX+imc?=
 =?us-ascii?Q?9NRXEbTo9lONE3pIjSjUvqptpXPFEFQT0GEqCkd7RvpBZRFWM0RH4OLNT4pW?=
 =?us-ascii?Q?AGLngaIqf7fJ8pzJ3izcgHqI6sK8bDNBEhnBq+supiDq69k1VDxUHGQmcIZC?=
 =?us-ascii?Q?0yrAHmVvFaB6J/px8Q2CDithzqGc5INKgGnvzmqfNY/Elt0r8jkBbqcz5AD0?=
 =?us-ascii?Q?P5c2X7vevuit584RFk7gHry4c7OgO0t6Y0g+ucaWcE9stcnnPcjOHGT6xV+m?=
 =?us-ascii?Q?hFcGfdqdvn8P0GJReQhfgv7DplSjFj+TjbcA9hKnpIwsqb45HdGFEtho5nKO?=
 =?us-ascii?Q?EWxW5bpMWu7FP+l3IF9Nne8PFjBoncoAu7f1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 12:52:12.9184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3009e80-e892-41ed-a230-08ddf5e905dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386


Ido Schimmel <idosch@nvidia.com> writes:

> On Tue, Sep 16, 2025 at 06:25:46PM +0200, Petr Machata wrote:
>> @@ -635,6 +648,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>  
>>  	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
>>  		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
>> +		__u32 fdb_vlan_0_bit = 1 << BR_BOOLOPT_FDB_LOCAL_VLAN_0;
>>  		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
>>  		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
>>  		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
>> @@ -661,6 +675,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>>  				   "mdb_offload_fail_notification",
>>  				   "mdb_offload_fail_notification %u ",
>>  				   !!(bm->optval & mofn_bit));
>> +		if (bm->optval & fdb_vlan_0_bit)
>
> Shouldn't this be 'bm->optmask' ?

It should.

