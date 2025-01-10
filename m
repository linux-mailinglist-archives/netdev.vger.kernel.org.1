Return-Path: <netdev+bounces-157135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEBA08FB4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9041887904
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6822420766F;
	Fri, 10 Jan 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QucKgj3l"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB5205E23
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509730; cv=fail; b=n9YjJi65bjFHyMmAmnxSXPKMEURUsn9/INZxMx6qzRBE4e/VS3AheYKQqCN6BLMNFj1C4Cm9xPm9C9pKJwwhu1m/u1zAsoL8TUM5TbGnLFzphak8gBREyHLltC508AdBNk0LfSWsFGId+toXcraIV3Gb/4JXhPQSViDG8EA8gbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509730; c=relaxed/simple;
	bh=MrOcMDTLAu+DBOfCZWehMV/GzwpOOitTeEnjZoksn4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lS3s170RDI+AL+phaK6ndOLW60e7Dalo4olHnxk8Z/EnSPx2FXxS3VDFEz2tjlt4sJg0vOXfbCn6GcSw4D6P/bnOyDwFbARnODZBE4ZmO1AytIOmY50sxhjzM2UwY7SvFnrX+Y9W4g1V/cPEekDxjg27NM0dX96BqEZkuZlCAHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QucKgj3l; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE9WV0cPBExB6P1egPYI/X2ZpNxnAqJy78nOCAGcoOhTTtidvgVx5dUm3fYs50033Av4louTgjlb/JgrlZgzUHP+CkQT5MgI9un5JfYHL+F209X+wD0efUwe3kCN4gWGOJKOBXTO9MMXkx9JruZNQOKeLu19NmIHOuJXpBTYpT89LmJCvx74P34BFlWY9o3fOX5HLGjmh2HECw53dCB32lTf4Ntqj0g+gaRfJj2gsS6i6ObrxGuUQbJTF5O+CTvHvYzMywyyQlyvAz0ckuFKK+lKafaKJYjriETMI269noelW2FlJx/ZvtAESRvGETnNQLvtacqTvXTSBrqU7fXvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrOcMDTLAu+DBOfCZWehMV/GzwpOOitTeEnjZoksn4w=;
 b=N4rl6mx6q1IdOVXOko7/uE/8wISQkt97kLpNgCjyonIIR91lQS2xlG4rfEoDrSuPHi+MNx8bb90g2fQRGmnUi16sJEyFI1PojK0FPduaW52QQE+IqUp1cZGgH19Ix1GafgXDxnntBIRj8Zkd4y6vSwjCT9ZkQjdb27XEbKmpTSmf54irOaYxYWG84trg3MupbeFKFEKiCMqbLgwLKd6ZfDc3MpFfetxX6YCIVHpXlp+BGbPI85ayvY5D7noKVLXC/DREdTvAE7jZn8kNYSG1WIIZyAJ6xfiTM6eLEkzg+sJq3LFD4CtDVoET88UuJ+rL/J2n2EKO/ThT4yO0J592BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrOcMDTLAu+DBOfCZWehMV/GzwpOOitTeEnjZoksn4w=;
 b=QucKgj3l3YZibODK18HBJbC9WsTH45O8xpXx4WbprcZM4b5hjUYTRRgTPjAH6ev9JL77jwsGVPpog4xa34J8rkM4E5XuDQV4dkNHFmoJ49AFrLvP1e0soAUNBAZC8xOMTbeqim1DlIqzBKOyHqF9vqf0kNzJTIPUOr958frk/3Ui95lkvleL8k0cD8yE5KxJ9FKKS5phmzHkisCGfSKNHzi6Su3Y78w1bCxxyJf3XXNyq9ny1XI3C8AaUk8+aDDc8rtEDXAEfl72Nqmfxoce+dWokIlngjXpaNwh/hyIeikUd9QAoMAKvps8ghjOAPyJdqYu1wHSbrrJ8xXUzzeCpA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7212.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 11:48:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%4]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 11:48:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "c-vankar@ti.com" <c-vankar@ti.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"jpanis@baylibre.com" <jpanis@baylibre.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware CPSW
 only if !DSA
Thread-Topic: [PATCH net-next v2] net: ethernet: ti: am65-cpsw: VLAN-aware
 CPSW only if !DSA
Thread-Index: AQHbY1LYc2/Ywrl+eE+iq6LL4sIQEbMP4rwAgAAB0IA=
Date: Fri, 10 Jan 2025 11:48:45 +0000
Message-ID: <5864db3fdb5fea960b76a87d11527becf355650b.camel@siemens.com>
References: <20250110112725.415094-1-alexander.sverdlin@siemens.com>
	 <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
