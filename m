Return-Path: <netdev+bounces-184223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3EA93EFE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07813B0C90
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17B22D7A4;
	Fri, 18 Apr 2025 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="pG9e9OlC"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023090.outbound.protection.outlook.com [52.101.44.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECA15442A;
	Fri, 18 Apr 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008790; cv=fail; b=p3zTS27RKFQVXzVrLvwzdgjBiimYxM5cD+7DeEu9L4yOIAhpxEY0VlpFbzYTfVbZ+U5bu+9J0OsnhGv8cQgjc0hj1bS6qd+PEini7svF6qmJ6yExDvT6eDDGAnMx7/xHkEjU0W+CHl+bCP7Gt87JfPN7XXi2KvDPxjjb9cqTFQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008790; c=relaxed/simple;
	bh=NzftBqNxqE0KF7An46DjKFjQUfNUaOQV05gap+snVug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fN7JtMb6GXo9uCill7kD3todSb7UfjAlRoJM8M7FeOwWMhrQ5cK/1kHlEDHWuQJPHVzhJfqu/dB+nG/wi8s0+poAb8vhd3sHlhHhsJ/HJ9yXRwlYMZxiO6RoxxP0PZsqzMpARELFOEQ7L19TCBqKvJdeWP5AZnAlZGOF+poxNGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=pG9e9OlC reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.44.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQbBhW47g1+fP9pucE5ipT6pR7JUP7nfyacOvdSvqN7nEz5/1OPdmaMB/+n3KidZHbvzssx41IHBsBV0aMp0u0EwZ6rw9Tdn4zT6T9effgZLCV8qJzUVpWubnjCpfA2fdI8ia+zsZlx9N4Rn/Tw4uJq3a4ppoXXuz724jz7OPSdKLHrbOl3jOUfNNdYswaQaA+HxMQQMk8rRCWNeGQxt9fVrGwa9x9xPd4aSZl3H3r2a3pS6K40Mc6Di/AaKD+8txTdCZpBGb/c08gOzgEwrFYd/Km7NY+4NQ1T0/VVeLSCRmMB4+HCNSfD/ys72+AgwH4/d8WT76vky+D5kixr4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzVi7iwZ48aZ58qpK+WGhWiQg6asv544XO/kNBCsKkM=;
 b=CnADeplbiEs/xQ+8cYU3k1jwJTfItkN345+clAn25iR8EJwcwZgVtJ8FD49hO/7XvU0NbWFN+rhPznUEQEXKjBG24k++l6AN3cHLORp4tHA8IiJ7u4n5DbT4PLDj9XH9uexi7FKDBJcbQYSl+Vi/gXl6FR/q63CH4s2b0VH5V81g+x4vO6fgrpR55PBY+72xlqAuk4L4pZMfLufjXgJGZ86IEvTTIMMmGo/bM4L2HQWY4z7sjKXHidi8Z9L1E/dH4Y2Xz0VGF6DpjtbjSkuGtRXf/3TVb8WPba5aOCJksSEaNW5Hb8xNXFJDatna1njQ1SKKxQ2puGa4XwPRofeBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzVi7iwZ48aZ58qpK+WGhWiQg6asv544XO/kNBCsKkM=;
 b=pG9e9OlCQTFCOK5D7RPBpjRjokwG+8DTQaz36kQa/KMVDXBB9npadFfYioJp5r33bqqlvCd3i480blW8kOzmVD1ilgAaFw4gwPrKdtAkaja+YoTBWLjxrHaYQGxDR/F7RKB24tlH9/2P17DA6r3L0/+DuA4rOXIiALVWKNiRVlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SN7PR01MB7902.prod.exchangelabs.com (2603:10b6:806:34c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Fri, 18 Apr 2025 20:39:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 20:39:44 +0000
Message-ID: <4d74b2dc-6c9a-4a45-9fc7-49f043120e6b@amperemail.onmicrosoft.com>
Date: Fri, 18 Apr 2025 16:39:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250220183411.269407-1-admiyo@os.amperecomputing.com>
 <20250220183411.269407-2-admiyo@os.amperecomputing.com>
 <20250224181117.21ad7ab1@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250224181117.21ad7ab1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SN7PR01MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 06334b8c-99df-48a3-ed48-08dd7eb92727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9MM1JZbjVmSVNsZzBvWDZ6cWFjYzdXYzNBNFI1Nm80aml6NnJyRmF3VVZ3?=
 =?utf-8?B?L2lrTEZFYlhpVGVzemw3MDEvZ0ZYZ2tnR0pMTFVoU3JtMS9FVUZPcDdNZm5G?=
 =?utf-8?B?aTE3cC9ZdnYxNXhpaHFMblZuRHVrU2g1c3pZWUJJd2h6UEJQZmJGZnlOMVlk?=
 =?utf-8?B?c25ISzFMZ1kvRGdvY3dHQThTNkxDSUt1eGZxT3NkMEpkUHBsdm10cDgrdFdx?=
 =?utf-8?B?SlBLejRYMFN6ZnBvS25oRWJPdUR4ZnkrdGVhQzk2Si82YUhSZkVNUEpTaXJh?=
 =?utf-8?B?QnlJMTVndFdVczJGbW1PajBieGtpZUxtamZXbkpKaWFjeWhhblZMQzdWSE82?=
 =?utf-8?B?MnFUbktJby9jZmVXMlJsN24rUmZtTjJQUncyUkR0SDdLcHg5a0hiaVBmU2d3?=
 =?utf-8?B?Vk9KUk5BN2ZRemxQbytzam4vVjVVN2RKSGhVRUQyZWxwQ3VGRHNCTXlhejhJ?=
 =?utf-8?B?TVJZUkxhWC81d3d4NzVld0JEWlBRZWtzeEQ4ZXBYOHJMQVUxK2pSWVBZZmVq?=
 =?utf-8?B?b0duZFd4Q1RoOXJjTXc0NnhwN28xU2V4eWhuNkNjeTIvMTJCdXM5b0hEaDlx?=
 =?utf-8?B?Y3B5YjBhSXlyUWRQRUJSSUtKY3BkNXQvZjhyekowOEZlSUFueGFSay9oTTNv?=
 =?utf-8?B?NkpQTEpBRWh2Ymk4ZEx6dERDWlR3U2JQNll3NVVTY0JmbzNlUHlQMzU1aGlk?=
 =?utf-8?B?Y1BjdHVWY3dIcUpnTTM0YlpOMHBLN2dobDBlT0lGbjdscW1tL1prQnBNWFhk?=
 =?utf-8?B?M21MeUJ2K0NFdDlleEI3ZGt2YlJzZ09RV1BJQko0bzdEYXB2VnpvRDNYRWdH?=
 =?utf-8?B?YXZwM1JOdEVrMXR5Y2RVa3RTbDJBUDRqN21Eb214NmNGdXVaVFllcVgvazQw?=
 =?utf-8?B?dEt5M0Z2VGFYcGRjS28xdGthMXNCZ1hMWCt6K21pNkZZYnhISVFmUnhIbDA4?=
 =?utf-8?B?Kyt3OUVBeWw0M3UyKzdqYy9FVElYdWlsYUlEUTliS0h6QXUwaVQzUkw4dytY?=
 =?utf-8?B?dzhuTXZFbDVNM3o0L0hNdCtuODJQaE8vQS8wRGdPRDFnWXZWOXVET3k3Zkcy?=
 =?utf-8?B?L29WYWlIWGFIRGVFcjcyNDZESjJhQ3g4eGovVnMxbmUzNmZ3K2Y3M3JoT3h6?=
 =?utf-8?B?Tm1IeUxQNTJzY3ZHUmdjM0pWOGpVSWl4cjBwblFDRVBiSnJNOWtVOUlLV0xD?=
 =?utf-8?B?Vno1QWVmeUJYRWJodmVUS1VIL0NSVStGMmkxMURRVS80TWdYY1R0V0FZcmdo?=
 =?utf-8?B?ai9ZL3BMSTJ3SlI4VFpPMzBQUmM3Z1pUZ1hhWFNKRGo5TXlxOWtBQ0E2T0V1?=
 =?utf-8?B?c1drVUxjOFE0NTg0d3FLZFVIMllmbUhpdWZTMjN0bDE1Umx2d0xJSHlDdEVs?=
 =?utf-8?B?dDM5WDg4b3A1YVZmRDNKcTFCbWZ4REI3ZUU5amcxUXFkV3BNTXY0U0drYjQ4?=
 =?utf-8?B?L2g5THNESmFNcHYvbThJd0lETG9mbWxsYXdOUUc1SGY1Q0h2M1QvWk1MeFhn?=
 =?utf-8?B?OWs2aVdlZ3BQTXhLTGJNN01IVEMvTUVZM1ZKMWhSa093Y3g4ZWgwZnNSVEJy?=
 =?utf-8?B?UTBLM0V6dmF4LzN4S0RIVGdzQUVoWmkzTHBvdUFNWlFNRklFZldUTHhDNGo4?=
 =?utf-8?B?Q281V1NYaW5KMityY2srSElXVUFTTGU1TlNhdEVMc1RCOUtxY1F5L3RVZU5C?=
 =?utf-8?B?QzNiUzR5N0VKMjN1bkxmRzBhTDltQk95V1U2NUhzYUw3MWtPeDVmM2FuNTBZ?=
 =?utf-8?B?MHphWDk1cE5tNC9OQ04rNnlLY2VOSEZCcmpXaVJJbUZ5S2MxLy9qd0YzYUNO?=
 =?utf-8?B?TndTbFNrUyt1Z3lzRnhpMUpvWUhHS3AyK29pWFMwbkR0YUtReTJBUTRIcVdR?=
 =?utf-8?B?MFZTN0FlL095RHFKdGY3S1l5S3BXMTF4bGhyTno4MTZkcnhrbGxtN0YwdjBa?=
 =?utf-8?Q?k+0FDS2P8F0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWUrRGIwSG1SUFp2dUltb3MrYldBUnBIVWxYMWN1b3hGemlMcElEYXFsay9T?=
 =?utf-8?B?dGRlUXU0NzdXdlpRdUdBNldQTmxod2thdWtjOVBHRDJVOHc0aXltblQyT1dj?=
 =?utf-8?B?MHdMNTJyalFxWUlvWi9Uem1lQk11eDI5TldkcFVMQms2a2hwV042TkRKOTQr?=
 =?utf-8?B?enZCdktLb25pWWVpYW1yV1M2N0VlRCtReDJHdno1U1VybCs5Q0htclFPcmRO?=
 =?utf-8?B?TnJkL0ZrSzhKdlRBQ1JuV0F0MzEyM1VreTFLSmxDcnQ4ZFVvdTBXS0hYN3Ry?=
 =?utf-8?B?MTJZd1htUFc2aUE3K1F0V3h2TVFFMWxDdUo2ZGpZakY3OWlFc09QMWllTVhi?=
 =?utf-8?B?eHNObURvelROZ3VwY2h0VHVHQ00zdjhBWnV0OU0yQVhUR2Y5eDFkNUNFQkVY?=
 =?utf-8?B?R01lT1E2anhBSnpKWjlxdDFpNmVVWEI0MnZKa21WVzQ1cklEd0lRK2tBZzFS?=
 =?utf-8?B?Unh3bHlaM1ZOSms2VERqaWZFbFNweUtKT2kvSnhaNUtscEk4Z3pBVjhGZ21Q?=
 =?utf-8?B?QzJZMUVSZDVMTVFadHFvK2Vxenc4NVdVaTg5WURKWFBhUXVzeWNpMjVLWW9B?=
 =?utf-8?B?OFFyRkRGVEIyNEVOSEF5cXU4c2FMRnV1RExRVytqcXhITjJxaWUyTHJ4ajRY?=
 =?utf-8?B?TDJnZ3dXckc3dWdLSXdEZFRFVEhxeUJTNmdKcEl1WDhlK1NROVd3NkoxZjFV?=
 =?utf-8?B?a0RuY0Q0MEhNWVhGLzRvY2ZsTG1VTmExVGJhM1V1anhXS09HRmRNVDhvM1JS?=
 =?utf-8?B?c0lMdi90MWtrRmVXZnBjcUlWTjkvTklTUklwbGc1YlY5UjVWc3hVSW5Lb2Fj?=
 =?utf-8?B?VGdnb1hYYmlkcnprVXRkWVJzajVqcTAzZk5raURLQmtTVUYwTWdwcDRtZGdk?=
 =?utf-8?B?UWxNNjNOVEV6cXRhQ2hvZW4yRE1xMUVaanF2WFI4OUc3T010TGdaRU1Bckt0?=
 =?utf-8?B?TFk5cHdOZkMva0xpUnVKZmRxL3UwR0ZScWdhV0ZCTUtxR0s3Z3U5bHNvNmla?=
 =?utf-8?B?VTk0aUJmMkZFZEtpR29QUnpLZE1WWDZNdi9RNzJNWXMvdGVzT0l5VVl3czF4?=
 =?utf-8?B?Y25udjZXMTkwU0RiZlFvWW8yNktnaFcvcFNoNFk1TnNuZEN6dkFwNVdOemlj?=
 =?utf-8?B?RHN0WkZZR0xrN3ppUmJqUEd3NnM2elZBemx5UlEvN2N6K0paUUsrOGU3ZWhQ?=
 =?utf-8?B?R2plUXZUYkc1SzBnT28rVnZzY1REdkZJVkx5TWVyMzFZaEpiaElPU0hGMURt?=
 =?utf-8?B?NzdlZmovc0QvaG1NbUh5Q0FTbnprcHptSHYyTmxEeUhDdHNub1k5T2dZdGdu?=
 =?utf-8?B?T2tUS0Z4SSt6aTBIZ0RvbnJzMjExMGlvbFMra3VNc3ppbk9ONG1LQ1hVR2Nm?=
 =?utf-8?B?dXN3UXZ1eDE2SGdIZElTeERJNlhxZ2g3VG9GM1dPamZueVJkbm9OYjdWcncy?=
 =?utf-8?B?SG5GSFppMHZ4eHlNR21pYVQvdWVpSFdPVGtrM2Q3a0k4ejFVU01JNzkwdVF4?=
 =?utf-8?B?S21OK3l1MFdwYlZGZWxDM0RWb3RlZklOTkJGZjJyZ2JxZTZUTzV4REROZDhT?=
 =?utf-8?B?OERpb1krZ3JxLy84aTlOdnkwT0t5NTVTaVlDelRWRFJLSllPTUlKeDI5dkNo?=
 =?utf-8?B?OEU3TGp1Rms5NGtpYTI2Wk84VVMrRXlUUC9Gd1Z2cEhCODhlL2NOdmFmRGQy?=
 =?utf-8?B?aHd6a2RBZWhvRFBMcW1ZVnhjVDJleHFBWGNueVBkTWR2ZWJTeHhrWlZmWXYr?=
 =?utf-8?B?VHNmYjk3ejdVRGIvM3BYQ3UwbjJYeDlLQ3JnalBESGpXSDZVOFQzV05UTXpO?=
 =?utf-8?B?NHVYZC9NUm10S2lyT2ozSTNicWZZZ1BGRHNRaFBBbjhpZGpWeVZOL0c0Qzcw?=
 =?utf-8?B?bmN3eWt0U0ZrbDJqWXMxWmpIQWdlQjdKcG5qalYxeDJhbm1yMEdpbXI3VjBH?=
 =?utf-8?B?NkRVcFJvOFArbzQ0NVpuSkk1UUZ5amxvRW51QUpNYThGVHVWUzVkcnU1SGhG?=
 =?utf-8?B?NXpLbEpmb3c2c3dTb0dvY0JjRTBDVE5zWHJUdGVOeFRMRCt5d2RCOHlhZXFU?=
 =?utf-8?B?eHR4QmJkckNTM3RLckp3V1ZBT01MWWpFb3o1RnNmUnMvbDlOeFlyb1RtS25w?=
 =?utf-8?B?U3V0SHU5YnEvbkdGVFdZNVJGRzdldTQ3cmtFTVdqdXo5SGt3K1h4bFJiODF0?=
 =?utf-8?B?L3lGaEgxK3lIOVhESGExNnlXdkVRRngwaDBqNDVNUjhwL21YVndqbkVMN1JQ?=
 =?utf-8?Q?lYrQv+1M7bt4SQfC/il8pnT/w2skLzC/xoUe6hLX6Q=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06334b8c-99df-48a3-ed48-08dd7eb92727
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 20:39:44.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mkj+QHq0JsBX6uQnBlB39NPKGdsv2da59/G/0YHuWEeNfHCVo/qCnp4x6qx9qlLFqbF25A18m19KXcERxaQODi7whOsLu2lqC8nLaEuro0h2/AK5mWEujcCjFApA9mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7902


On 2/24/25 21:11, Jakub Kicinski wrote:
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +	struct mctp_pcc_hdr  *mctp_pcc_header;
>> +	void __iomem *buffer;
>> +	unsigned long flags;
>> +	int len = skb->len;
>> +
>> +	dev_dstats_tx_add(ndev, len);
> To be safe you should call:
>
> 	if (skb_cow_head(skb, ..
>
> to make sure skb isn't a clone.
>
>> +	spin_lock_irqsave(&mpnd->lock, flags);
>> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
>> +	buffer = mpnd->outbox.chan->shmem;
>> +	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
>> +	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
>> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
>> +	       MCTP_SIGNATURE_LENGTH);
>> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
>> +
>> +	memcpy_toio(buffer, skb->data, skb->len);
>> +	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
>> +						    NULL);
>> +	spin_unlock_irqrestore(&mpnd->lock, flags);
>> +
>> +	dev_consume_skb_any(skb);
>> +	return NETDEV_TX_OK;
>> +}

Is the skb_cow_head function called in place of the push, or does it 
make it safe to do the push? Is there a case where we would need an 
additional early return from the function for an error condition? What 
would cause the skb to be a clone?





