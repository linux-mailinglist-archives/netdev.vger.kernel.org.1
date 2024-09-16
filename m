Return-Path: <netdev+bounces-128573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7497A611
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C185A282F87
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED31C28E;
	Mon, 16 Sep 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JWL++WgV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8A17BD3;
	Mon, 16 Sep 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504382; cv=fail; b=erSgJiNLdfp7lzUcEWZgSMRCIhUZ5K3whbeyWr6d+sV68nMhr4dXl4FoIjyvkM5jogbQaac17LOP5fC3YV7WuuHU1jV9+hYtKXv9SZbbxon8gxqbAUE22TG/gBxfFxSng7yw8mBRckhYPn70eMmJOaqt+c53cgWJOE97Ro74CeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504382; c=relaxed/simple;
	bh=at5jqehcY2haTztFsEpD8xMQ0Cgp0ttlpMnZrl3ARis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pi7677QCiwjFcbpIqaxnqykNklCo5KOIiw/eAxTte+La8RsWP7F4m3ZXohPCYAsx/leuAAxw5GMRXemdFeeHELet/IOdPoBzM1rJKKDP+3hnjys3K32qQzUn7vbF/107Zlexr2wh8iYmadjDmxuMkjx8jUcbqXhEW0cQ8ljpVQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JWL++WgV; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEH3tVQiaT2b6rFY4+Wk/sGodzzXHgjWf7U8cTQmjhtYQ5zvsGMSZMiDmABVpJhHPxVhG6/GnJ94tL5951yvjKu41v0uxpMOhVGw9cgLUwd5TTV/bV+QD21QnRTFlvuvXw4sJ+nwU6tAXJn/Fl5vmpXtam5GGobp+SHQIy0KiYp2khlw3hknzGjH7TsG7gzR0Ypz8un/FD6FBxoPW1EuQ8XldVw8YJY02JscJh4inq1C5DNj64r0QC5plO4MSX4/eqD1ErCetdGa/+WgNRL8AFEgH+GsGIv5kuvJxqHmAbHcgMrGXwIZ2pkA7c5snYu4BB+Z00qzaws7UV4vSafJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIq2mOdeHY7UNjnS8LPDx16X8qksb54/g/LBcWZ3Gl4=;
 b=IaSDK54MVyfC+uSjNGh+nW3L2hjPPLroRHpYcbmhxYef22EyOH5nQjkFgS1HvCRTjFfcoAr/wGDOXzUJWSwKBFiIkI72fhvcvE2FBfbOjBXqetMsPopWRCJq2fRBPGcvvmFMTM69yyYyLw5PsoHZS3cS+9uGRrrlfMN0IDEBy7qn7D4QNsFMzr5Y1ihT+RZ95RDqy13LOIEyLvsM1rYYd1EttUFyNbdMqavWehzoKEyH2uFkOampqlMRwycOWIQ0BoO4fc0EcLUbTD++DD8ssiaVXoqqJUXRMONs3hjc6wZG73S7wh43V58l/8uHiuQKUGZHmuddEdpkbJNqrixeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIq2mOdeHY7UNjnS8LPDx16X8qksb54/g/LBcWZ3Gl4=;
 b=JWL++WgVsqupamH5jIoHPsU+AHexE304xAl/poZtuoV1LdAq29thZMJSrBuf8bWcICJyvtkZKVqeE5oYlXKWqzwI5n7PZ8tSRXwX8mFvUyeaXEEtBZjn8PtvfQKTZ82qWA9HIE3s5WNu7086HNj5zIhot8DErPr/OztdmnFgeOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:32:58 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:32:57 +0000
