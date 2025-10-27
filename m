Return-Path: <netdev+bounces-233130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817A4C0CBC1
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B523A19BB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751F2E7631;
	Mon, 27 Oct 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fr9eoA6w"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291D1C84B9;
	Mon, 27 Oct 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558118; cv=fail; b=VuGA/MAZlfSExV9N3QpMcsS/KR2krN8P0TdRmkjzSyifKetjkr7eMa/i1sbP7zBkYHAxLCHpMLrrf4GHVsbh0uhbE49nVNTVbZDVa6OenV7Q2SPwtV7kjPTuTYjD0FpBBqYyPFtmi/Wgs6YMl3vgIDo74156gEd0p7M3Bu4UIc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558118; c=relaxed/simple;
	bh=+e5tF9uPK7l43v8vsJqnBV/DK1a9AE4Xxr9170o74s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eb//jFocc7OfLmnq3oNzYh6JZ6UUhkZ7DNueXRUsMr5EZFLXWcGiljJkodF3vqtmqWfBMJkTGwNRpzjukxDeSE8zm+CMBPExrNsimcb+Xs6c/K3PB21yY31TTpXcGV2j6jl5ZBG+FbVA6L5e/dWV+O0o9cRwEfV5EOqpTXnUQvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fr9eoA6w; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9tguiuDfTe5KniqvT1bYjjrHqlOQcU6WYXHbfaRhHsryMCcmiuds/RnjMR+s5Bpg260JRF3dZ5IQVQ6qTsT1iHDGtINEEb5GXkx7knDSijnD1XEA2vrg7fg/ite9u+fKM64e8jQP2/9vCol3vb5WM5210JoF+0la2mlrjryKR8VxCdkKLAYYCnqF0oLf3h7VP/gDTaHvpnX8H/zmAgbDJUc5da0zRYMSQSU8JIdCWqKHhGe8zXubaE9H2TtJU9II4HbJIVoJUhcKr4hfEM3ySY+WCyM6uHV1pv1D6MrDM1N9FPV2KsqRmHkAlx1iddR7sQqWOSGR1tXFExezRNdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e5tF9uPK7l43v8vsJqnBV/DK1a9AE4Xxr9170o74s0=;
 b=ag/ZNmSK+jRju5w4AwRSBqhGHZ7qehQbFXB+S0R1r2EXPqL1c0llxm2iT7tQavaaUf9j3gZKzIptWSwCfBuKKhaqMBy0aLg2mP7KHz4qNRUw8Bg49imwL8sis6OIjL2nUWqbur3mcr+LdvRSSNxHK23gUVppWBM/f9xDYpfjjvHcjAQv4RaoVGCuDDtTTrQrNIKKUvql/nSj5LcA13emqUWICGOa90KcZ+9vC+zLvr2cYgLO3RVCq7zBFrMK/+wdJNsxsfPNJD/5J0j9OieqiPqMU8RnJ+iKjdLYjKbhdC4OqW8b4pgwrhEqFZnZ6h3j3djyxTV6HzwLPfoYbOGBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e5tF9uPK7l43v8vsJqnBV/DK1a9AE4Xxr9170o74s0=;
 b=Fr9eoA6wOoVmn2Gx9jSWeT0WtbK5ZDb6YJQWD8puMkzM2jBShck7LsJ0+Fmu7LFoKLG71QHd0LO8KLsa315TyZb7Om7OgmaxQoxtm0ufNKXo8/L2xPPrFBAcVK8dT56qiCVM2TfPhdr5ZBh1zvZplFcmMFwEHwvAFm0hNWj3FX7qdfeeIzWOY2HESZaNDFEwgM7W3nmSEJmJQBTOOLxlJ1Y8Mz0UIi867V8D1YtbAEf0YkdBLX09NngriVaEQ2f9L34QwBbqCMt6a3S45ZekxxIcr1WTVyEmQjAhOBeGqb9rsY0LH502nwoMZVUOUCEQLbn5Ts4gsGVspCE3//9VMg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VE1PR10MB3901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 09:41:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 09:41:52 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 08/12] dt-bindings: net: dsa: lantiq,gswip:
 add MaxLinear RMII refclk output property
