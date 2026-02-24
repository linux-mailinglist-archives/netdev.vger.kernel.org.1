Return-Path: <netdev+bounces-260361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gk2LhRMnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF74182A29
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F35B3055DF9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A4B3093CF;
	Tue, 24 Feb 2026 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHWKgBmW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7530ACF1;
	Tue, 24 Feb 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916234; cv=fail; b=cDFjuQK122cIIJH+V/cjHooJs9YNjtBLi2/qZytzQxf5xXOov9dY4tntyLOwgXLFNNxPQfZFiiCgwtpSix/b+QLdwYcfDB83Ux/P3uVQtB6ARw5BTg7Aii0ii9WCce415sHYwcxBwsdiJsRJ19RO3fvYSgaHurOV8QJ78fr61gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916234; c=relaxed/simple;
	bh=VooMJvGcxNEVfVULPb8rn3pkOR9pZuy8gg5Lc9Y0FKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUXwD5qRVfCEYcqZcySSmtm2lljotcNEcFCGw8BkdwIw8NuGWtWLD0Asv468jlhJv9f1ceMgDqSsrrNFcI9JQPvQypDGCkDCWhdRI3rY0YzdlR3WPsdVeaWQY+qwvO5oS/7bwgtMRzMrEU1YDDvLlpVPgp2M5owzag5Ffi6q8zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHWKgBmW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771916233; x=1803452233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VooMJvGcxNEVfVULPb8rn3pkOR9pZuy8gg5Lc9Y0FKE=;
  b=oHWKgBmWldgLUISG0Zek7YWi5ZdEeAkSDk+Rs5W7xwy+B+2VZLd5TaHk
   DeIwziSCGXKSiG5pPs1RhQ4z104Vbrm7Qjq37hj0LWZwKesANjSbPBx1/
   MFNGTXsLmb+fC7PM09Px1WtLKmyiaNpGspk5EuwmiQnAJ1E3a2l3QHZ72
   jluBkyncMTio1u2UuqFL2+liUaxlmtvTnjLR4cwr7C2sKaXiWs/zuIdha
   H7tyk9QtCyNG3dufv6KEBMipB4f5ngPc+72vImNXBl5Bg5QAv3N3NgRQq
   /wl7Tp/JtOmtS8bsxe3ZlVTLdJAhIA0GKuD2NDc7ZgeJctaQxTsbMBSMD
   Q==;
X-CSE-ConnectionGUID: 3tG79qwbQOqqSRXrTdu45Q==
X-CSE-MsgGUID: q6Mq8HISRiiKSibn32o1hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60500724"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="60500724"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 22:57:12 -0800
X-CSE-ConnectionGUID: xNwJ3GRJQjSQiEFhoTwhVw==
X-CSE-MsgGUID: 0RfHcQgwSHuMZXPqjsQ8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214660912"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 22:57:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 22:57:11 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 22:57:11 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 22:57:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgZBFtT8viBlg2WBWN8rePDf/7HwyLdXE5p2b2HwKLrocSimBBP7nCAqHCv5Jy6EVTBSVnyEBSLV9AdRwB14riyPzfxfTa3+Ql/FXeQtX6hPZaw14xaVi0svcPnPpIkyV2MHCWPI9ABRZ4hB0DG2VpD6dk1tlQR7Xi2kE5MVyYMQyOnp8QMTBmkDBmjHc0aDUhQI150YifzMsvtZuQpjojkiimiaCUVC+iRUTpyrXQJGuJgubuwRKtAsbRQsQvpRTnOuKzRJY6CwDreSHsxmKg9eaKoKxyC0TRgU439Sea7Q/HTOrlO2TKP7ugrmcuUCMepQZACrEA+TVSs7kP0NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVpojfxDZ2uz5xxtGAVchRMQjEA+IO/XyWLO4UeI7cQ=;
 b=BmDLq2D5E4/RR0fUGnpw4PjEFaIuK9L95bMFp/xzvZSdRm0stSvrMiAKBOWcqOSGJeEkRjYJ+4DwBBFCKLed4TCdckjSWIBKbVEYtFyzhtQ4YYrbTTxqOjIb5Y6QlCxc4GOXQLx/85WpHY+tmT3OTGJma4VtkhpBS207zXDHutbJwYsjns/bEYu5S36DJoihO+9PzqC3pejxiTLStxwTDHdTe+5nLsZ9Mt9PzUIH0U68gK3pkSKkSJIu2Hx+wrPhW0m2itKM/8Q4nfM1UAokj3e371x0yUGDkK9g/RfcbyeplB6SQYjIsk+0EDaAiBiQK99dSfh0yfTgP3UPw9ieLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) by
 DM3PPF49E43CAC1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Tue, 24 Feb
 2026 06:57:02 +0000
