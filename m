Return-Path: <netdev+bounces-13068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AABE73A14C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D99028197B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283521EA93;
	Thu, 22 Jun 2023 12:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101921EA76
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:55:53 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4761BD1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687438550; x=1718974550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cleBsiZ/uyWn8W6H4kTrqCI4Y4jWE0eqeL25n8fLPnU=;
  b=lfYIdtmKycClEBb5/wC3GL5RNiLQGBcrLeGoqK3ZilulxNyXCgIr4la3
   AYZsvb0vMqIW4AC6m8yV35lg1BrjSdLf2wJD24VRY2SiE5R8cjBAAFiXw
   PyDVt+LkjhEzjD6MsLFZTwrwkq87UDSp8nk4hFMUVDiZ64F2AZaXgQB4V
   ml492tx9VN7akbHS/cMAhJh5OOcTcICMIclSOHEtBkGCTG7pYSOVYdPCA
   CbNQ0ftcmSxBxLmDztlTb9lRj8m2QASZoqgpROVNpX8Cr/6UWqbKeCT1G
   YbSbL5jLOSb9C59FZbJaJdAGKzW1Ep9emHb0HkW6/G1gp0oWUMs6Oipm4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="446853291"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="446853291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692249461"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="692249461"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 05:55:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 05:55:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 05:55:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 05:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/TloKNBy9b+UPEXBu5F2733r4gX7zxt0FUFV4voZY5siFjM8MaMkzH0VNi7rqaXqXp2GXpX0tLE3kC02ryT5l9NgtNi1tpPXIAcbQHbnVACIyRonOymtdRhVEoUcSNjLsR1g68bTNw6hlCUbOQjwP6BFu/eOTtHmYPlyz/Cqp3jtshc4dz9DdMi50RmPWTb+GWMwVe6n6gKrXakeavFHUAt5LEbK9aDCJQU40rgLMtXhQoUib7PF1t6vTYkqQGepkYE+vKt/mSjA8UFzGZlqfGzq/3ZHLLQnQVnQK9QnIAErhrVMo66NxJNXFyLf3SN3qRU4d8mKBI8bUFgvPhMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KthKipO7BgBSFWj8wDEXRtrVbKniwt0ckqjfOuac4o=;
 b=apke/mLssB2qwu/w4YDXMkoJNN+IymaHT3kkhgP8p3tZ5aotxgXR8/b5SPnpnm3NJRUMYsA7y9Ie3WqRzeA1mMWB7V+TKxElEfvSsbs6wuKmgjeYRolkQAY3yWZACHMZMd27BsodaZwh8xwHNqDz3oyyfZPGSvvBGxehme6elysnWAwbpvbTxbc6Ts3FFU/MEKiA/uOGoUdHXHydB5GQCotz2Z64GW+Qs3Nq+v2BaJD8gGq2EkYvUd1REpOFpP3u4MaT2A5J9IAPqCHXDw0DbM64RzNQnc5+/nAZFmwrO2eST3TP31WXzw/9yMd6C0Dz0Jqy2xaPQqdE+DIwrB+a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:55:46 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 12:55:46 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Vlad Buslov <vladbu@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, ivecera
	<ivecera@redhat.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net-next 07/12] ice: Switchdev FDB events support
Thread-Topic: [PATCH net-next 07/12] ice: Switchdev FDB events support
Thread-Index: AQHZo5+eG0BtYUHE5UiaHhT0ZggmWK+WuSWAgAAPgxA=
Date: Thu, 22 Jun 2023 12:55:46 +0000
Message-ID: <MW4PR11MB577640F5292E101BE51FCE02FD22A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-8-anthony.l.nguyen@intel.com>
 <87edm3vh4k.fsf@nvidia.com>
