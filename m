Return-Path: <netdev+bounces-37908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2597B7B79
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 51DC7B2080E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FB810960;
	Wed,  4 Oct 2023 09:13:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873D101FF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:13:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFEB0;
	Wed,  4 Oct 2023 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410814; x=1727946814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhA6G6iQDk6h2ylVLlt4bh1ON0HblxKQcSUr8gi0CsI=;
  b=YJWN85smSicsTH510GrBRBVcWZkB32yxRxfGjsv2JhyzWSkwNDjcSbt6
   6kgR0NvdShmgylph5mjNvpqZ9yuU5KhF86nwczQsdaeGymvnoZi8v/W2+
   3wy9gp/nhjmms+cpUtCUefxGzwyMZy2bQtV9TXdCFzPimiJ4Q1khHPs3X
   dDPTTkkIgjkDii587SynWa3CzFJo9dCBRvpDsWZyKyndvmBsN26gbb/9H
   WiYGL4R41u1MTkzSwfnnlFc6xyv2B4HuceBsw3Rp1mSIigGPSwdJX6AKF
   5xtssH7VbkYaQjkS+zfLNPrybVI90Ti81IRTNwroPxTGCyzpvtAyxCRLH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449605492"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449605492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="925026774"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="925026774"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 02:13:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 02:13:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 02:13:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 02:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGV/zsBASLaI6+Yz26JUbQ5PapMGQW6ffFoyGEDUGwAcQ4sXorq18hJGj8cYQWj9FxiZTw7z5xmVZbBiaiaFk8jJ+jvqINGP+lRxn0ozAcNL+Q2+Qrjym1Wd8F3B8rDueZWRQauYR3W8eYxncAlqnQB7N+rDPGxo0NvoQO4CH4XJQAprqm87I8iivTsyzjCEKLiKSHoYHAqBginrpbtgZfLW3B7mFMLVuCVp2rDTTveqLhm3Jb/ii6g7+Pf1x5OgjFEtM2m0jhtdQqZZPxU9YfJzFfZbm0rj0SEmuW+diQvEl0FpoxOYh9bf6JKjXwN2EjBhdkWyjNUizgyfxZxf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2R/dHq05OHJLCphhmiRSGNH6ldfA1jt6ht1YJMsIys=;
 b=LjoMdIKp5mF5f4vFcvU5uMxtCns6xwfs4pjgV3po2g7S9qRhJlEBPbEB7siSDdhygdlNOptt8zy3g2/S+g9VM9z58Ajc78gH1nuvbzG3SPVDv/b5SLx8kdy43AS7km5OjDXDJHfsA/Bsvh5L0oheuBn2jf/DJwzhTWxYotPd75ZljCEkocgN2ONJg1g0VjDx1B5ajTxZwU7zBBBy1rVrpyI4Fgw6V5A1gZUs6WNJG7rM/h/e4lrbj+HmTJP5aMZh7dqYWUOV7PuQK6mBkhlXkQlAMB8jqFfAlcUl1wStOs/PLO7ygEoibo2zLJLmZ5r+jyaN+JC5pG+24aQRUDWkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.30; Wed, 4 Oct 2023 09:13:23 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f%3]) with mapi id 15.20.6813.035; Wed, 4 Oct 2023
 09:13:23 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: add
 support for pin-dpll signal phase offset/adjust
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: add
 support for pin-dpll signal phase offset/adjust
Thread-Index: AQHZ8STYBdXle/Bxd0eyxPCX/7DD6LAu+R+AgAebAaCAAA0FgIAAAWUAgAB1LQCAAItBAIAAgqAQgAAzfoCAAQoWUA==
Date: Wed, 4 Oct 2023 09:13:23 +0000
Message-ID: <DM6PR11MB46573D01E85D027150761CC99BCBA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRrb87drG7aVrxsT@nanopsycho>
 <eb019ccf-c50b-e9d7-e4e6-f6574f805b49@linux.dev>
 <DM6PR11MB4657DB3C9BC3E1EFE6A2F3389BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRu0OlwKWSmXFOcV@nanopsycho>
 <DM6PR11MB46573DF9081298B816A215329BC4A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRxM/+njiiu78b9p@nanopsycho>
