Return-Path: <netdev+bounces-237633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284FC4E1F2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23A3E4ECE73
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBE342504;
	Tue, 11 Nov 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VUhbYuHz"
X-Original-To: netdev@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012014.outbound.protection.outlook.com [52.103.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BC33AD9D;
	Tue, 11 Nov 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867870; cv=fail; b=uVLXd1KFAvrCsdXnq/bW9WXqPh+eEqpcNYtHlbuVgGSaJYRmgMYeLymzGkDRZ27/dsLVvnNMPHAAfcsPYVPiLE0xBXGJbNU4yu736WU4xrqQnilEl5seOk2RKiAC3RIOjs6YHwzLNK5HvBNAyPjyhi962Zq7X+dHngyvrvxSzrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867870; c=relaxed/simple;
	bh=PZPzlRcOuxswbDh9r4UKsvgQBkiDQeASrM/f8F22ygg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i7N4Ccekc+CRVuLHJjsdKeRwVaLedFtFryiqYRrVW9JNUDbFLumQmUu5CiF1/MEbRSY5S0uNTdDVutzH6hZ5pS+OIsBY/apYwTg8MRBgLibz4M9Ml1NXN3TKCU8Ywhf40PjrfJdgfIzSm4MgZcmvqrWI5DEuPuhEP3GseNkxgzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VUhbYuHz; arc=fail smtp.client-ip=52.103.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIAhuzgVKyGfW78c2GefBPYC29Rjii6IqHT5eTmDDSzwslS6N3wLcdeW1ozeOndYvvZ6R2Wm4r1+3bWognAI0AvCMpS2fTI9HGBfJfJKE9CB7fTXvYCqEwwM3aD9agHl1nU2/kVf1AS9tsBxWnyv+r599t8qz8G/dw9Sh8BhThaP160lVkrR+KMES+Gm9k1MTT1h3uCeqLOv5O9erOW4H5vqSAjBk2PEtZj7eiUoCKfEp7nznJ1JTStJMT9Wey4wekPoeeXSwVSlFgZG8JyaGUJKTYYoTfPtb98nFcX3qSC9verMeoBrfI5KOJ2FNtanfIh8ch3tmV0hZ2vlf8/MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdlQasvgZpsaNEaH2Z1TcNBourXsBbaG/y0BlZ+RbYI=;
 b=gl40AoOl70/Rf3WHFdaipByNkPLyYLBNBBWZJ1HHAPr7ZLl2sdQVFQE9SjELeJh2RYy0naTvZY6dOU1COnfeiu6XGLHCD6KXU1XBwSKUlIZ+7Hr+6SG8Br3/WjHEuus6/kJwg+0enAnb0RijjJVZWZKJ0kZMDkbtJfyKtM4+zZPyiM1sJTn0ZB4bcH8GXSEBmwEFzJWn1J9EPlsxE5n0suXrtotjFSLyrnCGELYdhL7AnKTf4dhY/skXX2B/7IkvxNIrvoWZlCtxCNvjPwutyEZWXVV839DOBbCtabbMGa6iWWKInN9zVBR/6awgnWYOD4aSy6YaN3RYmrOuVtfuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdlQasvgZpsaNEaH2Z1TcNBourXsBbaG/y0BlZ+RbYI=;
 b=VUhbYuHzXQK9gGigI2et1/2CgqehlGWpGIt/dYOuxTfjbUI4eEbEvx2cRNHgy3xRi+g4lcDtvi/govW76CR0XyHZv9PaawtLEy5OXd6bKNprOaREjQx9WQGpA1l1oRp1qX7L/ltvXM76N6lrgeVa/ojLbel+YpjEbcnRTeDCIOGlZqqdaYVfvt06EwKIiwpBcCeB8sKYdvDfr/y/BjZALXxntxei4hisHPwJwHjuFMyvp9ciiRu0S3uwRRCnFulukqSgPBQpmufySmRZJUbCt6uTswSOkbMCAnl8eMrTUZTlwJt3KZai76WzjOpmJySf29Ts+9hujiVPcs1vWw9Qew==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME2PR01MB5842.ausprd01.prod.outlook.com (2603:10c6:220:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 13:31:01 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 13:31:00 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Petr Mladek <pmladek@suse.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "awalls@md.metrocast.net"
	<awalls@md.metrocast.net>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, David Laight <david.laight.linux@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Thread-Topic: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Thread-Index:
 AQHcT6WyuFN/zZUxwky1OIArpAbsx7Tm7iC2gAAGUYCAADcBgIAAU4WAgAR6PQCAAPXaIQ==
Date: Tue, 11 Nov 2025 13:31:00 +0000
Message-ID:
 <SYBPR01MB788101676D637353D4E27F64AFCFA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin> <aQ29Zzajef81E2DZ@smile.fi.intel.com>
 <aQ3riwUO_3v3UOvj@pathway.suse.cz> <20251107175123.70ded89e@pumpkin>
 <aRHzJIFkgfHIilTl@pathway.suse.cz>
In-Reply-To: <aRHzJIFkgfHIilTl@pathway.suse.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME2PR01MB5842:EE_
x-ms-office365-filtering-correlation-id: 94450ea9-e2e1-4e9c-0bc3-08de21268e11
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZlps6CageNK96R3p6oJJ6xNeOaw/6P97WeYhujlWOaaIRBHGn2sperGkK/s1HOz+g0PtBJqsEgsPFKliTDlccYKfI7x/rRibuXeemsCTp0nKvkpb6ldmp+TUDQPacz7Q3B1QGKDVbjYnRRyQZpkBYKcj/mCmA0d5kC2rB9vQaA2/W4cYK/y7xgHOcLXEaFZCzabw5y8/nJZye039bagNSfDoK1nB06TmQ37TRa0Ptto9aXcfmgUbNq8Y5LTzj+fMp/ih1fleG8plVNC2qwUE3Rz0L/K2YCpf+5TODj356Shkf3S0XproGXmuyezBskrfx+IEwJ+o+RQJ/qjKCecCS6kyIMlHYaulLrsF3s2xH9B/RWiJL2iy8UDec+Nr6+od78wdMQSt4+JHgZjBjV2WQ/YNK+iGmMVFuWzESWWXRYv9u8d3CVqw/ckvX1Ckg0NxOShzRHAjSbdpbjFRUgH5Mxw5WEpjlkp2jk4eOiWnRett+GWN3Y/5U4ALuHuIRs29mpDoOt9vJYGnmTvpdGEnFHamvMKtl1zTw1oaOCQRqULc7WUdniydI00TaeO2l5/zjUTsGqVl4X9W8R715ONevVMSDi4w2stw3ICrfZMrDNBaHSuYMEdDmE6Fp43gvqufuvn5KQuk5oCwM7qP0MyCYSQ5K1bBgXEhmUJq9nUXi487HKcRbpdq8v/8pKbBN3MTStxKiOtKBLVK9nHAAOdP8azU9VP4Obf1nJ7QgI9gtGFZcHq5oDp7ZYZwQDGHw6AGPxZYopHgCOmf4z7XplMMnf1BRWM+jdPJ67Z0hCG6BHkvbMA94lga6yf
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|8060799015|41001999006|31061999003|461199028|51005399006|15030799006|15080799012|440099028|3412199025|40105399003|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?r01Lnuc33B/4FzNybxBlDZDWoggVQ0KWdvi4ZG4nMEtTl1zL+YdXM4+tPh?=
 =?iso-8859-1?Q?OYNyCZz2a/zRNnMN5uHxkJDpk6mSTrircAGTWJ8ejq2RQM2sUGgh6QyYRc?=
 =?iso-8859-1?Q?JPa6WoXtGwNePucFQlt7jexEW0lE1deoVzOCZz+4yxWFH7FbNMazxmNcyV?=
 =?iso-8859-1?Q?DcpJqEneW1kHEDqDzvR1hJZG0fqPPnzjBIm6h/UFhWyLvJbJLtHGo6nCFo?=
 =?iso-8859-1?Q?ie3c2Wpkqp5RJtjbodAsxPM2Rlf8P/Wu0A8cpRvyok1pS+dW4fozlHSAZm?=
 =?iso-8859-1?Q?QNSBBu7vs9XuiRpJWgeeqN7e+F7ltybpB3kWmnBTlW+hm5TFoNzKIHfgQZ?=
 =?iso-8859-1?Q?NQp6kiJPK7kYzQIF6f+eDNaWJmOP8lpaqU0h+dIReF7C0VieZgUYqObUWp?=
 =?iso-8859-1?Q?1uuN1poCQFlj0ELNYvGJVia/4O/aox1S1nu22fO/6mgtor/UZ69igif2uk?=
 =?iso-8859-1?Q?AqTcuxNxm4m9+gJoMfzsBwT1ozts0rk6ipMHJGyn7EuRVyhI5zh9Tp4zbV?=
 =?iso-8859-1?Q?59qf0j5sLI3hEStzf/+Q4Jzdx9G+jjVRQi5aKEgnnhwRVoSrBkhyVNrgkF?=
 =?iso-8859-1?Q?QWLGooEH2fpZeVHvgS3+p0xaGMBVl31MBdjsbZ3Q5mY97G/G/sP2Hl+SuT?=
 =?iso-8859-1?Q?bqN+zaOSK9CoN8d7Q7dEu9lAVIt7wvzGLVm+q9YjbKv5cROingDPk+Jy5N?=
 =?iso-8859-1?Q?0r3nNqzxyQymJx7tCrX0DPXWm5/UFpTpj63nPUyPLzTrUaUT9E3DeUs8SM?=
 =?iso-8859-1?Q?I85htHb7zHmmkbv70iqCveh+k1QgTmeA+beayD7u85Fkz4uFlyJmBGz3Rg?=
 =?iso-8859-1?Q?ermSSiymx17GZOjCHZViq+GZn6Tw2+o2Tuefu0kBtBl+1e0/F0B41AXJ6n?=
 =?iso-8859-1?Q?Lo5ZpgZdhzne8dIO/eXAGeD8MKYo8GXNhVnrWsxDTpTzEjQnZsNtKPaju0?=
 =?iso-8859-1?Q?yX+yzUrS0Y3txkcxsKKawWRxiOq1eoZh6Ie7oj1zOnNDXak8unRbYPCzEZ?=
 =?iso-8859-1?Q?CauBLBAI96KuWmHUb8j8/tPcr8/Nf7gMGBMz8VtrnDppD15dbP0gxPDurz?=
 =?iso-8859-1?Q?9gqE4scg9IvsoxRtBfdBQ7c5HD2xr/wYKRXZpnoORjPUgir/oKYt2LpeeN?=
 =?iso-8859-1?Q?oeZ9hNusv5+4K1v3FkfW+vbryDrhWA8/CrP59ElP5loqKvBlN74VTI6gxK?=
 =?iso-8859-1?Q?jqSyyOrtwXhS//TWs4T6IHy3JILoWVV4uTl6kOkN7+4UCWRqHfSUcmeJzS?=
 =?iso-8859-1?Q?YHi58GBHRqzbXNKu+kKEA7LE3iA8xf3xSKznGKhu1JhFS66UlJG3Ifq05T?=
 =?iso-8859-1?Q?2eo3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bpgMahg7WT1EzFvjrqxULtseHtWw/HEt9WJ7x0O3SZoKzFbvjKg6ALs78F?=
 =?iso-8859-1?Q?RlBlwqXm1vePlaZ8VoDx3oguBINkhaTn/gmKlMgi8Kzd3jLZbRbPx/Ew4H?=
 =?iso-8859-1?Q?jfkdZXriemf4xWZ6I4iS9mY+aYfA9GiskQkTSpSxgIvm2zmNOcSF7UALDR?=
 =?iso-8859-1?Q?j5B2ufjAhrJlhKAjGhaoRPt6iLQ/AdRrINyiYhYxzA6dPTOFO6HXSCJPtG?=
 =?iso-8859-1?Q?0PycTYQvIvrKSjJWKNxhmWUU5mRMu36+M+p41+UBxw2KWCTNp1K+ypV47t?=
 =?iso-8859-1?Q?8ZgfgILh5mREFVLkf0GdDCqGr2XYKls+WecdYzbF0xbcBHhdGGV+odPIKk?=
 =?iso-8859-1?Q?QGcG9llSYm6cPTRuTsDL+WQCneIVCqnbisHIjVE4Js9NoE/EaUqVbfn3HE?=
 =?iso-8859-1?Q?dOKm70w923TqjCV2gFDB+0WqqO//RtfPYgEUWm+Fwi47JUPMwZzXZzreja?=
 =?iso-8859-1?Q?62ybKVRgJ/V50i5COExSwkmpJUv7sHqM/BL3xhk4ozI1q3gAEazp5p3Jfu?=
 =?iso-8859-1?Q?zt8XhDbJiR3f1wfnK7W4ZGdGtO/PcSKovYub2lUVbq9huccVNHm324ee9w?=
 =?iso-8859-1?Q?xmdArn97Yns7olh8Dt0JN1BSwlxuYhBwvhtmg1IIlRqxD+AGhGwd7ryrTz?=
 =?iso-8859-1?Q?GUQ6b0REFtaNuKpUQydNLsrgonatLP69taiBt98YoW0DUBBwCt5Dtwk5Ec?=
 =?iso-8859-1?Q?ZwN9BG10KYz8OvC2+ZK76CfZ3YzCs/wYn1IMMbKrcVVfCXGLbJeZxnA/J2?=
 =?iso-8859-1?Q?nzxwUqNOnHYbVoSEqQ6cQXYrgzvs7ONdiERJPU2amAiqGRmt4O43E6Yol+?=
 =?iso-8859-1?Q?i4l3MUekxT6NpYu2G37cnZwOoKJFZ+C+ubAQ1e9U1QxeOAhEnWF3CQtPlT?=
 =?iso-8859-1?Q?LJslDd09Y+QCQhteSEJQ9F3OBGus31Kzr31KdouSAq8P0Q1bFbq6Aj5JTX?=
 =?iso-8859-1?Q?nNmnwB+1r1h6hSnGlBcHesKb99Rts9A24jBUL8Mdx+Lsy358edbjWUymtv?=
 =?iso-8859-1?Q?e4kMz+wJ+UDQOnz3PdybgvYhgL7LsIZa8yDXs3WT8mWAtSl/wjJNIVDQ0Q?=
 =?iso-8859-1?Q?Y3ujRt1ZB4hPa7bPpTPTTBHH1ufPVHc4FIzXpR/U4mqVQHJjTdxNS46drq?=
 =?iso-8859-1?Q?8zdxzFYPVUkdQyGUZnsbcTV0+EcTHY3IXFAFqO/UhmvF0fIFD9edEEQ93A?=
 =?iso-8859-1?Q?8dHJuNYVE7iOYeyXgZeXxzdfTv3/TbdGHB8EDMWkjkz58+GWZefDlD6zym?=
 =?iso-8859-1?Q?GD9dILK4x9raZZhIKCsxdZPlSOdFQHTnlQKX23Jyk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 94450ea9-e2e1-4e9c-0bc3-08de21268e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 13:31:00.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB5842

On Mon, Nov 10, 2025 at 03:13:56PM +0100, Petr Mladek wrote:=0A=
> On Fri 2025-11-07 17:51:23, David Laight wrote:=0A=
> > On Fri, 7 Nov 2025 13:52:27 +0100=0A=
> > Petr Mladek <pmladek@suse.com> wrote:=0A=
> > =0A=
> > > On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:=0A=
> > > > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  =0A=
> > > > > On Thu, 6 Nov 2025 21:38:33 -0800=0A=
> > > > > Andrew Morton <akpm@linux-foundation.org> wrote:  =0A=
> > > > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@ou=
tlook.com> wrote:  =0A=
> > > > =0A=
> > > > ...=0A=
> > > >   =0A=
> > > > > That is true for all the snprintf() functions.=0A=
> > > > >   =0A=
> > > > > > I wonder if we should instead implement a kasprintf() version o=
f this=0A=
> > > > > > which reallocs each time and then switch all the callers over t=
o that.  =0A=
> > > > > =0A=
> > > > > That adds the cost of a malloc, and I, like kasprintf() probably =
ends up=0A=
> > > > > doing all the work of snprintf twice.=0A=
> > > > > =0A=
> > > > > I'd be tempted to avoid the strlen() by passing in the offset.=0A=
> > > > > So (say):=0A=
> > > > > #define scnprintf_at(buf, len, off, ...) \=0A=
> > > > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  =0A=
> > > =0A=
> > > It does not handle correctly the situation when len < off.=0A=
> > > Othersise, it looks good.=0A=
> > =0A=
> > That shouldn't happen unless the calling code is really buggy.=0A=
> > There is also a WARN_ON_ONCE() at the top of snprintf().=0A=
> =0A=
> Fair enough.=0A=
> =0A=
> BTW: I have found there exists a userspace library which implements=0A=
> this idea, the funtion is called vsnoprintf(), see=0A=
> https://arpa2.gitlab.io/arpa2common/group__snoprintf.html=0A=
> =0A=
> I know that it is cryptic. But I like the name. The letters "no"=0A=
> match the ordering of the parameters "size, offset".=0A=
> =0A=
> In our case, it would be scnoprintf() ...=0A=
> =0A=
=0A=
Thanks for the feedback. Based on the discussion above, I plan to prepare a=
 v2 patch.=0A=
int scnprintf_append(char *buf, size_t size, const char *fmt, ...)=0A=
{=0A=
	va_list args;=0A=
	size_t len;=0A=
=0A=
	len =3D strnlen(buf, size);=0A=
	if (len =3D=3D size)=0A=
		return len;=0A=
	va_start(args, fmt);=0A=
	len +=3D vscnprintf(buf + len, size - len, fmt, args);=0A=
	va_end(args);=0A=
	return len;=0A=
}=0A=
EXPORT_SYMBOL(scnprintf_append);=0A=
=0A=
I agree that using a macro like David suggested, with an explicit offset, i=
s a reasonable and efficient approach.=0A=
The `scnprintf_append()` function, however, does not require such a variabl=
e; though if used improperly, it could introduce an extra `strlen()` overhe=
ad.=0A=
=0A=
However, if the consensus is to prefer the macro approach, I can rework the=
 series to use `scnoprintf()`, as suggested by Petr instead.=0A=
=0A=
That said, I believe `scnprintf_append()` also has its merits:=0A=
it simplifies one-off string constructions and provides built-in bound chec=
king for safety.=0A=
Some existing code that appends strings in the kernel lacks proper bound ch=
ecks, and this function could serve as a graceful replacement.=0A=
The benefits were also demonstrated in other patches.=0A=
=0A=
Thanks,=0A=
Junrui=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

