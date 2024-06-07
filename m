Return-Path: <netdev+bounces-101655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F38FFB78
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2DE1F2326B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0D14F10E;
	Fri,  7 Jun 2024 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EO+eTHTB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6118049;
	Fri,  7 Jun 2024 05:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739663; cv=fail; b=CridngQiW/rCQazjjWdwVljpXdWIOegWCXraGcumfflu6Jr7fBLQm4lIjJZFpdT0/vn8g2Za0a6jm1nGGbUrADaj6ah/jYCa4dYap+THKXruN4IXVXHA2YErvjiDMxpDn6l6WUy4RXtUW81BbCJ9Ador0KyZEuSQlpSKb2FJfLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739663; c=relaxed/simple;
	bh=/SRXxYBOPxT4rdjlwjaqXCeQTnOe1LIk/WlNfulo1qE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JC9OGhOc2i9ZCDoA87Wxoqy3fJZQpWOs0pUqMe5q4tQeAywjN9qbjT6ZaXSPqMw/7eYGIReyA6R4ctsXn5WApQtDKaGje3sCs1Ew4wz5e/BqzAU4OGysRMrYaC1OJHjRYfZdi2S0LIoFl0hC1o7DOyXA1L27q4aBzaZf7kalL6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EO+eTHTB; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqYc5y2sigfFU3zrLQCXSnskk2N/gc1UUzBfU/4h5JRlxkC1bzBOusV4HEqLNvLSEd0BO6SvfIRWT6GzqDyJaufdKS/FRLrQgQTrRZhX2glSDLTwOdsWqyhgrF+UL2Ygm9X20LKUojCEaGuTnvLk3ufr2ZDOt6CP5aZbOvUY0w4DckmS4at/NguxlQ3EGaH77tf2RbjIWF6DQg9rzIogBNuC7rQzMqImmMUOo6ocUB9oNMXF87sIMUMeWkdWvnxQ82DkyvndadIRBF6LZ7fi+W6KfEk70uAvqpppV9SOIRMXzb2AGXNeDqruIPo1LCGHBp52y4QAJnGgqCSFu7VoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI5AS3dzwMqQJNnysWKYP3UOnDaeV3V2KM4y5f3JaCU=;
 b=RE4kzEjapc1ibKBjizW0kj3zzAEidDpGBv+HcFmtSXiuEGT8PoKUpvJe+xyUjKsj7BvJWmq05EF8OqYZ2FwOotG2xzqVoJuNp9o9TPtlbtux2s//97nlA+zFiUDBzd+wxB8rjXY1x9hrBJKJnGtofWCJ/t9pA2chQApjwxBgiIvy6zPkd+rHEWKqBPQ1dCEL/in3PjQP0q6thp1ttwpQZfLO/FCNpuNKdVnlZr9XdOks/ZMW7XIB0kgJ1XveyI0XYZK1IvZG6XKegkPeow5qmOqxTSfkTCHQLOsRLHHmIoOOnTThhop/yiqmTgPkI7psSvVxMRHx7d2qkoW+cNxawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI5AS3dzwMqQJNnysWKYP3UOnDaeV3V2KM4y5f3JaCU=;
 b=EO+eTHTBYBHMCGmn/8LA+eKmJK7Y1cyAuvxapE7LiQQ5uXJMQL5fwvPKFhfgicdTMMhzVvpcSXHc57jMgH0pFTV7j0jS+WSbj3pPVboUD3ydYK2udEgWcKuzH0ux16rwqdSzVZL9PfUpktW+UwXoJUz1vBQZA3oyDijPMUU0ZXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 05:54:19 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 05:54:19 +0000
