Return-Path: <netdev+bounces-154919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52129A00568
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B9B3A3A52
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AC1CB9F0;
	Fri,  3 Jan 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jZUnmQNr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973A1C5F23;
	Fri,  3 Jan 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890917; cv=fail; b=DMPIN47pt+c5hSxN0EtPNHrQI7eCmYVNuzmv0gD741dUl4QPEO3B9Ot8BbOF++sPr/ebjUrz7gQyQSOKGZbul2MNmWc+Qny4tmoGHrSCmaxKFvJ4Z1RpBCKW99FO3l9RcELJTIqdNuxXWy2sihvG8aji7JAL/S4nx/7G8PF4+uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890917; c=relaxed/simple;
	bh=U4nqeLawMks8U03j1AecF3FsxBsndXh1xQSbgP7r1x0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNg9CDXtTBv6TpAIQzKXo6YvH2Xwyl3FWUXdoRlf/F6Pnc5D+MBSRorqq87foiC47gz9JAe8dl5LoMXcTyO/fzduqW143nFLYVI/NlwWWOZ8YUdZf+xaQPaeNueA9MTASuXFeVUMeXuYaTwyES3j3pEsLeio5old+b068Ayi8ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jZUnmQNr; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GII4CgMoLBHwwkOc9UuPooZXkXk8cmafsfMqxsG4Y+KnfU/fjB0WLToMWf3Opp2+EQqEvgqZE05ilYRnG6fUjjyPHu/gFhn7EVlRCP/KkS0G9Sr/AT5NaGaZ9QhBDssW2uysAcYB8HpNb/ilYz+LWIgPnmuryGOFWeNv7Zp0o0f0c9KtP0ngH6ILPIPtfRrKFjZQjvyF5JWrn/Yl9GTsKEHfTWVBzfS6CNxi6ADrxHfZAU8oZozW1u8FHQmJCltPFdLJoNXl+n6EvFzY8M6/OZ8pObxQkM3kEjpuQCxZTih9ibkx+fgdJ0PXqOSUvbiBnZ+vllGkPzvGlfEBfHJiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFK/9P6DQmV0aIvfcIJcvkd+nP2SiWy06G0iDGADnXA=;
 b=SIh0S/RXwlv0mBq4Gi3nAvODtc4uulegt4fDC1eHayiFVpFM9xuQSaxZd2Gp7iaNg2nI/D6f+zyoemo5e3qP/CQ7HhgV3ENnXUaNq/Rsv8AWhmXuBYyxakKQpCz9yv5NARhjfAccG9E7FIfeKsCWR7JXE3I+TYYePsDBvabKUNH5RNcwRy9WgUalG7qawS8VO9zoubFOrbFMOX6rs/WSSajbCR5hxdkaUrq25/1qZYYeifGDUhsI+XSoPiQSeAk9VgOeLcHNLHbq9T0fzUyMq0wOvBTIXpn76oQkcrJ5rCFTF/C/+04gFyRGmvIej7LAWefKv57b6Yk+EgKtYX5qhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFK/9P6DQmV0aIvfcIJcvkd+nP2SiWy06G0iDGADnXA=;
 b=jZUnmQNrNrvscNsHAG7XtF3Q+EOezpB0SMHGWvC1iDW+KhYdpyq2R4Plgax2awfCBmrnvc36b9G3CY5GYLVafxR4Z+FbGGmvIzIn1NZmkw7L4+SiOg+7PbKWDRM6kIFiOnbF/xA0Y3Vmwj7gOV/I0LFnBa2j+6XjyO3TSJ/i49E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.14; Fri, 3 Jan 2025 07:55:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:55:09 +0000
