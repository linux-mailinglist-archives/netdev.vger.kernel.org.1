Return-Path: <netdev+bounces-229025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C605BD72E3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D154619A079D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1812741B3;
	Tue, 14 Oct 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="in8bGA55"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD801F4297;
	Tue, 14 Oct 2025 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412268; cv=fail; b=iWlg1bxEjcUfJm+lETs2ZJR+pH7906QssWwCtSB2w/TzXQzFFe2lQqMf0oBSvbqDCB4k7xDgcigJkOOCoX6PzJa3dvrPbVEWNSpzh97glZaTrQaXUVtzgPBKBX2Li78jsiI1As0FKfmEy9VqsYJRoBlNFba3Gl/OG2T/z7XphtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412268; c=relaxed/simple;
	bh=NzOQnqQCVNEylBoi6RMiIdro+47BUs0u1Le3WBzt83k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOsVR+l+lIs1OeX+SxMPCZHRzhBLxY8xD2CEZcsaD5DAiuhq39Tx4+W3YoidSknd6NAVbJNtjsasCuBUBw2lF2X1oKg57aOQCOmC94PuQqIYE9LkIC6l2bvSkf6QGYk3xFrdFPW8KU/REwrnp5GcTaqg9TZAuwkaS5UUeNeQgmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=in8bGA55; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BT3Smy6V2KangkCz4CpcKDt7ULQDNKpfxUGGQ7LUrcGKVNQkANqqpTRhzFR+JOi90/VRbR+HwpqXF0yyhILwYC46kKUy6y0sh87t+E2DkQfkIAdy+uQOi8oWlGXYyoYeMlC4E7cv4GMgXw19OXYdR7eIYUO2+Y0n8tuxbUOyq+UzJozInyMXkRyx70obtRrq8Q/L9Hd/01ouY9tthoupwY4ZohC+1yE9AF57M7dLe4oeksi5ty+brfOf2Qw7JuqFz+HWEztvMF4ul1Cxj4b0KaQ9AfB6Dwl/ABdiZZ6vp6pxqBPAGeAFhdqtXh/mUNituNYicYvdMEiNUqt1k7kx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzOQnqQCVNEylBoi6RMiIdro+47BUs0u1Le3WBzt83k=;
 b=bb/FizwELi3cbNTMp0WOan02SAhkZzZaEoXV5tyvrod1E28dKrHVPWBlJ4h0OtMjN749+JF2tgDkeOKkadvlNoNaESQsKZlYJIuTI0FFWS9WpwetsF/Bl5x5+shLreN4v2s1lDWovgGzO/jtwyOw+2yyoQBkraPSFeM8UTo0sWnpa4CVkmz+UTG5SztswyPTSZQlNv7Oy+/CIAp3yRKeJmzxBRVZzI7eRxtSRTl/1Newt6YTKvdiafz+nptnbIft99yN0NOcq1qKwf8g2UulLVDoIDQ0snTd+qnnzcRD1Y/0EVTutAnb2aP228hMQx0+OHg9ccuEjl6XTAn38N0v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzOQnqQCVNEylBoi6RMiIdro+47BUs0u1Le3WBzt83k=;
 b=in8bGA555f5NjZB7thhg3V0Zx2TykhSaEWpuzAVGc4ExWPLXQbgKj78xAixTFo1ozywP/rD0gGja7Ju4u0IM1bAXtQPNEcP+bMCcK2BTg6fmLGLOtVm4Nu3wU+pEMZxigFi0cmx1EyWmUpfAXLt1fDbKlh3DkAe7CWtil7SpcYAf2orfq/IHL9XQ8scvG3SUXCxidyRO6m7Xn/cqN5Zq/XPoVJfHZbhZrJWMXb1Xm6sYOHITxHpaD6+XIt8t7CUPoS35oJ4/aMjh35y8BqhORSe2U4hIvZe2P7sjTQ4NhsnYmRpRNY3ZShkX7v6eu7EZCSLunwCFQX/fRlRRNxRgjw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 03:24:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 03:24:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
Subject: RE: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Topic: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Index: AQHcOLyl4vHcP8LukUGQcvWe857yFbS7GIsQgAAdsACAAAShAIAFws4AgAAEejA=
Date: Tue, 14 Oct 2025 03:24:20 +0000
Message-ID:
 <PAXPR04MB851059330C28E5A41166CF2388EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
 <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251010105138.j2mqxy6ejiroszsy@skbuf>
 <20251010110812.3edrut6puoao36b3@skbuf>
 <45e6e4f4-b467-4852-b1ae-badf3c815075@windriver.com>
