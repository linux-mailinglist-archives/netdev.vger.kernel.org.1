Return-Path: <netdev+bounces-302441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cb+OFlzaQWpjvAkAu9opvQ
	(envelope-from <netdev+bounces-302441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:37:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B3F6D5878
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:37:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=ccxbY5LE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302441-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302441-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A10300FC66
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 02:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D3235E92F;
	Mon, 29 Jun 2026 02:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D692853E9;
	Mon, 29 Jun 2026 02:34:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700460; cv=fail; b=h9bnjeTcuhs4w68LjYuA+KTGmx4jhqs5g8bKb0kkfHC2sy8cDDT3ACYfA7GpHVnklttCQ7DvncX5x+TT52e7MX2NW/gCEO4pyj7HJC44xNPSuHCW9Y0zO2Ur48uY51xnPaDmu9M35w/7YuxNhORJ+9etW1EoJjB6St6zZ+71eZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700460; c=relaxed/simple;
	bh=QIRdylH0B5l5ewajwOvX88jwZd1GMnIx8LdFuojkbrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UxZ7QE0zKFCUhr4cemVuIFJo/5XwQS0ECvsbjkTD7UXl0gd/7atBVITUohvmlOUxwHO7FnNJcSbHyUW/z6QFDbUqZQbifU0psOa5fgiSooZuniF1i3BPO8rTWugyR2srISBzyS19lCaK5YQyXsSi8sz4RM/7op/ZEmaNgKiNKBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ccxbY5LE; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egkU0ycuiFrzDtgnUPV4t6S2iDCYKLVnHLgQdbaee4w8pEMXnptRIhM7DZ304skmLw4g7+EScLOIL8va9z8eloZtoUcwQ0/a94IjL8ESuumtEwGT4DpEzT/PGs7ROw8zsnSwmpfNO/8tfiTH051NToSkioKg0bS7U3X6Nf4ZYCnBwvQizguOi9kUzAwSynMkbvxWx7JPVftcK5a8dBG1a6oaWDqbF6KIHhRnU8JQ83uTMgFM+giP4oDeAn6L6OGbJ0a0XVgcCdvtAePke4AKDBekn400++WnOkiYLrIRJCScb/DxJiPj7cVKLOWeCicLxpycIImxhsMZJI7nQYq99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHvfCXUzyCLRtOJUbVLgtqW2mgu8F5C07c6MjD0r2OI=;
 b=rygVExryTno7jCfykcz6hhmFSOPTyIsyApxngAyLHfYUyvyQDmhjcB2l6LlQIazSbrv8OBpbGdmw58MXCKyHEfD7NjWB+Vun/CUhn1VwiqIQsREeKtge9YijtLmk9PDz2pT02tH/+ys4pBgwr5QCOVPXyzmcmI+2HvF7p74dM/vHrP0gG29tZaPxlEjRs21VrStZWjPdND/FYfxOqGZHMoXIiWPaAG+W/csCxHyB6jzPzFQk65Q/H8DxiY9K85Q0txShMQIbtmsMs6YByh93xS+ZE4tYd7lxNxSFxuMHarSsTQCGXlcIU5hvD7/EhHJbjkUHbc5m57DekMDT4APT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHvfCXUzyCLRtOJUbVLgtqW2mgu8F5C07c6MjD0r2OI=;
 b=ccxbY5LE2Jptdj87MXTiw4F9o9nYCu8xBO3dc7+FdpKJt+KxILT3F00tHa2QNEc7RreUUc4g8mUtVBaPk22GMtDQhsDDSy30wJjKLzzuHZLAg1W+wsEp0EX12z15yfvAWsoeiOwVf/N/ZZwzsAerRP4OHENzePso0KtXk+LRyQwcYP0x4VRh48eeVyH0nmTlox4AS+27l1f88UCsxJO7kQLSlw2aAV5DNVlJ3umvYBE3vIoHuR/bt0vfFSadkqlCf0xhhxXAtA3kwS7LlxpCdkuIE7GoPEeSF3+c45fd7TrdgAioAY+LQ4aHPKSgfi/nDe8rKzMX6xzgOAxI5sxGzw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB9P189MB2002.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 29 Jun 2026 02:34:14 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:34:13 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Samuel Page <sam@bynar.io>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v3] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Topic: [PATCH net v3] tipc: fix out-of-bounds read in broadcast Gap ACK
 blocks
