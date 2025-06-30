Return-Path: <netdev+bounces-202318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BECAED3DE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CD03B286C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 05:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE122339;
	Mon, 30 Jun 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="L3WJ9NkU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9E1E502
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261638; cv=fail; b=icgLgEsf1IsE7F4USi4gZkNW9DVFMRsfDxqzei2D8E5Gt2u5Kq/pD1RRVkNFc6HLakqy1lSDGmPbjuW4fHzfRoeYoKtz9sB+glWGX3gxGgF1vUY8OwZh0ONsQKXW5zADr7ba7osUbhgIMCMRB5iyTOolcCN579GWJmB9l78PDBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261638; c=relaxed/simple;
	bh=qAOWw5CDOTcBBm9XQPrekh8Bp9vnwUVk0y+3wp2Wm+E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECG8AY/MEoSkG99bN59KcW1UgLi9TU1+mfSl6ND8uPacc0YeO/HdgajqoJaCUmjYJ0k2WbW5my7jh6PK6lWQifXeturiV93zRHDvjhLHmU1tAMbcUKaMFFVw1lna4eMNU/0vQ3nhRObcivTKXOhWRbzYzC10TZN/YAn8KB62O7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=L3WJ9NkU; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNIjhK000863;
	Sun, 29 Jun 2025 22:33:34 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47kf1x0h8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Jun 2025 22:33:33 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U5KX8v000656;
	Sun, 29 Jun 2025 22:33:33 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47kf1x0h8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Jun 2025 22:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsUFOgsn98iu9sJWVRcq8MFFU2IdBjWpPLpFT6WQxP2ahdrY9niTQFIL/nVnxMYnWaCVJJtGysbpL5rbvWHKGtbvUv8ocjSyn076zHI2P92vSXZX+Fd57y62XnGsmaLv3AwTnA4NTFdVpuPgiyeuV1imMp14XXnk4kVsLmE7Xd/SGKA7RggrDpOu2SQzHDfdvrfdugPNpIIaK9tjyfUTsckYR0fFOFHE18h2BYtaDttESJZvVx0KTjFJMFQuFESKdeeG0YrBXvaoiaB7JnXs3zQw/Jn/tk33i8Cd7RyxrKn4L00sqRB4cdRbne73npydD3U8LcpG/V/9YxZmBC/9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAOWw5CDOTcBBm9XQPrekh8Bp9vnwUVk0y+3wp2Wm+E=;
 b=b35YnfunY12j68OitbxJB2IqYmZNjSgDBbNf+ACbMbayTlE0WmcxZXra7cHT1rqsUFBii+b/E1ZdNfRW0l0Ccd1Msppf/+KCBdrPr7+gednhUdp9ZYbbQg+Zc0y/mjmlcLq/ov4N81LF/+9D6s+LcwCTDD+P56JsnjORvX2/+KtIyRu+Dxs+Mzd05IOKwCOfG3MyVh2zGw1I9Tc8ZP9xyLeFaXNojxzPopYgiPL2sJryEEYJjRG0QiNM7L3aNF5GmX54mvo342j69SOfgokgRBu5s3Xlaw+5a6BRjdtQ+1Qfe+0KUn7EaCAKRZzw2e2ZS3rMnD0sS3JoiNWqce4VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAOWw5CDOTcBBm9XQPrekh8Bp9vnwUVk0y+3wp2Wm+E=;
 b=L3WJ9NkU6/mzXiY8hefaiAj9F+lYqcvd+PFF+UjtvORBwRLHt7+VJkGfI2inC4KqzSAIi87kfAequ58hTZ1tV5J/iCLCpTQh4i7BPJIzlKDUXYygrH31S7+ct+EIMmDuJHR1z6GswgJgs69+LWCggU/+uYeedzKyl67mbT4F/uQ=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH0PR18MB4701.namprd18.prod.outlook.com (2603:10b6:510:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 05:33:29 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%3]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 05:33:28 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [QUERY] net: octeontx2: query on mutex_unlock() usage
 and WRITE_ONCE omission
Thread-Topic: [EXTERNAL] [QUERY] net: octeontx2: query on mutex_unlock() usage
 and WRITE_ONCE omission
