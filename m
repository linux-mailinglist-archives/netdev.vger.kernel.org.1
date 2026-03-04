Return-Path: <netdev+bounces-263826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLltBRM7qGkTqgAAu9opvQ
	(envelope-from <netdev+bounces-263826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:00:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99EE200E06
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1854B300C321
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA643195F9;
	Wed,  4 Mar 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b="oIPfIpBG"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020123.outbound.protection.outlook.com [52.101.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20515E5DC
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632847; cv=fail; b=GcLl5JrfAAeUM4R0OnJfiaO6AaGyRNuUdVO4RJOn3c9v7Z72rKYsoDzX0PqbFYF9+KR9wMstK2IQUjc2Px+jd1/oiSXpX4pW7RNny2XBvdG4df0bu5WQcp73V1JxyBqzNLSOeEoHgzk3+IUNRvZbfFQpI3EW1+bm0HoQhctvJe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632847; c=relaxed/simple;
	bh=JFyuEp6GrH1UNdTwCJULqMtycfobq2dAhNgUlZ6Dh1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5Dci8VLjyAsKJYhyO4YWt8KXSi3B91Akut3qONuURLVURXyUp9qoRaVEdLr6ajKpww0PSTRhm6eSmvdPCdKpBuh4GI1TDqnjVwQODnCDdcnb1EhLcR2g/C30tr7JrAfBz/ivQy4Onmv9G1SAHvozdsX7eEOTDT/+WdJOWv1sFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=pass smtp.mailfrom=labn.net; dkim=pass (1024-bit key) header.d=labn.onmicrosoft.com header.i=@labn.onmicrosoft.com header.b=oIPfIpBG; arc=fail smtp.client-ip=52.101.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labn.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP9G1h2UvpP90XSj5RBlruB2Qe7a2lY4f7wzZmB7WtH/pcC8m+5m6cnOwDJIJHXuxaNYvJ3cE3/6ixwJwh8ud+MWEPPZkNQYAaUmK1DBg7LTpZLgVvk8V0mJmyRN5kG6Qupa14k0nctC9zK1ws8clJc0j/K4L2tIymsRzbvphg+9nTvXOd/z3aRsiGwDttNh3OFMKWdgK2KkvNiVN3Rzw91DLymuWdtN5+sSfIOPgSdcrYeiymE/NMv9xC7UJc9XBj1aic6aisLXWAAF4FDSsDt28OW6WXfxujDXCSpSoKOumeLLmR/DFc25CF+seWoaQKrGhFiISsGthp1dHPJoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFyuEp6GrH1UNdTwCJULqMtycfobq2dAhNgUlZ6Dh1I=;
 b=CuSE1dd8QgAdFe+duroWxWzwmvJAIwob1NZpAKdrneQ4paeZsUgKRMoRbUW2z/XHulaJ1+0i2f4hy/AXRHbBlU97gSwbqAXRucmjOWeVo8OuYNWDUF8+cixk+FSxIaWBC34y6Sm3ypa/FqVWIwqBD6RIxKCnmypUAUA6Vgo3Dagu/vz6mkkTwB8Y7bkXo7RJIEuOCgTReiADC4KFrxH+KLqLGWLmPRhWljT2NCtam81wwicWT9c9d6rIfieHL/wmI0zWxjkbmLK2VkrzAzcM9ALjuZmpjh8rkxaXBOJqxOu0wyVI/+fiEIfeqDboG/Dkaq+o34OQ/a1wBkcbmXw9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labn.net; dmarc=pass action=none header.from=labn.net;
 dkim=pass header.d=labn.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=labn.onmicrosoft.com;
 s=selector2-labn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFyuEp6GrH1UNdTwCJULqMtycfobq2dAhNgUlZ6Dh1I=;
 b=oIPfIpBGd+K4hHejDUQj2SzGGlG60IUtCXr5GkgwoJmBNjiNhHs3PR1GcsQpbFx/11j1HBMR4PnR8M8H1GapxIMSn5LvrxiSgj7eKe+6gWd3KlvbW+YssFFY4kaphXjBf8vhnIYRUBZ9qvsOPNgbQBkf+Yn/2Ue4R9kbQ1xKUl0=
Received: from CH2PR14MB4152.namprd14.prod.outlook.com (2603:10b6:610:a9::10)
 by CH3PR14MB7214.namprd14.prod.outlook.com (2603:10b6:610:15a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 14:00:42 +0000
Received: from CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::a4de:970c:e431:fe83]) by CH2PR14MB4152.namprd14.prod.outlook.com
 ([fe80::a4de:970c:e431:fe83%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 14:00:42 +0000
From: Christian Hopps <chopps@labn.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Hao Long <me@imlonghao.com>, netdev <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] Kernel Panic in iptfs_reassem_cont when handling large
 packets
Thread-Topic: [BUG] Kernel Panic in iptfs_reassem_cont when handling large
 packets
Thread-Index: AQHcqhxGIbvg+PghtUinsRA2sdsNQLWeak6A
Date: Wed, 4 Mar 2026 14:00:41 +0000
Message-ID: <F4AA8F05-F065-480A-8F83-7D9FD730650F@labn.net>
References: <DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com>
 <aaVGVTelUZ9gFhkT@secunet.com>
In-Reply-To: <aaVGVTelUZ9gFhkT@secunet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.400.21)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labn.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR14MB4152:EE_|CH3PR14MB7214:EE_
x-ms-office365-filtering-correlation-id: 8e0b0342-f1c8-48ec-7c3e-08de79f66c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 EiLP9BrN0S9F0MDUvfObBirKrSfE99Ex/LJPlLJBHdZLFbUroRgJX2eCsPXkhdbMdzz1cifXLY0HcgJ4DHF7aWXq0YGoueVwHEuQCYn7nNcXJJOAsH+WOPXxnIdQ8xDczG/g2RhXL2ZgOFfQRLJUy4Gh5oEXuYaSIWdMZ6UcOlg67KdtoXA4MQFaX0q/h19UwQGgS1oBFlsKfvbdtHXqkHsJXHH6SfNQaXABfs+mLMhVHjUfTIxxsDPl0uy/dKDRn4uo0ENcU/tyh0DECtfbqqVey7t9bmsll48SqINIzlVRJqIkvubCv2L5gRjMeezpdohXHuKl/aBlWw2bLPHRIuY0Iw988NU6buTg3UuYFfD/05I7B50n/mDovqTC6qrVeZ+1BDL7sQRtvttEjnAJ/0FxiBLYaT/Hxt4oYQB601wvJDXlN2JNPobg3zJEoE6ro55e7TDKCbxT0/xkK7BmsdstB+IxJv8/irHT9TL+BDdfE6j3F8qYiSM+rnLOExcUoQ7eCJww/GrKZo5CJpQwrdigcolk2mun2d1e4mEgGyt2wgbdvA5ceocVeXh3ywSQpI+eEVXwWKs84xLSEIOLWWjcU8sSV0uKRncH22HdAjFOWaUSnWVm93Gs6bEITTntOMdnaVfWqaVuvHGmevW96T3o/7oa9ftjTusgEXISX0hgX1HEbPCpbAxveZI1/FWw/SS4kKltWF/+dCCm1qJLD8xLKB61peQW52T4Tx5LldHit/s94v1sIvjGLNOxQIGqov8MMKCR5pB6Oerxer2DlTCOiEw92dnW32PUvPTUYGc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4152.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wzIGcJCKTtCzZsA0g0S1XNM3uivfsJ50zSMlaLV8vvcrPirrxT8SBWPfbEEe?=
 =?us-ascii?Q?sB2JXp6D9+LdiZp8MHrL2OmnQ7arM4LbNSuneFrqwZB/ejwaCHeAT0RfVmkc?=
 =?us-ascii?Q?hUT85pLsoSfWtwY8HRVlmejnzLXRNjCpXgzdDKuArrZcZmtGM6BQsMsghiCj?=
 =?us-ascii?Q?iRGZIPqpQG4aqvX303rhGR/KdeoWl38RzkbRuCxfint+4X5Ccp+ryqo6wOT6?=
 =?us-ascii?Q?y7fHbVsjhE/5aQPP72i6/6vg4x84R+HAw2mEOYOLC504EzCap+BvO9cEtQH0?=
 =?us-ascii?Q?K6wspj9TqGDeYMO9PCnCxLGlgHZRd9JCNEm6hlLTCQH/GOdr2mqy9o+2RmBo?=
 =?us-ascii?Q?6JWOhL5SOivSHDXpirUDSr4gTItcvWVgqDMR7AiaO7s7iezJjkZL7RAcdGzt?=
 =?us-ascii?Q?cOONP6pdXhdAQXbt5304likeYZlbilxkl97yTiGaNY8Lvf76KnA9GEOznciU?=
 =?us-ascii?Q?98TAvTQTXweFxvhiXgcddRWvFP9E8TjBlmArZddw+8iVSb/7Xqgg2RHuEVP7?=
 =?us-ascii?Q?De69HsFfNXN/bNLmkvyq08UfSTMIPXSm/TZWjB7W3oMQ/2lClNFhe3rdFpwg?=
 =?us-ascii?Q?bhPIY9aQwM41Z+ttE470Wdy3GJyKuyV2Z1O/zOoZoigvzXUJIxc906JRwBxS?=
 =?us-ascii?Q?VgyLnBM16KzNMkCmzEOzT2Hgb9lRUxRDCpydDAhiJqMXpzrNik0Ecd5+jEcL?=
 =?us-ascii?Q?N7j9+yYKgjLvdaIjSbwP/hKHR3ZhxFWNoDiPdb/vhT8yM68bMpP4LlprOYXM?=
 =?us-ascii?Q?GZJig5Gfy8xKTHdWDIUz0r4yFT4dJGlkyLUCLodyGt4dVqrD129uU7PJr9dH?=
 =?us-ascii?Q?SvIrolqjyavR3Addl1F6A11DIpkSxGdRxkbhKkpnD+5yevSTUGpyCEiPf1rq?=
 =?us-ascii?Q?d4p9yyvpKy89ecmZJj1H9nmPyrx8otGqFhCGrSkhGDLotL0sv1SaJjIQednA?=
 =?us-ascii?Q?3rxzeSDk/IGwXpjJOyJjKP1xToEX8vuanFh4PFXP163a7L0qZq/b7volv3hb?=
 =?us-ascii?Q?tq8CvE5q1iYa++LR5q+H5iBHpMJr4abV/K0eyvABNT9qdIHSjgiEmTGaE8Nu?=
 =?us-ascii?Q?4tuFbq9fjOstifXPPSdW7sVJKvklpTVwBUEgZxUvN+GHj3PhLXdnZ758SfBu?=
 =?us-ascii?Q?tkRZZq0Ln1DhS8X/Y3J0usiCmqkJqvl2nmdaCQNCE1FgjJDP67QpOuv/IqyR?=
 =?us-ascii?Q?mPicr1k77ZZfdATHcg0GkYaEhCsTerXKwKoJMpxTvE9qynUQ74W34wk7Npdb?=
 =?us-ascii?Q?Is8JbmEcXiIFrPhkurwKbMHK7Saq0mpbAWEue0R2YZQCB6TkP1UYUxawFG9c?=
 =?us-ascii?Q?xt0gNMo+6J3iUQAI90mxVzN4YtXwfRFDbQftd3pGS9PeQGMMGu6pVUt9mM2E?=
 =?us-ascii?Q?IChLyd0R2DvKQV5KaylsOvUPoM1AWl+DWbaxVTuBOyizVd/dtXGXcTOOR1q0?=
 =?us-ascii?Q?M1pIMKchDjYNu/HVY4EUDXdyUOconb5kzXF6QyvGSYhFNg1hXNtp7pSiCHZx?=
 =?us-ascii?Q?l9UwgMPMFGaOcM0ITVQV0D1NYQ5y4uU/x/oyFe2S/11xcVkOIoHGwEgb4x8e?=
 =?us-ascii?Q?lQGHL39NYc1H9o0huO7fcKln5+Phucf+RuzdH1XDRw6d9rb1hUqWZh4E82i9?=
 =?us-ascii?Q?GKIFDRgLcNkotqIHdSl8y4Me36/b1pt/fhU/qX78l7bYNZ7lkH8smRCa3mMT?=
 =?us-ascii?Q?8DvWwgCagD69hf6FpOUhEcI1/SdG1DJuNm9AqEgqh91yygHM6z1k66OBqbD+?=
 =?us-ascii?Q?X1j70a+UkQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3DA15333C83A34F9B3739F023E8246C@namprd14.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: labn.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4152.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0b0342-f1c8-48ec-7c3e-08de79f66c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 14:00:41.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb60ac54-2184-4344-9b60-40c8b2b72561
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6reUDbYzcL61O1R/V4cXQsXFW1i/5N4JW0M1SgRaLmD/vAv/q++4zZbGB/aGQbZpO9nQ98W+8Ke1Ks88em9Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB7214
X-Rspamd-Queue-Id: A99EE200E06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[labn.onmicrosoft.com:s=selector2-labn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263826-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[labn.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[labn.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chopps@labn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	APPLE_MAILER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,labn.net:mid,init_env.sh:url]
X-Rspamd-Action: no action


Steffen Klassert <steffen.klassert@secunet.com> writes:
> Add Chris, the author of IPTFS, to the Cc.

Got it, will take a look soon.

Thanks,
Chris.

> On Sun, Mar 01, 2026 at 05:49:19PM +0800, Hao Long wrote:
>> Hello,
>>=20
>> Recently I set up a strongSwan tunnel in AGGFRAG mode[1] in order to see
>> how it fragments large packets.
>>=20
>> Later I found out the receiver node will kernel panic when handling
>> large packets, I tested in different distro and both panic.
>>=20
>> Tested environment:
>> - Arch Linux 6.18.13-arch1-1 strongswan-6.0.4-2
>> - Arch Linux 7.0.0-rc1-1-mainline strongswan-6.0.4-2
>> - NixOS 6.18.13 strongswan-6.0.4
>>=20
>> Step to reproduce:
>> 1. install strongSwan and create tunnel interface in vm1, see the
>> attachment init_env.sh
>> 2. do step1 in vm2, but remember to switch local_addrs and remote_addrs,
>> also the ip assignment
>> 3. run `ping -s 3333 10.0.1.2` in vm1, 10.0.1.2 is the ip from vm2
>> 4. kernel panic in vm2

