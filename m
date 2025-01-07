Return-Path: <netdev+bounces-155658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0908A0348F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4283A49E1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA0C139;
	Tue,  7 Jan 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QF2+H71H"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916171CAAC
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213673; cv=fail; b=RHEhyzwKSS5ZHhcap1BlAJoWxDKHKNQL+kvR4d0xM2XMhUcUvicPuTv4kDQmt3as+g4FlpF1RUR/lpXlikkALR7dg9WFggjfA6636tom2euS0L+Jq8J+bwBNyDdM5wI2Ki0bgvcVHAEPWATNCwvMVEqqMVNkvuszSOxoBRGsIu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213673; c=relaxed/simple;
	bh=45RVhIT9bL+woNOk3iG7ZICEqqgWui3ksTdZFStXVpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBPH1AWKl49HttYMuB0KANqGJvkBh5g6EqjWjbmJuQBw6MGgIgtyiDIJjYB+R1OPe/hxBx5+XQeZcUR1h1d3yHtwzC9SeROwvC6CzKfvit6b6PyBsMSRHN8NQUexDtj6edvwgCh/EPn2BFNWVEZ6UdUvRq1yFsTi5iCGuyFUoTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QF2+H71H; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYvTD5uL8EKPpzjXsu1mu9QZliEsUI2G5EO3Q3H50kwtfYEC7W21mEJHbRn/KxtyaNLyHfwN0zs6aBO2n+4fxMxMekECwMs1w56D1ejMXjgDIulIkjPYrVrtxTlc5jRS2mhf0MzaZuC1iiEt1u9pHj83D4OsnSoktMn09opfP/Mr7BAEN+7vx9Yuz4FLl49QAmeWFkBmJPiqgW/YQP0IkuwUZ2MdJhoa01N/fK5I4YkeU5CfuKVLA4hMCWHL0jZFtEAy/kMyj1IPXrIzXfVGJ95gccNdDpPjJAjbhuvXLQtKAvntCIEDcxk+QI5sz4Z+BT5oSY0vAz1uXTzUO6C2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45RVhIT9bL+woNOk3iG7ZICEqqgWui3ksTdZFStXVpY=;
 b=SMc41ZNRQf9+4dSDCH+3zXoVdUdVOw6iLfySvRfPNinRw7dbv9997S8s9rXI6sF+hjUAreIsU4NMs/gUS6gh9lcwpxYKusIaEO5/wu03QME07CTOvfVMYd5s31tY30IbQJRYezjxPAugfnHpai6ya5YdYejvu8f4fTLYQ5EOlYRAC3q1P7SZ4VwJBRvPXNa573QrgLTEMfjfSShr6UTZK+bmJinv0pX6UGs607shpRaIVfm9SvLDM6zdnU7aqxtczsl9BMUsVhJU66wMc4jkKK9jWsWaJTLiJXSqUmvK35gCVvQxpcbu1a+uVqmF0rWyHDbRmZqXFkyq30I+bopjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45RVhIT9bL+woNOk3iG7ZICEqqgWui3ksTdZFStXVpY=;
 b=QF2+H71HTy2JUVqJJUAADuvDnzobiqEJ+9SyxCud7EEMQC1hABCldROCs4WkAnSpaTm13Lx1LmaLGvZzysb41AwhEZ0zVBRPGeeyr1NWveygrbI+SL4esardFcqcTa0HoTQ1PW9zBDO3PvpWruqtn4SdgtZWnNZE86727Iqpz22omNZkcGsmJyYLamfd1qLKRSNeT9voMc+hejyy9pAk5maXoze4oBESA6ZGiiFgcsSZU45IOivYkDgnbRpkveFW8ZCGqr+n6Vk+acfhCRxPXCMf+ubSxA5go1rhZLipFmvWoYhmm28hwgPCxrDpoSG9FVSZ3pHvKCURlH/NzZx0mw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 01:34:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 01:34:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Russell King - ARM Linux
	<linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: EEE unsupported on enetc
