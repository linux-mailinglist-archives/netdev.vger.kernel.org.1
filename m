Return-Path: <netdev+bounces-224802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF1B8AA7F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C627E5EEF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764B319601;
	Fri, 19 Sep 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hybKkB5j"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A731DDA4;
	Fri, 19 Sep 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300956; cv=fail; b=kTOpJA95mq0G0BfHSUFcLvHnoqB8o5VuELTcm3cu9JRZd/349aSz3YXR8QzeUm6lo89hzqS3OwIVIWiHB+2TrfY1z4P8ESLQYXBdjxq2CZpSMxnPABnPKo+EAK4QWJJxzqLOrP2QeuN0h8NYzp/y6PPepNFRUZ7fHeU/SX5ydP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300956; c=relaxed/simple;
	bh=gx9JmbafFRh/auqWmVQa0w0xM8sm41qn+7+TtjhfMcM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYIt8ggk81Nax/JvHtwK9ammpUzTnmqt3qr2KvqKt0QkJSzCJJs4sjI5oe7X3f0FoEOpJwZe97kiCuUbpnx4FiUcEcGPpdIsya9JqZ8heLEL55/RdG5Ua2DUUp9zO/NQ8P94jjt632A01tcnACpNES13CvFKfoa1RhtmsAfZgog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hybKkB5j; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWdnQiMghtvhCmOOqadatt1zcMTUoHCSWZoabGSNwT7bdqXYWOv3EZpE7zL9geQgKERjE4ug5Dsea5OZTijVt2UwGA0aadcmpBIYna8/bRWtLl2o1wmC9afsoBLW6Pq4SCLzE18/+eh3qNV1POlhhJvdyphtO75WQ0Y7m+2+mhOGfS3R8mUh/2E7+N4eX3RVs6PfAwpf2EeWU7zYnlM4/9cBuNGsNz7qo5DU1DGczoP/kBzAVI/r2XjEFWP7JoPTLzJCeqnr71N3PguNrpGjWz7LG+yKwXWY8eQQw006wJmN81bvuiq+iNB3rSjXeCzr2szuzxb6FSg1N0HSz9nakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx9JmbafFRh/auqWmVQa0w0xM8sm41qn+7+TtjhfMcM=;
 b=T7qy/VkO2XP2fT9D2CiakdVcN7DW1gIcm8xHIZtFJmxAuubxNsVdEOIccXmM0IDL1QB4DwQ0DpI/zJ3VpIpdczDEFPN9ACkz+eTDQl+5uiliE/6qLiIYckmWnyS/7RPh7NTvJifs3cgJbVRNVubwgeZgK0ZIimYT6jnkXHhPfX4e0EgIFP7rYctr+VKJpdykAwFGe6Jw1e3/2OMOxfzA/ZL8oowo7inf4q8rlx1K/PSkNGK1a49vKW2QsqNiEIabQ3xTAjnro+WWl5z4QMvo5Mc3yozc9lV2IQHM0PHyixl6TOqDawrOjv0hL0NGumz/FMp9KFO9LbXPnCNc319e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx9JmbafFRh/auqWmVQa0w0xM8sm41qn+7+TtjhfMcM=;
 b=hybKkB5jXuliiKH/zAYt3WHHx5oPRnWmWKy8p+u+7AOSXwyqQhCYeWOLvFhBUbeXLn1CAk892+QcDWvkEV+b0GlsXAUrNo0GOVGwN49u6fvNLOB3nSXqA6yXnqL037vyXsqTpCtQ7TMhZdH9Emn2HBsg/BtyyFtZO67YY/VJMDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 16:55:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 16:55:51 +0000
