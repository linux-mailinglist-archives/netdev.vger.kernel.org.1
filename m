Return-Path: <netdev+bounces-31176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22478C25A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFD01C209ED
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134318BEE;
	Tue, 29 Aug 2023 10:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499E110C
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:36:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D8D18F
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305361; x=1724841361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8TbboBdDQblawUOY8r2DsFiQwOapTSO3ZoLLrBkhRvc=;
  b=O3vso4O3XhmjvHnlMEsVdrufRfAc8gnhLjMiiJi/WmQZTMnWEhPS8Hbp
   rYKAavhTOmNEVdLaT/teGDcNblBcYWkuzHIw9OwwdMeF+tF5H/hiBBinY
   pkd3gJ6OE7SSbf/vfGDZsXL5iGmby7RpV44/9yY9mPPoNSPfbtIHRPhfU
   L9+DAlf0bHubrMKT/4LzOCdB+fjqlmi8HTuzMKCW3qC/YTtnbeEvxY8Ku
   eCI/MNiD3JKIfokKukOaVwAk6qEtQ0Pfu4WCipLno1iwvVDz+fwZunB5a
   zJTrxKtao12oqKssx541/x3lsag+pAk+dQexKuYAGIo1myTTJeOfJ3/tD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372746882"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372746882"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="715483610"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="715483610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2023 03:36:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 03:36:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 03:35:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 03:35:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 03:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo86BgCMNZ45o+FQel3vjrHEU378cy+BfR6X37Dza4oCfh64hN7PoNh9Kea1WeGtxi1H4blB7Ko4ue64j9eorL+U+i/UED+oShlH0X5GfoffOSDhgvq+41+dmZx+kZ8WObRCFnUAU73AAL9iWVw0WpVaYAbrO2/g1fgvPJPpewZrfyU6m58skR6HiE2MzpWalHVfOIA05Y4hxGF9c62HnaZfXrV1bmj3E6TO1VvxGMToWknQwlqbM6Fe15gGMcVslxDCKG6XQ2r6azU1KWWdxu4KwmtgwCEdLbcnBeHjFT9d3w0goJUMA6bOuh2Y83AfcVuLGytNJGZztFgcaYxtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TbboBdDQblawUOY8r2DsFiQwOapTSO3ZoLLrBkhRvc=;
 b=DRh12oEUJjvDbK1BlfLfc1sWvhwls732URJ3YX2CQLhQJHBGFznBkt0ybKIw4/8TEGOQKUy4oIPWsFCBZk2a/APqTrQzTx8CPXD2zj72kuF97KDAijjrKtUHeCnliWRmI2hZO4tVXtwxQTzbVbn0jJf6oEraQ/E3MRkR9mjLyQD5McJXTomT/I5iodEwf4pVVARaYdemFmZDax6ZCXqCTSDEj8JqDIrZs5R5/iVBE5Rl9hU539XJ5fKXPT6SiuXQe1x7BUjYfnHRF1WQP95EJge1lXozS3hXOLAmMOIkiv8QPcOFD/RcY0fZXDNjUR6sbq+5ZDxed3UDwnOm5B2u2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5800.namprd11.prod.outlook.com (2603:10b6:303:186::21)
 by IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 10:35:52 +0000
Received: from MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::874e:6435:4a8a:3229]) by MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::874e:6435:4a8a:3229%2]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 10:35:52 +0000
From: "Kolacinski, Karol" <karol.kolacinski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: [PATCH v3 iwl-next 9/9] ice: stop destroying and reinitalizing Tx
 tracker during reset
Thread-Topic: [PATCH v3 iwl-next 9/9] ice: stop destroying and reinitalizing
 Tx tracker during reset
Thread-Index: AQHZ1PX4DPNmd+CsKkKxOeym1Dk1z6/4Xe2AgAi/hcc=
Date: Tue, 29 Aug 2023 10:35:52 +0000
Message-ID: <MW4PR11MB5800133DAE0F85E3AD0A1D2986E7A@MW4PR11MB5800.namprd11.prod.outlook.com>
References: <20230822124044.301654-1-karol.kolacinski@intel.com>
 <20230822124044.301654-10-karol.kolacinski@intel.com>
 <2dab6c02-3db5-c2ae-ea56-c75c2e7a8834@intel.com>
