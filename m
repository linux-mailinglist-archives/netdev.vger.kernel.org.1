Return-Path: <netdev+bounces-179657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E23A7E06F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE7F1747EC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E31B4140;
	Mon,  7 Apr 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LjfXU4dL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E12C6A3;
	Mon,  7 Apr 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034428; cv=fail; b=HD0ero1czc5VVufEW7R1NFCDMEeyQemMrdu7zc1spFcKdbrgwiAnmwyCQtx/egZUGgK3NRDgHoe+kKqDNlzds5/ArIau4EhcmtskCz7BLxXFFzqNAkhJY5KEpxVzPZDNV2Oc9z2gOfBjVp09Yj0qjqx4e/3SrxHqj1Xydrmsu58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034428; c=relaxed/simple;
	bh=pSpfr/B4yBgejd/oZY/cBzzZSMP1p0PaBgBm0Ou8+Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7LEmxdSrh5x4emrqF1iU0ZlQ9/KA4Gj4XtF7Qjd6VABSTicysNBPaNfOk9HjAr1tjWpLZVjDQ10Xgv3oO/X/+G49HR9GZQVWWv3LCS4L445tshQbaySccCSTe2XK8C/jYiJQmzMhYfJh5sdCIVKwUAN1N5GoF9LwImQ4Q6j3qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LjfXU4dL; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvbOGyhBaXKISaWcnfTnLGZDANGjAIykcgnw0rEY8hgHs4xVmFJIXNm3iSttISoePGKWdOjWZvfmSQ85tlPHzLARsoJI2NuJrNYhSryuszWruFEWqFgFnxVjrOYmEn8zoAp5JHs1d41fCzAdAAJajVuNuV8CX/GVA6ag3S7ZfuG4nQczdlX54mH6LBoOfTT0L+se1sk/2XiHTyHIQs0uX3gdAXAyaCRhmvZDbN/sGcef37wDgK9ilC+5Rhzd4sbm7o5UYytgGByurN2xqDDf+nRAS88DTl1aOIoXQQhEzBI6keVrWPHf+K3iPE8CnAIomnGgwWKOeSLs+oJfJrSzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx9v8tO7WmlBtdCtRODZf/uBbotDn8b7LApa4h/RpRM=;
 b=DlR5movYOipJexaymdJnUQ5ruqBF/bdZXjdn3fVpxmBkdKXD5FAAKXoIW0mrjVG0CsPUbdtSDhfRgg/v2pu84ru+nyDtAdOAPnMDLR9WevhvlSX49eO63IyLNcGkUtW0wQm0z1jaa6Duov4cLkDoun5ls0Qg9Da+YhT2xRp/jgxH2TOLB6dm/TnZrho3hfLLFKRPSZFMQv/c+myH7o9xrnT9zNc9RU6UdWyS/m/+Ow1PfC1z5txdSmJNSffeUmG7QYNtwWRvSdU/u38xwgRsv0vCQFy25FOkKdtY6aZzPlz3w+XwDJT41cSrsX7JyZZkUJFbrCamAGaCZB1gnTz6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx9v8tO7WmlBtdCtRODZf/uBbotDn8b7LApa4h/RpRM=;
 b=LjfXU4dLTkQrthxiTDniZnIy8un+Esf3UpPTBCq0WIXfS5QiAUJKOpWeoea6NBD3oC/cTnFPMYURQchcMUMP2M0wNKXeHX15VkyM3Hsi0NAfSoUHW/s8nRrR7GSLrtE2LKpnrg/DcjfIZ79eVzt4K3u9vu0wrVlwoaZgEhkkWqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 14:00:23 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 14:00:22 +0000
