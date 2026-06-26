Return-Path: <netdev+bounces-302106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DLD8KEkgPmqWAAkAu9opvQ
	(envelope-from <netdev+bounces-302106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:46:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6736CABD1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HnIyF5WP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302106-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4077E300EFA4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9A3D25A2;
	Fri, 26 Jun 2026 06:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985953CD8D3
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 06:45:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456357; cv=fail; b=j23Kis3o5eAJL71bYlyE4oLie9XYMA4ruUPkFxGm4jlVz0ocF4Tf/HO33qfHK+LarDYG8H0AnMk2oWtmaJwoKCT81RJgukguWO12sMJ7ztHp6hExCGd6DyUeAJBEnkQTXbpcliqpzwJHOxLa9hLk05pwESwTJombF+miyWp6If4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456357; c=relaxed/simple;
	bh=IgdB6SP487s3lwXv1rSbLrMweT3SXdtfuYE3Y4OyWQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5yAnHoIJFIth/dKFAgu7VKs2oIn0GsLd+aaTHgtcc6IgFcVpvasYwZMG75POQxHNxGDM+dLtm6KoDiX7JfHT/T//1PDjeWXGU/ANFPZPGzQLOWenR7Bz+Mdl9OaPObt/z4RUPCDbtD8LZQD+Evq6BhNiV4RKCjls3clie4JXbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnIyF5WP; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456355; x=1813992355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IgdB6SP487s3lwXv1rSbLrMweT3SXdtfuYE3Y4OyWQc=;
  b=HnIyF5WPzzIm9i8sVjM+O1D87NQyajtE0inI/HMPFXw2HYuVE8fsIBhR
   EPCj756NTydqbWtyuMVtRT+GYyfbDp+XBFgvWrhQdwSPg8KkhSwe3rH50
   j4kthN3K+LzKmk2gX/S26OmmvQtUHFtTpHu5nb9rm1fhklUUjxNWahw6X
   ZWczmwBYYszFuSIEsbYI777Pmr0Q5tvUoGMUqRkZ21+F3YXD+/hFULeVD
   spad+5kA/+ToP0TMoW/1wu/YSSHXI7ZVHQ6gehMuD3t1h95EYfx4ty1gb
   qN8X+wAfblckjjVfYgJUYtyhOVvOpF9eG8nagrKuVyGwlNykQxRKYZ8WX
   w==;
X-CSE-ConnectionGUID: hWJ/cE2iS9CgdOFTPBf8kw==
X-CSE-MsgGUID: s/dLMctVTTWSRMol3jn0vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="108795636"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="108795636"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:45:49 -0700
X-CSE-ConnectionGUID: 5kwrQyL4TBOrESgIAhqvPA==
X-CSE-MsgGUID: WUAhCvQxR5y+x++mJirFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="255245202"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:45:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:45:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 23:45:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGltgGTkNaBJejj4MpV0iWrazBdicV4UYUs1g+TmY6JS7ekzzJ1CctajSctGx0OajkY8EHBILhADkQmjb0+lfjJo79fc4Oj2HJt19gEPr1b3WdyW4SUxUIEsNcW84FJNAgdycFpiA2gWIl1XjpJwvfOCxbX4L/7vZcTUMzSrH32T5u0zVc6S4R6NNIXSzrgfSKWBvKBIlGrBv8ipY8TVAn7jLzuDapXnkTFx6wRRRg9qyqM/UBVyhYl652b8E6gn50qFHbaHBwQrthBk6ap9YbhFECxR2l2ZGuat1WHBFYXYlz2vxquYY/WktiwAvVyap0srQz4NgOjXhLCqTFrHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC9h9MpSJ3L/6rGJlIYmgqSmRDxtZLAYlnM2Jxf9/ow=;
 b=oLkupEZObvCr/9cxJxSvke/ta2m3tr3VKFo/StDMMwBTOPnK3vXxNN682z++k5ARGVYOKcPlPy7Xdjwex29nwlci7TF/4qlL+1bpH9BizC8MmYrJ1pvYeNQXgYOo3+wVrovZ3m3tpt6sTtRTIJSIzXhK6oz2pCuu3FIxt1kiPuOXLBhigiu3uT9+gVvgWf7TOp0368kFRtTiOQ3Mr4m19FaPIEEHu9bWQOZgAu795A1ETVp2/2A7CKBDoWeUV3pBRqziecH+3PlX77VGFbOysCOex/jWzsHdcI35zx6SogQQHjt84jjDQGtsIg0T53YHy4ES9gA718l5PmCvGSRuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 06:45:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:45:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 net 1/3] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Topic: [Intel-wired-lan] [PATCH v4 net 1/3] i40e: unregister netdev
 before clearing VSI on reinit failure
Thread-Index: AQHdBLVolIph7753AkS66xOuFVusQLZQZV7A
Date: Fri, 26 Jun 2026 06:45:46 +0000
Message-ID: <IA3PR11MB8986EB2317BFF39C9444F629E5EB2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
 <20260625151431.1102838-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20260625151431.1102838-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8484:EE_
