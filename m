Return-Path: <netdev+bounces-282764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICdWEg8w82m0yAEAu9opvQ
	(envelope-from <netdev+bounces-282764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B12554A0E11
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FEA5300D69A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EDB38AC8D;
	Thu, 30 Apr 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fi5Bq0Lh"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6C3793C3;
	Thu, 30 Apr 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545226; cv=fail; b=Ju4Q0ilDULqGFt45iZlejhOKVnyr/IWhlgYKS/Fm6KCaK4vMYgptwbrmuz+BUQoO3CJ/C4u0LzGaLABE90LUWDdkCPnNbRCgPTtf4YtGSvDT7n92udgQYewzLyRjtZr8+GYX7BIkqxCPmNn0vzCRMm5+MTzXZb7aiPsip4GeJJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545226; c=relaxed/simple;
	bh=vEim3Nlko0pFsBSmIYXI4oLg17wGtQEWBpbptDAijMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+ZpSa05PiD6KV2CvpnsggePj+ZBYUEeLEWH3vNdwk4PE3wzRNUj0puE+SKhI1+72eC4k3ndNMWyIw4Nutg+FXZgapeiBAWKcBWoUvyIX/w+ysIWj3s7G/SFagCgdXfOQiVlGStGKLse35bTn3eQ9ruhlO3AZGn07k4Va5bfgqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fi5Bq0Lh; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGhjdwbGyhjwccra1DALSCXqmJxOluRBzHZrvIRsNHsqCj5tRGyhHmVJXS6IH5P6DGbRux82tb0TkJ0dugfF3qWsef/ltSqVdEj20oHmBSb01IacuD5ovwlQmLA9cNpCvjG+FrsPBqGia9EHweJog5ODY0WDOnAT42LlScX5ur+16sjHzUIIY1ouvZKQdmfJeIB15y7FSJvYLtvSLpkL6n6jT0xwBnwtJvV5YnITcHgFB4hvxcnIt/p4z+yh5//6QgZ4vpz6qlDTn7xYSCkd9YGRBd82k+G/5FKbgGgyG1bfipebbCYUq3CMKNNXY88u4g32oGOZ99rFbp6XcOsFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEim3Nlko0pFsBSmIYXI4oLg17wGtQEWBpbptDAijMY=;
 b=bSpa/vK4pzJchbEMpyA8lIKktBDw/+JTYjgO/Ry8Vm/imWVWz6GHoOhVU2NLY6kuD2kh44ZIRUz8ZXflpzBd09a64LS8yFdcLn5VyqIJpJxYgRQxTxhP0TdOau2cKEgRoF1dDFtkHEaUiEqPd0bhGU5dWIOHnjR/Bp0iKlnXqEPK0F2LwNoyikCbhcwA1WJBPkQfqsLLUgv2u5YBSVqno4cMoUWjq9JvM4xx/qbr+xz+cn+ORq949i9g7BR91AIa/CLliX8Q0n8lu7rJkfNMfcDgjKCb658vOu67RU+LHLU3/mzAJjM3lTZZ0114625/Zt6Ap9HES93JDEFtaBUjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEim3Nlko0pFsBSmIYXI4oLg17wGtQEWBpbptDAijMY=;
 b=Fi5Bq0Lhcm+TFVz3G6x/r/b0YfVNgC1RLRsprwWHrM4yGTPV8jB5MQG5h9M0ZbQUp+gWxqDyFfa8YgOb7JTKJgfwm6jFgpqL3Ir4bFswxCjvN2Ornt1dMOzQWSzXijQQ/MJaerA4+mR/nvKzJf6SDFKxoM872sFYGJ43rviEqvxZE9yVr63HVqrfekCnwkuLHeBIsbt+/N94/dS78JshuNyZi56HRpgCpn+TA1uIamKT9rj0qfz3sokY//f/WZOsC0eCsLg8kfB/qhod7QsY/+0qSsfFBy9rrbDb8ScrQEjQZlI6VHgqAoiwz8TntdzgfLVgdspF7YyYF3juxicL7A==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 10:33:40 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9870.022; Thu, 30 Apr 2026
 10:33:39 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "razor@blackwall.org" <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH net-next 1/2] bridge: Do not suppress ARP probes and DAD
 NS unconditionally
