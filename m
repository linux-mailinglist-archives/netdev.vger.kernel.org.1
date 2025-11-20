Return-Path: <netdev+bounces-240533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A483C75EB2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 783B63475A1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2740277CAB;
	Thu, 20 Nov 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bm8VNMWH"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19012362130;
	Thu, 20 Nov 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663279; cv=fail; b=sMU1eEgLHND6LQzmiXpwzuJLLeBEdS0clE9fm0tMeO0HQf4XsBnPR2un5TMVm5zRWSk3qyq0P2FAmTLZSFzxBffCQPtTq/J8FdsxIMcczonuTyD1ih4DGwFzbgO/guLMotUmpW7JfBYd7vQBkSVgkpZpWl4yTsQ76vcsU6utwzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663279; c=relaxed/simple;
	bh=SacusCQO7Fz+zzBJ5u9arIwOyrytljb73mt4aVTedHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d64ETNB9xxBPW3sPOZ8dWVT/GDvn1ErYNs5/ZJxhUYKiiBbSYlaaThouW8mnYs/HOyY6RSv8B6eOFQhNGWkQi/2RZKIFOprjKq9qRSd/Zu1ZGznbdZXpamAP0+YAgUow0TV26oHMWNa7dAfRKPpku28LXBXVI3P/8RK10xge+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bm8VNMWH; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omwS4qWSHn2ou8iBrKmRa6598XSpiFxc2CL8Fdo/F9+SEAfheXOUM5ceJEIKCeuvH+hZZBpzUzOi2uzgFiQQ3QMiZiYkV/2iMfU/xRfek+YbExivGAlTzxcYIpO4zu4CJy8a5peqHL1EpODOwc31/JDyEWrMXUIZkD3ifYdhO5IRaNqFs1WigoB1n648wectwlktTHDua9EkwPZ3q5rp8WRnkPzxQ5qaNWHlBiofdY4E/WrzNFKXdHsefSKpB+evORXqYSJXvi/aGyYg/ueCcMtqlVwapOzPGuaopOzYxEw/CbZ4yx+88Ynlg1Ul57t2+lIpCYjREA8G3MWl5KiEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XAh2UX73lwTzZnxSbO/cQ35wcy7PpHGxpjCYiBdp3U=;
 b=kdVXA2LXSxC2fjJZLEgZRvyLlV+tPfMGtNrzUq1354tMJzYXdIcpANy6Msm0xTzS4VlXpmYU5MllZAX+q2E+GLfqVteT56xrhh5bgWMSBwrtyOLGZoULZaCjG61yGKXoxJupul41KThmfK1SUGmBoU/63wuBPthFQl58DUFd+MT/t6P2muxRVZ0SZTbTgLQWQvbLiZndYW+PWa1WLXD9kKDtnhrhJiwhcrLBKFBqu9kVJ55+sT29OiA654a13oYZqzJrljNoi6hKfGLgrlcM3N/3JzOn5iYd91bcxitzYzOCIBNFg1hCZ3K6qqX2m+FjA9MzWh4x3fOLxPRsqfrd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XAh2UX73lwTzZnxSbO/cQ35wcy7PpHGxpjCYiBdp3U=;
 b=Bm8VNMWHpHwevKUoKSvSveLDvn8jiXHngfKkdQwcnLau2RhsCKONukuki0pfifxCq+PkYAUm62qbaIhnTfNdNLvEkuDndI2ETMf1SY+plYFijbIaic40U5VISTa/L1NomIQMzFlmO7zxT9sbA4pi3qnTfPAcptEMjEzSgPoTARE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:27:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 18:27:54 +0000
