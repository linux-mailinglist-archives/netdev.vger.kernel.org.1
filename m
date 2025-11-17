Return-Path: <netdev+bounces-239148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A7C64890
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA30E4EF9B5
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A725F98A;
	Mon, 17 Nov 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UDklcyYN"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23741333751;
	Mon, 17 Nov 2025 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387667; cv=fail; b=mliOK1TD6sKu+WTAleiAO7TQPMWGiYH3kOLfxZZl28MaSFlvtDJDtVRPM4Pl+vPT9V6VOdeCLMm0rJ7+PBoK6WoRCxZwdYgDhcstr0TZCVt6D8fGtzgubcvkJPSOh9dDbk6So/2pRmh7BEauH7nnrG5m0b+UkiM9bDNSo1rSkRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387667; c=relaxed/simple;
	bh=pxfXtcaMpoJHqAbvNGV8gLNaq7kb40LMo2XbMn3BJ9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9BUuYWIFpYgKrNmcJfFXtay2CLcDbn9GnLviQTHKd49UzaEUuaBo0KvZS5ulD61L0pfXAc8T6TVwIZyg93JKv5iwzWoDnhzQ8uMTkObzW3BfaDIN49V26mCjN5AgdCfnkr0fp4T4MZC/uoe0cHhnwpcMhzg277A2PKpRH714Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UDklcyYN; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1w/VuuISOlHKavsvaZblFsEfQdJEY7NPnuSHg4Lvc5el/wWeEBrnUECrX8Az3r4nNM42hMdUo5yhgwB68HwsSljvTzQfGHBOA8sMTzloIXYH1dwk3b5cTs4cOWNmnCMAb/sZN9tdJ7R9hv/O6Pn6aSLU8ZupNNBJpn6RmMJJaM7tJj6jWRlFnvrnpHZuChLKWKTSITQjI4utydiNvdd3UgSjQTEHQsmXAW2GDitXqLyeXS3kJN2pjc+Dh7ilH4inKTOZ2trnLKeDjlLJ8j4gkxzokJefT1G+RmQ1boTigShIqY6MZWHEYw9GL4GABraCzAixJn0SH6bWUCMn9uXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxfXtcaMpoJHqAbvNGV8gLNaq7kb40LMo2XbMn3BJ9M=;
 b=ecoM1Dl3gA7fDCVY8NA+orxkeyVsKLYsoy6WthbTsdL9a0zxEcSp83vx5aWemBs2iJPCZpEHM8szoeeF1TSYnYvYaAbxY16yjIYvyQ+ShVRXCdM4IkLOzp/tcPIiegr0rKUty6CwgTBenYPde4B27LG1ezZYLy0FAv2GkGdEos2OX5isIUPTCc8HxyM9EnqZ/U9h6B0dWld75Vrpuqa8K9HF2pPE2vTRBVsyoMASWcyMa0sHkQP3mtGjHptWxm762tAZazkbKDPtGQ7LYO9yORogF5Wj7MnvsaswYHGnQAzmzIag3aVP4OrJMKlPz+FFFpSoG9Gz99w3RLMHEmrmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxfXtcaMpoJHqAbvNGV8gLNaq7kb40LMo2XbMn3BJ9M=;
 b=UDklcyYNJaSqIDIPi3Ef107haze4aHoFUcoUm00Q1F1yRaf2DqD8chozzTP2frR0Ak41fOjdn06FU5K4OiD9n8uBeEyu5127/G6D9TS8MnZJ4MQ9v9hAkPZGlHMwJ5EVaeRPSeOj4Trl6lwROg1MoCYmMdgTkCH6dUiRU7/o/JTiXKSBabYuSkxKpWvxMBuMHIrQNgoL33dEcxt6+jBLtSxtVKrbprH4S1XxCOlPfL8Eudyjr1ULBpaZa6Q/gALjxu1ADJl9s3HwWwtONgZSvqkItkPRP54rUtJNK6u+eakZbVW65KaO06PRisciVLbjxhR+HbYi2kh2feSkuDpVAQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 13:54:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 13:54:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: phylink: add missing supported link modes for the
 fixed-link
Thread-Topic: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index: AQHcVqH8wRDKQtD4n0GYxJSxykL38LT1eb2AgACkdeCAAL8dgIAAA1Kw
Date: Mon, 17 Nov 2025 13:54:20 +0000
Message-ID:
 <PAXPR04MB851071D8B6E7F1FBCBA656CA88C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
 <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <9f9df3b3-ea08-43d7-8075-68b4fe19e6a0@lunn.ch>
