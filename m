Return-Path: <netdev+bounces-62992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C77682AA86
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4261C23C60
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC9101DA;
	Thu, 11 Jan 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8IdfUl/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896D101F2
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964022; x=1736500022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5nVF/jgQ4OaNK4hhrlRWVnpThpa4K3XmRfgYJp0g+UQ=;
  b=a8IdfUl/oP3OiyHY4sBKotcoSgIOI6wds+EOPS+9O5DR9HwRASKB+ZZR
   fwHlzmtmXPBIHKbcDwAP8DfYFDmapR5iz/yUHfIVchP3FRepBYHGDJZtn
   CB5vj2c+G7DBdJKCAIisKUr9B30kgaZQ2M7twbbhLgbRMtzxyaORHqj5B
   CAOp+uO6t4QVXmlm/1e4bTkm/ws3ssxPVXGBprVFNapiemthg05Qf8QNB
   glg8SLjPfL/2Ly94I2ltpmsOxbMnxIJjMQABIVnOv/2d714PwHvA8Q2Lu
   gVH3noNEEwMtFc8VRppjDeW5xaX77X2frYx2NM36MfQl4TVK8Qf+EXj0G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389225572"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389225572"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:07:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113770023"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113770023"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:06:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:06:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:06:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:06:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:06:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhQLaTA6OghIxk28UGvKibt9cDppktjCfS6kV14j2hCxSQmfm/C2BdZKHGQ6AjBxuETVrk3BBZWDSBgFvQE/WG0vi3t3FnBZZNP9UuD4EKGh8rRhSYx32mGOlUwLSVj4fvt/vzKf8SEQnyi+Wyg4yHPNVPPzDDm7dV9f4pg1GwTkUOheIOsEkzyu7Q/73bdcw98eliwh9zwAcjlJYst4PL9MEJZ0rNBMeSRuE5w2SwJQaMHQBiJlOB97T8ppX4hnhh3lebgP97yacD6YlNwtsZOJSpmXBjWLEW1pAPWHTkWBNxo6Md+Bl8JLEB7LD2S6hB03qOLau/zOi2nVddoOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R95xsPVHnq2raE2h8WxAr8GhyMk29Z36+zO0d3f8yVk=;
 b=hVJMF9u9YSBpXFAhEKc7QExrLByUG7qY99uLSQfyp/PyYE2DGUrD+1d9S5JZWNKzWyZuYxKXhhiHFHB2xuT/slMF4ilJ0oloooZl8nYNsfcU0E0lxqMR9328faxzkmYZW3GVa1QNjFRk9F60rOnACX5Dhzu1K/2j1OCuMM80WZn0KtXVOvMcTKC4NiJgBZR0ws3N80Sa42y+3yPLIOAuJ6GFNu+Qr8COGozqy9Rq6Rk6Fw6IHjCHl4+8kf7XNOkYVr9tpk6PAIo8WXtx9S0n2NoKiJd8LxvBduH5A3kK+b1uTtR4FlhA054HwWN16EvMIinAsudTgsyVBbt5rHyhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 09:06:55 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:06:55 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v2 3/4] dpll: fix register pin with unregistered
 parent pin
Thread-Topic: [PATCH net v2 3/4] dpll: fix register pin with unregistered
 parent pin
Thread-Index: AQHaPv9VbboF8qiqxUSEmVbowp83CLDJvB8AgAqfnAA=
Date: Thu, 11 Jan 2024 09:06:55 +0000
Message-ID: <DM6PR11MB46574E6BDA6B6F5E8A6E9AB69B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-4-arkadiusz.kubalewski@intel.com>
 <ZZbFNMMiRvgSi1Ge@nanopsycho>
