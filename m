Return-Path: <netdev+bounces-103229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F9F90735C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31D01F21FF0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0B145B3B;
	Thu, 13 Jun 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cV7UOVJ2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1D145336;
	Thu, 13 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284501; cv=fail; b=MhaAAOvyXQgdLLHrMTt9VlMqfp3qUyHEuj3oP+muipfY3Wn1aDQhkrbcDaRBHXqheLMkqNK8bf+8UoAaWuQ+CuOaldVQZn8u2vzAoThgvNCGRaT1ozD9nJ3G4rO8SZxliPjC5R0+W+OJ2SpzA189jduFMqlHQ5xXLmme38Ee8Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284501; c=relaxed/simple;
	bh=nZITn9yvFRXRvFfcQciwdKESMTEBrosvjcBdHXeV1wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3KPBXi5D6uDG0vmcevIVY1dvrUF4oRXq9XnPf5+6WfgaVe+pX1QMZTCoXNqdPAofDQr1i+5x9A4tdNiGNNIem+cFgLgFBB0kWjMKFNsYOBiiRnl7tyC/mHu9Ilr7oPYH/BfnyWUs94IYKSm2nJrdRAviL7i+e6I9pfecmxSc0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cV7UOVJ2; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukya9+xwmupqm1acs2PWUlY3deMmSmH2b0u2kFGqNyv7kKvwwHbmx063TAyY41rtscBjGSkrbE/CvjJP6BuzG44TQsiRQ7mG51ymtMWXCSX11P+9b4chl3xKhYrM8oZrsqT6S3M+XWeCKZFzxKwyKWaEFQmst7dVVAMCCzAdhN7aFZ/Fxgaa8d70hpBjFfqaThYB8cmsdtg0R9kqoJzlHrNOihoN074Srgid3rbC1tDa4ry0758xAsUN+EgwkS1YmTvKf67cOxNV4gYEESl3k8N+xCI+XWPxPRMoUSmJ7uy0XdRZjsKSuFfu1RK2RD6IY4xsFcMURAliyjZlY+xUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZITn9yvFRXRvFfcQciwdKESMTEBrosvjcBdHXeV1wY=;
 b=fyp/ZRzZL7gD0+BCohpURFBfr4nYijCachnIsW0dthW6YMWWBJsxhqZdzU/+qzvo/qo5RONYprzLUxSW4rpFI7y8cP81Hx2gz6TbnM6GAFFENZPu5nO/jlcVwSu/rM0lQn/XHWIIoxTSjnJwiFJWiKd3Sn4FozabcQzAMKhPbGoWLLV5Hh4IN4jxvAaVsaXe9KFUMah6mOADdjRUmbd9Jg/gP4HF72g6phRheH69BVx/yyBEG+YZY4dQiD6qkfx7H0oSdxp8JHd1JuRQWnftcSbFc/ZhHDZsWjokXP5xG7e0LOI3sUHJ8aU41JwsHoRGGtWIPhqfN6o7Wr6Be/p0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZITn9yvFRXRvFfcQciwdKESMTEBrosvjcBdHXeV1wY=;
 b=cV7UOVJ2CWJ+bwEoAC51qqqsNWmt5RYuBQZ8SrMN5EXhhKRCa2xPusYWCRT59/pwQIWrbdBbpFgYJkuY3NJBEyx3r/wXI9BCgJfBWC9TIc+Eul5dtRbG3Rx86PArpDJEazu2nqPVBYE4IG6aM01JrNzykpg9Pa7nYrfL/I/BF4ntFWW3T5wgWRcu4BmYj6mMHASb0RpBHNTAsGUZIw6TOMwiEGW6pwWX1UpZ8+R3gBEdLu3qzVm8Qgn9PcYuPrMpdcOZYwNe+HytTXTO72SaLE59RI2FDUBMHb4YhPyWLbWXf8w1mlhA4RlRwU5lx0gfsS73UY5aHiucgDYYlgM4Jg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 13:14:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 13:14:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "yuehaibing@huawei.com"
	<yuehaibing@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"p-varis@ti.com" <p-varis@ti.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "srk@ti.com" <srk@ti.com>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Thread-Topic: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Thread-Index:
 AQHavZEkKELFKPApXESUbFzBrG7o2rEdeQGAgAE1NoCAABVZAIAAHHWAgAA7PICAAUy6AIAAF4+AgAAEMACApSh9AA==
