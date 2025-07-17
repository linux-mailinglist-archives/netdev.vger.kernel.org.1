Return-Path: <netdev+bounces-207804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F95B089BA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45ACE7AB534
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1D291C28;
	Thu, 17 Jul 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBn12shN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012033.outbound.protection.outlook.com [52.101.71.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDF288CBE;
	Thu, 17 Jul 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745791; cv=fail; b=cNnF8IT9V16cZRjHQBlsEIphWmJeo3nOf1Q9XtWeXXmxdkqFnyx3qRTyhon3sqTHTX1NHjfRVZ4XFhUouJ1nbOGGclyvgQp0g06MAdq7o+6xtIiGf8LCW/zArLQL6M/UL6niDVcqKsO44oF/7JiAtM9pcrMTepd472m+kJIZpSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745791; c=relaxed/simple;
	bh=aOpFviT1L4cToSwDmZ1aDn4J2MOcwOogJ2S26O0wsyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hv1GDIArV8DFCfTqh2vh8kSMFuaC0TReJCiTVgdNrN+VByuHQa5fk/IKlhs9eJjij4XLpECIlBxp01v/b5IRR2aIfHWb8NCa0ldncu0WnA5BicQV+h5eU+UMWurhjxrKLUohBUZE0vkqufjwPPzq9IE5/LgKfjYnrLODLmprLx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RBn12shN; arc=fail smtp.client-ip=52.101.71.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW7nNtuRqC/V3PsTEA4yMRMgwpC9wHz0a/QGKJhZRq95xu3rfSPB0sSiBHgi/Qdv/lOCtYcFC9f0dcjqx4Gk/yH8fwCgoEaYdJYuZQ0XEeINhF6/iXvwzdt6VnOay+YQU0jFK+wM5t0eVWHSKF7msLbwe/CW9zCzcWjuegikqa+bUxiz00iUQLlNgQcF2FRSk3t6p9WUaSujtfv2rHSVjLBE6P0TTacIIvKn0j43DC61pSeurtzPf8sDoed2hyoW9IuuQLBos+IXgkY5jxXx4nN8KF1wjRz7gtffndtkAAS7zVDR3yncJiEWpIDmz7kO2XDk3+gabfaaSYEBF65k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOpFviT1L4cToSwDmZ1aDn4J2MOcwOogJ2S26O0wsyM=;
 b=X5LvUab5dJROHqxhPEtRdJRL7VjwultVDh/8E8gvH9wyOUaUqOpVRxRfwraDfcGQhItMU/Og636VwRwW9Ozf/SglhUoTJ9+EQ9D/NaZZA6eP9C9eoBUbZKnY1W7/qqH4y0/mS2fzK/hqIfLW6/nJl4BGmuvTwMMXmuGQGoWUqMGK0IHCs86OBIbMT8Vv50Gfvqgj2pha4KU7jOe1TDuX7i/CksKtrNNydplv86g32HSZWQuWtMigi0DyOYoQbf2PTlBmQEF42LAsN7UqO+NfyUMbwNOjPaKlJ/5TfjcJMiyExyKGDc3DlcXaAZXsYKyHxFznsIXwdLX6KG5F9uXneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOpFviT1L4cToSwDmZ1aDn4J2MOcwOogJ2S26O0wsyM=;
 b=RBn12shNBGQodA6kbMcfkMpzPN3piHqLhmLnX6XDL0Q5kaKPlinCyM15lR0WJEplIXHh5XpVXL4BFop2+JqJ2U7QhRDSCpngGUMLQyxfkO2ZBKEaqCDwXgGOMeDl9JJVkb6VAXZXx/gBR8omV/lKmCTVubVMAYeKXZNLO3ST/S5GVVI3oZEwRBmcZKLjn68f9scC5OWL2FZdRG7n5TO/3oOBg09zoJrbQYhrfSPFPCg+Ztv/uartIE+7k+EJP0woXWdfnqWgdtLoanzuHW93Flj4lv8X4tNHfDumbXz0QyC5x3KbtM0a15FEIiUz0dRWEemhtPY73UCXZ2NuWqHcLw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9740.eurprd04.prod.outlook.com (2603:10a6:800:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:49:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 09:49:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Topic: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Index: AQHb9iZmm/EQyWHMi0uUtvbMzlnJDrQ18GUAgAAJ0BCAAA9ogIAAAdxw
Date: Thu, 17 Jul 2025 09:49:46 +0000
Message-ID:
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
In-Reply-To: <20250717-masterful-uppish-impala-b1d256@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9740:EE_
x-ms-office365-filtering-correlation-id: 12b1c093-969e-405c-981a-08ddc5174355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGc0c0pPbm1LanAwcFJlc09qS1NhMWc1QmlqNXFTS0dPNzZaUWlFZnBqSFVM?=
 =?utf-8?B?dzd0NGQ0YVEzQ3dBRG5uVzNNZkQrVzVvOG9WT2xia3libjJsMkdDeUFOS0dM?=
 =?utf-8?B?S2ljMFNJWEhLNyt6VGxZdFRSSmJLK1pFZER2STdWa3JsaVdEN3MwdEN2NHRl?=
 =?utf-8?B?TzE2QTI5aDR5eTgwaWpEeUJPc2Y3dlVMYmUrZnQvcU00SUhxZmVISTVhUzFP?=
 =?utf-8?B?Mllzdi9MMzdwbkdBM0xjanZhQS8yYmhQSWxEY1dEeCtXcVFyNktOalFZd0sy?=
 =?utf-8?B?ZTlRL0JjbGdxUU56UnU3K0dmN1E2cS9UK1NKQ0MyZnl4Z2hHRm9IcUZDK3I1?=
 =?utf-8?B?eG9jTkhGN1JqYkE1eW9IMnZEcTh5NGdNRHJ6NFEyNkZxdFJvejRtejBuRy9T?=
 =?utf-8?B?ME5PbTliNHBVRmFzRWkyVFEzNDFETW1wb25jT1FpbkFvQmF6WUtzYmM3elZ2?=
 =?utf-8?B?QnM3K1R0Y29wU2ZacktqR09XVVdTZXpKc3RLcGIxNkRLMEt5di8wQkMyNHc3?=
 =?utf-8?B?R3JZUEFHT1NMNmZPVVdBOHczc1hlRmRTQU40QUVPK29tdDhJUitXclc1bno2?=
 =?utf-8?B?bmxpaisrU2dpdUxZcnRrZU9hQjU5ZWhWYVQ4eEN3UFBPR200M1lRYW41Z3VP?=
 =?utf-8?B?NUtBUnhwV3BzaFlicTdjWkxKSFNLa3BmS2djOUhkaFBYVko0UHNVRys5SE84?=
 =?utf-8?B?NVYxN2FDNVU3Kzg5ZlE4cDl2TU1ITFhBWVRVa3hSNEF4RVFTWWN2UHFsdERr?=
 =?utf-8?B?SWJPdUJJeGppREY4VFRXZlM0ZWxvRE1wdnZrN0tIb01iVGpITjhySW81RER6?=
 =?utf-8?B?eXR3dlU4UzRENUNVM08zcEJLRXh3alpQejEzZmpFa2NtMHoralU4NzBmM25i?=
 =?utf-8?B?bEtSVkRYTHBkbWFhN2JCUTdVelk1bXpjdXc5VDJRTlcxZFpwbHpjSTJQYXJm?=
 =?utf-8?B?YVhwTitUZ1JqeDBWS0xnbTZ5eUtUYS9GSWVicm8ydE8wdm5YYmZuOGNMeUlh?=
 =?utf-8?B?Nmk2cldsWmxHUzFwU3FjMzJWbklwNUR2eEhjazc2RVN0b0NUaDRzS2hyeXFW?=
 =?utf-8?B?WGFTNUhqRTdRdHdnYUFKR2FUZTZnc3NzUnZyaXBlY09xRi9ZOE4yV0ExK1Rq?=
 =?utf-8?B?eVRtVVhxNjY2WngzVklTVTBzbTdnRjNxWmhYU1dMeHlmUUlJeEUrSEs5WDFl?=
 =?utf-8?B?ZndRVWdSY05BK0NhWDYwNEZObkZvNHFOZ0dybGY5QS9XUWtDcjFYZmJ3Zldv?=
 =?utf-8?B?MCsrNFdYMDN4VXZDTzBnYUE4aW5qNDZMTCtvWC9QODNiYUZNekhGRzZXcU5F?=
 =?utf-8?B?WHFVN3h6bm53UVJaSkJ4bDFPTnRTTWdSR1dVaUhrVlk2cnQ1ZXZmVWNKeVNt?=
 =?utf-8?B?K3ZJZmtiK2tLUHk2K1QrRUgzZ3Y2cTMzeVRBQWdtWW9tNFNnU0NrekNFdVJZ?=
 =?utf-8?B?N3llS00rcnd2SDBadFFyQXIvcU44dVhKN3Bab3pBcjBpc09TUi9RRHNubGE3?=
 =?utf-8?B?dUFtNHVTZXYrZGZEVHlMK1cxRTNHQ3IrWHFIUzVUNEI5bnNJRG82Z0RJNVl6?=
 =?utf-8?B?Rk1yeXEwTDJ1TXVwdE9oalNBZ1EyVE5Qa2JMNk9JMkVEZDh5Y0lzd1JlaXJj?=
 =?utf-8?B?TFRKaHdaN3FBQXgveFAwOVVKYWlxTU0zOHFTY1FLekxYdnNHSktYbVA2OFVV?=
 =?utf-8?B?U3RBRHRYODQ2My9EdUh3cCtvZXBjVmVuNWRXNW0vVmNwdVZ3d0loTFU1RHFq?=
 =?utf-8?B?YUltazFab0FLMW9ySnJ0UEVGM0pTRDBBZkxpR1NxL2puMlhUS2hDaEwzcEFT?=
 =?utf-8?B?OWIvTkZoT3IxMzlmZVhSYUw1UkxZMDlDbFZiRHBlNjdEQVRxMVl2VWZBa2xk?=
 =?utf-8?B?RE9mSGEzczM2cmFUcG1SVWJwbXJZbXZodmNoaE9PQWwrQjJGV29neHViK2VQ?=
 =?utf-8?B?bDJuUzNlUVZWeHhoVXpSV0cyaDZvbHBFY2cxSHd2OGFoZDkzTkhqRTZKODRW?=
 =?utf-8?B?UityZ0RrUkh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SU5JOFJDVUdsYjFCUVJteDVHcHF4QnAvY25pUXd2MTlsczZzdWo2OXBkcWl3?=
 =?utf-8?B?b0Z2bkE5dzhBcDlrMHlvYmJ6a3hoaStOWlRTbTZscGNSQ2JQSHJkeTROU01i?=
 =?utf-8?B?ZGFqZ0UyR3kxSHlRSXRsZURsUGU0SEtXa24xZFdIeldMVWkrU0xSYUR1UGdB?=
 =?utf-8?B?aUYwTC9KWHBaTzY3RWJzZkNUWmVxSEJxUzdIM091MlovNG5wT0dvNjE2RWI5?=
 =?utf-8?B?RVNFSm9BRmdCQTl1aGJhSHRqdWo5ejd2UVdwRktiQjF3QlNsalhHaWN2MnZ0?=
 =?utf-8?B?Yno1NzcwZHVMVTdrdS9URTJsZmZDVCtDN04rRkhpQWY1WGJwVS9jSm41dDE5?=
 =?utf-8?B?TDBCVGxUTHFZMWZybFlSbjNwLzN1WGtWbEpoWDFDTStvZEtQdzVUQ1RIRXdK?=
 =?utf-8?B?YzJoNGNJVGtMTDNsVUxjQm1uai9jN1NPYU05V3NtZ1JXdzhmUzVRSlMyRWQ4?=
 =?utf-8?B?REgxblc3dG16RVNXMGxOTThISVRWOU9HcTU5QlVhMEk4bXVmb2s2U2Jmc0xH?=
 =?utf-8?B?TGp0Z2ZGOXVTdklURFhpemFBc05Jb2dpeHhXVGplVjNjUDFoUXBPSVNTMzdO?=
 =?utf-8?B?TlVLdC9jMHpOOHhGZHBkQm5jYU52MDJrTXRuOXBLbjdQZXBJbGFBQVJ0M1FL?=
 =?utf-8?B?MSt2cVJGL3Vlc3ZtaTE5bzM3V2YwYlcyVm1CTE9tLzF2VlM1Q0JwZzFLb09R?=
 =?utf-8?B?RTZhV3F3cmVxcURyRmhPWFVRdW9nTmVSUkptK2xmREphQmE1ZjhITHZJaktm?=
 =?utf-8?B?d05GQnkwVlpxRXNHTEpXeUM5bkxRZ3BON2tSZXBCMWF0SjBzQXFiR1NTZWJr?=
 =?utf-8?B?VXYyMTM3NHVkWitTdmVpbG5mb2FTNERua2pRRWdwNHk3L3JpSHNiOUVLTHNr?=
 =?utf-8?B?K1dlcjFnT0hMNEZ2MnVUZnd4amYrL0RIMFNrZVlRTjVBQVB3WTJQZnc2QkhK?=
 =?utf-8?B?N2ZxcVdSVmdQRlAxdlV2VUZwR3FHWXlEd1VLblA0ZElqYVFtREoveUFUMkpW?=
 =?utf-8?B?VXEyU0tCaHBMSU1MTmc4UEc1d3NZZmJ3eE44dWZnL1JnaVkrclZydGY1ZXNk?=
 =?utf-8?B?c0J5UGdPUm8xQVpPTTdaU3NzUXgzQThjejFFL0FCQ0JHd2lKQ242NTZ2eVJQ?=
 =?utf-8?B?N3JHUGJNdU04MzlmUHZpVFh2aVcyY2NWNENyS083c2RqdTdBRXNTY2dZVW5B?=
 =?utf-8?B?REdYRWk4SlJrSE5uSytCNGhUVllUOGJJbjJzOFZXVUdWQlRKQnJUYjFaV1Bl?=
 =?utf-8?B?VVUrSThGcHQ1NTl6M0daNXR3KzVSY2JTUGhIUExHY0xZdGtucFg5YmdEWC9O?=
 =?utf-8?B?b252QkI4S3F3TFpJL1dldW84dGFic0hxRFNSK2FwSmNaQmZvWUJLaVpUbDE2?=
 =?utf-8?B?QzBiSVE2RktKNUpxUVk1cFRsR28yMHZMK0paVU81dFdRcSs1b3N3cmI1U1Zl?=
 =?utf-8?B?aitKN1pvS3BOcm45UGRiek1MNnFnWWU5dGhzSE9GYkZhOUZ3N0o2RmpPTlE1?=
 =?utf-8?B?ZXB1N01QblVOalNMSjNvalZqb0J0NGhVYnc5T1drbWtCM2tDc2FhR1JCNUlW?=
 =?utf-8?B?M3dnQU1kNkNqT0RUZFB1Z3Q4OWR6QkV5UmZESXo4WCtwSzlNbEJHNHFHQUFB?=
 =?utf-8?B?dFdyYlh1ZDB6cEhJLzFJcGhORlFIMnE2Z2pGc09JNTMxaVVxZGxQN1Z6Tjly?=
 =?utf-8?B?WnRZY0paRkpWSGtlamZIR2FOYUNESVpRRytmcVBkVG9vd0RPR0VhOEtaT2ph?=
 =?utf-8?B?MmMrVTJJZEw4MVREOCtUY0tDVVYwdnBEaHM0UitaQkp2MW0rMTR1NU1BMHlL?=
 =?utf-8?B?MXlNbUpCKzRCYjg1TEZ5MFVtQTg0MmphNGpUeElGaHJZSHJNNW01ajFkSjNp?=
 =?utf-8?B?eHViS2k4VDVDTU1sb3RCL2xWc2o1NDV1ZGNUYlRRVldnWmZEa09aSnpoQ24r?=
 =?utf-8?B?a1VtQXhBVlpialoyODZETHQ0RDlRRlZzRnI0VVgwQ3QybEUvS0V6THdmNWRX?=
 =?utf-8?B?YjR6K0xRWXh1dUZicmRoamtIcUVyYjY5c0d4TWZzV3c1VDVqZmIvdERFdFY2?=
 =?utf-8?B?NGo2SUtUcGlQcEovd3dxUHdDM2pQUFN2cXRhcy8rVWRyY0dIQ2dQUzFBdHpH?=
 =?utf-8?Q?pDec=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b1c093-969e-405c-981a-08ddc5174355
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:49:46.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B7PBIOUCMshUkOL04MSnN3OZvjqwWi333HPBzA0ASFyILUlKs1NUnVCdRoUqgj2J+vz1+7PH14XBZecbJ5F5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9740

PiBPbiBUaHUsIEp1bCAxNywgMjAyNSBhdCAwODozMjozOEFNICswMDAwLCBXZWkgRmFuZyB3cm90
ZToNCj4gPiA+IE9uIFdlZCwgSnVsIDE2LCAyMDI1IGF0IDAzOjMwOjU5UE0gKzA4MDAsIFdlaSBG
YW5nIHdyb3RlOg0KPiA+ID4gPiBORVRDIGlzIGEgbXVsdGktZnVuY3Rpb24gUENJZSBSb290IENv
bXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludA0KPiA+ID4gPiAoUkNpRVApIHRoYXQgY29udGFpbnMg
bXVsdGlwbGUgUENJZSBmdW5jdGlvbnMsIHN1Y2ggYXMgRU5FVEMgYW5kDQo+ID4gPiA+IFRpbWVy
LiBUaW1lciBwcm92aWRlcyBQVFAgdGltZSBzeW5jaHJvbml6YXRpb24gZnVuY3Rpb25hbGl0eSBh
bmQNCj4gPiA+ID4gRU5FVEMgcHJvdmlkZXMgdGhlIE5JQyBmdW5jdGlvbmFsaXR5Lg0KPiA+ID4g
Pg0KPiA+ID4gPiBGb3Igc29tZSBwbGF0Zm9ybXMsIHN1Y2ggYXMgaS5NWDk1LCBpdCBoYXMgb25s
eSBvbmUgdGltZXINCj4gPiA+ID4gaW5zdGFuY2UsIHNvIHRoZSBiaW5kaW5nIHJlbGF0aW9uc2hp
cCBiZXR3ZWVuIFRpbWVyIGFuZCBFTkVUQyBpcw0KPiA+ID4gPiBmaXhlZC4gQnV0IGZvciBzb21l
IHBsYXRmb3Jtcywgc3VjaCBhcyBpLk1YOTQzLCBpdCBoYXMgMyBUaW1lcg0KPiA+ID4gPiBpbnN0
YW5jZXMsIGJ5IHNldHRpbmcgdGhlIEVhVEJDUiByZWdpc3RlcnMgb2YgdGhlIElFUkIgbW9kdWxl
LCB3ZQ0KPiA+ID4gPiBjYW4gc3BlY2lmeSBhbnkgVGltZXIgaW5zdGFuY2UgdG8gYmUgYm91bmQg
dG8gdGhlIEVORVRDIGluc3RhbmNlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZWZvcmUsIGFkZCAi
bnhwLG5ldGMtdGltZXIiIHByb3BlcnR5IHRvIGJpbmQgRU5FVEMgaW5zdGFuY2UgdG8NCj4gPiA+
ID4gYSBzcGVjaWZpZWQgVGltZXIgaW5zdGFuY2Ugc28gdGhhdCBFTkVUQyBjYW4gc3VwcG9ydCBQ
VFANCj4gPiA+ID4gc3luY2hyb25pemF0aW9uIHRocm91Z2ggVGltZXIuDQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+ID4gPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gdjIgY2hhbmdlczoNCj4gPiA+ID4gbmV3IHBhdGNoDQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55
YW1sICAgIHwgMjMNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0KPiA+
ID4gPiBpbmRleCBjYTcwZjAwNTAxNzEuLmFlMDVmMjk4MjY1MyAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0K
PiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxl
bmV0Yy55YW1sDQo+ID4gPiA+IEBAIC00NCw2ICs0NCwxMyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4g
PiAgICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gPiA+ID4gICAgICBkZXNjcmlw
dGlvbjogT3B0aW9uYWwgY2hpbGQgbm9kZSBmb3IgRU5FVEMgaW5zdGFuY2UsDQo+ID4gPiA+IG90
aGVyd2lzZSB1c2UNCj4gPiA+IE5FVEMgRU1ESU8uDQo+ID4gPiA+DQo+ID4gPiA+ICsgIG54cCxu
ZXRjLXRpbWVyOg0KPiA+ID4NCj4gPiA+IEhlaCwgeW91IGdvdCBjb21tZW50cyB0byB1c2UgZXhp
c3RpbmcgcHJvcGVydGllcyBmb3IgUFRQIGRldmljZXMgYW5kDQo+ID4gPiBjb25zdW1lcnMuIEkg
YWxzbyBzYWlkIHRvIHlvdSB0byB1c2UgY2VsbCBhcmd1bWVudHMgaG93IGV4aXN0aW5nDQo+ID4g
PiBiaW5kaW5ncyB1c2UgaXQuDQo+ID4gPg0KPiA+ID4gWW91IGRpZCBub3QgcmVzcG9uZCB0aGF0
IHlvdSBhcmUgbm90IGdvaW5nIHRvIHVzZSBleGlzdGluZyBwcm9wZXJ0aWVzLg0KPiA+ID4NCj4g
PiA+IFNvIHdoeSBleGlzdGluZyB0aW1lc3RhbXBlciBpcyBub3QgY29ycmVjdD8gSXMgdGhpcyBu
b3QgYSB0aW1lc3RhbXBlcj8NCj4gPiA+IElmIGl0IGlzLCB3aHkgZG8gd2UgbmVlZCB0byByZXBl
YXQgdGhlIHNhbWUgZGlzY3Vzc2lvbi4uLg0KPiA+ID4NCj4gPg0KPiA+IEkgZG8gbm90IHRoaW5r
IGl0IGlzIHRpbWVzdGFtcGVyLiBFYWNoIEVORVRDIGhhcyB0aGUgYWJpbGl0eSB0byByZWNvcmQN
Cj4gPiB0aGUgc2VuZGluZy9yZWNlaXZpbmcgdGltZXN0YW1wIG9mIHRoZSBwYWNrZXRzIG9uIHRo
ZSBUeC9SeCBCRCwgYnV0DQo+ID4gdGhlIHRpbWVzdGFtcCBjb21lcyBmcm9tIHRoZSBUaW1lci4g
Rm9yIHBsYXRmb3JtcyBoYXZlIG11bHRpcGxlIFRpbWVyDQo+IA0KPiBJc24ndCB0aGlzIGV4YWN0
bHkgd2hhdCB0aW1lc3RhbXBlciBpcyBzdXBwb3NlZCB0byBkbz8NCj4gDQpBY2NvcmRpbmcgdG8g
dGhlIGRlZmluaXRpb24sIHRpbWVzdGFtcGVyIHJlcXVpcmVzIHR3byBwYXJhbWV0ZXJzLCBvbmUg
aXMNCnRoZSBub2RlIHJlZmVyZW5jZSBhbmQgdGhlIG90aGVyIGlzIHRoZSBwb3J0LCBhbmQgdGhl
IHRpbWVzdGFtcGVyIGlzIGFkZGVkDQp0byB0aGUgUEhZIG5vZGUsIGFuZCBpcyB1c2VkIGJ5IHRo
ZSBnZXJuZXJpYyBtZGlvIGRyaXZlci4gVGhlIFBUUCBkcml2ZXINCnByb3ZpZGVzIHRoZSBpbnRl
cmZhY2VzIG9mIG1paV90aW1lc3RhbXBpbmdfY3RybC4gU28gdGhpcyBwcm9wZXJ0eSBpcyB0bw0K
cHJvdmlkZSBQVFAgc3VwcG9ydCBmb3IgUEhZIGRldmljZXMuDQoNCg0KdGltZXN0YW1wZXI6CXBy
b3ZpZGVzIGNvbnRyb2wgbm9kZSByZWZlcmVuY2UgYW5kDQoJCQl0aGUgcG9ydCBjaGFubmVsIHdp
dGhpbiB0aGUgSVAgY29yZQ0KDQpUaGUgInRpbWVzdGFtcGVyIiBwcm9wZXJ0eSBsaXZlcyBpbiBh
IHBoeSBub2RlIGFuZCBsaW5rcyBhIHRpbWUNCnN0YW1waW5nIGNoYW5uZWwgZnJvbSB0aGUgY29u
dHJvbGxlciBkZXZpY2UgdG8gdGhhdCBwaHkncyBNSUkgYnVzLg0KDQpCdXQgZm9yIE5FVEMsIHdl
IG9ubHkgbmVlZCB0aGUgbm9kZSBwYXJhbWV0ZXIsIGFuZCB0aGlzIHByb3BlcnR5IGlzDQphZGRl
ZCB0byB0aGUgTUFDIG5vZGUuDQoNCg==

