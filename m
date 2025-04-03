Return-Path: <netdev+bounces-179046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612EFA7A39D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3290189269C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677A248195;
	Thu,  3 Apr 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e77KUPJ/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88435D529
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686647; cv=fail; b=eKsIxQ2774/hdotPMKlT4cUaQwozZm/ZaN50cARyIQTKauw4ZCsC/FJHMLox//zxZ/bCHiL9IieOSnv7ss1VAlqj3b2NmakmyOovHatnczZHIXUbiCrKZuAvim22Vn90GdkaXbxmb64JDAyQeMMKQXsChBzgRXOMe4/BaMhEBaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686647; c=relaxed/simple;
	bh=C7aij4wNMCKXVHKgmk3JcjwmpkAEO46189t6IwT+fEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+9gddVVWsRwmK3xKuf9dXJ5CKRY9Eu9DTbg5pykf8Bu8t+RmtKtA4WC4t9/tQEf6ZF6S2EGo2mtHb4BUOyQ8mzL5mSXC8DP/RFR03mGPnFiSqGIndOAxfdaW7+Ht1u0kR7ZVCsGye7pr0AG52JUCs6ZRzq81oHjd7G2Dj7nW8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e77KUPJ/; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjc9EX2lq/0CNknjU4wcBToobWYn7uy/qW82qgxsFsTeDAIK7Vx+cem3a5C0BwXWdiaCkI4X6qgnWbz5/sjw6F9r2nqEcASV9QnJeEWuT8FRj8IjZguvtIbKoZl8qK5rn5DUcA/flX/8OZgKy8+a+9h3A1p1I/H8G3xYtdcCv1JJmrRGlNuoIDrr2ZKbfLyyivXLv4Qrah4Ax9GckdAn2OLWp8u41fFgDANbjxh5sELa5rhAaAHjuaiF7IxNBKxobToAWRiFZYf8SlysJbvlV1KSH0fk9gRlpTa11OYdq5OJPhmHmHN7EaJTci2gNn7GS0jy5PvKW+jxiAyrPXlzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7aij4wNMCKXVHKgmk3JcjwmpkAEO46189t6IwT+fEU=;
 b=iJ3zRysb3ymrVbHY7+G8uL9NiXMuyORfnln/jxHCI+1LO2z8CoOx9hz74wgVu/N/llcl234s4Ua2Hs3QbyO/1pgrzJGweQ/x32UXSDhVyyL/F+9i80IvUcHhPfiGuWy7UcDx5PKk6P6L9DyKfTswUh4kGg6DnVXsOsCBp3Um+4SUf8DUBegZ9aXT1C4TyBw2TYxqhTxJW0Bd/7cBMcdyxzn4N4Mc6xdW+YqbGWFmkwlF3SB2Alfs/46K4R2WfR3rsjL7VktkQJIVcGd2/A8TWRCkcLNTDN0YA8vaZpl753BGdkz4yM6MD9iLU8JtveRpO6jBfD6yTsKt0C5VTfzKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7aij4wNMCKXVHKgmk3JcjwmpkAEO46189t6IwT+fEU=;
 b=e77KUPJ/FtGS7LiL+fnE5dPCk+6CMhiGkNa6UYolT3KfyzIesTNFd4b935luqcYgRnYWWOHVaAv2OCgIuCUIukXgwVPA/SFel0fbUtoeFYeF8eXdrXZEBuvfNmv9smUANqIn8MS8gKKA7bmEbLDngQg/QHqYBFojK5ESa3FSmVF6jgJsvOz1rToQnhX1n55asIcpTP9vNIIOTPRQkbM4jJdsEmDOkVdWarNd4tiJIxAjGmxMCaJ8sf3wJc1a6xBCYT7Xif2ZrQWxtOkEAAnPpqC5ap4yowJ5/WVX7r5b9Ax47bZwkrsVDgFIp4K1GxduiHGf769cMhBxK/tAZrhR1Q==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.41; Thu, 3 Apr 2025 13:24:02 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 13:24:01 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: another netdev instance lock bug in ipv6_add_dev
