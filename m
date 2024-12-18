Return-Path: <netdev+bounces-152845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74B9F6004
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0980016C09D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D615B984;
	Wed, 18 Dec 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PzBRa3+K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BE35945;
	Wed, 18 Dec 2024 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510135; cv=fail; b=sBYmPyAa0/uHGzjlSbH+NJ2/Eb00nnZf7bzA13fwx+G1gcBOAYdfqcy6vBL6715ID4HRKJR8CB1N0m7wTJnEAG85U411QCIecOKSwF4EiT40XmDPzRpZLiXH9XV5qaV2jW6EUcQwj+m67gDo6+3OUOKABaon8+vYorkDqIa9PAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510135; c=relaxed/simple;
	bh=ybOQ7kYTo8bZa/jRFs6Zg2wf7dfQGZXOdVLrYlPQlSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMxMetzyJ5Yc3L6MPqXik04w+Kw5jVDr1rz+K8UuS8jHjlIxjIy1nE4R99Cdj06q0V4CnpR30sSBqxBPY3a4ZlJ/PWp6MBm6GrM9GtAtTGSjowRMhLm9sofnEMIECuwuimG9TzZLnWIjdxohi5TQFvRV+5OWRE8PwJ1VbS8qzkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PzBRa3+K; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8YCPMgHI5A0zdXSdh1IgF5yQg/kZG2d6TO940/2Sitb5xaSj698TTYQZU1E2zwFZGVwdc58S8wkKWSLZjnfdl9YJ9r6GCH+1AQPrUvi0DQsqnXMqjFDYnicNI9aVyUuDvHbe7noIND81AtFcJlCoW3Zbp+O64I3lWNTx899HbmLWtbSP7dYIC8cRSsppfTIK94HKwhGzns8sXo1uTlJkrA9OAI+XhUSVXXgzWCzpijP79rRdFw+iKxZ4spHFBhsfET/yhjEqRg0riCVHgSxsZlTpo6wy6B+CbHyIK9oC2pp+VzB/KiKoAAlwPiSKo5vowkYu7zOBiVwN1Bg83lZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVKJP2JdFo2e3n2s3ostHO9taCtGaeGTD3viijv0/Cg=;
 b=SK58Y7Lv9yFhGa74SPtJ6/gA+Lii5weU/wCxYG3HF0sb7Xf5/mOZjZFy0JObC6Fimuqrg5vsqsC8dQwRx9h/SCrr8aL2GB+Yk9j2vIvOYnVIA3lkwuXkGk87seeMzPlxnONmO0aAZv116P1Z1eYwD+e6oLM8+FMkSZkw7tnsUa9c3FQO8oqZ13hQ+4Uv/TcR0+n1L+1GwiDHysrglWW1tws7bLgpm3whIoKGpx0yrAvAnfpcHDhZYufhmu+R0ivlZK/COIQr9ldxGmCOAUuoCVrWq6qFEDfeHQkBlCazyLn4Zwki3aPPmUMd6+uahA+Yc++9014uo08FcFpPQDhHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVKJP2JdFo2e3n2s3ostHO9taCtGaeGTD3viijv0/Cg=;
 b=PzBRa3+KjgaRt2rcu4l1U0nJRbe4b/2L0vFzu6I4TRlpLFQNemjsZcH8de7gAg5Oy02ukQ2TQ889JXPFsgnfeQQsn/MVyafKgPixiLv359YvN3qRIkiTEZwB69dwZ9KHChqrq8QuV+Bfu49Hv7k2wCRPXqx7gyaSpGCBUAP5jXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 08:22:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:22:10 +0000
