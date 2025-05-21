Return-Path: <netdev+bounces-192476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC00AC004C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DA1636C9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02606239E98;
	Wed, 21 May 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVe/W/lq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B828220686
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868655; cv=fail; b=eFmZrpK5WXWJajrf8MQGMVTT6v6Fd8B5vTz0oZnViSY/PC/scbVaramgiuIkxyDDHjRmHTfItYoyXDz+g2ypMuaKUi6pj3LRTw1JVxYlgNSOyfrNFkwiP6rdLeMKXxPmJTilGskcoMKV0jtpb2PFN3uEc9rt2sKQxkw6yeyrgls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868655; c=relaxed/simple;
	bh=uXu277246qLiVms7TSwPDOyYvJyKlIQUZNddN4kwNCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aulSkB/cQfeLpkWkLCBroHZzs+lOPYykLmztoXGi6b1xnpj091nQDZnbASpdZo0ZtZdRNx5PuAPQ9y52Wk7ii6TovN8kZtrLTy4Ejl1Rns2161u64fW6omHuWEE3ezC0Am5i/4iXhY+W67TF6DcHKe6GZdon3OJv1CvlvjpnCAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVe/W/lq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747868654; x=1779404654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uXu277246qLiVms7TSwPDOyYvJyKlIQUZNddN4kwNCI=;
  b=fVe/W/lqFoowSC0kZ9NITUZZCquw82usqF58BHTcJqDd5Aw9D/IDsVJq
   yNm5/QW4jTp7Hbz5KwrIWZPvkW0Or/9n7FcQE1nGBno8Fu6QR18znQWbK
   atXKlwbFUAFX48hXnxIa+jeq3BRbT+DH4cPt2zE+D9ZYV2W/jA1QiWfmO
   m9znDFK7buDAKl2VvF5o6VE5DVZ22jF6h416bEd3PI/zx/RACBKovkpaY
   8pu/yRGD7j/YFCd5MLg9DtnEA5iMg/NwqJ9hRmQT7CyHgTDu6X1Dzcze0
   ytwLE1K0asBTwB/3SsDb2otXM7n5XNLmRKZ3y6u9mAwKLUpXCCk5udBFH
   Q==;
X-CSE-ConnectionGUID: YyPMGKj8SGGp8afeuHYFlQ==
X-CSE-MsgGUID: M9JAHxLiTZq6JLfybXZvYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49576987"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49576987"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:02:13 -0700
X-CSE-ConnectionGUID: g7/Xp9hdR/yAJ7KEooeK8Q==
X-CSE-MsgGUID: 1RzUfkMPQfCk8RgMvTfmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145266564"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:02:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 16:02:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 16:02:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 16:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZzH6J6aTvU+zIbvEVfJJ13t0wu6IAadtCrAM3alMGlA3pNaFSuDcLJgc390V1TSixF4kFmSIZM20FXuf1dnZeIzxtZNZgqatf5dC9Q+jOUVl064kRtcPNtsnZPcsm5U0aEFOCXdPyeD6ryUYqDJTqIHh005MVCo7WzejjksJj84UgC5mR/Pe+DRGQZhpqzPUy0achIVHi/S1XmCSenjCHKN3Wg+zXfOaZKwy+V0krhrfoNybV/oZ/Wu8SmNT5+l0cuzN1zszjSvwjeHHdZBf4yq5w2g4RoXqqqdF8gfXyJzvDz/iobeRGSwYUmZrK2J+CN0iUDzLclK38XJ2/a7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXu277246qLiVms7TSwPDOyYvJyKlIQUZNddN4kwNCI=;
 b=ZcF0c/epUqDx49sv8LJv0ZSahoHFWfwfpIBerE8IRSG46OyIXI5NMg7ZU8BFMRg3Cw4ilO1EwrF/I+hbe+0qHyN1pDPyX/+PVn2807n/aRNbHCpREVF0DaKFjisDtm+RQI9z33vKppHSu7916qi1wsJN2tfDttVMOfUfNaKuljn3RPH/11c93u/0heJvRuQqx0B1WVQ+Sr3pbiW9dOaeYFgqrlA3lLjiVfrFfp1y/uD4JkbFVpziU5lvlAwo6mvIAyayxUJyvFEwaJxT0PY1ShYzbDqWGORDldF9X/k97YxgBD/948vp6a/rwCtCr6Ef/gf3RkZ3zT+OWv5DyoOY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Wed, 21 May
 2025 23:01:29 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 23:01:29 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Olech, Milena"
	<milena.olech@intel.com>, "Nadezhdin, Anton" <anton.nadezhdin@intel.com>,
	"Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 2/9] idpf: use existing
 queue chunk info instead of preparing it
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 2/9] idpf: use existing
 queue chunk info instead of preparing it
