Return-Path: <netdev+bounces-192253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78352ABF1FA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B144E1A66
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976125FA07;
	Wed, 21 May 2025 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vyPwzMlV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88325F99F;
	Wed, 21 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824297; cv=fail; b=QGDw24U8NNlIRzLVGyhNHnyNP8b1yYPO3iR7dvEUi4fXWAKy9B+fMu56T13Hcixl3eW3uHcZ+S+mThlqecA/dBLd1BH4aaGCX3C2A/pfxtpbhEJIlHTca6juEZENVFZxuyYeM/h2peBWpn5qHGy0TboE8Y4ZLW1BIJKhxb9fXk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824297; c=relaxed/simple;
	bh=cpuBFFWSJZW4aa3nvMcqV+0g+1knnUYc5SFS2jm5GYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKSlSHTs0hOsKxzXa4oteb/2cqcZOYX99e+zpnOxQKtZbOmgf6U4Plzs2y+F0BU17LuZ7JjgvW+Qmjr2Q65zXMxC7OYojZL65R3NesXWNJUvVUKwYEIRt4hQGPlB+x9BA9dvvnUOUvmurnHph9A+zI/23FbPt4MrFiXIh5td1kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vyPwzMlV; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAS7VLoRfASTyDnHIPOIJIJOz13kPjmDOyxVbwKRO0HRVWj94oxtZ7Z00MYQxB80YVPMruG2ZGDsqQoB1RqW6gZ3PKS4qJ2O1gHpf0IUXz3a5oizwPk5cl+qJW+QYlZuXxTH+SVoHatmK5A5Pvub7h8ZZ7FESyySIy6PUDxW3ArQGBFF+pejppllEu9bfDe30N7xVxDLfflP7DpMErk0SAuiZMohd0jvq7848K+C7CbEuru0+8XnlbTSZoLcQOD2EbUG0/9Yv0QfI2T32Q6VUrloHh36oGjxFNZoAVEIj7uP2iYmS+rRONnhF2TQ59PKvRpHrwGzjYErPhijd2r5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBxeCs3jDj2rGXSCYiAy/bXRnYmmKtK75TMTTCpctfQ=;
 b=fCJZ7orKUk2Nt9z1EK1h/UK7Lo6oPIpEWBdg1/ffQd6cEXy4NWnwf5iegE794mOHwftNW10HfjsYxIAOmFfDF+D10RXfoYlX7lbbt6dDF37HRJ4DPBqBhVypQZQ/mvpbGWDMARUhhGwJQgDfcEzlcf9Gmyfozkvgt/JDZBZczdWVu1LBPuTGtvPkzPrafgSfSpzyMDvPTVbeQPsY9wmXGcfeZ/NrgSCXXgSlaNmclRlfmRgjwtBhw5spz7J4EqFIBDLAfnIahSZKYRlWPXs9eW45TCtvjFh/nEs+YGAh91v0pef+xAu47F+MGAplEWWay1CfZQAxV9iYmfdanoEKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBxeCs3jDj2rGXSCYiAy/bXRnYmmKtK75TMTTCpctfQ=;
 b=vyPwzMlV4r+2l1pewcyvJK/3ruLGejzm11QlAJLC0B4fxhjRV6JLDYc3HFcI750Por/SGyajVNUMVaDWTi0JqmeHsdhyRedWjjRdg7rrygQI1YoaPXBq2ULzlpJmL4Of5MLN0TN0sXXizGJIk4LzyKaCFa/It51A3c3NtQoWfww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 10:44:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:44:52 +0000
Message-ID: <10546cf5-c348-47db-bef7-4bfeeca6cd40@amd.com>
Date: Wed, 21 May 2025 11:44:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
 <682c2c6f8398_2b1610050@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682c2c6f8398_2b1610050@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f5547c-6c4d-4837-9fb5-08dd98548483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzgyVnF1YWVoZzY1dGdMSlI1TkRDWXRVbm1IV0kxNFUyMFlYZ3oyYkhjTjBR?=
 =?utf-8?B?OWJKQ2gwczlKWHAvQy93QXVGUVZ4a3ZtTmhUL3BNeVdXdGMyZ0Jqcis5Ly9Z?=
 =?utf-8?B?SmNCUXB3YWVyZEJqNlM3c0JVa3U0bGpXdStTMGQ3ZjFjaklrbjFQeldMN1or?=
 =?utf-8?B?c2t1MzNFS05XaU94c3RNL1I1Ri9hK2RJVDhSQ0JxeEFPa2hzSkd4S3hUTFEv?=
 =?utf-8?B?Q1lQN29zZW9mQ1hmY0M1Q2lIbTZncEFSK0t0RnM3LzliaGhBUnhUOXMzS2E5?=
 =?utf-8?B?TmF6bittSzZlckZVcUxqSW42MGNVWmk3WlhrNWxWSmRyemY3aExVOGhlUlMv?=
 =?utf-8?B?Vk9DTVRFS1U2dHVUQkx3WjY2d1BKMC9CR0h0d2NhT0NraEVPMVNxOSs2UGdO?=
 =?utf-8?B?ck5tZzRyV2pVS0tLdzJoZk5YUFdiZU5FMHFsaDVKR1JGSm9FbHlRSVpya2xt?=
 =?utf-8?B?TGdmNkdJKytjclp4d0xQV09ySlBabTNzWGVyVStTczFsSThuVWJYSERmaUh6?=
 =?utf-8?B?ODV5RG96Q0Z0VjNwc3BQOU9KSzBXY1h5ZTJWeHhDd2xPejJCOXJPeEtmdnZP?=
 =?utf-8?B?ZEM3NHBCTjlFOVUxMTJzU2dGVHFoVWhTdmhIR2ovNHFPT0RWWHhyWHF5S25O?=
 =?utf-8?B?bzQyMXFiRGRvaUJsZ1hkNFAzcFB5T0lBUThVM01oYSs5RXVURnJnYzNLSTdT?=
 =?utf-8?B?d3J5V1dDamppOThnS2ZRY2kvNzRZOUNlOFl0MWJyWUVOY0lQeXNtOUYyOHhq?=
 =?utf-8?B?SHRzemxBdnFHeUhuaUwzZGExSkFEKzNzS29iU0E1OUFqSzdsbVBhYVBmLzdn?=
 =?utf-8?B?RTFuZkV1RmNqVm5KWkdlSUNSVEhhcnczVFZUd3hyN0E1b3EyTXg1QlVIUll1?=
 =?utf-8?B?THpZcEVNbGQvNUVvWkNqVTNybHJuMC96bkgvN1RBWGE4c0cxR1p3Wld3dnh1?=
 =?utf-8?B?Rm11UU12L2lGYnhpcGwxMzN1TGxsSm81NGVqa05PbXl0WlVwWjVkYkg0NXMv?=
 =?utf-8?B?MUk1Vk83MTRBQkRFWnhvNDVNZnpNTE1yYWh0dEFzU0I1b01IRzZKMWQ4aFV3?=
 =?utf-8?B?MUFaMExlVDNlTWxheVJFMFRZcXhFWjYreGw3dFdmWTNWMFJIOW5NeStET04w?=
 =?utf-8?B?SUZ2aHMzL05GSFVkK2djNXZBd0ZVUjVlRlc4SVlPQVpxeE0wTzQ3emo5K3Rz?=
 =?utf-8?B?NEJSNjE2WjM0ZzIwVXF0NjZWTDJpWDdNRndoeGd5OEtDM1V6Ym9nOFY0cVhh?=
 =?utf-8?B?RHYyR2JJNkg0UEdWYWZRNis2c1h2aGs2Mi9nRjZZR1dGUFhPMlQrUExhWVA3?=
 =?utf-8?B?WGN5emxZZDZQZ2RuN0M0NVh6U3g5R2RZUFdvSDB4SGhEbHlqM00xdEl2dmwy?=
 =?utf-8?B?V3BzWnBoa09HcXVXQkFsclMxT3RBNGlXSktUeCtGUkpPRnJRcUZJMXpFZE5Q?=
 =?utf-8?B?WTQ1Y3E4NlkrZC9zYUxkVG9ORUNYd2dtTThCeVN5L2JKdlJIUk51MFRXSFVQ?=
 =?utf-8?B?d3dTQ3MrbmQ1SVBuQVlmYjRpNGI2Zmh5akozRDEzYlBBaC8wc2JlbHRheEtV?=
 =?utf-8?B?UHI4a2V5NFlpeC9DTGg0b1hoTHVBNmdhOWZUcXlzYUZUZHczZ250RmFSNXZP?=
 =?utf-8?B?VTZTYWptQ3hKaGp3QkducS94dnBaUy9USzU4VmdvWU40T3hDODZlWlFwSXZr?=
 =?utf-8?B?bUdUZ2o0aDZJUTc4MDJyb2QyK0NMUHFFZ1dFZXAyMnV4T3NBUmFCZE4wSTBk?=
 =?utf-8?B?N3UyaEVtMXBpWmRGcVFHdzZyZGRPSDBWWGdTN1llb2YzWWY1NlRuRGJNei8v?=
 =?utf-8?B?U0ZWd0xMdDFkSVlVYTB4TmxTMGRBMkJTdWE5ak9oakwyV3ROdTMwYmFOTFVS?=
 =?utf-8?B?YWtzVGUxcUN1TXppYmJqbElkcC9Iemg1bHV4aUZ2SW9DWE91VFlSRCtmYTBR?=
 =?utf-8?B?WllkcFRRbHNnd0w2ZGV3T3kyVnlTaUZQTGlXTVVFQ2JEb2ZmVGVBR3d4OU9q?=
 =?utf-8?B?TWE4UmFqRTdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktpOTBuaGptZE1BWHR1SWZPbWh5TExuVm5JeVZiM1ovU1d4ZHEzQVhCczBK?=
 =?utf-8?B?TVRyaEJlUWtvUUNFOTNGU1BiMjNtZUc2NFZRMXJFeDVWeWN2R1J0c3JUdzN5?=
 =?utf-8?B?ZFBlaGgxSHFxVUNqSS9hZ09sY1ZJS2k2NktCMFVyNHN4blQ1TmE3QXdpWldT?=
 =?utf-8?B?Ynl0OUpmL1lxeEhPL3dwSkdtZEl4aTVLcW54WE12MTVNVE8rNzFwOEp3eFJ0?=
 =?utf-8?B?K1ZiaWtWUC96TWgxVXNZcG95NFlmK2VkY1NrNlJqelQrM29RaDV5WXhKeFlQ?=
 =?utf-8?B?T1l6djFqQU8vckVkNFR6ZlVTODB0czZmcThkSnBKKzZUc1JZLzZKTXpEYUdt?=
 =?utf-8?B?bjNDdVhHak9HNHlJVUtzSDBnV1cyRjZhZ1V5cW1NS0lMa1dvWW5kUk5rOHh6?=
 =?utf-8?B?ZHo5NXM5aXR2UEM4RnppeUk2M0VzcUpvVFFjWnRVSFBuUGJJS05NQjg2TGVC?=
 =?utf-8?B?cDl0OWpQTEg0aWFvY2E1RFNONmtUMEJzS28zWkJ6a1dYcjBKWlJmZGYrMG5E?=
 =?utf-8?B?MlZqbnJCRE5SaFlOU0pURzBWMnZ6KzNEYVA0eXNEZHJVdlFzNUR6TGQ1S0My?=
 =?utf-8?B?UVF4NzFpbk5sVG5wcGp6WlMzdmxGekdMeUM2SlpEalhoMjE1eVNlMmpDY1Uv?=
 =?utf-8?B?OUcvK1Z1RlE0SGdoMlBWWlc1YmZZOGVPTXM3MTNSK1F3MWQvM1QrSHMzRTVy?=
 =?utf-8?B?YmM5V1dIdlRkOWJPNXFkMlZSMCtlQjZ3NlJuR3I1SWNkcHV6WWZLU0NrSHgw?=
 =?utf-8?B?aGxaLzNOR3BlYzQxL1ZPeUM5YTRGQnRhVitnMVk4SytzSE5OMkwzdjNtTlp3?=
 =?utf-8?B?SjV1SUFtNk1sM2tpUEZrbUZpNzJISm55V1c3YVlZdWw2cGdpMHNvZ2FpdEYx?=
 =?utf-8?B?TmllbFJDdThsZ1RsU1hnTXBlSHhOUVFrLzEzT3o2eDJ6QlhSUDJBQ0Fwbi9T?=
 =?utf-8?B?TUlRZmxITlZNWGFMUmFYemJLeEhXUGp3MHF6RU52TzhxVlppOU15ZDhhNnZ3?=
 =?utf-8?B?K1NhQ1h2N1FMWDRrOW96dllHR1Rnd3FIMUIyTkhGcWpNYkFZTmx3UHB4a2Fy?=
 =?utf-8?B?M1VNbUcyWHhzMkFmOHJtSTErSFhYSWdhejFkcks2SkhSeFk2anVoM010RStO?=
 =?utf-8?B?c3FheTNGbVM3U1NPZE5lR2tkcW8xU2MzNUxWUU9RcjAzMC9XYURLZlBCcXRQ?=
 =?utf-8?B?TFRqZ3JyTWhGRnN3K2xVVkxxOThlZzRraEtSdGQ0VEpzMFBVOWMwYnhVKzhE?=
 =?utf-8?B?YWRYRlZhZHR6UnRQQ3J4VldyYVZPcmhqc2NqdlpwNFd4VVYydVEyY09hSG9a?=
 =?utf-8?B?cnpaS3hWYzZSbHdHRjlmQkpCcm5mbFh2eXZHaWVwRDE1cmpiYnZWQlhUMVRH?=
 =?utf-8?B?SHpGbHROYmtLS2c2M09GSWJLMXBSdU8yN2tZbXJOTFNadEVnYitNemZtejkv?=
 =?utf-8?B?SVp6dDRmQVFzUjE0WDNRWktFeGdWZjNCMDdRY0RnS3lYQSsyVTVrRTMydWlO?=
 =?utf-8?B?WmloVjRXMVFPckV5TnhianFRS1N3emdCdEE5YUcyQllDcm9Sa3dOZGRvUXhZ?=
 =?utf-8?B?UkplN1lLRCt1REZDdngyMGNCVEQ5U3hVcEZGcjNXbnBqMkpCQUtGWm90ZGNR?=
 =?utf-8?B?dU1KYm5XbWIvbE03QkZIajRxYnhtaWxlbmdZZUFsWXpDTnZaMVNJWWRQa3Zt?=
 =?utf-8?B?a1BMTnE5b2U1VFFUc1Zld2tnZ2hBWjQ1TDFtUXBaRkZ5dDEyMmtKNEJGTmIy?=
 =?utf-8?B?dnNjdWtvVHNpTDYyWkNHdi9VZ25xWGsrWXVCTGZsby80bkdTaThzSTRuTkNX?=
 =?utf-8?B?dGt6NFM1QWQ0SmRaYy9MbjFHc0VsdGNyOXlMbDl6QlNLQjVZWTlyTFJ3bmha?=
 =?utf-8?B?UkVsYUpmWlU4KzQvNUY1MEptZW5pU0F4eUt6aTFrTmlKN1ZpNFB1bC81UXNr?=
 =?utf-8?B?TmE5WHVXOUROazRBbFRDSlFtanp5YldtWWdZUnZvaHg4a0EzOTQrYlY1alRt?=
 =?utf-8?B?YURML0xobVgvNUZoUFU5bFVybnAvU2JDUGNnUjJ0TS9JdzdZMlFmQTYycXMr?=
 =?utf-8?B?a0QxUXFrRk5kT1Fwa2c1QWd6ckFtR3B6dVRmbVg5dUVscVBMdXVManFmYity?=
 =?utf-8?Q?3QFx7uyjRW8Oahs8tLr1vMeOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f5547c-6c4d-4837-9fb5-08dd98548483
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:44:52.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXwIQONa70xn7i4YtUS2b9HRiK9bdRmv7nIHPka/NnauK3Ybhj8Zcibua0bS1ayB7+CfD6a6+qpIsJIQ9Bicpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007


