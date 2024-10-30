Return-Path: <netdev+bounces-140273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B169B5B9E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601981F2417D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF741D0F5C;
	Wed, 30 Oct 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZXIGhCK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC21D0F76;
	Wed, 30 Oct 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268771; cv=fail; b=cahF9f+xXRpBDCWmn0XeWXaVgCfEmWbAHYhlC9iXLMFpfWoRxlCPtn/l5x1N+7WwWriRnBs0adtkIKy3xQU7DVSI96Zf4nW42cTPmWgpkfsLWGyLtMy1UpfuOFUBUxqxiMLhAoYwPxeYsELWUCBaeXGfQEuDa+ZYqNmXorHizis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268771; c=relaxed/simple;
	bh=XulsmTCSUD5LD/F82aKWz0cxztCsFW0+uVHTge3rjTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KmlGzo35C1YsuaOJAE205ebYi9aneksqM9IacXZQL1jZoisEmG1Ps/jdjqytYA+BKKiEZ/B6SNwD5bhq8jYokdvzrW7QhVyjWygWEk87Zvaf5JpPM1FPFnMFg3Uy4xjlHn0HEA423x1BB0T+FZgk/TL/lZ+D9PXrhBFq9ApS/HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZXIGhCK; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGCi2yWZCM+zAFnfsfDaDIRqgXgxL00N5dn7TsLDXabGX5xtWQ1hzqdaFCbnY1m+jfTO32MlhqQsGVexHpSUdrAB+rKNvwjPybjPg5pNLzKZSOmg9dq3omGo2cmFTlxdrgxzqUHGXA3kKH/HrEyeGliglQRYMqdj5gWIxyITeXRN2tQasCietyB0UfvIO4GIIc4/KyU/fz0diugjNRzfmOT7z1CK8XFLp8Wf3WYU14El/BX/L0pc6HkaZrpsCk2g+mqq6rMSWhrHkBzm+MXdA5aJKBvCpsnXTsKqFKKMeNTpgYS8pY0IcFT/palyLSOSVLkkQo+F896RssxoYdW0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z78YIpGFY8z3NxBc/XZ0Wlge3bLp/jAzsm2yuQP2daI=;
 b=iJIz4it/BIXCyKANVqEVoC7p1hwk3ytuTaDzo/7dl/Dbtqlp7wJHzEyP9CT7d5SxDvDch+6paCzAxabB5LvgCZ+644iQXtKlC4m54/FIiexZ3stqIBSrvJZumTIjhCRIx772G7Q8bOCcv0Qhtimgu9wZE2eLnGrmBpJX49gjfha2B3R9Ed/3BwGIJ4cYEWI3xwM2UGLe+3z6yxKDSHe4Gql0is8jjQAGCoqzWrI3q4MUOEVEm8i+3eqSGDYQJrFp8iV51Ad7Df0iWnjIjh8/qdiQxpY0rc2z4RUPeOOpevkUo/B+feNCGINbictqPnLjSV7D+eKqXQw2YfoNv3KOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z78YIpGFY8z3NxBc/XZ0Wlge3bLp/jAzsm2yuQP2daI=;
 b=HZXIGhCKTkf21fx6N12DD8dgf75ztoWDxlnEP2Dssv/86t1zMK9f0gIuUXsBqRC2LAgacybUoVY+Z9qBK4fgIiKmsMmM5mD6Kur3pREtiS+d8JLYkhJQDj2+3jizGq6Gsusgr7LVbpofgNdykb3eevi2qJNiArOq0UKyqa/mjI8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 30 Oct
 2024 06:12:37 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8093.021; Wed, 30 Oct 2024
 06:12:37 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Katakam, Harini"
	<harini.katakam@amd.com>
Subject: RE: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode
 property value
Thread-Topic: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct
 phy-mode property value
Thread-Index: AQHbKRmHkthwh+AUqkuek3/3Rd7bY7Ke0skg
Date: Wed, 30 Oct 2024 06:12:37 +0000
Message-ID:
 <MN0PR12MB59539234124DEF1B37FAB220B7542@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
