Return-Path: <netdev+bounces-139435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21249B24C7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381C3B21719
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9918CC16;
	Mon, 28 Oct 2024 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="AMMrOFd4"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021073.outbound.protection.outlook.com [52.101.129.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CA18CBF9
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095115; cv=fail; b=V5DXCNUcPNdJvRQwfY2KgGvBGMj3jtooPAyVK3x2zapQLidxkmha/TRFb2LJ0E70/cJm84niadve312/78A97LUwsjnUtn9lonQPqxnw7YYfdDqsC561DlI0L1wjVYvBHgA1h9i8ZSrdKXHug/eDWjYvGIm6a1dtMv/JtmpvgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095115; c=relaxed/simple;
	bh=f7g19JsciQmWwUJnJWHlJeAzX691A68qjeg1OmPrrSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qr2Tc+4CpCc7Q2sY0rvEGqxIEOiZWHgBY7LAZSjWNDsK+vWh5aMz3lgBm2ZGwOPyzrwS6qxVg3oP3QmIlUZKDQjOyBx0HbBPGfGDhQ0LOLM+gI8QyvOPV6/PLaOEibOdkLjiMtNWTWx1Zv9BCPF8NdeKmY7cX2rLfLKIV0vH0i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=AMMrOFd4; arc=fail smtp.client-ip=52.101.129.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkHIdwlM5quKb6MbOLPMmOYvD0TjKl+zkMHmOPIoKXk9L4g/lKqLi/YeNiWt+BKVhoRXGH3wTyjF0CbbgX6Nmg5sZWtwOcguQ0qiLHFoQU/wlQdBCrrhP2kMR6QvYlBAaTIFymEg/IkjnTzK4J3u98LJfCm5z8fXe/oO9CAYxUbLWgt63k4EfBJ+G1Rr6we9/2Kej0Ofm3mbuhpvLyOAK8BrgD9zDq1+k4+DcNJfUq3AVeHDhGf/Hh1BBY+LGKHq4QQgPu2xV8P8wL7OZn4NdizFp+AJAghAI9OLAtVtWvq4/6jr2vhdbEQeRxFYtKX3kdb6uZD6yam1FWhIAC0O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7g19JsciQmWwUJnJWHlJeAzX691A68qjeg1OmPrrSA=;
 b=DFQL1pWXZbii5JbGuU6OP4lXNOoj5xOpgB26ydwipqoXdawRGNZ6xNI7t8Kg7NHgXAqf+FmWgkfDkh34ptXAuipG+QjrayNcg8vFsKrqvepRKJ8r3Y5ur+gOjSGBJH9jGJKGzNhUtDg5+VTXnNf2Npygnu4n1lx9PqSMKbCwzQXHOOFXib+0phpGoGjRKaLpA0/ClGU1437JwPJeZi3EuW0n8DAuKC7KZMPu1jjv3tgEYS2c5dfSe31qeeB43bbA5BT8yBnl2aszLO9B+Ln1jQdv1NxtvSs21XFwB4+4c485DpJgk8PiTYNsf9v4ZSXv7/umxWYYbGboEoi4cIN8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7g19JsciQmWwUJnJWHlJeAzX691A68qjeg1OmPrrSA=;
 b=AMMrOFd4cytvhhHb9Y3N39A77hbiay/OOtRiu0XGqeLevSh8rYO1CP5Tgr9Jf54UMZb1A9zO4YlLvmVP7L/EVVvYHQmHZTMS41GoOop9tIqY9hTX5Du0rs/YcTIlf2TYRygpPCjaSD7gJAzcCip/y2jjVoId9odDUbpXMzVUfnL/8wx+DVS989zMfYZp1bjekuk45YlJ+sNJIrFJZ249KkJWGA6/IELpoYumsvIAB+Ig9xGnxni3rA6GG+YoBY6fPHJCobE73m6p4i3T3uCmfh0/fhZ7GBhWESjVnceg6eqZlQgcf8ip+dOlp8/M/Strpn86KxbtNSEdcHMKQT+Cpg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6700.apcprd06.prod.outlook.com (2603:1096:400:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15; Mon, 28 Oct
 2024 05:58:25 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8093.014; Mon, 28 Oct 2024
 05:58:24 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, Jacob Keller
	<jacob.e.keller@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0IDIvMl0gbmV0OiBldGhlcm5ldDogZnRnbWFj?=
 =?utf-8?Q?100:_fix_NULL_phy_usage_on_device_remove?=
Thread-Topic: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
Thread-Index: AQHbKPV5hLNNCb3wiUWcUEoqMQ8DZbKbpyyA
Date: Mon, 28 Oct 2024 05:58:24 +0000
Message-ID:
 <SEYPR06MB513489CAF2A14D7DD5B32DF89D4A2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
In-Reply-To: <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6700:EE_
x-ms-office365-filtering-correlation-id: da675a64-4bdd-4b31-0eeb-08dcf7158912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aW1ab0EvZHluUEpGdXB1dDhWdmtwT1ZUeU1BcWxZcFJ2Z29qcVNRaXdJN2xt?=
 =?utf-8?B?N203TmZhSjc5RXNtcVhkWFNDZGpRUTVieXFwN3RaU2UwcEtnS29abFQzNFZ4?=
 =?utf-8?B?QmdOUnZDUDlqS09UYWZ0L0c0MElHM0NXZ042b1N1ZXJ2SHdiK2huSndoTnNl?=
 =?utf-8?B?WnRMYjNpalpsNDlsMjVWTWwzckNlemVOVktBYjhGTU12VW5CNjE4SGk5MGtm?=
 =?utf-8?B?aTFNUDJkc0ZLVDZNYWZKUk9ZV0kxMCsvWVgvczYxTnhIajRQVUdPVHVuNVV2?=
 =?utf-8?B?dXo0ejBEK2gyU3E2Q0d0YlhnckFKazZoVU5yYWl1OEVzY1FxM1k5NDY4cjQv?=
 =?utf-8?B?bzUxMmRrZ1dGNzJRbHZBd3hOc29Tbm5hT0poK1lMUUxWUFlvTzQ2ZzFMTzRD?=
 =?utf-8?B?R04vUXFJcHBOd0d5N1krQjJJNXhFazFEclVCOXdPdVpUOEdXK0dFVzk1anQx?=
 =?utf-8?B?aW0vc28vWmxhS1kvM2V1cm1QWElZdG5OT2dJMnlNUFJLa2k5TGJLTFptVFlJ?=
 =?utf-8?B?NGliYkNqcEc0S2ZNUGVxS0ttVWYxYXljbHhuSWtrUVhsWGtpcDNOQ2F2cDZ6?=
 =?utf-8?B?Tm5KSjJodGRGYndyMGJrZFNMSlA0dG5sSjRQZFZMeC8rRjdFNnhLNnZVYlZh?=
 =?utf-8?B?ZUlkbFljUHdnb3ExVCttQ2laQ2xhSUNudnN6NDE0OTdWQ1VCMHBwd0Z5SDRE?=
 =?utf-8?B?M2dJMGw4VTZjcG9MOFU0RXBkRUJBVkpoUjFyeXRFU3VRaCt4SndQejZRK1Fa?=
 =?utf-8?B?TWlQYmYzWDkyQUd0WXhybUNsK1NGRTF0bTlWMXNVRzNmblF6bFp3SkdTdUtt?=
 =?utf-8?B?cWZYYTVzYUJzdEpzaTB0cWY4L3BnY1h3eWcyMjVoK3BTR21HYWhvaHNQM2xC?=
 =?utf-8?B?YS91M0ZyTldRbXFjL0ZXU3cyNWI1cVltcHpSeXVFaXlSTDdWTmlUNWo5MWJr?=
 =?utf-8?B?WjNPdjhMaCtMRk5oWlJhZVh6cWJ6RTNxK015LzI2NzJrMGI0VDZGZDhWWEJV?=
 =?utf-8?B?S1Z5aG1wWFpuM25Ka3Mxc3ZXMVFqdkpUODFseUsvYW81K3hZekZXVlRDcHZ6?=
 =?utf-8?B?OW8zTGk0L0dvcSs1ajhWTjJnWDdKNytFY3lpWmtySDF2L2dkRmZNV1RnZC96?=
 =?utf-8?B?QTBGUW84b2xmVk1sUEhhTGUzUWpaV0ZBTjRzL3ZqZFhYRnZ2Rk5kZDZCelZR?=
 =?utf-8?B?L21mTGIwaTlpbjJ6WW8vaElpYmhaZld4RHMxQTFJRE1OTll0UjJDdTJ2TXJ2?=
 =?utf-8?B?M3pRSW9UR2VJZTI4VEpJSlVmaWRrOFJGYndNMHh5OE1QMDJPaWx2WDdxall3?=
 =?utf-8?B?K1k0bCs0Q1pyOG5KR2VtQ25zWGJRTENEdnNrMzlZZE9xTkl2aVJUWitlZERT?=
 =?utf-8?B?MTJLMUVOUWIzbFcvbVhCaEhXS1IyNnhMVG4yRFhSNmJqVG5vaEdxaXFKUC9q?=
 =?utf-8?B?RVpuYTZxMDRyRTB1bFZBKzk1OXZHN1hxeXNDbmprS0RyUUUwMnQvcnlzRzBj?=
 =?utf-8?B?eXpuKzhyY0VjTlhsWnZ1ejdyM3VlOGxwWm90YVBlU2dibEdnakhNQndZYjBu?=
 =?utf-8?B?dVkrNW5Ddk83SHoxS3Z2OHNBVERMTGxHOWw5c1BrbWJ5YjlCb2tBREliZWhr?=
 =?utf-8?B?VzdOT0ZnQnJMQXYvOW92UXUwUVNSM01YZHdHbi9xNytqTEpNd1pMZElUdzc4?=
 =?utf-8?B?a25rL28yT0lkcVJEalNtMEJXR2hFQmhJOVM2Nmo3QzJQN3FxcDhOa2Q4bjhR?=
 =?utf-8?B?YUhVYUlPbUlVa3FnYjUyMllLcG5idlRDaDJ2alZ3UlJUVTZVNDlsd1BxelRF?=
 =?utf-8?Q?IOaoIqFBZ9o8hzaMkmnycWvbxCXhfoZNGW4Ko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWViT1FSNWtjaDMwaWJyZ2NLcDFwNXc0cDIvOGEyOHhhUHFQSWJHU1pUT3Rj?=
 =?utf-8?B?VmhJcGprR2hjMEdUaDJ1c3IrKzc0T0d3M3ppVi9Nb25qbk1rQUxndTNGMWJl?=
 =?utf-8?B?OE12cW1YNlBGNktQUGVqSEF1TEY5NDR5d1hYU1A1S3k4azhlcVdwYzVhWXdT?=
 =?utf-8?B?eit0SlBFbExQSkJleUFQYnBHdy9PU0lVNWdPK21MdGRZamp0Q09kUG13dndy?=
 =?utf-8?B?OVErNXBpU1RpRnUwV0J5MWVWeENvVjVwNmxrZEVSWG5uK2JrRCtXUGx5UThu?=
 =?utf-8?B?R0sxcVBNVXF3QUZBd1krSUlrd2MyOVVJMXVRUUxlK2YxRytKRWoxSXhZaG15?=
 =?utf-8?B?cWc1NzI5RTVKNVpLYWxsbWJ5UE01ZGZweFI3UEhzaHBnSElJMWVmTTdBSW1L?=
 =?utf-8?B?bmlzdFhSRCtxV0VBZ0VDQlhjUFJ3dnBvNWdKMzgzN0NmVThISjZzTkF1d2Fy?=
 =?utf-8?B?NkpKWTV2NkNicEpUdEpjZFNRRjZldWJwZWJ2c2tBdGlmRjNMSGp1U1lxbUpk?=
 =?utf-8?B?ZXZMTjdwQXVmOFpPbkEydVFFemRUakQ4dHpmT1AvSGY1cE5HQ25JRXRDVGNS?=
 =?utf-8?B?VW9GblRqTDc0eTVCVW1Mb2Z2cjNGbVhLejNCRE9hZzdoY3IvVm5iMmFzejBZ?=
 =?utf-8?B?em5Zb1RVMmt1Wjd4NjZjWDB1ZE54RmRqMTVqY0RiYkYrd3pxSlJ6LzV3Nndn?=
 =?utf-8?B?bmNWYkdXY0pUUzA4NEhOSW9UcVFJdWwyWTZHUEw1VzNBeEkvaXZmMVRWWmhU?=
 =?utf-8?B?cTdWVU1nVGI5QkRFZExmbng1THBKN0MvSWhrWDBYS2xSbmNvaXg2aTlLOGh6?=
 =?utf-8?B?VWJSamFkeE5sZGQ0ZDB1K3RtdTB0cEFXZWlUZWJSSVl0elNZMVJoRFBXVkor?=
 =?utf-8?B?S3R3OXlSWkhwS1E4dEFCZ2ZaTC9Ca3loTmlvblF3WVpBN1F5ZnMzWWYwQnBW?=
 =?utf-8?B?dEFOS2txS1RKS2psTjJEL1ZNak5XdUJha3F1emkxVnlyOTR5U0xGVHlQWklX?=
 =?utf-8?B?UHRnZ3ZKUU5KR0VvRVNMRUV5NVZ6OW1panNZeENvbjR4UkZhbFBWcUR4anM0?=
 =?utf-8?B?YlhCdHdIVVZ5c2Y1WmpkYVZiUzRpeWltdHptdnA5bm1oRDdrd1NwOEI4RmZM?=
 =?utf-8?B?NEg3RVk4cUhFeFN2c0pja0VRaFZ3aUF1TzJMTnFWeFhBZnNMRDErRkQrbjAw?=
 =?utf-8?B?QTBLczVFZVEzS08rQkZIU2huL1pTR0EzSG1Ja3lTWndzekhxaUxRV1hzQVF4?=
 =?utf-8?B?QnZzL09XQm8rOFh3VTUxYVdYcUtwejByZXZ0NElqRTI1MGlGdlB0VXF5WHVP?=
 =?utf-8?B?LzR4QktHSDRrdzc0eHVsSnBzekdteDNGVWhQUUcwOTNndWhmR3JJOGdFY0pG?=
 =?utf-8?B?OFJnT1JCZHQyODJUUk5TNHpXTlVVSjBTOTQ4NGtjbmRicDBLWDhHaFZ4RG8z?=
 =?utf-8?B?cUxmdDE5U2dSMzg2S1FHaFVHeDRxbWV3V2gyeVlxMjFjdEVjZm52aU1lZmE3?=
 =?utf-8?B?cnFJZDIxcVJMUng3cjgyRXphbUloZEtDSDJIV1hQTVdRMUxvblo5d0lIS0hu?=
 =?utf-8?B?Q2VudldyNmxCSjF5bXNBUXJYS1hiOUViMENTZkd3Y2VGRktleER0ODEvMGE0?=
 =?utf-8?B?ZEtnV0FnK1NncDJBam92dkRjV3ptUDUyTWZUa3FGaXZhRDZIbjFIa1hkb0lk?=
 =?utf-8?B?djZGYmZWRjBGci9QdWw5dENmZDNmRnpsZVd3amRtbXFacE11RHdRcUpHWWE2?=
 =?utf-8?B?TWRtM1RGa25oQ0o2L3dyY2pENjgvZzRXc0VzU2g0TEFrS3BGL2IzNDlvdFB4?=
 =?utf-8?B?ZndYUWo1SzloSDYzczExNERsdWE1aitQM1lGeFRNdWFVTmp5YU1TeEE3clhh?=
 =?utf-8?B?WDlGT3ppN2VrL2R1dlowZVVUNUZqbTEvR1IranNzR0RFakgrcXAxbVVSbCtR?=
 =?utf-8?B?TmdUcjB3TEdYaWtJWXVBZmtJUlhEdmxtajRGd2ExOC9ZaElSOXc0d01YQitv?=
 =?utf-8?B?aDhSYWtHUHEyMTY0Z1RvTWFVZ2IxYjBMSXRhL1RMQzM3aWJOOExsREg2UENs?=
 =?utf-8?B?MTZuZGZhZ0ZEaXA3bnNuaXFLNFpsSWhzMUd4Y3M0cnlkK2IrV09idTR4UUd4?=
 =?utf-8?Q?ee4s6hvB4+9+MQP8bocOUTLFG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da675a64-4bdd-4b31-0eeb-08dcf7158912
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 05:58:24.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvucSckJZPHOxq0aS2zrrgY+fXM0Bv5D7U4WH+Mit5L22l+mjM052FsEG24DXnUyI0yP3RDf6JSwGll338m8Cr9qPlL4RnW1OnjAaXhNX5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6700

SGkgSmVyZW15LA0KDQpJIGNoZWNrZWQgdGhlIHBoeV9kaXNjb25uZWN0IGZ1bmN0aW9uIGFnYWlu
Lg0KSXQgd2lsbCBhc3NpZ24gTlVMTCBwb2ludGVyIHRvIG5ldGRldi0+cGh5ZGV2IGFmdGVyIGNh
bGxpbmcgaXRzZWxmLg0KSW4gTkMtU0kgbW9kZSwgaXQgZG9lcyBjYXVzZSBhIGNyYXNoIHdoZW4g
Y2FsbGluZyBmaXhlZF9waHlfdW5yZWdpc3RlcihuZXRkZXYtPnBoeWRldikuDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgaGVscCBpbiBwb2ludGluZyBvdXQgbXkgbWlzdGFjay4NCg0KVGhhbmtzLA0KSmFj
a3kNCg0KUmV2aWV3ZWQtYnk6IEphY2t5IENob3UgPGphY2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+
DQo=

