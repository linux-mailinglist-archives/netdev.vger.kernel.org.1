Return-Path: <netdev+bounces-276034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN8MBlEf1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 723423B0BF2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BD930131E5
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724135F5FE;
	Tue,  7 Apr 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ez8Nj6CT"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7335F18F;
	Tue,  7 Apr 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574474; cv=fail; b=FM2TRj/aA6PNFEVGO+uqSB6HHzP7wU318oHZRlq5zbrRdkNqLZ64ewX0cUwRgzjyiupEpgqiojpae8l5yspNSJK/HN1JouAUojkLUVZsAxY5nSRJsZeyMtMigh7QGgQ75iUqDq7VdXv6oAZzCsIoQYH+ogBcUDbG7urit5eMlgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574474; c=relaxed/simple;
	bh=v3ZP7CrG1ne8ZBXLKtzKUcPuYLYyRs4FoAbwN6s7sFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKXMQLZl4j7FJFdPaTWdrkhmZ1Cl4dvynahUJEdynXTo4IjUaNP3JakSROi4nckdTEKcxNvJY8ku4gJP7YX3A7qZZKJmm8/oJuw9rojJHWxK0XHU76DbTR6krdVkqX0/JRLMnuvpUlvSeYN1CdoLka9gy72ddwS/1rxqY/eYxiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ez8Nj6CT; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQo25bN63d5f6RFWW5rXqLVT7pNZNXGqRxk9LPGgAEYfOA4NLMTfbVfmvPTy1c9LoanNP2Agq4he0iDr5pc2+WmD5CGI1MAjfIpTTvDQ4HKvrjZZyEfzxX1x//XWE+Cl3Qm8X9a2OsWpMpg6Kw0keZmIC3qu2N+IpY2mjdE/1IZFGD9AOMfHnOGnNwhRokhCLcaT5oqKbnaoZl8ayaUQ8CJtwHEoHYZneeDKY04NIFi1AFtL3O4919fhVl8I6rNN+xUVgjmndfyQNSvV+CrWqwrxWnAcGFn2zOFWH0k+kP/ZIdIErCJZ5H7kLqz3fbrd1MZV5tX58ab7Jvzo+D2kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3ZP7CrG1ne8ZBXLKtzKUcPuYLYyRs4FoAbwN6s7sFY=;
 b=KwYNx35QRHszJC6tJu42Ln8axnD9d8UYQMIyd7aGfb2x41ipFMve2b7HnXnE2vMWKu+rb8mkjaTZvbI6q1v1WUcdvudpzsSZ+wMNv1rIPiQNamstfrue8xSJO6QROZd7DjdRO45/LaLUJHlJYHGRNsDqwxC5j3nB24xJgfWiSkC83YqAMIYxFStWxcBhN9RFFZi7DRn0Ki5otBNMUBvnZWL1WcybnzMxWkRAflaVdlTRk59Itwup5p3f0EobvKu5I7y4+a5B/AgMaXfTEwhMTbLPl9O/ys14bjUuf338XlQHQBtnSipViLOIMV1ZyQuwGXxX5dKWhIglcBlOH6Soxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3ZP7CrG1ne8ZBXLKtzKUcPuYLYyRs4FoAbwN6s7sFY=;
 b=Ez8Nj6CTXybeHbMZxXystp4NucJxG47L5k+r6Vg8zM5B5Kq25NEKQr+Ng2QwdY835vSiqizZ3Qw/NpPS0c8Z+qW4OiJtx/VaRbhmBZXkqX56ELneba4DujjzBzYykGi1Mj9Iaow8ESgHEnVLPWJLdYXq6d9V7l+oIwHxITfuwvelMeXelv9QB91DERNnQaHnKowR58qEKcOOOuHmstWsMD/bSPXvd8uMAXjnasC3A81hoffz/P/GPncfTARUUuQCJnLtaUli6tT1sBEFyR3o/3LTLkUr7oWEcWWSCi11sG10pCtHmw9Kp6BQubksQmx4lXY4yWD3jsUUGtffgC6fOg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH7PR12MB6884.namprd12.prod.outlook.com
 (2603:10b6:510:1ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 15:07:48 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%4]) with mapi id 15.20.9745.035; Tue, 7 Apr 2026
 15:07:48 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Thread-Index: AQHcwEV8JCUz5mbuoUiqCSPj+c8ZLrXL3u8AgAfhGgA=
