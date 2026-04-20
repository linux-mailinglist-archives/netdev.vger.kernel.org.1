Return-Path: <netdev+bounces-279951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHH6CUuw5mknzwEAu9opvQ
	(envelope-from <netdev+bounces-279951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51F434C50
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2863024CA1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A93339C009;
	Mon, 20 Apr 2026 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="km7zEmWL"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020128.outbound.protection.outlook.com [52.101.152.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99F39B963;
	Mon, 20 Apr 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726044; cv=fail; b=ElqlBCqDtdCANWSl7Ofb2mrKjiSddIzMy61si9VuYZKuy2z19d6ScBnvFBLsD99IlpRCkRDjEZFuDm0Crgz/FQE69/9cGW/Vls4SdtKJloq6p0sgm8lIO+U5+7pw5WA30fYIQyXIv+yJvdxI+ngXe9++e4vaNB0xhJy2Osxu1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726044; c=relaxed/simple;
	bh=sW7y9CtpxYerTLeg8gJpWQUkX3wYpL5EA/+jy5EHK4w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYUGn2a/K4qFpHWj6XqiL56vPWCgr+q/Isg08OCSppDux0CCjJBLLDFhBcS7SZOAffioqu7SBLapAmoIsiwNJdM68PjUasF07QpE3xfCguEa6Ng3b3gIeBn3efep4No7Yx7d+s8iBI4bdahg9kYFCZT/VZ9tSQV029hczRQz5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=km7zEmWL reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq69aohO7AzVPnKyST9tt6isf46fORJfzBjwBk/e6iWeKIpX0xP0UQXiaAju7Qh+VXo1HO38VGYUDkieXr2I5Z6JZyl8l6AbGrwdAdcvhmqHLONaKOks49XkzbEsgfSUZrfHuLVv3FQwekX17Y8MgZxHfeCbChhzNwc6qUH+0DI9YRV9mzpDPciQfknZ92BjMJcdHDYVxTgLKM4ZgUwp1LI3yFMhfvzjvWWjiSzWD8iI89gQ8Aff7zT9IiIhqkDcby6g8uOUax3ogo+Txeh/ufqmZB2WgxWtuwE9CxUCJUdpGQR7aMLnseJ8+z7QgL5jwa5Lf/6xcd7EFlD/smgFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54ncboGZ9EsyLZVGpla4yHVyGbBAgkskaug7rdphqUQ=;
 b=rBwaB5FjGCyzITRnIuAA6rZVSPd2VWMiFQjRxF/A6hduUwA5Ue/XQJIS25ZwN3XKrymmAU28NZv8AfDubtwq0xtf5dMNd+NW8+ykxsSrmL9tlMv3QOj3rSqLqtv2bLj3UFg/Ro7otMpiukIN4Q1GuPLYPeRIhX67Aum5orH3vUVZFbJxhZHBZNiQS+cLs47kfrFhOREwtIrJq4MYXaqct9khMUeT5SpEi/DRVRzgN0ilP/hLSjkFLKMpoeMo3zKb/lZUeXbBf5e6cMb1Z/5pgse06POi+hqeADKjtncAaEcq/up8Wjdg52zvs44bLo2VUA+VXwY00hthNVBSB+iQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54ncboGZ9EsyLZVGpla4yHVyGbBAgkskaug7rdphqUQ=;
 b=km7zEmWL2UMzpFKealH8jIkOHqACkAwRBK8D+V6Y0bv/feDPV17/0ZugPyEdUADIpxBXfxmp2XpGGPnnuSxOHYBg5Y2bGlT+FIiP0UwW7+aY11JpXw2TVt2yfTaUDv0V4GDy9Sav0D/NVo200JW/iVaFeOoLIZX29c9Sr/98d1WjVG1YxVLaMGCewg8msNH53oWDjQsjhIaNVlgUJa3HdtUhIwtxyWA7adFipq4dWlhiUXxEmGNNCJnCxINmEboIOYvKizO6OvMnGTndDre0iXaRV/qFmGychwg2M45FPVYI3269mzwfFiqsc4wTSRkejgd2jnkxU8ai9cGbBgZGIQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1562.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 23:00:33 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 23:00:33 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: [PATCH bpf v5 0/2] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Topic: [PATCH bpf v5 0/2] bpf: guard sock_ops rtt_min against
 non-locked tcp_sock
Thread-Index: AQHc0Rl9oN1BAIfwaU+UHCfCuVGjFg==
Date: Mon, 20 Apr 2026 23:00:32 +0000
Message-ID: <20260420230030.2802408-1-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
In-Reply-To: <20260417023119.3830723-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1562:EE_
x-ms-office365-filtering-correlation-id: 3bfa9c03-49e4-425d-0613-08de9f30a051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 LIMoVMPwlKDcS/UXlHtefoGfaK90uNkouAGkhtVA+dWQ47bI0JgisgtBAqJlv5T8zgSq4sf9PEf/f1REGrj9nZ+ITfpRGWpOZ5c3JM+/S8AbGwaI807XJunnErNtKVt1ryOevVE04w2tAhHMCWmAzKgW6mQmZTfPtRulpbx4YA9R69B1fPBDrhgqQH+7GH5lqCGZqx31eRnHaNxKI/8eJgeIBzyDAF4QE1AoIkQVitCRM9pmTxjnyhHcYVBkSoBk70pTs+kPZT1aOaRM4uGTsQP0BU0BT2slyYApmKuagXI7yfMi0Quu4IAukwQ9LiC4OMmYDiHzejWFDOinWNj7rR4eQbaECXWxzKiW3vsSQ1jeBUeOj0aoUFdiCZlvqwpEkJQPkjyweSPjLjhsLrZmbYPZoUTH2FpVxQzBmgu6jsWVb1pP4bAK+MDbE2y8ca5WyqS/pQyDbniFpsGBQG4fFbz11ZV5xXwnNBJtcJjokixdUpm9k2Q8Qat0YEINGfbwt9O6GDLeSjs+2yO3XxT9/tVMhBcJ8+wuGKa8WqnETqirWPxVlz3K3k1cdqYdu+hF7/Aiqy/uCh0L5uW8YkpD6OWk8rGbQL55bukF9O//dxrJWSE2JdW5L4brfY5CqHgyKT+wCMwOtmz9EZ30Us/qbe7jVD5dIxJo6pYGgLcLN0ZVW6liXF9AyJSc8MYanBWfJUNyAMaRNglPOGKXhEwSYU57uawk/VVldfBb0r+m0K4qjgpOv5BgnZE7vFtM3C3Nf6eaJt2FyfoMGRRSM+5SHueUi59mXHtgmIXtFwyjL+k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PVVTGIUFV3xs5J01Ak5wqOizhhSg4mc/zAwG395Sop/jPyyr78i1RMRpXi?=
 =?iso-8859-1?Q?RZUkkhh3Ypb2BQfeG3u2z5fD0sUTVep/bi46/1oKuv60xJZacdHclkTQ1L?=
 =?iso-8859-1?Q?5qOlv/2MAcqXVpkocESV+YqFPKcR2FLA82dlK0YzLPrvl8R9liw2nPQpuj?=
 =?iso-8859-1?Q?vG4HuV19bFGuHD0wd34bDmgt5iReBd0kAFsHOX/mT5PTPfceF0ZGtbmerl?=
 =?iso-8859-1?Q?SXTf4ycxKq8azzV1e7z23FWnUbSpk+VCQbsTuHJVFQqGjhEvw+aDmi2NWo?=
 =?iso-8859-1?Q?4ypY5AOqmyy1iHYCz9Ttj3b7CpBw/mY7E6/iriB/ySdGTqsWagf6XxKfAg?=
 =?iso-8859-1?Q?S97CtugOUfFY9N8IDPScvJbuKqV3cS/Bkmotbur0CDUyHDXt8g9a9LlO0s?=
 =?iso-8859-1?Q?iq3qUHv/HD/V8AbksoT2obs8A/H26bZJCoKpJ1V6zYFnXwlgYJk6X+Bzlj?=
 =?iso-8859-1?Q?cwqsEKIiR7n9NJYIifDrLhRi2ETpXwDiF8qsiDniHrAhFbHqtwhOu1sRc3?=
 =?iso-8859-1?Q?XesfWsTpWsUfVMTbCrgoxUOFBpQNIpjG55mhNFutQa7vKxRRiRM54eOPT0?=
 =?iso-8859-1?Q?AtvB+TdncW5ijyivysEkkxUqrYmjeNsIDkq14i5pDJnatP/rzUhjQIayuy?=
 =?iso-8859-1?Q?VUGfFoIQXYmfbbFsxY89BO01rAQVv5epKaxinHmoL41LuntJOlFbceXqS0?=
 =?iso-8859-1?Q?yF+l8eZ6yLJdMyk9COZVDqgM+bSJPQK1IZHZOR6yzQwdir4eP/8ioRFyUC?=
 =?iso-8859-1?Q?BCTMYCb7J3FLM5Hg+THTAcdBMNpe0xsNMTtfitsiAjNfO1iu0MhV8+1bhD?=
 =?iso-8859-1?Q?K19jpt2mJ9l9ih8gQ9Wi7Ssa8zxdp80/kEnMuixmGXRtNDeOawFHq/2KH6?=
 =?iso-8859-1?Q?4jd5sOcnbECg7ydx09nxF5RBdjVvzMqYvQx/CoQliVUK4Uu+roSmOT0u5X?=
 =?iso-8859-1?Q?e1iYwur8XbWknx8xn6AZuDtOpMaSOhJDNpoKMH3/INpbz40mnSiGry/OaS?=
 =?iso-8859-1?Q?sCgd7d73KjxMDspc9UUUA32rWyarMFn6jPvoRnu+qis0hh7inxsIi54KVa?=
 =?iso-8859-1?Q?K5w+EU7rgN5TRtUQEpspIgmX/+Iu6tsApsJOrxkj690uJC7iYrKv06nFNw?=
 =?iso-8859-1?Q?4kHjT+EwrNZdl8EN1lrjVN12ZDhwXE6F6NOpQlwrVoTTpAjkORu6uB/IEm?=
 =?iso-8859-1?Q?bN7Dw+hrXoUK0+QfXYzmwQJrG1mIovTXYb8kWfQZRl5uRdsEfgbLLvENvu?=
 =?iso-8859-1?Q?VAmV+ydjhs1T8CLmDqv3W4sEm+AO8cnBY/EFsjNJnJlG2py93s6Tu1ZwxQ?=
 =?iso-8859-1?Q?7P4MiiziDfHMmkkKqxXrgNu8byxSNExQDM5pU5aYOpQGEK2kczwIis/8K5?=
 =?iso-8859-1?Q?94oLSb1jutJLxlqPqvx5DR3/iR87/UCoQUswRvhZgMyaFyAqsFxVHqmZYT?=
 =?iso-8859-1?Q?6+Mgt1b5g5S9N1/kosfEWdijQFUwHxLdmIFXGnrXrS7LNzAk6obtnzWXTh?=
 =?iso-8859-1?Q?cYyaT08z6qD8NJB9pn/bT3Xl6QGUAgsM2c09WXXULWi6wChpY6eit8TGB5?=
 =?iso-8859-1?Q?MqUnyC/onEBozMn7TV5Bn4gwCBYG8bRvR3bNTqyGIhbdrOPeFyOC1MZwB0?=
 =?iso-8859-1?Q?pvFTwawQ0oEf7aRTI5wz4GK12I87DVtUxB7LuBbIeT12JusyJXtGTt+4LB?=
 =?iso-8859-1?Q?Xj4q/6bMmMg/QI+nuFkjnFNxKlQJkrW0NAbRmgKYutsR5eB4uB4DsDvpB0?=
 =?iso-8859-1?Q?i1RyMG9lRurc+TFybqABhtTahlbuAgZV70G5+Of1iIsoyVYE53k0++w/93?=
 =?iso-8859-1?Q?nsZr6nAwMQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfa9c03-49e4-425d-0613-08de9f30a051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 23:00:32.9813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMqqHnWlJrCwvHhNom2ewnB0LQgUHTvOWVtKNzA0Wd+z8lh+X5U6catDviDAqKL7ON2UluOoXsBXqsUrQjqpzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1562
X-Spamd-Result: default: False [1.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279951-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-]
X-Rspamd-Queue-Id: 7F51F434C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops ctx rewriting guards the direct tcp_sock field loads with=0A=
is_locked_tcp_sock, but rtt_min still used a raw load sequence. On=0A=
request_sock-backed sock_ops callbacks, that can read past the end of a=0A=
tcp_request_sock allocation.=0A=
=0A=
This series switches rtt_min over to the shared guarded tcp_sock field=0A=
load helper and adds a tcpbpf runtime test that exercises the=0A=
same-register request_sock path.=0A=
=0A=
v4 -> v5:=0A=
- rebase onto current origin/master to address CI conflict=0A=
- no functional changes beyond the rebase=0A=
=0A=
Werner Kasselman (2):=0A=
  bpf: guard sock_ops rtt_min against non-locked tcp_sock=0A=
  selftests/bpf: cover same-reg sock_ops rtt_min request_sock access=0A=
=0A=
 net/core/filter.c                             | 36 +++++++++----------=0A=
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |  4 +++=0A=
 .../selftests/bpf/progs/test_tcpbpf_kern.c    | 14 ++++++++=0A=
 tools/testing/selftests/bpf/test_tcpbpf.h     |  2 ++=0A=
 4 files changed, 38 insertions(+), 18 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

