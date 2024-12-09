Return-Path: <netdev+bounces-150100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6559E8E77
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA06163474
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A823215F41;
	Mon,  9 Dec 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u63yFBeg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094018DF6B;
	Mon,  9 Dec 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735542; cv=fail; b=KpRbwO7ztqbLEV5IwSZlz7Cl7Ebcf4BRlNMPjBa/pPCsZmvIQYSabd7IdLY4HJA9MebZhH4NUBvOFsDto71AXRbvSt9Iko5520JjFqrhH4MuRcTOOPDmXqnAqxg98Uex5BzrAm6CbkqMHrsSO2EPNWWnTDQ8Sgl11KSH3shf3qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735542; c=relaxed/simple;
	bh=QVXlCecMq/pS8vFr1GbxNnPFalrddxc4/vdmhRLisbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iko27UlIDFonNPBJDPDiYAou4Ex3jbiqs/cpDruj3ZB7ph6lCOXRTthh71fY8liNax1IcTJyGAqHA4+pN9x4wXmSYSoe5OldshLmQQbUBS6SdQhsHEZSweptc2h6+u/MLSFKiCn+omBmrk6MHpgTfNvi+q8Vq7NIxfVKTK1G6Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u63yFBeg; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiMdrEhYGJ9oBLP44zjoebAaeuXOfYmjrmUydRQKXwual5slvCo47BtvDKXKP/sQnp6N4oPGpk1uwQuHIQiRelCvpX2JLNiy03ys9TjKFHid9zuSgTA2AQdwDSM/74Ao7ht9yWqerHQxBBvZawxa4zaG7l+dI7YbJw0+g2qoIaGM5hxx3r6lQhS0rhcGNYrTg7xjSnJbrEEZTjBzkcpGEkidXZKNELRGApuZtuyorgIwNRk/hycKR8i4Blj1rYRTCetIFUUJ0F6SQ1H6NU2gnd/Amw3+wWbgSbsuEFUJik5fz1KDmgIDnut8pjlnwTm4PSy0SHyXqgzXQstS7BRz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=regQ0qjk/aKn7e//5/eoUPEPhMF0P+xoMQQFlfX/Z/g=;
 b=tIpyiXR4PkOotFGkhBgFwzuw6TvmmkltfD1rK1zJHMN4ID/hKizoNHiZhhTv2ONZkyofhx96SpJacrfT/tf0+uRGuGZtHzMuJofzqPfk/05lTNYOtZ2S9YnwJzP3ehLS2sKalRBXTDRl+fdSOHkz60qMgF6s8B2WniIkwCVfvfvhtm3PVDd1l31jDxCUmB38yl3Ed164D+tLrh9q6YoneDWhj5fNCU7xkmBKHGmWJc+K15Mz56NiptHbr85LWp0zQZU47tpR1dW2wJGw6Dmrq6wdTMNwgTO+wpGnpTOqML8ZQn0ZMhTkkLi1jiOn1NJh3WCRydCSvacbEcVkWz6oTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=regQ0qjk/aKn7e//5/eoUPEPhMF0P+xoMQQFlfX/Z/g=;
 b=u63yFBegaxesL30T+izQKze3KoUDHFi6WC6LLJJdnQdWApJCgza/NVhsssyECgRi96eT3vYxBT+mTqo9tq5MfNPo7wM7d0i8putIgwEquv7lbN9OEe3iCZQsi6FBO9Kavoo+AVKsdrkOQY8yJVGT77fRUmwAeCdft2IVg+u/Gkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:12:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:12:18 +0000
