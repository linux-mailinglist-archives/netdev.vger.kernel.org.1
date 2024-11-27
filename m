Return-Path: <netdev+bounces-147622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7429DAC29
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D76164426
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051B1FF7A2;
	Wed, 27 Nov 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3M50/EZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CB17C96;
	Wed, 27 Nov 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726769; cv=fail; b=AbfoK0yqqGa9ihGFGT3VbExJUiFX7Om3qaGk9r9vmHxKywk3xz+ZUfHfYdbgSehH+ol+0fWbi/c5EoxsT9JU5y7Ic1dazARo0Y9DDxRDtcM2J54Zz1w3jugvoL7lJLrKTDcQbkGXKesNviBgiS3Uxu3aF4nl7tHHxgGxpUBh00k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726769; c=relaxed/simple;
	bh=AdLeRb6LmKzbpCAwHZ40U1DRxr/j1hrS7qm+SI8/708=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G1JHisK6Ojp3OB7OZtMPxGue/zDE64xezijNNFHCfvTxDrPvZwJNeYOc/otPDsREEJFRAdrwPlPpvp68h4L6oH5WYx12lgu4Ii5irGUAwl7xy86z2UHXFNMws6YLUJfUovJTRK12Ks3TlltsBxuiMWHglvYPEauEYrD3HpyQRDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3M50/EZ; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhzCvwWz5KzlrL8c4nKQfh+z6KWjEVIA7shoW863QbBhDRk8c1kLyBPElA/TA+qfhZ4Nb34cvik0Wet0De/ZTrp0Y/QPGRG1Qs0RLzDHDjSj2CvUXHLhGFr3H0SL4thlRMmk9T7I8NLM3E3t3MF/e3/8f8+jQNbQVRKTY/I/TEXQQ4n1mQG3B1FZHUiwjbm1l/R29Z4OVFIh7y3Gwncn9iZCbKJD+zpwn8iWA2tFNGk7t9XRLLdsciZ+ofNdfhXUlqYXWMnKN/gw2xA/JFfJdX2LU0SkE3SJ9gShz9R+jyedXKYUyMVgZKkk5tPJtFDxhT1rn4kyh8vIXk7VZ08Bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0AwgVKRyX2OJ0WLnTDw0tnaPwloyix9SgBJ9ipxSi4=;
 b=sb54IC9uyFB4Ws+zIIkQGWWi8qF6vS2Y+K5Vux7BssLV+kOTja8QXchL8fMyiH3yvdNzhiUtN4JkOHCjgObcvRFHN71j07269InWikveXIiD/hZSXICdtm5vAH0r92pWR7Sj07m1V6dyxluG9MvW21Z77QZ7CjqgQNIDd7D/SizyfopZ3wo2+LAmBjNe1gaLmFaPsPNpYs/dN2RkZ4Yn6r8edJ55G+d4o0Ts+ikGhF4i+QyhfWKKOx43vRA/iLl6YYJ6dqzY6CkAR7wLqRkFiFLFDRl+ioDzN+wID8dHkY9wamRZ407EoC6sK3EILERte1Gxn6LfxnTMr0O83yM8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0AwgVKRyX2OJ0WLnTDw0tnaPwloyix9SgBJ9ipxSi4=;
 b=p3M50/EZIaiX1POdX35dVa/cq4XiuiSFN+k7SAfsMqi/Q0JtXSS/sQIAP11Pvwk/H+nv1AvF8sv/QTSSQsXOwmjYmoGU5xnIRVB37tyDc9y4MPG7cgs5oUl6un7gOL8cSuFvP12GfLaU70OMGo7e2rhGEOHcbAFBU+ixH5aXki0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 27 Nov
 2024 16:59:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:59:21 +0000