Thread-Index: AQHb6E134At5G5wqHEGLG97lDk8gGLQbL0XQ
Date: Mon, 30 Jun 2025 05:33:28 +0000
Message-ID:
 <CH0PR18MB43394685C04D448C0852393ECD46A@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20250628165509.3976081-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250628165509.3976081-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH0PR18MB4701:EE_
x-ms-office365-filtering-correlation-id: b4a6f0f3-d7a3-4320-9854-08ddb797a46c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDBMcVA2UlZjYlY4c09yMDR6REhTRng4UEJOZFRwNjhnV2lwVFdwaDh3WXha?=
 =?utf-8?B?RU1nVmI4djJCL0s2SW9jNXlScmROQ1pnQkZ3Y2ZiSVZrakZDL1krUlFUYVNT?=
 =?utf-8?B?U3dyNHN4T0k1d0tJMGNid2VNS2syOC9OeGVLcEtiZ2k3OUw5Q0w1bFllS1FL?=
 =?utf-8?B?WiszSWphMVhGUlc3dnUwTjZWTUVTdVhPTjBKR2xZSmZ4aXVrZi9LMjVVdTBm?=
 =?utf-8?B?a2JGc0ozK2NaVVJjcEZOYTJiZmRFZ3NTeEZLcGZFd2kveGtFck9RT0FRNjha?=
 =?utf-8?B?T0VrUWFvektzVmlFSXdhMXZaY1hkRXJJaTJ5TXY4V05vT2Y4OFFhOUZ3Q3Z6?=
 =?utf-8?B?cENWYS8vVk95ODZ1TUdGUkxLUHIrNEYvOUV4Q1lNNTVJbjVYYWdwdG1mL3pU?=
 =?utf-8?B?OHdldk5NOWw5aEh0VDBNbTNHR1FNSkZFZlFhM1VRS2tpZmlXZnVxV0EzUjNv?=
 =?utf-8?B?UFZ1d21YK0c5SHRqRWVXTjhoditPVzFwK0JyaFc4R2JEYkJqL1Fra1VwcVZm?=
 =?utf-8?B?MXArdUtpbUVEcmJPNDdIT2Z5VEFROHBCcjBQVlUrbjdPRXJUZDBTUTZITzA1?=
 =?utf-8?B?V0xtT3dScHFOZW1hN1BQMjRkK2RWM0dodXhtUEtxRlNEMzZsU21wMHZGQ3Fs?=
 =?utf-8?B?NlRiUExwRG1vQjYzdnZXM0JkelNsMy9ESkhoMTRxZUh0K1VJSG5PdGhiSEVV?=
 =?utf-8?B?RG9xYjhyeEY1cHJqcDlDZ1hLWXRnYks2bDF0L004OXBWcFNaQUMvRGYrcGFy?=
 =?utf-8?B?YitjVVBmckIvdjVSSGFiZWdmVDBpNm01M0VwT0I5eU1nOStDd1dORkI4Mi9E?=
 =?utf-8?B?K1E4NWxxQVYxeS94TU9PZGhTQllmV3p0QTRibm5sVDRSNDVqYWlmYjdBanYy?=
 =?utf-8?B?MEo5VVI0SEZqN0JjaHUrWGRIK2JZYUJRenNyUUJMODF4NTU5b3JSRkFPMWV4?=
 =?utf-8?B?REFDYnV4TGVscFZsYy83SXhvaEorUHd2SW9xQU01cUlscjNXNjlzSVFJcHc1?=
 =?utf-8?B?TWF5MzJVRFVLQXVaY09qa1BKdUlYTGg5TlRHUWwyM2xCNGovNTVxbjBwa09r?=
 =?utf-8?B?VEYyblFCV3B0WW5kNFlzUG1ZVXByYit2RVY2R0sxRSsxQkJEZWNwYXlNMTdp?=
 =?utf-8?B?ZTk2ZHZPKzJ0MjcycEFWYjZxRE5GTUdDYUJlK24vcklxaVVNcS9JQmVKbGlP?=
 =?utf-8?B?S3JIdENGc2tvVnkwc09xejUwak9LVFJBVGthbkxzVEVFclNHL21DcXRBU29U?=
 =?utf-8?B?TTIyNGFFYWxkOXk1V3RzbWxmdG5FdmxFekIzU05TRHF5M1pBY2NncVpWbjl3?=
 =?utf-8?B?OWg0VUc5VHdqNWMzaDkwSDcvWnlPQ1l0Y0oyRDlNMytyT25HTSt1Mm14N0Ur?=
 =?utf-8?B?WDVJeXpJRFlnSHNDQnlVN1lGZVlvajhqSm03NUFTdkJoTG9vclhSS283S2tO?=
 =?utf-8?B?SVBCZm9ac0FlQXVkS3FXTVRNYlJQemtmcXA5YkhmQmo4VTdxaEFHTGFBRUtB?=
 =?utf-8?B?b3AzU2IrT2daSlZ0SUgycGsyVEpFMjhTTEVvZXFMa2ZSWkNDcjh4cnhNYjBq?=
 =?utf-8?B?OEF2ekswQlZYOG1ReGxFc0NCS2Fabm13bzlZclNFK0NTa2x5VEN6TmlhOHpZ?=
 =?utf-8?B?dGc2UEdOazZkanc0bDd3N0VoNnR6d1E3K3FrcG1tMUVENklHK2E2SzMyZGk3?=
 =?utf-8?B?UjdqcGdPcHNmYkhNeXZKaGpNVHQyUG1yUEVNQ2FKRFo2RVZRV0ltMkxId0V3?=
 =?utf-8?B?cEF3dHdTdm9yOXYzV21HV0dIa2dmL0ZrcFdvMjlld2NQbWYwUVNwQ0pLQzNK?=
 =?utf-8?B?eWpyUzRYMldoZms4RzFhVVlNVlpVVElPaHRXK01PL1E2K1AyYXZkWUlGUkFW?=
 =?utf-8?B?SFlLTG9DU1cvRjN5cDlxSkJpdHFLUmJDNW05T0tqOW54b1FCSjdRYmowNVZS?=
 =?utf-8?B?ZTJrYnZWM25icGpMOHhscWpqTVEvUldkUllsMjAvQmxYWEdlWWhhZENFQVpK?=
 =?utf-8?Q?c+2N/wRtd/SO+zTNGXfnNNUrRKKgSw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WldnQzRlcnR5V2RHQnNCVzZmR2w4U3J1Y21CZG9oVXRYWkpkMjRCanBSZ0lO?=
 =?utf-8?B?VE1QSEYvNHpTeTFDMzRIYlliZnpoSCtWY2VHcWNFYk5uVkdIL0luZlJOc1d1?=
 =?utf-8?B?SjFqQTh3YWYvMk90ZWFjekJpNDBqOUQ0bzI5ZnRNb2YyYTB5TmxXVnJualhw?=
 =?utf-8?B?c20xc3NUOE94b2NPZk1KTzF2L2RXZ045c004dGVYcEF6UHJ4MGxDczkveXdM?=
 =?utf-8?B?bkdSRzNYNjBuV2RQMjMvd1FwTUhxMmpQaW5JR3h2VFZDNGRXL0lLcTZ4MVN5?=
 =?utf-8?B?TDJsREdvdzI3a3JBVkdaNjBtb25NR04wdEJvTWQxOVRaQytObnBacDBRQmJl?=
 =?utf-8?B?eWF1RWdLcjE4c3FOdGdCMXJmMlZFVVJDK29ZRWVKV0swT3FmQ1QxQTBhRDhH?=
 =?utf-8?B?cENLT0xKUmJ6VHVsZjByR0VOK1hOTXoxeXFlRVNFaXhLNWs1d2NoeC94M3Fq?=
 =?utf-8?B?NFpLWkkzbUZLVWtIaHpXZ21NczRkdzVFUEdlOFBUUllXTW12R3Q2MnN2Z1VV?=
 =?utf-8?B?MGdxQkRYT3F3MkdDZGRhSVhpMEI0WWtOU2lQVldZVGFpWStRTkg2ckx6NmJ5?=
 =?utf-8?B?N2RnU0F6RXRiNExPWEFhbGlqdHY4UXVWS3NQYkYrSi80VFV2TW5lNVNNVmZk?=
 =?utf-8?B?MGdnNVEzT0VTdWJ6SXk3ZThINDJMVitoeFRtNUtkYUJGTjlVN2d3bnpTclZr?=
 =?utf-8?B?R2JTajNHL1RzRHNDdGpyclRESGpYTG5LRHgzRHlDUDRwa01LTVNlTWVPLzRs?=
 =?utf-8?B?VUFIZnVaTE0yNmdlbmowZk56ay9WTjhVYmU5YjI2MCtEM1JCSEJhR0x4azJB?=
 =?utf-8?B?V2lwdFRQOU5iWUVYaEtyR1pUbDhHNHZud3NxZ1RtMXhCQThkUUpyQmVYU0Q5?=
 =?utf-8?B?aWdYQUE5cmtQWmIvaUVSaERWcHh3ckk5YkVLcW53Z1Z2a1Q2dllMT1JzT3BD?=
 =?utf-8?B?MUozTkY4QW1rMkhSSklRK25ucWszU2lzQ08rTlkxTHl1RXdLTTRya0UzTS9y?=
 =?utf-8?B?OU83Mkd2RC8zeTA2Z1JlbjVwZzA1Mnc0UnR6S0lyL3NBaFJXMldmQzRMUmZt?=
 =?utf-8?B?cW5yMzhRQWhwc2xOKzhIS29FWVRkMlB3RjhZN3lXVHJUSXpUNi96N1Bja2Z6?=
 =?utf-8?B?bmlkYnFCWDFydFF6UlczaUNzZkJUS01tYStQcW9nZFNaZDIraUNXMThPOXJa?=
 =?utf-8?B?Qjc0QTVvL3I5REFxRHo1RFlmK2RHbC94TmNsWWEvWWY5SUhoYUZ2Um1TcTJZ?=
 =?utf-8?B?NkR5aTdreVdOYTdYek9naVlOSGczZk1SdVBtc1ByMUdZS0puek5abnA1eU1Z?=
 =?utf-8?B?cGEweU4vV1JSRHU2OTBJRnd4TWdTOWxSVWdvNlczODFoOS9OaEkyMFd3VUUz?=
 =?utf-8?B?eUJFT3oraHYraDE5eEJWcUJaOFNNeVh2c3FDQTdzTXlORWlTRzN4QjhGenhr?=
 =?utf-8?B?YWFyVUszY1FtVlMza2J2ZWNQUDhQY2pwVmZHNUkvN0tOeG9IQVZwd0lPRDhY?=
 =?utf-8?B?ZUJiM08welJJOFV2WW1LUlErWFBPV3hqL3Y1bmtzN0NtdTVTUHJGL3JoY3Mv?=
 =?utf-8?B?QXRUTGIrb0dlblhmWmRYVlUrVWdzWFUxN0hsejB4UUNMemJ6UkhSWVhvTXkx?=
 =?utf-8?B?MWsyTnRJNzBJTGpaZUM5ek9zQVNlWDdyaGRtQlRrRGZENmFqai9LbUNmTDJz?=
 =?utf-8?B?RVVuT084L0I5WFZHM2lRTlB6dXlZZi8zTUdYVXFCZ1BNaDFnTW9kMGJRcHVD?=
 =?utf-8?B?cjcvYitwM1dZMW92YVA2bzNlb0wzQkhYeExKRTNmbnZObk5xbWl1QkRrRlQr?=
 =?utf-8?B?aFJ0Yjltb0cxRG1jRFRFcjdybnA4bzgyVGlnRDRudFhQOFNnVDhhRG03NkNY?=
 =?utf-8?B?V1VEdWN0T1pSWHIvKzVsKzh0RnFKK1Rlak1jR3FpU3VkRlNWQTFJT0FQZlc4?=
 =?utf-8?B?b2dtTjdlTGc2bjRHcWxIbUNZM1FhTlAvYWwvUkhWVk5PejVxQTczeWhqekFY?=
 =?utf-8?B?cERHUkN4azhNU0pqSk9EYUIrK0VmMDVQdkRTeUR4MDRMdGUyQXNBRDRVYmNV?=
 =?utf-8?B?RDZJSXBWT0JiRm8zVlR0RVZlaWpkNWhiYnNKdGZhNFVZYUVSWXd1L0poRUVO?=
 =?utf-8?Q?BsHo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a6f0f3-d7a3-4320-9854-08ddb797a46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 05:33:28.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zFFWO79Pr9yDyLcMULNude5RL4iWubShObNEsyIY0hCVi5fo/KdLjTKEeSWX0mZ7RyyLME0z/081A0PCnNLrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4701
