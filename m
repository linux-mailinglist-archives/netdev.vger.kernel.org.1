Return-Path: <netdev+bounces-126847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A84972A9B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F9DB21956
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110917BB3F;
	Tue, 10 Sep 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnwtJPvz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5540174EDB;
	Tue, 10 Sep 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953125; cv=fail; b=MS2QFwFVT7G9XiKe0kxpBkHfi+Qcs7B9/9NV3cPtZcMyqhf/JNQhvtih6rqnwgpQET2JjS/FZ0dkxrppkUY/UbZA3vtcnvzWoIc5sARJZ3DIysUeNuJo5B05Pzk1SeesAdJM4dAkBSXwrjBFTeJ+ECci5+29BcYN5vboL3L5vxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953125; c=relaxed/simple;
	bh=rNq3vSGBZlhMQo/8YF4vr4R3t5Bn8x70zKc7RAsZvyY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtxCWcP1DPhUQGnB33Zpnr9X6UAsT1Ieccv9zdroqBB9/vFml8wVdtRbFZneolVmiP7b2ZKpcxiG2E8b3sqDmTA4r7JA4MIgFYasg5ffUe2CHO98lnircQ/NtCOEu0jXxGcWc5Rp9u6WqgurbeRH0cQsKxJm9lgKE3n8EUBx05w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnwtJPvz; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juPYfGjPDOhSTWaYEXWWQ3/i8q3pxEKO3PY5UeN2qh1ru/DzjSEqBM8Iv+GOLRWCuw7R5Ld1KpDmXd91m5M5T63+qfHYj1t5ajshB4H0hE146ZsyZV6iT9j+NP5qjKWukUt1v9GsmldxGoDWCZWy8lOswT1rTBUVcZF3AXC8iMngXfxwq0XIJQpYe+3ZZD4xWFJh+FBE5w300KX74MisZRD3yaJ6M5LIdik6tUI3At+XfpmKqP4V65t0OiSHw/9MwWdXzpTtSy/XiAH8yb2zTfJYndzaj39nlHRimZKRVJJJDFnSlYZQORVsetTv9yjE/xA4KmTiRKHyXHMLgSB81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWvV6o4ZMTqTQkauoDCD5ZDkxIlLwGsi82FmjEpYH74=;
 b=X3mEFbw3hA0U/HqGn2kw1GgoHHgTm60PNKCTMYqYnb09Vws0vC3L+Vj013+PWVwnN1Wn/Z+1t2nvsw+Ohq41i58dohnnwiGSALGIVX96ASLlDBA1nHvvyeEAwIibEjWlYtNUPlK6fedmJ4aMjJ2m5zSO5zMF9iUvjQdieGrPI1M0jBVj293wfDoh36FdvWDFL2/9HYt8Iw6l/eIsiabhVkDn8lWiGs5HO36iyeyCzotDgVNGZcPcYj+YflNDHzx+q411tN/UieFOQQ6Avom5Zepr1sdi6P/Fvos6mF4kC5qq70ql9Jn54XfyliMPss1nCJCF95U+eEN+MuEVG9Exmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWvV6o4ZMTqTQkauoDCD5ZDkxIlLwGsi82FmjEpYH74=;
 b=YnwtJPvzfIWutDbIWKI7kZzktfe9+4g7+tzUDjyIdU+oHr1AKhlwKiLlOG+aFLJ4mXQHHTIDoPH6fk5dtnrniSDIccRgrwVjYOXyz6hxfSH7wug6RVpDh8hkK3+E/YnKpmGIl+2aAlykjf8+8xjBseKITS+ycgIKfuKfSkKRAjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 07:25:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 07:25:20 +0000
