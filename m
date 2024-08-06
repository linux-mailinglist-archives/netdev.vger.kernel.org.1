Return-Path: <netdev+bounces-116014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B6948C94
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5E6287F77
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD11BDA8F;
	Tue,  6 Aug 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0iksUdA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567A161900
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938838; cv=fail; b=TypkNkgzQrIq0Gq8SAiAeGC5DI3OI0ZbfQt9UUTZUBsECIG0k5KdKnJfiazBGsao/0QM0aotdrB7gH4qtzgT24RfUwtjc82XrGugE03hpxPo01E3fMVtQnV4ruBryzEV362LKanaIa+o9ozeQBLGoe8VCqhdRMKsrO9tQ4xQC7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938838; c=relaxed/simple;
	bh=TMXycArs13paSSs7QwWBMjJKSYdb2UmDQZs6wJhiAto=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=RDX/qeDqEKHyZE3N4PIAOOOANAUKmJt8yLuHJ71RMLzGMBfSzyR5MTxcIPw1gAMQ0NrLrrV7vbgBbhrGJAo79HhusiNF8SjjD+nGl7m9QfLaQg+/jek6uo71cdrrrkDO5U5BcyN87YB1UlP9wnUiCjVksSfHwYMgSRpBixi87hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0iksUdA; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlgGbZRdnDYJRP0fxixIEvg1+xsmPqkmlT6XN5vpqyJqnrJK/OoQJq0rg2OgqUMyVdclmYWEJBOw15kj96oUpbqqsPhOTr/tkhNkpYR+/m0xU2hvZFTkvvJ1AHhg7AQJO3V9girdtnhO4GMK72WaFM25zFHPfK0aS8Z2Yi9h8IfOmHsl9j2jCzTUlzKO5LN98X4hWKsu8F12ENYCcf/oHGFVgc+tFRi7EoU0qtzmUP7pcCm7X25mvFU7K2eHc4M1yWF07NxLYkPYoKOpY/Fc7adiZ/z3iRICoFYrOWrgn1efmhTKwhdiVf84F7r35XTt5btd9VpLfBxM/cxqjRA6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsgx/fdDh7SZq2A6NzLJwOiDVr+E34P3LEzQcCqE11c=;
 b=BfUmTg7o0laKyWuJzRkUH+tRUsvaAJcn3AQN9LxStV5HwagyRjjP4lvX5+qDsdw4YnNyfY6M1YTAooGqBXnHpGtRZc31brhLSl+8LTEKE4xLXUMckpXlIHkzk1+9lTZvoiJgT8mQcKkE93SzFLDfUx8cqek+JjRPbG89fu/v3gL2esvOVbs9jSckt2ZsldT5nDOY5ToNsH3eAgLQ9Bq/QHmHYo0TjkiO7AdybGuAtTMVH0DF159FV173F8C3hVXtd9JybJDG5shH82GlRUj74c+npm73IwYBxqCQllHVt4i/blzuDG4hgekkpiIuOVZO/4hYCNhpv62lHyKg3ESsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsgx/fdDh7SZq2A6NzLJwOiDVr+E34P3LEzQcCqE11c=;
 b=N0iksUdAwGtt9eWG4TfYrQgVzGkl9sLk6TBFqXj+XG68daDV9iM3jWMKTc8NEgO0g/jCOAenXcXoxd1PRYutwfen0r+cNt9IKdmJ3gZ+FGXa2+YkOZ70dxLl1FOH5dr+C09jQd+QH+p4SG07BKw+R2l+Yig3d9zy9+x+DZTFa2r8+lM1981Q+8ICuYhRutjA9FhsBYL6yZpr7t8R+pr9H1MFmIEy1/inFIyjsEPCI4vOnCKq2MQ6AbeZckL74IREHLekhIWdZ/pRVv4o1FNl1d3iUorDEmQboYIx1o0DplfWtkeleULUl1qdLUzhaWY79Sosv7BL/+F6TRgUwpzYow==
Received: from CH2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:610:54::12)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 10:07:13 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::45) by CH2PR11CA0002.outlook.office365.com
 (2603:10b6:610:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 10:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 10:07:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 03:07:00 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 03:06:55 -0700
References: <cover.1722519021.git.petrm@nvidia.com>
 <ba50a38cbf211cc98bdbebfda53226a1785f73e7.1722519021.git.petrm@nvidia.com>
 <20240805152344.2aa5f237@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 1/6] net: nexthop: Add flag to assert that
 NHGRP reserved fields are zero