Date: Thu, 13 Jun 2024 13:14:53 +0000
Message-ID: <24e6e870cbf927a65a304e780a4ab64b0cb683c2.camel@siemens.com>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
	 <Zd3YHQRMnv-ZvSWs@nanopsycho> <7d1496da-100a-4336-b744-33e843eba930@ti.com>
	 <Zd7taFB2nEvtZh8E@nanopsycho> <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
	 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
	 <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
	 <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
	 <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
In-Reply-To: <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7731:EE_
x-ms-office365-filtering-correlation-id: bce146c1-a95a-4468-f86c-08dc8baad06e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0RpdEJZdTlWcTgzbVJnaVI4NDQya2htcVlaQTNXYVhoejE2MnJBVmxxV2hU?=
 =?utf-8?B?dW5XVUZKRUhSbVkzWTNReFk4YXlva0t0U0VDT0hYRTFadjYwdFJPUmcza0dx?=
 =?utf-8?B?Sk5IaElZQmFUU3ZYNHhnSE1DRFJpbUdKN0NwNW8wc2VENHZBRlphekpoNitJ?=
 =?utf-8?B?U3ZQZCtvSi9jWVhHNjZUZmdEUzZvcUNuZi81KzhiSjUxQjFxWWNtc2k4Rm9k?=
 =?utf-8?B?QUYyNzZyQ3MrSFVCUVVuUGx3RFhYUnZaLzkzeVU2aUdLRXVxM28vQmJhb2V4?=
 =?utf-8?B?OXNsRzBXRE1xUEZwc0ZPNmczQitwWWVhTXIvc1RHcXNSdDljem8zK2hwOVdF?=
 =?utf-8?B?TFQ1OEV3UWhJUUE1dnBuckNCZVI0NUQ3VnNsUWpvMzlLRVFPSEY5SWJuZnBV?=
 =?utf-8?B?QTZ5NmZBK2NUN2RNR3ZHai9LbW5Ha2dFUlpBS3VXcjNWbUM5eDhTQzd2RGRw?=
 =?utf-8?B?cTIyaUFOYjVHdGRtaWhiMmdoQUw5RDVZaXREeWM4c212YzJ2dk9aeGhZTGRQ?=
 =?utf-8?B?a2hYNjJicWpKR2ZudGd1T050ZnJuSnU2U1ZCaHlIRnhrZUlRYVp1ekE2ZVRx?=
 =?utf-8?B?eVBta1ROSEZjRFd0NS93bkJ6UFZWck1jVkg4RFlTMTEvZERZMFVHa29sVks0?=
 =?utf-8?B?a1B6blZYenlaalRtT0ZGU1lhdmw0NnA4ZUpTZzhWVHVURk1TcGs4c2M5WU9M?=
 =?utf-8?B?SjdqUEZQcHJTM0hMQ0N6dGJEckl4QmdtWTRNN21UcFpZVGtTVmI5czJLVG8r?=
 =?utf-8?B?aXpMTWlRbGtsRU1mWm9KdGlUQ2NWZkMrWWVzR3Z1S25TeEZJTkhoV2sxWURF?=
 =?utf-8?B?T1FNR2tVamJVVzRmK2R5bFVlbkNGeStwZjdMV1dmOStSQWNSRG8rNnRIelFy?=
 =?utf-8?B?THNPT0ZrSS8wZkpZVmExMUtKS2FLS2lZT1lVNjgzOGdIeFhHeGlLYmkxenor?=
 =?utf-8?B?Nm5HSjl6SVFhY3BYWXIvdWZueUhwaDR1WStwWm9SODU1TUtKNXo3RW9vazhn?=
 =?utf-8?B?aXZQQjkxa2RGMDBEM3dxamtOaXNzWDBVV2VrZ2k5UjZJK3RkaHVpaTZHZHVS?=
 =?utf-8?B?anZZbjZNTkxUOWxzK05BNjQxNm42RGYrd1hFTnJtUWd2bFJlY1VFemtVTFlS?=
 =?utf-8?B?dDdkazJ1UElSZnFXeGk0TVUrNkE4eU1iMmNuS09kdTIwcVdlK2hrYm5vemJx?=
 =?utf-8?B?Smkrd2RxRFRvenRXUWdWYkEzODhURks4Rk5kTFhXM1FXc1kwNkhORG1XTU1C?=
 =?utf-8?B?VmFxR2xuc0pQVUFhamlPaVRIejJqeVhNclZHQitkaVBYazcwb3VSNFk2dmts?=
 =?utf-8?B?ODVCcWpWeStmdStDN285QkxQanBsUnNaVFNGanFoMlFCWlJPWlQ4QU8xS1g0?=
 =?utf-8?B?SEJqb3JpTlRWNUsyaEZwS1pENnZSeFYrcFFnWHRtZVZGL0h0M1dHc1g2R3dB?=
 =?utf-8?B?cjQxZW1JVUYrQitiSVZ5cFQybUttb2JtMWF2UjF2M0l0Lzk5Z0k4cFFqTEtS?=
 =?utf-8?B?aFZOVjZ3VDZ2ZFVLUzBXZ0ZkaFM1NE1HOXczSGMzRUdzMEU3TG10bGEzS1Zn?=
 =?utf-8?B?aDcvY09NVU1xZUxNV04yWkI2eXZJd3ZudDhlb2RJTjhyMFdyVUMzUTFDdVpR?=
 =?utf-8?B?a1FjTnorM2FaaVlrOFVpM1Bzb2RrbVJlblZsNGVqMnBiUnp0cXRpSzFzS1JB?=
 =?utf-8?B?dG5VVlptZW14eUl1TENPajVYQTAydHVhMkpIMWhkaVhybGYwUlJlZ2NVVVpk?=
 =?utf-8?Q?A+p69DQjB7XxJ4AePEBpRMnl9OKaGPihJonPbG+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODdCSlJBcThEaFBTeGkwT0R0amxkN3djOU9OcFFwUXZJQmRPZ2hFVWxSR0RC?=
 =?utf-8?B?YmtuNWMyNU4xYjBjWmNOVGNIbjMwTWV1a1h1MU8rS2lzT090YWdUWmxtUzhJ?=
 =?utf-8?B?a2xTYlQyeFAvSGlBUVpZcUxzZmxwNW1sdmVKdUFHUmcwYjJ2TUxlVE1GSjZh?=
 =?utf-8?B?WkpXVVlSVTMvWUVlek1xWjhLbU5oVnpkVFpycXdJOFczdG5IOWQ1OHFaTnRU?=
 =?utf-8?B?K0NDajNFeHJ0bFp0U0dPR2tMcEYybWFZclAzenpnUkhLTkMrOU42TThCY0xS?=
 =?utf-8?B?eE50Wk8yYTZNMWRDK0JtcXVaN0lvZm5iR2pjZGtvRjlyTDRIbm9BNHRLd2gr?=
 =?utf-8?B?SHNnR1Z2aFF4bDF6QlQ1TnN2ajQwTCtjRUVwdmcxM29ubGowWVZtWGFxUlRV?=
 =?utf-8?B?QVhyUjhtWFN4dkp4UTk1MWRua0lxNE5keG1XUnZFSmRPQ2VOc2Zyb2d0UXRZ?=
 =?utf-8?B?NW12UmFRbW9IUW5ieXUxa2hYMHh5UmhqSkppVVVxeS9NMXFyV1VxdEFUYjIy?=
 =?utf-8?B?NXhJWTlaWEdXcXJIY3c1YWNoOHZLbDRycVdZMjBqVFpzV2cxSGthalpIRDIw?=
 =?utf-8?B?SWt1amhHRmVST05aUTRiWlg2enNQK3MwZW5KZ3hML1FERnovOWdKK1BvcUZy?=
 =?utf-8?B?RnYvV3dFSWl5OEUvU0NJZldmTzc5a2hTenlSc29JRkllL0xwNmhqL0xScDZC?=
 =?utf-8?B?RDFOYnhtUG82L1RYQ25lQlprSGljeERlSTZ5TXRWQ0YrM2ZpSytyV3RnT212?=
 =?utf-8?B?ZmxvbXJab3hueDNwcVZIS2h3TG05RkxFQVY5TE5NZkxsUDM2dFZ5YWhQVXY2?=
 =?utf-8?B?QWZIUUw5QXRqZ2M1VUt2a3lMNFVwcFlGU3E2U2VqRGVNdnp2SVo3bnY1Y3NQ?=
 =?utf-8?B?ZTMwaDUyVVpRWmJmMUErUzdWQXdKeGZGRFdsN0N4cXRQSnpPeStyK28vSFRy?=
 =?utf-8?B?WXEzTUNCeW5DZjNKbi9RWUEreDJGNUFDSHBkekgyZ2JIcThKSENtam5VRkRw?=
 =?utf-8?B?K3ZUM05Hbzc3YTRDaTZubnNWdjlGaFNQR2RHMDJoQkI2SDltQXNRZWxHbVdV?=
 =?utf-8?B?UmdxWmFyUXdySVFuZDRnZExaeFlLbGdCM3VZSHVNQ3hybWZwRysvMEcrRWV2?=
 =?utf-8?B?dFphRzVITUc2OTcrbFc2RWZzdTFRWWZiaXJCQXBLdk8wTXEwNVB6T21GZWp6?=
 =?utf-8?B?cm1paWdMMVRxN3pBR0R2bmIwMXBnNGlUT1Z1ZFBGSHJHZUNTbGtZdXh3MHlS?=
 =?utf-8?B?QkN2UkFVY3ZRNVh1NTdUTHduNURmRFBnN2tQYmhBdnpBeXpXUFY0ZHEyeG5K?=
 =?utf-8?B?WTdLOGQ0N3ZxRHZnaFg0VXdvWUVDZE1qN3psZWF1bEVkVlJXbXQ2TDB5QlI0?=
 =?utf-8?B?R1VJZVlERWRlOFhsVVdpZzVMQ1hXaXpCK0pSNER4UmFoQTJPS1JnWnBJUkpK?=
 =?utf-8?B?MnQyRFVvSDQyTjZVaE1OVWl6V1VVWG9rWmxjLzBOWjJoOHo1VkJZVWxVTVhz?=
 =?utf-8?B?RlRTUWV5MEdibzhjcDJPRzRNelorV1ZiQldHdmg5eWNsNzJXQy9UR2hML05P?=
 =?utf-8?B?V3FhY3pQb21vd1dteGxvWG9ESjBZTGxUMUFwQmdqNzFXN3l3eWJxVmJyS0NY?=
 =?utf-8?B?U0dqNGthWmp6QUxwL0J1RDJHNWIyeUg2cngzOE5Kc2h4TXFjbFAybTV3SFFN?=
 =?utf-8?B?bUN2TVZkRFZKT09nOUpkVk9LMnl2dVRTTjN4SGphREpXaWhzM3RIb2lCMkJz?=
 =?utf-8?B?ZmVmQ0piZTBqZG1PRTl1VWRJaU90aEdLTGJoc1RWNVRLTy9pS2dOVFFBa1lw?=
 =?utf-8?B?ZWk0eGE2MzBmWlBIcTZvTGNYNExPVDdPanNTcU1RdTFPK01tc2lQeXFWQXRM?=
 =?utf-8?B?TzZoOWdHK1BsSWdKa1h2dHhqUE1tQW02Rm1OOHdjQ2d6ZUtsK3lMODVvcjRV?=
 =?utf-8?B?Z0dUM3gxdU1FNmNSUFNRMWxxcCt6aTl6QU5TTUgwYnJDYWxtMzhQZUJSdFhh?=
 =?utf-8?B?L2RjSmZTZ0hYMThNUy9TZTExU05Ed2RLWG1vRC9TRUM4RVBiamxyTmVQeFdW?=
 =?utf-8?B?b3EwZHMzK3dVUDhyVWtRSVBLT056dlIvMUV5V2VVM0JBMWlFUVd5MlAzVTNJ?=
 =?utf-8?B?VmV0QlpiSGdnVWw5bWhRN0NEZFVZY0FUSWxzV2dVbWpWN041WXRXZFduakFo?=
 =?utf-8?Q?+r41zgvmMTkOWrMXbhiaVs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D13D3AD4F8D240A4A8C7931133ECC2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bce146c1-a95a-4468-f86c-08dc8baad06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 13:14:53.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHXCJgDeP5CPSH5djpUTYRX1oy0yEOFCRuW5UJV7hS+fpYJ0cYfg6wbVNykR0CtWYfljkfn/bVPbslbrM6kO3VyWl3H9866FCrqnQq8rXkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7731

