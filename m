Return-Path: <netdev+bounces-284996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJekC0iL+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9564DF75A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4036A301A70C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC94A1399;
	Wed,  6 May 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH2s2FVw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD33F54C8
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092766; cv=fail; b=k5jkgpet6Ot3HEbPqUXLQJHNJRwFbFnJui5YkdC4ikwq8rexWmyApU0qVkXOhBLLZ29ZKi87oOrZtvaE66gscgY462wL0b+kd/69E9GsHxh4rCiXtIJsk7uVNUMmFROBzXj+emCP6aHctOYRC8JZ7YVc69zpVtCRmyPDjBlmC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092766; c=relaxed/simple;
	bh=/lLVSbKqiv2T2SzB2eF+2vq6y9hxAZERBE/reqUB1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bfnK/IfM8bk1WAxSdGRbZLJvgGg2AJKG1fWran/FtLfqhaKOEfvUvRKCMODbDalBWq+DOOvY3TLRxoj0Fkh6bmryFa0+5jWnFtkNNOCfOZ3o59keGkPk4DunZng5JROwiMwiqvUNneqUneXXlSG1DIYS1INxF+mFtcmZHG71FYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH2s2FVw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092765; x=1809628765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/lLVSbKqiv2T2SzB2eF+2vq6y9hxAZERBE/reqUB1aQ=;
  b=HH2s2FVw0NnUJg8kF8poBfwzNCufCsiWy9M0BGfV9xTL0EdW0QIzLchL
   VWwzS8cM2LsOHiTWdlGJ8ceg08KhLWzuhvUwC8lmDq9Wzkqmf4iV0GRcl
   iBnUCvI/quG+K/jc7bClAJWDFejpiff4dMrbmu1BG5YLxvmXPMqEkeWCc
   27WIGPJ5GSafAY/bIKZh+woWnHpcdbH5dKVCdzjvppk0v/qmzlPIbP6JS
   kl0YfvSorObWp8Z1QXPDryO5CYfnJpPV0Fd+c22O9T8fpjojmtUWke0IM
   Oxl63B356pLJgwGtzK9nFVfOVq2nVyq8wlMEbANFKCcTqzilcXFWOu3Xy
   A==;
X-CSE-ConnectionGUID: yJtZ2mkvTtOUqDdcPAhgSQ==
X-CSE-MsgGUID: fQGtq0D7Q6O7DRNI6Ha9Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66565402"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="66565402"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:39:25 -0700
X-CSE-ConnectionGUID: WfFXDWO7SpKF7VjjJDeFmg==
X-CSE-MsgGUID: sLnHRFl+Qc+i0YF3NEcHuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231847809"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:39:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:39:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:39:24 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnGpTNNPyLiIH39HikRTlVBlDGPub3GWHXsHVI1KKgfzfHO3vXRtkhIcASfnXzGtsiqBufR5jcC+vv6Xh2gA+N9g/4nBPizz08qdyHLWgbqb7DmQSKjITtNJRYeDXR8awadJIJ4qs7phEbUNUVpKB+yroCRRFjV5FZcTKzvMqBS+tQBY/VPntK0zrGl4Z18otQYOC08nneMt2DNKtc9fvJyssLDFUqtPtyQyNJfhwA0zCzxa9e76yKJt2n9mp9qooviUcWs1Cv/BV7HRLL247VundMyXYYB+szXlfkp3vkcFXZTSJQDeka4g3gmo7+b4B1zkbdHtO0jCPPxIb/ghUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwWhQgeEUFaQmjA9kxb8zGcT6RCIfh0YbBW1xBy6Q+8=;
 b=htF2qw8eBeRx9P9Y2LRSw+b1VwqDW6uUc0M0rb1iJGLKe3O0jIH38dRTyEK12+k7vproxRqu1egRUdQnbluC7qWI5sCyqlnaK3euoP74XHByy5wlnebTdWnVI5h04cyNysX5U5nac8/Gecd5AdxfxAy1NzIe/vBHGVi4pxnVG25xLX32KMqrlgIpcZglyGK1LQ5nX6hDRrg3xUqA5pn0hXnPrHh4wD5ivEcnqdwYg6A1HsQFyI3tnv9AIjzBrySenfWNwjhKzAQTINjQFQikViI1PcRz2Zqr/G6k1YRa6juGleBi9CCi4j+gMGJZz7kQ99AgM6Oh2eNQRen/HqbDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA1PR11MB8176.namprd11.prod.outlook.com (2603:10b6:208:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 18:39:20 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:39:20 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 06/10] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 06/10] ice: use plain
 alloc/dealloc for ice_ntuple_fltr
