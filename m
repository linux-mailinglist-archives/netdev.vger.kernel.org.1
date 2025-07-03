Return-Path: <netdev+bounces-203847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9299AF7722
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0724A1185
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C02E92BA;
	Thu,  3 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECKOfLJS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD819CC02
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552403; cv=fail; b=dVKItq/MgyLAG7/vSAa/OHys1epomZLd6xWlMKcXjD30zQutfcDLSoeYfghDmUGApoIXkLb+pU6TrqOa2sOQ6+U39M20YuyfllzCOBLcxMQ0MzFfZxaEK6bOtFUQltlCeKUCUMjY0HzSw6/ZVRz4HV87Hab5cq3/M4b/uNjAlM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552403; c=relaxed/simple;
	bh=agckePhXPgtXFpCCUrJ1D1vA6Agol4TXNFMIq8TgND8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzlNpjF+M9Btv8imCPwxhp06TfBoUcUWIwb5O6oMbBgnjFBjikxPd2GsBRUCukgDCe52ECYfyQqbfd71YdmR2GZp1zdJmJB105YiaiLwki1Ve8BkbtC5nlpMeC1inMKIWBf+f9H1K1lTMtvMB4t4WYQvpr1SuwHTyGi6TyZZ/tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECKOfLJS; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4RHbp12j9qEYV4kAa7NSugfsO9VgS4UzuWFzy3i6oVLhUcFUwq0QikYNkKqFgnRM1N49Or9aRfZwHTWYzRQDzfPH7n1PSS5qgmOHUJnVzb3Kt8bp+Z28gya8II6S1bOuPx+9rYNrRjYTAAIsrbLR1bTGeXLfHhtv68AkMOIPJVEBTcePkVd4jhdiuH9MuRLDSBSsej1NePRESHpP+twWSBo27EK352ijeQZDF0AWlEvLpn75kIVRk1JsOQgvuwfSoix7/WNHKpUgU4QQEH83OsfbNOSiynxvvZ+IXCbOf8P3WFKZe0M127iYNsLF6p3gNTYyIReeQjyGDnYpzeK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agckePhXPgtXFpCCUrJ1D1vA6Agol4TXNFMIq8TgND8=;
 b=BhKWvLF60M8yQh9y8sG3ROP+VcVzECjq4V77sxqVHUq18Dqi5w2eZl51MPJc7HNL2GFuc5eGd6PvYJwXJTR8+7D9Njw37zfUccm8mDBKGK/+j2j4n79HEXz5E8+XpYVh3vuI45ZsdUXKzMTw6TyXeX0XgNqN07QO/1bE+GPUJW/I3kFL87QLpCOHJH/ty3VjnjE19Leip57SPHrx/mhgmKSoWCcmmD1uY9UzDsliM7CJvMXPrANsy/KPg+wISm3OyWajJ4mbYLM4SDemKo7ZFqW0Bn3Sy7zpzHMtJg+ik+BS5B29HfRsgOeCesUyOGJwO4mSiaGJLtvGMUqeq2qJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agckePhXPgtXFpCCUrJ1D1vA6Agol4TXNFMIq8TgND8=;
 b=ECKOfLJSfhtj6M52uGmF6ao5/FbQ1tRGWulKHBIA7AYBUTFAiYCtKUj1tRc8ueoyUEbe4O+TWPebSq0h90w+h0+ls0dOld09d6LgvKUCHFNZtBkysrVHbzhQ0rnLDgdIN9Xlnp1gCMJy1jqFYA9ApKDwilxSUeZXGABCNU8/N0bXQT78XAlQlxwn8nq2A2PfsDyAfL3sVgiPCOMtATY11Y/UWdmuQJiHuNSFr1OUPrJnH1Cct16eXqxHdxCo70SFen+4YfW7KW3Gaz+tHi8DD2kDROr5iJaZVQtGZrhvmKOjMDtUKWVDKysAL+qLR+QaHB5NGDj334MeGvW2g/5S9A==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CY8PR12MB7756.namprd12.prod.outlook.com
 (2603:10b6:930:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Thu, 3 Jul
 2025 14:19:59 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Thu, 3 Jul 2025
 14:19:59 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "erwan.dufour@withings.com" <erwan.dufour@withings.com>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "leon@kernel.org"
	<leon@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
	<tariqt@nvidia.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "mrarmonius@gmail.com" <mrarmonius@gmail.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Thread-Topic: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Thread-Index:
 AQHb6TnEtCc8cVCBnkaQratSuN9zcrQbe70AgAA9xACAARZOgIAAuToAgADxRACAAQ2xAIAA78EAgAAA4AA=
Date: Thu, 3 Jul 2025 14:19:58 +0000
Message-ID: <1d93fb4824681a08149e5e83aa81aed5b9ab4079.camel@nvidia.com>
References: <20250629210623.43497-1-mramonius@gmail.com>
	 <aGJiZrvRKXm74wd2@fedora>
	 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
	 <aGN_q_aYSlHf_QRD@fedora>
	 <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>
	 <aGTlcAOa6_ItYemu@fedora>
	 <CAJ1gy2h+BtDPZ2y4umhjVMrD74Nd5dZezdZOOy-YqLvyFGKKQA@mail.gmail.com>
	 <2152c417f85fd77d795da7fea1d7daadb312ce41.camel@nvidia.com>
In-Reply-To: <2152c417f85fd77d795da7fea1d7daadb312ce41.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CY8PR12MB7756:EE_
x-ms-office365-filtering-correlation-id: c6e67353-0501-4075-1fbf-08ddba3cb128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWZ3NWtEaXJ6MWVxRWUxeHl3VFNVSGR2VDVYQkR1YWR6VXhmVXcxRTZvV3F1?=
 =?utf-8?B?WjUyUE9WbXV5Z3RESHNjc0lQTmVsQkNuRXJEMm5MRitYWkNMK2hiTGl3dnJm?=
 =?utf-8?B?K00zQXhxZlAyRDNQUUxUM1hwU21UbTRpdjc2NWQzVDA0WW1IS3MxWSt1RDMw?=
 =?utf-8?B?Ty9GVkpDaUtXOFlmSCtIRVE5bldhVTdOQWt5cmYxU1MvREVaNTJWSndzRHpF?=
 =?utf-8?B?cWRFWXFEOUdWd014N2NrV2NSQlIxYnZUYk1GN2FWekdZU3dYVlVrYTZGSlNS?=
 =?utf-8?B?OEdsb0w4SmprRXc1TWxoNmhKcnE4aDd6elh6eEtYMWlubmNYUHFiSkloNmlM?=
 =?utf-8?B?MHFmcXJYS3lvcE5CdkxGQ3UrRnNPb0FsUlNHYXArL0l2QTllVVVvRG1BU0g5?=
 =?utf-8?B?UTgzdXNkVFk4WGFCTVFkcEpvRW9ZdkhhZ2Y5a2EzaVpJS0xBcjQrcEZYanNH?=
 =?utf-8?B?TUREY0lMRXpBM0FVTE54cVQrblhVa1V0LzJTR3phWWFWYWpCaG54c0UyeWE5?=
 =?utf-8?B?V3R2ZW5EL0RNQ3FSd2Z5eEd3azFVUnZQMWpUUXpEeCt3RUkzY01ZSEpNNkJE?=
 =?utf-8?B?NmlyZ3MxYTZTMDNRYXBDb2RIYmFlU2ZRZEllQlFhOXVaVmgvdEpjNm8yMERU?=
 =?utf-8?B?VVUrUjZkMHBDWGVaSjNYUFFpSklDT0ZaYTlvOUJyTnlXaDNHRFY4R2QwRUt4?=
 =?utf-8?B?N1ZveDMxVUhWRnNUNzFhRXF6Q1RBSmU5NlVEZUE0Nit6RkREQWtHdVhNQy9h?=
 =?utf-8?B?WWttVzlCTzVSZmJVakNrVlJEUnNJSEh1TlhPYTZicnRtZlpoUDFjKzlNNVpl?=
 =?utf-8?B?WnZTbjZHYk5td3BHMGY5YU5IcndCa2MwVDFMVnd3NVlFNFdIZzU0UFhIN1NT?=
 =?utf-8?B?RFU0VVZRSk1vVG14blV3UjBqTXZoV3o2TldJUmJCYWNibkw3ajAzUktCSWRX?=
 =?utf-8?B?SGp0R3pZTVl2c2R1alpKOWJuRXhLamVuelMvcmIwdi9ucUFydHBNR0FjMUtw?=
 =?utf-8?B?Z2d1WXpRek9GZlcrb3lEUDlEUnpTNHZMYXRQdU9Zdk9LTHdUUDltRnJhanZ4?=
 =?utf-8?B?VFpFR2RGQXlLL3NNRXhmM2dCS2N3cFNqcXAvVmN5S29uNG41d1ZKb3pCaXIr?=
 =?utf-8?B?SGFyMGl5ZmtFTWx1K0dmTWE4MU95Uk5lNzVURXl2QXp0eTFzamdWUHd0NkNm?=
 =?utf-8?B?MlBMZVhHMDRpRzYzZkhseDJ4WkVlaVVzaUYxU2V0b1JzbUJLZEpBSERhdnlh?=
 =?utf-8?B?UHNGcUFNeUVkWnV3eGZmVnNTVlpjajV5MnZqQkhVOG9FVjhrbnN6VFc4WCt2?=
 =?utf-8?B?ZXlQZTZGeEd0dXFaUWN6eTBMN095ZytaeVk5eUZVU0VSYXprR25GeXpUWm5N?=
 =?utf-8?B?OUQ5ZHVFOUZ0MXhHNTJvRmllQ240OWdYTGJ2dTBtY3dNYVYxT2oxRnczNnFY?=
 =?utf-8?B?bENNZUE2UGhOSkorK2NVcWtsaUNHMHRMZFRheHI3cGVNSTVxa1R4M0pNSWpo?=
 =?utf-8?B?dHVLSDFhYzlmenRTNkFwNTRuSlFiTnNrb25mSGFIbXoxUmVpSCt0QVZPSzl3?=
 =?utf-8?B?cjNmeVNuOHBaZG1CeituL1JwQVVzZG1sZ2ZRWXNUU2gxZEFsL1ViWTIxRkpK?=
 =?utf-8?B?WG5Ka3pEN3lZT2Z3VmpXaFY4disyWVkyR2V3TXNWY085TVBuTHpFOU9mUHZS?=
 =?utf-8?B?b2Q0RGpJUGdCTXlKbzAyWWQ3eWxvY0hrQWgxcmhwQzNROStmcFUrL255dVVQ?=
 =?utf-8?B?bEY0Q01hN1pwTDRENEZUZlJTU09wYkhIVmZGOGppV09sVEN6UExKZGo5Mmhv?=
 =?utf-8?B?cVl5SWs1YkFXb0d3UTdvZjd0Mm5YeDdJcEcwWERwbmlJUG5xcndFNzdoRWpM?=
 =?utf-8?B?SjVaWHozd1AwLzhsWURwcnNxTisvakZsY3FHOVZJMGE2RXpMVTRXT1B1S2Ur?=
 =?utf-8?B?THgwd3cyOVBNRmNNUkJpU2ZRbVU4YVBVZTdDa3UvODczTEhySVlHY2tzT0pO?=
 =?utf-8?B?TTdQcHd1M0ZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkxQV3RiYSt0S0xlbElYdkd1ZFB1NGVXMkhFYWhCL1ZVb2FBSm1XMHpOZnBN?=
 =?utf-8?B?QkxURUxuY2N2elN1T3dNMEd6Yk5lSHY1b1FNZG9GdG53OGxoTDdqdUtWZDZh?=
 =?utf-8?B?VE1yMXdnR3c0dGtwazUyVFhrSXVsRll1a0N3UzVCK1ZSL25nMXlZRUtFQUFq?=
 =?utf-8?B?Yk94VTZpdWRNeElxK0o5b0FRU3J1Q0dPbmdCaHR1R2tQKzlIVm15bmpuanZ3?=
 =?utf-8?B?bnB2UGd4cEZoNlJTdWUzaUREUHVWRE1MM21PQzV5THh6UllwZ1J0d0tzOWFT?=
 =?utf-8?B?U2tyUDVFaXZNdTVZOWJOZ09MSHNMSmtPRTRVdVJMc0d2RGg3YzVqVjdEWE5P?=
 =?utf-8?B?SFFVVEFPckQvSHBnYm9FL3hvQTk5NTRxSzQyUGIyMHRSRXBMWXNKY2tWbmwx?=
 =?utf-8?B?RWpHUnhzbDVaenNBdEtiR2hDT0VXclF3akF1cExIUXdZZDVHb3QrZHQzZXRa?=
 =?utf-8?B?aVpXMThNMUZ4MTJjdWE1NE1Ob201Yy8xT1dGN2JyQ0Jla3psUVREblNHR3Yy?=
 =?utf-8?B?cEhIdXp2QVhaNWdoQVFjSzJYWGZ6NzdHVnhlY2lNMk1LRTFVZTc5a3VFekdl?=
 =?utf-8?B?MnlsNWF2dEFKVmpHaXZpZHNtbktvMFE1V0lrMWU3VmF5aVpyZDNueWZtdmtu?=
 =?utf-8?B?SEtpd2ZJQmIvZkk1aTgwWWlpTXdGS2J1RjgxRXozWGhhWnV3enNEdzZ4QXpB?=
 =?utf-8?B?MjBORS8vRGhyZklBRmRlbHZJZnhsamI5UE84dkJxaElXWElnZkFBVUxUU0Vq?=
 =?utf-8?B?Ukp5VHdjbnNhdmFXRjVNTWlBMUxGa0JzUG5ORmhZVGp3UnlTb0VSM21EazlZ?=
 =?utf-8?B?MTRGM0Foc2ZXbEF4UzBkSEhtTUg0d2hNa0tnUVBqZ0JaOE5Bb2FZSXJhKzI5?=
 =?utf-8?B?QTE1V3FWVXFnK1dQNm1ucUR1cHFQV3ArbWNBbjJLODJxa1VBbkZieTFBSkZV?=
 =?utf-8?B?c2lrNGk1dXRmRjNERFB1S2pqdjlNc0R1Y1ArL0VOWnYvemFWZ0Q1d255UUxy?=
 =?utf-8?B?Z0hDdGdRMUVUaDI2Rkc2SXYxZi95SnBrRjdjRGRQbDRrS2hMR0NCSlB2Q0Nw?=
 =?utf-8?B?THVoTEx2dWNTRXluNTRCc0I5N05DUTluNSs4aGE0aEc2b0ZiUmN0Ri9GeERT?=
 =?utf-8?B?aW1BTHNSNHk2QWtyaDJJeDB1WEx2MW1NR0ZCb1Bpa2cxYnFLZFIzWThPWHQz?=
 =?utf-8?B?d1BPaGNqbVdkeUVUQ1BNQ0NaWVJjZFRmU0xGbXBTN1Flcld0RHp6ZCtUeUha?=
 =?utf-8?B?Z0Q3djhaOHJJbnlMT2d6ZkorT0FreFU2WGZrMHUyUFBZcEZYRFJYcFZBL0pi?=
 =?utf-8?B?WUNaeW1lK2ZBL0NBNER0YnJlaUkyOFY2b0xDWU5pSmZPam5uREs0TUd4d1ZS?=
 =?utf-8?B?RWJ3Qk93YTJHeitNK1NVZTBEQTdZSDBOQnhlSUppZ2hZYTZydEJZZk1VVVNa?=
 =?utf-8?B?ZExaZHB4LzlmZTFJS0xZWUwyS0ZLN0srS3pnZXNtUy9HWDRxY1VibGFwTEFD?=
 =?utf-8?B?TU93ZWFtK0pGWmlRNmlxd2RKU0NrbW0xeWZLeUJNWlVxSWtyalAyTEF3eDVt?=
 =?utf-8?B?TnFIN2VQQW5FRzdVbWtVYTNWdlNBOTdLQ09WZGJnSmV5dlVzd1hBSDFSa211?=
 =?utf-8?B?Ulc2Z09DMHVqeFFQTVMxbm00Z2Jxa040ZUZ4TUpwK1N4RVZKTFJNL3UwMzUx?=
 =?utf-8?B?bXhwc2pxTnJRbGtTZEtMelZoaW1kRTJYV2VKNms1eDVqeWs2ZFNHaEpQVGZV?=
 =?utf-8?B?UkVicHRFMTZacDRUc2hXVG5acjl2SjZoTGMzSTVxLzFrYUVFYkZObjBNSVdP?=
 =?utf-8?B?bFovaDZjTHZDVEo3SFFNTlRwWmN5RVdhclFJQ3IvbHc1VFVuUStseWExcnN2?=
 =?utf-8?B?NEdpQW5NdzdkZmVnYW9WWmEzMGZEbVRmT2hhcTNoamIvdTNURjFNUFJNTnZ3?=
 =?utf-8?B?Z0VUUFV4NUhuUzlvRXBLZkZIcTlTdkVzUjJxSnprRmZTWmp3V0tra3h2N3ls?=
 =?utf-8?B?WTJxamRPTW1NMTJWSk9zdjFLY2RSVTQ1UWRzRVV2WU9wNW0vbTI4L0oxRVU2?=
 =?utf-8?B?blVzWG04Z2tGUjd0QllwOWJlamlYaU52MXdYT256SzNSVmZiSy92WHpwZGR6?=
 =?utf-8?Q?9bUv3PInyUpKBuNk+LzX+4mDy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC670EE04EE4254F86204021D6DFCF81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e67353-0501-4075-1fbf-08ddba3cb128
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 14:19:58.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EtjAJpmVcMqaDc1H1nbr9gK8YAugs3nQG/N+156+tOpgNbS+N1daBRqV/U2r706gWIev/R47/9V8KEdBfjJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDE0OjE2ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFRodSwgMjAyNS0wNy0wMyBhdCAwMTo1OCArMDIwMCwgRXJ3YW4gRHVmb3VyIHdyb3RlOg0K
PiA+IEltcGxlbWVudCBYRlJNIHBvbGljeSBvZmZsb2FkIGZ1bmN0aW9ucyBmb3IgYm9uZCBkZXZp
Y2UgaW4gYWN0aXZlLQ0KPiA+IGJhY2t1cCBtb2RlLg0KPiA+IMKgLSB4ZG9fZGV2X3BvbGljeV9h
ZGQgPSBib25kX2lwc2VjX2FkZF9zcA0KPiA+IMKgLSB4ZG9fZGV2X3BvbGljeV9kZWxldGUgPSBi
b25kX2lwc2VjX2RlbF9zcA0KPiA+IMKgXyB4ZG9fZGViX3BvbGljeV9mcmVlID0gYm9uZF9pcHNl
Y19mcmVlX3NwDQo+IFR5cG8gaGVyZSBeLiBTaG91bGQgYmUgImRldiIsIG5vdCAiZGViIi4NCk5p
dDogQWxzbywgdGhlcmUncyBhbiB1bmRlcnNjb3JlIGF0IHRoZSBiZWdpbm5pbmcgaW5zdGVhZCBv
ZiBhIGRhc2guDQpQbGVhc2UgYmUgY29uc2lzdGVudC4NCg0KQ29zbWluLg0K

