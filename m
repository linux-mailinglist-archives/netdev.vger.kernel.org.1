Return-Path: <netdev+bounces-119678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E794956919
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D516FB22F2E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC3165F0F;
	Mon, 19 Aug 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08L9X6Gs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C4165F00;
	Mon, 19 Aug 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066000; cv=fail; b=L9mmdo/fnH5HBueoqaFR/O+qQfDWZxq85k2fxUUl9J8LfEFr0wMBfZoCYD4VJIijM8I4DMnm4ktL6+NWeGn7wDq/9Cky34DqOpEXgD+aSGiwSIfvbvCV85XEwB8WmttioABKbWeR97DbYn+XYMbdRmYJQSx0hikDvP5AC4IaJzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066000; c=relaxed/simple;
	bh=26Y4WJAPhxTNKTDZOMSq6c5HjJhB33ldLDK6PEouIpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SCcXN61hdcmlNeVUsF/GNPR/CiEWeDjhfbnCjumxjyxG+gigDFyKWVZntePqMh4cLSg0YPVB5HQuXq+5R5NE+J4HG2UzR4jEKpoILXx5774wpDc+w1ozy+FINCi+jTioGU2JxmJzllztvFfUk/mCh+X1XO54MDGk0XZSwReuJuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08L9X6Gs; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXAOMMG0K2kDixNKLuzAcssbiLTXD4m9BZ5uLqh2M6qz+LiksCboPkF/vht+q6SrSV+S1Tv/Cr749Ld0wu+h5zkRiSKbHO1wHV96UKUS5PbD/fR7vNPPVzw2I1Y+d8+NeB0WKvTdoVwVkGTt4uRSyAI2QnJ6afMM/vJjR9HaU3K+TMoyfNft2mdUKV29Czvpt7vGJcxOrZY9UWJb0TP2/ZKZL2cMqKDKydFObKE0xLPCGnytPa6Vh/T8mVKbSSG3e8je8gX+MIhkk0830hE8jibYE/7SovfuQ5sUu10FdKDSyHGfP7i1YWPI2HoTSghuD88KU4a0vEOvUIbx5tRsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0533U7VSQ9THb/BTs8+rYC5p/kCG2FWoLaQhGAdWPc=;
 b=WIqdnKqbg6ila1S9OymetEmflN+GPFVfefJJTZs7vJAQgcw/pxLdGYZAjZTBeGJ6S0VD2kzHg+6fYCjd9xylmp6w23v1SKy7/I1wGT1K/ZTSRgcmJt76pqhFBHHMLYxIjimYu2DLe4yilDuRYATLoHQcCkohVy0XbvRDTNEmHkUu1YOFLlKkHDPO4Eody473AC0IDjbrSnfapMCsPxalB0N8zIJqgp+T8h3YHWJX6nBTKsJd7MK2126cbV298Xx8RmayyqA+ulEdwkDwIjVL9PLMXor+zoDfqSQyV84InQw6pxoD0p8Zk8e0L+4PCz4sKqtzX5ugJMnrB+hqnVzy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0533U7VSQ9THb/BTs8+rYC5p/kCG2FWoLaQhGAdWPc=;
 b=08L9X6Gst6hdiBR0dmMXxhZzVjn/CatUKABsyEl07kaX5k+XU1vqzyCWixDpD7Ddx2UYjwquwmGWFN7sRFmeYOGzjHh9svjMitEOxXyNcU2a4O5HTGd+e4pUPKBes9MIH9BJfFaliv0LikBIhleAHxVo1yAWR9gS8U70Nd1+X4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:13:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:13:15 +0000
