Return-Path: <netdev+bounces-136356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B719A17EF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C681C21C68
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7D18E29;
	Thu, 17 Oct 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzo/qqQo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA2A2D;
	Thu, 17 Oct 2024 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128719; cv=fail; b=YHLg2CTpddhzfrJZ2qKcPX5QzkLvHhrvEeUJnVvuWKvjyKCwFCzy5Ureo6MyE8301psWn1E29ibqkKcpTFmmbgDARbeHdSOKOuV+HW2T0UJbY8wpEWBvDFogNXlKzTy+wtxJdTviFH2wakYfJzSOJ+xaZm1P46DtGVJEDmT8Z48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128719; c=relaxed/simple;
	bh=V0JqAnDp2NHlxoJT2hh2G030C6QF16XzZaZp/tCm/BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBUubX/Cm8jq1YwUG251cs2CGXJM1oYlw2mwVIe6zeDMPMIfFqHmFqrEnhqSeAQnaWtEh/H6gOOMnV/SEIGUGaHxXZV1ZFz/qUWcWAXU4pr8c1xHLrGNUCXPku6DtTD4FEbKSdTr18oRZ6/VOsyIXPK/CVK4V61fDHQVrGs1Eqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dzo/qqQo; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThK2yePK2+JLJSDCRvanvVhxHs/HQWvsMDKEo1tCozKIa749/xd9sERi0ff+SqUz6ScTHRowmN0f6/pz4BW8jzaCpV74ku2yEcxEysEoGtXpcsMA2pjxTIrqwb+ISivQeAdO0qvNtQXrNccJF5Zbnyy80vcLJUkOPDzvRKUlrXJSfqrDo9w0sMSTQZNFITzcQYo5brxlWLugzrVGU9MPsnBicLjC7X0B0xw4Ly6R2Y8x8wkUrUNPIaUMdQGjfFUFf56gKLXFrHRmJfEqBtbtVOHf0yx+jWHrUwyE+ayvVEsTVMXGm8Rs3mGuUaEI2gvSvIo/rvXq8RTfzKpbygb24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0JqAnDp2NHlxoJT2hh2G030C6QF16XzZaZp/tCm/BI=;
 b=Pe2nh9edUS88p/keeCfzOdCd0kGuenvrhRSdX5s1mf6dQj7lcX5BfegJHtEY0EuX5ap1Maz9yFYwQ0RPQX3GzlknA9nTivNTk8Mke664F9oahCuk7pwQ6z02JAiEaX50Wj3lGEusBwJ7o9XQYrSP598To4XDgtcmD9o7sMlPF1DNc58hxyHkHXYutgIWGxfzxzGxoSqoOGd5sWkLbdEr+9oEjtvPefrk8K8cYMz+SSz4eaPwQ5vBSZqcM5JAjvLorSxniwwHfZTQvwsA5JItIRPcVHYzi4xrmOXGhsaaWV7ZAxoidLwMemCk1qbjebO5KMOc/N/ugFz3S3FqMXvpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0JqAnDp2NHlxoJT2hh2G030C6QF16XzZaZp/tCm/BI=;
 b=dzo/qqQoG7p2ytDswXZvlpCZEd8HWoS+lU2PpEjFf1pH+kN0CV8ITn6EuoLfKA0D5Dsrnv3J49FQcIqRAuYWetp740F3czG/xo8bGH+bvLm5ZZGR4MunriRULjsRMUZxRZSY9oghSmiM2AQxHT0bko4hYWs2FqYGWhl09EEaX/6TuZoVg1wuOQ7I+hL/IqjGeR0R00d+CRqUC/aB9Z4ISGgHB8tEwMaRbOdDaZ5HF/iYQD6RaA29MWrgyCedx9aQo+lj/S/TuR+JNPIBEWlMlsvH6m666jkjYACsBluVsi/bQgqtaqqO499+f7RBOYY1ZrArzvYm5owcDQtYvw+pqA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10845.eurprd04.prod.outlook.com (2603:10a6:150:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:31:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 01:31:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 01/13] net: fec: fix typos found by codespell
