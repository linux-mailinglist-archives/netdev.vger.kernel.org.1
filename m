Return-Path: <netdev+bounces-296392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Edu0KUxwJmoRWgIAu9opvQ
	(envelope-from <netdev+bounces-296392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:33:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900B653914
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=rg6uyArX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296392-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E180B300C250
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7D38F646;
	Mon,  8 Jun 2026 07:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686A247291;
	Mon,  8 Jun 2026 07:32:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903963; cv=fail; b=sy4pQ3MKuuRG7HhrU7Ga6w/D5fHrF0ogNzjheYaLsUVKgR14clPHdM/cEMjDklUIt3O7e7WwqU4ShXpZI5b3J6DuHXMuHbrdi5lJwkkM7jcBkvmRMVSTUMk4tHAVQYzDLDIyl9i+vlLLkwR41eWEvzFeaEvVJf1Fb9roe+49L9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903963; c=relaxed/simple;
	bh=Dza1DjHUgiLWQajqtI2tOHLtYYLm0TgKhsYQJQAA9bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOwpmruqMTdmgR7RROzzJ3lVtkJENAcfuKwk+gNnZBkH4laLZvNlzNCPPJQp6r6effli2CLgbY07PLuV1f4+8ygnidbIIUzw+AVFhT7dUOqaDFAdpr66+MgG5RC1zZLORaSvP+GQ7sjP9LmuPiwK7EPl+v9wYTNImqbQ6UkKeAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=rg6uyArX; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URuSZ1Bl9WeO1ja7ZsSPargaB5uPBy5h3e8wR4cDxX9CEQrAm1LTTWL/9fowbqBsMK+KKU//3smkjqR9lH2dv7tOyYDGSvkfH/Rc3VQPZ8O3WBWCv8Ah8zAgW3hB04KP4HDCOdWxRCVcc+EjDIQIVdo47VdOY+yCK0f05T7722qQ+uvxPogwLWiZtpM5jM4E2INXS1A5Di05puurSGsqMwDtVLdn262//HJ7bioUSt9AR1tPDDqu4Eph0XUH1h87eeNTDebqKUk3Sv5gIeOeVOpTyCq0al6UGlnZwit9CfTSzeCNmcu/QbxtA7qgX7dQVsZouYYaOq4/f1BbwCz2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX5CjJtzx1wL7BRoNilC3HuQ1bEm7S6kCkvAvhesr58=;
 b=PeeTXhq6cUhl9Z0cXCRPaSZeMSK60Z8t5gfs4h+eiEoh2PEtIq2fNk65B7o9UBX+BE/KbO7OpGSplGbkV5h1l0c5DsVH1b+/hEEClpiwUUzebOmswfE3/i5DEDqhH+fo2NeOBNNsn8USSN1rNdhUeMrPxmX/hsDrUZfygYrwxBNPYvJdLbRUFJsiIOvfI5A1DgbQHURIoWjYuYESemb8yHY7jI67irRjg8iPOg5jkmROpBjFHlTPMG9RChdRQfexK1Z6JzK7zIqYIxqAcDF6X6R76dtGlS8KlNiAC3SkJnq8cllKlJFNdXgp+uSkdLQQ2EEGmXOFApyZLZA0bY5wAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX5CjJtzx1wL7BRoNilC3HuQ1bEm7S6kCkvAvhesr58=;
 b=rg6uyArX2nZyeU0cQ4hxGISt4gI9cSpk9Apawibn0C72JkW4g8blbp5aexbZ2/Gj44bf1Q9olSxpffmpr0eLMhRr6E6F7oPFmaYEafEYil1HJnHYVlMI4iLOhGrJtj6BQzdWSeZyuSC89q6OxOYx3AwtkfMXZJpLWvlu+8S+pqAvq5+shorEHXLo4Z1aekKUsFLQwJxFyOd6dvXRQ/29pFrIA+645pWi/3uXH9qkmOaCnawBbVHx0/bYxWuOWWCbPnQsvVzXl+NrVd7CotaD0st3PYP23IGMBYkk0ppPxAu2WelHhtNy7gsj6gOaKlAjTMNHXUtA2SziGeKfF/VHhQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB3174.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2c6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 07:32:37 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:32:37 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net v2 3/4] tipc: prevent snt_unacked underflow on
 CONN_ACK
Thread-Topic: [PATCH net v2 3/4] tipc: prevent snt_unacked underflow on
 CONN_ACK
Thread-Index: AQHc9ek/HpqKJvVBcE+lNYq5Rbw8T7Y0RJuQ
Date: Mon, 8 Jun 2026 07:32:37 +0000
Message-ID:
 <GV1P189MB1988203684AE33AEEDD5AF4EC61C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
 <63f37dc57a6d2cc614cc466582cd8d69192c720c.1780766454.git.michael.bommarito@gmail.com>
In-Reply-To:
 <63f37dc57a6d2cc614cc466582cd8d69192c720c.1780766454.git.michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB3174:EE_
