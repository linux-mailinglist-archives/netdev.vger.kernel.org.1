Return-Path: <netdev+bounces-239251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC9C66444
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 22:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D608C4EDB86
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE573233E3;
	Mon, 17 Nov 2025 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltAZi8C1"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D2322537
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414479; cv=fail; b=K/nDYvwE0+C5UOr7zTHJzJvFRyBVHtfLjc3fh9Fz4JJWKK6abpwpTr7yPsDhCZl5WnUU6Wp5w6oKqTBUZ6f22MTObMAEohdk6ExTOQ5iEPMHb8o5AlLhalQ7NEt6O/Nk6Httdae51aMtrthwNF+I9bR7fdMwCU5fPrLzH/7sr4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414479; c=relaxed/simple;
	bh=TPh3Euwtk6s/rQvJ7/UfVRQkhygJq2urTKrFWt7DyZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oPIWf0y83DlpJXrntyPTtwLajk+2ZbUJ0CdQW+aXlL01XJlogNlCdtsNiJhxS+SCNhPiZcXBN7bV9YR14CMibox2qRjfd3do1CcGZtHQ4Mi9+PzfnVJI8EF9gLXgZUrS9Wu2RbUccxkGmmGBNJYJDo4DjCLOUMjFYyTOD42DgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ltAZi8C1; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLhIU/S1Fmrvc5nOst4bqYiow42IlIoCJW+qAdXh1QBtWHRUPAwJERg8AiYSr692ufzzJJtMceex+QBuy+MettJ8wfuflJdl9m5VUMb7zQw/JVgCM3xQyw6BLyR7/xnjD028raM13SWiryV/QZmrkjbvS05V76r6nuRju2Fve7iJRJ0p8lwsJcGMlhqt7B+0mYqCY2TvnEDMwIGPQjmRQO/CsPhU0fk/ktaheCL0Ww2IxBzSiG3S8oMd7VFYcwX1OnBiLyRN4IrD5UymoF4Emwld/ApPrq87nhVdvOjoB6oNdnPricSHAtWiYciVzWYOxFQ+nLsElqJ2IOQFFW8gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjzajBb4oNFdh1orYfRxmbOZ8blXH04i9Hxt7yAUNcs=;
 b=v+732PB62mZK1SahIOZk65919BSi5CEFJRMxq4Y08ak4EnVPNOmv5R6trye/yz8/3nyioChgjwjjhRW/vZ/gyp0ZO+mUbbLgbQHwnhKgwZgx5IPJEmE8497Q4RGaYbHmdXKTUdQDSQTHpFxLs8XplxFfj2NSAi5MxSPStRCGr0RRk/gyGKiP03Gqxv/ODLQus5CkVxu5Eks3JxC40hr1f/XrDZA/VgbM08Dpj+zcRI6qSeRtPUFnHhqWWU8y0wFvu4qAfFjuaX6HKPSQicAJls4s4fnMpm1tE2FCYGBFmqaYD90putJ4UNqA06btbX0K1WoS7mxrmuphsLTH+o7phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjzajBb4oNFdh1orYfRxmbOZ8blXH04i9Hxt7yAUNcs=;
 b=ltAZi8C1JKy2C/We+XrCTzDsHB2AcxYtiAnAoRo7yI+jSoaVGFS2WWhTY50fy1/vdjg0U2wlEc+jVgDgEefUEccCDYZ0tIMnNUU+s6n/+SgluBXjLd0yH3WbnMUM3mrZJG6HT2BN1larlz6yBbgokafDp6W0Qi5C9TZFG3uZyhriDkOx/m7jmTGC113vupUbGv9J3goXzIp9AMPRykrli9iG6qz6eYn5aRWHwOWisQzrcPXscsyB5WK3ScBQBgdZeLzgeUUMYBWGYkg+42LvnWX7X4NP5hm5DVy+/jgbOXTgWVMpA33eqYiWkt4xyB+690yYxq4G2A2mU4R8FguvPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 21:21:11 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 21:21:11 +0000
