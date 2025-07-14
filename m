Return-Path: <netdev+bounces-206595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B572AB03A7B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C18189CE15
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8B623F41F;
	Mon, 14 Jul 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cFD9ZlI9"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208F23F404;
	Mon, 14 Jul 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484266; cv=fail; b=fhQ/vqmW09q6hR64j3usTJW2MgODDrmHe2LjBYw/Ea/qhCp6/tCMf6/22AQsH215RvacPzJEdft3ms/W2C1DmZA1fbZBCg7ltLRHkA+z9nMjSbQL/kgePoN9zaAuLKH7TIZSzG5vwnSryxGV9qE5v9JrVB1xvRNzmAXKrBVoAeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484266; c=relaxed/simple;
	bh=81+mPijz8O3AtjqLyPaQ6+ZIgtqfgpGv8OP86/SKXsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uHWAk2+UXeJk5SXPfTdCATdzA17wxsHibu90jBkyEHDStgneWD0aiq1otOBIMFjKFMCHcyS6zzpm1TkQeUeJN7sS8jyMCcOWVBJBYwpeQtMj1KS/a8VNKp+Y5EY8A3dawiVGbUS2rwuLCKyjt1jDHm/kIIxJVh3pij8npLc7N00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cFD9ZlI9; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEp3mkrZy2YvGWiRFVwq9vgzxbaQKvh7YBY9EyuU3E6G06zayVF85GzNWfPqvw5rSVDSrPi+C+hmjz2kVCFei8Mwv6r1F9QvIk03OUQ1aI/x874TjpzCD5Gp64BWPmrc3M7FgAlgQ8lTPGRaELI9LXqesbCM00upVI428vzS14I8QnAu9tC6jV6i0wEuMRryO68LtmMgouBl1TM/+nWIcwsi9AQ9MLwSLzZ/fx9QE5BUqD2CyutvxWy7Q8Dr+rLxtEZ932fg+c+bBryIWv4nJo++nDhBRIDDuQv59zJwEZEgXBEW/GLOCauA6KQB1oEyModVSu743k0GH6+LAonXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p39+j3P636Z/xJxdh8JgluqjLIftoQfoDRVK8ErlSKk=;
 b=a5lVgMi9RCAk6/CtOq8MvEpxXzrH6A1wJ6IG99kIfGLa1+3kEgYSL56s56ZoFiJ08n+Ta6izSWrnwRdRfEPpqHl/EumTPqUtRVcFr1WDVNLMasfI39lUm9Kk3PQlw4FsW47iMf8Y2bshwoW0xl4tcxGTvG8EkRrdpCBhEQtlobA73QwnHrRhiQz/+Ng616POd1YUZumrO6RTRG+Iavxe3N4B0BtKw9VM5RKwZ8pskMod4276zXbtv1NuJD2gv75W1fobSSgL38Qg7KOUYrOq24zTI9egERZDiWQZmZ0xmNGO6iogN9FytryrChKSIQxBVL+vWTVm9Zk8sWZAU4jcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p39+j3P636Z/xJxdh8JgluqjLIftoQfoDRVK8ErlSKk=;
 b=cFD9ZlI9JygWZ1mwYbqHi40R0b4+ApG8kbTmVk9s2B6rI5d69n8Ok1I3rCtwhnAnvIbz2vJVELQUvDZxL67Lqi750dty5ZcYMTfAss8nCvhmT78021HDT4UWustYWE+PLrQGHFwG/SUKVUqqLjZJGGam5EMBSvwOBjfCXy2Ehbc9BOyXL0WoQH3mqGAmRdlWeX2upVkjIPRsWNVe5CQnxoUHC8tgveI38F2BDmPe3lmuEJY42LBMW42LKNxq1zenp5AggEXq08u7gF19D+rhbgCvZ5j1trmC0hXf+BvEiShDJfFqGz8+ab16Jhp/nXZdKanCR66kNBhU3X/Gi87lsg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 09:11:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:11:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index: AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1w
