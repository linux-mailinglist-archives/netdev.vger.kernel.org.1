Return-Path: <netdev+bounces-120930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D410A95B396
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84334282ED1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3A1A4F33;
	Thu, 22 Aug 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dOjpYAv6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FB71A4F28
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325355; cv=fail; b=PSk1xKZWzB2YatBEAiqp/ySQXOyktvPs76Yn6rPCBNWMtPLsh1EDDol2Vd5z/S9WLB7Lz+T8N/my3UNHOkXTHIt7bgkIPdmQPgIXa3ngc04G9AaGaGehx1svU9/UttOumCi6RZoMkty4Sg5LjpvpOGZF+JNnO1tZDXXrHlzFPDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325355; c=relaxed/simple;
	bh=/+yJ4EntPhMo524yU1MRAEMh2xYlMnFbixNbR4jNpA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDMvsDKZ1T6KMa6bXgPLAQBDbXw6CSEhoHSMmrRd4y14KKPJaq/zVXqstSSfJ68S2hzL7KWhK6KQeSwMJU1Pj5i36M66nHJaL1DRZ28QkgzFuKpcJvfKjqaLsUcfvyKl23fIGL13435L19NNYa6gOSh6OUKp0eJTgerfCE1dBnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dOjpYAv6; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLREJzCgzyjuHmVTqTtX6cWfFGAopRHyz3CsU2u1gVDdn+55ph0n8rvSMcBnsdvrvPmylEyXbBjueCUhP34Md6zZQTWhIXBYniP5sZ3nYW4AuiMY9zLczwztzv4QvuhlZqi0nrkty6zlC+OidZWP3aY+8B54eBwmTpbc+gMnlxO2nDMHXzby99eOGKOVXh/YWIiM4/D9Wway2SlrsM47ybVUztj38oberW8MgWRLFwkzpiU4XGPGha4CUWt8Q0en7N7J3jEbrVor9f5I3OljJUtLGPC64HTOVK/hrrbNa5HzyN/9X7f4LL2CfGuC6PzGGc0rOeE1raOZOuNIXy27rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlX1gZ5ndup5TfRjLFZgh9GKzUqwGEx7mSyrBWM8P5s=;
 b=ZrpmmplC2qT+ffUiN2KUFnWvkkr4pJfxHtL4zMGoDTzA7AQe8w7Es2Yj54p8Im/nImlyk1TQ8YqZNRu+fI4vgRNB5uBxwLTMzyFUyHoQ9Z1l1Q3Sl8E7MEjAjAX3DEy3QgW5WMlx9rGz6BdwO2w1G3EB9r65NxVneAjG4HSW6Qi+gJ97ls78rk+PfvAKJpR+2xjUkvoiYQxU942CoQKXAF9O9WxQo4+lcvlNoMiMwdSgGbaEGjTwy2PzEREHoFeBNl1I0w505xx0JTEEQADNuH4peVGgd4nOqDayPeX6Ih1CkoUSQp8ivWrVIUdM/g8TuoI7FVxOWF73yn2kuSNudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=jvosburgh.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlX1gZ5ndup5TfRjLFZgh9GKzUqwGEx7mSyrBWM8P5s=;
 b=dOjpYAv6iCdrKPYVMXrwtlvuUBfKE6Kkc6OxvupZ+0TgPxPLf3D5idQau9JlIhjRer/BARgWSDyT1rN6+n7YHNwK/k6fA9o+/9c7qC/9FGp8jjqW4BrhPpijTq3AlSuYR+VULu/VrDHK7OIbJ5Q2GDcL/Vq+6yJssjhiqz1sVf2OgIWX3EQzSmtJ3pssccClhwzF2z2sv2VUvf2YdNalJiFcQtmCftVM7uOB9uNFaJtUvSLrsyVY9+wQckjVqwM60rwOX0V+oXEFEzbGFr2f3AWFRkInz1YLwor1yP4sbrfSiEAarBjCIjYq+lrhNtK3D4P073YfxaHEB2ZwiQWMYw==
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 11:15:46 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::89) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 11:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 11:15:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 04:15:31 -0700
Received: from [10.19.166.250] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 04:15:27 -0700
Message-ID: <02d8277b-e6fc-44d4-8c88-2eb42813cd22@nvidia.com>
Date: Thu, 22 Aug 2024 19:15:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
To: Jay Vosburgh <jv@jvosburgh.net>
CC: "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Leon Romanovsky <leonro@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Tariq Toukan
	<tariqt@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, "kuba@kernel.org"
	<kuba@kernel.org>
