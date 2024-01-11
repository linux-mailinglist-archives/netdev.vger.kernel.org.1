Return-Path: <netdev+bounces-62996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5182AA9F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A3528553A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FC101EE;
	Thu, 11 Jan 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alxndZeR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC010957
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964603; x=1736500603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BcrgJSBjEKWU0QFn5jy09a53RTzQgF+prCelxOJBT/Y=;
  b=alxndZeRsjQn2Lk3qwYi3FBe8XvjzI6rfl/CJAHPukckXrvK/CT22rPg
   TBEcTchCZuu6vzT8ikSTF9Kw3YaJ/9Z7rUHVPLCVoAAm+ytDgN8oMAq+6
   68CUlTjXYmZHEdffflcJSWd2Aa2GaYS7xHqB4HWRWOBsgo4vpRjuCPniX
   PDfrjrSHbpGgVKJ/z1jQOttbpD44OsJChCeJMf/SScqaIEC/QqAcIpZQZ
   /QFZ8Ll1jT/vz0wqI51YqU9FHv70i4Y8uhXq+iiJ2prfpw8tN/v18bz/e
   KMk2p52LOUs8TzSCABdRCh9u3EfAq4grRzY8IHspvNUJffLaoBqwuB6Y5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12146589"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12146589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="30934026"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:16:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:16:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmuMghpsgtGHroFdJnmDOEyzitG7gHSHUQlP1sb7V1LLDDumVEpHH6Ccv3AlyqsJUeRuiMuuO/wNUxhPfTcXtAzQhIr+jDcljfeXe31snoUmn3Zzngzn/tOnCFoLYDRaLwpORBZW+iaRFnDGl7BT84aiNg7P8LrArTX3wablC+9xvlfxl86tjm/e2beX2VXweGTBVbmeKrghsGE7MR3RE8o4rj4tohmF9MQL19hf6vOe01H9RGorcm+SGrPxKQ4f7pQbsnr3k3psh4AZ+jXonC6rwe4xG2XT66/6QluyqGV3JV8jojezNUtaEoAzvB+Sx2NDPfigUBGJqsQuGVgzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS+t4b51QV3XVCjWmda1S1Gl5pLN1+aFl/Hs1r5VX0U=;
 b=B3W9bz/X0nZIY5gtKI2DiG6+UuPWWiy/075M4PayoeBKQvoe83eQwSXPxEEOKIjJGq3yRIp3cECl5bmSBhBUXaBOlyUx2NmfcRzHDqu18kj0VF3L0bbt0oMxyQ0obPUVk8/3guyPgmofIrv57oKW0pIzyXPsTTbto2xJxbRgRw6QAvR5i92pL+rD6hcdsErb9baEG0Tt0PBuEwQTbXkd9yvyAdKqMzAY/MjaBlH1m/4Gj9+xONGMsXXgtKrbhsNK/qxm2LtBHFYnc70BUzf/DAY9VZ4X/NuT24mEWBDP3av8ZtdrPz4ryyQ2OagcGbPxoPSrrydCf3W6yn9bCCUYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Thu, 11 Jan 2024 09:16:39 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:16:39 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"michal.michalik@intel.com" <michal.michalik@intel.com>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Topic: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Index: AQHaPv9PdEbVjXsF8EmuApoVd3S7HbDJwKMAgAqcBUA=
Date: Thu, 11 Jan 2024 09:16:39 +0000
Message-ID: <DM6PR11MB46575360FC1EC41E4584DF649B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
 <ZZbI_gsQuugrJ7X9@nanopsycho>
