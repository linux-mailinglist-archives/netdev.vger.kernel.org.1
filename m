Return-Path: <netdev+bounces-166530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD2A3660F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F227A5452
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2478719884C;
	Fri, 14 Feb 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CUK+oGG1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619B2AF16
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561007; cv=fail; b=CGq7zqXi2j7yfh4CjgB7wmbTnelEVHHQJ6XeO47BDY6g4wMZqJeTe8WbUnFtlX5qNJob4OaoaLS9VrMwpoMpdFicarAQlikLWNm5hHlsZlX0MMvw68OwgVasl4emc86gdvRVygg1+tOBVOqQ8Hrn14mffk3+MJoNfd90Mr92o1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561007; c=relaxed/simple;
	bh=2ykZCZsO46Rt+YShPBf3stjGLnMZ3JFIOaKIv68z0dU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EV5JajZnkxRitDQtLeS4TMqWL0nIaaY8XO/Yy9aY8r4mFX6zFSKkKFMpuj/qdYi9SYTtPmNhViG1lv8tLeq185VMswCs52yQ5LygbwN8KNuhFPLKljA19Ufb0bILLQsV38i1+zde2qk7aZ0xQdl1h0uw8vRDFqzi3sMRRz17Osc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CUK+oGG1; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNgwS1UVHQ65tz+rX23zX/f8kYjy53FaSd5O36/kkfqWQI1LbY7HRdtfv1LrC61URHTOg0CHdujRaTZk80bghyOSHR+m7OKdxvInCYJrmSh++3xB/9OWP+0jqk9nIWeRUdhjJNSxiamBuQvVSwXfbYZHzHazNF2DRO5tEBDtYUG6u2PoKWxyxJPGQAn+/7IHJVxsGdfa6BzM/MouMggiGmvR0eYESZDbYCLKvo/qymGFUQaGLrFZBHkpKdMhfPBsET4xg7iicm0OAL6wyAwbaWilZtfnKlui4YlkYodgmrQYbn+41Qzy2s//HdG/v2NAnU9eluwKlC0dF/+z7Kwp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yso2HbnWtAVrMllEZMWIEhoY/dnQO0fFsCKBxmTt3Io=;
 b=rk4G+LYMxDJiW7LWeLkdv4p5U7UVrt3JT7PBLFL/ku4JHYoLWZ2FMKzhllcWFfhDqFYIrRhw6o5fde/AyVuxshXIlhuuDqdhZDTHoaTLVU8kNwxRMq+yCys4VzvYzNRhb8r8w6yhFqnmJUJsyFv1F6+0JEqtH76R29W4lyfSSmfiPHVg/OTnFWFZBsTsa3mHqyvYAMHiD6T1VDkszbgNa8pU3y7nCkaRykPY3F/OL2gszc7v/lwNvVr9oypmaiu2FEop0p2Gr8iN4oqVZ6hvmmi0QroeooSbwJXjUeOjlfUIgOeCfxeqqCRXOvH15+yloNfF/vGx5tfMGMURgWuAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yso2HbnWtAVrMllEZMWIEhoY/dnQO0fFsCKBxmTt3Io=;
 b=CUK+oGG1qlz5VVmW6fMVsLORozcaVvpLheCcClQwS7J59rYcJfgWVOJa05luZ4Cz9OA2VHFLRG6iUpqwG3aqyR/awiamzoi+kEKvbiFmM7QIy3aIeH9Lw/Oxpqtp1hVwExk5aHMuRb/d1NQEDqZh2L0q4ag+Eg/P9hXstlUSjxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 19:23:23 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 19:23:23 +0000
Message-ID: <40590752-8b6f-49d7-886f-a7408030c121@amd.com>
Date: Fri, 14 Feb 2025 11:23:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] eth: fbnic: Add ethtool support for IRQ
 coalescing
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, sanman.p211993@gmail.com, vadim.fedorenko@linux.dev,
 suhui@nfschina.com, horms@kernel.org, sdf@fomichev.me, jdamato@fastly.com,
 brett.creeley@amd.com, przemyslaw.kitszel@intel.com, colin.i.king@gmail.com,
 kernel-team@meta.com