In-Reply-To: <45e6e4f4-b467-4852-b1ae-badf3c815075@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV4PR04MB11944:EE_
x-ms-office365-filtering-correlation-id: 083f3b06-0d33-4e8c-d894-08de0ad129f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWNtNk9mV0x1cVlqRVRHcWlVb0xIa3JkZUhoc1NuM2lNbVRXL3ZkaUtWTTNG?=
 =?utf-8?B?VHp4UjZJSGVqdGc0MGI0U2tGTFduak9ET1R1ck9wZlZhc0EzTFBXK0ltTEdR?=
 =?utf-8?B?YVVoVmRXNlc1eUpiaGFSTEZacWdGVUFTeHpCWk9La005VjM5aUQvd3FpdkZ0?=
 =?utf-8?B?cmJGcGE3RElsNVJFci8wYzVlR3NzcE5zbFBOdU9ZSnk5QnJRN0ZDekhWOTg3?=
 =?utf-8?B?UVJ6dUJSZE85RTVQTGlSdVRDbTZBU2FUMkdkQkZib202VXQ4bDk4Q2NyZDJL?=
 =?utf-8?B?bmUwajZxNXlibVdsVVhxWkRuV21USnFORmRQYTNLSFloeXU5d1RJaXBzRDYv?=
 =?utf-8?B?Q214QkgyWStkSmpraHVPSnk0Y1ltSGduWUdYam5SVW9VbjAvd28xQzBiNnpK?=
 =?utf-8?B?SWpkdUljdWtyNVN5MkRGNzl6L21RNFdBK2hjN2FFalYzR051UC9wNkUrR0s4?=
 =?utf-8?B?aGIwU0FuNFZlaTBDeG5VNmVUUlpLMU13YmlOeEZVUkRnZGlDVFpPUEVDc3Ni?=
 =?utf-8?B?MkFGcUNubTJieEp2OUpaYTJCSlZPRzU4Z2xZOHhIMncvdGVLeWU3dE1MWW9i?=
 =?utf-8?B?ZDJKS1ZHOWo4bVV4bk5zOHpvdkY1UmlnVHk0S0VtNVdjWWFCQXFKUDFWaEUw?=
 =?utf-8?B?dFJWSXJtUllyMHNsZG4vdUVnclZZczFpZTJnb25jMmVvb0RRd1BUb2dTT1Ns?=
 =?utf-8?B?ZjhReUtiV2hrUHMxemV6YkQ1VCtERGlBMzAreWNmS1NhRnlpNHB4a2c3Zm5Q?=
 =?utf-8?B?dTRDS1hBVGpUREdhREdiRVBXNitpZ3FCMkVrUTJPMkc0Q3BYTDdpRUhtUFVv?=
 =?utf-8?B?YnVjbjJYNnJOdjExRE9sWlYxMzViQ0JYeVE3TU0zeTNUb2ZHcjdaUTNjYUQ5?=
 =?utf-8?B?Q2NGQ01MQkxxdk9MSHN5aVA0Q0w4ck5jYmJrbms2d1VFYkFXcXpLL3crRTVv?=
 =?utf-8?B?cENMTDVPVVNYSC8xWkQzUS9MMXZTN2ZqdXhjT0NsK1Fhbjl6Y1JHaEZXS0ZL?=
 =?utf-8?B?ekJLeEgvK1JmWmdjb2hqRWFiOHpkVkxIU0xUcGM0b3ZJNVFHZnN3MnZISzhz?=
 =?utf-8?B?WXMvaHRKSlpJeVlURTJ4UzN3NmE5NFVEOU5IWm9uckVXdDZaQjE2ZFFIbnNh?=
 =?utf-8?B?MzJvbmo3YmtydTBCVi9qUFBiN0lPcmZiczNQV3RYYkgxbmVtM0s1KzNzbVYx?=
 =?utf-8?B?enFGbEo0aTZJam44Y2Y4bjN5ZGZOT2tLVE9GN0xiMTUrclU1NGFaQUJQWndJ?=
 =?utf-8?B?QjFwSzJIbE81R3FJSVFxWGQ4eUFlK1ppWG1VdytsVHh5N0NkenBQdStCRGZR?=
 =?utf-8?B?RHNZdlhjdjlJeEdoKzhJUnNycXlZdEdPRVVUVW0xVXQ2enZxK2U4ODRyTU9v?=
 =?utf-8?B?QXFld2ZjQTB5RUxzZjNuRVRpcDNaekdBdUJsTTVRbXE3Q2NIT1c0d1VGQXlu?=
 =?utf-8?B?TVRnYkZqSE9XWUhrZVk3SzJ6b0pnRE1aeGxvQTJyTVd2V0d1T1FEVGJQTEdD?=
 =?utf-8?B?UTUzaUJ2MzY4WGpjU3JsdFdGckJNcWkyalhFbWNINVJVMTdYNUlzQlppdzBB?=
 =?utf-8?B?MVlIclpYTVNSNzE2UVkyTmY5SlpscjQ1RmI2MThGbWc4OS9TQUEzZWJvY1VZ?=
 =?utf-8?B?L3JoV1U1VmQvS1gzM2Y0QnpMUGpMTWMwSWNIVkRkdytMRi9pbmtySVE3OWZI?=
 =?utf-8?B?a0grSjYvbGtZK2hXU3lrWjk4Ni91SmxBY1ZKemRvUVI2NWdLbGF1TkN2UW1U?=
 =?utf-8?B?VXFDSFpCVzYzVjdQYVdxVkRCNkNNMHZEYXMwRnNWZTB4ODkzVFBWRE01R056?=
 =?utf-8?B?NDd1K1VXQmsxNTgwSnhpS2U2L1IyQWREWmZnYkFkbFhLZ0RDY3haWUZ3K2d2?=
 =?utf-8?B?d0k3blgzQlZ6NlQwRFN2UDdxdzBBU2JQZUFQV1psMXpEaEJXT0dDNlN3dHA3?=
 =?utf-8?B?Vm5qbEs5RWpYV0F4MlVMMkRGSGdvYm9ONlgrU1F5MmtGTTNOakJ4ZmN0TXpk?=
 =?utf-8?B?dGNFQU1hdjZjUXRPTkdQV1Jrd0hVU1EyUUZmSWlKV1NuRktPc2R6ZVJpTFZI?=
 =?utf-8?Q?DAyxJI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDRUcEJudk5lRFdpdmtqM2Rvenp3TnJEN241VXVxUlJ2YXQvL2J0ZTdMN2JF?=
 =?utf-8?B?RGJKbStjQzlWVkZLajVKQWx1WkZHVzRxdktJTTNENGZOb3JtcldxWXFyUkpm?=
 =?utf-8?B?akwzV3lVeW9ITUFGYkJXK01RLzZhWC94VkdTbXZZS3llL1RDUHhvOUdjNFlw?=
 =?utf-8?B?bDYvQnl6VUZ1Q3VrdllsY1BGb0VHaWhtSEVQSjdSYTJuVE50d1RmVitIWHdX?=
 =?utf-8?B?eWZuWVFKVFJkbFE3cGFCRXV0a0VMVFN4Y0tzL3lPWTVla3Z4NTNDQUJwdisy?=
 =?utf-8?B?aWRjbjBvbkVMb3pob0w5Y2t4QjBzRVZmNGt2UUtPRGU3QzM0V2g2bUFsQVpt?=
 =?utf-8?B?Ui84dFh3Nmw2RFFHd2FEbXBMOWxvMmhQUWZIZ2c4cXhKRWRyTU84cG5UdVB2?=
 =?utf-8?B?WmVnZy9DT2hYdytWazRvS2h1bzFXYVpzOWNoUFFOaUd3aTRDTU5reHc3R1No?=
 =?utf-8?B?TlBXdGlVSVRFR2FST2dhKzkrcnRzNEV2dSs2YXBNblJ4VDMxNzVZZDhQeUtT?=
 =?utf-8?B?RE5kMmNtbEpLbko2Tmtsc0w2b1gwWXpLdWR6dXF3b1lISnNzelNIRDFwK3cz?=
 =?utf-8?B?cGNLSlc5dnRlZ1VkRnFuRW45c3ZpOUZkSXROengzTUkwc3lIVWtHRDFvNEtJ?=
 =?utf-8?B?M0h2d0VLQ3R2dkFtcWV6TThHeWlOV0RtWTJZK0xjeEdJOFNWV0lzTGFWZjBF?=
 =?utf-8?B?aEZtRDE3T0t0MjVQbTZDdnR6WG94N0lENUpwZzdoUHBHQmVQdmJXQXBIdWpM?=
 =?utf-8?B?bEQ4VThCMmJOdFEvbE9EdUdVcG5xVStLWXVQNkhxQ3hxZkVRUGtLemJqcSty?=
 =?utf-8?B?VGlnL1ZsWTVqZFJrcmd2b3NKc1dNTzhCUDV5bDEvUzMrelMydHRWUmpjOHZC?=
 =?utf-8?B?NlhzSzFTWFBCYlFyNDNZNVU0UFlHQjJJUUd0VmRLRHdqdmQzSExMUi94Uml5?=
 =?utf-8?B?bWsxTG5CdERSaFZQdnRPem01cHNRWnNsWFhraVliVkFMSUs3S3ZLMklZUjlp?=
 =?utf-8?B?L3AvZEU4M1ZRVFd2RkNOVDN3dFI5OU83WGJ2dENjWjZ2YW9HZWhTSE43SzND?=
 =?utf-8?B?bjdNUnFKck52ck5sM2hGK0ZyRXdZejdxb1hpbG1UZlNXcDRpd21HSGo5ZXZr?=
 =?utf-8?B?SUZPalJyQlpROE5UakZMK013VTZJdEhjcElscDg5VTJQa0gzaHVTV3J5MG5y?=
 =?utf-8?B?NG95VjZRSFF5V3ZPb3hmZUUvM0Q5SXo5NlBiOURNUlkyNnFJeUxQUW5aamhB?=
 =?utf-8?B?NEIrRmhoNVhyUnRvRFlNWVFtYUk4Y0FwODNZaDB4ejVzb3dBQmRVam1lVEVR?=
 =?utf-8?B?UUcxak90MHFHK3dKWFRnVU5CRFpmdnJtMWNWeHRRVTZSN1M4WGhpVWhraXlC?=
 =?utf-8?B?UDJUZ1JLMUZjWXMrOTJJWWV1eWRUUjJ3VWh4RFZIdUcwNzBVUEh4N3FOSXha?=
 =?utf-8?B?aU9yVk5aazhxQjFsR1diK3ZTS24rWUtYM0pId0g5MnlJVU5ucXBpcWt5clNY?=
 =?utf-8?B?Z0JPV1JnTm9USXlGcCt3OUo1cmRBK2MxbWJUQjI0U1piRTlSVTRmME4rVktk?=
 =?utf-8?B?Nk9PMEhUYkhRazBIdjdIWmhlTGk3bWVaUDFGWHY3N0pvbHVoS2Uwck1mYlc5?=
 =?utf-8?B?OEJoVDBqaEhHOTR4ckVtN2wzL2N2dEgyYTNSLy8zVTc5YldFTk5QQWRDS04w?=
 =?utf-8?B?cVA1R0R0SjBpaU1wczNzdTJ0czYwOTU3QnZnbFAwOHVpekQvWS84cURuRFdR?=
 =?utf-8?B?V290VU9wQmdqNHkwai9aRjJqOHNOeFEyVE1CT2MrSms5UGs3L0VxY01CbTBr?=
 =?utf-8?B?MVhZUWhrOVprRjE3VEtDbFhzdGo5L0krM1pxcXJOdmNCNWl6WGI1Z0UzbXVz?=
 =?utf-8?B?Zi9RU21JUEtuMGducktUTHI5bE1nazJTYkhpWGNEeWNMWGR3RUdrSXJyaDZ1?=
 =?utf-8?B?aDZGVlhTYWJCZ0JaR0t1UWhrbGU1TkhnZDNyS3gzUGtlQytmeHBraG5vdUtl?=
 =?utf-8?B?Tzd5Q0w5dXZDbWRLd1RaSUI1RFMwQVUwY0pYanY2VHF3d3Z2QkN2UmhYYkpU?=
 =?utf-8?B?S1VPS1QzWXFmSmRyb0k1UHMyL1gyWGZjbjQxUThWZm5TS3FwaThxU3REWUpz?=
 =?utf-8?Q?642k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 083f3b06-0d33-4e8c-d894-08de0ad129f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 03:24:20.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuojQfGGZx8rbRdI3JXUggEzWRKG8QglL/nSi5uVXDYryXV2qazw33NCfe1xL72ZPrj2ckTEJYZbvoKQlEuOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

