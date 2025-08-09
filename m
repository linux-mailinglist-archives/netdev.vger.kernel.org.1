Return-Path: <netdev+bounces-212326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF188B1F45B
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F285676B9
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1F26B2CE;
	Sat,  9 Aug 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ezQQ0AC8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDEA262FE6;
	Sat,  9 Aug 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754738669; cv=fail; b=QpxAz1F6ORefg9W3OrihGH6fScec59Zqddgkonp5BxlUbi7HkfHI35vd8kmdvXgU/5UPp1hGv8/+9gpAAsSlDkJtw2CDjmtCYK3XDWhtQsfJjBWlk7sbvj13izGMcL6vJyP9GUR9EnRlATJEO/1snnzhQZmeK397ADaDmrGjDLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754738669; c=relaxed/simple;
	bh=q7n1/oiCe8Gh4mHByUG4X8cRRNEmTsJC1lQO5t0+9yM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsmT50+gLDkO9Ybq+S38kRONvwsFRSVRGinJYl9jJHw4PvFLyUd767ANgt2hnUj5BTrxWqNTZXn/0ONeEQXqGlWnB1wD8h+Xwo2l+xY2AM0JvlrSkDDnnQWVNd7NYGQXHtEqcxk9sZYo7rFzL7QqwlyRdamltBWHP+Tl9Gp1vpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ezQQ0AC8; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv0CXTX1/nppGIZESiwCccxBoPfEFPuVYlfkJo9wsqho8N3C9Y/37eprwBdHjQHHSn8NLZcjZPtaBeFH5H47wAjYBv2iBBzL3Wrb3KiM1oLJvdJ0DeJSlyS7+K9pWVLfkaHlJ8EvM1UyF3mWkY4oY1+Tg6By0SS6cKHdFEeBKTnn9fyfd0tTF9sM0fpeIvx65IBEhteALsg+OrCGxLL+xEbYMQdkV+UmuNB5UG493AxgIP8qnVta1NpuChnEPdhGT8vMAeMc8TDiKr464mkyHnuXjIKRVbA3HS1gdcS2+wrDFAMcNZtT6IQC9C5f1w6GcMnjMuaoDSYC/yPBcYniYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLOWOdeUX5SELRBAfQ7AOmOoRGMV+sGRfkBoqiLKPZk=;
 b=K3/tonDfJZMsedZWYv4jPryoS0oQIyk4fDjlhdor4ZHNkrWig0PVjMnqw+zmh3UVog0KlamlLae8vIs0Lao8XFN/myyzCAmd9N3ZP/1qu4zoqNGOc7YbMWRs33UWCkh5TwR9WHXHRCElvCC9L6KHc9BpZqWXoiMehK7ZkxUHcZJ4omw/eW1QLRy2ORdhR8Xi9BKwNFz1DeruQ4eNPfACrO4gCOA5WvpTA6E/dO27kIAUNCYCIfIW+yI4dFiE6qGnee7F/WigJZpKuMELEN5NiMj71cER04tYoHyhZxKe1YBKMgdflftHFS1LxA8uS100FvReRNU+dfZBuZ2MIM4+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLOWOdeUX5SELRBAfQ7AOmOoRGMV+sGRfkBoqiLKPZk=;
 b=ezQQ0AC8HwnRpGd7SISoy4/5FhBuvjBJQpNspf5xofGvbWDSbrgCqThyojNPE9IcnJ2G/D8l53am2JS4Y1GEd5CCUQ6N28DDtvwNOqI+ZDhmWSxOJGUFD7kaAGqn9LJyUWJN4wUwPb7qw53f10XaltFxdxatLeClV58a/Pv2mow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 11:24:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 11:24:25 +0000
