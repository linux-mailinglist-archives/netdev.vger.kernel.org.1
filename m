Return-Path: <netdev+bounces-192626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDFDAC08EC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91041BA6F8C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C62356DA;
	Thu, 22 May 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHHcgKyz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4E1F1511;
	Thu, 22 May 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907137; cv=fail; b=fBxr85jnT/9UBHSQOcNJa/fcmGz3UG+dEYsCYm+DX2I4Bu9fX7fZLCPAWu5C1F87OjzKlr/eFqQBiASGOPIri2bTahUvvzsA+lg4MCTx/50nFLXfaFrs9zEtYmggEVYyZgEwpODz8XciT2YByBi1i61g2KjwHBJ4L/4sIx2I+2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907137; c=relaxed/simple;
	bh=awBc0p8dx/c1e6iD5wyMx8eHLMSHWftW/VZCC2ca+b8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuY+CCxGi56Ydkph6DlU0hBqTN77VQmsos/VuLwzmxl129FTRGtFBEDAzwAsA2PgJD5agmCiWK5qBj6UCZvS5zaI8svrGJVWefXSDYsW8y3VR/CuE1fCYd7Z1Yf/gZxAhFwxkH7kfXjM7BYTFHY4Qwh1O+RXVTI51Evl2pRSGts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHHcgKyz; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1zBGhLYeFvtTmo6etoR/5yND+SkAYWgBb+Mo8WANWjD40xrcIdNjnpuWUpqzQ/ebNRv0tTdCMkGRf6P8eowFh1C+TNQRdZv9NKlJvCdLhBfJJip1nLG91dlAjJkF4w4Cy/up0IHpcZG4t58nYhZpT/bIWwg77Op2wnBGdDUh70iMRoWKfLk1buivfQKkgJI6BeAKpTIRTEhFgviwMvqyI7OQo0RH8A4VnqRi1RSF3j3zq6oLNSTGGjHUOKwsxyZYCvlK84/sJQSjgekr7YMhCtjtRPF0Jhxj0Y6YjLXwBGeW4iQJ/9hwHGukxQrhOMOuPGjhLUH8mXqxu6aE13Jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqGDhXc1F9UCMGsP0EZdqIn9q2EYwRDusOdVDRs/VX8=;
 b=am4KoGVY2cndkiuWWn02F0vYul9NcmB9tN13VAdZkZCEGGWvfmpQc/EBt8EWsxtFGk6NTpKIg+txu8+yFr/Z/FNUHcDfyv2jJTIup+TR86h0PnqOMg/MDMTnsZ7ATrafABZCX9GiY/IGlM0UhqN00Em59LGjPuaH50tal7sKsFavBr9hL9492j+A7iWSs3jK71Yb1DhiQvT8QMXVH1NwqrGfQpGBRIxVWigb+idWijSVHu5RkDVUrCFf3KNMBGKSrE4GBUtu6CYHgxSI7QIb3g8VUwd/3ge3OUHO6ATDrQey2lvWnJF4Sg/415Zs67EJ19zkZq2JSa0BfHNWvkvhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqGDhXc1F9UCMGsP0EZdqIn9q2EYwRDusOdVDRs/VX8=;
 b=CHHcgKyzjfH/OkqbE0jNdNKDXr88/7i/1I4+7rNErt6vLuPxgYCPnzkqsQdiCp//Qqc1Jli40Jw5VtGlxlIOhX/2SQzxYZ0hYshhkAyM+OeHgGwGQMVdJtQOBKczPplOcf7aju8xNMxeTA4EjIBQkodawc2nNK9sf/A9b6xGzIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 22 May
 2025 09:45:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 09:45:30 +0000
