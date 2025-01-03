Return-Path: <netdev+bounces-154912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF110A004DA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A247A1B73
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C41C54AA;
	Fri,  3 Jan 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4pOT9KzJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4481C54A6;
	Fri,  3 Jan 2025 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888627; cv=fail; b=B3VUSOT7kXH6YiBZz27JOwXaepeLpXoISAE8FzSah8juHAAWug+SRvIjLEyzQlax45lMLNIFRe1PMvEGIC4u3RpSlND4I63EyDC8btO+MoEcU/mYad2S7r5W//4Cs2rShQgMqQtp1s0gkGDKFAwCaG/2IL+6PAiFMqtHPyEp9Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888627; c=relaxed/simple;
	bh=9hAg6WT60kBuZFctML2LXo07KFkwKr7Y4FenjYq4XyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBaG/t5D2kwdemntFEBALVP87A8XJyyH8xbPL6rCBQWnAaYFNhj87XOLWc6EvUw2AyS8fa9NY69ZmIs7iqSAH/soKUugamqjgAgnn51eVQv2Oazo+ZxB/HPdmKHaOb1jMRBrI2fHBX7hfrW4P2tn9Wn9iNq2ZzL5e+TbgdrhbiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4pOT9KzJ; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipNYF4ZZ+ub0lsOjW647+Hia/Xb2XjHbt01ie+riHPzWHIdA6V0xAzgzmZQdq4K2JFwODskl9HGCK6sTpGK1CiwRFwQkbXKkMcqaraaOGOfjLP2TLZFKkaY5HCgcvUYUloaK/ad/kN6qmWjJOOQTB+PRvyJmtZQCzwEuYNPopTvC+h+QHxavPh4rRU+/bRARrJZHGwDCLNM5ANVAlW8vQDCLJNrR01J3HcBCeid42usGRTVRRlWNnKKbWOE/HrW3TxJAJ+cqeDSGPuBkZgj9nk2i0m3+nOzP2qa5nJfrxJxRNHAT6DBmUrh0BnEyE8ivAcjmVOhA/3lXFRNNYCgu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS9sUAidGK7WcR1Og08VQVSnf0vb8uZwMdJe4vyjBrs=;
 b=ALQJvzteO5dgWZrhAm/2/hamxDueWpFAeG+vklRGhLPLU6qQcrDgzlQD6qz7lKn9+PPQqG9UZR9e77lcglm7qGbusVDWiTnolod0LTR6ZajumiTtSF81MWAPqNkEfsXNe9qkSvbnLfRTJnE1Qi5OSLAAheZ0qzNm9fuN44uf/QOh/lKGYqTne2McpS87iId5UzC163A4h1u5ukBhGYxJfbXQxihYJGsjrOnvsLQXb5JF1AQFEnMFicQXTqAgvMH3HdGQgQxXQdUI0U3DteRryBXU9SJ+FnOiDYwd0cBcRtPI3hE4guQBsYpN7qMJZapHS0/SHMelEAKt4ypkfD5D7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS9sUAidGK7WcR1Og08VQVSnf0vb8uZwMdJe4vyjBrs=;
 b=4pOT9KzJvj6qolRLDn952+nK3D1b+5xPwt1oLgAn3HDWden9CuIJORNlDZvFVNFfQ3F/eUiNj5H/o7CfFnEUyE6NwzPkNeg3u4B9hhrc+kMNVK5ltV4LrV8gpg0YbpqZmPNDtZo4uVKwlV1bs6ywBt4DvnqfAVhrZGIfinmUA6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:16:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:16:56 +0000