Message-ID: <9343a359-29bd-1c11-6e73-1df7ea14a4ff@amd.com>
Date: Mon, 16 Sep 2024 17:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/20] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-18-alejandro.lucero-palau@amd.com>
 <20240913190808.000010d0@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913190808.000010d0@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0112.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: d88b45f1-69ac-4f93-cb9d-08dcd66d385c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDJDQWZ5dFBpSTNqSjljbUQzaXNLZ1JES0JOUXZQRDNRK2c4a2cyNU9Jc1VC?=
 =?utf-8?B?dU5hWW9MWDU2aDNXMzMwcGVQN3JqelkxdmRDbnNVZ1liR1VHaURZQTBZclhZ?=
 =?utf-8?B?djJPYWFBUkt5YlFPMWlJV0p5eDZsNEdqYUEva1czNWV0YTZFZUFNczlwbmk0?=
 =?utf-8?B?enNOMVZYR3pWR3dKMDZEc216VWtmeXYrWmQ1RDRpTS9qL0dUeEp4MGkyelcw?=
 =?utf-8?B?NFdsb015SDJlWFlFWTVLUkE2aFZPVXpzbVc1Sy9lNG8rTGhCa3ZUV3JGVmQr?=
 =?utf-8?B?eXkzSzZJV2RHa0thNjBNb2l3TFdIbnZqd1FEd2FlTGJNcm0wWm91c0tMQXVn?=
 =?utf-8?B?QmUzUFo2S2JaQjlxdE1idXIvYnBQUk5CSzJBQUhXcHJWZEZJZW9sTjRnTFEr?=
 =?utf-8?B?M2REMzhKdUhMMEwxRzFkZXR6V2xPdm53dHBkN1Zxcm5tYm5KcTBWbVFxaXFB?=
 =?utf-8?B?MHlJajI0Z1VyZzg0WUdBR2t3cHBYUThhUkQwN1NmSVNSSVk0NGxzRWJ2NDRD?=
 =?utf-8?B?RG9tcVB1bUtBWGtFWUdEbHRUZ3A3RkNUUVZZd0VPekx2ZENaWFhLUzV2OTdB?=
 =?utf-8?B?TCtQaEZWM05jVzVnd0RDbTRGeGxtM2dWdWhCTzE0TTVVNXhrNHRWMWNrQ29X?=
 =?utf-8?B?dTExb0FkbWRMeDNkdnA3QVNST3NWTXhCcmdzdVJPc0FCUUJCYkN3M3pvamcx?=
 =?utf-8?B?aUJDL3QrUFBpVVpZSDc0MHdlbmZYblhHeW8rSThpVUdLRjY0M3dQTmhJbEU5?=
 =?utf-8?B?ejhOWUN1VUZ2WjhUM2ZuVFo3VmFLYjZ0b1ozMFlVbmFXTm1vb3J5WXJ2NXdP?=
 =?utf-8?B?MXBRSldiR2VmcEFObUN2d3F1Z1ZYSVNDRTl6RDBkSzBTbTBVcUVHM1JBVlY3?=
 =?utf-8?B?UmJ2Y2dBdmZlRS84M3VpWlo2V3RLK3BXamMrTGpuUWpZSTR3dXZrcU1GVDEw?=
 =?utf-8?B?aTZpTXcydEdQTmthUjBtd1VWSE9SSUVZemRwQzVHdm9NR29xc0pBZXU5Q1FV?=
 =?utf-8?B?cHlOZzhlY2dSYTBKSjJtY2M5alRFSlZWNWdVWVVOS1R0SXRsSTZIclcwTlFu?=
 =?utf-8?B?MXlkTC8yQUdCYzdnR2tpc1RCOWhDZVZFY1NxU0dUWjFxV1Y4cmxKaW5hbG9l?=
 =?utf-8?B?NzVDc3NUWVhweTVPellmYUdpUWordHRNNC9aMU91TXMrVll5U1Z0MDE3QWJS?=
 =?utf-8?B?SnY5cnhDTGFSN3VpUHpMRi9HR0IySmN6OTFOeGsxSkYvTlhZbG85S2crTmFs?=
 =?utf-8?B?VGg4WDIzYm5LUUMrNmQvUW9KZS9qUnRNcEI1WHpJTFlrclhkVW5hbStpRS9S?=
 =?utf-8?B?bGpwLzNnVFp4NjltRDJwa3ZlSm51bkRzZkkrSkt4VXMzd3RCR3E1L2NyZUN4?=
 =?utf-8?B?ZEZsR0lLQ3MzN0I2V3M2T0YzTXR1QW9Jc2hoUWVxSDBrYytIWHFiM1ZaQlhv?=
 =?utf-8?B?SmpNVHduQzFmQnhDMzVJc1VnMmtIQ1NnWkRybEdpQW5iVlpsSVM0cm5ZcWF2?=
 =?utf-8?B?UzNwYU0vdGF6bUFQUDJEU1c0NnE3WTVOR1RPNk5MRkFVWktHRU4za3NwcmI1?=
 =?utf-8?B?VW1XaWFUamc1WGFjQy9oWlY5Nk5SZkoyTW9DVktFYnlEUG1mWUlMK0x5NkpV?=
 =?utf-8?B?allidG9aYy9vOUFiSVJlTFV0cUlXbWx1aFRrSWh0WHNLMDA0QzJsTEh2Q2F4?=
 =?utf-8?B?eVFUdlN0T1AxQXo0dUJDZ21ESHhiV1JRSXp2Kzc4Qkhpc21xQWo3YkhOSElH?=
 =?utf-8?B?Z1RjeG4zVDlEb2ZBR3dBQ0VDVEdPai8vVVNjLy9UaUkrWDhuVmJNaXk3NmVq?=
 =?utf-8?Q?lgq/nZZ3QQ0mstulpQRG4GEp2o4XL/4ARQvNg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZZUVlqUktJR3hzZnFEMGR6b01LY2haeUJ1TUovRmxQVk5la3lyaERObVF2?=
 =?utf-8?B?TytXSjBnK3MvdjRLK1lSc0d2TDRUSTJLb1Q3Zmc1MG81Q0xaN2JCQ1FIRlJF?=
 =?utf-8?B?WFU5dDZzdU5xZmdkYzRQWGE4TlRtR2s3azFlZGQwenVqMFVQTEkxc05tOHFL?=
 =?utf-8?B?aTRDZ3VGT1d3UWpGRisveXg2MGFDK3NVL0ZLOWxrM2xXUTNidzVBeDYyR0g5?=
 =?utf-8?B?MGpRd25WMG5QajFSVndidGhpM250Q1JOWkYxcFNwclVFNWYrUmtrbElVY3d6?=
 =?utf-8?B?eTgxRHN2UmpuUHI5UEVxNkN1bFhBRGZVSDdndGQrSVpkd3N6OUdLTkVPRUt1?=
 =?utf-8?B?S2lra2kwOVR6SkRWUURzT2JwNXdwZ0s4M1crSGVJUHdEdWhVN0pTa0w0U0dJ?=
 =?utf-8?B?WGhRdWl2bTh3VGxjcFJZTWRTZ2ZRWUd5bnAyeHNJV0dMejFqMDVRL1F2SjI0?=
 =?utf-8?B?NjlMUzRodGswQ2UwemhISkRlakdaZmR1VDhYeHFOK2RlUWRWU2JlYjdyMlZJ?=
 =?utf-8?B?eVhaUnVjcUQyUlhOWHhBdnhhT05CRTJQdXB0V3FDVHdzNmpwQnNsdTNJZnZP?=
 =?utf-8?B?N0c5ek9RTUFJY2ptdjFDdmk5MUhDQUpCRFRweXBON0p4Z1BoWW85aHpoV25X?=
 =?utf-8?B?YklaWVduUDBUV21iT2tCV3J5SnRkSjkxMktrQ1lCMzZ1SEpHSlc0LzIyOVZ1?=
 =?utf-8?B?bk5WeVJVYmRVbENMajNZWHc5bUhoSGM1cCthaTFnUCsyUmxDaVppckpscFBt?=
 =?utf-8?B?OE9LYkt0YUgzcDFublpHTUQyK1V6dWFJQlBxUW9zYVZXdjhxUTJKdDdpV1F4?=
 =?utf-8?B?MUdkZ0ZjZFdYNU9ZRjYycUxzRktmRklJSklPMGRvaXRUMUpxUmFrQkpQRDZJ?=
 =?utf-8?B?Z09SdEY0eVhMR2Nya0UzM3hYd1pyekhkekNoM3pndEEvZG5zME1pOGozVHJ1?=
 =?utf-8?B?U2tLMkZFMzVzak5KbmgwSmpIZ0d0WkJiT1VUb0YrWWpxek9DRzNDSWFsVTl6?=
 =?utf-8?B?ajFLUXJibDFqbHlmZEZQRTlhMi9zdDdQdS8wVmlneFk4cjFDNTBDWFNad0dG?=
 =?utf-8?B?SlM3TjFkQVBFU0FRQU1haC85YlUwQTlsVzRMRmIzM3FOVGtPTnp6Q1NxZ2NM?=
 =?utf-8?B?UjNlVFFuaXAxNlpGbFNTUmlWUWMvdkdvdFprcTN1VGZIQmxTMmNxeHE0UVp5?=
 =?utf-8?B?RzZzdjJZNzBFS3dQZ3lmRDdyQmxKWTZ4QnR3eVluWVJseHREQmZTc3ZMNXM2?=
 =?utf-8?B?eThCL3V6UXgwUWdTQVIzUDlaVHI2L3FlMkxlWW50T0NHR3hHdmJKa3FBTldh?=
 =?utf-8?B?N012eVJoMHI0Mnp1QjZDMHhrZHh5VjUvSzhTTXhoWUxUT1dBVkcyU2cyODN4?=
 =?utf-8?B?SE04WXRYWTFObStCV3VFMTQzd1IvQWpPeDExV2wvcno5QnE5Vm9JZy9ZM2l6?=
 =?utf-8?B?WXBMVEpaRTYwNFNxNUxDRUYrUldYNGEyWlB0VExFSHUzSXlZQWd2SjdwN01p?=
 =?utf-8?B?b0JmTlFrUGxLNHB0UDB3dzg0RXVBdTJaM0RrRDY0R20yMFlsY3BtZytqR1ZO?=
 =?utf-8?B?TGk5RzFBMENYajFOb1AxZUdWYjkvdUZjMFpQNUxwNitWdnF0dnIvNkVFajFs?=
 =?utf-8?B?MDZLWSt5VlNOTE1JRnhIWkNDNjVWNVJtK3pENFhUY2dxN0U3Rm5WaUxzeFBv?=
 =?utf-8?B?THJmbFZZNFllUDlyQlVRZEZadFlqSmMxS1JwOVBaNW9jdHM5cjhXQTlwRUh0?=
 =?utf-8?B?dFV0VXFVOGxzVnhudlNPanRUY2srKzc1M1IxVWZtZUtMbmZJR0lDSGVBK1Ns?=
 =?utf-8?B?aGtJZ0l2UTFZZ1ZwTDl3QkRLUytUODBCR1RIaVAyT2RVRkkzRjVocXJPN0FL?=
 =?utf-8?B?MzRmTHF1NHlDWC9zclRtK0Q4akNvc0pPZnF1MzU4ZmtUQTJ3emROQ3E1WExT?=
 =?utf-8?B?TjhMbHpYTlJGVDBYeDFYTFlqSkdTWmprQTdPSkJNeDNhb1BrUWs1TXYybGRW?=
 =?utf-8?B?dFdaVGtIZzM3cnNUMDJQMXd4MmhyeDRoeUJwdC9CdGlRc1YzcEhTU3FzYkFr?=
 =?utf-8?B?L1l1Tk1XT255L1ZxNUhUYmpBQnZJelRoVDhSZlZZYjZSWlpuSTNVaFlXek1Y?=
 =?utf-8?Q?CagzMOPdfjMTZhVeVQGAu68qq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88b45f1-69ac-4f93-cb9d-08dcd66d385c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:32:57.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIXh6jALgik3ONPTP1vqm8eXh1c16N6H7YKcxljuRiLJ0KqXeL4bVNXYl8ji/d1vqF7Kbk6jEf5Ukj3WeSsvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653


