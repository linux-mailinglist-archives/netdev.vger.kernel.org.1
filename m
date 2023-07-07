Return-Path: <netdev+bounces-16028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9674B060
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4E1C20CB3
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF96C2D9;
	Fri,  7 Jul 2023 12:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B563C13D
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:00:18 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA11FF9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688731217; x=1720267217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MgAsrwtYIFbb9NIMF/cy1EtmgKws6b/XdxXTulb+MUo=;
  b=CeTQXNifAt2epzzyhJwF6QKiWYqhTad0OHzVMzskzuLkgKvE3pmC+EG1
   xxv75FzrBDw321iT1Bp2xzB06oT/GTR2Ee57kKePJslBieeLdO8wsTOOv
   HsEnyktFt1np/DkzsarJuscYxYgyq9OPDGcn/J0qZr7tqaAIYz0xftDNz
   svTGUYp9NhFUKTyDsg9LlR/1aoH6fmJach5g59BUbs7pvTOiqvhm6aD/F
   CpFeayCdaRqYvtgNY+4rWSS5b5NEuOQGwviEaTInIdEDO18rQosDGwEbO
   XO+Vn+a2sTmy9kku1CGqXKIx0JssOepspvjnBaBk33hj368/o671BULOZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367362561"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="367362561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 05:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="864521400"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="864521400"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2023 05:00:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 05:00:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 05:00:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 05:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvD382psesrvbBX/FmXXoKgJQFi2YFvGUieneabGQSqiVWhf0mQwdZ96spR/b4dZMurnKVf7o7IIdR4uF9g0JUBnFV5ZHx8NGv7ws2ji+6eWXOGQ0h7u1Jwx4YeN8XUKge3VMqVk2GkD02W7bII9JoIfhtVlsa3OEnbaaGod50GUHVNPfwWtfr0stRrsyZpekDTekKyoZwV5wrOn5MXuLupMHyy7cr86BI7rGYC9n0nWu8IyrRjiRkyzfaFJeJjfx0wN1UyrPV3AZYDFAnV7mwkQXf3jHtjx695T350WCCkSx6hAVt80DXcVuBg9wC0UyEh53UOoduiWz8RzOBPKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8qQr5SDHfHO5biN7z0F63DPImvAM8vfUmS3Qxlv3g=;
 b=KwNBbsI+p2biyJ9AJDD9bT0aqOdGMQI07cH8SJFZxewKDB8PK7LIE9RZcWAdyDc98KeMNsqPG9Tr0CuCSfqTM4CgeWZX4RvaB0tg9u/WERNwRAI3ggGxY6AcSzL3V1nOHhBT50WIIf2q4NSAlMcVkxEuW+am7+CY9P/swVXsnxq1RGE+XSFzM3Sh9OeLLTNUGL2XRPwP87Cla/dI5OYSGOlVNOGo2rA39yzX2euyF1XbvjtfUvxS+hkeq/UpggwmOlsxAhl1QZWLpWUzSgUXuuMosu3k+VLV4/f9IPxX6QjfhMjstvpenQSnWFglYPESMRCJ/7oJ1L1zqj9xVxlb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 12:00:14 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 12:00:14 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 06/10] ice: Flesh out
 implementation of support for SRIOV on bonded interface
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 06/10] ice: Flesh out
 implementation of support for SRIOV on bonded interface
