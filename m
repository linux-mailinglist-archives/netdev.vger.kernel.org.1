Return-Path: <netdev+bounces-192470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DCAC003E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638611BC6465
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C0230269;
	Wed, 21 May 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNHvf1k/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9ED23BD1F
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868389; cv=fail; b=OHFN4Za3I0KQOie6liSQbFxRoqaenI7H0k2OKb501lvxGLRA5xzdxrypz1JkeM3Yp0uatWeWvjJhdYUpOWgywr7ll2BYgZkdOxDeDGJEuZL+95gS7UsdVgX89/1naaGnCJHuh7ViMyRdmVLxW1b7URW7NF63A26865bv9u/c9jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868389; c=relaxed/simple;
	bh=AVrSNOr9BoYAfllmsYXMtKCACpIBZi0UHIdFU3QM+ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1pVIqQEyIxP5adgz+k2sA3vn2wjwMHFxDUE+06OZWPpdDpPWxpgJj53by9pzbux7uFBDmzyFHqM+1+bXdtA+crc+6xCKOybMdLykuQxkXTH7DZwMglodPAyJQvdBD7Wx7Tf7w8ce3kbtYvdxMvT+hbrBRaeJZPW6856zE7GTkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNHvf1k/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747868387; x=1779404387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AVrSNOr9BoYAfllmsYXMtKCACpIBZi0UHIdFU3QM+ss=;
  b=mNHvf1k/UwOvC3gp4U3AKIzfAW51unp/SEBAJGpaikvCaEBP0rUyEz9h
   Sd9pVH2fNnc9vu8iHLfLN2MWduBmDmuljR8Jxe8RFUC8ePq7s9ekvvi9B
   EzVP3X2RgJ0ALhJRzZ1TKghbCKU85h1NpdsreR+t79JXG8MVh8PJFiJCY
   YVb5uWLVGBC1soGkp2V41CgRm1OFhDisOErT8dMn+Qkva+wPLfNLyc18K
   xNR5s842cxu9hdnERECzm5qZaEaj8xKkYdQF4qgo3BIJ7tTW0MmE/itrL
   1a7lkhtx/kHzShfLhfEuSicNkLB7FsxLr0O1l/q1thmTtdPdJeOTnZVMv
   g==;
X-CSE-ConnectionGUID: UKnktX0mQz698JwOpNCz2Q==
X-CSE-MsgGUID: BwFvlqjkTT2AlSAGehyvlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="48993221"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="48993221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:59:46 -0700
X-CSE-ConnectionGUID: /Tl71DdtTvKPMWNfPCDRbg==
X-CSE-MsgGUID: CAutn5TNRZq2NkQc24YSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="171162082"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:59:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 15:59:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 15:59:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 15:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnkGOGNx7yAgBks4GlQ+IdyWpaECkSiIATu1ePJj+IvArY+gS4B45GwwolFAppCNoCw4l5YAAgyHcPhDuyQZGTslUiNO7y5DDEID1w5NFip+l1ZH7ZQnc991WR79zQDNCtXKcz5aXtn49/BEWGHLlIOe5sADP7jPWpVUIa5reIZ85P0E4wH+CzKEaW4WJmeJJ+l77audzFsdWBGhfEpbpWIq11Kp/BOvEbCO6YTiRM64MOWcoyma3rjVG2T8Mj/M6xaTIFq/mZXHXJY32bYc+xflnyR3pCNsM7j813zMkOMQBrlCyvaqN2K63gY8gw40W9fV9FW+yFOLBlFcZJCpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVrSNOr9BoYAfllmsYXMtKCACpIBZi0UHIdFU3QM+ss=;
 b=aQJQMNTVEPp7gn9o40o+vPMQGDz87P96CylayOQ8AJKbDs6FSKGbekWKrPGM+v37nPp8v8c/pFkp4wVgrdh4X9NvrvNGDhbpqwXkK4ouGHHEeL/scl+cGvj0EOg2zuBiz4CWM7lylW/eagb9G2xYtsFM+BPl0BVjo9UOLHvzrEXcb8OARxVKcFy247v86Dk8Yn/jxgGh6l4Sq/4qOceI/93filKL3qa41SRcz81wfa7JmCpBRf7dRQ9axB0NL6Rv2dKol3dRrEqk5K3eXJ8bzhhgt1SOWOWq3u6E6izgAYlJcz57difXwceNg66C14Sl9fkx+0PRvj9237kQaDtnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CY5PR11MB6260.namprd11.prod.outlook.com (2603:10b6:930:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 22:59:27 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 22:59:27 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Olech, Milena"
	<milena.olech@intel.com>, "Nadezhdin, Anton" <anton.nadezhdin@intel.com>,
	"Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 1/9] idpf: introduce local
 idpf structure to store virtchnl queue chunks
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 1/9] idpf: introduce local
 idpf structure to store virtchnl queue chunks
