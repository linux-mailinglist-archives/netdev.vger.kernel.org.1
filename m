Return-Path: <netdev+bounces-270362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP/+I0nPwGm2LQQAu9opvQ
	(envelope-from <netdev+bounces-270362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:27:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0C2ECA73
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A4DC3002D16
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 05:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15087288505;
	Mon, 23 Mar 2026 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf7Yd3lC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E78158535
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243652; cv=fail; b=XOLIx+7QJLqXJDddh7UwCK8aMK6YJhpW48euxvjGO4l8YRQuRfbNBijeL+x6VLLbjysoqiMx2dQW9wYhtleYKOAXkyYJeEXrvlX0zc+nUtka41EvFao3TJpP2lQUNlr894eujxncLIKoJ8R6XZ/KcvCbGtfpCYRGcJOc1rUAuME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243652; c=relaxed/simple;
	bh=LyTECMG34S/7mgoNDyeDU5LrvgRE16bq0eIeAXCoddA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvuKdDyrq4lerfLA6jocRzbESj6lizMHWlRQfrirZPAJWX7hRdxpbWw4rkzlZ/EkmeY1M2BQBruvAFcY5TDbxbw62S9DM8FAitObNK8BCbE2xoO3u+ZWru1FTQ3auKfsHuICfV/eIo3r6l4dT/0KSYKTK9QJ+NewynpTu4Ov7EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf7Yd3lC; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774243650; x=1805779650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LyTECMG34S/7mgoNDyeDU5LrvgRE16bq0eIeAXCoddA=;
  b=Gf7Yd3lCcs1uPR2Z0RrGHGGN9r/a+NLgnQmPI+R/Ikmt5cB/6tGWEmg9
   EIb+CcwhXYrDMk9nX7AZ/CnRtG35D4VPKxGt62yd4Ypyw7zyQNf8gcy1k
   YslAf27BTHYYJTRja00qZNiU1YvA1/1SsfFc5y6K5iHvS+/Ccbeo7m9da
   wH755I073jwwuRiyV9TGKl5OwTMTm1y3gbw2W2bUV9izYKfQCWPifouY+
   ubEvWI22MEhygNuHW26mAEpqZvRwd8TRKPNcIiiUA+CdtDnxEur+gw2+3
   xfsBz8bzSnJzeUPgYzAN7wVsU/YxImQfctuz7LMUdklP7inIQMtzAntev
   w==;
X-CSE-ConnectionGUID: tX662YZFTwqBDi/WZZGjQg==
X-CSE-MsgGUID: cdMOOAQ+RaWi/rQh8544wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="100689233"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="100689233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:27:30 -0700
X-CSE-ConnectionGUID: bY/Nbi7aTOmwNQN/qv6IaA==
X-CSE-MsgGUID: RypaKE1dQ9+NKkN29pFjqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228842987"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:27:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 22:27:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 22:27:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 22:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf6wCXzc9RPfj4bO4cN5vJgfYN0AHn4ULA4M4XQ2ub5q+exDR4Lni9Yx1SfBkTlpCb3ykQN4XkMML1UoF1QIo54MTJU8qKBs9O2fs0UY83qn5IaOBtJanjmnjDprSm0abROwpGL0kDsohf3dpEAmOP9Qo6QcZpBRMbyApWaga6NlSSbY99mANoOJOl+DjU43LV29+nypjMvUrdKauCZWOBPzwTarjRcKXmGe27IHig7ibxmjt9+Phouc9dCIAuC7t2QLLOFGCX1yjXf3OOaHBUQQdVeWxGFbFWQWKi4sT2MGqm2TzVaU8cW96iQPRcVWVC/GqaAQYauerRiNd5HqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYIMtXX25XbwT+M2cKvK7DEUkY+jXHqznBFZIJbJ+sY=;
 b=AT/eQQ60xk0tj/6je9iGzOdbf0v+eOO4yEdd0gWC9mx0k9JcNv8lYq5YQ9mbVb18u7lDoiGdBT+MEfAJZRaGNlWxZAssvySR5y4H/FDIbDHn3KoZOo2XKw7fqjvCqVOI8VWbLc9fkaGU960l5wZMdHsmjxWK7vnacqAQ4ux9X4RBZgZSEyXsn5A2KQrEmnZFz17mDMu/jkQuBh0tc9JwfFPtNy5WsDfcQBnHWUeDp3SkWPzkAbLNSlVrJU1qN2gR6OcIwp660RZZNbLrDb4uIrEGLfYfjIOcKvWqSj+tg5ebtwDOPIMtZCIrD2SD5cP02rtZ9rietw26QqlOhpP1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 05:27:26 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 05:27:26 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: fix unaligned u32
 access in ixgbe_update_flash_X550()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: fix unaligned u32
 access in ixgbe_update_flash_X550()
Thread-Index: AQHcnJY+zz3w/Ctk50q4kF1vX3vi1bW70J5Q
Date: Mon, 23 Mar 2026 05:27:26 +0000
Message-ID: <IA1PR11MB62412D2B51705B216545E65C8B4BA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SN7PR11MB8263:EE_
x-ms-office365-filtering-correlation-id: 3371d49d-3046-400f-6e64-08de889cde76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|7053199007|18002099003;
x-microsoft-antispam-message-info: KAZ0owZ04lGVoSQgcihuca5M8RPML1JD16VtQK7a07laTOnoHcAaCabjcJ3nCMwcskyOtf9dPWRfjTmkYKhBwPJ0Xzfcbws86ZJ2HCcB7jPQvrLpUbWTiMoVwCEUk60OR9MxRHlTWsXb7fk+PZu5eSbi5fHh986/0hepdbnw/PFSLLdw+PQG8+ol2IpK7rRVD+6fjptZFmKRwtXn0zTY/euB7NOOyOAT2bst9ICrvimSD4rwUXk7sSWFyHZpxz6KLTehqbYs7Dz/6fKjcoSF/nDz+395hNfxSSzT33LfbFQwHhjHx+TWOzVCGDdhz/hgc2ZdywQFYyDqs5iylVylkUcOhCz6TVMwT3okILy3dq1YRJ03naRG0tfSjLUNON6JoXL4XmEjSeSWUVNXQPLMRzrOIZSj3rDQ4OyIqv0USdn7ZYkxtlshjlbTAVyHB9snKupiykWWtckPdUpCp1jc5h67ogY6LyP2wvLFghgBTwDsRa+VnRIRKFQ65nBmmx9AMHgE6VNO/ABZMXjlHXcB2+BkqzPBm2hQi20lKpX5WHTL1wEXpDb4Axqr8dU4TJH3vITTBlgXd+XKA9c6yKe3g7N8QwZD48lB0PlrIkEzGFl90whIni9+L8PDji7yC2MEtB96TBDMYwO6+UPAvolguuZRADJGqRsuFiYTl1Gl+lim5YnSygevtQvdGcCvnU4ww5tl8UcAiTSBUgLAhVs+4xuVheu41WMVQT/I1XN9+8dGxdLku7x8RGzVsiuwQ2Wo2tMiTsftphum1AAtAu9Z5au5qaAoLpmhxxNseGbAn8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cdY4RAQ26krwKo8xLUcREXVlwt385jiD/ZSp+Jjce95zHaGkEnkOphhT+3a/?=
 =?us-ascii?Q?lI9ZIEm5p0EoT3IJQT54LYYICjWwzuT7xRnQJhJIXT00GzZ6rc5/mp8Y5K/X?=
 =?us-ascii?Q?kUx7bYNlpVfDZTC1JK6AAusUDAJfCComyS1SUoVMh+YfnPH6omLvVbzxXbus?=
 =?us-ascii?Q?QhnppAnQ8jDCCYSwMrpxdqF3SrFkYRmbwQPiuJu/ftWTYZbJ/lCodgjhlJUR?=
 =?us-ascii?Q?URfnYaLfupF0MSPPYnPfAWIweoslINdFWZXTcC2wkyuOzwF7RWqqCzqWsPE1?=
 =?us-ascii?Q?4oMcDgA9VtqhWLJ8obElkKEsBJtN/9EUXzoM1PBxGHbLV+KeDjK1LX5gGZ7h?=
 =?us-ascii?Q?5FMf8MHZmtA9TLix8b12aquGAx+szRtNZLU/AAICWkF2yq4nWxuJ7pZDtDxQ?=
 =?us-ascii?Q?rNtIBajdsQoVXb3F4cbhjq+Tqml9Ao8Uruaz8l6mdYJWOS1dzT+txGy+yXnQ?=
 =?us-ascii?Q?fChwTLLg/J9E2gygOV0v6NQxQUD56t6JNFY47UC1NcAp2axw8wW/K+gXL6Ud?=
 =?us-ascii?Q?9IG3OGcDX/N4KtxkMcK6ujbZb/4b0y4JRpWO9EayYrpz/8ZxsM+DZCw8FrcV?=
 =?us-ascii?Q?AjKAiuivfPoX4l8Ud+YWXsP/u9pW4d4DlJvDgDSt0XI0nLm5C8S7AY8kdrR1?=
 =?us-ascii?Q?OxXlO1MjA1PesJjeUH6vpl5tNAYQevB45A4+FDGuYVLF6SP4xFepjFlDq0Dv?=
 =?us-ascii?Q?vyDooiabP8djDL/fkzeamaT7z2+k7PiEAMPkAK47f4IfgRPoVIDmarFscApP?=
 =?us-ascii?Q?lZ8RWFeeXT1pXVJPxGgAfYH+ahdW3Z6n2Q/JBnrDzS2rSOzczLmS+LTGOFEp?=
 =?us-ascii?Q?8p1VedHC8XHdcVFJ/sxhDYmR4lSsWy68QzC7vis4tHftSs/7rJ/Ss7ji7pRp?=
 =?us-ascii?Q?smjBBvevvu/8Ey6Yepdo9FPQVNJ1MZfhRyzJ66ImWoykiCqCorAMk5ekwdpD?=
 =?us-ascii?Q?PWBwllYK0s5sD9hBbpkQ1ww0+BT7+ufCKkYfW9ZoawNCbMbUqCgJS1/CV0oS?=
 =?us-ascii?Q?J+/6OXA+qDvaFEwJnQLm1zxwUf3ZiJd6e8BPiDhEfJzhjT5OPPFW3v7HCPGA?=
 =?us-ascii?Q?mKwBb+6M3yPs8EUgRIwXlr5GT3dGaOMZ9fFgZN1Fdc+e+0EhAIIWnaqnzavr?=
 =?us-ascii?Q?HKBaC1tUF2pExRRnnh+w8Hahgcl7kmlHKnGw3EfQUnv87Ec7I11a2SDKLAu0?=
 =?us-ascii?Q?Zb+QxJmSGm9KHhW78Rt1QTdSGPlZugvpLt8I7yINtMeyfUPWpQJlLN00f3dA?=
 =?us-ascii?Q?CiZs2gs8nIcrYnboDYmWTFsjbKvN2g/UG6afgpolqMidg+QSS1qjy665fKJf?=
 =?us-ascii?Q?/bScFtfwlDOjms8DSNRDr60O245UkImMnRtunePBqMfZbkOtxe+k8Z5raYNS?=
 =?us-ascii?Q?b8chDgB041E1eqQyU0fRH2UirJqrC7dPjT+9b6i4JY4fqYkbYUjqqAJbq3oi?=
 =?us-ascii?Q?14l365OSHpygtvunDTAcwW9nEI8QVo2LwePtpdE9toZUtBnbl8FLjLp5xSvp?=
 =?us-ascii?Q?tQdbuZ4eDKJPEQGNJdNE1LInS7bB8jzJZZo1tbqr6jUmWtm2BWuHDLqv84FL?=
 =?us-ascii?Q?BzHWrPBtLv/QVZ1/hV4+xEKL5h7H84LYSgR+iR9fj18S+jrQ0rTyvBm7y+xq?=
 =?us-ascii?Q?uw2NnLPbhMTWuQ05aujRR5hT/oehEAj51uRrGK8gb5/AuxTNdfSKwqr1nWsY?=
 =?us-ascii?Q?3AgrV9jhqGaFfeSxzaxG6QS+p/B95AvImM4Gx4S7aeFYS/a7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g0eoLZjqm2sCpOqj5oPwDyY3GYctUG+R/vxRB5WLhTIhnsh0Nw7BvkWBWJ3PrjnolpHU6mNcqc4hpR49J3FgTMuPi394zqOWq+68wTlqkfhydgPH17I+md4NW1XpSAaO8tT19qfwMbv6Tzl/RWdkpx6XRvIMEOlqoHgJ13CQjX4mqm/OhEGo9ge5QHQk6eUQDokK+gKdZu/b4aBs2MwIqANBZulC1/K3r/hG8cWJmxIhMKCRhtD/yt1Hu6ITtawMU8wMMOCq+MLmTrVuvd0AaaVxOXGIuCdBm1A7xvTqcSz/gnvfp7xqhc3Za7pvZN4gTBpvl6Z3uXwJFCkhIdOcaA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3371d49d-3046-400f-6e64-08de889cde76
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 05:27:26.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZgM+gLJJhCo6xG0erbub7duI5T+V/KojxnkF8exRRmxJ6xrRpOo5OEfyjUrxCyVfpFEk1sOjcs2J5PoByR2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 95A0C2ECA73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 13 February 2026 08:40
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.c=
om>; Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: fix unaligned u32 a=
ccess in ixgbe_update_flash_X550()
>
> ixgbe_host_interface_command() treats its buffer as a u32 array. The loca=
l buffer we pass in was a union of byte-sized fields, which gives it 1-byte=
 alignment on the stack. On strict-align architectures this can cause unali=
gned 32-bit accesses.
>
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte aligned,=
 and pass the u32 member when calling ixgbe_host_interface_command().
>
> No functional change on x86; prevents unaligned accesses on architectures=
 that enforce natural alignment.
>
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2 -> v3 commit message line wraps
> v1 -> v2 change title and concentrate on alignement issue
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +  drivers/net/ethernet=
/intel/ixgbe/ixgbe_x550.c | 2 +-
> 2 files changed, 2 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

