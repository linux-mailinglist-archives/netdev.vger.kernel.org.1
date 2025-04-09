Return-Path: <netdev+bounces-180894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33014A82D7A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B3788802B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0226FA6E;
	Wed,  9 Apr 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tg3wdQY4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6B1BD9C1;
	Wed,  9 Apr 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219097; cv=fail; b=OKXwtNIGOYtC+9pD4VpxfhSG6LAY2mHyMv1ASGHYyjufK+RwRMbuANsNEepfD6XVCMV/ZZJzUZBnunVzRW6Zhvdr717+vCCooG4KgTOoJLeOC7PU8VurtthCo2knGTByT6jcXBUiZ7h7uGL8wTzrmB2mJ3SVhL012TfNRvjdVk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219097; c=relaxed/simple;
	bh=ipWU1OlEaMnOEm6XIiXP6S/dqJKa54qhy3OhTEGmQTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T2UxayOGJ8lyeFo1MLYl4/1e5nX6H+UF8wmiNk0NcG1d5zJf9TnkdoZiwubOFknQ/LLSaegfMxd1BiBm9lnTtb2uvgcaHyJv6jGHQf4FmPH5GrShdHmd3iCUqZyKcdGpIGlEFFT8M+tWMnrZfu58aaP8sZ804FG38i2fQ0BVONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tg3wdQY4; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsXsNJOQjhCzg/60XuDW5h6GQhLww9Pfkl5/xMjxOqm7epMdw2r98CC+yR8EuChTohRvB7EVN2VKmCH5froCJRc4rCjQ3yPJQfZ4P5s4ne7qwI+ZpDvFjNRAo/RdSjSExcih1tKd3OUIoyP3eYxQuRArSc1V0zQUMvet+FqoLI5M3Oe79NjhBpXwqo4Yd2q0ixvaZ8dq2D38WZX3lWBxOpqthCiAwLcJB1HciTWa1ITpQgaVAgSwXDAKQh81MN/2VzLF6d86JL00JTvQIzjfocVmcVSgIg2QsWmWOADIYDGEunSjj1Orl+gN4GDWZpPglRrDXtjm9hATbh7CCBw+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKUKEc+xnMEiLM5chHbUUym4YOkg4jYFla0Hxma/nh8=;
 b=QMURe2NmH72EBOcY6Oh5UotBlOg34J7lJ1nwzpJwCPano0D4YWgwcTbfgnIyzdP/+Z4bppL6EEof1AfxQUVUbdLGoxaUdOlO803kUMaNigCBuHyH5KmZHhZKwg71ucxRZYRhSamsgYdllkGVu2LhJis2wZQ5dQm1CixP5u0Xdod/8Lm3i9qG/nJywIRhaZNnl+01im9n+rL43Q15+4S/U38AjXLI51UXDG5Kr4PbJPax7ctEGCPRErCnTF7bzK+cjcSJhqOhRSV8q8DB6vBGtVHcrg+7sgUvuhmN6S143PXJzWvR9NMZKYTU8UIqtUR/fbC4Hok/80zrJGk+3xQzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKUKEc+xnMEiLM5chHbUUym4YOkg4jYFla0Hxma/nh8=;
 b=Tg3wdQY4y/UHRQgp/Z44cXSgL3ewfkFO4mfuSF+19KDYD9orl25avazW9kV8DLMD5z/0xlndrmq0h+Q4SJIwZ0b3pGRBqLNYKJ03vI6xgKp1pjlkaxZhC0dA1XkpVnvh+/bCaB3qtofb6rPYzYghPLYz4Cgy1Hab0WQAVRI/SCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 17:18:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 17:18:12 +0000
