Return-Path: <netdev+bounces-284992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KuYFdiL+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:43:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00E54DF79F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D565B3051A81
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F243043DE;
	Wed,  6 May 2026 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx05+9Iq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252D3ED5A2
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092501; cv=fail; b=tz/Jel+ojR6uNPxfyLgBDTfLJZrBGRJesfijG1/BVmclfbVtcIM6TWNQ7qMmxgDp8B8obkD2dCahpD4v5Di6c0PkPQzJWKwKbBZOzkvT1QdudEGnTKjZlzAuouc8KQvxw8dxzRwujoECdnw1Iu3t28+LQ3szjFKZ8QDvhu6i5AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092501; c=relaxed/simple;
	bh=dtHKDAe+fqzA2oQFLEn1tUrmg0UQBcuyWjrUGv2Qgp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbP0osyEsTzk8/wv+QWtGkO6bUrkKMWHsWetuyPY3Q8VevIYJ2p8yzzoAzNGkbWJM2dQoOhPoOcvdT2zsMbT+KiyJH8FYruDyc+m5X3ojW78vnP4+GG2nb1xyhKH5brSfrdAXMUky4IJWZGhZSyvQBwiIiH+WYGbw2VUt8pMprY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx05+9Iq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092498; x=1809628498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtHKDAe+fqzA2oQFLEn1tUrmg0UQBcuyWjrUGv2Qgp8=;
  b=hx05+9Iq3L2TUDXfZfFakL4dT1+p8mfWJPK1cxy6YSxi0p1HeMT2RNVv
   l++HHNPPISiUgX13d/w1FeV42U/+EX/ggKEVYBHmed7V7B8VV4zq9ZKkO
   bxq66rAbk3qDe7s6eZ1vJTpYcbGOBpOXshyYoJR/L87Voa4hORUFtlTZd
   annwZK+lhf5uL/ufDcjhoFBKeIYBkdqQdf/WPjzMavAL+Gdj/b6ggi2Ga
   EQXdQRjzORDzZXHLEjI4/n6qaUIitmJM3BVkvdtSSqtT3YUwMABrrV2wp
   Rgs0wqdikneYzm57nJ4V16R8KUfrtsnyetU+1YWiP4LggZGxl0SmskWWw
   g==;
X-CSE-ConnectionGUID: 0xyg34bQQc+0GpKzFFZUuA==
X-CSE-MsgGUID: rD1AV/CxTQOcpYiHzwl5Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78061106"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78061106"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:34:58 -0700
X-CSE-ConnectionGUID: 2ghMQh4hTTiJHerJNSq4vQ==
X-CSE-MsgGUID: R5cnxrZeQiyssfDrG70AyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="229831794"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:34:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:34:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:34:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkoX8GGqRueNEfb1KEqZnTlsdySgC7iilPz6YZL+sx+z+DheJ4EEWzHN7THar2QiJTkifDq3Po+A1y2dd5CApZ5xOyrJVhofJ/5Z2uSuR4MDSOQuFLoNxCnhC8AD36uIjuX5Ha44qd0HRIxHgn1KUJGkSmAvNPaDlx1EpGeANYFXbs+ViuZwC9S5eOaTFLRhl8Ws9hOBpQiT5ghKPFB0Ioxs0Vuktv63I3wrV309Fb6GbE47VxFPfy5W7ATszcZIIlOlSNy8SKY//MCfm83HO0hV0SAc0vTjeuixMpvUmFsfaOkp+5KnWSCv3bZoGh/mXLWlKZG4ag5PIThUGlRErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3kI6j4RUYPhcFybttWdWQuwrUHzxDE8MIMLkTCDHHQ=;
 b=RVBvk4EiGx8iePhDb4qkxYD3ddkG45/RIzwCJP3FzXr/nwrvggQia+CCyn5OKGGrQjCo3HhMcFjHAWSpZhHhE45UWmZ1kIRlry0YBO0DFE4lvsGwnEsNXiUUOqqWrgKSq00cX9HUJxSOhMu3hNH/WaFZl1QhZo3QCAi1hfH5uw23b7EpnsabBraddL66woBGoBlMueCPlGhvkWyAVZvhl2r43NpAL8rmRu2aYo4JfH/rcK9QFiLgmlxM7KuaDIbYttfIjLDPNhj1OUq/kBhrgBkXZGsiYH3BmshTG+pqgW7GThqBIWutvLz1fJLHxJD7Y+EoHFEATuD7qqsIwsxQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 18:34:50 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:34:50 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Cao, Chinh T"
	<chinh.t.cao@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 02/10] ice: initialize ACL
 table
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 02/10] ice: initialize ACL
 table