Thread-Topic: EEE unsupported on enetc
Thread-Index: AQHbYEAEPp0VVipOt0OTBhisL57pd7MKgsxw
Date: Tue, 7 Jan 2025 01:34:26 +0000
Message-ID:
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
In-Reply-To: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10179:EE_
x-ms-office365-filtering-correlation-id: ea264419-3d7b-48eb-f703-08dd2ebb6c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWpFcnlLSE5oZG1tMm9xeXl3RVp2MFFaZnhGQzM3OGtLRjFaQ01IYTFvS3RD?=
 =?utf-8?B?ckxxanF3SmtRVkt6TWpXdHlmd253NkVWeDVwdjBJWjNoZG5xUERtNVJybjY5?=
 =?utf-8?B?d0ZUaWpCNDJBNXBycGVYQzVPVFJ6VDhQL2lLWi9pdlZhc3Z2MldESFU5YWhR?=
 =?utf-8?B?MzArZExWQnZuTDJzSlQvRVBhTlJiSXY2WlNuY0ZQR3pWZEZJVzJERUNVNVlr?=
 =?utf-8?B?UGxETmJCb2FEeUI5NURWVzFEeW9xQ1E5bmdLYWhobHd1YkJPS3VzaTlmOWVP?=
 =?utf-8?B?T1I5L1lpeURTZWV6WVhwMGRnK0NIUXhLWFVZYzEyMTBnQ3NOcDBFSzhQMDZs?=
 =?utf-8?B?MWVxNWlaSkU3dzl2QUJjNTNoS2tWWjJ0UGdneUdPQVJKM1IyRHpLVXVEVUhN?=
 =?utf-8?B?U0N6djhTWTYxT2VIQjhLRk9FOTV3U0FIVWVhVjZRejVSNDBlU1lENWVRVE9B?=
 =?utf-8?B?bzRPalJESjQ3K3FqYys4eENQUEo4Mkk3ZGRnKzRaN0NaZGQ0ZWpTTXE0Ui92?=
 =?utf-8?B?VEpmOXZwT3d4QUJvYkl5NStGUExwYlIrRGgrNkdSQ2FIUjFoMUN0ZDBWdFd6?=
 =?utf-8?B?ZmU3RXRkTmt0SitKNXJiYWVBYUhDR244OVYwajU2d3VjRUpSUlRpUVcvVXcw?=
 =?utf-8?B?WUxLMFhOQjZsYWd4WVhYc2JvTnJvQmlCVkVmdUZJZjk1cG9qQ0hraWJKU1FI?=
 =?utf-8?B?T0hCWXVlVjUydjFOOW1LcHhVenkyZFRFcFg4bi9IejlBaEZKaVdTVlQzOHUz?=
 =?utf-8?B?VVkrcTB0RWUrZ05aakVOUHhoVVFTclNicFMxM3ZjNmptaVh0R0c2MVUyWkg1?=
 =?utf-8?B?VnlTcnd5SUQ3VklzM25ZcG04WnJ3NHk4cDFEajNQdnBxRzQvRTFlRzRBRURU?=
 =?utf-8?B?OU9acG9qRm1NTTZ3UE9WVy9iWHlOMXlNdGJJaEhucUhEVHc0ZFducUpYc3Bz?=
 =?utf-8?B?bDk0a21sRDJaT2kzMTNIVEFBSHg2RlRTSFFxWElxVDZVMVA2b2dwUGM4Rmht?=
 =?utf-8?B?VUExR0I5SUh1T1QzSUN4RDVXNlg0M1RzYUlMMHhpN0JGUzJVNlhwTjliVllO?=
 =?utf-8?B?Yk9EUzNwaEMzblk5WDF2anFuL2o5TXAvZWVGbER4cjU4dXhiNllwdk4zSkt4?=
 =?utf-8?B?NGNPMHpnYW1PamtUdklBQjFUMTlMdE9EN0xsdHkzVWRveDRYTG5nSE5rS1ky?=
 =?utf-8?B?dHhuWUVGNHV4b3JJaU93WGVydW41V3Y5YlhuemRWT3dGMUx0bVJEU1VnQkEw?=
 =?utf-8?B?NGVzWk9pVUs2aFFveWN3ckpkQWJzUkh6eE93RFpVZnVDQXI2Q1dieUQ4QW5Q?=
 =?utf-8?B?TXkwQ2tWRFNGMG5IejhPWkJPcXBOZmJjOEFrb0pQQlIxZDNick1IcGtRR3Fj?=
 =?utf-8?B?cVVIOXlJcEhTOTB0QURNM3ZwY3llK3k3THk2Z1FEUXBaY1AyZ2p4ZGpmU1g1?=
 =?utf-8?B?VWtaWlhwUWRIZFNGWDczaW1JTjBiclhvMks1TDVxbjRNV00vSWx0b1hVZ0da?=
 =?utf-8?B?RG1HVnVDTVhITUpQaEdTT1Nic052OVlsTlphcW1LRkljWnd6RWp0UlZKMEQy?=
 =?utf-8?B?K2ZHM3BKTXI2aUpKUEgvTGNVcXFIRllyRWE3amxKYnhhVis2VUxwQ3h1YnV1?=
 =?utf-8?B?SmlPM1pkYWNHYVlqd2ZzeWZBSG1QRmhIOHgySllxZFhlS1RJYzAvK1k2czBI?=
 =?utf-8?B?dXpMdEhxMEltUGZHLzdzS1FvUWF3ZGwrZnlHLzNtT3VWdlVRRFovcGlSRzdP?=
 =?utf-8?B?NGs4K1FzSTl1MmRIc0JDNU4yUWJLL3JaYzYxaE1xWnVsYlh1TUQ2aXJOcjNk?=
 =?utf-8?B?d0xZdUtwOU9rOVR0NVd4QnNndkk2SDByMzJ0U3dDUTVhR1BQa3ltT0hCbHNH?=
 =?utf-8?B?Y3l4dXlBcjBkaWdqR2Foc1lqZjZHa1pWcGJFdVZUcnRHa3dqOURvVnB4SUdR?=
 =?utf-8?Q?leC59hNM6rB2fGKAvcvNLJeERDK1buW0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWJtL1BXeVhnb1BnSmVERUpjYnEwVXBDbU9TS2pWUjlrbG5FK2gza0gwQUhh?=
 =?utf-8?B?emlvTkgyeUNVMVRlZUJaZ08rTmFWaXBmTmdPYUNwaUdNWExoWWs2bnNnUDJO?=
 =?utf-8?B?RHd5R0E5YkNodlBRUDdlSy9YV21GQ3JTSWRLdGxRbnF3L2ZJV2tQYWZVR3hX?=
 =?utf-8?B?S210UitGazdkM3F4TVphOUtzMFYrOTZ6YWlINVBWK3FiUzBiMEo1RDRpWnJR?=
 =?utf-8?B?S2NDakE0UVFXMWtjNElpeTlic0xyamxKdWhwUWZOcGJPbTRCbGtKelFaQlpj?=
 =?utf-8?B?YzhVZlhyOG5XVGYyeUI4aVlHVTltc002bDd5VnJpWnFlbEYvbDQvZUlDNG94?=
 =?utf-8?B?cSthZWhyOWkxNFArcTNtMktYanh0eng3QndLbW10ZmhyNTR6bkVNeitDNDlB?=
 =?utf-8?B?RkN4N3g4eVNtREpMMm9POHNaNlJTV2JWYmpScDFibVBRTTVXemVic0FNUXFJ?=
 =?utf-8?B?VXhjazN0anozdEc1eEZadkEzMGdHbkxRUUxUaDV2VXUrOGtjYzdBRjlaeHJq?=
 =?utf-8?B?enVNTVNMNXFuY3c1VHROY3dBSHNYT2RYY2NQdUF4TFQ2TnUxMmZldG1BOWVL?=
 =?utf-8?B?azBRNUh3K2F5bVpORHBHTnhncEJwYXBtWENzbWtIWGVsa3FqeTdsbmZGanFx?=
 =?utf-8?B?eGFEYTZKSjdEZ09mYjFqK0VxT3czQ09HNXBZNExMNFJqcjhyT1VQeUJiVTln?=
 =?utf-8?B?aWJjYS9CR3FmNlNIRHNIWFJmaDFvYVF1SHVPc2duclFyODkvUEkzS3FHZ1p4?=
 =?utf-8?B?L2ErQ3ByaW41Y01mS3MwbjVlNUlNS0ZSS1E2V21YNkRJRU9iaTZmcGVlN3By?=
 =?utf-8?B?eWgvWjBvRC9JR1NPNGQ4eXFVeDNqQUZQSHZWT0tmYXNSVGRuMnowUHVMZ3VJ?=
 =?utf-8?B?UDR6YTBXeGlGK0JuNkZvZnRIQUhSOUhKOTRTb0x2TVFVdzBNeml4cytxL05h?=
 =?utf-8?B?RmxJNDJSb3A4ZVFBSWR2KytDWU5GTmloM0lzYndtVzZmWEwvZzFwdnhxLzhm?=
 =?utf-8?B?L2U5eDJuVDh6NmxqcUF3WVNyUnhmSmxWYTFoYVRaL1hTVyt2STNaU0o2ODdY?=
 =?utf-8?B?dWM0RWRaWVFXV0pvMVkvMGdjeDZxVDcwMGJRMFQrMk5yeFpOQVlveFdSOFoy?=
 =?utf-8?B?S1p2T1VyaEdWaXBuTUtRa1ZONjRXUXNBVUNPZzEzT0hHaFZ5aDBwYU1PSy82?=
 =?utf-8?B?aXlwVXlacE0rK0xRcHFhSHpnRTlCakR6T2VzL1ZFWGtHRnh4cGwyeHVXN0hp?=
 =?utf-8?B?ZTcvOUFYZzJFckg2am1CNHdsY29iVS9XTCtQUTZFWStpSHU1UHVJaFVCdWt3?=
 =?utf-8?B?OUtncEdoWGlOTjVENWg1RC92azJqZExmaSt0TUcwTUdEQ25zU1VPNThmb28x?=
 =?utf-8?B?ME04ZnJTelVSREpYOFhVeDdYcWp5dCs3Z2VpMXdpU25YbGIrL05vdXBtaU1T?=
 =?utf-8?B?aEhMK3hqVDVmekM0cXdOYkNEbEh4SUVraUFEZEVZS1dYVFRzWmRHMVhjRDBy?=
 =?utf-8?B?YzRnZ0pPQ3F3NUFhZ0xTL3VlSGZDbElnRWZXaXRqL0Z6NVpVM1VnSTBTRkVy?=
 =?utf-8?B?SkJvMjA0VmVGeHA5M2pPTlFDOVAxSDIzaTVQZGlveDVLd1RBY3pmK3BKaVhj?=
 =?utf-8?B?MkNDNHRqTEljK3ZDY3VsU0hCTzl6ZE1nakJpa0FJQTU4K3ZCaEU1b0NsNXFQ?=
 =?utf-8?B?dUcwWHJ4cUtCbWUrczhoQ3lIWC9HanJGamxKaXVuZmJpcW13bFJjNWNSUFlr?=
 =?utf-8?B?bmNYMlRybWFBK0Zzd3pteUhxdjA5bmNMSnl4NWQyeWpDcFJZcFZLU09JaG43?=
 =?utf-8?B?WHg4bEI5cU5wdkx0RGh6VDV0QWNQNU5zU1Q2R29yM1Y5MDJuT0pkK3ZoSGhs?=
 =?utf-8?B?NUVNKy9pNktDc2JmR3RYaDlJSEh0NjhMN2tMUnlIa204ckZvMFdYRlVZWTRP?=
 =?utf-8?B?a1NPMGpOUE1GMjh5My9UOURRNFhoTy9xUTFmdyt0cnMyUFkyUkQyNVpmTzFj?=
 =?utf-8?B?RFBmcFZBZktPZUxIUGxhRVBDdDFNQmp5SkdaQ3puejhZcVFCMXVnYnVEdVNC?=
 =?utf-8?B?Wm5RNTR6cE9LeW9xMmhyM0tNK3BjNTN2UUtneVdzWEJ5Nm50OWs5RGxYamUw?=
 =?utf-8?Q?jusU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea264419-3d7b-48eb-f703-08dd2ebb6c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 01:34:26.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: takjosfcZTIChPyrQ2AWYbUSkUya/KckjP1QH1VKpXw6gQg5W4EsDLn/+ddfZtwbhkZOFze2+suAqO4Yx8JJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

