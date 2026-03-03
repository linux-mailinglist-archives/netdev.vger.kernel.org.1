Return-Path: <netdev+bounces-263326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF/OL8sRp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:52:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A251F426A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CDC302DFB3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E643D75C1;
	Tue,  3 Mar 2026 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsVtTEh0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CF3E1225
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556412; cv=fail; b=a9Tz0uDpVWmh4G+DpkyRTrnnqYpMr6c8ugmWUuPsaPzyf3YLjj5SMuIF3dKApVstGivP1TSucjv11D73tKL9FZc3IEFCvsV1Wo63dK/AyinVDrJvgVTfCzQnwuqx4FhEahR6r0NlFxyiiLznysGHTSAaThizaTBl2oOe409WoRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556412; c=relaxed/simple;
	bh=yHVqGXol2SvDOjfSauGNtmUQBWROGoWWnJLLtCOopFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmEsv43AOslDHo8XgGKKdRtkNbFl2GYNFqu5eCwuFtrWmiQn23ox6h1MvanVTvM/5Y/HXtS/NmmF13rZ/++aw2utgfvcUqMv+DZ1igOOsssusLiYnPGetXx6x4If/YXPv5VrBcvFK7PZVzYZ5aVMvaPnTNQ41YbmwLW7nq5mSzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsVtTEh0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772556411; x=1804092411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHVqGXol2SvDOjfSauGNtmUQBWROGoWWnJLLtCOopFI=;
  b=NsVtTEh0wvrMD2N8SD3aPbeAqc/1+I/s/4az83h0O6FL2tHt1/iG9IDk
   zXJazV6XRTokXiyAiPjSOg4M4ARccmFujiKwXXUcvK0/802/YPR4YbDoX
   mQBkPVZXYcRreb6OVUO0d4T0TNx8gwSdRj4M4UjqvTSAYXWP4dTnx7yb5
   9kpurn4LifNURk9uUTt3L/P2zwg3MeH5WgL9/QCTPRgsPsncq/OeTx0ik
   UjtJNDFJfM2DzWyhI+WdfMjqxvZ2suYpJ9zo1VqnerQl+TaA3UTACFsLU
   Rx4PAgzjqPBa7TMYllTDmiunUrfOV7VPZ0LLHFP3YR2w3d8pQl9c+VyW8
   g==;
X-CSE-ConnectionGUID: 472oPtOyRlOEvYcYgef8Mg==
X-CSE-MsgGUID: LvYXr1zaSZuO2tcs1tC1+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73725482"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73725482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:46:49 -0800
X-CSE-ConnectionGUID: N/tRYRMzRu+lrRbnKNexwA==
X-CSE-MsgGUID: xKhqNWosRdqFdUyKfwwm6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217225236"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:46:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:46:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 08:46:48 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:46:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGGHVn6FSYOft3vlNyz1qA15xEYB+LHfWEeG+YsOKx26am46mq3bIoEmGSM9kqZosv4NmAgfidP3e8ey9oi4UPr/Ly4Fle6cg6vdUFMarhNQKDvaeS2Sg390oqqkmoM7AOw2vRxyRYudOZDlZfrK/MQY4CqIOQ/t7FRGviG+Ts6vqUNOt66uekR8GZ1EV0ws2mYl+M5qdHHWRDO2xEC6HIxLZAcX+Z8IrmPbKjELiAJ4HPVWtSZJSLbmgCUu921E4gd24SilxV42E0i5b6E/7d5d/QP0EZJXr5werXCS2U4kwqsk23tx957cXklyev5t+oy4mA9/uqPIg5uw0ViH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0ZMzbBIhqnQtL3YbeTYFsWnBYhVv3s8X5xYQz0c7EU=;
 b=DxJKbCOqFAZJ58OeTKHFN7DEme34MFcL8F8K3OL+dGjOZwfeq8/6FzbWoMD53G+R8Dgmn8HWcZzBrJ4PwbI42xc7fSD6RkMgya5dV/y0kNQ/nmK7Dh5eWK+AdhfaVwEtOOtbylZUsiKszskTma19ucEUcAb3Qa9skFAGrfmg4dsVW9MsPjeMV8IkN8cFrc0zPZtKCAAbAva5E9PzKsDO7DCfS/eiaCydEFN/is8tqVy1C+/wYx3wO7oUDvChtWfAmZp4j6pQRxHHh43ll6kq5YP4o/SPegz6PZcxWWexuXYausP0mnEDf+pbot3GgV3XsAFzjunuw5kxRNGgtUX0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 16:46:44 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:46:44 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/6] ixgbe: E610: use new
 version of 0x601 ACI command buffer
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/6] ixgbe: E610: use new
 version of 0x601 ACI command buffer