On 9/13/24 19:08, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:33 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Sign off doesn't make sense given Dan didn't sent the mail. Co-developed missing?
>
>
> Minor stuff inline,
>
> Jonathan
>
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> -	struct range *hpa = &cxled->cxld.hpa_range;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> -	struct resource *res;
>> -	int rc;
>> +	int err = 0;
>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> @@ -3404,8 +3414,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>>   	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>>   		return cxlr;
>> @@ -3415,19 +3424,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	p = &cxlr->params;
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>   		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s autodiscovery interrupted\n",
>> +			"%s:%s: %s region setup interrupted\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__);
>> -		rc = -EBUSY;
>> -		goto err;
>> +		err = -EBUSY;
>>   	}
>>   
>> +	if (err) {
>> +		construct_region_end();
> Here I'd just release the semaphore not call this warpper as it's taken within this
> function I think?


No, it is taken inside construct_region_begin. It is hard to know just 
looking at the patch.


>> +		drop_region(cxlr);
>> +		return ERR_PTR(err);
>> +	}
>> +	return cxlr;
>> +}
>> +
>>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>> @@ -3444,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   			 __func__, dev_name(&cxlr->dev));
>>   	}
>>   
>> +	p = &cxlr->params;
>>   	p->res = res;
>>   	p->interleave_ways = cxled->cxld.interleave_ways;
>>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
>> @@ -3451,24 +3483,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>>   	if (rc)
>> -		goto err;
>> +		goto out;
>>   
>>   	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
>> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
>> -		p->interleave_granularity);
>> +				   dev_name(&cxlmd->dev),
>> +				   dev_name(&cxled->cxld.dev), __func__,
> Avoid reformatting unless necessary. Hard to tell what changed
> if anything.


