Return-Path: <netdev+bounces-135866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63899F755
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F37B282AB6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643017C9BB;
	Tue, 15 Oct 2024 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="K/LRLGJG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BA1F80A9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020661; cv=fail; b=DFzZYEBnh/aQ1WaDj/i6zcjRzZkE/75b3ldKc5K/0s5COi32g8A7Jdq2CJcWqp7DRjONyOCUgdZAKA5qTOAnwOfFFUoN6qQ01eN46j9SiLtqX4ztjB56NrvvCtpHcRQuXH5aqi1oZynYJdFNSpewQm9xZ8SONIB5L7KlL/9pyBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020661; c=relaxed/simple;
	bh=iZc4TBUA1XAjx3gAvFXBUC+mkI4RKWCROzJlKJJXeZA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzRwAF02QKOCrOrJkIRWYUARKMIBRIDS+SJaCq/wvrno42Qc1z3a7pKCepPgqECVHBKXkwMvBdPfrXPeyRcP2oDAvCyutjiyDBwzeXEU6fKtWG6PytuD8dig/QW/Vx1ylGskO98Nic7Z1LE6j/fzT+JodN9mdX7NA6xi3EW5tHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=K/LRLGJG; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yql3yLioP+8jUvfnwZd6tsWjC9TpFFw0G3xMRPEfj9SXoCiKD32wWzRtxF7FHDrp/mx9YvmqfmCdWH5jGOZ6QD5GSzSJQhDc/STGDMr+/F/24mJ++GCVFrIsNG1TvduRZWTW1+gO3Xo3Ddr7puQ83B0r0T8msEKkhE83BwVyWL3NDQK7uwv5KzCDovF3l/BR5K/mYpnvvfDkrbZfg+w29IjZlovoO0j9DvnC+/bYvvS14M6G7vdCsPsQK1IDLye5h2XCL4w2t3eABYE0UICRvDAsxRfx+HBrP4S82nfuWsmndqDPLVVN+lBFBlYor88u5tR9C7WSuS36mzNE0TwLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kdVWaYJlgeh1uVPIwyrnYgj3hz+MQ7m5q3cwJgmVS0=;
 b=ymKgvZOB+CctufrZ/iL3xRTT2apP9b9pjkyGdC44bJXbm5CkGuABs/OYK/oc8mOG/CvGCxmOboHa0x9r9u3TLOIZgJOsu8dzx0i/yVtP98AKDSzQB+rl/mjL67zj9nx4vNm3KTgXz1rZpHqcsXSlb6mlZqI6UKJZuyJjTx1ikNwryxVOdIXwAt0eHgFCzwLRheFXVRPahg9akIP3WiCV8Kr8QspZGl0B+5Sj+dbKLs4WgRCouWecJ0REHG6iQnvofdTpcxD7I8FFTZ16rUiAqbCEFKN0xMts22M+QYNF5313+Sm2FvhQLcAIsZ7kWjulysGl+I10CRxBB31FAnofSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kdVWaYJlgeh1uVPIwyrnYgj3hz+MQ7m5q3cwJgmVS0=;
 b=K/LRLGJGMABHtViLtmh6g/PXSeUw2sUysw77ZTEJeuO8W4QVYTig3VcMFXmtcNFjeP1Ujmvh2eytbDDv3Mt7InjbLdw2I+xrrwIaHvWHjbKhNGpvXK1wb8T016aUrsD0KAPVp+CQTYPDFMWlyyA0tkNt2c5uErBas3Bg2EAuWwKvlJ37gEBq4mrvvoKat9dw9MzY45rl4kJMowbNTz8Zf6QsjJBnL/v3foACkDR4F80/cqQptWuUbQpDcz3V3lWzsfuhQGaZAgzfOdFv+KIOgjS+zfixkYItzvOO3eHIXGrVpT0ztE7Ekwo4Wb5a3gj1p5Wlv7z6rFMcZ2dhmQ2nBw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB6368.eurprd07.prod.outlook.com (2603:10a6:800:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:30:54 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:30:54 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <eric.dumazet@gmail.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ij@kernel.org"
	<ij@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>,
	"g.white@CableLabs.com" <g.white@CableLabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
Thread-Topic: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
Thread-Index: AQHbHu002t3y1kqb1UO54mP+f4JtILKHonIAgABJpYCAACwWgIAAGoAQ
Date: Tue, 15 Oct 2024 19:30:54 +0000
Message-ID:
 <PAXPR07MB79845839CD72FD7E8B15C8AFA3452@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
 <dc3db616-1f97-4599-8a77-7c9022b7133c@redhat.com>
 <AM6PR07MB4456BDCF0928403D0E598F9BB9452@AM6PR07MB4456.eurprd07.prod.outlook.com>
 <414cad58-c070-4da3-8ec4-894cdf9b551c@gmail.com>
In-Reply-To: <414cad58-c070-4da3-8ec4-894cdf9b551c@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB6368:EE_
x-ms-office365-filtering-correlation-id: 50bd9ab6-fcfd-4a23-be2d-08dced4fe2ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?93UCApOYbAbTLtQmqKbmPFF0HBC/VU19g0DNlM6AWiAcYTCi8XYLheP7P9wW?=
 =?us-ascii?Q?QuV0efrLPc8LFwmXE6PM65Q6GgZXgeiHEmDYKiMZHSNRb/fRP0KRZbY1759K?=
 =?us-ascii?Q?8Gh2y4JTY8CDVQhl1QAcqmqjlHEyQEinUVXqY59yDgbhRVYmvkW8jDIMiBeJ?=
 =?us-ascii?Q?GvSmD1bV8zev9GecaGJjZk5YoygtNlZpXYB4Ra2vIUtkUp8/kqUkBVU/FWxr?=
 =?us-ascii?Q?AxjWm301SFezQuAeF1Yt+XzexeBmfOmWia1v0n/UusCRazgOgAQybt4HhisK?=
 =?us-ascii?Q?/BcSEt0xZHiqbPRDcIyd/nJh5AUS5x+qxivXEUbzeMvQK8KtPbWC5w9z2+TO?=
 =?us-ascii?Q?s0aJ94F378WMty+fE/uE+c0Tb8DcQ949xnrztUr3kuOsITV0kvV3CszfCiOV?=
 =?us-ascii?Q?Oc1RU0EUG9FvUJmEqsPiBNZcpTZrnBzHkAu1OCl9fm4Zw6YFDdYLX6InEMgw?=
 =?us-ascii?Q?+JwLX4SK9VMuTegE+rm7e9UlejwVt820dMr6Mis5RHPhdlyQh5AsCQMdfoMv?=
 =?us-ascii?Q?ynws15dWwQzHIm9LVduNJmlF03Dga8GCY3IEh6pvzYYXnXY/HB7HhYxpE3/o?=
 =?us-ascii?Q?o8rxAe1egKjQOnI7AGDT0oMV1hlORGCocr9ipnF24niNN/AZ0zGbxG8jl7py?=
 =?us-ascii?Q?ve6weU329DsjrG61ar2rMyGZGboriaduWMwZSjzC875JYigKe2S3N1DtN61y?=
 =?us-ascii?Q?c+vzbTZf5iW+0waqdXIPzVlEY+QUK07Vda6tB4/IvIzEfQFFGEQ9ajznxog5?=
 =?us-ascii?Q?wuTIoh/t//kA/qvA215g1NeG6Jylj420TBT8XUodQPGnaIfqmfV0R5pSXVXm?=
 =?us-ascii?Q?vby+bZMeuKuxeN6VSFX7j1Z0SFVDDHcuuOSOjyk/xqcmT3WJ5NHpYRuBXUbr?=
 =?us-ascii?Q?ImPreGQzHHeGZUh6ApRQ10TGBGr7E/1K4UUX4bVX29wR9r3ujbOx9cXVobON?=
 =?us-ascii?Q?bnMVLJMo3YO3hBJ/oPDIJvylNZX/HlxH/NBK3oliW8QoVLNZJti1FHzCDf9k?=
 =?us-ascii?Q?zK5cxXq2FDT9TPqVawHFFl3OubsNMcv2Wee/o3WnorpzHSOn2/Hs4SszVW7i?=
 =?us-ascii?Q?0xz6yhCT/3Orlna47919ETpUrLgiFNShySI8qZF5gqKnX1eRK30JG8/BZMex?=
 =?us-ascii?Q?UzbjXuVBTvBfbPuNkXzqQsQE8uaU3o9F7A/RBp19QimpPRupS0pnyDwgE6TZ?=
 =?us-ascii?Q?p6AJc60e3fZtJjsK3H9zC+7yWogVb0b1Q+v/vQRtJwSeLaSmdUMLxID4oCIi?=
 =?us-ascii?Q?WjSCj/8lA4V8GRVQN2+6fEKh2nQj0olGgGXVvW+61Iq3hZwrA4LF/NnIC2aP?=
 =?us-ascii?Q?kzo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?737QP9DGUwIRsjfMbF5Gu3CZQa8938saLuMxugzeTOpr/qNEVV8+fuIDhPcG?=
 =?us-ascii?Q?ZeigmVFjQE31TtTg4CaA6zNo6OZnc1mTYr198lO84fqkXW/Sv3lLxVtAYV8M?=
 =?us-ascii?Q?icJde0gHW0ffHmVjzdfoAGwNKsYW6PDV2I74HJWnltUdkd6VeCP5fH47KX1+?=
 =?us-ascii?Q?Lp+H6+6i8cei4go4IaM+J8EtGBgR/DfIydbw/1CLUT5aX6riiFJFOyD6iLCl?=
 =?us-ascii?Q?VQK0AJD1dkTanR2wZBoDRSjivX3xHgb9WNG7bcUoHpay3xXUKDSVdCb3/9FR?=
 =?us-ascii?Q?HF+G8Ssm30ifQjzGYM7ratKau4onbhbIZNOv6+/SElDYNKAlwuMRfgPknnM6?=
 =?us-ascii?Q?2Vu0fIc4Jq0hpY9VuaoQNHMgpUWhg1bt690tTrw4NAJolSZ6arxOR2dg4Dxb?=
 =?us-ascii?Q?iLfLD0p/WUcnF0E62elbw9d0fnqj8GWCKuxldE3BuRbwciiDyHcznv8UC16T?=
 =?us-ascii?Q?iZZJwli2fPlh2C2OESS/kVg1Hh/G9ggVK1YiiC8w9xQlNUiSb6ZqYa0W/2Le?=
 =?us-ascii?Q?cGs6jrYw002A2Efrz/krbOxu+5cj+RTQik4MTCsr86vfnCTsZewx6rPaRwyz?=
 =?us-ascii?Q?1BfXi7SBg3KatxN6SWJE3FGV4lKOYaHXV+G0MOlyRuECWE7ZjDsl+n948G0P?=
 =?us-ascii?Q?IKV0pe7hyUW73Mo9iZTf57q+ttfv1U85X6q8Tyj85hTHtzGiBp0tFGppaK0h?=
 =?us-ascii?Q?KgFuZ/w3/06p4dk+3ejRDzEnCue7bLp6u/EVOe+ehIYko/v3vsu3OTwDlQSv?=
 =?us-ascii?Q?+XsR0RkP9ZXpQnTVJmoiPUMvVNJ7/u1lXz6RUhSdFqiJi1E5jZ2CYOra0JX/?=
 =?us-ascii?Q?+7hNXDSRCru/biNmpQ2jcTwosMaNiVHMg2HsKfI4LxOKc8YzH9T+BgmX4X3Q?=
 =?us-ascii?Q?kz56fx2cAKi+M3q1IzAAoWIF1zoIf+ftf44o9DDV8UyJHf1239B9j7z2UFBR?=
 =?us-ascii?Q?By5zUmVjq9ITZvlwy6Ay+s02xo+9SlF/+iDI6jUN1a+NaNST6trTkRWEQBMU?=
 =?us-ascii?Q?hWpwvj+eUjnTfbpHeF8R4/hV789lchUE10iXgsM2epJSDhqospnFE1dF3GLb?=
 =?us-ascii?Q?QRs32RDgi78dccVXA7LNNTR4km5sFYORv9xa4pLntYwk0JQ1Kc8nM9/zmvoL?=
 =?us-ascii?Q?xrM3VIXLgbAbmGkweeY1ImOkOJzJpGgNI07b8aXFohGZFNxtnDjqlaquk7Dz?=
 =?us-ascii?Q?hqczHmDiUNCOYVbn8VO62nFjpvMLp93rr6Rbrlloquyx0bqKocG12AnI4/0O?=
 =?us-ascii?Q?iM98miWTdGfNikfky0+sxwMdzw1B/J6fdMcXogxoR5zA+tydpgIY1a2uUpwX?=
 =?us-ascii?Q?fz4wNNI1UIVB3d7V8AX7Oiak3/XlXI/2bfs4fg56yeYoS0B1MEjjIMVmUcSF?=
 =?us-ascii?Q?cYEkUixVgHqW6dZw80xXtEveJWtcC08zrzHgKgdAnNdD6Z70pPaJ89m5BT4Z?=
 =?us-ascii?Q?8bwoA//vWDDEycX5sAT4VBPVfKyHDl88bo3B1lkLMaq0PHNRbEqVb5Zdm5PB?=
 =?us-ascii?Q?9kZOW/j5KRwmSFkykTscwJTC/wewnuWnQYsWeuMVT+26HGmD3maBmfqOLDuc?=
 =?us-ascii?Q?DRZ2QacRH9tiUjvyjjb79d4hrN11lN+a0gw/DuLT6TU3WtwuELIWbDwrZ4v6?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bd9ab6-fcfd-4a23-be2d-08dced4fe2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 19:30:54.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCwhEKBXawUqrZGBNChOceI8LcLFMZhvBlk/WPuB9yD9j+HTp4WomlRnd4x2KEhhnScKJ6lh7vKs+1Ne5XtDHdPcSXb03aNCAW8PZ0KL7pa2fCw91BEKt6+0dGMdMnPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6368

We will split into several chunks to follow this guideline and make sure Er=
ic in CC'ed.
Thanks.

Chia-Yu

-----Original Message-----
From: Eric Dumazet <eric.dumazet@gmail.com>=20
Sent: Tuesday, October 15, 2024 7:53 PM
To: Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; Paolo =
Abeni <pabeni@redhat.com>; Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-=
labs.com>; netdev@vger.kernel.org; ij@kernel.org; ncardwell@google.com; g.w=
hite@CableLabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@eric=
sson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; =
vidhi_goel@apple.com; edumazet@google.com
Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch=
 series


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On 10/15/24 5:14 PM, Koen De Schepper (Nokia) wrote:
> We had several internal review rounds, that were specifically making sure=
 it is in line with the processes/guidelines you are referring to.
>
> DualPI2 and TCP-Prague are new modules mostly in a separate file. ACC_ECN=
 unfortunately involves quite some changes in different files with differen=
t functionalities and were split into manageable smaller incremental chunks=
 according to the guidelines, ending up in 40 patches. Good thing is that t=
hey are small and should be easily processable. It could be split in these =
3 features, but would still involve all the ACC_ECN as preferably one patch=
 set. On top of that the 3 TCP-Prague patches rely on the 40 ACC_ECN, so pr=
eferably we keep them together too...
>
> The 3 functions are used and tested in many kernels. Initial development =
started from 3.16 to 4.x, 5.x and recently also in the 6.x kernels. So, the=
 code should be pretty mature (at least from a functionality and stability =
point of view).


We want bisection to be able to work all the time. This is a must.

That means that you should be able to split a series in arbitrary chunks.

If you take the first 15 patches, and end up with a kernel that breaks, the=
n something is wrong.

Make sure to CC edumazet@google.com next time.

Thank you.



> Koen.
>
> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, October 15, 2024 12:51 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>;=20
> netdev@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De=20
> Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>;=20
> g.white@CableLabs.com; ingemar.s.johansson@ericsson.com;=20
> mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at;=20
> Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague=20
> patch series
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On 10/15/24 12:28, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> Hello,
>>
>> Please find the enclosed patch series covering the L4S (Low Latency,=20
>> Low Loss, and Scalable Throughput) as outlined in IETF RFC9330:
>> https://datatracker.ietf.org/doc/html/rfc9330
>>
>> * 1 patch for DualPI2 (cf. IETF RFC9332
>>     https://datatracker.ietf.org/doc/html/rfc9332)
>> * 40 pataches for Accurate ECN (It implements the AccECN protocol
>>     in terms of negotiation, feedback, and compliance requirements:
>>
>> https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28
>> )
>> * 3 patches for TCP Prague (It implements the performance and safety
>>     requirements listed in Appendix A of IETF RFC9331:
>>     https://datatracker.ietf.org/doc/html/rfc9331)
>>
>> Best regagrds,
>> Chia-Yu
> I haven't looked into the series yet, and I doubt I'll be able to do that=
 anytime soon, but you must have a good read of the netdev process before a=
ny other action, specifically:
>
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felix
> ir.bootlin.com%2Flinux%2Fv6.11.3%2Fsource%2FDocumentation%2Fprocess%2F
> maintainer-netdev.rst%23L351&data=3D05%7C02%7Cchia-yu.chang%40nokia-bell
> -labs.com%7Cd3d50c18d3fd483af47908dced4228e5%7C5d4717519675428d917b70f
> 44f9630b0%7C0%7C0%7C638646115617608802%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%
> 7C&sdata=3D4ZRJsQYIsYDrKQV1olJEcrcY7uZ%2Bg7CPhR4lWWPDsL0%3D&reserved=3D0
>
> and
>
> https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felix
> ir.bootlin.com%2Flinux%2Fv6.11.3%2Fsource%2FDocumentation%2Fprocess%2F
> maintainer-netdev.rst%23L15&data=3D05%7C02%7Cchia-yu.chang%40nokia-bell-
> labs.com%7Cd3d50c18d3fd483af47908dced4228e5%7C5d4717519675428d917b70f4
> 4f9630b0%7C0%7C0%7C638646115617637044%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7
> C&sdata=3DYc3mqMnAOICPRzhPzRPbFmkOsuPReaBIgpZvtZaLPvc%3D&reserved=3D0
>
> Just to be clear: splitting the series into 3 and posting all of them tog=
ether will not be good either.
>
> Thanks,
>
> Paolo
>
>

