Return-Path: <netdev+bounces-17876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3575360E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F11C215C0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AFDD507;
	Fri, 14 Jul 2023 09:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB36AB3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:07:19 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEEA30D7
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689325612; x=1720861612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gIVcqdmmQ+w0B4pkF5279eR9UwzmXaxzjEWpuSKvzhc=;
  b=GVF4yhXEpr6qs6kPgkT7qzAkjMcQnWoJve/qH09GLGU5l23s/7diYS5N
   18imTHfDdUV4wDch41Ji898/D5nOAzoJuLkAsjlkuCgzBDakB6J6C3xaZ
   n9sZLw//08hpt6hMh97+Edqt8+YLzttbL6Mdn2MMZ8dFJZkuTY4MRN3ap
   a0/kMW950zoHRHKQfUK20IZbVF7UUH8xjnIkCmouNgxiDlGg40XLxtBty
   qHnBZ4WtBVvg+5xqSRHYrNfxHs+eAwunhmDQfy3dgKI7romecZJxj8oYe
   db40t2/pZM7cCFKy24ZPUoOl+y8f8pUulb3fY7PGO67ImRSSkIT1rsWG/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429193044"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429193044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896347852"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896347852"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 14 Jul 2023 02:06:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 02:06:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 02:06:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 02:06:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2jZORJgogpHLvx9VBUOazhbsIk1lHjTt511ggFk51g7Izv6EehdMNr4igjfIoxgyjABJ1x/aexDQOC6S85SAl6wLA79lPgGcvo8agLMjA+lkPmUK2Et6NBU7h5Dm966TYsqT+ATG5mW+4dzP/K+RCud4blaGAox80I7dhfFqwpwAFK+kJXumqTHZaDGMOTRUIaFHvay6+cJV2zFAcEbnoWB+9szhtzbVw882Il4cnWPS5+FJVX4U/n74h/hJn4rwJE6YqtI71+3wVuEJbohQOPOd5NOfaOBULv9mcdbFstW58lLwiON2e9uGaCHcvUpzVrIlouNYEKurXTX74+uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahgdw+638xs737f1x4+UGFxgId0BPQruu2mEGl9twQs=;
 b=S7hosjiYlC/68tEFIjxRK+ubLdFGME5De1KlJ3CeQQjL84r8lKTlgImWpErRAtQjf7bCFCmG8f2hmpaDMChL3m4TuPLau7B5BK4QgRn2sbkozFmP/gh+XVPtAs3WAzTDmd2WbIWSdeweFwK/dqYRuCAF1dDGm4Gdo1g1XG4v/zLgDW/PQROzHbJ4j9z8rzVOJqig31Pwh9Ulk9wHRxfuvWcQnKTRHW/KnGSxsVaGAhDy4EBoT9E1GG8whtnbcG/jOse0Q25MmmHjRrJiH72vKgume7JLk7oQvpd7xBBV8fpm1s9pyKbxcl8LFcOjoutBbtj22+X44kvMrrG1DwQIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3133.namprd11.prod.outlook.com (2603:10b6:805:d2::14)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 14 Jul
 2023 09:06:49 +0000
