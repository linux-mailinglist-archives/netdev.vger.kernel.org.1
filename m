Return-Path: <netdev+bounces-213350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D25B24AF3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE965A5ADC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E142E7F39;
	Wed, 13 Aug 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="SfVHboxi"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023074.outbound.protection.outlook.com [40.107.159.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1C2A8C1
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092602; cv=fail; b=R0aukJWx3TTck00/RoXgOV6izBQtE6y9m4zAKVhxItfS/1zEKvs74FGx8+eKlNJQkODh6xmPByIHQ3kd6yePx3DvB4CzeiSRCLhpJ/nTIBJ5Fk7xhKkINzJQRQF4koCFaLvkvwQzzsSfV88Zu6puQWfSsmjLr7MUpI32/Vv2/4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092602; c=relaxed/simple;
	bh=MU7bldqoSfVN0gB8gGuquOSlTgE+yx1JZ1h3NSke/A0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QN8QIw43THfSt+V/tex0FMDDVWLwhYgVphNLlSUXe5aKomHUdhBaqPg64MxTML59xDB2u7YBrpZmcteve5VoITfx4MbDHPLbecxuXOFCjvpsFTctOgquIbhU9Ih/WQwvjyd8vDvsGF2ZOcInUXI0+aVfMD6iJDf4ENtM/OKM3X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=SfVHboxi; arc=fail smtp.client-ip=40.107.159.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpnl+OB/ot8UlBA6hHCfaxJawE3F4LtXU+E4+xdS95AiFmy3QIU6wmXMhZTJSiyFshQWP4jHtMDaJbI2XlcgbOLHtA1gIMO+i9o+ljlWKMaPZXacH3yVzEWlgFtPm9DNSN/JrUayDMx0+sLcp2Wz3K+b99SHSyeLYyIvGnrQD1UzeXjZyg1KSzotIz8ss4NM3JVRoZx5hx9mV5E4sK5KpLL+hbXvOSmnbzkljpDI+4GS1xQHxWmaJHnl/PGe9UgT2nu6SYxOxgR11mXjsP6fPq6y/aHXMhbo2oy6Du6n20lnDT8UHmGSagxQybyVN0ZrboH+J85JZ1T/X60hxaR+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDVZB56KTOngXe9aPSc588F5pUm2YQP33YF5h32Aifk=;
 b=D78xiD253LWLUaul8k5VbGl5ST6jZN9SMj7h2CxfDq6qwjkKJcqL017RG/GvnbJgUrZiiCO6oGIP4uN15zR6Dg2NbQqGL7ABLR2WU+7hv6eVimdq6ZV1t3pxDY/aGFcSxXU23uRT122JrN33U6kwuearUseSp2iqOqDpuptAAP4C2b2oziarvLNE7ZvTfDoj6q0mN0uhpH6PNVC/ncX9ADJjSVnTdCOB+AFOM/A1yQZLBOPZP7tJ1IH2i4e+372nZTTUJy/pFAeIz4DrZTH2OQ7o+2GWFOtgUzfZaSpxftECd9lzWI3rsYyhcPSvOLICcYUkdllj8ucYpwI4jK/Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDVZB56KTOngXe9aPSc588F5pUm2YQP33YF5h32Aifk=;
 b=SfVHboxiO38k1SwV6QgLA2z3zESTE4BV2gMYfLxdHSn3JXVTz6EUeSqwnjoi9aJfG3aTo2tb05y4X9jCUm1BGaMuFT8McoVbY5VyxUznxJTYUy0i3z77aTtqTLzxpn9lws1ki0HjdjkfHUqxkD2pr9+s+XRAcMl1IKwvcn4FLfV8kciXb00qagoiQgI3jX8mI1KYicKG8Sna3Z9/hW6/i/3qhWw9kbgHxkBky+m74elLkTw1sYbEQu6rcxCPCaELIobvwPLhjJ19sUIxofKTC7zz07xG5/5EDtEqqUa5pl44KexKpBqYcOTHdN/kg5dspP/1RcwTYVQGnMp6pVMRsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3767.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 13:43:15 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Wed, 13 Aug 2025
 13:43:15 +0000
Message-ID: <8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>
Date: Wed, 13 Aug 2025 15:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Woojung.Huh@microchip.com, kuba@kernel.org
Cc: lukma@denx.de, andrew@lunn.ch, netdev@vger.kernel.org,
 Tristram.Ha@microchip.com
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203103113.27e3060a@wsk>
 <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
 <BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203150418.7f244827@kernel.org>
 <BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8f4b9a-e3b2-4f7d-c9d0-08ddda6f5a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ympxanh4UVZKemQydGdIclF3RDBsNzhuVlliU3JzR1VvV213NmtwaVc3RDdh?=
 =?utf-8?B?cGdPTUFrYkZKQTRjbmtjc0ltZVNSRWlsR01EcTk3elRENGZJbklrZFhlU2wz?=
 =?utf-8?B?MTN1L3ZpVlZsWlJyQkQyVFo3eloxalJTNnBjeHE3WlVucVJwcGhkS1M3WW00?=
 =?utf-8?B?bEYwSER1VWRnc05kamZmWERubE9zU3JpYWtHd0R1RlVObDVzT2VRSTBBTTZE?=
 =?utf-8?B?dGNmbTlEdlZjUFhubnpWalBXNDBwcHFvaE4rNzVIOFIrYy93K0I3cGEzRUZo?=
 =?utf-8?B?cG5DVSs3cHcxYnVRSEw5TnhraUQwTllZeG9Oc01kdUhIZDRJSzhEUTJrczhl?=
 =?utf-8?B?ZkRyYXN5eUJhbSsyZWMySzNFVFpRem1qK1RvWlpTbW00NC85aW10QmJGc09W?=
 =?utf-8?B?c042Uko1dHZMTzN4SHMxVnZ5QTI4cEhCZzdlOE1Db21oMXJtQTlxSmJqSHlQ?=
 =?utf-8?B?bjBxWUk2Q1ZaL2lKbFpDdXgvZi9KMGoxakttVlQvd1doREVRNll4WGI0c2V4?=
 =?utf-8?B?NkFYbkRuZTV2YWZQelFNQUFaekhSUjRFNEFvQTFweVNoZWV0UUpiMmVPS1BG?=
 =?utf-8?B?b0FaUkVyRk04Sld3Nzl3MmprdGtyN0ZJYXZFSG45NXl6LzB3Z0ZzTU9kVDBQ?=
 =?utf-8?B?d3Qxd3VmSmR6T2RiSGJQTGpzSTdhTGpKSStac2xYYXA1UFhlZ24xRG9jMWRj?=
 =?utf-8?B?dUVkVURDUWtHVGNqRGZWd015ajJGRHpEZDhmV0ZxQkViMGNLSXNNd2Jycnc1?=
 =?utf-8?B?QkRRVkRpaDlqaktndExPWHAvZDhVME00c3NZOEtDN1ZhekxuQjdHczY2UkhL?=
 =?utf-8?B?bHJqcGlTSDlQR0dXSjliUW1QR3BGYXkvZlYvUWhSM05CYWRORGNiUWxaamVw?=
 =?utf-8?B?ekk3RStDVTAvekEwRTlpd01QSVU1QmtDenVJNGxTNTRqYUpHYmhZN0dkQmJu?=
 =?utf-8?B?U25TaWRxbmRyMnhpK0tZc3lqRDNvSEtKOURXa0JQZUgyVVZSUlBGcldpM2Fr?=
 =?utf-8?B?aDExeWhQWU9VN01WTEowQVRGM292cXU5N2tmZzdUdmpPU1VwZGRlOU5nS3Nz?=
 =?utf-8?B?OW5aUGZKeWxqcDJIY1IrckYyN3doa3NCMklWcHoxcW1IeHErdUVIK0NBaWI3?=
 =?utf-8?B?bkl2QnpxSGNDTUUwVzcxQWZHZUF0OFk2alo2dWJZM0VXbWVpbGhwdjYzeExM?=
 =?utf-8?B?V1VsUlBFcHVxUE5hcGZDMVh6MzE3anhoV3VLY2s1NThrL0pJZzdTT3VFU1Nl?=
 =?utf-8?B?aGtGcUxISTB0a01EVHJOTHJNNWhnRjA5bnE0Ym1OUUV1TFpsaEJMNCtuOHg0?=
 =?utf-8?B?WVk2K3VLUDVHbUVhVGxOOWJEengvcGxzKzhITWVKTXJOaGxBWm1jYnRBa1lQ?=
 =?utf-8?B?dklaRE1aUUhSSllMSW1PTFpXNmp5YkZEeDFBd3pYVm9waDRtcitjcXMrZUUy?=
 =?utf-8?B?TW5lQS93SXhTNGhuOUNrYmVXYjdmUlhHdkJ0T09YNU1qRjVvRjhMSXhoK3I3?=
 =?utf-8?B?RlZoeTBieDBTYndtYitvVGx5SnBmbjhpOXNoL3VsK2NYeEU1Y3RiVytBRHlh?=
 =?utf-8?B?UTh6YXBQTXUzUUlyNFlHR05KYXF6VktUUFhtSmNEM2lGclJrUTZlTUY5VDVQ?=
 =?utf-8?B?dGVXWWJudHhvWDFYV0l1VXlacDVuUkJtcStqMkd0Z3BtWmdyT1lmbHBEMWhl?=
 =?utf-8?B?Ui9TMlZ3R3haS1BSS0FBNmlxK1VXMjg5MkIrTW84cW1vdUEyOWdLTDIrNGY2?=
 =?utf-8?B?Sms5MEtDVy9YNnBVa1BnRTFLVzU2ZjZKSmdXd0M3UEk4RXd6RllzUUMvamxs?=
 =?utf-8?B?T01PQjJRQ3VTVnhOeVgyQTVaeWJsbVYzZWZuWWkrNGI4UjJHV1RSTU5DTE4x?=
 =?utf-8?B?akhvM3dSdE05YytuNm96NHZ5RW5lcEZzZkxnU3JMaWt5YXlZa0xtTGI1dEMx?=
 =?utf-8?Q?n8HfA56e6iM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R29hRG8wSkwzRk95ckQ1WU0yN2d1Qnp0amxkNUxtUFVrektyZzZKVkVNUUdX?=
 =?utf-8?B?Z1d5MWl0QTl3NmdRNzA3My82cldsdnZQUVJ3eFNVVTh0TUN0aThJc210YWdj?=
 =?utf-8?B?bFdCK3czUFlIUHVFQTZ1dGRocnVnR0dZdjBXcVNhZ1lNbjRMTkZJVmEya3Yx?=
 =?utf-8?B?TGJFZUNXaEFPVW9jU3ZiSHk4TXhMRHVxVW9VbW5xWDFnNVpDUk9MaExpVHF4?=
 =?utf-8?B?SDRqYkdkZkNqeUNZdUtyOHBPWURMK0VBTFNLNjhlNVFLTW0rSWdkRTkxQmpR?=
 =?utf-8?B?TTdaYjFxRmpNREJjcnVkTkc5SXZRVk5CaVFPZmRQdW9UY2lJMEZidlRwOTFE?=
 =?utf-8?B?WDNMTmttNi9lUVBjQWxOUzJkQUNJbkdnYUNZZHg0UTlZQ0Q3RUptakpqbTNa?=
 =?utf-8?B?M2NLMlgyVHNHQmlkQTRwYWl0d0hZT1EyUmoxK2QvMDByY2NMUXdUWmFkM1hp?=
 =?utf-8?B?Tm9VVTR2aGQ5QzJRMzUxUnBtNU9JbkNocHp5ampaaHNtdEs0NlpuSTFqMDRR?=
 =?utf-8?B?bmNIOXdsL0doM2liTXJyVVdPMWw4RUNBbEliOTlSYWpWY0NaUEpiQk9rNXpO?=
 =?utf-8?B?akowTWxTaHVkbTR3aC9YZkR0TjNGdG1WUkxUTVhNM0g0ay94S1QzQzFKVEdi?=
 =?utf-8?B?ZUhYdzV0Wmd4TUZRai9MbXY0UG4rVUlpc0h1WGt4WTlSRzVob1lFaFdXbGt0?=
 =?utf-8?B?bGZ0Z3h2NFl3Wm9tNXpGOHozSlZDOGx5RVdLU1pKZDJpR0FzcENXVGUxVGoz?=
 =?utf-8?B?YkN4YUM0TmhoU05sTmFIYlVpZDkxempjeXBqSkphL3hhd3F3TFFNcENVUDAz?=
 =?utf-8?B?a2MzdjhhSUlVenNhdDR0Rmo5Tzg2dENsbWFYUFdOd3F3S1RiY2lKaVVZYTVF?=
 =?utf-8?B?ZHFndGVaaWdZUkVpNmhXZWtXSEl1OUEvNzdReldtcjdiSCtOOFF4VGVaUStC?=
 =?utf-8?B?aGxJUEhGTkFIajh2OElFOU9BQjVwd0ErUEkwbjlhRjFFU25YZDNyTkM2VkhU?=
 =?utf-8?B?bTAzaFFxUGFCOGFrN2FlamQySWNWYjRtMUpIMVJwN3p2eTZJcWpUL1RrQnZu?=
 =?utf-8?B?WFNzNHlSSDQ4cHZzQU1peUxqUXo1SWNudThndWN2d0hVVDZYUS8vUTBBM1Fx?=
 =?utf-8?B?REdINys3S2ppSmJBNkkrZUYyS2NnZzdGbS9EdUYzSmJtbGgzcjVwVkNIcGFG?=
 =?utf-8?B?RklPaTc3SWtKaFpPMFBGRm5TcUVubGdpTXVGQ2ZRMjcvTXZHVEZKOHhUaUtY?=
 =?utf-8?B?NmEzWWZuU1p1cGVHVDFwVCtlajgxcGVEZFVRSzU0SExmdFNWaFBDVXZ0U1l2?=
 =?utf-8?B?RDdvdUJTNnRLaFJWR3FkMktrMnlkOGVSMmVraSt5aXlWM0dlMjljRUxGSWM0?=
 =?utf-8?B?a0tBcCtLQUVkN0NvMDRXWjdHZXhrWlF4eW43QmlVd0xoZDZ1QllmVCtyYlZF?=
 =?utf-8?B?R0MrakVwNVdocFoyaGdNSWhrOXdvZGYyTGR5UGUwOU9OVEF2cmh2ampmN1JR?=
 =?utf-8?B?WXcyMnlMOXdGVFBHQ1h1QXdhc3lZM0Yxb3I0ck1HUFZyNnBDWUxRUWlUNDdP?=
 =?utf-8?B?aS9LbmU2dFlJOGVhb1pPSE1YNHNBWWZQek8rcmlLSVYvT2RwMThGejdxVVhL?=
 =?utf-8?B?S0MwSzJYckVCVlVzajhNN1IrUlRRYU4vajI1OXBQUTBxQ3R2WjUzd2w1RWs1?=
 =?utf-8?B?VjRPYy81Uys1WUhGaURWdWUveHFUVlcrS3FWekR5OTFVOXNSV0RKVlppVEEv?=
 =?utf-8?B?YTdMSjZaTys3TUw0ZmtqWHl2SEhqTTczL3VTdC82K2pIVWZwZFFUVVBHeGZq?=
 =?utf-8?B?Uk5GUHFYbTg0YnFRay9TQXlzeFlYL0tFbTRFWXZxVjAwOWhlVVBHUDZTR2Q2?=
 =?utf-8?B?OFdqN1cwNXF5YlVOamNVRHVFanZVTXk5ZzR0MDhjZWJKajVGWElRY2ZUQWdK?=
 =?utf-8?B?czFEQ3FCRXJGQTdIY2NQQ011eHl1ZkNiUlJPQTN5eE1DQU1YZkM2SU4rRVFl?=
 =?utf-8?B?MEJJV0pzR2FpbS96UkI2OFdGL0QzMEJ3dVllSVliR0xDRXVSYUZUakNUQXl2?=
 =?utf-8?B?aHh5MVdKZUVzSmR0bzZ2MmtreFFDd3RMOHpxYXlrVmUvaCtOdDl3eUdJZ0kz?=
 =?utf-8?B?SDdQV2Z6c1lIeDMxSnJFK3BUd1pJVThVYjVXZG83Y0ZFYU5idzN3bzRQVEZx?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f4b9a-e3b2-4f7d-c9d0-08ddda6f5a8d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:43:15.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7L6loZ52ZPyi/CftcT2IEBCWhYQI0qcCg6r1DLP2T8oCl882YCoeMvH+zkYU3FOd+tNDmSaBxrScBfPi3x+Lu7zmXV3Fp70QQbiaCLTKiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3767

Am 04.02.25 um 15:55 schrieb Woojung.Huh@microchip.com:
> Hi Jakub,
> 
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Monday, February 3, 2025 6:04 PM
>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
>> Cc: frieder.schrempf@kontron.de; lukma@denx.de; andrew@lunn.ch;
>> netdev@vger.kernel.org; Tristram Ha - C24268 <Tristram.Ha@microchip.com>
>> Subject: Re: KSZ9477 HSR Offloading
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
>>> Hi Lukasz & Frieder,
>>>
>>> Oops! My bad. I confused that Lukasz was filed a case originally. Monday
>> brain-freeze. :(
>>>
>>> Yes, it is not a public link and per-user case. So, only Frieder can see
>> it.
>>> It may be able for you when Frieder adds you as a team. (Not tested
>> personally though)
>>
>> Woojung Huh, please make sure the mailing list is informed about
>> the outcomes. Taking discussion off list to a closed ticketing
>> system is against community rules. See below, thanks.
>>
>> Quoting documentation:
>>
>>   Open development
>>   ----------------
>>
>>   Discussions about user reported issues, and development of new code
>>   should be conducted in a manner typical for the larger subsystem.
>>   It is common for development within a single company to be conducted
>>   behind closed doors. However, development and discussions initiated
>>   by community members must not be redirected from public to closed forums
>>   or to private email conversations. Reasonable exceptions to this guidance
>>   include discussions about security related issues.
>>
>> See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#open-development
> 
> Learn new thing today. Didn't know this. Definitely I will share it
> when this work is done. My intention was for easier work for request than
> having me as an middleman for the issue.

Here is a follow-up for this thread. I was busy elsewhere, didn't have
access to the hardware and failed to respond to the comments from
Microchip support team provided in their internal ticket system.

As a summary, the Microchip support couldn't reproduce my issue on their
side and asked for further information.

With the hardware now back on my table I was able to do some further
investigations and found out that this is caused by a misconfiguration
on my side, that doesn't get handled/prevented by the kernel.

The HW forwarding between HSR ports is configured in ksz9477_hsr_join()
at the time of creating the HSR interface by calling
ksz9477_cfg_port_member().

In my case I enabled the ports **after** that which caused the
forwarding to be disabled again as ksz9477_cfg_port_member() gets called
with the default configuration.

If I reorder my commands everything seems to work fine even with
NETIF_F_HW_HSR_FWD enabled.

I wonder if the kernel should handle this case and prevent the
forwarding configuration to be disabled if HSR is configured? I'll have
a look if I can come up with a patch for this.