In-Reply-To: <ZRxM/+njiiu78b9p@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CO1PR11MB4980:EE_
x-ms-office365-filtering-correlation-id: fb862e17-51e4-4a6e-28d4-08dbc4ba293b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Za4S5SFqJt+VnffBbycG0rQ1LcT1xkHnv/hwUxGrdQ99a+ZVnmDt945XLw82gv73uLRaoynHulDaOeBuqxqYcpwCzKaiYO424WT0UMiDJUgt7MJaZyX2JKtiIwhPBmA2lW4/7lud+4cTAGiE73JoUQZogYVyA6nLZuy1kA0gNi3v1AXV+SgiWZupPiOXNt5AUlSRU2vCIMUbci8SPL0b6JfLtmZ9Xacik30+loWQY8wqIA8KGwzP1ujCmrqV4semezQ4GcnvPkCCA/dw9tMZ15TM9sNwLmuflZW/OTaj7Wg50fACmstzrtfOKhcz7gNcQ9bmyl8jQ2naIyeHTZY3TUhMVHUx/JS37dGgdP/cQqxVaW1QPRsqhbKp2qTLLK36JP0BqkSfrG0jZp4DcJleeD3Psbx+TkvWsRH0AjPuNQgBU79v2uq/IJbnhRNaiC+h7Y4lzpa+kpVgcTzGjqAZ6xWqKF5HV6+ipu7mkiGBelTETLXZYLKs1hfDUrBmbymuFNXBgKWcnyTtFN3bhpG3dvrjrPPYo2usypwh9y4zzvJE455052KYdyGp0bVCXMSurkzSrGtOOLn7Dqr7f5QeNmoNo4y+Ia6GGWY864wTxZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(52536014)(4326008)(66556008)(66446008)(55016003)(316002)(66946007)(54906003)(6916009)(41300700001)(64756008)(76116006)(478600001)(66476007)(8936002)(5660300002)(8676002)(71200400001)(7696005)(53546011)(6506007)(9686003)(26005)(122000001)(82960400001)(38070700005)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f2wupx38XbYceR0xcelWlou73sawCFRngjrwfudOn3u+8RgR5M8Wxy43LyHx?=
 =?us-ascii?Q?J4byaqHMZRJQw8wlwQdawpxq5P2JQd3Y0bM0BSfAT81+PdPCHdfmeoQgez8+?=
 =?us-ascii?Q?yBCTCqN0JwXkxfnw0fPFGeGHxSPO5EIaCg6fmwZHsMt2M5QSFNef024DGupO?=
 =?us-ascii?Q?1A0BrDUGq/giucqXu7sjkkwhQdSUQRb4K4PCmgz7LvUYuFv6+lmcTmcStMrW?=
 =?us-ascii?Q?dgfBx89Qr6X0GSwzGPMGziAkExmsTVsxJPkqC1OpKxb0Qr3kqv5zOap5hSge?=
 =?us-ascii?Q?npAGhNjUiKDSFcDKZfpO/BIqE/uSm1IRQRn0R8FH61gcMQ1QQgntkeSNbG1x?=
 =?us-ascii?Q?62PnDxDvsGGY9T1J5q0zS/ygLYTyGC7o6HKv2HVpVpZvSAzT6TxxBlll2lgv?=
 =?us-ascii?Q?BrbLHRYFJ1Po3U57XOfEDorhv4rGLaAujo030054+GJT7Gjprc1SMpFxAZKA?=
 =?us-ascii?Q?0FYq4P0+aei1EGzLr5O+CHy4Wc8U5eb1BZYoPRxRdOyDFX3QMLhB9BLFurmz?=
 =?us-ascii?Q?1VnejmHGCsvv6rdxxCYI3PtHHMRuf6YdgprE0EBxIpidGrar+hTBuSdyBKL3?=
 =?us-ascii?Q?SWjsYtMXa149dBHuBxeo+hKrGbynYQc32OX6Uvd2SwqWWRxm/dy0qHnTy/81?=
 =?us-ascii?Q?7CjqGHctE+AX2fHSc74AHbU8sVIpqXNs9qKFlBfDhXcC+eKfdlZHaXPHxhtc?=
 =?us-ascii?Q?nHw9rcNV3yAjb7kU+J8LOy2/wWCPE1qUaI/ZPa1mAGPAl8hIgV0QiX+7Nkuz?=
 =?us-ascii?Q?5J5J5KOyzVLThMQ2fsV/p5FR774WpQ17sZZLI3vPKESLSKFz3t8uu1AHLJxJ?=
 =?us-ascii?Q?Ydj7qr7DAGnd5/9x3h/wAwCmTgT4SNKgAeJXcu1nUHrShhyXwG2wbiLW5M98?=
 =?us-ascii?Q?SQCYnLmk2ecJ7zKuKWuP5gmI0QJMgQSf91UFx3N1u5myEE+JiL6GMKz63F9h?=
 =?us-ascii?Q?azYaVITdoMT3dNxcDXQACbknGJipJXq7ZDZDp37RVn5VXcbEyLZzQcXXVjam?=
 =?us-ascii?Q?hCY/dR50DviALf8emC/xSYs4yg+vCH6YvUJFKXgWumPRR081O6lIXGw4Sw8h?=
 =?us-ascii?Q?fo0hgypRl7UT64B3fTrgyXjwkv39xfLxL08aKUyqCEj9u5GuFni5oWBBDWHN?=
 =?us-ascii?Q?FEsImVVSUrtRJw1l+jgDTLpWW3T7/oO+RmGkKuhZ4YsjB41ZC4GivBfuCbyJ?=
 =?us-ascii?Q?FfhoIDH0tml/6wJzQiO38WfJEBTuCx7mzMEfbHApswUxUVjyUohywWFv8hJG?=
 =?us-ascii?Q?PkOaR1RDZZrANHynfCcaydG84tJ6qcOHHUsnOWqD4fwUUARcxqEPAvyvOXhg?=
 =?us-ascii?Q?vz0p/LzcqyiKUgn1eW5AGTGdX/3iC6ds3fKpAff9y17evfEjpf70yDUvYc8j?=
 =?us-ascii?Q?xexShbMR5G31PDRjr0kioLoSw+ouOy9ON2wOevlWVt10imvdWq6ihnSe18Da?=
 =?us-ascii?Q?BjbxGCEX/9d/BKxlT4ZMhulizclWW3hihZyz9NaQ2X3QANKLo2XsxeG2fEx3?=
 =?us-ascii?Q?svqR6cmhkB9WqmVYNXOXX/NdK2YFOwgvUB/syyHEMMkJ60u0dKNirpz39VW1?=
 =?us-ascii?Q?AMGYrZj0fHoKTQwKXKz+UHUbDW0euvpieILqUUMxbgZP9NW4n/aJbcLNme4+?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb862e17-51e4-4a6e-28d4-08dbc4ba293b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 09:13:23.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHGNsUEByKDvD6nDyexRwF1x7X6BDg7jwD6IJh7/ly/hEQ3BImY/ClC5PvpYPLCCpx0cOFdZEDFkoipk6EXvqHUR/Mir8IWkxsqY+Co5/hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, October 3, 2023 7:19 PM