Message-ID: <0636c174-4633-4018-bf52-f7f53a82f71a@amd.com>
Date: Thu, 22 May 2025 10:45:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
 <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f409f9-7b63-4f34-c6f6-08dd991563d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVArbjB1alV1TW9DVjZLY1Y2V0pyZGcyTG4xTitJK2xxZU92ZnhwTnNXYU5y?=
 =?utf-8?B?SEcrTG9qZFh6REhqcjVPWFI4QStWUlBEbnJWUVA5RWxQeUgySFk1OThBa1NH?=
 =?utf-8?B?M2g3SmVRaWt1UlEvWUZNL3NnOUVwYWdLalAwQmJqN2ZNam9taEpVUCtjMlc5?=
 =?utf-8?B?c1BWbWRIQ0cvVTVJS2pLWU0reHRGOHZYWXh2Z0p6RWpRcXhQbjVGVTJHODV0?=
 =?utf-8?B?cUx2NTVwZzRueUNpK2lWT1FZZHFrUUhPMVpjbFcyZFJpMDE3dHIvSXJhZE5a?=
 =?utf-8?B?aXZzTlJhcWZqYVhySUluZUwyUi9LOWtuK2VUTmlaYXR3TFEreFZoYWFhS2pY?=
 =?utf-8?B?anB4M1VDM0s4ejNoRVlKMC92RTI0WDduWmszeW5tc3lkdjh6S3pzZm9YZXZi?=
 =?utf-8?B?VWFDVHJ4dk5ZUWk2cS9DQk9DUDFFUklsNVBSV0JtUmVCY0JrOS9qZUFKdnRt?=
 =?utf-8?B?anJFbTU0RkpuM2FJOW9ubFlkSThFbVcxd0ZaUldhWENVYzNJbVZsVDdXRGRr?=
 =?utf-8?B?TTBWZ01LR1J3OG5GUHcwcktVeHF3SUlYdlRGVDJHaVRmR0c0cC9JVWs3cWtK?=
 =?utf-8?B?VVZxZFEyV1JVOEFIWDZBbmFtY2F2WmZnUWM1NFhtSllVZW1WWXEvTVo0ekFJ?=
 =?utf-8?B?eUpGd1RvbkNFWmJjVFgvTnBVM3gyZ3pidkcvSHZVVElFanY3cmNkdm9KQ2di?=
 =?utf-8?B?bDlUYVhJN29Fa2hyajBWUFV6TTZ1SFFoUkFmejBXMHJFbjd5ekozSEZ3ZW8y?=
 =?utf-8?B?SU56YkdnaGptU3RGRlRxVjg0L1cvN1hJNnpGelVtNG5DNXJnYjBUV1pISlpk?=
 =?utf-8?B?RDh0QklDbTJCVWh1eFNMY25ianlBejRhbjZ4UFRDVUt1THBkc3BjaHJxM1JI?=
 =?utf-8?B?U3hZajI0a2VkSEgrYTU0ZEl1SlBDbk9vNDRqNDljdkg2MnVwaXVubmlNRXhp?=
 =?utf-8?B?RHZjTHlPWU9KeTQwNHRjc2Rhbzc5c09BM2tqcGYyeDREdlFNbnJjTXc2T2Fu?=
 =?utf-8?B?Y1doeTdMMnpxRlJDcjU5SVozQ3JrV1pnS0prRFVkbU9qMWN0bHMxSU8zUXl0?=
 =?utf-8?B?di9VNEEwQ0JZK2NkTTRTcWVYbE5HUUJHenNvOFZraW8xckF4RmVrOE92Sko5?=
 =?utf-8?B?Wi9jWWkvMXh6cEpzL3U0emlXNHBEZTVpbGZSRklLdTJ1bEtObEdrNXFKT1Er?=
 =?utf-8?B?aGZmenN3bDhrMUlTdmhiMFpWdWtVVGVVUktJMEd4cWVObENjcG1ZSWc1ay84?=
 =?utf-8?B?bFFheEgwZ0F0UkZpazUxZU53THE0dFdsZ0M0T24rdTEwby8yMXlYL2xTNG9D?=
 =?utf-8?B?dGViZXZNd2RZYnVJN0hGdkN4REtOOGZRVGNreGNJZngxU3BPbjA1SVM5Smlz?=
 =?utf-8?B?SmxLcFp1TXJNeDY1ZkF6MVBic2FhRzZCenFLUjdlNzRDUkprTnQ1eERkcnhD?=
 =?utf-8?B?cjBjZTByS21ueS9XZFBKQkFzQk5LZlkrRUZjQWxLT1dlQjBjZ0VDcytTUWY1?=
 =?utf-8?B?eXlMZzBpdjQxckFSZGZlK0Z6Smt5WW1vdDZlZ3dISEE3WlUzNXl3R2lJbUoy?=
 =?utf-8?B?NjRVblc2ZnVsUURuMnBWb1F5Z0VDOWpVL3lJN1VnVGozTVQrOWtKd2IvWFhS?=
 =?utf-8?B?Mkswd2dBRmpkV1o0Qk9Rb2xUTVdiaEtDTTNsVWhEdVp0OTJreG9KbFF5K2FB?=
 =?utf-8?B?aDQwTWpQYkVkVUZPZytlS3h6UWtQTmlxSHFiV0lPb2V4ejhhZmxVUmRTRkdN?=
 =?utf-8?B?VXdJUXpEd2NvYnBOdHQ4c0l5eGxqOE9kdlFQRVp1clZNdjVMeW56bkdwbXdm?=
 =?utf-8?B?dDUxTWJITkRQcFkrRW00K09ZSGtPelVKc3Zxc1c2ZXBJS3J3azFEaE9NYzhp?=
 =?utf-8?B?YTk1eXFjUFdxUnNQd2ZHUStDZVR4Q1BqelFmZmpoYVdrN0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnFsSm4xeGRXK3FnajJxbWRGekVRNXdVR3lZVEJmZHFJbkVTaVNkK2swUkRm?=
 =?utf-8?B?K09WeU11Z0dKRnRDOXZtUmhiSittL1FOaEJEdFREUjRzNVZxOWZoYU9sNXNv?=
 =?utf-8?B?UGcvU3g3d3BnVVhwckhBellEWGhVNXlTQ2tWMisycDZObEhxZ1BaWEdUU1RM?=
 =?utf-8?B?YlRqa3RXK01qQ3Rxdk9VZFJqejBaNUtETUIwZFFZWUo4ak5HZk03WUdnTGE0?=
 =?utf-8?B?WVVwZHBMdURONjhXKzhtWk9MM1VqTnEyeU5rQXBLZkxHU29DOTBWWXpvTmNl?=
 =?utf-8?B?SFV6aUhPMUUva3N5M0Q3eUd5VkFWNU9VKy9iaDVhUkY1am0wSmNoT1FNOWQr?=
 =?utf-8?B?QWVVTWIya1FVc3A2MHVWWXR5KzNxbVUzbFdta000cXhxS1hSMWdPVi9VSytw?=
 =?utf-8?B?NXRzRDg0aXo4NDVCT1BrRTJZanhteVlBbXMwRU5CdmluUHdwaVFHenBUenZX?=
 =?utf-8?B?SnNMdTk0aVVpYVV1REViM2d0S1BYS0x5dlZaZkpRRnhWdmdTODIvcG81dlFV?=
 =?utf-8?B?aHhHN3QvcTlMR0FsUnBMc1BDUmRkNyt2T2RzdWFZVkN6Y1FtblJ2RVMxbGNO?=
 =?utf-8?B?WERZanlFK3JLOXRXTEtZK2lwaWZEa2VsejREeWJVRStSYlVFbllvZHIvWTUx?=
 =?utf-8?B?TUtWajVVbEVxVXZWNlZlcTBLRGVSQXNCYmN5bTl5cTNMcFNmSDFCRmVQMlF2?=
 =?utf-8?B?d2VKRnYxS3ROMTNFRjRqUVNrUzM2SHJwcW9paU05VW51QWxPaGNTaE1WNGJH?=
 =?utf-8?B?cXQrL1J5SDJ6YUR2M0pYc2ptSEVuNGxLOVBINWhLUmhlTDBLMjk0Q1pWa0Qz?=
 =?utf-8?B?UmpNOXEyWjRFUUtEU3hlRGFjVEgzOWoyR2VLUnE2eUJ5dkhuUXFramwwWVhQ?=
 =?utf-8?B?N0RpZW5Xb281Y3M5L1didkdNQWtRMjFwY1drVmlXWFJqV3FSMUVjWnlOOEMy?=
 =?utf-8?B?aDVwelJxODFRSm1PUjBOQ1prNWQzdG93RFB1UXFkN0lBZldLR3ZENnAwOVZr?=
 =?utf-8?B?ZzI1dERGZkpUUGhNS1BjM1FGdHh4RHBYazB2TmpUb2xmaE90d0p5SzZQV2I3?=
 =?utf-8?B?SHN2dFRFWFl5NUFxVFZZdUNrMW5aVnM0bWlSbkZ4ZmpGbG9uZyt2R1cxb2oy?=
 =?utf-8?B?Rll2YTJGRkw5b1E2NGNzRzlkZjlyRWp5YkZ1Q2I2bW5VM25ITG9PUThSQmZj?=
 =?utf-8?B?MU91Z2kxdUkxcll1c1dLYW1CNFJJZ2hTakcvaHdUalZCZjQ0dEdZSC90TFo1?=
 =?utf-8?B?SGYwQ1B2MC90a0FFbTdPb2FlU2VWQkxwQjZlQkk2aHRvWEtMMGZMRU4zbFgv?=
 =?utf-8?B?M0Nwd2t4eVB3MTNiK0dBUnlzYjhmblJKTmN6N1pkMHJMOEVsbEZsK2RBTDI2?=
 =?utf-8?B?SmRHVXI3UXh5V1hDZWUrS2VWNkNhaytiVEh6eDBqMkd2aXJBSFI4Tk1yelcw?=
 =?utf-8?B?NjF2b1hJeWR3TSt5SmxtUmhJblpFQkhqVVNPUVc0QmlmZW5HRGFUTjdNcGwy?=
 =?utf-8?B?clJVeUlFaXdIUGRLYjdoMHFvaUpSSTZ5enRDM1djT2Y0YnRvZWZvbjhwVXVm?=
 =?utf-8?B?emhBT1N1aGVFNlM0OWl2ZFJEMlBiNTQ3aS92elc3WkplRzdvaFBURGhUQWZE?=
 =?utf-8?B?M0ErbVQ1TFBHSDQyUmV6VG5VVmtaWVRDdjA4YWZQZmdnNWNmRnlZZzFkZENT?=
 =?utf-8?B?QTEyd3NQakxMUCtmeS83R29BQzdSWnpqMUVVS1d2akpEc2paMDdRbmUwMGxl?=
 =?utf-8?B?bm5CcjhPNDVkLzRFVXhVMVVRZ0JUVU5XZFdGRmhmQXFRMWVFTFpyVkFmU3dK?=
 =?utf-8?B?MExnYkZENkdwL1VXcFRydTFjRW1vcWFrenM4TlZ2Vmw1a3p1RXk5V1JKSzhs?=
 =?utf-8?B?bk15eTNOVmZmMlJVM3NXNE15cXNqTjdzSWwvYnZKRUlhSmpiakE3TVo2cXp5?=
 =?utf-8?B?WHc3MmRzVEVScVMzMTJvSTdObjlmdTM1K1J1bmw3OE9kUStka0ZSRmllaTNu?=
 =?utf-8?B?ektjWVF1b2svMTBJZkxST2tGZ05HWUlyMll0bld6ajlBSDdiSi8rK3VTZXpY?=
 =?utf-8?B?SEpOSkUyR3BYdVNadWFGa001VmpIQUxaSHJkaXllaGR5WFZtSEQvUnVuL3lK?=
 =?utf-8?Q?toWCHr/Xy/vfVGpmDnObxU7v7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f409f9-7b63-4f34-c6f6-08dd991563d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:45:30.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCbDoCU/bAagQC96v3G4nQjgzj+rweZ5fuwzywl87KPmgoSMy20gobQnPDQS4K6wg2f+N+Bi4XF6Qp4yWsWmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765


