Return-Path: <netdev+bounces-248962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DBD11E72
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8933007C59
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BE27A122;
	Mon, 12 Jan 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVnq+C1S"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D77248F57
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213941; cv=fail; b=lz/J0tD9v5Xmb0yQe+EO6rmOLdPTewSoAp4+KcygaTZiYbzkJgcIqyzF77GcBVfDF3sGtKegXRodtA/5kUtsSWwPPQxqWxNpcIlMk07Oyz7ixsCSxfZMDn/PO9YBQsggLxArSJCZjI8mLh7VyogZ9FyfWOQzcZkGllG7P8BszgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213941; c=relaxed/simple;
	bh=yD+xZeHpwNPM2aW3QHWabwMX5FQecMmfWwf4RNJlJug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PoMVP4fMLWzr3oAYO1m+13GRR+HFq0FyQpWL1zuX4yqfDgAG4kM7FUeguCSLRko8iIsP73qyvQftKhF26+2y/0W5b1rhwCmRB/kDtK2Aer4HLzVeVw2JV1ck7vJNuO4FCQJahKsE2VyC+o7npnncngJcmMMauUQ036mnnsu2jiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVnq+C1S; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNzaZP8eNCcVtmSGFhD5C2J5fVstbL8x/62BW1aCTt8obnLIJs5gjo391KCymSsiZHHgBvSsARE8xpQFswl9TQjs+T8eD4OzxNOBJRcky7LWEWR8XL9AS1VFi+BMI4fMdygOdNJeoIXMwB9ioHF/yuHKQ66CaaX0O3fWaEzSpbSyiKA8sU3ia7GCYbP8bAPNTeMeGm2GwuBrQVPFYKaKIjQTwkixTAhtkqjpXFTfK6YFMM7A8SAAP3T5et79S1SEH4dJdp+Q5FeNZyQDOeemET+tDBoCGxjgcFyZQul+SRavrg87y7lYaKViu5Y+8XfcRtuHfxHi5Ok/Gk6Bm8Uwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD+xZeHpwNPM2aW3QHWabwMX5FQecMmfWwf4RNJlJug=;
 b=ZP2fkhVrJv6Q85OsVyRAHObtJKafUAEuRLPolBmqD60Hko+p/2j0ojjQiyJiFLIvQuNWWruFJEx01vqVMjCJiF4T4AA8+E9doApJuJ9WZVSGi8Grd7pUv8rXkJQP53GQh5F2zr4zkx4kqnUYGCC28Nf9BZ5SMHw87QfDS2NaPKixxdO4yLo4FLT/c8vYxZveyuEFag1onQC9AU1rskyWNnNIWgTVvvZHX5UwypBQ4ICHLIx8A72hQNBJUrMPiGuWLgm/Q4btW+avijJQ0MEy0ZKmnDMxfRk+h3IvaKqucGoMHSDtwHeCJvqBjOSYg/fkoV3/ltmJ6Xh1ZXZ3AYVG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD+xZeHpwNPM2aW3QHWabwMX5FQecMmfWwf4RNJlJug=;
 b=OVnq+C1SknkUU8jWu9ZL4IattaWXmdEDi5yPqv3U3osN/hOAF/IlTUjXD/5EqmVLmJ4UiVv2e5QXmDsdFRj1fDhYuxx8y+DOxKWLey7NmyA00m0T+iE8URJZW1P0S2siCXTrh+ZTNkRWtns0Rmt3KUBAc+blC0ZPfJvcgfzLc09LHgODbnJ8YGjQBvAlo5ymLi6EumwsDJEuKAjZatgjQAQKl8QGITRECuhHjRQBRqcSQkJu0dtL68oQL1ebHWOZjQHqOH+aUUYtUCfweybQ4jxQIEpySJr3wK/LnjsMu7eN+pTd4AzbiCibGhtECrsK2877YKkMc61eX3NlwAsshA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB9077.namprd12.prod.outlook.com
 (2603:10b6:610:1a2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:32:17 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 10:32:17 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Dragos Tatulea <dtatulea@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Index:
 AQHcf8MYq0aPKotsqky8aDx5Wvpp8LVJpWmAgAAUJACAAAe+gIAAHPgAgAIn0QCAAlfUAA==
Date: Mon, 12 Jan 2026 10:32:17 +0000
Message-ID: <34305da7654365c3c8ade9cde07cb992f7270634.camel@nvidia.com>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
	 <aWDX64mYvwI3EVo4@krikkit>
	 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
	 <aWDvTx9JUHzUKEGm@krikkit>
	 <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>
	 <aWLWgrL8UYJISOsu@krikkit>
In-Reply-To: <aWLWgrL8UYJISOsu@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB9077:EE_
x-ms-office365-filtering-correlation-id: 0c1518eb-c852-4aec-6e71-08de51c5dbd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHV1TUZUcXZZTm8wZFVqM0d4Z0Flc2l5bGs3cFl3YkZ1ZWV1Q3RpRVJBTTZX?=
 =?utf-8?B?eUFiU1YwcUxuMGFGNzNGMW1xdk1zWU9PSFd6bTkxYldMWXpkcXRmNEVlVHFF?=
 =?utf-8?B?enJxR2NsYVIwQThkZU44MHZjTFlhSWNOK2RLWElxK1FzekdXUE9MTnBsdkh1?=
 =?utf-8?B?dXcxbTRIZEgySlc1Ty9Vemsvbkc3WDhIODBlMkJiclVSWmVlNUI1RXBiSlR2?=
 =?utf-8?B?UnBkMWtnZmk0UFI4Ulk3TzJtdU9wbWlqRVJOQXFWdTJDUDB1V1dOTlRZU1pN?=
 =?utf-8?B?R1Y1TjRPRVZRUGQ3QzlFZmhhSlJTWEY3VUoyNjVVNmNCV0VwdkgrYTFkVmNZ?=
 =?utf-8?B?VFdpKytpQXZiVG1xcFhTd0RQSXdRYWlwdnFtUWpRL05tU1NjamZWYjJRQ0Jq?=
 =?utf-8?B?cE1ockQrRlhaQTB4WFVjbllVMk93UVdBVEJPME4wc1Z0N0tObXcrSmJoVitz?=
 =?utf-8?B?WUNSMU9ETUplNFBjaEk4N0tLL2NKT2lvalFKNkVJaDR6U1ZlcW42RmR1bk1Y?=
 =?utf-8?B?TjRTbHp6Y2ZjREVKN1Y0WmNCTUwzNXNlZnhDVlF4TW9DbWtSRWlyZm9iYlRP?=
 =?utf-8?B?MVFKQmtTTXc2M1N2dGZ1dWRMOWpMampEbWIxZEQ0T2ZOcTVhUTNpT3p2YzFV?=
 =?utf-8?B?RFRKM04yT1AxN2x4ME1NWlBlUHIyWmZRU0tYU09BdUZ2VWhxL2c5Tm5qTnZp?=
 =?utf-8?B?b2hLYVo4dHNSWkZhVXRyaHNiMFBQWkhUNW0zTmV3eThadUdRcXV3VkNjOWhP?=
 =?utf-8?B?NGpLZWVTVnFjNkNWUGNIdEFrREJmNzNSOFN6dnZocUR4eTRvSXQyYTB2OHZn?=
 =?utf-8?B?UXNaUmFPcVFvQWV2Z0VKbkVSMm15b0hEODRma0FqUkJCSXhBYzVTcEFDV1dh?=
 =?utf-8?B?RERWaDV4V1ZhR2hwZW9tQVp3ZldtVHZCRk5jdUdZbGhnN2V0cVdyWlovbjRZ?=
 =?utf-8?B?eVVRMVlUVEZxR0VhblB2dkdUWkdlVTZLUGFFQUFsMUR3K2Z2eUh5Q1Rzd3Qz?=
 =?utf-8?B?UXJWR3NwRkVockc2RjQxZkRwd3V0cFVGWVhKNllLNEhhaCtJNUQ4RzYydzV4?=
 =?utf-8?B?Yk9JeCsvOWlYVjljT2JYd0tnRHlMK1ZWOUE3ZGRIRlRJSkMwN3pWMldReXdR?=
 =?utf-8?B?KzA3MmwrUzdRbkdpUnR2ZmV0aUZySUgySnVoNDcxc25JcGtKN2oxanUzN05S?=
 =?utf-8?B?RTRVeWVCNXkrZ2JIYnV1NHdORTdIYkdtay81eEtDWGJSa0trTmJYc08wMXk5?=
 =?utf-8?B?Q3BsdCtDSWNzYXQvM2RKNTd5VURITkdZc0k0U3ppUGY2V1pNUTFnQm1tbDB1?=
 =?utf-8?B?UlNjT3ZlREEvaEZDOE14R2wvRTE1NjM2N1hqVkxyejI3WG9xcXRxL1RSWk5y?=
 =?utf-8?B?bmt3cGhwQk14cVFvditTUnQxZDRLSUtEcjJnVG5HWkQrb1Q0ZldWLzFXcEdl?=
 =?utf-8?B?S3pTdlVVMXp4MGNWSTVDb2l3QW42cDBiQ04wVGQvNFhRbmQxNFk3M29FSVU0?=
 =?utf-8?B?cVFRMXc1L2t5a3FvQU1GbGluNUZSM3c2dmJhZWxwVkp3R3luaEVzd0ZGbmhC?=
 =?utf-8?B?OHN2N1ZJWXVSdGtoL3ZTcko0cDRlL1U1WVBqaW0yaU9iVWZMSFpIN29BRDQr?=
 =?utf-8?B?bW1BcW5STEx4U0I4M2tNVHdSYnNrTHlGUWpZanlRNksvN204VjhTb25VOXVH?=
 =?utf-8?B?UUlpRmpXdTcrRGJaWmF4NUlURTNXNW9ObWVSMkZrY1JYRGtHWUFxUUU2amhR?=
 =?utf-8?B?WXhYNjA4SGFkM21idlFRbGZYK2FTbTBzYThwdk5qamFkMFVQMXhOU1g5ZDcr?=
 =?utf-8?B?WkhNTzlnejc1c1h2TlpObjBQaDVYQ0p1cnFGK2krRGgrNXZVb0UwalMxY2tL?=
 =?utf-8?B?Nk42cm8rWG02OHFWOUN2SUxtKzlsT1BjZmg1RTBHVjNiWFhwMjV4NC9nK3Zz?=
 =?utf-8?B?NnhGVnZ5OE9XK0U0d2x2UndPNktTSjRYQmFyNmUyQ3FMSnhrTWE5aHpuTHJO?=
 =?utf-8?B?cE5xQjIzeUhENVI5QzZVN1ZZM3BINzYrb3YvMmVndWNXZzFtejVQd2ZySnNR?=
 =?utf-8?Q?4VnPek?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3ByUVQ5VU4yMi9NL25DaDBDU01xQVBTODE1Vmg4NmhqYm50bE5naXQwL0M3?=
 =?utf-8?B?VFFFQ2RBR2RIdmdqMnRRcTIxMXozVnlKZDBLY2R4RG9ONmJmallQTTFGbHVk?=
 =?utf-8?B?QkV1VVBiR2hBMGxOMVRySXp4a1psdXNvSnd3VzduVGdiWVJzRWNmYmZtNWsv?=
 =?utf-8?B?bzl5Nks1bmZHZFFpdDZmdUFtcm5WQkd1T3dWK2Y5bG5Ud1JPTnZ2WE1oUU9K?=
 =?utf-8?B?YTRQSy9QMjF3MUtienlDSXVWdExVZDh4Y0YvM1RlOFZzNWNXS1JVRERpODAv?=
 =?utf-8?B?VkJ1WDBrbTVHaUtyaFl2ZGFwdzRJaFh4QUh0VWp6TUdqcGpUNVNTZDJlTG0v?=
 =?utf-8?B?NVpQMDdXQzgvb3FVWGZONUNyYWNieUNqclJmUHNwTjhSc3hwNjErc3VLVDhH?=
 =?utf-8?B?RkFJK3k2S2t2cFlyWGZpUXd3QUJQbjQ5VFV0bi9UVFVEem4yQnhzd09ncWpp?=
 =?utf-8?B?NmNoUGZYekpVOFB0ZUV6eWNRQ2p2WlRzWDZTUnNxRk1pVUQ3ZjRuZWtTOElJ?=
 =?utf-8?B?cmllR1RnMFRXMkY2VXU5Uk9xUXRoYlFqOHVFbEVzd3p5aGUwclpKbFNJc3Yy?=
 =?utf-8?B?Z2hzTmhWZTRNSTE4RUs5UVJLRU5PbENOZ1RjNHFqSTVTbTFKT21xaFJJNjVJ?=
 =?utf-8?B?WE9pbGtmMlZVSjYrcDlLbk5LdHUwOEI5TlJQdVRFQno3c3hTOTlscFpubEdU?=
 =?utf-8?B?cEtQREhFaXFkb0pudTlaSmZGalE4QjZNWkxDdklieWhvUlcyK0hZRE03MFZH?=
 =?utf-8?B?TEg0ZUQvVU1XdW1EUWJIcnRGSkF6UVAvWUh2MmIzSy9mOUdScTJISFNndVRS?=
 =?utf-8?B?ajI0OHdpMnJ4TTBOV2ZPYWdXUzh0OXJadmRMSEM5Z0VHNEd4R2JoUTUwdmUz?=
 =?utf-8?B?OGlvMGhvZ21OdVkvaVRQMjZSS05yOWRidHA1MmhDcFZvVE9ZT2NPOHZNL25u?=
 =?utf-8?B?SnNlbFRkNHNTMWYxZ2tqbVl2Q1BneXFNM1ppblJkbzE1T3ptZXh3TzBJNU9s?=
 =?utf-8?B?WlU2MFBRRkdNYTg3Q1F4ejhGalZEZ3JvTTY2ZUwyaUJFQUZ4RjR3NHY3YjlU?=
 =?utf-8?B?QTY0R0FNU214QndGcGtoYTg3UWk3eHgwUFF0ek1rSDg1L1ZBaW9hZ0FyQlBS?=
 =?utf-8?B?TUdjNzFkMkIvcjhIb3dRTDA4TGZZRWtpbFN4NFRQQ3RFRTFQUFBaMmFlRllw?=
 =?utf-8?B?T05lSjdFYkoxSnBXQjJza1V4eWV2K1R0UlczRncwSHdLbE1SeWFEUW9ocDhS?=
 =?utf-8?B?YjJPekNsbXlXY2RBZ3NkdFk0OHpYeThEMG9sSDZ0ekJVWUx0R2hCQXlRd21T?=
 =?utf-8?B?UjJIUlZuaUhYVjUxdEwraVlpaHBWekI4alZRbUVXd2lDNjNVY0tqUGQ3V21W?=
 =?utf-8?B?WTZTcUhDNmpMN3lpdGZGdUIxVlBDZjhlMG9vUDE0dU8wVUkzOU9NWmJDdDB3?=
 =?utf-8?B?WUhuSWxBWlFHY3dhOWZtVEVGQlVnc2RZWVIwVCtEUDdZK09ndW5xOG5oeUxz?=
 =?utf-8?B?ZkdBU3FXbmordTNjYm1zUTJQZVg5M3FEWEV3ZEFJY3FmdVdYckZHV3JycG5y?=
 =?utf-8?B?dFR2UzNMRWQ4cDYxa1E2aDlWSWFFY2ZGcUpVRXBOOXBBbkJ3T2o1M09hdnhi?=
 =?utf-8?B?Z2o0NGN1S2E2eUpibGU2ZDVZNTNLeUdrSHk5b3F2K3p3VnppVnJhZEszbDk0?=
 =?utf-8?B?TitYWUE1aVplMGRDS1h2cUtHVjhHTTlQK2NmSnhsamJEZ0xudHl3M0NoT3VF?=
 =?utf-8?B?blRTRFFGd3UxVXlDQkU1dEM5bUVqVE9KajRhZ2dZeEdNT2hmQ0dCbndYRlNI?=
 =?utf-8?B?YmRPUEY2dFdCM2MxdFJEWkdRdlFBMXFlbzJ2cW1XYnRuNmI0RHlCR1lzWUN0?=
 =?utf-8?B?bnlOQkl0WnZWY2tiUUl6VFBvdmpBVGRHVGg1djgyZk9wV3pad2JwMDdSZjAy?=
 =?utf-8?B?SUcreGttOTVEejV5MDJJTnVwV3drZU5HR29mY1VTSGlnY0VmMndXcmpQdXI1?=
 =?utf-8?B?S0NDcTM0ZUg1cnB1cUtDK2d1NERUako0eXc3RW0zZlVZZG5xV1lnYWtSSkc2?=
 =?utf-8?B?NFB2VW10eGlnNEpLZkJpQnU4NlBiZlBta1dFeHlSOFQ1bFgwczhSMzNITm9v?=
 =?utf-8?B?bmR2YVpiYkhWaS9vQVVMWWFPVWl6NlJ3RzREQ1VjLytCYnVJSzgvZVZFamdO?=
 =?utf-8?B?K0QwTEZDK01wNEZscnQ5MTlaL2tJTjc4ZDFha3NBVU5tNFZCYkd6b1lnZVNh?=
 =?utf-8?B?OWN4enFobXlYcnZRU0N1MGRNaFg0akJxd2JYTmQrTEJuNG9ES2pkSFNuN1Jx?=
 =?utf-8?B?TEhFSEhPN1pUYVJ0Skd4NUtXNEFwQk9vNG0xUG1ZdEY0d0E2NE5Edz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E565FBA590E3CD4491667D78E0E9A5EF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1518eb-c852-4aec-6e71-08de51c5dbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 10:32:17.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waT5VCeU6GFJfT6yH2am+8Mboi6/o2uLV9x8Kf1NBecVhviF9lFzsW3JCK6jSrYB2C4ctvlqTMI2nZ/Z2HPhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

T24gU2F0LCAyMDI2LTAxLTEwIGF0IDIzOjQ1ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDEtMDksIDEzOjUwOjI0ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+IA0K
PiA+IFdvdWxkIHlvdSBsaWtlIHRvIHNlZSBhbnkgdHdlYWtzIHRvIHRoZSBwcm9wb3NlZCBwYXRj
aD8NCj4gDQo+IFdlbGwsIHVwZGF0aW5nIHRoZSBsb3dlciBkZXZpY2UncyBWTEFOIGZpbHRlcnMg
d2hlbiBub3QgdXNpbmcgb2ZmbG9hZA0KPiBpcyB1bmRlc2lyZWFibGUsIHNvIG1hY3NlY192bGFu
X3J4X3thZGQsa2lsbH1fdmlkIHNob3VsZCBjaGVjayB0aGF0DQo+IG9mZmxvYWQgaXMgdXNlZCwg
YnV0IHRoZW4gd2UnZCBoYXZlIHRvIHJlbW92ZS9yZS1hZGQgdGhlbiB3aGVuDQo+IG9mZmxvYWQN
Cj4gaXMgdG9nZ2xlZCBhZnRlciBzb21lIHZsYW4gZGV2aWNlcyBoYXZlIGJlZW4gY3JlYXRlZCBv
biB0b3Agb2YgdGhlDQo+IG1hY3NlYyBkZXZpY2UuwqAgS2VlcGluZyB0cmFjayBvZiBhbGwgdGhl
IGlkcyB3ZSd2ZSBwdXNoZWQgZG93biB2aWENCj4gbWFjc2VjX3ZsYW5fcnhfYWRkX3ZpZCBzZWVt
cyBhIGJpdCB1bnJlYXNvbmFibGUsIGJ1dCBtYXliZSB3ZSBjYW4NCj4gY2FsbCB2bGFuX3tnZXQs
ZHJvcH1fcnhfKl9maWx0ZXJfaW5mbyB3aGVuIHdlIHRvZ2dsZSBtYWNzZWMgb2ZmbG9hZD8NCj4g
KG5vdCBzdXJlIGlmIHRoYXQgd2lsbCBoYXZlIHRoZSBiZWhhdmlvciB3ZSB3YW50KQ0KPiANCg0K
UGVyaGFwcyAidW5kZXNpcmFibGUiIGlzIHRvbyBzdHJvbmcgb2YgYSB3b3JkLiBJIHdvdWxkIHVz
ZSAidW5uZWVkZWQiLg0KSGF2aW5nIHRoZSBlbmNyeXB0ZWQgVkxBTnMgaW4gdGhlIGxvd2VyIGRl
diBIVyBmaWx0ZXIgY2FuJ3QgZG8gdG9vIG11Y2gNCmhhcm0sIGV4Y2VwdCBtYXliZSBhbGxvd2lu
ZyBzb21lIG5vbi1tYWNzZWMgcGFja2V0cyB3aXRoIHRob3NlIHZsYW5zDQp3aGVuIHByZXZpb3Vz
bHkgdGhleSB3b3VsZG4ndCBiZSBhbGxvd2VkLg0KDQpCdXQgcmVtZW1iZXIgd2hhdCBoYXBwZW5l
ZCBiZWZvcmUgdGhlIG1lbnRpb25lZCAiRml4ZXMiIHBhdGNoOiB0aGUNCmxvd2VyIGRldmljZSB3
YXMgcHV0IGluIHByb21pc2MgbW9kZSBiZWNhdXNlIGl0IGRpZG4ndCBhZHZlcnRpc2UNCklGRl9V
TklDQVNUX0ZMVCBzbyBpdCB3b3VsZCBoYXZlIHJlY2VpdmVkIGFsbCBwYWNrZXRzIGFueXdheS4N
ClNvIHRoaXMgZml4IGlzIHN0cmljdGx5IGJldHRlciwgc2ltcGxlIGVub3VnaCB0aGF0IGl0IGNh
biBiZSB1bmRlcnN0b29kDQp0byBiZSBoYXJtbGVzcy4NCg0KVGhlIHZsYW5fe2dldCxkcm9wfV9y
eF8qX2ZpbHRlcl9pbmZvIGZ1bmN0aW9ucyBzaW1wbHkgY2FsbCBkZXZpY2UNCm5vdGlmaWVycyB3
aGVuIHRoZSBWTEFOIGZpbHRlciBmbGFncyBjaGFuZ2UsIHRoZXkncmUgbm90IHVzZWZ1bCBmb3IN
Cm9idGFpbmluZyB0aGUgbGlzdCBvZiBWTEFOcy4gVGhlIHVwcGVyIGRldnMga2VlcCB0cmFjayBv
ZiB0aG9zZS4NCg0KSWYgSSBlbmdpbmVlciB0aGUgZml4IHdlJ3JlIGRpc2N1c3NpbmcgaGVyZSAo
d2hpY2ggd291bGQgbWFrZSBtYWNzZWMNCmtlZXAgdHJhY2sgb2YgVkxBTnMpLCBpdCB3b3VsZCBi
ZSBzaWduaWZpY2FudGx5IG1vcmUgY29tcGxpY2F0ZWQsIGFuZA0KaXQgYmVsb25naW5nIGludG8g
bmV0IGluc3RlYWQgb2YgbmV0LW5leHQgY291bGQgYmUgY2FsbGVkIGludG8NCnF1ZXN0aW9uLg0K
DQpDb3NtaW4uDQo=