References: <20250214035037.650291-1-mohsin.bashr@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250214035037.650291-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7a5c94-7178-4f5c-7856-08dd4d2d0bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODBJeDluZGhWRDNYdTBDVEhsNWlscWdOVFFoWE1qaHQ5ZExsTUhsdlZWYnZM?=
 =?utf-8?B?U1BTdkRNZ1YwRlYvckJybGtFSmMxYzNkV2hCeE50S3ZKc1Q0TWpnVnFKUHNu?=
 =?utf-8?B?ZFFOMDlkQ1hIK09xUEh0dXE2MTNMSTQyczBIRE9rNTI5M0hTT0dEZk1VTmpG?=
 =?utf-8?B?c01DTFhBNW51TUxYcEhZV0JGR0M0M245NTNyRnRwdlV0elZJOUJMd3AwTkhH?=
 =?utf-8?B?UTNGWnZLU0NOSW05ZmYxajBIUy9kamhDT0xFVkhSa0Iyb09RSk9MdSs5bmM1?=
 =?utf-8?B?aW1XbHd2MjdXcFl3Q3pBTUFQa3pWMSsxRjJNeXp1VjgyYS9nZ040ZjY4N0hh?=
 =?utf-8?B?YTNqaEhDWDZDdWZhUTJUeVNTaGhtcDBLZmZCTitiRnBEdkNlTE9pdmVTdmVZ?=
 =?utf-8?B?SE11UVFYOHJZNHk0eEZjT1VoS2N5QnZWY0t1eExpUlE4UkZqM0ZkOHdYLzRT?=
 =?utf-8?B?MlhOaDFQYlgxZUF2OUV2VEFCMHNacngzS1ZZQWVOaWd4UjJkVGd1ZEM0ZWE1?=
 =?utf-8?B?azViTTVKL3UrTFpTcHlNS1VVTFk0Q0VwelplK3h1ajIrTVJyZERoS1V1bTFY?=
 =?utf-8?B?MEZ3QVhBbFcxeklOQzZ6a2ZqMDlNZFo3OEEzemxWYmxNTmpYcDVEUzBteUQv?=
 =?utf-8?B?QU5ydVpCaVo2K010Q1ZUeHZiVjBsdVVQVEFjVXV5Z0F6c1hubk5hdnI5NENv?=
 =?utf-8?B?dUFlbWQ5WTBhdjMycXZoVHJoSkVSclR1Qjd1eitCVHBoZjd6a0w0Z2dFMG9x?=
 =?utf-8?B?bnJWQ2JwcXNZSkZjL1VBY1hXZkptS2JudmVZR3lXU1FLdEV1UVVCSWMweEtj?=
 =?utf-8?B?VFJRcmlXVXRlNzlCVm0zU1c3bzVXTWJpaGRrNFJTbkxRRTB3VStoYnN3d0I2?=
 =?utf-8?B?QWlJZktqTGp2dHBXR0dRaEJmTFRVYkdiWWZVQjBLeDRkV1l6alFMdzZLcUJO?=
 =?utf-8?B?bXptbElQL0liVWU4ZXBtcWRtUnd0TERQK2g2anQ2eGhSRm14MzdQbzA3OVk4?=
 =?utf-8?B?ak9hSDdURHp6R2s5SFlqOXEyaVVkdS9DNTNHQnFwMGpGeG1RbUpNSGlmS0l3?=
 =?utf-8?B?NVhoSGovT0NqeXBRZkc1ZFZkelV2QTZMUUQ4MU9SakExQmUxVGJKL1VrR2Zv?=
 =?utf-8?B?dTA4bDRpYzZlTk40QmxPVVhzdFA2SWtYTHhiVVVtcnRBd09QL1BCTm82eEZq?=
 =?utf-8?B?NUkrM1lXNFhlN3dzMWdWMEQrZHQraVZ6UmExSkNXSUdBdHRCdEt2OHN2YzBn?=
 =?utf-8?B?Z2JwMDZrTFJsZndTdHBkM3FsMGVJb2NGekhBRXpOR2pRRitySHpRWFBveVp6?=
 =?utf-8?B?VGcxWVo0Y1F6ZkFqc2c4QVdUa3Nua215TkhtUzNvdHNBUTZ6V2tGVGxqRlg0?=
 =?utf-8?B?Y1NiUTRvbGYzT0lEYlJ2WlVjdmVzT1d4dTVQYjJzY0NncVl4SlFzbktEcnpW?=
 =?utf-8?B?T1JWeVl2TVBmUGxiaEsrMWRkem9BOHI1MFFNSzFta2RVcTEvcmhadC90ZGs3?=
 =?utf-8?B?TWZlZlQwUituSXV4ZmozVmFKYThTbGtVc0ZteCs5MkpyRnEycHVGUnhDYWVw?=
 =?utf-8?B?ekd5YnRheERUM0lNWTJtVmVVMWRVRS9VVFFjZ0hGL3JqWFFXelMvbUtpR3lW?=
 =?utf-8?B?WXdBY2dwNk1mTnkrb01DampWeU5YN0pvcWMyUFNRZWRmVWhGRXo2b0txK3d1?=
 =?utf-8?B?M1BVRVJFTHh6b3pvOFBOQUZIL3JBbzFFcnFldG9mS0ZDMVRacGpseVdrZ2Jh?=
 =?utf-8?B?MFd0ajJ2bER4UHhsSWNiWlUyaThQOWovNDZzcFZzTHluU0dLSVpvclUwM3g4?=
 =?utf-8?B?OWhRRThKOTdZMGp5K3QvOUt5ekhkUlBrMElyZFlweTltd1d6bXVDQVBFWFhN?=
 =?utf-8?Q?260hn3IsYhgZk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdaUm83MnpqRnlVWkRCY1A0WnJ3K2lPbkRtWWx5am5YeVBGWjA4Y2hoRm0v?=
 =?utf-8?B?NVVqdE15UUlJbGpwejdqczlPN1VNOWhVVHM0VklNZi9YSVp6RmY0dHJiUVNC?=
 =?utf-8?B?QWRxNEZESVpOcXg3Ny9Kakd0VFBxajZ5d1oyb3pBYTFFdkcxeDV4aG85ZVo5?=
 =?utf-8?B?T0Z3ditpbDdnRTZtbEJyREFqbVlFRDIvcUNjclZQU3JwYTYzTnpSM2wwWmZG?=
 =?utf-8?B?a3VEZTR3cnZqc3Z6UVJKMUNaNk9CVzAxaDRkL042d0JLNGZtMjBPWXR3RGps?=
 =?utf-8?B?ajkzR2NxVGNYQWQvWldOSmJOWkNoWU8raEd4OGFhdndrT293VUl1MFRJa1Zi?=
 =?utf-8?B?VmIzUTVHWGR2TVB4VGUxYTZMbDRXL29vUzVOcFRaRm9zYTJ5VXZCb1M5OXVj?=
 =?utf-8?B?d2hlT2t0eXVERTJZSFArWTllUnJGUURTU3pBUHQvSGYvTldFeXZGN3dJemEy?=
 =?utf-8?B?VE1sZ2U3Rkt2VHRoV0t5dWdiMmNwUGVRK0ovMlVlU0NpMlF3L1YvRXBIdWgr?=
 =?utf-8?B?UHhBaU0yM3IrNnhTbGZPMnBaS1FBSitYV1RFZlJobjB4bUFaQW8wZ0hieVBO?=
 =?utf-8?B?VFR0MjFFSWZ1TEx4dWFEVThGYjBSTFZscWkzeHlKT2VVREc1SjFVK0hlRDc2?=
 =?utf-8?B?Ry9WMVV5VUExbmp4WHF5Q1dWNkFvd0RiZ2lQUXkrTitzSkJBUkhCdUVtK1JB?=
 =?utf-8?B?cFcrdFQybnFtYlM2Q0M1Snd5dlRvWktKaUhmTFk3TFpVUXN0ZTVFRy9USU9m?=
 =?utf-8?B?Mi96MzVjZ0s5eW5rdmxlcnhwb3pJdXQ3MkdZeXVORnMzV0hxVGhSalB6R2l0?=
 =?utf-8?B?NDZaczJlVzhRWVJoMEJGNHdRWjFvakIzOWNNZUFCb0EvWW9iSWRwOStVY1JL?=
 =?utf-8?B?cVZOTW5mZ0hzcUNBZ1NzY2J0L2pQTFFhYmYrNjJoNmVpelhxNmJRcGF1ZTl3?=
 =?utf-8?B?YklwM0ZZV05QaWVjUTJOYWdkY05uUk9BRElSVUJneHhGWlZCZG1TUkJFdktS?=
 =?utf-8?B?Y1JBSzN4Yk5ldGF6T21RZ3JQNDdhS3RvSkhhMk5IcVdMWWtCTzJsVnZxQmFa?=
 =?utf-8?B?TTRzQ2cway9pajF3NnFISWVvT3Q2eE5YYzF5ZUN2ZFBrZHNMaldxYmdWR3Vz?=
 =?utf-8?B?dXJYNkVVYnhmdVhrbXdVNVBZQXhRTnNqUjhzNXJJMDI3SC9telE1R2xCRzI5?=
 =?utf-8?B?SlhNK1RVOTVLbys0MytGamlQWW40THM2c05PK011azlEaStlN0N3dnk3cTBT?=
 =?utf-8?B?RHZ0SG16N1pjckZITEdqOFp6NWFYSkFuY3JQQkdRTmY3c1pFekZjYXlrYnNs?=
 =?utf-8?B?YjllcllpaHBXSE5KQ1ZML2NuTEkvTmJqU3FkRUw5Q1Q4L1JXaUl2WkNqVytY?=
 =?utf-8?B?SG1zWmEySVBmY1kwVUlXLzNtRDJOK1ZXYmFQd3pEQytDS3ZsM3QxQWJtZUYz?=
 =?utf-8?B?cUsxdzFSQWY0R3V0YVJCL1JnREd5cGRtSEtpRmswdmowRXNEcVA0aHN4OVcv?=
 =?utf-8?B?YTBFOFk3Nlc1T0Nkd295WnhLS0pnVDRDa3NWa1lqYWJ2V3F3U3FSQ3crWXM1?=
 =?utf-8?B?YzVWOUxwMjJxZDBnT3RlUG9qVVBqeTZ5Y2g2VEtxVGdWMk9kamJNR1JmeDVx?=
 =?utf-8?B?NTBDTG1DM1BGWGJCY3QvemduQUhudFNrTnFxOFpSNTVvY2JUSFVyMTdEVnVC?=
 =?utf-8?B?WTJkZ2JSVFJseDQzeG9oRTZVZnQzdkRmMmFuRm1hcE5UMFhHQ1czTEY2K0Zh?=
 =?utf-8?B?S2U0MSt5RmN5WXVOVGMzcVl4QXNRWU9OSUNCMTQ3ZUVRdTdmYmVJZ3N2MFU1?=
 =?utf-8?B?Y2pBdGpwQ2d4ZEZkS2tzaHVpUE9uMHAwdml2VFM4ZDNQZ2hxRkNaTTJSeDdI?=
 =?utf-8?B?N3p1MDlMK2ZZZ0tmUTV0RDc1anVIM0dRYU8xN1ZDQUpoTlBYVmIxYlJtWTdX?=
 =?utf-8?B?d3NPNy9PRGFXUVc3ektHZ01ZbXhEOEJoNnZRR1dQRWpkQ3dvRitKT3NXRllu?=
 =?utf-8?B?Uzd6NVRCaWpkTUJaOEV0MDM4bENhU1E2TER0SzdoR0NtVVZoaFJtSElJYzls?=
 =?utf-8?B?OUhYQy8vUk1Xdk1FQ0dEdDJVd0d4L01vc3BpSlFKQzJ1YUI5eTdndVkwRVAr?=
 =?utf-8?Q?kNbuKOpGm1YAbJ2eeCPhNsh/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a5c94-7178-4f5c-7856-08dd4d2d0bff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:23:22.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unr52ipQDw7F205kXNzXyZFfX9Oierq+ZO4Wa3SQmJ6K8l5D2ZsMII6fSw8bIzz64g7yRKvn3oBYvSsAvmJacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400



