Return-Path: <netdev+bounces-62298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DC8267A6
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 05:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1988281B90
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 04:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0D138C;
	Mon,  8 Jan 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/nBfxPs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063C79CD
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704689707; x=1736225707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SLFh74xMZtf2jJAMu3c7qhliE03ytJOJa5HmgfhC29c=;
  b=C/nBfxPsq24wyHgaVmWzQbA/qNQMjKDNpbZLvJAVipr2UTbwevxye7b/
   NhgjIaTgYuNRgY+V3w8q9S3Sr26Fa4SdkNgOtlMlfqRDSNNicA354s1KY
   C9rCuJp34nzPGsbiElSVZZAhOXmVtqopYnS71fD5wTf8Vm50VQROOUuZG
   DNCxsH4PGP53QdzoSD5l8A99/aXyAt+9KIF75GVwW6TbJJ7Wd5n79OFrH
   gU4s/QIAOAuPXKGOGMM6l8EdzUlzEmWQ1QZLUA5KmaYpXCv1zfzb2hP5+
   k31NneEI6redlZ8FnzH/P4fDhQvupib5nQ5vQr3N/Xyf22uYU+5L4Fww9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="397516279"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="397516279"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 20:55:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="784735409"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="784735409"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 20:55:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 20:55:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 20:55:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 20:55:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 20:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXUBq9v+OfjVUvvZr2BQd4E7x4MIZHA1nmtp7OxSdK1AcG+qAMsVXhwoVXGPgxrn/2K0QzynDBS7/84FA3lqrncJLTYzKPphPuFWs7daSEUuzSwUqKrK/3pZDURQem1ML9oU7ojQ+Y+jRLIDyKzbF11tORlWvxca3g0++VUgDID49TUHgOu/ojEQghDzAUHI52G1ApeFwALWN2iZutkKJyuEc+of65cxqNY18fwIk1qAUKOw5nOvGC5zNiSyi90vN9ePdcVMm8grMZfEsUR3lKD/DLTYaSz/XW6aw9bTsC7bO2WyF2+JqyescLxUi5F/j2ZAl1VS/YQQP9fmQ6xk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smgqmsbr1wyMaiV9WLYR0rlgtUhuOSQRwzvwfNekaX0=;
 b=R0jz5dc7gQuwI++oQxBgQZx7IkTMvavLAWUaI/sTpid1+gOBcpziqkzSab8hvkoaoGhtYarcm0H7zp4AKRKEzVb5izQwDQL8XxAZoD7jx6KaNMupLgvd+d44iYn9rFmexlTwmSY/iWU6LFvwoanOAx22dkmJX9w7I1De0cR3weK7OzDk49+zdrFFc66SzWBUuQIEQiL5r69EL2kJqWs394MxMaKSn/wbRS0mSInv555PRGWowxCd1CfXc8psmT/y2D6eSaO7TK3f8cd8zJT6U9QAjThhbgaUszWSECI1+jv5Xy3V8WG1Sby5RTRh8JEbs4TPKT7NomMY0jEcr2Tb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Mon, 8 Jan
 2024 04:55:04 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::159c:7c99:e99e:a3b0]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::159c:7c99:e99e:a3b0%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 04:55:04 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ice: add support for 3k
 signing DDP sections for E825C
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ice: add support for
 3k signing DDP sections for E825C
