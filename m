Return-Path: <netdev+bounces-40316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0D7C6AA5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CD21C209FC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9E224D3;
	Thu, 12 Oct 2023 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9oBlM4C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26F210EA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:12:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75DB8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105553; x=1728641553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8egiPMIReyCmJj7LJEeTZR+evTxiZX5+4ZVrT7WVkJk=;
  b=F9oBlM4C++BO2ZcFrf+53YI6ShUPv5Oi1UFiQJ83XtBpYgGq2Y2E0Lr0
   UISEG373i4zBr0TTV8VttczxYzg4dlm62kdSFIeP6gOd11TGw4y9dz19l
   YuXJXuDGR4DGRlLFuM+blNFJPlAy7niaVOHDWTYcPjT66BHmXX1VmySzA
   nb0iiiT/XpYnmJGDl50ZP49X72Y+evgvgupgOExKfbKfQKOcT1gHeAugB
   pGYsOaoC4S8b46X6mJMVqFOpTvmBao2CXjEG/itaU296ajQNsT0K2+8AK
   XpTya16WzPybbaLcCjA8VFLoJNjbMNx+zaPLfFnN4GLNd2cfXdK5PQpaO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365158469"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="365158469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898036454"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898036454"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 03:10:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 03:12:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 03:12:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 03:12:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 03:12:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax9GGLcXUMpJGMx13BybyF0phm2mRO45hepivy4qVt8S5r4ZwPM+cHqkbXfR7XvubNvHiWRto7Wl9wEPmN6EteS3obP/Sju+ia6ys5IwdWhl5zB0XZNEthLwqWiv0XMmlhV/pQkU6/B/jOQrZ/Od6sii1kK8uoPxADdJKd0SAV1V2IWGqjNj3PlNdRbezoTTDcKE6OUEhpMwK/p1KIqNXOOVumRp6Lag3VLUsu87+YducUQ2ksklXaTkC/ZPVAjZfp+LaotqCKaYxhoOMzetzIiI0L+bW0RL+uXjfKZaZbWE8mGi33E1Mvx3qCcKRcpqbDsPOXQMfWzN+xRTz5VliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8egiPMIReyCmJj7LJEeTZR+evTxiZX5+4ZVrT7WVkJk=;
 b=TEDLIHHccXfEkXx+l/Sm500+htPxZoQaukVsqn8lxNnnIOC9LGuHwpHGPDV87BKtZzJM2ZRlmB4nZrI2EGa6ctUrH3sf8wWgqRcEG9ZdUrFRVV49PJOocoynkENnJgClkbaleJ2hvD1D8/+cCURgFppc2wLpEkl9I/O5wR7gspzr/9istf7CdQI8Sf+ZfVSJJeTOZ1oATK2DHqSDcScYuBrSqOZWoZVcivSpWmSV4TfRVitpZqBve5kO+e4KY8ZjnLSjpgEkWeHAdajxeOUHccrqaVHg6zGAtfbuxp5fa2K1HfVKqA0MbEfqSug53u1z/SoVIM/hf/xWSm2I/2pKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 10:12:24 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 10:12:24 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/2] intel: fix string
 truncation warnings
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/2] intel: fix string
 truncation warnings
Thread-Index: AQHZ9imWo+TRTQ/Nyk+59KkVAlaXKLBF+c0g
Date: Thu, 12 Oct 2023 10:12:24 +0000
Message-ID: <BL0PR11MB312284B4838C986D8B96ECA8BDD3A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
 <20231003183603.3887546-2-jesse.brandeburg@intel.com>
