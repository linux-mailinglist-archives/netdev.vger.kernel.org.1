Return-Path: <netdev+bounces-211607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94CB1A57D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C7A3AC6B2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2A21858A;
	Mon,  4 Aug 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="jrf6tT3X"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020097.outbound.protection.outlook.com [52.101.171.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4081E47B7;
	Mon,  4 Aug 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320037; cv=fail; b=GqbXajzEycHTBDVEBwbnvhPaxPmXGffvBR72TiPVhYxT1aHP5vx+T7bq4m6VkIX6AB0GfZ315FQFe4Iw2p80apbKis9RghSMQCLfssjhr2SVb296xFWHvQxGzNCvkBBqj4QO7aPRVSx2viD2SFAV7d4x+izrCmPcPV6S1alWqE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320037; c=relaxed/simple;
	bh=bNI8yTzPPv8jIaipKgGuuyDmmZ9h9zz8pNyb1U/2cQE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XS7/5Kwcy4vynV0gpWc0/KqH1sUKqrD3ABtn5IYpXrs/eiO8jUUbRVRFox1MVsM/jDYZs/6D+FRGbzy9ppS8djxDTrMRjlVQ+HS6z9XIPXS3ZgvOTi7w97Qxnq/uVZNVkeE3eiNQiLb5ckxIQPOKFw/+gPD+flU3xwWbTYpqWNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=jrf6tT3X; arc=fail smtp.client-ip=52.101.171.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R70zWdWtbRz+MiWuGfEFhG0l0WCW/MQXSwfIRjm1f1jFHJq97CYEWGOrFZhK9FjOD2cZjxdXaNhZy1Y8i2hZaltEZPFmn9HQOd+MjBsrkeUz8IxjmO20ENZcgqbUAQRPwO5SUlevDhjKTV38pQWBdM8heCFWb9nC4G8i8EFiqdu/SAIdgNUx7f3gS4s0oBERKOWrt2Zvfrl0/FJoP507pvuhqt/2gwGlFKCEsHZ5qg2zGOYE6n8Evhxh7BQEo9fHd39wvo2RZOOpmW8NSgTzwWdHpYCwwsseMQRsprCkpu0Wv65dlM/iBfMHORastEcF1RmGjOp+BVCO6A9jMJXtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNI8yTzPPv8jIaipKgGuuyDmmZ9h9zz8pNyb1U/2cQE=;
 b=e3kH+aA0Cil8XW5P0ZrYIXyY9fcoP9g5O8oL0OlMF6A3MwBVk9DrXKBT97rCiMSCntOrbO6rEWufe61zY/za89InPEh/SRNiqaOJYAl2OhEuH3wkyQtYLh8+T/0qIIKKy+bdZNFjPC47b5Jd/hv/85Wx9eJd8IK1BLtFdTCPvuq4gdC0Tnj3rg4T57EPzunvqENcqf/NZ78cE7fRv851bU0+xEd22onSdIE2g1Q7MjorF9a0Y17oj92fwU+fx3vQhPZbMDi02bY0GiEd0DFuo5ZK9lETQnA+NSjijU4Pv9kVwYOXZEXNG2zQPpj/+DDVQMtpbijA6SRdEojeJIwwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNI8yTzPPv8jIaipKgGuuyDmmZ9h9zz8pNyb1U/2cQE=;
 b=jrf6tT3XkbOZrkokB3aAMEiZoyTaitFlkkggNc9PFTbTm754OP6olZZRARzo80WQB7SHfR6NCVO8g2/m7MxgGVIuhmMlGBqAPcttIRooPLvAV0JjcmKND8U13mnN4pHQo/FflKO+MkGNihny/+8QH7ryGvX2UhnjhZhi0pZt6KI=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by BEUP281MB3620.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 15:07:10 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::934d:b034:c445:f67f%8]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:07:09 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v6 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHcBVFzM3IOy/Wt9EKQsk4a9qZ1Ew==
