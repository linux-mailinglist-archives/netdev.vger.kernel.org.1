Return-Path: <netdev+bounces-209308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15AB0EFD8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B347B5C6E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80329E0F8;
	Wed, 23 Jul 2025 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ld/t2gte"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5523C50F;
	Wed, 23 Jul 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266555; cv=fail; b=HtX/c8E0gzhm5tPPJapRu8zfToxr9nc/Wst8UjFY9LOFBhWyX2U9yJPxRz2kvkHJlA2SVC//91ZUhJjXzgX9LTqfuaDRbgrWXc0UCWkpJme26vSL4lkFd9LH4SHIFQuaSYyyBKUmE7/I7LUo7jqQg/GRkA3t5vNP87sbRjZSmhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266555; c=relaxed/simple;
	bh=yQa10byD2mcIn7urxrxFgJ+MWRnG6LXvZdYhGCzCExY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U65EKoXMgwR1ySiI0n4loGTvpeBvhxqRsHmHmfj6rvE7wkhwC7DmOvyFWYgxC+ui5unnYXGT44plY0xDFRBG2oO+jDzz2rgWkZIiywmdVE72kmq0rUDSS74Magks+1Kc4JlRYt3CVl0SslLiyvbZ1l+VpoV8MvYydfLyD0Lw6uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ld/t2gte; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGhkjOkuMd+ZtfZA8m6XOxLn4fB3eDWGLHeA8JJ6uLO7dRlDk5T897QXeFfcxV8zZi/9AOXXxaBvfLgq/8/TLGuF8IknNKwbnfFKEfJyYV84or/QafV7TpAIMiVEoWHK8f2Uktr2dTxNgpXIy1qHoPeBAngi7gf8FS7S37Ex/RhtFMxO6ReDgVZUr7Ia34me24mqjxaeIX71eEiHXAZrbh0pzn3+c7c0qyJJTLNhzLhq0xCrFtv4uGycy3PiJyIiGAdLJVPvXFbnJx/GAl3G5JBMkNwtAT8+Wzy+YvqkjdAHOzt9sq2IEUKrUi0UV1HYR1exW95bgU2Aw2HrHLKPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQa10byD2mcIn7urxrxFgJ+MWRnG6LXvZdYhGCzCExY=;
 b=Pm4NzKVMokVOOlUmPKTgHDj5U0LkrTwIPhiBOW+zrsnSksGmY9Bq4DRs7njy/HVq0jxPthot7BV0yFelPb1W1saOpIRx3WjYtwrPU5dcU5k0cObKykeolv0Y/WMe+5GZ7L+2aJBgRmsQD/Ez3gA4v9OAwmAEq8ZA6c1YN0hioZMzhctTAFRARqVY2bssWEM6I1mbfZBuDrDKCr19NFKZVT3Lwu9r8JhMt3QhzuPhWbt2ybI+oKFqS83GmdALR9b7e1J9HRyoplgsqCvL8TXGtdaLMzYEY5BmOGY68vucasXnkgQ+C8aeoU/lJaj/Nub+l6vckrz/tzl1QL17Oh0U4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQa10byD2mcIn7urxrxFgJ+MWRnG6LXvZdYhGCzCExY=;
 b=ld/t2gteAx85G09bIBQXq8gYMT2Kp9kAlQq/+xXJbFxZ5vARWGxCAIu9gQ+QAtyBxdi09bB+b37GFQ+4qlOt2r0VlzdTxeRewK16ryEEiCAeestkY2GkgNQqHNfZEt+3mQrSL5d0p2jBmLsXOQ/FJ4MUtYxV3Bn/uZ9Zb2SpeXjcXC3pdYGifrNMDXNy2MzwLUxiwcjfI1ycZflX+2zxMMcEh4l1c/9E90lo/usX4Lkvum2umeXW5DzN1Y9UIwZ7jRN9sTLcTbSsM2+R/d/d/3eqSvVYkjtWrfwqVDWyUjX241JJRmFJlbCWfa1Ok3b2buow+sbtEr41ar0mrjOqHA==
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com (2603:10a6:10:371::5)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:29:09 +0000
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4]) by DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4%5]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:29:09 +0000
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"n.zhandarovich@fintech.ru" <n.zhandarovich@fintech.ru>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"Arvid.Brodin@xdin.com" <Arvid.Brodin@xdin.com>, "horms@kernel.org"
	<horms@kernel.org>, "lukma@denx.de" <lukma@denx.de>, "m-karicheri2@ti.com"
	<m-karicheri2@ti.com>
