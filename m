Return-Path: <netdev+bounces-203478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1EAF6095
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BCE5248A3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4AF30E837;
	Wed,  2 Jul 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlIszIDn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6F30E846
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479018; cv=fail; b=Xk4hMBot6UmPNM5g1EDRQwHY8dTyBiz9z19rrmUyhYZjnd3xsAfinNXRKABkMJIvFC3iYL8Gr7Qx2FSVNOse7QBvw7n46FVue+OF0WXt+QPoo2RWs3chIWLPFH6tfiIw68vDD2kwb1gZKlKnR0Fqvm2kg66Ni6uxiTvGDCsAnJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479018; c=relaxed/simple;
	bh=sVCJMo0/fsFlrIWzBJJqQbaMaCEisss7vPPCp4gdMdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1okjFahJ56/zFoeWkrtuInVEGPkMOnuioegAQl48VfISs4jse1yJnFROTs/I0qCZIddR0+ECrffJX5wPP5TA3saqF9diCm8sFeAz5/08X9KZck/MPkBahgJn3H8CpYnjbDBsCASoXYxfr/REYlrk306Qmy2EhMUn8NFqm8bPow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlIszIDn; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751479016; x=1783015016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sVCJMo0/fsFlrIWzBJJqQbaMaCEisss7vPPCp4gdMdc=;
  b=YlIszIDn/YgU1IeCPvndLykctM97V7mTeyirKSDBd/ot5M/1snycOPao
   mLT/h38PO5upUBZhgR8BSuhXwbiU75Q+5+xfVQmy1v9qZYlv81+EhdCIM
   sRp2ucnW5cn3Kq8PlkRZdfA4L83uOMClVbjqahzuntM9Nda389eVtTrpG
   cCRDhRcxItYaSRaLB/0PoKH+nvBtb1GEkfTkVP/+LOtKnWlIDuH/rGdyw
   4+aXsPP5b1hxk7Ith8oTU/ogs9tEFL2gIjhvkPzOwSYjcBrpbzVhAvFE5
   6cpUhMHL1TLhO3UtAPc0WFbQiP3tFpz0KnQIED+MtsyemYu/J0Szqykoh
   w==;
X-CSE-ConnectionGUID: 2vVodfVtTy+q2/nZUXwCYg==
X-CSE-MsgGUID: Cff307jeQYCltkf5jJeY6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53653515"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53653515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:56:56 -0700
X-CSE-ConnectionGUID: vJhm9RVuT5ObmpM+OKmtUg==
X-CSE-MsgGUID: ywfmo46FQ6S1jneEInLVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="154224100"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:56:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:56:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 10:56:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 10:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUUztIcUWgXcm07moPmovQv8fuuQ6XQnAzkurcz9GiyFz0HRKv8l4WCeuaLdOAPc6Sfd5T5QpcqWaeX2ICnmh5XR/xacDpzGS8SD8+xm+wx/Xssm79sQjXEHqWc0tDiPD0FLpcVj1tKnGnQrhK1yF2LafxfmeN6QT1xcgB3L1i8ycBBsLuaj852A8twUY7nTEapoAo43y9jClcqXHjmX0OfvQOfDqspTj5jgWVia+IXMKRP3D73Eng8hlNt9Pazk+G8AOYZV527PbmblDQ2aUkWEqXdj2wTB6TbkhzsdgJ/ijmxteIJk7wOQuTxHpign5JCdhIrxayzNSplFRnDdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQqdeEAsMA/qcTg2WjvkdU67gIlnOw1a+5qAPMrlKL4=;
 b=IrVvfcqHwDepbuZ+afNORax+etW9y4pOAJVy8sFNnzJfntfKfGw4NeOsf6e+2F9pxFc2kpEHOSM8dFNI4Td+HQG38uboPOsityVZRAHh3IlBu6/fClkjAFCJP2uf0sEDM2OuYN9NgZ6Nv5AOhzglElEFaXhsbKDJLnypEN6eNzH/H0Y5SPFEqf5WZ8u6opsZnrsZiZzqfmbI/1HPritbYfYXKIptEyIpT0M/N52tmjmJbsAf3pDNBTlCH71v4NzdDtFyih9y4LUD1EZA3y+gQWAjiKF7Pjn+eZ5KTXjzBwpkD77yuO+s89N+EyiPM+mtAo8vvdQ1/bH88TGBl9teaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 2 Jul
 2025 17:56:49 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 17:56:49 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/5] ixgbe: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/5] ixgbe: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Index: AQHbw++J6QYW6vs5bkO0t0fxOcbsH7QfaI6g
