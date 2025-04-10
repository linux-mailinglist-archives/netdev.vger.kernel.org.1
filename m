Return-Path: <netdev+bounces-181218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9DA8420E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD10179014
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1D20766E;
	Thu, 10 Apr 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivWsPLdb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177471372;
	Thu, 10 Apr 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285716; cv=fail; b=Ix74kAehnBtBJErEe2KH7nW7k1eNolWjTpVVRiIwYhqXpgHnjrGanpZfrZ9nYgQxVn0agCCxo2bM86PfPL4VOQy9GLZpxw/f1xQd/Zu1ABsr60diPRoQqOO14WD/OH3UlEtepVuHI1XR6TM4oYS1FMERiaRycnVP47HjdqNgJ5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285716; c=relaxed/simple;
	bh=FoVSrYg5j9GwUBL/f3w0wPafM06FJ2L7KKpOUhbP92Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rz2kiLPEcHJs4zrqN80fOVEVeSbEJYmZkPLYLBcqpyn/SCy2uWKO06k8fwYDGyT34EfEmPfSWbGjMN3VuxWKXYTDjUqTLvCCRjAKQG1I2wNF+mS711TgtgVB87ES8t+pByoZJKFxxR0WkbYpu3KwrOsi+AZNAQGSlxe0gM8s/Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivWsPLdb; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOccqcg5WMomsb7ihckRMajaloEprKoa4fXul+6XVUl1Bd/0Mw9AkRatbKa6Vt+cumXfugkuoSO3/h2Pqwcj1IGNMjKLD/tnHQg26tWBC8i7cSWfP54n+c8+Cy3AKNTesqThEwa1mDYWNUXnloJlv5h5NjNIIZinNDDrPojh3RxxHeqUBkR8V+Krmb9DySNoY3ooYcqPVD1WsrTINRVB/tCuiwwXxmX5/33NBf2RFIIviS0irtO1W++AOfyuGbtfHF5tW29sRqFo7tfCAjJNMu2e59PORsFiMs/1JSVEjRS82CHpS1yHlM0lJaY3RCYJEZrta7Kg/7o7mgiSrzqvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWYSggkfMFpb+heAZ9Ng/nsJhlQBsLyy7taIccS2W8M=;
 b=XmY9fWe6ZCQ2Yi547EVltqD2j5dfKtFxB7+BP3oNZrK1+wSwCii5xHiRXFb6MR/FIHihv1NsvQky8gwFrKh6O12aNitDMV7eLdQjEMGWITgEOWG4UfG0R2UJOSpMF0tUQYaUeXKpcPh5YptJDnlXkHEBALS7aQVM+hIJ6WvPlz9a0sMZy2607loFjccXPXM+Ac0wB3qckFDGKsE+RUF5O4szyVcHyCRH6fE0RXiYArZY+34pSkyVXkuFcoidIcmkCqB6qW4C1Pl3T4WGV8QofrHFV62yJjsrx6HuH7W8axHzYWlPKQKsowkgxusgjUdMvFYCKFEFcSqrrGpOg+DTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWYSggkfMFpb+heAZ9Ng/nsJhlQBsLyy7taIccS2W8M=;
 b=ivWsPLdbrdVhhlTpadWrNEsIMNC0aPoSRMUpRdZggWUdg6mqBnVehfI9Hs/qpvvGSzJ79hfA86VXnTCuSfNYSaHwVxy4STEGF4ODD1jpbSM7lCfssr0g7vi5r1PBGJcIO/AqfHkPKPjyQCRVLDZ0R0a50vE/m6diKgBYCllSHu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 11:48:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:48:28 +0000
Message-ID: <78176881-2514-4059-a0b3-778e521f56a0@amd.com>
Date: Thu, 10 Apr 2025 12:48:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/23] sfc: initialize dpa
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-9-alejandro.lucero-palau@amd.com>
 <20250404171253.00002b41@huawei.com>
 <2b4963f4-0a1b-485c-8198-b9abf473f0ef@amd.com>