On 5/20/25 08:17, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/mbox.c      |  11 +-
>>   drivers/cxl/core/memdev.c    |  32 +++++
>>   drivers/cxl/core/pci.c       |   1 +
>>   drivers/cxl/core/regs.c      |   1 +
>>   drivers/cxl/cxl.h            |  97 +--------------
>>   drivers/cxl/cxlmem.h         |  88 +-------------
>>   drivers/cxl/cxlpci.h         |  21 ----
>>   drivers/cxl/pci.c            |  17 +--
>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h            |  23 ++++
>>   tools/testing/cxl/test/mem.c |   3 +-
>>   11 files changed, 305 insertions(+), 215 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d72764056ce6..ab994d459f46 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1484,23 +1484,20 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
>>   {
>>   	struct cxl_memdev_state *mds;
>>   	int rc;
>>   
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	mds = cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
>> +				   struct cxl_memdev_state, cxlds, true);
> Existing cxl_memdev_state_create() callers expect that any state
> allocation is managed by devres.
>
> It is ok to make cxl_memdev_state_create() manually allocate, but then
> you still need to take care of existing caller expectations.


I'm surprised to see this. I think the expectation was the 
cxl_dev_state_create to be managed by devres, and somehow it ended up 
without it.


I think the best option here is to add it. I do not think it needs any 
special action but just the freeing of that memory.


