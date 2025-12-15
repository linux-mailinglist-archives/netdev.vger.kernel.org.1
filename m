Return-Path: <netdev+bounces-244711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4758CBD82F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 214163014BC8
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A132A3F0;
	Mon, 15 Dec 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YuuZe9jr"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377D314D21;
	Mon, 15 Dec 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798424; cv=fail; b=pHNDpziYari3Pv1nwGVV1eiSaVU9/tdb1+VZpzTVP3cJFFroprQZtYrwpANpIBa19ygAMpXGEQU9GC2nuMx7zr8W531/9o9oUJ1R0I9XjgA14lqLR8SAXOWS8BTmToLIDVXFuKfIStX1m8RBIBKL3iaA0wESrzTj6HNPUE8bIQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798424; c=relaxed/simple;
	bh=qkv3UoP55MJhzak+26erMTZkDhhwAGHFpL8rmYf2hbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QFogB7zyTis/2JgKr3AvFcd5THJiBZEGGv146npjr0UXH2z+Gbq2ZJG68KnaXMl1VlOcwZIjffwE/CNgvKRmL4Gpx4bGFa0ZRkxqx210XCbEjg6wYl+IFAV1yixD6AEf5c/QKI6h2bFF3CaxW9vNeTGwvxQ8Oj8oAiQzrNIJ1tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YuuZe9jr; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnod3nR+LdYdmXSQcn23qdCM6nM5sCFkAtYRIlTOz2a1Omqi7aCnq5pSF+zy9tAifi715RwAB76z7DCupXBXlKIkMzUiwOSKM5kCYJet56zgxwFgXEYU9vm1+/uXXNrzzba2NWmWukGD5gAvDHEtkFeISCfyqIRFzfudgURWOq11iwnGdb7/ZPy9nd6W6T6QZ0WvAUJYnYLml6gBhIOnGWs2zAcp+LOMTZsDr2kfXTBcutUZPOwo0PlGCuJaOJn1RLfCCtHKxsEvE7uwq7U17d24k3fLLBk4PxtAgpkVtUJJ8T9IJ2ynkAJh7pZRTE/uURQkaluNdvRG7q5EQNtKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7HHxOa/+74EzNAVTDQ6p8CqsdNGLaXFJojtF0CDurE=;
 b=w6OyKNwcV9ddeeHTZDGMdN3Ci001dmw8tYZ5x8sDV3mKRQl6Sh7QAyB1LW9RvFm5VQPGG2ia0RlLA2iCKgQBH94prMAgPcIt4nmwDhnDxj0pyZzY3X40dGgUzkMAD9ODZijxXsr+sTbIAGl0PAdEiJCz1fE/9RtkD4P0W9rUyBQlLtYRL7AiKO8G5J3tyKI+WdeZCtDne1NOyvFZgyGsiktkiaL005djfic64m7JHiS1Sxk/HtjvkL975dZVmww+ru7GTmCGLZl9Iwnb0ZSl3J46O0jFCowSta5oBBAPyZXt9vUH0rOt/Gh8jBUfvOPhQjoLWVyEJ9zME0OZRiT24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7HHxOa/+74EzNAVTDQ6p8CqsdNGLaXFJojtF0CDurE=;
 b=YuuZe9jrxSmA1PvQg453PEP0Az7nCf7yLrL+Rn+1kHF6MOyx3I2/VycIGZ8IundvqldU33TdDMZyK04r3f8fKsH3GSeTv6vXyKLG6v9+SY1qR4M6hXTYtCT7aQ/lBNxb2PAINwg+WU9ehGcfCXbpOne14xozq7JVO7/PxRajhMLBrBm92d4Vv+96yYV2sMODfhxss+PMZbssZynGSTXoS4h/hWSbgJsWwQa+EWO5HP/JNuY0etSWyYDoF6kGs24rV8a2LFVdD5QiVF6ucHmstZt7z6zQZ8+RHRESwCRwFTbzYU76DuKE3ZakMxim351bwggl3ekUkT0pAyqSs/bXkQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB6026.ausprd01.prod.outlook.com (2603:10c6:10:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 11:33:37 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:33:37 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: David Laight <david.laight.linux@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sjur Braendeland
	<sjur.brandeland@stericsson.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] caif: fix integer underflow in cffrml_receive()
