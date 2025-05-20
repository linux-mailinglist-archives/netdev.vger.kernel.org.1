Return-Path: <netdev+bounces-191771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5FABD271
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA57170D63
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2521DA61B;
	Tue, 20 May 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Keo+lgM9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B020E6E2
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731369; cv=fail; b=gqb2OabkymOyRWvE9ZdUCIQmVfa1nLhFl+4RfOAth3dSdcTzpEW1aunnm26VLxwt4V3qIbZgtdvOcA3enRGYjvx7kJHbgiTn6bEJRCOBY1awwpXcRyaZ9WRNgsyP0o4xksIstnNfqO47YgTC69hCP01rmnfxy7zO7rTb3M0E/mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731369; c=relaxed/simple;
	bh=3keDxZF3j3Og+v3M7GZXR+ZktbqiwGsroSIP708rVzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6cdqVXvqWTD5SUhycnT2QsTbZd6C8/QFFH5xgDSfqlLKSjUBM+KshP2AXGcAwZwmklKHrZ/2eiuP9YW9wXJJy+X+JXsUMoDvGQgxbe+/nhYRWrZzpSiR4LyIuKuriqGxMhTkJWif1/9Qm5X8wgRsHyqJMTpeRO69//nC8KXRPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Keo+lgM9; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k90wxNIflbKuLlxI6Dv5wtc5+WTfrxe8t5KyPewEX2g+h0od1qfRYvEBZNzCcyJbhTNiuDf/7Kswp1PdHLSEiY5tHrB325f+Q8kugHq86QmjCiXgquoOBIhSNwRg0ope0m5IAmOK8454xQ+h8A+bkOE0rd0EqL9bwmE8jJsPrPRfzw13d1VEDgRF7G6gDaAp3rHEgw9pbMDOIa8lReDGWKQwtIFFh02ML3sOsqm53Esm5Irl/U5c3RUaFinEPo3W5Mc/FWra5u5HKS3JdeI+uop2iH0kjs04wy7YO0wBR1N4QoqFWwlarQD9S58tf90fWoHGiDBTuKCL9c+/0xj8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3keDxZF3j3Og+v3M7GZXR+ZktbqiwGsroSIP708rVzM=;
 b=laPrlrqp1acOvXKmixXEM8OKr8bNkb9+euL7NcHJzOtdaYiFxbySYXzKrpO2ksntQlowHakYl6KYOrTX/2FTOKR3tTkQhVHC3tXagQJNehUX5TNeXWHvmr5YkelqfWOx8Cl+X0l2Tvwa8HkcD7vEq8qFlpdFpBpTYXazX245zmGos4weusiVHXYcfOp3m/nMuOGnb7LmuUn2Ua9INYUklaEzvr2eCr8a8ZTOKWDGbMqudTmOlOYSHUdeQb5XNHk9j9es7HmyXFZcsnw7KeAFmLCpUgDs/NsZioEe5obtqGNNEJisBl2xc8ysqjb4pMsTcqCT9rKHybSYTpdPvE90sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3keDxZF3j3Og+v3M7GZXR+ZktbqiwGsroSIP708rVzM=;
 b=Keo+lgM955rTYOmM2BsgX3/6APhlV9kcCkJJb8JJOA6bYpqvWU5ojXeeXaaPG1r/Xf6wc9bpqPYR+1eMiKr6pKpq7A6GpDssJbCBA0FoKXHeRxDF4xJziUbdvAxGHJM4by/MF0hzISlfR3VDcHwemvkLjlu7XKohdlfDlkIeyE+G7GZwuJglywM4IH7Vh4eTz1aLyP9rwAmg3kUYKXZx3R9GO2AHmBPeP7qQlf/DaeZ6pZ6nDsN0sXlr2b97mtQr40TbxSsfs2eqmF7K6JZyyMnYleia9NQSybRbVYcVthv+cMFQPUqeVLbxE0wH/iJawt7Pjc0wzuhGl6iMbEpPOQ==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 08:56:04 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:56:04 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
	<kuba@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] ptp: Add sysfs attribute to show PTP device is safe to
 open RO
Thread-Topic: [PATCH v2] ptp: Add sysfs attribute to show PTP device is safe
 to open RO
Thread-Index: AQHbyNL7HHJXLHKnvkmIZinMVGqxfbPaG3+AgAEaHjU=
Date: Tue, 20 May 2025 08:56:04 +0000
Message-ID:
 <DM4PR12MB8558BD9B9C6E3F92981B286ABE9FA@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250519153032.655953-1-wwasko@nvidia.com>
 <2025051956-pawing-defrost-9af3@gregkh>
