Return-Path: <netdev+bounces-122057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1C95FBE6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A6D1C224A9
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036E19CD07;
	Mon, 26 Aug 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zsUY1Rg7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BF19B3D8;
	Mon, 26 Aug 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708592; cv=fail; b=j/N0meXjClMK/3ZV805kn5Kl2mKCsgvdhNzT7Jkdvaap84v0ytGSjfIbOm6BfF/unRoAmdf9KIVf7FkjsDW6buU76sg/HR3Y+04mZKigDjp6TDUHzn3DrXnGfxRLGYeposGQqDQlfobVdHGk3yUhp9JSLPj/LbemAfxCgvk0Y2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708592; c=relaxed/simple;
	bh=m7xKRVubYi3X0rCZlCVgA/SQtO/wPD4KHhcHkc+uKKI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VDM0GB5h85p1lJdNWexaS+Vc/PT2rCuxDSC/YMnDIcvIdLt09ArMnyt62LvW1JE/oqoAnoAOqNG4J/FPD400JALKmvGaJ20mTDD14a0msIxtZ8gq2ghHZLzuMr1NGJ/EFUT5Gi1fyvpx4bYZXlDZ1/pyBjxdrI8ss0ouuy7g45I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zsUY1Rg7; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj4pSKD7xqBaUbfAcXTUWkt0zm4CCuXj6+pbIMb8c0wUpYNUB5oltOub4f/i3PJELvdNh3kj0GuALcZRR6EzgVlcC9BrrDpzZW6ZlK5lQgtS5/VQzY0T237GNvDu1lVzjrn+FZWbenQEWfhuNm9UU/xwM0h955h0Tc+dSyfzGJyj287OzxDB/GOSdAem64XoDFRA7MWhM8GfbFbuxp7Tgh0/uwPC81q9m9j0tmdFtzxYmb4A0YdgIxZV8TUWMgS3hyhe3K+gFYFti44vBj0fJOl6BXJYs0mplx3SlrKsfeUylFQ0Zg6FHwQIVw9cwseW5fazELfXO0lwAj5NawTzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2v0s4PYV/scD0utpSuRGPH2fklr8+M/GjamCsNmrD8=;
 b=KhKzF1iBCFbJQ/F6jHjKPzWSunosh5blxKFEPbo76YB8Su9tJ18N7X0irV9/WevaAsYSmopLAZo9x6rkqAG3GTbNWT80HvfgSwp+Cfa57D3i1vdkkb9GHM6QXtsgqOuZqBiUlQmdDFwqToilgGhlvWr7DlpyJWuOQJHiURyw+3TgsWNi4v1uD6MTceUeRBICwhISMb5ZAxhBeRpBnbmh8D10YVkDwoiJlBSu27/5L8UBXssFO9OwVYh9N7EXe26e8jzDMJ7+7CN0cqZcLB6wTasya1TJNzNIvmbOcE+SRMFHROCZ7KB30Q53laRP1JPpeVEcBy8jXTDS3qPzPHA5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2v0s4PYV/scD0utpSuRGPH2fklr8+M/GjamCsNmrD8=;
 b=zsUY1Rg7dz74xVhRFTtRIVLzoga19bVtyMcm87VPZMN6bxDiyJzu/wW8NWuxtFvzcRDEpCs5JxDCwnYpAY69lXnNBL2m+0LUtqJ06MRK8hZ8kbOoVq4LOg8v603HUTaDNOdZ7stD9pkeM5OJhggas8kwW2rrzCR7lK/mT6Xb7iwxo3Uu1YVBQXD/ki8mfPRzS4NcyKmQPAzDaXZ+3icSpxvd6MwhURd1DanSr8SrnHg/QSBSxgJhq11+82Cn0B4/RZdPcc28NWiKMADNo86uxhd3nmpFiFqsEjPbIFNcjQkTBwWHBJQ4CKwOaw2UpR8TKEd1CNFUuMJTfjUBhISNeg==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 21:43:05 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:43:05 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Topic: [PATCH net-next v6 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Index: AQHa+ABnUbdskkVThEahFpyOQq+QaQ==
Date: Mon, 26 Aug 2024 21:43:05 +0000
Message-ID:
 <BYAPR11MB3558FD0717772263FAD86846EC8B2@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: 823974e4-2be8-49bb-2fd7-08dcc61811b2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1Q4kIFuyT2SnVdGdPNYXFDTRDK9VfR6H9aAZb0BeLcimcthXi+PKL+C7Lw?=
 =?iso-8859-1?Q?83PSo8r5mnoc5g1NLvnEdQDRM+sxcTszdnImjtkdFedd7FWNsZE4hNZEwQ?=
 =?iso-8859-1?Q?g+Dloq9c0Y9iuVqEsNjrJAYn8La52K1wNzIVzpJSnsDnEMn6EAA0d0YVS7?=
 =?iso-8859-1?Q?gL8gT/NKbnOopU9qte/K9EKmBN5x+1Zl0TEcZ+yo+Xkq7dAQp0uXgXehjM?=
 =?iso-8859-1?Q?b5c0toc77I6epTypTdXrInpsr8lFsAgssMz2gVrBQvxVvFKtQEp6tam9an?=
 =?iso-8859-1?Q?qEbYdOApVBkj9YNFzdd7SDGfplb0QT00sryTWSCF3adbbYFfDi3/G02OnD?=
 =?iso-8859-1?Q?KeH7rvTShl33AfLRLAxReTqbg2vLuTP1PhPy3F8fTR8imfmBrhZvFIIDCe?=
 =?iso-8859-1?Q?1XLpb6woNpv6drbjmfnu63jUC5/yQZSa79vkU4vfGW/Aj8BdH67UCK+MhT?=
 =?iso-8859-1?Q?RX+OW+emU8V7hx4PQHTOlnmlwLMurILGCbroyDaY05rP4xTQgi/D8jFIHl?=
 =?iso-8859-1?Q?yzWpdWxDdbIYZ2TaZug0WzuUtj94lgFHfPPrBsPVAf25XD7KqEyN98PaOw?=
 =?iso-8859-1?Q?tuj1I8ToSVrUm53QsVThEJ3xHV58dreyJQp4IrwOxU1pLikz//9qCId1IM?=
 =?iso-8859-1?Q?C1kUQyoxAvwHF5dtHMNrZ1QkdB13th114krWQBEilXkolzWlJQbni3NBym?=
 =?iso-8859-1?Q?4rHJuH5hcD0D8M/6srShUZ5w+zHaDRaNRL7fReeBCuOybQOgH+QgBTLpbp?=
 =?iso-8859-1?Q?vrnC84Ei9+W4hmmi3OyaN0e6dAuIlo1TMSkvaZhbbvd2f7AZW17RW+nes5?=
 =?iso-8859-1?Q?EmBSNy/J64UW9h6h9M9XxmG8+rwWflhqPhlVdt/9hc1f3X12nfdlDx3uJ+?=
 =?iso-8859-1?Q?uW6f0qJfy/4VBtv3tcijl2Nf8QnMC22VjAhqEt48+oGz21XrDjJfvlZ/p6?=
 =?iso-8859-1?Q?tTvR1VKoSrXuckMFbOIUKKdRC4f1ZL7rtJhOjFPiURbd3R5AJ5CtagvJ/K?=
 =?iso-8859-1?Q?XLUx2rAmJNauXjh1Zqgkk3HxzObABdJ9PV2AhI0GstQDe7vI7ZibY1bfLW?=
 =?iso-8859-1?Q?Hgi0qB8SJRR9HhhrSWViOD5K0Bi7ZCTKmADOD7PIeXlKvFnzirSMfKThHh?=
 =?iso-8859-1?Q?DvavhDzvrpGqDWuMKNdT9orV66GDRW/NoxGCz8chOGsHdMVXifmehhEXof?=
 =?iso-8859-1?Q?LOUWpZZ3/GoBadwMLydQbp4KF5go7oHmG/PPuf0K15KkihcWcfIPm55902?=
 =?iso-8859-1?Q?egJhnoNglpZVBDJQUANtliO2mmyhv6shKjNi5yROFEiJytrm09MFaKm7Zp?=
 =?iso-8859-1?Q?Ie8dMBCaP5M4iUmn68S4+eS6Lhc+spO5TRYVxAs20x+DgATEefOkpC38JY?=
 =?iso-8859-1?Q?01o3G03OiS8a3BgUWM5mgrEHxxuBubcbS2LbNr/7DbmuEClCnRmaQH+lvK?=
 =?iso-8859-1?Q?j/nu12eDO3HlKV7ZMZG+sK+8WmLbY6Z0KzS/Bg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tgruA5hdQP54VCzkAaU1jYWnvh+jNni5gqLHQu3FM0GpDMYMsMFOyHjNht?=
 =?iso-8859-1?Q?JTyV9PLlJuo0PgHcHfNA/9JN3odIDA0WdyqWt/tzmxgxiNRzpNESF9hdgq?=
 =?iso-8859-1?Q?o3wWl5x2irp4teRzi6ZKqAvBPl71O8UDSzDRGyX/BXvdenxx1e/21WQRLy?=
 =?iso-8859-1?Q?938I0gM9KTS3080+MUZj2Qjf4kk0Mt6XqhiWQsmCBjFO+XX8iOAYTjn2ku?=
 =?iso-8859-1?Q?D4Gho7tbFtXhwpSEVq8zwbTP5oHU2y57vaM5Tfjf0b49n5OVoT3LxNLEG0?=
 =?iso-8859-1?Q?HPALYBtdjr6GcDIuep0xPbDXFWqxFJKMTdGk2MIVCEiQKscKKd6HZT+y2Q?=
 =?iso-8859-1?Q?Obg6/u5vwQuFmGjWpypCdX5/0f4bbYC34XSi92rlKYtehbbH/uVszleW56?=
 =?iso-8859-1?Q?YokcvjC+hp8QWzqhm5/5lhHlOUUC6GOASFNRkj9j4jze8z/qu4lQdT8wNM?=
 =?iso-8859-1?Q?7UJHbZh1JeBhNSNl4p6Ybn6WpkHj7SrSJZvNpbNc+9C4H6umL4RqNvkJCU?=
 =?iso-8859-1?Q?a6V249j2tNqoc7e03+3ixuYoidk71F6JdLSZo6BI514yyW282a1JeG2L4X?=
 =?iso-8859-1?Q?ysOEKfDHQNQScduB1BNX3TzkBqZ6bbJc1zyxgKbU9Nh1Eg/434uGZfvi28?=
 =?iso-8859-1?Q?HueS6J6uuaLnFFIb+sVGbVC2B4DX2ZP3r/LWBUCLKL4x1BtXc/3dLLUtsE?=
 =?iso-8859-1?Q?s+OEeBqjpC6PEAnFzvG7t+2wksE+gRoNheYJwVZGkHtI+Su8bLwzT3ONR6?=
 =?iso-8859-1?Q?rZ2xCoSguA6gsZXRHfQBCjL5MB/e9Hi36JtOLii54oCJr77wzPf2Gpx589?=
 =?iso-8859-1?Q?QyRhTrY4Gm6V8iSQGKPfxGuJ72nIbzFl0Nz34OSwdJxd+q6zgZzofSR+J+?=
 =?iso-8859-1?Q?ppVdZVVBhMbpYUerA2ob/NlQsV7cu92U887AkSbHfKOBtCyOHgAY2KwM84?=
 =?iso-8859-1?Q?PnVS/ZiIyaqS7nz4SRAXwmm6cMAeLxArkQkGJVDniUcGrjc0mNaloai91o?=
 =?iso-8859-1?Q?s4jr8OEzvaSGzW94qU98xJzlXXAcGGSz3orS3Lk6s9/rkX0i0bLGF3fU+S?=
 =?iso-8859-1?Q?sR/R053t/NUOx8Ql3hbA7JpuG8LCMlMPhJWF6mYeNkTijXGrz+F4KQ6Lg4?=
 =?iso-8859-1?Q?4RF2FiQS+q5ElpCL6MCJcY6gW9qIQDMiFjRPh/0lX7bEqQI7hWECD+/Mv7?=
 =?iso-8859-1?Q?E/PFZOAFuU0ppUBEjPGN/CQPhN/U6hhKZ6uOCkw8xcM3TAMYgodnBzpGH3?=
 =?iso-8859-1?Q?+zIqou1suPhh/7MF8OrXSe1Lcn5l8CK+Df6GJyKgJH/P9uLteEiYLaweF9?=
 =?iso-8859-1?Q?BTIfFikYAuR1eWKFZxwMg9nLPuU4W6J8mCXS0admxteEWuB4Mt9RcPT+Do?=
 =?iso-8859-1?Q?yIf1mdBAeURE8YZAUp2QxGO3OGYBXMsH03SAqVcF8R8hh9hUS2447qVdTd?=
 =?iso-8859-1?Q?4PvcBXJW9P0GSRKU/iKtR1F+yLbPyqJQ0vtAVJjitCpmUzt/ueXHLjnapi?=
 =?iso-8859-1?Q?p4ecaJEd9YZFsLiuIkCIcQrDg77OreDcbsB3dHpppXG2SgCp5pcAxED3BV?=
 =?iso-8859-1?Q?pJG2oyiQW/0D6r0HEASCpq2W7Fmyp6VOEDSL7Cxi9mkVwGZHi/IvGGW6yW?=
 =?iso-8859-1?Q?/ZItKRC8lWj+NDBjDd1JHJ54vifIo/XKAG2qvSGrpVINFvdcybsYHMzd1L?=
 =?iso-8859-1?Q?5Ow5arUNIH6e4ORPaCFZ8DleAeN5+lB6voU+/nkK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823974e4-2be8-49bb-2fd7-08dcc61811b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 21:43:05.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ia76M4p5afU4KqCeoBNETmF8EPkazMq3FaRx+Q8TKznl4BXXnQIYgNMvHdJpaU7R95+HW0S1rmAuwEgAkO3+xBX678eO9z3OULR7TLJ2r/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449

From: Tristram Ha <tristram.ha@microchip.com>=0A=
=0A=
KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after=0A=
KSZ8863, so it shares some registers and functions in those switches.=0A=
KSZ8895 has 5 ports and so is more similar to KSZ8795.=0A=
=0A=
KSZ8864 is a 4-port version of KSZ8895.  The first port is removed=0A=
while port 5 remains as a host port.=0A=
=0A=
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>=0A=
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
---=0A=
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b=
/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=0A=
index c589ebc2c7be..30c0c3e6f37a 100644=0A=
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=0A=
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=0A=
@@ -22,7 +22,9 @@ properties:=0A=
       - microchip,ksz8794=0A=
       - microchip,ksz8795=0A=
       - microchip,ksz8863=0A=
+      - microchip,ksz8864  # 4-port version of KSZ8895 family switch=0A=
       - microchip,ksz8873=0A=
+      - microchip,ksz8895  # 5-port version of KSZ8895 family switch=0A=
       - microchip,ksz9477=0A=
       - microchip,ksz9897=0A=
       - microchip,ksz9896=0A=
-- =0A=
2.34.1=0A=

