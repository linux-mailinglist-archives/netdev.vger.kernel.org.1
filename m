Return-Path: <netdev+bounces-95154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6818C184A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0EB21276
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9F839E0;
	Thu,  9 May 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMpeDXWZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7B127E33
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289598; cv=fail; b=jWfX81o4GIKQ1sizJ6L4eCmRV/ipp5KZ3bnqITmz/LWXUwLb3k2tpJK7z9/wCypuJiITTqs+ZnEwOD60Tsnk/ddfl1b5iAD0DbRjdLb6QQEPpxD+jEwWstYfMimsxMFjCek4DS8k/91Kr/jEB+WgWjsYdgEUD7/AMxuqiYOvcVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289598; c=relaxed/simple;
	bh=z+QeduibeH4ocE/fVBJI1uCYH2yW6SIlYJBfOt4UNKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5Dij437Y4f+s30RZYXNuDj/Xr7JYGotOT7uQ/pMV73WIMLvgzmzlLcLABTrFQNBfiMGiHfdNe8YpzPtnaiqfzLSU2Ef88iVt3L7hNsvE6QgO0zZVymIo9oWyfGBJUiqPZ9w0cdB7jppj8Lkl747UAxrdDQxKFMlIxpDPgJPags=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMpeDXWZ; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyQCvTkNC0UwCHzYhJpvnCpV4LxX+k4efEO26NWMQUAwOF0VVgpeEXnUEx7DeZiPX5GaBfZQpQAxFhWBQC0VIkRsbMbNIbjN28oKj5QJnxdKeDuO3yQxRjFhz2mk/hShn5yUYLMe95BSlPxAXeDNzfeRe9xb2B5Q6lkw0Nin/wpMrJmp3miclmzrYtkhmas+MvxiZbN2xUzSG63h0ST2isEpY/xXdT80vDzq2EryIkiNj5a3hlFbQr+uC0FCmGmy6QiEnQcmkgy5MIIohxxM2jFdcIqjsXzCsFuY4u02S8fibny1uxfLlCy2X7jZjFl2wjo2H6BQcqna3smL9LiQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueVyPG0iDqnvZKn83uSy8k4oTMZfCVWF02n2LBcEIGU=;
 b=SjqfKoJ3BgJ8wlqxlvVGrllJmLI6BR6XY3/zY91vx2bQ6fm0q7n7MdFmRZ0c9e7HNXZ+x94pmdLU8XyE8QG//XqU3lSSFbVl5AQ3JLaiM+gCWejhT9Ib2nuSXOkXgEp4uLDoluXRxr4Tl38dfbAs2EmTC0QQ8QQwOPRJPX2rTVI22BY8XL+qs0Gjo74AZlC/eHT6+kDFi19fJSIlMhBsd96KWIbcVWqourxz11FcOR47YadNki33ppvZWSRehUpmC1uJCBahU1pg4kxCbD+hflTduV4ZR/OUqe8BWqiudvc91qR1R28euiEjBREjDoSMsHcJr95Qezw/fOlApvkWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueVyPG0iDqnvZKn83uSy8k4oTMZfCVWF02n2LBcEIGU=;
 b=RMpeDXWZWDjTX5xp6fx6T02Fpq28we23vUrFl9VEaAivLoMVEO33Pec49tZqwHpiO5QB9otrBoBY29syOMAsCE410NC2E+tq0Wo60rk+W1gv3+bphPwy98wgALhJU5WSAu+T34QtaMbq8B9GMfOkAG7pPqKON5mNnMRdEz3p5QOad6RJ+GUJ47bDoM1mjuyXe6+DQLXz/p1adHA1VUUUSs2nvxIr1sE1zJ+TqBnXK7mGD5YFrDbJAy8I2zOHmrfAe9jEDJ5czGHr+2K9ICqoxkDEXRBX7TmfBf8bu3ldJrGqyCyVSmog1FdJmLUQ43MXLT3hSk5gpHrOSlEVQvZjAg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 21:19:53 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:19:53 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Thread-Topic: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
 wake
Thread-Index: AQHaoi6KsnE7s0ArT0mYwn0pQXyMcLGPX5MAgAAHyfA=
Date: Thu, 9 May 2024 21:19:52 +0000
Message-ID:
 <CH0PR12MB85808FC72B8F48C3F6BF3A9DC9E62@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-2-danielj@nvidia.com>
 <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