In-Reply-To: <2dab6c02-3db5-c2ae-ea56-c75c2e7a8834@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5800:EE_|IA1PR11MB7773:EE_
x-ms-office365-filtering-correlation-id: 66b3d7bb-0f11-42b9-e86b-08dba87bb80c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztRjUVRQCaHburzU1Vn2TVT+fZTkbyRoVrAkjwTnKUelLTFFD+V31Ba6LzIDhEvm6QCTwi3F07RHm2yCLrCZM9CMsugJdx3pA/zJePgHePqW7h9GbKzwscj9zsP7xKhGwuqbdXHYceFbn3KYg364Qfyd9CHNw6k/uOKkxDPWIFpyJCwc4PF9iNg/tJQ96ytKw9cuOyRzwdDfcejNG1mc8Ckj1ZdKYkW18UxWo3k3m+I5z1E9Y1luaAmsR6eAewvQdWted2c04CeZNvZA/g8cBYmN2DKyMiDIpf5wuFQPeOWuqAP8Gxpy7Kdt3RuGwDJGF1tfFkBQZVtIfw1291kY0298DiAhVYVj5to7YCMKAm8LCp1OtBTj6h82rD2Am0okdLg2yYRZ9SSWrzkjbVivmMk3xR819kESZqAjK0ogueAp0WDsicusGE+wBUL7kHM0yKC3LKfI4nzAesHAuMrlOf1PJIpHGpjDyJQc2riPZ6sGAelpwLRzPw4XTuDYe+uzQnk5MWi8+tyRVsEJ0D5yyPv8V+yzVHH2yHlyWKjhwFCmFjLgjyTEtg1lNwt+jeZh9OhQhd9ueTxF9ixl0VnRUVCSzcZR2YgyqBsUbKOHnREZoQrnFAtu5m10reMeqHj+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5800.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(9686003)(38100700002)(38070700005)(316002)(41300700001)(82960400001)(4326008)(33656002)(2906002)(86362001)(4744005)(107886003)(52536014)(26005)(5660300002)(8676002)(55016003)(8936002)(71200400001)(7696005)(6506007)(64756008)(66556008)(66476007)(66446008)(54906003)(53546011)(91956017)(110136005)(76116006)(122000001)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?CMWpXIDwjAf1f+Su/HXtQM8DbbTKk7BdVl0ZisE+DarDwhXliiIRvEzYP8?=
 =?iso-8859-2?Q?MLh8lTTJvd0c6pZAnAgGcGF1vynldndZaxZZ2mgslrBNVyt3m4fEDuG2c1?=
 =?iso-8859-2?Q?vF5uMyK19Y+hKvJp+L9g5IPzKezoPNao/kLLkMLe5tGDuzlkIwEi+Oea3U?=
 =?iso-8859-2?Q?9cITxQ47PYVdjmAvSTL2SW2yvyemydJGFhDGpsaMfyGzI7GIH4Xik+6n0R?=
 =?iso-8859-2?Q?YziD7etv6uyw+f2MkcWF88jN/xQ741VNaDjbhsMshy8P/089saebEbKUjb?=
 =?iso-8859-2?Q?L5uxwiXudhnQw01HXx3vdcOoD7ITtASSJy+m/I/uSwdvV7yrrT7nfx9pfq?=
 =?iso-8859-2?Q?Finf32oB9r1GU4wmGNZR1+fpnEdtrKC3B8PHHueNDxokktVfbbNyuGJPa8?=
 =?iso-8859-2?Q?2WcafyXH7OS9kjAHYRCPtl+57Qs+bFPOE6Rz6T7TEjtZ/icA1aEXV4NADN?=
 =?iso-8859-2?Q?P94A7fr1iPxIUegCq2o7wR9zQSSvSY+oGDvhrIPQUFRuodfYtxVym6hZlq?=
 =?iso-8859-2?Q?O0Y6miJrWQPdFJgqyfOjGcy3w451xhguEvbozNfosCLTJ7IydtYuW/ob/S?=
 =?iso-8859-2?Q?slrcKY2A/gXyq5Jd0GNkNja/X4Qyj718Lc+GsVQFlpOgq5E73V0oWfhxsI?=
 =?iso-8859-2?Q?U3LYaP/Qa+iiWxrL0QpBAMhAWmyFRxgnUhi39Kz/DdjVeCIpUTg6PlJtFU?=
 =?iso-8859-2?Q?kItFij9H0wuK21EsO+jLiyRwnvwiH4/N4r0pbWRpJVNMvp0tR3/IDCeQXk?=
 =?iso-8859-2?Q?yvWqkdNRumcyaYn8aSPn1fLC6Stij6Xqrx41mF3r4z55+CXw4MkIZ/mR0U?=
 =?iso-8859-2?Q?OzZv1T6LkEnw/JVBhf1DlcivWlHZpbT++NybZkCM6zyUBqFY+0o1SfhgnS?=
 =?iso-8859-2?Q?9coGRHKqBWiAQhYz6jwRimE/nCmNbQJmqt8r/vFu/HisB5ofItrErGBFAn?=
 =?iso-8859-2?Q?CEYWXmV1STm3bClyy28QU0jPwJo6xlvhUJrsgwriY/P+zIvq5pKz18AA2s?=
 =?iso-8859-2?Q?UNUOCOUy2dgOeBHKVfEoa4Xq/oz4mhm5uOrY3K+X/h6QUgKPh29hXztTiB?=
 =?iso-8859-2?Q?qmtWnbV036NCe88Dk7/CYU71ncOgAQg32Ra1QtQiN4zCZxErsxHhj5BMDw?=
 =?iso-8859-2?Q?8usJXzRW8anQ/dlxUKucNywB7qwr7Zvx6W/zGlW1GARzYxVCzAuhGTJaVt?=
 =?iso-8859-2?Q?DWJMjDlWRswQMME5kWlOzHhMvRBEzlrsFZ9bBO+jUQrXnPbwgnIH5OBaHT?=
 =?iso-8859-2?Q?H41lAg86b7eoc7YDOAHWCUQ+ZF1FJ2brcM/KFizYCP3VC3bwt4l7KJzENB?=
 =?iso-8859-2?Q?TwSM+apXh38RA88F2fnXpJOt3qV3hvTQXur1Fe4Nr+JFBuMse9NvA/MAyj?=
 =?iso-8859-2?Q?Z4VGrCAdSOTWCO07D8zbH4CK/LuG92XFo0lzx1LYn9lXizjaaEOI6mZAxy?=
 =?iso-8859-2?Q?w0QMgG8IZcbm0z78YBpLo+NcHLN/OcSSJGkL632FB5mAufy6hbqIbv8kU1?=
 =?iso-8859-2?Q?EvpKo+oALKgMXy+PBYIxtIJTx4LHWTRtTyYa/ukG6g3RH7CRW1nw2ZLlJj?=
 =?iso-8859-2?Q?kZWszhZz0oXbcTdh5ahkndju2TLxoFFjGGgz+RzyS9qEB5us3K59oh1aQ/?=
 =?iso-8859-2?Q?NupvyCTy/tdmm7wk0Ev/FKI0Oipd9awNclH9OMuH1BRcm1sEmK0gvtyA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5800.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b3d7bb-0f11-42b9-e86b-08dba87bb80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 10:35:52.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pXvOpWanOiGoVQZExG8J+i1HJs/fYKzjF8lLpCcS+i8MhSraKJSIbt/X0c/4jQNSYkg8yn+LNwmVgAdGUClysgjMAhT8P8L351lGPsZTks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 10:53 PM, Anthony L Nguyen wrote:=0A=
> How come this isn't for iwl-net? Some of the other patches in the series =
=0A=
> also sound like bug fixes. Is there a reason everything is going to -next=
?=0A=
=0A=
This patch series depends on new features introduced in other patch=0A=
series on iwl-next. Bug fixes are not possible without auxiliary bus=0A=
feature for PTP.=0A=
Some of the bug fixes could probably be sent separately to iwl-net,=0A=
but PTP reset won't work properly without all patches anyway. =0A=
=0A=
Kind regards,=0A=
Karol=0A=

