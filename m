Return-Path: <netdev+bounces-196118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE82DAD3935
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2FB9C2A2B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7D2BD587;
	Tue, 10 Jun 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZHVCDH1v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E229CB32
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561381; cv=fail; b=MZqV4GeOaNyalRCreiLDjYEa9e48dcYGx2FJMW8tEl0MjRZcc4FpqDFI7Kg/2qv9YrX5W+UIFdNLpE+q+Q9jbKCxdvpjXSs3HufMsuyEniG8Z9G6wv/tu2xVq2o50JRdFBrXMLM2JKO16USdFUx9IujWYlSWeWyEKuqjVE9NI0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561381; c=relaxed/simple;
	bh=Plu6uqlTqIs1urWCpz7zXFanuIefKdum/UWoRApN9Fs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LMPuX6DaX2zorqoQxSVzmlZ+McyYZYz4YY75x8V84j0FGQ+1cdzfpTwDpiW+QFYkngSq4x4zA24fxewPcClSnsASt5vgUeNKVWrd8X+C7OIvGC+Fq5Ccs/TWETz4APQdlqgu9C578MRKwhYruY0FP/aVUm1XG7SiQn3pqza18IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZHVCDH1v; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5XdJySXVcF4VndhvIlZWu7YBLUbsxjfvdFHeWyB6pEfDsQOZFQsvqCMIzr0+UzXq1Gxq2bgTN7qHRzs7PZ/yjsZwzGq3PkMAVud4qEZtcs4rc7QQVf5GBhht+MF17uUzxui7oZ0ktJL4b/zHbGLEujsDlsnZLc/E3nTEpiboseLq8XGeOebeDILR+uPsnH2FjeFGllmawtSthcp5bPpRRo8H+NQHHlJffrgLRq1R4ZECBp5kid12piUzmJ6vyF3SGENQtUdjXVZu3KwgQ5b5mjTMQW0Bce0Ej+wzV41IOyxoD/F9U8jFzqd2P0iBE5pFvVuFAZGWAXu4hzc15n9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j+tV33v1+a3+C+kgZFD6aaN1p2APufwDl6+ngVF+74=;
 b=aqvy6qabwG20XOTBvj60I1xJ7TTAXR8+XvJ7GO1vxG+1MwlFXUI/BkrqnD12u15jUkMgs7i5WgQ8KxpXX/j0yeTq3aMYrOtPHQA6kjA/SY1t9RmPK7Dm4rjs4ft7NJRSY/xPH/7JYrwTbvx2/3pMWmkg/pXLUjzQdq2vvYVgzYAEurCuT6hArUIrsepq3c8anivmXdgHxFc1xr7acvpenI/anbECNnJxWdb7gvUCDWLF27EnCS8FBev1qhJ3cDIUr2qB8IWHzeq5s+Fkosnwvz01npVoRKEqc6zzZxvGsy6S4nKF+g9ofIAfbT9uEmHlbFU6Wjoo3rLInYMDulaRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j+tV33v1+a3+C+kgZFD6aaN1p2APufwDl6+ngVF+74=;
 b=ZHVCDH1vSABUfALRdsoa7ZKg9+j8fonEts9Vh28gnVa4alpid18r4RlMLMh5BHg3JRsdfzUh7+xcSvGGzR8bibHy85gUqKkJ2etUhmLf1s+ZgsEtbIxX5aSL8Hh7fFqOiUT6LnDFHh2C10Wsw/3vio75liQuWEM4r7f9s3dnpROUMtzzrpIiLCUaGGF3b/pRUlfpeivEzzARaxcvITTCwn262fCwg8feRdYx5Ndss5RSFKejWIN8hkmkZeeqKvUaH3tA1aR+VBkdqlI8zGZ9euRN/vmSjhiCUvzK5SjAxHNPs7fW1PgLTEyEM/trd2x2U2dL+tEGau6s2y78Pq3vSw==
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 13:16:15 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::b9) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Tue,
 10 Jun 2025 13:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 13:16:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 06:15:58 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 06:15:53 -0700
References: <cover.1749484902.git.petrm@nvidia.com>
 <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
 <aEfdQMWuDHu_lJaA@shredder>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<bridge@lists.linux-foundation.org>
