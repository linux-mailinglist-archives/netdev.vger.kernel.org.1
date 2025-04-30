Return-Path: <netdev+bounces-187117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC816AA5022
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3234A4E0533
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959B204F9C;
	Wed, 30 Apr 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="P7WWZnWI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22257248F59
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026613; cv=fail; b=WQ36avOkvvpkRQmoyqlA/lj6PCqBTUdaG6+sr3Ruu+p/YfccITGqZfdTn8Linym4HF6bW17nPh566D9h3FDc1+sxEOv3ys6KdbVXUHwvw5ZODqiDyUhfN68xoVL5+jFVsyu6M4++3KUeHSjgce9s41n85zkzO/dhvAWB5/joE4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026613; c=relaxed/simple;
	bh=Fne9tce/MPlfi2wbzcow3ONxLupmHDy1+YDz2hH/GBc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLmRW/GStzekaOotgJePKoEII2mXbxKnRqeMg6RU4IL5Q2dDSIOGpLOL+V0tdtVkixTRyXa70fLOGJoPOGReFGgmGIDKXbj82vyK+7vIC1sjzrWy/qWsv4MD7arAYMd6fpH01cirAOIb0tMaRfe7B2UGZWXmSeV55wVFCrtLK0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=P7WWZnWI; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1746026610; x=1777562610;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fne9tce/MPlfi2wbzcow3ONxLupmHDy1+YDz2hH/GBc=;
  b=P7WWZnWIa6wQU0ef/HlSAfiDVhR9o4AHcn3Cr0S7BSHno7IRdaetkD9o
   0oMM8p8AMAmoM5spfTrz8X9PPT8g2Bajyomgu31+lbrvq4nBmlleYpVXB
   MEag9x/q9aIKRzaHOWbwk8NgL2hxTtzDXh67qo/rQoinDQWvXPJJ7KZB5
   E=;
X-CSE-ConnectionGUID: dYdh1gt1SKaxm8GnOvcdvg==
X-CSE-MsgGUID: 6rlIEVgxQqmSdyM6kFjk7Q==
X-Talos-CUID: 9a23:KSxFZ24tDrW1iU6Wudss+H8YGpkqbiTm737AJh+XD0F3Q7GLRgrF
X-Talos-MUID: 9a23:H/Kn2ApAo5Kl0vCgdLYez294MOZF3au+MVkIqpkXnpeHGy5zZA7I2Q==
Received: from mail-canadacentralazlp17012026.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.26])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 11:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBw/B0CMHBgWqwlUKtd4kr0TgNN4daw+grCvSOH+nscfmtds7plnfwySd/BkXi2+TlOThLsAQwkrqBvDBXjOFbX7Qud2Z48JV5oIKaihNTeZTAZH2Et1a4q4TP3wdM33VjuRDPc7460wsUhozNb/q4PJVV4Hno99kKLe0LaysmoCB9sL6gvM27RHj1INuInEvRK3OZQCz2vNv7OHlObdf9YvxqaZYRQ3ygaGhVEeufhDVnfHzm8d8xRU1baDxcaGCfl1RYIFaihTpR/R9szwPsJE1vIXFAtkAju//CeAUi0dnCCOc00mHUQswSoVspR0Co5dp7lGEGvqXMiP53EYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oji0lHO7FR2GvhaW7/R8Vx4/83HVpct3zMJ5kNHKxVg=;
 b=oCeIVNlVA4YCD3LXYswzkUkY+h29WSf++v4l/DUgQX1QuSMl9QyxockvFTD/AG5O+AgFpUfw3hY3rYlxXRBEYPhIZX7rhB3IWrhtmHNIlFz4JkqNs4tovh9ovdQ63qQi+bBNGRUF0YgRT5IwHZCUxkiLLWFDcZi2HQJ/5hdtktBfiapxtW62APJPBo1b0XzLDzES3rd32QprBLckQU1iN1x2IQ4MTH2zIYzqJ9hwVfOGbTJ0WzXg8jART+JpEdcLQadU7hu1H7roNWmna/Gve52sEGxlTwwS7OhG25TX9WJbTvC7c/HIuLX6ftcQ291sc+DVy+nevff8/vJr9zEExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB5325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:50::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 15:23:21 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 15:23:21 +0000
