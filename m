Return-Path: <netdev+bounces-279952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEKfCHCw5mknzwEAu9opvQ
	(envelope-from <netdev+bounces-279952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:02:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD071434C67
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29FDD301E6EA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248E39B963;
	Mon, 20 Apr 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="pD0rlm/d"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020128.outbound.protection.outlook.com [52.101.152.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12939A80E;
	Mon, 20 Apr 2026 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726050; cv=fail; b=rEOIoudj1sDTd9jp3oX1RAjpo8kVBLdpLTSn3Llec5Z8e4iq39FQ6+D0QvxqCSScIJQ0VhIQzODOFXwKBjg/MDbWugLFJdK6OefKVTa/B7Niibppb0BOJu9pPkMweWGvVSjVyU3jDBPZNhOVUCZZCQDozWbHKTogCZD3YlD9Y9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726050; c=relaxed/simple;
	bh=XVuVU543P0Zh7NjGzr3w/2HvQ8iOhA0C3SDjJfi8PwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=phHS2mUB7GZaZWgzS51MVUMBzVxUhvusB++iXur0RJHFkisddmOiwFyviE2PmWJsgcIvWjIHCBPbgba9PzCwJj5jbWjgdh2U0pHVFKrga510P7DpeKvoFqPV+CIXWaqT+TsbDmH8jOWm6WvbVS32XRCiVUxEkVfgfN8sHFsBDEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=pD0rlm/d reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvbzzD893Bw8xV18G2boiPo+8roQ6dGAaVnOyvja9mqDtae/TsVLJG5zOFWM1c73XopF90VcZLecSsi6lOCt/JRFWjhRKiBvzwiNb5JZu5bwVKMwJQ0AMBa9OVcOJvFBqRG+mUV0WUfmZG1TVSnYXTkS2S3wm/qc17zpvxIdHuYdhvxfK3tbadvc7yzRQWfC4DQ3Am27nk2s66W56/rBek6iV9vrqPWvrixMm93TwcaC2jrVckrWfoCqcS5kadDOVG7IBEwKrg8C7RW4bxnXQodS4DB0z9DQRUN4kg7ccttY22acpst3Sdd7gZkFRiZtHzjDt4wzf8qNuK9J7oDfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG9ESFaW1RQ/C/UCoUMjtA/OpC+HhJ/o0OeOxTSMvC8=;
 b=d3huxwfei9O7XL2mbkdexezitsRqY1FsA1WUkp+5m1AUwSGFMb2A8eYVzCIV0RsGWs15SADIHgPBETKDas9yUVZwnTs9LttNBRF+RmYSANwxAoJxJfyQxko8y+Xnc3JrJyvWkcFZ3sCyS4r0DBIteXidMahQ5Ea2TlpMX/3bBTiDtPOnboItNbpAyOWQ30WmkdPPi/cZEvKFwn0UX1uBuLV+hapUDTJdZHlecFgBJdZlBlMRtm5CcmotYucI1yEGjEc02KB52hOMIkfYw3LBWylQueEcD2WzjWb+RbAH9Itc6rft1bxSNkms/7zoaFI64rZRS5vTbR938meFfykSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG9ESFaW1RQ/C/UCoUMjtA/OpC+HhJ/o0OeOxTSMvC8=;
 b=pD0rlm/du/bF/e5H+BUJkF6FKwQIvvAjm36afb1pktgboExyosHhHWJAzMkEr8YZeqIcSO4QjOXaybcgDWOCdZDrH3AcKBh/ZksAI5crc2Yo4bs1UtkoHCL8bUShSWLoUD/ZtatmHRg20nN3N433LWPfYYhsUdc93MLBG/X2gpDF7wZiCFqQvX2zl7Nn/LGEAiTbRFGJhejrq7yzQSeTL1Axfse01Yo8LBvq3fnef7m/RPaMfd/xQlgrLtjQ3uPNsOKGPof/T7UfVcykXn3mnRpp4omlOZ3VkecUdVfIlU4P5L8HVEP8ZLJlzzi5/94FHcBdaXnrRljoFlKVgB/fZg==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1562.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 23:00:37 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.016; Mon, 20 Apr 2026
 23:00:37 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
	<linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf v5 2/2] selftests/bpf: cover same-reg sock_ops rtt_min
 request_sock access
Thread-Topic: [PATCH bpf v5 2/2] selftests/bpf: cover same-reg sock_ops
 rtt_min request_sock access
Thread-Index: AQHc0RmATRnePAU2PUuG0Z1eSOHRag==
Date: Mon, 20 Apr 2026 23:00:37 +0000
Message-ID: <20260420230030.2802408-3-werner@verivus.com>
References: <20260417023119.3830723-1-werner@verivus.com>
 <20260420230030.2802408-1-werner@verivus.com>
In-Reply-To: <20260420230030.2802408-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1562:EE_
x-ms-office365-filtering-correlation-id: f04e0da8-4c8f-4db5-6214-08de9f30a310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Z6kIQa4cxPucjYgGLzxj1iofIGHfUg2PZjDvcDG1f3u6bbjykUSZDq0lFmp3hcXzLF/rKVBBLafv9wl0NTSwiD8ojknn9nPksG++TkidIg6TCViqYR0xWB0vniglPn5nerDC2IbLTEf2nzMMAS4pySyuL59j57Ypdx30/pdKVnEcIfeL3k4SkogzOEqtRPYQVzNuBf/5rgPxthAzJN56Byrp8TpUgpWjmHko8jTggelBNaFgQYaK76U43Dq3v5DOxE1UB7mEMLpWVShVHbcWPZmGV2mmj3i5vaMI63qPBjatu10n3Xr/4NDcXwCDyHqVlhNL/DaHaSZ4SAYvybjupZAfgwkxvVRaya24ujfUNCKmiUWzvoMZMT3XLrWwEYm5ieFPWTB50YdSRAK/6TJjGogjMPClv/pqA9WS5hg/pc7gTUdrJQMkGqOxWzkFhV9iDYm7cVUNUDFLGopJ7QnTbHIFsF7yLkUU7DrkCrfI3XqCHHVNGtbYg7kMBROGkWBWl3e5a+SVbJ8E0d8k8MXumV42qChz9UCOc/GamBTIdditftF7TE1wJFn7wl9RFQ6QHZe5HYxjhe50dk8GiN1YyfFTa2kP9Y0oYOoBvFt/sUSBBPlV/VMkTraHRSSvuXgqicxjPM5ErC2STbh60n9hzzk7GFSBlLTryhaY6dXAB8AAw7gsqtPBJD2mC5V05FH1Vf/ZnwDoAKK8IRXgS4eVqJL1ghWGTHSrgAt+uAm9eN7Y2CH2Ahu095P/001pIs0vvnMJR00/DXatrJ5Jgd8fEaay+qxjdKR0PEgUdwan1BU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lOxe9lu8GprAsfpdG032u+VxbftY1ThyZBzQXLTfOtsL9iwpD7UxScCLXE?=
 =?iso-8859-1?Q?icNZCe/UvskiYdaidZqhUxefERbO143YcHvEATcJQZBhQ41LrN8nlrw9ye?=
 =?iso-8859-1?Q?jgS949XeV5VrjN241AWCXtC+nP18GMRoNP74fCaXI4CVKRXRtMiWfwn5KQ?=
 =?iso-8859-1?Q?B0Bw3eVOc9BlX6cYnrsTvV8DRe1EtXLpPxiGkZvD0g7vmT4zL5m0hKcoVF?=
 =?iso-8859-1?Q?vTn/AXdemVx7/y/CLOM4HkTSQHOYyMiFkuRq7ASVjIqduhZ4IwaAi3Dy8a?=
 =?iso-8859-1?Q?/cdyzL0FmR41OpF8fEWPWXlJizkYKTlstAOr5K9QU+c8yEX9ylvtdbcvxW?=
 =?iso-8859-1?Q?YwHSNAIt0yc2CoJwaIz5uHXEmHxIiOumwKkWE3SFHXCoaszUWoXozd1Yxb?=
 =?iso-8859-1?Q?eD6XZaY7bKj2E+eLLb/GVTAgBhaiMfp502Typ0lq2wxuuqgqfs4D8dcMZO?=
 =?iso-8859-1?Q?fE2cwB7q0dTGi7yuEXTVHKqQ8HKRJyhLVE9pwWu91lGr6zjVjtE10l912M?=
 =?iso-8859-1?Q?wPOC+uw9hR5neU+Zm5Xce7n8FiwJ9/UQZi4c2ro2XqxDO33ZDMh7v+zG58?=
 =?iso-8859-1?Q?5XQbOMpNWuzwhoaEYGk6CzVV929zHlRw5MuH1/qr8zdW3RDfPTx9xLlNuQ?=
 =?iso-8859-1?Q?bfwqtWeBXh9oOqDiyB7zDfksVEFsJPRbzkkkK3/vIOVRK67YOsijewaP+v?=
 =?iso-8859-1?Q?qJssa5qteuAIzkWDK3f+8raqaHQKAQroKVNNBUNwL1f/EWeZfYFAvEvP4S?=
 =?iso-8859-1?Q?BpqhwLWEXgqskXNkLIKSZeWJFfydZJLAeXg55YBN1iy07GoOzKUXFwHwBD?=
 =?iso-8859-1?Q?OIzFVAOkKd0FvbFzbNP/xmOmMVh0MvleLTdc9Apd+RmpSs9ypkpT/Xl6+C?=
 =?iso-8859-1?Q?eG4zW6QcKZGslA0iwQnNR4iygOs9GwfrJoxseTX64ZVOgN/rRaKUlMrV2i?=
 =?iso-8859-1?Q?Hm15Tv5MZyk7Pn26Vu0r/Car9N9H+3r+OXgGTM+6GRO0XNEEK7Yd/Yw/vU?=
 =?iso-8859-1?Q?TZtxgVATeZQgx9iHzwa5zwtlHeJ3OGY6vOISnk+D5B6hytLLcG0IoNjr/V?=
 =?iso-8859-1?Q?iSdWvm65Hhhpg5VKwLfqfmzeFM9ASpGVn5sLvTH4jAfyG0NM8L+2agt5Ze?=
 =?iso-8859-1?Q?2sbib0sNo5FZ+gl7ypdMxAxlRmobYVsU+p7knrd4Khs9nIKejIzz1TwTXg?=
 =?iso-8859-1?Q?mZfjkbOjlltcVUP7txq3ZZUdYqUQ8+loJ/F38xx2G7F204IFS3cxNEO6Vf?=
 =?iso-8859-1?Q?YKZVcJg/pzYKF5AmFMHy3bIUXQjXpjJO0Y196klcX5Dye+2iLtWKPqpxsX?=
 =?iso-8859-1?Q?9AT+TD/aHqgCA/m+MRw+JYZJvOkHHlo7hSXGzkvr953IgYBK7A+ogUetTB?=
 =?iso-8859-1?Q?JaaUkRvMHG7T2ORfvAUD8JWyE0o879IRFxR1bTo6YHdpwUj5mQrt820VLx?=
 =?iso-8859-1?Q?DsPSm6HSOqOifHpxdbA0/xUVd4Snmju8zV55fy+sIyjQGAXzHikmi5Dp9l?=
 =?iso-8859-1?Q?gURUyIsNS1lww9FRavtxrhaiHXOUC7uZFIpVH4A5SSuUH538VKCEi0zqm9?=
 =?iso-8859-1?Q?DptJhck5EpoFqLpT7ba/h8iHRsZVDo+3lz1Gf8socwPxPL7q2XExRo63C9?=
 =?iso-8859-1?Q?We2s9S/Vco4UN4/UlkoKcOFELWbQ5uR5OT5ykC22IvW8QN8WRLD+9+M7z0?=
 =?iso-8859-1?Q?dysXD1xlSjdYg+rGpeu1rDBfGJaTX8GWnJaWk91JmCSWy5iHfZVrOyl/Y1?=
 =?iso-8859-1?Q?jCBA3CtYYgorvQzuEboH6IwC0oIvm4dzYBzf8iPZT8e5PmMe+rqu90/ZS7?=
 =?iso-8859-1?Q?nB8kHUT3gw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f04e0da8-4c8f-4db5-6214-08de9f30a310
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 23:00:37.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Rp7ASAWRJ4/reRWMWIQ+bcLU2FULMNKGVb5cdTWhaXOTZwMxvvznZ1DDwHeESSdeV+GfTw7nL1n3hyJGL3MTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1562
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BD071434C67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a tcpbpf sock_ops selftest that forces a same-register ctx->rtt_min rea=
d on request_sock-backed callbacks and verifies the observed value is zero.=
=0A=
=0A=
This covers the dst_reg =3D=3D src_reg path that the previous ctx_rewrite-o=
nly test did not exercise.=0A=
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
=0A=

