Return-Path: <netdev+bounces-277733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5stnD3gL22l48ggAu9opvQ
	(envelope-from <netdev+bounces-277733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821B3E2904
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4E93018BCF
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6120E334;
	Sun, 12 Apr 2026 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="Ii11+k7S"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020139.outbound.protection.outlook.com [52.101.150.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B681514F8;
	Sun, 12 Apr 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962995; cv=fail; b=SjGXn/4ARyq8iZ0A23cDMTlLWwasn+JiQIE8TcaKnnY88Cy9dwAtDB3XgK71PnJDB62/CSodOxjqJ1+ugAfnVY9MscUNKgce22flHACROCEGUVqvfecAhPWmUurUjQZmp5NsfBQry6Q+1FGESsVWjJK0Fk+ZcdR3ezY/C+SpKCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962995; c=relaxed/simple;
	bh=+JUEO+CglAc7awEi+XPm8s1gBRGT0rj4HS4nQ3RW68o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RKhXQL1+MbWbUFsoz27V6Ou278eusYKFfAzDy2uDb/x/u5WT0WBUYRzOWJJzWA6u2qp9/GzvQepv4y5ueKh2XBnG07vtH55Gq5bLnsiH2r27mxkVxehGkTUAP/JvKfd1f5hjgYiWnvCftn39k2D9wUSkxSP0sMndWyxJB4RDwQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=Ii11+k7S reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPTYwGcI6FARcz9a7hXdmnLf2UxxdaF6B9yjB0kk63IOd8aTVigSGmTOnO5qE4nYb2jaEtfXtnHQcImWmEdgWYE90tLQFfJbd2quyG/XCzZksMFjPwug5H9/qcRODdIT8sLlNlepPGFktALCXiLZkEaToMZyENxBp812cE9WQkVB7/u4yx30p6BqifIQrfQg1OOiJ7q6JbZsolppTioOhzvU1zdU2shwkaI4CJgEgQJhVsZl39KrUfS64auBzhn+G4qOLT/ZFNTXsr1YbDTio8Ix03H/Z1xai0Chezm6wUKbhlBU6f76id4f9f4qXsgvJAGWQMXc/hAP0Evy5QY1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1pWrtJZe8So+nuHkBZRyULFtwV2rp9ou9iflkAs1k4=;
 b=ifsUo73Dn0/yVkyhHSrlHDS17xKxfBGLC/0/bx3MY6wNAIaHpDdR26e37V5czPETgWC/+RcW6xK/1TYuF/sjP0EJaTkd11HKFaRHzNFPAGfaTQMI8TeH88e53eLV3kmRmKxa87Rowkvxt1VkHoqsB7hTIR+TjGDvbVDkV3Zj2BDm/KoI/lll+8GawNLKjaAKNv+2ZLpWz3AZlBI+6meqxu3N1lqcskXCLo1qAR2hzFWPBfZgdcdN9jeWjw92ZQVRXJNyPp3qnDFx9B9CC7R+qAYHpw/bRbnYzohqKh+fIPe8071D/od9/DroVgzVPKt8F5SXIgMDXWrmlDZPPHR2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1pWrtJZe8So+nuHkBZRyULFtwV2rp9ou9iflkAs1k4=;
 b=Ii11+k7Svb2UA+d6Gpb4q7A3ALEgbATOQ9YzT6Jhimr9HP3Da2CqX90mioUxK7qH0HvAKth1OFbUaYzrLWIGup9tdU7ZzVF9NkU5CGqn300CWviQN0PY5WDJXsQyCNvY2kUoxbSxbDwXaTFS5l9EbhptStuvzpQTxjyQej/GzvGXIc5vOsdjz7qysWxyi6sBYiOmFczsBGLF93i0qzbZZyAl67+ZzRVKKYMHJ5kEs6V5P1nZulrL/bgCvUtjTe+FbL7W3V2hwLbeDUKryPZtEnARCWgadQ7frhVbSiXn8qpDzwZASSdddb/5/OqynHJnrZDBRxeD6uBndpyZHwtrnQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0668.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Sun, 12 Apr
 2026 03:03:09 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 03:03:09 +0000
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
Subject: [PATCH v2 0/3] bpf: fix sock_ops rtt_min OOB read and related guard
 issues
Thread-Topic: [PATCH v2 0/3] bpf: fix sock_ops rtt_min OOB read and related
 guard issues
Thread-Index: AQHcyijkRApyD4bo20WHRGN/J6qm7w==
Date: Sun, 12 Apr 2026 03:03:08 +0000
Message-ID: <20260412030306.3469543-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0668:EE_
x-ms-office365-filtering-correlation-id: ba00d37e-ff59-4dae-ebf9-08de9840069f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 QLk40FtSQJYzl7PbZRRwFrshvzLJbonjLcmscnbfiYn5dI+nPVTaf+pFJ4D1gmg+Jj1YRs6u0tUNnDmp+/AxJyHJXbBeaxD6i8iQhE4HeIxQzbklr/brFXD9XN4Z3zep4YWmWFxTC8lY+MiL/Mo+VcICpOBtHklsLHvC9Hikxoynfl/pJ6vmjBFAygldNULo0PPWSXQUo6FNVLhwzCaQTFzp5R7UpG2/fEQdA/LbDepP62Zq6+54EyOxTT7NCo3navw4u0mymkd6Fr8uiDGzzzeFA1nHBlIuFIX8oAE5Jo1qMHMDYEpq9cesahqe2oIAJDKZ82KrQr9q99k9crTOVNH55LwNr3/U1heVTuPrmzk4y7FLqqGA2SIwSSkUTStDgt6Q6db8YwZNPAXWwXdO5UnKdWdBELrP48jqBxc+ePAm0jZIGp7YiQDoCcoH06PGAZ66lyKCrR9dEwRcrVA6xkw4qLAhKoYo9avigRYpVCawOq+yO06bwcco37yRysw9hW4sHFbsWwNehcrAyXku3vshgPTr5ebbqxzrOPbShapRTI0HI2QUOLS2S8pTe9ndErppPWii7rVcePKVOaQuuK6yRcQYL2GvrIN3ac9A9Sc9e9uE81i0jC6mjRlVmXpkNkBfbR3ugPUHgllvwJyiRzX5LJWg10lOw1f9Jo6JB/8SFe+d7xtmFXFoArtaePcncB/ikwgnr5qI3SNUBkB4ZE6T97aO2Us4ph/d2sBAa0fHvdqmUooOJuDp8YZ1Lfym3MH2RdAKKhDGVDqM2t/4eyKDZ/qSeAhxsERm5V4x7vQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O7ICUKQkjjTudSs4j59ACAWi/LHkdYdBvucFb3Fl+/Kl7vkd1dpG0n578Q?=
 =?iso-8859-1?Q?S/W2NTyuG2oJ5Asj1C/ryJM5Akt4s5d2MxXN6J4b5UmAYO53KeOZ+jp7aj?=
 =?iso-8859-1?Q?xjPHXjyIy6xH7uLPnc803K014LrjnStdUyu1Q8BdfVY8yvHhAlyFwXdCV5?=
 =?iso-8859-1?Q?yfRDe+56Ea4v51mJdAeZioGsi9pfa017Zrkln1rRRDVTlJSA1ub18iNnVj?=
 =?iso-8859-1?Q?MtZQ7mdBPbQ5dCdBYRT37TQI2fX9X3RE30FJuPx0bMJmHyxhK9IErX0Z0s?=
 =?iso-8859-1?Q?16b7qd5Hufe3z1m3eenmIJe60eEhgk+PG/iMpbW5siZeJSCXRsFfpCfEYL?=
 =?iso-8859-1?Q?0+v+XlWuIcTy/MVMSvjxhtuaQNTscCPRZeP+ywbUnFXlZ3wcY3kjxkG9SB?=
 =?iso-8859-1?Q?1U1mHEfi/IEaapzVPle/3kpmylJj3O1v0Gltufd2WervkGjtKilDFKWFJT?=
 =?iso-8859-1?Q?y7EdgkIuKjR8c7OEvNNTX9+kyntvKWJsgFjRcOi3GE6BhuoXbkbfMkx5PR?=
 =?iso-8859-1?Q?0jSBh+AorIkb5LadKLty4KaRJT9+ZcJU4n+4qL/RZ+i0WIcCewbRiW7x3z?=
 =?iso-8859-1?Q?T6G817Q1EK/CyNTECQoAi19tJ9WdoCb+AEPlC+Dfyd8bvfvT7sAjv9xGmo?=
 =?iso-8859-1?Q?4JZyb4F7ffy3OQXn0zUJIYOZmk38uvgWmZyvqmfIoiYqKfWqBcHSAI16Oy?=
 =?iso-8859-1?Q?V7QZNMzM8f6InVJY7XvNkdTWb0wc69T5fwIRkNiulKoyVMo9a05r4kL1Yo?=
 =?iso-8859-1?Q?TQ9n4VwcatQCVK2gnQRfF7dJFv/q4im0iDoXFNxZC/af+pOtW8eZqEF3Zy?=
 =?iso-8859-1?Q?o7i4kAtPOI7YOEKuZ+FW+deMAI8UyakYAEurTHSbpHZLsvr7N8KGG1y5bm?=
 =?iso-8859-1?Q?az4AuTo9l6z8S5Dx0MgnUVptQiPYwteUDaRqlBHFjNQ17W+lBA+Z/1mgzP?=
 =?iso-8859-1?Q?1GMrLKzO2zA5C7OrnMwP+xFFoxGGo0+SEkAYjGmEuw+45mKxDxBkkMPFNp?=
 =?iso-8859-1?Q?BDePANIAyhKUIcFLPLuaPkOJnw6hB/CmRTuE1rmjjynlKq8l31MLo40pyn?=
 =?iso-8859-1?Q?IlwtUlOtkGWlJpAofTJMDswMsp6m2K2laIalbTIClBVXkhYsBTQBglqEx/?=
 =?iso-8859-1?Q?C6eFB5nSnHlDrbDKTbLmr9s7m2XNDusfLq9Oj3ebI6z+RJEDtcTHwaX20T?=
 =?iso-8859-1?Q?/yViQKgLeV9QWkL9uchc7ih5HJNQBw3HljwKnjW5aTHXcuGPV9/6OkuUxI?=
 =?iso-8859-1?Q?Ctrcf4WXmQg3tKh1u+5zZjsTZJMkuckxHADSlnMru+42YJfv3EYZYhVV6Z?=
 =?iso-8859-1?Q?zyxWZBRl96Rw72pJUCs9CGowOEXLrDljZD/nxzuybsdJLA1kjhcTav4hhm?=
 =?iso-8859-1?Q?SFI6xE0642S0V1wIU63mXZFpnZJOQbD9OqjxCtHfl/r+IyUWawffuTvEGo?=
 =?iso-8859-1?Q?j26A29rRC+ik9/jqITIqrznvBvJNeYWZtbc2ejYrnToA36PcYEC3AJ60jY?=
 =?iso-8859-1?Q?9BtF192VoPG0KGk390ek4o9cWStNAUKLd+bDAihBOiIBMbbi6zjub+K4/y?=
 =?iso-8859-1?Q?zrApPk8h0gKFh9S5Kav1ud0F3OokRuNI2CDZQm1QIq0XaaIOwwALDWyCNU?=
 =?iso-8859-1?Q?VOBHLo9Vo1hdxN1HO4+utKpDlGivW0tqKgO9Z72zZ2aNrghrKwTxRyswwZ?=
 =?iso-8859-1?Q?aibydWEHg/97nlsJ4iehE7Ow6bM+Us4nNYfRPqNBZRiikwqVXPA9C9+bvo?=
 =?iso-8859-1?Q?gxCU0HoGIyczh+Bcw49K3A25dUURseJUJTN98TX+T3q7vxwoKVdyvgMWzM?=
 =?iso-8859-1?Q?CO9xDEgiqQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00d37e-ff59-4dae-ebf9-08de9840069f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 03:03:08.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHxLXYYjo6QBau7FVHYHSKP2/ajvsPSYHBCFdLvqZ7uGHnnSh6gWr50VQkvhyGHuIy8GdHUh2UVPpAWnqsITpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0668
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277733-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,kernel.org,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8821B3E2904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 3 fixes an out-of-bounds read in sock_ops_convert_ctx_access()=0A=
for the rtt_min context field. It is the only tcp_sock-backed field=0A=
that bypasses the is_locked_tcp_sock guard, so on request_sock-backed=0A=
sock_ops callbacks the converted BPF load reads past the end of a=0A=
tcp_request_sock.=0A=
=0A=
Patches 1 and 2 are groundwork. Patch 1 fixes a pre-existing info=0A=
leak in SOCK_OPS_GET_FIELD() and SOCK_OPS_GET_SK() where dst_reg is=0A=
left holding the context pointer on the guard-failure branch when=0A=
dst_reg =3D=3D src_reg, instead of being zeroed. Patch 2 extracts=0A=
SOCK_OPS_LOAD_TCP_SOCK_FIELD() from SOCK_OPS_GET_FIELD() so the=0A=
rtt_min sub-field access in patch 3 can reuse it.=0A=
=0A=
Patches 1 and 3 carry Fixes: tags and Cc: stable. Patch 2 is a pure=0A=
refactor.=0A=
=0A=
v1: https://lore.kernel.org/bpf/ (earlier single-patch posting)=0A=
  - Inlined the guarded load sequence by hand.=0A=
  - Feedback: please factor it through the existing helper instead=0A=
    of open-coding 30 lines.=0A=
=0A=
v2:=0A=
  - Patch 1 (new): fix latent dst =3D=3D src info leak in both macros.=0A=
  - Patch 2 (new): refactor SOCK_OPS_GET_FIELD().=0A=
  - Patch 3: use SOCK_OPS_LOAD_TCP_SOCK_FIELD() for rtt_min and use=0A=
    offsetof(struct minmax_sample, v) for the sub-field offset.=0A=
=0A=
Werner Kasselman (3):=0A=
  bpf: zero dst_reg on sock_ops field guard failure when dst =3D=3D src=0A=
  bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from SOCK_OPS_GET_FIELD=0A=
  bpf: guard sock_ops rtt_min against non-locked tcp_sock=0A=
=0A=
 net/core/filter.c | 37 +++++++++++++++++++++----------------=0A=
 1 file changed, 21 insertions(+), 16 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=
=0A=

