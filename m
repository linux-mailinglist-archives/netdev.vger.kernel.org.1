Return-Path: <netdev+bounces-143732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A29C3E4C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2DA1F20F4A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D089183CA2;
	Mon, 11 Nov 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iw6Uzzfw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BC55C29;
	Mon, 11 Nov 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327375; cv=fail; b=tKRo3ByQe2QJuKI0tz4tsaFRnkjsE4D5psOHenBAjf3K5zamDvsctrq+gbrr7ZTaAjOT+sC85Ad1fIPn4qPI9Lzue/3WgXv9FZ1KiS0xZqE2X4fcKqEKkKJ6idlNc/D22QF7Mi34hFgVIw4MQTWbadz9bzFrSwO58LS8rPHlKMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327375; c=relaxed/simple;
	bh=QdErGfrGHqRM9czcYeXqxp/D2OtkhUiVawk5naSVuoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C+METCMZ6989iK8duR/mTuWGUlGZM3G2mRTtfA54QiBrguD5KIY928KeJvClUj1kEa57angAs4uJOiYjw4pVMFx6kT5fRW0uzr7kuTyXegHpmsu51gLHD9KrVVQGZpKntS5pEmnZAsfxkytP2dxGb1BGKGz3z0z3V03o/omPNos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iw6Uzzfw; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Z6V/9WMZr7+AJ7lsnYHqwiVS79iRUTK9skANeuSQWE+3YMmpUOBLvPdnxpp3e0GxrBVjl0JdvEP94guUif8qEYeKB4m6C+rWS8nbbIJ1HwVL7EpS4aJmuGlelJCdwFd1S3sggByV6XQEK/gDCLsPT85CWJDPat7EnGI+aDaiv0Rl7PgmB+/coI4/VRtC/Rt1xfomuuzrfdVLuztY+vgApIxYzs+4bSVCul4JM6Gyy/+JipGClTznuMx0bnFG4lvbvlL+yn6+76gGyrq3Vrf8MzWxUev6RJq1JXEqf0fDUi1L6QmpGDX5t2LUs3GHwUCYpGAFmW3xjF5fGovWuDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdErGfrGHqRM9czcYeXqxp/D2OtkhUiVawk5naSVuoc=;
 b=XZV51CFQWmCE0zoaJQNNJLl+VVCLypetRkTFD9gTCECUlhTRCwdLqaGSt+2HMSyz98nxSGIagFL3yZRZFH9G4QGqUPYrQ9/1rIR7BlBAKM8hEtKs6W1CZk0lt0zBQsYbu8QHJzV9hOBwDSBOo1y8NTRo2sR3jFY86PkyxK6NijztAUpVehQR5ZTk5XA5/Q34yD9D4xB3FoKZ7qBykzrpd03jfU/k6ipoNBLftllyKFuIBcIIkZ7//FgMMhwwB/4Qbi7l7f1dTOFqHlTu0Y6b4GDp9d+Zy/mv4d/pAEHKNY5UzyTX0LqPpvTugckVudeGu/jZ3xIPykwsRUrpxPKn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdErGfrGHqRM9czcYeXqxp/D2OtkhUiVawk5naSVuoc=;
 b=Iw6Uzzfw/eGUvPY05fndqsapZv+ejxUZaUapn72g1OcBy8VcICAszEtIHrZ1bC2HhgUKkOwImRTJT0eEdW/vtEG0EplvRFeiRidP2uBdYwm9yXb55al+ftZjTIeXcFDKyO8huTlOxfpSx/W0iHruIalQZTSL9M0qVrFhwFF5kMPopPjbTFDBqF3QP3Y6HDQij5ILCJzHnmMjnqjK/8Y8q+1CfIpm3C8r47b/TmA4v76ZT0NAPm90wGoBUUcNK+WtNHV3fnN1y24q4HoSXWb8ElPcqMN6qbutNkSqtf3kY7qE4pp+JW2Jbkp8fItkwbWMYah3swCE4EXcaDLVLJc+kQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10265.eurprd04.prod.outlook.com (2603:10a6:800:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 12:16:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 12:16:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96Mok4WQFp4gEq5F3KBlp1btLKxrksAgAAekwCAACwL8A==
Date: Mon, 11 Nov 2024 12:16:09 +0000
Message-ID:
 <PAXPR04MB85107F97E4037BAF796C69E588582@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10265:EE_
x-ms-office365-filtering-correlation-id: b0728287-ce8a-4570-3a03-08dd024aa061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MWVCaFFzMkdyWFRJcVN0bU1GcTlWNmlVMlNiOTQ3UTlkd1RGVkpFK0VTeWpp?=
 =?gb2312?B?ZHdmMHJwdytZbUVSTXBKbVV5THpYaTdETTJMMTBpN2xpOXYyWitJVGdsNUwv?=
 =?gb2312?B?ZisvWWRwQlQyT2JrREZ2K0doZ0RsWXpnWEppWEtobkNwcVhZMGR0ZHhQeDhE?=
 =?gb2312?B?UTF5MkpqT295QkN2OTU2cU8xOE5kRmJSdzdIZ3VrOU9BQ28xY2ZERWFoQkZn?=
 =?gb2312?B?TngyditJRlVFWnFyUHd5R3h3MlFUdnNkbktoN2s0T1FmMGZjOWdLT2VvejdR?=
 =?gb2312?B?NnV1b1phT1RpOEJta1E0YmUwRDZhV2FaQ0lZUGZINGY5bldvVDk2TkdZcmFs?=
 =?gb2312?B?UzJSeGFQdERDTW5ETE5SbDRCck0reXdJaTI0MTRwejVpRVVSb3hBWGtCY2RP?=
 =?gb2312?B?ZXdlRW5ZVlQrby9qZ3F5VkVsOUsrWlVTYXNuTUUxbGRHU1BTdkVvY1RoU3RV?=
 =?gb2312?B?RmpMZXBFU04zZzlTZWZRUElrbGRJYzAvR3RYeWNMVjFTNUpzZmpjNDJZRm00?=
 =?gb2312?B?OEliUlhqcng2NHlsM1V6cktoaFFEQ3VpMjI5V25FWVdYRmZBSnBhaG9JOThs?=
 =?gb2312?B?T0ZEN1FWcHVjYm8zZDJ2MGFoV2hCdHg3VkxZcG9FTW9pUGtOTDBKRis0aURJ?=
 =?gb2312?B?ZE9pVUlGV0pOOEF6dVVDWVNpbW1IblRsWXZMSDFKNUw2a2tNaUJIMUFwNU43?=
 =?gb2312?B?dVZSTnhjcEZhQU9KNjZwa3lPV1RKTzBKaXk4eWpEdTFVZDFFcUdZSGo1cno3?=
 =?gb2312?B?MXA3RGMxRENkR0NQZ0ZWOFBWRXlkWDZQMVU2NTNMeGZYTEZVc3lhUkF5TEk4?=
 =?gb2312?B?S09yTDMwdDh5ejdWY0N5MGp0NzdiaytRVDk1Q0VDT1F4K3FyeXBRZmo1azU2?=
 =?gb2312?B?SVhZSWd0RW8yQUF1dFYvSlNzdndEZnMraWJTcTNrWTczOVIyMkNQWFJZTVJZ?=
 =?gb2312?B?cnhENTB3bzAveFJ2SUpJQzg5Vk1rTWtFUWVEa1plekU3ekwvdkIrK1EwY0lL?=
 =?gb2312?B?bUtZZGovM0dGWHhrOU5najJOWmFWQ3Qrd2xMbldpWHlSeWYzUXBZOXJFQ2JV?=
 =?gb2312?B?aGh1RHpEcVN1UW5zWWsrbDhUeXB2NzQ1R0VZTTczNXNRei85RTkyWEM4ei9s?=
 =?gb2312?B?MlA4OVE3bGNEd1VyL2h0RnpDTGRFRDNBQzM0Skd4b1hEcDg2T1NzakxDbWNn?=
 =?gb2312?B?S1dBWDR1SzhoZ1ZKalByWi9QTWN6T1ZrL05TRXZBYmZRZitLNk1USG5VREhP?=
 =?gb2312?B?NFBpaGZwMlNJMmZONzRqSkFnRzBDYTBid0ZYZTd6RVFTYzZBZ2RydG5zRnFK?=
 =?gb2312?B?M0xYTFdWTWphcUh3UmxUaklyUDZyK3NKTDJWNGJHSVpoWlQwN0lFSU1oQjNz?=
 =?gb2312?B?MStRQmV4ek9aUWFEZnhWMnJlWkorZndLZldWdmIwVGhENzdmZUVCVHE2VjF3?=
 =?gb2312?B?ek1DTm9xU0dPM1lENEZxL2dOakVNSkI4OGhReUZqYnhGd29YSk92QVlZRjJu?=
 =?gb2312?B?dERkcEJEVHdnNURPLzdIMnV2dDVYanpyV0oxcHk4MDg4RUJ1TFIrcDVVdElm?=
 =?gb2312?B?M3BVdTRROXhUODlqREZURjRvbklWMCtDZmNQOXJsYlRJb2xtUmNTT3g2OEZj?=
 =?gb2312?B?ZHc2S1NlUWZIQzkyRVVpbXJJU29MRy9HRnBCRDdqb1NzaXd0dkpETGZ5MWls?=
 =?gb2312?B?S3ZVWk9yclRiYzUzeFNWSEVYd1V0NWJBYlQ4LzdhZ29aWnlaaTBkQ0IvUHZZ?=
 =?gb2312?B?YWRsRVNxWkNMTjRXdHJJUjhYT1VFME0yQ2ZiUEdXa2lIc2kyMmhRZDZFNDRZ?=
 =?gb2312?Q?nP/63q6TCr5IZXe8PbonuhI9A0YXHniOzutUo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?a0dWWEdBR2RlbFVIV3pYaDZLUm5HQzJJdm9lOTAwbURDZHFSSGtVaDhKdFZU?=
 =?gb2312?B?U0xEQjZPdm4yRTJzeldBQi9qQVVDak9oZGFmSGJpa2IyREMrM3hteWx1N3hP?=
 =?gb2312?B?K0JOZVd0MkI3djJTVHBhS1dzQUhjUFEyL2VhR1liWkFkbE5VMURzUlRZQVp4?=
 =?gb2312?B?ZlRYUXhwemFzNGVsMy9OWjd3L2J3dS9YVmpvLzI1VWRXUExOT1Y4c0ZEY0Jv?=
 =?gb2312?B?dWFyU0RzS2VScndtbzlBaThOSHpma1ZNUmRQMjUwRWFaVjRoemwwNnVyZVFi?=
 =?gb2312?B?RWxxNVRxQzVmWG5YYnhaTWIxL0E2Y1h5TWhlUngvTUdjanQvT0wzSzlSWVVJ?=
 =?gb2312?B?b1ByZUczeVE1M0FZVnc3cktsaG5vNUovZFJmVlFZN0pGUUVRb0tyK3dNUnZH?=
 =?gb2312?B?dTBCZy8yR0E3NDF2Mm5jSzRNRWFQcTVhM05HZmw3dGNMZFZCcDFid2ZpTXF5?=
 =?gb2312?B?bWdoUXpyQlZLdFNVb29SSWlmMElhNkkvcytRL0pQL1FPdjZUb3VQNC9CSWh0?=
 =?gb2312?B?R2lHeVgzSWxkbUdsM1ptSC84dXZualpFVmc0QTgvVzVUQ2lVaHN6anB4T1Zi?=
 =?gb2312?B?NGlaaTh1YXFON1NTQ21iS3VOeEQ5VjMxVHB2Wk1tQllDaENhUnl2ZklFNnhV?=
 =?gb2312?B?RDFzYkxxc3RqYS9kZjhuSmprYlFwV1dmdGtwYjBzdW5mQjAwdGV5YStkQnh3?=
 =?gb2312?B?akUxMUREQWNKa1NlUmNmbkVmMU4yK1RTZHhMZVJxRHpWYlFVUU1GK2ZIVVFv?=
 =?gb2312?B?L1VqME5hMlAvdGxNU0Q0SHhWWGZ1Unphd1o3NDNpSDZ5aDFuek5zMHA2UjV2?=
 =?gb2312?B?S3VCZDQ5ZzJic2c4ekVseC9hR1pBTksyU2wvMFNIRk1yY2QvZUpPM2gyZWIx?=
 =?gb2312?B?UWNBNHd3UGtuWlJhRnRTZlJ5VEdrNWczdmU1L09FM2R2L3VxZDNOYm1Oa3Vt?=
 =?gb2312?B?cnBKclhLUnFSM0hKUTB2ekh4NlpZd0s3NExnYlp6V1ZIYll0MGs2U0FwaXhQ?=
 =?gb2312?B?aHptcmhLUWR0cERYYWlNZFUvdk9IQU91Tm1qVWJaeXpTMmVoUlhIMHZEU2hV?=
 =?gb2312?B?dnN0TGJ2MTZ5cTUvN20zYVRsY3VPZmd0VzIxYmVJUXRWeFRLdTVlakxMcXNR?=
 =?gb2312?B?V2YxRUd5M3RDKzY3Yk4wMU8zMzFtNjR6NDBHaHpjcEJBVHp2TlZtL1JQSCtY?=
 =?gb2312?B?QWdIdndMS3lIdWNWRFZhUjJlWHlLVHpNK01BbnNvSEIrSG5waHJVcWxQMVJK?=
 =?gb2312?B?Q3BJSGcwdDlaRVNLcWdRNWZVdEo3aTJYNjJGMWNGZ3JPelkwZmN6OVpZVGhj?=
 =?gb2312?B?OEdXRytXZSsxKzI1QmNldnFLM1BvRTZrNEhhbmlsODVNYzFLdUloaHBxTEhr?=
 =?gb2312?B?TE81cHV3MDB5YmVQcno4NkUxczRGeVcrZnlnV3h1dVllOTJPVUlTMGR3RXhZ?=
 =?gb2312?B?RVAyVWJXOFBrQ3YyZUJ2SjE0d2NTUEFNRTlxLzhRTFBGWk5Td01VLzZub3Rz?=
 =?gb2312?B?U3hHNXlld2JkTmdoS0RuNlQrMGVWOHJwcE1rTHd4NUlMVFFRU1h4RyszMm9Z?=
 =?gb2312?B?dGlNNFRnSVlSMGY2aE9rM2p2OXNrS2cxYzV3TERQWE5iYmREa0I0WTBsUHRW?=
 =?gb2312?B?NitvSTZnMENvM1ZJcjRxb3FGeENhaTFCSVdrUlU0ZkR1aTd0NnpZQVlHaEJC?=
 =?gb2312?B?U3JhcjQ3aHNZZkRjUDV5bzl2YkxpZjhNV1VkSUR5dmlmc2xRS2ZxMFlhZGFw?=
 =?gb2312?B?OEZZaGJSeGdMMkpmaWZkb2JvT29kNGRqNkh2REdtQlBzM3luQzd2MEpWQlA2?=
 =?gb2312?B?RS9FV1RPblA0QlVtZmVOWi9ndkI1TTN4ekl4am5uZVE1Q2tISldHbnBKWjZp?=
 =?gb2312?B?T05RSEk5bU9XNW5EMHRqdEp6TWIyMERydmFFbUozVGpXb2pvQU5QM0RpMEp1?=
 =?gb2312?B?OEU3Z2VtaWoxSmdqZzI2OTBtZ3ZLZlRubm51NnN3NWN2VFNBeGpvWE9haVVa?=
 =?gb2312?B?TFQyRzI3bVE5K1JZOWNwYzYxQm1XcEJlUmhDZTBaQlE5cENsZzVsR0RINVMy?=
 =?gb2312?B?ZHUvK0UyQ1RjVnRHRlZMSXhWb0oxZEh2OXdsbHJzb3NPNm1IaytTNHl4c3Vq?=
 =?gb2312?Q?DkmA=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0728287-ce8a-4570-3a03-08dd024aa061
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 12:16:09.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ha+1Y+OH7I5ppeRFDK3JwZzoAG7OxJl4vpudy5vtednRCPsfIeK+pZq84hw4FvdEkMNd9+sMn8b/A4DuErORmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10265

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZWkg
RmFuZw0KPiBTZW50OiAyMDI0xOoxMdTCMTHI1SAxNzoyNg0KPiBUbzogQ2xhdWRpdSBNYW5vaWwg
PGNsYXVkaXUubWFub2lsQG54cC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBWbGFk
aW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlh
b25pbmcud2FuZ0BueHAuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxv
ZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUBy
ZWRoYXQuY29tOyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtQQVRDSCB2MiBuZXQtbmV4dCAyLzVdIG5ldDogZW5ldGM6IGFkZCBUeCBjaGVja3N1bSBvZmZs
b2FkIGZvcg0KPiBpLk1YOTUgRU5FVEMNCj4gDQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiA+IEBAIC0xNDMsNiArMTQzLDI3IEBA
IHN0YXRpYyBpbnQgZW5ldGNfcHRwX3BhcnNlKHN0cnVjdCBza19idWZmICpza2IsIHU4DQo+ID4g
PiAqdWRwLA0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRp
YyBib29sIGVuZXRjX3R4X2NzdW1fb2ZmbG9hZF9jaGVjayhzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0K
PiA+ID4gK3sNCj4gPiA+ICsJaWYgKGlwX2hkcihza2IpLT52ZXJzaW9uID09IDQpDQo+ID4NCj4g
PiBJIHdvdWxkIGF2b2lkIHVzaW5nIGlwX2hkcigpLCBvciBhbnkgZm9ybSBvZiB0b3VjaGluZyBw
YWNrZWQgZGF0YSBhbmQgdHJ5DQo+ID4gZXh0cmFjdCB0aGlzIGtpbmQgb2YgaW5mbyBkaXJlY3Rs
eSBmcm9tIHRoZSBza2IgbWV0YWRhdGEgaW5zdGVhZCwgc2VlIGFsc28NCj4gPiBjb21tZW50IGJl
bG93Lg0KPiA+DQo+ID4gaS5lLiwgd2h5IG5vdDoNCj4gPiBpZiAoc2tiLT5wcm90b2NvbCA9PSBo
dG9ucyhFVEhfUF9JUFY2KSkgLi4gIGV0Yy4gPw0KPiANCj4gc2tiLT5wcm90b2NvbCBtYXkgYmUg
VkxBTiBwcm90b2NvbCwgc3VjaCBhcyBFVEhfUF84MDIxUSwgRVRIX1BfODAyMUFELg0KPiBJZiBz
bywgaXQgaXMgaW1wb3NzaWJsZSB0byBkZXRlcm1pbmUgd2hldGhlciBpdCBpcyBhbiBJUHY0IG9y
IElQdjYgZnJhbWVzIHRocm91Z2gNCj4gcHJvdG9jb2wuDQo+IA0KPiA+IG9yDQo+ID4gc3dpdGNo
IChza2ItPmNzdW1fb2Zmc2V0KSB7DQo+ID4gY2FzZSBvZmZzZXRvZihzdHJ1Y3QgdGNwaGRyLCBj
aGVjayk6DQo+ID4gWy4uLl0NCj4gPiBjYXNlIG9mZnNldG9mKHN0cnVjdCB1ZHBoZHIsIGNoZWNr
KToNCj4gPiBbLi4uXQ0KPiANCj4gVGhpcyBzZWVtcyB0byBiZSBhYmxlIHRvIGJlIHVzZWQgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgaXQgaXMgYSBVRFAgb3IgVENQDQo+IGZyYW1lLg0KPiBUaGFua3Mu
DQo+IA0KPiA+DQo+ID4gPiArCQlyZXR1cm4gaXBfaGRyKHNrYiktPnByb3RvY29sID09IElQUFJP
VE9fVENQIHx8DQo+ID4gPiArCQkgICAgICAgaXBfaGRyKHNrYiktPnByb3RvY29sID09IElQUFJP
VE9fVURQOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoaXBfaGRyKHNrYiktPnZlcnNpb24gPT0gNikN
Cj4gPiA+ICsJCXJldHVybiBpcHY2X2hkcihza2IpLT5uZXh0aGRyID09IE5FWFRIRFJfVENQIHx8
DQo+ID4gPiArCQkgICAgICAgaXB2Nl9oZHIoc2tiKS0+bmV4dGhkciA9PSBORVhUSERSX1VEUDsN
Cj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+
ICtzdGF0aWMgYm9vbCBlbmV0Y19za2JfaXNfdGNwKHN0cnVjdCBza19idWZmICpza2IpDQo+ID4g
PiArew0KPiA+DQo+ID4gVGhlcmUgaXMgYSBtb3JlIGVmZmljaWVudCB3YXkgb2YgY2hlY2tpbmcg
aWYgTDQgaXMgVENQLCB3aXRob3V0IHRvdWNoaW5nDQo+ID4gcGFja2V0IGRhdGEsIGkuZS4gdGhy
b3VnaCB0aGUgJ2NzdW1fb2Zmc2V0JyBza2IgZmllbGQ6DQo+ID4gcmV0dXJuIHNrYi0+Y3N1bV9v
ZmZzZXQgPT0gb2Zmc2V0b2Yoc3RydWN0IHRjcGhkciwgY2hlY2spOw0KPiA+DQo+ID4gUGxzLiBo
YXZlIGEgbG9vayBhdCB0aGVzZSBvcHRpbWl6YXRpb25zLCBJIHdvdWxkIGV4cGVjdCB2aXNpYmxl
IGltcHJvdmVtZW50cw0KPiA+IGluIHRocm91Z2hwdXQuIFRoYW5rcy4NCj4gDQo+IEZvciBzbWFs
bCBwYWNrZXRzIHRoaXMgbWlnaHQgaW1wcm92ZSBwZXJmb3JtYW5jZSwgYnV0IEknbSBub3Qgc3Vy
ZSBpZiBpdCB3b3VsZA0KPiBiZQ0KPiBhIHNpZ25pZmljYW50IGltcHJvdmVtZW50LiA6KQ0KPiAN
Cg0KSSBkaWRuJ3Qgc2VlIGFueSB2aXNpYmxlIGltcHJvdmVtZW50cyBpbiBwZXJmb3JtYW5jZSBh
ZnRlciB1c2luZyBjc3VtX29mZnNldC4NCkZvciBleGFtcGxlLCB3aGVuIHVzaW5nIHBrdGdlbiB0
byBzZW5kIDEwLDAwMCwwMDAgcGFja2V0cywgdGhlIHRpbWUgdGFrZW4gaXMNCmFsbW9zdCB0aGUg
c2FtZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhleSBhcmUgbGFyZ2Ugb3Igc21hbGwgcGFja2V0
cywgYW5kIHRoZQ0KQ1BVIGlkbGUgcmF0aW8gc2VlbiB0aHJvdWdoIHRoZSB0b3AgY29tbWFuZCBp
cyBhbHNvIGJhc2ljYWxseSB0aGUgc2FtZS4gQWxzbywNCnRoZSBVRFAgcGVyZm9ybWFuY2UgdGVz
dGVkIGJ5IGlwZXJmMyBpcyBiYXNpY2FsbHkgdGhlIHNhbWUuDQoNCj4gPg0KPiA+ID4gKwlpZiAo
aXBfaGRyKHNrYiktPnZlcnNpb24gPT0gNCkNCj4gPiA+ICsJCXJldHVybiBpcF9oZHIoc2tiKS0+
cHJvdG9jb2wgPT0gSVBQUk9UT19UQ1A7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJCXJldHVybiBp
cHY2X2hkcihza2IpLT5uZXh0aGRyID09IE5FWFRIRFJfVENQOw0KPiA+ID4gK30NCj4gPiA+ICsN
Cg==

