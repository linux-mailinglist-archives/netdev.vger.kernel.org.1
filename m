Return-Path: <netdev+bounces-115524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF87946D5F
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AE0B20DB9
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377F18C3B;
	Sun,  4 Aug 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHaeRx4J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D16FC7;
	Sun,  4 Aug 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758906; cv=fail; b=EQRcY33uEdSSpbkVM/aAuXA4ivnszeEGVrH0lAwE3R43/n84FYhVH0+kl9hFdmLyYys4/U626Dbk2sNdbwWgMeeeb6ht7ZRXf8ZqWWD8EACduUsXj4hnYYL6qjjQiTlpjt6P0zZA+o746vkQfbfhz7NhHn8cidzS7fbg8jTHE2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758906; c=relaxed/simple;
	bh=tyJcTYgyoNWv0N8aRifxH7DhksRDUmz2aCAmv1n04Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MBHff9CeYZdvKWrSKXV+v/4HIFPebiM3lMOKHuUtjDG+Z3rSujKxMICYH+gj+ZjX/4Z/6+PxHxb8T/Mndm4cCqsK2OecZ5EKbksC/KGNCVTWAi1+zfSCmKSDrD7m3yc1oRpFJxhZATIaqDpGBdl6zThLslOH7mRe7MMpBRdR7NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHaeRx4J; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyoCzUFu3b615aZv3A0ayIEjiuI4libjoeSjwYAoK0vT59ntYQrTtqGtB+3on1Fsq20khBhxIW9ZADzNEtBmycHhsDBIeEfJSRoJuVFfmtFehomwghSvPWJKh/m3zTNerJ2qr0eqpSFjN/1Q18bA6WsBoY33A6nQiGx4BRTdvNNJ8Yjxwbi1FijdzUYjV5wx6SglPDao9VDBvxftOobdhg5cekfeQ1AJm4edSPRyqF40Dr83zjQIZo6cFyajkEl0YGhjg6HuJbjE6wOT+c7pVQ09OOIbiQl3MeujqEK6WfP92z2N0msTIRstQUxZFBIUZKHbtfEZsZW7LqHyqASfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyJcTYgyoNWv0N8aRifxH7DhksRDUmz2aCAmv1n04Bo=;
 b=OyKKUBKUFEeXd6AVnZIwVpCKYVVtFoIrxDFk3au86Q4qFy3gebTXoqonsuT5YEjuA4PHOk9rhDGHInJU97jljzPkX3oLbWOgCepz03bWyfC/DMXEvVGto/1g12gEWnYGQ5/71j4UhK4IN1+//MLL+ONthWJ6I/zAhde/H9gGBn1WU8PKXSzVMlRsU7Ki8m/e2nT4lfJzQ1VlI1SZlkc1PONZZlPdvAP+qXx7NTufAxIlAdNnfW7A8ia/3ghtEXBX2u9qqO1CgpJUAgr0q19VaOa4lODc9RD7t3yY/XUa0/S7KJXxR74uCn+9J7aePz1Knt5tCNVOBwraUoo50v7TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyJcTYgyoNWv0N8aRifxH7DhksRDUmz2aCAmv1n04Bo=;
 b=HHaeRx4JG5Yy6rljW30ic+XIQ4PzBdglcg/2o5DAWllGyOL7Haamc+eDRp9LXv0oUY8ncqk5FMzzrG+lZF1r1J9Pk4IbP06m8C9Rpn39Hx7r3T+DCKfIp0zSSgsJAKgkiHxWN4vUkcf+qO2YE12LQ/vDkJBwb71P2mwqJp6jx0P+7Jrl0M3n5qMkYnYH4+GCx0+GgE2jrowj4V5dT4LzOzd77cB4zPCToZA5gcDy/eJ2W9q9N8p54namOp2x5vsmP9YrqiehmbIZXZapKjre1vBqsdPOqpzPgt3Gu6x3F6SYXWdlL60DLCjajSoncEPvkgrh1hVf5iXHWyjCnqLc1g==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 08:08:21 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 08:08:20 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] ethtool: cmis_cdb: Remove unused declaration
 ethtool_cmis_page_fini()