Thread-Index: AQHdBLBSW7SmmdSg+E2IKDDXp725irZU1aEQ
Date: Mon, 29 Jun 2026 02:34:13 +0000
Message-ID:
 <GV1P189MB198812FCB54E389ADDC91B27C6E82@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260625143815.1525412-1-sam@bynar.io>
In-Reply-To: <20260625143815.1525412-1-sam@bynar.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB9P189MB2002:EE_
x-ms-office365-filtering-correlation-id: af740d8d-4c51-4b62-4ac5-08ded586e87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006|3023799007;
x-microsoft-antispam-message-info:
 24rEir/mdb+kwrt9Ksdn8ahuJGU/J1Uj6HaXA1oH1aWgJm45L0FK0NMY8gxFF2+9aVc3N1vQiVQJiUR3cdQ8yQFSTbzUmT4ZQQTpHR2YLtw81YI2Gsmw0BAIzRFXqLzZEs9D/fGurW2Cw9bJRif5iSumYECX2yLJjnf9nEj3B8aWRQdMklbj6PQXVPtlPXrEfzoPzzv7mNU2NG8zspnWhP58Vzsfe9A9sF4CkTXYnlZTDMN64VZ0HOvIRl+5tmdT+m69sxu8DoMoHw5+/L/qjk75wezh+ysO7cpube2OaHMLfEqQLS0jheCEaiWIVjqOJfBCZEzFB/2fWHzG0fQnumaPPx2qQy07TNOOWgDjPSzIJQl2wjQCM1VAPl6mCPq34aEtYtmWcs53IdsjCXwdbjExdRSxmPZQt2r9W6NnoPgeYWvdRKja0XWOdl609fM1acI1Yq4exZ8LeRdGY4OOFzN4YC3LYSIAC//J6cXI9WmYBBL3Dk1QK5pjSLB9EUL93mS/NhfS4J55PvQYljdfTUCXB0hNNKIFS55Qji5ar29d2AGpGH2+TcGnPt5nGq4GJxvq3xCQayXocoP0/ddy/J9uJzWa/UMsBLVK+8+6NZaC1lX3FIEqqJW9scb/5uml6oJrEBZjff90MeC4b9VhH3hg5vIAkfqCAvRnYD3kjTTGTaJf3ZUJPstwGh53Qvi8eU34h+ZrME71xBeisPmvKy5DgbfcsGXhITRMbl6HR/M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?klBJljuViVmTea7gaM/IpwYtDDqTcACDQEhBPn2qQpXli5S1w9uBcLhKC2GW?=
 =?us-ascii?Q?7reXR6W7JKFE0lLpIA2FAAsAasb+PuFgFcKIQwo1fiSIPoDJysfMn9E94gIp?=
 =?us-ascii?Q?RrQzMziFof3VJOPEHqIvJAtw44TqC4MgtzChrypwSOe16UdOawINz661CFui?=
 =?us-ascii?Q?V7/PmAsQ/24rC3Y47cdWx1RzC4VBz1ESElcNJaCUyo4Qm2mJg6nHQUiL2dWc?=
 =?us-ascii?Q?1S7oSkDzE7lJ1CHk6NRYYZ/oaszTNSJhu8MmenAg9CwUXBIfGPY9MA6YFnoz?=
 =?us-ascii?Q?wOwo4OjUSgX8lEwo+fyms6Vu2L2J4pnHg1BbspOvvt3u51T3DhY98PYBOX83?=
 =?us-ascii?Q?BbNmZBsN2YLCoxwtV5e/vmU/KuaT41B71XQE+qxmKzu3aOgifyJY2y6WO1bP?=
 =?us-ascii?Q?y++rPA7pHYjdfCZmCwE0RKwIXLSqJzZaxwW41VmNaOkoL4rs/UhePe+vr1SN?=
 =?us-ascii?Q?OJKqEbd0ZyHI0vWZPx96yIN9aabZkE7VyQG721Al7A6ZWjlXxLrSF8wCHRlj?=
 =?us-ascii?Q?dwCug65d/Gheki+sJOuzvjwLo0ALyLxkYRycXsk7LmMlGmIuq4ln9Eo+Blmo?=
 =?us-ascii?Q?DxiNYXNtsa0pk7Atx92Nugyrhc9ldijgNM0fpiHHr7D9ZG7C6q5TbvBGNnyd?=
 =?us-ascii?Q?pqpaBRaB6Hm83Ves/Rp6oPJx8TiZr4BkYrbsSHFzjeRBtd+XRjUDW8mvT5vD?=
 =?us-ascii?Q?kPwxGggQdeEw+G1ngIuOS5cLIctzdoZLTRNj3DOkqIY2rphpA8R2wssK6Lja?=
 =?us-ascii?Q?uPBsaGKny08OG5nl/Gt9APQmcZEhWV5wl9R/yiV1I75e6Sprq/kBezuNq8Wn?=
 =?us-ascii?Q?goojHDT4b+LoG6B9mWdwCrpBLlgiP1nsC1aldtdSt9WLi+J7nZwnVvU3pYyT?=
 =?us-ascii?Q?3zP5eQIbflrt4iOduA3xkvdBJKwT1y4YItEirVzwlrdIdOjY5iixng0SiN+6?=
 =?us-ascii?Q?y4aBj8DiM7r3KI4c4FWRE9TrwEfiXM8TMDWBRPS4OYjNiRo15QbUazMW+/nQ?=
 =?us-ascii?Q?I5BmLkWXq2XBK9cpVW7pT6WeK7rrCANFTuzIb7t2aLZIgfv/EMsx2T7qPGS9?=
 =?us-ascii?Q?AehBFY4Wo5J9ioUoDyO6LDayS5EWt3gWq5AJqgM4tdJtxwFgYNYJJArFBaLl?=
 =?us-ascii?Q?hXfV47CsNDL8pkm83yDbuguy1UlMWxJvJKrdmkqT2SEbUKKpWF/0n+jWkhSl?=
 =?us-ascii?Q?PYbwolk0csnDQfLPlpLR32McEmrxXEi4CJ8lYQc/CJCbMrPPiTVDbxFDw0vG?=
 =?us-ascii?Q?8gCtvGx7EFHNdcI36swabRD2QUZCI/R+OxuFXly/3bg/CoFQJv7uUWYj0Djj?=
 =?us-ascii?Q?ZyHCYuiBrNPN5Eijqr3X8/3EQdJu77Bx6eOMZ07uuKFuvf1F23nFvVeVoM+M?=
 =?us-ascii?Q?57/II1yZOpxWHjsshrzrDgmcl7fkQtKOMa0dvXC34Ss4GZDfh2iUmaHuuYZc?=
 =?us-ascii?Q?Kkwj8GnplKmGdg14v6WeBVZLZbkvG/2SZxsdQCzkqCrf75uqpf6RLfcUj1Gg?=
 =?us-ascii?Q?4B8w3KIydrOReECWaxEYtA7YPZn3coazjlfRMsC/Zqy9TCyqGR6aOKOdM2xt?=
 =?us-ascii?Q?g+ZbGtGPfDm3j2bQTdcmSLWnkEzPC9Lnyd4U6JhbDkevS1SMnsBx4ec+/t8C?=
 =?us-ascii?Q?YNhdzyTmMo207uUvRCI7p6S7me/6wbsGXwUCIVHSbOVQDeknFhrOqOz5tKyL?=
 =?us-ascii?Q?YflAkZvVBqL4CVMuHkKovgoj8bG85i0VQ0oYt56iajwE8qy0qphZUO5lN/MT?=
 =?us-ascii?Q?Jg0EhwgUgA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af740d8d-4c51-4b62-4ac5-08ded586e87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 02:34:13.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3LmCo2QUbcLotjXn5N6UcTPSu+T4SJZc9MrzI+UPqmbSWZDXZW0w4skeGjPqJjcIXY/CwoZ7uzQYIc121uscEo7zqKKHpqfZBLZ+QXH3yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB2002
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sam@bynar.io,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,est.tech:dkim,est.tech:email,est.tech:from_mime,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6B3F6D5878

