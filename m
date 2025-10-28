Return-Path: <netdev+bounces-233548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0EC154AD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B494134F70B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904A03396FE;
	Tue, 28 Oct 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V78cWNcG"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43033769A;
	Tue, 28 Oct 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663512; cv=fail; b=jbY3YgdP2YWqBSLT4UpPrBI6cwXgISs09sp4yOBLtxzotUtn0J4e93LRr45bkdhdff6cwri0TdHOpKIrvKMfCovicUmLqheaq1RE+r1dO02ctlisdMgJBNjJ00JJ5s80fGdwtn9VsoHhwTnNAfMX4JPxiUtu5+wNP26yhPa/QzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663512; c=relaxed/simple;
	bh=1NYBqzl70VSYGILH9LDJJJnS2mVns0vtE+chrPAnjhA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dmuj8mCmRA2NITFVo1JphizDPsdhPMT0uE31qBhvV1D/3Zabvtu0F4GW0EZ7Xhhm2lhrlWNmi6vtCDICTRBSB7eu4I3G9zTYRowkM1NgjDOtIJddR/9GLNEAGaG3tnHznkUGN4aTk1F6E3H2ZE5D8jvJon0I9bvZ6oxdlsersf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V78cWNcG; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea3ERrIItwmur6/W+yGuyXPTOUEJQY0RmbhKsu52o6olh6fIrgXF5ON1k2Ez09djPjWwszzu1+H7y2PIevygjJEiAjJabJ7O0QKzCZVWopfJO2CuANE0rL7h95348++RR1sQsfey3jtqmUABD+v7Ua6hIM1Yib6RFGQ5i9HJuVMFOWb1cwlcTCjvWBGvxkS62YcVYjXljMc/GDAU3ad3nXl4gBK2S3XzM2iWV76O4chcwV1V5PVtkGZ7igTumTp8PoILWdqQnHIC9BHDw43v/aIJlpyr6hOvW7B1DCu2MU3/Fm7M4dDzRx9C65zZgJWL0k2BWrQgIilsRGNRgSphZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajTvyKYEsykWzP3CtlJ0W6g+/PUGzj8Pia5CyEaw0AU=;
 b=h7nMUX6yHqiWpcMsRA4uIhG4BcQcUseHuayJzeO2N2+VyHIurqGWd6Jxq/C4Ojxgti5Ln9C7hU5w+4NOheoMoZSpkNkVVTw3dUJO27lKnOB8tf1sk/R6tCoPjgnBZJ92vb6HqDAv8Ug0MDj23xzicI3S606Dae+nf+1P1xOT4oj5gm5c4qGQZSxqAczHS0wkwsbZ05q1ftkBPfQMaDNLlID/xgHJE/RMo2DMO/WLTAJaGXM7nJ6uF/745aCRCm0fO51oiLzSKNCPUiXB/Yb8UjPdeKlHkn/RxBgLrnDFG/PZ5Fj65iLDHSxkcKNhoUp5/IqG4towwahAveClAS0w+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajTvyKYEsykWzP3CtlJ0W6g+/PUGzj8Pia5CyEaw0AU=;
 b=V78cWNcG84oTv4trb7a+RXoTbcs683LsCL8ykKMxhNJdL/4FlM674BAcNJNLWa/Bkb44ktV9xKFJWlWyNQYw3v4ee4uMG+5EIiV5x4C24vutwbFEQ7OELeBggXwh5S+oIpTTDPyZeWF4GdUPru0TRLgzsYkX3QxE3reIS/GF5NrNh853AP5X14K73AM4N1AQq3n+VEPyD8GDEkuzb5BxJgBqmxKcfSa13wXHwQJDYtf5rWrjcGLYp6vhN8u3nZwfPd+T7a9XsH/BTbEH8QKJtn0/6ofCag26WWszyKeMHaX4+qtPJ4Q9I1Obb2bll7eyGJ4WQ1YYSoJvo3UgaG0SaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:58:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:58:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:57:53 -0400