Received: from SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::19e3:8c1f:7eff:d656]) by SN6PR11MB3133.namprd11.prod.outlook.com
 ([fe80::19e3:8c1f:7eff:d656%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:06:48 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: prevent NULL pointer
 deref during reload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: prevent NULL pointer
 deref during reload
Thread-Index: AQHZr9XXabjo72gRVEym98QQwFj8QK+5A/pw
Date: Fri, 14 Jul 2023 09:06:48 +0000
Message-ID: <SN6PR11MB313316ADB3FC895E88495936BD34A@SN6PR11MB3133.namprd11.prod.outlook.com>
References: <20230706062551.2261312-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20230706062551.2261312-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3133:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: b685173f-2340-46f2-66f6-08db8449a7f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNu/pMOsj9ln32yQDPzrS6Rs7u1pQuKfZHu/Jb98719LZ9wCuwB4mgq+wwl2iA6kHtUZk1mIU8lq+pmBWsJv90mvDdybe2JuYIHLE5cJYPiV2xDYtecPku+mXBSUzaFxh5WCN61442zmk5rV1ODPBiK3qJ1hFkugNHFa2jHHolQjByBTbueLGq39827Ou8+B9ov5WdBHDBQlVtlLOeHr5ujyDcoOern99zdOkCC230vBZD7B4ee94OchHHMd45qRd9jc3b50ipuoc43mog9541QkPXoxExPw4yAWapCMplcRhsU9Aye++Dly3YFK43RUrYNsZjN1e8Aia5UtDGJXuFOZuT6ecdLx2jMhfA6d0Su42lOignHIstn8HPBT4Q23BvZWnRLbFmJV0SrKcPk/I7sl2rZ3YNBIrF2SZLRw3+6h5yKYUnfVjh7yyRzoBcwthHYRm2hK5V9QGIVQ/ggSEUl8EL95drqkfOGCvpTpo0XvPnA0Kf1Eg4/xE0Z8vEwPkQ7lMFf5gVA9WHLImLtXsSC2USzCFJJQ67eHN/n31zlrSG51lTgkOez36NbxH9UgdBGhy12isAtgP7b7IbntvamhibJiOj6607W4cMxhZZLSwIIzlv25nCu7sqhizIZDtrkooC1F3K9c/3Ok1FM2Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3133.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(82960400001)(41300700001)(316002)(9686003)(966005)(5660300002)(52536014)(26005)(38100700002)(8676002)(53546011)(8936002)(6506007)(83380400001)(86362001)(38070700005)(186003)(33656002)(2906002)(122000001)(55016003)(54906003)(110136005)(71200400001)(478600001)(66556008)(66446008)(64756008)(76116006)(66476007)(66946007)(7696005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I5gbyQ431S2G2kaljj6prmd44LuHHoWt21x9h+uLU8sK2L7kQiUyD+mNhNw/?=
 =?us-ascii?Q?+pD3M81ZZW5L2S0eJDnVTNaZLQPgHdrjBnwKSlyjlYH9f+aPxyDwrnpqnY+j?=
 =?us-ascii?Q?XRImMRQviogot1CJvq2wSeV4s5DKCDzfgVsPe25B/vjFze44IPPQz8jtuSkx?=
 =?us-ascii?Q?LmSlxWbb/L+gIHDtOAAKNYxOLeT0R7O+7IYh52r9Q5b14YKV6IQdFhsyt4u4?=
 =?us-ascii?Q?BeMxGkQU4IDmMBzZlEGqAs3+uxcnNsq8lJ5KG8bNTqg3Y7fN/ZJd939K/k0P?=
 =?us-ascii?Q?59o7vFkTYYOvq/3GVzwL0UkYZ9u4VwekGIJiLitVcwLCz6NwQRSWXRvS8IER?=
 =?us-ascii?Q?/N8HWoEsmBY+B4esXiFv4LmXvfcjaCtIHnoEF7uU2K7WMKyHztEeyPPWp5ag?=
 =?us-ascii?Q?KmtMBNkYcoSdFTAst0ZRlqB77TZdcHGHV3fcOX5/m3sRtbnbRgafhX342cD8?=
 =?us-ascii?Q?GGyK1lYM0SNqUWL8HqQSwPsqQ3b8b376DpJ27ph49Rx0Xfs8bw9N0e3zMfYM?=
 =?us-ascii?Q?Pk574yojA78cZ9YAcxtf97Mg1GBKIfY3Y6bQTbHz/mwO23cjaBGI3TOhePGQ?=
 =?us-ascii?Q?8hVYvOttB9Njkjgy3prKcqkIHt1NNCUhABbaA6S3abKnZMLGoNHcvVKYk75Z?=
 =?us-ascii?Q?Nbbp7+HiDaRmYYCzT3FP9KaeJIZ4S1g+Znzyg6DT6SVNoNoVA/o1yPPiQJxb?=
 =?us-ascii?Q?BIAHdsJO3vw26QbYJQDSe8B+WJuirLS8qu5dxtRdhdqtrJYvqqBMT9B6pchQ?=
 =?us-ascii?Q?IfhuntEPIPGdgQGjhvaVdvoO00Ra/ig2rUUuwoM/WLfkW4pui9mlxQW2ueFP?=
 =?us-ascii?Q?rQxVRTtxhPUi51H9uX/wbx9a9kSGarDH8sSroyltAKY2zPrp15YDRu0R249m?=
 =?us-ascii?Q?js88NbHmC39zFlk8BaGo6d5lFzN+JK5mFtojYisZcZxnPNqGjLzMEfu07zh8?=
 =?us-ascii?Q?U0CUvGrME2C2Fb0tudz2ymoXI5GtR5A0DYZsj2d9RBgeILxkNwBmisxrlLIK?=
 =?us-ascii?Q?ugDFz+/n5WT7e+yar2y5jk8ouuI3bjWXvOLFhzL/0T42aRSlzVAghRW3aarK?=
 =?us-ascii?Q?omhRDSQ7498fNO4DZmNYQXHNKyHf93+IGIbJJ5kAjrCAvOdUFEpqzdsnioi5?=
 =?us-ascii?Q?PAov1B7Dpn4x06ucrHukIdps58/VgTFdBZrpY56dSgZC6YTjYSyC/KqWjHX/?=
 =?us-ascii?Q?OlWquHE/A1ZH01sfD5Wq0/lbjb60ASNfqMdUeF13c5uvzORdRQdUIxcOYByi?=
 =?us-ascii?Q?tfYVXCw+6CjMZaRpNZg0DLTflKDqQ5fdo3GJIee58GrkyqjHRao8fqTqAxHM?=
 =?us-ascii?Q?GwWvNpy4+4ttO8qHtwiJDs26A9nUdFubXTeVYuxdoovSUYBjKS70LLtvLcJ9?=
 =?us-ascii?Q?NXUCtRJZUY6rfx19Kbi0LftT8ux6rpT9Wk1GF0j3zBm3a/U5GSWif9rtBkpw?=
 =?us-ascii?Q?+FyXr2i1SPe2l4U8bUzw0nMW2zJtGcxGTmzlOjz/nlmq5ETHIsf06Yaty78w?=
 =?us-ascii?Q?/ho1468Z4xqtMyf5xSKmQi7g07aaBg2rgA/mBko9FxfY1AlCIxZCxILDeOW/?=
 =?us-ascii?Q?sL7+NKWAFvTeOgNocrFLjBeW33zo8detoNRi+1cCMz5MRd1CUlEl9DWHrjjc?=
 =?us-ascii?Q?bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3133.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b685173f-2340-46f2-66f6-08db8449a7f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 09:06:48.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22IzZyoePFBQiQrwI2XqkthsHK9tDbWToPNz1gTWygNzjtmcxG+HCYaSHubhz6ZcmpmEgfkSHQD9ihsjPnNtLgw2ka3pkxY1IZhRWju6JumrFJxOgyCV5K+35uICH42f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: Thursday, July 6, 2023 11:56 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Kitszel, Przemyslaw <p=
rzemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: prevent NULL pointer d=
eref during reload
>
> Calling ethtool during reload can lead to call trace, because VSI isn't c=
onfigured for some time, but netdev is alive.
>
> To fix it add rtnl lock for VSI deconfig and config. Set ::num_q_vectors =
to 0 after freeing and add a check for ::tx/rx_rings in ring related ethtoo=
l ops.
>
> Add proper unroll of filters in ice_start_eth().
>
> Reproduction:
> $watch -n 0.1 -d 'ethtool -g enp24s0f0np0'
> $devlink dev reload pci/0000:18:00.0 action driver_reinit
>
> Call trace before fix:
> [66303.926205] BUG: kernel NULL pointer dereference, address: 00000000000=
00000 [66303.926259] #PF: supervisor read access in kernel mode [66303.9262=
86] #PF: error_code(0x0000) - not-present page > [66303.926311] PGD 0 P4D 0=
 [66303.926332] Oops: 0000 [#1] PREEMPT SMP PTI
> [66303.926358] CPU: 4 PID: 933821 Comm: ethtool Kdump: loaded Tainted: G =
          OE      6.4.0-rc5+ #1
> [66303.926400] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS S=
E5C620.86B.00.01.0014.070920180847 07/09/2018 [66303.926446] RIP: 0010:ice_=
get_ringparam+0x22/0x50 [ice] [66303.926649] Code: 90 90 90 90 90 90 90 90 =
f3 0f 1e fa 0f 1f 44 00 00 48 8b 87 c0 09 00 00 c7 46 04 e0 1f 00 00 c7 46 =
10 e0 1f 00 00 48 8b 50 20 <48> 8b 12 0f b7 52 3a 89 56 14 48 8b 40 28 48 8=
b 00 0f b7 40 58 48 [66303.926722] RSP: 0018:ffffad40472f39c8 EFLAGS: 00010=
246 [66303.926749] RAX: ffff98a8ada05828 RBX: ffff98a8c46dd060 RCX: ffffad4=
0472f3b48 [66303.926781] RDX: 0000000000000000 RSI: ffff98a8c46dd068 RDI: f=
fff98a8b23c4000 [66303.926811] RBP: ffffad40472f3b48 R08: 00000000000337b0 =
R09: 0000000000000000 [66303.926843] R10: 0000000000000001 R11: 00000000000=
00100 R12: ffff98a8b23c4000 [66303.926874] R13: ffff98a8c46dd060 R14: 00000=
0000000000f R15: ffffad40472f3a50 [66303.926906] FS:  00007f6397966740(0000=
) GS:ffff98b390900000(0000) knlGS:0000000000000000 [66303.926941] CS:  0010=
 DS: 0000 ES: 0000 CR0: 0000000080050033 [66303.926967] CR2: 00000000000000=
00 CR3: 000000011ac20002 CR4: 00000000007706e0 [66303.926999] DR0: 00000000=
00000000 DR1: 0000000000000000 DR2: 0000000000000000 [66303.927029] DR3: 00=
00000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [66303.927060] P=
KRU: 55555554 [66303.927075] Call Trace:
> [66303.927094]  <TASK>
> [66303.927111]  ? __die+0x23/0x70
> [66303.927140]  ? page_fault_oops+0x171/0x4e0 [66303.927176]  ? exc_page_=
fault+0x7f/0x180 [66303.927209]  ? asm_exc_page_fault+0x26/0x30 [66303.9272=
44]  ? ice_get_ringparam+0x22/0x50 [ice] [66303.927433]  rings_prepare_data=
+0x62/0x80 [66303.927469]  ethnl_default_doit+0xe2/0x350 [66303.927501]  ge=
nl_family_rcv_msg_doit.isra.0+0xe3/0x14
> [66303.927538]  genl_rcv_msg+0x1b1/0x2c0 [66303.927561]  ? __pfx_ethnl_de=
fault_doit+0x10/0x10
> [66303.927590]  ? __pfx_genl_rcv_msg+0x10/0x10 [66303.927615]  netlink_rc=
v_skb+0x58/0x110 [66303.927644]  genl_rcv+0x28/0x40 [66303.927665]  netlink=
_unicast+0x19e/0x290 [66303.927691]  netlink_sendmsg+0x254/0x4d0 [66303.927=
717]  sock_sendmsg+0x93/0xa0 [66303.927743]  __sys_sendto+0x126/0x170 [6630=
3.927780]  __x64_sys_sendto+0x24/0x30 [66303.928593]  do_syscall_64+0x5d/0x=
90 [66303.929370]  ? __count_memcg_events+0x60/0xa0 [66303.930146]  ? count=
_memcg_events.constprop.0+0x1a/0x30
> [66303.930920]  ? handle_mm_fault+0x9e/0x350 [66303.931688]  ? do_user_ad=
dr_fault+0x258/0x740 [66303.932452]  ? exc_page_fault+0x7f/0x180 [66303.933=
193]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v2 --> v1 [1] pointed by Paul:
>  * change the title to more specific
> v1 --> v2 [2] pointed by Olek:
>  * Remove not useful part of call trace from commit message
>  * Reword comment about no rings
>  * Unroll adding filters in ice_start_eth()
>  * Proper lock in ice_load() also in unroll path
>
> [1] https://lore.kernel.org/netdev/20230705040510.906029-1-michal.swiatko=
wski@linux.intel.com/
> [2] https://lore.kernel.org/netdev/20230703103215.54570-1-michal.swiatkow=
ski@linux.intel.com/T/#t
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +++++++++++--
> drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++++++--
> 3 files changed, 21 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


