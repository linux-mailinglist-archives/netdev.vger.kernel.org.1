Return-Path: <netdev+bounces-20104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94575DA6E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C7D1C21419
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1F11CA3;
	Sat, 22 Jul 2023 06:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0F11C84
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:48:21 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BA270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008499; x=1721544499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NG+0qs1nsqdqPK/TRgdE2KlZ5evwEWCAcIugwka9PXc=;
  b=LNxCUlR1E4l/z1xm5W20wjllArsyvPKs++YWZBk/Y1RubuCcWfGNDIx+
   iTMV6Pt4DoDw+doAh+cNFU2kuEmzy+jI5u5k8pO6TNia2uMp7TEb3yAC9
   2YdS31d8QLfctyyASi5qhDGkhh0mA1tM7JokMhZM80ZxzNv4vaLguMNFC
   ypwypc+RjeSFaHKV0HkRWPqdEf0O9fTWW20m8covQB2TNCS8KzVVayk/R
   rIERgXNgVwhaDLxqvihbJhuPlck4voSbbVsZ+z+UkLPmtAhFzg9oI5Wux
   w1vvlsf3uFwlCKsoNQes8DlNLaBXRSfvHnpO3cFXyL4h95oaJ92Qz2aus
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="347457857"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="347457857"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="815259387"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="815259387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2023 23:48:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:48:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:48:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:48:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/f5ZICHDhkktx3PKjZaiK01zn71JWgQcx4Oj0LA2HnSpujNaqjJbIWIefaurhnpOstp6CMbZBJC/RkurprjLGfVFhbDnGA85YqkB21rGsuuX4PmRav7RiYWsMNAeaCSambCNBIZlqAeAZTc5jzar1Jqe5fuPEpTZU6YgQkam7Kip8NtJ4a+PDh1Cx4u6fVKbFZ6n7UYu2GB/IMnJCKR8CKL+mh87KcZu7UbmcQBAF3w5MljkkVVfGfZb31qI24uBfllriihLNIv+DR4ZKezFhhCfzrlkUq4iA507uN9OKmorBzTzLSoLNqVufH0Jy8x3jKUfyu7brf+33gyCKVnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91cKAElaRczkXtbwg4ISnsG0x/+Zpftp6Ih+Jbxsw1c=;
 b=LnPvyRAOzu34CIpq+1d6Pn65zaAvYvAe6JIzCl6QCrbASCbuapmHB7HqAeJX6DEc+CQmNC4sf0l9cq0QOKc33DHcfNV8XAm/0IwAkdIEY5k2ZA99zlagClYI69sbRiyKJzYnPl8OpMLaO23jCiYAfRYFgtJx/8ice9hQoUrePIZsRjqgJg/zpc0h01QRhlfwaBkyCtozmgKLjZCosEGb9c60Y38HMYF+ZO44muaw+j/qS6eNxdWch89e0nybyxzUn6u+slkkKq8jeHLINFeGM9+ZeHbe0xhZRM1ctYDzCvB9q8jlxb0mBpGySYYf9hNQm+m6AVSg/5R4JjWt0gEAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:48:14 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:48:14 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 07/12] ice: Switchdev FDB
 events support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 07/12] ice: Switchdev FDB
 events support
