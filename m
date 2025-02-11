Return-Path: <netdev+bounces-165215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98235A30FDB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F33E7A4362
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81324FC1A;
	Tue, 11 Feb 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ok274s6m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EA1F0E32
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287957; cv=fail; b=BcjtfF9f18L9I0ynAG5eR6NPbmq+CSFYJxNCV8uEgsX5VNxRyOme9bszmGiaPq4QIN5rV7zBc/HgZjAT4DQM0OZ2evO1ZGx2RBPdQuMOSBSdJF+oQMQYfsRGb8QtcXkMh4jU4xIARGVQRSjeU1n1ZYpeG+yF9T8kiFHCsDDg+A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287957; c=relaxed/simple;
	bh=vSB8l/4t2z6lOD6pjiTC4qHYeJcrxlB4fIUAhZnFsks=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DEmq34bTffXwZPPU6QEo91nKQyhk3Cvt4evJfGR7GtWQpiOEzm2QyMj4PTkImXAjb2nYLcOWzua6kRGk1oCseWOrlN6rpFSeOL0qQn5NSUuuAhUz8fLedFXa39n4u1yFolCBj9M58zBXKQz9Oa2414D73tltJmpRWZR9X6RNnFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ok274s6m; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUlfo7BTYTbtqryp7/eqguYN4ag7gSR1E1/NGm4xjRbSu2tZoRin0HoXeLyCAx7vJoRN9knbRmUpe3L05uemSHAdZxPQQE2YCm5m8eftw4Wvt7MU3kigDMoxAbTJ30j5pZ+8/Gz8OGMVp0mWyqmo+GA0RR3YRM6qOKMfaLSolG5zrm86nX7xGWUbUl/1M8ShMnaCBgIx54COQovsY02o80X0W2E28XUGsYyC0SumVQUXw5roOIEPtV0J6TG7WSJ/TjMh+LuCWzoY5TMteVAjdQIN4R7Bu+Gx4lfRTmG03jNHu0l2uGlDy8737Nbphcfp+CtS+H7LtquhjRPDYUawZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN00rj6sbXW09kZI50xXwUp41xNr/pHed3PWORSvwKo=;
 b=HWxyhI0MIFIBQ33KISvJAm4wzEtDR/+Ezsx/KgsgZHtPp1mEJWoTDGSudo2D9G3OmAELTzzPmwMFFh0ESVbYFP8IR0HqO4zINP1JBeeCU5oaV+0JFu/EN22Hg9I00s9OHRKIleimsTWhzdkEw+UW6uQ5sY/aFKN1yxKENfK21VKuPx+qUuokwKxdggMTxk/9KUlJNKzOAivtmG0Qgn2vOprZqKtdu8ynfWN8Xf3dDFttI498UEyHCGeVwj/jZWV9ds7QvWU/zLiKCD/LbqQW06zM3y9FaiKbZEYdDRlbMqevwnN+2XuKCL9p3MDTyYxcecPlYSj9M+440X82LhTLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN00rj6sbXW09kZI50xXwUp41xNr/pHed3PWORSvwKo=;
 b=Ok274s6mj/NmVxmwSoXBSVyXUsk8PbcQrAteC5Qjc0a+xveQl37qEOgvxN1j4A96jgtYYshoJKNNJvnjQbv0GIdUJ3ZjkAD6KzyydIDDLEVl4kAoBPvPjfcu/Y5zH7iQeO9vUeK7y2zBCNu/NKT+kqXlgDmDIBrHdOpUWXE9QNC38HV7HrnxmcE+qIWjtvLmk5GejK9PT4AzC4RzXVgCns+5yAJeGwpCUF++1KHLw1EbhJb3BoSsVBdRRmBePxvhG3yefxG3SMrw8Jtj6LyT5be4pHLP5gn1PLuMrcAezyBnG+4mmJcq/iMWXw3uk8KS1/ljqr+ZoM86YNvv1Me4Jg==
Received: from SA9PR13CA0141.namprd13.prod.outlook.com (2603:10b6:806:27::26)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 15:32:29 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::b1) by SA9PR13CA0141.outlook.office365.com
 (2603:10b6:806:27::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 15:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 15:32:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 07:32:11 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 07:32:06 -0800
References: <cover.1738949252.git.petrm@nvidia.com>
 <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
 <a800d740-0c28-4982-913b-a74e2e427f25@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net-next 1/4] vxlan: Join / leave MC group after remote
 changes