x-ms-office365-filtering-correlation-id: 6bbdeeb8-1bf4-4fc9-beba-08ded34e8d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Uq1Tv4WTbhnjLguFh7yOTvLHJPKig8nVamCnVc5QTAMDVGp69pU1Vk1lsWgt269VNlVH7yBH5POc8DuWmBn5StfyNbUXa8M2ENfty+G1x925MfMVMswsecQ4RZY1OFB4fOVl/IJM1G+SuvA2lTQ3H/llI23yQ9GZwN8ypu5buxQY+UoGXXm1mmWdrHjzz8fzUhUkVmkmUa7rs+gQBX0nCfBCjbk73NAOxOlmwQrzlO9YlFWpBryg0ms1E9d0JsBszuN07iOitd8Q1Nfq8+OVSIP2KgFgoWWm20oLrzlN/bKaL8xSy1SekJNoBJi6lKvTojwlD+jNrCy4JUvPl0R447aw9QE0y4x9AsTBClW4AMi34IJdP4tWBPsH/MnAihvIaQB3sjngEn0jVZcpMcYy/Y9i2t3ZWawsWHn95eLfZvd7NnE+yjBu09e/c+M1AbMMURWizc7uTA3CVcKQA2wI4Erd11lg5aZGYZiimJ5o03/abjvD6gFicPP5fFoxE2Kpu3UrDmTMGzCRIt0D0dAjts38pLl5WoNJYohe20tczah+SKxSgP6HxdhGfYxwHJXUBHiYrRyE7mtpanghYQYfXazniUcWAf3eSEIp7LpaUqzvYADqWipnBw01xA6CwD7rh/tumayNNDEDHFQqsC1eyCSVtLPcZvNAWEuhJB7TaREgYNLMrTK1rnovi5Rn73+9jjIwH2q5fMaizEPyp49SnDO/ICCZWxxB/HE3UjVQwi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m1drbGqet87SA6pmuk+Y4ti+uabcxdsrIa08EYSSws0InpKSdNNFcHV+W0/S?=
 =?us-ascii?Q?n1Ce4cdMHaWwPJk3AOVlCQuRetWTI1CHhwAvYBSQQ+RF+/EkA35G1EZLqWsQ?=
 =?us-ascii?Q?CugyDa2iTMtU2fTey7Hh2RSfc8KzpgrOKrrCm+X/1rQ7ToBxR3rit/10n0wY?=
 =?us-ascii?Q?NSZFwvEy94Sa4Jb/Y1kjIz/tCfpdQzzyLmzqU2XmhORoJhRApnq7XhS+tF0/?=
 =?us-ascii?Q?THd7J6olfUHPKM6oAYhsJEd65s293qV6QpxX73jyNkBiT/7h9Jd8zRvcn/EB?=
 =?us-ascii?Q?eE0divZVfVXxvi1ZkqxGmzoHqzXJHpTyphBInuxieA83quHt9s58oYcrtyJa?=
 =?us-ascii?Q?q59ECF3Pv4o5UWdgF5j1xUdfRauITIBOgar+OJ1EIiURJajMpdlEYZvAM1fc?=
 =?us-ascii?Q?K4rxmvB8VrodvW2giwVEYVLLunYYhN+EAmaiPV3g6DQhY8CdMHDrd9kFW3mx?=
 =?us-ascii?Q?muL2ZuN+z6wZWM9tgpCGw3tiAe3A7ONQJBz2eYMYzt6ssdUGsgFH44L8bPSu?=
 =?us-ascii?Q?+rsExWvDpCLOIDyUU/g4P3c79crEqZ2El4p/sc0LvZqcEue6W3Faet1fj7m0?=
 =?us-ascii?Q?H/RZvx0rUwfYPINIBGLVLPFQpqhdem+YzRIfhSj74AF6GurGnODBHcpuyGwh?=
 =?us-ascii?Q?XVX7uCcxlJea5tJHD/26OeOu1lp8U8Yk3UmtPxouZSXs/vg1nFKTIEh2c8U8?=
 =?us-ascii?Q?uUhhstXeNJCzKTUZRvDb9NEvUQQhwNicMwLCPOhKepiFNMSEEcBN8dime1VQ?=
 =?us-ascii?Q?BM4FLHNk00gZe2pH+MBdSd6CqPwO711r+HFGyYhJtGzeEDObi4LRPkkiTf35?=
 =?us-ascii?Q?1BW+cFK7RRhnpopWMwgJE7ev3p5Um2rUQfymPwsvT5w+nRuSVwpqUBHDg017?=
 =?us-ascii?Q?w6g9qo384QMaINhLnCAulPdh5Mh1LRlZxzzi9g4NlrfPKro502mXGWM8D1uA?=
 =?us-ascii?Q?J+v4XjNtHXRI9nGpefKpDN7H2W37KHwwvxwwQVlwYHksIdwZ6dxgXRSweNCW?=
 =?us-ascii?Q?kWnAaiwxdPVVL3S4UEdvHwGIrp/oi63/X7YAlQG+sOrDK/s0UiGvuH33dtoE?=
 =?us-ascii?Q?lNkGvuk67InrmyhHjfAgVler3BZ6X/gZt2rk8Kj6i6ZX6O6O1jUPelLJZJmH?=
 =?us-ascii?Q?018acR34kWVi43stl9k44LUYO8Qa1N+5jEZQmVAZA6HusqDp0NoOHKU82pKn?=
 =?us-ascii?Q?xCgWdLiAv55niMl44jROeEqzN6eSD8FHEkzHHmRgm50bBEaecblf94f5U2Rn?=
 =?us-ascii?Q?91MtszY/5YhNO8XaVkaZoTh6Hiry2OdIIoK6fUXpt/0knHvvHu6MGSQD1NE4?=
 =?us-ascii?Q?GLb7FpT2G3Zkbq1wq12wLp8L8cIFvJid4yhoNTh7dGkvqrjOEv4yXaToFdct?=
 =?us-ascii?Q?5XNEVOZxyO5cG5tHC5MvgK6EqeHX8vnaJ4cfdW+dMUfJAfWpcXhxA8sQVIzw?=
 =?us-ascii?Q?BNuaPIPmeTm3rzwvpbanP1Ap+KPR0wgOQoYRqbVaiveKoPNax8Up5jHzSBaW?=
 =?us-ascii?Q?YxeFJbHrgGnXMSa1jdGcSGQOTPPoEzyk4T2G/jR4HPrWgWJz1JtvypKRfN7S?=
 =?us-ascii?Q?Tq/T1z5twKPmBPnMdFy60b0ozj+cufzjto6QjnaIjQIxeNggp0+nD26IOVBM?=
 =?us-ascii?Q?WKhMjh6GsfwwL4GP04L+oijjiwAnoydFwemOa6RyEQnMxP6S+ZhXY3Qex/0q?=
 =?us-ascii?Q?QRuXeWxAv5dTrFstVYcnHV/ItU+sdpf7RvEhIw3NXm6sMdQmJa7JK4eq/MhT?=
 =?us-ascii?Q?M40xaSre2016KfrvfJYmxgKxZHQZbcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HkacnU0KIqohJBaYI8t/tHBUWa7R90frzzib9QOrRsFhB1weWFAX+ehzRgy71OAeMfRzIov/aynf7WUKvUgJefqTc3jXzTzHQaZ5EecwPNgAVbDVgp+4qq8VaUVwa1s++llq4Gdbvikcah4iBQrX3d1pSNQco2PYvAXnDljhbS3QF8O5dSNDOj89ZByDrAPJ+/Ip1vAdzXOIwGXfvGkMS0qMGYis27KCoM0T3XTcz1u3YYy1lXKYsPbjV/SYn6toU9NbHPO0NXqo24gBAlwNwZyp0IZyOPD74cxcn/lawapgWU/OYtllBgB8ObfKemOz1RNMaBpbPTi2Sm0lAposFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbdeeb8-1bf4-4fc9-beba-08ded34e8d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:45:46.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hq5+fXKAxQn8oN05HYvBhfd30f8HkSDqVYcy9kh93o++MihVdnpAd+V9ebiQAKIcx7cw0Z20ItVsmkKdEteLxNSdGHaq47z4MACQPwK5aj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-302106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,intel.com:from_mime,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6736CABD1



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Maciej Fijalkowski
> Sent: Thursday, June 25, 2026 5:14 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 net 1/3] i40e: unregister netdev
> before clearing VSI on reinit failure
>=20
> i40e_vsi_reinit_setup() tears down the existing VSI queue/ring backing
> state before allocating replacement arrays and queue tracking. If one
> of these early allocations fails, the function jumps directly to
> err_vsi and calls i40e_vsi_clear().
>=20
> For a registered netdev, this frees the VSI while netdev_priv(netdev)-
> >vsi can still point at it, leaving the registered netdev with
> dangling private driver state.
>=20
> Split the error path so failures after destructive reinit teardown
> first unregister and free the netdev before clearing the VSI.
>=20
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set
> num_queue_pairs for PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a56..471fa7f7b643 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14274,7 +14274,7 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	i40e_set_num_rings_in_vsi(vsi);
>  	ret =3D i40e_vsi_alloc_arrays(vsi, false);
>  	if (ret)
> -		goto err_vsi;
> +		goto err_netdev;
>=20
>  	alloc_queue_pairs =3D vsi->alloc_queue_pairs *
>  			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1); @@ -
> 14284,7 +14284,7 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  		dev_info(&pf->pdev->dev,
>  			 "failed to get tracking for %d queues for VSI %d
> err %d\n",
>  			 alloc_queue_pairs, vsi->seid, ret);
> -		goto err_vsi;
> +		goto err_netdev;
>  	}
>  	vsi->base_queue =3D ret;
>=20
> @@ -14309,6 +14309,7 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>=20
>  err_rings:
>  	i40e_vsi_free_q_vectors(vsi);
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered =3D false;
>  		unregister_netdev(vsi->netdev);
> @@ -14318,7 +14319,6 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  	if (vsi->type =3D=3D I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> -err_vsi:
>  	i40e_vsi_clear(vsi);
>  	return NULL;
>  }
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


