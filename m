Return-Path: <netdev+bounces-98366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1859D8D1214
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E2C1C20E5C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910DDDBE;
	Tue, 28 May 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWNHhXYf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BD2563;
	Tue, 28 May 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716863389; cv=fail; b=YS6DuC3c3v0s4FcbYMb/T5V0wBjYOAuGwXDX2FcTrPVZylSczjOBDZ51O+cwAD5mhiWf74U19m+Bu0bcH5MbYX0qsTV9uDnWQVNwN8QPylQRKWUyIMfVnAvQMpd7Gx8pKgc03zfMP9H+bk6p5DxUjKjYODAojNqfpCA1hBnfDco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716863389; c=relaxed/simple;
	bh=SZ8TCnMQ+Bmj9Xwum7m9EsSPD9gvGnosQw1JhDPN9x4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arBbpKHfaScUYArZa5JmpeopBXWtglJFk5fL8fMJ79BfmadO61zmeBR2TodLZh5EKs7vPIzZJPpVz706hBstYtyshqsmnwuhCOgdzQcDJsPmkPtafQoprgIhv3wZKgAFuZo5CZ48wHsF6pdhM1+I7OlA3n649sqeGXwPAJxQGGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWNHhXYf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716863387; x=1748399387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZ8TCnMQ+Bmj9Xwum7m9EsSPD9gvGnosQw1JhDPN9x4=;
  b=FWNHhXYfOTqMbcpqEH2L8ctweukWkuSnBJIpY4vEAhTduWMajD0edgNF
   Vm20WT7E6BUhtKfSRptDhMq+Wqltx+O9o4Qfa7QmzchNtTMWa7gkvRFWE
   ilPf+8th3XVVSIYEULw+DIFDm6r04Nm098CzZjZiDrkRb3ufepwD4+fVW
   GTpLHJZJPPGGU4bSTym3xHTKjly0NvNKkOjDarVpSVDorBBSCCNPMloTl
   HUZAJPTunTOMaSyhztU/w89t8Vd1ZiOZEq1TbkrSGamuzw4WNKN8fhPLv
   cpjJgKu1bHLkrQZ/iufmJZ1NxgKbd1tD3rLEzgEyYK1Yx3N+LC3FRLqWX
   g==;
X-CSE-ConnectionGUID: MF4mdiN9RL+BvhviJu4Vfg==
X-CSE-MsgGUID: WrBWbdBDSTCFnFKF/hkWeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11719755"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="11719755"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 19:29:46 -0700
X-CSE-ConnectionGUID: K/xFa69fRc+GhZl7ZBQP7w==
X-CSE-MsgGUID: 3c4AVBnPRkOtQVXCrOjQqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="58096461"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 19:29:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 19:29:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 19:29:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 19:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huPJnNvXDb53VnJRp0vzT4ikthCLdJ6rHYcRSGofRMrgX2WPWgrHz1SyUpbfJfDoRZfW2Kqg4q6CtY2X0Dj8IMnJXOFXC+jHznGvnjhxJWLanBnIT4gxmmu6JWSQZ7c4y6285iTBqPwN6RrgKtN2FWsKcObXTxMFCOC0WLjZ8Sxrhn5ey8aUB7h0Z1fzBKWkvkfNk3Pm4shYh2VJrE/wKju0TkpchTuAGosAg4+Nn0+EAe79BHbSMsy+9r9kyX7CR7CzO73OTbKcTNta3YdsUTX1MZ/G8CF7NJbA+Yaljn8N/zHNvjlW+N5JIP9O1Cxb/EpGVoagU+PeK+kl9igpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw/RfiZ4Rp7wrND/AIvhqRGUS7sDBEtD5yO7dAGu+6U=;
 b=OEHUM76ayGUyE1Occs5KzCBsNPnrSYD0m8HOwGIGDW5WddWxZ9IckInJjnay9WjaqzIcH3VJhOOO9w1tSzQJTlVjoOntL6LWTZl7uXLHqJlxQ6wtDL66EMqZKcOnppvv1SEatcqa1aT4FV63Za5izgaH2WfUMKmzrNKpaEkTWMjKq1vo1J9oDmg4WPRqI4Krfr6AMDTrrnneXwBgOYgUIJPb5LQcjnsGnjwjy2z0lJ+N8L5S3l5TfgGl4bfOa2uCdcZ13L8NienKX7W2y3YevfjwQmOKPTCEBDxebUfL3FOSl3I6avju//ahJuvTymEVhwTveo0+1MDyhuqUAx4dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 02:29:43 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 02:29:43 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGrb/8AgAB3OtA=