In-Reply-To: <fgt5mqpmibxjbfd3ae46hxk3m2sowpbxs3ffurwxiqairvlj4d@7ns2gdwh3v7h>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7212:EE_
x-ms-office365-filtering-correlation-id: 742fa305-47f4-4938-27be-08dd316cbce0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEsrd0x5MlM4VnpKRm9HT2d3M1IwakpSNDBLWlNwbkU3bEQrZVRya0JDM2Mv?=
 =?utf-8?B?eEVZWmZMOHV0eGIwQi9jWFQ5ckE0SmU5WXdXRkd6bVVBUWgyR2tkOTJrVzZK?=
 =?utf-8?B?OXVaQUcvUm9idjBxVmp3Zi9XK0tmbVA3ZmczcDJYZjJYSC9Wdy9PTHQ3L2pt?=
 =?utf-8?B?dmtyMzNzNFhobU1EWWlwOXRBQmx2cStJRW1qd281Vjhrek4wb0JNcEMweTlU?=
 =?utf-8?B?VDhhdmhiM2I3eG0zR0dqc2FCR0tzaUdvTDVJUmhCSU1uaVVWR0JzZStLSW5Q?=
 =?utf-8?B?SGJycTY1STVsS3RJYUYwb2dRNWMzZHk0dVBGOHBvR1NlUFZieldkNVhYUXFF?=
 =?utf-8?B?aVMvZko0bXRPVlc5Y1BqaWRidGZ2ZGUwdHZJT0NCYmpSMGxyWnZYVW9qRDBn?=
 =?utf-8?B?MUc5UFVMZVZnUzRTdFZGcnIxQkRtcWIwMHRLRzF4SElyaXgvYkNIQmxEZ2Rz?=
 =?utf-8?B?Y2lnUWRVRVBncTZUazBHRVozVG50NTRBbXptVVJrRlRLWjJaNnROa1pYN1Bq?=
 =?utf-8?B?aTFiWGpTWnBZTFdkK1FhaUdWY0Q1SWlJd2lBZVV6a203SVJkZ1JaRjVKRG4v?=
 =?utf-8?B?L2xzb2Qvd0swUWFxQmJLZGV3OEZKY1ZFSzVaajhGdEh6M0g3SGtEdzRxNklC?=
 =?utf-8?B?aTVHZ1h6MFVNaUxXdjgrbVB0aG5GQ3gwb2dIa3ljeHczWjh2ZjhrWTZHUmZi?=
 =?utf-8?B?MUh1QmhEL0o1U0YwTzlKU0k4SndlRVpobUxVOEFuTlRNNnUyU2htTWNwTXE4?=
 =?utf-8?B?WDYvaDJiUmFOak9oRDZFNWhaT2VNVG1tUzVVbXBieFlKeWV4UkkrSTdSOE9G?=
 =?utf-8?B?eHdQS3oyTnU1M3JLYnEzWFhZNHo2WGg5R2NEK2c2L3JNbllOajhRcFloN09p?=
 =?utf-8?B?SUROK2tnUzkrbEUydE5WQ3dKdlZscWp2b0tTOWJsU3FSN3g0djBPRHBIKzh4?=
 =?utf-8?B?RW4yeEZDUHZRQkJFUmV5eE8zQXNXV2pCYmk0UDFaWVJOODMrdFNFU2l0Y3kr?=
 =?utf-8?B?UzBXSncwcmdaS2RLU0pZRUlpUnBtZzJlT2NtY21jVkZSbVVxR2dTMW02Njlm?=
 =?utf-8?B?QTBTY21EM2pxOGxFOHZidk5TSTVwaDNZbmoxRUNEaVZkU0hicTBRQ3ZDc3I4?=
 =?utf-8?B?VVI4TnlZNU1PZW1uMHh6TzZHWkh3ZUlteWNEVkFFSDN0OFlKci85aU4vZWRl?=
 =?utf-8?B?a3JOaU1QRmxXK3FjQ25FTXRWczZOWVY3R0NpOGVEY1ArUWphQlFtUldSQWVp?=
 =?utf-8?B?QUhqNHI0ZXhSUXFsM2xqWHdzOGt5S1JPSmpBMFVDTFpoTGtZZ2MvVWJReklS?=
 =?utf-8?B?MGdtQUVmTGZ4UzJ1d1BHSjZ1cGZzQVlOc2x0UHpSdWQ3RzZsN2l1bWQzb2ND?=
 =?utf-8?B?NFVYM3UzTCtTY0twd1RxQmwvUFZMWVlVQ0NsMTFETG1WNzNKMnFuaUpUUFF6?=
 =?utf-8?B?OHNRZFRpcWoxcW9lZS9ZblRlbXhpUEZxQlJkclFNZngydkNrQjQrYkdyYS9t?=
 =?utf-8?B?aldWSXdDU3k5QU91RkFBc09IOXZxMGpDT0JoYTNsd3dNQ2ZHelpKUURkUm1j?=
 =?utf-8?B?Sm1Kb0d5NGVNbWZ5VVJXcTJVOEtjNkFTSG1zTWd3K3hsUmtSVTBFK1Y2SzFv?=
 =?utf-8?B?UlpDTWZxNEluOWo2TjBhZngvNmV4eTk4QzM3QWwvcHFoZFkyMDVLTEhwTjA5?=
 =?utf-8?B?Q2N3QzhaakNhcGU5SDI0T0JuQjlLUU1rdkd0OUlaa2R5dGwwUDh3L2JZNjlL?=
 =?utf-8?B?SHVnbVhWV2FYY3E3WmwvWlU2cCtlbDZlNm1Ka1prTUl0VUN5RmVkNWczN09Z?=
 =?utf-8?B?emcwMzM5TGQ0akJsT0J0aSsySTJYYTBPSWxHTUl1YXpWQjlWbjd0N1ltLzhH?=
 =?utf-8?B?Qk12VEtrOXJQTmF0K3JtVkZNdkx4RnRsN095UXhCL2FsWEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y21xVngrQmxETmh0WXkzN0xYaklkL3A3eFZzZGcrUjdsOVNvTWQ1UExLQ08r?=
 =?utf-8?B?cnIrakN2akliaC9qNm9iSnFBSTBPSFBxUmZvYjFwYm80T1JVb3FVMEdSZ01v?=
 =?utf-8?B?MkxWV0Rvd3hJVnBoSkp0SnMzQnRuTWRycTdWSTFyTXNmclFzRndqR1hKLzVM?=
 =?utf-8?B?TjVCZ1JpOHd6NS9qalRZSC9ncTdFc0o3dXBiNUJIVGl2cTFVVE1xb0kvQ2NJ?=
 =?utf-8?B?THFTZkE5NEFiVzBoSEtTY0h2VnU3YmVJQ0NPZldWWHpSUnl2YU5lb2tWM0hI?=
 =?utf-8?B?UkNWM3RVSnRsVVJ5S3NwTkl0MkVUa25ielFpWXdkalNxRjFWNmQrenpNcG4v?=
 =?utf-8?B?Q1o1OUtWYWdnMjUwVHpBZSt2RDhBZDZGWjRuWGFFZjZJWTMyc0QvUHZLZWhW?=
 =?utf-8?B?Z29xL0JTVlNpc2l5V3ljYko4cWZwTE5zWVlRd3ZRWDNyTmR1cS9SU3hKUEo2?=
 =?utf-8?B?NkRMTnJPK2tnWUlqWDg5dUE3WlBuZUxCL0lFcnU0eXJzODJDUXpmb0s1RUEr?=
 =?utf-8?B?cWg0YnBhcmNiby9lbUJaTWdJdGN0dmFpRzU5bTJzQ2QzbWd0aG9zZDNQWCt1?=
 =?utf-8?B?OHZCZWpJOTJubW1CWXFxVU91OGJaUWQwSEFtQUNNaUlQY0RLeThVcEhYRmM2?=
 =?utf-8?B?dFk4SUdBSXVJYVozSzFCMHJlL055S2ZCNDhFbUNjVkFkYzNtdlRrTWtiT0xR?=
 =?utf-8?B?YnpzakpEcWtvV2duallwazNBeWZFZ1dGTkJyUWxrRVVDMFQ1aUlNRUE4ekxU?=
 =?utf-8?B?azAyT1BkTnZVdm8yZy8zZkIrYkxEeUx5bEorSHdpZytJcU51Zi9zclRWMmNj?=
 =?utf-8?B?b0xkY09KSFRaY2VUWG5oUTNSN00xRnlPUUZPbU1oQjJoc053dnhGTkdxQ0Jy?=
 =?utf-8?B?djN3WHVSVHBlYUp5emxRa1BDNW9oMHNuRTZzUjdqV1JlTllrRTkzMTRvQVJ4?=
 =?utf-8?B?dUhvN3VHZ2JicmZuSDhwS0lkdlFFdVc4dlBwODVLYStWMzlxcHFrbURTajB3?=
 =?utf-8?B?MVFydDZvYkx0M0tBUUQzR1BOcUhFbktsTVovanpEWklkRVhBaWx4cnBLUGpQ?=
 =?utf-8?B?ZW1NTDdWa2d6TVlpck1NMEpqRnJZeVoyQ2NlQ3B6MURYY0E5eGRZbndBQ09p?=
 =?utf-8?B?RWpxWXhQbjhqUEJBa0g3VlRhNGdPZTE0OW5OQzhhbStlUS9hMHpObWxQQ3ZF?=
 =?utf-8?B?Rkk3ZWVqSnNvZDBzcWpOMkJnYis0SUM3ZlFFZ0t3d2FsN0Q0NE8wVmJqc215?=
 =?utf-8?B?YnZVeUwvc0U4T3FPdENYaE9ZRjUwUGI2a1pQampqeHhSZVQzcHJFQXpvOWJi?=
 =?utf-8?B?UzZiV0l5RmdmMEhUK1o2TVJIaDhqaXVNVGtjaVNGTkVndU5ORm1vV2tvUFg5?=
 =?utf-8?B?Y1RQVCtmRS90cjAyQXlKMzBwWjZPUTJXaE9MUk0wT2RpOXpFL2c2clZjbHpa?=
 =?utf-8?B?TGUzb1h5ZmJXdWo0MjBra2toNG5YQzlRdXVCSnRIcHlVa0RYNWlNY2JRMmth?=
 =?utf-8?B?Y2FuVXhrU1gyVkV3b1JHakw1NS8xdWxaekdIY2xQdTdrYndhbFQ4WDhqczh5?=
 =?utf-8?B?QkJKbnNZQ3RWVTNxYnpEQ3NSSDBnaGg0VU1hV2dpelFNNnVqUkpNMkdoSVhX?=
 =?utf-8?B?WmovZUtYaHJDQlN5YTJhK2ZSajFwQSt3MFlFMXY1ZzNNMERxY2lyUXZuSlVm?=
 =?utf-8?B?bVlVSitRZTE1TXdFcGN1dzBMNjhFcWFMNFprdHdPUXdURDEwcE9qUlluRmVQ?=
 =?utf-8?B?bk1kdUpwM1RiQ3JPVVV4ZWFrQWo3ZDZuWWVqaURTUTh4WmtDaWZmcmhEYWQz?=
 =?utf-8?B?WS84eVZVR0ovbkhQSjRyS01DZmdydXJxSUlncEl6d1M5K044R0x3WnVXMGFS?=
 =?utf-8?B?dzM2d0JCL0pnMEJGaXA1S2QrL2RYUkdZUU94b0F2Z25qcDJkRHJpK1Z3QWtV?=
 =?utf-8?B?dDh0QXRSNFlaSmdNME1XNTA4c21DVHUvZHdIVUZ4S1U2Q1d3NjFRcjk3UEZo?=
 =?utf-8?B?QjdaNzRQZExPVEVZcVNxamlQell3RTE0aUdiZHB6UytyVXJ4THV6SFIreUpQ?=
 =?utf-8?B?ajQ2NXg4aWFXL1BrSStSYUVqVllYMVRWT1ZsVUVyZnFGcU5sMCtZQ3pFcDkr?=
 =?utf-8?B?ZzJCbDgxczMvUDAxdVAya2dTOTNVVmJYZFBxWjBxU01HNlVBTHNxcW9QSTIv?=
 =?utf-8?Q?b1pzaIZigZUpIYcqwOZYU6I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D9D32820932B545A8DC968F315C7F25@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 742fa305-47f4-4938-27be-08dd316cbce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 11:48:45.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mg+HJciV7gjE7V9IipUk0nQRSa81bAD/nsavKa/gLZzwGzVsNQRCfReg5S32+35bggwBfUXsnnH2SamVWOqMXkK0MurhLRMaItUj06EkPyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7212