Thread-Index: AQHcyCEGBmCLxkaEcUuRhXmKKSurtbYBftTg
Date: Wed, 6 May 2026 18:39:19 +0000
Message-ID: <LV1PR11MB879069E515534F2D2C6DE576903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-7-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-7-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA1PR11MB8176:EE_
x-ms-office365-filtering-correlation-id: 86ed10bf-de39-4b03-5b18-08deab9ec922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ck6WvYeEmI/DzuY83XWniEsbOtFEiK+XoLQEvD0JTWlX1ORU6h2BPVeZ2HL/PlqKFuDataUlREkkdbbXwzIaff7aw2fx9FIsEhe6MMNnimRwdLiyWbahw5SRpbZsiMIZ7aQrSiayWOrGphaaknTeY8wRTsfcMGP+IJf7VK/FOBkI8gQp2H+0Oahb91koLllcldg0uwgbgqUNvoRpW/YOL6PpM0tj2q09X5wIUuJVQq/BjzXajibA5r6lhVeUHn23RzMLmYQOc6dzXzcwLk6h//iiABrV+4mF9ZsJLbhYJnwojSQyJ0P63GVpuUZV0U6IsQHjO4t8IodoaUuZCHj9r9hIMweFkOhpzXqV1+lSHg3MQhBuPYnTxYzEupr1PrYRlgwl0LRiC6dFdRz49u378/dBs0vvZCbdw3YGK3mgRH49C74LwJYm8/L4zX07FC8tXY0ao9RWVUtfl1RBwpoO6jynY+03W1EnixRTVJc8F1u4pjhVGmAXfcD9ScQQLNYG/pOH88tVWYyPfNt0u/ni/jrxMqIaw7y70qYzlaQZtxeNo6v+lcxzjyfp57i+BpZI1XcBOz4Ny0XJAdXiWiAzINPwWk+HghZAv+IoZGsipGhN5iy3nIVum2RJjOD0QmCJoFp/7t5Q6HHzrUcwhzEZ0JCKIZPHe7zximr+QitwTxrY1Sk8f1e1lM9MswsubOGmSm0Ln23sBuI3/o+nWR0gzGzWz6tOVUMDxdKRUfz37YERQd4KCFM2st9WwVNTUEwo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLWizUE2skxW1pSxrxudbwrz4DwLPpn3wcFTLvzsWQ8G0SDS4DA2S6HH1k1l?=
 =?us-ascii?Q?F01vTtGi/3ksmTWaNWlQ5UXxdFR6E3HFcemMgA7GV/RRjH2gUyS0ocKYs2kg?=
 =?us-ascii?Q?9rZ5Uf/VbbXWm0nCiPzVGnWyNVhBBmD9eB0LCvRbNPkLXHEdDpMJs3YmLVuM?=
 =?us-ascii?Q?88rsLagKVIYpJyl3MYJdW/YkSJQDUD3AnrcJumJJ69CgXl8wQmY/M5213ukf?=
 =?us-ascii?Q?p+Tpg1LDcmkzhO8KfnINooZGTI3sMK+tgQWy0M5RzqDQyZfleipwLNmXexDP?=
 =?us-ascii?Q?oFQbEFUGEl4xZmYRvifGLc2mxnwHeEP2Ao/y/X43dbjIgwfaKZzUcVee+KR8?=
 =?us-ascii?Q?px2iQ88f8efWq5KHaXuhRqEPlQKAiPh39vo2lajKIKnFB2ElzqNQeEI8EfKD?=
 =?us-ascii?Q?0q3qNZf9ZeSIISizyAS6WFU8jCBWL9gtbFmbnU70rgo+CbcIxI35695N/9dX?=
 =?us-ascii?Q?FNEGBsse8eFAr7qXX3ipO0qW98GnZkgiWxb83HMpRylKS5pGym31MpJTy+KB?=
 =?us-ascii?Q?uGitg2RcMVp5dZPsP4pUwl1XqsL2z21jbw77doGjAjueB2H+XHFHdQBGWUSr?=
 =?us-ascii?Q?3GxBBb7Tkz+Oa3qwGWErKyOGtGuZcBypPIVnN25tTpKyXyybPN07rXphVamY?=
 =?us-ascii?Q?3/fK1spBMjZyuNT5H8Xjx8rvE+OUrHygCWZ0TxnguoYpFwQ/fwdFJb3YCM+Y?=
 =?us-ascii?Q?2xjVLuAwHonWFOMtI6EX1HZpIQzsuccK/2+0siIZ5Iz5xIewqqe39NSmaj7L?=
 =?us-ascii?Q?nLwmAlmIdCunvjsviyB5PKQmltDByXkNJOqtqyTdXroyiXANNFZjfD68MsB3?=
 =?us-ascii?Q?S9Gkzs12/jJ3TDvPTCYP6h4Zom/nzcHBLyNob2UNdzWoo4qTKxHh0HFSnb5N?=
 =?us-ascii?Q?Ik5NS9p0yR1yonbHRUcr+TEYtvVKcUCXEoJj5ShOr8TMqMRDitB1Ot1quodV?=
 =?us-ascii?Q?EqVpGZtB2x7S0t7IF0U/YQTeW0rZj2LD4sur6BZuqX1OY9ALNxYiuf8neMrA?=
 =?us-ascii?Q?5J32FDh1I9ETIfmVz83JY4mIv+miLEumixUHmB0QrLmFLWLfjzPMiehzVzvh?=
 =?us-ascii?Q?jCIgK/rsabnwoG1F2zOa3HGZjMYo7RR/YBwg41b5LbUa+RgYmIxWtycFsyT6?=
 =?us-ascii?Q?9rUI7IFDx+ycaZIuHTgegz+j7Nszv2RWV2LtCxA3KSgTt00/wWbt/K7nDYyg?=
 =?us-ascii?Q?VoPw10DhjxI1eq0MIK3w55PKeioGQ+dwZ6GwwTt8dXdOheA1irdxt7ydBPPH?=
 =?us-ascii?Q?2hBhAlhUb5LkoN4QYU7QahW7kniEEJzSStUj+DyhSDSKuxjduMkXVJ16cnEz?=
 =?us-ascii?Q?eQ/41NbusIukWJZwtDp7CFamM6bk6QtfmMTdtW0nuqrq6jY9b79ZRPp0gxvM?=
 =?us-ascii?Q?jkLqMBSpxbYsfzWjg2Zpr7WhqCUIiXRtIj9bSIbbaQBKgQ/eY91UgT2Mitj4?=
 =?us-ascii?Q?S4QJQu3/I96QnENsYQkkREsX5u9Q5I48O0W2LScpEUkie2icQFYSHxq1496p?=
 =?us-ascii?Q?1gXpI2uB9JFj953Zd/W8bo4J/X2dP5Yi8pY9SBANupZl0soHLsEz6ewRsr+d?=
 =?us-ascii?Q?gqlpUUop65cvZgfrFb2gxCBSUohzN4dVSgxAS8dHbEcPSf1iYVCLjQp44WQk?=
 =?us-ascii?Q?oiIM7D6ahHo5ey1FvycCzI2hdtV36VlkX1C5Eq38630s5TF8/AUrHRDWsVeR?=
 =?us-ascii?Q?v4ldO1eyEGQsxwyiyairDx3noP/Jm7I8qVfh0pu7bMwiwmeFjcyAxJgbWOmR?=
 =?us-ascii?Q?wP1UxDrDcw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h1Q9XRT3LDRGU9meTVWSEVfK0YolCV0xyZPhmMnbkPftKs/KwTkqH21as0BpWJGsWorv3LhYsq5WtfoTdNHTwnPR8xXRkzjv8ajFPH93EkGaYRBdf5mmW5gouJR9odJOXGHZcM/KePtM1ev5PUVKk+FbnTfrT+TXXfblwWPjib0D9GM+CbzWrhD1fu/R24IOvt53uXxQZ6q95fKW33lUtd6JQyARS4f6EMPaTHU3CputtC9o+SaguJxbMCfwJmKAJD0z6PAqnTpseLD938KAS9Ru/grjyIv7+iOXVfxgeY5aAydSOrWzQ6bgqXiRRjvBhj22VCmZ8H+3vNa0mRJpgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed10bf-de39-4b03-5b18-08deab9ec922
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:39:19.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nD+i3P56635NsloYmiFzXSK9I/mtTd8MJDRUOqS1akyhbL5DDhTZpaceZGaTcSfRAtdKkS8Mt12A55AGM8DDkVw8XQrY1OT4j6yp1hUlNVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8176
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7E9564DF75A
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
	TAGGED_FROM(0.00)[bounces-284996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.543];
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
n Szycik <marcin.szycik@linux.intel.com>;=20
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 06/10] ice: use plain alloc=
/dealloc for ice_ntuple_fltr
>=20
> Change struct ice_ntuple_fltr allocation from devm_ to plain alloc, since=
 its lifetime is not tied to the device. All such objects are being removed=
 on device remove via ice_deinit_features() -> ice_deinit_fdir()
> -> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs()
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2:
> * Add this patch
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

