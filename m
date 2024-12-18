Return-Path: <netdev+bounces-153059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FB9F6AFD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F5E1897A8B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E91F03D6;
	Wed, 18 Dec 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="YAPLRVyt"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020101.outbound.protection.outlook.com [52.101.85.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99314AD0E;
	Wed, 18 Dec 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538994; cv=fail; b=SC1XBqig7EEWpBZRR4zjHW03z1FYQ36I+MqYXIpDGLaJfH7dOAF69yDuEE9a+h2NlpoKWa7fMtkHoyDpoAw/wM+KUoeOi+mmNOQErCBUrI6ab6v5PJ/1xwHJs9hYMQ7tq/z75hwEo/oZexCctx3djLCmVDs+vR3Zb/S7wIneewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538994; c=relaxed/simple;
	bh=bQyKJa2q3aapgwJE5tl373Lkb3BBVPp1TL0dq9+SB5k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbBDZ359Daj2LGv79t6Re0mnT1WrJ7SuzLeXMZbtXeWHFsswizG2xP4YknRx5zcIGxaXwYX5BnZv5hNxPmCRCDRI6Jz/UcfSlJySgVBiT+Q3TXKbHJPaD/jAtX/+DC2HpJGzrrE/MShTRMbKuM7GBu43IBSHc2GSuAbW8JGAjUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=YAPLRVyt reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPQOhR6VOaya06miDatx7AdxBVWga0caRWlpNhE9xAsg1i5tRukjwKYagX5Ebu/A9LigwwHSTvq1Z92m3eGItPM2aFhXAvZJcm1VXmtohEyA27/D8DNc5oxGpVgmimG5jQF3puNKU84QRc0LBE5kkhjscHG4WemZO3HqtiMVYyTeG9jMlBLvPJizoG05bi1sFoJQm7ZkkkfqI/o+TuLgXUzPP/THTUDBkD0aV0EPrjTs7rBZcU6FGTeu76quWKDQ9ElhcR1KCof4kJQesI6GSWbrd0IeLC+v05v8zR/ePeorMNQLwbX+Ss+VmKdJAlMECZD94eLgscxsgQNPB/qtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaCHM49tYPJQMY2gY+oxhUg/fLvhGKJ9uncfEaDzdYI=;
 b=Oh3jJXhB9lzQEy4lehtkdwQgUbt+bo6UnWI8q5p7t2K1FiQfNwAL1fRsVNetFc2PNWhBpThngZckhDPykzSrOsswC4LEQ3tIR8Gf25CAra0KTYg1jRWt06QrgVDcoV3TRtw8u5W78xBSkBHopcUvZy05b0aV5QeDBLkEBvOzBjRMfB3/9S5wP5+MCs/lBQCucKJ6F+hOOb4sp6S2B0WBgD/juczVLl3vd+4Nsm/05i3WwYd5oOBx8qJpVseHuxSp6ECNByfsQVp8w2Oj+Xuehc8T92jAN7yrG3V0ECxOi94wS3PbuLoQpjE1ovVfiVMIhMajAx16weG8XExWmcw88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaCHM49tYPJQMY2gY+oxhUg/fLvhGKJ9uncfEaDzdYI=;
 b=YAPLRVyt37kWhrBIW4NV7uAKaFJjs8oUjBxJK7K24NG5jRwZaz+6tMf9InL8Xnw8NXzB7sX/UhUZI/iClOldQmu+d6BNXXs/05Aw/x92z8fWxTXxnoRvHegqg3CjAmYwy12eq1E/hlIVSdF7Gx6DVb5o1N7NvWD1GADubOHnMY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB7238.prod.exchangelabs.com (2603:10b6:a03:3f7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Wed, 18 Dec 2024 16:23:09 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 16:23:09 +0000
Message-ID: <7bfb8a48-8a14-47cb-bd69-1d864535aeba@amperemail.onmicrosoft.com>
Date: Wed, 18 Dec 2024 11:23:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Joe Damato <jdamato@fastly.com>, admiyo@os.amperecomputing.com,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
 <20241217182528.108062-2-admiyo@os.amperecomputing.com>
 <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:930:cc::14) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4ad253-64dc-4a09-7954-08dd1f8042e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3k1ZFZ2T0QvZWpNV2RqcDFXbEx5cFloWld0VzB5cDVtdWtLWTJWb3lmTjkr?=
 =?utf-8?B?THhTcW5UQWRPSkk5VVF6NmJhYzdraHY2S3dLdGRZbkhCNkdaaXNBTmVvVjA4?=
 =?utf-8?B?aXJQU1hiZHFCQWV2ZlRRNGRuSCtIRkxkVFZFQjA4QnRtZVhFVEtkWE1zejhX?=
 =?utf-8?B?MDFqZXVyRzZ0VEZyeUp1U29PNnhjVEt4VnZ4QWNkME5wYm1OWDFiNFhmRFFQ?=
 =?utf-8?B?aE0rRU8zTW1wZ1E1QXNoRThMUitrLzd4TE9QMkdGckRhSitIZER6U1lINCti?=
 =?utf-8?B?SDIxTjNrakZpY2ZVZmFscWZ4eE45ODlsUU9COC9YV0NyYk1VSmRuUERUc2xX?=
 =?utf-8?B?cGFSaWg2MWd5UlJ4OVdleUROQ2x1NFg2Z0hqYlBhUXVxVnN0dFpJOVQzR3JS?=
 =?utf-8?B?UjNLSDlJeWpTUFRwMVErSkxwZWMxaS9VUFBaa041NW1FNW9IWk91c2dyVFdS?=
 =?utf-8?B?anNndGRTalVkVjlHbnBQeENTaGdoaEx0dEllc3FscDR2U0RaNk53aFQxRkJ5?=
 =?utf-8?B?MlpaOGF2T3A5L29OUko2ZjRGQ1Y2RGVoMHFmLzFpWVBTY0dWY01aSEk4RTFI?=
 =?utf-8?B?eWs1VXFDNU8rTlNsdHdQVDk4cXdqWFBPbS9uelBvYXNKV0FxcDVMdzFUTlpP?=
 =?utf-8?B?TGFXWkFxckJOeHlLbUp4dk4wRHg0TlZtbVJ6aTBPSkhhUCtKUEJ4cXFjOHZD?=
 =?utf-8?B?M0FTVm95dE85SEkybEc5QzQyanY2STg0eXFGVEs0UUk3a3Y0bUgzTHhqTDRK?=
 =?utf-8?B?b1VsaGJoV28vbXNjdHFzZXA5eXlIL3NjZjIzRm4rOENnazhwUnZOaHVXVWYv?=
 =?utf-8?B?a1pEbUdSaW5VWklkaXh2U2xHblhQT0dhRW93aTZTQ3NQVVl4eDVKanNUTWQ5?=
 =?utf-8?B?K2VQWmk2QmxnWVNQc0dkVW05RFVINER4bSt3a2owdm16c3RqY1BuVWxqVWhv?=
 =?utf-8?B?ei9ZM3gybXFpdFMzTEoxWWg5b0diTWJxMVJPbGVWd1JBUEdUSjJsb2FlRlMr?=
 =?utf-8?B?MzBOdEU3NVRTVDEzNXBnVDIyTWpYOUNGMVVqMmpLMVFXbGNnNHBjalhQUFAz?=
 =?utf-8?B?TVlHVGtETm04QXRDZFJ5ZkFONUF6em9OMnc2UENoK1hWL0Yyamt6SXZqbDQw?=
 =?utf-8?B?dUFVYkdnMUFDU0s5RUNNNFBGd0VKSGl2M2VjaEozRTRFMnM3clErcytDK1Ra?=
 =?utf-8?B?akIybzVscjhLRGZKL0RZOC9NcTRxNXMvdEdVVHZ5Rno3YzF4d2NXcTlFWGcz?=
 =?utf-8?B?YzByR2NTNWZiaGxWNEYzRldTOGNRVlpQRzJNaXhiZEhVN2k4ZzBaWU4weWVI?=
 =?utf-8?B?cDZUV0o2SXRoc2NoNHora00vR0JzVG9mc0gzRmlVbS9qdFA2ajh1Q0tsdkV0?=
 =?utf-8?B?dU04TkJqV0JXc0NaV1JVUUpQc0JSdFFRT3ZQbUlPNWxJS3lSdzhaRGhrUXo5?=
 =?utf-8?B?RE5uMjkzN3VabWhXQUxsbmR2RDNldWpoN0x2eVdyOEtJWU95Ykd0ejNMbkhB?=
 =?utf-8?B?RG1hUkw3L0c3M01JWlA2b293WHNwb2ZDMVd2dkpycFd3TFd5ZHk1SFZQK3Vx?=
 =?utf-8?B?a1ZLa01MNElZWmxBSHJ6K0piRlZNd2NLbW5RMzYyVkhOUmQ1WHZoT0c2MDQ5?=
 =?utf-8?B?bG91L1VEbUo4RVUwV3FrL0RBaTZwNnkzK25reHZnUU93dm50Ym5RekpOYWhD?=
 =?utf-8?B?cjFSYnlFc0xVL1NpSW1zbjh0L21INFdOLzcyQ1YyR3JtbUR6MHJYRDhYYnIr?=
 =?utf-8?B?VlRQQ3lPZk4vcm1mMmk4c2gwOW1lYlFkMkRWNlA4aHlCdUFkT3BXVHFuZ0Vj?=
 =?utf-8?B?L0hnMHNOWEZyaHVySVZUOTRjbVJ3cUdkcWtadFNlWDUrRTZWWEVVa3k0b1J6?=
 =?utf-8?B?OEF4ZmZxOXFJbDBiMGdvdmV4UHBsVlcralZkbG9GN1JhRm5sOTJwZnBDdngv?=
 =?utf-8?Q?eTY3tMycsAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG9SQWJVbUNPRDNBWXJZTWJXdDN2QnNVVnpHYjN0TDVaTUlFS3VBaU9HLzYw?=
 =?utf-8?B?cDRYRVBReWl6S2RjeDlKQ1ZkL1JibTdFZ01vbGZLQWgwTUZUU01MZEc5TGZl?=
 =?utf-8?B?MnhKb0RPVTVFU1BQZXlBVUlrM0N2cTdJSmpjS241aWE3RjdrVjFBa1lKRUpW?=
 =?utf-8?B?MHIvdTdCTzFnbUdGaWdLQ3FOZGhyZ1JtNEF1NFJvRnV6YXVWdCtUdGJwdDlL?=
 =?utf-8?B?WGtRN1EwR2pDK2ZGUGZaOWhEMGYyMWo2ZHh0VXRvUTlKT3NiMU5SV3kvY1k5?=
 =?utf-8?B?UUJLNkViVjZPQWxQYjRTZnhIYVJRQ3dxekx4bG5xV3QxT1pxbDFvRjNENkNq?=
 =?utf-8?B?NzcwWHYyQ1Y1cGVHZ0pKMTJMVE0wd0RZcCs4OFZVd01lVFBTWmRLeFdVeGZV?=
 =?utf-8?B?TmVOeHIzNmR1QldYaUFxZ29KN216VVZibHM1d0hjSW54TXcyclY2ZENaWjlG?=
 =?utf-8?B?eVFwcy9CeUphZzVIV1E1cXk2SDZoc2dqWDFvZTc5RVh6UC9uVWN2ZGlLVXhU?=
 =?utf-8?B?SWE3QzNpd0xCdXNoREpGUU50YVk3MTdJMGFVeGF0VFU0bjZyZDJpWVhDaTJT?=
 =?utf-8?B?SE5Za0tvYkZBa1BxQWViNEw0cE9pbUt4dWdpQ1Nmakg5dkFURmpmT29TakF2?=
 =?utf-8?B?Ly9UQ1I2aXhsTHNRZ0N5aDNOTmlpYWFmc2lBelNnUjIrRDkzWVVrdVhLZ2lx?=
 =?utf-8?B?aE9hdmQ1eDAwSG1vc0VKdmwwTDhsZWt2OG4xYm5DZHhuYU51TTE2bnh4ODJ2?=
 =?utf-8?B?YU9uMlRaRmdsNmFIZGZxWlJDa250Z25Cd1M1WllMR29QQ3FpcWhIcExTYjRT?=
 =?utf-8?B?T0Q1S1ZjTEtxSlZ5VmNGZEFERm9sa1VRNm95Zk1pSG92S2haRGFNNVloQi9i?=
 =?utf-8?B?SmVLSEhEbFFLZnNHWEkvRlkwVE81b2g4SThQUmhSa01XVlJiQVRNMFZhb28y?=
 =?utf-8?B?Kys4QkdpRWRPSk9zZHRXekgySkkrR3pMek9hOEh5TFlJWjIvT2VnOS9sWTF1?=
 =?utf-8?B?V1JNamNJMjJaUmVzZ0Z4QnR3VENIZG1oN0tWOFovS0ZyNnRpblEyMjZGODRL?=
 =?utf-8?B?SXQwUG9ZblRQMlZ5YUw3bzRpOEQ4SWx1aXpUdEpFYjNKWlZoNE1lWlRsWWhx?=
 =?utf-8?B?anptdDUyYTRVclRJemFDd0NOYkY5MVpTbU1wbUorc1R4UVk3VXpRQlFiWUpZ?=
 =?utf-8?B?cjFURDl4TnhEbWlocXNHVTBJN0xPd3ZOblorZmJNTS9SWG1CNGZXTmRNZjBP?=
 =?utf-8?B?eUpYZEVydDhUWitENGRGVm1wenU4YnVBWlUwbHp5VWlVM3c5S2szVXJlWVhW?=
 =?utf-8?B?d3BEVmQ4bFYwejRqb0xHRFZPSG5BYlVIVlMrU2QvZkRueVgzM1JqMnpjeWRN?=
 =?utf-8?B?TWNPK1RxbTVZelArQTFJaENmNXgyRmdvY0JBeW84bTRWOXVYSkJ2YzNTS1Bv?=
 =?utf-8?B?aTBXOXVEV2NOMHBOREpReFM2Q3FnZXVyYTcxUFExMjhQYmh5U0tWZzdlaExx?=
 =?utf-8?B?T05VV0NtaHNmdGVEbGdvQ2RUT2JFSkVBWEc0cURlaFRMMEwrSldlUGRydFdr?=
 =?utf-8?B?VWhsckhRazlpclRnZlBRQkpUa1QxUGJ4VDRUTCsxM1h4YUZubkx0S2J3UGtP?=
 =?utf-8?B?STR0SndtYitiREVvU3lrMDdCQmNxS3ZXakxzd1VWalpzSGJlSUo0S2JTdzZS?=
 =?utf-8?B?QmROcDYwbWNObSttL1hPeGI3RW55NlE0aXhKTkVWczEyVUh6R1htc2VNaWJR?=
 =?utf-8?B?L3hQMjFsMG4zLzhIUC9uK3E2Z2lGMEpBK1JxaXlydkVCUGx1OGhVZjRIYTRW?=
 =?utf-8?B?aWlpVFR0SmJrb2RITWhxZ2pncndyNUVDUHc4YzBZUlA0MUtKSzN0Ky9mYnpH?=
 =?utf-8?B?ZHFIOTNOMVJTZnVFTEVieTJudVlOTlBnR1d4M0p6NDA4ZkxXejZZby9yWEk5?=
 =?utf-8?B?QzVXYUV4T0VqbnJRVk1pZ2JLL3V3NVZBbDRjTVJVVTR6TXBCM0VSYStFWjR5?=
 =?utf-8?B?NCtlSElNZS95THNWK3hDN2FFTDdzZFdSZ1RuaWRSRU9BcEhaTHJ6aVQ5MERF?=
 =?utf-8?B?dzFhdUswbGgvRC9Db0VTK1pGVzdUalBpZG5JYzRhMUVUcG43ZXp4SGk0ZmRz?=
 =?utf-8?B?dUJqNDJ5MTUxaTN4WFM4Q3NBQVR2Y1NrTGdFdVZFZ2pBVGZPWlpsR0VRSm5D?=
 =?utf-8?B?dzgxR3JxYjBMa3FVWU5IR2EyNWszeWZOZWJMMlRWcTFWaEQ0cVZ4WlA5UGRQ?=
 =?utf-8?Q?FEeeyBWrVN2a3Y6+w3oEyUfqovskxT7fZgM8IfRpm0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4ad253-64dc-4a09-7954-08dd1f8042e8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:23:09.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmkT+I6928m4QJ9bQxDgXwOQU+KIAtdriLcC01Ojzy6erMIKH2i70oxDJYT1eoSjfkCdshIANhRbkVK/VoDIevIT1M2DOtqOHbpk8s1xk7MhwSCDwIa4KWz/m7kNW+UU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7238


On 12/17/24 14:04, Joe Damato wrote:
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +	struct mctp_pcc_hdr mctp_pcc_hdr;
>> +	struct pcpu_dstats *dstats;
>> +	struct mctp_skb_cb *cb;
>> +	struct sk_buff *skb;
>> +	void *skb_buf;
>> +	u32 data_len;
>> +
>> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
>> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
>> +		      sizeof(struct mctp_pcc_hdr));
>> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
>> +	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
>> +
>> +	dstats = this_cpu_ptr(mctp_pcc_ndev->mdev.dev->dstats);
>> +	u64_stats_update_begin(&dstats->syncp);
>> +	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
>> +		u64_stats_inc(&dstats->rx_drops);
>> +		u64_stats_inc(&dstats->rx_drops);
> Double counting rx_drops ?

Oops.  Yes I was.  Thanks.

>
>> +		u64_stats_update_end(&dstats->syncp);
>> +		return;
>> +	}
>> +	if (!skb) {
>> +		u64_stats_inc(&dstats->rx_drops);
>> +		u64_stats_update_end(&dstats->syncp);
>> +		return;
>> +	}
>> +	u64_stats_inc(&dstats->rx_packets);
>> +	u64_stats_add(&dstats->rx_bytes, data_len);
>> +	u64_stats_update_end(&dstats->syncp);
> I suspect what Jeremy meant (but please feel free to correct me if
> I'm mistaken, Jeremy) was that you may want to use the helpers in:
>
> include/linux/netdevice.h
>
> e.g.
>
>    dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
>    dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
>
> etc.

I don't see those function calls in the 6.13-rc3 tree I am working 
with.  Are they coming later?



