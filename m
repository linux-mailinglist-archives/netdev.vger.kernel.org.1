Return-Path: <netdev+bounces-69202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4284A15A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C7AB20FBE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B544C9C;
	Mon,  5 Feb 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+Htr77P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604147A61
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155513; cv=fail; b=PMPegx3vyFW6MkEDr4HRUDf5I4fH6vRYVNslapbngJlxuQuCNLtF2ThMlXea6mmnxBjABTRd2A4deScp4stwnPhg8gjJWxhE4MJdC50nN5pBDdWt3/y72u2xJxL7ya/lKnbfu5YnGeBjQwndUypWoRvLABTr5Ng+dj5g+pPc9OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155513; c=relaxed/simple;
	bh=VAhT8JySrTlTqHxtlx9lwUUD5jBGmDLHsz8pX1hGtL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JwvQbXMd9ED32LXrPG8oj4p0JgmUBziT4jkRCaJDYGyBaHICkXJrJ87PmzlCWq1dtJa+Y0Dsf64AiAYEYXVNvCE+x+o74fK74UPo1wEK5cvr/ZL9Q9QPuxV2CXfJVFHAiEgPwzASIiD041ieZ28ERmsLPyrFEUFyPbrG8GebD/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+Htr77P; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707155512; x=1738691512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VAhT8JySrTlTqHxtlx9lwUUD5jBGmDLHsz8pX1hGtL8=;
  b=F+Htr77PnTW2r4CRSNv3HSlY6rz3p0Ad5fV1AbKsm5Cbqe1M1sHGleGZ
   1yhvtnMSRC4lDuvyASWKXZRq+0HohL1Jwbm1PuCtm2XLDotykNnd09ewX
   Rl4TeHuoBZ/R4p+P6Pk1ec+RJJXI2u6ScAztAc6LNxe69h1nxdO+P5xW8
   3cJqeG4sY4gfaxANQeHFyj0H5y82XdyeNxt0RTAEbJ+BIu0RrA64RLlV6
   xEqcWEk8gY0ldxNwRdlm199Rh9xd5NOtQNXFcdt10p0AeSxY8v7ZN1XzD
   iln1BxLZ5+OwiJePvLhIlOl8VvCW3iM3ag8mQGBxuVXydoMu+xjpydWvy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11938543"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11938543"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="784675"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 09:51:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 09:51:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 09:51:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 09:51:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 09:51:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBTJEoFR2aNtAO69orh5srvRDT8gUEFx6TDTs9ZgGZy9ZYIAN+Lpirt5Wg1hhj6emj8uux7onIEXJJvZoPrLTeNVUhGHLGW3lurheFhOHYFvsWznkYJLG0N4gdD/LW1GvJrDA9gFryy3gTXp6OqHzNOyfDc2BDcLAiBiZoWs/JrUM/k3incP2kXtY8lp7bCaE4xiBYSi099npOWv4naWkDhl0/X+TMl/E1rB3P3Dp9T2BvP3UkbMCEHOrPc6u7LJZ6Hq1ibSoHshF7UpgZmcEysUGdQbB01CH1ad91QUa69m9RvHVERyw9y8yPGUWzzjoyKcLADrG8IKowwx2kvb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ8VS5H5KjlMZXrxT1wilhPqZOUC1guec+6Zlk7wWXA=;
 b=H/KKS2n6/f4uE49ONp90erNn4jRfo1fCttIYEUlXbTr0Flid2krk2NBHB6VU7DQfLY8kFsbcmaPAFqSwEjWw0+57NPt2Rr2N59D3lyA/wQ3UsJ3jjsaUFiXMh0Bvv6kxSstXVO4Hpo9VqSiOC+muej2V3ylnvNGbWh4RAoGmeQZIyy5LaNBW0lQ7pXfmAJYpcmAoqYi+9GsZHaJZ75v+HYTmyK+5S92QMFcKWwNreDnBWi4pfpRY3s9/aOvQNsrLwBNgSU6njjN6IRoiiKArUVb91PSL1phyfUjoen9WMWtsmypTtnqzHPOpkqYAdTPBfILWl8rrS6U++xNBFXhORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:51:09 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 17:51:09 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 3/3] ixgbe: Clarify the
 values of the returning status
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 3/3] ixgbe: Clarify the
 values of the returning status
