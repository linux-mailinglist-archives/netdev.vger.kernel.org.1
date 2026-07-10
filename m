Return-Path: <netdev+bounces-306591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Km3QEkYCUWqK9wIAu9opvQ
	(envelope-from <netdev+bounces-306591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703473BC14
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=t0I4wXo4;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306591-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306591-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5B1304C2EB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14B345CBE;
	Fri, 10 Jul 2026 14:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCA30C154;
	Fri, 10 Jul 2026 14:23:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693409; cv=fail; b=h9zJh3/tqPN70eUWl7pGXQsPEaebU0atHy+RurTRZ9lOu9Bu8SaOf3hHRfilGZVdKRKsn4MkEgl6av8/Pg/Os5tkQt/UVRPhIi/e1tTpg5uSDxc3JhZDISYTwK50FolUpP4SasNIYkxmFnRUV8bk7oWCtjds1EctKJa/CIWQ9vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693409; c=relaxed/simple;
	bh=VU3Yz5zFi1Cv5e7K8gCTrfXWttACyQGB52lmub2Opew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FDM9l02z4wk794+BpEG7xNDT3r4Fxr3brdNrrwb64iym55C3+QQxg2w8c0e5cdzPXcriO22Zv3D6bF5bDhQO7z3Q1Bm1rKORr4mEzNaUx8s8Pj9Yj6a95otx03O8ipSCahWACp41zkU3xi5XLIvI5rfhuIdxTerd/KWPUyW9sx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=t0I4wXo4; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQvswy+XiV6ICz0uiBvamYEJmqy5SmJrJbtXTwx9rSyZZQ+IO85UEydOrbndwWKz5LF3/pwLTbDgyIBwPkUluZheitOTVe99CZtGsTkwzSGaYSo/H5qAbSSi24m/y+dt1d63cQi7JKZDJCarNgBYChkVhh2QsGSfJ9K7uqo1Dcvzc4kmLBX/rBFsKp9vzFangi6j2BnK6W7cuBc1zzq+xtO1UEGl0oY774sj8r9xb82YXhDXEWBPLi9yqQV7S+APhwHuStRjFPUbfs6wiaLD0ekqKoikI5nhhqdBUB4rCEXWdH+1y4IA+Rco57iTQcjhFNZ/mb5tHV+D+LIPYFwqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU3Yz5zFi1Cv5e7K8gCTrfXWttACyQGB52lmub2Opew=;
 b=cFv/emzcMkTTNATNjKD3QEZS3RoTzy8yidMYk2fC1Z3+3GhVaMI4YOMxW5OOyf+cqhF4iLOQQfdcMtW65VPOZ/G2Pk9j4sjaOqIiAvrrdJC1veuWyccugsJb9P1Dzt157MzuiEDMNezkDsnz3s5GSWVDCWmAruPVFMmNp+FnJ01OyhXmaSjOEwvOeAi+zCK6I3f6nMOIwFkGa+9qr36UueuOfkpsnVCeQq0DAiIEvFk3SwRXasa+MX4hRrDwJr8JT7w7BA0xkLICjWm+bWSXSZ4hQPe2dhyNxoCyMqk/lWUG67VfQkR3EAoTgGWN7wRqyBunS1vlbxSG2hPlanIyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU3Yz5zFi1Cv5e7K8gCTrfXWttACyQGB52lmub2Opew=;
 b=t0I4wXo4U3Kw1mWFMbmdMM83nQXBAAQe40Y5rpotUrGjmatRE6EocGyVJkALSpS3T0FafNBbapKFcnLWkXQSr/8Xi+yZ5QWrsWmXx+N2Mc2X5EDcNx6bl5B7e97XP+5XHQAAEB6amptdV44Xgm8oNpfPau8Y5ZPPW6Q24dRD2dg7nVKDvKs1Io3JhO/icJej0D6QcFqsq01PB6aFjvBHLpLuPKdhu9518mufMemmv/6Q+3bF3wUWIcFiTvQxLVHbqnoHvuhABq8Yb7LQ2LAtDb1tj28ZenVN3Df39n7IQxEjvWye7m9vE1+EIhdOQLCxjPsz1A22ftXSEPmiHqwFMQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI1P18901MB0608.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:122::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Fri, 10 Jul
 2026 14:23:23 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Fri, 10 Jul 2026
 14:23:22 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "AutonomousCodeSecurity@microsoft.com"
	<AutonomousCodeSecurity@microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Cen Zhang (Microsoft)"
	<blbllhy@gmail.com>
Subject: RE: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Thread-Topic: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer
 MTU validation
Thread-Index: AQHdD+hHh2DWAInb/ECCJxp8DbA8n7ZmtBDAgAAVtoCAAAJXQA==
Date: Fri, 10 Jul 2026 14:23:22 +0000
Message-ID:
 <GV1P189MB19886E2AAE761FE04DF113EDC6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260709211649.15623-1-blbllhy@gmail.com>
 <GV1P189MB1988A52C474B5F7D7A9EC00CC6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <a5bc092d-3312-4b1c-94cc-4a8bed6c6588@linux.dev>
In-Reply-To: <a5bc092d-3312-4b1c-94cc-4a8bed6c6588@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI1P18901MB0608:EE_
x-ms-office365-filtering-correlation-id: 0f3fab89-5161-4f88-c4c3-08dede8ecc3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|13003099007|56012099006|22082099003|18002099003|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 +ZL84INluXRYUzqI7Sb5x8LqOCQhZ7wyz+Fhj1MjjQn+pXYBouFf9mI7olNiKnTf3pEQ1093ZBMVwa14F9fXaCBNZQd2xgOGD5RF7hnbA+dbmVZzxlAWJuKUx4DA97kFDxK4ahODlGL0vTdRuyoAYpcuqmse1kDxgDNyAaTUrAdbiDxyUOJW2h82h/3GsdR+vNklVNtimMzbII7K2zqt+1jOPqUS9YalNTFvl8L51TZRGUHasgVQq28eOHo4zptX/9/TEekGW3xxpikmpteeYVOois0P7uTjcleGwHi2V1lQUa3klNoyQzJhs8sMawOamNOQ9uXWuq8G82BdjghvPqbvJ7bc28jMM0Z3MwzrBmvVuM177eycdGFjr9V8cwr2qkQCMl16eM5GIPvo6zt7JZv3STwfZjV8SgLJqudHFBLmH/6Hg6UdD99rKQlbxJz6m1Bv/CnbLjiiEenckszKDxO2ZlCKhZNXL/Jhk4dyReYxeX3PCyV6yN44c77w8P/7RyQEpHudeuxOOYpVgNZZDi6dh8l4l8pNDcTKUIqj6BpeRPRfS4XBvtnxMDdxdXkJieAarPi3aUc06yzZbkrvMwfzZxGhc7ZgzFwd+t33wDg2+IkCfYlblltbs6WXFsty5pkzRvuW1c02AxJSffJlzXNOw2/madKr/hUwZRagFaLqA4Tqo8LaExfnhKa/Dmou7bZ2zRvpnehTJ36jTINskilwpOrn98XCflmHano18eU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(13003099007)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnRyQTNyQjhJbXQ1Vm83cGl1OGVkWGVwaWlGYUdnTzVFTmhlb0ZZaTlBWTNW?=
 =?utf-8?B?VkxQQ3V5Rm9xQ3dpeGNvRWo0a1A3RFBBU3ZDcjRSLzFrdUFKNkJuaHdRbG9P?=
 =?utf-8?B?aWZPMWJwSTd1NXZLN3I1eFFkejRJVmxKWlR0eVhKR3owRXpKNmJ4ZkQxaFFW?=
 =?utf-8?B?OUZsL2VhZi95a0pKZ2hzUytjOVc0MUtxRlltWVYxOE1lZDAvbzNvRThub2s4?=
 =?utf-8?B?Q0pHY3pQOSswUkdrSlZiOFNRVGQyenlkR0d6bWxPVVRtWmNvR0QvbUtVclBt?=
 =?utf-8?B?amF0ZFA5cEhoaTBKTVFvZmFITklqVVRIL0NBRGJzbXEzaUxUdmtHL21BNnhw?=
 =?utf-8?B?NGphK1JMTkRZR2NpaTdYZGVkRnFhT0lXemd6a0txN1R3YU1qNEs4aWRRdHND?=
 =?utf-8?B?b0cvUkcxN3Ivcjg0TU5BNE8rNC8rMG56VzBKVS96K2xKWXRZb2diNkxJbExn?=
 =?utf-8?B?cWhVK2wxcSs2NTl2NG1VTWgwRk5HZVQxRXVmUGxrWEFjSEJUU2ZxYmpnM2xJ?=
 =?utf-8?B?ZmxkWXBGbkdzWDFZWmswZmpkNGlJaXhITmdlbTA3ekg3SWw4aFIrU0lWMjFq?=
 =?utf-8?B?ZnhVSjdPcFJGck9Sd21yOTNscDV1eHM4SXRJa0ZlQUQ0NnM0Y0c5aW54dUts?=
 =?utf-8?B?OXhLT0NLeUZoblRieE05a25hbE5LMEJyYndoTkhZTk1qa1FjOXJGUlFKZTJp?=
 =?utf-8?B?dDY2QkdTVjJpMFN2d2VKTy9EUUVKMWVqWEZNVlFrKzZPM0ZkL3pSNjBpbHkw?=
 =?utf-8?B?aFBobThqMW5ZUXdyRW03T3BOak9VYUoveUpyb2VFc0ZZWmQ5R3ZkTFI5WDdM?=
 =?utf-8?B?eGxnQTlXeU93dnhaSHVJWFE1OWRHV1RkU2FVR1I5aFEwb1REYTF4WE04WDd6?=
 =?utf-8?B?QUdOMEtDbnh6TjVKK2R5VnpBeW5QZDRwMCsrYXNubVRjQ09vZlJ1TFdRSnZj?=
 =?utf-8?B?eGNBM1J6VVVBNHoyenZxbnBUYkFYenV4SExEZFFEYmY4eU16V3UrZmQxU2tu?=
 =?utf-8?B?Yk9id1BPYXd5S2g5a0huWXpaREU3T2tMdkJXdXczUlZackpGTWNGbXZuQkJD?=
 =?utf-8?B?eUswcUZUbjMreFRtdGZOdkJoSE5FTFhCVFFVSDNVTHVkWHl1SGFZYUxNSk9s?=
 =?utf-8?B?amxFZVhnNGpWYVl4R2MrZThhRVFLTHpqL0x0akk0ZkRtVmFqQ1dTSnhPRFhW?=
 =?utf-8?B?TVA4VFdGV3pxTFkzNWdJdS84Q0pQY2ZnTC83eEFzUmhSZjdBNTZYL1o3R1Bz?=
 =?utf-8?B?SDlGZ0ZGdGxEVkhlc0ViMmV0R0lzNmlrZkNCUDlzeEdOSGwzcWdqbHF6TkZs?=
 =?utf-8?B?LzB3bEJmZUxBSnptL0V3OUFINllhejNRTXdpTkFVYzcxSXJ0UkFhSHBtZ2J2?=
 =?utf-8?B?UDZuUzdJRUkwL3FPc0MrT2JhOGpnQlVFdWZ6WW5wMTkwNTUxRk55aktpRUpu?=
 =?utf-8?B?RzZ5TElSWU5KRFRURUdaNGs3cWNEcFdmNEFNczhJNkc4SHFPZ051bzJ3VmVj?=
 =?utf-8?B?YmFNUG1JMnZ1RUljL2ZTYU1yZFR3TlU3RHBDQUExTTdMVmphU0hpWUVHMENv?=
 =?utf-8?B?WE9DNUZCVVBIZzErQTRXa2NsV1g2bGE1emd4bHcwWVVNV0RMWlVseFMzeEs0?=
 =?utf-8?B?azZYS3gxcUduVnVRQVZ5RmtWOXhvWmZuU1FiczV4RlFQaVRSR3o1TFZSdGJs?=
 =?utf-8?B?NjB6MDR5RTVTWExsMDkybWcxNnVobjNwUmFnbkg1ZnRCTXBLcy9nOHowT3ZU?=
 =?utf-8?B?TmtvSnZuV1ZqTUxkb2lTOGo1RG90NkpacERiSU0wUUNVQTFxckpKSFNsU0tJ?=
 =?utf-8?B?ZC9DVnZjTGlmdHZDZXB2d0srb1RYWWowTFBla3lTT0NSZVJNanZYaTJKNkdz?=
 =?utf-8?B?Y1dWbTAwMHZPUnROWndFRk5oMGJNZlBhRWJwMkE5c2lxYXdnVkFvdG9GVDRE?=
 =?utf-8?B?NHJMM25PTkYzdzVYa0hQS0tua3ptVHh2RkV4a0lCc3NQRkRSczV4QWZFYlJL?=
 =?utf-8?B?YmlyQi80amZ1TGFWOENmL2pxVGdIV3RacHlPMkxWWVkwRTJwTWkyMWllTHJp?=
 =?utf-8?B?TGZnNS91aDhtSy9LNHp2Uzdsc1FGSjhlQXJ6ekhwYlNpUFhxVm5NclNmMzh5?=
 =?utf-8?B?ZGsxOHlIZVI2ZjJPYlRZeUVFWVpxc3lzUE05VkpwcHh6eGJEcUpQam9Uenpl?=
 =?utf-8?B?alNOTEVsQ3oweHJLVy9vRkw5cm5VdXY4SnUxYjZZbGRoRk4zZVkvTEN5MVVu?=
 =?utf-8?B?Rks5Nm5ieDNrZ1hDdGx6SXNKMi9ibTUxM3lOczRzc3BOcHBpd1VRY0liYi92?=
 =?utf-8?B?cXZNb28vNkFjbG04a0lKazBROXh0TWd3UFNSVUlQMTNBL0tTOUVsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3fab89-5161-4f88-c4c3-08dede8ecc3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 14:23:22.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJzMa7rIQJ470kt8q5nIYQqnDrH41oUtT2lZ5qbfB9zSMx9McjcsaFEsL0im3Mt2rXNR6HEXRDMIE+4/CBm3FB4J/nYc4t/pjDWii/JCDrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0608
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:blbllhy@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306591-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,microsoft.com,linux.microsoft.com,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,est.tech:from_mime,est.tech:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9703473BC14

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHY0XSB0aXBjOiBmaXggdTE2IE1UVSB0cnVuY2F0aW9u
IGluIG1lZGlhIGFuZCBiZWFyZXINCj5NVFUgdmFsaWRhdGlvbg0KPg0KPk9uIDEwLzA3LzIwMjYg
MTM6NTcsIFR1bmcgUXVhbmcgTmd1eWVuIHdyb3RlOg0KPj4+IFN1YmplY3Q6IFtQQVRDSCBuZXQg
djRdIHRpcGM6IGZpeCB1MTYgTVRVIHRydW5jYXRpb24gaW4gbWVkaWEgYW5kDQo+Pj4gYmVhcmVy
IE1UVSB2YWxpZGF0aW9uDQo+Pj4NCj4+PiBCb3RoIFRJUENfTkxfTUVESUFfU0VUIGFuZCBUSVBD
X05MX0JFQVJFUl9TRVQgYWNjZXB0IHVzZXItc3VwcGxpZWQNCj4+PiBNVFUgdmFsdWVzIGJ1dCBv
bmx5IGVuZm9yY2UgYSBtaW5pbXVtIGJvdW5kLCBub3QgYSBtYXhpbXVtLiBXaGVuIGENCj4+PiB1
c2VyIHNldHMgdGhlIE1UVSB0byBhIHZhbHVlIGV4Y2VlZGluZyBVMTZfTUFYICg2NTUzNSksIGl0
IHBhc3Nlcw0KPj4+IHZhbGlkYXRpb24gYnV0IGlzIHNpbGVudGx5IHRydW5jYXRlZCB3aGVuIGFz
c2lnbmVkIHRvIHUxNiBmaWVsZHMNCj4+PiBsLT5tdHUgYW5kDQo+Pj4gbC0+YWR2ZXJ0aXNlZF9t
dHUgaW4gdGlwY19saW5rX2NyZWF0ZSgpLiBWYWx1ZXMgbGlrZSA2NTUzNiAoMHgxMDAwMCkNCj4+
PiB0cnVuY2F0ZSB0byAwLCBjYXVzaW5nIGEgZGl2aXNpb24gYnkgemVybyBpbg0KPj4+IHRpcGNf
bGlua19zZXRfcXVldWVfbGltaXRzKCkgd2hpY2ggY29tcHV0ZXMgVElQQ19NQVhfUFVCTCAvIChs
LT5tdHUgLw0KPj4+IElURU1fU0laRSkuIE90aGVyIG92ZXJmbG93aW5nIHZhbHVlcyAoZS5nLiA2
NTUzNy0xMzEwNzEpIHByb2R1Y2UNCj4+PiBzbWFsbCBpbmNvcnJlY3QgTVRVIHZhbHVlcywgcmVz
dWx0aW5nIGluIGxpbmsgbWFsZnVuY3Rpb24gYmVoYXZpb3JzLg0KPj4NCj4+IFllcywgdGhpcyBp
cyBhIGJ1Zy4gSSBjYW4gcmVwcm9kdWNlIHRoZSBzYW1lIGRpdi1ieS16ZXJvLg0KPj4NCj4+Pg0K
Pj4+IENyYXNoIHN0YWNrICh0cmlnZ2VyZWQgYXMgdW5wcml2aWxlZ2VkIHVzZXIgdmlhIHVzZXIg
bmFtZXNwYWNlKToNCj4+Pg0KPj4+ICAgdGlwY19saW5rX3NldF9xdWV1ZV9saW1pdHMgIG5ldC90
aXBjL2xpbmsuYzoyNTMxDQo+Pj4gICB0aXBjX2xpbmtfY3JlYXRlICAgICAgICAgICAgbmV0L3Rp
cGMvbGluay5jOjUyMA0KPj4+ICAgdGlwY19ub2RlX2NoZWNrX2Rlc3QgICAgICAgIG5ldC90aXBj
L25vZGUuYzoxMjc5DQo+Pj4gICB0aXBjX2Rpc2NfcmN2ICAgICAgICAgICAgICAgbmV0L3RpcGMv
ZGlzY292ZXIuYzoyNTINCj4+PiAgIHRpcGNfcmN2ICAgICAgICAgICAgICAgICAgICBuZXQvdGlw
Yy9ub2RlLmM6MjEyOQ0KPj4+ICAgdGlwY191ZHBfcmVjdiAgICAgICAgICAgICAgIG5ldC90aXBj
L3VkcF9tZWRpYS5jOjM5Mg0KPj4+DQo+Pj4gVHdvIGluZGVwZW5kZW50IHBhdGhzIGxhY2sgdGhl
IHVwcGVyIGJvdW5kIGNoZWNrOg0KPj4+IDEuIHRpcGNfdWRwX210dV9iYWQoKSAtLSBjYWxsZWQg
ZnJvbSBfX3RpcGNfbmxfbWVkaWFfc2V0KCkgKE1FRElBX1NFVCkNCj4yLg0KPj4+IGlubGluZSBj
aGVjayBpbiBfX3RpcGNfbmxfYmVhcmVyX3NldCgpIGF0IGJlYXJlci5jOjExNjAgKEJFQVJFUl9T
RVQpDQo+Pj4NCj4+PiBGaXggYm90aCBieSByZWplY3RpbmcgTVRVIHZhbHVlcyBhYm92ZSBVMTZf
TUFYLg0KPj4+DQo+Pj4gRml4ZXM6IDkwMTI3MWUwNDAzYSAoInRpcGM6IGltcGxlbWVudCBjb25m
aWd1cmF0aW9uIG9mIFVEUCBtZWRpYQ0KPj4+IE1UVSIpDQo+Pj4gUmVwb3J0ZWQtYnk6IEF1dG9u
b21vdXNDb2RlU2VjdXJpdHlAbWljcm9zb2Z0LmNvbQ0KPj4+IENsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL0NBQjhtOVdnRVR0MEFqbUZ3RT1GLQ0KPj4+IENLakdYc0s2X1dEdjA9
a2JZUmNDOC1ub28rYW1uQUBtYWlsLmdtYWlsLmNvbQ0KPj4+IFNpZ25lZC1vZmYtYnk6IENlbiBa
aGFuZyAoTWljcm9zb2Z0KSA8YmxibGxoeUBnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4gdjQ6IEFk
ZCAubWluIGNoZWNrIHZhbHVlDQo+Pj4gdjM6IFVzZSBubGFfcG9saWN5IGNoZWNrIHRvIGxpbWl0
IE1UVSBtYXggdmFsdWUgYXMgc3VnZ2VzdGVkIGJ5IFZhZGltDQo+Pj4gdjI6IFNvbHZlZCBmb3Jt
YXQgaXNzdWUNCj4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FCOG05V2dF
VHQwQWptRndFPUYtDQo+Pj4gQ0tqR1hzSzZfV0R2MD1rYllSY0M4LW5vbythbW5BQG1haWwuZ21h
aWwuY29tDQo+Pj4NCj4+PiBuZXQvdGlwYy9uZXRsaW5rLmMgfCA3ICsrKysrKy0NCj4+PiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvbmV0L3RpcGMvbmV0bGluay5jIGIvbmV0L3RpcGMvbmV0bGluay5jIGluZGV4DQo+
Pj4gODMzNmE5NjY0NzAzLi44MTE0MzhjNDQ1NDIgMTAwNjQ0DQo+Pj4gLS0tIGEvbmV0L3RpcGMv
bmV0bGluay5jDQo+Pj4gKysrIGIvbmV0L3RpcGMvbmV0bGluay5jDQo+Pj4gQEAgLTExMywxMiAr
MTEzLDE3IEBAIGNvbnN0IHN0cnVjdCBubGFfcG9saWN5DQo+Pj4gdGlwY19ubF9ub2RlX3BvbGlj
eVtUSVBDX05MQV9OT0RFX01BWCArIDFdID0geyAgfTsNCj4+Pg0KPj4+IC8qIFByb3BlcnRpZXMg
dmFsaWQgZm9yIG1lZGlhLCBiZWFyZXIgYW5kIGxpbmsgKi8NCj4+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCBuZXRsaW5rX3JhbmdlX3ZhbGlkYXRpb24gdGlwY19ubF9tdHVfcmFuZ2UgPSB7DQo+Pj4g
KwkubWluID0gVElQQ19NSU5fQkVBUkVSX01UVSwNCj4+DQo+PiBBZGRpbmcgbG93ZXIgdGhyZXNo
b2xkIGNoZWNraW5nIGludHJvZHVjZXMgdHdvIGlzc3VlczoNCj4+IDEuIEV4aXN0aW5nIGZ1bmN0
aW9uIHRpcGNfdWRwX210dV9iYWQoKSBjYW4gbmV2ZXIgcmV0dXJuICJ0cnVlIi4NCj4NCj5pdCBj
YW4uIGlmIE1UVSBpcyBpbiB0aGUgcmFuZ2UgW1RJUENfTUlOX0JFQVJFUl9NVFUsDQo+VElQQ19N
SU5fQkVBUkVSX01UVQ0KPisgc2l6ZW9mKGlwaGRyKSArIHNpemVvZih1ZHBoZHIpXQ0KDQpUaGUg
Y29udGV4dCBJIHdhcyB0YWxraW5nIGFib3V0IGlzIGVycm9yIHBhdGggKG10dSA8IG1pbikgYXMg
c2hvd24gaW4gZXhhbXBsZXMuIFRoaXMgbWFrZXMgYWRkaW5nIC5taW4gY2hlY2sgcmVkdW5kYW50
Lg0KICAgICAgICAgICAgICAgIA0KPg0KPj4gMi4gQnJlYWtpbmcgdXNlci1zcGFjZSBhcHBsaWNh
dGlvbnMgbG9va2luZyBmb3IgZXJyb3IgbWVzc2FnZSAiIEVycm9yOiBNVFUNCj52YWx1ZSBpcyBv
dXQtb2YtcmFuZ2UiLiBMb29rIGF0IHRoZSBlcnJvciBtZXNzYWdlcyBiZWZvcmUgYW5kIGFmdGVy
IHlvdXIgcGF0Y2g6DQo+PiBbQmVmb3JlIHBhdGNoXQ0KPj4gbm9kZTEgfiAjIHRpcGMgYmVhcmVy
IHNldCBtdHUgMTUgbWVkaWEgdWRwIG5hbWUgVURQMA0KPj4gRXJyb3I6IE1UVSB2YWx1ZSBpcyBv
dXQtb2YtcmFuZ2UuDQo+PiBrZXJuZWwgYW5zd2VyczogSW52YWxpZCBhcmd1bWVudA0KPj4NCj4+
IFtBZnRlciAgcGF0Y2hdDQo+PiBub2RlMSB+ICMgdGlwYyBiZWFyZXIgc2V0IG10dSAxNSBtZWRp
YSB1ZHAgbmFtZSBVRFAwIGtlcm5lbCBhbnN3ZXJzOg0KPj4gTnVtZXJpY2FsIHJlc3VsdCBvdXQg
b2YgcmFuZ2UNCj4NCj50aGF0J3MgaW50ZXJlc3RpbmcsIGJlY2F1c2UgdGhpcyBlcnJvciBtZXNz
YWdlIGJlbG9uZ3MgdG8gOXAgc2NvcGUuLi4NCj4NCj5hbnl3YXlzLCB3ZSBjYW4ga2VlcCB2MyBv
ZiB0aGlzIHBhdGNoIHdpdGggLm1heCB2YWx1ZSBzZXQgb25seQ0KPg0KPg0KPj4NCj4+PiArCS5t
YXggPSBVMTZfTUFYLA0KPj4+ICt9Ow0KPj4+ICsNCj4+PiBjb25zdCBzdHJ1Y3QgbmxhX3BvbGlj
eSB0aXBjX25sX3Byb3BfcG9saWN5W1RJUENfTkxBX1BST1BfTUFYICsgMV0gPSB7DQo+Pj4gCVtU
SVBDX05MQV9QUk9QX1VOU1BFQ10JCT0geyAudHlwZSA9IE5MQV9VTlNQRUMgfSwNCj4+PiAJW1RJ
UENfTkxBX1BST1BfUFJJT10JCT0geyAudHlwZSA9IE5MQV9VMzIgfSwNCj4+PiAJW1RJUENfTkxB
X1BST1BfVE9MXQkJPSB7IC50eXBlID0gTkxBX1UzMiB9LA0KPj4+IAlbVElQQ19OTEFfUFJPUF9X
SU5dCQk9IHsgLnR5cGUgPSBOTEFfVTMyIH0sDQo+Pj4gLQlbVElQQ19OTEFfUFJPUF9NVFVdCQk9
IHsgLnR5cGUgPSBOTEFfVTMyIH0sDQo+Pj4gKwlbVElQQ19OTEFfUFJPUF9NVFVdCQk9DQo+Pj4g
TkxBX1BPTElDWV9GVUxMX1JBTkdFKE5MQV9VMzIsICZ0aXBjX25sX210dV9yYW5nZSksDQo+Pj4g
CVtUSVBDX05MQV9QUk9QX0JST0FEQ0FTVF0JPSB7IC50eXBlID0gTkxBX1UzMiB9LA0KPj4+IAlb
VElQQ19OTEFfUFJPUF9CUk9BRENBU1RfUkFUSU9dCT0geyAudHlwZSA9IE5MQV9VMzIgfQ0KPj4+
IH07DQo+Pj4gLS0NCj4+PiAyLjUzLjANCj4+DQoNCg==