I'll fix it.


>> +				   dev_name(&cxlr->dev), p->res,
>> +				   p->interleave_ways,
>> +				   p->interleave_granularity);
>>   
>>   	/* ...to match put_device() in cxl_add_to_region() */
>>   	get_device(&cxlr->dev);
>>   	up_write(&cxl_region_rwsem);
>>   
>> +out:
>> +	construct_region_end();
> As below. I'd have separate error handling path.
> Same in the other paths.
>

OK


>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>>   	return cxlr;
>> +}
>>   
>> -err:
>> -	up_write(&cxl_region_rwsem);
>> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> -	return ERR_PTR(rc);
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
> set in all paths that use it.
>
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	rc = set_interleave_ways(cxlr, 1);
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		goto out;
>> +
>> +	size = resource_size(cxled->dpa_res);
>> +
> only used once
> 	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
>

Clever.

I'll do it.


>> +	rc = alloc_hpa(cxlr, size);
>> +	if (rc)
>> +		goto out;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	rc = cxl_region_attach(cxlr, cxled, 0);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto out;
>> +
>> +	p = &cxlr->params;
>> +	p->state = CXL_CONFIG_COMMIT;
>> +out:
> I'd break out a separate error handling path and
> just duplicate the next line.


I'll do it.

Thanks!


>
>> +	construct_region_end();
>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>> +	return cxlr;
>> +}