Message-ID: <26723cc8-c067-280b-f0cf-ee3906545837@amd.com>
Date: Mon, 19 Aug 2024 12:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240804181045.000009dc@Huawei.com>
 <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
 <c9391139-edc4-73a0-3ede-d67c40130354@amd.com>
 <20240815173812.0000447c@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240815173812.0000447c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: aead4b1c-b7bf-4fde-03cd-08dcc03fec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWVQU3ZJQXpaWGFURU84RkN1RzVMc2Y3aDU1Y2RsK2dVMDdnb2hwcFVGbWhK?=
 =?utf-8?B?WHRPZzBJSnRxOFFoS2tzeC9BSmF6bzMrTW5JeDlNSUNlNTgycE02QXdFSFpr?=
 =?utf-8?B?Wm5KYXFmZWVnVGVmVlFFM3VRSEN3anhTdFhZSUw4R01ZTVJMRXR3QVRzTFZ1?=
 =?utf-8?B?dE9Yb2daTldOamVXY3c0ZGt4b1hnWG53LzZEbXVRNldMMkxjTXl2emxBZERE?=
 =?utf-8?B?TytNWGFzMjVPa1RTRnZEam9iUitPcXJiL0ZIbHhJMXZyUnB5VzJnSk50bTV6?=
 =?utf-8?B?Yk40eGtGeXoxUURsbmVwRjdadk9HTmRtOVVCclhocXkxOGlIR3dPUEtKcnhl?=
 =?utf-8?B?VEhDeXpRTmd3UVRXeXJHRFB1U2dCSGRHbk5OejMvK1dxOEMyempaWWVoQUNq?=
 =?utf-8?B?R3M3bDBMYUxLZDhLZkhjRjNNZkVCWmZKYkJ6djhMbzJrN0ZLUy9zcTR3aWhm?=
 =?utf-8?B?cFBMN3J4QW9reEh5NmFWaXZTTHcxb09CWC9uVGg0cDVvT3hTZXgvN1h2dVFi?=
 =?utf-8?B?ak5HNUpLMmg0TmhnR1llaU1SODZ1Q2luZFBGNzZnajZ0SDFGUXhRM0JZZXBt?=
 =?utf-8?B?MGZqSGdVcnBNaFp5VUlIWnduVFl1cFgrNy9TcHdaTFdSZ2lxZ215R3BxNXFS?=
 =?utf-8?B?T1RHdHhWMjB3TUlueUJ0REk4V0IwTmNlK0hxV2t2WGdKcnlHU3RWeGc4cFp0?=
 =?utf-8?B?UllKMk15T3RmQjFTYnovTElSOFNIcndxT1F4V3AxTjQ2UDFvaUVmQnZhMXRx?=
 =?utf-8?B?b055VVd0NWMwQ3hRTW8rd2FYbGZENmdRVlZWdjlDQ3ZpSE1TOW1XN25acWx4?=
 =?utf-8?B?SWxSYyt1akVMK2NwaWpaS2g4ZU84aWl2eEwyTlV2Tm16cUFwNGhJbDNjWGRa?=
 =?utf-8?B?MTdzY25LQU5SMVNqVGlIVFBYRW9RMWtwbVNOUWFBTjFTRDVaeE9HMXZWTC9W?=
 =?utf-8?B?ZkUrK1FNTm4rclpwZGVzM1UwTlFsZzVSbUVzc3NPcmM4U0RFZmFoRFBGQ3hP?=
 =?utf-8?B?cTJ5dUtGYlQwN3B2bktBVG5wZWlwdUtDNzNHYnUwVmNkQWptaHF4KytBMisv?=
 =?utf-8?B?NVRGZkZ0ZUFoNDd6MnBDTHFnTmNmSVpKRDgrZkFuVms3K1psS29zRzF5cTFU?=
 =?utf-8?B?Q2ovdTlqOFRLZm9TR2poRGlFY3pycTBKOEhNUi82bGY1aFMrSVhXemVZRDJP?=
 =?utf-8?B?NUJXRjJRWUcrbUlydFFpZ1dzZGpFRFFOTFlUbUc2aDBsWDNkOUs1YlNORk1u?=
 =?utf-8?B?WFpCUm9wMDdrVUhBeVdGS2NoazVITHNjZXVIZXRoQmFsejZsaC82U3RYR1lC?=
 =?utf-8?B?WFR2Wm1GTkl4QjM4dk5ZYzBZWTRaMjV6RjNlbEYrWXNhRUVWeEk4SHFrUlNS?=
 =?utf-8?B?NEVqcWQrb3BBNThSMGdqWDY2Rk05OE5aQ3dHZDNoRFBLOW5qb0tVdnZ1TG9z?=
 =?utf-8?B?WlUwN2NXREtieVR2djRJRlV6UmlBbWhRSHV0S3NWcG9DVCs4OFpOOVhLTEMv?=
 =?utf-8?B?aHE5TGkwWDNkU0lQQU5DQzhzTExtRUg4YlZjTHkvRVIvbms4dUtDNUowN29n?=
 =?utf-8?B?TzhmVWZiY0Z5cVEvbHdXZU1VZXhlUGMxaGxnc0JBaC9sKzRBeGNFVVhKRUdu?=
 =?utf-8?B?SGt3WmRvcjlpZkowZjcvL1hvZTJyM1lld2x0bnlRWnE1eVU2UnlJMlZ3U2ly?=
 =?utf-8?B?dFVXV01rQlNtS1BXOWhiTEwxOWIvaWxlTWNJYTZnYnFiUjloY3dNNklFMTVs?=
 =?utf-8?Q?YckWDNfYlnbEFAb2jI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE4vQTRLU244eGY4eGpRRUNSa3d5ZnhCUGptbEcyMlNNNlV0TnA4eUJnb0la?=
 =?utf-8?B?aXRmSEFXT21keTJ6elVxOXFrNE9mdk5CVUlPOFJSZEpvWHAzZGtPbC9rRFdV?=
 =?utf-8?B?NHRtam1yNDdETlNlc1ovcFIzYlVRd2M3NlNEK2JlS2VVUkNadlVkUVZTd3RX?=
 =?utf-8?B?Vm1sait4UjRkTms5RUlrSlNNVDVFV2dYQ1hkd2VNdE1wS1Yxd1hpeElER290?=
 =?utf-8?B?dFBTVjRHZkc3OURrdDlCNG1KbkI4aXBtSXpWOWdVUThOaVdjZ011Qnd2VktO?=
 =?utf-8?B?VDFKd0VxUXNPRmRCbG8wY3laa2NFeXJLdTJwZm0wYmQrWkRJOS8yeTZ0SVhk?=
 =?utf-8?B?ZDc5NmV4OVF1VWhEUmtpeUFmb3NlcG1QSXd0ejdDc05QbFZvWXNMVmtra3Np?=
 =?utf-8?B?a1JxenF1bjhtMmE5RG5Db3dhb3ZxQnlyWEhSUmNBTlJvN2toc21JazVtUk5K?=
 =?utf-8?B?bWFnUEtnekNmZytEQllZU3NvNERwMStvY2hacmxFSlUrVXZRRFJYVnRFSzR5?=
 =?utf-8?B?RWwzRXJscTBGZUdYaTZXcHF2RWs3UkE0TUhLNTJCdjhWWEJDTXdWOVlpQnNM?=
 =?utf-8?B?MnNIRU1MUkU1MXRFWXdTbXlLTTRWTkgxTkZMZVM5c1IxazdWZy9RMXpCYi8r?=
 =?utf-8?B?N2tRVGlOaG1TN3k0M1luS3dwK2VGSjdzOTB6WlAzRkZIMGkxbUtsbVllWnRv?=
 =?utf-8?B?eHowKzJ0eUI4Uk9oSlJaa3NuSGk2VGNHNkVDU2VRWlhpekZJRGI3RGFsVlhH?=
 =?utf-8?B?aFZkTHN3cW9sMlBQZ210eHo1Y2hISmV6a2pTUnNJUWU3TzRiS2dQUGh5Sk4y?=
 =?utf-8?B?cnc0SlhucnhMZ0dJMUtaMUtWdkJqamRwU2Jsb01hTHJ6SkQ2aUwyRWpBWGtk?=
 =?utf-8?B?WlcyZmh3a3Z5MG5EUXU3NitiTHNDZkZ0eFdlUE9CZHdWcmtaMFZoZWMwQjhv?=
 =?utf-8?B?ZklPUC8yb1NsdlN1RzBNeXh4ckZrNFpYTkZNWjdGODQycXJrdWdIRjFtZWly?=
 =?utf-8?B?Uk9BT0NkWXd3VDZKamh0MC9uZzdNUHo0MEhjaUtwZmcwNUc4VmVWbEU4S09s?=
 =?utf-8?B?ZFBEcTRZMVI5TWt3Mm5qNURoemlITHhyUkt4cGcwd3V6a1NwQ1Z3aWFXeEdt?=
 =?utf-8?B?dDY5T2x4bTh3MnVSbG52T0V6alZOTGQwUE9EeFg0M041ckk4aHZGa0p3UTVV?=
 =?utf-8?B?a0R6Z3BhU2NXbCs2dWovSlZCSFJ3Zm1GNTFyQmxJK3dGNUNvMDByRHl0R1Ra?=
 =?utf-8?B?ejVVZGZZeXNFWU9WeVhZVVhrY25OdEMvZllOUEJxNy9xV3hNdHRrUlczTnpY?=
 =?utf-8?B?Zlo1RmdHUk0rMVk3L1hFQ0krVGlVb1Voclg5cjRMN1dWQXg2a0cySHJUSHJU?=
 =?utf-8?B?RzJNU2pLZk80U1lqR0lGSDRUNG01NE5vYXZPMm95N0VNWFFvcGxTZVZ6K2g2?=
 =?utf-8?B?clE0TGZvY3hLNHhMSXZsalcwci9Jc1Q2c3dyN3Q3WXI3QytLSG4xVlVkbHgy?=
 =?utf-8?B?d3hRLzdSdXlBSzBlN0FIRStEMVZteWlKYlg2Y3MxcUo0ZkpubFdTN3FWczEz?=
 =?utf-8?B?RlI0ZHhhNEQxSHROWFZ6TjU3NVlvL0x6TEZna3VrRm5sM3lrbmZGNjc4WEFu?=
 =?utf-8?B?T2Vzb0JiYm4ybU9DQmswdXJEckptQXdzUzdTVUtBYnlCdVQ1YkJzSGpOTlVp?=
 =?utf-8?B?TExub05hOXNGWUVBZjJBQnF0VDZsMkdCUGw0ZVZwcUdxaUtRQWJtN2FpdEFa?=
 =?utf-8?B?ODhXclVUVGNzTXhtTXZIeFJENnI4em9LTzgxOHVsbnB6YlFKOTJCS3pScitK?=
 =?utf-8?B?ZkNLbGU0MWUwTlh6VzBhVVBFdTBaYkQ2ZThGVjZzUFhKakFJaE1VWUxMRGVI?=
 =?utf-8?B?SFkveVZ5YVQ4QVRpaU1PTnhpa3FVVlRIenp0R3pPanA0Z3V1Q0FRSWlmZDdu?=
 =?utf-8?B?UGhuUWIySExoYlI5UVZDMFlRWWN5L04yM21xOW4rSVFjK1ZUMWxwbDFpUFpV?=
 =?utf-8?B?YXZrN09kNEE4U3doZkhXWDZjdWN0VlJvSmJWUzJpL2hqL2g5UUJTUytMMmpa?=
 =?utf-8?B?WWNIQzEzUGFVNTdSUVdBNFIrT0tCalYvQ0xCOEpUSU0wZEpzMmU5cDVTQW8x?=
 =?utf-8?Q?A5SEoAuycap/dHhwl0ctl6Jzk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aead4b1c-b7bf-4fde-03cd-08dcc03fec1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:13:15.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drBVQ8st3vA4XkzpHY4XiIeq96drmyUVHnFXSlcP5nPsdcc4E+oJS1orgIqlzwU5J7FCOzG7Ris7bLtNqvLMpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696


