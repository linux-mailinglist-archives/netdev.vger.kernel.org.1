Return-Path: <netdev+bounces-133288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A74995767
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12606B264CE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B83212EE2;
	Tue,  8 Oct 2024 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJkUiiX5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5431F472B;
	Tue,  8 Oct 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414415; cv=fail; b=kF3cwJqWQdIKZYsLlYklc0N4tSYryeFMrWSZXAnaQ0j+1Yp+MSn0rCcu7ElbOAdE/9v7C2DoJfC1nd48FZntLwPr2EwIjY4WozrhrUCjJinqQrbXeFPJdjI5iPe1CMMM5tlGVdki0Aom4gfnTHi84ncj3BXMFfqY3l0wEo3pKSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414415; c=relaxed/simple;
	bh=9K7/uPjFrhGD2RGX3FFyemzSp5eHq3FIkoiMSUrmWAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qoWj05LoajgVYfvlo3FtcfvqEU3MS8onpg4+hirkn1bbTUe/IaONyOGFlShofqB/N3+f/L79S+7Wt6qXG2pLbBppEFZHS7ICZQaOuUbZ1w3Jn3C912dnUToByz8fhrbLvLUAjcRriBSxOMezE++Sz6bKSYxe3awwz8t3yhIq+Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJkUiiX5; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414414; x=1759950414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9K7/uPjFrhGD2RGX3FFyemzSp5eHq3FIkoiMSUrmWAA=;
  b=fJkUiiX5HSv8ovvDULaBFw4unkAwb5cPR74ZjPBMTNqsGW61eDFzEFO/
   HPM5a7LQc/B85QXX/1Bfxlt8apNXClaNDpJx+r4Ip4poyH/7F93qh0/n3
   +J4TXrBjg9xeGPhzn7ATT8WDz+rvtdpidGVI50RKv29ySBzJtGSk2pFff
   Er6x+cJ7Bq6LTe6inaBTx9OGL7QhZyF3gK9lJLcwp05H7ytBLkSPZWHIz
   4K1BqPiy5AIXJQY3380UiVCbdDrXE14wv8ZRM3GV7zvtkroyO8DDS1GV4
   lun3aWlDmgsXNbNlzkzz5v8t1cZa44nQ4Na3GHjDW6ZapAhc/d66rszQb
   w==;
X-CSE-ConnectionGUID: guX24TrfR/m+6jPxehGH7A==
X-CSE-MsgGUID: mV5buecdT7KgzNIOOjauUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45115870"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="45115870"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:06:54 -0700
X-CSE-ConnectionGUID: 0u/dE2+6ScKjqvfWE1Gb2A==
X-CSE-MsgGUID: k/nrj3naTZ+SsHK0qLYzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75642028"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 12:06:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:06:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:06:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 12:06:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 12:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpkLwRq4bhHACxVmUxDNdS2biXqAWIMeXnlk/L6REH49Aaz7IJp4aF/VeheUrzBK9uVwyP/cM2Kj94TWtKYKi+Jj/2rxJtpsz12jaAn5ujnRds/sRsyMcEpPFE6a5wC/GGUg3DvL6UpLC4lyxfILl7rq0gdOFRMtTbyg4NJAy39WCAUX5Qm3kqV1erhXKCAsndKrKB3mDvNchYJA+240FnK/P9xljcN7hi7Mx0HpktgrVqqupLkS80IfKg1EwnGoCgkXCknHUdMT9XcFwomimwHAEy7ogo3nj4ccEsH2ZdfIaN4jt5lIzz51ny/sJbY8sowKVCXWHbbzaCtVMT12dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K7/uPjFrhGD2RGX3FFyemzSp5eHq3FIkoiMSUrmWAA=;
 b=eEnU58NXwOTAk05Qf2Ba8IoY/uCUj5aPZuxBDxjMlu6TLTPwxnCRxofebQr1meaYJoaPPRV6aC3vmHvqGVmZH8nzcPR/jPyb5o0nCgUoUF8OaPmeeozTvAapV0lst4uzqxairhP014G3qPz+nUDOdaaeqBQYoPsOFrPRO37y7nqXPLjm3XccZg9wNCGduuDe79WOS3ZngTkpw/x1N1oPJNNn5BEBXvNrZJ0Ej3WB6O+qMhxAyFVevVEF01vkbpWsM6Gd6B6C9eoxihADaI+E+Ad3jmj22BOS5Enj9lSjBKpDZZi8xHnOSwQHCTxlH7X76kaakLNc9JKxO4o81JnXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Tue, 8 Oct 2024 19:06:49 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 19:06:48 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [RFC PATCH 0/2] ptp: add control over HW timestamp latch point