References: <20240821090458.10813-1-jianbol@nvidia.com>
 <20240821090458.10813-4-jianbol@nvidia.com> <120654.1724256030@famine>
 <2fb7d110fd9d210e12a61ebb28af6faf330d6421.camel@nvidia.com>
 <139066.1724306729@famine>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <139066.1724306729@famine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ddafb8-0fb2-42ff-d43d-08dcc29bc53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzc5Um9iRDNjYjY5KzQ4dzlNUzBvNGNZbXpaNkNKNDNSYlB3T1V0YjZNME9C?=
 =?utf-8?B?UFNTQlhaQ0ZjNm5EbUhBOUExaG4zdC9yb0JTQjM4ZGp3ZDc5djdHQ1BQQ3J5?=
 =?utf-8?B?T0dMT21QL2lzK1VuQU1SYzArTjVGdGNwYlpDZGZKWGx5cmtVVDNEakpMMUd1?=
 =?utf-8?B?OWdKckVaYjJ5QjJROUxtZWsyajgvVERGQVZURkNXbHJDa05RYy9BQlgrYUc1?=
 =?utf-8?B?M3BjdWZ5ZnVIakJINngwbVVBbUJVb0dOcHJzZ0FmOHdQTlE4dzhEOS94ZmxC?=
 =?utf-8?B?S3ZPS3Vqa1RGbnpxK2tnbGJZYVR3WTZ2M1lDOWYyaW4wQnVzamlkK25pelpL?=
 =?utf-8?B?Tjd4ekc3d29CS0grVlFHdGt1NEZXdEtGb2FpWXlmY0pCSGg2SVcyTTM0dGZR?=
 =?utf-8?B?WHpQT2x0bFFib0Q1ZnhhQ3RjNm9yMy9HZ2dBNEtlNks5RUFMcFlxcVdxOTNi?=
 =?utf-8?B?cWRPMDRqVVJWOFNKMVFSTCtLVUtjNXdXQmNIb1ZzRjduMTZRU1h4SkJMYmda?=
 =?utf-8?B?YWtyRXFwdVhxSm03MkxBRXVXcStEblRqVUMvbHJLcjc3U2ZuNytZYXJ4cDBa?=
 =?utf-8?B?V1ZXaUVMcEJOU09QUWZZVG51WDVhcXJyY0xkeHU2WUUvY1NYRWg5K3JPVjNl?=
 =?utf-8?B?alRFZE0xOGZLampYeHA1Z3pCMkNwaG91S2QxNy9lMURENVl2Sm1BdVpkdDh6?=
 =?utf-8?B?VVFRY1JpT3lwQzRqUTQ0YWpVQms0WDlIaGVJWXNrU1Q2eUJOOXhGQkJCak44?=
 =?utf-8?B?SGxTWnYrWnh1Z3hXNXVLUFJta05VdkJPazBXV3BCVDFwUTNKcmZ6Lzhoa3RT?=
 =?utf-8?B?dm5waHRhVEV6WGFSVDVwK1dJQWxJTGQzVmtKZ0JQck1uWkVaUlZFZjJkbENY?=
 =?utf-8?B?SlliSTdHQzU5NUFOMDZKZGNlcjdFdFQxTGVndHQyeE5EN0Z0QWg2UDNCRDhj?=
 =?utf-8?B?eVhnbldsN0FJdGRQbllhM0ZYSHMwRytWNEZrQmZJaExzaC9vaVJ4RTRVa2po?=
 =?utf-8?B?VFRESnpPRXI1aDZ1ZkYzQVo3YXhBVlRXcDFldDJRenNWd2NmUTFleDR5ZXFG?=
 =?utf-8?B?NGU5YVFDcXJkMHdqZmNFWm9xR3FOejBHWUM4WWJNc09ZeTY4NnhMWGh3R3hr?=
 =?utf-8?B?YTR5SUdsZGRCdFRQVnpveFd4NXVvZlJPaUZMaVBTeXE1K3FDUS9NRnpxYkVS?=
 =?utf-8?B?UXFtOXVjSml5OFd0bnRwYjUzOW1FalFBNEJrRFRuVWl1WUtoVXRxbGFLbnFq?=
 =?utf-8?B?cGdaZ1JIdmQ1WW1vQzdqRUVycTk3UEQ2YnczSXlIOFJhbEVDU3VRRFprL3FZ?=
 =?utf-8?B?eWhmOEFMVGVaMlFUU3B0TWhFbjZMa0c4OEc4dE52ckI4MFJYN0pES2lhaCtL?=
 =?utf-8?B?S3JEbWErOG1sQTRSVllCRjF6RkZXc2RmdzJCdHFXMzVzZjNON1padGZCbXJT?=
 =?utf-8?B?TE5kWForVERZUURaM3BxTDc0OEZHR0trU0wxMUZaMnpBRnAzbmZUSk1NUGNm?=
 =?utf-8?B?TzJzL1VkdlEyejM2dVVlT1gyUTZsKzIwbGFaTFl6WDdSUlB1ZnVLbEpESk1I?=
 =?utf-8?B?Z3ZWdnVNQ1hsbmxNbFhjSHRJWkxoNTFlZVNydXZOcTdKN1FWc3RLbWNrQ3JK?=
 =?utf-8?B?K3pKdWZXVGp0dWFhR1JvUGNESHFzeXlSaTVGTlBQc3JiYVQ5WExCM3B3R1hK?=
 =?utf-8?B?WTN5K3VUMTY3Q0l2NXhIRS9EdENIUGhRZkovZ1VjTHcyRzVxS2dZRGVIQWRo?=
 =?utf-8?B?bzRQRDc0SWxDUWtZNk9mV0lTWWlIbzQ1SDVkZUpOd2luR2pva0RtMzFmVUt1?=
 =?utf-8?B?UVhYZ3VoNjVNOXAxVE9oTk92TXRmeGxsRjlEN0Nwb1E4ajgwOHdrdE5NZVlM?=
 =?utf-8?B?K2ttZzVxa1dJdzhVZFFZeTFwdG14elBmZlI4UUVTK0Z0ZGV2SStLZ0V0RGdU?=
 =?utf-8?Q?HLpDKQdkT2df+ZVp9ejdkYl0826Nvjm+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:15:46.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ddafb8-0fb2-42ff-d43d-08dcc29bc53a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895



