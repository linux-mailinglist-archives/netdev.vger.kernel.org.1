Return-Path: <netdev+bounces-275538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIPED9Zu02nAiAcAu9opvQ
	(envelope-from <netdev+bounces-275538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CB3A2359
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85453006B77
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920731196F;
	Mon,  6 Apr 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mZPKewV7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807432F7AAB
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775464147; cv=fail; b=XAJMSC/yX8NOI7uFaeHJMDyxojBbjXdtGEQ5ftXaEtculr5ZRenYT/3Rui0qq3H9cjT1GTdQhdgB5SZ+ukYBzlycF9UJiBiaDa3E0r2VjlvTdzKoH6YHmEAfymJAzQ2fe85KJoddrfNvhG5/xecp5AqsiJTkuO57hmLb2z0LCxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775464147; c=relaxed/simple;
	bh=a/sE51lkFvCkgxtdFlqyQoxsfmo/agd7cnmJwBW9QtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQNqwirc0gNz9IPb4/PvsdwtL1zsc+TNIx586JBuRPyoXgRS+RUsbux39ZqbxUoEJXRBM3zMrLAZtQpD/8s9se1F88nZt3/6BygkGyNG+K8HMdh2RSK4firI1dA2vOKnULXEesKvtOfmoinCbqemAkaZ6a27jaEyTlMXKLF3yas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mZPKewV7; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXuWiJDFa9O9UbVq2ZRtLU9lgMol4cyuEQqKdb1bBQ3W+LMaFAWp1eqJqovBI7BCPk6o2ou9GBdEsjfi/5Z4xbl3eKVO19lwsioG3kRtUJPSGvjVkWWKBNtCodrfM1CxoLlGZlQGWtlbuc2UJvcfjm0SJelWWmcfJ/i9zIIA9n8EcTRvMw8X0iINMHCrjZM96I1th56FBsHV6vy78aC2H8GWYGhx63uuB83EZL23eF1ams0xxotoDEQdZcv42PKPEYRGrCeVjTgIiFpxUxu0zQr5ScJfVu/KIO8w4ZlUuzbkMFvwIKBRdzbbnfWHcJXBWUc4Uk1mvopxSvMmBDKxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU2QzCVNUY6HsNLLVdTb+wfQaNeeRq/sGaAtOMb6kIY=;
 b=eX7QPgk1qfcRevGzbX7hVO38Ids3ufeXQOxkZPfAVyBI2nEhcw4Z0eDxcBAZNWr3yKtGmzPXulI8Gw0ypPdIuX6aI9jgHNt4pmJ/6+GTFAiNjBbzah2++B5G3vwekJRHy3G7lZGoxu08IKnhqFomrS9anEyJI2XtpxcMifts1fNWoOc31iAHH54SyZMnRuVn0dZRdVWNsHAysvSBq3cuvNc7/TBA9if55Smf3IxcXGYIzp7yVMx1P8QRtJavkTWT68KXZt2Z2az8Lb94Ko/gZrYnYybD4bGeXemG4+LiyWF3LqdJC+s7Jk1OB7XMSFVIXjMmgxjEWAag1NDxman9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU2QzCVNUY6HsNLLVdTb+wfQaNeeRq/sGaAtOMb6kIY=;
 b=mZPKewV7k717XNnE3U1wBvzwDat0UFNg0qNhWbkJZRh5o8l3VaT7VMwJJMQN6DIWtFCHhQ+/+cQqTScL+LQXoWf6b8z5evAcZ+tdQTQU0i7HysnifpPGDVd9SvNM8XW+OOG9qZr5wj5vozucRXdR7ahVWqwrE2bl7lAW5qwto1M3QZwdspaA45h7P3ts2Wy1ym864FGXd3fZMOZdIterO0+V2u3wG1DVPYJYNzP1zMKa/hDbnZMe2tv8v1tPB6qJfGQHqEuV+pTHCAA9UKiRogzMGQ1HLvdGHKySQCe9HTXp8/3kS49qqbj2xiRR85Hwy33kr6Uc6kfLF7QlxDZF8A==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU2PPF4772558B0.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::a8b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Mon, 6 Apr 2026 08:29:02 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 08:29:01 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ying.xue@windriver.com"
	<ying.xue@windriver.com>, "yifanwucs@gmail.com" <yifanwucs@gmail.com>,
	"tomapufckgml@gmail.com" <tomapufckgml@gmail.com>, "yuantan098@gmail.com"
	<yuantan098@gmail.com>, "bird@lzu.edu.cn" <bird@lzu.edu.cn>,
	"enjou1224z@gmail.com" <enjou1224z@gmail.com>, "caoruide123@gmail.com"
	<caoruide123@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Topic: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Index: AQHcxLhPAyZoQw2hfkKoy+b+OgxZg7XRrHHw
Date: Mon, 6 Apr 2026 08:29:01 +0000
Message-ID:
 <GV1P189MB1988F57CA7DF4087D19D9901C65DA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1775269941.git.caoruide123@gmail.com>
 <8b07adfdbda1c0fbcf10a114f3272b848d4ea3a0.1775269941.git.caoruide123@gmail.com>
In-Reply-To:
 <8b07adfdbda1c0fbcf10a114f3272b848d4ea3a0.1775269941.git.caoruide123@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU2PPF4772558B0:EE_
x-ms-office365-filtering-correlation-id: 47d18efc-499d-4033-b960-08de93b68e52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 VMOpDdKZ3RHM3aF4dha2yb0GTAuPNHNa4GlJcNT9+5XYClDPqkL4AXo+OE26ezP4l/5sYB3kar5pgRzkk9tjYL2C7/EuzGORmEmGNVckRS3HyCz0ARX25JMC+8rBLp7nheZyhkSwPah4hFwDR5DLvM2luAq0WSd5ATrgCg2V+Vx3IYY5SACFVvrJR82VSi035/BDBTyzd8CnaSRBPMIJ1t1LnDbLq9YVUFP/unXdRmbpdBxT2t+Kb+bznmP9SDs50a22ehXYgLGJ0SaNBSTOpNWkK5+uVV1iHY/iziGXWpruCzQ92lHBV5GZ4sChqDzwGba/NJ85pKm74QtGpuxSkd5QEFbNUI7hy2kytPwrp1rEt3FiZX1vJi5SnIadZfAx4/UADKJrgJG2TbiBHQ8OSHrLyUUnyyCFZa8kt0n8qZECXl198+svKP+BVMd8hEyVGXec4n56l6D9sFPzwJj/QphTX1rr0OuKidpEU3fHWB/qUH2WOEwZClQXlSJvqeMJ3ILWDcmMY8Vr89hz+1CuXDtM3zrl38jCnqIRTPuXBWTaPYMVrDuyj6QYXcVuTcU210dQq9t4Mdszsdn0Bv/rs4F5IAamNjCGqsrEspiZTwr+02WMLZNUsb51mhQSb2pz8J/jmPJ+/C7HiAYxftcrXCXIilaz2zaIrSBpGZNKdv/oXC5R83eZRS0zcyahzdRrEmitu/JmLka2qWIVk6UNU4Tw4mPPsV6ZaWGEl9i26A2pI6w8Jm1upFy8gEEgSnmn0m6S+zN3SkuPGbFVcHVF8qOCvc9xUY/FCG8tIJ3qkzs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WKP16zQlTcZXgZpdP1Bujtm3uShoSxqMeMRzzQC9lUChNZyOn6KtPH+PD35c?=
 =?us-ascii?Q?xRbCSTHWQXQvzk3EgSR0XG4S9MKx5v07HKLqcQu3dRySlhxYLqqXst5zXLqk?=
 =?us-ascii?Q?1niI0uE00uTKsL3f+NRI3rwwM1jxf7RRvwX33eumQNoWMW7jHOcj853kj83J?=
 =?us-ascii?Q?lpwPJPlpFbQpG1+OD86AtJHeRrJuMPcDpOxGyEyMlSKWjQ8THBMk2UGMH72N?=
 =?us-ascii?Q?ZQ3OeldDEf1JmmZJQ43PCGQkNZlKeRn6ZACnOix5Q7UcXUIYghUd7aUhypR1?=
 =?us-ascii?Q?P0N2NKyE3l8+N1n21hX6Q+Zj+uPhzoHttMwNP8u0zcN0x2XIp7tmrRyEdpgU?=
 =?us-ascii?Q?TsbO5CUbxWVfgtigXwrmJu/DyDe7qpDmpY+UHG+T5OJXcGHgwry3rs7r4ian?=
 =?us-ascii?Q?sna4wLsazBOfz5W7yD7ccKE+DqB7mjL2sxNbPOR5lJZl51enf3x5V6tHBrjb?=
 =?us-ascii?Q?a5BGamwsx2T/Z/OqHOaMTwbG/utjV07uDNK3WtNsf0lEqmpYqvNKoWex+CcG?=
 =?us-ascii?Q?rJSPIUs4mJa0nzUOFkHakhTAR//4fwg3GnK1cEtNk651VSj8gGJYEhA9mV91?=
 =?us-ascii?Q?PGpgdbWvofdl6aCHlHOuvWBWo4JuHf1DFPPOr7vueJVcvZBJ56+pecV36j7q?=
 =?us-ascii?Q?w2lBtz9drpUTSlxO0V9IC/jG1xdrLkVUWQw8ESmi8ctz8pfpA0jIRugWCc1d?=
 =?us-ascii?Q?hiE6OZUhUabdLDNOCDA0QD/2AEmGncJvX2Yk6Qn7G4+/tqw8QzAFuaFgw8Qv?=
 =?us-ascii?Q?gCV0YNjzeTllUW71kybay/xpTFlHZgaAdbiy6eg1j3qbi0i9So+hIldjNrd6?=
 =?us-ascii?Q?KvFahshPmbnIycQdetxXDXLHMQDkn04Wj0CLDyj9OfG5ap1XsQC/LVX6Hovl?=
 =?us-ascii?Q?aMes/TIhuVNYVO8RYgjsdzMU9Jn1DDyQimM8iqPsZOvXkngX+ftS1taTFIIi?=
 =?us-ascii?Q?bGyASO8b2MuZ2jbVQTma22z4vf7y4xzX96qbbyaFOf/BlrIhY0R7dhmPE7p5?=
 =?us-ascii?Q?4vVZGDg9sXE2rH/U9OT2K55llFeAfHLEbg31EPLqLQwKBRlhlYUCOYTdRhKD?=
 =?us-ascii?Q?dXsFSu50Yz5cGyJBMgrnsEe7o7LJKc4IIhSyGoSvw+ZDc4DM38rJGZ/BarLh?=
 =?us-ascii?Q?kO+BqpKSXoHwwDjuyH1szP81+uoQILi4SwE2GkuAzs14RPDddGu94yyz8/di?=
 =?us-ascii?Q?YQ452uBbcopPLTDN/gotH9s0PkFI21e9knfaQR3ZyMeKvbksjy621hzsf41W?=
 =?us-ascii?Q?ogB7YPJLhOoaJbSI9u/9ZYY2vCKUnRsYwtIHfZz/CucvGr8NxCtBmqrFWpFR?=
 =?us-ascii?Q?Nb6PjRYmJjvFE36Qr8Lu+lMMVmzbitnLh9Ah9uZR/Uw+/1MSJPhTUfLaT7y9?=
 =?us-ascii?Q?E0TsFrwq9ROjbhcDuvqOwDvAvoI7LDNb0tCrRO1hzaJbK3KgRLNk6LIqEPHY?=
 =?us-ascii?Q?ubnFpqWLrSh3lGhCQPZrW1OCx7BmDtky7S01Hh7AtfEWs2NcRe3eyHFkBDAu?=
 =?us-ascii?Q?IYOfP2/WvFKkJoPYjm1xnKkVHlWazJrNUwT6xwD4p/GF3/jTuByIL+uty2CZ?=
 =?us-ascii?Q?hF6iYnUEcKFNTnWiTPfttvcw4tbNiNhzMHuNDvZdTc4Wn7CywfMDCGHEussc?=
 =?us-ascii?Q?ZW5UwJGJ6H2HhizWY57lG4pcSHxSDDoNVe+OT6TVFSPasbh3FdQPu4smfJU/?=
 =?us-ascii?Q?Az3wVQnOkfQJTy1vlqsL/viDVFSKqkLVGFSmzjC1CGVdN5mRxMfAZZNco6FP?=
 =?us-ascii?Q?skkU+QpM2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d18efc-499d-4033-b960-08de93b68e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 08:29:01.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mvynCbKRetmdWL/nak9jnsm7pa+OqD2zK42YdzJ7kZRISA3pBHJrBKpvzm0+o7VlJO1fSsKgbxIZBB2Zoz5vhASQvmALODclf7OpqLDI/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF4772558B0
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,windriver.com,gmail.com,lzu.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim,lzu.edu.cn:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 675CB3A2359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
>
>From: Ruide Cao <caoruide123@gmail.com>
>
>tipc_get_gap_ack_blks() reads len, ugack_cnt and bgack_cnt directly from
>msg_data(hdr) before verifying that a STATE message actually contains the
>fixed Gap ACK block header in its logical data area.
>
>A peer that negotiates TIPC_GAP_ACK_BLOCK can send a short STATE message
>with a declared TIPC payload shorter than struct tipc_gap_ack_blks and sti=
ll
>append a few physical bytes after the header. The helper then trusts those
>bytes as Gap ACK metadata, and the forged bgack_cnt/len values can drive t=
he
>broadcast receive path into kmemdup() beyond the skb boundary.
>
>Fix this by rejecting Gap ACK parsing unless the logical STATE payload is =
large
>enough to cover the fixed header, and by rejecting declared Gap ACK length=
s
>that are smaller than the fixed header or larger than the logical payload.
>Return 0 for invalid lengths so callers do not treat malformed Gap ACK dat=
a as
>monitor payload offset, while preserving the declared size for valid but u=
nused
>Gap ACK records. This keeps malformed Gap ACK data ignored without
>misaligning monitor payload parsing in unicast STATE messages.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Reported-by: Yifan Wu <yifanwucs@gmail.com>
>Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>Co-developed-by: Yuan Tan <yuantan098@gmail.com>
>Signed-off-by: Yuan Tan <yuantan098@gmail.com>
>Suggested-by: Xin Liu <bird@lzu.edu.cn>
>Tested-by: Ren Wei <enjou1224z@gmail.com>
>Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>---
> net/tipc/link.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..a364822=
c1cd8
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -1415,12 +1415,20 @@ u16 tipc_get_gap_ack_blks(struct
>tipc_gap_ack_blks **ga, struct tipc_link *l,
> 			  struct tipc_msg *hdr, bool uc)
> {
> 	struct tipc_gap_ack_blks *p;
>-	u16 sz =3D 0;
>+	u16 sz =3D 0, dlen =3D msg_data_sz(hdr);
>
> 	/* Does peer support the Gap ACK blocks feature? */
> 	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
>+		if (dlen < sizeof(*p))
Your patch is wrong. sizeof(*p) is equivalent to sizeof(NULL) which is 4 by=
tes. I guess you did not really test this code to see if it is ever hit.
>+			goto ignore;
>+
> 		p =3D (struct tipc_gap_ack_blks *)msg_data(hdr);
> 		sz =3D ntohs(p->len);
>+		if (sz < sizeof(*p) || sz > dlen) {
sizeof(*p) cannot be used because tipc_gap_ack_blks contains flexible array=
. struct_size() must be used in stead.
The above 2 comparisons are redundant because they are already done in belo=
w "Sanity check" and in tipc_link_proto_rcv():
tipc_link_proto_rcv()
{
...
/* Validate Gap ACK blocks, drop if invalid */
glen =3D tipc_get_gap_ack_blks(&ga, l, hdr, true);
      if (glen > dlen)
           break;
...
}
>+			sz =3D 0;
>+			goto ignore;
>+		}
>+
> 		/* Sanity check */
> 		if (sz =3D=3D struct_size(p, gacks, size_add(p->ugack_cnt, p-
>>bgack_cnt))) {
> 			/* Good, check if the desired type exists */ @@ -
>1434,6 +1442,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga,
>struct tipc_link *l,
> 			}
> 		}
> 	}
>+
>+ignore:
> 	/* Other cases: ignore! */
> 	p =3D NULL;
>
>--
>2.34.1
>


