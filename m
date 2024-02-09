Return-Path: <netdev+bounces-70498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD884F440
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101381C21CB1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636328699;
	Fri,  9 Feb 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlfzoRpO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22120311
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476896; cv=fail; b=aQlgedyor7ZjhcVbfC9iCid9LJp1S3cpTREsVdYlAnWDmEHcQSa3FeX3XQAdjmQ637A1jFMBSnoMeMfwo2mEMuoY6vZNHNBf9d0cjlXrGjnhHr1Wd0rtVt6PSY5+TLshu27yTOMifI0PHH2yLfi0xP8IYSFIoskS458z9U08HOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476896; c=relaxed/simple;
	bh=T1fLKO3Rs6IB+VQoK7PPFVj/Hw7Ucx/2CGXGJ6UOKis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z49xgn9uQl7nm2Lqo0GaqoX2TpunmWPiVtUcOzMwuDP/oLdy1RasvWbJEO2oHxwCn3THoGLZhsnvfB4pwiawVQCnsE28g3OYkAMSeWXpjDsosJZ9WphikpCYC0TiByCanG0VWIIpybR1anR9niIaFI+w9GRkeDIB3HXIsBQFgLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlfzoRpO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707476895; x=1739012895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T1fLKO3Rs6IB+VQoK7PPFVj/Hw7Ucx/2CGXGJ6UOKis=;
  b=TlfzoRpOY3r3zvlK2NXkaWM8w5KmkgoLtC5NAkWjX3kutiOqn2kUsI8s
   UUFrEz3NTcb9g/hz8W8iVK3yCUP4Qw/io2+/NADGRXFnvPYEVIwXTKKv1
   gqMkw0bw3/eXX3WGB/VNP6CcAdgPMLqcNRfeuKypcEwlrgrygRuIoEERd
   cb2oBabM3ssjmVgvqOOMZSo3G0MuOolweVlhWOux2rDed2h71WN5aEE6A
   LcZ7/gFhU9IpvQz9Xm4WQ0FoKw8x4+QZf3DJ11kSUKxzjU+t/huICdC+Q
   Dfzdyn3bfeT1YHXrc75eDfJtvTuKDanyBGcMlSOHky9u6u5G7PEsfYiMW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5261709"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="5261709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 03:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="6557427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 03:08:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 03:08:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 03:08:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 03:08:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 03:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnxqhskVFvtyW96RArubYHVESF+kIYxShvI1Pao3pgY6w6UN/tElqLvWkiW1Yh+X3a642z5AQCMiLYjQDPDGAj62RcOcd0aXQqOi7j8jUa9p0icjnRlhO9BXSF4+PtAqLKzY6250orXjezvyqwSWr38mJRtotaufGwkUodM92QPuEReGOGypcQOpxuqafenQOaRFfOvt5/jAqFdUDfj99KNMdKSz8embhYJHldqB/2MBh6OtI7Htn8GqzbArLzV7LdNLn52H2+epY2I2uN/FLrYbAasa+sGQxKncevyr0cs2tnarw3+rDiAXNsCEgKTWRYSE8sizPadMkmuHBip6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjsAwxQhGjTpl8zjLeWqsPVXnrgIW3L7a/RTWivBz80=;
 b=SRSxDHDUoW5MAE/F5tRzMGaE5OcsGMbT7FQPmXYdTtPLNYXUhPPi7KeqX6j5xNvKf4latMHd9pBj30kMntdz+VUmmI6h5yAcPM7Xo0Gva/cP3hmUGD6XDNgd7IRur2uY8nRkFc6+jrm1/eZtGS1j1/FGJxdl9ofwAoCBxIXyrW3r5COPcwUDY48yMIx3rOt6JKhkuD8vESO+EWttVKIo/59cBcejcXQLi49Td0qddUw8NFW65ND9tVkQO1vg8w3RFl7xaDZ0ZyvhpQH+uaLU1SRTGKmXroZyh6fpqDcLENdQU8pVwfWfkv490fgcmqDdhcMwN1VpVNqeT2EfNCZkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 11:08:10 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.041; Fri, 9 Feb 2024
 11:08:09 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: Add check for lport
 extraction to LAG init
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: Add check for lport
 extraction to LAG init
