Return-Path: <netdev+bounces-300320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S+GLO7SHM2q4DAYAu9opvQ
	(envelope-from <netdev+bounces-300320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE469DC06
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:52:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KdVjLXIE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300320-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB794301D01A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE247318ED6;
	Thu, 18 Jun 2026 05:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A24314D21;
	Thu, 18 Jun 2026 05:52:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761947; cv=fail; b=Tk0KQJc2ZXkAWjchCjWXne0ipnZT3exaPlpfEdM+USJMfgvkFXYP3vlNmxXR649vcn3ev9dlF5Ii8NP5BM5PJSqOup7F78UnznS6ZLft6oQRTeu86R7vF0w1Xb5fDvxm9w8Gettw2H+TU3GVXu1AfuYMZnLG/2vhNAG+38KqZl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761947; c=relaxed/simple;
	bh=TFKcdNXt93JJKJvYwJw3SIUPyoEQdkoi6vN4Rty1u7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqGP63VdL7V5Wzk7G95gLdRNIRYrrGnX+oOysJICAkFbzadyy+SAcwQKC4JUGs3ek7XtHdXkV2zJwm/aVrJydOB9KFLlsdH2mqfO2Y9FnENgqClbtvPqd/L4Wclf89v5fJwnpNb+e2eq0VhxYY61uuZmUseFDjn4FLkQNfh3/fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdVjLXIE; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781761946; x=1813297946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TFKcdNXt93JJKJvYwJw3SIUPyoEQdkoi6vN4Rty1u7I=;
  b=KdVjLXIEPpn3bfTtcB5FWB5mNW9SjPkl0ulBWVWn86zCLL00NYOLPvGY
   3qGkSBSd8KnEJyllUZAEFa2ve/df2NWeuUkUGTI2OkoUg/oRoAVfQubko
   qCEPXUvEu8LZXlKzuZrRblHw2+7KNNpH07PSyQzrjfqbL27tGbmqBitSZ
   Ljzz7+QUjRWFd4blV1wspHiy+IfSx5F2ZHE1073oVemMH/C0zV9F8xuz3
   n0M+zUbr96qT6wiYDeJarUV5b42l1HBk/vF/BOxrBtDZZm82Zh/vVPsEl
   EXOcQx3Ov/dt6b1XjbuuEUSn3YNA5vttWRbBNwQf/oYKHbQ8cRYmN50kU
   A==;
X-CSE-ConnectionGUID: OkcfXwGLR7a0lkhM6/BzAQ==
X-CSE-MsgGUID: q65PUUhyTy6XYQyI6pVB3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="94086377"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="94086377"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:52:26 -0700
X-CSE-ConnectionGUID: oBFCnaDLQKeTSH33jjbgAw==
X-CSE-MsgGUID: WvA2fDh9RfOqoCVMGHRZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="272353524"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 22:52:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:52:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 22:52:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 22:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpegVVE4eRWWnr9Vb4Jswx31mfp93RItvdZlq+TKBHV8CHsOgP4JDw6uJrfaCRwqRF/C3RoFMOojmGrY/kpkR/+n6Q26cKywx81EcojFtcKbGFMVneSAhB7hmtiuGJtqNeClUmchGmVQanWfnxY+AH60yqBsIDZMOLnZGF8Luwl91TCXWU9A3TEJH1fW0rTc7zBZhJgVT8sDSrXLsmiZlLrZ2gqTZZqh8Zf81fEUNXnLIoV7PkevY+OdGRCK56zQa/Ef60ubpdiKnrY05yXiyzEJGbNFtNIrELx6w0dqiBNJi3TSN/yU6FYDx0G/4KJisT8vN7bjwhLdEIRZGOi2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHL2CCQZjap62i/2Ew2B5pMzDA9AlzwBK5tewMgtrK4=;
 b=gQA87VxqnQydjDdSVkp1kHcn4WdGh4vD0M7zKVon6Ma5f7dTOETyPf80OiqEhXHvRPg/FaqmWqVVVf/ejtRp+n1q6Ozfc0t23Wm/I4jQw1b+icVNKzrJrqhGwLi8pQVQ4iyz1XDReHFKdI4IWHxAZWsSwQKMx6aEk/ewilIZeIKCmPBdPW/qY1EQwi8AcgswbWyz2Tg7A7NpVvu+0X79Oa+CfWQdTgPRYIPsCgvhgslIl8uMNMWk1XBk7VNnMU89cxR0u/pYht9fjF+mgYUl0CnwjXE4VCTuyKeJZIs6NgluhhkDKcNrIb6JKKxvNwhDAqLiqNNVKWnTUrtgnb9vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:52:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 05:52:21 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: ZhaoJinming <zhaojinming@uniontech.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2 1/2] ice: dpll: set pointers to
 NULL after kfree in ice_dpll_deinit_info
Thread-Topic: [Intel-wired-lan] [PATCH net v2 1/2] ice: dpll: set pointers to
 NULL after kfree in ice_dpll_deinit_info
