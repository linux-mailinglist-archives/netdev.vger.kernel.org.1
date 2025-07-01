Return-Path: <netdev+bounces-202953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C26AEFE4E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB2482C2C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9420E6E3;
	Tue,  1 Jul 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qrw5qal+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDD275AEC;
	Tue,  1 Jul 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383812; cv=fail; b=M2eJQ2+SowVfS7OZVLqh9eD82GDMaacylPPVxLAXQnbRlhys620pAiNlQ9MT+LpL4HWUWaQ7BmIaiK3t+Cs+jOQlJcMX14xpPjcjiZhBXecmGryizRfASmOmC06e5/I74JHc7xiujVhXWfArDBvy3nxEdsj5SQcPptA4NGTWSck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383812; c=relaxed/simple;
	bh=zTCTNncB+Cv875ozPo0S5dFX5MMFfsWPUbhF6nk/mFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZgDCYTDJP2b3NJi3Cnsmc7P7QAKRwcK3wpmKfOlNx3gUaClO8jLOp9n8xt7cyPM1lb7M7fpX1/kiwiJI1dzx/pbKVwvZdow/u5bx7cQqVzkYZ6a1hMCtWsM6UalmeiKBDnbxhjmZu5C8i8/YAimoaiL/JMWIT6bxwXwOyxb2tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qrw5qal+; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E215NGGv2dMsRbqhFV70x9f00h7T7JKU5SYLjiRfjU055Yvqin7e5tbHGA1VK3zFOKvmDTd+qRr/7Wth8re4Km6R+oixuehBM2NgAOomts1HybMzQgqraSVVxe1dtXqRcvdb2NQaLAsw0/MhKywcFVu27sEZxpIKym67pxrUMFS8YKv0aYpOHAGvR43D0+aLe3hLitDRkbzsgFiIQPtjUyPpv0l3CVLCMQ4Q6V/qkErNrU0DN3pg47XfcYFF5bzYTce1gcEiuorLsfsvL3QGTwvAe/I6f5rmc06Gxu0J+flImTUsUJETy1FVBtcMexq8B8TT3mouMaeSButj5a3shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDX58MFQh07OGE4zWmQ7afmaMtPiR0vcbxIjSof2kTQ=;
 b=F/vY70CUOmcdjL9ijz2lLXPmzdPbcaJN+u/fm3Jtd5KMmqTOmTgxWukvzUQV9kFHqNyqgPhrdcIYVMBx3oAsrb4OOo07wmR2cE9q0Jr9aNSg3t5lU7+BM4NUF1uiObcgaNRAuNgCA6pAbvAayGuw75wTvLs6ato9nzt8UaQb1IXW0JCGZdvzFH66VAnENPVDoqq58S0Ro7jaLRpnBAEyf/xHFPFHpl+7xQpi8iC97PCAvQmbFDzPtkXWO/itUE6Ux21KqH9e/pj/XkYEk9Vw8+OZYwnhsSX1OlnTQdePq0tNdc63geFDMfsdf1p8lr6htygrQ9eUBix+vgmIaFrACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDX58MFQh07OGE4zWmQ7afmaMtPiR0vcbxIjSof2kTQ=;
 b=Qrw5qal+OUXp0u6LeqmuU25ChLEmsteo66DU6ltBAaIR1837WAb6wUjeV3OzH+CCtpBU4m6PXOmbgltgY4IhowqtVBuDuVd7F7Y68MT9+PRNGH8QDNAle6CrWqPfQVh0l8kGGSedzhm074HvYG0PyLcAEPBqoV31ALM7XZZom5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 15:30:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 15:30:06 +0000
