Return-Path: <netdev+bounces-129932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A994987170
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991941F2727A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B01AD3E2;
	Thu, 26 Sep 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fm+wH5Cq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876681ACE00;
	Thu, 26 Sep 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346245; cv=fail; b=UAQQ1oH6Cd0T8iAT6I9G6Xhj1BNry2PzC1ILrDeDhcS6UCEusnT4die715yuZWLIG1/LrICrNKlJnBLxae8UOn+4VGWlF6jd3RDns/GNfmqPIcAw5Tyo4/hZGHLRYcGOOoU+jU/aEthlLkL2WB+lGv1ePBEfdrusnRX4kzDbpvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346245; c=relaxed/simple;
	bh=Z2sL7C924cvBOwN1Ue7PAn2OLZq9ahajNrN9SSAPxG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tB/j28DPfpluj8qxPZdzF7BB1UwpOnmFHmMXlGJimsOq2FsE1YiysJQgkjLvI/Zkq/FGVhXuth3XiTTIuGm5Kk/S+08LgZg7FpQQLvtxPphMsDHhedYgVccbq18lGCNTFPoT24BvBtR4m4UjxpxpjldVjFX1wMbb5Mi+hbHaiFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fm+wH5Cq; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqJbUb2eyzYamx2G5f1BirjsQKCRnrG77bmuOwXNNLPzypK/Upk0Aytmm1ui5RY36SNQJSJNWfa+cexydd2H9P+9XDM6AMt0C1+pfJ5XmoIzse7LF2sRzu2dla3qFcDjJMIWyFfiabEbKfwPIkHHboVuwoQybggXPEGxyJnnrTjgawfnxkTeAEoqhX+dNKELpuVIECc+5RTy0kWW/k1QQCcXsI4Y8AM1u/DoVIsuglKUVJq1dovwgV2CrmW50H7oADGqSKqQIxV25I17AenZG/9CdA6ame0wjszcTjUJf4uZqoPYh071E6X5HhrRs6iaeAcawCI8ynFEVNJnnpMDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2sL7C924cvBOwN1Ue7PAn2OLZq9ahajNrN9SSAPxG4=;
 b=oxDoeAoGefWfwGUe9SWBVJwsFDRl8H5ZTvaHghFvuvA2zzD/Ekn6S/wCDNU2ioyxU2dU5vgmkmnTDeajauSYx6PWbGV2TJEupjUfIphvPgBFCCW882jKzbxB4Em5bD43UPMvB/gXbX0dDOPC7coxqVexsornMJhnqmTDAnzCxQZR0B0AmzNSELglfLoGmEJkAnasPuo8oSkfgr9zHksTTxD8okXX4eRGsZ6Cge8ic8iZlkZWlvghAEKbybOsaQv3qAO6H5cuFCSGBABs/4y8y67kV3rojwPAyuZ7dMiPLo6p872YHhApTl8QsDDtBPC8OaX2GVpjwQDHosLvzqrl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2sL7C924cvBOwN1Ue7PAn2OLZq9ahajNrN9SSAPxG4=;
 b=Fm+wH5Cqb39e+gnXmXyCzrWA2QusncGEWfQIOy147JjD22VSDpiX9zF2jGkz0wALMK1uy4h1NyPXBU+AaIYNufbUhbpCmkKqJKV1Ms6j5k/Q2wz1952y/9kUaBUbLchqnb8IPrplCmjrlszgzbdWxLprV6KoGwKWbybzR2DXY1xFMKaxrosEl1JvHTu29eweYm+Z0Xaj3JyC7tzE/jn9A6fdsDGd6u7wuKyQuJjO+cVQgtT2Nl5Rkxy7pNb8t56YfZ/aWcjFnW6II7GVwUDZDpo+lmzMNv74e59/YrdztYMtUPvgw2wnVx/rZk+6tz5jm8mDiJLwGEVgV+9f3cQvUg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB7510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 10:23:55 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:23:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