Message-ID: <0dfb8db1-6c30-45a6-b922-5bbaf26b6eb3@amd.com>
Date: Sat, 9 Aug 2025 12:24:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
Content-Language: en-US
To: dan.j.williams@intel.com, Dave Jiang <dave.jiang@intel.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
 <a548d317-887f-4b95-a911-4178eee92f0f@amd.com>
 <6887b72724173_11968100cb@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6887b72724173_11968100cb@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0500.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5d7158-3e65-408a-f718-08ddd7374c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmFOaEhMNjRXQmdkQUZEL1BuLzZCZW9hMERydDZxMlJHdTUwVE91Ni8zc0ZI?=
 =?utf-8?B?Vk5mMDJiZFpwVGJxN2k3cXM0OEpsTlR0T1dweUFZT2dmSEVkOU9YYnJGdno3?=
 =?utf-8?B?cnF1dTVIMzF4R1lFNU1sYjRMNHg2RkVibDgwSmRDMHFiUDhhRTQzWHZOMEdn?=
 =?utf-8?B?WWhPcHd0NnBOV1IvL1JuVVpReE5PNjFINVlDbm01ZStmaE5WQ0JES0M2TFlh?=
 =?utf-8?B?elBSSmRBc1lHNDNzbUxBTDhYcUZsUTdoc0RoZ0diTjVHY0FORnJ0cHNQd05N?=
 =?utf-8?B?SDV2SDVUS2NPM2x5bnRWZVZldHhlVk14MWlJRTM4bkpHSER0Z1Zkams2M2JK?=
 =?utf-8?B?eG5YeklQRG1oTENRamlnNHVXMDYwbEl3NE9sT2wzd1ZER2l4UG93SktYUitL?=
 =?utf-8?B?c29KYVRxeFVsTG5LbXZ0Sm5saVhqQ2paR2dTKzhna3hsZzJxZDcxUTlPTWQw?=
 =?utf-8?B?NlFxQ1RTNSsvZmd3cEtiOW5RUEhqeFJhNFB5ZG5XVkh4TTY4ZERVVjVwa0ow?=
 =?utf-8?B?cXN2dENXM2dSK2tMNG9lK3QwVWlnMkFHWlN4ck45Z0VLQzIrRkJ4ZXpLOW15?=
 =?utf-8?B?bWpwUEhKNW51em5RaS84UzlRY3k3aVUxZEpQSUNiYWI2U1Yxbk5OdVVDeTVT?=
 =?utf-8?B?ck0vSkszV3pjNFo4UXluczVyb0tkcnZudnhodHNFRHJwZnJiWk5EdE92WEZs?=
 =?utf-8?B?NGhXYzJFNDdFWU1CaVRaM2twM1pEMkZPZ0dUQkhUb1ZrNzJEYndBZU13L0RG?=
 =?utf-8?B?L24rVVd4VnUwZjcxaW43Qjc5N010WlpyT1BKbHZUZEc0TWJFd2RKYWxBVTFj?=
 =?utf-8?B?ZWtsdzZRdVc0TW1yRWhLSFBJVVNVck5hL3k3WHBsNTBBQ1l4Q2dIaEo1TzR0?=
 =?utf-8?B?bG9uOWx1UWVlRmtpZ1dpZnl3c3YxQm5iZVRNRkZOOE1yUXVGaWlrck1ZVS9H?=
 =?utf-8?B?ZVlrV09Icmpyb0FtTzVPYVE3c1MwQlgxTFlsT0crWjk4ZTljMXhGcDBkdTZZ?=
 =?utf-8?B?NVkyNmw0TDZSQlNQZlBkNnZWN2doZVV6TVpWMERzbEs1TUN6cEJXVUI5Q1Qy?=
 =?utf-8?B?R1JCUHFjV0ErNC8xTjVMdEFuMUt3VExveSt0QWNUbS9adjB4d3RQM1FQQVB2?=
 =?utf-8?B?NXdoV2h4NStFRjNyV2ZZdkFGWDhML0ZZQlIrWndvdGV4NmFzYmVsbWY0VEk0?=
 =?utf-8?B?R0JtL2JYOXZQNDQ1dXNOaGlyNjJDcUg2TnVRK3JCTVo5cmszaU0zakdWbmVN?=
 =?utf-8?B?UWJqMWw0aWlLclBjRmp1a2hXaFAxdWF5UEloRE43M25ReURjVVYwQlA0eWJi?=
 =?utf-8?B?cHpLYU1lVWdCUW42WmNWVjFpUkRMVXJ1Z0RxREs0ZHNJQU1DdmUyWTlQQUc1?=
 =?utf-8?B?V3l0RlNnYml2eFFqNElYeHoyNXhMdWFJbU96Q2MyY3dseEpqOU1uMkhqaHRm?=
 =?utf-8?B?K042N0VnaXAwMzNOWEdBQnNvNlI1Y2Rhajlzd0N6eTcrSndBaDVBUXZPYXM2?=
 =?utf-8?B?MmNsU3ZOVEdIaTk5NnBBTko3RURUdFV2UWpRbXdRYXhBM3lic3o5TUZmVVA4?=
 =?utf-8?B?cnUxSzdJQ1VWdGpqVDJIWENBaXJDdFViVDVsVXhzQzBvbTR1UkwvK1dyYmFU?=
 =?utf-8?B?L2dQajNpMFF2dmJ4S3VOa0RFMGYvT1ErSVRpSngzd0dFM3k5YmZxU2xsSlA5?=
 =?utf-8?B?MXZMRElQRVpWaXJuWFJtaDhtajVWdTBzWno2WmZlazNUOWpSNzdHcmhpZTNB?=
 =?utf-8?B?UnNPeVJYRENuWlFmNFpzU1VGZlhpM1ZCUlZkVjY1N2h3WVVRTDZiMHhqMlRu?=
 =?utf-8?B?bUZpek10cEQzTkFYTjNhUzV3NjNwc0NtbFZ5dlZ0dWdDVTFCTzlBbEJzQkli?=
 =?utf-8?B?azJab2FObkZCOUJPaEQwa2lkTVN1WFQxWEZxdDJJYjZaVUZTZitjdzFwdVlD?=
 =?utf-8?B?NHJpcDF5N2ZYcTY5dC9PK213Y1pFMmJaZm1CSnpIYlFrRVIwMERBQXQveXJ0?=
 =?utf-8?B?bUN4ZVd3Zk5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1Bb1BwMWk4TlpBaUVPVEg2Nk9PcHdTaFU1dUZTSVR4eWptT1B3bVdTbzdD?=
 =?utf-8?B?K2wxajRnd3AwS2NoK2EvMm1wL20rUlBZOXcwRGQxVmozQXdwM2EyQ2F1ZllS?=
 =?utf-8?B?ZC9SYW5jLzl2UW10SUI5T1dtNXZCbmtZS0owamxKKytmWmF4cW0vNmlqdlFO?=
 =?utf-8?B?UmpQWlJPdS9tVjZJTm1tVmFMQnRDQWV1bzVXWEtSVmhnMXVPdDRnZW1zRlZm?=
 =?utf-8?B?bURIeEtudFRGYUxqbCtXRThkc1lpN3kyd2tSeHNVdGkrT2hyUmZGSzY1dFF5?=
 =?utf-8?B?b3pkcDduSmFqVVZqNmR2clVOQUlVSlBxWTNHc2dSVkNtNXdPSmpraXkzWEhx?=
 =?utf-8?B?aFZpZXlnbDkrZVZ3d3NNRHFad0hLYnE5YXV6MlBYWkxxQU4zV0VaOUtIRFBl?=
 =?utf-8?B?UmpjUU1kd0dlTWtLMUZ6dzVMU1p4azVSOGRPY3dLL2YxRkp0KzZKSi9OQ3NP?=
 =?utf-8?B?ZkJsNlY3RXNFaEpNUEpwNHgxTVBmZWZEa0NwTy9YRGtPYXZPdkZCbVJlTkw5?=
 =?utf-8?B?Rm96Nm5QTjBHY3RoRFJIT3c1TGM5M0xmeUQ4UnN0VWI2ekJjWGZ1WEsrTEgz?=
 =?utf-8?B?ZC9rL2FQL2tOM250d3ZHQWtQcWF0QVFOZ0R3a2MxUERqUUxlU3kyUVFTSk5i?=
 =?utf-8?B?SWtUZXhHWDRnMXlFdlNCb2dTK1N1ZjJDZDhpOUhhZ3J2d3IvUzJWSDdRTlV5?=
 =?utf-8?B?ODU0UzBKam0yZWJOUklFeXAzdVdKYkduNWMwSnQ0WkM5N1g5S2dCYjNiN2p4?=
 =?utf-8?B?ODZnUERzd0lBL0RjbTdYVGtEanhrRDBYeElEN3hmZDNKeXo3c2E1MCszcTFF?=
 =?utf-8?B?RmNtbDdmVGlzcVozdmNZcDVDZXVBelNLelhKVzdNcW50cUM3RS9jVU1CUHVi?=
 =?utf-8?B?eUVXOFV0UTFhMUJQZEZObk1MYjlsbkZkYmlISFRTZjl3QllwRkFoL1hGN3JI?=
 =?utf-8?B?RUtCWnNLa053TEJJNGNLb3VDZm9IMVIrekN4SnFOVlRrSGxHQUdNTmVhZ1N2?=
 =?utf-8?B?eDlWYVFNb29EL0hGYnR0VUZIUldnYXJnc0FBdm9jamlQK0ZnV2NyNTNtMEZs?=
 =?utf-8?B?WkFuanRkaXhRdW00V1JMcHN1Q2tMYmp2aU5FL2p5Vkhsb2Q0T3VRYjM3Sjh3?=
 =?utf-8?B?blFyZ25DenF4SG5HTk5xZS9scUE4NXBZQlg5SHNoWmpxTDN2M244dXZkVk9G?=
 =?utf-8?B?MHpNZmdqQ3FXM3ZGdmIwY0NaUG1UbHhRNldxK1ZGVk1mWDJydXZRM2pBeVMr?=
 =?utf-8?B?RUhWUHZKNDFyUWxIUDZ0aUVDSDQxUk90YnVHdytWVFJ2eHh2d3NvZm9EVU5C?=
 =?utf-8?B?dTZmUGg5cjZWMDZEZGRHME16bWhEUXVzSlFMdXp4MjVwblRpM2o0SlB6aCtI?=
 =?utf-8?B?dGM1eTF3ZjNTWE5OWE5TNG9IVmFIRHh2N1ZUMkpPZGIzd013c0VMeGRhTGRW?=
 =?utf-8?B?eG1NRVlDVmJaWm1DVHM2QUJFdStpRmlMR3FxRUFlYmUvREhERWJxOW1WU2Fm?=
 =?utf-8?B?NktuTkZLT2kvT3g3MjFPbUJOUGY3b0tzYmhRZ1ZON095eHVlV3hMRG9TU3A4?=
 =?utf-8?B?K3VRNjZqQUZRYnVXcWxNWDFXc3BickxYT3I1aHk4UmZ0Mk1nODh2aWNaMTJz?=
 =?utf-8?B?dFB6UzJWaUE5ZE92RS80TFFtSy96Y3FSVmorZm14U3d2bXowTHJMNnpQYTVy?=
 =?utf-8?B?YWRpMSs2ZHNzdG12NzB6d3l2N3l6WnBaVU4yNjV0bVVpOFhZaGwvUThIaTA3?=
 =?utf-8?B?aTRLTml4Wmdrd0l6UDY5NGlNbG1HT04yaEU5Ti8wOThpSUNXSFFnN2I0UDdM?=
 =?utf-8?B?UU5MZWxtb0ZKVWFRR3pkVUpQajdCaUcxUzdGeENHV2NBdWw0SHA1RkRFUWps?=
 =?utf-8?B?cnAzL0U5OGNobWhCOGxOdWFxdWFIb0poaldrK3FueE96UkJKZnRpUStOc2oy?=
 =?utf-8?B?K1d4Ymw5UlYwQy80T2duWW9MM2lHb1FaVlRFZ0NtaThFVjZpcThTTUxKTW9B?=
 =?utf-8?B?TXIxVlJ6dWluNm5kWTAwY2gwSzlpNzlBTmdVbmp2VnhucExyWjRMWjFTRTdH?=
 =?utf-8?B?UGx5Qk1ocGZrQkYyVXcwUkxpSWFRc0F3Q01VazJOVmEvOFE3Q1FtOUk1YW9P?=
 =?utf-8?Q?R0iM3iv/3k85BNymqqSYAB59u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d7158-3e65-408a-f718-08ddd7374c12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 11:24:25.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KucCRylVklWIyoj14eAQPlU3s6z5RVYgyesNki6nF4suJ0EW1jGbpi1qjCZ20RQX+GhyJH1W53g33AF1m27jGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994