In-Reply-To: <9f9df3b3-ea08-43d7-8075-68b4fe19e6a0@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS4PR04MB9363:EE_
x-ms-office365-filtering-correlation-id: deebc798-dc5b-4b46-e0b7-08de25e0cf04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bci4X60BaCSfrSRh+shnxFOvQTzKEiVAyUUbe7OhhjUlbksX/DROx/1iFM8g?=
 =?us-ascii?Q?5ETi7gaVVmRePth78wg9GtfVT7so1KtphplbV4eizR/Hy3NLnBm6RBYGwM28?=
 =?us-ascii?Q?5aOpW1xshzPg86ZitdCBWpeor+YSRbn01G2EeGDYohlbFvNam4VHxp6wpWMy?=
 =?us-ascii?Q?a8Cser10rhKUx1v15rfmEJ5KZ+r6+gOUO6eXcDPO1iuu4NbeDlmRywhoanf6?=
 =?us-ascii?Q?4AaO8dmVCBRzaTsdcCnA3PH81pQN5C9Ujt2xkQI1GAQW0/B1biV5jf8QuMcj?=
 =?us-ascii?Q?MEfiLle4boTs3g0B3RuiAC7nvzanQrwcWX4CHxAw4kxigMbEV82YsF5x0kn6?=
 =?us-ascii?Q?/O+Zi81fod0T2kYsAu8ZluCADdxwJyRUt468Pm2eCMzbvkh4YhWLi8sfcSYZ?=
 =?us-ascii?Q?s/wWvG5lHd4ogivnRTvQ2hHzddwhBnU9aUJoQqdiZVBmbM0i0vJcYCkKEW4S?=
 =?us-ascii?Q?6Ho/HVgzRZCbe+J9JO1Zy7taUH8mn9Bnnttdwii/+eQbPU/hXLfDru1CfwKB?=
 =?us-ascii?Q?TTFsNEB+NcUAhMhNf7tt8ZiifOfS+oNZsyQ1xiF7BtpaOebRIHlMT0FQhaOv?=
 =?us-ascii?Q?yhFHrrXdu45TzNHPIa2VitgpTwJfZ0z+qtuStVLtssSwGX4hP8d5Hfub6Kum?=
 =?us-ascii?Q?pQBf9p3wMND1OyQC3TkKM1Oi2CIkMpSgfYtl8YIdWLCqePlYU1MIgnefKzpS?=
 =?us-ascii?Q?IK2FEcCL4/isLkn3y3octB3xxdCSPNyDDG6A9g5phf6Bol6ah04Rn4RXVJNx?=
 =?us-ascii?Q?IwktcijemG+c7ZLsrfU7VaKxs/k+CSCFGv5MuxWGSoGHgYbzOE5/SfUfZyHs?=
 =?us-ascii?Q?rk+aZNf6rvnuk8v8KpvLakWaeNszSAaZJMrDYVntABJy1pXZ6o6OgColTTnM?=
 =?us-ascii?Q?RDBq5kBjPemMgFH/hA4LrUmb6kdBnZjnvEMemEKtJEwHdE0yKdPLThAPbD0g?=
 =?us-ascii?Q?lQ/ycwugsTfIh9AJVEU0L7+2jSpY+HrGerwMwWO9KoBJ97yZ06DRWgFyapP6?=
 =?us-ascii?Q?dVNbV2y99AixMnC58kK3HVirfJ8IkGINwI65GZmSmZOQBBFmfwdW/SmxuwHX?=
 =?us-ascii?Q?gm+c0i88Y96/qBQ1ZTwnxmt/UWMfECHUUbvdDaA9lrpaAQH0io9xrohJMaOa?=
 =?us-ascii?Q?Q3d6tK7BpliyWwKVs7GcHQDZklVRNy13rqiRtoh54nU+gsy4uz53zbN0LUrX?=
 =?us-ascii?Q?j3jN2YEcom84RNwcjtG89f1+SGDTKF0ilzPoqSqRR87E/bYs7LAllESo0j+H?=
 =?us-ascii?Q?cX2ghYLfJ8b6tYUTovs10soz48Gn8UBZcKB5jfHwgK8REii25nuTOxV/TXrC?=
 =?us-ascii?Q?xIrKQ+FYR1QV+39cHWhitsCWR8Man6URv+9OT2pTDXjx6NyWrdh0Gp8LEnUV?=
 =?us-ascii?Q?S6RDOf75fO/mHtR5s2xbSUWFGoWvAoqIbCfTqTN56SfcelcKY9CmoR2oO7cW?=
 =?us-ascii?Q?LmOxQN+MzQVyUuCsZ1tIb071NEXtx5TdMOYJUidOUeUs0RurfDb+MpsnrXMk?=
 =?us-ascii?Q?rArQvYIEC5Te/8gNKXXXb4T6RKaSxN/sHtCH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uxKcL4/8YOkb+UGjflbyuCUwi7wLyLMTaqDaL6xQ6IQD6rDEYC4wcg7AeJaS?=
 =?us-ascii?Q?POTbVzE8RB3BBDvaIc8HritJtep1YkGNORM3I97xOTM7vSEqcH+csn8XOg3P?=
 =?us-ascii?Q?OHdc4NDN8MEaeB31JvxNCRf9+n09WvTZBKIzi0ldrXjTRnGM5zKaga/DQP6z?=
 =?us-ascii?Q?XG+tO5xL+refw3Cr1libIMfkLv+l6EKddmxohZsl84fWgWpK4f5/78Xy+GY3?=
 =?us-ascii?Q?wUpqyN0lpnVV1mvwljr9kCB7AIEoDsA4Nxrn0cIHco2DX3oxjtvQiWpbI+pC?=
 =?us-ascii?Q?knYne1nYpPpKmWrAgzm5wnr2Y3rxxL7rA0DeuSYJzMsJ6sdVwVdO6cql2tzO?=
 =?us-ascii?Q?UqM+NSv0YrVtj0cPBUqocSrbXGDhkjSYBdkak50AWVAHlv3zgOhFhB35PEea?=
 =?us-ascii?Q?cm2ZIfNQPPHiZJyvPR0OtIKKCyNMCfeLGaXp/mOLRnWjrplrT7XwtXHk0AlH?=
 =?us-ascii?Q?nFaRwowWVbvQhwt0I57C3Fd2oMtohL26yd/Bew1iqDToz1mvV3NwSawoWnjZ?=
 =?us-ascii?Q?wnBWLt2+3ZjSBXvuZ2eik2sofZ15J7vuwcqIQr/67mhk0P/9cR+1QlHgH579?=
 =?us-ascii?Q?sgPVW2tCN3l7+nMNJzjGUD2gp5QsAOhZrsJz4lc2Xym/vt3hze8IafCJKQVy?=
 =?us-ascii?Q?sJREU9aaO8SrWdZdVflrZDbA70SscNfBaad2p5VckilZva6YgbjJXIUjMrUm?=
 =?us-ascii?Q?ByJ1pO+6gzt+r9qsVWMnxd9+3GnOfZStwBx6jOXzzDjMMCYcQ3cQFpgEdnWT?=
 =?us-ascii?Q?adM4Q5oAoBSG87+TYgLC+9p5TJNvCosXw2TNVH12LtVGRGShrQort9iE+UuN?=
 =?us-ascii?Q?KKH3Djvxn56dxC5YbMpQYTbNI5Fs+nMI8/p6CwVd1YRCEw3x6Fet4SxGHX3L?=
 =?us-ascii?Q?vKuht8vnRCIesDQigdySTgOnoZSDAvbHVD3IT5jik8BKzyxPDHnYxMaSpMO4?=
 =?us-ascii?Q?kPNdpWpO1oAldwDQb6kfbQh4EU0uMYJQXetFx9Ea3rjVazdfd9OzBxXKcvkz?=
 =?us-ascii?Q?LmrLNq90LmMuksqDNk9XCUdl1/FBCMxnNNPiBPq98ULv0djuw4KF/n48+zqI?=
 =?us-ascii?Q?jBM1BWFqZ3Qv6lxB9IE59vqpQx2SIo3OcaoagEUsSv1dYA/thG7ZRhgjM53B?=
 =?us-ascii?Q?0rGfYUmbzeO/4KBsBX9GFICcDKucjJCpPEEVP1b1j8DldpiEFA1WmC71EH8V?=
 =?us-ascii?Q?pQ5/LgHZxhfUwtblB4f7xkQfBKw1eAawVK8VnFH+/Oi0OjoZEI49K7uW0kj9?=
 =?us-ascii?Q?Zv87AwtJ4G7mr/He4WwGnnK2FY9jkuuUr46ivLadaURAgWBh6XhQZkd8WX1j?=
 =?us-ascii?Q?1tTbZzuByUA1O4EqLrp56NmEq/X8zFx7fTULFtDnaaM+DUcrOtMCxcmJ/LQx?=
 =?us-ascii?Q?cqQE1qn4412IHFJ+BSstlRCHffLqSMBjN2fJQ0WfBM6C3bmS/NZFBCMZivGb?=
 =?us-ascii?Q?pJt6UHmCVbyyX+BfnUqNYi4ZdbUkxY6lOOCC8rm5M48Slzyr2W6cfByC6LgD?=
 =?us-ascii?Q?E2vAMVTjFY9di9drfDgbRcLTzsX1aaumVi9obhlWWw61P6+TVC6sJ3vux/AM?=
 =?us-ascii?Q?eSWL1vLXQAOTwZ6gY6g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deebc798-dc5b-4b46-e0b7-08de25e0cf04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 13:54:20.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpTTVFK4VVCUqcLQqBptm9Xf+87ePtGQxOJ0bPC6BaPwTSSGqSP1haYK6ai24k+NFZYF+wbXVklJd9YWkvZ1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

> With 1ms ping times, you don't have buffer bloat problems, so that is
> not the issue.
>=20
> I still think you need to look at this some more. Both Russells
> comments about it potentially blocking traffic for other ports, and
> why TCP is doing so bad, maybe gets some traffic dumps and ask the TCP
> experts.
>=20

The default TCP block size sent by iperf is 128KB. ENETC then fragments
the packet via TSO and sends the fragments to the switch. Because the
link speed between ENETC and the switch CPU port is 2.5Gbps, it takes
approximately 420 us for the TCP block to be sent to the switch. However,
the link speed of the switch's user port is only 1Gbps, and the switch take=
s
approximately 1050 us to send the packets out. Therefore, packets
accumulate within the switch. Without flow control enabled, this can
exhaust the switch's buffer, eventually leading to congestion.

Debugging results from the switch show that many packets are being
dropped on the CPU port, and the reason of packet loss is precisely
due to congestion.


