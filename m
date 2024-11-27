Return-Path: <netdev+bounces-147539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C209DA139
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A7D284354
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1B481CD;
	Wed, 27 Nov 2024 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ep0ETOCF"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023112.outbound.protection.outlook.com [40.107.44.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F6A1114;
	Wed, 27 Nov 2024 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679440; cv=fail; b=txlzTOTp1+aFn0EGVbBBBkSqcqGMwlYpApskiqc1SRbg3/aZej7dA1M8X4B7sOm1mMbNu0igyZbkcB8SXDtgUAmZ1hl6EYGXk0NJBpRFgqi/M19l4NtQANWCCgQI3PKijMDyS7skHIkBf+afEClcxaJbgxD3Xn60uJqfc7l6yws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679440; c=relaxed/simple;
	bh=1eeKrAuwEmqIszN24MRJ0DcsZf2t5t8EfQebMM1W1zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z20kGcnwGMdZI+qOOBCNI0rtUKCTL5csAYGa+GI0fnKBl3BGzSCOt4I0BglJ0OCtL4scmZAunqDEhQ2Izbfjfj7VQxkf7teGrObWgKAOb5qh22U5XRj46bLM3XHgvvIEGqTKQyo/Eyq4TlfguoqhDZZCNQDLlChsdZHbrWv22Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ep0ETOCF; arc=fail smtp.client-ip=40.107.44.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGVj4kVNapx2hWMxc7QyhaBA5oXn9yGw4Nk7NCsHzlgsGy6enpi9tw9sLnMd79xLxRfWMOApLZTLyi+D/mzJPjThxifkz1CVpYmBXm8jCtGh7FfgzlehnPv6FP1gvMfYayvU8nRYQbu/ASs+tXisyiNOnrEqmcplpRUpjNL6oG/3vQKQIeMWn9cbkdk8APFtJ1hQdcsJTU3tdNWyxHEuwpzVvqxvzvPbileg7SXUgZS8bNAIk2YLtDVe33+H/fSIKLDKHe/Z24BWl5x/XBWUmX6EOlTWVwe5+BEI1deHbfQX+gusr+7tf8QhdkG9j/Su7d70bkqMvZCP8j4JoYtQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eeKrAuwEmqIszN24MRJ0DcsZf2t5t8EfQebMM1W1zk=;
 b=dCGROZM9Ypgd2GkvlQonR8ecvpjnGDVzSs77UuvgPJ1tTofSTOmuvFXhtzaTn1vg2sW4sf9Ey7e4l+jaVmMyJlRb5b7bGZigS9B4KQ1yJa2hDoMc2b9H6K6IiXr9i/6OAn2ajBiphl8qCAXRIFuwdEG7yuYjuByspq4L5Qi34YZ+Ak/xOHYxDizXVZVboWy7H6qFDucV3Ni3IlSHGk3arl4z0UCy2GAroAYGSGcps+yZbZik8ENpGXKMAz+nOIhh5+Cpq6AcSekEpGJ/ySmHACBLn4h1QdCZ3TtopYWYUKRv+zfem0OBhq7uyIrEPEO0Q22/wvi5gXmx6EO+nceLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eeKrAuwEmqIszN24MRJ0DcsZf2t5t8EfQebMM1W1zk=;
 b=ep0ETOCFtLRRkuw+aDsYIsrGGofUoSoWYYa0rwbq+YQ5mSH92ShZ/dDumbaIauwtD+8n3l+9IouKfK0QutF5WbFiWCY8xyltV5FDlrHH9qN6c7BDdy0JbSyNwZikgRPHXnsiUVvXv+qmSkOWEsef+V3T12D2/WlrEyLJOEi4RhtSLSeBHFBcyaDbC0rPEeM9vK2m6SLJkMKJxii94JmOnLapg/Y4Bo76hpfa2KiA+ThJb9G4uEdCQAF5aelpkVP8XLff2a5I640JV8/IRFuVkYXwifh9Zt1RC0SrzxpnP2CK6eDwNUKeZ2l3tfztoOBe2FqKtyQQg2139sdlu3KuJA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6728.apcprd06.prod.outlook.com (2603:1096:400:44c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 03:50:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 03:50:34 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjMgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?Q?net:_ftgmac100:_support_for_AST2700?=
Thread-Topic: [PATCH net-next v3 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Thread-Index: AQHbOyDbxNpji49FAkKFh0hSsYNmWbLH0kUAgAK17OA=
Date: Wed, 27 Nov 2024 03:50:34 +0000
Message-ID:
 <SEYPR06MB513468BB8BEF0A64077D5BE99D282@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
	 <20241120075017.2590228-2-jacky_chou@aspeedtech.com>
 <cc93cc7332e97e31f90edc13496951dc0df12744.camel@pengutronix.de>
In-Reply-To: <cc93cc7332e97e31f90edc13496951dc0df12744.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6728:EE_
x-ms-office365-filtering-correlation-id: e4c76e19-6c5f-4951-b712-08dd0e96a581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTVkYTAwN0N2OTVsYm5FSnRtSzFBQUdSSklUNHBMdzF5T3R6NEx6dkJIQTJv?=
 =?utf-8?B?T0tROWZzV2EvZkZJSUZtdm8vSkpRUnQydFlUUVZaT1c1TGJiTnFtdWRDNkgr?=
 =?utf-8?B?Qjd3alFRZkxUNmNvTG9sWlEvblJFR3cyQnBKYVZEY3piVHpuNzgwV0ZpUW92?=
 =?utf-8?B?QmdCQURyUHFxa0R1Z2M2dmhESS8xVEc3Z21ONjJJYmhIbTFSWW9aczFSS1Zh?=
 =?utf-8?B?YkdtVXg2b2JSZVNHRXpOLzNRSUVQUUMwc3I3Mkw0aTlKTFNyYXdmM25Fa2VI?=
 =?utf-8?B?elhpcXhUcnpmTTRtWGRzWUUzT3Z4Und0RUErUW8yblhWQ3UvTC9peEozM1Fl?=
 =?utf-8?B?c2c5TDJyQWtjY0lIdjBUbGR3Y011UjB6aDdKRkQyR2VjMEZBaCtQQno5bktV?=
 =?utf-8?B?aGNCUEFvOEk3SEJLZkhkL1hBL1g5Y0VBUXF6TkxVNFloZXJuUm44TmhEZWxQ?=
 =?utf-8?B?dFNjLzVWeWdZR3FXNm00NHUyYjBkR05UaUc4cnZnZXlnN2ROT0JxOVlpMXZz?=
 =?utf-8?B?Q0ZzZTRrUjRJYmNQaE5tUGYzYlJiM0N2Zzk0WFlJaFcyeFRuclYxSmYvbmhU?=
 =?utf-8?B?NnRMZG9BQWNibXdsNS9zMWRFQUxjVGRzaHFreDFGTHdiZzg0UnFuMnVvUkNo?=
 =?utf-8?B?ckxhUEdnU3VjM3dGQytvWXFOSmRXL1Z4ZWc0NWd6TklLcGFWWU9TbWxTZlV6?=
 =?utf-8?B?WVhmK1JQTlZGanFxTHJjdjB0cTRxcENKWGo3M01aWVlZZHZMWnlIcVlFZW9D?=
 =?utf-8?B?bDQ2TERMUzdOV1FYSFk4MVJmWnp2MEhuaDVJNEZrRFlsQTQrQ1NXcGFkbUk4?=
 =?utf-8?B?Mkp4aVZMT09CckhSOW92bUxQeExMTDJHRC9sc2NsNURKV1hiQkM1WEM5ZnVm?=
 =?utf-8?B?SENwbHI0ZTVYaDRvL0ZaRFZPVzNXVVZ1V0tjUnZLVlcrcDR6ajkzK2dUL3ZY?=
 =?utf-8?B?SnU5YlhWWmYvTTdaZkFIYUdmQ2xWczhFODJUQTVKSTB3ekpBbTVIMnBpR2dJ?=
 =?utf-8?B?c2I0LzludDgzbTRtc2NiaUwvZDhvOFBES0hhM2JzV1VSZ0xEbjUwb3pMSXI0?=
 =?utf-8?B?a3NIZVhOTnVEMEx6Yk85K2RFR2JiVk1mNUw3TnhwMVgvTjJVcHRoc0JrT2NV?=
 =?utf-8?B?enpsNnNWMlZySjFGU0FnaGt0VUNYZU5JTFZBTWFMSSthMnBvYjFNM3JEU2lu?=
 =?utf-8?B?VDFBVjJkcVdGaWdGWERTZUVNSDN1WkNlQUVIb2RVZ3lobzJDQzFON0pLeFNj?=
 =?utf-8?B?ZHBtTWRmV3VORjBzTkJKS0Rmanh5bjBOOXB2V2dFODVjS2ZxWjVrcEw4NXVz?=
 =?utf-8?B?em5Da2h5aUc2bnFkTG45UlA0RUJxN2RUalpJNFdqank3UHIvMm9xcXp5Z0x0?=
 =?utf-8?B?eWFLUW5ydjVlK3FPSnRBM2JUQ1plRjNOYzZTR1pmT1hsQ2kxbWlQVWJqZW45?=
 =?utf-8?B?N0FZanVTNW5QUG5pL2VLendhZU41eHlCdVZ0bE44RG9VNEloWHVORW5PNVUy?=
 =?utf-8?B?TXF4NWhlVVg1b0IybG04d0xleXp2UGpKR3VIUXpTTzFlMlUyNWNESXpULzcw?=
 =?utf-8?B?d01TaTJ3WkhWcEJDR29XL1J0UzQzVmtJL1BNd293Q0YrZG80TVBmTkFLbFVC?=
 =?utf-8?B?dHVkUkRtRmlGMis4RUppWVRURG5IcG53Umw3RDdRS3RFaTFhREdEQ0RVei9J?=
 =?utf-8?B?VDhMckczM2s0TXp2cmlQcEFRQUdrMTBkUzdMMWZpT2lXTTB1T0QvV3Y1aWRE?=
 =?utf-8?B?Qmd5NDdXekpMZlpvUzRSYjFzM09sWnV5aW5FVXVpdnA1Wkd0NHZ0RDY3UkZH?=
 =?utf-8?B?LzJjanRWQ2hGc2tQSlFDeEloZVp6aXc3NDhJbHdKWDRDTlQrOVc2WkE4VjNX?=
 =?utf-8?B?L2prVUVkQnlJKzJVWGNuR2dWZ3pnMXQ1R3BNN3daTEl0U041OUlubkNBd1JK?=
 =?utf-8?Q?w9238lDnOgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXgrbEMvYkhVODFMamp6OXEwTGlIeG4rZXBSM2hTREp3YTZoZmFOZXU1L0p1?=
 =?utf-8?B?djFSNTB5azlQMWdERGU3MWxkd0RDa2F0VkNiM2hwbHZRMVJNZmpWTG10aTJi?=
 =?utf-8?B?eW1SNU5qL2tsYXl0eXFLL0VSc0grS1o3NDlhd3RpTldaVTlXelJuRlZub2t5?=
 =?utf-8?B?MlYya3NMVnR1eXVqUU5NNHd1TmRsZElOay9uL3Rpdi9EQXg5cXBEVXhlVDNU?=
 =?utf-8?B?aFZ0YTN2Z283TnV4dzhNcDliNFVINkFIRnNqbkR1MWlOZGhrVmp6WllvSzBI?=
 =?utf-8?B?S0gzV0FqZUxKMFN1SnJqTzk3V01jQjFkUEVZdnhiejg0TkUrK2VCeEZZWWpp?=
 =?utf-8?B?NkY3dlZnZ21PRU5uKzJKZTFvUm9SL1dWYUN0NWNGV2pIWks2UGVua3crejZ5?=
 =?utf-8?B?ejd4T2xNck8vQ2JGamVRRk1DZEMvQlpXVk0zVzFjMHhNa0pHc3VOSVowdlNU?=
 =?utf-8?B?WmJlckI3WTRoTUllYzFRNjRuMWNmMUZnb210c3F1eTJuZHlxcVU1RHRXL053?=
 =?utf-8?B?bmF1cXZWNm43UXljSGtqNmFxOE9FMGlCbVBlemY5ZWtKY0RCSVp6a29OVTV2?=
 =?utf-8?B?ZTRVZzdKOUF4a1ptc21kZzV5UGluNVp1RXlaS1QzWEsyVTNYVzl5ZWhRUExO?=
 =?utf-8?B?Y01xdjZBV3RaZ2tWT2FvM21sTDF1VGJTN2FqRzh3eHcwSnYxOEI0Snc1R3N6?=
 =?utf-8?B?M0JCZHdVSEJ6b0h3Z2VsYS9zVVVpeENYZEdBODIvN3VDbmhUYXpaMmxxRnVU?=
 =?utf-8?B?dkRMcGZWeGNaT3FURjNyYkYwTDFxNGdadCtuYm9TUTEvSVFYZHk2MkN1RVFh?=
 =?utf-8?B?Y3E0cEhCSkh6RGRrdWJMOUtQRWsvQjdrVG5tY0x0eWp0MHNNcTlyMlNvTWxl?=
 =?utf-8?B?WkJlZmMvNThnRzhBOUhFYXdmUXpGQ0hSTzRuS1hCNlZLT2pJMXNjNGlIRXhK?=
 =?utf-8?B?dk8ydkN0TjVXUEdmM2tHNlEwbTVpYTFEdUZRaEU4Ym1HeENzL1NmNWhUZnBQ?=
 =?utf-8?B?QnVRZFNYNGh3eWZFVHhva3RQd0NWQ2ptNG55U3Y0N2dyNE4vczRJU1pVYlAv?=
 =?utf-8?B?VU5DdUNNaHUrbE9CQlFRQnNzcFBDbDNuanlocllSQ3NYcFRFVzM0NmU4NHVp?=
 =?utf-8?B?Z1pGaHFacmJ6b0YwOWd2SS9DVzhXVFA3SW5zcktzVjh1cmhiS2JycThDdkR0?=
 =?utf-8?B?MHVja2JaSWlzRlB5NFJjVzhadmU4OC9mS0tBOHYwQ3c5NVRjOTJlQk81ek9V?=
 =?utf-8?B?Z1BoRnIwRmp6VGlvL3FzbnYxQUtnbkx6Mk55ODlmQThTSjZqVUcvYzljTUE0?=
 =?utf-8?B?ZklBUFlUb2dsQnN1Y0tVRGUrRnVXRjBnbVQwQjBONDIrZk5GUHlMVjFjbkRj?=
 =?utf-8?B?eEVwQnJBUTBYR0xNV29CN1p0R2h4V082TXpsS01WQ21vT285Rk1KamtSbnk1?=
 =?utf-8?B?ekZRcmFtMjhGWkRubWpUWlN0aHk1NGcrWFZxdFU0MEpkTHlkM0h1SSt6cnBC?=
 =?utf-8?B?TDBLYWc1ay9rS2l1SjBsR2YrVUxqZEZ6R2x2RXozZ1gxTklPVE1TMHo1OWtF?=
 =?utf-8?B?Zks2S0FNdnVHTGN1ckZuMEw2THlva3ZKNEh6K2cwOFhvSEFoM3ZrUmxVR3Vo?=
 =?utf-8?B?T0dYKzBUWUFiNDJCTnhPMW9RNmF0ZWp5Q08rdk1OeW1ERFlqZzJCUEpXZFR1?=
 =?utf-8?B?aFlSQlRQbTZ3VkVFQmJGMG9MYklCVHZMdjQ0ejB6L0JFSEJxZGRWb0dGV09a?=
 =?utf-8?B?WDRnRndFMzF2UDcyNWRSdXYyM2JKczQybkUwMDF0bHFyaW5RWVEyamlIaWNZ?=
 =?utf-8?B?ZEhhdFV0UVZnSE9kNUVreVRvMkxNZmhoUzJjRUFkQ1R0VnlEWGN5MEk0OUNT?=
 =?utf-8?B?NVBYM09DVDl0SHlrcy9DejAxNTFGS25meE5BN21HUkxJeXVTOEJXY2pxWDdR?=
 =?utf-8?B?OEc5cFAxMFZsNjYyQVhqbUhtcDdERS8rUThNZDk5cWhobDVhQXpqRStjY1VM?=
 =?utf-8?B?RkpGeC9ZMzJJa0pOWGRwMlQrWlZUZjdib0FJWkx0WWRlU2MxaHJIT2pMZnB2?=
 =?utf-8?B?Zm5wZzkyeXorS0F6cjdxYWp2aitFcEVCNFR0KzVUbVo2b0dib3pFNjZlTnRn?=
 =?utf-8?Q?Sb/Mda+FkIYj0QG/vSu3pky7B?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c76e19-6c5f-4951-b712-08dd0e96a581
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 03:50:34.1042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gQpBQE/Dy3QEiWrnqYOeHJWejBwdt9U5NYzlw2Ir2Xsk9wasKFr9kK15MWb16ghkC0GOjCP+T7SmyhpMRFSffuTiFQfP7A+512j0aNraLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6728

SGkgUGhpbGlwcCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gZGlmZiAtLWdp
dA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0
Z21hYzEwMC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBpbmRleCA5YmNiYWNiNjY0MGQuLmZmZmU1YzUx
ZGFhOSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBAQCAtMjEsNiAr
MjEsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI0MDAt
bWFjDQo+ID4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1tYWMNCj4gPiAgICAgICAg
ICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0KPiA+ICsgICAgICAgICAgICAgIC0gYXNwZWVk
LGFzdDI3MDAtbWFjDQo+ID4gICAgICAgICAgICAtIGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMA0K
PiA+DQo+ID4gICAgcmVnOg0KPiA+IEBAIC0zMyw3ICszNCw3IEBAIHByb3BlcnRpZXM6DQo+ID4g
ICAgICBtaW5JdGVtczogMQ0KPiA+ICAgICAgaXRlbXM6DQo+ID4gICAgICAgIC0gZGVzY3JpcHRp
b246IE1BQyBJUCBjbG9jaw0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBSTUlJIFJDTEsgZ2F0
ZSBmb3IgQVNUMjUwMC8yNjAwDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFJNSUkgUkNMSyBn
YXRlIGZvciBBU1QyNTAwLzI2MDAvMjcwMA0KPiA+DQo+ID4gICAgY2xvY2stbmFtZXM6DQo+ID4g
ICAgICBtaW5JdGVtczogMQ0KPiANCj4gR2l2ZW4gcGF0Y2ggMywgSSB3b3VsZCBleHBlY3QgYSBy
ZXNldHMgcHJvcGVydHkgdG8gYmUgZGVmaW5lZCBhbmQgcG9zc2libHkNCj4gYWRkZWQgdG8gdGhl
IGxpc3Qgb2YgcmVxdWlyZWQgcHJvcGVydGllcyBmb3IgYXNwZWVkLGFzdDI3MDAtIG1hYy4NCg0K
QWdyZWUuIEkgd2lsbCBhZGQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgcmVzZXQgcHJvcGVy
dHkgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

