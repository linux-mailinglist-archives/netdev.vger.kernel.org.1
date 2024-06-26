Return-Path: <netdev+bounces-107051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF591984F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4BE1F23AA2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131F191494;
	Wed, 26 Jun 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c1i06iO9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32AA157A5B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430496; cv=fail; b=iKSh68Gm5l0lXGJreiyqdRQ4OTFxQ4Oi/yZHx4Q5ExHp1GbLo0DNg0qBUT5ARFxOo4g1cm1As7zm6lxGYRvQ+qCi9TEVJC2M9TD8fSdELuJkLEvvkPwQoGe9looeCzRaTMneABTsl67wzpbe7/ei8RP2D8jrCIt/AswZZ+iDUIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430496; c=relaxed/simple;
	bh=xCM5Jkmhu25dvbiEw5lhl1uIrbo/4nogMBE8GY+iwaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EVDbPLYFMg14lM3CuBEqB/toekXKA/sj0GHQV+C2ihn7Y3HTaVs+ZYPqUNZcz5vNcAPlhxX+PJwAgQTtiiSfu7Rrrm3rrFAOmTvH/bxddYoRhvrIXRtDDMu5JMORVkxY58KWwp1ZUl2sGw91oB9guDVE+Hlj5RF2OglW0hXXwXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1i06iO9; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoGdsH7qlFYupZhb0t66XeNUe5Fevu10C2sUqSW7XQX5igx3pxN3PUJ92ZhV22AcFg25d5SVCJCf6ejbP4k/xdap5lVJ0L9ZDcF2hILNAsd0ZHFufsY/RHHmQQ4fRcKJq9KMk27UOCGb1P0MeJKOhZ5SCPKYeKI8rC6WkHftqAsFb649f8UUoVyC2ThE8YeCZwkSSemakHBV7AcaNy+UuAetaEjgfuW2x+KcEKQ+PyHMSkLqms3q46UY88i+oWCyvQBEtBmvzB0ltA3fAz/A4qttmGBewb9Fv0nF/qqbdI54hpVZDfoWuD7mzpg6XhOUG5aipp/vKiAb5ZEIEP20KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCM5Jkmhu25dvbiEw5lhl1uIrbo/4nogMBE8GY+iwaM=;
 b=hENvak/FWHMSvK7QZeeXuyQ1pgp65wIHfp6C+yWqf5CHRxTh926FiKpTe7UJ9ECW52Eg9eouKZHMyASI4h6g5Y3TP3k4GY4fKgAdtQblpMMMjqzM8b7qLrf8gK3+uf0rRZkGUMuOrGRqNLWf4cBXiakjhqKfrtXNHDjqUBcasLqsyLgN1ruIETqD9s2onGuQLamhLJEbEvD6dPqLqHBMwszCTDgH4e1c2OE/P20gMuJCOGgi6UQF97saXXUa++a9KW0NzKlrvxn2ex4RXf+EYYkEx4yA73+zznl0jkVUDgzQBsVLE5pQmNvm1g61VOP6qgCLFUUnJ6j3J0CdHBBNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCM5Jkmhu25dvbiEw5lhl1uIrbo/4nogMBE8GY+iwaM=;
 b=c1i06iO9cd+SHMfuFIHzoA/INDjTMoKVtkLAuLZW7Uv+uKHvGKhszfa0voUdxNm89boBCCjBxRLQh6BZq9z7+s04ETk8bb66b087Yi9pbPUf2b4sY6cBrXzRU0f+6LnNiWLEcG+MutoROQyyvOpCmxRuaEbXZed+isG0BwcRI0f6uiiiGM3ewomd5xOJ3EkM8nU2YsTVSKzIMmdjvW8simh4Fqo7uQ2K37LafUquqpMSVe3o3UujonM1sfMWLGLZJyJCUXLphzrnX0eFMSc/yfFR5AiNRCAayAmdtc+BD0XCekntBU1ny4YJTnh/f+obH/k0iDoNJgiPqZHafBt7Gg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 19:34:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 19:34:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Shai Malin <smalin@nvidia.com>, "malin1024@gmail.com"
	<malin1024@gmail.com>, Yoray Zack <yorayz@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Or Gerlitz <ogerlitz@nvidia.com>, Aurelien Aptel
	<aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Index:
 AQHaseFnKTBtfKTbY0Wl/k9rKbX3hrGwkuMAgBBFaYCAADaUAIAZRoMAgAAH74CAAD69AA==
