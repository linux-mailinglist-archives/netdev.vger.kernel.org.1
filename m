Return-Path: <netdev+bounces-116001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C02B948BFB
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F401028292B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C181BD4EB;
	Tue,  6 Aug 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5I6LUeo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35408161900
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935393; cv=fail; b=GOHdeGNwBPdzQkYhcfTQqxGudiB0CgeFckSXw+cLdOdw3rR/BuPKStdVFG3gD7tNvL7fi0qaSD1B/QRANM4rfGcA44t6pwDFJcrHiNbOPbUg68J4K7DWIIixJRFXn7NG3HrnfdTX0AR180jaE5hHUEI7gf3d+BTzLyKbT3/v4PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935393; c=relaxed/simple;
	bh=zh/AiaIzwtfBCi+jxRd3cC65j1KkvLHscudfucsHzyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOc77Fu4kT0mAAsd/DQADPmirG+yCGCMyYZTRXhk4ZnQ9d/JepiOUSuVIsX/ohJ1zg7qz87oyziQ5ZYInWd92n/YRmoA9eZ1LF08LDU3Q0rPDNrTHaQv3Me1rrQo59B8yKJJfGc8zSpInXW7aSy5QvDdwFNeiCYeXICNI1/T2To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5I6LUeo; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWuVKUkr9tk+vtArQjmFc0V06y5XvG8lFdE4LGRhRMuNhbUHB46/t3lrOf3XJELM0GB46QhRcXJ6Ixvtp5F1TtA5STtjaoEXq0nO6t29PkuX/5nbfML696R4WFElCMVQ7qFzl7dKYrShFK7DR9YqJ496g26W1D72rRdNCFRHlsVpj8RgIe3Y/C/DjCgcwz94swAQGx+Squoegw5035XSxLq+I6P4aydkkhZDHp4szANAgaUG+s5uARpAafdTWvpE7TUsKKt+8wRaPM0TBKGC+d9sJQQ8ze7bbr4qOnhjic0TKf26aJeUiXypimA3TapTDnojmQqi3QG2AF3bHKHbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh/AiaIzwtfBCi+jxRd3cC65j1KkvLHscudfucsHzyo=;
 b=yZniGmgVSMuIbEw9roRg7RgGII354VfTwhPo7YwepNEPSe6AdBu73fumdggQEnbCNuCeQXHEol9YDly9dp3C6EfjZE8/s+3mTcZUtQbf1Oe07hDPevK3yuTcQERp1uoj1ZZn5Nz95Bg/IpBsC+nC+D5CgaTm5075xgJgkGSJzBZNiPiW2d/F2bHkokG06LF3hge5OjTgSyz2U1uX/FyVhXhFEkXsUtFHLufyXSerw1N1xlQfo0peXLjRHTkKqxViY1wSkVGDcc/lZO21ADiD5KMe84Gln8dEblKq42iDFyypYNGr5peqM+934KICUK62gUIkLqHeV9PQB5vTtNMLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh/AiaIzwtfBCi+jxRd3cC65j1KkvLHscudfucsHzyo=;
 b=X5I6LUeodrpTvzCSbhmgGRE+55JRAKj5rsK0Y0oY0iIsWadUlvUgpMQpKoVyPDDvrhku7/l749XV4tFxgjiPzQOloYSlsMgduGfJAbkygLT4zLpvWk8lngOD6dpwa5ylfYNyU/I5bxivjiTzF+r5nxGB2O9dCIoA5modFYbShqJMJgOkK//YuF73B+wSsFFaMbTlOYBu/hWlrHQLbBhy9hkNDNzqPrHMbGzaGjjV+CiYOao9wYWqZFR/ubk0g7WPhd7CIDFKj5A0iA1XvjRyzIE/7akVYUtW35OVrcljaxdexIwaeZ7j7F7rz6UKwU1f09gv9LyLZQdbapnkIj5rKA==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 09:09:47 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 09:09:47 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Leon Romanovsky
	<leonro@nvidia.com>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal Pressman
	<gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index: AQHa5vUrWi/gseXBCEqaGlxcFyce2bIZ7BgAgAAGwIA=
