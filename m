Return-Path: <netdev+bounces-132964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA82993E77
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A181282915
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6601613C816;
	Tue,  8 Oct 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1dmD4/f"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC113AA45;
	Tue,  8 Oct 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366569; cv=fail; b=OMI5oXS3NiTyqV63j9WZV4ConIVOKAt98f5rn0XQId8ve2ip3pJ7fD86+NX3dUwtiMBNiCujRvmkSMk9PnByOOxuaELFLAzA7oycRGplYUw/WabEeTpzM5sQPwlZB9rREHWN8axX06OxsCmIJ10znrEgBQsZHxT69OxHavOcPOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366569; c=relaxed/simple;
	bh=mkDeK4bP5H/xL+83uzCUnNQQPPcjjPrKFokKNzNsOoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GC7+Oeje17z5pfC8H5Be2OP8+pnS/RpsxQClTvLYjdPDGWqrtB5B7QNl4OM0IJcZNTB+8tZQbBaHv82Upybp9ys4f+nCWPE2rjasWBuTmZBDquV/HEkSG+BEneoZv4FBShIx98jtzP7nEpS+FaH4xFD4pCnTRGpyYvCTgQn3wPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1dmD4/f; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJX3AdVYpokDuAOrxni80SyilVxVxqBAO+e+EIVPRxSA06kP/jbjE8IGBSFN0MZ3nOtLkHduXXarJQrZkgzLc3bY+rSOLZ+alMZq5Achc4FJ4W0Dh+UB1FGuTNSEfc25bEXXvUO9F08ZtPFMg5vfswzQJ0BPat3YxuFt4kw/HxyduEiKg+pdKPKa3mOTm7L2C+TQcLK/WDiWHiYOI3BoaG9vQIi9h4UXtkjrE0z4jRzDEM1OKokWHi2XDHRfpcpsubI2m/85TVL+YUZoRD7ftpZX9ZZrju3BWXcHAGaqYcO0vbdNAUBznLUqU0EkdGJdVafGB29kBwZscPJLQg4Nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZPNBUsu1jx1hkyL5WtftQNpI3D3SmMgauJ2XfjeZI0=;
 b=XKUGdNyaJkjUS6275mitThSTGIILlEzEDLqkeyrbJob2+zqx72x28gudmSmkcd+DOwoG2H8P3m2FJlarIsQ9sxYltMCBrJYPW248sE6O3KJRBXHvvZVW0ZcgbN/+CsyzcVKhTdV68RyobIsq9KHFO//nOumSNPIg8K7fmDgMiK/g8FNWcadZVg7sMM3UOMrSe940r4I5ARyXoX79LAIGDLiD+l6nV0k9psZXOWdDGvCWoVRCFbao7HSSTAvKfSvAOTGFvzrG5x4EbJmvLfZoUm9FfCAlxDY1Fce4ISxRIrnbXZEWnM5gFW5MdynIS3Q1Y9OqH2yIEJDEZ8TA6uTAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZPNBUsu1jx1hkyL5WtftQNpI3D3SmMgauJ2XfjeZI0=;
 b=m1dmD4/fim7d81wq6ZNzBO2ST8nK++3M0gyMxPtxc+eJfPmLxb2MEeI/VaxmKnFYM1XV8MghjklmU2K6zGQSGgadU76kzNAhK8rWvAVo9iqj2Bel1MRYyG1/06YZYcGWZhCPOp5gmTBRBan1GHtzDfH3bY6gfFHZ0h5jRmxjc3QGWVJKHSlwAQcWGPSRLPyQI0bY0laN6yyKOD19GYdDZD/BTvLWGXqarsHV7GmVC69zpI+V5lgBT1uvWY4xIibm8TM9JhdCBGTEeCBG+rIJUpx/6r9IFhvHkTPnfzTbc9mxKUnfDClRNUEYQY0gNyz+UNNuJzhX41Wgc+G8fkwEkA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 05:49:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 05:49:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, =?iso-8859-1?Q?Cs=F3k=E1s=2C_Bence?=
	<csokas.bence@prolan.hu>
CC: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: RE: [PATCH net 2/2] net: fec: Reload PTP registers after link-state
 change
Thread-Topic: [PATCH net 2/2] net: fec: Reload PTP registers after link-state
 change
