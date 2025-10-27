Return-Path: <netdev+bounces-233224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915DC0EE9F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0167188AAFE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7122C325C;
	Mon, 27 Oct 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="N/1mvbud";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="LxLSBSdl"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay99-hz2-if1.hornetsecurity.com (mx-relay99-hz2-if1.hornetsecurity.com [94.100.137.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA72566DD
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.109
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578152; cv=fail; b=T3ZOoLz4jRo+Eqr2iOQotajs348p3YLSFTjjC5zUuK6eWdAZ/LtjLE06myPAQkcz71pW7E3oqW+KwdD60kpCasYXzPb8xM71A7pYgXSA4+8l/wqWEjQpsbb7dS7K/m8q2OhBpNZ+hpVwNNr3XEN7MGxS/wINwoMpbaxc6tV1oRA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578152; c=relaxed/simple;
	bh=FHjUKa0Jsin1hqlm7MHYs3RUL88wADD/Mro6m5rkEK0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:
	 MIME-Version:Content-Type; b=ZaOSBdDg2wdmOazcU1bjjGdk8+gBt3hHlafb3UIxcFB97NaQRLiSOU7hyyw5RG/P0MQ+DEzslkhwE+r6ggvmgSP3nu9smlGIiQ6cmNTy8wHC82D6SLZcbNLPetynBI5jOMX5uIiNQy2Sm6LQrHCW2ScifIPwikV3eGVf+gjBT+E=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=N/1mvbud reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=LxLSBSdl; arc=fail smtp.client-ip=94.100.137.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate99-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.65.102, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=du2pr03cu002.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=Sma1VzBwGZ2GFd+oOU/Es2I/ZSgtxEVEKIrUJGHln4o=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761578145;
 b=Xu92vORht8HlAusq/MdI1A2EfUmK3clhmZB75rYxTB1UJ8u0/yU+vf+7D1jVHbER9tkVT70K
 gjyBX3wUYURIOYasdKWJ/pROw/L8IQIrx91zOw+u4qfsA7ysV4b+tDwLtIpRPupABcgKIrLJ2qu
 FicVUcUlrrhr78xc5QfKCUaJgLlbFFKyXJ1GrV4BIyRhZDrQ/eorZet704YRYjv+4NHXgYimK4A
 MvM/8EhJnwgdge43j/EQ4Mr3ElNRn6SNvgAxK4Fm6dU/yg6RVNRvVq1Bc5FGM7Zqrx6ztHvyDVK
 IlaSRmTus4vTTE78NkcAe3J7Lif/ZhoM1oEWeQF/IHE5A==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761578145;
 b=nAGZIgutzEVNWVRR56X6Ge3r4EabHVDcivX5piEY7PXUcYNH1JjpLq2xV3MqboOqfZHW44E5
 yQwCMFi1Lq9yYT8fmmlJ0p2s6K/d9dl1vlC08Elp0YSsoCzVyAmDcELf5vStFiYo3YMQn8V29q6
 j8YVSgywM7N/Dvu0DAkfJMSobwS2PqcD3dm4q9IIrjemcNYJtn8EifuTzyII3wch8WH/6hhsV8w
 gVBVXKXNVHCji/QcBE8cxs3/EZ+Iy7iN9AEe/jV0378pcLhcyViGavYJsOR+zoU5uZ8XCKqU1G0
 hz9XVbrorYE0ykVuFaBpTUa7usozMoV0ZiTb4E+E2UC6w==
Received: from mail-northeuropeazon11021102.outbound.protection.outlook.com ([52.101.65.102]) by mx-relay99-hz2.antispameurope.com;
 Mon, 27 Oct 2025 16:15:45 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thwYlGhzKmp3dTuxvGvs7pWeRsU2rE5Imi3KmPTfiWYuAlFRUNLRUDNSrm+N0QF5cuAXSU/8PJ4eMjzhdujG8WEoqe4WU4wpvdbxHo9uOlVjjpRFJgN2GEUMlJx6hT57pp3HrABLkbdGLOwEOsaHoGMgbJYTat0koka8nMFaIm1UZkFmK/KIGcNMyZLvONQU2sppq0tnehEHcqFkK+lcLLoi9xjtkriHStA+vrNqBRFvJ7frBBqpRjePiy1oRVekLzzgmjmfCtyZZx3Ndppq2GJobh6zI2KosNPnHOU+8mwrkonG0aERdWSg0/TfKoNo/zuCcqNPuJJ3p15tsG87ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w52phcheU8zqdmTIwok9cX89n7LQRpYFLl0EAosiHVQ=;
 b=eYCoLqOagrMW02UKbgnWIg5xS1ydaPRdLmzcsRbZB1YG7KlxmeEDorF62tHFO9wi5qHZ8o5EqB3pT6ayUIh5SrTVveDWo7BJ5pBd1xwq1N/zu513Qi1bjsw0ogGfjiIQwayyIsryIyAzjenY+LrfSQVQznu+BbRryOC+Uq4/fMJin3ZBJFxNvKfmoBwxU/d2FcKg2Xu7J7NRX4nHKINbKI4c6Nokhc5nHk6agnac9DjiN9WRqEZ0MxW02UrlQVH9IaesbxgIBkGSjy0zvBDjivzlly33GO0f2fW6rgn0AdtEvuyG0nDeUmxfvaXaBdt37LKMXxVfybYRspE8RBWsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w52phcheU8zqdmTIwok9cX89n7LQRpYFLl0EAosiHVQ=;
 b=N/1mvbudnelKpdS58q/z54TcG1KR2Kgi5xFGUdJJmiIE8H296ZRH7L9Q1tBeTnjNDxlx9qLmiJP7Nv4PXCo83ulqG3k4FHnFXzPNVBX77tJylbwW2x4n5J6C+DsJBnJiDWnxMe9TdC+OYqYJ8yNNnS75+oHjIOXtEaEBZKFJPSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by GVXPR10MB8784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 15:15:22 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:15:21 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Mon, 27 Oct 2025 16:15:11 +0100
Subject: [PATCH ethtool v4 1/2] sfpid: Fix JSON output of SFP diagnostics
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-module-info-json-v4-1-04ea9f7a12a5@a-eberle.de>
References: <20251027-fix-module-info-json-v4-0-04ea9f7a12a5@a-eberle.de>
In-Reply-To: <20251027-fix-module-info-json-v4-0-04ea9f7a12a5@a-eberle.de>
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761578119; l=1288;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=kvosG01SGkXySoK4NwRHxjhexte6vCfAW3rUnBcLAO8=;
 b=lzmDcVTawlSJ0KTDFpKd4StsTQkfvScr4n3FOYmmvBKQ6jD9MNjGdd1epsThuRh3z9bJcO5C+
 HbdNBgt+LQxCdYYWDMCplcIg67R3ogLscmZfOiHgDe0tNhWxz0/xMXI
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|GVXPR10MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: aefb01f8-9d1a-44bd-2205-08de156ba5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWp5K0o2aWNyNW5VNlMyZDQ5cmlHNHRIeVZ3VlduSFRaczJpYWhXVW9aYUtK?=
 =?utf-8?B?ZEtIUjF2M2pROElqdmttL0VaZGljcHdaNGV6Z2hzelhCL1ZCZGh2NmdiSE1k?=
 =?utf-8?B?RUgxamZuSjhvV2V0aWZEa0NuZEtIS2RqYkIwQXpQZDNOWWh1WUorRFpJcXll?=
 =?utf-8?B?bnRlUTQ1MWIwdWlxMGNYazdISkFyYkZma3BiUjRtcjczbVJlVXY2Q3dYSDMw?=
 =?utf-8?B?SXk5U1VmalNYWjNCdVREcFFoYlh6Nk1aRlFNL25LQzU2RXZxcldITEl1dGN3?=
 =?utf-8?B?ZkVMaURaRi9rRVJGOC83UWJjTkJ3ekxOVFZ4TFRYWlYrTXJjUVNNUDVLZlRs?=
 =?utf-8?B?YWs0WWdISGdXbHppc01FWWF6dDF2alFGQzNVVWZDdUdUMTYyVFlCdFdieGFV?=
 =?utf-8?B?T0tuTUE5MXYwcFlhODZPTHp2dFNnQnM4L3J4dWpid296K1JSWW01OVlXcXZV?=
 =?utf-8?B?SWZXdGJQbTNHQkZtR3RGQ21ycFNkTDM3Q3I2ZlZITWhndHMzNWI4ZjZPNk9N?=
 =?utf-8?B?Mmo3alp1R3hFZFozZ0ZlODVSNU83aGthMnM0aUJXNGNQOUs3T05qeENMTXNu?=
 =?utf-8?B?UGNxWVFWNlJ0eElPZEZFRGw1Tm1DOTFVL1BMelpTaWxMZWVaNjM4UHJMakNt?=
 =?utf-8?B?RVlsTHVoNER6YmlxVnY0eXQwbFFJM080cmcrLzlnazg3ZGdHektsa25lVEFL?=
 =?utf-8?B?cTIzQVJNandMQjI3ZURkbkd3TlcwWkFZR1JxVjVEbFpDTkZ1WTBzL3k5YWpO?=
 =?utf-8?B?bXZ4ak5ZbEMrTUpwUlY2S01zR25PK3p2UmJRQldqMFF5c3FPVnhDL2FGUysy?=
 =?utf-8?B?R1Vmcm44SnZDbUVqZjRvY2VHRUtBM0EycjI5cDEvdzV0WWM5SDU4cXUzT2d0?=
 =?utf-8?B?WXRzSnp0ZENlMjFkUjlJZ0F5ZEJ6aTFIQ1VWb1c0TVBGay80NjhFeGp4OWFm?=
 =?utf-8?B?SE9SbDVLcnZTRjRtMExrWW1XU3dZaDlxbEZrSHY2cDdCcE9IOU5MT1YwVm1l?=
 =?utf-8?B?eFowSnROMUh3cU1USm5zVDNBZVIrS2g1Z2JIYUV2cEdtWkxNRUdlVldENVlr?=
 =?utf-8?B?WWFiTE45S2Y5U1o0UUE0bGQxZEpyZytzeDZXQi92NGgzWWd2MlpsekZObUlh?=
 =?utf-8?B?eVRISzJzTGY1V29OcWcyNGIwUUl3REErbUZmelhTd2lDWUZPQ3F4TDFYK3gv?=
 =?utf-8?B?OGF3bkozWml5N0Fuejg3eTZ3ZWJtVzVHOEtIY0xkYk1PRlE3Vy91U0FNd3J6?=
 =?utf-8?B?dTc0U0dkMS9JMW5BNW1FVUM1R24zSFoyV1JFa21xNmR3Mkwyc2h2Y25kS2xw?=
 =?utf-8?B?STBrRXdBV21ubTV2M2VpWDZCSUtCVEZCRjVLaHo1dnJRUFdKdjNudzlocnNX?=
 =?utf-8?B?KzBLZ01KM1A4b01lSmRPMTdSRzM0QjVhTnNRRDhLVkVWaElHL29vZzIzZVkw?=
 =?utf-8?B?ZFIvSmg3M1Q4SWQ5N0Vta3R5TnRaSTdYbVpxaWRteCtPNjZSN1VMamdBcWVR?=
 =?utf-8?B?Sjd4OXZFa2xnVzRpckc5L0VydW9zMTJRNjM0aTZzUXBIODRualRleUFoSjda?=
 =?utf-8?B?VitvM3daRFN4N1RFOFlNMU1rc20wd2Fhc2U2TGsrRXc3RDdvSGx2R0hlUXVS?=
 =?utf-8?B?VlFjYlpGTytVSi9LanZjd2tVazExWmRGUGVua081MWlDV1orQTlTSG5jZnl6?=
 =?utf-8?B?UUplNTJZb0VOTHlVTlV4N1NEUFNHMVpBQ0MwQ1dYTUpNdmRKMHRnKzZ4N3RO?=
 =?utf-8?B?T3YwalZxU1hvajRsMEp3OTVJTGxsRjNVN0xuR1VFZS9pditlQWJqSjU1WTNR?=
 =?utf-8?B?a0hIdFFJZFh5R1ZGOUpid0UxQ0dlVnREU0FDTkxlNm9yeE5NTDVhbVJTOUR0?=
 =?utf-8?B?ZGp4Y0haNElRVStWd0Z0Q1U3RmNrYW9UZU9DVEIxZG1SRTAyNkplbGJkMk1G?=
 =?utf-8?Q?/eCcmQ1mnTSTEGN7n/C3AWTrHb/wY3Z5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXVGSktELzhiTkVidEFQa2dXTlJ6UWdZYmxHVDdDenJhYmxwWE5JTzU3ejBn?=
 =?utf-8?B?djgrT0dSMldHbDlReTVQUkswcVVsUnl0aktLMFdtUDdNTmVUWVlUQ1FKQ1dl?=
 =?utf-8?B?UGpJd3RQUDhlSkEySGY3c0F6ZmVjRmwvL3J1RERQR0FsSkVXejRFWVVRdEpL?=
 =?utf-8?B?UTFCSG1ySktuNkwvOVFYZGY4WjkxZ3RoallwcVlTSTM2djc2UUx5UlBUdENv?=
 =?utf-8?B?dHFLSVBSZ3dKODR4SUhBNEtVZFR0K2doNjZKdmtLd3JOcXZqVEtHczdKZ081?=
 =?utf-8?B?QXZZWlRwNzUvRDRHcmVHUGlhN2NyUHBPRUxkUmVGY3ludU9UbkdlRzF0Z3I1?=
 =?utf-8?B?L2NzQ2o0T2lMaS9maGZ4VGlkNVRGT21yZk9tZVFLWjRKQThrYktpME9nLzlw?=
 =?utf-8?B?ZHBLVkl4ejNVb1J6WnpPSU5DM2NBTVphcWl2bUVkc0ZEWUlGNGlhWlJxV01K?=
 =?utf-8?B?RDdNWmZkb0I0cnV4ajcyM3J0ZE5hSjZHNnE5eGFjOWxZdlpnYkJuZHE5WC9i?=
 =?utf-8?B?OEVSQ3pJOThQV2tHc2xhWURkL1VCVW8wUTNjZmVCM0pRQ0JPUUxvL1pUS251?=
 =?utf-8?B?ZzB2MklPdWNlMlJHcHNrL2NGdjFucHlnOXAyUzBodi9vU2pIUFNrUnl0dVcr?=
 =?utf-8?B?SEtIL2gzMnAxTGQrMEJRalFMMFdqQlVFeThEL2FpZ3BTVXg2aDNYR0VLbC9J?=
 =?utf-8?B?NitaQm5XT1dKaVo5VUF2RlBpck9pcWJYanZra2RaNFYxNklEdlZXaUFxcGlZ?=
 =?utf-8?B?Yit4QWVjbDBtREdOVWJRM3k0dm9pOEdQZWNqVFdIUGltMEpCWDJNY0NmQlNy?=
 =?utf-8?B?N1FwRG4vUU50Y3pnaG1mRmNiMHp0bkxRM0NEUFJnaXh5L3VsYlMyV1dGRm92?=
 =?utf-8?B?VWFrYjJHTWc1OGpXVENxRnpTckJ2bFpqVDN3UmFab3V1VlNHTDFXa1NjQXBl?=
 =?utf-8?B?bXFrdjFlNTZPUVQwbVRVTnphRlVmdVMvZzZYRGpvRlo3KzNoMkpEdXR4SURZ?=
 =?utf-8?B?MDcwbEhQWVNiVUtrZ1E2Z1VXVlJ6Vm9jTEI2ak5URmQyS1lWZTY1QUtycVJW?=
 =?utf-8?B?OUpNa0JFRythMWJ0akJjT0oyNFRYZ1dKUzVSSy9FbUNQTHMzMytlN2M4QS9H?=
 =?utf-8?B?bEF6ejFjdk1VWWhwbDVkNzRYWXhmSlZWUGxhalEwaGswaGNOL3RUY0RnUnIv?=
 =?utf-8?B?RE1nam93QmxaVnZ4ZWQ5K3l6QjBBZVVDSTIxbVI0eWY2YWRHZ2wzTnMvSXhZ?=
 =?utf-8?B?YklBeHBPOW9SbDBXUEd1bDByVzU0RHQ2YTd6dHZCeVNHT0V0RE9CektyczVD?=
 =?utf-8?B?SkU0MTFNYjR6ZDNnaHhDekdSTkI3VFFrQTM3dGlFUUU0ODIwVWNDTVdOTDll?=
 =?utf-8?B?WEQ1OUxheHRIREljUW9RSXVGUVlqMTIrdU03dTRzb3g0T0hiT2c5TkVDTFlt?=
 =?utf-8?B?bStlUS9ocnQ3N3RyQmpGWHlzZXFYcWVUM1pTRXNFcnhhRVBwNmpDdXZvNWpO?=
 =?utf-8?B?Sk5PWjNsZ0dmUmplNWdtTG5lYTBsVlN0N0taM0tVWFJHaFBUV0hVbFBGT3Av?=
 =?utf-8?B?QWpUa2NuVVU3Ulhucms2NXhFYmNJNUlGTjc2T1lCTmJEdGZyVkNjZDhuc2U1?=
 =?utf-8?B?Mnh0Ylg2UE9ZQU40bmtvZVp2T3pIRjVFK0FUMGZ2cWZvbC90a29mWkJtbGc5?=
 =?utf-8?B?WDltZTRlTkcwanhMZk9Mc1ptMzg0RXBYUmhONEdQVlJ2NU5LeUJpQUNSV1N0?=
 =?utf-8?B?WCs4WjJYL1JLbEs2M0w5dSs1eGY0TkMySG01MkFmcGFmZ0VIbFM2YjN2MVBw?=
 =?utf-8?B?ejZDdjZ0dWdpSmE0OTFXVmc4ZUJzbndYMlRhcFFaSHI2aEh1dUNXNEFYVmtV?=
 =?utf-8?B?dXVSUDZ0Q2syUnVMdkMrcU04a014MC9SMy9pdE1aZjNYcDdwbGp3YXBJdXJt?=
 =?utf-8?B?V3hTazFSeXlrdnNyQnZDMzVWd1FvSVNaTVArRVlRMDB2NFRzRGt2cUlRUkJu?=
 =?utf-8?B?S1RjeGFjc3hDYnpzb0xXUDIxTFBHc2NrT0oveFNuSGVpNXBPQjUrenprQUtR?=
 =?utf-8?B?T001WHBNaFNLRkVockJrYUZ4L1RzYkx0TkJHSXZsblhmYmtsNHplenhQWmt0?=
 =?utf-8?B?U0J0bjIzM3BUSmtoeld3YWtHaUNhbUp5WUVyT1JqN1VTVEpIOURKVGk5R01u?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aefb01f8-9d1a-44bd-2205-08de156ba5a2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:15:21.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I4lnp9prdcBhRVOaznbbFiPWX5x2V2m2FXrsf2Adu+q83VWATGBU8gAIeakSUnrNsmaRRF44yoF3MYeIsFy41IwcV1410/TRk1A8b7fsVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8784
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----8CDD754BDD5298C925294F16E1217158"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay99-hz2.antispameurope.com with 4cwHBb1jYNz28mY8
X-cloud-security-connect: mail-northeuropeazon11021102.outbound.protection.outlook.com[52.101.65.102], TLS=1, IP=52.101.65.102
X-cloud-security-Digest:8354f790aa4adf57534627cd1e9dfc9b
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.670
DKIM-Signature: a=rsa-sha256;
 bh=Sma1VzBwGZ2GFd+oOU/Es2I/ZSgtxEVEKIrUJGHln4o=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761578145; v=1;
 b=LxLSBSdly5nkXW7OkvCZajnrioQkFULlrUtxcBUlS5URJgtFIiaDzjLbtweabHQIWTA0GSzS
 iODuvwLfbnokdijCC0tnGYzGpstY+++DKddj8wrGgTHqeXL6/bD+x+e3Qwh18HtBMWous866flm
 9wPH2MPtuThq7H4PT/NvYJILW5x7xjOXWAmsjy21TknxxhieVD6n2rfkPRivJChT8P3pKaDGFbO
 YvXzPcmsQ8RockgKRFQ/7NQEn3xwh8lStVezhtuGz/45oUVI6RRj4LjS9P9jOj/4lId0f5GSb8q
 WlXzeocb8uyMoz8rPqYej+ELu6n5PlILqv6iyOxcQK4+g==

This is an S/MIME signed message

------8CDD754BDD5298C925294F16E1217158
To: netdev@vger.kernel.org
Subject: [PATCH ethtool v4 1/2] sfpid: Fix JSON output of SFP diagnostics
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, Andrew Lunn <andrew@lunn.ch>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Mon, 27 Oct 2025 16:15:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Close and delete JSON object only after output of SFP diagnostics so
that it is also JSON formatted. If the JSON object is deleted too early,
some of the output will not be JSON formatted, resulting in mixed output
formats.

Fixes: 703bfee13649 (ethtool: Enable JSON output support for SFF8079 and SFF8472 modules)
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
 sfpid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index 62acb4f..9d09256 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -520,22 +520,23 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 	sff8079_show_all_common(buf);
-	close_json_object();
-	delete_json_obj();
 
 	/* Finish if A2h page is not present */
 	if (!(buf[92] & (1 << 6)))
-		goto out;
+		goto out_json;
 
 	/* Read A2h page */
 	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
 				      buf + ETH_MODULE_SFF_8079_LEN);
 	if (ret) {
 		fprintf(stderr, "Failed to read Page A2h.\n");
-		goto out;
+		goto out_json;
 	}
 
 	sff8472_show_all(buf);
+out_json:
+	close_json_object();
+	delete_json_obj();
 out:
 	free(buf);
 

-- 
2.43.0


------8CDD754BDD5298C925294F16E1217158
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjcxNTE1MzhaMC8GCSqG
SIb3DQEJBDEiBCCDbOoEjNm3IfYzLbRsb+juZxHkPkY+CkM8aplJ1Vc3UjB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgCuHTTf5jWK
hAHzSIH2HFkFol1a7lJx7Y/pMqsPFK5iZgGjo6qul114kI/KtWRu93iqv4wgxXRR
JBynDHRptDSg/nQcZfeLA6zBqKspmW6CqC5t/iXJ20e9wXg33KSsUxu/sIvQEgUB
xC1662685t34ELQ56HiAnGdF99p4f9QhxqtAlfxNBMlCl00yyJ8mxLbZWdBEXcDj
aaDW3OfHXgk1OzWZD/+gRReSgGIluaSi/tRTl1kZTlow7OMfY8Vgmu741dFv3FmR
gJw1+ioQyPYTfNfC1pJ2it5jlN8MnPKcQx+Y70OmEKRj5sJaMh/b6e61FSO463Sr
z+pi4yycIApA9a3HGjOgPlFkiYCYFyq26CgZSFcBufrGhP8jf+Udqrha1ioeB0hP
T6M0sUXKzSSgFRy7pxayfWMBUz/oQg9nA97NDG4a6fXnPb/gnLZbH9h0MUN2ONyy
zo/SK7G7fWHRhl9FcbkTunszaDkks9X6QNUyNtPtMtCeTHvspZ6MsbBgtiuANSaS
niShoo177LQk3kd7ENDHFya8mU82ErPnTtNEVUAlfpoZW1T7JrCSjph5VPb8C/QF
Lr3YM66Rd0/L95qFyDBAxrsgoO6r096paFtnfwNpiR1VbLq5aFApj2tZp8WgRXNj
+yFxoLaL3BG3Cr9Nx8uAqX/PpDpD4T87Fw==

------8CDD754BDD5298C925294F16E1217158--


