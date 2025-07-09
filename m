Return-Path: <netdev+bounces-205571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F106AFF514
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E683AB9E5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433723E226;
	Wed,  9 Jul 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="obdnZvvI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DB188596;
	Wed,  9 Jul 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102003; cv=fail; b=GotScvCyg1ifaHIHU87+efr3LiNNOMVPhpCuK7ONBb9Hlf709rMUGqSOLJtUfUc/q1p/GelXYCJuGaOVAHUu4/9IO19tWNPaEfU3ikVhOp9elVRLcd4UdnYLx3JRTqPhU0L7UlaEzbLGBho1DdkKfIlK6Xwmj+dRi45U1wwn0ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102003; c=relaxed/simple;
	bh=30F5GYlkSZnaHhxcGcYlETRJvVVnc/iAju5Fb9ofe0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXF10Afaz5P8ehxA6KqOMmvyUDR64PBu8RsKmKCWzlf0U1bA/FRVcTHHlwhMGBbwwziNsbehZkaokL6LNK+aCcCDxMbWl8TLsbiKnz2XEP7s0LSXgZkuqD+NroBh/zwT4+d6Y+ELuPefaYNlOtnVJosE1TFKx6Qive3szFHNc88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=obdnZvvI; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYD+RzvzKWsTQK3B0nSTNV26yJrR7qBvH2du/jyv6TsH2j4u8ebKJvvuV2Y/EX2tjsh7eCmvJLJniYi1HR4ulBQw3sMMrH/8VEgn6XA2ovk2rXOG7dI7nbYHbeteNbhOu/waAZLN+w54P2G5d+kkIu+NS0m8JutaREwfFapbBC9+UiCko6R9MpYODHoobLP6lGql3ntxVpUdD/mq/8gQMKasV2itrgIagrHF0M2FtnrnszdPOlbSmlKn7hdhIJirQWhnotvTUMLD0ijQVy2BjOLepyibKUgF5YMfcBh/+m9BQtByy7YMiXIMkrgNoKBFsWjirB1LoHOhNubbt+7w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvDTtTm0rdIUjJ9DsFjYln7kG/kJkJ2gM/e5Yh4wUxc=;
 b=faoJRxJ6KQkUA0xycVCpdB924ngAlD29MzXtNEjVYrDyy52YDWfLKPzVQKwpTl+HSFLOTjpvVl9WgXrv48J3fQQxyL00bi4Z8u8onoKsBf0luDhmO9psdli9wCUpUwTUAfMjgb2GqZagGWTaU0jn+r/EB2bh2sAEBu/0hnT5Wn0YQhL6/iQ1jDINgzYP/2Oj+WRjseaR2QNIqGjSK8GITeU6v+cQ+HhPd2+c9S5vd+b8EJNK2kVMRLMv9OKj8pP7IJMYPXHG+BgZeXy9urerG+ZiCPUfU1oST7DWIIg3c9tqd25quobw4qAzG9UDhj3+b6JAeyqU8bcyPCSSfzIMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvDTtTm0rdIUjJ9DsFjYln7kG/kJkJ2gM/e5Yh4wUxc=;
 b=obdnZvvIJHycpZuqT4e6vZkhGzBMXgFjIN7BfnOXqxS/TnN9TQbH2fhvj5bQ9H4LboQBGGpOz7otTho5uyTLw9939RdgZMABzhQbn1JtJ+4VljkSdu/OGEUB0YXba34FRT/EQX+TloayPD2q7SZtP6EQQxPUP5OkH99/NuJK2bquDx/tXMCN/CO+tT05K2Cisqq3IAaT1VFeoQPm5ibitXOPwzPd7v2fS3akA6NMDa/9c4tVQtWz9ZRGwVT9gxpoXrI/zrut5eTjthtWKfl7srkWxJSlTvRGRwArnRLUUKxa3/aPQjdkMhkyPm3pWhggogvJ3mrG34e+fGHVWgf3Hw==
Received: from LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 22:59:58 +0000
Received: from LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb]) by LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 22:59:58 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP function
 of KSZ8463
Thread-Topic: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP
 function of KSZ8463
