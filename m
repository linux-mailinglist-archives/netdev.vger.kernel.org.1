Return-Path: <netdev+bounces-215741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8199B30196
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1047AC0503
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54933341AAA;
	Thu, 21 Aug 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gEeuF7z+"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC40341671;
	Thu, 21 Aug 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799168; cv=fail; b=U2fut1CgvCyW9xG1cPabKkQrMBDdDUQN1fu8dmSzZiC7Qwyt8zPdNHhqDsDtXj/2++mF9Hm23m/GL0XuMKq9VstbL8GFPfMVNW9ooSy30kUUwgA4CZ/G/YsWbFRsZ42C9NfFwqvDoV2uXIUkvb8CoG/7kjBJUHJ1e+J3rH+QghU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799168; c=relaxed/simple;
	bh=6Yavy+H2k4nYZwfXkDkwzZbaAJ2bqJVgqIBF6tC91/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WNDefITJm/gXNPtOFlQiEZFoUdbSETEBYKv/LDOTJnfpml2meWRV43vDmUlUlbhmQJEyRTVqwstq9QR4AMgvkqd3xXBV936lEF4MkfPSngCfSlMkL1FJEXLbHfYjAOxgIkqNhYO6HUlLGMwgLoBYymOV67h38RceFY+Ka9xFFi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gEeuF7z+; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyC2ZcH2DRhYt06Nnd7fdoBNLrSboJq1nWTH05AqtXa9UuoNa+ndJBNtnyhpB9GVuDOJ2aahvJwiGRZ5fsBwnEglukft/BgqLKFb619v8frxPU+De2lGOtan95EsuravxXtn14srab5UrwGP73Sbaw5eRXlgpEvCRCMmFMpbvM2LsLl2LI00VQzy5Ri4b197rHEMFo0FmQWv6m6XIXpLc32nig0vCfg46huaV4PvkQ/4yPwJnMFAvcJBrPWB2Zv61ddYK/BSU+ZqmWvwK4654/MEmLt+vk+xFeNKXfOSfU19k+GaUwcCU5qVZ4TWu1RurOrFMbPWmoNRUGtpxoLKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yavy+H2k4nYZwfXkDkwzZbaAJ2bqJVgqIBF6tC91/E=;
 b=CWcnvPtgBhQptdklt0QuG/P4/HrLHcJO+Ib2KbC3g6P0thE/nkQ0yc4UEvZWYZDpsixqq4hrAaFKglxKiMmp01ePujrvrF/THTaroqi/rUEsLQIMMOrTZmDZhrG8zL2dI/fPPEpK2ZKsH7I+sMLh/S/iWwR2Lpt5ENdkQUhuNkd4vU6wHpvzPZmnB4VB0wuIgw0Btd+rufIRZJMsTXN3wfzXjcItHxS/vXecgossd6cdv7U5nWqNdGck/QMV/gGijxwHmhhXKKJaQ9yN6EffPZEulKborMQrWRSVmud0ZDDycZNl3Z0AZQn2GsOh0eU5vUg2zzdx84tRdY+nqkH9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yavy+H2k4nYZwfXkDkwzZbaAJ2bqJVgqIBF6tC91/E=;
 b=gEeuF7z+kC4ylcVMjvcS8Vr3KjJV84wq/Lk3wh0quA7RkutbR5BT8TMz3vQsmLtf0HGQ5pO4Mmm1GZjndV1NMkpyo6pEc4JsiIQmyRwXZw228Xo3GqOlx2uJzHAMi9b82NYHxH9AM+le9VjgDysPEdXdEeknLwIYdUiwvYkMpnhVdg8Vh7BpRKDUSW2g66/GCzAswV+yohCEg3W1TKHOdzHNYZLj7VJvM/rEA0FrXrA5ZPs3rvCTULlB/fhxh2+dPI53n1ymifwN7iTW6Yb5P0jVmDGzWClD/R+qO5ZgOZEW8VlWx1mUKhwqrJR2FyBNm2ihM8WhA5+hE/G0twcxsA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 17:59:23 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 17:59:23 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arkadis@mellanox.com"
	<arkadis@mellanox.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 18/23] net: dsa: lantiq_gswip: convert to use
 regmap
