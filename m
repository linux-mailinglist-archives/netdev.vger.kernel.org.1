Return-Path: <netdev+bounces-124014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B674D9675DC
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416521F21B53
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA6142E76;
	Sun,  1 Sep 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eKf4pT+h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155441F959;
	Sun,  1 Sep 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184890; cv=fail; b=c/M5DIQmz6LN7WHALH4F+EF2Y+CQr01BEIhtQHQBsQqcVOmf75EvKlpNal6ilU1WoXI/07nk6l4b4sasV7QUg5uqm8NovbbMZO5uLKXOXlCr9RPAOJj5RVwB59qTmGWMc0sxfDZGxVaCEDustuTeTTM0glcLcQtE5ARXAoF28zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184890; c=relaxed/simple;
	bh=TM7Gh8sjEvF6Xc1OlpnyzW58JZqWJDfd8UCeiM35iIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=px+hPab86v6G8CghppsQn9TbpcujrLoA0zm+j3mZSVAwOjfPvqp6LTneDHq6kX5dTLJ4bc9TD+wSBPOIY4KPhDmDhg14JcQKc/JMEGk1URTgPg3vPN/S4kefi9Bu7cAzxRVfQS5XcBdcZoQgHQGHSoOQuRBZdtyRDBTWPLswap4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eKf4pT+h; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4818ACu6010112;
	Sun, 1 Sep 2024 03:01:05 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41ch47rjaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 03:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/8uFa+qPjKgyZ5MdMmCz/FYy52CDv5/ZsJxkQggakHfXlAVX/4RF8TfT3011R/YmboMRnxEHE8R2RpG0GI9tLmazfpNAp7GgJ9e4/lopOtiONIp/pIRhQc5YAbYmG/G/fFtWpDU+0V5V+iJmRH8d0rfKf4Jb/nZvsqrHsODI1rxjtxQZvfOGZ+zpVKYn+x2P1U8Sz7TmhoiyMTmhy/ILMqgBZAOAxmK3EvoHMRKRKIdXKDHyhp37KEkdzO/Q9oBhcvahw1nTGVoJm7e43byEKrcx/fnEU2cYtlUR4xCFMwZo7/nDCv+q7q2WSi9ttIMKb6OYGGN+C1TbcBHGVVy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM7Gh8sjEvF6Xc1OlpnyzW58JZqWJDfd8UCeiM35iIU=;
 b=dulgFQrmWEA28CqFUpG33GcePUiW7k/T4iZd9rBNb+dm8bLIJIcZTLHdNlSDoukESyR8YPDwngXDpCHW6PDqDyKMMKN26f32xV7bUZtt+7ZwCQpcIP54TxHvRyLJeGTlRraGmIFDZbNk5vJgb+ON5jWf84HCI0QH0L3AqvbJzpWNtfKM0wvYEcQoC+f+f/TISFF4A5441BnWKLCObHTCYQlAGaH5qdQ7OA2P7YGSuoQN1rGuY9xMNrt+Fa8tKrWWDXiHoxMPGZ+o645tODVrNCfDqDtPReP2Y6TPw1ODSWc9cmJPej/K465sFnao9i1P1y3Q163lOIFy1ob2sO5Gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM7Gh8sjEvF6Xc1OlpnyzW58JZqWJDfd8UCeiM35iIU=;
 b=eKf4pT+hAB6ScEaVSUMMA1I+Gae4b2DzE4FKkylXHSTp68whIHCGroFW4VOt1SGBIGzbE7JTlvMiI2u6g/5nIbB5AcRMHId2YiH7KZMo+gyDLqmkwy+7N30nLJ5ep2Bc2uB6/UMCUHrKQDN8CTcuoDFmPMltAaTTGYynd7Y2/Ic=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ2PR18MB5561.namprd18.prod.outlook.com (2603:10b6:a03:560::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 10:01:02 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 10:01:02 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Thread-Index: AQHa9JYYC2Ol1Al2pkyFXUK9ORGsiLIzWbAAgA9m3uA=
Date: Sun, 1 Sep 2024 10:01:02 +0000
Message-ID:
 <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240822132031.29494-1-gakula@marvell.com>
 <ZsdOMryDpkGLnjuh@nanopsycho.orion>
In-Reply-To: <ZsdOMryDpkGLnjuh@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ2PR18MB5561:EE_
x-ms-office365-filtering-correlation-id: 6e85a77b-9fbc-4620-de53-08dcca6cfcb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHVMK055M3lnOXBuZlpxZnMwZTFqcHF0SkdQREc1OUhyUHpwRnBkVWswSVVP?=
 =?utf-8?B?azFUNHNtMWdyV01pcFJQejZXc05nazVrSVBtTkR5bG1IdlNQMHhJZDlTRFVQ?=
 =?utf-8?B?QUpTVm5rQ0NQeW1HVEI1Y3ZyS09OZmtPWVQvZzYvS3h2dlR6R2pRMTBKbFZU?=
 =?utf-8?B?elhkUEhkem5rYzdOaXE3aWY1OFBJdi8zNHBaM3RUMVlNUUpkMkROSWtVcjNs?=
 =?utf-8?B?Z3BDNVAwY0d3aHQzakhndkJ1K3NuNExENTVMTUVraFJFMlpQaTNzazlXd3ZD?=
 =?utf-8?B?azFadWFuT2dkQzZHVmt6ZzlaZnpxSGZUWWR4cEhWYm8ybjVkS0ZwSGZCMFRD?=
 =?utf-8?B?RnE0YVZXQkdNRWVoTjRDNC8rWTlLMDNEZnkvSXhQYStuNkU1SHcva1lwWVN4?=
 =?utf-8?B?VVNOa0psQVdtZXAxOG4xbms5TW9qQUR3NVJ0UEVGYzVyV1FrMkdlWEFLREQ4?=
 =?utf-8?B?TFgvZkVnZ2JHbEZCdlZFbnplUmRiUmxLWUN0SVRlYXBzZTQ1ZCtwaWNBYWJk?=
 =?utf-8?B?Rzd0ZVJOYmpxY250NHNTZzJnRWR6d1c3WHhvUnFCa3FpZEVNNVhrc3J6RUVG?=
 =?utf-8?B?QkJrYnFPbHhSaFNTb043ZlZxR05JclBKK3lkUFZyeEtGbExxamNPbG44ZlFp?=
 =?utf-8?B?NmlqR2tEYklXZ3Q5cW84dW5CZitZUkQ3WHIvQmhnNHVZY3Ava0JSWVlsZ01T?=
 =?utf-8?B?OVZnVmV6eFdncjhXcTBQcGh5Q0krRTBHaTJYbzFxL1ArUTFhWHFqK2YvWXVI?=
 =?utf-8?B?U01ZMmlpUUhDQXZwbEFmYkVZQjdjVTduR2tneVZCYmUzVVY4dXM2QTZqLzFV?=
 =?utf-8?B?Tlg1ZDd5eU50MXJFOEVGbjE0ckt0S2ZneHd6RnBoclpGUUpvZllmTWpsaldW?=
 =?utf-8?B?bjR2WkRSamNGWER6bzFGK3JFcXBpVmZWWDRGUDhqQWJqWWVucEpvS0dJSzdS?=
 =?utf-8?B?TXl3QUV5SEFFY1BDSGEzWEVpN3o0aHZrRFIxOVVZTlBGU3pVeFdFZnFUb3Az?=
 =?utf-8?B?cnBIK3NPOWFSLzh4ck1hK3ZueXJmYnIwV2RSbTB5YWhZb1NGNDR4WHVUUjJX?=
 =?utf-8?B?dkNvQ2FjTlVWZGRCT3dGZEdpVEFPNUxXcDNNVEc3Y0c5THAwaHUxeHladGpn?=
 =?utf-8?B?S3JsMkcyTWFKZUR4YkZoWGwxeWZaVjRLemZKRXU2ZlMxTHJBR1VMcWZKNDJE?=
 =?utf-8?B?V2FXY0g5WFdxcmZJbWJVdEM2dnFLQXVlV1p1S1RpUXpBb1d5VnpMRlZLMERy?=
 =?utf-8?B?bEFDU1AyU0Y5TFJIa040T2pORTlrem1wbnJsUm15RkduVzkrbGpHMXRjMW9M?=
 =?utf-8?B?Tk9tTllYSzk4YnczUFlCT0lodWJJZEhmVEt3bGJFaTd5SUtyMUY0YW5RUGIz?=
 =?utf-8?B?bGRXa0lSdmE5MG8zTmNvekJtZ1N0WWpHbWlOSjk5RzArQ28zdzY4R0UxdHpN?=
 =?utf-8?B?d0VsSlpZd2N5YUUzcmFZQkEycGlqVlJnc2RIa2tid2VWL0Q5Z1loZGFmQTNP?=
 =?utf-8?B?Y0FxdzJsTzFKVHdUY053L3FXYUFlTlp3ejhSL0RNNjNCYXBrY2JSQ0R1MHpo?=
 =?utf-8?B?NUQ4a0lRcVFsM2NvRU5EMkltbGx2VkNvYzFkdnVCOFFjNGFSaW5MM2dxSUFi?=
 =?utf-8?B?UlpDbGhvZ2hCNEEvZU9BdFFmcEFwVkpKUHl6Ulp4NUpYaFppRHZQOCs4cEpG?=
 =?utf-8?B?UG9zRFBYbk5BY1BQZFBSVGdCTW1VSVdnKzFpemFHMVc5WkplUUxLR2wxcDNt?=
 =?utf-8?B?Q3VocHhBTVJPWjVxcnVmSHVYQVZlUXRYb21JMTdYR3JOR3cydlhsd1EzSmdz?=
 =?utf-8?B?UkZKcXZWdllnZElTczdVdjZNRjI1eVAwY0lZaVRLQXZ1VnMvZEt5L0RYeDNp?=
 =?utf-8?B?NWJaWHRlalI0WW1VVC9yRFYzVGlIRmdyazlibkhHZFFUTUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3dlU0tNb0NWZzZsdUhZSzYrWWFTSU9wVGlzdjFpd0NMb0pYTmc0dzdJZkx2?=
 =?utf-8?B?ZDhDSzZ6NHBqVm1hcEFUcDVzZzlGS2VsQnovdGd2U28vZVlrb3o1T2gzc0NW?=
 =?utf-8?B?cVY1eHF6Z1RhUjk0QXNSWU05RS96eEVOWnQxTFhLdDhGUmcyaUJTSjBlUVZB?=
 =?utf-8?B?VlNuK3dEMmkzMkJVR0FtN3QrSDl1NEV2aHFaNEZHMlpGWWdCS1EzK2pCRDBB?=
 =?utf-8?B?dnBKa0pqd25MWVdrT24xTVdrS2NGM3FhRXJkeE1TZXpnSmtZVHZna1lWZ1lP?=
 =?utf-8?B?UEIrNkZCTVUxTTRTRy9GQWZPNEVvZUhzcmZTZEo5NzN3cWZCS3FHd09jc00w?=
 =?utf-8?B?OXpuOGkya1hPZW1MTFJhWjRRWUpGVlJETU1xNnZ0ZFpMUVF2YzJML3grZTFn?=
 =?utf-8?B?Q3R3YlZOdzM5YWc2YkZkWXFIOGtqZCs4WXhjdVR0SS85WHdhNXFHcWQ3VTRP?=
 =?utf-8?B?b2pxbm1pcFBNbldvaHZicXBPS0tiandReG43MTRZdmNVVVIvZjMvRkJYa3h4?=
 =?utf-8?B?Mk5qeG9ZUVFqZU5oL1owNmdQa3VXalg4VTVFaUhHelVNWEFTZWZzM0JFeXMz?=
 =?utf-8?B?KzFsNmdnbHJJVkRXQzh6aDRHdkE5aEtyR0JuK3FOSjV3bHVQcWg3RXl6SHhP?=
 =?utf-8?B?NzNaazZpbGpGRHBVTWRYa0ZxZERLYjdwUmx4Z1BkbHRnd1JtamlUMUlqK2tq?=
 =?utf-8?B?Rm8yVXVFTk9SWEdkK1BBMVVHTlduM3JadHdqYlI0Q0wwL3A5a2Vya1VsaHY4?=
 =?utf-8?B?MWNzVVdSSlFBejZHUFd1U1NGZVZsU25RMDZhN3MyaHJpNC8xMmhiYThQYmRp?=
 =?utf-8?B?OW9XaUE2bUc1TTJkN3RUTVBOUmEzZFpFd09TVVBRaXR1Ym9rZnQxQ0R0TGF4?=
 =?utf-8?B?R2VFd3dDZFMyUlQ0L1hVa0NkOFgyT2NjMjI2NmpuUlJoVElPRjBEa1YzSUlG?=
 =?utf-8?B?cGxaNlRVTSt5OVQ0Z09DaW1OT2psc2Z0S3c0Q2t0eFM5eThaR1dxWVVVMXhE?=
 =?utf-8?B?UHYwcWZwSjh3cGx0YThBMFJ5MU5qOW9iM01YT01mVjBzemFaV3QzbC95SkFE?=
 =?utf-8?B?bnhtSzFveXhsNzZ3VVZFVEEwYjZ2eDJ2cmdTMml5TFBsOXZXdHprcGVDTWZ2?=
 =?utf-8?B?eDNBZEhrd1MzMkxWb2R6NDljVG40MC92QnZuTFlOSUJmS0FXQ2RIK3hrQ0Jq?=
 =?utf-8?B?MW4xcDhvWkJGQ3J5R0hwaEhraktSMXpOVDR3VWozMld0Sk13RlFlYWp2UFZt?=
 =?utf-8?B?ZXUwU0R0cUJVdjhzbVZLaEtvZ0RHamtNcUVIdUxMWUFRUVMydEtPUXZXQUlL?=
 =?utf-8?B?Tytoc2R0c2tieXRtU1RnckRCQ0RlSGNoTlV5MXBGWEx4cXY0eFpNT2pwK1ow?=
 =?utf-8?B?Ymd5Rnc1THJYcGpBekp0aGllWGVKOTZQV3pwdHVYNWcwS0dqR1hyNHdkSHlq?=
 =?utf-8?B?RGhtV1IrNUZiUGlSckJrOHBPem5QVkZhUWQ0VEd6SzN2RmgwVWJTcGEwdUpa?=
 =?utf-8?B?bXlEMHQ0QnBrbFR2eEl4aGs1b0FiTjBVbmJSb2k5N3QrQUVsZ3A5STNrMWRB?=
 =?utf-8?B?TzNCNDYxM2h4S0lXd1NxOGhIS3VlbHc0OWhYelRwdnR5dTdNbHJESkI3NFZw?=
 =?utf-8?B?aWVGb2QyTXhrNWVNckU4U2xERS9kRkw4L1RITkFhVEU5YlY3bmN0b0ZKWnhB?=
 =?utf-8?B?TDZGaUNlTzUreVdjYkk5aCtqc2Rxdjl2dFUwT1BuWWgzUC90aTBhOUd0aGFw?=
 =?utf-8?B?VWIvZlZtNkNUZ3crbm1WVWFhSWRzMm9xNnVjcFBIbzFXamxLaVNRTVBzTk4x?=
 =?utf-8?B?UTNmTVUrYkdCU0FpMjJ4R0tXaHBkZnJxV09qcHdzZE91Z2pFVjlFYjhBc09H?=
 =?utf-8?B?ODFUa24rb2FiK3A2ZmNlWUFjZ0liNDhHY2tNV0JhMHc3YmZTWGJoV1ZZRWNu?=
 =?utf-8?B?T1dKK2NyMHVidVJVMUJXRFNyczFHRGdpYkRUbTN6ekFQZVh2MlNwdVJzY2ZM?=
 =?utf-8?B?U09iRlA1S0dGelVNeUVtTEVrN1RXK01pK2ZTajZFaGhSRWhWdTExdlhXSHNI?=
 =?utf-8?B?RzlDYlVMbms4SlptU0xydlBudG1QMkI1VmVuM0dxTFhIR21NWEw0ZjZBa21I?=
 =?utf-8?Q?1OK4MW+tOqT0sigG/mVygfY37?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85a77b-9fbc-4620-de53-08dcca6cfcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2024 10:01:02.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDgZlLSnQGZ/7tvX5qNaNfB7P6D0wO3eTQRyoU0WS2ZWSXiPDlC4CSd1/nQrG4x3elQlCRCLyDZgowquLKyELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5561
X-Proofpoint-GUID: rRf2PK2uEFs19RUPnic53KwxNSCPQp2d
X-Proofpoint-ORIG-GUID: rRf2PK2uEFs19RUPnic53KwxNSCPQp2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_04,2024-08-30_01,2024-05-17_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppcmkgUGlya28gPGppcmlA
cmVzbnVsbGkudXM+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA4OjEyIFBNDQo+
VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGt1YmFAa2Vy
bmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgU3VuaWwNCj5Lb3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwu
Y29tPjsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+PHNiaGF0dGFAbWFydmVsbC5jb20+OyBI
YXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo+U3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW25ldC1uZXh0IFBBVENIIHYxMSAwMC8xMV0gSW50cm9kdWNlIFJWVQ0KPnJlcHJlc2Vu
dG9ycw0KPg0KPlRodSwgQXVnIDIyLCAyMDI0IGF0IDAzOjIwOjIwUE0gQ0VTVCwgZ2FrdWxhQG1h
cnZlbGwuY29tIHdyb3RlOg0KPj5UaGlzIHNlcmllcyBhZGRzIHJlcHJlc2VudG9yIHN1cHBvcnQg
Zm9yIGVhY2ggcnZ1IGRldmljZXMuDQo+PldoZW4gc3dpdGNoZGV2IG1vZGUgaXMgZW5hYmxlZCwg
cmVwcmVzZW50b3IgbmV0ZGV2IGlzIHJlZ2lzdGVyZWQgZm9yDQo+PmVhY2ggcnZ1IGRldmljZS4g
SW4gaW1wbGVtZW50YXRpb24gb2YgcmVwcmVzZW50b3IgbW9kZWwsIG9uZSBOSVggSFcgTEYNCj4+
d2l0aCBtdWx0aXBsZSBTUSBhbmQgUlEgaXMgcmVzZXJ2ZWQsIHdoZXJlIGVhY2ggUlEgYW5kIFNR
IG9mIHRoZSBMRiBhcmUNCj4+bWFwcGVkIHRvIGEgcmVwcmVzZW50b3IuIEEgbG9vcGJhY2sgY2hh
bm5lbCBpcyByZXNlcnZlZCB0byBzdXBwb3J0DQo+PnBhY2tldCBwYXRoIGJldHdlZW4gcmVwcmVz
ZW50b3JzIGFuZCBWRnMuDQo+PkNOMTBLIHNpbGljb24gc3VwcG9ydHMgMiB0eXBlcyBvZiBNQUNz
LCBSUE0gYW5kIFNEUC4gVGhpcyBwYXRjaCBzZXQNCj4+YWRkcyByZXByZXNlbnRvciBzdXBwb3J0
IGZvciBib3RoIFJQTSBhbmQgU0RQIE1BQyBpbnRlcmZhY2VzLg0KPj4NCj4+LSBQYXRjaCAxOiBS
ZWZhY3RvcnMgYW5kIGV4cG9ydHMgdGhlIHNoYXJlZCBzZXJ2aWNlIGZ1bmN0aW9ucy4NCj4+LSBQ
YXRjaCAyOiBJbXBsZW1lbnRzIGJhc2ljIHJlcHJlc2VudG9yIGRyaXZlci4NCj4+LSBQYXRjaCAz
OiBBZGQgZGV2bGluayBzdXBwb3J0IHRvIGNyZWF0ZSByZXByZXNlbnRvciBuZXRkZXZzIHRoYXQN
Cj4+ICBjYW4gYmUgdXNlZCB0byBtYW5hZ2UgVkZzLg0KPj4tIFBhdGNoIDQ6IEltcGxlbWVudHMg
YmFzZWMgbmV0ZGV2X25kb19vcHMuDQo+Pi0gUGF0Y2ggNTogSW5zdGFsbHMgdGNhbSBydWxlcyB0
byByb3V0ZSBwYWNrZXRzIGJldHdlZW4gcmVwcmVzZW50b3IgYW5kDQo+PgkgICBWRnMuDQo+Pi0g
UGF0Y2ggNjogRW5hYmxlcyBmZXRjaGluZyBWRiBzdGF0cyB2aWEgcmVwcmVzZW50b3IgaW50ZXJm
YWNlDQo+Pi0gUGF0Y2ggNzogQWRkcyBzdXBwb3J0IHRvIHN5bmMgbGluayBzdGF0ZSBiZXR3ZWVu
IHJlcHJlc2VudG9ycyBhbmQgVkZzIC4NCj4+LSBQYXRjaCA4OiBFbmFibGVzIGNvbmZpZ3VyaW5n
IFZGIE1UVSB2aWEgcmVwcmVzZW50b3IgbmV0ZGV2cy4NCj4+LSBQYXRjaCA5OiBBZGQgcmVwcmVz
ZW50b3JzIGZvciBzZHAgTUFDLg0KPj4tIFBhdGNoIDEwOiBBZGQgZGV2bGluayBwb3J0IHN1cHBv
cnQuDQo+DQo+V2hhdCBpcyB0aGUgZmFzdHBhdGg/IFdoZXJlIGRvIHlvdSBvZmZsb2FkIGFueSBj
b25maWd1cmF0aW9uIHRoYXQgYWN0dWFsbHkNCj5lbnN1cmVzIFZGPC0+cGh5c2ljYWxfcG9ydCBh
bmQgVkY8LT5WRiB0cmFmZmljPyBUaGVyZSBzaG91bGQgYmUgc29tZQ0KPmJyaWRnZS90Yy9yb3V0
ZSBvZmZsb2FkLg0KUGFja2V0IGJldHdlZW4gIFZGcyBhbmQgVkYgLT4gcGh5c2ljYWwgcG9ydHMg
YXJlIGRvbmUgYmFzZWQgb24gdGNhbSBydWxlcyBpbnN0YWxsZWQgYnkgIFRDIG9ubHkuDQo+DQo+
T3IsIHdoYXQgSSBmZWFyLCBkbyB5b3UgdXNlIHNvbWUgaW1wbGljaXQgbWFjLWJhc2VkIHN0ZWVy
aW5nPyBJZiB5ZXMsIHlvdQ0KTm8sIHdlIGRvbuKAmXQgZG8gYW55IG1hYyBiYXNlZCB0cmFmZmlj
IHN0ZWVycmluZy4NCg0KPnNob3VsZCBub3QuIEluIHN3aXRjaGRldiBtb2RlLCBpZiB1c2VyIGRv
ZXMgbm90IGNvbmZpZ3VyZSByZXByZXNlbnRvcnMgdG8NCj5mb3J3YXJkIHBhY2tldHMsIHRoZXJl
IGlzIG5vIHBhY2tldCBmb3J3YXJkaW5nLg0KDQoNCg==