Thread-Index: AQHaVDa1jfDWCibsFUiS659l28Y6OLD8DrgQ
Date: Mon, 5 Feb 2024 17:51:09 +0000
Message-ID: <CYYPR11MB84296F8037FE3E077A32E583BD472@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240131110419.29161-1-jedrzej.jagielski@intel.com>
 <20240131110419.29161-3-jedrzej.jagielski@intel.com>
In-Reply-To: <20240131110419.29161-3-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: 545828b6-e0bc-42b1-f40d-08dc26730934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ft6DhQmhcW6Wp7a5XLv4q9AuHOuL/AQp3RCnBybXHjNmJXw/YIXOB8trXxSN62XFZTfUf6tjhX1py7mZuUm1w6BNsLUJfkwbGB2Ki8BQF5R6xnspMivwtyat95ouCn4r3XWST+Na/KMCRAk0lviBnrGj2QsNUyTgvLu2ZQBVocTWX0qGXaXnuaFeR2Iiepbm3iUrsyPjjYJFs7HvCKXlSRO6GOv62gorrhCWCn8eF8CVMx67W6ekPQuJjX+mIU8LGRCgjbDyYbtzPL4VBbt5D1rdxylKYv84Ff8Kj9AqZ1jSGTSDiB9ucgi7TjcngmobPir4oPRLPN/yKZtZZfG6+ByayQpEyKgR1rfqAwdjSatDbucDzUujpPrxT2iehUGQAlM2g3mB91b29E/97mfut2DOhk9EKG2TNQKGoIF3xyda4X3qCmqvieLGSR7dWj2RFdSrvTH4UNUIgaMkN6ExGNX5urKQhSx84pV0FtPkDFRqZ8sg3CvhD7IzZE0EURWcdDbip5/VC8ZTtD1HwE+1nLWgqrEWdIWzd8sqQcFc15n5VSSOzqeBN+O6MVvOhlf800nwijkWRIj9cFas4ZPXFSqBUFJvkPeWgzNR2gPbYFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(33656002)(26005)(83380400001)(55016003)(71200400001)(41300700001)(5660300002)(38070700009)(122000001)(66556008)(66476007)(38100700002)(64756008)(110136005)(54906003)(66446008)(76116006)(2906002)(53546011)(9686003)(86362001)(6506007)(478600001)(7696005)(82960400001)(4326008)(52536014)(8936002)(8676002)(966005)(316002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LkX7KCnRR6SuY4QbBYSF1dhPH1xd4NsVx6fjnKiUV0kCl7nhecZ5pPt9kW8k?=
 =?us-ascii?Q?p86Nsa9tOzKwS5LZFtPluZGVm+D6kaDrdMy8RUxg9mf7aN6Q4V3AcsIej5mQ?=
 =?us-ascii?Q?bFM8fmrsKwONVuGwmMjuJ+uzjUfOUWx0Kk6bohEMDEC/lXsjkj4VBFUS11Vn?=
 =?us-ascii?Q?chbftg9fh/+twk3/U1x+/5jmU3Bb2gnLElkdWqQXeBBiuPIqYEJOg1X9Qo/T?=
 =?us-ascii?Q?youdkgpj9PkpQ4M5MRh/BL8tnIpQrLcCa8p6TABJrX9Nqb4Rzrw0yClUVBBn?=
 =?us-ascii?Q?o+ct4nrMNB1HUpEqh26mQmBvjBa3dg3NMp9iC+cMXilkNn/Ms6Ba+P7NbOJ1?=
 =?us-ascii?Q?NY+OzPMx//y14F0TZC2bRhFd3pjWQbjnHKmSZRtAu7eckQCVACKARIO3I0ET?=
 =?us-ascii?Q?9oaykdyYbuRAqDAUqKpxwwiTOifHn9WC8wG4uWjTn0/F/LEV5bz+P9B20eu7?=
 =?us-ascii?Q?Su0v8vXXtquPpCzZjpWhcKMbI4T61PiMpaCDTiicooJUDWHyR/5rP9jJWN9n?=
 =?us-ascii?Q?8mqkI1qveGMM84UrmuKKrq06BFzUat0pd4akYXPJHkf1ckFMzhEGHTAI7PWF?=
 =?us-ascii?Q?77KuV8epQZZS2noBZgmv7KKRRM+tewK7tyMhYdAAn5weHMBrwfLiqgnsQXZK?=
 =?us-ascii?Q?TNhkVHVBqurCz6ApdR7Z8xtOTJimpWU0htPKrxhHmfG7tvSOuuMnImiKuzW4?=
 =?us-ascii?Q?1jl7gWwQY3QKtg8rEev+wGELR3DN9WIxZu3AE9BnSJc8/IDabJqdi5dQQx6m?=
 =?us-ascii?Q?pMTS/j6dOC19Op2+h4W7DS8c3Jrw9gYlmdMC03gMGl4wxxl4756h7iIyStht?=
 =?us-ascii?Q?ySOFcFJo5JDuzgCcB7RBdv0mvCtoAh1NvPvHiqsoQes2WjBnCcSjqjBSofcj?=
 =?us-ascii?Q?Omug9u0fwS9aJNRi+dKmXWPsMKDrrxqQxcaJACKWZngAzg2iO9geBMndf75d?=
 =?us-ascii?Q?fIqkHUR8Vatdb89MVdyYTyW3VAcVqAwtvxiYKrcsumdenP3MUV3RoJo0ed/K?=
 =?us-ascii?Q?YWq7BlTbATai5tCS9F0lZakDMjk7XAMPWh9fX7YRUax7yXqn0yC//FJ+Ib5W?=
 =?us-ascii?Q?Xk0O3vGo2vDM7fPgqSzGpGVBleoPu7aH4lHAAl3dVIinUP8/JM9dFDuQ/NcW?=
 =?us-ascii?Q?MfHl/Rii/Omp0eZz80lZuRAVEt0Dp8pQQAbc87hgpegbHtJLamK7j7nYVp5M?=
 =?us-ascii?Q?aj2pJGmJntzIoJLHx97pThqxi3lTv2PWPbfQejdYy2ja1afg615wfCCXTwKK?=
 =?us-ascii?Q?wn6BsNyuFJ3Ep2wdYVF8h5Tu0rzzYBbCekCCNV9kOSYrF2rADmVkZpPFAZjP?=
 =?us-ascii?Q?+7+0s2b6+0qXNV+DF4twk3AGkl+NJZ2oZLJMMu4+TC+wTstkwtlLQDDgkTfh?=
 =?us-ascii?Q?tRG5a9efVjNdWOYFe2/Tv/QT2sDaGrdorblewfilzycg1OlB3qbTmSuPmx0U?=
 =?us-ascii?Q?1Lmec6LW16y0rkZAeRe8cbgtqVuN/uXYGMjoGMyVnJDKlVZ3XMNWB6qy72nt?=
 =?us-ascii?Q?+4GbXPREaDqFGAbU8KdDOcoNn3jFMiX4aPyPeCl068s9R5++7dbNoKGiMjPe?=
 =?us-ascii?Q?6RCszlVEOHM/MT2Rgt6W8Eih5oVdVyCaMxiyRotv6QZriJN/qq8ASxUgiO1n?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545828b6-e0bc-42b1-f40d-08dc26730934
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 17:51:09.6688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JAAkHrzoRJ+wl3Ow2Qdc1JF2wadUfLSUP5GI0Cv0St+63QXxeimvSDGPF2XkUoaJDvQkdsAFPmvTOHkfak+RcdMenJulBtwXZzBZpK767OSrQ5lxCszMNJwfi1dS91j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: Wednesday, January 31, 2024 4:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.c=
om>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <horms@ke=
rnel.org>; Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 3/3] ixgbe: Clarify the val=
ues of the returning status
>
> Converting s32 functions to regular int in the previous patch of the seri=
es
> caused triggering smatch warnings about missing error code.
>
> New smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em=
() warn: missing error code? 'status'
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x55=
0em() warn: missing error code? 'status'
>
> Old smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em=
() warn: missing error code? 'status'
>
> Fix it by clearly stating returning error code as 0.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