In-Reply-To: <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|MN0PR12MB6032:EE_
x-ms-office365-filtering-correlation-id: 4cc8672f-b0b6-4ea6-1102-08dc706dc479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ybz/Xt4irYrcxP1F07zGwq9TZ3o5HGZFqpEeIC37GF4jnPJyQIzwVTUxxa5s?=
 =?us-ascii?Q?PcmxJ1Dx2az/W+hRRyUB4XEY4cv7se5X/gRzh4PvtKRRz3igkPbZQTaSu6F9?=
 =?us-ascii?Q?aHuZsaM7qwptC0vr7ldpP+CqGSDwuyJCAu4wXtwXZ5yje2+iStZeZO7chPi9?=
 =?us-ascii?Q?mj4iRlIQ2n1713XS/ScSUzno8fPmm8EJlpRspWvDpgZYlZ5nGfqNUB6IrX9+?=
 =?us-ascii?Q?29+KK9JiwIiQ43U99xQXBYzctCu2m9bbjaNoNme/KHxP/zClCOn82EgmFtDm?=
 =?us-ascii?Q?KVPfbo2HxMa3A/WbWrObozIt2lCW7kfZjXMn9ATBvifBf1L/MM/BrVy8tw5f?=
 =?us-ascii?Q?KVhR+WAqXg4qoBRQBr03tAbZmDfaVzhQvQZxHRVnRGp1xxZhXa6GziRcmZHk?=
 =?us-ascii?Q?nBheRBJQd2b2o+Bk3ETJljr9sub7phe4tq1IfxbMI9cMqxqaBsIe4Lvctqjf?=
 =?us-ascii?Q?9F+J7Np4LRu+kh75u0UbbW9FjpW89mRAIaD8A1NWv6cphUsLZb07xCTbkDbZ?=
 =?us-ascii?Q?FxXSo7G7ZZ9uCKuy46zH7WzRazIG95hx46JzkiBGSp311EhAcaPL2O39NwpV?=
 =?us-ascii?Q?OOxetCHp5bFxo8neUnc7gWMh/jMcRqO7j5+1duq/VejSw/+y3KpO/vM3q329?=
 =?us-ascii?Q?dI+THxYOFA+TGhY7BFYd9A78W19eODZxzHvglirskS33ITOk7yMVyNPnFQ+t?=
 =?us-ascii?Q?KI8hrJQSQSLHc4NEkZjQ2+yQc9IUQcuwj3ohWesWzPmgs/Q/v6YeVGBlB9lb?=
 =?us-ascii?Q?yUZDD0oijCk9R+ghvv202x0D+WHNGgL9GrcAGLT5Dx3YIdrFEYFTth5A5nVV?=
 =?us-ascii?Q?aelPrmxZtt0MD0doog5GZ7lpkM6Aa4DQBcVoAOQE1crZ7X0mB5RD/+odm+Qq?=
 =?us-ascii?Q?ftMw0Qg48TpTN82zTe/eSSenXm2a5cftPDfxiwTC3qG0vmRqMJ39gH1W88Lb?=
 =?us-ascii?Q?tEf/BeV2fFn3//xl9z4spv7jW/9h5XKZFXEZz4FjLIcMJzsncIqt/iPv3HZA?=
 =?us-ascii?Q?GeS17CZHAuIM96WVHi0YVruYHn398cIhJ/iDcsdgkqsFQ1ILEvnKalSnsHQ1?=
 =?us-ascii?Q?dbpCAPDHBnXaWxjpCIRwAGVvT+im6m5CLZbo2KkiSWNv9jfbvozE1NA2u9lW?=
 =?us-ascii?Q?IPwREHmtthUQNK3vxeS6hQgsL3RJM2vpLdZaO1JBo0O4aoBx71K20yD9d2gZ?=
 =?us-ascii?Q?ZnOntfvHzR3iunYZYnbtJ2Kxz1W8nF1iBheecg2NW2hLTGSwmb++NyUTO88c?=
 =?us-ascii?Q?s/xMcSK9Oq3YNqDJZ8qd8j54EuzeV/oYzJSMAf4jIpnCa9SyNWqZoKneiv5g?=
 =?us-ascii?Q?EheeubKjaVlCb6LMJezZrsk75a8m2qW6U0KYgrk9i8yW/w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cu0aS0FLsdBivJq8GEJFuy0jbqJuTACv+apqXMa1wunHQePH9kWOSvnHAgf/?=
 =?us-ascii?Q?RhaPux29lOloX8YMfrt8hx1Sa9TeM5VJ6SUQxHl7VcveFbZeGc9XDUN4ZIOd?=
 =?us-ascii?Q?yQBAxUeB6IrVNcQx/ZZQ5cwn+DAHArqTsiWsNIUrmDUGv64ka35Ws1Noyyj9?=
 =?us-ascii?Q?V1RANdmgY9pc7q6wMzMGsFZu/zq7eLxP1j86jop5XgIMOAt6t/EEPlNwUyYJ?=
 =?us-ascii?Q?CZS+Wu41gC47UQQj9OmzjhqFigPI6DcfsBCV/3b1hK9hKGXVgSmQcuKDexQL?=
 =?us-ascii?Q?6EkPol2/xsHWxusD3d1Kr1gplb6ZcRZ5FWJbaitjpF43aGZ8cXw6VElSPpL1?=
 =?us-ascii?Q?c+Pt/AwPDHDQ/r/fB5KSJMGaerFC0FWlzWOHUeMHCSmnaDS0K1ZnDo4FrB7p?=
 =?us-ascii?Q?wXRditQEVQB2Py0w49U8HsySDz9JDVJahJnruYsBrhAkbnj0qQ1rP0bKDylq?=
 =?us-ascii?Q?N+wtF0QgRsryGvQzN+oWZObnF6XE/rmOZF8y6Z9HHD+87OKTuilH8j0mrPbj?=
 =?us-ascii?Q?gaUuH4NW0nMBpJhyfJ6BpwdSjYp8d0WYRGNpsnWQ6wUbvb4pyxvQOiMYbYB9?=
 =?us-ascii?Q?upbxoh5gFPSl0mFtZpF3R0MKq4r6njUCdxy40tJ0PHGNq7ZcsU46yi1Ptg/N?=
 =?us-ascii?Q?KAsZjDd1xQm+jlgylqmt8ylIC0xkPDMSJpXo20P/KrdG0v2eKYv1MLXo4vth?=
 =?us-ascii?Q?ANKMTdEZ9u782vfu3trSZH71oPLaNtBspWFHhcGVj/HT/mep+W/WtAqnjx5C?=
 =?us-ascii?Q?jQsgkPbeKY7Dg7zpYn/B763Cy+p+wok9aHTYccriWYP4xKCJ9IE37Pc6GJgB?=
 =?us-ascii?Q?5a+o/dYqq4AN3MrcxD82QaCe6UaOa3wuKvzH9qOdKiHH8q6c5MsCJmfa4zPR?=
 =?us-ascii?Q?763DD/ixq0PZaJcXnby5of9Gxk1VuDXWQyj9APqtDKEEdhsdDE/JSMNeHcdM?=
 =?us-ascii?Q?9+FBkzju/uUN9yunlVaWzcGx1WVqVDuET22BI2T7whcVqjigNqkdwQlyWGBD?=
 =?us-ascii?Q?GVq8BVSxIa2ucqbsYTfbvSU09mZWzjl/VBFYxY7n5QNUwWTZ0xogZQA03KcW?=
 =?us-ascii?Q?3zavOZAXihAuBmk27AvIK4enU3PB9Kia+69maq4sevrYjYbd8N7paNrhuXpv?=
 =?us-ascii?Q?ulxvm/eJC7sF1V2qfhMAwh131cSFe6MgKwqh4K8doAgnP6Ih735BlFZXEySL?=
 =?us-ascii?Q?6dZP8f9nPsdtzkx1w9qlBB1+MoXLl6cO8Xvt6+TOo6ub+TswkgbaQBHyJL+w?=
 =?us-ascii?Q?4K3ATVsDux0B3S46Ypr/d2vaaZ0ZbG69scfJ2Iu3n/bCr+sWEfxea/ZLPecT?=
 =?us-ascii?Q?1kpU/WmpUXrgOmwtLXF7LzSLoyAj6c5fhYB9y0g0pmctD5SuhkJtUdYVuGJD?=
 =?us-ascii?Q?O+SWdHTJGId8ibtyWvkiln/hOisHr9AydJ8dmNSJ06Fg6wR8jo+68Fdmk+yr?=
 =?us-ascii?Q?olc++gqw3+KPscmGyCzysSsLekjtSbz0xEtVJ2GXyXg1zJTpqSlcRixa87pv?=
 =?us-ascii?Q?jP64EmO422jefXDh9kRCgvxcmrSPnE4jjK/p6vYAFig3/ppx6956lHu9gLPk?=
 =?us-ascii?Q?GFa629ZrzeSf4GE0ssQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc8672f-b0b6-4ea6-1102-08dc706dc479
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 21:19:52.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9Qj1UqozorAngpy/tGKLrJZWLW1A1+88n6XV3jd4pIH7n+Cyvoflbb6BQz4M7EJ5W+CC6Kfc+dFr40RyWOmqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, May 9, 2024 3:47 PM
> To: Dan Jurgens <danielj@nvidia.com>
> Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
> wake
>=20
> On Thu, May 09, 2024 at 11:32:15AM -0500, Daniel Jurgens wrote:
> > TX queue stop and wake are counted by some drivers.
> > Support reporting these via netdev-genl queue stats.
> >
> > +        name: tx-wake
> > +        doc: |
> > +          Number of times the tx queue was restarted.
> > +        type: uint
>=20
> I'm curious where these names came from. The opposite of stop would be
> start. The opposite of wake would be sleep. Are these meant to be
> opposites of each other? If they are opposites, why would they differ by
> more than 1? And if they can only differ by 1, why do we need both?

The names come from the API. netif_tx_stop_queue, netif_tx_wake_queue. It's=
 true that they can only ever differ by 1, but when they do that's interest=
ing.  Though eventually a TX timeout will occur if it's due to something li=
ke a lost interrupt.

The most useful thing is knowing if queues are being stopped frequently, so=
 if there's objection to the wake side it can be dropped.

>=20
> 	Andrew