Date: Tue, 7 Apr 2026 15:07:47 +0000
Message-ID: <e2eefeb7033caa859551834d3448a77b7af3c7d4.camel@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
	 <20260330130130.989236-5-cratiu@nvidia.com> <ac6BsG4IhAajip1s@krikkit>
In-Reply-To: <ac6BsG4IhAajip1s@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH7PR12MB6884:EE_
x-ms-office365-filtering-correlation-id: 510c68c3-415d-4ed5-c37f-08de94b76e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UtxNsJ/7zD6idtGfroWaVhIJEpBCnE1IYYAXwDtkMZOJ4FZJlXvBGid8YjwQ1Zml1qhXRnkqhpzipuVtcEedkmXZPGcI2z22AhUwK9rG3BTGSIZIhsryjBDgWXxdBAjBtjTPrTwunT4uRCWuPc8mxeoA1rrKl5n7kAlG+bxiW79b5j6tJV/Vmar8NIodzuxkkLZslFRpDaSY4XcdSd/ag+HYB3vbUL7ldhntmzKwzwbtlMn8LC75oIQHz/xu5+HwJ5uJDE8u4UHGWtPWUpQ+XNOGtP89yFAXjajQa1z//gUxZMFXL4KNFxrF/1YfCdGy+XhuqIBJ83rtLDEEEjP+G/VJPrsXm2pyAX/SRwpJ+GvaaKBhrq/D/hRlN0XT1XzZPqe+SpD+xMfRBX+nLQa0iZkTJVwQNDQhVijdsQXM6LgP66mjtcvl+GOLaqi1DWtJ1sdMkR+DrskNVe3z4uQlxKCJ50+AJNrSN6qKCUwrC9bhvivzLpfg7XUxY7jzUF8xKPj1i2mBtszOz336T985bsdmcfnCTBOo+N4Ty/RUUf+lRTf4aECc7j+V/PkegmGSoZnbDDSzJbnTIC8l1gAjP5Fo0PqleSwktjkHS9Zy1ergSDwTBRAwXtG8D6RiFTXuyEjK89u8cVpX/lIUFb4Hpyf2s6ZXaucKAN5TGUTJ3GzjIdGHjsu1oJ5JWppwRmwxaBF/ztUGd1CfPRWNfeQl4Vml8V5zgEfb/AFluofeJWfAh90exp7msP6aOQy6Q1XuqM0wPLTag2stFRAFrmnZY9RxK7iiwpkYsai6r6vG6Rc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alJPd3hDZEl2VVNTNHZsMXVkZUpQQVhVdHhwOXlqcFZPVlJkbi81Nm9QbCtv?=
 =?utf-8?B?TmYyOVh6b2ZzSmpDZGQyVlczNTNSQ1Zlcjl3TExjb2kwQml4dlpuUkQ0Rlpv?=
 =?utf-8?B?RUNRMVMvc1JPbkpuaThqemtYTGFjYndZcEREbGlYZ0M0czRVS0dGeURGRmpZ?=
 =?utf-8?B?NUsyWjFoQjVGZU1VdFp5UGcxd1pLd2NiM05jTVMyZHAxUkMzK2F1ZkUvOVdI?=
 =?utf-8?B?SWhrMDdnSGdDTGlVeVRYeWJZbHllZkZwNWFmNVdQNUVwVTFGTVpEdmFVUVg3?=
 =?utf-8?B?TUplTTEwRitYaVYwTEZxYTZ5YWplaWtqeitnUGsyQTFNeWlLbm1QSDd4ZlJo?=
 =?utf-8?B?WUhFUjhXZ3dLZWUvQ0FwdGtJMDNoQ25jSHVvMW9Ld2JCeE56bW9hS25PUVhW?=
 =?utf-8?B?T0l4SUJHbWNueE4xYXdyRkJuQnhCWjNOUVpKSVBLLzlNUnBzSTJUTG51UG1x?=
 =?utf-8?B?ZmtmdTEyanJ3UkZ4am12UzNTaEpZV3p0RGJvZEpXTUd1WUdJZHdMWDFtaHIx?=
 =?utf-8?B?VTViWXlPSDh4enBUbUVmM2RLUEE3dGFZVUx0SHpyMGtGT0FLNGVON2pOWTd6?=
 =?utf-8?B?Zm11eGNkb1lTOXBabjM1TWlFVDRXSmxyNUFnS21qODJ4dGxiTFZHRnIram5m?=
 =?utf-8?B?czNYQnVhYzdwL1pwSzRrdWl6T21SaG8vdGhaR3Q0VnJGbzQxVWpjZ29CdnRZ?=
 =?utf-8?B?ZXlidi94ZFR6enJPK2w1ZDFpeTk2VnNXYkxQYjlSSGVaTm9Yd0liS3ZmMlFW?=
 =?utf-8?B?cGMya3FNQXFnQjhHSlc0SUt2MHRvNVZFd3lwNTNxT3J3RDZRZVFSQUpDR25V?=
 =?utf-8?B?VVRHeUYwamlUUHhKUmVSVkVxSnR6dVVFc2xsalFhdVFvUXkySGp1YnlTOEhq?=
 =?utf-8?B?cGttem9wQ0tKQkNiNk94YnJsTGt2UjVTOWVpVmllbmkrNERwVUxFTDRWZWZZ?=
 =?utf-8?B?SjB1UG9XdUJkWUEvcUFURnV2RkpPeWgzNHlrMTR0aHRTY1JMMXF2Zzl0K2Fw?=
 =?utf-8?B?UEV6Z255d3lrZDRyZkhtSytCcmRveEMzdlVGWkVhZjBpYzF0M2VyUXVROERJ?=
 =?utf-8?B?OFFPQSt6YVJ6bk1LaHJ0a3F2Qm1oaGFVaVppNTlsZWRHclpmalZXVXNuSlJo?=
 =?utf-8?B?UDFJUFQveDF0dXk1cmF1WTZpZUJUQXdzcDdwQmgzME4rYlRWT0RIT0o0c2FS?=
 =?utf-8?B?aS94RjFUTHpJVUJXei80VnZsNnV0YmZZVTZyVlhxWGJEUjd3Y1hRdTNRNFp4?=
 =?utf-8?B?NkNpMEJwdHhFVDZsYzVFcDBTMDZKTFFoYzVVdkxpMTFMUzBlcEZ5cS9qbm9i?=
 =?utf-8?B?ZTJGK1lNR0h3WG5jYXB4SlI5cS9HcmhiRFJmTkhxVWl3L3lkZFJLeFhaNTc2?=
 =?utf-8?B?dHhFNW1keENYOEhUZzRMZGNWV3drWjRtQmtPN3FtZjlnZnBETEVsdUU1ZGlG?=
 =?utf-8?B?UTZZdUxUdERQYklScEl3bGhBS2JuaytzSWl6NGRRRjIyUTZhd25kRlY3eEYz?=
 =?utf-8?B?eHZ5cXUzaFIrWnVlWDhlWmprcFVHZHRGZ1BQKzF4UEpOZW5vR1lzSzZhSFZP?=
 =?utf-8?B?b1N6RzArM0tEL2UrdCtaY2FsOGw2VmZSVjhqUVZGczBKMllrY1RZdmtKdEgr?=
 =?utf-8?B?ODVLQUp0M0ZsWlBsOGNRT2tXelhMaU9adDlTbVUybWJ3WVZEa2sxTGswYXM0?=
 =?utf-8?B?UlMxV0NEendTOUJlRzZtMkl3UVpzbmxNdkt5emZaZjJmbG1meWpBcm9WRkJp?=
 =?utf-8?B?V0lwandZZ3Axa3ZKby91WG5ZZjRIeEpzek9Uc05uMEYxdXZjektLS3h3SEwv?=
 =?utf-8?B?by9ZSEJJN2tjQUdmTzVOT2QyWUx4dVJ0WTBva29pYjZhN3FNZDhVYkpxcFVC?=
 =?utf-8?B?MHNZaStHcUUzSTJCRjNPN3RreXByM01hMUc4WXh4QjJucGJRekhaU2hlZ0pk?=
 =?utf-8?B?MVJvQk8yWEJSSW96ZkxpbEtGZ3JXNm1oSmR6ZjVFc2R2bUFmMnZ3MnJ4ME1N?=
 =?utf-8?B?M0trNDBYUVRSVWpJcWlUOUpxT3pVWTRsTHA4RnUrdjh2K0lPRmxqd1dRTjIy?=
 =?utf-8?B?MlhQekE4RU43T3M0Q1BWTHhueUc5L2M4b0hDak1oc1ZKd0lTMWpKdDZNR1Nh?=
 =?utf-8?B?MWExdU8xYTVDeTdFTSt1Q2o2VFYwazFkM1pEb0lQVXZJb1hhT2lPRExBL0xt?=
 =?utf-8?B?eU9vTEF6aGxyOEN6dkNjOXByZGZoM21xay9mUjJyeU5uSW5XTDBGanlrRGgr?=
 =?utf-8?B?MnQraUVBOTZCcThTQ3MzVW5kNThWc2N2WHlFa2lCczR6bkJTTytrOEhKbHZV?=
 =?utf-8?B?SHpOK1JxYnN2T2xJNWdQWGgwZGFPbTFMZE9pSUU3ODdtZnpzV2FrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51CFFF5EFA60E24BBAAF440560F100A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510c68c3-415d-4ed5-c37f-08de94b76e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 15:07:48.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzBwAnZvIdTUr7qXOT2tL3mHdJC4P71a/vKM3sk7BCXaQk5Gub19oJ/0fTEWvduslyRr9aCBUawGgaJm268IUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 723423B0BF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE2OjQ4ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMzAsIDE2OjAxOjMwICswMzAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
