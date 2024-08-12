Return-Path: <netdev+bounces-117660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE78694EB53
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C861F227E0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9216FF5F;
	Mon, 12 Aug 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tJoBdoWU";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6V0W4/bA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0016F830;
	Mon, 12 Aug 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459209; cv=fail; b=Ig4dovAyAS/4rAPwsd0W/cg6ZY1jVlI7CShouAXny6x8ALtW7iNULp1EOqVoyCLRxRmsNakDjDTxR03XyrrzVUSOjJO4L0F9MB5YVDcdSCbi4z6AuMArHMMfKgXpwRMdWFqRdMnQZd/JoYSdvBsgAAygz5uKkahfUJJ1ZCaFCug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459209; c=relaxed/simple;
	bh=7SMFtDCzJRcD6/h+F3BtyRUsdkVmR1BcWAdqrE3+jSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LoRleowQrNgoCeiarrJ3OIzLQ1frRknPu6t63o9QMej5f3v8qQBndBaN13gplwKTU4L4M6Tb/CBRcLa3cVfy5qRBYXsexChJJk2LduP+9wKQCzC/mUVB8SQZYO1VcKq7Xni2QYk2pZe+rVcpzXXCvdQFHIEHqbWUNme3dFrU9XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tJoBdoWU; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6V0W4/bA; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723459207; x=1754995207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7SMFtDCzJRcD6/h+F3BtyRUsdkVmR1BcWAdqrE3+jSU=;
  b=tJoBdoWUEqjWbSHfyiy5vskLVEhBKrFHNBzJlSv7OYGHhuGwzYfJEuNj
   25/vhwcGbKlNF8IVC8yavVSh2oUD0yhGB2e0Sp+yyPkVlEM0CQvLZghdt
   FBETEhNR7sDGoHBTleQo3qT5PUP9IKnE3FgXk87wlluHMZr6dSE6gZwN5
   I0OsNxiiZ7j7ZEo5VPlVNcZt/l8yenDrq+yAsSsb0iWtowbR3Vt6FRAXf
   TR4rLwO6O10V7E2Fr2t4Acq+pyup0U6cLjFIw8tkt1WIhOZKW0iskeChO
   4+gjK6DeiUAUWICZ/Nf708zt338KInW/cGQwczIn5e8rup3cdJ27/mLM0
   w==;
