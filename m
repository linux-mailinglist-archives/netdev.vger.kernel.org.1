Return-Path: <netdev+bounces-131696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C501A98F4A8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BAE1F2275C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36D1A7046;
	Thu,  3 Oct 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jSp7uJUa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEF4437A;
	Thu,  3 Oct 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974654; cv=fail; b=rC4bl+pQ8vXAlFOuE0q4ekS5tlbmzr6UJpf9LBMbVH4O0ZHbtx45NEh2M+Ok3WWZ3kZ2Q8Q/2d/4hGIHHfOPUeEKEWQm/ltqLS93vIAFTHxx8MsGw6jA+oQ7gtDzcQUfg8kSJZ4/gQCnjpWIaZz68UMjqFu/LjqBvCKUuR7YZKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974654; c=relaxed/simple;
	bh=Bk9WU5dx58k4jWFPNKoaOj0pvXV7P7Niz+K+LbQ8eOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EiPfb1HpuPucOvRNHyTM3bQzAb6fl3rQbplLpCXJFE8Mnbw4J2Yll8rAbKvHjdzmhTRTq8xm6eTQt/uHFOjujlaCMwvN2MGUv6sv9PAVo/rTdA/y1Qem8RHzogIrRbd3JgFiXYfJaWkVmWitC5Ku3ITv/mrYmzGv9D486FU17/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jSp7uJUa; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4oHaQK7vnwLufEvY9XrJbApmOy0+FSA0h1YqIdOgaLvdOchii3/IPJvYtuIwhhTXi5GS/leCXXvLZNB/wlmk47v9xzT/y5KExb41ZBUWunVzR4dzcBqQ9XAnCzOiVEk/Bwl1NpB0d/6A7by2xu/P8aAgf15obOkwm4yTIb7C4jhpkLdeAp6pODU0D2hApnDBZWDxGn+QUkVGRuv42lUG2XBcDqxynPGg42oMFUJG+HHfG1YrCHZV+g7ZCvS7AhQ1uXe5gBq7cdQsib1kLp0sP96K+hHVpG9qcR6dSheU9SzI4PO6MXZ3i2lp/k0A74QCtGO00CXTgLo0Rne4WSa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egCsVUIY+zVsBeM7uwe3U9UlcazbTm1UTrqQbdBrcOg=;
 b=y0pCmjaB0k1i5cIUrTTJ4FuJu25/8nqgP1Nx4EV9g2CigopxrG5L8Zo6s5dvtld86zhhbWlbJvRyKW1F7Myj59mAb4Bgye5TMOr3XzgAi1lP4wWoWHrQpkSyageGG9tMVMDsOYnXya6kauB0xV/Fhc5TgRdTEiQVEMcq7pJo6xTfNsyOzQcvedwIx6lKsSRFg+yribAr7nCyAj591O56WE47uFrMEsND3sDE9bB9vXdTRg12QpVmunQROJW3BysAkuZ3/pLXv52Q643uo3pn/saobPFoJXdLIoHFzCWrsPNsphq1g0jM53JSpnaOcnZD9r1SZNJ7thXW2maLS6i1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egCsVUIY+zVsBeM7uwe3U9UlcazbTm1UTrqQbdBrcOg=;
 b=jSp7uJUaJNeB3WViLOFhv+PXmLhSzy6K4ETtWjDeHC6CPAQ6/08wK7dtMX1R0Abo5GpYcIVW9jpdiq2r1tIYwD7wDUJ21oftt29U2NNeT5GTshYdGiAlvGPm5kKj7wAOqoANOmGYk00yvn+dQE9/SpfCveqmvqiMRQkbwVFPpXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:57:29 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 16:57:28 +0000