Received: from DS0PR11MB7970.namprd11.prod.outlook.com
 ([fe80::b66d:154e:f761:5d49]) by DS0PR11MB7970.namprd11.prod.outlook.com
 ([fe80::b66d:154e:f761:5d49%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:57:01 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 14/15] ixd: add the core
 initialization
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 14/15] ixd: add the core
 initialization
Thread-Index: AQHcV8kYVvu/hwmG5kq9PnJzIrFNULWSBbUw
Date: Tue, 24 Feb 2026 06:57:01 +0000
Message-ID: <DS0PR11MB797038AEE76B5F224EF5A09CF774A@DS0PR11MB7970.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-15-larysa.zaremba@intel.com>
In-Reply-To: <20251117134912.18566-15-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7970:EE_|DM3PPF49E43CAC1:EE_
x-ms-office365-filtering-correlation-id: fbad970b-ac98-439d-ee13-08de7371e975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LkD2Cwv3+AVOa7F2JR7t/T+4/EoicscNBjp+WWZdjxZGrbS15t/oRrVooypu?=
 =?us-ascii?Q?Duu0qmBMM5DOcldMFD+UFZAFiG3Dmy4lbUvsiiO79/OxbHA1yxeL3aM+CcxI?=
 =?us-ascii?Q?NaKNZIHTxw76nVn8kIVH1rjIYhW3fvNn0eNZvmCHDKAkOdo/Q1nVa+s3gO0Z?=
 =?us-ascii?Q?pN1JenxlxZKO1HfWdxEjqR8EgKdmXJvhri63/pdq6xtkI6GU2NeHT1CUrDz8?=
 =?us-ascii?Q?8w7i57+eFgTetHiuVdENtrxk69o7xENP5UNlgDW0kyGySw5ZXdspoS9klTWJ?=
 =?us-ascii?Q?GjJqQcVzU2cWFMkWftTxL22hv/4R/Glf1Rdwr8fqPxfLtn5q5lc1OHLBWri2?=
 =?us-ascii?Q?pQ5NJDENWmqY2tDXByjyGb18YwRNzs6jQN93cAuclkJb9fqLronhAJW4y4eP?=
 =?us-ascii?Q?qGdKBITODDOExhn2cUmH6ozfInsiNBo1NOX7RNqKxogsl76UeXFnZ3XQiVss?=
 =?us-ascii?Q?yqFrqetm7c+srAeOSc4t10dZaA8eEwO1WO4+GmhN3K8ZMk3XFHiUFR/oPwsr?=
 =?us-ascii?Q?BrJPwAUeV9xwY1slgl/+QYvZ5AbhguvjWPu1Qk3X4gPXU1U3fbdriTOKWwL4?=
 =?us-ascii?Q?eFqognD4duBfwv3VqWmBDynevzjCR7YYzLF29M5LpSEV9u+hFL0cS1djWANY?=
 =?us-ascii?Q?QTGmdHyjxB8A5VPomQZQKMq8CjXhf6rNPRVU8tPkiN1QlRpxCUQSXPlkO+Dh?=
 =?us-ascii?Q?pfXnwZCC9S7dfXJdzBOQi0vFP9Cy250XoZPWNh5NM0m4GEAqLpc9Y0ybDp3U?=
 =?us-ascii?Q?WTVce/1dTYWoMsRo2bhIrKE7MoH3pk+P79LCb6N4U8kzp4wMhcpcS36VexqH?=
 =?us-ascii?Q?XlgD2+eKx3ThNsU3XKvGoVoMXnAjVVzucqsYv+g6+X530/kZUjWqsy6knrT7?=
 =?us-ascii?Q?PwWgOVhnY3c6GihK23C/vbHO2vYj63Ok4Y4kTMULhKLBDgOlKu0r38hz83mc?=
 =?us-ascii?Q?LAjxkkn3c6H61bLEoBbrhzh1na6n4skvBtxH8ZURK/5054JDg8oydwNaQMCv?=
 =?us-ascii?Q?G8Dl7+sBesxNuF8rPAIQ9GnK6r0RVtEUwmvnvRPyJAoJ2XEruR6KkiN8S4En?=
 =?us-ascii?Q?jxqp6L3QqQyjZCJfy60dF0aLJR2969g9Q43v5ISqIpODr2pvGN8H3+DUhU+L?=
 =?us-ascii?Q?06Akkv/Q7nuUR0y1uHRV676ePJlSV9YbLnQzmc9vJH+pm4xBGcIKwHAr/7Kk?=
 =?us-ascii?Q?BL+iV9NAeUwPn+MjF38SLRfF8y6Fv151ZGS+gYEf4a479wmqcK8RSSkKVY8p?=
 =?us-ascii?Q?pDinEE4BYtBdE6ugodyUBZ8l6qH5nY3pMxlzlDLYAJm2lqgIqshKJvNtJny2?=
 =?us-ascii?Q?TygbFIcWv1dfcMDudFq37/ZswhfA4VarVFlmsyiSG/ehkmX8PCV40621PYMS?=
 =?us-ascii?Q?tN6fx8IM3sEOCWd8zuwiSoijoYm+/yOfRDsj+TDcWaWBU6Waxoyq/KKz+glN?=
 =?us-ascii?Q?95PbgQaNnWcgSzGpd8JadXkxgi418GOokr6ItulaQtTEJza8l6FJqJCI73On?=
 =?us-ascii?Q?TTs1Ug1tzKVUP9cxeS6SWsmvcAGX79Q+F036R3KKkwU8sYfDFzyEe02R7OrL?=
 =?us-ascii?Q?kgF41pfG0gRCkHr6hcpWtUGROk7hdYXkUGKg8h6+NTcHA8qd2vuRrbtIM/L4?=
 =?us-ascii?Q?DrSlUx1ndaFSbjSAaJVjmiI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LPu9cKd7mrPtsN/DkuCXXOPueqi9d/QarYub2HkkRelArAaqLEu4lCyZtSKQ?=
 =?us-ascii?Q?6pbuawoGHAEruTerO526I4NLXCp3AH25hFnOY5asgQfRP86gCW6SJ8y1J63X?=
 =?us-ascii?Q?aokBWWszJzq3wK45gNe+tCQ5RuSaMS6LH1mkWKWqT7dIARQdeuckzn6HfcHL?=
 =?us-ascii?Q?DcQiMdgogb6xLlXzsJED0ovQ/cPcwkQK9lg/OSzzCSYjT4/2/bnpdPzABZgs?=
 =?us-ascii?Q?jKmktAO9Wo06wOU+4nxVDcR9P+r66AAzPedd52xRodzbdAVtcfLXJzZvtWx0?=
 =?us-ascii?Q?j6+WEV2cVazetJFIzDtBMT/Y8BmdAnSWP6baXDNxn+8EpjDr6J0VGpEcmnCu?=
 =?us-ascii?Q?lWhQPU30gDcWzOyEf9Os9gikdrTZ8nkkdOQqL8ks9sTURnEjKAxOsxV5j/TG?=
 =?us-ascii?Q?yGOqSf+iGnEuPSPb7U2TEIv109+km0i/oyT1P7uh8+pC73NmTBC7rSSrqjhK?=
 =?us-ascii?Q?Qq2siYHfM0ncE7mTSBfEHyjFvKz+9BQ1HdELsQ9tyk21Wv6fK82CBKR4jdV+?=
 =?us-ascii?Q?2Q5RsVd0C3gue4Tc97pg7YdMI+w7b+LcMhmc3b9ZJ7TsjDyXbE5x7x2zZX/N?=
 =?us-ascii?Q?TSemoctCMrjO4YY4gG2NNxg56DQx+/WXUyCrqtsRKNQiWdrQVG89jPqW49dZ?=
 =?us-ascii?Q?Se7PY1k0cfySlMc4i+jJjvnDMHCiI+i9Vza3cp4gNcgB3uGgOX+iJbvx7YjC?=
 =?us-ascii?Q?VLT41d8fyl4XjxSXYqY2MpO949pA1mPWSU5GbDhhq/hfFD/BT6yTbcXLHWdP?=
 =?us-ascii?Q?LK5FPhWJZbYUX1hzmSW5M7jFrC12rV0aUVq723dMeFfztO/5BZbRFf0UjBMb?=
 =?us-ascii?Q?+hI4zjubYMDaTJh5YgH4RbNy5CmPAAuaE2UplPBR7kAQf49+EJ6/w6rHrXCv?=
 =?us-ascii?Q?GFuq/hWGfULXZfq1PRZHn8MZWlNYfAzsW9iwu+JCbT3xc0gtPrVDKrqPWW3Z?=
 =?us-ascii?Q?NiQ3F8EBT6M9gCllIPOrXJsj2GQl1vSPZKlS6+VY6NCMM0rZPQSJIss1A/x6?=
 =?us-ascii?Q?yXqcseDGBjnqWN0PoklgceezIX7juWI0MteNXU07QyOjlecChgog2393be3V?=
 =?us-ascii?Q?0TEp6quZEdpWJ5Lez9J12/RNgrhGkyzvlv6+LfAgIM5FoZ44MeRBjD8lXy8Y?=
 =?us-ascii?Q?WJ9bXk3AsRGl93fqAk6T5JfZpNpiYZWiUfzPV1XD5wzZ5Paz4KWsjs55oMkb?=
 =?us-ascii?Q?ssbSqkWa1S9Vp7rr9Hjf0AXc8/ih5swCSfw7Zdte9SygzZSgWmMuMRWvWcmX?=
 =?us-ascii?Q?bO1op5IDC/mje1HuWCsqJSHlMoli/Rp9wuYzQ+EJK4d9YcMzVtcXCKUTG0Pd?=
 =?us-ascii?Q?0a500T6YfAWwzUc+cBPbPLRm2zdjdPpzsuk4Dh/yNKuAm1PW9wHQnG/Kc0wZ?=
 =?us-ascii?Q?7JCQjY5JzCptEcdInlSxMU+NgnJJCyCRp/NGOI/81M51KG5b9WFX0SSlS13H?=
 =?us-ascii?Q?HnrF5lNN4ZlGhAtwqmfgZAgCjkMNYvu6S/Wj9Xbc4g2itgpRAUDX1409oUBI?=
 =?us-ascii?Q?iy5O9Q9CC6CMWcDa0W79XHSBD8hCuf21FRYmSrgmrXzIADwWgQaD39lgxfbx?=
 =?us-ascii?Q?tq5KCuq1Yyd5n837tvUN7WRr5zGIV5c2X+AEmTzeDdnxWWBPI9inQw5/3UvG?=
 =?us-ascii?Q?LuwBCNwupaTfBNKQccYz4sXdoZuDrETI9RLyuLAaxXPm69pwmjPnPIoC/Lkh?=
 =?us-ascii?Q?Qjm0bVv5TcM12R/K1wxOiKa3Uvq8q+REj1b9xkT2xISzMlds?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad970b-ac98-439d-ee13-08de7371e975
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:57:01.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dctLi1maDTXI8tiKA7fIFnc3VI+flhzeRR3eahxgNDVlXbwc+DSLMuBAnazwROwme3nBto+QOWRvhwn54tE4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF49E43CAC1
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260361-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharath.r@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3DF74182A29
X-Rspamd-Action: no action


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Larysa Zaremba
> Sent: 17 November 2025 19:19
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 14/15] ixd: add the core
> initialization
>=20
> As the mailbox is setup, initialize the core. This makes use of the send =
and
> receive mailbox message framework for virtchnl communication between the
> driver and device Control Plane (CP).
>=20
> To start with, driver confirms the virtchnl version with the CP. Once tha=
t is
> done, it requests and gets the required capabilities and resources needed=
 such
> as max vectors, queues, vports etc.
>=20
> Use a unified way of handling the virtchnl messages, where a single funct=
ion
> handles all related memory management and the caller only provides the
> callbacks to fill the send buffer and to handle the response.
>=20
> Place generic control queue message handling separately to facilitate the
> addition of protocols other than virtchannel in the future.
>=20
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/Makefile       |   2 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |  10 +
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 149 +++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  33 ++++
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      |  25 ++-
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 178 ++++++++++++++++++
> drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
>  8 files changed, 411 insertions(+), 1 deletion(-)  create mode 100644
>

Tested-by: Bharath R <Bharath.r@intel.com>