Thread-Topic: [PATCH net-next v3 08/12] dt-bindings: net: dsa: lantiq,gswip:
 add MaxLinear RMII refclk output property
Thread-Index: AQHcRtLaR5WIZze6aEypeU4Nw2MIRLTVvjAA
Date: Mon, 27 Oct 2025 09:41:52 +0000
Message-ID: <54aafa653367790d4db14b097c1f87f542deeeea.camel@siemens.com>
References: <cover.1761521845.git.daniel@makrotopia.org>
	 <3900266acab61197fd27359439eb8d4cf25b2c0e.1761521845.git.daniel@makrotopia.org>
In-Reply-To:
 <3900266acab61197fd27359439eb8d4cf25b2c0e.1761521845.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VE1PR10MB3901:EE_
x-ms-office365-filtering-correlation-id: 70e855d4-a7f4-412c-7289-08de153d0f46
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWhOTmVra0JKVzNwaGtqcndkQktQL1JSeUJKMUczbjJ1RFdHcnMxeUNFck5R?=
 =?utf-8?B?cHlZSHVxa0NXZ2R0dWxQc3FIaGtGakt6bXRPV3pYK3R1aXVjYlpSTW83NTVN?=
 =?utf-8?B?UFBDemU3Q2tMbDEvSGI1YWpsK0ZWd05va0lvWUtUazFuODNqVWtaZWNESXE3?=
 =?utf-8?B?WHVsNDViNFJScmpvcGFCMDZxaXZzUHV0Tll2eEkwNGFNYTl3ZUdrOStqVGNy?=
 =?utf-8?B?TmNFeExUN2RyWW1jU0UxcWRtMnA0K0NPT2tuSXBKNU1vZU5rdHdGcUtUS2x3?=
 =?utf-8?B?anBMWGkxVEtxeXlNYWlCcW5XOUN0WitsR2twM0hmbDVvT0V1cGdzMnBDd3cy?=
 =?utf-8?B?N2doWjNWakxmajVNNDd5QTJBWXRlZEdXR3hBcXBkOHRQRHVwU3pZSjNIeXd2?=
 =?utf-8?B?VFNUSThsNjVFc1NNZDlLNy84UTRURjgrYTJ2VUl4UUlUVG1VRmRlRmtWUW9y?=
 =?utf-8?B?Vzg1SkRuWHJUL3ZNZGhBNTRyVnhTZ1UvMjNWRHkyR1dYK0xQaHVjLzFHWmlD?=
 =?utf-8?B?dUR4NzJqME1CZ015Nm5kNG8wVnIzSzJXZG5SSjlzRm1LMHdNQ1dxVlZWSWJY?=
 =?utf-8?B?TXF1SEJaVi9PQVNGYzVuVVdkTVA5U2tOT1JTRThZVStHck5rQTRSTml0TDk0?=
 =?utf-8?B?dE5rSy9ZNWswaFQ1c21sYWQvT051cWpQZCtFT3FKVW9Ia1FTRURBVmtKQzhm?=
 =?utf-8?B?Y0lna0pQTzJXc0s0a01wdWdYenNuUEdJR3N2L3drcFJWc0lNbVFySi81VUxB?=
 =?utf-8?B?bExTVWZyMFlwSXd2WFo4b3g0bmVpWWw4SjdrS25jbWtYZldpY2I1a2MvYzdu?=
 =?utf-8?B?aW9qNFB3bzRQOWFCY0Fyb2RXY1hQM2F6Z2kycE5tNVJHOHlOR0pPcENFaDdU?=
 =?utf-8?B?MUNCZkErenBLQWZzVGxpaW1kS0NQdXNoSnRDRGZRdkJJS245b0c1c21XL3Ew?=
 =?utf-8?B?dWVPZFZIVzM4SXlBRjJZZE8zNDhiMHlYTUo1VXJrc281ZWdaenBNcmlmSDVZ?=
 =?utf-8?B?S2tFVG9NMzFnTFpqb2QwY1BGNVFiRVNSUVc2UTZ5N0R3YWU5U09WdTlIdzJ1?=
 =?utf-8?B?UDZ0d202SXdOdnVGQ0QvM2lZUDhMUTdQVmFOQ0NCMnhjR3FsZ0FHMCsvcGcv?=
 =?utf-8?B?Q0dYbGFlYlcvUU5ac2N5bDRzcWpZYXl5RnlaUytFWTF2Mm5BVndHNVpYY2pH?=
 =?utf-8?B?T1RxckhkOUdqSWNtMzNCL1UraG9OUDI2RTBkcEFXcmR6aE95d0dSWjRldXV3?=
 =?utf-8?B?REMwaDB3eFBVNkl3bUtNRTNaS25nSVNtazlQYzVsSmM0VTFIWHN4MWNpVG5o?=
 =?utf-8?B?WnpGcUZoa1dtZ1VlOHV6Q2tpNXNmdFZwQjJuWGxnVmxDeHZ3UlZvY0hPZk53?=
 =?utf-8?B?MllWRDl3M01ZKzl0clhPRkNjSXJrWGI1QTNUQjN6RlF0dC9VQ2J3eU9ScmMw?=
 =?utf-8?B?Wno4amh0UkJYVHZ6b1VLNUpweitoSFdYaC9Gb242M21XWlBiQVVCQlBsLzlY?=
 =?utf-8?B?OVVqNElnMHlUMnlXNFVvL2d2YTh1bElzYko0YzZvSW8yTWNRc2g0NTZERlZ0?=
 =?utf-8?B?dW0xMHVlUkYzQjBRSnl0ejlLbWc5b3RwQklIZnFBOCtPYWJINW1sdi90NUlK?=
 =?utf-8?B?dlhIWk42NXdHUzhKZEptT2pvK3QwNTgxN1NmNnVKTXltRmg0eklIcE1zK01r?=
 =?utf-8?B?SGNIb2EydUhjeHZBZzZrTS8xd0xaYUFmQWFEdVZIRnVkZWNRbzRXRDM5RDFt?=
 =?utf-8?B?TUdrOC9yVmQ2UkVMMnU5d09nbHl3cnlZMHQvZzdjdzdHVlRwTzJxUUhUVTJp?=
 =?utf-8?B?NUdlekdCSkZoNVUvUlNiM0FKbzQxaXo5bWtkRnlKOFVPT1c0TWhaSXUzRVQr?=
 =?utf-8?B?MVVCL041R2g0eEhQNWJUNGtXRGJMbHBHZUpkZlVqLzZJV3M0Qy9RVS9RdmNT?=
 =?utf-8?B?VU1taTJCMk0vQ3dFbEVxWkM5VVZ0US9ZR0Z6dk0xQ25LaHZSSDQ1Vy81b3o0?=
 =?utf-8?B?aU9IZTNYR2JXNG1MSnEzWXFzT3dzMEZVbHVyUm1Vbm5RV1h1d1c1U0NwMW9W?=
 =?utf-8?Q?KDy35u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUJMNXJXbmR2b0RRN0dvemFsYWpsUTNDK2FpV0JKMGdSUEdmY2hkZzAxNzlO?=
 =?utf-8?B?ZkVlT2ZzeEd5Vjh3U3k2cU0rY0FFYkpzZUx3RHgvb1VCbHdkWFFXb1lIVXUz?=
 =?utf-8?B?K0xVa1FLUHI3a1R5ZlpmMXoxRmJlRnJoMCt4SWtVaUZFNnNRMi9qZzBnVlJV?=
 =?utf-8?B?dXVNdnM1ck1wM1VHVjBNNXZObFBybGZ4OTJkcG5tQlN6Q3Yxd0NSR216T0ly?=
 =?utf-8?B?NkxmMUYwbFh0WDNkV0ZaWXpXbERDN2xRWFpvM2w4d0xCUGxwMDA5NFlzd3px?=
 =?utf-8?B?SjU1dkllc25GTTYvR3FIQ3hmYTBxL1pXNFZReEpsRGN0R2JzZDFBU0wraTJ0?=
 =?utf-8?B?T3laUjF2ek1TclFXbE1rZkorK2JVeE1EclcyQURNOEtieFVwMTNHeGZTbDdR?=
 =?utf-8?B?c3NQU0JQZU9RTDhYcW0yS2xSMm8xQ3pJRlYwODVDM09UeXJNQlRNOEx3WENj?=
 =?utf-8?B?RnBFeUF3TDQ0TFYray9GSU5jOGpOTSszNGtIOE5SSFB2MngwMTVUT1ZnNnBv?=
 =?utf-8?B?Sk9sSEhoaUdQeXB3S25UOVI3VEk0RVppWnMvWVBGVjVEelgvRVNoUGNJY1RF?=
 =?utf-8?B?TzlCZEVBOExocjZ4MW0xMTR6OTZyTm9vUmhtOVB3alA0cThtUjBQVTF3ZWg0?=
 =?utf-8?B?QWp4OUxJWEM5SnlHVjBKUFpabUFyYUFQaFBZZGYxZmwyUWJMT1pZTFpOWTNY?=
 =?utf-8?B?L0tzZkxrb21BQlZiejBLZ0d6aElwRUthYWF2WlcyUjh4NHExbUM0L0NJcWp5?=
 =?utf-8?B?SlVuQ2dmMDR3YkRWM3BRaFJHNGx4UGp0ZTRsck15aFFFMDE1SU1LaW9Raklx?=
 =?utf-8?B?bWx5N3gzSHUrTDhhc2g3bU1nOEZMR3l4Q1B2eXlDd2JnaUE1TUpja0t5SjJN?=
 =?utf-8?B?Y2YwejVHUXdEYTlEb21TV1VIbktWemNydmJvTnE0bHh6ZGw5Z1IySSsyY1pN?=
 =?utf-8?B?ZUl4RWNKdDAzWWJ0dEYvdzZxNE55bklkUnpRUU1aaC8vamZjaFZpU21qOExh?=
 =?utf-8?B?RjRrV21hRGovdlg1Q2RSVjdzaUNQVkRnZ3lDZUhXb0NlL0xhbVR5WFN4U1JW?=
 =?utf-8?B?dFFPUkMzSUpscWlZRzNROXNWZzVyUzhGMTE4ZHR1dGtyTzh5eVNWTVhhWWU0?=
 =?utf-8?B?enFkdVhKSWdoSlQ4cUVpejFZRTNRbm5lWnZDaE9zZHoyTGJDZ1BvR0JoaWlw?=
 =?utf-8?B?SGNiK2wwTmlDaW80UzlOVS9zWVJYajNFK3J6Z1RvQ0hOZHF5SGwzczY5cUtt?=
 =?utf-8?B?dGhROEVka1BYRlFUZDlqMlM3NmZVKzByQjJGNm9lT01MbUs4eGlkbFdXcE1Y?=
 =?utf-8?B?WlVyZWJJeTZzQllLV25xUEtyWHlaN3VFZFJ5ZGU3YUhVMjhjQUVLS2ZyUlJz?=
 =?utf-8?B?ZEFwYkNhTjVsVVlXWHBpSlZONis3TUVpaS9CK2R6Q3F5VTlicjR6dHBpdFJY?=
 =?utf-8?B?Q3Qrd2g0WC9Hak1RNkVSUDNRY1U5cktSaEdyZGdtSEJlcVZod3JWODIvdG1E?=
 =?utf-8?B?bWxUZVdCYlpHMEdQbVUwZ1AxR2J0VXJZVkhCcGhzTXJ4RmRzMXBYU0NiM2xF?=
 =?utf-8?B?QUF3ZUh1N0w5L0dyQ3Zuak4vNXZyLzM1cEVjVHNrNTdYTlhQYndLS2JqNmtX?=
 =?utf-8?B?Rnd3L3NoZE9EUkFCeFM3VExNNHg0M1hEQ0lZdFZwbGFmT0FXd2ZobkFVakQr?=
 =?utf-8?B?dGVpSm10ZzVuMy9iK3B5QzNvTVF3eW1pQWlhYldJU2JjMnkzdi9UdFJtYjNz?=
 =?utf-8?B?YysxampxOVcwQ0YzNFRGWEJQREszdWMwQjNIQ3VoalhueHQyRlJ5WGdoSUZ2?=
 =?utf-8?B?R0U1eGVxeVUyOHpVL2JFbmUvOG9tdW9PajhZY3JNU2lWOEdCZS8vTFhQYldZ?=
 =?utf-8?B?QU90TzlkSUZVeDg0VWNoVHV4OVlEN25Zc2NuRVcyRDJIVEJ5b1ZTZXZGc3hl?=
 =?utf-8?B?Um1yQkh4QTA3dGdoRGFVY3IyR2QxOHdtU0dvTmZhbm9hLzNlNTZlWldSbWQ1?=
 =?utf-8?B?RUhIWElFdlNFaGZ5TllpMk9YQXVUTEFjQ3lnU2VyVzVGRGYyWEVUelkzS2Zn?=
 =?utf-8?B?VHhzalI2a0YvYWJkTkxZeS82U0RpbUJ6NElOQkhsZTBsamd0QVdtOUNMeGJJ?=
 =?utf-8?B?ZWNLNEllcWNDNDRkQjB4blN5OFU4TUl0U0VRMVFIOUxJMVdDSXNNREJNWnNt?=
 =?utf-8?Q?gpMl3UdWbw1zeWOspXCdr6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A342C27F7DE5342BAE75B64F7F4CF45@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e855d4-a7f4-412c-7289-08de153d0f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 09:41:52.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+thQhJE+6vdgtTEFhgmGLHHEeEgt7lEkdjcc4VRcaBPOny9p9nSjWCzM5RwAOzmBUnw4bJsrZj2wWlyGjBb7aOPogsGD899GprT8B4CCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3901

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjUtMTAtMjYgYXQgMjM6NDcgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBtYXhsaW5lYXIscm1paS1yZWZjbGst
b3V0IGJvb2xlYW4gcHJvcGVydHkgb24gcG9ydA0KPiBub2RlcyB0byBjb25maWd1cmUgdGhlIFJN
SUkgcmVmZXJlbmNlIGNsb2NrIHRvIGJlIGFuIG91dHB1dCByYXRoZXIgdGhhbg0KPiBhbiBpbnB1
dC4NCj4gDQo+IFRoaXMgcHJvcGVydHkgaXMgb25seSBhcHBsaWNhYmxlIGZvciBwb3J0cyB1c2lu
ZyBSTUlJIGFuZCBhbGxvd3MgdGhlDQo+IHN3aXRjaCB0byBwcm92aWRlIHRoZSByZWZlcmVuY2Ug
Y2xvY2sgZm9yIFJNSUktY29ubmVjdGVkIFBIWXMgaW5zdGVhZA0KPiBvZiByZXF1aXJpbmcgYW4g
ZXh0ZXJuYWwgY2xvY2sgc291cmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdvbGxl
IDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRs
aW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gwqBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9sYW50aXEsZ3N3aXAueWFtbCB8IDUg
KysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvbGFudGlxLGdz
d2lwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9sYW50
aXEsZ3N3aXAueWFtbA0KPiBpbmRleCBiMDIyN2I4MDcxNmMuLmRkMzg1OGJhZDhjYSAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvbGFudGlx
LGdzd2lwLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9kc2EvbGFudGlxLGdzd2lwLnlhbWwNCj4gQEAgLTI5LDYgKzI5LDExIEBAIHBhdHRlcm5Qcm9w
ZXJ0aWVzOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246DQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUkdNSUkgUlggQ2xvY2sgRGVsYXkgZGVmaW5lZCBpbiBw
aWNvIHNlY29uZHMuDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVGhlIGRlbGF5IGxp
bmVzIGFkanVzdCB0aGUgTUlJIGNsb2NrIHZzLiBkYXRhIHRpbWluZy4NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCBtYXhsaW5lYXIscm1paS1yZWZjbGstb3V0Og0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0eXBlOiBib29sZWFuDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlc2NyaXB0aW9u
Og0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ29uZmlndXJlIHRoZSBSTUlJIHJlZmVy
ZW5jZSBjbG9jayB0byBiZSBhIGNsb2NrIG91dHB1dA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmF0aGVyIHRoYW4gYW4gaW5wdXQuIE9ubHkgYXBwbGljYWJsZSBmb3IgUk1JSSBtb2Rl
Lg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29t
DQo=