In-Reply-To: <ZZbFNMMiRvgSi1Ge@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA1PR11MB5778:EE_
x-ms-office365-filtering-correlation-id: 36d4ae85-7109-4b36-24bb-08dc1284a8de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxNtyCMDjnVW18gzbTLm1v+Y/vE29bU3MkuF173jDOHCFRUi9+9nmcIfouStDFTr7Lh8UJ1PAm5M/HyZS2zNh210juwnOfhgoBQdocKTNCqTmrQrGaXYlglxnK6dYeSIVjiz3NUCAvD3OyvUYY8YKyttgKlkE3yRgsiYkSu9v1NbR+i8A/BTl/OAospO/OiBtD1P9oRJpEHa1N2qTIpnBOU8KhDKCK8I6OsQHK/+HUh6Rf8HSsB5/ePB7PlYmxW9cIrDhyT3JqS9Rtoh4YMmV7LySroOXN/xB+v/g3ck9vikfNUQfbRx6YnWUKi6A7/+vDlvdP924hFBHx7GVbbmmU20iL7UGgrwbeOpae7hAtY3A+MaQuDNkX2EfDJc3WeD38OQFiBlKRClTc47avqwfv2z9s0lWVI0avpRZsiKP/5GfgXuHbV8xOgX0tT+9RmuYO4ROrzBA2v2arbl9BpiblxTqbTR/dACyoPVLpFacVFapC0rlhUdtpAB41ZsCAGXgpefcH3XAOEKJ6mUlpcH40PICyUFqTuM3zF0sA1vd5ynhmek83usMMpatUQ+0ZirLym0YoW9xzsw9j8rTOvySwd9JL5JagK743vj4KIjJWa0P/ujNJJXdLPeOfUGdJDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(33656002)(5660300002)(52536014)(2906002)(122000001)(8936002)(38100700002)(4326008)(41300700001)(82960400001)(86362001)(83380400001)(6506007)(7696005)(478600001)(66946007)(9686003)(26005)(66476007)(54906003)(66446008)(107886003)(6916009)(64756008)(316002)(76116006)(66556008)(38070700009)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6U+QARs5m6NjMK2ZxaXU3FETzGSB9Dqc0wQ6IoenEi0KR4sOXD23Y7AVeWUF?=
 =?us-ascii?Q?4YchyslFrLYHzE5CwqAEXbdZHpbawxPooTb2wHzSqruUW9QW6cTyZHiuF9vK?=
 =?us-ascii?Q?Xc9pFqWUul+bCGDmvkwD1fkL0s5MQwxpDdukTPzCybpHbwYY4a6kWohLFjWC?=
 =?us-ascii?Q?sV0YYBIUtJROaLI7de1bcPMGgCmot4a3ux/NIz+oicn3X/K684MIcqAYY+E5?=
 =?us-ascii?Q?n0qPcU+czzbxXj40cU/PpaeRdrB6QNa2ql61vUA/P1RDORAof8sPAwxsqTt9?=
 =?us-ascii?Q?GmBwK3/Xo/Eq6iFkTSckD2mNw5nrhXGjbjY83lP/TGNwY9yov3jgSavBNM8v?=
 =?us-ascii?Q?sWL+Dk6FfWbvCfMhD/KFKBIHUpl8LhbYScJRM47g+IyUSy1QKsa6Akv0KBbK?=
 =?us-ascii?Q?hthp8mfFXMmems6NUsY+lrcUoQSN7PP3QMWdFJdZ9agq3DRVg+gvBd9rF/gN?=
 =?us-ascii?Q?p12DZxM9aFv+ux6VGZJo4x2cfaxSiE/K3TL43AivdIPwsT3UVekj4DRO+YGQ?=
 =?us-ascii?Q?A9XV2POBakmwE0FHeSVY3WT3ddfehDoXurxapKwpJdTWUtqTGBLovoJ+IuR6?=
 =?us-ascii?Q?ZP5UmRxkwGI78XU2cNSp3LVK3jAWIpi4wr4FT2gi9gtyUR5aka1vtAHbSFC0?=
 =?us-ascii?Q?JT8UnfUl12notLsgEuY0lSI+jLJp6O9bRH506bbt69kf/ZoRHGWQpNyz++Sr?=
 =?us-ascii?Q?ISs76jV7Ik4u6wC00icgl1TDnNvfLBj8ElJnwEEJDOvxm+J5LHS930xf4eki?=
 =?us-ascii?Q?52RSwW5LblQqdzm/tsSJ5NQ7FtBvuF3wPfaL3pFnHw8p7FsMRp1dubrNMLE/?=
 =?us-ascii?Q?wlbWXv1ogctx0tXCrGmS9NDmQ2i9DsA28E4eWD1QLKipL/5cmEPMbQ4xr64W?=
 =?us-ascii?Q?WU+trJmPkYHcdGoKlec1EtpN0HUvCwDCKPK1MBhVmTWbSbFluwFZMbBfOMuH?=
 =?us-ascii?Q?/EAf33yEtH1f5EBP2P76JmMD8nLu2YiRZbVA3Th9iHI4kH86KfWXWTH6Pe8L?=
 =?us-ascii?Q?JBdaoBpDxt807hbL6zEDCF0p57m6Tnurwk4dNHG4+AAcj8dUW94tnPaZBBmd?=
 =?us-ascii?Q?FMzJd6LPhqLo83F2gpYbVXT39yWyCQG9OTyDnGhT53qjGwS6+JiGmxp6a7Vq?=
 =?us-ascii?Q?LmEI14sPODX3D8/lhq4U7KAUqDHUYJbQt4x4Ze5coUeJHrVP60oH2d7bUGnb?=
 =?us-ascii?Q?/63GklAEPWXWFoXPREy3B5t7fwYBwPUeu+rLdfkwdJSlr8MiOzwiihlRp3NQ?=
 =?us-ascii?Q?Phdj3Wlro7gMhlWUf9pk0EsAHd7F1JMWl+fBTt25bQhrCLP4dI8uawUhSZRc?=
 =?us-ascii?Q?czKcT+I07Q7ZEGWpxKjkTNvwgyybOlNT4T3kA83bnHNM9PKZvN5fuSHV5OiB?=
 =?us-ascii?Q?+kTIU+ebBPgob1Fpc3x9AKakOuzXt0csybmpLY5i9JTYo5qNdWOk21F/jFrC?=
 =?us-ascii?Q?mZnreH6xFWeFkpYmFkS8dsB1yuqI+LhIwhUAYZHqUExQ/nRANG7ZWEv+dzSA?=
 =?us-ascii?Q?RBWFFw/MBtEC4mKcG5FhhopDUYRWhtE7BW8RvC7tVRUyxkwNAL5/imI8Uqm6?=
 =?us-ascii?Q?duQC5+dCTo5o22ABFRf0nwqjgBFCExahjrNYiLRuNk1N+1Z47CCMhyTV6OJP?=
 =?us-ascii?Q?rw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4ae85-7109-4b36-24bb-08dc1284a8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:06:55.7751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKKyGBMsW8hgijkisL/uQmxB6k7759jzFC8MmmK3jq3qMmb1rJg3LuXAAAVoPKHyMND4WPtrmt2fssuudAnPugre0rkFAX8NEWCxzAfUh8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 3:48 PM