In-Reply-To: <20241028091214.2078726-1-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DS0PR12MB7746:EE_
x-ms-office365-filtering-correlation-id: 2a76f043-b0e2-4194-458c-08dcf8a9da79
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zzq7Xk/BUQGOPfGCdF4oHgFKxwfcNB7jFz5mD4sTIImvyaqKDw8FdMHtmtHq?=
 =?us-ascii?Q?IUNN+EYjRAjGYpmRZ49+J8DkS8hwqa67udWU3AlmnO7Tq9zDYbkJWlSalEwV?=
 =?us-ascii?Q?Ef3uBXd4gddPJwVC6SUglGPjdKCERoGeWXz1aG9OWpl/ewuYk+xrdJFE0nbB?=
 =?us-ascii?Q?1d71htFOH3c//0WpGAVMQd1//Du7BpD6bIm5+hRlELsvyTtf9pZwyBEPXqlL?=
 =?us-ascii?Q?HqTYnj5/gV2pRZXKZDfSPL6p/Ntth9/DT8cmtFqJ/k6xkbzbi6y2VcUAlMCH?=
 =?us-ascii?Q?6JBSeLYWNm6pFIUDZwJnNBafbWo/zTywWdusD20OVDisrDdAERadZHDGa2H4?=
 =?us-ascii?Q?pF1KbNh6bvEb4rbPqk3AO43/mdhUtcfxsKCtdTN8dpb+UVzd31dHqHeb6Sdv?=
 =?us-ascii?Q?Ar7EoGh5PQNcp7rik/9PcusuXL30idIvWwIyNgcqnDCMcnyNgJKFmERtHf0P?=
 =?us-ascii?Q?8ZecKStziBsKo8xOFlkJjakS/Ho6QuNlCN+rrAKQtW6LQoElKj1cVt1Hnpax?=
 =?us-ascii?Q?aIn24QUOIK67POrNd+GEjL7FpR7q4R1K0J8JjWk7jBagRMqCVTJRm8+n2OB7?=
 =?us-ascii?Q?AiSqG0/QLp58sYdEGCtu3T4/TfSAgbNvcP7aLbi/wSMAnEOD5nb7QAZVq/dH?=
 =?us-ascii?Q?YFQ1kQnUx0oY1ajpzqCbX0hppM+XPkMoLD7MrXq2CoJQm/Z085vUdw7ywLrN?=
 =?us-ascii?Q?ubDhyZu+6fhZ9QSSN4v74i6XcwCG9G4zigVky8p77uUYPi/XD3LJwkStqbbH?=
 =?us-ascii?Q?IUruc2hQ1QG7441p+wEAPXIl9C/rZd2hubKegJz7qB7hp5u7s++Um5xgMt+1?=
 =?us-ascii?Q?5TeD597SEUhN9WJBu6vuUyNYmOaUce1DT0GgHYDlt2+S0DmYTaGRYIi51vGh?=
 =?us-ascii?Q?eYVNg+AYHuq5x24iKo4GQpTplAdm9nJR3olhKypUGNYzyXGMATgTajVNDKh1?=
 =?us-ascii?Q?tIkhpUlVzu9lGBnYH9DNf9lhy/cSaKVVio9I3yiEP5en2uGatL+BZjYqpjv9?=
 =?us-ascii?Q?sYUSNK56TXLtIW9pZXDp8OaraCo8o3TREF5UUxMMEL5o8DH79hUuJV3aX2Qq?=
 =?us-ascii?Q?JA7lj+wixAW+znOiKmF8Se55s41oeqkOR7pGx0BJ7CkL1DwYgI9M43oGCNyR?=
 =?us-ascii?Q?hxUlT+TEjM/RZhxohS/5w5eOoEX3rqhu8/YUmBp2VPVKUOvKP9y+nJo7m5+k?=
 =?us-ascii?Q?v5HOho2u6hWcxK5nHKGrDPGuf8LVRTahS29B+GXKAUFF23lbZVrY6V9JLCk0?=
 =?us-ascii?Q?3Bnx+8Fg8m/Y+hf9gHd9BxdHOk9amKsoAJm+di0q3S0WNJk5RJyiiFvUzIH6?=
 =?us-ascii?Q?nt0molRMv6aNE08r4K/em8CfVSiEnCGT+4lhDLRFkhugVfhv38f0uV5SKBUP?=
 =?us-ascii?Q?i4MhQbHWIBFm50Uq6jln0a9cMeCQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GR/OTaYbdUnv+KuEGE/EZdopH16HoIdyDeFhXpVZVjjm5dA++iqjhI+4XezP?=
 =?us-ascii?Q?Y6htDcbZaFAWXJPaAYrRrswoka1XnUSFM+oMUYVaR0MFiuqFE2SYF2Ghj2qi?=
 =?us-ascii?Q?mOM3hp0KYmDLU4qZg1Z3e+stBqt1hmZ4wf7m6gv4MFMZvwmQCggxdlgu68lk?=
 =?us-ascii?Q?szBrpYh+314L/bk6OqShHGcj87L9TEFXUAuYgTlz+PHQ0hNzcWevVYLV5ZRh?=
 =?us-ascii?Q?ByLCHsXKNOYySdCDLSAR/jmLBcOoGRcJ6ajTPL2KF3bXu7a66wRu8q+3UDmQ?=
 =?us-ascii?Q?u/IuRHVeXMBG3VtPyfa/Qusncytz5QJqpGsHTdfjVHqR8RiWbAgiarbhoZt4?=
 =?us-ascii?Q?T60tx1H5B0A/+srxKvvN+pM1MCtfplycUjg7pDa7SjLPIz65r3cpaU+PG4Ho?=
 =?us-ascii?Q?vvJDfd4CsBjoLmIJVAj8iwgSqqlMyGy1E7Xj66RmTiXnS5EPf/bmEtkQocbd?=
 =?us-ascii?Q?Hn7+TGAv+OvfXu9UtmIH+IQHodvR91bCAx9/zdcUB+RVxvqzFAazgHEsUlNa?=
 =?us-ascii?Q?qZg7vLO3UY728RZtT7zzRXJWE9S0HZkHsHsS499//mphk3UkhoFTbyzuI398?=
 =?us-ascii?Q?PhQnT6OrYqUTefeNHf2hhkznZ4jCworPvKD9mgY6u7vul2RwdW3X9nASV5dF?=
 =?us-ascii?Q?TYniiWszFkczuoH2Wd5hV4tj0yMoQLE594b7UbCWxSxJDG8ZbSgMLyuH65MB?=
 =?us-ascii?Q?+AMhuO6Nve6u5Ye2uG/xTH2WHGSbcOTWnCaxcvRnJEkV1kI49U+ajwhCCcPR?=
 =?us-ascii?Q?00RNO2Jk1lwY3M6nfLRfBgMmW6G5YBjDBVhnHDpN0rzl3EV3TH/UybeHtPg7?=
 =?us-ascii?Q?IGF6gSmGjJMNrAhgoUKZyS1Iz5/8YEKPvMg6l4Gb3wOlCU6Uy6vmm3yf1/I4?=
 =?us-ascii?Q?x2sAei3whT7G4prFQs0mFMGQpjen+z3gYaTqHRJBJAmX4xgp2xpXKd7/gIVs?=
 =?us-ascii?Q?n/yjOFNciR9nbRhuAcbiMBO7rwBrfeKPQBOlCq7dyvA+PgKCGhw+F7eDj3oi?=
 =?us-ascii?Q?5wT+TEdQ442aaoYIV56veg6U9gWh1mP/6Xjl4fnwBg0h9r/b8KQh92Olvlb0?=
 =?us-ascii?Q?bDY52jFhqaYg+l93nsbS03qEQffGA8t9U+XrHoELSnC1j8pdKvsL6HlMmUHJ?=
 =?us-ascii?Q?75uNo7qetLQFwWUHNNQgs4CsQQEPnqRwDZ1ts+ycefR7NlRLVaVvesBNOy1t?=
 =?us-ascii?Q?gAnRL3LxVuL+Vjtck4jpPbtCJmUQHrC+JodY3qdxc/xGRKr+a+wmi6JSB/LT?=
 =?us-ascii?Q?yNZ9DbTvLDFaC68FrXXX3ssdzp2qLQxsieH7deO7t/idqmYSpdJNMUvTgohK?=
 =?us-ascii?Q?O9oHtJaG/eIEkvTNTP+lIBomK+LZGMCOw2B2HlUBbezQy5udeoDAWffqsqrV?=
 =?us-ascii?Q?FJ4h73YCG5GHMrYaP07wr3EPJ+h0nwuBtF9SP8AZybmxe4pwDs4bOdSumybb?=
 =?us-ascii?Q?ze9V/x002/fK0N8LsFnF/ugWVNx4ctJxbNmY06KIhZF6hlXk6lzzxCPKr7OU?=
 =?us-ascii?Q?cfzEYBK0eYsnDzz9pBOPe1auswgJ8Nq40Ucb0GOnqstes8782v1rt4DdkMIv?=
 =?us-ascii?Q?P45KLpZiRdL4/RrpZQ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a76f043-b0e2-4194-458c-08dcf8a9da79
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 06:12:37.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnDz0mvOgEsY6OmsjjjMYasXpcooJUwtJmp93Er0WvWq9PZRDsjGj3od/ZCRa+Gl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Monday, October 28, 2024 2:42 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; netdev@vger.kernel.org; devicetree@vger.kernel.org; =
linux-
> kernel@vger.kernel.org
> Cc: git (AMD-Xilinx) <git@amd.com>; Katakam, Harini <harini.katakam@amd.c=
om>
> Subject: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mod=
e property
> value
>=20
> Correct phy-mode property value to 1000base-x.
>=20
> Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindin=
gs document
> to yaml")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> index e95c21628281..fb02e579463c 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> @@ -61,7 +61,7 @@ properties:
>        - gmii
>        - rgmii
>        - sgmii
> -      - 1000BaseX
> +      - 1000base-x
>=20
>    xlnx,phy-type:
>      description:
> --
> 2.25.1


