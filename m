Return-Path: <netdev+bounces-247864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58CCFFAC6
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F11F30031BC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D833C1A9;
	Wed,  7 Jan 2026 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PU7eJMWK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF564335070;
	Wed,  7 Jan 2026 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811319; cv=fail; b=kznph+b2HoFnzU0gmYpk0/867lh7hPHsvsm8XjLUQIw6qCRTa6Uym1Y/30FsJr9wgRXyHH15ZcXnkDxBrubchxoEB+elN578Mr4qoaF6KKrjekQ+94aa7UCZLGrNG/Iq6VZKs3fAf4x9PQGVdhh5Tin4856Y9g55DmJNv6TyDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811319; c=relaxed/simple;
	bh=OnPLj8Mu0wXQEy20d7o4r6PvS8CWVC5dUPBYRnLpd3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlAGjSyfDIaJlzEkrrfr1zUxXB/JMTKW7oKlOk50V8MqZ0l8gJPP52KDLQUmQYT2Aw4dgtnNFZhFpe/SCE+wR7pJTqnJ3XIqCO45J+5DAGu6kjmnTmt6kHVby7xoWyvO38L3Ds4SwX4kgKN7Vk8VFRdbCb7G4iLEP8RMIStQRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PU7eJMWK; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607Flw7f1570660;
	Wed, 7 Jan 2026 10:41:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iv1vPaouoRH1FIIoBYTiMhqS3/Hh8n2MvfTdQAiWbeg=; b=PU7eJMWKTb1u
	TcLhmXkrqeRZKxLPkDL6Ji+d7ypW4inQpg6HkfaIUKKwJ6NFiEm+f6GHCWnobQy5
	lp5P7uC9XJ8pAsfJ6yig/NFGobNPyNX695l2ocxq0J7CXzT+BwpVE79QiHNz7r2q
	JPzEhGF9lW1wXPXiQ/Co7Hlw3VnvaMrtyD3IfGOo1k56vmXc/qKNsJ5Y+6kESpJZ
	3T1QocXKOiRi91qRxNQoLG9HbG+d6RNlLgik83ZaHwi+ubt8S3yNIRwOyyRnIPZO
	6CbENccXEXMUEOmnDlAKGdnP8Z3H/tYyazwY9cN4adnommtF3AaM2LQoDjRQ2/Ma
	ePz/WTUX5A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bhtette8w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 10:41:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfVcLT5b9cE8CsSKDyA3ONhbt+do2EXUdPwcrvT0wz0ET0k9jZ0MW2WzktGdF6JXGeLfcisn+XXxbqXXqCA8PiYJs3g2wVMaDdh9LcqC6KApzk/FTtG0WhIBU3g7sGjR5PvccrzftaWabuvp/7BCqTFEYVXbbPkIX0qH4ADQm9Idhyl9JTlmQknEVS8W+B4H+a/UacRlKleCP+IYAq/vD3xv6Ud0k+v8ZAPVpHcz0J95biDrEPoTcb04YtUzayZgnUIZRov744r6cAvl9QaVYOXKP7QdqnO7Vrw7RB8w1z5q03qJWTEPojYDQDx2vR2+HJUcgj8yqR7uY1T19ckc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv1vPaouoRH1FIIoBYTiMhqS3/Hh8n2MvfTdQAiWbeg=;
 b=tJmA3UjZkZFweAaWkq9IwTKa517axLjDEsIDcqeNKb0ut3Cl9Z+X3GcZC4PnmHAmei1DLMT5WIoZFdm0RR4ozIqYuY3kSxW3UWwAvzXHH+lSGvaLROAOjgT7RxXrdXNSGpzPudefVKVaelhgU17ueecj6+603LgKte0XaCoqTLNnoK15mbboUUskdV08so1OclxbLKQXIbtKGq1UOnk11mnS3lt47wMGyPlnEJ5PWqW5FrAYdIcGL6UG1eKZpI9H89JkxxeHKRuMn6KEXHdada0a1m7PKtJ+2HcFopKOEjoi2Zfa3Ni+MomsDkac5eGLqx7O552kfniu/fjt1NlnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH0PR15MB4166.namprd15.prod.outlook.com (2603:10b6:510:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 18:41:31 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 18:41:30 +0000
Message-ID: <5ea6b6ae-5cfc-496b-91e5-4a6dcccf7448@meta.com>
Date: Wed, 7 Jan 2026 10:41:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <1767757749.8991797-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <1767757749.8991797-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH0PR15MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a1338f-0a52-48c1-f4c8-08de4e1c5fc2
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dFB6V1EvMnFWcXhjTm5hQzlyeUdVdXExUjlEYTcxVDE3eXVEVkFPMWNPbWpU?=
 =?utf-8?B?WnBSZmRlRXZ6VDFUcFpVNEVzZWtNR3RaNlo2MHN6cVdpUS93ZkdvMGtnNHdJ?=
 =?utf-8?B?VnUzd0dZV1pIcFdrMGJPMDkzTGVPS1FXSjRkYnUrcUZCdzB3bHlXY2xjNmNJ?=
 =?utf-8?B?Vlp0ME5Kampab0xneUNmK1pCWlgyNTkwSXpPOTNQcTEwdnV4d2VDVW1Hb0xG?=
 =?utf-8?B?dTFYcjREQUEwaC9Ha3hFUFl5OG8vdThIcFYyT0VjNHE3VHNFem56S2Jwd2gz?=
 =?utf-8?B?YUlnc0Z0YXlrb25FOVUxRFl4eGVaRGk3T2czNjArNGtpYjd5NEQzSG43OTBn?=
 =?utf-8?B?dms5dHMwVkg1bjQrQitoWnpjMDNHNGpuRUppTFZTZEhZWEx2eWxrOVFienRS?=
 =?utf-8?B?cFUySW9sZEYvSlRmWE0xYjZ6VzJkZWRVNjZMMTFDajljaWpZcjZnTHZYdjVE?=
 =?utf-8?B?TGZZWGk2SmxFV1VBeUdPclRHTUtEVy9DbS9JYVBLd0RuTXgyWDlFOXZkdW9q?=
 =?utf-8?B?MnRBZ2FBZlhyUDE5cDQrS0tUdUZlSnJIbUd0dEpxNTEraHE4RExHMm9tNXFr?=
 =?utf-8?B?d1RxeS9sZXVhbFpxMWZjTEtpdGJSUk03UFdkVFcza29MclNieGJDLy9iQUg2?=
 =?utf-8?B?Rk1va2dsdStITGdKNnRmSkdlcUN6blhFT1BpZzgzVnFobnV5MG5SeFEzMjF2?=
 =?utf-8?B?OVNZVmovU1RqR3ZNS3VaYkliRUpvNW1uSmVmT0tDa3Q2TTJ0RHllQkVBNnVu?=
 =?utf-8?B?SjZRK280Vlpnd1ZZcGFWcFRJZGFkNGsrZHFuL2kyY0FhOWRkd3phWEwzcVNR?=
 =?utf-8?B?T3BQWW5yeHNXR0Z4UEFCbDM4S0Vsb0ZqbG96VDhESXNQZlhNWDVFM0dxakw4?=
 =?utf-8?B?WEdrYzVad3U4ZHNWdERsdmlkRElkeCtnbEh2ZjFVOXcxYnlsdC9nYzVWenZV?=
 =?utf-8?B?WDhVZVh5UVJuRlpWSzZVVWl2VTgyVVRTdVJJMmkwUXN0Q2ZKNFZZaEloM2l1?=
 =?utf-8?B?cVE0M05scVB0bnBaazNVNVQ3VUIxRkVWVzRBVURmRE9lZlJrT0NYQVlWRkFL?=
 =?utf-8?B?bHBUV04vNDF1OEdoYVMwOU40RnVuakVjUXdsMG11b3IrNzJyZ1h2Znpld0Iw?=
 =?utf-8?B?eW9jc3MySm8wQ0VaaFUrZ2tscWozRTF0dm1kcWttN3VPZjAvdE9wTk10WnRP?=
 =?utf-8?B?bXkrelZXTkZlTlJqVnc1NjVsS3RzYzFycGZBVFRsL1o2NGNvaTRsVHAvd0pY?=
 =?utf-8?B?cWRFVUgyMmZjOGtNNGZEeHdjRm5vZnZaUWlYOFZWRnNqWjhOQVJsTk9pNnJ0?=
 =?utf-8?B?ODd5TlMvcFl3ZFVYSnBBbGMxY0xnUDl1a24wYitxam1vUWdzMjlwWERDaDB6?=
 =?utf-8?B?SUQvcWs3clVvTGFNWFRGdG1VemY0WXl3WnJrU3Y5aE1iUXNob1RKTFNZNXE4?=
 =?utf-8?B?aVMzaHB1cE41cmFIOHdiYXVNVVdSc0pWeWFYcDFjdEhvY3ZBTno3NWtxZEVp?=
 =?utf-8?B?UkVLbWlldlNpajR4TCsrVkxjZFVUTmZRWVNLVmovSlV0SHZYZHd6Z29TdzRK?=
 =?utf-8?B?YjZ4Vmx3MXlTR1RpMW1lQk5MTCtWa2ZwcFFXUnZUdFdsa2lJOUZaNlUweEhh?=
 =?utf-8?B?aG81dCtQaXVsNWM5VHNYRFI3ZnlqMVplWDRKZ2JzUG53bHNndmg5T1gzSnEw?=
 =?utf-8?B?NGJ1VXM3amVWMFdZdHB0OVJ2QmxNaldGOU5HRndlSUlFOU4vOTF1U2JZa1J3?=
 =?utf-8?B?czNKc3NnRFZyZDRSUGxTUno5Ykp5NWd0UTZ3TVdLelFuOVVSYkdtUjZWMXZR?=
 =?utf-8?B?czZvMytkOHhPTVJIOW8vQmVEa1h6aGNUdGNRWmxMeWVYUkNDM0dHS254bkNr?=
 =?utf-8?B?RUdOYVFTeGxMQXkwZ0EzcHZ5OEM0cCtDTUhhNUtyMDFNQWFGWjJ5RHNYRkt1?=
 =?utf-8?Q?I6UJ2TvuOHzvTQe2NDno45z7HjC9ksZH?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VTVHdDY5YTNsK1MzLzBaVzFieTlseFpscDVvSnYya0ppR2lvbjA2a29zWHRi?=
 =?utf-8?B?R01oa0wxUjlXUUlIUndFR09veitNb1pCbXJkd1FRQUNsMU40cStFWkZhM2Qy?=
 =?utf-8?B?R1B1QVdKeXNmUDBtK2I2bjJsTVJ2RzU3NmlGWFZDdlVKbGZ2ZDl4T3JFQnpw?=
 =?utf-8?B?a3Jva1VhV2JjUW1zRUN2bmowWEt3b0dCT3pwUzJtTHFBbVNGQTFkWGg5UWRr?=
 =?utf-8?B?SEYvRy9Jb1ZwNzlYQ2lUKzlEc05BaDc0MUpEbGNjMTUwL1FzTE5wckpNNjRm?=
 =?utf-8?B?TmV2dHNjbFVMOE5WbnNWR1pYcUFDeHFEaktBSjdSMGFUUTdqOW1qZ3QrSy9X?=
 =?utf-8?B?amhmTVQ4dXhpblBLNSt5V1lBclltTzhRLzdBVXd1cjRRZWRKaUk3eksxOWt0?=
 =?utf-8?B?dno5aXpydEtMdDBaeHpYNzBzSDQyRGxCbTNXeXpXQlhaOG5BT0VHNHR4REc5?=
 =?utf-8?B?ZS9tSy83VGtzMFYrYVVLak5MMEk0aTFtazltd24rQkdMdDRLQ1FwN0hOMHo2?=
 =?utf-8?B?VUJta2dhN2FnczBvZ25MZUNvNWtPSVRCYm9ENlRaeHNUQ2hSaFlmZ3BtUGRG?=
 =?utf-8?B?ZHczZFFWUFlYdk4xTnMzTVZ3SE9Vb05YdktGMGdNTmVMTmQ4UE1Ca2c1MitS?=
 =?utf-8?B?L29tbEtwMDhIRk1OeFF5TEdxNk96cDVmV280dTQvK2hBSXNreUVoTStJalBL?=
 =?utf-8?B?Y1FRTUJKaDJ5N1ZLYmJSQmVMb0JZam9HdjE3a24ydGk3cEJHbWhUczJWRWRS?=
 =?utf-8?B?T1ErMXhSbWlPT0ZiYlZhZlZVaVM2dERXcjZSbGxlOE9UYnZwVFJQcHNSaXhM?=
 =?utf-8?B?dW1ZRExYZWlFNkRLcDFpUkxZMUdma05wODlPbVN4Rkl5VzlNcUJ6R3B0eFVF?=
 =?utf-8?B?UU9ZYWhqd2xwVGtHTFhYeUxSMDQvTjVab2w2Z2tTOGozMmdrWml5RUIxOHdl?=
 =?utf-8?B?VlgrSHdGa2ZkWjRraEQwMVlVL3BjemdzczAwODZlMHpIQ3dBZis1RUhYeUZG?=
 =?utf-8?B?VTFWbTA5WTVtVmZOUUdKeHR0dFJNRExrcGlQOFNrTUZGRE01TEhhbnl4a0xj?=
 =?utf-8?B?WWNIQllFazhJdjRCWlRhZUhwUVZIOC9wZURaNENOR0tEZ1R2bGlSeWxwNWZB?=
 =?utf-8?B?amNTbHBpSTBpcUhhNDJBcXh4VVFjMkE0M1orYXphN0k4WTMzVHc2SE9LTVZh?=
 =?utf-8?B?V1pMbUI5QldvbkliUWZQNFF3RHNNVFU4dzJPSEN4ZTYyUGhuN212TE1WY1NG?=
 =?utf-8?B?amRWMTZ1N2ZXVTdicnBSVlFVSGVOa1k4WDlPSUt3L0tDUFNhYTZkTG85U2hv?=
 =?utf-8?B?SDZMaXF3U0VaKzZlUGFoRk9KYWpLWjY0Zm01blcvRFlkVFc1SktYTkpUZnZn?=
 =?utf-8?B?M0pwdWNGZHcvMFozZ0RKREdwMGNVU2s0V3NHVi9LTjZtR2ZwOUt3b0NiVGdD?=
 =?utf-8?B?RGxEZXd6eHVJV0l3cXU5TnFiVW5mSGhkaEFrUmVnQkxmMWNacExxZ2ZITDRO?=
 =?utf-8?B?MEoyODRSTllEYnIwM0VRTHNZMnNwMkdkQThTT1dpKzRKVExmR20rQk0waGFU?=
 =?utf-8?B?QWFYVk5mYm1xbmdWTjNpNUZGMG9Wa2NFV2RrR242azNERW1BYUQvbEZjRmt5?=
 =?utf-8?B?V3FGZ0p1bmU4MWJKVlcvZm4zR1VuSjNhRmRLR2pBUGVHTFEzaDVIL1RSTmti?=
 =?utf-8?B?aXE2bEhmK25yWjVabytlTDJBWXE2YVBYRktZaHREMFdoSVlGUG0wUmJIb0U1?=
 =?utf-8?B?QURodU11Vk5UUDZIczFrQWg4L3VTVUQ3MjBJZEpkU0xMRjVXSVpDazNUbzJm?=
 =?utf-8?B?Vnl2azh4TlcvNUJYODVnajFjTVpnZ2pHMVl3ZnBETnNNbHJQQkRNaldybkYw?=
 =?utf-8?B?ZmQ5bUwyNzdXYzBsRy9pemxqOTB3VjhsUXVuRi82dldPVFVqYnJSSVJuNm9y?=
 =?utf-8?B?RHZ0dllLWjVuNTZ4RkFiZ04zeEpqVFJuNDRXdmFWeWhkWGNwRWVnSFhWRG5U?=
 =?utf-8?B?bnkzVVRpWWR4UXpvcjZkcVgzaE5ydERmQ2dRL0ZCUzJLYlQ5U3B4V0FaeUpi?=
 =?utf-8?B?bDM1U2xqR1pJcTRDTVNCcjZDbDRZdWpnR2doTU02T1I4UWdPRExZbUYyaXVz?=
 =?utf-8?B?akhUVkFSZUYyQmhaVUR1YkpjTHZKSVprdXE4Q0RxaElRM0xURGdocEhSNzdw?=
 =?utf-8?B?clcvQmtIU0xQTU44cHRHOXl6Tm82ME9PUVVIVWhlOWhjdlltRW5Qa0tCOU9C?=
 =?utf-8?B?c0Z4anA4QURVeHFsWStOcFZuVlAzUzc5R0c3K0tJakZERC9NVmVLKzI5YXlK?=
 =?utf-8?B?eEdjNGQ3N2o0cG4waUEwVGpxY0pldml2N0NSOU94emhUbEtMbDIzQm53L1Q1?=
 =?utf-8?Q?+t+IS/hGpZhthH/s=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a1338f-0a52-48c1-f4c8-08de4e1c5fc2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 18:41:30.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMJqt0WGdvyyfPf1yfdk7uZJ8gi91NPUH1sT60z0WKfNnU1tsKm/jWw3xKVNQOxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4166
X-Proofpoint-GUID: 681TILBd7j-jz1vq3DSBgCkZCxHxi9yZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0OCBTYWx0ZWRfX/DVvczwZTMvl
 92fcH4QnTE4ds1ViVCBsQWESC2QBNkKjFDyFiW7eNkUjn3toZHae6onVYA1mQz2Tzq1MKC5hr/2
 /UQIZoODhIkhuwgCJm9C3K7CW+EbyE+Rqh00pbNmxNDIh7zAWPEr3eOUWeG7oywjy6Fba9OOU5a
 +D/QjuW3maHiKYpQL+l1aLkSaznHUStsI/ryke2vaESH/bk8U5cOJWfTkGNbEWP0gxA456BZSng
 0PH1cECMtrS1BD68XStk9n9TTzw+PbyQdMAI3UKKFe6W7GViFRdW3gcbuSI7Ve3Ma613LI3QulN
 7uLg6ssAzoihYmlt//oObvYivy6+1E5qQJhVvYeuBhlYW2rHIa4oU7yoja8jcveh4AaXqo37Q7S
 HMs1iSHWPpDcLQs+oCeCBeMaXCykf2h8wbjY/uImqxmq4fRtsYMTtKQVLBDgCyxOnseFvPPG1W2
 K61tAhdfF2PJK4LI9qg==
X-Authority-Analysis: v=2.4 cv=VLzQXtPX c=1 sm=1 tr=0 ts=695ea8dd cx=c_pps
 a=OANxLEngf0bc/nxW+UjZ1w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=8RIpY4-CrpwgI8uO6R8A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 681TILBd7j-jz1vq3DSBgCkZCxHxi9yZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-07_01,2025-10-01_01



On 1/6/26 7:49 PM, Xuan Zhuo wrote:

> On Tue, 6 Jan 2026 14:19:23 -0800, Vishwanath Seshagiri <vishs@meta.com> wrote:
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes. skb_mark_for_recycle() enables page reuse.
>>
>> Big packets mode is unchanged because it uses page->private for linked
>> list chaining of multiple pages per buffer, which conflicts with
>> page_pool's internal use of page->private.
>>
>> Page pools are created in ndo_open and destroyed in remove (not
>> ndo_close). This follows existing driver behavior where RX buffers
>> remain in the virtqueue across open/close cycles and are only freed
>> on device removal.
>>
>> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
>> sending control virtqueue commands while ndo_close is tearing down
>> device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
>> page_pool_destroy() during close, and concurrent rx_mode_work can
>> cause virtqueue corruption. The check is after rtnl_lock() to
>> synchronize with ndo_close(), which sets the flag under the same lock.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 205 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 22d894101c01..c36663525c17 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,7 @@
>>   #include <net/netdev_rx_queue.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>   module_param(napi_weight, int, 0444);
>> @@ -359,6 +360,8 @@ struct receive_queue {
>>   	/* Page frag for packet buffer allocation. */
>>   	struct page_frag alloc_frag;
>>
>> +	struct page_pool *page_pool;
>> +
>>   	/* RX: fragments + linear part + virtio header */
>>   	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>
>> @@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>   			       struct virtnet_rq_stats *stats);
>>   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>   				 struct sk_buff *skb, u8 flags);
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +					       struct sk_buff *head_skb,
>>   					       struct sk_buff *curr_skb,
>>   					       struct page *page, void *buf,
>>   					       int len, int truesize);
>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void free_unused_bufs(struct virtnet_info *vi);
>>
>>   enum virtnet_xmit_type {
>>   	VIRTNET_XMIT_TYPE_SKB,
>> @@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>   	return p;
>>   }
>>
>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>> +			     bool allow_direct)
>> +{
>> +	if (rq->page_pool)
>> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>> +	else
>> +		put_page(page);
>> +}
>> +
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>   				struct receive_queue *rq, void *buf)
>>   {
>>   	if (vi->mergeable_rx_bufs)
>> -		put_page(virt_to_head_page(buf));
>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   	else if (vi->big_packets)
>>   		give_pages(rq, buf);
>>   	else
>> -		put_page(virt_to_head_page(buf));
>> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   }
>>
>>   static void enable_delayed_refill(struct virtnet_info *vi)
>> @@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		if (unlikely(!skb))
>>   			return NULL;
>>
>> -		page = (struct page *)page->private;
>> -		if (page)
>> -			give_pages(rq, page);
>> +		if (!rq->page_pool) {
>> +			page = (struct page *)page->private;
>> +			if (page)
>> +				give_pages(rq, page);
>> +		}
>>   		goto ok;
>>   	}
>>
>> @@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>>   				frag_size, truesize);
>>   		len -= frag_size;
>> -		page = (struct page *)page->private;
>> +		if (!rq->page_pool)
>> +			page = (struct page *)page->private;
>> +		else
>> +			page = NULL;
>>   		offset = 0;
>>   	}
>>
>> @@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   	hdr = skb_vnet_common_hdr(skb);
>>   	memcpy(hdr, hdr_p, hdr_len);
>>   	if (page_to_free)
>> -		put_page(page_to_free);
>> +		virtnet_put_page(rq, page_to_free, true);
>>
>>   	return skb;
>>   }
>> @@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>> -	void *buf;
>>
>>   	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>
>> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> -	if (buf)
>> -		virtnet_rq_unmap(rq, buf, *len);
>> -
>> -	return buf;
>> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>   }
>>
>>   static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>> @@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>   		return;
>>   	}
>>
>> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -		virtnet_rq_unmap(rq, buf, 0);
>> -
>>   	virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>
>> @@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>
>>   		truesize = len;
>>
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb) {
>>   			put_page(page);
>> @@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>   	return ret;
>>   }
>>
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
>>   {
>>   	struct skb_shared_info *shinfo;
>>   	struct page *xdp_page;
>> @@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>   		shinfo = xdp_get_shared_info_from_buff(xdp);
>>   		for (i = 0; i < shinfo->nr_frags; i++) {
>>   			xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -			put_page(xdp_page);
>> +			virtnet_put_page(rq, xdp_page, true);
>>   		}
>>   	}
>>   }
>> @@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   		off = buf - page_address(p);
>>
>>   		if (check_mergeable_len(dev, ctx, buflen)) {
>> -			put_page(p);
>> +			virtnet_put_page(rq, p, true);
>>   			goto err_buf;
>>   		}
>>
>> @@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>   		 * is sending packet larger than the MTU.
>>   		 */
>>   		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>> -			put_page(p);
>> +			virtnet_put_page(rq, p, true);
>>   			goto err_buf;
>>   		}
>>
>>   		memcpy(page_address(page) + page_off,
>>   		       page_address(p) + off, buflen);
>>   		page_off += buflen;
>> -		put_page(p);
>> +		virtnet_put_page(rq, p, true);
>>   	}
>>
>>   	/* Headroom does not contribute to packet length */
>> @@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   	unsigned int headroom = vi->hdr_len + header_offset;
>>   	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>   	struct page *page = virt_to_head_page(buf);
>> -	struct page *xdp_page;
>> +	struct page *xdp_page = NULL;
>>   	unsigned int buflen;
>>   	struct xdp_buff xdp;
>>   	struct sk_buff *skb;
>> @@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   			goto err_xdp;
>>
>>   		buf = page_address(xdp_page);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		page = xdp_page;
>>   	}
>>
>> @@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>   	if (metasize)
>>   		skb_metadata_set(skb, metasize);
>>
>> +	if (rq->page_pool && !xdp_page)
>> +		skb_mark_for_recycle(skb);
>> +
>>   	return skb;
>>
>>   err_xdp:
>>   	u64_stats_inc(&stats->xdp_drops);
>>   err:
>>   	u64_stats_inc(&stats->drops);
>> -	put_page(page);
>> +	if (xdp_page)
>> +		put_page(page);
>> +	else
>> +		virtnet_put_page(rq, page, true);
>>   xdp_xmit:
>>   	return NULL;
>>   }
>> @@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>   	}
>>
>>   	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>> -	if (likely(skb))
>> +	if (likely(skb)) {
>> +		if (rq->page_pool)
>> +			skb_mark_for_recycle(skb);
>>   		return skb;
>> +	}
>>
>>   err:
>>   	u64_stats_inc(&stats->drops);
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	return NULL;
>>   }
>>
>> @@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>   		}
>>   		u64_stats_add(&stats->bytes, len);
>>   		page = virt_to_head_page(buf);
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   	}
>>   }
>>
>> @@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   		offset = buf - page_address(page);
>>
>>   		if (check_mergeable_len(dev, ctx, len)) {
>> -			put_page(page);
>> +			virtnet_put_page(rq, page, true);
>>   			goto err;
>>   		}
>>
>> @@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>   	return 0;
>>
>>   err:
>> -	put_xdp_frags(xdp);
>> +	put_xdp_frags(xdp, rq);
>>   	return -EINVAL;
>>   }
>>
>> @@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>
>>   	*frame_sz = PAGE_SIZE;
>>
>> -	put_page(*page);
>> +	virtnet_put_page(rq, *page, true);
>>
>>   	*page = xdp_page;
>>
>> @@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   	struct page *page = virt_to_head_page(buf);
>>   	int offset = buf - page_address(page);
>>   	unsigned int xdp_frags_truesz = 0;
>> +	struct page *org_page = page;
>>   	struct sk_buff *head_skb;
>>   	unsigned int frame_sz;
>>   	struct xdp_buff xdp;
>> @@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>   		if (unlikely(!head_skb))
>>   			break;
>> +		if (rq->page_pool && page == org_page)
>> +			skb_mark_for_recycle(head_skb);
>>   		return head_skb;
>>
>>   	case XDP_TX:
>> @@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   		break;
>>   	}
>>
>> -	put_xdp_frags(&xdp);
>> +	put_xdp_frags(&xdp, rq);
>>
>>   err_xdp:
>> -	put_page(page);
>> +	if (page != org_page)
>> +		put_page(page);
>> +	else
>> +		virtnet_put_page(rq, page, true);
>>   	mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>   	u64_stats_inc(&stats->xdp_drops);
>> @@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>   	return NULL;
>>   }
>>
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +					       struct sk_buff *head_skb,
>>   					       struct sk_buff *curr_skb,
>>   					       struct page *page, void *buf,
>>   					       int len, int truesize)
>> @@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>
>>   	offset = buf - page_address(page);
>>   	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -		put_page(page);
>> +		virtnet_put_page(rq, page, true);
>>   		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>   				     len, truesize);
>>   	} else {
>> @@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	}
>>
>>   	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
>> +	if (unlikely(!head_skb))
>> +		goto err_skb;
>> +
>>   	curr_skb = head_skb;
>>
>> -	if (unlikely(!curr_skb))
>> -		goto err_skb;
>> +	if (rq->page_pool)
>> +		skb_mark_for_recycle(head_skb);
>>   	while (--num_buf) {
>>   		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>   		if (unlikely(!buf)) {
>> @@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   			goto err_skb;
>>
>>   		truesize = mergeable_ctx_to_truesize(ctx);
>> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>   						    buf, len, truesize);
>>   		if (!curr_skb)
>>   			goto err_skb;
>> @@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   	return head_skb;
>>
>>   err_skb:
>> -	put_page(page);
>> +	virtnet_put_page(rq, page, true);
>>   	mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>   err_buf:
>> @@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>   			     gfp_t gfp)
>>   {
>> +	unsigned int offset;
>> +	struct page *page;
>>   	char *buf;
>>   	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>   	void *ctx = (void *)(unsigned long)xdp_headroom;
>> @@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>   	len = SKB_DATA_ALIGN(len) +
>>   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>
>> +	if (rq->page_pool) {
> 
> Why we need to check this? The page pool should be created when probing the
> device?

Good catch, since page pools are always created for small/mergeable
modes, I can move the creation to probe and remove this conditional
in v2.

> 
> 
>> +		page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>> +		if (unlikely(!page))
>> +			return -ENOMEM;
>> +
>> +		buf = page_address(page) + offset;
>> +		buf += VIRTNET_RX_PAD + xdp_headroom;
>> +
>> +		sg_init_table(rq->sg, 1);
>> +		sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +
>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> +		if (err < 0)
>> +			page_pool_put_page(rq->page_pool,
>> +					   virt_to_head_page(buf), -1, false);
>> +		return err;
>> +	}
>> +
>>   	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>   		return -ENOMEM;
>>
>> @@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>   	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>   	unsigned int len, hole;
>> +	unsigned int offset;
>> +	struct page *page;
>>   	void *ctx;
>>   	char *buf;
>>   	int err;
>> @@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>   	 */
>>   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>
>> +	if (rq->page_pool) {
>> +		page = page_pool_alloc_frag(rq->page_pool, &offset,
>> +					    len + room, gfp);
>> +		if (unlikely(!page))
>> +			return -ENOMEM;
>> +
>> +		buf = page_address(page) + offset;
>> +		buf += headroom; /* advance address leaving hole at front of pkt */
>> +
>> +		hole = PAGE_SIZE - (offset + len + room);
>> +		if (hole < len + room) {
>> +			/* To avoid internal fragmentation, if there is very likely not
>> +			 * enough space for another buffer, add the remaining space to
>> +			 * the current buffer.
>> +			 * XDP core assumes that frame_size of xdp_buff and the length
>> +			 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>> +			 */
>> +			if (!headroom)
>> +				len += hole;
>> +		}
>> +
>> +		ctx = mergeable_len_to_ctx(len + room, headroom);
>> +
>> +		sg_init_table(rq->sg, 1);
>> +		sg_set_buf(&rq->sg[0], buf, len);
>> +
>> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> +		if (err < 0)
>> +			page_pool_put_page(rq->page_pool,
>> +					   virt_to_head_page(buf), -1, false);
>> +		return err;
>> +	}
>> +
>>   	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>   		return -ENOMEM;
>>
>> @@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>   		return err;
>>
>>   	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>> -					 MEM_TYPE_PAGE_SHARED, NULL);
>> +					 vi->rq[qp_index].page_pool ?
>> +						MEM_TYPE_PAGE_POOL :
>> +						MEM_TYPE_PAGE_SHARED,
>> +					 vi->rq[qp_index].page_pool);
>>   	if (err < 0)
>>   		goto err_xdp_reg_mem_model;
>>
>> @@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>   		vi->duplex = duplex;
>>   }
>>
>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>> +{
>> +	int i, err;
>> +
>> +	for (i = 0; i < vi->curr_queue_pairs; i++) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +		struct page_pool_params pp_params = { 0 };
>> +
>> +		if (rq->page_pool)
>> +			continue;
>> +
>> +		if (rq->xsk_pool)
>> +			continue;
>> +
>> +		if (!vi->mergeable_rx_bufs && vi->big_packets)
>> +			continue;
>> +
>> +		pp_params.order = 0;
>> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>> +		pp_params.dev = vi->vdev->dev.parent;
>> +		pp_params.netdev = vi->dev;
>> +		pp_params.napi = &rq->napi;
>> +		pp_params.flags = 0;
>> +
>> +		rq->page_pool = page_pool_create(&pp_params);
>> +		if (IS_ERR(rq->page_pool)) {
>> +			err = PTR_ERR(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +			goto err_cleanup;
>> +		}
>> +	}
>> +	return 0;
>> +
>> +err_cleanup:
>> +	while (--i >= 0) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +
>> +		if (rq->page_pool) {
>> +			page_pool_destroy(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +		}
>> +	}
>> +	return err;
>> +}
>> +
>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		struct receive_queue *rq = &vi->rq[i];
>> +
>> +		if (rq->page_pool) {
>> +			page_pool_destroy(rq->page_pool);
>> +			rq->page_pool = NULL;
>> +		}
>> +	}
>> +}
>> +
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>>   	int i, err;
>>
>> +	err = virtnet_create_page_pools(vi);
>> +	if (err)
>> +		return err;
>> +
>> +	vi->rx_mode_work_enabled = true;
>> +
>>   	enable_delayed_refill(vi);
>>
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>> @@ -3251,6 +3405,7 @@ static int virtnet_open(struct net_device *dev)
>>   	return 0;
>>
>>   err_enable_qp:
>> +	vi->rx_mode_work_enabled = false;
>>   	disable_delayed_refill(vi);
>>   	cancel_delayed_work_sync(&vi->refill);
>>
>> @@ -3856,6 +4011,8 @@ static int virtnet_close(struct net_device *dev)
>>   	 */
>>   	cancel_work_sync(&vi->config_work);
>>
>> +	vi->rx_mode_work_enabled = false;
>> +
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		virtnet_disable_queue_pair(vi, i);
>>   		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>> @@ -3892,6 +4049,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>>
>>   	rtnl_lock();
>>
>> +	if (!vi->rx_mode_work_enabled) {
>> +		rtnl_unlock();
>> +		return;
>> +	}
>> +
>>   	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>>   	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>>
>> @@ -7193,6 +7355,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>>
>>   	free_receive_page_frags(vi);
>>
>> +	virtnet_destroy_page_pools(vi);
>> +
>>   	virtnet_del_vqs(vi);
>>   }
>>
>> --
>> 2.47.3
>>


