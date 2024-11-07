Return-Path: <netdev+bounces-143044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDC9C0F48
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906E01C227A2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2C21731F;
	Thu,  7 Nov 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="viZIPhdC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5947E782;
	Thu,  7 Nov 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008870; cv=fail; b=DgGGtZGJCNVqQUONZ3WbySZNBzmGEGETlaLZvI6cAaEIfNat9P83iViiEn8e1fknLfweJZ2G0h1BlqESyKfUDm6zVsSeIv5OhSwAyMufFVE8PZT06s6t4HCfVfbt1o/Jg5xuFMC8KsDm/S1vBFMWZU7rtJ4A9fKmFwlYSWwFAlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008870; c=relaxed/simple;
	bh=cKqwArC9n9BsPusgXEKItr3ZGslI2tKR4U/2gtb8m6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUAbzoWF9ydgczWm2bmdqJyCZtkpQjw085jiE9Xyy8DL+L0G0vUOlEcRVvxY0ZaXyjK2EtlV/CS8ziGWumnQUimuDEbQmoR9uxkPQiYtfG7W9K7Jfy+zsdIfpbfRYw4CItZMn6bfGMAvgG1Q21f7M4+FBWpjLWl8kdOc0buUufQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=viZIPhdC; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQbOdvbaxowsLH9AjV1SodFs0WMXNjrK1zron3dPomr5XyMUPa9S1X4C3SUmWzmtMYudq6FLXz+rdMV64GGa3PdrXHgFiAVutaaQv0k8Sv4+AbJJnHjRQueJRKmTvAO70DvkrcfofRVI6hu8D9eHf5QpFK9yyHNKI4h2OXtQXlgt2bCKS9AHXanbkQuC1QwoUjLzuY/w+1+cWRy3wcwzcIDtuq5+1dtyjXW3I5eZ9AeP47jKE3mc0z41/O4p+9G4C2Ahh9VssVQmvUg/Qk45xj5xGGzfrzFaOFV7Y9vRepIwdxeBwjGh0mm6CwbvehDZrC0k/LcjbK8ODi0gPdlm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bg0TgaGphRXM6yqo+dJ5hf2emZT2DPIegyPtmTc6vE=;
 b=oJavkVdspfzYjmIRfQfER7b+KOten8FCS925mq/W+hMaLFgnjI737zDaH/3sZhlqmCO9I8WqZGB6wCu2iMRabNtRIFZBdGNbacFSLi0z4Vk/9464NQDrVLvdho4NcXiUgXA/f4njkWjaLRCE15AI+dV5fGcumVg+r0+Fk3KeEniV146EGbIo6yzAhvdn+/swvhL4h7Wb4sNoCIAHp09N5UCCQRWdjHESyU9l24q5FW3WDFvqotFHkcnQM/ZA+bdQsqb4D5fyXvl1GZBUIHPBXOGs4exfzlgLgcTFGljZAYwOzCZTFwi75/0MZjEfL/MtJTUJ+WnM7v7q4BO6r07rqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bg0TgaGphRXM6yqo+dJ5hf2emZT2DPIegyPtmTc6vE=;
 b=viZIPhdCUrhm6VLS4zdOwgGHoBeRUia8xLz/pNfwHNkHX5LKaHygk1iXYnDZ97zgUCdSVzTJNTnEkFv2ywCRCOl5v2jkxTZEOH4+Ikzgbunvn79qm9msy0QQziY65hZVRZoHdRdBLUpo0ySbu/szHcr6ImiQsVQtWlFumtJVHs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:47:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 19:47:45 +0000
Message-ID: <feea2090-5e26-44b0-8e99-da9bee6fd8dc@amd.com>
Date: Thu, 7 Nov 2024 11:47:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] drivers: net: ionic: add missed debugfs cleanup to
 ionic_probe() error path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wentao Liang <liangwentao@iscas.ac.cn>, brett.creeley@amd.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Wentao Liang <Wentao_liang_g@163.com>