In-Reply-To: <2b4963f4-0a1b-485c-8198-b9abf473f0ef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0490.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 64827e60-2e11-4b3e-5d8e-08dd78259bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW1TUFJjQWV0dWhrRFZtVkVGR0l3K0NZRjB0blQvd1d6dnhKdVlqS0htZTVk?=
 =?utf-8?B?UVFONkNqMjR1dWVNU0ZuRUJUWmRGWldXV3A1Nm5YTkd1VCswN2xITDIzb09B?=
 =?utf-8?B?YzRVWStscXlubm01TDNMdStFSUVhTUNoOEZiVWR2bk8xY0FHQ0gyRXY4ZlZ2?=
 =?utf-8?B?KzNaY1pMZ2U5eFpMMmRuTVQydGRaREFiQ3RpSksyTmpyRE5oclBEUzk5Y0Fo?=
 =?utf-8?B?YVNIUVh3QWRQTk5ubWcxMHZTYlliVEdWZ0srVG5RVlA1ZWJQVVNWMVFnMng5?=
 =?utf-8?B?TVhoU1RJbkMzczZqWGpVR1dURlNtRlltNVN3SWV1eGt6RFFFRUcveHBiNnVs?=
 =?utf-8?B?SkVpZ0NEamhsRVlPZDFqQmhjRVovbEsrN2ZPbzVWT2s3U2lqOGxXdGJIQndC?=
 =?utf-8?B?emdGVHVxcHE2N1JRTjFpR1grL0I3VTFvUU1CamhxUW9IeThHY0pEZ2w0UEh6?=
 =?utf-8?B?U1hVMC9hUndBcXZzNitNMTFod051QS9WY1lKMGZuUVVqL1ZsVkFNUWd6UURQ?=
 =?utf-8?B?UmFhUGVRZGFOMi9sdXZRaUxYYXFVWGZoUWJ6STR4ZTUvV0xHWmYrMDVBM0xX?=
 =?utf-8?B?M3ZKZ0dkT1FRVEwzTXljdjNoRWIzcVFoaEFDSllLSXE3YjNIalFvbFVMVWxC?=
 =?utf-8?B?WXpsUFpyUU9ZYkZjbTZEOERKTXhjYW1lUkJPdEdIWHZpUzBkTGdYNXRsTFQ1?=
 =?utf-8?B?UXJCWjZ2OWwwc0h4ZmVoZFZ0WlkvUFd1N3VIMzl3SGxPNVlKZ1NRVVBVak1z?=
 =?utf-8?B?cDFnWGYxQ1BmTGl2MFhtTkU3dlplTkI5MjJBV29uOC9FL1JlVEFHU0pvS0lL?=
 =?utf-8?B?d1JoU3VhS2pSdmt0WlJxMDUzRUpJcXc4YmJ6WnVDOVRPbGRpZEkvSmlVUWtJ?=
 =?utf-8?B?Qk1zRGRqNXFKQkJhSjk4MExPUVdGYkx1enZ2KzEzdStHRCtZUm5LYlJEYmxP?=
 =?utf-8?B?c2pxUmM4bVlVUTBKRjdva0VkczFRaURVcDZHaDNPbEo0UFRFQ3BkSWQrakFU?=
 =?utf-8?B?ckhEODFqYlowSGdDL1U5cCtPcFJhaWRqaHZSTHh6cHhOSll1aDBEMUJZb25P?=
 =?utf-8?B?eXFWYWxsc0IvZXpTaDd2enRGRmxOMmdLb1YyVjVBOW41eGN5SWRadTMwYXE3?=
 =?utf-8?B?dGt5YjlqNDRIYjE4YWVHZ29QWFVlYU1TMmNqalRaVlVCUG55MFdlN28wR3RB?=
 =?utf-8?B?N1VOUnZRU0ROd2JIQ0RGUVVDYkZPREFyZ1l3b1R3c1ZpTGhzZW5sdFIvYUFs?=
 =?utf-8?B?UjRsbGk3TkhsMWxqY0t0Q0dOUWVnUnNaQVladEhzQWNDeW5DeGpHTXR1ZHBs?=
 =?utf-8?B?Z3hleFUwcSt6NjVkaGpmMUV3MDB3bDBDRHpDdU1QZXhvZG5abCtUaUJzdFJu?=
 =?utf-8?B?YVZvRkxvd01kY2hOVXQ3SjJ1bXM1U3pDRU1lZGl0QWhPdDBIa3c1dkJKdHhS?=
 =?utf-8?B?bjZYWmVtTExEbzVWUkowZllqTzB0OGQrQVdtL3ZmcXZ1QmRHL1R0R0EyYzNF?=
 =?utf-8?B?MncwYVBxK2ttTWxtaTVuZFlnZ245V0F6c3dUT1NQN3NiTFBvTW05NDZpNVdI?=
 =?utf-8?B?M1J6bk1QNFAwMnQ0TDRCWndGRnB5NE1VamNkQ09STi9BUTczRVkweVlvRkpL?=
 =?utf-8?B?Vnk2aEcvZmMxOXBOQ1ZVT1BnVExDdDVQeUFvS2FuWkx4QXpTaU56ZHRJRHZz?=
 =?utf-8?B?b0oyZWhhSlJiQ1ZEaWZEZUtQK2tIS01ZV3ZuYmwwckhjNnhocDRoZGFFZy92?=
 =?utf-8?B?ZnQxY21pSkM1dDFJTXVSWjlHK3B3QTNiMkcvTUNueVBFZUo5SXM2UmpXNzlT?=
 =?utf-8?B?YWZ2UzNqUXRveEhUei9FUUpwQ25oWDlmQXVLeTJITmpWcUdLK1dVMC9GQ21r?=
 =?utf-8?B?dTRmclp3WWtpRGFYa1dqdytXRWtDNHlOcWpIWVdQczdMaWJyM1I1S2dEak94?=
 =?utf-8?Q?fVpKGv4X7os=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0I3OS9tRnUwSjhsUXB3YytTdVp6ZG5NWWtuKzZEZ0JSRWlDUlZha2Zrb0hv?=
 =?utf-8?B?TFdtamh2R2NNdWJCSjg3elRQcFVVcWZZU0Z5cUxCSm41d25LMm9PbWJNbjNY?=
 =?utf-8?B?U2pmdnByRFN4aE9EYWxPTmpTcjRnT0tISzdtVHZoYTBpTm5TRjJBSDNNb0k0?=
 =?utf-8?B?aVZheUEyTGF3R1lQR3h4U0VPdFp5eEM2UTNOV216aGdFVmFWOSt1M3lRQk9a?=
 =?utf-8?B?SjVWaXpkVHkwYkpYSHRWT3hIL1YvaXU0Q0xHZWJRdEpWclZMZUNMVitXL1Yy?=
 =?utf-8?B?Tkl3bzZYaFU3L3RLbkhMbElPNGU5T2lmOXp0ejF2KzdxU0NlNGsyU3pwK0Nj?=
 =?utf-8?B?blMza1d4d3JENlZjVkJqclFWL25rVm5YRWNkdnQ3QnlEZXNWV1lVK0g3YXVa?=
 =?utf-8?B?RlNVdTExK0sxNlY2RnAvVU5HbFFpTHFPdGkwak9rMy8xU1hpRzhPVkpoakR2?=
 =?utf-8?B?TmlVZGdLMDNBUVd6UGswbjc2YVVmZTJKdTVDempoZVVENUpmSlB0RDhJN21q?=
 =?utf-8?B?cXBGeHFoaFJLWWlDTFlDU2FFSUNNWU1lamM5ajVmL01mb0t0UFUyMnlHR242?=
 =?utf-8?B?cSsvdjQxQXRDTXY1Z0xGQThaSnpmRDg4TGd2K3NjWHhhMjFZYlhhNGRxR0h5?=
 =?utf-8?B?SDB6ZEFVTXZYSWNoU2o2ZTVHSFJpRlA3OVkwei9hU0NwWHJzbitZR3dOYVFm?=
 =?utf-8?B?ZzJxV0drd0hhZU54SkVsQldlQ1R4MSsrcytXNUpMZ2dKbmE5Qk0rNk83bExG?=
 =?utf-8?B?ZVRlbTY0QU9CaEhDSUhRV3hvU1Y1d3lkS2FHdjlNei9kUHhOTlJ1TDVKVkx4?=
 =?utf-8?B?MUJVWDIwOHQ0OHRpRHk0SU5zUXNIa0tBbHN0QU1LdHlWMnd4eHY4OE1rVmtm?=
 =?utf-8?B?cDVCVVordjFaSDZxQ21abTN6VG8xRXE4TWNpYXBoV01DYnZ0U2phdU0wQVdL?=
 =?utf-8?B?L3RqZmxxZWVEbUhtNDBNOXQ1aGxnbjN1RTdiQnhQdmZCODZ6RFBlakU5d1Bp?=
 =?utf-8?B?Q2h5UTZKRThkWDcvMlpNWmN2dGIzOGVPZGUyVHZKR1JGNXdVSUx2R0RIenRz?=
 =?utf-8?B?TDhKZVZiQ2pBMnBJejQvd2FSN3NlR1N1TjdEcVZGODgvS24rU2RkSXZIMFIz?=
 =?utf-8?B?VHdwWEI4V2c3Z2IzMXNRa08vQUtwOGUxVmZ6N0d3LzZoenhhNWs1cWRiMHRM?=
 =?utf-8?B?Y0IwcGlTRzVaUkpUb0ozbE92NFRKb2J4NUNobEdvamxSS0E5d3RFcEpMZXc0?=
 =?utf-8?B?cFNIZUJzaDZPNHNhZlQ3NDNSTmpSOTVNWXl3Vk9TQjM1eHVQY1ExaVJSR0h6?=
 =?utf-8?B?RDg5MjZQSFZudGRsbDVnM2dldVNtZVByZEswRUVWUUowMll2Z3VGT3BCeFha?=
 =?utf-8?B?SDFDTXJWbktYalZSc3RBMnR1bHZhUE9JOUdTQTJJY2VoeDAxZkFIQWZCU01I?=
 =?utf-8?B?Z09hY3o2OEgydDlYRElqakRJMldWU0sxU2xxMFdUQnpQMDdrUDlNWVFNR1FX?=
 =?utf-8?B?RFc3WVJtUnhZUFNjbGZ3Q004eVMwY2o4UktZbmtXazkrNEloZmh1aUpaM25W?=
 =?utf-8?B?OVZKYjUwQmphMURTcHpHc1duUXYzVjUxemhaY1pEZ3k1NUF1VVpVUE9CVjBJ?=
 =?utf-8?B?M0JDcWJFS0I2SEN1bmRXa3JTZWFmMUhQT0Q3bUwvREV4TitZMGk2TTE2MXdY?=
 =?utf-8?B?WG1xOWU2WXNHTGFSMVZDVVFTQ3Z6clJlRTBUeUpqMDBJUnI3MXNZNjhxd1hu?=
 =?utf-8?B?L2poUWxuZjlBcWwxQVMrNXJrZjFHcUJaQ0hxM01KYkZNdTlJOWxFTU01c08r?=
 =?utf-8?B?cmRoRTRIMjlHb0JPbWxCeVk5YmkxcXhicXcyWU95RDFmc2RGSytmNFJodU5T?=
 =?utf-8?B?OEdLalFIeElKMm1IMW5FREg5UUdnV1dQK1hRSlpUams4S1JlR2M3UTgxZlEr?=
 =?utf-8?B?bEVSV05Oa255SHV5VGFsbXMzWGR6RHFraXNQL0NDSVl1ajJVdEpsVHljRFB6?=
 =?utf-8?B?MVZ4VlZNT3ZMQUN4WGZZd0JsTEg0dGhVVUU1eCtOZVVYa0RZUTZoQzVqa2Nl?=
 =?utf-8?B?OGhDWHRtTXhuNmZ0dlQwNXoyTGMvTWl1RkNmNEhEbC9BbWJEbGtOR0VGMTRH?=
 =?utf-8?Q?EOCgSNVL2q9tg5dGBwVTZdjCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64827e60-2e11-4b3e-5d8e-08dd78259bc2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:48:28.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d6Kn6xpmEaki3cZNxIIw2S4jo8x9UOFJWgMXwgjuibaxpxx3QCGAdqPphr1ZqqEjNQu9b70NScEMn18Fznc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247