Thread-Index: AQHbDmVnT9uKuxnUUEaaQmQywDi5ibJ7lO0AgACTBwA=
Date: Tue, 8 Oct 2024 05:49:21 +0000
Message-ID:
 <PAXPR04MB8510CF87A7A2669EA4A2BA01887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
 <20240924093705.2897329-2-csokas.bence@prolan.hu>
 <353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net>
In-Reply-To: <353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7913:EE_
x-ms-office365-filtering-correlation-id: ff455da5-29e3-42c9-7b8d-08dce75cf52e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?namfR3wrqxsVeeN2bG4lXkO2KsYK9XBZht/kwkOsCtnwtuHs3FzUbXIve3?=
 =?iso-8859-1?Q?rD77ykkDIUN5rrSA9lnod8p77TRN4NqVMZ/oQ2O3PvT6fV2wD8suRNBisG?=
 =?iso-8859-1?Q?qGtu7X2yGW9ZLeQRGtYzUjnno/l4zPidiulPRRjQazhUExmA0p68qKXIn3?=
 =?iso-8859-1?Q?9dwepVKkpvNbnV5gsF1Y40rIEZn8rjetbCv/XQ5zs3sfav8TnV1k4s/+zV?=
 =?iso-8859-1?Q?dMzDb+DGhd9OIZbhGrZkBGEsWz10HWmem3pP3u50C2HyHz5Bql5wKtVwhn?=
 =?iso-8859-1?Q?Kh5rrnIweCovYaGSeL2VLXNX+Zm0uj6bZxhPE3T+7/Y8k+um/mepgbMlAC?=
 =?iso-8859-1?Q?WPlPjNy1VcNXBzm07os+DeSB5SEwIrL8bPEJWBfGmjziep2HtCuXWxfT9N?=
 =?iso-8859-1?Q?+1uo8yBOPkNhwgr9wmI7JM0AMg3nfspxsvZ8OSf9NjnVKa0xKrs8v0EP/+?=
 =?iso-8859-1?Q?vheJA6J4yuxs5G0etnqD2IVajtT/EglVptKtzw+9hJ+vhNliCHgvsdZkI/?=
 =?iso-8859-1?Q?RI5QmJ//gQwjnEUDTQfceEgk86V1XTDW5jKtv6LCg5kCb95prwjPR/f99C?=
 =?iso-8859-1?Q?cx8BoEvTYYBSOaCCvaL6iXlEwVLEG2uRs3mU0RnIhOHTFk4NoOJpuobhpi?=
 =?iso-8859-1?Q?8AXG95h+zNO50nii8gTxaFug3frDS2XOLOcq1/RST5aqB+oHIevyFRl/nc?=
 =?iso-8859-1?Q?TGFR/psRVihD13lDew0mMcmCy7oa/1aPgiXLkE/MXM4YJCHuoNqNf1hN87?=
 =?iso-8859-1?Q?SdZrrdfDxc+fdyp056Mw+WvFQGrqeH20U+wIm5Pfed9qGm5JHNowsNVfQg?=
 =?iso-8859-1?Q?hvISYu8biv3JHQRpS9VBlvI1t8tkKNxFQHVdgJCk3PVPN7RatXthLecTdy?=
 =?iso-8859-1?Q?7wV8ngfYjyL6Ygui3OqUqIG0+40KgLvOMIPutt9bz6OlCpYhHhaKagwXV1?=
 =?iso-8859-1?Q?Qn7vdkX+nlbkCmyxwW1kGhUfPfVW/etjpVx4CzzFTWh4DiFB/nbFyQHSBI?=
 =?iso-8859-1?Q?lLyDh0CpMvgh/JHjAgkhphe9YzRxwOPNtGlV0lfFhs3mVcQFnq5WcWRZv/?=
 =?iso-8859-1?Q?IjW7g6ED3EwVqN73WtNq0TgwnDzmZZ+G5P8bubMq9/b5D2bPWPUSaAm1PS?=
 =?iso-8859-1?Q?NNb0T90uYT9wk6Dwta0kzh07CpzAyotFXmQh0m3BJOiA9pkJKPYnAazJlp?=
 =?iso-8859-1?Q?vSXcPv0R9q2TmLx+eCz/IMz4gnoOMFW0GLHqKBeFbDyUTjPt7ybVrcJzca?=
 =?iso-8859-1?Q?3tQajg3kXNzmnvogIGgtE2g10Pg87X37xZLS0xVG7RRqG7Y4+ZYzpIsSk/?=
 =?iso-8859-1?Q?oH7twuIwzd6oJO5Re7jS2wKOTw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mc8fcWSZjzRTpSt0a5nCV42Vt56h4kvdgQxVFHwWwqPMDUd9sB8hg1/8/x?=
 =?iso-8859-1?Q?z0/RroqT2u/RhlbdYQlz8w+uiBp7MKtiudPk4vJp5/LVn9X+nAObNrgVT9?=
 =?iso-8859-1?Q?8IumgRpMkI/F8ya+hGjHEz2yX8keWorEpEWlUHl+KEd7C64Z+dgLo1+c3d?=
 =?iso-8859-1?Q?9LMl0hQhBDKoE5DEbosYAeWmLNUvAn7OXOoTu0qijPbH0P7IoTjrzU2qMC?=
 =?iso-8859-1?Q?aDo8DW3K5Wcb/+txiSBR15w4HrgbBg+sscGUH/pe1YXq31Kx37FgwOcGkT?=
 =?iso-8859-1?Q?BADFj5Zh38kocjmmRcLh5xbj0+Zxb1UicY7a76rtGvAvf2puJP+pqPdgFo?=
 =?iso-8859-1?Q?QmTa5CZ43mfYumOutpIL5GJ7S0KfdEqjxoyohOY7PlTxwAJNtYcXNuzVvx?=
 =?iso-8859-1?Q?oZA6LSR3C8KHmDGFd7XL+hiQofSAriJ/7DvOtJpcs6jA9ouQ7yqDnKrb+I?=
 =?iso-8859-1?Q?SX3Fx6x68Li8jJjpVM54ou3ux/4FgAujuahKi7i91PfnlxawMkJtUqt9Bc?=
 =?iso-8859-1?Q?Exj9GH04FI04sAd39US16HyRq7m1ek8hBi8rL3jW3vibWlEBWHehHcIj5u?=
 =?iso-8859-1?Q?qLyU+3UG7PHTzFNR0OnmQR1KBLymIkcta+fuMbe4zGoSskk7fJth3qOPFy?=
 =?iso-8859-1?Q?PWmfj79ZVnc6QFcKW91uGoycUwjcuEjnwXcgay5inUlHbXDR4TKhoFhcNk?=
 =?iso-8859-1?Q?UC7QATw3MWcwYg5v7k6zzO6+yCFpW1NyEuFCfp9dJP6JF5h1+MlY9tftYe?=
 =?iso-8859-1?Q?nIlGsnb8qiWAXsCm/n7q7j3PVjA79a3mV/XcnGUEdVEK3bCquvWkAxzjRd?=
 =?iso-8859-1?Q?BBhvPf1w73AcdXmYSb1bXFaHMXsVVm0CHkZGJs8fV3XgA8axxUtzEbbiSV?=
 =?iso-8859-1?Q?ijjpxBN4kHburOuz3X+Y6Eo7PMTwU8gg9Y31A418p69Ez5SU+uO2Gb++7C?=
 =?iso-8859-1?Q?T/sfhgtNFlNV8mCdmO/nT1IJPOhruloJQvtI0sydn+5hbeW0DqBabBJIGL?=
 =?iso-8859-1?Q?7P7Pphm29TjisR3Atoow4nT9P8atqzqVz0SJdgPAD9Qod0VK5PAtc/mX8x?=
 =?iso-8859-1?Q?NKlg6/2gSKEclNJhSJL7KdG22oxiXrzGq3Fi+ocZ1j034ZUC8r4XObPn/w?=
 =?iso-8859-1?Q?B+D+2j/AaP4ufFNPjn5MyzG7Jf2hIT26hqM7aNphm6JYpBWrnivtoe6eb3?=
 =?iso-8859-1?Q?o7z4fWlcDD7TRsndmQuuLb/Sm7+YVY8oVlNgBga4xdJiDxuSLJAjNKCSsN?=
 =?iso-8859-1?Q?VrcRF9vgde6kw0xgOXb0tgxoHmngpTa3b9ZWMPftI9SV6yu1WOri+L6V2j?=
 =?iso-8859-1?Q?y3KokJMqE9cr8DBG8qKFt5K+SRtOdp6wmZgkNYYmPleR0tOXVQuDiFDTsS?=
 =?iso-8859-1?Q?1u3D/3viX8lJSQ9xls/TGRmpFVeyKWBuz0RmDCpLLinAzRBRbzHwwYI4EM?=
 =?iso-8859-1?Q?Hakzdcyzpq+aJUnLLz10zedmTaJxRcTujgf2oi7by5xyoFuKkX9SwfrZej?=
 =?iso-8859-1?Q?xjyyrlE4w6aBuUB706Bpak5a+2QsMuPD4n3sIKJGUFnCp4nG1bE6umHSvy?=
 =?iso-8859-1?Q?4YQQQhy0yYCgcwd2KuDCwMvzhAt13IKn+MFQ8r5HjjNcEKic8QPyXfVCmm?=
 =?iso-8859-1?Q?s2sxAaRR58Wvs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff455da5-29e3-42c9-7b8d-08dce75cf52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 05:49:21.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3vqQYHaJpI4iuRhxcOmBNbmpK/elshSKlaCNjlfwcavU1XymQ/Hdzhd2Ll+zfyDDAx8zuvVnbW8ejlHYEHLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