Message-ID: <bdb7427b-22f1-9c1d-8990-9f8287fc5fd4@amd.com>
Date: Wed, 18 Dec 2024 08:22:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 18/27] sfc: get endpoint decoder
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-19-alejandro.lucero-palau@amd.com>
 <20241217104225.GP780307@kernel.org>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241217104225.GP780307@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cbdb27-74ed-472b-9796-08dd1f3d117c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXRnQTRwVC9UN2g2Y1p4UDdZY290c2RRZDhJaFVCRlEvbTlCa2lZYzNSQjUw?=
 =?utf-8?B?YmF5d0Rpb2FIdmVsc2ZlV083Tnoxa3dvRDdtYitDaFR1cGVBb3c3dVFBMkcv?=
 =?utf-8?B?M0xmaUZCWUdGUFZLZ29URkxUOXR0NWhZS09qeSs3eHp5TTBqSTIzM0JhdUZF?=
 =?utf-8?B?empmcEVoR3FqY2pFT2lOTzlpZ2lTY1ZOQm5xUDZHQ1pnbWFPS095alR1YW52?=
 =?utf-8?B?RGVIU09nVzVPSW9WOWpUQWhwUlZXeTFNdEVNQUF6T0MyWmRNSU10WWdtZFYv?=
 =?utf-8?B?aUZ2WGgxQlRPQ2h5ZUlabHNXRzMybjBnQ1NxcmVDT3FXYXVlekt5ek41MTQw?=
 =?utf-8?B?WEJOT1plZW5YVEw0U2xDVFEzNy9TbjNMNXBmbHdMVTBWUjFHMjdjUWhRcnpX?=
 =?utf-8?B?TGNXdi9tRWJYcUEzZW5IR2J0cnZuRnZlaGhVNElYaVlNbXZLTnh3QUpoZ2Fs?=
 =?utf-8?B?RjN0OE1uK1R4UDdaWldsN1hlV0IwTGc2SDJPVytNZEVjWUQyVkR3Z2UyYUx2?=
 =?utf-8?B?WlBsbEFMbzRnRTZGK0I2MXJ4UFJHMVdyMnZMQWlkby9abmJUUGowRmFUdTBG?=
 =?utf-8?B?SVlaNTlyaXdkZ3EyRFFlVVIzdWhSYkNIbytkOHR1N05Qa0lWZnNveGNLMHdj?=
 =?utf-8?B?UUJUR29weUdSaVAzeEEzVWM4SUxSM0tJemFKVjNCZFRvT29YWGlYbDNSYm14?=
 =?utf-8?B?RDVUaWcwQjZZemZnTkM0YUtxQVJCUWF4ODgvaFk4QmZEY3J4a0lkN3UwZlhr?=
 =?utf-8?B?SnJ4Uk5HZGl1SEtDaTlCYk83K0NPQjRJdXVvMk5aUm1hMkJGQVhkMlMxVmZo?=
 =?utf-8?B?aHhpZFIxVFIyNEhqODBFMU40K1hFWkR2amd2WEIva1czV2N3U1hVMHlMSWhp?=
 =?utf-8?B?ZHhvRDZKcWhLcmVXRCtPaGJibnhJZGk2amhUTVhVMG5VL2UzTVE3ak1QRG41?=
 =?utf-8?B?Q0ZOMVExVE15T29BVVNPT1dNTVY4ZmtkR3FFZWRYVlpmNlBaaUV1MFNHM09P?=
 =?utf-8?B?WlFSL2FIWWRDSlZkR2FmeHB1VkUwazdrdS9MTHRmTjR2RS94MHFXaEdCZGZv?=
 =?utf-8?B?bjdmbkNVRmw0azkraTN6SFhDQXRybzQ4Yms2RVliWjhiOXNlOVE5TGpXYUJw?=
 =?utf-8?B?QW5FRFExRW9oNG5WMWV2THN2UmxTM1IyYldxcG5GUENaNTNVa3RrZ1JvU293?=
 =?utf-8?B?S2hTUEZBaGV3cloxVG5acU0wN0g1cmdJU0lnK1VYeW1YSjVtVU5jSG05dUQ5?=
 =?utf-8?B?U1NpRU5kWE44YUNDT2ZNTXpwOW43VGdpbXhLaXViZG1zUi9BbWVaVDduN1Iz?=
 =?utf-8?B?QkRuUkhvcEdaY0dUQnFHalJKZnFWVGdWZXhCK2JPWXlRMVBIUHVMVVFKckFP?=
 =?utf-8?B?dUpWMFEreVhBbERDVEdtUTM4MkRlQnludHdQNnMxRklGNTZOVWhpbmdsRGtn?=
 =?utf-8?B?YW44WnZiSkR4ZWJyU3dGVENtbUJtSXU3VFBiNDlFYjE0U2hLWTR4MTd6c2U3?=
 =?utf-8?B?Yk9IOGdYMEdnMDlpa3BpdjFScUJzQW95dDRISWRaSU9WcURhVERQamhBclZy?=
 =?utf-8?B?WHUrWFVlcFMzZlZ2ODBYY3NWZHozRmpvRUJJQ0hhRmhvSEFyUmFqdGZrOElE?=
 =?utf-8?B?YkJHM25sVk94Vkx4bGxTNmQ3VUpXZUloeUhxcGxoNUJkOGpTeXpiQjlVMTE1?=
 =?utf-8?B?ZjE5cjhkRnJXL1FCRmEyclRXRXh2MVpYUHJoQm5QS0hhSzIvNUVQeGg1Z09C?=
 =?utf-8?B?dk5aMDFoRitPZzR3SEhmU0tRTVRQU2ErZzArUjhVZG5Yd2VqdzlmTGt6Ry96?=
 =?utf-8?B?QmpoQnlpN3BKWXBBZGF1cjVKdzlmQ3RQaW9zSGFhRUxMRnpuWHFpK1VuUTds?=
 =?utf-8?Q?f3b69ztUq3DYM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUp0VG9NaXRMYlJPaWFzSWV5cmlaRWYwTndZSU5RSkdDVitndG56WUliTEtw?=
 =?utf-8?B?V09WMkkwWDhxeEwzQ1pqVVlWN3NtMExpYVRELzI2RDIzbnJQa2dJQ2dscjJz?=
 =?utf-8?B?TzB2ckJ6dW9NVmRSTHlMTkNwSUJsRWNraTVvSUJBSlZzaFJXNVZJTld4aUY4?=
 =?utf-8?B?TU56RDRTTlQvQ1lMKzJta2hjZHE0QTMyRng0SWs5SjdSc05LU0FWTzlnaG9v?=
 =?utf-8?B?VVZ4VzEwZ1JibWRWZW9kSElKYllQak1FS0tZaWltOFU4czRWK08rU05jV3k3?=
 =?utf-8?B?RnlUWnN3UENaSWZua21laFg4K2VBV1lnYW9KVHlGOEpFd00vcFRINHQxT0Z2?=
 =?utf-8?B?T0c0RmJ2Y3hKN3lnaURoODBDYWlLclNZTkNPeWJIVnQvMkNOL2pvRWNHbHl3?=
 =?utf-8?B?TUdvOFp0UDhnVFBHVGZBNEhYclpKdng1elNsbjRTRFNXNWV5WDl2OHJEY0tY?=
 =?utf-8?B?WVV0Z0dhN3RabUNtUTV0MnpqbFNCNnNjQU44K2YzcTZzbUR4VEVwOGN1TkNN?=
 =?utf-8?B?YTYzZm1sUWQ5dzgxeS9FTk0veDVsUytLYklXc3RQSHVBN0VsZzZXR3U5QWUv?=
 =?utf-8?B?Y2YxaXlrQnRQQ3I3VkN2eUw2Q1RzSUNLcHdEUlZkWWt4R0ZkMUVRMjRFakEx?=
 =?utf-8?B?LzBmQ0xpZ0NGcXZnT01BaTRqcXpuSjhBeXM1UVBlbkthM3luMXRoSzVCbHBO?=
 =?utf-8?B?VHlvUGJITk1QUDJNVDg4NFV1a05wWGlEVnc3U0VFekVHVUc1R2ZxRStUenZO?=
 =?utf-8?B?QUJlQ01sSXRxbTdBNmNzaDlQVC8xSTR6VDVUVGVlVEh3K1g0WjJnRVRMN2tW?=
 =?utf-8?B?ZHgveWJOQmYxKzZ6NS9hRm01cEY5THdiVWhZUk15MHoreFlUTU00OTVYRHIv?=
 =?utf-8?B?TURydmQ5Y29jcjRIZDBIb2krUE1oSUJsaUVJU2dQdFNENFFkZHQwYlJjRTV2?=
 =?utf-8?B?WGdib2xoUHVaYk5oV1dzRjEwM0hWVDB1cDlUT29lS2g1ekpkVUNrdG55UzBs?=
 =?utf-8?B?b1lXdnkwQjRQMDJPeldZTllCLythQ213UnlXNVd6M0ozYnZxM2xxaStLYis5?=
 =?utf-8?B?MXBQZHplOVhQUHF0Vmo5V1hGTHpUaXM4dktLQ2ZFbHNicGxhdFRJMnhtTXVY?=
 =?utf-8?B?QUpIazRQNFN2OG56MlhWNHFpSHJJOE5LMnZsL0ZGM2lkcFlnMzVsNnMrWUxs?=
 =?utf-8?B?K3h5eTNUWlNKRXNUTlNHcEJxa0tOajZ3dkR6M0ttSFdudzFydmdLUFliZjlz?=
 =?utf-8?B?SzBwcGl0VldEUTFLTWlUdVNrbTA4L1VYTDlKU1MweXdIOGxhdjdYRUNOSktT?=
 =?utf-8?B?Y0lINTExQXB4eFAxZ2YwTW5tU1oyaVZZR2JLcG1QSkRqZXRieG1sQUUzZFRQ?=
 =?utf-8?B?SkRjVytjUGg2cEo1UEJZci9kM2tXczF4SWk3OEJQbUh1UXI2cGxyOXJ5aVpP?=
 =?utf-8?B?aEc0NTRiRlF6SW85bUJucWNCWENka3lNOWZZdWFtazlWeXNmc1Rvck9FRWpF?=
 =?utf-8?B?ejFHcEIySmVVNTFvL3RoanFGc0I2MFpraytyd0xIa0pyeitmNThObDdxcks0?=
 =?utf-8?B?eWR5Ky82a2J0U1lmd1ZpOXo5eWRLU3NHbEZuVUxTemZLUlI5clBKOXBuWU5z?=
 =?utf-8?B?QjdpSk0yMzRYMlJOQ09leUFxNCtYQ0lvRGFtWEg4d2IzQXdyK2dJSk9ZNU5K?=
 =?utf-8?B?MFZRRkJMZk1GN2ltVXVTQWJ2L1ZhS1ozTlJ6bWZySEl3UndEeEtPQVd2VFhm?=
 =?utf-8?B?ZGM5czNwTG9reEpDTFE0dzVkMHNPVU1zQUFhZ0lsUzZlOHZnOXBVUTRRTEI5?=
 =?utf-8?B?dy9TNVN4V1VMRnNrOGQyYU4xUk96aXhlajd0ZE1Ud3NEdngxMEIyZFVmbnNO?=
 =?utf-8?B?SWJjcFBhRlJMSlJ4dytUUnhJdHVXTk5ldk1mSUJMMnhHSkp4N2M3Z3RmUEly?=
 =?utf-8?B?em9HRXUvVzd5b0xVdHo5WWNiL3pyQnJ4c3JhaTJaUklIVE5uSXprNUk3MzY3?=
 =?utf-8?B?Yk8vTTdZZWxrYmcwc2VpSmVXMURUN2c3U2o5SlB3NnFRenJVNlN2SlphbEU0?=
 =?utf-8?B?UTd4Q1JBVXg3VEc2TXc4WVVxc09MZEM0QStvM1RiZkFjL1BsMlg5bHhFbTJz?=
 =?utf-8?Q?CLIg36rYFDaxUnPDtYBBwhWqh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cbdb27-74ed-472b-9796-08dd1f3d117c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:22:10.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BbqJSuC0J1qXSz76uLre7H6/9bT6by/fqoifAPwqGFpm9MP9u2ycr2T1poHaLfx91KywYiHghQhaQ+zHRbECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872


On 12/17/24 10:42, Simon Horman wrote:
> On Mon, Dec 16, 2024 at 04:10:33PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 253c82c61f43..724bca59b4d4 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_memdev;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (IS_ERR(cxl->cxled)) {
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		rc = PTR_ERR(cxl->cxlrd);
> Hi Alejandro,
>
> Should the line above use cxl->cxled rather than cxl->cxlrd?


Hi Simon,


Of course. This one has gone through a lot of eyes undetected!


BTW, apart from the fact that I should use Smatch from now on :-), out 
of curiosity, is Smatch only detecting one problem each time? Because 
this patch had another flagged issue in v7.


Thank you


> Flagged by Smatch.
>
>> +		goto err_memdev;
>> +	}
> ...