Thread-Topic: [PATCH net-next] ethtool: cmis_cdb: Remove unused declaration
 ethtool_cmis_page_fini()
Thread-Index: AQHa5Ze58TX1pyqSxEOp5t2p+aOVLLIWvbqg
Date: Sun, 4 Aug 2024 08:08:20 +0000
Message-ID:
 <DM6PR12MB45166954774CA935EA0777E5D8BD2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240803112213.4044015-1-yuehaibing@huawei.com>
In-Reply-To: <20240803112213.4044015-1-yuehaibing@huawei.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB8660:EE_
x-ms-office365-filtering-correlation-id: 713263cc-2719-4929-5e8b-08dcb45c9ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NldwVTN3TnExRFdRSjF5ODdLcHd3SHlja1I5VDZuTUk3eStzZHN1TEJraTk0?=
 =?utf-8?B?UmdnUmdmbDk1Q2hXOFg1SmJXcGxQRFozTFRrQ3FVLzRiSVdBY2tXalk1bHNl?=
 =?utf-8?B?ZU1XOFpRaGE1Mm5oOUJBYWNyZytoempaOU1oYnZwdmthTUxZOXgrWHc3TC9k?=
 =?utf-8?B?MkoxZnN1bksrWE1keVppTk42ZThpSCtkb3ZSVmVlVmV6YS93V2tuRVhNUVE0?=
 =?utf-8?B?MkwxWmpLdTNHNFZXQmZ2eS9ZYTNiTEdUMDYvQW5tR2ozaTIwS2tra00vM0JD?=
 =?utf-8?B?SmZwOWJYd2VLTEdrTmR6UXNKdUF4bzBVcUxlR0ZocXZuVHJNV3lIbmxBSkJK?=
 =?utf-8?B?eDlXc0svczdOOEtNMXNaSVNxamIzeFJLcE1NTXFYQkdRVUVXTUdTSHdHZS9a?=
 =?utf-8?B?eUFZWUlNZXlaT3NlV2lvMERNc05rWWFPQUtObVllV2FlY01YRUhxaWpSd0RO?=
 =?utf-8?B?MkJTWkp4czZod1hJWExPSlVoUTJ2UTRCaWhLem8yVUROQllvclplcGtyQXJT?=
 =?utf-8?B?QlZySmdnUkNqbE1acDllRkFtNTZualg5ek5jcExXS01TdElwbnMyZGNGS2RS?=
 =?utf-8?B?U21WVWFXNi9SeVRQNzJZSDV4cEFFTGZUdEI5S0JyQWJwQTdEQ2dlSFJoTTJy?=
 =?utf-8?B?b2t5YVhCZ3ZLM2pWaXhlY3dwQlVkSS96bmJSY25KL0N3YlkvZ25FaXFSelBq?=
 =?utf-8?B?QVZyYTV5M1pJM3dxams3N3BKTHRDUVcrUlR1Q0NyL0Erbk1pcDBlZ2N3UGsy?=
 =?utf-8?B?MnJyUGQ1WnpNaXpYQ3lsb3Vrb1BzYk9uczBiS1JpcnVQdEtLSFVzU1BwT3FI?=
 =?utf-8?B?dk42bWJuSUFTdDVmek83d0ZrUWQzMDRiVVZlaDRBWHg0KzdZZEZRU2NZWGJ3?=
 =?utf-8?B?L1RibllWU1ZyMWU2WDdJTTcyaUJKZmd5MHJHTkt2NzRJTnpCNU1vVEUvK0gy?=
 =?utf-8?B?cWxsbDJ6OVVYalFWRWU2Z0VxZTVOTTBxeGFjSTBVUVJJbjZ0RVVLKzBPZmNP?=
 =?utf-8?B?WEdab0pqWkNzcmpiY0FaTm50SjhiekIvdC9IeUIyWVJVMkc1OE5HbjRuU2Zw?=
 =?utf-8?B?N3FpNUREOWowNlphUkMxY0Y4aGpuNmp4YnF5MGkzRDZ0K2pqemN0ZENadzlL?=
 =?utf-8?B?N2twWDJPL3poYkxzcVUzbzdmMnpQNnhJTkJkZERmY1JvRTd6QkVSQUNsVlJW?=
 =?utf-8?B?dUQwY0JydWJTUXE3KzZpeU85SnM5cWQ5WDBmWTRRTmtOK09WcHlLN09IZGU1?=
 =?utf-8?B?Qm80NHhEbUdGRWkvUkR5Zit2SXpjSTZQaHUrYnJxYWh0YVVtTFUwOUhQb2RB?=
 =?utf-8?B?UnFQUWMxY25rd2xmMk1WblgwRnFOZ21SUG9DeFBtdkNPNXlaMWN1V2x3dElK?=
 =?utf-8?B?UTE1UC9XQVo3RjIrZmJjd3ZqdXlwcCtUMEJFUHY3U2Z1OUxTS1lJcDFmWCtR?=
 =?utf-8?B?K0ZnRW5MUVNnYXJYRVdGY245ZmErT24xY05LYW9CLzBJMzQyUUFEbHlZN1Z3?=
 =?utf-8?B?ZjJGbGFVdi82dnFDNUxtNzMrWW83TmQvZWRDZkNVemYvb3ZUMnNrZ0p0dVZY?=
 =?utf-8?B?ckd4Y1htTGFVL1MrK0puM0FJV09rNGZKdm9Hc2MzYzZOZnJBTWJTWE1PK0lZ?=
 =?utf-8?B?WGVXZGQxUmRSWFpKaGViOU4rYjVZcW1EbUhGbUZZNXBIZjFGWGpDU29Tejla?=
 =?utf-8?B?c3l1dkNtTlVDdmpOdCtyeUZaakNUVTJmUW5NS2o3WHJYUjk3U2ZLS2E1MjQ1?=
 =?utf-8?B?cjZ6bTVHdEZ6TEVIR3R1bTdiL0NKSC9Na1ROT29pUUxLaEJGWVUraHpkckRx?=
 =?utf-8?B?WFMxeU1nZ0lzQ1M3REkyYzN6ZzBwZ0NYczc0RTRyMHFKQ3RyMlZNd095azBQ?=
 =?utf-8?B?Y2JKaDJsTHNSaGNVQU5PZDkrZDErZHIydlZydW11cWs3SlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNQb1A2MXA1WnpFWm5NRnZQc3g5dkNTQ3FyUXFHUmFsNjBjWTZSNkJxdTFE?=
 =?utf-8?B?UjR2RjgvNUdzaDVSc240bHA0SG5IY1lWQ2lhRXk2UHBDYkVvUm8rUkpkNi9u?=
 =?utf-8?B?Wk41M1hDY2w1VFA0bERYcWZ4dHdTajNSYno1VWlSRDR5NjNpTzVBclBrL2do?=
 =?utf-8?B?WENmQUpNcmQyMTFnV0s5aE54UUUvd0p6dGVXK1NYU0M5U3dWVFJkYnBWaVhS?=
 =?utf-8?B?TFpxOXZhLzFITG5IMS9YMnpFdlhCOENYakc3bDJjeDdwTXZ1QlBBVmJFTHlt?=
 =?utf-8?B?SjF5aCtacWppME83aTZXMmY2bWF0cFl1cXZDcndGZVRVYjNGOFYzQmNXSEls?=
 =?utf-8?B?U2wvUGMyYkpVTDlTdXlKRUJ5T2pYamo2d2FkYnBPNVNLd0JvRWFEbTNJSFlh?=
 =?utf-8?B?MkMydi94UWxEbWljRy9HSVBqK1pJYTA3Rm92V0h1b3JUdFNZdnZXQ3FYTUsv?=
 =?utf-8?B?aVc5ZzRRa1k3TE9wdVlITFB1cWkzeG5icFRwSWViVXRTcjdJeHpnRHVzdElk?=
 =?utf-8?B?Wi9va0ZUTllxRVlDdXp6Z0xkbW9WTlNhT09KUGlnZ0VMWWFzN1ZzeUxwdk11?=
 =?utf-8?B?WFJ4M1JaVFVGRE8rcVlhZUlDdkQ0ZytGTmYvMEJmWDZhUzBRcjl3dlJ1M01Y?=
 =?utf-8?B?QXNVUlJqSkY4d2FvZ1ZWbUdrUDJMcDJ3NlJpRUlEcUJlb2dkSlZBLzVBSjZ2?=
 =?utf-8?B?WXZ1a0FLS3BadDVKcnd0a3NoU3ZnV0ZKQlljSUNDTk1EQlZ4U25Ca2lWUjd4?=
 =?utf-8?B?aGgrYld5Zlp4UHo3VVh5Nk94MkYrQTRXOXpEcGZoNTF0Ukx2NDlMdTMxOFls?=
 =?utf-8?B?QnJNYU1RTzltZCtRTldUY2VJaklDSDdqclJNWmpNeDZVYVhVVFNiSUlyTGlI?=
 =?utf-8?B?dTl3MHNzZlpmaXhnMXpxQmZjUnJwNGs5dzBpNU45bVdnL0ZTSEVhT2Q1OVYw?=
 =?utf-8?B?dGVNVFd1MWpLRFZrSzI5L0lFVVdYVFlCa29Ec01aSTZaYUo0eDErWEh2VnRa?=
 =?utf-8?B?UVBRRHV6ZGhJWGs5UDhzOXBhYmc3YSt1Z2h1NFJtOU1zdjEyUWkxME1mZHFX?=
 =?utf-8?B?b1dUWDJEaTNVRzNwSGkzeEdXWEs4eG9VMlBvb3E3NjRud0RlZHM4alJOMmdJ?=
 =?utf-8?B?U0NGcVA0MThTelZhUmErTWgwT3EvRndmT0dKelYvcGN2MkNGaXZtVkJORCtS?=
 =?utf-8?B?S0RzS0w2ejgrcjRJYWhUalltQ2xycERSLzZHTFBDNS9mbkZEeTdHSXZDZDcr?=
 =?utf-8?B?UFJKQk5OdHVTalRFaWp4eWhLemFlZDY4Slg1ZzBBQ1VjRTl2VW91d0VFTWl5?=
 =?utf-8?B?Z2ttLzJYUlIybTBZMU9ISUtXSm1HSWRCVzh2dmRDNjFLWHArRVQ4aW53c3lh?=
 =?utf-8?B?VEViSEtYaDhWQS9MQmRZYWFibzNVc005WVpMdDVZbFpIbDJ0SFo4WGhiVHFG?=
 =?utf-8?B?eUorUXg1SXBVSFlhZUtCRDVkZGhuL1FGR0JnbkhnOXRQeXIyZG1vTnd6MHlm?=
 =?utf-8?B?VkxWdGxER3BsYjljaGhEMEo4UkcraXcrNUZSQWtsWGkyd3E1WXFHV3dmWUhH?=
 =?utf-8?B?WEtSTkUyMlRpdlMxMWJ6VzRyWWFmcFMvR1ZTMDFUTWVZeExseGhCWm5HTER4?=
 =?utf-8?B?T2VHU1EzS3dTaU92L2N4VnA0bXNJa1JvaXZDN1FBMVl5WEdacmsvVlVOVElx?=
 =?utf-8?B?dDNIU08vV05aVStLK0FHSHpiTEs0eU1CeVA1VENoZVpYOWhkM09TeU1uRHJa?=
 =?utf-8?B?Wk04QUdhNFlPbFpna3lmekdCaHBjQUsrMTNFckRBYTZCdm13TGZ6M01FU1pl?=
 =?utf-8?B?WGVMNTlDN2dualpuSGllN3Q0OEM5UEo2L0FCRVNVVHNYVTgvbHMwakttQmNH?=
 =?utf-8?B?SlR3TlRDL1ZWQ3JNV0gweG44dTdyUE9hK3QycWxhbnYza1hEbHhkV1c2Ulo3?=
 =?utf-8?B?ZWJpVUR2c2kwcnM4YnBvR2M0R3l2cnBUemNVeHNGdkFPNlEwNDFXZENqbHNO?=
 =?utf-8?B?WXBNVGdKVHdRMzdDNFJNM01XZU50ZjFmRlJJcTBjcXAwN05tV1dJTmhWeFZW?=
 =?utf-8?B?MGNTMGgrM3VTM2RvNkVPbWZsdWhuc1ZEY1dFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713263cc-2719-4929-5e8b-08dcb45c9ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 08:08:20.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxJxOUc3T8D6anc6mBNhnKIMMNB9Wk1UkXgm9Fm3KPWDAZwKja+Z8+HNegCP2zGR1WAdGyfslPu/MYVcn0wTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

