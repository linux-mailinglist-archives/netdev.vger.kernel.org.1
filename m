Return-Path: <netdev+bounces-20105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916275DA6F
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B221C2172E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD711CA5;
	Sat, 22 Jul 2023 06:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30111C9D
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:48:59 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4476C270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008538; x=1721544538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzz1IW+99UQWzRu5+YSoxgfiuhQKsTCbap6i39+YQ6s=;
  b=gI48MTY/w78eVGg3R9JgoVj7p0Gnp5PD4E96W0tZK3OGpgzFjGsGLVOk
   2A/3exASWx05GZjH+EMhuhXB0fcYlwgYtPlElWQp6vMDD4zQq0qHD4cra
   ngMpwHJ2RxWVv8pqR3z7y41Bx8WaXEe8rltZPEFwRgh+axaProukmQTup
   wLbrx9aZ8N1vNk3/U+YLIaSF51jXuYr/w1fKJ452rqaJo/7W195bquoW9
   rj6IusURfDEjqscqol+AOj/sPJhn6E2rHsB/XPwmmePjxjfl/eFbkkZHr
   no9miB58likctSen3UtjhZk/CUX6bDagvLJKvaQzgzXINaojx+X9kvJQw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346772045"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="346772045"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055813653"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="1055813653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 23:48:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:48:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA8LOgJrAYRBX4RO/qhZGkLRQUY66PN+wYQQnqPfgpzVg7cBC8mAQd4qALollp+fYtKs+nFoDQeydTvHElTkZa5y93R738FHv5DZeNVa5m/TmkwZCzl310CyucguHbBo3ZYu4DsGF8qzmmCi224tHPwgimZAhWy5uzsJYNeBwFXhFew/Nxww1Te4FSd4gG97YBX4TCSSGI5YQ6NVFzc7uSAcHm2jvriNoT5dHqt66GkLFEEsJBfstmHQjsmlJWyC5G+I3AjWlCjHOIFd/BQHbRzEaEgydpqnOTXfOt3KOx9o4EDH5C7hCq40R4m0sAEye87BITwTD/EUk4UYxjJmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KyGUIaqCniF59QnUc0TUYnHLcI5MNARmRG0QrVsk2A=;
 b=HhwLcUMs4ZArwzPbxOnxDJXsZPUG7YA2R6QfuXWB07kM0pvTSDFdhvjN62hV8+cZ9wYQ3iwH3dKmE5t4C0nWL1RXPGwhOLOp0pnaRBihGDDlDY86koPPbzwKuA35d1E998CLI+Tq98g5ITfZzGkD+hFmtPnDKkrmkQiWpSYX3FJLqXwgfhyBBkXtaunn7UzKvywLn8oX4iLo1hDmkYpN4QmqBpm7LwdR4S5VzsE0tp8JwEEDAWxWmAfKcoxrZ7YokCmrqkfDq6nqD1WQiPmbnSYnq//z77XjxqLTblxJva4B1ZoFOm67iuhYgFLM28QTqeTmO2hy4erF3rhCx1v9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:48:50 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:48:50 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 08/12] ice: Add guard rule
 when creating FDB in switchdev
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 08/12] ice: Add guard rule
 when creating FDB in switchdev