In-Reply-To: <87edm3vh4k.fsf@nvidia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|PH0PR11MB4997:EE_
x-ms-office365-filtering-correlation-id: eeaeea65-ca2e-4181-77f6-08db731ffee6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsaM5NkkiiVqUMzIOjoEeA8UVLMHfl47qBA5rV/I6KRjcgi8qLFggC5qwh+POTpEz1k+AIrUXn//UV2CHVowZX0JjuPMiHD+VBUT3c+vUNL+aFxtEhgppIHlBqW89nGDBom5BqY555+aEsUnwvhdmug3YFZQjStmyyNN7+AoiWBP/N5oQq4VRja115qCzBglz3KORLDWGXtSmfUrBnaYrlsz8igv2oR0FGALqbUyGFxzl+NX4SimJMsd2awH4qEKFy5sKmFRaWttZkDkixziiN62bFI16K5WsbEtXyhh+8haAHpgu0Jr6fi8KXXvdHJIA+IL3ur5Kbg7uBo/vn8AHcpUDnk3Gozi2AsjlzxqngDYBD+x3qjCyDlLO8QbeT3ZuVzRiHtnhcCT7cVzorK1Ja6C8nDUastl//ve4wZcUoxlBpTc9kJFsSGUyEHuWiNqSJ2l67N0sO7CRRo9wqYbYqovYEFLX0nshpyxmB+ohxly/s0QuUakCFeZhF7YCs3hnrE5g1KYl0rRvgJZDCZ0KzRx+9fffuLep6pN99cNHAJ3waPiVWjP5B/wiAgijUuDQpPR47w1v+W+84nSk2OdoMcInD5q4ZS2ranthssJM3HDG7/bKlTYYE7YUCcpXsZ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(6636002)(4326008)(64756008)(66556008)(66476007)(66446008)(107886003)(54906003)(316002)(66899021)(82960400001)(76116006)(122000001)(66946007)(71200400001)(83380400001)(30864003)(52536014)(6506007)(53546011)(86362001)(2906002)(7696005)(5660300002)(8936002)(8676002)(9686003)(186003)(41300700001)(110136005)(478600001)(33656002)(55016003)(38100700002)(38070700005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aQy/dfoDlB+om0MPBpDznZmeWZYROPnS1qxUkb/k4EsEn/7FqEtnLD1bbxzF?=
 =?us-ascii?Q?3ISeVuPZeYBdsKIQ4JTD8ZM2pCF6zJSDmK8MJIx49aVZfNLsrbwJwGqPCj0N?=
 =?us-ascii?Q?VCqXrlAY308IEuuQQSoAXfWjCFi61jNbCQ9r3iL9gE7wqRfP5GzSNRASB0ih?=
 =?us-ascii?Q?XCwILEfWOo5QxQDzwKjCsAnXIuHMIcaa9j4lpCE9L7bPMX2ra5ish/9HfPwF?=
 =?us-ascii?Q?W9bpvshWOHuUoZuFDtZQmtcV7MOPvtkYGj119iTrMEVsyVXV2xZQ/BcizG5o?=
 =?us-ascii?Q?VAkd0fHG08EAYOwkHft4ljTEmqXqj80Zsob66do1TihRW7SxKELsLfPTI0GA?=
 =?us-ascii?Q?d9HBLT0URSZOx4LbZO7Z9Bob7g3H6qJjSo+qAtcGnKstRHXZByavWNWtKHpq?=
 =?us-ascii?Q?TlHnzEh0U+b3LPgzutvI2HTpiCZNkPVlsO0DHcmBjaGBvdFgh8+YDGjPJpT7?=
 =?us-ascii?Q?k6eQWHrXAE6IADhh0NcY45keCVukYqJIGgArxZZK+OHP6Yo6lm5AqCY0UR4a?=
 =?us-ascii?Q?wQ0aYnjiUVKD5hgsEMZBtFAsprlbJKagmmi0M4rmJNQP83LHM0u4IAu9WR5k?=
 =?us-ascii?Q?xY0ZQk7DZp8qlXPFNTfGalYyC6yag3HSGV3fTye3W693LJ2Od/eiEuakNSoe?=
 =?us-ascii?Q?h97m/p3i7tE/0nOLuXpwUVqPU80xAKnizet0Wl2yEtMpTC8v7dsuaAVVNCeJ?=
 =?us-ascii?Q?5OFfewg/OSK8A0/VQMea/qpk7Y5q8Z3GGgShlaNnSTKIVsgPXobJhEpyjZIj?=
 =?us-ascii?Q?7vdpdZ5bx1OJhxAWNhSoyR4smJBdU98mryGOn3KwRBKWDj63IwYi4MLvzhdf?=
 =?us-ascii?Q?h5dJm4Ls5kQMjX3qAyA181AeTfP+s86jYj2uVIa1z5FhcP6VGkIaKAlBqM+c?=
 =?us-ascii?Q?W4jRQUEIYGmXm426paEhSwlKk6Qr87ZGXScmjZdFljnAqyLklhL0FYoIroue?=
 =?us-ascii?Q?OM6XwUy+vLWa0owAG5WcTDuChB8cn7dGBSp1uycy78V/l5nODmtxTEVmbCze?=
 =?us-ascii?Q?71p457Tf2GRkMFjNBWwubHqWWHMZKiwebo6S8PgoPP352y17dLDXVbXbcTc2?=
 =?us-ascii?Q?ahQXSz6sbDmSw8nSeQEo7eHfysWO7zYOTq2RwFoyfAGIMlloIJkEXHwc+4TB?=
 =?us-ascii?Q?TwFDkzmF7/vVo/Jl4fwHB/GaTKjl0bRFxD6vTGTUtcJLVeAYsrhqE2+ZAOCk?=
 =?us-ascii?Q?kfFhi46vaXFrfiCjp7zI5sFu3F46s8b0XK0vf3w0Qo0bayX4HCGPMK8g5eEn?=
 =?us-ascii?Q?AalXwSvi2jaxqeivTEUDSC8AAFZoqGlYWVh91T9UYDgMWeqYn7UOCAYWvAN3?=
 =?us-ascii?Q?KveG8zeq+jaYh9+6D0onsrJ0BQrJjL1BhcAnigPtUGLJNkcU+XxDd/8WFDC1?=
 =?us-ascii?Q?cI7D/1gljAwGAbt1WS6F2523dTkoHTxBVMFIg3asp+ojfJNxIiZFj1Zgucvh?=
 =?us-ascii?Q?vypg3BI0n2e+gMdoTkfVpMRtPQyfhEabb5IyB6AzA5XmuRT7vDGqo9Az3uSb?=
 =?us-ascii?Q?EpvSDPmmvkRNcwnuuKKF46hvt38+O8oSs6ndz4OIrizWb7BZ165ccSMY4iWY?=
 =?us-ascii?Q?9VcoF87F2VUKArm1RtU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaeea65-ca2e-4181-77f6-08db731ffee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 12:55:46.0132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77ggR7XCCpD0sUQoHD/QrAC9ELDpcw3pMQREqfD9zGapeXjX0fwvaO6jT/7d6dZd7+/+J/B9mLi9PhgyMN+owt4pvKIfYkQtUX0NHewFdtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Vlad Buslov <vladbu@nvidia.com>
