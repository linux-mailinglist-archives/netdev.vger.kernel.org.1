Return-Path: <netdev+bounces-218097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC5B3B185
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C17617C589
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D619B184524;
	Fri, 29 Aug 2025 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="vtr0en1U"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982F179A3
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756437346; cv=fail; b=FsW+eIVYJnn/2jeLsJ7Zli/zgSypQNt3/qlS39scxDkR4MlQvvh42t0nVutK8gOG8MmObiVz3TurIUfgfG1ECwOv2X1wzTkOsOOae5wU87yCcCdnB4HzpJ0KrugAaix6NdM4zPID3mPI4J2wxhHdzoS1T9Jh3Jk9Lj3Mtj+i28c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756437346; c=relaxed/simple;
	bh=Bfnd18pXxXMelYH8/MlAEdKwyLTT+6ehTMlCP/bV5VU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lt/cSloXThFXzalczrk4r+B+wOj8t9p90Pan9VqbVSJjRJ2YehF3fa63w5kxIJjDVB/aeE47SJf2FvfIhSlW6ZF+4pZiJRwXkA+usUetp3oDKgciXYzyyv680J7p0/yrsofEjCvge3nguiAV+c7U+Wo7ZtbDHVKRx6ZXLQ6oPv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=vtr0en1U; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756437344; x=1787973344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bfnd18pXxXMelYH8/MlAEdKwyLTT+6ehTMlCP/bV5VU=;
  b=vtr0en1UHE9xPqBPAsksQY5K7rzeJhIIODlWV6ibVdMY0Bgp5RbIG4sn
   njRVkhmBWXNtI+MXoaL2TjKkupI8KRLVXIB2kuhwGY9YbMR7g0xaZ8e/g
   IHW6jMIl9Us6PE+QnNJXfl76Ob7LRVtkZEEImmxDNBGVpYpaXEIdF+Odm
   s=;
X-CSE-ConnectionGUID: SATb17nDS7WvuYMaNdOVbw==
X-CSE-MsgGUID: VKlpI/c4TX24jMM5nptZcg==
X-Talos-CUID: 9a23:9NPj9W370iZkh97EA51ofLxfIekZeCSCylvrfHCmFFdMQZuZbmGa5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AjDZUVAzOmwMvn/gIBfctWLgmVkiaqJqNDFgs1p5?=
 =?us-ascii?q?ah/neaS5VHmqblCiFSYByfw=3D=3D?=
Received: from mail-yqbcan01on2109.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.109])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:15:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upyMq3bVwR8Zf38zQ11UzNeIuskleEWRowjo3VG8Kb9I53k/DKW0Kh7HDX7UVqT4llCuy3sGMLJeGLH3U3dLmbwJFo5nNCZIl4nyh5UsicFmRQpY+FteiihLUQdse8LCMLm+/zq56FXtpwfnL2DJ45B6Kx1tdoYeVKaLM/RdeFi2UIUNIAbv2fIR1rDk3T+d/pf5JaXaJPRGfGXi7Xpn4QixuqJuhpeVMC0nNQRgv3KaZ2d4S5txMeYJ58qL97vLCS75QjYwYXrNhCZ1Ys/ezltJqrG7GTD2pGih2pLZP1pr6g2rsjuflWirmFUxXygGV66s2NiA5PLAF84UkCXUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYCq4KhZ+1UXgm9gJJip2FAIdwl/qutUtBOM4130nG8=;
 b=SUnY5OD7M0aG3d9DDL480F/WPsR9k5ET09XJBssOb3dkqyE/vWoJe4mv8iUG26BmfjNtJt5RYC27l+0gybfqqNskHdiExdlHYf+ltEmXfFsYID+nd+oYR1i/z+ejUvwT24Insggsjwwy98XLdVD6HFO1nPfA5bUewzZTgdAZvm7irxhG+4zdEb10xJo6usoToyvWH0pVukpA1zQQAhUs4zpZUKksbzRjr0GIRFG1bij6sBJQaRR9SN0vUZDvSdvtU1iqDKKtruBDowrTgSmeq7JRisrFEmUoYtUqJ8sDNYo9ZBA6zPtYqM092Cz3OiEse0qhG3XSib99GMyz5bde7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT1PR01MB8233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 03:15:33 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 03:15:33 +0000
