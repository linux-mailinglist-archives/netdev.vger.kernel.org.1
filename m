Return-Path: <netdev+bounces-139167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EF9B092D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B369E2816BC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DC7082B;
	Fri, 25 Oct 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b="otZDP+CR"
X-Original-To: netdev@vger.kernel.org
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020097.outbound.protection.outlook.com [52.101.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA221A4AA
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872483; cv=fail; b=Gj8AgQO6ZIcOGZuuyeWyjxmN45xllrTjyvZsz0FOrsgx5FLCnN6tor4ILj6CswUNvNj6sVADo2AwXcACsCJ1EpgUT6pvFoVKtIkjfNaRYzMIW6GDeouZj3vXSqGDq0a78uktNNb7pEPwCnBQNwthwjnwvGPqQ0x5wYyNYIFD0Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872483; c=relaxed/simple;
	bh=NxIn6w/cSmrwyU3IHmyuHCgZRNEy5j3CRO1rk9E52Ck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/JPBkgIWnv83jw5A/GMMD+Cee7/0VUZMSP6twmH+GBNr04zou261Ccr8JeyAfH7QAmXsggXa/4RD6k+S7rRldSJfywsAT4y+S8ImfFeMcK4KFQ7eWH4JD5/MnZEpQJkQpA6MSQBgDxWo+axXRHnnG1Egs9BnhKhcpyRhZ1mArY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com; spf=pass smtp.mailfrom=ekinops.com; dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b=otZDP+CR; arc=fail smtp.client-ip=52.101.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ekinops.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM9vXqOJTtF3Q+1wfAJbTHe6YeVXkJzMwzEktxHTx5yM8lh3zaN4vyo3wS7zc3a36PkJen481EEiQkyRg4wVl8nhCSGWN8sokMUQps5LdI9YH0+YpMvdZAww1Og/wPdFtDLdms9kdTeBIOPtJV9rwMY2787bCHIXiOiFcKZPBjqvS2GGbo3w5XKrQFipTds1L5faYTp7rnnre+t7YFKO7MJ183sOLVn1q2uX8OwhxFTvzkSy2Ceb4zrjSgio4o+H2qxSlyDlGHvwS7BMbwJwtoZw4G5t4Y81BTnZ/b/5bpak/lBw1zkqroJ+9xV43kOgGEQwzZNTg3U5cdBs775EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXhIt061W77bhh4k6EseZ3+a3Yh2BPWecwB1aZvJvZU=;
 b=AY05WQ9W1pQ/cnwIoXj3vb8qXC0xC5D7EgD9qCYWeqyppwia7bl6SBqno509bL/p0fDKysXoe3Ym/mPT4z67SkCgWJkIrZMNo9VrMQLWLoHRycU1zq8RmMLmi04u8KsuBwvKuv2MU3BhlHxq+dGGjpLsoWqWiXSCoKjnXplSQKJOqBcVzWJyBwjP/vmU4PQ/iL3fELV9F5KSsW2vC6J2G3MzJOALe4F7vKR9Sff6APHqLn7qlFUP40ilk48qucctMltPkcTEygGHg3VuCeDzHx+W9Qi6UZEOMBjSrd6C1ld40PoCVr5CSCN8hqiETgxLjWtSkNpVRusY5klZSYmAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXhIt061W77bhh4k6EseZ3+a3Yh2BPWecwB1aZvJvZU=;
 b=otZDP+CRZftSdIx3kvbmB5Rwn3xIR3A3dgURriup6CJdLsi1/u/gycmPoIAVJuf0SoeHUdUZIVdCUEUti4Bo80YaIEbBxvDjaLdifJObe38usuuZp/MVHQCM5995kQqnw3+5B2MP204FtcovCc43zTPP3/eO4PmS4hLCjdUdGtc=
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:29::22)
 by PR1P264MB2245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 16:07:56 +0000
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af]) by MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 16:07:54 +0000
From: =?iso-8859-1?Q?Herv=E9_Gourmelon?= <herve.gourmelon@ekinops.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot
	<vivien.didelot@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
Subject: RE: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Topic: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Index: AQHbJuKS0axQvm9UnkuMCwF0pdBIELKXj7aAgAAQ1RE=
Date: Fri, 25 Oct 2024 16:07:54 +0000
Message-ID:
 <MR1P264MB368139E2B561ADA6ABC86534F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <87msis9qgy.fsf@waldekranz.com>