Thread-Topic: [PATCH] caif: fix integer underflow in cffrml_receive()
Thread-Index: AQHcZSJUzgxWdvCoLkevlpCH9RLz87UceS8AgAYlXZs=
Date: Mon, 15 Dec 2025 11:33:37 +0000
Message-ID:
 <SYBPR01MB78810A9BF01E403BFD95F871AFADA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References:
 <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251211132616.0dd2c103@pumpkin>
In-Reply-To: <20251211132616.0dd2c103@pumpkin>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY4PR01MB6026:EE_
x-ms-office365-filtering-correlation-id: 0f4634b1-b1de-4a1a-6714-08de3bcdc9c9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|41001999006|15030799006|15080799012|8060799015|51005399006|19110799012|461199028|31061999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aG+YiiQ1G9IDTyq0NnGwWwNT/85fGjTCS3V5yXTEl8bLeM/KBW49DsP2MS?=
 =?iso-8859-1?Q?PkW65P4HAVYSpDoJPa6pYq2otT0KdShxn20QvOvrkyNp3hJsqApqQpkYZa?=
 =?iso-8859-1?Q?BGu4g0bNi0uINA7A+JrMxC6ditW2V1p/oraoqC3r97ZJ+l4zP5yiisvPQC?=
 =?iso-8859-1?Q?6tH91KqOkNB5xPbyipOwXYn7umvyZVfcWrb1d2tRyHmksTLL7d4nKKMomB?=
 =?iso-8859-1?Q?rgpSM3i1umFgVotVecUiEeGoadRFmO+sNmkwHKoN3NY0w7z90lCPa1u0QW?=
 =?iso-8859-1?Q?O/OqHKK729H78lkyYFrhoGCq7eDuAD03yRt1SqK0TGeMAWj9LEQuTtHsmz?=
 =?iso-8859-1?Q?NGtyB7Pc82QL3djfMlhv3XqKZHFd2rxx6vMMRPIoOChbUveF8zeQ1aAK5K?=
 =?iso-8859-1?Q?lExQgBajDQTbaWXyTQ+mVbifFhuL6pOEBx2HjqMgaI+GJaxPbnAdi2dBRi?=
 =?iso-8859-1?Q?OnrKpvaItct0svzqP1Ei2HGewTDztfX/PcsngIJ4HoM6rbSmItwqAyT9vT?=
 =?iso-8859-1?Q?3gcrjLnMwcZOCea93iAgpXYccKyI/aLH1wbjRLARVt2ojosxsk7VeJL5jQ?=
 =?iso-8859-1?Q?Hphk1j/wCj5V0wTtcxSUmH3ECrMI1bM8cvpt4GMw4n7dL1irVYTErJOINV?=
 =?iso-8859-1?Q?A+8hgHGlHceYaQujrM8tvtRgA1fu9MJBtJnF4fGnEBarqROzwSVXf+VoSQ?=
 =?iso-8859-1?Q?hKAcNhcS7c+JrnImdPVWy5RYNREpPSMfC0EOggQtZ5YcB732b/9ccF58y2?=
 =?iso-8859-1?Q?t8AL0n7rh96qaOVmlu/Ft82J53oLrEyK27SYOUNLtotxWb6VafzIEWKyX6?=
 =?iso-8859-1?Q?vBAZjBc55ToKcvE5emmpRdAd2L/C+m6pjRVccpfEUxcrLtX3ZGwnRGUX9d?=
 =?iso-8859-1?Q?GuCVX6Sbmvvy7LtQwtTgdrP7CJLZPteuhO82KNBYfKqPgxMkiNeoNQpdwU?=
 =?iso-8859-1?Q?y2nzwHBnPXCZPPbByLUZSwRK2jruTYZbuRdcdmNfbGV9h1sqvfhFBBgemC?=
 =?iso-8859-1?Q?zLlxOyywDh+57D+ZX81LGMp3ng/pgZdSGWNdSftgP9kPRkeDrR0tj1DolC?=
 =?iso-8859-1?Q?hWF6I0UXSeltM8u7OjmL59lKfRI6KvD8UFkRND8vDpB1Zcc1YJ/KPnDKA5?=
 =?iso-8859-1?Q?kqlQtNr4SJyi4LTnTt/eQ/cBis+XVKpW0DWVYf7DtCrPPUBipHz2L3lAt+?=
 =?iso-8859-1?Q?IjjjfnHfZ1DYTpCNHJAVV1jxTrGBz5nUWBibUIzmJgIKrCtuRkgoK8dtEi?=
 =?iso-8859-1?Q?ZO3EevyVnnrnqM8HMnjiweDA/RpSUMP68JGkgDVhU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IyM2K2U0y9lavu8SslU+kvgnfnLWvOeybEJlsY0FgwtM55MlJpQQeNK71f?=
 =?iso-8859-1?Q?N1y1yRLHxPXz4WDlZAQgYNCo7b87se0xrclba86JxOasnh/+8JSallIXjl?=
 =?iso-8859-1?Q?ZK2pR0FDnAvtsXv0e5i9BPCr7R4wIzr8ybvMIZtShmJg8VUx+pB71EVSP5?=
 =?iso-8859-1?Q?GZUOfNUPDLBYA6hG6ASQf6k0iE43xSvMtuuLGheyQJz/d7ecnS+aQdPLWf?=
 =?iso-8859-1?Q?Xa8/urSOwYLg7nJ40YiuNxGLGJZRNN/xmm7Tl9lJvpQBBjeyPsCmtQjfVS?=
 =?iso-8859-1?Q?iU+YRMNoHHqxbM8IuKhTRqpzSsA5sWQQSF7Dkbx19op6tL5ZwUKTRVQWan?=
 =?iso-8859-1?Q?sMZX+eCepxygyHYT09yIlYL7F8GHnA2+OQQJs0r1MGaMM5Av9v28AlgUNF?=
 =?iso-8859-1?Q?EbS/6am6if/ZKr/hhHTdnW4gw+nMVTTPbONLq139Zdzf+3+ShcJ/RJddyd?=
 =?iso-8859-1?Q?c9loNNbFaPR7+y1I5t3JPufmYYkETT/Q5LuRo38AIlEZFXBvtUV7Itb8H6?=
 =?iso-8859-1?Q?Q2NS+HBE3cK9s8AyGFMqXSBLZoKbGrp/zC8uafcGK1Y9qyvDgjsyxJSPdl?=
 =?iso-8859-1?Q?bVIIuWDGNOlEWXuzrQcdw5bd0FBoUPlR6CsqV6Er04fqp/LhcWpIa0veu1?=
 =?iso-8859-1?Q?L0JzsYH9V4t8Gb61fCTHr8lyq6jZi5yAX05GhVIeB3MsY+yGncnnA43686?=
 =?iso-8859-1?Q?JDKpPotVaJ0BPPWeeJvkkCtMIvWNJk7XHs4rrdyzcby+e4RDEL1Eq/8mHy?=
 =?iso-8859-1?Q?/eibq8NZnW4RlQmFjGvJj0NIljUqc+mbetAhq2cO7fB2AeJqWsK7AyavvZ?=
 =?iso-8859-1?Q?eA87TV7XxlPRMKnxoUF+G393v3o25wbFIt2f3XXKQQMJffSr48tLOO682K?=
 =?iso-8859-1?Q?XCcLYPZSF/2MTt+Y/CtW1sfGN2UzxrJ2yGZ897gpddd5fcs1V12cjC5WXM?=
 =?iso-8859-1?Q?yiK4BezlkdPeiZc3si9wNiPIH1g1TLPTAq8RLRF5Asivzi7LHwXPcH9R8l?=
 =?iso-8859-1?Q?oDTjmlU7lYVxKHUSE24zXqFzk+5LS7QiCjqBLxqqUaSJOwdcFzjcDgm9jC?=
 =?iso-8859-1?Q?rPUhtaLjJx8g4BDBJWj1l2ZIuUF2TZdWLfu5IpdXP0l62pGWCWGcab/ley?=
 =?iso-8859-1?Q?STgQi7xKeAWvo9xIi3xf4HOCb2ifVzqXAqB6cZX9Fl/K6UH6UY/1GCQnvg?=
 =?iso-8859-1?Q?6IqMrBBgjorfXwv3g90A5kx6u1erZjZ4TyYiI2vwn1JTCjlUlzqJwfmxo8?=
 =?iso-8859-1?Q?Cze/+/+a1d5yoVLWsiiH6mIcRNeczQn2960W/SSiE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4634b1-b1de-4a1a-6714-08de3bcdc9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 11:33:37.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6026