Thread-Index: AQHZo8XDcvwg9B5if0a4l6DrYUkMka+uTX2w
Date: Fri, 7 Jul 2023 12:00:14 +0000
Message-ID: <PH0PR11MB5013639E2BCF91CA66B77EDB962DA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620221854.848606-7-david.m.ertman@intel.com>
In-Reply-To: <20230620221854.848606-7-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|BL1PR11MB5351:EE_
x-ms-office365-filtering-correlation-id: 4fd50bad-825f-4713-d214-08db7ee1b936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62HBehNTXW50mGnRdUvTTW6RdUPOBVinMzWhT1P9X0URQKbQz7ItZxxmwDzWyIVudrompVZWc84hZt9PQpEf0yXCGPqkEeJwaYqg5r/Pd6uiC7xkGfBqtH+0txp/KWaE8Ammw0vWhDulhMqozOHlwYZO7sBYH1D7tKZrZuRIz/gegjN+ts40px4P0T99bJB/h+T7einxQATkyxn+nCOYZmXaUCI/jONg4QHIZczsyDDsciNH7qjXE2nKo5PdNx5DLEeDKL/izrTyc0kpCd1lbaIqKznAhcs9Jd4kZX3RxUh05Bvvu93fNzmflT2bCzRsjLc4/MRe/xqAUguYsmUkpAR1+eSLp0mNAmgnbDsAqfteb/Xzqktwk5haPuFd7uQEjWA/LxeWR1nLR6Lff1emdc4KmNHylegC0NXtSAAL1E1SQr+gq+KXogVEiP6ocq9K98FVUHmXTu2vnikO4so985kNfSitcf+kfztJ308SPsezqtMH1rnyDj0WbLUvjz82tKfVh1+rqa02Q6qgGOKX22iIz80qSSiUCECHE5fO0sd/UkyxAHTgSt22o/VJEdkkFSOgJt7M6OT1Qam8qVXwPF6q44j+abJCenSRRVtelKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(83380400001)(82960400001)(122000001)(33656002)(86362001)(38100700002)(55016003)(38070700005)(110136005)(54906003)(71200400001)(7696005)(41300700001)(478600001)(9686003)(8936002)(8676002)(5660300002)(52536014)(64756008)(66446008)(2906002)(316002)(66556008)(4326008)(76116006)(66946007)(66476007)(4744005)(186003)(53546011)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X5PbN6hbKS+OgotkA/XaD4qb6Qa9XxgV299YFyB5FWFAFAuT0LiHyI3Bvh49?=
 =?us-ascii?Q?xHBDC4/HESC9Ts8/c5AOx99o6StzdNQa+2m21ubJqwZOLgvOtXsu+IfTyWA6?=
 =?us-ascii?Q?ytYjRsJyb/16IZPV/a3CdtQ12wkffN2ss/7i4vWI2zhh9He2obrviMKmpthd?=
 =?us-ascii?Q?UpBC68YBx+hr/klgY3Mx2Qn/t6mSKgRSqNrzf8ynaSH2nj7sf+SJr91Lc6Hw?=
 =?us-ascii?Q?lukj7E5TTQvzyYyjiEo7u2zucgqWeRImHvspHogpPguAw4JO80+y1co3Ppsw?=
 =?us-ascii?Q?A7N/KECe0G+2D1SEJOcLI57PSbb6fKqy/IGV6XrqpjgGjDyQtwJ7WtXbCZNk?=
 =?us-ascii?Q?avbOCbKaqkOuhg9JNaRo5u6FodKRzbPMSLxzGRBhUDw2hb5Z6zxanYpneKxS?=
 =?us-ascii?Q?Aha/uO1dyHSlcAuGmsQHCEoHBpbm7ZaXYiWmYzOktPOnnZk/XU/k4Vo6K+Tw?=
 =?us-ascii?Q?HrXG98VMJGOljeioPzN4gXq6HFRDLwZFYtDU6r81U3jOLeWLJeMVn07vqOmE?=
 =?us-ascii?Q?nbj1D7m+6W+QRcffOEbOtfRKPqd8PhqfwPmtpqtx9AyePYZ6sCVT/ZCA1moN?=
 =?us-ascii?Q?5cjmS9z/piEfwuJcVcLqoVM7NsRngMcMTkHp6nuluk85uR7OWOkQtutvoT+D?=
 =?us-ascii?Q?utJjfDdUpjckBdCoGqTMgthwRFu7FIia1cuR+irZryyG4tWPRbd8S2xLpZ1G?=
 =?us-ascii?Q?GPYaEfKWquD5CAvqv1eN0+uru7ylyb2c7qM2ObWprpxgkq1sV3trS2pF7KYo?=
 =?us-ascii?Q?NeBzhNagmEqFaC8io+rHWsLpQ3Ll/R/M8YG3uTdZTDZmQ+qx+cuUUKy9vLAW?=
 =?us-ascii?Q?e8ycE7n9k3vkPaO0z/g5qho+zFQQvV/O14uNYaymNbtAg/dCmwDB2D2L5iUB?=
 =?us-ascii?Q?pyHVYKA0q6heAi8o5ZTmBZ/M0eLqqwPUdPPjje5UHIYnrpDmW3eSh7/yxxpG?=
 =?us-ascii?Q?QyMiIwGkdQ6jn1ZmBX9xO+iBwsKIwmLSaEK9MrEpVYN8+A5o9tvhvfvuXUL1?=
 =?us-ascii?Q?fZuuoTPwG2HAWAJlQn+ZB0/v3PTUYYE12iC+Pm/RH2WDsrE8PSNXLUD/XzBZ?=
 =?us-ascii?Q?hWuVgmrkFJ+x9Y6e3QHlkfGX0OXqcnBOBxmrAHnM86IoMSDZW9Ymb4YpED0E?=
 =?us-ascii?Q?esd5cOet3Aj/wH7Q48RV6XOBby+TjwRA5A3DlyhaGfV6baoalbu3ozQmgwGN?=
 =?us-ascii?Q?wCVtC+LP+pGpsrn7Cg0F0W1EDakDy43CMroW/VjcNIzzlsj+kYjgGxwwdYGG?=
 =?us-ascii?Q?i8hTlLmVvs/Qk8omFpeCGckEbBodrnUNbmfyP48tkkhs2xGqLTsXM0cFMmiL?=
 =?us-ascii?Q?nBGtx2ySdNn2nMlMLi8oA4XaxlJAZtdUkgdQaLEoTXnLzn1yu5HizCmQ5r0f?=
 =?us-ascii?Q?OgrOV0qaH5/Qqn5jzIeuZwAGJWVhg94sPXMdCxjdW9Jvzx12gAI09t1vy3Gp?=
 =?us-ascii?Q?uh1aiYJzPvF/EbOwEj3fN8NeLSUCRlFXjf0TRmYn3YFW2c6jOENYC6LB6jcn?=
 =?us-ascii?Q?no3IzrWu7Pp7YPzre1wpV/XqiabUw4rWKUETaadRoPXuYBfymMlXmX23iG0x?=
 =?us-ascii?Q?sOPspi4AguYXjdo5Y5B8Q1dYMifn7RoUkMwU2nauLBBBld4Qn8X/xsyF8T/K?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd50bad-825f-4713-d214-08db7ee1b936
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 12:00:14.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeC0X6SOe3P24W3Af9YOzgk+A8JDm3bGE97rftWZmbHtKmfjmyEqZgXQfWZRnzdRpfzA8VP8uLeu900PRYTRVRyItyKBiAeHWA24+UjpD0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Wednesday, June 21, 2023 3:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; bcreeley@amd.com;
> daniel.machon@microchip.com; simon.horman@corigine.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 06/10] ice: Flesh out
> implementation of support for SRIOV on bonded interface
>=20
> Add in the functions that will allow a VF created on the primary interfac=
e of a
> bond to "fail-over" to another PF interface in the bond and continue to T=
x
> and Rx.
>=20
> Add in an ordered take-down path for the bonded interface.
>=20
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 822 ++++++++++++++++++++++-
>  1 file changed, 812 insertions(+), 10 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