Subject: Re: [PATCH iproute2-next v2 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
Date: Tue, 10 Jun 2025 15:14:18 +0200
In-Reply-To: <aEfdQMWuDHu_lJaA@shredder>
Message-ID: <87sek7enzw.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 688cf231-5593-49c2-8b8f-08dda820fa32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2kuNz4YRfpINISeocGp424NIS54u4z37wPOpkCMkuItr1mtzOPAiitbpjbg?=
 =?us-ascii?Q?eqCmvB1RuR+RCRUx/DeYDbBO011hXyiJdkVy0DzNjTELeYo7YppXF1NJohPo?=
 =?us-ascii?Q?vU2BPMgg2x13GcUVQ/y7WWE2WXTj8uOlDszCgZJ4oerZRScMMKrzbL/5eDuX?=
 =?us-ascii?Q?O2+JzCX+dOQOWFWVAlBvw4lTqSHGPDm5y8ZRnRxtYcs/1s0qWhJXFbJOyWX7?=
 =?us-ascii?Q?QHfodGXwAn+j4wo3MLLNGe0pMu2B4p3uOgzwqVL9bGE4pvytpg1iPBhvE5QF?=
 =?us-ascii?Q?zPVfiOC3B8UIlEBE3uK2uKw4K1hRdgwv3zcym1FGQ+peZbVAXdNG9+id7dU9?=
 =?us-ascii?Q?nhIHUOcn443MNVIlgvTPcSphSIC6U03Zb6+E83AQsBTs7JfR/HwiRJRxKi4p?=
 =?us-ascii?Q?VfCdQSGCpApb3MNA+W2PDTlJ0zNzgCngHNALcDuVzAtlYWHApwPLUaz8mGZS?=
 =?us-ascii?Q?Rgn0Ohl6nKZfdC3yEgl2g0k2alNWosoIiD1KVzZxEIMouf9JE/ktUkSL+z6m?=
 =?us-ascii?Q?EG1bOA4AUzAZEItoy8NgUqdwxxYZSNQuciL5wgCbIRIbrX5T16E9GZ+yWIpQ?=
 =?us-ascii?Q?2p7FuQSwCfBG3PIBPMB3kaPbE1XX8tZoITG52jHX2o64VcKlYKQdn6OqBw9n?=
 =?us-ascii?Q?e9J+Fe5n/B6VxSSNzwLZtNApCeFb1CQjTBjzPoGEUeLl0PNVK3Yrtp6RCqnp?=
 =?us-ascii?Q?uuzo/+O3LuK9GVwVWzx0JF122iRYI8nwAyBikaJv3hLsrfU+lSvgJr8n7Tt9?=
 =?us-ascii?Q?Rd7rEzwyMwH0iJW7yzfRt+hz6eXzaTo+78WN3VY3Cpsc+xT/vQ2Oyi7yZD+l?=
 =?us-ascii?Q?vemj/h9IJteE0vfSWkvrEvrUELEPpCc4O5ADigQXmRm5Og7wCjmcYdPmUevf?=
 =?us-ascii?Q?ho9k5BVGdzDdHFguqC0XRzkP8xzmuZk1GhgBovNAna5k/ByJ8bF5SSAO70tt?=
 =?us-ascii?Q?ZKLra/R8PLM4+K1WgybBCjxqf/nxG1l9tQRs3lhHJNz0+dt0oQXyOPded2g/?=
 =?us-ascii?Q?QLpsjWF7l+cWWK02YgC3b+nuBP4gU2L6Y5SF/a17/vwr0L8S5zTBMvCjMLEt?=
 =?us-ascii?Q?69KBGAQiWj4LexM070ttJgPmLOG4GUP66sTcU3i5L4sS96Xn1nIrE0+eWuuT?=
 =?us-ascii?Q?HuQ4RQVIBi3lhZP4yAANyiPu9BCzF7TP9+sCytz++KLIyGxl7T5QxCwux+4u?=
 =?us-ascii?Q?PtcqyHlgGu0HGWqNSzZ0jNmtJrzGfEdtbKWxc0H+bV0Zhqt5/e6e1mdj3/qt?=
 =?us-ascii?Q?1c/RwLtjk/5ltjNRS3+6iMSG5X0jt5UmhoDmANeOYP5MH6bIHVkbFwMK8vrN?=
 =?us-ascii?Q?EFM9OEU+lv9LykiTbvWCU/2JkMuo661YGax8pbTBmlJ9YiTAB56lEE8vhSfi?=
 =?us-ascii?Q?+AgrjE0WGUYip0941MDDTbiRNrdD2wGcuEkBvJRdYpn8d8v67POOjmBfvNas?=
 =?us-ascii?Q?ZfsOYWtILRGuKPey5Holv+p69wvV3NsaVdaNYA8rZEM87GoEhKSsQx/5aYEK?=
 =?us-ascii?Q?Wbq40vx8MZkyPLYRQjwtTgAdyWLvr3pZY0z2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:16:14.5019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688cf231-5593-49c2-8b8f-08dda820fa32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593


Ido Schimmel <idosch@nvidia.com> writes:

> On Mon, Jun 09, 2025 at 06:05:12PM +0200, Petr Machata wrote:
>>  ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>
> Code LGTM, but I just realized that the new vlan suite needs to be added
> to the ip-stats man page

D'oh! v3 here we go.