Thread-Topic: [RFC PATCH 0/2] ptp: add control over HW timestamp latch point
Thread-Index: AQHbFd0t7o14mOGSd0+ZtjITVvOjFbJ7eiAAgAHDhFA=
Date: Tue, 8 Oct 2024 19:06:48 +0000
Message-ID: <DM6PR11MB4657CA39A7CDDA926664E8289B7E2@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
 <ZwQHHmLeBUBpH71p@hoboy.vegasvil.org>
In-Reply-To: <ZwQHHmLeBUBpH71p@hoboy.vegasvil.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ0PR11MB4784:EE_
x-ms-office365-filtering-correlation-id: 60722f2e-f4cb-43e7-7642-08dce7cc5c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/GJ5aCCM1T9bWhegstVnJZG2oSxgBW3om/HLBxh3LlwqFiPSMLn4RdEUYxcq?=
 =?us-ascii?Q?b2p9BXfZePezevfwJn+k8oAH5NkvEQb6Vfc6X4guZ/eVVS5mKk+bulg6g2/k?=
 =?us-ascii?Q?oP2XMcFfNE0GMce7G6YORuu33gE9PBgraAs58pw6FC9z9skKSx0IssWoAUX0?=
 =?us-ascii?Q?5a9A9uObuS7A+hd/XdVjtT0BHs8ukmoQuv9c5TvVPX8sC9EKs4CETQ/ukYBV?=
 =?us-ascii?Q?4jd/cBVKVP6ir0XWJd5Yhehc3Csj8e8OTldkSpHi4NoDbjN61eEFuSB0iz4/?=
 =?us-ascii?Q?9OtTUZWj+ey5/GbkKIs/C2O3KmfO8nIG/SOxxVNmscm4ud7zUkPyPwT9z9TC?=
 =?us-ascii?Q?c9cFIXDjnKzBaUqI3jkbjez03SKpYnUVhaLVmwtxYWzZU00s7jFOeOIVLh0c?=
 =?us-ascii?Q?bDzDKrinoy81sD2CgDcFgqg7+9xwP8heGkOVC1RQ5haAblwvXpd9I/hMWusU?=
 =?us-ascii?Q?z6+dYxOjcLLxoOnPf6XuGB1cq+nxnVjoF/KzMLCm3DpqmnfgbmxsQjh9yJRs?=
 =?us-ascii?Q?Cr+EYvlIuulLjj2fCwkawp+HIEe7VD16pI2z74tCxjbdS78u867lqEG1tikK?=
 =?us-ascii?Q?svhsN0GdGkSf6NPoCtbh11I1/H8I8Mu7p/xUabs0TP0d6klpDgovxLhyM+0Z?=
 =?us-ascii?Q?68z8W1FlaPyDDfQhcbc/RAFJh//sFMVp0r0MU8HqEG8jUbepsKnwNmNMfE81?=
 =?us-ascii?Q?Cvj4/gGpP6IbkwLBsojThcweiTwU8UHk6s41/JqiCQc38OtX6ew2IdvkGk74?=
 =?us-ascii?Q?HbzacDUOOvRmH/o3yElxLHRgtn6sSWVb0cRMRH8yw4AtLt6qoisvq8K5mg5Y?=
 =?us-ascii?Q?D0n6GLGxbgQoo3KhSYeuU14Ktamn/SefIW5NQBb3NFirmgmPllpiWZwhAgY9?=
 =?us-ascii?Q?wHnsfHluvatr0Kjqys5uucgZ9JUF+rM64YKQ7AstsjBaypmupZNc45v7Jzyx?=
 =?us-ascii?Q?pMq9laJr2LVyQ71gLm3qZW4D9/LYQipND/wuPfWxrPZuNSXKmWu+o4lDL1Up?=
 =?us-ascii?Q?B8k2tl8uLaMQscKufgixCnLEGW0Yr8FGHr469e12YBT3PnPdlBiR21jkgXLf?=
 =?us-ascii?Q?Se3TyCX6Pj+av/w7b4WqgVakQXu3oDeYwlpMn/SJ+cKAwir8jtHvkuq/J8P+?=
 =?us-ascii?Q?l+I54wtw+kZzYv6Sn19BNmOvy1tRnpTtNUusxvwGEW1kfwxntpbrN2HCQRiF?=
 =?us-ascii?Q?dJywzD86zTKWPA+tEt2TN5vhAIpuIP+SkUawc03YVk42tW+3f2Ca/MscVX9Y?=
 =?us-ascii?Q?o+k69kphK4XL9MyOCuahfSqFFbveO8NxCz7oFmSSOamR3E1dasPVML5A5rcl?=
 =?us-ascii?Q?NGGQfYc4N9Py4QndiO2qhBDH4Xo4h3VFMvmlLgdi9zWJOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Th/rIGOrM2iGKkRHyR0mfBgiHZMp3XWzaxtgz7+mZBcA8FDs6mp4dNJ5qUFO?=
 =?us-ascii?Q?Q/YXa5b1E74TY2QIzE43SlJnxTD8oCz/fqVM/b9QVJdFh/wo+zMYRRaKrj/w?=
 =?us-ascii?Q?hlfFr3znMVUVJhBIqG/rIugaWwCTnfqURqr5lc6g3SCwvpWV9hKRwEH2siiC?=
 =?us-ascii?Q?euqAv398IHQebjxabw/vRbQEOhQ05EsCYPCHTVyHSKK8jqn4CrpQ4jDO0YGJ?=
 =?us-ascii?Q?jQ8f8PWblR9MWzmJthvmrVj3ASSbkcvay54YBMyLIjDFNNqRpNla2DnGLJ1C?=
 =?us-ascii?Q?Q/rc/eRTD6wnJhRVTgo2+GB72c7920ruklCIkJrTn0DiGy6bGl6f7GYDVr2c?=
 =?us-ascii?Q?ZLvfKsgsJujP3MI+XwOgfzoJgm7SyCGqaH2WcMNFCo7rIU/oFfa9gIkbRUSu?=
 =?us-ascii?Q?IXDM5Ifi20dFf/2mR6B5OR1ame2S2A4r6d0Rt2D1qlrrx/DGk4XyQ6Xr/A4P?=
 =?us-ascii?Q?MKSJZSP+GZpVN0m7AxX4EpIkDgH8VIi/yGFleVg0pOsxSBHMLGsyQMLpC1ug?=
 =?us-ascii?Q?ztSGdRIXZVFQJ6YnFbQ9RD1Qvzpcjqs+4yUshwejA/j2PAaxVd/cjqvXMrPJ?=
 =?us-ascii?Q?Uz2WBFehj4yCVlvOIm3NqdrNCZ10dbvSNVGW5hBUH6cIXmlVoIUzc2enYxqB?=
 =?us-ascii?Q?h309REOIiBolWW7PInxyxWEiXfifdApyhaa+Du79sQVU1xyVXtP/UOf8gCaB?=
 =?us-ascii?Q?vztXuG8KdUJI7ysf3RmwaRzvEv28xzfIAW1OwOFK2jlutQmTynOCsd2CFenN?=
 =?us-ascii?Q?lCbPJGoH88mw2Y9mq10OU5zXrkxsiUnm6nCVbCvqmMjIA90pupBQWKsbae9G?=
 =?us-ascii?Q?msfnkbNjEOUv5xpWb3tBUia0sS6PkNIFRJjuGQHSVPKh6lCMw1+ApqeYnFR6?=
 =?us-ascii?Q?2qiAg+JAMSWv/GlnE0HJo2egmwk6tN0e1UW8AhnTf98Aeux8m37YkhG0DiOv?=
 =?us-ascii?Q?s3cAe1/32SK40JB/2u3FAW7xOF/V1j2SwiwHZ+f7taFTURoYoqyZEg/YbDZK?=
 =?us-ascii?Q?Qq1VBEvzdXUtm8pi+oUVfc0DY++Me36c/udYrK9WL6ao+PQ0tPwvekYoLIjb?=
 =?us-ascii?Q?KypZGRKgn57iHwlqlMuIsyKJ92Q88+d0tFkWjsWT7lcj06zaZmWP7mcfkkI0?=
 =?us-ascii?Q?ZYlrcipFg66PhqP8u5nsabx+A23q8ttfv8fwEjmSZe78TqiBb8AFvwOGUuwI?=
 =?us-ascii?Q?Sr3n8rHioGgqyYmnbXO6NG866/imHbLr1WFCbZEsbICN1JmPqX/Gn4dz02YS?=
 =?us-ascii?Q?/4bp/vcC7vc0SWCYuVooJL8XTT982qdeiy5/Yc0KBcdOGdeexI66jb/OIAUJ?=
 =?us-ascii?Q?AUnKHE/fttECeztPtkg/MeXwAIrKlH/enP4VDiGFZGKbgaDVW5t4k0pRsBFC?=
 =?us-ascii?Q?bnArrdcWJVlDAxffj3O116UPWBnDoNz2Bf0DDBZ3T0vX7uENf9w/UCJkZpkc?=
 =?us-ascii?Q?b4wneJUmJahaVYf+kHd3x+D202Z6xuBbscT6bBOJeyPT/Hc7VztzBYAnO+d7?=
 =?us-ascii?Q?hbzg0LvNmmGSwP7G0efGdilBfapZ2Z0owkCGvTWSNQbB9sj4OH+x9y+z9BvX?=
 =?us-ascii?Q?pnTvK3uGAUpp3EixBzLqrk0Zlz0WY3nbj1ZKsYTsCN5Lq4SjgOS6+8gW2uGT?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60722f2e-f4cb-43e7-7642-08dce7cc5c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 19:06:48.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2WpGrl4rNH6Xg8eyfT73bWMQqEgaDjhPCNR7egyPZMfpr4hXIW97X+61IDYJR0Qn9Ca+BME5p8O88JTFC9l8QN42OkDGh9k6GO+b6MfHs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com

>From: Richard Cochran <richardcochran@gmail.com>
>Sent: Monday, October 7, 2024 6:07 PM
>
>On Thu, Oct 03, 2024 at 11:37:52PM +0200, Arkadiusz Kubalewski wrote:
>> HW support of PTP/timesync solutions in network PHY chips can be
>> achieved with two different approaches, the timestamp maybe latched
>> either in the beginning or after the Start of Frame Delimiter (SFD) [1].
>>
>> Allow ptp device drivers to provide user with control over the
>> timestamp latch point.
>
>This looks okay to me.
>
>Sorry for the late reply, but I'm travelling untill Oct 11 and may not
>response to messages right away.
>
>Thanks,
>Richard

Hi Richard,

Not a problem.
Great to hear that it looks good for you, I will prepare proper patches soo=
n.

Thank you!
Arkadiusz