On Thu, Dec 11, 2025 at 01:26:16PM +0000, David Laight wrote:=0A=
> On Thu, 04 Dec 2025 21:30:47 +0800=0A=
> Junrui Luo <moonafterrain@outlook.com> wrote:=0A=
> =0A=
> > The cffrml_receive() function extracts a length field from the packet=
=0A=
> > header and, when FCS is disabled, subtracts 2 from this length without=
=0A=
> > validating that len >=3D 2.=0A=
> > =0A=
> > If an attacker sends a malicious packet with a length field of 0 or 1=
=0A=
> > to an interface with FCS disabled, the subtraction causes an integer=0A=
> > underflow.=0A=
> > =0A=
> > This can lead to memory exhaustion and kernel instability, potential=0A=
> > information disclosure if padding contains uninitialized kernel memory.=
=0A=
> > =0A=
> > Fix this by validating that len >=3D 2 before performing the subtractio=
n.=0A=
> > =0A=
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>=0A=
> > Reported-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")=0A=
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > ---=0A=
> >  net/caif/cffrml.c | 9 ++++++++-=0A=
> >  1 file changed, 8 insertions(+), 1 deletion(-)=0A=
> > =0A=
> > diff --git a/net/caif/cffrml.c b/net/caif/cffrml.c=0A=
> > index 6651a8dc62e0..d4d63586053a 100644=0A=
> > --- a/net/caif/cffrml.c=0A=
> > +++ b/net/caif/cffrml.c=0A=
> > @@ -92,8 +92,15 @@ static int cffrml_receive(struct cflayer *layr, stru=
ct cfpkt *pkt)=0A=
> >  	len =3D le16_to_cpu(tmp);=0A=
> >  =0A=
> >  	/* Subtract for FCS on length if FCS is not used. */=0A=
> > -	if (!this->dofcs)=0A=
> > +	if (!this->dofcs) {=0A=
> > +		if (len < 2) {=0A=
> > +			++cffrml_rcv_error;=0A=
> > +			pr_err("Invalid frame length (%d)\n", len);=0A=
> =0A=
> Doesn't that let the same remote attacker flood the kernel message buffer=
?=0A=
=0A=
Thanks for the review and suggestion.  Please let me know if you'd like me =
to=0A=
repost a patch removing pr_err(), or if there is a preferred alternative.=
=0A=
=0A=
> =0A=
> 	David=0A=
> =0A=
> > +			cfpkt_destroy(pkt);=0A=
> > +			return -EPROTO;=0A=
> > +		}=0A=
> >  		len -=3D 2;=0A=
> > +	}=0A=
> >  =0A=
> >  	if (cfpkt_setlen(pkt, len) < 0) {=0A=
> >  		++cffrml_rcv_error;=0A=
> > =0A=
> > ---=0A=
> > base-commit: 559e608c46553c107dbba19dae0854af7b219400=0A=
> > change-id: 20251204-fixes-23393d72bfc8=0A=
> > =0A=
> > Best regards,=0A=
>=0A=
=0A=
Thanks,=0A=
Junrui Luo=