Hi Guenter,

> On Tue, Sep 24, 2024 at 11:37:06AM +0200, Cs=F3k=E1s, Bence wrote:
> > On link-state change, the controller gets reset,
> > which clears all PTP registers, including PHC time,
> > calibrated clock correction values etc. For correct
> > IEEE 1588 operation we need to restore these after
> > the reset.
> >
> > Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware
> clock")
> > Signed-off-by: Cs=F3k=E1s, Bence <csokas.bence@prolan.hu>
> > ---
>
> This patch results in a lockdep splat and ultimately crashes.
> Seen when booting imx25-pdk (arm) and mcf5208evb (m68k) in qemu.
>
> Crash and bisect log attached.
>
> Guenter
> ---
>
> imx25-pdk (arm):
>
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?

Yes, you are right, fec_ptp_init() is not called on i.mx25 platform,
so fep->tmreg_lock and fep->cc are not initialized, but fec_ptp_save_state(=
)
is still called, which causes this issue. I will fix the issue ASAP.
Thanks!

> turning off the locking correctness validator.
> CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc2 #1
> Hardware name: Freescale i.MX25 (Device Tree Support)
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x18
>  show_stack from dump_stack_lvl+0x40/0x68
>  dump_stack_lvl from register_lock_class+0x6a8/0x724
>  register_lock_class from __lock_acquire+0x8c/0x24c4
>  __lock_acquire from lock_acquire+0x114/0x360
>  lock_acquire from _raw_spin_lock_irqsave+0x58/0x78
>  _raw_spin_lock_irqsave from fec_ptp_save_state+0x14/0x6c
>  fec_ptp_save_state from fec_restart+0x2c/0x740
>  fec_restart from fec_probe+0xd40/0x16f0
>  fec_probe from platform_probe+0x5c/0xc4
>  platform_probe from really_probe+0xd0/0x2a8
>  really_probe from __driver_probe_device+0x80/0x19c
>  __driver_probe_device from driver_probe_device+0x44/0x108
>  driver_probe_device from __driver_attach+0x74/0x114
>  __driver_attach from bus_for_each_dev+0x74/0xcc
>  bus_for_each_dev from driver_attach+0x18/0x24
>  driver_attach from bus_add_driver+0xc8/0x1f0
>  bus_add_driver from driver_register+0x7c/0x120
>  driver_register from __platform_driver_register+0x18/0x24
>  __platform_driver_register from fec_driver_init+0x10/0x1c
>  fec_driver_init from do_one_initcall+0x5c/0x2f4
>  do_one_initcall from kernel_init_freeable+0x190/0x21c
>  kernel_init_freeable from kernel_init+0x10/0x110
>  kernel_init from ret_from_fork+0x14/0x38
> Exception stack(0xc8825fb0 to 0xc8825ff8)
> 5fa0:                                     00000000 00000000
> 00000000 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
> when read
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc2 #1
> Hardware name: Freescale i.MX25 (Device Tree Support)
> PC is at timecounter_read+0xc/0xbc
> LR is at fec_ptp_save_state+0x28/0x6c
> pc : [<c00cdfac>]    lr : [<c08a00a4>]    psr: 60000193
> sp : c8825c98  ip : 00000000  fp : c1ddc6a0
> r10: 00000000  r9 : c18c73a0  r8 : c1f68410
> r7 : c7ef4a38  r6 : c1ddc904  r5 : 40000113  r4 : c1ddc940
> r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 00093177  Table: 80004000  DAC: 00000053
> Register r0 information: NULL pointer
> Register r1 information: non-paged memory
> Register r2 information: NULL pointer
> Register r3 information: NULL pointer
> Register r4 information: slab kmalloc-4k start c1ddb000 data offset 4096
> pointer offset 2368 size 4096 allocated at
> __kvmalloc_node_noprof+0x14/0x108
>     __kmalloc_node_noprof+0x3a0/0x50c
>     __kvmalloc_node_noprof+0x14/0x108
>     alloc_netdev_mqs+0x58/0x44c
>     alloc_etherdev_mqs+0x1c/0x30
>     fec_probe+0x54/0x16f0
>     platform_probe+0x5c/0xc4
>     really_probe+0xd0/0x2a8
>     __driver_probe_device+0x80/0x19c
>     driver_probe_device+0x44/0x108
>     __driver_attach+0x74/0x114
>     bus_for_each_dev+0x74/0xcc
>     driver_attach+0x18/0x24
>     bus_add_driver+0xc8/0x1f0
>     driver_register+0x7c/0x120
>     __platform_driver_register+0x18/0x24
>     fec_driver_init+0x10/0x1c
>  Free path:
>     kobject_uevent_env+0x10c/0x55c
>     driver_register+0xb0/0x120
>     __platform_driver_register+0x18/0x24
>     dm9000_driver_init+0x10/0x1c
>     do_one_initcall+0x5c/0x2f4
>     kernel_init_freeable+0x190/0x21c
>     kernel_init+0x10/0x110
>     ret_from_fork+0x14/0x38
> Register r5 information: non-paged memory
> Register r6 information: slab kmalloc-4k start c1ddb000 data offset 4096
> pointer offset 2308 size 4096 allocated at
> __kvmalloc_node_noprof+0x14/0x108
>     __kmalloc_node_noprof+0x3a0/0x50c
>     __kvmalloc_node_noprof+0x14/0x108
>     alloc_netdev_mqs+0x58/0x44c
>     alloc_etherdev_mqs+0x1c/0x30
>     fec_probe+0x54/0x16f0
>     platform_probe+0x5c/0xc4
>     really_probe+0xd0/0x2a8
>     __driver_probe_device+0x80/0x19c
>     driver_probe_device+0x44/0x108
>     __driver_attach+0x74/0x114
>     bus_for_each_dev+0x74/0xcc
>     driver_attach+0x18/0x24
>     bus_add_driver+0xc8/0x1f0
>     driver_register+0x7c/0x120
>     __platform_driver_register+0x18/0x24
>     fec_driver_init+0x10/0x1c
>  Free path:
>     kobject_uevent_env+0x10c/0x55c
>     driver_register+0xb0/0x120
>     __platform_driver_register+0x18/0x24
>     dm9000_driver_init+0x10/0x1c
>     do_one_initcall+0x5c/0x2f4
>     kernel_init_freeable+0x190/0x21c
>     kernel_init+0x10/0x110
>     ret_from_fork+0x14/0x38
> Register r7 information: non-slab/vmalloc memory
> Register r8 information: slab kmalloc-1k start c1f68000 data offset 1024
> pointer offset 16 size 1024 allocated at platform_device_alloc+0x20/0xc4
>     __kmalloc_noprof+0x39c/0x508
>     platform_device_alloc+0x20/0xc4
>     of_device_alloc+0x30/0x174
>     of_platform_device_create_pdata+0x60/0x104
>     of_platform_bus_create+0x198/0x25c
>     of_platform_bus_create+0x1e4/0x25c
>     of_platform_bus_create+0x1e4/0x25c
>     of_platform_populate+0x78/0xfc
>     of_platform_default_populate_init+0xc8/0xe8
>     do_one_initcall+0x5c/0x2f4
>     kernel_init_freeable+0x190/0x21c
>     kernel_init+0x10/0x110
>     ret_from_fork+0x14/0x38
> Register r9 information: non-slab/vmalloc memory
> Register r10 information: NULL pointer
> Register r11 information: slab kmalloc-4k start c1ddb000 data offset 4096
> pointer offset 1696 size 4096 allocated at
> __kvmalloc_node_noprof+0x14/0x108
>     __kmalloc_node_noprof+0x3a0/0x50c
>     __kvmalloc_node_noprof+0x14/0x108
>     alloc_netdev_mqs+0x58/0x44c
>     alloc_etherdev_mqs+0x1c/0x30
>     fec_probe+0x54/0x16f0
>     platform_probe+0x5c/0xc4
>     really_probe+0xd0/0x2a8
>     __driver_probe_device+0x80/0x19c
>     driver_probe_device+0x44/0x108
>     __driver_attach+0x74/0x114
>     bus_for_each_dev+0x74/0xcc
>     driver_attach+0x18/0x24
>     bus_add_driver+0xc8/0x1f0
>     driver_register+0x7c/0x120
>     __platform_driver_register+0x18/0x24
>     fec_driver_init+0x10/0x1c
>  Free path:
>     kobject_uevent_env+0x10c/0x55c
>     driver_register+0xb0/0x120
>     __platform_driver_register+0x18/0x24
>     dm9000_driver_init+0x10/0x1c
>     do_one_initcall+0x5c/0x2f4
>     kernel_init_freeable+0x190/0x21c
>     kernel_init+0x10/0x110
>     ret_from_fork+0x14/0x38
> Register r12 information: NULL pointer
> Process swapper (pid: 1, stack limit =3D 0xc8824000)
> Stack: (0xc8825c98 to 0xc8826000)
> 5c80:
> c1ddc6a0 40000113
> 5ca0: c1ddc904 c7ef4a38 c1f68410 c08a00a4 c1ddc000 c1ddc000 c1f68400
> c0899dd8
> 5cc0: c1ddc84c c012856c c1d74800 c0a329c8 00000001 c1ddc6a0 c1ddc0f8
> c002222c
> 5ce0: c1ddc780 c1ddc000 c11a4e58 c0a32a08 c1ddc780 c10db96c c1ddc6a0
> c1ddc000
> 5d00: 00000000 c1f68400 c7ef4a38 c1f68410 c18c73a0 00000000 c1ddc6a0
> c089da94
> 5d20: 00000000 c8825d7c c0f6c1c0 c11a14a0 00000000 00000000
> 00000001 00000008
> 5d40: c1ddc780 fffffff8 c0ccd84a c8825dcc 00000003 00000008 c7ef4a38
> c0ccd5b4
> 5d60: c7ef4a38 00000000 00000007 00000001 00000001 00000001
> 82902800 c0f8be54
> 5d80: 00000000 c02995e0 c28d4bb8 00000000 c1d2ce7c c02996f0
> c1f17848 c28d4bb8
> 5da0: c1f17848 c0299200 00000000 c28d4bb8 c28d4848 c1f17848 c0fbe7ec
> 00000000
> 5dc0: c28d4848 54524bb8 56341200 12005452 c1f15634 c10db96c
> 00000000 00000000
> 5de0: c1f68410 c1195160 00000000 c28d6858 c0fce780 c10b5854
> 00000000 c07b0790
> 5e00: 00000000 c1f68410 c1195160 c07ade1c c1f68410 c1195160 c1f68410
> 00000000
> 5e20: c28d6858 c07ae074 60000113 c11a14a0 c7ef4a38 c18c5520
> 60000113 c1f68410
> 5e40: 00000000 c28d6858 c0fce780 c10b5854 00000000 c07ae224
> 00000000 c0c288fc
> 5e60: c07ad13c c1f68410 c1195160 c07ae3bc c1d82c00 c07ae430 00000000
> c1195160
> 5e80: c07ae3bc c07abd24 c1d82d04 c1d82cac c1f151d4 c10db96c c1d82ce0
> c1195160
> 5ea0: c28d6800 00000000 c1d82c00 c07ad6a4 c1195160 c07acee0 c0f67004
> c0fce780
> 5ec0: c1195160 c1d74800 c11ca0a0 00000000 c102dbc4 c07af1dc c10a2998
> c1d74800
> 5ee0: c11ca0a0 c07b05cc c10a2998 c10a29a8 c10a2998 c0009f70 00000000
> 00000000
> 5f00: c1d602bf c102f300 00000135 c004553c c102dbc4 c0f995e4 c1072400
> 00000000
> 5f20: 00000006 00000006 00000060 c1d602a9 c1d602b1 c10db96c
> c0fce780 00000006
> 5f40: 00000135 c10db96c 00000006 c10d2248 00000007 c1d60260
> c10b5874 c1073284
> 5f60: 00000006 00000006 00000000 c1072400 00000000 00000135
> 00000000 00000000
> 5f80: c0c22ac4 00000000 00000000 00000000 00000000 00000000
> 00000000 c0c22ad4
> 5fa0: 00000000 c0c22ac4 00000000 c000851c 00000000 00000000
> 00000000 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 00000000 00000000
> Call trace:
>  timecounter_read from fec_ptp_save_state+0x28/0x6c
>  fec_ptp_save_state from fec_restart+0x2c/0x740
>  fec_restart from fec_probe+0xd40/0x16f0
>  fec_probe from platform_probe+0x5c/0xc4
>  platform_probe from really_probe+0xd0/0x2a8
>  really_probe from __driver_probe_device+0x80/0x19c
>  __driver_probe_device from driver_probe_device+0x44/0x108
>  driver_probe_device from __driver_attach+0x74/0x114
>  __driver_attach from bus_for_each_dev+0x74/0xcc
>  bus_for_each_dev from driver_attach+0x18/0x24
>  driver_attach from bus_add_driver+0xc8/0x1f0
>  bus_add_driver from driver_register+0x7c/0x120
>  driver_register from __platform_driver_register+0x18/0x24
>  __platform_driver_register from fec_driver_init+0x10/0x1c
>  fec_driver_init from do_one_initcall+0x5c/0x2f4
>  do_one_initcall from kernel_init_freeable+0x190/0x21c
>  kernel_init_freeable from kernel_init+0x10/0x110
>  kernel_init from ret_from_fork+0x14/0x38
> Exception stack(0xc8825fb0 to 0xc8825ff8)
> 5fa0:                                     00000000 00000000
> 00000000 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e12fff1e e92d41f0 e1a04000 e5900000 (e5903000)
> ---[ end trace 0000000000000000 ]---
> note: swapper[1] exited with irqs disabled
> note: swapper[1] exited with preempt_count 1
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
>
> mcf5208evb (m68k):
>
> *** ILLEGAL INSTRUCTION ***   FORMAT=3D4
> Current process id is 1
> BAD KERNEL TRAP: 00000000
> PC: [<00000000>] 0x0
> SR: 2704  SP: (ptrval)  a2: 40841678
> d0: 00002700    d1: 00000000    d2: 403b2000    d3: 00000000
> d4: 00000000    d5: 40344cd0    a0: 00000000    a1: 00000018
> Process swapper (pid: 1, task=3D(ptrval))
> Frame format=3D4 eff addr=3D4006f5ea pc=3D00000000
> Stack from 4081fd50:
>         403b2000 00000000 40344b8c 40344cd0 40021ae2 fffffff8
> 40841460 40841000
>         401dfa1e 40841678 403b5fc2 403b5fb8 401dacd8 40841460
> 403b5fc2 00000000
>         40344b8c 40344cd0 40021ae2 fffffff8 403b5fb8 40841000 408414fc
> 40344b82
>         4081fe24 40841460 00000000 00000000 401dbd90 40841000
> 00000000 00000000
>         4031c96e 00000000 00000000 403e8bf8 403b5fc2 403d3f54
> 401bb68a 403eeb0a
>         400a2aec 00000000 00000008 00000003 00000003 4084149a
> 00000000 40c2a800
> Call Trace: [<40021ae2>] clk_get_rate+0x0/0x12
>  [<401dfa1e>] fec_ptp_save_state+0x24/0x5c
>  [<401dacd8>] fec_restart+0x24/0x7b0
>  [<40021ae2>] clk_get_rate+0x0/0x12
>  [<401dbd90>] fec_probe+0x6fe/0xe2c
>  [<4031c96e>] strcpy+0x0/0x18
>  [<403e8bf8>] fec_driver_init+0x0/0x12
>  [<401bb68a>] bus_notify+0x0/0x4e
>  [<400a2aec>] __kmalloc_cache_noprof+0x0/0x15a
>  [<401be2cc>] platform_probe+0x22/0x58
>  [<401bbf4e>] really_probe+0xa0/0x2aa
>  [<4032fa5a>] mutex_lock+0x0/0x36
>  [<401bc4f0>] driver_probe_device+0x24/0x112
>  [<4032f5ca>] mutex_unlock+0x0/0x38
>  [<401bc80e>] __driver_attach+0xe6/0x1d0
>  [<402fefd4>] klist_next+0x0/0x140
>  [<401bc728>] __driver_attach+0x0/0x1d0
>  [<401ba576>] bus_for_each_dev+0x6e/0xca
>  [<401bba5e>] driver_attach+0x16/0x1c
>  [<401bc728>] __driver_attach+0x0/0x1d0
>  [<401bb4ae>] bus_add_driver+0x12e/0x20e
>  [<401bd28e>] driver_register+0x4c/0xd4
>  [<401bd29c>] driver_register+0x5a/0xd4
>  [<403e8c06>] fec_driver_init+0xe/0x12
>  [<403dab82>] do_one_initcall+0x74/0x250
>  [<4031c96e>] strcpy+0x0/0x18
>  [<400400d8>] parse_args+0x0/0x374
>  [<403daf02>] kernel_init_freeable+0x14c/0x19c
>  [<403e8bf8>] fec_driver_init+0x0/0x12
>  [<40326a8a>] _printk+0x0/0x18
>  [<4032d026>] kernel_init+0x0/0xf0
>  [<4032d040>] kernel_init+0x1a/0xf0
>  [<400204a0>] ret_from_kernel_thread+0xc/0x14
> Code: 0000 0000 0000 0000 0000 0000 0000 0000 <0000> 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
> Disabling lock debugging due to kernel taint
> note: swapper[1] exited with irqs disabled
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
>
> ---
> # bad: [8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b] Linux 6.12-rc2
> # good: [9852d85ec9d492ebef56dc5f229416c925758edc] Linux 6.12-rc1
> git bisect start 'HEAD' 'v6.12-rc1'
> # bad: [fe6fceceaecf4c7488832be18a37ddf9213782bc] Merge tag
> 'drm-fixes-2024-10-04' of
> https://gitlab.fr/
> eedesktop.org%2Fdrm%2Fkernel&data=3D05%7C02%7Cwei.fang%40nxp.com%7
> Ca582618b128e40fda60308dce6f00130%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638639165713892201%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3D07kr3KH0waKzoZkAYyLQ6YB0Ep4S1kVPSaVUBtUS
> G4o%3D&reserved=3D0
> git bisect bad fe6fceceaecf4c7488832be18a37ddf9213782bc
> # bad: [8c245fe7dde3bf776253550fc914a36293db4ff3] Merge tag
> 'net-6.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/ne=
t
> git bisect bad 8c245fe7dde3bf776253550fc914a36293db4ff3
> # good: [9c02404b52f56b2c8acc8c0ac16d525b1226dfe5] Merge tag
> 'v6.12-rc1-ksmbd-fixes' of git://git.samba.org/ksmbd
> git bisect good 9c02404b52f56b2c8acc8c0ac16d525b1226dfe5
> # bad: [e5e3f369b123a7abe83fb6f5f9eab6651ee9b76b] Merge tag
> 'for-net-2024-09-27' of
> git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
> git bisect bad e5e3f369b123a7abe83fb6f5f9eab6651ee9b76b
> # bad: [c20029db28399ecc50e556964eaba75c43b1e2f1] net: avoid potential
> underflow in qdisc_pkt_len_init() with UFO
> git bisect bad c20029db28399ecc50e556964eaba75c43b1e2f1
> # good: [e609c959a939660c7519895f853dfa5624c6827a] net: Fix
> gso_features_check to check for both dev->gso_{ipv4_,}max_size
> git bisect good e609c959a939660c7519895f853dfa5624c6827a
> # good: [a1477dc87dc4996dcf65a4893d4e2c3a6b593002] net: fec: Restart
> PPS after link state change
> git bisect good a1477dc87dc4996dcf65a4893d4e2c3a6b593002
> # bad: [1910bd470a0acea01b88722be61f0dfa29089730] net: microchip:
> Make FDMA config symbol invisible
> git bisect bad 1910bd470a0acea01b88722be61f0dfa29089730
> # bad: [d9335d0232d2da605585eea1518ac6733518f938] net: fec: Reload PTP
> registers after link-state change
> git bisect bad d9335d0232d2da605585eea1518ac6733518f938
> # first bad commit: [d9335d0232d2da605585eea1518ac6733518f938] net:
> fec: Reload PTP registers after link-state change


