Return-Path: <netdev+bounces-226627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A5BA3248
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DE1BC1C6D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1F29D29D;
	Fri, 26 Sep 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K1WE57YQ"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED471A9FA4;
	Fri, 26 Sep 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878864; cv=fail; b=ZJL5mqzwqCoUz/g9JRi83n5iBzadex0s7+io1yBGrA5stQGf2ML7Vdl9KIzorxTheaohq0WnsCq6iOm5u6VRqsUpYT/8SrQC98FhVnQZRHcdvY2dMO/Xgj0cuaY+lLs8axNSWJSpK2UbSygoho1IHMs1NUOiA0JiGRaZYs2Jr0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878864; c=relaxed/simple;
	bh=1LEzfDRsk/T8ZYHdL5euOSyrfLB6cOKWLaFl0ffjvlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8+S0xpEQD5w281Ou4cDtPp16nQBwCYCAxgWFXvSTVqrfCLpYj8rPGpAas83zwNC+Cwv3/yTcr2XdnyT1LbPwqkQCQqgXwYhgwD310zA+9LpixLJdfczsl33nsxAkmxD1eaum+36C8+othAKicWmVm2lvblCAp4eCPARhLwTguk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K1WE57YQ; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNwFOz6Mz1d7owqAdJum68gLgPEXvO8BYMbqcLjfrGKKhpuEU6RN1ipzsmMk1b933yxVOhwUc+nNQUWMT6cvL1ro257FrRJ9H3o4dAHiz7Dlfman16SJYibdQ6GVXAeJ67leo15j9OmGwnJFHRyNr/QP+5EfW5kXV5fr2MH65mBnYX1kGWsN4oW5iqs+Q5pwlSPfqF22zqEr1Z3ITOmfMZ6bIc8g9X/O8+KuYGITvE6QdRrK0iAt06OM5kmcpQ5R6rHokINbeNtoekhbgm8lhZhdaM0LC57GlaPkXL+l48z3xvKA1ohXizn/uK07gfye2Q38EEYGo1A0pZK2CUsE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsMS7JRX1CXPmn9/eRR7u7IQXAc5SRxZ0yuQavrd3VQ=;
 b=IodKPV0gHCHXkDg4TCm5HNnKtkCO5gBuLriFiUZ90QoCMISeoFnDDelBjCLVxT85DwMaOVECaHdMHJB/ZkGVBn4BzsYjxpPF2ZqnmE1V0g4kuhN+93DyzfRggDuyRukl6EukartguUM2skc2k6t42T+LHlHdu1UUVPH0KJ0YNw4/3g/NWS+y2QZkPk+cqkSMP4kmBnkOtF9j79s302vnffIuYTIXEATG+qsSTwhz8Jh4zR/CbA5bsiM9rjNklHFd+vvUTdccBbcpGuhcwqlB4WjATVwyShOJ2m94IVK1gbdKEjPxbxSmbp1UulvB6Ia9QRPsI+6Er123wqPIWq4Urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsMS7JRX1CXPmn9/eRR7u7IQXAc5SRxZ0yuQavrd3VQ=;
 b=K1WE57YQj0IrXcf4Yeowi9KGnyExU+i0YtkYqfxdPcIOAaaYbWZ9sWLV3AcxP7tFFE25nim+Yx7BtNM2DeG7DsKh3jWcqU0iGhvwaTOd0dOh1adHqu1WcrIzXg/qQMQ9Ukf5S020sU/ky8sTOXZnLNQUnhKKZOgg6+nXFmq03nQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 09:27:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 09:27:41 +0000
