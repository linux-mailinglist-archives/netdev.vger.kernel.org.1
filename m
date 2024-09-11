Return-Path: <netdev+bounces-127229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A46974AE0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B893B22585
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C65139CFF;
	Wed, 11 Sep 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mVNMw7Q+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26F7E111;
	Wed, 11 Sep 2024 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038069; cv=fail; b=inpEyomPq0GPv3tDPKWcxvd2R+PqhgfWwx+LCkFT5jEXuR17Z2Gmda+RM+B4ZJnstpW2qu9h+ixsiUNdsS6eCSP5GWkvFOPHuU4fGZBqrdUHeANcPCBkPP7hcYrLD+nCnepd3NERZi1E2tzP+R+nUXR2dsG+YIgpSIxVSOMpUJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038069; c=relaxed/simple;
	bh=eW8rl99AqbBPiVub+zqsuiMZnL7cSC9M/N/Vmov5k3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJ+mnXnYCai9sQu1mqKIG01tRhJK8t+5EFAZOpk7bZ0eyo5IV1gv1yB9tjL3KdtaoG7q/LGjsYfxyYoFQqlledBUQBpqwLX1Js176T/j3CJJkyGkQWHlc3mgbMfsqR8qesMthBdGiTkzz9zeN4UVeAjfBOnWes/5URPKNj/Izmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mVNMw7Q+; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTrC2uKJcJWX0orvjoHsz/j/sVRz6zVcVn58RlkRhrtLc/6xmP/4Cs+DfPFo96UPZfbCTq3F2uG2keEvo2oFL5IMYUi8caz1zTqbsUYPSFYhw6STXKEAFPjkqeD0L1UjaC2Awq8Db5RkqhCBb71clTnHj8smfwSS98y56VXsWdMH85cp5nJufju98VNkY8r8CFQsFNDQSOD39I63L8hAVDlDM2DPTS6wuG5UNtIQ8+bq7lpRd7vpQqGM5jISrgDET9L6QiLDBhDPePtFkXml2hxFX3vDnNMQoo0b3XVlDuoZ1Jt21TYlDglpdmHI6I+BmaKS2W38A4MzjH62CaH6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2OlENML/mAKRCYJvJQtzaQ4FAOvpLg4aaexgR+pKBs=;
 b=XttqbmAQFM0SQr3SjfYQMjBxHL66cirwIFncgjfCMLH3IMqFZDlc7x5RpCloRxDvgcnsCh+0PhmI5uULGWxVb+GJZHGRRiXDG5dJY1kH4gXunaxMnU3mE+csvjLjyXlZPwgO9PEw4UvAMBUnv1n29Wa30VeV04gFdlbJxw8bnH5QWm27Kp8aVprwoEX8+dvab9saeWlkjjPY8gTlwhiIVa7g4NYmOcXDbogxg+/NW7mCPqYdt/hAOWmEWJyLSBZaf2OdoNHT1OjC3DbdisUSkLaJfni/t2sLWWcGsyFkwQjhvy6DbtIHuGZqWab6IGcSTHtpTIgBjbCmYbl7UUoOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2OlENML/mAKRCYJvJQtzaQ4FAOvpLg4aaexgR+pKBs=;
 b=mVNMw7Q+j5kHEi6JFMOS6+44EMVaZPonVLz4aWP5vbLnxLl4FLrbiAYPOZznY0J+qJjxQHzk+KG6rAas7NLvWlAs/gdEBIvxyyE2v2Hg3QwHJNo+MAkrRApp8G60/y/a+U7n13krLSftTxl0KS6aW0jkPqAcR5gmpiX6PpD+Gso=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 07:01:04 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 07:01:04 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
CC: Andy Chiu <andy.chiu@sifive.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ariane
 Keller <ariane.keller@tik.ee.ethz.ch>, Daniel Borkmann
	<daniel@iogearbox.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>
Subject: RE: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Topic: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Index: AQHbAw1QlhWoNsDZ7EOtVdYAw5Ers7JSJksQ
Date: Wed, 11 Sep 2024 07:01:04 +0000
Message-ID:
 <MN0PR12MB5953E38D1EEBF3F83172E2EEB79B2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240909230908.1319982-1-sean.anderson@linux.dev>
