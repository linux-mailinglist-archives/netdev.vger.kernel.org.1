Return-Path: <netdev+bounces-163621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E8A2AF5B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D11614CF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840E18A6BA;
	Thu,  6 Feb 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OHgR0Tz3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77B16DC3C;
	Thu,  6 Feb 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864263; cv=fail; b=DvKNgl5+4h5EEuJDBW9SuG/4lvVKQJf0KwFjzehKrruEONX+XPw4jzXyNmZ++rRvixXq7DYxLlekWYvEuJSYg3eYpG7JNv7HTLqC64DlG1rvLMIws5sJtWayhnPfjyyYLOAKralEmQj+QpLP48UHzTe7iPQgSMXyP/BKd6XDpqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864263; c=relaxed/simple;
	bh=o8XWoivpLoo8sX3WeFaRJR6pETaJ/4zPDiIE8uviRXA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLooDbglHtfBKZ+1H6+isK6dr35u5sqwXqkNagea8WzFZFmoRTUuGdb5W0HgEUoIVyYffC2LmVMH0uzOjxWWKT1/kQabHdJz+1e4JOxoB37HOvuOstFTI3FYUJqlLXIM2Hy4pNIxN7vWvK9CMLPPiwDCqwcgGl1RuvPXuONxaFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OHgR0Tz3; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMpUaP+PgYrVDfQofStxYoNdNXPFWvffwUAaR8B+CqFaxXv/0p4lBkC9tz/wfnZig6OZE5dn3zMAYI1ZDry+qYZXgqR4DxpqP83hQWjiC9HJloaQmciYCQq1IpXkTna+djhhv4f+aD8hDpJsHNlr3s6naYm77QeWrLIR/nAL77OjmkuhVvDfh15jHNEtp5Y+qYFQ9KuRQYHcC8AgF+BfevDVO69YpvQIyQTAHPhTPRNBmlgktp3//TnYDFspNNcCQLoBkg0khcxhehSdKWryf30jUt4cye/wtb/yc8E9ywt3SKtEZiEh8jjU5ILVV+BAN6StUm5tjKvfdPC4bZh2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDanq9yVClr1pucAJTOm3k2NNXcVSKJUtNOTQzZBMOk=;
 b=LHecYiy3CTFKF4hBMevi9OyoG292INFNlgFpdSfGv4wMDzK3omAmD3B5uHG1GTtODIGvKcJF+OFGCa/J3zSXu/vh4fH0JaFifYizBGa39E7+PS1A+shbRsGvyJqfCGSaBDQ7+HeHjeuYPYofz5xMPH7lQ6ds0jUeJpa+A+GIrKmkIFy2/xvx7zNJ9/Sxm8WeK7eyPGdgG+XekuhkBKL011q/FMjAfzLGKMAAut2GB0vBg+seLKJC5h0acfCTd7v/UQKOAfI8fzhC7E+9e+iECqNMVKcKebWonXxPPdp1Sdvmf++kJtPZ2kbp6MqgLewdZTPg8vW1xFDwYdCOzBcdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDanq9yVClr1pucAJTOm3k2NNXcVSKJUtNOTQzZBMOk=;
 b=OHgR0Tz3TORdCLRza4Kj8lrXbOV8HaaEkHO0ByO7en/bF5HYWLhluGnxaXyQ3D2J+Ew6DInM4wkyBg92Qu1cbxjn0rpPV3mID3Dz9cfIn5GiyBx/FcoR0SLO9PuUVOVleKFyeYZil9HrRTEC7rfx3DmENk5+HtdvTjC2hF+W5Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:50:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:50:58 +0000
