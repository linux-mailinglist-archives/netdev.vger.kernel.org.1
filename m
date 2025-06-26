Return-Path: <netdev+bounces-201379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE6AE93CE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87EB5A6E79
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FA1B6CE9;
	Thu, 26 Jun 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="liTdJozf"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012017.outbound.protection.outlook.com [52.101.71.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9191494A9;
	Thu, 26 Jun 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750902028; cv=fail; b=bkmFGavO5nDX4ODgu5z7WLirpCOQT+pkmEU6br7mx9Ieb33bUTDLp663i7sNv7dzbDS8lGMfWQKKSjwbh9whPbyAI02ZGp2k90Cb9vKiUmSZCWyHfMoUfoD0DmXtvMnsGT0VRIDdH0llHDvjwnlNGeemKVXh7QVtAvHX5CQOQss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750902028; c=relaxed/simple;
	bh=4qnVbmZ6XuqIIq0TEFoOuV4JX5SXvyaFRA3lugkDlGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tqh1X/nVzUbcugv4XdtMQijQD842hqz+9VBs3u3nSKwM+2X8tGRJBYljUCHm+0HjHl1wBbrO2kVESUrWaV9S1ZNDyfI36bDbvKXQtn6afiFTLCQt/DzN73Sd4D/bZjS3c/XgRYf13Zp9Ce5ociuqaLfIC8hf9meTna67fa1FIug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=liTdJozf; arc=fail smtp.client-ip=52.101.71.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIy7lb9GS9MSHxSMCnZ/4M/tcnqBZqJXfmrPBaL/OPid5DIn3r+f9T0MdmcpNSo+3DNdBDKUtOPZvSvkMmr3VfBCSl6VsNUhhP2+2N4+HLzplJtG3Sre5V/20Zpgbmprjj2nV6NAXbv3luqB5TD8L5ArZyD+D3tWpCsStxfNRCnn9/rttP18dv1Wc55q79z1jSD1yt7wdXaIjRjMeeO7mROLT+v5kEW8O1XJmGSZDGa22/H1iYM/oEmKDdJC02Veu6GyE2biW5UO1HfjgHSewIk3+ZLXrXXuge0yZjdHUCoJmRgZFolgrujLfPIRiDxO4+xEUGoQrDOeyQER4YakUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZzctlB+GjqIjfX7qC5RSOMU/GIg1KE6DpdXkSffGRk=;
 b=i5oZQfsz7XJ07p2SCVK6r1iWEXexKPLD6scShMV0LrUrMtYyNBqFIFj5fH3XjYF+YkpFXP5N7a5Uc8FT/PNmBQBU13bZlquaDgDVPg9EySEFplUNYkYZtvN7szskvl4VtIakPFq6/FKnmLYsKftRlLIqTvVdx8vGI+llUZqBzWgmiEAA6YcIX4i5PxF4hU7aEIPFxwE5zHdyUqwpZ891xtiP2KkMXnJRDeJq7QfBOE958FQRFy4OmoVNgoou09/tGLRgZenupF9ITeM39UkQzsDn+MEgb/gIoob8S7tkwKFrVaMaEm/vguEy7gG11VrC8VC4KHEadMiRpf3qmVzw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZzctlB+GjqIjfX7qC5RSOMU/GIg1KE6DpdXkSffGRk=;
 b=liTdJozfZBIxdzK7NcIBdcmmzTEHN1/7z+QanMd5daSZ1DEwrLne0hJ84DQ9lLH8yMctwZJOUBNz6X5j1nWtrnVgwkNto4uYQsUmDq77tEHjDRAROboD+mJpXs3c59rfI5KBXhFIUzQoSsOcgOREz27HGKLfkWq1Tzt34ES/gURh5oWjHgRZ/u6FruJzr05EJ8Szzm4HmdJTO7h9DXB3sE0HaX0JITeLXY8F/uCxONltD5ybuDGfOwSteLD1MLb0HvtH+zm02P+BKa0q9k3TayITvbS5pLYb4ramJxdjqZnzoQqDXBuuXkthkMaoglTR6BYQ0pEsIIoqBZxwaWuqkw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9320.eurprd04.prod.outlook.com (2603:10a6:102:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 01:40:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 01:40:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Thread-Topic: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Thread-Index: AQHb5PCefeDeoGBcAU2O+0gg3q53zrQTEliAgAARsWCAAPBEgIAAQlUAgABVrYA=
Date: Thu, 26 Jun 2025 01:40:23 +0000
Message-ID:
 <PAXPR04MB8510510F60881BA59CD532F4887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
	<20250624181143.6206a518@kernel.org>
	<PAXPR04MB8510EDB597AD25F666C450ED887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<20250625163459.GD152961@horms.kernel.org>
 <20250625133224.275a8635@kernel.org>
In-Reply-To: <20250625133224.275a8635@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9320:EE_
x-ms-office365-filtering-correlation-id: 0a58acca-29f7-4d93-49ea-08ddb4526b25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0wtEiSlcGRY7paw5N2Hp486tGh4ycyMCf8nJrFEWyd5tWXJET8m/YIQj9Gv3?=
 =?us-ascii?Q?N9o0ldjwjwzKddodQ1FN9m9RveE9oVl33zNqDn0UxnDCGqcFyw6uAk2Tsvct?=
 =?us-ascii?Q?OCiH5UIUnPVENWFyBEpwNCwVqer/XbIh2OtUmp6dq7TsDvpBz1AvPD8gFdxK?=
 =?us-ascii?Q?dGbqIsz57vJX4WTAsIjvVVTcGWJNmyNVXjrGQBToIEk+ta7NVtOGDrM6/6RI?=
 =?us-ascii?Q?9ekJZg2TAlk4efXVHGTGcN5rySI9nZ6ypoQOmRvgPsHvlXlgVlxYUiPdNqnP?=
 =?us-ascii?Q?rphEtCCYnOtO1eX4ITXb9lE0JZXssolBOCGP5qT7MmVdxB0K6U69tA5GKXuf?=
 =?us-ascii?Q?7TKvSJC0bCFh66ouxRdqbFP9G+AjXTNR1J/pwoAzFHFkEGy/BO9jW9Yetrr+?=
 =?us-ascii?Q?37It3lXlpQllIPyk/tS9qXwhzFNyJzpOjoJnlwHsUx0R/CYnXR6t1Ea0zl+z?=
 =?us-ascii?Q?cq8bp2UNd7pUD5GEkyLXzFOsf+SsgoV42FCckZeYel28WXWbK8XEAaJcM08K?=
 =?us-ascii?Q?GK7/RkTYLZasOAeZvTq3c8sRl4Djn1btrqW6ya4wiCbS3DYJm09hgBKDARo+?=
 =?us-ascii?Q?X3w7GXTDyhAlMsLdV1lKsQEwY9eqxmgBglxFxGH9BtNfTuBXeev5a73qwVH1?=
 =?us-ascii?Q?AR15iS1Eg20vhqsJ/o6aQuCltXln9oa0J71rWj+kPxWHV5gAUfNPNDp9VpqY?=
 =?us-ascii?Q?mYeClSRJ7ZEZc5ObuHS7PrQuWI+lSJMqyFnJ0d2o6rnefsWsdMxp3rQ64//g?=
 =?us-ascii?Q?71VyAvDM7AsO/EXRtmwkcqCAl4d1IdRWvRReFCGSg72aso9Ayxwy+bLAyTyc?=
 =?us-ascii?Q?OY65mUC1DQlUqt9jXtrM7SSxH6F20QYFnomFRvrqvVlAzQDdR+GzuoV1A9va?=
 =?us-ascii?Q?eWL3oHbEhymGGUB9R4SgQDoi+nxbECsAx5mT0h4Tb8Cb+Bvwj+MUDyoQB4Sd?=
 =?us-ascii?Q?G/J8/DS6xXWjp4nq6SVerQJJBFGLMny/PZcyvaUlOdp4A10jX7Zyp/5alo/O?=
 =?us-ascii?Q?aeRylGYSHjZ6Cw+q7Mok2+bLdi4z00LWcFUnHbgXHUbJCbkPXMVtTOeZIDgi?=
 =?us-ascii?Q?qwKmFgdQBkA1WZFdAWp5XhsKOU+Ki2pGQulCHjDVEJ2BjG+qV8ADxq2GSTiw?=
 =?us-ascii?Q?mRgFR+li3EhCii4Wg2UMj1gL8gOQn7XuVc8Ps3hMsIK33u0LXsz5QAVDTmfv?=
 =?us-ascii?Q?koCyS2wn0J2EAnHL8P0cgLIGut1A5Ae0LZh1LKhWjJlvOLL8AnIxRpG6mEgl?=
 =?us-ascii?Q?4ibY5wthGFCrX3b8CaCO3WtvlvscsSL2VA0C1mi5q3H9RMfYLVeWDpl2fZ0h?=
 =?us-ascii?Q?vjsPXEWSiEGMydXFA8BRQttQbFB3aY3FUfFb9jPCAVhoqNsSE0d5CDZ7fnAa?=
 =?us-ascii?Q?F8IS3DgIAizycZdrGg/EuiKabPWbH9LkvXZoTDIgsuTaJUIVltbVoZziAySW?=
 =?us-ascii?Q?fpy0qNBXht0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6TXXZlWP5xae0KS3r6QIt8UBDLDSE+pYh9ivCXMPwEwvGh3sRBJswvMOKS6S?=
 =?us-ascii?Q?8liTdevZmD/lwhDR6eoBWaqRC/c/kMurE+upeXU+I2T6K5fORWQUI0qVdkMi?=
 =?us-ascii?Q?EUa+EdzSTLVNg9La1vjrCx2eJW+4O4HsFxRNzeKKqckEN4IUX7qX2hoQPdB+?=
 =?us-ascii?Q?Gd+1KgCbBDfpqqEYM3rvzbLUa1Qcl2xGO0Qi7CIeN848dNGK81/86Qvg8iNE?=
 =?us-ascii?Q?Ej6/3ienPYG2DQdhL6ENSRPUDHfZrLTuGAbCiikOyiZ7TT9x1FXxTtDmBGea?=
 =?us-ascii?Q?1qYvoYaCZCBFJA1o10eif2T4zZRJZEtDqTSBDtNfiRPKpYAc0fcUiTWYUtxI?=
 =?us-ascii?Q?eNr/s1Y93ZqyNjYzrTpOTAPAFO7OQSo4p6oK5HXA9ntmO1i8WQKKDb/xdDqL?=
 =?us-ascii?Q?eyVsZuX7QzFeDlFi2+JA/mUb3qUypcecxX0JxqHIZOwgJ+AQfN9jYMlWNy8w?=
 =?us-ascii?Q?ppCOBLYbcQ842p4geVhCD6iYarCjJfhcNaxx7vd6OgwaG2Hqy/OjOef4adb2?=
 =?us-ascii?Q?XHExFdMWFvQEX0fKotoR23ws//1MsuVrd+r9hhnS08WGFGBBNCaY2XXwOxji?=
 =?us-ascii?Q?i/+RkyrsOefNQCXv6Qz6QWbNpQFXK9k0Ypw4+WNgYWJc+7E4pE/M81MqlhLt?=
 =?us-ascii?Q?NAIUIhbt1HaxjeoE7klxZjlcHyuclPFcBDv2NVdg/MevcYV+4IEpX4f4nF11?=
 =?us-ascii?Q?05Z4Eb6PinH3SlKjZyM2/sF+kz/hgrS2Hc1xq4HX8435rPIItFPp64xO98Jv?=
 =?us-ascii?Q?OIxbb6gcg5eAbOKWMxT7OLThL2ZXF1lmSaXOLdDrKZh2B99wBwSUamPWUmQN?=
 =?us-ascii?Q?aNc8CrZVmassB2Eywi94eLYlztXp62E/ic/cov9b/nXcyfv+YsxFrnI35p0j?=
 =?us-ascii?Q?UETav4y5lE34srfkpzQinDNHcbhEnHmNVCWUpU31NdFDndWhvYg8+B9thGfO?=
 =?us-ascii?Q?ukCbRNvYHByP0PAem1NB/e8hBlLkUDgtb+2t2KZwmvGAfBuUusDPlUdY+Czk?=
 =?us-ascii?Q?BHeXe0xEo2xLMlvmrpu5XKvl9C/TQLAC7WCJD46OhZDBptl2j43ikR+Mkg1g?=
 =?us-ascii?Q?dTgPzx+UH3VXhCVojOHQg42kQfyjxhtY3pdNOTPycPQruoSP5vcEOhus7xJF?=
 =?us-ascii?Q?ecQoUxaJ/ZuoiR9ioOY+e34xUxcjNbhTEvZvXmXiDmsD7FfAB2/pzxothZ9z?=
 =?us-ascii?Q?K9lTviQp2UO1CeUFyfm89naHQg2ZL/aCH+5sumj08tXgqDKmdgjJ6RoNZwHw?=
 =?us-ascii?Q?+3i2UxaDc+65Cm5kIuSkm37S17GMM40i6o0e6mHUEU1pXkMzbGej/fpest8h?=
 =?us-ascii?Q?g6JoWYpH8cWwU3juFtrq7ia+OwiqmOC/lMGJZvaytBP50q/Kv1mSYh0ewvlj?=
 =?us-ascii?Q?DQ/Al/M4aNV6RaNMm0uZUGQrL/+wsx452lD2FwbeZnwAfsN4l90XJcWpO1J+?=
 =?us-ascii?Q?2lsx6Xd1eJ14w+/rB41YIl9r5x/XglD+dEeoQFM1+Y/fmfPhShr0RxMoewN3?=
 =?us-ascii?Q?JNWl/IJZOMUTtPdPcO/FEo2Opv1XZ/Jmv79DYW+Qwv5w+LA3HatGZPSV3mnn?=
 =?us-ascii?Q?WFf2LjwJPl6RSF+LNaE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a58acca-29f7-4d93-49ea-08ddb4526b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 01:40:23.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnKxbHxByt9IbYgdt/pKWosMRiKZ9LHdmPegTHyFATzpUnyirXF4PE3Mu0Jdkp0tu+nVj2QwpsuSqAetINf1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9320

> On Wed, 25 Jun 2025 17:34:59 +0100 Simon Horman wrote:
> > > Simon has posted a patch [1] to fix the sparse warnings. Do I need to=
 wait
> until
> > > Simon's patch is applied to the net-next tree and then resend this pa=
tch set?
> > >
> > > [1]
> https://lore.kern/
> el.org%2Fimx%2F20250624-etnetc-le-v1-1-a73a95d96e4e%40kernel.org%2F&d
> ata=3D05%7C02%7Cwei.fang%40nxp.com%7Ca68166be285a4e0f081908ddb4276
> 67a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63886480348665
> 4949%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> C%7C&sdata=3DX1UJzBeU2dYFir7YQaMHkpoS03axSQGqQJm%2F2EIIh0E%3D&res
> erved=3D0
> >
> > Yes, I have confirmed that with patch[1] applied this patch-set
> > does not introduce any Sparse warnings (in my environment).
> >
> > I noticed the Sparse warnings that are otherwise introduced when review=
ing
> > v1 of this patchset which is why I crated patch[1].
> >
> > The issue is that there is are long standing Sparse warnings - which
> > highlight a driver bug, albeit one that doesn't manifest with in tree
> > users. They is due to an unnecessary call to le64_to_cpu(). The warning=
s
> > are:
> >
> >   .../enetc_hw.h:513:16: warning: cast to restricted __le64
> >   .../enetc_hw.h:513:16: warning: restricted __le64 degrades to integer
> >   .../enetc_hw.h:513:16: warning: cast to restricted __le64
> >
> > Patches 2/3 and 3/3 multiply the incidence of the above 3 warnings beca=
use
> > they increase the callers of the inline function where the problem lies=
.
> >
> > But I'd argue that, other than noise, they don't make things worse.
> > The bug doesn't manifest for in-tree users (and if it did, it would
> > have been manifesting anyway).
> >
> > So I'd advocate accepting this series (or not) independent of resolving
> > the Sparse warnings. Which should disappear when patch[1], or some vari=
ant
> > thereof, is accepted (via net or directly into net-next).
>
> All fair points, but unfortunately if there is a build issue
> the patches are not fed into the full CI cycle. Simon's fix
> will hit net-next tomorrow, let's get these reposted tomorrow
> so we can avoid any (unlikely) surprises?

No problem, I will resend this patch set after Simon's patch is applied
to net-next tree. Thanks.


