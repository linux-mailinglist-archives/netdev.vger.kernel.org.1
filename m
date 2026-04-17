Return-Path: <netdev+bounces-279208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHQuFcWb4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A714163D2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAED30B0388
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83F2F616B;
	Fri, 17 Apr 2026 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="ecfAWmlS"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020131.outbound.protection.outlook.com [52.101.150.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1172E974D;
	Fri, 17 Apr 2026 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393090; cv=fail; b=WgWUY3og0+yxkW6GzBWAU6UYjesTlwOOUHhxFOZQ3DWGdOzznN0yLOk1x15oDkWKN686lftBdl/sXtZRldYglo4nf0tYDM2TUt0SCtIa292cBMChJ+9B8bDBX/NUi18gLUtbddoxWdqNlqk1XwlAMbsedXn91H0uflybCDEHwkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393090; c=relaxed/simple;
	bh=j7DnnDymfmBQbDKanWKz7BscQ67Dk5KAi0Yx0sMn1V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMjCnfXfIGwpCjLulR96Rk5xsjUUv6UHHiDPUtYUOdx2n4ULlgulfj2Qpm1u+EAa7S21tjjgDe8/9y2fMGW2Q4Qn4J25rVp4BHwiRw+N0tw/U1YYBEvoG3pHzX62B9EVrcTqXMfFyPEUsi2lqpBT6kgnael7/bmD2tFTotInQEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=ecfAWmlS reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFgzmfgPlloqZaTG0FwncasNB6DE49GljJIiAnqDRKtB1vdSApKZfyM4MUdJWzjJHq47kce75x/+wFeG+/AdvIDpEmMVqzAz1puXIctDA9n71iddloxo7la9GqGjGHHSxnqUDGauR3qOOe7qRBe+TDBBqNv/LyrUzoax33/HNtB6YeCVs1iBFYNW0VDszVq21qMLI4TijYc2NflyWM+y798a1viNRGvfP5etZeM/JTIeHuFh71adOHgNQpkXISNwCHomX6JxjeKU0nzZxKmWqoZ9ejylHi5dY1NF2tb3p5vndYWUyPSZ9N7eoz50naZrISuX+2Aw/rpVIXC814CFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKgYFbrDLIZ73OT/WxVLPB6YtgrPdl40ldw24XSMCsg=;
 b=G/de3SK2S4Ha0i2JXnl5/xU1/XweT7RBmxgZpCyGbo5xCQmOPvO0F8r7+ipiGBSJ2PB1+i+KuG6s/PSJ7vHCjXlrVtNyC209qGtNLWo/pYvD+siwSPfYN5gipr6fJ1R9xImxMUuKIxichM4TppIfVyCgchgmEB4+AGTRm12/bs2dOVQY8ntG6Afixf1YSjV0DSHEoguFxwINOoWoRunES+5Ny+pVSw6bm9oPeObmtVZMH+qdsQDyOfIQTo6MJVL0D5hVA4Fka8pUwbehZBwD/709lQ/Mk4zQ7Zl7QGqhMhpRjyDvpiCG0I0h2eWUvtc2Nmx5FGo5QmZmNdMHK6Swlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKgYFbrDLIZ73OT/WxVLPB6YtgrPdl40ldw24XSMCsg=;
 b=ecfAWmlSArEHVTeA6kcTmmwcFdei5BDmiC+UBTvVUZjD9ARwujrKjRCbURhxib7Ll/qn384IAnFk7thmnIohWxZa2f1iiXWC3GlLWMK7xOIWm8a3sfW+Htwd4ib+Xrc64OjyRt8w9i+T2gzYGMgcsZFRb1I/mtkDC1jQVnLBKFkts9zsh76oAiFljJpyqpGgEcBNxyw79LH15sXNq0/4D8coMA6yEZ5PpRkURxT4LOW0NWX2NQ72kq/+SbNYw89hpVKJwyz6V8fBw/okkzo+5gHdWB4vFov0nppmGQttIS1AevqZz5hvHOdVPSMN6EZhawL0SEwDW+u+RZYCampssg==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0725.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:31:24 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 02:31:24 +0000
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
Subject: [PATCH 1/2] bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from
 SOCK_OPS_GET_FIELD
Thread-Topic: [PATCH 1/2] bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from
 SOCK_OPS_GET_FIELD
Thread-Index: AQHczhJI6Ry9h/rsH0e82HHzNWrypQ==
Date: Fri, 17 Apr 2026 02:31:24 +0000
Message-ID: <20260417023119.3830723-2-werner@verivus.com>
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
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0725:EE_
x-ms-office365-filtering-correlation-id: 1abc9af0-f8e0-47ab-5735-08de9c296b56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 v0kjSbe5B+xk67S55X45xRHsUZ7B3h3fuJJPsgPjP0XBlw3PHMb64kP93X3UOaiN2wlo0ZebxOaUdK9B5fLFwclrh84omZSZHN5q6CiVUWVcmY0RIkELYtJUrqix2Rmg1ab4bA9zJGfGfot2v6PjOyoyGs/fCrV9VY841uZQneK44SyRo9ZC1oP6imHoJ/0FvBjhqxgm/Hq1XmzVlLizxGQnEw1n4hPl8GsjiPDTch+olbYGZzG1vxu1jjjW4HX8vm75tRoLPUgyXdoHiJenClkYAOjdmHxx4GcsQHLdn6jzL8kOA/5nR0PyzDHvKc1n6/+hY4QSJiLe3T0m2CwasvfHvpELJCuWNpm6ipop9EMU0F7OIdnBlCMydej5fwLnSBxuVGI3yvwl/Ng5SYT+862EHt/sYJniq0Etiglu6CZGVeUO06JJ3WYKad73djHOuuIDAppO9gefgl6vHkpIoGxZHbYP7digJ3k4qPPRKFoQuNj8Hjgn+Ly6kVKpHhVgvYA1oTCe14LHvXJohUcKBb1bKGEr8+2BEDyWtgB2KEekaH3OExXVm9KvIRxBNwjA6ymuhDndx+F8jthpQ5jan/d5+O35Y36LF6jRiAU6739OrrC7ToZ62v/fBCvXOUvg4u27HjCchKJnsYDmTiEsTDsBp7zGOxgOIiIXn5z2Ztzeln2Y86ChvKWUKfrCve5coqszPECm3fc1djUdCa96HA+4pVT/u7m7xnWsL+bw/L6qXetOykNS9KKTohQVyRVMSrr5M4nOouu6bCb965OqtSG5BFVgUAXrho1UWsIjvT4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W2U4Ie6pDFL02PGOv4xEHYobkctQFYhI1I0MTExxgRr+zW6f4U8QAHfsQO?=
 =?iso-8859-1?Q?G9TIiLa1bCkpMc493hwqlI/c3YClPSpJbP4vSd7gj2nmy6jk1R7d7o+8eB?=
 =?iso-8859-1?Q?GPH05LiP+EVaunrLYcZHipDSowWyvBBuU+iafKO+IX2NxsQ2IvC+XxLz+f?=
 =?iso-8859-1?Q?MzT/GBM97w91njnfaoVRKAnugsQs/QN3KQKuEpYEbUYyTxJpKLqG7gLk9L?=
 =?iso-8859-1?Q?1BDIGQrgbmyqjsnqSQ/BFxoU2J1BdngBhAnl36hTqPpRKYmO66PNkBdmqd?=
 =?iso-8859-1?Q?uJ5sYZYfNoOtba1pS7DPS84OhbzIdUL1hTUj3wCdGwwACuYl2FSW/VE8dZ?=
 =?iso-8859-1?Q?Ju1bwRhgMDCbDh/dV6TEueWqVQGT5QdTqXnED2ljgaB3yfu8bKSuK1bH4X?=
 =?iso-8859-1?Q?2Ba/Ks39RBmXSXIXQwJguuvGYf8qdvSvok5x84N749TKp3ZZ1/UN7Arziw?=
 =?iso-8859-1?Q?xWts5dUH9Yy8k3A6f5M/rdq051Gi8MGO97DTi+QX5lQtZOrRGo1iz1ep2O?=
 =?iso-8859-1?Q?FbM0KXWd45Xa9iANXPBibdDstPU9fDBx1dJWjvVNdPCjPSKW2IC2n8L4R+?=
 =?iso-8859-1?Q?uUCdweY3Hzmxp6TF2rMGOhqniA+TG75bkOZinK4Q5MtFlMcj3nswwtJxwe?=
 =?iso-8859-1?Q?yg+8ittioAssj7JVMUrIJPbp1+wt8/JWGiowz0G8Jh4doqvZAZYqLJWg9P?=
 =?iso-8859-1?Q?EKeAO0jbLgYuzBx1k7JPyD89WYLgyN7NaV8uLrrCcBl8jeOOzWuxcQQVUm?=
 =?iso-8859-1?Q?o92wU844P9QUxR+6VCCHctKv8SMX7njo4Skj8I1HdpZmKvw7YUVqox3DOy?=
 =?iso-8859-1?Q?tstpY3WVpeqEzDccXI6HxnRuO2W/VF8D7Qw6kCl+WDZHOxqcboPhjRA0HT?=
 =?iso-8859-1?Q?UpMgbRoD1lR5cZh+zNqoiJxCMmnyY9Pb21eYhmmm5yYuat0FlSpmyIB15q?=
 =?iso-8859-1?Q?FfNHWhx/rPeA0Z3ozLMZY/IOweg5PWNfEx2D9ea2UaKV9NMg+3dLrOBP8z?=
 =?iso-8859-1?Q?U5aF+qQTW20+EhflTrffd0MNa9iuOQ65/gTO+IYvM1OqgLzElVAx3N+21W?=
 =?iso-8859-1?Q?Ct1h3sdVoNg4JEtOyQWgm0fsrjX7KZzA5OpdX01d6w/Ewvbz8kVzaXv22o?=
 =?iso-8859-1?Q?oSHWjYd5kE+wZjyw2zKZXHIoGHFrm+iNar6s+44n6t+kfR/he4wncTkbHJ?=
 =?iso-8859-1?Q?qM5MmNfHGBi70S5rWycPQuu2+6oTjouyaUP1E9KVIws+C6mXvfuhnOZdkw?=
 =?iso-8859-1?Q?CAwMxP5L8QOdVSwlxD96sLgv9UQ2bDH6uZ6VuxaQKT8c/37fMSzDv93wSo?=
 =?iso-8859-1?Q?L2lAWSnQthm8/FftFg4UJCs/yQe5H7uS6/ci5VI7lOl04JCej3LxBqE1d0?=
 =?iso-8859-1?Q?lk500YaKUdPqDeWcAWqWbUdIAgwB/chgn6DwsEwBm55muvxUcjO3M67Xhb?=
 =?iso-8859-1?Q?zIFSUN9+LKIJha+3MFEmTG3bOXYOH/j4h/8LaeybBbSlzgOTa0Z9Fqg0LP?=
 =?iso-8859-1?Q?5cdv81kWNx5sR/fYa/bDxI3gRigb+63dxjoeVeyMtg48qTfOSD/+ReRHtR?=
 =?iso-8859-1?Q?HfXDQ41dF1xOToKtRCvByVnGO1MwcgiRbrtTAXufESbrjdpF5wMlTXz/CL?=
 =?iso-8859-1?Q?e6oJ41dIietzxFf+6FDknZt1SFV0hAsDMoH2vrHqK9xYxbLaNcGN9zCLee?=
 =?iso-8859-1?Q?2ToROYWt6wzsAy0set+OjZp3Ywsr7sZwYi0PK2M2Vu26avlqXnmE7XrrTb?=
 =?iso-8859-1?Q?403MGgKwmzujn3ZMa2HZa2hmC76bSbagw8t6We+QgvJMPAVAGKIFoNNnEQ?=
 =?iso-8859-1?Q?gu98RMu36g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abc9af0-f8e0-47ab-5735-08de9c296b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 02:31:24.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRNSgB6IHGFZAV9WXvjuAScu+XocCjHBIO1B2zuX/beaU3vrXUyNtU605ZarC+y1Eh5xLaJfxl3W+pY8jRxjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0725
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279208-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.186];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,verivus.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7A714163D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the guarded sock_ops field load sequence out of=0A=
SOCK_OPS_GET_FIELD() into SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE,=0A=
FIELD_OFFSET) so callers that need a custom field offset can reuse the=0A=
same is_locked_tcp_sock guard and dst_reg =3D=3D src_reg handling.=0A=
=0A=
This is needed for rtt_min, which reads a minmax sub-field rather than a=0A=
direct struct member.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 19 ++++++++++++-------=0A=
 1 file changed, 12 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index fcfcb72663ca..e8ad062f63bc 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10535,12 +10535,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 	struct bpf_insn *insn =3D insn_buf;=0A=
 	int off;=0A=
 =0A=
-/* Helper macro for adding read access to tcp_sock or sock fields. */=0A=
-#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+/* Helper macro for adding guarded read access to tcp_sock fields. */=0A=
+#define SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE, FIELD_OFFSET)		      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;     \=0A=
-		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
-			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
 			reg--;						      \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
@@ -10567,10 +10565,9 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 						struct bpf_sock_ops_kern, sk),\=0A=
 				      si->dst_reg, si->src_reg,		      \=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));\=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(OBJ,		      \=0A=
-						       OBJ_FIELD),	      \=0A=
+		*insn++ =3D BPF_LDX_MEM(FIELD_SIZE,			      \=0A=
 				      si->dst_reg, si->dst_reg,		      \=0A=
-				      offsetof(OBJ, OBJ_FIELD));	      \=0A=
+				      FIELD_OFFSET);			      \=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
 			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
@@ -10580,6 +10577,14 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
+#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+	do {								      \=0A=
+		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
+			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD),\=0A=
+					     offsetof(OBJ, OBJ_FIELD));       \=0A=
+	} while (0)=0A=
+=0A=
 #define SOCK_OPS_GET_SK()							      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 1;     \=0A=
-- =0A=
2.43.0=0A=
=0A=