Date: Wed, 2 Jul 2025 17:56:48 +0000
Message-ID: <IA1PR11MB62419E27D8BA5FEA9B7735C38B40A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-5-vladimir.oltean@nxp.com>
In-Reply-To: <20250513101132.328235-5-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB5781:EE_
x-ms-office365-filtering-correlation-id: eefcca76-4f71-476e-c6ed-08ddb991d15e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xK/31D1ZqAwuecFw/rfYxm2EqnffSr1ZfJfARXweDXBYTMXypWRvupFgdypB?=
 =?us-ascii?Q?fjj0ygLR3tMMdYfFwWDdc2mcfD87skF5cc9yKf3PZYUTx6mRv7hHMDK3Pz2C?=
 =?us-ascii?Q?bo7LPdgkCt1WFKL5R6yUt544MrHU1KWAxYpagbOVqmchS2IskfTA5KSk6Kln?=
 =?us-ascii?Q?VNyR2IkL6V1syjauMxcA1pnz7vlsxR0E9b+enC/0rJPb6d2jH5j/EMPRF9+n?=
 =?us-ascii?Q?Z9Nus0ySYzTIlUFdPVeyoZ40PdCZDYvo+pZMwGYC1miq6MggWrQOif4zMEc1?=
 =?us-ascii?Q?ae+iezyJC5fNdXnnc3B5iooW5QrFrgUX6Mt4k4Xk+j5gvserJwbJ2mezlbkS?=
 =?us-ascii?Q?r8Zqj25wxa/Chb1LYBaF5ksOkuCuHnaGELwC/AY825HJRWbrRPfXDu80Tp+0?=
 =?us-ascii?Q?d4dU90IUVF5NOj85XBc68eJNM3uxCZ+5rz3Y/mGljH/tjIoHWAxwYc7Frvh/?=
 =?us-ascii?Q?P4jmPZJ5etTjKrAmOM9gU5mX4xrKIj/CsHqt0vtU/zFqnk4vyW0XzXSDxKBl?=
 =?us-ascii?Q?8ESKjyh8RHEwswMAJIU+va2mNZ1BiJ3BzgkrjyvWnC+BrvLOpA0MUhPrutIm?=
 =?us-ascii?Q?yiMQpcJsPDbJ6Ll9RIxUTksGVBWrDgNIRxdUcwT1WWw/oMUcQnRttQhnYTW+?=
 =?us-ascii?Q?Q3DiemcgshhA3uLuk1njtyrEDQ1Jy+9Xkmwz3wdsrhzCznmDuQdvsIZCbSyB?=
 =?us-ascii?Q?oM0CkWcWw03m3fqgKcPPU0lIohlj36WxXue8sXK3OKkwrKxn6KlY9GqcB0vk?=
 =?us-ascii?Q?kLmoxcN3mdiPW7om8cHjt3QNueDFvHBOdScJ4DIwxw8R5pUPRzCIJqGSJwZ/?=
 =?us-ascii?Q?dGmo2I7JFvj02jWoSV1YvlrTehORhdyGKW0EAR60mD5jeVcUoUA71OcFFqw4?=
 =?us-ascii?Q?x0Qmj/z4AufBQgUk8gfWhn5wBsplxtLAAJ4fKIRBXhOCAA2QsWdIh78sSi3m?=
 =?us-ascii?Q?B6YSCaZcafL50NXqGP0CdU5KMKtQi4fddynM5FOqHdFw3M970Hu+a8ogJefH?=
 =?us-ascii?Q?P23ZlJdUqJiqi8NbMruJkTb4qOSG5L7WuhPLY0wMne20MuK/YVsIC25Caa52?=
 =?us-ascii?Q?cu7xawlcCJtFL/288VBwHIMDq2DyWI9dNeNtxwC1jYo+LWx7O+I+VMffKNcx?=
 =?us-ascii?Q?Wdw0LgyDvb2SRLadprkVFb83bAmbVMA3T9h5Ei6Lpt/ZgEeeoxTuiQWPp7Nn?=
 =?us-ascii?Q?TK0IvWagu6jV3k7JAE2LtwPyMMBt2fna2CTcEJHVxAZmp+J0mkPvJmxW4AV/?=
 =?us-ascii?Q?bmwHwU2Z3w440Yq0GiAfhGPqQhp02lqu5I+YqHvfkgLLSRqWnOROEm3q34vk?=
 =?us-ascii?Q?rh+Ml2VDsZkLrqQ5wKXjC52evDlnZD36n6uJicezqyWTkGd0VABwasgNOO8k?=
 =?us-ascii?Q?bje8HiChpESnHqgaWypBgJPjg+P8IaaTu2QvGJZm5ugEPeR4hyT280SGQwXm?=
 =?us-ascii?Q?8qu1ynQHBN0xKMZEV7sbVF6F4g6/jm13IuCAiJzdL/AlKAv+7oxXiw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F95YXtsrg1s68eFCRqu24VUlNN+U+Qnm2/21HewImgv9Y9t1d1vwYE/c8het?=
 =?us-ascii?Q?PeFfHEtX5a+W7POAjhIwaUDepkH/obL89Ork2sjFjEM2tNgXzp5QT/IVpM4Z?=
 =?us-ascii?Q?RdoLVHJTe5A6DszWYtex7qG3i2/ky5aLBFzA2aHcqkBhFR8mhH4Hqf0DXlKC?=
 =?us-ascii?Q?IH2taDdE7w4o6oEgu1fX+TmsqK5YBoAnLRgOZzkhgD3gU+fXzqxWISAYto+7?=
 =?us-ascii?Q?YJCFWfMMBmveLlqGDF0sPXWWpNPTHoBfmdNDxb3FUCXzOsK3QaqkHkDFYdq1?=
 =?us-ascii?Q?ydMD53Ia5p2a85K6PXXFy9gLcvvK6Dc4d7taqx6LtUsnmKjHzjgGIotTHXzd?=
 =?us-ascii?Q?qgYPW9RXsrPEEW8Qgzcob61TCL9Jr+vt+dhFjbFt1vcFdWcZJBm44F+z4NLs?=
 =?us-ascii?Q?FZmvBuy4K7B2JtgAsAOMbm6u1wG9yOBJ+KtThYCcjuyCcskmCDJYSvK3AIY3?=
 =?us-ascii?Q?iBrQH47O/Oj1fv+4HfOYK/A3IWuZXPLk8tFsXc+Lf0+G7wWoHIpeApkQP6QY?=
 =?us-ascii?Q?YJOOYe1YBmUCLqlwR8kb6JYBIT3zm0/0XxfRv1vP+gt7EUFvje1Wu6rGRT88?=
 =?us-ascii?Q?12XrATxxJM+qA7sc3iamTrVtRHNRjC79FX4PyNkX264IUS9eErTfBdD40+S4?=
 =?us-ascii?Q?tehKwX9oxU5vPPnsKTbnZ49ljKnrfkwtCDJrviMbJsLCv2iqV2v7Re5DI9uO?=
 =?us-ascii?Q?e8cVvGfK3QbUW7+/7KBnmtamQukLZc/q01P1czF8LyeZFSnR16KN/NM3QcA6?=
 =?us-ascii?Q?hvFPkYIh9m689OnGZWaUn+ZdqTiEef7JcWpAKmopYNDW89tvCf9PL7n121jt?=
 =?us-ascii?Q?CffXtBnPIOWgnmfWy3p42LmLdDMRtlJyT8gFk+GRvk8+DQhhiH4xTnQTjUkO?=
 =?us-ascii?Q?5oxnmuK0z0m5RkoP1a5h48YfLj0xncTdh/GYTd50fyGwN58mmHQ/1AKu5qZg?=
 =?us-ascii?Q?QERtTSB2RiWrQ1hENxPn5S8k//GprSGjrk91x+K41bGPRevpX0+KA7SgaVu0?=
 =?us-ascii?Q?PI+XcD61F05UawyDuKwi4BkLZAgV/+j787rxii3lOH2guiV0/ziXzFdPC4nB?=
 =?us-ascii?Q?P2yTYhRFACmJZr/QYSeTnLeCmO0syDw7lVwpL7zf0nuEV2Lcp6dSAgoxwezr?=
 =?us-ascii?Q?HVLbrKuqX9vgLvR1DW9R6XUpVaueUBrvJQmjU9bd2Ie7/9PrxNfBxLflWb5J?=
 =?us-ascii?Q?e2f0NbcfFFn6tk/gI0h45/apzZVZYS+El6uzP5LZK6RUzfBmrpOyUL/fCDVr?=
 =?us-ascii?Q?4y7lEi+7nht23quJZm0E6GItlvQttZ4Up2FgrlMahqU7EPk4AAVcpKh/TzuY?=
 =?us-ascii?Q?0uYllX8wqN6o/WrfPHYr3adu3duL5b9gcps4fWxao8cNlUHNEXPpD5ipM4ma?=
 =?us-ascii?Q?kUGlv8xrN1aqAwZH7Voe2rHIyMLlrc4nrtUKz5y6yFi8Xzj2IcQp4ZnH2DWp?=
 =?us-ascii?Q?aZrJbDGvuOFGURtehpcFvpC0YNGRtBJtsqG1oSBhkFg27gckGCR88EZZovfW?=
 =?us-ascii?Q?b/DN6eHeoIdT142Dgpokd9MaBcmAcxfHRxmLdxV6IsTbIoL8Z2dVQN2DKkPN?=
 =?us-ascii?Q?OGbrOKq8WoX8/enZm6K/W1kw5IGjE62y15FiSmPHqJ5deui6KJdaj0c1r1pX?=
 =?us-ascii?Q?WU1bSU1UGifKQUp+0h8ExdkrzgdtbsxNDDGX3jqpItTt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eefcca76-4f71-476e-c6ed-08ddb991d15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 17:56:49.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBnnOuwTK3+59c1oliw04yutELFSA78UrhHzT2NZ+nBs+MX4QXxzk00W/Cd6T+EpZLEBfvdSG8IbWA8L0IXoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of V=
ladimir Oltean
> Sent: 13 May 2025 15:42
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; N=
guyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemys=
law.kitszel@intel.com>; Gomes, Vinicius <vinicius.gomes@intel.com>; Vadim F=
edorenko <vadim.fedorenko@linux.dev>; Richard Cochran <richardcochran@gmail=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 4/5] ixgbe: convert to ndo_hwt=
stamp_get() and ndo_hwtstamp_set()
>
> New timestamping API was introduced in commit 66f7223039c0 ("net: add NDO=
s for configuring hardware timestamping") from kernel v6.6.
>
> It is time to convert the Intel ixgbe driver to the new API, so that time=
stamping configuration can be removed from the ndo_eth_ioctl() path complet=
ely.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  9 ++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +--  drivers/net/ether=
net/intel/ixgbe/ixgbe_ptp.c  | 42 +++++++++----------
> 3 files changed, 29 insertions(+), 28 deletions(-)
>

With the ixgbe_from_netdev() change

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