In-Reply-To: <87msis9qgy.fsf@waldekranz.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3681:EE_|PR1P264MB2245:EE_
x-ms-office365-filtering-correlation-id: 79e59d56-207d-4446-9d9c-08dcf50f2f03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZRf5Eh+Y2sp1TpGAaEUU/Vkm4CWCLCByfWZ01LP0OOuHcUQwzEznkQwdeC?=
 =?iso-8859-1?Q?DyFUF0Hv/zwAa1QQZRpBh3FtnhiddhxMlGhRUJ+dcydpHOoCNIqNnqfQV0?=
 =?iso-8859-1?Q?SZ9VfCKoxnfeSvw8Dg5bl6FfioAxU7x8fc4EChcoVJuyp3OwvYHJe/Hxy6?=
 =?iso-8859-1?Q?7xlQZFsHIV4HRwRQSevmnw/ADlr9owwIPQ6lhU8XgtGcaHbMPq8fZ8Mkcw?=
 =?iso-8859-1?Q?ZD0x88cMUpjgq+kzwx+2g1JKmlFtDUxXiJPpN4Q2z8FpxlWchw9UFo0obi?=
 =?iso-8859-1?Q?E1JhjyTg6+InmYaD0sFwM/cpT1bk/aW2R9sm/JPfHDv6DM/kINg4jROkEx?=
 =?iso-8859-1?Q?ZxGvc+x8OczMnYItfI3JE6FJ8F+R1SqBP2rFjynjzYogYOtQQzqSTjpxcu?=
 =?iso-8859-1?Q?h8MEnmwP9QhZg8CE4XzPTo/CKZ39Xte9fSscUTaekF3gN7uCSgRi5fHAkn?=
 =?iso-8859-1?Q?F7XIF0UGd6xYY+oUq1GTpMjqS41gMEtdrenZyd0562qVrYsBCiSBmpsRFq?=
 =?iso-8859-1?Q?Xce0Zud7ttVjBWsEjjCKyjwkvlNqNLHVM9QUJWpXm0gyh9mgLYcJDw3gUE?=
 =?iso-8859-1?Q?7gs5608ZGJBBNLCQ9r86AdaZmre9KV23ZpP5Go3eV+ZtMVijDuMjtr9Jm1?=
 =?iso-8859-1?Q?R/fPWBGhJjfoboP7zbqG1ePp6dwdJrtMkeo079BT9SUEcJCunutn5tdons?=
 =?iso-8859-1?Q?YFNpsCKYRKPfRkhcQS5dDRBJii0qzOp/M6iQxveIQO/s9aqWx2H6+1tHhi?=
 =?iso-8859-1?Q?1u7S0txkkLqKjoEF6oMcnBwkvlkeMM5xGNc7pcZTteYbZ9OcJwep1qXlVR?=
 =?iso-8859-1?Q?js2HnpxiyowAT1aIPNAezrDJs1Nw6fVTodCuS5zo/txIzak2p/TH2qheGI?=
 =?iso-8859-1?Q?Hdcc3xL489kDfNhUAbALSvHRaJR7xngO82eLSFec9VTxXFPIiCTxAqcb2o?=
 =?iso-8859-1?Q?uA+oPegchJikTtIMsfxqLXZPAviZNaNbHR+HldnNhtzu6TFb6utscRZnr4?=
 =?iso-8859-1?Q?6xd9MjGGhsOkN7eFGGI1ReXnHpDk+Z0nbT4PjqWsHHf4UXGG3Bc7t9YyJV?=
 =?iso-8859-1?Q?gGgVLSVh7nM7uq3DlkEjpm7/QS1mmEJh2X5J8PjYVWn/hUeznBuSRZfo9z?=
 =?iso-8859-1?Q?g+fgJlixoMWh/vD5cogRE4DE2SDxYSUBern875lFktZmjyx7ryiB51Zrzn?=
 =?iso-8859-1?Q?zujkbyK++9pssewAaD1jWs+Vy/ZYF4rWkaEyqwPCgRpVz34Snoz1ZOb26v?=
 =?iso-8859-1?Q?1/e49YMTQOq0GyRhbadNVUoopsufDDj9TACXSTfMso5LVwfa9QNEV6eNmO?=
 =?iso-8859-1?Q?CKuW4fFdJYg6HlrpbvKLLa3OY6oU4c0Fl12EUT7Tg0t6ktP64opgNL76d+?=
 =?iso-8859-1?Q?D6bv6d/d2oc2KTXnLQfVq+pTXJjLObwKVbnZfZk7PIU8BLmCFU6GM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hrR+Fa10ElgJ1jQpkmqK1iO/8t6le0Zr5s0RCpvMtikC0pMQR3rCVudq7f?=
 =?iso-8859-1?Q?aIFMwntTGCNNTztQDDy6kyPdiFMdpCWxZz6GtKz2OCKe1MwKj5landUpLp?=
 =?iso-8859-1?Q?M+wD7vv8Zis6CcybXFte9p0kVfUH9/FzxZMMSlL5FzckzVcCNFvFlnEP+p?=
 =?iso-8859-1?Q?lLFc0EOJczG4pSfB78o/FlSkZ/NTFxiOViohCd+j3mw0RyFDHoA+pyjoPl?=
 =?iso-8859-1?Q?qznFhpNa4D2yzvI+0j6nipoEf+U16EYwHfbzQbjzFeJbJaGCLIPUZIAwKE?=
 =?iso-8859-1?Q?88ozp0v5WNRElt/3qDcaHt+FswKxslCEUgyETUNoaclFf8f591zbs/NhRt?=
 =?iso-8859-1?Q?tYR00i8K1lSn8w/kLmYoWlS1i2SPcPfPG2VJqeKHe0KKb2Rljzj+VOBHj/?=
 =?iso-8859-1?Q?wVeuebBjNbd2c1QgWD+tPPzRH3fFjW7T4gjIX7IqVuKQOJE90QPyEFcWV2?=
 =?iso-8859-1?Q?74MTtr5qYAmf9sot7Nc4WB/I80t+GXOzgR5HBrLgCbtoEI5/hugQYenMxZ?=
 =?iso-8859-1?Q?DT8Bm1NTEe9Yof0/L/khH+1r8NK3t2k7dZC3jtlcYIzaDGmpqGD32cKI5j?=
 =?iso-8859-1?Q?fHGvFTvyr6eBKKE1xJifzFXu1Mud8mGtcaaGYtSMqpqlqIzHw91Ajdxp5U?=
 =?iso-8859-1?Q?JLn1FUIVJ4fR3vioqsdLMCXwpO7+Gv5wTQbyGz7VwjsIDmpbgXRdLyiMDI?=
 =?iso-8859-1?Q?An1Tp6gM5t9TXWdMwM1MLLMS68awNw1l0zbATTvccQdS79gZzn/oUVBhTu?=
 =?iso-8859-1?Q?zsTr7RV4esk6s6E2Y5vkwgEqKuKj1lR++PcuCXqVOalYMIdTlXKD7TO7pj?=
 =?iso-8859-1?Q?TBZyxSnymv5VaNb0y5981fMifbxN1PgYu11+geaHA4Er9KPyn0JsvG0shH?=
 =?iso-8859-1?Q?rwMxT4VwKbCAkiX2AMqeOitDpzQeCapkL93nGPUVI9xWJlnJ+19o2f1o1t?=
 =?iso-8859-1?Q?Eh5sjckxtO3/9EEu4IcaBvg5LyMCQ8VTdVxJt7ih6FbGps+F4yPWAucIl6?=
 =?iso-8859-1?Q?g3AefrCq6eA0yzzYqb8WhOQZXfTDfRu4qwQSierpu57BnClOrE/bSSkKuG?=
 =?iso-8859-1?Q?sxMFbzzd0Onhx+J1bo0Xr4aGdpJrMloLtMzPAqzaX2fDPkGHLguzMGJwFY?=
 =?iso-8859-1?Q?ZL5Rb7osriF7oX+jqLtvk+z3FzVs5zJXxrwe+lrCM6ARRBTopDarsaWPIj?=
 =?iso-8859-1?Q?E042whgaWcAV+Ot3DBYC2rVX+Z1YY4VMcCrR+hoyvTlTYAXnYya5BgN8ZC?=
 =?iso-8859-1?Q?cG8NjXdDFveK3yWvnBR5d6W+qBcwQZj/60W9e4XgAEfqfOY600eFCnMIlN?=
 =?iso-8859-1?Q?gMfYyXnjaEskHmx145gkNsS2ERz1miz8ksD2mgLqPhIrVUdfwW5FZpgegK?=
 =?iso-8859-1?Q?oSdm4mTp48RSeFeYab+OMXLz0GZUX80Ivffhb8jeb+KJKwLR2fqqF+ziZa?=
 =?iso-8859-1?Q?nwjbKaFqDQAV4BOs0OoPPMAUGSuLdJNjet3ZOmPPY6ZUWHIwVyRp4t5FpV?=
 =?iso-8859-1?Q?z+i+YLaq4G32CfnCjlvZGT8ukYsKdigFS9/KDhg4gjxPvldtirmBVRZGOH?=
 =?iso-8859-1?Q?sfa9F9+u9yl3zYhTHZpwmBJT0/pOVXjaHXQsp3IImIZtZZ/Tysog6R3g3Z?=
 =?iso-8859-1?Q?Xp6xetqJKPpqBb5g2tCjUCAWDx20JZ1fdJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e59d56-207d-4446-9d9c-08dcf50f2f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 16:07:54.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A71sl1uf1mcXgmmqb2pkpu1BSu4ClfCzW6zruy0BL0ySyDcM6tVgp6klF4/4QwParCsMDTsypgyBEuCAhHaanljj5s/Raheip6FVdaGcnbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2245

