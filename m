Return-Path: <netdev+bounces-307054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sFtSO3qZVGppoAMAu9opvQ
	(envelope-from <netdev+bounces-307054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:53:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFC748668
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:53:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=DG1tY3OK;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307054-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307054-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D49300119F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B93932CE;
	Mon, 13 Jul 2026 07:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083513955EF;
	Mon, 13 Jul 2026 07:52:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929177; cv=fail; b=n3zV/YJWjM68xnA3Sxjgz59PeCfI41kuDvmJezXAFxkReA2CypvxmwB9keCh2huYVU6v7Zm66ja+JEVDftEfYGKZKIjPfByuep9uVZ3cQgL4c83lnYFnu66tSr9E1k5MiVrI0pHRvss9x/qSn+be1rqojzUybPY3YcOIN/2NROo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929177; c=relaxed/simple;
	bh=VEZwoJQFBbYbXJVFWw71FVf0CRfEF4xk0DOc3IacK2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1Ic3GSnn51xcwCPVkqo27ri5qSRUVCwaUysbVZLoyWOsY5lKEFsg2Mwu8OM+MMmb1RkZEJ0q6ncJQu5LnF5kgX6kiJ4DMWDM7834yvT+FtKZjnsRjchn7oL/JCnIak3zlMKBEXNN5/UgwG060F1QmuL9pxYrca4HhVKLkBN0ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DG1tY3OK; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svjzcjHxbL2/MlOgyGVIlsyoPLhDqVJPWrTctAnQRhMm4AbFe0mZFTXEMoK97nEvq0wzHRHBFrqvrOCQJu0gyMIl4UQpgztujIEu8/o5Va/1er6vIiX5ZHSDMtG7+T9lDgjgMpY5/Dm2ti3dvJ1xJrMNLm/tdF3Tt6hlsVt52xKCsBWdNZSCo44jptmGxZHwCxLFMOZIWG8aOiTZerl+NdgK9/356Lf3GEck+uOWXbBMcZDX055g6jLxy8BMFfkws4hdlEcnoaa2ydG60maFsV5cX9UwiFTmABESIvp5uhevzy/u5Q5RREm0Wds2tmWmTJepoE8mFp9+jaMrCYIzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grhy8h9MYFNaLB/kHCCx90PxKeFcriryav4Ak1us3u4=;
 b=bZCtihbjjqc7+MSyTFXLzrKUiMDWRdfcm0yyaJt51cJS/d3A5vIe8ShRukGcS6dWzp/artC3ouG+d5wTbuP8nbWr8ODVGInmwMHCxEUOEyUHDg7EG4TYDwZNfXzn4T/iv4YfONoyDbqiyuhUQSGQeqd6jj7MhGvbDeCbi9Bq/w842ZpvDyaDA8QVdGh0R+hZG7R8TVwDcA+31BnDMN+gGrZ9iTYHFr8vqYO6AX1NcbMIBAXPq3MHqzjBMSkWa1/JzGAqu+wx5zpdmiX3Vn/F/N6QNjy1QS8f+VQFMfR5/HWE2tlTo9Qcg9T1tfO8CpzecgviZTmlkzKYGAJmI1ElNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grhy8h9MYFNaLB/kHCCx90PxKeFcriryav4Ak1us3u4=;
 b=DG1tY3OKRW3TmVMBlhHThzzRe9gN0Pa4pKNjSgf02aUqSPvehPs0EFGNfiL7Zqnw9rBBACzfU3XdvSIJM67fNMZ2ZWixCg+TArAAk5xZvNALTeMM4Nh1lzf0SOgcvQsmszNunkFzP+7FdERrpQ4yMygQ91Nl/b/Lrv19fjTO5CzN6jb0cY9nnupkeUOa9XEwfTinUjp7oQZ/vtwI/Vlo7Z1uP1yPNcyEylXoeWu5C39wsabWewUiCRqhldcdpSDduIL3Q3ZhZvhQvfWXLg2pcNDNceyznoUix+3kOfT6R+yn5ut/NCecjWGAJyaKy6ag1Z+Pl0cv4T8upKNIyfSz3A==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PR3P189MB0985.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9; Mon, 13 Jul 2026 07:52:52 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0223.008; Mon, 13 Jul 2026
 07:52:52 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Daehyeon Ko <4ncienth@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Topic: [PATCH net] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Index: AQHdEA2+rYe7FoCWcUyy82fCjcu5s7Zq50yQgAAvKQCAAAGusA==
Date: Mon, 13 Jul 2026 07:52:52 +0000
Message-ID:
 <GV1P189MB19889559936C825BE444E9C8C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB1988AF0F2722101E30D902E1C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260713074324.3577116-1-4ncienth@gmail.com>
In-Reply-To: <20260713074324.3577116-1-4ncienth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PR3P189MB0985:EE_
x-ms-office365-filtering-correlation-id: 58cb2337-af2e-4f17-7b0f-08dee0b3bdc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 mGnbwSAPQgqUKGdgEAi0S+XyoVsKRcK+TIuUknxy1fgwVjIdrO2xbgHYarAnm4AuRm1yUXhzr86nF2oJew2F3/kFK5Lp8j9k+b0PnHoIcD9WhOj8n20qzSjPm8rvaX9Dot9T8oat3rcLIdiJXQt0Ag8R+bBw/ZFtC+N97Zak5JvnUt/yRRhm+CgJXafsqcziboXNUjkhD5Pb2ZzOZsTh7jserc2uSpRJH5TKLg+2AXjxNZu8sbpQcwXPOSO1ZVV4SlGxcNQXxZjS0BimxWjWyJNb6twArMv+pItRCHz3NqaLByG3NE3jRtpgfxvJSpXZat1o3Yg/egWcqQF1EWFE5L9v4Rta9vs1cpeAwj38tDd7+6C09ILMNw+7W58wVqxsziWrWY6GEr0Giey4M/ROsNCbPVNQ/Iq4U7dfW8r+OneO7mk2aAeODsIOE9HZULMAm1Kvkz6BYrM8slAIdHZJt7edMO7SxYEoU53EW78iMbJJFi6G0sbiIloWTVugNQqkHeqxoIPBSA/2ZwVBh/xr6CAXBiZA2HxEHp/cMlnyyK1gN9QEJ/pleb38Al6VRI6YmpO8o1DIWnlCou6Fbs5M8R+Ys53cNZQ9BOPV+G1TL3/RAaDKeCAgxzOpnBztM14mH/d3+388f2Bq5zm05dvpJuFhoofLFUBStX0M05OjbR21yVS2lQWzU8nYidZ2TFdYX1x81ZevMWCPmGCgH2SrxQdYhqRfxEbnIdNSgB4IuCs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/z+jlPfvNn8v/8voCzVvLLWDodjnnVitUP+w0oxsw6bI+DMG8feK9EHlm8t+?=
 =?us-ascii?Q?W8yIwR6qPylmjo46wYsDiTJK+MBBeunH1zkrP50+35gbc6AZO5CC1LvZI1X/?=
 =?us-ascii?Q?4kfZ21RILhkVUunhy1DV9FgXnhm/MJxpeQORzvAylKUm9GKshivzqNx7rydS?=
 =?us-ascii?Q?S+yAdbSEQ0DerCFkAUG4lCZBBihTLLBEo73aY8zYUh5feGZwTLkm5YOaKiqd?=
 =?us-ascii?Q?bBl4TJT3YvVp07gNExkppLkFOTIGuOD7J+yIeID84dx6OA7yT35vcpoae5l9?=
 =?us-ascii?Q?WkpSJp+uAc1Vs+zqQCredp/FFvMbJElF1n1g+lYZOQ9nhePZxJ+3np9YImF/?=
 =?us-ascii?Q?AkvNWFhRzd+bNsSPaUfluwY8llaKnq9BQOxRXMVKA3nvqajzuSUjmGsLA7s8?=
 =?us-ascii?Q?xpwPDFUglRHiPESP9fy4a2BKa5z5YPZjiLpQwbONbfHmN7UhSVfzGxS8hGs/?=
 =?us-ascii?Q?0jpmUJGPMMIgkZQ4Qr3LIPPts3A9sLtSVrRJKXuVfYUuUEIwvyaKcIonavEI?=
 =?us-ascii?Q?Dob0LTdMt3awXX5AVefrSGuDXsNMfvU3RH4HjO1VSdt57TEJpBC3wLF9A0iN?=
 =?us-ascii?Q?qiw02Kvs10ukzgSeNNlOuLi5fj3l3Lr1Rd4bNDXd0Ogh+xdfvAziJRSCE9zh?=
 =?us-ascii?Q?v7P1lNXMbWA5E5r/sDiue1PL2xukVMEcZ7gzhL/Vf6HravMfi1obQxOKAjpo?=
 =?us-ascii?Q?SKctGuNFwm/rgMWUpVrJ0LRQsnlYTCvWmRShbGEctqtqbGs6Vxsl+NNQ8h2F?=
 =?us-ascii?Q?VeQpAoA/u66iwh1rtlw3YICs5xeXcO6y+2kImxJJADFijCUzWDpgejb4FGAV?=
 =?us-ascii?Q?jyWXc392vgr4UyLMwVnXiOSlWXBQrFRj+ddaViTgGp/2E/QT7Sk+IcCLsj47?=
 =?us-ascii?Q?8xOuWh4MzyyUuUIC4tL4Z/yhROaxaf7nTQbb9GpncRWv7h2jKPpPvX/0z/8b?=
 =?us-ascii?Q?by9hUANMXKq9dsm+m1VcXFTsGEhYgVv5y3wQ1PYF213WVg2haXmGtvU0CPBj?=
 =?us-ascii?Q?rjrbYk5ghLVps10mdZKYEGgB2R4V9DP0g00F7D8DnYfGx95Q+RCYWKMPauIh?=
 =?us-ascii?Q?bdCVVJwG5SyZdJl1uItZxEA5VdzWXvsbxhf+Lh9E4M3+1hIW+xCBfhN5XYUJ?=
 =?us-ascii?Q?gzAcEAlG9kOsW2uxRuNwsK0QtLWot5ospt1gIv5QhXKnE0pO34wjiYLUysII?=
 =?us-ascii?Q?AaJ+4GjCQbxwPZUy5bRb9dF7p231+bGlxEQ0LCciKLcr2Fx/WG7OtEKdIu2H?=
 =?us-ascii?Q?IwfoPlqhHW1k0SjiCb5xWbyRSZR0bPjgPvD7HibvQPvz14BhOGowTN4CgqXS?=
 =?us-ascii?Q?NViRwTr+xLZoMup6F+czCp28BnIhu+8I9XKlZi7pAkMFUdQ/7M11jiJ3r8DM?=
 =?us-ascii?Q?BULGdZ3jilAdGny/0wHqGojJmCXeMffva28ySCkR6gAGVMmgMHi01nZ7tsMb?=
 =?us-ascii?Q?KdDAjZwjWww70bxKX0mDP8MMkFztuyeoBrLviApvb82IPjsAXXFsFcdS0T3r?=
 =?us-ascii?Q?bq70eYJJfmpYwrKqGiRGHVy06hV9XAL91dlmFGK412UGrOz8vXtNHq1kj7+Q?=
 =?us-ascii?Q?UHLYDcaVmVYjdht9oZRyqiSXrtr2PGXpfKEOy/1Oj3k1d4F127Pd/xpP8MR1?=
 =?us-ascii?Q?Qr0d6xmRy76CmvD5loOXkIoST2hQLA3uZ7fdFU/suck/B2oJ2J19aGsc2a1M?=
 =?us-ascii?Q?9/AcK15ifUZ7TFWcLGByNvszK1EGXECKYGpOf3hxO1bwbmCRd2P+P725RfUi?=
 =?us-ascii?Q?3kUUjHpE3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cb2337-af2e-4f17-7b0f-08dee0b3bdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 07:52:52.0161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXH18b+REbiE2HIOJqMj5bMcr7t0QQHRDbIBcj4M+h4uTmaG8Q/7Mt7KE+eVw84/K+72PRfl9RJ5Pcp24XX/LUYI1MsP4sXFF0Tnb2jS42w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0985
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:4ncienth@gmail.com,m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307054-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5EFC748668

>Subject: Re: [PATCH net] tipc: clear sock->sk on the failed-insert path in
>tipc_sk_create()
>
>Hi Tung,
>
>Thanks for reproducing and testing. Decoded with
>scripts/decode_stacktrace.sh (line numbers are current mainline
>net/tipc/socket.c / net/core/sock.c /
>net/socket.c):
>
>BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
>Write of size 8 at addr ffff8880047cdc38 by task init/1 Call Trace:
> lock_sock_nested (include/linux/instrumented.h:112 net/core/sock.c:3839)
> tipc_release (include/net/sock.h:1713 net/tipc/socket.c:638)   // lock_so=
ck(sk)
> __sock_release (net/socket.c:710)
> sock_close (net/socket.c:1501)
> __fput (fs/file_table.c:512)
>
>Allocated by task 1:
> sk_alloc (net/core/sock.c:2308)
> tipc_sk_create (net/tipc/socket.c:487)   // sk =3D sk_alloc(...)
> tipc_accept (net/tipc/socket.c:2744)
> do_accept (net/socket.c:2034)
>
>Freed by task 1:
> __sk_destruct (net/core/sock.c:2289 net/core/sock.c:2391)
> tipc_sk_create (net/tipc/socket.c:504)   // sk_free(sk) on the tipc_sk_in=
sert()
>failure path
> tipc_accept (net/tipc/socket.c:2744)
> do_accept (net/socket.c:2034)
>
>So the same sk is allocated at socket.c:487, freed at socket.c:504 (the
>sk_free() right before the line this patch adds), and then written at
>socket.c:638 (lock_sock()) from tipc_release() on the accept() fput cleanu=
p.

I meant to say please send V2 with above decoded stack trace in your change=
log.

>
>Thanks,
>Daehyeon