CC: "c-vankar@ti.com" <c-vankar@ti.com>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "jpanis@baylibre.com" <jpanis@baylibre.com>,
	"grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
Thread-Topic: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
Thread-Index: AQHbD/mT3IrJL2vGb0qy0l+Vcqok17Jp3GuA
Date: Thu, 26 Sep 2024 10:23:54 +0000
Message-ID: <99cb11c8d4cb2f9c64aabc400c1e2c39d9b1e004.camel@siemens.com>
References: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
In-Reply-To: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB7510:EE_
x-ms-office365-filtering-correlation-id: 780b7164-845c-4e9c-59d5-08dcde155317
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2FTY0lSMTBzSXVuSUh3OG92eWRieVdmM1IvRWR0Ymx2SjBJZXB0RXFxUnY4?=
 =?utf-8?B?NWtZY2diMUhBcVgzR2lDMHB4aTBRVDJZR3FReTY5aE4xSC9WejBVcVZTSzhJ?=
 =?utf-8?B?Tzh2R3VXc2VQSVJZR0tEQmRpbWdRdnR3QTYxNEt0NE1EYnlVZzFtN3BtYXN4?=
 =?utf-8?B?VnVhN2hNejVyVnRzSFViYVU4ZXBXM3NkRTdWdkxNRkkxeTdTTlF4alN6NTBt?=
 =?utf-8?B?WVFiS3hTZUpDdE9WbnJjZ2V3MHAvOXVWcGNoV3BRWXdiNVcwUWozeVhBQjF3?=
 =?utf-8?B?QVU3bkZUbjVQcC9hdVR0eXFoRjh5VjJCSHplaUk4cFJxSExGcG84WFBMWTB3?=
 =?utf-8?B?RUtVZDY1UjR5eVRHTVV4Z2dPeDR3UkRaeXJFT1VBOWk3b0xudzVlT1Y3Nm9w?=
 =?utf-8?B?M3hMQnpLaHJnZmdoYXgvZllmOE9HWitMLzEwWXhtalF6bE1aeGJ5akV1ZjBa?=
 =?utf-8?B?cUZGNTlCV0NQUlV4M21FaDE2bi9ta0N3bXRGemFSYStOeld1UXdaOFhidjdE?=
 =?utf-8?B?S3NvOVgzdnhxOTBVajJDNGx6TnozNTdNSmtkeUJrK2Z4aU5GajFiZ3VpUlYv?=
 =?utf-8?B?dmljWlBGdW9rcUFWWjI5UkFuNk13Nk9BOXp5R05YM09udUw3U25wZWY2MC9v?=
 =?utf-8?B?dlZ5TE1RcjVFUWxEZVhhQ21PTllyUWVVT0plN1IzY21YTzNibHdTS3BoRW9H?=
 =?utf-8?B?dTRrbktyR3pqR0pFRWtlRFdWVGszSlZ1SnZNTFFXS21tdzlCUExOdXozK2No?=
 =?utf-8?B?Ky9Nc2JJZSsvbmp2WlhEaFo5RW1CaDhDNWlzUXA5amgvbXRQV05uVEtycmwy?=
 =?utf-8?B?ejdhMHZES3BjTnRtbC96TGdUejRSdC9pZGE5MlVhQmxaNzJIQVFpdEtjbHRC?=
 =?utf-8?B?dGxCekVYU05reFQ0MGcyOEo1QkZ5ZG9RV0RZc2Q4RUhUcS9TaVRSWGZCZzls?=
 =?utf-8?B?QjEzTzd0a0M3ZWY1Ryt4bFJCa255S0JocnpGaXlRVzFRNEZzZzArdXVrWEQv?=
 =?utf-8?B?ZGQ4aFFia1UrRjJHbGU0YXJreUNUbWFOUGVjRUZwNWZlMG5yTUdadmloeFpR?=
 =?utf-8?B?TE43MWVTL3BidFM3aFMzMDMwRDdCdTZEdkh1Q3RuQmRhTzZ0TnVnbDB3ZTlP?=
 =?utf-8?B?ay82SEEzYWl4S0NJSnFnb041UVN4N0lGK1c0VnU3Q09ZWkllbWxDR3VsampP?=
 =?utf-8?B?NlUxVHdNYUl4dWZMK3lQaVpCMWJDZFhvK2h2NE5qZSttNG1WRDRwL2lpZVhi?=
 =?utf-8?B?aWlhT3NoN0JaODAxWkxGOVRjYTBSNm5kcHIyeEhudkZ5YVREZEpMQ3JCUlJR?=
 =?utf-8?B?WnpBVWwvUGZZa1R6MTlCZ1pwbmVvOE8xNjFlUTVOeDlHT0pzcUhrNTg3Slpr?=
 =?utf-8?B?S3BOOHN1RU5UV3J6Zit4cUVIR0ZXUHBIMlAzTnRZc0pLMjRneWNOZmtCQkNS?=
 =?utf-8?B?M0xQellkV2RuVHJIdEhiWDdROFQzdFNPNHh3NEpqY2hWTUdTUlBFNUpZTXBH?=
 =?utf-8?B?TEd3VEVJMTZxVXF4c2pzNFVYNGNnbGFIc0pINDgxVWtkekc1T01NSHRNOFpZ?=
 =?utf-8?B?b1Q4RTRrY292MmozQzFGZ1E0ZDR6WVpBeWVlVGppYWdiU3J2NXhTRHJUSUpL?=
 =?utf-8?B?ZURSMGtaWlpLVXBWVW5TVzVoMzRSSkJTZC9qME9yUE8xWXZCZ3ZUbTRTelZt?=
 =?utf-8?B?cVBOVUkrSjA4WFBUTURwa1pWb2N6eURaWkk2ZDUzRCtLeGlpNlJ3RkhpL1Js?=
 =?utf-8?B?KzNUcno4ak9ib1FJdVYxd3JiTW5VNEl2R0t0UkpEM3FzbHZjSWJOUE5kMFpT?=
 =?utf-8?Q?kEm22p5Feb2lHbSKwZgaAsfYgnFHCsXsEeKcQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU5EZDdzbFZrbEs3TUZLRWpTRUIxUUh2Z09XZFoxU3k1TXhidklnNFpBUTJr?=
 =?utf-8?B?bXNGenNvR0tKNFlRR2QwZXo0UVlRSzJjMlRxckZkVmd5cDVSTVA5MFN2OHpJ?=
 =?utf-8?B?ZVNqN1hCaSsvMmRNbFJwQk1aNTRzaE8zaERyc0YxVGFQZFozOFV3am0zWHpB?=
 =?utf-8?B?aVpQUGdtV3RPWWsxbmxTckh4enFMaDd2MWlGb2Vld05QVllvQ2hHUzQvdFln?=
 =?utf-8?B?YytVNTlRNzhwclpIU2RESDRpUjJ6cDFRdGJ4cXdZS2dkbndWQTY3bjBLc1Nr?=
 =?utf-8?B?WS9FNC9zaG9TZ3pFMVlIK2JjOHZJUTl4VThkVTRYdXZ5WmVDZ0I2bWl0YkVH?=
 =?utf-8?B?czBSZ1hKelUxYXFDZjlYeHNpSm5SV3UxcWtCZVJaTnZMRHprNkY5ZFhPdDdI?=
 =?utf-8?B?bkd3NlNSOGNXM2pXZTUyRVhHemttWGdVaktEZG42cWFCUEVrenh0aW9TWnRP?=
 =?utf-8?B?bjZqUk9PZEU1YTR0bFF0dTk2QWVuaDI3V3c4K1liTWp0VEllRmE1N1hwUGR1?=
 =?utf-8?B?ME9xZFFmT24zMWloSEk2MVA2Um5vM0pKczh1Qzk0STJOQ2tlMmlYNm5URk8v?=
 =?utf-8?B?QjUwdi9mb1RJcjFtVVh3M3NJOHFueEo5STRpTUpXZFlsRWwxVjIrajI3UTVy?=
 =?utf-8?B?ZTE3RHNPL1VvZ1UvelFqMTJTY2JOMm84MVVCZmxOWkoxT3pzYUxjQ0RYVjc1?=
 =?utf-8?B?aFlpaU1ZSk10a2dWZDk0eHE2dWJTb3Z4UDlESGVVeGl6cmR1dnhQY1hrcEtF?=
 =?utf-8?B?RlBuTXJJT29oemNDL3BQRjI2eUQrT05UamJ0TmthbVhoOFlueXUzS3JZTzk0?=
 =?utf-8?B?RE9uMlpnT3JlblZ6Y25BNHl6WnlySzF2Uk1IM05MWDIvSnZDWlRERHdFUGdF?=
 =?utf-8?B?R1F6TzR5VzEyaXVjUjJaVHhlVjJOeURzRWhXRXN3Q1ZwazJON3Jld0RGTzky?=
 =?utf-8?B?cXFRUDlFZ3A4NUlOVmZkaDRyV2Vnc015VWRvMUYrZkxNeXdzN1pLYmRDbUtZ?=
 =?utf-8?B?TGR5UzRxTGs4UzdHd1FFTUt1WEVaUGk2VWZjUVVrWFFmSG90SzRVTklISWVN?=
 =?utf-8?B?M2xtaTluck5SdXM3WGFoQ2w2dUZRSjRkUEhRY1JGWHpsWDhnUFZkWUxLVjRh?=
 =?utf-8?B?Yll2NlZ6blZBb3pTNG9QQ2RZZkUrdmowUnhqeUhyRjhENXk0Si9NUXlUUHhP?=
 =?utf-8?B?MmlBZ3g0dyswMjEwWVVsOWJSMlNaWDJ2N3NDbUhPcThuZmQ2THJLNitlTTIw?=
 =?utf-8?B?OUtjU3Rvd09oV0dNdFhwR1ZNTGVKd0MvcUNxRjRnZmRKaEpoR1RsaGJXUm9j?=
 =?utf-8?B?ZHhEcjNvZzIxbDhDTTdiU0RUczBnSXVKcXRDcitHSWRYdGMzdU9sZEI2MHJO?=
 =?utf-8?B?OVJadmxTTXhOdWhoREh6Um1DaDJUMnphZmJkbXo5cTFuNGxINlI1bFZ3cjlp?=
 =?utf-8?B?ZWFjZ0NvTlg1YjVhREZtWlZYOE5zRE56Z2g1NXplY0Q1ZUZMUlM4UkovQnlZ?=
 =?utf-8?B?SWhrQ0xUOXpBZ2hIRHdvU0NrZWxJOHRuZlVXbU5QZGh0K3loVkZSSWcwVE9K?=
 =?utf-8?B?a0k1R0c1YzlWRno1djRvci9jQjhxWXhUbWxWUXdBU3hETTFjWnlpWThXU2pl?=
 =?utf-8?B?M3J3YkY4WGRTVzVBOVpYY3EwN2J4ZjZpN0xaTDNxSW56R0tTR0kzVHN1TXlM?=
 =?utf-8?B?TTFlcHI4QjlOcERzVU9yWDFDNDlkN0NwanJVMGwzK2w2K0o4b0hnd0JpYUdq?=
 =?utf-8?B?dENQLzNnbWpzOXcyQ1VXamNJVThaSGZmeXVkY052dmNlOVFVK0M3WWhNQWpK?=
 =?utf-8?B?WS90UzZQZXczR2t5SEJwbW1VT29URnQza1hSd0h1aWx2SFFGeElWRzVoaDNH?=
 =?utf-8?B?WDlJUks1amYwOFpqM2QyY1B6UW52Njl6UkJ3WDNwM1FHSkNNeFRPS3hZeWhR?=
 =?utf-8?B?dFZqeCtBUkxXWno0YlpIaEk1UFBlRStVN3JpaHh0UmlKWk9WaFZ6aEtKYnNY?=
 =?utf-8?B?Y1Q2U3lOUTIwMUhEdWdEdVErV2M4YXBkT0ZtdEY4N0ZaOUJLUTRsMFVCc1Jr?=
 =?utf-8?B?TlVtL0ZHZFBRS3FDZGVFcVBMbTZzaDZYTU1MRERSdmdDdzhQSlFwNHR0TS9h?=
 =?utf-8?B?NUxEYXA1SjgwbzVLQUY5NG9DanU0YS8wbG1tU1NVWGhmc0JvaVZIeURvdWFv?=
 =?utf-8?Q?gcLpo6KbDAPZsk9+wN4F+cU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C4A50FFD834D945A4902448AAB25252@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 780b7164-845c-4e9c-59d5-08dcde155317
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 10:23:54.8904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3rAKFDGc3X4dN1F8F57PyFksJfFvyxcKKVbutNch/JXnwxwvUUieHVPQu5dSzRY84dpad0EQHh/1UaqWYuSyQ+5dNnNMTcY4+3cm6kzrb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7510

