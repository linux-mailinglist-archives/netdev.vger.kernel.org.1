Return-Path: <netdev+bounces-219820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3940B4326D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E091C216C4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8C2750E1;
	Thu,  4 Sep 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="XH5EGJYw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B616274FDE;
	Thu,  4 Sep 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967587; cv=fail; b=a3VVTLR0UkdorW2CALAqdzc3lhYXIkIE2L4L5NIMCK0MxYp/VV/Z09R97cBBr72f/K+obok5Xo9mB84VTg+Fq+pfMpIB2DAxnRUdpFeyYBi0lxTh/N+0HY8gzRXoSFKE/0L+2pywqFKZZEIeJaN3QwlhKm0s8IW6VyeQrwWLRZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967587; c=relaxed/simple;
	bh=4XfgdEgQsNj5HDdvpoIIQ5wsfnnmQcTAYd//uRceoaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Maoizq14GZipUilpoDkgR5l6zGUJtiMLyYcH/pQTCtjubicIj5+lE0At5rP4+ILnzyRbjaf31z2KrGTIGmfTpjhJ1SVlSO2kRLAsQO4tzz7T/copOaUW30EYE4QpXIuZ9l00xDVzOYU8Y1APZtsVFfV5pajrAmFwYPS1C470I5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=XH5EGJYw; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr+D8JwRDNhvQ2o5twcvwhuU0mDpbFceDudFtLaOLcKNDDS8JK+ioAiaB+840SAKIG435UXYKrtIvLe6GPQGgfMOUxGp6SN3fA8jBOJfPoH1d3mCXOA0Fb1/zSRw81IJFVrI71YHPeQ4Z9fMi5URljEGYxK7cxf+5NPAmpGmLibU+ziFBqryJBb/cZe+pbO2ht6vjd8QDErmoWi0RIqPvXeny4tP9wRmvkWCz6wo9IJgpLCWWwRuQIAV+96m30k13dJ9fhdFBagI6c6IlpYSYXAiCaGAyKBkjqG4lHrvY1P4X55owj3c+jyYfamcdsQY25VrRiQOouJHJRWk0Pno1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr9LoCNhOc7T9nHmpe0ZwhgvudZH192baeSZop4Hn6k=;
 b=uD1gSC5dC+tPAnTcsInj+O64kJmZagVdo7to/94hDS3VxTXDbMbD54TnK/Tvgre04KQ+K901YQvY/kWaALWUoTI2OUpEDSrTxOJHUQeAYg11u7coCWZ5fzh6e2O5WzZveria3xITDTPGPMbN2jUZ9XJIgfbaju3pjCv/1Nr4Unn8QLutSXCabfuqEI3aFz4dUsk8Udfvuhg5JMDClE23HDwn7drxyJZcITturxF34RvyZ8hC39a/zKb+Bew95Y2SEUdFnC55LfWPxnB2jB6g//E3ifJb4EvyT7gL3ZivHGg5FGzeiw6i4iTbtOfQ6cdc0evc5L22GNnL81s8wWGd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr9LoCNhOc7T9nHmpe0ZwhgvudZH192baeSZop4Hn6k=;
 b=XH5EGJYw/Kkoa04rWVjKJCNvyxKO3ny3EqazVGbZRooXlNcc3oLGHHEQ0vV0G0E+TWPCDqVbLIV2li0wEbmhtaej6buUSUUTqWdq10QTmGKEwU8R6lG4rW3RH1qJam4DhS3uIyYMp6Z3hPKwuu2IO5B+7LAagF7+odPlRB8E7EZ+3a6wCpLpofjOKydJy4KCVVmwqGCpEXK9IEuIXs7M3eK0aRYU4pzTEqmhIEGcpCP11S0MqQ/wMy7IwOdbIx2V/aO/b/7cZ3MmtYgQBd8Erx5o8rADtMpXP580vkIMQgz6acjbhqeGBUIRyOg7RTjFzS5s+4F79/v7CUj8DnYd3Q==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by CO6PR19MB5354.namprd19.prod.outlook.com (2603:10b6:303:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 06:33:01 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:33:01 +0000
From: Jack Ping Chng <jchng@maxlinear.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Yi xin Zhu
	<yzhu@maxlinear.com>, Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Topic: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Index:
 AQHcGONYZdoM3BaqikyKYzM9KF3Q4bR6E/UAgAQAW/CAAD2rAIABUPVQgAA1+YCAAr7WQA==
Date: Thu, 4 Sep 2025 06:33:01 +0000
Message-ID:
 <PH7PR19MB563690779EFD1FEB867A81BEB400A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
 <PH7PR19MB56366632D5609B0B51FE8939B406A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <8fa4504e-e486-41d0-9140-b24187626850@lunn.ch>
In-Reply-To: <8fa4504e-e486-41d0-9140-b24187626850@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|CO6PR19MB5354:EE_
x-ms-office365-filtering-correlation-id: b56c4090-5623-462a-96ba-08ddeb7ce566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+B24Dy5ujXSczs7It8u7m0z21fzHm99dhGdGDC6mC4ytS8iaGY0zaNT+oU4V?=
 =?us-ascii?Q?pNSe136aj4838He7/egWO/2YgAnP92CmH4sxdXF+TnqniK0oArBXTYO0nd94?=
 =?us-ascii?Q?NbTr2M7HXe4FzVpvBJc1Ke9Op+k0EijnUayvkM8ZTtfTD6eM+MGC1ON1hDXT?=
 =?us-ascii?Q?BFRNcpg/QicltV1d/I3ZHJ6IEc2AgzQuEpVEiwAt0A9XAZGzDsdc/s0AQXDa?=
 =?us-ascii?Q?GwhvBvFJ9x64Yi42jXIyO40GvpRE8IkI2T1UinnnaQVaCuQjQ91+CLOyanWT?=
 =?us-ascii?Q?GFI+mHjXwOK/ZhPr6Adaz3FiFN7ipsjs2oaG6awu5aquoUdLSQ3Ql5mFGcOz?=
 =?us-ascii?Q?zKM55N4vDlKXIoR5csaUPPhSqx2ygzWWnRS5uEStztMT4Qzn9LFswmUxtPUd?=
 =?us-ascii?Q?gu0ENkdkAU8TWu80TMni56ctJtu3xwXUQuRwinlkkT7rBN7SFmW1bkQ5G0tQ?=
 =?us-ascii?Q?YFvGXE+gJnc8aYoSla/ja5aGjDNElJYYNeLjQtgtZVEZvxcct5geagmfhfzV?=
 =?us-ascii?Q?l3krz1SJi/qM68MZjwi6kI1+7RNWsPoxNkt6DJAW5rXrgZ6w1ZzbJ1I+VxMM?=
 =?us-ascii?Q?6ZiXEJDnGgvdehBNsPR3+W3E26w4B1HSfXawjAkPlI0PP8d3V98XxG2MvxgR?=
 =?us-ascii?Q?6m207Um1YTTwXEHT8cnC4HJVwT+SnTdAezTULc/ZUEEqD44QESCVSlxSIGky?=
 =?us-ascii?Q?RXvkxUVh7ouecFSbMe4PaoIr7+pAEQ3unI8qjJfyXWsnq2s+keHtnc1AQ3l0?=
 =?us-ascii?Q?6R9VbkZk+CSgN4GORRJaDrC+UUz1LFN1mF/qKyY1SnIyqIz4xqxKqrNDfGW2?=
 =?us-ascii?Q?xLUdyfBwNGVq9mK0Dzw1SCx1QCEvKmyHSn3+RNel8CxInkz7xhog+vJIf/y6?=
 =?us-ascii?Q?vqLi9RRqAXrMlLQFBPNP9rKb93SRHL1Ql8BBtU/I+ajYH2ZQkKGlRokxV082?=
 =?us-ascii?Q?Zw8YA72/EB6e03qo/eBvsAbjOotcZjnpP938z9CiQkjWQhIoltP2rm/jkEI7?=
 =?us-ascii?Q?M3+pEtLzWu5ZNOCNbVu7J5TZouzhC6FP4ysazrCduDFD93RYTr0UVwl+LSqG?=
 =?us-ascii?Q?PLPwFUK8LytWLf0D14hOsZK6amKe7p3jxD1JRXkNxAoHhFTRtAy6GJ7dj8tH?=
 =?us-ascii?Q?jOr9aKFLWNyvzCv0PMY7BZDBONK6nSfJKCn84+kPIQjlzLP5GZPAmqYIh0+W?=
 =?us-ascii?Q?+YRBZ8dDF7UnAHZ/vfptUfL9zkauoN9sdB2zJT6HbmoS2kyno2caZFntJrVK?=
 =?us-ascii?Q?UP2hRM3NlMFfZ1+Bs1yBIshjDtOLDtaFfuXXKya3IHX2FSHJPIsK0sEga1Xz?=
 =?us-ascii?Q?o1WjRt5oxbriHglLhM6k46YKbMBG6dhbzMDBm9I4Cu2I7YhsZmfxNN7Hv+b+?=
 =?us-ascii?Q?rhGFZd+U3vsU8uhDFaAIBm6GT7sKjbySvsYORY2d45PTv/pC4ISZKgGcUkFI?=
 =?us-ascii?Q?B6WJ7ISnG0g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AnjoyTGsyyhjBiAgQm0LVRqXdlo0LvZYmYHBWhx+R5L63ZJBkXMPjfmVgDUC?=
 =?us-ascii?Q?9ixKVthsOshyhGE4zi+zsnVA1iM6OBjMAy39arB4ZPWypFxIWz2Rr5T6Gq2v?=
 =?us-ascii?Q?s2LboFw5ZvmotGNz76bCisXJkbF2dipct7GktYtW8PnmNmti7fkBbJ4ZdAnk?=
 =?us-ascii?Q?WoFeeDSbYy22/v1YPSJdO5UJ8WYFbV8mWxx5vrnTepBQg2n3wDY+y/lXT3Cu?=
 =?us-ascii?Q?HefTf0wHut85A9IOYSgjkYTeaBZDvcYNLqov6O5+nVnRNU+2E/AGX/Lm+VbK?=
 =?us-ascii?Q?v9Qvp2tSkpQP45+qFYW+W4YUxoHiHNagDcawbqOX2GsUxLwISCm6oQNtBq2F?=
 =?us-ascii?Q?K6u4haKzMYARrVEWl0D7DM8oFkcd5qNbKE/baYdbTv+bYL37Q3dBpdpSEQXz?=
 =?us-ascii?Q?rTDluUipVbXxVGfV8THdyXsCAe7sYOAjEmPf1EAo9eWzNaZR5pn/ZqIFyZDF?=
 =?us-ascii?Q?wp75zBOL2Ob/dzJ8ew3wuNpU/Ai3rMks8uYBWm3fXRCwMQoWwxV426FgQHCG?=
 =?us-ascii?Q?FNgRtm0wD+ZajdiNnrOlhm0YyirU6mzUnmIuvcfkT73FO4CHlakkZs3mQ49M?=
 =?us-ascii?Q?bFXvJ4RaJKtATnlbdLiuvW2Q9Xit8Tw54wrcPuP2cdmHbZLs1G2UCIbOOYID?=
 =?us-ascii?Q?bZBKIi3DEI0BLWGB2VAblcOeKQncNZ26KnVcFgFXIJtXBWG8rPqCLkLF/6B9?=
 =?us-ascii?Q?e+6U+h2MO3hVThcdd5mpbfcigkiNwd4uFHTfTdGguh95KMjPXdBk7TaHJ9cL?=
 =?us-ascii?Q?E0wOQQZcsdxbazfKoJFDupdHaL9L+cKY1br2PmfOs3a80GEDOw2cGiKgH+Ai?=
 =?us-ascii?Q?T1jgaxynUZYgJXXFnV0F72RpF48d4TFSp45UhLbgIogGcpo5g8vEqFn8Uu+0?=
 =?us-ascii?Q?D75DXexu2+8ykBYaewRi3reRN1uQutrz8svvipXoeheOocC4V5SPZjpqnvru?=
 =?us-ascii?Q?dxpxOWtk5OGHqClgLKYW2iWEiOzC6Racm8J186AktflpK8wlxO3n98QhLcE0?=
 =?us-ascii?Q?bbi1cvkBgiBbEZrIw1Xvj+8Hgn4JfnRzvr2bGG6V1PfGZya7GZiHwgfCoWyx?=
 =?us-ascii?Q?VZeudVT0HHAkyh2LYEToT/GuOKToqIRKQJp5SnC3ABYzcBQbZ/FVNjM/IJBt?=
 =?us-ascii?Q?ITzChJSqg3cVpYpeCjGllllYjEmym3dSQShZpqEIqQzH08JeWjs2EKGcwS4d?=
 =?us-ascii?Q?aqHiityRrur7spI6ofLkKZ0JuTVRKnQ5JYOWWdpCCWvTCY78gDnikq/hFp7Y?=
 =?us-ascii?Q?trZ9IY0rMHlylyoRKpJhKyVZFy5DPAvqq1/9SWJ7zWYLBl6XDsiFFE7zbzQh?=
 =?us-ascii?Q?Efj9cPlN/U3BmlhJuWKwIvLQinAyrkv0LVT7jpM8IAbbKJcIehQr7Wu0rK85?=
 =?us-ascii?Q?P9AslUcD7EODtOqA18COWGA5sl/fGbxSycJHqAFvkGpbTL6bF76HAaJ5FIo9?=
 =?us-ascii?Q?gF+tBjTvrVThgzWF+51F8kbbfOZWoqwVRKTDm1yTyZ/1pvTkEeE6l9KZ4z8L?=
 =?us-ascii?Q?oUJNONjGZiM62aw+mf3y+a+GC7x34Li156mJFRTzB8u3tlObebKM6/wHjkco?=
 =?us-ascii?Q?ycUHA5px3TKfCrgmmP8tseBi0HmIGX39qE5o9ISi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56c4090-5623-462a-96ba-08ddeb7ce566
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 06:33:01.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQf6xUj1PmrPkz5bt1cVsda4jo2E2c2kTv/FJjJ6lx0YriyQS1V2TJIbU6Wq9hTCZNyk3iudkniWfV4o9yz8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5354

On Tue, 2 Sep 2025 14:30:19 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The switch core hardware block is part of the MaxLinear Lightning
> > Mountain (LGM) SoC, which integrates Ethernet XGMACs for connectivity
> > with external PHY devices via PCS.
> > At initialization, we configure the switch core ports to enable only
> > Layer 2 frame forwarding between the CPU (Host Interface) port and the
> > Ethernet ports.
>
> So there is a dedicated port for the CPU. That is one valuable piece
> of information for this decision.
>
> > L2/FDB learning and forwarding will not be enabled for any port.
> > The CPU port facilitates packet transfers between the Ethernet ports
> > and the CPU within the SoC using DMA. All forwarding and routing
> > logic is handled in the Linux network stack.
> >
> > LGM SoC also has a separate HW offload engine for packet routing and
> > bridging per flow.  This is not within the scope of this patch series.
> >
> > > Are there any public available block diagrams of this device?
> >
> > We will  update the documentation accordingly in the upcoming version.
> > Please find the packet flow at a high level below:
> > Rx:
> > PHY -> Switch Core XGMAC -> Host Interface Port -> DMA Rx -> CPU
> > Tx:
> > CPU -> DMA Tx -> Host Interface Port -> Switch Core XGMAC -> PHY
> >
> > > How does the host direct a frame out a specific port of the switch?
> >
> > In the TX direction, there is a predefined mapping between the Ethernet
> > interface and the corresponding destination switch port.
> > The Ethernet driver communicates this mapping to the DMA driver,
> > which then embeds it into the DMA descriptor as sideband information.
>
> So, there are not DMA channels per port. The CPU has a collection of
> DMA channels, it can pick any, and just needs to set a field in the
> DMA descriptor to indicate the egress port.
>
> > This ensures that the data is forwarded correctly through the switch fa=
bric
> >
> > > How does the host know which port a frame came in on?
> >
> > On the RX side, the source switch port  is mapped to a specific DMA Rx
> > channel. The DMA Rx descriptor also carries the ingress port as
> > sideband information.
> > Either of these methods can be used to determine the source switch port=
.
>
> So here you do have a fixed mapping of port to DMA channel, but you
> don't actually need it.
>
> So this sounds a bit like the Qualcomm IPQESS device.
>
> https://lists.infradead.org/pipermail%252
> Flinux-arm-kernel%2F2022-
> May%2F743213.html&data=3D05%7C02%7Cjchng%40maxlinear.com%7C85f1f75bab584d=
678edb08ddea1c8
> 213%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7C638924130370008536%7CUnk=
nown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF=
OIjoiTWFpbCIsIldUI
> joyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D98FRlgiORUVgvaJX1Q%2Bmrwwfq%2Bib6p5CxRPk=
sa%2FhFGg%3
> D&reserved=3D0
>
> This never got merged, but it was going the direction of a DSA driver.
> However, you could also do a pure switchdev driver.
>
> The advantage of a DSA driver would be a lot of infrastructure you can
> just use, where as a pure switchdev driver will require you to
> reinvent a few wheels. So a DSA driver would be smaller, simpler, less
> bugs.

Hi Andrew,

Thank you for your feedback.
To clarify, this driver does not implement any switch functionality.
Its purpose is limited to controlling individual MACs, without support
for bridging, VLANs, or other switch-related features.
All packet forwarding and routing will be handled entirely by the Linux
networking stack.
Also, we have separate Tx/Rx channels mapped to the interfaces we are
registering. We also have a separate packet processor engine for
bridging and routing based on the sessions.

Best regards,
Jack