Thread-Index: AQHZtLEJlzlYYAGPKUaM8Qmbp0q9+q/FZ6qw
Date: Sat, 22 Jul 2023 06:48:50 +0000
Message-ID: <PH0PR11MB5013FAE33C0494C671343647963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-9-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-9-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 34b839a2-c905-4ff4-f941-08db8a7fb4c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKwAGUeD4JUk4Lapa/rThOqFzuExTRIrbuXKH3QKzJ4Mq4q+QqFc3Gee2jBfND1JwA3cS5M0AEPN2nHcWCp6rE2EFO2J5B/QVrIrevXgZLDLQvGmxLQb42u4SwAaKYtS4jo96g0gwt93thx0/20NHH/B2abWQj/jzJE1F+uPrcfc0CL818wM/6MvBic0fjDTPPKiV6yV6/4JrlE5Ud7zlzVWPVsowBcR5VWw+WjDdfze/ybjqkWupgebwjrC+XRIibPTUAhbhiRaJ2OLlWBul5PZ3kfyAWKVb2hc4WhDyYHpaR65eRTxwmtpP9pBJPM614ymuZWwYiyopl2ED+I/f3qkRnEd7i5X7qInJw7g7M9yB3SX7lUKJb3rWPXihFeM364Hq61dzW02Ll5w1ovh+KaWEEZPLju+12PxFGCcFpabplMrIFeqH2UMCRkzooMfSaJpzHWsohRnvhpRGikO9G2Slxx//qCOcoSSBLcTvOfSmvhW3nkWD8ulk6+IDGF5e1bGWFOnLHe8I6bkCdlgNGPEIzDVYBT6i4rIfaUMeUVvB++XxIQyqBvx7OFBmk4ydKuvkrl7hApIXA1+AfvJZt9cXwm5T0cIheKY+NztZDc/3+BTqPkizS7PUnPmG8+y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i36xDd8AFlLbcgA7jYLdqjTRXQGo8IzXTmoVoZYgCxmij2OfyTIMgb4Gq7C7?=
 =?us-ascii?Q?4QkqA793B6K7+4ZW6ik1vlolo/vnPJSVLzsyMjT5yezQWxpQQSjKpS1n1OY8?=
 =?us-ascii?Q?ag6s8XIFSoX4BWjRNHUqLyLMKezxnNFfXD3CVQADFvPfBeDloVtRyrRT5/1q?=
 =?us-ascii?Q?75Rn2aoU+M6xS7Nz70hze0N7ATEzUQPWAxZHExUic7OggWNm2yjXsfnkLvEC?=
 =?us-ascii?Q?FU3APDM42+WBe/B1jQ9PmrKwOYliqYkyXAetKxckfIs9+bUbRS0eZdr1d3/O?=
 =?us-ascii?Q?PS2b3qKRIjOO7zUHhq9QxTdfXYTVKTSwn7IQOD7H3Tv4MxcSCbCYUSJILLCm?=
 =?us-ascii?Q?ek/K3R2Cs1gPyTDmirnABiLyhznCTZW9iagl1EY08uTKUQu3SgOAj96mgtOe?=
 =?us-ascii?Q?0aKtt8Z0toyxy10uEVny10gwxsHoCq74ChRtNhBDy+JXHYlSGk0Ow+I5fcEK?=
 =?us-ascii?Q?Ju3/+fSc9MCW1phn0nQLKrovtjjxi5h6qjp8hof/9ruT/Mc+nK08g+/T18Qa?=
 =?us-ascii?Q?RNNk4ux/y2XPXgKGlWBUZx/Vl1B+yeyGXqhTHeM+co7ZsqYVV2C5yHrBZcmo?=
 =?us-ascii?Q?AN4l0CrkDxxSr0IbsXXXD/oJs/UiEf2SwTXNM2ipIOjcR99E2bPpran5xDhE?=
 =?us-ascii?Q?q/zeoBWkWbJLVWDqHnCKHf9pDBY9PX9/2knMQfFrW97edVCpqo3UxYYodADf?=
 =?us-ascii?Q?ePVdJzyh4ZepseRCf0ONNOfU/VLNH2pi9R3IjHx4r7qj/IAWicU4iqYnB5U6?=
 =?us-ascii?Q?/tJibXg29Usvw5mtJ2syisFZfH4MeKF028Kh0+/IrVQIVI+cgoMv8+PotvG3?=
 =?us-ascii?Q?kYhgu5k8TXJUayEm12lLQrxvWwbL7yadzkwjMJC2Tji13zW3XxTAtQQW+Azu?=
 =?us-ascii?Q?tX0qL+QB+NTs7vm3ConJ36IJBdbbYHQO5EHDCEGKU2/4XZf42yoD6U37/rV6?=
 =?us-ascii?Q?OKOrWqDqd/FlzOZzPaGuF9Jn0bmayqNmjqYRgYWspJoTqwi2jFeEMYaGnghJ?=
 =?us-ascii?Q?r/IoQCAxRp5fmb2M67uSRZ/z57sEHwTBFrOvbujB81jhdE15cEZJeGo2eBOX?=
 =?us-ascii?Q?LlAvWjmyuGzOjvHzqiU84Qg5rauyecWAYO5+yWEOzKJr3TuH1y98r6QgTjk1?=
 =?us-ascii?Q?z2Dnm9WK/BiTIDU6Q7YkSR+kkSTAxGcB0Sjf1TKu8JhAg2KFf1gj5USQSoR7?=
 =?us-ascii?Q?9Xm8nreCsJM4MX26/cJAw/1A2bs3+zh9X+G3v5s0wnfgVI0FD4ln16BibUW8?=
 =?us-ascii?Q?FoaJ1rvfSzJnHzGBoiuB09gYbBO50DLJtzguVDpeW8yLhfP6IsmbsEwU8BRu?=
 =?us-ascii?Q?yvMnXO6muaWS10VdC0NlZTZnOen0yzpQpPq0QXi1FIKWe98UvuLaM5PraaXx?=
 =?us-ascii?Q?FHqEvD48p6V16aKlnJ+LJ9EODCZ1Kyn6mpZWlFOVZXa0p8yYbHgXuhVsgFGQ?=
 =?us-ascii?Q?9Y0OkgjUMRvm2HSvV1mf7RG34++HqY+phQCl+IoRyPlShO3NM4UCIXeJ327G?=
 =?us-ascii?Q?/CgVsjAJ/KyutYMqL4TTw+12/iSwcchtGDg2rLyDHUF5QgLR4p61JCPD8Zah?=
 =?us-ascii?Q?n/O3JXKQ3WqUsn9c0hzz+mbIxYEmDJH77kZqZ2Vczsw6+Zrl5P3K4/IACaFL?=
 =?us-ascii?Q?FQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b839a2-c905-4ff4-f941-08db8a7fb4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:48:50.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shLg194W07MetD3lo1SB/921XXi+079gxPFzoIF12F5SSpqltCQ9ZOyUJAdY08PPzLfDGYLZExkWXd+btzVdSwk3MJqhH5VH7zbzwimsC+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 08/12] ice: Add guard rule =