>
>Thu, Jan 04, 2024 at 12:11:31PM CET, arkadiusz.kubalewski@intel.com wrote:
>>In case of multiple kernel module instances using the same dpll device:
>>if only one registers dpll device, then only that one can register
>>directly connected pins with a dpll device. When unregistered parent is
>>responsible for determining if the muxed pin can be registered with it
>>or not, the drivers need to be loaded in serialized order to work
>>correctly - first the driver instance which registers the direct pins
>>needs to be loaded, then the other instances could register muxed type
>>pins.
>>
>>Allow registration of a pin with a parent even if the parent was not
>>yet registered, thus allow ability for unserialized driver instance
>>load order.
>>Do not WARN_ON notification for unregistered pin, which can be invoked
>>for described case, instead just return error.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c    | 4 ----
>> drivers/dpll/dpll_netlink.c | 2 +-
>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>0b469096ef79..c8a2129f5699 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>-#define ASSERT_PIN_REGISTERED(p)	\
>>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>
>> struct dpll_device_registration {
>> 	struct list_head list;
>>@@ -664,8 +662,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> 	    WARN_ON(!ops->state_on_pin_get) ||
>> 	    WARN_ON(!ops->direction_get))
>> 		return -EINVAL;
>>-	if (ASSERT_PIN_REGISTERED(parent))
>>-		return -EINVAL;
>
>This makes the pin-on-device and pin-on-pin register behaviour
>different:
>int
>dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>                  const struct dpll_pin_ops *ops, void *priv) {
>	...
>        if (ASSERT_DPLL_REGISTERED(dpll))
>                return -EINVAL;
>
>I think it is need to maintain the same set of restrictions and behaviour
>the same for both.
>
>With what you suggest, the user would just see couple of pins with no
>parent (hidden one), no dpll devices (none would be registered).
>That's odd.
>
>PF0 is the owner of DPLL in your case.
>
>From the user perspective, I think it should look like:
>1) If PFn appears after PF0, it registers pins related to it, PF0
>   created instances are there and valid. User sees them all.
>2) If PF0 gets removed before PFn, it removes all dpll related entities,
>   even those related to PFn. Users sees nothing.
>
>So you have to make sure that the pin is hidden (not shown to the user) in
>case the parent (device/pin) is not registered. Makes sense?
>

Yes, perfect sense. Will do.

Thank you!
Arkadiusz

>
>
>>
>> 	mutex_lock(&dpll_lock);
>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); diff
>>--git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>3ce9995013f1..f266db8da2f0 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -553,7 +553,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>dpll_pin *pin)
>> 	int ret =3D -ENOMEM;
>> 	void *hdr;
>>
>>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>> 		return -ENODEV;
>>
>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>--
>>2.38.1
>>