>
>Tue, Oct 03, 2023 at 04:29:13PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Tuesday, October 3, 2023 8:27 AM
>>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
>>>
>>>Tue, Oct 03, 2023 at 01:10:39AM CEST, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf O=
f
>>>>>Vadim Fedorenko
>>>>>Sent: Monday, October 2, 2023 5:09 PM
>>>>>
>>>>>On 02/10/2023 16:04, Jiri Pirko wrote:
>>>>>> Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com
>>>>>> wrote:
>>>>>>>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>>> Sent: Wednesday, September 27, 2023 8:09 PM
>>>>>>>>
>>>>>>>> On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>>>>>>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>>>>>>>> Add callback ops (get/set) for pin signal phase adjustment.
>>>>>>>>> Add min and max phase adjustment values to pin proprties.
>>>>>>>>> Invoke get callbacks when filling up the pin details to provide u=
ser
>>>>>>>>> with phase related attribute values.
>>>>>>>>> Invoke phase-adjust set callback when phase-adjust value is provi=
ded
>>>>>>>>> for
>>>>>>>>> pin-set request.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.c=
om>
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> +static int
>>>>>>>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>>>>>>>> *phase_adj_attr,
>>>>>>>>> +		       struct netlink_ext_ack *extack)
>>>>>>>>> +{
>>>>>>>>> +	struct dpll_pin_ref *ref;
>>>>>>>>> +	unsigned long i;
>>>>>>>>> +	s32 phase_adj;
>>>>>>>>> +	int ret;
>>>>>>>>> +
>>>>>>>>> +	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>>>>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>>> +	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not
>>>>>>>>> supported");
>>>>>>>>> +		return -EINVAL;
>>>>>>>>> +	}
>>>>>>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>>>>>>> +		const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>>>>>>>> +		struct dpll_device *dpll =3D ref->dpll;
>>>>>>>>> +
>>>>>>>>> +		if (!ops->phase_adjust_set)
>>>>>>>>> +			return -EOPNOTSUPP;
>>>>>>>>
>>>>>>>> I'm thinking about this part. We can potentially have dpll devices
>>>>>>>> with
>>>>>>>> different expectations on phase adjustments, right? And if one of
>>>>>>>> them
>>>>>>>> won't be able to adjust phase (or will fail in the next line), the=
n
>>>>>>>> netlink will return EOPNOTSUPP while _some_ of the devices will be
>>>>>>>> adjusted. Doesn't look great. Can we think about different way to
>>>>>>>> apply
>>>>>>>> the change?
>>>>>>>>
>>>>>>>
>>>>>>> Well makes sense to me.
>>>>>>>
>>>>>>> Does following makes sense as a fix?
>>>>>>> We would call op for all devices which has been provided with the o=
p.
>>>>>>> If device has no op -> add extack error, continue
>>>>>>
>>>>>> Is it real to expect some of the device support this and others don'=
t?
>>>>>> Is it true for ice?
>>>>>> If not, I would got for all-or-nothing here.
>>>>>>
>>>>>
>>>>>But nothing blocks vendors to provide such configuration. Should we
>>>>>rollback the configuration? Otherwise we can easily make it
>>>>>inconsistent.
>>>>
>>>>Good point, in such case rollback might be required.
>>>>
>>>>>
>>>>>I'm more thinking of checking if all the devices returned error (or
>>>>>absence of operation callback) and then return error instead of 0 with
>>>>>extack filled in.
>>>>>
>>>>
>>>>Well, what if different devices would return different errors?
>>>>In general we would have to keep track of the error values returned in
>>>>such case.. Assuming one is different than the other - still need to
>>>>error
>>>>extack them out? I guess it would be easier to return common error if
>>>there
>>>
>>>In this case, it is common to return the first error hit and bail out,
>>>not trying the rest.
>>>
>>
>>OK, so now I see it like this:
>>-> check if all device implement callback, if not return EOPNOTSUPP;
>>-> get old phase_adjust
>>-> if new =3D=3D old, return EINVAL
>
>0 would be better, no? User has what he desired.
>