SGkgRGFuIQ0KDQpPbiBUaHUsIDIwMjQtMDktMjYgYXQgMTI6NTAgKzAzMDAsIERhbiBDYXJwZW50
ZXIgd3JvdGU6DQo+IFRoaXMgZXJyb3IgaGFuZGxpbmcgaGFzIGEgdHlwby7CoCBJdCBzaG91bGQg
aSsrIGluc3RlYWQgb2YgaS0tLsKgIEluIHRoZQ0KPiBvcmlnaW5hbCBjb2RlIHRoZSBlcnJvciBo
YW5kbGluZyB3aWxsIGxvb3AgdW50aWwgaXQgY3Jhc2hlcy4NCj4gDQo+IEZpeGVzOiBkYTcwZDE4
NGE4YzMgKCJuZXQ6IGV0aGVybmV0OiB0aTogYW02NS1jcHN3OiBJbnRyb2R1Y2UgbXVsdGkgcXVl
dWUgUngiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxp
bmFyby5vcmc+DQoNClRoYW5rcyBmb3IgZml4aW5nIHRoaXMhDQpSZXZpZXdlZC1ieTogQWxleGFu
ZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+
IMKgZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYyB8IDIgKy0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiBpbmRleCBjYmU5OTAxN2NiZmEu
LmQyNTM3MjdiMTYwZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02
NS1jcHN3LW51c3MuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ct
bnVzcy5jDQo+IEBAIC03NjMsNyArNzYzLDcgQEAgc3RhdGljIGludCBhbTY1X2Nwc3dfbnVzc19j
b21tb25fb3BlbihzdHJ1Y3QgYW02NV9jcHN3X2NvbW1vbiAqY29tbW9uKQ0KPiAJazNfdWRtYV9n
bHVlX2Rpc2FibGVfcnhfY2huKHJ4X2Nobi0+cnhfY2huKTsNCj4gwqANCj4gwqBmYWlsX3J4Og0K
PiAtCWZvciAoaSA9IDA7IGkgPCBjb21tb24tPnJ4X2NoX251bV9mbG93czsgaS0tKQ0KPiArCWZv
ciAoaSA9IDA7IGkgPCBjb21tb24tPnJ4X2NoX251bV9mbG93czsgaSsrKQ0KPiDCoAkJazNfdWRt
YV9nbHVlX3Jlc2V0X3J4X2NobihyeF9jaG4tPnJ4X2NobiwgaSwgJnJ4X2Nobi0+Zmxvd3NbaV0s
DQo+IMKgCQkJCQnCoCBhbTY1X2Nwc3dfbnVzc19yeF9jbGVhbnVwLCAwKTsNCj4gwqANCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

