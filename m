Return-Path: <netdev+bounces-307137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNB9O/XVVGpNfgAAu9opvQ
	(envelope-from <netdev+bounces-307137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D674AC4F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=fEYio7y4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307137-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 540E4304E0DD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B423FF8BD;
	Mon, 13 Jul 2026 12:07:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B33EAC80;
	Mon, 13 Jul 2026 12:06:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944420; cv=fail; b=hZJp7ZEZwGkjHxTGKb/xZCfwBU6VSqNovM4baqWU1rywJSg814DVTw5swBXbhKtqfIuVY4weqwFX8eq8wXjZpo/zC6SKOt0yF4xWaXccIQHd9WhwUGxXscrOt8FIqZOx7tRkiy0j5xIbxlxD077kxjQxU8kbmMFDKz88YnP21wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944420; c=relaxed/simple;
	bh=895RX0J6bHcHHyHMUkONGUjv+Q1BY4szsJyf8uAu19A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aymqfds3U5guzWQjY90ksGjY+wLDPN0ywm1K+R4/N3SctZdiV0SD9wxYzknSHTtPLsYP+WmOTpBa/gizDm8s+3pMradbH4IkrdunyzitFHCKdnTioZ5iTFyHsfXVXmG9S2yFIIhqsUP2cBki+2tCgXqfGfx/FmU6dVE2fqafHGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=fEYio7y4; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN20W5nxdIcr4OmGEemo6SaNT85B4LFXcMlOJ8R0PQRBhAvtqh0accM+Ai148UKdIHllween/6IT49js7miCIf6gMWRrB50nXbW9kgBX/J/fc3sb0TE3tqaH272nDxOx5M3cWlAhsHDcdkglUd4GqGYGuSuJiOdorV2vP3MQob4keOHj5hGv/0Hns6oc4QiPThtvXGacOBOEHa+EEikoP8nX5DzbB6ZsFDdo9sUN+WwyzZR9ekCMHS/OYabH3VmMxe2H2gC2f7dmhIY1+CzeGeQdgBCKr8Sff6BkxpbyNDiTUnOLOWQiuBSeM5BGYNY5q5GtU3hg4nQHn5kQArLH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DBcqwhegEvkLplB7Y9cD2OVnEBnyQIgP96GAdu03Fo=;
 b=QO9cvCsuUugH5cpylK8wbfRluiPvixjohLoQ+TkGBofrykXvqbNuCmDJBzTIXWecVdbMcRKqXuJdx4JDCp3ZpLnLZYAPUyos+gKAMDoeUgU/mMKxpCne9zTI/bwqcUB+u4RMy/V9PvicO8VcQt1Wlm4EoVm1fwVnG8x4LoqPJ7FzJPCBx5dQDkZfUNVsOpLzzLpjTO2tsu1rq8veWOahsEqNA1mMTNpegVOHg5EZZVEuNocS4unLfI9hgKAQkTe+GYX+s2ZKanBbV36swdQLd49TOu+tg3UjkKYazR8dM1jR4cRupBNsyPFB5undzxoNsPwfBIyPmCLQ8f65xPQvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DBcqwhegEvkLplB7Y9cD2OVnEBnyQIgP96GAdu03Fo=;
 b=fEYio7y46gurW0Q+iUhZFSOVfNYkYFPxLY+QSBEu91mmQFBLV25tDjNLHjEwX/1Ia40hoarzsw7xhS7SOjdTUswO9I6TDXX61+Fnvzz0gbcZ00mZ3xAOuKJqbyJ+Xgp2sxWBNNOsiMGPwEuruWCLbusjC3UXPTBoEezrLfYsGFow5E3ZO90/Hl/KYlAhBKz91PHMSzXrfDcmerXK4crEfehWIdeIwQ7TRsMPDTVDo6l9lPB32wzdtvxofNKRNZYd3flBQgUjb9ur6Qs+cGvCw2HjK9j3X/mhSt4vKNzIvyFTL/0JXOIic0FHuAMijIyNBo3KK/STcyT1g/G5YNq8qQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA6P189MB3744.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:516::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.8; Mon, 13 Jul 2026 12:06:54 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0223.008; Mon, 13 Jul 2026
 12:06:54 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v4] tipc: serialize udp bearer replicast list updates