Message-ID: <04a40923-d3ca-1b4a-7c05-2eedea707818@amd.com>
Date: Fri, 3 Jan 2025 07:16:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-4-alejandro.lucero-palau@amd.com>
 <20241224170855.0000295c@huawei.com>
 <81786f5a-42b0-2e5a-c2d6-bfd93b366d97@amd.com>
 <20250102124944.0000260e@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102124944.0000260e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f616922-e4de-4190-d38b-08dd2bc69af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdTZVlXSzcrUFBCUzQzMlJSNkZDU2FkWGNMeHd4cmRoaU5Ia29LU0U2STg3?=
 =?utf-8?B?KzdlNmhhZElybVJHdmN3ZWZiRW5ZU2dvTVBIbzRldDRRS2ZjelhXcG9INUUv?=
 =?utf-8?B?OGtrQVRvWU1JdHJFYXRvUTE4YVJRK2dOemNkekdtbVBVZ3hIQmtBNmhSQUFB?=
 =?utf-8?B?NWtKWTZZem5tc2JOZ1ZzNnlHSWMzZTZGSWpEUi9jUHpVa3BxckF6QXhkRnBu?=
 =?utf-8?B?RkEvRHVsMjIwTm1ObDZxZnR5N1QvL1FoT3AyREdxSnJoeTlwdFp2V0UremEz?=
 =?utf-8?B?RUY2VDRweFdVVnhKSks0TnVzOEJUcmR6MmYrVXB1eWNkM0lPMklDTzNwMzhL?=
 =?utf-8?B?K0FNUmpaazBFV0VaSmpINGx6Sm5TQ0VUYkxHQWFQdGZHUTNNVGlTSVFCREhv?=
 =?utf-8?B?QnBzc25tNHd1V1ZmTDNDdCtZUEdFRk5EVnlJQm8rY0JmTnAydHBBVFh0dXlQ?=
 =?utf-8?B?NG9JdGlLc0NyWFRNMWM0ZzBQZjh5b1hlVWhrZ3p1aWdMekl4cUFObUNnT2ps?=
 =?utf-8?B?Zlo2UzBrSGREQ28rOFVSdEYxQitlNVczT2htVXh6cnpWTUxWbWxZWW81ZVZq?=
 =?utf-8?B?QU9hMFJpL2hTQ29QMG5jempNTlgxQUhsM1ViWFFNdkd4L21hVzJQVGtqTGxT?=
 =?utf-8?B?WnlCL3hTeG9LdCs3SnpGYktoSW5LNGQvOURsN3UwTnA2VDcrMURWbkFKSGFM?=
 =?utf-8?B?ZzRxTitzeTl0MlRLYVJjSC9Vb2pCa2lGa0Z5aUZTVzhXMTd3WEU4MUFUYUgr?=
 =?utf-8?B?RGVyREJnWkMwTXRUdHI5aFVSN0VtYlRSY2FoNFlreFd3Um5yRXo4K1FCeTcv?=
 =?utf-8?B?ekhTUFZIZ3pEWmMxQjFNRWhRUnQzZVpYd2h4TlRtNG9QazdJTzJCTFE2NGhu?=
 =?utf-8?B?TFFZbTc0MFVsWWlUQzZWRk5wK3dYYjN3T3FzSGFsdW91cTNnUlV3NXJQNmlT?=
 =?utf-8?B?N1Z4a3VZRlZpYmlCTkh4RVU0K1hSdzBUb1h5S3dsZ1FZYVRLdXVGVGJjd2tV?=
 =?utf-8?B?Q1BmcHBMU1VWaUUrTUZDdVRuVURlblE4ME1vdFNpWHhCMXlLakZhSEhxSkpp?=
 =?utf-8?B?RzhBZWtoWXdFR1VzSkVHMUdEYnF6ZklTWGNHUjRadXQwcmdqQ1N5UlEvSHp5?=
 =?utf-8?B?aWJRQk5QSFpydGZmZ0xtcG5UNTZyQmdYc0VWZFZ1TFNjQmV2R056dEtSTWhK?=
 =?utf-8?B?NEJiSjIxdVdnRHdPODVTL0VGb0l4d3VMVTE0ZERYTUNLNXdwOFFucG53Q09i?=
 =?utf-8?B?bkZrbzBEV3NlL1lpb1pmamYrcktUTk1YRXYwWlVlL1FnSGgrQm1sZUJFN3JZ?=
 =?utf-8?B?WEQ2cHZrUFdmcGxvWGkxK1BIQkt3ZC9qdldpdGkzVmJLeGJXNU5EVlgyaXFj?=
 =?utf-8?B?eWhRU1dYang1RlUzYitDS2J1eXZTY3hTcUFNZVJNeXJSNzJsODZKS0ltUHhw?=
 =?utf-8?B?U3RHUlY4MkZBYXB0MitPbURVRS9pbGhtRUtGYXhPTk9LZkUwd1pOSkc1eVl5?=
 =?utf-8?B?QThVUG8zKzYyY2NSUW1KcWZuMjIydmphK0h1NDdZTWwvVkcvNVBEVXExM3pw?=
 =?utf-8?B?Y2NLOVVzZkdaa3hlQUtHRzc5NGh1V2U2OXBOTmprQ0UwVEFWWDVwTEticmk3?=
 =?utf-8?B?R2xQa0ZzSUYyM3hpYlRUc1J4bTBNYlFUYzdrRXVuYXJCMlJ1MGpxSkpXNktL?=
 =?utf-8?B?aWRoc2dqRUZsL0FsdmE3Vko2aWVmSGNEY2FQRnBlaWxYZ3U4bnhDOEg5Smdp?=
 =?utf-8?B?R2Q5alRxYlJEbmUwVmVCLzlVUzVuWWtvVHlEeHpqaHpxNXdhT0tQcGJGUFhh?=
 =?utf-8?B?bWhSQXNkYmRqTGxtSEJxVmYvWG5mMjZwbDQrYi91N3JVMXVlR1UxeHg4Ylk1?=
 =?utf-8?Q?42x95Jjb52EKL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTExTDJIcjNNTkpSMWN6ZytLZmM3WHE2K25pVEU0RzFPajk0U05ncUIzaktV?=
 =?utf-8?B?SGEzeXgvR2pua0FtVFNyWC8xNndVV25SMnlkNkMrNkxkUE1OaGJHQ1JzSWow?=
 =?utf-8?B?N0lobTEyUkpmaDBlV1JNVUlmWGppbzJIdk5WamIzcDNQL1JFL05maHAyYmhy?=
 =?utf-8?B?eGxJendITHZmY3FpdlRMbHJIdVNveXNwUVRKeG8vaFF2SE5wTWIvanBSUlg5?=
 =?utf-8?B?aVljbm91bithR2JzNmR1YnR3OFBwK1B3QnZlOHRJVGlzS1dBZXdFTUI5UVVy?=
 =?utf-8?B?NlVNY0F6cFJiTHhTZTlhcG9iN3NQU1VFYmVnV1ArcVBtUjcySUNWQmx6SDFY?=
 =?utf-8?B?SzhLbEFOalA0ZGpTcGRDTlYrOFl2ajJPK2ozOHhpd2h1b3hWWmpwUlhnakls?=
 =?utf-8?B?YmVESTJLM2p4dmhWVHJMd1hYUEFUTFd0NVF5RDFHRVVSVHdIOGhYRUdKUVhy?=
 =?utf-8?B?TzVmb1pFbVZMNlUxVHZNN3hOVGMvVHlHUGlDdlpyRWdTVmhQY1pGL2NVZ3cr?=
 =?utf-8?B?WEllS2lpQkc3Z0l1UHJuOUZLcXR4S3RteEJkb2kxVjdrQ1ZCTFIvV0FLdkx1?=
 =?utf-8?B?YXMvdmxOY0ltdmlnUzQ0VWVLQTFBSXZHbWw1Tko3MHQyMDlqZDRFc1ptWE92?=
 =?utf-8?B?by8wNlVRNUs5d0ZLNlRmTnlBU25mUFM3R2hnQmN5Y29haTVuYWpicUlXK01Y?=
 =?utf-8?B?SFFTS1JWelB3bU5SaVRneGo4VkFrMWVZK0FuR3dZcjBsd0x6UnBIZ1JOVk9r?=
 =?utf-8?B?Qm1GTmFyaUpFR3FKejYwQ2ZDU282UnQ4ZWw1REhuV3VCMzhENXluaUpDRjd6?=
 =?utf-8?B?R0o2QkxJR3FKRFQ1ZmVQZEhjZjhHclBoZ3pFVm12ZmI2Mi9UQzZueGh1UHgx?=
 =?utf-8?B?NW1DUGNOa0h5bjFud0tDUzdNc0orWjRrZzA5Q3dFTVIrSjNUOUVRRGxsVWRu?=
 =?utf-8?B?TWlXbXRCTXpyN05VN0dKekNHdittMlB1RTdjaWlDZjlOUzhkWWNZVlhoRmlK?=
 =?utf-8?B?TmZnS21EL0xYSUFNanM0cmpJcnY5MGUvWkFyTUthbUlVTkwrZTYxRE4wQ1NM?=
 =?utf-8?B?VS93cFZsZWJnV0w4R2QwZURzY0ZuRFIrS3hXRFRtaDNRSUpQZ3pDRnhGMVow?=
 =?utf-8?B?clpZQ0VUc3kramNxbFYzSi9VMkZiZ0pLOWJIcXFBaUQ5Z2RsOFBZQXJjeDMv?=
 =?utf-8?B?OUt3MXEyOUVOUGVyc0pJRDMrOEQ2U0xHWkdBOWViclExek9aVXJaU0V1WFNI?=
 =?utf-8?B?MkZpZkxYdFhhRGk2eEhCcU5KOEpzVFlOWU1UMWo1R1dGTTJBa2VQSFhzeDA4?=
 =?utf-8?B?QXYvd0F0bmNOYzNFRkY3bTd5UDY0aU42WXpFWXJXZTlSbmd6MnNObkRSdjFQ?=
 =?utf-8?B?dnlyM2lBZm9oWHAyd3dZdDBVbm5IZ2c1aHBKeFlwMWc3UW5SYlU3WG84cStM?=
 =?utf-8?B?NnFxYlF2bWcwTzAreGQxaFgzQjZLTkxBVFdYTVVpSG4zZ2xiWTJoTVhraE5D?=
 =?utf-8?B?bXcrT3lJWVo2Wnh0aDVjaTIwSzNiM1g2WkxId3ZUdUFWSmhhZ013c200K0xs?=
 =?utf-8?B?TnVGc0pOeVVIV0FydE9NZzNjdFhYdVBFNEFiUFQyZDl5a1FBMjVROW9ha0U2?=
 =?utf-8?B?L05XaFp5UWlIREdIenpDNVJTRE1xRjQ0aXpEcFJEOG14VzhKakd4QmwwTFY5?=
 =?utf-8?B?eFNCUGg5UXlpMGRMS0tiVzV1cGhqMzhUZU1TRXZqWHdHbnhnUzRUeDFBN0RK?=
 =?utf-8?B?TEFWc2NWeVJoaHhTaHZJYk9EbFZFckViNEZ6Q0JTcGZvblo3ZDNOK3o5b0cx?=
 =?utf-8?B?S3pRaDA5OEQ0TWpweVhwYnZyOTRNNk9HLy82cVFHUkJmWWtFSDZZMllEVnZm?=
 =?utf-8?B?SjhzRXJ5bjgzSTFxc3Jhb2M4anhFL1ppKzBoclJlWWJlWHVZdHRCVUo2S3hY?=
 =?utf-8?B?bTE1c0lTRkRSV3V6cXdrb3lxdlhERTY5UlJaVnBreDBJcVp0QkFRTGFSOXJZ?=
 =?utf-8?B?cmg5YzY5T3ZVM3lkWDk0cUxwMDhYWHpsSTlBamtNTzhnOEIwem9NMDUwbWVm?=
 =?utf-8?B?UjdSZzYvWHBBVllucnVuYmJ3YVNQd3ZxVUxCck9KWjV0RVJXaFR1bzFsMkFa?=
 =?utf-8?Q?l0GqrW6+BnoCejuF6yfosu/mp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f616922-e4de-4190-d38b-08dd2bc69af1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:16:56.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omi/Xq3NbrK9COyH0mvfHSGCTp+b+P8Krw5fd4T2LAMQG2n3bNXdcZvLgw2wT+ZGncu2J4bzHSiBKquVX5Mm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333