In-Reply-To: <ZZbI_gsQuugrJ7X9@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: eb82061d-89f7-4d5b-c889-08dc128604f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IYjtcwWP4iWooe+indj0oWcy94KTDV62jmInuGDDdQbUn/HZ5dJLWk2Smw02H29dppTYF+pwPGeTO9nIM4EKEftQ8qMvpoR5eD6xsX1zDL977SowhRxpyEWq378b2McFsZ6Ede01jOX0fjH9d0ZAmA0GpRnqFbqOPP+jwsfBk5N/j3OYNX5Hjc9F8rR1VWkdxPfl7o5id3XkLLnv2+i8vAcq5XQgwd6pphhHMODXPFmr94pcnOBiO1s7fmq7iHUJfX14HeZ3Lm+bWg0589qPlMFeSNCA7hv9rWKfxvjd9Dkb2RcJe81pd9NNHc3fCpzmcVXVw/IYxJ9ZRk0HHwpbIZw6JLQfd0sF94wgtsg43pr3fcRL+lYFWRaXSNImZ3TcsrpGUGPXAl3S6mqymnoxDfs1I5jZ4MOG1n0duJUWVlr/5WEN08FvehGGu0s0C+AL6A/9vMopWi2ty5xOIZ21u2UyzxzK2poZGam8HGM0ULfwedcEAQp7rJGmqfABf64kBy6+AK6fB/J1p/PAYokOF98EuAAfg2hw7RDrccJk3ZOAEPLf723w2pLbYGDzQ9dZUyWTVxzq8JFYMAHflj0UlrcU4skel9PZYNO2SyHg/VXFUz0XQs+C+OHFch2lVfB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(5660300002)(107886003)(82960400001)(71200400001)(86362001)(7696005)(6506007)(8676002)(9686003)(66556008)(66946007)(316002)(66476007)(41300700001)(8936002)(76116006)(33656002)(66446008)(64756008)(6916009)(54906003)(38100700002)(26005)(122000001)(52536014)(38070700009)(4326008)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L+7oH+7QL11Uy3U3svF8ZWH+Q89yE1pO1SZJZEdmtVTzeZefhQUWxhbkbVYT?=
 =?us-ascii?Q?ZAyWzq2IlbYvc40vSPbFN8M2tfvEPgCeekwhlqYBxww/mkOfIxhbNDkTiXsM?=
 =?us-ascii?Q?q8MgqdthivcmJgAbYVmlN2/iGRrFo2y2qu/95k9UTVbNdm7P6JU0BnbuTLtJ?=
 =?us-ascii?Q?Ncw6X5jTUB7tbY00S0H+zzoMRO3VEzFehzPMUoN6u0WZvu/BBOcd4fHT+1p8?=
 =?us-ascii?Q?cCdOpRWVJb1r2jYYjLyZCOeFrNmRNqpfckJKonGmmfKxkPIWkgxFjtnm0Bmj?=
 =?us-ascii?Q?THrmDnxq3MJJmf5ANVmEHEkm8DoVIuUI+48/7CNAVuXXkLT9iB3eo2DxVOwL?=
 =?us-ascii?Q?cSnz5hdnpNnqD3WfQSj+dOgvnnaoenzQKNyPhFjk/I++D1y3NvWu0m7VoToz?=
 =?us-ascii?Q?glKa/DMRIsfyUdiJaA7BCu+mgJUgaNDrP0TDCajqasQmFNRyjYPs0J8BIWje?=
 =?us-ascii?Q?PQsL39rjql4NFvpLOvpRjMsjVKDoKnGc5VGHVgJYKyu5FmQ+besLM6ssnpEN?=
 =?us-ascii?Q?vL5GzWlLpoL6s4dRkaEdpyvqSQVgneV5p4F/K4umRI44js0CAZqoSKXnnVJp?=
 =?us-ascii?Q?V+W9tWLx+8tZGZCRQuPTEtnV3+AUVXoj+2yBhFd2eVPRqA4nj0ZgCo8z6vkE?=
 =?us-ascii?Q?KYF2E6p1Oom73nvM0NZM4bDC0/ISMntu+BXJoI3xiVcKUmNFeCjx0p9x7hlK?=
 =?us-ascii?Q?xsMOSm71YdDvZpwXQBOA09Z7ICRUBFf1/x29jbsjbM2ZdW0B6Vto8NZDznpB?=
 =?us-ascii?Q?t+uxGe1lF4Q07pxlziuefTAPYd51O2P4J6qUaRWqUGp9YoNWyhWaV6VSHHuq?=
 =?us-ascii?Q?xfVBJVcYFJzfTPGohOTYAe1n6TPRBV1SI0m+o9UwfhEBi0IU2Asp3IcdTcVW?=
 =?us-ascii?Q?Cnv7Fc4JXb/wrypP8eDcAV6AirYK4xje1rLuJQ6r6odtthYhg11E50mBNQWt?=
 =?us-ascii?Q?Ekx8r/c/KNuUskZ4yEid6Xi1XXpExZWRcaVEeRRH0bjCs9eoX/nAbRPSB14M?=
 =?us-ascii?Q?9ThrbioIjkhOyWrY1wjOISX4IzFPwF/we15hQlTpoDs5vSgjWWk4bs5gE2zQ?=
 =?us-ascii?Q?MFKtFGy40bdj8Ck7p4uO6hfg5AB2VtRlxa2B48GWtX+g4qxwmhVVfWzPOgmN?=
 =?us-ascii?Q?WDtbw0I69ICNubynHjmumvh0NDMjWzrjq/UPG89PTalUhATOB9OKjz4LVriJ?=
 =?us-ascii?Q?IpaCz3Q6LN+fGj1ZpnAbx4ffG1c/CH6aEJqKDpyo36l+F8IDd7mPrxvorzFe?=
 =?us-ascii?Q?mDpYG9SUWuGOtehJMNODcJoo37ltgZPOoQxRlJmkTy+mOIkh5eWY94wcYQqZ?=
 =?us-ascii?Q?F24pJCw+1IzyEBCuCexfYrFi8VXz1Byiff/ARpPvPYCVuaYqr+PmWCMb6qUA?=
 =?us-ascii?Q?oAR/+3skTvHZCDdmRIM4uLfR4ETWV2aSn2LN0a2w2coRM8HHPJCAHvVerHBe?=
 =?us-ascii?Q?tr8z9gB/QbZHsHC+9WnAlToYYhAku1TWSO++ObIS8WDSQoeH6O7Y27fkdiV6?=
 =?us-ascii?Q?9qNOQKOsvGnPQ1HIX+lZpYF6ZSos7Ppa6NePJR9luGGIEEvruNlj37OiXMxJ?=
 =?us-ascii?Q?FG8GlcenyEpusUlxDbs60XEMhxuohqMzz8jrWV5bdy41nEYJJkIEDjsa6M7l?=
 =?us-ascii?Q?Cg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb82061d-89f7-4d5b-c889-08dc128604f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:16:39.7922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qG31iqYUTkDuiTdC8qHf/AOpeAILpUm8ydctyhC5sIgn0Be8lgr0fJQbV5OVJcUQKqKYmr4zW5559twMjP3UFxzm4LeXh1U/XpS/luFhI8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 4:05 PM