x-ms-office365-filtering-correlation-id: 5717d7f5-2220-4b68-a5d0-08dec5301d47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 T97QUmTQj0NZTm6waFTD7DgC39d1l11uUhZIeehksxDoX54xX04lKXyOKeKT1se0Sm7f0gnnCByZ9Qty6bn30CV3NibXBeUMgumyVifc2VhHD2Q+zHQYwvygMlOeWuzaPn0mMMUSNkAZE1whTTQasC1GWRgBoB9GJlnFwS0v3yL8aGsSrbXVRiAtGvhpjaepMpGoP/GhfigTlOyW8UCaMwDgCDDNkJju8rLtMhYp7aqiIFD6cax/7DlphXACMI0lA3dMRm3/x+j4pUzraMpqWtBUerpLk5p+fDEKjIuWO72XI4g1wbVZQ6CGNHuvQUjcRS6pyjUG/DvNMJ3aS6RoqL083XoPtiPJ+aPkeKHaLhK/eymXb1ROW7WnkiDuRR2KEWnT1taAdDzuwHppOvKoxTqkZHZsw/XrJaMR6BxqiqrlHdCOn4IL6cjRB53Ub3wcfcXwPrUpLyr+UH4FNUjdnKz3ua2RBDr96VzBnbbPc8BRmZyJKGLZ7QiE0RweeRLy0HyGn6ySTNlaydUZyfZUB3ya3wtMLZsdvHu/lpHXjEuFMPSerOTH/LZzUph+Wzr3LORRW+OOnaTAbmPAbz709Bhyum9YSMDVrFWDJIMOE2u7IYgK410M4Px6oewz/SDv4j0wPwfuYE8ki56HIUFJSDNk4GnV75YASM778U8Dx/+uw042kbLmhxYW/i56i8cwlNplTXZn40DaAExjaHiBIdWUYWSJGd4CcTc0yLfF9cYTEtI2s5UC7CalTHYXh7PE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vuwzRxMUsjiabZ6pdaQySAIudMGipIbvG1Btv1qvFu+9m518PHGRv/nYUy/A?=
 =?us-ascii?Q?GLr4Vd2b/BAREIEDdBaY4zXQldwsr/5IfAiHiLTugKRU3kJoHAmqHRa5Kffq?=
 =?us-ascii?Q?zCS8gnZ4Dyu7EFmtpXIVhf2Nv3qRSlnDK2GkaLTKWiIF05n3OfsVZpzmo9+X?=
 =?us-ascii?Q?VaspkVvJyV40PNtFezh1zeme6AEkM08A7sqCcI7MplAMFSD3qJy4/drQ410f?=
 =?us-ascii?Q?FX/DvLR/ED1b48QoIJ/P9Rd6eCQXVGjNxt0Vo7K4otR+QTeLYKkGlpGgw3TO?=
 =?us-ascii?Q?1UIiJjMPNAbQ4hDTv42xvrcWV7p8EZgCh3FGXd+3neCcF0rXB4imSiL5gVVM?=
 =?us-ascii?Q?ZSK/OCAVPihvbE+yKtzN7xl9rVxbyj40JSfhHEoGDCAuDp9GLrYCYoP+mL0Y?=
 =?us-ascii?Q?fWvQolO8yqcgrI3QkEuvBnXUqphm2tj+H/2vuPyq/1xPAUrX8rn2aX9uDCG1?=
 =?us-ascii?Q?asIfNoEbxRV9GyDRN3QmYF6t4507eP1vQXeaOWAfNT+8EAKvblSShngTdWAy?=
 =?us-ascii?Q?OlLkzzHrI9y1y07apEdm37d0XFddl6G5K7ZlegZkXidbuYFxB6/HMKzFAkW8?=
 =?us-ascii?Q?Fb/xPyHPZuHwXP28CqViG1ioD1tlp8654GIdycrKHsjibTq6viTr5FQR4mQO?=
 =?us-ascii?Q?N9jy+PPCwm3JXgsvCEBVhZnPUQpntACIC+rhqkoMQsZ6H5v24Avxy+2q9Oks?=
 =?us-ascii?Q?VocAupAcVnHG9q6SfsK6UTC64BcAAiRZayJQfYPtiQZdhvqeVN0GNZa7Ugx0?=
 =?us-ascii?Q?XabIdpwtKGmXAyArfuR0sfzf7RzC2KBzjEDutK2zZaXiMAKOela+W3u/l8LZ?=
 =?us-ascii?Q?cJ2pvip6Rjbcp73qEhbh4jlihcyTTzWMHEZxH98uq/5mNEan3sEikgtsua4k?=
 =?us-ascii?Q?nMZ6etvzUSGGE7kPycIDxyKB048swqvmoZX8QzFf83VRC++zQk5C4qwnt0ZC?=
 =?us-ascii?Q?UH/6wuwmV6XsLP4OdhrFpIFKN0RVhdqlPcNAq3rmdUUchYx6Ow7kko4ntbyd?=
 =?us-ascii?Q?MqWob6F19D7EiIYdnZWrg+NwnB9ay3Kh1vgd9b68fU0RpDoGYbqGAYs2Hs9z?=
 =?us-ascii?Q?qFeDokkxkM6xiFdWlHFyjFr8zOtSzxjDheZ/yRvw+zEdtCZBJc21vvhQsSZ+?=
 =?us-ascii?Q?wEuz0HDVgvotxNN9thGZsjtiBDEwgu/VeZocXtK0wDNV4HiFmIPOyELEg9vr?=
 =?us-ascii?Q?iKPN/Hd9lGlL9BjPhfrDKk1HC3kLrQNENhoMhxl4KGx5g3B5OUrJ7KD0qTOE?=
 =?us-ascii?Q?OntcEqrxTCov0nBTmp9gOurIBe0q28HyHD6AOZaK7XdTBJ1CBHigfEhAGnNL?=
 =?us-ascii?Q?hTHBFbGhTYU06RG61/5JmQ5Mx7kOCXqFO+1N2QzCmtVkpm9G4K2djVdUw3TD?=
 =?us-ascii?Q?ggYZcY83nA2TA3bJxmaVhKdemZJtGVj8tot3MP6VdUlV/gzB9mAEsF9l0tku?=
 =?us-ascii?Q?73br9p00jPdwP8DI9jGYbGrjBhYtEuRg0AO0lQCKOBpNnxZNfWmbYtrS0VDX?=
 =?us-ascii?Q?9x34ATjjE65aSzyPHzqARxuhvIkE2PewWEoNEi7wLel8ZVedScW+O7W8j8pH?=
 =?us-ascii?Q?yJF/q2JtuxPJP558bCdfBFg1Njg7fmAO6yOCFsmWE1MdKKrtzjOOJCHx6sgA?=
 =?us-ascii?Q?oPVQG5ek6c1OwatnUhmlsfQYvX/VEu4oGt+OiiKiReboDafzE32EhEvzwXoH?=
 =?us-ascii?Q?7yakZLqYE4vSaW69sRlQhS3WbkF8WcxHaRSfIs1kJhviApPwP2sbtWlsle1P?=
 =?us-ascii?Q?/9ee2m70Pg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5717d7f5-2220-4b68-a5d0-08dec5301d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 07:32:37.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fnmxkoYDWuM6le9q/yZlKIGwPeEK9ybd0bWZCGXBQLC50OPZWJayeuInR/euyQ240WdB++Rv9gQxhj66duJL4IDSdfyWlWb0DsDwbeQpWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296392-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1900B653914

