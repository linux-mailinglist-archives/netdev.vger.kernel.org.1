Return-Path: <netdev+bounces-20109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C575DA7F
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57361C20AB7
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07211CB9;
	Sat, 22 Jul 2023 06:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B912B77
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:52:05 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD73A90
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008724; x=1721544724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hlY2r3EMaX5VLonT+hFTYEeFxQefM+PtZEmv7zn8HOo=;
  b=IN/bdLdRcgZglAV7wfQNbBEhFokLt5uYn8+2GoKFaEHNgUr7UB14BQif
   +4trgXBUERVDOTJheOC45s7A3q+wtY5r/FLds3HHi3poog45cNVcfaiks
   fmhwLi1QwyAD5hMOjVEPSGLAGiT9Unid73NHcv9CSJQFYMbaWmf73RPqa
   +5FmlcNP6btgrLWa+kDbNQ0KzRup1QkaAWjffTM6brL8+jYOoIkee50wH
   /mig+H6MchTzNE0v+c2/h75ssHl29ifsJo8/QWRV5VmEE21Qcj9oLISCR
   4Mwa8Mul7VG8P477QS9AbycGmrgUK6WBdh0xMo+GNyBCSfVrmBVUomgUV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="366061785"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="366061785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675278703"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="675278703"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 23:52:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:52:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:52:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOIqkhLjYl8FSTAyP7vddg/i06N7gWje37tmvq+jZnZbXQY9UNqTdgxbOEYlzBz4+Gymd2v8LcnZsH3axL0mSxXzeEI2q6syb77PY+rDghy/8FYOSL4d6bzaPoXGSq8EZI7We9t2yrZJ5cUM/BcQcu0yV7N51VlolXnzImmm9EGxY/P2UrBADktBK3o2f+Jk5m0Vj9NkxRxoGMS5w0WKQJlBoy0/HM7Vc/nWNenWkcCnck9qZtcTY3tvmNxGB1thNsQh8GgbgxYP61quFNMRsiQ05ovw17NMTrwumYexoPVTNFVEjU3iaY+Tb9Elr86TcmyNcl0ISb6Mr0y+gbH5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJwjZ2JDy1LOGnKC7m+G48PRYzeeB036JHl2ADUSS/0=;
 b=Vwj7xXoeN2GMDgaZXaSQZFQtED8cX4j22N1l+hMNYOKBNzFxjrBsT6QXC48YrffLBTU1lvYyGco/1B4xHDsg77eqcJq8KUPOFW3QjzFK/MZKaQ4jHQEBqALuCUxyiqi1qdwCdGJy1dfjsABabkPW6COOvHUoV9vu60sJB70h5K8Z7eX2fYAm2/vxX9FUG8wm6JkXYdHnRV3WOBSrwtXt8YE2PUH3QPph2OGhY5thLvJzQjVAxC4mhsEQJoa6qMeZjfepkhOi9VUHFs0STn6OFflZukEoJiyad5CVRR9+wW0X49zqqta9hck6bc9MsMwgjoLjEUcaDL3YY34JHIRb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sat, 22 Jul
 2023 06:52:00 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:52:00 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 12/12] ice: add tracepoints
 for the switchdev bridge
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 12/12] ice: add tracepoints
 for the switchdev bridge
