Return-Path: <netdev+bounces-135228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0C99D088
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157E3B266F7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6E1AB534;
	Mon, 14 Oct 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="nuwMvh16"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894C4087C;
	Mon, 14 Oct 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918255; cv=fail; b=G0i+L3qQzysibtUMtWmLw39kCa+dhpG86Ypi0okXWN+aBKFPMVmxzi5ylT0gZarsJT9qTe34+fJsLBz5ydBJrHSSVTV8uAudEI9Gcns7JlvzrWtXQKnXpOPlRlOT4bGDgDEBTdUQOIB+mkPn1euldJp5eooiPkQTVvo3a9FB7uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918255; c=relaxed/simple;
	bh=Rc9SSRtwZ7Qg5KMgjVvJKl43h4maJ3C+B7ucheOIWNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qW0HIxndzzkdR1S+q/HFOcMfPDj55qS4ew0VDaK/OHa8O0H9qKQZxSbAv0f4hPNk3pwNShCVwv9NLTQ8keK+eAclinY3QULDA5byrIhsEqrEGOZjWGfnVi6lF8ICAPPhy9BFwWwoNz8W9VfPnR2UJThxJrqdRYOLje9IMPnhchM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=nuwMvh16; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xH52Rrv7MdCvye5spuLIS8+c7PyuYKsDK7PwSTyV7Kg/af4DdXkeJkXSAC89greVgHijdz4UewYhWmvh3d7RodO6iIS8n88yHMR3QE7+7P7xrBCFi4D6NOR+LkQXIpkWTbuFb8YPDKwmKKUUWuPW2XPwzHTvdOdLjMDRLqBY9ejz6rBK53lHtjjAFBoMFJomUXcedXgYdKaJEBRndw4xDY7rWUqJz4asaOd+D79m/WiNN4UPTucdlq2Ome3RgK+ZMtSFsxZuYwfM79odwoj/unD7n5jf/0V+SiWKMfHCeAnXs3YeyppeZCeowLcdRX9em1+wrNP0ZrQ+wl2kKHKMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADw4O8TUq7eft7Cf9q/P9MOi6LOi9rLNVkrJwCK1B9s=;
 b=P/FoHPS6In1G2PVmXGhAxvwU9jwLdTIk+5AP3kA0EhTpdY2cqZdarhRfzE34jrqFw98H6VHA311b9gxHGY6D301twCPVcf6oscRovAXbSYaBxo17/1uP6fzftfxN/s6e1hSE09kRPMZlk3TFuImefBnwppOouCIE+rP5RrAU7Qp7wY8yH6oeDOhE31wNGu5MXsUAI2vXrsU7hu+IgF7jSwSDM28bT7WWWAYUEyTId/wMWyQOgsmBCgPlsnaUzn2r0d3IvCSbNxFQpwOAK36dMZ+FPGv8Qh4JO2q2vbXuptbHRW5b7YoXRgjG4slmiQruJ7z9nJVzDK8ENVHrBZf20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADw4O8TUq7eft7Cf9q/P9MOi6LOi9rLNVkrJwCK1B9s=;
 b=nuwMvh160FhAp2ojTmlvSM5/cM4Z5OceOc91TJtVlrck1fi2cjjG8z1vop9Op5flAm9fzPqXeZyVmhbWhyqhgW27gVgLL0wjm8eyUfFXgwUiRY6ojOALrbdXv/wIVc6DwajVoPm7vKiMYvdJYjJyy0JiZyPbmso2cNeplji8/N1wlirG95NaE31GVNcQQZghEEyJwFdEwLvP+BBDvEIg8qF5hxqsPubXCy8lvtKmosI3nFQzTApafffvMCHWAZYQHiWk7EDUaxHs8P6QcNFc9/xARPrrO65ZmHq0HCJ0KcBJ/AX8cZ1P6/we4zOZN5XUN6gCXRK/KP6w6fhc35jtcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB7964.eurprd07.prod.outlook.com (2603:10a6:10:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:04:09 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:04:09 +0000
Message-ID: <4a09c9cb-f115-47ef-9088-c1a4d4d50c5b@nokia.com>
Date: Mon, 14 Oct 2024 17:04:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/5] Lock RCU before calling ip6mr_get_table()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
 <CANn89iKFB=T94_wRyND_Z_fGp-Wd9u0EHF_DXg-scQye_tb-Bw@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CANn89iKFB=T94_wRyND_Z_fGp-Wd9u0EHF_DXg-scQye_tb-Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: cad103b0-132c-4c30-e0d6-08dcec6174dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG9nLys4dTlMQU1sMVJGMXNKb0ZhY0dYOUNMZU0xL29jQTE4QitFLzFWQ2k1?=
 =?utf-8?B?M2t0R0V4L29lcmM3cU5xVEhTdnBsSVc0TC9zOUZFZ3N0TElCMWdYYzVoWWpt?=
 =?utf-8?B?ejBsSUxzVXdpRXZnUUFDTGk1U1NYMS92Q1oxQXBrQnJQdXl1Z05ab3cyaHZV?=
 =?utf-8?B?clN4aHAzN1IwbjdSa0V4dURWMUxucDUrbm13dDN5Z2d6ajJXRHFhbzBST2hI?=
 =?utf-8?B?SWVNN0JRTnFsMGVKaEl0a3VjQVRSUXFxVmUwSUFVTXd5UWtnTVcxWjcxdFAr?=
 =?utf-8?B?dkp2VWozR1JMMVk5Zy8yb1hJc0RmdVFUWXkzL0luTFRsRDBjL2cybWd3bHBk?=
 =?utf-8?B?T0xxYnZaek9HOHU5YnVYcnNzdGpJQ3A0VmRxOHRpamExZmN5MEtvV1VlZE1i?=
 =?utf-8?B?aURCYkt6enEyMmlTalRkRjNjU2RteStkNWJSR0pqZGpGME9TODJKTiszOGlw?=
 =?utf-8?B?WnhXZ0hwbmVVMURSdzcvWW5Nc0RVRTE4ZkFXaUVhYnpZVkt2WU1KSGQyaE56?=
 =?utf-8?B?K0lzYWtjODM0bThTd01SN3RrTmdId28wYjV2TjJ5dFFqd1UxKzAralY1WXpp?=
 =?utf-8?B?RTlFeWQwdWpRalJYWmdFcndXR0orVkh0MTVrVU5EcFpGNHBoNzVaRkszc0lp?=
 =?utf-8?B?VFhzWE5TSk9NSXV2QlM2clk3dzY4VERYRDFmdG9LSERNQkZoUm1uSVVzMWZF?=
 =?utf-8?B?VTQ5SWdJMEl3M2wvL0JkMG1DUmNjNXZldXVjRG5FOTN2MXFqamxMdDV4aWtX?=
 =?utf-8?B?TVdYNDJKbWFFa0dHeEFvdE4ycldZQkVGREdLYW9RVFlmRElWU2VoSzFxb2VR?=
 =?utf-8?B?NEpVZTBhUTROWWFnand5Sk5ORDEzeG5tWndvU0tZR3plOGRRUTA0QVN0bU5m?=
 =?utf-8?B?RWlpekhGOFNJWG1NdHVLd0pWeWEwZGxUckk5YTZINVl3alh2MHRrRzJjN3BO?=
 =?utf-8?B?NHlnbDg3WWFpMVgyMC9ZQ0t5NGhNRTFsQ052Yk5pdm5UaStYcFRuUU80eHF4?=
 =?utf-8?B?QVgwVUZvQnZGek53SmliWFFMTG9MT2dhR29nRDVwYXFxTzFWcll5MHFiTm9a?=
 =?utf-8?B?TWVtTjhIY21uK3NVeE9YcU11Tk5wN2FhU3hCRXBpNUlDM2l5ZDBReUlHNEFE?=
 =?utf-8?B?Z2VDNjZHVis1NkNEZDlPaHR6elllOWo1RUtwVlBXaGg1UGhacDhXcXBCckdq?=
 =?utf-8?B?MkdXVW54akhMSWRaNWQ5U0xqNWJuL1dyUm9zclQzeTJnbHFtamoyaXBPeU9n?=
 =?utf-8?B?NUtDVW9LZVJOcXJmMUg3VWxmbjIwYk9CVm9tWFJDQ1RhUGFLTjk4T29tOFBS?=
 =?utf-8?B?VnBGMlVwWVd5TEdYV0dXaU1kdVhrVC94VU0xQ1hrNks0UWRFWE5kL2lQd1JD?=
 =?utf-8?B?WFVpeTR1RENhalpqZVJUUDNDSUVsRDFoRGk0d25YYzZKWnRkdXIxRjM4SmFQ?=
 =?utf-8?B?UDNJclVJVEZlQXU1UFhuaTRzN2cxOXNZUnVLZXN4Y0xCKytsNTgxRlNzdk4z?=
 =?utf-8?B?blg1TFd6WUpQTjdQVFZPaFBLMWdoWlRiTVBZYWY3S1hHZVIzMnh6WGQ2NS9K?=
 =?utf-8?B?VG02UnhWZG1zUlIxSnJrQXNobHUxYzlFSXYwT09DUFhCdmx2V1lMMGNVb0w0?=
 =?utf-8?B?WDM3Szg1THNLQ2ozOHYzTFo4MWc0NkFXZnJuL280Skdua3FZNU1uNTREWDlH?=
 =?utf-8?B?bGpBM1haU1FnZmlkVmFpRllTeThHaGlzQWdGeGZxRURtZmh6djhYZmdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2NHdjdueStqaXR0RHcxWDZ0THNmdEZBSmVZajV4QzFXQUs3WjdDTlRJZFp6?=
 =?utf-8?B?RGg4WTlCdVN6YnNTTlliNUV3Ym1ENlRSK216L1NjYTNIVnlQVEhjKzFoajEz?=
 =?utf-8?B?QitXRE1Rb2hZRmtDSnMwd1REZ0U5RVJZUTcrakFTbkI4enlTUlRaL2pFb1JG?=
 =?utf-8?B?TUFPcHFMUXA4V0xDQmRPNGRKa3pDeDVkNHhrRmZ4VXRMSGZCWis1NmNDR2xX?=
 =?utf-8?B?Y0grSlZ0d00yczZYczNsMUFyN3pyMVJ3djBjTVV6RWUwd0ZxdzJIMXZ5bU1o?=
 =?utf-8?B?SDN1eXoxby9RUlp0YVd5RXFjSlg5cVV3azl4WEJjUFFDSHIxZDhCMlF2RzZO?=
 =?utf-8?B?L2xWQVNJaXVBT1RFS0VjOWF5bVRrQTY1TTNkaHMzNTU5cWN6VitPZnJ1NFNN?=
 =?utf-8?B?WWNIaS9LNVBCYnJhNnpHUE9ENXprcm5wdWtrUy9QWExNdjNiL1lHSktiakJC?=
 =?utf-8?B?MFNuQ0dtVFBBOGlRWW5wRnM2QUtnSTJWNXI5WUhERE90T3Z4dE9GVFh3eUt6?=
 =?utf-8?B?Z0twb2YraU5xSThZQS8yNHc2SG94SWFIdDlPeGJWdXNDYkgrYTdSV0wvNGJl?=
 =?utf-8?B?R01GTVN4emVPWHNUSU5PaSt3aHNuV01nRUF0blp6MVkwOU9FNmdKNmRvRysw?=
 =?utf-8?B?azRwWm9maWd1TURMY1hxc2IrNE9ZYWVnbklsc1ZXQjdIQ1d0d2pWRGZzVGo2?=
 =?utf-8?B?Q3lmZWw3R21GeGd4eFREZFpvUEpkY2w4UHllM2luaU9Kd2RhSndSYXg5YUFi?=
 =?utf-8?B?WnRqRVFTVWZuOEFHSGYwMEF5Y2Q2WE5lcmJJUDNzR2NMSFNPaGhHSEtTSzhN?=
 =?utf-8?B?aVZzNTZ1UVhISGJ3ZytZZjRjR1hxK0xFNjBXNUdGdTZHdTM1SU9JRUcrbmhv?=
 =?utf-8?B?OWVtOVVCSlY3c24rdUJiVURwalpLeVpwRFBxUGgrWTNNT1dCd0RHM1I2Q0dw?=
 =?utf-8?B?REg0d1liOTRpdjdRQkdQeEZUTG9rdENUR0hOeEZibEFpRGtMWEowYXphTHdE?=
 =?utf-8?B?cjR6VTFDRC85bzdNb083UHl0Mjh5cUNla0tZMVRsMVFSL0RlWmFWdExSZEFE?=
 =?utf-8?B?YnZUdDNpNU1qSGVzckExWGNRY0dBRERkNURxZ04vQU9pNUdodHNFNU9tOW5w?=
 =?utf-8?B?a3RuTzR4OGlPNFNhVmpPQW8yWG91ODE4QzU1U1lJNlJMc0pEV04zbTBWUWor?=
 =?utf-8?B?dTFHQ05jSzIzRStLQU5BSWZGUFViZHhwaktWbDF2SHlOTjdNR1NGUTdJTWFk?=
 =?utf-8?B?dlV4NnBCMG9DTmVUMUZOajJOcU1iOHpPS2w2OW9iaTU3S0p0UjlmV0hYM29S?=
 =?utf-8?B?Q2RRUkh6YTBLSUpXOE9sMG5XYXpISThDU2hQQ0IvdzZaVUtWazlwSHVmQ3Ay?=
 =?utf-8?B?WWVSdHVieVdWSkJtbWxaTjI0cVBkNm5lcEhsT3BvSld5b2Fwa1hQSVhJS01T?=
 =?utf-8?B?UmlFNk4vTGZOTllicTgwbExHNlBRaDN4dk9TNTV1MmdrS0dHV2t1Mmc4eTZK?=
 =?utf-8?B?cDdDOE5CVXJ3Y1NBSXlkeWQ4enkzbGFqZmlKdzdBbE02VW0vckFya01BamN6?=
 =?utf-8?B?OTF3bUJQM05DZkpsRjBjZHhQWVErK25NR0QvY3BMME1GbTJJQmN6Y29VVzM3?=
 =?utf-8?B?Z0p6Rmd6QXhQWVVWTlcxeDdNVG5uSHBkaWUzenIySU5jd2lPVWRsa0RUWXV6?=
 =?utf-8?B?VGdmQ2RSeEdjVWxvUjNyREQ5UCtLYm05alZpeFF1UmhNTW10czh3Q0ZNbUJm?=
 =?utf-8?B?aHR3dkhlYmU1c2hiTW5jVEpaYWN0WVRMZFgzNyt1eEl4S2JieVpNOUZPQmRr?=
 =?utf-8?B?ZkJrSzU0bFI2NjVzY3R1SEVTUkxsRUFpKzJTMTY0Z0M3a1QwbUhlQ2YwSk5X?=
 =?utf-8?B?S3kyQm1iM3VSZ0NESmVzYmJ4NXVsS0tidXFmbG9BNWRvZGFmbEg0WGZiRzc2?=
 =?utf-8?B?UU5hR1RDYmdVUnV4dUFXeU1PWFpNTGdBYmNUZWdjN1YybUYzQjBlSm5RdGww?=
 =?utf-8?B?MWRJQXNFMk1Nc3kxeXZqYWF6U3Bma2tRTFJwRFY0bVE3N2cwNWZKbXJPN1dp?=
 =?utf-8?B?cWI2NlVJd1hVOVVlTmRhREF6WEF5K1hUNE9BS2ZxeHlsaC9XVmNYSFFWQTAy?=
 =?utf-8?B?eHBiNWNWa3luU3JKMHU3QUpNZjJPUjcwamNKb3NVQ1ZCb0MrRWNta0tLSkRU?=
 =?utf-8?B?UzVFWTlCOVEzVU9pT203TkpGVlgxVlpGQ1N1dklnUzZjN0paQ1ZaUG9Heml4?=
 =?utf-8?B?VTMvV2g3STJPTStQT3gvN01aU0ZRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad103b0-132c-4c30-e0d6-08dcec6174dc
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:04:09.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T14zJ6fjmRx+A3nmmg+u8viX1tLVpS+CKxNIqVQh2W32dBeJ2Sk0kG86M41GAM2k4qZJjuFbq6CzcqDafc+5tU8Kv8mfjaoBuY7WQ+mtv2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7964

