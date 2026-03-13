Return-Path: <netdev+bounces-267527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFxkA5Y4tGl3jAAAu9opvQ
	(envelope-from <netdev+bounces-267527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:17:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC3286D38
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28043095C31
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312E3BD247;
	Fri, 13 Mar 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXUZbvl6"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083435E93C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418392; cv=fail; b=bIGyJ90PKDqa5uXr0aZ3Zw8ORorMAZl2KIsV2+7D/olfKI0IfFV6cxu4Agnd3AF/Fon8byH5ZWRgj5TwDFkMny1qvU5ZmDonvHwzIcybv5kmEFmSsAY+zi+dqw+ijNRlE8yKkfv1rCpe7StgIrllQleHcZLxtzvNpHRanFIEmfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418392; c=relaxed/simple;
	bh=KhLP8JN3FwR4rMwfcgxoan6hmJjLOdwCJRxjgriJx2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmitF6DT2otE1YImy8ZUl9XguVLf5IUlLfL3cfA6NuOmJ2AW1vqJf078wCeXTgfa5ryOU+0TA8u+8azDBW0gnpi2jhrlZE2nGYbuqxLoYe0DXpLuAwcBJJ4YNeBit1G1IW0GD+18jx0d8uiECPTEN3S9+UtG/c35S/gj/Dv+ujs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXUZbvl6; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3ot3sZHqrg6+oW/Y+uwBv6HUxsTL+nmO4drk/x+4HgPl2aJ1z/1r0VEVBcpOvkQhXE0yEbuFvzQy3n6GMez5lWOKXhSsXaLHFUdwb9Wh8ZadbI0iLT0rvQf53uTgFVUaxot5AB7Gi2DnYwafL64x6RFCVfl1T4Kcq+ZIkGJKR0A0UjGHk5npgiHeTX/8yHKKZ0F2Desj3NfWvs0BIF2xJvdd6ezQg62P+7l8RdIgrEM78Y5j2qQIYx7iOmqnDTTMV4XHJq4lomHiK29FDMv5evD0ydW6v7GbQ7wKGGNiY8NQsXLGTjZmTFN2sEwDgyC9S9+boraBXoulPpjO6p9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhLP8JN3FwR4rMwfcgxoan6hmJjLOdwCJRxjgriJx2I=;
 b=zTDeSZBTV7/tS4qvsn1XQPV7PCCAU+NTnQleZng8xmWmxkNHF04JbYxGhpBPNQhdpGAJGxAZ+OEc7/ikOUXlbR/JJyUtr39XJvLRrbW+oZfYLkv0LOmV5O+TsBw7a/adOX0Af2ZpMTspZP2f1W4IVXjO++XQLmHWYMgqbOkdRD2LTmNGuT07a9DvhbXSN0SnM04/PG2tl4plxoMOwsVcNG4WX1hlcGjvmIBcabZG31Hk2TWksZlkVAgd8osSplSIJb5NYuGMVfLEERSe9Gskd44zyKrb5Ap4VL8xvsDVco6jezHV76mDO+gD1022aYvlxd7ztLGotXk0wYdv907tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhLP8JN3FwR4rMwfcgxoan6hmJjLOdwCJRxjgriJx2I=;
 b=UXUZbvl620W/fiZlF9xd1sRhFeO4BPA7kJc2YkM7D4HMJgv0QRyhN4tn29CpZxWvYbsK60VdBP1cuL0AJ7N0QRFDA/AuIyF8WtVJ6L5olWMGsT/XtiKdetbAIGeFN5Pi1TQKvkhQ25ldMQSw6Jh38cvZBhzKcZ6yjBc1unNuQ0e5fYzr2aVFIebiTHZgIyfMqvtTOk2EZEYtOUiXh/nVD+iOi+2UUPlV1qOANRm/IaWWnLo3ZIex0dl2T8hGF4Ydq5GVYtsfb+eakldv6rtxYmxqNi8fqlAH6rCOuRPBswEsw1Rb9uem/ED6k95vUwIuKxEbQMYoGZKzxh4BVHcxLg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB6554.namprd12.prod.outlook.com
 (2603:10b6:208:3a2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 16:13:04 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 16:13:04 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 05/11] mlx5: convert to ndo_set_rx_mode_async
Thread-Topic: [PATCH net-next 05/11] mlx5: convert to ndo_set_rx_mode_async
Thread-Index: AQHcsvjebr8RZ38QjUSUHu1qSGg8HrWsopQA
Date: Fri, 13 Mar 2026 16:13:04 +0000
Message-ID: <10534fecb1be59b3468767d291c42ab502f85af2.camel@nvidia.com>
References: <20260313145113.1424442-1-sdf@fomichev.me>
	 <20260313145113.1424442-6-sdf@fomichev.me>
In-Reply-To: <20260313145113.1424442-6-sdf@fomichev.me>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB6554:EE_
x-ms-office365-filtering-correlation-id: a6fedf5e-5a31-496f-260b-08de811b682f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 PVSuARA6Ny/vmq3PRLPzqnLiIoLddBY4mN6BCtFH+M85Ql82YyUGBr0sNa+A2OCmOF62tS3FLT+5rSIxhbUHuty3WenkSLBTWNIHkTOVijCAoFdDv0+JXvHcA5xddGFpnNnuDgomfC0Q+Lvok3d1my50WNbfqNJEwkSH/TP12w1HM0Br4bcnUea/sBEBqVH+0iTftI96Lr98QN+XlpSbu9osajbOCbsEKJFLnnAaN1pflBxfxXHilfVHpgQNcPGzFfyacDuMG1Kjlsik9LV/cZ0Bn3X+yxqLZoTEVXJzNftR3N3i9wI3U1T7oHH7GHQ3MRjs8pagSujD+yJ6WnmKteMsbtgnLkhjN34MFt57XddJM76lWoTh4gzohPYBUezoK3S2z1viE3MRT2pjImtivwcR9JdUn6rqC83GWgjem1cOgEKGJmxGOLcm4NOdvQsA4FlAcOGE1hwfU40DXCfRJ9nfzCx4+QHi74EXzsOJIZOX4fjT/GWM2wPAwoelKfSYfx/OXQF+FJbrOqXdHgmBcZi4YtcHP9JTMFSt/EjzDZxD33RO5u6r30od/YM5aV4QHj3/taZruvkNVw5zyfBeVYLJKm9O5dYbrbvmRKzwmOnHbIB4rr6Jq6cu5P/Zr5cAOjG9reN3ex+HQGKm9gAZy0/JD7fOVKWb/ZzIkA9nVaacRN7Ve+LP/BQwxscgIPrcLtRWCJYZ9I8JFTSFBruf9n5zcWJ8SZQPtvrU5h90LnK08XXA+iYypg0ithW7OkQIyjBiwRED97lFxsGZN76GxQbKtkEbfnWVxIkJ7qiyD0s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWwvcm5WQ2VyY1hZV3Y3ZEdRdUlkL3hXZTcxNnFHM0FvZ3lXVlY1R1VNN05w?=
 =?utf-8?B?RGF0L3RoWGphVUpWT2xQK2g0N0hSQ2dHbDdQdmVTUytqeUN4N1E2a2FqRml3?=
 =?utf-8?B?S0s3eW9GZUhRdDV1Q0d3N2ZWUHR0amx2ZWovWFlqL2l5MmxTdUJjT3N4Y3lF?=
 =?utf-8?B?Z29RWnBRZGx2Sm5NU1FvTEc2djk4S0ZjU1VaTC9pb3dWRzIwY3R5Umdnbkt4?=
 =?utf-8?B?blN4SmdsS28rd1hHcmpyNmxaTEN2TThHZUhTaU5ZSWw3Y0FjcG5nbVRqK09Q?=
 =?utf-8?B?M3ZvblYxOWEzeVN6WTRiRk4rNHNIM3lmRWdPQmNkOHptMTJmRHJwV01jMmNm?=
 =?utf-8?B?ZENWUnN2bjJydnBWV0lpU0ZnZ1NjK3FvdC8yTnpjbDJXVUEvbXVQVGlnMkdE?=
 =?utf-8?B?V281WEp2MGJNbmpvL2hpdFgyZ0hrTUgyZ2ovWjMxUytkcmcrNDdTT3RkdDV6?=
 =?utf-8?B?eVU0NUY4RTFiWDFKTDkrRmR0L1p4elV1amQyL09QbzZBZ1A4UTVqbllYaElT?=
 =?utf-8?B?Y0pkTS9maE5CU0pueHZ2cHlpRkFNbmtBWWZVWWtOMTBoQ1NHWCtuR2RiTkhn?=
 =?utf-8?B?VE9rSnIyYkdPQ0p3TER2ZHVHbXlNdWxoWTErTzV1dWxRSVhOM3FwbjJjaTRz?=
 =?utf-8?B?ZXJ1cjVTUmVJNlB4M0N0WURBeXZjUEUvS1hBQ0w3VHFGUGhIYVRNcEt4SzN5?=
 =?utf-8?B?bFQ3elZxcUsrNDZkMm01dzc2R3FHSXJLR0dROFFCVzRmalFzQ2dydHJZKy9U?=
 =?utf-8?B?bkhFQUFObnJSakUwTjlDb2pWbDYxQnlwNEVzMnBXMDliR3MxT2xrckFkVGZz?=
 =?utf-8?B?SzhWS2U2UTJmWnpaV3ZOSXFWK0lzRlEwSXBXMEtJb2oreWlweVU2dDhQOE8x?=
 =?utf-8?B?WnJ2K1pYbzVOd0pUT1FXb1dYM2MrY2lnWDRNVUFZeWwxbWg0WCtJKzZuY3Jy?=
 =?utf-8?B?RjRCeUtVeENxTGxCZTVZUk1xVWp3c1FPU1RaMlZOQUNDTUFpMzNwQWV3MkRa?=
 =?utf-8?B?THIvamFUNmJrYXBhZlZrMzlZMlJiK1ZrdGFEb3M2dXJ4S09Md1I3NE9YeU5x?=
 =?utf-8?B?K2xGZXlIY3VaWHlaVzdNZllYUE8zTHNHdTQzSzBpcURPeFc2dmJjajdHdnd3?=
 =?utf-8?B?SW93VXAxamhnZ2J1ZVJLd1U3SUNRZ3E3OE10M1FRbXI5WTNEZjF4RkExenly?=
 =?utf-8?B?N25oWmczWkhCUE9ueVdLR1drRzN3dkIzUDZQblMzSUhpcklERnlJQnlEZ0hC?=
 =?utf-8?B?RDlVb2oyUndrNGxFTW0xR01GOUpvUjlNUjFkNDg3Z2NqcmNxZzdTcEgwS3hr?=
 =?utf-8?B?NlBGRGhJL29PalVwYXJNZ0VoYlpzL2I5bTdMS0JTRC91MzdkYytoSlBTeTR6?=
 =?utf-8?B?UzVPOVZvZlNpcGpYZklKUUxhNmpDQVZMdTRlM0V4OFh5ckk0bDB2QW1wWkhV?=
 =?utf-8?B?WGxtcXpXQVBUNlc5SHVWR0FncCtXRUJnbEdrU0ZzVVdISjVIWXd3ZTh1bnZ5?=
 =?utf-8?B?SWxkalNWMDNOa0tHVldTVzFURUlKY2hZY1doeGZxQTRvUUp2ZG9UQk9pOHFR?=
 =?utf-8?B?dGNiNjVoREVJVDdDdzhCR2NwS1hRYkVDb0xOT3JPNHArTXVveWQyeEpRRisr?=
 =?utf-8?B?VGx3dlZWemhSNWlDQ3M0TjdUT2M0UGhYYTZnemVJdHZyc3JqWkNNZHlHV1R5?=
 =?utf-8?B?bUsyNjBrWWNBbG9yOFBQTXpLZVNZMkEwMVFIM2syMUoyU0JqQkZ4MzZaQjc3?=
 =?utf-8?B?U2lGN0Z2WmJVNVArNHZaQ3ZDd3JrNXJuYWMxWVVRR2tpUERuaXhxYUNjRkpS?=
 =?utf-8?B?Y1o4ZmRCUnFZWGYySG1wR3FVVmxzNS9HVW1na1ZGTnZDaE13cHdTdUJGczVZ?=
 =?utf-8?B?RkVhTm1wWUlNUmxWNktyVkdHM1F1YThOMk1UcmRqY0VhelJtSVVFa3BNYW1F?=
 =?utf-8?B?WWc3eEtRWEFMNkpVcmdhYlhyMm1FTFM0cFo3cU92N2lVQTFzM0UrQXVmWlE5?=
 =?utf-8?B?RXczUjZiR1dCNXEyR0RwaXlUWkx4Tm90aTA4cVRXc0R1VGZEVGxrS0UxUmpp?=
 =?utf-8?B?b1pZdFRCcGg1L2o1VnFYVUJxblBIRVY3TERIR3dlWk1hSDRHUlg0Si9rYkN5?=
 =?utf-8?B?MGVyK1NKenhjcThmYTBIWnZtYStOSHJSVG4yUy9zbUhQMjNPd1JURjBYMEFw?=
 =?utf-8?B?LzloT0dMSkFNemlpcVB5YTcyYzhQckZkalJHWjU0UzY3RG41WHRZWVU1aWgr?=
 =?utf-8?B?d3JNcll0cnVWVk5pdS9ySWQwQ2hMUzBOaUw5ZlcyRERaSVJ2RHNBdEI2c05Y?=
 =?utf-8?B?UDBUbUFsdVFBZUdpTS9CSzhaSUJoMFdrT3FmcDMzd2VERVdQYU5uUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <640D9047C012194791E8990216B82289@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fedf5e-5a31-496f-260b-08de811b682f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 16:13:04.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbdHpoknzvWe5s/kWvcM5CKIzGv6hPxsoAD6qLIGkTnqVAPayFDunEKevYCyow9Xj3aVl91RMP8jTLt22bI39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:replyto,nvidia.com:mid,fomichev.me:email];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 74EC3286D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDA3OjUxIC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IENvbnZlcnQgbWx4NSBmcm9tIG5kb19zZXRfcnhfbW9kZSB0byBuZG9fc2V0X3J4X21v