Date: Mon, 4 Aug 2025 15:07:09 +0000
Message-ID: <89e056f0-f5c2-48e0-a8c3-458bce3f0afa@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|BEUP281MB3620:EE_
x-ms-office365-filtering-correlation-id: 9b18cfc2-bf70-4ac4-4bac-08ddd36895bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGkvdjVJeFpIdVltajBUYzRmSlhEMVAwSVpUeEZBMFZneVJPZFUwb3hyb29o?=
 =?utf-8?B?bTlrMlZRRk5Hb2FuL3JjcllOUkM1SXBCV09MaVFEaThtMFF6NHFqRm9vTDJ2?=
 =?utf-8?B?eXpHQW5iWW1qVHdzWFhJakR6N2VlN28yQzJZYzd5Q0xvdGF3Z2lvejdsNEFa?=
 =?utf-8?B?VmtENTBoNkpFU1FIZHBuL1NHclYzVzh1VnVNUXN0c0wzQzR6MWwvRG9mK2NH?=
 =?utf-8?B?TndpMWw3MXBrTGxWaW9BYjF3cDdqN21rUE13VFZpb0tkaHJoZ0FLcWFleTVS?=
 =?utf-8?B?cG9KUjI2aWdjbFQ2ZkU0Q1U4eUJDc1ZNbHRlcTM2QlhvMENZemNDaFhCSnlp?=
 =?utf-8?B?dGtHelVkZE5hbkRLMnVDanNUY3grNzErVmE4RDVmUGo1dHcrMHp6aTBLQnB0?=
 =?utf-8?B?YUVzS2V3NzRTYTNQRis4aXhKbGVOdjdKdHgyU3M4cFpWcHkzc0UwYXljNUZ5?=
 =?utf-8?B?Rk5jNXMrNHFqTjh2aHI2aXRBVEpFVkdaU1oxNVlGb3N0a000dHVUU2ZFYUxj?=
 =?utf-8?B?ckhDTFE4eXYrK09JeEh1S3l4MGViaUZJaGRUZCtTVkNaOFp2NmJlQjZrQ0RT?=
 =?utf-8?B?cFk5Sm80NkFUWGlNWXVWM290elpsNEQwTEF6L0V2c2xOVC9Wd2NsT0dKbCtD?=
 =?utf-8?B?N0lKQUFScndtVVoxMm41NkRGWEhvRnJiWnpnUVhMa1lldjhDdlZsbTJ1RVV5?=
 =?utf-8?B?REhmZWdkRWcwNEs5aXlrZkpJS3RSeGswN21Qd3NIK1JRMVRnZlNkTmNZYnNr?=
 =?utf-8?B?N3NNaXhRZ0N0K29KS2JWdU1XVGx3R3hrNWY4QzVPeXNkZ3NZeDZ4bFZYc0h0?=
 =?utf-8?B?MW5EbEpHaGxteXRFc243WUYwUnRCbTF3RSswQUV2MmY4NTJITm1paFdwZGlF?=
 =?utf-8?B?L29tY3pVWWh2NTRZeUwxNlNZU1NoRlE3QTlIbTN0eklWcll1TDRGNmNMUlhX?=
 =?utf-8?B?ejlMR2hJNzM4VG8xemd5cmJtb2JIUFZ4L3VMcDNOSlhqVk9DRW1UY2l6Mity?=
 =?utf-8?B?cVNMMCtrTDJFNmpMeVZmN2tSVis5U2g5REFKQWpmNWlXam5SakJ1Y0UyYWRZ?=
 =?utf-8?B?UjlhTk5rQlNVUzBXRXBMYnN3emRrS2t1dGJYUmIvYlB2Z3JrUWE0cHhrZHVZ?=
 =?utf-8?B?Njl0N3BENGtqY0UyVTNweUIxdTJ6Y3BxdEMwRHRGUjBYYlVYd0lzVTJ0YUhv?=
 =?utf-8?B?NVgwdkFHNkRIQldObHM0eWpsVnV2Z2Z2ME8xdndvYlBtNDRGd0pEK0dVRFZ3?=
 =?utf-8?B?VDZkMkJHRjAveFduL2lQZERTVGZYWnNBOXJwR3ROY1FUc0ZzSDBCUEYralln?=
 =?utf-8?B?b1hoVzdncFFZOTlSaEZYaW9rTDcxYmNVOTZxRnBEY1RyWTZ3UzBUa3VuZmFj?=
 =?utf-8?B?QWNmZW14L2IySVJnYU15ZWJoUmFUVVM0RFpBQzc3eno2Y2l6aGhqWWgyWWlj?=
 =?utf-8?B?dXNzcnRCdXFmV0ZMZkpIOXlqVHExTzU2dXRaSzZ2Q1MyWWtGUURsRXJmdlVX?=
 =?utf-8?B?M29OUmtIcGtOejB6My9GRzc4a291WmR6SVJCd3NZRUpTSFQ3dXB2K2dPL1N3?=
 =?utf-8?B?N3l6NjMyY1J5eTZJZ1VzS1lLb2NjbkVoOHkxRGJhSC9MRVh1Nmpsb1JDOWF4?=
 =?utf-8?B?UTUycGlkb2hOb3gzK1FLMndCTmhIYnVadkd4K1FTNTZlenVzT3VuTzlXNVUw?=
 =?utf-8?B?cVJNZGpFVDNqUkxyL1ZPSEVnUmI4TmYyY0pKZEk2TjMya2dnQURyNUZLMEhT?=
 =?utf-8?B?elNDZXpLNnE1M0lqV2hzUkJjczU5S2VBWG5XTmM1TldrL0wvSkVRWHZzVktY?=
 =?utf-8?B?cFpJR0treDdTRFF6T3N3c0F2djdQeUlHM29qR1BUdjBWalRtcGt3TDJqcGtD?=
 =?utf-8?B?Ykh6clhnSUVNRHlCcTIzd0FKYUQzUUtIMktiMHF6cXR1ckZlamVFajVSZGE2?=
 =?utf-8?B?UjhVVlpzNk8zTW5iL2ZOMHBwSnZ2RklsMENVeE9EUUZJOXB0aU9nY3Q1UWN0?=
 =?utf-8?Q?/5WBunwcxeZmC255gZ2m+lIjsHnu/s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVNQWW8yc09nVlpseWhGb2kwWllremlmWGllNHdPNGNuN0paUGh0emlIVDJN?=
 =?utf-8?B?Ujl0bEExMGtZQk5OVlIyT09XWnVmREVmMGRJQjhPU0NUMjB3RENjUlBCdk9F?=
 =?utf-8?B?MzRlRnc3ai9hUjBBY29IUnhPQjRiRWlBZS9teldYOGVWa01zL0ZUN3pNLzBC?=
 =?utf-8?B?b2djbEt4bVFHeWp2MzhMK001cytoQWpqc0F2QmxhTEJpcE1HK0F1aDd3M25W?=
 =?utf-8?B?MlhFY3V4SzhtdGRMSlZycU5GR2RZTDVDOVV3SWZJZW5FRk1JRm50YmQwZkFG?=
 =?utf-8?B?Y29EUjI4UzRFdlRpUU9hMEhDK2xvZTBROCtiVmREdGEweEp1WThiS09La2Zo?=
 =?utf-8?B?bWpWNnc3OEx6Z2FuUFUxZ0VBcGJERlE4eEpjRW9rei9CZUpLdm9JT1Fpeisr?=
 =?utf-8?B?SVIyK2lJVjdkTTIzT1pmZDl1V0VrVnlZOE1QSElKOXZoaUovMFV3QkRReG02?=
 =?utf-8?B?b0JYTHBSa1RIbUIza1ZkZ2VPUjFUMW8rVmpzRXg2MU1WUEZRM01mblZCcFlQ?=
 =?utf-8?B?UitITm54VlhkUDJMNkJ0d2R3UG1kWVUxZ3NUak52Y2trTzF5RWRYKzBaYWdL?=
 =?utf-8?B?bDlVYStzN0VqRzJsZ3BmRnAxYmNxQWxlODZEY05CY2VnUXZtdGtObnZTU0Vn?=
 =?utf-8?B?eTZFTTgzYk1oQzVyWmhnQ3pHdXZLUm9salk5QUNtSGZ2QmlDcmw1SFNXYXYy?=
 =?utf-8?B?eGlqeHNzUHZwR2JSczU1ak01RkVPWFRRRitIM0hHY2wwMVBTdzhFdkFMK0lo?=
 =?utf-8?B?eFVOZTh5NDhsemd1ZExrc1V1Y1FkK0NoYjRxa3htTEdxUlI3SEtwS0ZZNURO?=
 =?utf-8?B?ekxDQmdyOC9qRzRDbThoa0Rnc3laZHhnZElOd3ZUSUNtMG9qRFdGcFAxV1dI?=
 =?utf-8?B?VUVuejdtblVoYzd4azI5dlN6UVBTTUJ0MlRQTjdVQ0UwcVNTeUt0ajhQLzk3?=
 =?utf-8?B?Vzk4ZEU2cXlBTTZoaUtoQXEzMnVmbm5JL0NiM2NZc0FiVWNFRysvR0dQVjZT?=
 =?utf-8?B?OFR4aG5yd0svZ0V6dHpObjl3bVY3RFg3My9TUncyK2haQXEvSDZPb3JSSjYv?=
 =?utf-8?B?dURsM2hsTTgzMjJHczJ0d3FDb1FkaVNPTWlRRlZucUdrcUswOXh5LzZrVTA5?=
 =?utf-8?B?c2JtY1BxcTgwb2xJN0xWVi9va3BlS2ZBbm13ZnZvQmJKeG9tVGFyM0JqeUhD?=
 =?utf-8?B?ajRLMTBVQ3VmWmlXQU44a2I4QktQdy9rNFpXTGdVcTI1YzdOTjRBWElGUnlm?=
 =?utf-8?B?eVBQSmx3RVhkTFdIWUYyeHRUbFljU0JnWlZNTTlUVHlidlNhK0JpZ01XcGF6?=
 =?utf-8?B?WjlRSXBMdnhaeTk4YkVBUlAyRkhIbk9qQmxMZnpuaDJFQzZ5V1ozanhsRXlj?=
 =?utf-8?B?ZzgwZFFHbEJZaEk3SnZkOEU0S1dhb0ZTRmgrN1V3cUFWYy9SaXM2Yy9nb05v?=
 =?utf-8?B?VWNIcjJtVVp4ZEVsWm85R2I4RU80TWZPR2xXcWdpSVdKb2ppOVRiek1CTXZi?=
 =?utf-8?B?cGlnS25nSUtScDYrSkRnSHRqUEFVMTR6ZzhmMTdQeW1IZGNPU1Z4YSsrUm1I?=
 =?utf-8?B?WHY4TkhmRHJ6L21vUUdycEhKaEdCdzhGOFRWTVNibEtEZDdpM2xIN2llSnpn?=
 =?utf-8?B?VCt4M2MzS080NTNGNUxoak01R2VHMlVSbkZiakJtbU43RzVBN3oyRjVzUzlQ?=
 =?utf-8?B?MFFDRm41MEtVV3hKN0ZUd2kvOVZOSWk0MkhKZDAxRi9nSHJsNnpNVDcvUUF0?=
 =?utf-8?B?eUVyanVKWlZVTk1vaHByOTR1dG83TUdNUm10UXJWdW1PNzFnUDl3cGx2VnhI?=
 =?utf-8?B?YmZ6NWZ2bnBCejJhT2FXL0NaMmpUeVRSWUpVdm5Fa3U5VDIzanp2MjBac2g4?=
 =?utf-8?B?aW9HZ01JQXpIT2RLSHFMUTZYWjZIeEs2SkdzeTB4N2NWZEUzZFR1Mi9ycXNQ?=
 =?utf-8?B?K3h5bDhxdEMxREdTc0greU9wZWtvUXlGZ0NObXpqVXY1WENEYjY5UXl6ZytF?=
 =?utf-8?B?VWZjb1VUTndmOUVnRUhPcEFuNFhOOG10eGJEbER4QTAyQzVpN0pHRVN2dlF6?=
 =?utf-8?B?Uk5WTmJXTW1QbmhJRXYrZElYSTdqNEdnYU55MGt4S3dpR1NPQUdOemd6MU5j?=
 =?utf-8?Q?zFzBnVh7K/rHBpFRx4IFCTiMt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5073F3DC911BFA468CD9B10BD708ABB4@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b18cfc2-bf70-4ac4-4bac-08ddd36895bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 15:07:09.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5l4OCEGjA9OGMMPczUxVHMULOmPLYmxE9l+1TgmL/tEELP1Zzxpcb2GoSriaNVxW9ju5xjMAzEErkW2PyQmFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3620

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KQ2hhbmdlcyBpbiB2NjoNCiAgLSBSZW1vdmUgdW5uZWNl
c3NhcnkgY2hhbiBpZCByYW5nZSBjaGVja3MuDQogIC0gRml4IHJldHVybiB2YWx1ZSBmb3IgaW5j
b3JyZWN0IERUIGNoYW5uZWxzIHBhcnNlLg0KICAtIFNpbXBsaWZ5IGJpdCBsb2dpYyBmb3IgJ2lz
X2VuYWJsZWQnIGFzc2lnbm1lbnQuDQogIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IGluaXQgdmFsdWVz
IGFzc2lnbm1lbnQuDQogIC0gRml4IGNvZGUgc3R5bGUgaXNzdWVzIChhcHBseSBjb3JyZWN0IHJl
dmVyc2UgeG1hcyB0cmVlIG5vdGF0aW9uLCByZW1vdmUgZXh0cmEgYnJhY2tldHMpLg0KICAtIExp
bmsgdG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9iZTBmYjM2OC03OWI2LTRi
OTktYWQ2Yi0wMGQ3ODk3Y2E4YjBAYWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHY1Og0KICAtIFJl
bW92ZSBpbmxpbmUgZnVuY3Rpb24gZGVjbGFyYXRpb25zLg0KICAtIEZpeCBjb2RlIHN0eWxlIGlz
c3VlcyAoYXBwbHkgcmV2ZXJzZSB4bWFzIHRyZWUgbm90YXRpb24sIHJlbW92ZSBleHRyYSBicmFj
a2V0cykuDQogIC0gUmVtb3ZlIHVubmVjZXNzYXJ5ICIhPSAwIiBjaGVjay4NCiAgLSBMaW5rIHRv
IHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYzBjMjg0YjgtNjQzOC00MTYzLWE2
MjctYmJmNWY0YmNjNjI0QGFkdHJhbi5jb20NCg0KQ2hhbmdlcyBpbiB2NDoNCiAgLSBSZW1vdmUg
cGFyc2luZyBvZiBwc2UtcGlzIG5vZGU7IG5vdyByZWxpZXMgc29sZWx5IG9uIHRoZSBwY2Rldi0+
cGlbeF0gcHJvdmlkZWQgYnkgdGhlIGZyYW1ld29yay4NCiAgLSBTZXQgdGhlIERFVEVDVF9DTEFT
U19FTkFCTEUgcmVnaXN0ZXIsIGVuc3VyaW5nIHJlbGlhYmxlIFBJIHBvd2VyLXVwIHdpdGhvdXQg
YXJ0aWZpY2lhbCBkZWxheXMuDQogIC0gSW50cm9kdWNlIGhlbHBlciBtYWNyb3MgZm9yIGJpdCBt
YW5pcHVsYXRpb24gbG9naWMuDQogIC0gQWRkIHNpMzQ3NF9nZXRfY2hhbm5lbHMoKSBhbmQgc2kz
NDc0X2dldF9jaGFuX2NsaWVudCgpIGhlbHBlcnMgdG8gcmVkdWNlIHJlZHVuZGFudCBjb2RlLg0K
ICAtIEtjb25maWc6IENsYXJpZnkgdGhhdCBvbmx5IDQtcGFpciBQU0UgY29uZmlndXJhdGlvbnMg
YXJlIHN1cHBvcnRlZC4NCiAgLSBGaXggc2Vjb25kIGNoYW5uZWwgdm9sdGFnZSByZWFkIGlmIHRo
ZSBmaXJzdCBvbmUgaXMgaW5hY3RpdmUuDQogIC0gQXZvaWQgcmVhZGluZyBjdXJyZW50cyBhbmQg
Y29tcHV0aW5nIHBvd2VyIHdoZW4gUEkgdm9sdGFnZSBpcyB6ZXJvLg0KICAtIExpbmsgdG8gdjM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9mOTc1ZjIzZS04NGE3LTQ4ZTYtYTJiMi0x
OGNlYjkxNDg2NzVAYWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHYzOg0KICAtIFVzZSBfc2NvcGVk
IHZlcnNpb24gb2YgZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZSgpLg0KICAtIFJlbW92ZSByZWR1bmRh
bnQgcmV0dXJuIHZhbHVlIGFzc2lnbm1lbnRzIGluIHNpMzQ3NF9nZXRfb2ZfY2hhbm5lbHMoKS4N
CiAgLSBDaGFuZ2UgZGV2X2luZm8oKSB0byBkZXZfZGJnKCkgb24gc3VjY2Vzc2Z1bCBwcm9iZS4N
CiAgLSBSZW5hbWUgYWxsIGluc3RhbmNlcyBvZiAic2xhdmUiIHRvICJzZWNvbmRhcnkiLg0KICAt
IFJlZ2lzdGVyIGRldm0gY2xlYW51cCBhY3Rpb24gZm9yIGFuY2lsbGFyeSBpMmMsIHNpbXBsaWZ5
aW5nIGNsZWFudXAgbG9naWMgaW4gc2kzNDc0X2kyY19wcm9iZSgpLg0KICAtIEFkZCBleHBsaWNp
dCByZXR1cm4gMCBvbiBzdWNjZXNzZnVsIHByb2JlLg0KICAtIERyb3AgdW5uZWNlc3NhcnkgLnJl
bW92ZSBjYWxsYmFjay4NCiAgLSBVcGRhdGUgY2hhbm5lbCBub2RlIGRlc2NyaXB0aW9uIGluIGRl
dmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbi4NCiAgLSBSZW9yZGVyIHJlZyBhbmQgcmVn
LW5hbWVzIHByb3BlcnRpZXMgaW4gZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uLg0K
ICAtIFJlbmFtZSBhbGwgInNsYXZlIiByZWZlcmVuY2VzIHRvICJzZWNvbmRhcnkiIGluIGRldmlj
ZSB0cmVlIGJpbmRpbmdzIGRvY3VtZW50YXRpb24uDQogIC0gTGluayB0byB2MjogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2JmOWU1Yzc3LTUxMmQtNGVmYi1hZDFkLWYxNDEyMGM0ZTA2
YkBhZHRyYW4uY29tDQoNCkNoYW5nZXMgaW4gdjI6DQogIC0gSGFuZGxlIGJvdGggSUMgcXVhZHMg
dmlhIHNpbmdsZSBkcml2ZXIgaW5zdGFuY2UNCiAgLSBBZGQgYXJjaGl0ZWN0dXJlICYgdGVybWlu
b2xvZ3kgZGVzY3JpcHRpb24gY29tbWVudA0KICAtIENoYW5nZSBwaV9lbmFibGUsIHBpX2Rpc2Fi
bGUsIHBpX2dldF9hZG1pbl9zdGF0ZSB0byB1c2UgUE9SVF9NT0RFIHJlZ2lzdGVyDQogIC0gUmVu
YW1lIHBvd2VyIHBvcnRzIHRvICdwaScNCiAgLSBVc2UgaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0
YSgpIGZvciBzaW5nbGUgYnl0ZSByZWdpc3RlcnMNCiAgLSBDb2Rpbmcgc3R5bGUgaW1wcm92ZW1l
bnRzDQogIC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2E5MmJl
NjAzLTdhZDQtNGRkMy1iMDgzLTU0ODY1OGE0NDQ4YUBhZHRyYW4uY29tDQoNCi0tLQ0KUGlvdHIg
S3ViaWsgKDIpOg0KICBkdC1iaW5kaW5nczogbmV0OiBwc2UtcGQ6IEFkZCBiaW5kaW5ncyBmb3Ig
U2kzNDc0IFBTRSBjb250cm9sbGVyDQogIG5ldDogcHNlLXBkOiBBZGQgU2kzNDc0IFBTRSBjb250
cm9sbGVyIGRyaXZlcg0KDQogLi4uL2JpbmRpbmdzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0
LnlhbWwgIHwgMTQ0ICsrKysrDQogZHJpdmVycy9uZXQvcHNlLXBkL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgIHwgIDExICsNCiBkcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYyAgICAgICAgICAg
ICAgICAgICB8IDU2OCArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDcyNCBp
bnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYw0KDQotLSANCjIuNDMuMA0KDQo=