On 8/22/2024 2:05 PM, Jay Vosburgh wrote:
> Jianbo Liu <jianbol@nvidia.com> wrote:
> 
>> On Wed, 2024-08-21 at 09:00 -0700, Jay Vosburgh wrote:
>>> Jianbo Liu <jianbol@nvidia.com> wrote:
>>>
>>>> In the cited commit, bond->ipsec_lock is added to protect
>>>> ipsec_list,
>>>> hence xdo_dev_state_add and xdo_dev_state_delete are called inside
>>>> this lock. As ipsec_lock is a spin lock and such xfrmdev ops may
>>>> sleep,
>>>> "scheduling while atomic" will be triggered when changing bond's
>>>> active slave.
>>>>
>>>> [  101.055189] BUG: scheduling while atomic: bash/902/0x00000200
>>>> [  101.055726] Modules linked in:
>>>> [  101.058211] CPU: 3 PID: 902 Comm: bash Not tainted 6.9.0-rc4+ #1
>>>> [  101.058760] Hardware name:
>>>> [  101.059434] Call Trace:
>>>> [  101.059436]  <TASK>
>>>> [  101.060873]  dump_stack_lvl+0x51/0x60
>>>> [  101.061275]  __schedule_bug+0x4e/0x60
>>>> [  101.061682]  __schedule+0x612/0x7c0
>>>> [  101.062078]  ? __mod_timer+0x25c/0x370
>   >> > [  101.062486]  schedule+0x25/0xd0
>>>> [  101.062845]  schedule_timeout+0x77/0xf0
>>>> [  101.063265]  ? asm_common_interrupt+0x22/0x40
>>>> [  101.063724]  ? __bpf_trace_itimer_state+0x10/0x10
>>>> [  101.064215]  __wait_for_common+0x87/0x190
>>>> [  101.064648]  ? usleep_range_state+0x90/0x90
>>>> [  101.065091]  cmd_exec+0x437/0xb20 [mlx5_core]
>>>> [  101.065569]  mlx5_cmd_do+0x1e/0x40 [mlx5_core]
>>>> [  101.066051]  mlx5_cmd_exec+0x18/0x30 [mlx5_core]
>>>> [  101.066552]  mlx5_crypto_create_dek_key+0xea/0x120 [mlx5_core]
>>>> [  101.067163]  ? bonding_sysfs_store_option+0x4d/0x80 [bonding]
>>>> [  101.067738]  ? kmalloc_trace+0x4d/0x350
>>>> [  101.068156]  mlx5_ipsec_create_sa_ctx+0x33/0x100 [mlx5_core]
>>>> [  101.068747]  mlx5e_xfrm_add_state+0x47b/0xaa0 [mlx5_core]
>>>> [  101.069312]  bond_change_active_slave+0x392/0x900 [bonding]
>>>> [  101.069868]  bond_option_active_slave_set+0x1c2/0x240 [bonding]
>>>> [  101.070454]  __bond_opt_set+0xa6/0x430 [bonding]
>>>> [  101.070935]  __bond_opt_set_notify+0x2f/0x90 [bonding]
>>>> [  101.071453]  bond_opt_tryset_rtnl+0x72/0xb0 [bonding]
>>>> [  101.071965]  bonding_sysfs_store_option+0x4d/0x80 [bonding]
>>>> [  101.072567]  kernfs_fop_write_iter+0x10c/0x1a0
>>>> [  101.073033]  vfs_write+0x2d8/0x400
>>>> [  101.073416]  ? alloc_fd+0x48/0x180
>>>> [  101.073798]  ksys_write+0x5f/0xe0
>>>> [  101.074175]  do_syscall_64+0x52/0x110
>>>> [  101.074576]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>
>>>> As bond_ipsec_add_sa_all and bond_ipsec_del_sa_all are only called
>>>> from bond_change_active_slave, which requires holding the RTNL
>>>> lock.
>>>> And bond_ipsec_add_sa and bond_ipsec_del_sa are xfrm state
>>>> xdo_dev_state_add and xdo_dev_state_delete APIs, which are in user
>>>> context. So ipsec_lock doesn't have to be spin lock, change it to
>>>> mutex, and thus the above issue can be resolved.
>>>>
>>>> Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
>>>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>>>> ---
>>>> drivers/net/bonding/bond_main.c | 67 +++++++++++++++---------------
>>>> ---
>>>> include/net/bonding.h           |  2 +-
>>>> 2 files changed, 32 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_main.c
>>>> b/drivers/net/bonding/bond_main.c
>>>> index 0d1129eaf47b..f20f6d83ad54 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -439,38 +439,33 @@ static int bond_ipsec_add_sa(struct
>>>> xfrm_state *xs,
>>>>          rcu_read_lock();
>>>>          bond = netdev_priv(bond_dev);
>>>>          slave = rcu_dereference(bond->curr_active_slave);
>>>> -       if (!slave) {
>>>> -               rcu_read_unlock();
>>>> +       real_dev = slave ? slave->dev : NULL;
>>>> +       rcu_read_unlock();
>>>> +       if (!real_dev)
>>>>                  return -ENODEV;
>>>
>>>          In reading these, I was confused as to why some changes use
>>> rcu_read_lock(), rcu_dereference() and others use rtnl_dereference();
>>> I
>>> think it's because bond_ipsec_{add,del}_sa_all() are guaranteed to be
>>> called under RTNL, while the bond_ipsec_{add,del}_sa() functions are
>>> do
>>> not have that guarantee.  Am I understanding correctly?
>>>
>>
>> Right. bond_ipsec_{add,del}_sa_all() are called by
>> bond_change_active_slave() which has ASSERT_RTNL(), so I think they are
>> under RTNL.
> 
> 	Yes.
> 
>>>> -       }
>>>>
>>>> -       real_dev = slave->dev;
>>>>          if (!real_dev->xfrmdev_ops ||
>>>>              !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>>>>              netif_is_bond_master(real_dev)) {
>>>>                  NL_SET_ERR_MSG_MOD(extack, "Slave does not support
>>>> ipsec offload");
>>>> -               rcu_read_unlock();
>>>>                  return -EINVAL;
>>>>          }
>>>>
>>>> -       ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);
>>>> -       if (!ipsec) {
>>>> -               rcu_read_unlock();
>>>> +       ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
>>>> +       if (!ipsec)
>>>>                  return -ENOMEM;
>>>
>>>          Presumably the switch from ATOMIC to KERNEL is safe because
>>> this
>>> is only called under RTNL (and therefore always has a process
>>> context),
>>> i.e., this change is independent of any other changes in the patch.
>>> Correct?
>>>
>>
>> No. And it's RCU here, not RTNL. We are safe to use KERNEL after it's
>> out of the RCU context, right? And this was suggested by Paolo after he
>> reviewd the first version.
> 
> 	Ok, I think I follow now.  And, yes, KERNEL is ok when outside
> the RCU critical section, but not inside of it (because sleeping is not
> permitted within the critical section).
> 

Yes.

>>>> -       }
>>>>
>>>>          xs->xso.real_dev = real_dev;
>>>>          err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
>>>>          if (!err) {
>>>>                  ipsec->xs = xs;
>>>>                  INIT_LIST_HEAD(&ipsec->list);
>>>> -               spin_lock_bh(&bond->ipsec_lock);
>>>> +               mutex_lock(&bond->ipsec_lock);
>>>>                  list_add(&ipsec->list, &bond->ipsec_list);
>>>> -               spin_unlock_bh(&bond->ipsec_lock);
>>>> +               mutex_unlock(&bond->ipsec_lock);
>>>>          } else {
>>>>                  kfree(ipsec);
>>>>          }
>>>> -       rcu_read_unlock();
>>>>          return err;
>>>> }
>>>>
>>>> @@ -481,35 +476,35 @@ static void bond_ipsec_add_sa_all(struct
>>>> bonding *bond)
>>>>          struct bond_ipsec *ipsec;
>>>>          struct slave *slave;
>>>>
>>>> -       rcu_read_lock();
>>>> -       slave = rcu_dereference(bond->curr_active_slave);
>>>> -       if (!slave)
>>>> -               goto out;
>>>> +       slave = rtnl_dereference(bond->curr_active_slave);
>>>> +       real_dev = slave ? slave->dev : NULL;
>>>> +       if (!real_dev)
>>>> +               return;
>>>>
>>>> -       real_dev = slave->dev;
>>>> +       mutex_lock(&bond->ipsec_lock);
>>>>          if (!real_dev->xfrmdev_ops ||
>>>>              !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>>>>              netif_is_bond_master(real_dev)) {
>>>> -               spin_lock_bh(&bond->ipsec_lock);
>>>>                  if (!list_empty(&bond->ipsec_list))
>>>>                          slave_warn(bond_dev, real_dev,
>>>>                                     "%s: no slave
>>>> xdo_dev_state_add\n",
>>>>                                     __func__);
>>>> -               spin_unlock_bh(&bond->ipsec_lock);
>>>>                  goto out;
>>>>          }
>>>>
>>>> -       spin_lock_bh(&bond->ipsec_lock);
>>>>          list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>> +               /* If new state is added before ipsec_lock acquired
>>>> */
>>>> +               if (ipsec->xs->xso.real_dev == real_dev)
>>>> +                       continue;
>>>> +
>>>>                  ipsec->xs->xso.real_dev = real_dev;
>>>>                  if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec-
>>>>> xs, NULL)) {
>>>>                          slave_warn(bond_dev, real_dev, "%s: failed
>>>> to add SA\n", __func__);
>>>>                          ipsec->xs->xso.real_dev = NULL;
>>>>                  }
>>>>          }
>>>> -       spin_unlock_bh(&bond->ipsec_lock);
>>>> out:
>>>> -       rcu_read_unlock();
>>>> +       mutex_unlock(&bond->ipsec_lock);
>>>> }
>>>>
>>>> /**
>>>> @@ -530,6 +525,8 @@ static void bond_ipsec_del_sa(struct xfrm_state
>>>> *xs)
>>>>          rcu_read_lock();
>>>>          bond = netdev_priv(bond_dev);
>>>>          slave = rcu_dereference(bond->curr_active_slave);
>>>> +       real_dev = slave ? slave->dev : NULL;
>>>> +       rcu_read_unlock();
>>>
>>>          Is it really safe to access real_dev once we've left the rcu
>>> critical section?  What prevents the device referenced by real_dev
>>> from
>>> being deleted as soon as rcu_read_unlock() completes?
>>>
>>
>> I am not sure. But RCU protects accessing of the context pointed by
>> curr_active_slave, not slave->dev itself. I wrong about this?
> 
> 	No, you're not wrong: RCU does indeed protect the "slave"
> pointer in the above code while inside the RCU read-side critical
> section.
> 
> 	However, we also know that as long as we're within that critical
> section, whatever the "slave" pointer points to will remain valid,
> because what curr_active_slave points to is also RCU protected (not only
> the pointer itself).
> 
> 	For the interface behind slave->dev specifically, any attempt to
> delete an interface that is a member of a bond must pass through
> __bond_release_one() first, and it calls synchronize_rcu() as part of
> its processing (which will wait for active read-side critical sections
> to complete).  Therefore, the bond member interface behind slave->dev
> here cannot simply vanish while execution is within this critical
> section.
> 

Many thanks for you clarification. It helps me a lot.

>> I can move rcu_read_unlock after xdo_dev_state_delete(). And do the
>> same change for bond_ipsec_add_sa and bond_ipsec_free_sa.
>> What do you think?
> 
> 	The original issue was that the xfrm callback within mlx5 could
> sleep while a spin lock was held.  However, sleeping is not permitted

But, can we assume no sleep in xfrm callbacks, considering drivers need 
to interact with hardware? It's not related to mlx5 only, but others 
from different vendors.

> within an RCU read-side critical section, either, so would this simply
> reintroduce the original problem from a different angle?
> 

I moved the callbacks out of RCU critical section, because we never know 
what drivers will do. I thought bond may (should) hold the netdev, but I 
was wrong as you explained.

> 	Assuming that's correct, I think one way around that is to
> acquire a reference (via dev_hold or netdev_hold) to the interface
> (i.e., real_dev) within the minimal rcu_read_lock / rcu_read_unlock, do

That's what I did, trying to reduce critical section, unlock immediately 
after get real_dev.

> the xfrm magic, and then release the reference when finished.  That
> won't prevent the interface from being removed from the bond and the
> struct slave being freed outside of the RCU critical section, so the
> code would also need to use only real_dev after rcu_read_unlock() is
> called.
> 

I think it's good solution.
So I need to add the dev_hold/dev_put as following, for example, for 
bond_ipsec_del_sa, right?

@@ -526,6 +534,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
         bond = netdev_priv(bond_dev);
         slave = rcu_dereference(bond->curr_active_slave);
         real_dev = slave ? slave->dev : NULL;
+       dev_hold(real_dev);
         rcu_read_unlock();

         if (!slave)
@@ -545,6 +554,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)

         real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
  out:
+       dev_put(real_dev);
         mutex_lock(&bond->ipsec_lock);
         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
                 if (ipsec->xs == xs) {

If you are ok with that, I will add the same for 
bond_ipsec_add_sa/bond_ipsec_free_sa, and send new version.

Please confirm.

Thanks!
Jianbo


> 	-J
> 
>> Thanks!
>> Jianbo
>>
>>>          -J
>>>          
>>>>
>>>>          if (!slave)
>>>>                  goto out;
>>>> @@ -537,7 +534,6 @@ static void bond_ipsec_del_sa(struct xfrm_state
>>>> *xs)
>>>>          if (!xs->xso.real_dev)
>>>>                  goto out;
>>>>
>>>> -       real_dev = slave->dev;
>>>>          WARN_ON(xs->xso.real_dev != real_dev);
>>>>
>>>>          if (!real_dev->xfrmdev_ops ||
>>>> @@ -549,7 +545,7 @@ static void bond_ipsec_del_sa(struct xfrm_state
>>>> *xs)
>>>>
>>>>          real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>>> out:
>>>> -       spin_lock_bh(&bond->ipsec_lock);
>>>> +       mutex_lock(&bond->ipsec_lock);
>>>>          list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>>                  if (ipsec->xs == xs) {
>>>>                          list_del(&ipsec->list);
>>>> @@ -557,8 +553,7 @@ static void bond_ipsec_del_sa(struct xfrm_state
>>>> *xs)
>>>>                          break;
>>>>                  }
>>>>          }
>>>> -       spin_unlock_bh(&bond->ipsec_lock);
>>>> -       rcu_read_unlock();
>>>> +       mutex_unlock(&bond->ipsec_lock);
>>>> }
>>>>
>>>> static void bond_ipsec_del_sa_all(struct bonding *bond)
>>>> @@ -568,15 +563,12 @@ static void bond_ipsec_del_sa_all(struct
>>>> bonding *bond)
>>>>          struct bond_ipsec *ipsec;
>>>>          struct slave *slave;
>>>>
>>>> -       rcu_read_lock();
>>>> -       slave = rcu_dereference(bond->curr_active_slave);
>>>> -       if (!slave) {
>>>> -               rcu_read_unlock();
>>>> +       slave = rtnl_dereference(bond->curr_active_slave);
>>>> +       real_dev = slave ? slave->dev : NULL;
>>>> +       if (!real_dev)
>>>>                  return;
>>>> -       }
>>>>
>>>> -       real_dev = slave->dev;
>>>> -       spin_lock_bh(&bond->ipsec_lock);
>>>> +       mutex_lock(&bond->ipsec_lock);
>>>>          list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>>                  if (!ipsec->xs->xso.real_dev)
>>>>                          continue;
>>>> @@ -593,8 +585,7 @@ static void bond_ipsec_del_sa_all(struct
>>>> bonding *bond)
>>>>                                  real_dev->xfrmdev_ops-
>>>>> xdo_dev_state_free(ipsec->xs);
>>>>                  }
>>>>          }
>>>> -       spin_unlock_bh(&bond->ipsec_lock);
>>>> -       rcu_read_unlock();
>>>> +       mutex_unlock(&bond->ipsec_lock);
>>>> }
>>>>
>>>> static void bond_ipsec_free_sa(struct xfrm_state *xs)
>>>> @@ -5917,7 +5908,7 @@ void bond_setup(struct net_device *bond_dev)
>>>>          /* set up xfrm device ops (only supported in active-backup
>>>> right now) */
>>>>          bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
>>>>          INIT_LIST_HEAD(&bond->ipsec_list);
>>>> -       spin_lock_init(&bond->ipsec_lock);
>>>> +       mutex_init(&bond->ipsec_lock);
>>>> #endif /* CONFIG_XFRM_OFFLOAD */
>>>>
>>>>          /* don't acquire bond device's netif_tx_lock when
>>>> transmitting */
>>>> @@ -5966,6 +5957,10 @@ static void bond_uninit(struct net_device
>>>> *bond_dev)
>>>>                  __bond_release_one(bond_dev, slave->dev, true,
>>>> true);
>>>>          netdev_info(bond_dev, "Released all slaves\n");
>>>>
>>>> +#ifdef CONFIG_XFRM_OFFLOAD
>>>> +       mutex_destroy(&bond->ipsec_lock);
>>>> +#endif /* CONFIG_XFRM_OFFLOAD */
>>>> +
>>>>          bond_set_slave_arr(bond, NULL, NULL);
>>>>
>>>>          list_del_rcu(&bond->bond_list);
>>>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>>>> index b61fb1aa3a56..8bb5f016969f 100644
>>>> --- a/include/net/bonding.h
>>>> +++ b/include/net/bonding.h
>>>> @@ -260,7 +260,7 @@ struct bonding {
>>>> #ifdef CONFIG_XFRM_OFFLOAD
>>>>          struct list_head ipsec_list;
>>>>          /* protecting ipsec_list */
>>>> -       spinlock_t ipsec_lock;
>>>> +       struct mutex ipsec_lock;
>>>> #endif /* CONFIG_XFRM_OFFLOAD */
>>>>          struct bpf_prog *xdp_prog;
>>>> };
>>>> -- 
>>>> 2.21.0
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net


