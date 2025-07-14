Return-Path: <netdev+bounces-206551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA7B036FE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2081703D7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F67204C1A;
	Mon, 14 Jul 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="EPkZUyZO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC518CC13
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474202; cv=fail; b=Z8ZMZK1bh19TE5ymN3I4bFcVttoZBYyKt8nGSZBMmDcNc4M2IIuwP48Uzg8LVEzfd3zOP8TlGuzR2/EMjfJVdQU6GsKz58G6MwCYY44ru6H484a7NWvMdbdz2PPyQzHKQIpgYYDg3syDhDtbl4ZWtXh6PsPXyO93JnIWIHsXvA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474202; c=relaxed/simple;
	bh=hdEdytp8gum5PlfQyP6THqF0OiX/52X6wZcbyXYWGqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7DQvnj5E60JHnNU/EYezy7CImnx771Vhee3sC2AkK115OpFS12Fs6JSs/e25zyfaxrnNz8IjA3AICJfuY3/FN0Zo6YuKhP7WguoSXjukbhFiYq42UVFl/k6I7zpeoZnNe6p05RA8Dsp2EjD73yMbs1V5BcchBYzJ5VVoMKIC8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=EPkZUyZO; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnRyLepZSrYT2mZzHDEyJyyB8dENxGyWUAv3PA8raaB+nfD/XkaEWGYVwjBoh2+kZvJ4mQ2AEQDI0FRt5ojm4rzKvYaotCWquSjP18OHpL3yLyxWK94E37zBfSaJz69GTxPl+uzw8LnUvLTksoHmxpL9iJCNiEIeTuBQlxn87owsLo8no9y7YvxfuJjJPnNhicfVCxUiDlb3NOTRVV5YzRIl9YUZj5wb2BxbM8MDPGE3Zg3eMbfjtkXU2hGUS05hbzQI+QycPL9pZPV4posro8akwPRLWHyy/C571jDY3zN7MfEevrdy0E+lR+IoBR8QVn3u+Nadn11AG76elMi9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPPBkYnDiWij3vY8VP9Io4YyFM5yvAanokl557JvhHw=;
 b=Xv4npI7ttU+e/ABh8yEfsorUO5v8VCHlSr3/u5B4ewSXBL/7Ok8GwGn3jao57qQRhQuLORR4WBM2GS6GGd8eKfRK1CLO0B582uX5q1GXq9asqKoRe6qQGwvXBSyZQjlIPQInoqEAVK6xYvUoTaR6ibV43XnX3FrlSAyVo3lQUZyVC6ASvgCs22qBgpY4WNM/Ed4crWeODBo3f5RLnHWhePP9lllc21ScEbV2yypqz8C4C3UAoWnUH3MWia4WYzEb/ikaxpG7Jog1UVm7IAHcg2yuJau1hg3IGqGzvqQAoy2DQTOuuWWxeOWQKdBbSwl7uPD9UaAg118pqmlTPjKQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPPBkYnDiWij3vY8VP9Io4YyFM5yvAanokl557JvhHw=;
 b=EPkZUyZOJFlR/FMjvAn3fhCktp+Jwfz7Kx/DdM1b/YoG/sXX5hk3FIKTU+PCTeDNi116JGZzHpqZGD4JRQbsuruPr8Xgb6mbLn15NYmOiznEEuTllHd0BfDRUmXmcNGCTws3T0+vMzn/nfziygDK/Tu/r8Eicu8mCfUk0MaU7QPpWiSZD4TuLzqC/XD1YWRsLpn133+tSk22UfAvJ4hRZLr4TKfEgTO3uM78VvpsluIEAQFrmqSOAGXfvZiUMOkVjzVJl5CAqfAr5x0ItaeuQUYV8j66dOiIX8f4JhWPur9FXJcj4Aj9gXgQyz021NTUrymrcopqDGRtGIaoddO7lw==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by DM3PPF98F24D752.namprd19.prod.outlook.com (2603:10b6:f:fc00::74a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.14; Mon, 14 Jul
 2025 06:23:16 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.8922.017; Mon, 14 Jul 2025
 06:23:15 +0000
From: Jack Ping Chng <jchng@maxlinear.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
	Yi xin Zhu <yzhu@maxlinear.com>, Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH] net: pcs: xpcs: Use devm_clk_get_optional
