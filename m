Return-Path: <netdev+bounces-124109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1C968131
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34851F21E7E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8817C9A3;
	Mon,  2 Sep 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRHMW1NB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0233987;
	Mon,  2 Sep 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264033; cv=fail; b=Ixp+ldCdqW0yGGcbeXg6JshIqNKNL4DqvXCtvzuU46VeTtNII9RC1XHiI75+aH8pI0cI3tNx5PMfDj55QP81OJync/eO139ST7eegxxPEsmQrSe2jFXEG2/ym6FqPC+VuaNbVUztmnRIUdeb/BOcn3uJZtwHg92rtNx9PRAmptU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264033; c=relaxed/simple;
	bh=6VBNMXv/+YReNTxyXxLhJh8Zwpwz+149rn/wE/H+5ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lWPQ+0agoDoh9/GcKmdxlP1MDG9Xq6ycK4I09uEYCqk6Qmbe77z/M/qqaEYdiXqO0LckrmUR8Wp0dZJJ/dpD8jVTVa4F4FSOGQdZWlfjYbLbYbL66sNg1ronCy3prsAvHyfgd5AHFfaLGMUAMXzYPmjqTuE/7cGPdmO4xiWdzww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRHMW1NB; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nomvFanwecazca4O+fnZXUgG1jokF6WDqPreGOc3ykvQpJjS73KC2avFJoRBk23qZsUp0QE/hmoeTMvuz5n479GYUmHgllQE97RvzhXfBFyH258UNCPwx1UhAN16X40vJafqhh19AwIKhFrjwuXT+szqnOHCU1ui1c0g7N9k1t4je8u7gYI2+cuLgrzxEp8RhSTG8Oppr9qV1uXeYtJTUmq+wU0GR2heYFasvU8SRO0jYlmBRQX/jtv4qCiUAYmOXP0mnHp9D8sdRnMSYznKyu9aARb+xduPikn1NGwnmbLfG2YSQr5B4f229PRVAVupoSBYEGyURQ6SB0DbKTWGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP5MEGrGMIh8ntNhrniuScyiiTyzVXDRgtxhu2HrPiU=;
 b=BmoCf0tV8LzjoMvwZEgPpgT7nxpggk0hKIpD8gffXrwpxvglgfmipMAVhkd6pOSm6K8G5rsHaOUVSsZPPfPRJ5RURxCxrkU2BHAd7xqKj81h387fccAW6+KMPW8/o+/2cBfJuo2YJORJl2aHc5CqzSnsWf5iVrovyOXZOyoY+RuvQOqcG6qBJz9wlnCe+6beGAGoKZaQYABktNVv5aSRuyeOAapr9x+0IF8c+kLm2y7LPQQo6eDsEnukDvnWLjxkHiZtxh4gIa33qw4ApLzrGtuAPW0ZKvck4nlagBc2Ly+u+fudbr75kzuU/HmFxzDVes6OaE8RSlGH3rxnKG+I3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP5MEGrGMIh8ntNhrniuScyiiTyzVXDRgtxhu2HrPiU=;
 b=TRHMW1NBoZQiIa6N2IL0idCz03KwH4vwnYWo2gobyMJK4wkFGMTHIUh0ugzKFkcm6Jl5JAvKPioh28ncV2iKhB1LL/SDtB1jhncdmmI1Hmy/qgvBEPo5wNJ8jl2ud4Wj6QlAvrkw4VSlXzyJ4d2VVWoxKhHEyaXw42tA+hGSvYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:00:26 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7918.019; Mon, 2 Sep 2024
 08:00:25 +0000