Thread-Topic: another netdev instance lock bug in ipv6_add_dev
Thread-Index: AQHbpBgNsW0Cw2ElFUOEQjFKH76LcbORA5IAgADrjwA=
Date: Thu, 3 Apr 2025 13:24:01 +0000
Message-ID: <c4b1397ffa83c73dfdab6bcbce51e564592e18c8.camel@nvidia.com>
References: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>
	 <Z-3GVgPJHZSyxfaI@mini-arch>
In-Reply-To: <Z-3GVgPJHZSyxfaI@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CH2PR12MB4325:EE_
x-ms-office365-filtering-correlation-id: 9ac9942f-344c-4632-046b-08dd72b2cc73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDV2QzVsYVpVeW8yRlRFcVJnRG1VMTFGVk5qSFY0SzhPcUM0c1V3MlUvVWtz?=
 =?utf-8?B?ekZ4VVBrMkRUVWNENmhOYTdaY0hUdGhLOTVvc0g2VHFQYVFwc0szSjNBWVlP?=
 =?utf-8?B?QVJPVzRYaWpOclBva0xyQWNEVWpoejlJdnJ2SWVQQ1RQdmI1amlQd1dUZ0pz?=
 =?utf-8?B?bk9HWEZMeVR2a0lCUXR5VjU4SGxjSktGZCtZSFJxb1MxUmRBaXZ1UURmbzVs?=
 =?utf-8?B?UktuWUJSQ3NTdFFJSmpuOVRFbWNualNYaTM5NnB6Z0ZNdHJWZEtpS1U1ZGR5?=
 =?utf-8?B?TWNOTWJPVGJNODhLL0FZSHo0Yk9TMnJQY1U0U2RBYTNORVJZQU1jUDN6NTU2?=
 =?utf-8?B?eVVNNHJId1Vrb3lBK2JaWW5WRjIrelV0V0E2a1hnWGE5c0syaHpJcTk3dUww?=
 =?utf-8?B?Z1lBcjUvYVBlVHE4Z2ZBQ3NycEN4b0JkYTZRYVh1aW9KWFljcVJkazVNZU9Y?=
 =?utf-8?B?d1Z6K2hsamNWQ1Z1czQ0MjJ3Um5QSkpiT05HRTlXODFCUmJPTHBPRnFYK2xH?=
 =?utf-8?B?aWlCeUIwNGRhL2E1OVNKajg5QmZFalB6OHgybTBhWGxCK0NPTTdJVlF0ZjBu?=
 =?utf-8?B?THRSamppQi9YQ21oVWR5WXA5V2FSZ0VmcVhYL0FTOGdhSWZhRG00Si81NFAw?=
 =?utf-8?B?bjRrcVlrT3lUTmw1eWZJbFZiTFNvOUkwTkQxdCt6Q2xyVlp0dE8vbmZOSkR6?=
 =?utf-8?B?ekt6ZFdlYnMwT1E2WEFDQWVuRWRxTDRMVEtxMjREZzVET0M1MldtMzJVUUhI?=
 =?utf-8?B?eFlkQTNUNGdwWFp5RmNSZE1VNDI5VEhON0o5dFJvZHBMRXFNT0JER2ZZeUNz?=
 =?utf-8?B?YWZBN3FkNUxIdTU3V0VySE1DdnlZdEEvVld6cEVYdTBOZkF1eVA5aFhmUmx1?=
 =?utf-8?B?dk1wZHUzOXBRY1VHMSsyd1JJSFEwNkh5emp0V1daV1RSY3ovQ01BdFFpcDFJ?=
 =?utf-8?B?aW1RQVp6VHRoNWJjd2NrOURBVGx6RjNzWldiQm4xNXFHYVN6ajZxZXF6V0th?=
 =?utf-8?B?alAwL094TnJtN3JCK3B5YmhqUlgremdGYlBCdCtQbks0L3V1VEN0bWNsLzg3?=
 =?utf-8?B?cEhhSm12S1JySmw3Uk43SEQ3M1NYbHM5TVdrN09NZDViWWQyMEFBY2MrbE8v?=
 =?utf-8?B?UVF1RDByTmV3allpRWkzalhBK2orTXI1V2RCbUVKeGVjblRaYTlyMXRpMDhD?=
 =?utf-8?B?d2ZQYWxUbStjeXNqemtTSmlOSEhzQXVOUVluM1RDNEo0NUhsRGJDOXhrOTc3?=
 =?utf-8?B?U2pMRG1UVTNlZm5JZGtDN0FaZlR2UlU5TkxqbVdZV1d3T1Rwc25tenNxdnlS?=
 =?utf-8?B?WE5ubVhiREpiZzFObFF1MU9xNGpkTVBPcG1ZYWczeVI2ekFhcG0xcnVFUmVj?=
 =?utf-8?B?THdDY2xtcEd5eFRWQWdmTmExWldkeVZQdGhNckhHei9wTGNPVm9EMy9NWDFJ?=
 =?utf-8?B?dlVSZGRoZEV3N3FIMmV6Q2lOSFRmck1wc0pNTE4wemZRQ29Wek56ZG05RFVt?=
 =?utf-8?B?V3pYZ2h2K1g2K0UyK2VMcG96TVZUZkt5OW1iVE9zSWtIT2ZjdWJuUy96Tk1Q?=
 =?utf-8?B?TnhvbVA4TmZ2ci9tZGV1RS9FTm9KVnM2bmRRdWl5Uk5jUTZEeHJnVVRyVUlO?=
 =?utf-8?B?ZWVBcm44R2tzZXg4VUdkRzJXRzNBaWcvZncwTjRzTTlvMWZtNjM0eGFKWWhH?=
 =?utf-8?B?czQ1V1BiZExXYU9iRkRaSDRGWkRlUlR2MXVIZHg5TlB0dWJTc0FWakN2elhr?=
 =?utf-8?B?QzVCbXZyenF2NEQ3MmZYSnpBdGRYVlJadXhNSEQvWGJiamJmcGdNNk9WRWpn?=
 =?utf-8?B?V3MwNGRNeXBCQXhVQXBNcXhrV0R6bGFmSEtTNlAva0ZKVjVvSldxTkVRVkVr?=
 =?utf-8?B?QmpQWWJxRzJWT0ppSlhuNFdqUGJTek55YllwNzRidUxwSnNJeHRhTVA3NmtB?=
 =?utf-8?B?bDRuenhVUWU1TXNYemxjdTJJY0ZmQUtIOEpaMU43U3BPazBac3ArYkFQVVh4?=
 =?utf-8?B?UUpOOHpLMmZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0lpaUQ3UjlTazNDcTlQVHhRWDYzVjJGVkJHL0RvRC9DOExyUFhFZC91WVpv?=
 =?utf-8?B?cHVJQko0Ymo5ckg2UmQrSFd3VmZqWkRtcXZUdlJJdHc5QlhxV3NmM1Z4d0JW?=
 =?utf-8?B?d0pnRkNWenpIUjZHQmM4NnVGQW1vTjhwWmw0SUVtc2FZdEh6YkRPOWNFY21o?=
 =?utf-8?B?d3ZFSkJNbXJ2NnA4VjFzMS9PYzU0UTNtS2VxMnhkTjFYYUpOUWw5VWNPQklz?=
 =?utf-8?B?dU1ERGg3WWYrQzUvcFR5eGljUkNiVWsyMnNYTXBzbmVlMWJweGQ3OFQ4RDlT?=
 =?utf-8?B?WnlEZU5ISVpKYy9BcmpTQkNmL0ZxckdtUjM2bVVXcEZzYWtjQk5iOGlFdEp0?=
 =?utf-8?B?VWNxaEFBZEhiMnlTSzdMVm84TC9tM3Y4U0svOVJYQlAveUl4eHpLZXVlSzB0?=
 =?utf-8?B?QWIzcTFoTHBFQlFEM0FNd0ZIU2l1UmpCYndYVlp3T2ZSZnhqY29jUitIZTMr?=
 =?utf-8?B?ZUZ3UTJCeEFEa3p6Ylk3NE0zTExxbTZiekRzcjhEZjZlYmRPSkR2clVhSVJx?=
 =?utf-8?B?OFhHbVl5VURjbmhHWnQ4clErZjA4OENjb1NUaVJTdE9USkI3M0ZSelV5THh5?=
 =?utf-8?B?TUZXRlh6SWZSa1h1T2ErdU9SU2xrcGgyVnNCdHRaUzczOVpyOE9IS1FCWlpB?=
 =?utf-8?B?K2M1QStIcFNsM3ExdWxJSkc0akhaOFB5ZTIwM0VnQzE0K2pQQzdwN2FqRXlZ?=
 =?utf-8?B?aHFoVkVXdk9GbWVDZlVtcjliTHNyb0ZMZEs0aEgzK21YWHJ4M3FKQ0hVSXNw?=
 =?utf-8?B?R2h1VjRPNXNBVFY3YWZSZG5nKzFXYmlZK2NBZmNQSHNMVGNReFJRRWJaaWs4?=
 =?utf-8?B?Q01QS2ZiNFhEaHBnVldzUU54T2JNMlVCYUE1MnREYllqVDJud21uOWJQNzJN?=
 =?utf-8?B?RUVNYWlwQ21MVGpuK3prT0c0ZDUvaEcvN1E1YVg4b0ZQOGt2OW16YU9JVmN3?=
 =?utf-8?B?RjFIcmV2bFE2Vm9JdUNDenMwdlN0TFpFY3cwU3R0d2NlUTF0b0FNYmFaZTBa?=
 =?utf-8?B?U3JUT09rQko1ajFPTmdZRUdRUnZVZW5UWGhxeFFlY0l1b0NKZERZNTYxWW43?=
 =?utf-8?B?Z2NtSCs1QWJ4OEIzY2kxVVhjcWJRYnNNOElNVExpeWJ6TjR2NTV2UzJLbi81?=
 =?utf-8?B?elhteXBqbjM0NFdTWS9FazdibzllSldVbjFXN1NTRHZWU01uSlpTZlpjK3Z0?=
 =?utf-8?B?UDdWc2dCbk1JYU1CWjhyejZLSVlaMEVtTUtNVXRqRkY0UDlhL09SSjl2TVhS?=
 =?utf-8?B?bkt3eThYeXljZjdxZlBlOHRQN1JzZDBwK20rNEFDaGgrVWRXdXduNkNZSkJp?=
 =?utf-8?B?aU80RytQYzJObWE3TUYyYnVZYXJ6NGtpQ3cweTFEQkUxSmt0M0FZNmkwdXF0?=
 =?utf-8?B?Q1dPclVjc1pXWDFhTXhEVm5vRTdQUWlvSlpQRWV5VnBTMXIvWUw5MmhrVjhF?=
 =?utf-8?B?SDZMNkYzcko1aU43dTBRanNTZ3p4dDlqVXR1SGdyYnBiNHdsdzZLdy91SU9F?=
 =?utf-8?B?RlR3cWRab3hJNWxZbUFoNDJwMXAvNXVBZ0NTODdkODdzSlBMVlorV0NQdU9I?=
 =?utf-8?B?UlNNOXVQU29TSG9XNmZIR1k4eEE4aGlvNUZoaDVKVmdzcmdkK2g0Q0ZsSi9O?=
 =?utf-8?B?S1hYSHp6Wld1cm5LSWx6TW9jM2M4NDlLYnZZRG5pUTdpUGswWGRGcDhBRmVJ?=
 =?utf-8?B?SVp6STZVMW5PZFdVamZxSVJXNi8xNUhucmtnSy9BZ0p3NTZPd1c4T3BvSGdF?=
 =?utf-8?B?YVU1TllvM3ZvWWhQN3ArWG92TVpJOHFYZFl3eFZORDhzanRaY2JMSkpOZ0Z1?=
 =?utf-8?B?Tjc3U2E3dHVMMm9oTWROdld0T3JZVFpreWhCNWpDZ0pzNmd5b3pPR1RSSjlS?=
 =?utf-8?B?VjFFQWdTOTR1a3VzV0JrMjVqOTVUTU0xUTB6WnZIQ0lTTzk5MTVNV0VpMWlW?=
 =?utf-8?B?aGNUcDFJN3FORGJuUVFSdkVpS0tjOTBLTzFZOVFXSVJvamVGSnFJMTIzY0l2?=
 =?utf-8?B?d1hhc0tBRVJscXBtSmZxNzE1eVoyQ251UlR3eTQyT2I0R0VVN0tGK2VOTUpP?=
 =?utf-8?B?RXlKRER6SHM4bDgvYkNONDQ0Zmh0TWZyZ2x6R3NtN0cyckF3eTdhaG42alVj?=
 =?utf-8?Q?va84K5o6gh87gnj1EAhFzwu/f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC365FAB75A3244AEC4A1F9D294D0DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac9942f-344c-4632-046b-08dd72b2cc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 13:24:01.6209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIVjoUSpGKPrRFnJKU6sxljH3dbyac2AJnOBmDR29Np4o6hNVBWu2YWpeW0MnWnQCqRQXBzZSPpUw3LReW4BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