Thread-Index: AQHb8GkNuhIQFaBZrUSJjTnvkDtJ/bQpZyWAgAECGuA=
Date: Wed, 9 Jul 2025 22:59:58 +0000
Message-ID:
 <LV3PR11MB874269079536CDB53183760DEC49A@LV3PR11MB8742.namprd11.prod.outlook.com>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
 <20250709003234.50088-8-Tristram.Ha@microchip.com>
 <20250709073503.kffxy4jlezoobqpf@skbuf>
In-Reply-To: <20250709073503.kffxy4jlezoobqpf@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8742:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 6207cf52-75ee-4f14-210a-08ddbf3c5406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qrA0lZ6gGaCdvm9jOA0Fyn8EvpRaHRB/5LjzmQdqv2X9pccb4Sn4YofD4a5n?=
 =?us-ascii?Q?LsfHAV4Ig23Wa66zeVAVj1n9i/ADm15K/PhKCiMICehTqeejKhkRcAQq3Bgy?=
 =?us-ascii?Q?QtBbq5DHxdJsoYjlunYTzBIRQ4Ygrc3gAbUxbOaYNCqBGraLL5xn+/sBYom2?=
 =?us-ascii?Q?L9J1omXolDP+uoP5iE41c4TAEK1NpURwZbGALIMUdhQG6hvpmxIVqcL5g3bF?=
 =?us-ascii?Q?ZGWyhqwhUfFl7AAPb8eZSZsAWNjvYA8CeR0G1K6LpQ/wkdzcxx/6Uk0/G/Jn?=
 =?us-ascii?Q?Cc+N7FxVLozNC75x9RBKh6t6ndQnl/D4bsvKeGf4jphoMm0X8arYBLkWNMEi?=
 =?us-ascii?Q?X0oxrv9RSeiOZ02LwPWaQUezB6J6zwncLsgyxzvGh3A7L0fzhnnvjjnh4auR?=
 =?us-ascii?Q?88JQKhZ7idPUFb44Di1DOXri6mLihw2J5KCOlxGgeazSR/b0hiL8UMQxqHG8?=
 =?us-ascii?Q?8+PFR3JQf6l+Ld3xJvpRz0QsthBp3DcDfHiNwjA7XZ6fMcKVERHo0NM95s/3?=
 =?us-ascii?Q?wkbZtWstyr/0eQ1RhXeEWCZTqVL4kl1a4ATUYTVsJHe1jb80KAeYfux2ngfo?=
 =?us-ascii?Q?jEbGE58Fg/FHzzb/WSSxNVZTyknWL+Rj+WYmmmrPItjMNvMzaKx9wwgxMHUE?=
 =?us-ascii?Q?wyidp4ELB1lMq1oybpVBHD1AxicZZfVozlzTG9AhK72I3yjehNqyjjrRb2pw?=
 =?us-ascii?Q?zGEPYiyR43Xn5wKPZRIPzpsbMDA4QgvlTelD+zqtzAj5PHHirKP/FvdIAapy?=
 =?us-ascii?Q?y3UTMr1nNIDd19gP/uKqurq71cjqFzmqBImVfYXFJyEGagTL2FuIxETDgHct?=
 =?us-ascii?Q?eIrA9jFPBbHcMExGU9BN+EQGD92i9jPvskN57Ny1oZqR77MPmVvJT/NHCGPD?=
 =?us-ascii?Q?74ff9KQ0O7yrJqpTdLrU0l+UiIywP2GUIRBumBsnszgS2/BnSoV0rLx4BesR?=
 =?us-ascii?Q?7r+yTiILl/XIVU58+lxLtgqPulaaoEeQoYOCYXPCXGGJg9thz9MTm8OvUYbV?=
 =?us-ascii?Q?0mPkG9gTsNpkupjeaCCVE9Np/Ze4Gfdkvr+DBJCeOLGOeuQ4HRU4Lc0jFQzU?=
 =?us-ascii?Q?o/ZQ2iiu1ANjcksGuU/5JMLRkRx0z/NvwJzX/wYC0qYRL/m2Sy0n+ELHvWQ0?=
 =?us-ascii?Q?HeG1anD34LlHp4uHi0S2jQ/kiuWNWWcKOzv2cfliZbItVGcDznBpIfFsWzLC?=
 =?us-ascii?Q?ySM4Q1pSEUGCRhcOj+oSfXE1cBjC9ikhXWRjg5mNFwOxkMuS7MsWeCZ4cfoO?=
 =?us-ascii?Q?Wak2ZtMszKJa87ex3IuQWGo9fRF792f0esxFMkXJSEhoQVnPASjv2o02M/qm?=
 =?us-ascii?Q?O0MYZCNC/eVhHc3N1DybA7FRK7ZkvPIoWU8qEqpTEfD6FvvQNNNjURnFtteJ?=
 =?us-ascii?Q?GHhP4Dr1q1Cjfx00p0b5gyMYUtjinRUNOA+q3y94xAdkStMSaBa7/dDHVjnc?=
 =?us-ascii?Q?uPM7AVzZKwE4QScVMa7r7/ZMffGNNZWs4xkrwPcXG2ocdIDC1CvEXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u08HYJSMKjkaMEexV4Yh/dYwKUx1qv44QuZ8M46NjVvpGJ1OLNfTOAwSUaOg?=
 =?us-ascii?Q?52eO+EV3WjCaI+1XTiKkK3ZUznVLJVhGy8ui3cVr34kSX+KWpgosX3It6kzO?=
 =?us-ascii?Q?ukh0dZ4nWWBFemqFq+UYV2mQkA1XoMVMfJSnNfIiLq5KfY18bXqFmJyxWXvu?=
 =?us-ascii?Q?4GSSJn0dHZAagcCh7GT1/ByrV31AWX3MTKmI+Dld7aitIxoeGNWA3W6olJrl?=
 =?us-ascii?Q?7/4DeKMuYkkJ2pkcIeGyFY4Sl6I+boLcDO5u96EhyIdReFhiQ/9G0QBSSZ0O?=
 =?us-ascii?Q?hv+ovR3LLeThYvGTooEU1PQqVz7TSboIYGvR+2/T0j5ad1FTkIEk3OWqliCH?=
 =?us-ascii?Q?eSliRPv0o5wf2ygriW/gONvBW7OPbjvkMwkVWeVckFcBUzRHcfBQZ5uLGQi/?=
 =?us-ascii?Q?VH8LDZwrrX4dwruC6IBr4M1osTeWnZBeQqKoqucIWLtbdopPfTND/seFdGH9?=
 =?us-ascii?Q?d/ESwEHt5KWb/dRg88Rve5Jpta1Jk1JfSB541hV2hH3aM39+7m/9+3YxAfBn?=
 =?us-ascii?Q?dquNhazXWx1KW5Z0n9wmUjk27XyjlgW7uPrfEhUbHKlAC8xvS+18ZlmfTzG9?=
 =?us-ascii?Q?OTkWS5LD/CuFNzjVL0MHVkObJGHgKbWbREarJuXedFXQnnTMjT3oYCtGKaWF?=
 =?us-ascii?Q?ElrhFXvo++VgH7/xtJ+9FazuSm82IpKNuEI3otPTu4MXSX6/z9ym6clIrdEV?=
 =?us-ascii?Q?0V8roqdsO/1vR6Q57CuFDxvG93wCSQay2gKrwfOo0o1uYVJg68QcH/7USmR2?=
 =?us-ascii?Q?Cm+VHXcbQSsYD+h/4I/8jmz1Ndljclc8WLR2FGHHi9i1bS+flt0FaOS0Xwl4?=
 =?us-ascii?Q?va/iph6Im/xVx5mkgWgcayAm/wj2RElrBfOy4e3erdp7y9PJOKZSVIw/E4Ia?=
 =?us-ascii?Q?5ghEnuuuBO96w3mnWUjHLWLyGq3QRSMXWiif4qOkn70+3Eh+9RGA02KORymJ?=
 =?us-ascii?Q?8YBgTGnyZMDlUeunRrTJhOhXxfYs3TWEUL5bPoV0ABCd/OsExtydMwVAOV4t?=
 =?us-ascii?Q?vL/UVmj0B16upfi1EXSlXMnf3BCpWqGpMQYg1BF/gEAWTh00XAeaNDHFgNQq?=
 =?us-ascii?Q?T3bDC+69UszMhgch0QYXsKqOvTz3AXsecT6W0mTxvn3vrVUc2PRfDeZRa1l3?=
 =?us-ascii?Q?+leHHnk2UamocnxMPg5NhBXQjx4c5wki2gO0GrhpQS6vUGorLQx9iCZBzN4i?=
 =?us-ascii?Q?0QtTxrkBP+PKfFeIHq4hxSzA0kK/DW0seAwq8ewV21UpAWkGW34rTGFkpldf?=
 =?us-ascii?Q?R0ZNyMwhel7NMZKHOaIdNeH56UIpbM9TNo67h5R0+KijrIFncIwdXS9WjfBM?=
 =?us-ascii?Q?Y5yfbfMDLT0pkwYPk9l/nAjJuaI60bnJlJ2lqYr1K553YUviI7Uc/aQHW6OQ?=
 =?us-ascii?Q?s9z6ZRaWgGDfg1KR/ztHySKcpXLQfAiBRWcczFfwHEC0Zx3RWJgUdXVUZ880?=
 =?us-ascii?Q?ogPaJFnei3natHE/+pgg7gD6cJG0hWo+v5sI4uHohLYXme2VvARMxnpfmSzL?=
 =?us-ascii?Q?KoYQWoeqdm5Ov7hfTR4d7Xgvl/1U0UG4bmLWARrn/Kva0mFUffwkwh/QjZXv?=
 =?us-ascii?Q?TYVOOgtn/Llc447FpXBXleXUwkdP3fHwZK9P4h9M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6207cf52-75ee-4f14-210a-08ddbf3c5406
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 22:59:58.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhP8PXuSAfbn58yuTeSAQe/5wb+72wAcPNdDMiAJ5/j/WxrQf1wC9bCZ+QCKlNpvzGnP3ZbFsJo2RQwRnfzqD3rmnqdAeYnYdFUxqYARhdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827

