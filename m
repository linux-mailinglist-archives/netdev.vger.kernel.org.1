Return-Path: <netdev+bounces-112180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD89374F1
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B67D1C20865
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449C6F067;
	Fri, 19 Jul 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="APDaSmJ2"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC5208BA;
	Fri, 19 Jul 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377244; cv=fail; b=LckPD02bAa/iXSZQ9iHIFs551dp+MI7DPy7K3Q9TQvm3iaH4uG9hoE9ADug9wu3S31YKXgOakXYY8lo877qWcpfNnkwgwmTnqES6DXnAtnzoqwcZVywR95fkHAT36Uh19x6mb0eT6RPKLOtQQo162gwSfWOLAVpnOKatTIQVsp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377244; c=relaxed/simple;
	bh=mtCiNvqRTnt6j4CBx4tR+W+CwIL6pnywhu3oB8SDuG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iF79qu1dEALZ5DKaxioc/0zMlNP0R2rGmW/kbWaKyIiOClyObEQUaoKD05UWzy7NDJYwW12W5o51wNjyEXf7rJu7fN36C8jKcCDsrn5JUM8RuAAGJIw2fEa5bB+epdq38B5zKy53W1WHR2Cgbky+ezBmRpTGJASP+oV4DrVkgU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=APDaSmJ2; arc=fail smtp.client-ip=40.107.117.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtmAJpNM0bKq9AH43V2440wvWMezt4mwemKJSlcnDsJPTsTr+AGQ8+UmxjaF77Nq5ARqfTzuT7wV2bwpiiIZDAqMvDR5waWSUVkfdG6/Bj/hiWpp+pMhwoAPnFu/L70CQnPWOBxV9rgSU7mvpIdIYpbvlEpZ5J/n25rXMfOkFb4Eepoj+Fh4Lb1TiwVZyRHgdXB6gRI6J2N038weol3oMLxiM/F544IYk8RAMealCHrohyUT0vMFmkHZX4U/MsGWHvjn50vTvz2XHEiNch7Avc/CTqh47o/3R06b0MZSPpVqBbWBInAo73AUuRcBPmWFly8tG1JAD715BUI+aQYW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvjG7h5/RQE/wFif1p77WGE11z+YN1aYSMuHwW2zSVQ=;
 b=wIEkQe1hx5V1hff+GqHoK7KJ2WOgmVDSsrVcLzfu4uILYo7xbwqRutKGLpE5nS3EruvmUXjtpqUPyA8xM+OGnse+znlFgm7Xi7wtnX8BjocfNyjxJMGtv24iKAql8B3XTkbW05v2IsMgtIzpg2mJmlQQOXzJL8fj9tQ2oNf2MsvwVewP4uxU70hIdA5c5oxW2wNbw5QV/7P6WHxz64qz3Sy0Pbpt+J8UKXl2R6j+fSukHmML2LALAefOoq8jopd2NAzWCnSVaqNxvNLhszfWbwXANlt7TKwcs5yJDWgR0cUJiL0Pi2+Sp3OdCXzzYv97kz3snWDZ71XhTvyF8C+fsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvjG7h5/RQE/wFif1p77WGE11z+YN1aYSMuHwW2zSVQ=;
 b=APDaSmJ29ZFZRYzyqXlnKjYefvjv+A0m1zpsjyICdUPgfJWUWIPVlUyNixpuQ4PLiJ4cuZWY3ShVu76poXnYBL/zZYpPkYfWINlU+vcuDL3zwJaVL+9pq4rrp9/Wg8kfzZ+16g4ixi+WZrGCNaITS64C6ljvpHPTw9EWEh2Zh9MmUWDab50OjljE05/IH65Q71bCLTkYXaOC80RaYdKIKWfK0W/FmeLsXTSju1P6eZcPznAfUeQqfkobxx+nWJ/dnew1HkUWQIw8UG0EBOpNM0qiu/o97nKXP3iBVbjPwpxQcoDFUZnoV+EBxAQjjDRBuwyG7kfRqzcLiQ63aLJTpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by OS8PR03MB8818.apcprd03.prod.outlook.com (2603:1096:604:28a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 08:20:37 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 08:20:37 +0000
Message-ID: <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
Date: Fri, 19 Jul 2024 16:20:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
 <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|OS8PR03MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee077ed-7db4-4ca2-0bfc-08dca7cbab32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWhGai81Q1o3Z3BQYlhvRkVEdVJxaklGU3QrTFNGZ3RrWHVHZGZpZlJGTnNG?=
 =?utf-8?B?TGNTUlRjWFNpUkNqZVV1V0JjR1Vjc3V4SXFVc1dlZ3VndHlkczllYXNtK3d5?=
 =?utf-8?B?VDlCaHQ4aXIxV1R1TXRSWU9jOFZyT21vaFZMcUYrdEY1aG94QWcwTDJHbDhs?=
 =?utf-8?B?OGNPWXdudlZFQXVmVzRvaVc2bGFpTUVOQlhKMm9LaEhyb3dhZzJzUm1JRUkz?=
 =?utf-8?B?MmhzeGtnc21QVEU2T3ErWE5hSXRlNjFoR2FOZ284V1BtOS9zNTFvUS9hckhC?=
 =?utf-8?B?emlWTzBaeGRKUjd5NWJOOHUwbG45K0hEUk0rTXhVeGlxWFJRaGVDeXVQNHdj?=
 =?utf-8?B?NHlrNkduek1LV1F0bVowNWdhUUNXSTkxT09vcWliWlZkNGNZVllXL3FQV3B0?=
 =?utf-8?B?UlpPLzg4dzJrQXU1RVUzZXBQUG5HNjcranBuS2l0RHZOSmdOcDloRGo3dmJH?=
 =?utf-8?B?WjdiRWc3eUI1ZU8xb3hNMjN6QVJzMnlESUhhVGRoanFuWk9SVzJCQ0dnOEly?=
 =?utf-8?B?WWJvdiszWGpsN2dOMXhVKzJ4c2VrcnN4VDZDdkJ2MDE0M1ZOZURaMnBXMXk2?=
 =?utf-8?B?dE16Sm1DQjRzc25sZ2lMOE5ydkhkUUVPaDZOYWNUaFM1ZHJNV00ybUVtZVkx?=
 =?utf-8?B?Zm5vUG9nbjFxSVEwWmtqQ1RTdE82Y3BRR1VubHd6d2JoaEQ0QUJ0V2VqeThX?=
 =?utf-8?B?am5nNFhZTjJNSDdJcFIvS3V0NG1SRGJvY3ZaSnZGQWdySExpaGIvanhYYkgy?=
 =?utf-8?B?NVJhNDZmTUMyV0VpYlEzWml1UzY2Q1B6cFhoZWJEQWhLYXYwaEJVNUdwWUJR?=
 =?utf-8?B?TDN1RHVYbHM2UXVwdjBla0t1N1Rtanhvd0kvRXp4a3BYck5sdkEvSE5oa2hm?=
 =?utf-8?B?WjNlWUdLS0dVZTFFVmRHZitFc2dtYXVobWcyb3dOd0d1bEFoUmprY2szR0xx?=
 =?utf-8?B?dGFRNEMxRnVwTE5mTklVdytJZDhmVCtodEtPRElnODg3c1B0cnE1amladU4x?=
 =?utf-8?B?a2FZQk5nMGhJYWo2Q2RwcXgzQlRYZnVJMjlOZlJCc2x0ZEFLZWVVMHY5bith?=
 =?utf-8?B?OTRNdVpVTEhGYXBta1BzdU0yUHpXTnFMU0VuOWJNa3R5a2REb0Y5OWxtdUhw?=
 =?utf-8?B?OU1VQWFKOG84VW1ISGJOTFFKcmZscmtsMGVhL3kxZTZTcXdxeE9hVXY3UG9u?=
 =?utf-8?B?MCtyQWkzVnpBQ2tlcnpaNVFqUXFsdW1pN0VXaDZMQ0tNUWV3VUltWEpuc2NH?=
 =?utf-8?B?K0ZDSzcwaWRoZXRpUzExWms5ZXB6cTFtMmlmZlpRN3RSUVA0dVpSSEFvWmpZ?=
 =?utf-8?B?dEtoMFJhNmZ3Q0RGTDQ0ck9LN1BXVXVRMEswcGFLQVFVQW5mL0hFdUVIR04v?=
 =?utf-8?B?OUkyQ05ROU00WUQ4bEJpUWN2QjJiQlFFVVZTOW45STg1V0RoZ0xTLzFHaUoy?=
 =?utf-8?B?OU9QVGIvRnJ4bkZQdGxFWTlWczFLUlhpbWxERXhQNFo1VkU5OEpxUzJOYXJP?=
 =?utf-8?B?WGFHamJLMXM5eHl0ejhSK2JqY0ZyQVRSMW8raHZqSWtUVW1uY3hZSUlja0dD?=
 =?utf-8?B?aHZJOWNsanRYWWRZTDFnN3Q4L0VrbUZETzRCQ0lkMkxtbWcxU1d4ZjNyY2k0?=
 =?utf-8?B?djhROWhScnRIOXRGWXdHcVJTSmt0VmFUSUxOVUlOVEluUno4QkNKZXhSUjJZ?=
 =?utf-8?B?WS92bUJpR0N0WHpzTlFNS2RXM1BEYlVKcyt4ZzBhUEFSNE5ENlF5UmtqQS9h?=
 =?utf-8?B?WVlXYlhxaEhTNCs3QS9MTHNURUh6NzZBQjg1d25JS0QwdHZjVk1NbVpac0FU?=
 =?utf-8?Q?knWDvsNHnWRKeYtwZOA05wI1dM5OkzAwHiAaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEJ1Wi9UVzUxMHJnTG16ZlV6TUlVZUxrVWZVVHhsS3kyOG1IUTQ0SVdWTE1X?=
 =?utf-8?B?VDRnOS9EcisyMHBIRllDM2FUVGw5T2N3dVNhb3VVaEEwSG5kK3BCNGFpZTNB?=
 =?utf-8?B?SXNpSFJZcnk4MkM3bEQwNm13YS8wMlB2Y3NvZVc5VnRpL1RLRFBNcU5Eb3Jy?=
 =?utf-8?B?c3ZVU3ZIbmY4K2Z1SlQ1eUtoTUliMEdjcTZ1YjFqWUdxQ2lPS1d0S3BHeVdJ?=
 =?utf-8?B?czloT0M5TSt2MVpLeGk1d3JFK1BBV3hGZW9LNFdNNlE1c0hic3E4dE12bFNa?=
 =?utf-8?B?WXJEbzJpUys2NkRocml0MFMvUVZLUWlIS3p5UU8yd2JDL0lEMkdFcHhZTDdy?=
 =?utf-8?B?Ryt2alNMSmhXcTlDN2JSdVA3QkVCanF0SWJBQkdleCsrUzhSY0lSM09CMjF1?=
 =?utf-8?B?dzJ2Tk8zd1VvVjVaUTFoVGJCSkFLenpvQ3dCNXNlQTYzc1dSSnBwak5zSEpQ?=
 =?utf-8?B?aEVab20xZDZYQldoVmh4S3k5NTRFYS85Tnd0eXMwYVpRM0VJMHZuK2plVFlh?=
 =?utf-8?B?Q0lZU1pHT084cldOc042b1M3L2FDS01kci9nM09BRnVwTTk0K0Z5b3p3VzVn?=
 =?utf-8?B?eE5SdTZnRU52akFTaFA1ZlF5Q0tiRUJCN0E4T3RUSkZwd21wcHhPQVdFQXh0?=
 =?utf-8?B?c09JNzN6eGlON0dqSUVUSzJLTlVsclpFV2JHTGlOOEtkMVZHa3Y4TEkyWjRx?=
 =?utf-8?B?elFVWmtsYzQ5WkE0SVJrMW9lR3B6OXNXdTJCQ1ArMTkybCtuKzlEaTd5Z0Zu?=
 =?utf-8?B?N0tmL3BwM1RlQ2VRRm8wQnVCTDZTdVh4WkEyY1E3WTROMUpEYXhGY0FleFFv?=
 =?utf-8?B?TXJ3R25zeGVHOW8vc05YbkZZaFdBN2R1Q0lmUjhCeEZLelRsaEZwanJXRmZW?=
 =?utf-8?B?Ny90YUh0cytybVBJNWRCNVZnSHlQQUNscnVRbkN6bHhSSFlleUFBbTV1UjI1?=
 =?utf-8?B?RDdTNXMxUHBXTWRPQ012dXFKZzE5dEcrc0d4ZktwSVVjb2l2dE43bjNJT0RW?=
 =?utf-8?B?b2xvb3lhY3NkNTNjanpKNDAxaCtsckRNMVB1THgzc1FxKzg1cTBMUjE1MXJG?=
 =?utf-8?B?R29nd2tPWnpCOTVxai9aaDk0VTZMcjZ3VjFaWnMyankwdlZPQkpXMnViT3Ex?=
 =?utf-8?B?aGtUMFY4cjErYjlGOWEyeGt1MDhKdFh2dDkwWTNxRzFNTGx5TzZLdFdmL0gw?=
 =?utf-8?B?clBNVWkvZWo4enFERFhSc0lxdVI2djdRZGpubXJsWHhpYy96NlRRcnE4WGFw?=
 =?utf-8?B?RVhIbG5YL1E2Unhydk5ubE5XN2l1anVXMFRGaDUvbGorOWRpSHdwUU52NXVy?=
 =?utf-8?B?cTBCb3ZHdnF3QisvbWpvSXd3bHZ4WkpubEVaUjI0cjV6ZVFVay9TT1IzdDFp?=
 =?utf-8?B?NlBiRGhMSW9xa0p1eVo0anJZVWJGb3pjNFBUQWJRQXl5V21PWnN0ZjlETUg5?=
 =?utf-8?B?MG0xWWxMdFFzSm83ZjVzOFF3TEg0UVNQUE01bnVEc1lrMXl4NDBjTkNWOFdE?=
 =?utf-8?B?VFN6a2dhZzczeTVha1MyMkoxNyt2eGZ6cUVISnA4U3k3Q3c1SVV1YXJnUGxQ?=
 =?utf-8?B?M2VUc0FDQXJkR0tqVGNMLzNoa3dHbHhuM2dvV2J0SzgzYWVoN1dlNW5GdXgv?=
 =?utf-8?B?WkdHdlBybUhCZnZXSzZ6UkZ5enB6Y1ozcmY4WlUyTkJXdjhVcFhmcnVIY1NB?=
 =?utf-8?B?RXBmRkNPcWgxUkNmYjBQZEVpYVg4V0J2QTNvdVljSFdIL2RHcnRLWSsvdEhv?=
 =?utf-8?B?VEhrekM3cytUU0MwSzhtOTdhRXJTSVBIRkNrTDRmZ0R3eExpK2hFOUJWL2Iv?=
 =?utf-8?B?R3d1a3F2NTZyUUYvRFFpTVdJK2RjNkh0QTR2U2VGUmRQQm9pT3VkR3k2MzhN?=
 =?utf-8?B?S3BSc3ltSUNKM2JSQWpESHhMaGRCZEpDV2dNZ0R1Y0twQXZzMG1OUy9TdVAv?=
 =?utf-8?B?dk1FMDlka0diZDhPUE90UkhpaGlsLzVXcVMxRHJNemQ0b0JLd2drcTVqRG9n?=
 =?utf-8?B?aDlOMkVISnc1YVBub3RrWEp3WVNLUnorZnZnc0ZaWGMwenlIVjZiZjA1MzNH?=
 =?utf-8?B?UGpHamF1OFlVTDRkQlpIYXZ3VjZ4VUZTbnVaUDk1V2VQTEJUM1FLellXQ3lY?=
 =?utf-8?Q?a5rRjzZmezx7OfMgsndkH0aH3?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee077ed-7db4-4ca2-0bfc-08dca7cbab32
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:20:37.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B200+oRpR519rY93ORodzYuykNdF1sClZqfaL1ggdmzeRy2duFMOD8RiufXmRHm7wfDjmPHqBzgTkdeq2ySsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8818

Dear Krzysztof

Thanks.

On 2024/7/18 19:40, Krzysztof Kozlowski wrote:
> On 18/07/2024 09:42, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add binding document for Amlogic Bluetooth chipsets attached over UART.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 66 ++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>> new file mode 100644
>> index 000000000000..2e433d5692ff
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/bluetooth/amlogic,w155s2-bt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Bluetooth chips
>> +
>> +description:
>> +  This binding describes UART-attached Amlogic bluetooth chips.
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>

Apologies for the earlier omission. I have amended the description of the

UART-attached Amlogic Bluetooth chips in the patch:

"This binding describes Amlogic Bluetooth chips connected via UART,

which function as dual-radio devices supporting Wi-Fi and Bluetooth.

It operates on the H4 protocol over a 4-wire UART, with RTS and CTS lines

used for firmware download. It supports Bluetooth and Wi-Fi coexistence."

>> +
>> +maintainers:
>> +  - Yang Li <yang.li@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: amlogic,w155s2-bt
>> +      - items:
>> +          - enum:
>> +              - amlogic,w265s1-bt
>> +              - amlogic,w265p1-bt
>> +              - amlogic,w265s2-bt
>> +          - const: amlogic,w155s2-bt
>> +
>> +  bt-enable-gpios:
> enable-gpios
will do.
>
>> +    maxItems: 1
>> +    description: gpio specifier used to enable BT
> Drop, redundant.
will do.
>
>> +
>> +  bt-supply:
> It's called "bt" in schematics or datasheet? Feels unusual. Please list
> all the pins if you claim that's a real name.
>
Yes, you are correct, the actual name is 'vddio-supply.' I initially 
intended to

differentiate it from WiFi, but it seems unnecessary. I will change it 
to 'vddio-supply'.

>
>> +    description: bluetooth chip 3.3V supply regulator handle
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock provided to the controller (32.768KHz)
>> +
>> +  antenna-number:
>> +    default: 1
>> +    description: device supports up to two antennas
> Keep it consistent - either descriptions are the last property or
> somewhere else. Usually the last.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> And what does it mean? What happens if BT uses antenna number 2, not 1?
> What is connected to the other antenna? It really feels useless to say
> which antenna is connected to hardware.

Sorry, the antenna description was incorrect, it should specify whether

Bluetooth and WiFi coexist. I will change it as below:

     aml,work-mode:
     type: boolean
     description: specifywhether Bluetooth and WiFi coexist.
>> +
>> +  firmware-name:
>> +    description: specify the path of firmware bin to load
> Missing maxItems
will do.
>
>> +    $ref: /schemas/types.yaml#/definitions/string-array
> That's redundant, drop.
will do.
>
>> +
>
> Best regards,
> Krzysztof
>