Message-ID: <bf51b344-bc52-4383-9218-aab9f5f89c82@amd.com>
Date: Thu, 3 Oct 2024 09:57:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, almasrymina@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-2-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20241003160620.1521626-2-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c95901-e3f9-4d83-4678-08dce3cc76df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBsQm9MOUdVQTlGZ042eXhET0dHMUMvbGZwRTNKRjlKSmVjTE8wdkJwUTk2?=
 =?utf-8?B?N2R1K012VlhDRlJtRnNQTDRlelEzWjB6WnJpajlxZ0I1N0RLcHZhdlcrV3VN?=
 =?utf-8?B?elFQU251eFRFOC80amFKc2ZjdGowaWlJa2xHT0pYWW5sYTYrZmF3ZXR4MFdP?=
 =?utf-8?B?YVgxQmpKRmg3SDhDclhpbUJmSHdTcWFXMzlZTkw4aWt3SnVEVDA4QVhzVnVy?=
 =?utf-8?B?a2s1c2xyTGNFdE1QUVBrTml0REZGU3FiNUx1eVE0TjFrTGs2REU1VjVlRkxH?=
 =?utf-8?B?T1luaEdrcHdUenZYcWpMZThiQUU2ckdmcGxTSnBnTG1aZXRkNzRMeGNmUllW?=
 =?utf-8?B?YjhqOWszRmhhMm11WWoxNGQ5eE9jc0VWUXEySTRPbXdxR1ZlUjc0Wm5FTXJI?=
 =?utf-8?B?QkRGVUQzM2VPZDFUbzVOZnA5cXJKL2ZVTTB1bXoxeUVaOE9ya0xUTjkzMTZ1?=
 =?utf-8?B?MklrRWVqRUFncEw2azEyNC9RY01VbXovQndWMTVKSjQ4OTJjWFdLK0c5UG40?=
 =?utf-8?B?dnV6NnB2YytnSC9LanJYN2trM2hrc29LUG9mWkk2cWZDVDNCS3AyUkw3bWxX?=
 =?utf-8?B?RG0rWE13TnBnT0ZKSmwzOXJCdzBqeERaaVo0NVVlREJxMHgwRUFBdW83WnY4?=
 =?utf-8?B?RGt1TVlKZzkwOU0yeURCMkc0NStUVCtUZW0zV1ErOXJoclR6Yk9YQk5QRGxz?=
 =?utf-8?B?Zi8xTkdHUHRqTkNrU0tETTdWQ0N4UWdoWHRITDVIVG1OL3g0QlBXeGhuMGhW?=
 =?utf-8?B?cDdXeUI3Z2hGWFF5b05peGFhWVZCN2UzeTEweGtDUXNwTmU5ckQvRWhlaGZS?=
 =?utf-8?B?MGJwVUhSL0NIQU5HTWJFTjZYY3pZT0ZWdkdLSWRUM0xMc2d6ZnVEd2lBUmxM?=
 =?utf-8?B?SXN0WEdkMHIxQjRHblIrWEpsZnR6TE1GWHhDL3lOUTI0bERWeUc5cFZleXZW?=
 =?utf-8?B?QzZCaURHYjZpZmhDSWZmcWxDOHMxQ0IxM2JicjA2TkJJenlhTWRCdzlFcDFy?=
 =?utf-8?B?UUo5a0c4MkdzUXZQeWltaEJNK2grTSt1UVpONHJiTnptMUJBa1pZcHc5dWpj?=
 =?utf-8?B?VXFaMUVBRGI5YnE1VVExZWxIdVZTY0V5dXRxUkRQRS9mMTlpbGFDS2g5Y0J5?=
 =?utf-8?B?bTFnOENvOXVwRlRoc2RkcnJ6SmNqV09IZHZlT3BuN1d2STdvdlZ5Q3Y0bWZr?=
 =?utf-8?B?VEV4OFpLLzFQejQ0d0xlK1hhVWdwd25rMTZaS0g0N0JyTUkwR3gyOVZnRDI5?=
 =?utf-8?B?SGFEcXJ0bUFDbTJmODIvWEJiWkQvVEp6c2NRc3dwc0NpbERUeFdsR0V3bk01?=
 =?utf-8?B?YU02QTJtWDJ0MHpJdzJYd1Uzc0xqaVFsMjJHOTYvUTFZOE1TVVZoUnhQNnJz?=
 =?utf-8?B?anVCMkptNmpsQVVVd1g2eHRWWWdVTkFxS1VXd3duNUJaZ1A1dC9xMWtja0Jv?=
 =?utf-8?B?VUVaUWovbUtBeno5aDZpYVdMS2JYcXF2aERZZ0VJbVRCbWZ1dXdnNG5DdjdN?=
 =?utf-8?B?NUd3aW9vbkdlanM1UGYweWhHNWZEZng4VHhJWW1hQjdpdGpneFN0bzgvUkJy?=
 =?utf-8?B?MEp3VGRPOHFYS0FIa0xnSFViL3FOcERKUmt4ck9iQ2gvVW40KzVzYURyYjZK?=
 =?utf-8?B?MkJNb2tRYVJRcVlObHN1SzJmdlVyaExCK0o1OWgvd0dRUEhsczlBMDdpZ0w3?=
 =?utf-8?B?U2tCY0hORzA3NU1uNVEyZ2JNajdSVDlLcEN2aFpwM2JoQ0cvNzJ6dzJLVjlZ?=
 =?utf-8?Q?p3HY+NLOKY5ypp8ktOSIRrKZ8bFrwognXJSnLCe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUd4bGg4RFlBWks1V2w5WFJ6NXdhcUpYWlI3R2l0aEVuZTFQSS95ZWd0aVcx?=
 =?utf-8?B?cWdGZ0hrVmM3M2FQcnpISmErOS9qcy9naldHa3Y1aUlUQkd0ZVZtR1dpaStq?=
 =?utf-8?B?QVNZQU1UYm9jMW9XTEJRd0JqRTdEWTdOZkc3LzYwZDUrbUthbm1kREhScjJN?=
 =?utf-8?B?RUt4dEhDajRZVFhkM1hOUGlZQVpXK3FORzNuVlgweC85d3Erc2QwSVpvWENn?=
 =?utf-8?B?eFpIYzVVZDc1Q0tQcWRibTlSL2YzWnhkQUEreWZQeS8yaDJRRUJiaTJNd1c2?=
 =?utf-8?B?ZEpaVUYzaUg3aUZSYU51dFlmR0Z6MC96b05RR1RxSGdHbWFqQXJ2TERSUkJ2?=
 =?utf-8?B?ZmdHeUlkTy9QQVFTSWUrSzFtT0RDc1luRjlJYm5TRytoZzE3UDdkTEg1THdZ?=
 =?utf-8?B?YVZCV1ZDUGJLVFRodUxONTAvcWNSdnYzekRZTmFCSE5yc05jZlhyTXdaQmJL?=
 =?utf-8?B?MFR4QVlmUTNDbzRkWlZCTzEweG9mbmlham5oN2ExMHNCR0tZbS9lWjNOM2Zv?=
 =?utf-8?B?a3lHNXRkTFUxb2NkMkozUWNLR3lhM21OcmwrOWN1MjQ5b0FIRmRDbG05dFFr?=
 =?utf-8?B?eU8yMmFkVWFlbGtOczJ0UzlidmhLZXFucVFjRWZ5T2FJUFlNeGNhN2QzRWxL?=
 =?utf-8?B?RzR5bklxYTNQei92KzZ2em0ycWNoOEtabmRzbmNydGlvaVpKdkpYZndQd3Ix?=
 =?utf-8?B?bHdNVDI5WnY4azIrckxISHBsYk03M0s0TUcxRVJzVytTZ0Z1aXJMQ1NrOHUx?=
 =?utf-8?B?YVI3Y3djYmRyMkIyV1cwaXluN2h1d0grOUtxQTQ5SkRoOUJPS3NXcnVyc0cx?=
 =?utf-8?B?UG05c1VTRzh0c01OVjFzTzZUdy9qYXNSd0d5MDJqNVVMYUVKVmQ2ejYra1FI?=
 =?utf-8?B?K1JTcjgvSWtaRVpwR0wwdzI0UmVSdGI4ejZraHhscHFhd0JXbEhKVHhUVkxr?=
 =?utf-8?B?em9rY0Nua2pnZm1YV3V6ODUrc0U5MUVMS0hqQTRMODk3bGFhU01TQU1uYnhm?=
 =?utf-8?B?U1lXUUVoQ09QblhPemwwa1FSMnJOalJKb0F3L2UwVVpPZERlaWpHTnhINndV?=
 =?utf-8?B?dTJrenF5WkJVV0x6Tm9kTFptemlCdjFZWFJ5MHp1SmxtNDZKTXNZcXhuU1Z4?=
 =?utf-8?B?bUlWeW9OWURlTTFXL2xiVXJ3NGRsRjRzR3FwTW9hRzk2N3VFU3Bwdnp3eUdU?=
 =?utf-8?B?T2dUTExOZ0xYTDVNMm9SSkpjWWoraHpPT0t4Mm1RQi9jV3ppMnAwZ2hjeTFI?=
 =?utf-8?B?ZzE1eUV6ZlVBeWhGZkw3KzRvZVdNREJnenBmcHcyeEwzRktKRTRoM1l2aTJG?=
 =?utf-8?B?ZFhxTFdDaDhqTjB1VjVzNTkyK1Jzakp0SVhhekcyWFhEdWFUaFFLWktac3du?=
 =?utf-8?B?N281eGE0WGVLa2tmeitTQ1B0N1FtZ0wwZ2lXSnl1Vk9uUU9BWnZzMjc5cW9z?=
 =?utf-8?B?U2srd2RUbEJ3enI4aWU4MDFkY01ramljODNBQnhWSS8wTXI4TFlERlBzNWtV?=
 =?utf-8?B?eERFams3TU5zTWVTeDZqZ2FUQmZPek50OVo0ZFJMRElKeHZ6aVpBSi9qeHla?=
 =?utf-8?B?WnQvcFRRQ21lQ3pFandpS05QeWhxbWRjNVc3Mko2czRkQmg1QW5wV2dQaGJo?=
 =?utf-8?B?eWJ3NGIreXNySVRBOTlrVUpLaVZhQU80L1I3WDMzVytWU2dPS1E1RFJaVENZ?=
 =?utf-8?B?VlBvYVNRQkp2bjUwZzVLbkJMZ3R0Y2d5R3ptOUg1NkZxaDhWUmhPOEgxNU56?=
 =?utf-8?B?Q3NBdVNTZjNqVUh5RnBYd1VKQUkrOEF4MTlHV2k1WG1ZOGZpMm0vQnJlQkRU?=
 =?utf-8?B?NDlpS1hXdktMY0Z4R1dhSzJxcXcyMTQ3REdQZHFqb2RPaWY5SW8rZ0VtMlEr?=
 =?utf-8?B?TXJ5b3RIU1grc2Z4OWQxVnNhSkRuYjdja2pRZlM1ZlhQUVI4L1gxVzhFenkz?=
 =?utf-8?B?Z0hnOEU1dkt0YkZSOS9Sak5mcUh2WlpzWVNpSU9DWU9aZ3d2TEJMVUhLbUVo?=
 =?utf-8?B?YXd0WUlqVHdxUjJ4K1k5Nk0wZG1qT0kxY3J3OTRYWGRSSEhvVGp0ZjVVRDhz?=
 =?utf-8?B?YmxTTklCNEMxb05LNjF1ZDIvRnBSbGJVa2hLUVp2RlYwMVNPQUxzOTVyT0tr?=
 =?utf-8?Q?ZKHNocBI/ujNliBstoVEMV68H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c95901-e3f9-4d83-4678-08dce3cc76df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:57:28.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPskga7KMw7AmEN02RdAJUfYN5opitN4eJhBevvo36AFZC8r5+lXs8yLTHcYK1MCRi+2iq86QqvZ3eUrqlnfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v3:
>   - Update copybreak value before closing nic.

Nit, but maybe this should say:

Update copybreak value after closing nic and before opening nic when the 
device is running.

Definitely not worth a respin, but if you end up having to do a v4.

> 
> v2:
>   - Define max/vim rx_copybreak value.
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 +++++----
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++-
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++++-
>   3 files changed, 68 insertions(+), 11 deletions(-)

Other than the tiny nit, LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

<snip>