Message-ID: <a98cc504-c35a-4271-8e62-a2e0473738f9@amd.com>
Date: Fri, 26 Sep 2025 10:27:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 18/20] sfc: create cxl region
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-19-alejandro.lucero-palau@amd.com>
 <20250918160325.00005261@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918160325.00005261@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0133.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 47919d9a-d128-4d2a-6efb-08ddfcdef0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1JYXMvK0dKMnQzajZCcnFtUWsvSHkzUmE0b3MyV3R4YzE4U0Vid0FXVGY1?=
 =?utf-8?B?M0xrRzMwRGlqZUovMWlWTEpWRkRzcVNLUW1PM1Z5SlNFMlMzdGlaZGZza1ZK?=
 =?utf-8?B?S1BKSkx3enBxTXNyOTY2QmZTdk5PY0h0YXhSK1ltU0ZGYjI1REE5VGFmVnVH?=
 =?utf-8?B?eWhRQ1B2aUVQUElGclJCUkZUbmp4a3RQcElxMmpOLzhmRTBFclZwS2Z6S1Jo?=
 =?utf-8?B?ZVRCbFJqcG4wZzNxQlJJU1R5czJYbzdpSjFYK2U3djQ4SzMyejUvVzRnQmJV?=
 =?utf-8?B?ZWpWUnU2T0xRSklHR20xdTNDWElRUzBVL1RnNjZuNm9tY3QzR1NqUWo3bmZP?=
 =?utf-8?B?KzdlZ3Y2blI4RUxqMDMwcit3d1lsYmlOQ1BhT2h1OGpCNCtDWTFwdDJKRWxV?=
 =?utf-8?B?cklPTWdtb1MrQS9zcVlXOWdwWFZXZGdWYWxEbjI1OUVHTkRzOEplb0c2Z3hs?=
 =?utf-8?B?U0pnUWY0dWtZRGRoM1dsNlpGOUpTcEFLRW4zR1V5ZzJqekVXK2xTalU3VDMy?=
 =?utf-8?B?WjZuODNYMnl3clRNcVVtWE55Ukx2aS9HVy9mTTdpRUQwM2wxV1ZWZzVDSEFC?=
 =?utf-8?B?OWliMTloaTJBUjJ1TTFUbnkrSU5TajJJQ2QwUklpSWY5L3hQUWhCbFMyZ2RW?=
 =?utf-8?B?K1l2VW5IV3FVY1dhdmhwdlBoV0FpanJFbTV6THdTcnpQSk8zU2pDb2NTaU1j?=
 =?utf-8?B?N29jZ2xLNmpFQ2hKV2lQd2lhS2xsUGJPR3RLaDdUd3BwUFhoaUFqVm13L2NW?=
 =?utf-8?B?bWVLK1AydDlOZ05kQ2NLeXdLNFNoNkFOWnpmakZGN2lnQ1MrcmlBUkZodXlQ?=
 =?utf-8?B?ZGM4UmRpdUpmVzE4ZXpYemlUMFliQmJablg3dWduYTNXU3lMK1hzVDY0OVZj?=
 =?utf-8?B?NGFWRHVyV0F4cTNaYnBjSlZ3SXVNR09qSDloeHA0QWM4Ylc0ejlPdzJzbzgx?=
 =?utf-8?B?RDBScDZFRFdBTVMvUlZVSVJGNEhPaWJZa0dGNUlNTEkvTi90VEVTTllvNUFh?=
 =?utf-8?B?N1VMTnZSamkzdWx6bHRiT0tuTy9oaXRjc2xMY1VFQUtQcVRkTzNjNnlLeCtv?=
 =?utf-8?B?bTNtSThqdGNtK1BiTHl0YTNGei95SytoeDIxUFdmZWlWbVVvamMvNTBmKzNs?=
 =?utf-8?B?SEloQmxSd3lNZUl5elM1WXQ0ZEV3dUxxQnFMQllwUHJLZ0xhcGFXNFJvbFF1?=
 =?utf-8?B?Zi83K3krWFFCcGlOa2tPZVJmQTlEaTN2SlR6N2Y5VUlXNWlRU0lSVGJoNW1t?=
 =?utf-8?B?SjQ0UDNEazhQaithQ2NXcEZSTjUzTFhSRmQ0aEx4aVB1TS9IVDdYcWdiSnJS?=
 =?utf-8?B?NUp3OXJhNGpkWWh0UmlpVlZVdFZpM1lCN21IbS9ndFc2TXBNMW9BeVdNU05E?=
 =?utf-8?B?WEU1ZWRGN2ZpbUJRNnA1bzV1Tnh5djNhOU1uem41Rmx3TzVOeDRTeEFHeWwv?=
 =?utf-8?B?NXJiaU96NlBIY3J1QldDRnh6T0w5c2YvYmhEM0tKdDkyTzFiRHh2QlNsaXBI?=
 =?utf-8?B?ckJVNmVEeGl6Z3FNMCtsanZWRGdHMExEZlR5TXh4NEVGcXdId1pYS0dVc0N6?=
 =?utf-8?B?WXMzZjczV01nZHlIVXk1UUJtWHBKeVYzc1lDaXF1ZVNKeGhGMDNXVTNvZmZz?=
 =?utf-8?B?cDVEdTEvRjd4aVdHZityK0lvRFNwdjJlY09RVTBDT1dZemlyQUE5SFB0QjFU?=
 =?utf-8?B?c2krRkh6VGkrZ3JWZHVaaXlXWEQ1ZXJIaXZGcHNDZVRNWFlqYnhVOVNOMHZO?=
 =?utf-8?B?ZGdhRHJTRm1rMGRKYnRneHVVSnBtbjgySEZPZGtjNmpXTlNscENBZkhFZTJm?=
 =?utf-8?B?SzZKcTBVNEE5M1J6OVJXY2dzSkZxQ2tOcGo5ek9QMDhBTXZGODZsNUdsMkFS?=
 =?utf-8?B?eHVRZnV4QlROVkh4TWFpamVmTThDNE1xdVY5QzBWVERZa3Q2TzJuVG5sejBj?=
 =?utf-8?Q?+vLs4X61JdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUdGelBMWUlHbmR1K1VYeXNUdTBXYWZJSWpqVDA4MHFZYnVPeXRNWjVCbExW?=
 =?utf-8?B?WFFjSFhjVER4MDl6cXloYlM3REhrendpcTJQVjBmUy9TcVdjUXg5eEtJMVhK?=
 =?utf-8?B?dDcvNEc0Q0FZTlJUaUpxaFlscklzcUJPNUJxRVRLYWc0VzV1MFpKMDhGbm91?=
 =?utf-8?B?S25TSHJtWTJzMFdYei82ZU1WcHowcERPTEtNNUNYaTdJYXNzbWpuRGQ0YzZy?=
 =?utf-8?B?WENiMGZVSk9YL0dPcDNUSXk4cW9kbEFhRGdXQkUzTlE5NVZoZkx3NVFpK3F0?=
 =?utf-8?B?QTgvODFSVnhvd095eVZBb2REZlNkVUVxQUczWWFNazBMUkFOaG84eGZVampG?=
 =?utf-8?B?YTVhRkVIejV4UCtGVVJBdTl6eS9WY0VZZzI3SDNuU2M1bmFPY21TTk02SFI1?=
 =?utf-8?B?dG5zR250L1hnUDNCTUVXTlZTd2pXUVNWSGI1ekFpYmpCWjVzYjJIekY3a2Nq?=
 =?utf-8?B?UHk4MUZBNncyZ0hiWUt3NzhOTVR0azgrZEFZbTlFNVZGZjNIbWpnZ0RYaXI2?=
 =?utf-8?B?TUQzVndkdjZDbkxrZ2NnL3dzalIyMjNOTmE3aXdXdWgreG5qenpnNk42Rll4?=
 =?utf-8?B?cHBjWHZVNlZMeGNtbyt0U3hJVnRLaUJQak5yTkp0ZWpTcWlXL3kxb1I3c3pY?=
 =?utf-8?B?MTl4NEJuUUIrUG5EdEZxMVFSWXpteXBmcy80MGZzYkNpQ1ZtTFBqUVFYVmx3?=
 =?utf-8?B?NnV3cytHRkp0WjMwRWFJMXUwV3Y5WGFLU2dFWGhhc0YzVVptNFVjd2ZoZHNC?=
 =?utf-8?B?VHExc2ZkV3BPOXY4ZzAxQ0RVcjFPL254RHRzQ0tTdGFEV0R3b1FHSU1Pakln?=
 =?utf-8?B?Vy9zeGlHeUVWM1JzRGQrOHVqaVkrR083cHlETmNwMmxqS3ZjbDlEbTlRTDY4?=
 =?utf-8?B?Rzl2STV6VEVvZ20zVlZaRGxpSVBYYlU4QTdFbEVua1BReEtPNmNHZU1BV3l1?=
 =?utf-8?B?L3A5ajF4b3VmV2VQKzVtRFhCb0ZWakxsMGxSUGh4WU9Ta1I1ODRWQkVNTmVQ?=
 =?utf-8?B?VDRXdkowYmFDcmFObmZSZzVJN0thVkJzRDFnM0ExWE1tMEt4Q3FnY1hFTU0r?=
 =?utf-8?B?TjlseXRzYTNIY013eXoza3RqaDBvdjJYZ3R3Z28ySXo1RElFUjlOS3ZieS8r?=
 =?utf-8?B?L3RtTUtHSFpSYTVvUDhWSHhWRENaNFhvOTNYbHZhUnpzeHNnMjRtVngrRyt3?=
 =?utf-8?B?U0F0bnNyeUh2aVE2LzVrbk8rU0hzaTlOQVVHTDRVQjRaRUhJTGNjeTdsd3o3?=
 =?utf-8?B?cm9DZDRFVENIai9hRi9sNFRnS0tHcXpEcndBbnJMTUxkcHVJcko2ZVlMMG1r?=
 =?utf-8?B?RGxsS3YvaTJpZEZnVVFUOGh3MDY5UXdFYjlMU3d6Q2RJN3JxT1VhaldXZHlJ?=
 =?utf-8?B?QWNMa3dxTTkwTDFLbStWWWpqKy9wbzVrRW5Cbjc0MFNsK2FMNitIOE1PWmNS?=
 =?utf-8?B?ZGEyZnFJa0FqdDIzWGFKcUFkZy9BM0RZL2FzcG5GWkJWVUNPSFJCWDc4bmNS?=
 =?utf-8?B?NVNtRCtnWFlPaVZmYkRiM2ZtcUZWTUpqZDhQSWJjNG9vdGRIZkQwSDlVWTRD?=
 =?utf-8?B?elV3T3lFNkF4NmY3S1JacjNoZXBlRmorOUZDRnFmRU9mRGNPNDhsQk40OTZ2?=
 =?utf-8?B?U1VwVWdFWW1yanVBZXVvcnNmbzQxZUNzSDZIcHMraHN3ZVYvSXFIUmw2ejV1?=
 =?utf-8?B?bWh2K1k2QlZYNEhCbVpVanNXcjlYa3BxOHoyQ0pOSFVBYURzMHNBWVRXVE55?=
 =?utf-8?B?VkN0bTYzZ28yazR5T3BxaEJlQm1iZkVPRmV4SC9SQ1RsNlp6RkpTWTZDMkVl?=
 =?utf-8?B?dFNhbG9QVWZpaFJBcWo5a3UrN0J5YTd1eFY0cjNNR2pYMnR4aHBmT2hkLzlo?=
 =?utf-8?B?NmgzWWc4RHJhL3BKQm0vMWNoNE1rZGFySTFWUFg1NE8rMHJ4dzhyWTFkUFRi?=
 =?utf-8?B?VTdFUlNFbjY5cFMrMm5TOGVpa1FMMEovT1FULy9hWGhxS3lGRUlhTllML3VC?=
 =?utf-8?B?eDhDSlovRXF3RG96S3RiaU9ueFFPT0ZVcXRKeWxLNk1yUSsreVNzVTRvSjVa?=
 =?utf-8?B?YWdra1c1a3g5dzhhSmZOMnJWYnNqRTVYK29xZ3dLVGhRcE5RbmRRSWlTcGJQ?=
 =?utf-8?Q?V1tHhemJ4IvfISGHNWTN+lx9H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47919d9a-d128-4d2a-6efb-08ddfcdef0dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:27:41.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G16rqyMUYB/V7kyWF2RIWRKKOC9IruT/24QP3itDYokD8sxlokhBAve9P59pYRGe+Bb/DWbBRlzfJSp/Q5nhzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603