In-Reply-To: <20240909230908.1319982-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA3PR12MB8048:EE_
x-ms-office365-filtering-correlation-id: f4762534-0a05-4a43-88d3-08dcd22f8086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W2aKWDcqOcLCS9Ul1slRIMZdZTMsZoacAORZY8gHsfX6VuphbHMjRafTj60t?=
 =?us-ascii?Q?cO5f0T9gHUjTZeVE89r7p8eDUSKKlsaBRa/h3KNsPtGZW9KQuLslEM8va4A7?=
 =?us-ascii?Q?kt3PJqUOQBFOeVPnBCkH488bynA8qg2/WUO7c2sSPM/J/AsYau+tbx8oX6Bb?=
 =?us-ascii?Q?XWW5mrzlguuNJcFylAvs0t3fUatHFxvYWVBxOUaIapoJx0r70TwI09S7e7mC?=
 =?us-ascii?Q?Br5V8YXi1q+r2e4QeH2ualaEp4vuSjyrSluEEtV1OLWVgeJWn6fpocKwihbn?=
 =?us-ascii?Q?ULrITZXixPO4K4btTVXyD+N1Rc1geoeMW59+sidHtH5KLayPviZoIJIlDWpt?=
 =?us-ascii?Q?TXd3J6ivipnHs00gM8Cc+OBxTOHOzyaPbNsUQWT6OLHq9hs496zOpAAJxjR6?=
 =?us-ascii?Q?AvrhmDzJjvQKaLc9Yb/hM7OnEDsGbQWMiBOoKCKZbl2/iTDFVzdCgz/h+0JW?=
 =?us-ascii?Q?NSc/U0XQBBPvcYJQ4pKNt3qGnMz0MNnmLAPUODx6HRDIP22kKX9Z4PlugXgx?=
 =?us-ascii?Q?Au+CSWfRGg38ltaw/15jB0DMftH001liAeTTLKR+r24MPJ4d77l9IHEY2xtF?=
 =?us-ascii?Q?Q9WvLXDYR0tafMzg1NlES7xAE7i/6Gw1c0oYKxI556+SroE46Qid1YqZcaPL?=
 =?us-ascii?Q?uxsMsMh0ShD3dmhVnUZS8EFPzBRxZA0K+q6i08HgXtgvfmCRu27VVtBCMNtF?=
 =?us-ascii?Q?tQQ0uuNsGik+way4Dg+SAZhh+6h2OwdvKjwq2Vy8/lpO8FkONA0xBpncxD27?=
 =?us-ascii?Q?YQjx4ZWNL2XfE6Ze4+enWCOin8brI2b/AdDhviZoHj6nOIkmZXDAyXS2Nwrp?=
 =?us-ascii?Q?bIzKV1a/n96G4fC5HwwnwKsyyEzy3g5AeUY2fGJHHOAr98edwAN6baZ7iBvb?=
 =?us-ascii?Q?JAfDEV7aEaEzEh58m8rGTrKkgSszGhGbC3Uu9vcDiOx7TzmdSy9/u1AGhWdU?=
 =?us-ascii?Q?1H+nsi05/qXAD6tjqgSljqJnKOsv5F3KDaFad0BbAr2hxR2UjbaW7SFsgubi?=
 =?us-ascii?Q?qZPLVxCwQfj69rCSwwH+Y6NFAPQy9wdh9wFIdEdLw9oBB3JbxmgzG7gDa0ki?=
 =?us-ascii?Q?yJ58EM5wXoT6d6WE7dtAAdQ5wi6HCfe4LBiL6/Y7soiWhYP9kDkhX/2U/wBV?=
 =?us-ascii?Q?Vjbjg/wDF6aPY8J6KQro7xI2/gIL6kjYAo/OO0zfPT9SF6Fx5caS81PmqOKG?=
 =?us-ascii?Q?9KAiS0/C6H0LpSHI5+l8HTFtuMdEmPsAFqeUiSTpkQ82NOrf0qHIFRbnXyI8?=
 =?us-ascii?Q?GdjKuwbKhCiNkaf1BPD6bs6smyB42lu7VYK/cTNws81mUa5EWuiSkpDQqTVk?=
 =?us-ascii?Q?+KTw7fkd6hAobAh7/0Rx2wZtYOe257BQgU8d2Sm2SsDb3wmTX4XS+Or9RrC9?=
 =?us-ascii?Q?Y3jNzKmMqVOw+l7+6UVlS1cvMyjGJiUztD0U/Uj/iywfdvWC/KwMWmz8K6/B?=
 =?us-ascii?Q?6iQ5NQBUMso=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nd5luaYB6i4Ga8gMCR9A5+h13SFoJCoiRIertbOmSLyk744np51gQorZqpWk?=
 =?us-ascii?Q?bYoOOBv6DdGCGTHF18GzSmj96DTnqcUyzP3JJKbhGCutIxcPp+IvXuhltrID?=
 =?us-ascii?Q?z3hheEJtDYBPROGuGdiJwLGIyHZ4hELPp12yU6a7db0/r0xpsfwUj7Oh9Uer?=
 =?us-ascii?Q?SwTt/zXF2Zd+DmVfZgj2Mqa+JgCvO3v7/mI4MxOd0HSMNrsPGZdW7x6wQsIN?=
 =?us-ascii?Q?kkhRPxx5U9AgUkF9Qu548VKQ9jcWevMwcRFzG5/F271CinEm9j+JnpYIgvNe?=
 =?us-ascii?Q?adV4qXHwzF+7OMiNZff0QnW9d2gGxMKi2+bjMG/It3WMRGU+ibFDNdAI15Rg?=
 =?us-ascii?Q?i2EWElsCnWGKmI5zm+vISSVRQqXSpl2H6vF7zNPRC7zhqwmJR+3472wSdDgE?=
 =?us-ascii?Q?XYHV8obWRyVd4H/846Ri+ZcwnBLvA+nvX3Gfpjyoq6P9yhtKQFvODLMlJ+8w?=
 =?us-ascii?Q?qCL8dUxlnl1pVb1NTgUZddaa8qgTq7ORbHbdF3F8uaZusEySEsCEoiukTpgm?=
 =?us-ascii?Q?oM7MDu7reiEqMNoPWPzcomFB/bc4G527nT9qyoTiyka1OIJiBZdF0aMInjrv?=
 =?us-ascii?Q?UN9Ugoth1EkE+FLXEkBghR7BHM9qkYh8tGbib8QGLC4cZcBdQTvMRdA47zES?=
 =?us-ascii?Q?YyIZWi6suudeu1CWNUny9tIQnl9QZsxSFo18QHUpxHBYoWX1EdShlJpFw8R/?=
 =?us-ascii?Q?pE9F1m1eiovqEMvnoWS0k3bNZV0cMt1L1t1tj9VH5eSdiDr++XltM7BezLbV?=
 =?us-ascii?Q?QczuHkwpp2ZyDSkBsLEOHZS20IOo3IdDvXMLT0U/jAPtnmz1lKBEONtzj6sX?=
 =?us-ascii?Q?D3jV5GqiLAyz7NBJvui76kvu6c6r9YzBrkxoqk2P4XEGBG52mFbebHhJloLT?=
 =?us-ascii?Q?aVqvxUXHHJPSoRTK99NfaegpyHmgAJCJhaDoTmIZVix6N/20+XCDWdCeoOaQ?=
 =?us-ascii?Q?uX3Cg/JkKl9cYGAQOc+ujWDJwSRs+sp1t7E2x0iXpiQIRcg25qULGs7wQjki?=
 =?us-ascii?Q?0EZu+vmNtY2yhIixFwsRG/aozkJXMbeb075PutXgAlzTSanXB2dAZkLSrGdd?=
 =?us-ascii?Q?qeMS6RhfsmdPosamp9SgH+6wu1sAdL/hXXjIkA9RtpqmqN5N4nz/m/wOW5j3?=
 =?us-ascii?Q?v+a2L5KUtsGS7lPeCUV5O3CP1y0dojQiNt9ccj1i1hrqhVf7uY2nldCultP0?=
 =?us-ascii?Q?n98HC/SPzAMM7KpUgf55y7QSFM5u+lg5qnNryi46XlDw0izrhLKx0DgYKl9n?=
 =?us-ascii?Q?gJWzDD4pwuRCXk12RGjk6jTt7EW5vE028vXGMza5kYLKcN1yonRqh28TMBZc?=
 =?us-ascii?Q?WyRM6KqDjKYmMIjcUTTOBnichhsIS4goeyvLndcg6NPoRbIZ9/nlN/tZ/NO8?=
 =?us-ascii?Q?oTusqkjVWD34CW18bq/P8nnaZVjrsbtLXZ4BXw+9PPPIlbgBXzdK+8moaM9d?=
 =?us-ascii?Q?5lf3neD6xhf5c4utv1eOAMom7mdQB6nyDvcjDEY6afz816w8Tbhx0oOwqeKg?=
 =?us-ascii?Q?+Jrs9C5w4B9Atf/rtR70A4n4wlM1nwLPWAdQnwSjRMH1HTVMErrpcmXIZ7k7?=
 =?us-ascii?Q?aWC7GeDwJ8urNqQWj/U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4762534-0a05-4a43-88d3-08dcd22f8086
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:01:04.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IW1T7F6Qc+7lvXVyxeqWajTsLeSZZGJ0J52M2I5kp9YsF3kIBhFDEog/S7H69WQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, September 10, 2024 4:39 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org
> Cc: Andy Chiu <andy.chiu@sifive.com>; linux-kernel@vger.kernel.org; Simon
> Horman <horms@kernel.org>; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
> Daniel Borkmann <daniel@iogearbox.net>; linux-arm-
> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net v2] net: xilinx: axienet: Fix IRQ coalescing packet c=
ount
> overflow
>=20
> If coalece_count is greater than 255 it will not fit in the register and
> will overflow. This can be reproduced by running
>=20
>     # ethtool -C ethX rx-frames 256
>=20
> which will result in a timeout of 0us instead. Fix this by clamping the
> counts to the maximum value.
After this fix - what is o/p we get on rx-frames read? I think silent clamp=
ing is not a great=20
idea and user won't know about it.  One alternative is to add check in set_=
coalesc=20
count for valid range? (Similar to axienet_ethtools_set_ringparam so that u=
ser is notified=20
for incorrect range)