Thread-Index: AQHaKHueUKcHXUH18kmxxzWIuSJgdbDPjHQQ
Date: Mon, 8 Jan 2024 04:55:03 +0000
Message-ID: <CYYPR11MB8429A32F885AAB5DC2574548BD6B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-4-grzegorz.nitka@intel.com>
In-Reply-To: <20231206192919.3826128-4-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH8PR11MB6925:EE_
x-ms-office365-filtering-correlation-id: 10a5f79b-929d-4c92-9b2d-08dc1005fa51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qddDAWLZ+KwMu+lEiz7+Bpvj15+f20BKf4DvTT91Ru7OeJ/W601dFm0Ijvv0ZfCwF2qWezXflAwYhrDLOn5FWWy+fd/lI2IJpOBV5QxaJirjuW9WiNH8cl0oGjuzR3bzobzx2p5BSK60ht1niLErWpIZ0IO2c7GgkoEskFTMjoX7ryvl3yKsnht/hojedxrBtg4rjkRlGGjzqXSa7Im/Fq2qdCrRSaJh30nTjOOe8Hp4ybpXAvZEnwqCsXIGSx/PJ3VpqJchs8X5ATYtDn0H1mz65UVUtHkSFmppqdfePOBLsdRRjkr/4gneLW//vARi8Q0nIrP1XrgJCd29LpnpIY73hQ2ZAF3d855DkFJWUbDsl0KAwKbfwkigyMmBpkkhlInOKGt9a+Q+JbYKcsqBXMenOJ+wBUYkvmIIDrUHhEd/J7kkiWAyMNJ8wRPt7R7KRVckoLe8ftQAIYv5oIkWnDo8U0hVORARz0gaDBjyJNJHEg25i3AaktafEp0Ls8QZfltnx1TIeJZDrt+FKfQ7Q5nTrCAFU/+tVGQtP62U7dEIJVWWVTary29PO4a/IC8CuyncvUyQQn9xEUqYa7Ej3hBvn+MSJnWL32m9vZvlfa4kspKeFEwrzVjTyF/WK0XT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(122000001)(478600001)(82960400001)(83380400001)(7696005)(71200400001)(33656002)(41300700001)(6506007)(53546011)(9686003)(55236004)(4326008)(38070700009)(2906002)(52536014)(5660300002)(66556008)(110136005)(86362001)(64756008)(76116006)(66476007)(66446008)(66946007)(316002)(4744005)(55016003)(26005)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kbLxJ3Ai90ON/rbEK0hk9Yu6b88Ae12YsOtFyKwdu31R8j8NCi6tTtMJEDjq?=
 =?us-ascii?Q?L+VZIXFR9TgS8diubDqvndBSTOpDn6hJjKdfF33/iIY3tcs1ZkIYuXrvVlnZ?=
 =?us-ascii?Q?x40aktKx/yC/mHbA2tlJtVlp6bMOe3EueNARrrNJFaIbYyOR/Jzew4OTMMOp?=
 =?us-ascii?Q?4PlEjUDf+0lQ5aoaQE6D8DxkEBf/1DrW822YgBGnqzTyD50VWFql75z/5Mbn?=
 =?us-ascii?Q?iY6flGuwjBSRd4FG7Op/pSSxFU7IbcRgwpzmoEUNq9iWs6cLl/RPWtbZiSFR?=
 =?us-ascii?Q?HjSA6gSjR/vbC6LM2sf8qZTNnf4pGhQ7kJbwF1rWL5V4H5CEQr2HQIGcqOFD?=
 =?us-ascii?Q?F53rLRTeLwAPVHosLHom7uK7PP8/omuzfmkZQBGK/m1NKqlXxCpvVSkOVGXx?=
 =?us-ascii?Q?fDY843vp1iCWySySlWn2dqPSnBXSN6Og6uPtqtb4kB3jzpJdvI9bYiZUEHIS?=
 =?us-ascii?Q?pCG1MsHHGuyx/wuT/a5dGnB+fxmCRUVZbawzLf3hRuKXMnYvnq3W2/9jFOc4?=
 =?us-ascii?Q?Kg9btTqhJQhk+Cb2T3EAM1hiHMdzRK/I19t78SA8iD1VHKz/q/UNNArLC0t2?=
 =?us-ascii?Q?Zit6Pf+l4boZ1TC49NCok0LWdkP9yMUZLwlz9HhjCce00KgUev5YsYvh3Gwa?=
 =?us-ascii?Q?gtPjvpnc0Yyge4dnQ5sMDH0m3S3mSRIC3OwdepjFADoA5VLw9S0XZ1wLqlby?=
 =?us-ascii?Q?QWyv2uKsNSrzTvmuftJ9H4SAqMl+no0E1WQcG4MmbCWk1jhIE8l/bOGic2O6?=
 =?us-ascii?Q?/5y7+sWgHxYLesukO6M8GH1hy+4uPnXND6mJ8KuWC7k/2E0V7mI8izqhnzD1?=
 =?us-ascii?Q?NFPyl+F9w6JKOBFWJPz4Ff1R3QO5+SE7Nmffu6ZmP9qxZ6JCmev8wl3+BpqR?=
 =?us-ascii?Q?V1/IIgJkSshNQk2maHeck+jvMIXKlBMwuYOfIfV16HA4R6RqhRMypn9RWmLx?=
 =?us-ascii?Q?90epwiO5HEILyZhEqKcbbf5HnClj/xd6fCuRCjYBcUOzep0LnLnQUoKG3GEG?=
 =?us-ascii?Q?5E4ai5zuEaPmhEkjfa5Vhue5H+hIg7zk8s61fPOCsHAYtQ5kT9oMKbz77LCB?=
 =?us-ascii?Q?wq1lzB+t5T3bO7X8srDPGm0Eh/EdBCdaM7vebZ+N0Zwrs1iFC8rsJxtDFnLY?=
 =?us-ascii?Q?C8+iJwsKJhoDExH0YQcY/Z63To7ioF7DFJ9aSNtKe7YCTr5HswbAw5ZwNDs/?=
 =?us-ascii?Q?RvMigPkR1bTB/qDtgmbuWqyvv1s9bFh0Uz6kZF8C4QMY1vgibilxrCkHHgSZ?=
 =?us-ascii?Q?B5JSTHwGuZqZ/aTTngeXyoHkzLawO/yNgUhpZM8ixcLOGmTdhb8+ZMyiJLxT?=
 =?us-ascii?Q?Bw8EVwC1WOpwmA/YFT/HFg5EEu/gZFWc4niSdAFL00rkUsvrsxkmYHlvFUWl?=
 =?us-ascii?Q?jEzApADd8TKJvP0GDkkrOXdvBaQCABvv/aiVz+fGatHlkX5P43tDb+HGJOea?=
 =?us-ascii?Q?uQtxln2Wqc7bIvg4+J+gOYavYRQj37PB1cyvMwXOf7GxiKebrXrNmsUbpwx6?=
 =?us-ascii?Q?3lqPV/8vRk48C+UI0K2BdJYRVSmQ5J1UPeqGqD0aGdviS1OW4K849J1rGM22?=
 =?us-ascii?Q?0CVeycqD4ctD/xjns2/fjeslr4jSj5vpXpeBLijgxTSP0RJxsU8+WdVCTHI8?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a5f79b-929d-4c92-9b2d-08dc1005fa51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 04:55:03.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjVDP2DPZD5pwAB2pBFsTv8fsGgnXLySRHRU0bNJwj6uYWL9r2lSWqy6Oi16EeN6mByUC2TvdwGhL0kzMfg2UjSv+W/IZ4Hbuk9aQW7ZSfT4l0RGwpuqx8yEOv4WL9VS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: Thursday, December 7, 2023 12:59 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/3] ice: add support for 3=
k signing DDP sections for E825C
>
> E825C devices shall support the new signing type of RSA 3K for new DDP
> section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
> The driver is responsible to verify the presence of correct signing type.
> Add 3k signinig support for E825C devices based on mac_type:
> ICE_MAC_GENERIC_3K_E825;
>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 6 ++++++
>  drivers/net/ethernet/intel/ice/ice_ddp.c    | 4 ++++
>  2 files changed, 10 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


