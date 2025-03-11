Return-Path: <netdev+bounces-173768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE7FA5B990
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5BF3A8A9E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B28B2206A7;
	Tue, 11 Mar 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BU1HP4Pl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFA2557C;
	Tue, 11 Mar 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677002; cv=fail; b=EXNDf0i6JvKoAsa2k4Y0CgHdmx40QQ8K/8kckRqXQ9m/MU5X8VGVXpHJjSohChDfNLUCSb5EilJLlpryGvm6w4p7AdGtA8eiwziTq0RTdnu6bkdE4S6pYW+ywSuV2vXPNCH+lh3j8as+8hPw90WHhwHTRzf1ChB23Ltm7BB5pCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677002; c=relaxed/simple;
	bh=RmdwT9nV/eRZ48tXEyNy2Y6/7X2EcunNdyDljXc01uo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EkgSIJRsRVjAtmzRHjfQuje2LeaxvLqTZ24NBgBjy7XiImRaNRJX9hMvcVNs2GoFebsp90B4pryGSUjrAVzNjLnT0G162On7nt4gJVXyunRTs7xGOx8rRdIsTluz+Dj3oR5LpNv6XEU2MToi9pLH0tKqZU9EtkGHgvGXzbDUI48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BU1HP4Pl; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfThUaXdun2lD6FmmRzd3FINA7Is/PiD5kBtxiWoVLpQAWcZmN6eHl3ipiJH0x3rZJnmyXKJqS5riU7dc3sdhPeI74rz8MqPcVXTHQBMEgWZV9CeBSqLpH6ZnmgGmTGyUclO2lYOkHq+Q+BrC1tI8EtiwM0m6/TEgFw4hXEmrNrkQMO6TqRiVC8elFbPJ6RDJWmoi7iHQoh/lXOrORFpPYwUMbN2RE+6c5WHGlDBpcyAehw+gnWqq3ktdl4SLmbfYPAebBHCoWPuuIz6Ede9RucEEn9pMJkxtehUJ+wHyd2f7LPBoyUMhhNULKxeo0kvJDxYWHUONcjUoWvn3dyJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmdwT9nV/eRZ48tXEyNy2Y6/7X2EcunNdyDljXc01uo=;
 b=WI9lBJVjUKhNKpqti9X41b3+57QMvZCiccpnsvCmo9J1dCAm/t2YrE8znHxSb02QT2/OitjILyrbeKfAqsccOsjo03o724kdRYoZuY4VzKgbKiOxVJ7IWmvrLJjjE4T0B/NJcFkt4+rtDHlxd/+GndD3Mk8x0q7MhKYtsOzFBleCq6RK/eEy4SMgp+mcroPebbu7kgsE+GGAhCsiBBypz2+dnVmtAPc2M4Ts2MiuTW1lZE+Q5We/5GF0I7lYqTq1fes6wY3k0FaBVnWxRpnuMm5w6bLmytbR5SXATZyAbfXMxclTpjuWIPCj1e6uhj7+bjKLipdoNTxjigQwufWDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmdwT9nV/eRZ48tXEyNy2Y6/7X2EcunNdyDljXc01uo=;
 b=BU1HP4PlR8MDkbaqiywDNpeRgDpw++dQ4SVNIWMj0EPggJ0jMKTj8930PspNGutpjcQxVeCSFqD9X1EO7WSqMHHousEH7/TyGyDDQyWUshPJtKzbrt6TnyZvLZ+IyAepmGuPzat79iKlJFrQxhYPRwW7K7BqmzuG7pfTVEe2YdRVd4V4O9SFZDbKtcGvgCjBDtF7vqdlJjXwpLqvOsSfO6qaxGpb+3+kIL6gey5atEGyGcstBEIB6/72MsQh5Fb4eYbqk2RG4cLEVsdx8mdvpf/buwTCKTVQyeemdOZ0Qe0leEkFgfjPNY4LQyYBoQMk1aXyPk5CN6+6KWlkeUwWLQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB6612.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:09:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:09:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "jpanis@baylibre.com"
	<jpanis@baylibre.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Thread-Topic: [PATCH net] net: ethernet: ti: am65-cpsw: Fix NAPI registration
 sequence