Thread-Topic: [PATCH] net: pcs: xpcs: Use devm_clk_get_optional
Thread-Index: AQHb9GZcZSrTE+GSMUqIZkVsSWO2HrQw9CeAgAAx70A=
Date: Mon, 14 Jul 2025 06:23:15 +0000
Message-ID:
 <PH7PR19MB56363847B22AB01C47CB327BB454A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250714022348.2147396-1-jchng@maxlinear.com>
 <a9072d67-d48d-4c43-aa9f-2957c53b3772@lunn.ch>
In-Reply-To: <a9072d67-d48d-4c43-aa9f-2957c53b3772@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|DM3PPF98F24D752:EE_
x-ms-office365-filtering-correlation-id: ddbba4df-71a3-43b4-a111-08ddc29eea8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tblNvV5/HfVQdkTUgerBlqiZ0Qu2dncHWqqur8lAntM2/BcJzYIQkituT7lF?=
 =?us-ascii?Q?4U6QAHrxxANyK2DvJaMnb72QuHkDkHiBH5tuNloHDn7qSr97u9U3RilrPYl6?=
 =?us-ascii?Q?++22ng207zTrxJrVNXx8z37uLchTrZrQGlL243jEUawQgM/HmQG7S2eLVYG7?=
 =?us-ascii?Q?JSN28HW9VhgPTCdT07GPMMZIjS6aJzvqs5+CJpHYGn7O6LTCuf9Qe5BZDT/C?=
 =?us-ascii?Q?otiPDtZwnwrj08HxW1NeaNSUbkS8JfBRoLbEbuuxSfK7JjEivxy+wQ8pDm9n?=
 =?us-ascii?Q?LUVe5q99YaM5pBGYSC81RblPkfq0AGHsg9tnZEYvhPnVbTGiMDdIYxHPvOFP?=
 =?us-ascii?Q?VCeVY+N/ihJU0ekRwGoAlxGqDbBQ6W42aa8Goi7xqve6xICfhqjldRT2zMBz?=
 =?us-ascii?Q?03IlwXDiw+irmyaH5mKTZpfaJdTUK/rBicjzcYrPQ04NpBBVItQOuJAXnjPQ?=
 =?us-ascii?Q?Ssrb96EKq7oJr22ascr1uCcgYyUzFJqOX0f4o77etoK+9whBamKNm4fMG3pR?=
 =?us-ascii?Q?eomatoSIQcmt1t6PLa61MXHQmZuNqlAtMEKkKY7eHCmJcEODVEg+KeJbgybw?=
 =?us-ascii?Q?huDmYfveum5oNUUQNIOJXj4wduLeuuRXTgEUswfQOZ4U5ZOLVk1oF16JdGG8?=
 =?us-ascii?Q?hk+pAfgplePmfLbmI3f3PqUMENLwlVVAQeSaKWuy2dfglcY+btoHCvd/v0o3?=
 =?us-ascii?Q?8OL5O5vTChTwz2KvTk2gr/80vbx/5GdPhqjqqchY/ehsSwcUCQkqbPOg2RH+?=
 =?us-ascii?Q?lE+Oq2dMmHJQFTBt4dENTAjmBwV/qrQmdBvfGi1RrXGYNZIxABqiY4ZrhZZP?=
 =?us-ascii?Q?eZXpid+4ujkoAnL3z+L3u+nyNrqPrABPSpENE+LgAe704O9F9yYd8/mZk1os?=
 =?us-ascii?Q?jKoarJf8DrR4PWWXPf91FuSb+VhpVyePYbMRq27w0rc6AfPzFyuQRnWNiQjW?=
 =?us-ascii?Q?K8ZXd0ghFIBT4IwM+84U19ev3l/MVQcdvUp7zzvztlDToSpFRdWKl1NcHBuA?=
 =?us-ascii?Q?amc6m/4VeE4kkVz/RBoYxz0dv3bG33WL5Y+fWw0Xs3I+nzhHtfL1fNEoMpda?=
 =?us-ascii?Q?OtaZ5AipB9bjLtPQIdZU/6KmGYXcWdlEhASSimyxl+Ev8j97vqzX9TY1+ehq?=
 =?us-ascii?Q?85wPx//9ca1qOnl/YZm1L01Z2dwbiNbsQ4gw7d+gNcHhW0BL1SBBQY2r4tJ0?=
 =?us-ascii?Q?wsEB6s48xzj3gwvCt1IHsJkHYpp0UIDVQHRp4b/tikx6ewpToregE0TmKsJA?=
 =?us-ascii?Q?Y5xIczw+cqwUiYermI1lUixxL2JwitXV+K+L8CMO+UINn2vvmuMV/0CenhRG?=
 =?us-ascii?Q?xx/EacIBANL+lTLKHumcWHLf8ioCK2x/JRrZ9jqGSZ36yqVbi1BML6co47tA?=
 =?us-ascii?Q?RoYrSzir9exZeHnwPetofEblEeHvB16AI39zoCpas8TkwHxtGwjU7AK1a608?=
 =?us-ascii?Q?oEp/zM6q4yw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3qwOAiYmpZ8zi2OTSwQtIOmtZKx6WShY9G/2d1gIgLDye9bNzvzYQX8PhhE1?=
 =?us-ascii?Q?mV7/Z/eFOZrIDl3jtXcY80xGIrnKyzk3RsBNlnJIMghaGve0r6pbXXu3n7Za?=
 =?us-ascii?Q?JQnszbWjZ/Ydsnw1Sdto8dWHhARv6UBv82cz2GZH/Ls9gS0jcAn37DUcgzXH?=
 =?us-ascii?Q?ol4O0KprLtX2ukCx60gGHs3MiQ4vJX5uErOu/dC2wEkN6pwePMf+db4KZJJa?=
 =?us-ascii?Q?TCYsiZXLbOhDW0+OkRJDlKu7mTGi7rPNWEryIJdPfBDSv5PwErxUhBAj8nzP?=
 =?us-ascii?Q?gMEdttetpwJ/ZzziAZrEEIC2Fi1fEiYM88OvuPn3mcltcX10nnpExKap/dtV?=
 =?us-ascii?Q?VyAQgZ77+mVJrFv0tj8ZnUzp7Ce9azEmr1rcHiOaHTJOM+GszaXLixek3jA7?=
 =?us-ascii?Q?CF13TqrSVmXXvawNJvJhteh1zqewwdFs5m460ZU7be29hcB5chpmCPlxEEon?=
 =?us-ascii?Q?/8t6oQpXL+3HaLf2GKKTxf3xoLbd+gLPG4G00lUXlbwQWEddmwc0wfNST6GA?=
 =?us-ascii?Q?352WcTOU8zWTbtBactpWu6BPGIaseqzdGjwgH/Opvbb+eL35ePpyE4DGKtWM?=
 =?us-ascii?Q?st5p8kt1KNJu2SbdURPGgpjQ4Bakuw6BQ9DNLDm3H4C1UahpP9ROONv68F4v?=
 =?us-ascii?Q?3dC1pTIAktr0V6sBqiV27Jn2sIJjbNvDUbmjLdNLEBWgGFQqLfS3rtGJmTE7?=
 =?us-ascii?Q?RKsamVwy2vrNDm68jsoQp4xXCtavGTXpq/rf9q23pvYPK2OAyJBLz2HHOBPs?=
 =?us-ascii?Q?u+l+H1UtEzi74MdJqz0WuOTeEiFWYTgCqDLWDHNJo9YY6B4wXnX0UBs3qeha?=
 =?us-ascii?Q?I1ZzUviYGW1sQtRjw1McLpNIQv/Xy8MbcYbLzFqnr2BT95za3UjGOFnHO2MH?=
 =?us-ascii?Q?KQw4pvFdq/id877K8bNYd9gIkhbucsIOw9YPgU4rBEW9oESzKSd/4U8RV7yG?=
 =?us-ascii?Q?xENNa09xgOlaXmbGBFcyL1dVOV3YS5Qd7MCbYiyvfoAR7a7TNAnyW3a+Mw+k?=
 =?us-ascii?Q?cP5R4x8kpnbViaTM0DeMFBDQ2R6TVhj8eqNxcnVBSgjpXwRKVMvT3wFPHRMu?=
 =?us-ascii?Q?F6fbai1cZJMdLOB9+kvMgSTEPUdHj+PWwUZruAO1KSHaUowCUhOr3FL33GiE?=
 =?us-ascii?Q?SfSBLkkrZ22PkiWZtLeybcITuSqnuUdWfAqtN1pAc3foZ5GwDItyqk/0uw3k?=
 =?us-ascii?Q?O0sZYFbXtLRlUa+1OlCapM+zIuMFr76e40R0XtGm9OPSr5eagVcop0Tw7Rkt?=
 =?us-ascii?Q?e0Z7NpD3GtlmOVomy7oSO0Q21+o/aUNPT6Pc/M+GYDOcEnYas3AWgLVZkcqU?=
 =?us-ascii?Q?ypmx6D/lJ6KghMsjnxdmw2kZLUioHx/757LMG6Je1gp5uJiNVItAwV92EFzc?=
 =?us-ascii?Q?iB6vgbJrbMNADRmqad++3vf7RtUbdgzS3cwPhjhTcUBAf89snKGRx9Ath0k2?=
 =?us-ascii?Q?j2Nd5Na2PtX8FqiWuvmbHvvUIN7DPlmuho5LR0zPH98NoYQnXwHjZnys4KHa?=
 =?us-ascii?Q?wOqol2jtrjgIhr8rITabPLrqK8JZ9D3gW7+4ow/PxFPUApJ8OVl4K7gG6xpq?=
 =?us-ascii?Q?2KqT2nknkzUKPSIGgHQ1RkhgDpLYYcYTastJY7sP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbba4df-71a3-43b4-a111-08ddc29eea8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 06:23:15.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXb6n3CjRLgFULREkulWc5MJfOBFwjvMyBLkvR+r5ipeEI8ioukrCMgxspBSpy4D4lupfIP+ptibzryPPC9Abg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF98F24D752



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, 14 July 2025 11:22 am
> To: Jack Ping Chng <jchng@maxlinear.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net;
> fancer.lancer@gmail.com; Yi xin Zhu <yzhu@maxlinear.com>; Suresh Nagaraj
> <sureshnagaraj@maxlinear.com>
> Subject: Re: [PATCH] net: pcs: xpcs: Use devm_clk_get_optional
>
> This email was sent from outside of MaxLinear.
>
>
> On Mon, Jul 14, 2025 at 10:23:48AM +0800, Jack Ping CHNG wrote:
> > Synopsys DesignWare XPCS CSR clock is optional, so it is better to use
> > devm_clk_get_optional instead of devm_clk_get.
> >
> > Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
>
> Please read:
>
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fmaintainer-
> netdev.html&data=3D05%7C02%7Cjchng%40maxlinear.com%7C886c34c316bd44
> 46ca9108ddc285a138%7Cdac2800513e041b882807663835f2b1d%7C0%7C0%7
> C638880601486449721%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
> RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> D%3D%7C0%7C%7C%7C&sdata=3Dg%2BS4nOWPMRXUHR01haZGoySgGTFr%2Ba
> NlzI9r0v%2B%2FjLc%3D&reserved=3D0
>
> You need to indicate what tree the patch is for in the Subject: line.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

Thanks, I will do that.