Message-ID: <b459bb29-717f-42f2-9f6a-56b1ca562d46@uwaterloo.ca>
Date: Thu, 28 Aug 2025 23:15:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2] Add `xsk_rr` an AF_XDP benchmark to
 measure latency
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250828222501.288951-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250828222501.288951-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:408:eb::19) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT1PR01MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0a0ba4-2197-4b64-4c6e-08dde6aa50cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDBVTWk1cVQrY3Bhb2QyTDhBWEJHVkVnQ29UcHpMV0JZRTl6ZmdQeUIzYmpn?=
 =?utf-8?B?QUZySldjSDh1em9NNnVITm5FUEcxV3c3WkhQaXhHaExqNExhc1doMDFhV2k4?=
 =?utf-8?B?T2hBR2QramNLZHF2dG0rSEpGdWN4NXhvdXJ3dVg3SkxHTXRMZU1jRis2LzF1?=
 =?utf-8?B?V2FuRHYxOXBiVWRZTXdOV05CRllCTW5DZkZuVmUwTkJQV1BkeEk3QmtDTGU0?=
 =?utf-8?B?ektidTJ1V1VqRk1XeWlsa3hnYkdIb2Z0ZlN1ZEkveE9DS1RtN3VNb2ZIRmta?=
 =?utf-8?B?U0pTbUZWaXBxdWJXVUhxR05OOFVjZm02Z1EzRjRmTmlPRkdoZjBoanN6cDg4?=
 =?utf-8?B?ZGdxQVYzL1R5MHVVQTIxMm9sS2h0SlAwRU9LY0JXTUhCaXFLSjZlc1hMYitT?=
 =?utf-8?B?RGVLSVRWbmJzV2FjMStSeDdKcWFYTzBDRU9oVkczZ1phV0dILzI4eHNvOEFv?=
 =?utf-8?B?MHR4ZHJVU3A3MXFQRFhrRzZUeklsVUlFMGo3UXRvSmErcnVLeWR2YUlhUEx0?=
 =?utf-8?B?ajlKeldwVEdNNjZjdTg3WU9RMXhrZVVOQ1V3UmtBVkxORVRLVGhxdDFiTGtx?=
 =?utf-8?B?OXJSQlpCNHpOK2FKWlM0OVloSmw5M1ltZklmekhRRnVGaVZaNDIvYS9vQUlR?=
 =?utf-8?B?WFpFZGVLcEtTZGtZR2dCcjg1VUUzdXJ0V1lGZXRvZFYzdDIxdHkxNmNuY3hU?=
 =?utf-8?B?bjRDVDBRdFk3cWZHSm1hckUyeEtpRlJ0OFd6TkpYdVN0dDBSbnFHckVxcGFq?=
 =?utf-8?B?SnNwbEsvYWRYS0duQnNKRHZUQkZuaU9TUlorOFFwQlEvdE5lbjRoeW1ONU1S?=
 =?utf-8?B?YzI5NmxkenE1QUVBVXJROWhzWEoxdlMrUzc0K0E2N1o1OG5kTnlxRDhLdXBF?=
 =?utf-8?B?Y1VKNkJabVQyYThHMTBva05CRVRyV0s4Q0t6N2gvdGlqUXlhZTZRMWd2S0N2?=
 =?utf-8?B?b0dITnowdTFDMXNSa1Q3RjlSRUdWZm5pSzNrelBhRSt5RVd6a2poZ0s1OXlQ?=
 =?utf-8?B?WWVlK3Y0N0xUNmw0S0ZNRytrWGRjV1FWQW9zSk4wNlU2ZHd0RnUvNWRFMnRE?=
 =?utf-8?B?dmUwQ3ZFbUYwMzZ5eDJib1ZGQ3RUZjFWYkhISEl5Y1RQTm1HOWRmMGl3dkxT?=
 =?utf-8?B?YnhkSTBlWnJUblhqS2l4cnZiZmJTWVczKy9Bam40c1pEMTNZdlhzY2cyS25j?=
 =?utf-8?B?d1FyeXdTOW82cHNRS3VJSm5LbHZucVNabmt6ektqMFkrNHZ1VEs1NnJMTU16?=
 =?utf-8?B?cDZTbmlCaFZmZTZ6QUlVNHVYTWVNazd5RngxQkNCYmFGMTZMK2phMkVuUWFq?=
 =?utf-8?B?eE9MaVdUQnZ1dEx0WVZiLzJMbldqQ2gwWlBISFBybHFWMFh5SEVDSGtDa0RD?=
 =?utf-8?B?c3J2NENzMVkwMDdRZ3I3cHdFTE1wdVd2R2xQRWxiSlFBb1hYSmVOMEQ1MXhn?=
 =?utf-8?B?ekZTY2oya0VYdi9mSlZCUkYyN09aZ09ZNDZSZnhCeHpxSmpRRXBpQVo4Y3Iz?=
 =?utf-8?B?SFI3bEVWdTd4bDFmK0kzQUdGVzFZWWZVUmZ1Z21GNmpMRFlFM0FWdVNwZEM0?=
 =?utf-8?B?KzMwcnVoOFQvOTkraGFrd1hrWmpFc1pmcElRUlBUblZZYUkyY0I3YzlaWnFl?=
 =?utf-8?B?YnQ2dm1OMWVLT1k1bzBMd0s4YUNZalQ2anpoQnZKazlEQVFKaXEwdjRpWE1s?=
 =?utf-8?B?czBwdE1Va0g2eUdxK2RFUXA5S0oya0NDYjd1N1dveDdacGhRWk1vbkN0aU5Q?=
 =?utf-8?B?UlFjVkRMV2I1aGtaSmdGNUt2akM3Z05YUEF5VGg5QkRSSUVuZkpkZk5sY3cz?=
 =?utf-8?B?b2ZycDJlYjRuTEZxS3ZkYWlLcGUwTk9jRDl0YlRUN2dtY3dCN3dpNjc2Q2ZS?=
 =?utf-8?B?TnFzZitwOXNsQ1JtVmNzRzhqZXdmeEJHK1dYVFZoSjljQ0xEZ3AyQXhyNHdW?=
 =?utf-8?Q?QAAU4mA8qwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhpd2pLNHYrcXRseEVGcVl0bmlybk8zaG1PY2hDeXhWZTNnQTN1aVNzYUJy?=
 =?utf-8?B?NU00a05vWXYvZFd3VW9mYUhhQTBKVlBJdm5UYjdCeWVIc2o5bFF4TVlyUlVI?=
 =?utf-8?B?Mk9UTHJDMnBmVXRjR1dsRVl2UVFLMHhISkNFYUR5MG1rdlZSZU1hWUhVbUpr?=
 =?utf-8?B?TU93Lzk4UGZVUStTdFZJVlc1L1F3SlZYdDlVY2RxamtybE1oUzJnM3JJUkxU?=
 =?utf-8?B?RkhUaVgwNUJKaVZLYTA1R000a1gvY3hrRlhIWkVnSm9JZHJ4RHM1a1JMbDNR?=
 =?utf-8?B?UWFHenBWRThYbGhVOC9UWStTdVk5a2dxTHllZGVQa3NxTWMvSS9ycHpUaE1J?=
 =?utf-8?B?YXdvc1lDcWUrbHc5Y2ZQRFhnN0x6cVNVQklTZ3FTNlFpQndhRVZlSkczS0du?=
 =?utf-8?B?anBOR3d2VWJNbERXWnd4aGQzS3dwRGpQRHRMQk8yN2VrbVc1eEo3NFZEd0l4?=
 =?utf-8?B?QXVKcHZsWi9pSWxDWkJKeE82UC9NRDlzRFBOWC9hVC9QeDY3ZnFxbkVFUTBY?=
 =?utf-8?B?K2lKRnpuS2h5SWkremlNYnNEclJmcUd2a3BsVUxKVkM1UzFLMDVYMW8xU1N3?=
 =?utf-8?B?eXBEam9jcGJtb2ZkZEo4aXd1dCtSY0o2UEpUZW1pRFJjSTBYQWMwNEhrOUdw?=
 =?utf-8?B?YitOeE11S2dvYnE1T045V3NpQkNnbXpwM0ZxU2lmelY3NjNoR2lnU0NkRUJ3?=
 =?utf-8?B?VmlhUktMK0RrcUVtVmkrcUdub2VyV2xsak9KQ0JzREduWEcrSFJ4Tlp5dVRn?=
 =?utf-8?B?Y0pwT3RqZ3VHaXVzVTJwSSsyK2FOV1FzcjRTa05OYjBwUTBWNXdMTkFSQ1Uy?=
 =?utf-8?B?SEo2VzU0VDNvcDh4VlplcjZCYnk5VWJ6cFhSaEk3ak80b05VYjloUy9vZXJu?=
 =?utf-8?B?NkxSdjl5aFZvOTFzRmVHM0gwbjh5TjVBSFIzMTZoMG4rY0NESGxmTktnL3Vo?=
 =?utf-8?B?bUNjVlhaQVVLenV5TkZwWUxTRGdEQkZZRkdSczRraURFY0lEc3dPOEg2QUJm?=
 =?utf-8?B?UjB0S3pqbG10am55TVRMbmN4U3htenNHYmFQU0M2OFViZ3cvS1BQZU83TzNm?=
 =?utf-8?B?Z1V0NytsQS92Tm9DNjFPWFJXWUFsYWYrNTUvMENaZmRlN0hzTkY4NzBmQXFS?=
 =?utf-8?B?QzFqajJKdHErWGFBc0tENmF1eStPTkM1WEZVKzhMajJjWllLYmg2YjdKY0Jz?=
 =?utf-8?B?cU1ndDZaVFBzQmlKd1UwRk84bjA0Q1ozNmVjcjZIZnNFMWZBVkM1SUJ1T1o5?=
 =?utf-8?B?WHFzTlZGQWpKM3V2NFBUZEZNREcrV2dvbkpWL1hwMklWL0pTelJHaEQ1TU82?=
 =?utf-8?B?U3MxaEFZUEpJWHhXdnBENXM5T0UvSFQxdGtZZmg3NVl0dXBzZUFJMjdYVTBt?=
 =?utf-8?B?MXNkQjh5M2VBU3pxdmo5OGtnUjlma2l4TGxOcGMyTWloaUY0WC85Y050SlJT?=
 =?utf-8?B?bG9RaVVwT3QvcHNjd0ZQcnh3QmRqZWxDbmdFNmFoSUpUaUtIdUhSWTZ3dGlM?=
 =?utf-8?B?MHo1TnNNTlJUWDBobTcyZHJYK3M0cmNXbzhvcDk2TmVodGYvOFNsSU8yWnJQ?=
 =?utf-8?B?dFk3THhDNlRYSm5xcUhscEFZc0VLcHpRQ2VyZ29xL0o0Y1Z3d2ZlSFV2NElk?=
 =?utf-8?B?ZW8xQjlSZzRKRkY4b1NnNENGVVc2dEVIT3IrM2NaTnBjSmVsZ3JxYTd1Q3E4?=
 =?utf-8?B?TXFQSFAyMHp3ZzIrUmFJQjZiOGhUTEM2MXlLMWxha2U5T0tPRVZpdFNpcnAr?=
 =?utf-8?B?b1B2S2hVMWdJOTVIayt1RXcyaHJqSzcwQmttV3cyOCswaTdOZFlkRnhFeGR6?=
 =?utf-8?B?WUR3bjV0bFdaaG1YdGF5L3g2NS9YTXBsR0VwTGo5Q1VPTmhZaGtCakd5bXlV?=
 =?utf-8?B?RHBKdGxoREs1VDBVaTlCSG1LMUxXakRwMWJGNGUzYTN6djVxaUU5Z1JEa0FB?=
 =?utf-8?B?VWF4d1hqK0xPUEp6cWw5RFpzMW9Za0kvTkhJSVJTZlo2cERwNnNTMEFMYUZt?=
 =?utf-8?B?K1lxbDJyUHRhNW5TdWtCR0w1WUVTcTVvWk1oRm1ISVh4aXl0dCtBd1pFRjlk?=
 =?utf-8?B?TzEzdk9DbXJQWHFGUWh1VlVmcGFpVldXNE5yZ2sydE8yajBzYkhWbldiUU5m?=
 =?utf-8?Q?gyJZXRITmSmNmifjAQo4oYgYW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	35Frsp2r99mZRNrTaALR0cCgrPAtnTrwRLbn0saBGHoxaSHgqjj/2M2avVWT1NKWVQULAVALLoOdxnqUt+CSLSG/xZAKczlNb3g0hK4/YRhOc0wrPp9tonQ4gQ6vGlFD3c9MxDI8mYfThsbd2NH0hV+YmxF8c3r2K65p9ZG2tnvHenpz4szeCyoiRSHK8UGJgYpwB6214SbtR1gKO9ko9F4Xr0ChcjywL0v1o/I+8q7C4GKI4dqmDmrGigoKyfyS4cDOeIvLxH+vV2v1iQwSQSJS51YhZ7o+IxEfM+6vPoxVCoR0TTLDFJc5JTvKHjoGcD9IHyrcjjFkw4a0VX4HOO9phWA+2nyl7X2Fhe/iUKqnuesr2RWYkZm5O9n28ferd3N0HED4HKy066qGYDsGs9z0sPZ2vrt6yigRuKJbuonclCvww5Qa3ymw9qHuCsBZ0gyIlEAJIcyFqovmIOZVSoDgr0mxLoyowU9Nq/L2OA6w16lwHKjDtlqjLqxSNewkUVGTRf2s1uHWiic8koMrhySpd29b/4ukNhs87DDKXqal0dNm+prJLqwuvizfpbPWjOMB/dO7UgE+1umNF9Q9R4D1sYXepBftoyfp+IUP4AadkQog9KwayzfpHNLDf9d6
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0a0ba4-2197-4b64-4c6e-08dde6aa50cb
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:15:33.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsh6Np9H5XjZfBJn1uiMbpcEBjW2n3BZANHsgSGwlpeI8ZNGU2O+ZjRWRw2ueL8Xp77//zpQa/yE/CRi0xvl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8233