Thread-Topic: [PATCH net v4] tipc: serialize udp bearer replicast list updates
Thread-Index: AQHdEJQ1iqPcfgevbUOWOU75e3nIZLZrXHKw
Date: Mon, 13 Jul 2026 12:06:53 +0000
Message-ID:
 <GV1P189MB1988266AEFCF1F992E0F50D3C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260710174718.1969789-2-bestswngs@gmail.com>
In-Reply-To: <20260710174718.1969789-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA6P189MB3744:EE_
x-ms-office365-filtering-correlation-id: 2db1f685-80d9-4128-dc63-08dee0d73aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|38070700021|22082099003|18002099003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 BzLqEkojz25nIrAOOOAvXUDqwHSa+uQNstF2DGc7rFK6tkgGl6s9DpMG9eRt1UQIHefjzK+W6oavSwHFheGdusqgm29/qe+INPX2ki18jFyu+ikeS+QzMy9qabiFL0Khe/6eLM/QBVOcQI5bpT1RJSvu/IDPmDwF+a9neBf71rdYBpS7QzLfPl8HaJ0qA1kw8clRkSFutH/W7qxeAURMSWqN2GQ2nvrDaBAzyRDVeFUnsIi5e9mMueRCx9kJ62TtHTkDnRFdRRuUVFQxoPZ7fTwzuIQXWEJ0r8+fxm04JYmCMvD01K8v0r8esiSNiHVExV+iexvXWOHZUa3/a4DsB5LNaIvAXETzFINzkxdannef6RP0su1xJhcKADMuebOWlUipPIkOm+HguWySt1dmzK5qKzufVwhYCpjIN8SRisX8wJIR2QGL5BiQ65N9uE8g6B722Pkmh2UIL0p+Hkd3qA0ncp38oGlXPPK2QyB/bIswSweOPLVLUNeuVOZNN60Nd6svudsqeNJWi5s7HHS8jcqTsS0/6ffuaSaIDK6nDGVKlRr2YlFV69Tgq0VQLbGm72fV67kbbwNgrzsLBJijCSV4jdFXPtmxlU0fQeMa8uu1PhilFhLsHjS68/uygunCF0RzjAl6nagQbbdg1ePzwftQnjre2QVstj+Z9V67GHv53l2z40dhUfTkms4QbeTrT+VjFVhhkImHHoyi/r5Ge9Wj8moIfIYBvG+4S8a2xzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(38070700021)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?42pnO6Ktbj6Jx1ZGyBJut4hcRcv6xdmjXghQfI9Z1jnLO9Y8aatjotUh+XbS?=
 =?us-ascii?Q?N011NLzbF3WoZvOTr99gVEjCogSXsJgecsR2TLUwsubtXupyDCbc8Ez2Zsc8?=
 =?us-ascii?Q?T6+9Twd5LKiur4C2POCWDOOiZH+IRYR5cHB8yXtUoSx6osks4VJllDhCCBt8?=
 =?us-ascii?Q?HNX+4fym5VnujAZY+XQk3Z/qQntfHmtXQOK9dQfYWZVq9vWZdh3xYgv46soX?=
 =?us-ascii?Q?YOXbQtknyA7kAhLj6stQgK4hT3VDrj6+oVeaI4PCjBS3vclkL9UhUaiDoj/N?=
 =?us-ascii?Q?HltCnSxZHmDC7ZFJONz7bvkCQWF0GrncNzbZP/sHsgyoDybElWMgMLdl7RVc?=
 =?us-ascii?Q?6atQHAOeGEIoefQWjdZMwO+EFupkgKpbEaaAi+N8v94LkELSOhHLr4gE7X+E?=
 =?us-ascii?Q?ihztleh5bBbuWJtWWSm7zBvy+UliGjUk8Ua99mpsVE0FRNZw9gAgqW9/lD3s?=
 =?us-ascii?Q?cUXiwlBequMut5gB2Oo4J6xXmO6ugZ2LfQHicZNSMnnAHRt+23uZhTMgyFQY?=
 =?us-ascii?Q?V/JCfuMq+J2GLBW0A5ZmWHs2G2rKqGkWMv/ov8YkPFg0JrjV3estG1w0yOew?=
 =?us-ascii?Q?BVgnLktkV28Gy4JR77pQM2sDHleMAP5EoUghYzBWLvi6ikrwIvfPedWuYPD9?=
 =?us-ascii?Q?b6KKrjSwALJzEdHaD2l43Pg/ZrzeLeRmfM3ZMw9imQ4gjCoJtPy8qAmhmLxa?=
 =?us-ascii?Q?pIu5lvV1mGbCVlGsUpmXDiTd/fbVFecjkCFCxFp1fchJ6TY+YKPrjEZOOdY2?=
 =?us-ascii?Q?so0e/6E1+WBwyeQ0yV6yXeNMslANhOXE01T+qz7lnahhO83MvC+U3UQx4gxD?=
 =?us-ascii?Q?ppz8wnpkRLzzBqjK2X5YMyQIhcMU53+EzNUPPHYE4HH/OL3vFc+il2q74ZwF?=
 =?us-ascii?Q?ElLCupjU4TWzPc/zOjoaPdgKYXudYgZuX81Flpsdt8OI6qErGtbN2la855iO?=
 =?us-ascii?Q?DZEu6ocH+c5J5ZSfDj4C7b6F7icf6O3HSgU2fixMerHooAT+1H2gM8GeQoGy?=
 =?us-ascii?Q?MU4ccrJ4IgtVzGc7Lt9kmESjvXt+GJmpEHzgbtjbRNuMFTIN/iFbi5xOKHP0?=
 =?us-ascii?Q?6cVlfIEG3LpqnuBDdI0qYmRBTswpat7Zu8ibtvyOFTIqbG+1Zj5UrTNl++8C?=
 =?us-ascii?Q?15sa+lOvbE6796IxX7CE3zXtRknOBKgAR8i90v6F+rrFShXQRticDpNDZMYa?=
 =?us-ascii?Q?MHxlWh3k6Xlbwtpl8Se19fFOIcvZFJxTAlsTvI6zM2G3Z3q5j+3YEmj97N+K?=
 =?us-ascii?Q?8n5wy1MWmOunJisilcwxCYDGfhaSrcsOw2AXQelT5C7d86C81jzRhOqOQ0T/?=
 =?us-ascii?Q?PlmoVks4aHw8L5IAqMSQjKplUT7p9Zlw5CvvFm0W3V8isTqtLZJFDxvkMgfx?=
 =?us-ascii?Q?Hh/XQGGxmz4SlBH3+LPOit+ZgY9QrgzfXHPd+YE0mhJOJUKbkXHBCwXnKyVN?=
 =?us-ascii?Q?n9wAvGr/zVhM50Fjq/iZRG82JHWsz/hXVrxmUsQLZxAiknP+rdK8eRx8qtXn?=
 =?us-ascii?Q?KJ+ZGbpajjcTTJATdFAEUb5CUVhvc9bHg1USpJu8/XBHcU678IgBaGQ0TIm+?=
 =?us-ascii?Q?Wc+MvBhD1aMgn74mFhYsbo0Qjc6j+3zuiFrRlCWcNmNVjhuoQItCsYeYz5gp?=
 =?us-ascii?Q?xYMp1nDwbOlkUzBQ+b0CM0BeDgRljbvLe3M0pI78hiaGM49VGXBomUny6nKc?=
 =?us-ascii?Q?2M0fwLq882pawhBmP3jkjjVHu+UXI+TmlqHclwTX0Get3LqHnvq4FyKsCeub?=
 =?us-ascii?Q?wGHO5hbD4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db1f685-80d9-4128-dc63-08dee0d73aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 12:06:53.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hn1oX40BQmZw7/ARm5fb/R9MUOW25oDGXoO1k+FCj3yAlYwdwfA55h2BLHGoEWkGVW4/7YtLy1+iqe4f6mgCYORRyGVEGrHtlMjhBIzKaeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P189MB3744
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307137-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:from_mime,est.tech:email,est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 454D674AC4F