>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
>Cc: netdev@vger.kernel.org; vadim.fedorenko@linux.dev;
>michal.michalik@intel.com; Olech, Milena <milena.olech@intel.com>;
>pabeni@redhat.com; kuba@kernel.org; Glaza, Jan <jan.glaza@intel.com>
>Subject: Re: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
>
>Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:
>>If parent pin was unregistered but child pin was not, the userspace
>>would see the "zombie" pins - the ones that were registered with
>>parent pin (pins_pin_on_pin_register(..)).
>>Technically those are not available - as there is no dpll device in the
>>system. Do not dump those pins and prevent userspace from any
>>interaction with them.
>
>Ah, here it is :)
>

:)

>
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_netlink.c | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index f266db8da2f0..495dfc43c0be 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -949,6 +949,19 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct
>nlattr *parent_nest,
>> 	return 0;
>> }
>>
>>+static bool dpll_pin_parents_registered(struct dpll_pin *pin)
>>+{
>>+	struct dpll_pin_ref *par_ref;
>>+	struct dpll_pin *p;
>>+	unsigned long i, j;
>>+
>>+	xa_for_each(&pin->parent_refs, i, par_ref)
>>+		xa_for_each_marked(&dpll_pin_xa, j, p, DPLL_REGISTERED)
>>+			if (par_ref->pin =3D=3D p)
>>+				return true;
>
>		if (xa_get_mark(..))
>			return true;
>?
>

Sure, will do.

>
>>+	return false;
>
>
>As I wrote in the reply to the other patch, could you unify the "hide"
>behaviour for unregistered parent pin/device?
>

Yes, in v3.

>
>>+}
>>+
>> static int
>> dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
>> {
>>@@ -1153,6 +1166,9 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb,
>>struct netlink_callback *cb)
>>
>> 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
>> 				 ctx->idx) {
>>+		if (!xa_empty(&pin->parent_refs) &&
>
>This empty check is redundant, remove it.
>

Ok.

>
>>+		    !dpll_pin_parents_registered(pin))
>>+			continue;
>> 		hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
>> 				  cb->nlh->nlmsg_seq,
>> 				  &dpll_nl_family, NLM_F_MULTI,
>>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb,
>>struct genl_info *info)
>> {
>> 	struct dpll_pin *pin =3D info->user_ptr[0];
>>
>>+	if (!xa_empty(&pin->parent_refs) &&
>
>This empty check is redundant, remove it.
>

Will do.
Thank you!
Arkadiusz

>
>>+	    !dpll_pin_parents_registered(pin))
>>+		return -ENODEV;
>>+
>> 	return dpll_pin_set_from_nlattr(pin, info);
>> }
>>
>>--
>>2.38.1
>>

