Return-Path: <netdev+bounces-139155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE69B07F8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3695F280CB1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8921620F;
	Fri, 25 Oct 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b="iCnrN3LF"
X-Original-To: netdev@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022106.outbound.protection.outlook.com [40.107.161.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5002161F7
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.161.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869500; cv=fail; b=YhJSkin2cfjD3fe1+piYD2TVnhw0Jz2rTp2nkXR3hT4lyzOFNUkKGMIL3ciPJQpS8Z5iCmqd60WIF6FDIXkGiglO9OaEdZrCdrH7e9CfRAREAekZN/Kzu/OZTCcKuHky0nA/bqTrfohc6Gq0ZCkoSsd5Pn3JB/Kbh8DsUGZEZN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869500; c=relaxed/simple;
	bh=EyrKpm3gZAup+/ZzsI+ihqgONozolPE9DA2AUxOTN1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DoZJLPm6YORYigjlI1MMbH3Ohy8h28t26Uu639E42c7oZKWorBSlIkPqAxTmXllF7BHDroEcv9u4+T9SpxyUzoM8Lv2pS29ifNo1wxyfBDjzpSr4q63rYw0v07rTT+bO6c+4YYoqjek2CAyTSMskYIfnGS9U7Pc3M+/cazDK40k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com; spf=pass smtp.mailfrom=ekinops.com; dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b=iCnrN3LF; arc=fail smtp.client-ip=40.107.161.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ekinops.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VucM8e8vFtYnBha327vkF8S7tKDdBfksZipq57FQeS8B2ycM0ilSmeQcCbauI3/Pv4Tc6b65qH2qUjbeMT63ChZHEVsCaQxDWP1pZn2yEI2gga1qYZpUFdbSMMm/8gMz8hLnkU6oqHSdG0eDYI+AxAVg9Clk41dP10Na9ejsqRpj/7WM3x+/u8BUIKLkDYEXiXf9R/FX1cTRKNjqdN+MIg//9CYRFybaX7uV12+l3DTI26hgxjQsWk44LF1G1AgeYa4yRFt5rDublAkSg+Pka4HQYQ6ayT2+jha+taUpSUosUBO4eKr1eBuCmIPU55A9mXNx2mq0WLYT5gNs4WcmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35zhq/bC8zIrTFWkkbKKqTd6So02xcws6xOwD9BMQSc=;
 b=eajwQ0dzIG9Kym2TCAIfBptQ6G7rVgomEgtRORKvEBRlhiSWmH2ysAx6z9RlhNfM2whhQJwxDNIEKsl2zrKwzKtviSbKI4pa6fNm0+P9pslO/vx2UArUucZWBMJQAi88NhorQTb9j+fz1KMs82wAKaRJSTblc8JYLJv3BJ87b7oYgg9j43Izmqeuw4rYKsB6a3nm4O6ynKAok3LFokYjPG9J/yicTGTQe2e0/enh2daddwfCvPIjG7RsaiOq+HCj9GwYbAl6pAR5hS9MxpOOYQ6Urm1r5sqFoczzmu5TnIQ89eEA47gciMSlc9Ad1UI7kvOSr881lSOiF6AXyrqN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35zhq/bC8zIrTFWkkbKKqTd6So02xcws6xOwD9BMQSc=;
 b=iCnrN3LFanWCEEGXGeTWokD19zCR5glF9DFwPhn9a5DWcp6StlF5kwQmmzMMbwf+LnG27zwbFMA/Awv0vlCClGqqBqxYtNrkEbFdK9xi1QVe2EQEt7DBiGuMpVN8+xZqgiWnSCqnFRI3qdknyOmzV0fZQTKi9pNZPRx7tmYE0qM=
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:29::22)
 by MRZP264MB1974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 15:18:13 +0000
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af]) by MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:18:13 +0000
From: =?iso-8859-1?Q?Herv=E9_Gourmelon?= <herve.gourmelon@ekinops.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: RE: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Topic: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Index: AQHbJuKS0axQvm9UnkuMCwF0pdBIELKXg7M1gAAGU6I=
Date: Fri, 25 Oct 2024 15:18:13 +0000
Message-ID:
 <MR1P264MB3681BFFDEB416E4919D4C22CF84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <20241025141810.b37jxsaz2jjhxhvb@skbuf>