Message-ID: <ab847257-6851-10ba-0b0d-78351275e001@amd.com>
Date: Mon, 2 Sep 2024 09:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Shen Lichuan <shenlichuan@vivo.com>,
 habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240828100044.53870-1-shenlichuan@vivo.com>
 <6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
 <63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
 <20240828160132.5553cb1a@kernel.org>
 <4fe03d79-d66e-d33a-b5c6-4010f8bdff40@amd.com>
 <20240829080922.254736cd@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240829080922.254736cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fea3ad5-aa79-4fb0-c87a-08dccb254d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJUMHI4bFNTNit5SmFXcEtlanNVTTB1UHNDRXpuZlp4U1hBSUVUYmRUbnBl?=
 =?utf-8?B?K1pBdzFFSUw3ZElDNzAwVFZOc0VFMlFBTTJIeGJGZER3UTFnbjU4ek55Z0pT?=
 =?utf-8?B?NWIySE5ISllzVzExRVV2RFYwUkhIK3JocGkwUVRxcWMrbTVBcFlyTTdvcTRI?=
 =?utf-8?B?Q0VSQ2doUllMbWdpUFhqdVBIVjRxM0tpMWNzTitTOVd2VEp6RlkyOHRYUVZQ?=
 =?utf-8?B?Z1RUQklvZktRekx3MGxuUEJUNjdOSUo0NkZYc09kc0ZCNXJGT3ZSaVdheW1S?=
 =?utf-8?B?TDJWZCtyb1ZpL08zSmdhWFNrNWRpVU1Xd2o4bWcrUFZNcy93MlFiOWRLNTVC?=
 =?utf-8?B?ZTd1Q051RFROSmRnSXVDTnhacjdJdFRDSmFjVDZwU3BxUXphemtROGJBbFEz?=
 =?utf-8?B?NWloclhtNEZTZXNBMWRvUnBHQkV0T2FRYzJSNkpHTUdaSStzVXZDbTlodGZQ?=
 =?utf-8?B?RURYYzRKWWszWkgrakhKeGdxVE1xMGpzQ29FTFhMUDhOcTFtYTZzck1uNlZu?=
 =?utf-8?B?SWhsZWxqRGk0YWdNQTd3dWI5Y0UydjBhdGpuNWExdEFNZjFhQ0taemhVQTZQ?=
 =?utf-8?B?VS9FWVRPUE9TYTJHMzJMUlFFUXlCd1Nva2QwUFlNOHJXM3JMUW04Sm41ZFpY?=
 =?utf-8?B?QnVhd2diUUlFMTFJVUR0QzBTK3g5ZWU1amR4N0lPai9tcHFxWHRvSVRvSm1P?=
 =?utf-8?B?QmtFRlo3d24vVDJhV28rYkxSWEQ4aEJuUnBvZjlTMnNoVVFXYnFUalR3SmJY?=
 =?utf-8?B?YjFHRHp4TUxaZ2pBb1pSdjNWdmFuaGpvb0lvNjJFSEdCUGJzTUx1TGcrNEhM?=
 =?utf-8?B?eHE2aWJEdU1PUktRUmF2ZzI0dUlLWU0xNWlMVms1MElKZmM2WmZjdC9LMzBv?=
 =?utf-8?B?bU0vS3J4eWRVdnpyQi9DUzljSXc5UkFLTzQ1N1NVZ0k5dmdUSEl1R0pEQWFv?=
 =?utf-8?B?WkRrQVlqYUtjbW1Ka0NlMGxKWHNGdEZ0Z3Ywcm1JZzAxZjgrTGUxSDlvMERB?=
 =?utf-8?B?bDFZQWxVUUhMNE5GYkk1N0dEWXVJUUdvSmpLMlo4azc3UERpNEFkWmp1bTlh?=
 =?utf-8?B?ck5BV3FXRVNjVFVzZFVHUFBRUWo0aTZoN0ZxeE1qdmgwK2tZbFlNTzl1b3Fp?=
 =?utf-8?B?bFhxYnJSY09hNE44MEF2S1dQNDEra04wVW81dTFhQ25EbmI0ZDFoWjNCZGN4?=
 =?utf-8?B?VUFQeW1wVjd1ZmxJUmo4MDR4R2xGckF2TDEvMEZaZHNQcGZtZ0ZsWnBVaXRp?=
 =?utf-8?B?V0R4N2h1elFyNU51VDZFaE1IUm9ZYkJ0UWZnSXIyYmh6MUc1UkQ3emRXc0th?=
 =?utf-8?B?d0t4bEhjV0p2UEJVNnIrUlhpbjA1REQ4ZDlDSFJHbVNJdDZUNHROR25yejRE?=
 =?utf-8?B?dndKb3FSOFArTE9uQ29yK1Q0WlFwVGFyTXdyNDFhQkNqSktvcWhmUlA4b0dX?=
 =?utf-8?B?MXFEWFBoTjdSK0gzZnAvb2hYMjRjd2prN0VGd3VTUEp4SXdGMGI3dGdaSW5J?=
 =?utf-8?B?NS96UVo5Z2VZY0g5dGszR242OHdQdHRvU25MVS9abGJkRHhKOTJxdkxhWGRT?=
 =?utf-8?B?aGhwVDFVS1dMdUxTemZVTTdISndjYWRjdTFrbUZqWGowVEtYTmdpREkrY0Fa?=
 =?utf-8?B?Y1l6UUJrZzdUV1BWMFJkd05lWjIwNDhsZmk1dFVocFBuQnFXMWU2blpvSmxM?=
 =?utf-8?B?ZHVCS3IxVk44UEVoc3ZqRzZORi90aWNjSnhOR2xDZE9tY0FKSjhTcjczTm91?=
 =?utf-8?B?L3VNV0FuWUhqQ1p0bXJHYkhBY3I3VEFQd0pBMGlya2lWcEtUbkVxOUdhMGI1?=
 =?utf-8?B?NWZyZUw0Q1pISWRzRzBDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OThuYWlPZ3laWStJcGl3KzA4SXI0TEhVMHE5U0JpbnNxbG9oWXlTSFAzRFJM?=
 =?utf-8?B?b2V2aTREaHZibHh5eFdmREVyaDZwcys2NUxTSTJyNkRQaUFLYWU4TzUva0tM?=
 =?utf-8?B?NFR3enpRdWtpNklVTk8wbVZURVBZVVY0UmV6dXBHWHZxU09oOExZVnBCVEhG?=
 =?utf-8?B?aEFHdnlYZFl0MHg0U1E0YnQ4NDQ2aFM2OW54dlhCOVBqYitvRnRvVWVmZGNh?=
 =?utf-8?B?TVJ3SnEzcmxVZkVrSE15WjZDcnpCblNRVFh0YUMvQUo0UmhacVZxYUg2Y1pz?=
 =?utf-8?B?ZFVoRlhYa3BBWkJjK3NVbTNGWnRscHYwbkVSRlFOcmQ1MUdSWGNTZWd3UmFr?=
 =?utf-8?B?dEthaXJSTEVGWFF1TERJNWtEWmxqa0Y0NHREWnM3SElZdW1rMWN4K0UzMjRG?=
 =?utf-8?B?aDduM0lSY0dCQmJ0dFRZYy8rZDFzTkxEM3pGWlp4TUx2blM3SGs2ZmJ5aEZB?=
 =?utf-8?B?bldCREliSklyTVVUZHcyRE5kOUYyM1NlMG1od3lRYm8zaXdzTXFkWkpBMVZ3?=
 =?utf-8?B?biswRURXMFFtMWdBUldRUU9vZW5iZ1ZBSHlFVzRCemlUdTkwdmpveG9BNWtw?=
 =?utf-8?B?TW1oTXYzYjJQUUF6VVBVQk1CenFJUGphY2R5cUM1TU4vR2c5VEIyUFkrUDMv?=
 =?utf-8?B?L2pIVVhCL0d6L054Rm9vM3BteWZxczNQZnY4bTFyMXBUVEg1cG1lZXU3Um5k?=
 =?utf-8?B?eGpzZVV0c2E4WUljdng4Nk5nbm1BRDdYWUV3cldKMUFRQ3lxRVdGbVo5YkNo?=
 =?utf-8?B?Z09NeTFOQ3J1RDYrLzVEQ0UwNlFyVDFNY3R4KzdxalF5TWRvZnNmNXZVNDEy?=
 =?utf-8?B?TXBkUVhxSkFTeWwxM2t3aTRjaUk1emlGNUhZQVUxVkRVbUlUUFR0UlRLN0NO?=
 =?utf-8?B?M2FHeHlTWjFidWcwUDlyNUd0MFFhSFZXbmJrcE9jemZZU05uU09vd0tYQzF1?=
 =?utf-8?B?UEREVlVtSTdHdHNGSlNTdGo5UmN2bWo5VG9WTFE0NTRWZDRwc1dmTGIwUExU?=
 =?utf-8?B?TzJCbEl2MzNQTys0Q3pZYVQ2bTZ3OFdGWTVhc29ucmNTb09lTFQ5T2Z2WWpk?=
 =?utf-8?B?Ti9iOGx6MFMyUW1DcHFuUW9xTGJPM0FPWG83R05XbFJFcnpJYXhXblMxaEc5?=
 =?utf-8?B?Rm5Za2JSRjR3QjEva2oxT2k1OGdPTzFZNnNqcnFmMUV2TUR4ZHA4TWVxenhQ?=
 =?utf-8?B?V2x4a3ZBN3dlWlNRVXgvZ1ZIS05wQ0JlNXB4dW9yREtvOEVrU3pYYm5JRHJC?=
 =?utf-8?B?L0JUcGhGNXltbndvcy9GZmszd2tjalpyakRzWndNT3dXNW9iTXpBTHAwRmNC?=
 =?utf-8?B?N3FFeFo4dk5OY1FvaXBSTCtOYnN4dWM5cDNKRXRwZHd5dU5iRnU0NElCSUY0?=
 =?utf-8?B?SWtmOVlVUzQ3TG5sTWZnWmFKa0Vwc2FlcFU3NndFbVYva3B6MWVtbmJoN2Rs?=
 =?utf-8?B?dnlaSUY1eldWVmJGR3hZMmVqSEdqNnJDNUNVY2VKZk1BdHFYcHhGL1VRVXRV?=
 =?utf-8?B?WFZsNVZQdStqYWhlZzNMZEFTZGVWdG0xZUgyRi9rZnQyUFJjRFgwREFkczZp?=
 =?utf-8?B?TElIVW9wdXcxOGxHcWVhTDlWS1Q1Y3ZjLzgwT2x2a3dOeERxQnBuZTJXSU1X?=
 =?utf-8?B?N1pSYzgwZGs5eE9XeTczOW84VnVnM3RkWkovZXNxTG9CZW1waHpSNnhJZFR6?=
 =?utf-8?B?dzNKd09pbDhnMk1mMENxRXllSFlNZHN3VHNHZjF3eDNKQVdpVko4OGRJc0R6?=
 =?utf-8?B?a2szOVJJQ3ExcTUrQldpWFdJdWw5U0xYcUEzQ2p1RVI5NXcwNExsNXM3NFBa?=
 =?utf-8?B?QUhUWXZMS3JyWTNPcnl2ZzBRN25Gb1dOOHAweGlHRGh3NG83M2ZIL2pJU1Nw?=
 =?utf-8?B?Snk3TnY4WjdQZlQ2QmxqaVFxNlFEaGQrMHp0UGtMNGpSbkpET0xjbVJoazJ0?=
 =?utf-8?B?eElsc0dQQjFLR3p4Rko5TkR1b0hpclNqNXE3SG9xS1c5NUNTaXpmek5zVjB4?=
 =?utf-8?B?NjkzOFZCQXl0alRBWkN1Y3RpaHVTdDgwcHFhdHlDSm9WdzVvTm9Bd2VrRG5M?=
 =?utf-8?B?R0lJVXE0TjdvTUhRc0YzZmVtbmNLZlY5bElRcDJodmhiZ1lyWXdzWjVIT1hC?=
 =?utf-8?Q?WjqHYSMhsVAvapyWUwQZ8EjiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea3ad5-aa79-4fb0-c87a-08dccb254d53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:00:25.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH+absoOAGjFJTRgavB3/q8m9LzsPmzvZNkgG1LC3r2nyitg64M/dvm1iQyEix1KPxHmWU88fkue30nISOJwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446


On 8/29/24 16:09, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 07:47:34 +0100 Alejandro Lucero Palau wrote:
>> On 8/29/24 00:01, Jakub Kicinski wrote:
>>> On Wed, 28 Aug 2024 15:31:08 -0700 Jacob Keller wrote:
>>>> Somewhat unrelated but you could cleanup some of the confusion by using
>>>> __free(kfree) annotation from <linux/cleanup.h> to avoid needing to
>>>> manually free ctr in error paths, and just use return_ptr() return the
>>>> value at the end.
>>> Please don't send people towards __free(). In general, but especially as
>>> part of random cleanups.
>> Could you explain why or point to a discussion about it?
> It was discussed multiple times on the list and various community calls,
> someone was supposed to document it but didn't. So I guess I should...


I have seen your quick reaction with the cleanup.h guidance patch.

Honestly, I have never been comfortable with some of the automatic 
cleanup approaches ...


Thank you!




