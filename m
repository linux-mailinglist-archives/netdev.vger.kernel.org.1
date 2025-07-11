Return-Path: <netdev+bounces-206260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BFB0258D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 22:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3F586DA1
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C151DE2CC;
	Fri, 11 Jul 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="lJhylWDx"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C7A32;
	Fri, 11 Jul 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264241; cv=fail; b=YyIxByXu8L3vzq3WdHz+jYqRk5SL1pO0PR+AJB5K+hfOPh9gtsheEZjihEoyg50S/UOJpH5HfAId3MC35LztSPVHeOtR7Y7zFEg3Lnl/MklOn0js49BxSuQB88gfFaL//9UzHyzF3PY589sClrH9KHVsvjXRz8L2/Biw84Iq5AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264241; c=relaxed/simple;
	bh=DFvMAXA9msfjV8ijrqgPeg+R+UeTQIKoZ6SOfq6+Bw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ffhmZJSZVTV9MXE1kKHIldy1jC0tOkYi9GeRUuBR55xoEsneEbcReDvIaKb6cBU735JKJJQPpZwd4Q908YgaIGlnekS7d4ZbwqhjNZkSJE3WJVMOE9fZr7pw8+0JLsF37vn3siy/CeA5975lrTG16w2ZlFHe23fjflS5te6kYjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=lJhylWDx reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.43.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcrbOmTQOksLly+8EhIgn5VW/21YBjEqJEi1dUpTnhW/jPfIniVulaVv3DhQtlNmUxGBjToCpttIwPX+AgHXPcd4fyMOjYDN9v2P8QL0C30IIZTLcLIFtDntoIfV9DjP9bkh3JA1h1vrGzuQW+o+Yk0JMYIAyiMqb2zXoQdcODflVRTbXsGPy+Gr0mN1LecCDnA73h7gKwJzdoQ1GSoY23Oi7guBVmp0NjmropIhRVqzR74K/nZ9SoDpbEHKJPBWWIZ5c8YLGDH31AZtHqkMWYjcnrXSGEBgl8rC7eWgkFsXLe9zCQUZ6T3pnS5ZsTLR1s6EyZdHOC4AzOVRSsIP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/ksV3ZTbai/dOJ5zGicsrPbFs7dwly7VSrJN/snTLc=;
 b=MFEi5utdnsmmmzg2PR04gQBzW05aSkdJHO1VTRG3ZY/0NODNy5EFw31RkBF9K9tenW53E1h3qQ2uks5L0HnCKS8+l/8noIOPJbze/YYpee1fdR2n7MXIoAcp03mAcYrtEeSAyrRjZnVP/fkGg4nCRVS63+s1mx8+hR9u1fh0cdGUWUd62QVy7l8z2BMh1Xf3v/vPddqMOrQqUbGjZZCEkXwltWBBJVeEgKQq0uNfflwqzw7+MzwsbV8RjB0DHhpB9wgtBTsQzj9YTF90a2ADrV7e2ceK7H6PbqgXjv2HMsiHLoV1SeQFIJdPD/qet85XgCP/rSAfYVpAJ62NsPyb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/ksV3ZTbai/dOJ5zGicsrPbFs7dwly7VSrJN/snTLc=;
 b=lJhylWDxHrSvIfiIUEkIfMWXf0Wl1gY6A7ctVOJ0SeYqnNsclP59SznxM0XmiZqh8jasQkaNo4swLjam3XF7pWuVNpvRBY/KjiW3io5Qn2CErw4wnbdxRhEOoU7o9mUQogieUUIgrhwDEMBj0iv2xsuK5kvH017Qa1QBNfBvJNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BY1PR01MB8681.prod.exchangelabs.com (2603:10b6:a03:5aa::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Fri, 11 Jul 2025 20:03:54 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 20:03:54 +0000
Message-ID: <30bcce6d-9a50-4fb8-ab7c-8ae36eb99d74@amperemail.onmicrosoft.com>
Date: Fri, 11 Jul 2025 16:03:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 2/2] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250710191209.737167-1-admiyo@os.amperecomputing.com>
 <20250710191209.737167-3-admiyo@os.amperecomputing.com>
 <e64da89fdd2c72afaa62f02449db9b144e02b743.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <e64da89fdd2c72afaa62f02449db9b144e02b743.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:802:21::23) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BY1PR01MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdf9067-7f87-434a-ee2c-08ddc0b61031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bExZOXhvVEpDWkZDMVZIejVDamN4K0hYWUZrZXBoQmtGQlR4TFAwWVo4RGxz?=
 =?utf-8?B?YzZKTkd2WGduT0MySXkrbXZMUXgxSWxaNExsZmN0bDl0bm1YWUg0WnNaQ2ti?=
 =?utf-8?B?V1JwTjlWMEVwTWM3dEhvNkdSclJpRmpOckQ5bUpCZEh0NndTL1VGNHBCNzJz?=
 =?utf-8?B?QXVHOGpZZytHQkZ3V214ZlQxL2dyK2tlbnI5TkRxc0VYeVZJT2hCb3BJQXFO?=
 =?utf-8?B?SFZVKzBMa0JaVmFkRWU5NWRIRkQrU0pKMkJnM1BGSGt5dThYWnZBRCtMUUQv?=
 =?utf-8?B?Qmt1TGplT1JBYmRKdERvcFNRc3lvYVRobGJJSnVFZFA2SkQxVkVkVm1tUVJo?=
 =?utf-8?B?V3JzTGhWeGdsSWNQYTUwTjc4OFpmVlRLbmUvaEh6d2xWdkV5MGlINjRCTi9z?=
 =?utf-8?B?WFdHMmxiVk85ZjcxYUNxZ0lqVzd2QUVkN3RLMTJINzZqSk5QWFlQK09KRUNK?=
 =?utf-8?B?OVJpK3JZNDk1UEtjeDY2MTRuOHdlVlROYVlqT080b1gxYmdIbUg0dEFwblN5?=
 =?utf-8?B?cXgzOEZ4ZDlPUHZLUFM5VUZ5UkN3UXVlU2w1bDhHM2N2U254c2NKaDFtZVFJ?=
 =?utf-8?B?ektlOSt3TVdNWEFIZDFHOUFvVUpSaG1pSHNSU0dERFNtKzhzUGFMdVJaTGxi?=
 =?utf-8?B?REsxWlRPNXFSQkdzckZXdWNmeVlMclNQbEp6d3dYUXdZV200ZVdxYVh5YWNq?=
 =?utf-8?B?RXZuZ3NrODhsME9oaEwrU3lNdkphZTBvT2RJa0kwcEpQMVJ1ZXVTeENiNC9V?=
 =?utf-8?B?dEl5ZkZqNm9BTTNrbGpHRk40bEVNVFdubGtVc3hIemU0Y3lWWXFvRmw1b0VW?=
 =?utf-8?B?V09qakkwMlJZNm5EajZsZEJ6WUJjRFYyYk1JV2hSbFRjaU11TTRoNDJNdStl?=
 =?utf-8?B?VDhWU1NmcUFsTTFaVUYxenM2VkQ5RG9jS3lKOTB4Q09IdGVTT0t3NFgvZTdv?=
 =?utf-8?B?T0ZSVjZaY2xkeXh1eUFtK1BUa2ViMnhQdFozZTJPVThvZGxtUGNaWTRCQm9I?=
 =?utf-8?B?TldOMUlndGJTeVlveG03aTdObjdPQTg0SzFOYzFrR0NFeW9EbVlaelBhQW80?=
 =?utf-8?B?T25XdHpmWktZQzFUVnVmclVvUUhTUktzVEhhZFBsd2wwRElNUzJ5VDk3OTlq?=
 =?utf-8?B?cEVQZjVndHBoSUh1K0dWMy8vNmVGSFBUcVM3eVFraUZOcUdrTmVZOUh2eTNl?=
 =?utf-8?B?NmFTa3hGNzRPY29ZZzB4SDNpNFdxa2xTVytmVE95ZHcweitYTkJlMVRJdDR4?=
 =?utf-8?B?My9kNVZOelo5QVBLaTNqeGo5Yi9YeStzRXFZTnlwMFJuZEF1QkhsWEhLUXkz?=
 =?utf-8?B?cGhXejBJZnZXWHB6K3B2QU5JTmplSERiV1ZGalNIYkk2Z2dsaFJYUHpLdXVo?=
 =?utf-8?B?Z25mdXEwK2Z0eCt4N3lsdWdPMFBkemxwb2dRVnRHazFVQmlXbkJCRVk5akNS?=
 =?utf-8?B?bm9NTU5Oa1lwNlg5ekkxc1d0ZS9wTkxPQTFBOCtUMFQvWmxId3BReklzZUtJ?=
 =?utf-8?B?REo2WmZJK2VORTg4T21CN2Fia0xCSjZNQVlsMmlCQ1dFdmN1L2NRNUdDNERY?=
 =?utf-8?B?SFd2NksydFpIUWdjQXhJSmVLRVFhMUY0WSttN2xQbXhxZ01FZVZDNFlOTXIw?=
 =?utf-8?B?azNzRE93bm83cW1GY2dJYnU3ZFdhclpxUVVHUjMrZXY5NEF0dWJhclhtNnpM?=
 =?utf-8?B?QjUrYW1GYlgycmVsZjJYK1gvd2dCVjdQWGErd1BQa1NiWWR6R3phRVNVYU9M?=
 =?utf-8?B?Tk1FZDdJNGxiYUVURytZMVRxZGh2b2h5eWVUNjFDdnhhQ2d2QXQ3enkrb3BP?=
 =?utf-8?B?aXg0L2lib2UvYzhyQVVYUXZKTG1TWVFMRHFxeFVWL0FmMHJhTlZjdVFaZGIz?=
 =?utf-8?B?OWJRSmhWZ1VpK3RzZWlndmRRMnpsZDFRYlpXOFNIeFl3REhGZ3E4M3duL3gw?=
 =?utf-8?Q?wMyCjg5unds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejJnSkwzMzlIb2Zrdzc2UTIxdVZuV1dDZDdZbEJCZFhkdHhxNmV2dW4ydVJn?=
 =?utf-8?B?SDB1L3pKSEhmdVprSVEyUEw5U0loY01QWE5EM0F3T01XRllQaGlIYWZhNmNQ?=
 =?utf-8?B?ZjlCamEza25peHZ1OWdXaVh3eU5KZk5QcjJFVVVmNDc1R2paNzhjSlprdUt1?=
 =?utf-8?B?WjNlNXJSM2xtVWh6elNsRktuVjRhOEdiZkhqK2lMQ3NuVktWcXkvSXh4M1RK?=
 =?utf-8?B?VWd6S0VnM1B1bDFHeWhUeFVUYzd3czRweFI0SVdiR09oNi9rRFZqZTJCRTdt?=
 =?utf-8?B?VjRSU1NWelgxcFpwK09qdmhoOVdhNTF5UGlGVTVVMDAyNnRXcnFOaWJCQkVl?=
 =?utf-8?B?MEVOeklZbE9Lb0ZIWExOdlhyMmxvMmIzd3dzblF4ZXVDVERSOWJhbHpTSTg4?=
 =?utf-8?B?OURDTk1WRDQ0V21oVUNtU2d6cWdDb2JhWmEwUjFzYVFuMEh3bVBnOGp2QjJ4?=
 =?utf-8?B?d1hzbDVrTGprWUJLdUxPelhadjJQR0hQT3Uwak1BZis1MmZmK2diYXUzdk9l?=
 =?utf-8?B?TU5ZdWNDcVFKNXlNc3VtRytWUFFzd0NkNFRZMXQyNkJ0ZHdGaWxDL3IvUHBv?=
 =?utf-8?B?QlArR1htdW1OV1hHZHZCRUpuT3NBejFLdmJoZVd4Z01hZUg1dFd3bXNpYWlt?=
 =?utf-8?B?L0x6N0xoOHFHOGxKZlNjYjh5ZlZwRUg0RU9CbWtKMXFVWlRyRlFtSm8zS0Fu?=
 =?utf-8?B?V29uQTlpYU4zRXBUZ2JLVlBzTTFyWnJDeU9LWlI0cDFpczN5bHR5Um10MzJJ?=
 =?utf-8?B?dnBMYlRZZ0tMWHc5ZU45WHIwL0RicVplREI0TjdvTi9XanI0OHBwR0F5Q2ho?=
 =?utf-8?B?SnR4dDM0RmY2TlIwMzdFNFJHY2xMbzhnNDM5dmJWd2srcVh2eTBoYVZXRGtu?=
 =?utf-8?B?ODh4cmRHU3Z2b2J1M2t4VWhlOFNPSWtERWZJajFxMWxxc2s4dnprZHpvZlgx?=
 =?utf-8?B?NUI0RzlTdFcySThwYjM4S3pBZHhDMG1TdEFnMHR5S1oyWkt2bzBRRUQ1cUEw?=
 =?utf-8?B?ZmVkZjg1d1FBNlphcmtmcjFrS3M0dWdrUC9KT3Y2L1dJbUtXVUFHVkJXWHZa?=
 =?utf-8?B?bE9NQ3dUVWhmRGVRdHJJSlFXTUdFbG4zTXE2N2o4NkVZUGQvVFhaZDFSa0tq?=
 =?utf-8?B?YWVTZnpHblFMQ1g3WThmYWVTcDFWazFmTGgrTWhNQ212Nk9KeURWaGhLSkFt?=
 =?utf-8?B?cFo1MUJrN0dvZHpDdm5pUkF1cmRIdm9tVEZoZ3RUb2ZzeDlGaHRNM0xicXd6?=
 =?utf-8?B?SDVKeFJiQWc4UGZLQ1FON3MvSVNUaFBvdlo3eUE5cWFTSGV6b0crV2pRQ3Br?=
 =?utf-8?B?ZVNpT2UzcG1QaGdPSlBYYnBZeFFHcmlSeWNhWjZ4NHdoaEliQnFrTTlBekF0?=
 =?utf-8?B?RXRDZlRYQ3J5eUJ2SDBQWjZPTjJiWVJqSWc4TWZUMmx6NUtaN1FLUUg1U1hG?=
 =?utf-8?B?WWJkSjdHUVBYaE9KUXdyVUdRaUQ5RDY2TG1waDlEMmErSC9lUEdNb3lSNFh0?=
 =?utf-8?B?bVFyVEJjeWVzSHY2WFBDMExTU2Y0R212MGlaZFlPNndtaWc5eTJGVVZLQloy?=
 =?utf-8?B?NHl1aGptZ3BOcndSd281SkxvNDkxeHIrTml0bnMrTFZnOGxwMFN6STBHMDFq?=
 =?utf-8?B?dCtDa0xWNU1XellUd015Mzd2MTh1SWJoTHlNcWx6dW0rOWJiZEhjUHYybzE5?=
 =?utf-8?B?Vk0wWTcvY2hDejJTZ1RsUmFWR3FVekdidUJnRzNyMFVVMnFoNXMxTXBmMUx4?=
 =?utf-8?B?UmFEVWw2SGxPbzlsTGtwWmpWelFoMHo1OWpnMXdTcHhKM0ZMdTZPQXE5alFW?=
 =?utf-8?B?NndoZXd3d0RQU1d5NXlyUVNWVWZTNFpnK2hnT0gweDhvR1h1V3BUTFV4cWRC?=
 =?utf-8?B?NnFWY0RKRG5GSTVJRTY5ZWxUZlM4M1YzT3BrQTdyZ0pMbUE3dWg4dFJTK0Zl?=
 =?utf-8?B?bUFBaUxwbFVCOG8rR0hPRm5pc3dMUjNzYlFWWXlYRk4yNVVvczF1OTUrNk9G?=
 =?utf-8?B?RmZhYzNZanF2UjZtK3hvVFV1aExKeU9Bd2o1REY4OVdHcVphL2xZWExPd1FZ?=
 =?utf-8?B?KzYydjR0N2VDWFIwbEVNK01rcC9FQmFBcFZRU3lhcGhPanlldzBvVkVMcEoz?=
 =?utf-8?B?L2xWNDhOdkJUSTd3YTV4Kzl2KzlJZ2VsSEEzWjA3L2QySEVxcG9aZEdJKzE5?=
 =?utf-8?B?N0NzS0ZCdi9oSXR1dkpKTlZHVkV6bkFrcVRzSGRSaUh3aXFUTXBJZldyOG1W?=
 =?utf-8?Q?OPRLXBasxqPe8jXE7ueGJegLyXl7EcWPkEDCdpxHGA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdf9067-7f87-434a-ee2c-08ddc0b61031
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 20:03:54.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3nD3u6/eDMhv1Nx9YUgqGN0LDFma/83zWXnutzJbJFC7/A0LCDi7OzK1yOxNvyrO9J6bHqF12p8M+S4VYbGs+oKau9MDxNTMlloL1EaaBp/+AT0X+4N9m/nKgxysd6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8681