On fri, oct 25, 2024 at 17:01, Tobias Waldekranz <tobias@waldekranz.com> wr=
ote:=0A=
>Hi,=0A=
=0A=
>Could you provide the iproute2/bridge commands used to create this=0A=
>bridge?=0A=
=0A=
Sure.=0A=
=0A=
I'm creating a VLAN-filtering bridge:=0A=
=0A=
            ip link add name br2 type bridge vlan_filtering 1 vlan_default_=
pvid 0=0A=
=0A=
then adding a number of ports to it (with $itemPort being my variable name =
for the new ports):=0A=
=0A=
            ip link set $itemPort master br2=0A=
            ip link set $itemPort up=0A=
=0A=
then setting up the VLAN on the bridge (with VID =3D $index_vlan):=0A=
=0A=
            bridge vlan add dev br2 vid $index_vlan self=0A=
            bridge vlan global set dev br2 vid $index_vlan=0A=
            bridge vlan add dev $itemPort vid $index_vlan pvid untagged=0A=
=0A=
=0A=
>This only matters for FROM_CPU tags, which contain _destination_=0A=
>information.=0A=
>=0A=
>FORWARD tags contain information about how a packet was originally=0A=
>_received_. When receiving a FORWARD, the switch uses VTU membership=0A=
>data to determine whether to egress tagged or untagged, per port.=0A=
=0A=
As i mentioned in my answer to Vladimir, this is not what I experienced. =
=0A=
I had to reset the Src_Tagged bit for both tags.=0A=
But maybe I'm doing something wrong. It's the first time in 12 years =0A=
on that platform that I had to set up an untagged VLAN bridge, so I had=0A=
not encountered the problem before.=0A=
FYI here is what my DSA looks like (typically, I'm trying to egress untagge=
d traffic on Port0/meth10):=0A=
  =0A=
=0A=
                                          +----------+ =0A=
                                Port9(DSA)|          |--->Port0(meth10)  =
=0A=
                                      +---| Switch#1 | =0A=
                                      |   |          | =0A=
                                      |   +----------+ =0A=
 +-------+              +----------+  | =0A=
 |       |   PortA(EDSA)|          |--+Port8(DSA) =0A=
 |  CPU  |--------------| Switch#2 | =0A=
 |       |              |          |--+Port9(DSA) =0A=
 +-------+              +----------+  | =0A=
                                      | =0A=
                                      |   +----------+ =0A=
                                      |   |          | =0A=
                                      +---| Switch#3 | =0A=
                                Port9(DSA)|          | =0A=
                                          +----------+  =0A=
=0A=
I hope that helps. Thanks for your time!=0A=
Herv=E9=