Thread-Topic: [PATCH RFC net-next 18/23] net: dsa: lantiq_gswip: convert to
 use regmap
Thread-Index: AQHcDufTQ7aHenoVNEC3H04nVlVr4bRtbNSA
Date: Thu, 21 Aug 2025 17:59:23 +0000
Message-ID: <80e49f31a311787ebdd24992e3822727a708a0b9.camel@siemens.com>
References: <aKDiUb084FhsmsTv@pidgin.makrotopia.org>
In-Reply-To: <aKDiUb084FhsmsTv@pidgin.makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7522:EE_
x-ms-office365-filtering-correlation-id: 6e74db99-d8c3-46f5-003a-08dde0dc75ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlYwbVk0SmlkU2g0K25CUXp3aHNWZm4vZWgyaDNYOEYvWFRKYUZsVDFRRlBk?=
 =?utf-8?B?eXArcnB3cjV4Z1habkY0eEhOUWk1c25TK3hLb2ppUEI1OURrRDdnRFp3VUE2?=
 =?utf-8?B?WWdWUXJFL21keUxoUDZjOGpRL1hBWFo4NTBFKzdJengwZk9pL1lSQWdHWWF4?=
 =?utf-8?B?cncxOFNob0FobTRlZE5QWFFSL09ybVJPYjRvS2k5ekZlOTRjMmlDTHRNekZ5?=
 =?utf-8?B?MzBaMVJmRFd1M3hvTlJpc01LVDdONFRuZG5YM0dDeVZMQ0htb2ZTL1lQSTU4?=
 =?utf-8?B?aTRrbWFEWjBTZWIxbGhUV2diOXl3WjlQaWZjTHVjclN1TEhEaHBiNEdxMTV1?=
 =?utf-8?B?TUpIUXZxQWprYi82a3pob3NON1Ezcy9MTnFiZ0YrVkdrdStZUUw5NHR3N0Ra?=
 =?utf-8?B?ZzRDNzZQZFdUU1JOWDZEc2JMZ1d3Q1hOMzNJcWtrM0tweHQzSytZU2wyd1d4?=
 =?utf-8?B?Q2syYWtYNzJDTGRObU5oRjIvMEQvY2lyNldndUtEeWlSdTRYMUFsVmlKbk55?=
 =?utf-8?B?UnZOVWZMYzFaaXdnMnFXMnQzM3Q4SFMwOEJQQUkxbCtNZEh6dFhWdG5VZ1Rh?=
 =?utf-8?B?TC9iemN3blMvVjB3Ym5UcHV0bDRsUmhQcnVIU1FHWGpDR0p5QVVQV0Z5bzJT?=
 =?utf-8?B?Zjl0Mi9mMXcwTXVBVHhpTEY0VlI3eUF2SmVyTGVqZXE4dkhQb25JbUk5dkRV?=
 =?utf-8?B?R05IbEpuTVpNN2lNZzhFd3JuS01vOXY4U3FrNUhyeUNhZm1vbUZobms5RXN0?=
 =?utf-8?B?MzJVb1p2SUVtMVl6UWNyWS9TaE0wSmtEd2tjelllY0ZjVFBsb3F6T25oakd0?=
 =?utf-8?B?aHVuL0JrNHRjZWxub1VCTlI2VDd5ZVVQbytnd0hDV21pa1lnOEo5N2MrZCtV?=
 =?utf-8?B?N2wrNkxPQ2trOW9PaTlJZ3BqV3MxSUVKN3NrMVlSMmludExaVVFweW5HeDEw?=
 =?utf-8?B?ZjRUTDZ3aHQ0QWIyRlNkOEdQLzVNQTQ1RlVSblJVMnY4K2VUK3k5NmMyWVEw?=
 =?utf-8?B?MFlQdURzRVluUk03dGdoOGlDY0M3QkY0M2ppSzQzZjcrS2h4OWRFQ0ZCMDYv?=
 =?utf-8?B?SmpEMC8vV0x2Qm5GUnNUOWM2YkVoTTEybStKejd6bm95Q1lSQ2NteHRrNGpY?=
 =?utf-8?B?T2N5MTNmNzh5VnBkWVp1SXhsTUhUSHZyRnJEVzhndC9rSG0reVhlWk14MDdv?=
 =?utf-8?B?U1NGcUdDNUhtYzhqaGR1WGZrZnM1dG1KTDM2R0UvYmJRSUk1VUpHY2dQTDh5?=
 =?utf-8?B?cDlabHBGWUNCbUQ0OSt4SXRQUDZ4Z3poMnVkR2g1MGU4QmJ6OStxTTY5NVJr?=
 =?utf-8?B?c3JtNDV0TjFWQkhBRmUrbXpSU1ZCbEFRQVFYK3VhSlNPdVE2SHFkNGJXL2kv?=
 =?utf-8?B?MEpNQnlqaDEzdmpCcWFDQndVRXRXY0VvK0R2U2IyajBBUDRJQlZVZFV3K0Qy?=
 =?utf-8?B?cVVNOERzb3dPTC9zK1pMSURnZjIwc0dBWHBFRVZEMHpGbXh4bDZRTVNOclgy?=
 =?utf-8?B?bTdOdUhsTHVWSDkxMTY4NGE3c08xRzJvSzNLcm9EczE5YTVYVnlMc01rZUtv?=
 =?utf-8?B?VG9YNWFVUUhDMlUwTWd3WUY5SGZONlJobWtIQ01GaU9aSWhmYko1TGltNEV1?=
 =?utf-8?B?Uk1xRFBEZDlQdVcralRLNSt5R2pmaFVUUld2VGZpa3JIdnoyblUzaWowbFN3?=
 =?utf-8?B?ZWhHV3JmQWRQYnFiQ3pqVkNVMGVxcmpoUU43VURLWTJ5S25NeWMwNHdudlVp?=
 =?utf-8?B?T1pJaFF0Y1pKdGRQZjlwVU9MN2hjU0RkTDBlTlpUdWpmak8yaVhJN3V5d0Zs?=
 =?utf-8?B?bHZidjE4bm1mRm1ERVA4TGg5R2ZFTUZwRDBCWG9jNlJ5WWd1YVhGTElRNHlJ?=
 =?utf-8?B?ODRONGJrQnBHYUlFYnNhWnVKd1BJekFLVWdKNUM5RGZ1dDk1RXZpd1NnUFJP?=
 =?utf-8?Q?7OkscTFQfLbLVprKVg9SUQ0MLXNo2qtU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YklNSlU3QnF2eFQyM2gyeDQ0UXBDZW9WcDcyeEQ2eXlHWjkzV0lOc2Nwc0ta?=
 =?utf-8?B?WGVXTm1JbS9GV1ptVGRrOHR1Y0hjUlpRZ0duWnkvL09iR0RhZ3V3Y0E5V1BG?=
 =?utf-8?B?cXZpQ044bG1pbUlrbXZjU01qVjVnMFp0Qjc4V2VKK0FIMVcvVHp2ZWQ1LzdU?=
 =?utf-8?B?eGxKeDlFb2t6dUtjWndFUERkUHRSdHRQelpscno2OGZxZjdYa2RIRHVkcVh0?=
 =?utf-8?B?aTZaMEFENFNKbmRWcmlOTUp0b1h0VWZaNDVtcVcwS1ZjOGlKc3lMRmN4NUVn?=
 =?utf-8?B?WE9TaHJjSTFTaGpVYitVeXUybWZ0WlVrUFhPZXpINXIzRXlCWnQ0ZS93Uy9s?=
 =?utf-8?B?MUhSNDVXUVVxeGhUblhQdVhJcXRMSUhFVlJ3emlTMThLVUIvd0wrcVpKSWRy?=
 =?utf-8?B?TlF5MUoxWHNoendvZkxNTCt6WFhrbkxTNzA1blMrUUdpMHg5U05XS0xIaGZH?=
 =?utf-8?B?cWgxZFZNOXF5OHRobTBzbnFoTktvVUkxREpSNTlHc0pVTnhVaHk5ZFFEOUha?=
 =?utf-8?B?SFZJN1gwMUtnWHR0bzhaLzhuZEFVbklKOFVlUnJWN1pXWFVwT2dsdG9kZUdp?=
 =?utf-8?B?Ymdiek9DK0JVZVVRK0JXUDdOQkFSOTVpeFB6MGo1RFY1VWo0UExzd3pYa1lj?=
 =?utf-8?B?NVJxN2RyVTUyVllEUWJIYWIrU0N5clZ4OW96WXVWUCsrN3B6WVcrTURuekY2?=
 =?utf-8?B?R2tYejRBeklWOVEzWjdZbGVhZkRzQnFuUGZKQTViNVlxVUhsK3dRVGNxcVJh?=
 =?utf-8?B?S25SL3BydDFnSXBkaW0xN3o4U0srakg5bkx4VWU2OFIyYndZSTRYaWV1Wmx1?=
 =?utf-8?B?TG5TcWxQazlBZzI3M1dyQnBDVW1KVDhUdzY2N2FhL2h0U1F1UDNUaW9zWVFl?=
 =?utf-8?B?WTBYQ2pycTExakhTREwzT0kwM284eHBZcjhuMHRMa2tITS9mODR6Q1VYdk42?=
 =?utf-8?B?NDJqZkppbHgwdWZXcVRYUDREbFVPbitNdmwyMk5oSGdHQm15TTNHN2JUVisw?=
 =?utf-8?B?ZkZ3c1ZibWdYdThKRWkvM1JJNlNlTlRwMHNLSXNWa2xzQnNRampKVEsyWVNj?=
 =?utf-8?B?M3hWMTVrQzhMSVc1VTZFZitmcWZIb2x3WXJLSjBURGgwMGdtOXBjcnM4SmpI?=
 =?utf-8?B?YkdGZzdaYndGY2xIMDFwVnJnaU1PMnBuQk9mVy8yc2pUZGpYRGZ4QTVIRTNu?=
 =?utf-8?B?M1gvRFU1MG8zNDg5RmF0MjlSQm9lcnNIeFJQdG5HMm8vLzFVTVNZZWZjcXls?=
 =?utf-8?B?Uy9iK1BUQVdaVzRidmROUkVkTHFJaFRkU0JldVNmN3htRklFUFhlK282ZW5v?=
 =?utf-8?B?aE01VXFOS0ZwbUdXU0ladUZvancrcUNEazBrTjNlcVdIK3g1M296U2lDa1RM?=
 =?utf-8?B?M3VGNFd2YjA5Wk45MGcrbzQ2KzU1MHNEY1grb1JDczA0TkRzb3gwbzNOYVE3?=
 =?utf-8?B?aFlOOVJSOGIxSnVIN3VHYmNXdE4vTVRQSHRLVURUMkxqVFcvWFJRSENuVEFB?=
 =?utf-8?B?V1h5Vjc0SU1LZHdMWDhTNUI3Vnp4NUxjTDEwWDRublFudnRqaWVuS1hBRXFE?=
 =?utf-8?B?aU0xSFNIVU9MNzRJUVQ1OC9ZQUNvUW4velE5cUJucE04KzY1bjlBUWx1L0ow?=
 =?utf-8?B?TUNLMlRaOHhaRVVlUEVWQUkralJTWFZ5aWVpUmV6SXFBcGVqT3VPa0xzTDNB?=
 =?utf-8?B?RlF5MmN1NjRReE5jRHMrNWpoSjJlaWdUU2dOczREYzZkT0JCV3pLeUYzV1d3?=
 =?utf-8?B?VnJVUld1ZDRpMXFsdlVvNS91ay9zei84RDdvMGorMnpCUFNiUW1tUUV4RTVU?=
 =?utf-8?B?WG9WRXlncTdoZ1VPbUdLaFNyU0NyTjJydGtIcEVUNmJ0UTVVRWF0VVg1NVlz?=
 =?utf-8?B?M2RXb2oyYW5XNit4UkZSa0U1dHJyR3UxeFJNOXZyZElGeDBtK2V2UllxUjdG?=
 =?utf-8?B?U3RzRXNpcEFFUEJQS242WEJpUmVrOTA1ei8yRmV3ekJmblc2MzFjaGpnb1Y5?=
 =?utf-8?B?Q0tYRitCUE41T25weXBkck1NOWxXTXhLMTlKL0tmTjluOWhtdS9XYmMvTEFL?=
 =?utf-8?B?UEd0UkgrTlhBbVZBUDR4VURERDg3VGl2OGJtME4rcmJTUXJsbGFyVUw1bGF6?=
 =?utf-8?B?K2t1eVFQYVlOam1YVTlBajZXSzV5U3ZDV25GazZrcEVOOHc2azdXVDg0VUZR?=
 =?utf-8?Q?gngmV+lfkzCbCtuVvPLcSkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4845070DBEEF4441B2740835C07C6FF9@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e74db99-d8c3-46f5-003a-08dde0dc75ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 17:59:23.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcvQ7MEpB6ev2+ypPXNTd7FkvgsO0onVNc1OXN2OzqQonMd6NmOsLmA6Tx94Xhu8aJafzbFvBf5DdoQkvKRAKR6xCHJZw+RLz7qwbDsFFXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7522