Date: Tue, 6 Aug 2024 09:09:47 +0000
Message-ID: <42393e6f05796b4af74e024eb28b6236cf379232.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-2-tariqt@nvidia.com> <ZrHisKjAQPtbBJFa@Laptop-X1>
In-Reply-To: <ZrHisKjAQPtbBJFa@Laptop-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|BY5PR12MB4098:EE_
x-ms-office365-filtering-correlation-id: 867de791-7144-48f1-d921-08dcb5f78515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDJOWW9tdHp1cWlONGNJeXMycTdJTm5aWllXZy9Hdm1COEFHN1lFTUNLYkhF?=
 =?utf-8?B?aW14Ykt3QS9LWDAxdFg5VG9OZ2NNMUxTSlh0YkY5dkRFL0k0MndjK1FHT1dX?=
 =?utf-8?B?RC9oZmFPWVdIbVBFcDFxSklJMVFOVG1uSm5QRmhJajFTZHc3U1A2NUt2ZjVt?=
 =?utf-8?B?bHh3ZDdaS0hVSHBtNFprWjAwczkzblYvenFmWkhqQjJIejlDU1BlOGhjVThS?=
 =?utf-8?B?OHpkYXZzLzFUeUo2R0FUelJYUHlnV3RhVzROemJ0NWpVejVNejY0U2lIWWFV?=
 =?utf-8?B?bzFnLzVxNDZ0RWhENHZ3M3Q2QnhzVFJlTmJyeHppRUl1VUc0UHdoZFVDOEpv?=
 =?utf-8?B?N0lhTjlaU1NqSk1JejIwMGI3SFZ5WFVDa2NqcFBRYzJXOURGblpEY0RZNWRS?=
 =?utf-8?B?eVFKeFVnbllheDBUeDFsOThtcjdpTW56Z21yQk1wVEU5TEd0TmFRQTk4Mkkx?=
 =?utf-8?B?Vnc0NndhN2hLVDI5cjJqbjhDbnNtME9zYzh4MWJsQnVRa1B4b0VueUtScTAw?=
 =?utf-8?B?ajVnaldidjVJbzFmSytibXJubjI3T1lLV2YwelVlWW11Kytaa2t4b2w5cTRF?=
 =?utf-8?B?LzcrNlQ0SytENUx5UFRoYmxsTndkdVh5UllXUmJyUGJ4THErRkExZ3BRb2ZQ?=
 =?utf-8?B?TFozN1hOQ21aUlVwV3NDOGtNN3FKSnZ5ZzEvS3l3c2U1dC9oNWMwclltZDBS?=
 =?utf-8?B?b0hZc0xOcWN5TDFxRkkrV2RGSjdFeEFFaXB5NEttSnpGdHFjdllQNFF2OWJE?=
 =?utf-8?B?dWJ1ZmZJdjdwZGxBci96RkkwZXUzOFhzZUNBb2N4M21pcXVBbmZtMjFwK2xr?=
 =?utf-8?B?YkdTVzk3ZVMzQlFMRERoYmhSV1BrdHV4RTBzNHFMVUNsbnlhWjlhZGZRVlR3?=
 =?utf-8?B?cStaTW5lckVCYnloSmR2dnFxUi9zZVBXQzFBeXVGTUNKckNCN0tkdEF0UEps?=
 =?utf-8?B?a1JSWXhDRDBCSlRPUVVxbi96ZlRlU3Vnd3BGNXNoZi9oKzViMnN0aXRsNjJZ?=
 =?utf-8?B?RTVQVnRJN2dnRXovSlhYc290cFRLZTRmMWF6QXdYM1BsMjc5R2V4UkRXNGlB?=
 =?utf-8?B?TVBNN3R5U1pGdDJkeE4wU3ZIZXVIMHlPc0gvMnIzbkZSM0FCSjlWNkswYVRD?=
 =?utf-8?B?RmYydmtNanJ4bDExY244VXlUc0tTRWZybmYyRXpNS0N6VXRLRzBqRnpESzFU?=
 =?utf-8?B?bi9XUHVwc0JYakhNSVQ4b213eFBCc0EwTEZ6Ui9qWFJaZVl1dTlSN3NuUmhU?=
 =?utf-8?B?QU9HSEVwdzVIZmtFdkMrUUFGajlZVmU0b3FpMVBRNFFuY2p3KytMTzVvZmxG?=
 =?utf-8?B?YWczV3h1MUl5SXpvS1BMck85bnpqZXNKa3FjUTdXeWtORDhhMitWemNxa3Fy?=
 =?utf-8?B?UzhDRTQyd3hBczZoZkJTejgrSUQyeTRRbllvVUJyejJzc1kxOThRT1ovcWYy?=
 =?utf-8?B?OWFtTXhsbktQVkZxMS9PTWxPTDZlZnNMQ0t4SWU1b21EV3ppS0ErMlBZa2Z2?=
 =?utf-8?B?RmNqR3R3VkxkVHBzcWNjNncyY1ozcE8vTWhoT2NoZmcrVmZYdzBNTDE4MERJ?=
 =?utf-8?B?eXU2WDRad256WXo4WE94TUZEaG9LZ3lPYy8ybEt5Z3c3VUtVcFRSalBuNkxm?=
 =?utf-8?B?UmY5V2psMjBjSk1kK2NrdFVZS2lZMmNUTUxNcWt6dk5pWkZCSDVkMlRpZnlI?=
 =?utf-8?B?MzdONDB2SHZOSGN0VE95ZU5vc2lUTlVSMi9WRlFaTCtXeGJJN054Ty9COThX?=
 =?utf-8?B?bXVvMFd6dXFzTS9QenNQOEZsajBTOXhRQ0J0MmRoQy9JSUlUN1I1eDRuZUp2?=
 =?utf-8?B?alQrU1E5ayt1RnZFOFdUblduanF5WmdKbU4rMmE5YjF5bEE5WHlPejRzRmV6?=
 =?utf-8?B?NkEvLy9lK2gvNDNlVzV0ZENVRG40ajFxeGVicUtvM0sxN0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTZJblRZanBUNklucDNVZzJFTmI5cGNKdzJYd1BFYTVFWng1ZWIvbW5QekNv?=
 =?utf-8?B?aURaVzVKclV6OVNXdXVQd0lNK0xtNXVFWEFZMEM5dk1UZkpmWDMyQm1oaGhY?=
 =?utf-8?B?V244T0ZjR2J0RFhLdURDTU40Qk9nMEd0UHBUWGhpZ045ZzEvVVBOSUMxcm1p?=
 =?utf-8?B?d2xGVkpVMUZjZi9IL005QjVCRGt0d1NrV3pFM1lrd3ZQcC9NNERiSEtrUHhN?=
 =?utf-8?B?UVh2Y0VpT0RaNUJneEJQbEFUaE5hdmtaaldTVXRxRmZ0TkNMOEY3alc2ZTNE?=
 =?utf-8?B?WS80N1V4NnlPYjlwSys0ZytjWGVBekRTYVAzb3UvVEE0VXZUNWpNeThlRGhw?=
 =?utf-8?B?a3liUDh4VzNESVRDeTRQQnFNN2lKV2dzK0tHNFNXMVJtUE9MRW1yTkwzQ0pR?=
 =?utf-8?B?bkpGQzlRMWZSMWhXVjZ4SmVhdWNGZWdHZDd3M1ZwNUpyREU0NEIrK0lQdDY3?=
 =?utf-8?B?NzI1SGVBWnJPR25SMGVVeGJESlBFWEgvQVFvOStHU2sxaGZ2UjJCZzZLSzlt?=
 =?utf-8?B?bjZBeGl1dy8rNmlBajFpZ0ZZZ3RSUFZ6TC9pdlowVjg0MG5wMjBCWlplQnZ6?=
 =?utf-8?B?STZSS0h0U2N5dVB0YkEyakxoeUFPUWx0bjlUTmJFMXJFM1E3R2FrM3pqN09X?=
 =?utf-8?B?Qk9RUXhZOHloYUg5d1k3SHlFNTBjc3Yrb2lMSlpkZlhjY1phVUdlVzhKOEdT?=
 =?utf-8?B?OU54YzNLOG5KSXBNdTFuUWd3TzZKM2VMd05HMHJkUnRhWGxkSjFQZWhaMGFN?=
 =?utf-8?B?Zk5HYS8rMFZqc0hCVzM1SFFzTmRKcDBaTUxVTkZpV29QOVIvRnJkendCbWFk?=
 =?utf-8?B?ZGNFSHpLQmRudngyUHA0d0picjZNNDFLVDNvRGEzYUR2WTl4NVRYUXVjaWNK?=
 =?utf-8?B?ZkVQREE4bFRRMWtoTTVlSjRKcVZNamtQSG1MN3FUL05Wa0M0NVdRbkwyUGIz?=
 =?utf-8?B?ZHNqUjBtSEJ4d2tDSlhlVUc5Mms1VkJpYk9sVkdHMWtRcGJ1ek9FU1FkYVRr?=
 =?utf-8?B?THR6NmtzVHo1ZUFjblkyZGF5SllZWUR6M252QXdpdTkrd3Z5bXFnWkIyeGQx?=
 =?utf-8?B?TEtmcnZSU3VqaHA3ejAxNEtQLzFXK2VzUElYdGF2SjVxNmo3WG1WQ1FKT2tr?=
 =?utf-8?B?MityQ3daRjI3c29NRDY4MGtIWkRFVEhFRW5RRnd1cUpNOFY1aEZJYy9BMGlk?=
 =?utf-8?B?cGRMTnFuMmxETUh3WmRvM1VQMWdKVk96WUtkczIwSVNQUlZtMTg5aHZMYUcy?=
 =?utf-8?B?U2lud0ZmQVdtOWJNM3RFQ0tRMmVyV2tCeEVVSEJ0Sno1QjFJbFo2aEhwRWlD?=
 =?utf-8?B?Q0NtWEw4bjY3SmdiM1diSWdZMGpzMHdRWG8zN1kySWNLUjMzaTBsSmNCRmlN?=
 =?utf-8?B?WXB2MTlJZUlmKzhaTWlUUHUrTVBmQzl3TGxISGhoc3NWTUxXMnFoeDZlU2FP?=
 =?utf-8?B?a1RhSW1qVGdiM2hWSmVLbmVvazNaM1FTdEVXbWpaVzVWNStWbnN4Z3RyMHhh?=
 =?utf-8?B?VkNOam1uQi9jd0ZwNVNWT0lreGZrdFF5a0t4OE5yNzZ3S3N5ZW4wdU5PanhJ?=
 =?utf-8?B?U21McnNxajIwV3hPYnU4ZlkrZFUveXdta0pyY1UwSFBHM2szSlhvdGlmZ2Rz?=
 =?utf-8?B?eTRCRk9OcHRIdmxLRThXNE0wNlBMNUVqNFNFRk5RaUV2cWpnQTNTTTFzenlw?=
 =?utf-8?B?RFhlU0FqVjhtdklIM2dKeUU2SUg2bjk3ZVlaOVZ4VU4yRkIvejM1eHpGVENz?=
 =?utf-8?B?UW4yS1NuQTNmOEZ5eDJUWlgySmVqdmZYOXhGb04yV0VIYnJjTkh1VFdKOUFs?=
 =?utf-8?B?YkVJaEkwVmFXUmJOYkw3V2o5QWc1VEZoSmtHc2ZCT1JtWjJoUysvWmRtTlhD?=
 =?utf-8?B?Q2NxM0VsV0piUHludVF0eEd4ODJCMStGQnNwemRnY3lBbjNWcnFWUm90NFhH?=
 =?utf-8?B?NzhZTGRGbFNCSExVZzF2QnA5dVpudFlNdVlJYWtnR0ZMYVpEOHo0V1FNQVZZ?=
 =?utf-8?B?N21HSjRLWWxoL0Z2eXl5aHZwUEtmd200emdKVGFkOUhLa2VpR0RlTkxwSlhr?=
 =?utf-8?B?MzVaY0h4UWN4NjNvbHVSOHVEdTNyZUpLc2FiSkFqYWE1UndxRDJ1SEJKOU43?=
 =?utf-8?Q?U2p7CneDjZSaHFAXj3zxXqCuM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9B6635BAC945F4D9FA706AACF48E4BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867de791-7144-48f1-d921-08dcb5f78515
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 09:09:47.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naQ4yv7+JQHfnE6YJUEy7YO6OPXiyF0cypw28ifjZDr7+KmB4qvTWkhBEuCAJbR7C+WEHrWhSEDCuHAxeXIPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