Thread-Index: AQHcyCEDYGFtqZiHMkuZAGn4pTlLc7YBfXTw
Date: Wed, 6 May 2026 18:34:49 +0000
Message-ID: <LV1PR11MB879016128432FC383F31F8E0903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-3-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-3-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: 82d2f2c4-ca71-451a-dbda-08deab9e2821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003|3023799003;
x-microsoft-antispam-message-info: Duj4A7GKNsTcjLl/7Ium9orjcG5aGGJw9xJy2GnPHPB35hJhyrJSEVRUPxn0lRIYxan0XSB+S6BO6Y+qefRgzoTPFLOOxCFSvJINPLhQ0Fldqt0T9jZ3cY/Ppzd2tLcxOEIIepM5w3nuu9IPJo+M8jM8m6Jp7RHiQOI3e0MlSiksx4eopc6/z8nAckO1gFB6RJhZIHQLO9/lxts7GQjtha9xDrj8w459ipTdNVS0mLwQg/z2rANKYrTqkMiXWMOjpzr5dXHvA0Fej0Cx+6eQ3NC2MMd28rspGET1KvZdq4IlpiH2e4bHy5Xx9T3V3lwd3xDZm63one6SWfIJyQnubfEUxXSHwPKcjgtl2BxuGg81RGYgcpTW4HOPejR8R1YyJ3sC1zb/n8IchwFqlpLJNEtHw7xJVKvShOjYlPl3VCVYGWp4xB7nQMxH4faGH2tk/MZXQYjG9v8CeLtpoUpVsScAPGzk77TQ9Dqib48cvrp8X62CqqKXJ1azamRoB9Xl6Ha6KIMUQ91Q7AmkUpFk7LEcGpc6SmDXXmrRIbRJvZUUwR+zD4GnUTgESU/asjVgocTm8OvFt9V7Ev8x+VF/OfqiuvFg3nYsfmG+3mho8mTGTPIsf7h7PKnAX+4WE6lazFqWmK/kaUNcVnGwyivbHVcRx8xz/2sCzFzaZ50oOz/HJaKlBDPgnTzN1o6YWkYN5lDUCdn8gYuGmO9Os6xIpkEiWhmWwsa7mz8luJ7GGLg7ARyT6MBoWVqKCsDIrCN0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2UO4EzcawqEurn2O0Va0Nh/v06TPzqFD3lHS5bm6wNwEVWAl39NuH03b6CdO?=
 =?us-ascii?Q?WRoroQPyyVGGUPq+WDIhgf+XqUZjupcLQKzk/a6A589Fkj/RXY5HFkeLr6wu?=
 =?us-ascii?Q?WE6x2HRyfAGl7en8++SobYmMTeJ3AZBv+pl3VNevbDtxXhL0QVbFzYAj6uL+?=
 =?us-ascii?Q?7gm/yw9e9X4ZcRs+4lDYFhfDlLmYity3vI9rFxEhRzfjVRfV7BcSB3NEoY9w?=
 =?us-ascii?Q?0bFgP5RE+1wdRBUvK48aJDcfoqm22Jb28pLBeeHZbir+LiWT17dHiMEnPtJI?=
 =?us-ascii?Q?oYJloJZGbCY2rK5h4XX6nxXhKj1TtIXsYja/D1FnANp4kO+T22FZC2LrcXAg?=
 =?us-ascii?Q?EAS0Rlrn14udGZSk8FlEW4Yc7TjrNn1xecbHXOgspJOfT8oZmca3GYi2tgy8?=
 =?us-ascii?Q?PnR6dQQxznBwx4Nikfzb6HKHEOlICukGeRvRydNm7xN1nMV9YDe+mxP+CP23?=
 =?us-ascii?Q?dAXwfQZCKNpJHMTOsAJ2QLMx1WZ8Vmra41kYe2kokjUzi6piZiie3Zr7Nn4l?=
 =?us-ascii?Q?GpsQ3DxTuci7JBVkGKyvMeokP2DWXlc6OVJVkDHCevXQ16q1UPaAeUslaybp?=
 =?us-ascii?Q?gJ6mZs6LoYD/uaYQr+7lYlLQRSWAIXfKAxgrjim2ehjMm9PPgYS4mL+0vmnf?=
 =?us-ascii?Q?N8E98RoFkw33tiHnWxeFKevIg+U7Je8UzXFtiYRbEMVfMw6Jmw1AqY0VicQs?=
 =?us-ascii?Q?tCnos5kWTiI/bM/lX30UMrHWjmXnWp5lVit2hP8OuCcYSkkl9TaWaklXuQ5d?=
 =?us-ascii?Q?o7+k+slujSjVagSrmJOIMXQDDIwj3B213yect31lIYy3US6xNxFx4514jG/S?=
 =?us-ascii?Q?3puhq1ityUytubg9Py5bS44GGidFMB71W1nCGXzmQdfcn1GaUwb3+9kg3ex9?=
 =?us-ascii?Q?3YhZ7wBx+0k7pLHTnJvVpFxijJh4gPp8CCyPFH3nLVFbFG8RKH47R6bmhvnm?=
 =?us-ascii?Q?Mk1DA/g3QN6IrNWQbuPx+3BvcREdkiY/j3STHkmjf6k9uRLO2vLBIelIxv/4?=
 =?us-ascii?Q?ZemGLJlaaXxDsSoevXZa52M8ZlHBpvh+t1qLeA6Zu/hNsUkxNI0lBPmL8slf?=
 =?us-ascii?Q?VZaLf5RKbdOD4pedfrITouHW6EzSDNqqOo7y4g5TR09DeShWM+uVaW2H7xOy?=
 =?us-ascii?Q?e5fEQwrxlRfMwr5+g+K+rTNK7V37b0JGigRSr5aBvJo5pJE5Wpt0vjXANoqt?=
 =?us-ascii?Q?brztx72C4YrUtgLjGxuWeiUiXyJK9sgsyHz1i+XAR9GYTHkdBC9Lh9cDGjnl?=
 =?us-ascii?Q?zZTFay6ppGucI2g9ko+V5D8BKJzxFq7BCdn2NwfPsB+alyzVZ9fxs/4S3Hfz?=
 =?us-ascii?Q?y6QRepr6NTm985pMvN8Np5AfzrhctrRrPDvXd2rkhVEjls+5oOw+AZoDoBk2?=
 =?us-ascii?Q?tSssmjZk0fcemNjEe5dtYzNzI/SSa3/SQzCMCnEoVz5uWJoRSos88Q2wXWvt?=
 =?us-ascii?Q?aPEdDiOu97cV3pPfHqdbS7jmwQXrO3Xi7OjRsTLr6yhAJsBQNFHd/ILmve98?=
 =?us-ascii?Q?x5HFnQxqNQKJ2zwML0TF0k+jNT/tKqikj+Bv3EeK/1m5ARArb300Ci8VtG5h?=
 =?us-ascii?Q?UDwYxAMmzKo2hyV8SLgtzW2i+wGjt2bjwrKA48bmXbrBtnK55xSgiGgPBzUw?=
 =?us-ascii?Q?2GiCv60HwDk8gWNgoxgZX8nrLtCAHzj4wp7gffnk2cr4rmGwSbWTApv7c+J4?=
 =?us-ascii?Q?eJf/LXOIzVL9cAxiBFWVQNDLYrFFHfZkTz1XTFokIUZKqJ/WqYApsOn+wjrQ?=
 =?us-ascii?Q?JT/OOtgp9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oxLnJMoffLpRFqk+aqEPhJaAnsx/feXuNTPugY0XxFvmnw/r6reNBLIWh4stXs3Yvv/QSNYENtWBZBA8mZzB9+/9f+8DC8VlpqgAWgl9Qk+lNJKN81on8Gm2x818AvNv0FxqLPz0d//A81HJ999zBgqd2w+FqwxLlSc1dw5d8JI5HVGxTftT2kiZnvBGXhdw4fZybixNOB2VGvYC2A/0TT6yb6GHX6BworpJ8lkg2ApTjWDvVQGLEr1iy/kWSW6RBX60bi2cDhe+huTdkGENtEMDRhhzwzQBibA4VgqCEaLMEEF7IEt5ces8JzrSWbUZ+2Oysm/Po90e/245mtBj/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d2f2c4-ca71-451a-dbda-08deab9e2821
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:34:49.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDbEdZfXZNGHUfAp+gnFrKF5L2jU/ewUbb+mpz4/VxgmD0VIxFKttmPgmPtP8nyCyjL95GvcLvN2vli0sxAaraPTaNWFYu8V5cV0eHHh+j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A00E54DF79F
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284992-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.546];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, April 9, 2026 5:00 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Cao,=20
> Chinh T <chinh.t.cao@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@inte=
l.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 02/10] ice: initialize ACL =
table
>=20
> From: Real Valiquette <real.valiquette@intel.com>
>=20
> E8xx hardware provides a Ternary Classifier block for implementing functi=
ons such as ACL (Access Control List). In this series it's simply referred =
to as "ACL".
>=20
> ACL filtering can be utilized to expand support of ntuple rules by allowi=
ng mask values to be specified for redirect to queue or drop.
>=20
> Implement support for specifying the 'm' value of ethtool ntuple command =
for currently supported fields (src-ip, dst-ip, src-port, and dst-port).
>=20
> For example:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10 or
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -=
1
>=20
> At this time the following flow-types support mask values: tcp4, udp4, sc=
tp4, and ip4.
>=20
> Begin implementation of ACL filters by setting up structures, AdminQ comm=
ands, and allocation of the ACL table in the hardware.
>=20
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2:
> * Return -ERANGE in one branch in ice_aq_alloc_acl_tbl() to differenciate=
 error