On 8/15/24 17:38, Jonathan Cameron wrote:
> On Tue, 13 Aug 2024 09:30:08 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 8/12/24 12:16, Alejandro Lucero Palau wrote:
>>> On 8/4/24 18:10, Jonathan Cameron wrote:
>>>> On Mon, 15 Jul 2024 18:28:21 +0100
>>>> <alejandro.lucero-palau@amd.com> wrote:
>>>>   
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Differientiate Type3, aka memory expanders, from Type2, aka device
>>>>> accelerators, with a new function for initializing cxl_dev_state.
>>>>>
>>>>> Create opaque struct to be used by accelerators relying on new access
>>>>> functions in following patches.
>>>>>
>>>>> Add SFC ethernet network driver as the client.
>>>>>
>>>>> Based on
>>>>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>>>>
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>>   
>>>   
>>>>> +
>>>>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>>>> +{
>>>>> +    cxlds->cxl_dvsec = dvsec;
>>>> Nothing to do with accel. If these make sense promote to cxl
>>>> core and a linux/cxl/ header.  Also we may want the type3 driver to
>>>> switch to them long term. If nothing else, making that handle the
>>>> cxl_dev_state as more opaque will show up what is still directly
>>>> accessed and may need to be wrapped up for a future accelerator driver
>>>> to use.
>>>>   
>>> I will change the function name then, but not sure I follow the
>>> comment about more opaque ...
>>>
>>>
>>>   
>> I have second thoughts about this.
>>
>>
>> I consider this as an accessor  for, as you said in a previous exchange,
>> facilitating changes to the core structs without touching those accel
>> drivers using it.
>>
>> Type3 driver is part of the CXL core and easy to change for these kind
>> of updates since it will only be one driver supporting all Type3, and an
>> accessor is not required then.
>>
>> Let me know what you think.
> It's less critical, but longer term I'd expect any stuff that makes
> sense for accelerators and the type 3 driver to use the same
> approaches and code paths.  Makes it easier to see where they
> are related than opencoding the accesses in the type 3 driver will
> do.  In the very long term, I'd expect the type 3 driver to just be
> another CXL driver alongside many others.


It makes sense, so I will change the name.

A following patchset when this is hopefully going through will be to use 
the accessors in the CXL PCI driver.

Thanks!


> Jonathan
>
>>