Date: Wed, 26 Jun 2024 19:34:50 +0000
Message-ID: <d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
 <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
 <SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
 <253v81vpw4t.fsf@nvidia.com> <20240626085017.553f793f@kernel.org>
In-Reply-To: <20240626085017.553f793f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7356:EE_
x-ms-office365-filtering-correlation-id: 298ec384-82ea-4658-3427-08dc96170c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTZhTHlNRVRCR1dhVlNJa0ZHMXBrQTM0Ni83SFA4NEZSR2Z4VU1zOVVURXVk?=
 =?utf-8?B?Q20rM1JFeXNuWTJiajNNRndVUjlpeHdaaHhVbmphZ21PWjN0N3pZOFVvSGd0?=
 =?utf-8?B?eUhIeVZKQWd4RkpzUzBRYUo5M2F2V1JYVndObk9Ka1lxSk8xa1F3YmRZR1BN?=
 =?utf-8?B?ZE9qYnBlYmZUdUpMMXd3RnEzTmRnTVRCbFRSRlZ4NkZBYWtSRnFXaDVxR09W?=
 =?utf-8?B?VVRlZW92ZElkUmI3YWxuZWJicGZBRkVpcFZibDFCVG05c2hBZi9kNmlzbGpE?=
 =?utf-8?B?MGYxMkp3VWJjR1QwYnJVYU9BMEEvSlJDM25oc0FzUTNDSGV4RjdnTVRscmQr?=
 =?utf-8?B?RVJwZTF4a2lzejdEcmpkYmVCVHp4cWtLdnZLTzVjUG1WY0psRUN6RmhaSXJW?=
 =?utf-8?B?NmgrekYxY2pVVDUvNmJiVmdWVnVMU2xxb0V1WVlZY3EwTXczMXFVUnNycW0x?=
 =?utf-8?B?V3hqRGhPMHQ3RWNYSTJSMFRaUXpueHdZOFR2OWgyc1BZL00zRnloV05IOFQ4?=
 =?utf-8?B?R1VuUEhDUlVOWlZGVW1lS2xNQUs3aFVxQmd4bjV3ai85blB5S0hQM01YWmNZ?=
 =?utf-8?B?NjNYWUticmVma1QySFNMdW9UQnNkZFpya28rQ2lhT0RuYVdmTml2TEIrZjBo?=
 =?utf-8?B?N3dxWDU3TDlIRnUxSHgrY2JvT1M0Y2p0L09aQUVjdHFvbXVBSTdhVEppVnVC?=
 =?utf-8?B?UXorK0VwV1EySUpRcXpuVm1LazJEalVISkRvQVhsT3FCcEs1WjIvWUFuTDlZ?=
 =?utf-8?B?S0d5ckFoZksreXNwODhNeVZXZUtTZlYwVmZETnY1R2hMSWlNb2hnK2VHY1lN?=
 =?utf-8?B?NVVGa2x2ZllzR1o1R3F3Uk55WkhQZlhXSkhiYlVuWFp0OUJiLzhPY3JvVExv?=
 =?utf-8?B?TVJrTW9BQ1VZN1JOMnJiWXJLRldFaVF5YzJVdmZyVmdmWWxyUHg4SlUzQVRT?=
 =?utf-8?B?T3lLbTh3UHdvNDlELzVGTFRaSndVUVJ4amRPdC9JVzNLWTEzZzZNREp0Q3J4?=
 =?utf-8?B?Mlk2ZGNETzNtU1BsRDlpaExZV0h2OEdoT2tERFFybENjU1AvY2xSUVV6bjkw?=
 =?utf-8?B?cXpGUEY3a2ZFa1JQMkx5QWt2MWhNUGpPblp1YVFQT0NjZGp2MlZVV0xjelhJ?=
 =?utf-8?B?STlpMVg1NVo1NERvd1JDdk1qUE9TNCtvNDhVakkrUENOeWR3SEkwcjQwbXFQ?=
 =?utf-8?B?UWZHRnh0dk1tVXZheGo5bGNTaGpscHFCUm1veXdGY3B2NWhhQXJZUWR0VmlG?=
 =?utf-8?B?Vlkxa3JyUkg1RjFiWVhDWHB3d1dDbXVJcmYybWtBY09lVGdlOTVwaGxNMnZl?=
 =?utf-8?B?K0dNdmdZbHhJdmVHeVd1N3VqTStVZWJMbUIyZURuZVFtbFF3STZrZWZBelJ0?=
 =?utf-8?B?b0R4enJrdjJqOWNmRW5wY0lMdDg1QkFnK1BWdXZLbHhyQkpySER4cTBDK2FX?=
 =?utf-8?B?dTR2SEtiQytITnI2TE5ZSzJQeHc5R1BCbGx5clpHdTcwV0JlQ21UbVU2MUtq?=
 =?utf-8?B?WWZXclFyS2JqTzBVTUEwcEpjdlkxSHNWWmVjR1lyd2s3UjUzejRVcVE5TDEx?=
 =?utf-8?B?MmszS3hyVHNhK3FmRVJ2S3hoWU5ib29ON1c4b28vV0lyeEMxOVM5dE0rYWFR?=
 =?utf-8?B?ZnVBUFFTcmgvcWNRZkEzYkhuNFNFU0pWM1ZTT2x2VVZiQUZKQU9YVXBGaVg3?=
 =?utf-8?B?NUlIdDNFa3F2TzU4ckwzQ0JXL0xWZzNPRmo5NW4yNlNWR1BKcmo3K2kzVi9w?=
 =?utf-8?B?djFiQ05iNXAyUTNRQmszRHV1Z1dqS1BJcGRNZTAxMjM0bG1VbjlmN0g4RDdj?=
 =?utf-8?B?NWNYbzF5ZlI1ODRJQVJQeVdoUENNUmc5S1JNdWJSc2NrTkRpaTRmRUlnNlB0?=
 =?utf-8?B?a2FScDJSaHRqWm9NdksxcllseUlXcldaTlVEK0pkOVlWbWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEFiTlBySTFRL3RWUEFPOE4xOXRvSng0NWdrbjQ3Tkd0RXN6YVMvaG5abVBn?=
 =?utf-8?B?OGVLWXNKQzIyNTJnOHBVQm91MTRHOWtGTG5QQnlMZEcyUitFelFJK3FNelFo?=
 =?utf-8?B?eXFBOU0wOU1wWUdDVkh4S05UMXR2VXlCd0pZOTBnSDNBNHJiOVk2NVY2b2Jh?=
 =?utf-8?B?TTAxNGpOOWxoejBrL29ZV3hYM1hCMmdhUFFkVVdKRlREWEZwamg2UXlYY0JP?=
 =?utf-8?B?b29mazluS0dsMVdhZlBmV2JtTUZ4ZFZCTUR4RnFnSTY1WDZqbzlrQnU1c1J6?=
 =?utf-8?B?cVFSaklPbFB3alNibCtpaEVvSHozZUIxUmE1aTh6Z0hDbjQ5ZXNEcmliZWlQ?=
 =?utf-8?B?N1QxdHh5WVpXUnNJcTBTSHoycDFTODhKWmpHMGZUdy9MTUJmUy9NeG1GTWQw?=
 =?utf-8?B?RDFxUWZsd2psSjJYMmZiVDN5SW1qeitQWFNIUlVFT3EwWmw1dVZsZWc4cTNP?=
 =?utf-8?B?ajBYQy9xMVpjbnZwVWN6RjVvRzNKT3p4bmpVT2pJeXNCaUtnNDd2TkZiak9X?=
 =?utf-8?B?OVRoRzAxaGRPZEhYdGpmZ3VrcjFKeWxtaUUwL2FtQUVtVjg2ZkVNMnJlQktY?=
 =?utf-8?B?NVVEc3hPMGpVaGMrYVpTVkp2SVYwZEdQUTNFNHlYRGlCTGtuVGhKaGM3ZjVt?=
 =?utf-8?B?VkRHaElVeitSK0s4NndKUmxTc1ZKNWRkN0RLMkwydTEwNjdpZko1S3VnRi9h?=
 =?utf-8?B?elNRdHVsTTFhblV4S05qWUlUc20vT3F3WE8zb3Myalh6c3poSmZRQkNJaGhY?=
 =?utf-8?B?T0ZzbkJYQTJJUE9JV25TU2trQmxPdWVxTTBqMUlUV0IvaDZKbUhmdHdhSkM3?=
 =?utf-8?B?TWFCS1RpSjlKRnVGTEt5di90eVBHa1lyRHRVUzhDcWhxSUE2eGE1a1I5WnJY?=
 =?utf-8?B?YnU3cUN0L0R1TzNaYVU1OVNTdTJ5OC8wU2ZBcXU1bmlVbFp4SmNqS3Y0eFRQ?=
 =?utf-8?B?aUs2Q0VGNnpINEdkNGZlcmM1ODJaNHBtWVg4RHo5Y29kV25WQkNFWkhNWkhl?=
 =?utf-8?B?RUVaNlFpcmtRY0tCWi9jR0dRMlVVSXdGcDZ4WlNDa2xkQ005WHQxVkNuUUdH?=
 =?utf-8?B?TndVd1duUjFldXFUdmpYTnh4VXVsOWlMalZiMWZCNXBWUjhBdGx4RkxSUzdj?=
 =?utf-8?B?dlM0eE1FbXlTdUh6bmhBMlI5SHBpQ2VXcWs2Z2dNTmJZYjc0dGxwYmtIUy9x?=
 =?utf-8?B?aDJwcFNld1c4eGh6REh2MGc3cXlTa2NYbU0rd0Zya0RLM2ZNdjRQeCtLdmFO?=
 =?utf-8?B?WXNJZ0g3cDBxMHlUNnZmb2djQjYydVArZzZmbnlEVzdEeXBOTnhvWTIzRVI5?=
 =?utf-8?B?Rk5KK0o4a0YxeGhhaUt4cW93Q3F2UGpqWWF1dTh4Sk5GVUQ1aVI2bU5WOGlC?=
 =?utf-8?B?Uml2TVFyN0VYSG5IaytKQzJoSkMxR3lSNCtEUXl3RjlaOGpObGdjbkd4QjNj?=
 =?utf-8?B?eTVFam1TSW40c2pGODlFUlVkRDA0RW5kUEloSytGSlMxeHMyRjJXOUdVaDRO?=
 =?utf-8?B?cTA4LzN0OFQrejBIWDlMdDg1ODJicHhhQUNqd092WGZaMWJjNkkzZFZZeFFw?=
 =?utf-8?B?TXQ4RlhlWWwyaTVjQ3JGRjJ3TEFidCtIT1pnOUpkYlhGTHl1ZEhNM3J2bHdL?=
 =?utf-8?B?TUsrR2IxQkpBVXJMc1RUV1FVRGJ6emVsbXJCUHR5NzdjYVBNZFRUbHRWZXBX?=
 =?utf-8?B?aEIvTzdMVmZsNnhSdmUrMkVoaDJvUCtTTHArd0pjSlpKNlRxZmRUMkMzZVp0?=
 =?utf-8?B?OXdMbnp4ZWtzdHc0UnNQWTY3blBpRVRyRHZ6UGJ3SlE1U3d2YXZCVDJ4WU5h?=
 =?utf-8?B?WnB4V2ZzY24ydWxrZUFWcjlOdk92ODBHY2IvR1ZzYS9GdHBXRUNidmZ5Y3JW?=
 =?utf-8?B?YWExQ1E3em5oakNwbkNTVGJ1SFRaZUtQS0pheFhWS2h3S0FhWmM1OEJLSXov?=
 =?utf-8?B?OXZsMmpsUWRod0hUcVhrQm8yY09PcmF0dFozT1YvNlVOYlZld1h6YjdCYkR0?=
 =?utf-8?B?WGJ5amhPYzFQaVIxa0lDS0M3TStzaDF6UXNOOTVjbmhQQUlzOEZHVHZjcDNm?=
 =?utf-8?B?ell3dVJLTmJnQWdIbGwrL3dyalVFc1N6WWlFMVZ1YjVDdGtLNUNmSEZzZUlt?=
 =?utf-8?B?L0NPWWF1ZnNkQUF6a0FQdUJPNGdaMGdlenhQNC9TNk0zVDZTQlJiQVUwQmYr?=
 =?utf-8?Q?aHKaoepKI/C/c2SLoQAO/3semaAhCxLcn81R5YuYIVJZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88898F0D95A81E44B83F467322EC3A1A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298ec384-82ea-4658-3427-08dc96170c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 19:34:50.9546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYZLrlMahtqA/4zOba/6DWQ0cNR8cRnrQbX/X9TTmm0TVXB4Jo37/DE/ZtzLnwNEcMjiK5i+SLLGvHTnMNioGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

