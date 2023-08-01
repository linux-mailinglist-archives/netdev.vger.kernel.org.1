Return-Path: <netdev+bounces-23073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583076A9EE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C01C20DA3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194F6AB1;
	Tue,  1 Aug 2023 07:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3CF321E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:27:22 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53667127
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690874841; x=1722410841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+fbOTpYF+s0wyxeSzIZzS2vyuVuabS+u/hvVFzNfa9k=;
  b=ZhTf6IPnyDBDCE6c4Ny90V29EyfFvu9ormFhOuacsKqZ3LlBcTu+fiBS
   MVJxyOGpgpHZhl63wBoF5l2veROOUI6eYPSecKXyEF5EevhI2DqienFsv
   2g2KtG1QD2A34f6/dk3LrkEr7+32q5XAoJCdbkiHao/pV+HV8tBJ64lZ1
   8t5ajZhKQqoBOyvfzVudpnNh17k6O4RvB/FywX4wKgvdAkPdxSVaQ4viI
   CWhLO4W381fnro2Tci2DbPrhME08kxBaQz+jUl+52c+NWkZIL7I8SouWQ
   IAyQ+blp5MZfyPZpOjzSDAOZkkfYaFIJZcha+EKdE1yGZjn1nHF84eq4P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371933704"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="371933704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 00:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="722384831"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="722384831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 00:27:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 00:27:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 00:27:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 00:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrtHf3g5rdI1oUYOyh+VjAvTC2RSLcFV97joAIuIGBSkFqEYQC0p9i1/wWkp9mjB4GXNrTrt9x/ehKBLb+dylycGIsrQnSceD9O8F+Md6yZdPiG6NLdQpTFf5eD1+byjEvjEVYjogYjbbOaXzN9hJjc+AOAKHTRJ5xQoZV0r7UsiTiYvks8/9xC6ku/PNS/f+HGvF7aNb07VGYftp5KSFi0voHvJ3E93xcT7YaJDhcmtBffQ47cYJQHLFHe4Uk1fx2GEJV7uNlmE528vLHzPq7X8hglbsDuXcmbfoUhKB5VxUm0WCntZ2C6sK9pOAPT5TGy55yu/z/63J+o51pHLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMZXlV3IfxO2UQZ8VNbU+XBr3eRdpm0W5nqr6tZJcYk=;
 b=XalYjo//QQ5NS7jE0t0TnkVLVl4VF4jHN3aMBWYTNijXeNEXw1ttGI8J8pZKDNIYrBYvv853UtNiZnMyjPnb2iCs3noPvzwWXuQXOP7d7wT3gzRRbAXd+S42853oLWsrxe48ZrAG6i6te0z8idiv3iSI0GeX0NIvPf9GXCg6VSZ7FgdLrIeIADQMW9sUi+vXgDm+S2pXt/f/o87hQBE6Q0voSK9f72n2V/VX5H5wH0uiM5WegLxgMJKusOKdRgHdPaKC+9w7xZQnp7dxdsQw4eIHeqrTWYB1Cx7+Ji6K9vosN0AQdbHpSYruup/vjPa0STCdBF3GqVJ0mrKRPz8isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 07:27:18 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 07:27:17 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ice: Support untagged VLAN
 traffic in br offload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ice: Support untagged VLAN
 traffic in br offload
