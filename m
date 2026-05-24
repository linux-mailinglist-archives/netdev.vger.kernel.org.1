Return-Path: <netdev+bounces-291159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFilKRS/Emqa3QYAu9opvQ
	(envelope-from <netdev+bounces-291159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 11:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5C5C1C3F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 11:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85F73009CD3
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF335B632;
	Sun, 24 May 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGSCW82T"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C627280A
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779613458; cv=fail; b=ECaYtb7NY07moBgFiwDaV7Bs2WjnrEog63NXv9kHXQzyVnpLCcsfkObjfy2SbJa8h/O2LZ0eG7jCujNhfEpocs1JSAKgSloUrTRBd5XlF05ayDZ8BgXf2x+mJAj/NJO17dvfjUZx7brfsE9o5fsICl4aomKb3Gsxq1k2+9pQSbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779613458; c=relaxed/simple;
	bh=J2jjZcL1F40YbpoVh+62lR7ilookNC12ZHLQFdiSWRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGnn0b/LU71xOAOngeolVOPKlq/UHOxOY1bmE2cgT/N7p4QLQngflsHst0Qlu5rxNSMV4JGZhpWAtw59rYs2uM9ytBXIWoKE2dXOJVoKahpMfjjXZUGNZST9rQSAc87Yf0iRTNkoxzuO0KQJTI2kMKRN6VIY7nhxXAyXcFLv3rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGSCW82T; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b08LozyNxZ9rLeEPqikSg4FtGLxK/yLOzv4y5LPl847xWRtj9Sg+VhQG7YGIJkGj1/JtUFqbCDdQZrtRDqV+PWERARY/kH0vwEaasTNLTf6Qflj0ao8lhImt2jJeZ3JhFO9CKrmArZPZbQMRIc5tSRh1VtStS7vvofTMFZi1SKTm00mBt4zeGcA2C3lB1rqanlUjQTqbBQSc00u6e/uPvrR/BZs7GfNJ4ILoGCLkW5MXmzZxWFtpftFofnbSxrXcdvpquH1V6pFQqjVILU007RHbvWGUo+9/NqnwH8lXhM64+MhbAqgbQHt46rqvIkJegYCBkT5ktXFqcvGgR3X5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2jjZcL1F40YbpoVh+62lR7ilookNC12ZHLQFdiSWRU=;
 b=DZ22okSSj9R1ObnExXX59FDfBGdqZQeLchdGJDk/LiEQ3KesHI04Ehr0h/UCFfpEL+IkGXOwlLsU1sPOqYqR2vYjUo/e4cBMYaPqPGonn5LpuUsCOCgTeTdNjIVYUEui3sbYj6RZ4uuXUeOqdnIwtN1BAqW6WA2SbuVl8JfjVRqnXRgVHTXY5HdwOrMDG17zbk6JlwJeU/qfFZRasQ5azcgk+ai/JBSRVkz5Z8cyaX9w+fRudHisksZJO7tqMmqMtLiNXaPIZVVaKIraM7kjlQc8qNuHnoqjFrcl3rcDc+a/LNo2fQqQ6eENQF4Zrkwl0nDHxaBzOhKu6Qwx38ZEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2jjZcL1F40YbpoVh+62lR7ilookNC12ZHLQFdiSWRU=;
 b=ZGSCW82TvRhfy9/AFZnTwTy3QF6RY/IWmNo7liOEmzPUh4l3Z9aIAFgjscj1JXk4RDOyYyR5Yta+hmd9eKY7/tSkMsZi4iA6q6Y1tYpu+QpWg5NL6/Xa8Gu8Y3ZviwRmw0tlX7lhtTkKy0Y+7WbruXKqOmR4ch+h/mQugCZln0hmCQRe5TiYhFjM6uwZijNKXoLYIKceeiaGfpgewCDfr+OwlY9lANqDWGQYpIGlmSlO5dg1EiFIwT/XVnBEwniTuONTprKGbecX3cLo1C6GIzeyaYkBsPIKsVah2PhvCK2Rl79jJxAkH2tFP0AnNFEg5Vle/h9YmYlQiLxMXkAsXg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 09:04:13 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 09:04:12 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "kees@kernel.org"
	<kees@kernel.org>
Subject: RE: [PATCH net 6/9] ethtool: cmis: require exact CDB reply length
Thread-Topic: [PATCH net 6/9] ethtool: cmis: require exact CDB reply length
Thread-Index: AQHc6kCcz49V5Ay1PUGMtTLsmJqIQrYc4/nw
Date: Sun, 24 May 2026 09:04:12 +0000
Message-ID:
 <DM6PR12MB451674048FF9E4C32B99636BD80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-7-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-7-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|LV3PR12MB9260:EE_
x-ms-office365-filtering-correlation-id: 210d8824-5c6a-4cde-0ba4-08deb9736ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|38070700021|11063799006|3023799007|4143699003;
x-microsoft-antispam-message-info:
 78htQCo2wDabZrmllDjJAHfBApE+n/T/X/ne0ac7glHfDSzGVcvqQoMf0Ti67unyOUIX53QABO/N/AuMclkdmx+c5t8L4HOMWjhTIaE040Sg+xdMtP5cLLnDo2cgDJCDf2JI2C+sqp3GvhbaqRtqCWd35i+dD57LSA+8IDVCbMQc8JPotSIIao/bPUiF08msSme5nXcFn+e2GqCzwDwpJ6OFdkxbRZaIaS0xNirpCdmOyveo3gl10P0Yymr15Epz3r8/32rUQu44aU4XmgitO5YshWtWwJNnyxjHsiPWNIXXFL3JrDsg27PEAJNONckoIhChGTd3iMEz7H+EKjMcaJN3rJC7AnAIm5UziMyhAUyx+mtTkBl8qO+wjxia0P3oCWGoApc4FnnGhN9JkiGKZxMV9P3RbQ1+6/h+QAd4UwBGFGlbALirSr3ME8dHHd1h8p0LjPBqaIkZ8OFoFrZEV6mCHys5AK2mLH2T4BI3OobxaxABt4kcJpy9+88HoDVZkHVLr/Q9EKQ7ZjFQZlpUUKY9xv9Y35OUVr0OLhy1Do279ydY9zPH9QP39yBjDn/YifT+QKMOIHnkQPfAoY8vsrI/wMi3cgmkkHOdXGr6ao5r7p1BM8aAkIB+8ZZNeiLvgN29R98EzQ8FXS4cyFtLHoXMMzMqEPQ/szKbGKrXpQYZZqn4kllAOSUSJ6tEZDFP4cMebfKx+E7kDgmwgQJMI0E4bRJ2Au8JAg61HVbt/mpXNNqN348pNavIEnO0yNmo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(38070700021)(11063799006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1ZuUEVNZVd5RVlnY2Nkb09RcUJYWXJmcy9DV3h1NVk0SVh5M3NoclFIVXJY?=
 =?utf-8?B?WUZTYmxpNEZFaUJ6eWoyOC9HdEM2MWtwUktTa01GcC9JMGR2UGM1Q1V3TExQ?=
 =?utf-8?B?VzU0ZXZnMFdpRmVYQ3k1ZXdlQ29jOGl3eVhVNkYvaGtIMmc3Vlc5YS9FVmJO?=
 =?utf-8?B?aE5KNnI0UTZMYnEwMU5uSGF2clpQZTlRbVdBTEU0L2NKZTRhbUJuS2x0dE4x?=
 =?utf-8?B?c3Z2eit3MXFzRWpsUTMwMnRqSFRQdk9wbmU1bGQrTGo3bXFUM2JLUUZ4Zmxt?=
 =?utf-8?B?bjgrRXFjN01lbDdCRkhzRjhwcnhsRGR0ZmdESFhmTkRWdEpkUmNROGpST3Fk?=
 =?utf-8?B?ZEZ6cDJKcWFEeGl4ZFNPYjBzTHF4cVZIa3V0TlR1VmdJVFF4VkpwZVRUY1Rz?=
 =?utf-8?B?bktWY2o5RXNjKzhoaGx3TWd5bmgwSWJNZnc5a2NZcHZrYlFQWHUvb3duTFdw?=
 =?utf-8?B?alE0QU5MUTIwMEhFNGtWTHkvZ1plUUdpOE5YU1ZjVjBWdlAraWFxU0NBdHFP?=
 =?utf-8?B?cGRqNUNOS2ZsWHhLajR3RlNVUTR3Y29HTGliaGxSVXZTYjhXQlpub2J3ZE1S?=
 =?utf-8?B?UTVETngxODVHV2RGQ3dNNU9SL1ladUt2RmdnZVNndVVmeHh1VkF3ZW5KaDBL?=
 =?utf-8?B?bUlyVlhHMDJXcllrRVhIeUFtc0c0Q0o1WlFFOVNOYS9rZmErbWtoUGFjL0R3?=
 =?utf-8?B?MEc5RW0vQ296R014VjJ6TDlrbUR4OTVWODE1VkpPVGpqOTl2NERCVjJzQUFo?=
 =?utf-8?B?NXcwa2hnQXh4WkVQMEJhZ25EYUJLYmp6N1JLUnZJQXRPOWZNUlJNa25OWXZR?=
 =?utf-8?B?OER2SlZiYTFyeVplYnNFR1U4c0dJb3NrTWM1em52Wk5QZHZIQloreG02TnpN?=
 =?utf-8?B?VUE5R0F0MlVoeDg1VE9xOXdqTWlFL2lubDR1MTduMnBuYUt1M050cGdCamli?=
 =?utf-8?B?YWs0d2hTUEZmeFdDUXEwU2lZMldnT01wOU9oTGhTMUZDMzJGVllXQXFjN1ZH?=
 =?utf-8?B?d24xTlowMWo1TVA5aytTbW1jWHY5SGJnd3M4QnE1cEkvYXB3cXovQ1VMb0tT?=
 =?utf-8?B?blVNVDNvTkJUbE9XK0c1Q2t5Y2JjK25kUUpRMHNrU1h3OUkwUFhjZFl4bmJz?=
 =?utf-8?B?S0g1NzdBalhpbEw3NXJsOFphWGJtbU9Pd2xoayt3YktEZURvcG9VbHV1RkV6?=
 =?utf-8?B?ajdSRndRS3p0YnBJb1ROdGZ4aXBmK1MvS09FUnl0MVR4R1NDM1h4MVFjM0p0?=
 =?utf-8?B?c1AxQzA1em5sVjJ4Wk01Z2hQb3hDemZvYnlyNENMY1l3anFndVlSZVFmZ1lu?=
 =?utf-8?B?OG8xMnUwbWNFUWRpdmVwc29QcjJzdnY1cjRWUWFFdys5YXNtRHpYUllGei8v?=
 =?utf-8?B?TXlGODRjTGNBR3JhNTZJN0hTUmNCTVlJdnNtbXNRNHpGWlZlT0hRZldKSVhz?=
 =?utf-8?B?ckh3RWYyQUhKQVJvN3hlcEVxS2ZXaXc0elo4RmZzb0dhdUo1a3BhTVhPWWhY?=
 =?utf-8?B?bWJBZlE3Vk1yVDBDVXZWbmR6VDZpOWF2aDhlTzRoRGZFMzZYWURacklFdVZl?=
 =?utf-8?B?Kzcvbko4Mm5VTVZyQ0ljSkdpSFNPZEFXNHMrL1M2U0NIcFozMGVnZUpwQUFk?=
 =?utf-8?B?MC9vL0txU2VCd21yZUl1SUZZQndOYkYvdy94Q1ZDU3ZyM21wVE0zTWFSSFNR?=
 =?utf-8?B?L1J3NHpmQ2JlR0I0a2tDdm4wUTZoZ1ZkcEZlMk9iNTNscnowUnpjNnFFbDF5?=
 =?utf-8?B?bm5nd3JQOVBNdWRjUlBmblh4VEtGWEc0Z3k4TVlxeEpCY20xWE5oeHFYSXhX?=
 =?utf-8?B?ZkpLeUVvdFVNajgzcGorNmRsQXFPd20zS3pqQUtQV3VOYkNzS3BCMnZzU2M4?=
 =?utf-8?B?ZzhnSkdTcG5aa29od1RsZnZqRFNubFZxaHFwRmpaZE9jTUFhTUM2Sk1GSThp?=
 =?utf-8?B?eEd1Q0FFK21PbTNLWWpzMUIxSDhzUXJJZHRGNFZFTTVXT0FZakdVUjkxWWtE?=
 =?utf-8?B?dlhSMGEyTnJvN3l3c294VkY3RTVpQ0ZCbG82WTdVdWFxSGxaVnBQVGM2bHJO?=
 =?utf-8?B?aU1YMHBTT0dJeDI2Vk5aSGFwY3lFRUpaaTBDVTI5cTZTOWxqMkhJckhxNWhp?=
 =?utf-8?B?S1I0cjlHK3dMOUFsaWVXdnVrRGcvSXBJUDRGUGNjYzZNbXJqWnVOU3VHaXIr?=
 =?utf-8?B?eHpoQWVhalF5T2dKdU1XcUhRRWorYkNLWDJLcFdpZklmMHhtRnErbm5wWlk3?=
 =?utf-8?B?MWg2dTRqY1BwYURrTTAvd2dCMnBCTkJSS2dMWEZPNG9Ld0dlUWVMSjd4MDgy?=
 =?utf-8?Q?OxOgWEzls5B1Ww1ovw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210d8824-5c6a-4cde-0ba4-08deb9736ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 09:04:12.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34FQgib8DSW72qgkZuMzngqfV43G3cbhlZKJtyTd5nLKp9bbPegBh062yZVqDWOdyPkphtfLdxteHaZhI3FROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291159-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.044];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 0FC5C5C1C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMjMgTWF5IDIwMjYgMjoxMw0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgaG9ybXNAa2VybmVsLm9yZzsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+Ow0KPiBQZXRyIE1hY2hhdGEgPHBl
dHJtQG52aWRpYS5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsgSWRvIFNjaGltbWVsDQo+
IDxpZG9zY2hAbnZpZGlhLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBh
bmRyZXdAbHVubi5jaDsNCj4ga2Vlc0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQg
Ni85XSBldGh0b29sOiBjbWlzOiByZXF1aXJlIGV4YWN0IENEQiByZXBseSBsZW5ndGgNCj4gDQo+
IE1hbGljaW91cyBTRlAgbW9kdWxlIGNvdWxkIHJlc3BvbmQgd2l0aCBycGxfbGVuIGxvbmdlciB0
aGFuIHdoYXQNCj4gY21pc19jZGJfcHJvY2Vzc19yZXBseSgpIGV4cGVjdGVkLCBsZWFkaW5nIHRv
IE9PQiB3cml0ZXMuDQo+IE1hbGljaW91cyBIVyBpcyBhIGJpdCB0aGVvcmV0aWNhbCBidXQgc29t
ZSBtb2R1bGVzIG1heSBqdXN0IGJlIGJ1Z2d5IGFuZC9vcg0KPiB0aGUgcmVhZHMgbWF5IG9jY2Fz
aW9uYWxseSBnZXQgY29ycnVwdGVkLCBzbyBsZXQncyBwcm90ZWN0IHRoZSBrZXJuZWwuDQo+IA0K
PiBUaGUgZXhpc3RpbmcgY2hlY2sgcHJvdGVjdHMgZnJvbSBzaG9ydCByZXBsaWVzLiBXZSBuZWVk
IHRvIHByb3RlY3QgZnJvbSBsb25nDQo+IG9uZXMsIHRvby4gQWxsIGNhbGxlcnMgdGhhdCBwYXNz
IGEgbm9uLXplcm8gcnBsX2V4cF9sZW4gY2FzdCB0aGUgcmVwbHkgcGF5bG9hZCB0bw0KPiBhIGZp
eGVkLWxheW91dCBzdHJ1Y3QgYW5kIHJlYWQgZmllbGRzIGF0IGZpeGVkIG9mZnNldHMsIHdpdGgg
bm8gdmVyc2lvbg0KPiBuZWdvdGlhdGlvbiBvciBzaG9ydC1yZXBseSBoYW5kbGluZzoNCj4gDQo+
ICAgLSBjbWlzX2NkYl92YWxpZGF0ZV9wYXNzd29yZCgpDQo+ICAgLSBjbWlzX2NkYl9tb2R1bGVf
ZmVhdHVyZXNfZ2V0KCkNCj4gICAtIGNtaXNfZndfdXBkYXRlX2Z3X21uZ19mZWF0dXJlc19nZXQo
KQ0KPiANCj4gc28gbGV0J3MgYXNzdW1lIHRoYXQgcmVzcG9uc2VzIGxvbmdlciB0aGFuIGV4cGVj
dGVkIGRvIG5vdCBoYXZlIHRvIGJlDQo+IGhhbmRsZWQgZ3JhY2VmdWxseSBoZXJlLiBBZGQgYSB3
YXJuaW5nIG1lc3NhZ2UgdG8gbWFrZSB0aGUgZGVidWcgZWFzaWVyIGluDQo+IGNhc2UgbXkgdW5k
ZXJzdGFuZGluZyBpcyB3cm9uZy4uLg0KPiANCj4gTm90ZSB0aGF0IHBhZ2VfZGF0YS0+bGVuZ3Ro
IChhcmd1bWVudCBvZiBrbWFsbG9jKSBjb21lcyBmcm9tIGxhc3QgYXJnIHRvDQo+IGV0aHRvb2xf
Y21pc19wYWdlX2luaXQoKSB3aGljaCBpcyBycGxfZXhwX2xlbi4NCj4gDQo+IE5vdGUyIHRoYXQg
QUlzIGFsc28gbGlrZSB0byBwb2ludCBvdXQgb3ZlcmZsb3dzIGluIGFyZ3MtPnJlcS5wYXlsb2Fk
IGl0c2VsZg0KPiAod2hpY2ggaXMgYSBmaXhlZC1zaXplIDEyMCBCIGJ1ZmZlciwgb24gdGhlIHN0
YWNrKSwgYnV0IGNhbGxlcnMgc2hvdWxkIGJlIHJlYWRpbmcNCj4gc3RydWN0cyBkZWZpbmVkIGJ5
IHRoZSBzdGFuZGFyZCwgc28gcHJvdGVjdGluZyBmcm9tIHJlcXVlc3RzIGZvciBtb3JlIGRhdGEN
Cj4gdGhhbiBtYXggc2VlbSBsaWtlIGRlZmVuc2l2ZSBwcm9ncmFtbWluZy4NCj4gDQo+IEZpeGVz
OiBhMzljODRkNzk2MjUgKCJldGh0b29sOiBjbWlzX2NkYjogQWRkIGEgbGF5ZXIgZm9yIHN1cHBv
cnRpbmcgQ0RCDQo+IGNvbW1hbmRzIikNCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gLS0tDQo+IENDOiBhbmRyZXdAbHVubi5jaA0KPiBDQzoga2Vl
c0BrZXJuZWwub3JnDQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNvbQ0KPiBDQzogcGV0cm1AbnZp
ZGlhLmNvbQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo=

