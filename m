Return-Path: <netdev+bounces-265632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOpDGNr0rmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:27:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61DF23CB16
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB21C30A1E0C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674113E0C5A;
	Mon,  9 Mar 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nz9fgRr9"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE633B583E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073408; cv=fail; b=mU4Tc84u8B4pY9rIC1zv0AcaKy4GYsKjEl4pDTEL3ED9/+1faVuFeDuj5zpGg15W4rk1hz+c7pg9RWRCAEXJOEkVrWq+KNB49P0HbDoSVIaVwHYfyd7CkPfJZpumC+mbST0p9aVzZoDC0Yytj3AqWtT46goUwt6aGxXaNGHZhGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073408; c=relaxed/simple;
	bh=85wK4oHySrQZWm1sny0OBnkLgD9UBdJMaUm88iUrL0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6Mq1cZsMshhCj0HH7RgGXUWT/CjLfhernyA5rRfBXDJYOpCVb2JFCyYY4ngU0udqeh9atgs4FveLVYN5VueNj2PRlz7v/yFWAds2wB1kTPtXttSR/hOZEkvS5MfQe32r1VgYFfRIx8ZA45tRFfnvbtBOJPFVEVHtkcRI+9DTts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nz9fgRr9; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkSAulXCO/ilk+MXatpf8Iok4etttHfPLrF2MtawyYE9AVrpOmaAoahN2xBsdYdia6qLZLBfJmPPW6uO63QjBSkvOldNujFPgDbAdWFwXhUyUtus93lzGSo+LMExIO6xD/Ob5OTmwkhNhyu3Yf1RsgZxc5bcdTSvBCGZ2iZKLNyHHP5fXqKFHFNM2s+D5QK9/kLCyDLIXF1JBxR+ogSV/+eAdnyfd+L7ooAW7hn0dYY8IzYUXC/S1MhKicKS9p/3+tnqXrfW+rQXKdV61wxOigVxKdFlDPZBwfetyaTD1uALZNz4Lfm3lIuuge22kL8AH8G2Jr9x6/MPDlV3YYKD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85wK4oHySrQZWm1sny0OBnkLgD9UBdJMaUm88iUrL0Q=;
 b=QyAiWk1AaHbwyyIwvQdI5BkPW4+Pg9B6E6ocP+9iSnW5vhWffclObsa6/dwxRG1exGWtAagqENo9HZHMjB4cqQQNOWoCyaKD29OKtnL7j86A3U9omooT5eGdhMU3FEo0uk+wHaJfP+dcPPvcrhUhRHMpGPCxBQgOvTd3D/kF+Wsr8dNYU0xEauDdgIvy8YCaJ9p20go19U7ELDkcheYYhSMGwO+lGgVEFMnnJ1TWJbSMxf8fh4viBUbWKa9u9x0WTbRazQsGFlt3Gqtoa8heZDk/xYfX/+e+CJAk+/yKOU0ty8wpILM3cLHjyNT8WEwlHVbMfwf1BCVDUdy1BugnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85wK4oHySrQZWm1sny0OBnkLgD9UBdJMaUm88iUrL0Q=;
 b=Nz9fgRr9tVKBvuiScOrizoTsLOBbM2xHLGqVWCuid0ChMQPK4ynoE3/UKS6RPVeRqZxWnbTZHq+dGEJQEYVj2sfMXIAzvx2g4+AyKfmyl7CuliPWR06MrRKU8W+4mL61ho5MhYHYgbt79n/vOcAUqlQQr79wI7a4xxgQQKlK0k+PJs56PHNZ8ererRusWj46CVI5nxkZ8XPPfzbIlDN6mUXGwWte/hxSJSfL21OTfe6+w98Le7wPf5x9Xh4+u7545SbCDt9ueb/YfOxzzSQZ8HFZ2L6Dej0fE2b8iCbbc5umg63yGci6padrnzxrdb8y9v+JEomdiPskVZIrsRYu8g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB8236.namprd12.prod.outlook.com
 (2603:10b6:610:121::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:23:22 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 16:23:22 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Topic: [PATCH net v3 0/3] macsec: Add support for VLAN filtering in
 offload mode
Thread-Index: AQHcrXtpmGA/fY6jDEuE2Ksy/FqtSbWh6vSAgAAADoCABHwZgA==
Date: Mon, 9 Mar 2026 16:23:22 +0000
Message-ID: <678c4e9e9f2e54e47e67005e1a230641300e40dd.camel@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
	 <20260306115353.28f322e0@kernel.org> <20260306115405.0febac64@kernel.org>
In-Reply-To: <20260306115405.0febac64@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB8236:EE_
x-ms-office365-filtering-correlation-id: 244beee7-233f-4442-0321-08de7df82eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 K3xDyKus6aG0jmx+Akhp6rCttf8TsEdXtNn1iPHfSrGRYUZRc+NJDYzADAZiKJ/0Oa/dtQOpfAbLKoT8UeD2Bz2ViD5wlSnu5xg/NE6zocLziE/NMu0uI37Currjxb2h5DY96939if8AmckIvZQW72u9Di5AHO/S3ctzPEMl4PPjQQOYFGODNTKr/vARuggHb7SWcQx/GPMnfzESCfkCNmRGB4H1bNXhE9ki49rte7abHY/9VBKbRZ2PU5c/cHXeB8YnZ+ivDhX1I3Vu689rZmPyGbr8LyztA7yNeC3+augDiN8IhKyDU2cjOTIFXQ1ceqKmImQcXe7NylAKUuQWOg8bwPGe6c4TClpi5SsX2+2ZaDnOxyCs+4C8Pi/cpgd7BIFfIGdwlbLNsTCzD8CF74VEhZL4gh26zpcsPh/a/usLjOB3W7qTJlNee/UgxV0E9ykKuFHdPSSddkrnI9ZF7L0LNm8TJCkUw1coHkTgDA9TroEDvpIkzDScej0p4Ok3vRO3PTw0Z5TJF/5IHZxsGXvBsOxh5tRrRbyxMhESrFUoNyjOpd0sIadvXF5OOvBDl1Fk8iDAySqdpquv51eY0/e+UOtLSPlD5hV4cfV4trCee4ZPpeWR0plTfHP8Vz5PXC0WZuMeW7CqDwHA8WpBE9kR+w71objpZ0YDueuq/AhIhG90MfIczo6XoQSccGJ9Xs/9OV8IXNLZNaaWfLOELfySTr1gk21gE7gzs//4wUYJHIEQOpUER158YtKFteNCIssSyPeLopYiXxKNEGZu3F/5KelV2BjCe4V0XJVlVEY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2ZITm51NFBYN0Y1cjdHeVIyckV0a09SQi85bEg2VkpuRDVLN2N2STJxQThp?=
 =?utf-8?B?Nk9QaEovOXpyM0ZEcVRaWWo4cXVwcWFPUmVuZ1BTUmlQc2phaU13ZVlrUmFj?=
 =?utf-8?B?em1BeXVsM3ZOUGFNSmlId2NUTWxrZnZWTzFxZGxtOUVqeTlWSUZQYVZmSnhE?=
 =?utf-8?B?UE40VldmcTNDU2Y1UGxWcTZiTnZrL3YrME5NZ0I3b0tPdm5PeGZUQ2djbmxt?=
 =?utf-8?B?dk9mb0dDQzhnQXpHaVBIYmEvVkNoWHlrWUlmem9XYm9LYjZwM2gwaG9EWE9J?=
 =?utf-8?B?dElrVE80L1hrdGYyUHhuZlYycDdUNWJTdHB3VnczNWVVTU5ZVy9VcEZHOU5D?=
 =?utf-8?B?M2dBa0F0MlM3NURFWGhnSllKbGF5TFdtWStLWngwL1RsUTFoMlk5VmdnVzFX?=
 =?utf-8?B?UTYyazNpL0Z2dWRMWU9NeWFoNkFYU2tYMXp2Ky9nWHV6dk1LN2hQUFhBUWVG?=
 =?utf-8?B?dmdQRUdCVzdNQklCc21EUStzdmd1Nk9ta1NER05UTzRHZTZkR2xHOGM5a29r?=
 =?utf-8?B?dU8yM09nMmNKZEFjU0dPK21pTjhNdzk1OUswbXdpV29uOThHdWUvQzVnaDZ1?=
 =?utf-8?B?b0ZaOVVoa2ppelorUjhsNTJPd0RkVTYwUnEyL0pWSHZyUzNyMjRqMFJOM1Ja?=
 =?utf-8?B?dmtveGd6YXZtdHB6dXZZNCtRelhsZ1NXUmppcFRTMEFkNDcxNUJja1doZ1Z5?=
 =?utf-8?B?cFA4UXoyRDJmQzlIT0R4QWEwRG5zc2tmS1g5eVF2VC8rUHlmTDhNV0FHVUgz?=
 =?utf-8?B?cnhUaDRQd2pUeEY0YkIyZTFqSjhKN0dhV3B2QkJ6NTVpMkFKRVJOS0hwYWZ6?=
 =?utf-8?B?T2NiV0xRdTB3dTlnRnhsbXVuQll4Mmxrc25RSE8vYnVlcmdIYXVKQk5uUVBq?=
 =?utf-8?B?MVpBbDQxRkt3am1NUFVaUldjUExscDdYTUNYSCtOQ1JSMFhsUWtFcGVCd1pl?=
 =?utf-8?B?QllVQ0I3QVF0VHJueXpnVnp3Y2wvNEU0WU1mOE5pVG1TME14S0U0QjRVN2g4?=
 =?utf-8?B?OVRsQTE2V2lHWWJ5VXpFMDJyRHplRDFsejVGaG05U28yazJKOWxyZmt5KzRs?=
 =?utf-8?B?SHZ3SVJKNDE0a1ova0dOZnprR0J2S0Y2bk1Tckd5V2RJUEF1cGJnWVZMSkRz?=
 =?utf-8?B?WjBRRzMvREJHNmYwWDBNRFBUMWIyZ1VPZGt4QmF2OVl2MDdUbVNMNG00aTkr?=
 =?utf-8?B?R2pkWDZBK2Z5WWtGVWFzeGM3WkRCV1M2bDlKSDk0TmdJTkJiajcvb1BkL0c0?=
 =?utf-8?B?cmIrdU5SWXVleUcvVlAwcmI0M3l3MHh3K2R5Z3lGY25wLy9pT25KQkJ4b3pa?=
 =?utf-8?B?QTBuQmFpM3hhWi9XU1RCT1pPVU1rK3FjV0s3S25MV1hiUU9Kc0NzdHNleWZo?=
 =?utf-8?B?b2k2Yy9WbXRTbitNd1V4b1NiUGttWmlqbWNWN0t0Q25NRjRWYWVvQUt3MGpU?=
 =?utf-8?B?YTdpK0owVTNicUg3SjgwYnpNTkhoTUxMQlhBRHptcUY4RSswWDY4NzRFa2ZT?=
 =?utf-8?B?M3k2b0NVdC9nRVVYbFg5NGlLcnRibU5taEdEbkljcDJKamNaMjhFVmR1MDlP?=
 =?utf-8?B?K3V1YzB0dDRNL3VwUjFaNE9DdkFLbE8xUThzTWJFU2xpNjF3WDFSdGdTOVlJ?=
 =?utf-8?B?Z1p4NFNxb3k5VnJFTmh6QzE3Z2JDL2dYNTVtV2w2N1pqdDQ0NEhHamY0Rndk?=
 =?utf-8?B?eHdQOGlVc3FnWHZhaHA1NUtESEMvb0Y3ODN6dkhwR1Q5YjB1NzA1QTI2OHI2?=
 =?utf-8?B?eVRkd1RKRzBKMzZTdkxTU2xtY2NtNUIzNEwzOFBvNU5KcURPNk13d25DMDVT?=
 =?utf-8?B?K0RYeVZsYmpSS3NYL1h2dEVudWovM2RSSmd5NnFmcE1wcU9PK0djd1NqRHgx?=
 =?utf-8?B?cGVvWFlhNXRtM3BpV2RERDVtRUIrcmFHRWx3SmZRZStNTE5LWVVoSm9KZHZk?=
 =?utf-8?B?TU9iZ0JIV0hlK1JXZGIvR1Q5VnFsdWJRSG5xR1FZakJsbjRlQXFzZk50UVZL?=
 =?utf-8?B?MHdvUGJqamEzWVR1Uy8xNGlVM0YwRjl6cDFrV29jWmNxSDhHOVZTLzk4dnl2?=
 =?utf-8?B?cHdzUEVwMFpOZG9lNEUyUTBDTTVLdEJtdzBSMWFDbTlMWkpzRG1SMFBLQjEz?=
 =?utf-8?B?dDRZNkRna2pkSVI1SWZBaC9RMTJyeldkdHh1MzZ1ZHFvUGViWEJTSzJsVmRK?=
 =?utf-8?B?eFFQcnUwM3IvM1FBUysrKytOYkZjR2l2U1RYRVJOY3ZMVWt3T0JZSUJqN0Ja?=
 =?utf-8?B?anVIWUNuQnlMdU16cUZycEh2V3FYaGE3YkEyYVg4QUdMR2ZtbS9EWVlpbnpo?=
 =?utf-8?B?TmVPbWczZTFCWkpOdzZLMFpIM1dMQ1lHQWZJZmVZbnF0VE5zdEFPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58CB90C32A220344B7BDB1E3F07F67D5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 244beee7-233f-4442-0321-08de7df82eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 16:23:22.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qq3Wsxvpl47Qn5TPB9KmZ7Ktj7z5poVxET5z3pLY5+QvTI9UCJXj/seHSppCgbtyB4KqW+AkQIw7qtfMBXpDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-Rspamd-Queue-Id: B61DF23CB16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265632-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDExOjU0IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCA2IE1hciAyMDI2IDExOjUzOjUzIC0wODAwIEpha3ViIEtpY2luc2tpIHdyb3Rl
Og0KPiA+IEFsc28gcGxlYXNlIHNlZQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwMzA0MTUxNjQ3LjI3NzA0NjYtMS1rdWJhQGtlcm5lbC5vcmcvDQoNCkluIHRoaXMgY2Fz
ZSwgbmV0ZGV2c2ltIFZMQU4gc3VwcG9ydCBpcyB1c2VkIGFzIGEgdGVzdCBmaXh0dXJlIGZvcg0K
bWFjc2VjIG9mZmxvYWQgc3VwcG9ydC4gU28gdGhlIGZvY3VzIGlzbid0IFZMQU4gZmlsdGVycywg
YnV0IHdoYXQNCm1hY3NlYyBkb2VzIHdpdGggdGhvc2UgZmlsdGVycy4NCg0KQmVzaWRlcywgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvbmV0ZGV2c2ltL21hY3NlYy0NCm9mZmxv
YWQuc2ggd2FzIHRoZSBtb3N0IG5hdHVyYWwgcGxhY2UgdG8gYWRkIHRoZXNlIHRlc3RzLg0KDQpX
aGF0J3MgeW91ciByZXF1ZXN0IGhlcmU/DQpXb3VsZCB5b3UgbGlrZSBtZSB0byBtb3ZlIHRoYXQg
dGVzdCBvdXQgb2YgbmV0ZGV2c2ltIGFuZCBoYXZlIGl0IHdvcmsNCndpdGggcmVhbCBkZXZpY2Vz
IGFzIHdlbGw/IE9yIGp1c3QgYWRkIHRoZSBWTEFOIHBhcnQgYXMgYSBzZXBhcmF0ZSB0ZXN0DQpz
b21ld2hlcmU/IE9yIHdlIGxlYXZlIGl0IGxpa2UgdGhpcyBhbmQga2VlcCBpdCBpbiBtaW5kIGZv
ciBmdXR1cmUNCnRlc3RzLg0KDQpDb3NtaW4uDQo=