References: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
 <79f0ce60-58a5-4757-88eb-1cdc8a80388b@amd.com>
 <20241107114434.05e6b875@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241107114434.05e6b875@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ae4f70-ebce-44bd-d744-08dcff650cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEMwVWtpeE1HNFNDa0ZMdWUvWEZNSHU2WEpzTmlIdjhrWEQ2aU9DNzBrT05X?=
 =?utf-8?B?cmNJNW9KWDlhZDMrZlppRU1vZnBTMElsZDNUK1VJY0NSZ0YrWW42Q0cvd2k3?=
 =?utf-8?B?YWRWMWtrT3ozVCsxaHBaT243OGY4VjFtM0hwNG9xL2pCTDVHaVVCT3Q1S3dk?=
 =?utf-8?B?a0NUVmYxNmdJcWs3a2hvT2JDQXpFbXFLWU5NQ29wQjFPQjJtdmFMN2ZCdUF4?=
 =?utf-8?B?emhXZEhXVlR0QXhqU2kxS21icm5xSDRrVEEzc2FpRVh5Z0dyRFVUR1V5YSt0?=
 =?utf-8?B?YUR0YXVRS1VKQlJsbk9vQUlneU9GbFNXRlZ5QmFBQm5MZUhqVmg5Y29lMVFu?=
 =?utf-8?B?YUxmUHkzTXdQNU93ZmtMdTMyV1UzVEJ2VTVhUzhwd0FEdHBhOFNyQ0REbFRB?=
 =?utf-8?B?UGMvQmp1aDVJRUllcXVkQnVzZVQxVlRlUU51a1c2Ynl4NmhHeUpWeFRxVDFh?=
 =?utf-8?B?V0I1Tk5oZjNLTFhpUkN1cFdpY0lkdFlsckxQSno5Y3Z4eklsSEhOZVpOK1NQ?=
 =?utf-8?B?TmtwV3c2elpnQ1NZOHIva2pzR0lhM0M2ek8wUGt2QVNvVEVqdW9tdnNESlhF?=
 =?utf-8?B?cGtIbjN1cVh6SjM1cnR6a1FPZEVuV2F1NC92ek1yYU1PUEU4dG8yeWpyUGFu?=
 =?utf-8?B?eGp1VU5wbUlPVXZSbTdXakR1bTNLckEvMXpTYzJKUG1EaW4rVUFPMC84SUY5?=
 =?utf-8?B?VWN1ei9mQzMxRjVLZEM1amtCeTF6empsUDhiV1U4eHFaci9GSnYraHk3VlFB?=
 =?utf-8?B?QTBCbkhnRjV5ejRCaTFHVXhIUVFRcWhPUER2czJ5bVU0NXVBbjlMSTgwTklY?=
 =?utf-8?B?UGdPeVNjZkVELzMwdTVxVlArQXh6SmNiYjc3VUxJOVM3czZSRnJRdnBKRGpW?=
 =?utf-8?B?ZlluVVFzUisrMGFjb2JGVENpeGNTTmV0OUF1K2lNQmxyMDFYM2hoVkY4eDJL?=
 =?utf-8?B?K3EyTFFQUlU2KzFHeGY2YXBHTnpFZVRXNjFTWWVSWXZKci91QlpoQWpvM1p6?=
 =?utf-8?B?Y1A0Zlh2d0I0Qy93dm52TUc2ditnaWoyRktEWklnT3FMbHFIdGM0VmdDNkh6?=
 =?utf-8?B?czVxamtOeXhvN1htVnhGRlptaTc1Y3MvL1ZrRml3WHFSS1I1OVprd01RRjE1?=
 =?utf-8?B?R2ZDc2N5UlR4RE5ZNFowUVl6Z0xKVW1YYTdzRzErQlhTTithV1d6YWdFMU5J?=
 =?utf-8?B?bmIrNmRSK3RsbG9GMFhZeTNxV09MSExIbkpnT05MbU5tUlNrWHB5dmhxYVhh?=
 =?utf-8?B?czZBOVdycW0vN2dIb1dCV0NBc1k3dlZxRVJNYUdKQ0l3V3lrTzFucEtmbXFt?=
 =?utf-8?B?a2VaWXpMazhQeENpQWxCTDhXRGkvTnJ3eitOMkdmSi90eEh6dDJuRUNMVTgz?=
 =?utf-8?B?d0Z6eXE1bWNyek5CTjdDODFPNjVJVTZBeTVoMjJkVjdjNVhTbk16U092OWh5?=
 =?utf-8?B?RHdyajYrbUxNeXZVVkNhK1l2RmlWRW9RR0dXdHFGa1ExUjZHYmRGcUJDSUoz?=
 =?utf-8?B?UXd0dkl1aE5xRlFmSlBjVGlnVGVPMUJVb0ordDZSRDM1OVpnRFdvMG40QTYr?=
 =?utf-8?B?VmY2V0ZWZTZsVWtMSE5MTkpGd3dkNlM3b2lOQUZYZDhXQ2JRK3k0aGg5YWJM?=
 =?utf-8?B?alRneUROVXBiMlBYL1FsWm1zTjlZN1p6NXM2NFhaMWFibG1OdzR6ZmVQWmFk?=
 =?utf-8?B?M3FrT3o2eW5nL1JMQ3ZhYS9TcjR1cmZqaTEzcTdGb2lrZ1dnbEVSSzVPeGE1?=
 =?utf-8?Q?qHG0K22PFH7z8lV3O/uURpk1ih+nq5oEafY2Bd6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlJ2L0JCN0FQUFlUUUF4b3dJTlQ3UlZVVDdTNGh5VzVMS3BCYzdhbGtEclpx?=
 =?utf-8?B?d1VWNE14L3plSjU4QXRDMWpHamFwQzJBOW5GSWVMZUdPS2pkRnJsbWhLSzJY?=
 =?utf-8?B?clI0emFteWlIWmhBcVUwQVJMUkxLMEtLRHpKSUhCREpicFFCZzU1Y2VtV05C?=
 =?utf-8?B?YWt0OWR0UE1YTFhQT3RSSitzUWovMzN2NmppOHNHNnV6eVlHWDR6Y1hsM1FT?=
 =?utf-8?B?c2dOc3V6MzhVZjU2Q3k1cHhWc0NHazVtSy9SL0RhZVRxQWprMFpneHBqdUsz?=
 =?utf-8?B?ZW12RkhUWndFU05ucG4xdnVzSEVISGFzTDRlSmF3a0xrWStpU1kzUXgyUmtL?=
 =?utf-8?B?S3ZCWmR4a3ZCa0hpZW9QdU41V0RtUU9oRSs3N29kbFhLYzdTNzJsTU9rWktp?=
 =?utf-8?B?Z0cvNkZsbitmQW1NdmVmditCemxUU0w5eG9EbEF4MURNQk1BbjhBc0dhWS9R?=
 =?utf-8?B?VEF3Y1NLQ25yeGpMUzJRY0dKSGtDeDMyakV1SjZyakZpT1hvVTZ3bnlIdHhz?=
 =?utf-8?B?UnlkSkhQQ2ZjVVVacXd6WDAzcE9MM1FvWjhhSWJiRGEwVGtsMmJkNFJqTGZ1?=
 =?utf-8?B?M3hIQWNuMTE1NmJnNFphUjUzQVB0S0V6QnJobXc1VFBGS2ZjZmh5RERJa0Uv?=
 =?utf-8?B?S3VWcm5GTG5rSnZRQUw5eFN6UFFIZkJJekIvYklBU0NtYnk3N3VXZC9RRlox?=
 =?utf-8?B?YVdhTktOeiswSVBnN1c3bFgzSlUya0RhM2kzVnk5SFpnMDFqZE51MkxnZnQv?=
 =?utf-8?B?UlplUmRVd3pCMXVuMHd2M24xMWptQ09KMkcvMmg2VkFld0w0YUc2dFBlek1y?=
 =?utf-8?B?UmZOTjdGNktmdS9NNi8zZXRpa2U2U1ByYlMyYWNpSHlaelFSWGpqWElWNGpO?=
 =?utf-8?B?Qm1pTnMvakh4R1Y0bnhES05TZitBSm5XRUFKTkZYR2MyWEV6V0JGamVnVlNF?=
 =?utf-8?B?MzhJUVpFMjg2cmhOWlJrNGNZYmFzUEw0VWN0YktpUDVPUDMvaTNLcGtldWoz?=
 =?utf-8?B?N1RGQ0o4WFh0NGtGaCthQWptQ3FBaEJqWTFKR2xXNjNpNWJPNUR5aks3L3ps?=
 =?utf-8?B?K1FubmVVSGJFTTNpVTBCUWM0OVUrRkhyK3pTWW4yQjVUSVp5akM1ajBJM0xP?=
 =?utf-8?B?V01oeEZucndmVUM2MGVmSHI2Q2wrZHRxT1FYZWFwU2R5V2NFb21QNXc4RG5B?=
 =?utf-8?B?ZVowYzdiN0pkcGk1enBhVGF2amkyVEVoZmtucXU5eXgwVnBsTFpwb3hrSzFO?=
 =?utf-8?B?a3czZTArRnExU2xTbCtFNDNaZTQrUUNONFlFazBESGVSOURCVHRvTHZZcDNQ?=
 =?utf-8?B?OGhaVUhjVjVCVW4wZm1TTm9rbUlZZmJ4MVZoSXdhdmdiSFo0T1MzODN3UHg1?=
 =?utf-8?B?WXhHRiszRDdRSW51RmgwNXhxdGRGNnpuWVVUdXhaWWRkZVRVK25zcUZTK1E3?=
 =?utf-8?B?YzRFSWlCQm5rMEQvSDdnMHlBUldwN0JpR1JNY0dpK1paeUV0cmRGRDBEZ3Fk?=
 =?utf-8?B?Z0Ixb1F4VDJqSmFLaEw0bGZ4NDBVbFJvbllsZC9COHg3UzRRRkgwZldpZHMz?=
 =?utf-8?B?TUNsNjBtUDVqRTl6T3VoaXR2cmRtdzNidGQza3I1Y09yS2U5VGt5Q0FuREVw?=
 =?utf-8?B?TXZiSnphMUJ3ZUJ1T29WMzhvb2hTT2hWbHFHd2FaSm1aaU9UV2NMNHBueldF?=
 =?utf-8?B?VEVyU1pIUm9VL2NjRGdkNWEwUlpPbzhqOTBGRVhXTE9Pc1ZMNnNKeWl1R0M5?=
 =?utf-8?B?R0M1c3NoR2o4M1RGVFYrY1grd0FVWnd6UUZDL1hEYW5QaDBIeDNvWVg3NUNJ?=
 =?utf-8?B?cVE5ZXFmaWd1WFRBOEpnR3A2RHV5RW5DMmhFUXhUVDJ5TjM3TVE4UmsrSkJs?=
 =?utf-8?B?TVV6UnZLK3FMa1FULytYcFF1eklBQW5Ya0RST1lWRzlGUDlzU0lMQ3pQMm44?=
 =?utf-8?B?WWVZWERFSUVoa1RiZEl0cmx1VEswTVdJNVN1clZQWVVIWWtkYThrdWU1ZHhJ?=
 =?utf-8?B?TEpLQWVjQ0g3MmFwbk1PVnU5K1E2WHp1U0hRRFNMQ1kvRGVZZ3hnSUZXN0p5?=
 =?utf-8?B?d1lDSFcrYnBNNGdnblNFMSsvc0Z2anpBSVJONzZWSEp3NTlDUlRzTWVVTS83?=
 =?utf-8?Q?C5ru3UdZc16qC1QqmjbJxCGk7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ae4f70-ebce-44bd-d744-08dcff650cbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:47:45.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uyyWzgdRfq+D18lJ+tU/9KCxef+C4kak462LX3PGoJUwvm6CvfBY8dblJ2F8JJXRjgF3A8pdBY6HyoGoWLvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

On 11/7/2024 11:44 AM, Jakub Kicinski wrote:
> 
> On Thu, 7 Nov 2024 11:31:50 -0800 Nelson, Shannon wrote:
>> On 11/6/2024 6:17 PM, Wentao Liang wrote:
>>>
>>> From: Wentao Liang <Wentao_liang_g@163.com>
>>>
>>> The ionic_setup_one() creates a debugfs entry for ionic upon
>>> successful execution. However, the ionic_probe() does not
>>> release the dentry before returning, resulting in a memory
>>> leak.
>>>
>>> To fix this bug, we add the ionic_debugfs_del_dev() to release
>>> the resources in a timely manner before returning.
>>>
>>> Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
>>> Signed-off-by: Wentao Liang <Wentao_liang_g@163.com>
>>
>> Thanks!  -sln
>>
>> Acked-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Just in time to still make today's PR ;)
> 
> This change looks fine but as a future refactoring perhaps there should
> be a wrapper for:
> 
>          ionic_dev_teardown(ionic);
>          ionic_clear_pci(ionic);
>          ionic_debugfs_del_dev(ionic);
> 
> which pairs with ionic_setup() ?

Thanks, we'll keep that in mind.
sln