On 5/21/25 19:23, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Add a function for facilitating the report of capabilities missing the
>> expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/pci.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>>   drivers/cxl/core/port.c |  8 ++++----
>>   drivers/cxl/core/regs.c | 38 ++++++++++++++++++++++----------------
>>   drivers/cxl/cxl.h       |  6 +++---
>>   drivers/cxl/cxlpci.h    |  2 +-
>>   drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
>>   include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
>>   7 files changed, 114 insertions(+), 29 deletions(-)
> [..]
>> @@ -434,7 +449,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>   	map->base = NULL;
>>   }
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -444,21 +459,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	switch (map->reg_type) {
>>   	case CXL_REGLOC_RBI_COMPONENT:
>>   		comp_map = &map->component_map;
>> -		cxl_probe_component_regs(host, base, comp_map);
>> +		cxl_probe_component_regs(host, base, comp_map, caps);
>>   		dev_dbg(host, "Set up component registers\n");
>>   		break;
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>> -		cxl_probe_device_regs(host, base, dev_map);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>> +		cxl_probe_device_regs(host, base, dev_map, caps);
> I thought we talked about this before [1] , i.e. that there is no need
> to pass @caps through the stack.


You did not like to add a new capability field to current structs 
because the information needed was already there in the map. I think it 
was a fair comment, so the caps, a variable the caller gives, is set 
during the discovery without any internal struct added.


Regarding what you suggest below, I have to disagree. This change was 
introduced for dealing with a driver using CXL, that is a Type2 or 
future Type1 driver. IMO, most of the innerworkings should be hidden to 
those clients and therefore working with the map struct is far from 
ideal, and it is not currently accessible from those drivers. With these 
new drivers the core does not know what should be there, so the check is 
delayed and left to the driver. IMO, from a Type2/Type1 driver 
perspective, it is better to deal with caps expected/found than being 
aware of those internal CXL register discovery and maps. I will go back 
to this in a later comment in your review what states "the driver should 
know" . That is true, as the patchset introduces this expectation for 
facilitating to know/check if the right registers are there. But note 
this is not only about that final end, but the API handling something 
going wrong on that discovery/mapping.


> [1]: http://lore.kernel.org/678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch
>
> Here is the proposal that moves this simple check to the leaf consumer
> where it belongs vs plumbing @caps everywhere, note how this removes
> burden from the core, not add burden to support more use cases:
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ecdb22ae6952..5f511cf4bab0 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -434,7 +434,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>   	map->base = NULL;
>   }
>   
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static void cxl_probe_regs(struct cxl_register_map *map)
>   {
>   	struct cxl_component_reg_map *comp_map;
>   	struct cxl_device_reg_map *dev_map;
> @@ -450,22 +450,11 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>   	case CXL_REGLOC_RBI_MEMDEV:
>   		dev_map = &map->device_map;
>   		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>   		dev_dbg(host, "Probing device registers...\n");
>   		break;
>   	default:
>   		break;
>   	}
> -
> -	return 0;
>   }
>   
>   int cxl_setup_regs(struct cxl_register_map *map)
> @@ -476,10 +465,10 @@ int cxl_setup_regs(struct cxl_register_map *map)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_probe_regs(map);
> +	cxl_probe_regs(map);
>   	cxl_unmap_regblock(map);
>   
> -	return rc;
> +	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, "CXL");
>   
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d5447c7d540f..cfe4b5fa948a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -945,6 +945,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	/* Check for mandatory CXL Memory Class Device capabilities */
> +	if (!map.device_map.status.valid || !map.device_map.mbox.valid ||
> +	    !map.device_map.memdev.valid) {
> +		dev_err(&pdev->dev, "registers not found: %s%s%s\n",
> +			!map.device_map.status.valid ? "status " : "",
> +			!map.device_map.mbox.valid ? "mbox " : "",
> +			!map.device_map.memdev.valid ? "memdev " : "");
> +		return -ENXIO;
> +	}
> +
>   	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>   	if (rc)
>   		return rc;