On 4/7/25 12:01, Alejandro Lucero Palau wrote:
>
> On 4/4/25 17:12, Jonathan Cameron wrote:
>> On Mon, 31 Mar 2025 15:45:40 +0100
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Use hardcoded values for defining and initializing dpa as there is no
>>> mbox available.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 3b705f34fe1b..2c942802b63c 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -19,6 +19,7 @@
>>>     int efx_cxl_init(struct efx_probe_data *probe_data)
>>>   {
>>> +    struct cxl_dpa_info sfc_dpa_info = { 0 };
>>>       struct efx_nic *efx = &probe_data->efx;
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>>       DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>>> @@ -75,6 +76,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>        */
>>>       cxl->cxlds.media_ready = true;
>>>   +    cxl_mem_dpa_init(&sfc_dpa_info, EFX_CTPIO_BUFFER_SIZE, 0);
>> Maybe it is simpler to just pass in the total size as well?
>> Here that results in a repeated value, but to me it looks simpler
>> than setting parts of info up here and parts outside of 
>> cxl_mem_dpa_init()
>
>
> I think it is not needed once we initialize size unconditionally now 
> inside cxl_mem_dpa_init().
>

But after my comment in the previous patch, this makes sense now, so 
removing the conditional code in cxl_mem_dpa_init.


Thanks


>
>>
>>> +    rc = cxl_dpa_setup(&cxl->cxlds, &sfc_dpa_info);
>>> +    if (rc)
>>> +        return rc;
>>> +
>>>       probe_data->cxl = cxl;
>>>         return 0;

