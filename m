Return-Path: <netdev+bounces-136126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AFA9A0648
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FA1289DAD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714720605A;
	Wed, 16 Oct 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUMMS7CL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844720605B
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072749; cv=fail; b=ER6Oea/w5xDh8tWs352PlVIdIrGD0ihPC+u5Z0Lu9Fbj/VY8D2LZ67elS6KWiIZtv2WpeAbOmDVl22qivRIoalGmT4pILOsMecmeq/EGUweQhK3pUONs+6C/m/PKV1XmLlDvzN7OYwyBeRIBgFgko616XWjllJXgPqyCf9bo1Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072749; c=relaxed/simple;
	bh=bYcj53MTcjZCVt1CKt+X6r4nBZQortFp7At6m0BTLnU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NL3Aj6Jw1zvb8MIMTYyqreuO2YdY5lASc7mxumM5++28J4e+ftudOJMlAmbaUw6VSBfM6e2Bkn+LV+4kCMBAtw5GadALSvZWb1yjy27DXqiXvcZYjFfEH/xTrkatzxXUts+dBUtSZ3+TX9OiBBqb7oFSx0O2D6a4x6YDgiUqfKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FUMMS7CL; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBoTqJ/RjiCaCRz3FtFWqdwvZleNBNz3AFol5aE5vqfr/gv0jI3Rp8RXTqZeZ33cxPUXQy0r92qBGVlEFP4lz6JLDYAiEhht1CrflkX/Tnplm3w7WxDeTi1LSdqwd/qJ7gkZjy0hfbE0XcROB3p7YtN5PtXEnY5kF/erc7VV693nHL11JTFf8bj3AF6d4tmtLMR7XAbvxZHMtc9JbdYnXwgI/8B/FNmpkIMcJQwm/O6XA2LzNUv7tgyjyOF58X4Qbrdk3n5MkJxtbH8pkFfae6aypU7jP5gxTOH1WT/xoca1RgsCfrwA9n8eFZSeHQcjAfil1f7Yi0CvAseB5TJ5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYcj53MTcjZCVt1CKt+X6r4nBZQortFp7At6m0BTLnU=;
 b=gZHUfyiifv4MmE3B/1adF+qX6RfhYe/rkloQ2JGi9RzCV0bmQpmEgRPVtw69sm5OCyzjTEKp5ETNv3uuMG+t6B4nChDHP/MJPEbMmU7lBUrF9eWIBRUfO5FqLilFEpMHIckAfsMqlqThRf5DEhoffYLv8wayPxBAsZP0FJNr/0RY0U28Nbq9PRp2khq1vWG4EhGawTy98uQvR22/5NKDiMQpM8PBUi3hTcoEUFFB6uIlsW4Zx3H2Nf6MXR4mtFZaGHXp87XUoI+qw0iIso6vG7CmI2MfCNGuq7vauTsmsGJ5/6ieznrQJwqe85bN8afEp0NYLyE9ZyS2XvYhAKkn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYcj53MTcjZCVt1CKt+X6r4nBZQortFp7At6m0BTLnU=;
 b=FUMMS7CL22lOZbQHB1w111hF0zDBgjoSJv0gI+JHoRvfgThWZ385JdC21szhLjujrAk40g6nLS7Sb/ldPiCpwY5cfznS5ON4REfi+uhcvxIpzKGWVKFZ7dW3GHgnV60Ff+ZhD9ffEx6CnDVJv1Es59NePILMlf4iK5DWZAq+vbRSNlurDy0MpdRROTYY7KetPet5Cbk3xLzpyyDywz2smQYsJ/GnblJcFYuvLsKfV2691eX7O9jLfiJ3rQyWOUm7zvsjUNyCrgr+Qg+y9LJuOsx/hgBOW54gSO6QK5yd4NVqzjtc/OcAe94L8Tnrf5dfbG6o8PmhTfXsLuQVhUXZDw==