Message-ID: <8b4325db-4237-46fb-aa54-bda65168f016@nvidia.com>
Date: Mon, 17 Nov 2025 15:21:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 05/12] virtio_net: Query and set flow filter
 caps
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251112193435.2096-2-danielj@nvidia.com>
 <20251112193435.2096-6-danielj@nvidia.com>
 <aRtYgplAuUnCxj2U@horms.kernel.org>
 <0483aaba-0b93-41d7-bf09-5430b5520395@nvidia.com>
 <aRuRGD-d7kImAKb3@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <aRuRGD-d7kImAKb3@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:21::27) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: ab51a2b2-199a-4d68-3c43-08de261f3afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk5RUEQzSHIwcEQzOVQ2V3JYcXVYci9oZEdOckhTeTAzUUs1Y1owZWd6bFln?=
 =?utf-8?B?WGRpK2hSbzFDcWdSNlJqY3I5bnF2TXhLRjlXaVlSU3V5Y2s4SDlxRFdMVnht?=
 =?utf-8?B?cEpreUxyZERTL1BZLzVUaFFuMVRsTlo1L252d1VPU3hCL2xVZDRuTzZUeWV1?=
 =?utf-8?B?M1pBUUpLZzYwNUQ1RU5yRWJFVDBJelRYZTg3MndWcCtmcVlJQTRxeXdOSlZU?=
 =?utf-8?B?TUFvalBRamovVzgwVitidEZ2clZsZ005RFRiVVphUzN2SDZwVVVPc0pMdCt4?=
 =?utf-8?B?UTduUXFucWVvWFFBTDFFQmRKV0VEbGlyVWVNZTA4SnN3K1lSVU9hK2FVUkNo?=
 =?utf-8?B?cktvelhDN2pkWFA5cUxiWlBJVjl0Y0xTS3FleEo2UmUvTVhaZXVZcE5Kek1h?=
 =?utf-8?B?ckxsdUc5U1Q0dG1pRHpkd2lsZ3dtQW1pVzdsbGs1ZWtMM2h1MDJZN3BqeExq?=
 =?utf-8?B?MTc2OEd3TUhFU2tQenlzMUhVdmZTVThubGtoVHJndjF0K3BTblY4YVkxcmNM?=
 =?utf-8?B?eEhjS3l4MzRQMWxkY0FEaVRITGZvRCtjalNkWkVCcytRYWRtL3BDbXFUb0dR?=
 =?utf-8?B?UUZEeXFnQUFVSk5uWm9tci82a2lWT3dhd0NsNElTK3hjVnVPWk9ldlUvRDFC?=
 =?utf-8?B?bWlhZzJPVnJvbEEvNFJnQmNSRU5Fa3VGQ0wrQ2xGN1o1RXhudzZHMGRuRmw4?=
 =?utf-8?B?Nm9TVklOdnVZTWdYZ3A5Mmo3dkl3RUZodVh1YkorOE1wNDc4WUhmTytWMVBr?=
 =?utf-8?B?Nm9Tb0IyRFJzUk8zbVYxRy9SK3ZRVUJNcG8xdS82eDhpcGtZMjZjWnUraXBu?=
 =?utf-8?B?bC8wYzNkSVVGS3J5V1pNangvcllla285aTFKNmJQWkt1YWRrSHg4dHoyNGxH?=
 =?utf-8?B?ajBXY3p5L2NhMWFub3FtZUM2Vkx1OHhscHJDRm5XWUNOVHpLbXlyWnBlR3Ey?=
 =?utf-8?B?YWVWa3FSdVZqOGN3OVh6ZHpnc3REenFRSWFiMDdsTm02MjFsdHJzd0lyWXNq?=
 =?utf-8?B?c0JpR0RsbkU3ZTRnMjV4VUxFazljVDQ2ekJnV203cUpZMS9WNXoxNVR3OVNV?=
 =?utf-8?B?VVVmL2tCb2kvYnVFWFQrRGk4MkZORDZEKzF2NlRNc21majQ4Q0ZocmgvS2ZG?=
 =?utf-8?B?QXNEbm1VWkN4OTlZVkRCbFdZd21KMFF3ZFZaVHFoZWY0WlNEL05sR2hhK0Q1?=
 =?utf-8?B?a25nT1pUUUE3QVMzMEdRbWt4aStRVjV2QlRKVzBQNEROeGRobHFwaWxkd0pt?=
 =?utf-8?B?cGk4WE50QUlUeWRsRWcraFBvaXFwVUlkaEpHZ0g5Qkgra1lvd2dYSHdvL0lt?=
 =?utf-8?B?akdFSW44aWlva3VHMnJHYURVdzJ6OUZwQXM3VTF5eHNLckVKZzVERmRxREY2?=
 =?utf-8?B?UHB2Sm5GelY2L1pIUFFpRDJUM290eERqRmloeDBybVVpMmcvc01maEw5bE9W?=
 =?utf-8?B?NEZhbXBwOXJSVWpQdHEzZUF0N0lObTl0dzBJS1c4VXUvMnNwbS9jT0JsOVha?=
 =?utf-8?B?ZEhxNCtLdjk0bFhCOXQrWHhRV1hiMXUyZ0JpeUkvd3ZlbHBkQ05kSFpVZmZi?=
 =?utf-8?B?QmROTTcvUjh4L3BXVTYvYVgzSGU1R0hjQ2pNZXZteUtlM01wbHliMFBUZ1I3?=
 =?utf-8?B?ZEQ1NXZoQm84TWF4SWtWZVEvdDhPU2k1Slp6bC9BOXRIMlJIQWJrbFRnV0pX?=
 =?utf-8?B?TnpTUFhBOHhWZWQxTGpvd3dOMTk3enJsSGs4M2FzVkpFbjBQK3VLUGNwK3BZ?=
 =?utf-8?B?Z1c0TjhnMzIrdHkzUFUxQVNWVFlwWE85dEVYcXhBajBZSVlibjh5RE53cGRa?=
 =?utf-8?B?azYzaGwySExtRUdtWVJ6VnlQb3E1Qis0dFl0Qmx5K3dscW5ZRWFRVnRsQmtM?=
 =?utf-8?B?M2dTRS9abTEzSGVndTVRM3FYMXhxVHIycmY5Wlk3b05RM3Q1TFBaVm9kVWk1?=
 =?utf-8?B?QmRKNmlCaE5hL1ZlTjZ0YW5HRGZSYlBlZzZTTTNWS010WW90T0ZZV21BUzdp?=
 =?utf-8?B?YmgyZCtsUHFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akM4Q3YyVkk2cUhzbXdCM09wT0oybjZnM0ZKaXU1QUNYNU45MXd4V3g3c0tC?=
 =?utf-8?B?NllpdXlTWFRpMzFPdS85WlRreXJyQ1ZlOHhubDJQYnhVOG8reVRTdmpaMnpF?=
 =?utf-8?B?Ymh2dmdjZy8vS2VZb2RYL1FqdHozdzdtNTQ0MEM2Ump5cDFWb0ZqL1FTdHJC?=
 =?utf-8?B?WGl5NmZKb1RrbHA3SWk2V2N4SUdBQ3BOV1YwQVdtcFRtbUNNamNMalhjM2JH?=
 =?utf-8?B?Vm1qeU43SzBjUTcrbHNvWTNNaUJXblordFhrbWFSeUxYakptU2pnTVdCVStE?=
 =?utf-8?B?T3draXBqZHVqeDlxME9xOXpVMWxWMUhXcDZSRVZyZE1JRkdEVG1jZE5zaGVo?=
 =?utf-8?B?QlU5bnF6NktybUdnZTRyNVgvZGl5T3pGUUFuSEVsRWpCUEJmNCtXSkNFWUwx?=
 =?utf-8?B?d3NHMnhsWXZ0OFBhU1pPV3QvNEZyVjdzYXhoNUFmZGgxTlE5aWxvbzFPOVJO?=
 =?utf-8?B?Wm9ZeWZ1Q0c5dEZZayt1amRiM3Yyd1pVTlZqM2plNjNCU3IxVXZlbThncHpO?=
 =?utf-8?B?UzZTcXo3T0VLQXRBK05hTHZuVCtuelFTZjVQSXl6YkdrYmd3WVdIYTUwN2ZL?=
 =?utf-8?B?QlVYcDcrSnY0QmFRallCenJxLzJOd3lLZDVXbENrVGpCZWpObVZrRWJvQWps?=
 =?utf-8?B?TEwzV0tNWm96VS9FVHpEbDVKUzBrOXRWa1F2SVNKMXBFYVFqZE1QQnYvUVNJ?=
 =?utf-8?B?Vjl6YVVKZkozdUI3eHIySXJrTVRaZi9uc0hPRHQwQTVqL2FYMWFFWUtNODh4?=
 =?utf-8?B?VUJWZHFsWFhqbEdFek1EVk93TWpQNk16ejhGZW5wKzkwb09RWkJyaDJxVGVy?=
 =?utf-8?B?c0s5bVJsOWdnVFd5OGZBQkwzSDNOaGxsRkw0TFJHaUtUYmZxTlJUWS9yODcy?=
 =?utf-8?B?NXRxVXBXUVY4ckhDa0MwYnRGZFFRNGpwNXhCOC9VdCtmVTlWNy9hcnRVVkVn?=
 =?utf-8?B?ZmpMUXhNYXppdmg2b0hmUFlrV2d0MlFDSnZvVDN1UTdLTTZUSVBkemcrRSti?=
 =?utf-8?B?SjUzT0haRzBUMnhOQWxNamN2NjczNEJTMzNMR1J0S1l6ZHFlMDJNeWNLbHh4?=
 =?utf-8?B?ekRDT0RMbXNWcDVPcDgvbWtoQ1dKWFhnMThZQzJEZktTV0czM293aGIwdFQv?=
 =?utf-8?B?Rm5GeFFIN0Q5bUhRTE5pb3ZxUkVVQ252VWRxVFREaTV5a1AzN1NLZTBTNXV5?=
 =?utf-8?B?NFUzZS8yL2xJMHI3YVlERUxlbERBdERkYitaQmVqdTNNZXJtblQyVEJMdUFV?=
 =?utf-8?B?b25QRlkyby8zSGlIMVR2QmpCeWk2OEtnT0lLaWU4TTFWNm1HMUVlSmNHcmIv?=
 =?utf-8?B?K25yYU5YUVU5NDg4N1JKVmNIWTF1NlJVMVRzTFh3cTZGSHNiWjFPV0d6MjAy?=
 =?utf-8?B?aDFPTGV1Q1lHNXJhZW5ZcWdJcTYzVTVva01wRXlLY0Y5eGxpakd5Zys5M01n?=
 =?utf-8?B?eFpyTkNtbUJpQWpiUW5SRU1CSFg1YW5oN2J3RnhEREt2Q1NjSGt3bjNXSjkw?=
 =?utf-8?B?czRzelVscHp2RndMejFoMGp3ZVN3MmkzZm9oS2Z2L0xoMkhMQ3Rnd0o2dDhh?=
 =?utf-8?B?TkNPMWxFZnVMWTIwTnJ2TVZmbnB0SEFSbjV5K3NCV1psRzFNeWx5UWFlTGI1?=
 =?utf-8?B?UG43S00zMHowVk4ySU1tR2RYcTZNWDNhZ1A5WWdONmtvdXhsckMxbTZ5blRQ?=
 =?utf-8?B?WDB6NmU4UWMzZng5ZTNsNkJNU1JuTVZqMEtKNHgvUmNBcmJRcnhvR2tCZEhi?=
 =?utf-8?B?Y0RSV0p0YjZpMFRLY3ZFeFpvKzkrT3FsMjR5ZWJ1OS8xaFYwTHdPTTc5SzRu?=
 =?utf-8?B?cm4xZC83K3U5SHN4RG45NklBRGppd1lWWHNCQjc1Y0k3N3poNi91bXZvSnZ0?=
 =?utf-8?B?RCt5UWhZWHZFQmdpb21XRnJ4UmxXUG42bXpwMTJxcmJEQmIvZ0E1Q0lmYitn?=
 =?utf-8?B?MDBpcEJ1NTVKelhhRm5IT1Z4TlF6RmdlUzFaZWYxNFpNTlhlTW5TeUR0WUlR?=
 =?utf-8?B?REl4MFhQNStnOE5xWE5LRVJUUWhHUFNYMGdsZ1hBSzEwMHM4bDJyRWpPQ0Rx?=
 =?utf-8?B?WmZZaUVhelFFT2FJWTNtN1NyYVlndG9zYVFZU2RFRWNnMCtZZmFpMS9HMFFv?=
 =?utf-8?Q?qg7oFrwSVcvGjq/+a2N15//pa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51a2b2-199a-4d68-3c43-08de261f3afd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:21:11.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckLvX684mudJ4AnhHSht/kd+a25uY3OWViROG9JmOPBMY/7HcQ7LPFhQOxiaghlE4P5fSquPPCj6soMyoRHbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