Thread-Index: AQHc7y1+KQ3UXDgtbUmn153FjErFqrZCWvVQ
Date: Thu, 18 Jun 2026 05:52:21 +0000
Message-ID: <IA1PR11MB624185576C21B0E4F4664F888BE32@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260528171202.2659491-3-horms@kernel.org>
 <20260529053733.764996-1-zhaojinming@uniontech.com>
 <20260529053733.764996-2-zhaojinming@uniontech.com>
In-Reply-To: <20260529053733.764996-2-zhaojinming@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: 9bb87ca1-06db-4200-e0f7-08deccfdc3c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|921020|3023799007|4143699003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: 4kQHD5zJScsA6BdpfUPPxS4RW1HLAy0ZtVCAVRsv5B8a93+XEf7ERbuMgGiTMZUItXjeH2rEDATAzEyUAjpbirf5NvZqB37xYDVNwITmftmndFZkjZexuhLo2FMsxiPRG7op2yN0PfM+U5/U0EEoTELB9JL9bpkisBK2ykl6gs+R9nIzndLfwQYZIVw+UjjY+by1d421N/WkS9uvlxliz80cVIHBPmw+P8LOsHPHux1nvsNWQ3ZLKUnqV3xPrFag7qF+MyMB2niU/RwaVOeB1raoGKVWulNGoDLBpfUC2hUqiLFhcWWDl5LulgQ0IFPGUjuO8TRsHhoi2XqtgZEsiiBohndxeb6GK+Z54/KzOtDovWVl7B3hfCZEP6KV0EATshIoO2XhltUTo6RL1klpp25I4qk313FlDc7zSaeppswsCw/0xF7tLFjsQvZA94GAQBu12xNkZaX9KdRheP6Mwqw8o2gicpVop6KPXIDUn+UTyqwqONkcBWrxTvOrFn0zNkzTp4whsET6KOlpkNnaxEBzesVgNBEprhCdNusM5uZPZbOxI34B7i1T+HdGd67jagz7+C7k2lROZvuaifk08rvrBHtzxAla0ZJWIGTapkv0PfpihiWjLX7tqBpe/EsC/hniU0hd4xQYddDmlHKXPumofWsQ/gt0ZEBHAEFXUh1L7XGOG227fs3HUIPrWp+9l/oTAwXVVEtkwPtXjn//8Qp7iBGRj9qz3loyTojhbMvRpKdM9lNySsH3hR4mo/4NXPAKEgEWn9i/W3XYuKs/1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(921020)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vVH3On9ZMeYPSzk3+BM/7V3Kww7zPdX9lRnnivyKdH4/t4wIW1Di/r63/+aB?=
 =?us-ascii?Q?ZNqNWqSZl2btsYHwKSCQZjhIPYKEuxuAZcSrc3OWHE0uIaBiC005f0DxoMrT?=
 =?us-ascii?Q?pbprqyk23r32whblnJuRBMV/AOiq8WsvfTXkR0N6yMwlYaybj4XoPwhEgltZ?=
 =?us-ascii?Q?qazSdXVSqh6T1uLKWtOV+UbQSVPWrftpul77vSa1OmEpPSw5DqDtDA5fcUuI?=
 =?us-ascii?Q?HeLHh1ZEcG8TSrd0hrWzIlO9IbOMnW+rBlZKnCJKsmG85tuv85wP2wOrmS72?=
 =?us-ascii?Q?jrE8IjagohI3ESerPTdtyp9Z26umWnKpT4RSqtllBC5HkR6tDj/XpfsuqWfH?=
 =?us-ascii?Q?Kdi5eHxynbIcWdBEeyKT9Rd9NSBLxHDkuJR5+g63FF2JoyATI6XsEfdiMC4d?=
 =?us-ascii?Q?/zfEojn0W9w02IBfI2K/LFu20OOS+pTUL13I/i89HTrLB6iD/qDb9dqlv9ga?=
 =?us-ascii?Q?zkp93SzAtVRO8SXc39Uf6/Z2cnNMxLCQ1omi8BwFHbZIB+pedCXiRyYpS6Ws?=
 =?us-ascii?Q?0KIQNP2e3sxbCcIwXDhA/yffKyj9YtJvJg0bp9KUtLvPjldId+EsBNXSU+o1?=
 =?us-ascii?Q?yAnl3nKjf2AivI+jvoiPm5uWdVq1cMwRmCwIKg1sZOkOtCqFEt4Ym3ddZHd6?=
 =?us-ascii?Q?dCjMcywQzLrChqfF0rgLH713WPSiK9gIS8X57OzUrHd8ZeJCpFdjMq1N7qGp?=
 =?us-ascii?Q?kTYwuDhRVoFm40yoToJBUxIYDDEZix+JS9Gt0gTv9SsMdzpZKWbdAZwKZ4o6?=
 =?us-ascii?Q?7//Bcr0mdFJaPPa/EOBT+qeVQqFv4ogxS+yQDl4zY5qejN+2sUrXvIu9CJR9?=
 =?us-ascii?Q?tu5SEVFZjusA6Q6NxscWLaIkCFs00wsUyOYNG9tHdpN2/5X03zxqAr6fXh20?=
 =?us-ascii?Q?chFTnTL6tOOKktLYa8deG3yrIPcjZW6iqOif6e/2Cw8eUOzjqGt/nFteWWeM?=
 =?us-ascii?Q?oLMMuRFtM4ho7lfxkPIfpOIhdN/471QQH8ewk8LsCnl9SNdQXS4biPWoSe3I?=
 =?us-ascii?Q?s2sF6rhuAgOoJoqZTwBzYvLJlewM6KfW+Jzu2hWdjcYnCadpVBi1Quv26j55?=
 =?us-ascii?Q?B0vdq2y7pC2A1aqOT0ceRz3sYok8qKXPZjraOYVzbsJpS3v3is/aSvmiKvVG?=
 =?us-ascii?Q?HIJZ62Yzu4r+R8uMCUWot3qGCiWVK14LZJPk84hgvuOPCFA4pxQiQoaJd3wO?=
 =?us-ascii?Q?0dLAQgRxC7NYIsvus2I41hOaWFCCNIKRnAJFPX6VxJV0+8FvDhW1FpH2CHLA?=
 =?us-ascii?Q?HHWV4nwJXKWftm1vO/J9cAl0UhsHJNegvgNPMRSSceQwnKjxzHpz+IbxcVgh?=
 =?us-ascii?Q?wcRilWm+sgWxFxe8RgwUREm+2P7+VgPJIaVbLdm3fR0Q3Ch26XA3HQKTqQLs?=
 =?us-ascii?Q?rrb1zMeMF3qESdTF4K6RYtY2VtOnoP0ndVJndJ55ySsC8z+oBT3m1DGgZzu8?=
 =?us-ascii?Q?tGbsnFpyssF9B2fIRqKUllhUPNOKZpS7xehU5RbQ1m+42dsMU6vITe2MLhG1?=
 =?us-ascii?Q?bn4jsyYqn9VtBlPt0Kh9bfHSi/quZhkPrQtzZ1amwYhwput1kuhMxHCgU5CI?=
 =?us-ascii?Q?TByvPcBSzf8YLdboIBfyICcyiH4lLHNyZV21nZzrlsrhtCdEjBLxXIbbAtUm?=
 =?us-ascii?Q?sDFSDp9oA5a3R9pmsHRXzLVuqDPC5gQeVhiU/gHFaMJDjvQsODoqOTMP6VzS?=
 =?us-ascii?Q?z2gtCOn4T5YqGRj+aTyH+0ULhqe3Wf511n2RJoRPibjnr/BJs0PE7QhMlrZd?=
 =?us-ascii?Q?tMPSCdNviQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mE6nX0q+M0RJ+EMUIOyL1WMQ6I2dLOIyb5WLQFOLWKOCzBDWPNQ6EQr/E5ccTH/BlhnuRTQkWzu+Ee7gfmk28Qyd9op8O/lwlS3Q3juK11GS+PB/iugSpeki2UOMBt1YqqhGI4g4ucCJk8hZVaYWSXF2w+3pxtqi4LTjKUa0UNzzU6KHzAH6supF7yv58pTJK+lGD1ljcSvVHVBKQKTz/3gyz2kVGi26uUWH/HzAXvkzkqUm5YW9IWCXu7y6xDSGkgJb3OzqVgk4FHIM6ceCOVBk/SWqdyyNEIeE7xHI42VXfqGgzJs1WRipN12lDtqCUVvn2rCDDP2RKuzJQn8IIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb87ca1-06db-4200-e0f7-08deccfdc3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 05:52:21.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEEfaXXnmdrCTKI6WZvrP2R0NLa7vLuUHEa3blyrk2c/uSLEUnNwa1Ta7Drrl3h2adNF/T5hCKJqwbaSjq3H1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300320-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email,davemloft.net:email,uniontech.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6FE469DC06

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Z=
haoJinming
> Sent: 29 May 2026 11:08
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
 . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub =
Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org; ZhaoJinming <zhaojinming@uniontech.com>
> Subject: [Intel-wired-lan] [PATCH net v2 1/2] ice: dpll: set pointers to =
NULL after kfree in ice_dpll_deinit_info
>
> ice_dpll_deinit_info() calls kfree() on several pf->dplls fields (inputs,=
 outputs, eec.input_prio, pps.input_prio) but does not set the pointers to =
NULL afterward. This leaves dangling pointers in the
> pf->dplls structure.
>
> While not currently exploitable through existing code paths, this is unsa=
fe because:
>
> 1. If ice_dpll_init_info() is called again after a deinit (e.g. during
>   driver recovery), and a subsequent allocation within init fails, the
>   error path will jump to deinit_info and call ice_dpll_deinit_info()
>   again. Since some pointers still hold the old freed addresses, this
>   would result in a double-free.
>
> 2. Any future code that checks these pointers before use or after free
>   would be unprotected against use-after-free.
>
> Follow the common kernel convention of setting pointers to NULL after
> kfree() so that:
> - kfree(NULL) is a safe no-op, preventing double-free
> - NULL checks on these pointers become meaningful
>
> This is a preparatory fix for a subsequent patch that routes additional e=
rror paths in ice_dpll_init_info() to the deinit_info label.
>
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++++
> 1 file changed, 4 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

