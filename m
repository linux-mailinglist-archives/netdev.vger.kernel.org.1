Return-Path: <netdev+bounces-136434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75969A1BE0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021A5B212F7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FA1CBE9E;
	Thu, 17 Oct 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="COLcT/BV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16439FE5;
	Thu, 17 Oct 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151042; cv=fail; b=ELYjBscPgLgz77ppKKl3hurOGWlHABakSGOQ4W3pOUV4ILCF/+zv+1a0UUbBolUndvTbIRin28qHaSefiVNpogWnCw23XvwB591jMFUkE6ysX3Pf6avUAE+Gt9Z4KEw3SuvFtR10uWSJX+SgJjRhu2RGvsukgyobyovPaxEvuig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151042; c=relaxed/simple;
	bh=NB3yS90fvYCOD96PoEmf9PJeyxjU12kQuXm34cojyg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJ+TZvJZsZn9BkCx+9oYf63x8+rdRmG/liYEBi5Mghuiys4phq7/JPUPtfGzBOQAr5j6zKkPVfqCJv8K9PLVkB5HQqRe+K8iPMFIS7H9N4orYhnRGvc9S/KKRYVHqfPPefRKDQfKhaUow8oP8GYkCLDu/iH55qO1i6GVTxfnOMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=COLcT/BV; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnv6Un0rvRLcIDYoC9d1RVo2yMGz8Fb0/VtPhJJz+9+5oeN/XjBLNBMuMAqnC4ozjPXl1o6mkc46+SSlqZxaG+5k2q+ldeM4HXj0sCxIhVhYcJgxWWQeZuQEGkwtt/nWMCuu2AsFAs+/ade5WNbBIK2PMQoQLIxdY9gpxjWapri9c+b9U+ytPpWFt9vrwy/QbiWnkJuW92gYXM0XoQxT+VUcU8sbSauhwNZwr161fdPn3LKg/18nEW+ADeH3NBKP4sfIMRxGGqQ8w3B9ERP2Nm+27wtBQnHAiwZ5ip33Mfm5qzHqg89OH3UnTNSs1aNH4XKEeTLpEfI6KPlKr6qIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB3yS90fvYCOD96PoEmf9PJeyxjU12kQuXm34cojyg4=;
 b=evXOGmWG4bjZVPmIRtNFPzyIEDQp2jozkMJhWTOg8l0yhb/b4Ezu7/zNWWr2Ku3JY5dzvaJ0Qz8lalMtfZ/amyw4Ekr1HWhW85I0w5CHXxrY1r4Yo+kNwe66gIq+gOuZoT6Sy+iqdlMTK6+E4592XBZT28GxkahoSNM9jP2n54dd71yI4GQLg+skghF4shGHE6Yora1StR/j4hi+OSE4M1s4ZmezlerM5bUzVl90DrB/xdK7cQqUdBy4bEIqmwdrHbLyfZ4Cj2NVZ1EJ5trkhSd/IP/k6tXkAjy9t2p1v1ysr0qc6+gq496T3MkEDtlI9RqZ167kD4nj6fsC7Zi2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB3yS90fvYCOD96PoEmf9PJeyxjU12kQuXm34cojyg4=;
 b=COLcT/BVSgYJiAEap7AQr4rQeSRZRAzbU/2L6G+iKxmqQVaofbHzBFY4LlYCz2P2uwgcxbu5WqcoPJh31WaLIwrJl2Q3BnMuqNYR67FxW2GHv5585+MEsJAfbLBL/c9Uh4jahZFG2KVrRZDoWKpNqGVlokd65Y60hHcXpWZ5jdF+iMRMXdrXiE3RgbwWLjY3XIp3skAZmaINRjsel5dWXznSfGdPtUQVKhPi2BiEKjorWMAUqjT6352hxjeJmXshKiNxPGpVSZM2ebKq7ctEsuPN0Y/o1al5y6QDRyJEX+Zcz5cnl3hEgGjVGKclyfIwNC3XcOCtlvWjqIk86PSebQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10921.eurprd04.prod.outlook.com (2603:10a6:150:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 07:43:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 07:43:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Thread-Topic: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Thread-Index: AQHbIBW0EbmLSZRKu0+NHfJhzgqLtbKKP8NQgAA4MgCAAA7AAA==
Date: Thu, 17 Oct 2024 07:43:55 +0000
Message-ID:
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
In-Reply-To: <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10921:EE_
x-ms-office365-filtering-correlation-id: d9e49370-54af-4d50-704d-08dcee7f7421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWx3eVFOSEFiWm1iT0hnTkRaVnpjeC9sUEROU1Q1Z1M5OEFkd3QybENqS2sz?=
 =?utf-8?B?YjRjNUhicG1uM1ZtaHNQbElKRjgycDYrMFNXaXoydU04Q2NqSWxlYXVOZXVl?=
 =?utf-8?B?NGdQeEMxQTgrUHlFNlN4OVhnNGk1TW5LNVRXdDEvK1UyM1dtNnNSUU84ekJ0?=
 =?utf-8?B?a3hzZElPWCt1L0QxbnRhSGVXWUNld2FZdHJESHBLbEVyd2F1b0VlRytlTHBt?=
 =?utf-8?B?VDFzSHlRMExtMVJBL1VIUDhRQVZRMWxRNWtZNUNzQXZmeEVFY2Z1OGlFSXhN?=
 =?utf-8?B?eTFzQVdZLzJhQ2hBR0ZoYjV5ZzVieU53WTVUYWx2TjRGNU90bWk5SFBvSG9s?=
 =?utf-8?B?WjNvZ0tKeHpoVUUrVFpVMDlyYm00UmI1aDRFMnFPZk9YS1JWTUZ0SXo1cm14?=
 =?utf-8?B?VUJWWXlkbE1QZDc0T1VRa0pMemZaNW1vbXd0dUcvaDFCK3lBVGw3V1ExZ2px?=
 =?utf-8?B?QWlGSS9nQUNGT2pzR3R5SXZnVVlIWU56aG5xVE80NWw0NXdEZTA4Vnh5Snla?=
 =?utf-8?B?R2MrWGd3dENHTjI4STNsaytoQlFSaUtrWndzeTZTcFViRHlGQ25SVFVsUjdz?=
 =?utf-8?B?V1VpTlVGM3lSOEV3YktlSkU0czcwUDdjbk1pRlFPTmtFRkNmZU4zbG1reTJk?=
 =?utf-8?B?amdTZGVHaWJqUC9oWE1FSWlCaURYaGdzMHJsejUxM2ViOWNoREV1Q0tTRGFY?=
 =?utf-8?B?eGkybzV4RTRUSHdFTU1ZM1JEem1FMnFUQWJlTEhUWFJIb01nSGcxd2lpRXVP?=
 =?utf-8?B?VlA0QXIzSWZHNUNtSGlNeW9PckIxanFtNjdONCtTNW15d1RoVjRLQzRwUzhw?=
 =?utf-8?B?QkEwV05IL0tqZXBXVHZvU21GelAzdEVOUXduODVJZ20xempPVnZmd3h6MFV0?=
 =?utf-8?B?Tkh6OWdyWGUwQTZxMjJHYkNTTHNtT0ovQWpqcVVyODArNmpYenU1c29HMVVl?=
 =?utf-8?B?NlBTRm8yQ21wdkpJeE00dHk1V1lYczdCdDExSUpnOVV0aTBtVkdRVmNEV1VC?=
 =?utf-8?B?Um9LZ2pQcTF6WkxuWGUxRUI3VTlvMFcvMURLVXJEYTdVa2ZZQ1I5UFMyaVpy?=
 =?utf-8?B?RHNiN0hCb1JvM21PTUZiUXZmOThOd1hOck1pSXZoRXAxc2JrK1NoNXBtcVZW?=
 =?utf-8?B?YmkwK2Y4Nlk0V0xXZWtXVmtxZ09HZkZxMmM5ZzhYU1EwMlVaZGRHeVY4K3dY?=
 =?utf-8?B?TUg1elg0a1VFQ0RkVC9GSnNrbUYzN25kN2lPZjY4c0oyWkhDMTZVeGxFaUww?=
 =?utf-8?B?TUZMVlZIWnkyYmhTR3AvbnJhVVgwc0RnMUFqUmVvdElmVDFUcTdaS1JCMTYw?=
 =?utf-8?B?OTFLOE5JcXRwQ21RNTVLZktuR2lqdWV1UVJRL1lsUHJ3RzNBM0l0b1p1aXFI?=
 =?utf-8?B?b2MvMXM0ejVDWUhTTVc1enU2ckxKMmwyalZhTndvODV3RWJTQjBZTmpjQVJr?=
 =?utf-8?B?NW1BZ2VVZU5RZXZGNHlqMFlqNytZV2FQUmNPUDVJU0t4VFJmQ1V5eHYrSmlk?=
 =?utf-8?B?M3g2THNNWkVSbEcyd08weUFKeFlHOFkvZUFTRnlNa0dNNjdFNGgrb2tLb052?=
 =?utf-8?B?NEM3OE1xTFNBZmcyQnc0bmVpaWNCMVVTakhQbGozdFYvNEVBOGlsaDZYSUZV?=
 =?utf-8?B?MkdlOCtlVUlaWC8wblh3N05qbWl0cGhtMFpxZnNaMEYwZjZONnk5ak1VT010?=
 =?utf-8?B?WTdFSE1NL2tmZnpCUXc2amV2aU1VUmpmYzU2YU1DRUxnZFVTNFdvNDh2OEdL?=
 =?utf-8?B?TTUzclVzVUNuTVJjWGxsTno4ek1uUjRaYVVXMGpKdmdoU3ovR25EdGk1MlFC?=
 =?utf-8?Q?W2u3a5rBC6WNaxfNKSkqUsO/pqfBsAmUxYft4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVFBNlRaZWJLMzhoQUZlcjFwa2lkY09oWk9rcDVUR1g0MW5XQTV1aHh3UjI2?=
 =?utf-8?B?OHZqdlJTa0dTZ2h2bFJvczc1dGExM1ZYTlFva0xjUmFFbHdXWnZOM1I2Q0RY?=
 =?utf-8?B?TWxoajh2WHJNQ0hTQzhPZ0trNi9yaW5DWVFEK3pLdHhKa0wwU2FuRnYyU3Zv?=
 =?utf-8?B?OUxVaXAwK1JPVXcrYTRBbTRrYWZqOURwKzU5cTlNMGdoUkI5bXRaUTVIOWVH?=
 =?utf-8?B?bjl2ZXdDNnhtcnpDeTltVisyTlNXMVN1bktyV2NDanZvZjVFMnl1R0VPNm0w?=
 =?utf-8?B?ZFdOWmpPenNOcSsvZjFkNG1SS1lKejd4NXRDblYwa2VwR2ZUK3RpQnpFbUF0?=
 =?utf-8?B?OXhGK0ptUml1b0dTU2NSUG1wWWs0S0JWRExLV3RqUEFoZmMxay9zemxNM21i?=
 =?utf-8?B?NTNSd3Bsa0pnb25XeS9MNVBpZkMyWG9pZFoyWmY1bW5URlRGeFZuZTJJMXF0?=
 =?utf-8?B?SXBXcUhTZk51OWF6WkhVSUxXWUdxbHo3R2t6VWM5c3dmV0NsbUtRWEdwdTJM?=
 =?utf-8?B?V0IvYzVqdXZpaXAxeEdnemJyckZMeERCb3NReDZhcUFsd3p3bVI0UmdxQnVi?=
 =?utf-8?B?ZzAvNlFNQzcvbmVaeEZxNm5EV1pjMjVNSklEdHo4MU4rT1hHQUZ0T1psTk00?=
 =?utf-8?B?ZVY1K0R5Q29sTkRibEI3L0tZSmthT3BhL05ySVlvcUZkUm13ZWtiOW5DT1pY?=
 =?utf-8?B?dmdzVlNWRTZEVDU0bFBCUUMrZzJUNkQxbktXWG0vbDljTjdOdE5ob0R2T3Aw?=
 =?utf-8?B?b0dWYXBwdnA3TU1YV0lZYWhuVEtoVUcwams2ZFkxTE9VMjZibUo3bWFQc29L?=
 =?utf-8?B?RHA3RHNqTVJhTVhYZlQ5bHVDSmhXLy9wd3RuSnM4VzFrTFd0OUlKcm5sazg2?=
 =?utf-8?B?cmRzMkl4R2dncXRaSXQzYmp0K3ZCOHczYll2MEhxd0hJQWNVZHJWVktjdStS?=
 =?utf-8?B?NzlqalZVQ3pGS3BYVUVNaVFDMEg1Tk5TZk5HVzFyYWxtLzMxUzBjcWh6UWow?=
 =?utf-8?B?T1pHc3hhOFJneEl6YTNydzhKMTVoSTBJaTBTQ3VDQW8yMkEwditxd05adnll?=
 =?utf-8?B?cGtNckR1SkdEYUpWNlVvYWQ0Q2R4YnB3eFlTbVcyaFZOQlp1Ynk1S3dTTitB?=
 =?utf-8?B?UWVZcVNkYUtOY25wT2pmUEwxVXl3QmVyNktnZFBYK1dWVGExZkZHVndyYWMy?=
 =?utf-8?B?VnVPNFhkbFVmQ2JhYi80K09kRmtUNHBQd24vbXBUUmVaSEIvaENlTTFMZ3do?=
 =?utf-8?B?SlRRcUlidlU3c0xUaG1INWdENjl4bmdQZHFHZDJIaVRDMmU2d0toT1dXajEv?=
 =?utf-8?B?NlhBSUtEUXJBNUd1eG5kS0Z1ODgxbWVVU2dvYlJkOGRQRUNwZjRMZDZuU2Zu?=
 =?utf-8?B?OXpKRWg4N0RNbWJ4S3NIT3huM2NRVnhzMWJvVm11OHRaT3VGQVNpbnNycmlL?=
 =?utf-8?B?TXRqT1hpM0hHak1RZjlUUHB4R1lHbnEvbkszWHB2TFlFcnlvU3NGb29Bc3Ix?=
 =?utf-8?B?YWZ3STR2cUVtNGtBT2JPV21NbmN4WFhLMzZjUTIrUGplcFRKakpRdlovV1pN?=
 =?utf-8?B?K2sySWRMaWMwUWdTVzNITURsS2pYa2o1QmlaZHN0YWRvSUFNU2plVkN6Ry9E?=
 =?utf-8?B?MW5kcWY5dkQ1RWlwbHFya0xHK2t0V2M5UkVBdkxyVDRCamRpQXZINDFLdXFx?=
 =?utf-8?B?ZU9maW12WmJHZlZlajAyWnhidjFJRTl5MFBNVDJPaUtob241LzNkOUxpMlBn?=
 =?utf-8?B?bmJhalNONUIySVY1cmtScTFCSW13dDBnMHNKWVpDRHBaV3U1Zm1VdWpidDJk?=
 =?utf-8?B?N3lObEdCYUcxZ2ZQdGtVaUwyRWtDZ2FRT0I1SkNBMWI3YWd6VEZqMnpRejQx?=
 =?utf-8?B?SkdDTXJNMDIrZ3g4M1pEQkF1L0FBRDZaWFVFV3hweHBRWlZBZGdleUwxM014?=
 =?utf-8?B?Nk1FdnVCTkw3Q0VEWFZ4L0w1ZkxCYXRhN1AyU0ZjeWpPbUxMRkJEZEZKbjZo?=
 =?utf-8?B?czNZM0xqV2tiK2FuT1gyRkJKeG9ZcUoyUmx2NzdxcVM3VkdCWDdYa1JldUE3?=
 =?utf-8?B?RHBOdFUvQ29EVjl4ZkwyekhmdkhKR3VsOUZ3NjZBaHNQUkRoTkdQRTkwcENu?=
 =?utf-8?Q?PNls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e49370-54af-4d50-704d-08dcee7f7421
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:43:55.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5LsGah/L+c/6N3vXfXYxD+nmh7GmVXh0fXDPveK5XHDqZE8AqCIC6Q7ankRejN/p75DTtp2Mt7musmJW7rQmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10921

PiA+ID4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IDA3LzEzXSBuZXQ6IGZlYzogZmVjX3Byb2Jl
KCk6IHVwZGF0ZSBxdWlyazogYnJpbmcNCj4gSVJRcw0KPiA+ID4gaW4gY29ycmVjdCBvcmRlcg0K
PiA+ID4NCj4gPiA+IFdpdGggaS5NWDhNUSBhbmQgY29tcGF0aWJsZSBTb0NzLCB0aGUgb3JkZXIg
b2YgdGhlIElSUXMgaW4gdGhlIGRldmljZQ0KPiA+ID4gdHJlZSBpcyBub3Qgb3B0aW1hbC4gVGhl
IGRyaXZlciBleHBlY3RzIHRoZSBmaXJzdCB0aHJlZSBJUlFzIHRvIG1hdGNoDQo+ID4gPiB0aGVp
ciBjb3JyZXNwb25kaW5nIHF1ZXVlLCB3aGlsZSB0aGUgbGFzdCAoZm91cnRoKSBJUlEgaXMgdXNl
ZCBmb3IgdGhlDQo+ID4gPiBQUFM6DQo+ID4gPg0KPiA+ID4gLSAxc3QgSVJROiAiaW50MCI6IHF1
ZXVlMCArIG90aGVyIElSUXMNCj4gPiA+IC0gMm5kIElSUTogImludDEiOiBxdWV1ZTENCj4gPiA+
IC0gM3JkIElSUTogImludDIiOiBxdWV1ZTINCj4gPiA+IC0gNHRoIElSUTogInBwcyI6IHBwcw0K
PiA+ID4NCj4gPiA+IEhvd2V2ZXIsIHRoZSBpLk1YOE1RIGFuZCBjb21wYXRpYmxlIFNvQ3MgZG8g
bm90IHVzZSB0aGUNCj4gPiA+ICJpbnRlcnJ1cHQtbmFtZXMiIHByb3BlcnR5IGFuZCBzcGVjaWZ5
IHRoZSBJUlFzIGluIHRoZSB3cm9uZyBvcmRlcjoNCj4gPiA+DQo+ID4gPiAtIDFzdCBJUlE6IHF1
ZXVlMQ0KPiA+ID4gLSAybmQgSVJROiBxdWV1ZTINCj4gPiA+IC0gM3JkIElSUTogcXVldWUwICsg
b3RoZXIgSVJRcw0KPiA+ID4gLSA0dGggSVJROiBwcHMNCj4gPiA+DQo+ID4gPiBGaXJzdCByZW5h
bWUgdGhlIHF1aXJrIGZyb20gRkVDX1FVSVJLX1dBS0VVUF9GUk9NX0lOVDIgdG8NCj4gPiA+IEZF
Q19RVUlSS19JTlQyX0lTX01BSU5fSVJRLCB0byBiZXR0ZXIgcmVmbGVjdCBpdCdzIGZ1bmN0aW9u
YWxpdHkuDQo+ID4gPg0KPiA+ID4gSWYgdGhlIEZFQ19RVUlSS19JTlQyX0lTX01BSU5fSVJRIHF1
aXJrIGlzIGFjdGl2ZSwgcHV0IHRoZSBJUlFzIGJhY2sNCj4gPiA+IGluIHRoZSBjb3JyZWN0IG9y
ZGVyLCB0aGlzIGlzIGRvbmUgaW4gZmVjX3Byb2JlKCkuDQo+ID4gPg0KPiA+DQo+ID4gSSB0aGlu
ayBGRUNfUVVJUktfSU5UMl9JU19NQUlOX0lSUSBvciBGRUNfUVVJUktfV0FLRVVQX0ZST01fSU5U
Mg0KPiA+IGlzICpOTyogbmVlZGVkIGFueW1vcmUuIEFjdHVhbGx5LCBJTlQyIGlzIGFsc28gdGhl
IG1haW4gSVJRIGZvciBpLk1YOFFNDQo+IGFuZA0KPiA+IGl0cyBjb21wYXRpYmxlIFNvQ3MsIGJ1
dCBpLk1YOFFNIHVzZXMgYSBkaWZmZXJlbnQgc29sdXRpb24uIEkgZG9uJ3Qga25vdw0KPiB3aHkN
Cj4gPiB0aGVyZSBhcmUgdHdvIGRpZmZlcmVudCB3YXlzIG9mIGRvaW5nIGl0LCBhcyBJIGRvbid0
IGtub3cgdGhlIGhpc3RvcnkuIEJ1dCB5b3UNCj4gY2FuDQo+ID4gcmVmZXIgdG8gdGhlIHNvbHV0
aW9uIG9mIGkuTVg4UU0sIHdoaWNoIEkgdGhpbmsgaXMgbW9yZSBzdWl0YWJsZS4NCj4gPg0KPiA+
IFNlZSBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4LXNzLWNvbm4uZHRzaSwgdGhl
IElSUSAyNTggaXMNCj4gPiBwbGFjZWQgZmlyc3QuDQo+IA0KPiBZZXMsIHRoYXQgaXMgSU1ITyB0
aGUgY29ycmVjdCBkZXNjcmlwdGlvbiBvZiB0aGUgSVAgY29yZSwgYnV0IHRoZQ0KPiBpLk1YOE0v
Ti9RIERUUyBoYXZlIHRoZSB3cm9uZyBvcmRlciBvZiBJUlFzLiBBbmQgZm9yIGNvbXBhdGliaWxp
dHkNCj4gcmVhc29ucyAoZml4ZWQgRFRTIHdpdGggb2xkIGRyaXZlcikgaXQncyBJTUhPIG5vdCBw
b3NzaWJsZSB0byBjaGFuZ2UgdGhlDQo+IERUUy4NCj4gDQoNCkkgZG9uJ3QgdGhpbmsgaXQgaXMg
YSBjb3JyZWN0IGJlaGF2aW9yIGZvciBvbGQgZHJpdmVycyB0byB1c2UgbmV3IERUQnMgb3IgbmV3
DQpkcml2ZXJzIHRvIHVzZSBvbGQgRFRCcy4gTWF5YmUgeW91IGFyZSBjb3JyZWN0LCBGcmFuayBh
bHNvIGFza2VkIHRoZSBzYW1lDQpxdWVzdGlvbiwgbGV0J3Mgc2VlIGhvdyBGcmFuayByZXNwb25k
ZWQuDQoNCj4gPiBmZWMxOiBldGhlcm5ldEA1YjA0MDAwMCB7DQo+ID4gCQlyZWcgPSA8MHg1YjA0
MDAwMCAweDEwMDAwPjsNCj4gPiAJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyNTggSVJRX1RZUEVf
TEVWRUxfSElHSD4sDQo+ID4gCQkJICAgICA8R0lDX1NQSSAyNTYgSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQo+ID4gCQkJICAgICA8R0lDX1NQSSAyNTcgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4g
CQkJICAgICA8R0lDX1NQSSAyNTkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+IA0K