On 2025-08-28 18:25, Samiullah Khawaja wrote:
> Note: This is a benchmarking tool that is used for experiments in the
> upcoming Napi threaded busypoll series. Not intended to be merged.
> 
> xsk_rr is a benchmarking tool to measure latency using AF_XDP between
> two nodes. The benchmark can be run with different arguments to simulate
> traffic:
> 
> - Payload Size
> - Packet frequency (1/period)
> - Application Processing (delay)
> - Busy poll in separate core
> - Payload verification
> - Open Loop sampling
> 
> Server:
> chrt -f 50 taskset -c 3-5 tools/testing/selftests/bpf/xsk_rr -o 0 \
> 	-B <bytes> -i eth0 -4 -D <IP-dest> -S <IP-src> -M <MAC-dest> \
> 	-m <MAC-src> -p <PORT> -h -v -t
> 
> Client:
> chrt -f 50 taskset -c 3-5 tools/testing/selftests/bpf/xsk_rr -o 0 \
> 	-B <bytes> -i eth0 -4 -S <IP-src> -D <IP-dest> -m <MAC-src> \
> 	-M <MAC-dst> -p <PORT> -P <send-period-usecs> -d <recv-delay-usecs> \
> 	-T -l <sample capture length in seconds> -v -t
> 
> Sample Output:
> 
> min: 13069 max: 881340 avg: 13322 empty: 98
> count: 6249 p5: 13500
> count: 61508 p50: 14000
> count: 114428 p95: 14700
> count: 119153 p99: 14800
> rate: 12499
> outstanding packets: 3
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> ---
> 
> v2:
>   - Rebased
>   - Using needs wakeup
>   - Added PREFER_BUSY_POLL

I cannot find SO_PREFER_BUSY_POLL anywhere in the code?

Thanks,
Martin


