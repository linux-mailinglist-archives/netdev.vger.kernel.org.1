Return-Path: <netdev+bounces-220851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307FB49230
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0143A81CC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED030C62E;
	Mon,  8 Sep 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="5PrR3yY5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A1221DB1;
	Mon,  8 Sep 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343549; cv=fail; b=ILRPRrL1Ah0j8Nl+LlJS5TBSDgoN90DGeF+WMPnX8WvabIfwzcDHum51lYUhqb6V1KYzQJANzMnzCf+mifN0tXxtDXBahsUm0+dYX6n0/KVsYettlH1J3mqsYHL/DAg7GoanhX5ih5RZeK5va45NZVqi6CNMKhcTP93NmRreZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343549; c=relaxed/simple;
	bh=rf/fzuBgV9o7Ar99e6EcMUiEcXdU99ofxdYBTSKhkNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UiJqR3uUxJULNhf7eYwj6njs+XxKcKSo29kbzMhBjnP6wQmUFxk67aa5/L7ESAJNcQmTM8k+eT90ylZPySk4V1cmt/nbO/9ElrueEdJhDahXbX5a4eGxO8jXik1n4gYQdvQFmGn44aSNrEFzwT5UNc415IqZLTJmQsIfpxuRo6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=5PrR3yY5 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvxjDLmsl0pOpIaJiSxrI4kc0sw/m3I6CyxI4APp6WcYx23odJHu6VHdpEcd3dQSffsiP3d16NOCj65SVpasS2GJIF+/ppBIMSlqxsDV+uQxba3Xx0Drzoi1ISTNvGMTgYtpMPax1wfXRGfbq/J6oux/5aDSGypwwRZjFm90axt6I4tx1P7OvNLFgwX5P5/7WBGRyUQX6OJMPF0e2QDvLd/Vh4ZkeXQTtbFSaAMZPDXON4KoGN/tlBpOfgXFIa0GfkBwO0H0aWodQ0JiIiluidtXHCAfidqpuMWXTelqf4bDgM9W7v6sNkckwGsr38/v5OlMnxH6nUvZD9uMDgTb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zg+H0aVEsm+t8rJVzude0IuXSgq6ug3VHjk5W29r84=;
 b=UTuRyd0YWqUq3neuQoNl4AeJo8SyUCydUVJ+HpMvlWN5ZmYgk+g4sgx2u4Q2IHpKLD8+jizdUDAt8G1cZ5rKlfV9+ZOPVxYbKqxD8ktYpRfAcJ7v6tg4UgXFzSMyqwZdqbAGS/zxlzmfozzPjc+CW5Q0M5SEd8LYp09J68JsU1L9AQMawdZxTqY+r2Tsw3UMeeJ0NATCTItay2/+94EFdDKNZEJDAODzY+gP1S5xHDnbi+ZKh5q3XFqeVUUOdCvRJlzkTS3UmJJXLn0E6NrU3U5Tx4DOCH9byF2EovqpWBWRn9ioo89Kd7mYWmpq1n+QhHzgh+aEP84BGlonV0uM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zg+H0aVEsm+t8rJVzude0IuXSgq6ug3VHjk5W29r84=;
 b=5PrR3yY5Tvi3bHWenNXhCtw4Jmzl+hSIRYbCi2FIYjmTpD4OpMKa/7jcBjczF+bMO++5JN/rxj1OV4pOjavfhYghsKBtutG/c9GDYZ2SjWkKnE8bR0ZCUZkRCt9jlf7jWe6sp2gTrZbjONV6n3tlY/6xjb9MEXpsW0mmtFuGF2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ2PR01MB8206.prod.exchangelabs.com (2603:10b6:a03:545::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 14:58:58 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 14:58:58 +0000
Message-ID: <1ec0cb87-463c-4321-a1c7-05f120c607aa@amperemail.onmicrosoft.com>
Date: Mon, 8 Sep 2025 10:58:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: Sudeep Holla <sudeep.holla@arm.com>, admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::26) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ2PR01MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: ca322507-4bb7-489c-54ec-08ddeee83d22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVkzVzhucUtFNnVqWkg4dzI4bkpXYm9nU0dQT2tacE1sRy9OSFc1c0pBbVhY?=
 =?utf-8?B?V2VzNEVCcXpJQ2RBVDFmZlhMa3NtMW5zTzFVN3ZRZWw2WERCV3lnZlRjMDZX?=
 =?utf-8?B?c2Q2L3BtYzZwanNCWVNCTExndXJKTm52RXdySWZlZ3B0ei9makFPREIzZW9M?=
 =?utf-8?B?QnAwZFpmOE84NGRvOC9RQ2ErblcxL2phdERZTkFCc0hjUk9neVNaM0VyZmdV?=
 =?utf-8?B?TDZQY1JYZDF3ZzgrNFhpbFhqZTNjeGIwTi9lVGROMDlrZnpZNUxXcXlVdTlr?=
 =?utf-8?B?MmhSK250ckM5RlZpK240aE1hcTN4SlZreUdlVTJJdjF2UGx1YzVFS3Rhd1ly?=
 =?utf-8?B?MWVMSmNFZmladW1GS2RYV1BxckJEbFhyQVBkRkFIVG9sVE9TNDZkMUEvcnEw?=
 =?utf-8?B?d3k2d0VmT0thVUpOSmx2NHFHcjl0VkFIQ3RRMElmbEJ0OHZBYkM0Q0R0dzNp?=
 =?utf-8?B?TkNZcjdNVHZBeFgyT1dTbDUyemZzMFIzd1RVTFh2RGkrZFkxdDNJeHNMTUk2?=
 =?utf-8?B?dHYzNTRqb3JrU2x3d0FWUjJ2RERlMUFoYUR4L0ZzVG5ZYlFscENCcTFRbWI3?=
 =?utf-8?B?M2tGelNJNnFSS0t1WkRPYjR5S2NPeEZ2Ull3NTBiZjhrR3ZORnRlZHBTUTRx?=
 =?utf-8?B?UkJIRHVkSGEzd3lKb0VGUUZpMGNldlJQRS9sNkdDR3RtREp4ZzhPSVFLVFo4?=
 =?utf-8?B?cjlqaTBIdFZ6Wm9xaUtlVS9aZGlpRlZjOU9MTHA5Ui9TRU5nTG5QL1FZV1pO?=
 =?utf-8?B?ZGFPYTlzNGlhcllzVDh5MlF2bTVtTGFvL0V3U3pVL3U1UXFFKzlCZEdKN3Nt?=
 =?utf-8?B?RXdhZVhLVzVhZmV2RXNwU3dwbndTdG9ITjdqMDVMaVhDcWhaT2MvSTJjZGRy?=
 =?utf-8?B?WEI0NXU3ODFNTU5DMUtmWENxNkduaUJHdE0yRWg1UTJZcUVLSVlucXFBNFIz?=
 =?utf-8?B?RlBLOE5RRHZmaDkwaEtTMElnRXhXVUFQT0ZmaG9GSDE0RXh5ME1udnZXbTAy?=
 =?utf-8?B?WXg3TXRNdzltMmJVNTc0NUtFMkpvY3NjT2lPLzhnZnU2MVNIam1EQ2JZelli?=
 =?utf-8?B?QWhweFRpdHU5Z2lMTXdhajJjMzZqdGtieThXNWFKSWZzL3VLMGJFTXdUdUFR?=
 =?utf-8?B?STd4ems4NUtCL2luZEM0RllVL24weDdHMVNPK1VFTFNvVW1MZnVMcHZYbVFK?=
 =?utf-8?B?anY2ZjliVFVUcExEUGdkM3NDeTQ5SlVOWkJITTA2YzZsTWJDM2lzWXUxZDBk?=
 =?utf-8?B?RWEzU01lT3RwQU94SGlNK01rSHBEbHdDYmVnSnNDSnBCV1Z0ZExhUVNSSmgr?=
 =?utf-8?B?QmdZclNpK2NjMkFERitvcFBibzJZZm83QjhtbE41NEYrUGs0eW14SEVCRGZt?=
 =?utf-8?B?OE9WZjF2MFJIQitRNEMzUHZiajhsSHhBeVZiTDVBWkpMWWQwdWN3bzJ1Y0w5?=
 =?utf-8?B?eUZXblUvRmd4TUwxeEh5OFlBNDY4ay9hWVQvWDY4UU1wMlM2bWpNeEcvSVU4?=
 =?utf-8?B?Y3ljbG1TZVRUU3BjOE51ZHlseHRzMGxCWlJsTjlUQ2R3MitBUXc4a1EwMzFQ?=
 =?utf-8?B?Y3dnVE52ZkV3MTlQc2VlcE1kMFR5V0pXSWtFWmdZbXR5NWR3SCtwendTb0Vk?=
 =?utf-8?B?MCswSnFrVlRacWR6eGM1dHVGWlA4U1VKYTlyN1lwNFY5S0V5V2FMT0hyN2h4?=
 =?utf-8?B?T1NyZUZMdjU3SzkwVjJaS21rc1lOcE1SejBhTXVaVHBicWdISnc2VHY3Y0I1?=
 =?utf-8?B?ODQ2UitVekZPWHBXQmRoMGlyS1hTWHAxTDFEY01iSnNoOGNBZzNmcnAzeTJ2?=
 =?utf-8?B?NHEydjNYL0RvdUJqWTJoRkNHeHB0ZXN6UE9TMStsU0liWUNsWS9qT1Rsa2lV?=
 =?utf-8?B?c3IyNHp5RzkydU0rQkJzME5ncEdtREdIYThrdjRldVZoQU54dDlsb0dtWnpT?=
 =?utf-8?Q?Uf13jD4EPyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGNLbHkvaXN3RWMvaUZXRXVyNy9TdFdQRzRwcXVZMDJ4S1N3bkQrTEVpcm1P?=
 =?utf-8?B?alhCbTc1MEd6YXhTRzBDdnpJdWhBLzZpcWIzcXZpWG1jL2ZmUmNQSkRuRVZy?=
 =?utf-8?B?cE1PVnRRK2Q3RERTbVV2NXpTWklQV3N4NVJBZ1NaRnNaSmJHZGpQeWFMY0du?=
 =?utf-8?B?U2cwTFRibyttUUdoRU1CVmJDM2I2QTVvZG1UYTV6ZDRSNnk1ekN0QlNNOXIy?=
 =?utf-8?B?ajA5b0VXeDZpS1kzcHc0MnludzlEOWdhZTJYYmpTWVRYOXZmVEtobFhGZjdz?=
 =?utf-8?B?ckJ6aXNmTHRLbUFXbVBrUkR4TVd0Wi9oTmNIaWhOZzdxUHpXaEJ5dlRGeUJJ?=
 =?utf-8?B?Tm5GOFhiS2ZzeFBTdnZWcW5oeG1vRi9oWUNXT2NLTGQydDZjSTJhYnJMNlho?=
 =?utf-8?B?NUNGVms3dU9PRng1eE12dHNSeUFUWEF2ZFN3NGdQbnRBN00vZ2dpZnkwbHU4?=
 =?utf-8?B?VmJMU21kc3pTbTIwZWxZUGpnL2pTY1dHcTF2ZTVXb0FWd054ZitTTm9ZQW9k?=
 =?utf-8?B?azRuTUZncngxYU5HTzFPQnFtTFBROG1RSEFwb0ZUWVpKelM3ZUQyUDFXNlR0?=
 =?utf-8?B?ZnBSZkUzQW4yNlpLNjlwR3JPVlFzQ2JUUHJXS1RnaDlPMVV1bElYc3lwYkRi?=
 =?utf-8?B?ZkN6c2x0eVlad2VyM3Q4UnZoWWtDVmVvV0VsVGFkV3RESGViRXhyU2tSYjBI?=
 =?utf-8?B?VWIzVE5ZUjdBQ1NURkorWndzRHhrcjNkZDlsenNnTmxpSm9uSjVtQkNSZ2dn?=
 =?utf-8?B?RG9ZVjhYRnBrOVAzOWZtNFRoSXNYa2FSRUdUK0RqZkpkZGpjTlZEUjdGM2Zy?=
 =?utf-8?B?eWdoVDJFQUxPejdCcDJ6ek10OU5jTmpIT0E0QitzZUtkL092dnBJbnFtRnZD?=
 =?utf-8?B?eG1IQVd6M1ROZFdRVlNwMjdqWlprTkdHZnN3alBLU0JPaFV3YU55SnFUNmhT?=
 =?utf-8?B?T2cxeFV5bW80WklYRmxQZGVvY3ZMU2I1dHZKNGl4NXRWWVgrN05JTTNvazNF?=
 =?utf-8?B?OVlGRTIweGppRkZEVGt3ekI1V05jbzRzdTUyVFNpMEdOS2JWNVF2ajBuSStv?=
 =?utf-8?B?Mmc4RCtjcnE4RUpoWjhmMkFRQ0xGaG1lWFYwRGlJeFBtNmQzUk5XVFRyRVIz?=
 =?utf-8?B?b1dQVUFzQXA1VGVFQ29yNmVmZEZXVTdzcm81YXhkQnpIMmNwQUxoOE0ybS92?=
 =?utf-8?B?TWF6dW80VzYxM2RJYWF3bUpuMW5qMXJjT3hWTFVKLzN0SmRtK1JsV2pmQ3FK?=
 =?utf-8?B?eXZuclhqV0lVYUpjQjh1TGpGaWNOZkZmNlA2Q05sdGMzcCtaLzVjbDJWYWta?=
 =?utf-8?B?bVpIcXJ0eFhzUU5CTFJaMkRCc3VsN3prNUd4MDY3OHpFTWQwdDNIblBjZG9s?=
 =?utf-8?B?SDd1d1NmZVZPZDNRMzFRamozYjZsbjFHUEQ2SkhSajNBTVJEcXdPNVh0N1Y2?=
 =?utf-8?B?c1c0M1NwQVQyMGwxOW81TVVORUZwMTZiZU9Gc2FjVy9GTENQam5LalMxcWxw?=
 =?utf-8?B?OTJWQlRXSzU4RTBOKzZQMkpzYVErNytuWE9Id2I1VjV2cTlpU2RqUWlPMEcv?=
 =?utf-8?B?WHhEY1hQKzJBM1g5Z2RXQTlxWUs5MTRRTm11OEExL202WEtxL1RHeWxTUzJP?=
 =?utf-8?B?V0FUY0JNeFVTN0p5K3A1OFNZMzExN096YkJGbUFGREJPeVdpUVdaUHVRRDBw?=
 =?utf-8?B?bG52dEExOE1lVm5mZzA1TG1wb2d0SjJYYWNzRmN4a2VWcGdHb2lNRUQwcTlk?=
 =?utf-8?B?SVZ5eWVFdi9IWWkwNndMTzBzTkFzZWYvWnEzWnduUU1hOWN3eGp3ajRJNThh?=
 =?utf-8?B?Mk5JR3pFNE8xZUNTZVlUYWdUYitEM25HdXB3VlVuNVN0RStPRUpEUHVmT3kw?=
 =?utf-8?B?Q1RXQmZwOW9iYXBDT2hqUE1XWUVwY1dBRkNncTQ3Q2tld01mNVhkbjUwV0lt?=
 =?utf-8?B?RlozSWR6TlhvaXlpeHl3OWQyZGIzRStadktHN2NPMUxybEc1ZWw5U25TN2hQ?=
 =?utf-8?B?d20wSW1yUkR6dDhSNm5OQlZrZndlMjQxZ2dmbXgvalh4bEZHZlVsTVVsMVF2?=
 =?utf-8?B?R1BRWVh2b1gxOFJoOUowV3dBSld0VEdIYkJpSVZRSHRqajl1S0ZrK1c1NmlI?=
 =?utf-8?B?ZjR4M3ZIUWdxV1RudXY2VDNqeGlIYjc3TzB0SmlWTy9ERllSQWhLZDJmYTYz?=
 =?utf-8?B?VmRZOG8rakpCcWVDSGpWMGJwRTN3WTF3d1RkMkxmT094QS9oQXVqM09EUDJW?=
 =?utf-8?Q?W6MyTLDyahePgKYqOtiKLeewzHsLWHrFeCMtjwvNZk=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca322507-4bb7-489c-54ec-08ddeee83d22
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:58:58.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62LqlAnx27KvaZPIFmYLHMrcsOYoFkKLmxkLu4uJghJ7BKwh+A/HVX2z08DHgnb7xKA2oZDC+GbhJumOzTRC/a10n+5vlnqW9jLAxwtOjaoq3Vz5biZjt9NUcoYhc/eq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8206