On 2/13/2025 7:50 PM, Mohsin Bashir wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add ethtool support to configure the IRQ coalescing behavior. Support
> separate timers for Rx and Tx for time based coalescing. For frame based
> configuration, currently we only support the Rx side.
> 
> The hardware allows configuration of descriptor count instead of frame
> count requiring conversion between the two. We assume 2 descriptors
> per frame, one for the metadata and one for the data segment.
> 
> When rx-frames are not configured, we set the RX descriptor count to
> half the ring size as a fail safe.
> 
> Default configuration:
> ethtool -c eth0 | grep -E "rx-usecs:|tx-usecs:|rx-frames:"
> rx-usecs:       30
> rx-frames:      0
> tx-usecs:       35
> 
> IRQ rate test:
> With single iperf flow we monitor IRQ rate while changing the tx-usesc and
> rx-usecs to high and low values.
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 150 tx-usecs 150
> irq/sec   13k
> irq/sec   14k
> irq/sec   14k
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 10 tx-usecs 10
> irq/sec  27k
> irq/sec  28k
> irq/sec  28k
> 
> Validating the use of extack:
> ethtool -C eth0 rx-frames 16384
> netlink error: fbnic: rx_frames is above device max
> netlink error: Invalid argument
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> V2:
> - Update fbnic_set_coalesce() to use extack to highlight incorrect config
> - Simplify fbnic_config_rx_frames()
> V1: https://lore.kernel.org/netdev/20250212234946.2536116-1-mohsin.bashr@gmail.com
> ---
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 59 +++++++++++++++++++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  6 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 53 ++++++++++++++---
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +
>   6 files changed, 120 insertions(+), 8 deletions(-)
> 

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

<snip>