Message-ID: <66b44f23-cd12-4b8f-8fea-e5bffd8585b1@amd.com>
Date: Mon, 7 Apr 2025 15:00:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/23] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-6-alejandro.lucero-palau@amd.com>
 <20250331183350.GF185681@horms.kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250331183350.GF185681@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be57225-14e5-4797-2ed9-08dd75dc8985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE9HeGUySk9UdmtLa0hLb1dQUEdZckpjWHgxRjcrcUhzQ2NqOG9ic2tuOVM4?=
 =?utf-8?B?ZjhMNzRqSC96QThpdlU1c1lXZFJIRHVRL2dGdWQrRlpHMVV0Zk5sb3l1UGJn?=
 =?utf-8?B?K3owNGlaYWc3WnJQOW5MOGRDREd2bnNkTGdBc3ovVDN5QUV2UWxub2xxQXV5?=
 =?utf-8?B?WEFBU1lTRFdxUkxOd2syUzZ6TWwwQUsxUHRoeFptNTY0d0xLa0tMTUhJS0Nt?=
 =?utf-8?B?bERhK3k1Y0tNVjZ4VTFWMkQzTUs0N1JMQ1MwSnA2Q2dac0gyVis0WnIrTFV6?=
 =?utf-8?B?QmwyZitNWW1tRk9aVUVETFBrOWZURTVZNGF0MW1oaHd5K1VibVRmR0dxZkJz?=
 =?utf-8?B?UzRXOHI0VldnYW16OW14YXZOSHdXMGltdG5ObjZjekE2S0RCZHl2RnhlRGVt?=
 =?utf-8?B?YzBOMzdKSkVCOVZ4emkvekpJSURaYWJFVExNenFIZU1WNDluK0sxUXVabzJS?=
 =?utf-8?B?Tk1KRUFMMXFaRXRJcXJNMlBJMmZrNlNhR0NxaGpFbzllek1SMm9qTzVkY0No?=
 =?utf-8?B?TFNqL0N2WDVjRXFQVDFFY3pId1lhRnlQa0RCSlpaSEc4akhFSUpyYytjNzgw?=
 =?utf-8?B?YUZzaW1ObkNWQTlTY1dPQytlVlhsTVg4dHJQSCtiMGEyMENvaDNGZGhYbklK?=
 =?utf-8?B?R2JjdG5pakNMSkRKOTBQRmZYSmVBWUZhMWpvUXRPdlVBZkRtWTFaeFYvRnEr?=
 =?utf-8?B?L3UyT1hxb0hnRHVNMUZ0S2VHeElUZkFFYXJxTlF1MVQ1MkdsdEdoLytKSGsv?=
 =?utf-8?B?cjYrRjBiQUFDTzV1Z1dMSGdjemRmaEdLdk44WDZPUEd1elpxcXdLckhzSFpW?=
 =?utf-8?B?QWtrVDl1WnVaeUl4dHRPUFFoZlhOUlp4QWNGWDFVY2xZYWlUTmlvMnVvU21G?=
 =?utf-8?B?eVZyaDdWOWJSY3V5TXk0aWY3Q3ZMbk11QnZVaWE5NElCbVIrVExpM1pUL0ta?=
 =?utf-8?B?b3hDZExTTEtuNkVMdHBTNjJDQ1VwN1VyUmw0N2lsYnNlQzY2eGsyMnRYcTJv?=
 =?utf-8?B?WCtuUmt6ZjU4S3dnVFZXbDFmU2pEallGQ1NwdUFsSi9uTFQ4RWNNOHpJZG82?=
 =?utf-8?B?OHF3Vi9pZUsxWGFWYW9TSmRYZjZXWXAxdUNIaFlybDI0b1VldnpSTnE2VzM4?=
 =?utf-8?B?cWxHc01TKzBHMys1MTFnR0dqMTZuNjlyb21NVWVqeWpnQ2dmSmFFSWhCYnJw?=
 =?utf-8?B?UjRjaFRRZlBQbE9Jb3NuNEpKWkdGZGFVMlJxNUlKblNZMVBIZVNjWlJxQVlQ?=
 =?utf-8?B?LzJVR1hkWGFqUUkveXYzRFFISkVlTWhQQzBwamUvZmNtVzdNemEzVDU5L2Ez?=
 =?utf-8?B?T0NhY1pBN2Y3emFsbjRkUjIrbXhYWUFYWXFPNVQrWUo3S1dZS21ieTUrUklG?=
 =?utf-8?B?SjlRblRjWVN2dEhLZUthbk1abW50Q0V0RUVCdTA3OGZFLzkzSUlaRkVHMCtv?=
 =?utf-8?B?MGxzbzRBRE5HdnZud3pvRnBZTW4zc3lVQ0FYMTVWZ2R3ZG5RY21reXJTS3A4?=
 =?utf-8?B?cVFDQjFzL3EyQVZVUUh2Z3JkTTdOOEVnTFBWOCtCaEZyUjNVTmNUbWdFaUM3?=
 =?utf-8?B?TTRUMzB6bXBGdWczQnZmczhOZWV2QkxoV0dPVHY4K3VBYjhRQXFNZTRNYjlC?=
 =?utf-8?B?SkRZTXcvUlNVVk03ZlMxb0RtMjBJQ0hlcTU0cmt5SkM2NTMrUnlacFpWTVVV?=
 =?utf-8?B?ZmhJaGU1ZGt0TjNSakp6Wmt6dWFZZE5pRUJGeU4zazBsN1lGZGsyVUtnT0NH?=
 =?utf-8?B?T3RsbEMvVG9ITFVoN2tjZzVzbTVibXZZQW1lYkVkOHhuTjNpRW9CUGlPT3dj?=
 =?utf-8?B?c3UvdlNNU0pCSHVlaEpoZStIaFNSQ0dtZllnQ1hJTFEyS0xjSEF0SE5IaXdu?=
 =?utf-8?Q?vMZsjXKy5K3gN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3R1UWRLVEI3K1dtVHUyWTlYVHloeTZuby9sY0RzMEFBOE5TU3FJVncreTJq?=
 =?utf-8?B?YkZNcjdtRXlOYlNicC9EbDBnc29OUW00cFdhL0NldkZNU1dIc2FEM3NZZ0VC?=
 =?utf-8?B?K0dqT3JtMlBUSFloV243NE40dE9pclI2M3FVVytxTW1SLzNLa3pmbCtVVERm?=
 =?utf-8?B?TGx0eFlRYmpSY2pFVjlha2Vwci9rUjdJVEt6UHVQWVRVUXlBaU1JdlVBREpZ?=
 =?utf-8?B?aXZJWlJSUVYrYXF1Q1MzUldFeFJpS0pSMnRqa1BhUjJ3SGtyeXYwTzBqQkpw?=
 =?utf-8?B?eUFNME9xTUJ0T3Q4RkJocW9IVklBa2svNDhucXJncFVhUG8xdDhRUEgycU9G?=
 =?utf-8?B?TUE5QndZdzBqQjZjdm9VYlBFY3FMOWZOUWo5azY2ejFweG4rM0luMGVRVHI4?=
 =?utf-8?B?ODZLVEgrZFYwZGpuaytzaTcxQmJWbmg5c25HRlpEbCtUcmdGVnhrK2I0RlVN?=
 =?utf-8?B?Ly8zMXNZdWIwelBuZWloRTFGUFFRWmhjQ0NIZkV6aVoyTnBRckwxYzhKc09W?=
 =?utf-8?B?dzVSbGpJTlIxZlhTTFJCS0ZkZFREWjA5M3BDV1Bxc0tiRUlycmQ5UmluTCtr?=
 =?utf-8?B?Y0xlbTR3ZU42VmdlQWNUODNFWkZsdFRvN1lBdVg1cW1Ga2YyY0ZKTXBuaVRK?=
 =?utf-8?B?WlArUDF4NkVpRE0reFR4NGZBekZUWjUycE1ibjlNcVJTS0ZSTUNBRE4xS0Uy?=
 =?utf-8?B?MGFZUy9sMzZIRkl0VlhXY293QjNuNVBTTkh1Rk9BelBXNXp6VVNHbGpxa2xz?=
 =?utf-8?B?emRlckoxQXBCQ01sUHF0ZDlod25pY2dTOG41akRvR1NRUm03QnBUM2NRMXRz?=
 =?utf-8?B?Qld4WDUvVXNCcUkySDdaODZQUThpZDBWM280SnJLRi9KQ1RiV1l4TWx3UFVX?=
 =?utf-8?B?MVhqZ2I0OFljdGRDcSsvZDlFMXNySmdxUGI2d2EvejRZb1YvU1NMbUlaT1Rp?=
 =?utf-8?B?V294a2lNc0xjRkxvQnN0RmNYOFNNOXdyZGYwd1N6dGtXODFxTTdpRzVYSDBS?=
 =?utf-8?B?QTNlVGQxRWM5aWtjalN3eVUza3lGalE3SmRUK3cyYWlLVDIwQXNBdDR3bWVW?=
 =?utf-8?B?N09IaUdHSFNFdS9IUjF1MU9WY3p1WXdwcVczWjZBU0xqdFJLcGhNYTJ0aHpx?=
 =?utf-8?B?b2FsMmxyeXRCSnkrMGR1L29tQUhQcUx1NnlDU0N4bGJUaXNQVENKRmIyVVJl?=
 =?utf-8?B?dW9YS3l4U3BEbHg0akpiMUVxUmkrU0RXZFJHMzgzTHJRektibTlxVFZGaG1D?=
 =?utf-8?B?aTErM2NEWjdxU1VJT1lZcVM0SW83UkxUTlgwTmMwTERVYjJSR1lvRnNlc1lQ?=
 =?utf-8?B?Z3RyTkRORnRUR3pKa3pHQXdtSG1YYnRtVEJmNU4xQmpzeDQ4dFROaWpKYS9V?=
 =?utf-8?B?UUM0aUh6VjM5dlZhQmFLSysvbzhqTzlWNUNrV0EwUXQ2amNDLzdWTEFHQitU?=
 =?utf-8?B?dHNBbmpZa2VWNHVITk9zcVBDZm9Pck83a1RwSWcxMEJIaUZGOXl6VklMclZz?=
 =?utf-8?B?dUhLVm1yY3Q2R2QwQWJodnRaUWdIZGZTNm51eFhuSmg3d3psWSsrVVJkeC9o?=
 =?utf-8?B?SWJEWkZwYmY0Tm94Q0crazNPcHFjWThJUG0rbGxsVVdTMWNBUkx1aXRiTXFC?=
 =?utf-8?B?Y0paTVpYRjNkYSsvVjNzbkVWWkJlL1djcElpb0tKbWNsTXVmejgrOGdSR3pD?=
 =?utf-8?B?TEhMMHFYdEZlNnlMbENFRVlDMjNFdG1xMjVaYjAyWXliNEZHeDFXNzRKY1J6?=
 =?utf-8?B?ZzUveTlxQW8xV0w2Z2VSSWJHUWlUNGc5ZXIrc0hVTmcyanNrRTh6RSt6VHhX?=
 =?utf-8?B?bWZ2cU4vbUcvR3JIWW4raVZTREZjdXVQUEJYZi8ySysyakhON1ZjU0RkWUZI?=
 =?utf-8?B?Z01oaGMwR3llczMwRGFzbzdwS05nM3BHNXdvOXZRUmY4WXJXMTY5NEJiWUZS?=
 =?utf-8?B?YTBBc2lvWmFVVG5ZUC9FSzhybmsrZnNRcDQ3bzA4QUN1YjhJZ1U3M1VSWnFK?=
 =?utf-8?B?MlpGSWZIK2hydVlkUjh5ZjBNT2pJZXpwRlNSb3Q4NWd1eDd1ZnlpbXllN3NM?=
 =?utf-8?B?cFZTOXloYThieURiUEkxdTV1cmVJWWswMDdQYkxBMXdWcU9WRitCRXQ5OXlE?=
 =?utf-8?Q?Xm1WfhCH1OtKSduxcf66hEGRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be57225-14e5-4797-2ed9-08dd75dc8985
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:00:22.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWF78yH/zdc9958vHq0T7+LnTbNHC1pQsVmIfPUrNIgMsSwBdaj/9zTYXL3f6EN/tukM2hdOc/Q9QuKl2P+ikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255


On 3/31/25 19:33, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 03:45:37PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Export the capabilities found for checking them against the
>> expected ones by the driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  5 ++++
>>   2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 05399292209a..e48320e16a4f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>   
>> +static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
>> +				     struct cxl_dev_state *cxlds,
>> +				     unsigned long *caps)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
>> +	/*
>> +	 * This call can return -ENODEV if regs not found. This is not an error
>> +	 * for Type2 since these regs are not mandatory. If they do exist then
>> +	 * mapping them should not fail. If they should exist, it is with driver
>> +	 * calling cxl_pci_check_caps where the problem should be found.
>> +	 */
>> +	if (rc == -ENODEV)
>> +		return 0;
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +}
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
>> +			      unsigned long *caps)
> nit: the indentation of the line above is not quite aligned
>       to the inside of the opening parentheses on the previous line.
>       There is one space too many.
>
> ...


I'll fix it.

Thanks


