Return-Path: <netdev+bounces-98363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737F8D119C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6991E1C20FFC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11EC8FF;
	Tue, 28 May 2024 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdQ80zzy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9118BA41;
	Tue, 28 May 2024 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862023; cv=fail; b=NSYcMSsUr2gmG7JCZlOaaUuCPzpEJkyAC/PQvSLjzKr3vUWfavClc/C2kHDX9MbfkYjJ5VoHw+rkZMc01q6mb77aeSwQrq7t3jFR/MrQ+sx6VOcPAtNv04qFEiZOo4f8n/vjZbBkZkKwW0d+gNIqHFU9pCtOxEylnPK1RsOEaPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862023; c=relaxed/simple;
	bh=NVcvWHyf1EiGvqycquas9663wgOVLm7efo2VCv4vFnw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V7/gAhtbeFnYObm/Mq42bEWXcn6bxPLlxe0gra9BZMCrU4XwKXDlMOD60PYY9wca2FagyuEx0RT1JHVpGs7c0jEAaW6UYrYKiwln411vKnoHv55DarOMOLmWbK3+q51q2CZahie/sBznesBh7nf/RylQx7UTIa/hLhkMBIl/EDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdQ80zzy; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716862022; x=1748398022;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NVcvWHyf1EiGvqycquas9663wgOVLm7efo2VCv4vFnw=;
  b=kdQ80zzyqOfZuQ7SHDHs/XR/Uqf9bKWqjB63OhulZQRaN7AjKWYv6UaZ
   j7PcvALNYzozVfPGt8CMMQeVch9zmUN13P1lJ7M7QB0/OVO2n8OFmrFhO
   S63f2LU20TElr1h07WJfOa0ddymdmFTICRpeFSppvXH46qCQY4h8Czxm4
   Ts5PKGLNY6aQ9epb8yfuheqM4ob5IemuJm7um26omYOI2rHn6DCp4M/GW
   PZa5nZwdouoMtlTZmh4ELvEYagSo1GvVI2M9onzYnQMU+oaOKDgFzP4pM
   gKkUJbr9aNDYl/3TOt3RCH7jyTLG6V1lhgiaVlGCm3bJxEXamEYK7sEY3
   A==;
X-CSE-ConnectionGUID: O8xmvzRxSLqqaDkKaw0w+Q==
X-CSE-MsgGUID: sstjn3ePRYOU2Su2CUtLGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13027306"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13027306"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 19:07:01 -0700
X-CSE-ConnectionGUID: bGJ7j6z0R+WDhA93IL2b1Q==
X-CSE-MsgGUID: X9opswG2Q6OSJp7z89i9jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35384459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 19:07:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 19:07:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 19:07:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 19:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq6V09c/K7bosYXZatdMXHHXWOeIDAuwMlf141nx0oN6mwF+ppIxv33t3ykXTvZYcXzDFAP3QSbFd/3/fLM6YV+krjOollTb18GGGqoIFhJB4/w0F7gbVGsebtK5q66e5RDjcGtzfJKf5JMAUaJ7Lxl2JHC6wCif0nJoYq5N2faKtZlxDK5nqi9cKUIftGM1M8Gt8rvG1TwD+FTx2yDNpR2qDgnOB+3X4n8Qx01JUsh786KI3y+OngOLhnoWvCDnwb8up55+0gT3T7xWJyK31nnzJTsZjpc4fzo/eHc28uenl2SCwba62Fvo6JU0eqtUwVwO1JuC0bAvHCTJwWMECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVcvWHyf1EiGvqycquas9663wgOVLm7efo2VCv4vFnw=;
 b=aoypOwyiQfvJThvPl3av2yXE9IV+bATXakm5S5vPtnlzOilQFKSsy3yhkCXbix1XfQ73XS+ymO5ejWC4GJ3EaYHHDvzBwqafWaLfbKmmzDU8nr0Kj3MsxjhBYdagwQScorGiiH2PQsArtxv07MZi/LLY4DRH50p/E8GOFLmnfB8rCfsWSzwUyMdgQJNKAjlvgS15lc+mgU+bfx4t6T5hOmvzwGIwsuOgBQipDV4nNeglN0XSlu15N/Wcm89gBC8Kmi9owkTvc5scIcZr1x/5vgIAcBKKNrOBevsFiYfeJQ6SMjTFFjKq6UmfGckiUoZMVVg8yMjTqemkvS91SfnNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.20; Tue, 28 May 2024 02:06:58 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 02:06:52 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGq5HwAgAAuTGCAACRGAIAArq4g