X-CSE-ConnectionGUID: u8Jd7vCLQYuyb1jevy/brQ==
X-CSE-MsgGUID: sKD9Zi1CR1eMs+SLGEMX4A==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="197798400"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 03:40:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 03:39:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 03:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPaVRuhY7SbOw4lkTDjkTQMGxRpaRWSfgp0WzjWUV1KoltyzMsRVlYJ1M2xcijA+klXzIMoWiA38QzG/gK1FvvG5lklcyKvCKlKlZLnrkom8QpG92TAFbYTQZd7M3bLQzRN3dq4OM3q4PUEKurJMqKkfqJBO/tEzV4xk8Y+MrusZwVP0ezBqE6kmcRJYuroPwvuvV2Xy04ma4svVovd426atpbxRLNmlJxj0QuGNFT4wummockcu7UhezNlsa19PyOjC14f0VW6j8zO9mEai3jIXL8Wy560dJvVrIEP+FXrG0YM4+1uVdEgDyIWKcunobxfaFHTIsL+LdbMK5IYnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SMFtDCzJRcD6/h+F3BtyRUsdkVmR1BcWAdqrE3+jSU=;
 b=PRqDomOLgupgmGQxjmTA7fB3A3vNQo+UeE3HGX16Hm4P5R1QFEuIQkqBB28hFVTcj9/YMgz18YrrECBDkpmhDUSrJ5R8bT88i1SR7A8NmnOwS14D4KNnhTXiMdUNFNcxmsK+KGCxPIAgpDO7FlFzwtDdsuAAJD4Y2YBNmpbTVzFmuqqGO4bArhqsggolG9Qya7FqLKYuveyaAOyd47D4uTigc7S0LH0//I/1H+UP/UUXkHxM6jK+9otoLykyA9eFae0xpEzbMxq+IPbMDKABmPu0T+kndAmsW8CUjGrzlArIzMlw9/UGKnjIvvSRa7+SSEiqTfeULzsJUXsnLukkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SMFtDCzJRcD6/h+F3BtyRUsdkVmR1BcWAdqrE3+jSU=;
 b=6V0W4/bAQS8cCvTdgk/Go5Kje4fWkRbvnOAZwYOqIQ7gTJncO1wsr5Ft1SK0CfD6mpEkYNgtc0CFg3c1wFlMo8Q91tNbfEzjFGQY7JOHYziV6BcXoaMp7zlL5HWILajtduvrvLpT0yVPNz15AOz96DVxo1aDxiQWFHRqsjN80Q+ldN3HHFE4hrNL/jHyS17r3nch/xngiWN2Fk0hgRR1mO4SsUV88vvb8r79u01IbAc4VrVe1TInTmPVkkmzpisczOxwZzLnlcWrnvNooZktwTraATVjMYJoHCa9CNK4otn6sFOnJSvs940T+yu8mtY3QCfDgf0ArCCiB3Gfwtjv5g==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Mon, 12 Aug
 2024 10:39:44 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 10:39:44 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Topic: [PATCH net-next v4 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Index: AQHa7JTP/V8AYxq9p02+kJzcRagnaLIjb2cA
Date: Mon, 12 Aug 2024 10:39:44 +0000
Message-ID: <0440cceec9f3292bdc94cccafc945cce66ebc471.camel@microchip.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
	 <20240812084945.578993-5-vtpieter@gmail.com>
In-Reply-To: <20240812084945.578993-5-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA0PR11MB4750:EE_
x-ms-office365-filtering-correlation-id: 45e51448-8999-40f6-60b5-08dcbabb149a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEtvUXdrYytUNVVkdTUvZVZDb2M1NTFObWZPdjZMK2tGUGphTVJ2NGVRbG1D?=
 =?utf-8?B?MzR4TTlyZ3FVSFExSnZuOEtiZjMrSlRjVGtsY2tiaGFrN2dweUhWTUYxWXRj?=
 =?utf-8?B?bGkxY0g4OU9aSEloSllGZS9RWHpDUzNMVGtLUU5LdVIycGtEbitjdmZFNHhJ?=
 =?utf-8?B?ZzhIcXlnSjMwclB3Zy9welR0aHZsRitsZG1EYXVuaWV6VDMvSFBteGRWVjQz?=
 =?utf-8?B?aHV0Q1pjejRzYjA5UG5MNTlhVVRhN1dCQjVWS1ZuSWVVdGp2RUtDMUNtVkh4?=
 =?utf-8?B?ODl2Mm9QQjJsR3ViSDFGUXo1SjhXa0hvUmVBazc3RzFvT01iZWtYdjYydVhu?=
 =?utf-8?B?UytYRE9ORU1TdEtBUTZ0Sml2T1dudy9HTGd6WFY3UGlxaVhpTmFvdWFLUkl6?=
 =?utf-8?B?Zm5RQzhiTUc3UnNTWmlSdDFwYW9xdUpLdXEvc1hIRGU4R0tHTlNleUNud3h5?=
 =?utf-8?B?UmF2QiszYnJNdExsSzNETEQ2YzVoNy9FNWtpVGt6Y0FUT1VYbUlkd013SnVw?=
 =?utf-8?B?TG5vOURwMzB3c1VGajZPWCtMSzVvVGpjVTRlbmVueFUrU1Vjb0VmZnpyRjZP?=
 =?utf-8?B?VXhFK3VWeG9JckkyaUVIMjFtVEJ4L2tNREVzRnNUTG0zR1VjaGZ1aXBMdFkw?=
 =?utf-8?B?cmMzdm9xUDlxYzcvczEyZjJRa1JDU2cwN3BRV25GSE52Ukg5VVNKdUJVL2hz?=
 =?utf-8?B?aDFEc3BpVlNTdVJtU1B3UGtiNTc3UkZMYXlycHg4VnhqQkl1VkZ1REJsa2FO?=
 =?utf-8?B?aHpTdzlJYkZuWjliTDVGSjBtYS9OSUVveXVDZ1hWTFF0OTFicldScTZNdGFW?=
 =?utf-8?B?YkcwL0ZJOE1pV3lyalNBVjhONXRVV2psdVdLM21BbDdJZkd0S25FVDFjT1A0?=
 =?utf-8?B?bFdWY2xSZGc0cXh6RkZLV2Q2aFlpOURRSXBkTW5QZG5NQ1FudkF1c2JNSFEv?=
 =?utf-8?B?U2lZUTJwSmJWSVNyWnpaZDZXZFBveGVINlhDeU5RUWJ1T0ZWU2NueXJOL2pv?=
 =?utf-8?B?a0xEZzZNRkJZYnpHbzhQQzhPVjNlaDNNYzNEdWRrZHlpSnFvK1cwNDYrSy9s?=
 =?utf-8?B?T0Q3VWxJQWVZL1REcUN5SmxtVHFBQ1NEbGg4NlQwNlpiM24vcjZ0cWlqU1cv?=
 =?utf-8?B?NkpCY0xxVEJueXphZWl6cXdxM3J5bS9qMkdYUWVHZ1NOM3l1Y2duT0xFNEFR?=
 =?utf-8?B?YzE4UmdOZllXb2w4WnZPWlNQY1Q3L3RMTDhkRmpNTGJOTWVNcWZyd1h3aEVM?=
 =?utf-8?B?ck5aU2dKaU5SbHdWSG1FSis2c0g0QnZObHkxeGFVNXJ5TXdYNWhuN2x1cHhC?=
 =?utf-8?B?N3ZNMnQ5MTVOSkd3VHYrZU1XNUhybk9tTk00ZmNtelJhTmI4SW9UV3hRYjBE?=
 =?utf-8?B?czB0ZG9yVVE0K0RLdzBKWVlUcmkyak16UEdWODNPRlVCVUFzVEhUN2Q5c1VF?=
 =?utf-8?B?SmprUmNnZXRsTGdVSkdCSmd6ODYxVFV1Z1ZWeFZmMFJqU0dLbUhRdFpCUmRm?=
 =?utf-8?B?STRZbDQ2TnBYK0o0WkFDTk84V1gyaWlqMC8vL1Fod1owbGpXUFI1ZnB2MGhv?=
 =?utf-8?B?ejRRa1JnVmZZR0crSkZYSW0zemFSUFBxdjRiQWZ6WkJrNTdEeUZPbW9qV2R3?=
 =?utf-8?B?RWRKZmhmL2ovSHBGTEkrVkZWWnlrbTFZSjVUSXd0Yk1Nb2xpRXVPTkt6ejhN?=
 =?utf-8?B?RkV1b0RQT3pIZS9JMVVJbGRrc1hxL3kzZ2pRc0xGNjl0Sm5KZ3EvV0lzVmhY?=
 =?utf-8?B?cGpoMXJ6ZUU4VGRKYmJHWGNjZVE5eGkvUUVRYVErT3NxSHdTY2doWFdNTXFr?=
 =?utf-8?B?RVpjSTdhTy9YMm5yc2lxUi9SZE8zY0I4WFY5WUZMYzczNE96bDlQVzJFdWt1?=
 =?utf-8?B?KzZHMlVWNlozd0dSSkN1WUxieU9jWjlQUVdrRmUzSCtlcUlWQU5LS2dPMXdF?=
 =?utf-8?Q?uPMMXLC7+oo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ZmOVhoRGF2QXRXck41NVhhZXVwd2FWOWhpZ2g5dk1USU9ma3RqSkRlNWFa?=
 =?utf-8?B?Z0JuTDZDU1lUWERvVCt4bUs4UWU1RHpQL1Y4bEdFTjlYdVN1U2ZhZXBMMGZ2?=
 =?utf-8?B?TmVUa29oaDFBcTlYRy9iajFTUURFM1Z0TWEyai9MY0JnRDVUZnRodmQzU3N5?=
 =?utf-8?B?QW9rWnBGT1VOZjRVYlpsby8rZko2RnlCMFlJeUM0QnYxaVk1eDVGZkpJQ0FU?=
 =?utf-8?B?NEtaT2JsMkNXZEtad09jdUpSMDlTSEJUa3NsYW8vV0t3M01XQlEvdzVzdXZk?=
 =?utf-8?B?Mm1CSTFxM1JUcko4RWtRN0tORlQzc0hhVDEwUmFYOWU3dkwzNGpKVXFDNE4x?=
 =?utf-8?B?Q2dyUURIR00xYk5MRHNrNjhrVnZHQitCamxvU05OT1lGeW4vRlNEazlzMGtn?=
 =?utf-8?B?WmUyYlA0MDJsUmxlcUh4OHEvaW1KaFEvdE0vdHVlL0pkUUVoWTV2bXJybUMy?=
 =?utf-8?B?WkwvWFRrS1E1QkVQTldzakJSdStUTVVJb3BXKzEzeDRDeDFJbzcrYytHVmVS?=
 =?utf-8?B?cnBmUjJ2N0VRQ1VqL3dXV2xkUDdPeUV3MWFhdWE3L2xoTCt2VXMxRExneVlo?=
 =?utf-8?B?TGhkTUUrNkNNV2RqTzVvNHdTQy9sTFdGUUNJWnFhcVpJQ0VmaFZlcDZncWZH?=
 =?utf-8?B?YVg4Y2tETzk4ZTdVeWwybjZZS1ZSUUcyRzVOcjVXK2FzZ3gzNk5DVE15Y3RP?=
 =?utf-8?B?TzNVTDlvajFCa3JLSVpHQWdTaE5idlRVcVFNeFNITnY1aWpXd1hnUUZ4WVJ4?=
 =?utf-8?B?NElqY3lQQ05BVVoxY1ZReWc3SHYvcWFFWTNRNHNjbW1KNnNnNzJsSHRVaCtk?=
 =?utf-8?B?WTUrUUxsTXR3dEJjcm4wSUZQNS9hRkJ3MzlmY21JS0tTNDJiTU9qK0tpS2Y4?=
 =?utf-8?B?OXN5T0E1UDRjVnJ0TFFib29OSjViYlY3c0s4L1lsUmRTQzk4c3JYY2xCUjhC?=
 =?utf-8?B?S3hEd29STWdXMUthYTIwYkhUZEFNVE1WWDF6bU8wQk1MRHhyS1lReDZrbFQr?=
 =?utf-8?B?cHdwNVB2TkNqTEp6YW8xcFg0SUxmSWtPTThaeWwwUlZlaTZkVFVBdVdwa3Vt?=
 =?utf-8?B?MHBtSW0yd2h0RVJCQi80aWJNZUY1ak5VR1NLWlI5bEpVbU9GQ1pTM1BJanZX?=
 =?utf-8?B?K3I3cFBnb255eEhVd1dSMU5qWG9HZGsvQUlXUnM0YWRXMXJwTTY1aWhvVE5x?=
 =?utf-8?B?ZFZCZS80OVhvdExEQWgzS1Nkek10LzZ0dnFyZVA1VjA4NHhQOXFVMk1TTXVt?=
 =?utf-8?B?MEFReXZtaEEyRTZ2TWtWTVpkVEpKelJVU3VRb1UvdHFxZ3E4UTRZL2tNdVRt?=
 =?utf-8?B?WUJ0M0kvMFBuR3JRTXg0Ym5JTFpoU0N3WWR3cXdsVWlzK2pSdmJSRE1ZSm9m?=
 =?utf-8?B?NzNhSXR2TGR3QTJyQzZIVXpVU3Nnc3dEUkNNVWh3Q0lWdXB0azNWYnZxb0JH?=
 =?utf-8?B?Ti9wNlMyVUMvMWkzSFBqUEFJMWxtUHQwdlVRVGtkYi8zQnNteWhQVUhlTTZi?=
 =?utf-8?B?a2ZQNW44RTJKdEVKQzlpVEZhSVB2STRxdmRXajR5UEExL1F0RzRtTVB5empS?=
 =?utf-8?B?NUtrRmVYUzZvaXlXOUszUGg0dkdBQ2ZabkxKUE9IbGVSaHpyOFh0L1RicWVm?=
 =?utf-8?B?YWFHSXpHNnRzYUdENHZ5V2xVVVdTZHMrN3BMUXdvOTVBdEN4a25FTzVySnVi?=
 =?utf-8?B?WDhtckhKeE9FTkVIMVhqRnNpd1VYNERrci9zRVFSNW1xeW1yUXY4elhVNDJZ?=
 =?utf-8?B?a0Q1b1l6dHQ4QWdPRUE1KzJnM2lkdmZlVHBodnRzV2FUVElzT0lsN3BRT25J?=
 =?utf-8?B?clR4enJkcHJZVTZBK2w5Sng0SXlOd2d4U3AwZytjazNacWJwMGdoY21uMXBr?=
 =?utf-8?B?UkpJVGQ2cmVxVXVDbmJmbnkrVXo0T0FRZC9tTGpGeUMvU2xyTGNqNlJ5N2Fx?=
 =?utf-8?B?eldWQWZVaEI3RDI4dHh6ajh6bjV6cjFMMktsaURQRklDL2xyYVdaUHpSMUR2?=
 =?utf-8?B?WnJXaDZFL0tRcUhMdG1mWlRIZlFoSU1NeUplU3dYUHFhaXhINHVDa0lkYm1Y?=
 =?utf-8?B?UWdwekZ6dWRmaGw3VmYxQjRxcDdhWkQ2V3pnNStEZkcrU3VBYmQxYitSeGxT?=
 =?utf-8?B?L2ZPbVJUdlRIV2YxbXFYbVk0YlFOWlRFYXdSMEYvUTFvSEdLcUZlK2hnNTNi?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <472305FCF8296E47A097C2F533F10170@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e51448-8999-40f6-60b5-08dcbabb149a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 10:39:44.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7iIwdYB0Yd0SuJPOuviZcb3hnoonSudIk9BXF1Vb5QzyjNBPxSn74cX+9KPqhrfzvoFk6b/fBejIiZl2Yafl464NRhv1i60qrP/7SyH9U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDEwOjQ5ICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IEFk
ZCBXb0wgc3VwcG9ydCBmb3IgS1NaODd4eCBmYW1pbHkgb2Ygc3dpdGNoZXMuIFRoaXMgY29kZSB3
YXMgdGVzdGVkDQo+IHdpdGggYSBLU1o4Nzk0IGNoaXAuDQo+IA0KPiBJbXBsZW1lbnQga3N6X2Nv
bW1vbiB1c2FnZSBvZiB0aGUgbmV3IGRldmljZS10cmVlIHByb3BlcnR5DQo+ICdtaWNyb2NoaXAs
cG1lLWFjdGl2ZS1oaWdoJy4NCj4gDQo+IE1ha2UgdXNlIG9mIHRoZSBub3cgZ2VuZXJhbGl6ZWQg
a3N6X2NvbW1vbiBXb0wgZnVuY3Rpb25zLCBhZGRpbmcgYW4NCj4gYWRkaXRpb25hbCBpbnRlcnJ1
cHQgcmVnaXN0ZXIgd3JpdGUgZm9yIEtTWjg3eHguIEFkZCBoZWxwZXIgZnVuY3Rpb25zDQo+IHRv
IGNvbnZlcnQgZnJvbSBQTUUgKHBvcnQpIHJlYWQvd3JpdGVzIHRvIGluZGlyZWN0IHJlZ2lzdGVy
DQo+IHJlYWQvd3JpdGVzIGluIHRoZSBkZWRpY2F0ZWQga3N6ODc5NSBzb3VyY2VzLiAgQWRkIGlu
aXRpYWwNCj4gY29uZmlndXJhdGlvbiBkdXJpbmcgKHBvcnQpIHNldHVwIGFzIHBlciBLU1o5NDc3
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRy
YXBwZW5AY2Vybi5jaD4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NA
bWljcm9jaGlwLmNvbT4NCg==