Thread-Index: AQHZwS4wCmY8chCbQkmWIChXjeqlwq/VEKJg
Date: Tue, 1 Aug 2023 07:27:17 +0000
Message-ID: <PH0PR11MB50131F1CEDA4C77C775B95B9960AA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230728083042.13326-1-wojciech.drewek@intel.com>
In-Reply-To: <20230728083042.13326-1-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SN7PR11MB7705:EE_
x-ms-office365-filtering-correlation-id: dff6b3f7-b16d-4b80-5431-08db9260bc77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BjU/E2zXJsYvwN+gozDs7p2VkSjRZa7Hw90qD8Jc1FizYJ+NJbW1xQTOBbbRjDQUP5SIr5Tgqm9otI5pn9DncXdDMnh1BJo9OXDo6aBgvScnxb4/Y0K6thbnjfoDe713GZyKdEwW8HRts4vQwwW7ZeXvK1dNsV6AKYLnrqeU7j0a8TCJv3bBADCtIz3eE9X0/UdPB/O8yKfokblu6m30RDunXxzySVDw16gW4oMq5fFIRWw67h1DE7gRy3oKBEvUfyOHQcVI0ri/il9pK29aeHdKtzh+qndzSiKYEUW5ljE+ipVusWyygxq1a/E+u7k9lC02RT8SfpvPUwi26B3uRLw64VnH9QE8xukj9EQUA5BVPDg3uW9d14D4uNUZMTHix94gTup0fg/hHSRHpUcs9YMm2BV7VdxsQ4AsHYJgRRYYtm+vJrwdjEE5bbyInO1N31H90DeeTK/g1+J4xg/hbyhUuIr22+nqNQhqhMFsOTLYlP/BEThH2Dz7h6nuCJicp3zoV3i6m/jtKnLaoPDR1tGHcvXhm3zphBnzqrNooIxqs6n45onzt+Fjpn5dQd7CUdHFSSX1toEkMcC+Zn+7sZY2Lqb8v3yaKY8qeCNUWzR28mIFAprrtYd5ErbeBJQF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(52536014)(82960400001)(54906003)(110136005)(122000001)(9686003)(26005)(33656002)(6506007)(7696005)(8936002)(8676002)(5660300002)(55016003)(71200400001)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(53546011)(4326008)(2906002)(4744005)(83380400001)(38070700005)(478600001)(41300700001)(38100700002)(186003)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ogixgiiy3rHtQHEXEEnSagLQkypyvzDBRoRg1iVp2JQNd2EQWB3YQf2KAi8U?=
 =?us-ascii?Q?1+HGC1ltS0tZTB72KCldJlkrp6hZf7IOcs5l3lHNq0khwfdJAhUXvM6TWpYU?=
 =?us-ascii?Q?2Vja5662pLNxfVUX2Uhmnw6JriXmBT4EZMm6HeflzBNJxqQw5S353wQy2kZw?=
 =?us-ascii?Q?ViIUuvfV5DE0ClrPamzR7m9miWzplrktcj6scSdwQezZdSg0DRsCoSoxgA8n?=
 =?us-ascii?Q?k4agOYc1OPrs1pCJtRstNG+fxJKWHLgkfN3nrDkx9/gdsaAcNSLMwuh1g+Au?=
 =?us-ascii?Q?Ay/hyIeGP5GuNjBZM8FQ52NH2M98OMwIyrekJBnUKKfiS36VnXH26tFiw4P7?=
 =?us-ascii?Q?vT/X0nIteAH/nPydqThuOathfPfb8H0wnbwPHBTN3MHGpRnRg5qzQAIkltMT?=
 =?us-ascii?Q?gDGkoID5PqxjbdntopKKScmjcLDfLcoYlXbW6e77AQiY4p07/vSjBjq5gUIv?=
 =?us-ascii?Q?Voc0iO4hxifF4jrz0fzMI0TLJvFObyqdMaW4J7Qn3J8SaQkT6cNCeZEkFGwu?=
 =?us-ascii?Q?uycehSMkQc/K4YgyKn01nPisce5O+u2JSJUZTyDLun+HhIDdH+SACpMFST7m?=
 =?us-ascii?Q?TF5YrwMWLPBJrhMZaSO4Lcdzb281lka5jSEpIhr/2WTmXQxNOOwOcHK4hOIj?=
 =?us-ascii?Q?cJwVAVhipM+n/G4p//0Zsv/w/qVSxfROG4/JNYdGZhsH57F7fdmYODBqkmYW?=
 =?us-ascii?Q?p87sSQQC9fW3VouFFxZ2nUgOr6q1DioUXaBHiwCGpEryz8dATlTSutzRxldp?=
 =?us-ascii?Q?t7zOWkRpW6kL/d0esYnfT0kKsvzd99BIn5Yq7FvE2EZRXlCxNyhQihh9UQ88?=
 =?us-ascii?Q?83WWcP3lSFMg59R6M3vSHzGREi0tfzi9tB8cWaBAfK6+5tNOEhDfbj188kqG?=
 =?us-ascii?Q?KEsPiZiF+sWo1TeyPT6/2NZDREtxc+wPY6JPwW9YzYt+lIH7u+JtFhi3Kt7J?=
 =?us-ascii?Q?oGoW5NsJ32IpsW25d0LAXwb3R5R4Ei8OECfizPU4Ca92nPBcnhsAIOtuHF9+?=
 =?us-ascii?Q?03+bUL3Glt/d0GNF7OUf4o1akSjVoO9PVJMPjdQ0vRo/ptw+xExUsoO8QFnV?=
 =?us-ascii?Q?NDNoRFjISQ0W3RhmFv0Ma7FnR1WCtgyuF+qBwT1wtnNUgCOqQoN9O+UE4XEh?=
 =?us-ascii?Q?DzYBjcxztvRvHhMrEoTxpY1dr5jORsamVJ0engnFSvzrPHYG4wZhUEk6I0/e?=
 =?us-ascii?Q?0PDLxUW/TpCf5bQXKBViZ9a7HN5sZUNz/Vtjw/VHE1i8E+5ctz2ZK+4hxFoK?=
 =?us-ascii?Q?V7+ui65nz1Ui00zeBYICvaGFpGxIiFqu0PFYTZPdNxEEf3dB0FtHtK3uTvrR?=
 =?us-ascii?Q?yMeF5xcaZ9w87NLSG55IPIM+Cs/K32iqlAMnjBwFGvvRs/nCmjKBknjXJHDK?=
 =?us-ascii?Q?creW/dObKbD9IepGQy6SU/JTU9v4urtv9d76AP645MIbwtCp1bW4KMH+KMi3?=
 =?us-ascii?Q?NyJ/yTJ7BABZ8MsjNqCl4LwdJz5zuAT56zNA4PVbfs/Qd0qii99r+Z/5Seri?=
 =?us-ascii?Q?I8sWwE6Khwi95/uEKEK/Ro4snQczCfqE74xzMouAV+hr2F3jmRK/ynZ/0ThY?=
 =?us-ascii?Q?kwZCLJr/tTYWuZBmqJ359YzUAPzw8VG5x3+6XsZFpzRB3J184/DjVCQAz8NL?=
 =?us-ascii?Q?gA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dff6b3f7-b16d-4b80-5431-08db9260bc77
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 07:27:17.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eR67s00SQmeT9iJO8c51hJ9JhSPgJx7R1s02GmsXuggKAjNbsCTO74K1m1mkufs+XXBOIAwvUOTpcOyAX6PZJde7Bldfr37wc1sTtly4wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Friday, July 28, 2023 2:01 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; pmenzel@molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: Support untagged VLAN
> traffic in br offload
>=20
> When driver receives SWITCHDEV_FDB_ADD_TO_DEVICE notification with
> vid =3D 1, it means that we have to offload untagged traffic.
> This is achieved by adding vlan metadata lookup.
>=20
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: remove unrelated changes, fix typos, add comment in
>     ice_eswitch_br_get_lkups_cnt
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 10 +++++++---
> drivers/net/ethernet/intel/ice/ice_eswitch_br.h |  9 ---------
>  2 files changed, 7 insertions(+), 12 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