Message-ID: <d33cfda4-2557-fd94-dda6-5265e71ec2e3@amd.com>
Date: Tue, 10 Sep 2024 08:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
 <68878cc6-addd-47a8-b6c7-9baa141a8b86@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <68878cc6-addd-47a8-b6c7-9baa141a8b86@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0345.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6271990d-1c85-43ca-2a7c-08dcd169b9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1lsMDJqL25wV1R3Qzd2R3g2L25kTlVBMnFnMG0veVRNM2N4OXE2Z1JydlUx?=
 =?utf-8?B?YXY3dERRU0k0MGgxVklXZUlKSzFSTk1hWnRFNHVZVlQwYVAwa2ovSXdyandz?=
 =?utf-8?B?djBORXl5emRwZXkwMTNlWjBieGp2Uk4zalJOVkQwdDFVemRYYVExdW85bXZv?=
 =?utf-8?B?WVV0UnN4OUI0OFQzV1A0cWpHQUo5UHFsRlZYb2pCZ1FXTCtSSk1SRUhQejN1?=
 =?utf-8?B?MGJybElTTzJrVWFVQVlhcnEvb3hGbVFwWHdlUEVKWWdDa3lJZ3FOaVZGU0l4?=
 =?utf-8?B?b0ViNmYzNlE3aVN1T1FZKytMUHF5YjhYaGdJdzBrcGJMMEFnRlIzQzFpRkRq?=
 =?utf-8?B?VHZoblVxMFd6UlVpa2lYZTkvbDZMQWlVQlQreGhia1hJQTZMaFV0M3Z5Z3Iw?=
 =?utf-8?B?eHJOb2pDQkVvdnRkVDZTSXVkU1FmMTBSMW1yTzEzdzZ3Q25CVWZZNWZMdDVy?=
 =?utf-8?B?TlFtUTlwanA3d3AxSTE3bFc3NlRDTWloQk9McndOamFqWVEyczNNUGR6ZXF5?=
 =?utf-8?B?RDR1b0I1VHBtZWNVYkJJK2JNUTExaU9nVjNaVnFXVzZRUEVCalNpQjlSVEhZ?=
 =?utf-8?B?emtreU44U1ZpQUJDZHF2eEp2d3RKMmlDTk1JdlRJdDdYY1FUc0w5azF2Mk5m?=
 =?utf-8?B?UDk0S21mbnhtZGFWSkJYWm1QYldYdFRWV3dNTnVqVisyNVBiek9ZaDUrZ2c3?=
 =?utf-8?B?aUZ3TkppSm9TQ053aURWQktvdS9qbktWOXNsVlczQ20wL0FPb3B5RUlvOTNR?=
 =?utf-8?B?Y1BqWkVHR09EQnV4VTJJTWQ1U2dSbkUxZ1pnN1FwUVZjZlpSMkVzOUc2S2Qy?=
 =?utf-8?B?eThOSlVWTWp6akE1cWVzenlIMGtZclZyV2gxR1lXUkNBOXZyVXA2R243NFhX?=
 =?utf-8?B?Q1F3MGJ4RUxKeWlIUHh2SUFORmgzUHFyOXNIeHpWL3o5OXFsT0x6dmJsSTR0?=
 =?utf-8?B?S25ZbFlkUkhBWjVyTUVvYktUUHY5ME1XQ0MzYWhOMG9aUVEyKzlOWDVhUi82?=
 =?utf-8?B?blVlSGJaNFM1ODBKekw5QUFKNElySVY0SmJPdHlsTTFibHI4dXdpVjlYRVpH?=
 =?utf-8?B?SnViT3lYdEowZ3IvMURmNFp1eE9jQndzczlDZnc2KzNJWHRMNjU4NFFNTHMw?=
 =?utf-8?B?dkVrcUNwaE81Y3ZJYlJpNjhNalVkK0hHbm5rU3dTd2h5UGZRTVA4dWtpak9X?=
 =?utf-8?B?YkwvMno0UG1tZGpROSsrb3JHaFhPcTR3d2ZnN043ZjRRbGZwY0NGNEMydGdp?=
 =?utf-8?B?Vy9nRXJLaUpWS2FxZGo1a2RXWUNnSyt4dnhCcm0wVXUwVVAxak15YlhvRXBq?=
 =?utf-8?B?akR2a0dodG9LOVFXaDZSTzBUSmdCUWF5dktXaVQrT1NkVFh5czdCSmtoWDBT?=
 =?utf-8?B?QTRTWkRUNjU3d1Awbyt0RDZMU1MzSW54NjJyVG0rZHpaY0w3bkJkVVZ5THlk?=
 =?utf-8?B?WVhGYS8xdzREeDdlYWozSGlhcDVuNXErcGp5L0x1K05TbUNsT2NBdXd3U3Q2?=
 =?utf-8?B?MGJ2VnhzVG9kY1FJaXdDbHNDZHlQN3pFbGxIL1VSVkcrako4ZUk3TktHczAw?=
 =?utf-8?B?YVZqSWxFZnA5OWMza2g5Q3Uxdjg5aEswZzB2Q3hCbFVIQml4cDBzekZvOHNT?=
 =?utf-8?B?bGZiRW51YmtiTUhmcjk3YWhqaFRDUnVqWlp2RWhtS2FrOENUK1NHZDd5cUJp?=
 =?utf-8?B?M1YwTHpCbFQxTFUreVhvaHkzVjdEWHY5RGsyY2hpcVBPZFlyWGdxVS9PUXdo?=
 =?utf-8?B?cGVpMUxIT1cvaFdWVjV5K05Cci8yR2hHZ2pvSHc3NzQyakNoZDN4TTFwaDl0?=
 =?utf-8?B?aHhqa2trNnk2ZkNndS80OU5tOU9Tc3ArMEk4cERPbFlMTHhpTitKNkh6S3BC?=
 =?utf-8?Q?e/RSHeo5lk5YR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJmY09BdjFldDVtUW9oOTg0R3ZveEtSWndzdzJkVzFHcHVvNHB0MDhOcEFM?=
 =?utf-8?B?L3J0VkVOb1Y0NXo1WkpHYXFFTWhxZG1TL2xoNDlVbXpKUDhIZmZJTTZrNURn?=
 =?utf-8?B?SjNBbWI4T1F5WStvcGhsQmVuNHlaenV2Tk5lbUxyc2cweGZ6R3ZpMEMrUEZ2?=
 =?utf-8?B?YUVTbW1EK0V3MnkycHVUSWwvZWw4WDBqT25GSlJCZEdwWThUVlZtdXVOa0Ju?=
 =?utf-8?B?QkVJTWtIY084KzZIV0YxM0xaVlpOQy9heHcwQ3lCbVJxVTc5ZzJDUjVZR0Vx?=
 =?utf-8?B?Z0pOY2s5VjdtU0hhemtmcjBSWU9Fa2g1b1lMMmJ1TDhiZ010WWI1M0FoQ1Nu?=
 =?utf-8?B?NVE5citWaFJWS0VqQkN3VnN3Wm9QNjhuYXZTZEZIYlZpdDNZVnZ4dzVNY0xK?=
 =?utf-8?B?cXN5ZUJOcFQzalRHSnVIa0w2WitzSUZlQ0hKU2V1SDhUTzZudlB1MkxJczlk?=
 =?utf-8?B?ZjJqMmQ1SEVCNlhzQlh4alZJL2g0ajdhVTJheWxXK1pPTGVIR3ZpOERDZ2lC?=
 =?utf-8?B?TFFod0drc2ZZMWd2amNXWVF2VXpKQmJHZUFzb3BqckI4Wlp3UlB2UXZpNCta?=
 =?utf-8?B?TUdBY0lvMkdYT2FrNWJlcUV2WGdyaHQxelVocEp1RW05R3NnY2JEMk0xUGpO?=
 =?utf-8?B?L0JQQThGQnI5czl1TWFaZ04wSGw5aml2NDVQMGV5c1BONXpXMHhXVDVTOW9k?=
 =?utf-8?B?dnk5WHh6bCtrTEFha1hJNnlyZlJ3NmlaN0dGcEJHc21oUnYzdmdNblowTmNO?=
 =?utf-8?B?aWJiUm5BRVpTL0xHRXg0SHFSckFNVnBpSDZTakl0SVY4dnk4YTd5UVRDeTRH?=
 =?utf-8?B?QmQyOWNmbnpQYUhHREc3c0cvS3Z1MlJ2Z2hGVjV4eklEQi9JL1NuOVZmVThY?=
 =?utf-8?B?cVJNRWFLK3B4QnNCWTN1RXIyWGNuNzRWRVRjT2xoYWsyK0RzU3h1Q01FVTVo?=
 =?utf-8?B?aFdmWjltd3daSlFXZUtVdjJ6TGd0WVNjNTdhSlRPaWF6bXRaN09yMVEyQ3NB?=
 =?utf-8?B?TE16Ni94dFRJZ3A4d1BYNEtpamFhWGNubUlONVRuVlNzaTFaNDU5TmtMaXVV?=
 =?utf-8?B?bzJ5VHpJZWsvb2JqcCtIL2lTY3RDMlJYeXdCbDdmTFZlVkFSR0Z1aDZVU2tR?=
 =?utf-8?B?Z0RJQVU5S1N0Skpub0diUHpsL1JrL2YyNmhTRFlFZ2M0QjN0TlZPVTdVS3Z3?=
 =?utf-8?B?dW9TYWdGNVIvQVNhK29GNEpnVWNaSjVOY3RYU1VuQkd5WFlDa2xHZCtGT1JM?=
 =?utf-8?B?L1RrdkY5NEJ1QXBWMEszZGlYSkJhdzlEQTM0ZDBnak5RZUV5UTJBWDVEdkIw?=
 =?utf-8?B?a1liZGZYckFtTE1WK1d5ZVdndkpkLzF0V3Z1cFc0MG1vU2lQcktFbWJvVVB5?=
 =?utf-8?B?c0VyVmRtV0FIK3p5U0RYbTc1dW81RElwYXcwR2QyaU9QcTVZbDNodG5aTTlK?=
 =?utf-8?B?bjJzUlYrRXBGa1AyVER2VTBZS2hveDhjZzZEQlFSWmNKMjExM0JCNEl5UUtj?=
 =?utf-8?B?V3E4VVVxa3BUNWxZa24vbitIajEwT3hKSzJHT0cxWGZYS0dFclF4SVd4dVdx?=
 =?utf-8?B?ekROMXBMSSs2VnVDdDJRYXNPVW14SFI1aGt2V2VNT3ZYcGl3RG9XZ20raUJr?=
 =?utf-8?B?WklOd3VYNzVROWNKK0wwSWJsZkUrNCtnMXhPbmxkZWE2djVyRnR1NXRLa3c2?=
 =?utf-8?B?UEJxc25EUEtrem1TTDZpeWVmTVY4aWdEdW9kT1g3Q2d1VXFmU0d1WTA2WXpL?=
 =?utf-8?B?VlNWeGtpTlJUaXNQZWZNVHJpUXM2UldHbFBtSHZTSlAvN1FsemFwWU0xdUtm?=
 =?utf-8?B?clFZY2lWYjZTWTUycFVITHZrVlhEd0pGOXJzTGZpMU9oQldnamdpMHB2ZGFp?=
 =?utf-8?B?YnJUQ0l2aEsra0pkTW1RTkNGaTFkbmFDeU5jZ2RkVkxhSUdESEpIZE0razdV?=
 =?utf-8?B?R0JwanpydXdWM2Z6ZXJMSUNHdWJxM0NKYnJqb292SEVtQmg1bHJudm9wOVJS?=
 =?utf-8?B?ZGVHZVB5NGp3VEtmb2JrSFBjbFFJUWtDT2c2b2NQQk1pNVp0anZDMmZFYUtq?=
 =?utf-8?B?NzJMUmdjTFZyNDBleGdqV2VIUkphR2Q2VWo0dVc1WFIyelZCbG9uN2xQaUFq?=
 =?utf-8?Q?NjSzF8ibeKcS+fypbRY3L+7M5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6271990d-1c85-43ca-2a7c-08dcd169b9bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:25:20.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8L+QuVC3Q24EI/JEzoQfaCfHRHOnRLUXT967Pi/3/rTg3sxIhdobOu8+fv/0rTICA70fTSVaf/kxBER9jEtfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816