Date: Tue, 11 Feb 2025 15:56:59 +0100
In-Reply-To: <a800d740-0c28-4982-913b-a74e2e427f25@redhat.com>
Message-ID: <87seoksdjh.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f2e585-57d4-498c-85b8-08dd4ab14b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXdtS4X6rFHxIp9f77lPgKATUDRH7VzZBcLO3VrDEVAjBj0UU3DkE/Yoipty?=
 =?us-ascii?Q?Qy+S8q1qoXmYKU1452d4L3lLzIu/+AJGA7cEPdbJ35F8usqZGXmPW4BAk6lc?=
 =?us-ascii?Q?FTOKTcA+UqUEaCfLtoBGMRBq1553fEr/VwT0ERXNUw4wVR6zPyA4OowwOOZq?=
 =?us-ascii?Q?/4D9V5oakK9yr8+VQxOPbXjSfEoFuwB1a/a21/DTop5C6aYvBWeTQ1+mGrsA?=
 =?us-ascii?Q?DP2JiAR+SMJJGQqewggL1YHTgIZWTY5FkXz9FECLTr60YZCQWvn5hVJbNL2O?=
 =?us-ascii?Q?C1f+3mz0Oku0lFIla82XBbd5GdIqWe0px4wuYBNzAcRvnvIw2p9DqGC2DJ1Z?=
 =?us-ascii?Q?hOujceYZwSc+UQ2u8i4xmM3utvVaPs70dmuTpj08VObUy7wk0KGGiHovzN+7?=
 =?us-ascii?Q?gXFoAaClIDyOaJGfBVeJBG0+TdEOQPnJXA7U5Ju1gcTrYf08hc4dzFaIPicZ?=
 =?us-ascii?Q?3jvwxQkDq57ex/GH8HA0dSwkEM0yDtIg/HOahBZwEF5MHz4ofUWWOlbwbR5W?=
 =?us-ascii?Q?apz8+eqrYJu94gGylFq5zWWBazvdNbKdKyJ2f9H/9nq28liF+3BHUTrHK5n7?=
 =?us-ascii?Q?s9ZhKqpJl1i6qqCegEHD1R9aqjslOcYcwWgG8k+1CnoQUFSpaoMJQGdyf81t?=
 =?us-ascii?Q?JyU17dmenkAXQkuIMD7JQTA1lx4g40cKg4NQApF/7a9YOPp+wzgC6RRc5SML?=
 =?us-ascii?Q?LN9tKnBdeQwl6Ccw5UZr2bycfZGSnwxGbj4RiI+kPzDOY1tRLHVlXwh7mCTx?=
 =?us-ascii?Q?kN1MqCGc2uSUoVHlrgPljMLGs5nUoVJTD+UQu3ecaAcRy6smdE5FKDdhc7fF?=
 =?us-ascii?Q?egkwskmDSRUVySte3wqj1LWSHfGgGoTN3hcVpyZPo1nRSVVRW6q3MTmvdtF4?=
 =?us-ascii?Q?kJW5xH+VeK/KYV5CniG8s8lolklNYpp14rkVztdHP7z4t36GsJ8BDfEkFReb?=
 =?us-ascii?Q?rADc47FisV9rYyCeckB7QQTn0KSkgKhgK/NBMBQX80wclkaGIhKT04gr4XHw?=
 =?us-ascii?Q?lCLeSUX2Tx5lIdrnsTMw18G0GGtbL69yelwjtnefqnZx9ezmuEMZYA/RGi3n?=
 =?us-ascii?Q?ritAXJifqUWW/wgA/hHBEashEgPwm4I6kkl1e1HWWnT7MMLMdC7txsjwuya/?=
 =?us-ascii?Q?fpkGMCEcgh0fXIoIJLMG68YohTv8spIsvNtm4mPmMpfdyxQuaWgbx1sBJ5Nx?=
 =?us-ascii?Q?XaiUlBROVrNAuVjonUtNlV7JVuadWnuji8c2cZRXmnsyu5gKZ63YvOVEZam2?=
 =?us-ascii?Q?4w5/5QiZKUf6uRYjjlIx7AvCcigwbznUeMqUlZdgre6QmUowaGjvQKURUX8c?=
 =?us-ascii?Q?pBDcaqaLwxXrf+aK5TQR6ool6qq6yanzMjWLkNVtYtYPEKJvsDunRJJnNgSi?=
 =?us-ascii?Q?qeo92Xszb61pgX/xH6m76TZ+KmtG59tAb3jO19syGEV/uDka/Jx5xqMBcBTG?=
 =?us-ascii?Q?siXEMxUrWtl6SQR7e0N2PfSoLtt9u8yy1gzKnTE0FrHF3oBPidu0CyMppd6Z?=
 =?us-ascii?Q?5lF9Ec++AVFTx4k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:32:28.8241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f2e585-57d4-498c-85b8-08dd4ab14b4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017


Paolo Abeni <pabeni@redhat.com> writes:

> On 2/7/25 6:34 PM, Petr Machata wrote:
>> @@ -3899,6 +3904,11 @@ static void vxlan_config_apply(struct net_device *dev,
>>  			dev->mtu = conf->mtu;
>>  
>>  		vxlan->net = src_net;
>> +
>> +	} else if (vxlan->dev->flags & IFF_UP) {
>> +		if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
>> +		    rem_changed)
>> +			vxlan_multicast_leave(vxlan);
>
> AFAICS vxlan_vni_update_group() is not completely ignore
> vxlan_multicast_{leave,join} errors. Instead is bailing out as soon as
> any error happens. For consistency's sake I think it would be better do
> the same here.
>
> Also I have the feeling that ending-up in an inconsistent status with no
> group joined would be less troublesome than the opposite.

This can already happen FWIW. If you currently want to change the remote
group address in a way that doesn't break things, you take the netdevice
down, then change it, then bring it back up. The leave during downing
can fail and will not be diagnosed. (Nor can it really be, you can't
veto downing.)

I can add the bail-outs that you ask for, but I don't know that there is
a way to resolve these issues for real.