Message-ID: <3cb382e2-2ed0-41f9-976b-e5037a65dddb@amd.com>
Date: Thu, 6 Feb 2025 17:50:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/26] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-6-alucerop@amd.com>
 <67a3d99f6af20_2ee2752948a@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3d99f6af20_2ee2752948a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0058.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: afef33e9-2f23-43ee-c991-08dd46d6d00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1gzcGhMRVhqMXFTeEc4cERFUllXQ1pqaXVzb3FWVklxTTJiWmFqT1JZOXRt?=
 =?utf-8?B?RXJ6WitLc3h2MTZuVzQwSWNKUHB1aUJYUVhPUlVxS1lxY1N3eUNZam90M3Z4?=
 =?utf-8?B?MmNabmZ6WUExZzc3NDZRRUg2RmtvNUxQenZieHRrZkRBRzl1dUhZOTBQUjJz?=
 =?utf-8?B?Qkpka3dyRXNqQkdBZUtrbGo1T1pQZnp1QXl3Z0w4dGtjMjNhU2lFSGJudGFK?=
 =?utf-8?B?MW9DUEpzdHJZNGcrbTZpbmlxSVpiaU9Cb0gyMTdSSzZtVzlPVXVZOU1ZTkd6?=
 =?utf-8?B?dVpIMGNuS2tyWGtiZ2dud2o4MmNNQmM3cDdOOW45WXd5Sm52T1BSN01CRmVu?=
 =?utf-8?B?K2hpOHVnQ29EbDZEaEc2UzhOSHJqZ3FFOXA5TzFPdTFMZ1hGRXNwRS9LVFVV?=
 =?utf-8?B?MzdMSmMzZnNVdnpmOGZWamFPREJBcm1lYldjbUlocjU1RFFycFQvdzlBVnVn?=
 =?utf-8?B?U0dLTGw4b1ArUjBmV25Sc0h5QW5BdWFaclIzaFhnRll2ZmxkeEhObzFudDVV?=
 =?utf-8?B?dnpaOWhJbTN2Y0hBeXl4c2c5bzlCM1pxTnFHRk5SWFY0Z2VFRWtPdnc5UGFN?=
 =?utf-8?B?ZjJ5Q282bFFlUEpkeURqMmV3S25xMUVGTG1MNDBOOFNoZVBmSnBvMWN5YXZX?=
 =?utf-8?B?V0FmYmR2MW80N3pOTHR2OVVnUi9ZeElIR2d0bkFrNk1zZ2RCekpzQ3dtR05p?=
 =?utf-8?B?cm4wM0ZDdzltTWoveU1jWkZQNmIwb1ZwVzUrRElvby9IRTdrZDd0MHdES3Np?=
 =?utf-8?B?aDU3ME4waVBGU3g4THQ4TWxadjNEYjdHMW1KVVY0Q0RCNGQ5YU95REI4VzBa?=
 =?utf-8?B?RmJBUk45dHBtWnBzN3BvR1hKME1CcWZzUHpRT0dyQTgrTDhZYWp4WnJod1Ay?=
 =?utf-8?B?bStHTnBkRkJweXlNWVRDMkdpTGJUWDJmQ1RoYjJ2QjVEL3Y4OHdEWEtVYWZR?=
 =?utf-8?B?ZmlFTmpBc2g5aGRaYzI1OGtsQTBrTFIweEhKRlVTWGNIaUZkWm5nQ2VOM2lH?=
 =?utf-8?B?UGtZSmtiZGV2NnFGTXkyeWx5NDJxWC9zUEN3Yk1vMFgwTEh4Z3JBTjdZQWJV?=
 =?utf-8?B?L1g3OGNCekRPeU9mdWxGRmxuSUVXUFZ4Vlo5M042aFcxMS9SVkZhdDVvMzNz?=
 =?utf-8?B?b1dOY1NPSkdyN2NPNlVQN0hjRHNmcTl2T2NmWmRIQ1AzVjBSU0hlU1RBdE5S?=
 =?utf-8?B?OU8rOUJQakdnT3A2Ky9FOUJ2WUxudUUyMXpRVFhaYzVoNnRlQkFaZ3grdTNJ?=
 =?utf-8?B?d0V1Q3hVMzV3SVJLWExwbGlBUmt2TkloYnNyU0UxZFpuR20yV1JaeG9SVm5Z?=
 =?utf-8?B?Snd5SGhXUXpnVmxMTnFwMEpSZUFWSTlMNGN2cTZNdTFwRzdMSUMyb0NNc0pn?=
 =?utf-8?B?ejBxVGhXUldaZ3pxeEFpVDN3MnF3dS90c1hPMkZMWVpqNnlVdHNLTGhNY1JX?=
 =?utf-8?B?U05PVkxLaGZBYlRjL1JoeGpxYWxPRVEwaHJKUy9hODNOVGl5cGZtY3p5Yldt?=
 =?utf-8?B?Mm00YlFYdGhpNi9KdlU1SnBHTE5VRmRGV050TXNqbS9FNVBqbldoQk1WdElR?=
 =?utf-8?B?aFhjYVA0dFU3NEI3WlcwdlNrZU93Qy9RNklFSEZwa2xOTExtV1hYZDlweE50?=
 =?utf-8?B?YWhIakcwL25tZWcraXhYQ0NyUjJuOTVta3JjQW1pVTNVQkExV0lwYzFOdHpi?=
 =?utf-8?B?SEd0K3RiU3ZjeWhGVWxmNk5tbXJmVUhWUy8vaDQ4NWgzVDhHUmNvMmZrY2Zy?=
 =?utf-8?B?VjhMeStHMkdWUU90ck9PQkVVSmxhN0p2cmF1L3p1akIvZHJRUmxxN3BHU3dC?=
 =?utf-8?B?VjgxSnVROUhLVGRuMUtRVGg0MlB4WG8yYVlwUWFwS1lHS05VeEc1dHZWb0RB?=
 =?utf-8?B?RWp3TEpZZEZvNUJSL2tsVVlUd0NCWFRyL1BZQXRFZW1wNVRLOG94cnoySk0v?=
 =?utf-8?Q?ABUKgdgHxDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWU2cTJHOVo1SGV1dmxUUDNWUmFwK3JGS2VpQnJyWUQ1bkxkVU1NKzAzc1ls?=
 =?utf-8?B?VUc1SUVzNW9CVVZhcE9QSHFKSHVneHJSTmtaSEhVU0JWSlVDeDRTN09ORFRo?=
 =?utf-8?B?dXBIR3oyeHNja25TTkFob0FVSThHWE11bjkwbkZmc1ZVTXVCYXB4MmtWem13?=
 =?utf-8?B?bTBNd1E5YmIyRnNORUxWMGg0Rmd6bU9lYUJtUFg0OElOQ1RCSlJXY3Z6VDBK?=
 =?utf-8?B?TGxGajYveEcyWVN2SzZ2SkdZS0F6Q1VFbDJVVzVXM1p3ejFkbUlOdFRJR2Zj?=
 =?utf-8?B?MEZSYUdMM0NvYi9OeFM0NXk3ZUI4MHM1SDk2STZMQ1o5c1RValJvcExJcis0?=
 =?utf-8?B?WFc5ZkcwMzc4V0hZa2Z4T0U0Nk11NU8vTmRaaWZ4OXV6dUVLLzlxZ24vTjdz?=
 =?utf-8?B?RE5rZ05aTGttNjNVQ28yQU5acGxFNGh1VkFLekZPR2hrMk9GZytacWdzQlA2?=
 =?utf-8?B?bDhoYWxKTGxqcTRFSW9Ndi9UemZkY3FVeW5JakNOeitvbU5wSjVpeG9aTVNv?=
 =?utf-8?B?OUl2QTd3ZWVJZnE3WThPL0JYdVZsMisvOHlBUjJPemgyREcwNzdyR2ptZFgv?=
 =?utf-8?B?OUNZWnlWNXJoWVJRQ2FkU2pQaW02dHQwN0svQVZaZWM2WGxVMUVpQzhjWVE3?=
 =?utf-8?B?QmJGRXJJSHBlWlNFMDhvb1VlZ0FXaGw2ZHlrclVNU0t0eURJZFlCMTB3VllW?=
 =?utf-8?B?bjlzeWNwWXdPaVJkM003MGNWUlVWejk2MGluWFhBZTh2RjZ2R0psbE5VbjNV?=
 =?utf-8?B?SkVBTEFYSnBhd2h3eGhqUFAyRnEreHhTQ1RaOUFjMDBzaEhETGJ6MXBLRGVv?=
 =?utf-8?B?SXNkc0ttUUVvM0Q1c2FhM1I0UzhaZlRHN0lGZk5rVEdSaU9VRUFYb21HUjNI?=
 =?utf-8?B?d2hoY0RYa0ZaUFF4ZjltR1pFaGNEWDZqSDRZbDJEVlFMK1ViTU00UDJIK1VF?=
 =?utf-8?B?YUNSZnphTWlsQ0tBcWtUbkVoOGx5VHAramY4WWZaVGZCZmVPcWdyM3RyK3lv?=
 =?utf-8?B?Um1SV1dEMFBuSmx2ZlV1RFppN3VSNjZ1eWVncC9zdTdoSWNWenBub1dsTGxX?=
 =?utf-8?B?SUxlUHQ1ZVROS1U0SGVpL2cwbTZucGcxQTRtSzgvQ2ZMaFZWTjFuc1VtbHZt?=
 =?utf-8?B?VXNPNXUrWCtmeEZudkh4UXRxM3QxSG0rRi9qcndrRlpDdmdxZUx1OWRtYm1m?=
 =?utf-8?B?c3ZZTXNtL0dmTGtZRVlZMjhpTjZaNGJyWTBlbjVHRnZldWo0dklMSENha0xn?=
 =?utf-8?B?ME5EQlRZVmk4K3pkZE5raG96ZlQwbXBzQVZxdzI3aFVnNkFkU2JNZDAyWXdU?=
 =?utf-8?B?RjRTeWFRWjZtK0ZnblAzb3NDNWwwTXV4dmcyTHNTVG9lY013ZWdoNk9YOFlM?=
 =?utf-8?B?bEJSM2hBRHhpSnJacEs3S3N4bnJZWTlmWTB0UzUrNzlPR3lROG1jZzZlRzVm?=
 =?utf-8?B?TEZhWTBkUUlnWWt2MjZGbllrVHlFMGhyRWIvOVdqQTF2SzJxSmw1eWtrdTg4?=
 =?utf-8?B?djcyeGRTeE8wRk1IZkZHME40YjZ5cWtmWUtpODdoak9xOVBENERRTDJXYUsw?=
 =?utf-8?B?S0p5UFZCdWVCR1BvQ0t0SXJVZ2t6OUNxTFNmSDJ3S25DOUFNS1lzV3JON3lQ?=
 =?utf-8?B?ZDU5NzZIV3cyM2JKZDJvSTJqZ1pRWEVYWHlyRmJCeXhmem9vR3M5RjBjWGVC?=
 =?utf-8?B?UUhJdVJTaGl4WmFnM2V6VFhSVVlBbkFWMys0ajU3eXNEYXoxZjJ6eXprdGcv?=
 =?utf-8?B?Nkl4SWZ0eWxIZkFCdHZEZmhOZG9Sd20xQWZaVldTRFROMHJVZjczZTZwdk9n?=
 =?utf-8?B?R0RlbmhrRHBwNmxKczhVYjN0QnNMVXdPQjMreFd3YXhmOFo2bW1YSVVmclAr?=
 =?utf-8?B?K21VVkdYMkQxMVE4dDQ0WWd4ZEoyYlIxVWp1NWV6Y2xCcVlqaDF6SitzVnRK?=
 =?utf-8?B?c3pUb1lGNTUydkpkWEcraDBOT1lLK0hEcUFicktOZ1FlSExVZ0RxeCtsekk5?=
 =?utf-8?B?ZEh3RWYwRE82emsxVGZhYnMraytwMzZLMitWeFkvY0RLOVdEVWRWWWpmc0JI?=
 =?utf-8?B?ZGN1a00xSFJndlp3cm0xVFpnWXc3SHJBOVhubWFISnpCcUV1UUREQU1zc3U2?=
 =?utf-8?Q?8bOFp/Z2cqgH2I/Cq2lTKvQRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afef33e9-2f23-43ee-c991-08dd46d6d00d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:50:58.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqCGlSnBJCKSuxc8v00WK2whUgWvxc/A+7HVciUJncmB5D3NcgVCUkyxrHq+52jzDaWMebjcwzuAU4Y7uGj0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220


On 2/5/25 21:35, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
> [snip]
>
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlmds,
>> +			      unsigned long *caps)
>> +{
>> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
> Isn't it odd that cxl_memdev_state is passed here only to be turned into
> what you really need, cxl_dev_state?
>
> Ira
>
>
> [snip]


Yes. The only explanation is to keep calls in the accel API orthogonal 
always using cxl_memdev_state now.


The interesting part comes later in other of your reviews.