SGkgU2lkZGhhcnRoIQ0KDQpPbiBGcmksIDIwMjUtMDEtMTAgYXQgMTc6MTIgKzA1MzAsIFNpZGRo
YXJ0aCBWYWRhcGFsbGkgd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDEwLCAyMDI1IGF0IDEyOjI3OjE3
UE0gKzAxMDAsIEEuIFN2ZXJkbGluIHdyb3RlOg0KPiA+IEZyb206IEFsZXhhbmRlciBTdmVyZGxp
biA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IE9ubHkgY29uZmln
dXJlIFZMQU4tYXdhcmUgQ1BTVyBtb2RlIGlmIG5vIHBvcnQgaXMgdXNlZCBhcyBEU0EgQ1BVIHBv
cnQuDQo+ID4gVkxBTi1hd2FyZSBtb2RlIGludGVyZmVyZXMgd2l0aCBzb21lIERTQSB0YWdnaW5n
IHNjaGVtZXMgYW5kIG1ha2VzIHN0YWNraW5nDQo+ID4gRFNBIHN3aXRjaGVzIGRvd25zdHJlYW0g
b2YgQ1BTVyBpbXBvc3NpYmxlLiBQcmV2aW91cyBhdHRlbXB0cyB0byBhZGRyZXNzDQo+ID4gdGhl
IGlzc3VlIGxpbmtlZCBiZWxvdy4NCj4gPiANCj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9uZXRkZXYvMjAyNDAyMjcwODI4MTUuMjA3MzgyNi0xLXMtdmFkYXBhbGxpQHRpLmNvbS8N
Cj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzQ2OTk0
MDAudkQzVGRnSDFuUkBsb2NhbGhvc3QvDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBTaWRkaGFydGgg
VmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+DQo+IA0KPiBBIENvLWRldmVsb3BlZC1ieSB0
YWcgc2hvdWxkIGJlIGZvbGxvd2VkIGJ5IGEgU2lnbmVkLW9mZi1ieSB0YWcgb2YgdGhlDQo+IHNh
bWUgaW5kaXZpZHVhbC4NCg0KWW91IGFyZSByaWdodCwgdGhhbmtzIQ0KDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQo+ID4gLS0tDQo+ID4gQ2hhbmdlbG9nOg0KPiA+IHYyOiBUaGFua3MgdG8gU2lkZGhhcnRoIGl0
IGRvZXMgbG9vayBtdWNoIGNsZWFyZXIgbm93IChjb25kaXRpb25hbGx5IGNsZWFyDQo+ID4gwqDC
oMKgwqAgQU02NV9DUFNXX0NUTF9WTEFOX0FXQVJFIGluc3RlYWQgb2Ygc2V0dGluZykNCj4gPiAN
Cj4gPiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jIHwgMTggKysr
KysrKysrKysrKystLS0tDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNw
c3ctbnVzcy5jDQo+ID4gaW5kZXggNTQ2NWJmODcyNzM0Li41OGM4NDBmYjdlN2UgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4gPiBAQCAtMzIs
NiArMzIsNyBAQA0KPiA+IMKgICNpbmNsdWRlIDxsaW51eC9kbWEvdGktY3BwaTUuaD4NCj4gPiDC
oCAjaW5jbHVkZSA8bGludXgvZG1hL2szLXVkbWEtZ2x1ZS5oPg0KPiA+IMKgICNpbmNsdWRlIDxu
ZXQvcGFnZV9wb29sL2hlbHBlcnMuaD4NCj4gPiArI2luY2x1ZGUgPG5ldC9kc2EuaD4NCj4gPiDC
oCAjaW5jbHVkZSA8bmV0L3N3aXRjaGRldi5oPg0KPiA+IMKgIA0KPiA+IMKgICNpbmNsdWRlICJj
cHN3X2FsZS5oIg0KPiA+IEBAIC03MjQsMTMgKzcyNSwyMiBAQCBzdGF0aWMgaW50IGFtNjVfY3Bz
d19udXNzX2NvbW1vbl9vcGVuKHN0cnVjdCBhbTY1X2Nwc3dfY29tbW9uICpjb21tb24pDQo+ID4g
wqDCoAl1MzIgdmFsLCBwb3J0X21hc2s7DQo+ID4gwqDCoAlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4g
PiDCoCANCj4gPiArCS8qIENvbnRyb2wgcmVnaXN0ZXIgKi8NCj4gPiArCXZhbCA9IEFNNjVfQ1BT
V19DVExfUDBfRU5BQkxFIHwgQU02NV9DUFNXX0NUTF9QMF9UWF9DUkNfUkVNT1ZFIHwNCj4gPiAr
CcKgwqDCoMKgwqAgQU02NV9DUFNXX0NUTF9WTEFOX0FXQVJFIHwgQU02NV9DUFNXX0NUTF9QMF9S
WF9QQUQ7DQo+ID4gKwkvKiBWTEFOIGF3YXJlIENQU1cgbW9kZSBpcyBpbmNvbXBhdGlibGUgd2l0
aCBzb21lIERTQSB0YWdnaW5nIHNjaGVtZXMuDQo+ID4gKwkgKiBUaGVyZWZvcmUgZGlzYWJsZSBW
TEFOX0FXQVJFIG1vZGUgaWYgYW55IG9mIHRoZSBwb3J0cyBpcyBhIERTQSBQb3J0Lg0KPiA+ICsJ
ICovDQo+ID4gKwlmb3IgKHBvcnRfaWR4ID0gMDsgcG9ydF9pZHggPCBjb21tb24tPnBvcnRfbnVt
OyBwb3J0X2lkeCsrKQ0KPiA+ICsJCWlmIChuZXRkZXZfdXNlc19kc2EoY29tbW9uLT5wb3J0c1tw
b3J0X2lkeF0ubmRldikpIHsNCj4gPiArCQkJdmFsICY9IH5BTTY1X0NQU1dfQ1RMX1ZMQU5fQVdB
UkU7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCXdyaXRlbCh2YWwsIGNvbW1vbi0+
Y3Bzd19iYXNlICsgQU02NV9DUFNXX1JFR19DVEwpOw0KPiA+ICsNCj4gPiDCoMKgCWlmIChjb21t
b24tPnVzYWdlX2NvdW50KQ0KPiA+IMKgwqAJCXJldHVybiAwOw0KPiANCj4gVGhlIGNoYW5nZXMg
YWJvdmUgc2hvdWxkIGJlIHByZXNlbnQgSEVSRSwgaS5lLiBiZWxvdyB0aGUNCj4gImNvbW1vbi0+
dXNhZ2VfY291bnQiIGNoZWNrLCBhcyB3YXMgdGhlIGNhc2UgZWFybGllci4NCg0KSXQgaGFzIGJl
ZW4gbW92ZWQgZGVsaWJlcmF0ZWx5LCBjb25zaWRlciBmaXJzdCBwb3J0IGlzIGJlaW5nIGJyb3Vn
aHQgdXANCmFuZCBvbmx5IHRoZW4gdGhlIHNlY29uZCBwb3J0IGlzIGJlaW5nIGJyb3VnaHQgdXAg
KGFzIHBhcnQgb2YNCmRzYV9jb25kdWl0X3NldHVwKCksIHdoaWNoIHNldHMgZGV2LT5kc2FfcHRy
IHJpZ2h0IGJlZm9yZSBvcGVuaW5nIHRoZQ0KcG9ydCkuIEFzIHRoaXMgaXNuJ3QgUk1XIG9wZXJh
dGlvbiBhbmQgYWN0dWFsbHkgaGFwcGVucyB1bmRlciBSVE5MIGxvY2ssDQptb3ZpbmcgaW4gZnJv
bnQgb2YgImlmIiBsb29rcyBzYWZlIHRvIG1lLi4uIFdoYXQgZG8geW91IHRoaW5rPw0KDQo+ID4g
LQkvKiBDb250cm9sIHJlZ2lzdGVyICovDQo+ID4gLQl3cml0ZWwoQU02NV9DUFNXX0NUTF9QMF9F
TkFCTEUgfCBBTTY1X0NQU1dfQ1RMX1AwX1RYX0NSQ19SRU1PVkUgfA0KPiA+IC0JwqDCoMKgwqDC
oMKgIEFNNjVfQ1BTV19DVExfVkxBTl9BV0FSRSB8IEFNNjVfQ1BTV19DVExfUDBfUlhfUEFELA0K
PiA+IC0JwqDCoMKgwqDCoMKgIGNvbW1vbi0+Y3Bzd19iYXNlICsgQU02NV9DUFNXX1JFR19DVEwp
Ow0KPiA+IMKgwqAJLyogTWF4IGxlbmd0aCByZWdpc3RlciAqLw0KPiA+IMKgwqAJd3JpdGVsKEFN
NjVfQ1BTV19NQVhfUEFDS0VUX1NJWkUsDQo+ID4gwqDCoAnCoMKgwqDCoMKgwqAgaG9zdF9wLT5w
b3J0X2Jhc2UgKyBBTTY1X0NQU1dfUE9SVF9SRUdfUlhfTUFYTEVOKTsNCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