On 7/28/25 18:45, dan.j.williams@intel.com wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>> Can you please explain how the accelerator driver init path is
>>> different in this instance that it requires cxl_mem driver to defer
>>> probing? Currently with a type3, the cxl_acpi driver will setup the
>>> CXL root, hostbridges and PCI root ports. At that point the memdev
>>> driver will enumerate the rest of the ports and attempt to establish
>>> the hierarchy. However if cxl_acpi is not done, the mem probe will
>>> fail. But, the cxl_acpi probe will trigger a re-probe sequence at
>>> the end when it is done. At that point, the mem probe should
>>> discover all the necessary ports if things are correct. If the
>>> accelerator init path is different, can we introduce some
>>> documentation to explain the difference?
> The biggest difference is that devm_cxl_add_memdev() is "hopeful" in the
> cxl_pci case. I.e. cxl_pci_probe() does not fail is the memory device it
> registered does not ever pass cxl_mem_probe().
>
> Accelerators are different. They want to know that the CXL side of the
> house is up and running before enabling driver features that depend on
> it. They also want to safely teardown driver functionality if CXL
> capabilities disappear.
>
> cxl_pci does not know or care if or when cxl_mem::probe() succeeds and
> cxl_mem::remove() is invoked.
>
>>> Also, it seems as long as port topology is not found, it will always
>>> go to deferred probing. At what point do we conclude that things may
>>> be missing/broken and we need to fail?
> Right, at some point the driver needs to give up on CXL ever arriving.
>
>   
>> Hi Dave,
>>
>>
>> The patch commit comes from Dan's original one, so I'm afraid I can not
>> explain it better myself.
>>
>>
>> I added this patch again after Dan suggesting with cxl_acquire_endpoint
>> the initialization by a Type2 can obtain some protection against cxl_mem
>> or cxl_acpi being removed. I added later protection or handling against
>> this by the sfc driver after initialization. So this is the main reason
>> for this patch at least to me.
>>
>>
>> Regarding the goal from the original patch, being honest, I can not see
>> the cxl_acpi problem, although I'm not saying it does not exist. But it
>> is quite confusing to me and as I said in another patch regarding probe
>> deferral, supporting that option would add complexity to the current sfc
>> driver probing. If there exists another workaround for avoiding it, that
>> would be the way I prefer to follow.
> The problem is how to handle the "CXL device in PCIe-only mode" problem.
> Even with a CXL endpoint directly attached to a CXL host there is no
> guarantee that the device trains the link in CXL mode. So in addition to
> the software-dynamic problems of module loading and asynchronous driver
> bind/unbind, there is this hardware-dynamic problem.