Yes, that makes sense.

>
>>-> for each device: call phase_adjust_set, if fails, rollback all previou=
s
>>   successful attempts and return the failure code
>
>That would work.
>

Great, just sent v2.
Thanks!
Arkadiusz

>
>>?
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>were only failures and let the driver fill the errors on extack, smt
>>>>like:
>>>>
>>>>	int miss_cb_num =3D 0, dev_num =3D 0, err_num;
>>>>
>>>>	xa_for_each(&pin->dpll_refs, i, ref) {
>>>>		const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>>>		struct dpll_device *dpll =3D ref->dpll;
>>>>
>>>>		dev_num++;
>>>>		if (!ops->phase_adjust_set) {
>>>>			miss_cb_num++;
>>>>			continue;
>>>>		}
>>>>		ret =3D ops->phase_adjust_set(pin,
>>>>					dpll_pin_on_dpll_priv(dpll, pin),
>>>>					dpll, dpll_priv(dpll), phase_adj,
>>>>					extack);
>>>>		if (ret)
>>>>			err_num++;
>>>>	}
>>>>	if (dev_num =3D=3D miss_cb_num)
>>>>		return -EOPNOTSUPP;
>>>>	if (dev_num =3D=3D err_num)
>>>>		return -EINVAL;
>>>>	__dpll_pin_change_ntf(pin);
>>>>	return 0;
>>>>
>>>>??
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>>
>>>>>>> If device fails to set -> add extack error, continue
>>>>>>> Function always returns 0.
>>>>>>>
>>>>>>> Thank you!
>>>>>>> Arkadiusz
>>>>>>>
>>>>>>>>
>>>>>>>>> +		ret =3D ops->phase_adjust_set(pin,
>>>>>>>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>>>>>>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>>>>>>>> +					    extack);
>>>>>>>>> +		if (ret)
>>>>>>>>> +			return ret;
>>>>>>>>> +	}
>>>>>>>>> +	__dpll_pin_change_ntf(pin);
>>>>>>>>> +
>>>>>>>>> +	return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>
>>>>>_______________________________________________
>>>>>Intel-wired-lan mailing list
>>>>>Intel-wired-lan@osuosl.org
>>>>>https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>