Subject: RE: [PATCH net-next] net: hsr: create an API to get hsr port type
Thread-Topic: [PATCH net-next] net: hsr: create an API to get hsr port type
Thread-Index: AQHb+7fosV4yMl9lt0ysQiXA0LqHJrQ/e2EAgAABbDA=
Date: Wed, 23 Jul 2025 10:29:09 +0000
Message-ID:
 <DB9PR04MB9259A60ECD5FFAA71A0509A2F05FA@DB9PR04MB9259.eurprd04.prod.outlook.com>
References: <20250723100605.23860-1-xiaoliang.yang_1@nxp.com>
 <20250723100608.apixcv3ix5rn7ydz@skbuf>
In-Reply-To: <20250723100608.apixcv3ix5rn7ydz@skbuf>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9259:EE_|PAXPR04MB8928:EE_
x-ms-office365-filtering-correlation-id: 7a8cfc2e-f107-41ae-10b3-08ddc9d3c29a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?skmsSLbVquQsVkqV5hgnCKNpigSEz9tnHOAXtGDwfjTxs77CtvhhlFrNHUx/?=
 =?us-ascii?Q?D1KSTkxx2yyX9jFRFlMikRqq4YrEyHkJL7ZKUcvl+16poCtKgpG7Go2xjAlV?=
 =?us-ascii?Q?UXsWzqfBF5oyBWtIM49Y7QnrsB3T+mqo9nOS1pFFyj4Rp47wKtjaCuksGe+w?=
 =?us-ascii?Q?vmOod2B9/w6EEs+tzxUrAGwBH5G0Ki4nnjyet79r9oYnbV88qD/IBOXjOr+0?=
 =?us-ascii?Q?PdWDlRYDnYMJ8k4Zs6x8usF3zOaZoEcjs/NxiC2gdI/eCn3hMjY/314W65KP?=
 =?us-ascii?Q?s6HLZmLqWZRVrhbj/ZjxceHAf4RQ5Bz5yDvI+det4bqRB+PNPgqGNmq2m650?=
 =?us-ascii?Q?Nf5CbrEpMpJUrMg1T4zV7yBMJ4NYIuny7h1waPPdcDJ+0rytelIKhhByz/Zk?=
 =?us-ascii?Q?EybWEos+ljVneoSKhH8U6VKgNK4RdREPabIZnDDVh60fz70RTrtOKD/eO1R7?=
 =?us-ascii?Q?FWgl+3+sx06guCykUWilnRKqQW2QIkoTib2Zv1y1Hu7TOH1MGRGNPWJxjrag?=
 =?us-ascii?Q?8UL+JsXsdWK1u3xHUb/QYxjdJBYMEWATtSVtx0hthp6LYPo2ZcbGn4JyyEyK?=
 =?us-ascii?Q?M+4qw6PrVZTxQ4/dAIMxTr8E8bHSI+aP9XMrhnkhT43ykydXTQ+V2dv2aTgD?=
 =?us-ascii?Q?NNBnmyN7Po+A53CCosp/+cZ4MNM19r5h4/UvLJgWr/a81DreZgdxBrwe7xRk?=
 =?us-ascii?Q?mpSVcC1eYphKHXYK5A93lSGNjxKN055foH6ljKnnnkBbx2PlVhHXRQJ33iib?=
 =?us-ascii?Q?XUIqAjpoRNzAcrxvpUtSPXBXq8uQJkWERMF4ik3CIGXy3wbq+jZ4B0HTD1PI?=
 =?us-ascii?Q?OBwzK2ANxP6ynp/mbyntBJ2+lAmX+piJmUpiIjK6xLF3xg8oCfa7eTTW5uBk?=
 =?us-ascii?Q?fp4+Ww05jFdbEAgeCqaror8yN+WfTHlwIWbXQgFFPo1ooQeg/ncE8eViRDXv?=
 =?us-ascii?Q?PNsLoslAMlNJWcR+M6sku1rZwIFLFqOKhhh/mSc9hcwuAx4RbQdtED3on1hn?=
 =?us-ascii?Q?HpCovNpJKuTddzKJp/+l6gbCmJY/wwio9nV0L8UqMrOsd84iN25ydLI2368t?=
 =?us-ascii?Q?1iotTXWwYMj/BBfvYpOdYErfg3WZOgrOu8n9DgW4yXDCsIaorScnFJt5A/UG?=
 =?us-ascii?Q?/OiPPTc4tXh8zaaOoo0lz9KkH2MO/yjE0KIoH5TGfdgCDkuKRc4iyzrv2o2X?=
 =?us-ascii?Q?lvg4sN9Wn/OpD2WQr9qWJR5RrOlIpCxHxNdvAzI+coM5jUYeviGsOnWj8A2k?=
 =?us-ascii?Q?3lkk50YcY1QWZemAhWlXQGXDw50WTO2v5xt8+WMpDsdYm574R2z7Z8vCH0zV?=
 =?us-ascii?Q?oSJniVHVoFx5lGbR4uIdlhf4UemVh555gS3CAAZ9iKr3lkhwwmQ83Y4hIrpn?=
 =?us-ascii?Q?lrhTDfjB68LKW/EqInkbFWeb9drIc+DkUF8fU/1E3wupEnHJ/5vgCZy08w7A?=
 =?us-ascii?Q?lVI6lYMErkY6XWO6j/ZIARFE386cS+KTMkK09dkOCP6wnzkmDMpeRA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9259.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wZF220+xDVxOg2zd8HjdcoVQvsuaRka/AqN5c12Xxqfxcri5kpV8D1d8R9wH?=
 =?us-ascii?Q?23LxtSPQRDanfEvnCfnY9+fMYNbRlf/2cElHrdxMwh6+DAubok1m/W/8MNqw?=
 =?us-ascii?Q?7ejaQsp8kh9nUZ8iQ88gUow5z9PARRv2F85fTc2KhMNEPzrvTQ83vvwvkOok?=
 =?us-ascii?Q?NR4nT90EzYHxuiAdgC5V9G4YQ3hCOxlYM9D8MrMY3wDqaZgugwrW24gBdPBb?=
 =?us-ascii?Q?S0RDt1NlI84wjDq09auz/aA3o3OROewSVPLBkrUhTVBQmkhVlnYGIGoqbdzN?=
 =?us-ascii?Q?kXdDbgxygKMRH2ZfHl27iNuCNHkLtvK4q2MS707PUmyY0tE7oiiAHBWw8VgA?=
 =?us-ascii?Q?Fe54CiJnLzYSfb9n3j6pgFAYBWH2ykTCbC4AXW0Dnj36UKRYzOadwn9HE2ed?=
 =?us-ascii?Q?NwAwI5RXUX4VM7JO0Hqu2eugJGGI/XoPgcBM9YBpJLep98RXxLcTr8EadnEW?=
 =?us-ascii?Q?glK6vyH99RBgRk+6keW8n9ost3QzkeR3c/cbRRgt08P2Og3e/Jk6+Ae2lczr?=
 =?us-ascii?Q?hK5yw5nCM/S5iaKXUBXyZdBNP1ALbi0hy0iK/Uua5leuBjXT8FCUGrAKfTEy?=
 =?us-ascii?Q?qXwkveZf7nmo1pyYPT+Ht332gm6awP9bEEa9t27gHYNToYQ1ZOxIKATQjEkj?=
 =?us-ascii?Q?aqxKr7roavZgR9EZt1dJ7vkZkzThQBrbKz0Pbo8vg6eIGVe8HFfELPjzmHW+?=
 =?us-ascii?Q?1UVWJ+bU4JSrj7DC53Kg3f3H1jgMO/JTRlEIspYhLO9ivc4zHCiDFe81EF3A?=
 =?us-ascii?Q?kW1xcbtTuYYsPXJj29gfuFvfTr3XbsWKTWH2K2FfHm/VCTAWidioP343yAPf?=
 =?us-ascii?Q?Cdy8t2ftBgN0BXuppuk+dKnUffBsfHycrDBv72DZRrdAJjh2d6i3ZqzPBCmm?=
 =?us-ascii?Q?3TwJ0u+aTOf7Z48uMO6PIHWjtxci9+Ibm62lL+SG1znC7NLNvf5bM8ZMmNSi?=
 =?us-ascii?Q?mYAZ/RchSZu3Asz2GASttyR8Hd3wJrbuNKMntqUd81q25f4FuAyBJvCdFsaK?=
 =?us-ascii?Q?ZsZq8xWgOZvhxpTUTyqRN5mAYg69cVKmm6VwzthR0mH8mdRzL+l2Nmwk85Qd?=
 =?us-ascii?Q?r0Izmzaqr1PrgoqIXHSzjfc5Wy9OtvWs2KTkr26dSdtxQoXP3zehHNFWHZMT?=
 =?us-ascii?Q?ZSuZ8tUAvXnbdgJLQ80/2mjaPj9Lx7Gys2eNOpwdwgCtUsuZFe+aVeh36bGH?=
 =?us-ascii?Q?1lhpy/MnUc/m+uETpa3PE7pEjocspaxW80teQhiGfgBuU7ViIBaIiXG+EHOY?=
 =?us-ascii?Q?czS8Oh5JcEZWu86hy3Z7azK7k6OlleX2ygONgiCtCgkV6KrX8nq4UV8+i02b?=
 =?us-ascii?Q?El9zMk0Bi3DJ3eZEx2QpVoaef/sxy5zafVBeJ1J+hntnjw6EiQ18d07t3z9+?=
 =?us-ascii?Q?LNNr16v/7NTVdPTuGyToYXpnnXg9eqOrZonetp6joAt3k17+mwKMSpK5VhQS?=
 =?us-ascii?Q?nxfATwiegsO5hNL9JjntCU5AmmQtlV7wzCR1USIfrMDfaGO081Z1ces/74I6?=
 =?us-ascii?Q?eJ+1a2vfQf/9JonhnTpJ7seieFypx6xBE53oYIu1w5TuIgrB1KRL3I8MlQdp?=
 =?us-ascii?Q?gxTt/mIt+cXvV4xNOIKtQljVTjxF5lwg5HbmUtxS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9259.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8cfc2e-f107-41ae-10b3-08ddc9d3c29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 10:29:09.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzmpNsIPumsTosj9q+8BMoGQdXhkzg8HeurCBt/7lL5eLSca1/liVoK2ueQdySIAu/mwQny3BY0AMGYCRqwanSKC7NX1iUMrO3msQVZpPw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Wednesday, July 23, 2025 6:06 PM