Thread-Index: AQHbkkyd/vgmW1tIRk2UfG0M1eu7tLNthJWA
Date: Tue, 11 Mar 2025 07:09:56 +0000
Message-ID: <421a4c67865215927897e16866814bd6eb68a89d.camel@siemens.com>
References: <20250311061214.4111634-1-s-vadapalli@ti.com>
In-Reply-To: <20250311061214.4111634-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB6612:EE_
x-ms-office365-filtering-correlation-id: ede6a435-5716-45a4-6e3d-08dd606bbaac
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXVPYjQ5OFV5azRTc3VsOFdlcGZ2MTA0dzIrbUVBZVE0b2RDOXRyaDlTTWhL?=
 =?utf-8?B?b0hPc3pMc3g0aVo4czFXWlVKSXM4dXRVWUVlY1BHN3RsWjBpSTJMa2trZGVm?=
 =?utf-8?B?WkM2bEYrcnRJbld6bldEYVF5V2VLWnRXUEhwdWlHWVBWUHp1NnVNNlZPUWtC?=
 =?utf-8?B?SERCVFFKdXNjcGpYbllDOEdHRnF6dzdIWjJIcmNQQ0kzdTdQVjUyc21TbEtz?=
 =?utf-8?B?bm9pbDhqK3c5MzdqVmhTck10azBNakJWbGtYaTlBditLWXJQVFFadUZpRTAy?=
 =?utf-8?B?N2ZrQ0ltcVhuL3BhVjl1RzlqMnF3V1kzVUFXUVpoUmpsaDUxblFmTG9XbnpS?=
 =?utf-8?B?T0k2QWxidGRFYkVXRFNvc2g0UW15L1hKVGdBK0R4czJuTDBudlMrV2tFQTRE?=
 =?utf-8?B?Yi83TERUV1ZWL29VZ01KZE41bkYzYnAvZWh5YnY4am14VGdCS2dCd21oV3pF?=
 =?utf-8?B?T1dNcjQ2M1AvWnFyWlE2d011LzF5WThNZzdtclZNV2VDcEQ5SndnaW9pN1BV?=
 =?utf-8?B?elNjK243RU5YUHYrYitCS2cvSUVZTzliRFpvS2J1YThBS2JRQ2hsRW9mRHk1?=
 =?utf-8?B?YTZidnN4Q1gxZmYrTkpiY2dPZkFCNDdGb3RVazFhZE5zK1VEVkhBTHlhT2JR?=
 =?utf-8?B?VmlKUUdjMTlMZFc2OURPR2RONmdSTytEYkMvUkt5S3doUE5WVEtuMVBzVGFu?=
 =?utf-8?B?ZHhUL0gvNVlaS05yMVZHdUpmcjJ1TEFLS3FIeWpyU21LcDdHa0U4VENLN2ZU?=
 =?utf-8?B?Snc3NU9iZk5JTytnY1FZbHd3ejZ4MkdHZHlEWmgzWEJqcFQyeGQzUFhwMzBJ?=
 =?utf-8?B?T0VhakZYd2pkMFJsdDRtTGlVczJtVXA1QkJKTXpDNDZKeXVBeFUzNW9pRzNR?=
 =?utf-8?B?UTBZK3FsNVJWb1FHUkQyZGhpRkEvNHFZMVIyaS96RUtqTVVudlV1ODcwdmpv?=
 =?utf-8?B?eHBKYmlXRm00SlhOaUt6WXRFT05lTjFsTENVNmQxdHk1dSt6Q0k2T3FTa2tU?=
 =?utf-8?B?eUNoL1BlUE9XSFlJOGFZQTVEWi8xRGRKU3UzSEcyS2lpaFA3QUY3L0JpbWtS?=
 =?utf-8?B?bFZ2QXhYTUc1bnF4WU1heFNyUmdNSGxoWUo3Vm9pUVA1WG5UV2VCelB4UTVZ?=
 =?utf-8?B?SmNPYU55NURlazBzYUdpeUdSb0hpbTNTaks1WTd5aVRvdGs5ek5tTHFEcWV6?=
 =?utf-8?B?dTIxTmp6NTIyejRvNWoxR2ZVWnEzeDcxOHhYTHhSc1lyVnR1Nm9zOWFnWFMw?=
 =?utf-8?B?L1pqMkVPUnZrTDBpZzlBcjlXSXZHaDA0THpLMzZ1NmNMazVxSUx5a0E0dmtY?=
 =?utf-8?B?SG4yeitVSDI2dU1PbWFack0vWEV5Z2Jkblg4RENPUjZCcGlMUEtzT2ZEeU44?=
 =?utf-8?B?VEUrZkdkSW5Wb0RBWUZGZmlySFhvQzJ5bUJnLzJ4elBZTDFnK3RrU2VvSXZY?=
 =?utf-8?B?THB3YmNhVkNZM1pQMytZZy8wTXJiQ25UUU56NkdSWTFBVU5sS3pqNkRCN1dJ?=
 =?utf-8?B?TWY4NVUvTmFyQVhqTVZyL0czTHlCTnFxSm9pNXUxTklvT2trUlc2VVZIbnhz?=
 =?utf-8?B?dzlxK1pZWWpqM045OEhZKzFsTlo5b1V4YzZYb0tia0l0RnUzV2huMGMxNWFQ?=
 =?utf-8?B?dGMrSnkxK2ZIcDk1b0NabUhlUE93NG9QQ0dXQXFua3Nha3JBNzFQeE1XcHdR?=
 =?utf-8?B?dSt4WFZOUlRqT05sQU9FbTQrOFgrTUN3QkpJMnFnaEszN2xyMEwrTDZPWUph?=
 =?utf-8?B?cjMwNmRTN1BmMTdKV2lna0VTRHkrUFpJQmJ4aGlvZXdSK3NtV0o5aVBKSVpi?=
 =?utf-8?B?S3lRVVhtdGhKUHByK0VsT0NzUEdGNHY1eFJYSEhXWlNoTDlheENsMUdSMm5P?=
 =?utf-8?B?VkhBYlZvK1ZLQjkvZk45QnFYU1l6SUNsUFZJK1FGYU5OZUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bE83aFowN2pWVHZYdEVHQ2RlUFJ5WC85dm9SNFlnSnJWeldzY09tWm9CQjht?=
 =?utf-8?B?ZnpuU3NDSTVzbU9pejkrdVJ3SjNDNzdxbS9KeGswV2t5dHlDdjNmZXVtUTRo?=
 =?utf-8?B?VmZYRUw3WDFFblhDZERSSXM2ZUtudkNucUZIejhkY1VyenQwRFFLNE54U1Nt?=
 =?utf-8?B?LzFIbWxRQk52d0QwZWF6SmFyVjNjZUhLL2lrYkhaanJFbWlKSURkc1l4a1pz?=
 =?utf-8?B?QkFaaSthU0dvNGF0UHQ1TDdZcXozS05EN2poelp3M1dVYW8zTERET043ZGw5?=
 =?utf-8?B?ckg4ZkhsTGNLUUhrRW9vOEdzZk55dzdoYzVsc21qNkFTYjgrVW5IK0xYbmVk?=
 =?utf-8?B?cDZNT1VLcHdvZXJ1T2NEaXpvaDcyMk45ZmdaMDZFOVpFNXhKUUNVK3Q5clI0?=
 =?utf-8?B?a21EaGwwd2RMR1BDOHVuNDM1M090dWgreHRvY0s2M1hnOC95R3ozVEdZWlEw?=
 =?utf-8?B?UU5mNDVYUE55S3FVUkxxV3paRUphWlVQTElmajlJVVVMa1h4WGI1ZUEyYnBa?=
 =?utf-8?B?U0hSanZJOHFOWGY5NEVGSzVhNXp0eWVXUW9NcDZ3V2FGbWVubDRzRzFtNlp2?=
 =?utf-8?B?K0dXTlJyMlltY0MxRzk3RitNKysyWmsvYU9QRTVmbis5UWdULzk5L0VwYTZV?=
 =?utf-8?B?MWJ4NHplWUNuajd1SGQxV0o0YUl2czRWdDhLcVBnZXphaEpCOHpRa0xQYXY1?=
 =?utf-8?B?R1U3U3MxanNWVnphRmVWU2pzNXNIc1JqVnJ4aUYwNEFjT3k1YXJSbTFVTFU5?=
 =?utf-8?B?Z3NjL2VFVVoveE5TTW80NXZkTDRubDdvYlpRaGxLZDVVUXMvOVB1NktKaTNR?=
 =?utf-8?B?V3pyR2VDZnV4RkNrWllLMWJHS01pdldFNXVEdk9vM3FaYXdad0hQSERTUk8x?=
 =?utf-8?B?ZXBnR0pDSW1WSzJkZXRhQVZsNis3UEN3TUk1ZnlDUWRUQWpzeTgvU3grakNw?=
 =?utf-8?B?NllBVkhIMWNFRkxlc3BoTjYzekNFRGh0ZUVqbW1KT0w1aXpSU1hicFFxUjhp?=
 =?utf-8?B?Y1dLdDhqL2NKYUVIUFBpN1BVS29oSEFLZWMvZFNyNjk0L3hHcEZKWC9wNjU3?=
 =?utf-8?B?eWdGZzh4TGNxTEZySVM1SDNWbTJRMHU4b215SVJRb0taQnBPckM0Yng1L3cw?=
 =?utf-8?B?Y2tNMmFpenN1Y0Jqd1NBZUxRVVBhR2pTcXIwZ3g5b3JJZ0kyV1p4amdHKytB?=
 =?utf-8?B?aVdHT3QvSVZES0RiTm42Q1JpYlF4RjZFbmxlZGdxWm5ldFJNQW5hbkV1RWtE?=
 =?utf-8?B?WmdMSktRaUxESjBzSjZCSDJSQ3dHek5vZ1FsMVZyKzlKVzN1Tk1lZVJSbmNv?=
 =?utf-8?B?SFRrUjRqQ2JsMGxhdWg4WDE0VG02c096QW9MdGt1MHljWXR0NU5TSFI1U3FT?=
 =?utf-8?B?VVFWL3RkSVNrd3IzVFVZY3ZIZmNHdnNobFI2OHpSeExJZWp6aVFLbnROelBJ?=
 =?utf-8?B?Lzg5d1hVcjMrVC80SStzMUNpQ2JwUXdTTytzSjE2b1dQZmVBQzBSVmdsbTY4?=
 =?utf-8?B?Zm1COE9sYzZSQVBoRmJrU01oZURGd042YkZ2QkR2RTdsdVA5WllXRTRXUTRt?=
 =?utf-8?B?SjVkU0Z4a2RmOE0ybmFNQ1c0YUw4Y0ZxL2JLaW5qVXJ0aXFKYWxXRk9OUzM1?=
 =?utf-8?B?QkloODhLN1Bmbi8xSVRFbmVhdzlTaERvTFBGU0p1NUlpSEhVZnRkUVNjeVZ3?=
 =?utf-8?B?d0UxVHluNmZUay9lQU9xREs4T1pyVUljSFVUU3RNQlB5WVB5RHkxM3ArYVU0?=
 =?utf-8?B?QTBmOXhTZmxtd2p0bG9Db3FmNGZObERVOEM4dTRIUnkzaXVMTUl3MzVBdjM0?=
 =?utf-8?B?anNBQUlKOW9tSEhMN0Z6c1U4V0FJbDgya3ZNQnpINUlPNkkzK09YTTg0c0lL?=
 =?utf-8?B?RzRpS3hRQ0x3Skx2UkY1MC9kaksrR3JhK0ZXd3FGODJ1UFJGSEpNcFFYV1Y3?=
 =?utf-8?B?WjRTYkgrQ0thZ2NHWWd3UktjWHFhbHRFTTUxQ1JLbWdIRVBJdytybG4vRTZ2?=
 =?utf-8?B?alExOTkzcFN1SlpmY015ay9KeDlPd0VBTVJGVGVZN1NkSWw5bWxzdExBN2JS?=
 =?utf-8?B?aUFaQ05JVEZkYldMTU1BSm5ranJ6dEdMMzFIVDY2RnVpa3VkSmx6U1BuYU03?=
 =?utf-8?B?cEFlakFYdnR3dk1udWdRcFNNRkFwTXdUL2M2RVhDWW9sRlhqTE1yWm5iam14?=
 =?utf-8?Q?z4sB4es1qOSynH1JjGdmblA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C78EB220587346A816F563F359D286@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ede6a435-5716-45a4-6e3d-08dd606bbaac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:09:56.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p/QzJOW6d8cCuMRT/P2ztU2MnIzIOklUoWNGMZYwV3KwiGd+LOo3n2m4JCvOA2OzrLWPBM2DiHXFT95x2vntulpUZkwBDrj2t5I5f19Vbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6612