>Subject: [PATCH net v3] tipc: fix out-of-bounds read in broadcast Gap ACK
>blocks
>
>A broadcast PROTOCOL/STATE_MSG can carry a Gap ACK blocks record in its
>data area. tipc_get_gap_ack_blks() only verifies that the record's len fie=
ld is
>self-consistent with its ugack_cnt/bgack_cnt counts (sz =3D=3D struct_size=
(p, gacks,
>ugack_cnt + bgack_cnt)); it does not check that the record actually fits i=
n the
>message data area, msg_data_sz().
>
>The unicast caller tipc_link_proto_rcv() bounds it ("if (glen > dlen) brea=
k;"), but
>the broadcast caller tipc_bcast_sync_rcv() discards the returned size, so
>tipc_link_advance_transmq() copies the record off the receive skb with an
>attacker-controlled count:
>
>	this_ga =3D kmemdup(ga, struct_size(ga, gacks, ga->bgack_cnt),
>			  GFP_ATOMIC);
>
>A TIPC neighbour that negotiated TIPC_GAP_ACK_BLOCK triggers it with one
>ordinary broadcast STATE_MSG (msg_bc_ack_invalid() clear), sized so its da=
ta
>area is short, carrying a Gap ACK record with len =3D 0x400, bgack_cnt =3D=
 0xff and
>ugack_cnt =3D 0. len then equals struct_size(p, gacks, 255), so the consis=
tency
>check passes and ga is non-NULL; kmemdup() reads struct_size(ga, gacks, 25=
5)
>=3D 1024 bytes out of the much smaller skb:
>
>  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x48/0x60
>  Read of size 1024 at addr ffff0000c7030d38 by task poc864/69
>  Call trace:
>   kmemdup_noprof+0x48/0x60
>   tipc_link_advance_transmq+0x86c/0xb80
>   tipc_link_bc_ack_rcv+0x19c/0x1e0
>   tipc_bcast_sync_rcv+0x1c4/0x2c4
>   tipc_rcv+0x85c/0x1340
>   tipc_l2_rcv_msg+0xac/0x104
>  The buggy address belongs to the object at ffff0000c7030d00
>   which belongs to the cache skbuff_small_head of size 704
>  The buggy address is located 56 bytes inside of
>   allocated 704-byte region [ffff0000c7030d00, ffff0000c7030fc0)
>
>The copied-out bytes are subsequently consumed as gap/ack values, but the
>read is already out of bounds at the kmemdup() regardless of how they are
>used.
>
>The unicast STATE path drops such a message: "if (glen > dlen) break;"
>skips the rest of STATE_MSG handling and the skb is freed. Make the broadc=
ast
>path drop it too. tipc_bcast_sync_rcv() now bounds the record against
>msg_data_sz() and, when it does not fit, reports it back through
>tipc_node_bc_sync_rcv() to tipc_rcv() so the skb is discarded rather than
>processed. ga is not cleared on this path: ga =3D=3D NULL already means "l=
egacy
>peer without Selective ACK", a distinct legitimate state.
>
>Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
>Cc: stable@vger.kernel.org
>Assisted-by: Bynario AI
>Signed-off-by: Samuel Page <sam@bynar.io>
>---
>v3, per review of v2 [2]:
> - reverse-xmas-tree order for the new 'glen' declaration in
>   tipc_bcast_sync_rcv().
> - tipc_node_bc_sync_rcv() now checks the validity flag and returns
>   immediately when the Gap ACK record is malformed, rather than relying o=
n
>   the (zero) return code to fall through.
>
>v2, per review of v1 [1]:
> - v1 cleared 'ga' on an oversized Gap ACK record, which let the malformed
>   STATE message be processed as a legacy (no Selective ACK) one rather th=
an
>   dropped.  v2 drops it instead, matching the unicast STATE path:
>   tipc_bcast_sync_rcv() reports the bad record through a bool output
>   parameter, propagated by tipc_node_bc_sync_rcv() to tipc_rcv(), which
>   discards the skb.
> - v1 touched only net/tipc/bcast.c; v2 also touches net/tipc/{bcast.h,nod=
e.c}.
>
>[1] https://lore.kernel.org/netdev/20260623135443.3662041-1-sam@bynar.io/
>[2] https://lore.kernel.org/netdev/20260624135629.727262-1-sam@bynar.io/
>
>For reference, an earlier thread proposed validating inside
>tipc_get_gap_ack_blks():
>
>https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.
>1775809727.git.caoruide123@gmail.com/
>
> net/tipc/bcast.c | 22 ++++++++++++++--------  net/tipc/bcast.h |  2 +-
>net/tipc/node.c  | 15 ++++++++++++---
> 3 files changed, 27 insertions(+), 12 deletions(-)
>
>diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c index
>76a1585d3f6b..10d1ec593084 100644
>--- a/net/tipc/bcast.c
>+++ b/net/tipc/bcast.c
>@@ -497,12 +497,13 @@ void tipc_bcast_ack_rcv(struct net *net, struct
>tipc_link *l,
>  */
> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
> 			struct tipc_msg *hdr,
>-			struct sk_buff_head *retrq)
>+			struct sk_buff_head *retrq, bool *valid)
> {
> 	struct sk_buff_head *inputq =3D &tipc_bc_base(net)->inputq;
> 	struct tipc_gap_ack_blks *ga;
> 	struct sk_buff_head xmitq;
> 	int rc =3D 0;
>+	u16 glen;
>
> 	__skb_queue_head_init(&xmitq);
>
>@@ -510,13 +511,18 @@ int tipc_bcast_sync_rcv(struct net *net, struct
>tipc_link *l,
> 	if (msg_type(hdr) !=3D STATE_MSG) {
> 		tipc_link_bc_init_rcv(l, hdr);
> 	} else if (!msg_bc_ack_invalid(hdr)) {
>-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
>-		if (!sysctl_tipc_bc_retruni)
>-			retrq =3D &xmitq;
>-		rc =3D tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>-					  msg_bc_gap(hdr), ga, &xmitq,
>-					  retrq);
>-		rc |=3D tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>+		glen =3D tipc_get_gap_ack_blks(&ga, l, hdr, false);
>+		if (glen > msg_data_sz(hdr)) {
>+			/* Malformed Gap ACK blocks; caller drops the msg */
>+			*valid =3D false;
>+		} else {
>+			if (!sysctl_tipc_bc_retruni)
>+				retrq =3D &xmitq;
>+			rc =3D tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
>+						  msg_bc_gap(hdr), ga, &xmitq,
>+						  retrq);
>+			rc |=3D tipc_link_bc_sync_rcv(l, hdr, &xmitq);
>+		}
> 	}
> 	tipc_bcast_unlock(net);
>
>diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h index
>2d9352dc7b0e..55d17b5413e1 100644
>--- a/net/tipc/bcast.h
>+++ b/net/tipc/bcast.h
>@@ -97,7 +97,7 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_lin=
k *l,
> 			struct tipc_msg *hdr);
> int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
> 			struct tipc_msg *hdr,
>-			struct sk_buff_head *retrq);
>+			struct sk_buff_head *retrq, bool *valid);
> int tipc_nl_add_bc_link(struct net *net, struct tipc_nl_msg *msg,
> 			struct tipc_link *bcl);
> int tipc_nl_bc_link_set(struct net *net, struct nlattr *attrs[]); diff --=
git
>a/net/tipc/node.c b/net/tipc/node.c index 97aa970a0d83..8e4ef2630ae4
>100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1831,12 +1831,15 @@ static void tipc_node_mcast_rcv(struct tipc_node
>*n)  }
>
> static void tipc_node_bc_sync_rcv(struct tipc_node *n, struct tipc_msg *h=
dr,
>-				  int bearer_id, struct sk_buff_head *xmitq)
>+				  int bearer_id, struct sk_buff_head *xmitq,
>+				  bool *valid)
> {
> 	struct tipc_link *ucl;
> 	int rc;
>
>-	rc =3D tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq);
>+	rc =3D tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq, valid);
>+	if (!*valid)
>+		return;
>
> 	if (rc & TIPC_LINK_DOWN_EVT) {
> 		tipc_node_reset_links(n);
>@@ -2140,12 +2143,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb=
,
>struct tipc_bearer *b)
>
> 	/* Ensure broadcast reception is in synch with peer's send state */
> 	if (unlikely(usr =3D=3D LINK_PROTOCOL)) {
>+		bool valid =3D true;
>+
> 		if (unlikely(skb_linearize(skb))) {
> 			tipc_node_put(n);
> 			goto discard;
> 		}
> 		hdr =3D buf_msg(skb);
>-		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq);
>+		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq, &valid);
>+		if (!valid) {
>+			tipc_node_put(n);
>+			goto discard;
>+		}
> 	} else if (unlikely(tipc_link_acked(n->bc_entry.link) !=3D bc_ack)) {
> 		tipc_bcast_ack_rcv(net, n->bc_entry.link, hdr);
> 	}
>
>base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
>--
>2.54.0

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