> Hi Stefan. I think a v5 is needed :)
> 
> Please double check your syslog
> 
> [   18.149447] =============================
> [   18.149471] WARNING: suspicious RCU usage
> [   18.149649] 6.12.0-rc2-virtme #1155 Not tainted
> [   18.149726] -----------------------------
> [   18.149747] net/ipv6/ip6mr.c:131 RCU-list traversed in non-reader section!!
> [   18.149792]
> other info that might help us debug this:
> 
> [   18.149824]
> rcu_scheduler_active = 2, debug_locks = 1
> [   18.150050] 1 lock held by swapper/0/1:
> [   18.150090] #0: ffffffff95b36390 (pernet_ops_rwsem){+.+.}-{3:3},
> at: register_pernet_subsys (net/core/net_namespace.c:1356)
> [   18.151482]
> stack backtrace:
> [   18.151716] CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.12.0-rc2-virtme #1155
> [   18.151809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   18.151982] Call Trace:
> [   18.152122]  <TASK>
> [   18.152411] dump_stack_lvl (lib/dump_stack.c:123)
> [   18.152411] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
> [   18.152411] ip6mr_get_table (net/ipv6/ip6mr.c:131 (discriminator 9))
> [   18.152411] ip6mr_net_init (net/ipv6/ip6mr.c:384
> net/ipv6/ip6mr.c:238 net/ipv6/ip6mr.c:1317 net/ipv6/ip6mr.c:1309)
> [   18.152411] ops_init (net/core/net_namespace.c:139)
> [   18.152411] register_pernet_operations
> (net/core/net_namespace.c:1239 net/core/net_namespace.c:1315)
> [   18.152411] register_pernet_subsys (net/core/net_namespace.c:1357)
> [   18.152411] ip6_mr_init (net/ipv6/ip6mr.c:1379)
> [   18.152411] inet6_init (net/ipv6/af_inet6.c:1137)
> [   18.152411] ? __pfx_inet6_init (net/ipv6/af_inet6.c:1076)
> [   18.152411] do_one_initcall (init/main.c:1269)
> [   18.152411] ? _raw_spin_unlock_irqrestore
> (./arch/x86/include/asm/irqflags.h:42
> ./arch/x86/include/asm/irqflags.h:97
> ./arch/x86/include/asm/irqflags.h:155
> ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> [   18.152411] kernel_init_freeable (init/main.c:1330 (discriminator
> 1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator
> 1) init/main.c:1580 (discriminator 1))
> [   18.152411] ? __pfx_kernel_init (init/main.c:1461)
> [   18.152411] kernel_init (init/main.c:1471)
> [   18.152411] ret_from_fork (arch/x86/kernel/process.c:153)
> [   18.152411] ? __pfx_kernel_init (init/main.c:1461)
> [   18.152411] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> [   18.152411]  </TASK>

Thanks, I'm not sure why I missed that one since it also shows up on our v6.1-based kernel.

I went through all the remaining calls of ip6mr_get_table() in ip6mr.c (since
I've picked this topic up from a colleague):

- call in ip6mr_rule_action is safe because fib_rules_lookup() holds RCU lock
- call in ipmr_mfc_seq_start() needs to be in RCU read-side critical section as well
- calls in ip6mr_rtm_(set|get)sockopt() need to be in RCU read-side critical section as well
- call in ip6mr_rtm_getroute() needs to hold RCU read lock earlier as well
- call in ip6mr_rtm_dumproute() is safe because rtnl_register_internal() holds the RTNL lock

I'll prepare a v5; please carefully review as I'm not familar with the codebase...