Thread-Index: AQHbwGNQhrmhldYGV0uapWYCNpggerPdxV6Q
Date: Wed, 21 May 2025 23:01:29 +0000
Message-ID: <SJ1PR11MB6297FE518BE116767EDE381B9B9EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250508215013.32668-1-pavan.kumar.linga@intel.com>
 <20250508215013.32668-3-pavan.kumar.linga@intel.com>
In-Reply-To: <20250508215013.32668-3-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|MW4PR11MB7080:EE_
x-ms-office365-filtering-correlation-id: a5ef3eee-38df-4e9b-96a3-08dd98bb6c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FZpJyNAXdb28ahZ8zmSS4l6KbEM9yTYEPZvGYsIXO8KD1ftVNr9ReROMHfbY?=
 =?us-ascii?Q?WdSCaeQyFo3jw7GF3CNnzZR6MKiiLcYEAaCn14N/7O6ZKy5Vqs0es2cwy6D0?=
 =?us-ascii?Q?6JeWBGX5zPKrQLRieUL6D3puxyjg00mqKx113OUDClzonDjqbO4wDWEwngZ4?=
 =?us-ascii?Q?lIrJa28i2BZNF2f+dpzvHQ4saP20R5JxC20Vx5yDD2zCDZweiaBDE2drQ6UR?=
 =?us-ascii?Q?M9QYUWasX7wshxSvH2LA9UnIir46kHIfNi60E8/t+LPuptVw5PQyi91XtaJ4?=
 =?us-ascii?Q?lQsIoJbTD8RLLSqnR/aspMQJ7zG2VyzWGQm0IBmS6ob01k599lEg6P8u88AI?=
 =?us-ascii?Q?8v6BMAs6iUdY5yS1H8YRJl1uqY1hW1g9/FbID8d+Pqo+BDhbLKzYPQF/L0OI?=
 =?us-ascii?Q?Xy6VZu7xgu+PvE3CxzIM423qyRdr5L9yyooQ+u/tgiu04he7X0gBj9NAU1+x?=
 =?us-ascii?Q?5RtwzRxyonsPO38CNAMiB4UXyVSbN97aZJQXQZsOo1LTKrvxX7bxNAY2hTZ+?=
 =?us-ascii?Q?WW0/anBZSqDM9L28hyoQ1UCXcRgSg7a54L3mQnZbf5Rx/aMYyYpa/n5HOcmZ?=
 =?us-ascii?Q?G8Xo0V7ZGxlaSI5RDoV+E3bzgD7IDs6hWqOrjC3Prk52Ne099N48Lr0Be6oy?=
 =?us-ascii?Q?4rdJFxM8SQVjiHzPqn5/Xo1bqADeH+iXxRKDYcB3SHuFwF4fywB3LW60AOGL?=
 =?us-ascii?Q?KBU2PnMbRvfo7VMVoqFIqhXqahZwz8P1uEt6Aat4uYavbNEIw0ddAlH5wqsl?=
 =?us-ascii?Q?YvUDkEvZlblC3UQ996APF2VPcMRyoBnsf+lggQD3gnnzr/cMvTkgcXZlC9u5?=
 =?us-ascii?Q?LBfcX1rzU1+8+rBYsfLSe5xtiwYwqJN8CJ6mphXkhKzFjaCR9Np2PjbPXb0K?=
 =?us-ascii?Q?j6G0WeijzQwTQdYtMlftLxWF5mCJNyBnj7DGAE1EZl8Nmp6ZbNFykW9D9Vik?=
 =?us-ascii?Q?TY8HW/Wis8kr8xpUBHJ028kvd0ul2zI2Xk3SakZeglVJY4t2+SLS0ALrCaew?=
 =?us-ascii?Q?eJfIbSjfv7EVEQyW2TWmEAwvFLScGF9jT7Hvo6czXAeRpdBy9fltkJM2ApLO?=
 =?us-ascii?Q?DzrKnOO12o7StcvOpQyiWIBxAlmbHu/FJM9vMPajcwyztjzMVjrlql4yBvLK?=
 =?us-ascii?Q?NKtcWnhAch1uWw9GPCJcKDSg9QQ639RHOOEUci3NfVqTzzwHVrd9U7xEgRuX?=
 =?us-ascii?Q?ZwdP28gwj/k9hhDVjhfkV6d3bNEIGTwbpVyG56ideoP5wQBdW3HiEUeERixE?=
 =?us-ascii?Q?b5J0IH8z7jOv4kVAfhDRQ03Io/D6wWl2AkJFzdiYO7Jprf5r5dZmWicoTwE+?=
 =?us-ascii?Q?iOvo0cCoxsfXN5eeLvd1AqAyzG4efYfHR4z4gNgYOrZnpunEbpjmGoxksKxl?=
 =?us-ascii?Q?X4GTrK5Gcy2Bx7Qgy7j4etjzl5Ot1NkcjdHNdG41SAIOVnDuQdueiGw1N0p7?=
 =?us-ascii?Q?0thGQIGHwQ+4D1q+uRtobn1ChIxmtSjE019ExzzZ0e5wxqx3/nYA7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xoXDg7q0shWnasZlK3bfigjTcYXC6asMl8wVWGqXYIMb85DSHlaRyGeE0SiI?=
 =?us-ascii?Q?xHtgGaSE75x3UXMLID4ZJjFJ+eS+Q/6XNC6yowjeazuW0vh5O2GmUm2/WW/+?=
 =?us-ascii?Q?cuzenF/zZgTlMqmDQ239Ml3codE8LIubIS9YWRwn0Y3r5QwFs2dQ6kPlpRgf?=
 =?us-ascii?Q?OKk7h8jXsT1EjtwUH3nq8avAEfmd+3LTQHi9vtnVQivJBMFfBJPjP5G36j5X?=
 =?us-ascii?Q?jhc41399v7pXwqcuUS7QChtPtv8ag4B8e4ggaANQvqJep2XPt6Y8xT1XRCVS?=
 =?us-ascii?Q?549OT7hDSdqIQ6B+0e0df22eDECKMa+S17L+MDm/U7FxnLBY2S321dCakaug?=
 =?us-ascii?Q?Bu0GOk0+sbeVbd7q8ID/PFR42QNJEHA1Q7pfAREyXzwYd2Hd1gA0UX7jgx5V?=
 =?us-ascii?Q?rdjxUGimEmx2ykHwtvm+mbPJMhHgFz2ra0OkM2YVm5umUf7r3ZrmWEgtGSsl?=
 =?us-ascii?Q?Dcsn9ERt5M7/CkdJqu2Uu4pxmraThB7MaEoYBG9bMfh6ugXvPT3MtYrulX5J?=
 =?us-ascii?Q?sFf5Gj9JKjCMf76hDVlX11lN3UsyT1QAQUk9zpAplyPzymvY2MHlkE2+dZTF?=
 =?us-ascii?Q?9zK9VtNYFlTEKBBgEPRXadoDZU6cylLqXcL+ntEmEo/xxIgvGk3sTUstWKiV?=
 =?us-ascii?Q?tFJidvJ6B2+rrr7rb0dWF+PVfDUFLKO9oZlyGkLFP3GTx5vKae9wDEsn5KlH?=
 =?us-ascii?Q?1t2hhlUyE++yRUo/dJOX+0v+fVhcJQklVhlFhflVn8H0sYIWiYndlTkQwoF6?=
 =?us-ascii?Q?BCX/KUhqXr4nJTms6ILtUSZxSBBE/dn/5Au6v+wTDRJjFD+gIRp17vVyVg5n?=
 =?us-ascii?Q?xQ3lKzGd8VyjsoqB+EHaCA23pwFDAJgblTA43JosPlqqmBrvvSak2Lz5xMor?=
 =?us-ascii?Q?mj6qRzqbMgckp2s8X19YEQwX3MIFNfp+O85jgCT8K0DDJQ7ca8l42qgInxUE?=
 =?us-ascii?Q?7xUblVwEBzTgC0K/7vp3rwB+iY5Z+d6I8V/ie7nWLGfJPy+2MO0NEpa+a9+8?=
 =?us-ascii?Q?RaAjG7UVRZr6+ZGovht1faFvu9tqNdqYsNdGq56Q9iNAbEabdhIbOVgGjmhE?=
 =?us-ascii?Q?XvJTrkvFNTgoxH5NWwSsh8dz8gepQtSyPgdIg6f7eHu8QGh5A94ZEZYzzT53?=
 =?us-ascii?Q?Se1oECRL/W0NQgTcDWZWEIQ+5vrwrHBgWk8pf7e8XFvUs1z7xzDXCtpnuSGv?=
 =?us-ascii?Q?s6h4sJwx2OwiKz1ReALA6dt2JCA9vQ2JzhJhGnI8O8LuEqaiM7psyjuxYk0N?=
 =?us-ascii?Q?Q+XOCCJaSgcS/dfUowYgP6f3ZDpBrm3/ocudkYYoCXGOSH6e+Xa4/Lcz8Zzw?=
 =?us-ascii?Q?oEhiwuP14Bsw9dwHosRQc/TnaFyoyfPrvyfYbZeCec4zzuToKIUUs3CU6lyq?=
 =?us-ascii?Q?Sv5R7INIG6QtPZhKxnm1sh09ksoHhlAYUdW1TpJtGhFxYOMTauUN+uCapjgV?=
 =?us-ascii?Q?IwqStXPuOzj2la9+buoWQjnGhWApHY7WDeHPokGX/jWtATuQzJoVbaBXv6Rv?=
 =?us-ascii?Q?1IKLM0VCnXsIOs5V7oBxlTZ6m6V9PE7cwlY7WWJoizWQuKqLo6Ac3nUUzk4D?=
 =?us-ascii?Q?EQiVSKIOJracvFZImflcEMB9JtGdDI6xNxBz4iKw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ef3eee-38df-4e9b-96a3-08dd98bb6c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 23:01:29.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdVd0A9MjjyF8JpPaw6SeuYAKn0VpHAq0EEAb9Vi47eipaZW8w4wJtgUVNfQkaVs1pnDAuSBe+qDmXHYBqhyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Thursday, May 8, 2025 2:50 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Olech, Milena <milena.olech@intel.com>;
> Nadezhdin, Anton <anton.nadezhdin@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/9] idpf: use existing que=
ue
> chunk info instead of preparing it
>=20
> Queue chunk info received from the device control plane is stored in the
> persistent data section. Necessary info from these chunks is parsed and s=
tored
> in the queue structure. While sending the enable/disable queues virtchnl
> message, queue chunk info is prepared using the stored queue info. Instea=
d of
> that, use the stored queue chunks directly which has info about all the q=
ueues
> that needs to be enabled/disabled.
>=20
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