SGVsbG8gU2lkZGhhcnRoLA0KDQpPbiBUaHUsIDIwMjQtMDItMjkgYXQgMTY6MzcgKzA1MzAsIFNp
ZGRoYXJ0aCBWYWRhcGFsbGkgd3JvdGU6DQo+ID4gPiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biBpczoNCj4gPiA+IA0KPiA+ID4gwqAJLyogQ29udHJvbCByZWdpc3RlciAqLw0KPiA+ID4gwqAJ
d3JpdGVsKEFNNjVfQ1BTV19DVExfUDBfRU5BQkxFIHwgQU02NV9DUFNXX0NUTF9QMF9UWF9DUkNf
UkVNT1ZFIHwNCj4gPiA+IMKgCcKgwqDCoMKgwqDCoCBBTTY1X0NQU1dfQ1RMX1ZMQU5fQVdBUkUg
fCBBTTY1X0NQU1dfQ1RMX1AwX1JYX1BBRCwNCj4gPiA+IMKgCcKgwqDCoMKgwqDCoCBjb21tb24t
PmNwc3dfYmFzZSArIEFNNjVfQ1BTV19SRUdfQ1RMKTsNCj4gPiA+IA0KPiA+ID4gd2hpY2ggc2V0
cyB0aGUgIkFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRSIgYml0IGJ5IGRlZmF1bHQuDQoNCi4uLg0K
DQo+IGZ1bmN0aW9uYWxpdHkuIENQU1dfVkxBTl9BV0FSRSBjb3JyZXNwb25kaW5nIHRvIHRoZQ0K
PiBBTTY1X0NQU1dfQ1RMX1ZMQU5fQVdBUkUgYml0IGVuYWJsZXMgZnVydGhlciBwYWNrZXQgcHJv
Y2Vzc2luZzoNCj4gVkxBTiB0YWcgYWRkaXRpb24vcmVtb3ZhbC9yZXBsYWNlbWVudA0KPiB3aGlj
aCBpcyBhIGxheWVyIG9uIHRvcCBvZiB0aGUgU29mdHdhcmUgZ2VuZXJhdGVkIHBhY2tldHMgRWdy
ZXNzaW5nIG91dA0KPiBvZiB0aGUgRXRoZXJuZXQgU3dpdGNoIHBvcnRzLCBvciBGb3J3YXJkZWQg
cGFja2V0cyBFZ3Jlc3Npbmcgb3V0IG9mIHRoZQ0KPiBFdGhlcm5ldCBTd2l0Y2ggcG9ydHMuIElm
IHRoZSBhZm9yZW1lbnRpb25lZCBtb2RpZmljYXRpb24gaXMgaGFuZGxlZCBpbg0KPiBTb2Z0d2Fy
ZSBmb3IgZXhhbXBsZSBhbmQgd2UgZG9uJ3Qgd2FudCBwYWNrZXRzIGZyb20gU29mdHdhcmUgb3Ig
b24gdGhlDQo+IEZvcndhcmRpbmcgcGF0aCB0byBiZSBtb2RpZmllZCwgdGhlbiB0dXJuaW5nIG9m
ZiB0aGUgQ1BTV19WTEFOX0FXQVJFDQo+IG1vZGUgaXMgbmVjZXNzYXJ5Lg0KDQpJIHRoaW5rIHRo
ZSBxdWVzdGlvbiBtYW55IGhhZCBpbiBtaW5kIGFuZCB3aGljaCBpcyBJIGJlbGlldmUgc3RpbGwN
CnJlbWFpbnMgdW5jbGVhciwgd2hhdCBleGFjdGx5IEFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRSBh
c3NlcnRlZCBieQ0KZGVmYXVsdCBpcyBjdXJyZW50bHkgdXNlZCBmb3I/DQoNCklzIGl0IE5FVElG
X0ZfSFdfVkxBTl9DVEFHX0ZJTFRFUiBvciBpbiBvdGhlciB3b3Jkcw0KDQpzdGF0aWMgY29uc3Qg
c3RydWN0IG5ldF9kZXZpY2Vfb3BzIGFtNjVfY3Bzd19udXNzX25ldGRldl9vcHMgPSB7DQouLi4N
CgkubmRvX3ZsYW5fcnhfYWRkX3ZpZAk9IGFtNjVfY3Bzd19udXNzX25kb19zbGF2ZV9hZGRfdmlk
LA0KCS5uZG9fdmxhbl9yeF9raWxsX3ZpZAk9IGFtNjVfY3Bzd19udXNzX25kb19zbGF2ZV9raWxs
X3ZpZCwNCj8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K