> To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; kuba@kernel.org; n.zhandarovich@fintech.ru;
> edumazet@google.com; pabeni@redhat.com; wojciech.drewek@intel.com;
> Arvid.Brodin@xdin.com; horms@kernel.org; lukma@denx.de; m-
> karicheri2@ti.com
> Subject: Re: [PATCH net-next] net: hsr: create an API to get hsr port typ=
e
>=20
> Hi Xiaoliang,
>=20
> On Wed, Jul 23, 2025 at 06:06:05PM +0800, Xiaoliang Yang wrote:
> > If a switch device has HSR hardware ability and HSR configuration
> > offload to hardware. The device driver needs to get the HSR port type
> > when joining the port to HSR. Different port types require different
> > settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> > HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
> >
> > When the hsr_get_port_type() is called in the device driver, if the
> > port can be found in the HSR port list, the HSR port type can be obtain=
ed.
> > Therefore, before calling the device driver, we need to first add the
> > hsr_port to the HSR port list.
> >
> > Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> > ---
>=20
> An API with no callers will never be accepted. You need to post the user =
together
> with this change, for the maintainers to have the full picture and see wh=
ether it is
> the best way to solve the problem.
Thanks Vladimir, I want to use the API in dsa netc driver. The driver has n=
ot been upstream now. I see the HSR implemented on some devices only act as=
 DANH. If the device act as RedBox, we don't know which port is interlink, =
which is slave_A or slave_B. I will re-send it as RFC patch, anyone can dis=
cuss how to handle this issue.

Regards,
Xiaoliang