>   codes
> * Use GENMASK() for ICE_AQ_VSI_ACL_DEF_RX_*_M
> * Use plain alloc/kfree for hw->acl_tbl
> * Call ice_deinit_acl() unconditionally because ICE_FLAG_FD_ENA can be
>   disabled during operation
> * ice_acl_init_tbl(): remove first/last variables
> * Merge ice_aq_acl_entry() into ice_aq_program_acl_entry() and
>   ice_aq_actpair_p_q() into ice_aq_program_actpair() - wrappers with one =
user
>   make no sense
> * Rename ICE_AQC_ALLOC_ID_LESS_THAN_4K to more sensible ICE_AQC_ALLOC_ID_=
4K
> * Reorder members of struct ice_acl_tbl to minimize holes
> * Remove ICE_AQ_VSI_ACL_DEF_RX_*_S - will be unused after switching to
>   FIELD_PREP() in "ice: program ACL entry"
> * Replace memset() with =3D {} in ice_init_acl()
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +
>  drivers/net/ethernet/intel/ice/ice.h          |   3 +
>  drivers/net/ethernet/intel/ice/ice_acl.h      | 117 +++++++
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 208 +++++++++++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  drivers/net/ethernet/intel/ice/ice_acl.c      | 136 ++++++++
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 302 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  49 +++
>  8 files changed, 818 insertions(+), 2 deletions(-)  create mode 100644 d=
rivers/net/ethernet/intel/ice/ice_acl.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