In-Reply-To: <20241025141810.b37jxsaz2jjhxhvb@skbuf>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3681:EE_|MRZP264MB1974:EE_
x-ms-office365-filtering-correlation-id: 9cb8987c-e3eb-4b68-4905-08dcf5083e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+XVjBMoKlO51V9K9UJ3dvnyc5fr5pf8RPQE+TdvLGKWhZy5mcxrv8f4yT5?=
 =?iso-8859-1?Q?yJvzPqtt7WWKdHx6mloEs+cdxUgx/QvRwZsXiQGJMU5vsHB8U9hxCPhMeC?=
 =?iso-8859-1?Q?iXVuW5HNkd7m/otK0ObLYaso8KVoua+U5CgpQ3VDu04QwIJZS+JyLX4hLv?=
 =?iso-8859-1?Q?aBhZXmE8KCM+cQkx6SgK9AQsm6CUnQBgIVhpJc/DzCKWeNAMQy2F/3mSWi?=
 =?iso-8859-1?Q?KhIFFlEjyBAxoxUaRWGg9MMTHhT1Ck0DcxoGGkuxOOjQwWx15FIX7Bkvgl?=
 =?iso-8859-1?Q?ZQskHWPZFjpPJNTrJcrOj3/rKQTQ9jopvZxpdT4Re4T9rAEqiQdVrP1VN2?=
 =?iso-8859-1?Q?Qrtt1OdgDxHr1fvMuuE/gGW/gpnsK7VC6sMCglwhcieb1QgakMUUXcTlLl?=
 =?iso-8859-1?Q?qh/+OfL/bN/g59VRmRIiJCEZtHT9H6B0Kijtpufvik4rOt7ErcPtkg/F5C?=
 =?iso-8859-1?Q?ONRj9ApD2c1ImZNiEziQgP5QbR1JCA9DrV/O8Z3ffiDHoa/XBuh/vlH+hw?=
 =?iso-8859-1?Q?LZLD4I7kdPwB+IZuO4mczA/o19IcozWs7gu2fmv3R+DBkkxHaTR9OSPOmh?=
 =?iso-8859-1?Q?cLTpqCa46/Hfyb93gw0bjsXT9gq1guQuWwqKCHX7uN9cS3CAyjfnQ8drpd?=
 =?iso-8859-1?Q?U0b1z1UXVxlAu1HuMsXwLmrHHoGhXR9SUhOCWzjPmOLaQfvkazCI6Q4igx?=
 =?iso-8859-1?Q?SAfuLuyqyBqe7WicyLKlN0WeqIAH9Wl2IQ14K3zI2lvzznsjVCCtwHLdf6?=
 =?iso-8859-1?Q?6yNAZSOvwxKJQ4Wi8vi62EteCn/18A9CCCrBMC2YgomxVTsFaeb9BFWquM?=
 =?iso-8859-1?Q?+KN+T6OO3898LZuA7srmSNup1yAvgMCtmp41GDlh9c6KDmAhqV2ZzIoDQy?=
 =?iso-8859-1?Q?otlBfieI0TPPbNbh1g5of88UuOLJwPdQLLlFKdLoDDk3Uv2ucaD1TycEIg?=
 =?iso-8859-1?Q?0oU0ZnPjVFB5EdRB3GDuDZgLH5Jv+SN1ZHodkQWXLN50fiY/mHueKTMgRJ?=
 =?iso-8859-1?Q?En8hzz5ib8eZsV39OJuoxIhaPj6hTqYOGwJYVNUQXIwsIdTukEOIuA7HoG?=
 =?iso-8859-1?Q?pYv/0nsgpPtZW7iXRV0YodQW7ImdvNTMO/SQXMMX4KX8Qd3iy6rJvDmD8k?=
 =?iso-8859-1?Q?Rlng11QOAmSnogQcOY2/WunGsMB7b4YHB3woVdi2TA7GMlXex4GGghhIMF?=
 =?iso-8859-1?Q?3oNWIKQNFfQBV1h4Afk+JPr9vMtFXmxdHvuVq5YCdADzhQHnmVQPVe8dqE?=
 =?iso-8859-1?Q?QFAOpgsgzmvF7P4Z+6oZp+muRvJPYQnuWtuM+c008AcD/SEZph6K6Xsb+T?=
 =?iso-8859-1?Q?YoWMey4mU4PgNj08gHfPgKSPEGFhymJK6GpVV3RFQZlXq4aWuxGa0JTATf?=
 =?iso-8859-1?Q?LEohUKxzZoYST7NupH9681Lj+It9NPwwXD59AX2YCLwgaBk8u29uY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/rjnraBYTCFCcgoSrVUX5l1qWEduFKji0FCaidgs75eWhDFfhxgK50+0+X?=
 =?iso-8859-1?Q?bUv7BlWptQAW9NU3E7/vK/037U+0HOJcMiFdZkiJ0iQk5P9QBKe17PNdp5?=
 =?iso-8859-1?Q?+nRPJeq+3Rda2zwrY0rAJqXLiMPCgtVpcGJz6e+W2OLUMYcs4BDTUt/SMa?=
 =?iso-8859-1?Q?WJYyA8qfaFXrzP/ybJYZRysXM22wcm0FLKOzwgKYDxbOw+xmQpszRheydG?=
 =?iso-8859-1?Q?BQ/Rpozt/zsuJ+OX3vDCq5JQz3eepuLDwLBUtIjB6wD7i58NlyG1712HDp?=
 =?iso-8859-1?Q?HTZKWK7ACafErkBeCtgBmKnv0d3TE2ezpoanxOIlOXtJf5PI72iCXJ8Da/?=
 =?iso-8859-1?Q?J/7BCynUVyNMoBVQo3sNvSbLLdTb1CaTuqkxI4Hy20FJ5Zckflvo7VEiIY?=
 =?iso-8859-1?Q?CAMACj9Ha+Bn0weHKMWkawkvuxebRYD+wfieusJqV9zgj25XU+QJXNwXXM?=
 =?iso-8859-1?Q?LQ+yjSsQjwLPxJpbRKX3dz5tuxXYd0159fCDhWyi7KMaUzGBk4zcff9GSt?=
 =?iso-8859-1?Q?+uQDBxv3Kk4OIaJjA4DJb0L2xUcuB1t6g3nMzt+u4hx9nUFl8jpY2Xbqqs?=
 =?iso-8859-1?Q?kf1w5CkvHERUNGCsm5akCpNDmEDgf4TAP5lFZ/Y4atLI5U/bjoOwww+YSN?=
 =?iso-8859-1?Q?gjNKqkwGzMcZVLL1/n8MluVcgPqC5Se0QuT0nnGA9LIZp+AK9nDr1cEqH5?=
 =?iso-8859-1?Q?EsV1qLkbJHMa5OV8gsSHi1WRC5dqH60fLjZdn49jYDHFvK8Dw3Q33qTNaT?=
 =?iso-8859-1?Q?sCJ+3TWhTCftaJTGR70229VJ8tg1NVtdnsT2HOyKMFyVmPVWhyINQ+NOWE?=
 =?iso-8859-1?Q?JnHT42CQan7Qnht1o8SJleYN4ip2iu8/MkWV+wmacMwCIzD1qnW8ohwz0t?=
 =?iso-8859-1?Q?h5B/zGorH901L/wDdn/Eni4BdeP5URdndJYmI5ZE4DQ7p4crcQ7slQ+cKG?=
 =?iso-8859-1?Q?eCcroVE5YKNDBx1KlcyuIONrYnqQZAwiFlccrd2aTsJBT+PaFfz6CGeZag?=
 =?iso-8859-1?Q?cXo+2DWREiLZt0r/Lk5d0BmZRC0RJ80P3yGwJ4BxbZp8pRiqHemkgd2iQB?=
 =?iso-8859-1?Q?tacdvu9rHeB+T1hAvjhuGiMYukKIVllISEL4MVoU0VvJXvqFOIWw2CbOlU?=
 =?iso-8859-1?Q?OX/52S0uxx09MJsBRCdfTjEPKLSh3fNwdPphaBx7pmPnyUE0WMqrm9jZ0h?=
 =?iso-8859-1?Q?s3HYkaX/oQohN2LXxNDghW6GJDlwMuTy5jDoSRFiQccSC5fxMTsvg1Mukm?=
 =?iso-8859-1?Q?3eVzeKaWEQ8S6S1eKEWmBqWN7ze2JJDNLx6qTXGitz56lmd/K7GLloRsS4?=
 =?iso-8859-1?Q?xiepErpGDugrrJuLkKKcUJ8+1fRvAu4XQDwCI1f8kthiqVlG+jbd6JSvh3?=
 =?iso-8859-1?Q?uMI2s7ogyPabyUFFBWzn31e0YaOagPQ255e4OS5ncQZKHPrIoClnnk/ChP?=
 =?iso-8859-1?Q?PIYqet/zZ3bzMti56L2D3cy+6XiFCAl0/5cBsLPM5CdA+9eGEM0qzOuVZH?=
 =?iso-8859-1?Q?TNYlak8BoMCVO7FHAp9cPz8J8WhfJDXjfN4WFYOyQKEcEih3sDwQ8py6lp?=
 =?iso-8859-1?Q?3jZXk/n54OVRMn0hgHKzQ+/J/2KUy23y77Ba0h2O+N4yvzXsGGDUQdRgqw?=
 =?iso-8859-1?Q?nYkdfGjaWap7W6jy+yadpqA8rfPg63vQOq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb8987c-e3eb-4b68-4905-08dcf5083e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 15:18:13.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5eLFCABBeDRE0o5vfI02hsqFAV+m3etHhHlwf3FpJlTo/DMjTDg0sfnyD0qo5ssaaRZjCca62CdNZlZWoyUu0VztafaHsigF3L6wJ1melI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1974