In-Reply-To: <20231003183603.3887546-2-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: e4951a0c-4f1c-45cb-3920-08dbcb0bbae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIxHCyaxvBwyML+ipGKDBORPT/Yh8a0zLsp+zGOgxuLevMifhgGRSKZvJQ1dE2jz0teuA9slmjolTDKay+2QIhlB2pRehXMg6C2QYHEjd74oo9uE0oELQvrd9uJuXfvxPF4CzH7sG9Cd4sUxUlWYypK0NQqHxCgjAabBHMen+vcM70gHs481DpXhV5DMmhNbWp/rQiGYDRG3xWOXcae436VkBFfDgR26DYuFsz/JAIIthZsTPFwQ4vMtwUrMH47CvH4EogxbWIDRMRJIZvNs1VkeeyuARxVCC6FlKrPBs8DP50rrGM98JBc6bDSAB6dPyIjDedIacqy7VW/7GPRThJj/xzdU0Pvls8FuLpEYB7T/6buRPCZCkCOdYEO6LBYmKPyh5KnhQY+aYYHvFk06WWNnC84NHEdwqdjWKjFiT6OJZ5xurXtUT/ziSzhvHKVKNwImuM8EVHEjE6To+squbsKN41ZVCE8PvRhwBuAHnwUfcZgcOsdMNpHYcY66N7EeYlLmf1IhRbcR4HOLOFYWKFHfwMGsnBdAIDIvJa/JFX2NfacYBK8HjhJkL/iIZuINfQB8nwI6j8Zxh71KTUV5A1yKP+YsZ5ktN0qaOMZDPd7tICO6SEKY+XUTqJ1dbTnS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(66446008)(107886003)(54906003)(55016003)(478600001)(71200400001)(53546011)(86362001)(7696005)(9686003)(38100700002)(33656002)(41300700001)(66946007)(5660300002)(122000001)(66476007)(66556008)(110136005)(64756008)(6506007)(316002)(38070700005)(82960400001)(8676002)(8936002)(2906002)(4326008)(52536014)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djA1Z1lBSG9WRXFrNzlUMkI0SFp5VVJ5SXdUc3l6VTBvbXhzR1ZFNi8zeVBo?=
 =?utf-8?B?Z25sUWxXdmgrRFJPQXJiTXorQ2psNGlSV0NvZVhMQmphNHFlRm1QWFM3Y3Mz?=
 =?utf-8?B?Tmx4UXh4UWQ4ZjZ0MXV6RG9JVkV0Q2NwRDZ2K1p4S2RKUHBLQ05FSzR6STNE?=
 =?utf-8?B?bW9mVHRuaXZGOTByOTk4NlV2aXVQcVdEWllmQkNpYlRXaGNYKzRwUjd6TU1p?=
 =?utf-8?B?OFk4SHFVN2FFSk1DYmRrdFluTHduTFR2VU9NUDRYeTlTUjZ2NUR3L2ViZ1NL?=
 =?utf-8?B?OHZjYnEwcC85RFlFaXBYcVZwMVpyelZobWRjOHk3bVRGZ05nQUhPcUVUWnND?=
 =?utf-8?B?U0U2K3FiOWVscWM0VHZVUTZZQTByRE95Z3oyeGthQzZiMk9Ud0ZncEFnT01W?=
 =?utf-8?B?ZzRrMmdwcUU2ZGdMQVAvckdIUXBsMm8zenFnMG1jblZGY1lCbGc3eHdwUzk0?=
 =?utf-8?B?NU13ODlxS0VkWExsRTVRb004b3haT3lYaURNS3VJd1ZPUkVFc0g3L0x5WFRE?=
 =?utf-8?B?ZWtlMURnS0Nhb2NrNTNhNWVnR1lTVnlxTFJNRDVpTUNhOGc5Mys0dWxmaVJu?=
 =?utf-8?B?SWV0WG1lRFZ2NjU2OHI0T0VNSk9hWWp2Zk1MVWllMzhCTjR5RlhEMG9KQ1kz?=
 =?utf-8?B?c2tzWklGZ2ZLamt5SUNMVFRJdzBJT21pSnZsTlB3aUFTTjliV2Fodkhlc0N2?=
 =?utf-8?B?cDZ5M0RScnMzcW0xYmg4R2h6L3VyS09FMUQveTYxcUFxTmd2M3NuM05FRkho?=
 =?utf-8?B?a2dFYjBXS0FiZEhDYk84Tk9ZZU11L053d1NtUHhoOWVkTGpNR3duaUNkK3VD?=
 =?utf-8?B?aFM4d0RETkIyQmtoOS81aFMxd1ZXcm9TZllFMHU2eXdRNEFGYTdCaW05NE8r?=
 =?utf-8?B?TkREb1haVmNWZWRJRnVUcGJ6TGpXb25LODNlQWUyakoxQlZiQW5PWENINVZ2?=
 =?utf-8?B?eVNNU084Z2tYWHlxZFAxMzZxc2VOeUVmK1F0VWZ2YTZtZTVUd3FSbldOOHAw?=
 =?utf-8?B?REhVOUdTNnBScW1kbDFSRm5QVWxWOXdvRlU2REJmNWFwNzZ2SmJsYTRuOHFX?=
 =?utf-8?B?dExJbzZFUVZ3RHl4STBuVDZVWk9MY1phVitvQXh0NkZ2czFEQmUrZHVRTS9s?=
 =?utf-8?B?TVYyYWlNNkJYVWcwNFdTNXFSd0t0VzhhYmpTekRNUDVzY002ZmpETU53VEx5?=
 =?utf-8?B?RVgzU1VybU41ck5lM2ZpbHdLcDRoSzZrTEJ1dVo4Nko2MVZlU3ROeXdGRnhn?=
 =?utf-8?B?ZXo4eGFZZjNDL2Q5aStVSmE0WXpnbzlBVmFSY1d6YkdNQklMdDJRMEFFcjJu?=
 =?utf-8?B?eHlYQTRmNkhKTk9sdFBoN1NHeUtUeUFFRWZZcmZqbmdrQ3JBNXh0eVNpTVgy?=
 =?utf-8?B?WnExcU4yUHJiSHpQb1d6TlcrSXRhOEtXbzhybm5lWktUVjc3a3U3aEYyay8v?=
 =?utf-8?B?UVhIWjZtbWpXSW5rL3ZJR0FvbG1SRkhDd3NEOE9Na0FDQWxOTVNnSGNBWW9W?=
 =?utf-8?B?REpRclBYN0xwbG9HRmp5QnFEV243dkgyZytCZFdGeFFGWFhsTFJDT05OaFQ1?=
 =?utf-8?B?a0N2RXlPQThsUHZwOVJkTUJKd1FBMTFFMW95VHBnZ0xrSjRhSVlMV2lyYXFu?=
 =?utf-8?B?ZU1QR3N3M1VxdGRWaXI5YWRBMGpER3RPVFV2bTdPanYzVW54T2VTNmkxT1ph?=
 =?utf-8?B?RzVVdk5BL3lvNHFoeFo3RXY5d1FpbzE1V3ZrRVFDR1lLZ2YzZEhVZEdnK00y?=
 =?utf-8?B?dDIrVXIxSFZuUE5ETEZ6N2FvSVc1ODZxSXNFaTJINnpUVUttRWdJc09MNXRV?=
 =?utf-8?B?WnpDSUJDUy9oUnZnTDErY2RDeGZid0VKVzRaSHV3NVY4ZUl3c1BMb0lzbVpY?=
 =?utf-8?B?MWFqWk1Rc2t4eCtVMHVHU0tWUzUxVDF2dERKZ3FtdG1WaXV6MlYvSXppaVVo?=
 =?utf-8?B?K3lXM2ZkeDVsdWczRUNxaVpGNThibUZhbnlTN0NSTzd3WWZzamYvN3F2NkM5?=
 =?utf-8?B?QXZ2NURlN1VkeDVxMWRRWmFrYXk4NDU1R0ppYXJZK0svVW1BR3p3YWZpUnJO?=
 =?utf-8?B?YkdzTC9ZK2xkMkFpMnlTTkE4U3VvNHVBVzRHbVpMT0V1dmhLSkkyQ1BKUlY2?=
 =?utf-8?B?L2JMQ2tiYnRneVRlNUFQN0phaVNRK2g4YmJSN1pvMmZBdnhXcWU4a21Cbita?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4951a0c-4f1c-45cb-3920-08dbcb0bbae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 10:12:24.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DSN8Nh9iaGylp61M5sQs4geTlMGbDVJm9V0lYL5FTMWHnrlV5uwNiGHaPE2LPsBlhYa55y+epIQU7qPpRsyUdijgS7NE1vwEthpft0kUUczLvFiq62lgCGijcUOUIdYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKZXNzZSBCcmFu
ZGVidXJnDQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA0LCAyMDIzIDEyOjA2IEFNDQo+IFRv
OiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNv
bT47IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBC
cmFuZGVidXJnLCBKZXNzZSA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+OyBLaXRzemVsLCBQ
cnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50
ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjEgMS8yXSBpbnRlbDogZml4IHN0cmluZyB0
cnVuY2F0aW9uIHdhcm5pbmdzDQo+DQo+IEZpeCAtV2Zvcm1hdC10cnVuY2F0ZWQgd2FybmluZ3Mg
dG8gY29tcGxldGUgdGhlIGludGVsIGRpcmVjdG9yaWVzJyBXPTENCj4gY2xlYW4gZWZmb3J0cy4g
VGhlIFc9MSByZWNlbnRseSBnb3QgZW5oYW5jZWQgd2l0aCBhIGZldyBuZXcgZmxhZ3MgYW5kDQo+
IHRoaXMgYnJvdWdodCB1cCBzb21lIG5ldyB3YXJuaW5ncy4NCj4NCj4gU3dpdGNoIHRvIHVzaW5n
IGthc3ByaW50ZigpIHdoZW4gcG9zc2libGUgc28gd2UgYWx3YXlzIGFsbG9jYXRlIHRoZQ0KPiBy
aWdodCBsZW5ndGggc3RyaW5ncy4NCj4NCj4gc3VtbWFyeSBvZiB3YXJuaW5nczoNCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRjaG5sLmM6MTQyNTo2MDogd2Fybmlu
Zzog4oCYJXPigJkgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgNCBi
eXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNpemUgYmV0d2VlbiAxIGFuZCAxMSBbLVdmb3JtYXQtdHJ1
bmNhdGlvbj1dDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl92aXJ0Y2hu
bC5jOjE0MjU6MTc6IG5vdGU6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDcgYW5kIDE3
IGJ5dGVzIGludG8gYSBkZXN0aW5hdGlvbiBvZiBzaXplIDEzDQo+IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2ljZS9pY2VfcHRwLmM6NDM6Mjc6IHdhcm5pbmc6IOKAmCVz4oCZIGRpcmVjdGl2
ZSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCB3cml0aW5nIHVwIHRvIDQ3OSBieXRlcyBpbnRvIGEg
cmVnaW9uIG9mIHNpemUgNjQgWy1XZm9ybWF0LXRydW5jYXRpb249XQ0KPiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jOjQyOjE3OiBub3RlOiDigJhzbnByaW50ZuKAmSBv
dXRwdXQgYmV0d2VlbiAxIGFuZCA0ODAgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUg
NjQNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmM6MzA5Mjo1Mzog
d2FybmluZzog4oCYJWTigJkgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRp
bmcgYmV0d2VlbiAxIGFuZCA1IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSBiZXR3ZWVuIDEg
YW5kIDEzIFstV2Zvcm1hdC10cnVuY2F0aW9uPV0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2lnYl9tYWluLmM6MzA5MjozNDogbm90ZTogZGlyZWN0aXZlIGFyZ3VtZW50IGluIHRo
ZSByYW5nZSBbMCwgNjU1MzVdDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2Jf
bWFpbi5jOjMwOTI6MzQ6IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzAs
IDY1NTM1XQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkw
OjI1OiBub3RlOiDigJhzbnByaW50ZuKAmSBvdXRwdXQgYmV0d2VlbiAyMyBhbmQgNDMgYnl0ZXMg
aW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMzINCj4NCj4gU3VnZ2VzdGVkLWJ5OiBBbGV4YW5k
ZXIgTG9iYWtpbiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogSmVzc2UgQnJhbmRlYnVyZyA8amVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20+DQo+
IC0tLQ0KPiBJIHRob3VnaHQgdGhpcyB3YXMgZmluZSB0byBnbyB0byAtbmV4dCBzaW5jZSB0aGVy
ZSBpc24ndCByZWFsbHkgdXJnZW5jeQ0KPiB0byBkcml2ZSB0aGlzIGNoYW5nZS4NCj4gLS0tDQo+
IC9saW51eC9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfdmlydGNobmwuYzog
SW4gZnVuY3Rpb24g4oCYaWF2Zl92aXJ0Y2hubF9jb21wbGV0aW9u4oCZOg0KPiAvbGludXgvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX3ZpcnRjaG5sLmM6MTQyNTo2MDogd2Fy
bmluZzog4oCYJXPigJkgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcg
NCBieXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNpemUgYmV0d2VlbiAxIGFuZCAxMSBbLVdmb3JtYXQt
dHJ1bmNhdGlvbj1dDQo+ICAxNDI1IHwgICAgICAgICAgICAgICAgIHNucHJpbnRmKHNwZWVkLCBJ
QVZGX01BWF9TUEVFRF9TVFJMRU4sICIlZCAlcyIsDQo+ICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+DQo+ICAxNDI2IHwg
ICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmtfc3BlZWRfbWJwcywgIk1icHMiKTsNCj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn4NCj4g
L2xpbnV4L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lhdmYvaWF2Zl92aXJ0Y2hubC5jOjE0
MjU6MTc6IG5vdGU6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDcgYW5kIDE3IGJ5dGVz
IGludG8gYSBkZXN0aW5hdGlvbiBvZiBzaXplIDEzDQo+ICAxNDI1IHwgICAgICAgICAgICAgICAg
IHNucHJpbnRmKHNwZWVkLCBJQVZGX01BWF9TUEVFRF9TVFJMRU4sICIlZCAlcyIsDQo+ICAgICAg
IHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQo+ICAxNDI2IHwgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmtfc3BlZWRf
bWJwcywgIk1icHMiKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC9saW51eC9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Y2UvaWNlX3B0cC5jOiBJbiBmdW5jdGlvbiDigJhpY2VfZ2V0X3NtYV9jb25maWdfZTgxMHTigJk6
DQo+IC9saW51eC9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cC5jOjQzOjI3
OiB3YXJuaW5nOiDigJglc+KAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgd3Jp
dGluZyB1cCB0byA0NzkgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDY0IFstV2Zvcm1hdC10
cnVuY2F0aW9uPV0NCj4gICAgNDMgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzIiwgaWNl
X3Bpbl9kZXNjX2U4MTB0W2ldLm5hbWUpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn4NCj4gL2xpbnV4L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfcHRw
LmM6NDI6MTc6IG5vdGU6IOKAmHNucHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDEgYW5kIDQ4MCBi
eXRlcyBpbnRvIGEgZGVzdGluYXRpb24gb2Ygc2l6ZSA2NA0KPiAgICA0MiB8ICAgICAgICAgICAg
ICAgICBzbnByaW50ZihwdHBfcGluc1tpXS5uYW1lLCBzaXplb2YocHRwX3BpbnNbaV0ubmFtZSks
DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgNDMgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgIiVzIiwgaWNlX3Bpbl9kZXNjX2U4MTB0W2ldLm5hbWUpOw0KPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gL2xp
bnV4L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jOiBJbiBmdW5jdGlv
biDigJhpZ2Jfc2V0X2Z3X3ZlcnNpb27igJk6DQo+IC9saW51eC9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjUzOiB3YXJuaW5nOiDigJglZOKAmSBkaXJlY3Rp
dmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDUgYnl0ZXMg
aW50byBhIHJlZ2lvbiBvZiBzaXplIGJldHdlZW4gMSBhbmQgMTMgWy1XZm9ybWF0LXRydW5jYXRp
b249XQ0KPiAgMzA5MiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlZC4lZCwg
MHglMDh4LCAlZC4lZC4lZCIsDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+DQo+IC9saW51eC9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZ2IvaWdiX21haW4uYzozMDkyOjM0OiBub3RlOiBkaXJlY3RpdmUgYXJndW1lbnQg
aW4gdGhlIHJhbmdlIFswLCA2NTUzNV0NCj4gIDMwOTIgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiJWQuJWQsIDB4JTA4eCwgJWQuJWQuJWQiLA0KPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gL2xp
bnV4L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jOjMwOTI6MzQ6IG5v
dGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0aGUgcmFuZ2UgWzAsIDY1NTM1XQ0KPiAvbGludXgv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmM6MzA5MDoyNTogbm90ZTog
4oCYc25wcmludGbigJkgb3V0cHV0IGJldHdlZW4gMjMgYW5kIDQzIGJ5dGVzIGludG8gYSBkZXN0
aW5hdGlvbiBvZiBzaXplIDMyDQo+ICAzMDkwIHwgICAgICAgICAgICAgICAgICAgICAgICAgc25w
cmludGYoYWRhcHRlci0+ZndfdmVyc2lvbiwNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgMzA5MSB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihhZGFwdGVyLT5md192ZXJzaW9uKSwNCj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQo+ICAzMDkyIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVk
LiVkLCAweCUwOHgsICVkLiVkLiVkIiwNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgMzA5MyB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZ3LmVlcF9tYWpvciwgZncuZWVwX21pbm9yLCBmdy5l
dHJhY2tfaWQsDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gIDMwOTQgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBmdy5vcl9tYWpvciwgZncub3JfYnVpbGQsIGZ3Lm9y
X3BhdGNoKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAtLS0NCj4gIC4uLi9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aHRvb2wuYyAgICB8ICA0ICstDQo+ICAuLi4vbmV0L2V0
aGVybmV0L2ludGVsL2lhdmYvaWF2Zl92aXJ0Y2hubC5jICAgfCAyMiArKysrLS0tLS0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAgICAgIHwgIDQgKy0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jICAgICB8IDM3ICsrKysr
KysrKy0tLS0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMzcg
ZGVsZXRpb25zKC0pDQo+DQoNClRlc3RlZC1ieTogUHVjaGEgSGltYXNla2hhciBSZWRkeSA8aGlt
YXNla2hhcngucmVkZHkucHVjaGFAaW50ZWwuY29tPiAoQSBDb250aW5nZW50IHdvcmtlciBhdCBJ
bnRlbCkNCg0K