Message-ID: <c012498b-d9f9-439a-a926-ef5f10689bf7@amd.com>
Date: Fri, 19 Sep 2025 17:55:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 00/20] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <33f5b788-c478-4279-bf9b-a5fc1000bc23@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <33f5b788-c478-4279-bf9b-a5fc1000bc23@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e09dad-a951-40d0-ff4f-08ddf79d63d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmQ2T2VCOEV3aElROTg1a1dkWW44L1V3RmxoT2o2eXNVRUFVa0NyYlQxS3A0?=
 =?utf-8?B?VThZM1BQMDZqc2xEdXJlazdtcTVHVkdzSGg0eGFtRFVZbFhuRHF0TVhzVjhV?=
 =?utf-8?B?MzJiWTNlbTNYWmpsV2Q5UVI3cWQ4blMzbFlWMDNBY2sza093SE9Uc0xEUTBt?=
 =?utf-8?B?bEFSU0M1ai9yVXVmSE83WFFLZ0JFd0k2TmFyakRwY3BXMGJWc1U2NTZNekZ0?=
 =?utf-8?B?RjhJQlhiYm1oZHMvTm4wQ05jQjhxTkpHeDRqTjR0bTVBTVRJdkFEQit3cERM?=
 =?utf-8?B?eGxOWjhNNXdHa1IxYk1MZXgvQmZua2FxWEJSak1wcUVTZGpQTVQwdW9tcE1z?=
 =?utf-8?B?UUwrMkYzMlJMeWtsSHYyYi9SOUlOV0g1QXQ5RXhTU1RYNlpGY3VsZXU5WUZC?=
 =?utf-8?B?M05vYUlOSFcrMlExclg2Mk8zVHl2ZlIrcGpHUWFtSUlQVzBEYUZxM2hwUkQ5?=
 =?utf-8?B?K3ZMZzdMUloxT3RCNkt3SEoySEg3Z1VDdDY0ci9scklvVGhqODdqSSttVzE5?=
 =?utf-8?B?NDRpbWg5amdoUzNOWkJsZXNsYVhRZm55VWcxTmxnY0ViVzgyYkY0N3YvSDJH?=
 =?utf-8?B?R1JQQU5ud1AybzJCcGt0NG1nclFsUGNKbjVCK2VFT2NHLzlVMnRsanduejJx?=
 =?utf-8?B?UDZ0aTJTSjVFNk1jOWVVaWwxVVpnb0lWRXA2c2hHV2xOQTNXNHlzU0QzRGw1?=
 =?utf-8?B?aDU1UDZnZDBzUzczbkNUNHQ0MHlBRVBlT1NWMjVXY2xqZFRPREVTUUxXbEhI?=
 =?utf-8?B?VFl5eWRudGd4YkRjMmVmQ2dJVGJQV0w5cFAvNVE2L0VmNGQ2U2NXRmsxdVRL?=
 =?utf-8?B?UDEyK25GMFR0ejNFK3IvcHZxNWNUYk1YNG5ES0ZNL2hRNDVMSzJJSjZ2Wllm?=
 =?utf-8?B?YXZ3aGdRYnROK1FWSGx5M1NzbnQ4RnJaZFpnU0NPbDlDUVpDbjJiemQ1WHZW?=
 =?utf-8?B?RnFGcU9VckdkdCtiWUNEQ050b2d0YU1haC84ZEhCcjdWYkdxUkpzVlJMcjB6?=
 =?utf-8?B?Q1puNXo0SVlvdkhrQTRLY1YrY1F3NFFETDFrdHdyaDgwY0NGU3B5ZEdJT1d0?=
 =?utf-8?B?WGx6K0hQT2NoRFZPSWZ0c3EvdE5VeWhhcHY1RWptYnBuRjd5QkRpSzlLNDJJ?=
 =?utf-8?B?TGxObUZMMkRlU3o1YlU4SDI0dkxUMTExSmVQMHNUZTU3Ynp3dnZlU095eHR3?=
 =?utf-8?B?ZXpqQm9CejhRMXR2RTgrSmZzS0Jpb29TVjlCQzFFd3lvTnlmSVgraDZ2ZmdY?=
 =?utf-8?B?L2M5UnBZRGtWYVg1bEl1aFhKb3BPOE41RnpzeWlzNkNTRmhxZi9WbGRrdVFt?=
 =?utf-8?B?R3RDcHpPOURuLytKQmRZcGZGdzlqNDNuOGp4SHBob05rcVREWVdkbEFtZmR3?=
 =?utf-8?B?K1hTVGw0ZWJlTjd3cUhGVGU5YjZNZjF6ODduOXlpbVo2RWNpWWdnNmUvcUNB?=
 =?utf-8?B?dGNNMmVqYWR6Y3JkanZmZlY3Y0xnQkFyRGpxUEdVMlMvRXhLYXVXSUJMSDVn?=
 =?utf-8?B?VWdaNExYQVU4Mm50STIzZHd4VTI2aXFKeCtnTXczN1FyZ3l3Vi9ZOEdrSVhw?=
 =?utf-8?B?UEJxRS9jVXdrMTQrdWt1UnVHNFhjSkZ2aE85ZnJRU2ZvRC9neHJLQWx4bzRn?=
 =?utf-8?B?Rk1adEY2RFQ3VFo3a2hqVkh2NitVKzRkYVJGdFlhbnhuVVJTVXF4b1JFOW9k?=
 =?utf-8?B?RTRUNEN0Vk5nc1FrYUZaTm0rdG1ReUtmOVNRbVRVTXRVbGYzbHg1blU2enIy?=
 =?utf-8?B?dnpCZ0NrUzA0bDNjUVJxS0VMWEY4eSttdy9YVE12SUkzeXlIYTN0aGdISjFt?=
 =?utf-8?B?cDFuYklsN1BRSVhqcWs0cXMwbmFYeXdLblpHMjFOYWs3M3h2cVhNei9JaGtP?=
 =?utf-8?B?Qm42S2lzUXg1S1htRE56bkNmVlFBQzhKKyswc0pnV1VhdXBweTFxT0dhRW95?=
 =?utf-8?B?RHROWng5NnNmRXAvaHR3ZTlrQWtiOGVkN215OEg3WGZQTUQveXBiZXZPekk4?=
 =?utf-8?B?OThIUlRLc2h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGlGSVA4SE9TdElZQ2JJYjlFRTEyc041VDIyQldRL0piam1EUmRTNnBZeFBm?=
 =?utf-8?B?UkhjYUFMQmdBRkJQWmt5c2xEalM3MVN3SWRxTXdTY3oxK0RzTmlld3RBMW43?=
 =?utf-8?B?M0dEMmtFdU1YNytzbWFsTkxXbnJXcXMwWkEvMkVzb2JXNW0zNld0K2lick1O?=
 =?utf-8?B?djZuSHRQOHAycERZSmVVWVd0RXYxSUhacVhJTmtlSVp2K0VtMElWMzdhY1Mv?=
 =?utf-8?B?RjNWUS9EMjFPSmw5QnE4RjErdXFwOG9hOUFHa2F6M2EwYXUyeksxeU5vQWJm?=
 =?utf-8?B?OFhUSTYxb081d2tMVzFFSzFid1NWWnFKR2F1U2lYMjQ4ekdpWVNrNS83M1Fi?=
 =?utf-8?B?QmZ6NVcvZllqT0x4OERIRGZaendMT1Vrc2xWdFdQOFNRRWJuSisrNnBVNFFD?=
 =?utf-8?B?VzVHWTU5UjRiYVp3MXFDVXBoSXpMaXVqbGtNdnJtZUlsbmZWT1V2emtRaDdL?=
 =?utf-8?B?cm9iQzR1MXF6OUZiZWVoUlNtY01vbHQrT0tYWW03Z29nVGFHNVMrdmRQSG0w?=
 =?utf-8?B?UmRscWM3Um45TFZoWkthTzR6OXlLSWZYMjJYOWlROHdEUXM2NkJHZWZwNDBk?=
 =?utf-8?B?WG1hS294RXlTdnpCZU5vNjhYNTFvNlFBdEs1c2ZoT2x4eGJRbDlVOGZ3K3Qz?=
 =?utf-8?B?cFVGY253OTltaC9zZzkvczhQV0IwQ3padGx6L2dpTEZnNkUxSkxDcUR4MnlO?=
 =?utf-8?B?WXdiOVl0bXFNazhzSU1oalZqbHF2aVlQWHhGUW1TWmNQVE4vV0JvNGdEOHow?=
 =?utf-8?B?a2E0Q0ZEWlA3UTBEWndwaWxsa09aSDJtSDBzUzREL3lESEN6OXFwaWh6VllS?=
 =?utf-8?B?enNrZmtEbWtmOWZRQzEwK3ROMjlIN3dDa2FHQjhHZGJEZTBDK005OURTWTNJ?=
 =?utf-8?B?RWFhS0U3dStROHNObzY0aDdPZm5QVlZjeTE1NGg1OHJTNFhkeFk1MUx2dTd2?=
 =?utf-8?B?SDlvVHIzV0lKWEFSWlNEejRJVmVSZXFML0V4bnZycFZEcVhYWEhPcW5VNGd4?=
 =?utf-8?B?RkdvYTZMRk0zZ2wzd242UFlveXkyYXczQXlrdHlUb0o2S01wZ0NpYkVKa1dt?=
 =?utf-8?B?ZTZhdG9uL1VJTURIamhhZkFXWmRGd0JWOW9rNVpNK041a2M5MFFFMUJMS3dp?=
 =?utf-8?B?QkQzbnVxVlJxNkFnNTdyMENWWkhKc3RWM01LZW0wOEhpZnVxMnlJSE1rL0lC?=
 =?utf-8?B?VEl4UWl1R0t3TEgzM1NSbEg0K3VKNzA0MFZFV0VCNFQyR2d3MGJoMC9jeitU?=
 =?utf-8?B?b0lLenR3TWdrd1BuOG1OdnpHWnpoSCtJR2lEbTF5NHJkaE9DYml1TXgrdE1B?=
 =?utf-8?B?d3BnalRZbTAzY09GMjgyLy9QTXdrUGF0Qno2a0NaNit3VWhvWUxLeXRNc1NK?=
 =?utf-8?B?eFJRWHh4R1M3TmlwOVVXWVZQV3NieFBKdnQrOStHY3B0RWVSakF6bnArV1Fp?=
 =?utf-8?B?bnYyemRYTGpGYnVMUmVucWZONzVjeUZxOGl2K0d2cEtLWVJWNWplcWZWYmZE?=
 =?utf-8?B?bXJ2Z2lXZlZGclR1MlNNNGFicGpYanN5NWVFMGpscDJBSnBadENtVVNjQW1V?=
 =?utf-8?B?b1BubVVHam9Fekh3QnJDMnh6Zm9OYkhMaUl4d2dMckxNUTFuL25jMW9SUXEr?=
 =?utf-8?B?ZzNHVFRQZW9Yb0lIZkVvREZWaFJ4L2JlVWlLSTRzajNiQVV2QlJCV3pNWHo4?=
 =?utf-8?B?dDZHYTh4eEFOU28vanRTVWRzVm1LaDlZb01kSWEvV2YzK0N0RHVmYTB6L0t5?=
 =?utf-8?B?a0V2Q1FqYk9YbXpwSGN2UlErdXZ4WlM4dUhHVmthNUthZWxvd1NuVnRIcmUv?=
 =?utf-8?B?U296Q1dOalNqOUpMb0RQRS9IVlQrYzBMOXBGVlFlU1BlaC9kTm0zQWYvaWQv?=
 =?utf-8?B?RFE4N1UvZkZPMU5rK2lvM2tHMU1SYUQzSlg2M0UvT0RZSVhNbDdiNlRuVDQ2?=
 =?utf-8?B?bDcrci8wdUhFOXNDMkdtOXJ4Q09vZ1k3Tm1ZT3JrOVRVZGxkTGV1R1dTeVVl?=
 =?utf-8?B?NlA4WFljYkFxS0pnc3poODVRNVFGRmdWTkhOSE1TcUp5dVZJUnZBeDhjUW03?=
 =?utf-8?B?SUJwNy9hZGtpNjkvMTJ5ckVab0tML05GZDlTalliMHZtbURVZ1hLWG5CQmtT?=
 =?utf-8?Q?7yWZbAhs3Vi0n0uBv64d+Yyej?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e09dad-a951-40d0-ff4f-08ddf79d63d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 16:55:51.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7qcXPP65QCAv6RzJOadBXJxxi+sbHBYTvcbUF6eo2Df2pFbhioBookYFJ3eLa441Lq/T4lpNnD5ReMk9EauQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

Hi Dave,



On 9/19/25 17:26, Dave Jiang wrote:
>
> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> First of all, the patchset should be applied on the described base
>> commit then applying Terry's v11 about CXL error handling plus last four
>> pathces from Dan's for-6.18/cxl-probe-order branch.
>>

<snip>

>>
>> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
>> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
>> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
>> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
>> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
>> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
>> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
>> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
>> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
>> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
>> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
>> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
>> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
>> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
>> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
>> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
>> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
>> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
>> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
>> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
>> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
>> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
>> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
>> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
>> prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
>> prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
>> prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4
> Alejandro,
> I'm having trouble creating a branch. The hashes for prereq don't seem to exist. Can you please post a public branch somewhere? Thanks!


Did you read the first paragraph of the cover letter?