Thread-Index: AQHZtLEDJSzES9Bja0mKCg0Zymo8a6/FaIOw
Date: Sat, 22 Jul 2023 06:52:00 +0000
Message-ID: <PH0PR11MB50133100B47CD237549A5D37963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-13-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-13-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|MN0PR11MB6033:EE_
x-ms-office365-filtering-correlation-id: a321aae0-c1f2-4402-8be0-08db8a8025fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inXBaT7dWg4QOMgbPhSusWSopl3qQWjCuCyQLTKclQ/cxyVLu2FnesLwf7GUdpK6+uUOQ3VgbASAeXdCmBpKhhYaFHZ5TMn8Fxxws4vqtWnJdkC/K4rPFP55OS1XdCXe8D92Enojy2uExHo4qdtLhOaqR2POjs6btRbKPIXibmE8IsQXJlR6dwoRqxfkbGmirdO+Q7Lz7CmkD+1MqXqWboTl41QtgVPlPtvV15Bew6t1O3LWRjdLgfpYaJmYgMWsyybG+D2KvywgVRFe/bXPL3PJ/25xl9QLhdlNVkD9Mg/JRej8C9545CBhOsDqGAzayb98P7YxxYdlSAFggeRFudM4rMt0zQVzDVpRs/TX1THeN//krLylScH7+7Ls6SbJbWnl+ZaZ3RTDkln8iOimiw0GwQJaPVqeb/FpDv7jCabmMm+ykafKAxucaGKpDnZ1qO/0GM0mr7MEru3wiiLJKgecJV6Pz2CuFprTEV8ThG3u4eFhhtnVlStiO+SygXKTKPvBLhnhygrIRmBHAL86bturGsWQZL78bZyXG7FaD0LOsXJODBsOnn7CWBZoecEEyp88iDUdbVc2J9YpyZGOJT5YjOfmXWGMBMAmJro02cOtVCIiWBaIear37ldEBAMc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(64756008)(83380400001)(66946007)(66476007)(66446008)(66556008)(76116006)(33656002)(38100700002)(86362001)(55016003)(2906002)(4744005)(8936002)(8676002)(52536014)(82960400001)(122000001)(41300700001)(38070700005)(5660300002)(478600001)(4326008)(316002)(7696005)(71200400001)(53546011)(6506007)(54906003)(110136005)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tfHozco45e39wK+W8rWoVlKZU8zZCPiv88xJvqX3/x2AgcxpNCJAvzn82tqn?=
 =?us-ascii?Q?wlknJ5CdzWT0S44CLWeStvSorbBcZofoC5V+U9XqKGzf7A/GRj760QDulebh?=
 =?us-ascii?Q?1/DZIwvi8bsGBu2F7G7KsYSQlexQ4g47fwwhne8BK3oC3wW/chu+6Da3lYxq?=
 =?us-ascii?Q?xC8TwZgliMlSxNr26m5gEIVlndQy0iQUf6YmSnGuv5HEw4QbtWwyQUGVKxj6?=
 =?us-ascii?Q?NVBhD95D46XfBkE3iOYYKy6jaS42AQ9SI6SAO9hgTiWoyBVcNTKYjpiya7ke?=
 =?us-ascii?Q?qIzXgIMcB1rwAYEdpz66lsOI6Q4xk17WlFv4L/wSLmzxhdmcZ6Bo8wie7you?=
 =?us-ascii?Q?xEWPUpi3h5XLYlr9VJDY5+CJ9haklpv8FzvcXnNywsCVfY6Q7hcDsYy3UNsQ?=
 =?us-ascii?Q?J8ADXsQWmNs0R4h2yrxpyfHUzisWTn9bOVRzzZP8VSH++xcAzLZ8mBgDwW3z?=
 =?us-ascii?Q?d9tCYsc/tBAQh/+3Bn75+kOMItaufEU6O1t/fTePcC6BpAOL/KI8ufxk6bcj?=
 =?us-ascii?Q?e3a0+GP6xPEuchFFAqxfhwXeg904xvgx2JjtyBTLXlfBV/Jbx5X10qIDNMvY?=
 =?us-ascii?Q?muJO5boXPDgOjs3bNYK/z3MBiOGUcjavZ1B7F2Bqxv+LVgTkYPOmydtkzHdK?=
 =?us-ascii?Q?rp3qjUe0SzZUbwW1+pCWz5lPd9/ud4MFerG2U1zMDVshBvW8YCBY2rlZx/fU?=
 =?us-ascii?Q?scG/uq9e4691VPv3pbyuDHXehlN0cX5FAlfdum36+EV21T1q/rBkkgvSrcmy?=
 =?us-ascii?Q?KxIV5H/67NDTSYiSgeFHYVajHsioE2/WYROEk/Y4GqvPqmEtqvurUGcQSJ4w?=
 =?us-ascii?Q?y3A22RSfMgtw6lT8Q4/BSTOQecEWDBOaSdw3WgYq56Unr6MKmI83xFUmmTAo?=
 =?us-ascii?Q?6wQe2orraLcHms+gexYoN8gjwcGo+KYlntgjq50VRg/3gHgzVEH/uFr+omGd?=
 =?us-ascii?Q?T9+eU2j4233OmruJ6Fhk1RGpXqivTzuXG0VpUfq0SADQ4YYZPE9d9YCGPWs3?=
 =?us-ascii?Q?hY/q4sxGtPeZu+GVmqoAZMCKs4Jj/kfz+1ZzbNLdYfkoDKJj85HoaPvohj0v?=
 =?us-ascii?Q?FA6lOlDkWVLAmKVfiYtJgypfmwJNH4Xmqayq2/oN3ctQbneMSpVhA1RetGRT?=
 =?us-ascii?Q?ahrTAIAu01FJsTRv/DSIhgEMC/6obZbnywBPzfejkfTGqz4KFyDd3fq3FhVZ?=
 =?us-ascii?Q?xO4nvsav1IVNT32+pzn6ECjKBjDSBnYvp+7yTeriZ0SuuMTCGpATpFTHSgfA?=
 =?us-ascii?Q?sB3qOSrRp3U7BhX4LwHosSNCk8bsKnDWPdUGEZb/hDd4QVKapPDU7lV+XEWg?=
 =?us-ascii?Q?gtW9wv9cz5ldgXQoeEcfl/F6GC9cwbgWs6E205s+DZxa3I++Jr4x4fGYHTwW?=
 =?us-ascii?Q?TaE3IQk3toN4YjfhCu/RWH0OSfliEkrRp+58lIhzMqNvUsqtwYShd9h5g5Uh?=
 =?us-ascii?Q?mUGPwuYBbckKlGLmjVaW40mrYAQkrzJwVJ2+S97CiXGSKJDw9VQy+AyYklzI?=
 =?us-ascii?Q?EAv1UrHD9YD6uDadwtOMlRETQwP6BOOPKdJGv+iklLp6TtHtyrK9aJLQpSgz?=
 =?us-ascii?Q?QzVEazUNMGLdsL2sR9sIxCnwDQ4yRswuuHi3qORoG6HaelwyxklFVX25iuNg?=
 =?us-ascii?Q?cA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a321aae0-c1f2-4402-8be0-08db8a8025fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:52:00.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvmgoXBF18dQq3aIJnq/nnPvpvsJ/yNfsogFA+/yZNligUczNeyRbKpF3EE4YZsvqd6cdbwmcItOILWktI5NrqD7CgxFea5Obx8GQS81KGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 12/12] ice: add tracepoints=
 for
> the switchdev bridge
>=20
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
>=20
> Add tracepoints for the following events:
> - Add FDB entry
> - Delete FDB entry
> - Create bridge VLAN
> - Cleanup bridge VLAN
> - Link port to the bridge
> - Unlink port from the bridge
>=20
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 10 +++
>  drivers/net/ethernet/intel/ice/ice_trace.h    | 90 +++++++++++++++++++
>  2 files changed, 100 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