Date: Tue, 28 May 2024 02:06:52 +0000
Message-ID: <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DS0PR11MB6422:EE_
x-ms-office365-filtering-correlation-id: b1a509be-0dcb-4b56-0980-08dc7ebad7c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZSKnNlk9VbJUuiJb8kj5Q+EZl36B2yPFQSsQYOU4aMUtkVefYQqfD9g1ZyNG?=
 =?us-ascii?Q?JhqLqDFZW7xe63LX2tzuWEhq3XIOSNiwKw2dktkS96xsTxZFco2kKtDYjEJ2?=
 =?us-ascii?Q?0sxG2Jzh/pQCyPJQkYNcyl2f0sLGaJlEiAJBRwo3mZC5psrLWs76Prf0YCNS?=
 =?us-ascii?Q?pvBRGsqKIH6FTFuEyehKAU40H52Dv4RB7SQwUGIJa9sdBJQi+VXjXB1g7IQC?=
 =?us-ascii?Q?2GdcLlLsxwgiw8MrvSdq87TB8v4lZ2zXlh0utzH07VzP7Bmvb9jh1bk0t/CC?=
 =?us-ascii?Q?ADlcrK3dJRLHRSJp5Zmxw5r2Um7iNxXOkeMbIYCI1Y1uXN8xy2Zkmx1Xbpeh?=
 =?us-ascii?Q?ekoXQBDxHjRjtLH6njVgN4H2Z7rzyg+Q/Vu6qAT0840pYq9vA2QEVnrnJL3D?=
 =?us-ascii?Q?Dd2sXt0gRNe2CNJskeYSEYQThm8W8iBTxptiy1M6vBtAgY1pKF+f5g2r1TU+?=
 =?us-ascii?Q?2jX1NjPzCRQUeiw1xjLUxR1/AP1R2wJ7W6lolUONnTlFI0CVPOCM+19AjR1X?=
 =?us-ascii?Q?JwVtCzIY0zj6r3sJQt57GJRWl3uS2fAJfLCsAZ6gMx+8NrkyFLDLbt5hxE9J?=
 =?us-ascii?Q?A5nNfixJ6/mPdF42qwI/zN0f4/IslDwADQMFrBoqozAujxWLoXYGKaW+pVV0?=
 =?us-ascii?Q?cL7aV6M14FQ2ePsD2+F7c6TnDZQKb+/aYRBQWtvfKpetTAQ/taHEM/erxHrA?=
 =?us-ascii?Q?67I1WwHDyyPgpt31CghSeoKKyVq/Vaql8NtUL8M0s3Z+LSBXDRHtNW0gGsGB?=
 =?us-ascii?Q?cteQjbSOwtRIASHFyasQd/9PU3KsOe8E8qDLIscq6Vm7R1DGA1X+uMndConF?=
 =?us-ascii?Q?AUi90zsxZbhli+eeG7L8uZWFNOu2YlgEXz8Bk2GBMhrd6LT/zTCbXhi6KYbV?=
 =?us-ascii?Q?VcB5fvWxRTgn7rC+j2rApeQ0dxmkWyMhQaqTtiUCTYXkSaVBmTDtStagE/Zt?=
 =?us-ascii?Q?XGpbORJSwfw6XF0oYWPINOhdbp6v5ksAzZwwhsWuFkLwDheA22qjVFM3bwmo?=
 =?us-ascii?Q?7x//QhB1KI+76zl+PhIizROsMHpglX/cXhIwBNLhO1pQ1ZBUfcwQWAOCh2xY?=
 =?us-ascii?Q?FWkj2V/SM95jUSD+ZxvCrCRItjbLSIhC2pqAERP2wOXWOEaML940qRoAtpjr?=
 =?us-ascii?Q?MKPjKj+7gKYr/Bh8w3sD4zEaCv+bsJLfH71yMc0j6fgqN+Bz9qYufl2LYfFH?=
 =?us-ascii?Q?I5mtwaV8B6NwK6rQSjZuOQOhKod/ER3HHIbpRjFvrgABlq0gEPdenZqhg2yI?=
 =?us-ascii?Q?bDBk7dHDNaH9wgCuZKucDSBjy/CSKMuBAY5pIyXMnUv2ov0cKWp9EKa76Kic?=
 =?us-ascii?Q?db0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p59qmAwuGBklW3GbHj88f9mtwPKaC2D2HIy2LxHB/DgC1t+38MdiBd1MdyoK?=
 =?us-ascii?Q?MWyj8fHD6/bMJQuTCHfGBPuB2bIvyTpsZ/7M/cbKZQpy5qoOm0bXufA+U2ZQ?=
 =?us-ascii?Q?3t5/3bueziPRejz+um4l7hyFBXstIcL6q22AqJGMpRCh6w/o4SokwX/PbBZ+?=
 =?us-ascii?Q?8AjlaoYmQZTbMSpYEHqNnM6kXbK0Xc7+cgPEEwLCdku6xv61dBFuYXUp9VPe?=
 =?us-ascii?Q?0YDZiGR1ntTHtugjqCN/2NXS3oVYbibZdPKdNZXq/nNpJbCmtbdh7YOjBrN9?=
 =?us-ascii?Q?J70CwKCfmHEnWs+68jHoqCZoV5ZLV9HYA+JJlKSqIsWuJ7d3iDY4KX/nIzsI?=
 =?us-ascii?Q?8X9XthIcJvkwVKVaAWzjJ12eg/EWeXr46VwoVHqHm4ktVdDg9ll/AmqSuNbT?=
 =?us-ascii?Q?eFPcvr+PB6pQGy9iqY3LK0wtaPhebEIm7r8GqDOFI86pn/LcbEOxrBb553t2?=
 =?us-ascii?Q?9CLlxZEDdnXxXQpN8fbGAbMjvdz2dBGZ/7u887eC4Hf848fjvga/uhgutaRW?=
 =?us-ascii?Q?DMH095rBvRfHjLRhOUaNHlAQLiGmby9nhTL68zVZ6aOAKXd6h+TDnht+Ur1S?=
 =?us-ascii?Q?w50tn8a91f4SA50gia/zEbg/BkMSMaguknCTgkC3D6qcntcnGzyO9HTz9R0q?=
 =?us-ascii?Q?sTLkRVrZJPakH1VVCo6U20Is8zTuIQwex89hHJ5WqA+fSvyRdWQ2P1zdk+aW?=
 =?us-ascii?Q?AozvcLb/cz4tb+oW4FVGdfUTNosD88JSqaQo9UyBWsK6sUVy5sa6KOOWhM4X?=
 =?us-ascii?Q?naioPTVJZf4bOIL9TObVwbELrBK6Y8ool9u1P0fniO4ELxlaBn1cUyS/xhsL?=
 =?us-ascii?Q?B+anI9Bxe56iSIrhHuDHwPp8MoMw+s0xQJ0MrrvCGvtVgOiHcBufgULttSEp?=
 =?us-ascii?Q?TMo3t2XgMJI+F7t3LaYwi2mkxlBf26mLBbqUJdsMpH4//8y+x2wSDSLS83QZ?=
 =?us-ascii?Q?7yG0abZ7+0gyfxkvq6qM1+Rgj1ZAhRjxxvtOWRksaEzU9CZQOr25VnnlrZwg?=
 =?us-ascii?Q?C95XTZX+WrTJ4cQh/k2GnmQ2BNfdtQX+gZICNJUylQDAr8cmKnb2lHddROI1?=
 =?us-ascii?Q?y53KQP3YkQZga0khYcP1dOIyGGBducsOyV0HKJWxKdQJiD07J4YRw4iRcSBn?=
 =?us-ascii?Q?ajXiQ9IZ68mzy5GfuyPUppmJYm4h61xq7/AOwAWU3cVvA5pCyxKLKhZMeNyi?=
 =?us-ascii?Q?of2fXmC6mi+2nvy74e4Ug1QeDTPd4nJ8LY+DPyinQoh6mG63wgYgX5i+7vVG?=
 =?us-ascii?Q?FzkUjtKlCe/iw/ON6l22ncPGPh3LrFBNvZaYjkFTb79hUJJAGRogYhAGW24m?=
 =?us-ascii?Q?pOOJJKIuqr5KV64XKR+OuxRs6T5+NVWkwED1WFbyyK6Bs4mJKKh45waLc0TS?=
 =?us-ascii?Q?Eq8o7wVP06VjaDE7iAH1oHiVf6F4EIzwq6SGcVNO2ShhRDNZO8YVfnSzbeoC?=
 =?us-ascii?Q?G80jjFIG78rc16goHIEjl/zzWveY3ApemJVo3CEfbHKxoD7yVgaP58ZmJBwT?=
 =?us-ascii?Q?VFTWRwtWHASQzJOCb1Gbrd8jSqS9FUr2KwMWu+zzk3a4ZtDXYADCQc/GzJb3?=
 =?us-ascii?Q?Dl/daSlNDf4qM4cfeCmcQyhD6Z3fJkkwXwjt6asW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a509be-0dcb-4b56-0980-08dc7ebad7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 02:06:52.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ERdz5AtZsoHgY8IS6QlmEVHTUeJspYq2eFlOSyQmG8k6av/Po9aRFA8jJh9uvi6EWh0RzJY1MipGxZNziB1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Sent: Monday, May 27, 2024 11:36 PM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ang,
> Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature
> v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> Stripping
>=20
>=20
>=20
> > -----Original Message-----
> > From: Ng, Boon Khai <boon.khai.ng@intel.com>
> > Sent: Monday, May 27, 2024 6:58 PM
> > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>;
> > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > linux- arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Ang, Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> > <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > <ilpo.jarvinen@linux.intel.com>
> > Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature
> > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > Stripping
> >
> ..........
>=20
> > > > 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > > > Stripping
> > > >
> > >
> > > New features should be submitted against 'net-next' instead of 'net'.
> >
> > Hi Sunil, I was cloning the repo from net-next, but how to choose the
> > destination as 'net-next'?
>=20
> While creating patch you can add appropriate prefix .. like below git for=
mat-
> patch --subject-prefix=3D"net-next PATCH"
> git format-patch --subject-prefix=3D"net PATCH"
>=20

Okay will update that in the next version.

> >
> > > Also 'net-next' is currently closed.
> >
> > I see, may I know when the next opening period is? Thanks
>=20
> Please track
> https://patchwork.hopto.org/net-next.html

Checked the link it is just a photo saying "come in we're open" is that mea=
n the net-next is currently open now?