Message-ID: <229773bc-b81d-7e72-0b4b-3aeb6a7306d8@amd.com>
Date: Wed, 27 Nov 2024 16:59:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/27] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
 <32f4889b-c097-4e72-8a71-511aa06daa58@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <32f4889b-c097-4e72-8a71-511aa06daa58@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee07aee-84a0-4ddc-1065-08dd0f04d6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGRLWkZmZUlMcW92bHhZUnBFTkhlMmVrSGZyTmdhNWJ0eTJibUQ5RkxhTWxt?=
 =?utf-8?B?L3hxSm1aYk0rdkFVT2R1MW5oTG1Gd0lFbE8zd2loQkQ1a01PaCtwVnhKYWpi?=
 =?utf-8?B?NVpoL1hJQnRxWHIxc0lYcXdka2NBS2tvc2REMkNWWndERUlKamhmYXVwa3BM?=
 =?utf-8?B?b3FscUdLQlJUVW9xNDlnSUhnV0ZPSE1HRnQxeGMyUzIvenV0MWtEandmbUtP?=
 =?utf-8?B?dWdaOWxQVUt5VUFoNGZVTzFhTWN6bmFqbWk1NFpYUmpQWFI4M2ljL1FhZGhz?=
 =?utf-8?B?OEdMVzN5c25QWG5OSU5EdWZWeWxLcmtTVkFZTk9sL1AxdDBHcHV1cDVXUHZL?=
 =?utf-8?B?UW4yOEVwSmtjc0ZMcWRoL1lOWG1IaDBHKzJDZElZdklzcU9qMWRkMU9MQWNR?=
 =?utf-8?B?dWh2YTBkb3NRVEZlZWprdmpqT05DSDZhYXFXSmMzMEJPcEVtcXY5aWhNTHIv?=
 =?utf-8?B?c0NxTm1kaWNOc2pKanBvbzRNNlByQklTc0RTMTBSRTdNbk9zTUVKT3NtM2Y5?=
 =?utf-8?B?N3I1ZlIyVlZGTUU2VjBKTWJBU1U4YXMxbnhrV2ViajlmV2pUSWxRbEsySVpr?=
 =?utf-8?B?K3lPUCtkdTZmQkRVTHFnMFJRd1FwYTgyN05TeTdmakJMV1Q1RzFPU1lhQzI4?=
 =?utf-8?B?S0FhdmZuQUJjTHVCdk9FdHlYNjUvcy9rSVVCWExaamVxNHdIR3p0NElESWFC?=
 =?utf-8?B?U2FWZzdxYy9BM21BWFpzcWdYNG5JYVd4VkZGQ20yTGZGTkVvSVpwc044ZGZX?=
 =?utf-8?B?Sm1aNUxldGwvbzFxaU9acG90dlBJbitPRWk5My9LRUhPbVVDN0EyUlBHRXZv?=
 =?utf-8?B?NU9xZGdhZ0J4cXMvQVZJeXlobysyM1ptSURVSzhOdzBTUTBMUUJaNkJya3Vs?=
 =?utf-8?B?b0E3aitTWk5xTGNTY0pBankxNDlGZFl2b0QzNkI4UE4wcFBxUFMrem5DMnc2?=
 =?utf-8?B?WW0rWS8wNURKT1Nzd2lJUmIwdzZiL091enh2N3FYT3UwTnlDejlmZTFxeUNE?=
 =?utf-8?B?QWRMenFLTDlsVzBRMFo4SElTSE1yaDB0V0FCK09SQUlFMlhuNWh6NnNTbHRk?=
 =?utf-8?B?QUtXbXVTRW1aZ2dQSVVUbWFLTzdpaTN6QmI1Z2hiL1RXT3pqS3VpWGtXVzJz?=
 =?utf-8?B?SHB5RzRwd2N4VmNjeVcrVExVMkljdExodEUxOU1oamJnRnJoejNHWFBzdk9Y?=
 =?utf-8?B?bUtBTnp5Rlg5dmx2eTRJNCtMYkZwNkU4L0pFKzUwems3anNhZ2hNODdxQTZ5?=
 =?utf-8?B?TG4zb1pOQkUxMXJ6RktwS1JhL092Q0xNNktZdXNLMENUc2lEbWhERG9oR0x3?=
 =?utf-8?B?ZW5UMEltOEkraUh2OWwxMUFpL0dMZWdKd3pyNWtDRzNFdnF4MkNJR3kvWHpn?=
 =?utf-8?B?RkdhT1F2VTBFQ0JQelIwcHBXdXBPTzVMMU5VVHIyUXd5SW5xdHg5TWJ6bTE1?=
 =?utf-8?B?azh2RHRXZ0o2Y2tMTXNWNEd1cEVpNEtsdWlwWGp2UEp2L3FidUc3YXVqNUgr?=
 =?utf-8?B?TlFTVjRmU3JxTGtRejFONkY1UXEvYkxFY3dWTEtLRVhOajJoekdiK0NhWkxF?=
 =?utf-8?B?OWdNWnhjdWlSVmdVSE00VXlBUlMyMXNJSklEUUFLMzFwMXZkSUtHTTA4OW52?=
 =?utf-8?B?Zk9NVTd0V0RJb3djd1BDM0kwUEhYOStrL2I1VTBDQTdOSGZSVVpvY0VTSFhJ?=
 =?utf-8?B?YUx6UWtQMzhZa3NYcHBnU2dwZkU4dFhpK3Y1S0MrRHJvR08vVUhpVVpTTTUx?=
 =?utf-8?B?QjhZQWFzTGk0S0tPRkNRYkkxRzN3ZjlEQy9pYisrTWh4VTlHb09xMjA5azVw?=
 =?utf-8?B?MlQwQVZzN09UamI4OVZHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmQ3ZGZkdnBua01PWE5NYjc0czVPMHNleU8xdGNiK01waFA5cFlRRnYyWTd1?=
 =?utf-8?B?MlFrRzNzT1F0bktWOGVKY25CdWNBbDZ6YUYwa1VlRDFSazVldHNrTk1NNmc2?=
 =?utf-8?B?czJqUWw0cXRNcWIzYkNnNlh5NUtISkdIWWszTU4vRUJxMVdWR2dNc0JtQ2JX?=
 =?utf-8?B?UnJEL2FZcSt6eUZ3VmJiQ1hlZVBzT2lZK1d2Sng2Tlc0MTY4MW5ua21oQUNt?=
 =?utf-8?B?aWJ1VENUaVRYQkc5bDEvT2pLRXNadVFsbUxsa1FHSFBNblJTTUNrVUlrdkk1?=
 =?utf-8?B?TVZ3bGRQNEtMNUZGTFM0K2ZZNGh5d0ZGM2JkS3d0STJEbVg5aFB0VXdQdlZi?=
 =?utf-8?B?R0VtTnZqNEhtUTFUeVVLbC9Vd2M1V29Oa05IRkhJU2FTZDdObGl2eE5jS2cz?=
 =?utf-8?B?RXppWldJQ0tLbW1ueGM0elBlQmhQZVFaUnJ1K3I2THVTVjBGT0V6aXA0Wjhs?=
 =?utf-8?B?NVVQRVZxbVFhYjJXTWV5Z0RmUGVQZnVLTUVhYi9XOVFKV2FVaEppTk1XaGRa?=
 =?utf-8?B?TTBMdzBqUmVnWTN4N2NONm9tZXczTUpNMVdsS1N6U2xFYnJXM0syS2s4UFow?=
 =?utf-8?B?S09RRGRUeWcxc09mS3FDNDMrcEJPNWJCWDVuVS9UdWpWbTd2dmExRjJRdm5V?=
 =?utf-8?B?RHZScmtsK1Boeldmd1dQR0JHNkRGMGc2Z0ZhcTVsWS9VL0lsbWJRV1pkbC9C?=
 =?utf-8?B?ZlYyYVZVR3FUajZTdnlIMVg1cUJvTmZPQlZLdzJBT1VYZFRJdE9YNXh3V2Fy?=
 =?utf-8?B?bTNYMkxza3FxS1VScmgrSGNBSE9hNFhlajlzVnJjMGZuMVo4UDkwS09LdHY1?=
 =?utf-8?B?eUx3Sk9kY3dBaEZKQ2ZxK3R4akNIMVYyQlJva1VtMHZ4aXZ5UDNpamxDbndO?=
 =?utf-8?B?Um45dG9hcXFrdy9JeEZLUDVxV0xrM2QwUWl6VEY3QTNMdnFRc2VVWXViTWRY?=
 =?utf-8?B?MEZxbnhjOVczY3lpeTgzZ2V6eDlBT0pneDhZZ01ob0Q5c3hzQU41QS8zdGpU?=
 =?utf-8?B?TjNPQWpKUjZRT2dUL2JYYUMyS0VtWVd5VmdxVTY5NFY0WmoyMWx4WEN3bHNG?=
 =?utf-8?B?U1pBcWYyYXJCeisya1g3YXhmUmgrZGxPak1qL09ZaVdtaFp4WVVYeTgvbyt2?=
 =?utf-8?B?d1pFZVJxZ1ZXbi9SeGx5aGdLWm80YWhCVkxPVWE5QzM0bUd2QWllWnd5ZDA4?=
 =?utf-8?B?Vm5vWVNrNitoV05TUE8yTlNPbXR5ajQzWWFKVWpVbXlPdHpSNStrTTJkOXVL?=
 =?utf-8?B?SE5ma1dBeGY3dUt0Qk44SUxTdXExbUdSK3lVdVRERjBXV3NNRG05WDA3U2FZ?=
 =?utf-8?B?S2dBODhpNkhRTXNXUWNuQ2MrNEtwdTlHOENTS2xXdGNCNG5DRktZTWVXV2Y2?=
 =?utf-8?B?S1F4NnRpL0dwbXE5NlRUdVNQVlJ0RGZHZUJidXlZOE1rQ3JBQlpQTWp2ZFZW?=
 =?utf-8?B?SEZqK0pidzZkTWhNNjdxYWwrZ2ZPbkNMSUFMNUE3ekZCQUtHSGpudVpDOEpi?=
 =?utf-8?B?OXU1RnJMaWFkWmRjZDJIcWFjMXNCNnc0V1NoUWNOak15TkJ3VmhmQkQvME1X?=
 =?utf-8?B?cjhMbUJHRzN2T3BBWGNPQW1lK1Y4RUIxMW1qYUxRNnJKQWtndXpJM2hUUkEw?=
 =?utf-8?B?b2dTcjUweTE4YXJQT0V2aXhldUxBUXkxL1NYTGc0UFV4WG5iVlZYTkZDdHl1?=
 =?utf-8?B?SVA2elpTMHNjV01IMjJEdWNEYkdMOFBpanhmMDJCakJsWFpLNzg3Z3dKOTMw?=
 =?utf-8?B?TVJZMnAySGJCOXBpdUFDMmN5bjR6VjJpYm0vMTBxZitjWlFEK2dmVmtBOVNu?=
 =?utf-8?B?bWhBVEJoZVBEWDA0Wlk5QmFLSXZkV0UxY2RYSHRSaW81V3JmV01LQnlRVnVG?=
 =?utf-8?B?dmdkRkJRcWtDSHFHVzdBYXFvWlZ5cHAvbWJ1UlVSVlVzeHFkbTc5STRyamtY?=
 =?utf-8?B?SW9DSFIxUE5MWTBWRSt6ZnlybnFxb0FWcTZRVmUvOFRyWSt1M1FKcXlJclh2?=
 =?utf-8?B?Yy84TVpvbmNhL3AwSjV5K2NoRTJEaWNSelF0RXdyeVlhM2pwZ0RvSmt4aWxW?=
 =?utf-8?B?d0U0aHdTYVQzU1p6dVdKYnpQUTJGc2dvMmJyWm03ekc0NlpsVzNQWkNNeUtE?=
 =?utf-8?Q?plnw1/COufcAxboOsNAey595n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee07aee-84a0-4ddc-1065-08dd0f04d6a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 16:59:21.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUNIABjICCd6/pJFjjwCL5Ig83fN+/Qi4uFkrpZFR1bZMdljyoiImvF+b3XBkkHivy0SwDT2p8HBwUuA+ktYOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107