PiBGcm9tOiBZdWUgSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgMyBBdWd1c3QgMjAyNCAxNDoyMg0KPiBUbzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsg
RGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47DQo+IHl1ZWhhaWJpbmdAaHVh
d2VpLmNvbQ0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHRdIGV0aHRvb2w6IGNtaXNfY2Ri
OiBSZW1vdmUgdW51c2VkIGRlY2xhcmF0aW9uDQo+IGV0aHRvb2xfY21pc19wYWdlX2ZpbmkoKQ0K
PiANCj4gZXRodG9vbF9jbWlzX3BhZ2VfZmluaSgpIGlzIGRlY2xhcmVkIGJ1dCBuZXZlciBpbXBs
ZW1lbnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZSBIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+DQo+IC0tLQ0KPiAgbmV0L2V0aHRvb2wvY21pcy5oIHwgMSAtDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9ldGh0b29sL2Nt
aXMuaCBiL25ldC9ldGh0b29sL2NtaXMuaCBpbmRleA0KPiBlNzFjYzNlMWI3ZWIuLjNlN2MyOTNh
Zjc4YyAxMDA2NDQNCj4gLS0tIGEvbmV0L2V0aHRvb2wvY21pcy5oDQo+ICsrKyBiL25ldC9ldGh0
b29sL2NtaXMuaA0KPiBAQCAtMTA4LDcgKzEwOCw2IEBAIHZvaWQgZXRodG9vbF9jbWlzX2NkYl9j
aGVja19jb21wbGV0aW9uX2ZsYWcodTgNCj4gY21pc19yZXYsIHU4ICpmbGFncyk7DQo+IA0KPiAg
dm9pZCBldGh0b29sX2NtaXNfcGFnZV9pbml0KHN0cnVjdCBldGh0b29sX21vZHVsZV9lZXByb20g
KnBhZ2VfZGF0YSwNCj4gIAkJCSAgICB1OCBwYWdlLCB1MzIgb2Zmc2V0LCB1MzIgbGVuZ3RoKTsg
LXZvaWQNCj4gZXRodG9vbF9jbWlzX3BhZ2VfZmluaShzdHJ1Y3QgZXRodG9vbF9tb2R1bGVfZWVw
cm9tICpwYWdlX2RhdGEpOw0KPiANCj4gIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiICoNCj4gIGV0
aHRvb2xfY21pc19jZGJfaW5pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiAtLQ0KPiAyLjM0
LjENCj4gDQoNClJldmlld2VkLWJ5OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEu
Y29tPg0KDQpUaGFua3MhDQo=