Received: from DM5PR07CA0086.namprd07.prod.outlook.com (2603:10b6:4:ae::15) by
 MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 09:59:02 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::a8) by DM5PR07CA0086.outlook.office365.com
 (2603:10b6:4:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 09:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 09:59:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 02:58:53 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 02:58:49 -0700
References: <20241015063651.8610-1-yuancan@huawei.com>
 <8734kxix77.fsf@nvidia.com>
 <107fb00f-1dac-4a13-b444-af2649901ae4@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Yuan Can <yuancan@huawei.com>
CC: Petr Machata <petrm@nvidia.com>, <idosch@nvidia.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: fix xa_store() error
 checking
Date: Wed, 16 Oct 2024 11:41:28 +0200
In-Reply-To: <107fb00f-1dac-4a13-b444-af2649901ae4@huawei.com>
Message-ID: <87bjzk2wtm.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bab469-26ad-4bc8-9740-08dcedc92960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fu5DMTvGTpU4COfNhC4CGWON33rWPgLRfH4UR2yI+6ljDU14bEsKyeW8gMRE?=
 =?us-ascii?Q?+kKun8gp8bP52DFsKU00DDTXoN+TIUzsv9u5KFy55nkGcxL0V8chSIJo0JNc?=
 =?us-ascii?Q?kySZ8JE7Y+3/TS+Fi0AaX0XYvjaVDVOdmKYqROvc0Dzq+ppfsM+F+cXKojU1?=
 =?us-ascii?Q?6MmRjm1DHnRfpwBxjjuwh4E3k7FtYyazpqXTodx0rRVP3RBqAvzJELM5/Rug?=
 =?us-ascii?Q?X/oeZH8gylQo2RncN74AaL9J8HZOweliCnnBzbXECGw47VZsqoWk+fMGVkQ8?=
 =?us-ascii?Q?EM3RYM0jo8vXGYK4o2Dmv7YXgvqhPQs2sRqsFSstzrKXRD1kx+8GLjksOciF?=
 =?us-ascii?Q?4FLvIneA+p2i0T7pRlMAYxVrQHSY8013qC+Le4hLs0ghI5fRMFCVW+Kx/9X2?=
 =?us-ascii?Q?OyuZ+rhGEGRg6cF6R7vjzVXF7kCD10ooWaSYmG2lI3OYvxAm7LHFDqBX4wg6?=
 =?us-ascii?Q?hwjizvXrJevxB6NV3q2A54rbF/DRvdmxfmvH+8Fz8qSAnIeibN0IlbjBUtBy?=
 =?us-ascii?Q?Bdc6kCLm9WElbbn78sgFqWXedRNJZnUNo+ovwGZ917XXumQrLKzX1a6FN/m7?=
 =?us-ascii?Q?rogNjZk+L4D215Bpc7myBdKxwrkWc49ARIiUOMc+P+b1M6jhvJYuD2ZG0BUK?=
 =?us-ascii?Q?dOA8HeE9q94+ngNyJeqZ3FQ6J2BL/5xQd9q+pbBFyw4Dl2seKE1crs6xW/sN?=
 =?us-ascii?Q?dV7GaXAdEi9E+zWmSaEoi/I7i4hIUWAhefZ77wrKF5LA4I7Axp6RbCg0vDZ6?=
 =?us-ascii?Q?1FA3mYx/hZ/iRrsBP+0+Avhw4+MYhTl9kWScvPTl4jrQOJpajl9MfedOTY+W?=
 =?us-ascii?Q?/T37jz5Yi9uWMvr/5Ur5+Th0cdKCCQIMrSIBi7kRFtfijdOIGKhnykqz5woC?=
 =?us-ascii?Q?JFhXxkcumOvNEykw5YFJdoJdxjZknLOULP9UUgaJ5zrDZjC/+xnY0XrKF/Em?=
 =?us-ascii?Q?/qiYsbi8kaBDdgp53Zoa3PJK3D9+XPOha0heel6SfI1mCMfCiup95dUrrIt8?=
 =?us-ascii?Q?F3RLmcX4Xy6cf4X1jAAOQRE6GtVOrjSOGtH+cYzr0CJA+OiLVHa0K8LAgyiQ?=
 =?us-ascii?Q?ssdpK8xKNT1sZrhKuJEWEU1MlHlqr1y80GTr6UYP5QcxSXutaU1cs0Y80rDr?=
 =?us-ascii?Q?XTwqtZU2rGQ+DrMU0QKX8mrmZzeQpV7ihoPVcYHtuoV9HMLffFiaE03jxNjG?=
 =?us-ascii?Q?G5GlEbTDqprmBurIhwJ5aL/zlDcSlScfKaFwqNftvhPYUWcuItZrhumn/wvH?=
 =?us-ascii?Q?I5IveSuhaunkhu+AQaFP1nmktavA4sy6FIZqjXHWEOgZnROHAsWxI6lCcYlC?=
 =?us-ascii?Q?JS1SXDE+FplFWDVB9TqZKicRe6bJ4H7HKR0DxgLjoaX5SN/QCVsW14Ybj7Cd?=
 =?us-ascii?Q?LEHxo7IPSPStVO+h+0kQwqgxOL+s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:59:01.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bab469-26ad-4bc8-9740-08dcedc92960
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543


Yuan Can <yuancan@huawei.com> writes:

> On 2024/10/15 16:06, Petr Machata wrote:
>> Yuan Can <yuancan@huawei.com> writes:
>>
>>> It is meant to use xa_err() to extract the error encoded in the return
>>> value of xa_store().
>>>
>>> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
>>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>>
>> What's the consequence of using IS_ERR()/PTR_ERR() vs. xa_err()? From
>> the documentation it looks like IS_ERR() might interpret some valid
>> pointers as errors[0]. Which would then show as leaks, because we bail
>> out early and never clean up?
>
> At least the PRT_ERR() will return a wrong error number, though the error number
>
> seems not used nor printed.

What I'm saying is that if IS_ERR overestimates what is an error, we
bail out from mlxsw_sp_nexthop_sh_counter_get() with a failure, but
xa_store() actually succeeded, and the corresponding xa_erase is never
called, causing a leak.

(If IS_ERR underestimates what is an error, fails to store the allocated
counter, and counter sharing stops working. This will waste HW
resources, though I think it should still behave correctly overall.)

Anyway, it looks to me like a net material.

>>
>> I.e. should this aim at net rather than net-next? It looks like it's not
>> just semantics, but has actual observable impact.
>
> Ok, do I need to send a V2 patch to net branch?

Yes please.