PiBJbiBlbmV0Y19waHlsaW5rX2Nvbm5lY3QoKSB3ZSBoYXZlIHRoZSBmb2xsb3dpbmc6DQo+IA0K
PiAvKiBkaXNhYmxlIEVFRSBhdXRvbmVnLCB1bnRpbCBFTkVUQyBkcml2ZXIgc3VwcG9ydHMgaXQg
Ki8NCj4gbWVtc2V0KCZlZGF0YSwgMCwgc2l6ZW9mKHN0cnVjdCBldGh0b29sX2tlZWUpKTsNCj4g
cGh5bGlua19ldGh0b29sX3NldF9lZWUocHJpdi0+cGh5bGluaywgJmVkYXRhKTsNCj4gDQo+IElz
IGl0IGEgaHcgY29uc3RyYWludCAoaWYgeWVzLCBvbiBhbGwgSVAgdmVyc2lvbnM/KSB0aGF0IEVF
RSBpc24ndCBzdXBwb3J0ZWQsDQo+IG9yIGlzIGp1c3Qgc29tZSBkcml2ZXIgY29kZSBmb3IgbHBp
IHRpbWVyIGhhbmRsaW5nIG1pc3Npbmc/DQo+IEFueSBwbGFucyB0byBmaXggRUVFIGluIHRoaXMg
ZHJpdmVyPw0KDQpIaSBIZWluZXIsDQoNCkN1cnJlbnRseSwgdGhlcmUgYXJlIHR3byBwbGF0Zm9y
bXMgdXNlIHRoZSBlbmV0YyBkcml2ZXIsIG9uZSBpcyBMUzEwMjhBLA0Kd2hvc2UgRU5FVEMgdmVy
c2lvbiBpcyB2MS4wLCBhbmQgdGhlIG90aGVyIGlzIGkuTVg5NSwgd2hvc2UgdmVyc2lvbiBpcw0K
djQuMS4gQXMgZmFyIGFzIEkga25vdywgdGhlIEVORVRDIGhhcmR3YXJlIG9mIGJvdGggcGxhdGZv
cm1zIHN1cHBvcnRzDQpFRUUsIGJ1dCB0aGUgaW1wbGVtZW50YXRpb24gaXMgZGlmZmVyZW50LiBB
cyB0aGUgbWFpbnRhaW5lciBvZiBpLk1YDQpwbGF0Zm9ybSwgSSBkZWZpbml0ZWx5IHN1cmUgQ2xh
cmsgd2lsbCBhZGQgdGhlIEVFRSBzdXBwb3J0IGZvciBpLk1YOTUgaW4gdGhlDQpmdXR1cmUuIEJ1
dCBmb3IgTFMxMDI4QSwgaXQgaXMgbm90IGNsZWFyIHRvIG1lIHdoZXRoZXIgVmxhZGltaXIgaGFz
IHBsYW5zDQp0byBzdXBwb3J0IEVFRS4NCg==

