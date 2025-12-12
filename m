Return-Path: <netdev+bounces-244449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23744CB7C50
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D544B3015100
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C22F12AD;
	Fri, 12 Dec 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mRU5f5Zb"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010013.outbound.protection.outlook.com [52.103.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BE2F656F;
	Fri, 12 Dec 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510255; cv=fail; b=sTdjrTElYgCfdtxUxs+r/IS1d1TvCelqqr8LYltCKe6FVHUk8pVyrB3y8QuVfvBMYKee7hTC8Ahpm5zuGpfpmIYLk73RnEGCwr2fsxzEui04iToKlXSVXLV6LY5DREpRRGdGT/ojOCMz5XMuUFZMjyn8HbIErlSPG9d50DpAv+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510255; c=relaxed/simple;
	bh=h+Y9RhEBwzP1/bvbMsdBazep/vpemmFRN/+xht1y9Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXdH8l6TXMF6CDSLualeLFFaKzLt5UB5qG3J36LfrHHu00U9+AlHtMmrCd14M2SCIFmaR3r5xZhpibYKKvo+Wm3DdFFxMzMJviRF0DDTqZ+HOzlD2uvDvZzNWQYK5u3qA++/O0N+la23+KCiKB/rNxdaG+vg0pMTYW2klwo8C7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mRU5f5Zb; arc=fail smtp.client-ip=52.103.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0w1C6al9zrIeAPz33XfmzCoEvZer6pQ+d7AqFX+zFf2kmDWzxNaXLH+UTsxI3dV8OxdPim94MWYlzGlZroWxED5graxGDvThX54JhcnYwnhTGdX9Zf0COTTaaWbK0Roh5LeGGo0IQ9l/qnTTEljRV7KXuGMciQUT40CiIyiiwqNBsa19SsvPCDFfF0KoM+Yew+XFpOamOgzsRxu+dxoSWw4AoSikzcZP7/TbW8ZGnmzfLblP8Vb+Jvzoj9kpKHt0cJpKV8t6J9iFNFO0oNiM65FT0iJr4Au/qLN5AHfN9CrLm9bHK/8ZvcGOyZfBAf90n4qJ0V/T/gx1FCMSlv01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Y9RhEBwzP1/bvbMsdBazep/vpemmFRN/+xht1y9Xg=;
 b=mw/1SSsiruOidwM/0HkYHNT/dHoALvjR1vKAk333JFZ/zu1L55s8BdiPM10UtYf1LHMaNh7kEO28VocMkxupdk65JRvYcrYQWQmg5Ro2OGXuZyTRkBjm9f5JgTGqU3UH4USFE70I2XBZkVmRLj2tkMXX+VKX7N+nqq3tnkm7Ux4KOuRVbVnh0WQFGcxMwicToCQXDmNuA1GFU40yhCw6DyGBp1fgSNAsRzoPybbm2HK8T1Hk490yezjWJ6unJ1kA3n7IQYepKvszZ1G7895IjdIo1TKn3vc3IpYlVMAUPSEpe1tvMcsx9JPWn5VNGTTlefIgrLBBbYGu9/QNuTVesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Y9RhEBwzP1/bvbMsdBazep/vpemmFRN/+xht1y9Xg=;
 b=mRU5f5ZbqljHz7+U7m+xyxXJFcY2cc/dyxlcJAA9roXUzPUPWa8u3J0ywaZp5YE0BgcIzqtcRf/4ogvcR+s6qP8MlYZIjQ7Vn2NdCrNzbsPItl5AYV4OgnAiP5lCFDPySv5cyWwVq7TQT2OPhYz1YNHpZkl35XYNVqBke9hGgHhLHJFsstqmXSvJw9EkDyBLe5mXvSrCE0tXiPEj8scxuTGBsvg3JK10AMYnPeOCpTe3VJWTZoU1r1I3y6bzPZmCGUvnIndiR0L5dc2ubqqJjTysMIIxSqcJEDwghPRjjV0oV7fHfeYYxaWNXwWBQKkyx0SPgROYhK6ywPykB1bXeA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME3PR01MB6118.ausprd01.prod.outlook.com (2603:10c6:220:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 03:30:45 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 03:30:44 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>
Subject: Re: [PATCH net] skb_checksum_help: fix out-of-bounds access
Thread-Topic: [PATCH net] skb_checksum_help: fix out-of-bounds access
Thread-Index: AQHcaX96nqyBo+OHhkW6/1o9+elOU7Ua5juAgAJyBbM=
Date: Fri, 12 Dec 2025 03:30:42 +0000
Message-ID:
 <SYBPR01MB788187F80FD1A6ED59F0A0E7AFAEA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References:
 <MEYPR01MB7886119A494C646719A3F77CAFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com>
 <willemdebruijn.kernel.3905bafb42307@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3905bafb42307@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME3PR01MB6118:EE_
x-ms-office365-filtering-correlation-id: 386b5b04-7700-4d90-f7c4-08de392ed42b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|15030799006|51005399006|8062599012|8060799015|19110799012|31061999003|12121999013|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?EyzFJDnDDpVtLHnLdi6m2tNFzb66wjSOCuzXb/T+nDG++mLM6KCf+Z+ON/?=
 =?iso-8859-1?Q?64IinyOFELoK+vLyanby5UdVfRUPlVV8rOnZNMZHvlpwtW/AaKDAHvcQn0?=
 =?iso-8859-1?Q?40cbpP+RX2SE5ueXTg7+Ndgiwp285MzY35eVvDKUp+2AQ4r39CsTpgdX0h?=
 =?iso-8859-1?Q?9I3Dq0UQZ5P++Wae9oEGxH1ZoGGEEXW4DMatUIR7XhCS0pcMF38L9rqX4D?=
 =?iso-8859-1?Q?h8FrG/vL7z2r39bH2s9SwhAcnWTq9E4cVJZYKnkNhYqgBJ6AapwJ3kB3I6?=
 =?iso-8859-1?Q?7z1nRsYQH5zBoMAjBVBlFlDka2MZuQI1/RCAUZOboI1NoW0M6ReMmoWgYi?=
 =?iso-8859-1?Q?IQcze76h3XxZtxY0Osofg6jvJbd5XEQldcrjd0Xkr4mqaXbmH6swxBm/JI?=
 =?iso-8859-1?Q?YmgvnSa3ruGT66MVTXT9XUMZ4ZXrBCMQ6F3gohn6KFJFevycJ6co3eK2JX?=
 =?iso-8859-1?Q?nnyfOHkDoVNyVgAbrHWPhqzFTmQ9dc1PKJD2cQdlyqvXTJBM7041Th2xN2?=
 =?iso-8859-1?Q?o1Cailt9PxcqWiPEm6QfXn3S69uuvfyWBO7sfTjsmB1U8+5y50rIMFP3PZ?=
 =?iso-8859-1?Q?USUvYaFMq5Ckf1k5juPdWWMr5t5SNDZ02W9e0ruQepf2mFVvCgLtNl8EOp?=
 =?iso-8859-1?Q?246PAVJ1NEwARXpsQK1ijIUHY0qxhtBc0U2fPE3FG+jMXIZ+t04jWH3dq7?=
 =?iso-8859-1?Q?wk/jJ4A4cqfnXoUPUEG6OJTku3TuXKXprOjSGKi4jZcTXjP5mmeAnurLz7?=
 =?iso-8859-1?Q?Hkai8yEMQ18H47AXI25aa69X/oiUZ6Fnzqfnfkemo/W0eNUm3qvYtnLEnA?=
 =?iso-8859-1?Q?9U994PFPgwNgXHkQPQXYI9/jZpSh/ahMRSkaPg2QR9uJW4HrFm2GjL6rJ1?=
 =?iso-8859-1?Q?PxvblbQMcgaZthf37zp2Y+IbWwUscEiGlGguCR4B1/NSHwE2raTsEvqmiu?=
 =?iso-8859-1?Q?6xnhFqII14bX5GyKpZOSp/g1o9AnHANAxdi8ptQlpqz8nYD+7x4Tbb2veF?=
 =?iso-8859-1?Q?bd5afUo1lYckym0dCXoVBHvLvMuovBR6atyYCWFn9Kq7gL5N1Nl12QUGGs?=
 =?iso-8859-1?Q?IZJ4FxCm3NbYk2v0vIfwYbafUtCtFOPonfwGePndrg876TBNytJdQbhALT?=
 =?iso-8859-1?Q?ZmUM0kb2Gbtme7BFH/YtHsmOQQthlo0wysw6F/6Sp4DcTL0rGJJ8a9zB0S?=
 =?iso-8859-1?Q?bOk1040X19HpIPrRXp+fQ2UjSsAgDMg6EIIVvFmYV6P8VAy0eZq8tk2ovr?=
 =?iso-8859-1?Q?yQ3iLUiR26JvbtZyJvz3yCzjRU5JK135vatFlaoIE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vIH+5Slqk062MT/vKaIi9BiIcNj4B6sZc27qjktGxqy7baGz+uoxpcomxw?=
 =?iso-8859-1?Q?j4SIEP7qTmzaP/n4u0zVm/JojVOr6tZ18kitoel3YyNMIUW7bHjO+vvkzm?=
 =?iso-8859-1?Q?u0m7shVMkRnIUBbSAHxOAbsaI0vR25YfpoX5zr6uDeZ2DMAaXRIUJ9ouDs?=
 =?iso-8859-1?Q?e+kBYeHSmW64+qQe/XIDZ6q/mtibghv0LtEmnmVr8lzJk07qWQvLX1ZJGw?=
 =?iso-8859-1?Q?5+w4lABlM0XTpIzUq2eN/xmtsPH9guUni/qlEmi3BagSqHFrrvYAcPUkEB?=
 =?iso-8859-1?Q?tVf6eRtCubpmeYd5rbL4TdSOFEBIzWSJVcdKubeFrbsfNwjRTNlnhy8yFc?=
 =?iso-8859-1?Q?u6rnmz/k4LqnxBsypnQDrKHmJNKR7CDSmBwmaaFOBGs9nRFYg0syc/gG9e?=
 =?iso-8859-1?Q?GIka4+oL//pAN8MEU1zXOi3cSYhSz+/3uxgbXwS92v/85SJTxnnF9CuX7E?=
 =?iso-8859-1?Q?tcsSSMjRauI8/Mcqvl79vWSQ4OAAfKrJziBZUjnZWIEKREfegQqo6Px5c9?=
 =?iso-8859-1?Q?yYeYOJc/JvVQhnu4r+rOlyIVNjgbV7gNXWumXinKiI4bcnA9DhFs945jXW?=
 =?iso-8859-1?Q?54TrfdJv6IghlXmsY1e3pXbo9al4rLf6yDd2/h1+8EAquUyAOoiCRwu4/u?=
 =?iso-8859-1?Q?ozpcZ+/Dr85Xd5yELrXBMsNaucKabW5GXw2xjI7W9u6ckClGPjxEawTgU6?=
 =?iso-8859-1?Q?yCPxpAqGlfNN3FrFkkhdfr9sHC53CPrLwqtaPjPdIPkV7x+o47dDS02hel?=
 =?iso-8859-1?Q?/LEYDgOkYX/sIm8f6iBkV9i8V7RsJckKsSfGBav1kYdrVRbQsjFXGihzjV?=
 =?iso-8859-1?Q?DxzzB9HGsIimu6ni4I7Ih1cA97BzvzOqTpD1mjV7O3GCNAzt8335m8ZLpo?=
 =?iso-8859-1?Q?jjOatVrmrXVOFPxGkdIRp5kFfXFJp3chiQWSRSLA17O+/GkIQe57x3JZse?=
 =?iso-8859-1?Q?tB4FDMLfemB8jTeydWccw/upppBASgjHQ+TtYLLjV3tOXKXGMtS5o5Xny0?=
 =?iso-8859-1?Q?fc80l5A2E3pjTJZCUT+wsaQVSFhLHoULGkXWx9qYtGgAr5MiHNKvyiDOYZ?=
 =?iso-8859-1?Q?Qgrx7NXxo3PysC6vWP6T0iWWSRaEebVf1hsgwsGFjUbJNn6bPICWvwOK9L?=
 =?iso-8859-1?Q?+BJ0uYFCqrG9wV3qAVBLe4vzRJxYHrmPA7gAmYC7F/2To6Oy7h6X8vRroL?=
 =?iso-8859-1?Q?x8pFNIiswMpyxc+vHadeLz9ByTA1yq8agiGIyAbxndpr/9C/qdmsl8iAXV?=
 =?iso-8859-1?Q?sQ5KyOLezlNzeE78Nflu9rDHQN3/82fzVxjXhLgCc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 386b5b04-7700-4d90-f7c4-08de392ed42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 03:30:42.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6118

On Wednesday 10 December 2025 09:55:17 PM (+08:00), Willem de Bruijn wrote:=
=0A=
=0A=
> Junrui Luo wrote:=0A=
> > The skb_checksum_help() function does not validate negative offset=0A=
> > values returned by skb_checksum_start_offset(). This can occur when=0A=
> > __skb_pull() is called on a packet, increasing the headroom while=0A=
> > leaving csum_start unchanged.=0A=
>=0A=
> Do you have a specific example where this happens?=0A=
=0A=
After testing, I found that triggering this condition in practice is=0A=
difficult. In my test cases, normal packet processing does not create=0A=
the conditions where headroom becomes large enough to make the offset=0A=
negative.=0A=
=0A=
>=0A=
> > A negative offset causes out-of-bounds memory access:=0A=
> > - skb_checksum() reads before skb->data when computing the checksum=0A=
> > - skb_checksum_help() writes before skb->data=0A=
>=0A=
> I don't think this is true out-of-bounds as long as the data access=0A=
> starts greater than or equal to skb->head, which it will.=0A=
=0A=
I agree that it is not strictly out-of-bounds, but rather an incorrect=0A=
memory access.=0A=
=0A=
>=0A=
> There are known cases where such negative skb offsets are=0A=
> intentional. I don't think this is one of them, but needs a careful=0A=
> analysis.=0A=
>=0A=
> The use in skb_checksum does seem to indicate that this is not=0A=
> intentional indeed. Checksumming a packet where the L4 header would=0A=
> lie outside the data.=0A=
>=0A=
> csum =3D skb_checksum(skb, offset, skb->len - offset, 0);=0A=
>=0A=
=0A=
Since this is not intentional indeed, I think we should apply a more=0A=
complete bounds check. Even though the negative offset is unlikely to=0A=
happen.=0A=
=0A=
> > Add validation to detect and reject negative offsets.=0A=
> >=0A=
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>=0A=
> > Reported-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > Fixes: 663ead3bb8d5 ("[NET]: Use csum_start offset instead of skb_trans=
port_header")=0A=
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > ---=0A=
> > net/core/dev.c | 5 +++++=0A=
> > 1 file changed, 5 insertions(+)=0A=
> >=0A=
> > diff --git a/net/core/dev.c b/net/core/dev.c=0A=
> > index 9094c0fb8c68..30161b9240a2 100644=0A=
> > --- a/net/core/dev.c=0A=
> > +++ b/net/core/dev.c=0A=
> > @@ -3574,6 +3574,11 @@ int skb_checksum_help(struct sk_buff *skb)=0A=
> >=0A=
> > offset =3D skb_checksum_start_offset(skb);=0A=
> > ret =3D -EINVAL;=0A=
> > + if (unlikely(offset < 0)) {=0A=
> > + DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);=0A=
> > + WARN_ONCE(true, "offset (%d) < 0\n", offset);=0A=
> > + goto out;=0A=
> > + }=0A=
> > if (unlikely(offset >=3D skb_headlen(skb))) {=0A=
> > DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);=0A=
> > WARN_ONCE(true, "offset (%d) >=3D skb_headlen() (%u)\n",=0A=
> >=0A=
> > ---=0A=
> > base-commit: cfd4039213e7b5a828c5b78e1b5235cac91af53d=0A=
> > change-id: 20251210-fixes-ef9fa1c91916=0A=
> >=0A=
> > Best regards,=0A=
> > --=0A=
> > Junrui Luo <moonafterrain@outlook.com>=0A=