Message-ID: <db35fe8a-05c3-4227-9b2b-eeca8b7cb75a@uwaterloo.ca>
Date: Wed, 30 Apr 2025 11:23:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
From: Martin Karsten <mkarsten@uwaterloo.ca>
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com
Cc: netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
Content-Language: en-CA, de-DE
In-Reply-To: <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0478.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::9) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcf6b81-9855-4f14-56d7-08dd87faf0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ry9zMWNvbnNRUFYxb0l5S085LzdaODBqaGZtYXc2eGpZb1VOeDZ5UnJVa0tz?=
 =?utf-8?B?Q3BZbldUclUwOWMwMk9hampPUjdCZlJVbkRoVUg4VTltM1JpVnB1ZFRqaGhT?=
 =?utf-8?B?d1pJUXdrVUxCZ2hGYTErVXZwYytIcjFwdHlMdkdXTHRxS2RKWVZTZmp6aExi?=
 =?utf-8?B?TnZoYkNRcGZKbDVtajlaS25IUG02SWJiZjJTK01SWnlMYndNZ1ZsdHNCRURP?=
 =?utf-8?B?c20zWTJMd3FqdmVzb1FlUUNSOGxhMjg5VmZ6SDJjT2FLNDJzcEtPUDE2RTF1?=
 =?utf-8?B?NVE3UU15T29ueXhpWmU3aHhYaDc1SmM0Y3doRUZCdE5KV1FYMjYwQ05pM3dW?=
 =?utf-8?B?VW9rV3hhbU1TZFhKVWJuNVR2MVJ0dEVuQ24yVjkzMGhzVEN0QkRaSjI5VjJw?=
 =?utf-8?B?d2tZaStta1R2TzdiWkprVGx1QjdVRUZ4RWNIdjhzR0NWT25lOHVvK0FHclhG?=
 =?utf-8?B?RlhDTzBMZnUyZm04WjFjeVBpYkVVRWdDelZkQkFDZUJ4OGxLbmEvTWprZUdW?=
 =?utf-8?B?d21nWjB3bk01eFRvT21uUWgxc29jNXVCSjAveGxlMTBzMDEwK2wrNlM4Nmky?=
 =?utf-8?B?Umd6OWZVd2t1TnJQVEdUUVBqcnRTYjl2YXZuUy9vcGlUVnJkb1pGa0V5cVB0?=
 =?utf-8?B?clgwWlJuOEtueDV4NmFrajBVZ0JQbXZTUE9uV09FZmVxV3Jsc2NaWUJOZFNV?=
 =?utf-8?B?RVRGWVl6NzFWck1SZDVLMW1ESGVteVFUYmRad0lsbjRQSmRBVUVtOS9MdzRw?=
 =?utf-8?B?Mk1SdXd3M2xQUXpJNmZVdk5MRnRqeGwvdDU2dkVGbmFFczE5Sm1FVWw3VHNR?=
 =?utf-8?B?dGJpK2lLSmRocWJTL1lxUkIvS21ORFlMaVRkekYzTTNia3hHYnBLK0RLWk9q?=
 =?utf-8?B?cUV2Qlk3aEloMHBkVDRWWTliMVJWODJaNnZqUCtYdklmVXdyNkYxa0U2dEZY?=
 =?utf-8?B?dWozbWVXNFgzNWRiUWVUSVl5NWpLVEFxOVdwT2lCWXNRMW82ZUFLZzg5azRz?=
 =?utf-8?B?dTVBaTdjcStNYmlCVmJocklsRzc3OEJ0NmJFMkVHYjk3V3RtM0gzcjU2SW11?=
 =?utf-8?B?M1RpdjY5RlJTd3owdjhhMnJEYmh6R0ptaExXeXNzN1QzN3RKRHA3UUlwaXFR?=
 =?utf-8?B?eWM3anhzZHEranJkRSt5NmVHRzAxMWVCaGhGVmZNTXRjcjg0bDl1d2FCcVlz?=
 =?utf-8?B?T3lJQzc0dHZVVmJ4KzlGTFI0QWVWVlZYNGdTdksrRzVudVNqVnUwQ0FmOHZJ?=
 =?utf-8?B?Q0cybDIwZm1sOXJscTg2V0FBRHJQSHF0aVEyRk56ZHRNSk9WV25teTlIdFoz?=
 =?utf-8?B?Z0Yvc1BtL3NUUDR0eTRoY2NTektQSG9GSWtNOGhBZ3ZINTVTN09IVGJLZ1pO?=
 =?utf-8?B?c3k2ZGRWMWxkRFhOZGNqOHdsZVhsNUVqSE1lUUZiMklLRUxxSitnQ25SUGor?=
 =?utf-8?B?UEY4Rys5dTFtYXE1Uk5MM3RCK1RTSW1ONncrVUIvcXdkczZkQUNiQjJrS3Y4?=
 =?utf-8?B?cHZnUTFZamloVjQzU1Z4KzNzeEVSVHdDc0F1YkJEWGd2YUx4ZXVhVDd0SEcr?=
 =?utf-8?B?T0creUxsakFZSEhvbVRiWkVVSnlUQkFHOW9oSldlSXhEN041SUIydzN1M0tv?=
 =?utf-8?B?V0c1cVJoMmxGKzBBZjhvUStMZXgrYmpBN0REYThiRHhHYUtZbHdkZjVwdFRV?=
 =?utf-8?B?eXZwUzV3TEx1YkZIQ1RrdVhNdHBPdHVtdGh0Vk1Qck8xNHlCbGNTY1NUZjBm?=
 =?utf-8?B?RkY1aVZBYWxEMFhXMGQyNDl1MTVkVDZZczRLNVNKT1gxM3hLZTczNjJOQ3Fa?=
 =?utf-8?B?NzZrUk9BQ3VLcDBzZnZKR1Q0dGM5WjkxWllkakF3c2pwU2haQ29tK0ViQjVt?=
 =?utf-8?B?WUhHaFljS3RnaEJrV3I3RFQ2Ymd2NUpia09SaEd6UHRGWGN2NlBiZzJYY1Ni?=
 =?utf-8?Q?XWjIG365Y3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS91N0ZhT2Q5b2lOVWRyemo0Y1YyeFFXY0FWdDZJaDUwM3NVZmJja0VreWE2?=
 =?utf-8?B?bGMvdGMrN2VQSk9rcVNJbmc0RDZJdVRyYnkxQnlWcHN2OTNWZDVFYmF4cTBl?=
 =?utf-8?B?RlFNU21VRlJ2cHNCbHdCNVZnT2l3dHhrd1NSYThtRkxhV1JHY2JDZjBXbGs5?=
 =?utf-8?B?U2FDYy9uanFYSGdjckhDVHpyTmxWYXdIand5M3FpcVh4OXFGNExJSlpnUmd3?=
 =?utf-8?B?SzVBVTJraDhyUlVBbmpwdkRYcUxtUllkaEpSaHdhTHZiKzl0Nzg0elRlTGU4?=
 =?utf-8?B?akE1MHNNdnVLbmNZQWlNRVdNek01VDgrcGRtSDFaTUxoNFo5aWV3QlBZeGRl?=
 =?utf-8?B?WFZKZ0J2TnhZM3VpVXN4QldFN0x0SU5Ka2NrRXF4TzZrVzR2Y21UVHJzQ1Fq?=
 =?utf-8?B?aC9nVjE4dHVWNTc1ZDY5bGk0ZllnT253UHBJL2RqQjlJQXFJbUNNcVVJOFRC?=
 =?utf-8?B?MFJQUDdIT1JUZ0g3T3hrLzlXUDVsWlI2TmZrSmRERlk2YXdsdUVOQ3ZaaDNm?=
 =?utf-8?B?TW43U0tYTk4yZmVIazMwWTZYQ0pOYTdSZmx2QmVQWlpDa2FyTEdXK3pIQ0Y2?=
 =?utf-8?B?cDBJV0xtVlI2Q01oZUJaWEo2NkdYdHAyRm11d1I2NFMzN3lPSktuUXpiK004?=
 =?utf-8?B?bURwV1VVRS9nbWY5aXpjL2VBVGp0Zk82dHpqT0xidUx5L3FkemtqamNEcTBs?=
 =?utf-8?B?WGYwN3hmR3dIMlpIMmJHeDRkNE9HM0xoVjBJQ3ZZRjlKd25xejhDZjF5N3FV?=
 =?utf-8?B?U0VsL0hQU0tIaEVjYmFhMm1KWmpTQWpDTitCVzM2dEdTT2hIazJUQzExS3JT?=
 =?utf-8?B?RVR4bTk2cVFiTU1NWUxmUjF3a0p1Y3V6OStQbUhXSHJiUlQxWUJHeHBaSjZp?=
 =?utf-8?B?dWdtbmFCclVCTGVCcGQxSVc5eU5OSWgxSzNzS3pCRnk0b2dMS2lDajJxaXVO?=
 =?utf-8?B?ZDFwWHROVUg0a3FnVVBZZzc3eXFyWjNJOGh0UTdlVHhub0Y5amV0dXRscDVw?=
 =?utf-8?B?VEgwZmp2VENRTjVBMi9lbWpTOFFYU2hXYWphcU5wcFNPUUdhMUkrQVpwVytR?=
 =?utf-8?B?Rll5aHFvYlduNE1ianprNHJTUm1sTjRjazYxdGVpUnVETUZ3dlVNNXZWRGt6?=
 =?utf-8?B?Q3llMDFhM3pwczJMODh4aStPOUZ3alozZDBvRXRHTzVRelNKdkRTcVRab2hV?=
 =?utf-8?B?eVFlQVp5MXZXdkRLRHB4VnB6QmF5ZXlVa29ZSm5EaFhwSmJMai8ra0FRQ2RC?=
 =?utf-8?B?bFpxNmt4KzJqZ28vbkFISDdZKzBqcmpaMkNIV2t5cmlvenFaOXdJaDhOZjFy?=
 =?utf-8?B?RXFtR29INkt1T1BVOGhLWklsREtGZXpNR3c3bldEWHdSYThmRysxK1hGY25B?=
 =?utf-8?B?Q1lFRXF1OW5QbTZ1ZzFvdW9sekxtdlNvUitNbXM3NXJqNmtldUF2ZFFaQ01j?=
 =?utf-8?B?ZVdpOFgraitrTStKVUZjMDRKYjlQcnNmZm5LTkorbEg2cGRORnlzWkFibEYv?=
 =?utf-8?B?WGpjcS9xQlE0N1dZTmVOUUpEMksvMTB0aU9lV3Q1L2k3SjhFUENwcHFJd01H?=
 =?utf-8?B?UUdxdmdlaXlsQWFOeWVMV0RUMlFqdzZZSXIyM3I3Vng0S2ZlOUFMNnE4VFAv?=
 =?utf-8?B?ZkdTNXJPVEpKcjdKYTJmRVhyZWE1dFlXakxjWlVqaUFwK3NxdHJOb3o4YTRn?=
 =?utf-8?B?RDNRaldYS2RrVnZkZDBINlRDT1I3OWZIS1pxdS9FOFBGZnQxZlI2ejRkaEhj?=
 =?utf-8?B?SFlVSklzcUU4dElsMDZabFRvcnRCSENPc1Z1aGhRNHNXdk9LNjFJYTdPTEhJ?=
 =?utf-8?B?ZStCenZpcjZVTVh2THBobG1FTzg2ekJlWHV0MU81U1FuTGc4N2EvbU8rRUJh?=
 =?utf-8?B?K3dHSE8vN3gxTmRpOGhTM0tYRktRNFNUK0RMamg0emVrMFNsVE9CTm8zakJW?=
 =?utf-8?B?OVlITG9oeVRubTlJTGYyRDVvakZCVmgreE1HdmZ0MTVWd3ZCWndEb2R5REta?=
 =?utf-8?B?dU9neXdtZDc4Y1I1VVdJUlBJUmJGd3hSTGFLNW5yaDJKOHhmUSs2UHc2ai8w?=
 =?utf-8?B?emFIT0djeURkbDF6enRDdEtMclk1SG5qVDZrajZvalhUODBORDFGOGpBUVFO?=
 =?utf-8?Q?XdfcU1WFh/jaACQDTJML2tbjO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5L2ckPMXx2yM/W0oBaS128CfOYQ2t/hFXR3cw6nrd5LhqPz1mw2owH1H+fa96O7xHqeMEGWFZw60Ls7mUfwrqYGDyJWFw3yZGbrpD/MrEkSAZH8IKuKNtd1MuzInrb6dLoJEEKNbNAIYVnTKI8MPrHuQteqD4YuBZT67dA656+J6HpjhI8JTnf2+iT1touAskCZtm1/Vp0sZq5BGeOxSCqoBO+Vx27q+/t35EzR57t4uaqCaTIhF1M+/14ZwIC74xG6RcymVmUBfgMBk/UoSne9+B1LyEyopUbS4VnAcAqw3HJp9MbXXisLNykSwcwjPBfYZ+tWkvYDEjsbHHrCa5dapi8OwuRkAqV6PL6RE8LMikP2F9nuW668rI9bx6urM8drQ7GxETyoR3BY9k5HBJiC176dc3Xs3GcAehp/Iu4zTrE1o8DYIIT/Qq/WsrAZzDTYrzqx4nHfKq0IKLU8M/iR29byYFQHLoyvXtZIZxmRC8Mwslq2tLZJRjFJXQSFL4ZvC5CrE5yIDkzYxYgcqoDOC/t+w3L/X5SZ2PJ1f/r7fcz7keIwvOjUg2JwMnr+lozEjGdq6cmZ7NHT98Fi8apN8r3E8mcqsyxFodHP5bfFJQ6UQzVos5Le0QlBf09pM
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf6b81-9855-4f14-56d7-08dd87faf0e5
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:23:21.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+hr7myfSzF9QVSEejkw51cmokxhxH6l/IN3uXZ3bGgDMXZG4PIabpBmhkY4/Xb1F85Y1kr0PY5YjdJ3gnZdZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5325