Message-ID: <b1a8e240-abd5-9296-375e-a127e5f4061a@amd.com>
Date: Fri, 3 Jan 2025 07:55:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <20250102151009.000047a2@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102151009.000047a2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0262.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::34) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 429b4a49-4b63-4532-12c1-08dd2bcbf19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0owV1U1d1BUQXFOeXhlWnR3T2NqbWNVM1RLQ3ZDT2lNbHVqaVh4U1FrdFhP?=
 =?utf-8?B?dTdMVWIxOFlFSFZhbWdNdmZRUE5HcDdUOUx5WU1mc2FzeGhUSW42RHJZZC94?=
 =?utf-8?B?SDhrRVUvWDMxaWhrRG5iVTJ6SjBVNFdadTh4N3RtU1RGbDdITVFZYmhPMEYv?=
 =?utf-8?B?dFRvR3dhdG1OS3VXd29JLzBKSndaOFA1NTBLSzJ0T3BiTWFyMGlxRlQyY29n?=
 =?utf-8?B?WnFFbTJuUXJaUmI1cnV5UFVQNnZ0NkRXcFJFQWR3cER1YlA3MjJOSlRwd3U5?=
 =?utf-8?B?RkhyZTQxUTl0VkJWKzJMMU5RclJGbjBXeXhRNUZXbVlNYU5ETEhtRzVwQm5W?=
 =?utf-8?B?QzdTMkxjUnkxUkFJN0JsZ3JsamR1a2lzdGQzOE1vd0crc1NLRXFxbnZHQ1BR?=
 =?utf-8?B?aGJCNnh2djA5b1NkaGNpeHR1eXpuOVpjalRsQmdHbWtMOWFOczlOQWNLa3d1?=
 =?utf-8?B?R2VwL3loaTc4N3djV3YyYjlmRmtTdWw5VC9lTFFBTTBlbzBsS1VTdzJoNUN0?=
 =?utf-8?B?SnBpejFydE94SXhjUi9tMU50ZkpIam1WOWZUdE1zekJqZStHT1YzNElQRVJB?=
 =?utf-8?B?Y0ZsUzQxeEFKa25ackJ4ZFlPNjNPbTRxRWVYTW9nSkpHRGV2ZGhnSmxBTDVh?=
 =?utf-8?B?WFJ5aWVRNURXZVRyNDNpcFZiKzMrK1F2NmdJYU1reFJpb2tTMUNPYU10QU9s?=
 =?utf-8?B?SCtZdGdiUHViejU4RGFJTnFGOThaSUJhb3Bhdkc4djlwREp3a1YxMDNad2F1?=
 =?utf-8?B?ejNhL2l6bkQwMU1icEJyeklJL24ycXVQY3BpZTFoRkNIQXFWU1A3a3lxTU5R?=
 =?utf-8?B?ZVBSa3hBc2RBUjgzYmxOYThhM2Z6ZE9sendsOCtqVWFYNldhTnZ2VThaR3c1?=
 =?utf-8?B?Znh0ZUYySFVvY21SUi92c2MzdW1Ba2Mrb2tST1FPcVZmZEZsaTRkeS9aOGh0?=
 =?utf-8?B?ZU5HMkxhS0lWNXpBcWkwU3p2NjRvRU42YVNWbWMrQitESGdlTkoyNEc3aEdw?=
 =?utf-8?B?UzlYelRHZ2NpUHpKdkVteTBXOWZpZFNYN0o0WmwwSjBIeElYbmZZbXZOWnR2?=
 =?utf-8?B?VjhpZXd1Yzcxbjl0bVZnbkdxRWpGUE5zeXdrWUd3WnV4Q3lIczV2U255S3RK?=
 =?utf-8?B?ODc5SXkyT1NCcFI1N2JBeFdESWJXdzFHclNwVUpHcjM0VFgrd0huMlhtQ3Ra?=
 =?utf-8?B?U0hzRjFqWGdhd3ZCbHlnbFRWR2hJUWxLYU1rcmZxRS9JWVA4OHk0YkEyb25m?=
 =?utf-8?B?OGRma3dSUThrdm5CSmc1WkI0TkQxNDgrem9jN2V3L0U5N3g3dUI4V3hwU3da?=
 =?utf-8?B?THJra2VDS2RpNEZFdG83ei94TXMramJqeC80V0FXei8xVm9kNk5kM053NnpP?=
 =?utf-8?B?UnBUL2VKbU9zMmdaWkhiS2grSVVoSm9xVTlJVGtzTExXTmowdDYrajRoUHA1?=
 =?utf-8?B?TkFLZnBBa3A0VUFjaG05VG9LbmorS2tETklWZkcrZWs2Q1JRTHBzaXZNYXh4?=
 =?utf-8?B?TFEzeFlYWVpNQS9LUjNlTmdvTnRhWVlyUHQzTk5Na1hpZ2YvYk12aVZBOUk5?=
 =?utf-8?B?eUJ4NlBJQ0VmQ2Myb0hLbnlzbmpJVVF5T0FrbUZtR0QybFhaWFk1VXhTRnVz?=
 =?utf-8?B?Zlc0cWYxKzFKSEZyalFNblZreVVuS2NVa2F6cXQ1c05UWG52Sy80ZG8rM2Ix?=
 =?utf-8?B?UlhuYzJVNDVVRlBrZHQ0UE5VamNqMTMvNWxVM05QZ0VoQjFVYTFkeTBhSXdZ?=
 =?utf-8?B?TkVnZXZaQThrWU9DWWVUcE43ZnZsaTNRMHJKa0c2M0dOT1JGWXErdlhtMGZK?=
 =?utf-8?B?eWlaOXJzb0lxNTdBZmdVYXBGajhkY0RSWTZ1bjU5b2pvZW12TVAzQTRhY2Z2?=
 =?utf-8?Q?AsneqUlmKPxt5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNhb1hGN3Z2TWlPaWhSdFRvWk5KUlVuM0IwZCsrZHFtVDZBWW5hakhYeWxh?=
 =?utf-8?B?cGVsNTdLSjVxM1NzOEhyWnk5QUltM3ZGYW4yQ0xzdHk1ejVINFlzbnJvcklQ?=
 =?utf-8?B?dUtTWFRmQ1EzZ3NyRWI0S3IwQ1ZlRHd1ZW9DNTY3ZXRiYTM5bDRaaC9BcWds?=
 =?utf-8?B?L29yN3RmR1UydVlHbjhodVdQKzBSNkhod2Z2Tmh5YXM4VnVaTVlCNDN3MjIy?=
 =?utf-8?B?M3VpMzhHTlp5ZUZ5a3hvY0VzS1ZvR2NVeTBUN09VcWZCT2RtRjdJa2xqbERw?=
 =?utf-8?B?SlBSYXFuMkNUUDdpRjgzYmVMNGl1Z0dKNHNCMWM3U0l0K3Y5SCt4dlJ1RWJ2?=
 =?utf-8?B?a1YzVVRlcS82eWRBRGRYY1pvSUxkS3doaTFlTWlCN242Sk9UWjZ3dHlubnM3?=
 =?utf-8?B?TGJhVkw5cmo5aHQ3b1lQSngyVHFucGI4MUl5aU9rQXRUQWpaYWJJSWgrem95?=
 =?utf-8?B?emJJYUZ0aHROdmJURlVRNS9pMEtJWmRrNXBBNG1SVWF4VkNxT2JCUU1GaUJX?=
 =?utf-8?B?bHNBb0V0YUoyeUw1NDVORWYvRzhUUlN2a0ZKTjlBbUhtS3NQRzFtWUJtblpl?=
 =?utf-8?B?Uks1LzZTY3hpdFlGOHA0cG52OTMvcFZrRVpIa3J0dlAveHZRN0laRFZxVGdm?=
 =?utf-8?B?TnJ4MXp4eHg0eTE2WDBhcTNQMDVXdXRjS3VHKzE5eDlCdEtIdkdPUk8vWk1U?=
 =?utf-8?B?Zy92N3cwZDVGV01PejN3cSsrZzZzQlJEZ09wY1d4ZG56OWhYclJlbDU5SWlt?=
 =?utf-8?B?U1JWMjlHbzQ0ZS9iOVBHbWIvSTFmREkwdlltcS84aDJRNEtVQnFBTTZZOEkr?=
 =?utf-8?B?bi9sQ1I0L3JmRVA5eXlKa3R0UTNGekoxTjZBeUJJNTZ0WG45Q3Q3VzNteWVp?=
 =?utf-8?B?YjZLVnBKVGhENytUK0VHUFJXWjVoMnp1U3JPVS9pMjBtN0RybXp6K3N4ZXdD?=
 =?utf-8?B?QWZMQVZZRUtwbjVMMWg5ZTg2elQ2SnNEaklEM2N3MU5nTTRFeHp3NkV1R1h0?=
 =?utf-8?B?bTN2eGFCMVZoYWtCcld6QWlyZk10cjZWTUpXc2laRFArT29OZm9zaHFEbDFm?=
 =?utf-8?B?eHdHL0diR0tCQkpiRkNybFEvSm16Nk5XdXJ3TXB1T29ocnlsVGFYWGNqdm1x?=
 =?utf-8?B?em1rekY4ZER6bUVqWGs3eldnRTc2cm9DdWFVTmpYVVo4ZUUwRUhwYnZyWEJS?=
 =?utf-8?B?TldpK1RuSVUvTDhhK3QrYTM4dDRtMnZYNUhTWWl3VXcwbEpRODJxUmVhUHE2?=
 =?utf-8?B?YndDaTA4ZWNSZlhtbm92aHBwNWJKNFVNYXdNZ1NoeUdFRkFxbGRTdnlkTjQv?=
 =?utf-8?B?Snk1Q1kwaUlDTFRTL2NRaUlzaTJYSHcwNzVzdW5kRDlZMWNMVWJ3WCs4SVk4?=
 =?utf-8?B?OERacW9GSkpaVnRad2NSK3NlN2hpQW1SL05KQy9qRHc4NVBUUE1VK2dIbFdY?=
 =?utf-8?B?NWdXOWtlL2xUcnBtRWdKc3dqV1JOd1VsWEc5U0VkZCt1K1ZGVHMwR3RMZ2Nn?=
 =?utf-8?B?R1RTQ0tkVEVKWGtoaXRMNVlDa1dZUnBUMG8wTWROc1ZZQU1wRmxPcC9QVmcx?=
 =?utf-8?B?bzN0WFhsd0RDVnNFdy9tbFNib2VaYk5XN0ZoMEhJUER5VnVuT201MmQ0OEVV?=
 =?utf-8?B?emVHOUhCNFhEaFgrbFF4My8yZDN2aEdmREt5Q1ZLUzZ4VXRpVFhlQ0UrV3p2?=
 =?utf-8?B?UCt4SHNVd1RsbC9OTWhIVW5VNnl3VHl6bHFuMFVtUHQ0ZittcTNJWXZIVnk4?=
 =?utf-8?B?a0Q1UXoxNFJ2ZlNpcEZyMHgwS1htR3cveXhPcnJDTm0zbWMyRmxybHdBSWxZ?=
 =?utf-8?B?QVZ0dE43bHhHbDZWTTlucE9sWnBYeEh2bFBuTFJJNjRuQ2wxVjlGN1lCc3c5?=
 =?utf-8?B?ZEphWFRPV0dxYVRjcFVIUFVtYk9mTzRSWEVFazY1T3doNmZLbURIQ1UxZ2lR?=
 =?utf-8?B?RkJZcTljdEY2VFRmUlBIZ01BOUtaNTdBSVlRVUI2dWk2SDBvZXFVclNldHM4?=
 =?utf-8?B?aTVLNDFpdlFLRUFRcjlKKzNMOTdlc3R3aWc4OEpNc08xTy9BU0dvWTFPdEZ6?=
 =?utf-8?B?eE1hTVM4TjZQU09BUWtOUlozRWJCeEdxTUtyd0g3WTZhLzdoN0gyNGdTaGFa?=
 =?utf-8?Q?GAjbKJtS/Eg7iEQ5HUKA7QPSj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429b4a49-4b63-4532-12c1-08dd2bcbf19c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:55:09.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsEvjgwhrnuPHQ/COkBfqdtjC+8SZXYhUU5QTfgn7Jlyuuc1JN4mp1rmRe2ipPcZheJ+aLXISQ8FlpJnT92h3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390


On 1/2/25 15:10, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:33 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> A couple of trivial things inline.
>
> With those tidied up.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/cxl/core/region.c | 155 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 ++
>>   3 files changed, 166 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 967132b49832..239fe49bf6a6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -687,6 +687,161 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device *host_bridge;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>> +			__func__, cxld->flags, ctx->flags);
> Another __func__ to drop.
> Check for other cases where dynamic debug applies.
>

I'll do.


>
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
>> + *	    decoder
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> put_device(CXLRD_DEV(cxlrd))


Right.

This helps to see the reference to cxl_acquire/release_endpoint needs to 
be dropped.

Thanks!


>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridge = endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +

