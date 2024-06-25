Return-Path: <netdev+bounces-106413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC07916203
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853911F22636
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D012D149C74;
	Tue, 25 Jun 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAFUoPXa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD1149C50
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306574; cv=fail; b=iPm9K2qkBR1v+3JALB6jmu+PThqa0d+CxHZ6kgx+KHV5UI72wxeK6wpBDzl+eFoDIhBpgyY/cjEbQXSmj2U73MGrmxBKGqF7VG83xEDqd5mwCnQOvgCLQDMNjmycisvFdaM4MEutUOng8x6mG55DRBHN9ffMqU6XMd+Hh7XvtxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306574; c=relaxed/simple;
	bh=pfRUyfANtt1+tAMpZ5QPv+yoiVpOGXGvnv+b05Em9s4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KQgdjJWlC+0Teg6hy+SIMu3Fxka0FNtpF+LvAK3dtY/tNvOkyLE4WBvDI82kp9OuRxfKY75pMXwiOdaGAJ/qgIsJmcqFP51eM3Fe1tftr09cMU/kUuYJZJfYCvbljYIgYhYf1PlkXq77ZS7rkM/Ncg+R8eEpVf6eiSvZi5tvJms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BAFUoPXa; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjCXzmLrwYbdkGyAuM+vRkPa/Clo9T5uxN4RtUzRWYBRbyY0adAEDbRyrue+tYXHCZDdNDtHE/sNQTnWEluKQz+GQ1Cen40DwtLPk7keGmJou2rW5ZnOphyM4rGDC7NIawsBLUPd3vldTZidmj57obNsCSTQGpGeaSFj1BMDKcHdSPlrC+YVJWOzo+3s1CaHN9igDM2FMqQesOX8/zsTTRnZZ+QV8crkNxbM8knoqLzddOHcUoiKfcytcReaBm5uid60f57hvS1u/ldlZMRVKI3ZhdaGL4QBj4Z5DadRuCv2PIMCjnveR7YMFBJLjm8UcajXEWgBLrPjgCHAJFFXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfRUyfANtt1+tAMpZ5QPv+yoiVpOGXGvnv+b05Em9s4=;
 b=Ar4rCz1PfY9cJZdowLWTWQbFjTvqj4UNjJCK9NdIkx0MoxdGv+n5CNq3jgxZTzfsrGJdWGs4XqqWOGb91yeTf4csjJflvg8cM/3lRUwadk2bAG2t1+Ks6avFVLVFNCYjJMODI78u0g22cweVKG2XeH39WplBT7B9rU+s+x7JV5PYFd1hDV8XQUNj1j2Rk969ESjvfejh4dd7TkIX6O+hgYTd0EujVwYR/C05W22pYD3s05S5AK5QSwVlPwqSy0v40hKDC7w63XhbTQAMwwzbCIiLxOkePAP1eeBoz5q2XeVXG7M0jIRPXUPy1ZWrVfvWXFszcgm8j+sMp7IbILXxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfRUyfANtt1+tAMpZ5QPv+yoiVpOGXGvnv+b05Em9s4=;
 b=BAFUoPXaBPAZr4j3bnXGVDmFnqfG1s5SXI9aWyxDz2PZb/6MjYALLDKToJT06Dfx4o0cn4smZ0NQP5jx4fLRrgP7twIaE2IccbO7Oio/+sXSw3oKXXZXtOqr7/QwNBjO9uS9B0WdUvNeMlgkVif2sD4svLN62tSKlr5/6ub+zggD4b2BGE4Zv29Hg8zplccpXXG38h/1BFtB2mUcXF5I41gPzYHmQRslH+nenw36HtglhcvCEpQTu3/1rTK0AkNj/pcoNDo2QRc3Pr8tBME7w02PbaRerWdMew5ey958oBooxtIMi7FHTDnbenM0+x0dx7IPwq7cPSoX3EkoSwwxtg==
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 09:09:29 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::33) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 09:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 09:09:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 02:09:09 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 02:08:59 -0700
References: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
	<woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>, "George
 McCollister" <george.mccollister@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
	"Oleksij Rempel" <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Date: Tue, 25 Jun 2024 11:04:49 +0200
