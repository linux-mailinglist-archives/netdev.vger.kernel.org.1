Return-Path: <netdev+bounces-271094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG1FLlOgwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:31:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593730A2E9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC13E300F5FD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FE3FEB2C;
	Tue, 24 Mar 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a1pK03F3"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DF3FE65D;
	Tue, 24 Mar 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362438; cv=fail; b=cJ0+4aLUa2yguOFQuVMy4n+KTfZRcLEPFaaaxo+p/vE4/nRj/1exBdVXO3TXx3JrxxP2vUnszSOyXGVGE52XF9ecvsy82haT7JbTy2mf7EIRxE7NnxBUePwHMCVutDVT6IXAQlrunF2LmEq/Y7ZLf6n1WCu4nvRAqdSySPh8jW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362438; c=relaxed/simple;
	bh=aCi97TaHoZKdKaoaGQuaPAMf2K6BCwwKUo8rdUYhxpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPGjS58wfIx1YIf5hyOEAoXTE58/2Fy+ROR9C40gnSecE+lB+6uDsp0ZUqVDmBkWULkUkCrQ0WYaQx1pf4XY+Pse39n3HOg3438SBu0GCwRCrlZ9BW0Qbupj8pp3WX12NFNACiy54ZXIRvRZHF45+jlLpnWtooZxT7eA4zHPllo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a1pK03F3; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkBvipA0fvT/IrN6uHykS60gRt8BAByg0VD5ZFnEfbEaUF5cXO/pxZ/9wKc7XtPAb4hHwZb2FNPWfrS+rlbYsTWIAGlY8vPC75+nVhbp2ONtrZ0rz/LyosOZw2rSOyS9uM9C7+g4m999yH9Ly9ucJGKBzGIqRQ8kvH+DI7mmoa1N73paH/zncnO6E6ZXvlbulmur1tYwTJslXNz72rwRf/mYb3EoM7kJHWoTJGHtT0s3rw0KbVK6xvy+uwzmxoPS3Smcr2Wfyw00VF97CJWGjlYkeDwbPA3e4ED9K51gZ/mkVh2eRDSTYLhQYBiSubL4lgMHk5GV1ejXdtUR/lz+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCi97TaHoZKdKaoaGQuaPAMf2K6BCwwKUo8rdUYhxpU=;
 b=dHrPx+GvqdYJ5XIJ9NiuHvlOdFJSL2Hum4i1dVaWQ3jWklIm/p/CEiJKDALw/VneYlCyALs/qFc5yD1/ln06V42qK3CgF5mqTTpwm8odNWiXoa8NoqdTOA9dz9EnefoK9xbI4FRXHG847LywbdCzlVwWz6L8KVtPJwhyg7c2Z7tGQkeOqyRmCbWHT/erQ8g/GxBXSTltuQPm6nJAj1okMdS6o+70bBfuOwLNks97KsKmwcbkmlFUN3qipwnEWfvecmzpecEhaMqSqaX/BMfPbuVMSbB/I+6S05xhAaEdUw9xUDa/kIxWl9TjQpKn3ic4cmO1DLMIBy+ez2PyRHcvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCi97TaHoZKdKaoaGQuaPAMf2K6BCwwKUo8rdUYhxpU=;
 b=a1pK03F3mlFNys6mKDVyxvF2AIxrwYpdG768xXf+9D5QqAgfuIPIwfy+iivHQEvbFLWOuXUadA/EGmmB3G4slOj3Imt7eWwqyFQPlYGMHFRIHCbOKvZAwAADfPHGNWSanLcu6dd/ob0EbZscDiBctUQLbWEzGL0vEFNDoXI1XLMYRgSpN4go/3CiPkl/DnETcJueimNwezBidGtbaMM1CCaE5d2ILzeJjdKp/5zsYP4d8IOedsgdt8PCU+ZCTZoWu0huKQk2jLLzsKxxEA6yr2XrVGKSuJacT+yCWNyyatUlf9U4gGZiTuFsvygiFWCPU2a8B8i4IE747r8+nISUFA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SJ1PR12MB6194.namprd12.prod.outlook.com
 (2603:10b6:a03:458::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:27:12 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Tue, 24 Mar 2026
 14:27:12 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Topic: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Index:
 AQHcusHFtVV4nTuLykGR5FK+1e+FhrW8LSAAgAADwoCAAAXggIAAGROAgAAMYICAAWLdgA==
Date: Tue, 24 Mar 2026 14:27:12 +0000
Message-ID: <62b3b47291879328a868aa15fb7319b5ff13a20e.camel@nvidia.com>
References: <20260323123633.756163-1-cratiu@nvidia.com>
	 <acFODtfaa8LCKX4r@krikkit>
	 <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
	 <acFWIxzM-GxpAhjH@krikkit> <20260323093243.17c14edb@kernel.org>
	 <acF1jeGLpq7qDKgY@krikkit>
In-Reply-To: <acF1jeGLpq7qDKgY@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SJ1PR12MB6194:EE_
x-ms-office365-filtering-correlation-id: 7bc7053a-1a42-48f6-b80e-08de89b170b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kLsJOADv8fPKCtZaxBs08e08vUDNUqHh2xXR9HNJMiruxt8lAvSguPSJkhJqHFaaeOdTHszxS01HDzn0dyH6DQG9ifahnK722OhIbDm7b730QhaGLw3dk2iKayxhmXCQvlwglLVxJkmeOFT7rFRxdkEE3IOpNOgT1XbuREqfOR5pUzXtOwnsGze1J4Gt+OoG53atmxSOUJvsUcsS5UeUlfDUz+U6VSDSjqEtQdOIED2BE+Eo8jlGhyldr6sncIeMQVyxncaiBWTGTiFhjHLwJKeu+RtGpYYmNDkSi4cNnuEG+UuAB6ohK0R7oYC8Vx5zP6TrWLamC+nQq19LCc/mATKKv3mF8PlU8Ri9DYv6QwjX17Pnp65nRCXonwjS5+WQyJ0BfprgUgngmU9Zgzvw1lBlg1WkZuBKjp2+phFinczJhqmrnNaqnkCTH1IkS03DvNt3+KIJqIeG7o0fjWSbdNLEunAj+s3RLe7VJj/qUckqgm25Ky7dh1AYEiwKZJL6FOX0cd3cTKg4sFwWWkbtZkBUaDxkbpw85xO3ph/OApR6fomqvUeKv/yDsy1dHd0F1azS4vzBFUI4Q0fh52PbF83ooaUG3aeCbuY/wvd3Fo5FkPeHE+KmmmhW1Z1kaYRvyzJzeOJMENn/TDXURDJ4qhaQ9i84lxqyZbCcvvxPISgi+/Zv5Z1S1hWs0csrzOshTcuLshhEFZ2pFhakXRd7kpDtPhpj3AbiEQThBn4m++wB8VnGK7Iw4j5bwEw+nXhLLuVKHnSbpOU63UotlngVg4Y0Z5QmK8JJf+Y3DDYXROA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2c3QnYyRmJ6VGliT0ErOTZ3OENDZEQxNDNLaEVSVlBsRGFTdDR0ZmNYbHpE?=
 =?utf-8?B?anpLT0lPQUZXbVRXUit5cnRmYnIwcDU2cjhaVjhBZkdkSldJU1ZGaVBjNVQ5?=
 =?utf-8?B?VjErZDFOOVNBU3l6VnN0T3BOa09VZ0NTaS9CMFNEdXhYRHZDTTZEWWVuWlJY?=
 =?utf-8?B?cTNrWDAwNWJ4K2hSM0lqd3hkT3BHMDZ1c1R3Tm9CN1dUMzZYMk10SGJ5TjND?=
 =?utf-8?B?Y0VHSVdIRmVuK1hMWjVLZjc0VWhiYlM4MVJOQ2YySzhOWkZ3WHdrNnNjUnRN?=
 =?utf-8?B?T2tpNDErSHhuaWl3WHFDNjZIczJVUzMzYVZRaUR0UkxlQ3k2RUN3aXBnR2pK?=
 =?utf-8?B?eVUzY0NXbk5zZDV0QnlEN3VGNTFQNmtUYlZYdktkbzdPVWs0Vmo5MmRTa0tE?=
 =?utf-8?B?ZTA4cjJqWjlFa2cxNnc5eEc1S0E1STRIbWVFTm9UZEU0bGJqZGg5OUZGYVJl?=
 =?utf-8?B?bm41c2NUWjVhL2VtZXBjK2lGNjVRWFN1LzJNVmltT3F5ajFmVzVwb3ZyWm13?=
 =?utf-8?B?eXZiNVpaY3pWRnovanRXZDFndmx2bUpXaFNtQWNORUtkZERiZHpOTSs1NGJF?=
 =?utf-8?B?YXJSWk5sTEFpVmhWR3ZOTVpoM3NOOWpTUUp1bGVzVGZYVCtETi9LZnZ5aytM?=
 =?utf-8?B?VkNEaFpMS1pzOE9oUm90anY1bnhXcEdHeWttc3V4NXNXeE1qaVJwTEx1UjZt?=
 =?utf-8?B?QXBkRUhwWDVjOU1CSmMrcUh1OE93U0VZWUs0c01oRXRHcVlNSE40N2thVkg4?=
 =?utf-8?B?eVF2ZXh4V2k0L0lvOS9MYS85K1hsQzhjcVBUSEM1YlZWMVVTTTNIT0FMenFO?=
 =?utf-8?B?UHlCbkJML0FvNDJPRUJMSURjcUZQMzIyS3hkbUVxcmwrWnAwTyszM05ibXpZ?=
 =?utf-8?B?UTBQaVQwL0ZBT3FmczFiUXIrMTdhd0Y0bk1qdDN2a1hVQmJhd2drcDRobEIx?=
 =?utf-8?B?ZDJ1Zk9IQ05NeW16WVZzazNWQ3J1TDJpT3djaHhhVkxONzVkK0dIMVVxNk13?=
 =?utf-8?B?K0J5Q1VPbWtkNFZlaVBaUFRvcG0rVUZubExjejFKanB0TytxaVN1enhXeWNT?=
 =?utf-8?B?L0xUSmRDck9URitnZnJZdU5BM3RINGFUaU1lMmczOTFMYUYxaWRNblpMcm9a?=
 =?utf-8?B?TWw1c1Nia1g2bjlSVzROY1plMi9IYUU1bFhnb25MaG5DUkZmYU5mZG1vR2g4?=
 =?utf-8?B?UGR6Rzl5RVlvcTFUNElaT1FtaEFpMEM4YmlsMVNnV3dOS2JNaC93cUkzSTAw?=
 =?utf-8?B?dWpyNGc3VzU5VmZnSWJHQjZtNyswakRvQTdCMi8ydWhsVlFlbnhQSGtlZ0Ew?=
 =?utf-8?B?cTJ6S0dZcWR4bFZTb21EQnpyaVhBRGlmcDFjSkNPVEdMYWFIV0x3M1Z2T0lx?=
 =?utf-8?B?L2ppSUtGN2hDT1dKbExtVkJpUjVFaU9GQTZ0SVo1MjNyMWpoRzYyZ3lBczNF?=
 =?utf-8?B?enZGMWEzT2dqQ0xnNGViaXFMd0FLZUJKazd5QkIydkplbklKeU9Zc0plQnVr?=
 =?utf-8?B?WW4vaSs0QnVibTZ4ajBKYThHaVVEcGRvNURUOXlTVHBrdk9wWklXa0VWOFFM?=
 =?utf-8?B?bkY0c0MwNXBSTkN6V2tzOWRibzB3RVI0MG1hSlppNk51TkY2N3JkZWhoRk56?=
 =?utf-8?B?V29BYXpqTm85aWZ4bk1HR0crRnVzajd6SURvWUtEbGtpQmdsV1lVS25zN3hV?=
 =?utf-8?B?T2hZcTJIaHRyREtFNjhadmpLYkh2VU1WUERNbHZzMEJxYkRGeTNTQjFRZkMz?=
 =?utf-8?B?akdQdUdrUEtwTngzcU9FOUsyb3hTWHBjVlZNcHlNakQ2QlRjdUlPSWdTdW9U?=
 =?utf-8?B?aXhsVURnNS9CK2JYWkdUeEVpM2tHeDZKbG9uVTVLdm45L0hESHF1SmZucEg4?=
 =?utf-8?B?WHRrRlRJNkwzbWQ3bHkzQXJsWHE2NlR5YUNpT2lucHlqQ1JPZzNLRDNoeVc4?=
 =?utf-8?B?aWkzYzZKdFhET0IzMU55UHcydFZpSDFYcXQrM1NkYy9tNVpMTlNGanEvaHVU?=
 =?utf-8?B?bndPSHp5MmsyOTJXbmQzcVdYL2c0RDU4cm5Oc0lld0NsWEFqam12UzIzbUxt?=
 =?utf-8?B?R3VkV2llSitMb2QzTzJENEdjUVpTV2ZQU3Rhek13WTllNGMxWk9uY3VsK3hC?=
 =?utf-8?B?c1crcVFjck12UG5BNEwyTm9OZ3FSOGVTblRaeCtrd1dMNTdvakQxUkJ6MG43?=
 =?utf-8?B?TmR5bDYrcDBxVFFpK0NlUTl5Vk9vQ0hpWUhua0lwQVg5YkdWb1BtbERQbTFV?=
 =?utf-8?B?UHgzRUg5eHRUREY3MTBYTU9vbzkxdXd1b0sxYW5mTEY3dm5sc0oyZk5nRWtK?=
 =?utf-8?B?NHd1SUNzaUJGSERUZDdacGJhbkxzT1RPaXdEWlRjdjFmS1hjUjNhUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6564725A2227854E8A50053F08966A69@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc7053a-1a42-48f6-b80e-08de89b170b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 14:27:12.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGDnRRz+XMeJAWLEN0DXExOMK+5u2z+fsbbrdpimU8tGfdXJwGOogHaTl6/tk0ZPpyrM3k5W9v33mjyntcv6xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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
	TAGGED_FROM(0.00)[bounces-271094-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 1593730A2E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE4OjE3ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMjMsIDA5OjMyOjQzIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4g
PiBPbiBNb24sIDIzIE1hciAyMDI2IDE2OjAyOjU5ICswMTAwIFNhYnJpbmEgRHVicm9jYSB3cm90
ZToNCj4gPiA+IDIwMjYtMDMtMjMsIDE0OjQyOjAwICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6
DQo+ID4gPiA+IE9uIE1vbiwgMjAyNi0wMy0yMyBhdCAxNToyOCArMDEwMCwgU2FicmluYSBEdWJy
b2NhIHdyb3RlOsKgIA0KPiA+ID4gPiA+IFdoeSBub3Q/IEJlaW5nIGFibGUgdG8gdGVzdCB3aXRo
b3V0IGFjY2Vzc2luZyByZWFsIEhXIGlzDQo+ID4gPiA+ID4gc3RpbGwNCj4gPiA+ID4gPiB1c2Vm
dWwuDQo+ID4gPiA+ID4gwqAgDQo+ID4gPiA+IFRoZSB0ZXN0cyBub3cgc2VuZCBtYWNzZWMgdHJh
ZmZpYyBvdmVyIFZMQU5zIGFuZCBuc2ltLCBpdCdzDQo+ID4gPiA+IGp1c3QgdGhhdA0KPiA+ID4g
PiBuc2ltIGRvZXNuJ3QgZGVhbCB3aXRoIFZMQU4gZmlsdGVycyBhdCBhbGwgYW5kIHRoZXJlIGFy
ZSBubw0KPiA+ID4gPiBzdHViYmVkDQo+ID4gPiA+IHZsYW4gZmlsdGVycyBpbiBkZWJ1Z2ZzLCBz
aW5jZSByZWFsIGh3IGRvZXNuJ3QgaGF2ZSB0aGF0DQo+ID4gPiA+IGludGVyZmFjZS7CoCANCj4g
PiA+IA0KPiA+ID4gU2luY2UgbmV0ZGV2c2ltIGRvZXNuJ3QgZGVhbCB3aXRoIFZMQU4gZmlsdGVy
cyBhdCBhbGwsIHRoZSAidGVzdHMNCj4gPiA+IHNob3VsZCBiZSB3cml0dGVuIHNvIHRoYXQgdGhl
eSBjYW4gcnVuIGJvdGggYWdhaW5zdCBgYG5ldGRldnNpbWBgDQo+ID4gPiBhbmQNCj4gPiA+IGEg
cmVhbCBkZXZpY2UiIGJpdCBvZiB0aGUgZG9jcyBkb2Vzbid0IGZ1bGx5IGFwcGx5IGhlcmU/DQo+
ID4gPiANCj4gPiA+IEFueXdheSwgSSB0aGluayB0aGUgb3JpZ2luYWwgdGVzdHMgaGFkIHZhbHVl
LCBldmVuIGlmIHRoZXkncmUNCj4gPiA+IG1vcmUNCj4gPiA+IGxpbWl0ZWQgaW4gc29tZSB3YXlz
IHRoYW4gdHJhZmZpYyB0ZXN0cy4gSFcvZHJpdmVyIGJlaGF2aW9yIGNvdWxkDQo+ID4gPiBiZQ0K
PiA+ID4gaGlkaW5nIHByb2JsZW1zIGluIHRoZSBzdGFjayB3aXRoIFZMQU4gcHJvcGFnYXRpb24s
IHRob3NlIHNpbXBsZXINCj4gPiA+IHRlc3RzIGRvbid0IGhhdmUgdGhhdCByaXNrLg0KPiA+IA0K
PiA+IFRvIGJlIGNsZWFyIHJ1bm5pbmcgdGhlIEhXIHRlc3Qgd2l0aG91dCBORVRJRj0gc2hvdWxk
IHByb3ZpZGUNCj4gPiBzaW1pbGFyIGZ1bmN0aW9uYWxpdHkgdG8gd2hhdCB0aGUgb2xkIHRlc3Rz
IGNvdWxkIGRvLiBJdCdzIGVudGlyZWx5DQo+ID4gb2theSB0byBhZGQgbmV0ZGV2c2ltLXNwZWNp
ZmljIHN1YnRlc3RzL3Rlc3QgY2FzZXMgb3IgYXNzZXJ0cy4NCj4gPiANCj4gPiBJcyB0aGVyZSBh
bnl0aGluZyBzcGVjaWZpYyB0aGF0IHlvdSdkIGxpa2UgdG8gYmUgdGVzdGVkPw0KPiANCj4gSW4g
djIvdjMsIG5zaW0gd2FzIGV4cG9zaW5nIGEgZGVidWdmcyBmaWxlIHRoYXQgY29udGFpbmVkIHRo
ZSBsaXN0IG9mDQo+IFZMQU4gZmlsdGVycyBvbiB0aGF0IGludGVyZmFjZSwgYW5kIHRoZSBzZWxm
dGVzdCB3YXMgZ3JlcHBpbmcgdGhyb3VnaA0KPiB0aGF0IGZpbGUgdG8gY2hlY2sgaWYgdGhlIGNv
cnJlY3QgZW50cnkgd2FzIGFkZGVkL3JlbW92ZWQgYWZ0ZXIgZWFjaA0KPiBvcGVyYXRpb24uIEkg
c2VlIHRoYXQgYXMgdGVzdGluZyB0aGUgYWN0dWFsIHByb3BhZ2F0aW9uIG9mIGZpbHRlcnMsDQo+
IHdoaWxlIHRoZSB0cmFmZmljIHRlc3RzIGNoZWNrIHRoZSB2aXNpYmxlIGJlaGF2aW9yIG9mDQo+
IHN0YWNrK2RyaXZlcitIVywNCj4gd2hpY2ggbWF5IG5vdCBiZSBjb3JyZWxhdGVkIHRvIGFjdHVh
bCBwcm9wYWdhdGlvbi4NCj4gDQo+ID4gTGV0J3Mgbm90IG1ha2UgdGhpcyBhYm91dCBIVyB0ZXN0
cyB2cyBuc2ltLW9ubHkgdGVzdHMuDQo+IA0KPiBUaGF0IHdhcyBub3QgbXkgaW50ZW50aW9uLiBC
dXQgc2luY2UgbnNpbSBkb2Vzbid0IGN1cnJlbnRseSBpbXBsZW1lbnQNCj4gVkxBTiBmaWx0ZXJz
LCBpdCBzZWVtcyBydW5uaW5nIHRoZSBIVyB0ZXN0IG9uIG5zaW0gZG9lc24ndCB0ZXN0DQo+IGFu
eXRoaW5nIGF0IGFsbC4NCj4gDQoNClRoZSBwcm9ibGVtIHdpdGggdXNpbmcgdGhlIG5zaW0tb25s
eSBWTEFOIGZpbHRlciBkZWJ1Z2ZzIGlzIHRoYXQgaXQncyBhDQp0ZXN0LW9ubHkgaW50ZXJmYWNl
IGZvciBmaWd1cmluZyBvdXQgYSBwcm9wZXJ0eSBvZiB0aGUgc3RhY2suIFJlYWwgSFcNCmRvZXNu
J3QgaGF2ZSB0aGF0IGludGVyZmFjZSBhbmQgdGh1cyB0aGUgdGVzdHMgYWN0dWFsbHkgaGF2ZSB0
bw0KZ2VuZXJhdGUgdHJhZmZpYyB0byBlbnN1cmUgVkxBTnMgYXJlIHByb3BhZ2F0ZWQuDQoNClRo
ZSBuZXcgVkxBTiB0ZXN0cyBkb24ndCBhY3R1YWxseSBlbnN1cmUgYW55dGhpbmcgb24gbnNpbSwg
Z2l2ZW4gdGhhdA0KaXQgZG9lc24ndCBzdXBwb3J0IFZMQU5zLiBCdXQgb24gcmVhbCBIVyB0aGV5
IGRvIC0gd2l0aG91dCB0aGUgbGFzdA0KcGF0Y2gsIHRoZSBuZXcgdGVzdHMgZmFpbCBvbiBhbnkg
aHcgc3VwcG9ydGluZyBWTEFOcyBhbmQgTUFDc2VjLg0KDQpBZGRpbmcgYmFjayB0aGUgbnNpbSBk
ZWJ1Z2ZzIGZpbGUgYW5kIHRlc3QgYXNzZXJ0aW9ucyBndWFyZGVkIGJ5ICJpZg0KY2ZnLl9ucyIg
d291bGQgZW5zdXJlIGZpbHRlciBwcm9wYWdhdGlvbiBjb3JyZWN0bmVzcywgYnV0IHdvdWxkIGZl
ZWwNCm5vbi1QeXRob25pYyBhbmQgYSBsaXR0bGUgaGFja3kgZ2l2ZW4gdGhhdCB0aGUgc2FtZSBh
c3NlcnRpb24gY2FuJ3QNCndvcmsgb24gcmVhbCBIVy4NCg0KU28gd2hhdCB3b3VsZCB5b3UgbGlr
ZSB0byBoYXBwZW4/IEJyaW5nIGJhY2sgbnNpbSBwYXRjaGVzICsgbnNpbS0NCnNwZWNpZmljIHRl
c3QgYXNzZXJ0aW9ucz8NCg0KQ29zbWluLg0K