Thread-Index: AQHbwGNSzxT5gtqRb02irDOv1uCRPrPdxUtA
Date: Wed, 21 May 2025 22:59:27 +0000
Message-ID: <SJ1PR11MB6297BBA81A3543B4B9E4EB849B9EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
 <20250508215013.32668-2-pavan.kumar.linga@intel.com>
In-Reply-To: <20250508215013.32668-2-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CY5PR11MB6260:EE_
x-ms-office365-filtering-correlation-id: 93d946db-1fbe-4b3c-bc21-08dd98bb236e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?hWBHto5VYTCHeBjpDDj7QxrVhXAHCo0JGI6PaCSf5yN7bZh1nj1VcuKHJt+a?=
 =?us-ascii?Q?od6P2ylr9oCPKjGcBha8r1kjE2ouA+oNQfHJ0edjYTjiBQFtFsTyJ7af+IwX?=
 =?us-ascii?Q?Qox8zMtyjPUT7lOE4GepuMFamcmGfajLEfyaDv/xizzAkfbhXyWtG9eWX+IY?=
 =?us-ascii?Q?G0UT7uEAPLHzk0PimhekRuXip8837C0/GmWM/QMnLpAKxHS19K9PtlW7+kui?=
 =?us-ascii?Q?VGEE0m25GP9UXKLiEV7uId3dAl2zfvARD5HU2J3Su6YhhQtBUpy/kf9A8c7d?=
 =?us-ascii?Q?gzvHxNjGu5vbLnrZhSLH4opiON+YSr0bmr9D4Vn7Os7Gf3aWun9t66vznbS3?=
 =?us-ascii?Q?/Ft4A4cjeMG1/jOX7A2xr1uO2pOaokeHyXdA7YxxROLDopx15vmM8VLZoZGD?=
 =?us-ascii?Q?L2Yl/jWaBt2XjnSGI8fsNfzUWUCEz5DDH2DpD2wSAFbKxiOHcSzBxCX4J1Wl?=
 =?us-ascii?Q?PBern2jd2UIfuhUQo0gJmF2RJ+wAdAu1d4q81Cj6p5mr/7qsV7W8p1VO404c?=
 =?us-ascii?Q?+PJOJKbAyTT3fnQHk10uwFBjEUhhxDo9NTF4/C21E+qhqXXRoRKYoFUPBjmn?=
 =?us-ascii?Q?Chpl7w0HFeEZBwHSXL2OM/POx0lC9dNgBIS/kZpo7HtmINq0+A1HC3hCVCzK?=
 =?us-ascii?Q?awOZYrTmuBwuf32Y2P0PlFhL0iEI6lTzMx+MYHVw0WorkJfNs21yL4yCzd6s?=
 =?us-ascii?Q?HUZA0WMgDMl5cpTdLYqt+vUhfkv9kFOCTFq8hU137rAECAOAyb9yQnAMwGTf?=
 =?us-ascii?Q?iLCURI6GCvF9Nflu/HoYIHNKYpfghoFW+0xdeQEW9yek6aKYYOJnQGdN7RdO?=
 =?us-ascii?Q?25gnQXgZQ6h5yWI1MxioHS08RBeaP0WU7BqGdL954wSc3AYmsVF/G22MC4Zm?=
 =?us-ascii?Q?/C/PVLyk76zqTuKoupnYFKhGOGNQlXs7jqsKYWpyG8g5Y6VIVpZp/zwp0HF2?=
 =?us-ascii?Q?9Y9qEb3amfpf+tD/2GBsV+ojVsQO0nKFWfBi+O7Qplkvyu8Mox7F6FlEa7XC?=
 =?us-ascii?Q?g6POldSyYdVpxZGe/FSqLjnr42jDMrTkoshbeVrvYzwCURmaqDiyQxD+sw0t?=
 =?us-ascii?Q?0UOT4LeJju63a9OBvlJX07QTaKw80ncW70eZ9Vq7MklmP1T8tzjcduOugkXD?=
 =?us-ascii?Q?JaEqpBPKmPdioLcngedkhHyjpXZGpuqachjRGljs5c1e7zbuZDhL++UgwpyW?=
 =?us-ascii?Q?oTmo4CHjWU/rcGchjydEdO5EeTsjL02vxZVSwPxw6dJ40dQEC24wxYTUOYXB?=
 =?us-ascii?Q?r5eCm5u/kTVT5k1BsZa9oi4BcvQy3PtQ7+srPlHEkyRkEp1IpIRDrC5U7nU6?=
 =?us-ascii?Q?2yQ0UfjAftdhc7dKWNIRVs/URE2KMn9sSsYLvacVqjqCFvuCJhERpNEmCDg5?=
 =?us-ascii?Q?gbTuEAlK6JyImmmY8MA2q0r+clpYwShph97ewoirS5gdtBbiqYte71PuZeBI?=
 =?us-ascii?Q?0ntgrc6CpnYYXfVEA5fe3iZfhFSt+Qfc6RZbJTYFR1Q2ZXBnvka/ZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2bHW3Qa3ka3aDCaOpdPuMpqew+u/qXqtEtrMyWTkxfX0OBsNbiFHw7U/0go?=
 =?us-ascii?Q?b86d/ZSk6ut3pMCU1YjkflbZN+uKB/2zfAIh5uj2e4vH7HYc98liTqJ/Trwh?=
 =?us-ascii?Q?3IJ6FMv+Fy3w4he68ZnRL9wIniS9JKBWb08LFj1Ghd44bJGURHuK9cE5U6R+?=
 =?us-ascii?Q?AqNr8NTOa6iffoFGECxXZdpGy3KxTAmXtCU4Q+bgH07bV7RPW2UZIGA5Jl6l?=
 =?us-ascii?Q?Ho0akhRIzkxvUNXaWz1VcIYc540pW6CHwNjsKHc+Yo6mdAsoBTJsANbv1qvP?=
 =?us-ascii?Q?rBsj6RXiaz6fxqdxQDW/CSnafdbbMCawO4KxM6dsgyYGbMPXVz1f52L/VGAv?=
 =?us-ascii?Q?49RJwubZveX/rnyEFC3uxT5BN7fnLCpvKhKLK3aKr/eNxn3SkbITApSoJPXp?=
 =?us-ascii?Q?TAPAk3fi6L/jOa5ZZnANooSqMg9FvRjf6C21+dsAG2MCYmjNHmOQFga/0iuf?=
 =?us-ascii?Q?5ex9hfKAHW+2/d1ctXeQ6rdHzJ1VUbSQSCp1VqlUdWUioMA1SkECV01snyEh?=
 =?us-ascii?Q?BW5fP77CGk1O/gijpLLVgmKYNPANQ4/9g4jl8tY3OfEO/Q7X9l2DgQGKqG68?=
 =?us-ascii?Q?HPs3mhhLDIXySAi9qPVwJH8Y4O+S3IvdCWezxN8dmeR0IitWvQ0DidXkc9nL?=
 =?us-ascii?Q?59kmGnCLhW90oBFniovLYojxlC0p2Of517uxDV1cEIPV2drzwQl+HRIgcgc/?=
 =?us-ascii?Q?LgbmYx/5q3bAO+aHLD06grOLmvSEmqAJTv5xDeE73RE6CwBMWSdBcJHGnfCG?=
 =?us-ascii?Q?ES0eiixHaMYySoTrcCoPxPF2tZS4Ee5/PEBqD3usuqHzetCES6AtZqbbDa6e?=
 =?us-ascii?Q?Q3fMacdLObGLuthchM3xkdH7bb/mocdIMZd/eEwYQ/85un1crWohAO+sZedn?=
 =?us-ascii?Q?RMvQfK+ptPKu+S/LckLzIvhWc63TxR8Ax+M9eY0P2+wTtmkOPpECOw6JnRZD?=
 =?us-ascii?Q?bD4xswBFsGPbdFBNDRqlxAtXdmTgxOeG2Wv7As+aiC/Gxlb5T6CwOx09K0yC?=
 =?us-ascii?Q?aV8ZNs1Ru8O//JGOBdYAbQrQzf67hgxMfTicchthvco8zRLb59s8+QXbSbAC?=
 =?us-ascii?Q?BNo5fCV5tM2deyFyKyxKgNAFbpeWd9iQ4qv+CNPzKtQHTGlNz4U56QULtaXK?=
 =?us-ascii?Q?xh8qFbn8+gxSIiopHIk9YSsF/HbDyJ1JHCOfNYUxrl5xPcJxLnyxJRBfGAya?=
 =?us-ascii?Q?8p+lI5pwRknYPl//ThVXTmY4eLaL7fYISNnv8LiMzMbDL3a/GNSV9V5PJGZQ?=
 =?us-ascii?Q?JTckz6GGgNKhRZdw82RuYNpYwNn5dLAGr6R1Dv0+wtGpeO3EjOfK3c7cXIRS?=
 =?us-ascii?Q?75l14k8lY6C0sg7Y3iI79fRB8Ko5viMqwW7CwwaUKyjdZirkJLdvAarzuC3k?=
 =?us-ascii?Q?CRgy8LaRDEska+IECMbYCGFpKgMUPLBadQRhdzlPM4T+ZKct6iXSwRV2RJm2?=
 =?us-ascii?Q?u7Bb49di6UgxoU8BffaIsKJADxguBF2paVwTGkI0jvJhJlXoeH8lwPi/dlTA?=
 =?us-ascii?Q?VHWYy62nBaCmICN0hIEYkt38XebEx+PL2wI/pQ6YeP8gwiNtmAA5HexRG+4V?=
 =?us-ascii?Q?OiCJKhRyo9BngcuEL3TNeXJHbFE0kQFeczqe4LdT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d946db-1fbe-4b3c-bc21-08dd98bb236e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 22:59:27.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1J/J+Nkym5ojeg/aobpqveHx3xuA+eWb/i6EqkL0UybnScaDXS9eqBY6Ji1q4ilq3YIXqgOBM4tz2a6aih9aCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6260
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Thursday, May 8, 2025 2:50 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Olech, Milena <milena.olech@intel.com>;
> Nadezhdin, Anton <anton.nadezhdin@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 1/9] idpf: introduce local =
idpf
> structure to store virtchnl queue chunks
>=20
> Queue ID and register info received from device Control Plane is stored l=
ocally
> in the same little endian format. As the queue chunks are retrieved in 3
> functions, lexx_to_cpu conversions are done each time.
> Instead introduce a new idpf structure to store the received queue info.
> It also avoids conditional check to retrieve queue chunks.
>=20
> With this change, there is no need to store the queue chunks in
> 'req_qs_chunks' field. So remove that.
>=20
> Suggested-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>