In-Reply-To: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
Message-ID: <87frt1bd96.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: efd1bb58-4f00-46d7-7fa1-08dc94f684ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|82310400023|376011|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHhNQ24vYjJVUlUrT0RNaXFnR041OUpuczFweitBODdxTWl5OWF3YThGaEky?=
 =?utf-8?B?ODJxaENFNXI1MitMaHdlV0JwMlp4WmQvWEdqckVFODhKYzNRTWNLMVR3T3F6?=
 =?utf-8?B?d01mRDFKU3NaaHhWN0poVEhyLzVvL3NGQVVJT051emdIQ093RUhVamgzcmox?=
 =?utf-8?B?ekVOVGcvemZGTWlYUk9JSmUxTzcydVBWMy9Tclc5VmdBdno0aGhsL1RGWlQ1?=
 =?utf-8?B?QVRhMDkzOFVqenpLOVRZVWRab1YwcDJGd0tWeFFUdUQ0VEZoaCtFSzE0Mmor?=
 =?utf-8?B?Sm9EdnFDSXpRVVJCM1loWWs5V0ZkT0VIbVJRbnB1d3ZiYzY5TXo5Z3JyYkow?=
 =?utf-8?B?NzZKSnVOTHAxM2hSQ3ZLQmQ4cWp1dDVTeXZRTExFK3RLcmJLNVFGM3VyOTRq?=
 =?utf-8?B?WnJGSjZtMWt4N3JiQTloNkFaSVJEODdjRWwrazd1ZWVUVVdNSUtHTU5mV1Rj?=
 =?utf-8?B?elFnc0xYN1NiVXF3dVVYTTFqb3RocWc4b21iMEYyWVlkdy9IU2VRdk5TNEt0?=
 =?utf-8?B?YU4zbTlWZnRmYisxWGQxMnZPMXVad2owVk1yM1JZbjdrbDY3WklXakZzc0lz?=
 =?utf-8?B?aVZ6K0RhVFJ4Q014MjM4YWc2RlgzLzZYTmUyZWZVMnpwSFBKeTdPSUtzNEdO?=
 =?utf-8?B?LzVXLzgvR21OMFFFT0h4MENVeW5jUnRVUmg0eHhZUlMxRllIY05GdmE1ZG42?=
 =?utf-8?B?N1J6eWdMVkd1cUZLWWlrajhTZ000bDUzYXpYSnBhN2tQWEQ4eHpReHFNUWUz?=
 =?utf-8?B?ZVZCdFJIZnVnTVYwa2JrS2NFZHJmWk1tR1BvbEpvU2ZRYVFaamd4OGdLSFJF?=
 =?utf-8?B?YVhBTWcwT3R6cTdLa0NtbFkxanZCODZ1bXAvNlJONDZXYjA0YTh2VXBRdHdX?=
 =?utf-8?B?QnRJWFBNcUc5MXJJTStCMTVuZUVZR1l5WE5ZOU1CS2lBVWNEajNDQmRDSnp3?=
 =?utf-8?B?Y2h2aFE1OFRmd2NRbFFwVEVCUXpJMTU4b05rY3FXNGZ2VEVxRjd5aDRscW50?=
 =?utf-8?B?eGt5R0Z2MXFLbkpkQ3ZvKzUwdXUydkk5WCtkaWt2dmMwYWRGSTJJNU5vRnRN?=
 =?utf-8?B?eWZ2cG9OcjUzaUhDcE84enoxTzZkMDJFRVNIMFZmUU1OY0tPbnpTUWUxQVlt?=
 =?utf-8?B?Z2ZWYnZhYmx1YUJYa015TkFybGtLUnF0cE1DR3kvS2NYOGxHUmNqcnVlV2hC?=
 =?utf-8?B?a0h6Y1h5KzB1UXl3NEF3dGF3ZittYkJoalBTNWxDcEY3OUd6NXV3V0xZNW1v?=
 =?utf-8?B?ZEQ1WGxnY0F4V3JjRXVCZmF3WlFMVk5oZTZGU3kyZzdEend6blpnNkhEVDF2?=
 =?utf-8?B?TzltMmhYek5qWkYrK2lNN1cydjV3SXArWUVsMlNEVVpFeTVKNmZMcFVkS2VO?=
 =?utf-8?B?M29mOTNPdVB4NURaSjhMU3RDcCtsejl6TzgxVlNKdGdWTGYwRzAwMytwaWZD?=
 =?utf-8?B?THpaVlNaMk8wWUNlV1U5K0JWL01MaExWbm02OHRIZVdHbmRaNndUdzRLY1Vz?=
 =?utf-8?B?ZExaRW9KSzQ2Vk9UcVFJSEI3MXRsczEzNmNDb3NGSXJSRWZGOE5XSnNtemhz?=
 =?utf-8?B?VWJ4T0d6VmJCWGdnS1d5MnZxQnFWdndmWk5XeUdvc1FLZzFhRWtSc0crd2N2?=
 =?utf-8?B?T2lxRmQxUjdBdGZZVW5YVjY0NHJ2a1dqVm50WTZFNjJwUVg3Si9pNjZOT2xK?=
 =?utf-8?B?UitXZTRlbDFhWFErRWN4MldrSDM5VlJBamw5MTVtR1lYazhQVDdXcTVOUXVV?=
 =?utf-8?B?NTQ4emE3MDFwOTdBdDZoeVlmeUFEdVpVR3d6RGVuaUFJM0lBZXBvMW44OVhu?=
 =?utf-8?B?bEkzL09BbU5ZTXMvTmU1VXFodXF5SWR0SWtndHdpRnVyeHZrTjJ5elJwd2Ez?=
 =?utf-8?B?bVRFK3ZNclJQQTllN1FYQVBmUWhCT29GWWJNdWlLMDBJQVdwdFgxZ1NMYVEy?=
 =?utf-8?Q?hllBJySdqdknDnXQj+tRDgOO83ez1F+5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(82310400023)(376011)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 09:09:28.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd1bb58-4f00-46d7-7fa1-08dc94f684ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406


Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> While add it, also remove commas after the sentinel entries.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Petr Machata <petrm@nvidia.com> # For mlxsw