Message-ID: <8829c75f-eea5-41e2-b594-5c648216756a@amd.com>
Date: Fri, 7 Jun 2024 11:24:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: macb: queue tie-off or disable
 during WOL suspend
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-2-vineeth.karumanchi@amd.com>
 <90da3dd6-e361-46d0-b547-c662b649b03d@lunn.ch>
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <90da3dd6-e361-46d0-b547-c662b649b03d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0298275f-23aa-4c30-d42b-08dc86b645a0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjBWK0thV1VTdnVFd09KaHRQNXpEalJISVhsVU9KV3VVdkxpMHU1eWRkT3RT?=
 =?utf-8?B?bUFpdUhiMDQ4VFpscEdZc3Z0cGk4RlJ3azFHbDVPSnZJVHZ0V0U1eCtGTWl1?=
 =?utf-8?B?SXJXTU1RZFQyVmdaVjhVMkY4UWVzVnhDTFBqM1B0eFZsdDdhYkpxZzAwRkc2?=
 =?utf-8?B?YXhVVkF0NXpXZ213akVSTjl6alBxa0p1am93THJFUHhqSkhaOUdXdXlvbm12?=
 =?utf-8?B?aFIwUjJTT29uaU9paHE5a1Q3dmxJcitIbkQyOHBlZWROV2VkeWZLakhZQkpR?=
 =?utf-8?B?THRObFlUSEhjVzNPZUpIbXZuWERIV0I4aEJJSTZHQUlWUXRKRTBhdmN0YUlw?=
 =?utf-8?B?djRsakNSRHRhdXpvbkJLNm1udHc3VHBuSU1XRkNZTVhTamMxSjFtNWNGeWF6?=
 =?utf-8?B?aktISDN1QkpSN3RyN3JHUVE1WXd5aGVST3ZWVGxDMmt0elI0TnNiQm9Ialpi?=
 =?utf-8?B?WTBXaVh6Q21KVGE5MGVlcUFhT21Ha3JNRTdwQkdZcDVsQ1VjUGJQcjF3cHNO?=
 =?utf-8?B?WmsrZjF1aWJPbm9sVStFK2Jldmt1RFl2Z3h5OWIrMkNwTjZjbjdyY0JLOUx6?=
 =?utf-8?B?V3FaZDQ4bXVmMnptV0R1NkVpNjRSRjNFNVRlMlNSenBCZGcwdThhVjRuT05i?=
 =?utf-8?B?cXE0RnBwbHM2Z0NkOFU5QlB5Y1dsWXA0NjlQekhSbGdCTkViNVUvWURIb0Rh?=
 =?utf-8?B?R2x5QWdjRERiVXY3YTV0SFVVenNKQzVNclNaKzZoOUV4MGUxQVM5TTd4aC9Z?=
 =?utf-8?B?bDB4c082Q2UvTVJXU0pLSDVCdEczNFRvbkFyQ2gzODhwSis1eWlaQVd6NmZm?=
 =?utf-8?B?MVRQY3BtYmdibFQ5NlRXTE1BSWFMa1pFZjZtYXZoWkJZREorck4wRWl6a2pu?=
 =?utf-8?B?dlY1SFNGTkFEbWozVE9QVkVtRjZXMGF1S1NPaHEwbzFwdnFhY2dNUy9CYVJI?=
 =?utf-8?B?OXlVUE5pUnhlQjI3NWpORjZoSXZNYmRnd2piTGhvdktKRG85YWtINFVLYTVl?=
 =?utf-8?B?YWZ2Y3gzeXgwaDU5djdTUUprb09YNXZJc3Q2TFJvVWEvZ1gwY0w4Q2ovaE1Z?=
 =?utf-8?B?ajd4eFMxS3orS01WUnhzT004dFo4RFFYdUFKZUhtYWt3TDloWnVjbVZ0Uzgy?=
 =?utf-8?B?aC93OW14cXM3SWMwRnZudkRqMVV1bHdaenpFZEdVcE8zOGlOdkJBM09teVVW?=
 =?utf-8?B?am13bHFZMDdaNExQWWpKdjViTTE1VWNmcktDRUFBWU9BN2xhMEZROFZFY09P?=
 =?utf-8?B?aDBLUmU1VGNJQUJpVlc1YUFVYWlKSSt3OUNSdWtsM3I1cXBBbFVRRDQwaCtE?=
 =?utf-8?B?dm5KUHFaazVjQzZXODVBaHhybFFtSm5mNHZQamVmVXVmMXJIWkFHZDB1eklu?=
 =?utf-8?B?ZTlJOUFXSmNaZHpuNVkyc1gzTTlScDVZRmpvZ3ZnMFVvenJQYUQ1Vzk2NlpI?=
 =?utf-8?B?UXBNQ1A0VWI2cTZGSng4RlFXMWZTOUQvWFg5L3kwWjhxUEY0a1ZldmpBRkpK?=
 =?utf-8?B?bzdhNE5zMGsvVmxTL1JjWXQwN3BxY2tGVjYzUlhwQ3hLM2c3SEN4Q2pQS0Ux?=
 =?utf-8?B?ajZxbU1Za2lLQ0xjYms5RUxYQ3Q5WExnR1NkOGUyZVhWVGIwdS95bjRaS2My?=
 =?utf-8?B?allZZ2JXSXJQbU4xdXg1NVMxczNaczVYTGw3U1dwc2tib3h6em55RHBsMk9u?=
 =?utf-8?B?bkVDL05iZW96aWhxdE5SaDVDbUE0aTBIWnNzcWdKZWxZb3RvdFVkcHR3SC8v?=
 =?utf-8?Q?7PIZcT+XFPkpase+BkYEaEsJwie9V1blx7b4o+e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUxkSzlQb2U1ZzRtb1Y3WkhVQTBYRmRoVElVc3VEcXhqa3RyMzVGYjdPRlRI?=
 =?utf-8?B?TU5WckZ1QzR1d3VzeUNZOEl0TFk3YXZFRjI0ZWJiNFFDUnVxMmMzSGx6aFpo?=
 =?utf-8?B?aFJNeUZ3d1R6Unhtck5KZGFZRVFhV3I0dGJlRGlvQzBQSXl3cDdvVjV4Vkc3?=
 =?utf-8?B?OVA1UjNHdFRrZkE2Y0Nvb1d4U1JvRnRLQStmVEo5UE5KWW81K3ZFcC9pTmRu?=
 =?utf-8?B?eFBoOFdzOXBUWFQ4WmxDeVdoMWlpVk9OdWpNWW1ubnFkNFJaSTlIU1ZLYnlQ?=
 =?utf-8?B?ejJJZHorNnlyYWZ2aUdwR0Z4alA5Vlc3dUhqUEs3M0hRRWh2MjNNZWVJc2lR?=
 =?utf-8?B?TnZIS2RCbmxFSTNvY1Q2VzhiRTZ3Sm95cWRha1p2ZFZXamVTQnkzenJCOUth?=
 =?utf-8?B?K09ENDB2QSs3Vjc0b0Q1SmNJaHpVWUpwREdGamViNy81NGtxSEdGdU5pTzls?=
 =?utf-8?B?akd0MC9qMS9TZkJhdEtrZkNzd2hYZGpRQ2wzSDN3VCs5UkNkdFBVYnEzMDZW?=
 =?utf-8?B?bFUxQklQcE8yY0VmeSsxcnBVWWQzbTQ3TGwyT25OL241TGhyYzFVU2N6dkpD?=
 =?utf-8?B?Sk5JaFRDcFZ2cGhVanNMdFRtalhJa3NpTE1WZStQVFgvYkRsVlZETTRjUk00?=
 =?utf-8?B?ZGpyNFBaWVJXSnZBWVFPL0JJZkRra0ViNkg4bEt5UXNOZkh4RE5HNDlIbWhp?=
 =?utf-8?B?WU5UQ0lCUGFVeFJpZkFlcEZZZ0d4MXJPTURWZTdqc3BGSXlXRUJ0bm9DcWtz?=
 =?utf-8?B?UXhmUWJTcHJtS0RRTW54L1lOYUVVQW95S0VCK3FxeGxodHR4SHc2bjgwYytq?=
 =?utf-8?B?QTVKam5wRFVmWE1GbzM3WTY3T2RMT1dVVXYwNGlVWUN3djNLY2xvSWZFeFZS?=
 =?utf-8?B?Um1rYW5TRjlvRWN4Y0lXSTdCZGxzNHEvU3k1ZkFEYUM4aTE5b2x0UXo0MlNa?=
 =?utf-8?B?NFNHaEFKSlFCaE1FRHZwUDg3WlBuWWJYZ1NBdVVDeGNrZFUxRERFR05wWmxS?=
 =?utf-8?B?eGxqT3RBc1Jvdm53Vm1KOW1rTUc5SkNrUWpUVzdYUnZFRXJXREpwNTlJSmlK?=
 =?utf-8?B?UzhzbWV4M3ZXUGdTM0psVGZGOWlKc29KZytITGkrRXNTSzRicTN5T1FrdHZW?=
 =?utf-8?B?K1BnbThUOEZqaFdYS01JZnJkVUxodlNqMnJPaFlIc085MlZZeW1xeUpqTnlq?=
 =?utf-8?B?UE1ORXFhUTZGMmVlREg2eEVEQUh5dmF6cjBhS3ZnSktISWxMbEJVNkx0Ullt?=
 =?utf-8?B?ZE9xNW1OMWpEd3ZTQ1NOb2MxRllLZjVMc0d3dGcxbGZjek5ZVWJ2Z2I4Zndp?=
 =?utf-8?B?dGVwZFFQdEdUWENmSWpWeTBkYUdJOS91VlJnQjdEeVhqL2k2eWs5RWtrNktM?=
 =?utf-8?B?WnhEd1RKeUdVZzJNT0ZjZ29RdlZRYkVsRG94VGVvMzB2eXcvOEJXL3RBMEp3?=
 =?utf-8?B?WkhORDlJenFGYklla2hTRG41SXl5dFZUYnFVRmlCS01RLzRXK2dFUWFxU3hN?=
 =?utf-8?B?amsxRFNuVUtkNGFlN0swcG1EdlFzYktTVUZlR0hRRWtFSzQxWm91b1hRWDlY?=
 =?utf-8?B?dkVqL0hOTUNjQ3lDNVI2anhRTEJkOGFmcTQ3Ym9YSlNOUG5ncDJURGxkcHJC?=
 =?utf-8?B?NTFJMHF2bk1SazV0WUsreHdQejQvN3dFQS9SRDJiSm5HYlpsZTRoSjhNaEFR?=
 =?utf-8?B?Vm5rYjM3aFBiZkxNQ01JMDR0bTBPZnZPWTkya0h3L29PQUEzazdKTE5UdWpU?=
 =?utf-8?B?NENNWmJ3SHY3dUpQNDVLeE55REthR3B3cUVweWwrMHRON25oMXEzc24zdjIw?=
 =?utf-8?B?cjF1Ukgza29uNjRPWWYwWWg5SXRQTngxRUhtbjlZWGlxTy9ZT3NCTEg2V2w1?=
 =?utf-8?B?MGdidGhENEREbmhsUjZOM240eWpUYk1uOEZ5T0lINmpMeFVneUJJZTJsaHp4?=
 =?utf-8?B?OEp0NlJaQTdTeG8vNkdoVXR0bWEzS3kzSUMxd29yVDJaV0VHaGdRdm1PR2V1?=
 =?utf-8?B?TURzM3VVaE5JOHgvdXN1WWF2dk4zY056YUFXVGFWOVpwcyszR1pVTEUzcFRG?=
 =?utf-8?B?dHhjWGJGQWFRUk5hZWdCNlJmb2N3SVhydkRURFVCVG92akg5c1hzOTdiUW8z?=
 =?utf-8?Q?s/fU/+M1oSHKRCZS/j/1JaoMp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0298275f-23aa-4c30-d42b-08dc86b645a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 05:54:19.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6bewLaIsXwAvPyZ2ovahMwlYNCjt2y6FCLQlMN1bWb9XJqX0pqdaoRWhH0HspUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

Hi Andrew,


On 06/06/24 7:14 am, Andrew Lunn wrote:
>> @@ -5224,17 +5257,38 @@ static int __maybe_unused macb_suspend(struct device *dev)
>>   
>>   	if (bp->wol & MACB_WOL_ENABLED) {
>>   		spin_lock_irqsave(&bp->lock, flags);
>> -		/* Flush all status bits */
>> -		macb_writel(bp, TSR, -1);
>> -		macb_writel(bp, RSR, -1);
>> +
>> +		/* Disable Tx and Rx engines before  disabling the queues,
>> +		 * this is mandatory as per the IP spec sheet
>> +		 */
>> +		tmp = macb_readl(bp, NCR);
>> +		macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));
> 
> Is there any need to wait for this to complete? What if there is a DMA
> transaction in flight?
> 
> 	Andrew


For newer (r1p10 +) versions , there is a new bit in status register to 
get the active axi transaction, we can leverage it.


For older versions, there is no mechanism to check the current ongoing
transaction, it is a corner case. Currently, in macb_close(), iflink 
down and in suspend we are disabling / cutting clocks to the engine
without checking any DMA transaction in flight.


Thanks
Vineeth





