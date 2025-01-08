Return-Path: <netdev+bounces-156153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9EA051BE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 04:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3327A25DF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22D19CC0C;
	Wed,  8 Jan 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="cd9+rlEN"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2133.outbound.protection.outlook.com [40.107.215.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7552E40E;
	Wed,  8 Jan 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308478; cv=fail; b=eTzIRk8Azm90NrzITBMRSgttTzSHyOCyAkI5yOHHbFaPY9lx6DW7Q1WvgBNd/eYNOabz0BuePonFxpZuTpF3nh4PmFFzTWjHD2ewJx3BQOxlsP2TRgGBI9bqB3xsWVRuWiINXov9R7HjfoN2R2T26NiaXJxcfEich7vOP/3vnBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308478; c=relaxed/simple;
	bh=7locB7kTTS5ue/pMZrZwxf7UQWbXjlpMksmNz3YQyPY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ec3BaI85QvFCK3YIDofnVEXoT6uMkcR5eUJPS4AuKwWEsBSoiRMkgdLTLF/8omyb0sy8qwzjgRZB0/BFt2xQCMWjaxHu8xdzTabmYKPNA1+E3eQD7S6F6kNEJF0oj0xuVdGhQ8MpyKjN3PfIAtbu1Vs8bOzN7IyNEuPQtCf4Xas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=cd9+rlEN; arc=fail smtp.client-ip=40.107.215.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5cNdvI+RJdBDjGuDJEDwEbk7yWJ0xX5adUD/uHudiXUPMzUYfy4Ti+VWKBTtdMFB+6+0L3QwMuHWx1G3ZnX795kW798dFeUtbn3zAaCNSeN2i4AF315t/HoQffH+01K+d2iXoBT/ZfbBSLL/kw6z+uKiZqhTGAnFvmwkYaomUaa7pNsKXqrI5XY7Sx72ngf/q32ROnPZIuykxqSRdky7FKhPnS4C3w8JIiCU51LkeVQPH+B2+QR9X2MeLkL+8hJ/2D3YsRzuX8EDseOgzndl/sJtFy33dknSOqb1ek3WnbLRLptG5C6Fg2DhzNA4UGc7KD7Jo/KBOL6WCNc6dQ80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7locB7kTTS5ue/pMZrZwxf7UQWbXjlpMksmNz3YQyPY=;
 b=zGWnD6wZLlsXqvMdIX4hU0V0Hon8Ro2uV2zPpkAkNi6ErAG1jEAo1rTzivx93H1S2IVATR9Uo5zA7VIytkhPbUUl0GLaDkJxwsVGhsm0606coUwz4KYC2SuQeupRVPjft2AaqiGJgVH2ooubGTJe4YpNbx30kvqfFg+yVAsXmSgMGftrhE28oUa4iGGoka5XXloU6oLeA3F22SAjUeo1CkLjEiuzCZtOXiENGy7mx8S57s6EHkIwSW6dW5Os3GHgiibqkCEOWiO6wghSYqO/l5yo32UsDRL0G7edU8blmvT4IXZIqDjMypP3HiW6w74IMflCcCcfDMRl+fK9/L1nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7locB7kTTS5ue/pMZrZwxf7UQWbXjlpMksmNz3YQyPY=;
 b=cd9+rlENoiC9NUWAAFRr645cQFoISV0HEPzi6SRodSkvzBJ2ygEiQEqnZgO15y2b8m8p7g4jNoUsFB38wXE9DjHhw8ffA0pGeLSh3jhYzyIZ+rBru+g0B4rFp+eGPKUKpkFAaRevcT85w76YcKh6cJqOYiAiaKHN85aWrtpC0yDyKUCjOeXO/CdWUfHqMxzmB5295AfPLn/eM+eaErcsZU5mgG1H8F9FiHQpAc6R+HX2rcBu1064F2LZEwMQN2Yvjj0YxnHxaC0vDceoL1n3/a46J/lOY9Krn0+ZFdgc2NzNs/KNf4uUF5TsRT2vccg+MrOB4ur3q3CkQ5xe/WPaSQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB6446.apcprd06.prod.outlook.com (2603:1096:820:f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 03:54:30 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8335.007; Wed, 8 Jan 2025
 03:54:29 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ninad@linux.ibm.com"
	<ninad@linux.ibm.com>, "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Thread-Topic: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Thread-Index: AQHbYX4ZqwUnoFUOykuCVX4SkD1z2w==
Date: Wed, 8 Jan 2025 03:54:29 +0000
Message-ID:
 <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB6446:EE_
x-ms-office365-filtering-correlation-id: f5eb09c9-ed7d-4f7a-8c34-08dd2f982712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?MjJRaHZ5RFgvUjJDZW5RMm9mRzUreUhucW5Lb0N6UUNqeW5mSmdOcERWbUFscVc4?=
 =?big5?B?eTJiRGs2c0QxWTNEQkg5VktGeWhaY3MzdFhRZWlqaHJLMFdmbm9OL0ZNUjBvS1Br?=
 =?big5?B?UHJqNHFCVm1JRjc3ZzNBcmNRcHN0RkFNTWo3bHRHdmlJODlMWm5pYzNOLy9ERXpn?=
 =?big5?B?N2dsZEFuNGFTbXFwb0t6cGNrM0xLK0VDalYzS2M0V0NqcHFmWTB1aUJsSm5YMEFI?=
 =?big5?B?OHlsZDI1bmw3YzB1dDdINnlmaXFBcXZTYW5yZzdOYzJVcE5DMG9jMW9nYi9aNEJD?=
 =?big5?B?elRqQUFpbWlsbG5YVC9LTjhFT2JPQVhDdXl6S1h1eUluUldKZmNycTN6MW9zRUhO?=
 =?big5?B?YjRXeUd4Q1htV3Myclcrbnh3NzBtaUdTaDRuZmFCcmxVT0dpYlgvZU5sZ2pmRHBP?=
 =?big5?B?UFBwcW9aMDFFT3psQVUwQTRweWZaQ25CdFlYRTdqektkaDRNWFBsbG42Y25sbnlZ?=
 =?big5?B?K3JqcnJ6TzRub25rUVN0cHJPNFEyK280WVNYWlgyc3ZoNWpUTk5mUTJyM2JjSmhi?=
 =?big5?B?SU4rYU1MREIyNTBwMGhjalg2dDYxbG1uMGdTMGROSmludldkeU04aWtpbUJEejBa?=
 =?big5?B?bWIrdlA1L3FCcVhnSVg2VVNET2ZETU42Zm9zN2dUWTgrV1ZVZmJ6eW9UTUhNSFds?=
 =?big5?B?My9MN0VHejIwOHBrVUhSRlhuNWNhdjhvS3ArTmZHc2F5VEhVdFZWMVFOYmpTV0U0?=
 =?big5?B?eHRwK1c4RHpybXhIS2wvZjdJc0hCUjdySUc0aVhJditaaWtQcGQ2eXIyTDRXdFkw?=
 =?big5?B?WWpxbUxYV1dyaTdTOU00SHVlTEJXd2hSTHh5RS9EbHdYQlc4VjBkVEtVcHN6R2ZL?=
 =?big5?B?TkxsL2pid2dXLzJYbEZZdEszRWlHVGxlVHYvaFNTMDVEK09xV2hrK08wQktpVURx?=
 =?big5?B?NUMzT0d2TkwxOE5IRVk2bzJOend4N0tXeFJlK3MxSDNldjJDK1A2MVBsQmVENDJG?=
 =?big5?B?clJqNlVuRE5jaXR1UGJyTy9VdmZ6Z3BPSHFSVExzTW9ValJOWlo4N1R1NHozRmo1?=
 =?big5?B?RllGVjUzclFtTlJydmh3Zi9OUFhDU2dpZWpXWkRDZmU0Z1VpN3g2Q3lBVDh2T3JH?=
 =?big5?B?UktsSTNnMnEya0lwVXVzQ3JwcndHc0RneUo2TVRoU1JKcWlhK0kzdDNqYko3S1B0?=
 =?big5?B?VFEzRm45K2VzY3k4di9QWWxoQlFSZlhJbCt5UHpWOFZBMWI2NXlkaTdxcW1hTzVB?=
 =?big5?B?eElUY3NzMVBpZ05tRFZTSWI3ZEFuRS9lZTk2RDJqYmExcDBCbE5EYUFKME9xU2xX?=
 =?big5?B?WmhjbDFldmhEY0YwSUNyRWZITjNqRTFUR2d5NnNpbEM3dVRYNzk0SFpDZWpjWmYr?=
 =?big5?B?RUV6dTlWQnJxRWRuWnhUUTRYcFArVWsvOFNiellDMjJhc2trc0ltajVBZmdPSkUy?=
 =?big5?B?N0l0NkNVTldYRld1SDl0Y3RBdEZQN3YzdE1ZM2ZyajRCTkZtWG51ektRZEhnck8y?=
 =?big5?B?cFF0ZnppNWlmV0FXMjZVSy9VaUJNTHBpSkl0Wm1hOHF2R1VDa25NaUZTU1RtMVN6?=
 =?big5?B?a3h1U0MyU0tXbTV0dlRlVmVKS0VmQlU3SGkrcXFwYlVzSU5CWEFKL0RNMGNFaUJ4?=
 =?big5?B?Nmd3NHFNcDVzNWNneHcwMVpxTjhYc2VLSFc2UFBheFVUMzJuY2krWTVBZGdZOG1o?=
 =?big5?B?R0F1OGtiVVpMTGJxeXNneFV5VlVYUEh1dVk4YXJaNGpvaVArUUZ5L2VRNEdubnNU?=
 =?big5?B?UndmMFRJNnN6TmlHa3luNjJUQ0U4RWpOM2paUHpPOUFVNTBUOTdjRFM2aDZWL3Ez?=
 =?big5?B?cktNTXhvNzU3LzlWK01iUk9YRDM4TjBROENXUmZnQkZSQTlXWGZ4NWFGZGhRUzlt?=
 =?big5?Q?uuAGxpSmUBivGmuzhetW4Zt/CGDE/nVu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?RDI0VG52QTF0NnNxbVFFK3lpd1F4UURYYVJMbHpHVENDbkI2Yll2ZDJFV3VycUpQ?=
 =?big5?B?eTBpSEFYSXNUemJCSDBsb1ZuQ2NMSnRhS1ZtYk1vRDVhU2tFY05HbGFNNk5saHlk?=
 =?big5?B?engvM04vdWpzbWVIbHRvVllkOEoyeHl5YjdxV1d4cC9KTFBXbWlDcTdJc2NEZkdr?=
 =?big5?B?VDEvaSt0YlBQMG5JL29RTXpVZmUyb0VrakthR2w3QWpydjI2aTRzNVpxMDZzK1NG?=
 =?big5?B?c1Nhc3drZEpucmlDL0hob2FFTUxQeHM1eGFkZ2pjMWxiRktxMURGZWNITGtYNVZW?=
 =?big5?B?NzdFaFJlbFIrZ3ZEZ3hMVSszZzR6NHNxTW1kSUpoZHFyNDkyL0hrbHNtWFRMcGl3?=
 =?big5?B?M1lURnVCZ253dHRhcnNFSk95SFI4UFZua0h5U1lnaU1LZ3NWMk8wd2pYSWc5WDV4?=
 =?big5?B?TjYxMTNHWk45aTl5aE8xRXZZMmxxOGFwZjBDVk1WUHZXcVZuQktEazhMSFZGUTkx?=
 =?big5?B?dENtSENhdEpYL2d6alBWVDRnQWZBQW9EZVJpeUwrdFNhMmdJL2FBb2p6cklPOTNK?=
 =?big5?B?R3JpSmFyVFZJR25yTVhQTDBmVjZCMGI4dzlpcG0xeGQwUGZpWHRLWGU3UjAyMnJG?=
 =?big5?B?MCtFNHo4S05WVWIwZytzbzQ1ZFVEbUd3czRQQWlsYjVxeHRpelVUUnJBN3J6N2tW?=
 =?big5?B?d2FJNVk5VFJLODB6ZktkeXRDazE5MTh4NG5kaHRTT0lEUHp1c1JmWXVaVWJoVVRZ?=
 =?big5?B?cE5rTGpCK01NTU1idWpCdDZwRTIwbW13ckFqU0MyaVM2QVl2WE5JbXRoVTdYN0Uw?=
 =?big5?B?RFBHYmordVZ6cG1wbmlSRXJ2bitLTkxsekw0VU1FMmlobW5ZVXlUdlNZQXlYRkhq?=
 =?big5?B?L084TG00OFFxcEJDVHpCQkdjY1RiOUk1SmxXSldNM3J4QU9xSHNPdk5NRXZOeFVu?=
 =?big5?B?VHk3a1UwVm16bU01RG11NFc1eHJqUXNmb0ZBNXhtVVdSWWxpQVc1bDRFL3U1Rmhi?=
 =?big5?B?MmVaMTRJYVR1TDMwN1NOcU50VXVJT0IrTTBmdmUxMHMyQ2s0MGc3TEFGTWpiQks3?=
 =?big5?B?M2xHU2RaTkNlWTdNeUh6Tkk3KzJLY3J3VHhydllMUDlrY1JITXE4eEU3d1hZb1Z2?=
 =?big5?B?eVpxdEtLdlliazBqa212MytGN1czZVplN0FHRUJOSHk4Sjh1dlJ1ZWlYZHlIaWJr?=
 =?big5?B?enVCVmtmd0l3YmxucE1pVEpybHhHNEtBWkdYSHRwcWxUQTA2Q3FtMlVReWtQK05H?=
 =?big5?B?aS9rOElKMmJpR1MzTGF0Sm9sWE1CVjBoTHJBVDlTNFo4MDVWTjRuT090K1FSNFNM?=
 =?big5?B?T3E4OGNCWmd5Z1hZQ3ZJdkNVaTVYb216RjRScU44S3AwQ0l2cWhORTE2NU8weEJP?=
 =?big5?B?SWR6ZHl5M05hV3U0YUVzUUJyQi82azAzYi9sdDFJZzRqVVc3QUlQQW1JR2xmTDdk?=
 =?big5?B?Rmk1SVVBcGwrbUFtQ1FZbHYxaW53TFBlL0IwQ21NUmFJZC9SNTdGa000Q0hialVm?=
 =?big5?B?L0lzWmlKaHFyeDlVc3J4L0oyTURaa3Y4ZEZFaWRMUG1XTVV5VUJKZzkwbGY3di9J?=
 =?big5?B?VkNubHQ4R2NNRHpMd2EvOWZhVHNCRURWQkZ2OXBJUUdZNktFeWowd0FqcndQVXBw?=
 =?big5?B?aUpRVXdXSVpyUE5BYWN6ZElKNFZKTWNLVy84NWgrdTRUL0pSZkRkZjJubm0wM1gr?=
 =?big5?B?QngwYTBTc241TlA4Ky9mQm5RYlFaU0dtRThKSUJKa1hiR1BDWWt0UTJKZXBZQ01O?=
 =?big5?B?YTkrdmZSUUFqZEVXNEJ1eDZvV2xIcS9PY3Fld0E4Y1N2UHNRVWJPZHNCb1UzOWRr?=
 =?big5?B?ak82Sko3bzRvVGRkT3QvWHJtOE9BR0tmaTZNNUtyTGdqZGEzL0RxMS9kTzF4WGdO?=
 =?big5?B?czNsVmlYaGJabG5tbFUvdTU1dEg0OVZVK0RiSkFBZHJvcXMrUDNKRVVwbk1mSmhn?=
 =?big5?B?MzFtQUZDWVhPcExyYjQ0L04vaWJleVR3TjNWNDhZcWxpUVRMRXlxZWdqbEx5dnNE?=
 =?big5?B?cW9sVUhoRGEzVUNkMC9WQ1Boek1aRHdGQ2xucVNjTTk5cGNtUy82NkxWb1A2V1Vp?=
 =?big5?Q?ijlZKKKS5WFQz3LI?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eb09c9-ed7d-4f7a-8c34-08dd2f982712
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:54:29.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KvN6oQWtDYp3mzeQns96wBiiXsB7OpirKFlcFZBDEbRk0TvjXpzekGa/zAoA4Q4MiCwWrnS701HJFM7y/4Qqi1dWoDNc9aom4y34s7Cvjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6446

SGkgQW5kcmV3LAoKSSBhbSBBU1BFRUQgdGVhbS4KCj4+IHN5c3RlbTEgaGFzIDIgdHJhbnNjZWl2
ZXIgY29ubmVjdGVkIHRocm91Z2ggdGhlIFJHTUlJIGludGVyZmFjZXMuIEFkZGVkCj4+IGRldmlj
ZSB0cmVlIGVudHJ5IHRvIGVuYWJsZSBSR01JSSBzdXBwb3J0Lgo+PiAKPj4gQVNQRUVEIEFTVDI2
MDAgZG9jdW1lbnRhdGlvbiByZWNvbW1lbmRzIHVzaW5nICdyZ21paS1yeGlkJyBhcyBhCj4+ICdw
aHktbW9kZScgZm9yIG1hYzAgYW5kIG1hYzEgdG8gZW5hYmxlIHRoZSBSWCBpbnRlcmZhY2UgZGVs
YXkgZnJvbSB0aGUKPj4gUEhZIGNoaXAuCj4KPldoeT8KPgo+RG9lcyB0aGUgbWFjMCBUWCBjbG9j
ayBoYXZlIGFuIGV4dHJhIGxvbmcgY2xvY2sgbGluZSBvbiB0aGUgUENCPwo+Cj5Eb2VzIHRoZSBt
YWMxIFRYIGFuZCBSWCBjbG9ja3MgaGF2ZSBleHRyYSBsb25nIGNsb2NrIGxpbmVzIG9uIHRoZSBQ
Q0I/Cj4KPkFueXRoaW5nIGJ1dCByZ21paS1pZCBpcyBpbiBtb3N0IGNhc2VzIHdyb25nLCBzbyB5
b3UgbmVlZCBhIHJlYWxseQo+Z29vZCBleHBsYW5hdGlvbiB3aHkgeW91IG5lZWQgdG8gdXNlIHNv
bWV0aGluZyBlbHNlLiBTb21ldGhpbmcgdGhhdAo+c2hvd3MgeW91IHVuZGVyc3RhbmQgd2hhdCBp
cyBnb2luZyBvbiwgYW5kIHdoeSB3aGF0IHlvdSBoYXZlIGlzCj5jb3JyZWN0LgoKSGVyZSBJJ2xs
IGFkZCBzb21lIGV4cGxhbmF0aW9uLgoKSW4gb3VyIGRlc2lnbiwgd2UgaG9wZSB0aGUgVFggYW5k
IFJYIFJHTUlJIGRlbGF5IGFyZSBjb25maWd1cmVkIGJ5IG91ciBNQUMgc2lkZS4KV2UgY2FuIGNv
bnRyb2wgdGhlIFRYL1JYIFJHTUlJIGRlbGF5IG9uIE1BQyBzdGVwIGJ5IHN0ZXAsIGl0IGlzIG5v
dCBhIHNldHRpbmcgdG8gZGVsYXkgdG8gMiBucy4KV2UgYXJlIG5vdCBzdXJlIHRoZSBhbGwgdGFy
Z2V0IFBIWXMgYXJlIHN1cHBvcnQgZm9yIFJYIGludGVybmFsIGRlbGF5LgoKQnV0IGFzdDI2MDAg
TUFDMS8yIGRlbGF5IGNlbGwgY2Fubm90IGNvdmVyIHJhbmdlIHRvIDIgbnMsIE1BQyAzLzQgY2Fu
IGRvIHRoYXQuClRoZXJlZm9yZSwgd2hlbiB1c2luZyBhc3QyNjAwIE1BQzEvMiwgcGxlYXNlIGVu
YWJsZSB0aGUgUlggaW50ZXJuYWwgZGVsYXkgb24gdGhlIFBIWSBzaWRlIAp0byBtYWtlIHVwIGZv
ciB0aGUgcGFydCB3ZSBjYW5ub3QgY292ZXIuCgpTdW1tYXJpemUgb3VyIGRlc2lnbiBhbmQgd2Ug
cmVjb21tZW5kLgpBU1QyNjAwIE1BQzEvMjogcmdtaWktcnhpZAooUkdNSUkgd2l0aCBpbnRlcm5h
bCBSWCBkZWxheSBwcm92aWRlZCBieSB0aGUgUEhZLCB0aGUgTUFDIHNob3VsZCBub3QgYWRkIGFu
IFJYIGRlbGF5IGluIHRoaXMgCmNhc2UpCkFTVDI2MDAgTUFDMy80OiByZ21paQooUlggYW5kIFRY
IGRlbGF5cyBhcmUgYWRkZWQgYnkgdGhlIE1BQyB3aGVuIHJlcXVpcmVkKQoKcmdtaWkgYW5kIHJn
bWlpLXJ4aWQgYXJlIHJlZmVycmVkIGZyb20gZXRoZXJuZXQtY29udHJvbGxlci55YW1sIGZpbGUu
CgpUaGFua3MsCkphY2t5