On 2025-04-28 09:50, Martin Karsten wrote:
> On 2025-04-24 16:02, Samiullah Khawaja wrote:

[snip]

>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | NAPI 
>> threaded |
>> |---|---|---|---|---|
>> | 12 Kpkt/s + 0us delay | | | | |
>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>> | 32 Kpkt/s + 30us delay | | | | |
>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>> | 125 Kpkt/s + 6us delay | | | | |
>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>> | 12 Kpkt/s + 78us delay | | | | |
>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>> | 25 Kpkt/s + 38us delay | | | | |
>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>
>>   ## Observations
>>
>> - Here without application processing all the approaches give the same
>>    latency within 1usecs range and NAPI threaded gives minimum latency.
>> - With application processing the latency increases by 3-4usecs when
>>    doing inline polling.
>> - Using a dedicated core to drive napi polling keeps the latency same
>>    even with application processing. This is observed both in userspace
>>    and threaded napi (in kernel).
>> - Using napi threaded polling in kernel gives lower latency by
>>    1-1.5usecs as compared to userspace driven polling in separate core.
>> - With application processing userspace will get the packet from recv
>>    ring and spend some time doing application processing and then do napi
>>    polling. While application processing is happening a dedicated core
>>    doing napi polling can pull the packet of the NAPI RX queue and
>>    populate the AF_XDP recv ring. This means that when the application
>>    thread is done with application processing it has new packets ready to
>>    recv and process in recv ring.
>> - Napi threaded busy polling in the kernel with a dedicated core gives
>>    the consistent P5-P99 latency.
> I've experimented with this some more. I can confirm latency savings of 
> about 1 usec arising from busy-looping a NAPI thread on a dedicated core 
> when compared to in-thread busy-polling. A few more comments:
> 
> 1) I note that the experiment results above show that 'interrupts' is 
> almost as fast as 'NAPI threaded' in the base case. I cannot confirm 
> these results, because I currently only have (very) old hardware 
> available for testing. However, these results worry me in terms of 
> necessity of the threaded busy-polling mechanism - also see Item 4) below.