Thread-Index: AQHaSxw9ZVCqroRJREilX9FbCWcHjbEB+e5w
Date: Fri, 9 Feb 2024 11:08:09 +0000
Message-ID: <CYYPR11MB8429B8B327BD807EE4761671BD4B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240119211517.127142-1-david.m.ertman@intel.com>
In-Reply-To: <20240119211517.127142-1-david.m.ertman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8535:EE_
x-ms-office365-filtering-correlation-id: fe02edca-0e24-45ff-3cfe-08dc295f6650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8fVpmUi8pF9So8WuHJqwG0K/+WV0MhvBwBCUGv4Bcq6kHAdv1m/9gmwZ0ipYr421IKmT0CkBLYvasS6xyCzfKUUzWfB7vD3FEPjm4VXIREwaCLIKlEWkAvSFXuRquBrwx50zf0BrsbN/FWOHwSpRZhYrRszFyhjj/lDvp5j0GAB8XyPQUFsJ3QU0uXUvQ9GSDmKr5tI2qqEUXXBdkrZ3Tbkyi241NNF00QHczjl6T/xzH5DG6A2557yEo/tlbdRwfw1/9vew6bZk9RlPQqeIAOt133fh/F31b50SyCQfIB/ZZhiCStlvC/x54JpWvpXjnHBeNKJIK8w4W9lFc/NkgcwzY8orfyUidB/9hdQ6OTUSDXrYSDK9T25VjHPLeG3KTdumv8H8AlLkek7tMM89O/iSrZEkx0Gqdfrp7PsN9saHi9b1RP3NsqFQyDKQM2NujkCcv/1obaCdE1GzEf3GKVEMN2z41TVtSEr0FJ4ZJAYyrPlm5i478s31KWB6Ve3dOxjpzXznDfMWOoWqTtIfPPvV/fqZiRJLDAlixCNqO1bbJeiwKwgWEwsf3ptOyX95nP+OVK7PYWYeB2Zam7cZx4hTv4jf8/mF7HXAuR6b2HC/gslzt7nKDh9EXDXoq9b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(52536014)(2906002)(55016003)(5660300002)(41300700001)(122000001)(83380400001)(38100700002)(26005)(82960400001)(86362001)(107886003)(66446008)(64756008)(66476007)(110136005)(53546011)(33656002)(9686003)(71200400001)(6506007)(478600001)(76116006)(7696005)(66946007)(66556008)(54906003)(8676002)(4326008)(8936002)(38070700009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLnjgWtM2WPDklVNqye1syzkZEi965tvlzXqfgI+DEVqKxwJReXg2fkQxKXN?=
 =?us-ascii?Q?yau9aswWBM/IVFaF/ILHB/wJO4MxsdubHbpt4rz5PDLjq5rXZ/p3DbU87EmX?=
 =?us-ascii?Q?234jhzSUH5dToQ/b5V6B4zya0yHCI5b4J/gE29il9Uwd7tc4cBTZgTiF8Ykh?=
 =?us-ascii?Q?0qOxY2PTF6cj/BzP9Oi0TusLijQbJ93sNsx32A5a7IsdE1HcMoQHo2mdGTMs?=
 =?us-ascii?Q?vA04GEw7SeKvfh0I87mbf/7rryfdSa2M5FX2Z+1QKs1bXjDe1BglClJsqeQN?=
 =?us-ascii?Q?0swPrSu8iLInVs3iUT+pbiqnh7pZijd08A13C7/2YU7zRaznO5+bDuAr/kxm?=
 =?us-ascii?Q?2/q6QCqq4yEaaCAW8h5W0HsWXO+TSNJVxxiizrCOOASNWmlsGu+for+xWgPz?=
 =?us-ascii?Q?sC+7fpe3tPb2nFurU/OKMVxkbJ9/RbBc84rYoupeLgD0cPiEClcc8EfZ/DmT?=
 =?us-ascii?Q?tunEKJJFNagXbhOZz4xH3DqefU4EJWpgLM372otYuonUROc1Pap3Fwd5mbyI?=
 =?us-ascii?Q?2H/xbpgSMi2UmGc+XeNGRh+yxMsY6+tsQiermGR7YfNkWIWFOQdGmVhUwPxy?=
 =?us-ascii?Q?ePVlPuTRzeg/Qcb+M/MlDOv8xQfjCFBjLoc8NqRykrOMvXDc1lIKZ4LF1Sqk?=
 =?us-ascii?Q?CVSv+2WcaBvOHzzGzEIY3ml2eeNNAx7YtKL7FoaKKWmhDZvQ/bRcIlMnbZ6N?=
 =?us-ascii?Q?ai4EEYMiQKnbShtHTQkitgvsD76MiVFNsPyK89lNWbG3CPM2RpD5JjpESykd?=
 =?us-ascii?Q?VcjZnoclPlaqWDNrzZBk8VEGdbDMsQL2mVQHUDLAnIY/VmdprZjnuuYnjffj?=
 =?us-ascii?Q?UJTjISDg//H1mUAxITW2ixDQvSh9K+bBrgQ6nd9I/uWxmW7n03BN+D62GOiP?=
 =?us-ascii?Q?HyK5OjV5RmS6NI0dIKKCPZzRANwreB0RwN9PsbsuMGy8Bf2Nx9E8zTT+DisD?=
 =?us-ascii?Q?BoaYu+DsIfZuCgEzIfxlcrQ7/RgVxETHEOPlx95hQA9C2+hLOntUFb/S6YKQ?=
 =?us-ascii?Q?WAInKAekCPkMcrvH0+EB8IIPRV8YiySgEuCm2LyibTXpEdW614m+ohJgK4jy?=
 =?us-ascii?Q?CXVxMV4EyK+hcjV0M9m1DoNkq5HVLHzhWXv2kJPYKLWny0tiGyjOTTFXbQ88?=
 =?us-ascii?Q?0/uTIo47csfSYYwhyPDu+mPgXRBuwyeSEBSNKUX0+AhCPASvE2uRrwoTslhL?=
 =?us-ascii?Q?GPpgf1OJ62+GcgnSj/Xq+aMIbrgNrSYHKC2VukLP91zLqHRWfgCoiXrY7UM8?=
 =?us-ascii?Q?D1ikh+e9bu2ae7fJ6NcWpvhCdyjkJCzLEDfCB3sRZVJzQji5Yg9e1SYMAMGU?=
 =?us-ascii?Q?sX2MsbGdZ00FKvm6uik8zdx8+hhhPhbJ+giBY9DTJQVge7tRNPRB6gxBdiQQ?=
 =?us-ascii?Q?yNslElCUBCj/LceUgIeURmQZJiDwoTK0u8M+NDhaj0J4oGj8BiiQtA+sRzSm?=
 =?us-ascii?Q?9YBWzivMLwSEhQ6h3Hw7xYvC+pbfuKLBcPc0wUBsyOs8naLndacH/Ho0nuwb?=
 =?us-ascii?Q?JvZwaAexafTgbtwMii5KnJsvx52o/7jNGGsC/wQpgKT1p/bgQbPOljMua3e2?=
 =?us-ascii?Q?9VibGkxojzCD0h6KawjdUpMzJs64si8YKqSx0umXgSask0WwH/lnmtRqWoma?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe02edca-0e24-45ff-3cfe-08dc295f6650
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 11:08:09.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCNTO/vnX9smF97iUVM/eaKPDte4dkI/rc8YeCzK6BH7QSOVW4MN+axLxlkmXVVzQ1nHatfF5vqINU3ZAM/gtDq0NEjbgvo26BSxTOMO+MrjaEjobcZ9bLoN1rlKnvgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
ave Ertman
> Sent: Saturday, January 20, 2024 2:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Add check for lport extra=
ction to LAG init
>
> To fully support initializing the LAG support code, a DDP package that
> extracts the logical port from the metadata is required.  If such a
> package is not present, there could be difficulties in supporting some
> bond types.
>
> Add a check into the initialization flow that will bypass the new paths
> if any of the support pieces are missing.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 25 ++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_lag.h |  3 +++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