On 11/17/25 3:18 PM, Simon Horman wrote:
> On Mon, Nov 17, 2025 at 11:49:54AM -0600, Dan Jurgens wrote:
>> On 11/17/25 11:16 AM, Simon Horman wrote:
>>> On Wed, Nov 12, 2025 at 01:34:28PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
>>>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>>>> +		if (sel->length > MAX_SEL_LEN) {
>>>> +			err = -EINVAL;
>>>> +			goto err_ff_action;
>>>> +		}
>>>> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>>>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
>>>> +	}
>>>
>>> Hi Daniel,
>>>
>>> I'm not sure that the bounds checking in the loop above is adequate.
>>> For example, if ff->ff_mask->count is larger than expected.
>>> Or sel->length returns MAX_SEL_LEN each time then it seems
>>> than sel could overrun the space allocated for ff->ff_mask.
>>>
>>> Flagged by Claude Code with https://github.com/masoncl/review-prompts/
>>>
>>
>> I can also bound the loop by VIRTIO_NET_FF_MASK_TYPE_MAX. I'll also
>> address your comments about classifier and rules limits on patch 7 here,
>> by checking the rules and classifier limits are > 0.
> 
> Thanks.
> 
> I think that even if the loop is bounded there is still (a much smaller)
> scope for an overflow. This is because selectors isn't large enough for
> VIRTIO_NET_FF_MASK_TYPE_MAX entries if all of them have length ==
> MAX_SEL_LEN.
> 
>>
>> I'll wait to push a new version until I hear back from Michael about the
>> threading comment he made on the cover letter.
>>

I actually moved the if (real_ff_mask_size > ff_mask_size) check into
the loop, before updating the selector pointer.