In-Reply-To: <2025051956-pawing-defrost-9af3@gregkh>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|IA0PR12MB7776:EE_
x-ms-office365-filtering-correlation-id: a09d22a6-f420-4ec5-1a66-08dd977c2718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uGw/jbB+AXxXgOuD97hIHapgDo3tPK6ao0PZFkk57SpV5Rh7Xdr9jLJtc2?=
 =?iso-8859-1?Q?tGSd2etywF+LnzOHoCxEtMk8o7shOqhW8NVFSN2xWN5Y+gKMsxsPqOH7Cg?=
 =?iso-8859-1?Q?qmQ93p6Vxmn+XO0Qa8N2xNMcscr0Yc+k/KOvzj7ZmdsL5EzclmJYqnkCdJ?=
 =?iso-8859-1?Q?V9TURKXROYfQ80EY6AHRt4adLzfUbiEarAMNHfVAtBYgBEg4pCku6jq4lc?=
 =?iso-8859-1?Q?umDoy2uF/gV4WNHEXC81WoFc3o4VNZyyfhsou0AxE6TCkc3zRNLA/ICo9g?=
 =?iso-8859-1?Q?rUFvi11vs6xvAR+CZqzc/dUyFL6w/NyoIngBuD3/aXzKvkgGEPREsJW1T2?=
 =?iso-8859-1?Q?bje5id0g6bC98hc9OdFhtxdNc/5a2dPrxZ7UACPeeOlyB+dF8QcUmOY8VF?=
 =?iso-8859-1?Q?auTNyPV8KfquYFOOxQYBEbM2iGw1W+3CHnlkc4cAMWaIu9XWmjAr8Vb++3?=
 =?iso-8859-1?Q?Irwr9tSWdFizrvmIdy5M9srgVPDwSlK9Qss+Ej0vaihvF8i7jqgjkeeKoj?=
 =?iso-8859-1?Q?X7HaNZLemD7AzshpFQ/MobyhfakLBlqgTOeMrL1/MHhY0xdA5h3gdj2gXD?=
 =?iso-8859-1?Q?pd84nitChGxCosPQkcJWGOxTbUII2YyxM+koMrRv5i/ZJKdMWXdWOwXDkn?=
 =?iso-8859-1?Q?W004PCtkWGDh87t0StCtS/d+yJg5JZ1Iic0annatKYhaBgjtwqfwF39b8j?=
 =?iso-8859-1?Q?TgN4BZNmuj+hD6GHumm5B9W9C2XWAcSZYZYqz3jc+WYuFMHgaMRy5wL8kR?=
 =?iso-8859-1?Q?/oemUDmyT1Y5p8Z4RD0o634kmVpEYBWc8Rf0vhLIuxL+Gwn9niJekq6dRF?=
 =?iso-8859-1?Q?JN63bA27J1aBzXwsry9udjH77mH+0WltozxQpnCadn77Dl4M8dr257sK3G?=
 =?iso-8859-1?Q?70p8J/ab6863GoOq+MzVrQ/j4sBAS4O7w+VnNEY68cJhkVSDbXdpPdfp7u?=
 =?iso-8859-1?Q?JONGFNrC2IzpLlzOoq0u1r0H7vpXnau2Hntt7xxdJLmWWYawX2z3CWf1Kd?=
 =?iso-8859-1?Q?siVYnZPzDcWsGxuP5Ilh+L/GrQCjqzUBJsgDOrCVw1gaJCmPTMw5Tnswem?=
 =?iso-8859-1?Q?pJI+CDmjoqW0cwkMKyHKx1OUY2bDlx6JVjDvKmG57cMD9fY7zptmBfsmbY?=
 =?iso-8859-1?Q?JqdysxrD0GQrUNE5jRY8V5XeHdRajguBK0V6XP+Lr9Th2bXfgYJXoVbsK3?=
 =?iso-8859-1?Q?hGSyDHi5cxzuRF5A4V6gZ3TBcXHFb0/eX1bgdM0E+JPRx5wywykV2IwDOC?=
 =?iso-8859-1?Q?HGBPCcfakHX63NXgw8ai+26BJGrhQhsd02V2y5xBL6vPQx51rcr2ervExI?=
 =?iso-8859-1?Q?P7rJr0RW8PKgtjPmAGJKr53gY5qmMpZ/GqLT51a8Qwz/iJEzS+6h01cAyF?=
 =?iso-8859-1?Q?pc4AYofm65gXA5RgCIob/j3Zdxc2SSULdMbC3oGnfnq8pyjQpNQDjDwryT?=
 =?iso-8859-1?Q?3cLFAYjLxUuP38NVI21yrcVV+YAobdmAJWdBeX5IiW4QOqyrJM+Q52oEAn?=
 =?iso-8859-1?Q?6g45VU2B21x6aIxbu8aSdJ6U//C50X6MpOJZWhBDhzQA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NGUt85gSbbrUanRHu0XljUdMGlTQRR+HEwIqxb5B9YY1aGJwpw6At2J9hl?=
 =?iso-8859-1?Q?c+FtPVf0+EC0O37iFc0zLL94ZzirVb3x3z8wzdha0rsbrbtkPPQt8cr8rF?=
 =?iso-8859-1?Q?2Bdasaiv6eiOrT4gutct//MPOd9oFaZp3MdNg1jZbyxpcUKfWpBOWQ0MBs?=
 =?iso-8859-1?Q?AXiUVU/bWDuNGh8NME61k7A8YAcnbRxlSmOYBOBzPF4+jmEZqvrK1nvfmf?=
 =?iso-8859-1?Q?jtj+ms8WaLHvvMeNwHHezcQF8o/tE5ml7y6RJ6L3GoMyTzG96dh1vt+pKQ?=
 =?iso-8859-1?Q?avC2tZFumzKPQ3DEXMbs7K8GCabnSVa3Fgii0VUP7WoaBnIFMxEawjdznP?=
 =?iso-8859-1?Q?gaEm+uhxXDIPoFyYBGHHIjzRvBRipxFi12cRKg+P3z7K24JTnyCQTgX6Yy?=
 =?iso-8859-1?Q?isAevoksCIVULPKkR0ymuAX4KSsripp2/86fqsLOuGNIAk5Whzg/h4949j?=
 =?iso-8859-1?Q?ZsMoyDJE2svbjVHFvTyLMt409yhxvgPv1sX5oCruJqTVg9xOm1SalXK6si?=
 =?iso-8859-1?Q?5Ln9/ZvPBvgKiu52Ns7pFPvuth9OSNU4PfAQ0S1iJn2bBKHk2St/ItuWdT?=
 =?iso-8859-1?Q?qAIrAcWbkc+kkT5BoS70bCDbrHEj++GyBsgmEgOy3AeW9rDPCh5uM9SBW8?=
 =?iso-8859-1?Q?Du9eEHmwoosgz/xjazlVrMFyPECqIcKQVWcW3PvjkrA1Gec3u9PStwh1e3?=
 =?iso-8859-1?Q?JhmTKv1fU6/F/fpM5dL3Y+VGVLp8Lu1J8Fxx5I/AGHDuWUtfH24pmmFPpo?=
 =?iso-8859-1?Q?taEOn1St3eDtqRARJ8dh+mAOn3zigbOSiWILUrZX8f3MdDc+6VBDbU4LaL?=
 =?iso-8859-1?Q?cOndXvfAV/ZK8dHZm/nitGXS3sTSOC++d/8b7KgBPlu3zixR6Li/qVE76K?=
 =?iso-8859-1?Q?q8cwz5LQn36hlt7JT2/JfhcduO6JXf7FQ0vA1XJXlDzb59xrUOFQRjXlU7?=
 =?iso-8859-1?Q?OO+zkMOXCwMh4k4GoPX6ktb9K6IPiRq32Q9DJJnViVTSvbIBah7ckTOT5D?=
 =?iso-8859-1?Q?fJ0OKYqWcYEQl8ln8iybo6jQcm8WAVClNrtDl++DuWXvTcrs8t7Fljytks?=
 =?iso-8859-1?Q?k+wYVlB314dVB737iiKqtuz3q+daDwZQOWFoAU0rlasC/nUd2TPFnJhMcm?=
 =?iso-8859-1?Q?Y2W2rqrhsjFB/kqaaZLAkG3hUrS6uu8dhHTiyvXZ1sX2kBxRQ8Nyw2cPGj?=
 =?iso-8859-1?Q?Gwg97IXAoJcwSeb9Fzi5GC2OU1xvYo2xc8PuetV5Pgtj5W2TLv/lGrseNG?=
 =?iso-8859-1?Q?2MTtprnRxuaG1i4NVbTm1qwZTxX7d0GWx0HPbICjnbY5TGo8Anr7cmBpRA?=
 =?iso-8859-1?Q?xGXYs5WyqDf+gZ8HgC2yxYvEI8iAQOYOQ2f9T7cMFsfrVKy73bRq3XoIf/?=
 =?iso-8859-1?Q?lJcwOVcNRgOWI3PBwX3j5f/IigKakWXmFOnKr+XaduJI9G/feh6Z0v/f9E?=
 =?iso-8859-1?Q?77g9Wrr3PrHSEPjKfxtGIo6MPpJNOpdgiDAbtnVBoQB2NoxO6NykvcyH5W?=
 =?iso-8859-1?Q?GAlgOXF0Aqw8zadn+yqG5DA7dES5vCbfgJpk95Ysu+Lv3x86G1sLiEVQ/G?=
 =?iso-8859-1?Q?HZijUOYgIKXV2ipYhUt5HTxlaxYHmHv+xA80sN9EJJICGC9Oztl9wgUIzU?=
 =?iso-8859-1?Q?TYU6E3FeLYZgI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09d22a6-f420-4ec5-1a66-08dd977c2718
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 08:56:04.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7SGsX7qVdc2HTjfIE3Lrl2THGFgOxTdZ7ajb94mqlmhsuAgr/Ty4gAkZ65vF4xZdWpFckMO2jfbNyI2JryMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776

On Mon, May 19, 2025 at 05:56PM, Greg K-H wrote:=0A=
> This is not how to use sysfs, sorry.=A0 We do NOT use it for "feature=0A=
> flags" like this.=0A=
>=0A=
> Userspace should do something else to determine if the feature is there=
=0A=
> or not, or just default to "do not allow" if it can not figure it out.=0A=
>=0A=
> sorry, but this change is not ok.=0A=
=0A=
Thanks for explaining this. I'll find a way to make it work in userspace.=
=0A=
=0A=
Wojtek=