Subject: [PATCH 2/4] net: mctp i3c: switch to use i3c_xfer from
 i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-lm75-v1-2-9bf88989c49c@nxp.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
In-Reply-To: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-i3c@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761663488; l=2142;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1NYBqzl70VSYGILH9LDJJJnS2mVns0vtE+chrPAnjhA=;
 b=snXl9RDfZn+ie6TMwxRjrxbeLUHGuEotyBBzlzDbsVz4t4HiR/yYdvQt6AFg4ybaXW44n+GRq
 2M/avyD4YZgC3G91lORgixjeN+2GuCYtUPA+wuaVtw1BDnVdA9dDe+2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c64ddac-e0aa-4116-5284-08de16326f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2Qxb0VYelBKdGJ4Z3NWR2s2OG5uTzhKamJCU25neHhJTlUrWmtReUtYemxT?=
 =?utf-8?B?dmQ3bG9pVFdlNUNaVzkrNjFqYkNITE1WNWZ4N0srRU5Ca1R0KzgwWTFIa29Q?=
 =?utf-8?B?YWRIUWpRZW1pNWFDcGgwM0EvM080YzZ3RGZQbnhkNEhlWmttYzZBcno3Z1Fa?=
 =?utf-8?B?cjFlMFNQSU5HUmJSZmdYVU1qUE4zZHh4enUvTEZvR2EwQy9nVXNSYkltZzVT?=
 =?utf-8?B?WWl4WlBIeklUWVEyYW1qL1k2KzdYbk51Sy9zNHpnMjU2TG04VzQ0NHBEeEcz?=
 =?utf-8?B?RCt6a1dPVURCMVFXSU1XYkphQnYwbHZlMjJIZ3JCTDAzTkFaR1ZGZG1sR1Qx?=
 =?utf-8?B?b0h2QVh0enBrbzJBSStraGpIc3Bwa3B2NWV3OTJPTGRjdVgwbmcvVXd3cmt3?=
 =?utf-8?B?d1ExdFRxVlpWUThNWmd2d1VYLzRMMjdET1A3ZnoxbHJwelEvL3BiNHdtc2pB?=
 =?utf-8?B?eTc5N290RjlOOGR2NGJ0WkYzYjlsZmswZk9LREhXd2JXYXdMdHZEMnhNYjhs?=
 =?utf-8?B?WFhvaURYU1RyY0hFczdFSFVzemZBb1ZqUE1kMndUT2xLY1Y1WURVV1lJaVA1?=
 =?utf-8?B?cTM5anNtWXVtWHZSRklrSnVxK3dRdkh1VHNzdlRnaHlPcTRZSWc0MkhYUXNK?=
 =?utf-8?B?Y3pFUkwwTjlZY0tlVVlIb1B2cmJrdlAyakdKY3pYRlRscHMrVXM3cVFicnkz?=
 =?utf-8?B?dTcwR3k4RDQ4cDNLMU9Hc29BVUFmaE9XT3BQQnZYNVRvYmhFUEt1NENFVmU2?=
 =?utf-8?B?VUlhL09EYmdXMktwQWdhdXNDVTQzQTRDdmZLRTJ4UmtHM0djSzFtU2x2N1VI?=
 =?utf-8?B?R090ckIwZ0p6ZytzM0ZJRHgxcWpid1gwSHlPei9xZ0d3U1pYUEFramlFbEdw?=
 =?utf-8?B?WVdLckhzNzN1MzNCNXFDWkx4V05vYUxicXJPbWFyYVJwcVYxL1VFR2M0Z1ls?=
 =?utf-8?B?UnpqcFc0RE1MZHRmN3VoRG9waTZROVBqL1VUWUdCSVpmTzNzcDhrdXk0RVR1?=
 =?utf-8?B?clkyeDRCZzBxQUUvQkwzZ1FLTTVybm1neHdLZld2bXRUMnNCeUtwSGFzdDZi?=
 =?utf-8?B?T29RR1JuT1A5K2NkVkdUejVSVGF3RUk2MXMvTVU0NXlXUll0Y0lsOXkydTRw?=
 =?utf-8?B?Y2pnaHM0ejZFenFhN0ZNMG9PdWhHNFZaUU1GaFg3bGhSV0puV2tWTzdMenpR?=
 =?utf-8?B?MnA1OXRqRlRialAvdjlFQVhLN3dLNnlqNGtlYXUwVno1VFloQmt2QTVmaDJQ?=
 =?utf-8?B?KytTajlTV21EanR5enZtUzdhQU9RUVdnT1hDSkxUS0ZON3JQQVRGOVoxMVpX?=
 =?utf-8?B?Y3p3Z1FBNkRNL2g5OHFiYlRXQjIwMFdDYlpydy9IdElYMDVnd3kxTHhZa0Uz?=
 =?utf-8?B?ODFTY2RMUHpMOThxWHNwOFpUWVB2MVRZRXh6MGNPK1FhL2w1NXBtKzM0ZGVp?=
 =?utf-8?B?aURHZFNtWk1EcWxrL2VMUktpSUFZK3lVUUtqOWJwbnpDT29nT1pRcXpXYjZ2?=
 =?utf-8?B?aHpmU1FQY2dMenRGQmg4eUNaRUtoR05odTNCT0ZiMURvRGx2MGJxdVpSb1dR?=
 =?utf-8?B?cWE4K3pjYmllM0o3Y3hmakQyVUgrck9QMEk5R3UyaDZUVzdWSUFpaVhHZEww?=
 =?utf-8?B?RzNsK1M4V25ncVZQL2NZVkdUZk5TVDZlSlhORnRqYTZCUThtV3grZzVhb3FR?=
 =?utf-8?B?TUUrZXdhSkl2Mkh5YUxyajJONW13aG5WLzBweUQ0TmNibTVKcXZFWkhPb3Ax?=
 =?utf-8?B?MUNYWjZjL2ZmaEF5SmlXLzhIem9tUWJ3VzFadG5Hb1JFV3AyN3N4ZEFBbUFZ?=
 =?utf-8?B?LzNmZlZUSEM4MUdLejl1RXd2R1hXZ3BoekVLU0VyMGEyUmo0d25aWFFBNVZr?=
 =?utf-8?B?WGduR2cxQzB6RUxxY1RROXRDUXF1c0ZiRHBiT2VjdEpRd2RZdXpxb3JNOVM1?=
 =?utf-8?B?dFN1cnRBMWJic0tKdzI2ZnRYN3l6UDJKVkVvSzZIcDhOY0RWZ3J5U3N3WmlP?=
 =?utf-8?B?SzR6a1FodnF1UUlPVnJMLzJmOThTSFNwMW02em1EeW40bmdNbG1hZ0FMc1BN?=
 =?utf-8?B?L1dzMVhocVAwVGt4aDdpUWpBY0xtOFg4aDErQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFl2RHAzWkJvVEZGbklkdGNOVTc3UVQ2MkJTQjdheVpQSWE1dkIwZENUR2U5?=
 =?utf-8?B?d3Vnd3NDQ2p5bUtzS3hCUXBHTEc3TDQ5YlBxbUNvMG5mUTJqUllzU0g4bWVz?=
 =?utf-8?B?ck9tblpSWVo2TDRpZk9rK2pad3hrM0ZmeGtjd3ZIeVlPOHROWEJLMWQvWnNK?=
 =?utf-8?B?d2ZwQVI1cFdtaWpRZG9kYWdCazQwajFhMlBJZW83aFBKcUoyeHJpbTUzSExy?=
 =?utf-8?B?TjM4OE4yaGFzSzRpRHIxVDk5bm4zd0NrZUNTQmxsV0cwYXpCaFNWV3doazl6?=
 =?utf-8?B?cmhncldOYVJZaDAzSkNteW9WTjJMWUEvTHdxNi8vaU43cUR2NEd3NkNuTEpJ?=
 =?utf-8?B?ckp4ZWFvdlhOeWJZZ1U2UXlORmwvZlQyY0NzZ3BUc09tLytOTTBZTDBjQ25I?=
 =?utf-8?B?cmRIcFB1K3ZhU0RNQ2E2R3pRRFJEcmI0aHhGbVlnWGdEVURFRW93T1FHT2pS?=
 =?utf-8?B?OXdXZmhzMFYwMU4zbHFYaDdsRG1yL2NteUQweXd6QVphQ0dMdEFiNVdTSXBT?=
 =?utf-8?B?am44QUtNUTc0ZlRZclpxcE9xZFdWazhGM2t0dmxKRHM2RFFuQ01JeHZqZkla?=
 =?utf-8?B?bmt3a3E1MFdhVUpCVWVXVktTNmtoK2p3bTZBKzhlenhuWVBTc0hvTXNUTWRu?=
 =?utf-8?B?WTNHTnhKek5FM1lsdGx0S3VnYWpIK0JUY3h0V0g3NUtnWDg1RVh5eDM2N3VP?=
 =?utf-8?B?d3kvL1MyNTJlclcxNEg2aDZsYUROaTBXSlRkSVYyd2s5SFczdytyZUhPa2NM?=
 =?utf-8?B?R1p1bzRFRGFjSmhCYVBIU3QxQmJQWkdieW5sVjYwejJhRjRadUdlVURrQ1RZ?=
 =?utf-8?B?N2Qxdkx5a1B6Y0tSNVpGb1RPK3FOZlJQb2Zhbmc2L0UxUEh5UUdnV1RySWpr?=
 =?utf-8?B?QWttUTREdyttK29qamUwY0JEelZJWnV6ZVA3ZmNQUmk1cVdoN01HMnRjcEpE?=
 =?utf-8?B?cDBCTGd2U1VvSVZDdE9WdTg1bFhwYnhudUVpc1IybGhKcWk4UlRSSkNXWHVV?=
 =?utf-8?B?REFQUU5wNHZZNzduWjJzTXpxMGl4VkdDenFrdjZmQUQ4SEFGRnVKaFJqK0xC?=
 =?utf-8?B?U3B2Zm81SE4zejBCdkY3Vm5acUZsUS9UNXRiZUE5OFJDMEZOdG1KcE9ZZkhv?=
 =?utf-8?B?SC9BUG9FTUsrMkhyS0wzdUVMZ1d1NkFGbmg5N1ZMV1kxbloyOUw4Yi9kMFlJ?=
 =?utf-8?B?REY0czZQZm1mUnNQTjNkRGtlbDI1NVFwcEFLSFFTbG1ISDRLWDJQUHNlL2g4?=
 =?utf-8?B?T1lnODh3TEUxTVc0b2M0cHNDYzROZUFybm5yeGp4V0l3SmZxcDU3eUVqSitu?=
 =?utf-8?B?M3AvQitMOHc5SUM5Z3EzODkvNEF1L1lCMG1BTktTZXhZSGhvTVc2N1BMbmkz?=
 =?utf-8?B?NXF2SlBxVVd4KzIxZlVYN1RwNFFnaEpyYmVrdGVNTk96Sk9YK0EwR0dOVVIz?=
 =?utf-8?B?elowVm5TWGF1SEdpTkdFQ1l2cm9UM2UxZTF2MGIzMEtHVWlWVUoraXZHQUV6?=
 =?utf-8?B?UnJvckxxRGVtRHlCU3lqYWwwU3lIVHBHTU9BOE9xKzhvY3haOS9xeFVvUnN2?=
 =?utf-8?B?RGdCUkNadW56TTRud1BpZkw1cjVxekFPNmxoZlNvQUprTDMxNUJlVkdOaW5o?=
 =?utf-8?B?c3dUOWpvcTV1Qk1sV0RtemNPbWN3VCs5U3d1K3o4TUluNVU0L2lTRC84Ly9p?=
 =?utf-8?B?Yko4TDl1MW1aZkh2UlRPbnNjVjVGZmJNUWpWcEYyc1UrR21Kc3hlVUxPdVd0?=
 =?utf-8?B?ZkRFS0N5emhTVmhwUmk4b0w1YlY2d0pBUnJCbGhOSUxDQTg2YnAyWmY2UDRT?=
 =?utf-8?B?QmUzSVFqWmpDeEszSUx0aGFqQ0cvTXI5MFRnNEwxMEdCazdiTFZidDlBci8y?=
 =?utf-8?B?b1B6YzJVaXVDSzdmZkp4WVp2eWs0M3hTdk8ydzNIMjRDVlV2VmdyQ1I1VWwz?=
 =?utf-8?B?Z0trZFJZNHdhdjNONEdUemhKR2JKbldDL0NuUGsyYmVGMTByeHEvRmpMdzhG?=
 =?utf-8?B?UHhUM1NGY3QzeEFjZ1VBR24vTmw3U0lWbzhJYnpWMkdXZ0NYcjBRcE1OVzBm?=
 =?utf-8?B?YUptNVNVQk01bk1KMTg1dGFHRWp1angwbTdNMjF6dzQ1MEYvc0hRYzhyZ1Ur?=
 =?utf-8?Q?bVj8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c64ddac-e0aa-4116-5284-08de16326f2c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:58:20.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ+zzGDtkfo3jMkBe+BRzt6wCC2XRaCTyo5X8dJsrhXaSfwL0krHyy6cAJb+L6yjqJPZQEkqU/hMaBXNMD6LdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