> On Tue, Jul 08, 2025 at 05:32:33PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The PTP function of KSZ8463 is on by default.  However, its proprietary
> > way of storing timestamp directly in a reserved field inside the PTP
> > message header is not suitable for use with the current Linux PTP stack
> > implementation.  It is necessary to disable the PTP function to not
> > interfere the normal operation of the MAC.
> >
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microch=
ip/ksz8.c
> > index ddbd05c44ce5..fd4a000487d6 100644
> > --- a/drivers/net/dsa/microchip/ksz8.c
> > +++ b/drivers/net/dsa/microchip/ksz8.c
> > @@ -1761,6 +1761,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> >                                          reg16(dev, KSZ8463_REG_DSP_CTR=
L_6),
> >                                          COPPER_RECEIVE_ADJUSTMENT, 0);
> >               }
> > +
> > +             /* Turn off PTP function as the switch's proprietary way =
of
> > +              * handling timestamp is not supported in current Linux P=
TP
> > +              * stack implementation.
> > +              */
> > +             regmap_update_bits(ksz_regmap_16(dev),
> > +                                reg16(dev, KSZ8463_PTP_MSG_CONF1),
> > +                                PTP_ENABLE, 0);
> > +             regmap_update_bits(ksz_regmap_16(dev),
> > +                                reg16(dev, KSZ8463_PTP_CLK_CTRL),
> > +                                PTP_CLK_ENABLE, 0);
> >       }
> >  }
> >
> > --
> > 2.34.1
> >
>=20
> What prevents the user from later enabling this through
> ksz_set_hwtstamp_config(HWTSTAMP_TX_ONESTEP_P2P)?

The PTP engine in KSZ8463 is first generation.  The DSA PTP driver used
by KSZ9477 and LAN937X is for second generation, which uses tail tag to
pass along receive/transmit timestamp and port information.

It is not likely the PTP driver will be updated to support KSZ8463.
Currently that driver code is not activated except for KSZ9477 and
LAN937X.