I want to add one more thought, just to spell this out explicitly: 
Assuming the latency benefits result from better cache utilization of 
two shorter processing loops (NAPI and application) using a dedicated 
core each, it would make sense to see softirq processing on the NAPI 
core being almost as fast. While there might be small penalty for the 
initial hardware interrupt, the following softirq processing does not 
differ much from what a NAPI spin-loop does? The experiments seem to 
corroborate this, because latency results for 'interrupts' and 'NAPI 
threaded' are extremely close.

In this case, it would be essential that interrupt handling happens on a 
dedicated empty core, so it can react to hardware interrupts right away 
and its local cache isn't dirtied by other code than softirq processing. 
While this also means dedicating a entire core to NAPI processing, at 
least the core wouldn't have to spin all the time, hopefully reducing 
power consumption and heat generation.

Thanks,
Martin
> 2) The experiments reported here are symmetric in that they use the same 
> polling variant at both the client and the server. When mixing things up 
> by combining different polling variants, it becomes clear that the 
> latency savings are split between both ends. The total savings of 1 usec 
> are thus a combination of 0.5 usec are either end. So the ultimate 
> trade-off is 0.5 usec latency gain for burning 1 core.
> 
> 3) I believe the savings arise from running two tight loops (separate 
> NAPI and application) instead of one longer loop. The shorter loops 
> likely result in better cache utilization on their respective dedicated 
> cores (and L1 caches). However I am not sure right how to explicitly 
> confirm this.
> 
> 4) I still believe that the additional experiments with setting both 
> delay and period are meaningless. They create corner cases where rate * 
> delay is about 1. Nobody would run a latency-critical system at 100% 
> load. I also note that the experiment program xsk_rr fails when trying 
> to increase the load beyond saturation (client fails with 'xsk_rr: 
> oustanding array full').
> 
> 5) I worry that a mechanism like this might be misinterpreted as some 
> kind of magic wand for improving performance and might end up being used 
> in practice and cause substantial overhead without much gain. If 
> accepted, I would hope that this will be documented very clearly and 
> have appropriate warnings attached. Given that the patch cover letter is 
> often used as a basis for documentation, I believe this should be 
> spelled out in the cover letter.
> 
> With the above in mind, someone else will need to judge whether (at 
> most) 0.5 usec for burning a core is a worthy enough trade-off to 
> justify inclusion of this mechanism. Maybe someone else can take a 
> closer look at the 'interrupts' variant on modern hardware.
> 
> Thanks,
> Martin