On 9/18/25 16:03, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:44 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Add a callback for unwinding sfc cxl initialization when the endpoint port
>> is destroyed by potential cxl_acpi or cxl_mem modules removal.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/core.h            |  5 -----
>>   drivers/net/ethernet/sfc/efx_cxl.c | 22 ++++++++++++++++++++++
>>   include/cxl/cxl.h                  |  8 ++++++++
>>   3 files changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index c4dddbec5d6e..83abaca9f418 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -14,11 +14,6 @@ extern const struct device_type cxl_pmu_type;
>>   
>>   extern struct attribute_group cxl_base_attribute_group;
>>   
>> -enum cxl_detach_mode {
>> -	DETACH_ONLY,
>> -	DETACH_INVALIDATE,
>> -};
> Seems like a stray move that should have been in the earlier patch.
>
>> -
>>   #ifdef CONFIG_CXL_REGION
>>   extern struct device_attribute dev_attr_create_pmem_region;
>>   extern struct device_attribute dev_attr_create_ram_region;
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4461b7a4dc2c..85490afc7930 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index dbacefff8d60..e82f94921b5b 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -282,4 +282,12 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   				     struct cxl_endpoint_decoder **cxled,
>>   				     int ways, void (*action)(void *),
>>   				     void *data);
>> +enum cxl_detach_mode {
>> +	DETACH_ONLY,
>> +	DETACH_INVALIDATE,
>> +};
>> +
>> +int cxl_decoder_detach(struct cxl_region *cxlr,
>> +		       struct cxl_endpoint_decoder *cxled, int pos,
>> +		       enum cxl_detach_mode mode);
> Is this change in the right patch?  It's not a code move here
> as there isn't a declaration of this being removed.
> I'd rather expect this in patch 16, along with removal of the declaration currently
> in core/core.h


Yes, you are right. I'll move it there.


Thanks!


>
>>   #endif /* __CXL_CXL_H__ */