Switch to use i3c_xfer instead of i3c_priv_xfer because framework will
update to support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Replace i3c_device_do_priv_xfers() with i3c_device_do_xfers(..., I3C_SDR)
to align with the new API.

Prepare for removal of i3c_priv_xfer and i3c_device_do_priv_xfers().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/mctp/mctp-i3c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index c678f79aa35611272a4a410c14dcaeea290d265c..36c2405677c2c25fb1a48174b9d7e46aedde01ae 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -99,7 +99,7 @@ struct mctp_i3c_internal_hdr {
 
 static int mctp_i3c_read(struct mctp_i3c_device *mi)
 {
-	struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
+	struct i3c_xfer xfer = { .rnw = 1, .len = mi->mrl };
 	struct net_device_stats *stats = &mi->mbus->ndev->stats;
 	struct mctp_i3c_internal_hdr *ihdr = NULL;
 	struct sk_buff *skb = NULL;
@@ -127,7 +127,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 
 	/* Make sure netif_rx() is read in the same order as i3c. */
 	mutex_lock(&mi->lock);
-	rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
+	rc = i3c_device_do_xfers(mi->i3c, &xfer, 1, I3C_SDR);
 	if (rc < 0)
 		goto err;
 
@@ -360,7 +360,7 @@ mctp_i3c_lookup(struct mctp_i3c_bus *mbus, u64 pid)
 static void mctp_i3c_xmit(struct mctp_i3c_bus *mbus, struct sk_buff *skb)
 {
 	struct net_device_stats *stats = &mbus->ndev->stats;
-	struct i3c_priv_xfer xfer = { .rnw = false };
+	struct i3c_xfer xfer = { .rnw = false };
 	struct mctp_i3c_internal_hdr *ihdr = NULL;
 	struct mctp_i3c_device *mi = NULL;
 	unsigned int data_len;
@@ -409,7 +409,7 @@ static void mctp_i3c_xmit(struct mctp_i3c_bus *mbus, struct sk_buff *skb)
 	data[data_len] = pec;
 
 	xfer.data.out = data;
-	rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
+	rc = i3c_device_do_xfers(mi->i3c, &xfer, 1, I3C_SDR);
 	if (rc == 0) {
 		stats->tx_bytes += data_len;
 		stats->tx_packets++;

-- 
2.34.1