ZGVfYXN5bmMuIFRoZQ0KPiBkcml2ZXIncyBtbHg1ZV9zZXRfcnhfbW9kZSBub3cgcmVjZWl2ZXMg
dWMvbWMgc25hcHNob3RzIGFuZCBjYWxscw0KPiBtbHg1ZV9mc19zZXRfcnhfbW9kZV93b3JrIGRp
cmVjdGx5IGluc3RlYWQgb2YgcXVldWVpbmcgd29yay4NCj4gDQo+IG1seDVlX3N5bmNfbmV0ZGV2
X2FkZHIgYW5kIG1seDVlX2hhbmRsZV9uZXRkZXZfYWRkciBub3cgdGFrZQ0KPiBleHBsaWNpdCB1
Yy9tYyBsaXN0IHBhcmFtZXRlcnMgYW5kIGl0ZXJhdGUgd2l0aA0KPiBuZXRkZXZfaHdfYWRkcl9s
aXN0X2Zvcl9lYWNoIGluc3RlYWQgb2YgbmV0ZGV2X2Zvcl9lYWNoX3t1YyxtY31fYWRkci4NCj4g
DQo+IEZhbGxiYWNrIHRvIG5ldGRldidzIHVjL21jIGluIGEgZmV3IHBsYWNlcyBhbmQgZ3JhYiBh
ZGRyIGxvY2suDQo+IA0KPiBDYzogU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPg0K
PiBDYzogVGFyaXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gQ2M6IENvc21pbiBSYXRp
dSA8Y3JhdGl1QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBGb21pY2hl
diA8c2RmQGZvbWljaGV2Lm1lPg0KPiAtLS0NCj4gwqAuLi4vbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9lbi9mcy5owqDCoCB8wqAgNSArKy0NCj4gwqAuLi4vbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9lbl9mcy5jwqDCoCB8IDMzICsrKysrKysrKysrKysrLS0tDQo+IC0t
DQo+IMKgLi4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jIHwgMTYg
KysrKysrLS0tDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAxNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5v
eC9tbHg1L2NvcmUvZW4vZnMuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21s
eDUvY29yZS9lbi9mcy5oDQo+IGluZGV4IGMzNDA4YjNmNzAxMC4uMDkxYjgwYTY3MTg5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vZnMu
aA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vZnMu
aA0KPiBAQCAtMjAxLDcgKzIwMSwxMCBAQCBpbnQgbWx4NWVfYWRkX3ZsYW5fdHJhcChzdHJ1Y3QN
Cj4gbWx4NWVfZmxvd19zdGVlcmluZyAqZnMsIGludMKgIHRyYXBfaWQsIGludCB0aXJfbnUNCj4g
wqB2b2lkIG1seDVlX3JlbW92ZV92bGFuX3RyYXAoc3RydWN0IG1seDVlX2Zsb3dfc3RlZXJpbmcg
KmZzKTsNCj4gwqBpbnQgbWx4NWVfYWRkX21hY190cmFwKHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVy
aW5nICpmcywgaW50wqAgdHJhcF9pZCwNCj4gaW50IHRpcl9udW0pOw0KPiDCoHZvaWQgbWx4NWVf
cmVtb3ZlX21hY190cmFwKHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcyk7DQo+IC12b2lk
IG1seDVlX2ZzX3NldF9yeF9tb2RlX3dvcmsoc3RydWN0IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZz
LA0KPiBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KTsNCj4gK3ZvaWQgbWx4NWVfZnNfc2V0X3J4
X21vZGVfd29yayhzdHJ1Y3QgbWx4NWVfZmxvd19zdGVlcmluZyAqZnMsDQo+ICsJCQnCoMKgwqDC
oMKgwqAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwNCj4gKwkJCcKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqdWMsDQo+ICsJCQnCoMKgwqDCoMKgwqAgc3RydWN0IG5l
dGRldl9od19hZGRyX2xpc3QgKm1jKTsNCj4gwqBpbnQgbWx4NWVfZnNfdmxhbl9yeF9hZGRfdmlk
KHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcywNCj4gwqAJCQnCoMKgwqDCoCBzdHJ1Y3Qg
bmV0X2RldmljZSAqbmV0ZGV2LA0KPiDCoAkJCcKgwqDCoMKgIF9fYmUxNiBwcm90bywgdTE2IHZp
ZCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2Nv
cmUvZW5fZnMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bl9mcy5jDQo+IGluZGV4IDkzNTJlMjE4MzMxMi4uMzQ2OWI1YTE5N2RiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fZnMuYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fZnMuYw0KPiBAQCAt
NjEwLDIwICs2MTAsMzEgQEAgc3RhdGljIHZvaWQgbWx4NWVfZXhlY3V0ZV9sMl9hY3Rpb24oc3Ry
dWN0DQo+IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZzLA0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMg
dm9pZCBtbHg1ZV9zeW5jX25ldGRldl9hZGRyKHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVyaW5nICpm
cywNCj4gLQkJCQnCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ICsJCQkJwqDCoCBz
dHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2LA0KPiArCQkJCcKgwqAgc3RydWN0IG5ldGRldl9od19h
ZGRyX2xpc3QgKnVjLA0KPiArCQkJCcKgwqAgc3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKm1j
KQ0KPiDCoHsNCj4gwqAJc3RydWN0IG5ldGRldl9od19hZGRyICpoYTsNCj4gKwlib29sIHVubG9j
ayA9IGZhbHNlOw0KPiDCoA0KPiAtCW5ldGlmX2FkZHJfbG9ja19iaChuZXRkZXYpOw0KPiArCWlm
ICghdWMgfHwgIW1jKSB7DQo+ICsJCXVjID0gJm5ldGRldi0+dWM7DQo+ICsJCW1jID0gJm5ldGRl
di0+bWM7DQo+ICsNCj4gKwkJbmV0aWZfYWRkcl9sb2NrX2JoKG5ldGRldik7DQo+ICsJCXVubG9j
ayA9IHRydWU7DQo+ICsJfQ0KPiDCoA0KPiDCoAltbHg1ZV9hZGRfbDJfdG9faGFzaChmcy0+bDIu
bmV0ZGV2X3VjLCBuZXRkZXYtPmRldl9hZGRyKTsNCj4gLQluZXRkZXZfZm9yX2VhY2hfdWNfYWRk
cihoYSwgbmV0ZGV2KQ0KPiArDQo+ICsJbmV0ZGV2X2h3X2FkZHJfbGlzdF9mb3JfZWFjaChoYSwg
dWMpDQo+IMKgCQltbHg1ZV9hZGRfbDJfdG9faGFzaChmcy0+bDIubmV0ZGV2X3VjLCBoYS0+YWRk
cik7DQo+IMKgDQo+IC0JbmV0ZGV2X2Zvcl9lYWNoX21jX2FkZHIoaGEsIG5ldGRldikNCj4gKwlu
ZXRkZXZfaHdfYWRkcl9saXN0X2Zvcl9lYWNoKGhhLCBtYykNCj4gwqAJCW1seDVlX2FkZF9sMl90
b19oYXNoKGZzLT5sMi5uZXRkZXZfbWMsIGhhLT5hZGRyKTsNCj4gwqANCj4gLQluZXRpZl9hZGRy
X3VubG9ja19iaChuZXRkZXYpOw0KPiArCWlmICh1bmxvY2spDQo+ICsJCW5ldGlmX2FkZHJfdW5s
b2NrX2JoKG5ldGRldik7DQo+IMKgfQ0KDQpSYXRoZXIgdGhhbiB0aGUgbG9jay91bmxvY2sgZGFu
Y2UsIHdvdWxkbid0IGNhbGxpbmcgdGhlIHNhbWUgZnVuY3Rpb24NCnJlY3Vyc2l2ZWx5IChndWFy
YW50ZWVkIG9uY2UpIGxvb2sgY2xlYW5lcjoNCg0KaWYgKCF1YyB8fCAhbWMpIHsNCiAgICAgICAg
bmV0ZGV2X2FkZHJfbG9ja19iaChuZXRkZXYpOw0KICAgICAgICBtbHg1ZV9zeW5jX25ldGRldl9h
ZGRyKGZzLCBuZXRkZXYsIG5ldGRldi0+dWMsIG5ldGRldi0+bWMpOw0KICAgICAgICBuZXRkZXZf
YWRkcl91bmxvY2tfYmgobmV0ZGV2KTsNCiAgICAgICAgcmV0dXJuOw0KfQ0KDQo+IMKgDQo+IMKg
c3RhdGljIHZvaWQgbWx4NWVfZmlsbF9hZGRyX2FycmF5KHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVy
aW5nICpmcywNCj4gaW50IGxpc3RfdHlwZSwNCj4gQEAgLTcyNSw3ICs3MzYsOSBAQCBzdGF0aWMg
dm9pZCBtbHg1ZV9hcHBseV9uZXRkZXZfYWRkcihzdHJ1Y3QNCj4gbWx4NWVfZmxvd19zdGVlcmlu
ZyAqZnMpDQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIG1seDVlX2hhbmRsZV9uZXRkZXZf
YWRkcihzdHJ1Y3QgbWx4NWVfZmxvd19zdGVlcmluZyAqZnMsDQo+IC0JCQkJwqDCoMKgwqAgc3Ry
dWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gKwkJCQnCoMKgwqDCoCBzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmV0ZGV2LA0KPiArCQkJCcKgwqDCoMKgIHN0cnVjdCBuZXRkZXZfaHdfYWRkcl9saXN0ICp1
YywNCj4gKwkJCQnCoMKgwqDCoCBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqbWMpDQo+IMKg
ew0KPiDCoAlzdHJ1Y3QgbWx4NWVfbDJfaGFzaF9ub2RlICpobjsNCj4gwqAJc3RydWN0IGhsaXN0
X25vZGUgKnRtcDsNCj4gQEAgLTczNyw3ICs3NTAsNyBAQCBzdGF0aWMgdm9pZCBtbHg1ZV9oYW5k
bGVfbmV0ZGV2X2FkZHIoc3RydWN0DQo+IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZzLA0KPiDCoAkJ
aG4tPmFjdGlvbiA9IE1MWDVFX0FDVElPTl9ERUw7DQo+IMKgDQo+IMKgCWlmIChmcy0+c3RhdGVf
ZGVzdHJveSkNCj4gLQkJbWx4NWVfc3luY19uZXRkZXZfYWRkcihmcywgbmV0ZGV2KTsNCj4gKwkJ
bWx4NWVfc3luY19uZXRkZXZfYWRkcihmcywgbmV0ZGV2LCB1YywgbWMpOw0KPiDCoA0KPiDCoAlt
bHg1ZV9hcHBseV9uZXRkZXZfYWRkcihmcyk7DQo+IMKgfQ0KPiBAQCAtODIxLDcgKzgzNCw5IEBA
IHN0YXRpYyB2b2lkIG1seDVlX2Rlc3Ryb3lfcHJvbWlzY190YWJsZShzdHJ1Y3QNCj4gbWx4NWVf
Zmxvd19zdGVlcmluZyAqZnMpDQo+IMKgfQ0KPiDCoA0KPiDCoHZvaWQgbWx4NWVfZnNfc2V0X3J4
X21vZGVfd29yayhzdHJ1Y3QgbWx4NWVfZmxvd19zdGVlcmluZyAqZnMsDQo+IC0JCQnCoMKgwqDC
oMKgwqAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gKwkJCcKgwqDCoMKgwqDCoCBzdHJ1
Y3QgbmV0X2RldmljZSAqbmV0ZGV2LA0KPiArCQkJwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRkZXZf
aHdfYWRkcl9saXN0ICp1YywNCj4gKwkJCcKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0ZGV2X2h3X2Fk
ZHJfbGlzdCAqbWMpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgbWx4NWVfbDJfdGFibGUgKmVhID0gJmZz
LT5sMjsNCj4gwqANCj4gQEAgLTg1MSw3ICs4NjYsNyBAQCB2b2lkIG1seDVlX2ZzX3NldF9yeF9t
b2RlX3dvcmsoc3RydWN0DQo+IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZzLA0KPiDCoAlpZiAoZW5h
YmxlX2Jyb2FkY2FzdCkNCj4gwqAJCW1seDVlX2FkZF9sMl9mbG93X3J1bGUoZnMsICZlYS0+YnJv
YWRjYXN0LA0KPiBNTFg1RV9GVUxMTUFUQ0gpOw0KPiDCoA0KPiAtCW1seDVlX2hhbmRsZV9uZXRk
ZXZfYWRkcihmcywgbmV0ZGV2KTsNCj4gKwltbHg1ZV9oYW5kbGVfbmV0ZGV2X2FkZHIoZnMsIG5l
dGRldiwgdWMsIG1jKTsNCj4gwqANCj4gwqAJaWYgKGRpc2FibGVfYnJvYWRjYXN0KQ0KPiDCoAkJ
bWx4NWVfZGVsX2wyX2Zsb3dfcnVsZShmcywgJmVhLT5icm9hZGNhc3QpOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYw0KPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmMNCj4gaW5k
ZXggZjcwMDlkYTk0ZjBiLi5lODZjZjFlZTEwOGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYw0KPiBAQCAtNDEwOCwxMSAr
NDEwOCwxNiBAQCBzdGF0aWMgdm9pZCBtbHg1ZV9uaWNfc2V0X3J4X21vZGUoc3RydWN0DQo+IG1s
eDVlX3ByaXYgKnByaXYpDQo+IMKgCXF1ZXVlX3dvcmsocHJpdi0+d3EsICZwcml2LT5zZXRfcnhf
bW9kZV93b3JrKTsNCj4gwqB9DQo+IMKgDQo+IC1zdGF0aWMgdm9pZCBtbHg1ZV9zZXRfcnhfbW9k
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiArc3RhdGljIHZvaWQgbWx4NWVfc2V0X3J4X21v
ZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4gKwkJCcKgwqDCoMKgwqAgc3RydWN0IG5ldGRl
dl9od19hZGRyX2xpc3QgKnVjLA0KPiArCQkJwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0ZGV2X2h3X2Fk
ZHJfbGlzdCAqbWMpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdiA9IG5ldGRl
dl9wcml2KGRldik7DQo+IMKgDQo+IC0JbWx4NWVfbmljX3NldF9yeF9tb2RlKHByaXYpOw0KPiAr
CWlmIChtbHg1ZV9pc191cGxpbmtfcmVwKHByaXYpKQ0KPiArCQlyZXR1cm47IC8qIG5vIHJ4IG1v
ZGUgZm9yIHVwbGluayByZXAgKi8NCj4gKw0KPiArCW1seDVlX2ZzX3NldF9yeF9tb2RlX3dvcmso
cHJpdi0+ZnMsIGRldiwgdWMsIG1jKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIGludCBtbHg1
ZV9zZXRfbWFjKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIHZvaWQgKmFkZHIpDQo+IEBAIC01
Mjg3LDcgKzUyOTIsNyBAQCBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgbWx4NWVfbmV0ZGV2
X29wcyA9DQo+IHsNCj4gwqAJLm5kb19zZXR1cF90Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBt
bHg1ZV9zZXR1cF90YywNCj4gwqAJLm5kb19zZWxlY3RfcXVldWXCoMKgwqDCoMKgwqDCoCA9IG1s
eDVlX3NlbGVjdF9xdWV1ZSwNCj4gwqAJLm5kb19nZXRfc3RhdHM2NMKgwqDCoMKgwqDCoMKgwqAg
PSBtbHg1ZV9nZXRfc3RhdHMsDQo+IC0JLm5kb19zZXRfcnhfbW9kZcKgwqDCoMKgwqDCoMKgwqAg
PSBtbHg1ZV9zZXRfcnhfbW9kZSwNCj4gKwkubmRvX3NldF9yeF9tb2RlX2FzeW5jwqDCoCA9IG1s
eDVlX3NldF9yeF9tb2RlLA0KPiDCoAkubmRvX3NldF9tYWNfYWRkcmVzc8KgwqDCoMKgID0gbWx4
NWVfc2V0X21hYywNCj4gwqAJLm5kb192bGFuX3J4X2FkZF92aWTCoMKgwqDCoCA9IG1seDVlX3Zs
YW5fcnhfYWRkX3ZpZCwNCj4gwqAJLm5kb192bGFuX3J4X2tpbGxfdmlkwqDCoMKgID0gbWx4NWVf
dmxhbl9yeF9raWxsX3ZpZCwNCj4gQEAgLTYyNzIsOCArNjI3NywxMSBAQCB2b2lkIG1seDVlX3Nl
dF9yeF9tb2RlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiDCoHsNCj4gwqAJ
c3RydWN0IG1seDVlX3ByaXYgKnByaXYgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0DQo+IG1s
eDVlX3ByaXYsDQo+IMKgCQkJCQnCoMKgwqDCoMKgwqAgc2V0X3J4X21vZGVfd29yayk7DQo+ICsJ
c3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHByaXYtPm5ldGRldjsNCj4gwqANCj4gLQlyZXR1cm4g
bWx4NWVfZnNfc2V0X3J4X21vZGVfd29yayhwcml2LT5mcywgcHJpdi0+bmV0ZGV2KTsNCj4gKwlu
ZXRkZXZfbG9ja19vcHMoZGV2KTsNCj4gKwltbHg1ZV9mc19zZXRfcnhfbW9kZV93b3JrKHByaXYt
PmZzLCBkZXYsIE5VTEwsIE5VTEwpOw0KPiArCW5ldGRldl91bmxvY2tfb3BzKGRldik7DQo+IMKg
fQ0KPiDCoA0KPiDCoC8qIG1seDVlIGdlbmVyaWMgbmV0ZGV2IG1hbmFnZW1lbnQgQVBJIChtb3Zl
IHRvIGVuX2NvbW1vbi5jKSAqLw0KDQo=