>Subject: [PATCH net v4] tipc: serialize udp bearer replicast list updates
>
>tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
>list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs=
 from
>the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(),=
 so it
>can race the cleanup delete and corrupt the list:
>
>  list_del corruption. prev->next should be ffff8880298d7ab8,
>    but was ffff88802449ad38. (prev=3Dffff888027e3ec98)
>  kernel BUG at lib/list_debug.c:62!
>  RIP: __list_del_entry_valid_or_report+0x17a/0x200
>  Workqueue: events cleanup_bearer
>  Call Trace:
>   cleanup_bearer (net/tipc/udp_media.c:811)
>   process_one_work (kernel/workqueue.c:3302)
>   worker_thread (kernel/workqueue.c:3466)
>
>The bearer can be enabled from an unprivileged user namespace, as the
>TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
>
>Add a spinlock to struct udp_bearer and take it around the list_add_rcu() =
in
>tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so th=
e
>two writers can no longer corrupt the list.
>
>Reject a duplicate peer under the same lock before allocating, and remove
>tipc_udp_is_known_peer(). The old lockless pre-check in
>tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer cou=
ld
>both find it absent and add it twice. Doing the check under rcast_lock in
>tipc_udp_rcast_add(), before the allocation, makes it the single point of =
truth
>for both the discovery and the netlink add paths and keeps a flood of the =
same
>address from churning the allocator.
>
>Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
>v4: (per Tung's review)
> - Reject a duplicate under rcast_lock before allocating rcast, so a
>   flood of the same address can't churn the allocator.
>v3:
> - Check for a duplicate peer in tipc_udp_rcast_add() under rcast_lock
>   and remove tipc_udp_is_known_peer().
>v2:
> - Narrow the lock to the list mutation.
>
> net/tipc/udp_media.c | 53 ++++++++++++++++++++------------------------
> 1 file changed, 24 insertions(+), 29 deletions(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
>62ae7f5b5..3f0d75d72 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -94,6 +94,7 @@ struct udp_replicast {
>  * @ifindex:	local address scope
>  * @work:	used to schedule deferred work on a bearer
>  * @rcast:	associated udp_replicast container
>+ * @rcast_lock:	serialize updates to @rcast.list against concurrent
>updaters
>  */
> struct udp_bearer {
> 	struct tipc_bearer __rcu *bearer;
>@@ -101,6 +102,7 @@ struct udp_bearer {
> 	u32 ifindex;
> 	struct work_struct work;
> 	struct udp_replicast rcast;
>+	spinlock_t rcast_lock; /* protects rcast.list */
> };
>
> static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -278,26
>+280,6 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *sk=
b,
> 	return err;
> }
>
>-static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
>-				   struct udp_media_addr *addr)
>-{
>-	struct udp_replicast *rcast, *tmp;
>-	struct udp_bearer *ub;
>-
>-	ub =3D rcu_dereference_rtnl(b->media_ptr);
>-	if (!ub) {
>-		pr_err_ratelimited("UDP bearer instance not found\n");
>-		return false;
>-	}
>-
>-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
>-		if (!memcmp(&rcast->addr, addr, sizeof(struct
>udp_media_addr)))
>-			return true;
>-	}
>-
>-	return false;
>-}
>-
> static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 			      struct udp_media_addr *addr)
> {
>@@ -308,16 +290,34 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 	if (!ub)
> 		return -ENODEV;
>
>+	/* Serialize with other updaters and reject a duplicate before
>+	 * allocating, so a flood of the same address can't churn the
>+	 * allocator.
>+	 */
>+	spin_lock_bh(&ub->rcast_lock);
>+	list_for_each_entry(rcast, &ub->rcast.list, list) {
>+		if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
>+			spin_unlock_bh(&ub->rcast_lock);
>+			return 0;
>+		}
>+	}
>+
> 	rcast =3D kmalloc_obj(*rcast, GFP_ATOMIC);
>-	if (!rcast)
>+	if (!rcast) {
>+		spin_unlock_bh(&ub->rcast_lock);
> 		return -ENOMEM;
>+	}
>
> 	if (dst_cache_init(&rcast->dst_cache, GFP_ATOMIC)) {
>+		spin_unlock_bh(&ub->rcast_lock);
> 		kfree(rcast);
> 		return -ENOMEM;
> 	}
>
> 	memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
>+	list_add_rcu(&rcast->list, &ub->rcast.list);
>+	b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
>+	spin_unlock_bh(&ub->rcast_lock);