Thread-Topic: [PATCH net-next 1/2] bridge: Do not suppress ARP probes and DAD
 NS unconditionally
Thread-Index: AQHc16DnPRj3QDa/LEqKL1BqjTTuPLX3abLQ
Date: Thu, 30 Apr 2026 10:33:38 +0000
Message-ID:
 <DM6PR12MB451618D785F300F4B78F742AD8352@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260429062405.1386417-1-danieller@nvidia.com>
 <20260429062405.1386417-2-danieller@nvidia.com>
In-Reply-To: <20260429062405.1386417-2-danieller@nvidia.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA0PR12MB8302:EE_
x-ms-office365-filtering-correlation-id: 30a39c0c-14eb-42d4-ef63-08dea6a3f159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 dySM/i33MILW6aI16SRgu96G6X8rQXyyCaiyBOxWc1Cdb9umeyBK2MCKTBEgJe9d6/KHnrwjfQIUROao+NAqMXNodJ5PzYZ9ev3gcDqhwoGh4PEwE2XP1gsHzv+hcznmifdnjmvv/dvCCBkNVzbJDLuxCpBt1nHl16joDE8ds2bdaQlO7QAt+Bhr1S850PXeWrM+pS0QRFp/znRW4tdLccRnao80ArGRjO4BOoIqVPpISCIVq7q3G+ehssXtrk9r4V4hrXlwbrbuvR0Y4XEL35cmTV9xWPn6cnl/y35X4KmN2WRKhgccq265aODEONdVKbw6L+w0507mfJB0OliTFlFoD+vn0dIpmBFluyBFu33sbgVVTU4KhZuCwHmvvUlj6AYQVMEw4/GP9cynZjf071gD98RC2XSmQIyMjaeCAnD++VMsPU8sS+aYew8rpwHJHj8LcXF7g20AObwNpWoAXMqeIityqVTxwFX9NQ4iAAgtqsFgqmfZRfJYkzhMwbqwZWjHW4WpyBvdjhRPu21cHuUSgiNeB1yPYCtpbVEjIYlmmp4rFvrCfQEE8gy3XPx5pBb3+eLand6gap8r50Zap8F/WrBbWS4aET18Xmm2UfiLg+SVgSJWwg1rOubmKv4Fkz0jmXOts9ooprLLDtxDDxvF56G/5CvsKrRMF1dj+sW/M95o+0qMUSqt9BJmxSfssxNtY246zPMoMD4Wk4P0Z+qAgcOyNyIOtIoNk3XYserO+46dXUH2o0x5WJ9bWnYbD+DYfFtQFmMBw2d/v06CN4teMQd/nUadgXFQrtlpHt4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlpycWRzcFVyMnJxS1FKMDhLK2pxU3ZhQjVvRDU3YVdDNXhSRDFGRjBac05B?=
 =?utf-8?B?eDVNRk5hd1YvZUhXZnQrNWVnMnUxdEZEK3g1N3FpMGhHeTF6cWJidGpjV1lR?=
 =?utf-8?B?WEFMRzhheTNkNnNzMGhFUk9OekxzZDlJOW9xWU9QMDAvb2g1Q2dQaDUrRVJ1?=
 =?utf-8?B?a3VPOElRRmQwWmVqczg0VjV5N1JNdHF2QUVJZWZ3ODFubHZKUTF2MEJRaDRt?=
 =?utf-8?B?N3h6VE1qVlpFcUNtV1dsZzJxNVRSWkRCd2RjejdBRmkvTGEwdnVoYlU4S05t?=
 =?utf-8?B?RUMvRHBIRlJ0VURHdmlXTG1vYm5LNE5aWmtYTjVBVHlXZzdvdzIycGx1aVNK?=
 =?utf-8?B?d0JoeUpyMzFuczF4dFhKdGs3VEtmVjQrSTFicFluTXl6Wm4yWEg2L0t4L2py?=
 =?utf-8?B?ZGM1Mkg2QWhGbHNPampyQnd4Kzl0cW95ZGNMY3J3USs2c2FWaEdiVGVjNFJS?=
 =?utf-8?B?NTBUclpmcFVLSjJsbkc0Y1puWW9tWFZhbWdtcVZXa1JjOHJIbmJJUG1Jazk2?=
 =?utf-8?B?SkZMQXBNMmh3VVUxZ3Q1d01EYmVkdmlVSU5MOFRXM2xxR3FJMU9HblEzWG84?=
 =?utf-8?B?cU84ZnlMRHJGME1TM09sWGEwOUtnWEwrZmExM1JFQVBsS2hWVFIwUHZtSjZE?=
 =?utf-8?B?ZWl3YkhDelhqWHEvbFVrUkZHbGZKbDIrbjNlamFrZWRUL1NBeUYveGJ3ZDla?=
 =?utf-8?B?K2VEMkZNbjhNRWR0TVdtbTJoOWFUSnJNazg4Z1JadEpXTlZFRHE3MUNFY2lC?=
 =?utf-8?B?VCtCT3NzOFpCTVh1aGNuaEVnRWhhMzFIQWxwemU5ZGdRcFd4STRTZEk4Ykhz?=
 =?utf-8?B?OThYU3FFQ0R5UDd1c3E5T0hHb2ErVTZENWdId042VmRlS3B6NkxaQlVudklE?=
 =?utf-8?B?bUFRQWdsU0d1QWk0RDl0NjExc01KMitsRWlmcjBYYjMwNFBxVUg1ZWJrT2dw?=
 =?utf-8?B?cmpIb1BwZTd3SDdVa0dGT29TbGpxVUxXWkYxVkcySTFtd1NPa3kzMStPNGdD?=
 =?utf-8?B?bVhEamNzTG1ZTnRTM3lqdDRRc3d3WHlrbExJSXJmaHpWeDlPOHNTSjJBNVF4?=
 =?utf-8?B?NFl1V0pyTGNWR3NKTUtsK1g0bGpLbnlmSnIydFpSaE14WWtNQkxhMXJGNU1I?=
 =?utf-8?B?SUlXWUtEKzhOek5ja1liUlBQNGRBMkhoaEhlbTZBdlZvbjNZbUxPYkd2Qjdm?=
 =?utf-8?B?U2FCcXlYWTgydWJBWUQ1bzhoeUEzS3pILzBXUlo4NjMzc091b0RhaUUzQ3NV?=
 =?utf-8?B?TjZyaGV3Z2ZWdXZxaEprT3I1eFZqbTY1bXM5ODdEblNsTHQ4OXdQaGxvYjZi?=
 =?utf-8?B?Q20xSlFNNlQ4N0lqT1FId0tVVnJkOHhKYWtpUFBlYnZBZEVFakF6MFJqZ1Q5?=
 =?utf-8?B?c1BFcEFRcWRPcGpkR2Z4aXE3TTVmMDFTSENZMkoyM2Q5RExGT2x6b0NXRXkz?=
 =?utf-8?B?bWxXU25DTWVqa1Y4Myt4NnU3VXFrTEJEWjZ0SzFWcVNJemhUMGlDM04xcWs3?=
 =?utf-8?B?RW1EZnRKcjE2dTF1ZWFwellSZlcwR1VUQ1BzaTVWZ1UwRnFISmpOUjRmU0t3?=
 =?utf-8?B?anJ2bEpZcTM4MUNOYWRlTGQweVd2RXh6SzVzMVJ1anpFMG1RVWZKVElDRmJD?=
 =?utf-8?B?V2FabTdNbXBxamZReEJIOFNGVFZxY2hlSFhDa0huSlNkL3p3UVpSQlp3b3Ji?=
 =?utf-8?B?R0owWnRQeWlEcjJvV3VERHlYS0xURUNRUUVNZmgveUpmZk5aZFlHcStBZzBi?=
 =?utf-8?B?VE1DekJtVXlHNUpxeG14VWp6N2FEZUN5Vk5ENHhycEo2MHA2NmZrMTBwY3ZX?=
 =?utf-8?B?REN6Q1lLWis3Qm9zeHptTWs2ZG5QaEx5T0ZkQzhZTkY5UmgwNk5KUm5iRmtZ?=
 =?utf-8?B?V001b1pNUVc3Sy9lcEpCRFJwOGt0eDF2Ymd2TnhCUU52ODc2L3ZaTjRtaFZi?=
 =?utf-8?B?NTN3dHMzVTltVmdMK1RldE9UTk9pYXJBeUdmRmhRT2tVSEFGOERDS0Z0MENO?=
 =?utf-8?B?OWJsdDR5RmhZOXQ4Zm15RFM4NjUyYU1PQUVDbmpWMWVyM0xZK21CR1ZxeGRk?=
 =?utf-8?B?Nk5wQW5HWjVETUZZSHgwMnlML3hoekpHaFhYQ0RMd3JQT0tUTkZzUlpyYVM1?=
 =?utf-8?B?OTFuQ2hkTVVmZytkSFpvODVZcXQvMWpCZ0NDRldvZ3dPUmQyMzRONXpsVEdo?=
 =?utf-8?B?T0c4L2w0QVdUNVppWjRtSEp0QnVWTWtmWkxielh1U0NsOUNpWiswUy95SEdx?=
 =?utf-8?B?OWRNQmhFY2RkbjA3N0hoRmI5emhLL05IOVoxbCt1MTlkTVZXVldvdFRGb3Zz?=
 =?utf-8?Q?DcEoRuIxGUExEt2bqJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a39c0c-14eb-42d4-ef63-08dea6a3f159
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 10:33:39.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkY1nAWW1X7AcWRp+qO3ppWuFMRW+I38r6vsB86cdSggbXneFlvbA6vUvRgVjfymTTnJTWBWrEbWfx9xSEDcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
X-Rspamd-Queue-Id: B12554A0E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282764-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWxsZSBSYXRzb24gPGRh
bmllbGxlckBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI5IEFwcmlsIDIwMjYgOToy
NA0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogcmF6b3JAYmxhY2t3YWxsLm9y
ZzsgSWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhh
dC5jb207IGhvcm1zQGtlcm5lbC5vcmc7IHNodWFoQGtlcm5lbC5vcmc7DQo+IGJyaWRnZUBsaXN0
cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrc2Vs
ZnRlc3RAdmdlci5rZXJuZWwub3JnOyBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgMS8yXSBicmlkZ2U6IERvIG5vdCBzdXBw
cmVzcyBBUlAgcHJvYmVzIGFuZCBEQUQNCj4gTlMgdW5jb25kaXRpb25hbGx5DQo+IA0KPiBXaGVu
IG5laWdoYm9yIHN1cHByZXNzaW9uIGlzIGVuYWJsZWQgb24gYSBWWExBTiBwb3J0LCB0aGUgYnJp
ZGdlIGlzDQo+IGV4cGVjdGVkIHRvIHJlcGx5IHRvIEFSUC9OUyBtZXNzYWdlcyBvbiBiZWhhbGYg
b2YgcmVtb3RlIGhvc3RzIHdoZW4gYm90aA0KPiBGREIgYW5kIG5laWdoYm9yIGVudHJpZXMgZXhp
c3QuIFRoaXMgYWxsb3dzIHRoZSBicmlkZ2UgdG8gc3VwcHJlc3MgZmxvb2Rpbmcgb2YNCj4gdGhl
c2UgbWVzc2FnZXMgdG8gdGhlIFZYTEFOIG92ZXJsYXkuDQo+IA0KPiBBY2NvcmRpbmcgdG8gUkZD
IDkxNjEgKCJPcGVyYXRpb25hbCBBc3BlY3RzIG9mIFByb3h5IEFSUC9ORCBpbiBFdGhlcm5ldA0K
PiBWaXJ0dWFsIFByaXZhdGUgTmV0d29ya3MiKToNCj4gIkEgUEUgU0hPVUxEIHJlcGx5IHRvIGJy
b2FkY2FzdC9tdWx0aWNhc3QgYWRkcmVzcyByZXNvbHV0aW9uIG1lc3NhZ2VzLCBpLmUuLA0KPiBB
UlAgUmVxdWVzdHMsIEFSUCBwcm9iZXMsIE5TIG1lc3NhZ2VzLCBhcyB3ZWxsIGFzIERBRCBOUyBt
ZXNzYWdlcy4NCj4gQW4gQVJQIHByb2JlIGlzIGFuIEFSUCBSZXF1ZXN0IGNvbnN0cnVjdGVkIHdp
dGggYW4gYWxsLXplcm8gc2VuZGVyIElQDQo+IGFkZHJlc3MgdGhhdCBtYXkgYmUgdXNlZCBieSBo
b3N0cyBmb3IgSVB2NCBBZGRyZXNzIENvbmZsaWN0IERldGVjdGlvbiBhcw0KPiBzcGVjaWZpZWQg
aW4gW1JGQzUyMjddIi4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
IHVuY29uZGl0aW9uYWxseSBzdXBwcmVzc2VzIEFSUCBwcm9iZXMNCj4gYW5kIERBRCBOZWlnaGJv
ciBTb2xpY2l0YXRpb25zLCB3aGljaCBicmVha3MgRHVwbGljYXRlIEFkZHJlc3MgRGV0ZWN0aW9u
DQo+IChEQUQpIG92ZXIgRVZQTi4NCj4gDQo+IEZvciBEQUQgdG8gd29yayBjb3JyZWN0bHkgb3Zl
ciB0aGUgVlhMQU4gZmFicmljOg0KPiAtIFdoZW4gdGhlIGJyaWRnZSBkb2VzIG5vdCBrbm93IHRo
ZSBhbnN3ZXI6DQo+ICAgZmxvb2QgdGhlIHByb2JlL0RBRCBwYWNrZXQgdG8gYWxsb3cgcmVtb3Rl
IFZURVBzIHRvIHJlc3BvbmQuDQo+IC0gV2hlbiB0aGUgYnJpZGdlIGtub3dzIHRoZSBhbnN3ZXI6
DQo+ICAgcmVwbHkgdG8gaW5kaWNhdGUgdGhlIGFkZHJlc3MgaXMgaW4gdXNlLg0KPiANCj4gRml4
IGJ5IGFkanVzdGluZyB0aGUgZWFybHkgc3VwcHJlc3Npb24gY2hlY2tzIHRvIGV4Y2x1ZGUgQVJQ
IHByb2JlcyBhbmQgREFEDQo+IE5TIGZyb20gdW5jb25kaXRpb25hbCBzdXBwcmVzc2lvbi4NCj4g
DQo+IFdoZW4gcmVwbHlpbmcgdG8gYSBEQUQgTlMsIGJyX25kX3NlbmQoKSBpcyBhZGp1c3RlZCB0
byBzZXQgdGhlIE5BIGRlc3RpbmF0aW9uDQo+IHRvIHRoZSBhbGwtbm9kZXMgbXVsdGljYXN0IGFk
ZHJlc3MgKGZmMDI6OjEpIGFuZCBjbGVhciB0aGUgU29saWNpdGVkIGZsYWcsIGluDQo+IGFjY29y
ZGFuY2Ugd2l0aCBSRkMgNDg2MSBzZWN0aW9uIDcuMi40Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IElk
byBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbGxl
IFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgbmV0L2JyaWRnZS9icl9h
cnBfbmRfcHJveHkuYyB8IDE2ICsrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9i
cmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMgYi9uZXQvYnJpZGdlL2JyX2FycF9uZF9wcm94eS5jDQo+
IGluZGV4IGRlYjFhYjFmMjRiMC4uMzIwNTM0NmYyOThjIDEwMDY0NA0KPiAtLS0gYS9uZXQvYnJp
ZGdlL2JyX2FycF9uZF9wcm94eS5jDQo+ICsrKyBiL25ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5
LmMNCj4gQEAgLTE2NCw3ICsxNjQsNyBAQCB2b2lkIGJyX2RvX3Byb3h5X3N1cHByZXNzX2FycChz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIsDQo+ICAJCQlyZXR1
cm47DQo+ICAJCWlmIChwYXJwLT5hcl9vcCAhPSBodG9ucyhBUlBPUF9SUkVRVUVTVCkgJiYNCj4g
IAkJICAgIHBhcnAtPmFyX29wICE9IGh0b25zKEFSUE9QX1JSRVBMWSkgJiYNCj4gLQkJICAgIChp
cHY0X2lzX3plcm9uZXQoc2lwKSB8fCBzaXAgPT0gdGlwKSkgew0KPiArCQkgICAgc2lwID09IHRp
cCkgew0KPiAgCQkJLyogcHJldmVudCBmbG9vZGluZyB0byBuZWlnaCBzdXBwcmVzcyBwb3J0cyAq
Lw0KPiAgCQkJQlJfSU5QVVRfU0tCX0NCKHNrYiktPnByb3h5YXJwX3JlcGxpZWQgPSAxOw0KPiAg
CQkJcmV0dXJuOw0KPiBAQCAtMjYyLDYgKzI2Miw3IEBAIHN0YXRpYyB2b2lkIGJyX25kX3NlbmQo
c3RydWN0IG5ldF9icmlkZ2UgKmJyLCBzdHJ1Y3QNCj4gbmV0X2JyaWRnZV9wb3J0ICpwLA0KPiAg
CWludCBuc19vbGVuOw0KPiAgCWludCBpLCBsZW47DQo+ICAJdTggKmRhZGRyOw0KPiArCWJvb2wg
ZGFkOw0KPiAgCXUxNiBwdmlkOw0KPiANCj4gIAlpZiAoIWRldiB8fCBza2JfbGluZWFyaXplKHJl
cXVlc3QpKQ0KPiBAQCAtMzAwLDggKzMwMSwxMyBAQCBzdGF0aWMgdm9pZCBicl9uZF9zZW5kKHN0
cnVjdCBuZXRfYnJpZGdlICpiciwgc3RydWN0DQo+IG5ldF9icmlkZ2VfcG9ydCAqcCwNCj4gIAkJ
fQ0KPiAgCX0NCj4gDQo+ICsJZGFkID0gaXB2Nl9hZGRyX2FueSgmaXB2Nl9oZHIocmVxdWVzdCkt
PnNhZGRyKTsNCj4gKw0KPiAgCS8qIEV0aGVybmV0IGhlYWRlciAqLw0KPiAtCWV0aGVyX2FkZHJf
Y29weShldGhfaGRyKHJlcGx5KS0+aF9kZXN0LCBkYWRkcik7DQo+ICsJaWYgKGRhZCkNCj4gKwkJ
aXB2Nl9ldGhfbWNfbWFwKCZpbjZhZGRyX2xpbmtsb2NhbF9hbGxub2RlcywNCj4gZXRoX2hkcihy
ZXBseSktPmhfZGVzdCk7DQo+ICsJZWxzZQ0KPiArCQlldGhlcl9hZGRyX2NvcHkoZXRoX2hkcihy
ZXBseSktPmhfZGVzdCwgZGFkZHIpOw0KPiAgCWV0aGVyX2FkZHJfY29weShldGhfaGRyKHJlcGx5
KS0+aF9zb3VyY2UsIG4tPmhhKTsNCj4gIAlldGhfaGRyKHJlcGx5KS0+aF9wcm90byA9IGh0b25z
KEVUSF9QX0lQVjYpOw0KPiAgCXJlcGx5LT5wcm90b2NvbCA9IGh0b25zKEVUSF9QX0lQVjYpOw0K
PiBAQCAtMzE3LDcgKzMyMyw3IEBAIHN0YXRpYyB2b2lkIGJyX25kX3NlbmQoc3RydWN0IG5ldF9i
cmlkZ2UgKmJyLCBzdHJ1Y3QNCj4gbmV0X2JyaWRnZV9wb3J0ICpwLA0KPiAgCXBpcDYtPnByaW9y
aXR5ID0gaXB2Nl9oZHIocmVxdWVzdCktPnByaW9yaXR5Ow0KPiAgCXBpcDYtPm5leHRoZHIgPSBJ
UFBST1RPX0lDTVBWNjsNCj4gIAlwaXA2LT5ob3BfbGltaXQgPSAyNTU7DQo+IC0JcGlwNi0+ZGFk
ZHIgPSBpcHY2X2hkcihyZXF1ZXN0KS0+c2FkZHI7DQo+ICsJcGlwNi0+ZGFkZHIgPSBkYWQgPyBp
bjZhZGRyX2xpbmtsb2NhbF9hbGxub2RlcyA6DQo+ICtpcHY2X2hkcihyZXF1ZXN0KS0+c2FkZHI7
DQo+ICAJcGlwNi0+c2FkZHIgPSAqKHN0cnVjdCBpbjZfYWRkciAqKW4tPnByaW1hcnlfa2V5Ow0K
PiANCj4gIAlza2JfcHVsbChyZXBseSwgc2l6ZW9mKHN0cnVjdCBpcHY2aGRyKSk7IEBAIC0zMzAs
NyArMzM2LDcgQEAgc3RhdGljDQo+IHZvaWQgYnJfbmRfc2VuZChzdHJ1Y3QgbmV0X2JyaWRnZSAq
YnIsIHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnAsDQo+ICAJbmEtPmljbXBoLmljbXA2X3R5cGUg
PSBORElTQ19ORUlHSEJPVVJfQURWRVJUSVNFTUVOVDsNCj4gIAluYS0+aWNtcGguaWNtcDZfcm91
dGVyID0gKG4tPmZsYWdzICYgTlRGX1JPVVRFUikgPyAxIDogMDsNCj4gIAluYS0+aWNtcGguaWNt
cDZfb3ZlcnJpZGUgPSAxOw0KPiAtCW5hLT5pY21waC5pY21wNl9zb2xpY2l0ZWQgPSAxOw0KPiAr
CW5hLT5pY21waC5pY21wNl9zb2xpY2l0ZWQgPSBkYWQgPyAwIDogMTsNCg0KSGksIA0KDQpTYXNo
aWtvIHdyb3RlOg0KPiBTaG91bGQgdGhlIG92ZXJyaWRlIGZsYWcgYWxzbyBiZSBjb25kaXRpb25h
bGx5IGNsZWFyZWQgd2hlbiByZXNwb25kaW5nIHRvIGENCj4gREFEIHNvbGljaXRhdGlvbj8NCj4g
QWNjb3JkaW5nIHRvIFJGQyA0ODYxIHNlY3Rpb24gNy4yLjQsIHRoZSBPdmVycmlkZSBmbGFnIHNo
b3VsZCBub3QgYmUgc2V0DQo+IHdoZW4gcmVzcG9uZGluZyB0byBEQUQgc29saWNpdGF0aW9ucyAo
d2hlcmUgdGhlIHNvdXJjZSBhZGRyZXNzIGlzDQo+IHVuc3BlY2lmaWVkKS4NCg0KVGhlIE5BIHNl
bnQgaW4gcmVzcG9uc2UgdG8gYSBEQUQgTlMgaXMgYW4gdW5zb2xpY2l0ZWQgYWR2ZXJ0aXNlbWVu
dC0gdGhlIFNvbGljaXRlZCBmbGFnIGlzIGV4cGxpY2l0bHkgY2xlYXJlZCBmb3IgdGhpcyBjYXNl
Og0KDQpuYS0+aWNtcGguaWNtcDZfc29saWNpdGVkID0gZGFkID8gMCA6IDE7DQoNClJGQyA0ODYx
IHNlY3Rpb24gNC40IGRlZmluZXMgd2hlbiB0aGUgT3ZlcnJpZGUgZmxhZyBzaG91bGQgYmUgc2V0
Og0KDQoiSXQgU0hPVUxEIE5PVCBiZSBzZXQgaW4gc29saWNpdGVkIGFkdmVydGlzZW1lbnRzIGZv
ciBhbnljYXN0IGFkZHJlc3NlcyBhbmQgaW4gc29saWNpdGVkIHByb3h5IGFkdmVydGlzZW1lbnRz
LiBJdCBTSE9VTEQgYmUgc2V0IGluIG90aGVyIHNvbGljaXRlZCBhZHZlcnRpc2VtZW50cyBhbmQg
aW4gdW5zb2xpY2l0ZWQgYWR2ZXJ0aXNlbWVudHMuIg0KDQpTaW5jZSBhIERBRCByZXNwb25zZSBp
cyBhbiB1bnNvbGljaXRlZCBhZHZlcnRpc2VtZW50LCBPdmVycmlkZSBTSE9VTEQgYmUgc2V0LCBz
byBsZWF2aW5nIGljbXA2X292ZXJyaWRlID0gMSB1bmNvbmRpdGlvbmFsbHkgaXMgY29ycmVjdC4N
Cg0KVGhpcyBpcyBhbHNvIGNvbnNpc3RlbnQgd2l0aCBob3cgdGhlIExpbnV4IGhvc3Qgc3RhY2sg
YmVoYXZlcy4gQSByZWd1bGFyIExpbnV4IGhvc3QgcmVzcG9uZGluZyB0byBhIERBRCBwcm9iZSBz
ZW5kczoNCg0KMTI6MDg6MTMuMzkxMTM4IDVlOjc5OmQxOjIyOjg5OjYxID4gMzM6MzM6ZmY6MDA6
MDA6MDIsIGV0aGVydHlwZSBJUHY2ICgweDg2ZGQpLCBsZW5ndGggODY6IChobGltIDI1NSwgbmV4
dC1oZWFkZXIgSUNNUHY2ICg1OCksIHBheWxvYWQgbGVuZ3RoIDMyKSA6OiA+IGZmMDI6OjE6ZmYw
MDoyOiBbaWNtcDYgc3VtIG9rXSBJQ01QNiwgbmVpZ2hib3Igc29saWNpdGF0aW9uLCBsZW5ndGgg
MzIsIHdobyBoYXMgMjAwMTpkYjg6MTo6Mg0KICAgICAgICAgICAgICAgIHVua25vd24gb3B0aW9u
ICgxNCksIGxlbmd0aCA4ICgxKToNCiAgICAgICAgICAgICAgICAgIDB4MDAwMDogIGQ3M2YgNDVi
NyA1MzQzDQoxMjowODoxMy4zOTI4NjcgNzY6OTM6ZGQ6YTA6Yzc6N2QgPiAzMzozMzowMDowMDow
MDowMSwgZXRoZXJ0eXBlIElQdjYgKDB4ODZkZCksIGxlbmd0aCA4NjogKGhsaW0gMjU1LCBuZXh0
LWhlYWRlciBJQ01QdjYgKDU4KSwgcGF5bG9hZCBsZW5ndGggMzIpIDIwMDE6ZGI4OjE6OjIgPiBm
ZjAyOjoxOiBbaWNtcDYgc3VtIG9rXSBJQ01QNiwgbmVpZ2hib3IgYWR2ZXJ0aXNlbWVudCwgbGVu
Z3RoIDMyLCB0Z3QgaXMgMjAwMTpkYjg6MTo6MiwgRmxhZ3MgW292ZXJyaWRlXQ0KICAgICAgICAg
ICAgICAgIGRlc3RpbmF0aW9uIGxpbmstYWRkcmVzcyBvcHRpb24gKDIpLCBsZW5ndGggOCAoMSk6
IDc2OjkzOmRkOmEwOmM3OjdkDQogICAgICAgICAgICAgICAgICAweDAwMDA6ICA3NjkzIGRkYTAg
Yzc3ZA0KDQpUaGUgTkEgaGFzIE92ZXJyaWRlIHNldCBidXQgbm8gU29saWNpdGVkIGZsYWcsIGNv
bnNpc3RlbnQgd2l0aCBSRkMgNDg2MSBzZWN0aW9uIDQuNC4NCg==