On 11/22/24 20:46, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses. However, a dax interface could be just good enough in some cases.
>>
>> Add a flag to a cxl region for specifically state to not create a dax
>> device. Allow a Type2 driver to set that flag at region creation time.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   drivers/cxl/cxlmem.h      |  3 ++-
>>   include/cxl/cxl.h         |  3 ++-
>>   4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 70549d42c2e3..eff3ad788077 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3558,7 +3558,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * cxl_region driver.
>>    */
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled)
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax)
>>   {
>>   	struct cxl_region *cxlr;
>>   
>> @@ -3574,6 +3575,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   		drop_region(cxlr);
>>   		return ERR_PTR(-ENODEV);
>>   	}
>> +
>> +	if (avoid_dax)
>> +		set_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags);
>> +
>>   	return cxlr;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>> @@ -3713,6 +3718,9 @@ static int cxl_region_probe(struct device *dev)
>>   	case CXL_DECODER_PMEM:
>>   		return devm_cxl_add_pmem_region(cxlr);
>>   	case CXL_DECODER_RAM:
>> +		if (test_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags))
>> +			return 0;
> I think it's possible for a type 2 device to have pmem as well, and
> it looks like these are the only two options at the moment, so I would
> just move this check to before the switch statement.


Yes, that was also suggested in previous patchsets and I forgot.

I'll do it for v6.


>> +
>>   		/*
>>   		 * The region can not be manged by CXL if any portion of
>>   		 * it is already online as 'System RAM'
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1e0e797b9303..ee3385db5663 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -512,6 +512,9 @@ struct cxl_region_params {
>>    */
>>   #define CXL_REGION_F_NEEDS_RESET 1
>>   
>> +/* Allow Type2 drivers to specify if a dax region should not be created. */
>> +#define CXL_REGION_F_AVOID_DAX 2
>> +
> I would like to see flags such that the device could choose the region type
> (system ram, device-dax, or none). I think that adding the ability
> for device-dax would add a patch or two, so that may be a good follow up
> patch.


Not sure the system ram option makes sense when this code can be executed.

Anyway, as you say, let's leave this for a follow up.

Thanks


>>   /**
>>    * struct cxl_region - CXL region
>>    * @dev: This region's device
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 9d874f1cb3bf..cc2e2a295f3d 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -875,5 +875,6 @@ struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax);
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index d295af4f5f9e..2a8ebabfc1dd 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -73,7 +73,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     resource_size_t max);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled);
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool avoid_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>   #endif