QEAgLTI2MTYsMTQgKzI2MTYsMjIgQEAgc3RhdGljIGludCBtYWNzZWNfdXBkYXRlX29mZmxvYWQo
c3RydWN0DQo+ID4gbmV0X2RldmljZSAqZGV2LCBlbnVtIG1hY3NlY19vZmZsb2FkIG9mZg0KPiA+
IMKgCWlmICghb3BzKQ0KPiA+IMKgCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gwqANCj4gPiAt
CW1hY3NlYy0+b2ZmbG9hZCA9IG9mZmxvYWQ7DQo+ID4gLQ0KPiA+IMKgCWN0eC5zZWN5ID0gJm1h
Y3NlYy0+c2VjeTsNCj4gPiDCoAlyZXQgPSBvZmZsb2FkID09IE1BQ1NFQ19PRkZMT0FEX09GRiA/
IG1hY3NlY19vZmZsb2FkKG9wcy0NCj4gPiA+bWRvX2RlbF9zZWN5LCAmY3R4KQ0KPiA+IMKgCQkJ
CQnCoMKgwqAgOiBtYWNzZWNfb2ZmbG9hZChvcHMtDQo+ID4gPm1kb19hZGRfc2VjeSwgJmN0eCk7
DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJbWFjc2VjLT5vZmZsb2FkID0gcHJldl9vZmZsb2Fk
Ow0KPiA+ICsJaWYgKHJldCkNCj4gPiDCoAkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkvKiBS
ZW1vdmUgVkxBTiBmaWx0ZXJzIHdoZW4gZGlzYWJsaW5nIG9mZmxvYWQuICovDQo+ID4gKwlpZiAo
b2ZmbG9hZCA9PSBNQUNTRUNfT0ZGTE9BRF9PRkYpIHsNCj4gPiArCQl2bGFuX2Ryb3BfcnhfY3Rh
Z19maWx0ZXJfaW5mbyhkZXYpOw0KPiA+ICsJCXZsYW5fZHJvcF9yeF9zdGFnX2ZpbHRlcl9pbmZv
KGRldik7DQo+ID4gKwl9DQo+ID4gKwltYWNzZWMtPm9mZmxvYWQgPSBvZmZsb2FkOw0KPiA+ICsJ
LyogQWRkIFZMQU4gZmlsdGVycyB3aGVuIGVuYWJsaW5nIG9mZmxvYWQuICovDQo+ID4gKwlpZiAo
cHJldl9vZmZsb2FkID09IE1BQ1NFQ19PRkZMT0FEX09GRikgew0KPiA+ICsJCXZsYW5fZ2V0X3J4
X2N0YWdfZmlsdGVyX2luZm8oZGV2KTsNCj4gPiArCQl2bGFuX2dldF9yeF9zdGFnX2ZpbHRlcl9p
bmZvKGRldik7DQo+IA0KPiBQYW9sbyBwb2ludGVkIG1lIHRvIHRoZSBzYXNoaWtvIHJldmlldyBm
b3IgdGhpcyBwYXRjaA0KPiBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjAzMzAx
MzAxMzAuOTg5MjM2LTEtY3JhdGl1JTQwbnZpZGlhLmNvbQ0KDQpJIHNob3VsZCBtYWtlIGl0IGEg
aGFiaXQgdG8gZ28gYW5kIGxvb2sgdXAgdGhlc2UgcmVwb3J0cyBteXNlbGYuDQoNCj4gDQo+IEEg
c2ltcGxlIHdheSB0byB0cmlnZ2VyIHRoaXMgaXMgdG8gZG8gcy9WTEFOX05fVklELzUwMC8gaW4N
Cj4gbnNpbV92bGFuX3J4XypfdmlkLg0KPiANCj4gRm9yIGV4YW1wbGU6DQo+IA0KPiBlY2hvIDEg
PiAvc3lzL2J1cy9uZXRkZXZzaW0vbmV3X2RldmljZQ0KPiBpcCBsaW5rIGFkZCBsaW5rIGVuaTFu
cDEgbWFjc2VjMCB0eXBlIG1hY3NlYw0KPiBpcCBsaW5rIGFkZCBsaW5rIG1hY3NlYzAgbWFjc2Vj
MC4xIHR5cGUgdmxhbiBpZCAxDQo+IGlwIGxpbmsgYWRkIGxpbmsgbWFjc2VjMCBtYWNzZWMwLjEw
MDAgdHlwZSB2bGFuIGlkIDEwMDANCj4gaXAgbGluayBzZXQgbWFjc2VjMCB0eXBlIG1hY3NlYyBv
ZmZsb2FkIG1hYw0KPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbmV0ZGV2c2ltL25ldGRldnNpbTEv
cG9ydHMvMC92bGFuwqDCoMKgwqDCoCAjIGVtcHR5DQo+IA0KPiANCj4gSWYgdGhpcyBoYXBwZW5z
IG9uIGEgcmVhbCBkZXZpY2UsIHRoZSBWTEFOIGZpbHRlcnMgd2lsbCBiZSBicm9rZW4uDQo+IEkn
bQ0KPiBub3Qgc3VyZSB3aGF0IHRoZSByaWdodCBiZWhhdmlvciB3b3VsZCBiZToNCj4gDQo+IDEu
IHJlamVjdCB0aGUgcmVxdWVzdCB0byBlbmFibGUgb2ZmbG9hZA0KPiAyLiBzd2l0Y2ggdG8gcHJv
bWlzY3VvdXMgbW9kZQ0KDQpJIGltcGxlbWVudGVkIGFuZCB0ZXN0ZWQgb3B0aW9uIDEuIEluIHRo
ZSB1bmxpa2VseSBzY2VuYXJpbyBhZGRpbmcgVkxBTg0KZmlsdGVycyBwcmV2ZW50cyBvZmZsb2Fk
aW5nLCBpdCdzIGJldHRlciBmb3IgdGhlIGRyaXZlciB0byBiZSBleHBsaWNpdA0KYW5kIGxldCB0
aGUgdXNlciB0dXJuIG9uIHByb21pc2MgbW9kZSB0aGVtc2VsdmVzLiBLZWVwaW5nIHRyYWNrIG9m
DQp3aGV0aGVyIFZMQU4gZmlsdGVycyBmYWlsZWQgYW5kIHByb21pc2Mgd2FzIHVzZWQgYXMgYSBm
YWxsYmFjayBhZGRzDQpzb21lIGV4dHJhIGNvbXBsZXhpdHkuIFBsdXMsIEkgYW0gbm90IHN1cmUg
aXQgaXMgdGhlIHJpZ2h0IHBsYWNlIGZvcg0KdGhpcyBkZWNpc2lvbi4gV2hhdCB3b3VsZCBiZSB0
aGUgcG9pbnQgb2YgSUZGX1VOSUNBU1RfRkxUIHRoZW4/DQoNClBsZWFzZSBsZXQgbWUga25vdyBp
ZiB5b3UgYWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLCBzbyBJIGNhbiBzZW5kIHY4DQp3aXRoIGl0
Lg0KDQo+IE9UT0ggbWF5YmUgd2UgZG9uJ3QgbmVlZCB0byBjYXJlLCBzaW5jZSBfX25ldGRldl91
cGRhdGVfZmVhdHVyZXMgYWxzbw0KPiAoa2luZCBvZikgaWdub3JlcyB0aG9zZSBlcnJvcnM6DQo+
IA0KPiBlY2hvIDEgPiAvc3lzL2J1cy9uZXRkZXZzaW0vbmV3X2RldmljZQ0KPiBldGh0b29sIC1L
IGVuaTFucDEgcngtdmxhbi1maWx0ZXIgb2ZmDQo+IGlwIGxpbmsgYWRkIGxpbmsgZW5pMW5wMSBl
bmkxbnAxLjEgdHlwZSB2bGFuIGlkIDENCj4gaXAgbGluayBhZGQgbGluayBlbmkxbnAxIGVuaTFu
cDEuMTAwMCB0eXBlIHZsYW4gaWQgMTAwMA0KPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvbmV0ZGV2
c2ltL25ldGRldnNpbTEvcG9ydHMvMC92bGFuwqDCoMKgwqDCoCAjIGVtcHR5DQo+IGFzIGV4cGVj
dGVkDQo+IGV0aHRvb2wgLUsgZW5pMW5wMSByeC12bGFuLWZpbHRlciBvbsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjDQo+IHN1Y2NlZWRzDQo+IGV0aHRv
b2wgLWsgZW5pMW5wMSB8IGdyZXAgcngtdmxhbi1maWx0ZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICMgInJ4LQ0KPiB2bGFuLWZpbHRlcjogb24iDQo+IGNhdCAvc3lz
L2tlcm5lbC9kZWJ1Zy9uZXRkZXZzaW0vbmV0ZGV2c2ltMS9wb3J0cy8wL3ZsYW7CoMKgwqDCoMKg
ICMgc3RpbGwNCj4gZW1wdHkgYmVjYXVzZSBpZD0xMDAwIHdhcyByZWplY3RlZA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IyBhbmQNCj4gZXZlcnl0aGluZyBnb3Qgcm9sbGVkIGJhY2sNCj4gaXAgbGluayBhZGQgbGluayBl
bmkxbnAxIGVuaTFucDEuMTIzIHR5cGUgdmxhbiBpZCAxMjPCoMKgwqDCoMKgwqDCoCAjDQo+IHN1
Y2NlZWRzDQo+IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9uZXRkZXZzaW0vbmV0ZGV2c2ltMS9wb3J0
cy8wL3ZsYW7CoMKgwqDCoMKgICMgb25seQ0KPiAiY3RhZyAxMjMiDQo+IA0KPiANCj4gW2F0IHRo
aXMgcG9pbnQgcnVubmluZw0KPiDCoMKgwqAgaXAgbGluayBkZWwgZW5pMW5wMS4xDQo+IG9yDQo+
IMKgwqDCoCBldGh0b29sIC1LIGVuaTFucDEgcngtdmxhbi1maWx0ZXIgb2ZmDQo+IHdpbGwgc3Bs
YXQgYmVjYXVzZSB2bGFuX2ZpbHRlcl9wdXNoX3ZpZHMgZGlkIGEgcm9sbGJhY2svbmV2ZXIgYWRk
ZWQNCj4gaWQ9MSwgYW5kIG5vdyB3ZSBjYWxsIHZsYW5fa2lsbF9yeF9maWx0ZXJfaW5mbywgYnV0
IHRoYXQncyBzcGVjaWZpYw0KPiB0bw0KPiB0aGlzIHZpZCBsaW1pdF0NCj4gDQoNCldlbGwsIGlu
IHRoaXMgY2FzZSB3ZSBoYXZlIHRoZSBjaGFuY2UgdG8gZG8gc29tZXRoaW5nIG5pY2VyIChldmVu
DQpwcm9wZXIgZXJyb3IgbWVzc2FnZSBiYWNrIHRvIHRoZSB1c2VyIHZpYSBleHRhY2spIGZvciBh
IHNtYWxsDQpjb21wbGV4aXR5IGNvc3QuIFBlcmhhcHMgdGhlIFZMQU4gZmlsdGVyIGhhbmRsaW5n
IGNvdWxkIGJlIGltcHJvdmVkDQpzZXBhcmF0ZWx5Lg0KDQpDb3NtaW4uDQo=