Date: Mon, 14 Jul 2025 09:11:00 +0000
Message-ID:
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
In-Reply-To: <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9461:EE_
x-ms-office365-filtering-correlation-id: ebdf2a20-109e-4e7c-b29c-08ddc2b65a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zD46kk6ozJshlYPF+QOjNnK2GLcCz9MtMMuB6cGswtdmsVzXpIaOjLQjt06+?=
 =?us-ascii?Q?8VWe2usZOxpJyxA52v2PGN4iKhOJmdMfBGXXYBQZPh+jPqs12rAciGrtgQnw?=
 =?us-ascii?Q?v9DaAkgzVMdGtTRqOrhlWfg5hP2qneDoc+GYa8gS9PE1hsWiifltIqdna/I4?=
 =?us-ascii?Q?NEjGet5Zranq+NvWTWNpEso7l81HETIyCTxXQy2P9GSDgrDxYzLKI9/mVQwb?=
 =?us-ascii?Q?MxCxtiLE9Q92OJ6lxaDStEYbHfbYtTTWiJ85In2CttOQYttw1gJYUUqp4h9W?=
 =?us-ascii?Q?pDAemveNfUX1gCbDhuEUAnYj/ok1mhqRRpDIFfXS1Q0VS4VeWbKi9cmTe1ve?=
 =?us-ascii?Q?VQQ0IaUp3dNZPssK1L5tIMQ11Hj7GqsOLK+bMAjhsPQfRVWpyL9xjpolZQIB?=
 =?us-ascii?Q?lehNyYeRvxxDl1vI7vDBrA50BcXwJqhBBR1Q2smOu9IFXg4utSWWq3iOBXrS?=
 =?us-ascii?Q?u/BcZs+tI5n5ksFF3KS5r9zKlu2U/PLt0TWauMAa61kgi/MutrjXtH5CNdkN?=
 =?us-ascii?Q?E8NmzpSoQAUe5PVCL3uzH9Q/n5nSDKdjsRYc3vZjS3XAchyJnMN+YztdC1FM?=
 =?us-ascii?Q?i6X5IW+zaos9b6/SYn+8BaN0oXLkP0DdjYYdZG7VAnonwpu9VGHoJtHYaB5/?=
 =?us-ascii?Q?SnIQbyp5NoOuHR17FBpcfPIUVVkOJGhB5roCX1rIl7jfLBIj42ioMfkX4s00?=
 =?us-ascii?Q?sFE+ricyulSlm8AvWo2Zl5IGIFFn61ax5nr6TWWAF1UbeplmuyrF6fX+Gt+1?=
 =?us-ascii?Q?6D4fbTd7F/Sh37ILfqwBUU/C2issFtw4pU6l6zQ380OQK97EwYBdTtpvhUb0?=
 =?us-ascii?Q?gxP2enYJpN93zrheEsOlt3WNdRhtDdeD8LJcmWyRB8ATxXkgfVS0dXymfxny?=
 =?us-ascii?Q?mBWQdKMcM/Ik6kGtyfVi8ZYVJNLtvjiCcjkGJyXYC2go2Rg1iL01lOsHUGo7?=
 =?us-ascii?Q?R19hcu/Um9loDSFsbkvrvXNRQI2KNhKbF6zhPiSSiGZu4VuCPAzHIOwEoABC?=
 =?us-ascii?Q?+OF0svfAcsi221avnw84d8W1eiH6VieEG86DsqEe8YUBKnxTL/y0YnhXsQXl?=
 =?us-ascii?Q?Dn3GFe4ECo3iwEt4kjsb2GyyV4k1uJKhIKvfP8/csD5tLE2OBPPG+g3Qh6aG?=
 =?us-ascii?Q?ae5Rf0u5qsWzhU7G46flTXPCS7BLyyjuPiuKkuHePi5GgMV2iG+/V+HGwBs5?=
 =?us-ascii?Q?7E/hDjcRsUvovkkP38Xlu7f2FtDrxmW36z4UrYd3ocdWTDfNtBLNu+JA0bxZ?=
 =?us-ascii?Q?KA6zBVq4gfbxJfM+Cuv6Im1kznkT1nZlAqzACSOhNYw+d8Zj29sUgb4ZXdDI?=
 =?us-ascii?Q?U12YQR1GNTVX9kHLgSMkek0pjZirDTDavNJwrlgAhuY9SPnHOO2q7lfICA7q?=
 =?us-ascii?Q?xjE8UYQz6BJFblzwC+r+pynEz4uB4kZDdGpWdM1MuidrqZCu2rKBPG9QoYeW?=
 =?us-ascii?Q?UOhhzTwps3BP9bC2lxRSAWewk1n87nF4c+HZxHfSWsrGPKF4INFpDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6GdxRmoh25jXzSfFzC+R/EeZx2Dsu9NSHzrhOYqxaxw4EjW8OzmqPkvyQn2B?=
 =?us-ascii?Q?t/ahVNsuOLi3z88XlAbauw06ZvqWGPXOA9AGdE5nG7JIF5AVm9t8SsrhFHXP?=
 =?us-ascii?Q?Xq2gY0YnlK9Hb7t5ydVy5Teh6RTV8qTWhDGHTMsvIwpTr+pF/Y6Wg5WLKHam?=
 =?us-ascii?Q?ChufqCCtzh0MwsEWRUh6Nk+sxmqTo9yrxc8GLxhWw2pDGQFIXwzzPn/IEnEA?=
 =?us-ascii?Q?jT2mGhHVYpS0X1RYOBgwL17+z/43RkoWsF/T+Wtnm4Vkj73jhMbBFrRcKtBk?=
 =?us-ascii?Q?zNpjPu215S4hLKObeku0WS0yVsvb4lFEKz0EzMUVBUZCZs0gZWEgjbtBu7xR?=
 =?us-ascii?Q?6XCQTJQ+EyCwQ+o4yIqN/ztEyq8cOxFN0/SeoPAspmaARjd04LHm0xkME/Lk?=
 =?us-ascii?Q?dwMTeNW4KmjdCy2a44U3DAJxe8iBuUMbFcmC9jVw3IOvqTIlqEi6KRiXQEkP?=
 =?us-ascii?Q?2cLEYxJJRRBgmFJ7+O3MvjjhS4YSMvac7qEPiDJKdL+f4ydLIqRIK6vWL4AB?=
 =?us-ascii?Q?0z0enlqNYltqw259FH5OKUbw8W7Hr+e4wkMJM5/hX8JUjvBmgYTuXOp/vpzB?=
 =?us-ascii?Q?er8ZdCG2+5gyF5xVxFQx2eAUjsgLhoqCWkwG2tyYbZqW4DpuqJB9DOwI8PZQ?=
 =?us-ascii?Q?/wFTeL8Ioy87KuvSSQME7XlEB/N/fzxXSQAIJqcnmM+VeWu+qg6I8xhHUyA+?=
 =?us-ascii?Q?cbOBVJ+VHxXc0QAbciyUDENpIBjM8VmepRzf9226YXDOsYbmTSHeT/xEtxN6?=
 =?us-ascii?Q?6y0VrA9rktbCgEr0rIAi52jDH9hTADnXR6uXrTNpbDLBbTnIkp2XdgDKh0IW?=
 =?us-ascii?Q?zQFAwE7A8jdo3q4eRkD0x9YnLnmELEhagFVR85M3CprUpylQ8KYXdv9hZ57n?=
 =?us-ascii?Q?fEQtfJ222XMJEfWzAp9bNO4FxujUThHdVWhcT2iLNUWs2dtN9xSUpCdr3MDS?=
 =?us-ascii?Q?8NkBKRSQSCYafWINEiedAQVqhsKPiV/Xv00HLF0F3aOTNxKoP3imxqvQm6kS?=
 =?us-ascii?Q?O4ayEDnyLSWCO0UwfiHhuv5Au5bGny91oTGoOuM0U3eFoHRO0rAYgEe8mlTP?=
 =?us-ascii?Q?moKA30z/eRt9RaPGOpsBGtCTc5byejmqt+nke/Imznw87qah6zmZ/Ejb7QcZ?=
 =?us-ascii?Q?Fwql0yV1Np4qBWVgKiAwsVpY3IWreHQvXqKNzghF4KuFEA2lx3/I20A2LW8n?=
 =?us-ascii?Q?OHJUwtERnXAF8J8iWBieduoBnwRWfaqgLhWH3ic71Nox0nWhT2gYWoaCVKH3?=
 =?us-ascii?Q?wYpaQpbF3d+5PzB/8d9g7igI0yrTw0O9Nm6sFK4bl0yvRcf+npStkY5kSrrL?=
 =?us-ascii?Q?CWDbncM8cHgTbvpGpUjgOkKmgB7razAG289hwhouu+Ip0WNUlBm9lhv98pwi?=
 =?us-ascii?Q?dtl0U2OGMvCvzbK7UOwyfEbluSH/7w93MbDKvVvFFupDBBITiSi9Z2Ji+s5U?=
 =?us-ascii?Q?QOugRSwdA/ACljltK6Nli27U7jVyaQUm4bEzbjh+mZDQKHZdf0ZXx/e4dtTX?=
 =?us-ascii?Q?TCRApxc99Lr+sznq1NfmmAiKQMqrWOjEge+T4UfCe6H+L2V5RzojAHHNj5Ob?=
 =?us-ascii?Q?w+2KM96qHQVQruy/iko=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdf2a20-109e-4e7c-b29c-08ddc2b65a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 09:11:00.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMfb9fdhUUuYhAcCrORFEF+NN/vsxKyEGJ+CjSN4v8hXNOY6wg19ddAgvBlY8eq4Ll/zqabvcsE0iwtobqJX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461

> >>> +  nxp,pps-channel:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint8
> >>> +    default: 0
> >>> +    description:
> >>> +      Specifies to which fixed interval period pulse generator is
> >>> +      used to generate PPS signal.
> >>> +    enum: [0, 1, 2]
> >>
> >> Cell phandle tells that. Drop property.
> >
> > Sorry, I do not understand what you mean, could you explain it in more
> > detail?
>=20
> Use phandle cells for that - look at other PTP bindings.

Sorry, I did not find a reference in other PTP bindings. If I understand
correctly, you mean I should add a specific cells property to this doc
as follows, correct?

"#nxp,pps-channel-cells":
    description: |
      Specifies to which fixed interval period pulse generator is
      used to generate PPS signal.
    $ref: /schemas/types.yaml#/definitions/uint32
    const: 1