SGkgSmFrdWIsDQoNCk9uIDYvMjYvMjQgMDg6NTAsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBP
biBXZWQsIDI2IEp1biAyMDI0IDE4OjIxOjU0ICswMzAwIEF1cmVsaWVuIEFwdGVsIHdyb3RlOg0K
Pj4gV2UgaGF2ZSB0YWtlbiBzb21lIHRpbWUgdG8gcmV2aWV3IHlvdXIgZG9jdW1lbnRzIGFuZCBj
b2RlIGFuZCBoYXZlIGhhZA0KPj4gc2V2ZXJhbCBpbnRlcm5hbCBkaXNjdXNzaW9ucyByZWdhcmRp
bmcgdGhlIENJIHRvcGljLiBXZSB0cnVseSBhcHByZWNpYXRlDQo+PiB0aGUgYmVuZWZpdHMgdGhh
dCBhIENJIHNldHVwIGNvdWxkIGJyaW5nLiBIb3dldmVyLCB3ZSBiZWxpZXZlIHRoYXQgc2luY2UN
Cj4+IHRoaXMgZmVhdHVyZSBwcmltYXJpbHkgcmVsaWVzIG9uIG52bWUtdGNwLCBpdCBtaWdodCBh
Y2hpZXZlIGJldHRlcg0KPj4gY292ZXJhZ2UgYW5kIHRlc3RpbmcgaWYgaW50ZWdyYXRlZCB3aXRo
IGJsa3Rlc3QuIFlvdXIgZGVzaWduIGZvY3VzZXMgb24NCj4+IHRoZSBuZXRkZXYgbGF5ZXIsIHdo
aWNoIHdlIGRvbid0IHRoaW5rIGlzIHN1ZmZpY2llbnQuDQo+Pg0KPj4gYmxrdGVzdHMvbnZtZSBp
cyBkZXNpZ25lZCB0byB0ZXN0IHRoZSBlbnRpcmUgbnZtZSB1cHN0cmVhbQ0KPj4gaW5mcmFzdHJ1
Y3R1cmUgaW5jbHVkaW5nIG52bWUtdGNwIHRoYXQgdGFyZ2V0cyBjb3JuZXIgY2FzZXMgYW5kIGJ1
Z3MgaW4NCj4+IG9uLWdvaW5nIGRldmVsb3BtZW50LiAgQ2hhaXRhbnlhLCBTaGluaWNoaXJvLCBE
YW5pZWwgYW5kIG90aGVyDQo+PiBkZXZlbG9wZXJzIGFyZSBhY3RpdmVseSBkZXZlbG9waW5nIGJs
a3Rlc3RzIGFuZCBydW5uaW5nIHRoZXNlIHRlc3RzIGluDQo+PiB0aW1lbHkgbWFubmVyIG9uIGxh
dGVzdCBicmFuY2ggaW4gbGludXgtbnZtZSByZXBvIGFuZCBmb3ItbmV4dCBicmFuY2ggaW4NCj4+
IGxpbnV4LWJsb2NrIHJlcG8uDQo+Pg0KPj4gQWdhaW4sIHdlIGFyZSBvcGVuIHRvIHByb3ZpZGUg
TklDIHNvIHRoYXQgb3RoZXJzIGNhbiBhbHNvIHRlc3QgdGhpcw0KPj4gZmVhdHVyZSBvbiB1cHN0
cmVhbSBrZXJuZWwgb24gb3VyIE5JQyB0byBmYWNpbGl0YXRlIGVhc2llciB0ZXN0aW5nDQo+PiBp
bmNsdWRpbmcgZGlzdHJvcywgYXMgbG9uZyBhcyB0aGV5IGFyZSB0ZXN0aW5nIHRoaXMgZmVhdHVy
ZSBvbiB1cHN0cmVhbQ0KPj4ga2VybmVsLiBJbiB0aGlzIHdheSB3ZSBkb24ndCBoYXZlIHRvIHJl
cGxpY2F0ZSB0aGUgbnZtZS1ibG9jayBzdG9yYWdlDQo+PiBzdGFjayBpbmZyYS90b29scy90ZXN0
cyBpbiB0aGUgZnJhbWV3b3JrIHRoYXQgaXMgZm9jdXNlZCBvbiBuZXRkZXYNCj4+IGRldmVsb3Bt
ZW50IGFuZCB5ZXQgYWNoaWV2ZSBnb29kIGNvdmVyYWdlLCB3aGF0IGRvIHlvdSB0aGluaz8NCj4g
SSdtIG5vdCBzdXJlIHdlJ3JlIG9uIHRoZSBzYW1lIHBhZ2UuIFRoZSBhc2sgaXMgdG8gcnVuIHRo
ZSB0ZXN0cyBvbg0KPiB0aGUgbmV0ZGV2IHRlc3RpbmcgYnJhbmNoLCBhdCAxMmggY2FkZW5jZSwg
YW5kIGdlbmVyYXRlIGEgc2ltcGxlIEpTT04NCj4gZmlsZSB3aXRoIHJlc3VsdHMgd2UgY2FuIGlu
Z2VzdCBpbnRvIG91ciByZXBvcnRpbmcuIEV4dHJhIHBvaW50cyB0bw0KPiByZXBvcnRpbmcgaXQg
dG8gS0NJREIuIFlvdSBtZW50aW9uICJmcmFtZXdvcmsgdGhhdCBpcyBmb2N1c2VkIG9uDQo+IG5l
dGRldiIsIElESyB3aGF0IHlvdSBtZWFuLg0KDQpqdXN0IHRvIGNsYXJpZnkgYXJlIHlvdSBzYXlp
bmcgdGhhdCB5b3UgYXJlIHdhbnQgdXMgdG8gOi0NCg0KMS4gUHVsbCB0aGUgbGF0ZXN0IGNoYW5n
ZXMgZnJvbSBuZXRkZXYgY3VycmVudCBkZXZlbG9wbWVudCBicmFuY2gNCiDCoMKgIGV2ZXJ5IDEy
IGhvdXJzLg0KMi4gUnVuIGJsa3Rlc3RzIG9uIHRoZSBIRUFEIG9mIHRoYXQgYnJhbmNoLg0KMy4g
R2F0aGVyIHRob3NlIHJlc3VsdHMgaW50byBKQVNPTiBmaWxlLg0KNC4gUG9zdCBpdCBwdWJsaWNs
eSBhY2Nlc3NpYmxlIHRvIHlvdS4NCg0KSSBkaWRuJ3QgdW5kZXJzdGFuZCB0aGUgImluZ2VzdCBp
bnRvIG91ciByZXBvcnRpbmcgcGFydCIsIGNhbiB5b3UNCnBsZWFzZSBjbGFyaWZ5ID8NCg0KLWNr
DQoNCg0K