Message-ID: <c40d91b5-d251-47a3-8672-b9ea5c54eb2a@amd.com>
Date: Thu, 20 Nov 2025 18:27:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
 <20251120180805.00001699@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251120180805.00001699@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb8406c-57f7-4b15-02a9-08de28628556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0tUeWZkR0lNWkxxcisvQWJaaUZqaDBFczlwTTlpWG0zUkhRenJBQ0JUU3BU?=
 =?utf-8?B?YSt6alFDVFRpQXVBRmdVVTZPOXduZndiVHNZcUtZMjJtbFRCTUxIV0dLQW41?=
 =?utf-8?B?MjUzQmd1TUdpazFrb0dzNURsUjJqNmFCM3UzeUc3aXpwY2Y5c05BZ25aZnlU?=
 =?utf-8?B?NXdDQTVBTU9oRGlzeEp3ak9iRTNxeVc2N0VObDZqZ252dHVRbDF2MHRTTnlt?=
 =?utf-8?B?VjFBQ1ZGTlRqVUFxRWY5SHZ2eVFjdkhFTWpmUW16dVNWQUFjTDVwYUx1c0w3?=
 =?utf-8?B?eXVHUHRpQ3VyMU43c284Nm5CT3VMU05UL1Q1M2JnUVF4K0pUempWMkJNZzhq?=
 =?utf-8?B?WDh5am5vWmNTaGlGM1N0cXlhSzBrUnhpbE85SGlmSnlXNUFyNkFHaEM5SEN3?=
 =?utf-8?B?cngxUzNyUldINXpSd3BNMlJ2Y2plbnd2UFVwNlIrbEdzWllWYktwSUdBSDV1?=
 =?utf-8?B?UFNXNXNLdHBMdTZNN1dSUW5qbDhrVnBIS0JYSjZncThNYWQxaXZ2UkljTHZS?=
 =?utf-8?B?NVkrZjFKZ1hDRURIMWoyamdPOU5XUytrdDlsb2FlVGVNVVpqckxnaFVxNEpI?=
 =?utf-8?B?c3pQVHdJT1NjT1A2OVRKNG95R1NMUUpmdEx5Tnh0VjJCdU1CeHoyUnJBWTBB?=
 =?utf-8?B?TTlqblZiRHRacVY2cjR0bEhUcHN1bmtyYWJ5eDFkR0Zoa1dVbkRrU29SZU9y?=
 =?utf-8?B?R1hTWVNQRFJveEMvS1pFL2ZwUm9RSFE4NkJSMzQ5UE8xVkdINExyZzdaaGtC?=
 =?utf-8?B?WCs3Q1ZYZEx2NjJyU3h5U0xDMGxwOCtOd3Z6VVBsbDFLWk1pcEh3czNqMWFa?=
 =?utf-8?B?OVlPelRjM1dGKzA0eDdnZ1ZKYkxleCtxWTR5ZHd0a2QwTXhoUk0wTnlZMjRF?=
 =?utf-8?B?S2lrMmtDWU9qYVVoM2ZCZGFnRFhiKzJmYmp3aDA3Qm5BOUs3elVsQ1JKN1VD?=
 =?utf-8?B?ZDVrZUhTempWSlhRNEtNRjVoWXdSdmxMQkZaZ0FrVDJyaXRvakJFWWRpemVZ?=
 =?utf-8?B?UXFQYWh1ZG8wcUxWendsQzFVYThlbVhXK2RBd0lSVENUcXpTRjJsc1NwTW9F?=
 =?utf-8?B?Y2txUDd4YmNpazJmbzB2bEJGQ2NmL0Z6amgyTG5kMHgrOXlJT2JYeE1FK0ph?=
 =?utf-8?B?Wlg1dlV1bzFQNFphNHdrSmZDREhOWUFOU1NuRldGeTczcFVJelBNVjN2dEV1?=
 =?utf-8?B?TngwUG9uOHcxdXZ4Mjd2NzQzMlVDejY3RkRPaEk3ZG54bTZKd0JRNnptaG5X?=
 =?utf-8?B?bk5rcWQ1cjFscURqODlJUGN3cjZmR0pWMU9lRmM5eWpoNlMxdE0vTFRRYzZW?=
 =?utf-8?B?ZDBwNGZVZVRQS0pnL0QrTEpJSXVCT0xVTjJ6R0JJMVNFc3hnem80Y1JzeVha?=
 =?utf-8?B?bVlKTnBMQkVFK2dveFpOaEE1NTlkRlBkdTcyNmRpMm1pOTczOXdCbHhuV3Fr?=
 =?utf-8?B?SGRucG1TTEdadkV6b2tUWGpCZTJteTlxZk5wKy82b2oxaGIvQ1k3azBUTThW?=
 =?utf-8?B?ZE5hMWtSV0h0ajdCbjFBNVAwRXZpeGdSZ2dHdkRQVXV4U1hOWWhWaytERTBY?=
 =?utf-8?B?NnQ5Wk94UmwveGtXRTdVai9abmVYVHNZNEJrOW4xTUJNZGNCQ3NXaU1lbVd3?=
 =?utf-8?B?bThESmVCN1RjNUVBYlMyMXZ5cHcrQjNZZG1WN0Y0czFBdkRNNTdlQjFUdXpY?=
 =?utf-8?B?S2ZvNWp3NUpSc1Zuc0tmcmJuU1RibEhDWk1obW9KVmE0bEF6WC9TMnluN1Vj?=
 =?utf-8?B?Z0NXVVhacUVma3B6d25TcWRTbHlQTHVWM2ROQU4xZ2VsRTlUWXJ6TXRIT0JI?=
 =?utf-8?B?L05wSERlbHlrcUFFSkxHVWdwanlnc1VMNVllUVBsQTdHb2NQcHE3aW82azdo?=
 =?utf-8?B?SGIzcExWYjBVa2FMc0FmeTczV3VWSk5sWEhxbitaK2QySm5BQkltcmM2eWlP?=
 =?utf-8?Q?eYpfWvupyJ2AerTaPis3Q3qxK0LLG1Z7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdOeWJ1bnc2L2docWNLVHdRLzkvbm82UWdLMUVaZmZNUWZjc2dydy9MMFJQ?=
 =?utf-8?B?WGRTaU5WODhzQWtJbVgwdXAzVTErWXRuazBlZWtBazh1SGI3R1FBVGttMnBr?=
 =?utf-8?B?TWtUYnVWUmJ6UEVRZlgxWklsUklBNGJmSEVFc3pPZ3dwVzU3ZDRRVUxPUmNj?=
 =?utf-8?B?cXdoYnM0UDhhUlNYWVJRVUUxR254NzNnUEFBNEt6NjhXRlNtcVRrSVNRbkRp?=
 =?utf-8?B?Nzk1Skd2MXRYNEVXaS9oZUwvQjV6dHhTZjA3dHBLRlhJN1kxN2oxYkNUejdE?=
 =?utf-8?B?RlFjWW1DZFBILzJRRGZEM05kcElHalBJeldGeXdkWHdHRXRqY1VjUExpTXZq?=
 =?utf-8?B?M01xK2d6Sy9rb0tUNndSR29PQWVKZGhHUnJCM1l3emZXalppdXBXd3pveVRL?=
 =?utf-8?B?cElUK3QvUDEySzhYTWZLUE94ZmNPRTNpOFlPYTNtV0xOdnExRFZZZEV0T0Iy?=
 =?utf-8?B?blhabUNsdnIvb3JWN2hIeFoxVGMxaXE4TkxTYmhyNW1IVVJoV20xeURWTGty?=
 =?utf-8?B?QXZyMVpMSG1Rd2VuZXg2WmxNb091bWxKZkxJTlpFSS9rUkUyRE9xSlhBdTZ1?=
 =?utf-8?B?WU9pR1BieklxQXNjU0REQmNySU5hbS9RR1ZYeXJhTzdyckxTaW95M296cmtz?=
 =?utf-8?B?NjBEV3JoejJJY3NLNFdEYTRtZ2xFemVmRVBUMEZheGVPWWJOeXRjbHo4WjBT?=
 =?utf-8?B?cjJoM250MjY0REt2NzF1N21nNCtDTTl1K0tXR2FBbXVGMUs2MGtPOUFiSWJJ?=
 =?utf-8?B?K0RPRnVrazEwSlhnTGZWQklNOE5TcWJERUljMm95dTk4SHViaDVYamlJbHV2?=
 =?utf-8?B?TFpheGQyYWF6WWFnU0wwbllRK0I2cUw0Rm04NlROVG9WdU9hTFEyb1dSbGVo?=
 =?utf-8?B?WlU2c05NOXNZcEhGbnZmMWhSdTRLN0NmMERNZng5MEkxY2QzVTJVRHJmLzla?=
 =?utf-8?B?aTY3eDczcU9jNGdML080dGhLcGxvZkhGcDIwRUtPWjhiZFIvUE8zQlUrKzBX?=
 =?utf-8?B?TkRYb3hTM0tiZjBDZ1lxR3FnQ0h2TXRobEMyajl2VStqd3kwOGpaa2Y5NCtC?=
 =?utf-8?B?RGVlZkV6RTZyL1cyN2Ixd2I1Qkpla0N3NzFNU0J3RlhCcmJSTTVRMkZwbHBH?=
 =?utf-8?B?YXd6dXZVelZLTW43UUtMcXplRTFrUnovd3RHQlB4Z0RmUnJ3dk84WnEvUTdR?=
 =?utf-8?B?eWNXSGdhd0ZFOVB0R2x0cnR1ZWtNSk1yUVFxeVQrSC91OW1ML0xBbVNHUS9j?=
 =?utf-8?B?L1BtU3VDZXhnVXkrM1hFblRBYzR2REhzcThjWjFjWUIxYzhiYkRsSEU1MmlW?=
 =?utf-8?B?ZGxnVktQTytVN1A1N0JrMnNjZ0FnenJUYStMclpQZ2pYVDNnMnhKQ1BvcmJQ?=
 =?utf-8?B?RlZrZEY0VjFCZjJWSlhOTjVkOHhWQURFVEhnNm1rZThRUTdOMGNaU2lMS01C?=
 =?utf-8?B?aDRjdFAyb2tHenRWUGhWOWtwQ3AreUV0S0h0R3RQVkIyZ0llcm5jOTVEVjlI?=
 =?utf-8?B?cDJCbkdJODRXcElyS1R6RllMcUVMelNGaTIyOTR1YitNalZWb01sMDJtODdL?=
 =?utf-8?B?NGNHQmpKVFhuMURCVGdzeHpuUDVYK2NJQWFVN0JVMzhkMkE2TkJkS0RkbGhD?=
 =?utf-8?B?WGFQaEVGTkhOTVg2SlZ4SlpFSGgrdmErWEc1ZUdhczZ0aHhRN01veDUyekk4?=
 =?utf-8?B?NDB0RU5mdVAzZGt3YWVsR3R6cVlibEt0Y2dmUjE2QlAvRTBIMHIrRlpQMDBP?=
 =?utf-8?B?ZXJZb0tPYkhHZzNKVExOWjNkU2xHOUFjWTdoUU1CVzlxejgxYXAzN0xkdk1a?=
 =?utf-8?B?blpnM0lFWFozbjJNMk1MOCt4UXJmM1d3dzc4QU04OXhtQWNDcTYrOVVQUUh0?=
 =?utf-8?B?N1N2QzRYbk1wS0MxZ2ZpRExIWjRKSGFkY0VZYXFzQk1rMGh6VG9icHpyMEVP?=
 =?utf-8?B?MkNpSlZPVzVWQVllOXNkMmNTR0NVUTRmbGNzR05jeDkyRFZPRCtRbWVUMnEv?=
 =?utf-8?B?VStqa0k4c0lEbElKT29admJRem1FMU04cEZ2c0xvZkFuNmlpNk1kb1ZUTCtF?=
 =?utf-8?B?bUhyUjZZaUQ5NGwwdW5icGxrcmlBUmdvRlg0YzVsZFEzQnluSVo4MmFoRWhQ?=
 =?utf-8?Q?7OLFi0hWBlJdWLlK8XgITKRm2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb8406c-57f7-4b15-02a9-08de28628556
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:27:54.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrYkUAAXDoWBPmmMlXD7HpoCRftJGSSzc/mz4ymBSmgRT8KwhzIBS7vy807Pu1EksjSSh4p1ASD+f8V1QzjY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091


On 11/20/25 18:08, Jonathan Cameron wrote:
> On Wed, 19 Nov 2025 19:22:14 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for always-synchronous memdev attach, refactor memdev
>> allocation and fix release bug in devm_cxl_add_memdev() when error after
>> a successful allocation.
>>
>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>> preclude needing to export more symbols from the cxl_core.
>>
>> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
>>
> No line break here. Fixes is part of the tag block and some tools
> get grumpy if that isn't contiguous.  That includes a bot that runs
> on linux-next.
>

OK


>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> This SOB chain is wrong.  What was Dan's role in this?  As first SOB with no
> Co-developed tag he would normally also be the author (From above)


The original patch is Dan's work. I did change it.


 From the previous revision I asked what I should do and if adding my 
Signed-off to Dan's one would be enough. Dave's answer was a yes.

Someone, likely I, misunderstood something in that exchange.


I did add my Signed-off to the patches 1 to 4 along with Dan's ones, 
what I think it was suggested by Dave as well in another review.


Please, tell me what should I do here.


Thank you


>
> I'm out of time for today so will leave review for another time. Just flagging
> that without these tag chains being correct Dave can't pick this up even
> if everything else is good.
>