> Sent: czwartek, 22 czerwca 2023 13:54
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; edumazet@goo=
gle.com; netdev@vger.kernel.org; Drewek,
> Wojciech <wojciech.drewek@intel.com>; jiri@resnulli.us; ivecera <ivecera@=
redhat.com>; simon.horman@corigine.com;
> Buvaneswaran, Sujai <sujai.buvaneswaran@intel.com>
> Subject: Re: [PATCH net-next 07/12] ice: Switchdev FDB events support
>=20
> On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wro=
te:
> > From: Wojciech Drewek <wojciech.drewek@intel.com>
> >
> > Listen for SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events while in switchdev
> > mode. Accept these events on both uplink and VF PR ports. Add HW
> > rules in newly created workqueue. FDB entries are stored in rhashtable
> > for lookup when removing the entry and in the list for cleanup
> > purpose. Direction of the HW rule depends on the type of the ports
> > on which the FDB event was received:
> >
> > ICE_ESWITCH_BR_UPLINK_PORT:
> > TX rule that forwards the packet to the LAN (egress).
> >
> > ICE_ESWITCH_BR_VF_REPR_PORT:
> > RX rule that forwards the packet to the VF associated
> > with the port representor.
>=20
> Just to clarify, does this implementation support offloading of VF-to-VF
> traffic?

Yes