when
> creating FDB in switchdev
>=20
> From: Marcin Szycik <marcin.szycik@intel.com>
>=20
> Introduce new "guard" rule upon FDB entry creation.
>=20
> It matches on src_mac, has valid bit unset, allow_pass_l2 set and has a n=
op
> action.
>=20
> Previously introduced "forward" rule matches on dst_mac, has valid bit se=
t,
> need_pass_l2 set and has a forward action.
>=20
> With these rules, a packet will be offloaded only if FDB exists in both
> directions (RX and TX).
>=20
> Let's assume link partner sends a packet to VF1: src_mac =3D LP_MAC, dst_=
mac
> =3D is VF1_MAC. Bridge adds FDB, two rules are created:
> 1. Guard rule matching on src_mac =3D=3D LP_MAC 2. Forward rule matching =
on
> dst_mac =3D=3D LP_MAC Now VF1 responds with src_mac =3D VF1_MAC, dst_mac =
=3D
> LP_MAC. Before this change, only one rule with dst_mac =3D=3D LP_MAC woul=
d
> have existed, and the packet would have been offloaded, meaning the bridg=
e
> wouldn't add FDB in the opposite direction. Now, the forward rule matches
> (dst_mac =3D=3D LP_MAC), but it has need_pass_l2 set an there is no guard=
 rule
> with src_mac =3D=3D VF1_MAC, so the packet goes through slow-path and the
> bridge adds FDB. Two rules are created:
> 1. Guard rule matching on src_mac =3D=3D VF1_MAC 2. Forward rule matching=
 on
> dst_mac =3D=3D VF1_MAC Further packets in both directions will be offload=
ed.
>=20
> The same example is true in opposite direction (i.e. VF1 is the first to =
send a
> packet out).
>=20
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: init err with -ENOMEM in ice_eswitch_br_guard_rule_create,
>     use FIELD_PREP in ice_add_adv_rule, use @content var in
>     ice_add_sw_recipe
> v3: fix kdoc for ice_find_recp
> v5: free @list var in ice_eswitch_br_guard_rule_create on
>     successful path
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 64 +++++++++++-
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 97 ++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_switch.h   |  5 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
>  5 files changed, 132 insertions(+), 36 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

