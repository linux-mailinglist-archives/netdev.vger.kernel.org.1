Return-Path: <netdev+bounces-279207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPVZAo6b4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:31:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC34163BC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39B5306BC68
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DC2E7F3E;
	Fri, 17 Apr 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="KVfRw3Q2"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020131.outbound.protection.outlook.com [52.101.150.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23616F507;
	Fri, 17 Apr 2026 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393088; cv=fail; b=HAMdXexs7cSimD9mcEqdk624l/4OEFG6tcRPBizjGfA3pY5x/jA5PTA4QAmnhiEqhmVq5WG4jrWZYJ+lXyT0LTwX6UVJmS6915BodYXdeiieWZrYG+CehT9U2IN+oPiidtsxF74A1ZDvmpxdBul8KimniFKF1mS+Rx9R6ov1GPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393088; c=relaxed/simple;
	bh=ku4E5HaAH/VCnnSQInqMULlNO6ePE8D6MByTKTHHnoU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H7b4uzY2KZJVu98OE+bU/GLk70ZYIRq6K7JeRPs+tejk6RkjqRah9uaujwbqBaQccXkzlWm9cAaw43Z+GGMVoTtt/dejfofdaCVbesIC2jsGKTywsxDBrblV+1YYbpN/ZQNpDDLmbvxHGf4ajMUjwLvPfTschaoXruAuBf299Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=KVfRw3Q2 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyG0ooto3IUv2jnJydDrVgich8jFx3xrfqw8BAt7iFAs4S++SD5eHBZ+o1nezvhn4sRFsByUdJAjKEucZNK1LLMoCl0W3xjZYgKi80uQCKXStHa34u3BEVKDsScaJ2fHR8IlmxeXVjixRnXSAPYO6ekMQv3Ov27MTGITDVtOZx69SPVHSHLzbkcw45kttw/z6l/ZZG4z8ViuhOnTsURbLGbeTodhs7StGkRE+YVt8EHqnJEjz2d+8aC0R/bSFmOullMn2Y2lRnWkfbfA3SXI2i//aKNXT5Esak2YmyNp8wGtrNkY40E4Os5f5zXLxw50KDKJUsykJmuT9M6SrXqkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi3IFtp9rWRjK2n/dUGAnebdROs9x5JKLEnQv2GHMSE=;
 b=AtlI7OyxI2XEPv0aQg8buKnjXiRQT+MPXomLFMF0dx9ldO7+7ThhZqIOlIdZ3XuYY+1GSOW42Pb8S83E/A5EhGesn3pR6h1A+tsPTHADi21Nl5jTFOhP3xtpgtpRrg32PvNo07aKDAAWxAyiwaqMlO8Oei8kO5bVwoyzVylKnsUcYPAuLdm6A83XJHHCT69/muzPVgGBux9Ql4PDlTgZRwDBjNRjUx14gKVTooXA6Kq3Zm9rPML/IZ12+YON5zSCQ6CDNHHsR2xvEKHkxkpdBYh2e2dHaZhlYtKHhG+YIc1PdrPVoNwHlLBR0E8rIyacFdi6eq7v8isl4etQ4DiGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi3IFtp9rWRjK2n/dUGAnebdROs9x5JKLEnQv2GHMSE=;
 b=KVfRw3Q2iRLuMSKXA3W+a9fPPvcrrlARcDrfDb3NbYszJYkDBRENGyG5M5l9ksykEQ7xFiZn6l+VspJn2npJQeWPiwXlfk/12+ggMvK1pvq0fXHmRZqvMXE7P2PswdTsHIJLqwhvta/mHMdfJMmKN4vmhlXzI0ZJEhAKRzMrq3OcLioD9n9Y77RlidSotF91uFySPIaVHfve0oYy4dY17+yKnkMygzJNPtxdhPh6MXOF7UGlUhgvAnXqKLw2hN1lyLSpUBBMDxdmSb5Jz1J93PBlgzDmgTjmgpfpiVjYjBq/3O9eAviDmPdKDTDcGobhL1rIfkTplS30v+2sTxrvaA==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0725.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:31:22 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:31:22 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "brakmo@fb.com" <brakmo@fb.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "haoluo@google.com" <haoluo@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "jiayuan.chen@linux.dev" <jiayuan.chen@linux.dev>,
	Werner Kasselman <werner@verivus.ai>
Subject: [PATCH bpf v3 0/2] bpf: fix sock_ops rtt_min OOB read
Thread-Topic: [PATCH bpf v3 0/2] bpf: fix sock_ops rtt_min OOB read
Thread-Index: AQHczhJHMpvCoLMi60mpNggfwtXllQ==
Date: Fri, 17 Apr 2026 02:31:21 +0000
Message-ID: <20260417023119.3830723-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0725:EE_
x-ms-office365-filtering-correlation-id: 079a7fde-07aa-45b1-744d-08de9c296a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 VFa2DEIJW2r/vbo/sazFeCX1S1XTBHtQoToY05GSM8gFmGyDJrPJ6BsIthK+dlI69XStQ7o+pQV/0XM/MwpGdj0PTKy523zuUwhXEUOWyiu2VjrvjaouQFoDpbga3NAEgJy5FEs1H4CW9XgzGRb3PG/F5CyKxvTffJUp8gr9dGFtLQaKqEGppK/agkw9g/PXijEQTP6uHzPftrvGBkThb/tzWoBNEsvxCVdND1dxspF4VvlKS9pKb86sRXHCFMMWkdplJpOg5IOp+c3j35JF8zzsASIlSXhSoa9TP8cjNGB9CuBWjKjK2wp/df2AFJEkd3WbRDzlQG89Zye8a7fJtbtIw/kKaVJ6VYJmFcqEhJXIpOSZZiDOiRcoy2FLTTR/NtIzn43J2rjvWiD4ObCbfy6iOp8TmeVTo8Eex17DVxdcPZMGimCuxEIHiqhs+5WGMv8TUr1cNkFZ3KsuitMk67NpdykqimSNWLG0aZxduz3EU+AKvKek9pgafxnrex/0M8U4qqd1DYSnNffEuo0iqHt3iaWXcKVP+RpphP4En/9eXxoVvnOvva+QE7CHSNoaPFCa4bBm4nZ2/StB0kZneGprJldL9N8CnA1bgFKNTqxKzNSTT+NYqL9auyWnycCxBZiOPY2LzKueKiP7/eHa+22yOIH0eGMTtJ8UaMlYtMJyaz812JQt9hWRQnUI5uek6toYNLA6jS8p1Q2CAsU9JSlomlAE0uFKLC7Z48xGsg2W2GJYQbxkB8xLs53GYqAzisJfMM7x334myLoFDX0nLi/zMZ2jcAp3JglUwo4LUcU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lbk9MXpCWSvWLeVsDJ3y7l3lJSlY3LXhUwPnPdNxrlQ78OeCZJFkmcU8u/?=
 =?iso-8859-1?Q?wmPXkbg0ig61cP8OLXdILrIXt4oFHMaISg/JzGZI08NExciE9VCwkIn2/g?=
 =?iso-8859-1?Q?LxH+/fFdW1ewbP0VJzTDlLaiS0XQlfKaT10LgVDF9LQVJ5MxOg+1XZklRM?=
 =?iso-8859-1?Q?ZBPrOXUEKFWjL3ej+TKF3cd4FkM32JSdFOxujoWlEoWUzBqgIKCOYaQzlj?=
 =?iso-8859-1?Q?+ZvtZtdUjEotA+rnzmHptjgl5iwRdRmxpJ36gLYoOlNoED5RkB/3f1kRLP?=
 =?iso-8859-1?Q?+lAC9tV8UuXhfrMf0l3K7utJUYwtSWz9UYlRhhdjhCR8mMIMZJrR2VlgV7?=
 =?iso-8859-1?Q?F5qWINrVJP/U+RjV5m1SXl71CqTWADx9hrQLROtra/DqOV14rEHhuq4bu3?=
 =?iso-8859-1?Q?HCilLqmRgO7G/PA3rBxPx+QVixSh7ZWW6JDt0/ebOdzwp6QQBbNl2OEaDb?=
 =?iso-8859-1?Q?SGeVEBK/O11KZ4qEy86Wp7vJqOVw7PjZt/Uk/gUyEwZXEFC2tWTNzgEJWB?=
 =?iso-8859-1?Q?8n6ZXyfO0E+zbzox7uaUohktEtrX0DKXgo49Fvq/EQSfwwxbVpEELmVyNn?=
 =?iso-8859-1?Q?NYOWCjj8Ct9BFtZRi3i8Y1j31+YGHN8AEu5CryTZjv+ufkq46SwPN5V3OQ?=
 =?iso-8859-1?Q?le61kYIGdEcA8YnOXcQGZfIL/DaILiGqVIGuQEajLtTwIDhsxI1txM1GJZ?=
 =?iso-8859-1?Q?XYCWfO3x7VqyFawcqj9SO4lRpIIybJrVTzE2sMFwusvvuoZWb3rinq+vhg?=
 =?iso-8859-1?Q?a7HcziYRHjm+rcK+EpPETFZL9fwp5Jl9oEWV+iIQ+KcHc/iJ6d/cHGv7c1?=
 =?iso-8859-1?Q?4ugKnZ/7qQa0Rn4ms1iVisFz21GmH2Hf/ueD36aqjLPQZ19hbSnxqRQCgc?=
 =?iso-8859-1?Q?e8mhU/7Py4KDSbEL3BF03vM84VLGGK5f4Xi/r5sZAUGDDl6k3TlxYfJkOQ?=
 =?iso-8859-1?Q?fYd1+RyUSnyEykB8UwlmIAwmy8Iuu4M++gZOhm8Q2MCvkgBtsS+Yrcnwn5?=
 =?iso-8859-1?Q?DHJUg6nPuTXgRVzI+6CnfYgaDmf2rMkaYENc5H2rXsONcTgQFshdx6PzH7?=
 =?iso-8859-1?Q?PfZZF+OUKIBGJOn8V+yyfXo6XgA4g554U9kXdOJ+dD9v67oOcZ2sgi3Rt0?=
 =?iso-8859-1?Q?h2kEnMusZK14p8bHPDGA3rCNjVx/fcOmPUsUyWgP/vSr6ceEGxzViKrSeP?=
 =?iso-8859-1?Q?QBdsak5CKeUBuNHGpmgLzqdTt65a8HvJzKEJs0kJ/2DL/AK33RXgZhGshB?=
 =?iso-8859-1?Q?atuaUWiidG11FmS4AttH5Pi2dfW6D0lzQC1fhEjXHp4inNE359zBjqepwc?=
 =?iso-8859-1?Q?zhQzKqpKcPMHutRanndxw6xhjZTcjPn+FXtphGvNnThk+3WQsjADTEMOxe?=
 =?iso-8859-1?Q?p4kABPjqMQu7b0tOKc1fqBp4xUnuJAgaojaysQ7Mgn69XgEKd5tqzFFwqC?=
 =?iso-8859-1?Q?H5XWg60/4fbAOBxTpPEarYCsw9jhQKaQ5Dz1PNCPknkpDpzowa92c1ApLc?=
 =?iso-8859-1?Q?gll4e69Q7uOYwMU1nLmCQ8fge1q8tfbW9m4LRN5DSbHO8qUyTI0IYT7I6j?=
 =?iso-8859-1?Q?RLMjQtQ3xIAmMyN0x9sbPf67AP8w2hfqN2EOMy4mYHtgF+K38aHEEMcf99?=
 =?iso-8859-1?Q?r9gZtetxB3BfPhKxNL5pt6McC8K2wxpGIthy4ZTYBLHNq5FLn1KxMw5Ci0?=
 =?iso-8859-1?Q?fACqFjMvlbzqSCsP5HRkMEgwMAW2OSSzIq3t101OanmBoJpmS+wJdWSABn?=
 =?iso-8859-1?Q?jo8VRvCmXqLv6Hz/uyz23vP7Oqz5QPB73tSugTaHmlKUmw5WWXFZNiaD2K?=
 =?iso-8859-1?Q?0lFm7f+o4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a7fde-07aa-45b1-744d-08de9c296a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 02:31:22.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ce4E5bsjhGJy+PURy+K2ej76aEky6bbGvkrCNWuNOdvdZDwz6HxZ5+Za3NaJx+qlO2BornPAFs9/bLQn71ZIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0725
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279207-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,iogearbox.net,davemloft.net,gmail.com,google.com,vger.kernel.org,linux.dev,redhat.com,fomichev.me,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.150];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DBC34163BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 from v2 is upstream as 10f86a2a5c91 ("bpf: Fix same-register=0A=
dst/src OOB read and pointer leak in sock_ops"), so this reroll keeps=0A=
only the remaining work for ctx->rtt_min.=0A=
=0A=
Patch 1 extracts the guarded field-load sequence out of=0A=
SOCK_OPS_GET_FIELD() so the rtt_min sub-field access can reuse the same=0A=
is_locked_tcp_sock guard and dst_reg =3D=3D src_reg handling without=0A=
open-coding it again.=0A=
=0A=
Patch 2 uses that helper for rtt_min and extends the landed=0A=
sock_ops_get_sk selftest with an rtt_min subtest covering the=0A=
request_sock-backed !fullsock path.=0A=
=0A=
Changes since v2:=0A=
- drop the overlapping dst_reg =3D=3D src_reg fix, now upstream as=0A=
  10f86a2a5c91=0A=
- keep only the helper extraction plus the rtt_min fix=0A=
- add an rtt_min subtest on top of the landed sock_ops_get_sk selftest=0A=
=0A=
Werner Kasselman (2):=0A=
  bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from SOCK_OPS_GET_FIELD=0A=
  bpf: guard sock_ops rtt_min against non-locked tcp_sock=0A=
=0A=
 net/core/filter.c                             | 31 ++++++++++---------=0A=
 .../bpf/prog_tests/sock_ops_get_sk.c          |  9 ++++++=0A=
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 31 +++++++++++++++++++=0A=
 3 files changed, 57 insertions(+), 14 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