>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net
> driver")
> ---
>=20
> Changes in v2:
> - Use FIELD_MAX to extract the max value from the mask
> - Expand the commit message with an example on how to reproduce this
>   issue
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet.h      | 5 ++---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 1223fcc1a8da..54db69893565 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -109,11 +109,10 @@
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet
> */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits
> */
>=20
> -#define XAXIDMA_DELAY_MASK		0xFF000000 /* Delay timeout
> counter */
> -#define XAXIDMA_COALESCE_MASK		0x00FF0000 /* Coalesce
> counter */
> +#define XAXIDMA_DELAY_MASK		((u32)0xFF000000) /* Delay
> timeout counter */

Adding typecast here looks odd. Any reason for it?=20
If needed we do it in specific case where it is required.

> +#define XAXIDMA_COALESCE_MASK		((u32)0x00FF0000) /*
> Coalesce counter */
>=20
>  #define XAXIDMA_DELAY_SHIFT		24
> -#define XAXIDMA_COALESCE_SHIFT		16
>=20
>  #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion
> intr */
>  #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay
> interrupt */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9eb300fc3590..89b63695293d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -252,7 +252,9 @@ static u32 axienet_usec_to_timer(struct axienet_local
> *lp, u32 coalesce_usec)
>  static void axienet_dma_start(struct axienet_local *lp)
>  {
>  	/* Start updating the Rx channel control register */
> -	lp->rx_dma_cr =3D (lp->coalesce_count_rx <<
> XAXIDMA_COALESCE_SHIFT) |
> +	lp->rx_dma_cr =3D FIELD_PREP(XAXIDMA_COALESCE_MASK,
> +				   min(lp->coalesce_count_rx,
> +
> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>  			XAXIDMA_IRQ_IOC_MASK |
> XAXIDMA_IRQ_ERROR_MASK;
>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt=
.
> @@ -264,7 +266,9 @@ static void axienet_dma_start(struct axienet_local
> *lp)
>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>=20
>  	/* Start updating the Tx channel control register */
> -	lp->tx_dma_cr =3D (lp->coalesce_count_tx <<
> XAXIDMA_COALESCE_SHIFT) |
> +	lp->tx_dma_cr =3D FIELD_PREP(XAXIDMA_COALESCE_MASK,
> +				   min(lp->coalesce_count_tx,
> +
> FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
>  			XAXIDMA_IRQ_IOC_MASK |
> XAXIDMA_IRQ_ERROR_MASK;
>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt=
.
> --
> 2.35.1.1320.gc452695387.dirty