On 1/2/25 12:49, Jonathan Cameron wrote:
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 19e5d883557a..f656fcd4945f 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -12,6 +12,25 @@ enum cxl_resource {
>>>>    	CXL_RES_PMEM,
>>>>    };
>>>>    
>>>> +/* Capabilities as defined for:
>>>> + *
>>>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
>>>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
>>>> + *
>>>> + * and currently being used for kernel CXL support.
>>>> + */
>>>> +
>>>> +enum cxl_dev_cap {
>>>> +	/* capabilities from Component Registers */
>>>> +	CXL_DEV_CAP_RAS,
>>>> +	CXL_DEV_CAP_HDM,
>>>> +	/* capabilities from Device Registers */
>>>> +	CXL_DEV_CAP_DEV_STATUS,
>>>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>>>> +	CXL_DEV_CAP_MEMDEV,
>>>> +	CXL_MAX_CAPS = 64
>>> Why set it to 64?  All the bitmaps etc will autosize so
>>> you just need to ensure you use correct set_bit() and test_bit()
>>> that are happy dealing with bitmaps of multiple longs.
>>>   
>> Initially it was set to 32, but DECLARE_BITMAP uses unsigned long, so
>> for initializing/zeroing the locally allocated bitmap in some functions,
>> bitmap_clear had to use sizeof for the size, and I was suggested to
>> define CXL_MAX_CAPS to 64 and use it instead, what seems cleaner.
> It should never have been using sizeof() once it was a bitmap.
> Just clear what is actually used and make sure no code assumes
> any particular length of bitmap.  Then you will never have
> to deal with changing it.


The problem I had was to zeroing a locally allocated bitmap for avoiding 
random bits set by the previous use of that memory.

The macros/functions like bitmap_clear or bitmap_zero require a start 
and a number of bits, and I did not find any other way than using sizeof.

I was not happy with it, although it was fine for current needs of a 
bitmap not bigger than unsigned long size. But I was told to use the 
CXL_MAX_CAPS as currently implemented for using that for the zeroing.


>
> Then CXL_MAX_CAP just becomes last entry in this enum.
>
> The only time this is becomes tricky with bitmaps is if you need
> to set a bits in a constant bitmap as then you can't use the
> set/get functions and have to assume something about the length.
>
> Don't think that applies here.
>
> Jonathan
>
>   
>>
>>>> +};
>>>> +
>>>>    struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>>    
>>>>    void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