All Changes are accepted.  I have attempted to answer your questions here.


>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct pcc_header pcc_header;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +
>> +       mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
>> +       if (!buffer) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
>> +               return;
>> +       }
> Mainly out of curiosity: how does this happen? How do we get a
> completion where there is no original buffer?

If the sk_buff allocation fails, the logic falls back to the old code, 
which passes on a null buffer. There is logic there with notifying the 
sender that I don't want to skip or modify.

See the other patch, in the change to the irq handler.

> I figure we're restricted to what the mailbox API provides, but is there
> any way we can access the skb through a pointer, rather than having to
> dig through these lists?
>
> I think the issue is that the mbox API is using the void * buffer as
> both the data to transfer, and the callback context, so we can't stash
> useful context across the completion?

Correct, the SK_buff is a structure  that points to a buffer, and what 
gets to the send_data function is the buffer itself. That buffer has no 
pointer back to the sk_buff.


>> +
>> +       rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
>> +
>> +       if (rc < 0) {
>> +               pr_info("%s fail, rc = %d", __func__, rc);
>> +               return NETDEV_TX_BUSY;
>> +       }
> What happens on mbox_send_message failure? The skb will still be present
> in the outbox.packets queue - I assume we don't see a completion
> callback in that case, and so the skb will be in the outbox.packets
> queue forever?

>
> Are you sure you want to return NETDEV_TX_BUSY here?
>
> Is there any situation where the mbox_send_message will continually
> fail? Should we ratelimit the pr_info() message there (and regardless,
> better to use one of netdev_info / netdev_warn / etc functions, since we
> are dealing with netdevs here).

The fail will happen if the ring buffer is full, so, yes, it makes sense 
not to queue the packet. I can move that to after the mbox_send_message.

The NETDEV_TX_BUSY is correct, as it means resend the packet, and we 
don't have any reference to it.

The only other failure path on the mbox_send_message code is due to 
timeouts, which we do not use from this driver. That is a recent change, 
and that was the case I was handling before.