SGkgU2lkZGhhcnRoIQ0KDQpPbiBUdWUsIDIwMjUtMDMtMTEgYXQgMTE6NDIgKzA1MzAsIFNpZGRo
YXJ0aCBWYWRhcGFsbGkgd3JvdGU6DQo+IEZyb206IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25l
c2hyQHRpLmNvbT4NCj4gDQo+IFJlZ2lzdGVyaW5nIHRoZSBpbnRlcnJ1cHRzIGZvciBUWCBvciBS
WCBETUEgQ2hhbm5lbHMgcHJpb3IgdG8gcmVnaXN0ZXJpbmcNCj4gdGhlaXIgcmVzcGVjdGl2ZSBO
QVBJIGNhbGxiYWNrcyBjYW4gcmVzdWx0IGluIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0K
PiBUaGlzIGlzIHNlZW4gaW4gcHJhY3RpY2UgYXMgYSByYW5kb20gb2NjdXJyZW5jZSBzaW5jZSBp
dCBkZXBlbmRzIG9uIHRoZQ0KPiByYW5kb21uZXNzIGFzc29jaWF0ZWQgd2l0aCB0aGUgZ2VuZXJh
dGlvbiBvZiB0cmFmZmljIGJ5IExpbnV4IGFuZCB0aGUNCj4gcmVjZXB0aW9uIG9mIHRyYWZmaWMg
ZnJvbSB0aGUgd2lyZS4NCj4gDQo+IEZpeGVzOiA2ODFlYjJiZWIzZWYgKCJuZXQ6IGV0aGVybmV0
OiB0aTogYW02NS1jcHN3OiBlbnN1cmUgcHJvcGVyIGNoYW5uZWwgY2xlYW51cCBpbiBlcnJvciBw
YXRoIikNCg0KVGhlIHBhdGNoIFZpZ25lc2ggbWVudGlvbnMgaGVyZS4uLg0KDQo+IFNpZ25lZC1v
ZmYtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4gQ28tZGV2ZWxv
cGVkLWJ5OiBTaWRkaGFydGggVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gLS0t
DQo+IA0KPiBIZWxsbywNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gY29tbWl0DQo+IDRk
ODcyZDUxYmM5ZCBNZXJnZSB0YWcgJ3g4Ni11cmdlbnQtMjAyNS0wMy0xMCcgb2YgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXANCj4gb2YgTWFpbmxp
bmUgTGludXguDQo+IA0KPiBSZWdhcmRzLA0KPiBTaWRkaGFydGguDQo+IA0KPiDCoGRyaXZlcnMv
bmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgfCAxMiArKysrKystLS0tLS0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+IGluZGV4IDI4MDYyMzg2Mjlm
OC4uZDUyOTEyODFjNzgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9h
bTY1LWNwc3ctbnVzcy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bz
dy1udXNzLmMNCj4gQEAgLTIzMTQsNiArMjMxNCw5IEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X251
c3NfbmRldl9hZGRfdHhfbmFwaShzdHJ1Y3QgYW02NV9jcHN3X2NvbW1vbiAqY29tbW9uKQ0KPiDC
oAkJaHJ0aW1lcl9pbml0KCZ0eF9jaG4tPnR4X2hydGltZXIsIENMT0NLX01PTk9UT05JQywgSFJU
SU1FUl9NT0RFX1JFTF9QSU5ORUQpOw0KPiDCoAkJdHhfY2huLT50eF9ocnRpbWVyLmZ1bmN0aW9u
ID0gJmFtNjVfY3Bzd19udXNzX3R4X3RpbWVyX2NhbGxiYWNrOw0KPiDCoA0KPiArCQluZXRpZl9u
YXBpX2FkZF90eChjb21tb24tPmRtYV9uZGV2LCAmdHhfY2huLT5uYXBpX3R4LA0KPiArCQkJCcKg
IGFtNjVfY3Bzd19udXNzX3R4X3BvbGwpOw0KPiArDQo+IMKgCQlyZXQgPSBkZXZtX3JlcXVlc3Rf
aXJxKGRldiwgdHhfY2huLT5pcnEsDQo+IMKgCQkJCcKgwqDCoMKgwqDCoCBhbTY1X2Nwc3dfbnVz
c190eF9pcnEsDQo+IMKgCQkJCcKgwqDCoMKgwqDCoCBJUlFGX1RSSUdHRVJfSElHSCwNCj4gQEAg
LTIzMjMsOSArMjMyNiw2IEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X251c3NfbmRldl9hZGRfdHhf
bmFwaShzdHJ1Y3QgYW02NV9jcHN3X2NvbW1vbiAqY29tbW9uKQ0KPiDCoAkJCQl0eF9jaG4tPmlk
LCB0eF9jaG4tPmlycSwgcmV0KTsNCj4gwqAJCQlnb3RvIGVycjsNCj4gwqAJCX0NCj4gLQ0KPiAt
CQluZXRpZl9uYXBpX2FkZF90eChjb21tb24tPmRtYV9uZGV2LCAmdHhfY2huLT5uYXBpX3R4LA0K
PiAtCQkJCcKgIGFtNjVfY3Bzd19udXNzX3R4X3BvbGwpOw0KDQouLi4gaGFzIGFjY291bnRlZCBm
b3IgdGhlIGZhY3QgLi4uX25hcGlfYWRkXy4uLiBoYXBwZW5zIGFmdGVyIFtwb3NzaWJseSB1bnN1
Y2Nlc3NmdWxdIHJlcXVlc3RfaXJxLA0KcGxlYXNlIGdyZXAgZm9yICJmb3IgKC0taSA7Ii4gSXMg
aXQgbmVjZXNzYXJ5IHRvIGFkanVzdCBib3RoIGxvb3BzLCBpbiB0aGUgYmVsb3cgY2FzZSB0b28/
DQoNCj4gwqAJfQ0KPiDCoA0KPiDCoAlyZXR1cm4gMDsNCj4gQEAgLTI1NjksNiArMjU2OSw5IEBA
IHN0YXRpYyBpbnQgYW02NV9jcHN3X251c3NfaW5pdF9yeF9jaG5zKHN0cnVjdCBhbTY1X2Nwc3df
Y29tbW9uICpjb21tb24pDQo+IMKgCQkJwqDCoMKgwqAgSFJUSU1FUl9NT0RFX1JFTF9QSU5ORUQp
Ow0KPiDCoAkJZmxvdy0+cnhfaHJ0aW1lci5mdW5jdGlvbiA9ICZhbTY1X2Nwc3dfbnVzc19yeF90
aW1lcl9jYWxsYmFjazsNCj4gwqANCj4gKwkJbmV0aWZfbmFwaV9hZGQoY29tbW9uLT5kbWFfbmRl
diwgJmZsb3ctPm5hcGlfcngsDQo+ICsJCQnCoMKgwqDCoMKgwqAgYW02NV9jcHN3X251c3Nfcnhf
cG9sbCk7DQo+ICsNCj4gwqAJCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBmbG93LT5pcnEs
DQo+IMKgCQkJCcKgwqDCoMKgwqDCoCBhbTY1X2Nwc3dfbnVzc19yeF9pcnEsDQo+IMKgCQkJCcKg
wqDCoMKgwqDCoCBJUlFGX1RSSUdHRVJfSElHSCwNCj4gQEAgLTI1NzksOSArMjU4Miw2IEBAIHN0
YXRpYyBpbnQgYW02NV9jcHN3X251c3NfaW5pdF9yeF9jaG5zKHN0cnVjdCBhbTY1X2Nwc3dfY29t
bW9uICpjb21tb24pDQo+IMKgCQkJZmxvdy0+aXJxID0gLUVJTlZBTDsNCj4gwqAJCQlnb3RvIGVy
cl9mbG93Ow0KPiDCoAkJfQ0KPiAtDQo+IC0JCW5ldGlmX25hcGlfYWRkKGNvbW1vbi0+ZG1hX25k
ZXYsICZmbG93LT5uYXBpX3J4LA0KPiAtCQkJwqDCoMKgwqDCoMKgIGFtNjVfY3Bzd19udXNzX3J4
X3BvbGwpOw0KPiDCoAl9DQo+IMKgDQo+IMKgCS8qIHNldHVwIGNsYXNzaWZpZXIgdG8gcm91dGUg
cHJpb3JpdGllcyB0byBmbG93cyAqLw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

