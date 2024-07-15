Return-Path: <netdev+bounces-111630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E33931DC0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679001C21D79
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDD14375C;
	Mon, 15 Jul 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SquGcMZP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95926143726;
	Mon, 15 Jul 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086879; cv=fail; b=jCPudFsX8dlktChWwYPgqZxsrbARQ5zRs1LffAlw/WMPt8GvZfsoEnGaenFUPWn5sPgTodWUKeVfrFmoeY40Kn6FGkq8lyGo+6cg2ZKzXyuf1qJMIwS9kpSlAmXYILgJw0vhSquI7FhAQuGiqNqb08/5SlUzPubik3j/LyJinhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086879; c=relaxed/simple;
	bh=xt+Qf6hqq7v09hHIgN9voLaVfac7b5BSjBmLpVuT9lI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e9sK8J8aAbfHxPLDIyppgTV1JI0w1pefqtLGyE07XWBaC1ik9kay/zlcGTAe8/hrkZDZ0JKds28yOdzBEipzFUu5VkhxLcWQx8oLFZwmoqKi1BzA/M9Rmz4hF0SuaYBuY6wpKNvMgbrqb3+lBy7yUHXJxhC+45q2nLgAxgZN4mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SquGcMZP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721086878; x=1752622878;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xt+Qf6hqq7v09hHIgN9voLaVfac7b5BSjBmLpVuT9lI=;
  b=SquGcMZP8jVKhRfhqU5cVTgqRlhsIDQDBESISYnxzZmkdPZF99X5I054
   u88DDBRfUTxu+9T7VmmKXW0BW/U6H2JIrCMIZUfEsDzLgi76n0Pxjjn0g
   P8s19Rjktn+Lsn2POnnHpXN1MQMvK3Mm2mNWORm8RNeVfFiCZ9TBeHxWk
   eCSFQoFqoEHH/yWGDPdjwqxOJmbJDFCqSY1R3d2BgEx7ZZdx0KOHWBFrL
   qPRNoe+rMm4kE53eYWpPNb27SoCPdufskMknyU3kaZtKe9MHJnxeOPLC5
   xlwv7pqZmhmwbH80w3PwnoEYZJRyNwJijBedNvG1xXPX5PWhlAGyg47fV
   Q==;
X-CSE-ConnectionGUID: 8KRhoYxTTJSVV7UER9On6g==
X-CSE-MsgGUID: oWkvWQfKSjauKexlgzQsbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18610802"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18610802"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:41:16 -0700
X-CSE-ConnectionGUID: AmlxNlcbS/GZWr5i36zyqQ==
X-CSE-MsgGUID: hf33XWxvTTKzvqRHEg5k1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54155199"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 16:41:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 16:41:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 16:41:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 16:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/pGDOQ2xmroV+xoXma80yE7+Ps/rO9AHuV7SJVqJ+AbVyUNRjM8NnRyds1WGrtRwsNdDaMWdmFpzRbGcoz22jbJfqWFzpwh5cUCxCkbKKTi2pW6yITcohRxFjlCjhrFWoX1O0EMTkpgqHKtLePta27ygVs38DiLA877xpJMHnjiBPgUS8JLrovRM0PJgximizkEIshpJD/6qosKIGrCwTwTLBeqRfHp4R79XOghJdmCYsZaUWePNxBAHCQORoJgaLSq2+nwwDYUuH01uUbKKNeC0rgU+k1D8PGWZ7s54vjWfVuCee6Z4VEmA26N9IA3cT6EOAIn/Fw1H8GbjLT5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg82Ac1BxzM6APAxdmLs5H28w6YThAO8yhGzEFJy3d8=;
 b=D0KRDyzolMhihYRTYqdZpwwvjk6Dn19/sRDJeQmBfceOv9mdvOV8kcsql4IbzfWA6r2A8qBKyJJnigCRCyb40nqYJ8ZiZ6Y7b8BAEq/l7Gu7etHFMA59AAPB/q304YjxH0lIQV7027IhpXe/JBx1Uev5vPlGkVh3VdH7GH2thSoYMuFW5M+nN9gYvRGiPEszSrjhP238MWORQpL+6sQYtK4lzYf8AfNySeipHKWMTGrJwEqrT4ml5KfRSq4FBUhu4rRUWsQIKuoIH4R6V6inC2g5+ZEl1tz72qo+/rz7S2OMYbwkueOH9DNYHEfdu07SrRcIsUNDwbfhoDMWXfE3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 23:41:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 23:41:11 +0000