=0A=
Hello Vladimir, and thanks for the answer,=0A=
=0A=
On Fri, Oct 25, 2024 at 02:18:48PM +0000, Vladimir Oltean  wrote:=0A=
>> Trying to set up an untagged VLAN bridge on a DSA architecture of=0A=
>> mv88e6xxx switches, I realized that whenever I tried to emit a=0A=
>> 'From_CPU' or 'Forward' DSA packet, it would always egress with an=0A=
>> unwanted 802.1Q header on the bridge port.=0A=
>=0A=
>What does the link partner see? The packet with the 8021.Q tag or=0A=
>without it?=0A=
=0A=
The link partner definitely sees the packets with the 802.1Q tags.=0A=
=0A=
>The packet will always exit the Linux bridge layer as VLAN-tagged,=0A=
>because skb->offload_fwd_mark will be set*. It will appear with the VLAN=
=0A=
>tag in tcpdump, but it should not appear with the VLAN tag on the wire=0A=
>or on the other side, if the VLAN on the bridge port is egress-untagged.=
=0A=
>If you only see this in tcpdump, it is expected behavior and not a problem=
.=0A=
=0A=
Agreed, and this also what I figured out. But even then, on the link partne=
r, =0A=
I would keep seeing undesired 8021.Q tags in the incoming packets, until=0A=
I patched net/dsa/tag_dsa.c as mentioned earlier.=0A=
=0A=
Turning to the Marvell distributor for support (Avnet Silica) I was also gi=
ven a=0A=
hint that the Src_Tagged bit had something to do with the presence of the =
=0A=
IEEE tag with a 0x8100 Ether type.=0A=
=0A=
Then again, this solution suits my needs (working on a set of 3 cascaded =
=0A=
MV88E6097 chipsets with an EtherType-DSA link to the CPU) but I won't =0A=
pretend I've tested it in other setups on other Marvell Link Street chipset=
s...=0A=
=0A=
>*in turn, that is because we set tx_fwd_offload to true, and the bridge=0A=
>layer entrusts DSA that it will send the packet into the right VLAN.=0A=
>Hence the unconditional presence of the tag, and the reliance upon the=0A=
>port egress setting to strip it in hardware where needed.=0A=
=0A=
I tried to figure out that part as well, but couldn't get it to work withou=
t =0A=
my patch. I tried to restrict my patch to 'From_CPU' packets at first, but =
=0A=
I would still occasionally get 'Forward' packets with the unwanted 802.1Q=
=0A=
tag on the link partner.=0A=
=0A=
So in the end I'm sharing this, just in case someone else is stuck with the=
 =0A=
same problem...=0A=
=0A=
Thank you for your time.=0A=