Thread-Index: AQHZtLD08762uvsDgkSNbSVpm7NkIq/FZ3Yw
Date: Sat, 22 Jul 2023 06:48:14 +0000
Message-ID: <PH0PR11MB5013313C99C83E29B1E1B2E5963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-8-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-8-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: a581531b-568a-4919-ac5a-08db8a7f9f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tGN80t+yWUsX4d5K0J0SJeWZ/3N8tkskrTFnrnx+NudO1zzJ1jDuT+j+R4DjS8YhQ3+dY9ailRqGXdLN+6/tJgP7ndVnre9L8bntS0zowoR+oMvvj7j2xlN4pXTElBap8iBKewiddgdX0PuuvJP4JfGZebd3HhODTQCSqoT4IC6j44MZmSxBtInjP6Wt0ZpMygO/a4H3zAz+7DZJ8bR5k2Zr0Y++tQgSW0RH/Q5sUm2uWgJHPzYlv9MWnxc9BdfUvqCYwpjoYcuwar+69LkzopfuuDFWaC2uD0Z/l995OQg5Jdbhqw9YcKIC5/tD5SqqThDezSRxUGOI4JOSw167V7f20tvqUQ1mM55KzV+Y1VyG0N0YTC8N3mSflguWoJS2CEV2TrHrIyDSGMaJbeYgOMyofuxyBA1DgRTGv7GVulhBHljSQVW8GI1br1i79acFAvyD6Vtq0iKAEvMvD/4Td3sqJl2VG3CBN5v4Oq1zWwgbqekSq6hQ5ROHzkCntuFFn/1yGvHI+azajJYkwPWEDpjJPedel428gnPdcFjl8LuI55QJN0NcEpPd4JEWQu0m+YbIjCtw2fLG9Uh4F40LkPLZvM1PpYHCrZgC9MY3TgJHvNcdQ1so86XbZ9tyC2c/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jVYF3+4sRIBqj68klOcOX81smEmRlFRulE4WwnKeTE7qF7rKA4ih60yJL9UX?=
 =?us-ascii?Q?ZRwiUBrNqajUSDKUfPEkVMsMr6BngbNIF/nsZ2Iqh1Fy+eUNG1KVeJ/hqvbD?=
 =?us-ascii?Q?1e7NT1wg9l0vUExfEpSZPiarmz+k2l4Hq+9UvLPwsNldzgGaKVaviIF4Wma4?=
 =?us-ascii?Q?oZmuutK27Hq/W18Kf7pMMw706TU7LUJZkLWeCLeImR2gvao7wCMozPKgxWI1?=
 =?us-ascii?Q?TndpRTTEhUB9L6u8U3je/+WVSAxx0YKdhq2Hg4DxCnQxpmG+PXM4+a8HTFXP?=
 =?us-ascii?Q?Fj/LvHh+b/cM470ununBwzHTCr2ya+bwmqhMz10BEI1GjHDSkWPapTaYXtU7?=
 =?us-ascii?Q?j3Xo9qxYp4jrK+XVIysIYsxbaExmowU3aHFrTfPV8oAWuV+1sGSEdEyNNv9W?=
 =?us-ascii?Q?kindhxOffV9RuWlXFd52yvGqM0VwrCXTcJsbviYabPRnVSO4/l/xAPZ49aBC?=
 =?us-ascii?Q?gvYxfvtKfWAX3ON74Aol5no0kuuQiRLqEeBFAzxjfHTGjA+ogmm7Yua2Cmpy?=
 =?us-ascii?Q?wIKRzvLhy4AX+JZbUtm7LCnH/wlMVlGDCpEFT8pgd2huFW9tWAhTNfUK5Cxb?=
 =?us-ascii?Q?9F/llgOFXrLF6WWp7ej3TF4+0SlR/HTaaHzb7wqXBKxgXRKGA7wgHELrzA7K?=
 =?us-ascii?Q?Yc1SM7g2zdSnsdQ5jFHI4Msq7iE7spS4JbIwMhk8a/rDOu9x17+SEg8JNify?=
 =?us-ascii?Q?vxwvTbbYDsDOYi6vBCmCTbe+Sqfp1CyKmV0genWVYNRkyuUj5oC+2oX0UXgk?=
 =?us-ascii?Q?OcK8EdkFz4R5ldqnscY3HZNkr8tuSDsamSW3yYdMhusBimfg2Z6YNzYWaM7+?=
 =?us-ascii?Q?YPl1toRsgFwRVeV0rqkfmld6sUvw4aH5N8ILJ/dsgXlsPoJ6fgwq1s4gLHMU?=
 =?us-ascii?Q?sacZf3hE+T42gysra6jpsvSN+dOOJntRi71ELic36uuI1hvRYitstUxn2eOz?=
 =?us-ascii?Q?6brnheIx7cL5aXISekr5nio5kwwXIJss+y3MBFas9zI6RXIjEHsE81fh8I24?=
 =?us-ascii?Q?H8/d1Z35GOkXPMFQGTJQ9IfMEwObgcyAcuVi6YOfXKqg4v94EmIBCBxofEt0?=
 =?us-ascii?Q?az0qUHcByjFj/yWjpapbXRKgje8M3ejVpguMTlIDD9jYfGos95Hp26jceq9l?=
 =?us-ascii?Q?IX5eXMYxYscnGW6tP+HJcWFHui/0+HstaXT4+vhOS5q2x6867nYoR/oE3+dc?=
 =?us-ascii?Q?OiIqHzCnPIiFwoKEItOEpfz1+URgYPUfYRMI/O0QZGuxhu+Xv/Q3Rv6VP0Pj?=
 =?us-ascii?Q?GnIl38or+/6ltLKCg/8q7lqeifdelMQuMwQHqVePSOWshnQYK7PyvFMel0IX?=
 =?us-ascii?Q?+XvIcL9eadHsj5bLXFWbXx+2J/qI0CSgXGKUFKCEj5FmyQ69T+GhvNe9hG3J?=
 =?us-ascii?Q?EHPmsxisIgZLE8FouGwC0kpqntOJV5Kda1/KtTyQzvETtKtctcnrRGlAttvV?=
 =?us-ascii?Q?+yaxeVcCqBN8TOzPo5HYdYXIFfk+QhVtf1loiUxMaE3NnaVWB9ek9JyH6uKp?=
 =?us-ascii?Q?BAWeWqB9WJzugc0Fzlm53XrKmDZb+KSqnSIiTQG0CpUuAtQPaNWuWd3hJ1db?=
 =?us-ascii?Q?p795TCy+axmjjanoz+08Blbfb5gdYpG2RqkU+wBnbz5qjuVQHnArNk+ZXAiE?=
 =?us-ascii?Q?NA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a581531b-568a-4919-ac5a-08db8a7f9f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:48:14.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRuj+b6QgyActkZ/MbkYxfieLb5dG41V+WRXYFV0pMmv9hwSVY5hQ3F9FBWtZw+zAU/rhRGxhSvsRU+WUaUq1x9Tt+W1R3gBGT/a6GeOYhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 07/12] ice: Switchdev FDB