Message-ID: <09e46b72-7142-41ef-b0e6-c3883879cc8d@amd.com>
Date: Tue, 1 Jul 2025 16:30:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 09/22] sfc: create type2 cxl memdev
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Fan Ni <fan.ni@samsung.com>, Edward Cree <ecree.xilinx@gmail.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-10-alejandro.lucero-palau@amd.com>
 <20250627095120.000056bf@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627095120.000056bf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 467f29d7-292d-42b0-3a0a-08ddb8b42800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MC90a01XdnFqYVUzcmRaeXk3Sm5wUXJFSWZwa3FjSjJRMHcxV1EyYjloS1JX?=
 =?utf-8?B?bk5JYnlNRzIvQytyT0NvV3NvZ00veTNOMXNxQ09uOWR0TGJCMklkRmhMcHJD?=
 =?utf-8?B?ZDJXeGZNcThNazNwbkhvTFRvNVVKZTVNaHFkampMUWVIN0haWStwUkw0MEtM?=
 =?utf-8?B?S1U1MDFjYnRTRDRCYkJ2L3lUSUV5d2hwc0tkUTA3VmJiZXAyUXpBdHpHNWZI?=
 =?utf-8?B?QktEbC93VnFaV0RadVkxdFJ3WDZ4NG03YUJHU2xwSURhYTNOMklER1JQVE41?=
 =?utf-8?B?MmxXeVN5Vml1UlV2TzA4U2pwUmtlSmhaWWNhWXRmMVNwbGhrZDJRRW1HdE9t?=
 =?utf-8?B?cFNMc2hPMHlTaXhpMkVvd2hSaVRoLzVTZHpwaHFqZkk2UHA1cUs5NHVOOUFQ?=
 =?utf-8?B?c2NWTTZya3NRdmdOL1dhdDZmOFRJZ3pUa0pERENuYkRNOWE3ZEVHWXhUL3M5?=
 =?utf-8?B?YWJMaFFka1MvOXRrQlMvOEZid1lzTzZSWldDZTc3TXBjTXBBYXZNNmlPSFhq?=
 =?utf-8?B?NUROOENEOWlVQTE1bndTWmZnYlA5VDV4RU5vbVFKd2hpbkxZNHY5cElFM3Ey?=
 =?utf-8?B?cGkvd2VrSG5pZThuV0tHc0YrdFRoa0FwTlo0ZWc0VVVjL1NLNGZVNjJjQ3k5?=
 =?utf-8?B?Ym9YaWRjd3Q3dy8vYWU0ZkxzVjF5cEVUYXMwb3oxZTIvNUYvNlNlMVpIL1JX?=
 =?utf-8?B?ZE4rSWxnQmlFUytSYWRyMjRQcmEzOE9rbUdmYVBTb1dmQXgvZEtBUjQ5Ymw0?=
 =?utf-8?B?azJ3RFRxdWhhSlBQU0VCaTVvQXFFTzlObDBaN1ljUnIyNE5HUnZQU1lISld4?=
 =?utf-8?B?TmlWSktzc0FJczRicUo0WTB4dEEweWF2ZHBzWlZ3S0lSRlZDM2swN0gwRGZ5?=
 =?utf-8?B?LzRjZGJtdXFUZnl6T01CRDZxMGNXUms1S0dvem0vdGZhQTVSazN6bVlHbFNj?=
 =?utf-8?B?R2I5N0VRdHBWR0lRSXNRNzRIWkI1NDdaMCsyRWhqa1MrL2d1cjBDU3BBekxG?=
 =?utf-8?B?NzNTMThBNXNvUGh6eGp3czFPQWtwSnE0eUpUUU96WGFEYTBHam52QTJkYldB?=
 =?utf-8?B?S3RxZFVuT0ppb29pdnVvcmFrMGhzRVlCVHRzWmxMWFA1cFlNbkpDbzhvRGxN?=
 =?utf-8?B?VFBPbi9melA4T2Z1blFudi9EMlR1eGtkK09hR2FrUXJMclQrWCtTd3oxU1l6?=
 =?utf-8?B?SkRzMWpCN2pJMit6TUxIZDBESytFTEZrNndaVXBwdTVhNStIWk14SjhicDht?=
 =?utf-8?B?ZkdmL1ZWellUdXRYMEFaYTRRNHJtSy8rVmRPYlR0NUJLWjM1cjkyZ2pOTFBV?=
 =?utf-8?B?RTFRK3dzeXNwTm5qc0FSRk93VUVWQi81NXFTdExrZ0Yzank4YWxiM0dKQ0VC?=
 =?utf-8?B?MUxmWHlhalJHaVk4MlJvV0crSVFsTXdJS2JMZFZnWGZHcnZwRnRTU2pHYWg0?=
 =?utf-8?B?aXl2a0JNVWszaS81aEVIajNISnl0Z0Q1MlJ0VGNCb2pETnh6NkdGWlJtdVFI?=
 =?utf-8?B?QjZJQTN1bVhaYkhibm83RW5RV3JONVFYQmpzNW55TlcyYVlWczhmTUlwVmhn?=
 =?utf-8?B?d1NFcDE4MW1pV2U2VFNZVjBscG5lRUVnNlhzWmsrVUNuRGhtTnhYZURFdms0?=
 =?utf-8?B?TG9nZXNwSHpBQTN4SE5zaTNzUktTNXV4bWk0anZmMXJlRWtIb0NKdGdxajFN?=
 =?utf-8?B?bXV2MHVCdmRCS3FibkhCd2FVYy96Y0dnMzZxYWlNTE4xRTBwUlR2cHUyQ2JP?=
 =?utf-8?B?OFpOL003amQ0M1FsaktmSTVrRnVYaEE1V1ErNlRyU2JJNEV2NWFMV254N1Zv?=
 =?utf-8?B?TWNXZG9OZXdQekxvc2pPMUgyaFdBUGg5VnQ1U3dOM1MrRzBaVVZGazE5ZWpT?=
 =?utf-8?B?bXJmNWRvZ3J4Mk9jT3VMejhFREZLVGVYcHhIWmcxZ3lrM1JuYmJQMjlUQzdi?=
 =?utf-8?Q?zlh95zRjvVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNXRW1lSFE1REd5RDBsbFJPU0xzelYvMlI0bytLcXNobXZCdzM3WmFDdE81?=
 =?utf-8?B?dWx1QUEyTW5wRkpia0tnNDZkSkVUYSs4Q1RqemJUQ2JnajUxeVA4V3ZSeWM3?=
 =?utf-8?B?b0tiVXRXVjA2ZitiR0FLbzU5TzBqQzB0ckllcUNiQ3ZHaWlmeXo1Y0h6L1RH?=
 =?utf-8?B?M0pDSDBHTnJycXE3c3A0S2tTM21SZEZMdzZvODRQdFpUaEl6MEs4SFZJditl?=
 =?utf-8?B?MGVjZGRTb0QvMnJMWm1rVy90WmxrSzBtWDRZWWNpNU1WUjI4RGplUUtUanVP?=
 =?utf-8?B?VW16WGpaMklrQ01JWjVoUldEVUkwenJQQVBidWRCWithQkE2VTY4b2F3UTlZ?=
 =?utf-8?B?ODJPZjhNcDRUYVhZeUF3d2dLREJ3a2hiaS9pNXh4TkJGa3R0dkc2ckNGSWxR?=
 =?utf-8?B?Mm1ablpRa1RFNUVmdElWQ2FWMjdyY2c1ckR3TVpjUng4SStma1YzTzVJNFBX?=
 =?utf-8?B?dGpwY0pvSXZ4Tk9EV3dEZklKTzg4VGJxK2tUY3AzQm9kakpJdzRBd1VBQXht?=
 =?utf-8?B?dXdDVzRZTnkxdFlSZ1gzSE41RHVBaGVOOEh6U3JsN0g1OHJWUFd3dWdQay8y?=
 =?utf-8?B?WUJIODBaT0RDYlZPQURYNmlsM3NSK2R2N252Q2g3bW9MMDV5QlZWT3JDUWJO?=
 =?utf-8?B?YXFNOW14UXZKMTZseDhGYmQ5UHhNZUxWVU9nNkRJNjRsZ2Z3SjBaVjZMUUdC?=
 =?utf-8?B?bTZ3cXIvN2NNMFEzUzNZdFl0ZFg3d1liU0szMHlQS3ZmK1REZCtwY1dVVDhv?=
 =?utf-8?B?RmtTckxJT0lIRG4zK1Q2NkF6U1l5bFZoTll2VWhvZm8yV056dWZZdTFmUjg1?=
 =?utf-8?B?Z0JNNThVdjRMMFllWm9RTS9UTk1CN3FaZFdQdXMrTWpsREtIZFJ2TmplQytM?=
 =?utf-8?B?WVJ3VkYyTzNqaVNzMWFsd2poVHRwZVM3bndTV3JZWHE0TFJXNXpZS0YxWDc1?=
 =?utf-8?B?cUZVdjduTjNEZ0t1cnliSU53ZFNqTURLeXh4VnlNVWZtK2I3RDFrS0J0K3Ev?=
 =?utf-8?B?OFRpbHdmOUdWZTNXdzI1ajcxT3JJL1Qyb1c1dTV3b2Q5b0YxbTZkcEVMRktJ?=
 =?utf-8?B?SUsra3BrTWxTQ3RWTkFZb3h2OGR6by9CZGdnSnF6RHp4N0lNTEh4WXZ3MGsz?=
 =?utf-8?B?bTFveWNvSGNObXk1OHdoMzRMUGMybmo2YlJEUEhhR0w3MytKTGhjZUhYRHFp?=
 =?utf-8?B?bVpNSWwvR25ubFozT0c0Vnc4REdVemhhOVFlUDRXYzY0aGl3UkcydEVMcUJ3?=
 =?utf-8?B?eHJBNnY5dmY3Y1JCZ2g2U1YvUEY2SnMwNGpOQWxGSVRjY0Jma0hDd2l2bEU0?=
 =?utf-8?B?dDBZOGtoWDRkVEl1SUQ5RG92dEFvOXJsdnFxQzdxZ2RHbU9vaCtzUEFtUFJs?=
 =?utf-8?B?bTJTeW41SEU0dmNTKzRMVFNBVG96MlBqTWNwaVdvU281VWJyZ1B0Mi8rVWZq?=
 =?utf-8?B?c2FSNzg2QnQzWkE2V05XeGFnNDltSC9jQTRUcjJrOVhsUkxDaE5UaVJOcnlv?=
 =?utf-8?B?aXF0Ry9oZXpuUytROFp2VW9qT0gzb2ZVQ3h2Z25XY0U2SFNiVnBNM21iNURM?=
 =?utf-8?B?NGd5RENtOVJNcUJBM2ZlWTBXSUFUR05Gc3VGeGNlYm1TU2Y1RFNRa2R5WkNx?=
 =?utf-8?B?WHA3eTFMOG9HeWdILzJVcGluZG9KSHNteExiZGRMSU11ekJFTHV0V3p4OVhY?=
 =?utf-8?B?MWxjaXBqU3Fhall6R3dTUUNkb0lpUGdtamJ1aFR0eDRvQ1lUeG9XcUpVY2E3?=
 =?utf-8?B?d3VacUMrakgxVzF1RDRkWDZZWVpaam5JejJ1U3hUbTRnYTREQ0cwaHZsUUky?=
 =?utf-8?B?NjF5cElDMm84TE14TGh1RW1idEx5U3pSTDFUYjAyMzNOV3JVWmlRd2gzVXFU?=
 =?utf-8?B?UllsTkg0MlNzVVFqSkJZRjkvaDZ1KzFFSnp5ZEVMWFJHZVlaMWdJdUwvUm5L?=
 =?utf-8?B?Y2NueXR2Qm9XUVRneVNUTmNFM21FU25raWs5dlNDRHM3ZjVPL3k3aG9xQVA2?=
 =?utf-8?B?YWhaUnZuZWVFZjBycHEwNTBhUithaVI1SzZ4SFYwN2xTemNqSjVuQjk2Kzdx?=
 =?utf-8?B?Z1RJNE9xOGp5VnViL1NaSjEveFpzeXduRktqYVdQZ09laFdHd1ErODlXRXNx?=
 =?utf-8?Q?Y9lajpEYnWwNmcmV4x7xELjrf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467f29d7-292d-42b0-3a0a-08ddb8b42800
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:30:06.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XG6Aut7+77vcOC5g/ZplOCYMrOlRQHjMkYLAEMqVDbiWY2ProCZejbCidnfOVMRgpHqG83qQhQw8nQqb0Q8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294


On 6/27/25 09:51, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:42 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl API for creating a cxl memory device using the type2
>> cxl_dev_state struct.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 5d68ee4e818d..e2d52ed49535 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -79,6 +79,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   	cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE);
>>   
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds);
>> +
> Trivial style thing but common practice (I haven't checked local style)
> is no blank line between call and associated error check.


Right. I'll fix it.

Thanks


>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed");
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