Date: Tue, 6 Aug 2024 11:48:21 +0200
In-Reply-To: <20240805152344.2aa5f237@kernel.org>
Message-ID: <878qxanex2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cbaaec-5465-4432-b546-08dcb5ff8aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3+r4xLgbLiJCGTsw9zKdxaTguEY4Ib4dQanjTvnA4S7h9yvKVseRZn7YS6e?=
 =?us-ascii?Q?p4ItcFx/nUYQOOwPtkoCvbrBzg4c6m0QyiwWfWtX9K7yU2q46qmQCt/mFxy9?=
 =?us-ascii?Q?wtlWiJ0dHf3zjX6S0debqXEba0x5TNTOVGMqlGEjM5f4JHrufwvOrNbVpdNG?=
 =?us-ascii?Q?WhUNAAkVQXe6nbkaKoeR0ohhg6kA2vC2nrSPG6CDAC/HcBcY5GYakYFkidG7?=
 =?us-ascii?Q?4T00Uk0LYAgd2xZ8PWcrtbAGIwMKBOmF+YC9Apv2R/yy/huA0ngkpLj20+Cv?=
 =?us-ascii?Q?sa2YJIt6+tW7EvF3H3myEL81y7/r3DiImwCsVVf69RyfrrM/wQ0oLdZgF0nY?=
 =?us-ascii?Q?gtHxipYAqpiNpxZtmkoptsyZbX1G7xdzcNwMrIWG4iQF3iYHz4uhcRAWh76g?=
 =?us-ascii?Q?M9t/nzom01nB198IVjXXhqb8FNSGKtl4MnjSt/K40myQ9z0s1il7ifcVjgKs?=
 =?us-ascii?Q?gY5zf0Q9uVCimOk35hLcxRkE5d9nYhxgHHBpNza4Y5YXCC5XXYqLwYHn+jL+?=
 =?us-ascii?Q?RJj5A1Db0QgcoMHeF5OXMgb7SHTntG6bpydowCo0oIHD86DrIhB5aeTu+3z5?=
 =?us-ascii?Q?nhGF91Tp7QYdSM5T/BDmn3FZIMnDc7rpuXCDX62Z4vM3DY4MzgZ/m1xNAkLP?=
 =?us-ascii?Q?5s4NqHkqA0blymOHvxDu4ZEJYSrKFdq6AtbuteDrFW2gXYjt8L0Kfw6PN2dL?=
 =?us-ascii?Q?60fCyZ4w7GSlIQU4WVnv7AAcmcmHRFx1K7CsKgDk1iQSL4wD64uVshhAQtqQ?=
 =?us-ascii?Q?sUvOlvBY8rhkEUXZCI5Fh35NIce+fzy2MHdMhHJtuWLy/PX7XTQojeZw6/yQ?=
 =?us-ascii?Q?FKU8SuobFakWV4cO95Kq6TUfs9+9rX5hdZ0GYBsDQIrsprTqcSuuQoPoksMY?=
 =?us-ascii?Q?DMTnsZomowo1Hy8QJsheYnHOYus/CCyNW2E4LtQvN8hhZrkaXuYHCgoilGjB?=
 =?us-ascii?Q?tkeuhAZNm0Xr+l+/SmDZI9Qd3fj5Rqui8p7V3UfQezZKQcq55VZbxCXd2ZSL?=
 =?us-ascii?Q?NY5siE/e49b5vvDzpIyWHnHFU0UF/CnsOCq+V6X/WPjEUNufp3Bo59G66gbe?=
 =?us-ascii?Q?ln3yb8I4xrXoYjLv9p/i9unaAVPW1yH7xVvygjv6N0Wgw3fiT90LG7iumHIv?=
 =?us-ascii?Q?RiMLkCWTVew0JDMOb0zZFwYiKLb/iTZLeAnYn1D7o0XlLK+kTNaim0y4ORii?=
 =?us-ascii?Q?/KBaytiIc4ejD0asrD2QjEJSdSTZryH1KV4GrO0P1Dpme4b0A3W4FK3dBL1c?=
 =?us-ascii?Q?7+pAnqijMgPmJpsalsXlCK6d/K/qDVn55TgDQaCkwb53sgqFn7XR63IUjpHf?=
 =?us-ascii?Q?z7EN0VbgotdwdtIil+X+V/F9Pqhe+h/tZpfN5FB54SX1G6NcWnTfVtNDbWgr?=
 =?us-ascii?Q?RrmTsuR9jMIsNcrfMxXjNGJ5AFzlS1P9MXWGHSCJ7ntr0c2Z45WJtF5ok5B5?=
 =?us-ascii?Q?vD+HUtkZvrMabECNr0NbtomnZQS73vM+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:07:13.0393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cbaaec-5465-4432-b546-08dcb5ff8aee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 1 Aug 2024 18:23:57 +0200 Petr Machata wrote:
>> diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
>> index dd8787f9cf39..2ed643207847 100644
>> --- a/include/uapi/linux/nexthop.h
>> +++ b/include/uapi/linux/nexthop.h
>> @@ -33,6 +33,9 @@ enum {
>>  #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
>>  #define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
>>  
>> +/* Response OP_FLAGS. */
>> +#define NHA_OP_FLAG_RESP_GRP_RESVD_0	BIT(0)
>
> I guess these are op flags, so nobody should have a need to store them,
> but having bits mean different things in and out make decoding and
> binding generation much harder. Let's not do this unless absolutely
> necessary. Perhaps you can start defining response flags from the
> "other end", i.e. bit 31? Chances are the two sides will never "meet".

OK.