OK, but I think this is easy to do and before reaching this point of the 
driver cxl initialization. In fact, the sfc driver checks for dvsec to 
be there as the first step for cxl initialization and doing nothing else 
if not there. This can be changed to check for the CXL.io being in place 
and not legacy pcie.


>
> I am losing my nerve with the cxl_acquire_endpoint() approach. Now that
> I see how this driver tried to use it and the questions it generated, it
> pushes too much complexity to leaf drivers. In the end, I want to
> (inspired by faux_device) get to the point where the caller can assume
> that successful devm_cxl_add_memdev() means that CXL is operational and
> any non-interleaved CXL regions have finished auto-assembly/creation.


OK


>
> To get there this needs Terry's patches that set pdev->is_cxl on all
> ancestor devices in order to make a determination that the hardware-CXL
> link is up before going to flush software CXL-link establishment.


I have commented to that and if extended to check the CXL.io status, 
easy to add here, but I do not think that needs anything else. I do not 
mean your changes for making this easier to use by leaf drivers not 
needed, but I think you will address there a different issue and a more 
complex one.

>> Adding documentation about all this would definitely help, even without
>> the Type2 case.
> I would ask that you help Terry get the protocol error handling series
> in shape as part of the dependency here is to make sure that there is a
> capable error model for CXL link events.


Sure. I'll help as much as possible there. I did review some parts in 
previous versions, mainly those I have the proper understanding, but 
I'll try to review all through the next days.


>
> Meanwhile, I am going to rework devm_cxl_add_memdev() to make it report
> when CXL port arrival is deferred, permanently failed, or successful.


Already studying those changes.


Thanks!