Thread-Topic: [PATCH net-next 01/13] net: fec: fix typos found by codespell
Thread-Index: AQHbIBWvw9lkGA5l7UidDRBK6/tI9rKKKCqg
Date: Thu, 17 Oct 2024 01:31:50 +0000
Message-ID:
 <PAXPR04MB8510814D1AB70634E223887C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-1-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10845:EE_
x-ms-office365-filtering-correlation-id: 9e7dae0c-90e1-48f0-71a6-08dcee4b7944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzRyTkpxUEYyd09PMkV1RUViaGprb1RhWEp2THV1YU9VYWl2VS9OeTZzcHMr?=
 =?utf-8?B?a2FvSU5uTVM2OVozMmZVcWhLaC9BdkFhbHJScXZTNjFVclIvSmIzTlJjTjcr?=
 =?utf-8?B?THdkQmRzNmNjTTFZV2kxUkduTWlBSG1tazBKMTFrcW5rTldob0lWMytOWElG?=
 =?utf-8?B?QUpGdlU2SjZ3Z00veHFVbFdhdmwrcE51RjFSTm9nT3J1bjZ4WUxxOUJaT0ZM?=
 =?utf-8?B?WUFMWHdldjZzNmplaE1IUG9XR0Z4WlBnSkNPbThtRE92MHFkOFdNcmthWmdj?=
 =?utf-8?B?aENGMzViVUxlZVVpd3hFZWdxUUIrSDZHeDRydlczK0NFMk5MS0RnbkRrSFZw?=
 =?utf-8?B?bitOOUtIYm16WFBxRDZNQWdUcDZtdTdFYWhwRUxUaTQwQUVIc1VtajJZQmFy?=
 =?utf-8?B?SXdrUzZqaVNKdVdrdXJneWsvQmFIY2VGOUx1YS9EazJURDRFdGNHVktKM2dD?=
 =?utf-8?B?WnpKRFRKTWR2cTRseG5uMnYvUGExOHFwZEZsV1MvaUJoYkNaU3VXZHo2UmRq?=
 =?utf-8?B?LzRjU2tZUnZoZkozVko5eWxTR0VaYUEycjBzWEtZYUp5bjhHUkkzd2tQSHly?=
 =?utf-8?B?c0tSMXhMZC9zVjkwcTlXVEtLYXVodm9lTy9jUE5XWXFpSlUxM0xuRnRSdW0v?=
 =?utf-8?B?bjdMMWoxOGJXUjd1UllqNEZhL0xyaHptZ0ZxT1d2T0RLTFA5VWR2QnZwK3Ru?=
 =?utf-8?B?UkZKaHUwZlZ3STFFVnBQaWNBbFRVNWNLaDQzWVdHS21aSmphNURFcXBSeXla?=
 =?utf-8?B?NGZIWWVzc0lmRmI4eEVkUXo3MFc4dVJ1QWEyckQ4Y2lYdENkR29zbURkMHVI?=
 =?utf-8?B?NmxmN1pjOEJDTGRPak95TWlsWERUSHcxY2c2ZnZJZ05URVErVE1IUXAxYWhU?=
 =?utf-8?B?dVh1cFdBbWtYY2RHOVdGNld4VVNqNFNGckhvOW9VV3YxazFkc2E2c0tMcm9t?=
 =?utf-8?B?bThoVm1LMWJEeW11L2EzRGdRM2d0NDIxcjJEV3c4SjJVQzBiR0YyeGR2VTJG?=
 =?utf-8?B?c2Vvd2U5MjY0YVp5Z3M2aStlSXYrNHJEZEEwekNIVEZmL21veGlhc3ZMdHlX?=
 =?utf-8?B?RGJFcHdDMjBBRlUxbDB6cVB0WnNZWFNhUWQwaEpxd3lHaHZsVVUyT0RQUHVE?=
 =?utf-8?B?Wk1MMk40MSs1M2dtZjZQR2IvTmFWck1mVGRBVkNRa3JyT0wwRjFmZUE3amR2?=
 =?utf-8?B?S2kzV0p4WVpJOUsyTExqU01KSU9vWFVKQjNHVngyUXQwY2pBK3YySjRrbFlP?=
 =?utf-8?B?SzdUNEY3dmdXeldpczcrN3Z3RGwxWlYzelEycDZUOU42M2NYemZXZ2YrczJv?=
 =?utf-8?B?OUVONldFWjNoSE4xQk42YVpmMXc2Q3diS1YxWE51V2tZZmxnK0w3cGtleTYx?=
 =?utf-8?B?dnhhVkxWeVczVmdMK2RmMVg1S3VKS2M2VVZlQitSS09oNllFY2JqR29tQzYx?=
 =?utf-8?B?YXJvSzhGamxwcWxIQnV1UGJkSE9OZ3RwbEEyRklkYVE2QTA5aWoxdTRLOTBW?=
 =?utf-8?B?NWIwa290azNDWUpVN0NXVmM2elpacDZrRmpRRWVpRktBcUdoSUppUWhvU3Ja?=
 =?utf-8?B?TEEzMnZJY1JXSE1uL3phclRLVEVLa3lpUVBudFBlQ0NZYXhmWnRYa05WZlpJ?=
 =?utf-8?B?cTlzenF6aDRNWkc0R0RvZFdxRzAxSFU3UHlFZmFnQmQvSmV2Q3pwcWZuTFVQ?=
 =?utf-8?B?ZXJxLys3R0pZMldNVFlHV3lReWMxUTM4SHBGN3NRTkZOeisrY25IbFYwWVMz?=
 =?utf-8?B?N05SajV5Zk9hWGFFMU93S3NQMllmUFA0ajBlYmVhMFNKUGN5bjFORHVrL280?=
 =?utf-8?Q?0sgkGAB+K2xfYppFz4eg/Nh1CYZneBhPPUI3Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzdPL3YxUmM3RW40ZkdTOEcvRjdzUDVNVUFKNnRUK0sxWGEvakVGa2hkMytN?=
 =?utf-8?B?UW9qRXk1L0NyNVdBRXdwUjZjc09YVENYNTNPdE1UV1I2aTFUb0h6aTdXOHR5?=
 =?utf-8?B?R0djTEUzODBDMHNrSEkvc0MyUmt0bTgreEUzckZzYUh6cGc2K2lyVERRaUZr?=
 =?utf-8?B?ZWM3RXZqMHd4VVJ2dHNGanhxbURra2x1V21iZFpjbG1ud1hiZ2lLa0tCcTZ4?=
 =?utf-8?B?eGpYcm1WSFhLdDg0YTVObEVMLzFFRTJZcFpqSW9QaHk3QmZzQ2JDUjcrM2lG?=
 =?utf-8?B?amFHekFya3NlUVgvYU5zNktUMTE2clpTNlNKK2VDTXNjWE5GUnQ3S2RRM2F4?=
 =?utf-8?B?Z1lNdmRKTUVLOGtCVkZVQTU5K2RQNXZtRS9tYm5CS01tWkRoS25DU084TW93?=
 =?utf-8?B?dzJCY2Z5SldrMDlIZEg1b1VPZHFCV2xqSnptV29jY0VJSWZrcnM0WlpvRUVh?=
 =?utf-8?B?NEl6RzlycUI4RGY1c0RNTjBaSDVEMURmRHNtTVhoQW0wVTV2NGFBTXB3anRL?=
 =?utf-8?B?bzZNNlBlV3RBZ3FhdUtJR2VzSVYyeERSemZheVptTGFUUkRaaTEyejZaejV6?=
 =?utf-8?B?ZEJkaFp1NHRQMmFvanA4KzNBSDhjZm82bk52dkpIR2ZLcTlaZHIrQ0FtVmM2?=
 =?utf-8?B?THJUaUJoVUkyaXFYRmxTd1lGQk9lak8wVC8vSWJKNmk3TTJpTXJpQ21iMnRa?=
 =?utf-8?B?YTFBekFWM0JpQ3haSVNaWkRlemtSRUltMzc5b1NBMHhJSnl4NjE4RU1RaU5z?=
 =?utf-8?B?NCszYVFBUDJMY3Q0WVJINzgyYS9qNUdldUdUZFg3MlZSbUJxMndKa1VqY0FR?=
 =?utf-8?B?YzA4WGtkazVuME5NSjBlMDhwTnUxR0Y0Mmd2dzgzSkNQM1gySEl3R1BZQlRi?=
 =?utf-8?B?emwvWjVRVUFHTzRSZnZ5TmRXNXpFbEhrb1VpZktaQk9SUUd0SVUvTEo5OExH?=
 =?utf-8?B?bktkY2xzditxYU12RzNRVUltL0N0bXNwS1Vvbys2VjN2SnlMSGlKTFVGYjQy?=
 =?utf-8?B?cE1oaDN5MDBHSWI4UWJFREl3OU8vQ1pEcytYMGI0TFBvbWx5RzlGQ2dCZ1A4?=
 =?utf-8?B?MFV4cDI3WlZLT3Z2Tnpza1dtRmxYZU41NVN3UFhYVm84cjM5aS9ZcDYxUGFk?=
 =?utf-8?B?Y1RnNEVZUnlrMUFRU3NLakcvMWZXRTdEaWJqQ0RIa1JvSEJmbkd5d2MyN3I5?=
 =?utf-8?B?VmFYSkJGTWxYM24xYitwbDVpbENqcHhGRkdkejI4NFgwVlhpeTJ3UjBYQmg4?=
 =?utf-8?B?d1huRzc2R1lzTlFQTzEvMk5nSjVGMm1uZFJWRk5wVEtrWWdqbks5WGIxZkU3?=
 =?utf-8?B?aWU1VU5oZVp3NG5abGE1MjhDcEMwODdTYldDbm5xWFJVTE01UnJYSFhiUVY0?=
 =?utf-8?B?bW8vN3dHNFNLSThCT2ZTT0tZZ2Z5WUpWcnpPWFdzcENsZGx4ZXo0TVpZeWNP?=
 =?utf-8?B?ZEN2Q2V2WUt0U1FHSHM0azRmT2pzMXlPR3JLR0JQUFBhSVVwVFZjb1labEtw?=
 =?utf-8?B?M2R5dTJiVFdLc0pIT2x2OXp4QldDYlhIYzhjaElnS00wUStwVHRndmRkS01w?=
 =?utf-8?B?YUVaWmNFdTVrTTZCd04rUkN6Mi9tbytDWFE1YmV6ZG41OWJicUtRRnNodzRH?=
 =?utf-8?B?c21pd1ZWQ0wrQllQQ2FveXJONWxYc0xRL3lBNUc4d0QwZ2xLSHNrODVETE5a?=
 =?utf-8?B?N0d4TkovQ2hPZ1c5U28yU2drekFlTEFKWndVWHNzTTd6RytjbDNWWExGTE9P?=
 =?utf-8?B?U3pMYU5ZWUx3UTZscVIzMy9sVnZ1NEQzQ0lnTmprNHR4T0VUTzRBVkdMd1ZS?=
 =?utf-8?B?Nm5Wck9Cb3JWcFA3MGVCdEN6UTZoWnBVVjl3VWdrdGpGMWY3RFhVVDNrZjFa?=
 =?utf-8?B?alovcnZpbW1teElBNlVhMlFoRUkxOXZpanB0d2pldy9RK0FtaHZCQ2NQVGdH?=
 =?utf-8?B?d05Dd2c1VDhNdnk4UEJ2QzF0QW1XOGdJS2NTVzRPYXhxSm9EaGphNzZBL3Vr?=
 =?utf-8?B?ZHVnVkxCb1k5MjJPRDJjemtaYWdwOFlmNFdOVEpEWFhZaUdrMStHck9vQ0R4?=
 =?utf-8?B?d2ZCOUhBMENseVZkL1BmNjRaSkZid3oxeWxlcDJLZVkxaTNTaUtCTXAyTWoz?=
 =?utf-8?Q?paSI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7dae0c-90e1-48f0-71a6-08dcee4b7944
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:31:50.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb3dnKjMyDFOmYG1e9RDMTi3nbwf0Sxv+c9PKYMe6x4BZSu6rvKE63gMbjted/+q1Z+YWGpfYZqMDJ8k5UWlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10845

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwMS8xM10gbmV0OiBmZWM6IGZpeCB0eXBvcyBmb3VuZCBieSBj
b2Rlc3BlbGwNCj4gDQo+IGNvZGVzcGVsbCBoYXMgZm91bmQgc29tZSB0eXBvcyBpbiB0aGUgY29t
bWVudHMsIGZpeCB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYyBLbGVpbmUtQnVkZGUg
PG1rbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjLmggICAgIHwgOCArKysrLS0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19wdHAuYyB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlYy5oDQo+IGluZGV4DQo+IDFjY2EwNDI1ZDQ5Mzk3YmJkYjk3ZjJjMDU4YmQ3NTlmOWU2MDJm
MTcuLjc3YzJhMDhkMjM1NDJhY2NkYjg1YjM3DQo+IGE2Zjg2ODQ3ZDllYjU2YTdhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+IEBAIC0xMTUsNyArMTE1LDcgQEAN
Cj4gICNkZWZpbmUgSUVFRV9UX01DT0wJCTB4MjU0IC8qIEZyYW1lcyB0eCdkIHdpdGggbXVsdGlw
bGUgY29sbGlzaW9uICovDQo+ICAjZGVmaW5lIElFRUVfVF9ERUYJCTB4MjU4IC8qIEZyYW1lcyB0
eCdkIGFmdGVyIGRlZmVycmFsIGRlbGF5ICovDQo+ICAjZGVmaW5lIElFRUVfVF9MQ09MCQkweDI1
YyAvKiBGcmFtZXMgdHgnZCB3aXRoIGxhdGUgY29sbGlzaW9uICovDQo+IC0jZGVmaW5lIElFRUVf
VF9FWENPTAkJMHgyNjAgLyogRnJhbWVzIHR4J2Qgd2l0aCBleGNlc3YgY29sbGlzaW9ucyAqLw0K
PiArI2RlZmluZSBJRUVFX1RfRVhDT0wJCTB4MjYwIC8qIEZyYW1lcyB0eCdkIHdpdGggZXhjZXNz
aXZlIGNvbGxpc2lvbnMgKi8NCj4gICNkZWZpbmUgSUVFRV9UX01BQ0VSUgkJMHgyNjQgLyogRnJh
bWVzIHR4J2Qgd2l0aCBUWCBGSUZPIHVuZGVycnVuDQo+ICovDQo+ICAjZGVmaW5lIElFRUVfVF9D
U0VSUgkJMHgyNjggLyogRnJhbWVzIHR4J2Qgd2l0aCBjYXJyaWVyIHNlbnNlIGVyciAqLw0KPiAg
I2RlZmluZSBJRUVFX1RfU1FFCQkweDI2YyAvKiBGcmFtZXMgdHgnZCB3aXRoIFNRRSBlcnIgKi8N
Cj4gQEAgLTM0Miw3ICszNDIsNyBAQCBzdHJ1Y3QgYnVmZGVzY19leCB7DQo+ICAjZGVmaW5lIEZF
Q19UWF9CRF9GVFlQRShYKQkoKChYKSAmIDB4ZikgPDwgMjApDQo+IA0KPiAgLyogVGhlIG51bWJl
ciBvZiBUeCBhbmQgUnggYnVmZmVycy4gIFRoZXNlIGFyZSBhbGxvY2F0ZWQgZnJvbSB0aGUgcGFn
ZQ0KPiAtICogcG9vbC4gIFRoZSBjb2RlIG1heSBhc3N1bWUgdGhlc2UgYXJlIHBvd2VyIG9mIHR3
bywgc28gaXQgaXQgYmVzdA0KPiArICogcG9vbC4gIFRoZSBjb2RlIG1heSBhc3N1bWUgdGhlc2Ug
YXJlIHBvd2VyIG9mIHR3bywgc28gaXQgaXMgYmVzdA0KPiAgICogdG8ga2VlcCB0aGVtIHRoYXQg
c2l6ZS4NCj4gICAqIFdlIGRvbid0IG5lZWQgdG8gYWxsb2NhdGUgcGFnZXMgZm9yIHRoZSB0cmFu
c21pdHRlci4gIFdlIGp1c3QgdXNlDQo+ICAgKiB0aGUgc2tidWZmZXIgZGlyZWN0bHkuDQo+IEBA
IC00NjAsNyArNDYwLDcgQEAgc3RydWN0IGJ1ZmRlc2NfZXggew0KPiAgI2RlZmluZSBGRUNfUVVJ
UktfU0lOR0xFX01ESU8JCSgxIDw8IDExKQ0KPiAgLyogQ29udHJvbGxlciBzdXBwb3J0cyBSQUND
IHJlZ2lzdGVyICovDQo+ICAjZGVmaW5lIEZFQ19RVUlSS19IQVNfUkFDQwkJKDEgPDwgMTIpDQo+
IC0vKiBDb250cm9sbGVyIHN1cHBvcnRzIGludGVycnVwdCBjb2FsZXNjICovDQo+ICsvKiBDb250
cm9sbGVyIHN1cHBvcnRzIGludGVycnVwdCBjb2FsZXNjZSAqLw0KPiAgI2RlZmluZSBGRUNfUVVJ
UktfSEFTX0NPQUxFU0NFCQkoMSA8PCAxMykNCj4gIC8qIEludGVycnVwdCBkb2Vzbid0IHdha2Ug
Q1BVIGZyb20gZGVlcCBpZGxlICovDQo+ICAjZGVmaW5lIEZFQ19RVUlSS19FUlIwMDY2ODcJCSgx
IDw8IDE0KQ0KPiBAQCAtNDk1LDcgKzQ5NSw3IEBAIHN0cnVjdCBidWZkZXNjX2V4IHsNCj4gICAq
Lw0KPiAgI2RlZmluZSBGRUNfUVVJUktfSEFTX0VFRQkJKDEgPDwgMjApDQo+IA0KPiAtLyogaS5N
WDhRTSBFTkVUIElQIHZlcnNpb24gYWRkIG5ldyBmZXR1cmUgdG8gZ2VuZXJhdGUgZGVsYXllZCBU
WEMvUlhDDQo+ICsvKiBpLk1YOFFNIEVORVQgSVAgdmVyc2lvbiBhZGQgbmV3IGZlYXR1cmUgdG8g
Z2VuZXJhdGUgZGVsYXllZCBUWEMvUlhDDQo+ICAgKiBhcyBhbiBhbHRlcm5hdGl2ZSBvcHRpb24g
dG8gbWFrZSBzdXJlIGl0IHdvcmtzIHdlbGwgd2l0aCB2YXJpb3VzIFBIWXMuDQo+ICAgKiBGb3Ig
dGhlIGltcGxlbWVudGF0aW9uIG9mIGRlbGF5ZWQgY2xvY2ssIEVORVQgdGFrZXMgc3luY2hyb25p
emVkDQo+IDI1ME1Ieg0KPiAgICogY2xvY2tzIHRvIGdlbmVyYXRlIDJucyBkZWxheS4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IGluZGV4DQo+IDdmNmI1
NzQzMjA3MTY2N2U4NTUzMzYzZjdjOGMyMTE5OGYzOGY1MzAuLjg3MjJmNjIzZDllNDdlMzg1NDM5
ZjFjDQo+IGVlOGM2NzdlMmI5NWIyMzZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfcHRwLmMNCj4gQEAgLTExOCw3ICsxMTgsNyBAQCBzdGF0aWMgdTY0IGZlY19w
dHBfcmVhZChjb25zdCBzdHJ1Y3QgY3ljbGVjb3VudGVyICpjYykNCj4gICAqIEBmZXA6IHRoZSBm
ZWNfZW5ldF9wcml2YXRlIHN0cnVjdHVyZSBoYW5kbGUNCj4gICAqIEBlbmFibGU6IGVuYWJsZSB0
aGUgY2hhbm5lbCBwcHMgb3V0cHV0DQo+ICAgKg0KPiAtICogVGhpcyBmdW5jdGlvbiBlbmJsZSB0
aGUgUFBTIG91cHV0IG9uIHRoZSB0aW1lciBjaGFubmVsLg0KPiArICogVGhpcyBmdW5jdGlvbiBl
bmFibGUgdGhlIFBQUyBvdXRwdXQgb24gdGhlIHRpbWVyIGNoYW5uZWwuDQo+ICAgKi8NCj4gIHN0
YXRpYyBpbnQgZmVjX3B0cF9lbmFibGVfcHBzKHN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAs
IHVpbnQgZW5hYmxlKQ0KPiB7IEBAIC0xNzMsNyArMTczLDcgQEAgc3RhdGljIGludCBmZWNfcHRw
X2VuYWJsZV9wcHMoc3RydWN0DQo+IGZlY19lbmV0X3ByaXZhdGUgKmZlcCwgdWludCBlbmFibGUp
DQo+ICAJCSAqIHZlcnkgY2xvc2UgdG8gdGhlIHNlY29uZCBwb2ludCwgd2hpY2ggbWVhbnMgTlNF
Q19QRVJfU0VDDQo+ICAJCSAqIC0gdHMudHZfbnNlYyBpcyBjbG9zZSB0byBiZSB6ZXJvKEZvciBl
eGFtcGxlIDIwbnMpOyBTaW5jZSB0aGUgdGltZXINCj4gIAkJICogaXMgc3RpbGwgcnVubmluZyB3
aGVuIHdlIGNhbGN1bGF0ZSB0aGUgZmlyc3QgY29tcGFyZSBldmVudCwgaXQgaXMNCj4gLQkJICog
cG9zc2libGUgdGhhdCB0aGUgcmVtYWluaW5nIG5hbm9zZW9uZHMgcnVuIG91dCBiZWZvcmUgdGhl
DQo+IGNvbXBhcmUNCj4gKwkJICogcG9zc2libGUgdGhhdCB0aGUgcmVtYWluaW5nIG5hbm9zZWNv
bmRzIHJ1biBvdXQgYmVmb3JlIHRoZQ0KPiBjb21wYXJlDQo+ICAJCSAqIGNvdW50ZXIgaXMgY2Fs
Y3VsYXRlZCBhbmQgd3JpdHRlbiBpbnRvIFRDQ1IgcmVnaXN0ZXIuIFRvIGF2b2lkDQo+ICAJCSAq
IHRoaXMgcG9zc2liaWxpdHksIHdlIHdpbGwgc2V0IHRoZSBjb21wYXJlIGV2ZW50IHRvIGJlIHRo
ZSBuZXh0DQo+ICAJCSAqIG9mIG5leHQgc2Vjb25kLiBUaGUgY3VycmVudCBzZXR0aW5nIGlzIDMx
LWJpdCB0aW1lciBhbmQgd3JhcA0KPiANCj4gLS0NCj4gMi40NS4yDQo+IA0KDQpJdCBsb29rcyBn
b29kIHRvIG1lLCB0aGFua3MuDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT4NCg==

