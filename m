Return-Path: <netdev+bounces-277736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMM2LmAM22l48ggAu9opvQ
	(envelope-from <netdev+bounces-277736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:07:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640A3E294F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E42301C884
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5D2FD69A;
	Sun, 12 Apr 2026 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="nn5IIyDn"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020139.outbound.protection.outlook.com [52.101.150.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C022F0C74;
	Sun, 12 Apr 2026 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775963000; cv=fail; b=qX0Yo6O0HRY/YsvF7RFKOOCMfUiFHm++elbno8V9tjbRwzw6qrz3uemH/E+o4aUVD0+WnAx7id5plKjPfbTNhwsGJHiEG2mX6SLjJrHaG00d9qRqPsYTARRqIW3rB4XWtBrwGpaQ3IbjyAaaEb0gpMTlzpLzcZ394paM2lg1pXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775963000; c=relaxed/simple;
	bh=Q+FWb6UC5/GobjEddZLnCx3OFoqJVraWXxOUiBcAQmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPtqHB9lfWGm5BeyWZoRLTBc/5tq9QKaF6sfGrMNLHWN/y7ATSj23F23ZGFc15RptcXXW2DD3JkTDtQZDMNMXZfBxhVlDihlx0K3mepBHJPCvKZGWj2ZOFdnJ9TvEyPMBligRI0jM0r1Tfj1oDvUuhDP+ZmPTLq2+uvkv4ilQF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=nn5IIyDn reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMCYLjkTHzz3ke3+X08eaGomhca+oT5l7ZNnrra9erhnnj5JDuuY1LAwtDfjL1MW3HCgZ2jBeUEss8lKSzEg5lJq6X0G5EPqUG2eskwksNuxNa2U+giMh385DegKlLuBYRQsquY8/Yd28MotePaKEHVQ3tntv7XH2ml9W1ibx4wF+uiNt2ydLVQyZsVnAygq2puzqaypuwZS9jiXvc8TnMyCc1VEpkiLlJ5exdmwSXCxGUzhGkoZ+nAHRqA2EKmjq4u77xEmYYPz/MOxH0YSkqO0MaTdYyvQl8E4i1n2E4k6oSZkNXxenOkz95iDVsNmvNiTSoU1et7HcHAfCYKECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClP1KiamlEhqHK9kogOYxtZqY49ve67IBE2FN6I1cX8=;
 b=FgHaIZdYXQrUiyyVv8UK7RSbKpkdS0/Z6I1WpLhhY9Xv/pTpyAjT8jbU8ltP/gw5y0EiXx2iwerjoiQ12sv+mEb9qFxhJd9T28xr/BKjXiJYn+bCMRtcdl/skQkXCEyYYUZC4dM8TEuvzAjYdC1pGUsv7VgzjL0aMW+pbi+uKQBrZc8RDWAt/UCjgGfy2oKZQwbIxAm620CP5tFKX0mO553eawVVVyk0uEyeEbEZn9PfXcxTo2ypq55zVccc4RccjcvMx2brOESmpXWY9/7iRoh8alAo3abryzr4F99AVn6T+LK0Jo01VKmbKgpKtZ6L6dJXYjoncugQEuHDrsdTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClP1KiamlEhqHK9kogOYxtZqY49ve67IBE2FN6I1cX8=;
 b=nn5IIyDnT5l27VjRiURGGLYtGWav3rKoCSsIhmnKS9sPFcRKcF4s5KgVWYKSUjWDAhwkJefHb/QsIVAtJH+smAllnE1eoTsgU+7ZzI+1NeBOCn1Xg1vzm3PZch8t6cUpxHj0SH6dmf/uz9aEYtnyk1Hx4yon7X11JpmOeMHJjeI0Lkl/DXFpwmBI6zf5yk0WWkbPeBPzCodKcEU2HhPuBdJKtz6sN5G/0CwIMWXT5VZWDHsl+f1IQKLCZ4VQw1zDjeqei2tLNzXTXPnL0M5H8HzgZ11fmmlqaZQdbKC5FpAiJoRvrqRwAKwW1MlyHU9WU+U+sQYAjJpxRzydSQyX2g==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0668.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Sun, 12 Apr
 2026 03:03:14 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 03:03:14 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Lawrence Brakmo
	<brakmo@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Werner
 Kasselman <werner@verivus.ai>
Subject: [PATCH v2 3/3] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Topic: [PATCH v2 3/3] bpf: guard sock_ops rtt_min against non-locked
 tcp_sock
Thread-Index: AQHcyijn8WB+tCGVOUqZuGYSLPl7Ww==
Date: Sun, 12 Apr 2026 03:03:14 +0000
Message-ID: <20260412030306.3469543-4-werner@verivus.com>
References: <20260412030306.3469543-1-werner@verivus.com>
In-Reply-To: <20260412030306.3469543-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0668:EE_
x-ms-office365-filtering-correlation-id: d1022f83-80cd-4570-c552-08de98400a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 V8KEuDbuWHINWGV9KAvdNdv4ncVua848ikou4/Xwp63qTbR3strp2t0H308jNBcxu3tk7I9SpW5UGNU9ghDmXIuplMFwZ0E/34g1ffzRoqnp56gv2jr3bw7/DSKpzVew+gYqITzmDOS8oZip/U8ygq5fbjAq+rbqS2CErcUftxvPwrB2QPF7uPEabCjXGCu5YLtIU/uslSzFHfHLPH5w2JQOLRbF0DKOO1Z6QxEbCbxTeCh6aoKi8wqEaSr5oQcrBS9uzQF4NYG2GB/RHp3k8hoMNH5/Og7Py+u9bNKNvkBi3ZlAuctu0oAmgRl0cukESlBu8xvPoQzXhcyoDZ+KOACSHJDa3jYDFLWto5HVOwhSqUI4yzsYqtwH/jCluOst6njxWh3KPRtUigS0n/rxY/buTvddgXqDEXtix3/Ym8/hnepiPB3RGoFcWp1vTdsKoy4oeRq8rzNx83EwSHMzgvQm9EWyDQlhHxMlI0y6noby00SA1649YZgTV60ew/VxW7r5lunsi4gRTZYWBhajH99xfZyCEssW5fUEy8xRJw+Tzvc4aLuv1DidaePOWgQOXhNoMKNKPhfcDZZo0s9qkaEDrzj0oe2dr5fvvXnSaJNfjuIkW3swVcQjXM0OlVFQpmuJ+SGs8mDcPqed/39ISEcyWbG6JEyHYIsDAWG+OOwHJa7IlJV23gsGPZDHjn1W93gEBZBQlqW8wiJ/cZqW6VZKgKbawpYMenH7TFxoUtb30SaUbfoMYmWh5pxfxajeih9+NT2TucyRAIxJZAGxR+UTWm1THMNj3pTUFebPUTs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BZHWBI9khLTURBlg9DTTWxM8Rc4YlPr+ig2r5fMdcUcjHpwEOHjX72l1r7?=
 =?iso-8859-1?Q?IFdIQWUgIze1fgYhKf0EjHc9UiD7vkpr//k59j2E/xHpLWmq93VvJ2Zeo9?=
 =?iso-8859-1?Q?aHPOjLSepso7ZyIOhHQJsDy30GzFvBrxyp+nLTS/HFA+OQ+a/3YblT5aMA?=
 =?iso-8859-1?Q?CIev3dzwKIcqq5eWFt1yAm8yCRB1H1mBYgcD+l54G9QdRbkVZ4kyFx/+SU?=
 =?iso-8859-1?Q?hYMIlSd7ZTy37gMnD33iXPyYPFiG/2XLcZZe+REMQQgTfVLcSf1kvYXBh3?=
 =?iso-8859-1?Q?KrFqn7Y7evk/PKpThliIuj6EgTl6faKyElox26z861JbAvjaLGJqpVqNeG?=
 =?iso-8859-1?Q?Vi9/Rodl50txqpcoFnsfC+qppHdbD9P+E9jY+q4DlequWjoU17Gcjx/qKT?=
 =?iso-8859-1?Q?sq4lHAvzA+HmAiB/A/Ju8qLq38r++0eg1ncelHRhyUmi6JBs0OPL548vkJ?=
 =?iso-8859-1?Q?ZVflb1VkHvchnDsjp7WX9a+fHzUGuZK8B7NLMjZfwiW2z9y8asa4A80uWC?=
 =?iso-8859-1?Q?vJLbTikPfcc+XgsWle94yCrLTyVUsurZ+uYYfl+pv8NSyhxc7T+Es8AgOm?=
 =?iso-8859-1?Q?JvjIy3cdYbqybA2gZbQv48oRAHY1hBnpbPNuzLbpPK0mwtStDePC665rAb?=
 =?iso-8859-1?Q?lgA8WTjT2lPjnQVf37jHiVFgI2EFo5PSgEPXoKd1Foj6SNiDnQCNwuwyuH?=
 =?iso-8859-1?Q?bApycwkR8UKadVr7qWTY8lHpf34N9Y5CYv3q029tHCGsDBbKXGYjQSvH/c?=
 =?iso-8859-1?Q?2arZ4NHbIGyhFQmpyfuF3k3+bMMDD4tDq3MQEqPoyBCmGhrcXS+Q0IFX0+?=
 =?iso-8859-1?Q?1RZ9Xr+lTnLAslQI95vcfXG1unwb8il2eRLM5DX4l+q4xXIq5GI8+Cy+WW?=
 =?iso-8859-1?Q?bwNkZvueA40bVJhdGhh6aERAU6kgquBQ4dLvf42jTK71Yr7yPYBh0/F1l6?=
 =?iso-8859-1?Q?OeXdolNsfTnjFEyKWBuIVyA2D/ACA7bIb+HwQFr03OuR3Zg8wrSimbWwkc?=
 =?iso-8859-1?Q?8Rpemsre1ocs8IoO5Np65nhcUFTK6TiHcQk8tfKVqRdjgxn+Bc+w7IgL2r?=
 =?iso-8859-1?Q?aj/OXnX/p4Rh8p8qA5xjrXHIH4qXqJ4t8eh2YtTX6NXSYyWhrA7dxsqMbB?=
 =?iso-8859-1?Q?B63UmyoZ11hm69gApyqvrTk2VoHv1YJI/juj8+mQSL+MqeVDj28GVZoca4?=
 =?iso-8859-1?Q?LS3Kf4iPm13WCzzTy3w8uGJOIR6loh9yaPikiWxNMZ5jjaKwSz2oG4pbSp?=
 =?iso-8859-1?Q?yoreE55rgpsx/uJbZ9GKavje4IAuEFhmqCnfVVZB+TJhuE7U0BJzlRvjvd?=
 =?iso-8859-1?Q?JL/jjNutLw48dxW5+8lhZX1H6KkksH6XWqOII4zH9kSUAQethFls2hqhC3?=
 =?iso-8859-1?Q?riwO8VwlGAZ6e14Nav9FMKnqbE6dURwWMw8Uvsp4QnsicTNcgFr73w1ZG2?=
 =?iso-8859-1?Q?juRTMJSzXyHPYUg5ePe7m73ZHCtWJt/VOndPM90vFVzLJm3zrDspkEyPV4?=
 =?iso-8859-1?Q?i7ZGj+OC0MRV9liM+p2st7ziQrmwaqPcFaI8DMC3pEdb4FSf/CBhzvSkXg?=
 =?iso-8859-1?Q?ya9/B++V+lvbG0RqKCDxO8B0uNIwhHsY9pueGwIdVIfslKk9Qvgjrd7rNO?=
 =?iso-8859-1?Q?4Z7R9dl+4C6u0nlLUvmOSajxgPyiI9oDt1a7TUFRnsvEycUdT+PK48UeLR?=
 =?iso-8859-1?Q?Dk4L3Wi23X0/XAM462KOG5ApzqhQ/jkWzSRI1jIFe5mgfASE5YglmUULrN?=
 =?iso-8859-1?Q?qEvR822F0uXsxAM4RGiRtKdUPzRboRrYSh8TunY5Mi3V3CLWK64fSsv8lr?=
 =?iso-8859-1?Q?EPSo0qGTWg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1022f83-80cd-4570-c552-08de98400a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 03:03:14.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOoXBkhwV7ZPHdY6wzzPHUeHefLya7vYFcY5l0DNgwJCUvZ09PZ8jwkTjKMDVSHMIiCkTdOAQJfJac7RPD7WZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0668
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277736-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,kernel.org,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:email,verivus.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3640A3E294F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sock_ops_convert_ctx_access() reads rtt_min without the=0A=
is_locked_tcp_sock guard used for every other tcp_sock field. On=0A=
request_sock-backed sock_ops callbacks, sk points at a=0A=
tcp_request_sock and the converted load reads past the end of the=0A=
allocation.=0A=
=0A=
Use SOCK_OPS_LOAD_TCP_SOCK_FIELD() so the load is guarded, and=0A=
compute the offset via offsetof(struct minmax_sample, v).=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 12 +++++-------=0A=
 1 file changed, 5 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 385fc3e9eb4a..88fa290caeaa 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10836,14 +10836,12 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 			     sizeof(struct minmax));=0A=
 		BUILD_BUG_ON(sizeof(struct minmax) <=0A=
 			     sizeof(struct minmax_sample));=0A=
+		BUILD_BUG_ON(offsetof(struct tcp_sock, rtt_min) +=0A=
+			     offsetof(struct minmax_sample, v) > S16_MAX);=0A=
 =0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(=0A=
-						struct bpf_sock_ops_kern, sk),=0A=
-				      si->dst_reg, si->src_reg,=0A=
-				      offsetof(struct bpf_sock_ops_kern, sk));=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,=0A=
-				      offsetof(struct tcp_sock, rtt_min) +=0A=
-				      sizeof_field(struct minmax_sample, t));=0A=
+		off =3D offsetof(struct tcp_sock, rtt_min) +=0A=
+		      offsetof(struct minmax_sample, v);=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_W, off);=0A=
 		break;=0A=
 =0A=
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):=0A=
-- =0A=
2.43.0=0A=
=0A=