SGkgRGFuaWVsLA0KDQpPbiBTYXQsIDIwMjUtMDgtMTYgYXQgMjA6NTYgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gVXNlIHJlZ21hcCBmb3IgcmVnaXN0ZXIgYWNjZXNzIGluIHByZXBhcmF0
aW9uIGZvciBzdXBwb3J0aW5nIHRoZSBNYXhMaW5lYXINCj4gR1NXMXh4IGZhbWlseSBvZiBzd2l0
Y2hlcyBjb25uZWN0ZWQgdmlhIE1ESU8gb3IgU1BJLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQoNCi4uLg0KDQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2RzYS9sYW50aXFfZ3N3aXAuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbGFudGlx
X2dzd2lwLmMNCg0KLi4uDQoNCj4gIHN0YXRpYyB2b2lkIGdzd2lwX3N3aXRjaF9tYXNrKHN0cnVj
dCBnc3dpcF9wcml2ICpwcml2LCB1MzIgY2xlYXIsIHUzMiBzZXQsDQo+ICAJCQkgICAgICB1MzIg
b2Zmc2V0KQ0KPiAgew0KPiAtCXUzMiB2YWwgPSBnc3dpcF9zd2l0Y2hfcihwcml2LCBvZmZzZXQp
Ow0KPiArCWludCByZXQ7DQo+ICANCj4gLQl2YWwgJj0gfihjbGVhcik7DQo+IC0JdmFsIHw9IHNl
dDsNCj4gLQlnc3dpcF9zd2l0Y2hfdyhwcml2LCB2YWwsIG9mZnNldCk7DQo+ICsJcmV0ID0gcmVn
bWFwX3VwZGF0ZV9iaXRzX2Jhc2UocHJpdi0+Z3N3aXAsIG9mZnNldCwgY2xlYXIgfCBzZXQsIHNl
dCwNCj4gKwkJCQkgICAgICBOVUxMLCBmYWxzZSwgdHJ1ZSk7DQoNClRoZSBhYm92ZSBsb29rcyBs
aWtlIHJlZ21hcF93cml0ZV9iaXRzKCk/IA0KDQouLi4NCg0KDQo+ICBzdGF0aWMgdm9pZCBnc3dp
cF9tZGlvX21hc2soc3RydWN0IGdzd2lwX3ByaXYgKnByaXYsIHUzMiBjbGVhciwgdTMyIHNldCwN
Cj4gIAkJCSAgICB1MzIgb2Zmc2V0KQ0KPiAgew0KPiAtCXUzMiB2YWwgPSBnc3dpcF9tZGlvX3Io
cHJpdiwgb2Zmc2V0KTsNCj4gLQ0KPiAtCXZhbCAmPSB+KGNsZWFyKTsNCj4gLQl2YWwgfD0gc2V0
Ow0KPiAtCWdzd2lwX21kaW9fdyhwcml2LCB2YWwsIG9mZnNldCk7DQo+IC19DQo+IC0NCj4gLXN0
YXRpYyB1MzIgZ3N3aXBfbWlpX3Ioc3RydWN0IGdzd2lwX3ByaXYgKnByaXYsIHUzMiBvZmZzZXQp
DQo+IC17DQo+IC0JcmV0dXJuIF9fcmF3X3JlYWRsKHByaXYtPm1paSArIChvZmZzZXQgKiA0KSk7
DQo+IC19DQo+ICsJaW50IHJldDsNCj4gIA0KPiAtc3RhdGljIHZvaWQgZ3N3aXBfbWlpX3coc3Ry
dWN0IGdzd2lwX3ByaXYgKnByaXYsIHUzMiB2YWwsIHUzMiBvZmZzZXQpDQo+IC17DQo+IC0JX19y
YXdfd3JpdGVsKHZhbCwgcHJpdi0+bWlpICsgKG9mZnNldCAqIDQpKTsNCj4gKwlyZXQgPSByZWdt
YXBfdXBkYXRlX2JpdHNfYmFzZShwcml2LT5tZGlvLCBvZmZzZXQsIGNsZWFyIHwgc2V0LCBzZXQs
DQo+ICsJCQkJICAgICAgTlVMTCwgZmFsc2UsIHRydWUpOw0KDQpyZWdtYXBfd3JpdGVfYml0cygp
Pw0KDQo+ICsJaWYgKHJldCkgew0KPiArCQlXQVJOX09OX09OQ0UoMSk7DQo+ICsJCWRldl9lcnIo
cHJpdi0+ZGV2LCAiZmFpbGVkIHRvIHVwZGF0ZSBtZGlvIHJlZ2lzdGVyXG4iKTsNCj4gKwl9DQo+
ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGdzd2lwX21paV9tYXNrKHN0cnVjdCBnc3dpcF9wcml2
ICpwcml2LCB1MzIgY2xlYXIsIHUzMiBzZXQsDQo+ICAJCQkgICB1MzIgb2Zmc2V0KQ0KPiAgew0K
PiAtCXUzMiB2YWwgPSBnc3dpcF9taWlfcihwcml2LCBvZmZzZXQpOw0KPiArCWludCByZXQ7DQo+
ICANCj4gLQl2YWwgJj0gfihjbGVhcik7DQo+IC0JdmFsIHw9IHNldDsNCj4gLQlnc3dpcF9taWlf
dyhwcml2LCB2YWwsIG9mZnNldCk7DQo+ICsJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzX2Jhc2Uo
cHJpdi0+bWlpLCBvZmZzZXQsIGNsZWFyIHwgc2V0LCBzZXQsIE5VTEwsDQo+ICsJCQkJICAgICAg
ZmFsc2UsIHRydWUpOw0KDQpkaXR0bw0KDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