> events support
>=20
> Listen for SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events while in
> switchdev mode. Accept these events on both uplink and VF PR ports. Add
> HW rules in newly created workqueue. FDB entries are stored in rhashtable
> for lookup when removing the entry and in the list for cleanup purpose.
> Direction of the HW rule depends on the type of the ports on which the FD=
B
> event was received:
>=20
> ICE_ESWITCH_BR_UPLINK_PORT:
> TX rule that forwards the packet to the LAN (egress).
>=20
> ICE_ESWITCH_BR_VF_REPR_PORT:
> RX rule that forwards the packet to the VF associated with the port
> representor.
>=20
> In both cases the rule matches on the dst mac address.
> All the FDB entries are stored in the bridge structure.
> When the port is removed all the FDB entries associated with this port ar=
e
> removed as well. This is achieved thanks to the reference to the port tha=
t
> FDB entry holds.
>=20
> In the fwd rule we use only one lookup type (MAC address) but lkups_cnt
> variable is already introduced because we will have more lookups in the
> subsequent patches.
>=20
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: declare-time initialization, code style nitpicks,
>     use typeof instead of full type name in the container_of
>     macro, use PTR_ERR_OR_ZERO in ice_eswitch_br_flow_create
> v5: move dst mac lookup assignment from
>     ice_eswitch_br_{egress|ingress}_rule_setup to
>     ice_eswitch_br_fwd_rule_create since this was duplicate
> v6: remove vsi->vf->repr check in ice_eswitch_br_port_deinit,
>     it was moved to the previous patch. Do not pass br_port
>     pointer to the ice_esw_br_fdb_work, retrieve br_port pointer
>     from the netdev in ice_eswitch_br_fdb_event_work instead.
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 433 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  45 ++
>  2 files changed, 478 insertions(+)
>=20

Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

