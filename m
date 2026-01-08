Return-Path: <netdev+bounces-247964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5DD01116
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 06:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C959330049DF
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD232D9EE4;
	Thu,  8 Jan 2026 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qNPVR5t4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6401F0E2E;
	Thu,  8 Jan 2026 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849858; cv=fail; b=L9S+ZVNe/2fzSTJ6UJSHCusiHFxyN4ODJfG5y5eenbuCRzhInCfhc5zGlElOqHUrcae6LS3jLFFzghFuHhk4rpuCReHbZFHwGAhZNhOGAiwUA2qXlBo7IyE0qh/yq72evMacJvBMqhEuOmK/ODUARRuNogNwpkrxs4lA0CYycEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849858; c=relaxed/simple;
	bh=7pGeGmy9E5jwjtyDLVKKmgg7U4jde2bZs6Q7gJNVXyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=duB0tmU+fwLbOXxyxLSgULuzJ7fiYB8lqSSVLFQqnAEBIo8zo92N2sJ6eNlnRdR68rjAOP5vcELyEExs/hxaFcphxBbSNT0vn0erdnipBQBlYyqFo1kMBkAjIj1yRBkA3HVAJzjIvWRCv6paw+l18XnbLl3Z3IRuZL8F2Uf6iKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qNPVR5t4; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6081L8v53748942;
	Wed, 7 Jan 2026 21:24:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YrutjsA8Io2HCkBgL21xvQLzxBgBQdD8sNW1SIXIj9o=; b=qNPVR5t4we/X
	0/HQuRwMz/omgwbc0WGR5hwdFTqsM2M4WNRnJp71gWzd/30T4+lpy0fnvKUjmKSg
	1fWELytTL6XKvX3O18G7OEDIeNay6xkcW3aH/dARVezepZSC5prTdMg4We527DC8
	jgj0J51gOz9vdV0kJkttBeZ0fY/l/1uBOuKT+lwoy54Px0vVkXL0Z77jkGntvVcl
	Guyx69Hg/k7bhd/Jge1nGt7h2NX1pfANQS6EML4mizJrw/0slGpojNKIXxRXqBZ4
	szHAKGF0Zma0iwCoM3ZWQ8+j2F6bxz7RPgWWWJSrHsuFDLjojkqkw6Wyf2TWOCTC
	1rSSY5FSBw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bhuu0x4t9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 21:24:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxjRP1P1/s3vyCNz+4Jc0WVqzGiRXX7JEWObEfN9hsaLxy20Ehp2bE2VGVqPbwRNMFDuQ0WC6ExwmO/Ej+jElbnUesDcca4vVprzBrpfcMl5DTpKiCJlNLRs1VJVMmOTLkj88NvMsPQmLAHsCGKl+2lA08SXhjdVDiCAcsfS+v6HvPBJyL8oAYCtkejFrYDFSi05FlaRsHZbeZEh/rPNT13ZvaS3EmrlYGG4PMfZE+3rrb4s+NrSY6QGpoXLb+OUVZNaiGbmyGsNjR7Wl40Mqa4uL95seUKdQx4O0WTnSc953hr8ddtxLYrBz/C0O38tFnupRJaj3b+2GNI1UrNrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrutjsA8Io2HCkBgL21xvQLzxBgBQdD8sNW1SIXIj9o=;
 b=mTliWEl3QChlR1ggUeQpn2G/kr2ippgLZPZDRDtUHtB7BYrXaMSeVOt8W0GIgE2OHuu/z+V36wKbANt6IO0wc6odS2P4Tsqnuzu95qDsx40Hk/Hix/rN92P1bQd7ae/44J4rqlTBtXEDD61VzwXF5/alKtcI3dhA7ngc+cl/MobRA4Mkc+HsBfVTZKROsUoAMLP6/Q3nEGXgpolNF6RnWQMsJMl1tfXA8R4f8AkXoPo/QBQx6JnEenEISj91XDIOrVA7KQw1WRJmEzObzIqlKN1dmx6WBt+yt1BUDDMgkaW7Ec6jBtTdKfbin3FrYRxiKkoEprHoMRh0IZqdjUPlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by DS7PR15MB5859.namprd15.prod.outlook.com (2603:10b6:8:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 05:23:58 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 05:23:58 +0000
Message-ID: <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
Date: Wed, 7 Jan 2026 21:23:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260106221924.123856-1-vishs@meta.com>
 <20260107032738-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260107032738-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|DS7PR15MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ff34e4-9413-4b84-039a-08de4e761ec6
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkhoN2RyY2pNNmFTb25ONHMzN2NabWZHaVNGc0ZtZzJaMVVzenJ4WE8zRFBX?=
 =?utf-8?B?eTlLUThJcHJaKzJqM25NdzUzY01mNGU0dkRsMUh5dkhkNWVIZjRCNGdYSXRK?=
 =?utf-8?B?S3ExMVNHY3hJbFNlTG8zNGFJczVYZEt6S1Fyd2pzQ2poR2g2b09sRTFTM0to?=
 =?utf-8?B?V05nVUdKV0hIeHk2blZLbDEwVnN6dVh2eFFqNGRHMUJIcnNmQXA1N1h2eGZ0?=
 =?utf-8?B?R1M1ZitrOTRaVXMwdlA1Y2lZYkgwdEs0c2hjTHhONkpDeEpudk8weEw3Nnlj?=
 =?utf-8?B?TWE3dHBqUnY4Vm5IR1FwYllTbnVkRExKeU5SRHpzVGw1cGFjMmVtSUMrZ3B5?=
 =?utf-8?B?THdQZWpDeUVvS3QzTWtrTkFRV0czOWdLTHNqaVIzOHVQcXphbjFtWkNNQXhP?=
 =?utf-8?B?K3B3K253YmtwTk1MMVd4RjRrZy9uVjBON1hVcFFvd0U0YitFWmhYSy92NjUr?=
 =?utf-8?B?SHRvNkx3NGNiclBLOGF6eWZ4bXRvSytSdERKOVVJQUFMb2ZqdURNZWlhOVFM?=
 =?utf-8?B?VXoyMEtmcUpOYjJJcXlGbVozSHpNemxxSDEvN1F3MW0rS0xOMEwvbE5Sc1hz?=
 =?utf-8?B?Tmk5UHdDcVRGRVZET3EvOHh6UlFrUFZ5bjRwZkJjZURGeDRYcnoxL0dDc2to?=
 =?utf-8?B?SHg3bFV4d0ZWVTVOQVVvTkxjay9wUEhuUDNFVVlGcE1HeUlESDh0N1FnQnh6?=
 =?utf-8?B?Z3ltZHM4ZjI0QjJTcTlCQXo1MWRXY3ZYM2Fpell5bm9Ja0l4bjJ6VnFIeGtM?=
 =?utf-8?B?bmk0UmNFcWdsMURYZWZaSE1mczdqR0FnMWhVMVJ3UDNoK3NkKzNDdWNTTFNa?=
 =?utf-8?B?VTN5R1VqT3VNUlpuTnVVZUVYeDJBaFREVEwyaWx4Z1MyMmQ4WmxjQ3o1UVVR?=
 =?utf-8?B?TTV2TFp1UEhRbmJYVWtZRWJoN3FFcFBVUmRQWVRxTVVUWTRtUGhLZjl2SzYr?=
 =?utf-8?B?WHU2Q0VhNGZQSDNCSXJxSkVMeFh0ZUdybDNoRXgrV3NtSXpXNmQrRURqRTJi?=
 =?utf-8?B?TGNpNWFoU2xoTEFQTHU3emYrc1psOENXQkpleDlEYnpGTVcyZUZpa2Z2SDVS?=
 =?utf-8?B?b1hnb3o0N1B6NVVyVURxeTJIS0Q3YTNoQjdyckFoQTBsUEd3QW9GNWdaclJr?=
 =?utf-8?B?SG5sTmhUNDl6SXZVVFYwaktrbGwzSUJwTFdRSE80TURVZkJCdXhtNHUvblpi?=
 =?utf-8?B?NUhQRjR4Z1RBUHlwOGVVNVRpNWdyQXpvN0lRQW80ZWVWemUrQXlZZ25mTDRy?=
 =?utf-8?B?NnRhVGdCUFdMb3R1eDBMWHZHZk5uYmpCczkrWFM0WERZOUVuZURXdVBXeTlO?=
 =?utf-8?B?K3RCNTZ4YzR1Q3gvcmlxM3FFSTJFMEdIMEcyQllMUmU3QVh3V1FaTUM0eklj?=
 =?utf-8?B?UGh3OSszeHhUUDVGQ1ZQL2tQQ0lMbHptdS9yRWJyazJha2VGYW4zQTcwRUpV?=
 =?utf-8?B?WFhhMlBoWnJFV2dWUFdiWVMrajJ4c0t3azNVTWQ0elZzV0IwQ0I3bkpKbEQ0?=
 =?utf-8?B?M0ErSllyb0YwNDY0Y1RBSHB2QkdJZW1hUmtvMGRIMEVZbW81b3ovMXpPRUg1?=
 =?utf-8?B?UlBJRlhPQ2w1NzJWMnNQYUVNUG9EYllsNzRpZmxURldJY01wUVQzZC9YOWt3?=
 =?utf-8?B?M1lCUk1MQmN3WE1maExJRmxLWllHelF2a0pMa2wvbXE5QUc1eFVLRUs1Ujh6?=
 =?utf-8?B?WldLTmJsYUtHQk02WkV2aFprYXNBaFNMa3hoM3ljODh0dFhJMXVydGtjamJF?=
 =?utf-8?B?Y2V1eW1YM1U5dUFSS0dBMk5yaHY2Um5sSWFKYm9XK2h1bW1peG9VSy9ETTFT?=
 =?utf-8?B?SFJIQjdpY0o2bVE3blRpd0pMZTBJNStHMWZXVjdrSi96Ry81MlArSStoMDdN?=
 =?utf-8?B?K3ZLZ0tsSmEzMU5iUE0vWHp4dG5sZzZNTktaeE45eWxqU3pPQ1Y3bVZvWVFD?=
 =?utf-8?Q?cmsFwANorRg6mlmDgllRKBvj4zEEcoM/?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K25vcWo1alAzQnU5WUVHU3pKUU9lMUZpZVpFRTlTektkZEJrU3hNYVZOcmNI?=
 =?utf-8?B?MngzM21ZbHhuOU1BMitLbGE2NUc3UWJyNUpWZU5MSnRPekFZNnVtNFp6cmh4?=
 =?utf-8?B?b1k0dit6b2VTYStmWThDTHd2VTBGSFZHMXlQRC9iaWFxR0t1cU9hd2lQTXRP?=
 =?utf-8?B?UmJNRzAvZUJ0QTBWQXJabEhPbko0KzZFNlFhdnZ1amhhZ2dGeXZBR000NlhO?=
 =?utf-8?B?WFJ0ejZLeDRha2FnZVkzb0tSMnNLaFQ0MUZyT2xGallQMVhHTlc4eWlPeXgr?=
 =?utf-8?B?ZDh6VEpBeXV6ek1CVW1OZU5KWmt4QUx1aTB4UG1vQlo1eXZZRXVESm9vcVk1?=
 =?utf-8?B?dXhFbTVFSUNEZGRJVjNSS0VtbVNPOVo4dEdlS1ExZ1ltekQ3SGx2dGNId0NL?=
 =?utf-8?B?VFdsVm9uRmpzRHc0dHIxaG80TzhnMSt2bUozUVlyS01DU1c2WGpaTlI0UWFp?=
 =?utf-8?B?cllINjA3cG1WalRkMWtlUWlseVNVRU9NWVo2MnMxMEtmcGc5Q3hCaDZsdkc2?=
 =?utf-8?B?WDVTdlkzaXRBSWthVG9STGE3RWw5cTZvTzdUaVRHamptSE1BZmlGaVUzYnRS?=
 =?utf-8?B?VGdZMXdpOE8zZHNaMDJEclN5UUdNdjR4N0lvWHlCNkJPQnVRWVhSdjBuZlcy?=
 =?utf-8?B?MDlEd1NncGQ1ZllGLzd5a0cwOEU2Z2lJT25yWWNsODk0cUlJaURlbklmRFBM?=
 =?utf-8?B?SU5JT3gvNE96WnVRY3dobUJmbGorY2JrQkFNeWJXN2k1UlhEaSs0bDRHampO?=
 =?utf-8?B?L2d5cUxCZlZhNGVjQ2dZQ29TL09McUhEN3lpL1FXblZDNkwwRVk0K2hnR05Z?=
 =?utf-8?B?cjc1eEt6eGMyS0phai9VeTZKYUlyMDBXYUxHK1FtcW0xWXVRRzFoaUlvUm9H?=
 =?utf-8?B?L2lCWmNVUXBEYytsT1BzODdIOVVKaEd1Mnhqcy9tUEl0VFEwaG1OSHk2ellH?=
 =?utf-8?B?QzdXVWNYdGlZZUdpZ0VLYWkxS3g0a3FoT0hPYnZDdnh0ZVpXQlpkOVZDczE4?=
 =?utf-8?B?MkhYUmcyNi9mT1NVVFNEZzhmbXVtMVM2eUdhNVJ1ck1mOEtXNnNXdS9nam1x?=
 =?utf-8?B?RWRxYWVrMWQ3bGcrejNkWUM2RHRXMXNvWDlObVgvRGd5dkl2V3FJdFM0UXZa?=
 =?utf-8?B?R0p5c0ZOWk0vbUhlV1RHeEpOSklvMFNtMFNaTEJsdXczdW12a2NKa0xObUpu?=
 =?utf-8?B?WUxkM2VFY3JRNnhHWDl4WHl3d1BSR21NQWV3dUxyMG90S3k0dTNjMW5Qc0Js?=
 =?utf-8?B?ck5Oa21CN1ZoeFA4Q1dtL2FFVDNrbmNSMkkvNU9IdXB4eGdZbXpWUmYzalhl?=
 =?utf-8?B?akRuRFpYTzhCcndwQXVvWi9iYTFhckh6V2pwNld4RlBiTWhmQ0hmTGZ5dU5G?=
 =?utf-8?B?bzdZQkdLMUpNaUQzTGN3UWphTW51UlZvNXRpTmZBYVZMblhoNkYyYlExbjRO?=
 =?utf-8?B?YkNpSG01bUswSzcyVTBteXVVbkpndDRhRUxTZVlYOHJDbjhjV2xnNHd2Mkc3?=
 =?utf-8?B?bXgwdTQwQkFPM1NXR3dtcittcFY2b2lyQm96UHhlZ0hIN3hyZmJvQTlNQ1ph?=
 =?utf-8?B?WDBCTGR3ektML3hYNW13cDRzK1QrMlJlZHdwQ0JWdW9seExwbnE0azU2L0w4?=
 =?utf-8?B?RFVobW1xMXpMS3JIWFltdm5hTWRPcC9UOUw3VDBYN1FWNGp1YXpXN3d4MytC?=
 =?utf-8?B?N0J4cXRaNlgzM2RESXM1RkY4a2hOSkhkZGk3cExPeFdtWVBvc2g0d1lSeitM?=
 =?utf-8?B?dXh3MUtYaFArWktGMDdqd3VCNG1FZWdlZ2RHbGd5S0F6SnJqU0NwYzZ2eGtS?=
 =?utf-8?B?YnFsTkR6QmVFS0dEUFZseVJ4YTlURStkRGVrTzhJS0hqZy9lNUZNaUFyZTVD?=
 =?utf-8?B?dWE2VURoVVAyN0FUcW9kT2RhZkFkYnRDM0hWZGdnWHQ2VWZJbXVpSFo2NHZ1?=
 =?utf-8?B?THNidVhtNEVtZlJTRUN3ai9qdWJDVHlGL0t1ZUdUYjR3cVdzcDd6cFFWWkpS?=
 =?utf-8?B?WEU2QlBIK1hHcUtISk1zeHBWa1YvVzVIL3Z1STV5aXV5aWZpYUx6SzVlYXVE?=
 =?utf-8?B?T3RZbVZyKzlOek9pRCthRC9Rcm9mNEVhMjljSlhMTm16S3lNcXFUR2RxRWhH?=
 =?utf-8?B?RHV1c01UckNvRUM5QkpxcEpCbXhsTmlMemh1TS93Y0dKYkVtNUl2Q3QxSyth?=
 =?utf-8?B?SmdUWDdQTHdKZE1Sazl1Y0prOUdCR0hvbG9aSEI4WGxPa1hBVEhpOG8xbzBZ?=
 =?utf-8?B?R3pLL2dBTzhsbUs1UVZtOTZSRDRPL1czOTd6WEhEZ0pLM0RrZjlONStXOXh4?=
 =?utf-8?B?SFcxbjFIVTB6M0V5SGpVSHlNZWwxSUYycWRCclFNTTRGbGc4QXNOMVBwNEho?=
 =?utf-8?Q?tPkPuzURRx3uKvwaAXewuNPZSNoUoE6H7uAcr?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ff34e4-9413-4b84-039a-08de4e761ec6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 05:23:58.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZde/5KADQ8rSLG8lGgc6zGM+8CjVMJgsomac32Qx8QfIGqEvZKFvUzMGHL4N4fF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5859
X-Authority-Analysis: v=2.4 cv=bKkb4f+Z c=1 sm=1 tr=0 ts=695f3f70 cx=c_pps
 a=iHXbSHwDNs+yH6wS+48/mw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pBlTsiValDllgsjDkycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Rsny4glSzGuAOc3yzpJdQKfjvwIoTBtJ
X-Proofpoint-GUID: Rsny4glSzGuAOc3yzpJdQKfjvwIoTBtJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAzMiBTYWx0ZWRfX/+VcUOJG51aH
 6MV/CTU6ASjITMCZO88S6Wyfsd7N1d0Ss/qUnJrWq7mgwA9umy2LqxXb9K+9+fH2/ovzIBv2DEG
 8hY+jojvqVwd0SkCdW/S+a4u1q+QMf+XmtoAc3cveJaT1yFKIVNEsV/6WZd3T8ju+6fSxaRhV7r
 RnquprjWNCob3/3AG+Vf5TLMPpe2TVgFvXNBvXakjn8S+Xq+TV92EXk2dgZOP+p+OzSF7emQ7fQ
 H5oPfAJDE2gGuxmWUYUSRjo2AiBJWkYaEkqeEKOBmJwaDxGpJnFxK9CNHkD5x20oVbFIgbbwH6g
 Mn0u1dHRxd5xtu+huVCbkJTMXqGcL2mEMNcoUnxot3eBtj17T+JJKTzBG7+lc2lDxZzMMq1+Vye
 FwlWmGN4aXq2WYn3WvJ8xQfwmqZ2QeimNmzOdt0QBhU4XxkLn9fwdWzknU6CqNNUfDCcEpcJker
 GJy1S8O0WK02Y4O729w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01

On 1/7/26 12:28 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
>> Introduce page_pool support in virtio_net driver in order to recycle
>> pages in RX buffer allocation and avoid reallocating through the page
>> allocator. This applies to mergeable and small buffer modes.
>>
>> The patch has been tested using the included selftests and additional
>> edge case scripts covering device unbind/bind cycles, rapid interface
>> open/close, traffic during close, ethtool stress with feature toggling,
>> close with pending refill work, and data integrity verification.
> 
> 
> Yay! thanks for working on this!
> Could you share perf data please?
> After all, page pool is an optimization.

Thanks! I'll add benchmark numbers in v2 of the patch.
Beyond performance, page pool support is pre requisite for enabling
memory provider based zero copy implementations in virtio_net such as
devmem TCP and io-uring ZCRX. These features require the driver to use
page pools for buffer management. I'll update the cover letter to make
this motivation clearer.

> 
> 
>> Vishwanath Seshagiri (2):
>>    virtio_net: add page pool support for buffer allocation
>>    selftests: virtio_net: add buffer circulation test
>>
>>   drivers/net/virtio_net.c                      | 246 +++++++++++++++---
>>   .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
>>   2 files changed, 275 insertions(+), 41 deletions(-)
>>
>> -- 
>> 2.47.3
> 