X-Proofpoint-GUID: BheBbys11SKsuPjykpGl180pcs68kQP5
X-Proofpoint-ORIG-GUID: RUvEExxFZ4NeoDJyMuCYx06bM7L_3daU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA0NCBTYWx0ZWRfX8BFwHBDjB04D O7IhzCfLOCNr5qhYMJAe2X6h5NDrjYlh/l1FLEmtHeKz4+KJPQ0CW0znNnyxc+oCnnyGqmgz7Bn z0s3ZKLtDtobL4lAZ9ICCN5Zf6YWdwCK5xOiHuZLPUNMPZ0qft/kDiSk8VpwjqOvCb7TgsoHdIW
 ZQQQzIFkEPKBaDhHcqZ+hz5KWMnH5HYY+dzRrq0LvIpBde/fdJZhF1lrPX85EGaj5MJCyRSZz4t I3Ldv5mpdopY9Nn1o6IyXmGDUV1m303d/UJ6115InHemokYotKhtLPIq/+zau2ip8PoN0Boc1Qf QDZk2LVOqjGxY5Sw6Pd0AUiaQmlpQxgS1cIL0y5LlqJ5NXnZKNmEtybVVv0YoS+PopvmR81AugG
 fBkiPOZpLLWL8ZSOItOQTrzR2+hWFYFrRU9caU8HG75ESmjt1Kgx2kCQdQLSrvOQ5G/oJtYN