Message-ID: <a59eac7c-870b-4edf-9590-5aef07a64d7b@amd.com>
Date: Wed, 9 Apr 2025 10:18:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] pds_core: fix memory leak in
 pdsc_debugfs_add_qcq()
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409054450.48606-1-abdun.nihaal@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250409054450.48606-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:610:57::32) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 700679cf-a433-436d-fc7e-08dd778a81cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmtMSXZuZ2kxc0NoQ2dNcXpWK0JXS2czdjVxYXJiM1oxdWtWQjdUbHQybnYx?=
 =?utf-8?B?UlY4TTQ1RHlubUZNYjJQazFEQkZCaEpqSXFZRmVjTTZucjhLMTNPZzFYMWJC?=
 =?utf-8?B?aFYrNVE3UngrK1RaNmw4dzc4RG5iZE5zSFgyOTBBelhRZmJQSm9SN1pHbTJw?=
 =?utf-8?B?SkJWaGZJdHlzamtvbEQvV0d5dlNDTFVrVGRTSU5wdUdCemJTbUw0RkEwU3A3?=
 =?utf-8?B?Vi85ZkdKNUZvK3RnSmxaUllJNjNFNlhEV0lWR2swek44QWJHTnNJQy95K2hr?=
 =?utf-8?B?RE4xK0IyNEU3YzErVElEWU1ETHJJWlJKWnYrTzlOSEVhdGdYS0puT3F3NTgz?=
 =?utf-8?B?N0RZd0g1MUdNZEVLSlk1UXkzMitFTHdEN09xa1BCTkpUZFZacjNGVFNFbzdw?=
 =?utf-8?B?aU5kdEtyek9Zb0NGN3VPZlZwcnlBTzFVRG41cVNKZEU3SDljcURWODRRSzJR?=
 =?utf-8?B?eGlIeVRwLzgzaEF2T1E1S1hxOU0zMFJIb09jMnNJNzdBUEVqZkZYem16VndB?=
 =?utf-8?B?Rk1OU3l2SVU4RmpJUERmZTVEZE1ZY0VtNTg3MkEwMjl0YnBLTFZEUFFqWDFs?=
 =?utf-8?B?MDVZWWcxN3hnenNXenI4SWMzbmVwdVRVMkNhY3haMk9hbkZCRnMrVnpGeWh5?=
 =?utf-8?B?dVUrWVBKS3c0QnQ2dE05TS9QN2FTWlo1ZVdCcDJsRWFKaHNCL2prMVhlS0VB?=
 =?utf-8?B?RkJac0ZrVTR1Qi94dk0xZThRVmdxSmcvOHVWZ3FVd0pFZ3dNVDlvbHlNa3Jz?=
 =?utf-8?B?YlRiM1R0ek8yK1c5SGJCVUdLeXU3R1NlMHRLYlpFcGpqK1pTSWs4c2ZYQ1Vu?=
 =?utf-8?B?OGViS0JyRzJIbnYzZXdDYVBnSlRJNUs0ZHd0OHhMQUN2eUJ1MExidW1uclA4?=
 =?utf-8?B?UUdIRWJGenNvY296bjFhZlFwbk9NY2srMlc2OEorYUMvZlBxbVg3c05GZ3JF?=
 =?utf-8?B?YktSNkxjTis0UysydDZtb3haeitxTi9ESENjTXIyWWkxWE9WeEt5TXI0OXRy?=
 =?utf-8?B?Z1ZhYjRsNjBYRDQ5T0dsNTBDQzg5TVdBcXRQazM0UlFialp0ZmdQcW5rVGFQ?=
 =?utf-8?B?VDBycm5lV3lUdHhIU3o0aStsbEJiWlljcmduN3I3U2ZTek1sSW1GSjZtOHFU?=
 =?utf-8?B?MXdHU0xDaTlwbVFiQTVOTndUdlR4cjZkT0h0U05PODBNR2hCQ1N3QVkvUzJJ?=
 =?utf-8?B?WFJvUjNoMkdpZEo0Mjl2Qis3THpBajBQSlJlUkpSSFF4YnJ2NFRXeHpBUDFY?=
 =?utf-8?B?MmY3VHVnbkZ2WEMxNEptZlArbWNqN01KN2lXWVpua0IxaU5sWVpBcUtqMHg2?=
 =?utf-8?B?ajlveEF5Z3Y0ZFBGbjdaZVIrUzhtK2lKWXlONkxLZHcrK1hzTUsrbTlnUWJw?=
 =?utf-8?B?Ym5QRlJoWFcyY3lpRW53MCtUVUJLK01oVW1vNkN3Z2FaWFhNYkJEdUVFTzZk?=
 =?utf-8?B?RDgxWmVlSnp6TVg5UTFhMzFYNVRnQVhOVTNnNDd3ODl6c2J1WFl0N2lraVdB?=
 =?utf-8?B?VTFOSGVIalJFei83aHR0RHhGdGVLSXhMdWlkMTFDeFhEMlZibjA3NWtXKzM3?=
 =?utf-8?B?dXd4OUdGOU8rRG04d3RuNlY3UGFWV0g3WFNTbEFYcGRucHNjZWpIa01TM3Vv?=
 =?utf-8?B?SzdQZzBXc09HLzlJVExYQW5uMVF2c05qbm92dkZDbzZtWU9jZE1CVk5SWXJj?=
 =?utf-8?B?NVZoanFCc3d1TkZqeUp1UStRWDU2UjBnN3g1QmxzVHh4OGdvb3ZITU1lNTFF?=
 =?utf-8?B?cXJlNytIMzFQb0xQMU5Ld0c4QWtoSFkyRUJ6Qm5UYXZEZlV5YWlQQ1JBTUZY?=
 =?utf-8?B?Nkx5Z21TUVU5V2llcEtyTUtBckJBcWVkZ0FDQ09uSXpJenBTeHJZQ1FNK2pZ?=
 =?utf-8?B?U3BwRlVFaC95WSs3ZWlOU3Q3YVoxRWRCV0NKODZJWmMyWjRhWUd2RFU1eEt5?=
 =?utf-8?Q?W8WFnvwFXhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnpkRFI1Z1BxbHZhOWZ2SkFUK2VzaTdvNGdXaStPYlJOWjlBNFE3a3BJZjB6?=
 =?utf-8?B?YVpNL2lBaGU0RmFRYXFhcE8yZElFYW5pL0hqWTFIckJOWkxKdTljWGM5azN1?=
 =?utf-8?B?QTdmMnFhREpTeEUwdVlUWXViNThSMmxDakdUODU4Sy9PK3lhTm1BYlgzaFM0?=
 =?utf-8?B?NGsra2hVK1hGSGxMMTIvSTByQkpGd3Fyd2Exa3RDbElyUlJyNWh0M0FRdmxq?=
 =?utf-8?B?RThBR2FVZHU5K25jWnJqM0Vma3ZOVVN6eGIwU3BnMHBYNDFQdm9BejViMStX?=
 =?utf-8?B?UDJIb05HdzJmaTFqLzJkekxudzhQcmpGRTNPYWdFajM0ZlBYUG81VGh0NzM3?=
 =?utf-8?B?Sk1NT2FQZE82U1huQldMTG1aYnZrbWd0eGMzVHJVQU5rWGxCelFnMnhCN2Vm?=
 =?utf-8?B?akJLd3hPMFVmcFpQK2lMeDlQVzJ4TTBmY3dyRWJEQ1d6MXMrSjBIQXM0UDFH?=
 =?utf-8?B?RWhrbWZHdE54YzEzaWZrRmk0NTB5eS8xeUtpL0JmTG50UTJOUkNZOFFZTzNG?=
 =?utf-8?B?YStyWWR5elRhOXRidXBBT2dIQnRtZytEd3o0YjgwM0s2TlZtSjNkYlpFZ0xD?=
 =?utf-8?B?SWFtdVJCSGRoV2IvV3VOSjRSeWZucHNyZ0JOUmpQZmxsby82cWNFRTl3YVlp?=
 =?utf-8?B?UGpIT3g0aTBUd2xIa3dhdkdOY25MeWtXVERNM3VlVzVFbmJQYmVZRWh2VnN5?=
 =?utf-8?B?TWlhU0tLaGhxVU9tKzNlOVpYMVA1blp0cVlOcW5aNkZRUTNuT2RRa0FQR2xX?=
 =?utf-8?B?azdheG9JdnpKT1ZRS1Y3eVduS1JwSGUvUzZBTGxuMGRaYkxrcDNjZTQ2cGpp?=
 =?utf-8?B?SUU4UVc4a2pzQmErbnBaUmFGUEllSWdlM3dYazYxWlV0bWpLc1VjWjVnTHNJ?=
 =?utf-8?B?VWJHdlJoaUtXeEg0anpEZ3hlSHM1dFA4MmpnMWNSSXlWVm1uM3AvN0hHaElS?=
 =?utf-8?B?eGN4aldndzVWaHNWTTlCTzNyaXBGTGl5R2F3cGxkQzFJYVFXWVE1TW05ZzZU?=
 =?utf-8?B?cjFXVnFVVzJ1THJoVzVPcStrZWlzWXVTZnlKTFNaZ0lYdkVmbGh0Y0s0UHUr?=
 =?utf-8?B?eDQrZm9WYkx5RjV6SjF0dWlqVm5VNERFOFphR091VXZPV0o1MForT1pBVVFR?=
 =?utf-8?B?R2NBbWIvMTg4YTlRTnFtQ093VGdKbHVyU2JXVlF6djRwQUQrKzdScjhVNVZH?=
 =?utf-8?B?b24xcW5QMC9tNUFzZndhREtSODg3OFJtdmRvZ2VmYnhDS1FxMEw3TGRJK0dX?=
 =?utf-8?B?RUpEQnhMUi80bURCS2ZIaEY1dTdQSXpweFBOalZzQmpsSzI2K2VOZUVzaVhj?=
 =?utf-8?B?aFQrM2Zublp2bkNkdFhyeGcxMzJXYjhqRUdVUzF0bnRubklyUDUzSUdOVjRp?=
 =?utf-8?B?U3NKclFWTlQ3aFR5ekc3bWh1dThHZkM2OTZGbGtJMGE3QlJHRGR2angzTFpY?=
 =?utf-8?B?RGlla25WQUFuQ3crdGgxQTIvNlU0Zm1kWmdJZFFWQlh6dlpLalY5dXNkZ1V1?=
 =?utf-8?B?RFV3VVRJSTFaRE1xN3pNQ3FydzRBamkyYzRaMjc1cFM5YTlUTHZNcUpEQlNV?=
 =?utf-8?B?N2oyMWlST0tUTkVuaFVjaS8vajd2VEk5VUJDZzdXN1VLWGpia2pHSFh2b0px?=
 =?utf-8?B?cVBURko1OXZMZkpsMVN6RWsrd2ZVbDhQeld5b25IQXZwNXZCRDMxUmdqZjlp?=
 =?utf-8?B?dWlKSkozZWRzck9RZFpJdytPSDV4L0xvb0N3Q1BSRGFVTnl3aUV0eTM4MC96?=
 =?utf-8?B?YW5Fc1l4T1JiTlR5WnJ5R3VNYTNVcmgzd2dnQmMweXRiR3M0SnlJNFZDWGRU?=
 =?utf-8?B?Z2M4NjRtaE9YZHBIOGVlajkxODJ5K2Q3cnI4Nit1Yy9JNnc1Ymp6NDB1MUt0?=
 =?utf-8?B?ZWgvK2JCRURjZWF1a2hOeEwyLytGM1RrcVhHTzdiOGZQNk1JVkhTOUIrclJV?=
 =?utf-8?B?NEd1bzBKazl1OUw3WUZFcVhGTUFsaFQ1Rkt3OTRWNE9jM2I2dzkwWGVsZGxu?=
 =?utf-8?B?WDd3cUNiNjluUzBreXRvRU5DdW1vRjNvRkttVlkxTGFZWktSTzl4R1lPdGZD?=
 =?utf-8?B?VHBhcWk0R1hyQzdmcXEyd1N6Y2E5UkU1bmZEZ0trT0hYeUlia2JkczYvL2M0?=
 =?utf-8?Q?0tG2CQI87jazU8eJre6wbQulU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700679cf-a433-436d-fc7e-08dd778a81cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 17:18:12.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/TKsueFyA6DGJ7VLeZNoW8tMWH7maBGUv8MetniCPXORk40MXMLBYAUh+mer08kkncrT1LaPHgRgBHlQQyBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

On 4/8/2025 10:44 PM, Abdun Nihaal wrote:
> 
> The memory allocated for intr_ctrl_regset, which is passed to
> debugfs_create_regset32() may not be cleaned up when the driver is
> removed. Fix that by using device managed allocation for it.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>

Thanks!

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/amd/pds_core/debugfs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
> index ac37a4e738ae..04c5e3abd8d7 100644
> --- a/drivers/net/ethernet/amd/pds_core/debugfs.c
> +++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
> @@ -154,8 +154,9 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>                  debugfs_create_u32("index", 0400, intr_dentry, &intr->index);
>                  debugfs_create_u32("vector", 0400, intr_dentry, &intr->vector);
> 
> -               intr_ctrl_regset = kzalloc(sizeof(*intr_ctrl_regset),
> -                                          GFP_KERNEL);
> +               intr_ctrl_regset = devm_kzalloc(pdsc->dev,
> +                                               sizeof(*intr_ctrl_regset),
> +                                               GFP_KERNEL);
>                  if (!intr_ctrl_regset)
>                          return;
>                  intr_ctrl_regset->regs = intr_ctrl_regs;
> --
> 2.47.2
> 