sashiko reports potential memory leak when tipc_udp_nl_bearer_add() adds an=
 element to the list right after cleanup_bearer() frees all element in the =
list.
I think we need to add more code to handle this case as below:

--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -95,6 +95,7 @@ struct udp_replicast {
  * @work:      used to schedule deferred work on a bearer
  * @rcast:     associated udp_replicast container
  * @rcast_lock:        serialize updates to @rcast.list against concurrent=
 updaters
+ * @bearer_disabled: flag to not add rcast to rcast.list if bearer was dis=
abled
  */
 struct udp_bearer {
        struct tipc_bearer __rcu *bearer;
@@ -103,6 +104,7 @@ struct udp_bearer {
        struct work_struct work;
        struct udp_replicast rcast;
        spinlock_t rcast_lock; /* protects rcast.list */
+       bool bearer_disabled;
 };
=20
 static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr)
@@ -295,6 +297,10 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
         * allocator.
         */
        spin_lock_bh(&ub->rcast_lock);
+       if (ub->bearer_disabled) {
+               spin_unlock_bh(&ub->rcast_lock);
+               return 0;
+       }
        list_for_each_entry(rcast, &ub->rcast.list, list) {
                if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
                        spin_unlock_bh(&ub->rcast_lock);
@@ -817,6 +823,7 @@ static void cleanup_bearer(struct work_struct *work)
                list_del_rcu(&rcast->list);
                call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
        }
+       ub->bearer_disabled =3D true;
        spin_unlock_bh(&ub->rcast_lock);
=20
        tn =3D tipc_net(sock_net(ub->sk));

>
> 	if (ntohs(addr->proto) =3D=3D ETH_P_IP)
> 		pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4); @@
>-325,8 +325,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
> 	else if (ntohs(addr->proto) =3D=3D ETH_P_IPV6)
> 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
>#endif
>-	b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
>-	list_add_rcu(&rcast->list, &ub->rcast.list);
> 	return 0;
> }
>
>@@ -361,9 +359,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b,
>struct sk_buff *skb)
> 		return 0;
> 	}
>
>-	if (likely(tipc_udp_is_known_peer(b, &src)))
>-		return 0;
>-
> 	return tipc_udp_rcast_add(b, &src);
> }
>
>@@ -644,9 +639,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b,
>struct nlattr *attr)
> 		return -EINVAL;
> 	}
>
>-	if (tipc_udp_is_known_peer(b, &addr))
>-		return 0;
>-
> 	return tipc_udp_rcast_add(b, &addr);
> }
>
>@@ -679,6 +671,7 @@ static int tipc_udp_enable(struct net *net, struct
>tipc_bearer *b,
> 		return -ENOMEM;
>
> 	INIT_LIST_HEAD(&ub->rcast.list);
>+	spin_lock_init(&ub->rcast_lock);
>
> 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> 		goto err;
>@@ -819,10 +812,12 @@ static void cleanup_bearer(struct work_struct
>*work)
> 	struct udp_replicast *rcast, *tmp;
> 	struct tipc_net *tn;
>
>+	spin_lock_bh(&ub->rcast_lock);
> 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> 		list_del_rcu(&rcast->list);
> 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
> 	}
>+	spin_unlock_bh(&ub->rcast_lock);
>
> 	tn =3D tipc_net(sock_net(ub->sk));
>
>--
>2.43.0