X-Authority-Analysis: v=2.4 cv=fpjcZE4f c=1 sm=1 tr=0 ts=686221ad cx=c_pps a=0gkWj3JdbaniHOU3BBBfUQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=yPCof4ZbAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=G5Lck_d9DYWJjZ7XHpMA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsb2sgVGl3YXJpIDxhbG9r
LmEudGl3YXJpQG9yYWNsZS5jb20+DQo+U2VudDogU2F0dXJkYXksIEp1bmUgMjgsIDIwMjUgMTA6
MjUgUE0NCj5UbzogU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47
IEdlZXRoYXNvd2phbnlhIEFrdWxhDQo+PGdha3VsYUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBT
dW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47DQo+SGFyaXByYXNhZCBLZWxhbSA8
aGtlbGFtQG1hcnZlbGwuY29tPjsgQmhhcmF0IEJodXNoYW4NCj48YmJodXNoYW4yQG1hcnZlbGwu
Y29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOw0KPmRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1h
emV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj5wYWJlbmlAcmVkaGF0LmNvbTsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZw0KPkNjOiBhbG9rLmEudGl3YXJpQG9yYWNsZS5jb20NCj5TdWJq
ZWN0OiBbRVhURVJOQUxdIFtRVUVSWV0gbmV0OiBvY3Rlb250eDI6IHF1ZXJ5IG9uIG11dGV4X3Vu
bG9jaygpIHVzYWdlDQo+YW5kIFdSSVRFX09OQ0Ugb21pc3Npb24NCj4NCj5Ob3RpY2VkIGEgY291
cGxlIG9mIHBvaW50cyBpbiByZXAuYyB0aGF0IG1pZ2h0IG5lZWQgYXR0ZW50aW9uOg0KPg0KPjEu
DQo+VXNlIG9mIG11dGV4X3VubG9jaygmcHJpdi0+bWJveC5sb2NrKSBpbiBydnVfcmVwX21jYW1f
Zmxvd19pbml0KCkNCj4NCj5tdXRleF91bmxvY2soJnByaXYtPm1ib3gubG9jayk7DQo+VGhpcyBm
dW5jdGlvbiBkb2VzIG5vdCBleHBsaWNpdGx5IGFjcXVpcmUgbWJveC5sb2NrLCB5ZXQgaXQgY2Fs
bHMgbXV0ZXhfdW5sb2NrKCkuDQo+Q291bGQgeW91IGNvbmZpcm0gd2hldGhlciB0aGlzIGlzIGEg
YnVnIG9yIGlmIHRoZSBsb2NrIGlzIGFjcXVpcmVkIGltcGxpY2l0bHkgaW4gYQ0KPmhlbHBlciBm
dW5jdGlvbiBsaWtlIG90eDJfc3luY19tYm94X21zZygpIG9yIGEgcG9zc2libGUgbGVmdG92ZXI/
DQo+DQo+Mi4NCj5EaXJlY3QgYXNzaWdubWVudCBvZiBkZXYtPm10dSB3aXRob3V0IFdSSVRFX09O
Q0UgaW4NCj5ydnVfcmVwX2NoYW5nZV9tdHUoKQ0KPg0KPmRldi0+bXR1ID0gbmV3X210dTsNCj5T
aG91bGQgdGhpcyB1c2UgV1JJVEVfT05DRSgpIHRvIGVuc3VyZSBzYWZlIGFjY2VzcyBpbiBjb25j
dXJyZW50IHNjZW5hcmlvcz8NClRoYW5rcyBmb3IgcmVwb3J0aW5nLCBBbG9rLiBCb3RoIGlzc3Vl
cyBhcmUgdmFsaWTigJRJ4oCZbGwgc3VibWl0IGEgcGF0Y2ggdG8gZml4IHRoZW0uDQoNCkdlZXRo
YS4NCg0KPlRoYW5rcywNCj5BbG9rDQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9yZXAuYyB8IDQgKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvcmVwLmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9yZXAuYw0KPmluZGV4IDJjZDNkYTNiNjg0My4uODhk
ZGRmMWZmZmIzIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL25pYy9yZXAuYw0KPisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0
ZW9udHgyL25pYy9yZXAuYw0KPkBAIC04OCw3ICs4OCw3IEBAIHN0YXRpYyBpbnQgcnZ1X3JlcF9t
Y2FtX2Zsb3dfaW5pdChzdHJ1Y3QgcmVwX2RldiAqcmVwKQ0KPiAJCXNvcnQoJnJlcC0+Zmxvd19j
ZmctPmZsb3dfZW50WzBdLCBhbGxvY2F0ZWQsDQo+IAkJICAgICBzaXplb2YocmVwLT5mbG93X2Nm
Zy0+Zmxvd19lbnRbMF0pLCBtY2FtX2VudHJ5X2NtcCwNCj5OVUxMKTsNCj4NCj4tCW11dGV4X3Vu
bG9jaygmcHJpdi0+bWJveC5sb2NrKTsNCj4rCW11dGV4X3VubG9jaygmcHJpdi0+bWJveC5sb2Nr
KTsgLy8gd2h5IG11dGV4X3VubG9jayBoZXJlDQo+DQo+IAlyZXAtPmZsb3dfY2ZnLT5tYXhfZmxv
d3MgPSBhbGxvY2F0ZWQ7DQo+DQo+QEAgLTMyMyw3ICszMjMsNyBAQCBzdGF0aWMgaW50IHJ2dV9y
ZXBfY2hhbmdlX210dShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPmludCBuZXdfbXR1KQ0KPg0K
PiAJbmV0ZGV2X2luZm8oZGV2LCAiQ2hhbmdpbmcgTVRVIGZyb20gJWQgdG8gJWRcbiIsDQo+IAkJ
ICAgIGRldi0+bXR1LCBuZXdfbXR1KTsNCj4tCWRldi0+bXR1ID0gbmV3X210dTsNCj4rCWRldi0+
bXR1ID0gbmV3X210dTsgLy8gPCBJcyB0aGVyZSBhIHJlYXNvbiBXUklURV9PTkNFIGlzbid0IHVz
ZWQNCj5oZXJlDQo+DQo+IAlldnQuZXZ0X2RhdGEubXR1ID0gbmV3X210dTsNCj4gCWV2dC5wY2lm
dW5jID0gcmVwLT5wY2lmdW5jOw0KPi0tDQo+Mi40Ny4xDQoNCg==