>=20
> >
> > In both cases the rule matches on the dst mac address.
> > All the FDB entries are stored in the bridge structure.
> > When the port is removed all the FDB entries associated with
> > this port are removed as well. This is achieved thanks to the reference
> > to the port that FDB entry holds.
> >
> > In the fwd rule we use only one lookup type (MAC address)
> > but lkups_cnt variable is already introduced because
> > we will have more lookups in the subsequent patches.
> >
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 439 +++++++++++++++++-
> >  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  46 ++
> >  2 files changed, 484 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.c
> > index 8b9ab68dfd53..8f22da490a69 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > @@ -4,6 +4,14 @@
> >  #include "ice.h"
> >  #include "ice_eswitch_br.h"
> >  #include "ice_repr.h"
> > +#include "ice_switch.h"
> > +
> > +static const struct rhashtable_params ice_fdb_ht_params =3D {
> > +	.key_offset =3D offsetof(struct ice_esw_br_fdb_entry, data),
> > +	.key_len =3D sizeof(struct ice_esw_br_fdb_data),
> > +	.head_offset =3D offsetof(struct ice_esw_br_fdb_entry, ht_node),
> > +	.automatic_shrinking =3D true,
> > +};
> >
> >  static bool ice_eswitch_br_is_dev_valid(const struct net_device *dev)
> >  {
> > @@ -27,15 +35,412 @@ ice_eswitch_br_netdev_to_port(struct net_device *d=
ev)
> >  	return NULL;
> >  }
> >
> > +static void
> > +ice_eswitch_br_ingress_rule_setup(struct ice_adv_rule_info *rule_info,
> > +				  u8 pf_id, u16 vf_vsi_idx)
> > +{
> > +	rule_info->sw_act.vsi_handle =3D vf_vsi_idx;
> > +	rule_info->sw_act.flag |=3D ICE_FLTR_RX;
> > +	rule_info->sw_act.src =3D pf_id;
> > +	rule_info->priority =3D 5;
> > +}
> > +
> > +static void
> > +ice_eswitch_br_egress_rule_setup(struct ice_adv_rule_info *rule_info,
> > +				 u16 pf_vsi_idx)
> > +{
> > +	rule_info->sw_act.vsi_handle =3D pf_vsi_idx;
> > +	rule_info->sw_act.flag |=3D ICE_FLTR_TX;
> > +	rule_info->flags_info.act =3D ICE_SINGLE_ACT_LAN_ENABLE;
> > +	rule_info->flags_info.act_valid =3D true;
> > +	rule_info->priority =3D 5;
> > +}
> > +
> > +static int
> > +ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_da=
ta *rule)
> > +{
> > +	int err;
> > +
> > +	if (!rule)
> > +		return -EINVAL;
> > +
> > +	err =3D ice_rem_adv_rule_by_id(hw, rule);
> > +	kfree(rule);
> > +
> > +	return err;
> > +}
> > +
> > +static struct ice_rule_query_data *
> > +ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int por=
t_type,
> > +			       const unsigned char *mac)
> > +{
> > +	struct ice_adv_rule_info rule_info =3D { 0 };
> > +	struct ice_rule_query_data *rule;
> > +	struct ice_adv_lkup_elem *list;
> > +	u16 lkups_cnt =3D 1;
> > +	int err;
> > +
> > +	rule =3D kzalloc(sizeof(*rule), GFP_KERNEL);
> > +	if (!rule)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	list =3D kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
> > +	if (!list) {
> > +		err =3D -ENOMEM;
> > +		goto err_list_alloc;
> > +	}
> > +
> > +	switch (port_type) {
> > +	case ICE_ESWITCH_BR_UPLINK_PORT:
> > +		ice_eswitch_br_egress_rule_setup(&rule_info, vsi_idx);
> > +		break;
> > +	case ICE_ESWITCH_BR_VF_REPR_PORT:
> > +		ice_eswitch_br_ingress_rule_setup(&rule_info, hw->pf_id,
> > +						  vsi_idx);
> > +		break;
> > +	default:
> > +		err =3D -EINVAL;
> > +		goto err_add_rule;
> > +	}
> > +
> > +	list[0].type =3D ICE_MAC_OFOS;
> > +	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
> > +	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
> > +
> > +	rule_info.sw_act.fltr_act =3D ICE_FWD_TO_VSI;
> > +
> > +	err =3D ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, rule);
> > +	if (err)
> > +		goto err_add_rule;
> > +
> > +	kfree(list);
> > +
> > +	return rule;
> > +
> > +err_add_rule:
> > +	kfree(list);
> > +err_list_alloc:
> > +	kfree(rule);
> > +
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static struct ice_esw_br_flow *
> > +ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int =
vsi_idx,
> > +			   int port_type, const unsigned char *mac)
> > +{
> > +	struct ice_rule_query_data *fwd_rule;
> > +	struct ice_esw_br_flow *flow;
> > +	int err;
> > +
> > +	flow =3D kzalloc(sizeof(*flow), GFP_KERNEL);
> > +	if (!flow)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	fwd_rule =3D ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, m=
ac);
> > +	err =3D PTR_ERR_OR_ZERO(fwd_rule);
> > +	if (err) {
> > +		dev_err(dev, "Failed to create eswitch bridge %sgress forward rule, =
err: %d\n",
> > +			port_type =3D=3D ICE_ESWITCH_BR_UPLINK_PORT ? "e" : "in",
> > +			err);
> > +		goto err_fwd_rule;
> > +	}
> > +
> > +	flow->fwd_rule =3D fwd_rule;
> > +
> > +	return flow;
> > +
> > +err_fwd_rule:
> > +	kfree(flow);
> > +
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static struct ice_esw_br_fdb_entry *
> > +ice_eswitch_br_fdb_find(struct ice_esw_br *bridge, const unsigned char=
 *mac,
> > +			u16 vid)
> > +{
> > +	struct ice_esw_br_fdb_data data =3D {
> > +		.vid =3D vid,
> > +	};
> > +
> > +	ether_addr_copy(data.addr, mac);
> > +	return rhashtable_lookup_fast(&bridge->fdb_ht, &data,
> > +				      ice_fdb_ht_params);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_flow_delete(struct ice_pf *pf, struct ice_esw_br_flow *=
flow)
> > +{
> > +	struct device *dev =3D ice_pf_to_dev(pf);
> > +	int err;
> > +
> > +	err =3D ice_eswitch_br_rule_delete(&pf->hw, flow->fwd_rule);
> > +	if (err)
> > +		dev_err(dev, "Failed to delete FDB forward rule, err: %d\n",
> > +			err);
> > +
> > +	kfree(flow);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_entry_delete(struct ice_esw_br *bridge,
> > +				struct ice_esw_br_fdb_entry *fdb_entry)
> > +{
> > +	struct ice_pf *pf =3D bridge->br_offloads->pf;
> > +
> > +	rhashtable_remove_fast(&bridge->fdb_ht, &fdb_entry->ht_node,
> > +			       ice_fdb_ht_params);
> > +	list_del(&fdb_entry->list);
> > +
> > +	ice_eswitch_br_flow_delete(pf, fdb_entry->flow);
> > +
> > +	kfree(fdb_entry);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_offload_notify(struct net_device *dev,
> > +				  const unsigned char *mac, u16 vid,
> > +				  unsigned long val)
> > +{
> > +	struct switchdev_notifier_fdb_info fdb_info =3D {
> > +		.addr =3D mac,
> > +		.vid =3D vid,
> > +		.offloaded =3D true,
> > +	};
> > +
> > +	call_switchdev_notifiers(val, dev, &fdb_info.info, NULL);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_entry_notify_and_cleanup(struct ice_esw_br *bridge,
> > +					    struct ice_esw_br_fdb_entry *entry)
> > +{
> > +	if (!(entry->flags & ICE_ESWITCH_BR_FDB_ADDED_BY_USER))
> > +		ice_eswitch_br_fdb_offload_notify(entry->dev, entry->data.addr,
> > +						  entry->data.vid,
> > +						  SWITCHDEV_FDB_DEL_TO_BRIDGE);
> > +	ice_eswitch_br_fdb_entry_delete(bridge, entry);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_entry_find_and_delete(struct ice_esw_br *bridge,
> > +					 const unsigned char *mac, u16 vid)
> > +{
> > +	struct ice_pf *pf =3D bridge->br_offloads->pf;
> > +	struct ice_esw_br_fdb_entry *fdb_entry;
> > +	struct device *dev =3D ice_pf_to_dev(pf);
> > +
> > +	fdb_entry =3D ice_eswitch_br_fdb_find(bridge, mac, vid);
> > +	if (!fdb_entry) {
> > +		dev_err(dev, "FDB entry with mac: %pM and vid: %u not found\n",
> > +			mac, vid);
> > +		return;
> > +	}
> > +
> > +	ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
> > +				struct ice_esw_br_port *br_port,
> > +				bool added_by_user,
> > +				const unsigned char *mac, u16 vid)
> > +{
> > +	struct ice_esw_br *bridge =3D br_port->bridge;
> > +	struct ice_pf *pf =3D bridge->br_offloads->pf;
> > +	struct device *dev =3D ice_pf_to_dev(pf);
> > +	struct ice_esw_br_fdb_entry *fdb_entry;
> > +	struct ice_esw_br_flow *flow;
> > +	struct ice_hw *hw =3D &pf->hw;
> > +	unsigned long event;
> > +	int err;
> > +
> > +	fdb_entry =3D ice_eswitch_br_fdb_find(bridge, mac, vid);
> > +	if (fdb_entry)
> > +		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> > +
> > +	fdb_entry =3D kzalloc(sizeof(*fdb_entry), GFP_KERNEL);
> > +	if (!fdb_entry) {
> > +		err =3D -ENOMEM;
> > +		goto err_exit;
> > +	}
> > +
> > +	flow =3D ice_eswitch_br_flow_create(dev, hw, br_port->vsi_idx,
> > +					  br_port->type, mac);
> > +	if (IS_ERR(flow)) {
> > +		err =3D PTR_ERR(flow);
> > +		goto err_add_flow;
> > +	}
> > +
> > +	ether_addr_copy(fdb_entry->data.addr, mac);
> > +	fdb_entry->data.vid =3D vid;
> > +	fdb_entry->br_port =3D br_port;
> > +	fdb_entry->flow =3D flow;
> > +	fdb_entry->dev =3D netdev;
> > +	event =3D SWITCHDEV_FDB_ADD_TO_BRIDGE;
> > +
> > +	if (added_by_user) {
> > +		fdb_entry->flags |=3D ICE_ESWITCH_BR_FDB_ADDED_BY_USER;
> > +		event =3D SWITCHDEV_FDB_OFFLOADED;
> > +	}
> > +
> > +	err =3D rhashtable_insert_fast(&bridge->fdb_ht, &fdb_entry->ht_node,
> > +				     ice_fdb_ht_params);
> > +	if (err)
> > +		goto err_fdb_insert;
> > +
> > +	list_add(&fdb_entry->list, &bridge->fdb_list);
> > +
> > +	ice_eswitch_br_fdb_offload_notify(netdev, mac, vid, event);
> > +
> > +	return;
> > +
> > +err_fdb_insert:
> > +	ice_eswitch_br_flow_delete(pf, flow);
> > +err_add_flow:
> > +	kfree(fdb_entry);
> > +err_exit:
> > +	dev_err(dev, "Failed to create fdb entry, err: %d\n", err);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_work_dealloc(struct ice_esw_br_fdb_work *fdb_work)
> > +{
> > +	kfree(fdb_work->fdb_info.addr);
> > +	kfree(fdb_work);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_fdb_event_work(struct work_struct *work)
> > +{
> > +	struct ice_esw_br_fdb_work *fdb_work =3D ice_work_to_fdb_work(work);
> > +	bool added_by_user =3D fdb_work->fdb_info.added_by_user;
> > +	struct ice_esw_br_port *br_port =3D fdb_work->br_port;
> > +	const unsigned char *mac =3D fdb_work->fdb_info.addr;
> > +	u16 vid =3D fdb_work->fdb_info.vid;
> > +
> > +	rtnl_lock();
> > +
> > +	if (!br_port || !br_port->bridge)
> > +		goto err_exit;
> > +
> > +	switch (fdb_work->event) {
> > +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> > +		ice_eswitch_br_fdb_entry_create(fdb_work->dev, br_port,
> > +						added_by_user, mac, vid);
> > +		break;
> > +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> > +		ice_eswitch_br_fdb_entry_find_and_delete(br_port->bridge,
> > +							 mac, vid);
> > +		break;
> > +	default:
> > +		goto err_exit;
> > +	}
> > +
> > +err_exit:
> > +	rtnl_unlock();
> > +	dev_put(fdb_work->dev);
> > +	ice_eswitch_br_fdb_work_dealloc(fdb_work);
> > +}
> > +
> > +static struct ice_esw_br_fdb_work *
> > +ice_eswitch_br_fdb_work_alloc(struct switchdev_notifier_fdb_info *fdb_=
info,
> > +			      struct ice_esw_br_port *br_port,
> > +			      struct net_device *dev,
> > +			      unsigned long event)
> > +{
> > +	struct ice_esw_br_fdb_work *work;
> > +	unsigned char *mac;
> > +
> > +	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
> > +	if (!work)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	INIT_WORK(&work->work, ice_eswitch_br_fdb_event_work);
> > +	memcpy(&work->fdb_info, fdb_info, sizeof(work->fdb_info));
> > +
> > +	mac =3D kzalloc(ETH_ALEN, GFP_ATOMIC);
> > +	if (!mac) {
> > +		kfree(work);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	ether_addr_copy(mac, fdb_info->addr);
> > +	work->fdb_info.addr =3D mac;
> > +	work->br_port =3D br_port;
> > +	work->event =3D event;
> > +	work->dev =3D dev;
> > +
> > +	return work;
> > +}
> > +
> > +static int
> > +ice_eswitch_br_switchdev_event(struct notifier_block *nb,
> > +			       unsigned long event, void *ptr)
> > +{
> > +	struct net_device *dev =3D switchdev_notifier_info_to_dev(ptr);
> > +	struct switchdev_notifier_fdb_info *fdb_info;
> > +	struct switchdev_notifier_info *info =3D ptr;
> > +	struct ice_esw_br_offloads *br_offloads;
> > +	struct ice_esw_br_fdb_work *work;
> > +	struct ice_esw_br_port *br_port;
> > +	struct netlink_ext_ack *extack;
> > +	struct net_device *upper;
> > +
> > +	br_offloads =3D ice_nb_to_br_offloads(nb, switchdev_nb);
> > +	extack =3D switchdev_notifier_info_to_extack(ptr);
> > +
> > +	upper =3D netdev_master_upper_dev_get_rcu(dev);
> > +	if (!upper)
> > +		return NOTIFY_DONE;
> > +
> > +	if (!netif_is_bridge_master(upper))
> > +		return NOTIFY_DONE;
> > +
> > +	if (!ice_eswitch_br_is_dev_valid(dev))
> > +		return NOTIFY_DONE;
> > +
> > +	br_port =3D ice_eswitch_br_netdev_to_port(dev);
> > +	if (!br_port)
> > +		return NOTIFY_DONE;
> > +
> > +	switch (event) {
> > +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> > +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> > +		fdb_info =3D container_of(info, typeof(*fdb_info), info);
> > +
> > +		work =3D ice_eswitch_br_fdb_work_alloc(fdb_info, br_port, dev,
> > +						     event);
> > +		if (IS_ERR(work)) {
> > +			NL_SET_ERR_MSG_MOD(extack, "Failed to init switchdev fdb work");
> > +			return notifier_from_errno(PTR_ERR(work));
> > +		}
> > +		dev_hold(dev);
> > +
> > +		queue_work(br_offloads->wq, &work->work);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return NOTIFY_DONE;
> > +}
> > +
> >  static void
> >  ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
> >  			   struct ice_esw_br_port *br_port)
> >  {
> > +	struct ice_esw_br_fdb_entry *fdb_entry, *tmp;
> >  	struct ice_vsi *vsi =3D br_port->vsi;
> >
> > +	list_for_each_entry_safe(fdb_entry, tmp, &bridge->fdb_list, list) {
> > +		if (br_port =3D=3D fdb_entry->br_port)
> > +			ice_eswitch_br_fdb_entry_delete(bridge, fdb_entry);
> > +	}
> > +
> >  	if (br_port->type =3D=3D ICE_ESWITCH_BR_UPLINK_PORT && vsi->back)
> >  		vsi->back->br_port =3D NULL;
> > -	else if (vsi->vf)
> > +	else if (vsi->vf && vsi->vf->repr)
>=20
> Shouldn't this check be in the previous patch? Don't see anything that
> would influence this pointer assignment in this patch.

Yes, you're right. Small fix was squashed into wrong patch.

>=20
> >  		vsi->vf->repr->br_port =3D NULL;
> >
> >  	xa_erase(&bridge->ports, br_port->vsi_idx);
> > @@ -129,6 +534,8 @@ ice_eswitch_br_deinit(struct ice_esw_br_offloads *b=
r_offloads,
> >  	ice_eswitch_br_ports_flush(bridge);
> >  	WARN_ON(!xa_empty(&bridge->ports));
> >  	xa_destroy(&bridge->ports);
> > +	rhashtable_destroy(&bridge->fdb_ht);
> > +
> >  	br_offloads->bridge =3D NULL;
> >  	kfree(bridge);
> >  }
> > @@ -137,11 +544,19 @@ static struct ice_esw_br *
> >  ice_eswitch_br_init(struct ice_esw_br_offloads *br_offloads, int ifind=
ex)
> >  {
> >  	struct ice_esw_br *bridge;
> > +	int err;
> >
> >  	bridge =3D kzalloc(sizeof(*bridge), GFP_KERNEL);
> >  	if (!bridge)
> >  		return ERR_PTR(-ENOMEM);
> >
> > +	err =3D rhashtable_init(&bridge->fdb_ht, &ice_fdb_ht_params);
> > +	if (err) {
> > +		kfree(bridge);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	INIT_LIST_HEAD(&bridge->fdb_list);
> >  	bridge->br_offloads =3D br_offloads;
> >  	bridge->ifindex =3D ifindex;
> >  	xa_init(&bridge->ports);
> > @@ -340,6 +755,8 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
> >  		return;
> >
> >  	unregister_netdevice_notifier(&br_offloads->netdev_nb);
> > +	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> > +	destroy_workqueue(br_offloads->wq);
> >  	/* Although notifier block is unregistered just before,
> >  	 * so we don't get any new events, some events might be
> >  	 * already in progress. Hold the rtnl lock and wait for
> > @@ -365,6 +782,22 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
> >  		return PTR_ERR(br_offloads);
> >  	}
> >
> > +	br_offloads->wq =3D alloc_ordered_workqueue("ice_bridge_wq", 0);
> > +	if (!br_offloads->wq) {
> > +		err =3D -ENOMEM;
> > +		dev_err(dev, "Failed to allocate bridge workqueue\n");
> > +		goto err_alloc_wq;
> > +	}
> > +
> > +	br_offloads->switchdev_nb.notifier_call =3D
> > +		ice_eswitch_br_switchdev_event;
> > +	err =3D register_switchdev_notifier(&br_offloads->switchdev_nb);
> > +	if (err) {
> > +		dev_err(dev,
> > +			"Failed to register switchdev notifier\n");
> > +		goto err_reg_switchdev_nb;
> > +	}
> > +
> >  	br_offloads->netdev_nb.notifier_call =3D ice_eswitch_br_port_event;
> >  	err =3D register_netdevice_notifier(&br_offloads->netdev_nb);
> >  	if (err) {
> > @@ -376,6 +809,10 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
> >  	return 0;
> >
> >  err_reg_netdev_nb:
> > +	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> > +err_reg_switchdev_nb:
> > +	destroy_workqueue(br_offloads->wq);
> > +err_alloc_wq:
> >  	rtnl_lock();
> >  	ice_eswitch_br_offloads_dealloc(pf);
> >  	rtnl_unlock();
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.h
> > index 3ad28a17298f..6fcacf545b98 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > @@ -4,6 +4,33 @@
> >  #ifndef _ICE_ESWITCH_BR_H_
> >  #define _ICE_ESWITCH_BR_H_
> >
> > +#include <linux/rhashtable.h>
> > +
> > +struct ice_esw_br_fdb_data {
> > +	unsigned char addr[ETH_ALEN];
> > +	u16 vid;
> > +};
> > +
> > +struct ice_esw_br_flow {
> > +	struct ice_rule_query_data *fwd_rule;
> > +};
> > +
> > +enum {
> > +	ICE_ESWITCH_BR_FDB_ADDED_BY_USER =3D BIT(0),
> > +};
> > +
> > +struct ice_esw_br_fdb_entry {
> > +	struct ice_esw_br_fdb_data data;
> > +	struct rhash_head ht_node;
> > +	struct list_head list;
> > +
> > +	int flags;
> > +
> > +	struct net_device *dev;
> > +	struct ice_esw_br_port *br_port;
> > +	struct ice_esw_br_flow *flow;
> > +};
> > +
> >  enum ice_esw_br_port_type {
> >  	ICE_ESWITCH_BR_UPLINK_PORT =3D 0,
> >  	ICE_ESWITCH_BR_VF_REPR_PORT =3D 1,
> > @@ -20,6 +47,9 @@ struct ice_esw_br {
> >  	struct ice_esw_br_offloads *br_offloads;
> >  	struct xarray ports;
> >
> > +	struct rhashtable fdb_ht;
> > +	struct list_head fdb_list;
> > +
> >  	int ifindex;
> >  };
> >
> > @@ -27,6 +57,17 @@ struct ice_esw_br_offloads {
> >  	struct ice_pf *pf;
> >  	struct ice_esw_br *bridge;
> >  	struct notifier_block netdev_nb;
> > +	struct notifier_block switchdev_nb;
> > +
> > +	struct workqueue_struct *wq;
> > +};
> > +
> > +struct ice_esw_br_fdb_work {
> > +	struct work_struct work;
> > +	struct switchdev_notifier_fdb_info fdb_info;
> > +	struct ice_esw_br_port *br_port;
> > +	struct net_device *dev;
> > +	unsigned long event;
> >  };
> >
> >  #define ice_nb_to_br_offloads(nb, nb_name) \
> > @@ -34,6 +75,11 @@ struct ice_esw_br_offloads {
> >  		     struct ice_esw_br_offloads, \
> >  		     nb_name)
> >
> > +#define ice_work_to_fdb_work(w) \
> > +	container_of(w, \
> > +		     struct ice_esw_br_fdb_work, \
> > +		     work)
> > +
> >  void
> >  ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
> >  int