Message-ID: <a6919490-9ce1-43d2-bc63-5d80d01b1158@intel.com>
Date: Mon, 15 Jul 2024 16:41:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 06/14] net: Add struct kernel_ethtool_ts_info
To: Kory Maincent <kory.maincent@bootlin.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
	"Heiner Kallweit" <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, "Jay Vosburgh"
	<j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "Simon Horman" <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
	<danieller@nvidia.com>, <ecree.xilinx@gmail.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-6-b5317f50df2a@bootlin.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-6-b5317f50df2a@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c00b777-ffa7-4306-6fd6-08dca5279b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1c5MkU0d21CNXYzODIyY1NQSFVDaXVJUnhMN3N0VzA4eEdiOVRwZ3d1M1pI?=
 =?utf-8?B?NkcwbVdyNlZsWEUzNU5VQVJvYm1JWGN6b0c1OGM0cXU2eDBnbDUvKzY2bmhn?=
 =?utf-8?B?aUtYdjZ0RUhmZStWd2xQYTR5bllQVFFMMS85R0xpUXRqVDFDM3o5eVoxbUhF?=
 =?utf-8?B?dFk4bEx5U3dRRkFiNm5pUE5GYm8vVGxaWnpVSWlFYzM5MXhKcy9OTzcyUFdr?=
 =?utf-8?B?aUg0UnV2clJQQUFlRFRwVzluVTNQZlF2VXNoV0ZJaTNkdDRMbXdjcWFyTzNr?=
 =?utf-8?B?S01MMVNCb3BZRDNYR3k4ckp2UmVFOEp1cjE4anBrWU1aMjAyVDBaL1kyYi9L?=
 =?utf-8?B?dDltcER4WEJBQkJHNnJMc2EvVThCMnlabGVuMkZkR0VpZ00xR08ramdmZk1y?=
 =?utf-8?B?ajJYZWNvUlhQL002QzJHL2VvYTJpUmtsbWR0Q01iRVY4aU0wNGxlSkJwZWph?=
 =?utf-8?B?emhsUlV3bjYzRFZ5cXc0bkxBTVJqMUozbDV5b0JuMmYyL0I1OVkwaThaOUM5?=
 =?utf-8?B?SWx3YkQ0R3JDc0MwZi82c09IN1p3MHVjbS9iZVN3cWw2KzluZ2VBbUxLNjYx?=
 =?utf-8?B?YThCZi81cTlMNjByUCtWa3BOTWdSRjlqTHl5clZqM29ETEpXY2d3MmYvK3Nh?=
 =?utf-8?B?a05vY1RQQ3ZoSG5UUDVtRForUEh6eHZtcjQxTjA0OTJHRkRZWTcwcUpUbWVo?=
 =?utf-8?B?T3poeXlaK3luclFFSEVWYk03bHM0LzRFbDhpNS9wVHNtemwzNzFhdFFJYjJ3?=
 =?utf-8?B?VVFlR0tnOFJ4YldDLzltc3lQaTZEWCtDNzVEQzV5R0xWazJURFlFenRtSE1B?=
 =?utf-8?B?ZjFtS3FIQjdXbkNpc1FuL0grNnRsbXF6M2RTeEJrRnF5ZjhaREF6ME0yVy9n?=
 =?utf-8?B?TDJJaU9pYWtnbFFhL3ZQZXZmYWNvV1BwdkNYSlhyOFdpRE9QZUhIam9pSFFR?=
 =?utf-8?B?TmV2ZFhKT3E0dXNRUE1EaTZaTTRRbWR4OVpMTjlwQnZTT1BUVDdpSkllV25o?=
 =?utf-8?B?cmNWT2ZlR1dVbFVQeUdtYnZ0bTNidWlaTmwxUXZlcmxyZEJJYmlHMStOS0JS?=
 =?utf-8?B?ZGliQlVoQmo4T014TVJRRmJDb0JBbTZsUFNWK282dXlVVzZlZXBtV0ZlQm9I?=
 =?utf-8?B?bWxudi92NUN1NTJ1Zk5tVG5CTlZnSGNhelJFNWZjRXF2SUhsTHhyckxYMnRB?=
 =?utf-8?B?M1lwanhybjMzVVZVQWJiQWw3cUdXZVFtaFQzV2lFK1lXaUFSRzM1TTZhajVZ?=
 =?utf-8?B?ejkxbk9pWWw3T1VzZUFPeVJWMldSd1JCOUNtUExxUDRrTE80eTR0TlZDVmp6?=
 =?utf-8?B?U1lmWU02bkJ3R2tNNENEN0ZBTWphTnUvRG9QVUJHbkltNkJpWGZaQ1ZBNkR1?=
 =?utf-8?B?LzlyOUh3RUhkL1dnbGd3d3VXU0lDcnNxRDViWmM5RzFXTjd3Y3RVYklraFoz?=
 =?utf-8?B?TVJtTTdGT2VLeXRmQWpoN2hrVVdVd0NadHVvMzc4ajlqd0tsV2xKTXZDelFB?=
 =?utf-8?B?c3Nab0J0UUhEUFhIQVR3azVCYkpEOUNFaDFPOHZBOFh0YUJSVkxWb0dqNjJo?=
 =?utf-8?B?L2NCQWN0Q0grd1AzK0pTSzlaZDhDalljK2c5cjkwcGJ6Sis4RDQ3ODNnbjE2?=
 =?utf-8?B?WkkrVHI5ejZqSkZWeXpQSnN2ZGdaSmJmeXp1ZjROcUxZeWhpRXlld3FjQ2xO?=
 =?utf-8?B?SGdXUDZnemcyNWp2R2NEcDlFd0N6Zy9yUk9ZN3FVczdmd2xKK3R5bEhRejZh?=
 =?utf-8?B?em0wTERFOGtlaitxaVZmdWw1cDBQNXJJb203VFpwQWpzNmRYeGxmVnZ6QUZp?=
 =?utf-8?B?NytSUnVacldweEZpc1lBcXZxZ0QzWUdOYU5vVlZNTGpYNWkwRHJZUUZqRmdH?=
 =?utf-8?Q?ycIsm9xU7/4Vm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhlblNsQWNUQk9kYzF2T2dSSjJUYUVxRzVRbWUwbUNoSWxzYUE5WGZUUUI1?=
 =?utf-8?B?dlpiQWN1VStLZ2JuNlVhL0NrdS9WcGRRRENvcFdSc2JoMXlmWXdGZG5zenlL?=
 =?utf-8?B?RVZsbmI0OVcyUHhWVHVOS1l2U1ExSXFrNng1b0U0UTM5MkdYS1Q4RDVIZWh2?=
 =?utf-8?B?bTcrMGdBeDlDcDVjMzRCVW1oVmNoUjdrUTc1TDVHU3FJdGpvVTZ1M1Z5WTNO?=
 =?utf-8?B?bTdjVEFYY3d0aHowVElVMk9PNTdqbXV2TUNkeVhFemRSKysyOEZSczBsMy9v?=
 =?utf-8?B?WTVpWTBmMkJEM29iTDVSZ3djVlp6VWZXbVlxWXcxcS9YVyt0RmxCVWlwSm1q?=
 =?utf-8?B?WHNvMUJORFBiRU5ScDRFT2NpU0pibEJPa1ZIVFpUSXZqZmVEV0ZMUkoybndL?=
 =?utf-8?B?UkQ2Y3h2VnFPbUdYK1JOdjFUUE5JUHVsR05tcUZ1QnhyOGNvaTBWaVlUak5i?=
 =?utf-8?B?VGk4SStEMnp3N3JXNXNyU0JjTlQxTjZIRWo2WUhzZlVQeG5TaXJhRXZFQWMw?=
 =?utf-8?B?b1owN01NcE5Db3dWdnd3b2N2NGZjSzFEcm42WWc1VU04MDR0SWdyQkxxNkl2?=
 =?utf-8?B?ZTNacDhuZXpCSGdHYmd3WjBHY095M0VDd0RrRTdXS1pVWEQ1NVZyVnBWZWRY?=
 =?utf-8?B?dHIwZXdGYjhPdWNKNEJmTzBZTzMycU83VzJHRGx6dTZoSkRXT0gwVWZyWko5?=
 =?utf-8?B?MUcwNUV0OXpHMXNpOEk4L0lHbS9pNDlGSXlDWnUvMTdFNEF6cEpnVHZOVzF3?=
 =?utf-8?B?ZXUrd2crOFhsZ1o4RE9XSXBXYklEQm10bXpvc2FaNVJHYmFHN2dZQktpS0FX?=
 =?utf-8?B?RUpzYVVVdjV2K0o4TU1SemxvNlIxYmtpTk0zS0c5SWFIVFk5bHdwU1k1T29G?=
 =?utf-8?B?d0FUVHRMMnYzVjdsMjlWNGYwQXl4Q25iYjNydUlxTGNRYnlTVk03UFM3Vk1W?=
 =?utf-8?B?d2xsR3FTYmt4VEgyUUZHMno4RElXOVhlaWU3MmdlMmhPZ05qYVpOckVZUlNR?=
 =?utf-8?B?eFJ1dXNFVm9QaHQ4YVFuVzAvSDNOMjFQWkM3Ty9NYmhvSlprMThad2NVZC9i?=
 =?utf-8?B?YWhFbDlFbTl2emZRUTFEUDJxa0xVZUJKcmJpTGZYRldUWktFcWFJNFk1T0tZ?=
 =?utf-8?B?QUREL1AzMnJITmlsY3dhc1VFK2xWNW5xdFNEK1E3Y0dMdmsrWGZ4VEw0UGFX?=
 =?utf-8?B?ekZxc1dhMHpzdUhsZG9vbWwvNzdXeDJ3T2p6cnJJV0FKNHlwYmNqUmxHNXpQ?=
 =?utf-8?B?K3ZLZkJzZjBFVTVlcURSUTQ4Y3ppOTJlbjNVajExclh4V3RETG9Bd0g4MEVV?=
 =?utf-8?B?V2kwelJrMDZqZDNaYXFUVTZqZnBQZ05vT09RcWlUMFAwdjRCUG55cy9HNFpZ?=
 =?utf-8?B?VExPWXl0TWxnRXBkaHRMWCtvOXpQNzVUTkhVaFF4dnJtRE9KTk5HZHV2Q0RO?=
 =?utf-8?B?bEEySHc5ZlVuUDFxckNUd3NQNDVmWGJxWHBFK2orSlUyMVJMZy9nczNrN2t1?=
 =?utf-8?B?Y0JpTWZZM2Jmc1lRSndDNEhid2Z5RGtPNnpnZHdNRXZkd3lpempqcHF1NW9u?=
 =?utf-8?B?QzQrNm4wdHFFNG9TUjE4Mk9rRFBtcEc3c3B6SC9CYm9kRnVBczdmeXYyYU9Y?=
 =?utf-8?B?UWpQMCt1cmNnWG5nTGxWVHhmTjRjbUlXa3dXakI5b3doWEVib09SZzFzdDNt?=
 =?utf-8?B?NFkrWmtDYWxsNUh4TllYK1ZNWlZzQXBlOEJCT2pRaFBiSXZ4MEFBU2UyOGJH?=
 =?utf-8?B?UXRsVW90dUFQK3R4UFFMNE84ZG5YU25JRjh5bjNVZkIvanRFZ0pKa2lsU3VU?=
 =?utf-8?B?RlRGazZDU0hRVnR0aXd1MFIvZDRiNENRWURIcGZXbGNNY0JWOWdweWlKWHZv?=
 =?utf-8?B?RWhrenZhaVNFNEFSYzB3OU1welZUUFQ5T1cycjhEbXJEODhabkJBRDRCMy9h?=
 =?utf-8?B?QWxJQThUdUFKRjJRUzhqTnVuQlVqWHZKdVFnREE4WE9nZlB3SFpXTWIwWlVl?=
 =?utf-8?B?WHlRamFJQ2lYdml0VXJsRzhzZEFNR3p4Rk5ZMFZ1Ykd1Sm9EcFpURlBQMUIz?=
 =?utf-8?B?ek80WlZnTFZRbmNPenRMdXU4RFU5eE1mWEpWbkxvRENOSWgxM1VjMDRQYURQ?=
 =?utf-8?B?d2tEbzBxa3BGZllCaTdqRmkzOVh0T29SWGFSWjJmUGc2RVhoM2NtT1dXZDJs?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c00b777-ffa7-4306-6fd6-08dca5279b8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 23:41:11.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnTJIzBtgU/A1jeP4UTmSkYuiPWsx8IM49YeKkwHMioZzC2kmng4VrBRT/xvc2Wrs/0rWN0z4FGprzSvQ6mroiht5MYxaoUUvYYoqGFeHIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com



On 7/9/2024 6:53 AM, Kory Maincent wrote:
> In prevision to add new UAPI for hwtstamp we will be limited to the struct
> ethtool_ts_info that is currently passed in fixed binary format through the
> ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> already started operating on an extensible kernel variant of that
> structure, similar in concept to struct kernel_hwtstamp_config vs struct
> hwtstamp_config.
> 
> Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> we introduce the kernel-only structure in include/linux/ethtool.h.
> The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.
> 
> Acked-by: Shannon Nelson <shannon.nelson@amd.com>
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Also for the Intel driver changes specifically:

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

