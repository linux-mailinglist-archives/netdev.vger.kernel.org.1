Return-Path: <netdev+bounces-157594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407FA0AF42
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320281886BEF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3C23237A;
	Mon, 13 Jan 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="K26emCiP"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023141.outbound.protection.outlook.com [40.107.44.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D6232369;
	Mon, 13 Jan 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749131; cv=fail; b=JZdFyTzZDkrb3j21lU3+41o9qcayq+Ewa3g3Y8aydCVPsfzgz3UScIuPgFltGuK+zBt3k6Qsi778uBWv7TW/ZSS3/hhDiVK9BBVol3B+a/lqNh3JPM8INM0mQd/PKO6Ll+Y9GPS3UVLp1+RICrdqRCXOXB+sDt3QsWYcStVKBms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749131; c=relaxed/simple;
	bh=a7RSSD1Kq3bypSDbKmErrbixye0ltFBI1+34Dd+kUvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oyW87RGJLnrBueeVzx+YsLQCF+t8ktR+8V/PYxCm5pQc19dAOq5+aSaK8sDZFHyz4+KC6kJNkyJFNjOSRwFolbSfkZtueTwAs0E5zzUbuzQYa7fAo3rerlU2/RlY2qm56h9hun4pWX/s+uytqRW0xsHxfdLoYSBw0eYcGoV0q3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=K26emCiP; arc=fail smtp.client-ip=40.107.44.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUIiF6LZcao+0znAUjlxoWkoELcDgBPT0RqnEw7cRLBVKLwRID27TUO9dclj5LkLbaV6timMjrriNDj8+7EoOOzY0RkC9aU3AKGAQhNOd0q3ZhVylLFUuR/VQC0AQ26WMOzfN68rRrwTrht+yFASnLQjoXtpHxxvqUQgrZe43PNf/xdguatf1+fy34P0ieBZFTYWA1TUIQsXnBR8mZJLIqays4evhJw1TJZHgtla6He0eC1FIxl7O3/aAPjmyuCD8EiTc+GPyrR2+u6I1U/WuGMHV79lP0BHuDUKq0qU8Bk2JmD8thRd4/cd6ykatMJLd/8QBekqPTvRayBULn64fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7RSSD1Kq3bypSDbKmErrbixye0ltFBI1+34Dd+kUvo=;
 b=D/cFk83kNXeO8WiQrhlDVlRK9I8fl1kP37ZIhoF+j3lmLh+2wOSZzCtl5MX/u8Q6j0Ky8LVmm6Fsw7YOin9wiYVD+So/YnmKAw9y579iuiUCi2x0Q1fWagPEyaL66CjEUFOKppuYpXCihJtCQEee+NVPhBnwuE/XojTOy1SU6KcqNs6U8DcJdlzfaDaiCbxqXWlhCOphMVg8IZy3yaUh9j0K+kk0iY2puX9JhV5QIVYFo/H5wd7F7pMluoeDpLUl3qLv/Q57WZGvM/gS78C9jWqr8wEwdvp6hxnXWD2xEirtFDfgj6VezrNx07Byov7A2wQg32WGeW9zZdU8PANvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7RSSD1Kq3bypSDbKmErrbixye0ltFBI1+34Dd+kUvo=;
 b=K26emCiPMFB1GhBJsSRMTAdyWXiKX5jkuc6pfLUrlTokaTy36t+bQvUS3quWpXjPqNfzACnQxIUPHDJvP4slCkPbISzO1Baj9+qWlhQvRXOpbRg368byyDHTFCvUYtOuLxi8g7fXCs9rXe1uEC6baFJF0p2AY/IdElz2h8X2OkKPJbfPL/jiWfE1XtccvjVCwCm0QokX+jIDgwuYQMXpuy7KOB2ybLduv967iihBXFRDg2WGXh6dMKZBmBm43DOp/O2JytiRojQuzdhOStAfbn6buo2UEAPDdsZSJGdD/QCuOttUU6/u2GO2wnMf8LWnhR70ahM13DlxOXqXs5ku+Q==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY0PR06MB5377.apcprd06.prod.outlook.com (2603:1096:400:214::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Mon, 13 Jan
 2025 06:18:43 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 06:18:43 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Ninad Palsule <ninad@linux.ibm.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "eajames@linux.ibm.com"
	<eajames@linux.ibm.com>, "edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNw?=
 =?big5?Q?eed:_system1:_Add_RGMII_support?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIHYyIDA1LzEwXSBBUk06IGR0czogYXNwZWVkOiBz?=
 =?big5?Q?ystem1:_Add_RGMII_support?=
Thread-Index:
 AQHbYX4ZqwUnoFUOykuCVX4SkD1z27MNKUAAgABN4QCAAApFgIAAvO3AgAAxcoCAABHnAIAAB/+AgAEsnXCAAFfBAIAEMh1Q
Date: Mon, 13 Jan 2025 06:18:42 +0000
Message-ID:
 <SEYPR06MB5134D71B324B6A0094ED45419D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References:
 <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
In-Reply-To: <9fbc6f4c-7263-4783-8d41-ac2abe27ba95@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY0PR06MB5377:EE_
x-ms-office365-filtering-correlation-id: b7cbb5ad-5de8-4b6f-48fb-08dd339a211a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?TE8vQ2o4eDdtUTVtRlY4UnlJbzYzN3NDdDhlb1dkbTRsdmRTWExzeExNcjNkajgz?=
 =?big5?B?SC83UTNLZEdCdUZYV0VUOHdtQWpVS2FDTzdCTzJLbG9GQnZVRVZCVVpMR0RHTUFR?=
 =?big5?B?b09WYnBDTmw5WGpiNWxOby93L2N0UzZqUFVTMnU0Y05xQzVzMlp4VTg0Q0Q3eWRk?=
 =?big5?B?RTM5VHczdkt0aU1JWnlnNnpwRmZ6TWNrcElqWnFHQk1LcmE2SmU3Tk02WU9OTXph?=
 =?big5?B?WXlZNjRWN3FmWFZzU1VMa05SRWtUUmtYNkppNGxRMW8rODI3WHlSQndxVzB4dGhZ?=
 =?big5?B?NTB6OWtCN1JYSDlCcEkzcG5XY1dUU05JNWRIMmM3dDh5N1B6cHliOXJ1Mzh1UXZB?=
 =?big5?B?VDZJcmt4cVJwdXpud1ByT3paenNyTlFNaGlFeXlPM2daYXMyZElkejF5b0tQT2xF?=
 =?big5?B?MkxFQjBoenBGTGtLYkhqTzlMYWRRWUo1RlVnREt0b3N2eVh6aFhuS1Q4SGVTOUNL?=
 =?big5?B?WkxQK2cwOXVoZjFwTXgxWDZwMWRqcUpQak8yT2h0Q2VrUERaWWFPYURaRWdCZytQ?=
 =?big5?B?aTJNckdMeFREOU91KzNPdGRDSzJaaVVuQWJvaE85L3FkVDVVbXJSc0FGaWtpREN1?=
 =?big5?B?RTc1V3ZQUDNTL1ovRzdGa1F2YzBmSkVWNHZhWHJjMXUvMUN3UG9rQWlxZHp0Yysx?=
 =?big5?B?OFEraWpBSEpnTEo0ZWg4U0ZlYzNPSXdUelByVkNpaGI2ck1kTVpneDBQRHJuelJH?=
 =?big5?B?Zk5LUDBCYTVNVWVtU3ZjQWdFNDFhZmZqSVU5WDBkcDl2K0p5UXJuZzQrY0gzek8r?=
 =?big5?B?OTRPdnFWT2xuVUVSbGlFYjJSU1YyNW9QdTFpcmRnNEhqQmNzSUUwMHowR0h3MHFP?=
 =?big5?B?bVFRdU00ek9HNnR2T3hKeHlBN21ucnZqRnNIV1A4Zk4vK2lPZmdKVWhOeVhBcHBG?=
 =?big5?B?Vk1HUlFWV1U0YTJ2YjQrR25rY0Qwd1JkN1VWR0lrOHdrd2Q5TXdScmMyalBrMUwy?=
 =?big5?B?eUdUaUc2cDlzWXBZUmJKQ2VwUTNxeTBZd1E0VDFjVG94bHplV1ZBSThoWjJJWmRk?=
 =?big5?B?VTVJTWxkK3RSdnFVeDRvWVpmOUZxcWh5TGczWnFkMmVjR0o5eXduYjV3b1E5Z212?=
 =?big5?B?eDhZN3JFU1BnRVlCRnl6ZnU3TU5qbzg0OWErWFpNU1JYaVlWTHpyVHN5QkZWVHJ1?=
 =?big5?B?VVFkUmV5NC9mcHRCc3Y5QmthbS92ZDdIVDBVNTJhUHM1VjJVWElhSEsxNXlpNG1K?=
 =?big5?B?U2J2bm1FNjJXVmZpY2g0Z2VNQ25HOGUxZzByK2w3MnlSTVNHakNXb25WUU9zcTdI?=
 =?big5?B?UU5vcUhMWDdHZituNTFYeU16QkcxVTFYeFo5d3JZVWtOSmNHR0J2SlVYSldmRjZj?=
 =?big5?B?L1VMdVFwU3JseGFzVW5pK1RSM1FkYmE3QlhSUGdEQ09GNGtBL0tHUEFEVFY0Y2Z3?=
 =?big5?B?SERSY09rNTB4d1phZ3Z1d2NxS002ZFQ1aUdPNFQ5djBhNkcveWhHTEZROUFic3JJ?=
 =?big5?B?YmpZK3YyYVE1MFM3TjBZbE9TSjhjRWx3T3hiRVFGaXhCb214d1diZytRMTlPZC9i?=
 =?big5?B?WG5pQmV1Y0tFREhJMjdaMG5jdVMrVmpvelludmtTTEhvVHVRV3F0UWdXY2JSdW5J?=
 =?big5?B?RDBZWXJJNTkrZHI4TXBTNHpCMEVqai80ZVd6WEJPVjRVYnkreVRYYWZlUVhhSUlP?=
 =?big5?B?VisrQ0kwSkxvd2NKa1A2WkF5Ylhsb1BZZEVkRVk4OGYvQkwvbys4OFU5WkdZZU9j?=
 =?big5?B?UEpWR0tNSnMvaXNqblhIQjIwb1NNckxPc0dsVHRyaGwzSy9kWDE5ZVh0OTYya3BW?=
 =?big5?B?SS9kRHF2RS84R3FwWGVHWWEraHNKanBqY3VlQmhvbmJPZnRZNFpLSkhVa01rckZE?=
 =?big5?Q?jJpf9fNvJt2FYDxVLz5s9lkprtDUf0N/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?ZXl5aDZ6UlVyTmZWWjFuU2xsVFcwdW1rbU9CVmJrME5tNmJJc1c1OGxyMmxvT0lN?=
 =?big5?B?NjJaTnJNY05FblM3WjRNdFBrUlRjNmtyYW80WU55T3R2SmZGUE1vcnBZS0pCaG1U?=
 =?big5?B?THRUb1IzRkFFaUErTmtGbXczcG4rRGpKdzhOZE5TenJ5bnpoL1pvczFDLzVUTllG?=
 =?big5?B?ci9iUlJhZnJIcnBJMy84VU93U3lnMnhsYXcxeGJpaWozUytlRDlyWmgrNVZwSVpw?=
 =?big5?B?ZmgwUkNCRFhkTnN4UHhYcDd5MG9CcS9SN3VFRGNZK1BEWDNiaTRFQU9XemdRV3NL?=
 =?big5?B?SmVRMWh0YUV6QVhvQzcvU0hxV3FXRXhtVWQvVkdGSDJDSStNdHlRd0haR3c4YXZQ?=
 =?big5?B?dmNxdnVEdXd4ZkhGVmVMTWhBc1dCVWZ3UTNtOWFZV084SjdFWkQzT0w2ZFdLL3JO?=
 =?big5?B?NFdEczJOU0k4QVoyb09uTXg0QmpkdjZIL1NMaXNKZFhiMlRwWWROWXdSL2lLSGND?=
 =?big5?B?dXE1NmlnaFJyMzVCV2NiK1F4OXlqTEk1Z09QTG9ldmVWZFdJMENtSUx2NUJoelNZ?=
 =?big5?B?TVRqckswK3REbEpvdTk4ZUpaMWsvMDVJSjlCU050czZQOEl4a0VxUFF3b1ZwRVN4?=
 =?big5?B?bUJ4cUxaODMwVGlYUUE3TytNVXFjR2psdFRIWi9zTmluRWxrM0xxLzhTQ2VURnJ0?=
 =?big5?B?SndJY0pETVByZDFEc1Y1NjFxWi8rZEREeitZTmxBYTlEVFpJVTlzcDRKa2xSbGFW?=
 =?big5?B?WjFjNXFsNmhFQjZwUkJyOUtqWG5PTENTdTFCVld6OFdZc1JnaEpCZ0JmRzFZNjFh?=
 =?big5?B?TjFRVHRFaEIrZjdpbFVYS2N5bXN0ZmVIQTFVWllCQkE1SWpQUUY0TmZUYzZ4aUkw?=
 =?big5?B?OHV5QWhtdGZLT0RLakZpNngzVjhjbStLZzhNeHJFOGpKak15MjVxZFRGQXkyTXlN?=
 =?big5?B?NDQvclVZY1NMeHc1MnJMRXY5NTVFTWVmZ3hxMjByUUxoSzRkZCt2aHIwMC9qZlIy?=
 =?big5?B?cFlQQWVTOENmWWpWRkl4Q1Z6eUZRMzFDL0s3cEErMEZFM0grTnJscVc2dTVOclY1?=
 =?big5?B?VWJIdlR0UDlGNEVkM3JqcEhaVnh4NmhhR1dTMHUwWFk3Yy9MQ2djeThFWEVjcEJN?=
 =?big5?B?OVlaa2dLSmI2Yk5JOHJ4WVRTSU1TblpEYUNEWUlPQUZxRjFSN2JzZHFDYSs0MFAr?=
 =?big5?B?bjdlYjVQcDRjcElwOXQ4a2xjTzByMXJOQTRPdCtNTzVWQW5DSjZGczI3MEFLNEZY?=
 =?big5?B?dGt0SnRzbU5WdGx6NUFLeHF1NUpiTzJheXZHN3p2Uk1sU2wrYUZnZFVvZjUybWVi?=
 =?big5?B?eXJ0MzRMR2h5aXhnYU5ocUwycmo4dElza1U1NTB3K0hEMUpVTnBuYnBkU2Z4S3VY?=
 =?big5?B?aFRRelJIK3ZRaUo5QkxzbW1vQTBMeDAxcElhVXF0SmQ4aG5qQU9YVkFhd0M0MjY0?=
 =?big5?B?MUN2dDlFMTVCU2JWMmpDNVNkTDlQcXh4Z1VNNGI3QTZuSWN1cEdHeituUE5uQkRy?=
 =?big5?B?bEtHQ2lGRGRRZEpYdFZzNWJwekEvRldYSFNMdVpJekFzTVI0YTB2Mk1ub3kxbEpW?=
 =?big5?B?N08yZndDRVpCekI5YjNXUjJSY0IzNGI5YTVsc1AzNmhqNlhIZG9VOStVOXAzMlhG?=
 =?big5?B?anB3WjB3cFlURVZ2Ylg5ZWQ3YWQ1NTZGWDE0cDdEbUVyR2J4R01VdEorRnBRSHVF?=
 =?big5?B?WTY5Z0xPOXQ3RngxTDYvQklpRlkrRGVvRHV6UnFaVUFRNDhPMzV2YVg4QmtzemVZ?=
 =?big5?B?NDVPaHZMNXZRRjFGRENLRUNld1laUGhjY0hHb1IvN3IxVDgyTVVobUtZSFcyRitV?=
 =?big5?B?K1hzb1JISkc0Mm4vSWRFZHRERTFFTlYwaTVDcG1JMjlMYUM0WkZnU3RCRUIxcjdh?=
 =?big5?B?Rk5KTUpKbDRDMTZ4OFBrSTZSMmdJS0g1ckU1Z0E4bUVSZTJyYjRhK2NMMHBjY2pV?=
 =?big5?B?M2hsS2I1S2twaHhWTXd2Njl0VFREVTVBYzFCY3U2cUlCK0FvVmZTQ2Q5OG4yTHov?=
 =?big5?B?TmxWSFpqMHdxbWRpWkc3cVVkQ0oyVzM5SzJOZnBDZkhUS0M3S3ZyNWpZNmNKQmlH?=
 =?big5?Q?p+xtdjcAc/fCJazB?=
Content-Type: text/plain; charset="big5"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cbb5ad-5de8-4b6f-48fb-08dd339a211a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 06:18:42.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrRS+H61o31cuBbaTe7HBjeR0/BjjjSwAyRuuQZCePeBNe87jnQWF4X0XMhpdPlC7HVAc+yl+p28fvlbf8H77Dk6zh9PKFsd7yby1A2EpXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5377

SGkgQW5kcmV3DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IEFncmVlLiBZb3Ug
YXJlIHJpZ2h0LiBUaGlzIHBhcnQgaXMgdXNlZCB0byBjcmVhdGUgYSBnYXRlZCBjbG9jay4NCj4g
PiBXZSB3aWxsIGNvbmZpZ3VyZSB0aGVzZSBSR01JSSBkZWxheSBpbiBib290bG9hZGVyIGxpa2Ug
VS1ib290Lg0KPiA+IFRoZXJlZm9yZSwgaGVyZSBkb2VzIG5vdCBjb25maWd1cmUgZGVsYXkgYWdh
aW4uDQo+IA0KPiA+IEJlY2F1c2UgQVNUMjYwMCBNQUMxLzIgUkdNSUkgZGVsYXkgc2V0dGluZyBp
biBzY3UgcmVnaW9uIGlzIGNvbWJpbmVkDQo+ID4gdG8gb25lIDMyLWJpdCByZWdpc3RlciwNCj4g
PiBNQUMzLzQgaXMgYWxzby4gSSB3aWxsIGFsc28gdXNlICdhbGlhc2UnIHRvIGdldCBNQUMgaW5k
ZXggdG8gc2V0IGRlbGF5IGluIHNjdS4NCj4gPg0KPiA+IC8vIGFzcGVlZC1nNi5kdHNpDQo+ID4g
YWxpYXNlcyB7DQo+ID4gCQkuLi4uLi4uLi4uDQo+ID4gCQltYWMwID0gJm1hYzA7DQo+ID4gCQlt
YWMxID0gJm1hYzE7DQo+ID4gCQltYWMyID0gJm1hYzI7DQo+ID4gCQltYWM0ID0gJm1hYzM7DQo+
ID4gCX07DQo+IA0KPiBJIHdvdWxkIGF2b2lkIHRoYXQsIGJlY2F1c2UgdGhleSBhcmUgdW5kZXIg
Y29udHJvbCBvZiB0aGUgRFQgZGV2ZWxvcGVyLiBZb3UNCj4gc29tZXRpbWVzIHNlZW4gdGhlIG9y
ZGVyIGNoYW5nZWQgaW4gdGhlIGhvcGUgb2YgY2hhbmdpbmcgdGhlIGludGVyZmFjZQ0KPiBuYW1l
cywgcmF0aGVyIHRoYW4gdXNlIGEgdWRldiBzY3JpcHQsIG9yIHN5c3RlbWQgbmFtaW5nIHNjaGVt
ZS4NCj4gDQo+IFRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIGVhY2ggaW50ZXJmYWNlIGlzIHdlbGwg
a25vd24gYW5kIGZpeGVkPyBBcmUgdGhleSB0aGUNCj4gc2FtZSBmb3IgYWxsIEFTVHh4eHggZGV2
aWNlcz8gSSB3b3VsZCBoYXJkIGNvZGUgdGhlbSBpbnRvIHRoZSBkcml2ZXIgdG8NCj4gaWRlbnRp
ZnkgdGhlIGluc3RhbmNlLg0KDQpUaGUgcGh5c2ljYWwgYWRkcmVzcyBvZiBlYWNoIGludGVyZmFj
ZSBpcyBhbGwgZGlmZmVyZW50IGluIGFsbCBhc3BlZWQgZGV2aWNlLg0KQW5kIHRoZXkgYXJlIGZp
eGVkIGFuZCBrbm93bi4gSSBjYW4gdXNlIHRoZSBhZGRyZXNzIHRvIGRpc3Rpbmd1aXNoIHRoZSBp
bnRlcmZhY2UuDQoNCj4gDQo+IEJ1dCBmaXJzdCB3ZSBuZWVkIHRvIGZpeCB3aGF0IGlzIGJyb2tl
biB3aXRoIHRoZSBleGlzdGluZyBEVCBwaHktbW9kZXMgZXRjLg0KPiANCj4gV2hhdCBpcyB0aGUg
cmVzZXQgZGVmYXVsdCBvZiB0aGVzZSBTQ1UgcmVnaXN0ZXJzPyAwPyBTbyB3ZSBjYW4gdGVsbCBp
ZiB0aGUNCj4gYm9vdGxvYWRlciBoYXMgbW9kaWZpZWQgaXQgYW5kIGluc2VydGVkIGEgZGVsYXk/
DQo+IA0KPiBXaGF0IGkgdGhpbmsgeW91IG5lZWQgdG8gZG8gaXMgZHVyaW5nIHByb2JlIG9mIHRo
ZSBNQUMgZHJpdmVyLCBjb21wYXJlDQo+IHBoeS1tb2RlIGFuZCBob3cgdGhlIGRlbGF5cyBhcmUg
Y29uZmlndXJlZCBpbiBoYXJkd2FyZS4gSWYgdGhlIGRlbGF5cyBpbg0KPiBoYXJkd2FyZSBhcmUg
MCwgYXNzdW1lIHBoeS1tb2RlIGlzIGNvcnJlY3QgYW5kIHVzZSBpdC4gSWYgdGhlIGRlbGF5cyBh
cmUgbm90IDAsDQo+IGNvbXBhcmUgdGhlbSB3aXRoIHBoeS1tb2RlLiBJZiB0aGUgZGVsYXlzIGFu
ZCBwaHktbW9kZSBhZ3JlZSwgdXNlIHRoZW0uIElmDQo+IHRoZXkgZGlzYWdyZWUsIGFzc3VtZSBw
aHktbW9kZSBpcyB3cm9uZywgaXNzdWUgYSBkZXZfd2FybigpIHRoYXQgdGhlIERUIGJsb2INCj4g
aXMgb3V0IG9mIGRhdGUsIGFuZCBtb2RpZnkgcGh5LW1vZGUgdG8gbWF0Y2ggdGhlIGRlbGF5cyBp
biB0aGUgaGFyZHdhcmUsDQo+IGluY2x1ZGluZyBhIGdvb2QgZXhwbGFuYXRpb24gb2Ygd2hhdCBp
cyBnb2luZyBvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8NCj4gaGVscCB0aG9zZSB3aXRoIG91
dCBvZiB0cmVlIERUIGZpbGVzLiBBbmQgdGhlbiBwYXRjaCBhbGwgdGhlIGluIHRyZWUgRFQgZmls
ZXMgdG8NCj4gdXNlIHRoZSBjb3JyZWN0IHBoeS1tb2RlLg0KDQpBZ3JlZS4gSSB0aGluayB0aGlz
IG1ldGhvZCBpcyBnb29kLiBUaGUgUkdNSUkgZGVsYXkgcmVzZXQgdmFsdWUgaW4gU0NVIGlzIHpl
cm8uDQpJIGNhbiB1c2UgdGhlIHJlc2V0IHZhbHVlIHRvIGtub3cgaWYgdGhlIFJHTUlJIGRlbGF5
IGlzIGNvbmZpZ3VyZWQuDQpJZiB0aGUgdmFsdWVzIGFyZSBub3QgbWF0Y2ggdGhlIHBoeS1tb2Rl
LCBwcmludCB3YXJuaW5nIG1lc3NhZ2UgYW5kIGFwcGx5IHRoZSANClJHTUlJIGRlbGF5IHByb3Bl
cnR5IGlmIHRoZXJlIGlzIGluIE1BQyBub2RlIG9mIGR0cy4NCg0KPiANCj4gUGxlYXNlIGRvdWJs
ZSBjaGVjayBteSBsb2dpYywganVzdCB0byBtYWtlIHN1cmUgaXQgaXMgY29ycmVjdC4gSWYgaSBo
YXZlIGl0IGNvcnJlY3QsDQo+IGl0IHNob3VsZCBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZS4gVGhl
IG9uZSBmZWF0dXJlIHlvdSBsb29zZSBvdXQgb24gaXMgd2hlbg0KPiB0aGUgYm9vdGxvYWRlciBz
ZXRzIHRoZSB3cm9uZyBkZWxheXMgYW5kIHlvdSB3YW50IHBoeS1tb2RlIHRvIGFjdHVhbGx5DQo+
IG92ZXJyaWRlIGl0Lg0KPiANCj4gV2hlbiBBU1QyNzAwIGNvbWVzIGFsb25nLCB5b3UgY2FuIHNr
aXAgYWxsIHRoaXMsIGdldCBpdCByaWdodCBmcm9tIHRoZSBzdGFydA0KPiBhbmQgbm90IG5lZWQg
dGhpcyB3b3JrYXJvdW5kLg0KDQpUaGFua3MgZm9yIHlvdXIgZnJpZW5kbHkgcmVtaW5kZXIuDQoN
ClRoYW5rcywNCkphY2t5DQo=