PiA+IE9uIEZyaSwgT2N0IDEwLCAyMDI1IGF0IDAxOjUxOjM4UE0gKzAzMDAsIFZsYWRpbWlyIE9s
dGVhbiB3cm90ZToNCj4gPj4gT24gRnJpLCBPY3QgMTAsIDIwMjUgYXQgMTI6MzE6MzdQTSArMDMw
MCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4+Pj4gQWZ0ZXIgYXBwbHlpbmcgdGhlIHdvcmthcm91bmQg
Zm9yIGVycjA1MDA4OSwgdGhlIExTMTAyOEEgcGxhdGZvcm0NCj4gPj4+PiBleHBlcmllbmNlcyBS
Q1Ugc3RhbGxzIG9uIFJUIGtlcm5lbC4gVGhpcyBpc3N1ZSBpcyBjYXVzZWQgYnkgdGhlDQo+ID4+
Pj4gcmVjdXJzaXZlIGFjcXVpc2l0aW9uIG9mIHRoZSByZWFkIGxvY2sgZW5ldGNfbWRpb19sb2Nr
LiBIZXJlIGxpc3Qgc29tZQ0KPiA+Pj4+IG9mIHRoZSBjYWxsIHN0YWNrcyBpZGVudGlmaWVkIHVu
ZGVyIHRoZSBlbmV0Y19wb2xsIHBhdGggdGhhdCBtYXkgbGVhZCB0bw0KPiA+Pj4+IGEgZGVhZGxv
Y2s6DQo+ID4+Pj4NCj4gPj4+PiBlbmV0Y19wb2xsDQo+ID4+Pj4gICAgLT4gZW5ldGNfbG9ja19t
ZGlvDQo+ID4+Pj4gICAgLT4gZW5ldGNfY2xlYW5fcnhfcmluZyBPUiBuYXBpX2NvbXBsZXRlX2Rv
bmUNCj4gPj4+PiAgICAgICAtPiBuYXBpX2dyb19yZWNlaXZlDQo+ID4+Pj4gICAgICAgICAgLT4g
ZW5ldGNfc3RhcnRfeG1pdA0KPiA+Pj4+ICAgICAgICAgICAgIC0+IGVuZXRjX2xvY2tfbWRpbw0K
PiA+Pj4+ICAgICAgICAgICAgIC0+IGVuZXRjX21hcF90eF9idWZmcw0KPiA+Pj4+ICAgICAgICAg
ICAgIC0+IGVuZXRjX3VubG9ja19tZGlvDQo+ID4+Pj4gICAgLT4gZW5ldGNfdW5sb2NrX21kaW8N
Cj4gPj4+Pg0KPiA+Pj4+IEFmdGVyIGVuZXRjX3BvbGwgYWNxdWlyZXMgdGhlIHJlYWQgbG9jaywg
YSBoaWdoZXItcHJpb3JpdHkgd3JpdGVyIGF0dGVtcHRzDQo+ID4+Pj4gdG8gYWNxdWlyZSB0aGUg
bG9jaywgY2F1c2luZyBwcmVlbXB0aW9uLiBUaGUgd3JpdGVyIGRldGVjdHMgdGhhdCBhDQo+ID4+
Pj4gcmVhZCBsb2NrIGlzIGFscmVhZHkgaGVsZCBhbmQgaXMgc2NoZWR1bGVkIG91dC4gSG93ZXZl
ciwgcmVhZGVycyB1bmRlcg0KPiA+Pj4+IGVuZXRjX3BvbGwgY2Fubm90IGFjcXVpcmUgdGhlIHJl
YWQgbG9jayBhZ2FpbiBiZWNhdXNlIGEgd3JpdGVyIGlzIGFscmVhZHkNCj4gPj4+PiB3YWl0aW5n
LCBsZWFkaW5nIHRvIGEgdGhyZWFkIGhhbmcuDQo+ID4+Pj4NCj4gPj4+PiBDdXJyZW50bHksIHRo
ZSBkZWFkbG9jayBpcyBhdm9pZGVkIGJ5IGFkanVzdGluZyBlbmV0Y19sb2NrX21kaW8gdG8gcHJl
dmVudA0KPiA+Pj4+IHJlY3Vyc2l2ZSBsb2NrIGFjcXVpc2l0aW9uLg0KPiA+Pj4+DQo+ID4+Pj4g
Rml4ZXM6IDZkMzZlY2RiYzQ0MSAoIm5ldDogZW5ldGM6IHRha2UgdGhlIE1ESU8gbG9jayBvbmx5
IG9uY2UgcGVyIE5BUEkNCj4gcG9sbA0KPiA+Pj4+IGN5Y2xlIikNCj4gPj4+PiBTaWduZWQtb2Zm
LWJ5OiBKaWFucGVuZyBDaGFuZyA8amlhbnBlbmcuY2hhbmcuY25Ad2luZHJpdmVyLmNvbT4NCj4g
Pj4+IEFja2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBI
aSBWbGFkaW1pciwNCj4gPj4+DQo+ID4+PiBEbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/IFRoaXMg
cGF0Y2ggd2lsbCBjYXVzZSB0aGUgcmVncmVzc2lvbiBvZg0KPiBwZXJmb3JtYW5jZQ0KPiA+Pj4g
ZGVncmFkYXRpb24sIGJ1dCB0aGUgUkNVIHN0YWxscyBhcmUgbW9yZSBzZXZlcmUuDQo+ID4+Pg0K
PiA+PiBJJ20gZmluZSB3aXRoIHRoZSBjaGFuZ2UgaW4gcHJpbmNpcGxlLiBJdCdzIG15IGZhdWx0
IGJlY2F1c2UgSSBkaWRuJ3QNCj4gPj4gdW5kZXJzdGFuZCBob3cgcndsb2NrIHdyaXRlciBzdGFy
dmF0aW9uIHByZXZlbnRpb24gaXMgaW1wbGVtZW50ZWQsIEkNCj4gPj4gdGhvdWdodCB0aGVyZSB3
b3VsZCBiZSBubyBwcm9ibGVtIHdpdGggcmVlbnRyYW50IHJlYWRlcnMuDQo+ID4+DQo+ID4+IEJ1
dCBJIHdvbmRlciBpZiB4ZHBfZG9fZmx1c2goKSBzaG91bGRuJ3QgYWxzbyBiZSBvdXRzaWRlIHRo
ZQ0KPiBlbmV0Y19sb2NrX21kaW8oKQ0KPiA+PiBzZWN0aW9uLiBGbHVzaGluZyBYRFAgYnVmZnMg
d2l0aCBYRFBfUkVESVJFQ1QgYWN0aW9uIG1pZ2h0IGxlYWQgdG8NCj4gPj4gZW5ldGNfeGRwX3ht
aXQoKSBiZWluZyBjYWxsZWQsIHdoaWNoIGFsc28gdGFrZXMgdGhlIGxvY2suLi4NCj4gPiBBbmQg
SSB0aGluayB0aGUgc2FtZSBjb25jZXJuIGV4aXN0cyBmb3IgdGhlIHhkcF9kb19yZWRpcmVjdCgp
IGNhbGxzLg0KPiA+IE1vc3Qgb2YgdGhlIHRpbWUgaXQgd2lsbCBiZSBmaW5lLCBidXQgd2hlbiB0
aGUgYmF0Y2ggZmlsbHMgdXAgaXQgd2lsbCBiZQ0KPiA+IGF1dG8tZmx1c2hlZCBieSBicV9lbnF1
ZXVlKCk6DQo+ID4NCj4gPiAgICAgICAgICBpZiAodW5saWtlbHkoYnEtPmNvdW50ID09IERFVl9N
QVBfQlVMS19TSVpFKSkNCj4gPiAgICAgICAgICAgICAgICAgIGJxX3htaXRfYWxsKGJxLCAwKTsN
Cj4gDQo+IEhpIFZsYWRpbWlyLCBXZWksDQo+IA0KPiBJZiB4ZHBfZG9fZmx1c2ggYW5kIHhkcF9k
b19yZWRpcmVjdCBjYW4gcG90ZW50aWFsbHkgY2FsbCBlbmV0Y194ZHBfeG1pdCwNCj4gd2Ugc2hv
dWxkIG1vdmUgdGhlbSBvdXRzaWRlIG9mIGVuZXRjX2xvY2tfbWRpby4NCj4gDQo+IElmIHRoZXJl
IGFyZSBubyBmdXJ0aGVyIGNvbW1lbnRzLCBJIHdpbGwgcmVwb3N0IHRoZSBwYXRjaCB3aXRoIGZp
eGVzIGZvcg0KPiB4ZHBfZG9fZmx1c2ggYW5kIHhkcF9kb19yZWRpcmVjdC4NCj4gDQpNYW55IHRo
YW5rcywgSSBoYXZlIG5vIGZ1cnRoZXIgY29tbWVudHMuDQoNCg==