T24gVHVlLCAyMDI0LTA4LTA2IGF0IDE2OjQ1ICswODAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMDUsIDIwMjQgYXQgMDg6MDM6NTVBTSArMDMwMCwgVGFyaXEgVG91a2FuIHdy
b3RlOg0KPiA+IEZyb206IEppYW5ibyBMaXUgPGppYW5ib2xAbnZpZGlhLmNvbT4NCj4gPiANCj4g
PiBBZGQgdGhpcyBpbXBsZW1lbnRhdGlvbiBmb3IgYm9uZGluZywgc28gaGFyZHdhcmUgcmVzb3Vy
Y2VzIGNhbiBiZQ0KPiA+IGZyZWVkIGFmdGVyIHhmcm0gc3RhdGUgaXMgZGVsZXRlZC4NCj4gPiAN
Cj4gPiBBbmQgY2FsbCBpdCB3aGVuIGRlbGV0aW5nIGFsbCBTQXMgZnJvbSBvbGQgYWN0aXZlIHJl
YWwgaW50ZXJmYWNlLg0KPiA+IA0KPiA+IEZpeGVzOiA5YTU2MDU1MDVkOWMgKCJib25kaW5nOiBB
ZGQgc3RydWN0IGJvbmRfaXBlc2MgdG8gbWFuYWdlIFNBIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
aWFuYm8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFyaXEg
VG91a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L2Jv
bmRpbmcvYm9uZF9tYWluLmMgfCAzMg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gYi9kcml2ZXJz
L25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+ID4gaW5kZXggMWNkOTJjMTJlNzgyLi5lYjVlNDM4
NjA2NzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gPiBAQCAtNTgxLDYg
KzU4MSw4IEBAIHN0YXRpYyB2b2lkIGJvbmRfaXBzZWNfZGVsX3NhX2FsbChzdHJ1Y3QNCj4gPiBi
b25kaW5nICpib25kKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fKTsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2xhdmUtPmRldi0+eGZybWRldl9vcHMtDQo+ID4g
Pnhkb19kZXZfc3RhdGVfZGVsZXRlKGlwc2VjLT54cyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoc2xhdmUtPmRldi0+eGZybWRldl9vcHMt
DQo+ID4gPnhkb19kZXZfc3RhdGVfZnJlZSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbGF2ZS0+ZGV2LT54ZnJtZGV2
X29wcy0NCj4gPiA+eGRvX2Rldl9zdGF0ZV9mcmVlKGlwc2VjLT54cyk7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpcHNlYy0+eHMtPnhzby5yZWFsX2RldiA9IE5VTEw7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oH0NCj4gPiBAQCAtNTg4LDYgKzU5MCwzNSBAQCBzdGF0aWMgdm9pZCBib25kX2lwc2VjX2RlbF9z
YV9hbGwoc3RydWN0DQo+ID4gYm9uZGluZyAqYm9uZCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmN1
X3JlYWRfdW5sb2NrKCk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArc3RhdGljIHZvaWQgYm9uZF9p
cHNlY19mcmVlX3NhKHN0cnVjdCB4ZnJtX3N0YXRlICp4cykNCj4gPiArew0KPiA+ICvCoMKgwqDC
oMKgwqDCoHN0cnVjdCBuZXRfZGV2aWNlICpib25kX2RldiA9IHhzLT54c28uZGV2Ow0KPiA+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBuZXRfZGV2aWNlICpyZWFsX2RldjsNCj4gPiArwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgYm9uZGluZyAqYm9uZDsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2xh
dmUgKnNsYXZlOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWJvbmRfZGV2KQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gKw0KPiA+ICvCoMKg
wqDCoMKgwqDCoHJjdV9yZWFkX2xvY2soKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBib25kID0gbmV0
ZGV2X3ByaXYoYm9uZF9kZXYpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHNsYXZlID0gcmN1X2RlcmVm
ZXJlbmNlKGJvbmQtPmN1cnJfYWN0aXZlX3NsYXZlKTsNCj4gPiArwqDCoMKgwqDCoMKgwqByZWFs
X2RldiA9IHNsYXZlID8gc2xhdmUtPmRldiA6IE5VTEw7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmN1
X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghc2xhdmUpDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gPiArDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKCF4cy0+eHNvLnJlYWxfZGV2KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoFdBUk5fT04o
eHMtPnhzby5yZWFsX2RldiAhPSByZWFsX2Rldik7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDC
oGlmIChyZWFsX2RldiAmJiByZWFsX2Rldi0+eGZybWRldl9vcHMgJiYNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVhbF9kZXYtPnhmcm1kZXZfb3BzLT54ZG9fZGV2X3N0YXRlX2ZyZWUpDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlYWxfZGV2LT54ZnJtZGV2X29wcy0+
eGRvX2Rldl9zdGF0ZV9mcmVlKHhzKTsNCj4gDQo+IERvIHdlIG5lZWQgdG8gY2hlY2sgbmV0aWZf
aXNfYm9uZF9tYXN0ZXIoc2xhdmUtPmRldikgaGVyZT8NCg0KUHJvYmFibHkgbm8gbmVlZCwgYmVj
YXVzZSB3ZSB3aWxsIG5vdCBjYWxsIHhkb19kZXZfc3RhdGVfZnJlZSBvbmx5LiBJdA0KaXMgY2Fs
bGVkIGFmdGVyIHhkb19kZXZfc3RhdGVfZGVsZXRlLg0KDQo+IA0KPiBUaGFua3MNCj4gSGFuZ2Jp
bg0KDQo=