On 9/10/24 07:00, Li, Ming4 wrote:
> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c             | 30 ++++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  6 ++++++
>>   include/linux/cxl/cxl.h            |  2 ++
>>   3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index bf57f081ef8f..9afcdd643866 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>>   
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				&cxlds->capabilities);
>> +	if (!rc) {
>> +		rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, &cxlds->capabilities);
>> +	if (rc)
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +
>> +	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {
>> +		rc = cxl_map_component_regs(&cxlds->reg_map,
>> +					    &cxlds->regs.component,
>> +					    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +		if (rc)
>> +			dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
>> +
> I thought this function should be implemented in efx driver, just like what cxl_pci driver does, because I think it is not a generic setup flow for all CXL type-2 devices.
>

The idea here is to have a single function for discovering the 
registers, both Device and Component registers. If an accel has not all 
of them, as in the sfc case, not a problem with the last changes added.

Keeping with the idea of avoiding an accel driver to manipulate 
cxl_dev_state, this accessor is created.


>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>   			u32 *current_caps)
>>   {
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index bba36cbbab22..fee143e94c1f 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -66,6 +66,12 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err;
>>   	}
>>   
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err;
>> +	}
>> +
>>   	return 0;
>>   err:
>>   	kfree(cxl->cxlds);
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 4a57bf60403d..f2dcba6cdc22 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -5,6 +5,7 @@
>>   #define __CXL_H
>>   
>>   #include <linux/device.h>
>> +#include <linux/pci.h>
>>   
>>   enum cxl_resource {
>>   	CXL_ACCEL_RES_DPA,
>> @@ -50,4 +51,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>   			u32 *current_caps);
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   #endif
>