T24gV2VkLCAyMDI1LTA0LTAyIGF0IDE2OjIwIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDA0LzAyLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4g
Tm90IHN1cmUgaWYgaXQncyByZXBvcnRlZCBhbHJlYWR5LCBidXQgSSBlbmNvdW50ZXJlZCBhIGJ1
ZyB3aGlsZQ0KPiA+IHRlc3Rpbmcgd2l0aCB0aGUgbmV3IGxvY2tpbmcgc2NoZW1lLg0KPiA+IFRo
aXMgaXMgdGhlIGNhbGwgdHJhY2U6DQo+ID4gDQo+ID4gWyAzNDU0Ljk3NTY3Ml0gV0FSTklORzog
Q1BVOiAxIFBJRDogNTgyMzcgYXQNCj4gPiAuL2luY2x1ZGUvbmV0L25ldGRldl9sb2NrLmg6NTQg
aXB2Nl9hZGRfZGV2KzB4MzcwLzB4NjIwDQo+ID4gWyAzNDU1LjAwODc3Nl3CoCA/IGlwdjZfYWRk
X2RldisweDM3MC8weDYyMA0KPiA+IFsgMzQ1NS4wMTAwOTddwqAgaXB2Nl9maW5kX2lkZXYrMHg5
Ni8weGUwDQo+ID4gWyAzNDU1LjAxMDcyNV3CoCBhZGRyY29uZl9hZGRfZGV2KzB4MWUvMHhhMA0K
PiA+IFsgMzQ1NS4wMTEzODJdwqAgYWRkcmNvbmZfaW5pdF9hdXRvX2FkZHJzKzB4YjAvMHg3MjAN
Cj4gPiBbIDM0NTUuMDEzNTM3XcKgIGFkZHJjb25mX25vdGlmeSsweDM1Zi8weDhkMA0KPiA+IFsg
MzQ1NS4wMTQyMTRdwqAgbm90aWZpZXJfY2FsbF9jaGFpbisweDM4LzB4ZjANCj4gPiBbIDM0NTUu
MDE0OTAzXcKgIG5ldGRldl9zdGF0ZV9jaGFuZ2UrMHg2NS8weDkwDQo+ID4gWyAzNDU1LjAxNTU4
Nl3CoCBsaW5rd2F0Y2hfZG9fZGV2KzB4NWEvMHg3MA0KPiA+IFsgMzQ1NS4wMTYyMzhdwqAgcnRu
bF9nZXRsaW5rKzB4MjQxLzB4M2UwDQo+ID4gWyAzNDU1LjAxOTA0Nl3CoCBydG5ldGxpbmtfcmN2
X21zZysweDE3Ny8weDVlMA0KPiA+IA0KPiA+IFRoZSBjYWxsIGNoYWluIGlzIHJ0bmxfZ2V0bGlu
ayAtPiBsaW5rd2F0Y2hfc3luY19kZXYgLT4NCj4gPiBsaW5rd2F0Y2hfZG9fZGV2IC0+IG5ldGRl
dl9zdGF0ZV9jaGFuZ2UgLT4gLi4uDQo+ID4gDQo+ID4gTm90aGluZyBvbiB0aGlzIHBhdGggYWNx
dWlyZXMgdGhlIG5ldGRldiBsb2NrLCByZXN1bHRpbmcgaW4gYQ0KPiA+IHdhcm5pbmcuDQo+ID4g
UGVyaGFwcyBydG5sX2dldGxpbmsgc2hvdWxkIGFjcXVpcmUgaXQsIGluIGFkZGl0aW9uIHRvIHRo
ZSBSVE5MDQo+ID4gYWxyZWFkeQ0KPiA+IGhlbGQgYnkgcnRuZXRsaW5rX3Jjdl9tc2c/DQo+ID4g
DQo+ID4gVGhlIHNhbWUgdGhpbmcgY2FuIGJlIHNlZW4gZnJvbSB0aGUgcmVndWxhciBsaW5rd2F0
Y2ggd3E6DQo+ID4gDQo+ID4gWyAzNDU2LjYzNzAxNF0gV0FSTklORzogQ1BVOiAxNiBQSUQ6IDgz
MjU3IGF0DQo+ID4gLi9pbmNsdWRlL25ldC9uZXRkZXZfbG9jay5oOjU0IGlwdjZfYWRkX2Rldisw
eDM3MC8weDYyMA0KPiA+IFsgMzQ1Ni42NTUzMDVdIENhbGwgVHJhY2U6DQo+ID4gWyAzNDU2LjY1
NTYxMF3CoCA8VEFTSz4NCj4gPiBbIDM0NTYuNjU1ODkwXcKgID8gX193YXJuKzB4ODkvMHgxYjAN
Cj4gPiBbIDM0NTYuNjU2MjYxXcKgID8gaXB2Nl9hZGRfZGV2KzB4MzcwLzB4NjIwDQo+ID4gWyAz
NDU2LjY2MDAzOV3CoCBpcHY2X2ZpbmRfaWRldisweDk2LzB4ZTANCj4gPiBbIDM0NTYuNjYwNDQ1
XcKgIGFkZHJjb25mX2FkZF9kZXYrMHgxZS8weGEwDQo+ID4gWyAzNDU2LjY2MDg2MV3CoCBhZGRy
Y29uZl9pbml0X2F1dG9fYWRkcnMrMHhiMC8weDcyMA0KPiA+IFsgMzQ1Ni42NjE4MDNdwqAgYWRk
cmNvbmZfbm90aWZ5KzB4MzVmLzB4OGQwDQo+ID4gWyAzNDU2LjY2MjIzNl3CoCBub3RpZmllcl9j
YWxsX2NoYWluKzB4MzgvMHhmMA0KPiA+IFsgMzQ1Ni42NjI2NzZdwqAgbmV0ZGV2X3N0YXRlX2No
YW5nZSsweDY1LzB4OTANCj4gPiBbIDM0NTYuNjYzMTEyXcKgIGxpbmt3YXRjaF9kb19kZXYrMHg1
YS8weDcwDQo+ID4gWyAzNDU2LjY2MzUyOV3CoCBfX2xpbmt3YXRjaF9ydW5fcXVldWUrMHhlYi8w
eDIwMA0KPiA+IFsgMzQ1Ni42NjM5OTBdwqAgbGlua3dhdGNoX2V2ZW50KzB4MjEvMHgzMA0KPiA+
IFsgMzQ1Ni42NjQzOTldwqAgcHJvY2Vzc19vbmVfd29yaysweDIxMS8weDYxMA0KPiA+IFsgMzQ1
Ni42NjQ4MjhdwqAgd29ya2VyX3RocmVhZCsweDFjYy8weDM4MA0KPiA+IFsgMzQ1Ni42NjU2OTFd
wqAga3RocmVhZCsweGY0LzB4MjEwDQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCBfX2xpbmt3YXRj
aF9ydW5fcXVldWUgc2VlbXMgbGlrZSBhIGdvb2QgcGxhY2UgdG8gZ3JhYg0KPiA+IGENCj4gPiBk
ZXZpY2UgbG9jayBiZWZvcmUgY2FsbGluZyBsaW5rd2F0Y2hfZG9fZGV2Lg0KPiANCj4gVGhhbmtz
IGZvciB0aGUgcmVwb3J0ISBXaGF0IGFib3V0IGxpbmt3YXRjaF9zeW5jX2RldiBpbg0KPiBuZXRk
ZXZfcnVuX3RvZG8NCj4gYW5kIGNhcnJpZXJfc2hvdz8gU2hvdWxkIHByb2JhYmx5IGFsc28gbmVl
ZCB0byBiZSB3cmFwcGVkPw0KDQpEb25lLCBoZXJlJ3MgdGhlIHBhdGNoIEknbSB0ZXN0aW5nIHdp
dGggd2hpY2ggd29ya3MgZm9yIGFsbCB0ZXN0cyBJDQpjb3VsZCBnZXQgbXkgaGFuZHMgb24uIFdp
bGwgeW91IG9mZmljaWFsbHkgcHJvcG9zZSBpdCAobWF5YmUgaW4gYQ0Kc2xpZ2h0bHkgZGlmZmVy
ZW50IGZvcm0pIHBsZWFzZT8NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpsaW5rd2F0
Y2ggY2FuIGVuZCB1cCBjYWxsaW5nIHRoZSBJUHY2IGFkZHJjb25mIG5vdGlmaWVyLCB3aGljaCBt
aWdodA0KZW5kDQp1cCBjYWxsaW5nIGlwdjZfYWRkX2RldiB3aGljaCByZXF1aXJlcyBob2xkaW5n
IHRoZSBuZXRkZXYgbG9jay4NCg0KVGhpcyBwYXRjaCBtYWtlcyBzdXJlIHRoYXQgdGhlIG5ldGRl
diBpbnN0YW5jZSBsb2NrIGlzIGhlbGQgb24gYWxsIGNhbGwNCnBhdGhzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0KQ2hhbmdlLUlkOiBJZWY4MjFj
ZjA2OTQwOGNlY2M4MmFkYWEwMWNhZmEwNDYyYzUxOTA4YQ0KLS0tDQogbmV0L2NvcmUvZGV2LmMg
ICAgICAgIHwgMiArLQ0KIG5ldC9jb3JlL2xpbmtfd2F0Y2guYyB8IDIgKysNCiBuZXQvY29yZS9u
ZXQtc3lzZnMuYyAgfCAyICsrDQogbmV0L2NvcmUvcnRuZXRsaW5rLmMgIHwgMiArKw0KIDQgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9uZXQvY29yZS9kZXYuYyBiL25ldC9jb3JlL2Rldi5jDQppbmRleCA4N2NiYTkzZmE1OWYuLjFi
OWVlMjgyODA3NiAxMDA2NDQNCi0tLSBhL25ldC9jb3JlL2Rldi5jDQorKysgYi9uZXQvY29yZS9k
ZXYuYw0KQEAgLTExMzQzLDggKzExMzQzLDggQEAgdm9pZCBuZXRkZXZfcnVuX3RvZG8odm9pZCkN
CiANCiAJCW5ldGRldl9sb2NrKGRldik7DQogCQlXUklURV9PTkNFKGRldi0+cmVnX3N0YXRlLCBO
RVRSRUdfVU5SRUdJU1RFUkVEKTsNCi0JCW5ldGRldl91bmxvY2soZGV2KTsNCiAJCWxpbmt3YXRj
aF9zeW5jX2RldihkZXYpOw0KKwkJbmV0ZGV2X3VubG9jayhkZXYpOw0KIAl9DQogDQogCWNudCA9
IDA7DQpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvbGlua193YXRjaC5jIGIvbmV0L2NvcmUvbGlua193
YXRjaC5jDQppbmRleCBjYjA0ZWYyYjk4MDcuLjAwMmYxOGIxMWQ4NSAxMDA2NDQNCi0tLSBhL25l
dC9jb3JlL2xpbmtfd2F0Y2guYw0KKysrIGIvbmV0L2NvcmUvbGlua193YXRjaC5jDQpAQCAtMjQw
LDcgKzI0MCw5IEBAIHN0YXRpYyB2b2lkIF9fbGlua3dhdGNoX3J1bl9xdWV1ZShpbnQgdXJnZW50
X29ubHkpDQogCQkgKi8NCiAJCW5ldGRldl90cmFja2VyX2ZyZWUoZGV2LCAmZGV2LT5saW5rd2F0
Y2hfZGV2X3RyYWNrZXIpOw0KIAkJc3Bpbl91bmxvY2tfaXJxKCZsd2V2ZW50bGlzdF9sb2NrKTsN
CisJCW5ldGRldl9sb2NrX29wcyhkZXYpOw0KIAkJbGlua3dhdGNoX2RvX2RldihkZXYpOw0KKwkJ
bmV0ZGV2X3VubG9ja19vcHMoZGV2KTsNCiAJCWRvX2Rldi0tOw0KIAkJc3Bpbl9sb2NrX2lycSgm
bHdldmVudGxpc3RfbG9jayk7DQogCX0NCmRpZmYgLS1naXQgYS9uZXQvY29yZS9uZXQtc3lzZnMu
YyBiL25ldC9jb3JlL25ldC1zeXNmcy5jDQppbmRleCAxYWNlMGNkMDFhZGMuLjkyY2ZmYjIzMzMw
NiAxMDA2NDQNCi0tLSBhL25ldC9jb3JlL25ldC1zeXNmcy5jDQorKysgYi9uZXQvY29yZS9uZXQt
c3lzZnMuYw0KQEAgLTMyNSw3ICszMjUsOSBAQCBzdGF0aWMgc3NpemVfdCBjYXJyaWVyX3Nob3co
c3RydWN0IGRldmljZSAqZGV2LA0KIAkJLyogU3luY2hyb25pemUgY2FycmllciBzdGF0ZSB3aXRo
IGxpbmsgd2F0Y2gsDQogCQkgKiBzZWUgYWxzbyBydG5sX2dldGxpbmsoKS4NCiAJCSAqLw0KKwkJ
bmV0ZGV2X2xvY2tfb3BzKG5ldGRldik7DQogCQlsaW5rd2F0Y2hfc3luY19kZXYobmV0ZGV2KTsN
CisJCW5ldGRldl91bmxvY2tfb3BzKG5ldGRldik7DQogDQogCQlyZXQgPSBzeXNmc19lbWl0KGJ1
ZiwgZm10X2RlYywNCiEhbmV0aWZfY2Fycmllcl9vayhuZXRkZXYpKTsNCiAJfQ0KZGlmZiAtLWdp
dCBhL25ldC9jb3JlL3J0bmV0bGluay5jIGIvbmV0L2NvcmUvcnRuZXRsaW5rLmMNCmluZGV4IGU0
YzkzZjg3ZjVkNC4uMmNiMjhhM2QwZDIwIDEwMDY0NA0KLS0tIGEvbmV0L2NvcmUvcnRuZXRsaW5r
LmMNCisrKyBiL25ldC9jb3JlL3J0bmV0bGluay5jDQpAQCAtNDE3NSw3ICs0MTc1LDkgQEAgc3Rh
dGljIGludCBydG5sX2dldGxpbmsoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCnN0cnVjdCBubG1zZ2hk
ciAqbmxoLA0KIAkgKiBvbmx5IFRYIGlmIGxpbmsgd2F0Y2ggd29yayBoYXMgcnVuLCBidXQgd2l0
aG91dCB0aGlzIHdlJ2QNCiAJICogYWxyZWFkeSByZXBvcnQgY2FycmllciBvbiwgZXZlbiBpZiBp
dCBkb2Vzbid0IHdvcmsgeWV0Lg0KIAkgKi8NCisJbmV0ZGV2X2xvY2tfb3BzKGRldik7DQogCWxp
bmt3YXRjaF9zeW5jX2RldihkZXYpOw0KKwluZXRkZXZfdW5sb2NrX29wcyhkZXYpOw0KIA0KIAll
cnIgPSBydG5sX2ZpbGxfaWZpbmZvKG5za2IsIGRldiwgbmV0LA0KIAkJCSAgICAgICBSVE1fTkVX
TElOSywgTkVUTElOS19DQihza2IpLnBvcnRpZCwNCi0tIA0KMi40NS4wDQoNCg==