Date: Tue, 28 May 2024 02:29:43 +0000
Message-ID: <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
In-Reply-To: <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB5230:EE_
x-ms-office365-filtering-correlation-id: 2f7b063b-6c40-4daf-e5a2-08dc7ebe0883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SnCsTyWKCOce2xDHGo/S1Qm3yj5m9HPa9yFd0hDVjUnzr3B/Mzv1FAPbY2yR?=
 =?us-ascii?Q?Td7uSlsC0Dg/mDZbq5SNxRE+aw8klyWfP6PEwn0Yf3ERlgtWGMTGUuDwCEsJ?=
 =?us-ascii?Q?BtnIn6AapJZbkiFdx4ZGfDptpVcKimd3lK1H7SVC6cYzv6SEph+4NsbjA3y5?=
 =?us-ascii?Q?Jlzo8ub9H1sN7ECNrROdRPY+DCWDT3ZKlzcTH7KY+n4bgDU03JbAnj63Nb/N?=
 =?us-ascii?Q?EwiJsnQRdhJbtG8w3eaKp81japjEWaIFZeIDRLb0Pg/YZZ2ZkEQrUw6KUPwc?=
 =?us-ascii?Q?U3yhrs8yF47AA9O4DICpns+uTFll8ECn7ZMshEepyhi18cFy7X5blpQ/z1rc?=
 =?us-ascii?Q?VlZvs/jAHLNaA4rR8bLR16xtlf0w9ynq9YTzBTaGYJVeDA6BGF+9JqU3PwLQ?=
 =?us-ascii?Q?XS0xGfHBSnHyHEKToMfnLXJ7002olCXUnd1H/EcCuaGgw/csYuIE5yQDGl71?=
 =?us-ascii?Q?M8IcVYt9qrWzxyE/ppISgO5hdbk+bToE5K2iKittOSTOcXo3ar01rZJjcC4N?=
 =?us-ascii?Q?BYCEHyYzzmxi/l3ToXvBP+uAbQ6gMpKeOWhxHpezPSEKGGKqISs7Ge6n2ut1?=
 =?us-ascii?Q?O6Ie/ToLRwEEH76At0GsOxLLFDIySoUZg5we7gspb3ThZ+cE7NMQs8rrBZog?=
 =?us-ascii?Q?52nfdS6FXq2/hiwBZp6Qf9G+FytwJzqscYxL+3aQIdKzT0YHrE8pf11P+H9K?=
 =?us-ascii?Q?Dgihzv2C1p6nxEE5ccAzvmGnjtRcJMI9uSnaF0uTyxazemFATVd5CQhvhKmv?=
 =?us-ascii?Q?2q4vr+XGYBmpA1lQbgucrh+rg1JqY3Ahg1qA8bioI+6pQMKswE0LDyz4sit1?=
 =?us-ascii?Q?PhqAL9rBaUMdVJq55YDgIs3lXWhxkUfOI+ntjxDs15tx6IT/AqzdR1o9syGE?=
 =?us-ascii?Q?3JIyJLd3mxZkLboGxQ41+p01kV2pcI8iAPqW6asex7GV5wlF/NBWCT5TPSO8?=
 =?us-ascii?Q?oPpTdbB0r0IFlCffv0+jR7HohBzEZg+3EQtiDvI/6SIWl5ZsOf77/zUumpNr?=
 =?us-ascii?Q?d498Dvz4cFsVKQQ10OY0n2ezJ0+Rkq1xlJpE23onEE9aH5CF7mg9/QLTXPLO?=
 =?us-ascii?Q?ULlNULANElZOT0wauoTqTpp9j8yWLUN0Q2wKuj8RDn3amDPNvflNMIDSjZpQ?=
 =?us-ascii?Q?QNFSIh/fjz5EK9oXj3zmOTuOgnjnTwbdin1e24sfXI7S8ad0vYd+8wmPOtZr?=
 =?us-ascii?Q?T5BheabW0515eDYV546y03k2WeZTkho8q5tA9bPB6AWYoi4hkLns6QX54XSM?=
 =?us-ascii?Q?9rzqWVp0d6XwvB5Kn4lyNmWcUl9g124XeK/h4ZvvaaJJE58jn7eWm23kgQNG?=
 =?us-ascii?Q?sT0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gf4jCZj85XvSDZjGwQz4uLPv4INdNYyf0Y5F2kjpR2XkaWacn6dWJCr7jD/v?=
 =?us-ascii?Q?uo+bnR2M96aIebM7SnDp2aqIDPHSjWOQTp8FIJ5/iRFet5Ux6Pwly3MlpSls?=
 =?us-ascii?Q?8Vbxt1WGPbsv1o+HQv77DrX5EaGBqqBNX6NpeDLLAfeoaM8lnzef/vsUMDff?=
 =?us-ascii?Q?+HWIQSDb0lAlIXfEyT1cqxG2sCSTilAkTdB9z/RD/ybLsftUSe9roETktDD1?=
 =?us-ascii?Q?4trfgEPK91fKB29OUQBOUuJfs40M14+9ZCAVq3LZtQUN7z+/M9hzo+dWH5yz?=
 =?us-ascii?Q?pIyDiyUE6i1Oii8rwcZUKaHcVPBWadHpgrd4V7wsyx8rIsxVRcC00W43K9HE?=
 =?us-ascii?Q?mrMGn6kdTwAmBZ7+HstUWFYbB2jI40/pDe7QuIhQa6aFlUDJOyeXt+GgAuHO?=
 =?us-ascii?Q?auAGjQUzWeihL/0HyDyxV4HsW5yU3Q5bUouVGFMW8MDEBzontMorcWdsaxxd?=
 =?us-ascii?Q?b1JXlpsYK9DK2n+m+6Llxl4+oWQAU5SMtIOPq8OIr7dZ91f8DRK7Upocm9RL?=
 =?us-ascii?Q?VyoZTqH2cP/JJ8eDcOrYZYqfv0+FmuDEGM6XApawUng+2aHkxl6FWmsrKBdu?=
 =?us-ascii?Q?6AfuNW/z2K/MblVEs1R8GOMw/6tE9g19slw7+je6ryr4AoS/6O4zPq4TzLQ0?=
 =?us-ascii?Q?6gMsG9YLyZckqKBTtrAFkzClmlkQ8ClViJA+5JGm5Un7dU/KOuTzF6oCRpy9?=
 =?us-ascii?Q?edthuCWBjto/qQnWa/xF/lpSf891kU8uhw4U6NcaBSQne4eHaClxYWAtvWFD?=
 =?us-ascii?Q?SSpcqfVbOuBuWSCfZ205DjL/l1vZV0goizBPWzq2CGRdTXPzV11IQNbmF+2m?=
 =?us-ascii?Q?p7EpnZg4YEMF0nEGCpVjko/3NT0f5Z/olyNeyUR/tNzNgL7rav3iE8exnoqK?=
 =?us-ascii?Q?I7+5z2QhGeIGm4WRizqniZIy8PaDSNBNQeWZah+1Lu8Tbkfbv5PhV29Qv92K?=
 =?us-ascii?Q?paLHTvCFN28xtc/3BAg/nnxSA9D9GXII2GB5gsV0ajj2T92HxUDanVeGosHE?=
 =?us-ascii?Q?wvyfoGM4nbKmx3QrPv+A2T1u9GRy5oViK6piVjqstZ6lRGwXQgM49FVLzs/o?=
 =?us-ascii?Q?vNv3ffNLmO5W3SB3Xh4NU03HvnqE8SVZxxoXsIg9AANHrZCIRaUwf/BfV2RX?=
 =?us-ascii?Q?0VHaJBXqkZ+kCGGi1grHxj/nk75pXovDS90XA5hfoDZYwproeP9k6j2cgBMr?=
 =?us-ascii?Q?meidlsZKxgvM9oayI655+4onBUUfN+wXdx9j0rJMtrV4Hti8Z6O4TiUW1TZe?=
 =?us-ascii?Q?AKaErXBnAN1RL2rpg+Zcqu98Ja81cKfb4LK0eZzbo8Dr71UG0qpWBgksZtx7?=
 =?us-ascii?Q?J6hiUKuF/JiQ9Us4dKeibGx2drvSTQsSNNnVqDi7tW7hFZyFjhQZi6r3rImE?=
 =?us-ascii?Q?7jGuwHbAoZzCjAKAAlGb8paHls3rleZKG0eFVjo7U64ZRQMgMVIPEm2Y6OVG?=
 =?us-ascii?Q?4xewaeC2TCWHGLYajJTmEsCdgGS4PYlMgN8z1Mk+M5DTGSFYE8wZRragPSCT?=
 =?us-ascii?Q?VcWNgHILGyM4tgmMlwpL/VjtO9OfXWeGpbvx/mr8FJjuDETMtCuzd2lA0yrw?=
 =?us-ascii?Q?5ij88YYd5O56MCLVPJyp/D4f0nkISAg2i07WpBLW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7b063b-6c40-4daf-e5a2-08dc7ebe0883
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 02:29:43.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Y9htBblrlIqwWG1L+dpoGwQHk1UaGrgqCyDuFrjL7NRk1t5RK4dzrlBB5cNQy+O5sLeLzGhzii3A134vPTqvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, May 28, 2024 3:00 AM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-
> md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Ang, Tien Sung <tien.sung.ang@intel.com>; G
> Thomas, Rohan <rohan.g.thomas@intel.com>; Looi, Hong Aun
> <hong.aun.looi@intel.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
> stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
>=20
> > This implementation was ported from the dwmac4 driver.
>=20
> How does it differ from dwmac4? Can the dwmac4 implementation just be
> used, rather than duplicating all the code/bugs.

Hi Andrew, 5 years ago the driver was initially implemented separately, may=
be need David S. Miller help to clarify this.
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/=
stmmac/dwxgmac2_core.c
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/=
stmmac/dwmac4_core.c

If you take a look at the code, the register mapping looks different at the=
ir TX MAC Configuration register and RX MAC Configuration register.
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/=
stmmac/dwxgmac2.h
https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/=
stmmac/dwmac4.h

So, for this XGMAC VLAN patch, the idea of getting the VLAN id from the des=
criptor is the same, but=20
The register bit filed of getting the VLAN packet VALID is different. Thus,=
 it need to be implemented separately.=20

>=20
> 	Andrew