On 9/4/25 07:00, Sudeep Holla wrote:
> On Mon, Jul 14, 2025 at 08:10:07PM -0400,admiyo@os.amperecomputing.com wrote:
>> From: Adam Young<admiyo@os.amperecomputing.com>
>>
>> Define a new, optional, callback that allows the driver to
>> specify how the return data buffer is allocated.  If that callback
>> is set,  mailbox/pcc.c is now responsible for reading from and
>> writing to the PCC shared buffer.
>>
>> This also allows for proper checks of the Commnand complete flag
>> between the PCC sender and receiver.
>>
>> For Type 4 channels, initialize the command complete flag prior
>> to accepting messages.
>>
>> Since the mailbox does not know what memory allocation scheme
>> to use for response messages, the client now has an optional
>> callback that allows it to allocate the buffer for a response
>> message.
>>
>> When an outbound message is written to the buffer, the mailbox
>> checks for the flag indicating the client wants an tx complete
>> notification via IRQ.  Upon receipt of the interrupt It will
>> pair it with the outgoing message. The expected use is to
>> free the kernel memory buffer for the previous outgoing message.
>>
> I know this is merged. Based on the discussions here, I may send a revert
> to this as I don't think it is correct.

Have you decided what to do?  The MCTP over PCC driver depends on the 
behavior in this patch. If you do revert, I will need a path forward.

Based on other code review feed back, I need to make an additional 
change:  the rx_alloc callback function needs to be atomically set, and 
thus needs to move to the mailbox API.  There it will pair with the 
prepare transaction function.  It is a small change, but I expect some 
feedback from the mailbox maintainers.

I know all of the other drivers that use the PCC mailbox currently do 
direct management of the shared buffer.  I suspect that is the biggest 
change that is causing you concern.  Are you OK with maintaining a 
mailbox-managed path to buffer management as well?  I think it will be 
beneficial to other drivers in the long run.