>Subject: [PATCH net v2 3/4] tipc: prevent snt_unacked underflow on
>CONN_ACK
>
>tipc_sk_conn_proto_rcv() subtracts the peer-supplied connection ack count
>from the unsigned 16-bit send counter snt_unacked without checking that it
>does not exceed the number of messages actually outstanding:
>
>	tsk->snt_unacked -=3D msg_conn_ack(hdr);
>
>msg_conn_ack() is read straight from a received CONN_MANAGER/CONN_ACK
>message. If the ack count is larger than snt_unacked, the subtraction wrap=
s to
>a near-maximum value, leaving tsk_conn_cong() permanently true and
>starving the connection of further transmits.
>
>Validate the ACK count at the start of the CONN_ACK block and drop the
>message if it acknowledges more messages than are outstanding. A peer (or,
>for a local connection, the connected peer socket) can otherwise wedge a T=
IPC
>connection's send side by sending an oversized connection ack.
>
>Fixes: 10724cc7bb78 ("tipc: redesign connection-level flow control")
>Assisted-by: Claude:claude-opus-4-7
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
>---
>v2:
>- Validate msg_conn_ack() at the beginning of the CONN_ACK block and
>  drop invalid messages instead of capping the peer-supplied value.
>
> net/tipc/socket.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>9329919fb07f0..80ad973cda16e 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -1362,9 +1362,14 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock
>*tsk, struct sk_buff *skb,
> 			__skb_queue_tail(xmitq, skb);
> 		return;
> 	} else if (mtyp =3D=3D CONN_ACK) {
>+		u16 conn_ack =3D msg_conn_ack(hdr);

It is not necessary to declare a local variable here.
We can do it in a simple way:

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f..f64f7a35b5c9 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1362,6 +1362,9 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *=
tsk, struct sk_buff *skb,
                        __skb_queue_tail(xmitq, skb);
                return;
        } else if (mtyp =3D=3D CONN_ACK) {
+               if (tsk->snt_unacked < msg_conn_ack(hdr))
+                       goto exit;

>+
>+		if (conn_ack > tsk->snt_unacked)
>+			goto exit;
>+
> 		was_cong =3D tsk_conn_cong(tsk);
> 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
>-		tsk->snt_unacked -=3D msg_conn_ack(hdr);
>+		tsk->snt_unacked -=3D conn_ack;
> 		if (tsk->peer_caps & TIPC_BLOCK_FLOWCTL)
> 			tsk->snd_win =3D msg_adv_win(hdr);
> 		if (was_cong && !tsk_conn_cong(tsk))
>--
>2.53.0