Thread-Index: AQHcihWNIw2KyTUY9E2JuCNvWJl9M7WdIZZQ
Date: Tue, 3 Mar 2026 16:46:42 +0000
Message-ID: <IA1PR11MB624198C28B4A097F01D36D9A8B7FA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
 <20260120134434.1931602-3-jedrzej.jagielski@intel.com>
In-Reply-To: <20260120134434.1931602-3-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH3PPF383C22AA3:EE_
x-ms-office365-filtering-correlation-id: ad58fa80-0dad-4a6b-26be-08de794473d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: lZUo99P6UUQOGFH8zInSvzM6dj/2YuAbd3tyrHpg01GEsef/x1wz09ounWY+w6TxRxDXf2JPOBDWkKYsnPY1vYLJ4j+bzxcMymhQdH0FNTVi+qJCY3EqgaijZpIb4u9UEUn7z69VRopSEcFttUGPkjb4ZsgyPiUuRzS64fIyD1AfXuuItb9+rLa0zjhvNRNCOP4BoJZvYcqhJWK3gvF4JEUAGf8duSl2FVPFQwdlaiK8L9429V8a652Z12Entezcf0byAItmylvlHwF3WV9EsAhA/wOpODzfT4Wy/0boo4lfGrOD6q4AeWPC5nStFcuK9DoSGbE8wOR6Nc31sicz/rQpkaD46GZOr7mSArHq8pnxrDAYEC6oQiuaQztPD3BTmqldww0pSJpWVeIB/1NfpNaWu6sxdZSochmAkjlNeORNEDIfs7bOYbcC1fyzqbISPcL2tNdv6BVCoXUYF6IoQoDzWQTXl6oIaLO8k43rd0/3zyIU6RzXNvetBe7k0tTNNLJssGZKI4gxYe/wX4FHBWWBtNqfSNv0Kie+VyvvIY+bVt/F7NfIm20rR4/0MaM+uFuxy71XHmcyK03wXHIuOedaZ4Rv+IpBKKf40XUBGkHM33dpqbhysYX556mfY5sbJ/I2HRnnthnHj+Q2KpBaSJ0B8eePF2LrOHpVZOh7g3hlPN6Ta1oMxh8az+QGhQHpbja8r7hT7JRmIGow3A6w+vpNnO9zR+8kcPoqfCcA+YzagBCs1cajyTQJKzdrg8+BYna25+mzlI2PnEdJHpjfpKtNZkgMVfsuZEyEku9II/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5T+V86OUGWg7O6fS04UMnx3iOLB/i8lZroVYGg33hal3vSkapJq1WGA4d2lQ?=
 =?us-ascii?Q?bq1fjaReBrhQNxkbSNtFsyF7+bsllK/OPmfb/jA6xFpuXFo4fLvFcea7c3iZ?=
 =?us-ascii?Q?XvjfJNJo687u4TbSSpJFMVp9g+zfIToBUPm8XV5yQ9UgKz4WhtZ7gHfIS6mi?=
 =?us-ascii?Q?naH5VQXwOgt3L8PllRGlNt68XNVLn81vyoFZaFFxEBZ0YJasK/0PxpQDwBDL?=
 =?us-ascii?Q?vNU0OgK6xVz8oacM4nV8Za8ffydYplyusSzZM8gUTOW8SklYhKCjBcEa+lyz?=
 =?us-ascii?Q?EGqLEhuuSxgjaQ07GqrR5Z67NJ+XUXK66WlKh3t6CF7b42T1WZdald0Njlby?=
 =?us-ascii?Q?gP39b/V9IkHJNl64WCUPDi8dCCMb9ceL+sBu458j0kGEvvt5uveRPy7CODCa?=
 =?us-ascii?Q?a0wA1w/9oHVIOV4m2zhV7RBjk3Rb5PFPJ+BaYon3CKuX3d36guZbuse2WLkx?=
 =?us-ascii?Q?PB36MwPuU/pc0PaXo3NqSoF0IJVuHzue73jdc1GolkS8mZVnsFXlEqw51mWy?=
 =?us-ascii?Q?avhqhEhXKxJ2urhGm1q76wd30ZHXasZSha/MlM5rbgMMTS403k3dxQEbveZk?=
 =?us-ascii?Q?BDDN5vqchb3P6FgF1tcfdxBGAhgY6Ssx9A7YAuII9KtkknkEahaXB/upNx4R?=
 =?us-ascii?Q?uDBuyIoyUddL1MHS/6W5ZujHU7kBdw+RkLU2rZ7CEd3x22GBfGxNtagrXfaW?=
 =?us-ascii?Q?EmKToH49XziTEAmBF+4BM4uHUWFsvSwwJ8rpTLmb9osPAwZy1z4k3W4y24cq?=
 =?us-ascii?Q?0p1MAsJSREAAOmxZkd2MgtPIJTGSrChzHeXUATWk4MI3PvzQK4N5bF74SKnq?=
 =?us-ascii?Q?I96OPzDWRia0qZSLOlX0FMEQRxOkEf+Qgn51DY2BuO4uHbQ+92MBAxJEtZlt?=
 =?us-ascii?Q?j2BNMHKlCeFSgvsbWkzCXhss8oSddcgFdapQ0huekGdy33UqR1tIpRtbLGFe?=
 =?us-ascii?Q?CxzobKAFJlA7C5NIOslpR4kZZoP+4greQbYppnGI16kzAAGH58L8+V6eXutZ?=
 =?us-ascii?Q?cdDaivqijEBcpViFnGcENeT9uYDhA+a//xwo/RN7svVo2T/G43iQ+snRmb/f?=
 =?us-ascii?Q?chXbDTLFnM2006lgpLLTOm3vkAu+oVY8QxcmcZzvjQBrwaKRcek+0dfjJ8gW?=
 =?us-ascii?Q?u2VFGYUPoErh3BzAziGcJ+/FfuX4xmSq5O55TQpOmWle+y9AExWXw+OjRK4z?=
 =?us-ascii?Q?7IWcpw71CttX03bQUDP/o3j1muLzZkHHiWYVezGw2NkIQkaP0lAxIHLZ54GO?=
 =?us-ascii?Q?k5vxcnY5KeaVE/DseE81g6gvAgpAfGc8ua7wWYFUrlT8F+wuwjdatOzMD7Pl?=
 =?us-ascii?Q?icNKvKD2l2l6oEInPjG6EzP3Dv/s2Vvk3RV+UNU97p39I2ikyVEWAJHsn63b?=
 =?us-ascii?Q?h8NX/yoK63AS5YSG7HEXkgwlWBgpWEplqJ15SU4iRu6CUxpWVny6R+7fwkx0?=
 =?us-ascii?Q?1574Ls60najTCRdx3MVwwircxel/N+w409rZB+WP2WlxwELUJXcwzDVnwt1C?=
 =?us-ascii?Q?myyzLeKBErzgUmtkw/S3Q04Mzd0uIhnj92+KLEMGbpJ525OmbJQpsuYzjyOV?=
 =?us-ascii?Q?aBItHiIsClrQyAkihih4QY11/LMmfukcls3a0jW0zUnQb55PDTAIV8BEmkTX?=
 =?us-ascii?Q?ybch1uFxQWIaUztx0XOvkmqNi3NYVtQrryAfoQhP7xdmFnx8CbeiwN17LRb5?=
 =?us-ascii?Q?PWkXTSVCNkbe+Y6zE6yZ7nGDKC58+VzJ2RkjCF1eMf5+M65Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad58fa80-0dad-4a6b-26be-08de794473d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 16:46:42.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bEVNkgVqtekiSe1i/vqD7SwYOuvVU0DJzdlwsvZW3e6KxbrlDMmfCPHsXZ9ii+JvQeDNUcyQi52ar89FksCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 34A251F426A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,IA1PR11MB6241.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 20 January 2026 19:15
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/6] ixgbe: E610: use new v=
ersion of 0x601 ACI command buffer
>
> Since FW version 1.40, buffer size of the 0x601 cmd has been increased by=
 2B - from 24 to 26B. Buffer has been extended with new field which can be =
used to configure EEE entry delay.
>
> Pre-1.40 FW versions still expect 24B buffer and throws error when receip=
ts 26B buffer. To keep compatibility, check whether EEE device capability f=
lag is set and basing on it use appropriate size of the command buffer.
>
> Additionally place Set PHY Config capabilities defines out of structs def=
initions.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c   | 17 ++++++++++++++++-
> .../net/ethernet/intel/ixgbe/ixgbe_type_e610.h  | 15 +++++++++------
> 2 files changed, 25 insertions(+), 7 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