>>   	if (!mds) {
>>   		dev_err(dev, "No memory available\n");
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
>>   	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.cxl_mbox.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>   
>>   	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
> Ugh, but this function is now confused as some resources are devm, and
> some are manual alloc. this is a bit of a mess. Like why does this need
> to dev_warn() every boot on MCE-less archs like ARM64?
>
> I was trying to keep the incremental fixup small, but this makes it
> bigger, and likely means we need to clean this up before this patch.
>
> Ugh2, looks like this current arrangment will cause a NULL pointer
> de-reference if an MCE fires between cxl_memdev_state_create() and
> devm_cxl_add_memdev().
>
> Ugh3, looks like the MCE is registered once per memdev, but triggers
> memory_failure() once per spa match. That really wants to be registered
> once per-region.
>
> That whole situation needs a rethink, but for now make the other
> cleanups a TODO.


I can do those TODOs but I do not think that is relevant for the patch. 
I mean, you have discovered a problem there but this patch is not 
introducing the problem, AFAIK.


>
>>   	if (rc == -EOPNOTSUPP)
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index a16a5886d40a..6cc732aeb9de 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -633,6 +633,38 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
>> +			enum cxl_devtype type, u64 serial, u16 dvsec,
>> +			bool has_mbox)
> As far as I can see this can be static as _cxl_dev_state_create() is the
> only caller in this whole series. Fixup included below:


Sure.


>> +{
>> +	*cxlds = (struct cxl_dev_state) {
>> +		.dev = dev,
>> +		.type = type,
>> +		.serial = serial,
>> +		.cxl_dvsec = dvsec,
>> +		.reg_map.host = dev,
>> +		.reg_map.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	if (has_mbox)
>> +		cxlds->cxl_mbox.host = dev;
>> +}
>> +
>> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>> +					    enum cxl_devtype type, u64 serial,
>> +					    u16 dvsec, size_t size,
>> +					    bool has_mbox)
>> +{
>> +	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
>> +
>> +	if (!cxlds)
>> +		return NULL;
>> +
>> +	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
>> +	return_ptr(cxlds);
> This function is so simple, there is no need to use scope-based cleanup.
>

OK. I'll do so.

Thanks!


