Return-Path: <netdev+bounces-279949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFRvCRmm5mlPzQEAu9opvQ
	(envelope-from <netdev+bounces-279949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:18:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526A4348E4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF403007C98
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76824388E6E;
	Mon, 20 Apr 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="IMJwbqo2"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020094.outbound.protection.outlook.com [52.101.152.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD153CD8CB;
	Mon, 20 Apr 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723401; cv=fail; b=Fvdzl9rIGWXeN63nUYvNrc3iIGJ8sBDQN8WTqW/wfwz/Ggdeoj0ALkA+YCiPR/ccW+G2n1OeTlmN8x4ebf9hgPIeLrsAXrg1rMGu9gzxk+8lZnJ51WnFzXaYaJ2WaEIbktQBzFjnzptUgh1h0kViTikrYZ0oz5boZhodZIsZp4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723401; c=relaxed/simple;
	bh=3xOjJeaX4xNUjHM2DMplM0uopcydo+tc5fNjw9x+PlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqTQ6tVA04MoJhKn9l46mjZqN0JZJNTE9+1iEXYuJTkYH2XVOZFgDDs07Jrf7kRokwJli02ztYXHMpYDrPv/Uzmf1BoQzGWy0hLi6RQ01H765qmj7US7OefZ4a/7Qx/HjEDB+G8PoR1RpWWGtXM8at8BeZtnUpBewa3Ln6iEeHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=IMJwbqo2 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWTHmzZjhpy17rvKgwfVfV5c5sQbZgDZbD7oYFYgX5lcfpk6rl77tKbsFR+36wdnEOPslcwUrSMQ+xcbJaq4t1c1JvA4iOJL8mBoD8xseGS3f/5ouqp/04MsonYF8AsO5y3KML4atekJbljzMezT3m0bo/otYQPlpo+BTD3gGRRMgZQS7le7Ka4BinruqxquSRwijEej63vTT+Us3faX5yFCOMlfkRTz/XA9I2FgIDw77iy8t5yebzbSa3dzZvUd6FtESFxdFBYOL7RCayXm922rXmgO/NwKXJY8tH93khRuwzrn9Cm7nhOw2Hm7a+iHlDY0Ebb4t56AuYIsGNOqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxyqKxoXPemyUV/ax2eIaN0oP/QdZTzgPIj4cXLcpYc=;
 b=MLuhWAu2fmYqmzOTojhHhiZ2UA4LqQbGYtlrfvgy8GfLg8KhCEylYBoDeI2eyJ2bnfmOzpipw4xp0Gl8BfdPlA7bDJ1JTDJ/rx7l4ILVXIdw13OTux/2F+bjKkO+hYApOEQPjcoLwM+KYtrS3pqbu+MzJKkqB50ansvxN92prReVwRPl0rVIJ5kjnjr5ZYy6qsaLddtArPc+JffuPQY7IyLi4wme+WhLbCjPBohVAgf6M+hmC7B1ATboWHGFLjDygmI9cL8deBoMoM/zP40IrGIRaYj1ydjQAu/awEFMGY7F0v1REItV+tM2N+nikcPb3M1wvb8Zf1lrUP+9VJuJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxyqKxoXPemyUV/ax2eIaN0oP/QdZTzgPIj4cXLcpYc=;
 b=IMJwbqo2I2rF3Y42Xoxf0BDAA46Rr+f0jzu1MTg8ijXD0GBBY5NkK0N6ZoXJ7AksY72I5squ04pifABrCBkLAnIF5bkswTVv4F9R3OXodXILIJktdjoS+HVCWnUQzaevGZtCyNMGQjkjSLT11tZzXHxftfuYN/rkMjYD+duhWuvqK1sE3wUsIbxnmOQFShkb/4jkXQDKA/PKrdTG7UNk07nmRf4D0yU1YLCyuY1CzoruV7T8mc+wWFcRHt4bPFJx8W8XMU/ve2Nkj237LzzFBT98bNleAG0PRqe47gml1J8gsG2qgL+HLX/+0nH4kRPIlQLpvKI4a7j0UqQX/t5Y7A==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY0P300MB0673.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 22:16:29 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 22:16:29 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Werner Kasselman <werner@verivus.ai>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
	<linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf v4 2/2] selftests/bpf: cover same-reg sock_ops rtt_min
 request_sock access
Thread-Topic: [PATCH bpf v4 2/2] selftests/bpf: cover same-reg sock_ops
 rtt_min request_sock access
Thread-Index: AQHc0RNVd9G4Lb+plEOuMqVqtnwA6w==
Date: Mon, 20 Apr 2026 22:16:28 +0000
Message-ID: <20260420221621.1441707-3-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420221621.1441707-1-werner@verivus.com>
In-Reply-To: <20260420221621.1441707-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY0P300MB0673:EE_
x-ms-office365-filtering-correlation-id: 5ed07110-50ff-4b44-e64c-08de9f2a7893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Oe5kLwCuVk6WBGfjRJIDQq/u7OMliYiN51Eq0JMj0IVOG8PR4aR2JvaCiXvpXS7N2WlI00yQGw1RVKoPrdxiXBPh8oJQPGd3ytsMu6i+X+SCed/AckF0O4y1ox9fUDitH6EChoKhSR+e4M/3OM1/s4uTIFXhwPEi+0cGARClGj6fPwp1ECrQHHD7rUlzWGCCe4nNVpnxGgPMaKIK9ZkOI3i2FTrtVz3REpgcb0+uy/Vx6ZgH7TgGwdno1vOMGROwKA5gMKEvkIM4lfZp9pthLTWysNUxYMKiWr+HSUOaGqSe1gbD/71+QGOb8Qkz1eP3dY6ti3W7Rp9UJIj11J5D6Id5pbkCCY3NeyCLKxMeJUo+nG6JAaDaY9x3SoMCkRr6iXLazALDGSFVCn093Q3SpN4cU39WRN20v7xQiDumLV3hvJM7ddeflM6IimX3AP900ZWvfBPZm9lFM/w7YLCtC0uH2PMdp0v3oNcYGpFl8hITSfIi0M2rNJVrEtTugrUBhasVKScacF940LS7Z+b9s3YaFD99S4+9XWixJU53Swg98lTZZjnF/8xasPEM0RxCLjp8wpUh3bt3kr2Cjr0YI3KH54DF8wQtkmJtUE9sRLcH78xXCKaK4Hw5OunDslyO9mKozmxXH48S+T6Y6ihhLRROeYphA0rgHOiCOramQCq2d6ZxSkQFPgZtv1+F7S3mAUkKLKe4kXSWcai5Ynl0JdNv8Z+cUK1rfibdcUUvEFMm53f7YsPC/hgwoQHvWXvRhyZJ7c5YU5KuACFJzwUX35hlBGoA1kGZyULtcwpxSfM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fhlynrtymh8wYj2qszA/cJiZhyWduCjTVuVpVrx6l2U7UKlvWdva1Yq+Fe?=
 =?iso-8859-1?Q?pkseLbQ4FyjIQxQT5aUCIXwp7P9cR43AV0oFLi1XpR9UPFdRz0vmrw/JRg?=
 =?iso-8859-1?Q?dZ1mcDvCSbXOZEF68IN0F7ZNWcjc0BDN0NZx7boXsk4iE3ItUS+uAjneqb?=
 =?iso-8859-1?Q?6Zm4CuCbtWNU1ah1iPWqG7Yuk3zRwXG39g3vzyZ+Pc0ZtAW0E0VtDj1gDM?=
 =?iso-8859-1?Q?fGPW9KwmhBGj/S2yh51d0LxcJmQn55ugge5GF/bFLokii2+8o+NgFkAc1v?=
 =?iso-8859-1?Q?/Ez71nGwLXoOUkLH+BEuHLiRHalmFq18KI+2QJqrTizeTNqpVtyQqpPHz9?=
 =?iso-8859-1?Q?Z84Mrlf5WLc7gwwt2rRDUBMuDGkLGsCbQcGaU5E2USXdBFnMUrRdbGSIDx?=
 =?iso-8859-1?Q?RgT1Ns9AjVDscNx0718HPWPFN1TcL7auU9XBWEGphuutxXLpsQ3b31JcVK?=
 =?iso-8859-1?Q?O37tdGzGiFqlRYqOZpts9mkgl2L72FpWzKAHpJRpiM107xWFYIreb9IHHn?=
 =?iso-8859-1?Q?GU5IFR2F9IWpCALOR6C42u4NuglyPHS5L3LNQ67LJhr+5S+LltOkG5B5+S?=
 =?iso-8859-1?Q?aeJsxtsIj8Ma0NoEMMpxPTtocJLIrzH74GA4AFZXQ34D4eC0m83kPS7AhO?=
 =?iso-8859-1?Q?KMXeq8fB9j0fegexeMLxOgXAv8+hSK4ixv44vfSpmajgexOnsWOyEFeRuF?=
 =?iso-8859-1?Q?YDdC9T7mVIOpRbeADrlU9WSxcc5xA5F2PrkRXpCYhdmCeVpN9AcTlAPuv9?=
 =?iso-8859-1?Q?ov7DEsBIpBFQqHH9OQXGvo72pFpijgGM+BbxWvh9KwxBzsqHsl3Va8oM5T?=
 =?iso-8859-1?Q?FuhqPgpBoZJDi7r93uqL45nxk5JIzBk7ON704HVB9EdqgcURJNe8J8xWXC?=
 =?iso-8859-1?Q?B5AWcHhEvjdze+xrc9HHaRkuuCiRTKJNK2hIazrQtRZmkhmNZV2u/nyKi3?=
 =?iso-8859-1?Q?9yHZ1L373leyYYXBr6eFc5pboWAY+tITaM3a7CHdNXEfoAKxxADhkCYNX1?=
 =?iso-8859-1?Q?K34YYvaVVdXRGbCNsN+WS8vwJLq5fDnB+7noksYcSOpRnEumaHje1J+DoP?=
 =?iso-8859-1?Q?zIeAH6MD6zYQvQd6cTJye3N78NcdOEWQH48B4ZrWLFXcH3rvvS0XjbRZCt?=
 =?iso-8859-1?Q?H3FjmPO6KeJ5zOyntCRVQxOfSIgH/UC3LV88sP7tgDHLGBzyrJ66a29h39?=
 =?iso-8859-1?Q?buH0aa4h7VpcLnwNs1WOX1kRP2jFYsSAU8aa2+tstCsSdU8XJfBiIYaVjs?=
 =?iso-8859-1?Q?QjnOjdaKY3XfljGJl6lin1hI6ortCWlZo9/62eF2rhZMYwbYR0Xp0vw/4p?=
 =?iso-8859-1?Q?Xw5WhJDhQN+fd6WvOVMq53+z1mfFmbWzQohvAR63JgfjrJNLZ6PNobxtP5?=
 =?iso-8859-1?Q?YnzG0QFUlpH+m6qIvgoUDLvvrxaq7N/Ltm6tmM12Q9hyYaML66nMjdAv2w?=
 =?iso-8859-1?Q?SQ6uAlFvsErvh8QYMjAD41nTA0R6/yYQFxCYJq3KE1A0HFATky7lk5BIKC?=
 =?iso-8859-1?Q?rISX929UazF4EDzLF29WN6sL9+Zt3ne45N4i+IHHtTc3F05J1smCn2nOtU?=
 =?iso-8859-1?Q?/UpYDzSfneIGNZOqGkRTUjGN5KDRI96eYqcW/lUY1/hVCiEHdLrvsgJJYV?=
 =?iso-8859-1?Q?C1DpYBjlKo/mpdxWAVhwYwlPLdiy19mHTQ+lEjXpG/4O4LCInmBdB2NofA?=
 =?iso-8859-1?Q?XVbuI7Z6FtFMA1YFDEiR3F6EbEkVEuHddlcxCPh6RASkeV0l0BwbOv4veP?=
 =?iso-8859-1?Q?QFLv+TlRrAxhburY8H4taaWms579b6HqDHAmmw1N1hSUVQpvho91hQ3ij0?=
 =?iso-8859-1?Q?hIXouSPIMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed07110-50ff-4b44-e64c-08de9f2a7893
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 22:16:28.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1N6noGLvu0lnaaEiI8ZCQm2WgTpKx14el1wmEWaCq+zR4QKOeMvH4ZfSVl3zXFntpS6P4v3zE/pyUqwX4pRs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0673
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-279949-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[verivus.ai,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,verivus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7526A4348E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a tcpbpf sock_ops selftest that forces a same-register=0A=
ctx->rtt_min read on request_sock-backed callbacks and verifies the=0A=
observed value is zero.=0A=
=0A=
This covers the dst_reg =3D=3D src_reg path that the previous=0A=
ctx_rewrite-only test did not exercise.=0A=
=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 .../testing/selftests/bpf/prog_tests/tcpbpf_user.c |  4 ++++=0A=
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c | 14 ++++++++++++++=0A=
 tools/testing/selftests/bpf/test_tcpbpf.h          |  2 ++=0A=
 3 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/t=
esting/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
index 7e8fe1bad03f..1b08e49327d0 100644=0A=
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c=0A=
@@ -42,6 +42,10 @@ static void verify_result(struct tcpbpf_globals *result)=
=0A=
 	/* check getsockopt for window_clamp */=0A=
 	ASSERT_EQ(result->window_clamp_client, 9216, "window_clamp_client");=0A=
 	ASSERT_EQ(result->window_clamp_server, 9216, "window_clamp_server");=0A=
+=0A=
+	/* check same-reg rtt_min read on request_sock-backed callbacks */=0A=
+	ASSERT_NEQ(result->rtt_min_req_seen, 0, "rtt_min_req_seen");=0A=
+	ASSERT_EQ(result->rtt_min_req_nonzero, 0, "rtt_min_req_nonzero");=0A=
 }=0A=
 =0A=
 static void run_test(struct tcpbpf_globals *result)=0A=
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/t=
esting/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
index 6935f32eeb8f..a488b282b5dd 100644=0A=
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c=0A=
@@ -33,6 +33,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)=0A=
 {=0A=
 	char header[sizeof(struct ipv6hdr) + sizeof(struct tcphdr)];=0A=
 	struct bpf_sock_ops *reuse =3D skops;=0A=
+	long rtt_min =3D (long)skops;=0A=
 	struct tcphdr *thdr;=0A=
 	int window_clamp =3D 9216;=0A=
 	int save_syn =3D 1;=0A=
@@ -84,6 +85,19 @@ int bpf_testcb(struct bpf_sock_ops *skops)=0A=
 =0A=
 	global.event_map |=3D (1 << op);=0A=
 =0A=
+	if (!skops->is_fullsock &&=0A=
+	    (op =3D=3D BPF_SOCK_OPS_RWND_INIT || op =3D=3D BPF_SOCK_OPS_NEEDS_ECN=
)) {=0A=
+		asm volatile (=0A=
+			"%[rtt_min] =3D *(u32 *)(%[rtt_min] + %[rtt_min_off]);\n"=0A=
+			: [rtt_min] "+r"(rtt_min)=0A=
+			: [rtt_min_off] "i"(offsetof(struct bpf_sock_ops, rtt_min))=0A=
+			:);=0A=
+=0A=
+		global.rtt_min_req_seen =3D 1;=0A=
+		if (rtt_min)=0A=
+			global.rtt_min_req_nonzero =3D 1;=0A=
+	}=0A=
+=0A=
 	switch (op) {=0A=
 	case BPF_SOCK_OPS_TCP_CONNECT_CB:=0A=
 		rv =3D bpf_setsockopt(skops, SOL_TCP, TCP_WINDOW_CLAMP,=0A=
diff --git a/tools/testing/selftests/bpf/test_tcpbpf.h b/tools/testing/self=
tests/bpf/test_tcpbpf.h=0A=
index 9dd9b5590f9d..e9806215cbc0 100644=0A=
--- a/tools/testing/selftests/bpf/test_tcpbpf.h=0A=
+++ b/tools/testing/selftests/bpf/test_tcpbpf.h=0A=
@@ -18,5 +18,7 @@ struct tcpbpf_globals {=0A=
 	__u32 tcp_saved_syn;=0A=
 	__u32 window_clamp_client;=0A=
 	__u32 window_clamp_server;=0A=
+	__u32 rtt_min_req_seen;=0A=
+	__u32 rtt_min_req_nonzero;=0A=
 };=0A=
 #endif=0A=
-- =0A=
2.43.0=0A=