Message-ID: <c2563430-0e82-61ef-9bf9-72c7c6dbebcc@amd.com>
Date: Mon, 9 Dec 2024 09:12:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 09/28] sfc: request cxl ram resource
Content-Language: en-US
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-10-alejandro.lucero-palau@amd.com>
 <CAH-L+nPTL0OiN-aCaob714yh91za=uXyOi_MnGKUCL4p5EOW4A@mail.gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <CAH-L+nPTL0OiN-aCaob714yh91za=uXyOi_MnGKUCL4p5EOW4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: a435730d-d9d1-4f8b-7acf-08dd1831946c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWlCdkZoTHZWYktxaFRoTFl4R0Ixb09qYm9CNktPRndDZnc4N0tNQUk3NXBn?=
 =?utf-8?B?dVdCSXpERkZ2VEcrazhMUzZ5RnY2MWJzTFNmNHBOR1plbXdBeE93YS9hRDg1?=
 =?utf-8?B?NWMwOXJVeW4rNXVFN3dFcnJ2OEN6a1N0VS9tU1hXV0ZvcGlGVHNPMjg0T3lJ?=
 =?utf-8?B?NGpDQU5GVHkzOHBBMjRHM2pzSkNTQkJpVjc1RHdXcWlkZGQ0cm1mT0NLVkg2?=
 =?utf-8?B?N2txU0oxRWZIMytaRDIvNS84UG1RT3YvUURjNTZGUE1WR1U2d09VVGFtQkQz?=
 =?utf-8?B?Y1p2bkJBUnh4aVVuOWgwQ1phNFA3L3hycUFpM0V0RklsOWNmbER4eDBYZlpD?=
 =?utf-8?B?czRLVGtaVjFqQU1PM3B1OG9XV3VmWmZWSWxrcFFmdFdGZ3d6ZXZYZjh5UnZw?=
 =?utf-8?B?bi9HdXAvMjhwLzVjeUFvbHJKaHg3WFlaN0ExQ0RCRjZEVDRyWTQwdTdCaU9a?=
 =?utf-8?B?ZzlHMzZCR2pkZWhhVUxza3M3V2NuTVhud2swTk45eHdTeWI2dit4VitYY0k3?=
 =?utf-8?B?bUFMb2ZrWUg1Q2dYODVmb25BWGE0N1ZmdGlwZWppTGVCZkFNM1pjOSszbldv?=
 =?utf-8?B?SXY1OTJXdTI5WExNYXhZb3NMQXdyZUJreHhNVHdheHlTNEVDTlNCeVVhd1Bx?=
 =?utf-8?B?MHVyTENXam15WVlvR2Z0TW9MbDdCT1lCd0NBdEs0OTA4ZHR5akt4cnhtTndJ?=
 =?utf-8?B?ZU5FWTRBdTc2QTJOUVFTS3Z1dXJFWHIwVk13SnU5SzZNSU9HZFZudnk3eW1o?=
 =?utf-8?B?UHlidzc0VFptU00yamNCdGNqcG56YS9HcVV5TkpUYmFQOHpySmpSaUQvbzZv?=
 =?utf-8?B?WEZ3VnJlVUl4ZVdPS1o3ZXp4R09oK1ZnalJNQXh6ZmlySGdYWUQ1dTlZWVVB?=
 =?utf-8?B?NlpkNSs5amdySjZ1OTlxMU5kZE9nMmNzNVhtdlgzKzBxWlN3RW45Ym1JUktO?=
 =?utf-8?B?ZlhjcmROUWhaRkR6R0RFbExVM2MvdGtOM1J0dmNZOGFDMXdzWWNWWlkrMjFW?=
 =?utf-8?B?UlgrZnh1UU4xbzlCS3NINk9pWnVCMjJIUGVGN2M0WlJRYjA0TEQ4VFNqSFg2?=
 =?utf-8?B?UmFweXhkQlI2VWF4RGllQnBYeTRZbE9XbzgwaHhyTGNWbFg2SXJlTXhUMnNF?=
 =?utf-8?B?U2I1dzZQYXVpc0ZhaEFNdDFjNmhGWXA2UG9wMXBLcnNtckFKVUJ5Q21zbmJR?=
 =?utf-8?B?REt1cXd5clZOWkNYcXBpSm54bHlyRitrTCtGREJ0UXlGY1lMaWlZblplQXBu?=
 =?utf-8?B?MzVnTTh0c2pPT1dpS3d4V1d3citDVEFCZmx6bXRsMTdtaFNVcVRXUnVDZTJW?=
 =?utf-8?B?aWkyWmtUSEYvckt5djgyOWwyRXM3UlU5cVpVcjMvWm5UY1lvL1dnQTF4czRI?=
 =?utf-8?B?ZzljOGR6Nit0UUFpT1Foc2o0RXlGT2V5OGJGS2FOVkNTYlBrQmJoT21Oektu?=
 =?utf-8?B?WFFaVVVLb2pTd3FDU1F2QkRvdURxb1lBNGg0MEdFS2R5ZENBN01MN3pjYVlM?=
 =?utf-8?B?MTRqNVhDOU5FUXBpSFRSL3IyQklVU0R0SDZWK1ZRV1dtdTJ0UzFrbDhqOFZx?=
 =?utf-8?B?WEttdTd0NEh2ZHhhSFQ3dDFSSTdLOXBDUmxQYmFqOVZGVDVmQktKTWM1dEtt?=
 =?utf-8?B?ejlDYnFhYWlicThSeFJiYnFXN0lMUHBkcTdDOEdpc1JweHVMbm5xbndoMW5o?=
 =?utf-8?B?NFdLNmE4dm92eTIrUEhsRU9XUlNReGlJWW1EL1lRUVRwOFlFTGNIZ2kxS2Iv?=
 =?utf-8?B?NTB5QlpWRUMzSkw2RWp6RnRaa0NTRldVby9xQ1ZoejR5NGpES0loVytWWXFK?=
 =?utf-8?B?Q2Nid2M5WWFTT2t4YnIzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW9sRWxZTlJBbTlURjg3dGVGZGZ0Ny9qWjNienNTY20yZXkveW13SnNGMkFu?=
 =?utf-8?B?RXBrcitpcDJjMU83cHQ5THdrcmd5L3BJYXZ1aTJoUWtYZ1Vmb0NCVlNWY1Uv?=
 =?utf-8?B?a3FxNG5ZQzJlaWp1bkp5bGxLQ3pLci93UW5SMGZrUU9HN1JES2svc0EyUGxv?=
 =?utf-8?B?VDlCVVNJam90K0FWZy9DaFExWjVHY3RTOVI2OVA2WnFuZUE0U1RtRG5vM1li?=
 =?utf-8?B?YWlOaFVaWXZsaEl4d3JYMXR0ZUR6My9xb21ZTTlTcW1RaTZTSzdvK2F2dDA0?=
 =?utf-8?B?cGxnUThuK3dqNnhsRS96VmoyN01DTXFOblYxYTdQUS85MVFVa2ZPQzJHRWdN?=
 =?utf-8?B?UVF3OWEyNE50U0ErWnRydjQ1bWluajNHaVc5aHcyT1VScVJsdlI3cFAzdFlX?=
 =?utf-8?B?VEhGWFA4U3Y1MlBmb2kzMWp2RldvV2hvRmxQK3QxQ3Bxb0ZWMzBydW9peVNR?=
 =?utf-8?B?aWFBU3JadjBWeExnWWNwS3IxS1BGRHlzSWE2VS8rWTB5ckZLT2VsYWYvU0hv?=
 =?utf-8?B?dnRocW1lbVFRUHkxc1VyaUVWMHFmWlVVZGlMRmFvQVhVb2d3VWdOZ2ZmLzc1?=
 =?utf-8?B?clRySW1RZC9uSkZCLzR0c0RWZUxJZU1BUUo0eU92b0xqSzVmSXJNTHVJSDdF?=
 =?utf-8?B?aDUzTzJWM2ZxVVQxYkhPNFE5aEJzRG9aSHJiUXJHb0FkOEdzYjNpak5EZ2xY?=
 =?utf-8?B?dUhmRDB3SmlLVnJ1bm5zcXY5WG1yTkJvQ3FGSVRNdkMzSTF2d3pNUkVGWkpE?=
 =?utf-8?B?b0hIOTdIaEJaZk1oaHROZm4zMlBiL0wrU2s3bXhEZ0k0K0xBWWxMZkVCTkth?=
 =?utf-8?B?ekFvQmJDSGRBdlY5VDhXZit5THJoN3dBMWJpWHJnMjZyZThybFlGL0FmZWNK?=
 =?utf-8?B?UndWUWg2K2FuVm40MTNESFltZ1duUlZNd2orNXN4SThnQmpwL3dPUTJrS1dE?=
 =?utf-8?B?dzlHQnBIM0NCcktudFJPdWkyUTNnZXJkeXVpL3RUVnlGdEowOVBQWndkSS9N?=
 =?utf-8?B?enZpMlFmRFhIZHNUek9IcHZ4UHdzOEJLaStCQm1TS2dGRUpKVkhTRTFaK003?=
 =?utf-8?B?TlVpSmtTejV1QThNRVhjMDVyL2FXdGxNMEIzeGhHZUhmZ0ZNQk5qbXh3enlP?=
 =?utf-8?B?enJEU0hGZEJpQ21rdnAxQjFUb25BSjhvdEM1b1M5MHY0NGNoYitBN3N5RkNl?=
 =?utf-8?B?V2h0WWpBZXl4WWFIRzZ1U1ZJdVZnNHQ3cjVsNlFKTDNXcU5rd1ROdlQzMHFi?=
 =?utf-8?B?TklnMmw0N3J5dEdSQlV0ZXhBR1ptcmovUEtZMmhsWGI0QWxjNzJXdEM1MFow?=
 =?utf-8?B?SnBpVmNvM1NTRkR1WjRyUFBESSt0ZmxBNWdCWjduQWcrZnJlTnRCZVBUK01n?=
 =?utf-8?B?RTRMNSt0bGVOMkZwaTNYNHRPRk8vd2lab25KeXZvWjNONk04STlhWUplMnAz?=
 =?utf-8?B?RDBSMFJBVnozbDd2NTFKWS9PS2lsbWsvZkJ1MTMvTjFXQlNJNTJuUE9VS3F6?=
 =?utf-8?B?eVFpSldEQVJrbGQ1WldlczFaY1RzeEVlSFVQSHIrMWVDMXRSOVZsSGgxSXhn?=
 =?utf-8?B?QUtnZ3pqMHBKU082LzZTY3RuZnRsY1lqa2VHTU5GTHU1a1h0NzVXckJ2cCs4?=
 =?utf-8?B?dFdKRUxvVHgybWVTUDZQVWduNmdJU0c1UktCZEtPTnN1Mm90SG85RWkyMUNP?=
 =?utf-8?B?Yy9aN1NxZmdydCtKeGpqQnpPU1kzcjVXLzdTV1pOVjU5RkNsajhRMHUvNnBh?=
 =?utf-8?B?dmtKWm9HRTBuUDdKMXBlOUQrc0Nkd3JmYjhiVWJ4RmNrWDhEVHEzUzZQYVVK?=
 =?utf-8?B?RW1yc0pzeXF5NE10ODU0N0Z5c2kvMUwwTU41ZlE5REVFWXVFZkd5amdud0Rt?=
 =?utf-8?B?MDlDQ2xSUTFoWjZLYXdBSmw5aUgxUHdSOEQxWGUzWUF4SENYdGJSTGxyaU5O?=
 =?utf-8?B?UlVTWnZUMkkwWEwxUkJPUEF1SXNuZUNvTk9ramdJcjRLdjVIcGltU3MySUhQ?=
 =?utf-8?B?QzNrMGdjaHIrZzZQTmh5aUxpcUkvcjEyMGNlMEZEREszYk9DcllKWjFMRkVL?=
 =?utf-8?B?WkZ2dlc1VWp6b1Bvb3U5L0VWKzdBYXdmQmlNb0xiZWJiakNTck5Ea2hvWWU0?=
 =?utf-8?Q?BNpCq3U0dB48mDoLJSjy2ffS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a435730d-d9d1-4f8b-7acf-08dd1831946c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:12:18.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1mtR5h83xlmQejFW0nye2aKv2TVBnjGiuBhtQIUIMdmFwTNem1wTJVXUlt6ezgAAGvFp8QRheLB3gW+9Y6vrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756


On 12/6/24 04:28, Kalesh Anakkur Purayil wrote:
> On Mon, Dec 2, 2024 at 10:44 PM <alejandro.lucero-palau@amd.com> wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl accessor for obtaining the ram resource the device advertises.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 44e1061feba1..76ce4c2e587b 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>                  goto err2;
>>          }
>>
>> +       rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
>> +       if (rc) {
>> +               pci_err(pci_dev, "CXL request resource failed");
> In case of failure, cxl_request_resource() logs an error message.
> Hence do you really need this duplicate log?


It could be seen as a duplicate, but with potential concurrent cxl 
devices initializing, this one helps to figure out which pci device is 
linked to.

So I think it is good to keep it and it does not harm after all.

Thanks


>> +               goto err2;
>> +       }
>> +
>>          probe_data->cxl = cxl;
>>
>>          return 0;
>> @@ -98,6 +104,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>          if (probe_data->cxl) {
>> +               cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>>                  kfree(probe_data->cxl->cxlds);
>>                  kfree(probe_data->cxl);
>>          }
>> --
>> 2.17.1
>>
>>
>

