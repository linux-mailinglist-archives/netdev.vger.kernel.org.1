Return-Path: <netdev+bounces-189896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83EAB471B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E62A4A2BE6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6D25E44B;
	Mon, 12 May 2025 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="lO45Yjaz"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022087.outbound.protection.outlook.com [40.107.149.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13425C71C;
	Mon, 12 May 2025 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087554; cv=fail; b=NmcyWNEg6+0L7I/BUqwu3uKSlsEp6+7/saaC+Nv4sKIJkR2PedUzmrXVUC4XiMmG+Xks6hfnoXoqyTmYvaegMRO5gs9VyFwQcMXjEQC9CpHaMcA9bMrYknuGeeWroXWtgUwkQ1zX0gpPV0mzcMeDybZD/vd4EsVlDNuvHd70Fx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087554; c=relaxed/simple;
	bh=a9X/NYPm9vFzYiG5SLrdDmvCA6jmCT3ZleYcEEp24O4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCg9CDiehiPTl3mEagDih5tcWAnGzqOAFOL19LHtIDz1SiLkfSwNrcpQNd6VbTGXpG2ycr+FpYD5NtpZqBrJ4wgXbiWQEwzKqmGLeyVmbklG/DKakp27OIwuBOfrU0JxWjtNJdp/dROba+0UlZFRHxWFD6lKSFV8Yd07aHKhJD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=lO45Yjaz; arc=fail smtp.client-ip=40.107.149.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKeq2KRoETL+qxXBUX4F5ou0egi/86r9+8OM5WJVwQ+rjhENZ8QNmMzr8EomAzyQqgyZVx/Kp4WTX2qK3WmX/Hcr7UQRYsUWyCgoOcud+avvKJCkJC0vPWcsbDKwgvKR+epFKbCwH8Y0S1GStMMxJOGHevOzMtXMedKzOXs2gyTw7/x+km6mpmFGo7QSUuEMV8w5tubBb1N2qOmqlnVR6GoE4kzxq4oKGzISjWQ/s5eaFSs73SW5aKovccgpNUnNCrbOoqH/UHYliLjKE7nifuu6goqq1JNx4HnyeP4F1wffEdvvSVt5Y+v4HLbWN1gkkFG8wHDWskTHAEaQUU+cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9X/NYPm9vFzYiG5SLrdDmvCA6jmCT3ZleYcEEp24O4=;
 b=Hz5WdybSWpYep/p8KtHLs5hJ5VyNztAVWGdto1ypMTx9uoMFFD/Wg/kwRekI3c7H9r0kDjCY/r2WdwSPiK8O2KHmqivddePLo0gsOvO2BWokudHAwDHuxHzfvYItv0iA+zL1VmsOupq4mNceBBirQ90n16/v2P2c2OUUMEZQHHuJT94UV/Vns7uWyP8Q2U7Gcr7dlF8am8OCldpJ4Sg55jxxZm7fycJogpbqf6t/Uoeu7OrRrVr46KTEB1Q8eZGRDYt54U8wJkivfBct/aePeYN/TFIoiUxTW3rMUZO5TZ/AOYZSn94yElR+dMHqHHrCuWAPiQWUsWvcWWWBdxnYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9X/NYPm9vFzYiG5SLrdDmvCA6jmCT3ZleYcEEp24O4=;
 b=lO45YjazX6jkUO5GfD3ndLQQrUcpey04nm8HNKWUMzWnQ85hunHJiOV0Yu7Z6Svvho2Uf2MnZwLgX00QlNubg3ISo7m+diYU3wWW4lQQe+A3T7Tf7zCzHBOm5kbyNA4cPmxkvVr8eO9/Lo48yhvnmZJ1pp5WSEnej+LI3QylOHw=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 BEYP281MB3892.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Mon, 12 May 2025 22:05:49 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 22:05:49 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Index: AQHbw4oFAO3g15YsTkGGTqTEXILqOg==
Date: Mon, 12 May 2025 22:05:49 +0000
Message-ID: <259ad93b-9cc2-4b5d-8323-b427417af747@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
In-Reply-To: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|BEYP281MB3892:EE_
x-ms-office365-filtering-correlation-id: e049be51-e9f0-4a12-de78-08dd91a12788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDEyeFl2STJoSFUxV2tsL3FqdTFOYmtoK3Nmc0lJTUJEL2pka09tNGd2VTdt?=
 =?utf-8?B?WGpTSkREbWN2bUpkcE5PdUZyMm9XUDlOb3ZUWlI5eGRjcS9NNHZ6Z0hITjhm?=
 =?utf-8?B?MGw0ZW4zTlBSZS96WjI2Uktvckd4NjdVMlJyQm12cG9BbllSKytWMDBad2VC?=
 =?utf-8?B?enV3ZjZNVWdUSWY0TUlZUFBKQlJtWnVsRG5PVXdQR2txKzRCWWFabEF1YUFW?=
 =?utf-8?B?MFRGbDhlb2FONmgyWCt3bFZjOGNMbk9VRXJBQk9ya1h1dFhMc3YxNWZueFVr?=
 =?utf-8?B?VERWUExDR2pEbFhmdWFVWDMxcE5HVkk2cVJhL0NReStpKy9qL1owYURXTVZV?=
 =?utf-8?B?cklXK0h1Sno2UU10ZUNNcnYvbW5rNmpxdDJiOTRkb0FBeEoxRXU3L0lwUThM?=
 =?utf-8?B?NVFUQUhEbnlDQXUzUFBwektYdGswRFBiRTNBcm1oM3BnVTk2bVBsS2Y2WmQr?=
 =?utf-8?B?NE50eFAwekJEaWxCTm1CZmVnN3NucEJnUzkyOTJlbUZHMm1lU1NTYzlGNTNq?=
 =?utf-8?B?UkFjUHp6eW4yc0U3SHVad2xEeUtRKy92VFQzTGVFdVozdGNsVDFoR1NyZHRF?=
 =?utf-8?B?RUtLcVV1bW1rWThYK0ptT2hScnpTR1F2dUNwaU02TThmNUhaQUVHZXIvK1Zv?=
 =?utf-8?B?MUlCcUJPcGNkMWdRRmc1bW5kZEdmSXd5TnRsMkJFc2RVeG03V2JUUkJDNlFP?=
 =?utf-8?B?V21WM1hQWkNsb3BEMWVOamhDUkxjV09VQ3hUL3V0VXdwSUJJZEZnTnp2SE1Q?=
 =?utf-8?B?VTZ3aUZzdW1WSjRUL2UwOHFUeWljdllXRFZWaFpOMEpZdTZxSEJHWEhDNENy?=
 =?utf-8?B?NExDVVUwTHlMV1grcVloOVNxYUIrVlZIUmFKMFh4TlJuWkdwREZsaGVnOThi?=
 =?utf-8?B?UFNzTXVxczgxU3ptckM2MUtidmJjS21VSHR4T1JDV2NyQmlQTk93ZXBKdmhw?=
 =?utf-8?B?dGtIaGoxQS92dW5VRmRrTlowbkdBU3Rtd3FkYmZPcjF3cE5ldGhVQ2lIakZP?=
 =?utf-8?B?TnRMVFdZcE8yM2NTMk5JbWl0VjJNY2M0UVUrRlE4OEZyMkF0ckM4REltelU5?=
 =?utf-8?B?NSsxUXV6L3IyblhuRzA1V1BmNmxERERFUGZPbUY5bmFMVlE4T1luWDAxaDVH?=
 =?utf-8?B?dXNVaXQ1bm82N1BsbCtDMEZVc1BjWXg2YjhtazZOcktaUUx3ZWF2MlJGWWNR?=
 =?utf-8?B?RlRDU2kyeFh5YXEwb2ZBM0Q1MDBnblF1NkNIWlBtYW00TzlHU2RFRmxON1dH?=
 =?utf-8?B?VDJZVXlvL1FBVGk1T3VwVXFGMFJSeDB2VCtnQnpHaVMvOFFRRmh1L1F5QnYx?=
 =?utf-8?B?YlV1S2E2RU53dS9XM1J3V0pGdmFSNlRDbGU1eVAwazl2b2t2aGJRNkhvRHpz?=
 =?utf-8?B?NlFKVGhpS01LMklyUldnQjEvdVJURDhHaE9CZFAvQ25pY05ZcStPcUhoWEZB?=
 =?utf-8?B?dlBONkRQNWpkZWpDalRSaHhPamFjcVFIQXRzSU9Ca3RoVUU5bXNXMzFJN0Ny?=
 =?utf-8?B?N3JOSnE0aFg1bGRLZ2tDYllHdEMra0NkNmhDeG9sN2tlVkdXNFVzanFnUDdo?=
 =?utf-8?B?YmJuT1NqNVhqdUF3cUtQdDVlamdYYWFLMmdyQ2Urb2VLVno2dHdBVmNzWmlx?=
 =?utf-8?B?MWVZbzF5UWx4bXJMYVBMa01USWN3c2t2ck1DUEdUV0lSNkgzcTJVTWVLOW01?=
 =?utf-8?B?eTFIcEdaWnNwNVZ6b0srSVM2QzBnT1g2NERSQUw4U3NjbEJPSzdYSnpqK1RY?=
 =?utf-8?B?L1VodGJOa3hsYk05SWlQeUpQa2k5NkxEUURvb1hlamE3M0xsY0t5bjdnR2Y0?=
 =?utf-8?B?aGl5RmVkM2xYSHZCK2VxbGowVUd2Qk1QVFFtNmxtb1pteUZXWGVNdVhmY2I4?=
 =?utf-8?B?ak9oN2JYREFyKy9mMlZXeGVQMzRiVXp1eGs5WWpWaXRnRUVGcUJzTEgxcU95?=
 =?utf-8?Q?ioHXTKUIphHqU+YzClp7RkMDdD2KrSup?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djliN3VsWkZyVWtRSE1zTnA5eUx4RXJWY2daVlBLWXNhVlYrcFF6Q0pMMmg3?=
 =?utf-8?B?K1JOV3NhSVJoeGxrNngvVFBzcjBLUHBQMklSR0kwbTZqWTI1aDBYeUZqd0Zi?=
 =?utf-8?B?WGRHd2Y5T2JJRjhVSk5QWisrQVJrMUszeDEyR2NpdU1pZjkrSHB2M0NFQ25n?=
 =?utf-8?B?bzRubEZvaHBGcFVDbk02NksyQWlOeFJVcDE3ZDlTYmpRZTRJSUQ0QmFzRWxN?=
 =?utf-8?B?ampyeTJOK1pwSSttdlBaQWVaYXI2QlF2SU0vY210b0NIMVQ4TTZkUVdOZUxx?=
 =?utf-8?B?cGJHWENPZktmUDZodU45QktTZGFZYjV5YkIva1pwUVpjOE1QRG1YY2NkT0Fv?=
 =?utf-8?B?b0dYMDRlaCs4SXdmdGRHbHBJQVFYUEcwMGR0VE53a09LZG10NG00dUNxb2ZQ?=
 =?utf-8?B?YmJXZVVBUDBaY0diM0dyWVYvWFZZQ2QwSGtFQWpJQitpR2wrbFFtQWx2c3R2?=
 =?utf-8?B?TlNXQ2RVcW0xN3NOSW0rQy9KazRETjg4U08vVUUwV3ptTGIzaVJvcHJNbTBn?=
 =?utf-8?B?OENPZEdzREhHQVBOSW1WQWtxMG1GMGF3aVBUaiswajhzZlBIdnRhSTZCaWhS?=
 =?utf-8?B?YytrSW93NGkrY2JGRXJ0amJnclh4RXMyMW5waGFHUVAzUSt0ZnRsWDJ5cW9E?=
 =?utf-8?B?YWhicTkxaWFFeHlNSDRUS1RVeDVzZTlmRlo2Z013dWI5eEJoMHNuN25DSUsy?=
 =?utf-8?B?QytDWFk0eWxOQjNOMXpHa3J2Y2t4M2V6NEYwckZmeXhwdlY4VWdPTDM1ZGkw?=
 =?utf-8?B?UzdWUGoyQTI3eC9DcFordWI3aCtaak82SS9jbFQ5eUNBbTJvMDdXSGFRZXEv?=
 =?utf-8?B?WncxclhQKytiMWRHNlA4YUVWYXVhOGJsVFlnY29heWJTcStUZ2Y0V1ZiQTI0?=
 =?utf-8?B?VkQwaUFHaEI1Q3BkajNEUDRIbG96a2hoNWN4SVVkbi9VdktNMkVpSGJlWnRC?=
 =?utf-8?B?Z1BpcS9INU5NVFU3SGxVMnFVRDBLNGt6anhDR3B4dm90UUxZTnVRcnFFT1lO?=
 =?utf-8?B?OTY0Zzd1czZ6T2N6YUhGTFRSNnFGOXdFekJUS3BHUWZoT3hiVVFSd2JKdEI4?=
 =?utf-8?B?L09RNGVseGExc1pWRnVBTDh6YmgzMlJ2ZHExMVRpRnlKd0VJc213Q2tSTjVZ?=
 =?utf-8?B?RmhLc2NHN0RkeXpFNlFzS3pOMmlwV0NGeVVjQmZpdkNPMUoxeDlOcXBxSE95?=
 =?utf-8?B?ZTZJSmh2N3AvMEU1c2MreDdiWitTcktseE5kcTlIOHZSSjFkNWs2dzZSelNZ?=
 =?utf-8?B?SGE1WnJBTnVaMmZqWk9GKytNODJkQmM2ZG9leER4ZndWZGpidGNZQkNSUzhY?=
 =?utf-8?B?N0lBQWlSajdERGZqN0F4YVZIcFBvUzd2bWFodjdtOHdXdFF0WTV2ZDhPakZs?=
 =?utf-8?B?R1VBenh3aFRPQjRGWTBIREpsM2NxcGcvR01nL2RLYzkvRmNVQm1IaFNvV0NG?=
 =?utf-8?B?UWl2MXRhOTAwWUxRbng2UU1EczFHdnZESmJOd1RPZDh3RW94SU5DeWMrb3NK?=
 =?utf-8?B?M1BvUy9icjJTSk4rNW5WNm9SMWhwaTV2azNFeEVnZFM1OVUwYWVTS2d1NEpO?=
 =?utf-8?B?N3ZYeVFhMzNuc2RjRno0eUNZeGdUeGVjNTlzL0FqWlAybGZTVlNMTDZpV1hn?=
 =?utf-8?B?bDE5ekVVWjlpS2szc3V6bkJCS1FIN09RejNqZzMwWk1TRTkyM3laMnROVTRV?=
 =?utf-8?B?cFVQSHh0cWFMSE40Q1RCWG9aeXZ2TWVUNEFITDVTc3lyenhiVW1NMXVLbTF4?=
 =?utf-8?B?RnFUZjNiZ09HUjV6dnNzd05LcVMvL3ZrekZseWZjUXhxZEJxci9wOFBZL1dn?=
 =?utf-8?B?Y3VRTEhtajg5cWFJdEcrc0pHaENwRTB5c0ppT0I5Wm9nSUxidTIzOUdvT2Zk?=
 =?utf-8?B?cnpJR1lPZUxWejhaOWExMHVTdTVMK2JBcE40RUNZSWpiTEM5Vys0QkFLcm1L?=
 =?utf-8?B?SHgyclc5WDU2clJqUEoxREVBVmQrSTVuR1lvbVV1ZzR3TEV1bTg3NWdXY2gy?=
 =?utf-8?B?VXVESWxMVGdveS9rQ25STUF6eElTQzFLQmFXUEVYMS8yZkw4ajJ2b1d4SGVW?=
 =?utf-8?B?bXdqSE5ySVBxVnJTSjVGbE5wcDRuRmNhYStNdGo1eHNKK0hNMmJDYVB0TjF0?=
 =?utf-8?Q?xHn5VGLYX7Ro0EhF6xVK5DMR/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCC4A847DEC4347B3CBE4CF521596CB@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e049be51-e9f0-4a12-de78-08dd91a12788
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 22:05:49.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4QvcN3TA1YCLTJ/QgZ0DrbWYAft67FhAuyBmiY9ndmWQnyIkmBRc7xRJz640mRF/+YFyeRcyIVZf+RTye3/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3892

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3
b3JrcyxzaTM0NzQueWFtbCAgfCAxNDYgKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDE0NiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9z
a3l3b3JrcyxzaTM0NzQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5k
ZXggMDAwMDAwMDAwMDAwLi42NDY5MjRhM2NmYjANCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55
YW1sDQpAQCAtMCwwICsxLDE0NiBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbCMN
Ciskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
CisNCit0aXRsZTogU2t5d29ya3MgU2kzNDc0IFBvd2VyIFNvdXJjaW5nIEVxdWlwbWVudCBjb250
cm9sbGVyDQorDQorbWFpbnRhaW5lcnM6DQorICAtIFBpb3RyIEt1YmlrIDxwaW90ci5rdWJpa0Bh
ZHRyYW4uY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwc2UtY29udHJvbGxlci55YW1sIw0K
Kw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBlbnVtOg0KKyAgICAgIC0gc2t5
d29ya3Msc2kzNDc0DQorDQorICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29u
c3Q6IG1haW4NCisgICAgICAtIGNvbnN0OiBzbGF2ZQ0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVt
czogMg0KKw0KKyAgY2hhbm5lbHM6DQorICAgIGRlc2NyaXB0aW9uOiBUaGUgU2kzNDc0IGlzIGEg
c2luZ2xlLWNoaXAgUG9FIFBTRSBjb250cm9sbGVyIG1hbmFnaW5nDQorICAgICAgOCBwaHlzaWNh
bCBwb3dlciBkZWxpdmVyeSBjaGFubmVscy4gSW50ZXJuYWxseSwgaXQncyBzdHJ1Y3R1cmVkDQor
ICAgICAgaW50byB0d28gbG9naWNhbCAiUXVhZHMiLg0KKyAgICAgIFF1YWQgMCBNYW5hZ2VzIHBo
eXNpY2FsIGNoYW5uZWxzICgncG9ydHMnIGluIGRhdGFzaGVldCkgMCwgMSwgMiwgMw0KKyAgICAg
IFF1YWQgMSBNYW5hZ2VzIHBoeXNpY2FsIGNoYW5uZWxzICgncG9ydHMnIGluIGRhdGFzaGVldCkg
NCwgNSwgNiwgNy4NCisgICAgICBUaGlzIHBhcmFtZXRlciBkZXNjcmliZXMgdGhlIHJlbGF0aW9u
c2hpcCBiZXR3ZWVuIHRoZSBsb2dpY2FsIGFuZA0KKyAgICAgIHRoZSBwaHlzaWNhbCBwb3dlciBj
aGFubmVscy4NCisNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KKw0KKyAgICBwcm9wZXJ0aWVzOg0KKyAgICAgICIjYWRkcmVzcy1jZWxscyI6DQor
ICAgICAgICBjb25zdDogMQ0KKw0KKyAgICAgICIjc2l6ZS1jZWxscyI6DQorICAgICAgICBjb25z
dDogMA0KKw0KKyAgICBwYXR0ZXJuUHJvcGVydGllczoNCisgICAgICAnXmNoYW5uZWxAWzAtN10k
JzoNCisgICAgICAgIHR5cGU6IG9iamVjdA0KKyAgICAgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQorDQorICAgICAgICBwcm9wZXJ0aWVzOg0KKyAgICAgICAgICByZWc6DQorICAgICAg
ICAgICAgbWF4SXRlbXM6IDENCisNCisgICAgICAgIHJlcXVpcmVkOg0KKyAgICAgICAgICAtIHJl
Zw0KKw0KKyAgICByZXF1aXJlZDoNCisgICAgICAtICIjYWRkcmVzcy1jZWxscyINCisgICAgICAt
ICIjc2l6ZS1jZWxscyINCisNCityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcN
CisgIC0gcHNlLXBpcw0KKw0KK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCisNCitleGFt
cGxlczoNCisgIC0gfA0KKyAgICBpMmMgew0KKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
KyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKw0KKyAgICAgIGV0aGVybmV0LXBzZUAyNiB7DQor
ICAgICAgICBjb21wYXRpYmxlID0gInNreXdvcmtzLHNpMzQ3NCI7DQorICAgICAgICByZWctbmFt
ZXMgPSAibWFpbiIsICJzbGF2ZSI7DQorICAgICAgICByZWcgPSA8MHgyNj4sIDwweDI3PjsNCisN
CisgICAgICAgIGNoYW5uZWxzIHsNCisgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQor
ICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICBwaHlzMF8wOiBjaGFubmVs
QDAgew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAg
cGh5czBfMTogY2hhbm5lbEAxIHsNCisgICAgICAgICAgICByZWcgPSA8MT47DQorICAgICAgICAg
IH07DQorICAgICAgICAgIHBoeXMwXzI6IGNoYW5uZWxAMiB7DQorICAgICAgICAgICAgcmVnID0g
PDI+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF8zOiBjaGFubmVsQDMgew0KKyAg
ICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNDog
Y2hhbm5lbEA0IHsNCisgICAgICAgICAgICByZWcgPSA8ND47DQorICAgICAgICAgIH07DQorICAg
ICAgICAgIHBoeXMwXzU6IGNoYW5uZWxANSB7DQorICAgICAgICAgICAgcmVnID0gPDU+Ow0KKyAg
ICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF82OiBjaGFubmVsQDYgew0KKyAgICAgICAgICAg
IHJlZyA9IDw2PjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfNzogY2hhbm5lbEA3
IHsNCisgICAgICAgICAgICByZWcgPSA8Nz47DQorICAgICAgICAgIH07DQorICAgICAgICB9Ow0K
KyAgICAgICAgcHNlLXBpcyB7DQorICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKyAg
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgICAgcHNlX3BpMDogcHNlLXBpQDAg
ew0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+
Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5h
dGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfMD4sIDwmcGh5czBfMT47
DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAg
ICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisgICAgICAg
ICAgcHNlX3BpMTogcHNlLXBpQDEgew0KKyAgICAgICAgICAgIHJlZyA9IDwxPjsNCisgICAgICAg
ICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0
ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwm
cGh5czBfMj4sIDwmcGh5czBfMz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0g
Ik1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisg
ICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3BpMjogcHNlLXBpQDIgew0KKyAgICAgICAgICAg
IHJlZyA9IDwyPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICAg
IHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJhbHRlcm5hdGl2ZS1iIjsNCisgICAg
ICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfND4sIDwmcGh5czBfNT47DQorICAgICAgICAgICAg
cG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0KKyAgICAgICAgICAgIHZwd3Itc3Vw
cGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisgICAgICAgICAgcHNlX3BpMzogcHNl
LXBpQDMgew0KKyAgICAgICAgICAgIHJlZyA9IDwzPjsNCisgICAgICAgICAgICAjcHNlLWNlbGxz
ID0gPDA+Ow0KKyAgICAgICAgICAgIHBhaXJzZXQtbmFtZXMgPSAiYWx0ZXJuYXRpdmUtYSIsICJh
bHRlcm5hdGl2ZS1iIjsNCisgICAgICAgICAgICBwYWlyc2V0cyA9IDwmcGh5czBfNj4sIDwmcGh5
czBfNz47DQorICAgICAgICAgICAgcG9sYXJpdHktc3VwcG9ydGVkID0gIk1ESS1YIiwgIlMiOw0K
KyAgICAgICAgICAgIHZwd3Itc3VwcGx5ID0gPCZyZWdfcHNlPjsNCisgICAgICAgICAgfTsNCisg
ICAgICAgIH07DQorICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi40My4wDQoNCg==

