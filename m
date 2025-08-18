Return-Path: <netdev+bounces-214514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB4EB29FE4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3266D3A6A2B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE01156F45;
	Mon, 18 Aug 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="IomWJPpZ"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021121.outbound.protection.outlook.com [52.101.65.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDD261B62;
	Mon, 18 Aug 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514871; cv=fail; b=csakhb9WxAUIGcTkWAXeR1CWus3yWH15/0I9coKY5YWK6OAM9xDDSzdt+9ss3VUd1d02/4x77hQtp/DuRsQt7nHQ9Bb8nmE959nbCDke/lQpgiBRyUKRn4OtA5LT1kwsfbZTo6sVs7SHTkdAqoC2miiGecdtnJyT4YzW0ow2ojk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514871; c=relaxed/simple;
	bh=8h35WjggQiieF127DzuhjLE+6uCL+Nf4ifrR6BGJHV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ww9LIqept8366H6v2yWNusaYZ6p8j8QoymtRxuS1xSXd/Lu0Kh8sVLHCeslSB8awc7Dv6LomGzuEdXVJppKU3qZa2+NFp7wcMuBPVrLofLOHbs4cX+N8n4taH/ZnNcb6rCe+H2Eo69BfRa3p+oOUtNdxBTcC30ejsZ37Z7CEOYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=IomWJPpZ; arc=fail smtp.client-ip=52.101.65.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOgsA49LZK81Tc2EZwvXWptVU87W+/tz1C/doNyWrVuJW85i3euG4VC7yx+G+yVJ2PMJZ7jHcBKffoy+hSzG22Zdhl4bR9eQnjRRMpjpp3JwDCxN7AXqJgeh2hnORLRaHlanUsQTvVKjq2kLNykyIx10jvPX/r4/lhZBR5N4G91fzAREK/7GwG7Mepx/7/qLk7AwAlqyrL/Mkk1aTO9S3DaKtCY2d6rBs9RbmG1d1wgmDCYClk6mOSjdwmtjlC1Jirj9R6YmAjYC43whGmuwUAvbCe/kNTF/GPXxIZgyF/ewqh6ys4TXiekFMvN42zlwwmCUkQrJa1VbV8B4c2hgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qjIKEeeUwnd+IvM2lT+mDjTehM/kFJdBUJkJRSAncE=;
 b=mQ+FJJrbmYlTbjH8oQrFwRiBzfe6/aM3G8pq62J5lgd0hyN/Qr9uQ4dmtYgfgBjf9L6a8PIXwDqOez4fHdZqJrOZxuQ+EByyAsNAe81uRtfD/qmwmHolv6jqYVeYgFq2ZZG7NmyZt/pk6NgqqqQ/xXNMZazKq8YFqs6K6lZOlppILBuWM0xiyTA1+6SM0VN+w2kjm8K583DbrygA+3bkwYY9hX/91TKajaJqfPYVanw0KQzD+Mvj3JXfqxNVtJtIRZYRc7NAumSdBlhNQjfOdYJ5YNjqZw2o57GQr2Hdj/Aoz3iesUuFYVwApT0LnmSMl55XS05UZ7CjKmAYtnYXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qjIKEeeUwnd+IvM2lT+mDjTehM/kFJdBUJkJRSAncE=;
 b=IomWJPpZHT2/1MirJau2SYLdFtuyOLEqhNGleA3PTQnQMCIQ7XWaKc0ZF3cKGm7EmwlUrc5FZZMIlANVV1csVlbigqKh7uxLijUVo3hnGIkfO3Dkf0GG2TRXCi0++v5k/pBsRuwJx+lZEBuLEbLaI5r+LGS7Man6oGfSIzZ+FhT+Fz3IEyc93UP4Xx4b5LYGOth2DfI40ENQ6p8Tg6pvexZAMlGWQloLWbJjWMw8RsAmmfF8QCGJZ74oGgsPdCe2wZnallaNdED2nZM71iBHSM5iLSD42+FFDQo+xIEIRu2arzeQI6FM4cZvX1f95CWAHWDcDC0VZUMfGNHI3zJgmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 11:01:01 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 11:01:01 +0000
Message-ID: <a45178cf-304d-4fab-bb10-7621296661fe@kontron.de>
Date: Mon, 18 Aug 2025 13:00:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
To: Tristram.Ha@microchip.com, frieder@fris.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, lukma@denx.de,
 pabeni@redhat.com, UNGLinuxDriver@microchip.com, olteanv@gmail.com,
 Woojung.Huh@microchip.com, andrew@lunn.ch, florian.fainelli@broadcom.com,
 jesseevg@gmail.com, o.rempel@pengutronix.de, pieter.van.trappen@cern.ch,
 rmk+kernel@armlinux.org.uk, horms@kernel.org, vadim.fedorenko@linux.dev
References: <20250813152615.856532-1-frieder@fris.de>
 <d7b430cf-7b28-49af-91f9-6b0da0f81c6a@lunn.ch>
 <27ccf5c4-db66-491c-aa7c-29b83ebfca3a@fris.de>
 <DM3PR11MB8736A15C582626DE95429F6EEC37A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <DM3PR11MB8736A15C582626DE95429F6EEC37A@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfea2fc-873e-41ff-ef16-08ddde46847f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ukd2QUpneG16WVUybEEzZ1k4Y0xqK2M3dE81YzhBV0p5K2YwZ3oxUi9wbEsy?=
 =?utf-8?B?citMNUNMUDVqN2Q2eExDTUprQzBzRDVGRHk1TlFQZzROUTZDZkZ1cmp4MmVa?=
 =?utf-8?B?cDBObzB0aDhXNnZSNGJCWnFlWEpqdFJmejF5eGg0VlJOL1lyNXdkcmhMUnYx?=
 =?utf-8?B?TkFNSUFqWHBKQVpzTE9Rd3dZUitwUVBvV0ZEZytPYldOdVFrRkVudzNkemw1?=
 =?utf-8?B?L2diNWc1blhMcWFnOFBVWHJsQnNmL04zdkV4U2VkU3BVN0pFWnVZSlNTTnFj?=
 =?utf-8?B?eGxxemJRMUxVRi9KUjd2K210UnI4M3hIazh1eGlOU05BOG1PczV1MGZaYzUr?=
 =?utf-8?B?VGFCRkhnbW5RUTEzcWRhVXpwTGFWWGRIakdiR1lEYlFzczQreTlqRGl6bUc0?=
 =?utf-8?B?UnQyKzllakJFWkZVTC9RRmtoNTNhZEFuNFArclovaUpaQlduTnZRd05mUGZv?=
 =?utf-8?B?MWVieTNPdzRkUDF5ZGlxVUx0Y2dlNVlPdW9sQUwvV2xnWTc5S0hhaVIzaXpx?=
 =?utf-8?B?ckV3b0ZIUmt2cVArUEZqZXVwN2pWbnRycDlxUG52N2o5M1A3a0dyM0FmY2pt?=
 =?utf-8?B?OVFoMlgvcVdoT2dkRTJsYk9rQTYyL0hmb204NkV4dG8vTzljdE1mYk0yb2VC?=
 =?utf-8?B?V0pjQkNHTldpTm9hZk5nV1B3b1dGdGlnNHhDd2ErR1dpYTV1aFBpME1DUFEz?=
 =?utf-8?B?dkJ2bGVGQ2s5d2pRV2hSYjBwMWtlUWQxTlZyMjJPa3FiQlJMdWFnZHM0ZnF5?=
 =?utf-8?B?S29pVGxObWxoTmN2aXBXN1RJb21wNE5ONDN2ZjV2WGwyc1ZGRVNlUVR1eVhW?=
 =?utf-8?B?YnllNUkxMHhPQWNLbTYyWUY4VzBHZUpRUkxyRDMvaytQRENWblpyMVlWcWdE?=
 =?utf-8?B?Q00xZHNWTDViNytUQkV5djlFRDZrS1VuOU9kTVllMWFLOTEvd3F6Q2ZUbjRY?=
 =?utf-8?B?dEFDbkpHcUJqeldIK1l6K2E5SWRNN256RDU3bE00Lzk3QkV5K2w2Y0xMOHA2?=
 =?utf-8?B?aGJhSHNreExEa1kxQXkzeEhYenhOangzeUZrSnk5KzR2RmRDeEkzNzR6MFZM?=
 =?utf-8?B?ckdYN0xEK2JqTFcvb2ZDUEZpNkJONENSeTF0OHVRZGtkb1FmeWE4aHdjaVlK?=
 =?utf-8?B?RTVXYlJLbnJhVWRsby9Hd29iSmxOcC9EMWYzVFkzd0lPRFhrVWVoenRIVzJN?=
 =?utf-8?B?R0p6czJaZmxYZ002dHVoV09aMHhiSnRDMU1hQUNLamNkczFOV3l5ck5aOFU4?=
 =?utf-8?B?M1VvZUxJZnlUZjhieTNEa2ttV0xod0UwRU9oSUVjdEk3Z2ZsT0JOMlBPY3dT?=
 =?utf-8?B?a3Nyc0dxRFYvZDY0ckFYTkNzeWl0dGxyWlVtRG9YUmUxSFJRRjI0MDhpZU9G?=
 =?utf-8?B?c3N2Q2NqTE1IUGkwOXlaUjFYV0JnZ2V6RlF1clp6aGcwMlhlOG14MEFoNzM0?=
 =?utf-8?B?VVltaG8wNXlyeEtTWC9ab1JiTzd6Yk4wbFhEb29aZFFiQzVmT2ZnUnNGQ1RU?=
 =?utf-8?B?eGdCaUQyWSt1anhBZWpQNDZOUkY5RVlENTBGcXZ0TWRYU3AzYnc2dWp2VVRi?=
 =?utf-8?B?T2k2d1NPakZ3YzB4dWxjcGZxV2NMWGlHRXhwUzFRcmU1MnJkRjJWWkt4RnhJ?=
 =?utf-8?B?U2pzdEtmMnJZczBySGVmOHZkRHZWeTE4L2pESHRDWGtTcjVlejJoTWt6dllV?=
 =?utf-8?B?UmFqNk53eG43ZHVMZVlYWHNxN1JJMFlJNVErWnpNVkd3YXY2b0tLUk51TGRS?=
 =?utf-8?B?M2MvYVRVaTU1MWt4V0tlWjZQS2l5OXJGU09nVHhSMWluMVdmSkZxQWR2TnZz?=
 =?utf-8?B?YTNnUEVuUzVyQnhXNlhIWGFoUUZERTRwZGlzbkExS2doMHpkblRjdmlzSmxO?=
 =?utf-8?B?ekxqNWN5Z2Q3T1BnVVJBNlQrWEVRTXdORGlvUncrOWtjajZ4Z0NpODEzTzZJ?=
 =?utf-8?Q?IVzJo9wrBAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjF1b3JTYXV4M29IWGFsR2VudERXa2xpSWxCVTJacUE2SFcyekk4TWhmenhq?=
 =?utf-8?B?V2RJMXVTeDdmdXdPZWlSNm1yZFg3WWxXcWpWMDA4ajBBQnl2U29HV2ZFNGx6?=
 =?utf-8?B?aVFSak5Rd1EyWXNud1BmcHJJQjN1TGMrUHRCY2xrQ095Z3dTWVJ6dkw2djNK?=
 =?utf-8?B?Nm1NUVZtM3pWcktqR1hJbWtTUllFc3daVVZ3TGFtdTVDVUExYlZCRmpLdDNM?=
 =?utf-8?B?NERYNEhxZVBsaTdMTHlPRWw3T0xXRk9WZWNHUlpGQnM2TW01QStMVVBjL3E0?=
 =?utf-8?B?dVBqTmt3VmM2cC9WeGIxWFluQW03ZVFDL05JeVMzVExEYk45RUZiS082VnZo?=
 =?utf-8?B?THVnRlRxV25TL0l1WHRyQW0xUmI4MUoyTU1xNlRxOUtSU1NEYmVOTHpYU0xZ?=
 =?utf-8?B?WVNVREI0NFU5T0hQNnZuQUR3TlREaTIreWMvSjU1L0xFT0swdDg2czNLSXpZ?=
 =?utf-8?B?Z3EyQ3NndVdMWnhDeTdBbGxJY08ycUEvYXUrS2dKK2NNd0pNNURQblU5U0VW?=
 =?utf-8?B?aHhXTjR0YkVqU0ZVZTY2SVVWWHlnMkdGa3Azd3Y0Qmc3UUxHTjJxYjBQWUdC?=
 =?utf-8?B?N2ZlZWhobHhZRXhvWjduRU1UQ0RVVmw0aFd3eXMrbldKVnhCR2ZFRTRxS3Uv?=
 =?utf-8?B?QWc5UHFDM3lBMzdOUEthb1V6OTc1YUJuZjhVb3plWmVCeGNQSmNncjBJaUVS?=
 =?utf-8?B?dTFma1dGVkNyNVNReW9lWC8zd0N2blVuY3hKdXJIRGExRGVPUEw4QklQVzJN?=
 =?utf-8?B?QTZpQXc2ZE1wVkdGMG9Wb0dyQXZyM2FMcHRMOW0xc3NaVlMvVyszVVpDR0xs?=
 =?utf-8?B?S1NpME1uYnJXWnZTYVFCaXJkVXIxYkdsWnM4czVWMVVQV28yVm5rRjJ2OVVx?=
 =?utf-8?B?ZTdtVG9jS0pMUzg0Qm55ZmZrWWg5eDN2L1lYQ09nVTNLOUhCK3pSbEhWTW85?=
 =?utf-8?B?QjVMSXZCUG5yWERhVlVBMGt3ZGVGbTZXQ2xqUXVZeGFoTXRESUtUT2VhMXI1?=
 =?utf-8?B?aWJwZHdEUmV1K05SNm1xVHhnUjd3eHQ1dWNvVmI1aWYreG91eG1NcjVjam11?=
 =?utf-8?B?T2Z5V2xFM3pGWjlCaXRRY2tIMGpYQU1vYnU3dVFLdHlCekR6ZmNId0FjcmM0?=
 =?utf-8?B?VUFSZE9NN2pab0N3KzNhWGZ0eEtGdW1KZ0IwZG5pSnJQano0ODZHMUZkb1R5?=
 =?utf-8?B?QlNVT2UxaU5rV003My96R0RIQzZGellpMWZmTlhIZWFGaHpnL09NSUM2Rmx3?=
 =?utf-8?B?akQ1UWNFRzRSM3MxdnRZSzJuMDAzMFNpYnU3cE5NMnZ0Zy9WYzFxRkhPdzF1?=
 =?utf-8?B?ZENwcVJiRTYvS3dMOXl5SjhZWkJqcGxqNkRYK25RdjU5M1RvMlE3Vnp5aURP?=
 =?utf-8?B?dlFscWM1a1pML3FRZGxxMUtIdVdwWnNXZUhzdmx4RUVDT1VQWGJaNTlKRWI0?=
 =?utf-8?B?Mm9PcmF2R2hZSVoxTWlHRmZFTkpDRVpBMkdaREw0M1oyWDBPbGZLUURWN0hT?=
 =?utf-8?B?MTNNMnlIeUpaMkVFeVNwbDZrMUNjN1hsVVZVc2lxb3cvbHhKZFdYRlJhVXVE?=
 =?utf-8?B?Wk90UzNQTVY0OVY4ZnJEa2FzOWRJbUdGaTFRcFVzaFBQS01uWkh0eCttL3pW?=
 =?utf-8?B?cDllM1BJZ21IQi9uMWt3Vlh3N1greVdwc3FTNU9EdkkyZVRtRDNVcHJGdS81?=
 =?utf-8?B?Y2F2YlFOZkY5RFVvelNMa0tVVzN6dXBYN1dObk5IWFR5M1BKK05GV05nMk5L?=
 =?utf-8?B?V0YxTFlsVmtnUUNnclNwa3V6YzhSNTIzK3M5dXRFaGlVWmh4K0ZKMTF2eHVY?=
 =?utf-8?B?YTRQbDJ1elY5WXA2YzlCSHh0a2VlUTk2VHBncGxWc3lhQlhDWG1NVXl3Rklj?=
 =?utf-8?B?Y09jWDIxM2RWcVFPS1pCcU1UcEhhRGM4cERQRENvR256Z1VLVU1vTUkxVS9K?=
 =?utf-8?B?MFhDT2hPZEpndk1Dam11Qmorc3BUekEyOHdhdFFBZDRhcGlJSVdjVnZ1dFdW?=
 =?utf-8?B?Tm1KTGNlTkRubFlXdlRBMEVqekRxQzlzeHA0T0RuWnFCMVRuRVMxbWVIRXJu?=
 =?utf-8?B?aEMva3JWd2hZeUVKYkVnSnRjcitVaDd4cVBCQ0NIWitHV2JUaUlmaHRBSGQ2?=
 =?utf-8?B?TXk2ZUsrN3d6S2c2UEIzZVM5L1k0K1RxK0R6Y2ZvL3pEWHZQVTRaUnpzcnV1?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfea2fc-873e-41ff-ef16-08ddde46847f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:01:01.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7de0GWRkIzLupwITWGHoFyKcDTMApCIGO1OrlvaZHD4tgKb56qpK4qLFxAEk1XREzwAMq1zUkJpPtWDE0TnZQDKt5TiCEFQnfe2Ntbn/qAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032

Hi Tristram,

Am 16.08.25 um 02:53 schrieb Tristram.Ha@microchip.com:
>> Am 15.08.25 um 00:59 schrieb Andrew Lunn:
>>> On Wed, Aug 13, 2025 at 05:26:12PM +0200, Frieder Schrempf wrote:
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
>>>> HSR ports. This is set up when creating the HSR interface via
>>>> ksz9477_hsr_join() and ksz9477_cfg_port_member().
>>>>
>>>> At the same time ksz_update_port_member() is called on every
>>>> state change of a port and reconfiguring the forwarding to the
>>>> default state which means packets get only forwarded to the CPU
>>>> port.
>>>>
>>>> If the ports are brought up before setting up the HSR interface
>>>> and then the port state is not changed afterwards, everything works
>>>> as intended:
>>>>
>>>>    ip link set lan1 up
>>>>    ip link set lan2 up
>>>>    ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>>>>    ip addr add dev hsr 10.0.0.10/24
>>>>    ip link set hsr up
>>>>
>>>> If the port state is changed after creating the HSR interface, this results
>>>> in a non-working HSR setup:
>>>>
>>>>    ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>>>>    ip addr add dev hsr 10.0.0.10/24
>>>>    ip link set lan1 up
>>>>    ip link set lan2 up
>>>>    ip link set hsr up
>>>
>>> So, restating what i said in a different thread, what happens if only
>>> software was used? No hardware offload.
>>
>> Sorry, I don't understand what you are aiming at.
>>
>> Yes, this issue is related to hardware offloading. As far as I know
>> there is no option (for the user) to force HSR into SW-only mode. The
>> KSZ9477 driver uses hardware offloading up to the capabilities of the HW
>> by default.
>>
>> Yes, if I disable the offloading by modifying the driver code as already
>> described in the other thread, the issue can be fixed at the cost of
>> loosing the HW acceleration. In this case the driver consistently
>> configures the HSR ports to forward any packets to the CPU which then
>> forwards them as needed.
>>
>> With the driver code as-is, there are two conflicting values used for
>> the register that configures the forwarding. One is set during the HSR
>> setup and makes sure that HSR ports forward packets among each other
>> (and not only to the CPU), the other is set while changing the link
>> state of the HSR ports and causes the forwarding to only happen between
>> each port and the CPU, therefore effectively disabling the HW offloading
>> while the driver still assumes it is enabled.
>>
>> This is obviously a problem that should be fixed in the driver as
>> changing the link state of the ports *after* setup of the HSR is a
>> completely valid operation that shouldn't break things like it currently
>> does.
> 
> Here is a simpler fix for this problem.  If that works for you I can
> submit the fix.
> 
> net: dsa: microchip: Fix HSR port setup issue
> 
> ksz9477_hsr_join() is called once to setup the HSR port membership, but
> the port can be enabled later, or disabled and enabled back and the port
> membership is not set correctly inside ksz_update_port_member().  The
> added code always use the correct HSR port membership for HSR port that
> is enabled.
> 
> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for KSZ9477")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 4cb14288ff0f..c04d4c895025 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2457,6 +2457,9 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
>  		dev->dev_ops->cfg_port_member(dev, i, val | cpu_port);
>  	}
>  
> +	if (!port_member && p->stp_state == BR_STATE_FORWARDING &&
> +	    (dev->hsr_ports & BIT(port)))
> +		port_member = dev->hsr_ports;
>  	dev->dev_ops->cfg_port_member(dev, port, port_member | cpu_port);
>  }
> 

This looks fantastic! Way better than my approach!

I just tested it and it seems to fix the issue for me. Please send this
as formal patch and put me in Reported-by.

You might also want to add a comment in the code that gives a short
explanation for this.

Thanks
Frieder

